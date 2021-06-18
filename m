Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5525BC48BE8
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 22:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3322961284
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 22:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhFRWIv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:08:51 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11]:58404 "EHLO
        mailout1.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbhFRWIu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 18:08:50 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20210618220640usoutp01cdb413752c175d0826bf79d9ab4de2dc~JzIIoK8z81011010110usoutp01L;
        Fri, 18 Jun 2021 22:06:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20210618220640usoutp01cdb413752c175d0826bf79d9ab4de2dc~JzIIoK8z81011010110usoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624054000;
        bh=erJ2kpwOrCJ+eiP3ZdrRVJDJz0BvbY4Q5u2wF5eXyUw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=RZjklLejf2qd/kRtJvvN1BDXeyXwaCMKPdGCNtUYwsHeIsX1Nklnl4C6MKcEag0C1
         1F8IzcVKa2qJwZJkp5c1/sxiHVIFFCbOsv7cudtdcjgQdmsI7jzMnzb/6A6MgShNen
         6u8Y2ZPBmx7uxQPRVuOtIXyA/ZSj+kVxUDxqjEPA=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210618220639uscas1p20aca014828a1ff0a17be10f1a1911b2f~JzIIZXGnd1280212802uscas1p2J;
        Fri, 18 Jun 2021 22:06:39 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id B4.F1.19318.FE81DC06; Fri,
        18 Jun 2021 18:06:39 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210618220639uscas1p170b58115a21550d3b1c1c0ed33887617~JzIIAaLU10489504895uscas1p18;
        Fri, 18 Jun 2021 22:06:39 +0000 (GMT)
X-AuditID: cbfec370-c4fff70000014b76-df-60cd18efa451
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id FC.08.48268.FE81DC06; Fri,
        18 Jun 2021 18:06:39 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 18 Jun 2021 15:06:38 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3]) by
        SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3%7]) with mapi id
        15.01.2242.008; Fri, 18 Jun 2021 15:06:38 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Johannes Thumshirn" <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 05/16] block/mq-deadline: Add several comments
Thread-Topic: [PATCH v3 05/16] block/mq-deadline: Add several comments
Thread-Index: AQHXY9s270Ky0iSS60+mX+aL9AMDqqsayg0A
Date:   Fri, 18 Jun 2021 22:06:38 +0000
Message-ID: <20210618220638.GB210778@bgt-140510-bm01>
In-Reply-To: <20210618004456.7280-6-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3B9CA5578DA184CA4F2B139A825794B@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djX87rvJc4mGLzdqG2x+m4/m8W0Dz+Z
        LVrbvzFZ7Fk0icli5eqjTBY3FrxhtHiyfhazxd+ue0wWe29pWxya3MzkwOVx+Yq3x+WzpR6b
        VnWyeey+2cDm8fHpLRaP9/uusnlsPl3t8XmTnEf7gW6mAM4oLpuU1JzMstQifbsErowFl7Yx
        F8yVqPi98hpLA+NM4S5GTg4JAROJPy/2soDYQgIrGSUeT9XsYuQCsluZJNaeuMwKUzRl2jJW
        iMRaRonP0zuYIZyPjBKPOtsYIZwDjBKbPsxnBGlhEzCQ+H18IzOILSKgIfHtwXKwHcwCX5gk
        nr7iA7GFBVwltjzoYoWocZN4tWwJUxcjB5BtJLHoWBSIySKgKvFrhh2IyStgKrHpSwVIMaeA
        uUT3hF9gAxkFxCS+n1rDBDFcXOLWk/lMEDcLSiyavYcZwhaT+LfrIRuErShx//tLdoh6HYkF
        uz+xgYxnFrCTON0qAhHWlli28DVYKy/QmJMzn7BAtEpKHFxxgwXkWQmBbk6JQ+seQO1ykVjc
        dZARwpaWuHp9KjNE0S5GiTmzP7JCOIeBwXNhOVSVtcSNl12MExhVZiE5fBaSo2YhHDULyVGz
        kBy1gJF1FaN4aXFxbnpqsXFearlecWJucWleul5yfu4mRmBiO/3vcMEOxlu3PuodYmTiYDzE
        KMHBrCTCy5l5JkGINyWxsiq1KD++qDQntfgQozQHi5I479zIifFCAumJJanZqakFqUUwWSYO
        TqkGptAX5pLO79sCU+4373X89dfyueOj63baPodDSpfuUFzItf6S3tMVi4WvzJaX8Ld47lwp
        qJh3M3+eWP7My+rT/3HfdmVS3Mzmam/BO1Hrx88vzi/k3jkv09z6amPZM2XFFfdcYyR8jiiy
        TRctNr8xb/sTvUWqtd6v9srw3l71LtT1zJorfyO+l18/fXK/RJ/ZhMdfeUqfnxM/Ntkg/cRd
        veibfS93zX0a/lczRqkzda25DOdKoVDVnhITDbkrfc7fOXoOGlgy/zjJcqyd4eDJYD8eAY+F
        bYwPa2tO9h6023k3T/XZ6l/db2fI/bI/wno/YbX2bcaLE9yu9b5b1NASvOzDBIlG13sXN7hO
        aZRILVNiKc5INNRiLipOBACQONoy2wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsWS2cA0Sfe9xNkEg+61fBar7/azWUz78JPZ
        orX9G5PFnkWTmCxWrj7KZHFjwRtGiyfrZzFb/O26x2Sx95a2xaHJzUwOXB6Xr3h7XD5b6rFp
        VSebx+6bDWweH5/eYvF4v+8qm8fm09UenzfJebQf6GYK4IzisklJzcksSy3St0vgylhwaRtz
        wVyJit8rr7E0MM4U7mLk5JAQMJGYMm0ZaxcjF4eQwGpGiQ8Pr0M5Hxklpj27ygjhHGCUuPX3
        NAtIC5uAgcTv4xuZQWwRAQ2Jbw+Wg8WZBb4wSTx9xQdiCwu4Smx50MUKUeMm8WrZEqYuRg4g
        20hi0bEoEJNFQFXi1ww7EJNXwFRi05cKkGIhge2MEh39CiA2p4C5RPeEX2DDGQXEJL6fWsME
        sUhc4taT+UwQ9wtILNlznhnCFpV4+fgfK4StKHH/+0t2iHodiQW7P7GBrGIWsJM43SoCEdaW
        WLbwNVgrr4CgxMmZT1ggWiUlDq64wTKBUWIWkm2zkEyahTBpFpJJs5BMWsDIuopRvLS4ODe9
        otgwL7Vcrzgxt7g0L10vOT93EyMwIZz+dzhyB+PRWx/1DjEycTAeYpTgYFYS4eXMPJMgxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnFfIdWK8kEB6YklqdmpqQWoRTJaJg1OqgUnil1dI5kcP4yMZ
        uuGVp4PlViaKybjyl7IHXjtbd//EpdfFXut/BUcYOjE2XP9VdN3nSOKCe09+LlP9/UTEt7Tm
        LrNK8vezgrwPDd9/rN50othnEpfpkocLgi9fnnNOyqw9ZZcvu+LRhatOvktYd8NW3vTm3bWW
        2ysM30+rfZK4Xuylt6fuZ6n53S8Nf//b6Bw9LdjXfFGnZ+WVpqu6Vhbqc6JlTAqr5Li/X369
        qER9idDJ7U4PXY70nLrcfP0Kt0z6trJ9H8T//1jSWuN8/Fm6wxTW9RO8nHxFCngOPYh6aWmb
        vcngR79HQEXr5i8v+5kPB1WaSlpMeppyUpjzaYxb7BYdzy+ua5t3J1z0ZFJiKc5INNRiLipO
        BADzF0+9dwMAAA==
