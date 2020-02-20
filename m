Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D06C11D04
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30ABE24656
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V471fNkg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wyrsDzJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgBTIgp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:36:45 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39801 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgBTIgp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 03:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582187827; x=1613723827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NGpx4PQlBBjs/ppLhQ13+AkT/aOqGaNCX2Bf+xHfrSw=;
  b=V471fNkgfdtQ9cDetwxTWqzwTEI337d2JGXPK68aAO326saQ3XIrCW55
   s8+7H24LZe3zwso194gJQq/0RtWmMUMZMTqk5yWhFwqjPDWAAre+XxYkB
   n1IqKkHM1v9H5plq39MCaa7yUHPdcCQrxmQD+k++SjsCIxw4oV8Gs9GmR
   IxF3bxJ/Fw0CNdbXfrxquIAt4sVBkv3xg1exozz5Pr3TRsdpCvFt0H5Ny
   57K7e/085ICH1jUuHmAbu7Jvtz5uFNbfA5PS8mAzO5PSBg+ZeWG48cwRN
   WKtqYbMI2kilEmqRfVZm02d2f9DRFyiDasz25a6R1TCgFc5QPUvRjn+F1
   A==;
IronPort-SDR: nyb51ndqDZL/BCjuFw85X+NsvsN2Bew17391Re1ctCq8+MIispyKFRzXQPpja54b4rcswiuRNC
 bNar1GGdyCJeiDxUAMWXuhBQDB4ddDnaapZWiUMUJ9DsCAoh46YhUXWKKbKy61u6y2eugpQuQc
 xF0tbVr8lv6lF4TZcwcnvbMLmwbR6CGdCHYGDooWKqG45dRkMGAYXrNyvmDZLEFmdoNxdYaLx4
 dKACmJHjkbZx8Xc4UoEg+2/ofrWXFaS3s5Q2owDqFzXeTww2yAsnpQLKWYN1eU0D89tMTJyjMQ
 nKo=
X-IronPort-AV: E=Sophos;i="5.70,463,1574092800"; 
   d="scan'208";a="232132775"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2020 16:37:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyoy6ByZ91rUbSC1hqYkve87s5/7Qtoo8rmLFUFcMepXteM/2/RDRMKbHXS/TDEFuKzR6K4e944KnVrLl9YUvQEqBpmLiwNU90xLe/Ervk+KeFhOGywwxq3eHfu85z9nflI3v6cC7dyAx9jjUUkJWLaUHu3mz1w6qUmRXZwEDAAJkJ139IPFNF1YsNdLpT9h8yq8UEllt0ixEEDTz3bsbYjRvK3Xmt/iHAvBoT+J8Pw83ptzR6RV/vCFFyL6imGh0/0WF3iDKCF0gfUCfXSwoZJgYk9TicbncjkkX/jChXua4voksR5ba5csLfleU5bqNBdtJ+91iPAlf71oRbxvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KqBpu53WwNx2lUwohQTSrgM8ltPUm0I21TEbyH22d8=;
 b=BmEEmXXrit018q+8ifRYjzhqQpUcv/ciJvURWoAOCQkeQf1nhlv3PkybTqa2/gWuhMkc3+oK1LiHVPO56iShckSdpWd2EVL2lRP4os/Mir4tnL2ZYiz7PJBBEZFvpajEyBVbsuPKTSefrks6WHQ/aXbe2fEltsl5EGndbVL3KaqZ9vP/2l7+kNWq0UXl2Htuinq+TRpUTsCPr7+p0feOZFpJd9NbxG+pKCCghiMyxl+kzgCP/5Ov00W4JK7RTAhYsKuhKG/OffSf11KShJjhBkdWjtZUfUcodfLL+ntgpcL2lQvd5GEhsIeh/iBSKfEcB4griLsd+660S9kq9qeflA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KqBpu53WwNx2lUwohQTSrgM8ltPUm0I21TEbyH22d8=;
 b=wyrsDzJDLjc00mtdllrbHFl/kPqV2dUK9hKIpelRb5Fx798tjw/mWzIH34KU0lBiTc5e7yOB6dvxmdI0MObJ1pBUgQv/qae26NgqDw2AnLFXKaAC63+bBOMb+ZlMqgcIJ8s8ode3YQWR4frssaeYIvwJMYBj969M6oAHBHJQwAE=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (2a01:111:e400:c61b::7)
 by CY1PR04MB2329.namprd04.prod.outlook.com (2a01:111:e400:c618::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Thu, 20 Feb
 2020 08:36:42 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9020:d6d2:8e3e:ade5]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9020:d6d2:8e3e:ade5%10]) with mapi id 15.20.2729.033; Thu, 20 Feb
 2020 08:36:42 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] block: Fix partition support for host aware zoned block
 devices
