Return-Path: <SRS0=SUnH=3S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3E2C2D0DB
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6B720716
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DBVRyjrW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Phxyj/sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgA2Xby (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:31:54 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53535 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgA2Xby (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jan 2020 18:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580340715; x=1611876715;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gMnnHu3ViFnfUtkjRk2Xvg7YEMadDoBY3mOOpnM1PB4=;
  b=DBVRyjrW/Psmob4c7AJZTG6P9Bvb6eJoo+U0M0jnDTu5oLF5+ul1L6un
   FVOXsR+87zhnrjo28Vc0Ix7irZBapdUVTWWnsa4CsZuE8AuImTAlIGTym
   XvFusUk4n69EevknZBGFhed7TyJdyAgJQ3IXe3jpN2p692Q3RroXhe2NM
   JzlWqe5rrs25Ji+1sndl2T7yehtdXE32T+AlZ4Yn1oCIb8HXjRwD3Yqui
   4QdKQPio1Yx03ueCiH4sY6lzq+ihtm7IQuD87tKAYDimcoNdYwMxv5Gwv
   6PtwSso+bb6PAM06ikvs9Po4WAMxs7JMj0CzFERSykOvSug+smY4gcPxD
   w==;
IronPort-SDR: dq5XhMPuBV+tO7xzINW0+QVX6q7Rvgkp+6lbGmkADFHR9oOVRUaT3XyOW2pe4U+GgmVgvWiarM
 TLHMGzJjYmb11/X7YdI1NyRj7vJ6d7aEJ/ciHqOUiKCzFLaLT1QmgvYuZtxkarZbAgoMw5ZjTQ
 7kG5R2jIKmVA9kjeithf8QZkpESy8w7CDMQ22dt26e5HY+bTLlshb4A9YnJ8yR8FNKOYVkYMks
 v3m15+1kp4V5XmWDfAUremr31kkshVam00Og8deKP2eubNfmhnqqwzdrbp5Se2VBijRXJ2mmtl
 oW8=
X-IronPort-AV: E=Sophos;i="5.70,379,1574092800"; 
   d="scan'208";a="130160472"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 07:31:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go8cjfomB6uRy94SfgAigjj0IzhGUwHKcBBbwxKTfW8Fh5g3X0ukHbbjFdCqlFuutJcWLjwdwysPBV/qhsscEoJVU56TuuBjZnTlPI3QVLYl5z2zIuaKXiEQb/6qhMs8zRu2/zi1+KosqGksB0kDMQov7Lo1lUbWalFtR9xSpkePlepbuqZhUrwyHySoYXeKq0x7eOHyhHr4AxBMCONFtA/JqRdUjqHuoOvhtzc46PdoX4WBSJ/gsnByl2Kyhxh1IbP9Vy7+eRUe9/oLrc3YHGo3RaemvmABaDAABg7lwIDe7QHZVyG1GFVhpdz3fZLT1nxdvLqFPY8XsoqvUiORnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMnnHu3ViFnfUtkjRk2Xvg7YEMadDoBY3mOOpnM1PB4=;
 b=m2kWzDkXUOhjDTZhpNzJC/m8C9rq/sUCcvPE/PgYA7BIQzPOjzGLrzC0k6oqrP8SusUoMpcwR48Fxk6m2x8tD7MYqy2NLLDOdyfeqF5qIPAiV9BZbLqXJRAhLxzAT2wQl+tdCM0FYZJZYC0oV41BKZd+wDDvd7tKDSFRzSSh6LWHy9jdG8/pWihCN6SihpKjudwMEtc0MmoJwPmaRNeX+Dkvpru1pUIhCKsZuwKlH58r8hbVMyuE0OcOlfWoKzPDtKQsMH7960Z9LblqxYy7704d4F18/ehua6dYj67rAzNEoLBaUd23Slxsr48CcOqCxXO/JKMnM/H2WJ1YvhJFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMnnHu3ViFnfUtkjRk2Xvg7YEMadDoBY3mOOpnM1PB4=;
 b=Phxyj/skEuD2k/QPpg1igYB782JPDv70MtncFvHbJvBeyvoIFjNkMtl8E2hXegNPCJDhHQfpDQLkBzK9a538RUST+bmaPPzTWYCWbmLd2NkhxTbJnNr+np0p4QmqgW2HChnSbPmyJaiLplK2Go8+PP72D6KMJXdC0I4pNd51jNE=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB6181.namprd04.prod.outlook.com (20.178.236.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 23:31:52 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020
 23:31:52 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "Elliott@suse.de" <Elliott@suse.de>, Robert <elliott@hpe.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests v2 2/2] nmve/018: Reword misleading error message
Thread-Topic: [PATCH blktests v2 2/2] nmve/018: Reword misleading error
 message
Thread-Index: AQHV1rtHpjzz1hm1mEmvg5KMAq0m7w==
Date:   Wed, 29 Jan 2020 23:31:52 +0000
Message-ID: <BYAPR04MB57498630570473E2DB75865586050@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200129154619.103332-1-dwagner@suse.de>
 <20200129154619.103332-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cd852c7-7b45-41e3-c2d0-08d7a5136b7d
x-ms-traffictypediagnostic: BYAPR04MB6181:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB618171EA3C270DC053578E9F86050@BYAPR04MB6181.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:480;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(186003)(6506007)(26005)(8676002)(7696005)(53546011)(478600001)(2906002)(52536014)(71200400001)(8936002)(81166006)(5660300002)(9686003)(81156014)(66556008)(33656002)(110136005)(76116006)(54906003)(66476007)(316002)(64756008)(66946007)(86362001)(66446008)(55016002)(558084003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6181;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z80Qh0EfH+eHm2jFuA8RqHrxYa+Dr5hsl0wp+Id/ZwR0P/JcbnViy9cXRDQHDXzYOmSsfi6PZhHqIBrjhYW8jYu1/tH8JWg5PAQ240ng28/znFyyLzYv8hbkQKAQy0OrZpAa7lIY9ZUub7AWQoGsTAKp32Me2TfRc/Ewo2Kfb9PTy2oG1Q7lYDUQJcfJPOMYroENSXqFioAK7VD6UqS7WY4ERG0E0+pUSjVfQ8VIKCyB8QNj3j783wKDPX5TVQi4BioRLH9NO/zfisN9kWQT9kDNsiulJSOj8ma2iZSoAsVbU+tx3TXy5xbWPVH8xP97XuwKkKCGAQaWnXAsKRXHmpsHp+4y9s8c/xiTE+cBdjgC9o/5/BLWe39M1kYVT40mrP+0mTLkPcQNxNwvQJP7evsADU+PT4jvreFOymcx+NE/9GZ+KWqrFwD55ZwW+Xug
x-ms-exchange-antispam-messagedata: s01Ywojnhql/bTBlHr3a5RsD68ssEwXmB9p5hwvsSESWvosR5NF4KfUhEx+UqXqqNWp723n0jpr7auNlq5dNLhQYHgueeh558Ukui+CMZtX5FlUYdDjCLyfGeb5tvPyHa+wmXJEXkPsaSwq+dwgv8A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd852c7-7b45-41e3-c2d0-08d7a5136b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 23:31:52.1201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7rJie2aYpcDXXhDJBfGDdNmNc224/G1t8eQdfLnwPGkjAz/d7PUds+A+Q4WhWKspRbGyIDvZQ1YvhEwZa5PEriu31dkZQIDuvW6XkDQVyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6181
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/29/2020 07:46 AM, Daniel Wagner wrote:=0A=
> Successfully..." is misleading. Reword the error text to clarify the=0A=
> real intent of the test and what failed.=0A=
>=0A=
> Reported-by: Logan Gunthorpe<logang@deltatee.com>=0A=
> Signed-off-by: Daniel Wagner<dwagner@suse.de>=0A=
> Reviewed-by: Logan Gunthorpe<logang@deltatee.com>=0A=
Reviewed-by: Chaitanya Kulkarni@wdc.com=0A=
