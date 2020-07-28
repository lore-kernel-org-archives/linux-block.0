Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABECDC433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFEF207E8
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UfwPDlw+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gqpwF6kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgG1Kov (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:44:51 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31560 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgG1Kou (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 06:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595933090; x=1627469090;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=UfwPDlw++bnA+01u95XWGciCXDFhfgREyFe3Ude+354lhTHtwtbtgCe8
   ieFcbTXnsCuegSUmC/GyJu/URi2GRv+rSGyHGgCg9eX3g0xAAypIcCJFp
   q6AGWpB66IwNrmnu2+jgSpLwqDJnwf5A9P7danKNjWgndrH+fREpuNNlU
   Nqb0m7Ui7XM4n6QTcHKBBC3buQHvY0Pax3AZ5wY59rVaAauLvWTY6EQoG
   /SrrtQkMsMau16dxs2lKXHIEt+PazLySQt3y2ao8kG0m5cKk4gF0JfL+e
   bgbEamhF14i3DffaVacwLIIh6q++fiP9gXLvJvoplAoAE9nugK5DtbiYm
   g==;
IronPort-SDR: KGBO8f3FZAb1VzABdLHeREpqNPmgg2ErX+s4RwCTNXHRZCCdWKGVJ9s329Z4dr/l8/NagiMQqN
 ZAdGTxDJnNzIRqarP6cApC9ipwdPyQQgwi//2jxVVYNHOdAXxObhBGOQHMBRU4DZqxSAs55VkM
 UVmCU8lJKGe1mpdyiFwtTPlZl5VFgiHk+/KedrEQl0dJwqfGnigQ3lSVAehaelCwVIuqJmi+Pt
 2Skq8rDc/eaj6ke9F0x0ZQNWqRSbUgTmPljeEJIqfh+jGAfHfb2C1ASmGWmooI+WHVfuK3iMda
 MLM=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="252880805"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 18:44:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt+dG4TbUmVfXkHy9lSO9ZF0y1EByu9B158bhoVztNxnTUruVVdTnb7uAiY+E6HR2xikCnx+iC/YAR2ViusMw6Ap+okU9mL08pnh+N+agk8+qdW9HPviTzyGxhvFlKNcU3y3tqCYHY7nWqnXRio+sLxwR787eNGrTgIB1yjhbSGCeoMGXXUsoVr2yK/qxJm4LJ9boyTk4G//q6iD+sInKEI+GtNcWO2tmtvI/28PQSwj5AU09Fds1BTlrmkEmnHPYXGwU5qQj+cX1YtTfYtnGzM7Zxx40zVur6n/qpAURouIdQawVRffpoACUSXHUfXnajiQhhgjYhf2Rdz1Hqe16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=goWH+RMNzN8tPFJZ/4LuydJyToDQcIT4foAWjyMG+fmmsctYZSBcVyjS/y9GmHS3VkB9dp0xLGfLIJAIhl4MWS9NSI++YtjOQvOZtyLWrya9E+XbfueEgKP3b3wXRuDnnZTZr3ND2e+m8scomKRplRpB2ER5YddyXgsHg3y0gG6iesqsgRyruvIy2RkENWq2l7ihGINYnkWAG2rC/bCOZe/aWxmHusjA9fVr8WUxbgz7MIKe/1pB9y73PB1m/fwnOfQSMWI1J9ZifWHhEfKUHyIZB8np5uxxukc7Fs3oSCnwteVH3/BUU6qHBXRgt+Mq32mW7WeH0c1/szlCWsJqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gqpwF6krl9+5MLafA8/8KQ4z8eGZqVz/depqBzKzH2wqKE/L0vBgUBEJ8satjiHiu8EAqwnqQVCykWWp/xnhASQWEyD56R261D+8s2RXvwPDHV29xKoMJn5hXjmKtwHbSdMXQ3++udzLUTi8kDg1u6RI51O//2TiyV0f4oreTE4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5325.namprd04.prod.outlook.com
 (2603:10b6:805:fb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 10:44:39 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17%6]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 10:44:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 1/5] zbd/rc: Support zone capacity report by
 blkzone
Thread-Topic: [PATCH blktests 1/5] zbd/rc: Support zone capacity report by
 blkzone
Thread-Index: AQHWZMfyi8P/Mbd7IEumt6qumggiqQ==
Date:   Tue, 28 Jul 2020 10:44:38 +0000
Message-ID: <SN4PR0401MB3598A3CA59CF011435ED63319B730@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
 <20200728101452.19309-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0c570dc-ef7e-4354-9d7b-08d832e33a61
x-ms-traffictypediagnostic: SN6PR04MB5325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5325BBC87968975150536B3E9B730@SN6PR04MB5325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNLshuK1yqP0Esp7/C7XlKPJCmuzynjwW+K5bo27dGCVnFWYTdTw8c35ccn42AU6VrP7tSOvrO8hn07X9/xNX2jA3RMFpgNdAsFoCy0y9U67qWjFvOYg1IGE+OWznEVoulXi2jjRxKpDP/RCnEYRlJmOGFb6PUak9Kl9QlJZTF2o0f5bKVgpI7JXezea3SdaUVDupfkzxp1mG1xvVX9DTR7JgY2gCvKu1X+ONJT4uD8ANk5ds4kKCmfXzSspfVsqBlXbl10rPHY63ohDt0lofNODIJiobL7fWCR5wNGORmg0+uAELZrSHbanA1l8TH01ZY5yHLg7qJI5i+Q7gtwtLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(6506007)(86362001)(54906003)(110136005)(316002)(4270600006)(33656002)(558084003)(4326008)(71200400001)(5660300002)(19618925003)(26005)(66946007)(66476007)(66556008)(64756008)(52536014)(8936002)(9686003)(7696005)(55016002)(8676002)(478600001)(186003)(76116006)(2906002)(91956017)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GuwHbHuypVFAuxH59zJ63a9RIWCRlgm7F9rm9ddRI7ZQaB1c3yQXXJAEaDMTYWp2uuZ5Ss9nFq+ABDSw3U9dQINPrh9qjcP2S/sE0zSuB3vbETBMIF/WIOPjVTCvO9ZVzuQrBmB7PcV5ZZbBLaAGlfpfmOotxGSjzfIWzb3FdNrx7Z4m4qPPy8hkJ02zZiGrYUqaGSb4dC+CYr2Dh1LOv2pEW1VC8w0g0sF4pEmn61gxri93NgW1wHq10CG2p5Ko70P3Q9aAWVXh/qgvBQZPDuoaf0Ic1qStPJW3fQDh4hAiVkiNMH57DaZujK2eNdIrCkxWscVEMXSb2QflwUILl2hi5jFyFSrCsu1OI8Ei6MIWhKKzHo1HCU8ntvnBqqLwfGKFQGa3G3h2cRbu2KpjCG5n/hW4wz0iCZMU2bA/DFP+s4wk6S7iHT/hdO9H/2F7GNCp3bgH9lZLm572Qi7nsX0j+V7ZcPd5l6lCKuBfmyLtUyx+rRWRjv4bQjLV2X8E
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c570dc-ef7e-4354-9d7b-08d832e33a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 10:44:38.9587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOWzQ8sA4GM3vBlurFYY7HTI4D+kcl6Me2x8pzCpkms6CQQX7BYyBImYlKAPv2c681SizbmxOdV/SpAqeqC4J0uQXftFDa+ZGGzKS0Jgq0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5325
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
