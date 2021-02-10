Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBD2C433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 22:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A0464EAC
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 22:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhBJWoA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 17:44:00 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23465 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhBJWnz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 17:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612997034; x=1644533034;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vmgBMWdvpxE8Rx9LZk1NDAKhwhVj8VPMIyyOU2AvEcM=;
  b=DV0Efzmq45Tj0QE/Z4hw4DL1dy6O4lz23Dt4RDmx5eahP2/RlL0YkvnS
   cfUE/n2PfWcnOoATX8eFJwyGpG0o5mObMMxmRujhoz2DLhHx3vB8FDOpG
   Kv82ooxUK5yMtQa8ZYBv+9XDl/VzcCe2kOKpQYdhAaeLMKNXO4KZY00JI
   Ug3OtL47anAGNp9ZSODWNIcllF6KCPuUQzqaCnClZc2arJBlxKVREYWZJ
   aHfonkxQ4/r8vUcCQlaXNghTaf1XVEKOMIIHURWsi92JJ5O3i/Uwq0yYU
   /Fuig4Ns2nlicOU/DKhB3ylMpVxZlzsB7HVUZHQDCusxY34P4xWuwt5jQ
   Q==;
IronPort-SDR: T8wlP1kjWMTUWirfZBiNjzItc1so9LPMAC6TSyXHNyuhaT3g8nGH8Av0KXTUjIrrIOqXCqgHKt
 5IXFP3NpmHcsO6qqisuiZg10N0ohHdaATrgW8qsdkh6pttzxQl2BNZp5tuUf/WFvDkP16G0kDp
 H03cvIPExHJY+Y6Ywt7e82YCEfkIoFutM44CVhO6JulXr/3PAJKgzq1KFEQzmU3Vq8a0ETpka+
 tvlUXMEFDn2zXnJZvKiMUYpKkO/TsjbV2EhVAx5006y7366yX4A9H67Oaxewx+SKAeqlzIihfH
 tSw=
X-IronPort-AV: E=Sophos;i="5.81,169,1610380800"; 
   d="scan'208";a="159695231"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2021 06:42:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWG/SjEKhuj146BqE1hZQ3rTtK00m+/2KWAO0eOdTt1Dtybr0xZOXDXW/PucwVfftqr1ag/aVF7LowZK+sNlIrrIkySY+tgEkcC0gAVV/wHbn/DsPv65ZZ4ZT3ORh/9CW7TvVZtPkNvslMAEvVilWkHclrt2W7jylk5fgVlC03mOqUcMILDGuqEQUBluTz3vdMwkwvkqjM9q90/+TRgPnajCb1j5najjUn+XVgML5a8lcodEnbfuqXEh8OI2x4dfKF1Tli7QHneE+qWuFBq1OnUh1eef8Rt6WSJGP5HHWmQ+6ID9X05U2EwePlcDQ3JlnnLbNZartDqRqj74x2m3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akliqGle43LnowBUXVRhD6+DgvM1tEq38GnEJcBdqwo=;
 b=aQ+WbGIw/1txIuEDRYbma/N2CIcIuSiLA+hnDLobaUF09rxF+DzIb62S7Sqe2MPiX5kWm28VhCaUlmROWnCEehA/sdPuvV0g9mvbDKV88RdT9WxkVahvWI89LhxS3WgIDSjZjngHU2YvmwcD3XnH2P5IqR9R/LzV9ZkQSytnuvJACan4v3ikVINVcV9PCyeY7CVbtFNd3cnBwig4kj0obs8O/lSbuajI7oECWWOo5bjUC2JVIf1SfO+jemEWnbxgDjzFE/MK6sLY3iQgXEvjxVCSfSqfQ/Ln8HOv0XZo8zbxMjQaHGbwBdkfvx7/xp5rYWzuRiuDRrKJF8Ck7RA5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akliqGle43LnowBUXVRhD6+DgvM1tEq38GnEJcBdqwo=;
 b=f/694MeH4ynZwAVPOJRG+Tzs6KzeBbkcSRGjCV8X8jD9jCVecPQXiHJzeKq3Zd7c5H2fjBnlPJK/xKYZ2e6j+FCeeghfhkErKKfvYWhwtZWEP0J/EFRrMWh8qdEhNrQ/+S2uvqpUvBh/73rIMrzk2Co3JocxyHNPbbn3qAwzU8Y=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6753.namprd04.prod.outlook.com (2603:10b6:a03:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 22:42:43 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Wed, 10 Feb 2021
 22:42:43 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "hch@lst.de" <hch@lst.de>, Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V9 0/9] nvmet: add ZBD backend support
