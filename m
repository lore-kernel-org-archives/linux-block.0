Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35ECC433EF
	for <linux-block@archiver.kernel.org>; Fri, 20 May 2022 09:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347627AbiETJYk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 May 2022 05:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347703AbiETJYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 May 2022 05:24:36 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54D72F381
        for <linux-block@vger.kernel.org>; Fri, 20 May 2022 02:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653038674; x=1684574674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=abAMhGfLUuRWCFdevNOA0JyLJA5Df8TYDtLoW/Vtq5U=;
  b=kBxuHY1NHqhK1IqKIKb9MPDjw8jWL/3sUrEJLEwjo5WF5rcZYdxCMV5W
   cKbYtoR+bTPKt7o9X6u1HYoZekrqZof/iz+Fd3x/sTFa2JlqY7UFfLmys
   sngIIK5yVRqQ8YQ+OFcAmrm0jCpfBKOe6kXZ0WpVilfFAX/ZL/C25/iXQ
   5UE9AY3je0YOh2Dc4LMaAjb/h7yQbVHEIvlbRMRcKDqWAGppzI12OcdLd
   Zr+ma7PlfRBrxjloUBlu7dyWXbaA07UuxbyCURYFQOBhFPLHLbAT6xKGK
   2Nd5exqGl1g3zHr21JJdri0N/wjrJVKPp7V0v8l1xmN/YpIMNWpxb/y4U
   A==;
X-IronPort-AV: E=Sophos;i="5.91,238,1647273600"; 
   d="scan'208";a="305115369"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 17:24:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZ4uwdaTHvFpAHvbe+tLO6tFkjtUi4/s/a6y9YjswNxpouFWnVArYfZtthMyUqEoN1KC563eYHUTboAE4xdgn3AuzMh1oZfqSaG8yfry7NhHGLt4QqxPvCAk3T8jjv81bJKcvvS7nDaV6mSTaCKqVlGGNoxa8SXjBmULYJSfQPqfvWZfN0cTB3d+SGWnN2JWiGtljscIpaZIt/9ZlpSOghbezfLbBGQMeGV5aDRcfdC+Zazw6pFQYvnZ++bFP9dTbWqNlnyFo72JSl47saYjPxiWHecZcSiX7oZJdUdTJxn+uMe/zubfmOTIu9sjHkLPLHmsLMj/LldanLOTfBJngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1lxyaqShARVB03Z5pHNOyRTkvmnn8rXlmzdUAKWLrM=;
 b=bkx52inZ06qn4ypVcSW1BUY/DDPa1Cdk1egUZgbRkPQkXbwUKsEjd8+tAPEjjFf8wWSCuiBVXWRsmQbsP/W3Uoe7m6jbohk+cyshZb4TTm8gz5XUOJyFU4FoiffxX8mSArLWwhVqEd8W9sRGCuEp7R0sojvHLBwoGAyZDVBKiVZRjQiIZ4xqwyBojqVYV4+2ixFMIaIBQ6yinVZ+qD2X5W5Q1pdpx77l4f12vNmk3eEGyvC9cEGD+w1+3FJPlqDgCbPuwpYmZD0dsoATZbRdhK887Apoe0KVieOMm76ITS7nFifQpv01k05konbk86hNZRF9ckURKcd4605o4Gdm+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1lxyaqShARVB03Z5pHNOyRTkvmnn8rXlmzdUAKWLrM=;
 b=E5tUwhP57ndNZFMhGfWLmbtqkvCGLQU5V0nVH8l2xNRdBRkL0SfiRohNWaW2R/e8qr55StHncY82DGhKREQr66ksllnDQVXX6cZGAZN/TupZUml7/wF6F4cwbFttVBGJ0axi75uwKJwNsFgd2ls0o2Es/Mpv/0AUlHioQqqLUX0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6154.namprd04.prod.outlook.com (2603:10b6:5:12b::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.17; Fri, 20 May 2022 09:24:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 09:24:31 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] srp/011: Avoid $dev becoming invalid during test
Thread-Topic: [PATCH blktests] srp/011: Avoid $dev becoming invalid during
 test
