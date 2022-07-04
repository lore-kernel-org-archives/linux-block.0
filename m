Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82431C43334
	for <linux-block@archiver.kernel.org>; Mon,  4 Jul 2022 05:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGDFUO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 01:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGDFUN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 01:20:13 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB6D2BE
        for <linux-block@vger.kernel.org>; Sun,  3 Jul 2022 22:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656912010; x=1688448010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eOQYKRcSXfRp3HTi0cM92HaIGmqh7gjTBzDXJV7Pxlk=;
  b=ltP0gxC7f6mQ8KGuE38yYYGNOvDUBf4C4JHjJMQIci6qmJH2xEoMTyCT
   Gj4fFDISv93qkeOXkpoYuD/OJp7ckfma1T/T/LraU48cainL4Z1wU7Brx
   QJFYtrMau0G9b1zIgltAHSOBG6nOdzxKNqEeFCAjXgDN9tK5cj2FF7Bi6
   iXD3yw2plBZ1Mhzj2+Dzkf4njXKOMw1Rj6v8j56XtdpyYGx5apGtZSeOP
   VikBByGmGs8HsZ70R4PoahzqdRSa2cAhytrf1HaXK8ipjZZKF45Os10ay
   PxvkLBJbv7ifqj12DhJMkF1R5M0Uxt3BdVoelTDqUhN952o5xo3y7JVlX
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="209625457"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 13:20:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNuQHUYsxCmZHCbav36HaubT0UAB7zmxbICxQ3gsBuef5XiKPUuVVviz8apUa0Iupic1eMNjAASVm4IBKBtbZPnWLEaawV+zmcssJuIo2h89xXOuj+mDfJvv4F1C/q+dITaWXvC3Dn1wvNw/RbjdRQvejRSyYdpqhbk4f0lAGQXynCM+uT2kL8LuaMUeX5gMtozqUoLUIdKdEhb0hSRosJITcbUzixphDmlsMIEOFEiiQQygvFU9Q5RW4t+aE+HrE+MEdwBSP5VrescnByo3M2XkXmgLI24x+jXTdUlj8LdQlopIhvFxnwezthauNTvsAOrapoMIiCnhI1QI6xgUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=222WGlNURkjTHQyCG4Dd7hH8/TWs/5nx/A07RyHNI/w=;
 b=Ef0r+I30fbcO1UXDa6bgZXOBWTaC6zTRWrHHWmMFSHEvghUuC1xc7qF9xRL05BmwDNB9lWGtv/SCSsIXG1MUSuDenPVMnK++RCubgmQbZwZUsWak3oIokml5PrcL7wtSotKQEgUT/oI+sTZPGmksnW63BB32vjU4FqydNXMpAvK8cIiLr0SexfwutEaNHr9eBMK1S0aday8B01qe34tD2lIxKYEmYM51WvhRqr8kvrc8+AJkhYrQ4W/cqjf4n9C/FlpnZMqNnDUO5wcWCe3BY3Fl6QlHmadLy92gs8J2l7fQK1J4kmiBgCimeFFBrPvqzfDFV36sXkOVuh5NtRspPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=222WGlNURkjTHQyCG4Dd7hH8/TWs/5nx/A07RyHNI/w=;
 b=Vv2zZNb94hKth+talat6iq43xa8I9VzNj6gaH4AuSJuEVDYTEZ4w+IG7xU+BJmWC/kzB5Vkau3UqBDMvkPNVpfnHEWRquSzKEZgBRKRKLA247X/KR/kn4PAv7OUv9LAqoG9u54cNG0av3IxE1rb53nZ8O+g6ylpg9oogdUOmVyM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7484.namprd04.prod.outlook.com (2603:10b6:806:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 05:20:08 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 05:20:08 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] block/008: fix cpu online restore
