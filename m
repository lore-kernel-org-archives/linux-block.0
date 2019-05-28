Return-Path: <SRS0=Dgp+=T4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A8DC04AB6
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 18:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7528F208CB
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 18:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsXKGYRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE1SZ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 May 2019 14:25:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39649 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfE1SZ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 May 2019 14:25:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so2212920wrt.6
        for <linux-block@vger.kernel.org>; Tue, 28 May 2019 11:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=gYkXm0onGL56rid+MKSr/Jk5iqG9PmkUJkB8/sqP09k=;
        b=HsXKGYRv5oOgdZAfgiyuwIsqDn9wXYMv1o89uIlvTaRRJWI7cOKUzj8pS0cbXrDi1F
         xANiV34T+OvcdecTtb3mbvJd2OUjIYYrt1tBgKbnsKK1qWsFYAFQ7KRb8LIpOKHFKtuQ
         5B/wMH3zsR5f6XVu4b/SJzFPpijgmWu7MBTF57FX2lWEt/eKlFFOl9XU/+DwV/kkg9yK
         ZkqBFuwrR8fhX7lHL5OUVs0xrZ7qhKx/b+Jc3Ui47ab/jbPhZCN6MsdvjsJqrwHhBQUk
         tLHJBWdhUIYOiA6QgxTzYarf8Bb94Ds7207jDTk96YFTp4XGSb8fXujZWq3WCTnh5n9z
         XcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=gYkXm0onGL56rid+MKSr/Jk5iqG9PmkUJkB8/sqP09k=;
        b=FkzYu636OH3ehWVUDJDq+uEO0DQnaczz5tqiN5WJcePFssncFOvvLvl97uXBvJMDaZ
         /VZqYih/QLwtjtusIX9+X4UMt6UbI/wYEqAFCmQz/1zNd7aEtvbBmXzjaMQeqprnVRIq
         1/0WZ5GakGcwsZ4flSl9mojSwDflxJonmBkk+FAqzG25hWkvlOI4Copcx+XS37dQvKNK
         2eesC7m2/Ea908Yh9OKLz2uVM7V4Wko7DF/qktR9J8xN0wY2E9daSm27EdwpHyNtSeOQ
         ZoiUYOjxiWFGOEWob7rpE4+zlPsMj2fHsY4IWOnFs8J0MHNpE+WWFZZSwg0wVpz5eK3c
         rZ3g==
X-Gm-Message-State: APjAAAW51phTW0jkg9gk0b6A0EP6fwks+QXbbmUJLLjJjDvpoHK/3GS5
        LaJuHLH5Pg37F+llsplh8DuUXs4MKFE=
X-Google-Smtp-Source: APXvYqxAkXChBSeHC8GqHhzMhuWu4tO3lOMrPxdeBAXfHse1AcjlRMtkySRukgCec1qDgxP92c/kZw==
X-Received: by 2002:adf:efc3:: with SMTP id i3mr490853wrp.45.1559067924504;
        Tue, 28 May 2019 11:25:24 -0700 (PDT)
Received: from [192.168.43.7] ([109.126.135.3])
        by smtp.gmail.com with ESMTPSA id b2sm13632197wrt.20.2019.05.28.11.25.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:25:23 -0700 (PDT)
To:     Hou Tao <houtao1@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     osandov@fb.com, ming.lei@redhat.com
References: <20190521075904.135060-1-houtao1@huawei.com>
 <20190521075904.135060-2-houtao1@huawei.com>
 <76a679b4-cd55-8bca-0020-fb320914f491@gmail.com>
 <1a525ec8-3197-7cb4-bec7-bdd8b345cc84@huawei.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 1/2] block: make rq sector size accessible for block stats
Message-ID: <4ddc4092-e760-4c67-4dc6-33660c99b808@gmail.com>
Date:   Tue, 28 May 2019 21:25:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1a525ec8-3197-7cb4-bec7-bdd8b345cc84@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9p9QPRcZ8kCQU1IRTKRGP4wkY1XGfnJlB"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9p9QPRcZ8kCQU1IRTKRGP4wkY1XGfnJlB
Content-Type: multipart/mixed; boundary="HJdkdYvqa6FTTyFuujxTu7gFMEoV3A8bY";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Hou Tao <houtao1@huawei.com>, axboe@kernel.dk, linux-block@vger.kernel.org
Cc: osandov@fb.com, ming.lei@redhat.com
Message-ID: <4ddc4092-e760-4c67-4dc6-33660c99b808@gmail.com>
Subject: Re: [PATCH 1/2] block: make rq sector size accessible for block stats
References: <20190521075904.135060-1-houtao1@huawei.com>
 <20190521075904.135060-2-houtao1@huawei.com>
 <76a679b4-cd55-8bca-0020-fb320914f491@gmail.com>
 <1a525ec8-3197-7cb4-bec7-bdd8b345cc84@huawei.com>
