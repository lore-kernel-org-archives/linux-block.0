Return-Path: <SRS0=XUQF=5A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB92C10DCE
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 23:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43BF20409
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 23:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gpT3mxi6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NGCKz+ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgCOXWs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Mar 2020 19:22:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42194 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgCOXWr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Mar 2020 19:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584314568; x=1615850568;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cknyvMjOBa4pJHH69WoACQgi0pQZ1bfzteUUVGh3XBI=;
  b=gpT3mxi6gXvaXPBztPUOy5d6SyQhnXWYuNuKCaLwJ4tZYbjIdIDmg3J6
   9MXCKLGXYI6ZP9GzxvKvT0ltCuc4C7jKolBqkFcVONzr5I3GwYqjeTXPE
   7Sb2/DF0slrKNg7W73/H6qfwytmsh+Z01nDwvIF4RjoPvOMaDR+WIrPAq
   yHecwrHnYWHoIPGBJtIbKV0yWwXF21YTRhuCeQKkcjHgkq26mJP2YsA5B
   /J1HajFAwt5SnGVz22yb8ibMTzFIIDgsS0NFyHALqVsAQJlgac1xVRtH2
   FhGPutV8oUNJY6VPfkaz4h6m8YswKC89kUrVscfl2SjCsHjYILoCjxguh
   A==;
IronPort-SDR: D0uoKL4EwVPyidoVjw51P/BDS2mPz+I5+JF90MGp+zcyuf2aBjOPsP0LYVqrCpC/9c+fdLX9Sl
 hnJpQiC7tvhabjCyGRNFTecWV/KonSLiJq4ZWqEyWjU40u4HGuldWB/K6HGi29lMJ4Mjuo8I9+
 PeaNoAEGN7Pw2ouXXbxgM3MssejcfBOBnjx+uLsN9BArkywncWWeaeMub9VV7zZaTzr8CtFfyr
 DcUpGYIvBrVPAexqv1t1XK/w61Gu8eAr37YZcCkL9YEtJv1Oc/M0Q2HNaIy2H50klSYXKDmpPv
 xtA=
X-IronPort-AV: E=Sophos;i="5.70,558,1574092800"; 
   d="scan'208";a="134013726"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2020 07:22:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuB3RtyFP2nX+8W1R8oASW4N14/5nFeXaf7kQDeiPvmVNLJhomX7i816x+VxiRtEy/OhHpG6sTqgZJkq1Ez6xNXkehm8sYO+ZlBea49jQNdYCnfOp12Gp53+Jo7/pCWAqK2SNXCDDlg1IirMv5GwATLyZTWsznwU1tFk7NUufi6x7krkGGpAKV5TqvO2MpQUhVgFZpa0bExdQLrg3o256QOqBaQ7bhR23pnpMcBj6Yc26h6gKUrAwfXhEtFJWO5DfBg1gw/sgLmRXbaHcaAf9h41JMo6ymMGaOsDbX/HUpPTl3VX/EuGiT4Kl9iAnqgoJkas74f3kvRA/zuXUa0SXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cknyvMjOBa4pJHH69WoACQgi0pQZ1bfzteUUVGh3XBI=;
 b=dqmhNwfQQJ5kBn6meq7NUVmtz7h42KL9yRMNtXjThFHUo906c33pquLC6Ebmp0/QnjLHjfFbHoCkFDh3DODC1cJNC3kgijnNaAsGA7zKEgOEokn8eaih9W9knzK1Gc12Z8fPir5lUgt2LLcQbD6jjY+MenxBn7lvHdv+/N/hNuA41Azyt5vpTsJSn7U37KfyhodSLM75TVkeEbxEymNMTf/MJJip5myVPThGR+QHysZRlAR4kXfMwTg02SDd31OjCACeyb1RUKguBFbaigjXy0+cEHfHnYLtnUSTcV3zA1Cum24jM5mHH/2uB0F6GXyOAI9BPZN+I7OA5TszChlpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cknyvMjOBa4pJHH69WoACQgi0pQZ1bfzteUUVGh3XBI=;
 b=NGCKz+ay88peMyCwupr3V7BykTZ4ZKOTpiT+miQ3HhSDz2fLanBmY/mlxH/9g1xyxm/7CEkX4WQzxf9orMvzoJs7BZzJvDCuzdyCABnaoy8gDqAmflEH7Y3NtIOHvF7Q9PaQIY3lQ5V56H68qSuixb4ywP0TW72+4Oi2o8l8tCI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5255.namprd04.prod.outlook.com (2603:10b6:a03:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Sun, 15 Mar
 2020 23:22:45 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2814.021; Sun, 15 Mar 2020
 23:22:45 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 2/4] Use _{init,exit}_null_blk instead of
 open-coding these functions
