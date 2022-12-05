Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D402FC4332F
	for <linux-block@archiver.kernel.org>; Mon,  5 Dec 2022 02:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiLECJd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Dec 2022 21:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLECJb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Dec 2022 21:09:31 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DCF12A8C
        for <linux-block@vger.kernel.org>; Sun,  4 Dec 2022 18:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670206170; x=1701742170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A6E9IdD++a7IDTo/97pq3Mdyc9fGcf1qZLq4S3F4kuQ=;
  b=b+12Kw1sQDPP2tiIi7vLQBgYqx4YxnglFt9A9oynYRIC04/1so2o4CUk
   yv2ZZ36+BEJ1NV5wx6z/jikoV7qQ0H7cbsKxRicTFYSVx1MVq3XitYh28
   z3w803eljO8cHU7leEzc/iK6VSlreTszZQCgml3jZwanFYLKBFMXGrHfG
   BL6bgX2C0SPtC8FWCpu9fAjIndPc3z6dq3nWK7oZNp/FH3uevxDKTqZmx
   C4gCREjWmgXiGrdLTEj4xElh0fHaFpHw6vY5Z7wdJOoC8HVdmHOBs34cd
   VGEqzJCFkddPWGakUcUR2DW/Qs1Ia7PB3t0LuftM+TBc8AK41H01hyb91
   A==;
X-IronPort-AV: E=Sophos;i="5.96,218,1665417600"; 
   d="scan'208";a="223037207"
Received: from mail-dm6nam04lp2047.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.47])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2022 10:09:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2qDPrRX+c0USDV2ELdUBJ2RCXQP7Ia65kCGYWqbC0GIFkdw8W1FMQy9kfbwpDOiexWU+7IlMJNnARrKuCpGbNXyVh+SUVetT+q6ZIcZGWyxd0FC4WopdTRndKjqNRMdj98wrE2pHz524AJaLeNRWgQDwVq6XaEre8CLNtiOh2g/ar/gqDdIwZvEiKCZJHVM68809MmQZjyMT8Y3YYi3n+gEuZ9KC26Aimiv+QCq1YZMAYJMGo8QiZ4a17uxAuD3ETVelryOJ82qvHn7P0zd+EYqxst3zo4b9DcBy9yvRZqJlUK5J4k/lT45FC3EGX7mYF0JxguqqGd28XfGbIu0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckkbP6rqUF2JUiVhz5FbfHn6UEulEUTb7ydCC9/sc8E=;
 b=a/UG2LJmsme+zxTJ6ciiLI2CE7rVXe/fGRmeR1Ql5boh0BcnHeUjnEVYV0uRNNQWe52AsxxOKp55ZkAxmKr4l6c8OGZ5TUsCdvUEUdXrd6e4Pp5gwlnS8aEba53WffQlppthJXhumtVPgpsXHOEqTaS9ecl5tyd5ikwhOwET0LJXGOVHCAeJJtTwxPCXonXZtJPQZvMxki0f75A/CSEun7VkXEE2cGfDewbCznK4Uddvu4ZfOWSpnKOtjW+9VaF0/DTjifstM9F/xq8Z7fBDDZDs7zcbYxwj+UxwVwdwxpnis2zMdU3ncuwhCGOvaJFGbUFFC7VnAOOT5wxos2kvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckkbP6rqUF2JUiVhz5FbfHn6UEulEUTb7ydCC9/sc8E=;
 b=r5LHuXUnQuvLh+kx2KtpcHHGvDzPEth1o0yOIV+wciVKpHEIHNWDoHT76CESugtWNgKwUgIZENMnSkTmWkZIVOZwmFs6xGHTk82tHD9HfmSTznc+migwEMpS19HaDboHtX/m6h6+bdUF2VNBT4WvEfU206LCpAFo/YZ5/LGgOwY=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by BYAPR04MB4247.namprd04.prod.outlook.com (2603:10b6:a02:f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 02:09:27 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::df54:4cba:2af5:afff]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::df54:4cba:2af5:afff%7]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 02:09:26 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests] block/017: extend IO inflight duration
