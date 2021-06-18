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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4D3C48BE8
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 17:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C31B613EB
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 17:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhFRRR4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 13:17:56 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11]:19415 "EHLO
        mailout1.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhFRRRz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 13:17:55 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20210618171544usoutp011e8011c46f4bf3eee02d082e82119268~JvKH6tZYF1347313473usoutp01b;
        Fri, 18 Jun 2021 17:15:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20210618171544usoutp011e8011c46f4bf3eee02d082e82119268~JvKH6tZYF1347313473usoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624036544;
        bh=LHSPL6p7ApaEriCytK1GvhcqqhbeSdcLd5Q7FB+rybs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=WJJfuWERusvuxpNcGZK0oFkUirfqljgbNzX7tOfRtke/TyYYtZgt8RTIxeORF/C3Y
         sPsOrvtsw+9WRh/rxB5Iq9W+fKLvinuEXoF2AZlT+5pyaaSDQVaKoDswKvyPHwRMzs
         6+3QbLOufT5+ryknCdySKvAwvpbuqarJ9rZqHE7A=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210618171544uscas1p12b66d21b826cd3dcb955eed22ed847d8~JvKHtFB5V2748827488uscas1p1q;
        Fri, 18 Jun 2021 17:15:44 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 6A.6B.53491.0C4DCC06; Fri,
        18 Jun 2021 13:15:44 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210618171543uscas1p2f93a7127657eb1c1c3fa990d322e9d32~JvKHJz0KA3095430954uscas1p2C;
        Fri, 18 Jun 2021 17:15:43 +0000 (GMT)
X-AuditID: cbfec36f-f09ff7000001d0f3-72-60ccd4c0613d
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id BD.05.47882.FB4DCC06; Fri,
        18 Jun 2021 13:15:43 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 18 Jun 2021 10:15:42 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3]) by
        SSI-EX1.ssi.samsung.com ([fe80::255d:1bae:c3ae:e3c3%7]) with mapi id
        15.01.2242.008; Fri, 18 Jun 2021 10:15:42 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Johannes Thumshirn" <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>, "Tejun Heo" <tj@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 02/16] block/blk-cgroup: Swap the blk_throtl_init()
 and blk_iolatency_init() calls
Thread-Topic: [PATCH v3 02/16] block/blk-cgroup: Swap the blk_throtl_init()
        and blk_iolatency_init() calls
