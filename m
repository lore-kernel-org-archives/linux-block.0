Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33086C4740A
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 02:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5C3218DE
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 02:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ISVXBTQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389256AbfIJCEC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 22:04:02 -0400
Received: from mail-eopbgr1400097.outbound.protection.outlook.com ([40.107.140.97]:24463
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726470AbfIJCEC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Sep 2019 22:04:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRZq7+l1d1JkSUWpQMY4Jyt+tLLH9O1yBkmW+5uIqfhSg3gY70wLFlM1IoAZ4EWKpxHWNF5N6opk8R3Bdy0e3vmAyZuvrVbavM4egyqdmx9NhuCIyWpecUYWR6uDxk+EjV+byPxTBdxMNHkd20B2VH6jgfzBwt2vv22WTXBlGS7teJtoeRdPCkIo/a2roTbJdg0eKtR8uIXL956y4madd7ZGPQk82WXzX22f5wVQcxwM7g81VJvprAEVG7lzoRgRwhtmNh0JSjXmdZulRqIYkq/LwvKa71D31+s8QGK2rTfT7G8RWpAQvmHp2jmjWN4lAfRsw4VkFyjUdMqMHBnE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78D4q5J2b8GVtoAdqKz97HLt0Juo2jSBQ+C5WlQ+Aw8=;
 b=LMYm0ns+F1/DS5mB/BZ0PXh81rH5VElH9QSqM2mxZPn4ise8FhFd+HZ29iJWTiBv2YVVpvLbfrsg+EOFXQyDCibIQ5qKYVC5C7WQa/LoxyLpsVpt77GPtAClVDjfs6oGHDnGPYmg2hE3anMFJSuRLPPlEElh2B4QCd3VPlYlJg/hW8/Xgc5hcbWZ6P3c+rcmp6pW89Z9ayjgpWG1U/e2u/wCCM3dxCVMsYOrBq15d99nuhdTPLp8sQkzMNSCSb8Q9j0Jaiy10MD/z1HWU27WU/1t4WmBRcU6IqaOEFWDSPaJnJNttxmyUZGWFonlTE/fBYsOPzNT/ia/zQ8WazUP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78D4q5J2b8GVtoAdqKz97HLt0Juo2jSBQ+C5WlQ+Aw8=;
 b=ISVXBTQLN2C2qt7JvJr69Zy45o5K00QrStd8GJobGS3FVNA/5yNS3Mj+8Vdyx+EWcYpUgbdNSegpw/Um0Vlw8LRGbuNGl/HMKiflpbrLqRD+8HN6bgmfUKjDIKIx8ohkaLbw9YIBtYN+hD1ZMhtB2FNzNU+DX/QZbRkGVWD+25g=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2527.jpnprd01.prod.outlook.com (20.177.102.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.17; Tue, 10 Sep 2019 02:03:17 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::7da1:bfc1:6c7f:8977]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::7da1:bfc1:6c7f:8977%7]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 02:03:17 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: RE: [PATCH 1/3] block: Respect the device's maximum segment size
Thread-Topic: [PATCH 1/3] block: Respect the device's maximum segment size
Thread-Index: AQHVZw4VWMEEraTQbECBt67bhcbO/KcjhO+AgAAz34CAAG4C4A==
Date:   Tue, 10 Sep 2019 02:03:17 +0000
Message-ID: <TYAPR01MB454470364B682B9BF708E557D8B60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20190909125658.30559-1-thierry.reding@gmail.com>
 <20190909125658.30559-2-thierry.reding@gmail.com>
 <20190909161331.GA19650@lst.de> <20190909191911.GC23804@mithrandir>
