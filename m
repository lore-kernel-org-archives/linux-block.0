Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11FCC4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 04:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiKPEXL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Nov 2022 23:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbiKPEWd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2022 23:22:33 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CBA48763
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 20:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668572343; x=1700108343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w0yle//ujr1lYRRM24XdIEbvJkIFJhEcRrGI86epyjI=;
  b=HpUIK1NxdRihKuufp6685jP3MKMF6VebO71hDwWILe/E769KmTO86H7b
   bonDRMSznoiQ2ONMiN9JPgf6J3LegSbM3Bx5+ayVejsH1InLYKnZEvVtt
   L7O2VAgaUbFb4ZhCSUDsZkIObg6hHhUias+OEbCAFcV42AUoxGVnNzeKc
   mNdcviyNRlknpH15X6/31b2Hw03GUZdFEsbod9ySV3NW5A4DxngC295d3
   MCRyiZoevmDZHeIjYLHXgLpqR47lPwNVs0JHnEVfUwkK/HtfSgZh69UgC
   2tDvmrB8sVQl48W6cS4nZr5lGWiRuK9hO7tED5bXQtmOa6wlpfv87Xaz6
   w==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665417600"; 
   d="scan'208";a="221537930"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2022 12:17:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awA0nL1LByI5BSktt7/wHEnXgrESpsnSjtd0dTyQ5M2fyxa6BGTvgvtBRGbe9K3vrquenpA/yDVTFwx7AOgUSQH9BOQP4cwyxL3ujhT8emTkuTDcN9dC1SKZOZgHwlFPy3IA5tiiHO728PV9U6HLKaS93oAJTaJQ45m67Esb+sEl0uAQztI/5ycQGmDs7l0tRE7HLV+FHzUUtCuY4bAWIFCjoBgeLpDAkn7Qodfgz0MZS3izmmbTjs/4sCzwbn9J2pkp+pdFw8t8VBWGAAT6sThAbDTwqWHtrzksjJ1oJdTrVQZcBsWuWAGptLmE+wxMRGQZMWfGPuUqz1EzuHjC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzbhaKExvRrR3Gy0qCIYZ2LkX592aioGdx4X7q9FqMw=;
 b=WeH3eMbHu7FaFUIahOEtMOanE9Up1xFdUlJEFktlpCmqaWNoG1hMUk8tbvyBpAHnk64O82oLfp9Y28frU46WCAqmjh/pjFOuKYxtfkcIvI36wB+DKnq4U8ogjBA/Ee/c52f22y+stwOZi9EACADLmFLe0HumzCMNuSnhCii/GIo9vfiidwPImNO2PLh0CuV8qtDp12LoQHsMAl6KO7gP7ZcUFVKIEdYXlXBafU6DSay8/JkxSD4NRK//L6ZG9GVADhNJZO/Ic/L0kWWnR7IZm0YLKw8U62KXo0i712C5aiBAjmYcO7Wco3Xu4YBmcBbrQ/xRJR0FwKjUywNn4dD4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzbhaKExvRrR3Gy0qCIYZ2LkX592aioGdx4X7q9FqMw=;
 b=aFiRWFTNXWsTdT0LKUCTkwviMYZzgcP0EBZ/0ooSATzjWzuPQ/FVZ5Z4OwDoA23jMQ65Q8so+IY9F5WfvcjbClpt+F3fwwjU9lAy5QRiZ2qRftJ+vG5J4/Xp9kPZyZl7zUJCnb/mw78BI5h5li4Yw3+pSTVhAAkkuX16FF4Myeo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN7PR04MB4130.namprd04.prod.outlook.com (2603:10b6:406:f4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.18; Wed, 16 Nov 2022 04:17:03 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 04:17:03 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Alan Adamson <alan.adamson@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] tests/nvme: Remove test output for passthrough error
 logging
Thread-Topic: [PATCH] tests/nvme: Remove test output for passthrough error
 logging
