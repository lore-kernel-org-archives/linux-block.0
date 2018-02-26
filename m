Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 26 Feb 2018 14:14:44 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH RFC] sbitmap: Use lock/unlock atomic bitops
Message-ID: <20180226221444.GD9157@vader.DHCP.thefacebook.com>
References: <20180218130506.GW695913@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180218130506.GW695913@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Feb 18, 2018 at 05:05:06AM -0800, Tejun Heo wrote:
> sbitmap is used to allocate tags.  The free and alloc paths use a
> memory ordering scheme similar to the one used by waitqueue, where the
> waiter and waker synchronize around set_current_state().
> 
> This doesn't seem sufficient for sbitmap given that a tag may get
> released and re-acquired without the allocator blocking at all.  Once
> the bit for the tag is cleared, the tag may be reused immediately and
> due to the lack of memory ordering around bit clearing, its memory
> accesses may race against the ones from before the clearing.
> 
> Given that the bits are the primary synchronization mechanism, they
> should be ordered memory-wise.  This patch replaces waitqueue-style
> memory barriers with clear_bit_unlock() in sbitmap_clear_bit() and
> test_and_set_bit_lock() in __sbitmap_get_word().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Hello,
> 
> Spotted this while verifying the timeout fix.  I didn't check the
> whole code, so although unlikely it's possible that the removed mb's
> are needed from elsewhere, so the RFC.  Only boot tested.
> 
> Thanks.
> 
>  include/linux/sbitmap.h |    3 ++-
>  lib/sbitmap.c           |   17 ++++++-----------
>  2 files changed, 8 insertions(+), 12 deletions(-)
> 
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -297,7 +297,8 @@ static inline void sbitmap_set_bit(struc
>  
>  static inline void sbitmap_clear_bit(struct sbitmap *sb, unsigned int bitnr)
>  {
> -	clear_bit(SB_NR_TO_BIT(sb, bitnr), __sbitmap_word(sb, bitnr));
> +	/* paired with test_and_set_bit_lock() in __sbitmap_get_word() */
> +	clear_bit_unlock(SB_NR_TO_BIT(sb, bitnr), __sbitmap_word(sb, bitnr));
>  }

I agree that we want this, but for a different reason than you described
in your changelog: a sbitmap can be used without a sbitmap_queue, so it
should provide the proper memory ordering. For the sbitmap_queue case,
the compiler/processor could also reorder something after the
clear_bit() and before the smp_mb__after_atomic(), which is also wrong.

>  static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -100,7 +100,8 @@ static int __sbitmap_get_word(unsigned l
>  			return -1;
>  		}
>  
> -		if (!test_and_set_bit(nr, word))
> +		/* paired with clear_bit_unlock() in sbitmap_clear_bit() */
> +		if (!test_and_set_bit_lock(nr, word))
>  			break;

test_and_set_bit_lock() is an ACQUIRE operation which has weaker
guarantees than the full barrier implied by test_and_set_bit(), but
ACQUIRE is enough here, so I agree with this part, too.

>  		hint = nr + 1;
> @@ -432,14 +433,9 @@ static void sbq_wake_up(struct sbitmap_q
>  	int wait_cnt;
>  
>  	/*
> -	 * Pairs with the memory barrier in set_current_state() to ensure the
> -	 * proper ordering of clear_bit()/waitqueue_active() in the waker and
> -	 * test_and_set_bit()/prepare_to_wait()/finish_wait() in the waiter. See
> -	 * the comment on waitqueue_active(). This is __after_atomic because we
> -	 * just did clear_bit() in the caller.
> +	 * Memory ordering is handled by sbitmap_clear_bit() and
> +	 * __sbitmap_get_word().
>  	 */
> -	smp_mb__after_atomic();
> -

This, I'm not convinced that we can get rid of. clear_bit_unlock() is a
RELEASE operation, not a full barrier, so the waitqueue_active() read
can be reordered before the clear_bit() store. Imagine we get this
interleaving:

waitqueue_active() -> false |
                            | /* bitmap is full, allocation fails */
			    | prepare_to_wait()
clear_bit_unlock()          |

We should've woken up the waiter, but we didn't.

>  	ws = sbq_wake_ptr(sbq);
>  	if (!ws)
>  		return;
> @@ -481,10 +477,9 @@ void sbitmap_queue_wake_all(struct sbitm
>  	int i, wake_index;
>  
>  	/*
> -	 * Pairs with the memory barrier in set_current_state() like in
> -	 * sbq_wake_up().
> +	 * Memory ordering is handled by sbitmap_clear_bit() and
> +	 * __sbitmap_get_word().
>  	 */
> -	smp_mb();

Same idea here.

>  	wake_index = atomic_read(&sbq->wake_index);
>  	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
>  		struct sbq_wait_state *ws = &sbq->ws[wake_index];

So I think we want a patch for the test_and_set_bit_lock() and
clear_bit_unlock(), but the rest should stay as-is.
