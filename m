Return-Path: <SRS0=t5dV=4R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C6CC3F2CD
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 23:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB3024688
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 23:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QeHGtUJ8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TTQCGI1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgB2XLJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:11:09 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13039 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2XLI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Feb 2020 18:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583017869; x=1614553869;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2cTa5DanBVmmClHHLKS8sbC+Rr+Tq5NvOfnlxUyH+7U=;
  b=QeHGtUJ8JANL7XSX2GGyUfNYIRm2/ubkrc2NYI92WVMZhwEQSyvavwsJ
   yMFKvm6FJLUV4QA/A50Z/B1kA+0e7zXyhmTUzEnHGFal0lyARyyHeKWm1
   coijP0DROv1gVcnwfZOTxn8Oi55lFTJ8gJrDw+Bh6KxHAXCNV5s3ZNEuz
   gOFU5x0arkL825NNhVHKXmzxJ++WfwoDN0fSv55emsBKFrdKqFlItOx4h
   JP99JGoSdZD2TbwP9t96O2YAito5XtyqeR84XvN8q5emwZxPTGP2JBqpe
   AsnruQx9blzkQacjbGF6fV8FB8QwPseCiRuqwFlEzDL9DgMvkAYDUgIVP
   Q==;
IronPort-SDR: SQ2xfBmMKnJRfdJQv95mI26R7OGs/tyAl/6xeSGSzJoLPTgAV6ura1s8JK09wkpdzDkZdWY+aa
 /M9dUBBjVQX0S/pY0F5XNQ89lw9bFqN9llIDhaQ4mgmlhddVF/CynV0JMxCrNpyZpQ9dFyixIp
 MNhWa1PJrUpF8bV0gYTHyFZ550o6jn5eRdDaPklZwZneuutzGkAbN0lsLYX59ODlp6QZuWhkCf
 /BDNk4EmqSKeAObCQuHxRcfWhdv5eFs1tVCVYSsZBsSw7eJh1bvtMWrTHUVLlDN6PCX/PV0d5p
 7VE=
X-IronPort-AV: E=Sophos;i="5.70,501,1574092800"; 
   d="scan'208";a="132524476"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2020 07:11:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUnVzyZAo4c24FO2j5TAQJdGNH4KfhF+JInC4yBpcohpxp5HmyRco9YNfX6LN6PRhdqAMiV6Jdm2E7qFotaPn6xS4YqaNie+s0gWi3TWE2G5gk8D7kFmXzR8HaZLFddpzedulEToP15/0bqUpzDhVaNhBAvh6FlfLNw+Rjk51vLPJlvnrtYLa6NgWI7AHhWZWPrq+tkaS4xVIrk+N04/ZwcpuDimyak3XQJbHfVlz0RTH1UcS4jQIDXBkCmV4QQM5iX3qvAcElfWv3bmvC8lLePyLO8VzHOTfsmgcV+n7vzYyI2HYL+B8jeEJrjxV6VpPrIan0HZO+vLQypcVIOXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cTa5DanBVmmClHHLKS8sbC+Rr+Tq5NvOfnlxUyH+7U=;
 b=Nt/eqt+Qv8K/sg9EfM58iKnSFtpgcAQFyr6xt7iFjPdV9X74zyEPDA6irpL+QcbD7Ut5tZCZ2n0RAWJFY1+1LlixaLad7wgttFzmC/mriEWRwfRLHX5Ue5j5Sho0FbxbkBCxTHLUB5EvYVmQUHVOznjr3soiCfsn59MmZVAsIfUye2thkYIdqqoNw7LkI72/SIO8O0wsfBsSn8iEE+V/+gtgfW9ksanGnlQiGIwNvdVJAbU89lX5mlCm8+CcM50M5gOdvI443NBi532wyzz3hSRNxibt5KXUsHMpDMCTz+ZP8AxtqutkOsBfT2zx4SA6d0b+/mkMOdsvx2LxLG2jpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cTa5DanBVmmClHHLKS8sbC+Rr+Tq5NvOfnlxUyH+7U=;
 b=TTQCGI1xgzoOJDK/Z6sndzp767Doeb1HOaAxHYmATg12QopRjp7WWXkIBWrVIjJsDKdu7FR8m4B9My6WHim4Yn9S/IPu5cCJmezUdLiwwnfT/q+HPcEZNs4/mcnzUPuoh0q3HNLruuvZ5cyzU18P+tIjKpbRUXlF9g1C0/xYj6M=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB4568.namprd04.prod.outlook.com (2603:10b6:a03:16::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Sat, 29 Feb
 2020 23:11:06 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2772.018; Sat, 29 Feb 2020
 23:11:06 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/6] block: use bio_{wouldblock,io}_error in
 direct_make_request
