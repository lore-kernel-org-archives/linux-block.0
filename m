Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9F0C43462
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 17:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0235E613B6
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 17:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbhDMRVO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 13:21:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47120 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhDMRVN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 13:21:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DHKdnl036037;
        Tue, 13 Apr 2021 17:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dBvuSBksH3SR7P7GSp1MmdDW9ZTtzhn946suRnZEXMg=;
 b=QO3HNUSf/IAHfTp+bufYHrkSIPQHiMeJyrP+7hCVo33cbOvT/ME/BwnmdAmHjRsRxQ8a
 KA3n48DRr6x69lFy2zxukkoGdokStnhTdBzxdsM1QdTJ4g5StfLsQ9mxoMDWzLA8MmlK
 jCx2F26oyhJbQMfcgLQLSoh+zDTPNp5Ix3rluKhGhjMj3AOJnk7L16O+6rFWjNb9yLxG
 LvKI9ut6TU8uw9c4iaCUkRn0pzDB0l7hqtJPQ0rGEUwl3ZCpgAWaTNS7QbbpzDCQYPVR
 nj+dmfnoVw8KDcjz/YjNBfQDwt7/ps1NmlH/tpxE/ojcqyQdEZMbr9m44rn8bZRRvC6t cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37u3ymfuaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 17:20:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DHKMU5165579;
        Tue, 13 Apr 2021 17:20:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 37unxx4v8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 17:20:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbRfn13qOozIZqABEYpss0mlsiW0V4AXAaHSYpJKfOQwXjXi4xZky1NPeqe8EbJZ5MM5ACACqsMq/9eoYMXGIO35uwQfnxh6ArsqA6T19uy/0bIbJxdcN2sGxaKUf8c1sW55QNL/bYuM1ksKGvZCBkmuvYZKMY6sTlrB8U5+5nGdHiL+biAq5b2Frn1pRL3Os8D+mWu43I1FV+sYQK1RINtdMAP4h4z4wekjdqTYPi6suC1U3LP5oV0WvvpUfAgqviR8U7EXwGpx/0YJBl+ygpwJocTXwTclTVWXbmVx8JKYuNVOlEkSlbjf6LjihINi9D8C2d+fZiktHod7YIP0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBvuSBksH3SR7P7GSp1MmdDW9ZTtzhn946suRnZEXMg=;
 b=FpKCSlMoykh1KIsm0scY3V9+2D71P68K6hibZ6BPX47yih7fFvjxp+vQ2KCAZkVzwELuWaOYVzVDT++QCFBMBpYXhvWMpaxPXaLUJKZ4G75Dc+TkiFRvQr5s3h2vzAdt5am4NcG4zKP9lI5AVd4oPAhJTb5n/GmHVod78ROfkTg7JJB1yod9ohVescK+bF50nkhPJFVB6SoGK5YI8IwO6VPZ1cRfq7f+FoHw5vUwvyMH5HrwwHGwLqOifAJ56h504edlUE6uh2hYt5XkOZOj9c08NLCMuLA6dxnnQ6JCSnJyPjeuYyaxsdk/Z17ubkw05HFrdvaOLY9SwFtXqwZcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBvuSBksH3SR7P7GSp1MmdDW9ZTtzhn946suRnZEXMg=;
 b=jAb4ySx8Rgy3oG1r4Kmc9AqyG0zG5QHECgoUIMYI+yaFLYxkVbTm6ZsqDA/DiC7+dD5rS71xUDuCGw5SqhQ+X4ogDUXLS+YpsBPCGv8b2LPgY8zxlOUKKo5Yw6bh3e7mduVhuQf82Xx/PIbRjsMeMhEIgl095aT9wm+Vguao+Xw=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2461.namprd10.prod.outlook.com (2603:10b6:805:4f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 17:20:41 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1%4]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 17:20:41 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] block: Remove an obsolete comment from sg_io()
