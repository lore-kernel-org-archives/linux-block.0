Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B436FC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 12:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE8A2075B
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 12:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AtWt5b0F";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EL15Rnoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfB0MqD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:46:03 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36028 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfB0MqD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 07:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551271563; x=1582807563;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=moAw366/0z9mi8YbF61+uPF8xxMWyyxiD7drbZJCUYs=;
  b=AtWt5b0FZyfkyDTD+OpfpnsQ4Ciw+e0oSwZo/Kq/kkca/Qti0Db5pI4j
   Z4WWy/1xata9gGs8DI4+IuDbRat5nFl5yIDYnCUzNogTHw10pH0ZdXkP8
   IBKrcFAq3MT2Hs8dXaxuDZk02WqIV3W6lk6bzvVUjG6pcLv7glGF/yaEW
   aMDdK45qcUfvgb1VMoLIdTwZEZNkUe2peiQxmC3KzdDzn/4izmmzyrwt3
   mrLJFiIYUaYhZD+e2AMM1b8275ol1UsjkD0S91SHOMEgwF/JIDxb8ai2J
   CLEfvwkJJGEvuElMv7B/YH+6ZBi3f6D+b74t4uytBbdHHD2WIUQ9IpVuv
   w==;
X-IronPort-AV: E=Sophos;i="5.58,419,1544457600"; 
   d="scan'208";a="102277648"
Received: from mail-sn1nam02lp2052.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.52])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2019 20:46:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlaGpX+qwvZj2vkDh6DU7N3k7o1QG9X/8+2BMTAFbPs=;
 b=EL15RnocavnO1JA4fAjnI4+owNq6uDJVHn1aZYiYD3CrVpKS3A3VFDX2XKFuCMs9hzz0Ek/zRDhwQGCwGMv7qnp6HY4O4tVJdC/ot6q5EbdMUsib1xAufVAqO9cxG6PdTdUT2qFUc0IcRfowAeGiEGdipsO3bKu6Kud5jDyy5A0=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB3799.namprd04.prod.outlook.com (52.135.214.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 27 Feb 2019 12:45:41 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::88b4:7016:f0cc:7bbb]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::88b4:7016:f0cc:7bbb%3]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 12:45:41 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     yuyufen <yuyufen@huawei.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: add a new flag BLK_MQ_POLL_HYBRID_INVALID for
 hybrid poll
Thread-Topic: [PATCH] block: add a new flag BLK_MQ_POLL_HYBRID_INVALID for
 hybrid poll
