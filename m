Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45271C433E6
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1A164F50
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhBBLxT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:53:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11127 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhBBLxP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 06:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612266794; x=1643802794;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=qS+bZGgJVFVwzid8xI8SddQiNjLpLol/vbOt/Cgt7q/groBV0L37YkX7
   DhQvkSU4S+/mxBCoJXroaVlH/jdvpb3OSm1pi9rLLL1sbW8CcMDAyq9XQ
   Ikpz+rpi2G5SFrm899DFbavJeX41UZTuQgjTFmjxZYg9EtokJC9AIz0/5
   jL/2tmSQz6vNbgq5g9DxIA0rSBfUfwuyeYGns/SrmOCZj9STUpjyyZEXi
   e/Pmj6zqhtm9I4XuxUVht4suyAXLtEPagb9yQoarALCfwO0rg84xe5fcN
   +fcp9Qk0cOdZOy2pSX5FgGgAXJxThcoGeGTE+sGJLvjq8BHECTq8KYqXc
   Q==;
IronPort-SDR: l+m2uAbLaivpMHCWlPXanlVRsaFNDzVFy5Nn4PTJJ0E470uI/Ed9GVmLK3FDeHLqkreg9FXwzk
 ndeEabVAPqiB1KuTkAckwczFWorwzbzsBDv9qINb50EuHtlSjwqkh56z3BL1jLramdxTT8UzXR
 BffYpTevKPHSJldLBbBxxOTlt1oWxP31AYk5xYRDjnfwRaKRb2i0vcju7FEVSCafeJrnuLtxWL
 20WoWO2pOEckB2oEtnxwH5+iZ3W+RQjP0yFXRYiNlbB7oFmyhXPHdYNcUgiEibvhBdl4bF/rin
 8Xo=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="160097035"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 19:52:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjH3uU5afSu/VBwlvSe0N8GwWdW0Ug4FDlJCzYdcw0cv9ICSdbdjI1IL09l9xonV6mfyBs6qB7myM1WXEw8TF/ZwDJlibpf2AIycQBd4vcYLwqtOOh3KrJyrzxBMO8dXraPp2S+gCoNWuStt+c3PeRKx0hG+dgDR+X37cjaxmGaojhDAIBygLPbx5Yy4oyaTbJctsnT5SPdwucZady3jsTwPt62BMJZ0rdNkoyZioBTfLcQqiNSwtY3CezL1hGAsV7sS1QmrwQAMSE+Uv106qw904tQCRGYQ79QcFKnTBTIV7f6Xlo2xlQVCh6zYSlSJiLh/RYuBz5hDw7v9bcNeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NxNNz+Jb1H0r3vRlE3jYx8A9L5sgp5YBsp39+htsvjbErPyLuaoX/mG7gAlUcdfTMa74cZmK28xl/VJno+30iUKrrUc0HNi46MDhNh6if6oLNeX8XPMcheqwASnelZ3GIiN1Cok5Ob3Ur7zpn+GceGAimbr+uDRdU5u2po+mbuoExLRnLxRuEDzfDOxMFGXjZwWIKpn2hM5otKZB+Q4OB177ZP8s4CzMF6TnbdIVAEEY0zmwS3e1uNxR4u1sWH2s7u2l25btr0BFri+keg7DlbSVsRPgrrV/h7rSDemlUMojdkPP0AOEEBfj2AppHsFxzb4cFpVDZaHuabsU2kYyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XxxtlXt4eTlIrYEOQ50JqnRXTMzAiwcc0lmH22vwascTil9sx8oSLWb8/psa32cw0vOpEPoHgBDglmBS4LjN8/n/+YYjiooA3OyuzEOircYcjDzHsfj1OqZzXr2Mm05I0xgnqdVhDQj7cWk9tBp06S58VmFpj+edlZ+hmeV5ACQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7593.namprd04.prod.outlook.com
 (2603:10b6:806:14b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Tue, 2 Feb
 2021 11:52:03 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 11:52:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH 11/20] loop: remove local variable in lo_compat_ioctl
Thread-Topic: [RFC PATCH 11/20] loop: remove local variable in lo_compat_ioctl
Thread-Index: AQHW+SXTZpKYZfG2pEW3xBAOPkup4Q==
Date:   Tue, 2 Feb 2021 11:52:03 +0000
Message-ID: <SN4PR0401MB35984AB4C537BB129E9E0D6F9BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
 <20210202053552.4844-12-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f88b85bf-2891-428d-63bb-08d8c770f53c
