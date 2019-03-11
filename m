Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1347C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 13:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACD0206BA
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 13:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PSR8fSG6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oJkf+7KW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfCKNv6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:51:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34410 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKNv6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 09:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1552312343; x=1583848343;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ISNEhTCJa66RxNldrxgpHuFGOA4UY3/jsjzgZYiQ/Fo=;
  b=PSR8fSG6Cic8SQ4SmAcOTPeBjoUU+TQh5wREOEZEWAN8u05NAI7Rv3KY
   DzW88Bf7gu0flHoN1BCbQV8cfS+hfAcxrlmIucPdiwRK8HqMl+RJN3SDv
   EEs7TUJ90as4beBQy94iR+cOBoUq3srDkJyAYA4ENHgSo3wCF+wurxSRU
   /ARckY8fEmH03hDZLe/yTiddOsq7kWaEwCbTO+gCD9FWci12x8PuysFKX
   hpEQCwnqu/WaDIQiGSFlluQBc4f+wx8Y05ZAbTqRszWpFvk7u1NAGnqNG
   EhKIGO6uFfTI4pRtay2q2kdDz3tHeI7yiIff4l5BCt+M22K/BN6nRpVAE
   w==;
X-IronPort-AV: E=Sophos;i="5.58,468,1544457600"; 
   d="scan'208";a="201714663"
Received: from mail-by2nam03lp2057.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.57])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2019 21:52:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU4LCigvaGZdcVwRCcwYAmVo/0+3F2qR8SK3RBN9ZKA=;
 b=oJkf+7KWFmRlhpU5/AMA6mlNITv5pkGT6bnL4+vjur6iHTxCoTevfGuVcxN53SI29SuGx5wUJbfHMeoQZ1GRV2MkFDwAidjSpgcf/VHY20yjTbYi1lr9kfn8yEJcgXRpw4BHDAhd8c8LYzBzSm/mZ2nqincP/X3V4ZguNAqZePY=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4504.namprd04.prod.outlook.com (52.135.238.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.22; Mon, 11 Mar 2019 13:51:49 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::7879:14e9:8b5:6c1b]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::7879:14e9:8b5:6c1b%4]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 13:51:49 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     yuyufen <yuyufen@huawei.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "marcos.souza.org@gmail.com" <marcos.souza.org@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] block: add a new flag BLK_MQ_POLL_CLASSIC for hybrid
 poll
Thread-Topic: [PATCH v2] block: add a new flag BLK_MQ_POLL_CLASSIC for hybrid
 poll
