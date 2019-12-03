Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B487C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 00:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDA82070B
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 00:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfLCAtA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Dec 2019 19:49:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33964 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLCAtA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Dec 2019 19:49:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id h13so868424plr.1;
        Mon, 02 Dec 2019 16:49:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gkqruUigiDLwGAs8n/4um0iYijs+j5UqnZLX14xEyPw=;
        b=fYGNwNz6hWvNXHkEaPW2L/TlVoPEsRkkDioESZb0jTMpBYMXdPs8JorYD88XNAqVMI
         FOISPgBgSsp2qsQ+AQ1QGpFOQJqWX7ivpXzrgAKJUwSE6PTN1Pgk/cZm1XyT+5UYtVIu
         pXYDJ8izriH+wZ6qbN4fEDg9Fe34s5RbwsELrUrXmYzeQ47mKc23a423AQiNYv4O+6wf
         fQEzO9qbrM/iEA4yBY3upRey0HLd6/rx/AYB3M531jYXz3JTuMooyUeYKNMPLg//C493
         dUaNCnj1dIM/KoPITUzCgd4P52KYTK1QOsiv910oOlOBWhJ7ctf3mcKa2qdAu9vNsmOm
         FzCg==
X-Gm-Message-State: APjAAAXcRMnbaf+XfH9ZbCzj+CFwbJwDf5LVnnMYJIOv5ieNyPYKoNRx
        EbYktKc0djBVxCtcvdiBxxE+ABvZ
X-Google-Smtp-Source: APXvYqyA2GRBkC9z8d6c2ewOHiJ+bpqNv7hRXmwEyQSIOiiXEtRQjlIon/nX/3CvSP8FcYVUMKSZgQ==
X-Received: by 2002:a17:90a:8d10:: with SMTP id c16mr2352771pjo.109.1575334139105;
        Mon, 02 Dec 2019 16:48:59 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c1sm733565pfa.51.2019.12.02.16.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 16:48:58 -0800 (PST)
Subject: Re: [PATCH v7 1/2] loop: Report EOPNOTSUPP properly
To:     Evan Green <evgreen@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191114235008.185111-1-evgreen@chromium.org>
 <20191114154903.v7.1.I0b2734bafaa1bd6831dec49cdb4730d04be60fc8@changeid>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7d4508c7-a3fc-67f6-392e-50a6247898aa@acm.org>
Date:   Mon, 2 Dec 2019 16:48:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114154903.v7.1.I0b2734bafaa1bd6831dec49cdb4730d04be60fc8@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/19 3:50 PM, Evan Green wrote:
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index ef6e251857c8..6a9fe1f9fe84 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -461,7 +461,7 @@ static void lo_complete_rq(struct request *rq)
>   	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
>   	    req_op(rq) != REQ_OP_READ) {
>   		if (cmd->ret < 0)
> -			ret = BLK_STS_IOERR;
> +			ret = errno_to_blk_status(cmd->ret);
>   		goto end_io;
>   	}
>   
> @@ -1950,7 +1950,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>    failed:
>   	/* complete non-aio request */
>   	if (!cmd->use_aio || ret) {
> -		cmd->ret = ret ? -EIO : 0;
> +		if (ret == -EOPNOTSUPP)
> +			cmd->ret = ret;
> +		else
> +			cmd->ret = ret ? -EIO : 0;
>   		blk_mq_complete_request(rq);
>   	}
>   }

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
