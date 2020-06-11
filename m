Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2ECC433DF
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 01:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEDB2064C
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 01:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qkvaGuNN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="saqnuThw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFKBfi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:35:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44835 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFKBfh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jun 2020 21:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591839336; x=1623375336;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mR4lgEAtEVppV1+B0ZtUDuYy5Vx+qbjEb9C7TK9oDMA=;
  b=qkvaGuNNeESCoqQo6XDhWx2sp3ao25AYuPUPbwXpN4BUdFj8PW+e9nMB
   mg6xSPQmG68Gy9J6xSCP+esi+cEg9lFYncAEWKYN3WPt2rdePdQ2hNaby
   LmwAQ2K3FBN/TRE7L2nucJ8z8UlYdFUnBDVVwwslnUOGK0pIYX8kQnwbn
   0BqnS2vcdaG1LHJSCxQz4AcKeamdB8iydUovPJ0bAA4arzqxySG9G5Yb9
   kvb4PuCCMWFOEEG7tiP9uTXn4npDJXy6M8uXJIujKrPI3mAjC1UDJwzbe
   7BTl393vkXtmgI+KlwaOLdZDbaMMAPStUM5oSR5bmE/onRW7TMETs3aTV
   g==;
IronPort-SDR: SfzhKqKWOsvP2ciXtqn/P8aXcoO/J/hc0HO3yA/+drkVqMgkTVdlheW5kQ5jsimfQ3HtYoBIWT
 hfQu8ulTTQkomkNELficaBJF0AyNVBBK/O+BfoXZxUgVHHMCKNTLqYIXDT3+ZFN53XUXDI/++h
 RnEWNcfda5TyjcRSLBz+tKlbFUZFx3Z+3nhdsT5zoxiQZxHH/Po8W9uWUJoz7ZSAXX9hHjYoQU
 Fiz68uSJFwZW5D8M0sXqf0nH9jjNZHU2UB6ymZFbuGI4Za3dEodiFsuzdWtWKXVax8+mx/ScdQ
 LoA=
