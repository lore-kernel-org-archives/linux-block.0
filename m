Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDF2C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 08:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiBOIet (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:34:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiBOIet (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 03:34:49 -0500
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91925C3312
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 00:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=Xfwq0
        Miy8wMhAX3BGV+dvwmTSyWPzsFr/ZFFtiazrzY=; b=XxNiaKLalM64jG/bs1Eiz
        EEnkOqx/SQ/j/aqrZjxPNP0rQL+BqVmnlkKT/6pzp4C3lgz2fETixXead4qp1CoR
        NniE7qFVdSKIhy9ka2lwfDy7VgIVK9X3JIuVrD98BhZT3bfj90zK5QQ7noQBJNFn
        oNXyp5AAqta573GVKMWJRI=
Received: from smtpclient.apple (unknown [117.89.15.89])
        by smtp10 (Coremail) with SMTP id DsCowAAnvjagYQti4TnlDA--.27048S3;
        Tue, 15 Feb 2022 16:17:37 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH V2 5/7] block: throttle split bio in case of iops limit
From:   Ning Li <lining2020x@163.com>
In-Reply-To: <20220209091429.1929728-6-ming.lei@redhat.com>
Date:   Tue, 15 Feb 2022 16:17:33 +0800
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <42D97969-47DA-4EF7-B934-D3914F2FAD5D@163.com>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
 <20220209091429.1929728-6-ming.lei@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-CM-TRANSID: DsCowAAnvjagYQti4TnlDA--.27048S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF1rGF4kWrW3uw45Ww18AFb_yoWrXr45pF
        yxuFn8Wr4vgr4vgF13JF1aqFyFyw47Gry5C398Gw4YyFnI9rnFyrn7Zry8ZayF9FZ3CF48
        ZF1vgr97Ga1UGrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uio7_UUUUU=
X-Originating-IP: [117.89.15.89]
X-CM-SenderInfo: polqx0bjsqjir06rljoofrz/1tbixgGoNl3brRh1PQAAsi
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If where will be one more version of this patchset, please update my =
sign with

`Ning Li <lining@2020x@163.com>`.  : )

Thanks=20


> 2022=E5=B9=B42=E6=9C=889=E6=97=A5 =E4=B8=8B=E5=8D=885:14=EF=BC=8CMing =
Lei <ming.lei@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Commit 111be8839817 ("block-throttle: avoid double charge") marks bio =
as
> BIO_THROTTLED unconditionally if __blk_throtl_bio() is called on this =
bio,
> then this bio won't be called into __blk_throtl_bio() any more. This =
way
> is to avoid double charge in case of bio splitting. It is reasonable =
for
> read/write throughput limit, but not reasonable for IOPS limit because
> block layer provides io accounting against split bio.
>=20
> Chunguang Xu has already observed this issue and fixed it in commit
> 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO =
scenarios").
> However, that patch only covers bio splitting in __blk_queue_split(), =
and
> we have other kind of bio splitting, such as bio_split() &
> submit_bio_noacct() and other ways.
>=20
> This patch tries to fix the issue in one generic way by always =
charging
> the bio for iops limit in blk_throtl_bio(). This way is reasonable:
> re-submission & fast-cloned bio is charged if it is submitted to same
> disk/queue, and BIO_THROTTLED will be cleared if bio->bi_bdev is =
changed.
>=20
> This new approach can get much more smooth/stable iops limit compared =
with
> commit 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO
> scenarios") since that commit can't throttle current split bios =
actually.
>=20
> Also this way won't cause new double bio iops charge in
> blk_throtl_dispatch_work_fn() in which blk_throtl_bio() won't be =
called
> any more.
>=20
> Reported-by: Li Ning <lining2020x@163.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Chunguang Xu <brookxu@tencent.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> block/blk-merge.c    |  2 --
> block/blk-throttle.c | 10 +++++++---
> block/blk-throttle.h |  2 --
> 3 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 4de34a332c9f..f5255991b773 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -368,8 +368,6 @@ void __blk_queue_split(struct request_queue *q, =
struct bio **bio,
> 		trace_block_split(split, (*bio)->bi_iter.bi_sector);
> 		submit_bio_noacct(*bio);
> 		*bio =3D split;
> -
> -		blk_throtl_charge_bio_split(*bio);
> 	}
> }
>=20
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 6cca1715c31e..6f2a8e7801fe 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -808,7 +808,8 @@ static bool tg_with_in_bps_limit(struct throtl_grp =
*tg, struct bio *bio,
> 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
> 	unsigned int bio_size =3D throtl_bio_data_size(bio);
>=20
> -	if (bps_limit =3D=3D U64_MAX) {
> +	/* no need to throttle if this bio's bytes have been accounted =
*/
> +	if (bps_limit =3D=3D U64_MAX || bio_flagged(bio, BIO_THROTTLED)) =
{
> 		if (wait)
> 			*wait =3D 0;
> 		return true;
> @@ -920,9 +921,12 @@ static void throtl_charge_bio(struct throtl_grp =
*tg, struct bio *bio)
> 	unsigned int bio_size =3D throtl_bio_data_size(bio);
>=20
> 	/* Charge the bio to the group */
> -	tg->bytes_disp[rw] +=3D bio_size;
> +	if (!bio_flagged(bio, BIO_THROTTLED)) {
> +		tg->bytes_disp[rw] +=3D bio_size;
> +		tg->last_bytes_disp[rw] +=3D bio_size;
> +	}
> +
> 	tg->io_disp[rw]++;
> -	tg->last_bytes_disp[rw] +=3D bio_size;
> 	tg->last_io_disp[rw]++;
>=20
> 	/*
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 175f03abd9e4..cb43f4417d6e 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -170,8 +170,6 @@ static inline bool blk_throtl_bio(struct bio *bio)
> {
> 	struct throtl_grp *tg =3D blkg_to_tg(bio->bi_blkg);
>=20
> -	if (bio_flagged(bio, BIO_THROTTLED))
> -		return false;
> 	if (!tg->has_rules[bio_data_dir(bio)])
> 		return false;
>=20
> --=20
> 2.31.1

