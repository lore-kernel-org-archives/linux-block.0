Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5E6C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63C0613D4
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhE0DOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 23:14:46 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37460 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhE0DOo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 23:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622085206; x=1653621206;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uwN4dQ5AswNc9nFWah5rn4grCm2VUerGn/16jGyXc3M=;
  b=qAabF9D/1/Mpw85SiGZfdMR/GFbJQxmKCmi/nbPmG4kASnPBYMO/N+Vl
   ACxCTHqECSdyfynm4Mm3Ezw8Ut41mzI9ebOHlTCvjPkdV+2dQ3kGRzouo
   J6M5d0SzDUxaZ7TjG5gbTlsFlkvPcJ1hj+/9wg0sQO2lbJsAtj5v4rYEC
   TnwNstDwhD7pemeKGv7ykT6Kf9COxX3jO1QtJL4q1grAaobwWsOc16F+s
   uXEeg0B2BBY13WhwzdE0d8Yko2ilhn9ChTFlMz/YcKRaST2XpzCKLSzoH
   o1QBQU3D/h22RMDYiV4AYAMgiJzLHw275arOfivX48VVh4dwtxNWaHC4b
   A==;
IronPort-SDR: DY7sHiO9xn5wV2W3ZAZWdceiPoDtELPFy811CV0PO2FDB2MtUz1f/pqpz41YbVMnWdS6Vpq9Lo
 nklFcpVWepbHwSa8PSAD/t4cYgoh+95mpMddLN5cVfJLS8MfIgBSEB05DwKxkRvP3/rAS8FTrw
 /wihZ7n3rVLjDF0Se9GvINyZDYKcZEodTHgj184eKsUJ4C134wdqkocRPSGqlw4jJZRxCEjKBJ
 fbtIQQiU+Re07VxL9BNNn4yiqJp8TfRlGyfTIi9PW1rmdLj/PVCUfTtCAZJoQayokzAh8bV2S/
 oQk=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="273500839"
Received: from mail-sn1anam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 11:13:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtDMUQEF5jIfRjwtp2I6/PFtYyu9JO7mZF3H4cjwxbNUDSZyBK+ps81ZScgb+H+BqnIiGO7HrGbdRk8YOGOy44TfBZKvuqUgGwxcYjFuK9N0qfxdtSme30+/UxCWxoldcOeIfZKuss6c9hn4DT/AJFpNNMuyrf5jfg3MmOh9dhhi+28lebzE9N4PxMq7NwUz19oPYH2ftmVUAEUrn31MLxdO9+d5vcqJRsro9hTkg6d+NJGqAO0GWlFlcjbTZ37s7LdJ+5EQYPg1fYYewPiI+oCedtpeqbdINvtFZEOiSwrI8cb9XMAOQmkrcdiDHqsdFVMxd/uPIAbV7NpWzb1E1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7RpxeukxjSfraSpA+azxXDik5Q4tpwVKDt+DuGj9h0=;
 b=Rof/FE4O1FabFOG/jYhaCEHPt+3ILFKKA+XsR1OOR0hl1DScDvG7nyTo78egSZ7SMDdbW8GQiSBLr2HnFxKP4wu0AYRgkA7ukdvarqSD/WqfPjC+/iBvugbfP+GfHprThAdPXM3xNIMlwUdFkV/R2lbhyIXHHjvSM3T4syGg8rZvuiQ5gEW6cnkDiSf+obBnXjw2BQeXLPGYLnVPJqzxi0QOsnjskcyPBuiXKjzOu6WMioPHPIYHe/8+orUv1H8Tabd3VHp6K1cxSWAN7JhC3Kkd2sYdbSyFZbZD4eEcUJPGN7foV70RthHx39t0Ah2mfZiwX30GyznDiA0orejdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7RpxeukxjSfraSpA+azxXDik5Q4tpwVKDt+DuGj9h0=;
 b=B/6X+VY0tqO+IFR8xBGpF991NFawVbtfG8ierSmpY/oIJkMNlrPAPd08riD26IfU1J2MXbZjx8wtJc8YsFJZHIpC+PYlymugeiyIruoflVq+8fxr3fwl+7CvIBn478qdk2C/bVBBiY/v/yvca0o5PQFfgMmxe9SFMONI/vEIPjo=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB1194.namprd04.prod.outlook.com (2603:10b6:3:a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Thu, 27 May
 2021 03:13:10 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 03:13:10 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 4/9] block/mq-deadline: Rename dd_init_queue() and
 dd_exit_queue()
