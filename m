Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9E7FA372C
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 18:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485B4214DB
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 18:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ozIiO5JX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ffAuMZMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfKHSNK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:13:10 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20555 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfKHSNK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 13:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573236790; x=1604772790;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IDxBmt3KYuqN2NlDcwYaXfKMcrU+7BmtyU0UHqLnCF0=;
  b=ozIiO5JXXQaHSc+8rMnk8TAEtiuYT1MztEvMUy2/W9kbOy2LQiNShyfa
   2Kfuqy7A6wSTVlA96SOF17tt3Y5IkK8Z7ONDoapFZKS0GINvWauN4npbA
   7yoNO8sClfiYUfPKDfD4bdBfGQIn1acfTsrHBK/KxyVyVo/nyctPP3Dyy
   XZcTgtmEj/O1pH9Ler8M9fWHPLLLp9wTnfYHrNUe5XzM+Vy49SCfvvPwP
   4Va+cPi+X7FYxVU67/etZE6TMJ55OFdJXP4gyRyf89KjrEXal8U51eH05
   vrA4mmPLFo7K8uMbQWO253cIghiAJxd1bouls9Tf10L1/7PwKAD8kL3ne
   w==;
IronPort-SDR: Q9uCuzVDlV6PnCBpZIV9gU/7gWXSCzZ/TJXCVyvxxLwZRHQcFU6xjwe2ScbAqG1P7Y+5oc6I6W
 edK+5SwQ1+im5t47A5pzfXdHXuY2QzFZgjcrm/MLHYI4h9kUC8u1E12c8E5CWrv3KWZv/t56K/
 AFNw806EHui582rVcyWVRtWPkLu3Kb0/BfSty5N9XSuVySEjXX5H6ACvxw8jWmxNtO0eLT3TGV
 CZvI7drUmdWLKL2iD9GzCT91pByO16a+umKbv/i4ilNwCQ2FImg2Un7vk/ixYeQQzBkIuNmwKt
 cIk=
X-IronPort-AV: E=Sophos;i="5.68,282,1569254400"; 
   d="scan'208";a="122521359"
Received: from mail-co1nam04lp2059.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.59])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2019 02:13:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F03N05LWv/Jg3IhJPgb5da0ivvcDnFjlOZoVasWR6XJ/HB6IrG4dB283zRl8WTTGUI53maWMd0ZtorRSxo90384p97mw7bCtzeF7ivsyyHGGcqhnD1XG+2DSRahucdXFOcuYtikmkC0kd9LKVk/kyMW5KtOHmr7x8Aqo98JnhpD5u+kNMaya93jPqAVTygjQf4RPHPREjwI+c9TJe933OlepT/RoPN+vZhDbRA9GThde+hQ+nI/1mFuPRRwm3ZGp8vhRCZrjAnGKzBPgtyZt8FSrUTNzZ4ReItIDEYNb/orv/8jV3nGj6kCEYWjNq7mjrY1Vb19yrKMjD7eQAbZwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDxBmt3KYuqN2NlDcwYaXfKMcrU+7BmtyU0UHqLnCF0=;
 b=bCyFqXa/mnWrFyHSBLLxNv4w2w3L1/6bGmMUwli818LR96UfFLmJLZST0kTQY0oLcKZdJdi1s9JMd9yUasSii8WcMcErPMheTQt/+8iTSft3pKqLsaLRGkKDm6EgQp6vNV3lJWagOnPt9t1XUNcG6OfoLDHpSsphWJS3c5elRHu4FU51iRcnx947mGWlCC66JVZ7Z+xKNbJPGdoJuaxxIEJF9x/6Bjtyn9IcK7A0a2GJgvlN83I7f9uSGUfLU3JpMGWXzGAoks+pxzAuT/pSiGPQpiz88y3kEHYPOsqVQ+YkmNzlWETnBaGCV40WReJGCnATgeFGVrqlnDDDC4poEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDxBmt3KYuqN2NlDcwYaXfKMcrU+7BmtyU0UHqLnCF0=;
 b=ffAuMZMTld0ShO4FflkmUYcvRS1jOh2cuzQlS2O35zuVV76Iz98TTeczhwvHNq036S0ghEZ3DqAQMR3ltcveZIkpNkKIVTqlc035bX/9zBuH8TQo2B4XQX5dkt+nUsCNtJkbsQ7fYrLdgu39nkblfVxe61k0wrHO4TiBpGOstyU=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) by
 DM6PR04MB7098.namprd04.prod.outlook.com (10.186.141.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Fri, 8 Nov 2019 18:13:07 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::65c4:52fd:1454:4b04]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::65c4:52fd:1454:4b04%7]) with mapi id 15.20.2430.020; Fri, 8 Nov 2019
 18:13:07 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bob Liu <bob.liu@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Bail out iteration functions upon SIGKILL.
