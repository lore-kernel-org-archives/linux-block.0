Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A8DC433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089E9611AF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhIOIrS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:47:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40856 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhIOIrS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 04:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631695558; x=1663231558;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OrKQIsv4lNydINZ4Z/KgFpBRKD8R8m1jLUP9wVpAET8=;
  b=eSYzfufeL5sK3jkd0djCVjOqsicbpVfCAAUshGwW/FT7Bi8xY+nAsbaZ
   kJLtq32TUWVlPUh6uipAT0FCV5NNE+V+LemBPdZN+aBvIA48qye9ODPpG
   96spk/9OOipdtGDs0Y6RxfjL6DWhDcedlIm5sNLjVqXvu7jMJ2LL0BQaY
   Nt2PzMXA+LKmvDAjrr9nLrNhABgS3yEc6hdNeBC8Guo1PvszTqyvUJHqp
   FVGqJoAC7qhfPkuTLe2Qawe7CSXt7XSG5boKpkp/lX4VJMp86UL503JoP
   cnVDlLgyjDtFbUCVzwDJVjGW0PPbpmCXUBT40DHldnU3oMmHxQx6TXvDA
   A==;
X-IronPort-AV: E=Sophos;i="5.85,294,1624291200"; 
   d="scan'208";a="184840091"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2021 16:45:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9ZslR9JaCJGzhL76ETRDw5fqsFk2CHo5dC1uBcpkHZUKh3JbsRGqXl+uPp7fMre1NoQxjG+A85HF9epzsJmUy+GncYayxfjW79+eFWxiiKIxHbD64ArPwqIhgR6aSe7qbAKIuCpdmlql4BR6tgajY5QrVyz1ZH9iBO6L0Kb5LVk3LCX7deR5cmftwWBbHfWTFW1yTs8qb9hNb0UCKU4ME70wiGGhqdaODNN/wXk8vimpb4HvR+yR+1QnyHbUQQzdv/kaXLmRQnVTVSVwuGpzEmmNlOG/Z9iYlwSB+tTA6Nx/zYUv089zZkaU2Bs3pK33K/LYfw1Gc0fdQBbpxQHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jm8cZNPGOWm77LZLBWIVzp0owRTwlxTvVtwUzv6oNxA=;
 b=WrFQBuGH5ap79vH3nijM0Fpon8OOKuSyrmRQkAiCTrYvydIqFZPUud9AiPL4k/+a3itcykNdgtRdl6QP7wfMb6pgWXwC8obGA2o3PaHb+vjTDJ74b52G95ALGaYUAmHFb4ATiWsZVvAPN0OJMDLY4ARyM/wZnOlSN4QDrITvhzG+2mfy+CiY+yuIPpO1SXXLx08E+/zP1WKgPmiBtowMcDn2aSslDwqXNezu06HWQgVIm90Wif8dsZJQKLms1dp+o8c2MsO0fEtytP3aiHsyhkjIbDy1xZkxjUJB9BySbNo6vHw0R9XFICEC2ygCQ0WChZkbRFD7RBERKuLJP0vgcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm8cZNPGOWm77LZLBWIVzp0owRTwlxTvVtwUzv6oNxA=;
 b=BwHeXdJxm2x4vI2rnRMRd7bQkLLeoWfOkcQ/OCWysgGIZZAJDYtolRBk/kfio/HLR1pu7DT/pXCE8nZCgPiYGSDZ6Q+HdoX0I9D6o/vjj+urHIzIn3fqGV5MAodlWphHfgsq8ugQQMTacVGdRlOQ97+Sb5usIx845wepciHyZXk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7510.namprd04.prod.outlook.com (2603:10b6:510:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 08:45:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 08:45:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 01/17] mm: don't include <linux/blk-cgroup.h> in
 <linux/writeback.h>
Thread-Topic: [PATCH 01/17] mm: don't include <linux/blk-cgroup.h> in
 <linux/writeback.h>
Thread-Index: AQHXqfzmZ6ph4/R0Z0OWrv7q3tt6Tw==
Date:   Wed, 15 Sep 2021 08:45:56 +0000
Message-ID: <PH0PR04MB74162E70080738578747F6439BDB9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210915064044.950534-1-hch@lst.de>
 <20210915064044.950534-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d00aa08c-6eb8-4a97-968e-08d978253be2
