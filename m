Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D93CC04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D649320C01
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 16:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kZm2v8jx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k4HHp9dV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEFQqp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 12:46:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:36971 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfEFQqo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 12:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557161205; x=1588697205;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=y2OjkSeqmFkP0aomMl7IKfPQKqCQF5bziomLCBfPotU=;
  b=kZm2v8jxzqRBEqZwjxIpLLlY659OSTbgHiL0LSRWnOJZKEC9ge06J0hU
   9uToA2/EwqNb+D/+SLc0BH6hk2sKZmbvsZi+KRbxCzFAjNC90xkWka9+w
   UNwzrboFrh0HZsCMbdAf+jPMdQrs8m3HE/p5pXEtcsyycVlfJprmt94Qp
   YTqYyQpJqK4Np1lLg8gIYik6ry0cG3Ya0Wj/gQuJhasYP/ikHZZWQab/m
   o0j3d/jTOv+KHAU5/jDocmzw7tQwZ26bmVOvPMQvabP3wx68ZHLbIYVt8
   PjNFejcxd6xvwCtTf9a3WrH+Q0f+CbnEinDO7R0yqjIr5uMVmlWrTTLqQ
   A==;
X-IronPort-AV: E=Sophos;i="5.60,438,1549900800"; 
   d="scan'208";a="108836057"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2019 00:46:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2OjkSeqmFkP0aomMl7IKfPQKqCQF5bziomLCBfPotU=;
 b=k4HHp9dVX5qt8wMN4/u9q0dv9eSGP6tKcUB3fmqi/jnHurs2UkS6kTq8vtRnxKTCMT2HQdmb/IsqJrs84E83ORnpBfBBYLDj30dfu3Bydxy7egQaB7qWmY9nWJC+QqFWqH4IoejHJ0SstKaVdNudG4KHnOHJB3Uj7y00NWuz35c=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB5182.namprd04.prod.outlook.com (20.177.254.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Mon, 6 May 2019 16:46:42 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 16:46:42 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>,
        Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
Thread-Topic: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
Thread-Index: AQHVA1Q6zH4CttIufkWRxlafayMhPw==
Date:   Mon, 6 May 2019 16:46:42 +0000
Message-ID: <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 996a3b8e-29c1-40fc-d391-08d6d2426af2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5182;
x-ms-traffictypediagnostic: SN6PR04MB5182:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB51823FEAA3F7BFF1CB8CA51386300@SN6PR04MB5182.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(54906003)(102836004)(53546011)(72206003)(6506007)(110136005)(316002)(73956011)(76116006)(66946007)(91956017)(33656002)(9686003)(66556008)(64756008)(66446008)(4744005)(66476007)(26005)(186003)(25786009)(6436002)(14454004)(53936002)(256004)(66066001)(4326008)(2906002)(229853002)(5660300002)(7696005)(76176011)(55016002)(52536014)(6246003)(6116002)(3846002)(478600001)(8676002)(74316002)(8936002)(86362001)(446003)(99286004)(71200400001)(71190400001)(305945005)(81166006)(7736002)(476003)(81156014)(68736007)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5182;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t/ckC+/u6lLXR6oBjKM4DYvSF+M1ajBx5KV6nPBzkA28oeqJOxO6olMcqzzRGQhWCHdRLMLruLrW5/hHqPngUz58SJ05wsiEd7ZYfEuSAHTf0PiyqCb2u/7mJo5OkF4euBIumSmYSo6WAtey2WZpoMfIWituon3/2K/CQhSAkYCXnYY3XFlin+kAm15EYPZvZQgHdu1YHP8siGFbaCgoDoTURx9+P2CSFvzdDElwdI75M6cVQ0UdwRnSvK1dE2v7Uv3SXgd55FmKQshTK3ObyUd7uyVzj9LOvpobmF/Xa279rRSN4AQN+kP2iZgkPfVjVvySa5U76ZDOLLbfz3rMJHWubaAfLt8mJ4UeTf9U+uzRp4wi8K2BWbTidgXxfRyoalnLBc7+kAWZYnW16oEVgC03SEjXkvyl/bgjH9pnsEQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996a3b8e-29c1-40fc-d391-08d6d2426af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 16:46:42.2436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5182
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/06/2019 09:38 AM, Minwoo Im wrote:=0A=
> On 5/7/19 1:25 AM, Chaitanya Kulkarni wrote:=0A=
>> We need to get rid of the string comparison here.=0A=
> Chaitanya,=0A=
>=0A=
> Do you mean that test case bash script should check the result of output=
=0A=
> and return some error value instead of zero instead of *.out comparison ?=
=0A=
>=0A=
> Thanks,=0A=
>=0A=
=0A=
We need to get rid the string comparison as much as we can e.g.=0A=
in following output the nvme-cli output should not be compared=0A=
but the return value itself.=0A=
=0A=
-Discovery Log Number of Records 1, Generation counter 1=0A=
+Discovery Log Number of Records 1, Generation counter 2=0A=
=3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D=0A=
trtype: loop=0A=
adrfam: pci=0A=
subtype: nvme subsystem=0A=
-treq: not specified=0A=
+treq: not specified, sq flow control disable supported=0A=
portid: X=0A=
trsvcid:=0A=
subnqn: blktests-subsystem-1=0A=
=0A=
Reason :- we cannot rely on the output as it tends to change=0A=
with development which triggers fixes in blktests, unless=0A=
testcase is focused on entirely on examining the output of=0A=
the tool.=0A=
=0A=
=0A=
