Return-Path: <SRS0=K2Ob=YP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFBFCA9EA0
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 17:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994232184C
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 17:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QMN07Oe2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T+DkKA0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfJVRzx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:55:53 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45030 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJVRzw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Oct 2019 13:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571766952; x=1603302952;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3G/X5VFshbrKmILcxPb6efVb2Ivuv7/jbdpN271Bsv4=;
  b=QMN07Oe2aPfpkjk7VFsPn4ZOwpIxH0DMrU87rjwnVHeWOsbtvBbqKcFx
   7K+XPREidCwjRcFQ1AWdslbW3l9zupX/V6Xe3Qe59HicIkHBmhZK+ClBO
   yFraWpHO0LBdOdiESqolLAAr1kRMw/dlTGgR9iBJH9umPBpTQ26+aFcA9
   Vckdu0pEwh2JLFB8zKK1jSc2zsOO0AwBXKbF8qkImHYFmi48BqvPW386h
   DXCZH3jtv55HlhKu0Om4bnz9z4nS71hffQTQ/lZ0e93u2z8fkji+YhsY4
   9XkGhqtha+GwWqBUQ2t0b3cEoEtRHmGVMs4Vg+65YBjCkkMqw6R70j3Mh
   Q==;
IronPort-SDR: aXAjfloWMLHOaKPwy5G4TF7kHyKseop7m5LArv8RwlWvJVXXN4eYuCxQN/vytK1Xl3e8Ucw248
 teF5mUxsx+eCGq+sodplN1lCL4hUqNYGzRNBC+kRb4jkvnDBqISJRJlB+/ENqnOrHsrxuScnta
 Ym2ghjyLyj7wIdEXRDvAa5bAaDp0rhpmDm4lQ0p5jOm7B2d3508eNOMSurdG8X3/mLGf+4S81f
 3Sqi+YIa8i5X+wsaDbyJx5DwdvB3Hdj3x9yVIxcDDk4/JeSeoYYQ/crSj8FclcWg6YmMaXwwP3
 mjA=
X-IronPort-AV: E=Sophos;i="5.68,217,1569254400"; 
   d="scan'208";a="125510844"
Received: from mail-by2nam01lp2054.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.54])
  by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2019 01:55:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYwOXI9EJd9kSErEryHwmvGLyQUBXAFWGavbHCnosSRbV6ZRqtSdfLwOXrCsAKRRXzUIwECZfhDItrTLLo9MUA98KgeBuk8WvblZ81wZTYg81XMQnSZy9brgpqta2N8CsYPBDPZwl/Bsj1q2zavI6x8oTeocjGLDFv9mryNtoKF4s82Rkes5ivAHaKMIwRNDlfIiMHc1ScTSbWl55ZKneOIq7E7bn+BiBO2PcL8LfygZ3FuuqZi8wfyvivXPQ+d9qv6+18fcTtCi9SVSIAEoH+IQFLldFQxYF8pQiP3icEB9SIr1as77y0Ri2zTKBxnIdpSVE6u0DSrpZZqSjWwhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G/X5VFshbrKmILcxPb6efVb2Ivuv7/jbdpN271Bsv4=;
 b=ajOSjV3oRLfomuCVGDNb7JhmFy0WSL5IWLf+wtDOSVFI/wPeidKiXLfgDHjvbrF5OwqK3w4bauX/VkH1miY0PGarSP00WrYlxuQVOkYQyA4BeIqLWYiScN6I2YwZPanmBCSksc6ccb0PlWhmXg8NEwcliw62vAgrU+SGr+vMnzYa5cIrb6ZvWehp4HVb8KWe/dI8xsaPQIUIMEgH9DJnkH/AnKfYEZs0ytOjIZhfn0hYUYf7cNI4rZtngDYZuFXDAwj50PxneC6S3ZoXN8sBS1861v6geri3XezoIXa7mN2KstSIBRkYCGOfbqxUoClRzE7fPdX6AwZK94n/vXdJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G/X5VFshbrKmILcxPb6efVb2Ivuv7/jbdpN271Bsv4=;
 b=T+DkKA0MoJFokUhXYSM4n9ob/iRbYhw1zD0ND8mRf5z7+BFPfNAVBSPcLsaJrA29ElooCKZtqxRnOpG1ah1mGf7Kl19YldLvXF/w2cRlMqQTk0mf60NrTFjrCS6RwmjG3doDJEaF5w3IyTYO44cB5688+QPJz1cQty+7JGrADYE=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB3829.namprd04.prod.outlook.com (52.135.213.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 17:55:50 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 17:55:50 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH blktests 1/2] Move and rename uptime_s()
Thread-Topic: [PATCH blktests 1/2] Move and rename uptime_s()
Thread-Index: AQHViGLtHuoJvdjGHkCiy3Od19QF+Q==
Date:   Tue, 22 Oct 2019 17:55:50 +0000
Message-ID: <BYAPR04MB5749AE37B2F62DE4552C6DDC86680@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191021225719.211651-1-bvanassche@acm.org>
 <20191021225719.211651-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf294a6c-ee12-4713-aa5c-08d757191355
x-ms-traffictypediagnostic: BYAPR04MB3829:
x-microsoft-antispam-prvs: <BYAPR04MB382932A878BD3F47F926F67686680@BYAPR04MB3829.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(189003)(199004)(8936002)(256004)(52536014)(476003)(14454004)(486006)(76176011)(9686003)(71200400001)(478600001)(99286004)(6436002)(25786009)(446003)(26005)(3846002)(5660300002)(6116002)(229853002)(7696005)(8676002)(2906002)(71190400001)(186003)(4326008)(81166006)(81156014)(33656002)(558084003)(76116006)(64756008)(66446008)(66556008)(86362001)(66946007)(74316002)(66476007)(305945005)(6246003)(53546011)(6506007)(55016002)(110136005)(54906003)(66066001)(7736002)(316002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3829;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rTxUwg+uZkCF9SrKH/D1gGvVvwGegbfSjmt1d0pJGNLkpBoQi3tOGh5j7HeW/PW8s2soKLENQ4BFC6HS9DiSiVGWMJ7wXze2yp0nleHp0SOH7XaiCED/ufGvXEhd2BpKMa98egYTUcReYIN8GqehmLWsMZan3UV8afs78phjKhQK67txZE3AX+9UO/H2isESOlYFX3BdoCexXx4xX8RWuyghknyJIh416Qu/BNlgK6NzvuqqFLzA4qVjK7JUnzhZaFHYo0XWGz80SyOJR2SW4A3Epo9Rmym3COKzFFb/e3byO15dOTC3tHdCwWhkIffXP0HQX3k4vTm6w4wmWefyAbG6Q7gQmZ4LencDIoR3yCQ642H01CE9QxCN0ZChxkVKLVvy37uSdzwNpNThCAOfx5yvknKRImEiHMVqeioWD5lXpM+dp8T0LwxHX9jOZJHe
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf294a6c-ee12-4713-aa5c-08d757191355
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 17:55:50.5795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQr1rVmuEMv0nHQX9Ygj+5IrRzrv2HD7v2EIii/sFNXJqtZKNqpNle0Tr/9xIJgdf7PX8Erqy40jvKgAOKl0QtRocjwuDRwlTrqK83KTpY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3829
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Look good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
On 10/21/2019 03:57 PM, Bart Van Assche wrote:=0A=
> Make it easy to use the uptime_s() function from block tests.=0A=
>=0A=
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>=0A=
=0A=
