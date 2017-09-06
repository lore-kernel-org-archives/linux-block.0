Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] lightnvm: pblk: check for failed mempool alloc.
From: Jens Axboe <axboe@kernel.dk>
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: Johannes Thumshirn <jthumshirn@suse.de>, =?UTF-8?Q?Matias_Bj=c3=b8rling?=
 <mb@lightnvm.io>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias@cnexlabs.com>
References: <1504710066-4699-1-git-send-email-javier@cnexlabs.com>
 <1504710066-4699-2-git-send-email-javier@cnexlabs.com>
 <20170906150811.sa3vrrkbpv5rffeb@linux-x5ow.site>
 <d8295f1b-5021-e20b-ffcf-4fbbbe7c70b4@kernel.dk>
 <B52A428A-99AA-4CE3-8C30-3C2BAA30678D@lightnvm.io>
 <086e6df7-65d8-57b7-6605-d585985a3ddf@kernel.dk>
Message-ID: <d644f8f8-cb67-38a5-53d9-7b32f7e42902@kernel.dk>
Date: Wed, 6 Sep 2017 09:20:32 -0600
MIME-Version: 1.0
In-Reply-To: <086e6df7-65d8-57b7-6605-d585985a3ddf@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/06/2017 09:13 AM, Jens Axboe wrote:
> On 09/06/2017 09:12 AM, Javier González wrote:
>>> On 6 Sep 2017, at 17.09, Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 09/06/2017 09:08 AM, Johannes Thumshirn wrote:
>>>> On Wed, Sep 06, 2017 at 05:01:01PM +0200, Javier González wrote:
>>>>> Check for failed mempool allocations and act accordingly.
>>>>
>>>> Are you sure it is needed? Quoting from mempool_alloc()s Documentation:
>>>> "[...] Note that due to preallocation, this function *never* fails when called
>>>> from process contexts. (it might fail if called from an IRQ context.) [...]"
>>>
>>> It's not needed, mempool() will never fail if __GFP_WAIT is set in the
>>> mask. The use case here is GFP_KERNEL, which does include __GFP_WAIT.
>>
>> Thanks for the clarification. Do you just drop the patch, or do you want
>> me to re-send the series?
> 
> No need to resend. I'll pick up the others in a day or two, once people
> have had some time to go over them.

I took a quick look at your mempool usage, and I'm not sure it's
correct.  For a mempool to work, you have to ensure that you provide a
forward progress guarantee. With that guarantee, you know that if you do
end up sleeping on allocation, you already have items inflight that will
be freed when that operation completes. In other words, all allocations
must have a defined and finite life time, as any allocation can
potentially sleep/block for that life time. You can't allocate something
and hold on to it forever, then you are violating the terms of agreement
that makes a mempool work.

The first one that caught my eye is pblk->page_pool. You have this loop:

for (i = 0; i < nr_pages; i++) {                                        
        page = mempool_alloc(pblk->page_pool, flags);                   
        if (!page)                                                      
                goto err;                                               
                                                                        
        ret = bio_add_pc_page(q, bio, page, PBLK_EXPOSED_PAGE_SIZE, 0); 
        if (ret != PBLK_EXPOSED_PAGE_SIZE) {                            
                pr_err("pblk: could not add page to bio\n");            
                mempool_free(page, pblk->page_pool);                    
                goto err;                                               
        }                                                               
}          

which looks suspect. This mempool is created with a reserve pool of
PAGE_POOL_SIZE (16) members. Do we know if the bio has 16 pages or less?
If not, then this is broken and can deadlock forever.

You have a lot of mempool usage in the code, would probably not hurt to
audit all of them.

-- 
Jens Axboe
