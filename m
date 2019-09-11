Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB229C5ACAE
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 20:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4CB2082C
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 20:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yjttr6d9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eHx58X63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfIKUjA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 16:39:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39857 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfIKUi4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 16:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568234336; x=1599770336;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fA0Yrji4qfI+gV3pm1GcvSvbB2oGuuXbNCzK6MdEoMg=;
  b=Yjttr6d9z/UvI5pZ+luWSP0pWVHbY4aecEsuJhMeWGQz9AHowxx1EqC+
   4JCrjkANEW7di1LTAaXZnOHxEUItpCio5coaNBW55LgZjBGEl9YiBJscI
   p3D/om7W2/cgOKBlIf7X3z2CHERor436f8yrRpsiMjdeaHn2ofzst8bLF
   r7crgzKf+HAvIIkWkDzVNaNHByhdoNPqFps89Ipc3mdnimj8qFUtz0vQX
   ijDG0IztbzOJObW1Aq8nk8dvEarx224yTeu8y0j8644XerfUtS3y4fOm5
   +WAKzwb50V0keT50MatuPMBLRSa8t2+Ae4poY3OMmkaZy/TQwz8VGX2EJ
   w==;
IronPort-SDR: Ddtv9nCCR6W6MqylayqSWqtZwTkizsP57xyh5/ZY1ZMRgaOXmxH3RdeVL+gPJoheJc198BEICL
 AFZxFnCf69XtckMcBBcePFra54TfTdtPbzhL44oNIbwm1QV6ej0dNhgzkiFHTBo3y1jBPGiY9m
 TuNIu2d4PeVo9unxZ2SjKTigW+5XKrOBOmfaPtrVrti5G2dQ4zM1NMEQp2DWmRcb9KQ+nvh1jf
 E5S2djUC4ujyOKbFg5/7vyiaPp5CMjfaUJD32IZE6bXDzePFBAy46fjDfhMjFLUU2Kh0WP2iCV
 jsk=
X-IronPort-AV: E=Sophos;i="5.64,494,1559491200"; 
   d="scan'208";a="122574028"
Received: from mail-co1nam05lp2052.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.52])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2019 04:38:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeXtZn/dDyloX96qW03nTMSlx4GqakdckpQey8JRnZVk5+MKk74T2n5EoZ5zzXPwryEf27DWGb1yJGTRKuRyIka8yCyyYh6rosrBOFZpzjqOPFDhVkUhwcaILhOpei25EmTCqmGPT9x9P9an26xpQ+NX+XsFzRagMcwq41WD/jNopWVOeuaUJBM+8aWP0jArTU4YaLgmJbJvpROqMN/67NL8Yo80GuVD2ZmMrJmxIKJrWpvvdXDomxa2e6lcrZOwvsUqwWkljrZ9M1tAxbYxQ/VUT8TtNlNcuxbeko57Epdv0FqS3Av4fvOKvEST+7o1uXTqedG45IDObWAdy9fk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA0Yrji4qfI+gV3pm1GcvSvbB2oGuuXbNCzK6MdEoMg=;
 b=jmCDUNKtU4qxeBZ5UtcdRQRdf6drtKu3gc/qfD8piVCXcS/TH0ScjdOO7oFEgDUVsRLjhyQOLEEyxiaP5vFvRUVaU6avBrubQhl8Y+VKwWPA4UMCBb4dZjW9j4MvPjKpT/Tf+kaQjrL6dhGCvDjE08ltXvnKyAtAIk14fKdxA+mbfAiVtqQldqJMsFrbSzOvcBzR1SBuC9ukdQtmNh1gPN43oWRgiP9bvtbf6Biopx1UxPAkIymZ9JQOomATqwfzJidbyj/6ID7nbnt8wQcgaDViZumO1qtXhI6cn38GmZ3UXqFfoJ25ZnOZwv2zCZj/mKN/egK27ebM2n7bpYoN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA0Yrji4qfI+gV3pm1GcvSvbB2oGuuXbNCzK6MdEoMg=;
 b=eHx58X63+KJoqXBBvBOPcJ1ZXykbeRHvYgkZrpLLarBQBDHy0S85cxqKYL9bZVvainJcASjlc/eEmy5K9LCCaUoSbEg+lVxY2IB2lzVWe6/fkVKB0ChkIVHf9j3ZHjC2FiRf/T3xCWkh47zLqO3pV9Pzz69+fejKDRtiDqSaqaU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4870.namprd04.prod.outlook.com (52.135.233.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.13; Wed, 11 Sep 2019 20:38:54 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.016; Wed, 11 Sep 2019
 20:38:54 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v3] nvme/031: Add test to check controller
 deletion after setup