Thread-Topic: [PATCH V9 0/9] nvmet: add ZBD backend support
Thread-Index: AQHW6JsaYjPbWYB4pkeYj4FVUhUBMg==
Date:   Wed, 10 Feb 2021 22:42:42 +0000
Message-ID: <BYAPR04MB4965A4A8B3BD9E070F492EDF868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2607:fb90:482b:10d6:f4fe:f24b:7108:1811]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2bfee4d7-7beb-4c65-4526-08d8ce152dcf
x-ms-traffictypediagnostic: BY5PR04MB6753:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB67539E313FD804C38A69CFBA868D9@BY5PR04MB6753.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fhczE7kkPM0kiGXal+IdseLWFbd3BrZy1OJeDSz1MdBkmlCbSWy92wVlTnLqiWaBwUsrCPFgKcTO22yHEM0DAu9TIsXkf0wemmBv02iIxHS2F9nwQj/SwjiHX47T4siw/dH83H5Zp1F9MLmQ9ck0bDhWi9fan+aAk0HlUlFxqXvXE0QOVCWXXd86SGXzR/enSofvw+4q/BUM5bX8R1Cd9RNSCgtTbtYK1lgkubaKJCkZtdMRBrq82Mi8mjIhjmEmb787uEtxdDSAfMbZ5zVqPUdeRD5TqAU6NRhVvejw/coWwr3Mq18c8d0NqB7BpQp5+BgM+eZ1+o3+IoMWuO197VDMh7978sRTsTNF9wAXqVz06gsR0ZS7+uh7sZ6Z18D/3qsLaxvD3SeWS27PaRaxhOTdr9GyqgagAHf/+8LT4M6jKcRweg+mbpi/de5ZEcG700BAVT7jutTR7iCvoTOKMmmQLkguqN0ZwsI3eh437yHeJfQeQuuSnbj799hRcIdBenIcLBzxyihOZafu+ZKIlHNK0esXq9Ss1baGFNI7PEXWeY3RJuOf91tOtXAiPPF3L19nwhsa7sYcbngUzggEODwJUOC1kNNY3KhwuH3q8eM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(7696005)(5660300002)(86362001)(478600001)(186003)(966005)(9686003)(66946007)(8936002)(55016002)(316002)(66476007)(6636002)(52536014)(6506007)(53546011)(71200400001)(2906002)(8676002)(4326008)(54906003)(76116006)(110136005)(66446008)(64756008)(66556008)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1woJwQTMtkvlNEXmvwuIx9dgyCSfCzBEfATY3RZ1l1FbQRr3tIp5oj15JT50?=
 =?us-ascii?Q?RG9vVs5rA9bqKxVc5F+icshiyuqSiq451s7NwmnB4LiNqrmuuOMlJuJzUccu?=
 =?us-ascii?Q?iNi6eBwC1QS0KOtVdUejRa1SIR2bB6Ajkq5zmLurmX+1bHk2YaYr4YGsWpww?=
 =?us-ascii?Q?vOSxh71C6oZGGJMXenCqolu5gkdGAN5WU4sIx2jzh3LFNBld+GZgedwRgfyT?=
 =?us-ascii?Q?5VBxUwqj5yesStmWmWsHQVLqMqg38il5b5PRN0LZbEtgUPuiXin40JBxiCXe?=
 =?us-ascii?Q?tvlhVko2l/2Xs8wquE71wf6Ksjs1+VxWRuk/7m7vcU0MhvX2MXB6unXW5ea5?=
 =?us-ascii?Q?Tw55o4E6nIusNalvZrLpgkehgpcqCQBm1+CgQ33Cox3K30v1cQnWIUpP8Gzd?=
 =?us-ascii?Q?djO+b3TEtbePQyGS3znmRHo9n2ebBk6rGqxnOYDT/URJyhgQKYuZaKHTf1Ae?=
 =?us-ascii?Q?Bi90pSUDzkW8Mv2fEF8cyMt4aY/KOeV0btomnGCP/e6s+SlbWkjMSd8G4UlG?=
 =?us-ascii?Q?mUaAhRbP0jNGoQi4iQdTLYdh5GMi0gaFSvQJ/JICdBlUW2jk2N1PhiC4abvT?=
 =?us-ascii?Q?f9xmzm9HK03/1YelpQlF6shjpdqxbwQs3q2QHMvV+Sv1txu3M+XUDn/YU/Nf?=
 =?us-ascii?Q?EiYlb4pIySkswZ369omXA7ol+kqq5gWiRQRQPucJ9syxXsLmjlOWPGmydPnn?=
 =?us-ascii?Q?LTaDyxkUhcOzQg8fR9FNYG1fzis7ZOeCr2nNteKypEO9e8NK1EMpBc/yGYr6?=
 =?us-ascii?Q?ZVN5Xufl85uo1ytVXwB6GIWerHBiQ+G3EyeD1xJniSQkz+SInfm3NXTUg9Bz?=
 =?us-ascii?Q?hHE4gfSqKqbqXUtMXn5hKRkbc4vExaup3HHd0rx1exdFTsE+fyRXTf4R3Xdv?=
 =?us-ascii?Q?UF+hANsIWgtm+BULaogwKSyjXtZ2LuReMrhgBnotasQjOcLJEdipXRmWIsmJ?=
 =?us-ascii?Q?P0ToBwqw/7h75S4wVYmASoJ+P258ABlXOoJSx9YzX6+MaVlseaZrt2MbaIT+?=
 =?us-ascii?Q?ry/VafVHqyI7e9vaHr+Cc/nHr5193NkWAU5V+2V+53GHRNT7p3PoXXdf6GlN?=
 =?us-ascii?Q?IIVaioqU9rnNmA+QAZFdK+rndsdn+vLQFiqwtDKMIqVQjltky6c9MR0/RWbC?=
 =?us-ascii?Q?n+V/o5vQK2DGVlOhx3K2zVF8pHvixhAsilXkaq3j6YYXh0v270lQO1+tS/SX?=
 =?us-ascii?Q?qF677JfqKnyImnurZOXDMiMvPKtdQ6AjznfaEPMZsNkjiqJxQNWzucZrMbaD?=
 =?us-ascii?Q?cJIbASjvVZZzAqtUj+TA7mpoFczlbSQaGhdUIpA1N370l0Gbx+E9DPNAQane?=
 =?us-ascii?Q?xeIk3iyF4Q4mmgdsRZKb6f4zhaXgoRG5Z9nBc2Zl8hz7yGibrD9GZnQUoTAO?=
 =?us-ascii?Q?vHxR9CGbuC3moFnDP1ruIw8R+Oy8rUzrPBYZRSzBCMlHysSCdw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfee4d7-7beb-4c65-4526-08d8ce152dcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 22:42:42.9969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTIYyHxHj3xQMm9ZYxg7KNMLshuTWDfXsSBzzEHtTDqZovLTpyKg8lm0hFE8QNwNyL9NM+tQRirVZyTDeDwRkBchd6n6n9bh293ISPRdp3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6753
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph/Damien,=0A=
=0A=
On 1/11/21 8:26 PM, Chaitanya Kulkarni wrote:=0A=
> Hi,=0A=
>=0A=
> NVMeOF Host is capable of handling the NVMe Protocol based Zoned Block=0A=
> Devices (ZBD) in the Zoned Namespaces (ZNS) mode with the passthru=0A=
> backend. There is no support for a generic block device backend to=0A=
> handle the ZBD devices which are not NVMe protocol compliant.=0A=
>=0A=
> This adds support to export the ZBDs (which are not NVMe drives) to host=
=0A=
> the from target via NVMeOF using the host side ZNS interface.=0A=
>=0A=
> The patch series is generated in bottom-top manner where, it first adds=
=0A=
> prep patch and ZNS command-specific handlers on the top of genblk and =0A=
> updates the data structures, then one by one it wires up the admin cmds=
=0A=
> in the order host calls them in namespace initializing sequence. Once=0A=
> everything is ready, it wires-up the I/O command handlers. See below for=
=0A=
> patch-series overview.=0A=
>=0A=
> All the testcases are passing for the ZoneFS where ZBD exported with=0A=
> NVMeOF backed by null_blk ZBD and null_blk ZBD without NVMeOF. Adding=0A=
> test result below.=0A=
>=0A=
> Note: This patch-series is based on the earlier posted patch series :-=0A=
>=0A=
> [PATCH V2 0/4] nvmet: admin-cmd related cleanups and a fix=0A=
> http://lists.infradead.org/pipermail/linux-nvme/2021-January/021729.html=
=0A=
>=0A=
> -ck=0A=
>=0A=
> Changes from V8:-=0A=
>=0A=
> 1. Rebase and retest on latest nvme-5.11.=0A=
> 2. Export ctrl->cap csi support only if CONFIG_BLK_DEV_ZONE is set.=0A=
> 3. Add a fix to admin ns-desc list handler for handling default csi.=0A=
>=0A=
I can see that Damien's granularity series is in the linux-block tree, I'm=
=0A=
planning to send v10 of this series given that it also has a block layer=0A=
patch=0A=
[1] should I use the linux-block/for-next or linux-nvme/nvme-5.12 ?=0A=
=0A=
=0A=
[1]  [PATCH V9 1/9] block: export bio_add_hw_pages()=0A=
