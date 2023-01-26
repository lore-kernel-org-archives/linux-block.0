Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98386C54E94
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 14:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjAZOfn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 09:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjAZOfk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 09:35:40 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09826222D4
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 06:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674743737; x=1706279737;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/djV3seSUD0NlSj+jVeLKEPukNe9jKZh2DQKPkMyzaA=;
  b=cbkIjHBrTX8bouWgaMjdxoc6WVMLdGMDnRwUS2tP+8wN+aui5ovSoQ1T
   bYELIPZnKpllO2ronZZ0PZBRkj1bCETV8VEh7Yk3r2NLjrUlAnLpK7Rzf
   V0DXYujD0kEIy0XLzWD4LCLoiMMJaqJ3jnqAdd+fT0jPSwTP3HsVH0w2w
   Cqs/kDCKZIqBo+u28b2EpNA5uTH1ZoNuSyClhiBMW66Se0Y7X2UfvGgWH
   ahC21YUkYc5U9Dmh3+CPwuvpeNje2qRsvbEj+2vjepjQUj2s3y2eQ+jXm
   ehgbEwYUXEGdAdGRN66AKDw0/ruq5m8koDVfCMyM7b5jZKRS6RA4pN9oO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="314739709"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="314739709"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 06:13:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="726280755"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="726280755"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2023 06:13:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 06:13:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 06:13:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 06:13:37 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 06:13:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC7di1xua3FBQyB1HUmRRHHTbbA5kPqkSJeJ55TolDAmUUIV8tGB1SSsKK4ZyGYFFsNsNEySIHvy2F4iStDM7tzbc6ssz5Qz/tZ6Yy+iMHB5XYfI1I39M/3oD2lZEamCnVRY7jbLW56MxovgAqE2ca3/6UOJtgDZOHhvMmkQpoYHlQ/A3xZq+fDVJVCkICNDEinq7tWQbJug4IDDv0jt2OUflIUKxtNUNsGD93pnGqHSvSvvp8qVjW2f49nQeIcrF8u/R9S7Dqo9VN+PxIDz8kPC6R0ZuAuoVhwiNKYMLLjwAltzqgevaw02O6wMhigyaPTEqECJ3MdiLH5slB57hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G2AhwXOl+aqYo6QmJc3C4WG/OSES07tU0+dmWxK3B8=;
 b=DZGelmxFeGE1HrquvgTGcpmVRcgFlC+STg4k5dzqbjMp9c0b4XTkW3EhQtFUkiLpOChLuV+PZHBgAI6i86pPdVR8gGWHGaEc5Q2LIexO/Tm4kPP5kTn+3Rp40aI5lC3gsQ3VWNIMTypvFPYJ4x0b/RGU6teAQgHd/W8r+HI+9JywaFf+SXhMadU4vu458H02vlNLrAgGrpv8JyqxruDZTiJKavkGOTImz8tlpsGHn6vA7QtWvUrhnzMItJZtTqNkLJGzI0PaVxm/zZx04ttLnuFWBD4RwBkLzZbtJb1hUyEgzV0LMF+/WkIStlHDFJwcB0Uo5FhlXq4LKbaExMdkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3299.namprd11.prod.outlook.com (2603:10b6:208:6f::10)
 by IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 14:13:34 +0000
Received: from BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::7072:21f9:7c87:db72]) by BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::7072:21f9:7c87:db72%7]) with mapi id 15.20.6043.021; Thu, 26 Jan 2023
 14:13:34 +0000
From:   "Harris, James R" <james.r.harris@intel.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: ublk: move ublk_chr_class destroying after devices
 are removed
Thread-Topic: [PATCH] block: ublk: move ublk_chr_class destroying after
 devices are removed
