Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C78C4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 17:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD44A207FF
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 17:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BBz/8bI0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Kv/apxwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfI0Rd7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 13:33:59 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8272 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0Rd7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 13:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569605639; x=1601141639;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=R2JmrNO+lAn9fC9eojlxdmUMLCjWSy6wB8Iz3q91+Pc=;
  b=BBz/8bI02JdSMA5QYmR+Du/lHIjqxFb6RG67pReAnoLqUwCrRBFDVa17
   W32j5YvnE63DnJLUhKIPv2Zv9Uw9ksLjA2EUzAGq81foFltQhtUQmPlVA
   9QrzZ3xo49X06wmZCnxCBwRSNUb9JRODBid6mrlW+0BBogPw769sfNxeR
   RvV8agGCWLbuBTThrzetGtk5aIBqGEmN22qvd4tHUde3f+q2YRcERhUU4
   HowzgfOMxV8wp4mPRRyeA0VAbNHpO9jHhsoaequCUrpK4wEk9yHOWOWtr
   SdEQ3qTD83UJtec9rNgWFmUbNEajAn3cALRyjZeZMDGCoKSOH7G0YwESq
   w==;
IronPort-SDR: 8ogSdw8pD3xSQDnPnZCW9wnTBqb3bRgWKtztZ3GafzEEsmai27idVXLIxUeptfamonHox8Fc95
 Fm+Hfn5Pkub6Oqn72O7UBXN3NT1NdYn7YJvnZ1wfigwBMrJWGoTnzmBHtsa7pums+I8C3O9uOY
 lnJ6hPzXrJJJwvrUKsRIXbUSwywJumuPy7K/w6dCoYSKmWwW/Tttsq6w4VUOZMSdn6lg3XgikK
 B3+kHKlwRzT8vEMuE1t7ux27wQfexkZ3KbxEpA9fj/cM0NKaif2OCdB8VCENBtcsRH61ZzBHyU
 LYw=
X-IronPort-AV: E=Sophos;i="5.64,556,1559491200"; 
   d="scan'208";a="120873825"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2019 01:33:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPW1xGjNOWav0i1lN1+834yv1IvqJnFdx9DtoRCNi3p87dJfnc/BY4B3LPBO5siil8DP/BUMX3zftFzRPZXy4jgic2OjZji2rYIADmnUlI+acv3CucwZuOxboMLH4aJBrnbYbvR7AEeBUtSw173owR9TiO+0WaAEaO1HBPlVJwioGRhUPJreq17OZ1SyHyGNjyXA6r+svg/3s4L8mfRY/55TPV3bBJ5Pwk9NzFEx5PFCJQMlZ16oCuQEjIar7VI5+BL07SzDzDSNGeLE3eggRV0MkB3uWoDe5vaHq0/Ji53xQqrIgGCZ3jSr9sGibe9hic4Swx/zaROO0gCwoS/pUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gO0W4Bng5XbT22pqk75WPXxpknSO0JtwueHapRXbx0=;
 b=PQH/koSozgTZJ+Bp2fCgISrD/sUYGisByJOGnA/8oDfXOzzBIhIcaISKZBuDa498z+kZ/vBidZIc8jT/q+5uOeRqT41MTEJoDskZP5uA8VHYegCFje5A7A0aWH3K8kgeEl9vPWzUuf+kxXshv4fBdn7Fd4STy/pRv5DtS4f1I44hqkvnPagEt7x5dAWK9ERytp7t5PYCX0jU4GtbxM4OFl/RKKwV1dq7Kmg6Z03jpkQbWPoJS1SMSLoA4zqb+fRhpk9h4eGDCSQtVVn5U9mr6JmQpg133UUjlfDRxTW1aDOtZjyza8KeXmsGPKSpoPk0XpETEICm/I8sF2p+br9Czg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gO0W4Bng5XbT22pqk75WPXxpknSO0JtwueHapRXbx0=;
 b=Kv/apxwUU1uSRp4N87PvWqhofaLBBFiX6cwR6GXAyfwtI8Z/gR21Iiag0a0TJfGlHUIcT/FHVLKAtcjJOewEZSmr81Si44mY0WAk65g0pprm9/LWCBCTG4gq2lIqIhkDbKEezY1X7c8yQFDcHNSaWQzPgdTGJ8KCgAAN5VmZyZ0=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4071.namprd04.prod.outlook.com (52.135.215.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 27 Sep 2019 17:33:55 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117%3]) with mapi id 15.20.2284.028; Fri, 27 Sep 2019
 17:33:55 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 1/2] blk-mq: respect io scheduler
Thread-Topic: [PATCH 1/2] blk-mq: respect io scheduler
Thread-Index: AQHVdQSz1R5UWPhzK0WufyKE7KOizQ==
Date:   Fri, 27 Sep 2019 17:33:55 +0000
Message-ID: <BYAPR04MB58167AD06CEC7ED2E0CC4BE3E7810@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190927072431.23901-1-ming.lei@redhat.com>
 <20190927072431.23901-2-ming.lei@redhat.com>
 <BYAPR04MB58166A77C55B3B8667B37554E7810@BYAPR04MB5816.namprd04.prod.outlook.com>
 <ac7a494c-9d83-6cc1-ac39-3cdd258ddb68@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af5c81af-db03-40e1-4559-08d74370df4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4071;