Thread-Index: AQHUzmRmFLsyTgVJfUee4QS0axPl0A==
Date:   Wed, 27 Feb 2019 12:45:40 +0000
Message-ID: <BYAPR04MB581600BE4E6B945E3E52CD75E7740@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190227062155.19732-1-yuyufen@huawei.com>
 <0a46f96d-1707-9e1d-cd44-4eb7dce60533@gmail.com>
 <ac9ee8b8-6eab-4cb4-f8fb-cf92341a45f5@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [63.138.96.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c484ffe-0077-4313-ff17-08d69cb17b57
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB3799;
x-ms-traffictypediagnostic: BYAPR04MB3799:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR04MB3799;23:wyBpFu30IXukVC1L6Z3FikUyJOwpYsIv8KsUjGFg1?=
 =?us-ascii?Q?fxu6+zYgsDPshXzytC1D3ksmIDpmukOLP8jXKKdwGIkLc1JqFWNPPWh3A3bX?=
 =?us-ascii?Q?ut/qsYs72refxtsNups8n1NMlybAN8smRbAOR4z0/vSS/PqGLMRcJXlC4jjd?=
 =?us-ascii?Q?eXNdZY7rttWIP7tSBvhv6a/UGsn1Qu2ofwEug/MlyF2lhpyAY3JX6ffQRex5?=
 =?us-ascii?Q?uLwPO5CR8T1DvImPa3SW4akl9DFRxHVF54yFmRSqvpLkQ6GN0R2b4GUg92aX?=
 =?us-ascii?Q?ktWv6vr9PVNsydXusMsFA8sCTgk0zjGq8yxLW4u0xHMynvOgHVponaxNYPhQ?=
 =?us-ascii?Q?g+MBZYqIjRdy8cWpNnQ0YjxD5VvUIrDykiH10KBuReadX1UzTN14rbpHA0yx?=
 =?us-ascii?Q?gyM0v2GOJr4/5hQSdq5ZtQhEn2AFd/etY2Qd+lPy8kVvKnDXFGEa2wltsEk0?=
 =?us-ascii?Q?lW8E0/7ptQ0MdvVLrE7ssgktbAdUvVzbZ8djn6plN5lDNnwrBEkduIx8MAel?=
 =?us-ascii?Q?YdTJzZTmCOqcC70ZHSFZxJHWHfYvf594S7Zmcy97ocXNzSTOQpxfIbbUlLUu?=
 =?us-ascii?Q?VQJ39ZoMFXb8Sc7cbvlZ4q4eRdk6kdaZX+VpGhWQ+0q1UFAIDgtumSAzjG6L?=
 =?us-ascii?Q?deGeiVOhUI3QykrjMNgA9eXY7i145o+Am0OiifPx7ZtrGC0EBuk+fAMnPQGT?=
 =?us-ascii?Q?I2iJ2SX2YRNYmXLGQBn2w+zZbac0OrL4HeClxmLKzDCxvTs61ir5PihkjZkT?=
 =?us-ascii?Q?CG+SuU8EQ37pIN1QeAILsoNDIUkPmEcSNTwcKJr9b0sVsZJEIZ7qh0N6jta5?=
 =?us-ascii?Q?ycPlYV/kCwEX64NCs7kLEB5HxATqPMKJ/mX5DYqVel8/KJuXg0NbkRcSgA5e?=
 =?us-ascii?Q?aLm7VZeY03eY6aBeUT1/Ct/lVW4PTHYYehlrAsCrKZQOkR7lOpu/ABR6ooi1?=
 =?us-ascii?Q?+na4luTLE4F4ltsDXEKQPaMLspsk87H2CBp7Y3EpQkrOwubZDQ0jV2gvE0MU?=
 =?us-ascii?Q?VSul7U2uZ9F9RcE22RsvMnt7rZFzyznFc0h7bpRWKvLEOrEK9Vk4q2SAulMe?=
 =?us-ascii?Q?09DwNqqFHSsKholFE7g6OEwHpw8tNM6qOixprKdSfcVEXYvCOqPumFFdKqF2?=
 =?us-ascii?Q?+wM7dQX+axR+LPG4P/RFS2VafJmb1SOKswJT7MN+B3WCc8G0pYtc5hyBBPb9?=
 =?us-ascii?Q?Sb18gaVuu3srXZ95yLMOdmOR0oIIFD/d3hMzOGVUJAo1IhGxLAZi1FI2C4gC?=
 =?us-ascii?Q?GIS9GtsVgoEnycvPxk=3D?=
x-microsoft-antispam-prvs: <BYAPR04MB3799FD66C322D0252C6B4FA4E7740@BYAPR04MB3799.namprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(6116002)(26005)(25786009)(3846002)(256004)(14444005)(446003)(102836004)(186003)(476003)(105586002)(7736002)(316002)(6246003)(106356001)(2201001)(305945005)(6506007)(99286004)(53546011)(66066001)(76176011)(486006)(86362001)(68736007)(110136005)(52536013)(74316002)(97736004)(7696005)(81166006)(53936002)(8676002)(33656002)(81156014)(14454004)(6436002)(229853002)(9686003)(478600001)(5660300002)(8936002)(2906002)(2501003)(71200400001)(71190400001)(55016002)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3799;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zARb1PQY4NwEv46PcCWTPX5CmCvc5kmjzjnmwz/YoVlEV3BJZW4wWVrDnWjJi8PzWQsiSNWP/wOqDTFmDzCfvOndG3Hi2fQGobRwzDRZDwtRXan5l6lrJ+Aj0dM/xZhu3qQtYN972hjwdBk3nBhrGirubRJrIjDYMmT2Hl3OY0LAZTRGy5X2naEgg0bz3zCg47uMfgQ6UhyHJSMD7Kt5O/ne+CGRFI5qSLnA4172NZm+BIhduOTncwPq3LaP5stdpp38J85/jsObk9UkcsFY+tluqrR95rMzHQc4/A4BgNjedbMD66lbti3rkNx7mrTagAU7BWAyHNEPOORWROzyIpNMAtA6rIDEt6ykquUL4QPInjJ2INC5KEivnfyv11uNac5RnmP3O+67EA9DVC8nKr+zTX1jl3Gh1RK/g99gek0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c484ffe-0077-4313-ff17-08d69cb17b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 12:45:40.9951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3799
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/02/27 5:38, yuyufen wrote:=0A=
> =0A=
> On 2019/2/27 18:27, Marcos Paulo de Souza wrote:=0A=
>> Hello Yufen,=0A=
>>=0A=
>> On 2/27/19 3:21 AM, Yufen Yu wrote:=0A=
>>> For q->poll_nsec =3D=3D -1, means using classic poll, not hybrid poll.=
=0A=
>>> We introduce a new flag BLK_POLL_DELAY_INVALID to replace -1, which=0A=
>>> may make code much easier to read.=0A=
>>=0A=
>> In the commit message you say BLK_POLL_DELAY_INVALID, but the code and =
=0A=
>> the commit title use BLK_MQ_POLL_HYBRID_INVALID. Is this a typo?=0A=
>>=0A=
> =0A=
> Thanks a lot for pointing out this fault. What I want to=0A=
> say is BLK_MQ_POLL_HYBRID_INVALID, not BLK_POLL_DELAY_INVALID.=0A=
> =0A=
> Yufen=0A=
> Thanks=0A=
> =0A=
>> Thanks.=0A=
>>=0A=
>>>=0A=
>>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>=0A=
>>> ---=0A=
>>>   block/blk-mq.c         | 4 ++--=0A=
>>>   block/blk-sysfs.c      | 4 ++--=0A=
>>>   include/linux/blkdev.h | 3 +++=0A=
>>>   3 files changed, 7 insertions(+), 4 deletions(-)=0A=
>>>=0A=
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
>>> index 9437a5eb07cf..8df9f6e97d2e 100644=0A=
>>> --- a/block/blk-mq.c=0A=
>>> +++ b/block/blk-mq.c=0A=
>>> @@ -2857,7 +2857,7 @@ struct request_queue =0A=
>>> *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,=0A=
>>>       /*=0A=
>>>        * Default to classic polling=0A=
>>>        */=0A=
>>> -    q->poll_nsec =3D -1;=0A=
>>> +    q->poll_nsec =3D BLK_MQ_POLL_HYBRID_INVALID;=0A=
>>>         blk_mq_init_cpu_queues(q, set->nr_hw_queues);=0A=
>>>       blk_mq_add_queue_tag_set(set, q);=0A=
>>> @@ -3389,7 +3389,7 @@ static bool blk_mq_poll_hybrid(struct =0A=
>>> request_queue *q,=0A=
>>>   {=0A=
>>>       struct request *rq;=0A=
>>>   -    if (q->poll_nsec =3D=3D -1)=0A=
>>> +    if (q->poll_nsec =3D=3D BLK_MQ_POLL_HYBRID_INVALID)=0A=
>>>           return false;=0A=
>>>         if (!blk_qc_t_is_internal(cookie))=0A=
>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
>>> index 590d1ef2f961..8775b898f96d 100644=0A=
>>> --- a/block/blk-sysfs.c=0A=
>>> +++ b/block/blk-sysfs.c=0A=
>>> @@ -360,7 +360,7 @@ static ssize_t queue_poll_delay_show(struct =0A=
>>> request_queue *q, char *page)=0A=
>>>   {=0A=
>>>       int val;=0A=
>>>   -    if (q->poll_nsec =3D=3D -1)=0A=
>>> +    if (q->poll_nsec =3D=3D BLK_MQ_POLL_HYBRID_INVALID)=0A=
>>>           val =3D -1;=0A=
>>>       else=0A=
>>>           val =3D q->poll_nsec / 1000;=0A=
>>> @@ -381,7 +381,7 @@ static ssize_t queue_poll_delay_store(struct =0A=
>>> request_queue *q, const char *page,=0A=
>>>           return err;=0A=
>>>         if (val =3D=3D -1)=0A=
>>> -        q->poll_nsec =3D -1;=0A=
>>> +        q->poll_nsec =3D BLK_MQ_POLL_HYBRID_INVALID;=0A=
>>>       else=0A=
>>>           q->poll_nsec =3D val * 1000;=0A=
>>>   diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>>> index 338604dff7d0..2102447b67d9 100644=0A=
>>> --- a/include/linux/blkdev.h=0A=
>>> +++ b/include/linux/blkdev.h=0A=
>>> @@ -50,6 +50,9 @@ struct blk_stat_callback;=0A=
>>>   /* Must be consistent with blk_mq_poll_stats_bkt() */=0A=
>>>   #define BLK_MQ_POLL_STATS_BKTS 16=0A=
>>>   +/* Using default classic polling */=0A=
>>> +#define BLK_MQ_POLL_HYBRID_INVALID -1=0A=
=0A=
May be simply renaming this as BLK_MQ_POLL_CLASSIC would be even simpler ?=
=0A=
That matches the comment and also the actual use of the macro, i.e.:=0A=
=0A=
if (q->poll_nsec =3D=3D -1)=0A=
=0A=
means "do classic polling", which would nicely fits with:=0A=
=0A=
if (q->poll_nsec =3D=3D BLK_MQ_POLL_CLASSIC)=0A=
=0A=
A lot easier to understand in my opinion. Using BLK_MQ_POLL_HYBRID_INVALID =
as a=0A=
name is confusing with potential error cases where we actually want to do h=
ybrid=0A=
polling but the poll sleep time is invalid.=0A=
=0A=
>>> +=0A=
>>>   /*=0A=
>>>    * Maximum number of blkcg policies allowed to be registered =0A=
>>> concurrently.=0A=
>>>    * Defined here to simplify include dependency.=0A=
>>>=0A=
>>=0A=
>> .=0A=
>>=0A=
> =0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
