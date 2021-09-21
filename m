Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F212AC433FE
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70C961131
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhIUNgy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:36:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42744 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233054AbhIUNgu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 09:36:50 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LCsUxg005091;
        Tue, 21 Sep 2021 13:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HOlybDeZh3BnmzaCPmLOlwZUcE5We0ebIDJWMBrKE/0=;
 b=rzzDA4wwMT4AIvWtgmUoAfKJZ6ct4ejnNQDPNhZ4b1KSJ5cdeApbGEt948GQbnvWANO4
 CDZrQUEHfUZZAb2v+l7uudd96zto23NyBD8oZ3uafMmGZVlw6zTB+JQ/9jFqsL2PiXG6
 irDlve3Z/XjNY5B3Ib/tGVSTOX0ofwrJJq4icRpA6O/3Y05JWHa/Utw9Xe2ZYm27A4/T
 lkyVz2lwtoz6pbAEgCE5/ZzsKrvAlxCwNQH0kdKUza97/ljhqUSMQtWAGt80IpEQbxxj
 k8s9DWrFQA4lLQ6UR4ReTlJpt1lBlsJbp8Ma5IHC63Af4ZCuhoyPH/pCmcoaIrkUwLAK Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b796ca05q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:35:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LDK16E013639;
        Tue, 21 Sep 2021 13:35:18 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by userp3020.oracle.com with ESMTP id 3b5svs7svp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXaBfbhO4ODRSVhD7+ZtisNGbdPYqSJVFJWxWAajbR9hiM3xqSB87AlQt8azs9rPuO03hkOtRT4YKskLQvqvmb3xfVXzF+Wih8OLoqiJ9eDL5aYBXtJH1EMAoFddGKLHF7mTKjwJodDioU8NLvYo6ubIx0XSZBfZweGONYfTKihuo7F/rUNeOhgI3Vnm0AWTVEH6z7QGGrF35OfYCj/o9cN3D/KOmETrfMMtH1Mm7yt35aGWPSHBTJMZE3RMRlQRehem2KxV17N8jB6834JDn/WtRKzqNDmJIfqVaehGQw4XC2L36lf8VH0w8eFxOc2ucSInrJRXbn6uX+YRhsg+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HOlybDeZh3BnmzaCPmLOlwZUcE5We0ebIDJWMBrKE/0=;
 b=IZdd5EFb+MYlOlhNC54zsz27G8nfQDu2GiXGQQrHRNUB+8A33l6JMBXNJO3sIB5fkChN0lnB4lrkFW5S/KWX2njJmu+zRXVFPJQLQN8O062yQSh5e5+depb+wynrepQo0zyTFQeRniay7sFQjRg5bQIo0dp+LOgylzM883Rh7IRrCG0Bu0A+b7+tF+VUmlReo/S3/RK43C+iXGgn2tuBm1e2xZX0suD8668+yyquPIf5Rma4Lpz4pOS0I4FjSCQbkdVKcDTJSz1w5EXy6co8toss2D0nB5l6rLUi0qIZ1kZRJTOFhLGY0iXGPdc2TP2Mmz3gHezZEXZySoYnQVFWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOlybDeZh3BnmzaCPmLOlwZUcE5We0ebIDJWMBrKE/0=;
 b=l7te9CMcPnaaaDzxkLxSMABpwjebCv0MR0Dj7IYOhu46pPAd8dpHSJ4yFKXE+uoK+mc5yBsaIRz7Ep3TCaILrEnO40wUixh/e+sN0YR/8+LnqtAyZAmFCpiC9vMct+A1grVY0+IDaTozHSdR9/YNeqv2fdU3CUJKfkbQUXIFRKU=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 13:35:16 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 13:35:16 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 2/8] loop: use sysfs_emit() in the sysfs sizelimit show
Thread-Topic: [PATCH 2/8] loop: use sysfs_emit() in the sysfs sizelimit show
Thread-Index: AQHXrsogT0Sddi/UqUmOGasnueyTNquufW6A
Date:   Tue, 21 Sep 2021 13:35:15 +0000
Message-ID: <963633EC-7C44-47AC-BA68-C77CCAE8F730@oracle.com>
References: <20210921092123.13632-1-chaitanyak@nvidia.com>
 <20210921092123.13632-3-chaitanyak@nvidia.com>
