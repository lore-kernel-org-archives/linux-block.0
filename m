Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03066C4360C
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 05:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A0E20815
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 05:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GMFKCbiS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="q/jdKT3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfI3F26 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 01:28:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60071 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfI3F26 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 01:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569821338; x=1601357338;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Wi/dzrM2Cy53CBilICssaIr9VN1eZGGR98OplwV7MbI=;
  b=GMFKCbiSZOnd5kbsGTJ2iXcz/3ib9Y+an+Xv+Msw83UFXT29wCLJNUT/
   M8HOxPR3b8M/SmWYhVn9zU6TFY9AWAGVZy8UVT5FM1x5ZkzR3gKMKL62t
   MxnEZ03BSZ0cnkgXJcx4cCyRO26pvM3tTvas9Ze582l9V5x4vQQoZU7TC
   zy4noJTDzQ5nlv4NoH3ArifrX8epq5mbkn0/dYN0N5x9P7q8qXJV4yrOZ
   EtXF/n6lKVG5HXLGEvh+ywHJo8Gviz1HDnn+VJwO5NZf5c8VwPOLqi48L
   8Mwe/uN6K+m28HSwlcrW9ZORP7zHct/HcRAO4ER5h5nBGhRKo/xVgLWVQ
   w==;
IronPort-SDR: sl2okBGIbLr2SnnpPW0uC7IX2irJHv61g/mQg2yyvnLF7EC00m9pMsPwA88DeoG28FjamspGYW
 Q8TuN6traQpO4jgnKH4eo6/U4FgUc30OvcUDTX9+13/w7ZPMxWNAjaxg3P75y+5njxhjoH6GGp
 8ou4e26uX++Pf8ia+xkWHr3iRxKcKAIrVD0+uv/sQszoW6qA+zCqbN7z15K7ag0ADEL8pgue4R
 tX3M7NvgSt8f+CFCAe9u9wM3DTgi03dPvBsb6OdEPwBilQz88yAly0vejXVFc4Qr4duuVxx9CM
 MQI=
X-IronPort-AV: E=Sophos;i="5.64,565,1559491200"; 
   d="scan'208";a="226306797"
Received: from mail-by2nam01lp2059.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.59])
  by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2019 13:28:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sx86ni8JvkGzX+0TypPfd5VMoclQyGZXcyQE6Mlq8n1pSTcoacyCPqrazInhRm6JiKt5Bw72EwU5l7riY1OrjjvATwml8LkQi+OYAMXP5ryKr6P1psPqpTEZasYK1IJciYwACfHLgNpASt7Y34sTDAYElQDChL77fhf72bd9rA60TJtjzSNFcIfMic8w/AZX8RlITFhO2/qgqEpuoWR4XTwtfaXGfjQE6gtWN1v1qSCpTi9Ug/b8D+ujUt5+MeZGjxtmrFpAE4zfYaW4uA5akYcBmuokll2tNHMWLLlo6YXYfZLDK1h0n9WqKq8J3laeoeVhi0TCLq8l7lYuht3CZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcC8qS0pt7jVsINnu46QPho5cm92H9zz7L/81zX0jV4=;
 b=Z7bFLZDa8B1JUGKGShJav459mcN+6Xd9OQvqn/Us7TiNyOp4g3DZoMRziYzkNG+T8G5UnOzjAK2JPKcTrCnFSMTHjFiB0CVE9uNJIVbI8TQfF7aqoPkfN7MVoESIHnDreSThvgo5emkwsUSYV0XsfReWNiXGhuXGRUWMZM2gtjsguLVo4pv0wRj1cuskfUesHhJaeV0Ww5f/FYx9S1bDEzTwTPvJec6gkI1ub/CF9noBZXYub35RjxF45e+F9N7rSnMy5KFWuwPo52y4kYQQHAKy5iNrNmdzR+9Nj/+jN6wMlYJ2F+eszqS2eJA8rHugIppKR1oCxikt2PBZjeex/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcC8qS0pt7jVsINnu46QPho5cm92H9zz7L/81zX0jV4=;
 b=q/jdKT3GpXMI0/SA+gpD0rWVtzpiJuR+F2KA+8Tw6LPnO9Q7dczFOWqAJHRmWw7f1Qsy6DCnGHQyj65hwnNKhQjAn9IOW7OSk99kZ4vO1Ux8W3Gmn8PVHdd3dfd7l0F0JKEzhqBq9m/MttiBsJ7EtNygr/hmsOomU6r1zErtI7I=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4200.namprd04.prod.outlook.com (52.135.202.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Mon, 30 Sep 2019 05:28:56 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::84c4:833e:ec0b:5053]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::84c4:833e:ec0b:5053%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 05:28:56 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "xiubli@redhat.com" <xiubli@redhat.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "mchristi@redhat.com" <mchristi@redhat.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 1/2] blk-mq: Avoid memory reclaim when allocating
 request map
Thread-Topic: [PATCH v4 1/2] blk-mq: Avoid memory reclaim when allocating
 request map
Thread-Index: AQHVdzG+JVhUd+Jmr02Gp8lZPtjllA==
Date:   Mon, 30 Sep 2019 05:28:56 +0000
Message-ID: <BYAPR04MB58160630271A8E552F7FD5D8E7820@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190930015213.8865-1-xiubli@redhat.com>
 <20190930015213.8865-2-xiubli@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [83.175.114.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: befabb89-a295-40c4-8675-08d74567170c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4200;
x-ms-traffictypediagnostic: BYAPR04MB4200:
x-microsoft-antispam-prvs: <BYAPR04MB420014FD7723A91D9557759DE7820@BYAPR04MB4200.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(7696005)(3846002)(33656002)(6436002)(14454004)(2906002)(6116002)(54906003)(476003)(486006)(110136005)(26005)(6246003)(478600001)(76176011)(25786009)(4326008)(446003)(66946007)(66556008)(76116006)(66476007)(64756008)(99286004)(9686003)(66446008)(229853002)(52536014)(2201001)(7736002)(305945005)(71190400001)(71200400001)(66066001)(74316002)(86362001)(186003)(256004)(6506007)(53546011)(8936002)(102836004)(81156014)(81166006)(8676002)(55016002)(5660300002)(14444005)(2501003)(316002)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4200;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: POrtMTRUcsZmiwiyxOOkpjht0NsSTPsSJkKJoi/26afKdAb1ZKkVtqLxqv5iQ4babQsbtsIUDw9tQhVhgumprJEOk8PFOrZ7EITMUGvE03Nf/SNpWhK4Fz/wuJS+R0NYTRn062zQWBPycjyaPxzqd2PXf2n3/drHAtFjf0BzoqpdzhiZahrXnu7ig2DcF2ugrXTjMz+Woa7Wuwn6TioV8NTYNDAEk/5th1mOAgIqsOoFKfYNRpVdKoBB7VwxNC8m4+prtvuyJK/nB2bV+LfTdWvwsUVtT6Gt5AWMVE8zWbj6qeSUKohA/0UkQ7OwXHPtKLlv0VqOxXfGCSW6+alSVXH2DeV/2Kq2+g6Om3euhJ2NAmdxc8R7IARXaHvi+MFofX9+Gr6hpyHi7Ya7XUl/aGlnBOLkeqzOE4Mpj69NNrw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befabb89-a295-40c4-8675-08d74567170c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 05:28:56.5580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSoP5G+rhbcFQixpxXjqb1lfyaJxPXPcsnm2I9NrPu8HGOEN4nZcUSeY/6Y5jWhubM8ONnaN40DZN6z2w4tOEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4200
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/09/29 18:52, xiubli@redhat.com wrote:=0A=
> From: Xiubo Li <xiubli@redhat.com>=0A=
> =0A=
> For some storage drivers, such as the nbd, when there has new socket=0A=
> connections added, it will update the hardware queue number by calling=0A=
> blk_mq_update_nr_hw_queues(), in which it will freeze all the queues=0A=
> first. And then tries to do the hardware queue updating stuff.=0A=
> =0A=
> But int blk_mq_alloc_rq_map()-->blk_mq_init_tags(), when allocating=0A=
> memory for tags, it may cause the mm do the memories direct reclaiming,=
=0A=
> since the queues has been freezed, so if needs to flush the page cache=0A=
> to disk, it will stuck in generic_make_request()-->blk_queue_enter() by=
=0A=
> waiting the queues to be unfreezed and then cause deadlock here.=0A=
> =0A=
> Since the memory size requested here is a small one, which will make=0A=
> it not that easy to happen with a large size, but in theory this could=0A=
> happen when the OS is running in pressure and out of memory.=0A=
> =0A=
> Gabriel Krisman Bertazi has hit the similar issue by fixing it in=0A=
> commit 36e1f3d10786 ("blk-mq: Avoid memory reclaim when remapping=0A=
> queues"), but might forget this part.=0A=
> =0A=
> Signed-off-by: Xiubo Li <xiubli@redhat.com>=0A=
> CC: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>=0A=
> Reviewed-by: Ming Lei <ming.lei@redhat.com>=0A=
> ---=0A=
>  block/blk-mq-tag.c | 5 +++--=0A=
>  block/blk-mq-tag.h | 5 ++++-=0A=
>  block/blk-mq.c     | 3 ++-=0A=
>  3 files changed, 9 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c=0A=
> index 008388e82b5c..04ee0e4c3fa1 100644=0A=
> --- a/block/blk-mq-tag.c=0A=
> +++ b/block/blk-mq-tag.c=0A=
> @@ -462,7 +462,8 @@ static struct blk_mq_tags *blk_mq_init_bitmap_tags(st=
ruct blk_mq_tags *tags,=0A=
>  =0A=
>  struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,=0A=
>  				     unsigned int reserved_tags,=0A=
> -				     int node, int alloc_policy)=0A=
> +				     int node, int alloc_policy,=0A=
> +				     gfp_t flags)=0A=
>  {=0A=
>  	struct blk_mq_tags *tags;=0A=
>  =0A=
> @@ -471,7 +472,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int tot=
al_tags,=0A=
>  		return NULL;=0A=
>  	}=0A=
>  =0A=
> -	tags =3D kzalloc_node(sizeof(*tags), GFP_KERNEL, node);=0A=
> +	tags =3D kzalloc_node(sizeof(*tags), flags, node);=0A=
>  	if (!tags)=0A=
>  		return NULL;=0A=
>  =0A=
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h=0A=
> index 61deab0b5a5a..296e0bc97126 100644=0A=
> --- a/block/blk-mq-tag.h=0A=
> +++ b/block/blk-mq-tag.h=0A=
> @@ -22,7 +22,10 @@ struct blk_mq_tags {=0A=
>  };=0A=
>  =0A=
>  =0A=
> -extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsign=
ed int reserved_tags, int node, int alloc_policy);=0A=
> +extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,=0A=
> +					    unsigned int reserved_tags,=0A=
> +					    int node, int alloc_policy,=0A=
> +					    gfp_t flags);=0A=
>  extern void blk_mq_free_tags(struct blk_mq_tags *tags);=0A=
>  =0A=
>  extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);=0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index 240416057f28..9c52e4dfe132 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -2090,7 +2090,8 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_=
mq_tag_set *set,=0A=
>  		node =3D set->numa_node;=0A=
>  =0A=
>  	tags =3D blk_mq_init_tags(nr_tags, reserved_tags, node,=0A=
> -				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));=0A=
> +				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags),=0A=
> +				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);=0A=
=0A=
You added the gfp_t argument to blk_mq_init_tags() but you are only using t=
hat=0A=
argument with a hardcoded value here. So why not simply call kzalloc_node()=
 in=0A=
that function with the flags GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY ? That=
=0A=
would avoid needing to add the "gfp_t flags" argument and still fit with yo=
ur=0A=
patch 2 definition of BLK_MQ_GFP_FLAGS.=0A=
=0A=
>  	if (!tags)=0A=
>  		return NULL;=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