Thread-Topic: [PATCH] block: Bail out iteration functions upon SIGKILL.
Thread-Index: AQHVlis6RTlSzptCx02pPsSyxswoAQ==
Date:   Fri, 8 Nov 2019 18:13:07 +0000
Message-ID: <DM6PR04MB5754F53E04CA4B3B96E01233867B0@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <000000000000c52dbf05958f3f3a@google.com>
 <3fbc4bb2-a03b-fbfa-4803-47a6d0075ff2@I-love.SAKURA.ne.jp>
 <24296ff7-4a5f-2bd9-63c7-07831f7b4d8d@oracle.com>
 <8fde32da-d5e5-11b7-9ed7-e3aa5b003647@i-love.sakura.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d362952-3ced-46c6-e85c-08d764774e63
x-ms-traffictypediagnostic: DM6PR04MB7098:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR04MB7098257015D9DE50B8F57671867B0@DM6PR04MB7098.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10019020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(51914003)(76176011)(6306002)(305945005)(7736002)(4326008)(66066001)(66946007)(14444005)(256004)(446003)(6246003)(6506007)(486006)(53546011)(74316002)(99286004)(5660300002)(91956017)(478600001)(2906002)(66476007)(64756008)(66556008)(66446008)(8936002)(476003)(14454004)(76116006)(8676002)(71200400001)(25786009)(6116002)(3846002)(186003)(81156014)(81166006)(102836004)(71190400001)(316002)(110136005)(6436002)(55016002)(52536014)(2501003)(229853002)(86362001)(33656002)(4744005)(26005)(9686003)(7696005)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB7098;H:DM6PR04MB5754.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZYat9TU+JOXupGU1+oIFWBYNQymyWX+lGd6tCfo1+E5fu7Vx/HcR5m/5T56pwkrW2GPo8h0//uqe8g2XBPp4lNW3ZsHBzeCBbzLwCc0QMmBwD/LwdQcCOfWM0K3VVSOLE9Kl9jgwpuS2xJiM0s58ZQAN9o+X6kcnNjWEE6GMdyZWvL1hu4uckQrYoiFltt45DTJd0LDoQUevb9aA5XzE05ugCd23Dy6GhyNrviKu3EYh5jIVSddMNRs3vkchS1sulP8P91LLNv+wxFofrHfNlBsRj3CqVe1VyJ9kF2cPqB5VfIEXALA7dZhYMbgRNTg9tuQf7CNXK/V2cVsJVNjbddUmUzhDUPZ2CUHDvCYvmcY9S3i8SsC+UwKaL/r5Akti2ka+ktaIehHfeAJ2HrUHce+eYQoBdUbPoEk97MRb/sVv245HDE8F0oeRMu2hc4vzsOmS1wnGsc+ok5kneSeLtCodRaMSQ83MCdmeTRrmOXJGWVYMCYarOCY3NR66oAQ6e9u9tGoLbmCF3emWIOTSuyS/zy/FApvedle5EUTJYr8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d362952-3ced-46c6-e85c-08d764774e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 18:13:07.4581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udTyNY2LenzFPb0xwo+mT+vf/6eltqEt3RhsGovQgvkQh+BzjBeHDS1hZgsRjC2PyQzPDMqekscZWLaRBI4hnbx58v9I2BuWeXCdPv1URRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7098
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the patch, this looks good to me, let me test this patch=0A=
will send a review then.=0A=
=0A=
On 11/08/2019 03:54 AM, Tetsuo Handa wrote:=0A=
> syzbot found that a thread can stall for minutes inside fallocate()=0A=
> after that thread was killed by SIGKILL [1]. While trying to allocate=0A=
> 64TB of disk space using fallocate() is legal, delaying termination of=0A=
> killed thread for minutes is bad. Thus, allow iteration functions in=0A=
> block/blk-lib.c to be killable.=0A=
>=0A=
> [1]https://syzkaller.appspot.com/bug?id=3D9386d051e11e09973d5a4cf79af5e8c=
edf79386d=0A=
>=0A=
> Signed-off-by: Tetsuo Handa<penguin-kernel@I-love.SAKURA.ne.jp>=0A=
> Reported-by: syzbot<syzbot+b48daca8639150bc5e73@syzkaller.appspotmail.com=
>=0A=
=0A=
