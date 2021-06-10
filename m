Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F9C47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4554F61181
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFJGXA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:23:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35942 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhFJGW7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 02:22:59 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75110219A5;
        Thu, 10 Jun 2021 06:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623306063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDO763HHy6szAN1gEavM8EQ+mWvLAQCfJ8jL378NIk0=;
        b=FTkRv/E00NvS1bqbNoqPkf12wbBQPksMjEndJVJkctMVNflK94UlEY2OViICJGfxkuDiEV
        gcpIpSBakjxwLvHUzE8li2fcfI9v8nqaPlLs3CiAjiB2EcOXPe7RFivhTIR5fXwlhiEYos
        8tdsrj0xptUVBAXAe0rxEe3B0sYYGAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623306063;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDO763HHy6szAN1gEavM8EQ+mWvLAQCfJ8jL378NIk0=;
        b=ZZ8UnVqNE8guvbXHukquNCApVrga2Vk3kVRKL7IUj+4QycDLFLJXyfuJk4Y+JACCT66iEs
        EJTJhHbTievIQiDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 245A3118DD;
        Thu, 10 Jun 2021 06:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623306063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDO763HHy6szAN1gEavM8EQ+mWvLAQCfJ8jL378NIk0=;
        b=FTkRv/E00NvS1bqbNoqPkf12wbBQPksMjEndJVJkctMVNflK94UlEY2OViICJGfxkuDiEV
        gcpIpSBakjxwLvHUzE8li2fcfI9v8nqaPlLs3CiAjiB2EcOXPe7RFivhTIR5fXwlhiEYos
        8tdsrj0xptUVBAXAe0rxEe3B0sYYGAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623306063;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDO763HHy6szAN1gEavM8EQ+mWvLAQCfJ8jL378NIk0=;
        b=ZZ8UnVqNE8guvbXHukquNCApVrga2Vk3kVRKL7IUj+4QycDLFLJXyfuJk4Y+JACCT66iEs
        EJTJhHbTievIQiDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id uCQlB0+vwWBtWQAALh3uQQ
        (envelope-from <hare@suse.de>); Thu, 10 Jun 2021 06:21:03 +0000
Subject: Re: [PATCH 05/14] block/mq-deadline: Add several comments
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-6-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <9283adbe-61c4-198f-26e3-989c3f131191@suse.de>
Date:   Thu, 10 Jun 2021 08:21:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608230703.19510-6-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 1:06 AM, Bart Van Assche wrote:
> Make the code easier to read by adding more comments.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
