Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D693DC4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC30613D4
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbhE0Dts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 23:49:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12835 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhE0Dtr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 23:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622087295; x=1653623295;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cAZTTV/Knqc0ZRtWqkBArHg2YM8QhGcCa/x4Kuca3eI=;
  b=C8e4WZpmMczR8sx7ri3MgnyidNt4Gi3thRhnnWp+V+Tr52F/F8Xfd0yp
   RBEuWQqF+M9Y/FuN2MZLO36FjZuaL8yhppiGAnxVjfVDSaL6kPxgRJ1lx
   TVZ5hRULiHxLKbyEztiDVZoMj/HwgelBlHDfpDhqST5rnv9fcMmpsXt9C
   pD9konWhCif97tcwoHLaY4AB1ciDocpRiaW+y9XjvrhroOgLfSD47kWug
   ucFDioDahGJLvM5kl/1cIqFEW0MlHTUdFsgxpoO4M+Gel4R1CgG9ojwKU
   hMpHN5UB0IwVTA+x/uJKTCHjb5VtinLHwraYHKvAmBeKTl6QZJbFoirGB
   A==;
IronPort-SDR: cUSCIZTrIefe0qZFR8MDNM1BOaJemS60bqTFgDhrWF9x0OzP4sqG67BGyLv+PDwp8Dea4MCvab
 nc1/BexyQGr5c8iBfRwb8bcwQhqdNs/YSnQ4Z9noOgWa8mxP3osZ27+YcoR1ig4H61Zk0q9ALJ
 AtkDd1KNenfNZs3yXwxXoy/txvvCd/py8g7mueZu+y9SLeSMYXN7txmyKfRrYkqc55xzodVNEp
 7v0PFw+IVhhS3z33X49UQzQJWBkRthtEzm5C7OkEYJQIbI943XYzwMUVd5Q9AmUrOLnnDmLLQO
 f7s=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="168891171"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 11:48:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+6ysKCmaCPknjz4xawPrO5ssYMPQO0dL/lH8l5BPzMVWIS+avmM+rkcqY7npFEDN4QC2lihqN0RTB/+yy5Uz7jjGry+QQMBXKI4fHOlC698lvfi7BKWkszG5VhyYw6pA/N8dKVkERtfoxgPTA6CzIg6ZE3cup8kXmztBwC6TG0qD+Fex0JhzESeBUTfPkCDm9pH1sYBKsLI7b00CvC5gjT13g1VydTPOkeGKnhqYEsbG48zOKCE1LeennAEWMBnMcEAV1Q+GAFz2jA5+tmmgH1IRogt6hBk9wDIELbfDosMfauXVyhIG693k3IYBclsQ3i1G4JSk5nSFGepTL44Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUH/XnXTsTjuyAWRSRjXo9s+iYeTimt3CMH1zJJ/tmw=;
 b=gdQPF0jem79Dghc44NxvrGEiHkh3AVUDFz02JzotGqKgeDDsLPpuEnlUVDhryybTwmbjAHl2QU+zlFhbPW48pmb9vl3dQWGy62Ke/YsSIDsgccNhUI36F9b/YA6xRhMk4sn5SMgeGOTqhAmzaAaT+Vz7XLAh5h8b/58p0UxruBndJ3jCJPtzrSVP/K3Six0BQ6SU6UairUlCrn0uo9qNlp1HPctoUHELpJza+KllUukXscQjMdzuaZCH5IZS0Y+6CF5SwxmFzbnllhs4WW8GL7TRaxDZivcniwJWW69Fsf+mQfySAnjL2XY60NIiM9nwYdNaWI4Z6P3LQe+x+XKdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUH/XnXTsTjuyAWRSRjXo9s+iYeTimt3CMH1zJJ/tmw=;
 b=e+vWSfTkx+OTHXmHUDieiEXQxPs+E/ppk+72kRoZHhw3sdGvvXqsoxGfVJrhYIWbEVy+QEcZP3n0SvchSzLKmFvA5i3i6qY+THUaGmzrwuzH8p8H0Htg3z0xmvh4rtdGcmoM4XhtrL5R8u3ZvVUofH8fsuWp7AelpDdfmvQZXCo=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6073.namprd04.prod.outlook.com (2603:10b6:5:12e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 03:48:05 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 03:48:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 8/9] block/mq-deadline: Add I/O priority support
