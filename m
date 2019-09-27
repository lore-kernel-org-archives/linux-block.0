Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D05CC4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 10:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF50120673
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 10:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="bh9vm64J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfI0Kpn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 06:45:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41273 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfI0Kpn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 06:45:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id f20so1901918edv.8
        for <linux-block@vger.kernel.org>; Fri, 27 Sep 2019 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=5ZfJhgjsJNNEiICb0XVlpoPBPpZmyftg4KZucrAlWHk=;
        b=bh9vm64JLduCse0hNtHggzmENPc9mXiYhtXkR3Z15I3jVjcn6kh4VyWqQFzElCGH/d
         oUioOd9FMNBKD7EGCNWOpqE75ZUz9698NmviaMoUYWFXomw+aEq4tSplBicJi7rzt9hu
         GkUtzCn8s/3j5ecjWcY7M8ukYuIEQntCBaaSZ21inDrl8QMPUhm+QCLxixk7+CZR4QyR
         JbMYszweFMhNeFcLCgKCasLZLsOVJJatTjOoVnbez1ptWvn1kAcMBoUqnAJzx8Vw+ZuO
         17AjmSiCORz8sbYOMsKsIqylZMUXJ7L7YuK+tDuoJB0ZXPNKF2i/RpiyHoPg2SUgZ+W4
         jjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=5ZfJhgjsJNNEiICb0XVlpoPBPpZmyftg4KZucrAlWHk=;
        b=dTIWTIoE7727fvZZ7zGbvvhIek+t4fwcOB+fL9smV6tKsiKQko8OkOXdjk8S2qh77/
         19Po12FbLxg504tKaGkbVN7zOPOiWus+SMCmvGfjysT7RHMLfI9I7w1/GTWORcHMLhqZ
         diFSyJjlIdAr4JOnGNFcpVid1JSCMkTfI8ZZRLxyTk0xLfnsXbhA95mJ1trwfEldkTdo
         v7AtGXjSAAaoLsrripMk/atXckmpr3gm3NlEl5c4LUTLBG+l4kGBGhB8ZgqbnntoYesx
         9CwlJevv+0BZLfeeL5Vfu1HxT068xPTktr6r9oBH5Fpkpvl/3Dr9CFyekSbQCheaG9Cq
         yWQg==
X-Gm-Message-State: APjAAAXnvaS8iJkSpV9DtEZG/G9XAsAzy5iRi3OYGPKtwkZu/pH2T8nJ
        JKKSlqtPdhj4zkT+8LCK2YMeCQ==
X-Google-Smtp-Source: APXvYqxFr1mpLkLsDzwgW9IPHCAtZaqdkPGns/VLpyykcUWo8LJu7VL6SViknyy3r1Wud3Zfd9RTHA==
X-Received: by 2002:a50:d758:: with SMTP id i24mr3656967edj.246.1569581140995;
        Fri, 27 Sep 2019 03:45:40 -0700 (PDT)
Received: from [10.22.151.221] ([89.248.140.17])
        by smtp.gmail.com with ESMTPSA id i53sm444881eda.33.2019.09.27.03.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 03:45:40 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <F17543BE-F182-4E28-A907-0C4925529CED@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_9E9A5CF9-8C2C-4B51-8C10-39EFC67B87B3";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] blk-mq: respect io scheduler
Date:   Fri, 27 Sep 2019 12:45:39 +0200
In-Reply-To: <20190927072431.23901-2-ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dave Chinner <dchinner@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
References: <20190927072431.23901-1-ming.lei@redhat.com>
 <20190927072431.23901-2-ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_9E9A5CF9-8C2C-4B51-8C10-39EFC67B87B3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Sep 2019, at 09.24, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> Now in case of real MQ, io scheduler may be bypassed, and not only =
this
> way may hurt performance for some slow MQ device, but also break zoned
> device which depends on mq-deadline for respecting the write order in
> one zone.
>=20
> So don't bypass io scheduler if we have one setup.
>=20
> This patch can double sequential write performance basically on MQ
> scsi_debug when mq-deadline is applied.
>=20
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> block/blk-mq.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 20a49be536b5..d7aed6518e62 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2003,6 +2003,8 @@ static blk_qc_t blk_mq_make_request(struct =
request_queue *q, struct bio *bio)
> 		}
>=20
> 		blk_add_rq_to_plug(plug, rq);
> +	} else if (q->elevator) {
> +		blk_mq_sched_insert_request(rq, false, true, true);
> 	} else if (plug && !blk_queue_nomerges(q)) {
> 		/*
> 		 * We do limited plugging. If the bio can be merged, do =
that.
> @@ -2026,8 +2028,8 @@ static blk_qc_t blk_mq_make_request(struct =
request_queue *q, struct bio *bio)
> 			blk_mq_try_issue_directly(data.hctx, =
same_queue_rq,
> 					&cookie);
> 		}
> -	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
> -			!data.hctx->dispatch_busy)) {
> +	} else if ((q->nr_hw_queues > 1 && is_sync) ||
> +			!data.hctx->dispatch_busy) {
> 		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
> 	} else {
> 		blk_mq_sched_insert_request(rq, false, true, true);
> --
> 2.20.1


Looks good to me. Fixes a couple issues we have seen with zoned devices =
too.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_9E9A5CF9-8C2C-4B51-8C10-39EFC67B87B3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAl2N6FMACgkQPEYBfS0l
eOABwQ//cIngw7uBAkc9bZItObl/cdXIqvFJ9f6ls3KPBqTAbQg80WhjcxdBqE1Z
IZvaq4Ggjkr48c4tLUsLF2YdlW1pv8SPiJlUL9+DLfEqq/CH0CuGtj/QE1foPxNa
k7P0Pb8WixnF2xG1cG/+Vk7z3K8ZS49Tlr8fd9ksBypozO21syhSJTXfWWKGMB28
EDnW/FRdPGGg2yO83i95boPPjkSmRwfpIBn/1lCZm12oogb+U1H3wScWuK1zZbI1
9v/Asd4Cz2qq0/lmkNwMV2Q9sju6+ze/0RKESEib2TUiMqz4EtJpARw+tXginYjg
ZJNnq3kpvftnptGS3U62+2DG2FwCVAaerJNSozU+vh8NUIPakcX0NG7Kyp/3IjYn
7DDkFhdyh6e3CftyvuVax7yw8g7Cu7wGBfc3uPhzK1Zj99GazKbK0SA6UEXb+Zo8
FriOPjK1/4rPavDez9Yp+SkBlhktLAfAm4QAR+B70SF56B57uF20QDFZ7kirsgvI
ZQGaG6zW2G3bnTd1iJOEyJ/qtJjOBMcYTwNyCeTzfOh9MQwZgnTeIQI2zSBrcaCr
qMoWSHyuzKtTrOOypJ3gaVuz7PsGWv2itLczZoorsP2LfPeDGaSGQe/hxDu4l2oh
IiPIrMptQJzt9KkN09F1DMg/k+jUuCpCoQUfnL5a/TaZy9x8C6Y=
=dcA5
-----END PGP SIGNATURE-----

--Apple-Mail=_9E9A5CF9-8C2C-4B51-8C10-39EFC67B87B3--
