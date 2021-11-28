Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89AFC433EF
	for <linux-block@archiver.kernel.org>; Sun, 28 Nov 2021 10:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhK1Ksv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Nov 2021 05:48:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51458 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357220AbhK1Kqv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Nov 2021 05:46:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D863D1FCA3;
        Sun, 28 Nov 2021 10:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638096211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3XPObdsGLhTMC67Iw0Nwt0G7ktgm8K+swHK5T7YOKXg=;
        b=FK4JwCojVd/M1kkZF9ag0WX1LsvErKA7qm/LgQaohbbSKimEMKPY8Ey5vZyG93Cc2mz2Tu
        7X8YEMlDPgqZ9Imo7e5WOuYi+herM0Ug2F2aloPTB7pgX5V7T945USBngNKfhh7Xvb6zpX
        bi0oYSHbUKnJaDkKMOTh7dvB9F/C8c0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638096211;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3XPObdsGLhTMC67Iw0Nwt0G7ktgm8K+swHK5T7YOKXg=;
        b=1Wv9kM9Kjg+IqgNRavewj4VCchBFGW9z2DxnVxkZNss6Q2edQ2VtH6MnAo7RUHnrEXdCLL
        K6/N86al22bVKMBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEADC13446;
        Sun, 28 Nov 2021 10:43:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M+g8KFNdo2F9SQAAMHmgww
        (envelope-from <hare@suse.de>); Sun, 28 Nov 2021 10:43:31 +0000
Subject: Re: [PATCH RFT 3/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for
 shared tags
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, kashyap.desai@broadcom.com
References: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
 <1635852455-39935-4-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <95685711-ee3c-f1ec-4329-47e8e789a08a@suse.de>
Date:   Sun, 28 Nov 2021 11:43:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1635852455-39935-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/21 12:27 PM, John Garry wrote:
> Kashyap reports high CPU usage in blk_mq_queue_tag_busy_iter() and callees
> using megaraid SAS RAID card since moving to shared tags [0].
> 
> Previously, when shared tags was shared sbitmap, this function was less
> than optimum since we would iter through all tags for all hctx's,
> yet only ever match upto tagset depth number of rqs.
> 
> Since the change to shared tags, things are even less efficient if we have
> parallel callers of blk_mq_queue_tag_busy_iter(). This is because in
> bt_iter() -> blk_mq_find_and_get_req() there would be more contention on
> accessing each request ref and tags->lock since they are now shared among
> all HW queues.
> 
> Optimise by having separate calls to bt_for_each() for when we're using
> shared tags. In this case no longer pass a hctx, as it is no longer
> relevant, and teach bt_iter() about this.
> 
> Ming suggested something along the lines of this change, apart from a
> different implementation.
> 
> [0] https://lore.kernel.org/linux-block/e4e92abbe9d52bcba6b8cc6c91c442cc@mail.gmail.com/
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   block/blk-mq-tag.c | 52 +++++++++++++++++++++++++++++++---------------
>   1 file changed, 35 insertions(+), 17 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
