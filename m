Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C69C3DA7C
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 12:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiL3Mlh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 07:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiL3Mlg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 07:41:36 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2738A11A35;
        Fri, 30 Dec 2022 04:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672404095; x=1703940095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SusP9z69L9HKuSxHySgYyZ0hDNgdoTCH/paGdp5ZaXM=;
  b=rNPs/x0NqgyA9sAqc7mChtx8wN53jLAK3NneAzfx1WiRtWjAWLzEaIOL
   TsgSGm6/03PZ9je/jX3gJcLfdKSSUnLHyjZzTyS5pSXv9nkEOH4pWmLnk
   8JfIYQCynu3DZQC8be6TZBJyiHh0hJTPR8+AU5ezAh0idT4tg1igS8G84
   FCQT4Mq63xXsrdhMcT81vIKvGStzcAkq9Wu8y3csel2ZG/AFhFVtC0gNt
   PT9weQV9Xdcu2sgvErOx68op8G3VB/aGHmHxOBgcWVYxWkPtNEYglWEN3
   ghl+Dl+hkWMCFsmRMSQSRVyT8nDa/o6YHofSWa1Vh18b3b4dVqB2jjiM+
   A==;
X-IronPort-AV: E=Sophos;i="5.96,287,1665417600"; 
   d="scan'208";a="224813877"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 20:41:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HL+a2ymd9QDuU/Tc3zD/ZCEDO+K2SQSTlOdvxgi0E/hiNw/VGIvziDN0Vfw19wSbN6Ui+y6xqGMHxN1gy4qryJA9AYdwroLLe0opEN5djs30GX6N+ahN85T//x90/JiRAwepyVl81HSLowMtbBYUjGZ+cDj+Um1eFztCsuFgMyczsqgrRdh5cCz4b2Xw8XiY+o0e6xm8dpxmvbDOhWkDsRT/59QXS0PF83HgsW5ZyyVGj9Nq3zo2mrzx9vZJaSqYPtF0aMX08J2DYjmZCPHg0/Bp0io4nN4afu4HY0p4xv8ctj53YoEp18a3bYhCiCGIgdg14O3F06Xp/7r1f/9STQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EYmjcabuqd9LjEjUF1aosEyHrCsVbqM7BSeWHQOcnc=;
 b=eWlNzxyLJMDxW4nS2wB+XIOiMFwbvFSmmB0H4dROwB9jQ+0GSdbcpAM37wncAr3uaZTXJZPOOwZ2kt/ZC2O+xsiBTJxIQPIdwEGaTTzFDeMdwE5KbU2Lvl18iGOqxj36hSTBIfdXQs/irhQ21moEbO7bhnZwUnkSZLOTYYn2Ct/m10CRACFVQO7QoBi3ttGqFKAAkko/Ea0FSjvvBt03x8QOVKXUvw8STcBKT5ejM+H4vCxfDSv7P1rj3+qBs9TBvMQHm0zoce2ChbYLAYASYSxseZfhuGPjw55E1q8vP4dua1yd6uQXFx0ARGPNmhNitnYZSo+IXr3x3PqfcTJYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EYmjcabuqd9LjEjUF1aosEyHrCsVbqM7BSeWHQOcnc=;
 b=TnvYFlgMbr1PrUWojI9jC5E1PI/LxVYJdRKkzvvjerCu1DrhG14xFOaHKh3XWYSSoUVK6qNL1Idr/JAbA/Obmt3Mx2uLZBITmO740RtY1KJPPKK4cIJssqFBrb3Ca5KfJVUCmgWP3XqfrDQEraU/vu4YVaZ8iaeCyOlm7QkdcCE=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6296.namprd04.prod.outlook.com (2603:10b6:a03:1e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.15; Fri, 30 Dec
 2022 12:41:29 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 12:41:29 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 7/7] ata: libata: Enable fua support by default
Thread-Topic: [PATCH v6 7/7] ata: libata: Enable fua support by default
Thread-Index: AQHZHD0aq7+4wKWoQkiyzEvhMhy44q6GSWKAgAAWNIA=
Date:   Fri, 30 Dec 2022 12:41:29 +0000
Message-ID: <Y67cdx1h0QMb0brO@x1-carbon>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-8-damien.lemoal@opensource.wdc.com>
 <Y67DaUBSFBU9xoIU@x1-carbon>
 <602e37be-38fa-0143-a6fe-010aa74197d8@opensource.wdc.com>
