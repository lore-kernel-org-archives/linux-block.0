Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F36AC11F67
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 23:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5225161D68
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 23:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhF2XdH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jun 2021 19:33:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34460 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbhF2XdG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jun 2021 19:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625009450; x=1656545450;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9eyevDGBnk0Y9w8L44YMJkN6fUkF43ValJD6VBSdgnk=;
  b=D5ax5uxTdVAzSu1v1HcbxtxjeF0fMoPFAF3znAjIUthK8y4WNAmNsCk+
   EXiC+3kYu3BUnK8ppmoYqfJ25zs/3wvpY/AyTm52zsdP25oGif1NXtT+/
   NUt2DETNgYN72BwzvU9/qxhcRI/3+48CUeuYCmB899GtX//mtxQTdo3jS
   /1iMjuOMYXX8JGwpwGtdnaGImDdo87bufILZ/W5xnGA6acdwyRLCzd6wC
   574OA9kNWXCj+NNC1PQun1LPcMKEk6YJMucSOzAzsoqymrZ/4m06RwTbB
   rVVIu22/snwtOkg5Q1STph2rsR7rSDOmstW2mhwUd7WBGkUymr5XFQWQo
   A==;
IronPort-SDR: YKnaHyGkAS1D075Fl2sp2Lg5jyEK40xsLDaM9i43m9oQt+jJ2fI6ZLHXqQRgoWsp65wRifP6FQ
 gfA9B+TBFLaqYdIUL3lAzlERV/0kw9V4uQlPWz+Px68PI777OuKnEwNERin6XM/lb85WA0rT6q
 zopbbtabvwpGbR7r0NAOT8CeyQR9XRqGpLYAE1TMdKTr96D/xHCOSM5ZDxswYeQExJ/6qVEZHq
 rykB2V3edEqo0xnGiitxJfi4Bv/Gqa+4RU4nqgHXwqroER19wvbh+Xl+zQ0uvq4OtwbdGbwpEI
 j4M=
X-IronPort-AV: E=Sophos;i="5.83,310,1616428800"; 
   d="scan'208";a="277049626"
Received: from mail-dm3nam07lp2046.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.46])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2021 07:30:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGlSyrn6n+6i6cM+ke15ZlNjMno5gZkuzgYmzQZnHDNwG+7/l11/eWmOiS/wFsXhAaCF6oX4GGcMW52TmtEKeVFQj8cZGnSNduW7AOScmmT1Ps/q8sI3CSK6CV6teWXH8DYafCTmCOQdhtp4gU5jo6c0TU5X+crPmsE3qGmHNPf+vENRdrbRKxrDfdnmhNtmxCm9vBsXYQwLZVQyYS43Ri/7jgcPjx0x6/u16rqQCRG7VEOKeVBCknx31p0xOhxfYlDR8vZcPbijc7IDzn3pb7nsqtv1yCExF2DhSDiIkHdk4y1vGXh8DyJnmfwtyLalcwpCULi+lxlVZD7Q+6eOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu8PyTsLY0Kq6NOqM83kqcJzg0kLBuoyddY1k/w5mOk=;
 b=RT5spdtNULoIBoX5xuGuoVVlNEU3vH9u3IP04KlDpzXQIX5SIFmhSxkGrOnOjfoU3wryTy/qkAAJVNF0vIPU4V6GAyXDnriMv6HaNhWdZuuzJERjOQY1JgzBzqbXOAgVvfEXgRTpMyN39YnOvKrlXmtUu0q/1pkQ8HbhmzaldMnzhPafvGWkpzp+ojpZ23ufpWM7P9OxR1voyDQprILFrMaPgTCSrQKm+MA1fICU7CAB/05/38r+F7xbGW3W/xxf1SAK7isUk3Qd1xwL3RtBBDnVHtqBffhRghOFQKU1BwlbNLT4n2NhjxrYZODxGQXB6IXfCRJM26uDE5U96Th8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu8PyTsLY0Kq6NOqM83kqcJzg0kLBuoyddY1k/w5mOk=;
 b=xcdhgmzc/659iaNKI4q+fPd8Z9CGWZuRAX5PmpyZ9uusWjWIte47SU34+jqPai94GWGIe4ULZ8l6ADSvCcS6vmoa268mnwpxG3ihsKZhDYCQjtn8OdJRsG/wPz0N/jjYIMCE/QUgO+yUA/u21LVNp6l/4kaaUWRlm1r4QqBvAO8=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5243.namprd04.prod.outlook.com (2603:10b6:5:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 23:30:35 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd%9]) with mapi id 15.20.4264.027; Tue, 29 Jun 2021
 23:30:35 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't use
 managed irq