In-Reply-To: <1a525ec8-3197-7cb4-bec7-bdd8b345cc84@huawei.com>

--HJdkdYvqa6FTTyFuujxTu7gFMEoV3A8bY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27/05/2019 14:39, Hou Tao wrote:
> Hi,
>=20
> On 2019/5/25 19:46, Pavel Begunkov wrote:
>> That's the same bug I posted a patch about 3+ weeks ago. No answer yet=
,
>> however.
>> https://www.spinics.net/lists/linux-block/msg40049.html
>>
> Sorry for missing that.
Anyway I haven't fixed it properly there.

>=20
>> I think putting time sampling at __blk_mq_end_request() won't give
>> sufficient precision for more sophisticated hybrid polling, because pa=
th
>> __blk_mq_complete_request() -> __blk_mq_end_request() adds a lot of
>> overhead (redirect rq to another cpu, dma unmap, etc). That's the case=

>> for mentioned patchset
>> https://www.spinics.net/lists/linux-block/msg40044.html
>>
>> It works OK for 50-80us requests (e.g. SSD read), but is not good enou=
gh
>> for 20us and less (e.g. SSD write). I think it would be better to save=

>> the time in advance, and use it later.
>>
> Yes, getting the end time from blk_mq_complete_request() will be more a=
ccurate.
What bothers me, if we sample time there, could we use it in throttling?
I'm not sure what it exactly expects.

>=20
>> By the way, it seems, that __blk_mq_end_request() is really better pla=
ce
>> to record stats, as not all drivers use __blk_mq_complete_request(),
>> even though they don't implement blk_poll().
>>
> And __blk_mq_complete_request() may be invoked multiple times (although=
 no possible
> for nvme device), but __blk_mq_end_request() is only invoked once.
Doubt it, that would be rather strange to *complete* a request multiple
times. Need to check, but so far I only seen drivers either using it
once or calling blk_mq_end_request() directly.

