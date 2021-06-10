Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82522C47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634CC613C0
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhFJGFI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:05:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51808 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhFJGFH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 02:05:07 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 733B31FD37;
        Thu, 10 Jun 2021 06:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623304991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EaIPBuG9IdWL8v+Pbtmhd74oK9XOhfojnIofuT+XfK4=;
        b=TY3TV7dx3oPr6by0QuYk+3g4/59q6pSuxXOYN0yWyIDTraMO81IWOko9QWHyrLfeFJeFo/
        zwlkjn4JQ08c0uDd9WtxMqn7v3wwi8eBPGqiYamTST7y7h4lBhDp/tFU5Gp47t1Rblpfpp
        dtV/0Mw98CS0ROJHIbFFWbM0yG/EGIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623304991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EaIPBuG9IdWL8v+Pbtmhd74oK9XOhfojnIofuT+XfK4=;
        b=eMCcGOy9Cq1l9iNU5xIZH8PnM9XQy0++523vJtTkWIYjIeoDcc2IoDCZ7DoZR0o2pDzzgI
        1EEtnMHjRh64FbAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 24177118DD;
        Thu, 10 Jun 2021 06:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623304991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EaIPBuG9IdWL8v+Pbtmhd74oK9XOhfojnIofuT+XfK4=;
        b=TY3TV7dx3oPr6by0QuYk+3g4/59q6pSuxXOYN0yWyIDTraMO81IWOko9QWHyrLfeFJeFo/
        zwlkjn4JQ08c0uDd9WtxMqn7v3wwi8eBPGqiYamTST7y7h4lBhDp/tFU5Gp47t1Rblpfpp
        dtV/0Mw98CS0ROJHIbFFWbM0yG/EGIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623304991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EaIPBuG9IdWL8v+Pbtmhd74oK9XOhfojnIofuT+XfK4=;
        b=eMCcGOy9Cq1l9iNU5xIZH8PnM9XQy0++523vJtTkWIYjIeoDcc2IoDCZ7DoZR0o2pDzzgI
        1EEtnMHjRh64FbAQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 3V+mBx+rwWDpUgAALh3uQQ
        (envelope-from <hare@suse.de>); Thu, 10 Jun 2021 06:03:11 +0000
Subject: Re: [PATCH 03/14] block/blk-rq-qos: Move a function from a header
 file into a C file
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-4-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <c7317d7b-1f3b-27f5-8f7c-876d87454a58@suse.de>
Date:   Thu, 10 Jun 2021 08:03:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608230703.19510-4-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 1:06 AM, Bart Van Assche wrote:
> rq_qos_id_to_name() is not in the hot path so move it from a .h into a .c
> file.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-rq-qos.c | 13 +++++++++++++
>  block/blk-rq-qos.h | 13 +------------
>  2 files changed, 14 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
