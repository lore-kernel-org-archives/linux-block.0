Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989BFC77B7A
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 08:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjEPIzl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 04:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjEPIzk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 04:55:40 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB0E2
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 01:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684227338; x=1715763338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h1dDhg9gFrlvYOaPVBc6FiuG8/Ot6e/uQUhum4OGeug=;
  b=mNDb4uAbgKftbh+oWsQGjVxFMpmHGYieGWEg/wVQFDCPfz+wLSRD4Jb3
   zepo+/F4nE/VpSQy2UxCXSmY10XWjpmnCvs1GkgSwVc9q10tKacWYvl0m
   aTZvGc94XjSuiUx92ju8NGnLxEzkMgonA/O0wcGkgPB7CWWuyogA2Wk1m
   0hWCODnWQfZwVynOW4d+pV0jU3MYAIbfV5BAxsguDtBqqhBRc/KL//B3J
   mhAqADB/uqvCXoIH6h+j2t7yb/NDP8aurvEB4cDdFJAEuQWzwWzZJOgJ/
   NxicjASWHEaAAUVH49Qt/vrbvB1+6QghQw1RXgDyapjtEr/0dUJwyUvBh
   g==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677513600"; 
   d="scan'208";a="229074310"
Received: from mail-dm3nam02lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2023 16:55:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0dID3rxQZe6uxqd1e0wEwOBiXZST6BVwgoshXJbWLfGHLn9P7yyGwwEw6Y6Ktj03+INq6yU2BUaPN26RaOTPlRJOzBwk8iN3a4bz0AbGqhsxcgOk6JlJLqQfnf6WL/wnESrx1J/eygXpqUqjBFs4781QqNr+onGGVNTtHXF/bGFwcG1WbMCytGmZdm4rxz3zvY+1YY4tY7A3LWl7hfyb46MccgFEdQaapCq2shR+OOqvOhJQyHusSK2U4e5XR/dwN+5sMOvKXnuAB5bFBaz8EPErm35nBMQhGdwkIMOXAQE7PMFPR28C6GstR9Z4bg6JeLynv7q/PdsK0V+VJMOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3JnPEg3dz+AgxRkNAu9QXNzY2W/CMI6JjrbUhHKeFc=;
 b=H9tKFQ2Dp4/zSucRLswMwq1yeQrtFMv1phrUcuCoLjXBOkK6WgGKeD0IgUqHAlOEubjaAKDwQHz0T6boVjqU0hfmBQO78I7vKIYvalRSYow++vTWWx4ptYB7Km0WJ4niTyyJ0LYZ7jKI4SV+BBaBvvGFUldKMzu2Iqrd7ayJuWv4IT426ldjw8pPF/p+u15/Tr6fVG+hoEvtEZbjnsjRuoxeRbJMZlPynvwHNbFf+VewDQMJNdQ8qI025l3+3drcdn4of/3vong8j+vNDYCcXOwpiyTs1/3gL5OCx+KpVB1g0ebQENfjbOpAEo84CDIEZGYOTqkkd0I+E8XJRBWboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3JnPEg3dz+AgxRkNAu9QXNzY2W/CMI6JjrbUhHKeFc=;
 b=IED6wIOE7oM0CGWFGt4JVNQhbJEvHyAUJ+aqpAMR+TU13wCXhUL/w2vNY0JEDH4/eyzXsN3I46Io28e2ICxv0zed5I/ta10eE7cE2UeExkXPGXy68ul0TY2YPr0TtGBInuzjzcqiFmDL1THTCtlZAeEnQma6SnmcjI7RpQNipvE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA0PR04MB8833.namprd04.prod.outlook.com (2603:10b6:208:489::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 08:55:35 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 08:55:35 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 blktests 0/2] blktests: Add ublk testcases