x-ms-traffictypediagnostic: BYAPR04MB4071:
x-microsoft-antispam-prvs: <BYAPR04MB4071A8F0259C823AF38FB9C0E7810@BYAPR04MB4071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(199004)(189003)(76176011)(14444005)(5660300002)(76116006)(6246003)(14454004)(186003)(25786009)(7736002)(66066001)(33656002)(66446008)(9686003)(102836004)(8676002)(66556008)(55016002)(66476007)(64756008)(4326008)(305945005)(6436002)(54906003)(81166006)(81156014)(110136005)(316002)(486006)(6116002)(3846002)(52536014)(476003)(446003)(8936002)(66946007)(2906002)(256004)(71190400001)(6506007)(99286004)(71200400001)(229853002)(26005)(53546011)(478600001)(74316002)(86362001)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4071;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IX6yVVLTct/S9nIgoyCjpnhPPa9w2jn/Spx819PJoaDW4asgxhycOEmET9i7ihw9YajoeV49FG3jLbPBo/EdxMlp7YR3NAhb511LZTTwFSvahFP+UItYW1mvvmR8JkyJ1/nZ3TqIhJAIqBV/zYWLvlnapfwtiQOhlC9YKaK1O5d9ZG59NSHKuw5qSGEbzxYtH9wWs++smjqtMlyqLi4rsF+zirvp1YW/QIiF/PQtcfrWeDZM1vW19Gh/zo0hxn2Y7NgYH+dxKcNW6jS/5wTwBnH56CX0AhPBCIN5SvYhutPS6KagvzZSX3hqGDilToBHOsFgKJH1KBdRzC+q3Vjoa/yC/2ovF+AEjvY8iNJDIpXiH7qg34qMdieLjP6VzOg+wxgqYW4PgSQBFu4f/8mohrmE8Atk2UMI1UoU+a9wtxQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5c81af-db03-40e1-4559-08d74370df4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 17:33:55.6160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOmoAeVgSPuAeg/RsWDxVAbv5BRWYWJS3UBIrcxsop9/e7QY0gdhGHrfvh+UCtTyRkgRfIKJzI1p2FZGkyzG7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4071
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/09/27 10:32, Jens Axboe wrote:=0A=
> On 9/27/19 7:25 PM, Damien Le Moal wrote:=0A=
>> On 2019/09/27 0:25, Ming Lei wrote:=0A=
>>> Now in case of real MQ, io scheduler may be bypassed, and not only this=
=0A=
>>> way may hurt performance for some slow MQ device, but also break zoned=
=0A=
>>> device which depends on mq-deadline for respecting the write order in=
=0A=
>>> one zone.=0A=
>>>=0A=
>>> So don't bypass io scheduler if we have one setup.=0A=
>>>=0A=
>>> This patch can double sequential write performance basically on MQ=0A=
>>> scsi_debug when mq-deadline is applied.=0A=
>>>=0A=
>>> Cc: Bart Van Assche <bvanassche@acm.org>=0A=
>>> Cc: Hannes Reinecke <hare@suse.com>=0A=
>>> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>> Cc: Dave Chinner <dchinner@redhat.com>=0A=
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
>>> ---=0A=
>>>   block/blk-mq.c | 6 ++++--=0A=
>>>   1 file changed, 4 insertions(+), 2 deletions(-)=0A=
>>>=0A=
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
>>> index 20a49be536b5..d7aed6518e62 100644=0A=
>>> --- a/block/blk-mq.c=0A=
>>> +++ b/block/blk-mq.c=0A=
>>> @@ -2003,6 +2003,8 @@ static blk_qc_t blk_mq_make_request(struct reques=
t_queue *q, struct bio *bio)=0A=
>>>   		}=0A=
>>>   =0A=
>>>   		blk_add_rq_to_plug(plug, rq);=0A=
>>> +	} else if (q->elevator) {=0A=
>>> +		blk_mq_sched_insert_request(rq, false, true, true);>  	} else if (pl=
ug && !blk_queue_nomerges(q)) {=0A=
>>>   		/*=0A=
>>>   		 * We do limited plugging. If the bio can be merged, do that.=0A=
>>> @@ -2026,8 +2028,8 @@ static blk_qc_t blk_mq_make_request(struct reques=
t_queue *q, struct bio *bio)=0A=
>>>   			blk_mq_try_issue_directly(data.hctx, same_queue_rq,=0A=
>>>   					&cookie);=0A=
>>>   		}=0A=
>>> -	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&=0A=
>>> -			!data.hctx->dispatch_busy)) {=0A=
>>> +	} else if ((q->nr_hw_queues > 1 && is_sync) ||=0A=
>>> +			!data.hctx->dispatch_busy) {=0A=
>>>   		blk_mq_try_issue_directly(data.hctx, rq, &cookie);=0A=
>>>   	} else {=0A=
>>>   		blk_mq_sched_insert_request(rq, false, true, true);=0A=
>>>=0A=
>>=0A=
>> I think this patch should have a Cc: stable@vger.kernel.org=0A=
>> This fixes a problem existing since we added deadline zone write-locking=
 with=0A=
>> commit 5700f69178e9 ("mq-deadline: Introduce zone locking support").=0A=
> =0A=
> I'd rather not mark it for stable until it's been in the kernel for some=
=0A=
> weeks at least, since we are potentially dealing with behavioral change=
=0A=
> for everyone. We've been burnt by stuff like this in the past.=0A=
> =0A=
> That said, this patch could be a candidate. Let's revisit in a few weeks.=
=0A=
> =0A=
=0A=
OK. Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