Thread-Topic: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't
 use managed irq
Thread-Index: AQHXbLtuHkNoWHYc2kOLK+PDH01yww==
Date:   Tue, 29 Jun 2021 23:30:35 +0000
Message-ID: <DM6PR04MB70814885C27FF97CFC02A456E7029@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:3c1e:efb:30bd:d238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e058b6b1-438f-46c3-35a2-08d93b55e590
x-ms-traffictypediagnostic: DM6PR04MB5243:
x-microsoft-antispam-prvs: <DM6PR04MB5243CEE68CD7CF51793C1688E7029@DM6PR04MB5243.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZAE17pzl+rbrK6A9Q6wf2gPANVPbv9xe45ZqKt3q+nHCA+lzXZ5lj2uwWaK70mqTQ1NvQkYnmzkPfmAPNWh1VD6Df/pSlyyv3wqxtcYCeGxTPzwc/vSn9eRrWlfhK5PZiGo/533KHVV77y0qEKLaBeVR8gj6lKjAwpOU69reQx0OpIPBdOkL2WgjE/SXUgdz35MZUtXcYpcK93/AwlwDNNR5jun5lPrWWcXaAYXmaTsCZ8W3s2+7Zg+bafg1+jwVdzMYr4q/mQCxrOeivuQg0lGb2wX5TNOquGpSRTQReQuEgqR+t4Sq3kjfmtfWGNoIa7bK7gb7qRV4L37NPxxjLjHcKrX3NaRVNMAX+SbR50HyvMKEdik67beg/2Dxb2SrENCaA31MMIKD18ZKN+LMJZftTliw+D0ufHqAMFXl3RQfAY2ZioUpp646AEYr3QcZ5wNASLTMF398b1U1Kc9V5PPl3p1chd3AA5wTQrcrgkWs+hZ8GkJnItc9lJ8vguP1OrqDAWk3+5Wg42MsBsdUY1q9Gfkgwoy3EwqR4Hh8gjomr+VW6MYyYX1cZFOoW4WGShbtPgLRJ8JOJxP20AIZwobuRuSQFBN9NeWa4wekR3DRdDE+Rqnuk3EPN9gm77hhPCmZZZXLyfqbXoE8kytBEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(66476007)(55016002)(71200400001)(66946007)(64756008)(66556008)(2906002)(122000001)(86362001)(7696005)(52536014)(66446008)(9686003)(8936002)(76116006)(38100700002)(91956017)(478600001)(8676002)(4326008)(6506007)(53546011)(33656002)(54906003)(5660300002)(186003)(83380400001)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?psw6XeuEygRBKdXZGIzD6q1JoROu7bUCd4AEpjju5v7s+/PTAIlFdnFvnJQu?=
 =?us-ascii?Q?XP7RvfAHmrbNQ9xMF7CwNAkWoTe5x4dO3FhArx8PotCOPEByIrTf8GDs4iuH?=
 =?us-ascii?Q?iN80mp42vmY/lPlkbBnKTM/nsRnMx6QG9sl7nw9ShHsS7tVR3N/od9yCDNwk?=
 =?us-ascii?Q?RJ6hGJ526lIqo7ey9iIw4ZXULep2/XEgrl6h1bh0YaTArZdiyML57ElQsQs9?=
 =?us-ascii?Q?B8f6AQPabZUdEqT8POVLxng72o/868BsZbfuKG8iDdhpXsySfCgprNpOR/Xn?=
 =?us-ascii?Q?gPSzXzIP5kttSBkyFITzoxPmSinwJyKjTGWBVVG0rB9K1nedgHLWoRs/QD5/?=
 =?us-ascii?Q?fuGjeJqIdIgpPMXQgIlaQ7PopegIAa8mEpfKIviTQ1f5naIfkk2cKHqhQ/94?=
 =?us-ascii?Q?+AcRBDBG9vdUNeIMKM+1JImEN2Gyjyn/6LZ85zW/u4SnDNSrfXI8Dg6lFCq5?=
 =?us-ascii?Q?aTx38alIGmsEDVEyf78se3p01c+r3JaZtnV8I4g7gRrvt2BMp2E8DmlLpFk7?=
 =?us-ascii?Q?Ltk01j/ifNl4NIkSSUHgVaWlqm+Cus4ez/3SY7QYiSPjogORXvEsGquTSCfo?=
 =?us-ascii?Q?f7TyE1XlKKzcsT5YGvQdFMv61rgEzj7keRN8Gckm+vOgclZENkkdV5Bux7uV?=
 =?us-ascii?Q?c0L2tghhpqIEc/bYfPq9gTtDzA5YSpkGDTZS3uwPw6rk0vzdd+/eMSdz4rXz?=
 =?us-ascii?Q?QP250R3o4ulwax3hsfsqIt4sSgNdvBJSdS0MUfT+3T4kxmKi6SRZnLcrQ+sx?=
 =?us-ascii?Q?WKhgQQnyJrMw8EHnEDM+xX+BMX5The/jD82m0b0xxoxL/wyvQ9YHF0LQAbNa?=
 =?us-ascii?Q?z9u6Uv0xUko+XlB8Z18fgLg7Cr7zPXbVpZo0mDwt0UCzxJgu7K8TwdOcIEXq?=
 =?us-ascii?Q?nJ0M0uTjn+WKLK8t3LDUJwRqXHtvioo1mzYHDffKAHWby4iPfIZ4nEC6Qdwd?=
 =?us-ascii?Q?TSzixjFYxZUFE/zKd2DjwuNiTdEezpQ+XVD7/3Yb79ScGZY5+9PzyNVrTMBQ?=
 =?us-ascii?Q?8SqJMMGNttCWqsaQlegainW3giD6LExyCHCXDpEO7GJLo14z5WONTC0ZBWoX?=
 =?us-ascii?Q?aRyh8f5rSt5W6zfLAvZTUsTiJKUrZkVAK5UmxYQpTwLfX+tTCG4DbOFanxM7?=
 =?us-ascii?Q?X0Sh9nwfgsBAG57OP1XndEjbh2hwUSLG4f8rqWkiZUKTKuiFoaFquk5BMNym?=
 =?us-ascii?Q?C1k9meHq/JmA6jZHPv6KswiUlplQmLzqqWGiEh3j4+jU+25jZo+P0563oNpn?=
 =?us-ascii?Q?zg4z0oHN2n8Jc/6+0zyGn6cpm3mGYhxarqFPMlndFRqPrwq62cQicvT57UD7?=
 =?us-ascii?Q?AHNrIWSFW57Jfw79L3SUI7W1d08tZl1MzUURBe2vSWEJ5hMm/WcT3XX7ODMr?=
 =?us-ascii?Q?exn5XNmnI5Suxt9oG0LCSm2v7ov5CdA+8R8SKxEDC51iTSPQmQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e058b6b1-438f-46c3-35a2-08d93b55e590
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 23:30:35.8093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJAKN3QzI/CpkiqHCXYmnpH2zYFdpgQ4aOo/l9f+rf05wvjVmiRlm84xbjOk3vz89n5IjCv/JR10mpufoo/9jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5243
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/29 16:50, Ming Lei wrote:=0A=
> hctx is deactivated when all CPU in hctx->cpumask become offline by=0A=
> draining all requests originated from this hctx and moving new=0A=
> allocation to active hctx. This way is for avoiding inflight IO when=0A=
> the managed irq is shutdown.=0A=
> =0A=
> Some drivers(nvme fc, rdma, tcp, loop) doesn't use managed irq, so=0A=
> they needn't to deactivate hctx. Also, they are the only user of=0A=
> blk_mq_alloc_request_hctx() which is used for connecting io queue.=0A=
> And their requirement is that the connect request can be submitted=0A=
> via one specified hctx on which all CPU in its hctx->cpumask may have=0A=
> become offline.=0A=
> =0A=
> Address the requirement for nvme fc/rdma/loop, so the reported kernel=0A=
> panic on the following line in blk_mq_alloc_request_hctx() can be fixed.=
=0A=
> =0A=
> 	data.ctx =3D __blk_mq_get_ctx(q, cpu)=0A=
> =0A=
> Cc: Sagi Grimberg <sagi@grimberg.me>=0A=
> Cc: Daniel Wagner <dwagner@suse.de>=0A=
> Cc: Wen Xiong <wenxiong@us.ibm.com>=0A=
> Cc: John Garry <john.garry@huawei.com>=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
> ---=0A=
>  block/blk-mq.c         | 6 +++++-=0A=
>  include/linux/blk-mq.h | 1 +=0A=
>  2 files changed, 6 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index df5dc3b756f5..74632f50d969 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -494,7 +494,7 @@ struct request *blk_mq_alloc_request_hctx(struct requ=
est_queue *q,=0A=
>  	data.hctx =3D q->queue_hw_ctx[hctx_idx];=0A=
>  	if (!blk_mq_hw_queue_mapped(data.hctx))=0A=
>  		goto out_queue_exit;=0A=
> -	cpu =3D cpumask_first_and(data.hctx->cpumask, cpu_online_mask);=0A=
> +	cpu =3D cpumask_first(data.hctx->cpumask);=0A=
>  	data.ctx =3D __blk_mq_get_ctx(q, cpu);=0A=
>  =0A=
>  	if (!q->elevator)=0A=
> @@ -2570,6 +2570,10 @@ static int blk_mq_hctx_notify_offline(unsigned int=
 cpu, struct hlist_node *node)=0A=
>  	    !blk_mq_last_cpu_in_hctx(cpu, hctx))=0A=
>  		return 0;=0A=
>  =0A=
> +	/* Controller doesn't use managed IRQ, no need to deactivate hctx */=0A=
> +	if (hctx->flags & BLK_MQ_F_NOT_USE_MANAGED_IRQ)=0A=
> +		return 0;=0A=
> +=0A=
>  	/*=0A=
>  	 * Prevent new request from being allocated on the current hctx.=0A=
>  	 *=0A=
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h=0A=
> index 21140132a30d..600c5dd1a069 100644=0A=
> --- a/include/linux/blk-mq.h=0A=
> +++ b/include/linux/blk-mq.h=0A=
> @@ -403,6 +403,7 @@ enum {=0A=
>  	 */=0A=
>  	BLK_MQ_F_STACKING	=3D 1 << 2,=0A=
>  	BLK_MQ_F_TAG_HCTX_SHARED =3D 1 << 3,=0A=
> +	BLK_MQ_F_NOT_USE_MANAGED_IRQ =3D 1 << 4,=0A=
=0A=
My 2 cents: BLK_MQ_F_NO_MANAGED_IRQ may be a better/shorter name.=0A=
=0A=
>  	BLK_MQ_F_BLOCKING	=3D 1 << 5,=0A=
>  	BLK_MQ_F_NO_SCHED	=3D 1 << 6,=0A=
>  	BLK_MQ_F_ALLOC_POLICY_START_BIT =3D 8,=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
