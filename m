Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7504C74A2B
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 15:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AD72064A
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 15:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IhvWN2Xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGJP5L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:57:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42375 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJP5L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 11:57:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id a10so3026520wrp.9
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bCgahzti2H4k0inNwBwoYMBFlTIrGKjBpdUGJxYsHLU=;
        b=IhvWN2XcEXZKympra4rFGQ8XvmMOyx3cF8QKZCCOcNPjRvIeGS1ZNcev/kA8e5HTxf
         93e9uQ6+rQyo9gdBki98KtcbNZFDC3UZzql6Li1ID0ELyb42995I+eSaST1jGPCa3CLj
         I+5K8ljzTtvm8M1RPksOJAi6cg4eCl640WxZV2xXG9wshriWPSTQ3DZLNvHp51HSPosU
         5II1kcB5ChdXngbJb9eWvIVxv4nCfTocJQpBSd7B8LvWBHvXIocKhprOpY+pZ+KOyviT
         Rg5dtI4zUT7rEfxoUFnpJPCB6UewR13n+YFAIMcBGzArR+CIT7XHJetVfxpOTA7XRf2u
         Pm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bCgahzti2H4k0inNwBwoYMBFlTIrGKjBpdUGJxYsHLU=;
        b=aMcm/fj7qiUMiQCb3WuGpU5UBO71PLs8Xu0rtxYbKdvpDKdQV9SYC66Z7xqso4bq0H
         MfUMCS9Ooj4QR1V2r9lsro+lq1bqVKq6Uxhq0LvKiHai606+2v3mT858ZKgiewqqY1S8
         HdGLO781lvJa/M29Jk85a0XEQ+h94MUPYmN3td37doP2165fZt+jju4kg0gKCxVzJ5s4
         RsrMLsItzLqyndoMt6a7aEiLiS1eAg8zRUZ1azGljyj65ja6CRr2KAhfLV+Zk+55Crl3
         NjgatnxpCGENZRIjmaWHq3QdQ77RldfXkoL330RENZs1vYR3YY1mvOJMZ0JjRkcsdAVt
         6QjQ==
X-Gm-Message-State: APjAAAVUdmHIK5oilo5E9yPVoyU0SDQtrTtiXNLN3L+/DeCRQ/xwzhfU
        XHN4FusGRipX97HbSDvjvqMHeg==
X-Google-Smtp-Source: APXvYqyERMaNG1mszHufpHv6TPLaQ51d3M8xL3ddjS7LFW9gwJ3XCXXuNk6T9xJNV9cEfzQli2O4rg==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr6216559wrn.171.1562774229410;
        Wed, 10 Jul 2019 08:57:09 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0c1:1130::10d3? ([2620:10d:c092:180::1:1099])
        by smtp.gmail.com with ESMTPSA id r11sm3399808wre.14.2019.07.10.08.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 08:57:08 -0700 (PDT)
Subject: Re: [PATCH V2] block: Disable write plugging for zoned block devices
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>
References: <20190710155447.11112-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <71be2c3f-2e26-dfd4-72de-2eabdddd311f@kernel.dk>
Date:   Wed, 10 Jul 2019 09:57:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710155447.11112-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/19 9:54 AM, Damien Le Moal wrote:
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 633a5a77ee8b..c9195a2cd670 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -238,4 +238,14 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
>   		qmap->mq_map[cpu] = 0;
>   }
>   
> +static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
> +					   struct bio *bio)
> +{
> +	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))
> +		return current->plug;
> +
> +	/* Zoned block device write case: do not plug the BIO */
> +	return NULL;
> +}
> +
>   #endif

Folks are going to look at that and be puzzled, I think that function
deserves a comment.

-- 
Jens Axboe

