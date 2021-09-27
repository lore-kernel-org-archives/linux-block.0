Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7340C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 15:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA73D6044F
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 15:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhI0Pz1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 11:55:27 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3144 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbhI0Pz0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 11:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632758029; x=1664294029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Hu3vlOsrQhjm9B0055zMhBri/+gpqzAVD+OUm9iScgA=;
  b=k9iQFYqzS25X5j3TkCHTs4rNliqROehhJTED6+7scsX7JqhALNAAEOiI
   poWUKiBGP253cmJxp3LNPFDl1gNASKjmw7+vJ33LuLRRF6W3pqSzemgkQ
   BiH7n5aEf6bTGG0HEeQmhLVrJpGhvKYoSfn+9BrM+aimSfEpvC6jVp6UA
   mmmBWhMXMOmfkjL279qe5lUZNOK2log4HhCFezxDDhZgf/wcb7A+M2Fz3
   AprrkZ6Z8uYXEEwhrUEtpVosrdDtDg8Ghy1XM7mMIeaXMHqGjGEYhr0xy
   67hsSz+z1y/VEAy1y/T8RrlL3+mI3r/kQmHdZRqkxlZD03AC1uE/dLv6+
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,326,1624291200"; 
   d="scan'208";a="292726083"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 23:53:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+Hf79CidQ6yv4+8K4A0IybUQFzLkXlaQu9+VpagMUo6QeBdaAeCa7vhPjiE601rLqAzBWtLR5gOqc99fxY5CV7SV+CzzIJab8nQmkSGIeUjLpzOV9z70p0c1wURvm2EA7Jwh8HDY6f3JDnAoS7hYRdHZ+FjYbEpx0/u/VjJG/MJfUxH89Bb3VmSxoWj96qH1qRkxhRjPcXJsSoMHnTUJ03lYJceNMWxdgjd4xsA9eoMP/jvXsiNT04wqJugeXXP17pL6DFisDpVMY/Q/L3oKpJVeNBSZsO9tj4aWvcQQzHv/XS95as52BtSZLvirzOopXjkjCXRwp5Z14SnJH1bIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oCpNKs6g+ukDHCGv3SmzNZ1BFbilwoMp9yE0vULsYK8=;
 b=ZYKiuyx0E9WncVD8IQ0G0PK4BEUncGgvXWUAAvsK4yb0AOPufxTBFNjKa53KWk2Q7Z6g9iGtFlUKYgRqU+m8LcxqYn4IK9c59nIP4iUWVzA2l9Sxm6Ms09vXx0stpvD+rJN45bcdAwoUJtiqCYwZpHeP6A01AoZYZ6bMfwgXMpwhFexJuBhfIUZIezWsqqyoBFhLle3RIh0jJVu36r8/Rs9gnBAmTGE4QG6OhF/5Z3JH9m1X8109DJ0TPb+y15cOQWPT9AH2uXGj+vmCvKNhBeery7oImPjBTlj7oO7MYpDKRX3O6jkS+f5ABE+z8n3LIsIw7S6ltCu1n8T/Gtu7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCpNKs6g+ukDHCGv3SmzNZ1BFbilwoMp9yE0vULsYK8=;
 b=naWrXHmuqrvbHOXB0o5MYEr5kBUQN1v90aD7Rh2oF1S6CywXS3zXIYJEyKx3CSIX1qb+BRkRRjvNmYW+eE4ybCgfYbqhH/RvBwCJTntDi2OQojKPOaANatoeIAmpDyCHM5AXoax7sGeSevl4AMaxgoK2iEo4tnIRal60X/iDxQk=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7511.namprd04.prod.outlook.com (2603:10b6:510:4d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 15:53:39 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%6]) with mapi id 15.20.4544.022; Mon, 27 Sep 2021
 15:53:39 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/4] block/mq-deadline: Add an invariant check
Thread-Topic: [PATCH 2/4] block/mq-deadline: Add an invariant check
Thread-Index: AQHXsNKKVHelZibTcUKmcqdTPECwTqu4DgYA
Date:   Mon, 27 Sep 2021 15:53:38 +0000
Message-ID: <YVHpAkKqPYL8HIbq@x1-carbon>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
 <20210923232655.3907383-2-bvanassche@acm.org>