Thread-Topic: [PATCH V2 blktests 0/2] blktests: Add ublk testcases
Thread-Index: AQHZfwGpLqPKOeastE+7gVohCfBp669cqlYA
Date:   Tue, 16 May 2023 08:55:35 +0000
Message-ID: <becol2g7sawl4rsjq2dztsbc7mqypfqko6wzsyoyazqydoasml@rcxarzwidrhk>
References: <20230505032808.356768-1-ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230505032808.356768-1-ZiyangZhang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA0PR04MB8833:EE_
x-ms-office365-filtering-correlation-id: 893c35a4-55ba-4eaa-c102-08db55eb5047
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MN+ay5etD8+mhBYW7X7YWO5ptF8OjXm2ZMRQnBUIx7ZBMR4kHTXtf3MY5JtmolhfPqqlk/OVyIb9vdSNK31pq7iWZSjMpUK3PmVOjkb9p1wcAy9wLA7suxkGxELpQe5FWoDZoF9nhw9L83PXoS5VWIiBYKijGJSoOO3nufENKFZ3iCQqRw++S1BwTsWPQxsE3cb/tKRjzh7Vp8k0hwEV8TZDU7rxdfIqGgj9wMTJLldWz1WDeK2UR49f1DTTrVdfCcJpOFg+9pgu9vhFTI2YK3H1ry3h6Zii1eH2uhaSKkY+ZjuiGzAoonxIOT87D+IsYGLab60t3a2yh79hTnQG5nSMcjWVL8N6QJDMYsRi4IR1pH2+dRubII9UUjd0ESR1wdoBkzB2INMNblGZeTzKkcXFIqWwGT8UBs9V2fYzsCWKTOD5fNKuHG6c5erZFleHIoyn6zqmgOuGT2wlJMKE9I9CRjJJ7t0jLrGbcYCLti/LCvI1nMj43/roRh5lyx3MohXILrcjH/UFN5ncRRZ6BqUv1I/kBB/dNSLPKdpw86EtgwpGmhenJkDV91Sg7Qsw0iGK9lyz/JlGRM5OVLFKr4WjcbFTwJW1paxb44jyhz7giAnVdbZPMxV7+mZgPMJchcjmMYXpPj++AHVQNqk/eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(6486002)(86362001)(91956017)(54906003)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(478600001)(71200400001)(33716001)(8936002)(8676002)(5660300002)(41300700001)(2906002)(44832011)(38070700005)(122000001)(38100700002)(82960400001)(6506007)(186003)(26005)(6512007)(9686003)(83380400001)(27256005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?91mFepyuo/xfVCONC0iijBU8LZtwhYW5yKcylK/lhILXDLOTmKC++gT4+5EF?=
 =?us-ascii?Q?GbUMNtD2Q9OZmJu5VuboY4SY9ecgVggmzEW85bDjnQIjBf1t9dd4Tcov3Ozv?=
 =?us-ascii?Q?7P7cInuDe7WIBkvrBrYRO3ykTM2ykuyF99+FFgEB6HlKJPBFVft5p/EnzQq9?=
 =?us-ascii?Q?cmoLoS3TJ/bus5vXm+4nTlsj/nURPFJag+feWjozH3zXX9OnkyX9MH86AwYH?=
 =?us-ascii?Q?c/yTqzsgvdFVLfpjAMnw856o93sl9HS4Q6lAF7xvdyKakHm+F4muO0buY+uu?=
 =?us-ascii?Q?+R+reHnV9zCuPWkgjOMdoIYrIr5hc21znZ18kKlUeIlV33tom69Cp6DG0jDC?=
 =?us-ascii?Q?MiIwrM0345C+97S1OkWp+rIAjxoCUYIPZ76RjUFOtpi5L+DtLxv3r9Uw8+Zy?=
 =?us-ascii?Q?4G+D+90seSmomQcQ5mEjfJKq3VLNfM1EtEyDpHtctKec/0BVnrggSY3Cti4J?=
 =?us-ascii?Q?lWIGdMV86S+LWYmykOFjZeVlPq6RcbpJJXDI8sOKaUb8TXpXV0j8xVF1r5NJ?=
 =?us-ascii?Q?I7Lh/MatqQrPpht7Q8unVy3iOmL+hlN91yNfzjE4NbjWEWwCsOYD+18ShnW/?=
 =?us-ascii?Q?zM9iZvURrj0+HGgjvLRbLt8IrcJTff46PHA6ZiP8I8YMiO/9raOv5YFKOVyR?=
 =?us-ascii?Q?wni2WFARsAxe+JIpNb4XLMXCWsBkwS9MDDaIplOeqUfHW+MSYl55KGhMSTQ3?=
 =?us-ascii?Q?v2tilvc35ajhzl0affKU/1086rANkFiW7ModYK2prtZBmdpLNboe1RZ3sc4W?=
 =?us-ascii?Q?I1vGaXtEfb8846xRel54h9y/umowLc41buerjUsOaTWaJ9rNdQKVF+mlYkaF?=
 =?us-ascii?Q?Z6WDv8/ye5tKKH2YSRiFrCQH/oEVxjtM4IYbJrI5JtOFrODvO5u4Q+6rW4/P?=
 =?us-ascii?Q?atAAMDOxoHuKbYPJOcn/7XR0EjlDAHo1AtgmgIOsridc6f8WLsXHS8i1EMq7?=
 =?us-ascii?Q?LaWjo7AAf4TmLminq9G7gLrnw0dSbe0/DLpSGMAAHY7WEbgMLH38HMN+AK11?=
 =?us-ascii?Q?G58IOFG4ByHikLCDHXMhIz4uJ2dhbZmZjaRfVq/0itbDntInzoUpbdpQ6ev7?=
 =?us-ascii?Q?CwODph4GgmtsZ7WyvAXYOATQDhouObDNORjx56h5lYTTyC03Y79Y6Lb4RvLf?=
 =?us-ascii?Q?a3cpmYO57KGmXTP5CbCx0X/T2Py92FIp5Fr6ooXXDKesd2iSp9GXPaeTBJZN?=
 =?us-ascii?Q?LHZ8bxrpEjSAMIRVWoWXp/2lpl+UESY78bqlVIX5cQifpihch67HC7n2WjPG?=
 =?us-ascii?Q?qOo1O05dGU0vxWBs+XxYFBPU8ntOZk+V+Vt6Si7aI7H4OwakTBqt3vCS4OhM?=
 =?us-ascii?Q?FbBKu71smpzldbkvhAqqTQldwVaQ2NT808joB4zZs0kYxigagSuOHrEizeR6?=
 =?us-ascii?Q?3rIy6c+Dv8JQx6bnjvqIqbkBfICwGEDHAHZ/Z6EL4Le+yedWvOaZmzhfpH2Q?=
 =?us-ascii?Q?FDDsf07a4PqxnNIRprsAr+GxVmLcwQjwe9BJcidR/DQfEy9sEcY83SLDLc3d?=
 =?us-ascii?Q?vbYigsktiV0E4L4fuaj5dHuxG0JEkAitX9PtfPtEy7uxpv7i1i9uZghsbgFK?=
 =?us-ascii?Q?AlnL1KC4aQ+N2huVvzkTRk8dEwrHbNpCg7QXsiwqYHTJXNJzN+06uMqca3oM?=
 =?us-ascii?Q?rP1JTyjVV17B1RzPSfEZtI0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C58C2E214116B47ADA0334A4CBE28D9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t+ggdTTrYOOtaKlAvo2sjFIq0QwLGurat13PG/rvflOTqo0cS4pj39eOQrWtX1YzQOi9wZWdgALynjWQ4f3x/sFq02cA2IXD74B/zuZ5F/AQB9BpeJfOYa0AHkIqI4cLkpBHh0TrU3rk4vicNSh35TO3QBDxSw3fRovHufAFL4qxVIfuAebplRGoSas38uWvEaiMsjgedssdAjL76Ukw11fUbi1sriLESL46YMvKFLvGTJpHFQJNh/YJIKvHFgOcVoAuGpFk8hUGIezvB0E24S2I3WjoXnGqSNrr5Fpli5LnXifrLxBw7BFbmk7hHWdoe7ThNPJCFxB4owdaGXfDqX8wpxiZBC2Fub87Kes0d+QLOE6/kC8Y+IB4+sgHIV1n4vaKS1bK2+gSINgVFkMo1RL1DajHo6Lo5g81wKXvPKGHfTpWa3n4SGCq9tL+3uR+jCBSiI7DyO3g++kg35tEaBKKAAbJfSI5Ln2K7V3uNW9ZPg41F/CHL16+ffPmptZIEqnfbTBhXlsoUAWVNfKZC3jQuZQvgpd+S/WdgMwjY/ceofsBujjndPbmqiA1dx4THyMFKN1427+4+lT5EREKEkx2RcykuBBtN0Fbg9O0CROh4J6JN1CSsTgS6b+qjGYAwn464nx6ZAxcPLxvxBc4I1+hGm5Od7nqPjIHVk0t1QWnoNXQzguWPa+aJb4xE8W2iSUbBYNG0VVO8L1iA8NC407jHRzdyVCfd6rQ0NwZNtlfaOHJGG/sWaHVZRVqJ9icGElN9wv6YKcYKTppw9UexOnBrrOwIkJn/rzfVPq1akx9hah0J2qVE3bFEovqSm1maPWUNbq0qf2XGs+pUnbdAJYRRe7XNBeVu9aFbyKS8rs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893c35a4-55ba-4eaa-c102-08db55eb5047
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 08:55:35.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J1l8AaDT0Y1Z/bQd2qWLqwjDOOILZR6cqOajFFvbmZnihyZN1seewNK7JHaDJ4mDPlC78iyDM7D5IeHk3J5TMuJ85AyTng22LHyjRI+Szsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8833
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 05, 2023 / 11:28, Ziyang Zhang wrote:
> Hi,
>=20
> ublk can passthrough I/O requests to userspce daemons. It is very importa=
nt
> to test ublk crash handling since the userspace part is not reliable.
> Especially we should test removing device, killing ublk daemons and user
> recovery feature.
>=20
> The first patch add user recovery support in miniublk.
>=20
> The second patch add five new tests for ublk to cover above cases.
>=20
> V2:
> - Check parameters in recovery
> - Add one small delay before deleting device
> - Write informative description

Ziyang, thanks for the v2 patches and sorry for this slow response. Please =
find
my comments in line.

FYI, I also ran the new test cases on kernel v6.4-rc2, and observed failure=
 of
ublk/001. The failure cause is the lockdep WARN [1]. The test case already =
found
an issue, so it proves that the test is valuable :)