In-Reply-To: <602e37be-38fa-0143-a6fe-010aa74197d8@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6296:EE_
x-ms-office365-filtering-correlation-id: 1489eacb-ef91-4c36-9cde-08daea632c79
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 98NGf4UrN0rDlacZfEgjfNxT9B/imXVRtopSamCBbH5hPfPlbwtDFrH9iKfj/Ua2ff8xXVvVV2wF+yVdzH2W0lOA4/ZYvoIo9Rvds2iQFzlZ+Tb+59UqZ4qqi651noykyQ1ymB4aCW1qPb2jOLfVDXWzmYzRJY6kxxbNgzdyJuFMh/5/aZIFRDDtHro7/cjs9Wf2LbU5bZF5fgLImfYSDFb7d2FrOSTvGdNhV/X9twKmmA/PHEjtsbDNOetHlGUfnBpex85aXZeZSAMaEv4tEXWAqjrcx9Kn+33svXeDqSYnpqg7cIA1XGChLXqp2AxJXVs7SV6Kv+i1e28rTgKiJIb7zIG8Nkp/r+IYR2bzva/rUuD04ffMVnf0wDzNKSIDpg1HdTeCjjR/acdMkAsGvHI0TWpnjlm0L/MR3SZtA0S/9AWUgipkU7JCyxfueFppAnzq53c3xzU3Mov5/ypYgYaCaYxrp6G9+vtoDtCSypJzSUQctRE0lYpUmFCg7jHqS1GlckjKHD5TjqYBYyZC08C/qP1EAlZfeVBRVm8jTg9w31MhRIeXr0vH0sNIsun/PLfKxwJtaepc4CpLwPYNU//20mAkDrAi0nOPXz/XXkpJULc2ijckMlO+uhzA3wW1MM5nNu5NZ9Ct+rr8BkN1PZ/C+2HBUgW6LRSjzJUZyOdKh4W+Usoq3Fh1CAVhHMoQgZKH6Ora6Q6FfhgZo2362Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(6862004)(66946007)(2906002)(122000001)(8936002)(5660300002)(82960400001)(41300700001)(38100700002)(86362001)(83380400001)(316002)(54906003)(71200400001)(38070700005)(66556008)(66446008)(66476007)(64756008)(478600001)(91956017)(6506007)(76116006)(9686003)(4326008)(6512007)(26005)(53546011)(8676002)(186003)(33716001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mE1vHt/USsGKNuG43DjhuuCdL2F1JBEqMj0u4Qtt3udNIDEWvgHxRWUT+pEQ?=
 =?us-ascii?Q?LOItA8utCcj1dztNapnyJjULN+EIjFLEqKW/NlVpLyiNjHCYz4P+2EQjqzmc?=
 =?us-ascii?Q?UV/J0bZpn2crbx7FcIRXG86QR+3fwLo1QRf7VVuGlJ/rlveG5z1UCwcb0TPx?=
 =?us-ascii?Q?RHWZd4dv8IAG8hO7/TY30Sv5PbVJdBtV+wANBQp7FmG8iCwJBe/xoALFkc10?=
 =?us-ascii?Q?5g9bLVNLmMAKvnOIHmJJuQ8b2Pnq4h8ZorXPu9kecz7c6/3JUIenP0qTyQXX?=
 =?us-ascii?Q?L3dq/UtE9sw9xQJ3huYR8jwpOCLJTWr+zjAIxviDNeg7bV7MQs46RXmuGu5W?=
 =?us-ascii?Q?TwvtWBd8KKCDhlixFEEnMm9h4Q+5AJZp8Bx+4PmCjeSqf/Ha0b4HlxQVQjv+?=
 =?us-ascii?Q?iFo97KGFr5YjYGowCGSnRbuYO/Ig8x7EbcQKH4HTbpeGFUdm58/Rj1lsyTVA?=
 =?us-ascii?Q?vu/Q/p+CBSIBQh1AwyuIb2LqFlkLpCi/WIc0X+CuJaW67OA4nXUIGjPc2PuZ?=
 =?us-ascii?Q?8oHutPJgzsQd57oQksl7s5hcRgPbskc40v2pp1uT2whI1DXMDietLsLHYEqX?=
 =?us-ascii?Q?MYY7p3h7dLz6h2jhe9WpZzyNFh4IXResLprUVANVmdIT0TCBw4teGCxv6vPm?=
 =?us-ascii?Q?w5/1JDsJ9zhCq6R+eShK/6n7apNNa1oczltk053lDqkVaW2hePDAt8RuHyQZ?=
 =?us-ascii?Q?YcIvk+nHPCaOf+EF8TEYW43rItIRl9nDjyMaRPYi4DLp4XiE5uA3RzakBt+H?=
 =?us-ascii?Q?B3NUMoBUdtBCVj/aMa7dsrervK3OL9o0jX6HV0ZnX4J56M1RjvT5pET1RG0K?=
 =?us-ascii?Q?gxqhrptb1Yajz7Hj3r2iFoilpdgPbfBPwE0br19JlbgBoOiOB/3+RV+c+Tk9?=
 =?us-ascii?Q?5TnthNoI0gkG2SzLFjdlk/WuujAcH6mZftiFXDfS88wpERHLw7Ma+X35bI5E?=
 =?us-ascii?Q?K3R+uhuLfoPCIVyVHfjR8lAfqgrFCoMy1AP3kFFpmgzS4etPS8BxqLBpdz0u?=
 =?us-ascii?Q?2TDbNfKLG2t16nsob4As2RcuKBZIZ+SuTLvJrDe7UJrMPKfzPjajqNHVq1gv?=
 =?us-ascii?Q?teBKj8dDg5I3yFJ5xIIVUih4BewD1vynYMPfAkWOsJWiq3ZJBDqdAi9gSsYd?=
 =?us-ascii?Q?YO5q/33RRpLOpMNYoFE5CqhKRBf3ehQNLNQLTChtx5rSt8mzoaIvjhyf9Ihx?=
 =?us-ascii?Q?o2WUchD6HRVjJJdIySIuD1k5fIXUYMlvWECvsGLYorW5nmwWVn4q0Ou4G2PI?=
 =?us-ascii?Q?QoRIPoXo/nmJYkYc4rAetqGg7588ee0qCyU15FX6bgxpeav/O6ZefGQpNXs9?=
 =?us-ascii?Q?QrcYqiA8n8MoGE0TCVe+bKIosCMWWV2RgY/EkAXReQZvx0PxEbNTvOVF8Hr0?=
 =?us-ascii?Q?/NH2nAq1D/mERRPplTOJEW/JmTPBh5M60uUojUye4IMvEZ7G2+N1I8SbLIwn?=
 =?us-ascii?Q?AEVTyrQqFGiK4/svok7+xju4xD3S+bnqZtxBNTKa+l+CCSFkNYtT/fQgNUYy?=
 =?us-ascii?Q?tr9ZMPtFJjMyzDoK2q1YXx+KTm6ZUE5S0N/dbuX/taPPpacC8Hze2UNiYfd1?=
 =?us-ascii?Q?sZf2T8Z4jXAJK4bnGw+ACfjPXUaQWmZGmge4ts9lXdNnBKD1vG70vLEahAA+?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <297B0FF788397C4EB12FA7E251DB271A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1489eacb-ef91-4c36-9cde-08daea632c79
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 12:41:29.4863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8t+GCHpVr0mCprHz+8LELgtyrn/nQFPYPEFFNj2gSRZG2Vc200tXDoHjglEvYzcLgJQr64Ec+TA0luDG6weww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6296
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 30, 2022 at 08:21:59PM +0900, Damien Le Moal wrote:
> On 12/30/22 19:54, Niklas Cassel wrote:
> >
> > Perhaps this commit should more clearly say that this commit only affec=
ts
> > the simulated output for a SCSI mode sense command?
> >
> > Currently, the commit message is a bit misleading, since it makes the
> > reader think that a SCSI write command with the FUA bit was not propaga=
ted
> > to the device before this commit, which AFAICT, is not true.
>
> It was not with the default libata.fua =3D 0, since the drive would never=
 be
