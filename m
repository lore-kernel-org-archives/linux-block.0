Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6C5C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 08:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0FF61D08
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 08:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbhF3ISQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 04:18:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45744 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbhF3ISQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 04:18:16 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 30E321FE3B;
        Wed, 30 Jun 2021 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625040947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LN6+hSCnnQVV1lBAadscEQCEm2I2cFMswDtuEyY5AQM=;
        b=sqdBm/S1Jp4iQ5rKuwORax/+6LsKR6Mz82+GFHyXqPNErX8hTv0w9tx2Hsycc5Ta2QprYu
        s1Jgqw372Ax5Ryoe82aq5/gIn6gysXiJSSj9wd8rGmTAFMYRppBxLAyQkgbtrb+xyyu/Ie
        ujrnT9B+PcJgSv/LNQUNCzSxB9G8Xeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625040947;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LN6+hSCnnQVV1lBAadscEQCEm2I2cFMswDtuEyY5AQM=;
        b=sdq2BggLE1xlv6d2Q78YwVNhSUSDlsqWM6fC4V29RxO68iURFseYXxgMSavoVNDdOUCu5e
        IvOOd63+1YbqkpDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 105B111906;
        Wed, 30 Jun 2021 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625040947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LN6+hSCnnQVV1lBAadscEQCEm2I2cFMswDtuEyY5AQM=;
        b=sqdBm/S1Jp4iQ5rKuwORax/+6LsKR6Mz82+GFHyXqPNErX8hTv0w9tx2Hsycc5Ta2QprYu
        s1Jgqw372Ax5Ryoe82aq5/gIn6gysXiJSSj9wd8rGmTAFMYRppBxLAyQkgbtrb+xyyu/Ie
        ujrnT9B+PcJgSv/LNQUNCzSxB9G8Xeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625040947;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LN6+hSCnnQVV1lBAadscEQCEm2I2cFMswDtuEyY5AQM=;
        b=sdq2BggLE1xlv6d2Q78YwVNhSUSDlsqWM6fC4V29RxO68iURFseYXxgMSavoVNDdOUCu5e
        IvOOd63+1YbqkpDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id arNxAzMo3GAiOQAALh3uQQ
        (envelope-from <hare@suse.de>); Wed, 30 Jun 2021 08:15:47 +0000
Subject: Re: [PATCH 2/2] nvme: pass BLK_MQ_F_NOT_USE_MANAGED_IRQ for
 fc/rdma/tcp/loop
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-3-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <46fdb02d-8d71-d465-072d-5e8d6ec3601f@suse.de>
Date:   Wed, 30 Jun 2021 10:15:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210629074951.1981284-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/21 9:49 AM, Ming Lei wrote:
> All the 4 host drivers don't use managed irq for completing request, so
> it is correct to pass the flag to blk-mq.
> 
> Secondly with this flag, blk-mq will help us dispatch connect request
> allocated via blk_mq_alloc_request_hctx() to driver even though all
> CPU in the specified hctx's cpumask are offline.
> 
How is this supposed to work?
To my understanding, only cpus in the hctx cpumask are eligible to send 
I/O. So if all of these CPUs are offline, who exactly is submitting I/O?
More to the point, which CPU will be submitting the connect request?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
