Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8F2C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 15:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33672065E
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 15:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eSUOKq5L";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X6oIC9cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgKKPNk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:13:40 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1620 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgKKPNk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 10:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605107619; x=1636643619;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=eSUOKq5LdRTjkrmLBcrFUPWHur6UFHV1ofOhgMZDgugJnTxQWC0C3jjD
   AO0Km4IX6cY2RlbIQIQ+Ej56dzSJV1zflkCVv329fU1KBY2fuOMuacS72
   7i/SEb5Fv0LH7fw1D3KrQMT2RvBmnHvBjBbDntvuLs3UUdejvKzH12YEP
   W6feUnXBYNuiWzTguW6vbxE2wFR5L5OpNHLYUzdjxBway29uwLZjXpabM
   eI+gafzAw/EMDaxfwYxiE5oGAjA4MqICkTwbvNrsuYmXYH1X1hjWndFMz
   pXV0Yy68e27PYEnVmzhSLOjuPcsqbeI8gvjAAWEinac60Yb1p3OaElAEb
   w==;
IronPort-SDR: JD+T98WhlB9U+JI3+mNodeH+/ZBw+G/Gz0grCIvn/HDlB+W4VNDKFgaLme1pZmLQVs+74gaV6w
 KZKSQ8AC986dFzgkyVJOp0V7DTqcwMY+6xnJ6ByliXJ418hOkTouyx67XGQGBK75WZA6tG0Hsi
 ph6yE97u3to9RF5/v6rBOIgDij9lu7+mj9WhhFd4eKqaQH8ZUr/t8dYlaBTlRe8fOuPFuqXcTu
 IqbhLut5E4JZWZJBajYB3bkfhOot19bXHPcn7mGs2dUg4umFMK/XvlmeB2yRYALGBPiBfOL7hg
 EV8=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="156875302"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 23:13:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTD0oU7dkIiZrkoezwzdNP9T1z1QSiDt/23NTPHCSEgNePfCSkXReUSEVPTFquiGtXZBRCTzWJMgtyG1micfOj1732Nb+Csc4cjvuPhNfvTzGAAhER1MOTYgdeJ58RBAKns5Rdq4QL4oJ9RWYQrdMsX1v2tS6oXJKrzly25g/T2Bh9c6M9ES4Oa72ptzjgKt57GHcd4I9vcfe0TXZi/Xo5JZFszhehIvH/dhd2A75pqUz+eijfMeWpthOG42MA9SYFGh5bINHWkeJ2Sru8SbCj/GLEHOfFWRFnmtYU6cOPMwEJ4ub7VDe5Vjc8o5DNmvzCXu8yRoUVN7KJxMptV03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=njlpmrwn5BpYOqwoSd8qAt1bWz6gLDTC9zzm8rsR3DurCqyLmE/aaWnpoR7+VHKYKuOYTfQW7YNgKdHaep9uMK9mN/RCyJJiPZDi0RNlFtbdCKCjlFuF+kXFNJPWxWDYIt4QBGZOM6kGHOPEqNcOV9pThr9eRxDHaOmMKkUIWvyi9C5qoFXTLdautmxHdgMeEARmqv3YRJ+W6Kua5JvT+uUJa7D4br5DzB09OzzBSyXt4V1Rf8L/Morcd8hGV/682rT1B0qUZpn6CdV3Rs7Wqu7tAp4Ortm/oc4Tn7joOvkh8oulDSZuQ0tqAZ5+fEfGdvf/hT8hu6IQUcPkStnO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=X6oIC9cwx0ss3q/wOCWXTB0YlAhLkSSle2oxqoPr482JLNJjVwPCB48KSsPqvu8CFOpuuTndy4RfOuIpnxW9dpT9JDBL/Qm33E4RigKAOAicxjRyESl3P7rII7PTaeNjCoVFEPh+w/IRMDk3LvCA/qlN8zqhuxqgrjAuj2ST2qg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5326.namprd04.prod.outlook.com
 (2603:10b6:805:f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 15:13:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 15:13:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 6/9] null_blk: cleanup discard handling
Thread-Topic: [PATCH v3 6/9] null_blk: cleanup discard handling
Thread-Index: AQHWuCq3MIhYH68xxESNj4FBXz79mQ==
Date:   Wed, 11 Nov 2020 15:13:37 +0000
Message-ID: <SN4PR0401MB3598A520E1359F1F338D330D9BE80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
 <20201111130049.967902-7-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aee920e0-58d6-4396-1c76-08d886545da8
x-ms-traffictypediagnostic: SN6PR04MB5326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5326BC43A1900AD8A00BB3AA9BE80@SN6PR04MB5326.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SkM1Vkqb4o3e7SdopwRu8yTGMQZTGhKGHH4yLHpWytYDzcpyA704BSOEl6CxCLwZUya6GAAqPLCZtgjHutqvccj5GChhI2XpQlfprmgW3daYtShuKkJWYT5tUxI5QXBSCHO85wuPlznD2h4kbf8uq8ZJROVoTUnc7ARrxz2kiPLIdJCIk3YHmu8y4yG3x/s9w0f8QTfdPre4aDgacrImUieM9Zj3EvORu3TUll8zVXip28aUw2gTEjvIBJlBY8WDx6A1V/eKpWJLkESOus+hfaBRMzVXvPnsvRh5jjPxqXZUnMuRKWusIrPF6JxhxlIbYSOEGbwO1Y4K88gU7yrbXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(316002)(91956017)(86362001)(26005)(8936002)(33656002)(55016002)(66946007)(71200400001)(4270600006)(52536014)(5660300002)(6506007)(7696005)(8676002)(186003)(76116006)(64756008)(9686003)(478600001)(66446008)(66556008)(66476007)(19618925003)(2906002)(558084003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: X8U+ZmpCAaIl4J2qY3u9cWsZNURT9xee0Sr4CISiRIYviLWhvarTmveiQOg3ZuUSRedZCqlEpgFCmDwVK1p41xRo/JDm4CKp9rYlkaiBCPa+IYL1BBlZJGLxTS4lL/vWyBluclGhbH/CbgGTlLE3TFMGu/bSn69/ltUl1WOXXM+PZD4Kf7Gd2G9UCDHKeeC5c06b52B6Bwe43HieUTRU+FrA+b8j8GRZI3rdXQgbH3OParllb1aH++7Dw1Ol1M0HpLju8tb0xc3dd9xHHboQiP9qMM3wmYSMwe56ymja6itQ9F2inLbt8eshgvBuaxqXYtWRpQFw7+zErGzOtLy89Rr9sTj888vuKm7UhslNzv8YcGNTlx2GT+GjpK0NNkUr2g9fHIlfFzhknk9Hu3CAIgE4buPBsqHOdw2ut2BTuQZ8AohJKpyDqsb3s/YEy87mAyBBfmqqM/DiXRzo0m3O9Pu6ZXk1YDFBEHnioxucgtdtyqcyRb/lRi55kWOOCHVcicP7WiZIiHejnRbpwmB6WcMDkiGH/eBHNyxXzWvLEwx6pTI26aoLW6VudeF4FMEHuiNLRee3sbRzjcfeWzdNn5PpK1ZKF30Wkc5BZPQMvm90bFZlGk7e6Yr3AS6ujmtantG1knrZYiw1EftSRWu8kA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee920e0-58d6-4396-1c76-08d886545da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 15:13:37.8984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvxwjHQOpNveRN0A2HiI42KJm4g58Tr6gPaoVMzh6Qet+77Pc3cuQBRWJwtGNhbYTwqOtUcotYRJYOCmh3X67tcGackzJ+E1JHpOEZZKlTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5326
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
