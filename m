Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D54ECDE27
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 07:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBF8222BD
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 07:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ojBdiRO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfIKHXv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:23:51 -0400
Received: from mail-eopbgr1410121.outbound.protection.outlook.com ([40.107.141.121]:22461
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbfIKHXu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 03:23:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuvFegNqBjTU1ZadRuJzk9fSpq+bwGGh6XwHHt4agV89EQLff1ehsW2wgJEu6zzSgyCcssCEedQDV078nCyIX6uvHymYqUV+1Ea/5FSXIhhSKJZkKSQjWre7JFvMhBFRpQFSBNxC82d45aSBYGNW01aTOqUvfQBA4Aez4G2u65JLf+Zl1dQhfTBPXdvaP6vrMsutu0kqGEEcmnxI3z3vVnU4jKxDgibZvZ6sZ56umxsr5MA92NawdsCZw5tMTAc43ZWoaz60f9g3aVKhqC7eZNdwPy9D7GHAnWu2d46iUw176KnoCR9sU1fJVGYJjIt41dme1iWjBP/Rr+r58NVdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9rrtJxSyuFyKevYmcbOIGzqqXjWAfoKjreWjyFQlug=;
 b=b/f6tdIWgeInV5Ail4dOBw4K2jSOKXctwUD5zL6fVU8KQHCoPOfD+5cUzwopEVn4WNkeMMnz/9ymwpMrh2R1Ef9sjuAI7XG+sFYfwQF2bgrg+vknS4gRmScwACdfJb2t7mt5XGDlxroZQfTbPcQyLT17Uk+9OLrpXgyASbso6WLqBBP+EW38YyS8UuN91Eg0kBbC+DspDd9S7UV1UQ0T6VABDMccxUY3tmuKj3ZYf7XmB0Raxu32L/IWiivGlR2D24LuXNCEa0Pq8+QkNeWD2K20/+xd9odAmF3p8e2MHBu6ppV+Gg8K0accNp3eLnIRZgWwq5t3xh0d6u1MWLOzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9rrtJxSyuFyKevYmcbOIGzqqXjWAfoKjreWjyFQlug=;
 b=ojBdiRO65KKj0ZWPvTJsVzQx0cTTmmDEvTY1fCojePTbYLdnH6aOqSwYoZ1YUyO943wd1zUqJmygScxjWqhx1KWf4jzovAvXroRUptgbmESPY4pQ/x8bLti3PNj7cUvTMuei9dk407C2cma1EQtSU65D8gtEb+C2lqRHRGlXFNY=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4221.jpnprd01.prod.outlook.com (20.178.140.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Wed, 11 Sep 2019 07:23:44 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::7da1:bfc1:6c7f:8977]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::7da1:bfc1:6c7f:8977%7]) with mapi id 15.20.2241.018; Wed, 11 Sep 2019
 07:23:44 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: RE: [PATCH 1/3] block: Respect the device's maximum segment size
Thread-Topic: [PATCH 1/3] block: Respect the device's maximum segment size
Thread-Index: AQHVZw4VWMEEraTQbECBt67bhcbO/KcjhO+AgAAz34CAAG4C4IAAXlUAgAGGJkA=
Date:   Wed, 11 Sep 2019 07:23:43 +0000
Message-ID: <TYAPR01MB45440EA8EA26C4A476FC3847D8B10@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20190909125658.30559-1-thierry.reding@gmail.com>
 <20190909125658.30559-2-thierry.reding@gmail.com>
 <20190909161331.GA19650@lst.de> <20190909191911.GC23804@mithrandir>
 <TYAPR01MB454470364B682B9BF708E557D8B60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <20190910073032.GA12537@ulmo>