Thread-Index: AQHXY9sxekxvzBc5BEKmzW4HMTEMFKsaeMQA
Date:   Fri, 18 Jun 2021 17:15:42 +0000
Message-ID: <20210618171542.GB89662@bgt-140510-bm01>
In-Reply-To: <20210618004456.7280-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68FE835A7D55D14BA70C4088089F04B3@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djXc7oHrpxJMOhdwmmx+m4/m8W0Dz+Z
        LVrbvzFZ7Fk0icli5eqjTBY3FrxhtHiyfhazxd+ue0wWe29pWxya3Mxk8Wv5UUYHbo/LV7w9
        Lp8t9di0qpPNY/fNBjaPj09vsXi833eVzWPz6WqPz5vkPNoPdDMFcEZx2aSk5mSWpRbp2yVw
        ZRxc+YGtYClXxdopzawNjFs5uhg5OSQETCRObXzODGILCaxklLj0QqKLkQvIbmWS6Lr/hw2m
        6OiNGewQRWsZJfa8DoEo+sgo0dj6lQXCOcAoceX7R7AqNgEDid/HN4KNFRHQkPj2YDkLiM0s
        MJFZon2tHIgtLJAtMenYY3aImhyJT2feMkHYRhLrrlwBi7MIqEr8f98F1MvBwQt0xY116iBh
        TgFziRnXlrCC2IwCYhLfT61hghgvLnHryXwmiKMFJRbN3sMMYYtJ/Nv1EOoZRYn731+yQ9Tr
        SCzY/YkNwraT6LrewAxha0ssW/gazOYFmnNy5hMWiF5JiYMrboD9KyEwmVPix5oPUAtcJH5v
        vgRlS0tMX3MZqmgXo8Sc2R9ZIZzDjBKbLixnhKiylrjxsotxAqPKLCSXz0Jy1SwkV81CctUs
        JFctYGRdxSheWlycm55abJSXWq5XnJhbXJqXrpecn7uJEZjoTv87nL+D8fqtj3qHGJk4GA8x
        SnAwK4nwcmaeSRDiTUmsrEotyo8vKs1JLT7EKM3BoiTOyxQxMV5IID2xJDU7NbUgtQgmy8TB
        KdXAtFtd6bdJxNeyFXz8Zm6HdWLvsavGCj2U5rg7UUrx5ALN/PZmnYrgPcHis9ZPNvyYNU11
        w8Nz5mFPVR7t8X2rdu8D+4wV29fImf0P0p94QaO09IfW4skSzHZ7NVj7mwsVlnTH1d74rxEf
        wdtip1qg6R4Zde3DhqV6p1VWCu19Its6fx/zCtM1jxr948q/6njcTuM+GPEtTvSTAo+ImHOY
        QhZbd4Ji6j1T19KS2QbfjfWv9q3fr7Tmckd1g9FE3Zim2MaahZmWHv29eobctm+e/mLYs6pI
        WvfCzPnnVMqELk4WyHvSkbWZ81WITlehzukqp9WeN7VLkmyYb5TZLXVYEpnXYOps8CPbd7oD
        uxJLcUaioRZzUXEiANQC5q3jAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWS2cA0SXf/lTMJBt9+KVusvtvPZjHtw09m
        i9b2b0wWexZNYrJYufook8WNBW8YLZ6sn8Vs8bfrHpPF3lvaFocmNzNZ/Fp+lNGB2+PyFW+P
        y2dLPTat6mTz2H2zgc3j49NbLB7v911l89h8utrj8yY5j/YD3UwBnFFcNimpOZllqUX6dglc
        GQdXfmArWMpVsXZKM2sD41aOLkZODgkBE4mjN2awdzFycQgJrGaU2Lt+HRuE85FR4uaUY1CZ
        A4wSvXcusYG0sAkYSPw+vpEZxBYR0JD49mA5C0gRs8BEZom9DbfZQRLCAtkSv1f/YYcoypFo
        fPiKFcI2klh35QpYnEVAVeL/+y6gZg4OXqA7bqxTBwkLCWxnlHi6rgbE5hQwl5hxbQlYK6OA
        mMT3U2uYQGxmAXGJW0/mM0G8ICCxZM95ZghbVOLl43+sELaixP3vL9kh6nUkFuz+xAZh20l0
        XW9ghrC1JZYtfA1m8woISpyc+YQFoldS4uCKGywTGCVmIVk3C8moWUhGzUIyahaSUQsYWVcx
        ipcWF+emVxQb56WW6xUn5haX5qXrJefnbmIEJonT/w7H7GC8d+uj3iFGJg7GQ4wSHMxKIryc
        mWcShHhTEiurUovy44tKc1KLDzFKc7AoifN6xE6MFxJITyxJzU5NLUgtgskycXBKNTD5Xlya
        qaM+82yubvj8QL97ue/sl79qeMlvvrrndwGX6B6bxpxp/I/r1uSX5LcwF+yRWqk3K2ny6drX
        r3wudWzLdVlT/kjZ80vGrfNhy1hlJU/Pjjj2bSt7WouWic+NpgiWopeRcup/ug7J3NFusDDn
        c1k+WZ3x+CTbh61CG0y4JwjHPkpsfJW9ouTEDb7X9wRj387bqXtmc3LEtRapX+KWdWl34m33
        H9Bu8Lsrd7NUULltWsiC52+5Xj5YO0Xq3/qQllUeVjNMjy3U5c/ji9WQbvA8vnXO8wPe7u+W
        rfOusKxobuqQnVw4nyvX7dTB63cXHvpqWu3AvedFY1Qoq+vyKf1efyV23tt80O2lS5YSS3FG
        oqEWc1FxIgDDxE3kgQMAAA==
X-CMS-MailID: 20210618171543uscas1p2f93a7127657eb1c1c3fa990d322e9d32
CMS-TYPE: 301P
X-CMS-RootMailID: 20210618004509uscas1p2601aa451e11a38a4efe45e8853d2aa92
References: <20210618004456.7280-1-bvanassche@acm.org>
        <CGME20210618004509uscas1p2601aa451e11a38a4efe45e8853d2aa92@uscas1p2.samsung.com>
        <20210618004456.7280-3-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 05:44:42PM -0700, Bart Van Assche wrote:
> Before adding more calls in this function, simplify the error path.
>=20
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-cgroup.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index d169e2055158..3b0f6efaa2b6 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1183,15 +1183,14 @@ int blkcg_init_queue(struct request_queue *q)
>  	if (preloaded)
>  		radix_tree_preload_end();
> =20
> -	ret =3D blk_throtl_init(q);
> +	ret =3D blk_iolatency_init(q);
>  	if (ret)
>  		goto err_destroy_all;
> =20
> -	ret =3D blk_iolatency_init(q);
> -	if (ret) {
> -		blk_throtl_exit(q);
> +	ret =3D blk_throtl_init(q);
> +	if (ret)
>  		goto err_destroy_all;
> -	}
> +
>  	return 0;
> =20
>  err_destroy_all:

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
