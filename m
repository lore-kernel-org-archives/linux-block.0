Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23661C433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 12:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJDMYD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 08:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJDMYB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 08:24:01 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09645071A
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664886240; x=1696422240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RhNW7epFBNPojI71nR91yuX4IZTYeDYGnlMB0GqQB2A=;
  b=k5gz5rh5wkhDrSXBhDuUYYUOCCXLoz+ma3CTvKFzhlO7ejUDsNAGy6yk
   JF/l2HjKLH3GQNqh5+YhrVQsjdXvLhZd2tgR2cNy4dOc06iQHKDS0UdCp
   7+3WAUlFM5vmkPK3UPCp3DfVDIUcIHhKuFHigO4R67qPgC7pzjir3hxhE
   CtD/3xvifztD1QoL9BnZ1BpflLVOsWmf4vLK+0SHuZU6RrOr5A30fFL64
   HBofc4+V3gbcAkoaJFuAviqGe25ta4X712YMW8bd/KqVhRK1bjr61/gki
   SXrJWcJEKKwel7XPXODgvqu1GvcDj6QXmkgl1BBquZ8MTnpOHWn2qHbZT
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,157,1654531200"; 
   d="scan'208";a="317234679"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2022 20:23:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMJE1Nti5zETnU6KWZmt/6AMnP0csLjd9Kg6my61LD0a74GcbbVoGDjE+Z1aTu8dl8SVPK9OP4QvD5i3svWMHXKlafl3evp4gk9PecMZ4a2WFaDkPZk7qmJ4Fw91RYfnxzc240N5+CeMMeZkYowINu2bpcUJJb5h+FhK+e8aSFcd7t7nBI7T6K+5hKh8ed3ZnC4b8Yy6J1yVHHxXD6noSJ0Yv3mrP77gYKWVDg85+whse6TNsEjTt83joKzfz9apFOm5l+PUsS8C39ZhnF5e4Ht5LsGfmE56PWsNjmo7l7JwReDG0unMUiHq4XnYS2CYBMg5TS+I7zkiJWUlChu/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLjVwmcDtqjRrZErUA/bbrAOQ5AIEWoElDsodxvJtMk=;
 b=iI3CXO6ftUDJPBcNG1YtUKfJ1MQdXnYEEuH/40M23aGsNKoDIbiiPxfNR/rPHbeg2geI8Qu+LTIar7fdUPG6E6qo4d3vjU4xBx6Ezi1zrVaYn7nau9iRDXEoLf0O2SeR/5svirJK0eP0xCwTO1NDvzqh38htpBGBQVtDQpzZNpj9Z3CbnTMC6ylONgVBZ6IZ8nMv6salqy60kGIrYLfZ5qG35+ZjHH0ISxNO9fxe4xtR/J08BpXg7AkwUcryQzyuCaEP0qJndiccXspIsskljDqug1ubl5f0gopuzCtpKZlLGeoQ3Exv0eq/ZTLDDtFRwBWB63W6YRNQPFkuE6SEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLjVwmcDtqjRrZErUA/bbrAOQ5AIEWoElDsodxvJtMk=;
 b=cKOnKuCkmxTHgR8dGyw/66eMwDENGGJrEBtwrhd3pYeo0kgvuaZeB7rDcYORDopczNzjzHeM9U9XE5J7CDMfHc4is+2GTXVPq5pvf5Caw1keYNg3X2KU7W7tLNLazabQOZKrLXtCFJtTiK5BDlFlwDGyjtNy1t3BgHnAxHexftY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB7008.namprd04.prod.outlook.com (2603:10b6:208:1ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 12:23:56 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::950f:778d:1de1:53f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::950f:778d:1de1:53f%5]) with mapi id 15.20.5676.023; Tue, 4 Oct 2022
 12:23:56 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: lockdep WARNING at blktests block/011
Thread-Topic: lockdep WARNING at blktests block/011
Thread-Index: AQHY1GJXrtuQitm3Pk+3ExLt/WFGaa330IUAgATf7QCAACBlAIABQxMAgAAHQICAABRnAA==
Date:   Tue, 4 Oct 2022 12:23:55 +0000
Message-ID: <20221004122354.xxqpughpvnisz5qs@shindev>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <20221004104456.ik42oxynyujsu5vb@shindev>
 <63e14e00-e877-cb5a-a69a-ff44bed8b5a5@I-love.SAKURA.ne.jp>
