Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6206C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 04:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B90206D4
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 04:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IPAWFgFh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DOmHuwV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgEPE1i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 00:27:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22937 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgEPE1i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 00:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589603257; x=1621139257;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Yo7DFDVRrdoJtxJR4s1oDfb7/wqkuR7ZuXeH1GtSoCE=;
  b=IPAWFgFhaptlLZC6bO3bgCk/2STKAxE26cH4LP+g+kYie9KLQ7TiSv2N
   8vXgWmmSI+q/eLKywElaxQWv+H2I2LIgMEWKvfNmnPWkp/mFQtSyyZD9N
   91xg/AReda/rXTYGCM9jxgNFL+1R5EbwmLVzxdBmQ8NllII8i0vFrhCWS
   M0E1u/OKBx9ePP50Ye4aoDl5iS+x7vhQHPIpOkPeS3i69IUxtUVHuHtoB
   i4QjMYv2km0JA0kfBqK6i0RxZon3pv6p8WF/+TX3F+QtwCd0UxS1HU3hy
   IGms65bamtcYXfVPXXO0/IaiGCSLJj4c/8y5WAm6dT7Z3E4SGyECNnxZT
   A==;
IronPort-SDR: 6X8EZp2TIdc2cUhazQ2BTQ06T+WoiY0IDEvk8XYfhDEaGu2jox6aW7H2jmhqUPgQSrVd4FTe1b
 ePwD8g+zD4RzriyOsTuZcDalqmjjzyA5HRV3CPpAhS57Os2mwy4RWzu8wbN6tBB6VE6wYzu3mk
 pjYi/wqU9HYhWD5UharbJnD+aNREB/NyJ/YyhSMlZHaZr4OIroB2TbwAvvbwyBNpJoeQvddVQO
 bhGhRVjXoQPvw/VOqlPy6uGgyP8P3qzV6AM1jx3ri8KKw+PQgqhXw/cnGnMIIh9DEfYYShB0Vt
 6iU=
