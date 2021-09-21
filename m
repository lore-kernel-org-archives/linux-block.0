Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4A6C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A1E610E8
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhIUNhS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:37:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32092 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232227AbhIUNhR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 09:37:17 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LDDBXN017239;
        Tue, 21 Sep 2021 13:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JIQnVtVrOQzB14OYqNmRvB7hYYXNrf1sD+rIderQVAo=;
 b=ghDfA2ROPB4EuyMqwR5Y87LW1aAJhSd1jNWiDcP7dhI4K2mN65D4pWoQN+FAxmIg3oRd
 rVlZa0cwtEFzFShVbbnlPNo/xu2DZgShHPY04+FVEfY7WY47B/NJaHb+d4I5q0A6dADS
 07mYY6LSoFiafFVtGY6YApfuxZ4bQHHt8b4ZTHkkzWGJS7olj9koj5/Lr2WhLTEWzn/O
 6JZtUlfcHcoUcGsrlhIvxH9rEsZplZ+yKjcgLEjv4lx4lXiU6Xx3WenXhCUNUNf2drVu
 GmDbCAFbZXRpldmDsOQn9dK8tZyXd3mmOjazOdKbhwnAiPUZxJntyYaO9W1DXkwFxhiT /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b79adhvqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:35:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LDLYlM121537;
        Tue, 21 Sep 2021 13:35:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3030.oracle.com with ESMTP id 3b557x267w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:35:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmrq4uscd38nexjiN2ydXsgTfGlpSK8fuCov6RwlKB6YWTaj0i5IhqI/H5++RjpTp1Wj0XMB6sN6LjLm9KSpdwk6DP5dxIelMz+ov3N8wQJUzNtZMaq0c3E4vSLbQior5uKiix4my22/Nm5z41EFv8wzCnliu1LZgjBUy+2MWEV+FVm2/RJ2uQr2zIGtppwlFRSjGp4FOLHJ1pZofRiJRPZ9UCw/8h6ieejCs0jnR+HVSmcoIbtTva7iO4WwBuH59cKuD1NnS8CCcwxQzKS8aCYgx4GrWBoR1ospBO2H3E8Vgv0IH7cFaTUPuTdowta5QN/lTOOd+io8yL2XcFqXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JIQnVtVrOQzB14OYqNmRvB7hYYXNrf1sD+rIderQVAo=;
 b=TydnZHb2DCYK4KwHM7Xivw4JpXfFT2fYexVdWFNgLg5ZpL9EeW7qqhHgYyOG/e6bfiSEPZ1ga9EgkNHlxcJQbPXFodE0zZRcql5zukLZrl74UEYgWpBLrDn6fWmqA+cbniF9eEEPha5X8UqyOQbhlcScAfjZGZar83vG/PmxV1WbIVlTQXP50EFlnfp9ZOjzXHNWvtz6UJtZrpTfZ8uUYSIvkXwW5uXN2/aOFBdPNPjsFdC/KcWHRwjKvsDvRnzjZRGm3wAcmlw8P6k5N/RxsUVvr09FbRFBM7bLtZ7yAgFEB2NuUGKwqilX0afqPE36IRyvyOzzfDK+8+8oUZ8S3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIQnVtVrOQzB14OYqNmRvB7hYYXNrf1sD+rIderQVAo=;
 b=Nyv1Fh9rk81Mqm89ENNMnAoINr0i6mZlcPPCF+54Qhl2prOCulmEbDvICXDZjydSxj7D01jWtfbxtIMKjJ1q0vPDB6Q0zSpaDvaZh1WKsQJtPSScORYzkVL06FzJffXuZMF81z7QTQXKY9ZQLvZVE+x/xt2NbPKXeGA3v99uoDc=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA1PR10MB5510.namprd10.prod.outlook.com (2603:10b6:806:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 13:35:26 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 13:35:26 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 3/8] loop: use sysfs_emit() in the sysfs autoclear show
Thread-Topic: [PATCH 3/8] loop: use sysfs_emit() in the sysfs autoclear show
Thread-Index: AQHXrsoodqsYKTpDeE+okKs1LVFxVquufXsA
Date:   Tue, 21 Sep 2021 13:35:26 +0000
Message-ID: <5F504ACB-DAC5-48BA-9DF4-B86534B02B6B@oracle.com>
References: <20210921092123.13632-1-chaitanyak@nvidia.com>
 <20210921092123.13632-4-chaitanyak@nvidia.com>
