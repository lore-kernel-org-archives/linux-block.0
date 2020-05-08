Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6357C35280
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 01:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8650F208DB
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 01:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GSNYOIIq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sVRyyqdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEHBNA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 21:13:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:18875 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgEHBM7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 21:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588900381; x=1620436381;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6xfRtlAhtN1QYdwjVsA9PAjAhQyIbQ65QXfGV75YvdY=;
  b=GSNYOIIqEds3Btl1DxeCCsUMxTWVqtU18dUXw8CeXeEsVGkk4OmMcoHU
   HhyTdINg/LN0AAc/gM0Ou6nwFBeB65qrq/WMIWhGoMDhQtsyI+BzjHae8
   tCAum0tOCEU3s+xd0mQdomD+4wzcWJzyZJckpelWkK5sKZswmgLImo+f6
   1kc72A6+fEW4f4lhMOp5xhYSTvD0hWzg6+/Z2XxNxTBegp1B3vHkdmrNh
   jH7IxQbWxQMnQDvydCREmPOLjyTzWjjE5LsPHFU9/O+dAgLk+XrFMvPzm
   A7uVtknldXALOluL9z571gl9P3Z0rm01ZAmjLBcA/fnKyJsgYwA5RTEMJ
   Q==;
IronPort-SDR: RJsAGWJlugG0pU8OBUdZ/omeHnMctMMMz/OuSIXkxtDpKjzb7Ltob1K/aheJrc7+DDSTBWG4io
 Mp5GI251oZV7MvMcPX7jZlT7tSmxq9Q0oK2foBoE/mfYUOVQqv2wfxciR8V+HFGBFrWBy0rQjA
 E6C/TJZ0upcAwQ4eldbiUWodAAArYCMuFIMx3onOq6eb/2r1zZyZiNlGRfM32GSUzZ3HyihxM2
 is2DJkl7y/z3vyBAHIopOo8ZR8VmbZQ9Zq675CRB4FePc2iMP/nz5uCtR0H74i5ZJBHFJmj8U2
 +Os=
X-IronPort-AV: E=Sophos;i="5.73,365,1583164800"; 
   d="scan'208";a="239832915"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 09:12:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWC/7O4tC1DDeHhI11ZK5lt/09uzFKQPK/rzsE3Z6ta141iXtoR98ecrQNQPM1N3II8c6/xhDRzxzJooB2qZ/3m8UlQiF1YRQyN6slgrmbzt4NJIgHgAX0hR3865P1F9sWj+QSQf+B1AtLUPKZoO6eDLTX3zAF4aO4TMip2GjWPXLv4h7fWFlgYxibBCxp2Ik9w5Vf3DKb6ftf3BjdIwdb1jH0MnoOe8tZgUymXMzW3vc9VXlQNC7s/V7qpvdPGZjw39qkBNcQ7sktb10ASYoCLf6bWWcSNCwaGTe0zfNAvcYk0XxmGCH6kybgjnJKx2/k27rnMZm9ewiwp8SwAQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/JGdp0dLONf9EYwZePDItZvl8LrXBmDVpjd6JeFa7o=;
 b=Qs0Xcf2qt0INuTvPYqQ9qz1CU4Dn5g3Wncqxrs0dLtfhVfbPvqC7cBegXLHeOTEonC2T7muKg/1Gl86G2xpw1o//1Y26iDIChlE9RKLtmhyHCiho16r7hc3sCRUzbQISUxth72V/WrBhWILZ0rWF3NU91pE14cZP+eTxerAI0ZDP3TF+1PSPy5PQ1JGaujz3uofTajtePysK+WA87paVvCpR2rCi6VgI4jvBiwsqLSr3G+6WfLr9VG2efo/b+NPd754HOF8CnZHxHNbwTPrbd+7mWXKtftUyFu7iroTi8zQt7qbeLJB9bhbX0xia8QnQNjSMf/HujeHnKU9VhpR4dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/JGdp0dLONf9EYwZePDItZvl8LrXBmDVpjd6JeFa7o=;
 b=sVRyyqdUEd5cU0Hfg2FU1HO+AaOETMkLiFSfH7MWLM8NL84atIt54vaYPLj8WxncRwaQ1RjOnCUA3A0MvBin/iTeuPXk2XHZ20xw/aY44jpd+ck22Xwq2XdxwbfMPRU3liFzwpdLB8EEYgrJ7XWSJPmDBTh0RqRO4kz3EEbo4Hw=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB6091.namprd04.prod.outlook.com (2603:10b6:5:130::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.29; Fri, 8 May 2020 01:12:56 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::6c49:dd56:97c3:3ae]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::6c49:dd56:97c3:3ae%6]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 01:12:56 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Kjetil Orbekk <kj@orbekk.com>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "harshads@google.com" <harshads@google.com>,
        Khazhismel Kumykov <khazhy@google.com>
