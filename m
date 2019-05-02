Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9304C43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 03:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF582081C
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 03:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KT6NtTML";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HvKJKGL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEBDnv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 23:43:51 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:16951 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfEBDnv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 23:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556768699; x=1588304699;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GgwqYnuvlZnAbZxmKlSVdxALzcQQ2nEIvG42jqIlMeI=;
  b=KT6NtTMLg3QF/m2FIkdMn4zXSxLzRI4/+u7k2OaZGoDZQ9ZPQWZzkKZY
   k6u7f8HmNrONNeB/LJKGYUCV6Xe2l2vVs9Irj3sfh8lVz9meuOVrvS8pK
   CKG5ofvZwM1PCu8XymGh8K/W7XyPFhAoqKqcBhQvIkPaFdTFVBhG2vF8P
   CrUPmV3OURohjsxiyfn/u5ZdUKZGedy3QI5+pA0mIh1tmt7+RRQQm0Ns8
   iQkZy0NCPDFE2U4Oo/+QNQ/5O2JyWs65EzwIrhODzOe+vB+HXWUNaTF2B
   +CTSOlIGmdcYEiEv9gCdHqVlgguRMer8lTQ6KDCRZNa3ooGVOq77ds+r/
   w==;
X-IronPort-AV: E=Sophos;i="5.60,420,1549900800"; 
   d="scan'208";a="206526695"
Received: from mail-co1nam05lp2057.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.57])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2019 11:44:58 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgwqYnuvlZnAbZxmKlSVdxALzcQQ2nEIvG42jqIlMeI=;
 b=HvKJKGL0VfcM2p9fjLtiqwSoArfrVprDs5t0nu0YhpggB1vq2S3GBu3cSOV2JJWN1FvjQOqSlE9zuOtwBWaKoHkxAMEKUqbEfyChXgY2S2KO5bI4s53V1kLua+zmrf7QMDWTt+ZDmzggpvfNtt55XQZsOof/UctrS/iDhAt8F6o=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB5200.namprd04.prod.outlook.com (20.178.6.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Thu, 2 May 2019 03:43:49 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1835.018; Thu, 2 May 2019
 03:43:49 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC PATCH 01/18] blktrace: increase the size of action mask
Thread-Topic: [RFC PATCH 01/18] blktrace: increase the size of action mask
Thread-Index: AQHU/9ZdvJvPcvuZYUKDMpYx85CQfw==
Date:   Thu, 2 May 2019 03:43:49 +0000
Message-ID: <SN6PR04MB4527BDC294F24B4954AD201786340@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
 <20190501042831.5313-2-chaitanya.kulkarni@wdc.com>
 <1556725711.19047.10.camel@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cf0c76a-1019-4147-0536-08d6ceb0634e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5200;
x-ms-traffictypediagnostic: SN6PR04MB5200:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB5200326DB1EB25E3B645E88B86340@SN6PR04MB5200.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(74316002)(76176011)(2906002)(14444005)(8936002)(476003)(256004)(14454004)(9686003)(5660300002)(99286004)(229853002)(186003)(68736007)(53936002)(86362001)(7696005)(66066001)(478600001)(72206003)(2501003)(64756008)(33656002)(91956017)(6246003)(52536014)(71190400001)(81166006)(486006)(305945005)(3846002)(6116002)(81156014)(7736002)(71200400001)(446003)(55016002)(66946007)(66476007)(66556008)(110136005)(66446008)(316002)(8676002)(6506007)(102836004)(53546011)(25786009)(76116006)(6436002)(73956011)(26005)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5200;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AmhWOwl3l6IKcuHEGaf4slTd2OgpvOEGqQkjXE2igxp6jW0nvIKSnsAb5JAINdW+/JADK276YUEun8QPfqiRzdaq8/W1Yv6CHmTgJ59ZSig5wCLmf3dY1+MU/e1FtLhvWIXBnZzq7K6UCXLxGJKfY0iSMXCjToJU9q4gd7FkeWZYNkxOQT4+HSaEOKsKUlw0h8Gp6fJoIqP+2/HzqYOdmaWh2BN+vm+Yg9MXAPVSpF1AM/2RDvkU8GcCVQflzoaWF77enwqwbUmo3FuAl4rFHlsz8q2fxLIQsZaS444xUnh08EGqEkWYN8eacMfWp3axuROKL+Y8qW/0K3MTWw6BOyk32uNtorPCIjO3murWjnGkBxl/6J6qGO7L6KdFV10EH6Rq5ftsytkNB1u4mIJbM8X/GVaqAdMM0vLmwQyIevQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf0c76a-1019-4147-0536-08d6ceb0634e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 03:43:49.2735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5200
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/1/19 8:48 AM, Bart Van Assche wrote:=0A=
> On Tue, 2019-04-30 at 21:28 -0700, Chaitanya Kulkarni wrote:=0A=
>> -#define BLKTRACESETUP32 _IOWR(0x12, 115, struct compat_blk_user_trace_s=
etup)=0A=
>> +=0A=
>> +/* XXX: temp work around for RFC */=0A=
>> +#define BLKTRACESETUP32 _IOWR(0x13, 115, struct compat_blk_user_trace_s=
etup)=0A=
> =0A=
> This change breaks user space so this change is not acceptable. I think y=
ou=0A=
> want to introduce a new ioctl instead of modifying an existing ioctl.=0A=
> Additionally, have you considered to split the blktrace_api.h header file=
=0A=
> into two header files: one with kernel-internal definitions and a second =
one=0A=
> with definitions that are shared with user space (include/uapi/...)?=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
I want to avoid modifying an existing IOCTL, I'll add a new ioctl and =0A=
update the tools to use the extension IOCTL and split the header file =0A=
also. Also I found that user space tools have replicated BLK_XX_XXX =0A=
definitions, will be okay to keep all those in one place and include =0A=
those from the appropriate header file ?=0A=
