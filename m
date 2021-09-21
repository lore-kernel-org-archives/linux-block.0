Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ECEC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4EE60F48
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhIUNi5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:38:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33468 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233011AbhIUNi4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 09:38:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LCrqW6004965;
        Tue, 21 Sep 2021 13:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0rY9kyOgC4QGiMbrdd15PmjWkl9bF4Kyij/bnaJje1o=;
 b=mw69owGkHuZgbYBDTP1TDbNtfs1xDjVaBdmOD+aT8OP/WbndDD3Et13+ccmTbdg7hkgz
 RWHBVGSD8yPFBBnX6rZRK+3TeRMk6HFN8fkg6L5d9MUNbAAefVstdiricZWjS+yWh2eq
 56x9fvMgRFnT4i5ld1PX/ms2rt8NB52w7Q7GlcxBmYOAbVAaJVnOE0F2/qRl9/qFGuCE
 w5eQQ+gQlMDDhdKNAHJASvE16GstpLY6JFoALoOZfHYBNnQ5zGLtPVssLLHz7WY4Hhq1
 rT7+IwJt5Emcm2dY7KwIrL4f2k3ZG9au33QZY3we9krKqEkRcjTaKCnwQ3TWhOnL76ty iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b796ca0fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:37:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LDK0fA013622;
        Tue, 21 Sep 2021 13:37:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by userp3020.oracle.com with ESMTP id 3b5svs7ww2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:37:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhTEAQill59LrLRVJ4LatoNwZBvKhFEpoAPCbFlQnoF3Giv2LM93yy11FTzz9tHaoyU6kjHTv5rZjkpSpFzBazEPPRMPPeBRp2nRPQfIyrTXXojrUoaXKp17JH+5om6E568BIomSs3nlWB8bdxixqDqS3mAPevP9rKmPHLQCKQGpEm/UgelZ8sRQ2LfnPCeMNwzvgaV44zkRToErhJZlOSjc1+Pk/NgRaIVQEYYIFOBMLf4nYfhUCejqij7NrhFSchqwbmdIFkA4DXDpw28sjdg+tdXgD0oYNKYFJ0RyL1Tymw32z96gfZRJqLLclQCJFcNJWP2joCYkPGd63OuECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0rY9kyOgC4QGiMbrdd15PmjWkl9bF4Kyij/bnaJje1o=;
 b=JwtQ/HguVjg2zUTny+b5ayY5gQP8YmIWPi0sEoHrL0N6Hsu6DEPgz3PR0VVTSpQDpb7WqYrF8GXBv9+CxEnc1Wp3zSsB4KWPbvy95N/PmEztsbirlq9ck8NXUBWUcFNlVWxm2Tqexqa0+lleRML4FH4rNbAgnYKyqrjD5eY9yMmDZO/DSoPSRvYYLcMrMEkzanOkUWubMeyDTL/L/utgJQx48rgM+h4oFh3jU64Ot2T2xflQtWwNxEfo1UPtpleZ5DHh/MnHIRSHJO0p24NJhP8ZbIgsZx8xZGZGDBJ7rRldj1q1cXXi4n04HnDMVNy6ECRv7HzhDr778p7OM9vVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rY9kyOgC4QGiMbrdd15PmjWkl9bF4Kyij/bnaJje1o=;
 b=rAdVppVcbMnt/nH1o59nabD2d23+fRgrk43cXvOfq+GDQ+Wm+toPR95yFYokD4usH9DRP/W7ez+SFbcyJuV0abpzhIEIcOMFjSHAyMjgSXvykmDyxc46dJHts4+lkXSMfLy+IVS1eDbTBUvPNgMhumUyiB5ZKgaLhxC67ek9MfE=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB3454.namprd10.prod.outlook.com (2603:10b6:805:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Tue, 21 Sep
 2021 13:37:21 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 13:37:21 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 7/8] loop: remove extra variable in lo_req_flush
Thread-Topic: [PATCH 7/8] loop: remove extra variable in lo_req_flush
Thread-Index: AQHXrspBABs4uhRrj0S/aiikKZqi0KuufgMA
Date:   Tue, 21 Sep 2021 13:37:20 +0000
Message-ID: <433B1173-C70F-48EB-97D3-2B8946CE4B22@oracle.com>
References: <20210921092123.13632-1-chaitanyak@nvidia.com>
 <20210921092123.13632-8-chaitanyak@nvidia.com>
