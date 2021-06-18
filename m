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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165C2C48BDF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 17:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92AF610C7
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 17:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhFRRYS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 13:24:18 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12]:63429 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbhFRRYS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 13:24:18 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20210618172207usoutp02b0f8756e10a41abeffc9c2cc2a09197a~JvPszV9Cv1297912979usoutp02h;
        Fri, 18 Jun 2021 17:22:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20210618172207usoutp02b0f8756e10a41abeffc9c2cc2a09197a~JvPszV9Cv1297912979usoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624036927;
        bh=CePfP2tzTp6vMjR/1kcLJJsTHOpNO9hv2yACWVwNJFg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=isOhrplLs8ig1SshOBQ7lOA4B8RJZEQHUGIYGQgFkgxl0MtCjB7CwvutXLsw23ViX
         wxlaqSlNyftisnln2lVWsUIasEEgnEFQ0DwceCF0VgAWUaUxB0gfZRFtpFETxaOlSx
         tEo7bb9Wt+Ey4mPaESoXjqB+V0WShrhRpCz1DFY8=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210618172207uscas1p27960eba51a15fe457bed01e114bbe320~JvPslxI6X1616716167uscas1p2H;
        Fri, 18 Jun 2021 17:22:07 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 39.BC.19318.F36DCC06; Fri,
        18 Jun 2021 13:22:07 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210618172207uscas1p1475c882a53fd11c7d6c4b457a6272cad~JvPsUIx5x1685016850uscas1p1X;
        Fri, 18 Jun 2021 17:22:07 +0000 (GMT)
X-AuditID: cbfec370-c37ff70000014b76-82-60ccd63f82fb
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id C2.25.47882.E36DCC06; Fri,
        18 Jun 2021 13:22:07 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 18 Jun 2021 10:22:06 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3]) by
        SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3%7]) with mapi id
        15.01.2242.008; Fri, 18 Jun 2021 10:22:06 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 03/16] block/blk-rq-qos: Move a function from a
 header file into a C file
Thread-Topic: [PATCH v3 03/16] block/blk-rq-qos: Move a function from a
        header file into a C file
Thread-Index: AQHXY9sz1vDYFZPHvkq8OJ+NXXByr6saeo4A
Date:   Fri, 18 Jun 2021 17:22:06 +0000
Message-ID: <20210618172206.GA94206@bgt-140510-bm01>
In-Reply-To: <20210618004456.7280-4-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D44069E1F8FAF4A9CAC2F749A9CEC26@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djXc7r2184kGHx6JmWx+m4/m8W0Dz+Z
        LVrbvzFZ7Fk0icli5eqjTBY3FrxhtHiyfhazxd+ue0wWe29pWxya3MzkwOVx+Yq3x+WzpR6b
        VnWyeey+2cDm8fHpLRaP9/uusnlsPl3t8XmTnEf7gW6mAM4oLpuU1JzMstQifbsEroy5n/Yy
        FewWqJj18glLA+Me3i5GTg4JAROJp/M3s3UxcnEICaxklGi4u50ZJCEk0MokceN3HUzR6ye3
        mCGK1jJKrPnxjwXC+cgo8en9ZnYI5wCjxKKWE+wgLWwCBhK/j28EGyUioCHx7cFysA5mgQ9M
        Eofn/WbtYuTgEBZIkri6Jw2iJlni5uovrBC2kcSWy9uYQGwWAVWJdRdvgc3kBTrjdN8RZpBW
        TgFzifl380DCjAJiEt9PrQErZxYQl7j1ZD4TxNWCEotm72GGsMUk/u16yAZhK0rc//6SHaJe
        R2LB7k9sELadROfhy6wQtrbEsoWvmSHWCkqcnPmEBaJXUuLgihtgr0gIdHNK3Jz7ghUi4SJx
        9ccbqMXSEtPXXIYq2sUoMWf2R1YI5zCjxKYLyxkhqqwlbrzsYpzAqDILyeWzkFw1C8lVs5Bc
        NQvJVQsYWVcxipcWF+empxYb56WW6xUn5haX5qXrJefnbmIEJrjT/w4X7GC8deuj3iFGJg7G
        Q4wSHMxKIrycmWcShHhTEiurUovy44tKc1KLDzFKc7AoifPOjZwYLySQnliSmp2aWpBaBJNl
        4uCUamAq5FI6/ks24/OiT2a3Pa+r2xsYXOZevuzsqhkbj85d2ntKY8ZNuY/7vqV8eVKgvDTr
        56RZF/f+33pz4rzdd679zompZNnc0fY499zLiOmN/e8/fbjT8kzq/5rcy/XVrfmsUj7VRz1L
        Tm93/DDv54oduat+ZRjdkws+9HnXlJiNHw/acb232lB1pEfG/9g+tv9SD/ZN9CxlWeiy2HXr
        Kd9JfuWZ0wu07/WL/Kwofeir8l3HQytTUGXBManVM3g3cgV+EmlX1P8iyrjkyBG5dZvnxC3s
        eMqVl/7FKOTN4vfrDpna3ZvqeDf+ne+inuO70u4+lFrH/uajl1mUwgr286J69s9Lrl/m/Hjj
        9/KGqlXX3NYosRRnJBpqMRcVJwIAVXsxyd8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWS2cA0Sdf+2pkEgy8bmSxW3+1ns5j24Sez
        RWv7NyaLPYsmMVmsXH2UyeLGgjeMFk/Wz2K2+Nt1j8li7y1ti0OTm5kcuDwuX/H2uHy21GPT
        qk42j903G9g8Pj69xeLxft9VNo/Np6s9Pm+S82g/0M0UwBnFZZOSmpNZllqkb5fAlTH3016m
        gt0CFbNePmFpYNzD28XIySEhYCLx+skt5i5GLg4hgdWMEo1LbzBBOB8ZJW4+fA2VOcAocXz7
        fRaQFjYBA4nfxzcyg9giAhoS3x4sZwEpYhb4wCTxY+dHsCJhgSSJX21P2CCKkiVefVrKCGEb
        SWy5vI0JxGYRUJVYd/EWO4jNC3TH6b4jYEOFBLYzSkyeA9TLwcEpYC4x/24eSJhRQEzi+6k1
        YK3MAuISt57MZ4J4QUBiyZ7zzBC2qMTLx/9YIWxFifvfX7JD1OtILNj9iQ3CtpPoPHyZFcLW
        lli28DUzxAmCEidnPmGB6JWUOLjiBssERolZSNbNQjJqFpJRs5CMmoVk1AJG1lWM4qXFxbnp
        FcXGeanlesWJucWleel6yfm5mxiBqeH0v8MxOxjv3fqod4iRiYPxEKMEB7OSCC9n5pkEId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rwesRPjhQTSE0tSs1NTC1KLYLJMHJxSDUzHO3WX1q/5zhjg
        5d/3KG+1e0mU2eGpFTmOV5iPZ/9gkouxywudu033S3l8YqJ+9/+ynTwfy4WKH1kHtG0K7tv9
        7Xgk11uXXj+zv1a5ys0Lc1+vj0o0+mp4JKKNee4EwQq97ypJbBJmbdcutXcsq9rAbtGsU1CX
        t5u9dpWcUF/sqbI56/af+vtmf8zznNeeUiEzPXMVd9gv2VJ6U7l3gtlXocOdV7jm75mmmTnP
        +Fj8ysvWnvvMMtYe+mn3e0P5oso7xnIMkzhPSTyfuNe/lzl4oVjQelF3oR8GN1/FeL+8mzk1
        yvKauuL9vY9v2v3+97TMvPXz1gUXIzdUa0uomcivOWVg+exV/4nNr7Y57VdiKc5INNRiLipO
        BAD5WdcUfAMAAA==
