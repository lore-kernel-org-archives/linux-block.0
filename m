Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7EEC2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 06:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66E161417
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 06:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhEYGRY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 02:17:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46165 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhEYGRX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 02:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621923354; x=1653459354;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1R85ZEi+aLNE5288xgE4Ndu1JlSWBBUbpzFD5EHAdyk=;
  b=LccgyYeiCz1S3sUDNxkdecG/GzyFRjs86e3Ql2hiSPxWH8b2qbbY42x7
   kZ96LQPBqDcswqGlfWGf4lJePmeHML2alipVLcn6FhVJenjd/vvt2r0LI
   X3v4ai8A8BLpS/KenLsxGmLUCOdgZ5OmvKScFmlANQucvGzK6fLBrLWW+
   QvqSCGmxjLHjqmElYi48thV+5QB19VknsbPjfAF+7dyQQGjxl1gNSDycd
   0WT9GdR5MNPDjRQW3HNSEWwQAd1MbiinNSKXImrtEn/gK3HOiyNk0XV6d
   FT1qqFD9Z/u+8mZle0mFDYRBqNrPPB1r13lOdtH55kGk0tUPwTWdBWjmv
   Q==;
IronPort-SDR: zE8nL6paKzQEyhUR4L/al16TXp8a9PKF23vpvdvhStPzS2o/WA9IHEjwG6L4s6WT4RnjjOU2aI
 Dtkdg5jpyjSPaOiOnTvaaX7VSDzvJ5ukz0pM+8Lrzzhb1zAa/DEWFYorfs7qLYhrayu4QN9kWE
 AX04TE8Q+hzoRk2Yrj/kYwJGotaBEG6c/hRAFa6iztmH/NwkDyir1v2+Way9QMZYBxDhSR2eHB
 jXYuWAigmq9swmEQgqOsVvdQrZJ0lsT9ES4my8f5wrpVw0zH2LJH3pzIWC9NAp8iFGEetncNwW
 4Wo=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="280621378"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 14:15:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHJC/S2JSOMSjoBqlrlcezlIC5VnM5OOdvVW7CsRApQurmCsCrytp4CiE98HmHZNSNCommhODEfijkCYEwwgQOn3IaDqXZsCepksv+XjoVXUfr/8u5PAsnUKDHCrc9UoiatJS9S4X3lcOkvSKa8vTWW6JwI6snCiT+g6h9aQGGQhjhHjjJZW0P9j8PUXm2e63vh/c8YcV4KAjR9DoHI1HBmvb4xLFDO5Alt3kXCOw4m1rM0SYCBH3zDpw62uPdM851PKHxpUvU9/SVYIXqR/+PYvJ9HYrAZxDaHal2nI3hGWrARrvfBqpn38X7rf4ZX08FmFqvtSyMdabZE1WM7bhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R85ZEi+aLNE5288xgE4Ndu1JlSWBBUbpzFD5EHAdyk=;
 b=oJ2OBHvTm7wKsD111uIZOST/ooMpA1TYHzd34FKrYABUo4A9lgpJHqMunoSbdOMufgpRH2Lps5yaQOyDwh3541FIG3fQlJSn2BOlYyxlA4k8At6gUCoWVIjdt/9+Jyrx8OCJrWxqlOZ3WTRwE0j36GBRPG8OiM+cWX9lutmIl9wUC1heft88Os5jmIyZbS1NOsdx0xv8XnAJDhEKWJyqyhgSIAe8hymURZs5QZxs4wkY2BhnEc4xpz/dFnI5tAx7XOmw6ZU1GYPDBaJ+XO8cbrz6yECGBvbByofllL6tpggtQ7wl74YMM5sLIIV5mwXCnPgBTHRqVGEf4f6nJG6xGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R85ZEi+aLNE5288xgE4Ndu1JlSWBBUbpzFD5EHAdyk=;
 b=B7j+D2nCA0FoApoiZIjLDqC0MOhs66bqT4IeOcO95huvQlh52kn1+RXhKJsDRb6+FLx1qYpXQqmpBANhrhoAbX87qIqzpwJLiXEau7lqL2Eukt+RPz+5la890c+BQTP7l4/DQvevjFoZ6J3KO26wnaS/EvX2wmgII82CnEVh1qk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 SJ0PR04MB7456.namprd04.prod.outlook.com (20.181.254.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27; Tue, 25 May 2021 06:15:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 06:15:53 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 01/11] block: improve handling of all zones reset
 operation
Thread-Topic: [PATCH v4 01/11] block: improve handling of all zones reset
 operation
