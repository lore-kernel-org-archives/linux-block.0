Return-Path: <SRS0=ocky=TZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E858BC282CE
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 11:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F7F2168B
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 11:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6GC0WAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfEYLqZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 May 2019 07:46:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44150 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfEYLqY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 May 2019 07:46:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id n134so8927781lfn.11
        for <linux-block@vger.kernel.org>; Sat, 25 May 2019 04:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=Hzqf+AYsGils8dVi1iytRQRIfNKqCUE1eBHueiYUIx4=;
        b=F6GC0WACJzZW3MYzK53dWLJblTzxxCfLHFYQ9/0rTyr3Vk50QHBMVXLfX0dgVbWini
         hMYGjgeMAw+74uGNxxXlXXnoZz6FwkPMzYTO2QkFZd9YJw+bbto2PDO+LD82CY/K9EPI
         2H/qq3mgdTegdfT9QkiBP6Spd2nS7MhWuQW70jotrMbaiz69BvxmJUN5Se8dl//Vtn5q
         NkPuEZ530pf7Gq53F8b90S2OM4L9kUwZuB451cgd/E08g1ptWzbc5F9WUVCUfm9ex5Dq
         s4fer5H03ZpEN9c7rEShamXnbJ7ET8VktvpAFTIK+9X+2r0ekzBbpp6zHmAbRMe6VCKn
         XP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=Hzqf+AYsGils8dVi1iytRQRIfNKqCUE1eBHueiYUIx4=;
        b=LgX0teHPA3X0HFpILYx6Zu8ZhpnpSj3gce41Mjwf7y2V8Kuo10RqOyrfNYlfux4Gu5
         N1xsmRkpK8RN+0zsDkgxfLpFn6CqYEKQjIY1HBLf5EgrdrCGlnGYhAZe6typ1CgIRkSs
         V2B0bbI/8SCr8ODPQjNTOrkVPKjZaL3e+RKmE6xmeI8YfHQP2Uf9HQVQs800hksNAvLh
         j64Pkyt9uiRoZEU+vSFojB+dG6eD59AxCpxtbHOwKY5qckewgpzETZpLGMdzC0OiUyXF
         u9/PUcKRxWkxeLXaoLvepBoHX3J5fGxFddtSVGRLJkBxmWDNUVbe6WMyrLB/T4NgsixN
         PvXQ==
X-Gm-Message-State: APjAAAUiigVmvaJWryodLq4Rr5dFHNEI1PJvASPMWbD0JFjEuoTohElz
        al1JB2fqMwoK/4m5xV6BQ6I=
X-Google-Smtp-Source: APXvYqxUyLr2lIEeGh5dmZpuqAnGQXOnxrzBIRIQdDtlXkyfyyULl5EeVXyPK0cQ9mniHzCujxfb4Q==
X-Received: by 2002:a19:6703:: with SMTP id b3mr18664965lfc.153.1558784782159;
        Sat, 25 May 2019 04:46:22 -0700 (PDT)
Received: from [192.168.100.101] (mm-78-96-44-37.mgts.dynamic.pppoe.byfly.by. [37.44.96.78])
        by smtp.gmail.com with ESMTPSA id k21sm1252157lji.81.2019.05.25.04.46.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 04:46:21 -0700 (PDT)
To:     Hou Tao <houtao1@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     osandov@fb.com, ming.lei@redhat.com
References: <20190521075904.135060-1-houtao1@huawei.com>
 <20190521075904.135060-2-houtao1@huawei.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 1/2] block: make rq sector size accessible for block stats
Message-ID: <76a679b4-cd55-8bca-0020-fb320914f491@gmail.com>
Date:   Sat, 25 May 2019 14:46:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521075904.135060-2-houtao1@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oCjwihpbbVpBdFUZe28PfWGFintMfYMEb"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oCjwihpbbVpBdFUZe28PfWGFintMfYMEb
Content-Type: multipart/mixed; boundary="yu1a7xTTS5W8N5A205b2TeLAjP1x5RHNO";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Hou Tao <houtao1@huawei.com>, axboe@kernel.dk, linux-block@vger.kernel.org
Cc: osandov@fb.com, ming.lei@redhat.com
Message-ID: <76a679b4-cd55-8bca-0020-fb320914f491@gmail.com>
Subject: Re: [PATCH 1/2] block: make rq sector size accessible for block stats
References: <20190521075904.135060-1-houtao1@huawei.com>
 <20190521075904.135060-2-houtao1@huawei.com>
