Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BAAC47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 05:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1F6610A2
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 05:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhFIFFS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 01:05:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45141 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhFIFFR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 01:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623215004; x=1654751004;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=n/NwhgsS2Kp/QWMw/oL8Y9hIJbQHZD7MK8VbXfKszDU=;
  b=fa/8uuJWV7AwdQJd+dm62iBiqi1MvDGhE1zjZcHjVV+Ld0HSwR7mpTLY
   h8/DXFgPtCDi746WUxX1AWcrXJ3y/ehJMCqafcR8i2kLNIT/3HbslRNR5
   8RShR5IxMW/IFELGqR7EaqeolzXiFh89tuzoVKBZ4K3D1yig4hqghmSMS
   Ip7Vo/FyO8uOy9Cv1NQJY1hK4a8Gtd5rTDqyMYsiqdAGXe9QagQoBFBcW
   vIDmfHiyhytGiQsLDByxIkc0h98lNTbgXdQmthO3sA7bGWLdwSHNblew4
   ts1bPV/ekMUTgiUvgfxzFuazobmLCytwtPl4SpTQXPhEyqs6MU/y68+4D
   g==;
IronPort-SDR: 87HQ8zmMtmGSTmpRPtBYxsjfAAg3UI7Pgd6SIzx0og1QZC13U1Z2OaKEpgCo5w3OaiJTXB8QOR
 U9FlP3pMVuigvbPXLsedp+riekmXVlDl/chg31JBWKU3tMeWeAp9umJtnUbEnB0v86a/vCaaly
 876n7PaqPt2pX99JoaGyvrbnKQAS9qBI27iIHiProJzgKvdbOT0K5d/YTA5OQzPJYqChmpVnLj
 vVBEupKqF5bWxheTXOTig4yals2WYY9PtAaD3u8uuMiU/Ri2J2jzi3SXl/lssZ5pb2q/q2I/sO
 FY0=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="282685878"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 13:03:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lv72KlciwKdpq6JQxGlsxGI9FcBZZ/OgLWKzpGko2RBBowaBg6JyP+8S+LtwTR0BnWk3so9BPVCmdq14qbAEXj4Nd6f4sQsOiXO7xjj9RQkrXWEXNAhfIS7oTnKExjpAvmaiu9pk+p8uY6b1nGOXp3wYMCNfZa+suyQLper2ed06Xv0kPuGaKlf9H2yh3fqjlGO0KgiM9p9DWWS6cJALoa9vrliF/Uf5Pc1cphDbCfJndtAj1IeSvWDtEDzLR2564iTM4PiQJg7hAhybhwzz2pZkZCxIdTdXvaEymNidHniGxM1JqwsSGep9j4zJv7M27NqOzwKe68BED9+borYmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRBZGxcq7Wcp2Gc2upjxuxBvB5WI8pWS2Fwg1GuEwA4=;
 b=InTvH3b/5OiGzrQfjFEv1hVlaTTJQYDd/bg7kzlw/rQpHkXaz0/VfOOwJ4kiKRAjPLE6n8EOq4umLei7yC7+F9N3GuIbGO2EOfO8lgO4XtjJEBuk4GXeDfGM4O4qPOXQwQaju+0TC2CjZ1uLtziYvyy6wtN2M56cMnlk8GgtLcUpZkdXioprKy+z9DoDati0DYTWIAnq27Ibq8HxIyLY5Dpk4Nd3yLrvQPIIdHwUOfgtsR6zwBNUTwL64SxqYilUzOx65KJGeB793WZdyKL1V5S9qx9GUG5+Y/dfGhocWARYe4r68JUcjaeTiR2Lf7wosquM990EC+JLzNCQGFUvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRBZGxcq7Wcp2Gc2upjxuxBvB5WI8pWS2Fwg1GuEwA4=;
 b=BAuT/wQuzQkdVUTzYDtljLL1E03ubO3bn2uUY3LVsBvl7pPSLG2ELzbQcEZ8Uij1oPF4aBZXSacQTSXzXY2j7Bpbef8LD8wA35BuG8V/WL5Z8xa8Y6704DwZzEiaoy6jDFLTo1VjgYk4WFNw2mfjeOj0Z0xPeaeGCVgzIED+l2s=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0250.namprd04.prod.outlook.com (2603:10b6:3:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 05:03:21 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 05:03:21 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 12/14] block/mq-deadline: Add I/O priority support