X-CMS-MailID: 20210618220639uscas1p170b58115a21550d3b1c1c0ed33887617
CMS-TYPE: 301P
X-CMS-RootMailID: 20210618004517uscas1p154b24c3118fea6f3052436209c6c6e24
References: <20210618004456.7280-1-bvanassche@acm.org>
        <CGME20210618004517uscas1p154b24c3118fea6f3052436209c6c6e24@uscas1p1.samsung.com>
        <20210618004456.7280-6-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 05:44:45PM -0700, Bart Van Assche wrote:
> Make the code easier to read by adding more comments.
>=20
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 8eea2cbf2bf4..31418e9ce9e2 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -139,6 +139,9 @@ static void dd_request_merged(struct request_queue *q=
, struct request *req,
>  	}
>  }
> =20
> +/*
> + * Callback function that is invoked after @next has been merged into @r=
eq.
> + */
>  static void dd_merged_requests(struct request_queue *q, struct request *=
req,
>  			       struct request *next)
>  {
> @@ -375,6 +378,8 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)
>  }
> =20
>  /*
> + * Called from blk_mq_run_hw_queue() -> __blk_mq_sched_dispatch_requests=
().
> + *
>   * One confusing aspect here is that we get called for a specific
>   * hardware queue, but we may return a request that is for a
>   * different hardware queue. This is because mq-deadline has shared
> @@ -438,6 +443,10 @@ static int dd_init_queue(struct request_queue *q, st=
ruct elevator_type *e)
>  	return 0;
>  }
> =20
> +/*
> + * Try to merge @bio into an existing request. If @bio has been merged i=
nto
> + * an existing request, store the pointer to that request into *@rq.
> + */
>  static int dd_request_merge(struct request_queue *q, struct request **rq=
,
>  			    struct bio *bio)
>  {
> @@ -461,6 +470,10 @@ static int dd_request_merge(struct request_queue *q,=
 struct request **rq,
>  	return ELEVATOR_NO_MERGE;
>  }
> =20
> +/*
> + * Attempt to merge a bio into an existing request. This function is cal=
led
> + * before @bio is associated with a request.
> + */
>  static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
>  		unsigned int nr_segs)
>  {
> @@ -518,6 +531,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,
>  	}
>  }
> =20
> +/*
> + * Called from blk_mq_sched_insert_request() or blk_mq_sched_insert_requ=
ests().
> + */
>  static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
>  			       struct list_head *list, bool at_head)
>  {
> @@ -544,6 +560,8 @@ static void dd_prepare_request(struct request *rq)
>  }
> =20
>  /*
> + * Callback from inside blk_mq_free_request().
> + *
>   * For zoned block devices, write unlock the target zone of
>   * completed write requests. Do this while holding the zone lock
>   * spinlock so that the zone is never unlocked while deadline_fifo_reque=
st()

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
