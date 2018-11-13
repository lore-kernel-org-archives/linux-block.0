Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8D3C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 19:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0256722419
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 19:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KVKMr2oX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0256722419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeKNFUU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:20:20 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37690 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeKNFUU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 00:20:20 -0500
Received: by mail-io1-f67.google.com with SMTP id a3so3098174ioc.4
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 11:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9EsoTkqxqSLmgEnKYvT5ZRwO9gPWZrFeZw50w3YzxOI=;
        b=KVKMr2oXNeuYCUkldZ1wyIpyx/CpgR4YyUQr7cGlkZ5fwnjM9T9PvJtNN+ZzUvepAs
         a6T2JhMWgelRO5RW5ncmszCTr2BfSOHgrc34UtdEYJynIKLd+l8br2AQIDd0tLhH1Ct1
         chTcVt92EbvwTyoin1J4xXl6hcoe1MikZJslzFrX48t85og+ojC/rM7C6DoMTwj6d446
         PngSfhZa5v+fU8fAC9mXW19nlGOuOghoaBLjbp1d0akfH4tM2VNhGCNLx7HDgmYT3QZP
         jZSBEKDyAO/c2K3F8poI7y7ENde8TJqpI2m2hlQjnDt3KjoWfdW6XEPFh2upKKp+e5Ov
         ceyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9EsoTkqxqSLmgEnKYvT5ZRwO9gPWZrFeZw50w3YzxOI=;
        b=QZhFAeAVv6OrIC/x7dbbhC7WpFt841ZDnRKMDIWChQ2GCoWjfd8UYjIWwCEzSCzbhR
         ApUMGSyA+6GdWxHBRzikrbCLM5juVhLbw2TGc8FMVMA2h0U1dAH70fHxdtr3snAWnttV
         5ENu6NLo6/YHgJd5kpPmwtaNhz9DmSfjMu8Ytl0U6k80zlyYCoSY1xyBz6q9eL0sk51C
         us/GcVr6zn1Vyvz2xO8BOvnaclGE2xMPRUsAf6/4832Q5NfkN0a8QashuEzxvzqZNyHN
         udJoT18YdHUuGt20cH3Ws7BqsLosIaMT1Gwht6cdGVNtBqGTPKzhj/RhIHua+F+8ygFv
         AkBw==
X-Gm-Message-State: AGRZ1gIdAAUoO0533KPygCs4iUEUg6f9pMZbDLNJ8XpBmA80OE0L5eF0
        jrDaS7VUPxDYJfjUTF9XEpSxpSCItQ4=
X-Google-Smtp-Source: AJdET5cPzak/ni3PZTQCdw1uI5LsLASnmFikR1XJs8227bhHXQFNX7trAxTsRMkFWxrU5eugfYxoHA==
X-Received: by 2002:a6b:b78d:: with SMTP id h135-v6mr4951395iof.274.1542136849372;
        Tue, 13 Nov 2018 11:20:49 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o14-v6sm6942780ito.3.2018.11.13.11.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:20:47 -0800 (PST)
Subject: Re: [PATCH 1/2] scsi: Do not rely on blk-mq for double completions
To:     Keith Busch <keith.busch@intel.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20181113185712.10063-1-keith.busch@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b2d9c646-3311-9f85-6e8b-de3ddf295899@kernel.dk>
Date:   Tue, 13 Nov 2018 12:20:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113185712.10063-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/13/18 11:57 AM, Keith Busch wrote:
> The scsi timeout error handling had been directly updating the request
> state to prevent a natural completion and error handling from completing
> the same request twice. Fix this layering violation by having scsi
> control the fate of its commands with scsi owned flags rather than
> use blk-mq's.
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 61babcb269ab..c680171ca201 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1635,8 +1635,18 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
>  
>  static void scsi_mq_done(struct scsi_cmnd *cmd)
>  {
> +	if (test_and_set_bit(__SCMD_COMPLETE, &cmd->flags))
> +		return;
>  	trace_scsi_dispatch_cmd_done(cmd);
>  	blk_mq_complete_request(cmd->request);
> +
> +#ifdef CONFIG_FAIL_IO_TIMEOUT
> +	/*
> +	 * Clearing complete here serves only to allow the desired recovery to
> +	 * escalate on blk_rq_should_fake_timeout()'s error injection.
> +	 */
> +	clear_bit(__SCMD_COMPLETE, &cmd->flags);
> +#endif
>  }

We could have this be:

static void scsi_mq_done(struct scsi_cmnd *cmd)
{
	if (test_and_set_bit(__SCMD_COMPLETE, &cmd->flags))
		return;
 	trace_scsi_dispatch_cmd_done(cmd);

 	if (blk_mq_complete_request(cmd->request)) {
		/*
		 * Clearing complete here serves only to allow the
		 * desired recovery to escalate on
		 * blk_rq_should_fake_timeout()'s error injection.
		 */
		clear_bit(__SCMD_COMPLETE, &cmd->flags);
	}
}

with

bool blk_mq_complete_request(struct request *rq)
{
	if (unlikely(blk_should_fake_timeout(rq->q)))
		return true;
	__blk_mq_complete_request(rq);
	return false;
}

and not have this CONFIG_FAIL_IO_TIMEOUT dependency, but that'd be a bit
more expensive.

Was going to suggest a request flag, but the request is gone at this
point. So that won't really work...

I'm with your solution as well, fwiw.

-- 
Jens Axboe