In-Reply-To: <20190910073032.GA12537@ulmo>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b06a7653-0ebd-4ac0-00ad-08d73688fa81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB4221;
x-ms-traffictypediagnostic: TYAPR01MB4221:
x-microsoft-antispam-prvs: <TYAPR01MB422174ABB4F1BE9BC8AA88D1D8B10@TYAPR01MB4221.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(51444003)(52314003)(5660300002)(6436002)(7696005)(66066001)(7416002)(486006)(33656002)(71190400001)(229853002)(478600001)(71200400001)(11346002)(26005)(186003)(6116002)(476003)(52536014)(6916009)(256004)(102836004)(99286004)(316002)(14454004)(25786009)(2906002)(446003)(6506007)(76176011)(54906003)(561944003)(55016002)(14444005)(6246003)(9686003)(7736002)(305945005)(66556008)(66476007)(76116006)(8676002)(8936002)(4326008)(74316002)(3846002)(64756008)(66446008)(81156014)(81166006)(53936002)(66946007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4221;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vE6OrYW5gNrJsj3ccOeQqs/OR3Ie/HcZG0gnJc6OEfmk3ODPjCkHa2qIcyq5xZd61lGrEPCYrt2EqYNQ42DYhGoMQVs08dhRt+6cMfrf41HbwrI5oSjrtZ5KQm0Z94RGKjC2NgdFmuq5Uo6K+tTjEq06zU7+Q2hpouEBHpBX6CZwjDhOauTQACrD/kS5wWkaEKVNZVh4cY62wkCx81OxtNnYdFAmX6jBiZYsLHxC5HoCZTM/RdBV7JyP+WbNBucDCaP4QOY4XhMBdcFLG6FsaaT3M/g0UCuHZOMRr4/IrucoZrB2pGkFW+H2MgrIKjClNG9XbF056QsCxNMGdipYPriv2GUYSWCm3cYxEZABZ1fgAH7w3NTXvSJV49lZx6QVUNDc6CFpKkcXxCJbOMd0Tw63GDTtQZydxRWNxku7zdY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06a7653-0ebd-4ac0-00ad-08d73688fa81
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 07:23:44.0366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycSu61vJlnGP3fXyOHt02a3ezgzwVkY5gGTFnR6W/33i++7v+I/hJHY2C9zZXzsK5IF3h/j0RsXdUVpHXCWAEPklV7+4KrwnGNtbXPlbeJj59CdgOlVqxfQBc74S8jHM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4221
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Thierry,

> From: Thierry Reding, Sent: Tuesday, September 10, 2019 4:31 PM
<snip>
> On Tue, Sep 10, 2019 at 02:03:17AM +0000, Yoshihiro Shimoda wrote:
> > Hi Thierry,
> >
> > > From: Thierry Reding, Sent: Tuesday, September 10, 2019 4:19 AM
> > >
> > > On Mon, Sep 09, 2019 at 06:13:31PM +0200, Christoph Hellwig wrote:
> > > > On Mon, Sep 09, 2019 at 02:56:56PM +0200, Thierry Reding wrote:
> > > > > From: Thierry Reding <treding@nvidia.com>
> > > > >
> > > > > When enabling the DMA map merging capability for a queue, ensure =
that
> > > > > the maximum segment size does not exceed the device's limit.
> > > >
> > > > We can't do that unfortunately.  If we use the virt_boundary settin=
g
> > > > we do aggressive merges that there is no accounting for.  So we can=
't
> > > > limit the segment size.
> > >
> > > But that's kind of the point here. My understanding is that the maxim=
um
> > > segment size in the device's DMA parameters defines the maximum size =
of
> > > the segment that the device can handle.
> > >
> > > In the particular case that I'm trying to fix, according to the SDHCI
> > > specification, these devices can handle segments that are a maximum o=
f
> > > 64 KiB in size. If we allow that segment size to be exceeded, the dev=
ice
> > > will no longer be able to handle them.
> > >
> > > > And at least for the case how devices usually do the addressing
> > > > (page based on not sgl based) that needs the virt_boundary there is=
n't
> > > > really any concept like a segment anyway.
> > >
> > > I do understand that aspect of it. However, devices that do the
> > > addressing this way, wouldn't they want to set the maximum segment si=
ze
> > > to something large (like UINT_MAX, which many users that don't have t=
he
> > > concept of a segment already do)?
> > >
> > > If you disagree, do you have any alternative proposals other than
> > > reverting the offending patch? linux-next is currently broken on all
> > > systems where the SDHCI controller is behind an IOMMU.
> >
> > I'm sorry for causing this trouble on your environment. I have a propos=
al to
> > resolve this issue. The mmc_host struct will have a new caps2 flag
> > like MMC_CAP2_MERGE_CAPABLE and add a condition into the queue.c like b=
elow.
> >
> > +	if (host->caps2 & MMC_CAP2_MERGE_CAPABLE &&
> > +	    host->max_segs < MMC_DMA_MAP_MERGE_SEGMENTS &&
> > 	    dma_get_merge_boundary(mmc_dev(host)))
> > 		host->can_dma_map_merge =3D 1;
> > 	else
> > 		host->can_dma_map_merge =3D 0;
> >
> > After that, all mmc controllers disable the feature as default, and if =
a mmc
> > controller has such capable, the host driver should set the flag.
> > Ulf, is such a patch acceptable for v5.4-rcN? Anyway, I'll submit such =
a patch later.
>=20
> I'm sure that would work, but I think that's missing the point. It's not
> that the setup isn't capable of merging at all. It just can't deal with
> segments that are too large.

IIUC, since SDHCI has a strictly 64 KiB limitation on each segment,
the controller cannot handle the following example 1 case on the plain next=
-20190904.

For example 1:
 - Original scatter lists are 4 segments:
  sg[0]: .dma_address =3D 0x12340000, .length =3D 65536,
  sg[1]: .dma_address =3D 0x12350000, .length =3D 65536,
  sg[2]: .dma_address =3D 0x12360000, .length =3D 65536,
  sg[3]: .dma_address =3D 0x12370000, .length =3D 65536,

 - Merging the above segments will be a segment:
  sg[0]: .dma_address =3D 0x12340000, .length =3D 262144,

> While I was debugging this, I was frequently seeing cases where the SG
> was on the order of 40 entries initially and after dma_map_sg() it was
> reduced to just 4 or 5.

If each segment size is small, it can merge them.

For example 2:
 - Original scatter lists are 4 segments:
  sg[0]: .dma_address =3D 0x12340000, .length =3D 4096,
  sg[1]: .dma_address =3D 0x12341000, .length =3D 4096,
  sg[2]: .dma_address =3D 0x12342000, .length =3D 4096,
  sg[3]: .dma_address =3D 0x12343000, .length =3D 4096,

 - Merging the above segments will be a segment:
  sg[0]: .dma_address =3D 0x12340000, .length =3D 16384,

> So I think merging is still really useful if a setup supports it via an
> IOMMU. I'm just not sure I see why we can't make the code respect what-
> ever the maximum segment size that the driver may have configured. That
> seems like it should allow us to get the best of both worlds.

I agree about merging is useful for the case of the "example 2".

By the way, I checked dma-iommu.c ,and then I found the __finalise_sg() has
a condition "seg_mask" that is from dma_get_seg_boundary(). So, I'm guessin=
g
if the sdhci.c calls dma_set_seg_boundary() with 0x0000ffff, the issue disa=
ppears.
This is because the dma-iommu.c will not merge the segments even if the cas=
e of
example 1. What do you think?

Best regards,
Yoshihiro Shimoda

> Thierry
