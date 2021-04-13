Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB05C433ED
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 16:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494A661004
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 16:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbhDMQSX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 12:18:23 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:56009 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhDMQSW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 12:18:22 -0400
Received: by mail-pj1-f44.google.com with SMTP id s14so3888152pjl.5;
        Tue, 13 Apr 2021 09:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/LRwKo8dn0MljtPNm7dSpcMCQAuuph6Ku1LEOu1i+PA=;
        b=YGdWaxTzvzCQAEx85NBOUHe02qM9ymzf0kD/Y1AsreHN+86XeHtkhxVeNzLRsuDP1p
         x9B1/EeL2eijcSRg7BSVQLeHLb6MCM43R/NrjHdivEXd4q+qvZpkzZioE8cORjpYwLoN
         WLn3lFdd2lHLGYrK6AFHM07CMcfEonfrOGzQRR8qV6eRQSVE5mXimU29npspqEluwaxP
         oHFk7aRUvthnpjEDvFLOic0kv+wTPyv+bZX+4vUCmBYklU8xc37xwDkw+eLiln63L7h1
         pgs1t3/jF1a+zxjwtg0uWt8ddJnZhL3YdN/6lZoDVivq1sNngToDD1r/d01FQhFAjoA8
         3TjQ==
X-Gm-Message-State: AOAM530A6DlQzqMJ2A3QQJFoIgdPZUUrBzAa92XXkLkCEJ3p9jv8ZetK
        JbAD/KEIM4+zYukFU60jeNA=
X-Google-Smtp-Source: ABdhPJw4Ytpvr9/UWgaEETaKL9ALSRBQgs94pxx62HFE9wxzMqQobQL5TSoDDLWFvbcK6JC51bj2HA==
X-Received: by 2002:a17:90b:4a81:: with SMTP id lp1mr835205pjb.154.1618330682678;
        Tue, 13 Apr 2021 09:18:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:345f:c70d:97e0:e2ef? ([2601:647:4000:d7:345f:c70d:97e0:e2ef])
        by smtp.gmail.com with ESMTPSA id s13sm2607981pjl.48.2021.04.13.09.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 09:18:02 -0700 (PDT)
Subject: Re: [PATCH v7 1/3] bio: limit bio max size
To:     Changheun Lee <nanich.lee@samsung.com>, damien.lemoal@wdc.com,
        Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
References: <20210413025502.31579-1-nanich.lee@samsung.com>
 <CGME20210413031257epcas1p329f38effa71445de2464cee32002e618@epcas1p3.samsung.com>
 <20210413025502.31579-2-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2e54f27a-ae4c-af65-34ba-18b43bd4815d@acm.org>
Date:   Tue, 13 Apr 2021 09:18:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210413025502.31579-2-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/21 7:55 PM, Changheun Lee wrote:
> +unsigned int bio_max_size(struct bio *bio)
> +{
> +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +
> +	if (blk_queue_limit_bio_size(q))
> +		return blk_queue_get_max_sectors(q, bio_op(bio))
> +			<< SECTOR_SHIFT;
> +
> +	return UINT_MAX;
> +}

This patch adds an if-statement to the hot path and that may have a
slight negative performance impact. I recommend to follow the approach
of max_hw_sectors. That means removing QUEUE_FLAG_LIMIT_BIO_SIZE and to
initialize the maximum bio size to UINT_MAX in blk_set_default_limits().

Thanks,

Bart.