In-Reply-To: <20210921092123.13632-8-chaitanyak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc776699-2a62-4e8e-d07c-08d97d04f013
x-ms-traffictypediagnostic: SN6PR10MB3454:
x-microsoft-antispam-prvs: <SN6PR10MB34548CE66EBA261703DED5A5E6A19@SN6PR10MB3454.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: evD8hVKq3kdPdaEhoeS4FCZLTPG9xMDMxYglRve/YFnXZhJUvg+UVB2Eho5ii7ggsrPTOG1uMY6xmum9Hikdqttd2rktbyy/ADiXWflsx4B1eSztbextbnPhTUXUHx1BEl5e3bNfQtGTHvz3K8GkXKu9nzD5kw8WEK35sGPME4U19/7LpnJe99d/YHxXCC0BykoGXJAAu3dDgFLAt7mJLp1r2c8GIxgRNO+UJ7ts0z/YI8IiHV+KJQsbbL4+juicBcXQntrAuHO0HX/5VRjsh9df9GEqLE0Tgy82CjuXwYpHvyjijXLDorYafXbF2wIzyVW4INxirWFLzs7CsXFY73yV80CTlJ37lSmCvTgcubu005Ip3qfOetTJBmOgnlGSKvcRz9QbChW9+7acAzD8Pb/2KTxXmc9jLjyZFgMgxoSYzpjGYpOssisH7Fxvc6xuKjurbFnAmYZp7R/MO6v0M5n3EdQ81bvqDsSroLvw7QWwCdIsemCEfJBYqNpqjg7g8oXeS1D0UuiRUfYet06GsHDwehcqtadOki1rLw9PBK95mLIovTZ4BfTCAVD9AMm4i6llI0TbOe3F8TOlwCoXJDZy57ZV5DzcsdIRHsn3BifPXXbAhTUVMA+WRbpNCcqhB+0JxgVjfd/lS/ellYEPH3qPDN+8wgELYibGW4yqKuiEzAUc/j/qB1Tz/xVKo5YuGy4DDpsZ6bW8M8b8CIhZoV/gxbYrdokfWm6klUR6OgPoFM0BDJYrxkBO1F19pVRo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(508600001)(6512007)(4326008)(2616005)(38070700005)(2906002)(6506007)(66476007)(64756008)(44832011)(122000001)(53546011)(66946007)(54906003)(71200400001)(86362001)(26005)(186003)(38100700002)(6916009)(66446008)(66556008)(316002)(8936002)(5660300002)(83380400001)(76116006)(8676002)(6486002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1gAs+1lLf4d58WPizsUfyZJafOhRRNLOn7PMvIV6lsHT0aHcNvwCD+j491om?=
 =?us-ascii?Q?TPDvM7bGWD2aCAKXE0ldwsGb9bxblKosz7JUrLLJs8oCw+lnLigAyD55xucJ?=
 =?us-ascii?Q?dJYzal7Wb1HqeyQ6kuHXg7VssErVSTLiJX9N1vhp4zg8WTSJ5QyiFRYzVT9N?=
 =?us-ascii?Q?/JsKAzPXLobz9nlIPcbknQk9qpVsC99uXkaZlx75sS2PDUN7aVJ3OqBi/MaO?=
 =?us-ascii?Q?b2B25WZ2kE0NLq1r7HZA3any7mrkPfBBgrUn/FahpY5+S1kEBhfN+RjVabkf?=
 =?us-ascii?Q?e62H1C/jopr2kLS2XZDMHzemlsnM1h2iJNvIe6dfQlCVqaAR5i+qcvDIWKHu?=
 =?us-ascii?Q?NgwYGa0PG0ayGvyZwH7FhdLv/lVbK0o/IgQeNYt1agTI8viLvM84Yw4NcgtW?=
 =?us-ascii?Q?7ZqlfF8mmH1Cejd08wtVAD6e3JKqevWyIidGYyRaGKyMFK+fo+0HCO1PDs1I?=
 =?us-ascii?Q?NJUfZu1w9nHv8hP+aRZALJ1g16jGsllsFdoKKce810841bSkpsMSWv7WXKK/?=
 =?us-ascii?Q?Dm2cw4/4CR5SITC4nlZ6fWPVvZOtIu+cjgDJR5QhpqCK4GC9wTlLs6iyDXIz?=
 =?us-ascii?Q?b87R6sgUWosxgQWBd+aKTCf+H+MYlStN2xwC3+QJXMLhPgzSY0qUFAhantnr?=
 =?us-ascii?Q?nClHL+YwDECsh9ks1uAxkraJnCBszJs8gp+EgLx7qjXoa0zNd8Z8CBUpiqAs?=
 =?us-ascii?Q?9ddeKVmUfb2ReNAf69Mv08MCCYh5iyaDZEYmLPafK9Ppn/2cafO9E0Ac0drT?=
 =?us-ascii?Q?rSaLmz7Ui++XjlAJR1utS2taNjPzcInyGzGGLjxILS9985hJbAIfrH6O4ICV?=
 =?us-ascii?Q?6350khHIUfz5L121/bXP1q8enciO1Epl3ReVD342Ld+QPofI/AcLAnYOmtPo?=
 =?us-ascii?Q?er1WHIJe45hqYiZioXyoyo6MwsfhpUTejvybe6q3gqZn+cNruyCCQw24cy9G?=
 =?us-ascii?Q?xzTmWneJNLpVGoDaBCtASLl3bj3kPxkAa9c0s8Y3kJ6EidR9YpjRus/j8Xwk?=
 =?us-ascii?Q?EVQ6IDGVCUeBOh6jLOAL2q1Q+fQirYPfvKjtI//UU4nHzZ2kOBRQCXfPRIdA?=
 =?us-ascii?Q?e9CfzDHmMQRSeT12zxODdZBgkfhCreTYqfpeuIyIad9EybF5u6JpVygL8nda?=
 =?us-ascii?Q?QJZ0G95daPa5Lx4dSZiBB4Co+123po29xm5kW9NmLos1cDB3CDMVrFxopNN+?=
 =?us-ascii?Q?ygUuINVrACvR0K9WP5li29Qg3WucX+mznOIQxDvYGAD0L9vk5GJJw58PXKfQ?=
 =?us-ascii?Q?7eDrOjkEYwlrivIuXTE5bAT/BL1F1CGGdvXthNegY1J8RPuFDdpwqiV0JkpI?=
 =?us-ascii?Q?K8v+lijN2y5cuiL4nvGtUq0kj5TH4ZvSa9Qhfv8aaUmUpw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB624A8B29DCF641940D30F6F20E6A77@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc776699-2a62-4e8e-d07c-08d97d04f013
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 13:37:20.9917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixTGrJIoPGwRIPPjZqV6cMKDtsa7QMZUVvEIVJmpVfcPpZ9Q/MNMuP7MfFzoQWcFilwRwSoJbM4IPt2oSYXdB448Eo2KeIuDaQ+OspiTK+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3454
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210083
X-Proofpoint-GUID: 6zsLYkkDRhL8h-3GY4z_r9LTr747ogf9
X-Proofpoint-ORIG-GUID: 6zsLYkkDRhL8h-3GY4z_r9LTr747ogf9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Sep 21, 2021, at 4:21 AM, Chaitanya Kulkarni <chaitanyak@nvidia.com> w=
rote:
>=20
> From: Chaitanya Kulkarni <kch@nvidia.com>
>=20
> The local variable file is used to pass it to the vfs_fsync(). We can
> get away with using lo->lo_backing_file instead of storing in a local
> variable which is not used anywhere else.
>=20
> No functional change in this patch.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> drivers/block/loop.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 51c42788731a..6478d3b0dd2a 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -498,8 +498,7 @@ static int lo_fallocate(struct loop_device *lo, struc=
t request *rq, loff_t pos,
>=20
> static int lo_req_flush(struct loop_device *lo, struct request *rq)
> {
> -	struct file *file =3D lo->lo_backing_file;
> -	int ret =3D vfs_fsync(file, 0);
> +	int ret =3D vfs_fsync(lo->lo_backing_file, 0);
> 	if (unlikely(ret && ret !=3D -EINVAL))
> 		ret =3D -EIO;
>=20
> --=20
> 2.29.0
>=20

Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

