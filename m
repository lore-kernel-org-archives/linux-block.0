Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB773C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 02:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D05264E38
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 02:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhCACuh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Feb 2021 21:50:37 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:55375 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhCACug (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Feb 2021 21:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614567133; x=1646103133;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hPZ+A+LubE1TseaVeGmYTHISZx3G0xHS490YebNBKlM=;
  b=gbrzO/UJq1tP7zlpAcGmYSQhEuxwKVfuKt2jyKsxF+EA+jCEFySJ4VXj
   eeRwd9hLxN2Eae+a2BdcetbrjjnhVeXMEhIQxbFt4n8+BXLdmE5zWWf+m
   80g5twkMkAWwsFvo8Ok02rej/+RZeF/qaR5bdDD3vQ0r8j5OgdLGFhzkg
   fCKn0AWGvG0mLlpUBDicoeNYPuhQuJHGORVACPyKgdRg0KH+Lgjg1FJX/
   wCy/JVaeQ2ysVgbT0OPv7Ift5eZoCyp48uRWlzN7U1Ga9Rn7SwihpXEvt
   2MOwXOB+Zs8JuLsjP5PyGhBmgSAoARbdlRon/jJbgEQGKsO0EUGhyh8NL
   g==;
IronPort-SDR: /As6ryXAVw5KtYoDwbZIvaNGhE7+uZNbzMia+nPlSYTUJn1a74ar6XqKoPnbd2H9ywJZsExII7
 v7bPy8H5yKUUNarAYjtqYCFobhh5Gw0XEvcYbRkNfoNnvyShp1JyY1NRjAznIarg9+PEjzCCGJ
 HRxR6oavDsWSTOkbq+HDwOJkOk4n1FTB4LEUITL0qG7IeLvlop/H+ijHHx09oBS3YKUvk3ZGTR
 2eAMsoq5Ng1iEwPpg7ELD5Idne/XlSIu57u6E9NSYbTGL83yC66+Jry95MLcFzNF0kl3pdvztd
 1Vg=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; 
   d="scan'208";a="265290406"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 10:50:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlHMNSObG3CstHPp8oOjcOBMhYAAu/isj4CDmChsipaUXmvv6xib9zG77c7AmZjmPdqRgwTVDdvEQ2pOQio/tW2x2lEyjaX0KJzqzd33sp8q9lbU9zHTHOSsSbHyQNve0EGkG4e8JvKcgkygYc2Lp0f7blVUllkdbduUx56u7BjRZhvcVy1uVCleYUbK0K6DZmMqJ1XJnadye/rZUpbXe2NDbenUq7bqylWraK4LjzYhVREKnmq3LWUG96dcAKqyFSQ65T5dAG0hNJ0TxHl8GcQW/rWmxCNRTLsatKPKpEhPV0SPj1f07iVcbnyy6KJ0GFV4c5a8L9Tk+oDBsiJbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFGg/ueuA7MwkYwCzzw/ASDT8xA9juWtKHoI/ZWKEDw=;
 b=N5zKcGhgy95alco6jNaMfffWQ9nGh9kCND9hvp99x1cwIeq9g04fOuNo3P7vwibqRgXuP4s2eD39PP42cTMXcs00UXdE/XLUOWXeC6Bz9XFOqJMJU2utdddCcVnSKV4NCfXNV5hHVH19815pLPZphob1550GSIAu+WPkHPCHeB0TG8p3wa0orXXl0KYeL2bfRbEtEmIxls3hf8El5DHy4AvRQfjm9jORzjLwuL33eTU6BIvEWnm4kRc+YfLVB0nFIbYnPByYP147xQQ8Kscfy3xSdXfzzoWFkLDTS9stPj0F5pxd34aW50n6LzC4+AsjLyMjoYoC8uWewAv+7i4/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFGg/ueuA7MwkYwCzzw/ASDT8xA9juWtKHoI/ZWKEDw=;
 b=BNa0bEnJOLCOy6NYW1aqUCku1S/N41qOS1kCQQfy/crPlWCPgNyYrYxw4UE/lbQazubHR6yy9ta2UZPOcKQqzzvJdytYdsbGyQ1CQ2BR69GsOSmlGNBIOo8LPw5fOCuo3nbJT/ZYBi+9crGLGWrSPsmuRwr9EOu65zmFbKZYeeM=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4770.namprd04.prod.outlook.com (2603:10b6:208:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 1 Mar
 2021 02:49:28 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 02:49:28 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Yufen Yu <yuyufen@huawei.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [RFC PATCH 1/2] blk-mq: test tags bitmap before get request
Thread-Topic: [RFC PATCH 1/2] blk-mq: test tags bitmap before get request
Thread-Index: AQHXDkBn2BVgEXbcxkKfVSLaweLNNA==
Date:   Mon, 1 Mar 2021 02:49:28 +0000
Message-ID: <BL0PR04MB65141AF7BB3E37828FC77473E79A9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210301021444.4134047-1-yuyufen@huawei.com>
 <20210301021444.4134047-2-yuyufen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:347a:bb00:3286:307b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c62cd4b8-6bd3-4cb4-47dc-08d8dc5ca1b5
x-ms-traffictypediagnostic: BL0PR04MB4770:
x-microsoft-antispam-prvs: <BL0PR04MB47702461D59928D541B6641DE79A9@BL0PR04MB4770.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KGmiagMCRUdplKlF7Sk4CS5wMFA7J7FR0rqPFgsBT8lJ1LPt+OXeYFLp5ZH0w7O/YFCXqOx2yMlt4r0DaSwpJxe19l+3pUBqsYFqbDBzi0qPhUZnsa2K78GYKm+bfImIo5QoOmbnPwWGT0AZvjEQEILEW5oh6MwL+Bz4wjilWhwjZsO6Txh8Ao3FKgu+xgiptD35zNbvOEPQ2+vBEwQFZ8IK5eqR+JYXkLIVg4j7IdIcuxoNXndpvKq0uIH+mJDjw7RaxPAW0dLYWl4ifDlzZKsZcwJuBzjC9HlbLmmrRORoyVnDyd8FasQYRkeY8vBSiWNmnwqE1X/3zLVFhvYjTdfCsehthYlJr4pNdaKK8Nxi905lwnshPxW6GG8fTthriZTorg1KZIeDQP6TAv3MaGkiGSy7xiLEpn+R8EEnCwi4JdR3m+JrETGvc/msyhC6n19xq3luMhK4kD1HPX6lFz/sZdt2YUPU8FBlFyo5cEHX/6QeOQNNVGaYctbc5koEHZuvVwZguM0kFUWvHdc+qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(8676002)(186003)(5660300002)(6506007)(7696005)(71200400001)(55016002)(8936002)(52536014)(9686003)(86362001)(53546011)(33656002)(316002)(54906003)(110136005)(83380400001)(4326008)(478600001)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kDGVJg4g2zo3V0wCwlfT3o7GEHIlTLDfmWwF+pKmvB0v9Y0QdDegvirMUOTg?=
 =?us-ascii?Q?FwNbj8LZA2cKo/ePLqw6ibQHQJvuk7svAi/WLc2fTVh2FwlCyj/1FAlqM7v5?=
 =?us-ascii?Q?6JP1ovgnqU4r0D07AonvFMH0/sI1SFRbhNS2ROdqbHfi7fzR8bfWrInXNCN7?=
 =?us-ascii?Q?IELfARzmohHXHvbvEmsbF9zLJRhJ2jW9eBZelZlXxdfktEV+m4ozts9s5FYH?=
 =?us-ascii?Q?kccu3vkljZZxjxPQLCgCvgtwRYhPl7rku4eYdfr50PNZxoKIQY6eNfi8jmQd?=
 =?us-ascii?Q?cgduRZb/6l09cNMCpEAFqVpE/IZuaYyXLhoC1YBHXIgI9IrBocpwprueslOa?=
 =?us-ascii?Q?D1xBlQGyER1jMHscrpNoaxlPPDqsTjnl+pXHI5aYo/PXRpahsLv4D04F/HVx?=
 =?us-ascii?Q?pY379xoKGpomHUWUE5KglVVrQkoYRU/+LM9DWuqKTWg8uzlqgWrQ+8MX6sai?=
 =?us-ascii?Q?T2CYNjW1KHdRA6A/UUvBuIucOac2sJ2p8kkXijfotv3M83rkvOjDezpoWQ1a?=
 =?us-ascii?Q?IYVOqzbCbgxuWbjvU3rJC/HJoiYbX86OOo+KdenopDFBIekM5rWCUItDyYi7?=
 =?us-ascii?Q?Y3axoxDr6P8YT0OCKttrUDFLOMIIkaT8FgrCS3IJPn6WrYYi9rK9wy7Cn9A2?=
 =?us-ascii?Q?0F0AUos7J6IS0ZwWWctgARTRTagN+w8eAy099kCfgQItXQr6mOQaneHatIeq?=
 =?us-ascii?Q?noc6eDzcaABNWHvyXsKoJzBpsiDa1oEjBEpQBgQRLZitDhQelf6dNmIHOJcd?=
 =?us-ascii?Q?DvpW5Q7TD+mqQG1+7IzpUG5azUqumboyxF9m04Yf7bn5iXT8XbcaCUFsgoIC?=
 =?us-ascii?Q?uB3RFK7c1wcfbQA3KQDaC6mCy2+t7pNpq2V1tCn2cyyxjUUK8rHmLpRW5ISy?=
 =?us-ascii?Q?Pkk/o+J3RbVYk7PffPCPZVYDzoCoB6ZTFHyQS4vqhGIf9Or6MansUn8e/awy?=
 =?us-ascii?Q?546q2nFuB4BiqtYsRMqxIIU3qeYakdrzPGha1zJivSRMdgWNFUWasRDVYLWR?=
 =?us-ascii?Q?PdMybLpALoIlyTW+VzBmVdZwODdjpASeexBe28hzHvLHvNXi1z8KjuaSiq1U?=
 =?us-ascii?Q?l5WdfB+tmnQye1ewUuCxX4u0qk8egiY+wx4Pvw3ykUvo7IU8VE10PLqyQ+L4?=
 =?us-ascii?Q?mQT3fPLMBxkSAy4PxIZkM2WEUOnkFRvOuttt8fgfigtkvkYWi81euiwYr8Ay?=
 =?us-ascii?Q?JKuAZoKU6Qade81NU4qXwzRDJfIXBA0IbOdjUVimol/YYfW5a43iOIvLR77e?=
 =?us-ascii?Q?1cnOgHov8b8hMxt47lFe1rJoWoWCM7gkfKZM+QiAvYu9+pkFxOsX1PJDmVlt?=
 =?us-ascii?Q?iUzlOPp8egx+8doZClu5R0Icp08IQQyzUNo89zSG4z04i/MkbvWzO0DvBfc/?=
 =?us-ascii?Q?2gbiopO3OHG0hBOQdX8Z4N2EyZvo63YRJCEn+W0Q6nDLEv4nhw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62cd4b8-6bd3-4cb4-47dc-08d8dc5ca1b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 02:49:28.0282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFPP93ltuYYb25y+hzYTgBJsg9v4YrSJR9g0bFwY5sL6GJZbM6fGtprlT9V6voaGoy5cSS1iIdL4n8VufhS7kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4770
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/03/01 11:13, Yufen Yu wrote:=0A=
> For now, we set hctx->tags->rqs[i] when get driver tag successfully.=0A=
> The request either comes from sched_tags->static_rqs[] with scheduler,=0A=
> or comes from tags->static_rqs[] with no scheduler. But, the value won't=
=0A=
> be clear when put driver tag. Thus, tags->rqs[i] still remain old request=
.=0A=
> =0A=
> We can free these sched_tags->static_rqs[] requests when switch elevator,=
=0A=
> update nr_requests or update nr_hw_queues. After that, unexpected access=
=0A=
> of tags->rqs[i] may cause use-after-free crash.=0A=
> =0A=
> For example, we reported use-after-free of request in nbd device=0A=
> by syzkaller:=0A=
> =0A=
> BUG: KASAN: use-after-free in blk_mq_request_started+0x24/0x40 block/blk-=
mq.c:644=0A=
> Read of size 4 at addr ffff80036b77f9d4 by task kworker/u9:0/10086=0A=
> Call trace:=0A=
>  dump_backtrace+0x0/0x310 arch/arm64/kernel/time.c:78=0A=
>  show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158=0A=
>  __dump_stack lib/dump_stack.c:77 [inline]=0A=
>  dump_stack+0x144/0x1b4 lib/dump_stack.c:118=0A=
>  print_address_description+0x68/0x2d0 mm/kasan/report.c:253=0A=
>  kasan_report_error mm/kasan/report.c:351 [inline]=0A=
>  kasan_report+0x134/0x2f0 mm/kasan/report.c:409=0A=
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]=0A=
>  __asan_load4+0x88/0xb0 mm/kasan/kasan.c:699=0A=
>  __read_once_size include/linux/compiler.h:193 [inline]=0A=
>  blk_mq_rq_state block/blk-mq.h:106 [inline]=0A=
>  blk_mq_request_started+0x24/0x40 block/blk-mq.c:644=0A=
>  nbd_read_stat drivers/block/nbd.c:670 [inline]=0A=
>  recv_work+0x1bc/0x890 drivers/block/nbd.c:749=0A=
>  process_one_work+0x3ec/0x9e0 kernel/workqueue.c:2156=0A=
>  worker_thread+0x80/0x9d0 kernel/workqueue.c:2311=0A=
>  kthread+0x1d8/0x1e0 kernel/kthread.c:255=0A=
>  ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1174=0A=
> =0A=
> The syzkaller test program sended a reply package to client=0A=
> without client sending request. After receiving the package,=0A=
> recv_work() try to get the remained request in tags->rqs[]=0A=
> by tag, which have been free.=0A=
> =0A=
> To avoid this type of problem, we may need to ensure the request=0A=
> valid when get it by tag.=0A=
> =0A=
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>=0A=
> ---=0A=
>  block/blk-mq.c | 10 +++++++++-=0A=
>  1 file changed, 9 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index d4d7c1caa439..5362a7958b74 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -836,9 +836,17 @@ void blk_mq_delay_kick_requeue_list(struct request_q=
ueue *q,=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);=0A=
>  =0A=
> +static int blk_mq_test_tag_bit(struct blk_mq_tags *tags, unsigned int ta=
g)=0A=
> +{=0A=
> +	if (!blk_mq_tag_is_reserved(tags, tag))=0A=
> +		return sbitmap_test_bit(&tags->bitmap_tags->sb, tag);=0A=
> +	else=0A=
=0A=
No need for else after a return.=0A=
=0A=
> +		return sbitmap_test_bit(&tags->breserved_tags->sb, tag);=0A=
> +}=0A=
> +=0A=
>  struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int =
tag)=0A=
>  {=0A=
> -	if (tag < tags->nr_tags) {=0A=
> +	if (tag < tags->nr_tags && blk_mq_test_tag_bit(tags, tag)) {=0A=
>  		prefetch(tags->rqs[tag]);=0A=
>  		return tags->rqs[tag];=0A=
>  	}=0A=
> =0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