Thread-Topic: [PATCH 8/9] block/mq-deadline: Add I/O priority support
Thread-Index: AQHXUpPol9EPE/uoT0Or8KEh4kLpzg==
Date:   Thu, 27 May 2021 03:48:05 +0000
Message-ID: <DM6PR04MB7081661E924716B91E4E0899E7239@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-9-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9697f11e-64c0-4928-5cf8-08d920c23c53
x-ms-traffictypediagnostic: DM6PR04MB6073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB60732D72A6C6E43B730F8A20E7239@DM6PR04MB6073.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PrmXBBv6pF1zObZv1iSnrABzNQ6klx1TucZhfEyS9/EO/qq48LOgDuMiWF8o8XhuBJ0z9oO7o9HPxBr8UVgQcVO6/ZQ0aTXl03aeA8zOjVEDATRlYsWmtBXQmc9YlopcV7j/iBMWwI+Nh29/+ZgVIyZ6rUj1LWOQ4P1qZz9tKn0k57a8SYCLrEuuMVB0vlmi4xH1wFpt1cogmCbHFK8qZGVYEPEPrNssmuo/89ebi/KW3fPt6sF00u86lmg3CFUQT0tAPW6zkq++9CQqhKvsEMRjzLOeKtwzundffe9Yw+1P6iBa/8XDdOXvDoQeGNGK8GBG58Y1OJwyhuFG/jQuOmuZmohxJbIx0kosU3iMMbBW0IqtthxoojTBOU3kcQ2LVSKWy3UvcimZx+KXzl0x7MQe9QHngbUelXPB60ph7aCWFra2h7L4adekgiOGKgEChrPORsbHKNa2npArOoX/tYg4qaxwoNkjJBZ95ou3iL61BWKaX4lc6LKuPkHR/BiFKrf6gZhYDjITanArQE7nI+0nZR7UCxVRiUY/kgWnNXtBnHtZ0FYS3R+jVmxde7cpae1xGNf4udWluNsLX0x7sGsm/dmtBjq64DzLHZEo4+k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(86362001)(66946007)(66556008)(30864003)(186003)(66446008)(7696005)(71200400001)(110136005)(33656002)(53546011)(6506007)(54906003)(5660300002)(55016002)(9686003)(316002)(8676002)(8936002)(4326008)(2906002)(26005)(38100700002)(76116006)(91956017)(64756008)(66476007)(478600001)(122000001)(52536014)(83380400001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?i3t6CpZXGWUyOVGetjE1Dw5+IK4vLUJ8vQs+3iNaS/3cwAEfgiD27Hrdm1X0?=
 =?us-ascii?Q?rpXwNpAfektypBbCFXzgTyDDfeTX2pG1Cg70nI5jgvrzbtHG6g6/UdWcZkNe?=
 =?us-ascii?Q?5sZbbPTdDxaFLJQ9tvWJlCu9MDm/GYy7qiWh4rYw6yOoaOpI5t11wLmD3/ar?=
 =?us-ascii?Q?c2J8lpO45sKLuySdohQIStuxNeyQJEWmWETs/hIoiqepMou+u++1KoP88XYh?=
 =?us-ascii?Q?Bw6pYYC/1VvimmyjOPH88HZrNNDLV8PWBlbaa+vQz56cXo900J1Pw9SUEJMO?=
 =?us-ascii?Q?g+/yaTz++MpJaOidFdnALOFK/1jAwsbPqDEifEzRJUCKAriPmGTX9FjfRDq8?=
 =?us-ascii?Q?w6tnYwunGS8uaC/LbRPNmYqlWxOq8fAjskK+an6uVGj09ViHn1iSQoy/exa/?=
 =?us-ascii?Q?ECWmDUWXDJ5e157OAcMiVt/kRSFFWjNeGQ8fUbOHnEmQQCpfMN0Cw7RGVhi4?=
 =?us-ascii?Q?y3qYEkuBLVIOdxnvA2fy2YdCs5lmx28EjtHwT4eV+hIxtmezHNv9gWFpTIHm?=
 =?us-ascii?Q?bPL0BFxX1bPGl72IZlA4OTDOKE3hjek04kHQ5Oqt9ykxTLUQTsFLkjIvQ+en?=
 =?us-ascii?Q?jPVtV4KmJGT7JmlAb9cIgoOjKUojzvurgn4ccIl3P4Sm6DUBmz/TAE4jxxug?=
 =?us-ascii?Q?Zu0iUBc0pw62yj2AXS7fbfuokkxbViDrFKan1CVDQLnqBoYRAZJ0/2bVPNCe?=
 =?us-ascii?Q?gJSKWOYbKf0Li/EeMY6DKkQ+aqex4eP7Q8hlN5CBwFMMM/og4/qzrTCZaEI+?=
 =?us-ascii?Q?G+HpBqrvNvDF4sv7F/1tQNecvVv1aOj2RYgdhfxXUWRJ7ri9n9S+qS6NE9VE?=
 =?us-ascii?Q?lp/HhVCOm/aZUbaFiv/saEhCUL2f8HJpX8LSbiHzNUDW/Ok+Oe1cQcp//M+2?=
 =?us-ascii?Q?3MM0Oiza4h0B6yIH/G5uXRZu69PcXwzAEP07WggmjRVV+522cT52QkI49QcG?=
 =?us-ascii?Q?2OqL3Z4e+A0wmlpEGhwlHh6TC6ECs1V1AOb4dtElP4ck7D5qsWoZS2hSlS5J?=
 =?us-ascii?Q?hwlPFkXPteJGwzqQ46oYr833A6fUQSTkbfXn7i0ybfqjhNj91IeAGI/4VebX?=
 =?us-ascii?Q?KNsiig+AdxxNmWIoCBXNeprFX1ZHYotQrSdM9SgDVg7ZGgiTFMO04JLmh4R2?=
 =?us-ascii?Q?paBsCDD8dT4DypUAJfgFvEKkFwdRasNAUFyACXa+0Id9Jh9LZMHuZ8zgcaLn?=
 =?us-ascii?Q?5Hkj11vErBXLGi7Eb65lxbka4aAj7ds+BoK5bzC1rZ0wXTPLRBdV6DynTW3P?=
 =?us-ascii?Q?JP+HUng/unbh6e1cPaox3AkZcZTJp5UsV/vU4U5nmKoOIeoGUsp+cFF9/mGH?=
 =?us-ascii?Q?hdRsLYlPV7fYtNMNHo2V/VcD+iwMmGe3NQLASGU9liwocA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9697f11e-64c0-4928-5cf8-08d920c23c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 03:48:05.5654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1UPL2iFMU9zm0+dYqHItVKn5qToWS42D1Z2vD21uVU3sAJg5EBhu35S0aF77qB0Bd7JjVGLMtRZ8nhnZuUtUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6073
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/27 10:02, Bart Van Assche wrote:=0A=
> Maintain one FIFO list per I/O priority: RT, BE and IDLE. Only dispatch=
=0A=
=0A=
I/O priority -> I/O priority class. Since there is the prio level too, I th=
ink=0A=
it is better to clarify that this acts only on the class, not the level. It=
 may=0A=
be good to mention that piro level is ignored.=0A=
=0A=
> requests for a lower priority after all higher priority requests have=0A=
> finished. Maintain statistics for each priority level. Split the debugfs=
=0A=
> attributes per priority level as follows:=0A=
=0A=
s/priority level/priority class=0A=
=0A=
> =0A=
> $ ls /sys/kernel/debug/block/.../sched/=0A=
> async_depth  dispatch2        read_next_rq      write2_fifo_list=0A=
> batching     read0_fifo_list  starved           write_next_rq=0A=
> dispatch0    read1_fifo_list  write0_fifo_list=0A=
> dispatch1    read2_fifo_list  write1_fifo_list=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline.c | 293 +++++++++++++++++++++++++++++++++-----------=
=0A=
>  1 file changed, 223 insertions(+), 70 deletions(-)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index 81f487d77e09..5a703e1228fa 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -44,16 +44,27 @@ enum dd_data_dir {=0A=
>  =0A=
>  enum { DD_DIR_COUNT =3D 2 };=0A=
>  =0A=
> +enum dd_prio {=0A=
> +	DD_RT_PRIO	=3D 0,=0A=
> +	DD_BE_PRIO	=3D 1,=0A=
> +	DD_IDLE_PRIO	=3D 2,=0A=
> +	DD_PRIO_MAX	=3D 2,=0A=
> +} __packed;=0A=
=0A=
Why __packed ?=0A=
=0A=
> +=0A=
> +enum { DD_PRIO_COUNT =3D 3 };=0A=
=0A=
#define ?=0A=
=0A=
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
>  =0A=
>  	/*=0A=
>  	 * next in sort order. read, write or both are NULL=0A=
> @@ -62,6 +73,12 @@ struct deadline_data {=0A=
>  	unsigned int batching;		/* number of sequential requests made */=0A=
>  	unsigned int starved;		/* times reads have starved writes */=0A=
>  =0A=
> +	/* statistics */=0A=
> +	atomic_t inserted[DD_PRIO_COUNT];=0A=
> +	atomic_t dispatched[DD_PRIO_COUNT];=0A=
> +	atomic_t merged[DD_PRIO_COUNT];=0A=
> +	atomic_t completed[DD_PRIO_COUNT];=0A=
> +=0A=
>  	/*=0A=
>  	 * settings that change how the i/o scheduler behaves=0A=
>  	 */=0A=
> @@ -73,7 +90,15 @@ struct deadline_data {=0A=
>  =0A=
>  	spinlock_t lock;=0A=
>  	spinlock_t zone_lock;=0A=
> -	struct list_head dispatch;=0A=
> +	struct list_head dispatch[DD_PRIO_COUNT];=0A=
> +};=0A=
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
> @@ -149,12 +174,28 @@ static void dd_request_merged(struct request_queue =
*q, struct request *req,=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> +/* Returns the I/O class that has been assigned by dd_insert_request(). =
*/=0A=
> +static u8 dd_rq_ioclass(struct request *rq)=0A=
> +{=0A=
> +	return (uintptr_t)rq->elv.priv[1];=0A=
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
> +		atomic_inc(&dd->merged[prio]);=0A=
> +	} else {=0A=
> +		WARN_ON_ONCE(true);=0A=
> +	}=0A=
=0A=
I do not think you need the curly braces here.=0A=
=0A=
> +=0A=
>  	/*=0A=
>  	 * if next expires before rq, assign its expire time to rq=0A=
>  	 * and move into next position (next will be deleted) in fifo=0A=
> @@ -191,14 +232,22 @@ deadline_move_request(struct deadline_data *dd, str=
uct request *rq)=0A=
>  	deadline_remove_request(rq->q, rq);=0A=
>  }=0A=
>  =0A=
> +/* Number of requests queued for a given priority level. */=0A=
> +static u64 dd_queued(struct deadline_data *dd, enum dd_prio prio)=0A=
> +{=0A=
> +	return atomic_read(&dd->inserted[prio]) -=0A=
> +		atomic_read(&dd->completed[prio]);=0A=
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
> @@ -214,15 +263,16 @@ static inline int deadline_check_fifo(struct deadli=
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
> @@ -231,7 +281,7 @@ deadline_fifo_request(struct deadline_data *dd, enum =
dd_data_dir data_dir)=0A=
>  	 * an unlocked target zone.=0A=
>  	 */=0A=
>  	spin_lock_irqsave(&dd->zone_lock, flags);=0A=
> -	list_for_each_entry(rq, &dd->fifo_list[DD_WRITE], queuelist) {=0A=
> +	list_for_each_entry(rq, &dd->fifo_list[prio][DD_WRITE], queuelist) {=0A=
>  		if (blk_req_can_dispatch_to_zone(rq))=0A=
>  			goto out;=0A=
>  	}=0A=
> @@ -247,7 +297,8 @@ deadline_fifo_request(struct deadline_data *dd, enum =
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
> @@ -278,15 +329,18 @@ deadline_next_request(struct deadline_data *dd, enu=
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
> @@ -294,9 +348,9 @@ static struct request *__dd_dispatch_request(struct d=
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
> @@ -307,10 +361,10 @@ static struct request *__dd_dispatch_request(struct=
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
> @@ -323,7 +377,7 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)=0A=
>  	 * there are either no reads or writes have been starved=0A=
>  	 */=0A=
>  =0A=
> -	if (!list_empty(&dd->fifo_list[DD_WRITE])) {=0A=
> +	if (!list_empty(&dd->fifo_list[prio][DD_WRITE])) {=0A=
>  dispatch_writes:=0A=
>  		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_WRITE]));=0A=
>  =0A=
> @@ -340,14 +394,14 @@ static struct request *__dd_dispatch_request(struct=
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
> @@ -372,6 +426,13 @@ static struct request *__dd_dispatch_request(struct =
deadline_data *dd)=0A=
>  	dd->batching++;=0A=
>  	deadline_move_request(dd, rq);=0A=
>  done:=0A=
> +	ioprio_class =3D dd_rq_ioclass(rq);=0A=
> +	prio =3D ioprio_class_to_prio[ioprio_class];=0A=
> +	if (rq->elv.priv[0]) {=0A=
> +		atomic_inc(&dd->dispatched[prio]);=0A=
> +	} else {=0A=
> +		WARN_ON_ONCE(true);=0A=
> +	}=0A=
=0A=
No need for the curly braces.=0A=
=0A=
>  	/*=0A=
>  	 * If the request needs its target zone locked, do it.=0A=
>  	 */=0A=
> @@ -392,9 +453,14 @@ static struct request *dd_dispatch_request(struct bl=
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
> +		if (rq || dd_queued(dd, prio))=0A=
> +			break;=0A=
> +	}=0A=
>  	spin_unlock(&dd->lock);=0A=
=0A=
=0A=
Unless I missed something, this means that the aging (fifo list expire)=0A=
mechanism is per prio list but there is no aging between the prio classes. =
This=0A=
means that an application doing lots of RT direct IOs will completely starv=
e=0A=
other prio classes and hang the applications using them.=0A=
=0A=
I think we need aging between the prio classes too to avoid that. Otherwise=
, that.=0A=
=0A=
>  =0A=
>  	return rq;=0A=
> @@ -435,9 +501,12 @@ static int dd_init_hctx(struct blk_mq_hw_ctx *hctx, =
unsigned int hctx_idx)=0A=
>  static void dd_exit_sched(struct elevator_queue *e)=0A=
>  {=0A=
>  	struct deadline_data *dd =3D e->elevator_data;=0A=
> +	enum dd_prio prio;=0A=
>  =0A=
> -	BUG_ON(!list_empty(&dd->fifo_list[DD_READ]));=0A=
> -	BUG_ON(!list_empty(&dd->fifo_list[DD_WRITE]));=0A=
> +	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {=0A=
> +		WARN_ON_ONCE(!list_empty(&dd->fifo_list[prio][DD_READ]));=0A=
> +		WARN_ON_ONCE(!list_empty(&dd->fifo_list[prio][DD_WRITE]));=0A=
> +	}=0A=
>  =0A=
>  	kfree(dd);=0A=
>  }=0A=
> @@ -449,6 +518,7 @@ static int dd_init_sched(struct request_queue *q, str=
uct elevator_type *e)=0A=
>  {=0A=
>  	struct deadline_data *dd;=0A=
>  	struct elevator_queue *eq;=0A=
> +	enum dd_prio prio;=0A=
>  =0A=
>  	eq =3D elevator_alloc(q, e);=0A=
>  	if (!eq)=0A=
> @@ -461,8 +531,11 @@ static int dd_init_sched(struct request_queue *q, st=
ruct elevator_type *e)=0A=
>  	}=0A=
>  	eq->elevator_data =3D dd;=0A=
>  =0A=
> -	INIT_LIST_HEAD(&dd->fifo_list[DD_READ]);=0A=
> -	INIT_LIST_HEAD(&dd->fifo_list[DD_WRITE]);=0A=
> +	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {=0A=
> +		INIT_LIST_HEAD(&dd->fifo_list[prio][DD_READ]);=0A=
> +		INIT_LIST_HEAD(&dd->fifo_list[prio][DD_WRITE]);=0A=
> +		INIT_LIST_HEAD(&dd->dispatch[prio]);=0A=
> +	}=0A=
>  	dd->sort_list[DD_READ] =3D RB_ROOT;=0A=
>  	dd->sort_list[DD_WRITE] =3D RB_ROOT;=0A=
>  	dd->fifo_expire[DD_READ] =3D blk_queue_nonrot(q) ? read_expire_nonrot :=
=0A=
> @@ -473,7 +546,6 @@ static int dd_init_sched(struct request_queue *q, str=
uct elevator_type *e)=0A=
>  	dd->fifo_batch =3D fifo_batch;=0A=
>  	spin_lock_init(&dd->lock);=0A=
>  	spin_lock_init(&dd->zone_lock);=0A=
> -	INIT_LIST_HEAD(&dd->dispatch);=0A=
>  =0A=
>  	q->elevator =3D eq;=0A=
>  	return 0;=0A=
> @@ -536,6 +608,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
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
> @@ -545,13 +620,19 @@ static void dd_insert_request(struct blk_mq_hw_ctx =
*hctx, struct request *rq,=0A=
>  	 */=0A=
>  	blk_req_zone_write_unlock(rq);=0A=
>  =0A=
> +	prio =3D ioprio_class_to_prio[ioprio_class];=0A=
> +	atomic_inc(&dd->inserted[prio]);=0A=
> +	WARN_ON_ONCE(rq->elv.priv[0]);=0A=
> +	rq->elv.priv[0] =3D (void *)1ULL;=0A=
> +	rq->elv.priv[1] =3D (void *)(uintptr_t)ioprio_class;=0A=
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
> @@ -565,7 +646,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,=0A=
>  		 * set expire time and add to fifo list=0A=
>  		 */=0A=
>  		rq->fifo_time =3D jiffies + dd->fifo_expire[data_dir];=0A=
> -		list_add_tail(&rq->queuelist, &dd->fifo_list[data_dir]);=0A=
> +		list_add_tail(&rq->queuelist, &dd->fifo_list[prio][data_dir]);=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> @@ -589,12 +670,10 @@ static void dd_insert_requests(struct blk_mq_hw_ctx=
 *hctx,=0A=
>  	spin_unlock(&dd->lock);=0A=
>  }=0A=
>  =0A=
> -/*=0A=
> - * Nothing to do here. This is defined only to ensure that .finish_reque=
st=0A=
> - * method is called upon request completion.=0A=
> - */=0A=
> +/* Callback function called from inside blk_mq_rq_ctx_init(). */=0A=
>  static void dd_prepare_request(struct request *rq)=0A=
>  {=0A=
> +	rq->elv.priv[0] =3D NULL;=0A=
>  }=0A=
>  =0A=
>  /*=0A=
> @@ -616,26 +695,41 @@ static void dd_prepare_request(struct request *rq)=
=0A=
>  static void dd_finish_request(struct request *rq)=0A=
>  {=0A=
>  	struct request_queue *q =3D rq->q;=0A=
> +	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
> +	const u8 ioprio_class =3D dd_rq_ioclass(rq);=0A=
> +	const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];=0A=
> +=0A=
> +	if (rq->elv.priv[0])=0A=
> +		atomic_inc(&dd->completed[prio]);=0A=
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
> @@ -707,7 +801,7 @@ static struct elv_fs_entry deadline_attrs[] =3D {=0A=
>  };=0A=
>  =0A=
>  #ifdef CONFIG_BLK_DEBUG_FS=0A=
> -#define DEADLINE_DEBUGFS_DDIR_ATTRS(ddir, name)				\=0A=
> +#define DEADLINE_DEBUGFS_DDIR_ATTRS(prio, data_dir, name)		\=0A=
>  static void *deadline_##name##_fifo_start(struct seq_file *m,		\=0A=
>  					  loff_t *pos)			\=0A=
>  	__acquires(&dd->lock)						\=0A=
> @@ -716,7 +810,7 @@ static void *deadline_##name##_fifo_start(struct seq_=
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
> @@ -725,7 +819,7 @@ static void *deadline_##name##_fifo_next(struct seq_f=
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
> @@ -742,22 +836,31 @@ static const struct seq_operations deadline_##name#=
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
> @@ -786,50 +889,100 @@ static int dd_async_depth_show(void *data, struct =
seq_file *m)=0A=
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
> +	seq_printf(m, "%llu %llu %llu\n", dd_queued(dd, DD_RT_PRIO),=0A=
> +		   dd_queued(dd, DD_BE_PRIO),=0A=
> +		   dd_queued(dd, DD_IDLE_PRIO));=0A=
> +	return 0;=0A=
>  }=0A=
>  =0A=
> -static void *deadline_dispatch_next(struct seq_file *m, void *v, loff_t =
*pos)=0A=
> +/* Number of requests owned by the block driver for a given priority. */=
=0A=
> +static u64 dd_owned_by_driver(struct deadline_data *dd, enum dd_prio pri=
o)=0A=
>  {=0A=
> -	struct request_queue *q =3D m->private;=0A=
> -	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
> -=0A=
> -	return seq_list_next(v, &dd->dispatch, pos);=0A=
> +	return atomic_read(&dd->dispatched[prio]) +=0A=
> +		atomic_read(&dd->merged[prio]) -=0A=
> +		atomic_read(&dd->completed[prio]);=0A=
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
> +	seq_printf(m, "%llu %llu %llu\n", dd_owned_by_driver(dd, DD_RT_PRIO),=
=0A=
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
>  };=0A=
>  =0A=
> -#define DEADLINE_QUEUE_DDIR_ATTRS(name)						\=0A=
> -	{#name "_fifo_list", 0400, .seq_ops =3D &deadline_##name##_fifo_seq_ops=
},	\=0A=
> +DEADLINE_DISPATCH_ATTR(0);=0A=
> +DEADLINE_DISPATCH_ATTR(1);=0A=
> +DEADLINE_DISPATCH_ATTR(2);=0A=
> +#undef DEADLINE_DISPATCH_ATTR=0A=
> +=0A=
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
> @@ -879,6 +1032,6 @@ static void __exit deadline_exit(void)=0A=
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
