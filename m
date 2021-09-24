Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E0EC433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 10:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1395461107
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 10:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbhIXK4M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 06:56:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26797 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244849AbhIXK4I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 06:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632480874; x=1664016874;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+rHxX6pck4u8QsYpt4hoCCH9X0SMdpH8gF/rNjGHDYQ=;
  b=iabNpmMCKoygMF+bjwAEjsz86xtc5/HOEdhOAGZA/SQG1QRXwNFE+VXG
   iF/xtdYakygmP6IpzKebMRbIUcW+ezNORMjqBLEESB+IYe7sE0Gv4duND
   Kvbl3Nt7VFh+JS0FWvmxmN4OXULcieV8V/L1KbBJVXVnJM0UFtS8Kyj5M
   c+IZL+/24Wo54Q3mQlUKdh9SArM8Bn8+Y5LAzVgbtQ0YqfKjd0TWPb3GE
   1X4ez1tRwf6vkbZ5Ylk6PDNKWc+TMp061YG332Bbws3ENV2NhCcbNEjL6
   JLB809kxjOvVc53TKSGDPhFl8Fb3ixx0BnQzarkQyhfEiUwXFQvC6lpRn
   A==;
X-IronPort-AV: E=Sophos;i="5.85,319,1624291200"; 
   d="scan'208";a="180866897"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2021 18:54:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EitOEVprA2kyKkfHVZO5TIOmKcLsm54FWYiQlYbp90Lew9plidCkyJPgNbacBuH+5v/hODwj3sfbAV2xUz+7Oq0nyP9+aTBOhTA88Q1/GGdXqj59yCu0gIgxy1rePNvAwhx9LL//0rq5PPFoP1ptGevMdCQmWPlgcprQoxHDrk/exvAahkGwhgOCgsBlVuu+D0fjzz7e/Orjro4g8wpL0N8UgPvVQRjgYum2qlHxzKT1zzlbVNCH9zGwlXis0UNPmLUj9Qax8MjmzhcTFQs8O5eGogk0SAIqfEx1LXbWOViUc3mGjVkJbgaghq8LZ3SZRnhqxRTS2BP/bBsx/Ge6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hTUMMcZXlCUTGjz95QcQEPsswYnQspi3NQCoGFTNL6Q=;
 b=i6kHYqRWbtxkSDXppGTAxI3Btg0NZf1hvK3WqbtrtMkmIqmjMltBnBucCpLGgKeXjaZZa96Min5aqtbdbynnZeBYz4hTNZINtDgQxQqYiBhN16Y3ZYxXozeZXGJHQAFMMdSm0ebFH1GNYdQukyfU60DnIV7tALQIzZevdF4qbEZM9NXL+1Tr7gJYH2Q1txaHMdg/8wsCYfQFJTkKHJ8uZJRb5SSQ0DJmO5QkzhDBm6re5e49paZH8W5UxqcY270jzCOpEmkaasvXgUEzmMtRV4Z6OijexhYpqjJFQt9wsTzPXumzlFZch0zYnBWUcqZ5daoFHDmeiv6Af5Wd/cN1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTUMMcZXlCUTGjz95QcQEPsswYnQspi3NQCoGFTNL6Q=;
 b=dbFFzjI1tjwKk0Vqre24c6CxfB9YC10Vmtn10HtBN90XgJn+QTzkTCbMtsOCUmgBSbyTk5aXJOL2A8kYbZrTUzmCK4kME+R62AlIW59CSQOyPrOJjPGC4SE6SAG3BZ1ZIQKXJ/+XR+rtXKJP9qikOLIJfnvbqSYZ0VRMhnCqs1k=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4537.namprd04.prod.outlook.com (2603:10b6:5:2b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Fri, 24 Sep
 2021 10:54:32 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%7]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 10:54:32 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/4] block/mq-deadline: Add an invariant check
Thread-Topic: [PATCH 2/4] block/mq-deadline: Add an invariant check
Thread-Index: AQHXsNKKb9CL6iQz6kui3gTmqwQsrA==
Date:   Fri, 24 Sep 2021 10:54:32 +0000
Message-ID: <DM6PR04MB70817F97C589AF6118F657C1E7A49@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
 <20210923232655.3907383-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cece1aee-b360-4e1c-715a-08d97f49b0b5
