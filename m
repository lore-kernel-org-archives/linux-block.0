Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0CAC433F5
	for <linux-block@archiver.kernel.org>; Fri, 10 Dec 2021 10:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbhLJKE0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbhLJKEZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Dec 2021 05:04:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00305C061746
        for <linux-block@vger.kernel.org>; Fri, 10 Dec 2021 02:00:50 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x15so28786475edv.1
        for <linux-block@vger.kernel.org>; Fri, 10 Dec 2021 02:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O70batPj3wvi7RLrp3X+l52GyfZpEV965rgDfVwXWZY=;
        b=nwrUIMOWOU4Q7yQqvPcI8A0eut+VItBwApaqSOQ+7tajte458rjWZjpOj5X8gek9ym
         KNcvP0d6nah96lj4Uo1XXJAsRAD6FzdqerX+6KvqepB1GzUCjMY9dej0p2bfBRyGAEBs
         eBajnOnM4yEoi8h6ZvLXUKd+Xh/IbjlK0HQWNWQhKlEhvTzRrFEXk6XjpJWncNA8OCvz
         Jbc1y4sSDIcnlWVkWnwbGTRTqs2qmO5MvBtYlazwt2qViCfH5npWoN6A+0sQMCWMOP8v
         0QTwsn6HfD4mneH4/49vSCl6EbDPRQAU3b33Fi0bzV0uuBfpTAZ4EJqHFWWZDkio675n
         o4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O70batPj3wvi7RLrp3X+l52GyfZpEV965rgDfVwXWZY=;
        b=YGh1RAdiX3/ju9UArtiLGqMZYg47jKI+jwri0KYBI/mjSUC7j4XzbSgkxYqDjrICLI
         nlYVHEO2Ct/MhB1ThjJk+heJznXgkRrPjf7B77cX9Qw3kmJw0QKrGXbLmXl2Tni59q8i
         4kW5vDThrJ/bzunz5D6S/EmdC+GRmOiAUVtv0fKs/0AMBmlwP2tfDD2MyH28zoD9XI+a
         isk8jRgPMWA3u4HShAIcyPZbWNyNHjAF0Ia4KD9fbdg3l27K38uv4/mF8b4yW+riP8Dv
         rRx4nOgc3nTLkMfOe/Gt3DYLzRwFPRGQjTmRiQd8Jbc1D09WZoeC8B6WaoGKVb6mToI6
         T5RQ==
X-Gm-Message-State: AOAM531uyi/IYVR9zPeH6cNC8QQlO2+MKQvjtCyPfXlmVnun1/NF30BC
        gRzkK89RXTdxCwNygjrU3SZzF43LtZwP4A==
X-Google-Smtp-Source: ABdhPJzVXx7aPKj2tvaSKP6WsRk3Q77ORMfERfBZXTHM+e/h9EvNk5zEsT8ijNh7uMtX3ingxiqqXg==
X-Received: by 2002:a50:e003:: with SMTP id e3mr36877353edl.374.1639130439406;
        Fri, 10 Dec 2021 02:00:39 -0800 (PST)
Received: from [192.168.1.8] (net-93-70-85-65.cust.vodafonedsl.it. [93.70.85.65])
        by smtp.gmail.com with ESMTPSA id og38sm1183171ejc.5.2021.12.10.02.00.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 02:00:38 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC 8/9] block, bfq: move forward
 __bfq_weights_tree_remove()
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20211127101132.486806-9-yukuai3@huawei.com>
Date:   Fri, 10 Dec 2021 11:00:37 +0100
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA78962A-DC03-4A1F-9B79-D085A4908E5E@linaro.org>
References: <20211127101132.486806-1-yukuai3@huawei.com>
 <20211127101132.486806-9-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 27 nov 2021, alle ore 11:11, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Prepare to decrease 'num_groups_with_pending_reqs' earlier.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> block/bfq-iosched.c | 13 +++++--------
> 1 file changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index e3c31db4bffb..4239b3996e23 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -882,6 +882,10 @@ void bfq_weights_tree_remove(struct bfq_data =
*bfqd,
> {
> 	struct bfq_entity *entity =3D bfqq->entity.parent;
>=20
> +	bfqq->ref++;
> +	__bfq_weights_tree_remove(bfqd, bfqq,
> +				  &bfqd->queue_weights_tree);
> +
> 	for_each_entity(entity) {
> 		struct bfq_sched_data *sd =3D entity->my_sched_data;
>=20
> @@ -916,14 +920,7 @@ void bfq_weights_tree_remove(struct bfq_data =
*bfqd,
> 		}
> 	}
>=20
> -	/*
> -	 * Next function is invoked last, because it causes bfqq to be
> -	 * freed if the following holds: bfqq is not in service and
> -	 * has no dispatched request. DO NOT use bfqq after the next
> -	 * function invocation.
> -	 */
> -	__bfq_weights_tree_remove(bfqd, bfqq,
> -				  &bfqd->queue_weights_tree);
> +	bfq_put_queue(bfqq);
> }
>=20

why it is not dangerous any longer to invoke __bfq_weights_tree_remove =
earlier, and the comment can be removed?

Paolo

> /*
> --=20
> 2.31.1
>=20

