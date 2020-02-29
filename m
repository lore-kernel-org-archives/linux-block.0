Return-Path: <SRS0=t5dV=4R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D15BC3F2C6
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 23:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770972468D
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 23:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KpToXJf4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mH1fjkFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgB2XTx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:19:53 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63671 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2XTx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Feb 2020 18:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583018393; x=1614554393;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CMcCnyZJ400z5VpY059iOM7cJdFs+oTHGfmGsKWp920=;
  b=KpToXJf41rclSjNQXJGg6cLm022J/Gzot2/lxNq3mTHlI/k1GGkrjBjV
   jjg8ubhVQGuG5/JfTd5HkrBFphyCZbYt9Ke97zmuGqy8GF570fPFXYyNf
   fFWQnIIzC7CTwxakZ2gQU2bENhnjqyJludoORxM+YYH7IE/H2at71w5U2
   E3iZP5xgVU65yDC75Ad1BJ4hPHiT1sO/Y8zEM+CgYxL0xPMmLOpZ6MeKK
   +PttQK2yPdNqngaeI8fSNcd2YYeuRY17qPDVFecfZf15+bKpBf6G2SVuB
   9zUD3/IhHTeOqjB44xMTQf7GKugK3RARrkbszxatqdrxzhLS/jXah0UFr
   Q==;
IronPort-SDR: QwHUwBK94nkUL6OfyYfgdUlqQmEcLUGMCFiEGyqJNo30TiNz/qg5kgWONWFGu6/vdMEkwfJg+l
 NTYv/xiqbu9IA87VgYAg+uiUXoJ/u1pLkB5TQbHyzSIvPK1DePV8+k+jSz9OInu78FXv1DLhIX
 IOEFTP4RCos968m3yI2BmvQXLWy5973/MEG5tKnd0UFO0DHwAVyuohVFvJ+pTGTihoNnP4bewr
 PsUGEzKGSBMUcyYTZ33HyFSB/w1k2x5TSTg7VYzFgTO0zPEE6hc5euHwSq8N5Vdz2nojHuJKuv
 4wE=
X-IronPort-AV: E=Sophos;i="5.70,501,1574092800"; 
   d="scan'208";a="239276213"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2020 07:19:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3INW8rkXkXYjZBmlag0R3FSGwYElq3sLbWUJ1Iie8jAQwyJtP5S4V7yO+h0ljH00aNIXz+4TJWeMd9JTSJuUQ9IhvgapiX+tHFJaVXYrsfyrb6JIOBgdl3NMp+5uhA21XtJ9FIEgxILZ/bUoPWnPIU/S1ZT6Sv4lG9CqX8UTqskOlrnKMpcAPxOVcMmoFg9o3XDUT9B936FCa2cyJPLU/PHYnTX7AqCmUuZP61PPwgkQM07a+VRYiQgWb6ENrJprsdi1X53X7JjYdMMYq0yv8ov3t+DLgEJYfS16wPEm//qDCEw7H+prmB0ZV2uCghl7TKO/ZDjlRHM7DAdV3fZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMcCnyZJ400z5VpY059iOM7cJdFs+oTHGfmGsKWp920=;
 b=QrLd4L9uVCVfjcxGJ+EtSD1JMEGLtP5NKg3DDYq+J1K1Gzd8rxKLGs24ChNx8R6bOY7ZYmIcS/JM7I34ABZXnYV891/XRfE0YPcPuFEQs5MmvUPLYtQYMIvJxYL3qAD3Qj2xpHrKWuIsqAEWZj+MRTXVwUbzM+QSri+uk08VKJ1pnc4XsI8Pi0UDh3ixy1qIAKfZL12BO8WsZK+1AvXCbgwPOK1xIsdsq3Xb8zUynLTdIoelACtBqx4OZAVJb1e/+HbpGX0y5LwKd5r7bc8wKMSgFPb0CMTDH7yTH9mc1asDVVF4dtF/dDUmQKfwjHR5iFB+6M1cIvkbkQ3m0RHlSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMcCnyZJ400z5VpY059iOM7cJdFs+oTHGfmGsKWp920=;
 b=mH1fjkFqKs5EFv82pIOejulNQrGf8vYARLhXz8R8YdeU9M2FEpgpvSoCh8dphAcpOxgEWMMOlWH+EXX8ge67ee/tBuLt5chOxwWZ12ufuh1Q5saxA+3MVLHY034a4890eQnqTvY80QGElQOImmhYuO3iyMNW45joEFVBgYVBFCw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5159.namprd04.prod.outlook.com (2603:10b6:a03:42::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Sat, 29 Feb
 2020 23:19:48 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2772.018; Sat, 29 Feb 2020
 23:19:48 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 5/6] block: remove unneeded argument from
 blk_alloc_flush_queue
