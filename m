Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509ADC433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 01:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiFBBxf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 21:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiFBBxf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 21:53:35 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255B025F434
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 18:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654134811; x=1685670811;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ubD3ntNWmcpNqwymZFWCFjx8IkEeXWsf6dOGoduVlaU=;
  b=ffgKB17PGbRsL8cLKPVOBodOZUtl+EN7DoixfkWI1tzFk+sv90iB8JNU
   Gp8eggzoY8j1YKw/zwplTmXVCzVQEN0k8l1UL88He+hc+9XgxJRFfv86G
   Bp2n+0LoNw4oq/Y7N4Cwk2+ysZ3nzqjxtB+dRD9Nkpin2LpJRz63OGEL1
   haEbJBXD1HydU/Y5BN+Aj0JWwihfZdOReI6mSbXBhSgNPo3272QEEafvp
   rOCEs8ZTlMytiui8CptbTGRZwmuEzaq0RRxJnsd24EVaFJcysxoK3aLz0
   o3fuFkvZrZR7WOcyjHkuSIFTkecp6LjEAIop0VSnm6MlubbYwSgkAFIyr
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,270,1647273600"; 
   d="scan'208";a="206911461"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2022 09:53:31 +0800
IronPort-SDR: M+vVtdUGuvm9tgYgFqN9383Vb3dzsm+X4cAFEwI/FWy9KBt9UF/yFqQB8Ol6S9+/8jcIjl1Hrs
 E7+PyD54pcSsCZfW2blRsj4dxkdsxe6+KtYTO8bt0Imh5WjTtmMkSNnffMfoW4SvDdT+GS7boL
 XF32atX+yNMD46DO6UfZQ8UCaw4iYlRpOo5AipvWddxB5sOxvCDK6tSXLLpmenIuv51b7+92mN
 Zn8UPO7VZh2amHDAsg1r4664xby5VumEcSKuJtGF8OeKwpLhyqj41jdjhRC40Qj37EKBoY9bSn
 JtQui8ecKc1jb1/BBUJQUHyD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 18:17:13 -0700
IronPort-SDR: 7XJDhyKUCeDJehI+iMO2QRYlN/VAHZDp/O0ANYDIpfOjr7p5YvCA12EUbTL9LTd+C9LImZhLaT
 Ek+9gsML3yMSlw+H8dHuhktGIO5UD+JNLchPycWgQwKpkPH2BDdUFb7LmVTxCVy+/EaPHN96YJ
 TnNMq18H2kY36nuCWqh5+Riid4KekWXb8fBDTk1vDvQIBpt75eyIqW/AKf1ocDkTOIxMcEWig8
 ZJjL0DB9oahjRFuCe8qx4VO+S9qKKB4koxfc7mwd48k3UqdCGSFQYjth9ywG4fsv7ae2v4vNgN
 Iss=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 18:53:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LD8Dr3Gsgz1Rwrw
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 18:53:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654134811; x=1656726812; bh=ubD3ntNWmcpNqwymZFWCFjx8IkEeXWsf6dO
        GoduVlaU=; b=QA89cWzQFZFkPmS9rLQOKILtu/sn/dlO8VWvuDG6RmcKZufnX+t
        +qSqKglS9y5/6xjchHQ2BdfHatyv3FE4nb7UzA/LLcSRol73q0qHnez8KGo+FoR+
        ti3srcAGDIV0NlomCGBb2d9if7OpSl/kuqBtpZT3SShDtx3nFx1iis/4oWWazRB9
        FKlr0BZ3tvvGd0FvUYhSmEsGQn1DtiOyUAudiDLgVzQeD0lVeedg1KOBEnhS8MV3
        gk/l/ujNbNDqJu2neJu0l8hXwFe/MRYnrsHQo4vRSYkGq9XkLGPp1a1AAj3bAbTx
        1pKy3/d4hR7ZolLvPG1jQH2a1Ftya3qi5Lw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4zf-jHjb8937 for <linux-block@vger.kernel.org>;
        Wed,  1 Jun 2022 18:53:31 -0700 (PDT)
Received: from [10.89.84.115] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.115])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LD8Dq0Wh3z1Rvlc;
        Wed,  1 Jun 2022 18:53:30 -0700 (PDT)
Message-ID: <c79b25f4-88dc-c432-e69b-ef5abdf37720@opensource.wdc.com>
Date:   Thu, 2 Jun 2022 10:53:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] block: fix default IO priority handling again
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <20220601132347.13543-1-jack@suse.cz>
 <20220601145110.18162-3-jack@suse.cz>
 <cadb5688-cfba-3311-52d4-533f6afab96e@opensource.wdc.com>
 <20220601160443.v5cu4oxijjasxhj7@quack3.lan>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220601160443.v5cu4oxijjasxhj7@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/06/02 1:04, Jan Kara wrote:
