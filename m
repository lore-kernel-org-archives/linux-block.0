Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D090C64E7B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 06:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A922085B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 06:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K/GblgqW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LmjIACZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgLAGsI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 01:48:08 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52965 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgLAGsI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 01:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606805287; x=1638341287;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lhbqpBAG+PuiEDHo1Jgl2MPYaJhSX8mwlGakRpsKh1c=;
  b=K/GblgqWrYwNjYsb/4lGX79NNaJPEFIsi/DKcy4fhrnidKs6c0IOuhlr
   6VEjkPQG1SiaC1AH+OW217Z39oY+PnXYbDzJfytHttZoxXrf9rPCzletB
   VM0coWYzYwYTdbMAUA0/pEA+uFPPVp54kcxMHQqR7qyHvV29aNZGIxpbp
   JTtLSbgcoJUu5ZHgo2hKJr/64ZvMbTSJBy9lCM3szoyuUiaJ1gWq5Jubg
   a7PsU3bdZh52xe8HZIH8BAN8+yvw+JZFDJcm4uSKVJ0P1APcIy6Xi6eBL
   XT5objIxhivvzaomqARXWLBNkb4mHDcuiWAkI2ISYfanCuk8kb5vALQmR
   g==;
IronPort-SDR: j7ozqqxezOVdDg8XuAnD6XVaf7/3y3LbRuFYYAsOejO/U6iFFwmbCzxas/TXwtzJRGVDdiTKGH
 E7vObYWtt0duxezcbE067nscNFC0Hmbtx/QDVjGC6IYxDmeKpEtgVea1P5ezpXImSc39iG4U+r
 My0XASGgumooxltHyX98P8xrILgmjxtwJ6KGQpNpwzIPi8NYUkV2aMb50k6xbg2oXAUTp4NVjO
 obxk/RUpZkHcP8srveMMt0RcMPfHYGVjKqSc22oG+LQOKZv72FE2JUyCLY85Ae6ggtZ5+EZyzx
 JeE=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="153823746"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 14:47:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdW8qxoP40yaXDBKPtgXWpNc+9E6coZ/AyXAaXwD/GJ722C4N99lEGO2I8VDTYA+TLZTVSe8T+vl/fg2Sx2O7LKnoDJJBDesYIsl1chQ8kZ11tT7rIR9yVpThN3ev816bMxjAuROaiCCun0o3fAEYs2iaSTHT0ve0mAWvS37iH/VCgreXpjtxVR5pqtjdoUKwQN5f37ZWkbZ4qGco2w64yFFIzt+c5j5kqplmHwjk6gXImQqR9BzmRZGF08N5gOBELoi+eYZKK7tVFeAjxphbNwLMudIzm4GMddAMZ6pH4UeX57aDpxDgqOeeJLZejzQes1cGaOtp4C4w/3ty0n3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHUTxZ3tMrXqAyyMJl2m+1WZuMx4fG+5fdk5Cmj4Dfc=;
 b=ee8CR4sI/Pn9Pro99c4379wWX6EatJDfmfRhzDglbmf6UkQJJL6HCxWXHXmsWC8xsUEONt8I4t6+5XbYgpW+CINNAO1gh0PrjeFl4c0yyzBgpcPWslNUowXu7ye+870dnNsZoYOoC72xCyc9aabwy7e1YcHaruMSQGXkoOmCqOrRL4xjujf8s0xSvmpQ2CaDTNQQ+2zwoPr26RG82JP7PcFc0VV63y1iJRZJeX4H+utOYpqTZro8h24qPylrhYqmYI59gb9Uzb33TDpb+oppWfrigIHwj8ZZDTDmqiCdPOX572ClPTFeEedPJI1TkLYwGi/poK/C97V4l/OPnHgeHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHUTxZ3tMrXqAyyMJl2m+1WZuMx4fG+5fdk5Cmj4Dfc=;
 b=LmjIACZpv9ZG9tIMbIihEvZO+GbVXult2nYvtraxNNj5tznL6qAVLPijskUe7LxR93jxwuRUw15sDV/OFMv40UpAyv+KiSoV3qUrnjDgMpypHH/J6yD7+6gbDzLXxPB5eq+xj0wei8RM2J7RpbvqqxWJCmHgXxLhhRRDK71MFqw=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7094.namprd04.prod.outlook.com (2603:10b6:610:98::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 1 Dec
 2020 06:47:00 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Tue, 1 Dec 2020
 06:47:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Topic: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Index: AQHWx5hxyX5y33697USsRw2vyDa0aA==
Date:   Tue, 1 Dec 2020 06:46:59 +0000
Message-ID: <CH2PR04MB6522A2943EFDF118FEBA264EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b1ec0b1-7330-4386-4ea9-08d895c4e760
x-ms-traffictypediagnostic: CH2PR04MB7094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB70948E68BDE46454FF234D5FE7F40@CH2PR04MB7094.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9VF+Xvpf14MFDD5LY8Y5/d7UTrZ5uAo+FPEGFG5HeUxMVhYbpHanLmb8iw9cTPVm2BY5J48VDtC/GE+k7cB7Yw1E9ToU5676DQV8LkUUym+pLz0htS/rhEz6g/M6pZCan3ux44zN9Zj8RuFr8UO56n1Ns9eqaZv+kS1Uk0qNM7Kf4xj4qaI29M4N7E7giujnhMhZYKLzLqUMcdQjbN+x0MJAirwWE8/75YNUmduQWPdL2el5ejoLdm8jbYv/kdNCBJ/xSQ8Wft69v2DZbADZVnlZSTFINMPaMg47h+ecGDQ9uF8CCv8utraRRLi8jYrDD9YJ4TMz4I00zqCsweZMIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(110136005)(66476007)(66946007)(54906003)(66556008)(76116006)(33656002)(7696005)(91956017)(8676002)(30864003)(478600001)(5660300002)(86362001)(83380400001)(9686003)(55016002)(186003)(64756008)(66446008)(6506007)(53546011)(26005)(4326008)(8936002)(52536014)(2906002)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?H8zCZFyluuoWXifNM6Yce7pcNVVM/hggUaod4/swBGNu3QvfE7F6l3JkS7hv?=
 =?us-ascii?Q?MNCUPfAmSqMzVVWAbbK8jL4fkd3Vgh15QKzuUfPW7M1IML2ybRte5GtkUVo5?=
 =?us-ascii?Q?VFbrmN2sR+bi/r+71oCFgZlkkXLXFSAZ4XjB9wssXS0TpF5jdt2fRRXne/qx?=
 =?us-ascii?Q?yJECjr4oqGF3QBqIXRHH2X05u3noWHLPjPlqh58QyBYZf8yOwT79CPBdCYgK?=
 =?us-ascii?Q?RyUs8JHCcQKFBvBrJXfJ9KfxWRkxBOn6bghIW4o6AzUjb3+75abr9n2uzZxw?=
 =?us-ascii?Q?feRENbOqT5mR2kf27imiXkKxsZHIfWuao/zfZwUOgoWUwqp7VHkcr7C50TOa?=
 =?us-ascii?Q?wO7pgRDg//Alk83OutPRtwKQVFB8FNIqoAyVpM+4PqfArD4D1sbH0f+K2TpH?=
 =?us-ascii?Q?pKI7VDJt4G6XZarGtX9f0ux7c8LOH4f/InkYo/aQzmhRJ54ya8FJR/Jarsnn?=
 =?us-ascii?Q?ekjIR8J+2fb4wqGFR8d+Zz3S59qF/ntbx3w+jRMVKtl3R1DofVSLV2p9jiCg?=
 =?us-ascii?Q?5GjTZIcmPXlt0SuUBRaY62f3q2OzUFk2PyZySLibz8u+njm39TF5a+nk/2Nq?=
 =?us-ascii?Q?w8z3sYmzcqUGWcwqF0vEqxE3zdKMNDwiUnrgEJRndNWWCsLFxDlb6/zYKSVJ?=
 =?us-ascii?Q?/Sx235R5snRzJMWj2MbA59u887A72qYiTJ6IMaYLxfYouoFWDHqPtoRpjj/P?=
 =?us-ascii?Q?/sx7jJ1NE2l74faMO46fxNpsDlbYfeQqN7NMqY9kxOsPZL29VDlqunJotadP?=
 =?us-ascii?Q?NoqYgkkNcpMnvoMoAJSYMVbjNh56xbrTtkmFiHCJ3SeDmlbD5UVIhq41UKl6?=
 =?us-ascii?Q?40MD35X8CWkln5THYTGRO0dp4m3XO9XXpt4szrCs5GKhOp/UgvDvqjn719kk?=
 =?us-ascii?Q?o81+HGqPoK+i1qfmVFJWTKcZK1JZbOcXm/tvQGWBh+AJVDRwBK97qxcH3tVS?=
 =?us-ascii?Q?ZaBzVgwjkSiStgdjRHD/7E/Q3W/2UrH8o+llxhjZJosXz0tVhA7hEc5u77lS?=
 =?us-ascii?Q?98k8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1ec0b1-7330-4386-4ea9-08d895c4e760
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 06:46:59.8960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXovvnWf3Nq72QGhau9TXXay/D2xObxKp1oeD35zTxHZaLcwuCrhD7BwAd6Ptjl4/9vFjerCd4/6UyYr3/HpYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7094
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/12/01 13:14, Chaitanya Kulkarni wrote:=0A=
> Hi,=0A=
> =0A=
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
> namespace with nvme-loop transport. The only testcase is failing in #12=
=0A=
> on both null blk and NVMeOF ZBD backe by null_blk. =0A=
> =0A=
> It uses invalid block device to format zonefs and doesn't do anyting=0A=
> with the input device, still looking into it.=0A=
> =0A=
> Regards,=0A=
> Chaitanya=0A=
> =0A=
> Changes from V2:-=0A=
> =0A=
> 1.  Move conventional zone bitmap check into =0A=
>     nvmet_bdev_validate_zns_zones(). =0A=
> 2.  Don't use report zones call to check the runt zone.=0A=
> 3.  Trim nvmet_zasl() helper.=0A=
> 4.  Fix typo in the nvmet_zns_update_zasl().=0A=
> 5.  Remove the comment and fix the mdts calculation in=0A=
>     nvmet_execute_identify_cns_cs_ctrl().=0A=
> 6.  Use u64 for bufsize in nvmet_bdev_execute_zone_mgmt_recv().=0A=
> 7.  Remove nvmet_zones_to_desc_size() and fix the nr_zones=0A=
>     calculation.=0A=
> 8.  Remove the op variable in nvmet_bdev_execute_zone_append().=0A=
> 9.  Fix the nr_zones calculation nvmet_bdev_execute_zone_mgmt_recv().=0A=
> 10. Update cover letter subject.=0A=
> =0A=
> Changes from V1:-=0A=
> =0A=
> 1.  Remove the nvmet-$(CONFIG_BLK_DEV_ZONED) +=3D zns.o.=0A=
> 2.  Mark helpers inline.=0A=
> 3.  Fix typos in the comments and update the comments.=0A=
> 4.  Get rid of the curly brackets.=0A=
> 5.  Don't allow drives with last smaller zones.=0A=
> 6.  Calculate the zasl as a function of ax_zone_append_sectors,=0A=
>     bio_max_pages so we don't have to split the bio.=0A=
> 7.  Add global subsys->zasl and update the zasl when new namespace=0A=
>     is enabled.=0A=
> 8.  Rmove the loop in the nvmet_bdev_execute_zone_mgmt_recv() and=0A=
>     move functionality in to the report zone callback.=0A=
> 9.  Add goto for default case in nvmet_bdev_execute_zone_mgmt_send().=0A=
> 10. Allocate the zones buffer with zones size instead of bdev nr_zones.=
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
> 	Handlers for Zone-Mgmt-Send/Zone-Mgmt-Recv/Zone-Append=0A=
> =0A=
>  block/bio.c                       |   3 +-=0A=
>  drivers/nvme/target/Makefile      |   2 +-=0A=
>  drivers/nvme/target/admin-cmd.c   |  38 ++-=0A=
>  drivers/nvme/target/io-cmd-bdev.c |  12 +=0A=
>  drivers/nvme/target/io-cmd-file.c |   2 +-=0A=
>  drivers/nvme/target/nvmet.h       |  19 ++=0A=
>  drivers/nvme/target/zns.c         | 426 ++++++++++++++++++++++++++++++=
=0A=
>  include/linux/bio.h               |   1 +=0A=
>  8 files changed, 487 insertions(+), 16 deletions(-)=0A=
>  create mode 100644 drivers/nvme/target/zns.c=0A=
> =0A=
> # for i in nvme1n1 nullb1 ; do ./zonefs-tests.sh /dev/$i; done =0A=
> Gathering information on /dev/nvme1n1...=0A=
> zonefs-tests on /dev/nvme1n1:=0A=
>   4 zones (0 conventional zones, 4 sequential zones)=0A=
>   524288 512B sectors zone size (256 MiB)=0A=
>   1 max open zones=0A=
> Running tests=0A=
>   Test 0010:  mkzonefs (options)                                   ... PA=
SS=0A=
>   Test 0011:  mkzonefs (force format)                              ... PA=
SS=0A=
>  *Test 0012:  mkzonefs (invalid device)                            ... FA=
IL*=0A=
>   Test 0013:  mkzonefs (super block zone state)                    ... PA=
SS=0A=
>   Test 0020:  mount (default)                                      ... PA=
SS=0A=
>   Test 0021:  mount (invalid device)                               ... PA=
SS=0A=
>   Test 0022:  mount (check mount directory sub-directories)        ... PA=
SS=0A=
>   Test 0023:  mount (options)                                      ... PA=
SS=0A=
>   Test 0030:  Number of files (default)                            ... PA=
SS=0A=
>   Test 0031:  Number of files (aggr_cnv)                           ... sk=
ip=0A=
>   Test 0032:  Number of files using stat (default)                 ... PA=
SS=0A=
>   Test 0033:  Number of files using stat (aggr_cnv)                ... PA=
SS=0A=
>   Test 0034:  Number of blocks using stat (default)                ... PA=
SS=0A=
>   Test 0035:  Number of blocks using stat (aggr_cnv)               ... PA=
SS=0A=
>   Test 0040:  Files permissions (default)                          ... PA=
SS=0A=
>   Test 0041:  Files permissions (aggr_cnv)                         ... sk=
ip=0A=
>   Test 0042:  Files permissions (set value)                        ... PA=
SS=0A=
>   Test 0043:  Files permissions (set value + aggr_cnv)             ... sk=
ip=0A=
>   Test 0050:  Files owner (default)                                ... PA=
SS=0A=
>   Test 0051:  Files owner (aggr_cnv)                               ... sk=
ip=0A=
>   Test 0052:  Files owner (set value)                              ... PA=
SS=0A=
>   Test 0053:  Files owner (set value + aggr_cnv)                   ... sk=
ip=0A=
>   Test 0060:  Files size (default)                                 ... PA=
SS=0A=
>   Test 0061:  Files size (aggr_cnv)                                ... sk=
ip=0A=
>   Test 0070:  Conventional file truncate                           ... sk=
ip=0A=
>   Test 0071:  Conventional file truncate (aggr_cnv)                ... sk=
ip=0A=
>   Test 0072:  Conventional file unlink                             ... sk=
ip=0A=
>   Test 0073:  Conventional file unlink (aggr_cnv)                  ... sk=
ip=0A=
>   Test 0074:  Conventional file random write                       ... sk=
ip=0A=
>   Test 0075:  Conventional file random write (direct)              ... sk=
ip=0A=
>   Test 0076:  Conventional file random write (aggr_cnv)            ... sk=
ip=0A=
>   Test 0077:  Conventional file random write (aggr_cnv, direct)    ... sk=
ip=0A=
>   Test 0078:  Conventional file mmap read/write                    ... sk=
ip=0A=
>   Test 0079:  Conventional file mmap read/write (aggr_cnv)         ... sk=
ip=0A=
>   Test 0080:  Sequential file truncate                             ... PA=
SS=0A=
>   Test 0081:  Sequential file unlink                               ... PA=
SS=0A=
>   Test 0082:  Sequential file buffered write IO                    ... PA=
SS=0A=
>   Test 0083:  Sequential file overwrite                            ... PA=
SS=0A=
>   Test 0084:  Sequential file unaligned write (sync IO)            ... PA=
SS=0A=
>   Test 0085:  Sequential file unaligned write (async IO)           ... PA=
SS=0A=
>   Test 0086:  Sequential file append (sync)                        ... PA=
SS=0A=
>   Test 0087:  Sequential file append (async)                       ... PA=
SS=0A=
>   Test 0088:  Sequential file random read                          ... PA=
SS=0A=
>   Test 0089:  Sequential file mmap read/write                      ... PA=
SS=0A=
>   Test 0090:  sequential file 4K synchronous write                 ... PA=
SS=0A=
>   Test 0091:  Sequential file large synchronous write              ... PA=
SS=0A=
> =0A=
> 45 / 46 tests passed=0A=
> Gathering information on /dev/nullb1...=0A=
> zonefs-tests on /dev/nullb1:=0A=
>   4 zones (0 conventional zones, 4 sequential zones)=0A=
>   524288 512B sectors zone size (256 MiB)=0A=
>   0 max open zones=0A=
> Running tests=0A=
>   Test 0010:  mkzonefs (options)                                   ... PA=
SS=0A=
>   Test 0011:  mkzonefs (force format)                              ... PA=
SS=0A=
>  *Test 0012:  mkzonefs (invalid device)                            ... FA=
IL*=0A=
>   Test 0013:  mkzonefs (super block zone state)                    ... PA=
SS=0A=
>   Test 0020:  mount (default)                                      ... PA=
SS=0A=
>   Test 0021:  mount (invalid device)                               ... PA=
SS=0A=
>   Test 0022:  mount (check mount directory sub-directories)        ... PA=
SS=0A=
>   Test 0023:  mount (options)                                      ... PA=
SS=0A=
>   Test 0030:  Number of files (default)                            ... PA=
SS=0A=
>   Test 0031:  Number of files (aggr_cnv)                           ... sk=
ip=0A=
>   Test 0032:  Number of files using stat (default)                 ... PA=
SS=0A=
>   Test 0033:  Number of files using stat (aggr_cnv)                ... PA=
SS=0A=
>   Test 0034:  Number of blocks using stat (default)                ... PA=
SS=0A=
>   Test 0035:  Number of blocks using stat (aggr_cnv)               ... PA=
SS=0A=
>   Test 0040:  Files permissions (default)                          ... PA=
SS=0A=
>   Test 0041:  Files permissions (aggr_cnv)                         ... sk=
ip=0A=
>   Test 0042:  Files permissions (set value)                        ... PA=
SS=0A=
>   Test 0043:  Files permissions (set value + aggr_cnv)             ... sk=
ip=0A=
>   Test 0050:  Files owner (default)                                ... PA=
SS=0A=
>   Test 0051:  Files owner (aggr_cnv)                               ... sk=
ip=0A=
>   Test 0052:  Files owner (set value)                              ... PA=
SS=0A=
>   Test 0053:  Files owner (set value + aggr_cnv)                   ... sk=
ip=0A=
>   Test 0060:  Files size (default)                                 ... PA=
SS=0A=
>   Test 0061:  Files size (aggr_cnv)                                ... sk=
ip=0A=
>   Test 0070:  Conventional file truncate                           ... sk=
ip=0A=
>   Test 0071:  Conventional file truncate (aggr_cnv)                ... sk=
ip=0A=
>   Test 0072:  Conventional file unlink                             ... sk=
ip=0A=
>   Test 0073:  Conventional file unlink (aggr_cnv)                  ... sk=
ip=0A=
>   Test 0074:  Conventional file random write                       ... sk=
ip=0A=
>   Test 0075:  Conventional file random write (direct)              ... sk=
ip=0A=
>   Test 0076:  Conventional file random write (aggr_cnv)            ... sk=
ip=0A=
>   Test 0077:  Conventional file random write (aggr_cnv, direct)    ... sk=
ip=0A=
>   Test 0078:  Conventional file mmap read/write                    ... sk=
ip=0A=
>   Test 0079:  Conventional file mmap read/write (aggr_cnv)         ... sk=
ip=0A=
>   Test 0080:  Sequential file truncate                             ... PA=
SS=0A=
>   Test 0081:  Sequential file unlink                               ... PA=
SS=0A=
>   Test 0082:  Sequential file buffered write IO                    ... PA=
SS=0A=
>   Test 0083:  Sequential file overwrite                            ... PA=
SS=0A=
>   Test 0084:  Sequential file unaligned write (sync IO)            ... PA=
SS=0A=
>   Test 0085:  Sequential file unaligned write (async IO)           ... PA=
SS=0A=
>   Test 0086:  Sequential file append (sync)                        ... PA=
SS=0A=
>   Test 0087:  Sequential file append (async)                       ... PA=
SS=0A=
>   Test 0088:  Sequential file random read                          ... PA=
SS=0A=
>   Test 0089:  Sequential file mmap read/write                      ... PA=
SS=0A=
>   Test 0090:  sequential file 4K synchronous write                 ... PA=
SS=0A=
>   Test 0091:  Sequential file large synchronous write              ... PA=
SS=0A=
> =0A=
> 45 / 46 tests passed=0A=
> # =0A=
> # for i in nvme1n1 nullb1 ; do ./zonefs-tests.sh -t 0012 /dev/$i; done =
=0A=
> Gathering information on /dev/nvme1n1...=0A=
> zonefs-tests on /dev/nvme1n1:=0A=
>   4 zones (0 conventional zones, 4 sequential zones)=0A=
>   524288 512B sectors zone size (256 MiB)=0A=
>   1 max open zones=0A=
> Running tests=0A=
>   Test 0012:  mkzonefs (invalid device)                            ... FA=
IL=0A=
=0A=
This passes for me:=0A=
=0A=
./zonefs-tests.sh -t 0012 /dev/nullb0=0A=
Gathering information on /dev/nullb0...=0A=
zonefs-tests on /dev/nullb0:=0A=
  4 zones (0 conventional zones, 4 sequential zones)=0A=
  524288 512B sectors zone size (256 MiB)=0A=
  1 max open zones=0A=
Running tests=0A=
  Test 0012:  mkzonefs (invalid device)                            ... PASS=
=0A=
=0A=
1 / 1 tests passed=0A=
=0A=
This test create a a regular nullb device and tries mkzonefs on it, which s=
hould=0A=
fail since the block device is not zoned. In your case, it looks like the t=
est=0A=
endup using an existing zoned nullb device, which should not happen (nullb4=
 and=0A=
nullb5). How many nullb devices do you have on that system ?=0A=
=0A=
> =0A=
> 0 / 1 tests passed=0A=
> Gathering information on /dev/nullb1...=0A=
> zonefs-tests on /dev/nullb1:=0A=
>   4 zones (0 conventional zones, 4 sequential zones)=0A=
>   524288 512B sectors zone size (256 MiB)=0A=
>   0 max open zones=0A=
> Running tests=0A=
>   Test 0012:  mkzonefs (invalid device)                            ... FA=
IL=0A=
> =0A=
> 0 / 1 tests passed=0A=
> # cat nvme1n1-zonefs-tests.log =0A=
> ## Test scripts/0012.sh (mkzonefs (invalid device))=0A=
> =0A=
> /dev/console is not a block device=0A=
> /dev/nullb4=0A=
> /dev/nullb4: 524288000 512-byte sectors (250 GiB)=0A=
>   Host-managed device=0A=
>   1000 zones of 524288 512-byte sectors (256 MiB)=0A=
>   0 conventional zones, 1000 sequential zones=0A=
>   0 read-only zones, 0 offline zones=0A=
> Format:=0A=
>   999 usable zones=0A=
>   Aggregate conventional zones: disabled=0A=
>   File UID: 0=0A=
>   File GID: 0=0A=
>   File access permissions: 640=0A=
>   FS UUID: 339b07fe-ebbb-4876-be16-5a887384f349=0A=
> Resetting sequential zones=0A=
> Writing super block=0A=
>  --> SUCCESS (should FAIL)=0A=
> FAILED=0A=
> =0A=
> # cat nullb1-zonefs-tests.log =0A=
> ## Test scripts/0012.sh (mkzonefs (invalid device))=0A=
> =0A=
> /dev/console is not a block device=0A=
> /dev/nullb5=0A=
> /dev/nullb5: 524288000 512-byte sectors (250 GiB)=0A=
>   Host-managed device=0A=
>   1000 zones of 524288 512-byte sectors (256 MiB)=0A=
>   0 conventional zones, 1000 sequential zones=0A=
>   0 read-only zones, 0 offline zones=0A=
> Format:=0A=
>   999 usable zones=0A=
>   Aggregate conventional zones: disabled=0A=
>   File UID: 0=0A=
>   File GID: 0=0A=
>   File access permissions: 640=0A=
>   FS UUID: 591f1476-47c6-4d81-b0e8-7c82d4c5b657=0A=
> Resetting sequential zones=0A=
> Writing super block=0A=
>  --> SUCCESS (should FAIL)=0A=
> FAILED=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
