Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99ECC4363D
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 23:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5B32100A
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 23:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D4l0uQ2n";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ysiR6kGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgJFXzU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 19:55:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38765 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFXzU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 19:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602028519; x=1633564519;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Rpp3lVhDfwFLQIi65G5h2Y0pvnAZDCHoniqvK8NkzA4=;
  b=D4l0uQ2nzbwnMn0JfGnsZ8KZefeOgVZBrhRyjl15otAMm0vArVFHieuV
   n1uktGOUNJQ2GMs8ZxIziLJ85u5Lv/cXGeJ9kUdMuEu/bdZp6zMawrnst
   clcNEFNhVX2jfm7KpPeNgy2hV64OyoiMekGtHtZXisw0dqWUmf9cZEOyO
   blIezbaZzcz5IbSOFQzyq9L79l8NWhgAaEC+uImnqgsR+iHVWPm+5qHXE
   t5F/whHNoljLYRnFR8cUxz5F9/bTbuzhvK5KGaOQwETuNHPl399cBKdYt
   G7Ov6l3BeYDrhcNG6pIxk79nREeZ/goMVZtyxmMRFs+BpXqUC9hMSSURo
   Q==;
IronPort-SDR: UtUNBcDvoX/Zpg5m4HuyXQ/cYrs/kLE5WswRjgYNNFkrT8xgMTz30Pa+Df5q7BgKehAiDd+j51
 EJe/o4Gac+6hrvtr/VPpvHsvukkRDdJ98i+VhEBa8pTMI48TzXSaHgPyte/NJRYcT8r5u4Y1Xp
 f7RnaPWYakfdOAU9F+WDrcmcmBTJE7rKoODHC5/6PRELi2molg6RZSB9SeQQLyWPkEYBiCDnaR
 Rm/vd9diOS0BtPoUL4vOYqmLoLJuYRPGto4yA4w9KJ7+y8wy4q0XSs8MawLPcaPWnjjGd4mfwX
 pKs=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; 
   d="scan'208";a="150427381"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:55:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUdpU2CQzPsbwHuhH153vvIJGmohjqcH7ijSxWJ4hW6SQZCL2xkj0ex28p/PZrEDS/727p3CtZ4HbHTrwAVmHeF/L5LQ1weCvdSq2W5pAZY5JJcwDNr8KBfXOZ/4evw8c4bIV9EWuNX0sNj/67dn1ckZxSnRqU5CPZgaKA/CEzT6gJ6Ld9AROkLmkQkJg3PNqfLZhR/EIqdptHlfeLMTqUuEQmrRe7f7HW2t3CS0f5hEuUtXHwBhXXJ69WnVESq4xblCPkxHRVUSVe0eqjmn92j8oNWeLO0YsEo+DNrSIz5jc4RyVaIEkL65AaN+HMWfzQlRHnyRcIWftY+uQO4CBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpp3lVhDfwFLQIi65G5h2Y0pvnAZDCHoniqvK8NkzA4=;
 b=TLVmnNpwvWKnWbF1OolcEtT8Y1yfGPoA6oBs7hnEPmVkNpxD61hWMkbBmssyT17okLLA/qcs3O/b0+azOMObt2YZbpev4zYTq5lDBT3U+cqNwu6uI2wme8lo0IHSVV5qJyRhfa7fWQ3pSxFWcFwZ0/MDzB6cgeKoPjBaa69waIuOj3DZsyC/LBFObsVLa1xQHZna0xw10A0XTCITor+hpNZ82syscAVk70BeaqBlGlfxjSSOtCgmPMK1vhLqHHh6nGu5fCeAVhbLRntfBqKWbo14N6Xn2X6sU9mPNcTVUOESSAO1C1n8Gkcbac0Aai3x7g33MWZ+qNRx5bRPbb0/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpp3lVhDfwFLQIi65G5h2Y0pvnAZDCHoniqvK8NkzA4=;
 b=ysiR6kGmIcRQjYboDw3te1Ay4lZ8aCNj+yvh8okrUVHbIc4Y5I5yY/AK2ayVzgfrfZeKYBHBPoeitA/X4yQ0cGOpVq4KeVauF4zyv+zxkYfQGBL5Lb9ia5I3g/+id47Pid+WeBtsAjNdOPa4hsSM/a2lV3w4cI0pQUjd0iO7SV4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6898.namprd04.prod.outlook.com (2603:10b6:a03:22a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Tue, 6 Oct
 2020 23:55:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 23:55:17 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH blktests v2 04/11] nvme: Search for specific subsysnqn in
 _find_nvme_loop_dev
