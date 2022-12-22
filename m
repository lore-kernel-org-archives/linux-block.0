Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B53C4167B
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 12:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiLVMRy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Dec 2022 07:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbiLVMR2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2022 07:17:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B1E5F9A;
        Thu, 22 Dec 2022 04:16:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB633218F9;
        Thu, 22 Dec 2022 12:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671711370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZYGAq14pplLpiNrmQcS1JQCKPYmMA6jJqy55in8a0s=;
        b=OIhEdkvNiZAF4cxf2ykgTqCekW3izA7U7wSQ7H9GVZx7pmmmaNXMTM+8R1coiPGfW4M8C5
        fmFQcDgiSAugDq/LjbozrrWMj45u9vp+SWwvOou8IKmAAjjq0YbgX3tmeiF4LtSKTnabqY
        jP47oDvUhTGVKStjCMTivJT5hzjH2uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671711370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZYGAq14pplLpiNrmQcS1JQCKPYmMA6jJqy55in8a0s=;
        b=iDvymCBPHfTkayLxQFvnR5HQNSEAMeaOkUoSabVmpcdtO0nyTqSgYx7BZEFNDYoKt7JsAr
        IHeOxzkIwhAsCrDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E066138FD;
        Thu, 22 Dec 2022 12:16:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U9KJJopKpGMqEgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 12:16:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3A35CA0732; Thu, 22 Dec 2022 13:16:10 +0100 (CET)
Date:   Thu, 22 Dec 2022 13:16:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, mwilck@suse.com, wuchi <wuchi.zero@gmail.com>
Subject: Re: [PATCH RESEND v2 2/5] sbitmap: remove redundant check in
 __sbitmap_queue_get_batch
Message-ID: <20221222121610.6o23vbarpiaqwkcx@quack3>
References: <20221222143353.598042-1-shikemeng@huaweicloud.com>
 <20221222143353.598042-3-shikemeng@huaweicloud.com>
 <20221222112319.26wtwxeyry6ybvse@quack3>
 <792b0caa-0e99-94b2-60bf-90ad719c63d7@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792b0caa-0e99-94b2-60bf-90ad719c63d7@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[Added to CC original author of the problematic commit and reviewer]

On Thu 22-12-22 19:49:12, Kemeng Shi wrote:
> Hi Jan, thanks for review.
> on 12/22/2022 7:23 PM, Jan Kara wrote:
> >> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> >> index cb5e03a2d65b..11e75f4040fb 100644
> >> --- a/lib/sbitmap.c
> >> +++ b/lib/sbitmap.c
> >> @@ -518,11 +518,9 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
> >>  
> >>  			get_mask = ((1UL << nr_tags) - 1) << nr;
> >>  			val = READ_ONCE(map->word);
> >> -			do {
> >> -				if ((val & ~get_mask) != val)
> >> -					goto next;
> >> -			} while (!atomic_long_try_cmpxchg(ptr, &val,
> >> -							  get_mask | val));
> >> +			while (!atomic_long_try_cmpxchg(ptr, &val,
> >> +							  get_mask | val))
> >> +				;
> >>  			get_mask = (get_mask & ~val) >> nr;
> >>  			if (get_mask) {
> >>  				*offset = nr + (index << sb->shift);
> > 
> > So I agree this will result in correct behavior but it can change
> > performance. In the original code, we end up doing
> > atomic_long_try_cmpxchg() only for words where we have a chance of getting
> > all tags allocated. Now we just accept any word where we could allocate at
> > least one bit. Frankly the original code looks rather restrictive and also
> > the fact that we look only from the first zero bit in the word looks
> > unnecessarily restrictive so maybe I miss some details about what's
> > expected from __sbitmap_queue_get_batch(). So all in all I wanted to point
> > out this needs more scrutiny from someone understanding better expectations
> > from __sbitmap_queue_get_batch().
> In the very beginning, __sbitmap_queue_get_batch will return if we only
> get partial tags allocated. Recent commit fbb564a557809 ("lib/sbitmap: Fix
> invalid loop in __sbitmap_queue_get_batch()") thought we may reuse busying
> bits in old codes and change behavior of __sbitmap_queue_get_batch() to get
> all tags. However we will not reuse busying bits in old codes actually. So
> I try to revert this wrong fix and keep the behavior of
> __sbitmap_queue_get_batch() as it designed to be at beginning.

I see and now I agree. Please add tag:

Fixes: fbb564a557809 ("lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch()") 

to your commit. Also feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>
 
> Besides, if we keep to get all tags,the check below is redundant.
> 	get_mask = (get_mask & ~ret) >> nr;
> 	if (get_mask) {
> 		...
> 	}
> As we only reach here if we get all tags and the check above will always
> pass. So this check in old codes should be removed.

Yeah, I agree.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
