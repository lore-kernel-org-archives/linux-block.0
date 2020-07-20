Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410DFC433DF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 08:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19EF92080D
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 08:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MRDp7sOc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n2OK8fiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgGTIP6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:15:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12005 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTIP6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 04:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595232957; x=1626768957;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=MRDp7sOcexcVxiUK8+RRP+pHsWpCMmwzrmoUXg0Z5nxjDoA8bwapPW5b
   42bOkNJeIqRPxR3f+gCraCTH1MXZ4EisTaG/eB+PaqM+BRo0aGx4kcavn
   DFSTsQi5hbdlSou2vnkAEkgzRecqE3PPt/QX2SIeYgUDXnkEarspHmgdV
   iTpg3gfpmYr7eKuJFHd1YStx43cJjdspFNOvGIMuQe2c8uAEljqURWpK8
   9KTHFnH2UrPkNTMiV3+lFafq2gKsXfTOK2GWGq8TclKgjQkfhM90JmjmI
   51zuvSDYrbuJFvCokniVUxDE2/MAjTBjScspP2Xt76qCxEUR48MqfnL1s
   Q==;
IronPort-SDR: Kvgg2A4EJms9XLmw4Rr7ocFGB3OXTH4CLm6AAfF5ZQylCb0AYzCw3DkbbxeNkdeJDEW4l92NsA
 9QX4Y65pCTjTjEqN7QTg68vOJAc9O3/ZCZNw2B7TfDlGn6jyCMvGVc1u/6mmI4Wze2ZZNFr852
 hDXrvyKQ7WsxOuUMRY7VJI8Wv1RDV2Vixkbal6IykmDHkl7DIFvKVTzFcTwQMK9CTzS6F2sFLQ
 9PTFNQVzYZqJdyHjZIBlxrFbyMexnSCisSXOvvfbVzrDLNPIQhhlNRS5SvYnnGyKKqYwcK76P8
 lK4=
X-IronPort-AV: E=Sophos;i="5.75,374,1589212800"; 
   d="scan'208";a="252169446"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 16:15:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGyXQAnOUUSWg8H8OdBSr794arNMVaEXyCQ2l5n4RAvA47t6zOGNLG0XEmtUef78NUlxHazT/NpFBRLEgOVS6fC8AmFH8zQTYDMRh3HqocL8BSUsdxP+sIrTCQrZdSwNIzA1fDf/xlMmxQbjuconMeRicwedAJqCYCcuTiEwNtxz6ef0sg9B8q4NXBWj1x/tToR+X6yVTKTJbX4IM4wotUHW3TVWko4/YLF7x946rgHKvTrZuuORqI/PuQxBrs8Ot55gdGj85s+ZabyQsdyhkWLN2gXQdCQvhNmDOKFqlyKbiB9X5BQShP26RkWy3ycGSmAnG1fRbSI/bAW7d16K6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=T+w4o2hSsyqHDj+DIjF7+qWUSV7XnEeZWzEYd+lt3nWWSiY4ZetC0skuJdj1AhZVDa5nM7gRUS+4isnrFd4zx/1DZv9pJ2JznMl9RZkF+wqJSUD/2HRPPENBAtY2EP5V2VFIoLif5Mph2FRrLsz8U0M3BZ4653zTZtheR/forUiEIwFzJRvdLecpDRzW3hVhXQJ6zekvxK3Z4kMrCuJNmeuxcksCn7UGDewQ6UdHq2LZ/5IuC3oM/kl+8VOsaWp5kTXHTsMxg57Yc7xTgm1JwXptTRW7ub+zrEy9tl5ojS7RNjwKT6H75d7Kub/i0VnYc3lnqE1bRGJWj5/Q8Ptuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=n2OK8fiOt4hxNnnXujCC0bbTWhhR4sNiF5icVWIjpZIzWJj6PZUA9zZJSNPjfa59HQcxdBDv3Ve+y2iNnKLOxUpB3AUpnVGCerB4puVczvxaVz/QpLqtU/5q6N6OG/BdjrRtFzNDB0I30nVQQcnsf7SOMAv1zj0wofdYXNXTwyI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5166.namprd04.prod.outlook.com
 (2603:10b6:805:94::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 08:15:55 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 08:15:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH 2/3] block: remove bdev_stack_limits
Thread-Topic: [PATCH 2/3] block: remove bdev_stack_limits
Thread-Index: AQHWXlzTticbI+De9UWDtTddChjH9A==
Date:   Mon, 20 Jul 2020 08:15:55 +0000
Message-ID: <SN4PR0401MB3598BF7CD73EDABD6993313C9B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200720061251.652457-1-hch@lst.de>
 <20200720061251.652457-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2fd6855-2749-41e4-62fb-08d82c852001
x-ms-traffictypediagnostic: SN6PR04MB5166:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5166904DC0B705E5319AEF939B7B0@SN6PR04MB5166.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9IDm26oU7bNZFlQMSPyPedJf808qz9J598ce9V2+W8pMFq4IIO59nbbJxbav0xNGRg3umEuGgLnjKGHYSx27e2DbasMKfSjzgOrRXUPU8a6pVuHEbunKs2FWGznwGDlAap67IZwV98RUuEnOTwt0/qmcwsC/swMv5iDIA/pEd1FU7/fAOdAYnO1cl32vWK2dktml2AoDLWLiD0pxqQ1FOmvR/4ACy9WhKnJqzDHOGKqXR/NfUNUmO3PxAQABgYbNbgRUIGJDf+9IaSFxpwRk9TTZIrrMbJSq/4XI5z+q3mu+cDPqGCF5V3o/mHekQlE/24nv5nujz/sh0Y+bSeFxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(55016002)(52536014)(8936002)(186003)(316002)(5660300002)(110136005)(54906003)(9686003)(33656002)(86362001)(76116006)(7696005)(66446008)(66946007)(66556008)(64756008)(66476007)(19618925003)(478600001)(4270600006)(71200400001)(8676002)(91956017)(4326008)(6506007)(558084003)(26005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xe1QsrqXKLByu0qif+NLhnZ2F1czlQEeBR55rAth/cZyiODTcn3RHwdxUPvOnh4TQ+JOEHd+drqpah6diMAxlw4SMnVJnCvzTr0Zi69pz4VUIGdZQ/701/Fh3v4LZdP5dK8xcVAnM3mUmjFIW2FxSOtp65m4x01fjdz42KtG2+qEcUr/c86AbfgN8Bed9M9fkmbpbVKh3xqKlZsAeghoKGbKsc1jLvL584XFpj0poJCY2fkMK4Z8Bo5+g56ZeXxbwn+JSt7nHN4GqbEIh85AikdeWljSFXssEI/z2hccA3aWm054RkzdI1yHbEg8W3WADAErGTeQ2/1rO08tjwGPVLGxvCXKtf9ANdPGU/WhO+xtwZ9OHhJSTdJ77wrTzEot5DmI5qchCwL+umMCQdI4DV0Vy6ZSxX89VOvsePQ5NQBM6Ak/JNz3+OVypyegh01tXs4QLE+Zrt+uvrpCctHBAQKPxicUiGYYU/oP6GOuKeolRntODimCdj80HHaYm6uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fd6855-2749-41e4-62fb-08d82c852001
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:15:55.0090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDhivRCFPdJgrNFRTRvb05PXLQhhTsmf4NlNr92Gwbde8XPh+cb4+MjTDtVtLUC936FLSn+U587m3K1R/x4pXV8PJ2d+D8oVWzQvN3FcKYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5166
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