Thread-Topic: [PATCH 5/6] block: remove unneeded argument from
 blk_alloc_flush_queue
Thread-Index: AQHV7ki8DBY4K2vpLU2t/swizuyT/g==
Date:   Sat, 29 Feb 2020 23:19:48 +0000
Message-ID: <BYAPR04MB5749C18C7B3A998958A1A9F186E90@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
 <20200228150518.10496-6-guoqing.jiang@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 299839af-2e9c-426e-77da-08d7bd6ddf16
x-ms-traffictypediagnostic: BYAPR04MB5159:
x-microsoft-antispam-prvs: <BYAPR04MB51595E70995D9928D69D5FB686E90@BYAPR04MB5159.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 03283976A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(199004)(189003)(316002)(8676002)(26005)(81156014)(478600001)(81166006)(5660300002)(8936002)(110136005)(186003)(53546011)(9686003)(6506007)(7696005)(66946007)(4326008)(2906002)(66556008)(64756008)(66446008)(52536014)(86362001)(33656002)(66476007)(71200400001)(55016002)(4744005)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5159;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L6OuCY73c46maqg6FMeOKOYfBYK8SlMg/4UB6kgFRu5+oYL/O10iRTNvjccdw+IOxtExHNyha5UIFw9So7EvOsz0dftUo/x8kEET5BkKK0Gq/UjM3HhposEHbu5i8ASBFOjxZT3xdWvrogN9YsqC1LqAj4J/VK7SCif2DgFh0/I2v8X2+CTfCEohow1sHKmabLOqnPxmsqzj2PGiKCGt5gqdpjEtvxbJsHNglAl/4tfeTyB5M3cwASlw0kSRXt53KTSdH8U/WAyXel1W7r0KQNlBOxirjMg6vKUq/9UBpy04QBQ5TbloBxeEcVM3Z/oTQiilYnnkafE0k4OT7kBsmJtCPOiS+MWaReJ4zErqy1a1uiUponHFkvmhN0yeWC2/WfZnUW38Zh0PnduUvztzHbSZWyA+ao+c+ugkKHGA4utDB4bRBzymsdVvztlpdFwZ
x-ms-exchange-antispam-messagedata: C6QVK+PMZHL+dLlNa6vp6+lMsCL1JbS3dYdqoi2Zhu7WeA495B4cgLbrbKIZNowk+D54nRmccyqt6NGqq51n2H8oRTM9EH7GUFXkokXwPwtHDTAFJEO/ohOspHOUjvs3J3DtnubRk4XWA48MVm+1Gw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299839af-2e9c-426e-77da-08d7bd6ddf16
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2020 23:19:48.6631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/cw7iYQusvsd236MW15WeOLYG3mTfKqHJWAo/htILL9fe3+6Lsy3CF/qEY9IQ3uFkSyodWLXI0yhMFEKd+oL8cL1503FjBaaaLidfK/S8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5159
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good, except I did not count but please verify the=0A=
patch subject length, otherwise looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 02/28/2020 07:07 AM, Guoqing Jiang wrote:=0A=
> Remove 'q' from arguments since it is not used anymore after=0A=
> commit 7e992f847a08e ("block: remove non mq parts from the=0A=
> flush code").=0A=
>=0A=
> Signed-off-by: Guoqing Jiang<guoqing.jiang@cloud.ionos.com>=0A=
=0A=