X-CMS-MailID: 20210618172207uscas1p1475c882a53fd11c7d6c4b457a6272cad
CMS-TYPE: 301P
X-CMS-RootMailID: 20210618004511uscas1p29ea44dff22f15562546c1012aa3cf87d
References: <20210618004456.7280-1-bvanassche@acm.org>
        <CGME20210618004511uscas1p29ea44dff22f15562546c1012aa3cf87d@uscas1p2.samsung.com>
        <20210618004456.7280-4-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 05:44:43PM -0700, Bart Van Assche wrote:
> rq_qos_id_to_name() is only used in blk-mq-debugfs.c so move that functio=
n
> into in blk-mq-debugfs.c.
>=20
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq-debugfs.c | 13 +++++++++++++
>  block/blk-rq-qos.h     | 13 -------------
>  2 files changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 2a75bc7401df..6ac1c86f62ef 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -937,6 +937,19 @@ void blk_mq_debugfs_unregister_sched(struct request_=
queue *q)
>  	q->sched_debugfs_dir =3D NULL;
>  }
> =20
> +static const char *rq_qos_id_to_name(enum rq_qos_id id)
> +{
> +	switch (id) {
> +	case RQ_QOS_WBT:
> +		return "wbt";
> +	case RQ_QOS_LATENCY:
> +		return "latency";
> +	case RQ_QOS_COST:
> +		return "cost";
> +	}
> +	return "unknown";
> +}
> +
>  void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
>  {
>  	debugfs_remove_recursive(rqos->debugfs_dir);
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
> index 2bcb3495e376..a77afbdd472c 100644
> --- a/block/blk-rq-qos.h
> +++ b/block/blk-rq-qos.h
> @@ -79,19 +79,6 @@ static inline struct rq_qos *blkcg_rq_qos(struct reque=
st_queue *q)
>  	return rq_qos_id(q, RQ_QOS_LATENCY);
>  }
> =20
> -static inline const char *rq_qos_id_to_name(enum rq_qos_id id)
> -{
> -	switch (id) {
> -	case RQ_QOS_WBT:
> -		return "wbt";
> -	case RQ_QOS_LATENCY:
> -		return "latency";
> -	case RQ_QOS_COST:
> -		return "cost";
> -	}
> -	return "unknown";
> -}
> -
>  static inline void rq_wait_init(struct rq_wait *rq_wait)
>  {
>  	atomic_set(&rq_wait->inflight, 0);

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
