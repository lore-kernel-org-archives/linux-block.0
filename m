Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA33C433DB
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7ECB650A6
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhCPD02 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Mar 2021 23:26:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6433 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhCPD01 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Mar 2021 23:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615865189; x=1647401189;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pkJAMnM7JvV0+3n0msMcWoXGp96Lpt9J24dY1+Iz8Ao=;
  b=nvCrlPBNhRpBLe2+J/bbXG4ztIPuxDz4aNDJyJ8Z229HvmWU3QpXjwzF
   HFxVSmCPaa6NpNnxAZsuA6nODQv6ev6wCpu5fdPn9+/YSADB90CbA3bIw
   5w4Me00ggNyI3kofIjbfU32Zwi5Zw68BNk26c7hpEOZyCn4TiQrkREZjl
   /r3Vl1IzTHqjM3V/CfcRrUeFnBq6OHZXVq3Wses6yX5YKoeTlynkGzSvB
   53ZmXo4lVbnZwbrs6vPdXHvzMfZ31aqfqDcM68vmV0BvzMOyo7fZi2t52
   qyrvd5Jpk3HsSgR9VFZBgi2JivGuuEpPEUKyAf+evMxPg1vM28gOKy8/N
   w==;
IronPort-SDR: 9EMduOO6OPjR74EfRZTpPAqS550guTfvSpYzR/qfqh19qO6Q4rMpA6JeUNzw90Mf88fjh9NtWr
 TXG1PBsAZhtzRSGlQ5x+9+TAsXstgGIfxGkZTQnADMXGh7qGQRC2SNljvKr+FaJMr0+N+1Tnnl
 jmA5LAEmnEV0Hm/6LDCskn7011VN9K5k49rpAXFx6dJZqbvpryunu0BDmtIIFF9hQskwcn29l/
 fk/QaPNiCVDVOiOLfATG6pqVPNTrxQj6mgfmy0qj7jX8B/pBQO6MtAy5Aj8UKex6fehMd5P1Wy
 QVI=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="266605817"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 11:26:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfsUWVgbw8WD7OUDEMRygJT0lNOZuxFOqsfBGcAVMJfrLVF9BdVmX8XlfIhhT77OGTqZoVb1Wkvuo15qkxvkUzQ7CgFFOXaepRK9lOcHQXtwPIVvUh4N2RWMjYXjjN1ng8LcdMrPMpTRzlD6eOAuGiGw3Ar46EGmFF38h3VuSCUf++tm90qg8enU3sbL/rHjJtUfyxUHspUhaaJYoFTIDkOV3+yeoUMx4eEcxz3LZZMLP335aA074tQIT3+t7cARsLexmplAc549kvX0zZpnhAmMaGUkLd5MCESKW42SDaiUiG7kOmejNqx7khwfnIKKlfx8Lp9npr6/3kGb0I1zsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkJAMnM7JvV0+3n0msMcWoXGp96Lpt9J24dY1+Iz8Ao=;
 b=SyY9q0xREJP+a6AlT2U4QTNhcguoGagpflAIDNlYpkrX8XVXbShL7uj8GM8hTiDSa5ksxUVHFfMc9naok+tbeQ3g7R4CS3/5MFmNOq+86x/rq9wfx9EiN39VCj5WlB/UO/dukfV1k3DMxLNmlpgBJpu+tbJnSLtImLS9x3a/ksHtLXxIqhmR6GOyfeszQzvbbXwIRWvsnPyXsYCGSAtcc0gV6z4HxMK1pz7wbtZ5ES1NeRmKSCKlZCo2ZnmY3J92RtlMLj2MC3msHlAvhG5CKz0C9YsdTTwtBgy0fupvJNGfTsmyhzaVMsKSWKY8pCF/CjVWd3Ps86EJkDT/UkWiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkJAMnM7JvV0+3n0msMcWoXGp96Lpt9J24dY1+Iz8Ao=;
 b=CLsp8Y60qyQhnc68TbREZ/oCgyKZ4vJcuYqg44YeQmOM7rix5xftq0OVI9Nb1jDvd0YUcqqN3cL9qznueuRqMptQsgO3g9HJk0pPBqYpBPKaNjEm6cQlkh/3vvEMkVLWzJPWPQlCo7DOi1uy46hUOS2/GtbtuIMZnc5CZDhxMOY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5333.namprd04.prod.outlook.com (2603:10b6:a03:c2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 03:26:25 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 03:26:24 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [RFC PATCH 01/11] block: add helper of blk_queue_poll
Thread-Topic: [RFC PATCH 01/11] block: add helper of blk_queue_poll
Thread-Index: AQHXGhMMI3cXeBzoIUOBWmHIqtHowg==
Date:   Tue, 16 Mar 2021 03:26:24 +0000
Message-ID: <BYAPR04MB49657BD04960EA2C63ACF4A6866B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210316031523.864506-1-ming.lei@redhat.com>
 <20210316031523.864506-2-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69e2ca13-5439-41cd-5ea6-08d8e82b4730
x-ms-traffictypediagnostic: BYAPR04MB5333:
x-microsoft-antispam-prvs: <BYAPR04MB53338B035384CFEDF0AABCC8866B9@BYAPR04MB5333.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aloSD8vFkdniZp6I/LQCofV1gTEEOC3y5oneysx/3fZ3u0H18TpQEThLl232i73PSJHYqI28pTv9BqmGAGYHFTI94duXORq01EBjjnyIOevJ03HlTPbt+J3dn6vcVwtQbfvr9jbtVMR0HpgiIqBGsKGCsyVAAWqxdhr5SbdwCKkvPQi835vqk6tE+81mZD5Zp45dZKaDdL70cereLKm9D1LoVdl7I66brhMtwEtuaXEsZPh9kFHrZHdZC2OSRA6mtpYMnOxbXRT+dKMsKxjWl5LPompBW83Sryl4LONKUWfF6Od4Cc23T2xk8kae5PURprDTGXLH/xj/f8smEMLHPI7/tc+uKIpWLz6FRLnrdozwbE76k5tFKfT+grIVyf2+NNqoMcnnBniA3JlZVQqMSdgYFaQ9WjbZ6TTVs/YtW8AjH/MsXpdxrNHEz8d3aM+urJ3Yb9Le0y6Y2sTThR5QEAABSPl725JJp73l0ropRtzcxAYg+lyYr+iHPibTyRFK6Knoclo6W/w2h4LIQeIUQteLfZwCs1pNB5JcSwHFK+Nsbjxe5sni7BeP3PChMv9x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(91956017)(66556008)(53546011)(66476007)(66446008)(33656002)(64756008)(66946007)(76116006)(26005)(110136005)(316002)(6506007)(558084003)(4326008)(71200400001)(5660300002)(186003)(54906003)(86362001)(8936002)(7696005)(55016002)(8676002)(2906002)(9686003)(478600001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2g9lpXD1lsk9lGkAJJRNTm1St/lIPS2HmKuICAkZuWWgdv03LvsXK9Jk1n6P?=
 =?us-ascii?Q?yNP8Hc9+GH/MbU5X53Px/U2dpghuPiTAhY2GJ2noka9RFfeltCxaqsdFP5A+?=
 =?us-ascii?Q?SP1U3tGUtO4id+bWQLb+IpThl2THCRpSzxyyxuFxVrC+vs4Pgx7smpTa6r4x?=
 =?us-ascii?Q?qXskcT8W4IBphTGx5Hir5Xc+SA6J2sd2XmpJd9mZn/dE/6+zM5cADLb1S+9E?=
 =?us-ascii?Q?VBkij5ornVya6UXLRF3qBJ+SPtr6WILlsU2juPfw+BmevfYnWjkbhUGOPA+z?=
 =?us-ascii?Q?4kB2m+KTxEWAt8ipQ3kExm356Rm/hArIYO2PfojbR+QDZ+3cXDZyHGesMDv4?=
 =?us-ascii?Q?sIf/M30yp2NoNILUQ7SosD10OljzsrluckXZxfwc5n6T+D9qWxikt4jCwOJf?=
 =?us-ascii?Q?eGJXGTNmfrqbuKQ16QXqYLvgeaVNPKWrtHqJYlie9QldXFHVhKDW99YkoP4j?=
 =?us-ascii?Q?YVOJeDJQMKUyKpZoazb7XhgzrWPeJUSYI2LCkVVZvbjYo9g0/i2y3E0Z5Sju?=
 =?us-ascii?Q?S4kVNuaG1wtitqVQiSnYGmnpktOyYfbj0PSlnWAYoHLpbqvA4zrEURNLxOmc?=
 =?us-ascii?Q?D9c/7zRmTeEx6JpEb/1IIVGC8O7BJAznqTf7t60mpE41qntNFNFxEW4anYon?=
 =?us-ascii?Q?pSPFUuTN5Ppu0jbp1hIOJh3ErP+TjVkzRtbiE00mKv8Kf7YSj2+EM1En5Bas?=
 =?us-ascii?Q?YBVWHI2yyHnBOT3UepOiAL0iVMtIKALZZ+3c7wUaz10O8eewey1XiWj8BU18?=
 =?us-ascii?Q?/qgZVJUFmuo3HUQST+TKBtccVy+7tlIX/lDzjWkhVzqrtLkl/vbLvTjg9i5M?=
 =?us-ascii?Q?GIAkPnwc3u7Fmy0RSt2pVZL25XRyuZdfiRwsRw8hB93WgVDhKsWatvDlKf9s?=
 =?us-ascii?Q?FXV7qA6MWYHL+wdlSPZGGetZhirttjTU63XUM+3GFiozKw62J+78b1eUH//x?=
 =?us-ascii?Q?Y8aOWUeRlV0EEoL+z9f7LbprBQwIRybVeOC6PZwViVGPq5H1HEMV8DFKxZSH?=
 =?us-ascii?Q?aG3UxhovzXnp0Cp724rBZi8v+5O/fUPeGXnPr3MXo+qHVfvETvnKgFAiurwM?=
 =?us-ascii?Q?64YrU3I5pcuJo+yVCU/mXXtKFhEPTjHvrrHypogq+4ELoiQUt94RjkKIX1Cg?=
 =?us-ascii?Q?v9hRsonJwPkcrEm7EeIDhW1cZhxvhtZCowjK2AqO/CGuERbrLrn69dO/VCBv?=
 =?us-ascii?Q?yD2EQ9jdL5oI4TfnfA/PnT8Us4Qm+t+gDLCv4GjaDVxw7ws5Vr19YJ0nszPj?=
 =?us-ascii?Q?94B1XOnjwc0cIccBoG1EB2UqVUZEh52XB2IrKM4OciUHh+FWxAoDKJO4LFNX?=
 =?us-ascii?Q?DlzkqNsomAepHCZZeVMsSKio?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e2ca13-5439-41cd-5ea6-08d8e82b4730
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 03:26:24.7018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qA44kAFMh6+GowQdIqkJTgrTPas8G7uRa38evEQugvXxV6e4vTsPUiNiqfSO7unsTqSdJJoVTgoTAEsfk83c669Ji8jcyh7kkFupYSKUTPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5333
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/15/21 20:18, Ming Lei wrote:=0A=
> There has been 3 users, and will be more, so add one such helper.=0A=
>=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
=0A=
This looks good to me irrespective of RFC.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
