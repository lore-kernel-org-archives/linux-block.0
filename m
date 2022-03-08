Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB14C433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 01:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbiCHBNA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 20:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiCHBM7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 20:12:59 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ECC63C5
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 17:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646701922; x=1678237922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HglGU4WR/HykvDCumQV13GPBcA1yNtFgTKCjnnPNe04=;
  b=KfdhyJopM1tblsUeoROxrw2Re9H6t2BDVJP5Z0mw03CWC1aL5TOnQzwh
   +2Gv6dBGzYjd7LqY722fX9xdIZ1AwEPSaTnY/gnMdqfVi2R33e9EKyACr
   1N+mxkloRs7zwZDs/eedN/vzJq5yNk2EIMY9fF0wE2t/+r/GgBhl1lS6C
   jpRM6rMYavcylfLGsSmdTVYpmOqBwSDvrQj8opnLmJGyzmExMkDqQ32if
   EuWk0gKfO0gVVbulZ9fERHTXv97sIW/hjHphFw5JuKc9H7MhYCo96YD0D
   dZ+XIcwL03YdTxY4DTv4zAOzrym0cqPPj1CxDORQOBph42ojxLiUqyT4x
   A==;
X-IronPort-AV: E=Sophos;i="5.90,163,1643644800"; 
   d="scan'208";a="199554872"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2022 09:12:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXYZ8nipRyv54mq4ldlZbVXWIFsOaib2E0qf7i/hpY6L33N7WD6G2zZmRQZYUQBf40PnTBtEkahlkrIDyazZlPmFpUAWc8C0OWanbIjC9+wipSCRV3R8eHkVy+91RKdEhgcx5LE+Orqt0x4A3qpIcwB0vaqt8bgQoyP8aIiJWqMzaVLCjNb392F0T7qztb+srZJXu5ChykHypSUiIJTlUwrwRxnZN56iG4xZiGCffmTAeniT1H9cuw8FFdhJsL8BJYycKZScskcLx9u1nPPrzRBDCyQ0OIBgAmC+6hdcZNGr5aqP72js+iJyvQ04hTRQdAup4SnXfCJBmJAM5Cpn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9NTDN/jKwsg9KLeru3yk0pgrmRQEg0ZJ+UAul4YL+U=;
 b=UI74WzzN/I2MwDKXPmwzcum0tUAigXqYkD2Iq50IbssKoi4dfwLiwZKkWXB68m0bfrIntDOQb/mtI5yNiNwSJGYNZbtZsfs9MIaynOtCIv6OIIFUbvY3gBGdYcyTuoNWQIAHfeI6mDjHrMFcdqcDGLCJvBO0HRqTgbE9mHd1dQA1eHHT41Qva1xYCl9LVn3YDC15U+opZO71Pr+5N3xFglq+p6wgsJtOQK5AQ2qAEtvCqxi6UkkJR76F1gxwlYqPVeLXj2dp+pBcZ1bKV8/W7gr58vIt/RKiknwKQ1pCyBlAknzsPc0a3niuI19KDbOxW0l7x/rw2jQAiZwvfmLyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9NTDN/jKwsg9KLeru3yk0pgrmRQEg0ZJ+UAul4YL+U=;
 b=Vmn8DhvNecltiiS5SX46O1eN3Sq1px91MpxCxTzK1AGxkSLRz2vKJY/B4nw22fmaeQD3CHkaBGokneyQTQ7gN0TrefInsrIqM0dzleT+J3sJ0FU39Hwwe7LlL5i37QK8gsIApG/lojOfs58gMfIaPx80cxTO2SAtO/DY5uKJD2o=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM5PR04MB1052.namprd04.prod.outlook.com (2603:10b6:4:44::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Tue, 8 Mar 2022 01:12:01 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::58d1:70c4:5b35:6c0a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::58d1:70c4:5b35:6c0a%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 01:12:01 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] blktests block/005: KASAN uaf at bio merge
