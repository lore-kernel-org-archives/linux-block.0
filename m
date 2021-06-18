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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060FFC48BDF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 23:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B4961205
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 23:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhFRXKG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 19:10:06 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12]:18376 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhFRXKG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 19:10:06 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20210618230755usoutp022b85bd9d1a5c54f5625a6344bd4fc784~Jz9no_32f2774427744usoutp02l;
        Fri, 18 Jun 2021 23:07:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20210618230755usoutp022b85bd9d1a5c54f5625a6344bd4fc784~Jz9no_32f2774427744usoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624057675;
        bh=MGCXxsTqMZEWB1pLoCyeZ6MxCQyF9IAcgcU0HqxDoJI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=FYfXghcwpUMu2di3oObdmFpntGEVs45nO3HQ8y6tlXSuCAQOfIeFiYwszgkV2ud+L
         pxPI+d5uQGgBNizgoJoa5b2bxSAfFqrs5C9vzl6bjUJnSqrZNuDUg3qcPtCg3qUsOF
         MhowUzaXW0BakFzFIR5KT65VOrUCew1bcy2W5s1s=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210618230755uscas1p12042ce70b4a7154278e521f495241722~Jz9nfO4_N2324523245uscas1p15;
        Fri, 18 Jun 2021 23:07:55 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id DB.06.53491.B472DC06; Fri,
        18 Jun 2021 19:07:55 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210618230754uscas1p21b3b68d04215a12c346cb5607bbb902a~Jz9nGKtiR0475804758uscas1p2A;
        Fri, 18 Jun 2021 23:07:54 +0000 (GMT)
X-AuditID: cbfec36f-f21ff7000001d0f3-ea-60cd274b70e9
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id D2.98.26904.A472DC06; Fri,
        18 Jun 2021 19:07:54 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 18 Jun 2021 16:07:54 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3]) by
        SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3%7]) with mapi id
        15.01.2242.008; Fri, 18 Jun 2021 16:07:54 -0700
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
Subject: Re: [PATCH v3 10/16] block/mq-deadline: Improve the sysfs show and
 store macros
Thread-Topic: [PATCH v3 10/16] block/mq-deadline: Improve the sysfs show and
        store macros