>=20
> Regards,
> Tao
>=20
>>
>> On 21/05/2019 10:59, Hou Tao wrote:
>>> Currently rq->data_len will be decreased by partial completion or
>>> zeroed by completion, so when blk_stat_add() is invoked, data_len
>>> will be zero and there will never be samples in poll_cb because
>>> blk_mq_poll_stats_bkt() will return -1 if data_len is zero.
>>>
>>> We could move blk_stat_add() back to __blk_mq_complete_request(),
>>> but that would make the effort of trying to call ktime_get_ns()
>>> once in vain. Instead we can reuse throtl_size field, and use
>>> it for both block stats and block throttle, and adjust the
>>> logic in blk_mq_poll_stats_bkt() accordingly.
>>>
>>> Fixes: 4bc6339a583c ("block: move blk_stat_add() to __blk_mq_end_requ=
est()")
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> ---
>>>  block/blk-mq.c         | 11 +++++------
>>>  block/blk-throttle.c   |  3 ++-
>>>  include/linux/blkdev.h | 15 ++++++++++++---
>>>  3 files changed, 19 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 08a6248d8536..4d1462172f0f 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -44,12 +44,12 @@ static void blk_mq_poll_stats_fn(struct blk_stat_=
callback *cb);
>>> =20
>>>  static int blk_mq_poll_stats_bkt(const struct request *rq)
>>>  {
>>> -	int ddir, bytes, bucket;
>>> +	int ddir, sectors, bucket;
>>> =20
>>>  	ddir =3D rq_data_dir(rq);
>>> -	bytes =3D blk_rq_bytes(rq);
>>> +	sectors =3D blk_rq_stats_sectors(rq);
>>> =20
>>> -	bucket =3D ddir + 2*(ilog2(bytes) - 9);
>>> +	bucket =3D ddir + 2 * ilog2(sectors);
>>> =20
>>>  	if (bucket < 0)
>>>  		return -1;
>>> @@ -329,6 +329,7 @@ static struct request *blk_mq_rq_ctx_init(struct =
blk_mq_alloc_data *data,
>>>  	else
>>>  		rq->start_time_ns =3D 0;
>>>  	rq->io_start_time_ns =3D 0;
>>> +	rq->stats_sectors =3D 0;
>>>  	rq->nr_phys_segments =3D 0;
>>>  #if defined(CONFIG_BLK_DEV_INTEGRITY)
>>>  	rq->nr_integrity_segments =3D 0;
>>> @@ -678,9 +679,7 @@ void blk_mq_start_request(struct request *rq)
>>> =20
>>>  	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
>>>  		rq->io_start_time_ns =3D ktime_get_ns();
>>> -#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>>> -		rq->throtl_size =3D blk_rq_sectors(rq);
>>> -#endif
>>> +		rq->stats_sectors =3D blk_rq_sectors(rq);
>>>  		rq->rq_flags |=3D RQF_STATS;
>>>  		rq_qos_issue(q, rq);
>>>  	}
>>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>>> index 1b97a73d2fb1..88459a4ac704 100644
>>> --- a/block/blk-throttle.c
>>> +++ b/block/blk-throttle.c
>>> @@ -2249,7 +2249,8 @@ void blk_throtl_stat_add(struct request *rq, u6=
4 time_ns)
>>>  	struct request_queue *q =3D rq->q;
>>>  	struct throtl_data *td =3D q->td;
>>> =20
>>> -	throtl_track_latency(td, rq->throtl_size, req_op(rq), time_ns >> 10=
);
>>> +	throtl_track_latency(td, blk_rq_stats_sectors(rq), req_op(rq),
>>> +			     time_ns >> 10);
>>>  }
>>> =20
>>>  void blk_throtl_bio_endio(struct bio *bio)
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index 1aafeb923e7b..68a0841d3554 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -202,9 +202,12 @@ struct request {
>>>  #ifdef CONFIG_BLK_WBT
>>>  	unsigned short wbt_flags;
>>>  #endif
>>> -#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>>> -	unsigned short throtl_size;
>>> -#endif
>>> +	/*
>>> +	 * rq sectors used for blk stats. It has the same value
>>> +	 * with blk_rq_sectors(rq), except that it never be zeroed
>>> +	 * by completion.
>>> +	 */
>>> +	unsigned short stats_sectors;
>>> =20
>>>  	/*
>>>  	 * Number of scatter-gather DMA addr+len pairs after
>>> @@ -892,6 +895,7 @@ static inline struct request_queue *bdev_get_queu=
e(struct block_device *bdev)
>>>   * blk_rq_err_bytes()		: bytes left till the next error boundary
>>>   * blk_rq_sectors()		: sectors left in the entire request
>>>   * blk_rq_cur_sectors()		: sectors left in the current segment
>>> + * blk_rq_stats_sectors()	: sectors of the entire request used for s=
tats
>>>   */
>>>  static inline sector_t blk_rq_pos(const struct request *rq)
>>>  {
>>> @@ -920,6 +924,11 @@ static inline unsigned int blk_rq_cur_sectors(co=
nst struct request *rq)
>>>  	return blk_rq_cur_bytes(rq) >> SECTOR_SHIFT;
>>>  }
>>> =20
>>> +static inline unsigned int blk_rq_stats_sectors(const struct request=
 *rq)
>>> +{
>>> +	return rq->stats_sectors;
>>> +}
>>> +
>>>  #ifdef CONFIG_BLK_DEV_ZONED
>>>  static inline unsigned int blk_rq_zone_no(struct request *rq)
>>>  {
>>>
>>
>=20

--=20
Yours sincerely,
Pavel Begunkov


--HJdkdYvqa6FTTyFuujxTu7gFMEoV3A8bY--

--9p9QPRcZ8kCQU1IRTKRGP4wkY1XGfnJlB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAlztfQgACgkQWt5b1Glr
+6VXAg//c9l4AtgA78oM7rEQwh82uQYZ1542Op2iVoVRnQQIMtXtnY4xUWYwz2RT
tqZu/UVvtAFkbduUFtVrtsPFlgbZpBS98BBc7TX4GQBkpJiQ/XyWbEbSF7olEmFg
nKYH9pH+H074jVKTZQ+zoJHlyERWpvPLGCppcZ/shjL1/lkHE/gg0GSnzp1YDOcI
mrIxFjU/NvBZw4eLXUkbzFAdWoj6zLU1gjRK9FMGnRFOzkUiK1Q4+w6mW9j7vuvW
pMQ9/7/SHVFx3AvJKIsqKJ3inl3o9yep95Tn4aQ1GMtaur7EugBg2LcOE1tHQVZ8
WhUM/H/pN5T3KZQd5Hz42JuFBRDtt7VJrFxLanVCiM2Ea9DS2fom954R4Jop1mWD
qA3yn08Mw98jyXqTpKuKusQ+5zQ/ANOv9uJNlVr9ZgvJLsKBQkLQx1w0gUMbbxUB
/kfbK/9VpDQSH4jV2DxQIJ+OUzZnWVhTu7ctaQ1L2lmmoRK2WIp2DrXJxZvFnVJQ
Fu+6f4UYLW0Q8tjP5dMP3UMpPRp5wywoa/xWMkJ6TXuCFvRwXfcl0EmOpJ1IdhaY
6DCNVas+YAg0FuLkVwqb1+nNKUmhi47ShFxqANfhfoXQCNNMlPVsv1t8AFTNHqlH
WD9BIzhcsr30l4QBxGEvtgi2j5jUCz1HEDmhX81AEps9ua+y58Y=
=g5I7
-----END PGP SIGNATURE-----

--9p9QPRcZ8kCQU1IRTKRGP4wkY1XGfnJlB--
