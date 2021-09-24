Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14769C433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 10:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0ECB61214
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 10:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbhIXLAL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 07:00:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24254 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244324AbhIXLAL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 07:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632481118; x=1664017118;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=27LMyr4tirvhMmbQ+j3FcTgHu/TrrB7PUWdFF0JuROE=;
  b=IyUVRBwy5V8V9sbq1FH2EvgBjG8bxiK6r3nYMs1kaIHMRp1/jodYiwdH
   U2UK0vWPRwpYhv3+MCW2+z4xPKGWbwR5UcenexWXPhSX8Li2SF04QDm/D
   zCRgrSHA78EYP+KQzUtFiZLYPmKJudorYVTiUgAWCQWLVfcOlY5EOanVB
   KI17Lr4TDh8YKiEoqLmGm8q9i8f0S3IaXNohCFea48H2/k8P2WcOLW5Yr
   QtBK15i7tXRoWb8vw24RdXsx2dXuKNMpYKvAUUsQHq1UdEcHHTm/XvODa
   BdNKg2eYgNzozHo0BXRD91QpfiALWjo/JrsD1RF5fS1mkcJcskSJ3Mui7
   A==;
X-IronPort-AV: E=Sophos;i="5.85,319,1624291200"; 
   d="scan'208";a="179927091"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2021 18:58:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+RepWY/bByxJniH8/4mMLMAykpHfBSfTZ7xdAxswehFnlFS0aaOdsWJNqR1GkheLJPd86dR0rdhWEoKdP0AuX+BQUJ/alsNzMOr3wyr3ELYy9UPptODY2FhTKrZXFjjewH/kwvWw2tFEznmuaqsFfe/RmMup4nRcDQVbG6q/MzFHQAkGfJxMUZ5nQcr6s8SPRj/S9Zgf9Xz69Zr3EXg7ZuJL00BkLiUShPweDfeFK/xlBaygJm0KPrXeMqsG8c5wv46zd/EE0KOymtI4Q7C2m1hlfwOHCHoux7p5kbG55XT8Y4VZ2sGSFmyt1uSNtqC6x6XUx/CSJqCNc92PO5rWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=if4PV7zflH5aZIL+4OLv5uVbxG5mBegb+AGttFPeVsA=;
 b=MDQK/4Q4GhKR+iSqXc3pb3RsjMR/7jDwHyh3iLeR5jpIlWU3FLT0Z2PMYuxRw60ci995wLdiRUuMKCwvy+5XUmB0NeOeILlXcLVgTSBwoMY1xsEBiLBH9IGUcAx0uYptxqtHT14UThJM/TZCfx++m9KgRtY3Ai5UoXFNKjBolDSA7X0UGGVA2tD/qSNvoQGORFzMReT627Jv/0qFqnvIMDREN3zBOClyvE7qquuzO8zeqi290xBfdmJPW5GE4RJm0im2fG/J/fEYyPG0+e8v+l3jzMF4fr6WSdW2+FgYWJskxVPhpkjo+Dy03RRzbiWRLVihPaYqLPj++2GP0hVGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if4PV7zflH5aZIL+4OLv5uVbxG5mBegb+AGttFPeVsA=;
 b=LASYyogOOwCl0jR187v7Bl1xxN+kEYHKekJM/yhRUPZaaZC0d2mgNkER4Rsx1oVoMBj0AEhaLraZBkFTsSK/dsGHtxpFuThtQd9gJQHiSngkmesh153OffH5Af3CETagzFuwJQI4BQwvD9BB+XPrbb64rMmpX63FlXhBgNBeIG0=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4537.namprd04.prod.outlook.com (2603:10b6:5:2b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Fri, 24 Sep
 2021 10:58:35 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%7]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 10:58:35 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/4] block/mq-deadline: Stop using per-CPU counters
Thread-Topic: [PATCH 3/4] block/mq-deadline: Stop using per-CPU counters
Thread-Index: AQHXsNKKbGNTCUT9vECjQKAJIR9Njw==
Date:   Fri, 24 Sep 2021 10:58:35 +0000
Message-ID: <DM6PR04MB7081B7096944F8115A8BE2B6E7A49@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
 <20210923232655.3907383-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a14d025-983f-4c67-1e43-08d97f4a418c
