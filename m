Return-Path: <SRS0=SIFN=YZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040E6CA9EC9
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 07:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E0D208CB
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 07:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ix7U1xWd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="curE0aK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfKAHmn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:42:43 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59197 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfKAHmn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Nov 2019 03:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572594165; x=1604130165;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PwIe7dRYRBgcETOZViDcgB2k7EFNaCX2xZh7LCgyDfo=;
  b=ix7U1xWdps+pyj3weNXYleFOccUnMEXc2Xg15DRYIrmer6uTjRNfo7Pr
   A8ryP1t+KvOZJ7U41T0P5oo5yvs2kPCNvR7KdJqC8TxdosFYlKa8NIGq3
   sbyyFPo7Eh57ShoowKWOGMevC9tvsimNyaZWZDx/67CNPFhzpQnwp07vy
   n3wOdk6jDaJkwzLuBnIDUUDuyS6Xozcws5jWUkyWDNJII8JF13f911P3z
   SWbgZduruScUvryAJpkQwVnTh26etevnAU43diFng/OQKymq5hnUjBggy
   U0MX+6C/Vu84D6D2WmP2uC+vojywpMnRqa4ShvA6OpxmHYi/g37G7VYgC
   w==;
IronPort-SDR: IuF1Dc0bwhF/xY6YMEaDF/YFOIJuDsNQxAMquxRFnoxcxKr6vXElnbymL0znOd7pwr07Z0BUb6
 uGTNIMH1oqVbgcpiXPkHeefHNkj09lEsj5lf8JR4EpvwydrPqkUSOriFXGz4eh61h+3gkw+CPW
 NVauCcH4xGqQsKyQG44T5j+x20G75x774IJr4v6VOCr+sItzTuPYLkJZAJVJ/I5uZoB7AkWrMd
 bg6YHTrQNTH6M1Lsns3Cm4Su5vR6eUG/3mk0gi9MpFxkX1aUXnCM+0Yqi577bf7ZeCFlTA9WMY
 u84=
X-IronPort-AV: E=Sophos;i="5.68,254,1569254400"; 
   d="scan'208";a="223032493"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 01 Nov 2019 15:42:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alYQ1eaPpY3DfdS9eYVxOgS1N/YTlT8aqXaDoPKeXf9e8rF/OYS0Rg9LOKJC3TVW5VrPDuAgTpN1sm4SMfTMKCuWiX0A5EDOm3DCXx4q2RSqfVJ3gfsVnn9LK2eILkbJjhoiQ+kUjzsmKftFsLf+OAcpyRAjyLRfDEmoh2/botY+NxkSCrIPCKLS6dBsVQbKUe2Wz/nAjbiyuGOHhfCIo3omGM4MtNuI2EFivvlyit2qRTcij4iEnq/1JL4RIrP9PPShcQsOGQVwWhzkNnu3ye8WY+9PZP6wdv6bdZlpDA2Qld/tkhR5OYmEBXN7db0BJeiC3pTv2/vmHAy+sB8t2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwIe7dRYRBgcETOZViDcgB2k7EFNaCX2xZh7LCgyDfo=;
 b=HszdUt+rhw9jvH9LMrN32c8S8JfhzA+ETYJczEQWMETJf3yHmBMr//PMZCL71ulo5NjeuX/93qF804PbrIH9jrrvvyYk5qda2M5By6ZzSf8CSzSdV2NtYZ+uk8P/Ib/rabE/GlZ/aM0i+gaMm94hreTpsehvyT98cA8+cEzQusQ7s3/YQwet4gxMGJq1/hQrfKEMhihU+DCd4LCWTjR0a7ytOvK8sBOQxDWt7/oivpcCd6n5uVUoVQVyWWe5rwIG4Yhs6t1ztzOBh2vNZ5QLkLcF73yCK31vJBqLULMVRHB1DAeAA4piN+GPbDXdUOCYKFKj2MhviC0m3Mc4VIs86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwIe7dRYRBgcETOZViDcgB2k7EFNaCX2xZh7LCgyDfo=;
 b=curE0aK00RCoEzseXAvH5EJjXUJKPkiWZU81eYCEWAy0sSFKrA8P6dajI4uziRDunTlHcq6MNe/u/Y0qQfnMpx8mskMvSBAbekYOTD84zmMHTi0m6n7msXmDgupWdchQQIUaLCX+mSTwQc+EhEaA6MO9EjATg/77oiMNpTgp10g=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) by
 DM6PR04MB4108.namprd04.prod.outlook.com (20.176.87.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 1 Nov 2019 07:42:41 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::65c4:52fd:1454:4b04]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::65c4:52fd:1454:4b04%7]) with mapi id 15.20.2408.016; Fri, 1 Nov 2019
 07:42:41 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Omar Sandoval <osandov@fb.com>
