Return-Path: <SRS0=MEbK=2Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFC7C33C99
	for <linux-block@archiver.kernel.org>; Sat,  4 Jan 2020 22:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2232424655
	for <linux-block@archiver.kernel.org>; Sat,  4 Jan 2020 22:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="POgRMlMb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kXwJyGfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgADWcT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Jan 2020 17:32:19 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22485 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADWcS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Jan 2020 17:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578177160; x=1609713160;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mAhAlJWlyxPqt2COxTwNBjasBE1ma/qqkGtFJwa8jro=;
  b=POgRMlMbpSS+lKpYeKQmvXNj6XjwAcTU2MKJmvssz/VdY7QpvsBdkU1Q
   k2gVNkCZOqySKmU0fU1UFOOyzBrCxEQ03BlTzHMBZy67Y5YF83Zs/3vuV
   +qZ4iElQtszYSZMokbU4fo38+AoBJrlPxPak0dhCY0EcFVctIqY/UEnLn
   l+6eiDblT1UYk3JiYcuVGju37C23OI7JCQtE4Z28vqrbRJ7j/gEKkVw4G
   1gA5bXwABHqDc0sKnnmDpX1yJsDv1zu0aFR6+XnoZ0bhxliGHWgFx1rhC
   0YUZ6YRdhz6xWgweUsYhMNhOUtQzzLJu6CMdnYLyyj+gNgKgAinzSmcMy
   w==;
IronPort-SDR: ZR28yCo+jp8WaqB+2NmZv2qRczatGOIzcjCV8TSVhf/jEhmE8LBPlWwYnRTwWtLT1zCCU6VyKN
 qNUgb/7SbSpLEpwtPxC0Zx+K3Q9ueIBx3lBbGrsKXJJDkF09onau0/jrFaUJNAI/+Gx+kz5P/y
 UoxgI5hEux6qYz/i5yKytM3T6CBZ5AMkr/s/71miUEDCzS/bplNtBXwM/CTBi9rMPzFA0x2hbb
 uulAyNlODBtPT3w5Cwjrkd/WqQOuZlhbERq9nKJ9OkSLRjwlSGiUjTYf3Xs91KP2wXMTiYUxwY
 GP4=
