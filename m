Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E4C352AB
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 09:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65500217D7
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 09:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ItwrcujW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfI0JFD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:05:03 -0400
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:18755
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbfI0JFD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 05:05:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEIUi/0U9nGMZbJwvAYIpciya+0dSmjFg3vvC7kJODZEHM3/FlZ8O3BW1tgh2Ju9v/5mzzI/BmoyFXPGQituw1Y0uVbLh6l4VvJXNX6aee9hj4LLofysqK9EBWs/xW7cxOGLp7Hbph+QmCsP8Gzf0bv6swvzgLEgDdJ3fLjXFkm6A8L5rOjnRAa606K95OsYdv9iSaZkF8mqyfcmO01DA8QD9DpmFKUHHeCggZL1J7VK1oHH5+GvneNhEnQ2deXSkZlT04M6U9ZOtm9iSbj0ACHPMuTAObTCZhPwN4mgJS8PIU89biNt6akztJTgoBxS3aElhC8cm87LVXdX8q/Tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FLRDgjQ+L8j4jUJD715qF3l+SAWnSefZFtKBCqwK1c=;
 b=aV5AGRKr3PnaPbXWfMAaDkoFKszGbYWqZwZJN2dyfVE/bj4u3ZcacKAlzbOtY/Yotswc4ZDUBDwmPBSDzJTq9I6iHtSlA0LSKH28g5KSxyG/ocxZseInVwAOeZI/x/z8fIYeA2JB1cQVSQ8BbYFcPqcOeydvRUhRiw5BLA0/MU9dWSUZlqfG21/2xuV1ZZV3ntB69P7L+9qnFQR/FtY3q2REhjjPhKRMC0HOdnzjnfZWMJKKB8EYLcc5TMJuZpDJjLAB9KF5WOHtYhmPX6eP+jd1SxrFIO6cakF6VDUFg3Yj9bO3UvtughauTiZjUaJiV+oH8ml4kGO1LNAgHNdRfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FLRDgjQ+L8j4jUJD715qF3l+SAWnSefZFtKBCqwK1c=;
 b=ItwrcujWYvYKrrbhKcurd30DHCNaANuetThYVVJohELV2shiCyeyBnzEqD7usgB3fQzOLc8hcpuq7bhZbrET3Q9QQ10oUbb1li1aHt5AarVgPixMn0yOqCrXVfT6YlX+mh11AGq/32TKypC7y2fEMB+K2D0ElyJ5oHHZIJRDqZM=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB4304.eurprd04.prod.outlook.com (52.134.31.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Fri, 27 Sep 2019 09:04:19 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::744a:c78e:b8:633a]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::744a:c78e:b8:633a%7]) with mapi id 15.20.2284.023; Fri, 27 Sep 2019
 09:04:19 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: reeze while write on external usb 3.0 hard disk [Bug 204095]
Thread-Topic: reeze while write on external usb 3.0 hard disk [Bug 204095]
Thread-Index: AQHVVOKTn0FJLyYmMEO6xr/XJ+YAlKcChwmAgAEfggCAAJrEAIAJfxWAgC8dUYCAABeMAIAChrqA
Date:   Fri, 27 Sep 2019 09:04:19 +0000
Message-ID: <20190927090640.GB2609@b29397-desktop>
References: <20190925170741.GA5235@lazy.lzy>
 <Pine.LNX.4.44L0.1909251429370.4444-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909251429370.4444-100000@netrider.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a746f9d-fb12-416a-6556-08d74329ae8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4304;