Subject: Re: [blktests PATCH 1/2] nvme: handle model attr in subsys create
 helper
Thread-Topic: [blktests PATCH 1/2] nvme: handle model attr in subsys create
 helper
Thread-Index: AQHVj1uq6KWVSR9vcUi6kuvCeP0e8A==
Date:   Fri, 1 Nov 2019 07:42:41 +0000
Message-ID: <DM6PR04MB5754FD5709BDB1BEF52FDAEF86620@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20191030195258.31108-1-chaitanya.kulkarni@wdc.com>
 <20191030195258.31108-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 177973ba-4969-4176-f2fc-08d75e9f134a
x-ms-traffictypediagnostic: DM6PR04MB4108:
x-microsoft-antispam-prvs: <DM6PR04MB41085AF8F4740E711E40DDF186620@DM6PR04MB4108.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(8936002)(66066001)(6506007)(81156014)(7696005)(81166006)(26005)(6436002)(2501003)(256004)(102836004)(74316002)(316002)(53546011)(52536014)(229853002)(55016002)(9686003)(8676002)(76176011)(478600001)(86362001)(14454004)(486006)(476003)(33656002)(3846002)(110136005)(5660300002)(25786009)(4326008)(2906002)(99286004)(186003)(76116006)(305945005)(66556008)(64756008)(91956017)(558084003)(66476007)(66446008)(7736002)(66946007)(6246003)(6116002)(446003)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB4108;H:DM6PR04MB5754.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JRh5/vOoDxeD70Yq9oB2DfDjScbqCRVgm5ZFSNWnIsgVy2U2JwRf/uj49t0df20WtR61qMN/NCuxhEic9dN5UYtRuZAahlkkkz85KGtkrkDFDVsjsNl66NXtbt2DTdNvkIcbWhu92cV4mfCqrxTDB6ORfptuTTRrwy/FupQuuS2DNrhA/n9MnHaSeaGm244Y2+Vj8774vLj8xFjVopYjq9PHh6edmO+2D+FPvWXXLSNKNU4d9MNLN6qA0MC+USBsZt3Jo1eHr1hUm99lhCPWNBMgzsDIuwcws2NAe56PDpseDnXi1uUM2Clz7bxeua+9YHyybWWqUwj/J92iVw23NEzi4mN/r1tjMVjjmBNaHWWMS3pMeGtOwA6J4iZTnowP46GIyv7DzLboyLM17gc1jmVoL+9oLc/r9KUz+M1p6I1nJiGW6nVRplQanD91eJHL
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177973ba-4969-4176-f2fc-08d75e9f134a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 07:42:41.1545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzcMtLFc8B1D+bSN42VHZubMq7EwM6tF8xHp2ugo5NNi4jlKQeWRIRDLAynMoNAHhZri0BxHZZAhfHVAMSo55AR7tpqwChvdiwxYE2mIOH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4108
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/30/2019 12:53 PM, Chaitanya Kulkarni wrote:=0A=
> This patch allows _create_nvmet_subsystem to handle and optionally=0A=
> set model attribute for the subsys.=0A=
=0A=
Will send out updated version along with kernel patch.=0A=
=0A=
