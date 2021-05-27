Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A941DC4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8040C613CD
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhE0DNC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 23:13:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28780 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhE0DNA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 23:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622085087; x=1653621087;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JxJs22a3KyXx3zJvd3MuxjV31SXMcjzvZj32mS0ZzD8=;
  b=hJa+KvPZIzqUHK5IwU5lWgi1toYwA2tIVM+wuo1gfAuh0CEpo2pwSg5B
   NChxC01FeN5WhaQcke+RO1uMKnMPrsKxCjx/cinf4FaOcLFrkaUMqVjFB
   HyJbazrVWgTvx8YQ6x75pk9hb//KhcLrLij68aQ0WlIpQ2Bo2LFBynZgM
   p2v5y0Ba+qlVxg261hOfmjqSaChCDIny/iOjZt2RyxRg007Ch5KWmW3PB
   qfmJiVfdlxvVHdKLAdgQimKfCH5A4oG376vPYC2TJOCgWufMPmyDZIzmC
   MuywlSLO7zn3cQLDwyiJ+fa4WIKVcxvdnWoJ0+NL1EB9ws54vWM8Ubzam
   g==;
IronPort-SDR: YARM05MocUIGP2QPkXqXTCqWxJmnNtAnClSDcoIgMdJaR1n6jcNYEz12I/hifc5cDkDfRBBj+D
 ZnznfIlA4+oqsJr2oFo4+nT2rJP2YMi0PgkmhwNj46C5tFkEUyg/UuTunIzYncNZAyI/bbTKxM
 0XHaWwjOBHzH+A5i/75w0wxt4aY65aNvM9O2rSQjGvnKVhGnoUfgQRp0okT00EZwIcN2pnWfaZ
 e8Tv6xDj704QBH7e+lmnwzqRq/lBPubKIuGt4Z4AKy08B62WQJ0jf2SDtG5Z9onb1/TBrewtKH
 /Bk=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="168887045"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 11:11:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwAwRcNfDvQ2Jp6lYrI1ajqkNvwbEY6cvNh3Tc9mqElZEVIFYMkcKyvbAszcCo+BcAZPu1ThqEjjXnEGnBSkDdAydTayuh1zr5C+DVWr/MseWws4vbxDrXb2onvHYmqtSQcySksbc+6IYUHOVEOe2OG7DKgIdlRogm3j+foKCc1uVfaMmAYJ9qhlJahe7OTPVwgKXc9d1dc4mDPf0qmOieLNihCJV06NlWPjcsg3upwlugQQwETxh588YCjoo7ur4QYggfX3vX6AN8oP9MnfUfreg42R0gBkP8ugq5TL9KNmE25KZEdLwUlA6gzpU8JTAzsJIzneaMWWeNfK9hMT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qo1TgBaWLt0tXDDtC/bBhy4JsN27Ow+K+BWoJHvCm8=;
 b=L/5qChI9+Lnu/TpCodSFvlACub67VnTng0kpVuJAULYXI/3wkWPNX6QmgbUBGkCg5E68UPZe20o+TwR1JppRpoPhuhLbNfnVQDmEGS7gwbsk/8AAILwHrd4UfrTjI5XpzB70v7OsleUg5g9XiFyHiP7V+9im3JpXPXyVB/H63FqxCrQNqBJYXST4D1ojqWwoi/6kQb2plD4rsfabR05Vzn7U3bjHxiMblZ9/m2mnYQ2Sq9pTIuVYQ5+yI+pJkh1OLlBQdwxUFxELZzmOWF/0uGrUHB71saLryd7n7kpB/qtWx8+sAKpUFV3i8ueiSz7CBVRwYivl0+OFarsArpJ9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qo1TgBaWLt0tXDDtC/bBhy4JsN27Ow+K+BWoJHvCm8=;
 b=R1XSh3FGAa9RKchlaeEsp1Gtul7EraZJyHD05DrjrcPeA4Sh2Tkd5sVa173j4MZ3f5bQUZq9Buwmu+IuK1WFX52s91kxdfpgy9n7RleQ/YdsCVIvJc+tnqu2GFESKEZMH8ondTh5brNCDcpjN0wDToCpFYrZ16Gx3cIOF0yJHi8=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6073.namprd04.prod.outlook.com (2603:10b6:5:12e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 03:11:19 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 03:11:19 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/9] block/mq-deadline: Remove two local variables