x-ms-traffictypediagnostic: SA2PR04MB7593:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR04MB75935E4DD1D3B2F1EBEC64039BB59@SA2PR04MB7593.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5bF6AkKVZgMODR7Umi/zC9fKq+yE5ntMXKHyari1b/7fqSD3JAnj6sKnFPZHDtqIMgBVSXrQn4qRTmSb6ipv2u97PxgS7VrWjPg37h2+JaXv0nRRBZQGJoF+609cJ1g112hx09suQrP4RNBv9mCfySh2swHWUzHGBUZDsxHj423RmtYrj9d4cA49d7M5wRi6VOyfW5qXW+TUK5bGlqC7dHhq5cKSNzIeNPgAvl9GdUXB6sRdpq6m8AJBcW1B3zF6iisXKHIYkMMp9CgygjO5++f/73ysTgKra2x1nL/2o3gnP2iDAxZrZOyEpcDvV+tVNTTmq0gQIh8uGzwQ0jtf6znGHk6mpcYVH9W9Ow3T6prtKso27fagRXrIEICrJhR8gi+0QZlYEHPry5KQoDZDs9ur2W19hvnTrkshxNGl6U4YRFkfycibwzoQLbZHIOWfeAw81uLFpXCCcOkT025qLUtxSP83hkNIIVCQ2ws6yVzI8ZFKa9gQFsGipeul+8HO1jKQChXlO5kIAAGoyefjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39850400004)(366004)(76116006)(55016002)(71200400001)(6506007)(4270600006)(316002)(7696005)(478600001)(5660300002)(86362001)(110136005)(186003)(8676002)(91956017)(9686003)(4326008)(33656002)(2906002)(52536014)(558084003)(66946007)(8936002)(19618925003)(64756008)(66556008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tH42QDPbOlCOE5iBAyYtKcwx2OPwQHOnNmr9JEIkcW76NJ6D3B5daHvo8Zy9?=
 =?us-ascii?Q?h/dhOhOv7VsrbVMnurff+B3TnlGQY8T6S1hdnb+wTcCcVcNKc5M95KW6GW5i?=
 =?us-ascii?Q?HALXBytzuGbA5BreuvSX+ZCNkw3zcDqIRHTsskk0kdrNCfTLjTEqXCFQt/0U?=
 =?us-ascii?Q?yTeysoio0HYeMTMkuGh4XEDGyWq1gjCwDgGHW42b6PAHw4xiZPBxiJFVr3jS?=
 =?us-ascii?Q?+0qNbW6bDu66QGl093WG2LbbzRebuZD+tnSVeeQcJQ7cCSHAhABHDj1T+t4s?=
 =?us-ascii?Q?KAxUzu5ppeDopRVlIqT06zVGcKXs+qBKM5FLzD9wzwu1Z5J1ObmlwnLT0CO1?=
 =?us-ascii?Q?afyDpFFPMprWp8j7O3dnIWeKWwUfy++Qbcb8SqvHpHISMHYmmbPvRrpcZqAr?=
 =?us-ascii?Q?dzxMXR5ax3dfmkcLBBh7THoiq0D8Fwe6971u5/VvlO2bE97tTTJ0VD4VlaEv?=
 =?us-ascii?Q?JJtXUIUj2+Z4UAwTtzb54qXTDh85jfqVEqufmwsm+zexRzyPpwV76p5R26em?=
 =?us-ascii?Q?NYpFvDZXF8sf44tgfcRbGy8d/xBV1smiLZ7t5IIGVPJhWRU5MEz3mUP9gxrB?=
 =?us-ascii?Q?65ljMvMElKX88DumMYTINj/2HpjooJawBNrWOqqx3S3IHm94wx0dBvNk8bjv?=
 =?us-ascii?Q?l3G3q9oihJ2ge3hF92WIOQ+hp6JGZRyQscXHzmqtbL8q5Utrh6m+RgouTivU?=
 =?us-ascii?Q?dn66WiTZZvTsG+SRxGvQ7Zz3Ci54mcVmT3aC2ZZu5gfeu6MgCL25tCiAbCBE?=
 =?us-ascii?Q?clLjOmue9t3vxvr0y5JPwCdWNBgH4BeetPoptcxzfhsbTOMv06ONpn5StvzN?=
 =?us-ascii?Q?lLll2elORcwneQqHp+vDcEGJwTAsiRY+/8XvrL8aqDX7V8zxfrr9tml/uEk5?=
 =?us-ascii?Q?xl3AUzmqQrjndS8mSKd5/kRzICii2iv2lqlTloTl9KAhL+dvFT1FctaTUgkB?=
 =?us-ascii?Q?Uxbv3i0Ja0pSaYKSTK9csjMlChdCB+gRbbs1UzUyd3EcbaiZqo88d6JTAbEM?=
 =?us-ascii?Q?jbLY+bp8k8Y4nsZyjiW3N6Y/cMoWY2hgJZzMbi93RTGXvVg8tiCNvbzIUWl6?=
 =?us-ascii?Q?nG1RheQiyIC98P0EnvgRMuyRYVQnd3dNnLJA1gaK1K4agizEYQCDl+NlEIjb?=
 =?us-ascii?Q?5YcnWqnSqWqTFRgtIZprUAf7YH/tEcQzBw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88b85bf-2891-428d-63bb-08d8c770f53c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 11:52:03.6545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWTf+BM8ehYvs7aOyCXzkz32AAWm7D1t+zxJmCt2DeQOncSSgVCdCT4wWaTia7WFOnr2zXZfyTh1VCmgXoocKaQgxKb6zK+iIf7HUdHxSPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7593
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