In-Reply-To: <63e14e00-e877-cb5a-a69a-ff44bed8b5a5@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB7008:EE_
x-ms-office365-filtering-correlation-id: 56f9750a-1060-43ca-f75e-08daa6034e96
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nlMXGomELoW+nQQaVYsx5b9LD3hk0+DTrKLrPDZmuEZIOSK3+XoXe2xNxuX6ucIKfoNCEH5ghqIrFS3tcr/MwIFtbypQtOgdOMnJ9q119LyhYrOz806HCMkIQLbnagOs+lBzhRFqWY0dZ2HPzogAuHuINFXKV7jVmMCt4EZLeqvjZvGUd23e9kp4sTc8owoId59XZIgI+yTVqoVJWo6K8vbpcSjZLnXs/mwNnXvG+zms8QHB5tV5Nu0LKOOlDxmRo6TnH6W1cLsBMD/3JgqBhfMIj6s5tmcT01ZNaLYxvE6MhE+he4V8KWowkFhqkyRIa+xlqwbZGGcUzDrZBw1fwR84XM6GXblW9IIHFz4R8zW1bJZ6rUlykyupYtgVPqxdYwUMdY+i1mwZ1uL3p4LptoasZNvSXwmD20B6rbJlNyVBrlLFRVf6dC8WNY6k0thuHhuBq6D96O4jt1wjy9+PLByXGrkfGLeKliDGCkACCXWkYKZj+HUke6xaz4RS6gbOZbnnEG1azz/O35Lp8+q/0u4vxd6YRIMDG4gWmjb7Oe2z1q2YIId1e0mlKNSKJOtnoNyh5mZo8huoOOi/O2MLPUBEXUyI5AioMgCsz6C9E5OrOjy5QP5fcry9uFp5m90qDlYdQWIdc5A04iw6A7rW4hb8TCzzabSAlw7jhvLPVnfIA95F8nwR4gcg3RFr7siuY8LrkK+Q8UsiCQh1wSCX3nj/jQZiGpSHuv8XurB4hyUdks3jz6pOsSpOeAwToCA3geiWKo/uxntYryno/FIEjdQ+1RCWuQeZ8wIYuVzwhRQhj2thia6pSPVm8CSLbOXZq5H8bi9loHqz2f8qzqh2oA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(54906003)(478600001)(6486002)(6916009)(966005)(316002)(71200400001)(26005)(8936002)(53546011)(66556008)(6506007)(41300700001)(66946007)(76116006)(91956017)(4326008)(6512007)(9686003)(5660300002)(44832011)(66446008)(2906002)(8676002)(66476007)(186003)(64756008)(83380400001)(1076003)(86362001)(122000001)(38100700002)(33716001)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mQiiq2F8eBH0dx72u/3qmVTwIWeQZFTYterRHpql4Q8CGn1Ftybe1PXn88mP?=
 =?us-ascii?Q?SbDymaexKcARg4jv2KHbj1bji1KASNUIMn3ke1djcuO4uQR2DtD4u69Ync9t?=
 =?us-ascii?Q?46nKebASkgkxtqCS4Gq4dmp9lXnbQKKni/pZ8QbYPdY6CZyUL7ITCOaJ2X3z?=
 =?us-ascii?Q?tAsN9gHEIubeG+jqRrUahYWTyln3oNx1czfgL7m1XYYZhbDXv87KMJPbsG59?=
 =?us-ascii?Q?5u4a223gOc7WfRO6otuBqIm9fk4YBMb4h2m/YEzJuu2rcugF0sFFsmVR83kQ?=
 =?us-ascii?Q?0z5I89s/+xMoILxqWaiX3SBV8ySjS8NhNsiFiTBHmMjkJnci2K78iQYNp82K?=
 =?us-ascii?Q?sIO33J9D/f41wglQqGVlAOaJ3JoHu+5AEhmgpJ4m0cCATq/IDQMuGyoDYZ4z?=
 =?us-ascii?Q?BA7LDFISUdciLZV+YYPYNpgYOmZEgQmsSJGL9585onvgPNvAsZ3jRQ2Ts+Nv?=
 =?us-ascii?Q?V/p4bYBkheLw1Ok08kt+yztJUmiAnTUYAwoG8HMftXKSLCfI0S36uxpo6+vt?=
 =?us-ascii?Q?hH18WTBzfsNxcdG5cgUN1FNOugLwdUWcf1xfvfu5e8PNGu788CIPJxQWp6b4?=
 =?us-ascii?Q?yAqT1U2Q4eRlmKj6FwF9eq4otbTVA21h7CQG5MIWxusgnvZIrYAks+Iw60us?=
 =?us-ascii?Q?DRmiMMm4rJEbu2QIcVKYfccj36J9kzNN3aPylhYzak9L5Y5Mo5CmPBaIl+dW?=
 =?us-ascii?Q?vIReOFNvkh5TOw49rd0rMusV8Ga7NmaxO6LGWw7SvAkfekBBtaocpBsG5o7W?=
 =?us-ascii?Q?Sjwn2zPbTMp27yKHvogxQyMimZ7A5eJnhVvWiBgyPWcmZZsrl0wOpKn81Bu2?=
 =?us-ascii?Q?WZt3GhASYNJktevJdWar5gRr6Rk4Cf6Em6rduFVrC3Ny1I0ryInohhBvCreI?=
 =?us-ascii?Q?9mMR7y5dNWkDtXxF2o6vXXYLcdKtKqQRJUDjFZfgsiAB0/VJmvAIJW5fXGiP?=
 =?us-ascii?Q?zHn9yP3Pl8SnftU9Oad456uOYK5UnHBY1+2pQi4DwRjyEzbwMBUPsvufz5ss?=
 =?us-ascii?Q?tWdVIKNz4QioxIVED3/a5uQxVeyf2J57LFstEyYjbh0jG1tyJOOdRGYnwt9w?=
 =?us-ascii?Q?gZXA7Kuk2VgW4x1lTSO7bRVqwe0QmGTvccoPvZD+FSTPWsEdgeF0m4mo7Cud?=
 =?us-ascii?Q?PCm3u2Yuu0g7DvNqErTo9lt15ZeK4snxI2Fp4GZVdS02UAs7kXV212B8yfHJ?=
 =?us-ascii?Q?KTKK8SxWZEFfU43Z3O+oR19y+Y1aVps97FBkKGEQ3nW5OcbSDvwj4NdQYq1r?=
 =?us-ascii?Q?0qN0ToUU3S2DKOJFgm5HgCyClvbtccFpRULDM6zGrqBdy4invg2Alc34pFB2?=
 =?us-ascii?Q?9Kd+7VJpvTwk1lCnOSgm6j7UTXtsLa+e59taVRVV2BW2x/X9S3sJcqIqEYSI?=
 =?us-ascii?Q?dY2MRZjUkMmzjmQi3J6cXPL4lwMR1IWNvBGZdYqkvKm10eKDzvX8+pMxc4ZG?=
 =?us-ascii?Q?qkXKVGArptSB8WhC0c4qep+n29amUrCoJduPir9d80TFyd6iQ3khe7cXxL2x?=
 =?us-ascii?Q?Lh6oG2ZjDwDK8meZ2/mTLQkJWUKLZANR1gfrJ81CxlrCsMABv6L/rESrXeeJ?=
 =?us-ascii?Q?+stMbam4vs6yGxBsy/0DRO4M/nIbkRNfG9cIidkuaR+NK9n5s1/XvU5RBBGg?=
 =?us-ascii?Q?7MX9ejHG+mIcyPOfFwVt01g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4874133AD5676D41BCEAF0BB038DEEF7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f9750a-1060-43ca-f75e-08daa6034e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 12:23:55.9819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3MSmuexZsJ+97OxnTt/0qUXh0n6Il2qkDDmUUh0OREgV+58prHhNtMmMrc8R5raft5eqkCED0ijpS3VmSO3peQrMZUxjn60QTFNicr/9F0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7008
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 04, 2022 / 20:10, Tetsuo Handa wrote:
> On 2022/10/04 19:44, Shinichiro Kawasaki wrote:
> > Any comment on this patch will be appreciated. If this action approach =
is ok,
> > I'll post as a formal patch for review.
>=20
> I don't want you to make such change.
>=20
> I saw a case where real deadlock was hidden by lockdep_set_novalidate_cla=
ss().
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D62ebaf2f9261cd2367ae928a39343fcdbfe9f877
>   https://groups.google.com/g/syzkaller-bugs/c/Uj9LqEUCwac/m/BhdTjWhNAQAJ
>=20
> In general, this kind of deadlock possibility had better be addressed by =
bringing
> problematic locks out of cancel{,_delayed}_work_sync() section.
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?=
id=3Da91b750fd6629354460282bbf5146c01b05c4859

Thanks for the comment. Then, I think the question is how to move the
blk_sync_queue() call out of the ctrl->namespaces_rwsem critical section in
nvme_sync_io_queues():

void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
{
	struct nvme_ns *ns;

	down_read(&ctrl->namespaces_rwsem);
	list_for_each_entry(ns, &ctrl->namespaces, list)
		blk_sync_queue(ns->queue);
	up_read(&ctrl->namespaces_rwsem);
}

I'm not yet sure how we can do it. I guess it is needed to copy the
ctrl->namespaces list to a temporary array to refer out of the critical sec=
tion.
Also need to keep kref of each ns not to free. Will try to implement tomorr=
ow.

--=20
Shin'ichiro Kawasaki=
