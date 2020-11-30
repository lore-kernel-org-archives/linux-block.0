Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79168C5519F
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 06:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA2520691
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 06:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="haNo9clC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JWN/d/RD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgK3GxJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 01:53:09 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2507 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgK3GxI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 01:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606720063; x=1638256063;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Z5sn7p9H1RbLs2hq4omKJ1UU5HFMsOUhHwlXiVtYC8w=;
  b=haNo9clCot0uRAISTOFnRVR0dmya0P43Q25XYXMigXENR6+KzV5p9rh9
   IOmJs4Zv6nQHK2cln0gvR0ARy+ZuRPvZVBCvvnJjAG55yqGvSSEcTx0OJ
   6HadptUvvkDnjwBgFeF8/w7VeaF9CxYWc0ll7md9NQ8mFVUqMk5YVtOnC
   rkRFwhMVJR7Sznmg248kEa4YUg8SXSUP7lZykDx9VGQkIfFHnk1Ol3XSW
   R4gBqFopG3PuNkPpm0D77xI6o+arI0F4lo7UHKsgFP5ih7HXs7zhvtdDw
   1Go/ZX0appUVtemRtVkciqtzjuA3fOZdZS8tJ0tMBs5hBsSFhepn7LomA
   Q==;
IronPort-SDR: s7DCsRknmA7mVeZUOzRrIHKHnBBUYiPSNHGLXkWX282VDIPuauwDxdxLn4TPUnY4tmofc7Xg4a
 gRlBvlFNUabkzxwHMyti/8VdMRtMA6teh5wu5kih288o3j/Fz8x2SvbHvaeFfqfcAym6cWku0p
 8KyU52dZOfTN4hGA9jUTld5Wg5oLOsZAaeTuvXZXk3xCTolhT7ttojj1URs+hHLr47zmqhkfZB
 tWF0uB4IGnTYQ6bF4DyW1hKRZVc3atDjAhgFE6jleYwxrNFgwwsMrTA0rFvJhIZpEyhVVXggWy
 Ags=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="257463384"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 15:06:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4owiO4Sp2voIRcyWRIYPJnFJEF49V7FjD+eKHmFF3W1GarfbHg5PqVb293ixr+nbImtKA7/B74vPMqqbbqSjWpLRSFulzfjYOp/mwqc9KTWznZdP/g+Pw/nWQpXEi47T+vNPghY4mRYD/jMalot5PzOpTojNQgWix8GZTc3YMstwROqYDrQndUIAD2rK1zAga5qONHshh+vsQlgsjNHmpFRoUs1eQ2ETPs0viH+N8zkrcC8jm8CJPuWcESyhefD6u0stf4b5bpDJxe9kL1lHuKiGH5hWUEVuBVaDFPOAj0+oRvAzljr8X9BkoHh2p+2k6CAWz8g+II6w9DVZE2Uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbXXW3AiFclrzzxSdlL9nqhFxk51UELwMWUwAfb3uQs=;
 b=cmn1zfaGfVQSqZQnGHTJBWdzngW6GZ9E986PdVRBr9WwyGZmdcfoP62pXT23zE5UKGAF2tz0HVe/GJpyGFRic3EDjjU1Xgs9Foit280sEgasTrd6PEeS9CXya7H3ZbaesdAi7hddFa6/byLxc4MmWh305RhR6jzOuEjeHzM2iIWC/p+/ayU9qlBGzNhYSUJ0jwEgIDipM8CuCuvQmfghSqfW4v72aXHEtmW59ei8I8kpjatTez1UMzsACUeAvb+XRIhuvVxG6GtFiufw69RJJjJgdCzzu/Kz6FIY9y2pr2RaTJCxriZy9NU8/milqfchBX7hXIJyR0dUXXmkztByFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbXXW3AiFclrzzxSdlL9nqhFxk51UELwMWUwAfb3uQs=;
 b=JWN/d/RDsfqp1qxn0loRf4jZoiIo/Saxd2RwIhdiWJVBZs+n4KTOpazsHUyMCDJP4WBKeiUman1uN5dOUBm9/MQLUcHM10DF4afWFp6s6qqqtem4bDlo7Gmmq4kWoH8Gow19HswUyjht3Su9/kjMxnck3QOrfRxdAgWJvOQCDmg=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6885.namprd04.prod.outlook.com (2603:10b6:610:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Mon, 30 Nov
 2020 06:51:59 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Mon, 30 Nov 2020
 06:51:59 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/9] nvmet: add genblk ZBD backend