Thread-Topic: [PATCH blktests v2 04/11] nvme: Search for specific subsysnqn in
 _find_nvme_loop_dev
Thread-Index: AQHWl1ssGO8rVJrUsk6VJGLZV4glGg==
Date:   Tue, 6 Oct 2020 23:55:17 +0000
Message-ID: <BYAPR04MB49657A481271ADC1F576377B860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-5-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b718a2b5-51f5-4217-c671-08d86a5346f7
x-ms-traffictypediagnostic: BY5PR04MB6898:
x-microsoft-antispam-prvs: <BY5PR04MB689855309CEC85B624AC58CE860D0@BY5PR04MB6898.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jTO+khJNyED99Dl+cHEGGakHlrxssKSFyWGbZbmXNhc5rtLWk1WEglZWH+wC8VzQMmdC/Xrv0fl0ViABxAVXU2HbBPCNtmMOpf4iGNEaWm1UuEn5VHWWmx925ywOhso7cUSDJFdko+wU1II0lbdWr6Nf68uQUHB46NG/G1kb1we9xuz3m5voEQ61dHHsSkU247O4bc1K0aVojHrB0cVlr3VtvOivUbNGuT9s+zOK7UDK+2bybmsiNKZs8vn76/ZzPaFSk8mbUrLTXJQiO8WDrC97p2Putn0ZZoYVQJXI2BEBtxrQv9OxuJpXCel/DPK2pTgKc4InbnOuDEt79ZjYTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(53546011)(86362001)(71200400001)(5660300002)(498600001)(33656002)(7696005)(55016002)(8936002)(8676002)(9686003)(2906002)(76116006)(66446008)(66556008)(110136005)(54906003)(66946007)(186003)(4326008)(52536014)(4744005)(26005)(6506007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PbYw1EHt7DilMMiArzndgpUmNBskt8FJ5f4P6mp70IVRT2uT8+F9RHGP0IO6Ab17H9jo99d0bLjf31t6QnVEbSHjFcO5hokIt1hyNOM2cUMHEfDGqZZA9V7a+1SJqB96bEjy1yoBevKxYQAlpdF7ri4pbmCXzpKeGVjQo3iToxHJ92Y130GR7PpJeN2oWTEXkfjsH6VI/HLfPfU89VT/wNA5UftJAX9ejCLvhmjujFkHUKzKDxvWqD8r+Uy7YNWkJ7ysWMyJHvk5S6z7HYwnMzaO1bD7Ev3bMRXHPuYfT9LoI/XfGgphtWaveaGJV99HlAYrLBkm3tABIPpo6CZFDefWPa/I1bzegeQk14Lj+jM/dq4SAYu6ljLmsf+m01n0UU44rZita2/Ll422qQ9qVx89E9OM41FEBGV5bCApO2RaTE2XSGRgo1/VM9vy9jBGlWh9/s90KeL6RqD081iiZdbCkMWs1XyVEVkIerJYMvVbB3thhb+/yWrivlpWgil8gD9ggOWdzOFg0X8rHwe4eVqovzsF5a6vAI1M3gonewwHe6e1EjQ2Ln6WboMvcYJdAOstUcU4HJMK8Q6OExKa6J+4aztQMex04TydTZKEz6BrKlq6XCZmr6xdDFrY2TPm6lEbj4mApwXQ2jLNsEE8tA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b718a2b5-51f5-4217-c671-08d86a5346f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 23:55:17.7238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DztorwYjmsHmM7c5HvF3ktwDjJFO91QCYvnKM1PmrW2MhIPN+QQXqXnrvpS+GzNrwz/VHfGpP6q3GJEM+WXRxiC5tRI/LmhLww72xEEgy98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6898
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/20 11:54, Logan Gunthorpe wrote:=0A=
> This ensures we find the correct nvme loop device if others exist on a=0A=
> given system (which is generally not expected on test systems).=0A=
>=0A=
> Additionally, this will be required in the upcomming test nvme/037 which=
=0A=
> will have controllers racing with ones being destroyed.=0A=
>=0A=
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>=0A=
=0A=
If I create a passthru testcase with :-=0A=
=0A=
1. Create nvme-loop based nvme ctrl backed by null_blk say /dev/nvme1=0A=
=0A=
2. Create a nvme-loop based passthru ctrl backed by /dev/nvme1 say nvme2.=
=0A=
=0A=
=0A=
With this patch or this series will I be able to write the testcase ?=0A=
=0A=