X-IronPort-AV: E=Sophos;i="5.73,397,1583164800"; 
   d="scan'208";a="137829912"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2020 12:27:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiUneqad54pKkhWdPHnU7zOuF55pvd6BOPyp4pte/G+23AcDrDeZil1YbRa6UHnCaxFqQABrz/2LOjxQh2UEv3Ld9s7j6T0zcFR2ONDb0vWrho5JrWm/nrEdf7h5fDA0TG8FhCq9N1ibUsf9q0Eatw7IN26QlJKDjJzWI15QiN5/T2euggNQZ4dHMvUjbpVDyRGB9pm82Gb6buZim1RPqxCETCdAK9rHEbGuRm4/Ko/uxBPmnxuRWyY+a7QDXZYW7RgmuskTcpYC7wLsD7+nA7cTNnogtyRNrW9OFg8N7BHcN2MUbdmsnn9mMjUjN9rAvl8tdjvSdwf7vCo4T4Cykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yo7DFDVRrdoJtxJR4s1oDfb7/wqkuR7ZuXeH1GtSoCE=;
 b=Du8Xn3fSSXWTVQLPSJPPdsBtadwoJNMJJNQKg0FJE0sm0Ove0FJMarIW+v3syI+IfmLCTBCajws030d5mdJc5QfPgx9ZaqYas9jq5IxIDQdcAOcacrO6LgdaxiZD+f+AHZ2M99A7W5aLy9VjdrxL1R2CD58cI0/Y4QlW5hTiTM4oQkmIhpfPUrkEIz/Wqkk8mRHUqfhFHT/TVlMzQtvlWaXMBnlW0Lw40J6FtAd1gOCrxfoEwNa2etO5E6nJ0GZnKrZHoGG/eXRgBiVN+WlGoxW7033yb5sdxjIE1XbqX8HqAKlXxC2fRXRXJA9KYiXJweopmXYyzUX1GbbFHuofug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yo7DFDVRrdoJtxJR4s1oDfb7/wqkuR7ZuXeH1GtSoCE=;
 b=DOmHuwV4pdUugTh8uArK9omesLqB/hxVvLXR47NvNg6Drebmne6fxWH6DRzuRWuFmhriww7P/BBvc5OScpGu69AmcZTC8owYR+eZG6cebTuIwuZNsKezBds+UZEgQAw1aVGGORaD8c6r/9Ezc9sVeW3SUsxF2XSVr8JIyGuXLuU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5829.namprd04.prod.outlook.com (2603:10b6:a03:10c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Sat, 16 May
 2020 04:27:35 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 04:27:35 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Xu Wang <vulab@iscas.ac.cn>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: block: use set_current_state macro
Thread-Topic: [PATCH] drivers: block: use set_current_state macro
Thread-Index: AQHWJD/tOYwa7M8zv06RBT91a7YmQQ==
Date:   Sat, 16 May 2020 04:27:35 +0000
Message-ID: <BYAPR04MB4965C5F3AAC0AA7FC78EAA8A86BA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200507071211.15709-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: iscas.ac.cn; dkim=none (message not signed)
 header.d=none;iscas.ac.cn; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e29a5500-785c-4f9c-2a51-08d7f95175a4
x-ms-traffictypediagnostic: BYAPR04MB5829:
x-microsoft-antispam-prvs: <BYAPR04MB582935B7FB0E56B9F8175A5D86BA0@BYAPR04MB5829.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-forefront-prvs: 040513D301
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+jaWlMZsJPQOZMrCAAzhaP73l8Z2zKn9QTBqbb9LpKssCRbMWuZQQUYUmbXLrU9qF/XhHUFIV4wgSevgim2OZ3ZpeicxLhfif92/KqxekefEWoPYF0IwAA4GiVqAJh84Epjl4dvRaZ91PVlElq3PfNeoYuwddJYJK5RmqB461qRzAX9vkgWeGwwLr6eRzSsMyfOhv8SAaT29QOxzV3KsH2uc3DmJGt6OdV5TkuLDc6tLIv8jdPuhN8VfsIjIG7w1DS2mWZ1Ie6m8dy/cKnJsVla0tuawRwTZXi0qMnkpdE/vuiAoQq7kM3wTVP+Zcr2mhyULczzwM4qUBLZ9bgQkSVpZSe7qNNrqgee0U6Fq2PAiTsUH8hLyIsQQlrbbMgEDdpDklos9PferFGjLbHSUTErxq9ZdaOT/5BJTHFZ9PQdz9Yshp4XUNPcSbUDQlva
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(5660300002)(55016002)(8936002)(8676002)(26005)(186003)(6506007)(9686003)(71200400001)(478600001)(7696005)(558084003)(4326008)(54906003)(53546011)(316002)(110136005)(86362001)(33656002)(64756008)(66476007)(2906002)(66946007)(76116006)(66446008)(52536014)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: w34LrE4L9vajXQ7bvhXjLU3TJr/piiAbz+6U5S0fkztGJCTqHrtcYKq+jd/52y60bYHxxRFXG+mdocBDjp1f3kZaLomcuvRwcCNEDrIfu2bzmZRM1/7O5osR5fjXXYmwoWSrD71Btk66K/j+Zjl9i2MhV8k17Z6bRQ2/aIzH+ToxMbpNRvoGAhcOP6rGur8XEdXsDi+KgmpFV9sx9/vdAnEp8or3uoDvNUOAPzsv4iQI8j/Jgdk6kwO4rtWWjTWAVG5DALoX7jkAeqrchcZdbKeY/Y0vHHk9UZhjjs/5F3uqzXeQeh6JeKzLhJDcm68BO2kksK1Bq6gjku3+UIj5gsnv5IJkqz7NmqzEUtQtXRqhbCD1blSucYpWm3jf0vzwfkhODeTN/ar3bLXuMDEyZyzrY75UUineOjHakNibBWo/Ra2JHHqHRw0oqMYCD5GPBlL/CcyhMslqqm/YqvroVg7bjFP4aP+XQCOJzNRPIFo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29a5500-785c-4f9c-2a51-08d7f95175a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2020 04:27:35.6255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGq4g6YDhGlfhQ7UARUyixZ63uAaKMRx65HUkejSSzfnT1+cDNgTpAoWOdxMJ1dDiphUYAuIrrXSCBrRS0AI8NNjIkG6UV0W6HVu+HscNzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5829
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/07/2020 12:20 AM, Xu Wang wrote:=0A=
> Use set_current_state macro instead of current->state =3D TASK_RUNNING.=
=0A=
>=0A=
> Signed-off-by: Xu Wang<vulab@iscas.ac.cn>=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
