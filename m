Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7189C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CCE464F4F
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhBBL4r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:56:47 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:22616 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBBL4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 06:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612267004; x=1643803004;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=n72ipFMT/kYxCr26OUV5WrQgItBV9Y6dGqi7ZWXwjdslHC37KKlqWbvN
   qN2H0OmIo9zPM64w9/VEf8mIv5QtWBCgKCvFJQ9hKItL+dIfqg40DZ+n5
   LGMGJqDdbWejBlUNTBr8V0nA6oWCRE19bQ6p12jdY7WHsALjhYg4YO66y
   kZSANypzlKn7kOixn3r/VS6Y2Gac2+CJv8TKsJp2+hiQKxhNQdSFM1/yL
   9RSeTpssNfO0d4v9iQkoff462kasOfrZXlk/K0Ab9s2Wt5vkMgLW8LpyF
   fpAj0sapItNmYkBii2aogXuJVxoRcpowNVlVwgXGgSwz2BDdH1vYC5Zhf
   Q==;
IronPort-SDR: M6bryLaJ7GCz97KyG/TV6nObwB5jViboHI0WpvLUvXqwUumQx7IIml/yEDAcDUGu6zxakEtXf1
 EV9EQe9Gq9VQp4NuLo6Wd4vVbO0CZBMznw7FwY2vd7p8vkWP1sAZnzYL0V/7z63kRroE1s5w0I
 vSTZVpkGe+k4xzuXHMKwYgurPWJW1ejaQnTDtY7PH9KO/ZBoh1TaMxPupES1vPxv5Dzm04rRuN
 h9YAS7HqiFA8NuDz1c7XeeQtrUY3fMbVbbF8dhAtWZtX2hbXnprTJ5hW9w3PtCSzI/aoEyj3Dw
 vSE=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158913824"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 19:55:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8jNQnt9CKosfAZCEWnI1pBv3ngSbpZ7pNhJKJ18yBn02Qgl4vpPboRZhbw0oXt1DEXby4MadTo0jGlzhbC0Q/8PYZ/N3QHcxm4NoDMT76sTRp1jpKOK/t6nTaOppvp3S4up5li3A4ydqDI9CC/Vk7ohqwWquyvERWZy5z4nCbkB6I+xAFrzn6aKMSPrj3Yzqt//whqMBAbQEFBmgJh76JSTYByR/t3gkfLvHPf23NoHsShU1Sy79XRqTb5Posrt+Uij3TQwMhXSPBjc9bEWhxQQbVkuSS+oaJuuKuuEdOtkbYK8l8ZljjTs32uLTI0bjjGhEbWQ06r9mpCOmG3ZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=F/DzCBAy7wPqc4lEbzSHrkcWE/r/cEFYgf7KfAgWkN5wB412I06rpa7ZKzHuttcD3zZmw6DiMX/7T5rDbd70UA5UJ/kLOiLskLmKgrh+eFTNs1ksxk+78vr3DDoykEjDbQVmvmhjtaB5nzcWbtm/0Lox034HATQM4nCsKwDTOsu4w/r9l4wqthS0lwHxX7oSNATAPfk3O+JW2hXI6K9mvI9hCRwn2w8vG78KGq7N67z1QIWtlqIWEK21wN5gY0rjRGqubf+4qojwh/xg4OIkbJuObNlNvhmfytMcqmLXDBGZvnGuaWwBYUaDcVD59YIhwHZrYYk2kIr4ZJk5eajPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=rLeXLO8oSrGz7KyrMX5SW/URFfRoWWU1Pou1UD/IM3IpESUDPRyTjFJTbSXyhPaZge9CD35bloUkSG92B8kd/9wcXPiFUkzj6Ii8FDH03f8jayE+BzvQTIAFMPnqpQelvMGIu8PzTv5j/J2FyplkAo5Y2ib/lbymOY5Xp01/1+0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7593.namprd04.prod.outlook.com
 (2603:10b6:806:14b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Tue, 2 Feb
 2021 11:55:36 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 11:55:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH 13/20] loop: remove memset in info64 to compat
Thread-Topic: [RFC PATCH 13/20] loop: remove memset in info64 to compat
Thread-Index: AQHW+SXWArm/qUqPWE+FJLbmgT80Qg==
Date:   Tue, 2 Feb 2021 11:55:35 +0000
Message-ID: <SN4PR0401MB35981FBACB87543711F96BB49BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
 <20210202053552.4844-14-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7b4bfe9-e839-48fb-f547-08d8c77173ba