Subject: Re: [PATCH] dm: track io errors per mapped device
Thread-Topic: [PATCH] dm: track io errors per mapped device
Thread-Index: AQHWJMQbT0aMuH2MDkOcDQCwLKYHBQ==
Date:   Fri, 8 May 2020 01:12:56 +0000
Message-ID: <DM6PR04MB49726E28257263F5A1C643B386A20@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20200507230532.5733-1-kj@orbekk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: orbekk.com; dkim=none (message not signed)
 header.d=none;orbekk.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 566aba22-a9fa-4839-b1cd-08d7f2ecf0f2
x-ms-traffictypediagnostic: DM6PR04MB6091:
x-microsoft-antispam-prvs: <DM6PR04MB60914DFE9F25C5D994D914D986A20@DM6PR04MB6091.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GjIIfAGC3DnGXMXHo14iXXoxMT/3xTP8NHyKj+7SeRLhQ0/+n+NSCFTT0aBuzB/fHS1Zxi814OMD7jo1ixek8Nzope7PAN5a834vW/7pegPWSN3GgwWGIfJLvvkfeSiJpLvswz2uBxI5G70bR7MhhnzE9mVx4fyRc7mFLaABHyDbW/pZtasQLLB+XAWbkexMUHH9USXMmkouhMEpTgyzrhAVMUrAfksi++Lh/3+aUEvUBOC5zRU9KaFeKWx7l6qBzNqgmyR9spEFg34MapZF1/4Lnm4wcJNgk3WOjVGzsN+q3K9yd3158GPDMrhUHBsTEzSJL1sACsjrNelrpKrdS3jULEVY5sNbbB9N2djKfSVTndxb8DWcOBLCZDdBVBgO2dFeabBgZ6sn383VHxV32uIg2UwculwsmqnDmhlx/ZeSG+u728eME7eRfInEAZXPbkiSRss+NFXibALuXWS28du5lkmOwfdiUoAngN3WLyIdTQcidhuVXFma5jkEbJJE5c6Aa7f/0fr1iRBhhwqZ+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB4972.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(33430700001)(55016002)(186003)(6506007)(2906002)(66946007)(66556008)(52536014)(66476007)(66446008)(7696005)(64756008)(33656002)(4326008)(76116006)(86362001)(53546011)(8676002)(316002)(54906003)(5660300002)(91956017)(478600001)(9686003)(71200400001)(558084003)(33440700001)(83320400001)(83280400001)(26005)(83310400001)(83290400001)(83300400001)(110136005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +1o+BydoZpKX3H/k1lagZBFQ/Rkopo3ENU09dtuxOX0HfWT1+pzACholiqzO4k3AYQ1Eo8s6rRz/OnO0N8XP65MQnIye5xxlLvf+6phwL0oTza5RC2tG0gFFYONnaChLZGoAlGwN9neHSMMbKIW2GZChq+1SvJXy763M/ACBpyXLjKAwJ8Y2P89I0Esm2Bl2xXXDa9+Y/li6x5sRtUtt5Z/7Mgd4jJnNPJaLxfKiAI3/YgNm3Srwf/NgxRj0xLQ/Eus++fFthfUyw1y3gEKq1l4JVj4upFDEXrkZiRQGlLW4Ac2WTtnbN0Wxeb/VcGvRGRJ+lc9H/ImLTwPQszYCStqIZTVlBbGelisOid8BEAJpufw26PedpbEhju0jyJjaQLqYbfzeWE6wRCEG7QUPJ/f+l7OG/C4c6+7BjbMcPM32gztuNvCEKw1/jMk1lubwZ49GZYF5AptGpfHXyYm5+Nl1Cg3aw+DfyyxWGcX6LsZ7516a/nQ7Q/gwrENtg5vKpgbRYHWP4NouQKMOA3Haxcz8JkZSIwc/L0DCSUmVmqUDR0NFuv66YZrXsbyIEgNq7XkGurFLB1PhH6QuJFLb2xvv2NdDmSl6uGCPLi6aFMWK6i3H4mhRZi2fFGeJ0JPQZ/jBkTncuvhi2wRGV4jQ9J62VXpNthfxdM/wXOkelYKAFwgiHTR8CQCMx0G/C8VO7cSNpsa9j5PGbqfjBX/P76t5pz5+X/VBLTte5SZ0FZhmG1qPSFxGe3fmNuKSOIjWyJdH3kf0kOweU8TDJIyEP699LG2F26uugsBu9UR1Qi0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566aba22-a9fa-4839-b1cd-08d7f2ecf0f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 01:12:56.4295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fPxSK3z4kH4KJFSfP8BSJuNGIgMcCEo+iHQ7/jkvfRBZ/QzKm1Y0iYWTW+yShS87599B7kYyTjJkIwE3Emx07lYeXHPi8BMrke1WGyf3OsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6091
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/07/2020 04:06 PM, Kjetil Orbekk wrote:=0A=
> +		if (tio->error)=0A=
> +			atomic_inc(&md->ioerr_cnt);=0A=
=0A=
Given that there are so many errors how would user know what=0A=
kind of error is generated and how many times?=0A=
=0A=