Thread-Topic: [PATCH] block: Remove an obsolete comment from sg_io()
Thread-Index: AQHXMBb8YasAp/bObUWFsjPYFLqFv6qysngA
Date:   Tue, 13 Apr 2021 17:20:41 +0000
Message-ID: <F9FE74B7-5367-49EA-AC27-27A146FFFD26@oracle.com>
References: <20210413034142.23460-1-bvanassche@acm.org>
In-Reply-To: <20210413034142.23460-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [70.114.128.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37fbcf53-becc-44e0-a747-08d8fea076ba
x-ms-traffictypediagnostic: SN6PR10MB2461:
x-microsoft-antispam-prvs: <SN6PR10MB2461BCF1F7786C80986E481AE64F9@SN6PR10MB2461.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PUlvQVOIHH83WENiqQ7d8UgCcvZ/DJNtRUF2WhME66q/5MJA5l0xB2UnLa7nK4LiGteNDvFEh36PVLUNQ+orrRanEt7xSm2GddPu4Tt54z2RyymzNCGNibig3Gy1RBqkLdh9svgUGoKjyxwBlPQTkDMfCRUM6tAJ8ZnBhutnNGiv6RcRAxAGIHqUe8WJOVTx8EL56J7v6ZpoOyAdxTdOOPDePvLIXc1PqXh3UmRrGrevseZ44KFSp7eX3K1Bk6i/p80Gw0lRYCpc4ZPissQsaALBTfgSr8CfQYQANGTWnv4bT1eaXiCD5S7AddgQQoi4HB/INTXYmSQa8orfdB/zR3uws1ZjLJy9kW7KC4D/mIALeN1paOtMMoOrEz8YkVhwsVIyZli+6X4GHTPsGN7njMoVPhEF/zfBTyB9f6hJ+3x2FCS4DTazS/qhiLfuWI81ETgcN/TANf+zpRk9YYLmrjUsGFp3uMpL+/BfvV0ceaQpylLTgT2P9R0Wc7GOvx1xZdt1ZtuyShO9yBFOww/9UApqdGm4kn24IxsM9y1pfXaxnigNeEPuLuYfm9wb25RmYTi8uGSrc4RgZ/WVgzuTtaVv32ygdxoAma+KpXDQa11Ot3sfeT8DPBFCBtGYCrc9UPdlWzYVTIxDtcQL3MxqUZLj3ank+Q0S/qnRI5nl9Jg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(376002)(136003)(396003)(71200400001)(54906003)(6512007)(5660300002)(8676002)(186003)(76116006)(86362001)(6486002)(316002)(33656002)(6916009)(4326008)(83380400001)(66946007)(38100700002)(478600001)(6506007)(53546011)(26005)(2616005)(44832011)(66446008)(66476007)(66556008)(64756008)(8936002)(36756003)(122000001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BRf19An48HTXGwINOsiY1axNnyPWA1BVvZc010cOTwSxOKExewXAnSrx4TKE?=
 =?us-ascii?Q?W/IAOLy12zzoM+PayZnX0Zr1LQu3QkWU0oxaD1IFX+W+Pwh+wT+NAWP/zeU7?=
 =?us-ascii?Q?ZxzqLDM5UxkrIQQENY82EFHUFR+lMwMVAHeK87UG0qluIuvMQuSiXYpbG0dn?=
 =?us-ascii?Q?Hb6rGOgccOBiv2wZKVN8AEEUVSlTEmSaFJT21x4A6hADaLCNWuXztcLGMRV2?=
 =?us-ascii?Q?0ZiO4yHQu3NFEf8j5r0w+i4FGDxelZyZFKObbddoi92mK6VYEqhr8wQsPgPy?=
 =?us-ascii?Q?ZGp03pXphnwXBkko8UIdUjYhWZOt1+kx+2wfOuafkA6meUHot/cp5vekPNix?=
 =?us-ascii?Q?DoheuOKfr1WQ5UIE8OHZHRT/b9xp80d1J8xkOoxrrm/43f+p7TV+7moOA/ll?=
 =?us-ascii?Q?OEMKslQJ7TxBhJMe+8qJfKAC4cJGfrVrefFG61Ixc1b5+dGOEcP7XPKLADmD?=
 =?us-ascii?Q?rk02Wf7/FZ3Q/JWHPtoqCi2m2dSYONxRMknWo//nM4THbpH9HjoqjKtMPmgi?=
 =?us-ascii?Q?wbWxeNYY04KKHgADTQqmTpWd0DPMgX7woetE7/O55aAKStrrepkThHe2/m9i?=
 =?us-ascii?Q?wamO37pXH0a8T0uwVsWDlL0gleK6uWpC+8Wn1NQI5z2PdS68sTYXK/rKP64r?=
 =?us-ascii?Q?Y2SxO4McUkgTn7008IqTI8dsT1wAy69sKQjZgTuUlHLvMkRvm5Co+yiJi2KT?=
 =?us-ascii?Q?RNCSF1twHfTPq3JjPn2FgV3hnhoRaXmzG70uaiiXN3CkrRfjzqH0mLD4mx0J?=
 =?us-ascii?Q?MZOriT00PMQdWzn7gOH/6kEAad5f++136Q9vhJ2yhRjhZoMhvKJrzg/smGyV?=
 =?us-ascii?Q?DS48EIH0ZuVEuIolOtpjRK+oHJzPhh6sX5fb5VPtNj35RMc1sNWnG914xVaL?=
 =?us-ascii?Q?XpdtU2un3Z75ItKcLjzylCrtDjJNPViRPjkII1oOPQ+rvLqFMCFr7mXWT4pV?=
 =?us-ascii?Q?hVbsys9TjGNfbrwPX5WmfOivBTQFEOtZp1f/s8LaG6Yh0YtPjcoF3FqPBSRp?=
 =?us-ascii?Q?P4h0N4ocn9uqIbKdndFO4znTHYMzeHJgQ/lnhETNaK8jRaoSJ/JRPH9N3IRe?=
 =?us-ascii?Q?IotRCldvbbKlbdpVAVhYUCegkvtBrRdVE5/QfAikW1ObbeTWZWuee4s41gpd?=
 =?us-ascii?Q?WZg3Z+iw0mpNDhqJiTlPsbaGGTDm0kX5zf3n8XkCV/3L6gUwOe+vaEr0Y4Og?=
 =?us-ascii?Q?pUY04Se4t2GsyeEKF909PoN1D2TVr+RveQnn3jkmQIgeB0Kcuk4KY8x55bRJ?=
 =?us-ascii?Q?TIrvvDNrvfY9mbTsifBO6qm9rcIHNd16e2K+Y+kSnmYyCmVAPENvKPieyKTC?=
 =?us-ascii?Q?Rb2QLJPlzb8vhHFjbikYIz6Cm/YShaWYoqbbpZdcbyOcRw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <102938BD8276BF4C8D25385C405A344B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fbcf53-becc-44e0-a747-08d8fea076ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 17:20:41.2072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 301dMOW6jwls9iZNV+l1wOm6j0AMv6pFlb74YTF6UvZModRB33WUyKMf7WfieLes6pzLQUlTIh0OQGkfSR2JW3m4xZJ0Z8hIje0T7s1HqdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2461
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130118
X-Proofpoint-GUID: SYNaYIKZNlAVQeHLqOHR8E9eyER-7tlw
X-Proofpoint-ORIG-GUID: SYNaYIKZNlAVQeHLqOHR8E9eyER-7tlw
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130118
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Apr 12, 2021, at 10:41 PM, Bart Van Assche <bvanassche@acm.org> wrote:
>=20
> Commit b7819b925918 ("block: remove the blk_execute_rq return value")
> changed the return type of blk_execute_rq() from int into void. That
> change made a comment in sg_io() obsolete. Hence remove that comment.
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> block/scsi_ioctl.c | 4 ----
> 1 file changed, 4 deletions(-)
>=20
> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> index 1048b0925567..1b3fe99b83a6 100644
> --- a/block/scsi_ioctl.c
> +++ b/block/scsi_ioctl.c
> @@ -353,10 +353,6 @@ static int sg_io(struct request_queue *q, struct gen=
disk *bd_disk,
>=20
> 	start_time =3D jiffies;
>=20
> -	/* ignore return value. All information is passed back to caller
> -	 * (if he doesn't check that is his problem).
> -	 * N.B. a non-zero SCSI status is _not_ necessarily an error.
> -	 */
> 	blk_execute_rq(bd_disk, rq, at_head);
>=20
> 	hdr->duration =3D jiffies_to_msecs(jiffies - start_time);

Looks Good.=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