x-ms-traffictypediagnostic: SA2PR04MB7593:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR04MB7593016BA590FCE47E81044D9BB59@SA2PR04MB7593.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qFdG16IizhH6V85G/tToMxrJC5p19+0d6+I5JChrbIVDBOJdmEzEXUhOpqxDds5NhPzBWtymVdjJgyyRzJB2UDl4NQZe9i0IQ5k3XMlEpDs3rqCzUOUCvM86z4kli7uaeHDA3chgG7XprAdzoDs+gQvSPIRRrnFwn+D+fYs7aJBIwD+Grvr8xxr0HSdJV7f8WnVLMP+c4yxJRhg5P+Tx0E+3idbF7Vx617tN+OHIQfzKkpiHY21/NQkuMUAtCD6wyIs61obk7CJ7CaUv5KC9wcipEc3VdCE1bTV+mpRDbRHhpMtk4H7xydLQxlkuLiAKEoNwu6+TIppLXYKH46QkjxdiHeA380ap+955TEBlv1xi7Vg9igx8qFlf1pJTcFDtO/1tK8bUA9rKL6UMylgRtAe6YHoD/Acp5bMo2CInYsiosMStgGvBXyEplCTHHfcahtVIRBhAtY4JiINix+FnjhxWhax3L7xEsiRCGV57EL7SB/2pDktFRIinhPUqUybYKKQH4X0EuYM8ntwalOmjSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(76116006)(55016002)(71200400001)(6506007)(4270600006)(316002)(7696005)(478600001)(5660300002)(86362001)(110136005)(186003)(8676002)(91956017)(9686003)(4326008)(33656002)(2906002)(52536014)(558084003)(66946007)(8936002)(19618925003)(64756008)(66556008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0LtT+0noUpmco66buvLRv8WT8NcCekm+us39zAyDHYJxlSPGB92RD8lLOHcq?=
 =?us-ascii?Q?Ob0KqE5sA1Ox+4CVtuAPm+Jf9keF0+oVuINnLbglduCy71tfpsiEfXcV3z34?=
 =?us-ascii?Q?09lp85F5ZQDgk0sVmDjDjzvRX2sW1+GsuUlk9TyKNsn+FbMCEMYrcHWWbovO?=
 =?us-ascii?Q?mt2aRmncPPWUwGbSQlm88I5ATz7voEReRM95BmEcxAHDDYwSuqnexj7V7M6h?=
 =?us-ascii?Q?CdHMooy4iDBCd5DboS/9qkiAV+11TXft9ZbKG5DKW4lSCWAzaKa3XszBpxvM?=
 =?us-ascii?Q?8SqZvJGvzh6OkBR4J+MxhajLjWDj55Eq9tvQdznMG9VkOGA47ss/XK8SbxEK?=
 =?us-ascii?Q?A5Lvit7kIWGJZXxealEPiuGB9p3MqiCh9qFLwlS2RA1iclhbMh/9/qgdp35w?=
 =?us-ascii?Q?4PfHUcHrYzXVh39I/PDfxNpn4H0KA58vX3O0JGxa6+HDEE2mOVTHh0sUnG4u?=
 =?us-ascii?Q?3wRHlKf9Emg2tVEAYuqHfJNu9kC4LJU2keCbozhBGOA+cIK3RWewOzRl3yz6?=
 =?us-ascii?Q?2mR/Icv5aQB2YM+KzjgfVgD1SENVoWU2yTmwFZFyaM/8bBPE5owSAUjNd88m?=
 =?us-ascii?Q?/9I5E1lnWlgWHDGYqqpr5PiBoaqnFE+I1EuyK6r14IBNVH6sVGp3JIVNecsI?=
 =?us-ascii?Q?31zHWpM6EEQswBYU8X1IFHQbN2yjbetouova3H3+pvZUTCVb4ZipnqKqz4ia?=
 =?us-ascii?Q?jil4j2iqlzQ4v2tIOmo5NoHnhp8iCVRMcsNHaTmt7yj9sGHIzXOhVexbyzPv?=
 =?us-ascii?Q?JW/eSJako/OdOxBvfrg2FtCbixSSv9sItQhjZHekqqLu6q6TyJ/W76imn0q1?=
 =?us-ascii?Q?UwuMHDcnPEQJq5rHv/6xSJ5rA7T7fFo9E2+tkoP9xI1zO4oQcckUGFY/k9Kl?=
 =?us-ascii?Q?Jpk4Zbp90GWPEVB9vTf2V1+AROwHSedb9cIgZ0bHRuqCiC0ZhXC/+84Qsepx?=
 =?us-ascii?Q?KzV7BaDDsWVPfNuQ4XK1eqrlfDRRypV+AL4zhY/Zi2QKHKY/39rvXxtLVP68?=
 =?us-ascii?Q?/XiBEV30w+nnItaTAvOSfYw6U28M5lmZxh9yRc69i3ba2zX1ZifqcXM27Xgv?=
 =?us-ascii?Q?+VSESoYQTEOEBLjssjA1QS9nRnPnkwf9eHCg2kdvjI1mIH2eic0jfqGqV9nM?=
 =?us-ascii?Q?JUM0NTb3jT87SpvVu9c//78Tlj3dBXMbAA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b4bfe9-e839-48fb-f547-08d8c77173ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 11:55:35.8999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AaKMpLnO9ZrG803lsnAY/D6zxVRWQnm+PskvbRJ6uVwpJJE2XQIYPmUXrYgEX+I6zK+deqDjyEJ7FLcbCGHS1j8/h+2BHYDpaVsT7v5ZF8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7593
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
