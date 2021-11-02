Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E3CC433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 22:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9AE61053
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 22:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhKBWqd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 18:46:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59734 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhKBWqc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 18:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635893037; x=1667429037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XDZlIoaSwj5mXB93Xi8/52rwkEOeZx872q5vu7q771U=;
  b=ifmxQOkcbOKdisGFi6sQfR4zGClBKalTtX4ng2XI/5VYnZVrPofOxyFg
   ZJpquo41dTVyRKD+7lXCC31y3+hmJuEqEecCeAzoZ5pKzlGeH+iMvE8RW
   Af4xc5Kt1PYDI4dry3++fdgqavTdp2XpIQ+EfbThDJWBl+2J6JssF4XP2
   nVmPSHqEwNmPLyOT07sPmn/7FmQ7OInELBKOGHX2D24EpfE5g6LMm/1Z0
   QJlkVVFWXC4O+Utm8qNJ3vwKtV3yDn1ufZOR60iwROKEkE9lkMZ9MuPrc
   OSxLnTp+U8fAU/HM7vFzHKHYi9B7WxwM/qbTp5TuFuQWkvmBlxLpO3vbv
   w==;
X-IronPort-AV: E=Sophos;i="5.87,203,1631548800"; 
   d="scan'208";a="183536408"
Received: from mail-sn1anam02lp2042.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.42])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2021 06:43:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjcGfp3V1eljMB8NrhaJfMsDvpxSemehYo606ybyhtNRNHYr2sZGYxsepNl4SzKJfjt/wxwvcfRiRmbCjdkYH5D3CpOXomIhWO397V16vMsTVE36x8yh5lAc0Ncxbmnqr+RoZmMrvslqlEBYbL1ZDG2uFX35UjKk5rqc0yWXvoiTkTqj6rAemm9I1UA4xhqRUsRcr/zIdCKa/iufNRZ0WTNFdJwQ9v2FwDHiJRAbn2VGvC3uGm4jwSQVizZdP5C29E3BIxU5BG6JiXyLNjRI/M4ZZ5eO17bxNjiJLojPZ9mHfvRssJzh57y/+L4ZPVuGnb9llO5f+Z9siqNk73gBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDZlIoaSwj5mXB93Xi8/52rwkEOeZx872q5vu7q771U=;
 b=AylE8FIAGE+bmveZkWVouWPalY21eGXvqAXcb3l4/MP1I2o1Jps8p8bk02WvmYJqiP5UKo7/oew9F7UuEHCwRIl1rgHmsYrvGHSVewVeD9FKO9rI1jcbZnpG9Hl5fVrK5WKkmpLgWI55P3wBMuVAXbDSjUh5fl0YoVWLMFci3Sv5D6e60dZjah/uD8Erp8BrEG6KYJxxVJMclmKI0k3xzjaKn6hc3azn0Sx5BkiKbIQiaP2C8BmaFu1YARJwI7Sbm5IQyyKXWr0GPwbzmJOwk7HxTVWZO1pSePORJXEksuzrtLVVOdu6F7dxZFHY0bCGAabsm91DlXQ/mDbT/xooHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDZlIoaSwj5mXB93Xi8/52rwkEOeZx872q5vu7q771U=;
 b=DD6qquGsK9LqhLozwaDzIIijUqQQzG+2SUKB0tUTSTijfigTdhc3QPvnKurm4IB7Hp1K0MoZCsr37rgSLsW/2pFOTq/11boo66tt5cPAMoywy9rVxBJxPNXh5yEvvUwCgSP8sIegZSrRlRlUh44Ao7ZOaUtxxcR02IMya/fGUK8=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB6184.namprd04.prod.outlook.com (2603:10b6:a03:ed::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 22:43:53 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 22:43:53 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <Keith.Busch@wdc.com>
Subject: Re: [PATCH V2 3/3] blk-mq: update hctx->nr_active in
 blk_mq_end_request_batch()
Thread-Topic: [PATCH V2 3/3] blk-mq: update hctx->nr_active in
 blk_mq_end_request_batch()
Thread-Index: AQHXz/95/xNmQXe8gUaXW5DNA4E3Gavw1jgA
Date:   Tue, 2 Nov 2021 22:43:53 +0000
Message-ID: <20211102224352.sv5fihsfpkqjghgl@shindev>
References: <20211102153619.3627505-1-ming.lei@redhat.com>
 <20211102153619.3627505-4-ming.lei@redhat.com>
In-Reply-To: <20211102153619.3627505-4-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3ac950c-86dc-40fa-5e27-08d99e523f2d
x-ms-traffictypediagnostic: BYAPR04MB6184:
x-microsoft-antispam-prvs: <BYAPR04MB6184C17B9077CE12620D50C4ED8B9@BYAPR04MB6184.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q6TgiHc2FYJCPIwagV1zQzxsTnLzCxRvex+Kl1CxNN2ID8uh4bODbihe8re4QvvkWsq59m5POmFBV1BDh+N+N54t5eoijn7Fy95dbCjnP9JmWKOg4rGw09nbRhe96ZKgM0J2CjNS3md4PNf1D1s3+21eucMZayqbwVZcL6yg8GIpDNvLYHvjXhA5fetpgxn9Dnqojcl+fvoPITBbhby5U2IXEK32rOkstPKl/sc6ymW12LlFsJEHrX4YCWIWfH6PGmPtyLgbo6a+ZJZYWp/a15hnt0bSXPA4/BjmJA/MPxSldOUPX4Or5qaJERC799w0QkcRCKAeeB1tri5NrKdPUoDXtzSA2Ng9eUFu3aVt+WGkCQqjgrNFAvkg3h7tXx/FJchnWwvmMP49XinCtKVx4cu75TiVrfFOJCwSXt4ntmtgo1id6JXHKKAz16V7qZUveMHsVi/1CFWapzaoEH1WlY9r08v+pd3NNNRxWPZa0MMG7yFlN4pX4kH1QfpMvIykCxPWJPDdIXQ/y7DVsSvJ2u8uh/Nx4TVHbp35kPlpORD7m0fCpEqZ9llqOcrDFQxqUae3/c4fNbrmWX0YC5sBnSTG/gvnkTfkQXBEqPlc3Uu16B7UIvYo6WycRlUigFkpF+wz16jecving/A8i6uAleGhYT6yJNlcOFk4g/kxxfs7z0pfYCzpyNTbHy1bXGP8Wf1M82DqHl3oGU+SDgloYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(15650500001)(38070700005)(83380400001)(186003)(9686003)(6512007)(86362001)(66446008)(66476007)(64756008)(91956017)(44832011)(66556008)(38100700002)(122000001)(76116006)(6916009)(316002)(54906003)(5660300002)(66946007)(6506007)(4326008)(508600001)(26005)(4744005)(8936002)(33716001)(8676002)(1076003)(2906002)(71200400001)(6486002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sVH6EpkqTwHXIhPNCwgM2E6ZG+Pa0Sg5s1PjNiSp/n6KABNNQr7cM0OY61nj?=
 =?us-ascii?Q?RRAPxvexZOOyzLtBAND9o4hPYV/LSSc+97b33WaoF0wz7HilWxMlOyo0bER/?=
 =?us-ascii?Q?b4HE50fog+w95TZewFPwp+dJa+VwME0UwHr4mEC3V2lQuDqvtLbtZDaINOka?=
 =?us-ascii?Q?d2opRkAyDJlMEUtcXXmLPA2GfjtWIhHreyDDGKZzdCJkwb+mNilqNxcj0xib?=
 =?us-ascii?Q?MQPQWFqiQGJYeDL0frRCCw7SikDD7IQoVqZHCgb4BdhnO029SEvu5Yf8TzYb?=
 =?us-ascii?Q?2MR86bDusFeEHrzdotFI8biCbBOP9iVL29pocJozxn4EX3/QvhOIwdl2Rry8?=
 =?us-ascii?Q?Q4QVCF0X+nY4Ttr7Ji+4JV9hk/n+yxBKT3OiFU9/Rk3kGmiQ65frAb6qeJph?=
 =?us-ascii?Q?q9T7H0iSTx8nG3JcjTS1O1DRsibtd+xZBbWvn4uSl1fZYXvbIxPYrmdN9BUO?=
 =?us-ascii?Q?O17hyVS1WeWaeTtIQl1hAoXLNVwet0T1lCL/f9TDcHGs4K12aN3u7d4iSQsd?=
 =?us-ascii?Q?x/I3782qpB0u6BCJDL9CVFHJXk7dP3EipAmv9o8DeIrkbTA1uz6qkggmG8sM?=
 =?us-ascii?Q?EcBJBATQotQTnkVAR2nnHveBsYB/rH9JlMWLLXR8SS4NiJbhhnfj1zkpOm4e?=
 =?us-ascii?Q?KcUiw3qa6oZ7B5KvdmtanFZrB/+EWKXyr0AUr2iB4ZDxtngvNVbkd801vD4U?=
 =?us-ascii?Q?HqZBMB9vgRsVpmAaq0RA1BrtkBfs/SVQWbKC2XmuO/ptDL5FyXPR5B5xmwnt?=
 =?us-ascii?Q?DtkzzAQcW0e8h3qGUKFIAALauqzGYS+qxLYq6PCSOYEKiGAcSxCdr5OhEro9?=
 =?us-ascii?Q?kyGQfnYWQx9aCwm/Mv9+sIB6w7jNLL4l9gqpeaa+42BnYr9ejXOp3dhFfxCg?=
 =?us-ascii?Q?ASYthXpMvicIWj4AkszyI6kkSQyCTI0lg223DmjrjSG0ZIoO7cPBVB6tOfOy?=
 =?us-ascii?Q?ScXzYKmQ1S3+qmpblTmSRjewjcdagiQLULbPeHm+y/iuORh8ZFY3KVTMU2gr?=
 =?us-ascii?Q?n/eFO7qa3iE8HZdKywQrOATIbgqxHFJq/xVMuyV2Lc0gekOTEAiVO61Odveo?=
 =?us-ascii?Q?3+zkz3hrXQPaSJUfuVWtBPHmTBFO1GjusnqfNSTEHV5wAAyJhAF+HoMHUZJZ?=
 =?us-ascii?Q?YgTJpkiM6TSPRFi8nexoFMpkxP7RQl9xZFJ6uFuKsbXKdNQ2yT4bCSPmwWQ1?=
 =?us-ascii?Q?yMzbetWN8y5sK3bhf0CbJrAlxTo3FmiTyJ6PZSYmk2eWwwTPIB3FbJRc7ViM?=
 =?us-ascii?Q?DKUds8olGlZ8YIDcT6a10KxQ69cdPCkMlVvAVwG9H1p0w6+zDAHS1KxU88jd?=
 =?us-ascii?Q?g0U9wBHr8tEsVHMUjDRtqs7t4km9PXAUq1VWMwhy7AupJpZmfOSpgRuB2/4E?=
 =?us-ascii?Q?dPlckifnfeG/zD2YIooZHzf8Rd1uy0mzHVr23IDe/F0oy8DDkZxk9okT3GkF?=
 =?us-ascii?Q?b2f0VeC69FZbNs0liwfLbDZZC0MsP1vr1ZIJtMXLRHOGNKDltByE7Eh890hn?=
 =?us-ascii?Q?r2OD9ki0dYJwfhqUlYoj41gffjvt5m7z2AhaD+Oo05khTPmGP0QhqLNSjlJ0?=
 =?us-ascii?Q?VtzHtBo+A98vIU2cUN0B1pr/lPeUkABNV4byh0CA1sRNf6EIOubeNr/slwQx?=
 =?us-ascii?Q?3+Sk7Vbunf1VkqYsFmf8PN9X31SMTINRYPYN0cKyiSEKjWe3Z/8mq7gw0RY1?=
 =?us-ascii?Q?UhiOSl28Srv6widbD+YKEYNZX68=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C6A22793DD1ED428C1DA1726526BD11@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ac950c-86dc-40fa-5e27-08d99e523f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 22:43:53.3164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVNNftBmjFvWLRxRZK+3wv3J756HdQrvToTXXuQEJzpxWEd+lLmk6H5BIn9quaYDyKsCZhJzo9F6gTazAzp/2xIJyIsFo//Zf97iQQOMpvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6184
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 02, 2021 / 23:36, Ming Lei wrote:
> In case of shared tags and none io sched, batched completion still may
> be run into, and hctx->nr_active is accounted when getting driver tag,
> so it has to be updated in blk_mq_end_request_batch().
>=20
> Otherwise, hctx->nr_active may become same with queue depth, then
> hctx_may_queue() always return false, then io hang is caused.
>=20
> Fixes the issue by updating the counter in batched way.
>=20
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Ming, thank you very much. I have confirmed that the blktests block/005 han=
g
disappears using NVMe devices with two namespaces.

Though this patch is already queued up to for-5.16/block, in case it is sti=
ll
meaningful:

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=
