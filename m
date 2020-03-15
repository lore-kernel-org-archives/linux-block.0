Return-Path: <SRS0=XUQF=5A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D4AC10DCE
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 23:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD06205ED
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 23:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dI8yETB/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ngcY26Ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgCOXgN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Mar 2020 19:36:13 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23247 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbgCOXgN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Mar 2020 19:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584315374; x=1615851374;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RudUpSJsJRYq1TjUCL7dFKEGrIfGMtO5bY3XgV+iEZo=;
  b=dI8yETB/4E11GkUP6dX4trxIU8v9SgFSzs3RRJAljX/XxVajUFLlbtvz
   VhkMVFbWAmLfLXAZzPcZrhkRGQ7xwvK6UmkYFot0gb2/mWGLlgl5J13XW
   Na/zgrzO+cBmoq+X7KCaZ8fMdeIsyIPCHi2LSiOAI2J8+ZbzXN1kEjKtu
   v7/wG+yoDYyHFMA4rf2XTfkuFtlDRwPdIjCnV6HSHGNYTF9XxLGcw6SJH
   7SbLBRzTZI+eD29m+gPcNvl1x15J2kzXZjGa0OvqSG9ADpJUwKTHScyvf
   jx7nqQRfi/I96vynrIOIW5Cjo9bT4VZM+e8RZ4qccwhijTMxKfMLVLG79
   A==;
IronPort-SDR: Y5GLEHIhZgAQfd/gjZSgLLPrh5kEzdKu1/b0yIXXxy4OtjE3ESpXy8nKYWs2RSsrZdNkqckui6
 7JYebcxXPSXfW/mhro/ICj/EdQ6S20idwu18zluJBAOvJ6aQrIbf4q8rsTiODR9fudz2Tm6Yt6
 HFy9mlrPYM2JdggEuuUJIQjQ8AhbDlgm1nTCNOZqJlQrs30lioojPi+RPVxBQZcgRJktmUqqx8
 Cir1tsDnT90LiYAitQon/k8Su8guf0vsjEMC/KFTqbZES41DK4ZvH72XPDA4VgcQNsiOCJWPyX
 62A=
X-IronPort-AV: E=Sophos;i="5.70,558,1574092800"; 
   d="scan'208";a="133008829"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2020 07:36:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBhKmjf62qGTvbax8f9l6vTrE+KZhXxJd7yU3FuFI+V3aUqW5ZVHo8v2RNQif0md/XsiwoXraCESk8eS2f7umiVTlzj79In3kxNh27NFVGzbcRbmwiwz/6R6U82zTSXILhcncdNvi36IGhFsD5ik/Te0MbVSdj6L6Vyd7GYo3tPb4wdo0pndRJPdb0RqSWh2DyuXPEuo0WebPbmPIVq4qfESFMpRzrkUumrieRty2yTmSqUV9VbRJ4GhkEc2+Gl70g4QcW3z/Qn9cEN1hyffku9+F6KKlTuS6t/vGhXjvDjhpp2IPaHg5uSeYG74aRHboyfwmo86TWpxhs5sN3Nxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RudUpSJsJRYq1TjUCL7dFKEGrIfGMtO5bY3XgV+iEZo=;
 b=arA/9JrsVt9mOiHrdFMyG5XbDrQJPoW8T4XDS0UFjjVrwt/twuoNCzJpGTW9sviOkSibPPIbmTCTxzBRZ+BrDxfc6RGozZSg0Zc1niCQWyrfMpE9WJcxokfM/+cdPAS1kdYVSPP5zDFGpaE66BdlBevdJ/OrlIQ9xk92gT0FdlZtSLMcpF3XlTr0ToA6Oxf3b6RDqrnBBQ+KsjZ2qQAZ2EhI29JBIs13DIcZMjj7Dob06yKlxvvsGqJ2FGjJv0NFm29DUdc3Wcwu1opsKINdpfmlErsybq6yyKip5iaIChD+o5W+aQUobGzYPEdONG0/Ipb21cyCVpW27eJhxsR1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RudUpSJsJRYq1TjUCL7dFKEGrIfGMtO5bY3XgV+iEZo=;
 b=ngcY26HtI5rlBLL2OD8d/sshbuL9CNaHpUKT+9ixmhB/yhe+jSCNoCXIsEFwvabN8mnbQwCwltKPcXVOQJodAjhUXRu3DQrIE0WG39FIxL1Q3epwJLaXQaV1ziIb/1Y8HiSgpzpaFrNMfQKUdZnLtz1Iw2a91M8ISYPGKUcN/aw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB4839.namprd04.prod.outlook.com (2603:10b6:a03:14::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Sun, 15 Mar
 2020 23:36:10 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2814.021; Sun, 15 Mar 2020
 23:36:10 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH blktests v2 4/4] Add a test that triggers the
 blk_mq_realloc_hw_ctxs() error path
