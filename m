Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84348C4320A
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 17:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F0F60FD8
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 17:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbhHZRBm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243172AbhHZRBl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 13:01:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BF8C0613C1
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 10:00:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n5so6087604wro.12
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D0BmolIUc7AaxmOXkkGcHNut86vj3C+IhIQPOzpyCi4=;
        b=QOYbShgS6bD3HWaIwPIFr8nBnwyvyYoqHaxzTX4E9vt6+kZIAQIrUIrLcdXnpPhPKU
         OrPl1ZhFSspKBSr/1YxyxVEcG2CeB8aHYbVY3AEJuyySkWF6p0kP7i1BuUNhnwXRu42c
         7hDnQp680Ml9t4sh7iJcvSOVY8rKlaUsbI0RGW+x0CacNWo2oTAIUuFpeDwXzhNxWiIP
         iISIO3fyELAJYiC3qRhhass1V/LmRO2+JLPviwDgtTh7VqmhBYM1mkuSWqAIwRinufLr
         2LSt5qvUNkIi7/cHEMcIVo2F6U7ki18Z8v01BcGYmb2clAozWG7Try7KD5ej0eYPElpR
         wzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D0BmolIUc7AaxmOXkkGcHNut86vj3C+IhIQPOzpyCi4=;
        b=Z0PfBnBuvz8TIa65RXmE/PJVAE3SwXMF5aQjPkHiasVcC4G3QYDkfRvSphIoBbHSbN
         JZHn14ZpbAjb/kAt0NfEUA/mXP6cZ6xM5vShpZ8Z4kVNFSczZGW2pJNXWZ80hxgX9/1t
         iuGWbwwoI4/Az/MWggzaSNIP5v6tjWqakIyDI1ISmz+HaeivlTY3bCJKPluYy6VBdg6s
         63lbxrXmetiwHsZ/EbTKmVGbE9xqu67EfUaLSjjz3OczoShldsFES1nqEcRPYVSp+A17
         tvNi+e2kv5AePE0QSSn/szKX+9LfZvS8Q+An7DJ5rD7z9+kX7BXd+yseR/D5HH7XCzh7
         0RcQ==
X-Gm-Message-State: AOAM53291KW65J0rzYi5jQvf+jYauSFrg0WcvrxkcubDg4QvEig2WXVb
        elI2/MHRJYPNL/F5ZUJ8jzlI49IXebQBaQ==
X-Google-Smtp-Source: ABdhPJwNZp7aLl+JaXIhkMUeFPlQx7dJsYl7biwuzYUdIyGQm2Jubx6QDJwgZO/SJej9+S7n1PRViQ==
X-Received: by 2002:adf:b745:: with SMTP id n5mr5237936wre.338.1629997252614;
        Thu, 26 Aug 2021 10:00:52 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id t5sm2552698wra.95.2021.08.26.10.00.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Aug 2021 10:00:52 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 3/4] block, bfq: add support to record request size
 information
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210806020826.1407257-4-yukuai3@huawei.com>
Date:   Thu, 26 Aug 2021 19:00:51 +0200
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6420E679-38C5-4599-AE28-446F927BDB6F@linaro.org>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
 <20210806020826.1407257-4-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 6 ago 2021, alle ore 04:08, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> If bfq keep

keeps

> dispatching requests with same size, the following
> information are

is stored

> stored if CONFIG_BFQ_GROUP_IOSCHED is enabled:
>=20
> 1) the size
> 2) the count of requests
> 3) when the first request was dispatched
>=20
> These will be used in later patch to support concurrent sync
> io in such situation.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> block/bfq-iosched.c | 15 +++++++++++++++
> block/bfq-iosched.h | 16 ++++++++++++++++
> 2 files changed, 31 insertions(+)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index a780205a1be4..7df3fc0ef4ef 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4936,6 +4936,20 @@ static bool bfq_has_work(struct blk_mq_hw_ctx =
*hctx)
> 		bfq_tot_busy_queues(bfqd) > 0;
> }
>=20
> +static void bfq_update_dispatch_size_info(struct bfq_data *bfqd,
> +					  unsigned int size)
> +{
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> +	if (bfqd->dispatch_size =3D=3D size) {
> +		bfqd->dispatch_count++;
> +	} else {
> +		bfqd->dispatch_size =3D size;
> +		bfqd->dispatch_count =3D 1;
> +		bfqd->dispatch_time =3D jiffies;
> +	}
> +#endif
> +}
> +
> static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx =
*hctx)
> {
> 	struct bfq_data *bfqd =3D hctx->queue->elevator->elevator_data;
> @@ -5019,6 +5033,7 @@ static struct request =
*__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
> 		bfqd->rq_in_driver++;
> start_rq:
> 		rq->rq_flags |=3D RQF_STARTED;
> +		bfq_update_dispatch_size_info(bfqd, blk_rq_bytes(rq));
> 	}
> exit:
> 	return rq;
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 610769214f72..9ab498839e7c 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -777,6 +777,22 @@ struct bfq_data {
> 	 * function)
> 	 */
> 	unsigned int word_depths[2][2];
> +
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> +	/* the size of last dispatched request */
> +	unsigned int dispatch_size;
> +	/*
> +	 * If bfq keep dispatching requests with same size, this store =
the

keeps ... stores

> +	 * count of requests. We use unsigned long here, so we don't =
care
> +	 * about overflow.
> +	 */
> +	unsigned long dispatch_count;
> +	/*
> +	 * If bfq keep dispatching requests with same size, this store =
the

keeps ... stores

Thanks,
Paolo

> +	 * time when the first request was dispatched.
> +	 */
> +	unsigned long dispatch_time;
> +#endif
> };
>=20
> enum bfqq_state_flags {
> --=20
> 2.31.1
>=20

