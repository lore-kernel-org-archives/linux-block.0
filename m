Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96B7C433EF
	for <linux-block@archiver.kernel.org>; Sun, 28 Nov 2021 10:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhK1KpR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Nov 2021 05:45:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40866 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbhK1KnR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Nov 2021 05:43:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64E462170C;
        Sun, 28 Nov 2021 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638096000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9DkhicfqLgdXO/jo7jYDrCXnxFhkX5WqR1peT7wdlYw=;
        b=C5C+XClBXZ+iT3kyeVBwoKht0lHSh8c7+AFc6a8qmWCd/v7iVdImwgGur1UTeBAqKOHGMO
        O9iTzatgwDXk48NuT9TeOUVOdapBCnrqQ9JatN/Ki7BbC4g3e/dVM1ntceZT54QERW0PHl
        7K2kRTiKJtkgg7nteArajg3ZV5LArn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638096000;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9DkhicfqLgdXO/jo7jYDrCXnxFhkX5WqR1peT7wdlYw=;
        b=pplJvuI3Zc/0Xjxia1FxB1WAPVmkDDGqPv+bm9OhREjYebk9AyJM5pWaO/ocRNg7rrznhu
        IVKBiozYvlk/haAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BBF813446;
        Sun, 28 Nov 2021 10:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dCMDDYBco2GdSAAAMHmgww
        (envelope-from <hare@suse.de>); Sun, 28 Nov 2021 10:40:00 +0000
Subject: Re: [PATCH RFT 1/3] blk-mq: Drop busy_iter_fn blk_mq_hw_ctx argument
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, kashyap.desai@broadcom.com
References: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
 <1635852455-39935-2-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <395729f9-7885-cc76-9055-7467af84c2e3@suse.de>
Date:   Sun, 28 Nov 2021 11:39:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1635852455-39935-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/21 12:27 PM, John Garry wrote:
> The only user of blk_mq_hw_ctx blk_mq_hw_ctx argument is
> blk_mq_rq_inflight().
> 
> Function blk_mq_rq_inflight() uses the hctx to find the associated request
> queue to match against the request. However this same check is already
> done in caller bt_iter(), so drop this check.
> 
> With that change there are no more users of busy_iter_fn blk_mq_hw_ctx
> argument, so drop the argument.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   block/blk-mq-tag.c     |  2 +-
>   block/blk-mq.c         | 17 ++++++++---------
>   include/linux/blk-mq.h |  3 +--
>   3 files changed, 10 insertions(+), 12 deletions(-)
> 
Reviewed-by Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