Thread-Topic: [PATCH blktests] block/008: fix cpu online restore
Thread-Index: AQHYjwg096RdlhMAIEKAAwKQivwDX61trWMA
Date:   Mon, 4 Jul 2022 05:20:08 +0000
Message-ID: <20220704052008.jegtbiposiy5aipg@shindev>
References: <20220703180956.2922025-1-yi.zhang@redhat.com>
In-Reply-To: <20220703180956.2922025-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9745bfbf-9509-4eaf-818a-08da5d7cdcce
x-ms-traffictypediagnostic: SA2PR04MB7484:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m0uFR0vkLlgz1EsrsxEpZsNbgxIhJzoXmwPXU8cYJQdeLod416ujztR9GAwfzYtZLHMTn8xKyH6NEWRKjaPq5jd7Ejmm6cY+3uZ0Ri75J+XDFDySpr7XqYvSBog7O3y6HZ5eCCQ7wo8F0e0A3xYJljjZWXA74b558ffntjUPHdWbssT3rU7F2PJonm2YMrxbg9WH/f31OtDhKcLn6BVk+EbeOVEApUfeZ3VNxsdIDSG5tBb1cqOAoeWVZ4TmCwUk1bVeQxSCPpQnzrxEl0ybyhu8x6aXe2/PccMPk72bQ5GCChYJB96Xx2goLfgpzlLUCAossUZYKAF7M15Y681LiAsELwziWdFTRIvRiMcOerY7KT0UNz53i85HFNLCh9ZTUAEiuzUGc+me58/FiomWqrF//3NeJEGVtO92F0Lj7Egr8WyVN8sP+iushJ8kg5QiOyjmPg7U7mKZ5bYPLT/1jmIFPaic1RLcVv6dasIDO6E51eViYi0VjMCU/ps9HVUSbWBVTiljWCagXamhfUzOlvV5cNAVmVxQs62v+9g06HChBbyk3QI2gC4Nl0hEXosq/KhsG6Mrua7n+XB+sALUfx1iVo2klPdegY8YuGiclqnojGzw4MFBjmbbJZZtZn6fhkKPqEdMqhcKr6CrZMcV+Qx0Cgj7CgBiBQDUBTbHyDvoSzN2vF6OZrMSTxoX5gENYki5JXghTacWTvc9EXrOt4KGDMcFf2eHwle16XURCW2Ob3C5UZpi7Qx1R43JGrydaP6QHTCptOYnkeb3S6OzeHHhf4XoEC/utKV3ZNsZiRYtPVLopwDWqRF4BClV4bav
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(396003)(366004)(346002)(376002)(136003)(71200400001)(6486002)(478600001)(2906002)(44832011)(66476007)(6916009)(6512007)(6506007)(26005)(76116006)(9686003)(66946007)(316002)(5660300002)(66556008)(8936002)(66446008)(64756008)(8676002)(4326008)(86362001)(1076003)(186003)(83380400001)(41300700001)(38100700002)(91956017)(122000001)(38070700005)(33716001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Imx4giQw7x40P+WXHNtC71MVXLtnVD2QYk6EWe9J4t/mejZ5jX0MpZ18e5l?=
 =?us-ascii?Q?A/iqqYi+b2neFWniuYMHPHhimuYWmhMTSw+9rdy0gryPVg3ATwZr0NluvRSg?=
 =?us-ascii?Q?VJrYQHQH08JkZng2nn1/hhWdV9Vx8ZzD+7Y7fJLKsHDgjUOtgzvfWripRLWy?=
 =?us-ascii?Q?bCKX8e6rOPf5pl4L8q04Hh78PtjPvRcef1k2P+U7ARtOrNLdFWBOe3O1mKN7?=
 =?us-ascii?Q?legOWO9vY3yjMALl+DiNQFkQOYuOMQhS7Z84a9olL3iNDedJF/y0ysR28hMF?=
 =?us-ascii?Q?+vP6LJCqq7YnH7uu3iaP+i9E1uG39MJYQlZvrQuaTTUAAXPWoaT/zdmSoFLz?=
 =?us-ascii?Q?c0AnQb1ZghSS0ucgRgrMUaJ1yC9SQW8Loc8AS+ZB+i10CvAwa9Nw32upu+0h?=
 =?us-ascii?Q?3MYtLxkkvRg0a6uPT8twmZm+nAyoEpXjgdVXY3f2hXmdNiaQCltjuzfaH7zt?=
 =?us-ascii?Q?1Pw9qkPv2weInng3jPFo56qwkS3IQ+APrGSQ/9ZujHw+nMgDBuh2Yv/R8W+U?=
 =?us-ascii?Q?7hbHI9SsNU1HMCYAOd211t7lljrBZzXpGFoZY66nVUbD2zLwzEfb96LAvema?=
 =?us-ascii?Q?LxPJdz7tVPOeyqzejViD2jFzm4CSU4qXdhON8wMScVtvG07edm89nrpgZta8?=
 =?us-ascii?Q?rZqEmeTYXB7hPpErxVZ60n4Y4Agenh4b8U+qj0drLpA+BUbAa4mP2n8AmEhv?=
 =?us-ascii?Q?L7GZCOoaRx65O7fFbsZmLpn3HyN5AYqC0D0giIOwlgbydceXU3kM9z3CPvau?=
 =?us-ascii?Q?cdeRJc+w9WpWkIXRK02uwpRwvOo/MXzMpS3YkNBu8QKfD7mitUnEh9wbpWLk?=
 =?us-ascii?Q?aDxbuV8q7/IBOndj/JQKqlkidLyfYFO24wQ1Xia+nWOnv4qlykdq/hHXMvax?=
 =?us-ascii?Q?KKqsrQAGMuvhzD76ag7xX5tMChI0c5tSOMZiPH1YgQn9UW50pJwXVeWGFzsY?=
 =?us-ascii?Q?dkTCHjx6xQWtU1lbv+mj9eX0UPMY8XftMm7BCCynZbFzOBSVhT0H8WAYy4HK?=
 =?us-ascii?Q?hcproVbEZr4vhizrwSh1HSOSVZovu5Q7J8daQByvQHIMMXpVUsM5+rUsusNT?=
 =?us-ascii?Q?rTtlF2wKFEBz/cvu7SVfZSxV/5Vdyb9/hhaOMSZpn9ZGF7hBsvV3SNKYwSHF?=
 =?us-ascii?Q?EIePMCmyyEWuo1HPpvSGnyPFq0NNoCKL7+x2u+wAbxJg3nsx5uvixkKrATew?=
 =?us-ascii?Q?4YobGjxXGnlPghyx0/EbdSu9nQWDDgJfD67RKnmpNL6hqazSdBfRPFvi/IQ1?=
 =?us-ascii?Q?83Jab/8UaJ/qkDdY7EVm87GJrPm1vSsZpzAkkIiRHqxTbO2rczfafaFzNcpt?=
 =?us-ascii?Q?bVpCNNCIYkY+u2kJp1YrVtVLrK6gCjh3mxUxY4k2GU9083BOSlxmkAbGI2tG?=
 =?us-ascii?Q?kVs6N6jmcIQB+fqGzfH1Qf7gO8Ioq0yOVRAOgC3EmTI9fJ6/RBTbiMwKmqle?=
 =?us-ascii?Q?Z/N5yVocSeFAJGPvIWpEwRTOdgYRsInPDYddgsrPWVQOtvNXsKxwwLPhP3/p?=
 =?us-ascii?Q?6HS1Ni9SIummeRIcjcs9HdCLbOAbanPOQqk0lSyvxDOYkZcNenyZYS3EFjff?=
 =?us-ascii?Q?yi4BIyGtxVjyoGUnonAlow68R/D29mcf6lrPXZaoZDDONILKb4XFbX3WJlXG?=
 =?us-ascii?Q?xq1XsAJDe18TAwvFargw088=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D83B6BD334BD614BAA07EACC5C11C745@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9745bfbf-9509-4eaf-818a-08da5d7cdcce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 05:20:08.7570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEJNTZJxZ7GJqKI0IpDlJ/5rFIjgPZ2cXQurXjp/a6jaaL72VW6xj+zz5C99jD+F6rBKNKjmFiNdcsS/hDSgCyXHFXUhNd6rN9/PCkrOuX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7484
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 04, 2022 / 02:09, Yi Zhang wrote:
> The offline cpus cannot be restored during _cleanup when only _offline_cp=
u
> executed, fix it by reset RESTORE_CPUS_ONLINE=3D1 during test.
>=20
> Fixes: bd6b882 ("block/008: check CPU offline failure due to many IRQs")
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Hello Yi, thank you for catching this. The commit bd6b882 put the _offline_=
cpu
call into a sub-shell, then RESTORE_CPUS_ONLINE reset in the function no lo=
nger
affects _cleanup function. When I made the commit, I overlooked that point.

Your change should fix the issue but it makes the RESTORE_CPUS_ONLINE=3D1 i=
n
_offline_cpu meaningless. Instead, I suggest following patch. Could you con=
firm
it fixes the issue in your environment?

diff --git a/tests/block/008 b/tests/block/008
index 75aae65..cd09352 100755
--- a/tests/block/008
+++ b/tests/block/008
@@ -34,6 +34,7 @@ test_device() {
 	local offline_cpus=3D()
 	local offlining=3D1
 	local max_offline=3D${#HOTPLUGGABLE_CPUS[@]}
+	local o=3D$TMPDIR/offline_cpu_out
 	if [[ ${#HOTPLUGGABLE_CPUS[@]} -eq ${#ALL_CPUS[@]} ]]; then
 		(( max_offline-- ))
 	fi
@@ -60,18 +61,18 @@ test_device() {
=20
 		if (( offlining )); then
 			idx=3D$((RANDOM % ${#online_cpus[@]}))
-			if err=3D$(_offline_cpu "${online_cpus[$idx]}" 2>&1); then
+			if _offline_cpu "${online_cpus[$idx]}" > "$o" 2>&1; then
 				offline_cpus+=3D("${online_cpus[$idx]}")
 				unset "online_cpus[$idx]"
 				online_cpus=3D("${online_cpus[@]}")
-			elif [[ $err =3D~ "No space left on device" ]]; then
+			elif [[ $(<"$o") =3D~ "No space left on device" ]]; then
 				# ENOSPC means CPU offline failure due to IRQ
 				# vector shortage. Keep current number of
 				# offline CPUs as maximum CPUs to offline.
 				max_offline=3D${#offline_cpus[@]}
 				offlining=3D0
 			else
-				echo "Failed to offline CPU: $err"
+				echo "Failed to offline CPU: $(<"$o")"
 				break
 			fi
 		fi


--=20
Shin'ichiro Kawasaki=