Thread-Index: AQHY+VAqj+m0i7O+SU+q/si86nu3RK5A8eyA
Date:   Wed, 16 Nov 2022 04:17:03 +0000
Message-ID: <20221116041701.mu4osauvwqsbvjau@shindev>
References: <20221116001234.581003-1-alan.adamson@oracle.com>
In-Reply-To: <20221116001234.581003-1-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN7PR04MB4130:EE_
x-ms-office365-filtering-correlation-id: 931e4993-fb11-462d-c360-08dac7896a4c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30N0NJg8aP8vEGBOWqVf5L6yshuBwsDw5UoPBu6yh4zcuUGHZZqUbw7HC25zE9vlxspYitw8BVad+HF/ajqKk7hdeAA7p0H/W6sVyxbUHdTFJ2Lg671VMXgHp2uxcYowOx3SCId8QML7fMnpEZsrxL/pVRm8mW5cjiaIFvvgQoUpq0+G3ZrqQeAwyBdT6qvqpwU070UzLfa21DuSRtetwAjjixi0Lq/iIFU0e/C+IS6/qg4+9CJUZ3elkkz7VN8R8V13XSlL4FFDHShTjvAH6LuH+wQWsmBdANwVTvoxwVY9ueHgODxE4+8vbBOXqOp454sAPl0zOGKJd+WT5hUKIDetvbr/3f5YYgR4kt+DaHJL+MQhAjW7lVYwZQl5psoaFjQoTDIPIXTIEgztHHoJMCmrrXDdWFABgMiK9ufXNJcFKRb2IuokQFHHoUID0JlWAetii5dmGyGluaJNE81dbSYeB6FSHJe9stFWgWz19z9zvDh8vWXAru7dN+njuTJG68cIJJp/U71R8xQbuzFltptIVQ0gqlu97MqgKdEm7DBtHmUtxarnQ7vceNSWEATgXDTu/KW9apMNJM3Yy8eboQAvCa4y8xvXRJ+9i6uG1rkzdF/O8c4kiRZILXZ/fkhRPeWCrv9h2T+x3jK4xzXb8g2xqL2JcRNmxMj9Bllhlp3CIor95619IoLHWkx0cgPQ8vBIL930jG2uODmUinKk8zY5F+iDObS23mN+8dIKQXop8GVZmf5ncwTGi8k+hMqfBCORmP6x2IF1srBWD87cEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(76116006)(44832011)(5660300002)(6512007)(91956017)(8936002)(26005)(66556008)(4326008)(66476007)(6506007)(41300700001)(64756008)(66446008)(8676002)(66946007)(6916009)(316002)(122000001)(186003)(54906003)(82960400001)(86362001)(33716001)(71200400001)(9686003)(38100700002)(83380400001)(2906002)(38070700005)(478600001)(6486002)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AR1usdmVfbxW3x4FyEN/VHpRczeCMBYPHzyy38cMZdd5bnPlJWV5m3aYZzkl?=
 =?us-ascii?Q?3PBT9xVX9wPt9jreY33gfYfq2z8Xx5ZDse3EmwbEEFuPMAPtmVl+zkCG09mq?=
 =?us-ascii?Q?RtJ6k2LwyKsoZMb6RIPRglHQtATWtYwdvVXPyy9r8Q20wdcWPjvgQFYmqqqo?=
 =?us-ascii?Q?2pmaTqZNyMFYKbdjnn0MkFjbwgr0vxi/4Efdz2v3Z4vHsNzRJrMI8UJnXE20?=
 =?us-ascii?Q?VJWAkuZJ59IhAZD8NJr5h3VVyLQ4H5MdJeJCeNy1wnmxuqZPfxMIrqRN5sn9?=
 =?us-ascii?Q?0IobJOGGtk4A07ua3TLu6dp3h9GeEY2aBhejZpzjRPZvPrMlkVKp+FFklBEv?=
 =?us-ascii?Q?WmqWDj88rCzoSGRlocsRRENXtSNcWqYTppQSXvjIj8TUj+12KamX1/OnQmSp?=
 =?us-ascii?Q?XRiXFi0qxwBFP2txubLwmkyFly5SMYGtBU2cI9qdLx5ZHSkx5IkriewAR7e9?=
 =?us-ascii?Q?YNqkwQ5pEkfKl9G0bMFxZ7AUcncjMJ9tOYb2bEgZhOWtBzOfBo78Ak7ZX0qX?=
 =?us-ascii?Q?tI85CZOXTsjLwutS5Yq8whBGv7ZJhxxaPc8AVNt4v2KjbM3ciLbt4BYzA1iS?=
 =?us-ascii?Q?Y4GPoxWN8eiuwfM0R0syK4gNcD2hU8Ls5NqmBR77DbjC8mXwo8tSUMTzDgYL?=
 =?us-ascii?Q?38e5RPI/qba3sy3Ia1Ab360zWq6sm4UFEwyaF1qe1yAdJqvX0t1VmEBpLXMJ?=
 =?us-ascii?Q?bpQnMK23of4OHnEck9yGP9+YXKSRI7hU2Jw3+oQwpmmpTnZhEifwbqyNiH4X?=
 =?us-ascii?Q?QN2a+XcBme0yMqC3+6/gExFsmBweAM/2n7uS6HcVi8ezPf+mBc6ftovY7zda?=
 =?us-ascii?Q?XFBs9cyteGjgzBB/I0shSvQtvmGapQwPqEWnSJP4G22n8QisOFzUu/AhIpsE?=
 =?us-ascii?Q?891GWZXCpB1sHGSr6779A0NoWSQ8KHR76cx0r3hj5zUuE+YYiVPQZVgM9ofH?=
 =?us-ascii?Q?ycw/mLDmOliSylidSw/NQPb/YcSOowy2RjfQtXkakZPE76RlEzzew6xLlQk4?=
 =?us-ascii?Q?cjHW0ZVE1H6yeWa+WxggCzOurvR4gjrGbTuFaZyw/ZWP5r1+I9YVf4HooX8B?=
 =?us-ascii?Q?CJS+bn6f8lDhgEbZfziVWMKcnZJEkFunTD7DQSzbItRhVQB60WLZMwSUPOnR?=
 =?us-ascii?Q?W7uem0kbt8+m19+rI2iEeMylMbhoOuRkDJQ6d73IwHS35I/e8OZ1Q5rG0SS6?=
 =?us-ascii?Q?ae3cRbpNvbvjV3AxPAV3/t55E5fCGGCwRfBVuIRjXSBqdxZiRfNaOHXmHKo8?=
 =?us-ascii?Q?p5DPhFfyCYIjkuHR6fK6wqzS9AAGSX9l0jJ9zUxlXSL+blVqewWqG3B22J4O?=
 =?us-ascii?Q?6Yq0Ht9g9tV+aw/yr58J3yCFn022FSG6pKYS3j/yiTZbqNO8qrwjxW+pMy/p?=
 =?us-ascii?Q?zXiOkwMkFnaOABNhEHqYWRIeBW5G0FAwRVa0qY1km41YzFRirAT6r8QtjY2p?=
 =?us-ascii?Q?OWerimvYnImg8MkFrq0py+pTEaFw7rDOu3/EIzmjSoNkUadBxwi4gumwnnTN?=
 =?us-ascii?Q?eBbS9dzvkALymVVXr+Lj96dHf7Itn3Bo0zSATmyjJWwggl7pwZ7bG78CB+He?=
 =?us-ascii?Q?ylBt3e18/qx4ViL47YfL2aoUjt7RWIMTzL0oVD4cH7SCgIVhaatUuisPBuD1?=
 =?us-ascii?Q?4Lp7/oU7qojrib0T5p41eoA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE0EDD2F1914034393DF89FCBA54935D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OfLpLCIAuvS0oWcMY0+6i4CuEk83OhBBi2QDm9ApBECHvoN+r8cCN9p86ve+jYCUYvTPASX4FSTp8hY8GmNYJJ7noB7w360zG9L5UAEQHuY+k3wcQUaaE/F+MjaSNj4eFlqvlsKuAElcOF+p6b76WwFoc61P1A4LSslXPyuaOLNlPLqbpRU2x3UP3pMiS+iA6AmXRqJiWH/f9qOtUP/iN+HUrjyhqcKr5FMG+ME+N6j0n9yrNSzSopxqCf3VpBhlH4/UR7EFEr9biS4MwAWfZECKY2zla0TCyrcbR+No+fKaDs0rwgOTv4OI+z4Kx1L7G5M7oDxH3WTKNNE3vYk9fpm3g6aBkerIJ0rVCypE2QHJEu3pqrbUf/bZJMvup0ur6C0WleaHJiWPbLB62GUmE2ucN2FUo8go7kwrJ43fdD0tuvML/2nij69zZViqpmUTaZRlmVglTRK5Sl+0dlBnFh5WyeNrluTMktkO8aKPIYp8/Szj6Olhy8xbofUjIF5Mx1ZboXLT86Rfp639z92O11rQN83U2yvVHsoR47zfyIUuRkVW7f2RTfK6IpOYIL4G712QzzZRibpTH7KL7Ykb3DJULgZtwGMIx4AzM/f0rzkkc1W9lfbz8IYfTax0QW9dZmF/knucQNp3CjQZ+gvMBka+ecTON4YnRkejSpAeIH00nTrtNzA2gHJN8l0M/iut6BcuWl2KNaYuTpPYs4k5MHG4DRQSTcU5i4D7RsNHjHGiVbblPw0qv1vFk5hBm3d8oDTnUaQvonLUU6kiTPauE6srtO5WZNKTHbwbGDrR+hPddBvR7Md+2QLUP0kJ2FtfkiOcsU3sqf20Swpz9zBoriKo3fNRxMdjkM/9ll3a8PU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931e4993-fb11-462d-c360-08dac7896a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 04:17:03.3741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYLVag7gN9CIU1g49z7JwJb4dRW6xVgPiQNxfIg6xgj7VtbxwyTgr1UXjxXnr74ZppOe22DLLwZ8HL86ba6t2TCKIQu4p36GBvpewp13Mn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4130
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 15, 2022 / 16:12, Alan Adamson wrote:
> Commit d7ac8dca938c ("nvme: quiet user passthrough command errors")
> disabled error logging for passthrough commands so the associated
> error output in nvme/039.out should be removed.
>=20
> When an error logging opt-in mechanism for passthrough commands is
> provided, the error output can be added back.

Thanks for this quick action. This two-steps approach looks good for me.

I confirmed the fix avoids the failure with v6.1-rc5 kernel. Also, I observ=
e
this fix makes the test case fail with v6.0 kernel. I suggest to skip the t=
est
case with kernel v6.0 or older, applying the hunk below. Could you repost v=
2
with this change? Or if you want, I can apply it together with v1. Please l=
et
me know your preference.

diff --git a/tests/nvme/039 b/tests/nvme/039
index e175055..ea626e3 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -14,6 +14,7 @@ QUICK=3D1

 requires() {
        _have_program nvme
+       _have_kver 6 1
        _have_kernel_option FAULT_INJECTION && \
            _have_kernel_option FAULT_INJECTION_DEBUG_FS
 }

--=20
Shin'ichiro Kawasaki=
