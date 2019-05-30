Return-Path: <SRS0=WD2t=T6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2590C28CC0
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 09:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AC9253BD
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 09:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US3LqS+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfE3JTO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 05:19:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53762 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfE3JTL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 05:19:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id d17so3464698wmb.3;
        Thu, 30 May 2019 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=XwvjD0+tQchJNATBLZlwVS2b5f1Akjy2mn0CYq6xgcc=;
        b=US3LqS+h1n9/KdH2tJ6YHQkS1SUX63V8hl+YijQtCSMV4yDSetFjVGi+U1Rn7o8QuS
         e3IngcfMQKLEqmtheRAzdyQlmt+we6PPzDtGxZn8zrb1G4kTa23N0iOJ032GT4lwL4l/
         h5nTLaHMT+YzwXCwaRCduD3W/TRVqm2wPe9RAsw5kStvHp2fxMZez2GZ6YffRaIWVTXf
         o71ktSKx0Cnd4ERH5ZsudXuQDB1EhU8dVWqRDZDNtEeFt6U1jtXdiV+qUVitQiFno6ye
         7CWl/dVTlgg+fa0fh5Ix1WS8lzr3YLqOJXXq3iEhdPfz4RuPCVjqSczjM6QdQFwb5JwU
         20JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=XwvjD0+tQchJNATBLZlwVS2b5f1Akjy2mn0CYq6xgcc=;
        b=oHVMPqdEglXvwRJ8B4ACWBSyXQBG8kUBSIrlsGGdHnhJC7RpCMvncnqATomMSOrczq
         +SV/6rpuTxrcg/CRNh1OODqGdFl5PJdKSFJmbLRmrRz8dGYPN808CDp230QvqhEKiqn0
         r8gloJYvUKorEabIWQOYj0bvNA9VzO8zUnDieefb93xGlEO1mzRURP6gn9Z8qzxCI30a
         XRSzLm4+oR2ec7Nv8NRQseCJRZigAh9FCEFbUo36P2Mf0isTpxRXu0J8j6ul/XXdhg8+
         cGzyWo7YQXo/0aPG9U2wu6n30e+OxmmifR62HdhP62UGafkNZplkzcOXo76LtqTj7JEG
         gVPA==
X-Gm-Message-State: APjAAAUgqcJGd8eq0ZPyyyoN+Gr3nYlOVRo/yx9Z3W4L8h5IYcViaYQI
        teXjTZPvEctXFZJ6NhRXEQE=
X-Google-Smtp-Source: APXvYqzoQxOklGT4gUYxSheA7XUrb8T81I85fnjQSX0cCxYHjwooKGd0tOVkhnCk67iiGQKT0ikg/w==
X-Received: by 2002:a7b:c933:: with SMTP id h19mr1677397wml.52.1559207949334;
        Thu, 30 May 2019 02:19:09 -0700 (PDT)
Received: from [192.168.43.7] ([109.126.142.5])
        by smtp.gmail.com with ESMTPSA id f65sm2297255wmg.45.2019.05.30.02.19.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 02:19:08 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@fb.com, ming.lei@redhat.com,
        Hou Tao <houtao1@huawei.com>
References: <dd30f4d94aa19956ad4500b1177741fd071ec37f.1558791181.git.asml.silence@gmail.com>
 <20190528183726.GA25022@vader>
Openpgp: preference=signencrypt
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 1/1] blk-mq: Fix disabled hybrid polling
Message-ID: <9a50a87e-e37e-f5f3-90b1-8599a71ad706@gmail.com>
Date:   Thu, 30 May 2019 12:19:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528183726.GA25022@vader>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YGz42mCsFGMGguNSAU7zC7fPU5mBliGzz"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YGz42mCsFGMGguNSAU7zC7fPU5mBliGzz
Content-Type: multipart/mixed; boundary="hsCjCnXVnYUwQsGQbElQ7xmTxgMi9asiu";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, osandov@fb.com, ming.lei@redhat.com,
 Hou Tao <houtao1@huawei.com>
Message-ID: <9a50a87e-e37e-f5f3-90b1-8599a71ad706@gmail.com>
Subject: Re: [PATCH 1/1] blk-mq: Fix disabled hybrid polling
References: <dd30f4d94aa19956ad4500b1177741fd071ec37f.1558791181.git.asml.silence@gmail.com>
 <20190528183726.GA25022@vader>
In-Reply-To: <20190528183726.GA25022@vader>

