Return-Path: <SRS0=XUQF=5A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156E6C10F29
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 23:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D697C205ED
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 23:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I2/7pDAv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="y01hmN+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgCOXet (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Mar 2020 19:34:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11550 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgCOXet (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Mar 2020 19:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584315288; x=1615851288;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0kvbbJ4SiwHiY1oUFlbKkId4NRRP5cFPol8QdflYmVY=;
  b=I2/7pDAvAouqUhdsxeMIHQTvPrF3q7/qiwr/erTmKJtxr+daDjtlIC8Y
   wtt79WhSmsLzcpxiaT5QjhviiIzQeEB03EINtm9f4aFKECfHIJJiKD64u
   i+8xT0ep+L+xvc9ZjYb3G/uJbipP35pOpdo14Nq1qOlcNR9i1B/a8TmUW
   6VMid6BPob/Fw1JY5oDLuIBZl4J8cke6M8ZFwKQGyvWP5AxjeudX8IqqH
   PnMGPtvGi1jOcafIQcNbTt7idi35wWcyaq/5dVeQbBRpggAtZhJ1qfo41
   WafLR0BXXae/LHNQnjsHMZmBoL0aOZtvC9MzyUoLB5uLtiNPFmEE46pWI
   A==;
IronPort-SDR: gOM978neKhRPICwg7ZwHzxEHuNt/Hm6Ye39pQaR5iu0hGx7sGrl6JFIv1mu1Qzo13PqL9X8ior
 vTtA9uN8h76oaVO18LXEUWaLhze3Nc1rzd6gq64inXXupAjKVy3gEDgW8IRRh4bF61rZOY9bjt
 F+sIoMK+dnwvBzyVXPt37v39PpQCls/Xi+7CLisA/NOT+SuLsHJTwDJMsSwhH9laPDZgFYAGUI
 sHW5iwqaDczaBhMu8pUMq9vTzkvWaqdcH08rnaHHhtInzhHGbFyb8URnyw9XsE2gmapDKHioBk
 u8A=
X-IronPort-AV: E=Sophos;i="5.70,558,1574092800"; 
   d="scan'208";a="132563004"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2020 07:34:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7dHb2/5iS61EOks2KwxZiNlbpBFEm00vpSQsceTzIzZ7/juGSPgtbsc2VsWQBz03heVYV8Ut7/5bBbip4hnI4QrY84YdC+QcA0fcXUQjaRrzUoG2ZzA0jpWyGjtiSa1oZ04a7dTHycrDnn/WvoLwBWdsjiPbapPpTTFARkjvuZa8VgyyHMrO6nqRMYrXHEgwAbOC1lcx24fUaLvbkA2vy+50h2Y3hPLCWlXXCY7sCyNlhXhUS5d6Rn3l1TYRK/rf9zdgV56HvOyU/Y3ucuKFEflPrTTzt0tmmwYnsd1AmDe4yLeWOx4BspRxwBhPQciAj4yFRPT3uwagWEeQ8NqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kvbbJ4SiwHiY1oUFlbKkId4NRRP5cFPol8QdflYmVY=;
 b=DsbvlPzl2dy5c0/0t9FeFFGkh+SK5QBdheiNrw8kxv14J1mIEk8bY4n426/EaoW4qufTKl72oYrf6E+wYj8LnLaiVaKOlzbfZ2+Q6FXmsXc1BA0KsFFD1o7Z5xdkpS6A6GoaPilDeFTAOuASF70PIeTF7ZRH7hfAnNfXVmVFDlyktlyuLGZSQYDi1vVUfONgLSLT/4NXHqSilGNcwzo0uVh3IUwRXBt6Yqhf93Cun0oz9OJxOpbMPIfYPU4CR0IvviyQ8/7t7uatpcO/XmxDGRFWt2NwaVJLAdkyU+ujG4SEYnv8DH+LG1eOxVz/5gAJq4oMyNb1RUsxleJTeUFaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kvbbJ4SiwHiY1oUFlbKkId4NRRP5cFPol8QdflYmVY=;
 b=y01hmN+RT68MyA1lRhTdwprJPoFdJLrdEXqmjwllGaUa4HNBi++4u7ZEnW/EuxV3werpnj7HuwX75KjaoLfPbECe07a4twliCvzhiWBf1wxu+2yRgARbtLHk+y09pOgwPTp2rmE2Lw9aL9lPIBfceZvnPRZWl5JvHBAdALMx/Jk=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB4839.namprd04.prod.outlook.com (2603:10b6:a03:14::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Sun, 15 Mar
 2020 23:34:46 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2814.021; Sun, 15 Mar 2020
 23:34:46 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 3/4] Introduce the function
 _configure_null_blk()