Thread-Topic: [PATCH] block: Fix partition support for host aware zoned block
 devices
Thread-Index: AQHV5tzHvAdAMVkhL06rsJOJLyxSq6gitZ4AgAEOZ4A=
Date:   Thu, 20 Feb 2020 08:36:42 +0000
Message-ID: <20200220083641.ez6k27z6y6uepqse@shindev.dhcp.fujisawa.hgst.com>
References: <20200219042632.819101-1-shinichiro.kawasaki@wdc.com>
 <20200219162852.GB10644@infradead.org>
In-Reply-To: <20200219162852.GB10644@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fadaf8f3-9c61-4365-7751-08d7b5e002e1
x-ms-traffictypediagnostic: CY1PR04MB2329:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB2329F090F8D40A449225564AED130@CY1PR04MB2329.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(91956017)(76116006)(6506007)(6916009)(66946007)(478600001)(316002)(54906003)(64756008)(66476007)(66446008)(6486002)(71200400001)(2906002)(5660300002)(66556008)(8936002)(9686003)(6512007)(4326008)(4744005)(8676002)(44832011)(86362001)(81166006)(81156014)(1076003)(186003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2329;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vs+ikOMSyjRJLJ1miVFsIbXqN82K9ZpPafhiRPuiWHbEYrJUJy+eNxPD3LbRSvRRRoAWplilvwAc/odeXjVOqEp2dBQr0T7BY/FV4mkqXEzKykhaS62rYEwS+P3yPUrM81tQbj6DX/TOC8jLPeBVpgmc01peBUspY55lISkqiuhIC6X4f8x/+c1A5mWMGuKIMchIzM9HvU37KtIj5CiF2h037Bl9StR+T9BgjDdKmOc6htqsCb8vydRuIRdmAgn0qIgwjfjdoen78ARu75N0TJrJHqcAoGzz6PLtaOCrCjTYpGAweTHIQOo2b2WBrDoc5wGWA4sf4BtKppGjSaiVJ10gBiwJpLepyXBCtPr2A1IO2ynpKGcKoFDjig8gUeQuHjLhasf0PaoKXdf7mdNVOg804B/JYBsafZYzq0HQDI6a/f3KLPaZX5q/jnwbpweN
x-ms-exchange-antispam-messagedata: uoqY+sr7QgHXtC9NnoCumCAVF67anWWjNEKSaTQV+hqi+krOqg3HQDHRv5Sdp7EXWCgngq2/mUPoijQKqfUMqOibveTZ/rre5/xWnmKHDlLWhyXSSilHIL4bQMcCV2JuTf/Kh7CS/+jkSdUFr9bQug==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E56F54E6F7D414DB911512EC5346F2C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadaf8f3-9c61-4365-7751-08d7b5e002e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 08:36:42.0417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hgT2ZeY+XtjrSNPw3T8tU2Sku43a9oxMtu3FgdA8OaQ2JP84a1MXb953/RofOFQaXyobP9SdFVfW0wmRQpyX8lSnC5JnQz+X9G5bECUIug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2329
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 19, 2020 / 08:28, Christoph Hellwig wrote:
> On Wed, Feb 19, 2020 at 01:26:32PM +0900, Shin'ichiro Kawasaki wrote:
> > +	/* Iterate partitions skipping the holder device at index 0 */
>=20
> s/holder/whole/ ?

Ok, 'whole device' sounds more natural.

>=20
> > +extern bool disk_has_partitions(struct gendisk *disk);
>=20
> No need for externs on function prototypes in headers.

Thanks. I found that coding-style.rst says "Do not use the extern keyword w=
ith
function prototypes".

Will reflect to the v2 patch.

--
Best Regards,
Shin'ichiro Kawasaki=
