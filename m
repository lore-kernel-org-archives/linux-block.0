Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030EBC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 14:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDDE613BE
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 14:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbhDFOg0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 10:36:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34262 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345216AbhDFOgZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 10:36:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136EPS1a058368;
        Tue, 6 Apr 2021 14:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VC23CgVQzaMRVt/dFumb51jCL+pmG2Eg2TBGU5MyA80=;
 b=iTkG76dCY5MmsL8LGJXwR09U58qOzfqQ2QXO4vJ9A537sra+6bAawWfu9uhzVHpVCfMw
 ECSH8bU/GX9cqjpKxxsedAbwCWrbDizhn5KtdLMGGHNQoaVkHIR4f/NlElT+C+HyXyxo
 sqiOW5NZFG6FI66Qc+pmtdaofQJb9HPfvqnfS3Q7H9k1ueZKSzMFfC0mkJVdqT0RjDLL
 a7MZ7utQNvZcQX1pPXcNdV9JyGZVWX3/uwFfAsZdglKGH7cAuou/IvEEJXpmA0LS9IOd
 WsHDKcZePFW6Rwl80a3Ram8yLr4S1GQUF0vesOr17lsVA+rsiFtpXtwOhj0qn/mb4as3 iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37q38mnqu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 14:36:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136EP1KF191037;
        Tue, 6 Apr 2021 14:36:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3020.oracle.com with ESMTP id 37q2pucdpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 14:36:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlfPyc1q5BtGFMjDO4VOizRFYTssGVFQHvwUZVBHb//sx6tZoDtYszo+6R+T9uIMheNhhdrZak3unuXMJE8upkRbnrfI+HIrnbZRXwCdTzw2Ef9vqOXUHtkQTYuOhAw8NXhX0DYbdd+YLtDIK7qiV5GkVG2qNX26J/OJpcPbMu2QbCGfYbxQtGkWJeeFvjSn2fJSvtz2DU3xn1VOZYzUd4URNwMbtAlw+X3ohnqO9r3nVitUIkEQqRl1M//3BhzntG0JLcCz5V8qBGZYSG2izOowWO7N7eIPTPaId3xu9eh4oKz5jmBMJ+PmBqSS5e0OA4eZqrz1Q3EXFfsaPVyqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC23CgVQzaMRVt/dFumb51jCL+pmG2Eg2TBGU5MyA80=;
 b=I5++HasbnfWZybCTptTeCCAzpJKKwXR3cm/lGLwv0HxsDnFFIvNZEaSEzGmhQgVhNYnKdSNnhcfCMejuzpRDcb8cqrIQvNYYTTrDpIZcB0xGrkIqUdG9IK+VWvaavEJvDL4UgcFNyDJXTu4zbMGZFoB/KEcfvqw0tILNYVth42Cwzf+7RNgBfHpIILumiNB10hr1RxA7ME3oM8cOdW9qUNPCI8H7M6EkVLzRPxmLdBaBJh0I5EsEN0Agj7HXUtHjKN0nJW6N6GKuhLcS2YPDADyxDTYVXTI3cj1sjJNsdzaOC6O41TBGSVcENAnVGtkw4DePCgoTXXqGnbCZNhHdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC23CgVQzaMRVt/dFumb51jCL+pmG2Eg2TBGU5MyA80=;
 b=rzPN2sdDfaZ6PE+Jg1+qk9R85h2jysv8einhw26DLazLD4LzA69Dx8YVtyydseVwpIRFEuufKBMBVlaxEcTRQnIHQ6PxH7twKkR4qUeVCPFvGnrt6rGtt3jNU1NMQgegwZ7h2AUNFVabGNhdOJ+v/dFrqfUZ2u0FhqI11hNGZsI=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4553.namprd10.prod.outlook.com (2603:10b6:806:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 14:36:10 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::20c7:193:d737:7ab1%4]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 14:36:10 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Nikolay Borisov <nborisov@suse.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Always use blk_mq_is_sbitmap_shared
