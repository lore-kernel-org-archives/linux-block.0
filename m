Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E67CC433FE
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 06:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJDGLq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 02:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJDGLp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 02:11:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83532FC3A
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 23:11:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97E881F907;
        Tue,  4 Oct 2022 06:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664863895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oGSHM0hWuwViZnggZRbXJsFebI7RBTt4DJusTo9/TUc=;
        b=c284Wlhp64CzT2OAccHeFgp7MMiAd8krIB/fW3XhSNTAn1cKcq52Q+T1hApwV7lTKmvVi3
        pmA7t4XbWUGDn5x8iYl1d06KocMQQopZYNfnAmdFY86nXdn97ZKb2MBtJI00+/5HTLJKuf
        7z/qPS2JXEuHQ4xyjfv/kOYIe1zC8/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664863895;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oGSHM0hWuwViZnggZRbXJsFebI7RBTt4DJusTo9/TUc=;
        b=Cag48y1TPu0pD2ZKc+3f2T9Swl1kvdjl2TJLMm52tF2Nc3EXmNGj4pIlK6X1NulGMypfI9
        Jy2R1gAS18E8+SCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6834F139EF;
        Tue,  4 Oct 2022 06:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lajRGJfOO2PJFQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Oct 2022 06:11:35 +0000
Message-ID: <9db5d7eb-bd84-85e6-c30a-da057f1b2b69@suse.de>
Date:   Tue, 4 Oct 2022 08:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-3-sagi@grimberg.me>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221003094344.242593-3-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/3/22 11:43, Sagi Grimberg wrote:
> Our mpath stack device is just a shim that selects a bottom namespace
> and submits the bio to it without any fancy splitting. This also means
> that we don't clone the bio or have any context to the bio beyond
> submission. However it really sucks that we don't see the mpath device
> io stats.
> 
> Given that the mpath device can't do that without adding some context
> to it, we let the bottom device do it on its behalf (somewhat similar
> to the approach taken in nvme_trace_bio_complete).
> 
> When the IO starts, we account the request for multipath IO stats using
> REQ_NVME_MPATH_IO_STATS nvme_request flag to avoid queue io stats disable
> in the middle of the request.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c      |  4 ++++
>   drivers/nvme/host/multipath.c | 25 +++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      | 12 ++++++++++++
>   3 files changed, 41 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 64fd772de817..d5a54ddf73f2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -384,6 +384,8 @@ static inline void nvme_end_req(struct request *req)
>   		nvme_log_error(req);
>   	nvme_end_req_zoned(req);
>   	nvme_trace_bio_complete(req);
> +	if (req->cmd_flags & REQ_NVME_MPATH)
> +		nvme_mpath_end_request(req);
>   	blk_mq_end_request(req, status);
>   }
>   
> @@ -421,6 +423,8 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
>   
>   void nvme_start_request(struct request *rq)
>   {
> +	if (rq->cmd_flags & REQ_NVME_MPATH)
> +		nvme_mpath_start_request(rq);
>   	blk_mq_start_request(rq);
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_request);

Why don't you move the check for REQ_NVME_MPATH into 
nvme_mpath_{start,end}_request?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