Thread-Index: AQHXY9s68Uw3dl9o2EaNgy+s5IZCLKsa2yqA
Date:   Fri, 18 Jun 2021 23:07:53 +0000
Message-ID: <20210618230753.GA241503@bgt-140510-bm01>
In-Reply-To: <20210618004456.7280-11-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68A26251AE69234799A37F8EC03F51DE@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTVxjHc869vd5Wm12QwCM16BqML0x0bMQbMeoHl9yhH4zZEsFE6ewV
        utFCelvfZWSCxaLR4YKjGK3V8CpRsCCDbpEyQMUXDBCwC1Ai1FSI0irFDWk2elnSb7//fX7n
        nP85uTQR+VQSS2t0Bl6vU2UrKRnZ1Dn9bP3O1U8yNpa/kLG1QxcotnTqb4ItNAUw67CVYLa6
        tgOzg9ZJxI7dthDsnHkYs7+7EljnpdN4u4zr7dvJ9T4xcg01Zymu9UU+xfnGXST39o9+irvb
        fYJ71xDHme4X493SdNkWNZ+tOczrN2zNkGU96+sicyfjj/5lDRL5qDTOjGgamC/hUluUGcno
        SKYagaPXJBFDIQaPvZA0I2lIsk07sDioQ9Bm70Ni8CEYHpghxXAfwaPAODW/hGI2wmxXPTHP
        UcwaCLgrQxLBTGFovzormR8sZdLhWs9NUpT2QZ2jkxI5CR6/ng59J5lVUNP6IOTLmWS4XGbD
        8yxlWGgyPQ8xYqJh5tGtEBNMDLjGrmGxdwTYyh2EyNEQbBmlRP4URma8i0T/M7C2+imRt4K9
        KF8icgJUXJ8gxHMj4GHZ2MJbLIO2qsHQZYAplkL11PTCpjvANXpxgRUwN1SBRakFwZVyn0QM
        7QgaeiqRaKXAoNeMLqJ4S1hzS1grS1grS1grS1grK5LUoBijIGgzeSFJxx9JFFRawajLTDyY
        o21A//1y3cH2nGY04PIlOhGmkRMBTSij5FLN44xIuVp17DivzzmgN2bzghMpaFIZI8d7fz4Q
        yWSqDPwPPJ/L6/+fYloam48lA0/lURm6erXyVePb73FjtPs6kfwyr0m93ObRLAl+9KPUX8v6
        Wz/MbuuqMljdQ3EFawe/XVn02/682HslgTSNGx/tLmg+6Sn4mGVQp59b3GlW+6nX7dr1ezcM
        f2IeT5opvr1n8sxmT2pHWsWNwz/dIav2nT3tfVCy3XKw5B+/3FJ/CN1qOXGusqjszp4/lykK
        O/wDFbW2m/YPS+7ZNQH9+TyaT9nFE4ZDxqoV6957ZNE/ziU/9DWfnKtLMUgKEsybhrRdE5fH
        eY9ilyJtoqc/1Sn9uvQr18h33yxqlJ4yBZ9HjLqF8yNa7y9tN9Jz49VflK7gyoP7l7qq3+y4
        60BeJSlkqT5fR+gF1b+sNZ7y4QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWS2cA0SddL/WyCQcMjPYvVd/vZLKZ9+Mls
        0dr+jcliz6JJTBYrVx9lsrix4A2jxZP1s5gt/nbdY7LYe0vb4tDkZiYHLo/LV7w9Lp8t9di0
        qpPNY/fNBjaPj09vsXi833eVzWPz6WqPz5vkPNoPdDMFcEZx2aSk5mSWpRbp2yVwZZy/cpyl
        4I1Kxe0F/5gbGKfJdTFyckgImEgs+rqHqYuRi0NIYDWjxLSlt1khnI+MEjN27GOGcA4wStzb
        +IAdpIVNwEDi9/GNzCC2iICGxLcHy1lAipgFPjBJ/Nj5kQUkISwQJTH/whIWiKJoiQubzzNB
        2EYSZ159BYuzCKhKrNp9ghXE5hUwlZg+cxHUHTsYJTbtWM0GkuAUsJDY1n4RrJlRQEzi+6k1
        YDazgLjErSfzmSCeEJBYsuc8M4QtKvHy8T9WCFtR4v73l+wQ9ToSC3Z/YoOw7SS2dDSwQtja
        EssWvmaGOEJQ4uTMJywQvZISB1fcYJnAKDELybpZSEbNQjJqFpJRs5CMWsDIuopRvLS4ODe9
        otgoL7Vcrzgxt7g0L10vOT93EyMwPZz+dzh6B+PtWx/1DjEycTAeYpTgYFYS4eXMPJMgxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnPdl1MR4IYH0xJLU7NTUgtQimCwTB6dUAxNzWfD6Rbfa94fo
        FoW/+L2FUSYmW2f7rZh7PIZ3ZfKjHv7eoPhGJcJ8e8Rlp8CaEJMDxRvXOJv3bj5RsXB7RtPt
        vzIzGdZMZ7m9yf2P6ksNY+9Ns5+eP77mt/Kb/0EpfPwcNuc+Tea4oDr9aWulldBM9fVT90yU
        YlmZfCzXMPWYQE7w3cMz33Lvv3LV7c/mgG1uXMtVmXf3fWcwPLY90XDq9VUJO9X/+0r8zH26
        U3TtFnnL1ymN4cXOc9S0b+k85WH8kzXXfWO0Y9CyBq2zR6uKoyb7xn/+vsdfsfPfVZHk6pW6
        H66yOShyq5akn4075PCy+HzRCgZdVq0iSUe1l9Y7l0jqREw699euWsXn4holluKMREMt5qLi
        RACeyGSSfgMAAA==
X-CMS-MailID: 20210618230754uscas1p21b3b68d04215a12c346cb5607bbb902a
CMS-TYPE: 301P
X-CMS-RootMailID: 20210618004523uscas1p118a3ca19aa236230fc96da78437079a6
References: <20210618004456.7280-1-bvanassche@acm.org>
        <CGME20210618004523uscas1p118a3ca19aa236230fc96da78437079a6@uscas1p1.samsung.com>
        <20210618004456.7280-11-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 05:44:50PM -0700, Bart Van Assche wrote:
> Define separate macros for integers and jiffies to improve readability.
> Use sysfs_emit() and kstrtoint() instead of sprintf() and simple_strtol()=
.
> The former functions are the recommended functions.
>=20
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 66 ++++++++++++++++++++-------------------------
>  1 file changed, 29 insertions(+), 37 deletions(-)
>=20
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 69126beff77d..f92224ff0256 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -605,58 +605,50 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
>  /*
>   * sysfs parts below
>   */
> -static ssize_t
> -deadline_var_show(int var, char *page)
> -{
> -	return sprintf(page, "%d\n", var);
> -}
> -
> -static void
> -deadline_var_store(int *var, const char *page)
> -{
> -	char *p =3D (char *) page;
> -
> -	*var =3D simple_strtol(p, &p, 10);
> -}
> -
> -#define SHOW_FUNCTION(__FUNC, __VAR, __CONV)				\
> +#define SHOW_INT(__FUNC, __VAR)						\
>  static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
>  {									\
>  	struct deadline_data *dd =3D e->elevator_data;			\
> -	int __data =3D __VAR;						\
> -	if (__CONV)							\
> -		__data =3D jiffies_to_msecs(__data);			\
> -	return deadline_var_show(__data, (page));			\
> -}
> -SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[DD_READ], 1);
> -SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[DD_WRITE], 1);
> -SHOW_FUNCTION(deadline_writes_starved_show, dd->writes_starved, 0);
> -SHOW_FUNCTION(deadline_front_merges_show, dd->front_merges, 0);
> -SHOW_FUNCTION(deadline_fifo_batch_show, dd->fifo_batch, 0);
> -#undef SHOW_FUNCTION
> +									\
> +	return sysfs_emit(page, "%d\n", __VAR);				\
> +}
> +#define SHOW_JIFFIES(__FUNC, __VAR) SHOW_INT(__FUNC, jiffies_to_msecs(__=
VAR))
> +SHOW_JIFFIES(deadline_read_expire_show, dd->fifo_expire[DD_READ]);
> +SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
> +SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
> +SHOW_INT(deadline_front_merges_show, dd->front_merges);
> +SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);
> +#undef SHOW_INT
> +#undef SHOW_JIFFIES
> =20
>  #define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, __CONV)			\
>  static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t=
 count)	\
>  {									\
>  	struct deadline_data *dd =3D e->elevator_data;			\
> -	int __data;							\
> -	deadline_var_store(&__data, (page));				\
> +	int __data, __ret;						\
> +									\
> +	__ret =3D kstrtoint(page, 0, &__data);				\
> +	if (__ret < 0)							\
> +		return __ret;						\
>  	if (__data < (MIN))						\
>  		__data =3D (MIN);						\
>  	else if (__data > (MAX))					\
>  		__data =3D (MAX);						\
> -	if (__CONV)							\
> -		*(__PTR) =3D msecs_to_jiffies(__data);			\
> -	else								\
> -		*(__PTR) =3D __data;					\
> +	*(__PTR) =3D __CONV(__data);					\
>  	return count;							\
>  }
> -STORE_FUNCTION(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0,=
 INT_MAX, 1);
> -STORE_FUNCTION(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], =
0, INT_MAX, 1);
> -STORE_FUNCTION(deadline_writes_starved_store, &dd->writes_starved, INT_M=
IN, INT_MAX, 0);
> -STORE_FUNCTION(deadline_front_merges_store, &dd->front_merges, 0, 1, 0);
> -STORE_FUNCTION(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX, 0=
);
> +#define STORE_INT(__FUNC, __PTR, MIN, MAX)				\
> +	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, )
> +#define STORE_JIFFIES(__FUNC, __PTR, MIN, MAX)				\
> +	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, msecs_to_jiffies)
> +STORE_JIFFIES(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, =
INT_MAX);
> +STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0=
, INT_MAX);
> +STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, I=
NT_MAX);
> +STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
> +STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
>  #undef STORE_FUNCTION
> +#undef STORE_INT
> +#undef STORE_JIFFIES
> =20
>  #define DD_ATTR(name) \
>  	__ATTR(name, 0644, deadline_##name##_show, deadline_##name##_store)

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