Thread-Index: AQHUz82d1LZ9qgKiN0O1Q2T355q26g==
Date:   Mon, 11 Mar 2019 13:51:49 +0000
Message-ID: <BYAPR04MB58160E554934D081C582C64EE7480@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190301012855.137660-1-yuyufen@huawei.com>
 <68a8b534-9eb8-7309-4df8-a90ea5705e49@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [12.169.102.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23525d5f-5a03-4b7a-03a8-08d6a628b5a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4504;
x-ms-traffictypediagnostic: BYAPR04MB4504:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR04MB4504;23:W+nSXyYA+zc4ETEGq6y5Eu0JPuF8FJs/Q9//TEhCs?=
 =?us-ascii?Q?yeliYK2JaEDLxFc0ZpT6OS1OAWe4rWq8k5l20g9/pfrnbYtyebeoKEnZi8FR?=
 =?us-ascii?Q?0zf9hC1UY9VmfX376ILig4ZSQYuy0NtROiZSKGRiNgD+F/XH8Lo6ziW+GSRV?=
 =?us-ascii?Q?2JWZ6tilRX5YthrrD9ykkxJkRCodQ0k+qWwLRGQwiLlBmErCACTTpAbo4dSW?=
 =?us-ascii?Q?nmWWDChUSCRrMSvLKa4hYf0yL8BWiEM/BS9yEKwHwrxWZV/N6umPO3yfjONk?=
 =?us-ascii?Q?t5fC+0/ruhYQXi0csSznnzrPfNghjwWS2+zs+xYnO1jHYGihbK0vEEWzCVLh?=
 =?us-ascii?Q?w/BsSMOvop60QE9kNzWbajuT6ftTnfhKtOQkS/Y4/k64qbDCQqxcwnhe9hXk?=
 =?us-ascii?Q?bMDdUsls6zOOSrzHSSNXtVQvFlTlozboeEhc0r3RtJZkYuzNnKHYhK51eyYi?=
 =?us-ascii?Q?k/PgCtuQ9an+w7dD/P4wMkUSP0zl+7JpMkikVVy4m65Ba2/WeAoEBeelL3UL?=
 =?us-ascii?Q?e/Oswew3CYUtPOL4cSjOqO1DPiLJQEWecSnNJk5M6/eLn29ApMS/Jz9kYAkH?=
 =?us-ascii?Q?TkNL7C3ZzRehDAd4lDHS9ZRLt6SHbWUB9eekqHdKRzmmyf1XCzwv1Yp0hqnr?=
 =?us-ascii?Q?vW2wJRQxawGG23Ikr1QQfrDRZAGGPVFj46j/QtzA5HFQ0VpxA2qqVjHUVSsf?=
 =?us-ascii?Q?cDNjc/hbatDTytcDKMBXZNTUukcHAWXyLNjdUhWnEGCQL8ucH91/FHlc5nJn?=
 =?us-ascii?Q?lTG2PZGkWufXmNijP8RnF9E7Z8HAfoWjSZldlFvAHXjkuWcz3S1oplWoLXoY?=
 =?us-ascii?Q?tuhdJr1o7tI+1CLAxUqlnukYhbyNeQ7DlPVf+5sSZFqufFwM2SMAH32nBWFu?=
 =?us-ascii?Q?6swLPDg0lAzJ6YY1tiwr04/1H1oSEXQWi1bVNDJaML+gXwNiIhpXk0F1+n+0?=
 =?us-ascii?Q?KnbGxgi2DX4Jv21Kq0Dj4Z8embYGSGNQbje9oD9d8wmhvcq7VsJfCYksW05E?=
 =?us-ascii?Q?hPRcxwkOqoNkLGBKLO2XEN3BuDHbCLaPouBTwZbJkffx6xd7qTDsEJEZZBR8?=
 =?us-ascii?Q?D/cOmEYhxC18sok9n0peqwqSX2Qby7KxysxK+ym7jNXQJHsFEyw5QvDs82J8?=
 =?us-ascii?Q?BSI36Lq4qYsXDRgljBhGCioawTcuACOg0tDGvVfpYBctlqMSENFWpQr3A4GO?=
 =?us-ascii?Q?ZsbdZ8pv9jnm6iyGyPF5cvPM6sczFV+IwZVoK/pxv0d2ljJR7bm9+BvyX7o+?=
 =?us-ascii?Q?/V/wAuVRa3LJdnuiNM=3D?=
x-microsoft-antispam-prvs: <BYAPR04MB450468FA536AA86F8B61F93DE7480@BYAPR04MB4504.namprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(6506007)(6436002)(52536013)(102836004)(53546011)(229853002)(186003)(5660300002)(6116002)(3846002)(68736007)(71190400001)(81166006)(81156014)(66066001)(71200400001)(86362001)(99286004)(256004)(9686003)(110136005)(26005)(106356001)(14444005)(316002)(105586002)(2201001)(8676002)(55016002)(486006)(33656002)(72206003)(2501003)(53936002)(76176011)(14454004)(8936002)(2906002)(478600001)(74316002)(7736002)(6246003)(446003)(7696005)(305945005)(25786009)(476003)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4504;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8Em6yyTNNoa8Xjyxl8o5IQysnEgA4CG7KaXl+/HUqhSQnUXByioiJZ6Nx7wlfducwiAx40CFHExL0kaCNvFGfkxufL3TI1KFa6qvo1Wx4HzHP9dZwcTumza+25I2CJXUGn/HltOIcSGDYn7TZBwR7+SFq7vzk6uEJmINYkre/RQ+xMw84bGM5kVy8tPc6dW2A+o7+eklZ8xZbv11HyK2fTDKpts9vZSwapz8i440EGBH4dKDwKY5qHQvrZ/v0RG8ZqLWwAJ5YoS3y+2VlZFX7uLu2x8tMWEYkU0GK3D/9YFFil0x4Z2CNnYNaKV6TJKIUoV6DBz4O1KQnSNRDpG1BEfo8VAkd63EY0sWFiYek4K6xmruYYRphmU4zkg8NPQJZD4qZqdH0ykOQA440/hkeK9kuuU1ckvGLnO+zx2Zv34=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23525d5f-5a03-4b7a-03a8-08d6a628b5a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 13:51:49.4068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4504
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/03/11 6:31, yuyufen wrote:=0A=
> ping?=0A=
> =0A=
> =0A=
> On 2019/3/1 9:28, Yufen Yu wrote:=0A=
>> For q->poll_nsec =3D=3D -1, means doing classic poll, not hybrid poll.=
=0A=
>> We introduce a new flag BLK_MQ_POLL_CLASSIC to replace -1, which=0A=
>> may make code much easier to read.=0A=
>>=0A=
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>=0A=
>> ---=0A=
>>   block/blk-mq.c         | 4 ++--=0A=
>>   block/blk-sysfs.c      | 4 ++--=0A=
>>   include/linux/blkdev.h | 3 +++=0A=
>>   3 files changed, 7 insertions(+), 4 deletions(-)=0A=
>>=0A=
>> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
>> index 9437a5eb07cf..e70202e3b378 100644=0A=
>> --- a/block/blk-mq.c=0A=
>> +++ b/block/blk-mq.c=0A=
>> @@ -2857,7 +2857,7 @@ struct request_queue *blk_mq_init_allocated_queue(=
struct blk_mq_tag_set *set,=0A=
>>   	/*=0A=
>>   	 * Default to classic polling=0A=
>>   	 */=0A=
>> -	q->poll_nsec =3D -1;=0A=
>> +	q->poll_nsec =3D BLK_MQ_POLL_CLASSIC;=0A=
>>   =0A=
>>   	blk_mq_init_cpu_queues(q, set->nr_hw_queues);=0A=
>>   	blk_mq_add_queue_tag_set(set, q);=0A=
>> @@ -3389,7 +3389,7 @@ static bool blk_mq_poll_hybrid(struct request_queu=
e *q,=0A=
>>   {=0A=
>>   	struct request *rq;=0A=
>>   =0A=
>> -	if (q->poll_nsec =3D=3D -1)=0A=
>> +	if (q->poll_nsec =3D=3D BLK_MQ_POLL_CLASSIC)=0A=
>>   		return false;=0A=
>>   =0A=
>>   	if (!blk_qc_t_is_internal(cookie))=0A=
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
>> index 590d1ef2f961..8639e135687e 100644=0A=
>> --- a/block/blk-sysfs.c=0A=
>> +++ b/block/blk-sysfs.c=0A=
>> @@ -360,7 +360,7 @@ static ssize_t queue_poll_delay_show(struct request_=
queue *q, char *page)=0A=
>>   {=0A=
>>   	int val;=0A=
>>   =0A=
>> -	if (q->poll_nsec =3D=3D -1)=0A=
>> +	if (q->poll_nsec =3D=3D BLK_MQ_POLL_CLASSIC)=0A=
>>   		val =3D -1;=0A=
>>   	else=0A=
>>   		val =3D q->poll_nsec / 1000;=0A=
>> @@ -381,7 +381,7 @@ static ssize_t queue_poll_delay_store(struct request=
_queue *q, const char *page,=0A=
>>   		return err;=0A=
>>   =0A=
>>   	if (val =3D=3D -1)=0A=
=0A=
Since val is an int obtained with kstrtoint(), val can be a negative value =
other=0A=
than -1. So what about something like:=0A=
=0A=
	if (val =3D=3D BLK_MQ_POLL_CLASSIC)=0A=
		q->poll_nsec =3D BLK_MQ_POLL_CLASSIC;=0A=
	else if (val >=3D 0)=0A=
		q->poll_nsec =3D val * 1000;=0A=
	else=0A=
		return -EINVAL;=0A=
=0A=
That would avoid problems with negative values other than -1.=0A=
=0A=
>> -		q->poll_nsec =3D -1;=0A=
>> +		q->poll_nsec =3D BLK_MQ_POLL_CLASSIC;=0A=
>>   	else=0A=
>>   		q->poll_nsec =3D val * 1000;=0A=
>>   =0A=
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>> index 338604dff7d0..f9c2ebf5e621 100644=0A=
>> --- a/include/linux/blkdev.h=0A=
>> +++ b/include/linux/blkdev.h=0A=
>> @@ -50,6 +50,9 @@ struct blk_stat_callback;=0A=
>>   /* Must be consistent with blk_mq_poll_stats_bkt() */=0A=
>>   #define BLK_MQ_POLL_STATS_BKTS 16=0A=
>>   =0A=
>> +/* Doing classic polling */=0A=
>> +#define BLK_MQ_POLL_CLASSIC -1=0A=
>> +=0A=
>>   /*=0A=
>>    * Maximum number of blkcg policies allowed to be registered concurren=
tly.=0A=
>>    * Defined here to simplify include dependency.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