> exposed as having FUA support. See ata_dev_supports_fua() and its test fo=
r
> "!libata_fua" and how that function was used in ata_scsiop_mode_sense().

I see, drivers/scsi/sd.c does a SCSI mode sense to check if FUA is reported
as being supported, and then calls the block layer setter for this.

So changing the simulated SCSI cmd output is sufficient to tell the block
layer that it can send FUA requests to us.

>
> The confusing thing here is that indeed there is no code preventing
> propagating FUA bit to the device in libata-core/libata-scsi for any
> REQ_FUA request. But the fact that devices would never report FUA support
> means that the block layer would never issue a request with REQ_FUA set.

Well, ata_scsi_rw_xlat() is used both for passthrough commands and commands
issued by the block layer.

Just like how ata_scsiop_mode_sense() will be called regardless if it was a
passthrough command or a command issued by the block layer.

ata_scsiop_mode_sense() will not behave differently if it was a command
issued by the block layer or if it was e.g. a SG command.

I would argue that it makes sense (pun intended) for ata_scsi_rw_xlat() to
also behave the same, regardless if it was a command issued by the block
layer of if it was e.g. a SG command, but I will leave that to you to decid=
e.


> That would be possible for passthrough commands only. What is going to
> happen is that we'll now get an error for that write if the drive does no=
t
> support NCQ or has NCQ disabled.

Why would it give an error on a drive that has NCQ disabled?

Your new code looks like this:

static void ata_dev_config_fua(struct ata_device *dev)
{
	/* Ignore FUA support if its use is disabled globally */
	if (!libata_fua)
		goto nofua;

	/* Ignore devices without support for WRITE DMA FUA EXT */
	if (!(dev->flags & ATA_DFLAG_LBA48) || !ata_id_has_fua(dev->id))
		goto nofua;

	/* Ignore known bad devices and devices that lack NCQ support */
	if (!ata_ncq_supported(dev) || (dev->horkage & ATA_HORKAGE_NO_FUA))
		goto nofua;

	dev->flags |=3D ATA_DFLAG_FUA;

	return;

nofua:
	dev->flags &=3D ~ATA_DFLAG_FUA;
}

So it should only give an error for a drive where NCQ is not supported.
If NCQ is supported, but disabled, you will still send a ATA_CMD_WRITE_FUA_=
EXT
command.


Kind regards,
Niklas=