Thread-Index: AQHXUQ1F6jb1VNqY+kaEwGILkKYOng==
Date:   Tue, 25 May 2021 06:15:53 +0000
Message-ID: <BYAPR04MB496571E36CF14B9647FDD21186259@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
 <20210525022539.119661-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [70.175.137.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0e4a19a-96b7-4c37-0681-08d91f448ce8
x-ms-traffictypediagnostic: SJ0PR04MB7456:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB745669D9E3103C0D836AEF7C86259@SJ0PR04MB7456.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eza9Ygdx0Sv/i7MpKlo2hp233kDPfYKw55D7tyVs8JwpowqQOERKlNlUw9ok3jGD6i9UPbMe/gPjyhIpgZ4kGUKHlHylMZW8kD1CT66hkB4OWHFm+q3ECTZClUtRrLjChcZzjwRz6CqlEZywxvV5Wsv3XpbfZOKuR/yTpiHQivtqPVlTSFoWUh9sVE3L0rzjhEW3Q8z7cM5meg0PTG1bA2j8+Fq6msS+GPCXzTfX3jLab+Bax38syBX6+GTSnr9ddXnPL7RNtx/1ouxv4FsG3vxoYKLnmolyz8V2/3kLVwvxRtDqknva1WD6dRnTb9lm4xFFTyGucEQqudACSzMUY6phLJAVKmqPFmWojxkVJSEgB1kuKeoe88B//gLyADOGY9X4gF04r1CzjRAgw2fgmLzWDNbWAAVsmlm4wKoCTvBjdz6D2wampM4FhC2a68zui0HZGFvqciI70pSgTDfVsE8JvEH5CojXImHgNcgzN0J5RUF4iYoU3dVhSPbaTQpxNqzDNTyHFA5ZUfmGqJ8oqshzYGlpcDXeekTNNaGQ95v48PaDZPUA4Aj1kZGZGHtJ/EA2e/zNmNlx53bN7Jh8zeh646ohDdFqqSSNzyb5Jk4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39850400004)(136003)(366004)(376002)(66476007)(76116006)(66446008)(66946007)(9686003)(8936002)(64756008)(66556008)(71200400001)(86362001)(186003)(478600001)(110136005)(7696005)(6506007)(52536014)(8676002)(5660300002)(122000001)(83380400001)(38100700002)(2906002)(55016002)(26005)(33656002)(53546011)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CCi9eMi55+ucK60Xe6tQIjV7D3Bn55zr2W4J7BdyFYInd1KV7A9kPJcieabV?=
 =?us-ascii?Q?AX5GTmK4Yn4GDxCygV31UKA/h1C5zoXiR3FXK4rB87JnIPM0doTVmxNvUEfG?=
 =?us-ascii?Q?UlwR2S1/dwd4/eMr+BW82wfmNJG4NG+6/Bws8VULPrz+pYYKDYRH5r950sVI?=
 =?us-ascii?Q?HyLP759i1jfSknMdVpmPhUdtyxG2O4UdwYovC7k15tHGN2cp3HK5A8BGfGUZ?=
 =?us-ascii?Q?rS7Lfdvgki/W3YIELguqcoyvH/1/lcMxCOJTrJ2usuClE0E5F0ADE1BjO9no?=
 =?us-ascii?Q?wVa9AL58WZ+zQQ6qQwqTwdf//TPiAXdlmMmewnJUu6f4duJ2MNQb85XMzj14?=
 =?us-ascii?Q?DUvfDuLw+nbA41tez+bad/iqYRXJZZKGhKRIqkP+iRLueAM9LF+U1hkrGyqi?=
 =?us-ascii?Q?BdxQcd7g5egPVwVy8mJ1C0Qr3kTdJI0Kt5Rvb3mGDZ68ysPU4XDMIl/VPKXQ?=
 =?us-ascii?Q?DrWDWlaeinT7X/KvD5TWwJdxKNBwAePlw7+hbf5rJmF+Bd2pJUFca7gtAUjs?=
 =?us-ascii?Q?XUGLxl17VCae19NotRgNYXvGkV9xidmvRSThgjJxbmYtfnmooPgjUw7va/fk?=
 =?us-ascii?Q?u9hmHPP5p2It1cepAs63WWV9uaE7cARXiLMeegjzKoPdUcAycrAnE2xqlUSx?=
 =?us-ascii?Q?QG7uIe9+tW+ug+rKypWCJIH5lujTZVJx/mD5J6WHvDgUR9qIL6r+6P+n3RiF?=
 =?us-ascii?Q?0/3nMay9UKBsxumpLkC5zz980gEVAQYBaAdvZ6Ts2IGfTnL3QU0ttUK/lpEt?=
 =?us-ascii?Q?DDypFSGXF0/u+0/vk6tbfUqKRApCi2aNWNlLgzvTJcWeAD43euMjdYe6FysD?=
 =?us-ascii?Q?QU3o8jmshlEMs3HVaDHPBvBSUc32JQGhG1AKdDYAYTrXEJST67uU9ZhXcL4o?=
 =?us-ascii?Q?f4k3f/Vuo9T3lJ1W498kDPeKZPCq9L5YNOEe2RUfT/H2So47ZGYVUCkY3uZa?=
 =?us-ascii?Q?dn5fDLLoP67QC9u68fM4IBPDeT8bLWSMbRnLeYo/I2UMZ4i2Y+RQYMNpsT1A?=
 =?us-ascii?Q?bCfIwvVtrnxH8U+YyKYTeejXDxFehWa+GFCsreQbsGCPViGYcr9UYg0Y/I9k?=
 =?us-ascii?Q?CHXQkIreK714Y2kiiYYKRfUIpepK3FE/jA2sdEfpI2l+9z0FiiKMZwP6FRG0?=
 =?us-ascii?Q?bfw1qRkmQqCXG9FLmrTbHotO7VUausWCadz215c2INeFB3cdxLvjpFM2dGY4?=
 =?us-ascii?Q?mRDsOr00gp7EYhgZ9VtkM7xh3iQp7ZNI+jLCM11wgXJy4dVMjtW7p0ejTVb1?=
 =?us-ascii?Q?ItYHZwmB08tHS05VXyTWLL5QHk1FpH186avgHwJNY9KyQw0KFhqopa0ZZKk7?=
 =?us-ascii?Q?3jPsBoOY7WJ8duAvCPVeaCm8w52u1HPmeuUn0xken51mAg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e4a19a-96b7-4c37-0681-08d91f448ce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 06:15:53.0200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cu7XPUYRsL2MX8G3JpLimFKVNjIz55bYjJARvXcwwiGVGrneWOp3GmR+8Vd35nTT3sIjMczIegLzdwHfAo20dbxJuySzn+5sKQEpRqSWl9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7456
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/24/21 7:25 PM, Damien Le Moal wrote:=0A=
> SCSI, ZNS and null_blk zoned devices support resetting all zones using=0A=
> a single command (REQ_OP_ZONE_RESET_ALL), as indicated using the device=
=0A=
> request queue flag QUEUE_FLAG_ZONE_RESETALL. This flag is not set for=0A=
> device mapper targets creating zoned devices. In this case, a user=0A=
> request for resetting all zones of a device is processed in=0A=
> blkdev_zone_mgmt() by issuing a REQ_OP_ZONE_RESET operation for each=0A=
> zone of the device. This leads to different behaviors of the=0A=
> BLKRESETZONE ioctl() depending on the target device support for the=0A=
> reset all operation. E.g.=0A=
>=0A=
> blkzone reset /dev/sdX=0A=
>=0A=
> will reset all zones of a SCSI device using a single command that will=0A=
> ignore conventional, read-only or offline zones.=0A=
>=0A=
> But a dm-linear device including conventional, read-only or offline=0A=
> zones cannot be reset in the same manner as some of the single zone=0A=
> reset operations issued by blkdev_zone_mgmt() will fail. E.g.:=0A=
>=0A=
> blkzone reset /dev/dm-Y=0A=
> blkzone: /dev/dm-0: BLKRESETZONE ioctl failed: Remote I/O error=0A=
>=0A=
> To simplify applications and tools development, unify the behavior of=0A=
> the all-zone reset operation by modifying blkdev_zone_mgmt() to not=0A=
> issue a zone reset operation for conventional, read-only and offline=0A=
> zones, thus mimicking what an actual reset-all device command does on a=
=0A=
> device supporting REQ_OP_ZONE_RESET_ALL. This emulation is done using=0A=
> the new function blkdev_zone_reset_all_emulated(). The zones needing a=0A=
> reset are identified using a bitmap that is initialized using a zone=0A=
> report. Since empty zones do not need a reset, also ignore these zones.=
=0A=
> The function blkdev_zone_reset_all() is introduced for block devices=0A=
> natively supporting reset all operations. blkdev_zone_mgmt() is modified=
=0A=
> to call either function to execute an all zone reset request.=0A=
>=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> [hch: split into multiple functions]=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
=0A=
Apart from nit mentioned earlier, looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
