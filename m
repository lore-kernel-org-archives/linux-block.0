Return-Path: <SRS0=L9ug=Y3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED027CA9EB0
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 20:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CDF2190F
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 20:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Te5Parv4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NdajAFRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfKCU0P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Nov 2019 15:26:15 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63920 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfKCU0O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Nov 2019 15:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572812773; x=1604348773;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KE2xpVAovthxX/r6jFmUPMU76rYLErm1Xg0E5fOz/LE=;
  b=Te5Parv4o3mAjsmymym63r2KEreYN/KyZogSDtGlRdHBGBS5k+R+q3m+
   WOmP9Wq7kd3yJ/OQNNcKi8JwMA8f6pKYHnQdS7CpGZe1swuHtHJVVWA1V
   u5zhbmXxHv4ygaOjqaMej9uYxt4/xLhlrPm96XUOITDouXAPXuaaMwbPK
   Kb2UDPqvaHF4nw9SaKE+6UuNyIcERce0AVW5Bw1nasXQCz/nUh3Sp/ZvF
   dbyyrrIPY7PMeGblqRgySdBUQNcmw9Ppk4MrJSwAxoJdVqQADJ6UvTZG8
   u46YrUFG35+c5eGNYpS5UDBcZ0L7ZdlNAx3i3vTJYwHSN97wd007uRPbm
   g==;
IronPort-SDR: 19+ZKUidS4MNybR4jTreSLdncebqc3KD1TH9JT6pkHJuDvzkoKey+NVecCly0u5jNnqIpdCjSb
 d6tgxT5hX9L6MLo5B5Xw25NiN89fAVGfou2ZgZxX6GxltmECK5w1M5RlEopSMP0urxtunWP9Kq
 z6bV5bRm/K5KyH4c9jlWlqZUBttep+XuAdCSPSJnChO76j79q+z+nUsPsVm1xXXWLxwsHTrHdA
 ndExq5sGuyqPkFJwUilYPQPLDvR4El6kVpv5prPO1jNL3YqI4sV1O79TKeFppWCgroLyCCg1lA
 Frk=
X-IronPort-AV: E=Sophos;i="5.68,264,1569254400"; 
   d="scan'208";a="229221692"