Thread-Topic: [PATCH 0/9] nvmet: add genblk ZBD backend
Thread-Index: AQHWxsj8BV6nBA+s3kKgMz1iixbxTw==
Date:   Mon, 30 Nov 2020 06:51:59 +0000
Message-ID: <CH2PR04MB6522E1D0137093EC187E7AA3E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:3811:272:f33b:9d56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abca2fff-5a03-4d60-d745-08d894fc6fb1
x-ms-traffictypediagnostic: CH2PR04MB6885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB68852DF0120D846E6B3ACA89E7F50@CH2PR04MB6885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Q2rvzpEGyzPmHA2ovLZdKLHOOWxJYHYgOeZR5ylM6rZZxBEOMaTHJilWoCftFnh/TABHLLQ2kqjN0MVzbALdVfd67bKV0nigJxhcUvylUz/3RUvPQi8BYp8g4OA0Tuw/iuigp+KKAaix7h05qb5WkzEP8dJwkaoJJJFcqqVYHdaslgdz0ob9eHkmmKoksmFA90579ih0qr6GZirmH/0gcgvo91ziFpuHBjaVaUedAsi96U6kIfWfECGxBh9DPNCHfXEf2BjP0I9hwofn28u2Q8JVqFYoD9fyeHbayMmo7ECAuBVfDbwg1ukzGL/VeJE5kFR0Me0btUJb2DrM8kTCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(55016002)(9686003)(76116006)(83380400001)(7696005)(53546011)(8936002)(6506007)(52536014)(66556008)(478600001)(66446008)(64756008)(66946007)(66476007)(91956017)(4326008)(5660300002)(33656002)(8676002)(86362001)(71200400001)(2906002)(316002)(186003)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Be4izRlAb0oKPYBMpal7QOqpNvF1gVLu5PixAMc6IOvgznoDl7Q+qhuumpWI?=
 =?us-ascii?Q?VQgBZWf/S3HGc7CQ+Bs8hcYCP59NEA8BchSY4PAf7GA1ezCowsOWoW9j2U86?=
 =?us-ascii?Q?jDfmeF1fpFPtPM4EZir1tujXeVlkeeKrcHFzX8D2DxnLH4/Gk8ZvJJHlDLZV?=
 =?us-ascii?Q?OlYdhCIDJrpCvNvQ2ECXEOocQcNd1OzZcLsZe45VWEvDGcjLPJsiLbYsAz8I?=
 =?us-ascii?Q?jwPGovpK7LZxLRw6/9NK5ulKWWl5jEdwIAoT7wmItRE5piXLRgOJW8sMON3K?=
 =?us-ascii?Q?pzoxwPRzLH4jO5zdmOmzLbRdOiDLctOQB31PlZjt4lupXZQkiw9FtjyvnCDU?=
 =?us-ascii?Q?MFIAaGIdgFd4G13Zw8Cp+IVMHqijekRpzxq+5S+h3nS3yIeu9lD1GPZ1I8f4?=
 =?us-ascii?Q?pfhP+3gj+mXFaewv5XjGCMnV1vhSgvDB6P4KbJVblVFLKUQc7kZ1E9N/mxFJ?=
 =?us-ascii?Q?u60kA8w61vPmq8d3yXX7Nd8kUcTdGEv1eLr0Ar4EJMHwXYjL0LmKXFOltXxY?=
 =?us-ascii?Q?PakEpoepf3NUnTo1Pr/oB/vAqvk1zLmEqszS5UnHbhPQnlLawMR0dfMxfG/7?=
 =?us-ascii?Q?gqTMXx3FX7FCMTGG6t5ZKiayeh9LLgJ7sAJ1M0nN8e7EMNk5vOF0e7Ba6GhS?=
 =?us-ascii?Q?+6hKBKgoKbKkJsTUZKmS89YxobrDJr38o60iwPDUgGoO+Nu0taOCA94Zosmi?=
 =?us-ascii?Q?jSYpZNAlG6IjHIIACRD+NMBo0Kuri+R5/tJZ5HHQCwkxliymaekvCncw+Czh?=
 =?us-ascii?Q?gqdYcijuoApQjifOqLbe2G01kJDER/YiQTP+8SwMpZFKUK7tnr84C0WKnFqO?=
 =?us-ascii?Q?jKBWfk2629BPFbl+/sNzorJ5uvYutmHCcnAHpLepWgWqmYH5LsilkMLYt7mE?=
 =?us-ascii?Q?akx//u8FWsCu7y1guvtqjUldxXcrM4sVgskcOAn01owsMMir9clM04Alw801?=
 =?us-ascii?Q?mtOpneH4CGRj0SIKOFWHGXNcCGL+uRH57tcc+O5rN2YlQO2mSq2qdgu/fQWY?=
 =?us-ascii?Q?Nu92bCtlVpFeaqe+rv/qnrIhLyOC39NUkExTGuXZfERmTbDmW34ykR5dDN9B?=
 =?us-ascii?Q?+o9Mkd4Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abca2fff-5a03-4d60-d745-08d894fc6fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 06:51:59.8564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjKTKCnwKP7VDqWTB0DA9FfA8aq4v50abrOKkmSYtbN+yd1iwuS+zvDGNRycJ2AxHyl/XaZvWiq8MBIJ4cI43Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6885
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/30 12:29, Chaitanya Kulkarni wrote:=0A=
> NVMeOF Host is capable of handling the NVMe Protocol based Zoned Block=0A=
> Devices (ZBD) in the ZNS mode with the passthru backend. There is no=0A=
> support for a generic block device backend to handle the ZBD devices=0A=
> which are not NVMe devices.=0A=
> =0A=
> This adds support to export the ZBD drives (which are not NVMe drives)=0A=
> to host from the target with NVMeOF using the host side ZNS interface.=0A=
> =0A=
> The patch series is generated in bottom-top manner where, it first adds=
=0A=
> prep patch and ZNS command-specific handlers on the top of genblk and =0A=
> updates the data structures, then one by one it wires up the admin cmds=
=0A=
> in the order host calls them in namespace initializing sequence. Once=0A=
> everything is ready, it wires-up the I/O command handlers. See below for =
=0A=
> patch-series overview.=0A=
> =0A=
> I've tested the ZoneFS testcases with the null_blk memory backed NVMeOF=
=0A=
> namespace with nvme-loop transport. The same testcases are passing on the=
=0A=
> NVMeOF zbd-ns and are passing for null_blk without NVMeOF .=0A=
> =0A=
> Regards,=0A=
> Chaitanya=0A=
> =0A=
> Changes from V1:-=0A=
> =0A=
> 1. Remove the nvmet-$(CONFIG_BLK_DEV_ZONED) +=3D zns.o.=0A=
> 2. Mark helpers inline.=0A=
> 3. Fix typos in the comments and update the comments.=0A=
> 4. Get rid of the curly brackets.=0A=
> 5. Don't allow drives with last smaller zones.=0A=
> 6. Calculate the zasl as a function of max_zone_append_sectors,=0A=
>    bio_max_pages so we don't have to split the bio.=0A=
> 7. Add global subsys->zasl and update the zasl when new namespace=0A=
>    is enabled.=0A=
> 8. Rmove the loop in the nvmet_bdev_execute_zone_mgmt_recv() and=0A=
>    move functionality in to the report zone callback.=0A=
> 9. Add goto for default case in nvmet_bdev_execute_zone_mgmt_send().=0A=
> 10, Allocate the zones buffer with zones size instead of bdev nr_zones.=
=0A=
> =0A=
> Chaitanya Kulkarni (9):=0A=
>   block: export __bio_iov_append_get_pages()=0A=
> 	Prep patch needed for implementing Zone Append.=0A=
>   nvmet: add ZNS support for bdev-ns=0A=
> 	Core Command handlers and various helpers for ZBD backend which=0A=
> 	 will be called by target-core/target-admin etc.=0A=
>   nvmet: trim down id-desclist to use req->ns=0A=
> 	Cleanup needed to avoid the code repetation for passing extra=0A=
> 	function parameters for ZBD backend handlers.=0A=
>   nvmet: add NVME_CSI_ZNS in ns-desc for zbdev=0A=
> 	Allows host to identify zoned namesapce.=0A=
>   nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev=0A=
> 	Allows host to identify controller with the ZBD-ZNS.=0A=
>   nvmet: add cns-cs-ns in id-ctrl for ZNS bdev=0A=
> 	Allows host to identify namespace with the ZBD-ZNS.=0A=
>   nvmet: add zns cmd effects to support zbdev=0A=
> 	Allows host to support the ZNS commands when zoned-blkdev is=0A=
> 	 selected.=0A=
>   nvmet: add zns bdev config support=0A=
> 	Allows user to override any target namespace attributes for=0A=
> 	 ZBD.=0A=
>   nvmet: add ZNS based I/O cmds handlers=0A=
> 	Handlers for Zone-Mgmt-Send/Zone-Mgmt-Recv/Zone-Append.=0A=
> =0A=
>  block/bio.c                       |   3 +-=0A=
>  drivers/nvme/target/Makefile      |   2 +-=0A=
>  drivers/nvme/target/admin-cmd.c   |  38 ++-=0A=
>  drivers/nvme/target/io-cmd-bdev.c |  12 +=0A=
>  drivers/nvme/target/io-cmd-file.c |   2 +-=0A=
>  drivers/nvme/target/nvmet.h       |  19 ++=0A=
>  drivers/nvme/target/zns.c         | 463 ++++++++++++++++++++++++++++++=
=0A=
>  include/linux/bio.h               |   1 +=0A=
>  8 files changed, 524 insertions(+), 16 deletions(-)=0A=
>  create mode 100644 drivers/nvme/target/zns.c=0A=
> =0A=
=0A=
I had a few questions about the failed zonefs tests that you reported in th=
e=0A=
cover letter of V1. Did you run the tests again with V2 ? Do you still see =
the=0A=
errors or not ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
