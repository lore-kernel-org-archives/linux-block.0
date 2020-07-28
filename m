Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD5AC433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0563120786
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g1HRPfLW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jnCGTKGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgG1Kpf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:45:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13989 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgG1Kpe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 06:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595933134; x=1627469134;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=g1HRPfLW2rps/sC23QCsSJKwfUx8Kr2AT94EUYz9Yr6PHAVtf6ja7luX
   EtJdOMcEDpjinxTzjNmSmjWYLtvRRbiqI6kiRlXK2AyvlQRqoNjbY5R1f
   doXAyceHVxFJqrojiD7X/8Yp4znhuIH9aqrP5CUBRj2SZumgfrDHUxprL
   Yuy4Lg5puN993ml1NxKTjWSAGkQleujsIr/7i2Pcyx7pZ2SwT757mXnlC
   NmjIci/Js1h5+X7ZF+2s44Eqj2c0prwXAotZXS2nstiW5nOFO+f7coIra
   DjhCCvbUzu3nsrV3qR3efa+sk9IV1LpGd2b/BQhXfnLVw65kOTDAAd7GE
   w==;
IronPort-SDR: jEs6zc3y18T3VjN4rLu2BQvoOVNJCl1Gc7sezAFpr8jzP0IQR9F5L9/cfhsWjMViuWUeDOx9kJ
 KLWyTpxA14VostXkfks0e4cKQck83chTj6mhwiQ3qZ8+WxZ8KnsRJZiHE9EKHt1+wFPSng1j0G
 I5YQTgfvLOZAYp+tLQBUlGoHavZOxhJFQ7h+JcFPRA0GA0h6hWmQR1OUH/noMDxE3gmVVKTGh8
 JUTWHGKkunAAiBSqyXAv6rBlafckCQGc8JX3M3/+ITFJxMKYHQmca+hEZaqwkeVbX0b9N1yHxq
 70U=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="144806577"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 18:45:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGhiy7rILP8wJWFBzwAjb9Z1zJcYG+YZalH2J31cp3D+hgiTPcWdULsHsDHDUHFKPhKeQYHTJhdl22nADGLL2HHfMSmefjzhxG1vU6JSAE9tl7FJpGkaDu4nQaK/PT4SPLrW5Lrrmraeg646qwU/UVw5okLYc7UirqfvUHDhGb8UCBoQ0jmWnvLsu9ryo0vocIIJ3ahTMwRkcEy3NDry5uwYPp5yG9oJFZW4hL4CNDUx4yivGdp65GQ9WoOgZvMTCJCxqz8log9a0npVcDRL9RcfJ0C08eOKPEEZPY/1e7yK9MX4O4em8G+cZGDBjYd9DAXI9/8sAgmxmDa0yXLbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Rt65FXrdwFc3M5buva6AJvZ7H7d2gA2iFMrrMz+1bPjHgROun2hCjwRoYEymjCDg5lozsR/0Z97TKmBdcQ1Pxh+f1OMyq4xgyeDiQtbjHtutVSD/EXlLW0uG7TLzYhcgtE9w6SSsnvdhFI+OfHZhBXODFDzMKDzxDMi5Qxk71j05qtqIWy02EtJn426gkuNQovnVcLk2hPxh0g0ammBqPPthUcnTYtquvXNkjiKNQSgnDg8Tu8nPtZzjytO/T64E/Ne/k4nuO/aE1/4F8a1d1xKUn+weZupP2dZLESs8ctS3J2yP7AArE0u8srYKYWH3TpmrVQ4kJJlrH036MoHYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jnCGTKGBvnlwB5zjTqrPxQ/If/v2qI07ec3+vmaZ4hqybr3gM7Cvu3JLUfTKZLRhpIlMYyEk6JCW7oKGCTVYvyXY/rpZQ6sHn/weMHp6bw1DIVRgYLXJ+NZVhfaXMrkYLwjHr+Y235PKbtzNFaWfAUk3/Z6L5o7NOodJqIGQLhg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5325.namprd04.prod.outlook.com
 (2603:10b6:805:fb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 10:45:31 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17%6]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 10:45:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 2/5] zbd/002: Check validity of zone capacity
Thread-Topic: [PATCH blktests 2/5] zbd/002: Check validity of zone capacity
Thread-Index: AQHWZMfyNySSKYjACUSqLy4V/Ue0IQ==
Date:   Tue, 28 Jul 2020 10:45:30 +0000
Message-ID: <SN4PR0401MB35986EC1200526B95FD6316F9B730@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
 <20200728101452.19309-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31be0e34-aa51-4feb-2ef3-08d832e3594e
x-ms-traffictypediagnostic: SN6PR04MB5325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB53256A9AACFD19B7DDA742E49B730@SN6PR04MB5325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x7zeg4Q02ZRV8lRVWVXFT04kHQDcJyuwl78NRy28GhInZi6CheWUuPZyKAKcKOogYnJ78JmTNco2VDtScchPt8eHTTS0FOk57LhJBlc73xoQ8TNVqusEsepFerxgpfsixfFq5luqkS3Nevzgi5UBCT/c1YmLEvDie95ghNvJln7v36dM5weGrQTV+ltEKIi9Rsvm6JtaKwA2dCdsT1544fluHwQL9KxxUse6TsOPir/8zkJUDejkISHHS6eaiTab6Ikb2REj475z1BsRYyFS1DYkdO3EnopS0tio+yKicW48wovQ3ltmKNZZzHqHQHFV6WDIjLV+sH5zdXgtTcc7aA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(6506007)(86362001)(54906003)(110136005)(316002)(4270600006)(33656002)(558084003)(4326008)(71200400001)(5660300002)(19618925003)(26005)(66946007)(66476007)(66556008)(64756008)(52536014)(8936002)(9686003)(7696005)(55016002)(8676002)(478600001)(186003)(76116006)(2906002)(91956017)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jT64tptIiaTsa+lwL4vdLztV+TtJdeULb6L8QKrulG42a3IRa/1ckzst89To8F7Qk+DkDytYnaESwkLPgE9lnmvwYUcGIZE/n5QXFRneLScOiP1Au5p3jwU+lSpJGa2aKC78/pyexXme9kKmYBnZD3MvoqxmgHFO+oi60fH/6vKT3YGhJS3yCQ0jY+NVqlIGh6hHD76TmtT3fKa43Wrk+ZJ0xc4v8IyoyrK7Y5nxrt8l7sWrIqcSGmEycjJerRcjsWJ5LtLF3DLbLa1qxOuz2msi1bBGjRmSOBYyY1SsYUHcnHF2QiqmJbfuef4PTl9FipIEYAaJDPMOMKTIHI+W7hDHOGRXGGLSvH54ep6AO4JgbgCxsCErVDm6YM2NuxosqiLCqHSI+8Ov56jewKZE3wHSNDBml2WCpfpX8ALGyopVk3K6YhoebC2/gPLEkq9CnkepFCYsNJ1kkVvJe6V2W5kvQVnL0Z/h7EiMUoFhBeGwbhe+trJPaLhgsRBtXEIA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31be0e34-aa51-4feb-2ef3-08d832e3594e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 10:45:30.8497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqOgjHbP2QsrtcfKOZbDMy55yIeHK910bVhY2t94tfOg1p3Zz6ZPljZ4QUYciEpEjmZhIwB4YGH4bpkIiaiZLjdIPwP21TLMRqrMaaZiuYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5325
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
