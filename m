Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59170C3A59D
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 00:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJXAuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Oct 2022 20:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJXAuJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Oct 2022 20:50:09 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70EF4CA20
        for <linux-block@vger.kernel.org>; Sun, 23 Oct 2022 17:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666572605; x=1698108605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HRy/6WTi13YR3o2h8093pF7YfSmKXYSDz9INnHnf+Ts=;
  b=pzyfqTbecXFP0D3xawBF21zAaCRUBZmRm/mH7HdqkxxP+N4O4VWfm9lc
   0oZzJh3361EpMfJYVz92ng3DtzwLbWSLTnOz+cJDjWkEmSCn/2FzoUuXh
   gWS7SCK3MtC5hgU4/QPdpuc/asqrvLvQzP9uk3r5DULGRvAowYDcYn4kq
   w2LCfFuR49JZihYYzirJPBh4Y/6uE4jVJ+X4fAxg7gn2STXXNOZ7DBM0Y
   NMr7cLiCfQ6vVUrgjlf/xjiaKdJ8N+4sPyn3zOxSce8a9q90ddwqmxaYy
   2cq28hiNfCOg9xGj0LSlnsaPn0fA7RAj0Juu2acCx7BbOJ5ePWlXBswes
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,207,1661788800"; 
   d="scan'208";a="318879139"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2022 08:50:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLTnEHOeJfgp1/RoPZeiqEAEOKgi8QY4t/hoxCeeIInBfoc6dwOBB4ah9utZTDrt7q9s7tf/8swxyYT32uDqzC3G9ZBjtuT4BEvLmjiEY+lbiSUa0Gl+OxSV+mcbq4PeTYHcC7vLgKctjFxvwuV5mmF9DU5tXVfIG5aou1Nim4gi/2LGoTER4WMgcGVRKmVFpoAS6Lx0lr9bcJqXoHcVfuCNMkneLTMbXQ7uJP0Fc+vidTOJ9Ec4hVzrItAmD10wNW2I7oO5oqNJgKcBUH7UNzYaU5dYZ2Xb1thbxS7qEOkadXQOUhm23UW5XfRoWBjIp9JP/VbPxKwE+KkbS4am3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nc3cbRgWVV9F5ysHs3Dfd9SQZyuyZPAaukw8Ec+RC+o=;
 b=DOUPWnU31DWKAS13iSPMGYer/yrJdtl1JuTvTDy7dT7uhG5POgyu93Wlq3MN2Aa8KVNSGpPAG3l099B1IxwhFcMGREsGZxy3GqLjPV+96ubrYsfxdwE+ujNWS2Bdj+xMBhrWyR3Ytz95g14oEizM08PH+ErkiyTGbD9kBosnSdd5PNF9GY2+SrXfwdTj1ofF/Qp90hUZvtUR/JPGUCoIwkFWOwXI8HPqVhUgwfKYrJNznSq7UszweiuihrBXUv/Cu+hol5QcTmefsGTpG+dIXQku4jTPPo9ISNOSBFPUjpZgJjpYGNUSA1DfM6kBZvP/7f//Vt/R7ykD22kmr06DVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nc3cbRgWVV9F5ysHs3Dfd9SQZyuyZPAaukw8Ec+RC+o=;
 b=fQ3FiDMU+d4hR6qdjLGVHJF6Ur4qx3DGXa0C+K9Y63mVObzDDdNTA+7MnSK54xhC3z4ZrSEx8rPlgcUPRGEu76MqJuOU/7T4IREi6/P3UvK18SMA4jlJI5yP4PKBrpveVuDQZd0FkBk5Y3Z5VWhTM+TI6lWlf/JtiulO4XTAbD0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5527.namprd04.prod.outlook.com (2603:10b6:a03:e3::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.21; Mon, 24 Oct 2022 00:50:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 00:50:00 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Topic: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Index: AQHY43l6J1B4S//4t0qObxFCSR9tRq4VPZSAgACG/YCAAFOEAIACd3OAgADVjYCAACWRAIAClmaAgACdFwA=
Date:   Mon, 24 Oct 2022 00:50:00 +0000
Message-ID: <20221024005000.givqygw4jyjzjp7q@shindev>
References: <20221019051244.810755-1-yi.zhang@redhat.com>
 <122cec5e-5374-e98f-a8e7-b063d9c413fc@nvidia.com>
 <306b38d1-3098-91e0-9ddc-f4a8660fa386@sandeen.net>
 <d3688d8d-bcf7-9cbf-7c99-74cb1a05a9dc@nvidia.com>
 <20221021085809.zkzw23ewnv6ul3b4@shindev>
 <0f2957e1-2b05-73ec-85b1-91cb643ccb54@nvidia.com>
 <20221021235656.fxl7k4x3zjbbaiul@shindev>
 <CAHj4cs-Vx0+QBF5cSNh4iHEhPao8iJ2gtfE_W7XHKwUh6eFNPg@mail.gmail.com>
In-Reply-To: <CAHj4cs-Vx0+QBF5cSNh4iHEhPao8iJ2gtfE_W7XHKwUh6eFNPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BYAPR04MB5527:EE_
x-ms-office365-filtering-correlation-id: 9cb33fe3-350d-4a40-3666-08dab559ae4e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cudHhETtKGs/zGHONdMnqclAgyOlFrHfnlYS9XDmK5JTLD30H5qBw2mkMDlwtBqGfIU4eGLHM3cxzJxPRafC16Xfa4kCOLNFt2fR/6eK+tQnEHtZ9G4dyf3IpTzsd166yeBTkNPWe+3QAjHRJbrW1Jjg0o+0SBRtF9FpX2jBEjx6TPFvqnLpS/FE9pmS65vNAT9hnqyM8ZkrFkWNp+4aJGHVdATr9eq7AcByiPLXkXmSSLfgaIm0kR6ouzC1GBz8C5mbVwo92cwILYTgykXRmnHIyeOYzpcRQObrpgWrmJ8Xqx5T1dzQ0rgzVaKiTVmbXtQMd4W17SlkwtaGNd8Irm6AzlI/LespUQPNRHDGdh5qUy5G4QCOkRuZiHUdXeFV3thZurGxP9/aO/BP24+hVcSCbxOGUNHWPCNzUOtSYSHQT+i1Bc56fwmgSPYEEGcwgztx2g1NWhAQL7cTuSHKTcnScjfp0Zc6MDP9UCEU/+yl1/lKgbnsLcoAxPFPKWvOvXaqM0F1OIabUDlv1Xb88TzOtFYFZOTCusB/xdpf1i1F/BKpzh3FLnEkkqgjC1FRsimMd3z4uWgRNW7siUYENUyB7HYWO0pmXROGymffyDFl6ZpztOMYD+MxTEtobU2In9ZgFAvwzaTHL1ffSnHIrh4WEvXzy1ntL5s6ENxvrhf7VXQDTgrrGoyylYdtVzGWCilm1gr9mg0dgbFJp2kUe77QXBNlWpDp5cN/c9OI5OIuQzuySoaIufcMa4a3jjhV6GS6kQVTdLHlMTMi2cKUAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(136003)(366004)(376002)(39850400004)(346002)(451199015)(122000001)(8936002)(5660300002)(66899015)(9686003)(44832011)(83380400001)(2906002)(38100700002)(41300700001)(6916009)(54906003)(53546011)(82960400001)(6506007)(66556008)(86362001)(64756008)(91956017)(478600001)(66946007)(66446008)(1076003)(186003)(4326008)(8676002)(76116006)(66476007)(71200400001)(316002)(6512007)(6486002)(26005)(33716001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GKD7CZGUcC0Um21LUJWWL0eI0r4Tz/n9bKwazpSjl24MbGO8ss3pFFqlQTcJ?=
 =?us-ascii?Q?AylUv4sIEFnZlTK3n6mRD61aKTYjzwRvLTeaU3iU6IlPKnqbgO65k64nfd+C?=
 =?us-ascii?Q?FBRArWvjFhla5ILcHRxaxhT5Mq3titT+wsLoASVAG9hz58YQoqc5raWZZqjV?=
 =?us-ascii?Q?ClLxUet5nTIqlQDQSZXdVZ4tXqKQ20azZaU8wtTYU9WvxXnDEMJmAJl/okOz?=
 =?us-ascii?Q?8aEN+LKsSGvt0jE0mJ36tzB0jmy0T27bHaQB+r1gkXFBg3kBBP1hxnOvKuRI?=
 =?us-ascii?Q?sdlSPnxD5FR2/aE4+89hl1znyMNGxsXef0wjOflCFC4iYTjbP0yNA089Jq8m?=
 =?us-ascii?Q?KGIcp87h+JfYqjZKPVhg/uf8q+uybwLQcjujDMkJoKf/TpmLzVv8fHQbfsio?=
 =?us-ascii?Q?8zsv6d/UbSeJgVuiL1GX7jQu7cljskfjq/8GaN3bG/v1BShPw9KuejA1lnjS?=
 =?us-ascii?Q?DP95C2VGWnTbgz1rOMkfIhBtB6MMLi6SD88Fy3N5y1Z7i2u/59+mAdlstjCn?=
 =?us-ascii?Q?pSkL5+nO+aqlCfWZF/cidXJCVICXQPEBEMuTDda6Vf0qwURd6lyubAC1nBqh?=
 =?us-ascii?Q?VDLhNo01tshFXpsS1u6GVOjTi4eiOb8NMgl9PG5DSqv61923jl9h2VJVTJC/?=
 =?us-ascii?Q?1yya5mERFKp2kcXeVkMpEsFOa0gtnb4sI45DF91kcN4KaoioOiQVQEcB5/Ep?=
 =?us-ascii?Q?wWouPBXWZUuGCj45/lzWADvJvJydaTbguVu04AsZ4YxpeU+zTzWQTuh3Abms?=
 =?us-ascii?Q?6RrymGzCb5e9xY22A7ObyXykDlTiZekdu2FVCDxRHUi+EaXyzIN7rsPonMYC?=
 =?us-ascii?Q?eSJmp6fnOIS9rkLX2MwOOQJRu3Z2UxUQ9MkREa6UzP97eFliAd0GD+lfSysp?=
 =?us-ascii?Q?wp/XfZv/QhdvXjsQG+QXVPiw40dbGLAiPPpdLPqRaK+gydEe23nMbhHtNB4p?=
 =?us-ascii?Q?JD8E5WBIbBUefo35NB0kgUYSznTtGm8chY0oYX8aFS/8fASrlrdk4APmcfkI?=
 =?us-ascii?Q?QpGzFm5WwCh4diBUxY+zTImqeWKj4oLWM3HPeAbM25D4RP/lh5gmMEd4ntI8?=
 =?us-ascii?Q?+gahO5q6FtXdt6pNmU5XD+9bmjbUQzzLsU1z4c8b+Zv4+HOTK53xwZqpP4qZ?=
 =?us-ascii?Q?Zn5IgzwyLnCUEQELtwgt/5v5MG+ki7CydlXkoT98kmV2SuG6PQbfrBfzRsBH?=
 =?us-ascii?Q?HeDwMNJJVBdr68YXqWCIknWsMujwHoZey8NGHfLqaXXRQTWODLUjfBtIynij?=
 =?us-ascii?Q?D9A7kV/b9xfHhuwXc1puZXjL04vxL2IWAJB3Yg8Ti/jrauWRG11xKgG8yKt/?=
 =?us-ascii?Q?URLVgKxvcho9H5OraVbluYlT5xSyTnIm1NGhKV6nCUpBNbPlTvF0gtuiEZ56?=
 =?us-ascii?Q?SvJ/BchSa9VwaGL7o4x8sThj1Am2ZkSQ7FPAptmtV/mmXzm1JQN1E3BmLUCp?=
 =?us-ascii?Q?s0afyXwUjo5dfMT/4s8UL+OmJBDGTP+hlE/tgrnY3evo9gG3uMCIgsY+yXgK?=
 =?us-ascii?Q?Siml3f9PgBbRpSHGQF70JqVSXbMMnQrov7aDRO6EQk41NH2DbuS6rxcDkmaW?=
 =?us-ascii?Q?7EBAExAzLvDgA6CRbnpMrPA6U32W5zTV/VCZqNUpmVLwqexQmxwpOL1gDtnh?=
 =?us-ascii?Q?VppRVmiN1ot2TS9mqHTB+jY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B254EA87973E79478C7AA87029F4C876@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb33fe3-350d-4a40-3666-08dab559ae4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 00:50:00.7267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0jdkqdAy7RfoxncTHB/MFOphLTYWUTcNu7k4/AhJ8+oyR9x6iW2j5NMDckogdio9GCutlSWz4z4D5ydq+CDeiVha899sHYMZHgLvrxQCec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5527
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 23, 2022 / 23:27, Yi Zhang wrote:
> On Sat, Oct 22, 2022 at 7:57 AM Shinichiro Kawasaki
> <shinichiro.kawasaki@wdc.com> wrote:
> >
> > On Oct 21, 2022 / 21:42, Chaitanya Kulkarni wrote:
> >
> > ...
> >
> > > I think creating a minimal setup is a part of the testcase and we sho=
uld
> > > not change it, unless there is a explicit reason for doing so.
> >
> > I see, I find no reason to change the "minimal log size policy". Let's =
go with
> > 64MB log size to keep it.
> >
> > Yi, would you mind reposting v2 with size=3D64m?
> Sure, and before I post it, I want to ask for suggestions about some
> other code changes:
>=20
> After set log size with 64M, I found nvme/012 nvme/013 will be
> failed[1], and there was not enough space for fio with size=3D950m
> testing.
> Either [2] or [3] works, which one do you prefer, or do you have some
> other suggestion for it? Thanks.

Thank you for testing. I guess fio I/O size=3D950m was chosen subtracting s=
ome
super block and log size from 1GB NVME device size. Now we increase the log
size, then the I/O size 950m is larger than the usable xfs size, probably.

Chaitania, what' your thought about the fix approach? To keep the "minimal =
log
size policy", I guess the approach [3] to reduce fio I/O size to 900m is mo=
re
appropriate, but would like to hear your insight.


From Yi's observation, I found a couple of improvement opportunities which =
are
beyond scope of this fix. Here I note them as memorandum (patches are welco=
me :)

1) Assuming nvme device size 1GB define in nvme/012 and nvme/013 has relati=
on to
   the fio I/O size 950m defined in common/xfs, these values should be defi=
ned
   at single place. Probably we should define both in nvme/012 and nvme/013=
.

2) The fio I/O size 950m is defined in _xfs_run_fio_verify_io() which is ca=
lled
   from nvme/035. Then, it is implicitly assumed that TEST_DEV for nvme/035=
 has
   size 1GB (or larger). I found that nvme/035 fails with 512MB nvme device=
.
   We should fix this by calculating fio I/O size from TEST_DEV size. (Or
   require 1GB nvme device size for the test case.)

--=20
Shin'ichiro Kawasaki=