[1]

[  204.288195] run blktests ublk/001 at 2023-05-16 17:52:14

[  206.755085] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  206.756063] WARNING: possible circular locking dependency detected
[  206.756595] 6.4.0-rc2 #6 Not tainted
[  206.756924] ------------------------------------------------------
[  206.757436] iou-wrk-1070/1071 is trying to acquire lock:
[  206.757891] ffff88811f1420a8 (&ctx->uring_lock){+.+.}-{3:3}, at: __io_re=
q_complete_post+0x792/0xd50
[  206.758625]=20
               but task is already holding lock:
[  206.759166] ffff88812c3f66c0 (&ub->mutex){+.+.}-{3:3}, at: ublk_stop_dev=
+0x2b/0x400 [ublk_drv]
[  206.759865]=20
               which lock already depends on the new lock.

[  206.760623]=20
               the existing dependency chain (in reverse order) is:
[  206.761282]=20
               -> #1 (&ub->mutex){+.+.}-{3:3}:
[  206.761811]        __mutex_lock+0x185/0x18b0
[  206.762192]        ublk_ch_uring_cmd+0x511/0x1630 [ublk_drv]
[  206.762678]        io_uring_cmd+0x1ec/0x3d0
[  206.763081]        io_issue_sqe+0x461/0xb70
[  206.763477]        io_submit_sqes+0x794/0x1c50
[  206.763857]        __do_sys_io_uring_enter+0x736/0x1ce0
[  206.764368]        do_syscall_64+0x5c/0x90
[  206.764724]        entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  206.765244]=20
               -> #0 (&ctx->uring_lock){+.+.}-{3:3}:
