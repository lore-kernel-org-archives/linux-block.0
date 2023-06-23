Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34E9EB64DD
	for <linux-block@archiver.kernel.org>; Fri, 23 Jun 2023 08:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjFWIyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jun 2023 04:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFWIyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jun 2023 04:54:16 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED28D10C1;
        Fri, 23 Jun 2023 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687510455; x=1719046455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+qz+W3cPpCADCJLvLvBmU74bNuVE0Tjtx2bxexKlSDI=;
  b=Kxpm8JJgTd/oJk7V3UvHUIfj6Lalj1mpMoO+GDYfEW3LDxbkn0fSXCJA
   qxM32KNXFwwiVR9eJNDkzZcR5uvQVUfRtH6xj4DOUGerEHseBpanpqxAp
   Cgj9xyeBmW9T95LigCOWu+nFUoId4FcEcFODpoibwx6IKVcRdJTpnh8la
   mS0RIldpw4R0f1Ktg3uuISg6mP7wMUelBI/dihLNiYh5UHHgWurnenvmX
   dJOBTu2k9UFs+CYygAVksxeAjuR8Ak++XqGaooyikX6KcGMQZ4JwQon1d
   J13W/iZ/8ehgdS6chi2PtYYgtSVze1/Fu9tNHSvRuzOMC5nL10tmucBoo
   w==;
X-IronPort-AV: E=Sophos;i="6.01,151,1684771200"; 
   d="scan'208";a="236044863"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2023 16:54:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8bKz9/0Dea796rRu0V0ZTEl3TUYKTIQw3F2I6xm+WUdeEFMJ5XzB0vRZqQJo/l4I3vmSaY2c91s2c7QMABJOQwoA4jeE3/CtBr1nLLkXXFdDxaetAUjfu04KF4sSaWYDBgSnKEcNT5soJUaAbHWReZzmZ/C1r7Lwx6qrRgEfC4l7y51FNVSshOXi0zrZCbR3xjErR7k3n6SYqENey8U6dFVxdPKPhR5IxgyuSnls49I6a3o1wvSOHaYuoT76paDMRsneYJoTRlXcL1WkuUUenI/Nlntb5oYecDyLq/a+pTOpzs0MqRlCGDRgXo+kMBOizTQ9RlyBF/9G8hkLmaloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qz+W3cPpCADCJLvLvBmU74bNuVE0Tjtx2bxexKlSDI=;
 b=dvGordNAXIm2Xal7fa9znvRbB+43T8TilGzLPK3ZhLyJuEMM57XWIQAQl9xJkFdQlaYiOq9lqfwOzJzRLltxFurhTF/Ofgd65n24oWHb1InYpk63HxITX+dyKGZ90J6u1QoeuBe13G0Gx+wM669KSceHEiMX96yRRTUGrbDKlnLEXT+mlGEqafsN6JGjkFn+RFDc/o/BrlZWdWvRjrhaJAXgE8yRaJu+nVNrvc5QF80tUv5M0UxGO+A46IAzxsgjnC2N5hFIEuh5OHsREfpj3cIqmez+GMr1XIiMHQ4bWZh4C4sxgEMVDt7BFjuMDrJFgXu+4zn5/Xqk7mY+uyxldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qz+W3cPpCADCJLvLvBmU74bNuVE0Tjtx2bxexKlSDI=;
 b=ESdkCxrPUma0tcMAy706r6wiN++Shm9KB2Zv8lUx9bVP2rCE+AWUidDS9zIaf27oJy8NpuSmMwTX37o7QINwv658ZL6hYrHFKGNd3go1NwQZ5+UYljPQ6pgngqeDev8dyShJCVbNNKV6daLuXs7v6QFK3TVDNCFZIZj6ZcCjdxA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB7993.namprd04.prod.outlook.com (2603:10b6:208:344::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 08:54:06 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 08:54:06 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jay Shin <jaeshin@redhat.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] block: make sure local irq is disabled when calling
 __blkcg_rstat_flush
Thread-Topic: [PATCH] block: make sure local irq is disabled when calling
 __blkcg_rstat_flush
