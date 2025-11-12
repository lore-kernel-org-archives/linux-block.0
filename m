Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661681C695;
	Wed, 12 Nov 2025 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975757; cv=none; b=gGTpZ0F+mWUZI2uaa6SVmz3pQL/ELIRaLapOz7C6OrYPg++hxjs6JJjqxQY3qGeqtPWOAJ1n9QAQLdVhOWkbXwZmcSzsIp4x3TD7ATqvEeTkFec2JhjAu8R6f8j3G8h5UuV6PGXlJu4582FY5xDWIRa0OR/pv3UPtLMqrJ5fgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975757; c=relaxed/simple;
	bh=JmkStz5Gh3rOJ+hhrwXD71Fdps8rm8yy5L0EEOeZmIE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b/JT3ZFud4M5WaZ/FcvBW+CfRUTIibPFe/TcezYhl6k8ddrBtbm6xIsTSVMxrFuxIRoxvfzCkQSRGxKdtaeHDV3I1iOteA2nZtT6FSjlj+KzjCzyFQ0pwkcnn/WTLTPZ4TOg+/WE04MWk4Kx31/EiD83Uo2+BInaoBZoWagey94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jV7B9ZTX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jV7B9ZTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AB3C113D0;
	Wed, 12 Nov 2025 19:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762975755;
	bh=JmkStz5Gh3rOJ+hhrwXD71Fdps8rm8yy5L0EEOeZmIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jV7B9ZTXfZmPp8me+Wuw+QBmvt0yn5k6449d2MFzoWtNYgQAgvWFCnN63D4FxHdEK
	 xr0CS75jOOBvnUb5WaBGXYHGrThYQ9xzUsZac0uDJk6lnos4tcUXBcN/rfRiu/obRh
	 z+TazN1tQlcqy0WK84BZYYHNZMhaZxyiIyF77ZxI=
Date: Wed, 12 Nov 2025 11:29:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Caleb Sander
 Mateos <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>,
 Stefani Seibold <stefani@seibold.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 01/27] kfifo: add kfifo_alloc_node() helper for NUMA
 awareness
Message-Id: <20251112112914.459baa16c4e9117d67f53011@linux-foundation.org>
In-Reply-To: <20251112093808.2134129-2-ming.lei@redhat.com>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
	<20251112093808.2134129-2-ming.lei@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 17:37:39 +0800 Ming Lei <ming.lei@redhat.com> wrote:

> Add __kfifo_alloc_node() by refactoring and reusing __kfifo_alloc(),
> and define kfifo_alloc_node() macro to support NUMA-aware memory
> allocation.
> 
> The new __kfifo_alloc_node() function accepts a NUMA node parameter
> and uses kmalloc_array_node() instead of kmalloc_array() for
> node-specific allocation. The existing __kfifo_alloc() now calls
> __kfifo_alloc_node() with NUMA_NO_NODE to maintain backward
> compatibility.
> 
> This enables users to allocate kfifo buffers on specific NUMA nodes,
> which is important for performance in NUMA systems where the kfifo
> will be primarily accessed by threads running on specific nodes.

I was about to ask "please don't add infrastructure without users", but
I see a "01/27" there.  I wander over to lkml but I can't find 02-27
there either.  Maybe something went wrong.

I prefer to be cc'ed on the entire series, please.

> --- a/include/linux/kfifo.h
> +++ b/include/linux/kfifo.h
> @@ -369,6 +369,30 @@ __kfifo_int_must_check_helper( \
>  }) \
>  )
>  
> +/**
> + * kfifo_alloc_node - dynamically allocates a new fifo buffer on a NUMA node
> + * @fifo: pointer to the fifo
> + * @size: the number of elements in the fifo, this must be a power of 2
> + * @gfp_mask: get_free_pages mask, passed to kmalloc()
> + * @node: NUMA node to allocate memory on
> + *
> + * This macro dynamically allocates a new fifo buffer with NUMA node awareness.
> + *
> + * The number of elements will be rounded-up to a power of 2.
> + * The fifo will be release with kfifo_free().
> + * Return 0 if no error, otherwise an error code.
> + */
> +#define kfifo_alloc_node(fifo, size, gfp_mask, node) \
> +__kfifo_int_must_check_helper( \
> +({ \
> +	typeof((fifo) + 1) __tmp = (fifo); \
> +	struct __kfifo *__kfifo = &__tmp->kfifo; \
> +	__is_kfifo_ptr(__tmp) ? \
> +	__kfifo_alloc_node(__kfifo, size, sizeof(*__tmp->type), gfp_mask, node) : \
> +	-EINVAL; \
> +}) \
> +)

Well this is an eyesore.  Do we really need it?  It seems to be here so
we can check for a programming bug?  Well, don't add programming bugs!

I'm actually not enjoying the existence of __is_kfifo_ptr() at all. 
What  is it all doing?  It's a FIFO for heck's sake, why is this so hard.

> @@ -902,6 +926,9 @@ __kfifo_uint_must_check_helper( \
>  extern int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
>  	size_t esize, gfp_t gfp_mask);
>  
> +extern int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
> +	size_t esize, gfp_t gfp_mask, int node);
> +

Nit: please align things like this:

extern int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
			      size_t esize, gfp_t gfp_mask, int node);

(several places)

