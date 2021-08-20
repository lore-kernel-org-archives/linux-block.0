Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89338C4338F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 00:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D567610E5
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 00:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhHTAqK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:46:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:6779 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhHTAqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 20:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629420332; x=1660956332;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kO3+HMhbGXhdQIG8TC43Qf8mLn+u16tRwZawZ3bD3LU=;
  b=a+klccFUqj3MDVOJ+s3MqjrnxtbENptVUkgo1K9nRn3rx8OMsAI6BBOB
   fZcdIOz6+0RU2yCDGvP8CONtEKV0LtdEoPHqjl1zrdmG+3dJiYXaDfYO3
   SVevdRPYnUdKV91k5ffHtSkAXjbdq2JAE1XGqW/D7+gA953NJb8vY3RKS
   00kk8dHV7o0xEImOs6wGx9V6ppQ4i6u0sNs1aiIPjWywuPj2cXhkrdICd
   lLGssUZsKMqG1aqpVGxaQShZY6TypbzPUJGtvDzuZXySEN6UgFV6rhvWk
   IMW4yuwN47OZRwRBzFh1QvIJroI9S9SX6gvOfjf7WfmKNbCXTbtAvReka
   g==;
X-IronPort-AV: E=Sophos;i="5.84,336,1620662400"; 
   d="scan'208";a="176995914"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2021 08:45:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WivImGRS5kQb7nQ83b/MnyCq2ElAz7esYJGChg2wlMtP9pt7hUvbC2stMUCEECb2TUhEuWIq9COKX+OVe9obLo1bppoTApnBwT2GG0v4UMBwOkYjadaYVXCitq6AtIb3rZaW79p94lIbv/kFE1nH3T9V2jIJo0tANbb+w+K+1gfxEw0udt//7mGm4Urckp7d3bQjItaJi9B7u5jTtY1pnShmKfOAXvaepgfyRbpQ4xq2Fso6fLhgA4yf49UIYMchbukGYBxniXpfI1FowtUKv+LBwZAQXSaCAl2pHE05Q5leQ1WKNLwHTmcb67bTAarPYT2GMPhya4TJ39iF9oXkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ/wTlbc1EA5uXfpqVdVMf8rwtlx/ZddDaUfRWgbZlU=;
 b=DfuQnwKMg7OrOSrd5oihTaHer4g6zxlWQ2An33iI7x7+BJLTCBRKR1FwJbV4yt4wxyS60RR24xvYm6WW3fH62L0jnANSOzB/hI7WOsrIx4j8/G/GWnkJMCjm+kfsFaKImtPp3MQd5MoGY3+f3PifzI4wUaYylKANTAfcehyjzYyYNxXWhuFbp//2Uv9spAm0+g+mb0OckFoZu5c6zi1MW9B6eRNezqwHaaZ9aDlA2aYSzmnufkWW8zgE9AlTMTI/iY7d8TMjNRjaou1ZN2x5OoloSbktLyjOrj/UB87esE1+XyjxBxLU5lbdT18tgfiQBEz8clVzwGwQ3XVaH0GzFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ/wTlbc1EA5uXfpqVdVMf8rwtlx/ZddDaUfRWgbZlU=;
 b=osk+vND+HW86d1cRh9KcrOolHSU9IEDCD1J6kFaurZ5Gf2rUV8CXzloCeMwQPqno/VVv/cf1nOf2KRIx2x0OWX03jWbPsZVt9a2qSZaIpZloUcvy5x6Hq28eFqgmDD/KkP9NVtAu89OLK2ki5Gp8ZvWKrq37a+aetBSXNA7rJZw=