Thread-Index: AQHZpOWyalexY3rv0EGLnyvh+ABlIq+YFruA
Date:   Fri, 23 Jun 2023 08:54:06 +0000
Message-ID: <s33v2z3pspz7vkgwawxetz3yudbhwbnnmkupzeqf62i6272mex@rks2oo3hur4h>
References: <20230622084249.1208005-1-ming.lei@redhat.com>
In-Reply-To: <20230622084249.1208005-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL3PR04MB7993:EE_
x-ms-office365-filtering-correlation-id: 24c02f94-aca1-4e08-de29-08db73c766e9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fU3SvjRh/4T+OP+T5SWr1rw647YLLP8rywoNXcz7AWEcjHunltJlORan/0d/iyrJ2HfUEU3seJRkT5caj+7Xbbu+265GBoy2YaulHcKjwTAeYx31f+MUi+SVvRXQ11W1EDz1Momhdajs4myme+8uC/LC7X10xSpCQqeulRklbW9YNFoAW5CXHtFuTPeXC8bZgQs3dY0qro4ir/ZI4vdlEGgPHKK69POwOrlEmAnNAPmOvWKDegWby/ZupoqUcC2cTgL01VclM6Xk+Elo65jSBPft3/3E9J6e5sz7OBcSjZJ8TJDGJWSJPRAMscsF8dMEZCeczq07Y10/qsfDH8fibcnaYn49WXo50NkOfempoHTkktY0uO/edJ/mSqsMgc3cUdOJCY4sw++ybReLPJI8avcZuIQUtkzsZ3iri036+miE2GhjVZHmtLgyn20zfgSGevLtfRm64wV/JprnoDkZCubp0UqyEmiYswKjuRRpR+rBuxFAMkw+mFLN4Kzj6LtG/bzQoabka7BkZZAMZNCJt5yWZJeNO1ivWRkNi0eP1kZeqc8jkcDGSxSUsZc6nY/zewPbTHHW1JJxXkKs1rZBgY/T9kyFvxv4pIeZh6EQOQA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(6486002)(38100700002)(38070700005)(86362001)(966005)(82960400001)(186003)(26005)(6506007)(6512007)(9686003)(71200400001)(33716001)(122000001)(83380400001)(8676002)(8936002)(2906002)(6916009)(316002)(4326008)(41300700001)(64756008)(66446008)(66556008)(91956017)(66946007)(76116006)(66476007)(478600001)(54906003)(5660300002)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iWHx7KAqmrU4ltwVP7mqNjmBA0jkWEGS6rP1Xr7CzXTd52DgfAV0C/bZHjVY?=
 =?us-ascii?Q?0oaAeNGHkGC+V5hzU51OpGORgYjf3ymJoMsTPAvTlFYzrC+BIud8l+dW9JjF?=
 =?us-ascii?Q?qvaYYZALDTo4Z3gUUmQqq0+VImnR5Xi45ZLAhybIjL1AZhnlHj5ofvpmY+Jy?=
 =?us-ascii?Q?SqnyJr9h8sDoHyEFSQejWDKLXG2lwKKKrnztiRr/Oy0n33NxpAlF12B0VSF3?=
 =?us-ascii?Q?mJagEuPtmIpiiSW85UK482V8fPD5QwIlQUzbekamN4HLoaY4I1h1/XVQ7y8W?=
 =?us-ascii?Q?8PMpnCxSQb722h/QRCEalmCY+Y0gn1GCr2+TQO2wmd7HPFfHUQnZ83fu5u+c?=
 =?us-ascii?Q?Cjbi8cLs8sGHLKgK2GQUiv2pgDSMxuW22FHj5Q2DeEStV/Nb5jPxf58I66gP?=
 =?us-ascii?Q?J4sjxqZemEOnv/r31Lrm6nKJBrjQqH/2EJX30PGz3tvTASe8Np/3wCfWyPwv?=
 =?us-ascii?Q?/zI6Diz1l+6UzBz7JF3ftLkz4xuJRZ4r7yl5e38Zne4KsvE4LsbJVBumCplZ?=
 =?us-ascii?Q?fabgOc/3y3pO8U1Q/b4KSetytQZV3htlRYSGnyDHuF3NTQynRD8CBQx93rNf?=
 =?us-ascii?Q?whCvoy4OuP6Z0GrxjQonxTn0fgBdG8Yl/dC1EJ5zXsm5RwTjItsMyfltpgK1?=
 =?us-ascii?Q?bNQANzCGU23P2KuspCyjajaUalS+SJFRiX1HDNWgD5H3bWo5Nfr7k5c4fFYm?=
 =?us-ascii?Q?+4YA9UKzSQbLZPdvKU2BAFVtjPzOlqzkYbgFZkNtTmKmaoV2+JejyHmg5fSo?=
 =?us-ascii?Q?WHqOA9xT4+hnkPlP7Hvrk9VEyaiOI/9pgV1wQI51cXzLERzc73GntkVVVtEt?=
 =?us-ascii?Q?G2mHyiRYwb736wEi4GPCC8BzY4rFQ/qZ3jAQuM1vNSdTNo5f+Yl0h20qLTur?=
 =?us-ascii?Q?oojNYhWJ6rBbzvB4v3YEVUs9qBqYp69NVtKi225CpPFh6+MtGM5Dx7h9JSCc?=
 =?us-ascii?Q?LgXIjdR0hyoHhdMBA803gC3PiX3KZr9ZI0fDY+xe2lml0M1uNix/Iu9S5l0m?=
 =?us-ascii?Q?gDCLJs629wjsg5xntznsMgc5Lj3yVaAwFATC10s16Yq5SQeNS5QXE3w45hbv?=
 =?us-ascii?Q?9U2kD+tD0va+pLYTuB00mDBQqL1pOY0FmA3aq7db0jJ/Yy7FvF0kwe+CpTG4?=
 =?us-ascii?Q?C+TWaPSmzLf5X3iJ8+aoSuh6TVPzBOSoDa5B8tMPnUqnCwCu9ftkkT+RFjrB?=
 =?us-ascii?Q?qEX8z63LFpINUiLkRKH7zaC++0CCLtGxkWQx9T40pkP3HzRlAe/gar13JWNA?=
 =?us-ascii?Q?L+oznh9w/FGrWGMooK7SikVMGFSet74f1XKdIggbb54KTDQSneLtnzwFC8K+?=
 =?us-ascii?Q?O49MLvnQR7tPqEwbsN1KWERV9ZTrPRQVV23Q6Gaf3lcFiQ0bTgT3N7t9krFz?=
 =?us-ascii?Q?iuRv/yvZX+OGGr/d0yLoyUtCOedLGNjkbQF2dYH8dzkrysMp3kMQvRx024ao?=
 =?us-ascii?Q?oAjxy3XsltjH04JPbgrB5DoRbvwywWzCP+9TMLhjl6+bA6qmq1wHMoGScVTQ?=
 =?us-ascii?Q?0143b5X7HR1CYdiMZeJdhJSBJ1a2pR07r6HMJbYWyvMkx83N6/kMFOEgQvCu?=
 =?us-ascii?Q?LcukKcQ8q1cs7vtXe3Q44snXIeUZekPb7kGKjXhLr6ML0hUTefp1hsy6siiT?=
 =?us-ascii?Q?FIMtMGLJWpY8TxuohkRfZSo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB490FE65D57414B955E76A457FA80D9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pt2Sm22m2Ib9Fz38Kdlp70jN+k4jhuBTAeC/oCuKkIFHoFq6U1xabcRlrn4uc7Wb4FZ20qOLIdx8sxPCgSPhky11iI2S72E4stNthr8xdiMm5zyemyL33e8HPyR39meJDgeCtQJziA0Xmpa3xy5TFKEoubMnkc0i7IywVG6uq8op4fdMq7CDXxihKFM+Zof0P7qa4oVFt1ZS9bEX3Ty+2/vk3khHeHk8lNjjCl+49u/QSmyVgUyFWT9xcdikl1FAfH6MFE6msXGFbYzvYx49R/wc55lmLCsEktaGHU82mpjmKkNMYNX8vgms2ecxdpepD5N6lvz8ie4oBVnjYAIkVbBvhDicHZFJmXoqXNG1wII0lRi1HkY7ls69U1s0Y7UoBBVuJanzFEYp5a1ZHIkDry6tnhQbG3Ca8VD54KsfZGMKV7OyRFdnjuVEWFvuhL3CfdECxMVrhKtPmnm83wPGORSfV3xDz49Y8w3s0PPeBj2UDPbv6ABEmDKBp7IfZobdfKYr+37gzQcuO5BQ2iJCfLXiVrSFpHwDBLyaNTDDVX3LT4X8jXMF57Y7sZhiJfSBFUMgYHlMf/Oaed3fnhe8/ooPzzNqXbUU/MqGdJumk3jX8/ZHbtXsc1EPv6ZuUfXVZDgRoOd8Zbd47d5LG/SqQk7U0lj2MXAKhj9jR3sbbWIyC/vczLSpJHbQWlYDTvf/My0ResiJf0qryH6QsrJfV0bmlY+vq/q9yxNB8oMFlxf/oH1194VgVHtrHgEmUFGPvXcSVxmgIsHm4TyR0w4urYO2CYplaxbldhWXJ2BrLf278GVnR5ChKF++xER2WwbhVgi3Cwmnqp5q+p9J+7iCgmGK1uoUwHHlt5dPEggAuDo=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c02f94-aca1-4e08-de29-08db73c766e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 08:54:06.5090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Req9dD50cN+7e+PdHostb88Jp8RDucySqIyHwB1Y33e4mbxKQB+639g/DjlNPDBOrBvuDf06hHuPKkGl5HCEHgZzCYNot4yZGtReeFLbiiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7993
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 22, 2023 / 16:42, Ming Lei wrote:
> When __blkcg_rstat_flush() is called from cgroup_rstat_flush*() code
> path, interrupt is always disabled.
>=20
> When we start to flush blkcg per-cpu stats list in __blkg_release()
> for avoiding to leak blkcg_gq's reference in commit 20cb1c2fb756
> ("blk-cgroup: Flush stats before releasing blkcg_gq"), local irq
> isn't disabled yet, then lockdep warning may be triggered because
> the dependent cgroup locks may be acquired from irq(soft irq) handler.
>=20
> Fix the issue by disabling local irq always.
>=20
> Fixes: 20cb1c2fb756 ("blk-cgroup: Flush stats before releasing blkcg_gq")
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/pz2wzwnmn5tk3pwpskmjhli6g3qly=
7eoknilb26of376c7kwxy@qydzpvt6zpis/T/#u
> Cc: stable@vger.kernel.org
> Cc: Jay Shin <jaeshin@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Thanks Ming, I confirmed this avoids the WARN I reported. I also ran my tes=
t
sets and observed no regression. Looks good.

Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>=
