Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DF9C433EF
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 18:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B3260FC2
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 18:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhKCSOv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:14:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43762 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhKCSOv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 14:14:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 67802218B2;
        Wed,  3 Nov 2021 18:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635963133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M5xi9zgTrboVqJHeduNb9rmHRIFLMslDpsoc2TkwWhc=;
        b=k/K7kFYk4Jy275dVNGdH7foeMCeDmSdcbf6Ws2SqvW6QjhZ4sD2Mhkuwv12bFOXJB+1qKU
        t5pUFI35uCtthCZ/VkuFMvYcFOrJ6KESHDhnzf22DsL4jwzYg2AAsIJc31zGhp2m8XTuR9
        l7sxY+9POjMKTNATrUa0b26BYbMnYzw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 457CB13C89;
        Wed,  3 Nov 2021 18:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uFtBEP3QgmHhCQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 03 Nov 2021 18:12:13 +0000
Date:   Wed, 3 Nov 2021 19:12:12 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4/8] bfq: Limit number of requests consumed by each cgroup
Message-ID: <20211103181211.GA10322@blackbody.suse.cz>
References: <20211006164110.10817-1-jack@suse.cz>
 <20211006173157.6906-4-jack@suse.cz>
 <20211102181658.GA63407@blackbody.suse.cz>
 <20211103130314.GC20482@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211103130314.GC20482@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 03, 2021 at 02:03:14PM +0100, Jan Kara <jack@suse.cz> wrote:
> Since we stop the loop at bfq_class_idx(entity)

Aha! I overlooked the for loop ends with the entity's class here and not
after the full range of classes.

> I.e., we scale available tags proportionally to bfq_queue weight (which
> scales linearly with IO priority).

Yes, you're working within the "order" of the entity's class and it's
always the last, i.e. least too, so the scale is 1.

> So in principle it can happen that there would be no tag left for a
> process in lower IO priority class - and that is fine, we don't care,
> because we don't want to submit IO from lower IO priority class while
> there is still IO in higher IO priority class.

Actually, can it ever happen that the higher class leaves some tags for
the lower? (IOW, is the CLS_wsum anytime exceeding sum of all active
entities of the CLS at the given point in time?) (1)

> Now consider a situation for a process in BE IO priority class in this
> setting. All processes in BE class can together occupy at most BE_wsum /
> (RT_wsum * IOPRIO_BE_NR + BE_wsum) fraction of tags. This is admittedly
> somewhat arbitrary fraction but it makes sure for each process in RT class
> there are at least as many tags left as for the highest priority process in
> BE class.

Can it happen that bfqq_request_over_limit() is called for a BE entity
before calling it for an RT entity (more precisely, not the
bfqq_request_over_limit() calls but actual allocation of tags)? (2)

> As I wrote above, the highest active IO priority class effectively allows
> processes in this class to consume all tags available for a cgroup. If
> there are lower IO priority classes active as well, we allow them to
> consume some tags but never allow them to consume all of them...

I assume this implies the answer to my previous question (2) is "yes"
and to the question (1) is: "numerically no, but lower class entity can
take some tags if it gets to draw them earlier".

> Yes, this is kind of an extension of bfq_io_prio_to_weight() that allows
> some comparison of queues from different IO priority classes.

I see there's no point using the same values for the weights in the
bfqq_request_over_limit() calculations as bfq_ioprio_to_weight()
calculates given the nature of strict ordering of classes above each
other. Your scoring makes sense to me now.

Reviewed-by: Michal Koutný <mkoutny@suse.com>

(this patch only)
