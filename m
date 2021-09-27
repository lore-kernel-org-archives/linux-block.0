Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10F1C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 15:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8168A60F94
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 15:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhI0Pzd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 11:55:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41819 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbhI0Pzc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 11:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632758034; x=1664294034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SMy/e+KjVspCHnGRWRFRAJqjP566pQedr8CXY/DEuQE=;
  b=e4algD3E1bUGtflHdcQ/3m3fqJsyuf7dKBlPknVLU/5omSt/ZhdWazaU
   AP3STogbZbGbvGu1S9af/ifJzjoZmfp2v4Z/Y5BCfkRsRobkGd2DHCKLN
   qFOFcMMJivWh9LvqasOoovOKc0qmjBJ3NxqT3i7hTrkCP3ef/HUg0o3L+
   xzgB/v+OdmPOa+lpTFlT/4cRnpqRQG5zsBW77yjuOtXDoaUYQ7E7x9e1b
   I6Bx0jPYQutqUQ8lx1I570EodaIAD1SIwrfTIfSLFce5KzVWDVOBk4k0A
   NzPC5VW5RBgqYPnd6R0gdvnZkaTMS/RFXZjw1oFokB39hdlf+Jb9sSmlG
   g==;
X-IronPort-AV: E=Sophos;i="5.85,326,1624291200"; 
   d="scan'208";a="185871159"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 23:53:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAKGaAvQBD/NESL33wuPD9x4fWC3XGm2xWs1pQX+f4ntV1736YkQFMq7gfl/GUb8/Gggti7CVP1xC4UWBpuC2tLLteiQik/IypadKiGekiG8ER/t+mNDE+DjKuw315bnCB/gUvRL7yXR4YBFU/eYjku1TKLTETEch49weJ1bBWKiDH81vrjtH/fFQjcuSKh1FE0yYvRvAKhtiOy3z+XZPIUAIl1RqDSegCRqbimLe+IzR0lbFxEdyiWCmbKzlz/D/qcZzkLkmnZkko7E2LaEhbvvTs1pnFPAHAvYGjHOXl3wR6fAHPtba0F5rP6zDC6yZ5SU6dozswZRiQx9fCutyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wt9ML/FYOGW6diyGUQeGpYCPg7dKIadVsc4TlViQtXE=;
 b=JvXsifHBRamM7yIpOnLcUkqUtv7hTz48A9IG6lZCo3I0FNcdp8J6L93xwULrYTE7ssjVl60C+7WPqqNeCW3Xrl6o4EHvSWt7nDaNgtncoXrgayjvsOZNoNP4Pv+1XUN5EOlGGYi1PUR+IHghOKeircqSkpnswKI3d7+GBjFhrp+HBHGVNoTdB7hOSnHw8S5czy6uLEuT0CldjmNF6IY8pszgobob5P6/pusLtd6HlWGx0nPiutVS4sLxw6e4bbyG/0AXrixbGItS3/yrP/kq2PvH7CpdNardUky5zd3Izm7JcgyxwQGxhMbUqRSJ8jiKT2hWw3eQ39rhi/EMcCda5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt9ML/FYOGW6diyGUQeGpYCPg7dKIadVsc4TlViQtXE=;
 b=n1noSoq3oGsPSQj8QoneILDF4GW2DginCIJIQ4GxAMYv4qXXHIDQRe14X87qo0Sf9Xhy+CFc14+9Ftws9mbWhqZ7XhJXx1JETZNJyWcpSERPSscD0521EKUXcCzs5sHlIzFuez2lPTWIl+bres/7XHu+aI2HGPD9GNzbwmp4qXs=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7589.namprd04.prod.outlook.com (2603:10b6:510:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 15:53:52 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%6]) with mapi id 15.20.4544.022; Mon, 27 Sep 2021
 15:53:52 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/4] block/mq-deadline: Stop using per-CPU counters
Thread-Topic: [PATCH 3/4] block/mq-deadline: Stop using per-CPU counters
Thread-Index: AQHXsNKKyLQ5MztTIkKMav2PpWTRiKu4DhUA
Date:   Mon, 27 Sep 2021 15:53:51 +0000
Message-ID: <YVHpDuPRUXUXkb8/@x1-carbon>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
 <20210923232655.3907383-3-bvanassche@acm.org>