[  206.765813]        __lock_acquire+0x2f25/0x5f00
[  206.766272]        lock_acquire+0x1a9/0x4e0
[  206.766633]        __mutex_lock+0x185/0x18b0
[  206.767042]        __io_req_complete_post+0x792/0xd50
[  206.767500]        io_uring_cmd_done+0x27d/0x300
[  206.767918]        ublk_cancel_dev+0x1c6/0x410 [ublk_drv]
[  206.768416]        ublk_stop_dev+0x2ad/0x400 [ublk_drv]
[  206.768853]        ublk_ctrl_uring_cmd+0x14fd/0x3bf0 [ublk_drv]
[  206.769411]        io_uring_cmd+0x1ec/0x3d0
[  206.769772]        io_issue_sqe+0x461/0xb70
[  206.770175]        io_wq_submit_work+0x2b5/0x710
[  206.770600]        io_worker_handle_work+0x6b8/0x1620
[  206.771066]        io_wq_worker+0x4ef/0xb50
[  206.771461]        ret_from_fork+0x2c/0x50
[  206.771817]=20
               other info that might help us debug this:

[  206.773807]  Possible unsafe locking scenario:

[  206.775596]        CPU0                    CPU1
[  206.776607]        ----                    ----
[  206.777604]   lock(&ub->mutex);
[  206.778496]                                lock(&ctx->uring_lock);
[  206.779601]                                lock(&ub->mutex);
[  206.780656]   lock(&ctx->uring_lock);
[  206.781561]=20
                *** DEADLOCK ***

[  206.783778] 1 lock held by iou-wrk-1070/1071:
[  206.784697]  #0: ffff88812c3f66c0 (&ub->mutex){+.+.}-{3:3}, at: ublk_sto=
p_dev+0x2b/0x400 [ublk_drv]
[  206.786005]=20
               stack backtrace:
[  206.787493] CPU: 1 PID: 1071 Comm: iou-wrk-1070 Not tainted 6.4.0-rc2 #6
[  206.788576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-1.fc38 04/01/2014
[  206.789819] Call Trace:
[  206.790617]  <TASK>
[  206.791395]  dump_stack_lvl+0x57/0x90
[  206.792284]  check_noncircular+0x27b/0x310
[  206.793168]  ? __pfx_mark_lock+0x10/0x10
[  206.794068]  ? __pfx_check_noncircular+0x10/0x10
[  206.795017]  ? lock_acquire+0x1a9/0x4e0
[  206.795871]  ? lockdep_lock+0xca/0x1c0
[  206.796750]  ? __pfx_lockdep_lock+0x10/0x10
[  206.797665]  __lock_acquire+0x2f25/0x5f00
[  206.798569]  ? __pfx___lock_acquire+0x10/0x10
[  206.799492]  ? try_to_wake_up+0x806/0x1a30
[  206.800395]  ? __pfx_lock_release+0x10/0x10
[  206.801306]  lock_acquire+0x1a9/0x4e0
[  206.802143]  ? __io_req_complete_post+0x792/0xd50
[  206.803092]  ? __pfx_lock_acquire+0x10/0x10
[  206.803998]  ? lock_is_held_type+0xce/0x120
[  206.804866]  ? find_held_lock+0x2d/0x110
[  206.805760]  ? __pfx___might_resched+0x10/0x10
[  206.806684]  ? lock_release+0x378/0x650
[  206.807568]  __mutex_lock+0x185/0x18b0
[  206.808440]  ? __io_req_complete_post+0x792/0xd50
[  206.809379]  ? mark_held_locks+0x96/0xe0
[  206.810359]  ? __io_req_complete_post+0x792/0xd50
[  206.811294]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[  206.812208]  ? lockdep_hardirqs_on+0x7d/0x100
[  206.813078]  ? __pfx___mutex_lock+0x10/0x10
[  206.813936]  ? __wake_up_common_lock+0xe8/0x150
[  206.814817]  ? __pfx___wake_up_common_lock+0x10/0x10
[  206.815736]  ? percpu_counter_add_batch+0x9f/0x160
[  206.816643]  ? __io_req_complete_post+0x792/0xd50
[  206.817541]  __io_req_complete_post+0x792/0xd50
[  206.818429]  ? mark_held_locks+0x96/0xe0
[  206.819276]  io_uring_cmd_done+0x27d/0x300
[  206.820129]  ? kasan_quarantine_put+0xd6/0x1e0
[  206.821015]  ? __pfx_io_uring_cmd_done+0x10/0x10
[  206.821915]  ? per_cpu_remove_cache+0x80/0x80
[  206.822794]  ? slab_free_freelist_hook+0x9e/0x1c0
[  206.823697]  ublk_cancel_dev+0x1c6/0x410 [ublk_drv]
[  206.824665]  ? kobject_put+0x190/0x4a0
[  206.825503]  ublk_stop_dev+0x2ad/0x400 [ublk_drv]
[  206.826410]  ublk_ctrl_uring_cmd+0x14fd/0x3bf0 [ublk_drv]
[  206.827377]  ? __pfx_ublk_ctrl_uring_cmd+0x10/0x10 [ublk_drv]
[  206.828376]  ? selinux_uring_cmd+0x1cc/0x260
[  206.829268]  ? __pfx_selinux_uring_cmd+0x10/0x10
[  206.830169]  ? lock_acquire+0x1a9/0x4e0
[  206.831007]  io_uring_cmd+0x1ec/0x3d0
[  206.831833]  io_issue_sqe+0x461/0xb70
[  206.832651]  io_wq_submit_work+0x2b5/0x710
[  206.833488]  io_worker_handle_work+0x6b8/0x1620
[  206.834345]  io_wq_worker+0x4ef/0xb50
[  206.835143]  ? __pfx_io_wq_worker+0x10/0x10
[  206.835979]  ? lock_release+0x378/0x650
[  206.836784]  ? ret_from_fork+0x12/0x50
[  206.837586]  ? __pfx_lock_release+0x10/0x10
[  206.838419]  ? do_raw_spin_lock+0x12e/0x270
[  206.839250]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  206.840111]  ? __pfx_io_wq_worker+0x10/0x10
[  206.840947]  ret_from_fork+0x2c/0x50
[  206.841738]  </TASK>=