x-ms-traffictypediagnostic: PH0PR04MB7510:
x-microsoft-antispam-prvs: <PH0PR04MB75107A52A37F9DA00EE6AB7A9BDB9@PH0PR04MB7510.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gEVJaotyaD2VOhlgxExPv00g7tohhytK824zMcMZRDBtHds2P2Mw2v7F0ZqQWvcMJT1aDI6hSIqMnpwBGk+kJ65B/p6ZvApmzrDzSKRI/tcFMvTvRTJRex8PHEzpbaICLTQkJq9sDSSyAQhSEYPj8zRx+sJCWpT5q3iHKrqvLqmnkhhO8FUQdoeZPFi2qDjMgt40HAY3jM9xEl1ahNX0ccaHEN9AW/bOIw0e80oqkJGjEb2SE3V5/TJHr1L+IlRwkaEik+fd6MVcdXMLN7NopdmOSWEJ9pVmHvxKAMG41R8XaH+ZMz6TA77SlYIfdeOw6EK0O+zjCxcswfxvYd/RzmP4gHezsrxN61rDaGs9HKKAZATfSeXxYXgkAIHgHevN2UFwSwKmEjruZYA4FnpLnsgf5FUTLLrX8bysd3ulziiC0gcMGUoe4afX8LCwM9fP0WAzl3bzqwPBjGaVlmiIe/K/AY6XVQz6DxMrp5r5HOMnI512oaVuMieYDfvsV2/F2wRJrzhzQCFcOFEDd0S/lDGhQ2dxUGVS6kMacPls54qEnvbcgg1dgZyPFVI9oGS7uF36bHd17Iku+iXkNbLDyLQhTNbbueACu6/cyqN7Iquvmq5WlMUgzG+OMTkogBbrSAKjAZ5Qrj3zU2dF9VuNgghGqzQ1eVtp2jnuw8Yc5kLRVs9ogustjxWkLpb9cuFn4ApuXXkQjhnu/ncL30Br4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(4744005)(66946007)(66556008)(64756008)(66446008)(71200400001)(2906002)(91956017)(76116006)(66476007)(8936002)(6506007)(7696005)(53546011)(38100700002)(8676002)(33656002)(186003)(122000001)(54906003)(9686003)(316002)(110136005)(55016002)(5660300002)(86362001)(38070700005)(478600001)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/gBUx8a+x9bsSHGpq+i70JlBulFCWQgqs49EGWDMMEfGP4R7IGlhMa4+usyT?=
 =?us-ascii?Q?by3s+rnApFsdhNM7PPKlYFzfAONwzFCsoUTmKDBedVNimJPOWXlP+UFTBvhC?=
 =?us-ascii?Q?G7FgZQwBWmAkrdWYR4dxmFIXWyh1WzaorB4zF2hte6V6Ibabul+wIy4DIwS3?=
 =?us-ascii?Q?7+B6vpptpOTNGd/42wHLUUoOLLa3iI74fcdSSKxFc88CyL9cUGoY6GLgA3vz?=
 =?us-ascii?Q?ccZ5wwuWNEXs9rqEywgSTraB1GUd64/IXAKJtQ52mrKA9uuvqSokiymTQw2Y?=
 =?us-ascii?Q?qGS9zo8AGaiHmX7IxZpcqtEkQKadgLBiFtLDr5HC+qGW1+//tScr2pWqGldv?=
 =?us-ascii?Q?ehKiGyoTqG1uz5HF0VmikOlBh4SzVq4DWhU4XJr2yu6Q7WEfw85eopuTGYhL?=
 =?us-ascii?Q?N9tev6G1bkJdZjB1gC96D0UuPcN9mkhvTrHJvnml3km7tYMg8GSDCHjD2dTp?=
 =?us-ascii?Q?hlzqNqhMulXv3X7eqFN5Xwyl0velpjRcz4pWCdDGcl+wdpNaRk+0FYlH5+Kl?=
 =?us-ascii?Q?8t454C6pUOZj3oWIndqIiIsmyHYooLQIOJkybPoC2uuSpL77oDARpr7GEwiM?=
 =?us-ascii?Q?mmAl8ddR9kBtVyny/uU/s7tKDVTM/lvAX4hNjza0RGN3nMayduBiT4VITlP6?=
 =?us-ascii?Q?vE31x12aP2/TBwHOfdd6KmaqwOuViVeT8UzJiZs/NmOXof9VdLKhXT5WXCnK?=
 =?us-ascii?Q?Tnh7eoeXYxFBlkMw7766K7dKMeA9iAlPs8+koXWa2/IwzL4y1xGk9xy10DuO?=
 =?us-ascii?Q?9c/Ypbc3xTnagmx1AsLmyXpKYIE6Abqd7GkacjWOvQzSXMdOXP7tdMhzt/NR?=
 =?us-ascii?Q?Kp/DgfKSlk5O6FTECFgGWquZRo/zqHKaUVC9Ab5SX0Z9Vphod2bVEFiS32qZ?=
 =?us-ascii?Q?GB9fz8AYQJtxw6a9ZQzdY+0BJxfAHitq+cZ1gOSt0wBBE85/36tkpY+D7QV5?=
 =?us-ascii?Q?22DoIOC9+GxHDtjwLElyVEO4kC/eyKLw1eBRJ0kGG1T6geBYOnXQ5SRfCGTf?=
 =?us-ascii?Q?qSEnFqVZvlnVag26UA1btk3kfovyubTUMKuwC5SjH9C83ahNBF8fpqtYR3Cq?=
 =?us-ascii?Q?/0GFQmy965jCifpEs1O6JB9Mw/vd/mj4Vnbe3+w/Z/yEvlmT2MYGXL7PMdpv?=
 =?us-ascii?Q?Q/IPm65BHtbAZx7HHDXfrMrIGsUXVY0JHiNlhRZvuFoq/FiIIcOCiI83ryND?=
 =?us-ascii?Q?ZusnDeg9pxKC6tm07aN/vL761JvzrtK3Q+XYSTL0+7LGhmPEjj8+LNv4GiXK?=
 =?us-ascii?Q?n17qQZ4NhJRk9CpvENQ5SW+rnyszbsluktAHo0wrza2xJuNJNTwDbLWZfvb1?=
 =?us-ascii?Q?8fNDNJWSSMsim7dbZt4m3vrnaM3Kkmx+VoB41AfoSbyEaig5XpOAZZiVRVKV?=
 =?us-ascii?Q?PTD/ajLVL00x/AMbkNcomj26zQaBqb7cWrw9UzN3pejkiRW2Ng=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00aa08c-6eb8-4a97-968e-08d978253be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 08:45:56.2568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sp0AlFhYPLCQU/d+8yBblXZNW/02AYt2jxI4ClKs6mY9GfJGTI8lcOU5Yo4o3zCYSKU1ZFmtHQgElL/Kkd73ROeA89D2NGltwlBrQCY7K3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7510
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15/09/2021 08:42, Christoph Hellwig wrote:=0A=
> diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i91=
5_utils.h=0A=
> index 5259edacde380..066a9118c3748 100644=0A=
> --- a/drivers/gpu/drm/i915/i915_utils.h=0A=
> +++ b/drivers/gpu/drm/i915/i915_utils.h=0A=
> @@ -30,6 +30,7 @@=0A=
>  #include <linux/sched.h>=0A=
>  #include <linux/types.h>=0A=
>  #include <linux/workqueue.h>=0A=
> +#include <linux/sched/clock.h>=0A=
>  =0A=
>  struct drm_i915_private;=0A=
>  struct timer_list;=0A=
=0A=
This one=0A=
=0A=
> diff --git a/lib/random32.c b/lib/random32.c=0A=
> index 4d0e05e471d72..a57a0e18819d0 100644=0A=
> --- a/lib/random32.c=0A=
> +++ b/lib/random32.c=0A=
> @@ -39,6 +39,7 @@=0A=
>  #include <linux/random.h>=0A=
>  #include <linux/sched.h>=0A=
>  #include <linux/bitops.h>=0A=
> +#include <linux/slab.h>=0A=
>  #include <asm/unaligned.h>=0A=
>  #include <trace/events/random.h>=0A=
>  =0A=
> =0A=
=0A=
and this one look unrelated.=0A=
