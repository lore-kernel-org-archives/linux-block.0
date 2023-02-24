Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF8FC61DA4
	for <linux-block@archiver.kernel.org>; Fri, 24 Feb 2023 11:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBXLmD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Feb 2023 06:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXLmC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2023 06:42:02 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A6F42BFA
        for <linux-block@vger.kernel.org>; Fri, 24 Feb 2023 03:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677238920; x=1708774920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dXsjSAYW0oOIIrx8gk/t1WoEgK3tKo7JLheQSHwJnuI=;
  b=VEvFBoCA6pWTEIDyI/3tB3CBB7PdqCp/EjdBWNFhXlhbx+vB4vJy6ewf
   q3jCGvSOE1PYP3i9YWhm9sqvMDMt7aQTKLnsmT6qV3mRC9cQOk5tOQD9J
   d6uC8kbHqOtFUcOn+KgIzWB3ieTBQEoHqas+Ilb/enw2sJFcZX3CP0V0b
   mlg8Ur6+Alkg+nL/YiUDQ/Aq9kuJmwwu2DqsFO8rcewHSZ8bfBFDO4cjE
   SRSpW/ZsxBZZJMkn49Vm3hMfVL2l8Zfbf2Wi/ZvIlujtVcXbfcuQptUnw
   /o8pjwkMsEPmbm7zPz+W1N7PkbKAwfFZl1C1ZAD8AGOrN37YBtXe3xY2X
   g==;
X-IronPort-AV: E=Sophos;i="5.97,324,1669046400"; 
   d="scan'208";a="224139984"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2023 19:41:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpA+jQQkBouQq+YuMJ3RyVBQtpNe5tSYpt9jwyDsXce5xXshMLpcwOW9u9Kry6g1Cqf85v4UHHndx0yOTNkE82XtN8a8hIfIqBQPIcLquSkbEHwsEPy1nYY8307VKwRQUHYjUqdXznYsa04I9TJoC2rtC2ld1ONoX/51tl0dt9bqmTu97CVITji7O6S084UPfBtNvLyQZOMYCmdT32J2SOJr4Tb/0DmEb9+blc94M0/sDE2uLi0VzBhQrOo8cCWbUboZROkm71EpDIaC3aBZnDr0i2wpFyqzN86t/xSOPSDMSnmnpVRCF69vh2SofVHNpvHtbY28JttZVrhjMQTGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x96gNHJeOqC9/40h0mco2JCj/MbNS6dl0q2a6dFObeA=;
 b=XhpWo/SNmjII01Dm95icqLpW/WDCFFNuzOS/gcI8z6kBxQDE4HmJz6w48Tq3bw68VNrQLIkd6IdMxSuOv+2U5fZxNsmLZwrpTdjG5LdINzMuUi1HMD0qmeVTxSuYjUbgauC1JTH4D6b3ajubU0gFeS++nwlxqqPpJG7L1HQQzINVJegwoOgkzo9kyFfk8zwOyCJp4/zDV5MC3QYpoA2tAXe0CbuKMdt697aN4bT4AVqXG3/4mr+6heEhpCRN6FvQnlozTJQ22Y3vslAgDj6/3lrsQr8ptcVsVIx967UyVdUFsbMOWtBW0uWL5DiY6vnNhV7J4DGEYqkMN/5NZQsc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x96gNHJeOqC9/40h0mco2JCj/MbNS6dl0q2a6dFObeA=;
 b=oqAlyMKgKfM6X/6vWo2WJVHK12L3DNUfR/MqtSWY2karcARSwnhLaUCrbradTLX8A+FOp+YkGc7bIRp+AtSnhprVKEL+62e3DWTE/kbt3p8OLnNOjtUf7aA9BX7CZ97VGf5DjRYoSlnvVWStnATRPeyYZa+Vi0LGKmtwi1a5YlE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CY4PR04MB3765.namprd04.prod.outlook.com (2603:10b6:903:e0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24; Fri, 24 Feb 2023 11:41:56 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%8]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 11:41:56 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v3 1/2] src: add mini ublk source code
