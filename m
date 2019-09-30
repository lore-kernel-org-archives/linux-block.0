Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222D4C32792
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 20:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5F3224FE
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 20:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfI3UtR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:49:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42236 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfI3UtR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 16:49:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so4351458pls.9;
        Mon, 30 Sep 2019 13:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UmfTonvoYn/sz7KFi8ddR6otlUnEOyJ4JIchPng5apk=;
        b=tM+kEN5Q+0P1culpTLFOtBmWg2yeAiVDO9IyeMqvDlse3rsa7YGmoTHPG+PrxxjzA/
         Qalb9ctomHYT3uNkvDIQuPPCvkYH89A8AaRPOHXIHG7ldQC932HXs4E4q7s8JYBGduKq
         yqKUJU6Xd5HVozyWAXc99hAoJ/ft75dpnLuXhN4s8NgtCmL+fe8FzJtelJjtAxdUDd3w
         td90e+DTLan6kRwuiMSQ1ehhE58IH7uFNAeIgdocNqo24f0s7XIXTIfL0Nd1bJm8xFAx
         euy1OAYcgoTTc6hpw9flYSc5lzEknM+k3xwf+Fq/CSqvbsxUtWGGF6JZYxG3zqT89s1S
         rrvw==
X-Gm-Message-State: APjAAAXib+8zCjdcONf4A4WyJmQmgTK10ZMfN8GCAGurttF5VKZRj88c
        aLQ3cE6YUufW4KfKwhC0jNvm9hZd
X-Google-Smtp-Source: APXvYqzbrSXpsKliVwn/NaAkhG1dBCmQeIWrM1t1mWJH2RQEgJUdDCSsZ6p1pPQ+4rLLp3sAiSHCnw==
X-Received: by 2002:a17:902:bd88:: with SMTP id q8mr22421320pls.288.1569873208094;
        Mon, 30 Sep 2019 12:53:28 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id w27sm9598997pfq.32.2019.09.30.12.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 12:53:27 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] blk-mq: Inline request status checkers
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-nvme@lists.infradead.org
References: <1cd320dad54bd78cb6721f7fe8dd2e197b9fbfa2.1569830796.git.asml.silence@gmail.com>
 <e6fc239412811140c83de906b75689530661f65d.1569872122.git.asml.silence@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e4d452ad-da24-a1a9-7e2d-f9cd5d0733da@acm.org>
Date:   Mon, 30 Sep 2019 12:53:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e6fc239412811140c83de906b75689530661f65d.1569872122.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/19 12:43 PM, Pavel Begunkov (Silence) wrote:
> @@ -282,7 +282,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  	 * test and set the bit before assining ->rqs[].
>  	 */
>  	rq = tags->rqs[bitnr];
> -	if (rq && blk_mq_request_started(rq))
> +	if (rq && blk_mq_rq_state(rq) != MQ_RQ_IDLE)
>  		return iter_data->fn(rq, iter_data->data, reserved);
>  
>  	return true>
> @@ -360,7 +360,7 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
>  {
>  	unsigned *count = data;
>  
> -	if (blk_mq_request_completed(rq))
> +	if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
>  		(*count)++;
>  	return true;
>  }

Changes like the above significantly reduce readability of the code in
the block layer core. I don't like this. I think this patch is a step
backwards instead of a step forwards.

Bart.