Thread-Topic: [PATCH blktests v2 4/4] Add a test that triggers the
 blk_mq_realloc_hw_ctxs() error path
Thread-Index: AQHV+xb5ix8JN5+hp0WoLH7k4unM1A==
Date:   Sun, 15 Mar 2020 23:36:10 +0000
Message-ID: <BYAPR04MB5749D95C5608F8878CCF8B1C86F80@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200315221320.613-1-bvanassche@acm.org>
 <20200315221320.613-5-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0a4afd8-a4e9-4dc4-1d53-08d7c939a493
x-ms-traffictypediagnostic: BYAPR04MB4839:
x-microsoft-antispam-prvs: <BYAPR04MB48399315C87B5C8365A962D886F80@BYAPR04MB4839.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:285;
x-forefront-prvs: 0343AC1D30
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(8936002)(4326008)(71200400001)(81166006)(81156014)(8676002)(52536014)(53546011)(4744005)(6506007)(2906002)(186003)(26005)(478600001)(66446008)(66476007)(66946007)(9686003)(64756008)(76116006)(66556008)(55016002)(54906003)(7696005)(5660300002)(110136005)(86362001)(33656002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4839;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWiVzJ4Q6n68pzWjgc2BWbUjK7zlcIMbkAj4wZFSHWIpPUbB6RgI84ZkFBQEU8PU4AWNgLmF5BUzgRKyGdHYN5ekiu4sWDRtrvoM8SJ4z6+jo1RT3TzlgC5kGU1uj5FGuBA3edmms5WPgCwtPSsdpo4FK/z1n/SGPINTB3e8/7sUe6mcKzeJibGPTy5KhN+75P+ZGn+tk3/01S0AIKugqSobvyDq5gPG5f5KC43xRMe8XCEp+xmja7wH91wVT3tvp47dqiLrFCG+640rmYoZFaj0fAJx6xaiJvmSrC0TLY7PdQvyqBK24zAhNFgoURgUqEEsAUrsT4y3qx71I0EsaZADGjYKCNKrIZvA5aEtzSNjNgEUrvmZr8yIfgwbvjsEqhDR1VeiYtLRMYQ5UVdsSpLTG8zdU4IeegoidirXLiODw1hdJLQuKGGUuAud8uqB
x-ms-exchange-antispam-messagedata: kfJzvve8+Oy/H81bldlioTXesOobzmY0Rv9++QvUtqDkKRucoUjOHd0q1VEvaLvUaDyww9ZyggDy+j5mp5v2D/Ehk7BCL0DlO9YW4IIpk76LK8AYzZSUOkgKzklZ8McJbRNrKqh/rGAUm2nh+I3hpw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a4afd8-a4e9-4dc4-1d53-08d7c939a493
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2020 23:36:10.5909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fEi3T9mDJ4fS3hjZGaguBrsL1KGShM4Qa97+4DwqefvsRa4q1VnIx1wKkJKX5c72lBuIXu8hW4yk4xfdNac27FnH8VgKUlOKsqJdLBL2pk=
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
> Add a test that triggers the code touched by commit d0930bb8f46b ("blk-mq=
:=0A=
> Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()"). This=
=0A=
> test only runs if a recently added fault injection feature is available,=
=0A=
> namely commit 596444e75705 ("null_blk: Add support for init_hctx() fault=
=0A=
> injection").=0A=
>=0A=
> Cc: Ming Lei<ming.lei@redhat.com>=0A=
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>=0A=
=0A=