In-Reply-To: <20210923232655.3907383-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fff67bb-74e2-4410-009c-08d981cef901
x-ms-traffictypediagnostic: PH0PR04MB7511:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB75113A9790A65E3CCA0D997EF2A79@PH0PR04MB7511.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9AAqzSnbUmIs7WcWKaq734h9/SRiRds7+7F5DoRUp8TwcsdV+btuGQDzni4tXt5KlVTcfbmgDMdYT5Rx7WdUHDy/Eioh46a8WIw5huhGrmaHXZpmIpOa3JAMr04pkyIto/uJdAdPY/Vn/+yoOtdqZm/QpirsWjSYKFMxBXpOx9f3jP1cyr2KgtMRrtZ/ES18hwbsGAeL0JDXikA3+ihimWCrYIgOapOBvLkBDgoPKCGRXPO+IJhNiX9SR6sq0uYrAzMGnJdsIiJlk2M+VXl3bf08WZdhLtQEuMGKZ3uMTLAicZNJ8rp68OSLMZ2PCJnsVSL5mDpdzNiL+uYWS1dUKVkLSm0+omWt/qnyAL2aSff6V4vG9ALwkZWquKPg9qZaCWmYQGHssyxXlJ4STAynvXgwmZmSH1rcLoZTdSpt6zFlz0XjngAsHMraa9XBjy3UP1PVR8R8ARbZuQTgM6/JB08CIU2ewMevVfOVyy0A9NABoX7j8t8eS4a2r95t5HU+6GVQxNQc4O9J2NPyOtYEvMbA9ajP9g+lrOZQBE17qjAHSG8UD/NYROaZYCkRQN/VzAd/HVGQ14R5wKF3ENF9aZPM1SMn5yXZvrrs+JmZ/hvnq2cwysQ5zH1eWT15xIekCUtNJFjokQEGvlWayG5VmtPI/t180mAzw7pKuhmRqpoTRsARhxBl7BMoq3B58xFJefufy9VmSCrZ+E7rdhz1JA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(86362001)(316002)(64756008)(33716001)(66476007)(6506007)(66446008)(8936002)(2906002)(38070700005)(54906003)(6486002)(76116006)(91956017)(66556008)(66946007)(4326008)(8676002)(5660300002)(83380400001)(6512007)(9686003)(122000001)(186003)(508600001)(71200400001)(6916009)(38100700002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bnxInPGbyYjJT9pr0gT2KJ64p//mkE0xcLxZzlbyKzUzeUdVV7RsPl48df5C?=
 =?us-ascii?Q?eFZjZ+JS4o6DrfDTl8Yhomny6TFovInVrj9W7j+T4wky1BbBxOsePXAmQkKi?=
 =?us-ascii?Q?s+Er8E2ZmwC2YmunQuKf1e0KSDs7BVZn8AKtGtA+nXSd0fAYL3GlaLozNMZv?=
 =?us-ascii?Q?pdKK8VtoeNYPP/Rybx2P5j3wHYVcoF5avuyGBwyNkBu1J1jDEehaBQgeKqMc?=
 =?us-ascii?Q?ZQ0uWs4msdTj3+7JozwBG0+ZcqHDHNhGh1mVQ0k/rfE+Hhm3BNEGQy7V/XCD?=
 =?us-ascii?Q?gZUntVIYZl7l9Vzj192KcZA7t+xqtxC0+08XTU2SSfXbXZhNMW22pSZRtNLO?=
 =?us-ascii?Q?kFT38S7mYbE6eH31afcuGYSspe6pAJfsUp40k7I4dqnSkK8sC8OpaZRHTqbE?=
 =?us-ascii?Q?cAzk/LSJPKVeaAFj4geuIf/2MAY3/I/rMvqfpeyPzWlQLrX4c+EUiPO0bO7M?=
 =?us-ascii?Q?C9hZrMQPrQX2CpUpsCbnrutZoR3XPfTZ2SMN2ZKJWJIB/LlAjFT5x+RC93EC?=
 =?us-ascii?Q?grgty7hRm8U+wYsunWKKtyTNZqBe7Oy419O9mSWlWJkkDUKN3nF0QmCIeoxh?=
 =?us-ascii?Q?qonbtbB/Fm9BM0OZUVyyw9Nc2Ylq3nF3qcjh9sI4kysGVWs13AZGUtoXycjM?=
 =?us-ascii?Q?2+QBEq2CXmhZZRHASOweR1Hr2Z/7mpgxdYHffygUTkPh7WTi0hq7Xu5uDrEj?=
 =?us-ascii?Q?GmgEeaCFnPUac7fc8RgvRqOdZA9m3Aylk4wkg/1g1OQYdQ2rwgmLAJnEymTo?=
 =?us-ascii?Q?6TMKoeOY0u1ylx01VfUUrhUeTFGqsRUfqxmj3EwKAICJYerQL6qyB2cLARaN?=
 =?us-ascii?Q?pIpb9aUjlKA54UOUpLqiJ0GBuxJNUV1dFnG8Oc9KosLecS6ZeolwAI6tcwnW?=
 =?us-ascii?Q?+rmG333JDiJUZFxVwOwAYI/UCNkNzor8j77ydZJFmfsuWiinytBvqbbC8xPo?=
 =?us-ascii?Q?+SIs5YxthVx4CRgosHyxseryFxDw5+ksngB9TRVaMEmjkxGjuRfmIZnOJ+gf?=
 =?us-ascii?Q?deOUtKO1mgSEJ0KkgKtsirTMkyr3MIgtttq0WLHs6xtQ5rEORR3F5G97CQC1?=
 =?us-ascii?Q?8jAuLy/PjgpHBCFMogf0+yjKaZ/i+RTEFk0etltA0ZMVFoG+LdCPSou4mPeZ?=
 =?us-ascii?Q?6ZNp1JQ2//8kbSBQEwwlMnrPPw2N8eSNagxY9ck/EqnREfGGYiqycU0/kFOM?=
 =?us-ascii?Q?asdswGWcjCX+H6lYsoCasd4ODBCzsmPhsdTdPpvB8djPRIL9t99EaWxlAqrh?=
 =?us-ascii?Q?bSmx41gavyUKZRR3mGj5UK4LcwwT/ICnP4VzoH/978XBPYyA/VW/n0GswBBj?=
 =?us-ascii?Q?BBsXJNSHmb6bXFvaZ+2TCLYXfC3gsbkCnmCUblfMbPJRgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BCB20F880DF564CBF352010E71AE191@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fff67bb-74e2-4410-009c-08d981cef901
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 15:53:38.8901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2vHMMkBr1ZYQ03K1iWPi1JspNmrKe9nemdpZ5lghMpL2pCY3KleRbIzvrEjfFLkxVMieGTodx9KbuuICQc4Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7511
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 23, 2021 at 04:26:53PM -0700, Bart Van Assche wrote:
> Check a statistics invariant at module unload time. When running
> blktests, the invariant is verified every time a request queue is
> removed and hence is verified at least once per test.
>=20
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index b1175e4560ad..6deb4306bcf3 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -270,6 +270,12 @@ deadline_move_request(struct deadline_data *dd, stru=
ct dd_per_prio *per_prio,
>  	deadline_remove_request(rq->q, per_prio, rq);
>  }
> =20
> +/* Number of requests queued for a given priority level. */
> +static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
> +{
> +	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
> +}
> +
>  /*
>   * deadline_check_fifo returns 0 if there are no expired requests on the=
 fifo,
>   * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
> @@ -539,6 +545,12 @@ static void dd_exit_sched(struct elevator_queue *e)
> =20
>  		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));
>  		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
> +		WARN_ONCE(dd_queued(dd, prio) !=3D 0,
> +			  "statistics for priority %d: i %u m %u d %u c %u\n",
> +			  prio, dd_sum(dd, inserted, prio),
> +			  dd_sum(dd, merged, prio),
> +			  dd_sum(dd, dispatched, prio),
> +			  dd_sum(dd, completed, prio));
>  	}
> =20
>  	free_percpu(dd->stats);
> @@ -950,12 +962,6 @@ static int dd_async_depth_show(void *data, struct se=
q_file *m)
>  	return 0;
>  }
> =20
> -/* Number of requests queued for a given priority level. */
> -static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
> -{
> -	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
> -}
> -
>  static int dd_queued_show(void *data, struct seq_file *m)
>  {
>  	struct request_queue *q =3D data;

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
