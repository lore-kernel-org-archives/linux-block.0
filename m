Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4FBC433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 15:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA20420897
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 15:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gj+VZWvU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n0FSEXnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404177AbgE1PX0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 11:23:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:48584 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404237AbgE1PXZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 11:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590679403; x=1622215403;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
  b=Gj+VZWvU1sIjaexm8AVZTIxTOj9d2P2DShQViKn0WV+SFty3Ra7zmiZm
   wZd5WlyCuUwfuUqvYj6sE/slv5Lr1ou1pNOCxTTdQoTkf0/c2HPbh+s6Q
   KWXsITrOp1gomr4n8Z0FoiELlpj/mZLjIMX/0uMPUuyUzaAUNyf6tK9dT
   IbbsBnbe16OG5FVNtJ3Q7ay/3eFYfxF6lO/30zFGwAUeGI08dMtaeqwkg
   08hL9PN2aAkeyImMjxQsoA0PoavejryeHuaPJWInkjdaDCzTA3BOhL+P9
   1LHzny1hN1QwGDlOLcFInZQ/4vVI2S3nR/m/HWmuHFesogtHoIcKC9kSa
   w==;
IronPort-SDR: 3XCstdkhPpRdRdMJRCsWCQ/aWD/Rl65K2ddfrUaSXelsMhXwBxXMbkqJNzemMYOCZn15grVf3G
 5tEWrY5Vz2VzO2t4/63+2Fao3K6rM0cFgQQvnis/78H/5hSgQBbO6Gj2fcbZUyhzJCMqehQ9q1
 Pl+Wh0aQjXu8Q7UGzwOKfeRFxhtU7OIHce0+7hwpN/oUdqZ2Z2cv/tv9Zq4McOMEQAAkmmMjWo
 zecHkmCASIlhgO4jWZcmiZrgucac2uEniBjVBkPO4L/M+El6jzPkFUSANRqLb0v/aacDJvf/Gf
 qo0=
X-IronPort-AV: E=Sophos;i="5.73,445,1583164800"; 
   d="scan'208";a="138712562"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 23:23:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMXsTZE7YHgWD8V4Roo4TsqvjCpM2c+YiEM/fe5GTxxPrY69iqp9f+tUN7hVlFVilGCvl+gGS0g+eMgsCLXcaBTJIDnYVOBsKBbKVXGUSXiep7Ge2fkG8aZa4Kg6KMj1cxxlgSOlrIdJdpqjR2seFRZioRdg7v7fjklPPcDgZVhsw5m2KYV573Kuf5lPNv9gZpSNFqsQohxW/6LiiKmacuiL4GJp/dstn1E3plctzltBxTD5snt18Kfy6in6Cab/hdTqIwN8Go6kQtJ/EzW5RgXjA89h8/TaGdH017N0go4nLBIQeX7IZG6WiEL38/IWxcJv8LErDCMyLPPZV78/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
 b=nvC+x9Q5qsWkoeGF6r/C1LErOg+khg9lGv/Neuf/TFZQ7UIqxMoUZYkTx6JnfENG0RVowA7Ggd2poxcEN8MLSVO4g4By629vp/lKWYYRsxE/cPh/OJscMc5yww7iKtWf3qKofHoLYVNgZjMzNJCUwMUSwKztFMCz5iedpLFEHQ3P41qBgD9B9YCfDqgh/YaXLVd1dKH4487NzY2DO2o49LT8hAUTL0AlyFSk0VVTdSk9e4+fwvXkziwzCB1b0mxff+ZR573UJq5bTwn3Yj3NFk5OewpkT3Dy4DA2gMiDLWJ/EoqDLIPfZJ9Kymf5QAPMZH3nR6SpxA2k71UFonLIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
 b=n0FSEXnf5r8cY8NRtOlrEIWDs8h7bkIsugb0o5ztGTlUiRpx1aanPSWunLKEr0uKwv9Z1mkJmf3K2ZW6rG8T0E+6LNMGfIKmWeuuGQIm2O0NmadpG4k2vI+ogH8YTf+PTCUrtDt/ASm606ml9ZF+pse4xQmx0fBRrlO+ajPdpjY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3597.namprd04.prod.outlook.com
 (2603:10b6:803:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.29; Thu, 28 May
 2020 15:23:20 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 15:23:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCHv2 2/2] nvme: cancel requests for real
Thread-Topic: [PATCHv2 2/2] nvme: cancel requests for real
Thread-Index: AQHWNQNrbZ7dDc5SSUWqKDc9ef/rVA==
Date:   Thu, 28 May 2020 15:23:20 +0000
Message-ID: <SN4PR0401MB3598FC8DB818BAFC0C08757D9B8E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200528151931.3501506-1-kbusch@kernel.org>
 <20200528151931.3501506-2-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2abd3d0-435e-47f9-da15-08d8031b0df6
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-microsoft-antispam-prvs: <SN4PR0401MB3597B512A89A2463F70110D79B8E0@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oQp/5E9rF6ezMoO/vumV4yTlOj61v8NVpk3Mxk8YVxRVwxsB1Ep9o60Qkzazcq3alMkF2qI1IZD+pkS6j09gL50qHgCa3mQeCc3cUPSIr4PaMat5s0ekO1lt5IiPfAuzCrjdGV+WZUJixXy+H0VDU7kwhVXml8BEKNwrnJh0N/LfLRVBadYNBzuweH4zioEEDz1DPktVtryU3ZAnpETQvlNp7P/dEq+xub4sraMQmTy3Klso6swETeB/KCyKuXMFDYigC8G0VL54Z7lVM2ZFsM7wcBuxAwuglJRLrtjSLorBt9QQa0DAGwBXDVi+fOflyLZWTWckliwK7UPvHkP33g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(52536014)(5660300002)(33656002)(558084003)(8936002)(26005)(76116006)(6506007)(55016002)(7696005)(66946007)(316002)(64756008)(66446008)(110136005)(9686003)(91956017)(86362001)(66476007)(66556008)(2906002)(186003)(478600001)(4270600006)(8676002)(19618925003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JrTRBl6oncQQHkuf84MM0jJSsM+8tJAi+XeiigOekEkekyeRhv1vA1jLpd5drsrwEagllJqOtTsW7VyQFx6Cr4mcPaYAmFbHnsHbdKtusa3WVRK0KIAU2ecZ/XMY2EtTKDzg3/Z1uu757CgDX7bqSNI90168hkE4pQdoJqveTomzTIeHjIDiYYQ1OTyvBzMs+hVejT4J9/zD4dst/n4DKcueqqze3/tS60uLix891aPfms7I43FLni1QoStMCfSEeFAo74n0V+aRjqofkL3giM9rG5JyHCt7VnyhsoRHTu5OM5jiIs7vR5t5zyW0HNJnxp6FMCZQbu86OW/2Po+KcRPNTY85qKHTIYANB2hyFk/bkV4wy/idxFpdBxQjSSzU7WSS40XwMT105WMyw5z/fTKnKg3WRmtasz6hZ/jwCgKanjwcReKy2jTKcHHBjLOMqUkuPtZeyuqxbDyu3ooZVAneEKxcxPRQ1P/WXOhZm8JVSHQDW9qGproYV5PI8VfJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2abd3d0-435e-47f9-da15-08d8031b0df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 15:23:20.4837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYURKp3362DN77sPPTA2QKatLn+Qnslo/jLEAv9k/OBuiHgy16ueiuWqJjm9hHsfBEGH4kVwhHrNgTX5w8skefrnbuaFCP5YmDZMD7qtPLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