x-ms-traffictypediagnostic: DM6PR04MB4537:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4537490E1AE81614EA913817E7A49@DM6PR04MB4537.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7vSV0vz++xRQnJghWJBqyeZPF+7DEQDnmaua47G/PvaPfdYi6cDOzPDmXPObJWCqcpVrWhnu+IUNHy41KE4qVqZ+gV2MCjY2BjketeQLWiPK2bGwjddWU1YiMAhg6yWenZxPbfZHCScZsRNbPUOCOIfdqFI2d3PKE3ipOF6KaQXRNRlUCDv8ZU2nteIl4z3DfNkTSQLr0bYttfkkYVrQGEcUr7Zc/DPBO1VuB7Pf09GldghhMG5IsYrviiym/0OK1dd9VyM6LjbIK3ZF16Rx32jBkV4IJFNzF8TkLLuaNUcSIDmnCINOqKYQX5p6GztgyXhPVzHjeB/Re7bmA6s0UK2C24L6oFyCBis5QHsJrxqvehmNbaAUMKuM8/qoa+O38f4To2i1vwuABcSH5XqYvt30d8EIoyf1uFt8/M4CMUBlRgxaYYiinBBXWtmcW4w4/U/doZOEvNSevTi0wjn+14RvAyGRy4/vYyMxEkaImjt0g9aThmqsq9JhvLTRPadUVE2fO2tFnflYS1QW+XEPHpbenK3ru+o7/S7XrhCTid+6UPfHh2RLYR6dWESiKeCbuVwsERW3UHFlwXh93WJXn2gn57itNgSy7kFpVEWoEibjMTVQIMSVDHfMvaEIdL/UKOLHs/IBz1coTtRz5PkrtuVC6HQsB34MPP9X/FTupbN7XoeSZ/6WzLG3DPkW2qSEQhJ29senC1+uDfp3HSHaGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(76116006)(86362001)(38070700005)(6506007)(91956017)(66946007)(83380400001)(8676002)(38100700002)(8936002)(64756008)(66476007)(66446008)(508600001)(122000001)(71200400001)(52536014)(66556008)(54906003)(5660300002)(55016002)(2906002)(316002)(7696005)(53546011)(110136005)(9686003)(33656002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PARpoL2pzB+N7Dt6pVBGNIfc1UfC4btGKdnh9l7hwHhPPjNKEwZa3C7xSleS?=
 =?us-ascii?Q?5LZxUqN4Dpiyp/c6d5g0eqoaRde7EFZuUWdcRDyheDKlDt+SP/TgorQawdPu?=
 =?us-ascii?Q?8xqJ7AsrFECjD+pae7T3fBB0pJuPcrvTHPLIKCRuLW62ihrRWxpSNLmbCci3?=
 =?us-ascii?Q?k5d2QNzgyXJQjdKqjS8IU+YjGbn2nptZmmua+O2MaeEqdSurTfoFoXG86T1x?=
 =?us-ascii?Q?y5KOvlhhYyKf6mZ8q8lJT5UjgY8zqhnkwH1dXNChl3lxHZca8qbfSGAO0zLT?=
 =?us-ascii?Q?yjyvXZynk0Op9hXpzc+4uAm0tomJ3OWhhQEmNnb8lLQxYiZ2meIvSSWuBWDa?=
 =?us-ascii?Q?zimH/7Oe1xJCm4hyGIvWr2erXibfl8jNfPXsHiTizfVNA4VQBhKfPMDdxyz9?=
 =?us-ascii?Q?l37gSJggcZxLQe/vCVOVgmSOdG+2/od5KIAy2P6VQs20aRCnJVXar3i8F4Jw?=
 =?us-ascii?Q?qTDPMgONK076xAVWBSripPsPMnmmc9h8mwnZGKpJ6Sl1YLw0leYpIOEiludY?=
 =?us-ascii?Q?7P21TkiMc25odGpFNAtDP9onEIcfZDf5lqvs6IodejobnFW8+Knf/wl/Wca7?=
 =?us-ascii?Q?4hhnG3qeWbc86O0ZxM2ZkHcmdelTydBtkBwiXtk1zCyA31J0OOMezwT7cPcJ?=
 =?us-ascii?Q?9OwmbrbcDY+Nz9oaV/REdCoSzjRVHTO1YmCWqAQpkmoC/Vqsz/GojjcbEe2C?=
 =?us-ascii?Q?V6+qkH3Lh02a0WFOF2QKKTnD1WnmgL2onLBq2759iQ9WnxsP8x8DhHh6MBVE?=
 =?us-ascii?Q?FONnWkpKf0QBxDmqmU+fTuHyOB9iBZOU+AHknGQh9PWmjF+rYqfM5DOxZU8h?=
 =?us-ascii?Q?/9soWsuJPNBP+lXTc8MwG4UIZ/30JRLFldDdGZltuZofW6TFECU7MT+Kk39W?=
 =?us-ascii?Q?2zZDVap02JfOieeSkH/gAb+I06fYq1wU23W3WYayfkHG8Cznpnu0EscLFf4K?=
 =?us-ascii?Q?7yuNyZAdHky6SH6+PQg+hZsomg8aLulXEr+dUykobZUgFSCjWNZATrz6f9ZO?=
 =?us-ascii?Q?Njoff32hPSEuN5aSghYi0zxXH3BZ26dT4qhbq3nMOCpXUprPJFjMc4Ap04ur?=
 =?us-ascii?Q?Gb27ZQkV30OD50GWWt9Z06CZ98vu7vi0OAGTGFchHXn4JGN2rOsr4FimAXaN?=
 =?us-ascii?Q?Z+HsCxKss6ys6FnGF0Fm6IDkWW2WeVIQsDv91VF7oicMXIwr2tS384l9DUPK?=
 =?us-ascii?Q?ZhyssRQK8OfoOvtc0d8sWOJXFTt6v/wmhTJPZSaXNoaPogwKCj6Gu2VgHEKP?=
 =?us-ascii?Q?g8jZNcxOo5E0LS014n3verrhX/AfUcY/+NIdYdG1QdrhdpRGmmUxz3b45SFm?=
 =?us-ascii?Q?ySVWJq71UftHssCbxXq3dkZ5Wa7e8FF96v/ob9//2qQKt/AgxzNiGxOlYHGF?=
 =?us-ascii?Q?F/bw8OowiDP0kbIgog89f5R1veU89lCAZlqzslSLG1oirkSj+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a14d025-983f-4c67-1e43-08d97f4a418c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 10:58:35.2191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrOEttlnUjZucEuataonAPTR3YaPtaSx15vykC8RIkdlIsGII4rNcH4AAuQhWeMOajF76Y6Zi5ITfHDLspSThw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4537
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/24 8:27, Bart Van Assche wrote:=0A=
> Calculating the sum over all CPUs of per-CPU counters frequently is=0A=
> inefficient. Hence switch from per-CPU to individual counters. Three=0A=
> counters are protected by the mq-deadline spinlock since these are=0A=
> only accessed from contexts that already hold that spinlock. The fourth=
=0A=
> counter is atomic because protecting it with the mq-deadline spinlock=0A=
> would trigger lock contention.=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>=0A=
> Cc: Hannes Reinecke <hare@suse.de>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline.c | 124 ++++++++++++++++++++------------------------=
=0A=
>  1 file changed, 56 insertions(+), 68 deletions(-)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index 6deb4306bcf3..b0cfc84a4e6b 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -51,17 +51,16 @@ enum dd_prio {=0A=
>  =0A=
>  enum { DD_PRIO_COUNT =3D 3 };=0A=
>  =0A=
> -/* I/O statistics per I/O priority. */=0A=
> +/*=0A=
> + * I/O statistics per I/O priority. It is fine if these counters overflo=
w.=0A=
> + * What matters is that these counters are at least as wide as=0A=
> + * log2(max_outstanding_requests).=0A=
> + */=0A=
>  struct io_stats_per_prio {=0A=
> -	local_t inserted;=0A=
> -	local_t merged;=0A=
> -	local_t dispatched;=0A=
> -	local_t completed;=0A=
> -};=0A=
> -=0A=
> -/* I/O statistics for all I/O priorities (enum dd_prio). */=0A=
> -struct io_stats {=0A=
> -	struct io_stats_per_prio stats[DD_PRIO_COUNT];=0A=
> +	uint32_t inserted;=0A=
> +	uint32_t merged;=0A=
> +	uint32_t dispatched;=0A=
> +	atomic_t completed;=0A=
=0A=
Why not use 64-bits types (regular unsigned long long and atomic64_t) ?=0A=
=0A=
>  };=0A=
>  =0A=
>  /*=0A=
> @@ -74,6 +73,7 @@ struct dd_per_prio {=0A=
>  	struct list_head fifo_list[DD_DIR_COUNT];=0A=
>  	/* Next request in FIFO order. Read, write or both are NULL. */=0A=
>  	struct request *next_rq[DD_DIR_COUNT];=0A=
> +	struct io_stats_per_prio stats;=0A=
>  };=0A=
>  =0A=
>  struct deadline_data {=0A=
> @@ -88,8 +88,6 @@ struct deadline_data {=0A=
>  	unsigned int batching;		/* number of sequential requests made */=0A=
>  	unsigned int starved;		/* times reads have starved writes */=0A=
>  =0A=
> -	struct io_stats __percpu *stats;=0A=
> -=0A=
>  	/*=0A=
>  	 * settings that change how the i/o scheduler behaves=0A=
>  	 */=0A=
> @@ -103,33 +101,6 @@ struct deadline_data {=0A=
>  	spinlock_t zone_lock;=0A=
>  };=0A=
>  =0A=
> -/* Count one event of type 'event_type' and with I/O priority 'prio' */=
=0A=
> -#define dd_count(dd, event_type, prio) do {				\=0A=
> -	struct io_stats *io_stats =3D get_cpu_ptr((dd)->stats);		\=0A=
> -									\=0A=
> -	BUILD_BUG_ON(!__same_type((dd), struct deadline_data *));	\=0A=
> -	BUILD_BUG_ON(!__same_type((prio), enum dd_prio));		\=0A=
> -	local_inc(&io_stats->stats[(prio)].event_type);			\=0A=
> -	put_cpu_ptr(io_stats);						\=0A=
> -} while (0)=0A=
> -=0A=
> -/*=0A=
> - * Returns the total number of dd_count(dd, event_type, prio) calls acro=
ss all=0A=
> - * CPUs. No locking or barriers since it is fine if the returned sum is =
slightly=0A=
> - * outdated.=0A=
> - */=0A=
> -#define dd_sum(dd, event_type, prio) ({					\=0A=
> -	unsigned int cpu;						\=0A=
> -	u32 sum =3D 0;							\=0A=
> -									\=0A=
> -	BUILD_BUG_ON(!__same_type((dd), struct deadline_data *));	\=0A=
> -	BUILD_BUG_ON(!__same_type((prio), enum dd_prio));		\=0A=
> -	for_each_present_cpu(cpu)					\=0A=
> -		sum +=3D local_read(&per_cpu_ptr((dd)->stats, cpu)->	\=0A=
> -				  stats[(prio)].event_type);		\=0A=
> -	sum;								\=0A=
> -})=0A=
> -=0A=
>  /* Maps an I/O priority class to a deadline scheduler priority. */=0A=
>  static const enum dd_prio ioprio_class_to_prio[] =3D {=0A=
>  	[IOPRIO_CLASS_NONE]	=3D DD_BE_PRIO,=0A=
> @@ -233,7 +204,9 @@ static void dd_merged_requests(struct request_queue *=
q, struct request *req,=0A=
>  	const u8 ioprio_class =3D dd_rq_ioclass(next);=0A=
>  	const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];=0A=
>  =0A=
> -	dd_count(dd, merged, prio);=0A=
> +	lockdep_assert_held(&dd->lock);=0A=
> +=0A=
> +	dd->per_prio[prio].stats.merged++;=0A=
>  =0A=
>  	/*=0A=
>  	 * if next expires before rq, assign its expire time to rq=0A=
> @@ -273,7 +246,11 @@ deadline_move_request(struct deadline_data *dd, stru=
ct dd_per_prio *per_prio,=0A=
>  /* Number of requests queued for a given priority level. */=0A=
>  static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)=0A=
>  {=0A=
> -	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);=0A=
> +	const struct io_stats_per_prio *stats =3D &dd->per_prio[prio].stats;=0A=
> +=0A=
> +	lockdep_assert_held(&dd->lock);=0A=
> +=0A=
> +	return stats->inserted - atomic_read(&stats->completed);=0A=
>  }=0A=
>  =0A=
>  /*=0A=
> @@ -463,7 +440,7 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd,=0A=
>  done:=0A=
>  	ioprio_class =3D dd_rq_ioclass(rq);=0A=
>  	prio =3D ioprio_class_to_prio[ioprio_class];=0A=
> -	dd_count(dd, dispatched, prio);=0A=
> +	dd->per_prio[prio].stats.dispatched++;=0A=
>  	/*=0A=
>  	 * If the request needs its target zone locked, do it.=0A=
>  	 */=0A=
> @@ -542,19 +519,22 @@ static void dd_exit_sched(struct elevator_queue *e)=
=0A=
>  =0A=
>  	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {=0A=
>  		struct dd_per_prio *per_prio =3D &dd->per_prio[prio];=0A=
> +		const struct io_stats_per_prio *stats =3D &per_prio->stats;=0A=
> +		uint32_t queued;=0A=
>  =0A=
>  		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));=0A=
>  		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));=0A=
> -		WARN_ONCE(dd_queued(dd, prio) !=3D 0,=0A=
> +=0A=
> +		spin_lock(&dd->lock);=0A=
> +		queued =3D dd_queued(dd, prio);=0A=
> +		spin_unlock(&dd->lock);=0A=
> +=0A=
> +		WARN_ONCE(queued,=0A=
>  			  "statistics for priority %d: i %u m %u d %u c %u\n",=0A=
> -			  prio, dd_sum(dd, inserted, prio),=0A=
> -			  dd_sum(dd, merged, prio),=0A=
> -			  dd_sum(dd, dispatched, prio),=0A=
> -			  dd_sum(dd, completed, prio));=0A=
> +			  prio, stats->inserted, stats->merged,=0A=
> +			  stats->dispatched, atomic_read(&stats->completed));=0A=
>  	}=0A=
>  =0A=
> -	free_percpu(dd->stats);=0A=
> -=0A=
>  	kfree(dd);=0A=
>  }=0A=
>  =0A=
> @@ -578,11 +558,6 @@ static int dd_init_sched(struct request_queue *q, st=
ruct elevator_type *e)=0A=
>  =0A=
>  	eq->elevator_data =3D dd;=0A=
>  =0A=
> -	dd->stats =3D alloc_percpu_gfp(typeof(*dd->stats),=0A=
> -				     GFP_KERNEL | __GFP_ZERO);=0A=
> -	if (!dd->stats)=0A=
> -		goto free_dd;=0A=
> -=0A=
>  	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {=0A=
>  		struct dd_per_prio *per_prio =3D &dd->per_prio[prio];=0A=
>  =0A=
> @@ -604,9 +579,6 @@ static int dd_init_sched(struct request_queue *q, str=
uct elevator_type *e)=0A=
>  	q->elevator =3D eq;=0A=
>  	return 0;=0A=
>  =0A=
> -free_dd:=0A=
> -	kfree(dd);=0A=
> -=0A=
>  put_eq:=0A=
>  	kobject_put(&eq->kobj);=0A=
>  	return ret;=0A=
> @@ -689,8 +661,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,=0A=
>  	blk_req_zone_write_unlock(rq);=0A=
>  =0A=
>  	prio =3D ioprio_class_to_prio[ioprio_class];=0A=
> +	per_prio =3D &dd->per_prio[prio];=0A=
>  	if (!rq->elv.priv[0]) {=0A=
> -		dd_count(dd, inserted, prio);=0A=
> +		per_prio->stats.inserted++;=0A=
>  		rq->elv.priv[0] =3D (void *)(uintptr_t)1;=0A=
>  	}=0A=
>  =0A=
> @@ -701,7 +674,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,=0A=
>  =0A=
>  	trace_block_rq_insert(rq);=0A=
>  =0A=
> -	per_prio =3D &dd->per_prio[prio];=0A=
>  	if (at_head) {=0A=
>  		list_add(&rq->queuelist, &per_prio->dispatch);=0A=
>  	} else {=0A=
> @@ -779,7 +751,7 @@ static void dd_finish_request(struct request *rq)=0A=
>  	if (!rq->elv.priv[0])=0A=
>  		return;=0A=
>  =0A=
> -	dd_count(dd, completed, prio);=0A=
> +	atomic_inc(&per_prio->stats.completed);=0A=
>  =0A=
>  	if (blk_queue_is_zoned(q)) {=0A=
>  		unsigned long flags;=0A=
> @@ -966,28 +938,44 @@ static int dd_queued_show(void *data, struct seq_fi=
le *m)=0A=
>  {=0A=
>  	struct request_queue *q =3D data;=0A=
>  	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
> +	u32 rt, be, idle;=0A=
> +=0A=
> +	spin_lock(&dd->lock);=0A=
> +	rt =3D dd_queued(dd, DD_RT_PRIO);=0A=
> +	be =3D dd_queued(dd, DD_BE_PRIO);=0A=
> +	idle =3D dd_queued(dd, DD_IDLE_PRIO);=0A=
> +	spin_unlock(&dd->lock);=0A=
> +=0A=
> +	seq_printf(m, "%u %u %u\n", rt, be, idle);=0A=
>  =0A=
> -	seq_printf(m, "%u %u %u\n", dd_queued(dd, DD_RT_PRIO),=0A=
> -		   dd_queued(dd, DD_BE_PRIO),=0A=
> -		   dd_queued(dd, DD_IDLE_PRIO));=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
>  /* Number of requests owned by the block driver for a given priority. */=
=0A=
>  static u32 dd_owned_by_driver(struct deadline_data *dd, enum dd_prio pri=
o)=0A=
>  {=0A=
> -	return dd_sum(dd, dispatched, prio) + dd_sum(dd, merged, prio)=0A=
> -		- dd_sum(dd, completed, prio);=0A=
> +	const struct io_stats_per_prio *stats =3D &dd->per_prio[prio].stats;=0A=
> +=0A=
> +	lockdep_assert_held(&dd->lock);=0A=
> +=0A=
> +	return stats->dispatched + stats->merged -=0A=
> +		atomic_read(&stats->completed);=0A=
>  }=0A=
>  =0A=
>  static int dd_owned_by_driver_show(void *data, struct seq_file *m)=0A=
>  {=0A=
>  	struct request_queue *q =3D data;=0A=
>  	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
> +	u32 rt, be, idle;=0A=
> +=0A=
> +	spin_lock(&dd->lock);=0A=
> +	rt =3D dd_owned_by_driver(dd, DD_RT_PRIO);=0A=
> +	be =3D dd_owned_by_driver(dd, DD_BE_PRIO);=0A=
> +	idle =3D dd_owned_by_driver(dd, DD_IDLE_PRIO);=0A=
> +	spin_unlock(&dd->lock);=0A=
> +=0A=
> +	seq_printf(m, "%u %u %u\n", rt, be, idle);=0A=
>  =0A=
> -	seq_printf(m, "%u %u %u\n", dd_owned_by_driver(dd, DD_RT_PRIO),=0A=
> -		   dd_owned_by_driver(dd, DD_BE_PRIO),=0A=
> -		   dd_owned_by_driver(dd, DD_IDLE_PRIO));=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
Apart from the nit/comment above, looks OK to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
