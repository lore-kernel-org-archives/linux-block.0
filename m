Return-Path: <SRS0=Oz6T=VB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109B8C5B578
	for <linux-block@archiver.kernel.org>; Thu,  4 Jul 2019 00:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00DD218A0
	for <linux-block@archiver.kernel.org>; Thu,  4 Jul 2019 00:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RVClWjoq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ViGKD7bC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfGDAPB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 20:15:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50325 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfGDAPB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 20:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562199316; x=1593735316;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UTkRxZq+ySkkM8YY8Sb0Pe9eNRE1wlH7UjxDPwNRoNA=;
  b=RVClWjoqwuFYKOLSgdLYOLsKWQoop89+FIiwJVkXkySpSNEUPUFndvvm
   64cIU8ZJu+zUCZmSoNhWPoVO9q1ERyW5Ev/C3GrRvTLeNVnFKig4e4RzY
   Yw/658sGKDqBDY9a7tcEiPib0eDfP+QancM8RF6y7lprhvG755EqqCQ/F
   MrXT6jwsD0c6CWJW4E0tHUnh94JOYhs3QoaA17d+NASZTsAYO+r7ovM75
   me49LKsOoQyg46BGrxyGPmtMM9bZvtkDE/JhjkmCEd5XjeIbOnXed7/cc
   So1/qXyt53AQ362ydqt+p41Ov2d65COfDgb9JeA0RWBJrpKf4buCHDZYa
   A==;
IronPort-SDR: q6STnOzmWQNDTSLd5dU9ALbrki5zsKAdJRHAMngotT7A5zzRov5Cw6cpST+WeP4oKoJ9mKN5et
 79ThoZi4WEUQ9QOuiwxAvbsGNxmHboA+PBPVpGP9yldg/aT7sabii/GLAXxTdfXnFB3XP7yY6u
 b/UZ/1tZ+P/P9N/AIhfJeX7r3aPG1ZKOs8cuWmHm0MgStL+S7QXZVx/a7md42ou0r9fVTIhOn4
 p/r9DYJ0mGYRYFib18PJ02Qb+hV4KlywctQBptwDc2eCbuQfVkLI6Mbd1K99Is2/18O2hTXANU
 K4g=
X-IronPort-AV: E=Sophos;i="5.63,449,1557158400"; 
   d="scan'208";a="212055038"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2019 08:15:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTkRxZq+ySkkM8YY8Sb0Pe9eNRE1wlH7UjxDPwNRoNA=;
 b=ViGKD7bCybD6iyIS3Az8mjllsadimOIpcUyvFLAIPjK66ZivxDYy5dG32ROuOrU+/HWooPgDvAKrlL9fAhGtndIyifX2qOYVOjr6bP3TYUADc+gphMScexGeyeHzfph2jf6Ky3ux/BXd+A5pAVVuMAcRXagPRjz/o8PtPJ6LEh4=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4485.namprd04.prod.outlook.com (52.135.237.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 00:14:57 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078%5]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 00:14:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: add unlikely for REQ_OP_DISACRD handling
Thread-Topic: [PATCH] null_blk: add unlikely for REQ_OP_DISACRD handling
Thread-Index: AQHVMIUbuJn4kztvYk2XiiEoPdjo8Q==
Date:   Thu, 4 Jul 2019 00:14:57 +0000
Message-ID: <BYAPR04MB574988931BE197AB00EDAA4E86FA0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190702032027.24066-1-chaitanya.kulkarni@wdc.com>
 <0760ecc6-feef-16b0-dc45-1e86c3b3d09e@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:b8d2:4d45:f4cb:6e09]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5b06d3b-d514-47fd-db3d-08d70014a5ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4485;
x-ms-traffictypediagnostic: BYAPR04MB4485:
x-microsoft-antispam-prvs: <BYAPR04MB448592BC0089438B56D2C7F186FA0@BYAPR04MB4485.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(51914003)(189003)(199004)(66946007)(64756008)(66556008)(66446008)(66476007)(72206003)(6246003)(316002)(81156014)(53936002)(446003)(8676002)(86362001)(52536014)(25786009)(478600001)(476003)(73956011)(486006)(76116006)(55016002)(81166006)(14454004)(71190400001)(71200400001)(76176011)(256004)(6506007)(74316002)(6436002)(9686003)(4744005)(229853002)(7696005)(2501003)(186003)(53546011)(5660300002)(102836004)(110136005)(8936002)(68736007)(33656002)(99286004)(46003)(2906002)(305945005)(6116002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4485;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZQlo0HyojnnBuV8qiEQPSH+mpciE62D3uQyNUlUEqrxF8hkxem/0lQmNtZOk3nAYrobXut5tthCbVzWL0GzOXcj+m4rni/kP+GBe2pA2crTBSFr+vDGvftv6DloAUtRS3DzECupfLNGWARQCe3c4VlEtuiPznqkj9Kz6sf6z9aJJ3Mz9o7MsSMLgsHlB3MB6SZaxbj36SjmUrOrQjN5abcfzwKMJ3I/jGOe2/R4yLkz2a1mU9gb73Z4342LJAHGjmuT22SStZKndVz+emtwbNORPY6DImWGUoptrI+HREhoPYNEIQfnRpGlsUYlHhN4mGJe8I8cXCqPr3AOsX77cBisBz//QdrW4dCPfM0ODNNXbugvqHXvCQDpbcdGZrWVCFvMySgyYXd7DR3n2U3ZSc6yMyTm3QOV3UtmRvX5lV5k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b06d3b-d514-47fd-db3d-08d70014a5ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 00:14:57.7313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4485
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/3/19 6:39 AM, Jens Axboe wrote:=0A=
> We should let normal branch prediction handle this. What if you=0A=
> are running a pure discard workload?=0A=
=0A=
Hmm, I'm wasn't aware of such workload especially for null_blk where=0A=
disacard=0A=
=0A=
is being used with memory back-end, I'll keep in mind from next time.=0A=
=0A=
> In general I'm not a huge fan of likely/unlikely annotations,=0A=
> they only tend to make sense when it's an unlikely() for an=0A=
> error case, not for something that could potentially be quite=0A=
> the opposite of an unlikely case.=0A=
=0A=
Make sense to drop this patch and future such usage of likely()/unlikely()=
=0A=
=0A=
usage. Thanks for the clarification.=0A=
=0A=
>=0A=
> -- Jens Axboe=0A=
=0A=
=0A=
