Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E086C48BE5
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 23:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2D7610C7
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 23:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhFSXFD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jun 2021 19:05:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64088 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhFSXFC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jun 2021 19:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624143771; x=1655679771;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PqMVgM9R/PkEGO3Gax0r/SXsBxLsUTFCPE3zVK0fOxI=;
  b=fRrDF2uAtURm08jCWIXi34F6kuGZNm20up9Hp/FzP+EVOSkMq0LVr0aw
   5siV2IX6vl0CJ+k5hwAlV3NU+7W+lAgn3C9N2szBxO0oso12vC2XsTBR9
   8S6V3kBGLd+8AKsMpt5Sdx26SG6WLC+EUXia4yKNsWwhFzNM3uMYrdBGS
   Vyhidgb1lgH0QEOaq0X4UuGOn36UqwNcxbneKZAPXQV9kXXEsVzQsIz5T
   ta0uP5U47iUilIBpslj73B+gKiEQQokKeIdrdnw60HnslHElxXDwl1ptU
   QjrhcgvTCm5cp5pdlZAe/UwMxQTpkFTtLxYHRcgZBqkUDxL/ShFHRzxIQ
   A==;
IronPort-SDR: O4mi7cBcaQOJVowgIKMtFOJIvzd8ykdVnTjaVVCObf+GwWJVMxF8aA+Of+7tzowbxdGMTgFkgA
 4IAOIWOaqYjjT9qZA0JA02Celam46dp4rRpe8SDQL0QXXZhS95Vug+kfGcayHBpoRA3BOCeZa+
 /ZtgP9ZCg7uozGPJWcBiKXsBeMTCh63QTrNCT/B94rsZw6ZD019PpkQyH1yNG2xISy48ea+QHT
 vcp5QrR/pe/7rPF0c7hvVCqOcEbAUSU7MY1ZPTVj+PcB0GHECyvOhSJYOzzctSL8F1YpYSP2fL
 +9w=