Thread-Topic: [PATCH 12/14] block/mq-deadline: Add I/O priority support
Thread-Index: AQHXXLsQrNfwnSgnmUyY0OBm4aL5wQ==
Date:   Wed, 9 Jun 2021 05:03:21 +0000
Message-ID: <DM6PR04MB70818D0058A0B1249AC7EBFCE7369@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-13-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:513e:a3fe:98aa:a7ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61b57cb0-fc7f-44fe-e78b-08d92b03e776
x-ms-traffictypediagnostic: DM5PR04MB0250:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR04MB02509E61F9C6E79A9EE3FC7AE7369@DM5PR04MB0250.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sKCuNXJXK0MedwxiwzNdLNBzII3wmeqUNk8b7B/1fZsD5xvBcsnEn8GA5f7qYOwjRz2ALda20qUY81GZo3mBQ/FuI+9suaPqqvjAC+nVBKLyowfMIJTLt8t3PiXTMPkFPoDQ6CQhMpwj9QGe17HekOTWpOoR0P8nGh5umhVnToMtb7jC4QW+jY9cF3GATEdq7kKbyPfg/z3GEAyhXjQ2Y4fymhmvxJjDMrWEgw3qPvJ210sgGzRM4ajj8R/ul4pxTLKgkxbZGMeR+Fesf4XAaNl51PoWb8ZBWSeMki78LV39ozuZmJqLJV/kXZ8vWp0y+tOyxJRRKrI4DvdrvUtUIHN0CjfB4dWu6+eBh4R3yPBQy5vnyt35NJ7FOC39AsNd2CnjTBngM/UO1YfRQiMNxUBVUkqgVYIxSi/Bd4KBQPKuYnGcTio8G6SFGoEEDiKbjqGnGvfCgrp667QNVD7v7VOAjCbSGk8hSZUCqs1nkxtCWlo6DDOjIueuX78Vqejru7MhCY+U+xJFPbAssA8sspluNl4MkYsSm4xZC+HxBfMU//sgF+jZu2FqOYonZjbed8p54BdALq/4obxpFI300gzvDf4CqqLedLbO/MIBX5s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(38100700002)(122000001)(8676002)(8936002)(2906002)(30864003)(66556008)(52536014)(66476007)(91956017)(71200400001)(66946007)(66446008)(4326008)(7696005)(53546011)(110136005)(54906003)(6506007)(316002)(86362001)(83380400001)(186003)(64756008)(76116006)(33656002)(5660300002)(478600001)(9686003)(55016002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FWM2vpA5FYWqo6vJtKMDiVDI+EBZREQoq6+GZGeBscee/ax/jkaaMOSIdrLJ?=
 =?us-ascii?Q?unJ9lX+G2aC3OhJ33/66dWJgsa84n7QOHcz/hHXuHbKYpy8F7sfSsi9uqzDK?=
 =?us-ascii?Q?j9iemUl4/lgY6b6bYl7bznszUvDTK/8Qo0sLVhtlKvzErHCS99kPDQrUZDn7?=
 =?us-ascii?Q?SiOFGIT1j1wWJ/Jkp5ffqXlJ/qUIJzAq0lp4bzGlLk63F0XoIDWysxJoXbZ/?=
 =?us-ascii?Q?0xnZ+oJ8o7bAuXK2BvQEzBIL7eEZ5rSho8qlNtilB8gHiLRwju7huhBsuh51?=
 =?us-ascii?Q?7uWEFiCx1GhMlzMDWHKFQ7/dUodQ8vjq/OxPKuLt+gJluZLprehlAsp2A3nm?=
 =?us-ascii?Q?7DsMPmwnhtI5hSxiUYiwceyf+gpFJCFHHTr0LCl2kyMpvIZcDm+2vsA7oQWd?=
 =?us-ascii?Q?yxAoYK5Oar9y3FtIIF/uTEDIRzt97JPHFAD79DCHwYn7Kj/m+y2ocwzA595E?=
 =?us-ascii?Q?ezDC0oV1iWrHF3CEmGPvKvczIc20K0T2pU0zHds7ZAxZpLDNirpJyMcie7KP?=
 =?us-ascii?Q?XC2KaJDH1Lj34ImCP3wweu4ehZn2mcD/GAY89/fMI3R5i8NwNLmZHa2pXgru?=
 =?us-ascii?Q?iks5mCUImuQeNPwp57bv+nWs1GS2esFEXjHv1NE9XkUQtCC9vf5ImHsPzTBA?=
 =?us-ascii?Q?OIm3hvh3ownMXfU2rOXCkZN0zlGkvWRngbR+/bPKdFVJuCbso4Z7la9ilJin?=
 =?us-ascii?Q?OPa7hxBhCquhMZ4oKEYYCTxk4tNH6yvq6k+0L/WFSxJ0EHpBhI+tphk/x699?=
 =?us-ascii?Q?O2ee2mrz6gO8HidzuBWp+GvPKxh8aIM2btpCHoSOV9tVQEJQDLVfPftllWVO?=
 =?us-ascii?Q?D5FkCAGWwUpORXv7LRLgh7b8nI2GntbSUugw1jFKVyzm9WQ6NOLoPK+r75u8?=
 =?us-ascii?Q?hhYJInZB6yDlq5LE5blMwWf99NIUA5B0Ku4N+oLSt6xBnHW5Vd3Ne6BU2g9z?=
 =?us-ascii?Q?s9hqe2ckt/edsANgSqTwI2xu/drdaM494Kp41gv6VQooE7tEfG6jgFbixGbv?=
 =?us-ascii?Q?XqpHKpP5uxRhzu5ltukIANyqC1wmUWVFf1+/PftWQQAxIryzdEm/87q6i0eb?=
 =?us-ascii?Q?AIuMk23xqqWkGq6uMz9AeYf3rSvJFRQ4+qWuocXUDuzIQjNRH5P3ljHmxD9p?=
 =?us-ascii?Q?fxj+I8/XSrRUw/zWF6907vP4w/yMcvwVENLZnpUlzu+RL/soUzKQ0NSMf/T/?=
 =?us-ascii?Q?h6k5hKXeHVMN8rrX7Sc5Lyc/VUkN1ds9wT9dNkBObwZJxXLyKljIz72OmXft?=
 =?us-ascii?Q?Ys3OtLbpR4tARh+RTU3JIUt+BdqyO4YufhzIk0udEC7l/d51xaFLOmJgiCbB?=
 =?us-ascii?Q?72HSF9rfmQCl3aWqnIY/uz/JmEw3KBGYKXR46/a1VXIHXQveL4RB2KIl3H18?=
 =?us-ascii?Q?wh7NcT9DJLWkpEHywhsTFwb78nqn2MQ7FvwReyCu/4yI3flyQQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b57cb0-fc7f-44fe-e78b-08d92b03e776
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 05:03:21.6109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QhYtsFGW/t72ilJfHkL9KposKvV01ZfQCQdLRJqV6NgXM3j8hWh6luyaqbv8VcUarFlhDGuSxbZMS/6KMfX06Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0250
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/09 8:07, Bart Van Assche wrote:=0A=
> Maintain one dispatch list and FIFO one list per I/O priority class: RT, =
BE=0A=
=0A=
s/FIFO one/one FIFO=0A=
=0A=
> and IDLE. Maintain statistics for each priority level. Split the debugfs=
=0A=
> attributes per priority level as follows:=0A=
> =0A=
> $ ls /sys/kernel/debug/block/.../sched/=0A=
> async_depth  dispatch2        read_next_rq      write2_fifo_list=0A=
> batching     read0_fifo_list  starved           write_next_rq=0A=
> dispatch0    read1_fifo_list  write0_fifo_list=0A=
> dispatch1    read2_fifo_list  write1_fifo_list=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Hannes Reinecke <hare@suse.de>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline.c | 355 ++++++++++++++++++++++++++++++++++----------=
=0A=
>  1 file changed, 279 insertions(+), 76 deletions(-)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index a7d0584437d1..776ff49713c3 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -42,16 +42,40 @@ enum dd_data_dir {=0A=
>  =0A=
>  enum { DD_DIR_COUNT =3D 2 };=0A=
>  =0A=
> +enum dd_prio {=0A=
> +	DD_RT_PRIO	=3D 0,=0A=
> +	DD_BE_PRIO	=3D 1,=0A=
> +	DD_IDLE_PRIO	=3D 2,=0A=
> +	DD_PRIO_MAX	=3D 2,=0A=
> +};=0A=
> +=0A=
> +enum { DD_PRIO_COUNT =3D 3 };=0A=
> +=0A=
> +/* I/O statistics per I/O priority. */=0A=
> +struct io_stats_per_prio {=0A=
> +	local_t inserted;=0A=
> +	local_t merged;=0A=
> +	local_t dispatched;=0A=
> +	local_t completed;=0A=
> +};=0A=
> +=0A=
> +/* I/O statistics for all I/O priorities (enum dd_prio). */=0A=
> +struct io_stats {=0A=
> +	struct io_stats_per_prio stats[DD_PRIO_COUNT];=0A=
> +};=0A=
> +=0A=
>  struct deadline_data {=0A=
>  	/*=0A=
>  	 * run time data=0A=
>  	 */=0A=
>  =0A=
>  	/*=0A=
> -	 * requests (deadline_rq s) are present on both sort_list and fifo_list=
=0A=
> +	 * Requests are present on both sort_list[] and fifo_list[][]. The=0A=
> +	 * first index of fifo_list[][] is the I/O priority class (DD_*_PRIO).=
=0A=
> +	 * The second index is the data direction (rq_data_dir(rq)).=0A=
>  	 */=0A=
>  	struct rb_root sort_list[DD_DIR_COUNT];=0A=
> -	struct list_head fifo_list[DD_DIR_COUNT];=0A=
> +	struct list_head fifo_list[DD_PRIO_COUNT][DD_DIR_COUNT];=0A=
=0A=
WOuld it make sense to pack these 2 into a sub structure ? e.g.:=0A=
=0A=
struct deadline_lists {=0A=
	struct rb_root sort_list;=0A=
	struct list_head fifo_list[DD_PRIO_COUNT];=0A=
};=0A=
=0A=
struct deadline_data {=0A=
	...=0A=
	/*=0A=
	 * Requests are present on both sort_list[] and fifo_list[][]. The=0A=
	 * first index of fifo_list[][] is the I/O priority class (DD_*_PRIO).=0A=
	 * The second index is the data direction (rq_data_dir(rq)).=0A=
 	 */=0A=
	struct deadline_lists	lists[DD_DIR_COUNT];=0A=
=0A=
>  =0A=
>  	/*=0A=
>  	 * next in sort order. read, write or both are NULL=0A=
> @@ -60,6 +84,8 @@ struct deadline_data {=0A=
>  	unsigned int batching;		/* number of sequential requests made */=0A=
>  	unsigned int starved;		/* times reads have starved writes */=0A=
>  =0A=
> +	struct io_stats __percpu *stats;=0A=
> +=0A=
>  	/*=0A=
>  	 * settings that change how the i/o scheduler behaves=0A=
>  	 */=0A=
> @@ -71,7 +97,42 @@ struct deadline_data {=0A=
>  =0A=
>  	spinlock_t lock;=0A=
>  	spinlock_t zone_lock;=0A=
> -	struct list_head dispatch;=0A=
> +	struct list_head dispatch[DD_PRIO_COUNT];=0A=
> +};=0A=
> +=0A=
> +/* Count one event of type 'event_type' and with I/O priority 'prio' */=
=0A=
> +#define dd_count(dd, event_type, prio) do {				\=0A=
> +	struct io_stats *io_stats =3D get_cpu_ptr((dd)->stats);		\=0A=
> +									\=0A=
> +	BUILD_BUG_ON(!__same_type((dd), struct deadline_data *));	\=0A=
> +	BUILD_BUG_ON(!__same_type((prio), enum dd_prio));		\=0A=
> +	local_inc(&io_stats->stats[(prio)].event_type);			\=0A=
> +	put_cpu_ptr(io_stats);						\=0A=
> +} while (0)=0A=
> +=0A=
> +/*=0A=
> + * Returns the total number of dd_count(dd, event_type, prio) calls acro=
ss all=0A=
> + * CPUs. No locking or barriers since it is fine if the returned sum is =
slightly=0A=
> + * outdated.=0A=
> + */=0A=
> +#define dd_sum(dd, event_type, prio) ({					\=0A=
> +	unsigned int cpu;						\=0A=
> +	u32 sum =3D 0;							\=0A=
> +									\=0A=
> +	BUILD_BUG_ON(!__same_type((dd), struct deadline_data *));	\=0A=
> +	BUILD_BUG_ON(!__same_type((prio), enum dd_prio));		\=0A=
> +	for_each_present_cpu(cpu)					\=0A=
> +		sum +=3D local_read(&per_cpu_ptr((dd)->stats, cpu)->	\=0A=
> +				  stats[(prio)].event_type);		\=0A=
> +	sum;								\=0A=
> +})=0A=
> +=0A=
> +/* Maps an I/O priority class to a deadline scheduler priority. */=0A=
> +static const enum dd_prio ioprio_class_to_prio[] =3D {=0A=
> +	[IOPRIO_CLASS_NONE]	=3D DD_BE_PRIO,=0A=
> +	[IOPRIO_CLASS_RT]	=3D DD_RT_PRIO,=0A=
> +	[IOPRIO_CLASS_BE]	=3D DD_BE_PRIO,=0A=
> +	[IOPRIO_CLASS_IDLE]	=3D DD_IDLE_PRIO,=0A=
>  };=0A=
>  =0A=
>  static inline struct rb_root *=0A=
> @@ -147,12 +208,31 @@ static void dd_request_merged(struct request_queue =
*q, struct request *req,=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Returns the I/O priority class (IOPRIO_CLASS_*) that has been assigne=
d to a=0A=
> + * request.=0A=
> + */=0A=
> +static u8 dd_rq_ioclass(struct request *rq)=0A=
> +{=0A=
> +	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * Callback function that is invoked after @next has been merged into @r=
eq.=0A=
>   */=0A=
>  static void dd_merged_requests(struct request_queue *q, struct request *=
req,=0A=
>  			       struct request *next)=0A=
>  {=0A=
> +	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
> +	const u8 ioprio_class =3D dd_rq_ioclass(next);=0A=
> +	const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];=0A=
> +=0A=
> +	if (next->elv.priv[0]) {=0A=
> +		dd_count(dd, merged, prio);=0A=
> +	} else {=0A=
> +		WARN_ON_ONCE(true);=0A=
> +	}=0A=
=0A=
No need for the curly brackets I think.=0A=
=0A=
> +=0A=
>  	/*=0A=
>  	 * if next expires before rq, assign its expire time to rq=0A=
>  	 * and move into next position (next will be deleted) in fifo=0A=
> @@ -189,14 +269,21 @@ deadline_move_request(struct deadline_data *dd, str=
uct request *rq)=0A=
>  	deadline_remove_request(rq->q, rq);=0A=
>  }=0A=
>  =0A=
> +/* Number of requests queued for a given priority level. */=0A=
> +static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)=0A=
> +{=0A=
> +	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);=0A=
=0A=
This also includes requests that are being executed on the device. Is that =
OK ?=0A=
=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * deadline_check_fifo returns 0 if there are no expired requests on the=
 fifo,=0A=
>   * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])=0A=
>   */=0A=
>  static inline int deadline_check_fifo(struct deadline_data *dd,=0A=
> +				      enum dd_prio prio,=0A=
>  				      enum dd_data_dir data_dir)=0A=
>  {=0A=
> -	struct request *rq =3D rq_entry_fifo(dd->fifo_list[data_dir].next);=0A=
> +	struct request *rq =3D rq_entry_fifo(dd->fifo_list[prio][data_dir].next=
);=0A=
>  =0A=
>  	/*=0A=
>  	 * rq is expired!=0A=
> @@ -212,15 +299,16 @@ static inline int deadline_check_fifo(struct deadli=
ne_data *dd,=0A=
>   * dispatch using arrival ordered lists.=0A=
>   */=0A=
>  static struct request *=0A=
> -deadline_fifo_request(struct deadline_data *dd, enum dd_data_dir data_di=
r)=0A=
> +deadline_fifo_request(struct deadline_data *dd, enum dd_prio prio,=0A=
> +		      enum dd_data_dir data_dir)=0A=
>  {=0A=
>  	struct request *rq;=0A=
>  	unsigned long flags;=0A=
>  =0A=
> -	if (list_empty(&dd->fifo_list[data_dir]))=0A=
> +	if (list_empty(&dd->fifo_list[prio][data_dir]))=0A=
>  		return NULL;=0A=
>  =0A=
> -	rq =3D rq_entry_fifo(dd->fifo_list[data_dir].next);=0A=
> +	rq =3D rq_entry_fifo(dd->fifo_list[prio][data_dir].next);=0A=
>  	if (data_dir =3D=3D DD_READ || !blk_queue_is_zoned(rq->q))=0A=
>  		return rq;=0A=
>  =0A=
> @@ -229,7 +317,7 @@ deadline_fifo_request(struct deadline_data *dd, enum =
dd_data_dir data_dir)=0A=
>  	 * an unlocked target zone.=0A=
>  	 */=0A=
>  	spin_lock_irqsave(&dd->zone_lock, flags);=0A=
> -	list_for_each_entry(rq, &dd->fifo_list[DD_WRITE], queuelist) {=0A=
> +	list_for_each_entry(rq, &dd->fifo_list[prio][DD_WRITE], queuelist) {=0A=
>  		if (blk_req_can_dispatch_to_zone(rq))=0A=
>  			goto out;=0A=
>  	}=0A=
> @@ -245,7 +333,8 @@ deadline_fifo_request(struct deadline_data *dd, enum =
dd_data_dir data_dir)=0A=
>   * dispatch using sector position sorted lists.=0A=
>   */=0A=
>  static struct request *=0A=
> -deadline_next_request(struct deadline_data *dd, enum dd_data_dir data_di=
r)=0A=
> +deadline_next_request(struct deadline_data *dd, enum dd_prio prio,=0A=
> +		      enum dd_data_dir data_dir)=0A=
>  {=0A=
>  	struct request *rq;=0A=
>  	unsigned long flags;=0A=
> @@ -276,15 +365,18 @@ deadline_next_request(struct deadline_data *dd, enu=
m dd_data_dir data_dir)=0A=
>   * deadline_dispatch_requests selects the best request according to=0A=
>   * read/write expire, fifo_batch, etc=0A=
>   */=0A=
> -static struct request *__dd_dispatch_request(struct deadline_data *dd)=
=0A=
> +static struct request *__dd_dispatch_request(struct deadline_data *dd,=
=0A=
> +					     enum dd_prio prio)=0A=
>  {=0A=
>  	struct request *rq, *next_rq;=0A=
>  	enum dd_data_dir data_dir;=0A=
> +	u8 ioprio_class;=0A=
>  =0A=
>  	lockdep_assert_held(&dd->lock);=0A=
>  =0A=
> -	if (!list_empty(&dd->dispatch)) {=0A=
> -		rq =3D list_first_entry(&dd->dispatch, struct request, queuelist);=0A=
> +	if (!list_empty(&dd->dispatch[prio])) {=0A=
> +		rq =3D list_first_entry(&dd->dispatch[prio], struct request,=0A=
> +				      queuelist);=0A=
>  		list_del_init(&rq->queuelist);=0A=
>  		goto done;=0A=
>  	}=0A=
> @@ -292,9 +384,9 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)=0A=
>  	/*=0A=
>  	 * batches are currently reads XOR writes=0A=
>  	 */=0A=
> -	rq =3D deadline_next_request(dd, DD_WRITE);=0A=
> +	rq =3D deadline_next_request(dd, prio, DD_WRITE);=0A=
>  	if (!rq)=0A=
> -		rq =3D deadline_next_request(dd, DD_READ);=0A=
> +		rq =3D deadline_next_request(dd, prio, DD_READ);=0A=
>  =0A=
>  	if (rq && dd->batching < dd->fifo_batch)=0A=
>  		/* we have a next request are still entitled to batch */=0A=
> @@ -305,10 +397,10 @@ static struct request *__dd_dispatch_request(struct=
 deadline_data *dd)=0A=
>  	 * data direction (read / write)=0A=
>  	 */=0A=
>  =0A=
> -	if (!list_empty(&dd->fifo_list[DD_READ])) {=0A=
> +	if (!list_empty(&dd->fifo_list[prio][DD_READ])) {=0A=
>  		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_READ]));=0A=
>  =0A=
> -		if (deadline_fifo_request(dd, DD_WRITE) &&=0A=
> +		if (deadline_fifo_request(dd, prio, DD_WRITE) &&=0A=
>  		    (dd->starved++ >=3D dd->writes_starved))=0A=
>  			goto dispatch_writes;=0A=
>  =0A=
> @@ -321,7 +413,7 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)=0A=
>  	 * there are either no reads or writes have been starved=0A=
>  	 */=0A=
>  =0A=
> -	if (!list_empty(&dd->fifo_list[DD_WRITE])) {=0A=
> +	if (!list_empty(&dd->fifo_list[prio][DD_WRITE])) {=0A=
>  dispatch_writes:=0A=
>  		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_WRITE]));=0A=
>  =0A=
> @@ -338,14 +430,14 @@ static struct request *__dd_dispatch_request(struct=
 deadline_data *dd)=0A=
>  	/*=0A=
>  	 * we are not running a batch, find best request for selected data_dir=
=0A=
>  	 */=0A=
> -	next_rq =3D deadline_next_request(dd, data_dir);=0A=
> -	if (deadline_check_fifo(dd, data_dir) || !next_rq) {=0A=
> +	next_rq =3D deadline_next_request(dd, prio, data_dir);=0A=
> +	if (deadline_check_fifo(dd, prio, data_dir) || !next_rq) {=0A=
>  		/*=0A=
>  		 * A deadline has expired, the last request was in the other=0A=
>  		 * direction, or we have run out of higher-sectored requests.=0A=
>  		 * Start again from the request with the earliest expiry time.=0A=
>  		 */=0A=
> -		rq =3D deadline_fifo_request(dd, data_dir);=0A=
> +		rq =3D deadline_fifo_request(dd, prio, data_dir);=0A=
>  	} else {=0A=
>  		/*=0A=
>  		 * The last req was the same dir and we have a next request in=0A=
> @@ -370,6 +462,13 @@ static struct request *__dd_dispatch_request(struct =
deadline_data *dd)=0A=
>  	dd->batching++;=0A=
>  	deadline_move_request(dd, rq);=0A=
>  done:=0A=
> +	ioprio_class =3D dd_rq_ioclass(rq);=0A=
> +	prio =3D ioprio_class_to_prio[ioprio_class];=0A=
> +	if (rq->elv.priv[0]) {=0A=
> +		dd_count(dd, dispatched, prio);=0A=
> +	} else {=0A=
> +		WARN_ON_ONCE(true);=0A=
> +	}=0A=
=0A=
I do not think you need the curly brackets here.=0A=
=0A=
>  	/*=0A=
>  	 * If the request needs its target zone locked, do it.=0A=
>  	 */=0A=
> @@ -390,9 +489,14 @@ static struct request *dd_dispatch_request(struct bl=
k_mq_hw_ctx *hctx)=0A=
>  {=0A=
>  	struct deadline_data *dd =3D hctx->queue->elevator->elevator_data;=0A=
>  	struct request *rq;=0A=
> +	enum dd_prio prio;=0A=
>  =0A=
>  	spin_lock(&dd->lock);=0A=
> -	rq =3D __dd_dispatch_request(dd);=0A=
> +	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {=0A=
> +		rq =3D __dd_dispatch_request(dd, prio);=0A=
> +		if (rq)=0A=
> +			break;=0A=
> +	}=0A=
>  	spin_unlock(&dd->lock);=0A=
>  =0A=
>  	return rq;=0A=
> @@ -439,9 +543,14 @@ static int dd_init_hctx(struct blk_mq_hw_ctx *hctx, =
unsigned int hctx_idx)=0A=
>  static void dd_exit_sched(struct elevator_queue *e)=0A=
>  {=0A=
>  	struct deadline_data *dd =3D e->elevator_data;=0A=
> +	enum dd_prio prio;=0A=
> +=0A=
> +	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {=0A=
> +		WARN_ON_ONCE(!list_empty(&dd->fifo_list[prio][DD_READ]));=0A=
> +		WARN_ON_ONCE(!list_empty(&dd->fifo_list[prio][DD_WRITE]));=0A=
> +	}=0A=
>  =0A=
> -	BUG_ON(!list_empty(&dd->fifo_list[DD_READ]));=0A=
> -	BUG_ON(!list_empty(&dd->fifo_list[DD_WRITE]));=0A=
> +	free_percpu(dd->stats);=0A=
>  =0A=
>  	kfree(dd);=0A=
>  }=0A=
> @@ -453,20 +562,29 @@ static int dd_init_sched(struct request_queue *q, s=
truct elevator_type *e)=0A=
>  {=0A=
>  	struct deadline_data *dd;=0A=
>  	struct elevator_queue *eq;=0A=
> +	enum dd_prio prio;=0A=
> +	int ret =3D -ENOMEM;=0A=
>  =0A=
>  	eq =3D elevator_alloc(q, e);=0A=
>  	if (!eq)=0A=
> -		return -ENOMEM;=0A=
> +		return ret;=0A=
>  =0A=
>  	dd =3D kzalloc_node(sizeof(*dd), GFP_KERNEL, q->node);=0A=
> -	if (!dd) {=0A=
> -		kobject_put(&eq->kobj);=0A=
> -		return -ENOMEM;=0A=
> -	}=0A=
> +	if (!dd)=0A=
> +		goto put_eq;=0A=
> +=0A=
>  	eq->elevator_data =3D dd;=0A=
>  =0A=
> -	INIT_LIST_HEAD(&dd->fifo_list[DD_READ]);=0A=
> -	INIT_LIST_HEAD(&dd->fifo_list[DD_WRITE]);=0A=
> +	dd->stats =3D alloc_percpu_gfp(typeof(*dd->stats),=0A=
> +				     GFP_KERNEL | __GFP_ZERO);=0A=
> +	if (!dd->stats)=0A=
> +		goto free_dd;=0A=
> +=0A=
> +	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {=0A=
> +		INIT_LIST_HEAD(&dd->fifo_list[prio][DD_READ]);=0A=
> +		INIT_LIST_HEAD(&dd->fifo_list[prio][DD_WRITE]);=0A=
> +		INIT_LIST_HEAD(&dd->dispatch[prio]);=0A=
> +	}=0A=
>  	dd->sort_list[DD_READ] =3D RB_ROOT;=0A=
>  	dd->sort_list[DD_WRITE] =3D RB_ROOT;=0A=
>  	dd->fifo_expire[DD_READ] =3D read_expire;=0A=
> @@ -476,10 +594,16 @@ static int dd_init_sched(struct request_queue *q, s=
truct elevator_type *e)=0A=
>  	dd->fifo_batch =3D fifo_batch;=0A=
>  	spin_lock_init(&dd->lock);=0A=
>  	spin_lock_init(&dd->zone_lock);=0A=
> -	INIT_LIST_HEAD(&dd->dispatch);=0A=
>  =0A=
>  	q->elevator =3D eq;=0A=
>  	return 0;=0A=
> +=0A=
> +free_dd:=0A=
> +	kfree(dd);=0A=
> +=0A=
> +put_eq:=0A=
> +	kobject_put(&eq->kobj);=0A=
> +	return ret;=0A=
>  }=0A=
>  =0A=
>  /*=0A=
> @@ -539,6 +663,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,=0A=
>  	struct request_queue *q =3D hctx->queue;=0A=
>  	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
>  	const enum dd_data_dir data_dir =3D rq_data_dir(rq);=0A=
> +	u16 ioprio =3D req_get_ioprio(rq);=0A=
> +	u8 ioprio_class =3D IOPRIO_PRIO_CLASS(ioprio);=0A=
> +	enum dd_prio prio;=0A=
>  =0A=
>  	lockdep_assert_held(&dd->lock);=0A=
>  =0A=
> @@ -548,13 +675,18 @@ static void dd_insert_request(struct blk_mq_hw_ctx =
*hctx, struct request *rq,=0A=
>  	 */=0A=
>  	blk_req_zone_write_unlock(rq);=0A=
>  =0A=
> +	prio =3D ioprio_class_to_prio[ioprio_class];=0A=
> +	dd_count(dd, inserted, prio);=0A=
> +	WARN_ON_ONCE(rq->elv.priv[0]);=0A=
> +	rq->elv.priv[0] =3D (void *)1ULL;=0A=
> +=0A=
>  	if (blk_mq_sched_try_insert_merge(q, rq))=0A=
>  		return;=0A=
>  =0A=
>  	trace_block_rq_insert(rq);=0A=
>  =0A=
>  	if (at_head) {=0A=
> -		list_add(&rq->queuelist, &dd->dispatch);=0A=
> +		list_add(&rq->queuelist, &dd->dispatch[prio]);=0A=
>  	} else {=0A=
>  		deadline_add_rq_rb(dd, rq);=0A=
>  =0A=
> @@ -568,7 +700,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,=0A=
>  		 * set expire time and add to fifo list=0A=
>  		 */=0A=
>  		rq->fifo_time =3D jiffies + dd->fifo_expire[data_dir];=0A=
> -		list_add_tail(&rq->queuelist, &dd->fifo_list[data_dir]);=0A=
> +		list_add_tail(&rq->queuelist, &dd->fifo_list[prio][data_dir]);=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> @@ -592,12 +724,10 @@ static void dd_insert_requests(struct blk_mq_hw_ctx=
 *hctx,=0A=
>  	spin_unlock(&dd->lock);=0A=
>  }=0A=
>  =0A=
> -/*=0A=
> - * Nothing to do here. This is defined only to ensure that .finish_reque=
st=0A=
> - * method is called upon request completion.=0A=
> - */=0A=
> +/* Callback from inside blk_mq_rq_ctx_init(). */=0A=
>  static void dd_prepare_request(struct request *rq)=0A=
>  {=0A=
> +	rq->elv.priv[0] =3D NULL;=0A=
>  }=0A=
>  =0A=
>  /*=0A=
> @@ -619,26 +749,41 @@ static void dd_prepare_request(struct request *rq)=
=0A=
>  static void dd_finish_request(struct request *rq)=0A=
>  {=0A=
>  	struct request_queue *q =3D rq->q;=0A=
> +	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
> +	const u8 ioprio_class =3D dd_rq_ioclass(rq);=0A=
> +	const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];=0A=
> +=0A=
> +	if (rq->elv.priv[0])=0A=
> +		dd_count(dd, completed, prio);=0A=
>  =0A=
>  	if (blk_queue_is_zoned(q)) {=0A=
> -		struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
>  		unsigned long flags;=0A=
>  =0A=
>  		spin_lock_irqsave(&dd->zone_lock, flags);=0A=
>  		blk_req_zone_write_unlock(rq);=0A=
> -		if (!list_empty(&dd->fifo_list[DD_WRITE]))=0A=
> +		if (!list_empty(&dd->fifo_list[prio][DD_WRITE]))=0A=
>  			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);=0A=
>  		spin_unlock_irqrestore(&dd->zone_lock, flags);=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> +static bool dd_has_work_for_prio(struct deadline_data *dd, enum dd_prio =
prio)=0A=
> +{=0A=
> +	return !list_empty_careful(&dd->dispatch[prio]) ||=0A=
> +		!list_empty_careful(&dd->fifo_list[prio][DD_READ]) ||=0A=
> +		!list_empty_careful(&dd->fifo_list[prio][DD_WRITE]);=0A=
> +}=0A=
> +=0A=
>  static bool dd_has_work(struct blk_mq_hw_ctx *hctx)=0A=
>  {=0A=
>  	struct deadline_data *dd =3D hctx->queue->elevator->elevator_data;=0A=
> +	enum dd_prio prio;=0A=
> +=0A=
> +	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++)=0A=
> +		if (dd_has_work_for_prio(dd, prio))=0A=
> +			return true;=0A=
>  =0A=
> -	return !list_empty_careful(&dd->dispatch) ||=0A=
> -		!list_empty_careful(&dd->fifo_list[0]) ||=0A=
> -		!list_empty_careful(&dd->fifo_list[1]);=0A=
> +	return false;=0A=
>  }=0A=
>  =0A=
>  /*=0A=
> @@ -702,7 +847,7 @@ static struct elv_fs_entry deadline_attrs[] =3D {=0A=
>  };=0A=
>  =0A=
>  #ifdef CONFIG_BLK_DEBUG_FS=0A=
> -#define DEADLINE_DEBUGFS_DDIR_ATTRS(ddir, name)				\=0A=
> +#define DEADLINE_DEBUGFS_DDIR_ATTRS(prio, data_dir, name)		\=0A=
>  static void *deadline_##name##_fifo_start(struct seq_file *m,		\=0A=
>  					  loff_t *pos)			\=0A=
>  	__acquires(&dd->lock)						\=0A=
> @@ -711,7 +856,7 @@ static void *deadline_##name##_fifo_start(struct seq_=
file *m,		\=0A=
>  	struct deadline_data *dd =3D q->elevator->elevator_data;		\=0A=
>  									\=0A=
>  	spin_lock(&dd->lock);						\=0A=
> -	return seq_list_start(&dd->fifo_list[ddir], *pos);		\=0A=
> +	return seq_list_start(&dd->fifo_list[prio][data_dir], *pos);	\=0A=
>  }									\=0A=
>  									\=0A=
>  static void *deadline_##name##_fifo_next(struct seq_file *m, void *v,	\=
=0A=
> @@ -720,7 +865,7 @@ static void *deadline_##name##_fifo_next(struct seq_f=
ile *m, void *v,	\=0A=
>  	struct request_queue *q =3D m->private;				\=0A=
>  	struct deadline_data *dd =3D q->elevator->elevator_data;		\=0A=
>  									\=0A=
> -	return seq_list_next(v, &dd->fifo_list[ddir], pos);		\=0A=
> +	return seq_list_next(v, &dd->fifo_list[prio][data_dir], pos);	\=0A=
>  }									\=0A=
>  									\=0A=
>  static void deadline_##name##_fifo_stop(struct seq_file *m, void *v)	\=
=0A=
> @@ -737,22 +882,31 @@ static const struct seq_operations deadline_##name#=
#_fifo_seq_ops =3D {	\=0A=
>  	.next	=3D deadline_##name##_fifo_next,				\=0A=
>  	.stop	=3D deadline_##name##_fifo_stop,				\=0A=
>  	.show	=3D blk_mq_debugfs_rq_show,				\=0A=
> -};									\=0A=
> -									\=0A=
> +};=0A=
> +=0A=
> +#define DEADLINE_DEBUGFS_NEXT_RQ(data_dir, name)			\=0A=
>  static int deadline_##name##_next_rq_show(void *data,			\=0A=
>  					  struct seq_file *m)		\=0A=
>  {									\=0A=
>  	struct request_queue *q =3D data;					\=0A=
>  	struct deadline_data *dd =3D q->elevator->elevator_data;		\=0A=
> -	struct request *rq =3D dd->next_rq[ddir];				\=0A=
> +	struct request *rq =3D dd->next_rq[data_dir];			\=0A=
>  									\=0A=
>  	if (rq)								\=0A=
>  		__blk_mq_debugfs_rq_show(m, rq);			\=0A=
>  	return 0;							\=0A=
>  }=0A=
> -DEADLINE_DEBUGFS_DDIR_ATTRS(DD_READ, read)=0A=
> -DEADLINE_DEBUGFS_DDIR_ATTRS(DD_WRITE, write)=0A=
> +=0A=
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_RT_PRIO, DD_READ, read0)=0A=
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_RT_PRIO, DD_WRITE, write0)=0A=
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_BE_PRIO, DD_READ, read1)=0A=
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_BE_PRIO, DD_WRITE, write1)=0A=
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_IDLE_PRIO, DD_READ, read2)=0A=
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_IDLE_PRIO, DD_WRITE, write2)=0A=
> +DEADLINE_DEBUGFS_NEXT_RQ(DD_READ, read)=0A=
> +DEADLINE_DEBUGFS_NEXT_RQ(DD_WRITE, write)=0A=
>  #undef DEADLINE_DEBUGFS_DDIR_ATTRS=0A=
> +#undef DEADLINE_DEBUGFS_NEXT_RQ=0A=
>  =0A=
>  static int deadline_batching_show(void *data, struct seq_file *m)=0A=
>  {=0A=
> @@ -781,50 +935,99 @@ static int dd_async_depth_show(void *data, struct s=
eq_file *m)=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> -static void *deadline_dispatch_start(struct seq_file *m, loff_t *pos)=0A=
> -	__acquires(&dd->lock)=0A=
> +static int dd_queued_show(void *data, struct seq_file *m)=0A=
>  {=0A=
> -	struct request_queue *q =3D m->private;=0A=
> +	struct request_queue *q =3D data;=0A=
>  	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
>  =0A=
> -	spin_lock(&dd->lock);=0A=
> -	return seq_list_start(&dd->dispatch, *pos);=0A=
> +	seq_printf(m, "%u %u %u\n", dd_queued(dd, DD_RT_PRIO),=0A=
> +		   dd_queued(dd, DD_BE_PRIO),=0A=
> +		   dd_queued(dd, DD_IDLE_PRIO));=0A=
> +	return 0;=0A=
>  }=0A=
>  =0A=
> -static void *deadline_dispatch_next(struct seq_file *m, void *v, loff_t =
*pos)=0A=
> +/* Number of requests owned by the block driver for a given priority. */=
=0A=
> +static u32 dd_owned_by_driver(struct deadline_data *dd, enum dd_prio pri=
o)=0A=
>  {=0A=
> -	struct request_queue *q =3D m->private;=0A=
> -	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
> -=0A=
> -	return seq_list_next(v, &dd->dispatch, pos);=0A=
> +	return dd_sum(dd, dispatched, prio) + dd_sum(dd, merged, prio)=0A=
> +		- dd_sum(dd, completed, prio);=0A=
>  }=0A=
>  =0A=
> -static void deadline_dispatch_stop(struct seq_file *m, void *v)=0A=
> -	__releases(&dd->lock)=0A=
> +static int dd_owned_by_driver_show(void *data, struct seq_file *m)=0A=
>  {=0A=
> -	struct request_queue *q =3D m->private;=0A=
> +	struct request_queue *q =3D data;=0A=
>  	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
>  =0A=
> -	spin_unlock(&dd->lock);=0A=
> +	seq_printf(m, "%u %u %u\n", dd_owned_by_driver(dd, DD_RT_PRIO),=0A=
> +		   dd_owned_by_driver(dd, DD_BE_PRIO),=0A=
> +		   dd_owned_by_driver(dd, DD_IDLE_PRIO));=0A=
> +	return 0;=0A=
>  }=0A=
>  =0A=
> -static const struct seq_operations deadline_dispatch_seq_ops =3D {=0A=
> -	.start	=3D deadline_dispatch_start,=0A=
> -	.next	=3D deadline_dispatch_next,=0A=
> -	.stop	=3D deadline_dispatch_stop,=0A=
> -	.show	=3D blk_mq_debugfs_rq_show,=0A=
> -};=0A=
> +#define DEADLINE_DISPATCH_ATTR(prio)					\=0A=
> +static void *deadline_dispatch##prio##_start(struct seq_file *m,	\=0A=
> +					     loff_t *pos)		\=0A=
> +	__acquires(&dd->lock)						\=0A=
> +{									\=0A=
> +	struct request_queue *q =3D m->private;				\=0A=
> +	struct deadline_data *dd =3D q->elevator->elevator_data;		\=0A=
> +									\=0A=
> +	spin_lock(&dd->lock);						\=0A=
> +	return seq_list_start(&dd->dispatch[prio], *pos);		\=0A=
> +}									\=0A=
> +									\=0A=
> +static void *deadline_dispatch##prio##_next(struct seq_file *m,		\=0A=
> +					    void *v, loff_t *pos)	\=0A=
> +{									\=0A=
> +	struct request_queue *q =3D m->private;				\=0A=
> +	struct deadline_data *dd =3D q->elevator->elevator_data;		\=0A=
> +									\=0A=
> +	return seq_list_next(v, &dd->dispatch[prio], pos);		\=0A=
> +}									\=0A=
> +									\=0A=
> +static void deadline_dispatch##prio##_stop(struct seq_file *m, void *v)	=
\=0A=
> +	__releases(&dd->lock)						\=0A=
> +{									\=0A=
> +	struct request_queue *q =3D m->private;				\=0A=
> +	struct deadline_data *dd =3D q->elevator->elevator_data;		\=0A=
> +									\=0A=
> +	spin_unlock(&dd->lock);						\=0A=
> +}									\=0A=
> +									\=0A=
> +static const struct seq_operations deadline_dispatch##prio##_seq_ops =3D=
 { \=0A=
> +	.start	=3D deadline_dispatch##prio##_start,			\=0A=
> +	.next	=3D deadline_dispatch##prio##_next,			\=0A=
> +	.stop	=3D deadline_dispatch##prio##_stop,			\=0A=
> +	.show	=3D blk_mq_debugfs_rq_show,				\=0A=
> +}=0A=
> +=0A=
> +DEADLINE_DISPATCH_ATTR(0);=0A=
> +DEADLINE_DISPATCH_ATTR(1);=0A=
> +DEADLINE_DISPATCH_ATTR(2);=0A=
> +#undef DEADLINE_DISPATCH_ATTR=0A=
>  =0A=
> -#define DEADLINE_QUEUE_DDIR_ATTRS(name)						\=0A=
> -	{#name "_fifo_list", 0400, .seq_ops =3D &deadline_##name##_fifo_seq_ops=
},	\=0A=
> +#define DEADLINE_QUEUE_DDIR_ATTRS(name)					\=0A=
> +	{#name "_fifo_list", 0400,					\=0A=
> +			.seq_ops =3D &deadline_##name##_fifo_seq_ops}=0A=
> +#define DEADLINE_NEXT_RQ_ATTR(name)					\=0A=
>  	{#name "_next_rq", 0400, deadline_##name##_next_rq_show}=0A=
>  static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] =
=3D {=0A=
> -	DEADLINE_QUEUE_DDIR_ATTRS(read),=0A=
> -	DEADLINE_QUEUE_DDIR_ATTRS(write),=0A=
> +	DEADLINE_QUEUE_DDIR_ATTRS(read0),=0A=
> +	DEADLINE_QUEUE_DDIR_ATTRS(write0),=0A=
> +	DEADLINE_QUEUE_DDIR_ATTRS(read1),=0A=
> +	DEADLINE_QUEUE_DDIR_ATTRS(write1),=0A=
> +	DEADLINE_QUEUE_DDIR_ATTRS(read2),=0A=
> +	DEADLINE_QUEUE_DDIR_ATTRS(write2),=0A=
> +	DEADLINE_NEXT_RQ_ATTR(read),=0A=
> +	DEADLINE_NEXT_RQ_ATTR(write),=0A=
>  	{"batching", 0400, deadline_batching_show},=0A=
>  	{"starved", 0400, deadline_starved_show},=0A=
>  	{"async_depth", 0400, dd_async_depth_show},=0A=
> -	{"dispatch", 0400, .seq_ops =3D &deadline_dispatch_seq_ops},=0A=
> +	{"dispatch0", 0400, .seq_ops =3D &deadline_dispatch0_seq_ops},=0A=
> +	{"dispatch1", 0400, .seq_ops =3D &deadline_dispatch1_seq_ops},=0A=
> +	{"dispatch2", 0400, .seq_ops =3D &deadline_dispatch2_seq_ops},=0A=
> +	{"owned_by_driver", 0400, dd_owned_by_driver_show},=0A=
> +	{"queued", 0400, dd_queued_show},=0A=
>  	{},=0A=
>  };=0A=
>  #undef DEADLINE_QUEUE_DDIR_ATTRS=0A=
> @@ -874,6 +1077,6 @@ static void __exit deadline_exit(void)=0A=
>  module_init(deadline_init);=0A=
>  module_exit(deadline_exit);=0A=
>  =0A=
> -MODULE_AUTHOR("Jens Axboe");=0A=
> +MODULE_AUTHOR("Jens Axboe, Damien Le Moal and Bart Van Assche");=0A=
>  MODULE_LICENSE("GPL");=0A=
>  MODULE_DESCRIPTION("MQ deadline IO scheduler");=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