In-Reply-To: <20190521075904.135060-2-houtao1@huawei.com>

--yu1a7xTTS5W8N5A205b2TeLAjP1x5RHNO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

That's the same bug I posted a patch about 3+ weeks ago. No answer yet,
however.
https://www.spinics.net/lists/linux-block/msg40049.html

I think putting time sampling at __blk_mq_end_request() won't give
sufficient precision for more sophisticated hybrid polling, because path
__blk_mq_complete_request() -> __blk_mq_end_request() adds a lot of
overhead (redirect rq to another cpu, dma unmap, etc). That's the case
for mentioned patchset
https://www.spinics.net/lists/linux-block/msg40044.html

It works OK for 50-80us requests (e.g. SSD read), but is not good enough
for 20us and less (e.g. SSD write). I think it would be better to save
the time in advance, and use it later.

By the way, it seems, that __blk_mq_end_request() is really better place
to record stats, as not all drivers use __blk_mq_complete_request(),
even though they don't implement blk_poll().


On 21/05/2019 10:59, Hou Tao wrote:
> Currently rq->data_len will be decreased by partial completion or
> zeroed by completion, so when blk_stat_add() is invoked, data_len
> will be zero and there will never be samples in poll_cb because
> blk_mq_poll_stats_bkt() will return -1 if data_len is zero.
>=20
> We could move blk_stat_add() back to __blk_mq_complete_request(),
> but that would make the effort of trying to call ktime_get_ns()
> once in vain. Instead we can reuse throtl_size field, and use
> it for both block stats and block throttle, and adjust the
> logic in blk_mq_poll_stats_bkt() accordingly.
>=20
> Fixes: 4bc6339a583c ("block: move blk_stat_add() to __blk_mq_end_reques=
t()")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  block/blk-mq.c         | 11 +++++------
>  block/blk-throttle.c   |  3 ++-
>  include/linux/blkdev.h | 15 ++++++++++++---
>  3 files changed, 19 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 08a6248d8536..4d1462172f0f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -44,12 +44,12 @@ static void blk_mq_poll_stats_fn(struct blk_stat_ca=
llback *cb);
> =20
>  static int blk_mq_poll_stats_bkt(const struct request *rq)
>  {
> -	int ddir, bytes, bucket;
> +	int ddir, sectors, bucket;
> =20
>  	ddir =3D rq_data_dir(rq);
> -	bytes =3D blk_rq_bytes(rq);
> +	sectors =3D blk_rq_stats_sectors(rq);
> =20
> -	bucket =3D ddir + 2*(ilog2(bytes) - 9);
> +	bucket =3D ddir + 2 * ilog2(sectors);
> =20
>  	if (bucket < 0)
>  		return -1;
> @@ -329,6 +329,7 @@ static struct request *blk_mq_rq_ctx_init(struct bl=
k_mq_alloc_data *data,
>  	else
>  		rq->start_time_ns =3D 0;
>  	rq->io_start_time_ns =3D 0;
> +	rq->stats_sectors =3D 0;
>  	rq->nr_phys_segments =3D 0;
>  #if defined(CONFIG_BLK_DEV_INTEGRITY)
>  	rq->nr_integrity_segments =3D 0;
> @@ -678,9 +679,7 @@ void blk_mq_start_request(struct request *rq)
> =20
>  	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
>  		rq->io_start_time_ns =3D ktime_get_ns();
> -#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
> -		rq->throtl_size =3D blk_rq_sectors(rq);
> -#endif
> +		rq->stats_sectors =3D blk_rq_sectors(rq);
>  		rq->rq_flags |=3D RQF_STATS;
>  		rq_qos_issue(q, rq);
>  	}
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 1b97a73d2fb1..88459a4ac704 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2249,7 +2249,8 @@ void blk_throtl_stat_add(struct request *rq, u64 =
time_ns)
>  	struct request_queue *q =3D rq->q;
>  	struct throtl_data *td =3D q->td;
> =20
> -	throtl_track_latency(td, rq->throtl_size, req_op(rq), time_ns >> 10);=

> +	throtl_track_latency(td, blk_rq_stats_sectors(rq), req_op(rq),
> +			     time_ns >> 10);
>  }
> =20
>  void blk_throtl_bio_endio(struct bio *bio)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1aafeb923e7b..68a0841d3554 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -202,9 +202,12 @@ struct request {
>  #ifdef CONFIG_BLK_WBT
>  	unsigned short wbt_flags;
>  #endif
> -#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
> -	unsigned short throtl_size;
> -#endif
> +	/*
> +	 * rq sectors used for blk stats. It has the same value
> +	 * with blk_rq_sectors(rq), except that it never be zeroed
> +	 * by completion.
> +	 */
> +	unsigned short stats_sectors;
> =20
>  	/*
>  	 * Number of scatter-gather DMA addr+len pairs after
> @@ -892,6 +895,7 @@ static inline struct request_queue *bdev_get_queue(=
struct block_device *bdev)
>   * blk_rq_err_bytes()		: bytes left till the next error boundary
>   * blk_rq_sectors()		: sectors left in the entire request
>   * blk_rq_cur_sectors()		: sectors left in the current segment
> + * blk_rq_stats_sectors()	: sectors of the entire request used for sta=
ts
>   */
>  static inline sector_t blk_rq_pos(const struct request *rq)
>  {
> @@ -920,6 +924,11 @@ static inline unsigned int blk_rq_cur_sectors(cons=
t struct request *rq)
>  	return blk_rq_cur_bytes(rq) >> SECTOR_SHIFT;
>  }
> =20
> +static inline unsigned int blk_rq_stats_sectors(const struct request *=
rq)
> +{
> +	return rq->stats_sectors;
> +}
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static inline unsigned int blk_rq_zone_no(struct request *rq)
>  {
>=20

--=20
Yours sincerely,
Pavel Begunkov


--yu1a7xTTS5W8N5A205b2TeLAjP1x5RHNO--

--oCjwihpbbVpBdFUZe28PfWGFintMfYMEb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAlzpKwsACgkQWt5b1Glr
+6WVnQ//ch8quE8P8K1TwQjMEKZVl4Ci1uEwsyU8L1jOrTThzWQHBmPfYSzidTqd
cvM3hpfx58B8DwG1Ihkh32yYx2S+JfEDm4JrSXHDxDqYhhjqj22MagyqHRG9QzCi
WQ6PH0Un14tELNdKA7DljPASEGnAlsOv9QSmlSSKZEHWXMyPnnf4/qxZxngidfek
N3P9e5o3s4PUw0PPePRyomU0peE5apshW9gQYv9rffnSxnK7TWH8jtWeDlCK6b2V
WQ8yr9D5KCN2kgYMDijRyGpxyNHIdFBMUOQs05+Ppdqij0hSWnygjKpW0XJa2my9
+vm5hB2zjkZ8FEtd9hnqGIicIxODD7FJkAolBMU02mQHmWLyc6+gHJT2qMaDHeH+
hH8tbVFYWUGrVNLqZJ+pb9JHvYvrizQqova7TUm6PVhNcpS8X1ppOGr6OUl9E7Ay
lCYNPPF+RKIIsbVcFtY9gdzGxXGqKka6OtSmK1xDWhG+rWmSElhn4ZihLS0Ca424
d7pYUXA3DR06/aWghNE0qVoLfhZiISjw3y9Fsg3vkSL80HWcpG5zqp3dRbg/UuCq
PR2mM2dbOX0s1KzbH5GacrwkKmxBd8I0a4PmoLsDJfHZnbsRoOKJc8G0xc2rsIag
H4xApDavNDm8pieQvAV7zj9bh2WQMlSJ6SIyJgjKFmty8YdeoJQ=
=yO77
-----END PGP SIGNATURE-----

--oCjwihpbbVpBdFUZe28PfWGFintMfYMEb--