x-ms-traffictypediagnostic: DM6PR04MB4537:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4537B6A719ED4DF3F0EAC149E7A49@DM6PR04MB4537.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ye9YQCQqg+IIKSb508fDVZXZQ/I41nu1CbBYVsFdLOX+mJBsSEBqVyLgPtAiPDAEMv0OunE1oYqt5AcooPoXlKNp84XFOrhHl42joTI6OpYB6X2NuseZUtHs1lZIyOP6L/GNWrU4McFJDpLtnYTM6HnMw+zKczHoOF+KpH1AoOXS6k9JGaKX+ME1iCT7ep8n2L3v1TFmXbCtIA0CH4DEYQDLsitHtkx9VfKjigFzUc+fI/YcQk5NlAp13cUTtOnLlyVrWIzHpEpP2mjgOy4m6+vdH9ij8Wsby692CpAgHScmQGzSSnm91pCwxeJreNGMmHKpVUut3V54s148JHx8/oJGwCVU2NPabKhEC+iE/QNOqxNPMAh7APzahDK3tr8zAMeW1158jO15XZV7+nA/vmP+u0SjOCPoZwUIyRB6XifX+ty7jb/xA/9dqCKi+tX3UxAdvxOXdriCnq3SVlyhZjd1UhYToiTfu5pDkLzBoZuPfvnkT+aCV9bXVxY+qqxY+nGJqkgPiJm+LW/UN26kw3+gYR1BzFU2ij0RNz6YKCpNuEcc5V50Cv/WHwKJQgdCHGOH+frGMBI6KkbtZA9raoPXm0j2Jb+tQezLmEpTy4FchAIon9N1jYAxsgrBpMO7/vcJh9DnULmoeOMXpLDcsWQ5sQ/MFxB76hosUwaidEGsgNtxuk0xsiVQ2c3xda4dGuzIv02NEzFh2xrqzqPSbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(7696005)(53546011)(316002)(5660300002)(54906003)(55016002)(186003)(110136005)(9686003)(33656002)(86362001)(38070700005)(6506007)(4326008)(76116006)(91956017)(122000001)(508600001)(66556008)(71200400001)(52536014)(8676002)(38100700002)(8936002)(64756008)(66946007)(83380400001)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4TYHcZmBP0VSNaBWkkVnN7fj78hOQ1ol5BC1G19i032cd1xZRcqQLUs7psrj?=
 =?us-ascii?Q?J10Kiz4hGqJzXvbzq2csCpF8H0lii919p9CVL50dMo2GyItQJVcUG3nhhqU1?=
 =?us-ascii?Q?/5cfkZe48Wb4HmzuGUNpT8MW6NHKK6XASDypQFpMXWDBbEqgpaQC0r1Mlx0m?=
 =?us-ascii?Q?uWDdgXedb0obkIbETI00wzppw8LVZK24VJIRXxr516GxM75Y8j0CvgUDe8cV?=
 =?us-ascii?Q?e3pFcwm9Xdi+HJwZPJ/77nuJxoEGIjyK3vGLUiS11X9k2MkFHOQk64rdNGOf?=
 =?us-ascii?Q?XIDk60kZUaZ8Dc7A/vA7YlRnx5uRcKkcB76ccQNa32VyXREAN1H2kesnGR7N?=
 =?us-ascii?Q?RTblOUIn2nLZYWYs1dJs92qPFzRR/xT/bCv/ER2II16038oXBdw3W6w3HcCk?=
 =?us-ascii?Q?lz7yD6K6vnU8vnCZsAhEBRuMLPZv9k7RM5DG2OrMhWhhNbX0XJbupLdukLry?=
 =?us-ascii?Q?3F6rWRSNeTmFLmsse5iZlFEAElWVF1oCT3PxF2czS4CvI4nc1CNf4HWvPH5n?=
 =?us-ascii?Q?Eq9ex8FOBIRjL6EB+WWuECa3eOf7oOJqiMeuXJlkv82nJ7ttQUhasPHu0lW1?=
 =?us-ascii?Q?UykON/+hav/yNfwmKAJ3zixmQ931MUVHQDNnAPGXGOAYsOaZnXN/Hue6A4M6?=
 =?us-ascii?Q?BivRUY7mWJ2UlHqkVz8RBrKeHPyM4TS8NRcZs4q2sgYl1oA0LTDQWGyOJgtz?=
 =?us-ascii?Q?xnYRtrJbh0NFbGBE+S6iHUl3P+oGl1lyyzAwPJKlGBg5dOhlEuS5BKwiIykS?=
 =?us-ascii?Q?O17O7HADnnHWX20ss3eHV7ADu2mo1kDXlBJIWqGat3GNJuT5+Vkm4+N3/QPw?=
 =?us-ascii?Q?c47l8uSokLCHoxk4x76kg/EsuSTfG1/avLbsT7dWnC/whZFG8YsfdvCcggkc?=
 =?us-ascii?Q?De33SPXjoCvcIKcwcH/noOMvmQ7ZjqN8agtv/u3sCNsEXU5uB2wpF9bCRIPn?=
 =?us-ascii?Q?MHT2EgazZ5R7l6O2rl2qxLEKJ6pqUeoRxxgGR1bHFRFkERRnpQKbPeFsQjQ+?=
 =?us-ascii?Q?09MlTml1Bwo43rcZ8CgCnaK61BwsThc2F4Lbg+Uxx9tImnj8FLkWxp96ysX6?=
 =?us-ascii?Q?nUOcoUGj1Q6xOuvGUL5e5Ak8iaIbSJw8N43mvfV0Jnaxq3GMOwDkGLG5SNQj?=
 =?us-ascii?Q?/gSMJvlHOnYrP+SHcZDF0daZK22o8PTky6xfOpI4b6hyAydEtO0IW9X1GjFw?=
 =?us-ascii?Q?PmAy5pb7UiapSSoWQnMebOZ97mKwsimHcAB1naEd+FSn0J64fbG3NXF2RKuS?=
 =?us-ascii?Q?Y9zk9ibhcsLMSspDK2rH+BkmUlYqyV9tAZUyUC3ZQlS1hnvksD60xYfXTePi?=
 =?us-ascii?Q?EaWe0mif3rSUGTwQxPnHlvlVJCb8vxxlINPwFkscN0VA9xxltCqfAHu1nGss?=
 =?us-ascii?Q?p7tiuQiRnmB5lFxfBPW0es0BQSVpCCF1U+tIp7WOccpijfeiDw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cece1aee-b360-4e1c-715a-08d97f49b0b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 10:54:32.2412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3i26oYsSS8sGTYgMrEXCh/WOVP7IE3xlC4oMV/zk41a6YVSuFY/g6xqbzGMS9DsoPFriIofmB6eDFiPP5OwR3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4537
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/24 8:27, Bart Van Assche wrote:=0A=
> Check a statistics invariant at module unload time. When running=0A=
> blktests, the invariant is verified every time a request queue is=0A=
> removed and hence is verified at least once per test.=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>=0A=
> Cc: Hannes Reinecke <hare@suse.de>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline.c | 18 ++++++++++++------=0A=
>  1 file changed, 12 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index b1175e4560ad..6deb4306bcf3 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -270,6 +270,12 @@ deadline_move_request(struct deadline_data *dd, stru=
ct dd_per_prio *per_prio,=0A=
>  	deadline_remove_request(rq->q, per_prio, rq);=0A=
>  }=0A=
>  =0A=
> +/* Number of requests queued for a given priority level. */=0A=
> +static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)=0A=
> +{=0A=
> +	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * deadline_check_fifo returns 0 if there are no expired requests on the=
 fifo,=0A=
>   * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])=0A=
> @@ -539,6 +545,12 @@ static void dd_exit_sched(struct elevator_queue *e)=
=0A=
>  =0A=
>  		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));=0A=
>  		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));=0A=
> +		WARN_ONCE(dd_queued(dd, prio) !=3D 0,=0A=
> +			  "statistics for priority %d: i %u m %u d %u c %u\n",=0A=
> +			  prio, dd_sum(dd, inserted, prio),=0A=
> +			  dd_sum(dd, merged, prio),=0A=
> +			  dd_sum(dd, dispatched, prio),=0A=
> +			  dd_sum(dd, completed, prio));=0A=
>  	}=0A=
>  =0A=
>  	free_percpu(dd->stats);=0A=
> @@ -950,12 +962,6 @@ static int dd_async_depth_show(void *data, struct se=
q_file *m)=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> -/* Number of requests queued for a given priority level. */=0A=
> -static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)=0A=
> -{=0A=
> -	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);=0A=
> -}=0A=
> -=0A=
>  static int dd_queued_show(void *data, struct seq_file *m)=0A=
>  {=0A=
>  	struct request_queue *q =3D data;=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
