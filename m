Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1FBC43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 08:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiFWI4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 04:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiFWI4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 04:56:07 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4B138BE7
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 01:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655974562; x=1687510562;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QcpW2T8/bf5O/mZ6fsFSty3A4jZ4Bj5uoOF/1/hS220=;
  b=kaQZCRcjnAITlk1hmGrbs6EE7TlkRazF1g7A1H8Pe8hweGQDlMXKpNP+
   /ur4IRmFTsb4jAg1s6QtwFYzkzPO6VhskPVm4EhO7lrC6S83gq3VtQGyb
   GCM3FdLB351LvjosOPkrze45w7zO7JZZzTd4hQq5vm4LB7+iZZ5orZbzg
   Ud9bitxdeqIQha1TdwB2hD6PHbnvHgla6Iwasky9eL9E2p6D+Fc+yrSiA
   KmrchIjz2lTTlRPG//t+rsoL885waPXat18SVFpWd7ivlswF8rePpFhrs
   jyNHl014dyfDgL/QjOGdJdVatqfC2+mf4kiLVppxriV4MkcUNRf8as4BH
   g==;
X-IronPort-AV: E=Sophos;i="5.92,215,1650902400"; 
   d="scan'208";a="316010826"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2022 16:56:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBLj51kllGjNCLLHL3Z9yPFXVp2d24AC1cWP6dQ+fG24+JxIVda060aQATTm70OKGfaw0jbOEQ8S3p3W4Hmz6sFJIaH9g+tSLt/XspR6xnWWXGiaZ4QBIf4nghfrWRe6l7qgzlukw2+WUz/4DOOUDZ8URoH2b7H8vXFZEP6xvWdn/LaRYH8wvYqf1dVIsxq237nZF9A63DOz00M9djzjrwLE+k0o4K93oBh4rK6ZAJQ0BXmMLr7/lGYbyYQ+Z2YNmhkIuRT+d0C1EEMl+CUWvnxPUAuh2MdObP2Cn1MJdT9DwlCmH+Z/B/KnKvml8M+FC1A+yoyq5lI7ca4JzfM8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcpW2T8/bf5O/mZ6fsFSty3A4jZ4Bj5uoOF/1/hS220=;
 b=NgjWKMBt+TdCcwDPI/ZtOAoFVgjqQKYWTxOfNyDXRn6Mxe60WunoaN10wFigyPp/e93Wi/Pg8cy6qZRayj0InYPn9sdCBsy8sSBImJUpcbIuW6kuW1fw2+ZVjqatZ6WQlSITsaTK62qEJA9XdaibMPrDnn7Gz5nYp1po1TWdhwY5zCgd6WAxSA+CvFou/Hv5xugqhmB4DwvsRu+RSr+RLHbSXPnKKdvgbBwQ0/R35LdirUWANlmhktEgFe6cp0hCRhmH0ctZDIb864O1gb7eNgdYwXIyZJNpoMT+JhJW8VdwdYQ1f4DogAFxntLzqFiWkO9faUDGftmcPLzPD+R6Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcpW2T8/bf5O/mZ6fsFSty3A4jZ4Bj5uoOF/1/hS220=;
 b=AwQLcYERqHq2bfMUzycO0tMayW0mdLZBH/Uc77p5PizmYVAaKKbpdivY3iEwLaOIyOK47ANGSIdYo43Z2oq/V16tAK/mDP/IrV0taFrSumIJO3UXe4/x+t5R6bYSdz/Um40SUDqBvidOW4ZnaN8f+X2XrFXw76WNRQoxxATaHRo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN6PR04MB3966.namprd04.prod.outlook.com (2603:10b6:805:48::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Thu, 23 Jun 2022 08:56:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 08:56:00 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dylan Yudaken <dylany@fb.com>
Subject: Re: [PATCH] block: pop cached rq before potentially blocking
 rq_qos_throttle()
Thread-Topic: [PATCH] block: pop cached rq before potentially blocking
 rq_qos_throttle()
Thread-Index: AQHYhYkGlgdmJpOCC0mS4qhKsmFu+61cswuA
Date:   Thu, 23 Jun 2022 08:56:00 +0000
Message-ID: <20220623085559.csg72pmamhwgkcbx@shindev>
References: <65187802-413a-7425-234e-68cf0b281a91@kernel.dk>
In-Reply-To: <65187802-413a-7425-234e-68cf0b281a91@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a3aa461-9745-4421-a102-08da54f631de
x-ms-traffictypediagnostic: SN6PR04MB3966:EE_
x-microsoft-antispam-prvs: <SN6PR04MB396616A2A31EF89DD2449BD2EDB59@SN6PR04MB3966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ygKa2PX4b2urf/Tyfyr6jak6mlP973BPatKT59juz1rRAxsBnYu+wVYpNzj+PW5XBymmdQXL1Qvs0h/hqGL9JtmEuR1Y2xV3FRLUOwpSRDwDjU01ICKXIh0rmqrbhF+P3VTeX2gd701t/kVF894z6iea3bGEUg+rGhB227h2dQQo9xdrFtvOcG0Li2MR0eWVDOH0hUDSPis4rldLjJ41lhlAqmyTamjbDsA6KjvqJcEjsDNS3GRP+Y6MQp4gDdVDbC14CjxQHH6LP2hnQauKRjwdCsC0/nFikMZMqoE1D+ToxB7L3uzBdRjoOr12an7B0Ymt1Z81nRxLk8jhfZMoFdT93q/m34Hdiz28LDGuaZHWVPiQDNtqR05YKDTgskhguSYGYLYlyUuYgFTk4W/nL5CLQQwN+vYNnzRpcyik14O6HTjicD0Jhz5qiQczTS+7KEszodf6GGB9oP4YXgwGqDnGFQFm74btt01aB3kloyA6WyvbPGu/W1wpYsHS7Dm/jayJeXlGSkjCeyi1gahePxjMb/60EcvJuPYvXZn8aodrVz19wn/s0ruaAQjs3M8gX/veA0zwTf3CXQgeXZRQwUYk2b+1tNnOIKj3e29vecJhkDCn3NBFc/MbHaJjOsSvZ5fauLlZQaaRY09Cr376W0gnoRgzPMK+QpALbcF6nV635g0Qlsh4eY21FrHA4BhY3IxWjBLNJfKVamwZmm5qJQ3NeuQr6HxR5Wo6kYv7k1OIEoI0CP7qDfIcOOts2n8oHX9rkcpf+9vdQ6LvsBoYQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(396003)(39860400002)(346002)(136003)(366004)(38100700002)(64756008)(8936002)(44832011)(478600001)(4744005)(66946007)(6916009)(66476007)(76116006)(91956017)(66556008)(54906003)(316002)(6486002)(33716001)(5660300002)(66446008)(9686003)(122000001)(186003)(71200400001)(6506007)(82960400001)(83380400001)(6512007)(41300700001)(2906002)(8676002)(38070700005)(86362001)(1076003)(4326008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MV1VJdnFFpiOs66aCWdtbjaxwzY1uq8U3sjZVkULHIDAt1aSUL7sb2PFpUuD?=
 =?us-ascii?Q?CiTzbgNWzl0q/In6ZQTQM5icWZotvFt2MSi+N5kmNtprH5i0byPAbuguoSD3?=
 =?us-ascii?Q?nPCgOLeH8W8M8mp07RoKIb721so6QWXZF7Ni2m7rC8woJ143ZonIH/GXPiUQ?=
 =?us-ascii?Q?vy9Hn8e6E0Z46Z5VOLFIJh19GmpZqfFuuTR7ydXTKwdZdJU+U9GD0fFngnmg?=
 =?us-ascii?Q?ScqXlHtEgJtqCT34lTutxXvRuAsLc0XcujtiYQkW4KlfIzUNjS3YProaXtkI?=
 =?us-ascii?Q?AJyApaqohEB7RVbuGVs1J3OKb58wCvfQluoppckzRi7VKFu8HImeNnrs7zU6?=
 =?us-ascii?Q?TXBrK9wMP9dnWTJ+DekOjptof9N8TDEMKAsVvovqX1R4zG7cTgRm8RUgHuIW?=
 =?us-ascii?Q?NjGKAro33+ou2hJ2VxdQhGfYwabFDs+j14DAAZLq2cqUjxlwIw4+cRiEhmv3?=
 =?us-ascii?Q?A5HReRC5N7bHayk75OdQty4U+5YLvbsZ2wSzGNw4DTkv3M3z1g7hwgtFa21x?=
 =?us-ascii?Q?3PkYKg65ctxYOj/FhzrFdrG1WvupblLj9GhZGjaYbRfEN3l9/5eqECb8UVrn?=
 =?us-ascii?Q?M+oLEOblQT+KQ+alF5oFc6IU9VA6CHk74W7lW5Av5sEBKIeHml2yKLampAoN?=
 =?us-ascii?Q?UxuGxfrfO0UAS87P7bUpE4vV35O/1RNBxfBJvpvHhTz8mjYqsWBEWgUjxN8g?=
 =?us-ascii?Q?xh1m1jtQPWGaHZgKX2Y1NB3k2Mpy3ktQDEczh7vIeKZyEdRxYUCdTg6I6smt?=
 =?us-ascii?Q?bXFAQmPHhmA5zFJLqbY+QwcmyT/yPddNNZYAyVA4i8xB4/UFIbYKcAYPslsn?=
 =?us-ascii?Q?vb6RujckpVqFoOlF55ZlFaS3X8LZN/uxktt9AdXgizEP1eQxyF2vj6xqO6Ev?=
 =?us-ascii?Q?PTVwOWr0zpwkshIgzbeQS8zptVTi52V3Ih5+tgVi8hYtScSzFLCptsEYWUqD?=
 =?us-ascii?Q?NHlEb5x9QNRhYQW9swJ153Vz/5j0184T7ilFRhSWZLvSUCOVrNExECnPtpnz?=
 =?us-ascii?Q?S6eZaMlNqn1XZ2PRr+5WOT1NMfQ9z5k8cmuouLK5lLR4CV3JIq0m2mf6IDTS?=
 =?us-ascii?Q?/7hk15v0HfteuZ5NmLj13F2kH6eupZvFOva1AQoPWggVcQaeoJJJGa9JEbXt?=
 =?us-ascii?Q?Jtd37LcyDsHR/87QWYx3w4RLWD/Q9VbKZRGaVGJ5ycvdW6AnV+9w7fkbXIMt?=
 =?us-ascii?Q?mNz7fz5iD773/96vojODubFS28OlkBVJvEdP10rQKxUc6JTpMNVNsEyxHw6K?=
 =?us-ascii?Q?pSLFRFDhGSn8HrEpoOkYD1Riq09zlG9OHOW4g0+JFFHPuoo6BfiBajZbLVRC?=
 =?us-ascii?Q?kkETm3R1RyGyd2DLHTz+zd5iPGNamNcPuOQXXOtOea6LLWvp68bYCCwP0qCu?=
 =?us-ascii?Q?fjpqBqjIiZfkKrFgB5QwEW8WmKEu6dk4dv9QltmmXYS6G23/oaeMLkhzySL3?=
 =?us-ascii?Q?AMsIQoci5puH5BmPv0+IixjpbIbxR7o3XQKyE3b+mQ13WOJqkAp2PCagq6ac?=
 =?us-ascii?Q?Y3orXonVu2Jz/7q04xRD4kzsYkBsLUMuRCgw+CEnAA/rMmEd/m6L3WGXhcgQ?=
 =?us-ascii?Q?KA5R6xsd1GHagcYizL4kxlCUaC77s3pwRDR2FDUkaCYMvbLfl7zbzUcyLWwn?=
 =?us-ascii?Q?Dx5fPZvrEdUT2aSwftAshYsOu1miOoZVxcCGFihJdFUqS6E5NV+hUwLngcAr?=
 =?us-ascii?Q?AhSsP5UZ/9/ImGVucpwd5oqvRPLJ1rs+ypax89ZMcpaVNBwwlep25pX6GsDo?=
 =?us-ascii?Q?OKPSKxGgVrtkqdseiknFh9KYTDbMW6+DBzRku2UrnZex5QcsLRTg?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C377FF29A454DB47AD5E90E7C1BB8F00@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3aa461-9745-4421-a102-08da54f631de
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 08:56:00.1552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nm9+lLM+3VdNaBjPeBCQE+zHgqnSUUfs855fvj+rG9e0payCDuYdYaxY3zATHwjsiCxXiidq0G+EWjErhRu4DoyppCNFgzWo2tD7MLbDq/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3966
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 21, 2022 / 10:07, Jens Axboe wrote:
> If rq_qos_throttle() ends up blocking, then we will have invalidated and
> flushed our current plug. Since blk_mq_get_cached_request() hasn't
> popped the cached request off the plug list just yet, we end holding a
> pointer to a request that is no longer valid. This insta-crashes with
> rq->mq_hctx being NULL in the validity checks just after.
>=20
> Pop the request off the cached list before doing rq_qos_throttle() to
> avoid using a potentially stale request.
>=20
> Fixes: 0a5aa8d161d1 ("block: fix blk_mq_attempt_bio_merge and rq_qos_thro=
ttle protection")
> Reported-by: Dylan Yudaken <dylany@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Thank you for the fix and sorry for the trouble. The patch passed my test s=
et:

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>


BTW, may I know the workload or script which triggers the failure? I'm
interested in if we can add a blktests test case to exercises qos throttle
and prevent similar bugs in the future.

--=20
Shin'ichiro Kawasaki=
