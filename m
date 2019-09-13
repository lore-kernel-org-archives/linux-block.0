Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A766C49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4335C20693
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p4X7Mlpb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="N20U/NU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbfIMWQW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:16:22 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52305 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390255AbfIMWQW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 18:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568412997; x=1599948997;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Hs4iR0kYMmnPUOMHja/9rUd625ArpphC1LkbGxRcZq4=;
  b=p4X7MlpbuZIcOgpggRvlQ6KZEfx3lBKEycrRtUGFygcva73D29gNl69g
   MSrFDad3NEoZWc3nvfmqWV/3aPE/AT8uRoJzLAdb/1osmZLVFeOEYx2Mm
   URKARF4ru2HettZSx11YzkqvDcLHNQnynLm3vl/qbMPumI+P0SUU3ks/s
   ZhIckhhrFTjPH6MvmDOqUA57o2/3P5vecHI0kAlNGQjSFmrDs4dBr4pyb
   dnMAUfH2aM49GrMNsq5RafSGfX5y7sc+HFsnTt5kfP972UJPIhTYhUvrl
   CJGgu/qjXyleyQNx8kFWVh+nZ6JrvvLjfVlWIAF4iNIVU7dEPCNNItEO9
   g==;
IronPort-SDR: ofmBZbjJ2nRQC93j/s1kE0YA+meq98SjXL9iUp1HVxow0PeZAzbI3mHgjropBFUvEqSHw4T2A5
 FAXJt7t4tDgajje9ypdywGACP3/AaUqd+MPAE9sJ2CqgNJPw9zSDkWBSMuZeobtVkoLFypC1hK
 fd6cs9uYw9uIoOulF7gDlUO+2i18cu1fttKJt2yGdVK/WpYsVvlQilBs4bpbICnD9YbyRv4SDE
 CQWXuVlGrI00KVkOZVftgmLCgTtpdTFm0Cv4dgPQpX/L8+KILr2fwrDS+jben0wul81b9Sf/Em
 X9E=
X-IronPort-AV: E=Sophos;i="5.64,501,1559491200"; 
   d="scan'208";a="218951120"