Thread-Topic: [bug report] blktests block/005: KASAN uaf at bio merge
Thread-Index: AQHYMhZAQGfK9roq2EqR+pvUaw6GV6yz2Q2AgADVy4A=
Date:   Tue, 8 Mar 2022 01:12:00 +0000
Message-ID: <20220308011159.nehuv76mq2c6qtro@shindev>
References: <20220307112655.5ewkvhz5d3avglnd@shindev> <YiX6B6uKsMQ0erbj@T590>
In-Reply-To: <YiX6B6uKsMQ0erbj@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b64df1fc-0c82-449c-f42b-08da00a0a63f
x-ms-traffictypediagnostic: DM5PR04MB1052:EE_
x-microsoft-antispam-prvs: <DM5PR04MB1052750CD144AF9CC0F275B7ED099@DM5PR04MB1052.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TKnxdmbQXs2OK80hwrlP9ZGxx4DXJmufvoShO1R0wzf3M7+L6A/GmWTqn0ccCxM9lUDTWQxeVvJBV8GuqscD2KeA8qKHqyHcdZa3LgraJVHLzxtWdrgZ4XYMJO1MmV4/7QWA6OFqAlE9ORQzUON7r9y85rpDz7x/crc0hc49FhcGnUOAInIspJmRgO9UHoO/yg+v40WxFrfwouuqo+u1oeuyFfNyrQxysHNHteUiQSBzhpFoiVlMlE69rC0V31J5e4ae4Yh/+8qBVbKwQmKM9dT7SWODoF1fkt6Hj0HR6AVEvO32tUXFgrbwUCLApcGgDqwkVxxD5S7MOhjFCLEhdmbCXz0425pmfnZBAsJuk6HlS3pprYt1+UDOzNX1fgpQ5qjM6HBdL9GHEJFSkiYzvzQ8ndZVMtgaSHnCG3iYRAiE9NQKnONvcu56v++MQ6fcU5fqQJlbkgDuV55TvVbkPImHZEZzj/zVqSjPee79FWXwtpPWthBxUxevWQid6k91l4sqyy2dRyr1XJVEtD6t6Vhhfe2szrnLK502pcm6nRmge2QILXphi7Okoq4qRjz+Xm4WI5PRZxv0JKMMG3ySJ71hJT5JHM1kGfMlrxenG1S82McBjsfgwg9ZaR7Vg3GWS4dbA/do0liNz9aITd+MkbcA6aklcCfvMpZywiLQHwZa0jiRFqYCCoDJjx/aE7rqs3/deZzmFOjayrXtHc+HHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(4326008)(8936002)(44832011)(86362001)(5660300002)(316002)(6916009)(122000001)(82960400001)(54906003)(8676002)(38100700002)(38070700005)(91956017)(83380400001)(76116006)(66556008)(66476007)(64756008)(508600001)(6506007)(71200400001)(9686003)(186003)(6512007)(6486002)(66446008)(66946007)(26005)(1076003)(33716001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RjRUE0VOgtTC6yRKnTvBTXFTf88iVbpVtfC/bDeY13YMNTphnL02x4cB08ul?=
 =?us-ascii?Q?ZFIQ2u7FheeY3rsrbpaiygpdzWLVIPYn227Rdd2p1z9N56hTP13r+AJF0AHS?=
 =?us-ascii?Q?3bBkrd1CVxj4ceg9Q86h7JVE7hTnPOis7kmdrJvfEp8dSlHI+qEIliY6Hbst?=
 =?us-ascii?Q?VYY3KoHzhPLXd4jpdy3P2ybSwdBsxydGNX94xud/8nGOBoHeW31psaFtaB2Z?=
 =?us-ascii?Q?qW4VpKYj8b9YG/noCDvcUOVuy+Cday2kpq39CPp+y24oGqgXa1ASFX7fQwM0?=
 =?us-ascii?Q?nO5UJX0r+chXu08mFnvPCiV1DvP80MeN/r8+da9lSFhk10m608RdMN8DadDf?=
 =?us-ascii?Q?wYeF3vk9jovS7zPcDq78xX2TPM6TTk5id9GzK5aldZEb5Pys24JXefw1aI/u?=
 =?us-ascii?Q?a2fbV3UMSP0yuaT28Ofnw5eFuvpjcb8TG7wkymWsjPYDygcWeYvGAZlOZwuN?=
 =?us-ascii?Q?W366W+f80euEl8o/ICtm4lnEMunpzn2JC0IW6uqt95fESopezHs98b1aDe2o?=
 =?us-ascii?Q?z4StHH4QNG8qqQhqkD7IYzRFnXnrXongx9UyD5dhXD2DO3z6nbkaLISyDNWl?=
 =?us-ascii?Q?ma+hLDWfOPgwJvHLMu7TSXBujO+ttcdCVOGOeGzU7nOa1cTMcAgKZimtEG1g?=
 =?us-ascii?Q?I/rErWJLdUAyLwYNnkI7pxcrzph5crpFj5qwQXWlPJvAQ2UxmDviYFf9O9UB?=
 =?us-ascii?Q?kHR+MnobftxwwfHz+3e2XKSuXTR82HVhUMX2SNhV/OSgSwg+78tOmHKGVcRY?=
 =?us-ascii?Q?3QSz+0pXVzkpLBrMppJdIv48SnMpCCRqCdoJtCDE7uGDJL2j7Gq/fZLI/r0A?=
 =?us-ascii?Q?J2pkB9AkLkyhrTLko/7crogS/ouO14Ic52ZZlcKKgJXezq2sfPt8/KL/t34K?=
 =?us-ascii?Q?+u6HmnMqpQgVcnEURuSF9HGqOT9y82I5XJGR9BkoQ10xalpLF2SjguoeiJEe?=
 =?us-ascii?Q?y6jVGUCR5Gxkr3c7esClzPohIJUOz3cGLXXIF0tLOiysGkoBwtN8oacLX5XJ?=
 =?us-ascii?Q?b6QqIkI5BxX4zLh8AATriunp7cckInv36j63Z1ifF5kUbLGjNd10PTjn0YJE?=
 =?us-ascii?Q?ORCU9Kuw0Uh3TqGheTY2AoxR8hKzy6HFFy7ht1Ekds/56TfcXXrfjb6ilEIT?=
 =?us-ascii?Q?z+/u4pP6EimsrGy1RHaJp+JxAX2sYgv4wvW5WDW67tppFlQleZ0iaouFom+/?=
 =?us-ascii?Q?GANp+8hnZ0sVTexEd8SPSmmgPqwGtjy1086TCWtPqDaMa8yhzlkQfw1BngO5?=
 =?us-ascii?Q?+7wjpOGOrn1vVjk6Ba4OVsbeyeD3dODwKm+4vyLLGkC+1dsgBGsjAyrKh9y8?=
 =?us-ascii?Q?efCxq4VW+3TskAh3zhhqtzJFqYVIOyIn8PyeIB0Km2QQPx4cmopnhOUzyNyX?=
 =?us-ascii?Q?klnrU7YfSDyhBBStyVRgl8KdlFFOgS/KD21fPgjGY2v/mXpjPUP30YLt3QWZ?=
 =?us-ascii?Q?6V9/KC9YYGRWBowEQpw5dOPYyVAC5xuMXWLWXhlzp1tIbaIYWwI8FYyKXZL7?=
 =?us-ascii?Q?+ymLDeiXa651laSD2n46Mlk3CchVSoAz+NQuAdMjw/KiMjoqosS+E8k3VciF?=
 =?us-ascii?Q?szv+rcKhkx6HL1X0OQyahJsS+XvJFzjQjl2gAltq7M408cxnGOw8h9GiY1vb?=
 =?us-ascii?Q?HrbqB/gyobxwPstkIUwGk+z5XQfqVeD6yIBoNIWUWbUR+pDKws70rAQMa0Ot?=
 =?us-ascii?Q?DC1qHhiEakCKA4sBQ5rR2ASspsU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38B11196CFEA4447B6FDD7CA2CDCCBA1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64df1fc-0c82-449c-f42b-08da00a0a63f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 01:12:00.8135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61U2kDFOUsFHQVo/2Pq6n2uOxHwQpEjlCD6WL3RQ2USjwfImOHukh5fkEl/nN4BwNiMMhns/BdVi8Fcej9lDAkZoWLqRA6NlVf+0nM0Crsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1052
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 07, 2022 / 20:26, Ming Lei wrote:
> On Mon, Mar 07, 2022 at 11:26:56AM +0000, Shinichiro Kawasaki wrote:
> > I observed blktests block/005 failure by KASAN use-after-free. The test=
 case
> > repeats IO scheduler switch during fio workload. According to the kerne=
l
> > message, it looks like bio submit path is running while IO scheduler is=
 invalid,
> > and kyber_bio_merge accessed the invalid IO scheduler data.
> >=20
> > The failure was observed with v5.17-rc1, and still observed with v5.17-=
rc7.
> > It was observed with QEMU NVME emulation device with ZNS zoned device
> > emulation. So far, it is not observed with other devices. To recreate t=
he
> > failure, need to repeat the test case. In the worst case, 500 times rep=
etition
> > is required.
> >=20
> > I bisected and found the commit 9d497e2941c3 ("block: don't protect
> > submit_bio_checks by q_usage_counter") triggers it. The commit moves ca=
lls of
> > 3 functions: submit_bio_checks, blk_mq_attempt_bio_merge and rq_qos_thr=
ottle.
> > I suspected that the move of blk_mq_attempt_bio_merge is the cause, and=
 tried
> > to revert only that part. But it caused linux system boot hang related =
to
> > rq_qos_throttle. Then I created another patch which reverts moves of bo=
th
> > blk_mq_attempt_bio_merge and rq_qos_throttle calls [2]. With this patch=
, the
> > KASAN uaf disappeared. Based on this observation, I think the failure c=
ause is
> > the move of blk_mq_attempt_bio_merge out of guard by bio_queue_enter.
> >=20
> > I'm not sure if the fix by the patch [2] is good enough. With that fix,=
 the
> > blk_mq_attempt_bio_merge call in blk_mq_get_new_requests is guarded wit=
h
> > bio_queue_enter, but the blk_mq_attempt_bio_merge call in
> > blk_mq_get_cached_request may not be well guarded. Comments for fix app=
roach
> > will be appreciated.
> >=20
> >=20
> > [1]
> >=20
> > [  335.931534] run blktests block/005 at 2022-03-07 10:15:29
> > [  336.285062] general protection fault, probably for non-canonical add=
ress 0xdffffc0000000011: 0000 [#1] PREEMPT SMP KASAN PTI
> > [  336.291190] KASAN: null-ptr-deref in range [0x0000000000000088-0x000=
000000000008f]
> > [  336.297513] CPU: 0 PID: 1864 Comm: fio Not tainted 5.16.0-rc3+ #15
> > [  336.302034] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.15.0-29-g6a62e0cb0dfe-prebuilt.qemu.org 04/01/2014
> > [  336.309636] RIP: 0010:kyber_bio_merge+0x121/0x320
>=20
> I can understand the issue, since both bio merge and rq_qos_throttle()
> requires to get one .q_usage_counter, otherwise switching elevator
> or changing rq qos may cause such issue.

Ming, thanks for the clarification.

    In the subject, I noted KASAN use-after-free was observed, but the kern=
el
    message above shows KASAN null-ptr-deref. Actually, both KASAN
    use-after-free and null-ptr-deref are observed occasionally, and I mixe=
d
    them. In case it confused you, sorry about it.

>=20
> >=20
> > [2]
> >=20
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index d69ca91fbc8b..59c66b9e8a44 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2718,7 +2718,8 @@ static bool blk_mq_attempt_bio_merge(struct reque=
st_queue *q,
> > =20
> >  static struct request *blk_mq_get_new_requests(struct request_queue *q=
,
> >  					       struct blk_plug *plug,
> > -					       struct bio *bio)
> > +					       struct bio *bio,
> > +					       unsigned int nsegs)
> >  {
> >  	struct blk_mq_alloc_data data =3D {
> >  		.q		=3D q,
> > @@ -2730,6 +2731,11 @@ static struct request *blk_mq_get_new_requests(s=
truct request_queue *q,
> >  	if (unlikely(bio_queue_enter(bio)))
> >  		return NULL;
> > =20
> > +	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
> > +		goto queue_exit;
> > +
> > +	rq_qos_throttle(q, bio);
> > +
> >  	if (plug) {
> >  		data.nr_tags =3D plug->nr_ios;
> >  		plug->nr_ios =3D 1;
> > @@ -2742,12 +2748,13 @@ static struct request *blk_mq_get_new_requests(=
struct request_queue *q,
> >  	rq_qos_cleanup(q, bio);
> >  	if (bio->bi_opf & REQ_NOWAIT)
> >  		bio_wouldblock_error(bio);
> > +queue_exit:
> >  	blk_queue_exit(q);
> >  	return NULL;
> >  }
> > =20
> >  static inline struct request *blk_mq_get_cached_request(struct request=
_queue *q,
> > -		struct blk_plug *plug, struct bio *bio)
> > +		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
> >  {
> >  	struct request *rq;
> > =20
> > @@ -2757,14 +2764,20 @@ static inline struct request *blk_mq_get_cached=
_request(struct request_queue *q,
> >  	if (!rq || rq->q !=3D q)
> >  		return NULL;
> > =20
> > -	if (blk_mq_get_hctx_type(bio->bi_opf) !=3D rq->mq_hctx->type)
> > +	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
> > +		*bio =3D NULL;
> > +		return NULL;
> > +	}
> > +
> > +	if (blk_mq_get_hctx_type((*bio)->bi_opf) !=3D rq->mq_hctx->type)
> >  		return NULL;
> > -	if (op_is_flush(rq->cmd_flags) !=3D op_is_flush(bio->bi_opf))
> > +	if (op_is_flush(rq->cmd_flags) !=3D op_is_flush((*bio)->bi_opf))
> >  		return NULL;
> > =20
> > -	rq->cmd_flags =3D bio->bi_opf;
> > +	rq->cmd_flags =3D (*bio)->bi_opf;
> >  	plug->cached_rq =3D rq_list_next(rq);
> >  	INIT_LIST_HEAD(&rq->queuelist);
> > +	rq_qos_throttle(q, *bio);
>=20
> rq_qos_throttle() can be put above together with blk_mq_attempt_bio_merge=
().

Okay, will move rq_qos_throttle() just after blk_mq_attempt_bio_merge().

>=20
> >  	return rq;
> >  }
> > =20
> > @@ -2800,14 +2813,11 @@ void blk_mq_submit_bio(struct bio *bio)
> >  	if (!bio_integrity_prep(bio))
> >  		return;
> > =20
> > -	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
> > -		return;
> > -
> > -	rq_qos_throttle(q, bio);
> > -
> > -	rq =3D blk_mq_get_cached_request(q, plug, bio);
> > +	rq =3D blk_mq_get_cached_request(q, plug, &bio, nr_segs);
> >  	if (!rq) {
> > -		rq =3D blk_mq_get_new_requests(q, plug, bio);
> > +		if (!bio)
> > +			return;
> > +		rq =3D blk_mq_get_new_requests(q, plug, bio, nr_segs);
> >  		if (unlikely(!rq))
> >  			return;
> >  	}
>=20
> Otherwise, the patch looks fine, can you post the formal version?

Will do.

--=20
Best Regards,
Shin'ichiro Kawasaki=