Thread-Topic: [PATCH blktests v2 2/4] Use _{init,exit}_null_blk instead of
 open-coding these functions
Thread-Index: AQHV+xb3KK8TwT/UvEyj1hcTrjtU9w==
Date:   Sun, 15 Mar 2020 23:22:45 +0000
Message-ID: <BYAPR04MB5749DBFEB0A089C968CA92A886F80@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200315221320.613-1-bvanassche@acm.org>
 <20200315221320.613-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c42d3efa-db7b-4fae-dbf7-08d7c937c4a3
x-ms-traffictypediagnostic: BYAPR04MB5255:
x-microsoft-antispam-prvs: <BYAPR04MB525581BEE02C9A0DD63D9DC386F80@BYAPR04MB5255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-forefront-prvs: 0343AC1D30
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(316002)(71200400001)(81166006)(81156014)(8676002)(2906002)(55016002)(8936002)(110136005)(478600001)(26005)(186003)(9686003)(4326008)(558084003)(76116006)(6506007)(5660300002)(53546011)(66446008)(64756008)(66946007)(66556008)(52536014)(86362001)(33656002)(7696005)(66476007)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5255;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L/KUj7UbM74tYHYdzQ3bJC0QIu41GyAGMc7FdRDRPJagykuoN9JVAK31O/Ri7hKHmflPbrAWQCDA+onpha85mTZWuseZM+A6d/cxwN+MuAU3YDlctulDRsKRMCCG2F42deM/ie3Z19XIw8G98gpWBo2uYdCf42YNI1fXsB8O6eOd1qApxc1vZ8ymLAwCr2OzUZmQMMztpCunqqg/N4clKwH8rwzk23hb78iUt1XZAkT8fvivyT7sW1lDmPziH15MtOYDQ8QotW5OTgC6966a0HOZdNYRcNVxPQ8nn3Ddo6HuiBswxvTFULLu4VN6TQWVDuLFQbMixQ3Xx/Y2KpKop/8/qe1NOwbr5DKog6bhxR5DJgPFaXV2LEXsNeSShIaC3FAhN+trUi5pkTwCuu6kGWXpUjWacP2dfKUp17KWPzz2ZYGA9aWB0ZQIJ1TA6qdVQFOi0/26Nl0NI13svoaMeRFdF91y+H9noVYqJEAGRWU45tFFAWEW29Wvo4MXI4Gh
x-ms-exchange-antispam-messagedata: K9HfygWrJ3MiOsQv64jyc7pJoGoukU1kcyLQ7MyZiq86nT2MnGASSumw1u/n7/t3ZpJ0vy+pOU+o3QxlxuVF8/fSBs2xxOp78CJ9nUxpLcCd4A4XVWkEKLdeslFBDbBD7nlr9VXd8cMfEzpH3Plo8A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42d3efa-db7b-4fae-dbf7-08d7c937c4a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2020 23:22:45.3982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dkNhG2rRmpRn7wkkwuEMO46Uj83H+g+Cgtg+jW0JNw87o5tBfGsJ15EtPHEptv1Zc5qhzLQoTIjGqnBXvLo52rZ6qpld5WfeE0v2Je4uB1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5255
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

LGTM.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 03/15/2020 03:13 PM, Bart Van Assche wrote:=0A=
> This patch reduces code duplication.=0A=
>=0A=
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>=0A=
=0A=
