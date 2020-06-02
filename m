Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50BDC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 03:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930CE20671
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 03:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jJPkSTeV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c7+0Cghh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgFBDKr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 23:10:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9483 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgFBDKq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 23:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591067446; x=1622603446;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JQcefYCC5VGy+UIA0s+KLf27+1s9/W6ZGewubNnw3TI=;
  b=jJPkSTeVmUy6fR7v9laE7y5dcIL1DD2t5WFNGZqT/ppIb1rDefDb2qq5
   GbkS9zptz7hR1bST6nBieJi19KPqlztA+ycvZXv39yFaj9RQmQp+DSvfq
   u3EnDMKbsHoYr3juJWMOkPNiey85swq1AhbX6A+zkCF2hRHp55q8PktcB
   PRCXZ6ho8du7T7bIjsKqZjryjT03uTh5u9gZn0uuiv0gKwRM+5Tm9et1g
   jXeY69Y6KpDaD9enBf5RQR5zonNbu4jSaz+iKdxd13c0uh17JJSFGW11c
   ObEjfuOXZGFZA7AknPeLz4Msj7+1nPikOQ50HCYMNDsGU58jqrJH7lVz6
   g==;
IronPort-SDR: zJrg5ispaoeJARWQNiQHuBk4xNyy77QqQ8sYCLTMjlqP2MyQZQE10Q3R7fi/3ck4btrGf/cE9T
 quBGHLpLNiz8UPeyK3AHHolPIz/G0L6S8kGcq+xiO0w28x/HWjIL0OwEP06OlF/CLK05W3nk9X
 bqhptlmmlWs8mSFbCJOKPoYYTBc3SHUFKFBOA+0U3HG834hqBcsRBnrg6FIVtL5RVE7XftO2oH
 v1Qkfkyee0fanS4y/jZHKuVWrfPejdIDTehDi9Dv2ZsXiaHgzoegpiX60CTD054V3y9Ldn4hqL
 k+g=
X-IronPort-AV: E=Sophos;i="5.73,462,1583164800"; 
   d="scan'208";a="139316092"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 11:10:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NodcfUHEKVS6cniSK2qSrGEqNyweMphhp+TA8v7v4UWRo9mPhtoWi52V9+oS4pQVJ7JgsUuSfaM1nzpJA/f8MO3j1r1F4StjjVcxdAzuoIyWoowxtzLVYCYmcv+Xx5V9M/ZHvTHzAm0ykue0ya9CzTKCtLq5CTdugtNnf9HZx+qBnrjraeli6r+vS8K/WCUymtbIypMD5+B9OhHD+PFi8hHksCsuflyGvz3ulyaT2izb73km700Cia9LBjq/MdBVRSOCvo4UBNcU++TYkI38EP4+rE7y65S8+Ql44PDtgM2aSE5Ffu/+TK1WT8dgMsJuLjGjP61lnd/zxC84s1+uNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQcefYCC5VGy+UIA0s+KLf27+1s9/W6ZGewubNnw3TI=;
 b=JpiFS85W9xDMQDr9H2SCBU0V7c7EBT8U0ZfTjGgiOXZ8f+qg9CjyGFNpi99ArPxGWp6K3kgLmphaaFAEVjp7AAu2g6vlyCKtzGOWDjd64hFR4QDcolkbMo3w8kNB9y6ZFerNT5TUwP/+JfvpilXK8SFC1zCeRuj6C7rQwA9oUuOZZ5FU8dBjIcHmPDISRwkwO9A+N1r8GUhPe3wvjVd95VkafuAbmK2Asrmgifmywv+5FZE+U7GzCTTtMUBI4gxMupBooX8lbYIHqaBWcgY6gsihOebuAK7me8c3sZL6JYpTVbs7JcHZ4MHPo1757TdsdvzDHsAfCLP+mIddft/msw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQcefYCC5VGy+UIA0s+KLf27+1s9/W6ZGewubNnw3TI=;
 b=c7+0CghhXkBJaulSsx4hS9xH3cQN3am2Fm9gQRtDCGTgTor+pq96WGNrpALcnL7H2b5UE4bxAD5lX+aX5//Oi4aTGXKMOhvy/eH4sFl9NyBET1aZgDN2gktXwSAHK94dkp6I5XbOLe+5gearB+52NL8Dp2oGSwblm2/RUsOPwT8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5942.namprd04.prod.outlook.com (2603:10b6:a03:110::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 03:10:43 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 03:10:43 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/4] blktrace: use rcu calls to access q->blk_trace