Thread-Index: AQHZMXzjqUPGgu0udUe0s69A5ZiXCK6wvcWA
Date:   Thu, 26 Jan 2023 14:13:34 +0000
Message-ID: <E5FB4A9B-B22D-401F-B4F5-C15D5F4934D6@intel.com>
References: <20230126115346.263344-1-ming.lei@redhat.com>
In-Reply-To: <20230126115346.263344-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3299:EE_|IA1PR11MB7773:EE_
x-ms-office365-filtering-correlation-id: 15ce750f-7a1a-46bb-f973-08daffa782af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IBdXpmPtenOtON0mCiIfnsFFypcS5r9x7XNyRT/3KCtxrVdsBvE85325A/g8rVXCfmLBTVxB+4BeHTdfe78CsNtpI05Iq4K6DMKRK7V2ir9y5joKhsVIArzZ62ddCie4cj1YTalNn0yjNbxLq+GFHAPIu93e7TH7YYlj71ExTbnAE5tRfjpDQ/YNQ2BVpHSHgWE7/JocGUn+hPAnQaS/zT4qIshcPDOkftkKU3/iz8e6iWC25BLPbO2Rb0QhaVCxx9O+JydPJavJXNGHm2X9si+IIgKC673kbM9JwG/Pii05OspPNsqLYbhlNLPhzLeS4Ypl+27yKinlbadhkniPXBL3PtQEFW7MTDgt6gvhBwhB/UzTp4GryEeN20yZuF+0rfNuVRNyejE2AL4Hk2pfe5/RIPCz3E8ImjzFwST1xDKlIqQl42eqzJEH7c6PqpTfahNc3/EBHMPz47YQ8fcbIL+4x5Rrw5dz2utotHQtN8tT+y3W9ztTtv35XyF8dEECbYGDCAIOd+8hN954esfh4G/7VXCpOiqHXBlUiEqmJgCWYNS6SuUUH6rT8EEtJtAsEtlhZp/oFgCPwN3PDWAZIcYV6jOft8Fel3+uWI/Hr8VJExTF2YZ8bwpaQ/rSEmIQmj1MQPsveeDWVxD2YyGz8P2vKnBzgd4w0vtl3Cnr2GNBrkSLlPPH/F0zJ53+o6b7pPvv27Rk+zfTB9cpe5RxdWn2Ni0//cuRgwX6MciILwFZfsfhQdQcUeFWFbsWHOms6aY0GWn4FyrGsNbx0KCGGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199018)(71200400001)(8676002)(33656002)(36756003)(86362001)(38100700002)(122000001)(38070700005)(2616005)(6512007)(83380400001)(26005)(186003)(54906003)(478600001)(82960400001)(5660300002)(316002)(6486002)(53546011)(6506007)(6916009)(64756008)(66556008)(41300700001)(966005)(66946007)(8936002)(66446008)(4326008)(2906002)(66476007)(91956017)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mGwCPy0p9cOiLI4Likw73iVZUJqzwLn4+JcTEztSP9qiYQok5KIrM/tvF8wI?=
 =?us-ascii?Q?TZChUPumumO/P4oBoxoHEe2oL7nmrDhD9yWgCAmZzAtkqlayxJMb2Z2OESl7?=
 =?us-ascii?Q?5gHsXujNLNcloKSsWpCV8pNspeLdCUhFXtE+hJ4tJ7oPkhS6L2VKgdwuUkt/?=
 =?us-ascii?Q?xR7Vj6sfOBqqzDdWANut3ZXSuF3vlfIYY+WRZ4v9PNHo0WQUKFbJbPjoQfuq?=
 =?us-ascii?Q?29aafR64Tp21wC2rIfaTeJqZNyGtk3uHhA/NuWQ7MjxhfUAizS9eGrED3ciG?=
 =?us-ascii?Q?d2DBE5WfZrf8aQHLy5xjsyhwpFyEVHr58Ly7oj5NkmezPQBAGB7l2tjgHLCQ?=
 =?us-ascii?Q?R4VZ/eJqQ5XnRjmeY4tcf6SQ7cqzt1N1hLnA38dWBYoR7uosyknemV5zPr3p?=
 =?us-ascii?Q?Q/U0VsNZzWlWGL9b11m8uzsuvNXjGN05xVR/b4ValqZrANeOOCBc8Z5osW3C?=
 =?us-ascii?Q?HLQnx0hBCLmyN3Z0Txtt9127GBMISNYi1o7SeepePtBKONbst8vt4ET5z/Qp?=
 =?us-ascii?Q?Me4TDktOY8IL6xgelQW0ecKJfBNTSGlTo/A4TElpMTCWPCkauOpveFtEC4v4?=
 =?us-ascii?Q?TSD3l7QcMeBg0F3/qYAHfjZc75FUEjxXJNc3b3kqndOgsOEG7Gu/hx51F3jv?=
 =?us-ascii?Q?Nf7L5bUL76x+Pe9KzfiTeJLADkCzh6a0dI3AuWtAxCo1DOPNX65JV+Crw08i?=
 =?us-ascii?Q?0PUIYtTLnVRd40S301K3hE2GkGEWm0ap1Lx7CYji9WwB7JDP0tV9KIWImbIn?=
 =?us-ascii?Q?FZvGBYCqORprXjIGp89gsB2RNQSiEEH0aq3ETgZLNv+rFeZnZJjnDuybdYp+?=
 =?us-ascii?Q?bp1aD/KShNPgQO6623oWf0/Fx78ImQjMfKpDq1wCP5bafvYWerb3XWDAVekk?=
 =?us-ascii?Q?YUrHUIBrAomuzXZDYzjhd8EIYG46bgTyti83n4PGRr3v0m9sRHpc0/IO6E3B?=
 =?us-ascii?Q?Ncvj+7iN890Gv+afUBbezLFJZM1naPeTCOwboL+FQm3W6FTG3klVH+KvMn2K?=
 =?us-ascii?Q?RlcLdW02R5tHPgw+pEP0SPlfnwtz/zlYo2yTF9Ipt7qviY31Q4RvJP2Gukr/?=
 =?us-ascii?Q?ENeyQ4b7NruVFDTVvsRE4asWvj+N/fed2lF73M8MKF+Tjc464/xwNU8IzsYn?=
 =?us-ascii?Q?FG63TPW7S6P+xNUzsd6XNOzhaS4jMWWR3btesyRvNhCetUK1gPg8LqsT5+6T?=
 =?us-ascii?Q?jjTKQzoiqKgiaXvAV0eywRoGR2tjAzEzJ4tVq6r5VYUgBdZBmo5z65BbLHrp?=
 =?us-ascii?Q?CJA95eQCZlhcolAmu2gLAX/NuCtbFEg5FHKSfhV0zO0gaqYsSm7+tFuMVLXQ?=
 =?us-ascii?Q?OOb05oJvW08mLBYl2jsdXG4OPDAxerVOboFEZXbbxqSWOcsniyurY/Z5TtPV?=
 =?us-ascii?Q?8ElOtiTEAXH/VvKeaa7ma241jxpW28OsGkIo7cfrBJTbofaeV4jSs+SA9QvU?=
 =?us-ascii?Q?wy3bHKbUkmoLJ4RK25YtpWJ4KiI4NG13XHOAVTVenpFHzMO3ObeHy3KPbMHz?=
 =?us-ascii?Q?rfwW8i0yWhULZMRIJwyD3DCzFfEI4gU+puiHH66cwyolshlfixKVeCGYXwJ4?=
 =?us-ascii?Q?iBQt8Uni84bjnLoHPN2AoUbd+Klj+wVlfsSVVxL4Vm1S9j0TYLCFVcN9MTLa?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D10F3B8101A8545BA8A4AC77811BA34@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ce750f-7a1a-46bb-f973-08daffa782af
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 14:13:34.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S0Mpg8ioYOr2h8Xsbfs6K5rjukmbOlrtRMQPV/z6jy2S8yCIUbwR5DTktVjpPGDhZ5959r0ZE6zFYdQZO1Rjn9S8FYnIjxGqWOHZbR7rGrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7773
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Jan 26, 2023, at 4:53 AM, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> The 'ublk_chr_class' is needed when deleting ublk char devices in
> ublk_exit(), so move it after devices(idle) are removed.
>=20
> Fixes the following warning reported by Harris, James R:
>=20
> [  859.178950] sysfs group 'power' not found for kobject 'ublkc0'
> [  859.178962] WARNING: CPU: 3 PID: 1109 at fs/sysfs/group.c:278 sysfs_re=
move_group+0x9c/0xb0
>=20
> Reported-by: "Harris, James R" <james.r.harris@intel.com>
> Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver=
")
> Link: https://lore.kernel.org/linux-block/Y9JlFmSgDl3+zy3N@T590/T/#t
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> drivers/block/ublk_drv.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 9f32553cb938..a725a236a38f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2238,13 +2238,12 @@ static void __exit ublk_exit(void)
> 	struct ublk_device *ub;
> 	int id;
>=20
> -	class_destroy(ublk_chr_class);
> -
> -	misc_deregister(&ublk_misc);
> -
> 	idr_for_each_entry(&ublk_index_idr, ub, id)
> 		ublk_remove(ub);
>=20
> +	class_destroy(ublk_chr_class);
> +	misc_deregister(&ublk_misc);
> +
> 	idr_destroy(&ublk_index_idr);
> 	unregister_chrdev_region(ublk_chr_devt, UBLK_MINORS);
> }
> --=20
> 2.31.1
>=20

This works for me.  Thanks Ming!

Tested-by: Jim Harris <james.r.harris@intel.com>