In-Reply-To: <20210921092123.13632-3-chaitanyak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc5daad7-6286-420f-898e-08d97d04a5a4
x-ms-traffictypediagnostic: SN6PR10MB2943:
x-microsoft-antispam-prvs: <SN6PR10MB2943512927E21A3DB04D3AE2E6A19@SN6PR10MB2943.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B3RZVBCbKfcUmHKPSs7tifFMLVnhY+dIto9c2Dcuc8bLWjKi1hMXpCkrk2KC850cQzX8edEp5ZpgcBmcUrt5KnwhgmoxhHW8e5lFHRCQ6p+qt/LPzAIdSLjrpmZ0mb9orHWKGON/mxcOXb7gZmUxV4YJcD4soojxO8acJHibWXl2CddSEj7jSe+HUf0wUoqcKioNLC+oKK5JkLct+//uzy0uJVYU7dvsGeaXzfClobOvM28WmEgnV5y4SQ5Jci8wI8Dp9KIaqefk7112FA36RvJwUlQxh7J1bqSFo1YlA8AIxwkNYCfvTS3FwbQYFlN2ou3abj18svD2E0wDKa2BBn1sWUaJjFRF8dUfS7A9myBqIQKi1eLbQ+IHAkTciwebRcQY/C64zlwCRKKwx/UcBQnLu7CFnJROBXXzyTLFYvXZJtQc3k2hwMjLfyWi5uJT+7sPEHN5hF2r0SW9ap4hq9fXfjooqY3we5082Wxq/JSW4cvk4XT4ORSngWivsRQukTZ3XQiz3aER4yDTngY55l+07kZ7Jl14Dn34NGf6aMPXWM4Rvg+dC6zcrXjNDACLyXflD+0KW/Apk8dTLV2tZe1cf/5TXUgkEqsU/eFZmc5ADNoX8MMBFAeIauR+QjoNE0QNKrEnidycOpJioBGkpXb03ec+tk4ZxWjcKL9uYIRUxbzPIFlL+f7LvPPBt2BTxL5eJKAbfi+jIH7r7q7Zsk2n1ix6KSuIx4ObKjbRirpqey1SASrKEvAx+Q7fS0kF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(8676002)(54906003)(122000001)(6486002)(76116006)(2616005)(4326008)(316002)(44832011)(71200400001)(6512007)(36756003)(86362001)(53546011)(6506007)(2906002)(508600001)(33656002)(8936002)(83380400001)(6916009)(186003)(26005)(5660300002)(38070700005)(66556008)(64756008)(66476007)(66946007)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?doy7boPyesoAEH+g+a4TSVGXFkgQP+1qL46KJU3VvtHSi4k88OIzXTpJ3/Dr?=
 =?us-ascii?Q?KTfu1KcLD+8iRoFO+ANTIeOen2yL06ggApnjm1KXS1B8fj2EUsEcdhS6yQW5?=
 =?us-ascii?Q?lFDgDK0+lc+Qf/M3Eir67Uq/pUjF2Tf5+KXTctUNQ5veDj2pLfXlbQBFCX7G?=
 =?us-ascii?Q?jikuTqPeTDwRINbFSlhSinXOmyV6oM4128v+u3z1LIeo08IhiYDQsXJ4gHYu?=
 =?us-ascii?Q?9nvHdQ9QcaDpGPZ67B2BPeCuxyt7iubaGUkKdUsA+mlpPTCLz7MR6uAKm13G?=
 =?us-ascii?Q?BUhW1JkIjRAWj4NZvX8xGp+DGbtnCMGz4q5/aP24wxGk1Q0nMKfpnZyHx2/B?=
 =?us-ascii?Q?XKOtPuOZeBy/FJZMTgRILJjgydoHEpY/jN8QVulGXwvHTmt1+KHIHvmj2R3F?=
 =?us-ascii?Q?Lwylf2uIFmYt/ocqi20vGJE1AVopY7t3wSJyoLmDdzIpslNkhiYD9Cs9j7dd?=
 =?us-ascii?Q?z6L8y43tjbgP8bjpso1yehRyemKZtDTIdhp99GEqgtfmwMWnYR2JqPhwK+t6?=
 =?us-ascii?Q?erSECotjbwfapXW3vITgXgrMt0ln2rscC2c5CBoeFKq1qxeYk3uef+6eWfWb?=
 =?us-ascii?Q?/LOK/hfqD4ZFNDdq5nTaFnnSXmxt1iPTr43E1iT+JVhiGJX9Ly+q5ZEEnQ7v?=
 =?us-ascii?Q?jAoi6VXRQyxul6d46Vd1GO2TXvyxhCg3tR3F1Iq9IVFEHUiuA0CGtqNBmmgq?=
 =?us-ascii?Q?vL6k3lVVu4GU9TyNHot4kJOEjzdlJx4zmpusgPbnteJCEDWDi43tVSdyL9wI?=
 =?us-ascii?Q?+uSCh/ecMZrxvxH+WIl8GEDtqv1Aa4aP4CpcHe9Ol4NOMJJV/HuE2kCvvTh5?=
 =?us-ascii?Q?bznKutpUkDlCQFDKAc0t79NV72W7NEW49DBqhvp5X4O8RKYw88aJ/RlTfv3g?=
 =?us-ascii?Q?tC2ANHaxQ7lLiPfgJYULy/UUO7OLeJnVtdwIIa52QFAEPxpuVT1FOTw4eTU6?=
 =?us-ascii?Q?vgeHvrpDKoO+oSKoGc84w57N14BhUl+o7CAukpdT3cIKtRhHhFnnYUcWgpRI?=
 =?us-ascii?Q?iAqM79+DIj3s/QHaOtVmQKTYCTzYvEBxBxQU/sSeKZCMX5tcqtHaZikX8qwC?=
 =?us-ascii?Q?qVHyOXIeQgH9q0h/XB+0Wtj+Vl2VCao1SHOVOdL/0UgMC1sXTkEbibE1PElG?=
 =?us-ascii?Q?Yga65tn5Yi/W6kLY7Fo7HzfMYvPb2fTRpfs3KeGIX8ZBdKx95XWEqTbY0oZs?=
 =?us-ascii?Q?Cnl+9ElzKpj4OCflJi+jZBMDSrJ50JT/xicMSAGWiHpsTlqYHQA5Bwiy6hT4?=
 =?us-ascii?Q?DSAXm+p/lwAQU5r1qwZ6717+8qL8G8e7TZfFhippEMQhQQfN1u351rGICbRn?=
 =?us-ascii?Q?bALwUVAZaWMK4pR1YXKuI40RlotsNtP4HKuUFQbbPTkvSA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <802294B3D03A9347A4E4B280CEB0A109@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5daad7-6286-420f-898e-08d97d04a5a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 13:35:15.9122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKQpP81iotb52ogf+1bDi+4z+FL5++xZmFqCoqto+cm3Cs8evzklrW7Tl9M4BjGWq+kphBR5KPMtzwR2QjiGj0UyKmxsIVPVu9m8AAVdNng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2943
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210083
X-Proofpoint-GUID: UMoeSdF-uEZQViDag6B_-IPdCRCKSb4P
X-Proofpoint-ORIG-GUID: UMoeSdF-uEZQViDag6B_-IPdCRCKSb4P
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
> temporary buffer and ensures that no overrun is done for sizelimit
> attribute.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> drivers/block/loop.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index e37444977ae6..ec1329afc154 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -861,7 +861,7 @@ static ssize_t loop_attr_offset_show(struct loop_devi=
ce *lo, char *buf)
>=20
> static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf=
)
> {
> -	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
> +	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
> }
>=20
> static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf=
)
> --=20
> 2.29.0
>=20

After fixing small nits noted in patch 1 you can add=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

