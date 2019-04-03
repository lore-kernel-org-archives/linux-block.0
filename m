Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF27CC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 21:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4289206DD
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 21:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfDCVrm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:47:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35313 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCVrm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 17:47:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id j132so169231oib.2;
        Wed, 03 Apr 2019 14:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KOx4wzKCpwgMYGX0YYAJALuzRNStsmrDfiYt9i4Ya4c=;
        b=CquIVjs6YZnuaxKLyijlEEFnJUlMZeSp2yHv0dA7Nsy7Zjc9UONc5MCGWxKHPuWZiG
         sTG38OVGAejAezK+9ZsCcZEmWtSSEjfmsIWkO0ku5HQx2EURtLodbbbuocUjysFcT86S
         LQmwOcYHlRxCgvFNDA1q92GAqlJUb1Rj7vTUNMEBF4WHCqbexz7kPEpiXJktiyVNz3d+
         OOIYJDhpyPkZKBOWBgl8l2rnbRGwTLo+Bpd8VqnMTmkei0uxclJAiFN5nLIX/TXdJmU9
         6T2HV6ym0lN9IyEl5Nnp0+bn9eoLEL5ZhX7es9gU8EqGZkzKfNFaVwVzy+/ar3fb660u
         Sp6A==
X-Gm-Message-State: APjAAAUOpdfp0skTXSRDAvwMhm1ALa+/AdE8tN2gWB2DXraqSd3F/9Z9
        WduDDwZw3/nbYVqpUtgPBiQJc4Vi
X-Google-Smtp-Source: APXvYqyZcReFv81PWDWl3RHSWTYZuG8YuQWi6Y/chX9v4ape5gaK+d1+FdJo5p9gtpBC0+mosoQkOg==
X-Received: by 2002:aca:df55:: with SMTP id w82mr1174186oig.113.1554328060617;
        Wed, 03 Apr 2019 14:47:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id d21sm7227569otl.33.2019.04.03.14.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 14:47:39 -0700 (PDT)
Subject: Re: Panic when rebooting target server testing srp on 5.0.0-rc2
To:     Bart Van Assche <bvanassche@acm.org>,
        Laurence Oberman <loberman@redhat.com>,
        Ming Lei <tom.leiming@gmail.com>, jianchao.w.wang@oracle.com
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <6e19971d315f4a3ce2cc20a1c6693f4a263a280c.camel@redhat.com>
 <7858e19ce3fc3ebf7845494a2209c58cd9e3086d.camel@redhat.com>
 <1553113730.65329.60.camel@acm.org>
 <3645c45e88523d4b242333d96adbb492ab100f97.camel@redhat.com>
 <d9febee1de759206bbf4d66f6570415ae64e4f33.camel@redhat.com>
 <8a6807100283a0c1256410f4f0381979b18398fe.camel@redhat.com>
 <CACVXFVOfZvnDo_ccVm1+cFRo_oSoiexgLfe_pyXp84v=0eQ7rQ@mail.gmail.com>
 <38a35a9c6a74371ebaea6cdf210184b8dee4dbeb.camel@redhat.com>
 <5d79ef69efecba45718c87110e8a37a37f973bea.camel@redhat.com>
 <74e767afc0e10054f87fc821fa15966449d3dd2a.camel@redhat.com>
 <1554313972.118779.233.camel@acm.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <71cb067b-2267-c151-dbdc-a21f78d5fb0c@grimberg.me>
Date:   Wed, 3 Apr 2019 14:47:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554313972.118779.233.camel@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> I have not been able to reproduce this issue. But you may want to try
> the following patch (applies on top of v5.1-rc3):
> 
> 
> Subject: [PATCH] block: Fix blk_mq_try_issue_directly()
> 
> If blk_mq_try_issue_directly() returns BLK_STS*_RESOURCE that means that
> the request has not been queued and that the caller should retry to submit
> the request. Both blk_mq_request_bypass_insert() and
> blk_mq_sched_insert_request() guarantee that a request will be processed.
> Hence return BLK_STS_OK if one of these functions is called. This patch
> avoids that blk_mq_dispatch_rq_list() crashes when using dm-mpath.
> 
> Reported-by: Laurence Oberman <loberman@redhat.com>
> Fixes: 7f556a44e61d ("blk-mq: refactor the code of issue request directly") # v5.0.
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 652d0c6d5945..b2c20dce8a30 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1859,16 +1859,11 @@ blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>   	case BLK_STS_RESOURCE:
>   		if (force) {
>   			blk_mq_request_bypass_insert(rq, run_queue);
> -			/*
> -			 * We have to return BLK_STS_OK for the DM
> -			 * to avoid livelock. Otherwise, we return
> -			 * the real result to indicate whether the
> -			 * request is direct-issued successfully.
> -			 */
> -			ret = bypass ? BLK_STS_OK : ret;
> +			ret = BLK_STS_OK;
>   		} else if (!bypass) {
>   			blk_mq_sched_insert_request(rq, false,
>   						    run_queue, false);
> +			ret = BLK_STS_OK;
>   		}

I would move the ret assignment here after the condition statement.