Thread-Topic: [PATCH blktests] block/017: extend IO inflight duration
Thread-Index: AQHZBGUXOx+ttitxu0StN9TwEaCe8q5W7HuAgAen7IA=
Date:   Mon, 5 Dec 2022 02:09:26 +0000
Message-ID: <20221205020925.2d4byup6u4y3bm2w@shindev>
References: <20221130024012.2313090-1-shinichiro.kawasaki@wdc.com>
 <6cdd3f9e-af36-00a6-a3de-793972a383f2@nvidia.com>
In-Reply-To: <6cdd3f9e-af36-00a6-a3de-793972a383f2@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|BYAPR04MB4247:EE_
x-ms-office365-filtering-correlation-id: c820f5a1-4958-4720-b81b-08dad665bc81
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XCk5ZFkSaoL8CP9RnBS/Xs8R7Mlsc8hLnju1sHTH/OiGAnDvzFnBnwQO7KLrEnnW/G47PDn4N4miW4q91wdsHgBdEutLjuSL8rdBbp6O5zFQ2yn9rpqIcmVGDUm+PtpHj+WXEn9tZwn8lAaBrdcuBjUEV9G8Nyd8mrcMqG8NEZBAOGrZgLdXIVOWEb8Q3EPe5SjIrB1XzU1jY1brxuYGlUYftKUC8PqaaAiNNujLs7+oJCi0RYShGRvqeM1zL+9WPn/tfZFGousyw6y/if1Gv3aSmoSkg/qBWQr1FYhL5l0vcgEmKEqcWYIUXULPC13xK8ETeYIuSum09zRFy3u0+znYSdP0J6OGnL8BRyQeOzKz/1/uctrM7OpqnXcvT1JsKsPJuEFi5FIQI7FED2eUo5zMWFs/r2zAJKlmT/QMa6CT1EzoED1YfaAYvZiWNSP63UTjEVwINu/9rRQg9XHMkoz7gLv6sMERP+OIS9aXH3oqWuHqDiDU+B1IxSTFUdHId3+GqQ+Hjpe9bqbqlbfhN094r4rzmeBXuoeFPMyFf6hok5W6LJ/Oq31/k/NPXaYAQuBy4Wjv4UMS/os5p2/cd5iX7wOAsFm/bCCUqYYyfz0sn6aLOLcGDp4EjJ4d4Ikw/cOa4WkXLiJzwlzIR/9wK8/ec4w2FGPyeQxsduFsTjrYD94YlrRdNgXn3TOEw4zmtrnTns7D17vgt+v9/YAqmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199015)(1076003)(71200400001)(83380400001)(6486002)(26005)(6506007)(33716001)(6512007)(478600001)(9686003)(53546011)(186003)(38070700005)(86362001)(38100700002)(82960400001)(122000001)(8936002)(5660300002)(41300700001)(4001150100001)(44832011)(6916009)(54906003)(316002)(8676002)(76116006)(91956017)(4326008)(2906002)(66946007)(66476007)(66556008)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qdg/T11Hmv/FfIR8FVEz4Z3+9pyEcd+qGfcX8hRet8Z2OTjBaA2JaRzHUsap?=
 =?us-ascii?Q?rZdHzOASRqzsxLRquO5li12ImGrSc2t8w05CWE1CnL8DHnRVlrMHS3h4L2/S?=
 =?us-ascii?Q?CoJKrot65AuUYlFOHMWjhLJLfM7FeF7toAX9+PfsdPTEmXvJTA+T8mOlFHBa?=
 =?us-ascii?Q?TOTAF5cFWUXcir1eEL/Yem19QFMZz1uxTF4AP/YxrjrTEVqk4QNuIiRspaNo?=
 =?us-ascii?Q?dzjYMdkgfdsH8AdJnhZ2Rhd4LmD0gKuXH7FYCPxq4w9WjuLfM2X5UduLBb2a?=
 =?us-ascii?Q?86bUGHUALoQ9Fb3s4PE/JC41w+sw1atVScOFNGyNuVitlecqgs/FFJy37Xw5?=
 =?us-ascii?Q?YCergm+2lgclmfoL8WgxJsjod804jG+GdY/5s6R/BeEYaRKttTLJDRAwlLly?=
 =?us-ascii?Q?imJ+PgI+oXL9X7zG4LsH5W9dMyCMY48tQEEmGM2eM7rU0zSfQvYjCQKZGHwv?=
 =?us-ascii?Q?xTyb+bd0tvedS5kSyg0l1ugFFYyaQt7XNagpqvIOHhp5KbXDluqm19yMaifY?=
 =?us-ascii?Q?qTyTdhK3OAvIuD9H66j2Jzm9jMl5I44F2P5muWkKt2X/J4yMNpmtL6TW7DrW?=
 =?us-ascii?Q?BWH0R+EnexH8AA9SowsgmRS1ZZgSPOzXsG37yaaL0gB6G5W92sDM+P3RGGYp?=
 =?us-ascii?Q?FPD1vzj2EaNbPAJ35Cc/gWuGbR7FGfQTIl1jy7bhN8HtG085KusMlBNAK5Pt?=
 =?us-ascii?Q?JS1SHmF/0booSgp3nuxNUnGGckjS5s3IiT4sMqSmfjB0C3N4yVpnKEeTHgr/?=
 =?us-ascii?Q?riHzy76dNqSC/oc53SQVM+Bg6QXfbDKfTtHrVhVgGxVJKMHI+oyre2XDyKF7?=
 =?us-ascii?Q?w3zUx2IWez5VCt7YmVcg8H1sKHHCP+vDlIGvyczFtrYHmzzu8cNQlG2O/t1h?=
 =?us-ascii?Q?Wd7RceODukk8NrjhRqWFSCPPXBUMhM5YBpT1XXPWoNVlcSYUu/zPb5SLq7eL?=
 =?us-ascii?Q?wHXvoa9SemcEr6Of4UNSYFjcTbhVd1QihHTg4FELGIOD/Rwo9uIt76IUIb5q?=
 =?us-ascii?Q?h+EginzYM45Zvp4iz2nuFTDOYPzyiioUnZg8BzdEebBsjRLKdv3xoqQrkU2G?=
 =?us-ascii?Q?JsSC/SgEEL5ios1TQM1BbSbPSxMgVulk0h3XTZ974m+x5opbwUqfw2r1c01q?=
 =?us-ascii?Q?H4iYxKiN4e6Orlh4290hEOqlL0macqvqxbuezzz6/c9ulYSCzy+/Hg9TEzAQ?=
 =?us-ascii?Q?TDQGfqhReYzMSRNxY0dn7Ectn5hIpTQNKXgItaUoJioaTRmSvcMPY5Wzhpx7?=
 =?us-ascii?Q?61z4dz3CS43JAe/GjgVRUI4fYTbKgyDUEqSNyZZKxJZ+jpjyDqXA9dq/Ktmk?=
 =?us-ascii?Q?eYwscfkxPAzAPrhX0bHOMG3jLO5N4zU+l1rRaPFIM96dPyVTc0W0foQ9gQmG?=
 =?us-ascii?Q?0isOJ2qTnK9/u5NGQ2DIZXgHa7YVpny4Aop78BOiLUUgXXYK5aqN5GcaulYo?=
 =?us-ascii?Q?yPKg/huuFIks+wzUN3pK9EAIl0hsCmNOkVxh5vODnO0Mdnxt2c6+mNt2rtDN?=
 =?us-ascii?Q?FZQbdaV17fWeQgYXYN+5+y1MTdQI8uEddQvgH+LDSucmY1c6wOD4cjfI/0Qh?=
 =?us-ascii?Q?uIyq2PDjLbgAY58EAkmAodCodjPONIbsmJuuNZtd7pBDfF3qMOsSCKXK5XSS?=
 =?us-ascii?Q?MnJd5SgvKr6ANeJPO4/ph1s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <441B10F297096544AC89FC85D0E7C168@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DHQ4XcHqZdkRqJqveZmNB3PiJlucbDOItOuk+eVzgQIDv1UJsNSUipJS78tZslPBVKoC6r2WbFZk9aVpKTb1l+c+qBhOG+OpTwiD3c/sMZgehs+B5Tc26v3PN6g8AzGyC4al7J+eRv2y92E+UEbRTnoQ5yOfd/ugB7/vTRJgzJct+5D5mocszRjdA8xDo4irLSZEn93+5kFNZQDActaGkeiG/sa65PwN1v3ZyvsnfUZ7jgOiKEhui0lGELVlpKe9scKmAEQ05Cyp5+yw3I1uS+pTUc01WufcSjQsKUNK4PuzTJl+SRhiXdcc0OSiMVgU5SnGS0BcaXz0PBFdD0Ljqfj+Ac87paltc5iRt65veVWB426z+nO4QVF3jCsdUqbnE/Ra34kclRmKFPvVMaz0QodYP6iMoWWKW45lPM/72fhLjv+vnp/WG5yLhT9dGJunt+PUu0fCH2yBcVe31Qzbd5knJGT6PqJDlje+51Mpz3G3/PLEEIchUvWEER2sOYi0uFDf1kCIRsxfPNKLnqVyF9ldMEodRZoQQ77WDGMhBgcnnZArlyRuIYYn6BKVwG1h4rhcNB3AKsJ8P5G8VXW5qqnbY5FxYvm05KPxpRLocbB9NPCjHaZ/Rz8IY23S4L8AVMJsWhKGg2JEuqvk9AKVfhxadwOFOoAeFED8MOsj0GZOtJ6XFpk0mtjTXY8sPBum0dVxeLPQjIX9zSCvsgM/twhGC2vSctjqzF0RXHh9+D35ARxDoK8wfSUHnwSuBr6F4SLD5cadYCCb7nyddLA6gsr0UpIdHWmoX4w3FXlbIh7VRIvl0oSwSxNOu3KqwG3EeM1z0cCyRWekknf63z7g2K9aP1omnu1KH3+CZ16kj6E=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c820f5a1-4958-4720-b81b-08dad665bc81
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 02:09:26.8849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UweX1JJRMqdOaamGxikcbwk3ZzMtxI6Hmj6fzGlq6kgotpKc+Eop+EQ+dk/tcbFX2p4CbwcAq2qb4TkqJKIF3PldCsS/Ue3wyMmPufNB5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4247
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 30, 2022 / 05:14, Chaitanya Kulkarni wrote:
> On 11/29/22 18:40, Shin'ichiro Kawasaki wrote:
> > The test case block/017 often fails on slow test systems. When it runs
> > on QEMU and kernel with LOCKDEP, it fails around 50% by chance with
> > error message as follows:
> >=20
> > block/017 (do I/O and check the inflight counter)            [failed]
> >      runtime  1.715s  ...  1.726s
> >      --- tests/block/017.out     2022-11-15 15:30:51.285717678 +0900
> >      +++ /home/shin/kts/kernel-test-suite/src/blktests/results/nodev/bl=
ock/017.out.bad   2022-11-25 16:23:50.778747167 +0900
> >      @@ -6,7 +6,7 @@
> >       sysfs inflight reads 1
> >       sysfs inflight writes 1
> >       sysfs stat 2
> >      -diskstats 2
> >      +diskstats 1
> >       sysfs inflight reads 0
> >       sysfs inflight writes 0
> >      ...
> >=20
> > The test case issues one read and one write to a null_blk device, and
> > checks that inflight counters reports correct numbers of inflight IOs.
> > To keep IOs inflight during test, it prepares null_blk device with
> > completion_nsec parameter 0.5 second. However, when test system is slow=
,
> > inflight counter check takes long time and the read completes before th=
e
> > check. Hence the failure.
> >=20
> > To avoid the failure, extend the inflight duration of IOs. Prepare a
> > null_blk device without completion_nsec parameter and measure time to
> > check the inflight counters. Prepare null_blk device again specifying
> > completion_nsec parameter 0.5 seconds plus the measured time of infligh=
t
> > counter check.
> >=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>=20
> overall it looks good to me, I trust that you have tested this on the
> fast machine also and make sure it doesn't regress, with that said :-
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks for the review. I've applied it. Yes, I tested with multiple machine=
s
including a bare metal fast machine, and saw no regression.

--=20
Shin'ichiro Kawasaki=