Received: from SJ0PR04MB7165.namprd04.prod.outlook.com (2603:10b6:a03:2a3::21)
 by SJ0PR04MB7232.namprd04.prod.outlook.com (2603:10b6:a03:294::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 20 Aug
 2021 00:45:30 +0000
Received: from SJ0PR04MB7165.namprd04.prod.outlook.com
 ([fe80::51f7:9917:542f:1836]) by SJ0PR04MB7165.namprd04.prod.outlook.com
 ([fe80::51f7:9917:542f:1836%7]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 00:45:29 +0000
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
Thread-Index: AQHXlVysvcZeBwZKNkSbW/SgpyhLOw==
Date:   Fri, 20 Aug 2021 00:45:29 +0000
Message-ID: <YR77J/aE6sWZ6Els@x1-carbon>
References: <20210618004456.7280-1-bvanassche@acm.org>
 <20210618004456.7280-17-bvanassche@acm.org>
In-Reply-To: <20210618004456.7280-17-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c77ebab-154f-4c5c-88fe-08d96373cf4a
x-ms-traffictypediagnostic: SJ0PR04MB7232:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB72322AD384F03C01BB192CD9F2C19@SJ0PR04MB7232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BwPUDWV2rAM8WmE07JgfddnasNzoULHwVGgzhOOZk8pvYsHssbqjx3V68Wo6QceLO6MWxfL8NBfV2fShnujEcutNTpj7RdX3+JvhtuDS7/BVDKXEmGm5phoKvnstDFCrwdLoMivnzTT8youkCsHwMWTzInGF3caQW1h7/vwbMsMR4omg/TbkFQMIb8w26A+bFyoAI7Uak6UHv9eFK+s8hJaaTGcV6BmR6g9+GS20W4Q+y8iaO9T+vg2wKxVpeHW4oVvdbiMDnoXJqsB8AYls9GWukfjD5naU04Kx49UCWuFLna8hPZezO0K2f6tVkkCh8qiAONdyDWTnrTB3XBeRjOi73hOSxL95vxFpzFxHoEHpU8BqYnt81yG3YNr7RMDPTJOGXUSveMbjFrGDs9ZpF4u4nGmiqnF7DObNcywr1wPR88St3pvEYRIcNGZfyTr9Ufs+GrDOKz2tT9Xs3+DSDyZ+dJMHEo3psGEZqQzRFbK8lyjiOQ30e7ai53jyKJmsVM/oOdRzPPjjs3qYwFMPfyZGoPEREC3ww6LFJoXE0fdvSUTchHgBuoly+UD8OrFSl41hQls4f99mAdSVDv9MifKllamaBR9huDHnJKczASDzEsaD2HilQfKJsnf6Q3k4XxCXaUZE1n5IryQuSXtp/2/Zm+xFBHGYLhqN19Yd/U2Qbs6TMpPc3nZ/YI51Jo8COp/F/CfaR92K9Sva9kAjGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7165.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(33716001)(6916009)(38070700005)(6506007)(5660300002)(71200400001)(316002)(86362001)(76116006)(66476007)(26005)(64756008)(91956017)(2906002)(6512007)(6486002)(66446008)(508600001)(9686003)(66946007)(66556008)(30864003)(38100700002)(8936002)(122000001)(186003)(83380400001)(4326008)(8676002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vTSG8MV9FSYMbSW0QzRf+aNaBlPGwSTMdmXwjzVk9vu3001eRzECeV2/HNtp?=
 =?us-ascii?Q?78EokcI6EYCltiLmjV4ozKu5N/eZXiKFweu55eEJf5BjATCHHQShtbw0hqyv?=
 =?us-ascii?Q?Qovckr1RuDoGwX/B8VqdDKBPoGyeVLdtDQJk4lG0UiUXuyGohWXnv/EWwZ5E?=
 =?us-ascii?Q?ZO2Un9MtPKkCclCgYJyflEcGYKi0Nr0SPwmc5zgj0yuSmaU1VRiqqVylyZ6C?=
 =?us-ascii?Q?BVKrpfR3QuMG/bU/hypK98CPL/f7kwwg1rbiwVj+A7KmeyzxP43w0vgKz2uF?=
 =?us-ascii?Q?bQWWdhqQjanYIPC6VZ2DwlWo4S9i5SDMlcimIpkd+QByW4ZaPuf0v0WC5RQa?=
 =?us-ascii?Q?5NjoLMuWTNXdTmDdv1BtPQg973unLk0QztFKQbK8OViRXQVAuiMhezXE7YNz?=
 =?us-ascii?Q?pkZdTyoL/rrHP8NYr9JbeyvsO6JdS1wh41gS1ONcMG38gdMlmDPo3B7aptWR?=
 =?us-ascii?Q?L+Aajv/ZzEzoWO42/hABmuBqhP7bJmK4DPbo3PfRKLb2UMeQTlhzYhnn5pL+?=
 =?us-ascii?Q?LF+qp81hbNcbdIk3qVwhCfy+IPJWTcdSFK7thzhHxpa0HiJsmO8FKOnROHrU?=
 =?us-ascii?Q?KQDOpdN2dHgxSBeqZNZ1vZ2Hql2GcM14/89TsIK+5K+4XpYSW0v/XXloU1qH?=
 =?us-ascii?Q?zi6NTm40B2kYTT2NMhQ6eKATcpUxJDJ0Zdf+g/e/tcs1m36DGPnMzerCEDAa?=
 =?us-ascii?Q?n5jNrr/ziAXQrZhhvEO0nWbPzIFaWbad4IdBYvw3WBxbsVFd5ljNwedgF6h+?=
 =?us-ascii?Q?IJjjpz8itmLrDRV/b10uWi1ayydTaYPXBCj0R6gSIxldQ2A0ExfGYqJbT7/5?=
 =?us-ascii?Q?5U/oG+Du4yvFMpa0Ywnjs4R63VL0OFJnRM6/dj+Mt/PMT+UUQUNmnZ0pinC/?=
 =?us-ascii?Q?2XOhuw67UpqZUN8igIKfm8W7Jp04r0s8MqqIiZcGAMwFdJ865N/6e8DJbkDh?=
 =?us-ascii?Q?/X09GEqN8atexs8bONbHa8I6FC8qL9sywcD2IsEtTSpn00hBeVRD2Hpm8S9y?=
 =?us-ascii?Q?jMLFJHZIdwgNQgxO3655/bAI0bNqZ2VVqqBuRC4Urj9nn0iNEXRKJeJTTYw3?=
 =?us-ascii?Q?N7iEZlOcqUXr/3s2IzpzkzVMp7hj6dhWi0t1v0GfjQBpMR//ZNb4SA8JMxaN?=
 =?us-ascii?Q?4G7dzoDTbzkKyYidxY3nNb6TSlaoRvqry+yge4M6EYumXLAnpgkWkVztWqq2?=
 =?us-ascii?Q?YVJnGaMVlcCD90wtrZreGK4nSZ8PDDk5Aqtyu8UtlBLVu+ShSQVjIpenxUi0?=
 =?us-ascii?Q?HZOwsMAwGIMxCdTDCeiFZhUMq4xqWrizvVm+fLooeTB4jJ4ts+crZEKkHJVH?=
 =?us-ascii?Q?p/FnUVu+HDbuktVXCAxVxKJeyde7wDKog4XqzgUh9cMA5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67C1AE6C37103043A7D5256FC06A6FCD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7165.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c77ebab-154f-4c5c-88fe-08d96373cf4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 00:45:29.8528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9x3MWJOZZ9u5zHPd4pdMc/EZv/AguG5NXFK6XLATRT7fD2PDhEpJzi3edds4Aj6Bv5wKslLCLfues6sTXPOLgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7232
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 05:44:56PM -0700, Bart Van Assche wrote:
> While one or more requests with a certain I/O priority are pending, do no=
t
> dispatch lower priority requests. Dispatch lower priority requests anyway
> after the "aging" time has expired.
>=20
> This patch has been tested as follows:
>=20
> modprobe scsi_debug ndelay=3D1000000 max_queue=3D16 &&
> sd=3D'' &&
> while [ -z "$sd" ]; do
>   sd=3D/dev/$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/=
target*/*/block/*)
> done &&
> echo $((100*1000)) > /sys/block/$sd/queue/iosched/aging_expire &&
> cd /sys/fs/cgroup/blkio/ &&
> echo $$ >cgroup.procs &&
> echo restrict-to-be >blkio.prio.class &&
> mkdir -p hipri &&
> cd hipri &&
> echo none-to-rt >blkio.prio.class &&
> { max-iops -a1 -d32 -j1 -e mq-deadline $sd >& ~/low-pri.txt & } &&
> echo $$ >cgroup.procs &&
> max-iops -a1 -d32 -j1 -e mq-deadline $sd >& ~/hi-pri.txt
>=20
> Result:
> * 11000 IOPS for the high-priority job
> *    40 IOPS for the low-priority job
>=20
> If the aging expiry time is changed from 100s into 0, the IOPS results ch=
ange
> into 6712 and 6796 IOPS.
>=20
> The max-iops script is a script that runs fio with the following argument=
s:
> --bs=3D4K --gtod_reduce=3D1 --ioengine=3Dlibaio --ioscheduler=3D${arg_e} =
--runtime=3D60
> --norandommap --rw=3Dread --thread --buffered=3D0 --numjobs=3D${arg_j}
> --iodepth=3D${arg_d} --iodepth_batch_submit=3D${arg_a}
> --iodepth_batch_complete=3D$((arg_d / 2)) --name=3D${positional_argument_=
1}
> --filename=3D${positional_argument_1}
>=20
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---

(snip)

> @@ -484,15 +495,32 @@ static struct request *__dd_dispatch_request(struct=
 deadline_data *dd,
>  static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct deadline_data *dd =3D hctx->queue->elevator->elevator_data;
> -	struct request *rq;
> +	const u64 now_ns =3D ktime_get_ns();
> +	struct request *rq =3D NULL;
>  	enum dd_prio prio;
> =20
>  	spin_lock(&dd->lock);
> -	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {
> -		rq =3D __dd_dispatch_request(dd, &dd->per_prio[prio]);
> +	/*
> +	 * Start with dispatching requests whose deadline expired more than
> +	 * aging_expire jiffies ago.
> +	 */
> +	for (prio =3D DD_BE_PRIO; prio <=3D DD_PRIO_MAX; prio++) {
> +		rq =3D __dd_dispatch_request(dd, &dd->per_prio[prio], now_ns -
> +					   jiffies_to_nsecs(dd->aging_expire));
>  		if (rq)
> +			goto unlock;
> +	}
> +	/*
> +	 * Next, dispatch requests in priority order. Ignore lower priority
> +	 * requests if any higher priority requests are pending.
> +	 */
> +	for (prio =3D 0; prio <=3D DD_PRIO_MAX; prio++) {
> +		rq =3D __dd_dispatch_request(dd, &dd->per_prio[prio], now_ns);
> +		if (rq || dd_queued(dd, prio))
>  			break;
>  	}

Hello Bart,

I'm seeing some unwanted behavior since this patch was introduced.

If I have two processes submitting IO, one with IO class RT,
and one with IO class IDLE.

What happens is that in the "Next, dispatch requests in priority order."
for-loop, even when there are no RT requests to dispatch (

Here are some trace_printk's that I've added:

             fio-1493    [029] ...1   254.606782: dd_insert_requests: dd pr=
io: 0 prio class: 1
First RT req inserted.

             fio-1493    [029] ...3   254.606786: dd_dispatch_request: chec=
king dd_prio: 0
             fio-1493    [029] ...3   254.606786: __dd_dispatch_request: dd=
 prio: 0 prio class: 1
The first RT req gets dispatched immediately.

             fio-1493    [029] ...3   254.606791: dd_dispatch_request: rq ?=
 ffff888144ff6800 queued ? 1
             fio-1493    [029] ...1   254.607005: dd_insert_requests: dd pr=
io: 2 prio class: 3
First IDLE req inserted. Will be put on hold (for a max of aging_expire).

             fio-1493    [029] ...3   254.607007: dd_dispatch_request: chec=
king dd_prio: 0
             fio-1493    [029] ...3   254.607008: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 1
             fio-1493    [029] ...1   254.607132: dd_insert_requests: dd pr=
io: 2 prio class: 3
             fio-1493    [029] ...3   254.607134: dd_dispatch_request: chec=
king dd_prio: 0
             fio-1493    [029] ...3   254.607134: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 1
             fio-1493    [029] ...1   254.607261: dd_insert_requests: dd pr=
io: 0 prio class: 1
Second RT req is inserted.

             fio-1493    [029] ...3   254.607262: dd_dispatch_request: chec=
king dd_prio: 0
             fio-1493    [029] ...3   254.607263: __dd_dispatch_request: dd=
 prio: 0 prio class: 1
Second RT req gets dispatched immediately.

             fio-1493    [029] ...3   254.607263: dd_dispatch_request: rq ?=
 ffff888144ff71c0 queued ? 2
             fio-1493    [029] ...3   254.607264: dd_dispatch_request: chec=
king dd_prio: 0
             fio-1493    [029] ...3   254.607265: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 2
             fio-1493    [029] ...3   254.607274: dd_dispatch_request: chec=
king dd_prio: 0
             fio-1493    [029] ...3   254.607274: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 2
             fio-1493    [029] ...1   254.607439: dd_insert_requests: dd pr=
io: 2 prio class: 3
             fio-1493    [029] ...3   254.607440: dd_dispatch_request: chec=
king dd_prio: 0
             fio-1493    [029] ...3   254.607441: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 2
             fio-1493    [029] ...1   254.607618: dd_insert_requests: dd pr=
io: 2 prio class: 3
             fio-1493    [029] ...3   254.607619: dd_dispatch_request: chec=
king dd_prio: 0
             fio-1493    [029] ...3   254.607620: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 2
             fio-1493    [029] ...1   254.607789: dd_insert_requests: dd pr=
io: 2 prio class: 3
             fio-1493    [029] ...3   254.607790: dd_dispatch_request: chec=
king dd_prio: 0
             fio-1493    [029] ...3   254.607791: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 2
             fio-1493    [029] ..s.   254.607860: dd_finish_request: dd pri=
o: 0 prio class: 1
First RT req is finished. IDLE requests are still on hold, since the second=
 RT req hasn't finished yet.

             fio-1493    [029] ...1   254.607978: dd_insert_requests: dd pr=
io: 2 prio class: 3
             fio-1493    [029] ...3   254.607980: dd_dispatch_request: chec=
king dd_prio: 0
             fio-1493    [029] ...3   254.607980: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 1
             fio-1493    [029] ...1   254.608021: dd_insert_requests: dd pr=
io: 2 prio class: 3
             fio-1493    [029] ...3   254.608022: dd_dispatch_request: chec=
king dd_prio: 0
             fio-1493    [029] ...3   254.608023: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 1
          <idle>-0       [029] .Ns1   254.608657: dd_finish_request: dd pri=
o: 0 prio class: 1
Second RT req is finished.

             fio-1493    [029] ...1   254.608672: dd_insert_requests: dd pr=
io: 2 prio class: 3
             fio-1493    [029] ...3   254.608674: dd_dispatch_request: chec=
king dd_prio: 0
There are no RT reqs waiting to get dispatched, and no RT reqs in flight.

             fio-1493    [029] ...3   254.608675: dd_dispatch_request: chec=
king dd_prio: 1
Therefore the loop continues to examine the next dd_prio (BE)

             fio-1493    [029] ...3   254.608675: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 4294967100
There are no BE reqs waiting to get dispatched, however there are 429496710=
0 reqs in flight.

Since it says that there are BE reqs in flight, we never continue the loop =
to examine IDLE reqs.
(This number is obviously bogus.)
If there wasn't any BE reqs in flight, the loop would have moved on, and di=
spatched the IDLE reqs
at this point in time.
(Since there isn't any RT reqs to handle.)

   kworker/29:1H-464     [029] ...2   254.612489: dd_dispatch_request: chec=
king dd_prio: 0
   kworker/29:1H-464     [029] ...2   254.612490: dd_dispatch_request: chec=
king dd_prio: 1
   kworker/29:1H-464     [029] ...2   254.612491: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 4294967100
   kworker/29:1H-464     [029] ...2   254.616483: dd_dispatch_request: chec=
king dd_prio: 0
   kworker/29:1H-464     [029] ...2   254.616484: dd_dispatch_request: chec=
king dd_prio: 1
   kworker/29:1H-464     [029] ...2   254.616485: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 4294967100
   kworker/29:1H-464     [029] ...2   254.620479: dd_dispatch_request: chec=
king dd_prio: 0
   kworker/29:1H-464     [029] ...2   254.620480: dd_dispatch_request: chec=
king dd_prio: 1
   kworker/29:1H-464     [029] ...2   254.620481: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 4294967100
   kworker/29:1H-464     [029] ...2   254.624481: dd_dispatch_request: chec=
king dd_prio: 0
   kworker/29:1H-464     [029] ...2   254.624482: dd_dispatch_request: chec=
king dd_prio: 1
   kworker/29:1H-464     [029] ...2   254.624482: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 4294967100
   kworker/29:1H-464     [029] ...2   254.628478: dd_dispatch_request: chec=
king dd_prio: 0
   kworker/29:1H-464     [029] ...2   254.628479: dd_dispatch_request: chec=
king dd_prio: 1
   kworker/29:1H-464     [029] ...2   254.628480: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 4294967100
   kworker/29:1H-464     [029] ...2   254.632478: dd_dispatch_request: chec=
king dd_prio: 0
   kworker/29:1H-464     [029] ...2   254.632479: dd_dispatch_request: chec=
king dd_prio: 1
   kworker/29:1H-464     [029] ...2   254.632480: dd_dispatch_request: rq ?=
 0000000000000000 queued ? 4294967100
   kworker/29:1H-464     [029] ...2   254.636477: dd_dispatch_request: chec=
king dd_prio: 0
   kworker/29:1H-464     [029] ...2   254.636477: dd_dispatch_request: chec=
king dd_prio: 1

...

   kworker/29:1H-464     [029] ...2   264.607254: __dd_dispatch_request: dd=
 prio: 2 prio class: 3
Instead, because of the broken accouting of BE reqs, we have to wait 10 sec=
onds,
until the aging_expire timeout occurs, until the first IDLE request is fina=
lly dispatched.
If it wasn't for the broken BE accounting, this first IDLE req would have b=
een dispatched
as soon as the second RT req finished.



So, what is wrong here?

1) The "Next, dispatch requests in priority order." for-loop does:

 if (rq || dd_queued(dd, prio))

To check if it should process requests for the next priority class or not.

dd_queued() calls dd_sum() which has this comment:

/*                                                                         =
                =20
 * Returns the total number of dd_count(dd, event_type, prio) calls across =
all             =20
 * CPUs. No locking or barriers since it is fine if the returned sum is sli=
ghtly           =20
 * outdated.                                                               =
                =20
 */

Perhaps not so got to use an accounting that is not accurate to determine
if we should process IOs belonging to a certain priority class or not.

Perhaps we could use e.g. atomics instead of per cpu counters without
locking?


2) I added even more trace_printk's and I saw this:

#                                _-----=3D> irqs-off
#                               / _----=3D> need-resched
#                              | / _---=3D> hardirq/softirq
#                              || / _--=3D> preempt-depth
#                              ||| /     delay
#           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
#              | |         |   ||||      |         |
  kworker/u64:11-628     [026] ....    13.650123: dd_finish_request: dd pri=
o: 1 prio class: 0
  kworker/u64:11-628     [026] ....    13.650125: dd_queued_print: ins: 0 c=
omp: 1 queued: 4294967295
   kworker/u64:3-289     [023] ....    13.650217: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:3-289     [023] ....    13.650219: dd_queued_print: ins: 0 c=
omp: 1 queued: 4294967295
   kworker/u64:0-7       [030] ....    13.650226: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:0-7       [030] ....    13.650229: dd_queued_print: ins: 0 c=
omp: 1 queued: 4294967295
   kworker/u64:2-288     [014] ....    13.650365: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:2-288     [014] ....    13.650367: dd_queued_print: ins: 0 c=
omp: 1 queued: 4294967295
   kworker/u64:8-294     [024] ....    13.650405: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:8-294     [024] ....    13.650407: dd_queued_print: ins: 0 c=
omp: 1 queued: 4294967295
   kworker/u64:9-296     [018] ....    13.650418: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:9-296     [018] ....    13.650420: dd_queued_print: ins: 0 c=
omp: 1 queued: 4294967295
   kworker/u64:7-293     [031] ....    13.650444: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:7-293     [031] ....    13.650446: dd_queued_print: ins: 0 c=
omp: 1 queued: 4294967295
   kworker/u64:4-290     [001] ....    13.650491: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:4-290     [001] ....    13.650493: dd_queued_print: ins: 0 c=
omp: 1 queued: 4294967295
   kworker/u64:8-294     [024] ....    13.650588: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:8-294     [024] ....    13.650588: dd_queued_print: ins: 0 c=
omp: 2 queued: 4294967294
   kworker/u64:2-288     [014] ....    13.650621: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:2-288     [014] ....    13.650622: dd_queued_print: ins: 0 c=
omp: 2 queued: 4294967294
   kworker/u64:7-293     [031] ....    13.650642: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:7-293     [031] ....    13.650643: dd_queued_print: ins: 0 c=
omp: 2 queued: 4294967294
   kworker/u64:9-296     [018] ....    13.650653: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:9-296     [018] ....    13.650654: dd_queued_print: ins: 0 c=
omp: 2 queued: 4294967294
   kworker/u64:4-290     [001] ....    13.650690: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:4-290     [001] ....    13.650691: dd_queued_print: ins: 0 c=
omp: 2 queued: 4294967294
   kworker/u64:8-294     [024] ....    13.650764: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:8-294     [024] ....    13.650765: dd_queued_print: ins: 0 c=
omp: 3 queued: 4294967293
   kworker/u64:2-288     [014] ....    13.650774: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:2-288     [014] ....    13.650774: dd_queued_print: ins: 0 c=
omp: 3 queued: 4294967293
   kworker/u64:9-296     [018] ....    13.650800: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:9-296     [018] ....    13.650801: dd_queued_print: ins: 0 c=
omp: 3 queued: 4294967293
   kworker/u64:7-293     [031] ....    13.650833: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:7-293     [031] ....    13.650834: dd_queued_print: ins: 0 c=
omp: 3 queued: 4294967293
   kworker/u64:8-294     [024] ....    13.650865: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:8-294     [024] ....    13.650866: dd_queued_print: ins: 0 c=
omp: 4 queued: 4294967292
...
   kworker/u64:2-288     [014] ....    13.655333: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:2-288     [014] ....    13.655334: dd_queued_print: ins: 0 c=
omp: 19 queued: 4294967277
   kworker/u64:9-296     [018] ....    13.655382: dd_finish_request: dd pri=
o: 1 prio class: 0
   kworker/u64:9-296     [018] ....    13.655383: dd_queued_print: ins: 0 c=
omp: 19 queued: 4294967277
   kworker/u64:4-290     [001] ...1    13.655564: dd_insert_requests: dd pr=
io: 1 prio class: 0
Here comes the first insert...

   kworker/u64:4-290     [001] ...1    13.655565: dd_queued_print: ins: 1 c=
omp: 12 queued: 4294967285
   kworker/u64:9-296     [018] ...1    13.655565: dd_insert_requests: dd pr=
io: 1 prio class: 0
   kworker/u64:2-288     [014] ...1    13.655565: dd_insert_requests: dd pr=
io: 1 prio class: 0
   kworker/u64:9-296     [018] ...1    13.655566: dd_queued_print: ins: 1 c=
omp: 19 queued: 4294967278
   kworker/u64:2-288     [014] ...1    13.655566: dd_queued_print: ins: 1 c=
omp: 19 queued: 4294967278
   kworker/u64:8-294     [024] ....    13.655662: dd_finish_request: dd pri=
o: 1 prio class: 0

What appears to be happening here is that dd_finish_request() gets called a=
 bunch of times,
without any preceeding dd_insert_requests() call.

Reading the comment above dd_finish_request():

 * Callback from inside blk_mq_free_request().

Could it be that this callback is done on certain requests that was never
sent down to mq-deadline?
Perhaps blk_mq_request_bypass_insert() or blk_mq_try_issue_directly() was
called, and therefore dd_insert_requests() was never called for some of the
ealiest requests in the system, but since e->type->ops.finish_request() is
set, dd_finish_request() gets called on free anyway.

Since dd_queued() is defined as:
	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
And since we can see that we have several calls to dd_finish_request()
that has increased the completed counter, dd_queued() returns a
very high value, since 0 - 19 =3D 4294967277.

This is probably the bug that causes the bogus accouting of BE reqs.
However, looking at the comment for dd_sum(), it also doesn't feel good
to rely on something that is "slightly outdated" to determine if we
should process a whole io class or not.
Letting requests wait for 10 seconds when there are no other outstanding
requests in the scheduler doesn't seem like the right thing to do.

Kind regards,
Niklas=
