Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A936C169C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 03:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC2E21773
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 03:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QPGpswy5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hxYNJQgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfBLDCA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 22:02:00 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45112 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfBLDB7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 22:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549940524; x=1581476524;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7HOL8NrXgDganMDZsDX2NAS+8DH8cySK5DuAPjwrxzQ=;
  b=QPGpswy5y91uJ+u2RXj26TJYJuCuEAZHAhueugdcNq5XKzwXAEFQsgsw
   AKzFpa6TZ4oYevxRbjO/yF1QvAy7NXqArezhT6CXgMgdoUBnuVvIFGcwK
   Rtdd9dHUSbhh1FgEjYFetJKjdSkR8ZZKT5huF26jonJKGRI+9ifKvFqXV
   mvWt1WrQTtSuze3o/5bP4KUr8baAblDP0qo+yrDxm+6fFoE1/ZR6hybgE
   j96mq6N4Av3g84jkBiEaOt6CCIFBYn2XU2wmQp+03g96aOELhPHrl3Ggo
   Tj6pba6xb0QG/Z14ZVErUFjMY7MFAVJpH74jgteDQpD7KEQE8s7XLlz30
   A==;
X-IronPort-AV: E=Sophos;i="5.58,361,1544457600"; 
   d="scan'208";a="199167072"
Received: from mail-dm3nam03lp2055.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.55])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 11:02:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HOL8NrXgDganMDZsDX2NAS+8DH8cySK5DuAPjwrxzQ=;
 b=hxYNJQgYeiSxmVXUExX1WNBvmEA4wHaso032BT5apq+soQtWbw/aWuClndVvcHqg4Yw8G1SYGeqyXYT9S6GlQDWx41km+bAwvmn7E+G7IZ3fBpsP1DsAtty3FgA1vz8y97P3s58zb115JC4CdhWva24jkdKo17shPVmFsScZYM0=
Received: from BN8PR04MB5812.namprd04.prod.outlook.com (20.179.75.75) by
 BN8PR04MB5522.namprd04.prod.outlook.com (20.178.213.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 03:01:56 +0000
Received: from BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::a154:37ae:a602:2458]) by BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::a154:37ae:a602:2458%4]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 03:01:56 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH v3] nullb: Prevent use of legacy request queue mode
Thread-Topic: [PATCH v3] nullb: Prevent use of legacy request queue mode
Thread-Index: AQHUwmQr2Cdtwf5BqU+TFKeq+LgcPQ==
Date:   Tue, 12 Feb 2019 03:01:56 +0000
Message-ID: <BN8PR04MB58129B4F85A2007C6C89F6F6E7650@BN8PR04MB5812.namprd04.prod.outlook.com>
References: <20190211234716.18816-1-damien.lemoal@wdc.com>
 <a27e13e6-93a3-e7f7-cc67-a7169c8a44ad@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 499f8616-1e1d-407c-6b59-08d6909672a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN8PR04MB5522;
x-ms-traffictypediagnostic: BN8PR04MB5522:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BN8PR04MB5522;23:+Cr8NNiSZ8iCbr3oamFzovJwXqTsNudbQk9GCrQTb?=
 =?us-ascii?Q?fk0XbIxaHqyJpBRAzgDbozjFIr3CNErbRT1WK2wilLXuaS8X5iCkht3S6/3I?=
 =?us-ascii?Q?Je5wJ09DTruy8vpCB8I33BJdE5OPZAtqe19PElJg6eha89EA46mEHPCkV0aY?=
 =?us-ascii?Q?rrZ8HmFMeUfws6Fu4Z9ThAnOck4xwLeJ4mES0mDS6RxWfIN5SYcyX3MWeQAs?=
 =?us-ascii?Q?KSfoI8y2rUaenEMcRpnbssl4lm/FGoNkK8qX0TocwrAc7fzRIXB9V5ziICF9?=
 =?us-ascii?Q?e3WWvDipBUgjLzuyAlVLcJSo1RjDnEJYoDkTApHepoWecNPufCGOQzJUKE/V?=
 =?us-ascii?Q?jRsOpAmpvowEBzSb19j0jnO/j1b4E3WWui3NFYnNkHhdtsHBvFumUHIKEpfe?=
 =?us-ascii?Q?o+9eye1CZ4aNQYuSkLBiG+/wY17vG/uPuhKqQFxprYeGX4g0vGLv/zmuRQH9?=
 =?us-ascii?Q?xeiGmhfBCf3DWzLy34QSEuOr05X2hxU2SXQMC2B7qxyo/ISuuFVC1mfIhi6b?=
 =?us-ascii?Q?J9FfYjU0717MpYvFMGWF/pX3rVP46fvbAlsZftytJ2MyjH8mdGkFkb6bn5hu?=
 =?us-ascii?Q?zwUWc+9plswm+3IDjuVtczvfCC7MGEPo2JXhQgSlNI2YuoUonRs7uofIozGx?=
 =?us-ascii?Q?FhySfViEq3nFYNyeIJ6IVZGuLSLeLXCSJwa644RNCdSnwLP7tp8fUnCoZKQI?=
 =?us-ascii?Q?xHIRmFZ+OoLP9s9EOYuKMY7Zzv3V3INrcWU+oKdebG05xaaQ7W5KuOCbrpj0?=
 =?us-ascii?Q?gsD1hZ/HmarvgDfDR59Wb9LmiDwS2Uk1ftIalqD0kqRoxe2pbg5nqxlEgJqo?=
 =?us-ascii?Q?UwiKnwmcDOw1WX9USCwM/4OJe3MbDIG3tuNiQ5zOgsxc44/tTmrWfKC44twd?=
 =?us-ascii?Q?zJN2gPnjwvWGw9LpKyArnimSSthQsL6RbwLBLC+xIR2df5eHJjmY3FeaLB45?=
 =?us-ascii?Q?FfXDWBhkPDkPybP+eZKbhDvbKV5zO85Xf1yJmM6dOWVFKJM0Qryx6n2tPUUC?=
 =?us-ascii?Q?/9rcB1FKe+TsUbM+5gWhyVK0SQed5d2JKt6Iq4omeY19NkFCR95gjcq2jTza?=
 =?us-ascii?Q?r/no0bSg5LDxckbWYATan9A1P2rFTRGwLGnuGu20DU+kF9IF6b8iMTRSHxRN?=
 =?us-ascii?Q?FIHCM9OaVR43gD3j11vDNXXiyvZtQKeCJoZ6UPJXK5KQME8nC7n9ddqhp27u?=
 =?us-ascii?Q?o/VZ/VMOwGp22LNmjng3EvqdD/J0r6c3XwA?=