In-Reply-To: <20190909191911.GC23804@mithrandir>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07419aa2-d5aa-4f7a-299e-08d735930be6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB2527;
x-ms-traffictypediagnostic: TYAPR01MB2527:
x-microsoft-antispam-prvs: <TYAPR01MB2527ECA10459280664158E7ED8B60@TYAPR01MB2527.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(199004)(189003)(52314003)(7736002)(2906002)(66066001)(6116002)(71200400001)(71190400001)(3846002)(8676002)(81156014)(7696005)(86362001)(5660300002)(8936002)(52536014)(81166006)(478600001)(66946007)(99286004)(54906003)(110136005)(74316002)(76116006)(316002)(66556008)(66476007)(561944003)(66446008)(64756008)(305945005)(186003)(256004)(14444005)(7416002)(4326008)(102836004)(229853002)(6436002)(25786009)(26005)(76176011)(6246003)(6506007)(11346002)(9686003)(446003)(55016002)(33656002)(476003)(486006)(14454004)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2527;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F4GHTnrWmyhyuOEQiADITToaFZuyK99XxsVj5rGbYUE07HnuX9p/hGqsniZk53y/7ol+/0fmxcqD0TrR1gF3kXBg2XXYDqQTn8u1BYz4LNKdOCPGbaWanRwrtWYwu4rHr2NvXbB5IWS+/B4FmLDyGwJIS1sp5yUEu4jlQ8lptyuy8WNBJfCEXIQ+Y5OYZp+26xo6YAxzP3Y0v8lGebtrgkKtLn0/d71lHb0kX7gPKeygtLu0q6EmNCIjla4wdI4B75KpAZLGYgnXnHiupTrpHd3aSCRiCYVkRK8ECnFTDetoJ4Ai1fMU/Q2UvZ/RgwUDJGh4nMtf0kwhI6ddoRhDBnHkyipQM8ePCErstpFSeurS9E/6n4YJmHMc+GFY+V/v00B6wjl5l1hVNHm7yp2/PrtyCEUmLQeryQKhS0SySw8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07419aa2-d5aa-4f7a-299e-08d735930be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 02:03:17.0233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGIEYtPqDXFjFswAS9NCsimrpLlbfRJu4znfIxlTq7iZ30WwagGGz9f6S5KNwS2glp/FdLjk/eIcEO+ynEikQHGxodPUWeKcaGlU/9aq0RZSNgkOnQReZp7X1eUvV+Ei
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2527
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Thierry,

> From: Thierry Reding, Sent: Tuesday, September 10, 2019 4:19 AM
>=20
> On Mon, Sep 09, 2019 at 06:13:31PM +0200, Christoph Hellwig wrote:
> > On Mon, Sep 09, 2019 at 02:56:56PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > When enabling the DMA map merging capability for a queue, ensure that
> > > the maximum segment size does not exceed the device's limit.
> >
> > We can't do that unfortunately.  If we use the virt_boundary setting
> > we do aggressive merges that there is no accounting for.  So we can't
> > limit the segment size.
>=20
> But that's kind of the point here. My understanding is that the maximum
> segment size in the device's DMA parameters defines the maximum size of
> the segment that the device can handle.
>=20
> In the particular case that I'm trying to fix, according to the SDHCI
> specification, these devices can handle segments that are a maximum of
> 64 KiB in size. If we allow that segment size to be exceeded, the device
> will no longer be able to handle them.
>=20
> > And at least for the case how devices usually do the addressing
> > (page based on not sgl based) that needs the virt_boundary there isn't
> > really any concept like a segment anyway.
>=20
> I do understand that aspect of it. However, devices that do the
> addressing this way, wouldn't they want to set the maximum segment size
> to something large (like UINT_MAX, which many users that don't have the
> concept of a segment already do)?
>=20
> If you disagree, do you have any alternative proposals other than
> reverting the offending patch? linux-next is currently broken on all
> systems where the SDHCI controller is behind an IOMMU.

I'm sorry for causing this trouble on your environment. I have a proposal t=
o
resolve this issue. The mmc_host struct will have a new caps2 flag
like MMC_CAP2_MERGE_CAPABLE and add a condition into the queue.c like below=
.

+	if (host->caps2 & MMC_CAP2_MERGE_CAPABLE &&
+	    host->max_segs < MMC_DMA_MAP_MERGE_SEGMENTS &&
	    dma_get_merge_boundary(mmc_dev(host)))
		host->can_dma_map_merge =3D 1;
	else
		host->can_dma_map_merge =3D 0;

After that, all mmc controllers disable the feature as default, and if a mm=
c
controller has such capable, the host driver should set the flag.
Ulf, is such a patch acceptable for v5.4-rcN? Anyway, I'll submit such a pa=
tch later.

Best regards,
Yoshihiro Shimoda

> Thierry