Received: from mail-dm3nam05lp2055.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.55])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2019 04:26:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIVDbtqacCXigeKFdeE+13hd2F2jt8nR9/G4JesYgf9r7unjbWLiO3CspF+OOY3TXOb6oPh3vjLrQt36+DXRQ3bmYgNTDSmFTRvAWmLZ1Et9NuhYOf19sQ2OYEPviwwZTBc3c1O3UdOX6qPVQTSZ1LFiJvG9RXEmS5f7IrhLa/jtdBUj+QjlkKgEC3lt9gp7y1T6QZeAP+mdELTxKcPsipdd7yEDqvsWMBh8RXN4wzQbg2SmozbqYjo6f5q9mJd9IEKFgnPK+E7hKjURK3GOXqeow6RkFIrD9lmfs3DMRv/S+TndVoocJCgc0DTT5UmZ7e3uQEmd60k3AzxTZ5UmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE2xpVAovthxX/r6jFmUPMU76rYLErm1Xg0E5fOz/LE=;
 b=SL0vkqmda/XqW0OEuigm9XfmE6S9Tm5KZJ8WuPrJ0TvARASX/YlPPQXwMwR2GuX0zbG1kPvMvEstmvg3m2xmdPl7izeuB5M+HoXCSrKRU6ZgZW+TNdJaw0LS3oKDDisjjU8QxaXOZBWuiHjz/zBPFHExGNIjukmlL4bRl4TlxZyPjyzbu6TlBDogq5yr7NE/69d6honCHiRV1Oeb54B/hR0/0kLU0jXYnxhRNUSv2a7b/5l3QN+Ti/YPHdq8HMu7Wuxel1fs5GH7KRt2zU18dbsAMZnHwbOd04rkhFVFTW713aeop1Vc+9O7gTBRbCWjJoc6SoR3qPQVLuPt9sR4gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE2xpVAovthxX/r6jFmUPMU76rYLErm1Xg0E5fOz/LE=;
 b=NdajAFRV2qIKDfY02Q4UEv9zM8Ql9BXfwJpP8TVbQKn00yfqKAVKxOSTjqDV5wuLR3sAHSF0YeSsDfvCuv8Fhlh+/LKgsUPIW3ad44Oc3sNIdRXlAi+pwRgItgzzfzW6mHCu5unENokR4tOTjUWKAp0e9wmUPvz3F5sDUJt7UWE=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB3814.namprd04.prod.outlook.com (52.135.214.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Sun, 3 Nov 2019 20:26:12 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2408.024; Sun, 3 Nov 2019
 20:26:11 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU cores
Thread-Topic: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU
 cores
Thread-Index: AQHVkVPqDb9QIWc6hE6kE3ixbLET/6d5jM2AgABaZgA=
Date:   Sun, 3 Nov 2019 20:26:11 +0000
Message-ID: <15219C3E-9DCC-4F33-B8BB-C1EC8CFE1CBF@wdc.com>
References: <900885b8-108e-6da6-b565-acf9a813d5df@kernel.dk>
In-Reply-To: <900885b8-108e-6da6-b565-acf9a813d5df@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a29ac7ab-f1cd-4d90-50ee-08d7609c1170
x-ms-traffictypediagnostic: BYAPR04MB3814:
x-microsoft-antispam-prvs: <BYAPR04MB38148E475224B9C2D6B97F49867C0@BYAPR04MB3814.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(7736002)(8676002)(305945005)(6436002)(26005)(6512007)(6506007)(186003)(256004)(6486002)(76176011)(2906002)(478600001)(33656002)(6246003)(54906003)(6116002)(558084003)(71190400001)(71200400001)(4326008)(316002)(3846002)(66446008)(64756008)(66556008)(66476007)(66946007)(229853002)(102836004)(76116006)(66066001)(476003)(81156014)(99286004)(8936002)(81166006)(2616005)(446003)(11346002)(36756003)(25786009)(86362001)(5660300002)(14454004)(486006)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3814;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jrQY+9Oei3isqrDAkS30EEMY0GbKunFjSQ24xULzYdBMTrTjVmWA15MsFYkOv6XV6LFonJ6ntZUIggpRJn5sxx50s4/5XlBC8DbrwpyXfJLGXY+Mxe8rDuOIZ2QikUlBbvFqbdBZe8E0btYMtu2FK9AVA1HFgV2QLTili1C6Y7ImS7Xo7K4q2loDBycQQzND+aAAjZJrtgH5GqrptEZhk859QZrFSRTllFpL5K3dUunzGIeydVNAgH+fAqiiIpazfZdiwfC3EQongpmeBjmv5PxF/1Rf5y+VY7u3jR82l/9jFjtkE50cGek4yAwsSYc9x4MbvhJfZfnkCN0azAma/0VmLJ4kb17uo8t06NEhPhsDaFSyiN54h/9xu1+yAC6okroCOTOrmA/ZlFDOuMObAfetvUudToyWDr86BK29PhVXsjTLxP11TT9nNgzBbyE4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D0E783E6BB779498B15493017D78D3B@sharedspace.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29ac7ab-f1cd-4d90-50ee-08d7609c1170
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 20:26:11.6134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBt8gMv9nV4QjiUMXwXbLPivUubXUOzeDWE5d4YnQ0vVT/JbfAHYP8HAMIYvUroEdaN/CPPFDiSDf9bnN1wz10Az8sbvKD6ztJ72hj7AtpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3814
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Okay.=20

> Just more noise I think, really wouldn't serve any purpose.
>=20
>=20
> --=20
> Jens Axboe
>=20
