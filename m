Return-Path: <SRS0=ZSeo=EM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AB5C2D0A3
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 14:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116CC207F7
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 14:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hpMzJmJk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VHZgoQ3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKFOIq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 09:08:46 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:16055 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgKFOIp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Nov 2020 09:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604671725; x=1636207725;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YWtl1cdp38S9wTlHf1O39sYRhtmaPJVzuuIFRTmSEK4=;
  b=hpMzJmJkpkPuSQqFkhaR2liO8G9m89lseHJQTrJQkPbzsGOiK1FOd2Vv
   kEoctwMXRuOjJyW0g3Z+D30Sa9atmAAEH1DwiUx7bbxFvscvD7PoXNwnk
   pWvqqfxDka2GQkZHJ5NcbmAN1BTbcj7QEOE/uoohuIFt4J5GPFRUXNT5R
   gClT/ri0bpnJ+DvvGhjBizrs5C+rQGSeYFrQlfg+ohxWd87Hgx3J5EaQl
   9W0q5JGDE0QhA3LHZ4nkooDeg6oiPxKuth52rnOMyXaIp2GsaqfO0Nkud
   kvnWUoF9iMY8zELRZRmxb+t+KJlWZkjmwgCbxOBBzPNWNXvJt+Jj4h39W
   g==;
IronPort-SDR: KU3XVtkKtzT0zhYU0bfPeMoyxxXz9MCielFm1Z0B2NlBvUq591Gp5NWxHGPImf1IiD5CAgiUdd
 CeAmdnDO5eMUrJgkbEeQ7oRkNpdwUdFsLzs9M3rb4zymATbFO+RzAj9fO9RFoKJKyX07YZFDNX
 zXPGebL3gOYS/r8Df5X9khnKw0Q2OQbPgBWHqxaFr8a7+HIw33IK1znvDBk8t/2+7VzmBYxyp6
 Z2YO9wGafO6UbOEkwQxBv+JPcUDs0V18qkU3CDqRXvRSjAD57ehrqg1qJwUcZ4FPYz7cX05Mzz
 k2w=