> On Thu 02-06-22 00:08:28, Damien Le Moal wrote:
>> On 2022/06/01 23:51, Jan Kara wrote:
>>> Commit e70344c05995 ("block: fix default IO priority handling")
>>> introduced an inconsistency in get_current_ioprio() that tasks without
>>> IO context return IOPRIO_DEFAULT priority while tasks with freshly
>>> allocated IO context will return 0 (IOPRIO_CLASS_NONE/0) IO priority.
>>> Tasks without IO context used to be rare before 5a9d041ba2f6 ("block:
>>> move io_context creation into where it's needed") but after this commit
>>> they became common because now only BFQ IO scheduler setups task's IO
>>> context. Similar inconsistency is there for get_task_ioprio() so this
>>> inconsistency is now exposed to userspace and userspace will see
>>> different IO priority for tasks operating on devices with BFQ compared
>>> to devices without BFQ. Furthemore the changes done by commit
>>> e70344c05995 change the behavior when no IO priority is set for BFQ IO
>>> scheduler which is also documented in ioprio_set(2) manpage - namely
>>> that tasks without set IO priority will use IO priority based on their
>>> nice value.
>>>
>>> So make sure we default to IOPRIO_CLASS_NONE as used to be the case
>>> before commit e70344c05995. Also cleanup alloc_io_context() to
>>> explicitely set this IO priority for the allocated IO context.
>>>
>>> Fixes: e70344c05995 ("block: fix default IO priority handling")
>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>> ---
>>>  block/blk-ioc.c        | 2 ++
>>>  include/linux/ioprio.h | 2 +-
>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
>>> index df9cfe4ca532..63fc02042408 100644
>>> --- a/block/blk-ioc.c
>>> +++ b/block/blk-ioc.c
>>> @@ -247,6 +247,8 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
>>>  	INIT_HLIST_HEAD(&ioc->icq_list);
>>>  	INIT_WORK(&ioc->release_work, ioc_release_fn);
>>>  #endif
>>> +	ioc->ioprio = IOPRIO_DEFAULT;
>>> +
>>>  	return ioc;
>>>  }
>>>  
>>> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
>>> index 774bb90ad668..d9dc78a15301 100644
>>> --- a/include/linux/ioprio.h
>>> +++ b/include/linux/ioprio.h
>>> @@ -11,7 +11,7 @@
>>>  /*
>>>   * Default IO priority.
>>>   */
>>> -#define IOPRIO_DEFAULT	IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM)
>>> +#define IOPRIO_DEFAULT	IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0)
>>
>> "man ioprio_set" says:
>>
>> IOPRIO_CLASS_BE (2)
>> This is the best-effort scheduling class, which is the default for any process
>> that hasn't set  a  specific I/O  priority.
>>
>> Which is why patch e70344c05995 introduced IOPRIO_DEFAULT definition using the
>> BE class, to have the kernel in sync with the manual.
> 
> Yes, but it also has:
> 
>        If no I/O scheduler has been set for a thread, then by default the  I/O
>        priority  will  follow  the  CPU nice value (setpriority(2)).  In Linux
>        kernels before version 2.6.24, once an I/O priority had been set  using
>        ioprio_set(),  there was no way to reset the I/O scheduling behavior to
>        the default.  Since Linux 2.6.24, specifying ioprio as 0 can be used to
>        reset to the default I/O scheduling behavior.
> 
> So apparently even the manpage itself is inconsistent ;) (and I will
> neglect the mistake that the text says "no I/O scheduler" instead of "no
> I/O priority"). And there is actually code in BFQ (and there used to be
> code in CFQ) that does:

Arg, indeed, it is a mess. We need to fix this manpage too.


