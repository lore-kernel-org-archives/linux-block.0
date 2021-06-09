Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93179C47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 07:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C09F61354
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 07:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbhFIHFd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 03:05:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38827 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbhFIHF3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 03:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623222214; x=1654758214;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=aaB/y1M4F/CeagVe+uy56nN/wgGmeMJydF2N+7Yq5OT00F/MyHFp8awF
   d07FeSYLpqGdqAGmJNp2rC4mjSK0V6mPKb63GtdB/rF7tKL0C2B8MCB6v
   x5weNeIWylvZPZ84Q3DTiJoVinS2l4UmQgDal5ZgBcgchrn4c8TpdslKW
   IpHpaMtIDwzICeJXl3sqQV/6YRF72BhU8HGjQZh/EDUkHqbwr3CgiK8GC
   7toEGCDgAAgbQ89LMoJrjf+gMy26GrBDembUrDIRkMy05tAo9x2NAIivU
   IYnubIbsyL9L9e58l/sclWt9vKIaxqNwD8dLKnKJlTfdo6g170Hzn0d0F
   Q==;
IronPort-SDR: scI6i69FfYQlHuwg0zJve9RA2u6dysEzqJiUNHQNzu1VY5ADkGIXTy1HwoOcWZyVc/2i3AC4D0
 pDzHXCyaTPL95k96ymu68Maj3KnA8JQLdjhZrC0rgod9Fcmi1wbCUzV0KlXC3Ix6om76d8Gve8
 p7MIEv+q6QoDOyvzH5+2UQ/BRr3BkKRrXHBryvzZZ64WBj+VnGr0rGnRNNjY3WJ6BNCvaWw7SV
 Lym8iG1a9bVcMEiXKSWW/NctWAOcVVEkO2MK1Y9EqbJJRRMtPmEQ8zmsvQmUltwWeXtzzKQYIF
 apI=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="171264536"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 15:03:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5uyCMIejUoUfKrBTgLC6JTV9TQNoyoT0Dko4qYvlwHSCy824uEgMPjB4N9Qh9SiKn/WxIBrXJKpHGVjUpI6yCCiBEZe0CWfl+VtTRuL7aHj+2ePplL/3oXIBLmhrYsRo7Go6Sq9fLmDn2jVYktxvVBFNsIf7k5Puiqi6EDawO2CwJLZq5gbH/+N/fCFFm/X9UtsY3atxI6doT7Nz9dPxMewHPz3rIDjc0eqwrVP4wu9s0PM8P4XwlzDoJfgRuuX4yYIkPAVTYRAQLaOGqXeKj9bdI/jycgvfZMEsbsFTLG/Zx6DeL9Bm0cumhz0Y8RgAqntWw8DHV6lR91OH96d1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ShowvJ042iu4SVxmDcZDuIlhAj9g2Ls/mmF92bhv2iUGJlNaBTdRGmmgBmCJH/Vwaa8/4RhB9wnAlekFIa+IASMqGkCSFrI2ae4U0OMMRlbsxWbXzS/iqIaG6QazRkT7MVvEvW5wnSjjoaEqqQ/my7VcFnAmlacYc9TEnRr9xoOfgc1PIGLmwFyouXMrMg1CSO/sNm2ha8T0ZUmbfP8n4JhJGuf3J7X59YjAqKcVkOE5QiQH2lO0aMAzTykgIy6Bn3+kARL0VlSHkJ6YxPsGeKn4iwbshwqcxGxav+GeVQLQbEm1SJbAEOqNJWsOJ1hAFR7KIiJyT7ZX7aYuWnFleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=KD9JWwrnIedmQ/2zT1hrq8e/Bi2G4cMfmtWGne6wdp5rVytuTnVk6QcHLCJRbmGNlep5x7mudZ4QYY7I823fPWy+cEbiL7srWEKu9nup7mR228R8BLoFcK8bw3F65IHcOADAuM8eOgTB4VuqtMI8WFRYj0Hw+6A0aynxL4pRbu0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7173.namprd04.prod.outlook.com (2603:10b6:510:16::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Wed, 9 Jun
 2021 07:03:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 07:03:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 01/14] block/Kconfig: Make the BLK_WBT and BLK_WBT_MQ
 entries consecutive
Thread-Topic: [PATCH 01/14] block/Kconfig: Make the BLK_WBT and BLK_WBT_MQ
 entries consecutive
