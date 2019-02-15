Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D97C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300962192B
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="meryw+G4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="H+VUF0AV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfBOCwJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:52:09 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34574 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbfBOCwJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 21:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550199129; x=1581735129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yVRR9067+1/ltO4lLMBM8uNj5jwiq4vZxtlkFgR3HQc=;
  b=meryw+G4WtHVaDF9P3LHxlRXg3KgpNfQeOX1ojEQcKTlDXyWnqa7uxuU
   br6hIOghA2nk7ATc6ALH1NqscQhwdr0SO/2+QUxmEBCx3lJAhy/1ER+ar
   ynGRgO9aWOKfFwa7WUQRrC+EqX3X/CQPP7Qt4Tb1WtZd4D6xPxPUu37Lr
   10bk7kAKTLDxgJuj7blFiPcUeNjdoNwc18Zg6wWW4SiJmEmMWTxbVxZVP
   mzB1ZjhKusJqRzen0LurCyeB00v6vDM4IAo4dz4Uq4WjMSXppxeDyVtAN
   qJQPzUzxmvY2QFQineA0EC6seR9+hVcFRMCPmsbvbS5fTOoFHrtr574kS
   w==;
X-IronPort-AV: E=Sophos;i="5.58,371,1544457600"; 
   d="scan'208";a="206483152"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2019 10:52:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVRR9067+1/ltO4lLMBM8uNj5jwiq4vZxtlkFgR3HQc=;
 b=H+VUF0AV+tsK+4RLSzEQ3Pqfm+gbWI8rHZj2TiHqHytApJ8PfzocmF3t7uMaXUr/bSvWG823Qsy9KVkl68Kpp2M32DVUIuXG60BV3xOqWsCeH1TcT0rkSsGS6+li++DgqcwNiikup0EKe9L44xSp4C5CcsW8ZVFVebZ7nIPbh50=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB5720.namprd04.prod.outlook.com (20.179.57.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 02:52:06 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::f827:c296:5af6:c2f7]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::f827:c296:5af6:c2f7%5]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 02:52:06 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM TOPIC] improving storage testing
Thread-Topic: [LSF/MM TOPIC] improving storage testing
Thread-Index: AQHUw8cWY/Lzvrp1zEiECHyARXLTBqXfH/CAgADR54CAADaO8g==
Date:   Fri, 15 Feb 2019 02:52:06 +0000
Message-ID: <BYAPR04MB4502D20C28D486AB49CFAE0A86600@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190213180754.GX23000@mit.edu>
         <20190214105507.GA9739@linux-x5ow.site>,<1550186783.31902.81.camel@acm.org>