>         switch (ioprio_class) {
> 	...
>         case IOPRIO_CLASS_NONE:
>                 /*
>                  * No prio set, inherit CPU scheduling settings.
>                  */
>                 bfqq->new_ioprio = task_nice_ioprio(tsk);
>                 bfqq->new_ioprio_class = task_nice_ioclass(tsk);
>                 break;
> 	
> So IOPRIO_CLASS_NONE indeed has a meaning and it used to be the default
> one until Christoph's 5a9d041ba2f6 in most cases. Your change e70344c05995
> happening before that actually didn't change much practically because IO
> contexts were initialized with 0 priority anyway and that was what
> get_current_ioprio() was returning.

5a9d041ba2f6 was from Jens, but agreed, io priority initialization never has
been correct.

> 
>> The different ioprio leading to no BIO merging is definitely a problem
>> but this patch is not really fixing anything in my opinion. It simply
>> gets back to the previous "all 0s" ioprio initialization, which do not
>> show the places where we actually have missing ioprio initialization to
>> IOPRIO_DEFAULT.
> 
> So I agree we should settle on how to treat IOs with unset IO priority. The
> behavior to use task's CPU priority when IO priority is unset is there for
> a *long* time and so I think we should preserve that. The question is where
> in the stack should the switch from "unset" value to "effective ioprio"
> happen. Switching in IO context is IMO too early since userspace needs to
> be able to differentiate "unset" from "set to
> IOPRIO_CLASS_BE,IOPRIO_BE_NORM". But we could have a helper like
> current_effective_ioprio() that will do the magic with mangling unset IO
> priority based on task's CPU priority.

I agree that the task's CPU priority is a more sensible default. However, I do
not understand your point about the IO context being too early to set the
effective priority. If we do not do that, getting the issuer CPU priority will
not be easily possible, right ?

> 
> The fact is that bio->bi_ioprio gets set to anything only for direct IO in
> iomap_dio_rw(). The rest of the IO has priority unset (BFQ fetches the
> priority from task's IO context and ignores priority on bios BTW). And the
> only place where req->ioprio (inherited from bio->bi_ioprio) gets used is
> in a few drivers to set HIGHPRI flag for IOPRIO_CLASS_RT IO and then the
> relatively new code in mq-deadline.

Yes, only IOPRIO_CLASS_RT has an effect at the hardware level right now.
Everything else is only for the IO scheduler to play with. I am preparing a
patch series to support scsi/ata command duration limits though. That adds a new
IOPRIO_CLASS_DL and that one will also have an effect on the hardware.

Note that if a process/thread use ioprio_set(), we should also honor the ioprio
set for buffered reads, at least those page IOs that are issued directly from
the IO issuer context (which may include readahead... hmmm).

> 
> So it all is very inconsistent mess :-|

Indeed it is.

> 
>> Isn't it simply that IOPRIO_DEFAULT should be set as the default for any bio
>> being allocated (in bio_alloc ?) before it is setup and inherits the user io
>> priority ? Otherwise, the bio io prio is indeed IOPRIO_CLASS_NONE/0 and changing
>> IOPRIO_DEFAULT to that value removes the differences you observed.
> 
> Yes, I think that would make sence although as I explain above this is
> somewhat independent to what the default IO priority behavior should be.
I am OK with the use of the task CPU priority/ionice value as the default when
no other ioprio is set for a bio using the user aio_reqprio or ioprio_set(). If
this relies on task_nice_ioclass() as it is today (I see no reason to change
that), then the default class for regular tasks remains IOPRIO_CLASS_BE as is
defined by IOPRIO_DEFAULT.

But to avoid the performance regression you observed, we really need to be 100%
sure that all bios have their ->bi_ioprio field correctly initialized. Something
like:

void bio_set_effective_ioprio(struct *bio)
{
	switch (IOPRIO_PRIO_CLASS(bio->bi_ioprio)) {
	case IOPRIO_CLASS_RT:
	case IOPRIO_CLASS_BE:
	case IOPRIO_CLASS_IDLE:
		/*
		 * the bio ioprio was already set from an aio kiocb ioprio
		 * (aio->aio_reqprio) or from the issuer context ioprio if that
		 * context used ioprio_set().
		 */;
		return;
	case IOPRIO_CLASS_NONE:
	default:
		/* Use the current task CPU priority */
		bio->ioprio =
			IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
					  task_nice_ioprio(current));
		return;
	}
}

being called before a bio is inserted in a scheduler or bypass inserted in the
dispatch queues should result in all BIOs having an ioprio that is set to
something other than IOPRIO_CLASS_NONE. And the obvious place may be simply at
the beginning of submit_bio(), before submit_bio_noacct() is called.

I am tempted to argue that block device drivers should never see any req with an
ioprio set to IOPRIO_CLASS_NONE, which means that no bio should ever enter the
block stack with that ioprio either. With the above solution, bios from DM
targets submitted with submit_bio_noacct() could still have IOPRIO_CLASS_NONE...
So would submit_bio_noacct() be the better place to call the effective ioprio
helper ?


-- 
Damien Le Moal
Western Digital Research
