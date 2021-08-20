Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F74C4338F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 23:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E684F61166
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 23:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhHTXGE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 19:06:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:6935 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhHTXGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 19:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629500722; x=1661036722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TL9GYop6fNHTyBMC1PjLzwMQJ8kQerUXSi0T109nnl0=;
  b=knNK0c/jzUSbF0EsojOKEykV3/IgbgcWzFbo3yrM0w2oP8qHO3gtNKPp
   4Oei0MkQnu5mrdGXiBsPNejuSgfGPdGf2vS5si9WsIjYKuqWlATMiv922
   8puZGlQSsPASsqUocg/wwfLjPmWyCS7VxGS5vp0xBA7DlhTDUvEPVVEsY
   4I2Vv+mD8H7KYEANqjdVNSvreYHczFLcahgwB89n/pdeTQNNL/8TLp/lV
   zkOxlhAAYQJzK/nC/v2xypqL3zmIiOApZ7pRL4/Hq8jkZVbCLNAITCmdN
   BIXhTaNemvocjhQ00cwne/Gex8RTfhoRFohvY0xeQBPsMGF9ls3aSshld
   w==;
X-IronPort-AV: E=Sophos;i="5.84,338,1620662400"; 
   d="scan'208";a="177104855"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2021 07:05:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCOLf8+nSrjn+7XXK2nzeV3OHaq9cG6NZul2UVxUol8exjWJdF2/ksVIwPly9dVmhEZYccJB5Wk06PwwZutYXjHYNpET5UVIsxG1FzX0vBEx35f0vDgFUsRApz86cUlywv9tWggEge17oFGW63lLX0F9pSlRND0dbg01u8qRJtw1+k1x/0sMqzyTFbvrUD3wFXVoFnWUax4+AZ8njznt2iXt7eahedPWSIFODbg6UDO3v75JXVXHU8a3ofwsc2TexAmwNsQePoAXta8XJWeBApMhfdOaaGqwgijarou6uY/0xGmZGeyJ6XvWTIA8nbrbVkGpgTV5lDoS/dw4Yz/JoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nehifISBnwidkon8HrFQ+eBiw/kIKyVz3xxPZkbmmo4=;
 b=MSPv7jJw4tn7arUGvgQS8+g5UHEPC47w0+FOk/Er6cW9pb9XDL2sjt9+7q+g7TdlGrtF5tkRP530XE/KgzrP1nQkmu1+ZmB8hZALSGfYpXjxlH377oWbDjmBDDuvjuVcqV1x7F/qXGBoYOxFEGi/O37JbLkvbTWyEv5mqqwyaoApOJKeJt4TNxaVw6PZFBrBeBySxgvhlD6Vbxl/Y+PHXr5Ua8po11Lw2NZjtqMdZvR5Q8OgAN4vd5xnHg/axtffM5x7ylRbTjmumqzpwxmaqLNPmyNbbhSXy/D8BT+oVz9XEyKf2C+u1tRQwfacs32LgfzOUy/5aSn5vP7bHWBclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nehifISBnwidkon8HrFQ+eBiw/kIKyVz3xxPZkbmmo4=;
 b=isljGO5fLuskRinyfTobH4FZ3HxlZe8+y+ws3VP6B8fLgQMdBsLl8KrhqMJ1Yv7wqdYItAG5/gST8z0qD0UeEPJNETblIn6JKQCROwlGpTii1c2k8OhiSSVk/+T5J5Ra5Wb1zvsZu69NAhitwiF7iKAeLmLCVpeJIZv/DfD/mRA=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7526.namprd04.prod.outlook.com (2603:10b6:510:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 23:05:11 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9%8]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 23:05:11 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 16/16] block/mq-deadline: Prioritize high-priority
 requests
Thread-Topic: [PATCH v3 16/16] block/mq-deadline: Prioritize high-priority
 requests
Thread-Index: AQHXlVysvcZeBwZKNkSbW/SgpyhLO6t8sO0AgABT/oA=
Date:   Fri, 20 Aug 2021 23:05:11 +0000
Message-ID: <YSA1JWt9soMSs23Z@x1-carbon>
References: <20210618004456.7280-1-bvanassche@acm.org>
 <20210618004456.7280-17-bvanassche@acm.org> <YR77J/aE6sWZ6Els@x1-carbon>
 <5aa99b39-c342-abd4-00a4-dc0fbfac96aa@acm.org>
In-Reply-To: <5aa99b39-c342-abd4-00a4-dc0fbfac96aa@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a44052a-02d0-4f92-8694-08d9642ef665
x-ms-traffictypediagnostic: PH0PR04MB7526:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB752678AA26E31B0D62E9173FF2C19@PH0PR04MB7526.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SdW5RTCVk5f+M7BNzV2P0KFpeMwzsgR2AiWBfYbiGvZfgg3x2ztBQa6LPma1CD1LjHHDBeuFS1QdGYrA3XdA+R2HwK7RzyrdnAqSbBl/grvOacpXCpLhYkCwwM8/ylqUTgZ1yt/nfIoOx+pyIdxfcZFZkGgxmIR8wQdQEzvaDW29spJ+q+g8JWZZwT7y+rWf2M8pVnqzIDOGjWQqXSaiSDuUiVZUWskTop4oomlb1Ws3smVyO7y9cXQWY/ToaaHQtjvaCwOIJzN5rJ7VUFy4Pi+ss/uwpk6MwqPuutKFfgcnW/ncx0i5BlBm6SyVWvwI2aJ96pmNSbJtyJDMA5sw/Mf0yjHdssApzyTFm+GEoXT3IVE8DUIZJcD11M2ApY7CSZcAFsWZCarSGqPGSKzxE5Kau7wj7upzPKXs9msAMizIstk2+SvQXMvHjb8XWiqhq3a3G7V2dFB3hOrr0BG5U9qWoN+R3cuKFdPG2viZxzQBWSu70uVM/AydcCI7E0xKE0XlXr7/D/YGFekpk0RocwVv7XqU/L1ZbO42n8lq4gjSqxlYCT/qvVe3NucshljcyIamb8FZZoL+QKJj78Ip3NvkSn8JebPjVca6HmcrgvPUF8b4KfKNB55YXG6bxEziyWYH4b2Qb68UPEIV/45X2JVKUKgyTTMig0Myohd4ZFNPSFjg9LgMS4+PzTJ8tJmKDXZRi2q29iFtugmC2ikjIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(39860400002)(376002)(136003)(366004)(396003)(6916009)(2906002)(6486002)(54906003)(8676002)(4326008)(33716001)(316002)(5660300002)(8936002)(83380400001)(53546011)(6506007)(38100700002)(186003)(91956017)(26005)(122000001)(38070700005)(478600001)(86362001)(76116006)(71200400001)(9686003)(64756008)(66446008)(6512007)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7rFuc6DaQTfWs78pcXTj8dm1Ot2iMfNrEFuXKc25+bZb4DNF540xEpxsc51P?=
 =?us-ascii?Q?N6SOiU5hjd5FmU5CfuvuIDhWwnWyR4ca7MoSSRMnpl37FQuN3MMwIcsui8az?=
 =?us-ascii?Q?CGMr/rt6p2he3pgtZd+y+qQAGs+bGJLVvRwin/jULQzaflYptUkIk11Z7ZQk?=
 =?us-ascii?Q?dm3r7jtbKUdWG4fe/XJuNxZxGBO6e0iyUWWFeqoZxadP6a9mIhquXi0A5Dij?=
 =?us-ascii?Q?Wbyx4QwLAXurGvt6kYUQIBImpLJV3M1cxvbDW4gUWG6f4FPZV+I/6744wGQe?=
 =?us-ascii?Q?Pqj9vWzOqcGJEAXXmgbMVyiBHzsYL8G6Gqdz26A8t9r1lEVBz5VmguBRgihc?=
 =?us-ascii?Q?uv3H+JU6Z520mSzUJXWdNayN/mUC0cJ7MpdecKgHywZYAX/5tBpB360sps1R?=
 =?us-ascii?Q?trXFN6yfmXM/HAk6If6HZhdMmYWeCtXkPcU5pU5HSAX1PxMotYWNxvkcRRxD?=
 =?us-ascii?Q?JIsP2ag4V5NrjCsXMFtiYKZubZpwCqUhd6TfgWvSYXiI1C7Nsobv9tmIz3al?=
 =?us-ascii?Q?yMZiaNxlyiLUySY9/yAoohYE12KJH+Kofbqd9xfdUp7CapwzYHYf6L0KXrHg?=
 =?us-ascii?Q?lJ5WB1k5f4xqU5s9p5xuLODYyWiYS85aHDJWEDs/b9f3yoFBvN8jnHbw7U/+?=
 =?us-ascii?Q?mQSBqSmP1bdfHdWkGrqp19Y5pD4CapBY0ZVnJP7y1vNp5jrR0FdwWSKP8Hv9?=
 =?us-ascii?Q?SCeUUt062RH+qEKXrcmplzUQghnUNllhEoWfBSinJrapw9azDgVaiz/nDcuc?=
 =?us-ascii?Q?aKce0RxmAOMejxM3V66zU4RcNgemMZHzVHqBcvqreIPyibL3Et+Fk4WjMDHN?=
 =?us-ascii?Q?hOPSTN9KgeKUamYR1e/p2U876J7d+VvMKQqrnjmSKQ+p9mNY5q/26MwJIILG?=
 =?us-ascii?Q?yjBi8UgO4QE90tRBXFyl59Mgwlp/DLOaXh8FPPOG9jaRC1l9Hv6mRU+67aZ0?=
 =?us-ascii?Q?D7TlbOrunmH43yFfEKaTExJs99Dm45Gx2fXCHA0Ag8R+xxTqsbCzJckYzyLV?=
 =?us-ascii?Q?aSpOzfdZjzgUkQSFC87LNemx8Pq0RYjmJL9WsclaYJtK1sIXSVcFpShi62P+?=
 =?us-ascii?Q?xafHMPqVYnC8wUbpAnbGQJgpy1AXui37CwIX9ZUYwt8OrsLTuTAu3XTVFk0C?=
 =?us-ascii?Q?/J4qFLv8IEdJGMRZPwpHy5KqrO9KdLUJIV2NTGyKXBvEbq8zkhsEu6/Or04M?=
 =?us-ascii?Q?Vhw7y04VUOppG1naTbT20PYBukA9dRvkpGQhZrk5O/f8WVi28qgJkp65k0Ty?=
 =?us-ascii?Q?GQdM7ELEJjmqDTLlBxw42kQ2nXh7jMtd4i4WdAufTTQ5ORKNTF69JaH+Lq0x?=
 =?us-ascii?Q?ri7OxsVp05eNY9cBsCzajVhLAETphe8sxTuDlc6sMUEXzA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F71138D37B562642B1C5843024B4F7CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a44052a-02d0-4f92-8694-08d9642ef665
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 23:05:11.2696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOU6c63QvBjRYEGSirq1pT+1HulN+XvaxCWEXiSlnppL0Lfz9KN3efC00SVoQ1k7bI2tPZLJ8kLokrWdIywfYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7526
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 20, 2021 at 11:04:32AM -0700, Bart Van Assche wrote:
> On 8/19/21 5:45 PM, Niklas Cassel wrote:
> > dd_queued() calls dd_sum() which has this comment:
> >
> > /*
> >   * Returns the total number of dd_count(dd, event_type, prio) calls ac=
ross all
> >   * CPUs. No locking or barriers since it is fine if the returned sum i=
s slightly
> >   * outdated.
> >   */
> >
> > Perhaps not so got to use an accounting that is not accurate to determi=
ne
> > if we should process IOs belonging to a certain priority class or not.
> >
> > Perhaps we could use e.g. atomics instead of per cpu counters without
> > locking?
>=20
> First of all, thanks for the detailed report.
>=20
> Using atomics is an option but an option we should only choose if there a=
re no
> better options since every atomic operation in the hot path has a measura=
ble
> negative performance impact.
>=20
> >    kworker/u64:11-628     [026] ....    13.650123: dd_finish_request: d=
d prio: 1 prio class: 0
> >    kworker/u64:11-628     [026] ....    13.650125: dd_queued_print: ins=
: 0 comp: 1 queued: 4294967295
>=20
> 4294967295 is the unsigned representation of -1. This indicates a bug - t=
he
> "queued" number should never be negative.
>=20
> > What appears to be happening here is that dd_finish_request() gets call=
ed a bunch of times,
> > without any preceeding dd_insert_requests() call.
> >
> > Reading the comment above dd_finish_request():
> >
> >   * Callback from inside blk_mq_free_request().
> >
> > Could it be that this callback is done on certain requests that was nev=
er
> > sent down to mq-deadline?
> > Perhaps blk_mq_request_bypass_insert() or blk_mq_try_issue_directly() w=
as
> > called, and therefore dd_insert_requests() was never called for some of=
 the
> > ealiest requests in the system, but since e->type->ops.finish_request()=
 is
> > set, dd_finish_request() gets called on free anyway.
> >
> > Since dd_queued() is defined as:
> > 	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
> > And since we can see that we have several calls to dd_finish_request()
> > that has increased the completed counter, dd_queued() returns a
> > very high value, since 0 - 19 =3D 4294967277.
> >
> > This is probably the bug that causes the bogus accouting of BE reqs.
> > However, looking at the comment for dd_sum(), it also doesn't feel good
> > to rely on something that is "slightly outdated" to determine if we
> > should process a whole io class or not.
> > Letting requests wait for 10 seconds when there are no other outstandin=
g
> > requests in the scheduler doesn't seem like the right thing to do.
>=20
> The "slightly outdated" in that comment is not what causes the I/O delays=
 -
> these are caused by updating statistics in dd_finish_request() for reques=
ts
> that have not been seen by dd_insert_requests(). Please note that
> dd_insert_request() and dd_dispatch_request() access the I/O statistics
> while dd->lock is held. Only dd_finish_request() updates the I/O statisti=
cs
> without holding dd->lock. So the dd_queued() call from inside
> dd_dispatch_request() can return a number that is too big but not a numbe=
r
> that is too small. Hence, I don't think that updating the I/O statistics
> without locking in the deadline scheduler can cause an I/O delay.
>=20
> Does the patch below help?
>=20
> Thanks,
>=20
> Bart.
>=20
>=20
> Subject: [PATCH] mq-deadline: Fix request accounting
>=20
> The block layer may call the I/O scheduler .finish_request() callback
> without having called the .insert_requests() callback. Make sure that the
> mq-deadline I/O statistics are correct if the block layer inserts an I/O
> request that bypasses the I/O scheduler. This patch prevents that lower
> priority I/O is delayed longer than necessary for mixed I/O priority
> workloads.
>=20
> Fixes: 08a9ad8bf607 ("block/mq-deadline: Add cgroup support")
> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline-main.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
> index 294be0c0db65..933be9c82ec4 100644
> --- a/block/mq-deadline-main.c
> +++ b/block/mq-deadline-main.c
> @@ -743,6 +743,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,
>  	blkcg =3D dd_blkcg_from_bio(rq->bio);
>  	ddcg_count(blkcg, inserted, ioprio_class);
>  	rq->elv.priv[0] =3D blkcg;
> +	rq->elv.priv[1] =3D (void *)(uintptr_t)1;
>=20
>  	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
>  		blk_mq_free_requests(&free);
> @@ -795,6 +796,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *=
hctx,
>  static void dd_prepare_request(struct request *rq)
>  {
>  	rq->elv.priv[0] =3D NULL;
> +	rq->elv.priv[1] =3D NULL;
>  }
>=20
>  /*
> @@ -822,8 +824,16 @@ static void dd_finish_request(struct request *rq)
>  	const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];
>  	struct dd_per_prio *per_prio =3D &dd->per_prio[prio];
>=20
> -	dd_count(dd, completed, prio);
> -	ddcg_count(blkcg, completed, ioprio_class);
> +	/*
> +	 * The block layer core may call dd_finish_request() without having
> +	 * called dd_insert_requests(). Hence only update statistics for
> +	 * requests for which dd_insert_requests() has been called. See also
> +	 * blk_mq_request_bypass_insert().
> +	 */
> +	if (rq->elv.priv[1]) {
> +		dd_count(dd, completed, prio);
> +		ddcg_count(blkcg, completed, ioprio_class);
> +	}
>=20
>  	if (blk_queue_is_zoned(q)) {
>  		unsigned long flags;

Hello Bart,


Thank you for your patch!
I tested it, and it does solve my problem.

I've been thinking more about this problem.
The problem is seen on a SATA zoned drive.

These drives have mq-deadline set as default by the
blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE) call in
drivers/scsi/sd_zbc.c:sd_zbc_read_zones()

This triggers block/elevator.c:elevator_init_mq() to initialize
"mq-deadline" as default scheduler for these devices.

I think that the problem might because that drivers/scsi/sd_zbc.c
has created the request_queue and submitted requests, before the call
to elevator_init_mq() is done.

elevator_init_mq() will set q->elevator->type->ops, so once that is set,
blk_mq_free_request() will call e->type->ops.finish_request(rq),
regardless if the request was inserted through the recently initialized
scheduler or not.

While I'm perfectly happy with your fix, would it perhaps be possible
to do the fix in block/elevator.c instead, so that we don't need to
do the same type of check that you did, in each and every single
io scheduler?

Looking at block/elevator.c:elevator_init_mq(), it seems to do:

blk_mq_freeze_queue()
blk_mq_quiesce_queue()

blk_mq_init_sched()

blk_mq_unquiesce_queue()
blk_mq_unfreeze_queue()

This obviously isn't enough to avoid the bug that we are seeing,
but could perhaps a more general fix be to flush/wait until all
in-flight requests have completed, and then free them, and then
set q->elevator->type->ops. That way, all requests inserted after
the io scheduler has been initialized, will have gone through the
io scheduler. So all finish_request() calls should have a
matching insert_request() call. What do you think?


Kind regards,
Niklas=