Thread-Index: AQHYbCtpB2+1P+ICEEOyiRv/Yjs6iw==
Date:   Fri, 20 May 2022 09:24:31 +0000
Message-ID: <20220520092430.lqjfkzrtoyrkg4wo@shindev>
References: <20220518064417.47473-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220518064417.47473-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba59aa36-342f-43aa-32bc-08da3a428bef
x-ms-traffictypediagnostic: DM6PR04MB6154:EE_
x-microsoft-antispam-prvs: <DM6PR04MB615474CB9D14C68D3B95EFEEEDD39@DM6PR04MB6154.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BvIMdNnYxk/YjiICcw9A68rPq57ttyhi0qohyVMpSPDK93A1/bUxdqtQOVqw9v+k5eIqJFYH+TJ1f+cOSAzUSMFPnhw3eAHAM+y0B6Z4O1bWUrlUS2tv6ygxdYXluS6ZVozF4cLRrHWY6j1naEdFnkr+XLLoiHyKeE0fiqtACBaV9v0dEyMLdA8bbfXIZBF8v26IX361Y5R3CTvqq0xrwMsKT0QQ3ydVAXI0Ir6J9gQxtUIpbWM3t/SHfjDpi+wZDAWcJdYXWC4NAwf/6SQYl9IKosSsUP/0+NnBvzuIAPczgi77nP97uipj0mUaWMUCxUxo6SBOuN4U7OkDNJ/Z2kiGRNi79Lvnuk0WqQDR3pXLAw9J8azh27+4Gzvt/DHXgbqyfjPwaBnrfqk16NE9QjvbxSodfALweN2qPF5L4JG88PXbWVbT/0b0gTAD++Vxt6+T1/ZGCxtYJ9wOUvwCwapLMBFyu8pvwwCmbq0b26JuuM5PTvlNEyA5eiCngmjTgghOAXjrZ7Uj32fkd7JLSmjhcnk/IKda2DbuelD30Vetw2xGs0Ui22qoKgKeLHtAd7SYvlmr0iWh8PwRS7Hw7QQ9+Q5xcm925/WXaDEuRnVVD0eA555fK1onYpZyWiJiup51FKq05TZIxOqsJF9fLry5hNCMmgImA+5wVL+q14N0le6P/AXFw5dsSINVyNMok9lTrSm2WebXT8E7sOhWYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(1076003)(8936002)(6486002)(38070700005)(5660300002)(508600001)(91956017)(122000001)(4326008)(8676002)(4744005)(76116006)(66476007)(66446008)(64756008)(66946007)(71200400001)(82960400001)(44832011)(33716001)(2906002)(66556008)(316002)(38100700002)(54906003)(6916009)(6512007)(9686003)(26005)(6506007)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z6ZPveQ0CYlLY2lCiYy554dsaZtm7i5zSy3V25WrTv+M8Ojo1q/yQrT6K2Tn?=
 =?us-ascii?Q?VJ7f1FIPDUBSGXq44yeZV3zZtgGKmXW2FqR6RwJV2GGxdlvvVcY+z2xzcwc9?=
 =?us-ascii?Q?nW4ABEGSvW3yyhAfC8GT0SiEW9EtYLKnFOqlGC+vybpI6M4r9FiaHBZsmSgG?=
 =?us-ascii?Q?tkr4qdS3Og0ka43YL0OmydLSp/9nt47bFyDV17MWa2bRUAvWaauIh8w8JlwU?=
 =?us-ascii?Q?JJbgzZa4ckWmrwj2RPsVSEA1TYFpOmfcJODYL9Nik/ZU8zdPGgUNlnfCrgk1?=
 =?us-ascii?Q?9ilbsAm/mU0hHcJTqIQ8/84wIw+mde8nrWmaG/1axEFH9afoWFhX4qY1X9VB?=
 =?us-ascii?Q?L3iZ0eGDTRNXK6akTzqcy7Pf93ZQxwCnAo9c+UDSDQSfcRgtI9bJ7fwbTGQk?=
 =?us-ascii?Q?Fcs4kF30JjJ6fvehCcdJEJ42LXt2cxekJqxYSgCbMLGNMWqgiQCEeXkud8fn?=
 =?us-ascii?Q?QNwrh6kRdyEsvw1yxW4PUXPrF2KMbK+R1Rpp0t7+sEUF6jAdh7JuUTMpcmq1?=
 =?us-ascii?Q?8NLVmxFzccpLvaAzrY+yp3SAJgtffqhl1oNPDt5FX7qGYRH9pMt+xwfkeRFm?=
 =?us-ascii?Q?+iT/cS6hJ2lBu3Xk30uoAkqBtviJ0Ie2Mb9w9SpIazgU28GcqKuErWmbIWko?=
 =?us-ascii?Q?bABac+nnsRaSZdYLzoJJILR2CntXAROwaA6DjPvWcse+WIoX/3hk5j5XAxgh?=
 =?us-ascii?Q?5WBSSz5EOvmR9ZWMHhxUHyVws9jmoy7ryUuABp596e8Lk2bYgBkN3ga1sUv/?=
 =?us-ascii?Q?A3LZD42VbsQfKxaPQRobhvZsDom7Mq6OkMvZ1yNhit/id2Cl/EpeNloTwppP?=
 =?us-ascii?Q?t5DFQ74xsqHNuJUGK+jeH4V6iv/Av5ekiWkmFInIYdd6LqkwimqpwaQzWtfJ?=
 =?us-ascii?Q?r+J/pYZvHd5Ylu1Tr1U+u32LgxhnBYL1FywDOFTxFy6mF/rZlfx3JT0KlVWI?=
 =?us-ascii?Q?YEeVXn0FDIyi2bPzD2ckCtCq0Zc/ge3GEyzXiBctY7bybXLBnsaWHTEmH/Qc?=
 =?us-ascii?Q?iQUpmKTK6XJ9e0qym6z5yQB6IaJz0afhxi56J5HFEdPbOvkUQlWyjgdMmHKS?=
 =?us-ascii?Q?QDdtk5kvBxyODj3ai2vPtOHPiuOiZMwFVfYxj7w2a7MLjQoR4ggTeWI1nTmq?=
 =?us-ascii?Q?yN/5byxr/T2G5oF+V3tb6bxfC2WMIxOryGVbbUBpQ2XD8NB17V68+0JzkNZ5?=
 =?us-ascii?Q?mwu/0vWjeTp4W8QiMQEfROB3wH/c5GG9kJzQBaqOV/f7zBFFcLt3D+zFthBD?=
 =?us-ascii?Q?ZcZUT4PNY2UupKTcu/hivgSVA1JhSfEsBHgQCtctK0vwexOKHwCNMd3ODyvs?=
 =?us-ascii?Q?QwSEs/Ednfh2JlHiKS3q+sq9uVlx9L3MXw8/Uys2yrTO5MKsovTFyFN+dy0m?=
 =?us-ascii?Q?hTWon+olHK9DVNgAc8aAPf8GQ1y7I1kUYsYLzOWgEF1c7tWCZwAK7a0lRlrq?=
 =?us-ascii?Q?qUI1vO0L3oO3lCzKW48K1ZACkKV691g94TDWNgR6BIIiBQ1gdScPwhuTWtmB?=
 =?us-ascii?Q?0N3HeS7xS7wGlucBVrvtX6I0ktuqhQQejAPsWfcIJDmVHHgibeU5wMCL7Hdq?=
 =?us-ascii?Q?IZH2P+WY3Sc2Xg/fm4Tues0R0rddH8tHnJFOoc6bdALpAVtKz5/ZAqAFnzFQ?=
 =?us-ascii?Q?0k5sXDrhJzVrUOK71anbHCrESp5dXe/6KIO/ix26r4yi58mRws4p9kf4D6Pq?=
 =?us-ascii?Q?GeE6ujBVUVthSX1NDGPpow/uQhftcvxUC0DSNmwpXrQ9A1miRkWnz0ulD7wT?=
 =?us-ascii?Q?o+d2XJeiyELy3z1X5vLCn3qDpUcpvBkpRS5AIPLOOz+RaWU1E/VW?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E969D37C470574282855CD90BEB0333@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba59aa36-342f-43aa-32bc-08da3a428bef
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 09:24:31.5839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LuiE1+6Fh4I4TWhwBWRQuDrBLRXhFsll33JAi+hNTfauPxw2UyBc/41vpJyI/57WEy9zdzS7qyHslAijBJuhPmKOAr/SHxwpzBk4iLeIDNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6154
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 18, 2022 / 14:44, Xiao Yang wrote:
> $dev will become invalid when log_out has been done
> and fio doesn't run yet. In this case subsequent fio
> throws the following error:
> -------------------------------------
>     From diff -u 011.out 011.out.bad
>     Configured SRP target driver
>     -Passed
>=20
>     From 011.full:
>     fio: looks like your file system does not support direct=3D1/buffered=
=3D0
>     fio: destination does not support O_DIRECT
>     run_fio exit code: 1
> -------------------------------------
> This issue happens randomly.
>=20
> Try to fix the issue by holding $dev before test.
>=20
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

Looks good to me.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=