x-ms-traffictypediagnostic: VI1PR04MB4304:
x-microsoft-antispam-prvs: <VI1PR04MB4304371DDCCF3DB78A78DA528B810@VI1PR04MB4304.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(376002)(396003)(136003)(39860400002)(366004)(199004)(53754006)(189003)(81156014)(44832011)(99286004)(66556008)(66476007)(446003)(186003)(33716001)(6116002)(91956017)(486006)(76116006)(6512007)(66066001)(4326008)(305945005)(6486002)(3846002)(2906002)(66446008)(66946007)(5660300002)(8676002)(86362001)(25786009)(14444005)(11346002)(256004)(6246003)(2171002)(478600001)(7736002)(1076003)(64756008)(6436002)(229853002)(14454004)(9686003)(81166006)(102836004)(53546011)(33656002)(76176011)(6506007)(71190400001)(6916009)(316002)(476003)(8936002)(71200400001)(26005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4304;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U3hkgkhEs7ZduIpzU9NtVkOye+s2KLUvsqM3DeIqD7H34UUF/FsU3J/MlCpQJjWk7P/oFmlpefVqWB3/PJH4pxfUfHwYVDzwkxkD1JVJKaBWViFWdsc3RKKrsodpqKEIQN4XUoxsLm2InKIGELNu0s4OPUdZaSUEmJMOMQDZDWtnm6TLAT5s6YraFNKshIICvy9ThRlYR4iqHTrH4MLrYD6j4x1RDBHGw5M8eiAvm3ACdlMvd2XS1Sd2j2ohL/mEouXj7WMEZnacslVK5tTYXWvsz3f3L0SGr49uQp6POyzwOpb4QZbk56EuOAq1S7b0UnmdNr7s1YpBMiQ+yJ3SjPAh8VQNumMslwqmPV8iRX9JFPjao4QTxzMHPrp25J546UlN1hm4Q93DLFoJ0YQucNnEyuhg0k1Yix49dPGLPjo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <372E4F8C9B643E4BA7002AF2531162B3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a746f9d-fb12-416a-6556-08d74329ae8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 09:04:19.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3sfPeL9S1oCn/YkOPbhoI9AliZOSo18OHH+rmpwKZRJ/ifhidvOHmjba8vxa8EkoV3BM9JenDCutNO4ywcIIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4304
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-09-25 14:31:58, Alan Stern wrote:
> On Wed, 25 Sep 2019, Piergiorgio Sartor wrote:
>=20
> > On Mon, Aug 26, 2019 at 07:38:33PM +0200, Piergiorgio Sartor wrote:
> > > On Tue, Aug 20, 2019 at 06:37:22PM +0200, Piergiorgio Sartor wrote:
> > > > On Tue, Aug 20, 2019 at 09:23:26AM +0200, Christoph Hellwig wrote:
> > > > > On Mon, Aug 19, 2019 at 10:14:25AM -0400, Alan Stern wrote:
> > > > > > Let's bring this to the attention of some more people.
> > > > > >=20
> > > > > > It looks like the bug that was supposed to be fixed by commit
> > > > > > d74ffae8b8dd ("usb-storage: Add a limitation for
> > > > > > blk_queue_max_hw_sectors()"), which is part of 5.2.5, but appar=
ently
> > > > > > the bug still occurs.
> > > > >=20
> > > > > Piergiorgio,
> > > > >=20
> > > > > can you dump the content of max_hw_sectors_kb file for your USB s=
torage
> > > > > device and send that to this thread?
> > > >=20
> > > > Hi all,
> > > >=20
> > > > for both kernels, 5.1.20 (working) and 5.2.8 (not working),
> > > > the content of /sys/dev/x:y/queue/max_hw_sectors_kb is 512
> > > > for USB storage devices (2.0 and 3.0).
> > > >=20
> > > > This is for the PC showing the issue.
> > > >=20
> > > > In an other PC, which does not show the issus at the moment,
> > > > the values are 120, for USB2.0, and 256, for USB3.0.
> > >=20
> > > Hi again,
> > >=20
> > > any news on this?
> > >=20
> > > Is there anything I can do to help?
> > >=20
> > > Should I report this somewhere else too?
> > >=20
> > > Currently this is quite a huge problem for me,
> > > since the only working external storage is an
> > > old 1394 HDD...
> >=20
> > Hi all,
> >=20
> > I'm now on kernel 5.2.16, from Fedora, and still I
> > see the same issue.
> >=20
> > I guess it is not a chipset quirk, since there
> > are two involved here.
> > For the USB 2.0 I've (with "lspci"):
> >=20
> > USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x=
0 USB EHCI Controller (prog-if 20 [EHCI])
> >=20
> > For USB 3.0 I've:
> >=20
> > USB controller: ASMedia Technology Inc. ASM1042 SuperSpeed USB Host Con=
troller (prog-if 30 [XHCI])
> >=20
> > Any idea on how to proceed?
> >=20
> > Thanks a lot.
>=20
> One thing you can try is git bisect from 5.1.20 (or maybe just 5.1.0) =20
> to 5.2.8.  If you can identify a particular commit which caused the
> problem to start, that would help.
>=20
> Alan Stern

Hi Piergiorgio,

Would you please check if below patch helps?

commit 449fa54d6815be8c2c1f68fa9dbbae9384a7c03e
Author: Fugang Duan <fugang.duan@nxp.com>
Date:   Fri Jul 19 17:26:48 2019 +0800

    dma-direct: correct the physical addr in dma_direct_sync_sg_for_cpu/dev=
ice
       =20

--=20

Thanks,
Peter Chen=