Thread-Topic: [PATCH 2/6] block: use bio_{wouldblock,io}_error in
 direct_make_request
Thread-Index: AQHV7kihHzHE14b2+USAUy+Ztlw0Cw==
Date:   Sat, 29 Feb 2020 23:11:06 +0000
Message-ID: <BYAPR04MB5749C71968898BDC98B714B186E90@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
 <20200228150518.10496-3-guoqing.jiang@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb0847bb-07ec-4152-5af4-08d7bd6ca7ea
x-ms-traffictypediagnostic: BYAPR04MB4568:
x-microsoft-antispam-prvs: <BYAPR04MB4568D5B9E9821683774D958286E90@BYAPR04MB4568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:311;
x-forefront-prvs: 03283976A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(52536014)(5660300002)(558084003)(66946007)(55016002)(53546011)(110136005)(8936002)(6506007)(316002)(478600001)(9686003)(86362001)(4326008)(186003)(71200400001)(81166006)(76116006)(33656002)(81156014)(66446008)(8676002)(66556008)(64756008)(66476007)(7696005)(2906002)(26005)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4568;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5YjlCvE6qGM/zQzX6Yat2jUJv4Oub+KkhraZ7Ir5ISAds9zmEsef/1dVc4ShUGOSwTPctnlWOJlRGPWLG3XOgzeHUl3ANvJAl7R66DnV2rH6gA34Ps7EBrOJogGHQb8aBvCAA1F0TPhoDIR2EhrAb+znSEH0tOe/e972tFhYIFB9SY5cMh6ICO8vdcb6BXz0A/Bxb5+MzUrqS7m3gKaKr5gxTOA5xFWjyRbLSThom/ehXAIA1wKRsKHakMETlY59d3f0MY0ldtCX0CX5Yvf5V/0mrZHwErS99odEl/xuZOMurSvJXyYHWh79naiOI9PsiJGJ2PoqQUhgxIBMNMskLPcMEjJ1xJLsA0rLGF4IT1CmvGh4yYshBVgkkedQrSlVf4EwzVkSx+ZRsFKQnQhsn9CwJcgmbLDK+6nFt5ggbQn0y3dcERWBcXoho7JV+eHiP4cNx5C6fwrd1EYWRJvbkfYcusKaC7cshHO8/dZqPbnQ98qrYQoAw8x2goTMBRhR
x-ms-exchange-antispam-messagedata: mvJQb3I7nmR/XxjdsPDI0PNYONXZM7Ai5BkdQOgakLFrdhARlvT5jTXBK1h/2YPWKNmpi3frbYrbopchbkB6FV3NiLYJZjFEy9AhfzhUcKkZ7WDfM96DGzTLuNkxcMgyyTzO9By1N0NSJNsfKXj/2w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0847bb-07ec-4152-5af4-08d7bd6ca7ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2020 23:11:06.6616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uo3w9XYr6OrKfIS/idaqnYRJ0W2DmcKkJAea5uPNnkchMbM7YFYRQentRuXRjOKK4+fb4UBBRlxZTtVNP3/4mbTyjUEvpa/vChdYQSP2liU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4568
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Neat, looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
On 02/28/2020 07:06 AM, Guoqing Jiang wrote:=0A=
> Use the two functions to simplify code.=0A=
>=0A=
> Signed-off-by: Guoqing Jiang<guoqing.jiang@cloud.ionos.com>=0A=
=0A=