Thread-Index: AQHXXLsSqmAmc0QCVUSJF+LFlDHSvA==
Date:   Wed, 9 Jun 2021 07:03:11 +0000
Message-ID: <PH0PR04MB7416AAEA3C96233C1119643B9B369@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:2906:41b5:83cd:3a40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d636cf6-bd59-4e26-f7a5-08d92b14a535
x-ms-traffictypediagnostic: PH0PR04MB7173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB717375C17CCDE7ED3B7A56B19B369@PH0PR04MB7173.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FbFSZ/wmic9akQ17iIt2q5uW3uQZxPSEDhmqDzoNS58YnP+jNC2olHzzh0ne8856m9nz3e1YZkEprgq+VwExTQrj9Qn/slcPJ1gm5UvGaV3wWH4eXCIlgRUUiHr5ffFs/h/Q86Je1l5STtt0TeYdB1TUhlZxnW4BJ562lwtJZ4iQXCeWiL+jsOl/QQV7mEZikKMurFnd2btqvMefL9ZzCJwWvjHc9p/r0MCic+WACm1Q391ClyoimJqQsu2RKCIPd6l/6RqGMfuQTuweG0dPX8HxuuePeer3b0ZFg/fZQS5upo/olfkBJ4oswDEnFcLgUDoj4NOYoPvNUZqyDCzPMFONnwUAxYeTI6U4T/KbXP344glpZ+thoMjaRrKuX+vclFn3r4qugz1jEvK+CAN7Sqhk3azRub6zRGVPrEXWVw2Q0Z6cxenxHLmHxcSNX5PLeoEjbvgBODbZzByye3rJy6f89TyRsj43JtSjRIDf+7157nPp1FuA/OuE0P8Ek6HGzN+Z2ynKw0MQUv54K6hmjQP183RhQh1zdJn+US1xbNv2dM3/rfe8ryvEq6CIKalcgtcxGhMm2d3FewEcdCrcpfzcHLg2tnSyIfYUFqBMVpo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(5660300002)(55016002)(91956017)(76116006)(478600001)(2906002)(7696005)(4326008)(33656002)(4270600006)(71200400001)(38100700002)(54906003)(86362001)(558084003)(122000001)(110136005)(9686003)(8676002)(186003)(316002)(66476007)(66556008)(64756008)(66446008)(19618925003)(52536014)(6506007)(66946007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W+CtAonrT6Vb9iWm4QoIA7bOcxDv0A16vlLiY/wyJ2wrsE9BgCIO8f8aw4Kf?=
 =?us-ascii?Q?BM1W/4dGe0iE+sWKlnTWbtUYS53gcBPqCIiVrYt9vdAzp0PZdpZy5Z0iZ7Zt?=
 =?us-ascii?Q?cWOWGGNHtuIt52sOGp6IsKoLW3m5fo0V4HOaQpAb0u7ELRoJD6M/NVwgWPzB?=
 =?us-ascii?Q?HwBgAd1GxaWwwlWOa9ag964j165ckdBA79EheXiJltGWLZXeY0EUcTEwOFCk?=
 =?us-ascii?Q?vAXXU475p7wcH+awTBqe+DwBsxrcJgxtP9u0e9K4okMYXnJarfuW5R1YIXYv?=
 =?us-ascii?Q?Rcbo+XFNvJMhMwNxy4N5upC+UREI3LMuZj2egzV+OOX1Zwy8ZHrt/tPnr2xd?=
 =?us-ascii?Q?kj+H6c0cWkYIJ+1I0jZD4usKtpFQxljlRC5q8dsWOtehOiDNLJJ1kqjoVI+D?=
 =?us-ascii?Q?eg5nddFWyzbDOBvrgRRYqm5ln1Kx8EhV7wrn0WeiOOsGvi4TX3VCIK4b69Gw?=
 =?us-ascii?Q?bzA/LPudK+N4LQQrJTh8tiNaXP/G+b/g6Z/cD5SGTDO6qn0e5tcPUkTbnzsu?=
 =?us-ascii?Q?GGeXxrnYqEBXHgur92cjBU+U6yItt+fsNqwTu7HH+TK+E8Z5Gjkf3kS07tRO?=
 =?us-ascii?Q?x2PXBvc+K9XNrNSUX86ljRupZK5vUUdZ2Gaa/WMaqwIyJCrGeTgXzpQvAwIC?=
 =?us-ascii?Q?dmVjz7GUGYZ/d3y5DlWrShlixF8tX9nRMywotPVUSrbb1Y6++PsIL0iwo4PU?=
 =?us-ascii?Q?ttpCxmyWFSgVUGUJBTcaKe9IhKgKZvKp4yfwRySIgOGbAuUpMSQK+s/aIJDQ?=
 =?us-ascii?Q?RBd745ACQT2faVSLmD5+dVv/Ofa5uceKSlQBhboLacfUmzvbO+0ou9tWgWX5?=
 =?us-ascii?Q?6ICyNnUg55XZbZ1TrD3s/Xmrt7A9xaLndInAatbZ3+VXW60taCaFrtUIsHgs?=
 =?us-ascii?Q?sFMCqXF0vu4OfHuRA3hLZhuekWmMO0yFZje9F6ZLC7ZbwTApeLDPWHmowhtl?=
 =?us-ascii?Q?Ixc0OBa3JHIF2rqRDbTsmW+ReLSCDljJRqtL+XSxwbHwqGejbgUFd+0nGe5t?=
 =?us-ascii?Q?1XmtEl2yNniVOG/BKHuddGp1F7ZA+SynJbn88rju7y1n5GfIr6alZD57W5ks?=
 =?us-ascii?Q?xl452godSz9lUrtdsIBp+eY6H82QB5ri/Evj0qyYPuRJDIwDdjVemJ6PfcQf?=
 =?us-ascii?Q?COOzI/FSmiNemYn7HyvnVskAtaEn4oIooxSC1AyMzeiN7LKMvnkFDsXiBwJA?=
 =?us-ascii?Q?Gm/EaWt3G1N96Tnjsl4YAk+287HvCdmcrCkWmdcUQsVpqtJTFVoYyG73/HL6?=
 =?us-ascii?Q?zP84FaQrVG+Tq9D6s+rF9KtVK2Ry1pu7kTtUVPbdD3GxPC1XYVv2iinsiJoP?=
 =?us-ascii?Q?jQE2iGhZyD6xD50RjQu9E96bEYNViUdSlNcplC/u5ia/Aro7jGk6eWQ2lns6?=
 =?us-ascii?Q?Dewf9V+B8FtW/thWeA5KQWc1szczmBktqtaWOSgVMm8oGSpSLA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d636cf6-bd59-4e26-f7a5-08d92b14a535
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 07:03:11.8533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aBYR8DxzaZjJm29eaO0dE9jywfjGmRfwwdGGVR3zi+FFDWF6PtTnsgOfMLLXPNQHAqv9KN/otOQTkHruxkpta4ugodL/V4Ho3LC+MCuR/04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7173
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