x-microsoft-antispam-prvs: <BN8PR04MB55226359BD8FB2D1D3E992CAE7650@BN8PR04MB5522.namprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(366004)(376002)(39860400002)(189003)(199004)(7696005)(6116002)(14454004)(478600001)(7736002)(76176011)(25786009)(72206003)(3846002)(97736004)(86362001)(2906002)(186003)(99286004)(2501003)(476003)(33656002)(66066001)(446003)(110136005)(81156014)(486006)(74316002)(53546011)(316002)(6506007)(102836004)(26005)(305945005)(9686003)(106356001)(71200400001)(8936002)(55016002)(105586002)(14444005)(256004)(71190400001)(229853002)(4326008)(68736007)(6436002)(6246003)(81166006)(53936002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB5522;H:BN8PR04MB5812.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6UELhhrMMOZov21Jbhbp6vztouVh00J793eiiehES01vH/Th47WwPbOpRvHqXlgyVRjtsjZ405Bft18F4+A3n8ZbIdpHWVE3L2WIq8QhbmSnipOLhGaIW+65k6RpvbnZtU0OyiZGPu6A+C0HnKExjzBv4rcLVUHUJ5jhM3WwTKguBNA4evhyy8dsxZo+kj4fAxXqqP5C+Pq16TCPOdYJLiMZTMo5dqcs7UDv/AFu6LQNphjkfxiglperc+3WgtaBOlSmug2EG/52VbSslc5PzoYI8jSZadjGLsHRloY5U55crXtQrEY+QxzZ2cCQH3pMNqe0UjX9fUlMx/xCWgJGPnMiz8U9IPRjMe5KJVett3a2+GlP5+EPQvdgxcTcFjGrmLs/hAH9issVT5lNFRJiJXrzWxBIJuEEvN3F2GARC3I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499f8616-1e1d-407c-6b59-08d6909672a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 03:01:56.0885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5522
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/02/12 11:55, Jens Axboe wrote:=0A=
> On 2/11/19 4:47 PM, Damien Le Moal wrote:=0A=
>> When null_blk queue mode is specified together with modprobe/insmod, a=
=0A=
>> check to prevent setting the nullb device queue mode to 1 (NULL_Q_RQ) is=
=0A=
>> done. However, the same check is not performed when setting up a nullb=
=0A=
>> device through configfs, resulting in a oops (NULL pointer dereference=
=0A=
>> for the device request queue).=0A=
>>=0A=
>> Fix this problem by checking for an invalid queue mode value in=0A=
>> null_validate_conf(), propagating -EINVAL to null_add_dev() if the queue=
=0A=
>> mode is NULL_Q_RQ. While at it, also fix the propagation to user space=
=0A=
>> of null_add_dev() return value when a nullb device is created through=0A=
>> the power attribute of configfs.=0A=
>>=0A=
>> Finally, remove the "1=3Drq" value from the list of possible values of=
=0A=
>> the queue_mode module argument to make it clear that this is no longer=
=0A=
>> a valid setting.=0A=
> =0A=
> I actually left that in there on purpose, to avoid breaking test=0A=
> scripts. It's not the perfect solution, but I viewed it as the=0A=
> lesser of two evils. Maybe we're fine now, I think blktests has=0A=
> been fixed a while back?=0A=
> =0A=
=0A=
Yes, blktests is fine right now and not triggering the problem with a defau=
lt=0A=
config. Internally, blktests never tries to enable the rq=3D1 mode. I disco=
vered=0A=
this problem doing tests manually.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