Thread-Topic: [PATCH 3/9] block/mq-deadline: Remove two local variables
Thread-Index: AQHXUpPi+H8Pgh18tkOh1M4PjZZiRQ==
Date:   Thu, 27 May 2021 03:11:18 +0000
Message-ID: <DM6PR04MB70813ABF8F4FD9DC457570DEE7239@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-4-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66d9087e-78a6-4153-ad04-08d920bd1918
x-ms-traffictypediagnostic: DM6PR04MB6073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6073AAD6381736524B5B1A76E7239@DM6PR04MB6073.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:357;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4EqNgXudM1VJxwc34CEB8I30qt445xnpuZf/OuwBUV3NQaywWapBx0R0PZ34urDAcuCp/Wntke9qpZFXkK8TrPFLaTFUdQ/WjNp5qfK442P/BveHtL3jP59zbd02ZQFEmgpKhO2MyTKJuBkp0wi65W1uX2LXd6mVf9UWZVa85sYSb6Vo9s+GZgkl8IiQgM0nbNJShxB+86nc4oCeXjrcXZCMdqaUAZB71rXfPHc4zY0S/Z+2DTX2JgBELfh1WXMA99qw8itSFV2n9HQaLHNZWOwC5dzg+wg2JGUrtp6AvsOrTZyq1UU7zDHr7bJT1xeFiZo6ABQGT7jwH1RrYUMqdfc1wkWD1UAjc1pD/jC5IMk5cEN7a8DY5mjxNj5JMGfjl/ZIo9qAjTs5U+BC/CYHndOWi9v6mDL2CY6lCAjUo0CB4FekN60njGCuY+GIuDMVQ1+Qi0jsHS5hGQZgesiKMcppuuocmlKBWzWfJWEk/kQb4M/23pzLHDKiHB//KdJkF5ZK5W1B3W1/ana1Zs4LLG2tq65gF9M9yM+Mha0t3Owe5v4FuCwhMVf0NS4kqB6UeDBFsohieakUXVztuK+/wskv3cRohqUdgPow+A6XkM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(8936002)(8676002)(2906002)(26005)(4326008)(55016002)(316002)(9686003)(38100700002)(122000001)(478600001)(66476007)(64756008)(52536014)(83380400001)(91956017)(76116006)(186003)(66446008)(86362001)(66946007)(66556008)(54906003)(5660300002)(53546011)(6506007)(7696005)(33656002)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gX04nP1hEuBfFQx5V6YdLVvLgyNM/CatfDEIo72fh1Dt1EhCXVIVz3UzPhiz?=
 =?us-ascii?Q?X7D5i1lWifFNKy6NBJSnEn9WK9r7YyJ5G2Ex6xHaYl1c2woDkckDVrnWZbcE?=
 =?us-ascii?Q?mIjoXjA/mT1oOQsdJ7YvXd5iMG5+RaOODdIjOKJIO6vWPh3+Zsgq9atUQeT5?=
 =?us-ascii?Q?FA4Wja1zsUwaj6w1LqBv6u9i75hrRfU9KH+xzrHjNiCg1yL8EqbRCRxGzW0Z?=
 =?us-ascii?Q?GdFjNXk/X1dsKPMC4vQ1Dj2KZZXG5cFMxN5VsHz9yCgUtO4GIjuAhxsocVLp?=
 =?us-ascii?Q?Zkk+U7we4YpKaKiHkbi4QyEIDNWL05uE2SrzHSsrEgFyDDzPQJ6BtH9Gln7v?=
 =?us-ascii?Q?/Rru0Jm9UwCCSqdk5HoKPyYm0QnxUIS2yzuf6QnUjZIYuisQTrzOy02py1q3?=
 =?us-ascii?Q?VjgxM2dsNHHbTPUPw+SY0+3NEbpcqmBozga1PAHGTREokAL1aeHx+tq+ltZ0?=
 =?us-ascii?Q?dVm5ROh9+g6rrVcmVbVEbD0deygaTSpSxEsrlMbl+k0B9sbQyg335X2oz1g2?=
 =?us-ascii?Q?g+2nMupKvnToLsHFYva46c4p+0Y+PthGR1UiWh6zGglzwqYcEA044+oVPAFb?=
 =?us-ascii?Q?eFPW4R/ebGqWNRCaeQUsX87hXxdYfoc9HECYGk11jyoMawRqB2ubmAJdAIvo?=
 =?us-ascii?Q?ZrN0pcDv889O1tNEKy+xr5UiBYGn/gxohKV/sPut8tVwbS1lXi+cfZFIq0Np?=
 =?us-ascii?Q?VSjJNlB9FcLUqhMi6FrROyxMv/hECdCnor9tfA6yoeEpvHeruccHole890SN?=
 =?us-ascii?Q?9o6gXvBCP6mQgTsJFSD/N8gcHE3ti0Vp7XfTIb8gQSJqBSZ5GTMUIaUc69RZ?=
 =?us-ascii?Q?BBj3LzsBzkf83oimOvkzrTtHBfbNnHmWasVGarJ6IL+cNx1NzdKpbIH6GnX0?=
 =?us-ascii?Q?NJLABrsRZku8+8ix9xzJlda2sRPKClXnr/9avX56nB0kpPrjdVeKJ8OPezxM?=
 =?us-ascii?Q?U9mVYgL9rknrtccmlG9gjEAiIDxt2uG6QLEzl4cB4lpYDv1Y3fk7fN1jgxz1?=
 =?us-ascii?Q?ABgTbKIK2mC4PIQJD5Y/+CCz5tlU6crf7gl0mlHwBddDlBVtLNpv/bA74YfX?=
 =?us-ascii?Q?7BGzAK1hGSx+DAP8ueCb7O1AFqd/Im7b0ci/XgffbYczsAiqg/9t4Tn7qDGa?=
 =?us-ascii?Q?8SnYOtsfJbfv7OmEyVQEIBrVkzzmhbslqo/KEEc76z31uYb0g+URbk23K7to?=
 =?us-ascii?Q?d6H2dpQIEURRMlkSybiU4Poy1uaUARzpxgqWOSFXje2wK6GkoYFZxbUkOEwk?=
 =?us-ascii?Q?0t4lKSNjMnJQGCVbNGw98j7MHNMnovFEBFBFQOz3+PBFNGCcNqV4drQHA2+q?=
 =?us-ascii?Q?hPxcEAGsgEpBpJtrMR9v6/GBsv2QJnhx0JLVfnMIcIhqYw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d9087e-78a6-4153-ad04-08d920bd1918
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 03:11:18.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qd0FTl1xWnLMEIUshLTto8/dlX0WAsxsWPEbVMMxRnJZpgN5U7RcbrNoJMCoM2KYaBJvHgkyS6FAqFxKJRxHww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6073
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/27 10:01, Bart Van Assche wrote:=0A=
> Make __dd_dispatch_request() easier to read by removing two local=0A=
> variables.=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline.c | 8 ++------=0A=
>  1 file changed, 2 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index 4da0bd3b9827..cc9d0fc72db2 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -276,7 +276,6 @@ deadline_next_request(struct deadline_data *dd, int d=
ata_dir)=0A=
>  static struct request *__dd_dispatch_request(struct deadline_data *dd)=
=0A=
>  {=0A=
>  	struct request *rq, *next_rq;=0A=
> -	bool reads, writes;=0A=
>  	int data_dir;=0A=
>  =0A=
>  	lockdep_assert_held(&dd->lock);=0A=
> @@ -287,9 +286,6 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)=0A=
>  		goto done;=0A=
>  	}=0A=
>  =0A=
> -	reads =3D !list_empty(&dd->fifo_list[READ]);=0A=
> -	writes =3D !list_empty(&dd->fifo_list[WRITE]);=0A=
> -=0A=
>  	/*=0A=
>  	 * batches are currently reads XOR writes=0A=
>  	 */=0A=
> @@ -306,7 +302,7 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)=0A=
>  	 * data direction (read / write)=0A=
>  	 */=0A=
>  =0A=
> -	if (reads) {=0A=
> +	if (!list_empty(&dd->fifo_list[READ])) {=0A=
>  		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[READ]));=0A=
>  =0A=
>  		if (deadline_fifo_request(dd, WRITE) &&=0A=
> @@ -322,7 +318,7 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)=0A=
>  	 * there are either no reads or writes have been starved=0A=
>  	 */=0A=
>  =0A=
> -	if (writes) {=0A=
> +	if (!list_empty(&dd->fifo_list[WRITE])) {=0A=
>  dispatch_writes:=0A=
>  		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[WRITE]));=0A=
>  =0A=
> =0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