In-Reply-To: <1550186783.31902.81.camel@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [129.253.54.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61040b26-4e9e-420f-856a-08d692f09270
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB5720;
x-ms-traffictypediagnostic: BYAPR04MB5720:
x-ms-exchange-purlcount: 2
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;BYAPR04MB5720;23:zcSzlcLYc8ihXfoLQXWRxKePvgoKqPBGKFGrLrE?=
 =?iso-8859-1?Q?k8NvKV5ebYMnVuOldPRUblEGo1H1ETj+KEkMtYoLX5e1cBp/unBOwjLVWA?=
 =?iso-8859-1?Q?6B+zzq2us+9kaFcNCWxnYWLVEoopb5LjFW8ey47ByVhTlGUrLw8Oo6SZMo?=
 =?iso-8859-1?Q?fGxQ/c6mNWneq0KMMR7sdETkkKzbajxyrjexoUE4xUUq0fRqBT7E6+uFAJ?=
 =?iso-8859-1?Q?hkqQ1YGAAyeUB0VxFMhWF78bq3jNqdRZTV/vF5fPwP+amOL3KVCni0sDOM?=
 =?iso-8859-1?Q?QHeI1rdIv9/7i6ING1i7jn2r8bHASyNNLPbh9ArG4WT+4rnSkpHAgQtVNi?=
 =?iso-8859-1?Q?Qg2rlqXZv4Hz3OZU1IRl7tGltN7q0UxL46kw5MS/aMSUHfMgeX7luLcT/C?=
 =?iso-8859-1?Q?vLzN1jTwJULX6KZItBiPbw6TMuVKOTOBvVnGvUkU6vVYqLoNh8Z/3Gs2dZ?=
 =?iso-8859-1?Q?RMIFTU8FvZGE5g5zJ2/qQ0Fo2d/44Q3Zi+e4rrlVVYUuVSmLwOblY4QOKu?=
 =?iso-8859-1?Q?G/uzwQSCIKJ922dvaJcqnPMFdrfa48u7SBo92lyLVLaL2NTVIqiKi/2u4n?=
 =?iso-8859-1?Q?iZKWrD3nKDlh4sf3/clW9HfWeDge0l5r6b0G/8/UGcsZ6sI6nGEynm7LO7?=
 =?iso-8859-1?Q?+8gojU1JrLz1HZ1QmLUE0SyOnV9B9wDcjUEFSZBVa43J3ehoL3Zsefj6EN?=
 =?iso-8859-1?Q?/30xvpkf7b1ADFUFau7Bh7wx+biJTkInRqgfG+SIHFgL0bfygXpMZkIC57?=
 =?iso-8859-1?Q?qRxhKn6F8GFCe92EdEDfnywJjflT+Qo1I/jPvMi0CmhL4w61KWYD3s4Jgf?=
 =?iso-8859-1?Q?q4LdDNhujYctNtQH8jUTd/LAbMbubWYhPyBS9mc6WDbT1W9hQBGiJ6Omi4?=
 =?iso-8859-1?Q?rrzV4o/8p4kZ9ZQnaLI9+sjP9Rm7UNPG2tiMMVYHNjBUQCRljz/twwCHwc?=
 =?iso-8859-1?Q?uuF84YpMJwsJtErXELp1IS/WP8PCQAdJwFj4QilutBHeAHKuawhgc5gra1?=
 =?iso-8859-1?Q?k5jUJih4XgB5lw2AZ0RPYUgJopgwK/tza11yR1ZUtCIMxfZTiRAULW6Hzn?=
 =?iso-8859-1?Q?DaXweI/Hd9SdaJaHpaRUWE8Jm86He7Xw4I2LcNDQWslJW9nZ+izyy+jEJn?=
 =?iso-8859-1?Q?0aGENiH0MuqXI/Qq3en1VdYKq5QBsrKzeW/n28U2kZDP8yXUtWre/pEXjH?=
 =?iso-8859-1?Q?mJPLR/7WzfyuyKg1VK7Po+QlZNrPwf9yzLZvt9/KQkJXvLXIStrRxRpyT5?=
 =?iso-8859-1?Q?J9FDJtX294Sz8a5ktj9WRYuniQvAwdbZx9cpMBWo+sgBTdXBg16FO5wWqW?=
 =?iso-8859-1?Q?3U7L437b4nG5IBi3ltMxunVUV8g/zHbCEgYFeMDmQ3Evg=3D=3D?=
x-microsoft-antispam-prvs: <BYAPR04MB5720178185591D3E2A0A0D4786600@BYAPR04MB5720.namprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(39860400002)(396003)(189003)(199004)(6436002)(186003)(74316002)(25786009)(9686003)(476003)(53936002)(4326008)(486006)(966005)(55016002)(305945005)(33656002)(7736002)(6306002)(6246003)(6506007)(2171002)(72206003)(478600001)(14454004)(26005)(99286004)(53546011)(102836004)(105586002)(3846002)(7696005)(54906003)(97736004)(446003)(2906002)(11346002)(86362001)(76176011)(68736007)(66066001)(81166006)(14444005)(110136005)(229853002)(81156014)(6116002)(8936002)(256004)(106356001)(8676002)(71190400001)(71200400001)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5720;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nTQuZvm/84vd3t6We+SprKy8p+518z0okhcTOIpc33rlM4h/sU0f1o+LhYMWJ5s6S0oBuDErnvqY0AYVN0/Gexb5yIH31b2ACpswo6AyN0or8cgq4W5PQnYPEQ0k6xqqfNclhlkAlbep4xv6yFWuIQ747MhUCDNq0Ciid7TJ15IWHR40LQJOm+ql1xOnTv5+GnxnvvdeIwRuXZUkSIKbs+i8oopKWDEH9w5rtp51hMcD79gzEPKDQZEiFDBflvVL+4oTHSLBVEqAAa6tZYpJGoep5f6AEvs28C9Th0VfLsnjKcT8xp+ibtU7TFsBBTALk/nemAbFiIjXRJBAv+nGN+9BHmFmm0aoEAevrAivi1az0Noxl37+n/oGSeLlf0y2PNqcieIiQlZaPN6oT6obE2eTHxhh+ny0S6QlZb7odxk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61040b26-4e9e-420f-856a-08d692f09270
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 02:52:06.4957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5720
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Bart

In this way, we may end up modifying probably most of the common tools,
which in long run can create a bunch of the code for the tests. If everyone
(test contributors and tools maintainers) agrees to have such a "test" mode
to all the tools, we can go for this approach.

-Chaitanya

From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org>=
 on behalf of Bart Van Assche <bvanassche@acm.org>
Sent: Thursday, February 14, 2019 3:26 PM
To: Johannes Thumshirn; Theodore Y. Ts'o
Cc: lsf-pc@lists.linux-foundation.org; linux-block@vger.kernel.org; linux-f=
sdevel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] improving storage testing
=A0=20
=20
On Thu, 2019-02-14 at 11:55 +0100, Johannes Thumshirn wrote:
> On Wed, Feb 13, 2019 at 01:07:54PM -0500, Theodore Y. Ts'o wrote:
> > Also, there are expectations about minimum versions of bash that can
> > be supported; but there aren't necessarily for other components such
> > as nvme-cli, and I suspect that it is due to the use of a overly new
> > version of nvme-cli from its git tree.=A0 Is that supposed to work, or
> > should I constrain myself to whatever version is being shipped in
> > Fedora or some other reference distribution?=A0 More generally, what is
> > the overall expectations that should be expected?=A0 xfstests has some
> > extremely expansive set of sed scripts to normalize shell script
> > output to make xfstests extremely portable; will patches along similar
> > lines something that we should be doing for blktests?
>=20
> I think this is the root cause of the problems you've sent out mails for =
this
> week. A lot of blktests test need filtering. See [1] as an example.
>=20
> [1] https://github.com/osandov/blktests/pull/34

 https://avatars0.githubusercontent.com/u/5319409?s=3D400&v=3D4=20

Add filter function for nvme discover by frankenmichl =B7 Pull Request #34 =
=B7 osandov/blktests
github.com
Several NVMe tests (002, 016, 017) used a pipe to a sed call filtering the =
output. This call is moved to a new filter function nvme/rc and the calls t=
o sed are replaced by this function. Additional...


Hi Johannes,

Output of tools like nvme-cli is not an ABI although an ABI is what is
required to make blktests work reliably. One possible approach is to modify
nvme-cli such that it has two output formats: one output format that is
intended for humans and another that is easy to parse by software. I think
we should consider that approach and compare it to using sed scripts.

Bart.