X-IronPort-AV: E=Sophos;i="5.83,285,1616428800"; 
   d="scan'208";a="171640207"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2021 07:02:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mle0tMfbjzgouTm4jzJTucJ69KQ86NkkEgPTnigD68fX9byM1jEb4WeHNnZnMUDBPdjgYmiG3HjanqzDfiZysfeojpqBE3BLUhbYfbyW9ueCqD2XUcsUPkyhVlmls8TXJl4I3earatvAwpOgDcWEFYHUJQgUQ//AXkn75haRLtt8WIaHlVQ4KWpcHgZRFkSEjyqDveHgVCUARyvhBwSP3GfBZCI9sXK6OaSBaOLBxyVaqJOHJOMJ63VHVs04G9OEs4HNsQT7NvKrluzVhwGVzFw741y8zSVRhKkQwSC579/aR6jquaS3b2vwj920YRBTuG1T3nwsT3l4GSalbr+WfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqMVgM9R/PkEGO3Gax0r/SXsBxLsUTFCPE3zVK0fOxI=;
 b=FEJYY9FaLtQ+uKKDSQwOFZ+QG0ZA12BzvoOU9UAz/TXen6CWi+stNh9BXQS4HstqTOJLY+PAxfV4rcZ+FsaVCM6db+/DcsTTPnHdBzeJ3mdjJsIWz3CUA5qS8b+oMdv5tBJQVqfMxrOfvbArmZG3xRCutnDeBQEqGRCJ4chaPY7LmehZCNBtz1iYGQ8DljZCqRWeEWQeJLEBqah7jTctXJgaCQjZsZ8gLKDQ9ThDNimfp5h7fJtUctzIzcMUCnQiXoI8iOcLV037t6k66zNpO7oKa/lAjpSFBOb9do0/kV3MWA0e0YTvbrGa5JkaaE5s9o7oiHpYRpuT75qkvU4iBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqMVgM9R/PkEGO3Gax0r/SXsBxLsUTFCPE3zVK0fOxI=;
 b=UeOnzmkxm6HF3djeIrJXMXWXsOSU5KL80ICHpErmCuy5cbMADVTJzSoVP6FOEMfK+7PNF+Yc3AWA5ujJpAm77jjqizWGFD5oJWxTRmq8Fk6ju4k8zR4H/Z7PlFhfn2pyCUdPAq7E78M+j6j7jGv84ouE2GLwEFVf6PQ/7M+BBBM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4758.namprd04.prod.outlook.com (2603:10b6:a03:11::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Sat, 19 Jun
 2021 23:02:45 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4242.021; Sat, 19 Jun 2021
 23:02:45 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: fix an IS_ERR() vs NULL bug
Thread-Topic: [PATCH] blk-mq: fix an IS_ERR() vs NULL bug
Thread-Index: AQHXZEg9/p2Pgd3CvES/C6VD4Wwljg==
Date:   Sat, 19 Jun 2021 23:02:45 +0000
Message-ID: <BYAPR04MB496550B2490578C550993A76860C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <YMyjci35WBqrtqG+@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2057b6d-c095-4e79-781f-08d9337659fc
x-ms-traffictypediagnostic: BYAPR04MB4758:
x-microsoft-antispam-prvs: <BYAPR04MB475873E71F93235992655E01860C9@BYAPR04MB4758.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1/QXgmESIEOh3RWv8XxdGGYt4lPQhReseJ3fyg2L0x7cGNVf8NrAmo+uE7C/9rIk1aK34et9zCPf8oNtKw1Hs+ZflGjYIDJxko+sELR0jrWG2QvtCfICunDaBz7Jnm0RVlBZ/KZM32nNtzbfrtK0QIoyS9lKRUh0EupNDdDySxzBBjM76v+rI/6uwCwQhfWCVUyibXLNa1Bd0D5sbZYQIt+mK7sFjn0KKkcc+jXvZ3SsyA7ie9PzU4Hr9UsVLqeUv76SI0AAG+kJEyR065Z+DxPcMVYNwpkMiW/j4iJUaKxZi/tzeF5K/02i1mBZPUhaqyyrs00K3UsW1Sw/g43i5t4DCWJIcJS/6vjzehTHcxBlIxjVIc9TZM/fQTgO7AYQ1GkPFiKEL6cazoZcEXcOr59Tm9K4KvbEsvFxJP88oEbit6NU6OfOC+SCx4gQWNz5KOKhSQ9gIbb58HI8LMNOeM66aflW8Z1vs2rIvAoCSv5fPfJTwdfteaaPe22ak9qml5DVCb1YbO1cooS+rkCP//1AspgItAb241h8B7JpymL1N6Js6Rzp+sKsQ9lhi6570ksOz9Dn12GeDLfL1vpUWm7mrO3CZcGEWkiN6xBmwvM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(55016002)(9686003)(66446008)(64756008)(66556008)(66946007)(38100700002)(122000001)(66476007)(4326008)(76116006)(8676002)(6506007)(8936002)(71200400001)(53546011)(110136005)(54906003)(186003)(316002)(26005)(86362001)(52536014)(2906002)(33656002)(558084003)(478600001)(7696005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GOxFmb4t3CZIW9Uw/Q0pG8pUwp00c6+1PgadtaFo9XAsR58E5dSMJF2c8JcU?=
 =?us-ascii?Q?gDMOoaZC8ifzMTWc61StRWy/uhCafw2U0CRHYYPpVHKUzE+uRt3WCZPVFuyt?=
 =?us-ascii?Q?BcgaFTr48rL4gZr1uiZ2ySNE98DgzXobwSN/JkeuatBLvSceb+hsEaK+RAho?=
 =?us-ascii?Q?CSjYhOe9aj/ENX8EaFTpoCT4y4OiCaQuRlXE4bvh+RXIE3Bt6x4yxNc7UUR4?=
 =?us-ascii?Q?LfYaeQ6gQAaCLnbMaLJxbs9Cx4bOjVLEcvPFRb++OoyEFKaFXyqhtTj0Eb9K?=
 =?us-ascii?Q?vDJ7t1rabvb+i6lKgOhje+BvHJb07NI7LExsqDQFfZvz9kPOoHqJuTUGgzpP?=
 =?us-ascii?Q?V3wPjB7wNHt/qVfzyvam9dUmyKl2ZXBpgxpXLSo7RlJP6dlR+UBhAluN7g+x?=
 =?us-ascii?Q?4lqkfgajhGlvWhn8rZIQ/jHn7k7N2KV7UqVqrP/xDO7FNOR8Vy4fwfuCfPM+?=
 =?us-ascii?Q?4fW+vKeO/zs4ilrVmEmJlzOUA7zAwhrA+jyvgD3v3qgDk7NB7zGk9WIZ3pxi?=
 =?us-ascii?Q?TZ08bCaHLYde3Bis6miN6vxES/ChRKYdasMDhhEYPhlpO/Pq4YMsBdzPZbdh?=
 =?us-ascii?Q?m/JDAQru8Ae2JKM7H3u1jgXGWX1L8Dp1kiun4j7y8fhHQ5FI8M+K9tbdzcdj?=
 =?us-ascii?Q?BpBco1P1s0zJfwKP/nI6IDTtuzekKF3vLecmc87Lv0uUyo0v95198sft5g1G?=
 =?us-ascii?Q?9gFyfrookouTDkriREJD2x7HH37jXFWzGNbufwncf4iDD1vG3fJNYjOFR/DQ?=
 =?us-ascii?Q?E6rMbSYW4pysTqrOT3J9qxRdj1vbV99kJ3EKQcrs4CQ6JvQBAGOAy/V/5va5?=
 =?us-ascii?Q?xms3uGVzk7xK0SSgvhySSrGAbBv29UdzVNgnhNp09l2Bkth+EEbEhfMKlox7?=
 =?us-ascii?Q?GTHSYJJhpVUn8Zo8+V7d8KJmoX/eTD1GMpnRAec2zbxsHbzjQPvLYi+oNVTV?=
 =?us-ascii?Q?alyQ/+diQ6J7PrRfsdcP20d46lKDGMx3SOib6QEBnBOBnaIAC/FMuTn8H885?=
 =?us-ascii?Q?e52oSSmBt9jEyNqEf1/0JlAQXg8blH3fp2yDKyHtlkZrsJYn6WZHbV1O2E1z?=
 =?us-ascii?Q?5wxHCNj7QiAtf+z4kS3q5QXEWaeOxYhjp0/jhEmZzwWI199Mby5QTgbO7i+4?=
 =?us-ascii?Q?lY8Ss2O4d5btVYVN7/dPGbl8OLyD8mp+db17hQTU5gehHbEJDJ3LrsPbVT1j?=
 =?us-ascii?Q?CSAzbv5ipDW91pR1+aRmB38EUhB9DexFgl+SRv1fuZZIjgQLUc7ZBvpChYjW?=
 =?us-ascii?Q?uXpnXLc16Ma6ovqJWetrc1w2PRJCRped1eSrLouvvY1Cxs6KqihECAIitrBF?=
 =?us-ascii?Q?HvBxN8nbPX00G6YZsRDsw+B/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2057b6d-c095-4e79-781f-08d9337659fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2021 23:02:45.7462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYYu4H514GJu7DmQtpumjBLwFLCBlR01584rE5rgXI2PMZGoaZ47DhyzobGQvDyHHDwrJYDDdqy4EFwvnB3iHTbbd1tl8TQLUAb0gVDwBKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4758
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/18/21 06:45, Dan Carpenter wrote:=0A=
> The __blk_mq_alloc_disk() function doesn't return NULLs it returns=0A=
> error pointers.=0A=
>=0A=
> Fixes: b461dfc49eb6 ("blk-mq: add the blk_mq_alloc_disk APIs")=0A=
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>=0A=
=0A=
Thanks for the fix, looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
