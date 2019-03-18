Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF3C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 23:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A642064C
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 23:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KTO4oo2X";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lM2vpboN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCRXSV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:18:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41505 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCRXSV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 19:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1552951135; x=1584487135;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0k7oyPpwrqDN8560/LckFbbsLTMF+Td2KHSdAB/kn3k=;
  b=KTO4oo2Xsq0TZJWikKvmR4sDfHdfLYGA9iSFf2gXH3kVLB17ntD1T7qv
   gXXKQAcqRIP34G1MNWwyYW75lCNZMXtnZjRjhKiCw2FHO5uyG4z1m+9AO
   TKJXEorRoD82cfCytgj5qFy6uWmU0Q6VqtJgn69Q0HemPQ5DA3dqA047n
   OIt8AtXblI8FU9kt7leq4sVya0e/+7edoBtuZi3y4t2zej14csTLjySz+
   mRG+7JcbgNx0jmxSpbIDM03wO78xZhhvlNCMJZwAh7jmrk17xnVqSezZr
   6iPlEcyBhJx9QjDWwXreKw4z84UFBnwJ2VONi96aCjVFMoJD6RSqYEOnQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,495,1544457600"; 
   d="scan'208";a="202365972"
Received: from mail-by2nam03lp2050.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.50])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2019 07:18:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYAf4juqoVR0pEXO102dsuyqNH53ONrffJl3S+a2KJY=;
 b=lM2vpboNaTqDsY4H0u87MhiVoyErvdFqbHbyvbxsGObWDRlhm/XUz11qEKgNQ9NdaH/UvLM2CRRfCm1U5d8wPMirL6T/at5sOPi1CRPGKHsHyzzDZewjloPMkiy1cQAYSrRD9Ki2o/jxbvQF/i6aHRtYZ3OvPua7VlTt6bISSd4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB6181.namprd04.prod.outlook.com (20.178.235.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 23:18:19 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::7c30:6437:71e2:e32e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::7c30:6437:71e2:e32e%3]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 23:18:19 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Yufen Yu <yuyufen@huawei.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v4] block: add BLK_MQ_POLL_CLASSIC for hybrid poll and
 return EINVAL for unexpected value
Thread-Topic: [PATCH v4] block: add BLK_MQ_POLL_CLASSIC for hybrid poll and
 return EINVAL for unexpected value