Thread-Topic: [PATCH blktests v3 1/2] src: add mini ublk source code
Thread-Index: AQHZRN4GILFJJ+eZuUC9lhofX/G5Ya7dwCUAgAAKEICAADYNAA==
Date:   Fri, 24 Feb 2023 11:41:56 +0000
Message-ID: <20230224114156.yxul4qb323pswteq@shindev>
References: <20230220034649.1522978-1-ming.lei@redhat.com>
 <20230220034649.1522978-2-ming.lei@redhat.com>
 <a20a449a-73c1-c7dd-b100-89e346c35828@linux.alibaba.com>
 <Y/h1LQbf+brRw1mo@T590>
In-Reply-To: <Y/h1LQbf+brRw1mo@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CY4PR04MB3765:EE_
x-ms-office365-filtering-correlation-id: 0fd24b27-3a4b-43d3-edd9-08db165c21fb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzDzIgZozO5NDvtMQSiCMpqjvFXCkhZxvQBurqweWdFDjjlUWoa9yE9PTpaAGmIb5unqrQ87wTSZK9EPq+flsw+aWkNcvylaMv8aFipRd4bTWWdJ5xam3ywmO9uoesgViOMayS3zcarkKIKGvGrNT7DbJWmBkdPC/gDJzQkGoPpPDwpp6ArN5iLrtwJ+Lm2NgQCctHFPYrHETUx5tZnWI8losroI8tWRBLw0x3xv1xhgRUBTexer9ggKRzJUs0ecCAH6+WoAPr54NcyC/+FLlG+bi8OwM+ualpSAH5o+C+16peLF+yATViSKbwDrG+IJ6Cet04uNRTyE5s3YPM0fgPKyFPEzMoQ8SWdBFadVyEDu049Rmy+1eVyaVkzhRWCkxioBBOpfD7AUfCyZi8mPB1HFr8yIFABsD5QlOM3YfXN3WPTvQQjyCK01nosDjMFjjNqTSPbdTa9Jp17A7E01tFSjIBtBSgX54lYcA2GNtiElwvRVcxkMUAYPTGN0kwI9Erhri4I1qWgc8XfxrRIy97846zJ0wyTAlVvLxymPUp9GD5AUN2EzYP65xhZjwy5KPizkl9Dgf0dGi6II5pQn2XwVl1dhB9Z7Dyj7jKYbs5VaBmbjc9tbUV6XE4MSrwAGc7sdvcK/oTDflBAI1S2A1uVO9WRJneHag5sJVAgSfzZo2oWJPcEnUtEzpEF+7BOy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199018)(26005)(9686003)(186003)(4326008)(76116006)(82960400001)(122000001)(38100700002)(38070700005)(8936002)(91956017)(8676002)(41300700001)(66476007)(6916009)(64756008)(66446008)(66556008)(2906002)(66946007)(44832011)(1076003)(71200400001)(5660300002)(6506007)(6512007)(478600001)(53546011)(6486002)(316002)(54906003)(86362001)(33716001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E+pEENCE8XBFG4Gc+nuH9aHoUn6RBd5HzaRoq4o6A58YDlmGIJMuF/Lk/r4G?=
 =?us-ascii?Q?jkU8iMrpbnz2TUBPMfhDLOv//Uv4iDTqrRfLIphN7RULvEWx7SWUWibaoo1x?=
 =?us-ascii?Q?4bFyAa0BXhqxWeOP8PIDoj43guvb/xwgFCjmRnoRGaopKiuJJG66m4oiDQB6?=
 =?us-ascii?Q?rM+UjXNbKM+vrOWK/mH3FaPkrmD30TStaktrmgyvviiq5q9p8t2tWbjE1/Bt?=
 =?us-ascii?Q?p0oKQqe93a8btBzuDcgejdoqNaJ1tyAs4nDr2BT5dGvDrkQ9cDxN1irLK+/w?=
 =?us-ascii?Q?Pc7fe+oG0hVYJ70Aq/iNp7x50ZGieaaCDZJjyefAk+5dIyrw/rqz0LDNGB4x?=
 =?us-ascii?Q?r2YZyV6L4wGuum9SFR3DbRcYKAz5fyBgpLAKHZQA62vSWazqeSkYT9kbqAdH?=
 =?us-ascii?Q?S3Ff9HYPcGOSD/U0gox+dpslo0KkzPQnRe5+EmOm8nMuB4BgZLjRlSO5ciq0?=
 =?us-ascii?Q?tjB4l3jDRvgKCy/LVDAG8IgMQEo+iG6jLleYzMDaMU5CZoqnCShJh/pi9gOB?=
 =?us-ascii?Q?9lfJOkLzoUBtpqpfa9zbHTyzDrZ9WKGekVKWQfxpcaXsmdfQTvziTZ6qwJ3Y?=
 =?us-ascii?Q?pkuqvfPPVOY7ENhR5syn5fjgY2teg1w+hIcnUTd72Gwrm28GGMV77RgV8b+7?=
 =?us-ascii?Q?f+eS6uHHhmOpTAIFlyk0Wz4w2mqeOgbYrwlHMFztj7io7KwJkjWJCPtQ8+dH?=
 =?us-ascii?Q?0DSAdlwsA3FaaRlvUhVuy/GxTGHJ5MIizS5zyXB6MZ7351kD03j9+NtxYBU1?=
 =?us-ascii?Q?xid3HE9/tAElKBeaJRAb0yctJVm+Rt0zK2kwg0D0t1pxhb7Jujxuhn2nlp5I?=
 =?us-ascii?Q?5Oz8RQlXyebiHbUm7obeIxKSvpmSFjvDo+n7f/td60zu7GkeV6WxEkHznYLG?=
 =?us-ascii?Q?zD40CFv184d+KQlzRynSvwc2UGm6ejknU2bg50AoFeh+eDlM0ZmbWgyEoFD0?=
 =?us-ascii?Q?vEZZtp80EvQg5FUcYP98fghzU6h1bZs1mx8Pa9wAH4w8F4OL3mhnl1+6Tgr8?=
 =?us-ascii?Q?9dQ+DCt+FUuoPAbHMC5WejyhiSf5xaRGIB2PGAmN2lH7tNCopZONxuVCBvY9?=
 =?us-ascii?Q?6CdRe+EKCUWiMFtBufjboH9ZpNPbTXUV2OSlRBwbwKIkp3dcBACQckm+foWt?=
 =?us-ascii?Q?cCXhmG3Px/AMWa/uaOvED7sVorf13KwH5KhcVhhL7twczPthGz+Xtov6x1U7?=
 =?us-ascii?Q?4J39WYmTRqY4a+0OMWfNCIa71ZSOZlhguSgP0DpY5x/D20LHIY9ImZ91hCse?=
 =?us-ascii?Q?ruxV15exNu/Vc6oYXD7WIce2kDevsylKmNWVeAfIjP3YQKBwL+LzTCLZaCxN?=
 =?us-ascii?Q?988XS7z/gY/P3qszZLW2xtTiRviJ735Gb0DWggtLtvDhZD6e6QE3N+r7aoMo?=
 =?us-ascii?Q?coBNV1QURenljDL6qi0HAeWFZrvwSp6u9RIySEYF0qWgJifWJjuYJXlJDSDR?=
 =?us-ascii?Q?EnWhCjAbdaIv9rEzSwVqpce9PVxn3t24OsKgu+pXTfucffeQCNZ56gjSR3yN?=
 =?us-ascii?Q?UzlB0VmTu0m5zAtG1PTx/EzB6btUKjUKR9/WHTHU4Azr5rfHrTmCVk94MkS/?=
 =?us-ascii?Q?AagK44XaXaBCGk5uj+pdHkiUDOpgRV0WRN5LDyV3s7Cl9NSGmGCI//9QMobD?=
 =?us-ascii?Q?ZQph8Eo2ObeNTb1xJkEsp7c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95E45BDF86D1274EBF73ED489933E12C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: asVviEOITcp7XSbhltbScauav7c1c9XMssYOT63T1xKywMgU7/Lz8BfwQRxcMAJE5UbOURPu9Ngr01hTfh9byTI5I5kTIT7wr9BWDPN8UoQ8J0ljk8ccGP5m6eNtOje30qZN7zqENYVCt0ziO+FDNtY4gp3vqu1TI537WSEtKfDuYQR8B54iGFLon6FT4VeF3P6PjGu2H87HEFEvZ99VeMc9rzLt1fyprrN5Dz8wPoQdirO+y2zJZE8PjmIYsz+VsTg2qdG3McOMtfd+DuAc28lwVfwJAymSAEDxGWo6rQOu4aqURk8kPVYueCcfy1a8EXOQygWqiAbiQLOEPPu3q6GDpC/x324LfGscONuHBcKCvQ9rx6Re+3uHyRzSemdQ8H1BRIn23S++ak0s9cxv1YV+MmC4aHuEk1E5+5Pui5ivjpn54qQ3lHagUc5UBNrNWg9ceoYFdBElNit2c08Oypees3HNhipj8QVu7/18Ab4i0WnlZattB7ypLBxGtnPqfkvJJ9aFtlIMy9SqfDKUe6lo1SlanzbqFmyLRbJqBS+ekq2XqvfpM4nyqQ95NLGYG605YniXs3LZcj35v9yc9mt6+3tpoQZopYjZvAc4DthRzM12hertebim/6nRlEEYWDNx/2/oSL6TOgCukOMMZ+RBNXe6fKOA1aH9M9qzDY2Ib909FWXVH5tM2euLELl3wfhHL4l+Lvccxtj6pzs5IOzSWK4ze5l9aua9K6CgcyWpSQSQtxAtT9SOWcZjMYxbZAYiCyEtApPqgx7icMybJJc8fV/FBa6HGJlcpKNQRYtTtPtbA8CEzdQlAEPtfHqUXi9yRKbZq8Ix05zxcaHM83gWiQ98+RQL8sh5PmyciYA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd24b27-3a4b-43d3-edd9-08db165c21fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 11:41:56.5392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZiCP79dsdkqgrWKOmEK9QCNRD6+6MCwrxX63ZSJ/goHJiB/Uw2Q86+dw2YDCepm+xnOqNXxi2xwICVVkNzLy0iwzwqXRALJrESAPCrT7bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB3765
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 24, 2023 / 16:28, Ming Lei wrote:
> On Fri, Feb 24, 2023 at 03:52:28PM +0800, Ziyang Zhang wrote:
> > On 2023/2/20 11:46, Ming Lei wrote:
> >=20
> > [...]
> >=20
> > >=20
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  src/.gitignore |    1 +
> > >  src/Makefile   |   18 +
> > >  src/miniublk.c | 1376 ++++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 1395 insertions(+)
> > >  create mode 100644 src/miniublk.c
> > >=20
> > > diff --git a/src/.gitignore b/src/.gitignore
> > > index 355bed3..df7aff5 100644
> > > --- a/src/.gitignore
> > > +++ b/src/.gitignore
> > > @@ -8,3 +8,4 @@
> > >  /sg/dxfer-from-dev
> > >  /sg/syzkaller1
> > >  /zbdioctl
> > > +/miniublk
> > > diff --git a/src/Makefile b/src/Makefile
> > > index 3b587f6..81c6541 100644
> > > --- a/src/Makefile
> > > +++ b/src/Makefile
> > > @@ -2,6 +2,10 @@ HAVE_C_HEADER =3D $(shell if echo "\#include <$(1)>"=
 |		\
> > >  		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
> > >  		else echo "$(3)"; fi)
> > > =20
> > > +HAVE_C_MACRO =3D $(shell if echo "#include <$(1)>" |	\
> > Hi Ming,
> >=20
> > It should be "\#include", not "#include". You miss a "\".
>=20
> "\#include" won't work for checking the macro of IORING_OP_URING_CMD.
>=20
> [root@ktest-36 linux]# echo "\#include <liburing.h>" | gcc -E -
> # 0 "<stdin>"
> # 0 "<built-in>"
> # 0 "<command-line>"
> # 1 "/usr/include/stdc-predef.h" 1 3 4
> # 0 "<command-line>" 2
> # 1 "<stdin>"
> \#include <liburing.h>

I also tried and observed the same symptom. HAVE_C_MACRO works well without=
 the
backslash. Adding the backslash, it fails.

I think Ziyang made the comment because HAVE_C_HEADER has the backslash. (T=
hanks
for catching the difference between HAVA_C_HEADER and HAVE_C_MACRO.) I thin=
k
another fix is needed to remove that backslash from HAVE_C_HEADER.  I've cr=
eate
a one liner fix patch quickly [1]. It looks ok for blktests CI. I will revi=
sit
it after Ming's patches get settled.

[1] https://github.com/osandov/blktests/pull/112/commits/dd5852e69abc3247d7=
b0ec4faf916a395378362d

--=20
Shin'ichiro Kawasaki=
