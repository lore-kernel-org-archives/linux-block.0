Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DF4C64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 07:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208982087C
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 07:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mv0CPmDZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xXgUKA+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgLAHwi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:52:38 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:32148 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgLAHwi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 02:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606809158; x=1638345158;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6ncOmW1K+HMOTDnSPb67A0wEzwCDjnPUmWtaabiDkVI=;
  b=mv0CPmDZTzRxzHzGcdCJ5V0lpaB+POtLXPcYmpzZ1X4pLheC814GVOTo
   wcoD6W5DKWnBxjF0Uswfdr+uKlKUq2qlqSueBRKokL2w/Tf54H4KqqYIG
   c0yMIRMhe/qJmAVHuJvj/osFRQj2X08wgQUAx5ERvWSILSH9N6GwYBsOm
   Z2Pd57lh97404qSTldrN7CkAWGmHjqL/4hMst0PmqhXOJEDOa2TLprkxn
   2Bl51GRPhOsVFPRvzYWaZyTpCZFyoXqb4/PDBoLNwtZ//Ayr0NM9IS+8N
   qEyGHKDyo48gkNLGlKZbrrn81ld+qepj+tIZviEKNCNxAUHm1E26F1m3N
   w==;
IronPort-SDR: GvPcx8Pb0/VdNxWA8a5r7G9zGBwJXLxAYKCW5cj5zcchYN4RfdRwSd84pVrUR4YFHoYu7VkZCL
 5/aygmIIk+yToa4/ChefYlu6dhAU6I+YporeK1LfnLcMuJAUnqXHfCkc8xU7039aR4Jbn4ljJ8
 9MKHJIox4KiTHcO7ZTj9gQsFKqJo90KKSpP7NPxG33Mxff3GVMLhHHsiYZwaEgn2MONYPpI67n
 dj6XZfFBXfvuQ4Ay1+JTQ9NsUWUIPwe3ch45ln4ptfgyWxyf6tQ2gz3SKh2UuK7xFEJTUMZNwq
 SEg=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="155092302"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 15:51:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvd12c5R8AyEGwLpFJJUMirRb46k4lyyXrsbThF+mtZIlWjz4eCsvijm4Bsp1s+bj4M1SaMVXOz6XuxsCcqeM1DuYXItrjbhWAZ/PU9+n4u6StT1parZ64vISLRGt6QXrYa/NLJOKUTbyAQK3gMMBi0nEjCTIdwpcs7aLcXYoU/6y7llyYLZ9NlE3LLECAMf769j0WbfUQytFVKn8+vmB2F6Juu9MbxzURxB/gGD3icFoXC7mKZwoSwP3TTVAgIEqwftkx+yHN2sQlqTE7X/32kVbVAD1iktxK1mMU1Md1foruRDJqSc1YG/ibOoA0TKwiY0AcklgG0DfSF9p9yazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEAa8XayvtWc1/oSl6UqmEi4FGUayBf1MjHBVcmGO1E=;
 b=RCkTeqZv+/yKd795tLrXLyauH2JfHriJMXEEhHHCdmuCGUUMOJvCga2RxfBUhsjwfsSI0N74F4LyJHGb6dXwiwv5ArtPmdqAe6j7fLyY40oEEOl5951wZB5kWkOb38fqRKaIOW6hAMGXQHoNYvyVi7Nt4T+06PefENM7bPp3odf0RsCxMmIBOspbHCw7xzY76VwkxCktxKktQ8NYKH9Y82YYy2FTLZBZ+hisvhF8H7CtG7UcRuAeqYr6tOSKW8blph00LVF18McMZ4HHIb4nFoiytIwc6XrHsaAieRZcxnsC6GTHU0TMk7riBdcE2Cj0dpM3oh/S7c/aWrGGUboTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEAa8XayvtWc1/oSl6UqmEi4FGUayBf1MjHBVcmGO1E=;
 b=xXgUKA+EO2Vu4U0/dXbwY674t7zJlb+7Ry48rLm7Yn/5gyMOW5nl5rHq8DLCmvkoBja3ogvTjMz1pd1AkEKU78K3RxJIFA45WtfUGd5CtVWYduVxkDv8oEts3gF06e3buRyCEDJBh2VupTCEq3wPzTIzjGgBJtHKcIY8y/LtbBY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7420.namprd04.prod.outlook.com
 (2603:10b6:806:e8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Tue, 1 Dec
 2020 07:51:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Tue, 1 Dec 2020
 07:51:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWxsl/DkSBeYlhG0OpN4tsfc2WHA==
Date:   Tue, 1 Dec 2020 07:51:30 +0000
Message-ID: <SN4PR0401MB359894FFC3A97AE587885CB79BF40@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
 <20201130032909.40638-3-chaitanya.kulkarni@wdc.com>
 <SN4PR0401MB35989F591B47F3A8AD3E2AEA9BF50@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BYAPR04MB49656FC8CD2E8762C734122A86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:b8ae:bd87:d6c6:21f6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc9c5e32-8068-4a27-858c-08d895cdea1d
x-ms-traffictypediagnostic: SA0PR04MB7420:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR04MB7420C761988A9766D2A420839BF40@SA0PR04MB7420.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZCyNeYisAM/qJwNUThbbvHv/oZPg/7RnMPe3Jjf1VI3YPjyXSuB+dgxPsauw+4NIFm8xYXyGx8utBNwiayF/nWuxhnbdys8eoXBwCy/Gz3ls7f8z/w8R1kIFgfD2txOY/Evi7f2sxup3WVpBaSONbZ82k3EhER9Ve1b+Hzpddq885MPwWxlM4GuPaNlhlh3HeD5tjiHY3gD0bh/NJ82oG4BIHJP9nSXqj12lhEhz3BtSTWJ+zjK88N9R1i7m31m1Eh83ZePQeSUG8zgMdeGcEdUavEsmZPhKtSqCISs2wMJ+/FW53kssBwKjgw+g9uf1qBr9BeDa5VGbUVPNjbZK/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(6506007)(86362001)(53546011)(7696005)(8936002)(52536014)(110136005)(54906003)(33656002)(66556008)(66476007)(4326008)(5660300002)(316002)(9686003)(66446008)(64756008)(76116006)(8676002)(478600001)(186003)(71200400001)(66946007)(83380400001)(55016002)(91956017)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IBGk4F3U0hikBCWuOXV/eW47OtG5pMZBh3rVlmIxSTRX5HWjVxoSS37Gknbm?=
 =?us-ascii?Q?QkdZMHakIJt6TvcyWgmZksikBpTcErwODJbvq5O8l1Y/VQXL0uFjZAhHpPCy?=
 =?us-ascii?Q?pTl258aTgTNdnp/RT2hFwnZjZcc+FkYMe2NKzUYEuHIiEQilcesGyqx386z+?=
 =?us-ascii?Q?PVD4RDH/YT5MUBYCoAC/vxzPiKcAVA3JiHAaKPUBZLMDZkvKrXGcUr9cpENd?=
 =?us-ascii?Q?ZpFmh0qbqdjfb83e9bTql+U83SjqrTfZlZnzmtt0BqNRni0GnsCFxjqsP/ei?=
 =?us-ascii?Q?3tbka/IEaQIP6prw/YA9+VYZDq4w27Vog1dDX/Z2mM6gM3nUp3tgQffN4iqA?=
 =?us-ascii?Q?fiUzSCYiAEwqlxmxndRDSfCInQ1kXG2TPGZn4B4zDNmYmDigq/oRNlZGzVbE?=
 =?us-ascii?Q?UK/PcGXNq6QcWvbANJpr1vrlsX7jEVUVFZjPVcE07eErNZVeoNBMST98NcOL?=
 =?us-ascii?Q?ayoyIInPHikspV7fNTjVA+ih6UNN+y56XK8b5DlT5v+W9XiP37V+NnrC3TwI?=
 =?us-ascii?Q?sR0yzDki1HotAjRSerQRk+CZ4yr+aHyH5U2SNfSvycn85k1jHIfwCGk57hZ5?=
 =?us-ascii?Q?g7EzY/GqGMSN4in1OkiE3WPt/mM6n4P3UustxNOL5vTP1z95CIo46T2jEHhn?=
 =?us-ascii?Q?qmcckY1uNx3XMKlz3Q/CR0ngPA9xNnnbDVvlmkktKTz7uCErQn0Xj2Q2b2Tv?=
 =?us-ascii?Q?MPXLFTtah2qd1//spYNQ/SYlxR0ftdNegohJkY2wSgs/69sCBE5r2WySa1x5?=
 =?us-ascii?Q?2EagOHHJaioqZAhYSaWKXX8aD6x4f09WiLkrM6N2qvqtefyOSIygYNifTbBF?=
 =?us-ascii?Q?0Z9ey9EzHA5a2HF53qaw/+pcgTbR+AQpNQZ8Y2tILUIXdmv598syyZvTr4Yk?=
 =?us-ascii?Q?zucPRQEhT90J3djcNGwbnT+CSfSI4hYQv2gINODtx7QeM2Le7J49hqghccCC?=
 =?us-ascii?Q?mw5+7uwxzwpACpO+Lpm0HKsTFRl0mqGDn39DmNy+RQfhP0uNz5jlzM/R/hHI?=
 =?us-ascii?Q?eoeLv6LkfbU4hdD0uBdlJDWs9Twa/ovX/0OUM6Ruvi2++f3PxZEdCxdg4ol+?=
 =?us-ascii?Q?bDVn0311?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9c5e32-8068-4a27-858c-08d895cdea1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 07:51:30.0623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X1yizPI/QjCwBInNSmoENi/sKHm5Ftlwny4M2n6V8DfMkiSm0Hah7fOQ/GgWxfILdrw5exLlz84Gis5ezUxXxqjirKAY81Xo6nZDtA9GreE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7420
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/12/2020 04:49, Chaitanya Kulkarni wrote:=0A=
> On 11/30/20 04:29, Johannes Thumshirn wrote:=0A=
>> On 30/11/2020 04:32, Chaitanya Kulkarni wrote:=0A=
>>> +	ret =3D  __bio_iov_append_get_pages(bio, &from);=0A=
>> Can't you just use bio_iov_iter_get_pages() here?=0A=
>>=0A=
>> It does have a =0A=
>>=0A=
>> if (WARN_ON_ONCE(is_bvec))=0A=
>> 	return -EINVAL;=0A=
>>=0A=
>> in it but I think that can be deleted.=0A=
>>=0A=
> That was my initial patch but it adds an extra function call to the=0A=
> =0A=
> fast patch for NVMeOF. We don't need any of the generic functionality fro=
m=0A=
> =0A=
> bio_iov_iter_get_pages() anyway.=0A=
> =0A=
> =0A=
> Why add an extra function call overhead in the hot path for each I/O ?=0A=
=0A=
At least in my compilation (gcc 10.1) there's now extra function call overh=
ead.=0A=
__bio_iov_append_get_pages() get's fully inlined into bio_iov_iter_get_page=
s().=0A=
=0A=
$ make block/bio.s=0A=
  CALL    scripts/checksyscalls.sh=0A=
  CALL    scripts/atomic/check-atomics.sh=0A=
  DESCEND  objtool=0A=
  CC      block/bio.s=0A=
$ grep __bio_iov_append_get_pages block/bio.s=0A=
$ grep bio_iov_iter_get_pages block/bio.s=0A=
__kstrtab_bio_iov_iter_get_pages:=0A=
        .asciz  "bio_iov_iter_get_pages"=0A=
__kstrtabns_bio_iov_iter_get_pages:=0A=
        .section "___ksymtab_gpl+bio_iov_iter_get_pages", "a"=0A=
__ksymtab_bio_iov_iter_get_pages:=0A=
        .long   bio_iov_iter_get_pages- .=0A=
        .long   __kstrtab_bio_iov_iter_get_pages- .=0A=
        .long   __kstrtabns_bio_iov_iter_get_pages- .=0A=
        .globl  bio_iov_iter_get_pages=0A=
        .type   bio_iov_iter_get_pages, @function=0A=
bio_iov_iter_get_pages:=0A=
        .type   bio_iov_iter_get_pages.cold, @function=0A=
bio_iov_iter_get_pages.cold:=0A=
        .size   bio_iov_iter_get_pages, .-bio_iov_iter_get_pages=0A=
        .size   bio_iov_iter_get_pages.cold, .-bio_iov_iter_get_pages.cold=
=0A=
        .type   __UNIQUE_ID___addressable_bio_iov_iter_get_pages499, @objec=
t=0A=
        .size   __UNIQUE_ID___addressable_bio_iov_iter_get_pages499, 8=0A=
__UNIQUE_ID___addressable_bio_iov_iter_get_pages499:=0A=
        .quad   bio_iov_iter_get_pages=0A=
=0A=
