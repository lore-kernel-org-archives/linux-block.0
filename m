Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2A6C83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1ED2206D9
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YJOKiJg6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Mvq63lUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgD1Oza (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:55:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61290 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbgD1Oz3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 10:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588085729; x=1619621729;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=YJOKiJg6ioqEtydTNjc+eE6zrWhvIaaklz8kbcFGKqcyiZkv4Uk7YCip
   ax065IcF1GAsf4Y9pMbKABTorT84jAI6N6ME7S2pBEJrztj3Cnty643Cb
   r70jIUWJKkT5JwJSCfdIp4oUNDwVSPzDaVw+jcnOjTgzgbzT61Ts1QRW/
   M6nIg/1rfE+8nvfcIv5VvKUch1pNgQ4iNnEcn1k+swmHbQVkMCrRzXV18
   SskL/6Z3+w+nTNO1rNUv3T0dyw7FcgkCAmDwdDyvz57lPAdHWysC19l8B
   XBpjAftMWSHdlmnzdugRyW8Y/waLe/yNDjPaOzIQaODRIpc0FL7cvWypQ
   g==;
IronPort-SDR: YZ5yVAHvpyiY/i7CSZiTMVwPw18TWY2CvflB74ErhNFHSccuPJvEBaJ/TS/S4BPYTZMO9ucHSf
 M2htCdPZvWN7ynFP8JJzuA9W0+I5ucKB91lW1akNdiy2YlyZoPOkqUM/6v8rBUmwj/wF+wzIF3
 dtwdCJCcqe6RsTrZXlOf6AlLr8lNBBxiDyYNXNSccT0sdgPYFaMg+biq4HkxiO92fI2CGfrZLM
 ohDKdYmIClBZkLMgwKOKSdwX1fp7n+8P9HnNfvxaRX939JkxLMDHQMxMWwpkRv7P0nknks4Qrg
 3Xw=
X-IronPort-AV: E=Sophos;i="5.73,328,1583164800"; 
   d="scan'208";a="137797435"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 22:55:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR0lCGnRxFkTMWb08PTmHDQRB+yhqhMKL7D77h0PMToNPNfyOWJiHaUCI7RuVDcGVbOL2hOk5z0IMa11H1oAa6OdY5SUKaIQluvgVBFbZaCG/Vh3A+oumo3ILeGjRy471zEBKGMmk1lx1eGn2FmcXvym7sNAcc27th+OYp/ZjOF0aX4FBTfwNYfDg0FnfRtzyRlJ73HmK+k+eAJXi8GH5owHmNgjxx8uuC1HIQrhxIu4YTQWc6AG8Q+kvoFfLIlU4ClCjJoqkDvGP8kyz6C7A9qv4lptzMEmWgZd6ZZ+XvO/5SqNAYkz/oxpBz/ULbpDVRhTau082/oo4FObu0tgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=P/sBpZOoCtGHShlBlKezMM4A0JniouQfE8INeYpvn555yP066XxD9eN3ij4lK/ywchXwIJN8SfHO01AsVfRgyBV81wRBOyPI+dGlyw95cszdNClwKagudSmJa55RvU2UsEGGKXzGaf/SdGCZttsc4Xud1NKGc8CyZSsv41jY6TnLDOdkAENo4kaY6yrp86XE6PhB1iAYcszlVKETy2B38ABAdavcNvAM12co79DJp27aj76cCdyUHHJ3A3Q1i4ZEOhR/OmbF5+UdCywsaUSyV2NKm6Hm5W5FW3/sv6swZJlYn5MXS8mECggYxoV+pStF21mIwlLDlKlYMH04SzmpbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Mvq63lUB2KcNx0LO5Nw0IEMKVUPr5XwMFPZyAYosP0GXpLyCsI1EufAbqIG831n7uZLUvgzbTCqxZUM0/6sZyeMMCfCpIzHEftCx1k7bRthlVSEYZERlcMCjmnJX6EOSS05ofh4BE0yZBy+r0/zx8tY17x04hJl8Fzu+8/fxqW0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3581.namprd04.prod.outlook.com
 (2603:10b6:803:46::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 14:55:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 14:55:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/4] block: add a bio_queue_enter helper
Thread-Topic: [PATCH 4/4] block: add a bio_queue_enter helper
Thread-Index: AQHWHVAaAUJlfIiVCkOcpSanD17z5w==
Date:   Tue, 28 Apr 2020 14:55:26 +0000
Message-ID: <SN4PR0401MB35986A663A1643B0B857A1349BAC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428112756.1892137-1-hch@lst.de>
 <20200428112756.1892137-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c617e4cf-bfc7-4e06-1c90-08d7eb842ff6
x-ms-traffictypediagnostic: SN4PR0401MB3581:
x-microsoft-antispam-prvs: <SN4PR0401MB3581237B3662C246C4DB024D9BAC0@SN4PR0401MB3581.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(26005)(71200400001)(558084003)(19618925003)(66476007)(55016002)(4326008)(66946007)(66446008)(6506007)(2906002)(52536014)(64756008)(66556008)(186003)(7696005)(86362001)(33656002)(8676002)(76116006)(9686003)(91956017)(54906003)(498600001)(4270600006)(81156014)(110136005)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XDB3Pre6Th6BwQOKuXMAt9cWJ1NMwq9lcDjSfa9AKARg48N2PfjUdOQyqPh7Sfd5BxSS5kI+tekOqkYQrREHceI6mPSQoRNrt4CH6w8qVBNQS/UyDDEKxVvOYsLQeOWsMsRQFVvSMCauIbXJXOlhPhq55uDCaI9s5AoCx6h4pnE/uq0qi87nkEJUiS6EfWO3CXLEef79b5IRqAJbDwPBFQcakOvu0D4ihs2osBDRwQtbFcpreO55DGjg7Gftw81FJsgZYh3hmwFcMKVu9UeG1EO3t3f17O+ftSiIAnz/wZ5pyY+rRfVwnfY06PVj5mRBkLzb0nnjmrzlW7FEJyvHMBV/8VsIIsVPo4f/nXAXsKakO05kZnTjfaWG1+P4XzA18vO2aUHaUP1sYxnmx7m7x3cvjRNt9Osc5GMUppeWOACBliBf7KQhmH1XzPdYzBF
x-ms-exchange-antispam-messagedata: b2KF3vD/WCPKv9JLpUWyLOx0jFMJoZzkElXBrlONLVlQIS8weZ/Jbj1V6P+vBmXHFjqZ9sKZBgYPCgLNjRKTgzzbEbTqiMm7Qdt3hhm1Q9Dd+SSmDhrudyJsbutJ2BqoFwMJzCKSqP9OkNEYQzUJAdSy927Ih43/99o4Q+V7zfK3fxsd8IZl5KvvNmgAu71qJe1AfosEZ9PR76UcG/RF1rJ6+fshKochp8uNQoY6B5qR88tEeaY1sqcBa1FknjP+5VlmR8yUDLxcWic3utLRBf+idQXpxb1RrhqWmwd8XQs+ZeAB+Kc4YPhz00ENaMfbkfKhuA27A/YV2Yq0j+L2aQlZmN8kXcioYgxaJiEAKbzQrolTJWLVfye6bolF5aDt5veJ+nMYU/xINi1wOaWt2qJQNaEQ1flJeQMoOuHUP9GBrdNPURyCBrbijXJKF4fWYLIhFiNME37vaHGWkegpThBm8LgDjIXsIXzB2DmZp3UmHNZBGHyKueOGhJ7rs4uHQAKiq9CAlQ6byYPLYVPbQ+yyMelgbV6ME5fEAqwJCDSeSobn5GCshOMO/FCW9h+B/A+6TnLGai61UJzTjCEqw7zivZejaEs/riZoAuLk52OgQdhbKpOYFoA5peqRGIwh+RVhzYVp7C5/QxiET5bUI9RWMDOnmdGrYLpD2GeaYvlJGOr1GRmXuBRNOCFuPji3ZrOxMdpEcxw8NO9BrOW8B34PmbugUJ6SPRoPSmxNNPlVG/Oguo5lShY2B98UM5Tf3ciPreqEZS/wu5ewv2n2YTCytiQNfdIZ5adisOFbexo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c617e4cf-bfc7-4e06-1c90-08d7eb842ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 14:55:26.8293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UzBZNKLUSqeVk6rKrijdndzjQ7WdZb3P4D6RCDVKmqQ4oRcA+AGJbmhVgnIOzo9tfXFzLIRRk6O1Ssbz8fgMBi5c/wq4npmqDumjID91i+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3581
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