Thread-Topic: [PATCH 1/4] blktrace: use rcu calls to access q->blk_trace
Thread-Index: AQHWOH2q4g8+N2lFs0Oc8r+vgkyZ/Q==
Date:   Tue, 2 Jun 2020 03:10:42 +0000
Message-ID: <BYAPR04MB49656977FE2595A87946147C868B0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200602013208.4325-1-chaitanya.kulkarni@wdc.com>
 <20200602013208.4325-2-chaitanya.kulkarni@wdc.com>
 <8c176b63-8a3b-7086-083a-dde931c52012@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb4ffb82-cd2d-446b-67ab-08d806a28962
x-ms-traffictypediagnostic: BYAPR04MB5942:
x-microsoft-antispam-prvs: <BYAPR04MB5942003C7747BB97C71E3A79868B0@BYAPR04MB5942.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1B6GbIXjwpb585YclaQTqvd9FVeFKOgXiMlJcLYIQKGtNXUJj1uAmZxXEtsiikeCxqqGjNyONvBsElStffhh4y4qXTMmdwo46YD3LGIssjlMias+Es6YyxpX2SK9PnbWZzgXK2MbulihdLmEjn6vUMKTmfYxxCs3RnI9dD0TbO1hOvXWIuCpQ5CQPBmmTueVCYg06KXycL8+mCi7RvxAhNuYJXRe7TWDVKLkHTT2zfUTIA0DTXGQJj3Qq3msFzPEPpFszyFvomN9e0khveXDSfHuy6fs9e2UsIruzE0AQfIgsfipstOoXKOcnFzGb+wADQZYQOxlptrN7iCiWyuUMTHLYSpLrz4Lew93zIXWaHBei4281lUp9kWkP5aDiS2ixdUpLMJwaHrINdnT4ZwAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(26005)(71200400001)(53546011)(6506007)(4326008)(8676002)(316002)(76116006)(83380400001)(8936002)(86362001)(110136005)(54906003)(4744005)(55016002)(7696005)(33656002)(478600001)(64756008)(966005)(186003)(52536014)(2906002)(66446008)(66476007)(66556008)(66946007)(9686003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jJOSkkQgd7sycH1GRo24SDS9vBMk5E3AJ8naaGN75aaVf4oN9kfCc1Zz5RcZ2BCLxZsYL/0zEDSphACqmlyHLQ64Oo2+3Mrt3IS5eo8V56taJTSBRSyU5f2HBEcxL7s6EjswpL2E7Gd2AoZJEaqwiMb+vgfaT7/CTxbtLZwSkz2AI4hkY6/mgr8vSMYY8HbVcf5OUocMB1Zih6gQ7xrnAPGZfHfQAfBaTHrE3yk7a365WVGnrI1hj15FtOzqOB7CE9ul8/u6HNPEJWm6e+1u6gR9TOZsS+8CwoVd5Jfy21t6v9qEHCvxVBLqfNQU4NO0t1te8NrJbXkIKauWK6+WjUOg0/xtWAAb/iqF197aQa/hkweqoGprSLCrHyQyLm3Be/pl66S0KT0/mtju7prEW3hbCUahO0HMVkF7rKYk34LiD0S+/mhogh/3cpwJ6tBdMff9fbTt969ZMbmB1DHwdqDjJim9KEcHZchjziv4v90=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4ffb82-cd2d-446b-67ab-08d806a28962
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 03:10:42.9792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wg+vY3yGqLoQNC3M6M5fV4CdI6V8zQu7mzcHOksLlhj9OGeDOedlBTtXZLyNkKexBa76oTHZj+cKX3G2wPsdNuIoEtgDlaPemdPEG20gNI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5942
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/1/20 7:27 PM, Bart Van Assche wrote:=0A=
> On 2020-06-01 18:32, Chaitanya Kulkarni wrote:=0A=
>> Since request queue's blk_trace member is been markds as __rcu,=0A=
>> replace xchg() and cmdxchg() calls with appropriate rcu API.=0A=
>> This removes the sparse warnings.=0A=
> This patch looks like a subset of a patch that was posted a few days ago=
=0A=
> by Jan Kara? See also=0A=
> https://lore.kernel.org/linux-block/20200528092910.11118-1-jack@suse.cz/.=
=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
Thanks for pointing out. I think my patch maintains the goto labels and=0A=
keeps the original code flow with two calls as mentioned in the patch=0A=
description. Maybe we can merge both patches keeping Jan as an Original =0A=
author since his patch was sent first ?=0A=
=0A=
At the end of the I just want to fix these warnings before I re-spin=0A=
blktrace extension series.=0A=