Thread-Topic: [PATCH blktests v2 3/4] Introduce the function
 _configure_null_blk()
Thread-Index: AQHV+xb5BsC6zEG8MECFyS+rQdxvQA==
Date:   Sun, 15 Mar 2020 23:34:45 +0000
Message-ID: <BYAPR04MB5749B2C4B4E886AEA73936E386F80@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200315221320.613-1-bvanassche@acm.org>
 <20200315221320.613-4-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de1c3be2-00ce-48fd-81b1-08d7c9397217
x-ms-traffictypediagnostic: BYAPR04MB4839:
x-microsoft-antispam-prvs: <BYAPR04MB483918A7BC10B610B8FE4A5A86F80@BYAPR04MB4839.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0343AC1D30
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(8936002)(4326008)(71200400001)(81166006)(81156014)(8676002)(52536014)(53546011)(6506007)(2906002)(186003)(26005)(478600001)(66446008)(66476007)(66946007)(9686003)(64756008)(76116006)(66556008)(55016002)(7696005)(5660300002)(110136005)(86362001)(558084003)(33656002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4839;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: azXvMJHJ5D1B5UjPaac3UaVKEkOwzO44og1k/zOSjKka2V1dnP78wNOFjSHn2BpBqz9ksUND94r0T3kSTdXf6qF+in/aC154aD2XoPCSX9xN0zmbnqKfL6lzymJUiQxNVkD/lIkdh7D0oMIX7t3psawGy1Hio5c9sHR5PXlV6ov5o9pxuVjELhiodcW4DwdwH1u64YNDZ6ThBCxl8JN++fPVWWMSH3K2vTMDJOtmtR34AJp3CphXlKJS52Cqn0JTorH1hnzbT24peZLxjYyueI63hNEpP0T0nZqXf37LciOx+9hWfmYWBdBVTpb63VKleX6pZQvztA+ERiJPMMH0n17cNDbpCtiSpQCiziT28r3K0Jvdjihz2IKnEXWLu3XE1Opu9SLXhXpfRQLu/KOYaTNMBDy0j8sf4LqDGl86GrB7PsAmGb4YtCOODddmwuRO
x-ms-exchange-antispam-messagedata: FZCOOuS5yl8gbK9WPYBJqwDp1Cw16usO5bCMopsDWmAeriZz7LjMm+QkDqw0JsZ65zdBwfdDjP88xBjivwVsTymU177BEtvEgeb7ASs7bdaSvZxm11rGZygV1+T/uchcJ1gKZ+0UpLIbD86eTTCSgg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1c3be2-00ce-48fd-81b1-08d7c9397217
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2020 23:34:45.8577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pU0rlmmLLpHmoJyMZ39ZFMY4Q9Faj3uS9n0ytXDLSD7vk6AiX2zen8YvBBxIUedbbB6gknYqiRLPx59B/mvmtc12sV/2VSDIoKcEA81vtzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4839
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

LGTM.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 03/15/2020 03:13 PM, Bart Van Assche wrote:=0A=
> Introduce a function for creating a null_blk device instance through=0A=
> configfs.=0A=
>=0A=
> Suggested-by: Chaitanya Kulkarni<Chaitanya.Kulkarni@wdc.com>=0A=
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>=0A=
=0A=
