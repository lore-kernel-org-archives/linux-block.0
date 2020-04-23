Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16183C2BA19
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC7121569
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MpQakBur";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NKyXwr3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgDWHOW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:14:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29694 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgDWHOV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 03:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587626061; x=1619162061;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=MpQakBurI2IIgMAid4xpYdWF9QxbuLBszIQTdZZi1KmPTFGiGsOd04Tp
   9bBcmXsHD99sa7feJmzXwV/oE2ZEYBU2STQLu2ZHxDYInv3E2MXpGtlIe
   z4o8joKRvLvMAcfTOKY/qtU+wTW1mgmOMyMPf0Csyf9jFRug5pTQZ+Y/J
   l6weu5AsSuAic9gyTiMYwKZ37eocEx5o51LYeRfaNndiaDra/PcqeVYe8
   7mW/bKlTgEUsQiHW8WNBAHvyFa8YExgPMA2GV1Sxs379riuh9k15yDIot
   K+lkYokegUJ1Ctj5pCEcFnL30H2SlRpNnsDGWC4kqrHpFBrwq7T6qXe/A
   g==;
IronPort-SDR: gV2O4XVGzEBrLgc6/FxmhUIBLdwY6s+Uf62jeFbeNnm0jc4Yu7C2VU+7kbMaUBNiy8Zxkhz/ZP
 vGgsEmXkEgN+qmDeSS2XWWku8VcAh+Ip8X8qpjNjqG4rOI/A1Y3caD7UtIJnwsAqoUI1PC11QI
 nBUXKuy/xU3ExKookzyPxnKtNTFbqYeMN+QW1vweXnTEw0TYZ0/HToD+mrzLngY3QC1wP5alq9
 3e1W368hF3A57gc2aMyegwCV9oxVQYEAdi0Mw+Y0CSG0rwgl9oo8S6mxohwuC+wulTo796gBoF
 dus=
X-IronPort-AV: E=Sophos;i="5.73,306,1583164800"; 
   d="scan'208";a="135955311"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 15:14:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf8P8RerzbgqiaLuC/Br/LFudArEY5mGVe8hCe8q4wuIGh1yv9FSTnV+iC6Bs7YRerDp9wxHnG6xWIVMGxDMsOP4p81WSAoX1wbMBh6fFtAmuJWC0x090fbWkWZvtfeFFliBZ99k6Lb5ias2jmvc6A8IxaBXj5muUl9/FHsiQixP46/k/NeBjLH4IzGRRt2Z6Wbhgb6Mv9ZYNSxTo4pXYBsMbz1GWiMp5kw9sibMosY3Gvnx8yffKApxEtRCHTekzQUDaDXpBCQdsgNu/lGXzNKd9nNTojjX5q3TPJ8/7wpQg2ohcYXNQ7ean8uowR/EV5IpWrMgKhA2mDf8DqyGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jTu8YqRAYqq5x+hI4cd4IrD/epsL9uoBhoasu2tHdWpUbrQz4xTrxpzn3k5mIyKqNDx5q6m9Q5tzew2BP8n78xjUeCJ/s1Div8Jekzqqa/MMK2qR+Bu+f+QTUgKJETjFeYSgWlCcdqVL1KTNsn1Smkps8f+gsDzbspeIFcFpZvNgstwEdK10pLVdgbj882IjSrvhQa5MVBDZjCiQG+FvRGuP5WXmbXvC3fjyNcygT+Bo3ECk/I1Xm6zhPeCmuYwRfIrh8bt9107EjNIgtyHB3NET90u2u/3jeY/2yAoXhgcZAksoqTn+tA1a90PL3oQVBDV1T7wQwllABmHu1E9s7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NKyXwr3SDTpWxiePgVG6HGj0L0s+RBGuHrMIXkshI0paMIIUz7KMSuSazMGY0f7+FuYHrF3yT851llfQcMORuVQmUC3bq4grkFa6/uKikBSQ1dzc5gWRRQo4Zt/+y000K6zxiZTT3jZiJnx1JOw33tSMwhQf9rS2vDvIuh/XDd4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3566.namprd04.prod.outlook.com
 (2603:10b6:803:45::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.30; Thu, 23 Apr
 2020 07:14:19 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.032; Thu, 23 Apr 2020
 07:14:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 1/2] null_blk: Fix zoned command handling
Thread-Topic: [PATCH v3 1/2] null_blk: Fix zoned command handling
Thread-Index: AQHWGRuq6TMmmTjng0Kg+f2DcmAK1w==
Date:   Thu, 23 Apr 2020 07:14:17 +0000
Message-ID: <SN4PR0401MB359847C5C8A80AD98A0C37749BD30@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200423030238.494843-1-damien.lemoal@wdc.com>
 <20200423030238.494843-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94905f13-7249-4ad9-9117-08d7e755f0a9
x-ms-traffictypediagnostic: SN4PR0401MB3566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3566CF145083435CC02BA9059BD30@SN4PR0401MB3566.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(8676002)(81156014)(71200400001)(8936002)(478600001)(19618925003)(4270600006)(86362001)(316002)(110136005)(26005)(52536014)(7696005)(558084003)(9686003)(55016002)(5660300002)(66946007)(76116006)(186003)(2906002)(33656002)(64756008)(66476007)(66556008)(66446008)(91956017)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3yn5uA15M3Vgw2iPt+3uYVD2LMhXstHoodALq5E9FvCM8i93NdIYPiJOYTu5QhUn+114TgXX5ioLY1ZGVqThbBtBHQWru5O7mE3Nu1tIPIecYz6jr2roxoCAExH1i3hxcfCiGfkQu88xEO3/z73AhEc/bG2FvS0JUHK4xunhyzPpv7WE4dEdoLTJIqxQCQdO/R0x7SODanUAgK6KDqPb3lhpXUCv1Du3X7S0SrzxbTHL4Ylcacwjh0nmHy9mOGAkt07qLo1tALxwgzNmeEG5as4RzNu6wteOFtclSdgBaDLx5oHEHpeaCI+d+t7srtob9go780bbSuUazaasfJ5F16BWkTTeGnUzD9wvKtlf0xhoj/kQRrLQakxWJyWO/89Nqu2XWjjmRAMkEIlkufstFFznPf6cctJPMs4YHDr2kXhJuUAyxU9SJNT+Rlzm49m1
x-ms-exchange-antispam-messagedata: oaAYQgjsvsULjAztO6ce75u6p5WOKMNA4zAOHGJeBYFjvAscoqIjZd9ntVH3cP/+0ZWWu7kHLFcpLjo6BR3HNwQMW5luA0xSP/hfCSTUM7sMfZVOaKHi1LHVwBizXjlEO2jzYDp57TerWDHc73jakg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94905f13-7249-4ad9-9117-08d7e755f0a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 07:14:18.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7dMBsJ1vicXSLXUClgA662cI8kFcHCPLI2X/ypwxAF/C/lkzosuy5VXhwEkuzsLkJfPlMn5aqYp6Yqx21NGJ9sHwcUafPQkUfayQYlc5yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3566
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