X-IronPort-AV: E=Sophos;i="5.77,456,1596470400"; 
   d="scan'208";a="262025032"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 22:08:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1ZeW1ESeeAGFtdhfmFT6T8cqaTcsUDHa+bqAlL/sM89IS8XbsYov12xyzTkAZwGNeCQUgjNkxOyKcul94KF3v2TsjyO9oSmlaGrcgw0am3ePZymoUj9RSASY1Yy9uuRXpQBtc/k/cL/jmxPIDTgAornbDnidUzpBv88pPRIHBUc3TVzFIEHfbBsBZw98f2NTR2i/Yv2epMF4SEZfrRYUBPkC2urXWy5U8jIhyaKGDojzdI1w/zvpo/2XiaebtA21mIgbxiq3RFYjn/1H2FcSMt7hT9FdLaCkdgMVefId8kztb9SH2w1dFR0TKbGAcDOd4PZK1xP93jEWM3gTDt3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62Rv8dGpucJDUK+wynPoYVONxFimkqngzbuKvSaSZEo=;
 b=a/K3X/+EvI2CmfZnErdvu1/Op4RrHLjoK96vPJYLSZLRlKcW8TgE9GNMx7cUWlsX9Gqr6B2+yKa/ku4bCYeOk3fmLME1rOJ6Q75xaqevUO+eNtjOzll4r1dctc/vIa8Pa13S4P6QzKb3nVzUJRLQ+4l9jEzysuKvpnMuCE+48+cqHXnQ8xF5zimYy5WaJgxNcMUDvxnou7YuZVGQgKn5DIMB7w4lD/Gs03cKs3428cvVjzDGc6DptxSrpkSICvco/6hGZe7sNMccnAmxtp+ilpkE78PmX0SWE8A7aDjvuX4TXYeWghDHF+3+zdKgUeHLXqO9I4lW6NlxTFhU+nEspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62Rv8dGpucJDUK+wynPoYVONxFimkqngzbuKvSaSZEo=;
 b=VHZgoQ3XYLPrPoTQiDt2/N3g05vTBes5Yv6L5VYlEGfI6Stg9vFy7G1VVx6kHtZV04yz9iP6cfdTwsCuJTWpuaqD8/IucvnS10QDZzQs2RMmuPhb801+NGG+wY5m79nCjG1G1fnDHbEkXQx1PZzYSabfYAMUNjPsSmV4/CFmQFA=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4738.namprd04.prod.outlook.com (2603:10b6:208:4c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 14:08:42 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 14:08:42 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: Fix scheduling in atomic with zoned mode
Thread-Topic: [PATCH] null_blk: Fix scheduling in atomic with zoned mode
Thread-Index: AQHWtCw7QeWr2UE3BEOjKG7Bm7c3fw==
Date:   Fri, 6 Nov 2020 14:08:42 +0000
Message-ID: <BL0PR04MB6514C9CB9BE390D5276A4907E7ED0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201106110141.5887-1-damien.lemoal@wdc.com>
 <20201106135532.GA16634@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:89bb:1cde:d92a:2dcb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3bef7632-1c46-4945-eb1b-08d8825d77cd
x-ms-traffictypediagnostic: BL0PR04MB4738:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BL0PR04MB473833E12D8DCCE4185C7A7EE7ED0@BL0PR04MB4738.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvJQo7GA/2mBtDHP7Ia1gkiXpsCvTT8rVAoaJJrzXvAPfZDYs6+BP4XYGnKicCQnQbAE+G0XjmfdTyn2iZIsbB6lOVNjJXH+fIeajB53jqn7R6shlZgD3jkMZpWf1AiDxeYYUjdXBCv0WZdu/BYonm2jJDHroPsBzqw9/EiGZy3kMxtD58PlQJ9Ms2aX3ZHpADkGE1w5auvcF2At/uUCI82dMAu5s38UQIjD+uhQGJaKBGls/2Zv2JfkzQfw+WdhmklFMP48Az3p2KugKmLd65EUXbzFgsMgE3j7X+mlC2yb9XlBHmUL+BezntKa/YH8qL3Hnz0w9sCicLfHhPr59w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(7696005)(91956017)(52536014)(186003)(33656002)(55016002)(66556008)(53546011)(2906002)(83380400001)(6506007)(6916009)(66446008)(86362001)(66476007)(8936002)(478600001)(316002)(54906003)(64756008)(8676002)(66946007)(9686003)(71200400001)(4326008)(76116006)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SKGff/OQoSY2j1zwwP0O53nwJHkgoeGScQk2L03+7Oxdpiy6IQBovpm/do1Fu7rl4h+a9+SuSh0c3l7j5Aq/9vXajuLcxuovMHxCIaqudj5A9Hm6WzYjXDcr66Y02du0/tmyGfUBDh4hofkZbqA104PA1WTo87gt2ihFfq6yAplpPi7MPuW3l4/4JsNal3DrzLWFvNHu4vudGHwdc/vui+1LVQIEYkQ8yh0aHrq9C8xg2bovCCm7bUojpwOJms9bU/HlD4zOqqjK3RW2Ffw9NDo6+jYTljYSRdf+/zFjf6Wgx/4tkD3TifvmlrhLWbDg0eF6sVXe5a9+hfRFSeojM2igV+GJ3bzEXnjJqo6rzqCc48QYTXScpJwygdiy/D+DxxgQmhd3dERU7qPdg4l7c6ta8wyJn0yrVld+9cHThzAq7dOQl1hNwW5uU5k+bCC/sB9DD9xTVan/VcPP3V8WcNqwbwbDfwJu37UtJc8qnTr/NFpxLheT27f2S/YgcTAFUvhP38+UxNRhxnizaCsttPce9i2AixT2JyU/lCP6X7wH5X39Xnk9QkOrIKsxdGj50RTrAlotXYMopZw2fR/roT0n201gYC2IiOyxI8NuWrWMGibxU6Q1hMIIWSWkZbSbOAF/q6wDDZ2Xl95fv8hqLI5sIN7CbttmBURqsy4JVboQybe2GN/hvtwMJYeYzG8pb6V3bB7O+MsIf3XdcxKvig==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bef7632-1c46-4945-eb1b-08d8825d77cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 14:08:42.5876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtNDE+Kg1BjZYPcQw0ZHEaS6aAxoBlgTQY43rlcrrVsCo+JWsqbL6FMq8VA6RoXEtF7LM7Dmo4AmFFnZLGYaWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4738
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/06 22:55, Christoph Hellwig wrote:=0A=
> On Fri, Nov 06, 2020 at 08:01:41PM +0900, Damien Le Moal wrote:=0A=
>> Commit aa1c09cb65e2 ("null_blk: Fix locking in zoned mode") changed=0A=
>> zone locking to using the potentially sleeping wait_on_bit_io()=0A=
>> function. This is acceptable when memory backing is enabled as the=0A=
>> device queue is in that case marked as blocking, but this triggers a=0A=
>> scheduling while in atomic context with memory backing disabled.=0A=
>>=0A=
>> Fix this by relying solely on the device zone spinlock for zone=0A=
>> information protection without temporarily releasing this lock around=0A=
>> null_process_cmd() execution in null_zone_write(). This is OK to do=0A=
>> since when memory backing is disabled, command processing does not=0A=
>> block and the memory backing lock nullb->lock is unused. This solution=
=0A=
>> avoids the overhead of having to mark a zoned null_blk device queue as=
=0A=
>> blocking when memory backing is unused.=0A=
>>=0A=
>> This patch also adds comments to the zone locking code to explain the=0A=
>> unusual locking scheme.=0A=
>>=0A=
>> Reported-by: kernel test robot <lkp@intel.com>=0A=
>> Fixes: aa1c09cb65e2 ("null_blk: Fix locking in zoned mode")=0A=
>> Cc: stable@vger.kernel.org=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>  drivers/block/null_blk.h       |  2 +-=0A=
>>  drivers/block/null_blk_zoned.c | 47 ++++++++++++++++++++++------------=
=0A=
>>  2 files changed, 32 insertions(+), 17 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h=0A=
>> index cfd00ad40355..c24d9b5ad81a 100644=0A=
>> --- a/drivers/block/null_blk.h=0A=
>> +++ b/drivers/block/null_blk.h=0A=
>> @@ -47,7 +47,7 @@ struct nullb_device {=0A=
>>  	unsigned int nr_zones_closed;=0A=
>>  	struct blk_zone *zones;=0A=
>>  	sector_t zone_size_sects;=0A=
>> -	spinlock_t zone_dev_lock;=0A=
>> +	spinlock_t zone_lock;=0A=
>>  	unsigned long *zone_locks;=0A=
>>  =0A=
>>  	unsigned long size; /* device size in MB */=0A=
>> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zon=
ed.c=0A=
>> index 8775acbb4f8f..beb34b4f76b0 100644=0A=
>> --- a/drivers/block/null_blk_zoned.c=0A=
>> +++ b/drivers/block/null_blk_zoned.c=0A=
>> @@ -46,11 +46,20 @@ int null_init_zoned_dev(struct nullb_device *dev, st=
ruct request_queue *q)=0A=
>>  	if (!dev->zones)=0A=
>>  		return -ENOMEM;=0A=
>>  =0A=
>> -	spin_lock_init(&dev->zone_dev_lock);=0A=
>> -	dev->zone_locks =3D bitmap_zalloc(dev->nr_zones, GFP_KERNEL);=0A=
>> -	if (!dev->zone_locks) {=0A=
>> -		kvfree(dev->zones);=0A=
>> -		return -ENOMEM;=0A=
>> +	/*=0A=
>> +	 * With memory backing, the zone_lock spinlock needs to be temporarily=
=0A=
>> +	 * released to avoid scheduling in atomic context. To guarantee zone=
=0A=
>> +	 * information protection, use a bitmap to lock zones with=0A=
>> +	 * wait_on_bit_lock_io(). Sleeping on the lock is OK as memory backing=
=0A=
>> +	 * implies that the queue is marked with BLK_MQ_F_BLOCKING.=0A=
>> +	 */=0A=
>> +	spin_lock_init(&dev->zone_lock);=0A=
>> +	if (dev->memory_backed) {=0A=
>> +		dev->zone_locks =3D bitmap_zalloc(dev->nr_zones, GFP_KERNEL);=0A=
>> +		if (!dev->zone_locks) {=0A=
>> +			kvfree(dev->zones);=0A=
>> +			return -ENOMEM;=0A=
>> +		}=0A=
>>  	}=0A=
>>  =0A=
>>  	if (dev->zone_nr_conv >=3D dev->nr_zones) {=0A=
>> @@ -137,12 +146,17 @@ void null_free_zoned_dev(struct nullb_device *dev)=
=0A=
>>  =0A=
>>  static inline void null_lock_zone(struct nullb_device *dev, unsigned in=
t zno)=0A=
>>  {=0A=
>> -	wait_on_bit_lock_io(dev->zone_locks, zno, TASK_UNINTERRUPTIBLE);=0A=
>> +	if (dev->memory_backed)=0A=
>> +		wait_on_bit_lock_io(dev->zone_locks, zno, TASK_UNINTERRUPTIBLE);=0A=
>> +	spin_lock_irq(&dev->zone_lock);=0A=
>>  }=0A=
>>  =0A=
>>  static inline void null_unlock_zone(struct nullb_device *dev, unsigned =
int zno)=0A=
>>  {=0A=
>> -	clear_and_wake_up_bit(zno, dev->zone_locks);=0A=
>> +	spin_unlock_irq(&dev->zone_lock);=0A=
>> +=0A=
>> +	if (dev->memory_backed)=0A=
>> +		clear_and_wake_up_bit(zno, dev->zone_locks);=0A=
>>  }=0A=
>>  =0A=
>>  int null_report_zones(struct gendisk *disk, sector_t sector,=0A=
>> @@ -322,7 +336,6 @@ static blk_status_t null_zone_write(struct nullb_cmd=
 *cmd, sector_t sector,=0A=
>>  		return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);=0A=
>>  =0A=
>>  	null_lock_zone(dev, zno);=0A=
>> -	spin_lock(&dev->zone_dev_lock);=0A=
>>  =0A=
>>  	switch (zone->cond) {=0A=
>>  	case BLK_ZONE_COND_FULL:=0A=
>> @@ -375,9 +388,17 @@ static blk_status_t null_zone_write(struct nullb_cm=
d *cmd, sector_t sector,=0A=
>>  	if (zone->cond !=3D BLK_ZONE_COND_EXP_OPEN)=0A=
>>  		zone->cond =3D BLK_ZONE_COND_IMP_OPEN;=0A=
>>  =0A=
>> -	spin_unlock(&dev->zone_dev_lock);=0A=
>> +	/*=0A=
>> +	 * Memory backing allocation may sleep: release the zone_lock spinlock=
=0A=
>> +	 * to avoid scheduling in atomic context. Zone operation atomicity is=
=0A=
>> +	 * still guaranteed through the zone_locks bitmap.=0A=
>> +	 */=0A=
>> +	if (dev->memory_backed)=0A=
>> +		spin_unlock_irq(&dev->zone_lock);=0A=
>>  	ret =3D null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);=0A=
>> -	spin_lock(&dev->zone_dev_lock);=0A=
>> +	if (dev->memory_backed)=0A=
>> +		spin_lock_irq(&dev->zone_lock);=0A=
> =0A=
> Do we actually need to take zone_lock at all for the memory_backed=0A=
> case?  Should the !memory_backed just use a per-zone spinlock?=0A=
=0A=
For your first question, yes we do: the per zone wait_on_bit_io() lock seri=
alize=0A=
zone operations per zone but we need a device level zone lock for protectin=
g the=0A=
counters (imp open, exp open and closed) for zone resources management.=0A=
=0A=
For the !memory backed case, I wondered the same but decided to just reuse =
the=0A=
device zone spinlock as the single lock for all zones. Not sure if a per zo=
ne=0A=
spinlock would improve performance by that much given that the lock time fr=
ame=0A=
becomes really tiny without the memory copy. I will try that to see how=0A=
performance changes.=0A=
=0A=
That said, I would prefer to add such change as a different patch for next =
cycle=0A=
and keep this patch as a bug fix though.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