Thread-Index: AQHU3ZiV3SxKwq/4LkCbXK8dnVPbEw==
Date:   Mon, 18 Mar 2019 23:18:18 +0000
Message-ID: <BYAPR04MB5816478ABCB32CF0CBD89DF4E7470@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190318144441.133569-1-yuyufen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ec8fde1-e480-4f3c-e30c-08d6abf801e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB6181;
x-ms-traffictypediagnostic: BYAPR04MB6181:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB6181889C68C79DBAD78FBA06E7470@BYAPR04MB6181.namprd04.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(39860400002)(346002)(366004)(189003)(199004)(305945005)(2501003)(9686003)(6246003)(256004)(8676002)(81166006)(6436002)(55016002)(81156014)(68736007)(3846002)(5660300002)(229853002)(53936002)(6116002)(105586002)(102836004)(66066001)(8936002)(26005)(2906002)(316002)(186003)(106356001)(71200400001)(14444005)(53546011)(6506007)(71190400001)(110136005)(86362001)(52536014)(486006)(14454004)(446003)(7696005)(97736004)(76176011)(72206003)(25786009)(7736002)(478600001)(476003)(33656002)(74316002)(4326008)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6181;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5D2R4NWj/6x6x/aJOdn5Ww6URZeqcViyEOTYGG/4DT62qegJoVxI6h91hi64K2wvzQS3KdycN12xb+G4b+zErWcpLL46LKv4CQdDhWC2+W/NFIwRaXC3AgBGOFsvI4F9jaezI5UOj1CpafA7GYsk9ASQryFdpuGFM6gLmXgS1Gh6mHzjdEFFpSpCZ8G6p9ZCopFuP0zwqFNY2MYgz8hYfAW03ToRhaKqjO9WsjKjWSjio7T7n/49/tOzvfyRwkxHWbdG9UWTS+JkoI/NujYKO5HYbtySCC3N/o8ZF7Ir72MedVrvUk8j9+GV3SOi3aZkyFNZ14zRBYtAIXhTNLGlIdzhDAFfmydWzRtkegcsKfGYx+LAMHMooequiFBvxXIy78RP0kD0+IvfHzUHE/ZEl8ng8067NLlGd2leaO2HzMk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec8fde1-e480-4f3c-e30c-08d6abf801e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 23:18:18.9236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6181
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/03/18 23:40, Yufen Yu wrote:=0A=
> For q->poll_nsec =3D=3D -1, means doing classic poll, not hybrid poll.=0A=
> We introduce a new flag BLK_MQ_POLL_CLASSIC to replace -1, which=0A=
> may make code much easier to read.=0A=
> =0A=
> Additionally, since val is an int obtained with kstrtoint(), val can be=
=0A=
> a negative value other than -1, so return -EINVAL for that case.=0A=
> =0A=
> Thanks to Damien Le Moal for some good suggestion.=0A=
> =0A=
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>=0A=
> ---=0A=
>  block/blk-mq.c         |  4 ++--=0A=
>  block/blk-sysfs.c      | 12 +++++++-----=0A=
>  include/linux/blkdev.h |  3 +++=0A=
>  3 files changed, 12 insertions(+), 7 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index a9c181603cbd..1c588e5c4a02 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -2857,7 +2857,7 @@ struct request_queue *blk_mq_init_allocated_queue(s=
truct blk_mq_tag_set *set,=0A=
>  	/*=0A=
>  	 * Default to classic polling=0A=
>  	 */=0A=
> -	q->poll_nsec =3D -1;=0A=
> +	q->poll_nsec =3D BLK_MQ_POLL_CLASSIC;=0A=
>  =0A=
>  	blk_mq_init_cpu_queues(q, set->nr_hw_queues);=0A=
>  	blk_mq_add_queue_tag_set(set, q);=0A=
> @@ -3392,7 +3392,7 @@ static bool blk_mq_poll_hybrid(struct request_queue=
 *q,=0A=
>  {=0A=
>  	struct request *rq;=0A=
>  =0A=
> -	if (q->poll_nsec =3D=3D -1)=0A=
> +	if (q->poll_nsec =3D=3D BLK_MQ_POLL_CLASSIC)=0A=
>  		return false;=0A=
>  =0A=
>  	if (!blk_qc_t_is_internal(cookie))=0A=
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
> index 59685918167e..422327089e0f 100644=0A=
> --- a/block/blk-sysfs.c=0A=
> +++ b/block/blk-sysfs.c=0A=
> @@ -360,8 +360,8 @@ static ssize_t queue_poll_delay_show(struct request_q=
ueue *q, char *page)=0A=
>  {=0A=
>  	int val;=0A=
>  =0A=
> -	if (q->poll_nsec =3D=3D -1)=0A=
> -		val =3D -1;=0A=
> +	if (q->poll_nsec =3D=3D BLK_MQ_POLL_CLASSIC)=0A=
> +		val =3D BLK_MQ_POLL_CLASSIC;=0A=
>  	else=0A=
>  		val =3D q->poll_nsec / 1000;=0A=
>  =0A=
> @@ -380,10 +380,12 @@ static ssize_t queue_poll_delay_store(struct reques=
t_queue *q, const char *page,=0A=
>  	if (err < 0)=0A=
>  		return err;=0A=
>  =0A=
> -	if (val =3D=3D -1)=0A=
> -		q->poll_nsec =3D -1;=0A=
> -	else=0A=
> +	if (val =3D=3D BLK_MQ_POLL_CLASSIC)=0A=
> +		q->poll_nsec =3D BLK_MQ_POLL_CLASSIC;=0A=
> +	else if (val >=3D 0)=0A=
>  		q->poll_nsec =3D val * 1000;=0A=
> +	else=0A=
> +		return -EINVAL;=0A=
>  =0A=
>  	return count;=0A=
>  }=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 0de92b29f589..5c58a3b2bf00 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -50,6 +50,9 @@ struct blk_stat_callback;=0A=
>  /* Must be consistent with blk_mq_poll_stats_bkt() */=0A=
>  #define BLK_MQ_POLL_STATS_BKTS 16=0A=
>  =0A=
> +/* Doing classic polling */=0A=
> +#define BLK_MQ_POLL_CLASSIC -1=0A=
> +=0A=
>  /*=0A=
>   * Maximum number of blkcg policies allowed to be registered concurrentl=
y.=0A=
>   * Defined here to simplify include dependency.=0A=
> =0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