X-IronPort-AV: E=Sophos;i="5.73,498,1583164800"; 
   d="scan'208";a="139687078"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2020 09:35:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krM9ptydNZeDUVYVHJ3aiXY0zVsXNveSDN6EyiOYpNbY+NAgDIypAkucsS6+H+m/tLHCaiVYcFJnrOaDcaKBO0m0y5cvIsyyehpC7kpBK82tLEO+9weOi5pkJZQyzsaMr+brvT/MXeIi2ygvetT1DcdaJ/9Kl6+u6uhzuHIx3qfbxXINgAFDQ8QCVxPZGToon/qFDT15qOs/gmGSLr4rFeAJ0IE6Kgd50cRFuNHA830u+YX9TI6QV0XCNIoS0ayx5PrYWhQuEbP6Ec4HM+seXl7etOwiKjQfjFjXBZXrp0iPZreNsPeYiTi5NH5c1P7dOzS6xvGmzsq6+vIx2AIG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJm0S2QQXlSezEK7VTdNsDc3OGYreQT+1IPNMY+eX5A=;
 b=Wx9iV0LjuRsGnYDdRzlCJdhxcz4EavCX6xfotJ6fFWU4uOSfR0G/SQ65RJ2tTm9IMeb0JOMk/9u9bcP7PE5L1pMVvytTTLq69ScaPRjiHAoKotPu4cFSgKenAik0xYI7/ci1o7B6gaQAGgZgLttPaYMiv8IbyWHq+13O0/vxZ3+/zlZWB178MKyXW4UfJfV6UeA+gZBN19LdNvbz8eFNZ6/kgHgZeXIpWZklybKlP3J2UGxrZStrcCVFwsaRXsCWNXgXlhVm24piPc+sf3EV9YFU3qDQ5OEIAsTNPumcSRL0gYL81a2xYoNhsmaDF8ZnlPKhYvlx/Wiq+uPK9qFoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJm0S2QQXlSezEK7VTdNsDc3OGYreQT+1IPNMY+eX5A=;
 b=saqnuThww2N5M1S5sTY6QEZTEhNUEly8K7s+6RIDFpTskFD4mPsT7lWjycV48bXeO6Wl82Dmsj17oZSoWkX8zPDLEl4yiltjWDIzMKZ5PoMxJ8i8lgj3nxXYxhFTknRISdsyXi7TI/cmBvwg87IFAVuHR3hMb/3eD8XgdKnbxWc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4520.namprd04.prod.outlook.com (2603:10b6:a03:5f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 11 Jun
 2020 01:35:34 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 01:35:34 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Daeho Jeong <daeho43@gmail.com>,
        Daeho Jeong <daehojeong@google.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Question about blkdev_issue_zeroout()
Thread-Topic: Question about blkdev_issue_zeroout()
Thread-Index: AQHWPgrYecJlsJZTA06ZiAEFeZpWDg==
Date:   Thu, 11 Jun 2020 01:35:34 +0000
Message-ID: <BYAPR04MB49655E779DE03C5149CCBBB586800@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <CACOAw_zf5HNDaFtaMBAFYDFQaQj6YaXADke8JGm=A7CYXiCN5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8d3e2f6-6fc0-4c02-bed1-08d80da7bc47
x-ms-traffictypediagnostic: BYAPR04MB4520:
x-microsoft-antispam-prvs: <BYAPR04MB45207A0A9305062A0C9658A886800@BYAPR04MB4520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +WS0UWoM6Q+Y0kOSEM/a74TrdH4cvhSacKe/YrLy5XJQVR4xkFOfhuBGrwoDnX0Hy7rN241aoz6aQFNyYsz6l9lH/SlFygnpO4/7WDTVcE2QhKFaQD26sK1f24lR6X3d0Ljr36S2nJ+61libAPhVhT/oGsmSBMwuiB56wosaWBCNwCcvfHHfuDu6EhT0onZML7vuThVhwmVbJZGYsBmUKGhE45acF3nVe6A3yRLZhDPER6vnPW0JQ9P/Tn0r9kmhyMvYEeXijE8FWyV3NLPw1x+lJyvAIFN25MV4BGCiSiCJLyYFUYVnCxZYz0/92bFEu22PTECNYR0Sizhx8/k3bA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(186003)(66556008)(76116006)(64756008)(5660300002)(8936002)(26005)(316002)(66446008)(66476007)(52536014)(8676002)(478600001)(33656002)(66946007)(55016002)(7116003)(9686003)(110136005)(83380400001)(6506007)(53546011)(86362001)(71200400001)(2906002)(4326008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rc7SA4v0JZCMCKXyHSH5aDjfZlyvowEju4Z7Mf+jR+scvB99kxg5k90jsDrciaov/1LrbirW+OFQUIKdM0wscDEoIfaX9ZH37dryCS3/qw+SnUEyDbEDIWq+WJNgn6HWVA8YMRLP6hrlCyqneVXOvSOYqo4N+ODdMMUwx6RyNV99ochUliLWCzWExm6hsH49Kw6ZXfqkzUFfao8/8u1t5hFi+KIb3WdYZnBJHTK4KptWxUI+dTzr2v5ssBi+rTXf5tcopEtqVj/M2xNW4VT5tSVWEYU0blbv3mN/UPtPujhs62RKjY8Agd5fovwhctQ+rMo3Jod69JHoLYXQX9GepuTdzbrs+OyTVEvtNzpqBW0ExmZk0NO/pIwGEsZ4ahDM8fZutBfHEksQmQ4OVa1PH0vyazVHzcd7POhgrxH/zymJP+zmBfx7Uq5Ns8ufhoAJ55hhEXQe06QjvX5OQx4PpuGUjGCjh9EYhqdU0aqEchY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d3e2f6-6fc0-4c02-bed1-08d80da7bc47
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 01:35:34.1113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8f+2Oh2bDABV/KcJ8otl1mnaCHZFUfjPvbfMb8pkftXmKsWdywJAVPgtG4D3M3mCU9hHRykbSI3LzpNWC1s9Qq9OCZp4Lq6qPgIux36Z8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4520
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Daeho,=0A=
=0A=
On 6/8/20 8:05 PM, Daeho Jeong wrote:=0A=
> Hi guys,=0A=
> =0A=
> When I looked into blkdev_issue_zeroout(), I found something that I=0A=
> cannot understand there. In my understanding, all the submitted bio=0A=
> will stay in the plug list during plugging. But, I found=0A=
> submit_bio_wait() calling during the plugging. I guess the below=0A=
> submit_bio_wait() might wait forever in the lower kernel version like=0A=
> 4.14, because of plugging. If I am wrong, plz, correct me.=0A=
> =0A=
>       >>>  blk_start_plug(&plug); <<<=0A=
>          if (try_write_zeroes) {=0A=
>                  ret =3D __blkdev_issue_write_zeroes(bdev, sector, nr_sec=
ts,=0A=
>                                                    gfp_mask, &bio, flags)=
;=0A=
>          } else if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {=0A=
>                  ret =3D __blkdev_issue_zero_pages(bdev, sector, nr_sects=
,=0A=
>                                                  gfp_mask, &bio);=0A=
>          } else {=0A=
>                  /* No zeroing offload support */=0A=
>                  ret =3D -EOPNOTSUPP;=0A=
>          }=0A=
>          if (ret =3D=3D 0 && bio) {=0A=
>                  ret =3D submit_bio_wait(bio);=0A=
>                  bio_put(bio);=0A=
>          }=0A=
>        >>> blk_finish_plug(&plug); <<<=0A=
> =0A=
=0A=
If your analysis is correct then this is true for=0A=
blkdev_issue_write_same() and blkdev_issue_discard() also ?=0A=
=0A=
If I understand plugging correctly then when a process is going to wait =0A=
on the I/O to finish (here submit_bio_wait(), the device is unplugged=0A=
and request dispatching to the device driver is started. Does that mean =0A=
we should finish plug before we wait ?=0A=
=0A=
Just for a discussion following untested patch which unplugs before =0A=
submit_bio_wait() in blk-lib.c and maintains the original behaviour :-=0A=
=0A=
 From 253ae720f721b2789d8fcde3861aeac6766b4836 Mon Sep 17 00:00:00 2001=0A=
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
Date: Wed, 10 Jun 2020 18:23:19 -0700=0A=
Subject: [PATCH] block: finish plug before submit_bio_wait()=0A=
=0A=
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
---=0A=
  block/blk-lib.c | 6 +++---=0A=
  1 file changed, 3 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/block/blk-lib.c b/block/blk-lib.c=0A=
index 5f2c429d4378..992de09b258d 100644=0A=
--- a/block/blk-lib.c=0A=
+++ b/block/blk-lib.c=0A=
@@ -104,13 +104,13 @@ int blkdev_issue_discard(struct block_device =0A=
*bdev, sector_t sector,=0A=
  	blk_start_plug(&plug);=0A=
  	ret =3D __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, flags,=
=0A=
  			&bio);=0A=
+	blk_finish_plug(&plug);=0A=
  	if (!ret && bio) {=0A=
  		ret =3D submit_bio_wait(bio);=0A=
  		if (ret =3D=3D -EOPNOTSUPP)=0A=
  			ret =3D 0;=0A=
  		bio_put(bio);=0A=
  	}=0A=
-	blk_finish_plug(&plug);=0A=
=0A=
  	return ret;=0A=
  }=0A=
@@ -200,11 +200,11 @@ int blkdev_issue_write_same(struct block_device =0A=
*bdev, sector_t sector,=0A=
  	blk_start_plug(&plug);=0A=
  	ret =3D __blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask, page=
,=0A=
  			&bio);=0A=
+	blk_finish_plug(&plug);=0A=
  	if (ret =3D=3D 0 && bio) {=0A=
  		ret =3D submit_bio_wait(bio);=0A=
  		bio_put(bio);=0A=
  	}=0A=
-	blk_finish_plug(&plug);=0A=
  	return ret;=0A=
  }=0A=
  EXPORT_SYMBOL(blkdev_issue_write_same);=0A=
@@ -381,11 +381,11 @@ int blkdev_issue_zeroout(struct block_device =0A=
*bdev, sector_t sector,=0A=
  		/* No zeroing offload support */=0A=
  		ret =3D -EOPNOTSUPP;=0A=
  	}=0A=
+	blk_finish_plug(&plug);=0A=
  	if (ret =3D=3D 0 && bio) {=0A=
  		ret =3D submit_bio_wait(bio);=0A=
  		bio_put(bio);=0A=
  	}=0A=
-	blk_finish_plug(&plug);=0A=
  	if (ret && try_write_zeroes) {=0A=
  		if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {=0A=
  			try_write_zeroes =3D false;=0A=
-- =0A=
2.27.0=0A=
=0A=