Thread-Topic: [PATCH 4/9] block/mq-deadline: Rename dd_init_queue() and
 dd_exit_queue()
Thread-Index: AQHXUpPkbijb4+An1Uex74mMpbpurg==
Date:   Thu, 27 May 2021 03:13:10 +0000
Message-ID: <DM6PR04MB7081E7FC163109B4082627DEE7239@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-5-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e246a7b-064b-423b-d4a5-08d920bd5b8d
x-ms-traffictypediagnostic: DM5PR04MB1194:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR04MB1194773727B663BB4CDDA5E3E7239@DM5PR04MB1194.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ln2L6iCxMVid1HbwLWpvvx5665f0tX4py9r3r7WjiXqBpV9frIU890uz1K600kskEjS9VbCQNC9/tizp7c6HZsx3S0RSuxG5BHLwPlWAh6TcCY8w0eYVxClnCRudBtTCLmGG63ESA5RKr0yz/gOXOB62i8e4GK23RfWzF8fw8s8Nc2KAtgwXZqgqcCcRQu1WDTF8+IIqHX5qMJxbH3CVQPuwr/4eCUnZXen1q4ZzIuV648rTWk9ExfkOTrM7ENYUw2QxgGiaV/gdKl62NT1DH+lpuJIj2iOzoeiLkxL2eW2wt10JkDgUdg+f4Cy5McuwP7XmmVX43GC8549CEPAtaa6sm3F2dVzokXQqd1GAIvH9niNJeLtda7H7G3xrKr1HJ1anlqJ5RDDNsisoeB2RBdX0Erz+W0nKlthhWHfG1chF0actV5oiLh52TnivpZ4fFB3a2ynCxx6MoYXRUG6Rgk0Fol+Mow7Od09b/EDJvejvtkeArvaiksAAE7pjjgaOGIiF1EjmqyQu3hKvgmtgjZsXq+33hKZ0TZr86XA5k7OjJSZRUtwIJQO9WRAcm6IdKo7VZAMQRQwuaZNRwjcdAzU9su7JftiWqeUu1SJBDdo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(478600001)(55016002)(33656002)(66476007)(66946007)(7696005)(66446008)(26005)(6506007)(4326008)(2906002)(110136005)(53546011)(9686003)(71200400001)(316002)(64756008)(8676002)(54906003)(86362001)(66556008)(83380400001)(52536014)(122000001)(186003)(8936002)(91956017)(76116006)(5660300002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kbdYE8efeohZ2FHG0San0TTPwSVuAyI7bdb1hOn2A+0yxKQFkdQ4mT3FmlyM?=
 =?us-ascii?Q?EoH40lKIVaFs+R8pt9ktSolwCa7PjBfj/8vJLolIOjDved93CKHXYEkq2VhX?=
 =?us-ascii?Q?0wwEUOJwBrEIUrSsB9iIKggQwBdpFSwqUwRL+fIPWsE2uqaEfOOoUyY6gz0V?=
 =?us-ascii?Q?XPAPUxeCEHR4J/AIIAC22jXEF/CMoE8XtzxjF4T+R6kKRSLs4VSkgUO7zDy3?=
 =?us-ascii?Q?xXla8nZbF3T1YUWQZJrnVXXh+vw1IGE8RYut+1rqnEHA1JqG7EiyWiuKVKHv?=
 =?us-ascii?Q?qvPrXUd6f21wNT82VvpnsKc64Swg2jTD44OaMWNcC3v4GbIblTWtw7paSf8u?=
 =?us-ascii?Q?89jfDmGtw89MejXYkUWv0MYxQw0j7mrfTOa2NCeLiaPCmEYg4OwRWagbpgIw?=
 =?us-ascii?Q?sF4xv84hM6YLxQQ4zf7/oZPXsK+9Cm4+ga8TCOYFfd8tEexEfQ9L7sQDxzTR?=
 =?us-ascii?Q?11Z11SZBROr9ymO0J+VUYhnE3UZneWD1MXHfdzIsClDnZ5ivdVeXb9+kXoaH?=
 =?us-ascii?Q?isdrBA+eQEdGqF614l2h7Q62/fEptXFCcuZeIQINIIYibd2rbrDMf9zlwfVx?=
 =?us-ascii?Q?xLXceSQNB3w2+N+T0cWrK3GsycnPE+sNtTdU5RESbVXKi/3sT+QIM23snLVd?=
 =?us-ascii?Q?9Ma8U3jW7+k8JYe1QJJ68rza0Dq3AhKk4GFFqiWqQWrV/8iE988Y/UvSPesl?=
 =?us-ascii?Q?IJvRkW9cIVlOyzR5iDOA5Yi8UjmWha/ke9SJmxXUSnD2nXZNUHY0NNH+nuYr?=
 =?us-ascii?Q?TQI0jjQ3QGa7l/KA6KSYhLZTDwA9RynvgdPRusnl4BxdXiy75pw7iWWLjXF1?=
 =?us-ascii?Q?b/5XxA909hDGK6kI9QL9b0HAPnV9/AxKxn7ufsiiPhm+peaBIgmYktqfG0Yp?=
 =?us-ascii?Q?Zg5/RVaFGlwp14bxSfOpAv9dFG/u79CtEClyJscxn9L0pCtUfSA8mOWtIuYS?=
 =?us-ascii?Q?GrLjVy7d43Dnar6R5ul452UMeBb8oXgfNh8G8AKgscF8krGSLB9Mnxb81VQ4?=
 =?us-ascii?Q?f0oYiHFJSuvFOXVn8iCJCZzTwok7vLvpaUVTqKXrasil/0omeK8/3+Hajp9u?=
 =?us-ascii?Q?lblgpSBGx60YHhYhe8XXTor9emSAuVaLeDUfozkI+C5iL4THW3/e0/xYQ3Z5?=
 =?us-ascii?Q?usGgzTj0g6Q/3jUfYwAgEWbm8Sn40LeNGvwxWZC1haPMWSciY0C7qu7Sp21T?=
 =?us-ascii?Q?OwktiDtAarPOJ8THT1ZTsvTnLEYHqjOujMj29fB1CE9zndHNInCTHhjLtyQA?=
 =?us-ascii?Q?h8LmgL5Tb8kKt70/DeonFqmeOX5jJiD7I1pgO4WSUt7KP9nvSOXiPF85r9+e?=
 =?us-ascii?Q?R1twcnQZOId8PouhSna6NKFzHTsAhcFER0kRsuA3r17MFw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e246a7b-064b-423b-d4a5-08d920bd5b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 03:13:10.4733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sxz8itLv1vWswsmHVw9yuTu47uDyMFpxej057UHhEflet/nEIJA08U/YU/iq92h9XOF8JoN6MgJZ1+D9gpzaAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1194
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/27 10:01, Bart Van Assche wrote:=0A=
> Change "queue" into "sched" to make the function names reflect better the=
=0A=
> purpose of these functions.=0A=
=0A=
Nit: may be change this to:=0A=
=0A=
Change "queue" into "sched" to make the function names match the elevator t=
ype=0A=
operation names.=0A=
=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline.c | 8 ++++----=0A=
>  1 file changed, 4 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index cc9d0fc72db2..c4f51e7884fb 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -395,7 +395,7 @@ static struct request *dd_dispatch_request(struct blk=
_mq_hw_ctx *hctx)=0A=
>  	return rq;=0A=
>  }=0A=
>  =0A=
> -static void dd_exit_queue(struct elevator_queue *e)=0A=
> +static void dd_exit_sched(struct elevator_queue *e)=0A=
>  {=0A=
>  	struct deadline_data *dd =3D e->elevator_data;=0A=
>  =0A=
> @@ -408,7 +408,7 @@ static void dd_exit_queue(struct elevator_queue *e)=
=0A=
>  /*=0A=
>   * initialize elevator private data (deadline_data).=0A=
>   */=0A=
> -static int dd_init_queue(struct request_queue *q, struct elevator_type *=
e)=0A=
> +static int dd_init_sched(struct request_queue *q, struct elevator_type *=
e)=0A=
>  {=0A=
>  	struct deadline_data *dd;=0A=
>  	struct elevator_queue *eq;=0A=
> @@ -800,8 +800,8 @@ static struct elevator_type mq_deadline =3D {=0A=
>  		.requests_merged	=3D dd_merged_requests,=0A=
>  		.request_merged		=3D dd_request_merged,=0A=
>  		.has_work		=3D dd_has_work,=0A=
> -		.init_sched		=3D dd_init_queue,=0A=
> -		.exit_sched		=3D dd_exit_queue,=0A=
> +		.init_sched		=3D dd_init_sched,=0A=
> +		.exit_sched		=3D dd_exit_sched,=0A=
>  	},=0A=
>  =0A=
>  #ifdef CONFIG_BLK_DEBUG_FS=0A=
> =0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