In-Reply-To: <20210921092123.13632-4-chaitanyak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32f596a7-b006-45dc-4649-08d97d04abc9
x-ms-traffictypediagnostic: SA1PR10MB5510:
x-microsoft-antispam-prvs: <SA1PR10MB5510E4EF3890BCE2A8E80847E6A19@SA1PR10MB5510.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:298;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fd5yWrHw5gIOyrTHiGIJCuz9BajvFtUwBmtd1yIIU5VuuIuWgso+9d01VcnarHTAEDGgiOGwCGji1E81CRixMzwqXupcS82E+X9oUwTxn5vYW5cI3Zrij+G1Vs+EYAIJIUXjqP4naECKU/49VqU89OJVFeB1rUamWi8+FRGU6PV1LI9kfKB5e4R+Ydcaerb8CSa1AzwI+9bIMiDDXQg967hBJFu2XDyTkqNJZLPy2OewNf2lkhgi4MKXl5aKqA7VhjthrrD1w+QRhthn/jsclWfjbPUv993Oyk3KhsmXxXkaIzmZy2ubX+PUoxsQZL0qmG/QaeqIde+W9YFT97K9WXiy4qdDyQ3IORsk+SLhCTvlK20y65eMErLoMCoPstSJoSeJGNWDACssVBgBv3mGGJJGtPTB1+uCtdDyAJgnEmYt6uvhq1EZonNczvnOYUznvzE4pMyzzZZZSWnVTyOuP5HK+3DRVmx1AvZ1jOc7lShRLITMvzcuw7RYRpQEC7knWuqPHf0Z+xRzxVjNGvIsVBJ0gMEoeSdGPsNntUM8EXaKk4sUmfjp2teS1Phs8PVkOFssepWWb8I6vD/OIXyhSAKPYy9e0JnqY/LK73Ol5ObzD+GF1kKRcCDZNrHZHxLlfqdtKmTVZnSbkQ/KkcyHMQZ9tFOMqKrkA5MFJ828gQ5doVXIPtm3hmy+Mgq/wuipIDuULesoUkquhWRwOODOvo3eZDfNGGABteaKLOdjxBHIpUxLTkwU9SxFhUlQXXaA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(8676002)(54906003)(122000001)(6486002)(76116006)(2616005)(4326008)(316002)(44832011)(71200400001)(6512007)(36756003)(86362001)(53546011)(6506007)(2906002)(508600001)(33656002)(8936002)(83380400001)(6916009)(186003)(26005)(5660300002)(38070700005)(66556008)(64756008)(66476007)(66946007)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tQzCMA2seWHemuLILyApPUYWkJBoPlAjZcZfEkTOfPdUPm3uE3+a1HdifMUx?=
 =?us-ascii?Q?jX/VgGoU/Ywpb14b4ehXh0vYaspyEQM0yb4HqHu3CPwt8NGMTNLLtRn/ftRk?=
 =?us-ascii?Q?NjGROiQl/ru2rzpOvZ5TKDbTRxk3AuTqDJJAP9GeK4LJkEN/UwJ4cTmZ61vb?=
 =?us-ascii?Q?9/5KczxMDtxJAfArt2lOdjL2juc+IQ/cNQGw77GjeRGUqa4UjnScqrVhsJqv?=
 =?us-ascii?Q?dw7uvnMoRYD+hVvkGQ+5MN6YGOlwSSWgbo7168BhI3YBptKsgirnT5O4mCeE?=
 =?us-ascii?Q?C2TzLytlPm8wQCzqOvdNhaWJiKYvbGIGqmQermbYh7VP1AsntACkFeJKun+N?=
 =?us-ascii?Q?+9BvEKmHlG1PHVElRc6P1jPtYtjFgNYRV1dplEH4TFiLeFMODGeuq6FMzQbx?=
 =?us-ascii?Q?lAxGH1pHQeO+pnDroZiMfXNoz+7rM7zfUBC5wzghStca9UmUV45Y5ux4Pcbp?=
 =?us-ascii?Q?1RzhmCNnA5weVNfAj4BbK9pBz/XJj5zyauhBI0Xxz26oJN6FCSMaR5uZNQXz?=
 =?us-ascii?Q?FgyKFY4yOAEfKK+Z/v9XwujqwuOfUy0+eGzGtrYWjsUbkehsdSMxqVwguHSC?=
 =?us-ascii?Q?McZ3XRo/89u6pLeSID+8dUZWxYH/oVHE34dRuDVwWHvop0NOjLFyevI5Jluw?=
 =?us-ascii?Q?iJLnzvw1G1TijTXWfQB+0HudKOrWZO9A9kHGrIKGLH5chVv1wctKrA/VXc0X?=
 =?us-ascii?Q?BcAkHwCtcojUW+h/Xg6CQnCdXRnqSIJ3kyequ0AL0xPN76I2932I6CzEapFE?=
 =?us-ascii?Q?k5UtH5oGhhjlA3pTJmX/Mssnz+SP++ewrAuUvh4iJR3urbtLtpDepaOOhRG4?=
 =?us-ascii?Q?hwfT/j/iV1p4almt887qbCJ7zQZ193vLd1wxhZb6gp42bmCugmUQzGscrsJT?=
 =?us-ascii?Q?0OT4e/WpN7yyaQ6GyCq84iUMrvwCGM2aeYQr15iBlSB6CBn2kUckIPhZ4J/j?=
 =?us-ascii?Q?DLSu5ya3uKN1zrwC4/2bEaG7uVsG/pTOZ79P3XQI9kG265nWIfpvIaZUvowB?=
 =?us-ascii?Q?QRyQmrVDmjiGqYWSGEsl6+c72uS1NN/UxXqSkmfEVhnoaKGuFFWc6qYSsQZa?=
 =?us-ascii?Q?h/rGtg8P5AP8PkqtI1DuFfTBTVUjKL6y8PkOJGtpko8L5LLPK5IuS7cKricP?=
 =?us-ascii?Q?doINbn4B12zQMVqJdy/D42oVX9L5zPY32GrwdAAeGdiTaZ/GiCXVsBfkoK3S?=
 =?us-ascii?Q?svNYGpTNL2IAfsHAXi2ADqQMVgEowP9n4G1uIydWmRzVp3LgbFZdXRVlSwre?=
 =?us-ascii?Q?J6c8Dt8rsOpqehYEoac86uVXiT98uNFGZWM2uqnVd45ibeRs92/SpaFhytF2?=
 =?us-ascii?Q?P0af4Yv1Oyk6roQAoxOGy2+AA2Mj5shAjMU2xv09ymQ4zg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED48BC1A44EC704BAFCECFED513E4F57@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f596a7-b006-45dc-4649-08d97d04abc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 13:35:26.4212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tr8SkQkTG3HG9ldcu46X80kC/mXkGOHZam0lSFcCgfi0Sz95ICtgoBjmFa9CqSaPJ4tTAF+u8WPxHJogX4M3ebypdhKEQIDkkVyHV1us3Hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5510
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210083
X-Proofpoint-GUID: _hfAjgjIfsOn8H5ExcMw9QqnEVoFJ4D8
X-Proofpoint-ORIG-GUID: _hfAjgjIfsOn8H5ExcMw9QqnEVoFJ4D8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Sep 21, 2021, at 4:21 AM, Chaitanya Kulkarni <chaitanyak@nvidia.com> w=
rote:
>=20
> From: Chaitanya Kulkarni <kch@nvidia.com>
>=20
> Output defects can exist in sysfs content using sprintf and snprintf.
>=20
> sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> used for outputting sysfs content and it's possible to overrun the
> PAGE_SIZE buffer length.
>=20
> Use a generic sysfs_emit function that knows that the size of the
> temporary buffer and ensures that no overrun is done for autoclear
> attribute.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> drivers/block/loop.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index ec1329afc154..fd935b788c53 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -868,7 +868,7 @@ static ssize_t loop_attr_autoclear_show(struct loop_d=
evice *lo, char *buf)
> {
> 	int autoclear =3D (lo->lo_flags & LO_FLAGS_AUTOCLEAR);
>=20
> -	return sprintf(buf, "%s\n", autoclear ? "1" : "0");
> +	return sysfs_emit(buf, "%s\n", autoclear ? "1" : "0");
> }
>=20
> static ssize_t loop_attr_partscan_show(struct loop_device *lo, char *buf)
> --=20
> 2.29.0
>=20

After fixing small nits noted in patch 1 you can add=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