--hsCjCnXVnYUwQsGQbElQ7xmTxgMi9asiu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/28/2019 9:37 PM, Omar Sandoval wrote:
> On Sat, May 25, 2019 at 04:42:11PM +0300, Pavel Begunkov (Silence) wrot=
e:
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> Commit 4bc6339a583cec650b05 ("block: move blk_stat_add() to
>> __blk_mq_end_request()") moved blk_stat_add(), so now it's called afte=
r
>> blk_update_request(), which zeroes rq->__data_len. Without length,
>> blk_stat_add() can't calculate stat bucket and returns error,
>> effectively disabling hybrid polling.
>=20
> I don't see how this patch fixes this problem, am I missing something?
> The timing issue seems orthogonal.
You're right, it got completely mixed up. It's rather an addition to a
patch from Hou Tao. But considering your comment below, it would be
better just to revert part of changes.


>=20
>> __blk_mq_end_request() is a right place to call blk_stat_add(), as it'=
s
>> guaranteed to be called for each request. Yet, calculating time there
>> won't provide sufficient accuracy/precision for finer tuned hybrid
>> polling, because a path from __blk_mq_complete_request() to
>> __blk_mq_end_request() adds unpredictable overhead.
>>
>> Add io_end_time_ns field in struct request, save time as soon as
>> possible (at __blk_mq_complete_request()) and reuse later.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>  block/blk-mq.c         | 13 ++++++++++---
>>  block/blk-stat.c       |  4 ++--
>>  block/blk-stat.h       |  2 +-
>>  include/linux/blkdev.h | 11 +++++++++++
>>  4 files changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 32b8ad3d341b..8f6b6bfe0ccb 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -330,6 +330,7 @@ static struct request *blk_mq_rq_ctx_init(struct b=
lk_mq_alloc_data *data,
>>  	else
>>  		rq->start_time_ns =3D 0;
>>  	rq->io_start_time_ns =3D 0;
>> +	rq->io_end_time_ns =3D 0;
>>  	rq->nr_phys_segments =3D 0;
>>  #if defined(CONFIG_BLK_DEV_INTEGRITY)
>>  	rq->nr_integrity_segments =3D 0;
>> @@ -532,14 +533,17 @@ EXPORT_SYMBOL_GPL(blk_mq_free_request);
>> =20
>>  inline void __blk_mq_end_request(struct request *rq, blk_status_t err=
or)
>>  {
>> -	u64 now =3D 0;
>> +	u64 now =3D rq->io_end_time_ns;
>=20
> Kyber expects the timestamp passed in to kyber_complete_request() to
> include the software overhead. iostat should probably include the
> software overhead, too. So, we probably won't be able to avoid calling
> ktime_get() twice, once for I/O time and one for the end-to-end time.

I asked that in another thread, and it seems we can't reuse this.



>=20
>> -	if (blk_mq_need_time_stamp(rq))
>> +	/* called directly bypassing __blk_mq_complete_request */
>> +	if (blk_mq_need_time_stamp(rq) && !now) {
>>  		now =3D ktime_get_ns();
>> +		rq->io_end_time_ns =3D now;
>> +	}
>> =20
>>  	if (rq->rq_flags & RQF_STATS) {
>>  		blk_mq_poll_stats_start(rq->q);
>> -		blk_stat_add(rq, now);
>> +		blk_stat_add(rq);
>>  	}
>> =20
>>  	if (rq->internal_tag !=3D -1)
>> @@ -579,6 +583,9 @@ static void __blk_mq_complete_request(struct reque=
st *rq)
>>  	bool shared =3D false;
>>  	int cpu;
>> =20
>> +	if (blk_mq_need_time_stamp(rq))
>> +		rq->io_end_time_ns =3D ktime_get_ns();
>> +
>>  	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>>  	/*
>>  	 * Most of single queue controllers, there is only one irq vector
>> diff --git a/block/blk-stat.c b/block/blk-stat.c
>> index 940f15d600f8..9b9b30927ea8 100644
>> --- a/block/blk-stat.c
>> +++ b/block/blk-stat.c
>> @@ -48,7 +48,7 @@ void blk_rq_stat_add(struct blk_rq_stat *stat, u64 v=
alue)
>>  	stat->nr_samples++;
>>  }
>> =20
>> -void blk_stat_add(struct request *rq, u64 now)
>> +void blk_stat_add(struct request *rq)
>>  {
>>  	struct request_queue *q =3D rq->q;
>>  	struct blk_stat_callback *cb;
>> @@ -56,7 +56,7 @@ void blk_stat_add(struct request *rq, u64 now)
>>  	int bucket;
>>  	u64 value;
>> =20
>> -	value =3D (now >=3D rq->io_start_time_ns) ? now - rq->io_start_time_=
ns : 0;
>> +	value =3D blk_rq_io_time(rq);
>> =20
>>  	blk_throtl_stat_add(rq, value);
>> =20
>> diff --git a/block/blk-stat.h b/block/blk-stat.h
>> index 17b47a86eefb..2653818cee36 100644
>> --- a/block/blk-stat.h
>> +++ b/block/blk-stat.h
>> @@ -65,7 +65,7 @@ struct blk_stat_callback {
>>  struct blk_queue_stats *blk_alloc_queue_stats(void);
>>  void blk_free_queue_stats(struct blk_queue_stats *);
>> =20
>> -void blk_stat_add(struct request *rq, u64 now);
>> +void blk_stat_add(struct request *rq);
>> =20
>>  /* record time/size info in request but not add a callback */
>>  void blk_stat_enable_accounting(struct request_queue *q);
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 592669bcc536..2a8d4b68d707 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -198,6 +198,9 @@ struct request {
>>  	u64 start_time_ns;
>>  	/* Time that I/O was submitted to the device. */
>>  	u64 io_start_time_ns;
>> +	/* Time that I/O was reported completed by the device. */
>> +	u64 io_end_time_ns;
>> +
>> =20
>>  #ifdef CONFIG_BLK_WBT
>>  	unsigned short wbt_flags;
>> @@ -385,6 +388,14 @@ static inline int blkdev_reset_zones_ioctl(struct=
 block_device *bdev,
>> =20
>>  #endif /* CONFIG_BLK_DEV_ZONED */
>> =20
>> +static inline u64 blk_rq_io_time(struct request *rq)
>> +{
>> +	u64 start =3D rq->io_start_time_ns;
>> +	u64 end =3D rq->io_end_time_ns;
>> +
>> +	return (end - start) ? end - start : 0;
>=20
> I think you meant:
>=20
> 	return end >=3D start ? end - start : 0;
>=20
Sure, thanks



>> +}
>> +
>>  struct request_queue {
>>  	/*
>>  	 * Together with queue_head for cacheline sharing
>> --=20
>> 2.21.0
>>


--hsCjCnXVnYUwQsGQbElQ7xmTxgMi9asiu--

--YGz42mCsFGMGguNSAU7zC7fPU5mBliGzz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAlzvoAcACgkQWt5b1Glr
+6Vf4xAAk2UTedNBHal+WWUymCsZv0G1MTzcXRxjVtaFL4oO1MEpJyDbstIK+huD
lB+gsUlChdW6/4b//yRKv2tHhdStcWJf21nj2TTOW3h+tn/J1eQvtS4laoeTI928
CGvct1ZUtqQ3ZBM04f0rWlXb0x6emkyn2clXefPhJcS/MNVnK87jjpMPDGCXI6Al
di5fKjJV6RA9vTDtEiemJc2cb3nblny0RC8YgxhSFecOd9rJoQ/08wT1OwFB0Pdy
6OoNJfpYRYgPI10ztK6WJTWMXigXOHTPGf9ZR/Vm78YU8Ff/K/vaTFbhXxc+GKB9
ET0aOTo6Ccu6e3OUuc5hSnAVJg7QXOCdyx+dUw7SIwe1jokBjfu/fSorO3nG5RTt
sPhe3/loANS3GseMhauP7jKTJoYp5ronrFIv1TfpKDxBBxv7l+NsF3JWAz/pwHS5
LZEbfa4Dydzh5jsV/b+qngp4m/+rKSVIVl5+TzXSPYGIwGnnnEnFL1OCysmMaVEG
zhB03HYdypWjDPwQeYmHDbQ6vFP1x6yIVsPEIlqOppzS8SUQMHGddYEKljcdb7Lz
Lwh8iwjjNPcOrM9AKnaxTouXKkTm965ck9c0gkhOZAMxSXAbGwEzkh3LQ3g0Ix4c
DwNifr6UBEOqvwr6jp3D/ihEFlET87Fn0hUHBPPnmgsCkK7Tayc=
=1+UR
-----END PGP SIGNATURE-----

--YGz42mCsFGMGguNSAU7zC7fPU5mBliGzz--
