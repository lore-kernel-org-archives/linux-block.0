Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F937EB64D9
	for <linux-block@archiver.kernel.org>; Fri,  7 Jul 2023 03:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjGGDfD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jul 2023 23:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGGDfC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 23:35:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA681FC9
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 20:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D300C6162A
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 03:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F18C433C8;
        Fri,  7 Jul 2023 03:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688700896;
        bh=xQ2YFcODB4eDkuqGlcrGt+RB4lgk/KdPmEt2L/pc6kk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L5DwfpV9IjE8REz6n4fLhejNfNGLKRe0UcHZkDZ6j3JXy286TIcyo1zWKiZFDz3Fv
         qB5tnTcE9cnGlXQ3NF89JhSKO4LsOqGgDitbTjCoVFswTLBUZyJL/WSZDqcErSvCMA
         o8QQBmMyzej6mjLwVhvG/VPCUZ21HPLn9zRzTQLWk5lziNE/mB0SvB5IIyvBmf/ABR
         wjWEnWoNAK1NHyJMc4VjYRi2L4tf9koApAolRaCFmqlz7CbQccdpV33BMEsnCUnZ0d
         SDyXghITNuputwFsCSXhPdBrZz3tYhDzl66j94gZdv4OHmqDgq/nbCsCcq00JBOoaa
         UB5J5UQCrmvSw==
Message-ID: <30620d8b-066f-7357-1d4c-2657d445e286@kernel.org>
Date:   Fri, 7 Jul 2023 12:34:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: Do not merge if merging is disabled
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230706201433.3987617-1-bvanassche@acm.org>
 <ZKdebT5VRdr0qxxv@ovpn-8-34.pek2.redhat.com>
 <06034722-621b-e06c-53e6-d2151cc07a64@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <06034722-621b-e06c-53e6-d2151cc07a64@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/7/23 10:50, Bart Van Assche wrote:
> On 7/6/23 17:38, Ming Lei wrote:
>> Given blk_mq_sched_try_insert_merge is only called from bfq and
>> deadline, it may not matter to apply this optimization.
> 
> Without this patch, the documentation of the "nomerges" sysfs
> attribute is incorrect. I need this patch because I want the
> ability to disable merging even if an I/O scheduler has been
> selected. As mentioned in the patch description, I discovered
> this while I was writing a shell script that submits various
> I/O workloads to a block device.

Ming's point still stands I think: blk_queue_nomerges(q) is the first
thing checked in elv_attempt_insert_merge(). So your patch should be a
no-op and disabling merging through sysfs should still be effective. Why
is your patch changing anything ?

Moving blk_mq_sched_try_insert_merge() call to rq_mergeable(rq) inside
elv_attempt_insert_merge() would also make a lot of sense I think. With
that, blk_mq_sched_try_insert_merge() would be reduced to calling only
elv_attempt_insert_merge(), which means that elv_attempt_insert_merge()
could go away.

-- 
Damien Le Moal
Western Digital Research