Thread-Topic: [PATCH blktests v3] nvme/031: Add test to check controller
 deletion after setup
Thread-Index: AQHVaMU8QUU7CWdh+U6FXoE9awxRVQ==
Date:   Wed, 11 Sep 2019 20:38:54 +0000
Message-ID: <BYAPR04MB57497809CA89CFC73487A19486B10@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190911172021.5760-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bde0c98-2741-4fbe-4ce9-08d736f80ff3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4870;
x-ms-traffictypediagnostic: BYAPR04MB4870:
x-microsoft-antispam-prvs: <BYAPR04MB487027229DE95A077825248086B10@BYAPR04MB4870.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(55016002)(71190400001)(2906002)(229853002)(76176011)(8936002)(6436002)(81156014)(2501003)(6506007)(81166006)(8676002)(102836004)(53546011)(478600001)(52536014)(66446008)(66066001)(66946007)(6116002)(9686003)(3846002)(64756008)(25786009)(66476007)(66556008)(76116006)(6246003)(5660300002)(74316002)(110136005)(476003)(305945005)(7696005)(316002)(4326008)(86362001)(14454004)(99286004)(71200400001)(4744005)(53936002)(26005)(2201001)(7736002)(446003)(33656002)(256004)(486006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4870;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DV33dCE28dSQhGWuPJQanIBVJK8z2+7shJHPK0YzZhmU4XS3aes1436fGhfv2Ae/4krrwRG067HUgdd1wtcCQ1fLOYoHs8Lfnp7DQs7UNu1NKdKSKc72UozZFYtI43KESyS+3trRUEkoihwMtlmHWCWMu0TAVktNbZ+VUPuVHs3q93FA8PkJxsDATSAMP0geore09eGFcjYm7fwwgmoqSG6dOEnY+0jO3qJEq05rMS7FrVlT68Xj57uoJKhFv2LIoXgMTgb6FZ6PXcf9vkDxM3TiGg/EDIMfYFtNhGitqhRdSkKb6bBjpkZndNQQYsvvgpxYG9pdaeq/pISvooMgUnpFDxoLltKnUA/PC1vE9vr1rnJbpIOhb1WtoXz6G2Y0/MzPO5UIIPqbvg9h8ugsu5oEfdKMPjYsj2nrVd8W/X8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bde0c98-2741-4fbe-4ce9-08d736f80ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 20:38:54.2527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DB6r6WsNpUvXUjIMdPwEln0oo8xDClToJdALJiYJNIaLfLjIIn79Yi/DlICIRuSyLMqX8QYO1wXLMbc84RaapqrkvZHMj1+xTX8poH947Wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4870
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 09/11/2019 10:20 AM, Logan Gunthorpe wrote:=0A=
> A number of bug fixes have been submitted to the kernel to=0A=
> fix bugs when a controller is removed immediately after it is=0A=
> set up. This new test ensures this doesn't regress.=0A=
>=0A=
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>=0A=
> Reviewed-by: Sagi Grimberg<sagi@grimberg.me>=0A=
> ---=0A=
>=0A=
> Changes for v3:=0A=
=0A=