In-Reply-To: <20210923232655.3907383-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72593199-688f-497a-3bdf-08d981cf00ba
x-ms-traffictypediagnostic: PH0PR04MB7589:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB758950456D665FBD34AEA6D9F2A79@PH0PR04MB7589.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MioekaFE4y6walY0QQjKVQed5TGRo1A2xpG3YzAhNelcIMI8w+G9Azke5O4KZxaxdrOsRb9x5h37D2IzIMbYD2EytKKImKsRKRTt88dxMHc4zY94ZL3Hal+z6w2eJi2xLOlwLLsFu7K8sI2T9F79ZYzPNNedVDXZ/5JtQJ0E0mTK/c2uncHySSHZuN/hv0JZksTDboRzJAkoSe0JTeeKcsIYhX+NsDklepKQFpfimujzPL96lErMZh0phY4aNkQSK4ZMv+BJ00Xpt/7FzWNL/Pm+W8P5sleFvJbNFn+bQynx5qMeaWMPYVLXrU+AWr6t9g2n+Mwd+71HTVG6jXiLjlHxyHT+2rERs9p3XLcWW0LkR3d75BUHNdF2JRsh4nza5dyqEH9o1tRPahZNM08fsYu5K9IIT4OXQ6/sBomXgzpP6yVe5UgJoXJpWgOB6BrAf6jUrIIj33gqO8RyhBTQAMQkpfVVN53l0UE6nqHO4Fk7WLvO03708e1ynExwJPIXdjKS+dPd/Bd+qbuKKDiFWyUzlWu/POc668w0/ph7IoCpq7pTgcBwYY+F3KE902XBGAGspOuP1uJClkJ/ZBnB8K42tFwD02Vb6bddytnlg3Ysp38t6hAcX0r4Wr2iQy3vVyRJYtNOo5wkyKsRuOmmlkhHpD9Tn8mhHgYxqZpMzaDtXELq1Wk4JjcZT3u040Q1MIgoyA796ii4aDqL01hnPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(86362001)(6916009)(83380400001)(186003)(38070700005)(6486002)(71200400001)(54906003)(5660300002)(33716001)(9686003)(6512007)(2906002)(76116006)(8936002)(316002)(8676002)(38100700002)(122000001)(91956017)(64756008)(66476007)(66946007)(66556008)(66446008)(508600001)(4326008)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vvepVVGDg1zixV6/t4xy7PR+LLWlItRd4HjUD9gHA6GRHml3H7zZTwhaCh0J?=
 =?us-ascii?Q?pCdqHxL6SgBteE9AKisO0A6ww9k6A3RSmd7yf01UoDi4NE4pHIiMnqlBKZOC?=
 =?us-ascii?Q?mFm4vwMTX061F2uRU0XxAdiCW/Q/RBzGo6LuKqEFFpeN6k/YY8MPNJmi6t2c?=
 =?us-ascii?Q?liNNjiqX6OeH6CPdoRLraFh0algNTIHty10e9o2eENNlpXYDUgWjLaAA5G2S?=
 =?us-ascii?Q?gNtirz2+Dk967/VnnU3YD7Kn0+0C24IJIf+fGi/z/QAliMifJyjyJmeYEfHQ?=
 =?us-ascii?Q?nREwuN8Ps8apgM9y0nW+ZbloefCee9WMKba6EMO42yrntkICyHn634WX2Crv?=
 =?us-ascii?Q?zeQShvpqp66oSW8c9ZMCbC+oeJZlivxvxMwznmbMUOuBgtnnoUHaS5c0dF8L?=
 =?us-ascii?Q?eECyQw1fBHSTzdG0GpuM5YHv1QGnMP5xKEI5VLiW61tluwqiaY+Ub/eWA/ZZ?=
 =?us-ascii?Q?gTmTeTiVX71b0wbw4fTMATkDYuy4sgXzDKwITPHH8HafPtz7bR7dtcGZFCbi?=
 =?us-ascii?Q?IY6npAMriA4Wi782+8peP1v+K8fCPBNgt0XwJwu6mrtfzTwyOUoypvRDJWGg?=
 =?us-ascii?Q?eQ3387tbXmI4WXILjPuAKl2vDhITJJvnT5wf5l5anChAzVuokVXTWAIw9+CJ?=
 =?us-ascii?Q?9tTLwbNK1z8IL7EuLVJKFCVQO+8nIVFpJ8CGTGdP+XuulAgG51jB18YIMTsF?=
 =?us-ascii?Q?2S86Jft6qvghAGQuyXIeB3MOwi2KwhpbnQsNa0l9rj9Rmn9zPqKOlk2qGgjg?=
 =?us-ascii?Q?BsMdIQY1iRLF0cYBORrSc/i4SsW3wJH0K4TvaB3UGFSlc+/gH/Z8IuIp51u5?=
 =?us-ascii?Q?uqHy4Br14o6dvnsFFauPHHlS7WrQj/U3Wm82Tvqn8+NK/DD++Ver2WT6xB4R?=
 =?us-ascii?Q?dNLePM6do+oFXJrRleeitqnNdkj9i8uJ2FicbYNwXG4i3/fbzJtRQiL7p44j?=
 =?us-ascii?Q?nNNHh+EupG9cppkVY5mwXBjFPO7TiX79RvNlP0RpIDuYglWd2kMoLHz9xGXz?=
 =?us-ascii?Q?5avuQO6s7d/1J5fQQ8P8f3W77BclGc2IIvAVeb6LmRvaTqB5hIHkOLrDqm/z?=
 =?us-ascii?Q?i1AIsMl/+riTF92VT9lRJyRE9M9+fshASerHQpuneInO7d8ROBPXQw8cvyYD?=
 =?us-ascii?Q?JbdWxJyRO2TLC7TFE57lPOlwdX4+iQHtdokbNYyqzz5YODId/R/7CZz4ve43?=
 =?us-ascii?Q?pXeFlsIxQkH6CVH9427RoB/bFtfpuVXVH/0pUW6y7HP9NFkOIiyHF0TDF/Q2?=
 =?us-ascii?Q?rK4XVRrvdtDGeo5qrCUzCGR0iMbck9NnIqVg4EX0Zse5xbzVY7QlH4ZbbwRN?=
 =?us-ascii?Q?CWjD8zC9mx10ErdQgbaS32rIhrQTWNubN+l086+Jypj6yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BF4F8B9010C6242916B9A9EBCECFEBD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72593199-688f-497a-3bdf-08d981cf00ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 15:53:51.8232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLthYhMVlCkqI5Z6n20Xf4qfs9gtunCMSuLGw/Q3K4nDRBjb8Bb3NLqolHX6y7zIfzCFLvUAQULMPu2jGhPNNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7589
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 23, 2021 at 04:26:54PM -0700, Bart Van Assche wrote:
> Calculating the sum over all CPUs of per-CPU counters frequently is
> inefficient. Hence switch from per-CPU to individual counters. Three
> counters are protected by the mq-deadline spinlock since these are
> only accessed from contexts that already hold that spinlock. The fourth
> counter is atomic because protecting it with the mq-deadline spinlock
> would trigger lock contention.
>=20
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 124 ++++++++++++++++++++------------------------
>  1 file changed, 56 insertions(+), 68 deletions(-)
>=20
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 6deb4306bcf3..b0cfc84a4e6b 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -51,17 +51,16 @@ enum dd_prio {
> =20
>  enum { DD_PRIO_COUNT =3D 3 };
> =20
> -/* I/O statistics per I/O priority. */
> +/*
> + * I/O statistics per I/O priority. It is fine if these counters overflo=
w.
> + * What matters is that these counters are at least as wide as
> + * log2(max_outstanding_requests).
> + */
>  struct io_stats_per_prio {
> -	local_t inserted;
> -	local_t merged;
> -	local_t dispatched;
> -	local_t completed;
> -};
> -
> -/* I/O statistics for all I/O priorities (enum dd_prio). */
> -struct io_stats {
> -	struct io_stats_per_prio stats[DD_PRIO_COUNT];
> +	uint32_t inserted;
> +	uint32_t merged;
> +	uint32_t dispatched;
> +	atomic_t completed;
>  };
> =20
>  /*
> @@ -74,6 +73,7 @@ struct dd_per_prio {
>  	struct list_head fifo_list[DD_DIR_COUNT];
>  	/* Next request in FIFO order. Read, write or both are NULL. */
>  	struct request *next_rq[DD_DIR_COUNT];
> +	struct io_stats_per_prio stats;
>  };
> =20
>  struct deadline_data {
> @@ -88,8 +88,6 @@ struct deadline_data {
>  	unsigned int batching;		/* number of sequential requests made */
>  	unsigned int starved;		/* times reads have starved writes */
> =20
> -	struct io_stats __percpu *stats;
> -
>  	/*
>  	 * settings that change how the i/o scheduler behaves
>  	 */
> @@ -103,33 +101,6 @@ struct deadline_data {
>  	spinlock_t zone_lock;
>  };
> =20
> -/* Count one event of type 'event_type' and with I/O priority 'prio' */
> -#define dd_count(dd, event_type, prio) do {				\
> -	struct io_stats *io_stats =3D get_cpu_ptr((dd)->stats);		\
> -									\
> -	BUILD_BUG_ON(!__same_type((dd), struct deadline_data *));	\
> -	BUILD_BUG_ON(!__same_type((prio), enum dd_prio));		\
> -	local_inc(&io_stats->stats[(prio)].event_type);			\
> -	put_cpu_ptr(io_stats);						\
> -} while (0)
> -
> -/*
> - * Returns the total number of dd_count(dd, event_type, prio) calls acro=
ss all
> - * CPUs. No locking or barriers since it is fine if the returned sum is =
slightly
> - * outdated.
> - */
> -#define dd_sum(dd, event_type, prio) ({					\
> -	unsigned int cpu;						\
> -	u32 sum =3D 0;							\
> -									\
> -	BUILD_BUG_ON(!__same_type((dd), struct deadline_data *));	\
> -	BUILD_BUG_ON(!__same_type((prio), enum dd_prio));		\
> -	for_each_present_cpu(cpu)					\
> -		sum +=3D local_read(&per_cpu_ptr((dd)->stats, cpu)->	\
> -				  stats[(prio)].event_type);		\
> -	sum;								\
> -})
> -
>  /* Maps an I/O priority class to a deadline scheduler priority. */
>  static const enum dd_prio ioprio_class_to_prio[] =3D {
>  	[IOPRIO_CLASS_NONE]	=3D DD_BE_PRIO,
> @@ -233,7 +204,9 @@ static void dd_merged_requests(struct request_queue *=
q, struct request *req,
>  	const u8 ioprio_class =3D dd_rq_ioclass(next);
>  	const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];
> =20
> -	dd_count(dd, merged, prio);
> +	lockdep_assert_held(&dd->lock);
> +
> +	dd->per_prio[prio].stats.merged++;
> =20
>  	/*
>  	 * if next expires before rq, assign its expire time to rq
> @@ -273,7 +246,11 @@ deadline_move_request(struct deadline_data *dd, stru=
ct dd_per_prio *per_prio,
>  /* Number of requests queued for a given priority level. */
>  static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>  {
> -	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
> +	const struct io_stats_per_prio *stats =3D &dd->per_prio[prio].stats;
> +
> +	lockdep_assert_held(&dd->lock);
> +
> +	return stats->inserted - atomic_read(&stats->completed);
>  }
> =20
>  /*
> @@ -463,7 +440,7 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd,
>  done:
>  	ioprio_class =3D dd_rq_ioclass(rq);
>  	prio =3D ioprio_class_to_prio[ioprio_class];
> -	dd_count(dd, dispatched, prio);
> +	dd->per_prio[prio].stats.dispatched++;
>  	/*
>  	 * If the request needs its target zone locked, do it.
>  	 */
> @@ -542,19 +519,22 @@ static void dd_exit_sched(struct elevator_queue *e)
> =20
>  	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {
>  		struct dd_per_prio *per_prio =3D &dd->per_prio[prio];
> +		const struct io_stats_per_prio *stats =3D &per_prio->stats;
> +		uint32_t queued;
> =20
>  		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));
>  		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
> -		WARN_ONCE(dd_queued(dd, prio) !=3D 0,
> +
> +		spin_lock(&dd->lock);
> +		queued =3D dd_queued(dd, prio);
> +		spin_unlock(&dd->lock);
> +
> +		WARN_ONCE(queued,
>  			  "statistics for priority %d: i %u m %u d %u c %u\n",
> -			  prio, dd_sum(dd, inserted, prio),
> -			  dd_sum(dd, merged, prio),
> -			  dd_sum(dd, dispatched, prio),
> -			  dd_sum(dd, completed, prio));
> +			  prio, stats->inserted, stats->merged,
> +			  stats->dispatched, atomic_read(&stats->completed));
>  	}
> =20
> -	free_percpu(dd->stats);
> -
>  	kfree(dd);
>  }
> =20
> @@ -578,11 +558,6 @@ static int dd_init_sched(struct request_queue *q, st=
ruct elevator_type *e)
> =20
>  	eq->elevator_data =3D dd;
> =20
> -	dd->stats =3D alloc_percpu_gfp(typeof(*dd->stats),
> -				     GFP_KERNEL | __GFP_ZERO);
> -	if (!dd->stats)
> -		goto free_dd;
> -
>  	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {
>  		struct dd_per_prio *per_prio =3D &dd->per_prio[prio];
> =20
> @@ -604,9 +579,6 @@ static int dd_init_sched(struct request_queue *q, str=
uct elevator_type *e)
>  	q->elevator =3D eq;
>  	return 0;
> =20
> -free_dd:
> -	kfree(dd);
> -
>  put_eq:
>  	kobject_put(&eq->kobj);
>  	return ret;
> @@ -689,8 +661,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,
>  	blk_req_zone_write_unlock(rq);
> =20
>  	prio =3D ioprio_class_to_prio[ioprio_class];
> +	per_prio =3D &dd->per_prio[prio];
>  	if (!rq->elv.priv[0]) {
> -		dd_count(dd, inserted, prio);
> +		per_prio->stats.inserted++;
>  		rq->elv.priv[0] =3D (void *)(uintptr_t)1;
>  	}
> =20
> @@ -701,7 +674,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,
> =20
>  	trace_block_rq_insert(rq);
> =20
> -	per_prio =3D &dd->per_prio[prio];
>  	if (at_head) {
>  		list_add(&rq->queuelist, &per_prio->dispatch);
>  	} else {
> @@ -779,7 +751,7 @@ static void dd_finish_request(struct request *rq)
>  	if (!rq->elv.priv[0])
>  		return;
> =20
> -	dd_count(dd, completed, prio);
> +	atomic_inc(&per_prio->stats.completed);
> =20
>  	if (blk_queue_is_zoned(q)) {
>  		unsigned long flags;
> @@ -966,28 +938,44 @@ static int dd_queued_show(void *data, struct seq_fi=
le *m)
>  {
>  	struct request_queue *q =3D data;
>  	struct deadline_data *dd =3D q->elevator->elevator_data;
> +	u32 rt, be, idle;
> +
> +	spin_lock(&dd->lock);
> +	rt =3D dd_queued(dd, DD_RT_PRIO);
> +	be =3D dd_queued(dd, DD_BE_PRIO);
> +	idle =3D dd_queued(dd, DD_IDLE_PRIO);
> +	spin_unlock(&dd->lock);
> +
> +	seq_printf(m, "%u %u %u\n", rt, be, idle);
> =20
> -	seq_printf(m, "%u %u %u\n", dd_queued(dd, DD_RT_PRIO),
> -		   dd_queued(dd, DD_BE_PRIO),
> -		   dd_queued(dd, DD_IDLE_PRIO));
>  	return 0;
>  }
> =20
>  /* Number of requests owned by the block driver for a given priority. */
>  static u32 dd_owned_by_driver(struct deadline_data *dd, enum dd_prio pri=
o)
>  {
> -	return dd_sum(dd, dispatched, prio) + dd_sum(dd, merged, prio)
> -		- dd_sum(dd, completed, prio);
> +	const struct io_stats_per_prio *stats =3D &dd->per_prio[prio].stats;
> +
> +	lockdep_assert_held(&dd->lock);
> +
> +	return stats->dispatched + stats->merged -
> +		atomic_read(&stats->completed);
>  }
> =20
>  static int dd_owned_by_driver_show(void *data, struct seq_file *m)
>  {
>  	struct request_queue *q =3D data;
>  	struct deadline_data *dd =3D q->elevator->elevator_data;
> +	u32 rt, be, idle;
> +
> +	spin_lock(&dd->lock);
> +	rt =3D dd_owned_by_driver(dd, DD_RT_PRIO);
> +	be =3D dd_owned_by_driver(dd, DD_BE_PRIO);
> +	idle =3D dd_owned_by_driver(dd, DD_IDLE_PRIO);
> +	spin_unlock(&dd->lock);
> +
> +	seq_printf(m, "%u %u %u\n", rt, be, idle);
> =20
> -	seq_printf(m, "%u %u %u\n", dd_owned_by_driver(dd, DD_RT_PRIO),
> -		   dd_owned_by_driver(dd, DD_BE_PRIO),
> -		   dd_owned_by_driver(dd, DD_IDLE_PRIO));
>  	return 0;
>  }
> =20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
