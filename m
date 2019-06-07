Return-Path: <SRS0=19b2=UG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56001C2BCA1
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 12:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A02212F5
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 12:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="fougVQBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfFGM5Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:57:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46920 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfFGM5Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jun 2019 08:57:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id h10so2861565edi.13
        for <linux-block@vger.kernel.org>; Fri, 07 Jun 2019 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=hoUx8jm9U0EqhtodQP7NyWM7PbHUgWTmjcaE/ynWwWo=;
        b=fougVQBpc31Vqhze0JA1HQq5eVutmwIGVG9Mw6h8DGz5rYs0s3Ps3viJhp5hRy74+8
         pccX7gFp4EW38fGEhUzDFk+eKrYZT60iUSXWzPr4iBCd/ql9RoLMpn8l7WTCTpmHExtQ
         bu5HUFtgQxMxGWuXZ+6EXO1V+mYs9X8PwWCQ/j1WkUzIBiGB2bWMqdk6buFtFMvLYizK
         PT8f6N9hSzZCCesY74/ku5yh9JOa709E7SbLaZqOxBqxM+DeUalqiYqir9TGlXkToOdz
         e69PUz6VS2CwE7A4/bAChVYjB99NAVUSY9EOEBlJb7sF5PBY4v3aePlTHk3NfmekdkkM
         r5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=hoUx8jm9U0EqhtodQP7NyWM7PbHUgWTmjcaE/ynWwWo=;
        b=MXi67fnKuWBKts4HayPmxIHyKFj3gNGo302NhkC7ANdZZtfthqUT60L93RPEkCxQE6
         ae23cj+f1ysXNPRt12IR0+uVf234GTin0h09saGBQCT8IM6Wj55QSwyI7JRC/J6gkK9x
         /okOyDx4ghcHcqW1956ZcWOQ43AnEI6ukbLfOmsKx6NQvD0Y/jh6L/tR1EPp1tzruJBV
         A7HTFhYBjUOsESuikYtHHri8O5YdCOo7GkzUIyVAR5tQ7/KDAJUIjFTBxL1hS1byhDuB
         5RBXc8QP/xnDNcDfO+i4GdElQcdZdIw5XcBTc6QsBWWPgk6xT0l42aX/Nw4OKAJFm/t+
         5kcw==
X-Gm-Message-State: APjAAAUg25yAYwBok9ZioRUG5xWzfSEpat/IP98cD+p/2O2YFGXA5Ly1
        MSfDzVJ3+fO9u++WhPhCEUmmzA==
X-Google-Smtp-Source: APXvYqy1VcGiXxKyrVtK4msfJH/DO6w32BSeE7hoCHmhVGIT7izhgrCTwOd5MpuW4uXrcvbDa0U8Pg==
X-Received: by 2002:a17:906:27d9:: with SMTP id k25mr5536186ejc.194.1559912234074;
        Fri, 07 Jun 2019 05:57:14 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id u1sm361781ejk.28.2019.06.07.05.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 05:57:13 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <BB0234C2-A7A4-4503-8598-64D6FA9D79F6@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_37EC1062-498E-42E7-912F-6DAC0CF9513D";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/6] block: remove blk_init_request_from_bio
Date:   Fri, 7 Jun 2019 14:57:12 +0200
In-Reply-To: <20190606102904.4024-3-hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org
To:     Christoph Hellwig <hch@lst.de>
References: <20190606102904.4024-1-hch@lst.de>
 <20190606102904.4024-3-hch@lst.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_37EC1062-498E-42E7-912F-6DAC0CF9513D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 6 Jun 2019, at 12.29, Christoph Hellwig <hch@lst.de> wrote:
>=20
> lightnvm should have never used this function, as it is sending
> passthrough requests, so switch it to blk_rq_append_bio like all the
> other passthrough request users.  Inline blk_init_request_from_bio =
into
> the only remaining caller.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> block/blk-core.c             | 11 -----------
> block/blk-mq.c               |  7 ++++++-
> drivers/nvme/host/lightnvm.c |  2 +-
> include/linux/blkdev.h       |  1 -
> 4 files changed, 7 insertions(+), 14 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9b88b1a3eb43..a9cb465c7ef7 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -674,17 +674,6 @@ bool blk_attempt_plug_merge(struct request_queue =
*q, struct bio *bio,
> 	return false;
> }
>=20
> -void blk_init_request_from_bio(struct request *req, struct bio *bio)
> -{
> -	if (bio->bi_opf & REQ_RAHEAD)
> -		req->cmd_flags |=3D REQ_FAILFAST_MASK;
> -
> -	req->__sector =3D bio->bi_iter.bi_sector;
> -	req->write_hint =3D bio->bi_write_hint;
> -	blk_rq_bio_prep(req->q, req, bio);
> -}
> -EXPORT_SYMBOL_GPL(blk_init_request_from_bio);
> -
> static void handle_bad_sector(struct bio *bio, sector_t maxsector)
> {
> 	char b[BDEVNAME_SIZE];
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ce0f5f4ede70..61457bffa55f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1766,7 +1766,12 @@ void blk_mq_flush_plug_list(struct blk_plug =
*plug, bool from_schedule)
>=20
> static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
> {
> -	blk_init_request_from_bio(rq, bio);
> +	if (bio->bi_opf & REQ_RAHEAD)
> +		rq->cmd_flags |=3D REQ_FAILFAST_MASK;
> +
> +	rq->__sector =3D bio->bi_iter.bi_sector;
> +	rq->write_hint =3D bio->bi_write_hint;
> +	blk_rq_bio_prep(rq->q, rq, bio);
>=20
> 	blk_account_io_start(rq, true);
> }
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index 4f20a10b39d3..ba009d4c9dfa 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -660,7 +660,7 @@ static struct request =
*nvme_nvm_alloc_request(struct request_queue *q,
> 	rq->cmd_flags &=3D ~REQ_FAILFAST_DRIVER;
>=20
> 	if (rqd->bio)
> -		blk_init_request_from_bio(rq, rqd->bio);
> +		blk_rq_append_bio(rq, &rqd->bio);
> 	else
> 		rq->ioprio =3D IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, =
IOPRIO_NORM);
>=20
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 592669bcc536..c67a9510e532 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -828,7 +828,6 @@ extern void blk_unregister_queue(struct gendisk =
*disk);
> extern blk_qc_t generic_make_request(struct bio *bio);
> extern blk_qc_t direct_make_request(struct bio *bio);
> extern void blk_rq_init(struct request_queue *q, struct request *rq);
> -extern void blk_init_request_from_bio(struct request *req, struct bio =
*bio);
> extern void blk_put_request(struct request *);
> extern struct request *blk_get_request(struct request_queue *, =
unsigned int op,
> 				       blk_mq_req_flags_t flags);
> --
> 2.20.1


Looks good.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_37EC1062-498E-42E7-912F-6DAC0CF9513D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlz6XygACgkQPEYBfS0l
eOCs4Q/9ENBxvVxpi9eHenUSrpxNT3UJrlYgAn1CSlskql0j3pExgdN2xh/xj116
b0pTlgQmCGWXCqG4y2pQfCGbnqMIEXlwCsBLgxHkKBwI3diMQ5MewqCYAr9/yklY
NBep94M32XdwPTrGnNGImB+he//Ju8Yjvbl3AQGBbUaHIWw418ykv/ELMJeqTKDb
gciC5MLCqXRkDnX5k7CSnvjoHY4PolFhLRx2X9JjTJfUf5MzqrWwp7FX61ztoZ4O
iWDW3HkRUHZVEb5fWhqczTVeQ3GlfTZpr+RI4DVYty0SOS4HbpFh0smB5y79ohDm
0VZmkWqedZYi65635DXQEIYmt/370E5C3DR77oFQgEvp58UOKujN8cDevOpl5B0F
+ydq1R3TO7CMETO2iQECIswgf1xmjb08nN1dDF6xYLP2VTeToC+wBe0QB7tO8FRx
irTyxUX4gkHGPi5J+8UGlBalKT/zgR6qSLYQl2YsBsSk0QmKe8IsjKFDGmhA7ym/
mOOOeWVyQ5fwDevwueMEEuRe7+81/mqdOgU2H2W7ZVTbdj3uFFgnrzat+FnNQ03w
4IEFnN0zEnAemHCPG2FsdD1cp9vxpP3lahLHnC8CmMZsFkaV1cVdCMQXJPi+i0/u
idF48qV5h0MbccnNsTda4k3ZtIDldJMOmC44vRr4YAYNi2Hfdsw=
=lGuj
-----END PGP SIGNATURE-----

--Apple-Mail=_37EC1062-498E-42E7-912F-6DAC0CF9513D--