Received: from mail-by2nam03lp2057.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.57])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2019 06:16:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtHh/dZoU3lZXdBk7oRXUqmz+IXdkY8ZcFq8b4D3V7rFBQTD4IveSHaHyl2XEkuGyyee1tRjwJB/Mr/Dz/LRGmURaRabuTN5YmMbcISBwZFAAnhaY/n0MH60i1256urYVOWreNm6LTFWWTk0Gd00mS1Zd3PLRzv/I2g/APIArA4rJCQlldbzf67hGMRxQLESi7wSYPuKzXKb8wL6DwgUgIB3G+vpuwOBMuw84xNaNy5VnoHtI1O0ZxHb4IGWmmOrNtU/QuOI5MED/mSy3KqYNLp/yrcl4+NfEc2yvpgSf0YrziA1x98/g+i/eaZbNvx3gfVMMNlcL/V4IuS4X7KDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hs4iR0kYMmnPUOMHja/9rUd625ArpphC1LkbGxRcZq4=;
 b=Ls8bKsl4YyFxTR1g7lfOYmsipn84eomSIqxZvyj7c16s0il62N02MwYsTsecf/DhGGCGmqn+ivQTyQKHQnq0TSYeNOpfsH6+GBETnWeFCB9Ur4aZf31O1JYcb9uWK1B69gWwniaPu9BXY7UdzJtca/zwKePi0uusPJGdMbiqPAEjwXRNu/MvUv+qkZ1pZ83MTUMnZIbCY9DN4K4BNo8oHGtMXm8/8iCJLZuR7YkPbSsXtwW8C6xAfgEX40y0Ye1HZ9oR3nY3qHjKUG01p5dpXf1LvsgLk5Tkso9r5jka0JXN7rlVNA1xAwXfBN5hKvf2S0Ed3TajNbMSXbu6QpLSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hs4iR0kYMmnPUOMHja/9rUd625ArpphC1LkbGxRcZq4=;
 b=N20U/NU6jTm3qfi6LagbAOko8XASO6PvZTtI6wtqbsSpjrdI5HTDd5H97B258TrGfJTM9bGeK83bIez/Ywq2Z8VC6NBejfRB79vZ2oJ1zSl7tQJshVS/+BkzcSJl4FbtZ5zo0hb7DW0xRdhp6ZWHnob2L+XDzcY2S15kVqHuY9A=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4294.namprd04.prod.outlook.com (52.135.204.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Fri, 13 Sep 2019 22:16:21 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 22:16:20 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@collabora.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>
Subject: Re: [PATCH v2 3/4] null_blk: format pr_* logs with pr_fmt
Thread-Topic: [PATCH v2 3/4] null_blk: format pr_* logs with pr_fmt
Thread-Index: AQHVan86PwHRvfg7/0CRrrpMdIDfOg==
Date:   Fri, 13 Sep 2019 22:16:20 +0000
Message-ID: <BYAPR04MB57492ACBBD1A644B22D886BF86B30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190913220300.422869-1-andrealmeid@collabora.com>
 <20190913220300.422869-4-andrealmeid@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 106488f3-62db-47b7-de6d-08d73898019a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4294;
x-ms-traffictypediagnostic: BYAPR04MB4294:
x-microsoft-antispam-prvs: <BYAPR04MB4294D4B8179F5FFA2F36D40D86B30@BYAPR04MB4294.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(99286004)(478600001)(54906003)(110136005)(3846002)(229853002)(316002)(52536014)(9686003)(55016002)(7696005)(76176011)(86362001)(14454004)(6116002)(81166006)(81156014)(8936002)(5660300002)(4326008)(8676002)(33656002)(25786009)(558084003)(71200400001)(71190400001)(53936002)(76116006)(476003)(6246003)(64756008)(2201001)(6436002)(66446008)(66066001)(2906002)(53546011)(256004)(2501003)(102836004)(446003)(486006)(7736002)(66556008)(66946007)(66476007)(305945005)(6506007)(26005)(186003)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4294;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WjugYBBoFLP40ibsF8SI6eODoI0BWv+q+heQnCNz3DCK8XPM108Ppm5mq1XDKHEGl0jdIQR2+v026mih0PRKr1SfqdXp0JxqDCAqXdykb5GpDPYTaUXY5jiqoVwZzdvlHoARIxI0gvnH0bsIvOo0wvW45fju47jIsk+siVpQt/OZOf14ivlyvhqMa4k9yUXTkbGP/r1RjvSyMHTqrtyhWzGCJmHX4K+NGomwUz/ZN8wjfVNlVEDMLaJaM1omWwvqYsrQCotGh2RvAoyvWGCdZszQ55+fKbHHF0Mih1JxPYYBwR+ZoyqMSkDLRtMCNEFFb7nmLWMFFagtMVJVpoN244kexOOcwfsSJ0fMoZKN7JBWOPVujYvz1gkkuxWZvgQUvYN4gBvpYa9fWDisLrmNFUgRZ3nxDr7Z1Y/Bc3tJxwE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106488f3-62db-47b7-de6d-08d73898019a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 22:16:20.7496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2Hr0GFd6u04mwygOvt0JqTjfHX7wvoVbtvj2gw4P9BguZrLwfvjcWaoS7Jy80YEIiPzwATS5JSs74zPJu8kyDF8+gjFz5la5t6y0x2DF2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4294
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 09/13/2019 03:04 PM, Andr=E9 Almeida wrote:=0A=
> Instead of writing "null_blk: " at the beginning of each=0A=
> pr_err/info/warn log message, format messages using pr_fmt() macro.=0A=
>=0A=
> Signed-off-by: Andr=E9 Almeida<andrealmeid@collabora.com>=0A=
> ---=0A=
> Changes from v1:=0A=
=0A=