Thread-Topic: [PATCH] blk-mq: Always use blk_mq_is_sbitmap_shared
Thread-Index: AQHXFk8Z/VHSquZbfU6FuFbSrT/bP6qnt7+A
Date:   Tue, 6 Apr 2021 14:36:09 +0000
Message-ID: <BC26B507-52D2-4D4B-9A77-CB4B5DED1A6B@oracle.com>
References: <20210311081713.2763171-1-nborisov@suse.com>
In-Reply-To: <20210311081713.2763171-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [70.114.128.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 106de4d6-68a4-48bd-0403-08d8f909521a
x-ms-traffictypediagnostic: SA2PR10MB4553:
x-microsoft-antispam-prvs: <SA2PR10MB4553F221110D51D07D2AE980E6769@SA2PR10MB4553.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:185;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kEDTVBYRIBivxGIZV+WMsGnNKvoJv853LVGON+q4xh6bhJ3dX9tvhkprcqKYJJ9ukK+vfGmFyF8EVHkZw88fxWGHa1VzMuCt8aLEItnQcLYYJbgOfnJB4znTX/yNSsy6HQxNKIR2bATb3hKJcksBDB9g5exoPBlBr1m9tMuvRnfk6RrqcgleThIKBGQW5yzwOYHjjYZKfH+jgqBUFD+h6bR9gICLXWNKqnQt8q/vmt57gaEbouYNM1ixEglECbcrQef8erWoJ5bzfsY2mZsdnl69Byzk34hZq6zolc7rrk9b5xShLr5FOfjjxN8ul514vakgmbSXl60Atgbk1wiMEfGwqmh/CpXYDKUugW2Xy4FxltDeFvJV79CEO76ZkcKnQx9r0A5osVjC5rnPmC9q3lcW3EvePQUJ3DLpmFMsZBiVVc+BWo8sGDE2mJLEcgcpx2gYbFvUa/BvKqAeQGHThNB6qG2SNpN9oxOet2qcABZeIl7p2WHSfuvXNjOBdU1/TLf2FHEReowmW7Ck1tjpw8K/sFWGZxGmktEpHWyjMMpJsUxzCxVHHTshA6UKlp0mUTA2NbtQy14JyIe4TCGH4EJQCwYKBbo2KfxHUWoZt//Nd5gKjexXZcFX77vDm8XhOtmW4RTWq4piimSi2JreVspY1b86+UDAGeBkZDP7dGJB5mjAL6aXeno507BAHjNG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(346002)(376002)(54906003)(33656002)(6486002)(8936002)(71200400001)(44832011)(316002)(6512007)(86362001)(5660300002)(83380400001)(4326008)(2616005)(38100700001)(8676002)(36756003)(76116006)(6916009)(6506007)(53546011)(2906002)(64756008)(26005)(66476007)(66556008)(478600001)(66946007)(66446008)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ElGIz0XPR9UKcGXaAT/s6TdbdafY3XcTBNesC+W2nteeoD4+4V3y7Lullz7v?=
 =?us-ascii?Q?an44soSj+37Lr6SA6vvH/MMPGOXny4bvUW219JyIdZGIPrryyXmLBTRXR0bD?=
 =?us-ascii?Q?F33CaSV1WZJxgTL403PE9tV0hWNQde19or6jzDfKAWRya/njPGWJOCdNP1lw?=
 =?us-ascii?Q?NjI2yGns655AdQOsXCeXXSzX/H7rn/aUBhDbhG58ceuwnrGZ2KUoNK0Gv/2c?=
 =?us-ascii?Q?A4PEsHwDB9F+W3kNhreprAfrho0XSvu/FFfaX1U1vTT8wN9zK7gH/aZ++iWD?=
 =?us-ascii?Q?URFlfOYGWCv3N2IFGGXv3tyqvBitosOcmd7A6g7HLclbXR6IYnN/YXw1v9ow?=
 =?us-ascii?Q?08Z1c0Eg2R3KO+utSxRD/xDgVhoDlL96u3v04I6PdP9KMt0MJxAyJlUyYV4B?=
 =?us-ascii?Q?KGJid4CsxC8JX1wQ6oNAfMnYTUScWPzes5AcL0VIpq7vMYzjsPejMd0gn6l6?=
 =?us-ascii?Q?jTH6/8o6lBI2uSCCtgDJ1bOu9itBBV91Y/U2W3nWkX05ukBqID//uST/whwY?=
 =?us-ascii?Q?ZlkhJLTwwzuiklwl6UMPfa5Q0JUMLFAqeAh0NGFe420NIdTwRmRB/BYM0/9F?=
 =?us-ascii?Q?Ia3aY05z5arM3f/rRGCErBS5PvROuclv7vyMnQMdy48tTUyAAUb+t3NSyncA?=
 =?us-ascii?Q?x25vl6zvRz7GwY0bIdsRvRlVn+s/frY8U0RWjpkJb5MT4cLq4mePeH+Q9tzG?=
 =?us-ascii?Q?UARxbLYrFbY/weiyvkTur0DBhm2IN4aehgPwKjfu4j0o78TEiymsspwznIZy?=
 =?us-ascii?Q?A0HW5aQFZcCb432sM90jj4Sx+NfbC/jLG+kep2P6+8fBGaPar5Nhha4YZK6j?=
 =?us-ascii?Q?RtTy5NxnN6GqonzpJBKzsnlsIg1Bnck3JMJ17W5UVyXQM79dq03+pauUZE5i?=
 =?us-ascii?Q?SOG49UjWL/RzgshH1VA1eU//96t7AQp2qSFHpZfqnv0T381WtrE8gSX2FIOY?=
 =?us-ascii?Q?FhlqWGeUTkcoKVJAZ6vQDxi4Hrwds2wW9yC1nHjxYrSbaUNarjCJW6YXUVri?=
 =?us-ascii?Q?xEPAk3RnjOwUklEZzzDCex27iZwgGCl8Vu7V/+/V4Z6H7gpLAnZ2MaPlrUFT?=
 =?us-ascii?Q?E0taPJ3PVT1kGeDmwJ1ZNjtNJKSyothAKVbollEm9sRSn+kmvs/iDDZgoMv6?=
 =?us-ascii?Q?I3OBanRZSlEIEWq8zqAuOp3tWiFtP32M0r/heenumsym/VQMHU7WZPC0p0HG?=
 =?us-ascii?Q?EsoEboTmq1hLPtTTfciMZU/uRgQsYeoL4nQwxPnE51f8HVKXtuNa2vehUlXj?=
 =?us-ascii?Q?QY9UbWHWXtU+x2DrECzXZchJ5klgu5ROZuhtVE2OJgMzOgGvNcHwKMcTecR3?=
 =?us-ascii?Q?nB/l5GJsntr7kiWrKLPA050Khl9tpnc9t7nu9cAbp6fDLw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <712072BA6FEE6E438E2E4CEFBA8072ED@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106de4d6-68a4-48bd-0403-08d8f909521a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 14:36:09.9514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32hABcUrYBca/BdozQhlLhYypEwvXCj0J6SfJ+iBsvzu6E6BtO0aMuFFnjh26jF6d8JRfqmSVqa174rjqBqXkiCFvvHvjDG7TMuMh9gLpbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4553
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060102
X-Proofpoint-GUID: v4xB6NSfJblodL4X93TZrfKRUhqjuz6d
X-Proofpoint-ORIG-GUID: v4xB6NSfJblodL4X93TZrfKRUhqjuz6d
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104060102
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Mar 11, 2021, at 2:17 AM, Nikolay Borisov <nborisov@suse.com> wrote:
>=20
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> block/blk-mq-tag.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9c92053e704d..99bc5fe14e9b 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -517,7 +517,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int tot=
al_tags,
> 	tags->nr_tags =3D total_tags;
> 	tags->nr_reserved_tags =3D reserved_tags;
>=20
> -	if (flags & BLK_MQ_F_TAG_HCTX_SHARED)
> +	if (blk_mq_is_sbitmap_shared(flags))
> 		return tags;
>=20
> 	if (blk_mq_init_bitmap_tags(tags, node, alloc_policy) < 0) {
> @@ -529,7 +529,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int tot=
al_tags,
>=20
> void blk_mq_free_tags(struct blk_mq_tags *tags, unsigned int flags)
> {
> -	if (!(flags & BLK_MQ_F_TAG_HCTX_SHARED)) {
> +	if (!blk_mq_is_sbitmap_shared(flags)) {
> 		sbitmap_queue_free(tags->bitmap_tags);
> 		sbitmap_queue_free(tags->breserved_tags);
> 	}
> --=20
> 2.25.1
>=20

Looks Good.=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering

