Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3D1C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426C9613D3
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhE0Dep (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 23:34:45 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53880 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhE0Dep (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 23:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622086392; x=1653622392;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nkPVVCuPP3dabssplunxgDHYg74/Q0v7JdDxjdEyCDg=;
  b=Wz4mYmQVcgjvwI6NZw9AxTFPzOrcjfqwngreR9JALZB863yXRBq4jSaC
   5vxvBemcWI9EAJsacnGhzYAZVRWu0t1j4ZQriuqs7db8VZL3A+TJ0MR8f
   DE61AQgFbL3TxNVS5Olnw5Za/Rv8qWD7bSytSFMhLTYH5KwFMmbJL4xDq
   jMKVHFu4stTHqTbDSmw6N0MsS0UO/LHQOyyqoRhM9J0/MZW7lRsLoNFtQ
   14psdxHpF8afkG+K5EPziA3Hue7fae+84rkoIUCuDisv5jqRyZUYGFM1Q
   et4KHbj9gtpIsVEjmasUL0ae0EarE5phuencHctfuNu0W0UdKFP+gmYZg
   g==;
IronPort-SDR: D/ardbIsMeIP/Hv5TrITem2smNzM30ZI3vSDyD2l1flBktXu4sHCXO5a8vk+uAt8frj4VBQ04K
 afdE02hCOcxcioHsvoFSURr6j3d5vSSeoj68BpGn4BSAnjVcqS/lHAKaDEolxw3+Yf3LFC9dJW
 sDvqo8zT50yH/pyVs32eMZx/ZkUN8s304BYMuHLlWwvkLBXJPohm8NoQNzvD/5CpPRCmcsx42L
 DKT0FvN+jJ9YxBZ5XkSFoP8dVpO3yx13WEu8ZTEdq2eMOKXqZtprfn7Ym32I7x/5bJlCn7JFm7
 gQg=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="168889860"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 11:33:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6Hpwquy7MQ9ks0UCh/jCiZDIxGNGHrQ3VHABh8SN2p9o3k0ArxHlaZUYr5EymGaf+efSztF5i6A0Hg1yi6Q20JM3VubHXFXuDkiRN6tPgVCY7vt7yS+w8FIJprbi03Mzo72ACBzI/HZIwzSkZAlVb1L+nZRLVkvpO8HSEOEqijUGdPwQLn31tRFL0Y97MdT/5yZtYfiM15NAeLb0EiRNEhda5szWWK0Q4w1scHEvGoFpGZXoJwDnfUt2WdeUh5zo+8Udwx58GUAn7Cz6Lp4H01zXc+f0CQAsEebFcSzaLUsZOqYO3WIeczZt8KHLKTVpYGvB0wkpWW8OTp77bAzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kecGiuJy+x6QoneacmnpSvGeH6/gNE8YP5pmpRjwg6I=;
 b=X+3ENDLqQb2MYg5oDq/Ly26PYWGjxlC8AhE7ZBZ834cW2w4D3en1zD+ESCd5Hmok078deemZJ7WW4VOdkl3XIQEqmc5j3fFvJHhGHckYO/IrW/kLUwBzHDmfjPjQHrzthuQg/xslsRYpWnOsHMPR5kX5D+yY0kxMSWrcYL7UbTvsR71cfOXzVJDS/+EH7ltGSz0GTbPShJjYg8ywO54ruoKGJ3kfOS/wbtE0vNaxNhv+szex/uxNMU1N47IeTeMg85GEvEjNST2K6tpFNMehkkiuj7EBb/pCuK+XjH3Qik6Z08qONlCEgCtcr10eQClpdu7kAFsCUz1ss8niRi7ojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kecGiuJy+x6QoneacmnpSvGeH6/gNE8YP5pmpRjwg6I=;
 b=UwxFQc1H/oX19sS6zLX9B4zrL5Cw7LUqD7v4YsW2ep7aTszJPfOKoDUir6yvWQ+A3bHtH8ubdWPROSdIWyATqSgV8TuL9VqlF7E9ENimzFd5lgbh5PYSyKHyDMnl3oDHCbp9ftzb8O6c0rJkeOqFriH3fcAFiUxDUY9mbLmHb7s=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4347.namprd04.prod.outlook.com (2603:10b6:5:a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Thu, 27 May
 2021 03:33:10 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 03:33:10 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 7/9] block/mq-deadline: Reserve 25% of tags for
 synchronous requests
Thread-Topic: [PATCH 7/9] block/mq-deadline: Reserve 25% of tags for
 synchronous requests
Thread-Index: AQHXUpPoJJ9O2wpAS0uclnEqU+OQ/g==
Date:   Thu, 27 May 2021 03:33:10 +0000
Message-ID: <DM6PR04MB7081C21724FE9742E1A16C13E7239@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-8-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eee961e1-6cd7-421c-8388-08d920c026ce
x-ms-traffictypediagnostic: DM6PR04MB4347:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB434793D76C00E33A62FB1887E7239@DM6PR04MB4347.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 99x9WGXu0jDBZkBtTtjBNFo2hoXjf/pvwqOajDh0l9VpItsmNJDpIvwjW7w+1DZdJGyYmWWX8+78Om8sekbTcVlx9NK+TzFZAAzPL5bfKYYpU2KZqUcQDs2JAuQw7NPdk9AY9EIFAoH37zJEKuzf1b97Zr9FU05BNr8Ia5WVv0N81oXo9Zr41E5s+hQF/udRBPdzO9DfwrJbuJogOYyyCVl7/dRFt+2S55QOF79wo2MSBbXDJAfCsUUvb85UITv9GmqSNmOgvbLsSE6AQjc7EdtshrVdXCoyUdLGRNoqg2SQ0iLb5WGdxkTa00gw2X8hwke9Y8z31q/UO/Bca2tWXqsMd85HiHmZtzIGSOJJzfrnh0dBJyNa1BeELK7WPNYIzploqKRdUHjMuhRGex7AXLb1M+xxP95r/N+NA5KSmpW1NwAVlVplKs6uFDLGsXnoqGYmG0lIi3Emu1UXUU6ZwiX7uk95PT3QJ+eMacVCYcF0we5QvAPlOtzP98PfjVZMLpDKqnu9ptLFK2wf69XLUxiN1bSfgwgZRlzZCMqim0aAeN/ymNHnyZpssfEfb5kreah3vnh34+7/nWc6z9k6GkXxt9Mg+t+CLNeei1oKKwg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(122000001)(66946007)(52536014)(54906003)(110136005)(316002)(76116006)(4326008)(8936002)(26005)(33656002)(186003)(71200400001)(2906002)(6506007)(83380400001)(5660300002)(66556008)(53546011)(55016002)(64756008)(66476007)(9686003)(38100700002)(478600001)(7696005)(8676002)(66446008)(91956017)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N4N366xek0cJhg54BI7Udx0D2rMr+b6GEBRImWxhAhmpQ3XvTBvXqRsESz97?=
 =?us-ascii?Q?NrWbFznpXRWyKHIh/u26sx514Iw9K1JBq+Hqb3AEGVlQ09IxXTFi7vQ0pHft?=
 =?us-ascii?Q?xymtU+zTBS/MLDJ7LjgiDDXsfEi+eTf1fpgQ5jGwtROp8BYVIj307LrMVUOD?=
 =?us-ascii?Q?p2DWrtS6BqNRvkDayngBO0mSOc0SDLKTBlw5mjhqmYcNoSbxfDS+Y/4SWtyy?=
 =?us-ascii?Q?7Mx0O653n9oYFv5BBeeN6axyp2jq/p5wtN35U2OJAQGnocBNpGuYvlle97WK?=
 =?us-ascii?Q?67ZhWhj8Umv5XrELZaZ3OkAwZRDzcju7KaYc6Qv4UtB3+uKq+laTDE7vUiL3?=
 =?us-ascii?Q?ZZE6GsT8Emrex1d30IxJFsyU1o8+jYX/y/4rM2ysrespNhKzWylfWHTJ0os2?=
 =?us-ascii?Q?GhjdrJLsqWh7VkaZAAVomnZ3/gZVNeicSytTrHu5tzwOfk9mJFeOJO4fnoZq?=
 =?us-ascii?Q?oX7+fSmN5dEok1ymteZ7xORXN3UrgwNMD6Zz3p/7aAwiJaFVwxHkjwr8ORNL?=
 =?us-ascii?Q?p6xsnj7BcQmv+chy4E6N9qXwBA+1+Flzj6yrx+WiFmZGYBVerejy+q4l2N9S?=
 =?us-ascii?Q?v8GptoHhTqsfu3icYckapiMeUjsnRoMZetcqEoRIcWZ8zNQkfm426bR7z2gP?=
 =?us-ascii?Q?i6noLy4CaUlpFvR41XwDiS4yEJEpA9gPwBS9sQYsy0cVmCg60U1WABKvc2GX?=
 =?us-ascii?Q?AxvLrVRHgDEElXZ2nfNt7LAJ8RHek01Fenn2Au2ja/eaDDWHNv4+gvuCBEWc?=
 =?us-ascii?Q?SOFYgiMaozwqDf3jrlMX8SS9RpimS8YU8ZLDWAZtvbJTYeQdu3VokwtOp9A6?=
 =?us-ascii?Q?I8spvFhV6TvFsbgyDLNo7Anfi8fZJvKstDju+cE/wb9pDru4KGsTihUA0pzN?=
 =?us-ascii?Q?fUuxyJHmV5FIMmGziYwRCaxMibbw8yXnlfwWRKcD7ZtCp5mVENdTUYVOBHFT?=
 =?us-ascii?Q?nFwqu0+uKWJLxPobm5u9E2uUovLV8f2wOFOZO+HwXbBVKf2Ty8aqMBxJpHF7?=
 =?us-ascii?Q?zESGMs6ZXLYklPlvB93TlCbvdWoy82EzRbwnw3NhohLZJT1njKMQGlb6J5mz?=
 =?us-ascii?Q?lTo1KZJruDpQ38zkzfPnHdo+EuCy0Rp4G3N8GLGwXU/eN+3xOLgQzPJgvyeS?=
 =?us-ascii?Q?zOdGlTRRlcVL5eShpwEDGFY3xAfTGAd9ifh3ErCiim20i52q+KWHxNw+bUWS?=
 =?us-ascii?Q?0QnlCsfsFV34ZtNnueLhqfa8/hzKUCfQm0a5pEdOH7XwYV0DSf5y5zUjXkPt?=
 =?us-ascii?Q?ezSTHvdD2MMYgQqEHPpfHRj1ng22yotvqTj8zLif/VaXaa1aQ+O5JsUxs36b?=
 =?us-ascii?Q?ZnVJjJFDYDsztZ/jAN1r69OstNCwlG7qFNSru+ve/RBbgQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee961e1-6cd7-421c-8388-08d920c026ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 03:33:10.4522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PWCiwCAsgA4Vlyy/ewbUyti1CZnSCBZ78uJNqiUjEkJQwKUBiLNZLtsAQZzA/oIwBmZfk42nrVJz9ykzxpWEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4347
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/27 10:02, Bart Van Assche wrote:=0A=
> For interactive workloads it is important that synchronous requests are=
=0A=
> not delayed. Hence reserve 25% of tags for synchronous requests. This pat=
ch=0A=
=0A=
s/tags/scheduler tags=0A=
=0A=
to be clear that we are not talking about the device tags. Same in the patc=
h=0A=
title may be.=0A=
=0A=
> still allows asynchronous requests to fill the hardware queues since=0A=
> blk_mq_init_sched() makes sure that the number of scheduler requests is t=
he=0A=
> double of the hardware queue depth. From blk_mq_init_sched():=0A=
> =0A=
> 	q->nr_requests =3D 2 * min_t(unsigned int, q->tag_set->queue_depth,=0A=
> 				   BLKDEV_MAX_RQ);=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline.c | 46 +++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>  1 file changed, 46 insertions(+)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index 2ab844a4b6b5..81f487d77e09 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -69,6 +69,7 @@ struct deadline_data {=0A=
>  	int fifo_batch;=0A=
>  	int writes_starved;=0A=
>  	int front_merges;=0A=
> +	u32 async_depth;=0A=
>  =0A=
>  	spinlock_t lock;=0A=
>  	spinlock_t zone_lock;=0A=
> @@ -399,6 +400,38 @@ static struct request *dd_dispatch_request(struct bl=
k_mq_hw_ctx *hctx)=0A=
>  	return rq;=0A=
>  }=0A=
>  =0A=
> +static void dd_limit_depth(unsigned int op, struct blk_mq_alloc_data *da=
ta)=0A=
=0A=
Similarly as you did in patch 1, may be add a comment about this operation =
and=0A=
when it is called ?=0A=
=0A=
> +{=0A=
> +	struct deadline_data *dd =3D data->q->elevator->elevator_data;=0A=
> +=0A=
> +	/* Do not throttle synchronous reads. */=0A=
> +	if (op_is_sync(op) && !op_is_write(op))=0A=
> +		return;=0A=
> +=0A=
> +	/*=0A=
> +	 * Throttle asynchronous requests and writes such that these requests=
=0A=
> +	 * do not block the allocation of synchronous requests.=0A=
> +	 */=0A=
> +	data->shallow_depth =3D dd->async_depth;=0A=
> +}=0A=
> +=0A=
> +static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)=0A=
> +{=0A=
> +	struct request_queue *q =3D hctx->queue;=0A=
> +	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
> +	struct blk_mq_tags *tags =3D hctx->sched_tags;=0A=
> +=0A=
> +	dd->async_depth =3D 3 * q->nr_requests / 4;=0A=
=0A=
I think that nr_requests is always at least 2, but it may be good to have a=
=0A=
sanity check here that we do not end up with async_depth =3D=3D 0, no ?=0A=
=0A=
> +=0A=
> +	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, dd->async_depth);=0A=
> +}=0A=
> +=0A=
> +static int dd_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_id=
x)=0A=
> +{=0A=
> +	dd_depth_updated(hctx);=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>  static void dd_exit_sched(struct elevator_queue *e)=0A=
>  {=0A=
>  	struct deadline_data *dd =3D e->elevator_data;=0A=
> @@ -744,6 +777,15 @@ static int deadline_starved_show(void *data, struct =
seq_file *m)=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> +static int dd_async_depth_show(void *data, struct seq_file *m)=0A=
> +{=0A=
> +	struct request_queue *q =3D data;=0A=
> +	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
> +=0A=
> +	seq_printf(m, "%u\n", dd->async_depth);=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>  static void *deadline_dispatch_start(struct seq_file *m, loff_t *pos)=0A=
>  	__acquires(&dd->lock)=0A=
>  {=0A=
> @@ -786,6 +828,7 @@ static const struct blk_mq_debugfs_attr deadline_queu=
e_debugfs_attrs[] =3D {=0A=
>  	DEADLINE_QUEUE_DDIR_ATTRS(write),=0A=
>  	{"batching", 0400, deadline_batching_show},=0A=
>  	{"starved", 0400, deadline_starved_show},=0A=
> +	{"async_depth", 0400, dd_async_depth_show},=0A=
>  	{"dispatch", 0400, .seq_ops =3D &deadline_dispatch_seq_ops},=0A=
>  	{},=0A=
>  };=0A=
> @@ -794,6 +837,8 @@ static const struct blk_mq_debugfs_attr deadline_queu=
e_debugfs_attrs[] =3D {=0A=
>  =0A=
>  static struct elevator_type mq_deadline =3D {=0A=
>  	.ops =3D {=0A=
> +		.depth_updated		=3D dd_depth_updated,=0A=
> +		.limit_depth		=3D dd_limit_depth,=0A=
>  		.insert_requests	=3D dd_insert_requests,=0A=
>  		.dispatch_request	=3D dd_dispatch_request,=0A=
>  		.prepare_request	=3D dd_prepare_request,=0A=
> @@ -807,6 +852,7 @@ static struct elevator_type mq_deadline =3D {=0A=
>  		.has_work		=3D dd_has_work,=0A=
>  		.init_sched		=3D dd_init_sched,=0A=
>  		.exit_sched		=3D dd_exit_sched,=0A=
> +		.init_hctx		=3D dd_init_hctx,=0A=
>  	},=0A=
>  =0A=
>  #ifdef CONFIG_BLK_DEBUG_FS=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