X-IronPort-AV: E=Sophos;i="5.69,396,1571673600"; 
   d="scan'208";a="228377991"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jan 2020 06:32:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR+xKYD2dPuL1Rk3lvQZtBCH1/7fNtAzGwFnFCzNEltwADmot/NLDz2yrXdoefUtaQtkRukqcDy897t8wbGM8ctWkYA23NW40XmKIFTJCCEnqJszvxDtEajkHUOrxuOafiHWGXrhTIKYZ+yQG4joDa09+zKS8+aQKk6NlvyYyhTZpbC3dEoVzn+CMm+rqYA5VeHEkzN1kG4PomAEyJapTyJ88/pUsPdNErND0GlgfLZc1MXOStanGnPN5goWeKUmmn05DamNxhRRZI6hKVlmUfGVpZLRI4hh2+ITPW+NxtL++n5uQiXMlL+rEl7UxUYGdTWOsQsPwenzAz5RHWCosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAhAlJWlyxPqt2COxTwNBjasBE1ma/qqkGtFJwa8jro=;
 b=QyqW5pCSpf5QNF9RgSiavQ2CbY3aINrgEBdbnzCk0KXCwXRuunFCGfa2eYiqzFplVL35+1iXXxhjOHOzBbKbsC1s9oxSddly+xGOM4b7aaH2a9NUQ5Q0RwtGenBbr+Kq2LXaAuwQsDEIr1KItDfHsKXoyaCFtGtNhJsdC984hIFjtMXli/xQWKTwTC1Nk9Y4BL14D0Mg8plLkn4hlFMMrlT4kvyLiTg2hbYmQQHIVv9Q38yD13OrQrdKmBQmAGZozxEfrOCahAiL+vplJiDEFK8LfxAX2KyFBMv1OLA4D4ikT0kxnL0rrrLOa4hZe7ntaHBxj3coZ0GqlU5Wm7AXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAhAlJWlyxPqt2COxTwNBjasBE1ma/qqkGtFJwa8jro=;
 b=kXwJyGfv4kGBQ3GIKdfRMWnSZ1BEPFBosOIYlljUtQVTZkaErz36BH/T84UPgdFJm+FH04wPDwU1TRTYor03Iz39l6/oh3TYIwXWQONx45s0LKvf0FzWCc3S36ma+yfdzocSdPWi2DNQ9D/7S/Y/U2UgLbIu9fsXwbCZuLMAhvU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4184.namprd04.prod.outlook.com (52.135.205.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Sat, 4 Jan 2020 22:32:13 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2602.015; Sat, 4 Jan 2020
 22:32:13 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "Singh, Balbir" <sblbir@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>
Subject: Re: [resend v1 1/5] block/genhd: Notify udev about capacity change
Thread-Topic: [resend v1 1/5] block/genhd: Notify udev about capacity change
Thread-Index: AQHVwUG9qzxAaxFzwka5YkVHh6Dxxg==
Date:   Sat, 4 Jan 2020 22:32:13 +0000
Message-ID: <BYAPR04MB57493C2B95D0679C4B23BF8086220@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-2-sblbir@amazon.com>
 <BYAPR04MB5749EE1549B30FCECEC1154B86230@BYAPR04MB5749.namprd04.prod.outlook.com>
 <e5d7e25798d679ea4ba070950cdb5a14f9818eff.camel@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 627881fa-f3e1-460a-e03e-08d79165f1fe
x-ms-traffictypediagnostic: BYAPR04MB4184:
x-microsoft-antispam-prvs: <BYAPR04MB4184B1C5B6BE996DB673643B86220@BYAPR04MB4184.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02723F29C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(66946007)(7696005)(54906003)(110136005)(9686003)(316002)(76116006)(66446008)(66476007)(66556008)(64756008)(8936002)(55016002)(86362001)(81166006)(53546011)(81156014)(6506007)(8676002)(71200400001)(186003)(4326008)(26005)(2906002)(33656002)(5660300002)(4744005)(52536014)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4184;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T6KUjJM9S4/g7P/Y7HFBkRvDKP37Gec9l+mdCPw09N6D341CIc4J6DoqUoaEc/4Sm3hb5dbLzhD5FEcvuxPP/5BAX9M6f9JewE0QUUweh55MAg9A0sLd4mX7zfN4Uh81nNIFMBX4CopZUWqxfIm6DWti19WPq3CDqjPRZ3rDVNonnFfIerKQ5UAV/XwdwCPbhxMJrzefdl8hJG4UrnNuorNJaSWOj27KrDuq47h+4O8hJt8F3cbeD1mFWrF+elVCBn8S6H9+KFpX/xIffhoYdmO34U/PrU9BJqyBPzNY2IzMqnkZNj7XojKvlNeRKR8ImaSSweevDC0QOyP4HRqgn28jO3/5OQhsE1+XNPdhmzqO+jn5UiGHEJf8nEJ44/jUn9aeDu10yaXy5A5BPoOtgUiUbyO0WEWnytNLtny2OE/qua2UA6jHzpjVsn0pmhbZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627881fa-f3e1-460a-e03e-08d79165f1fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2020 22:32:13.2992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5umaWUCbxTebkov9Pf6/Ll9ekCqWe7evliHwJ0sBXEhT4qoftl1E3Dztlq0a4ig72taxx/BCaAU79TypTF204fUxjbqAOVPLYl8dNXxsSzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4184
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/03/2020 08:44 PM, Singh, Balbir wrote:=0A=
>> >Since disk_set_capacity(() is on the same line as set_capacity()=0A=
>> >we should follow the same convention, which is :-=0A=
>> >=0A=
>> >1. Avoid exporting symbol.=0A=
>> >2. Mark new function in-line.=0A=
>> >=0A=
>> >Unless there is a very specific reason for breaking the pattern.=0A=
>> >=0A=
> I don't see the benefit of marking it as inline. I expect this code to be=
=0A=
> potentially expanded to provide callbacks into file system code for expan=
sion=0A=
> (something you brought up), marking it as inline might be a limitation.=
=0A=
>=0A=
That can be done as a prep patch when framework is ready.=0A=
> I'd rather not clutter the headers with this code, but I am open to what =
the=0A=
> maintainers think as well.=0A=
>=0A=
Okay.=0A=
> Balbir Singh.=0A=
>=0A=
>=0A=
=0A=
