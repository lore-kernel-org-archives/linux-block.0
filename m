Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727C5C433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 07:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiCGHjA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 02:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbiCGHjA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 02:39:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F72F5FAF
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 23:38:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0734F1F38E;
        Mon,  7 Mar 2022 07:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646638685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4oYl3EdZ7CSoSxevRax4nWKOsrSxDdVbt1TlmkHCjM=;
        b=Ca6bi5kp3KZJ8tJgQU9Iv/t8Kzu4K0IUtvYEbKMbKo/LF78RWtTPhg7prJfs8ydm/AK0w3
        AvY4BdAB2Evr4yrD1PE49SOMCgam/Ep9cb8oI0IFZgoJtNwTuWspsbRneASSpo0zqH4XIv
        R9P/jgAZ8g1Z3zuK9XQ4HT6WfMEsh6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646638685;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4oYl3EdZ7CSoSxevRax4nWKOsrSxDdVbt1TlmkHCjM=;
        b=gyjOVaz62GtJJ7zmFujhpfDIQcAfu/T750d/iiPWOh1hNBnrOLjCodtEr7/e7vm0aGNnQp
        DjDYE9BS63VN6KDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7D6313A04;
        Mon,  7 Mar 2022 07:38:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uS2oM1y2JWKZVgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 07 Mar 2022 07:38:04 +0000
Message-ID: <ba059185-330b-e752-25bd-737437b48c8d@suse.de>
Date:   Mon, 7 Mar 2022 08:38:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V3 5/6] blk-mq: prepare for implementing hctx table via
 xarray
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220307064401.30056-1-ming.lei@redhat.com>
 <20220307064401.30056-6-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220307064401.30056-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/22 07:44, Ming Lei wrote:
> It is inevitable to cause use-after-free on q->queue_hw_ctx between
> queue_for_each_hw_ctx() and blk_mq_update_nr_hw_queues(). And converting
> to xarray can fix the uaf, meantime code gets cleaner.
> 
> Prepare for converting q->queue_hctx_ctx into xarray, one thing is that
> xa_for_each() can only accept 'unsigned long' as index, so changes type
> of hctx index of queue_for_each_hw_ctx() into 'unsigned long'.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-debugfs.c        |  6 +++---
>   block/blk-mq-sched.c          |  9 +++++----
>   block/blk-mq-sysfs.c          | 16 ++++++++++------
>   block/blk-mq-tag.c            |  2 +-
>   block/blk-mq.c                | 30 ++++++++++++++++--------------
>   drivers/block/rnbd/rnbd-clt.c |  2 +-
>   6 files changed, 36 insertions(+), 29 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
