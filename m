Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B396FC48BD1
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9803D613C6
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhFJGYD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:24:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53316 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFJGYD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 02:24:03 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 34E541FD37;
        Thu, 10 Jun 2021 06:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623306126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5PLv8prxtSqmU/jjUUUkuw/WeXdPpr5M+Gh63pEAQ8=;
        b=vT3bR/ElYh8bh62mLqp4LeEwGO25WUpncdPhQz18e9DDtYrcSAEDm4dZ8QatHI+AzkyQxt
        /WboTIRjL0mznBqDvtMuzbsJ4t+TgmzsMLZ8fEykCLWCod1GbkByAYscczjM5i89U8lh+m
        j/09oExxnHx5Lvs6MAvFPe59gUvZ/3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623306126;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5PLv8prxtSqmU/jjUUUkuw/WeXdPpr5M+Gh63pEAQ8=;
        b=VmdrrxGRWzFBCOoq2qpCVO18mNgaMhiz9QpDJsyx/NvCSQDD2gRMzyQSoCTihsJB89lEUo
        n4U2fcdPXQeyyEDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id F2D95118DD;
        Thu, 10 Jun 2021 06:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623306126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5PLv8prxtSqmU/jjUUUkuw/WeXdPpr5M+Gh63pEAQ8=;
        b=vT3bR/ElYh8bh62mLqp4LeEwGO25WUpncdPhQz18e9DDtYrcSAEDm4dZ8QatHI+AzkyQxt
        /WboTIRjL0mznBqDvtMuzbsJ4t+TgmzsMLZ8fEykCLWCod1GbkByAYscczjM5i89U8lh+m
        j/09oExxnHx5Lvs6MAvFPe59gUvZ/3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623306126;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5PLv8prxtSqmU/jjUUUkuw/WeXdPpr5M+Gh63pEAQ8=;
        b=VmdrrxGRWzFBCOoq2qpCVO18mNgaMhiz9QpDJsyx/NvCSQDD2gRMzyQSoCTihsJB89lEUo
        n4U2fcdPXQeyyEDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id uv24OY2vwWDqWQAALh3uQQ
        (envelope-from <hare@suse.de>); Thu, 10 Jun 2021 06:22:05 +0000
Subject: Re: [PATCH 07/14] block/mq-deadline: Remove two local variables
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-8-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <40aee2b0-34d4-bd2a-5582-6d5a4fd01dfa@suse.de>
Date:   Thu, 10 Jun 2021 08:22:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608230703.19510-8-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 1:06 AM, Bart Van Assche wrote:
> Make __dd_dispatch_request() easier to read by removing two local
> variables.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
