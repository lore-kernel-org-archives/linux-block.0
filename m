Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0143DC4360C
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 06:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F0721855
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 06:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ReiLASS/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rbeyeosI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfI3GUJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 02:20:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5971 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3GUJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 02:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569824409; x=1601360409;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OIUj7Y4m5fsXWJYxI+3JbYLsPcR9cZHiQZAueEibxiQ=;
  b=ReiLASS/WF6WyduD5ITz0A/3cmJgzdar1U4zjZp+j2cr97FwtHgqarAi
   X0ATWgijzuupnaLkVh/uvG30hCznL0YhmgTXw4zx0FY2DkBn/7Z0U91YM
   +0BrbNnAqpHGEgJ0NyeYSfIt4UpkNXcppja2p04DB88jZit89CMpDyEq1
   Zmiic8YO9kSxbZgewohPm1HSv1mNsjL1F401Bxvd7Eq4xIIJkqcwFjDOs
   TK4Su1UU8nAV5jNp1nuYLV8tktHWC53VnqkDaCyZ25ttM50lYogh+SLdv
   IEgJSfH3o7f1puPdiroSHUUyTAYjpE+n4fHNBfeJUPcH08DreAp8w5BUa
   A==;
IronPort-SDR: 0Ty8Sz8iefmtMe/E5r4H0bm5+ziVoCYYGyL6n0ZrhJpqpX4sBm+3AWiZRNMgZ6zw+jGvotAJjz
 Kxr1GPRIIzlTbqtddfoJ6ZhrtBBKgPuhNAUtXDyGFIIRjytUE1K6scLMl9u3KK7VZ/ObJQP75t
 b0v3IFw6zf/ez4K8yh7BZkpaUnh8vlFOmbIE0bVfXpmCKUaYkuPrTtbHny77uS+1hkyU8wIscM
 2TjjNtoGXvo9x7+WliTOW6IS0syGYdNT7Fw1m9IL8iftf2vxXNgxV5O+ZDE9QEwhB8WXMDyExN
 1Gk=
X-IronPort-AV: E=Sophos;i="5.64,565,1559491200"; 
   d="scan'208";a="120985967"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2019 14:20:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLNguwUv7Zuag5JkCXuzvAp3lETJVdjnoOXzMjdAwPu37Hc1iz/jIbikBgpCM2FRIgBLhc43vsO7DRTLPcQHu54qP0ycMLXxM0O8kQsf1EHuqX4bby9LmAVvDD1gGTaVZ4YIEiiQG3AdQ+UL0OAGVJ6P3wIoBEOt+X0+unveCTj8o3w6Lul1jTQ9eGWLcEP4DPxCdzCves+HyXEbF+k5HxlFkKkpl612vsFHOIPKymAJurqzvcTGNgn4llVC+87jSntvqt9y8ESGdiE2+tvvSPO3UIZIPIRoLi4QyKp9GkIwfN3FtXkejMmlCStMU9B8JIQ6Wj/V+QyKbdadgcl8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOy0l7L/g33wROqvuD+rqiAQWSEjPORs9YLkN9nU+Sc=;
 b=BfxDdlXDB2Y76hOrFDmwp7PIVy1aVNwalls1/hs7s8ATEm6SNyr9JxQJarK0G5qE1kLuiTpQaDUFlj+iQOzpo0JezyOpXvf0T25uozNybdgxkI51UgYeDLCqKUH5egZDdfTIdoHMC1NeIUBFqBpYF1FCYPvkOX/lziew4ki8GE+kGWPrzd7rKm0aCZynnWQN33lohUrtBsw51ULJ4Vn+TBZFZvXpz5yhp4d7VIjQYrN4t3KiHalLZN+GnnWqqK9kZZn6VogD5WjAt3yIuS0fKyH7fhTlGqSUnMe7BmMK/QlI8Gp7xAfLplZTXTrF7bTfYG2nLucMU6RSLLcm5tbyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOy0l7L/g33wROqvuD+rqiAQWSEjPORs9YLkN9nU+Sc=;
 b=rbeyeosIKzc+Kb31m6EKyWniySQNWwkGSsFE6ROQYP5kC5LvrNnDn4bHlI4431laiuiq7IQR3ssuFSZPd6tDmTmqo38CdgSsvz6NJzi+sNPqnD3Iw5721830uQ72uz/KJx9n2FjkeYYDOAkgFjXG3aOWDOBH9kXW8/o/epA92Q8=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5093.namprd04.prod.outlook.com (52.135.234.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 06:20:06 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::84c4:833e:ec0b:5053]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::84c4:833e:ec0b:5053%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 06:20:06 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Xiubo Li <xiubli@redhat.com>,
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
Date:   Mon, 30 Sep 2019 06:20:06 +0000
Message-ID: <BYAPR04MB581605EF9377C18074099232E7820@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190930015213.8865-1-xiubli@redhat.com>
 <20190930015213.8865-2-xiubli@redhat.com>
 <BYAPR04MB58160630271A8E552F7FD5D8E7820@BYAPR04MB5816.namprd04.prod.outlook.com>
 <544c7d2a-6600-9a8a-2f75-03e1d3211912@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [83.175.114.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4d25a00-d1ef-4afc-f2ab-08d7456e3cd7
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR04MB5093:
x-microsoft-antispam-prvs: <BYAPR04MB509395BA427B3CA124E9F5E4E7820@BYAPR04MB5093.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(76176011)(66446008)(7696005)(6436002)(102836004)(99286004)(54906003)(110136005)(3846002)(229853002)(81166006)(316002)(8676002)(81156014)(6116002)(26005)(8936002)(71190400001)(9686003)(55016002)(186003)(6246003)(256004)(71200400001)(4326008)(86362001)(2201001)(6506007)(2906002)(14444005)(53546011)(52536014)(66066001)(74316002)(476003)(446003)(14454004)(25786009)(305945005)(7736002)(5660300002)(64756008)(66556008)(66476007)(66946007)(76116006)(91956017)(2501003)(478600001)(33656002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5093;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ljbtdc/weRZcc1f3p8+1oZPOcGiPEf0v9/c3aHEXt9wlZOyzAdl+TcjUPl0/lN3P9EksDKul3vQLYryNiFo7GKVaMSMdZpFg+qawuw6QqJHSDFHlZNwUcTXpVElolbgiFE4jh1a4apppD+kHI8yaoS4LGUchGLCb9HB+fkfsd7X3wLw+eSXWxeLYFgyNCB92FggFMpt1clKLIcB+fQsZiAPPgREyOmJl1PsESPMa8TSkBuhHDFwE6KhErXDb0ejYmDAvVZnWtfvCFpbZYF7xanZZj1DHR/0piB98HiBXRSJvudTQFaDmSgccS3ZIA3TfqdTnF6fqv4Y+ahegL/mOAtLDNYU17h8jncK6PAiClEYRK7HlbrzJUOJXerdzTp2JJ7PFJql1hzG2Yak6eHBHTzMvZJsvBkbv71+KrnvLSiY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d25a00-d1ef-4afc-f2ab-08d7456e3cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 06:20:06.4689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Axl5hYgovyW4fdPh9kmKGXX6FdaYeP2CjzPuctmsCbXkVCwBCXxp5xd2dx7QqqEV38sOQxOcykjX2y/RC6rvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5093
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/09/29 22:50, Xiubo Li wrote:=0A=
> On 2019/9/30 13:28, Damien Le Moal wrote:=0A=
>> On 2019/09/29 18:52, xiubli@redhat.com wrote:=0A=
>>> From: Xiubo Li <xiubli@redhat.com>=0A=
>>>=0A=
>>> For some storage drivers, such as the nbd, when there has new socket=0A=
>>> connections added, it will update the hardware queue number by calling=
=0A=
>>> blk_mq_update_nr_hw_queues(), in which it will freeze all the queues=0A=
>>> first. And then tries to do the hardware queue updating stuff.=0A=
>>>=0A=
>>> But int blk_mq_alloc_rq_map()-->blk_mq_init_tags(), when allocating=0A=
>>> memory for tags, it may cause the mm do the memories direct reclaiming,=
=0A=
>>> since the queues has been freezed, so if needs to flush the page cache=
=0A=
>>> to disk, it will stuck in generic_make_request()-->blk_queue_enter() by=
=0A=
>>> waiting the queues to be unfreezed and then cause deadlock here.=0A=
>>>=0A=
>>> Since the memory size requested here is a small one, which will make=0A=
>>> it not that easy to happen with a large size, but in theory this could=
=0A=
>>> happen when the OS is running in pressure and out of memory.=0A=
>>>=0A=
>>> Gabriel Krisman Bertazi has hit the similar issue by fixing it in=0A=
>>> commit 36e1f3d10786 ("blk-mq: Avoid memory reclaim when remapping=0A=
>>> queues"), but might forget this part.=0A=
>>>=0A=
>>> Signed-off-by: Xiubo Li <xiubli@redhat.com>=0A=
>>> CC: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>=0A=
>>> Reviewed-by: Ming Lei <ming.lei@redhat.com>=0A=
>>> ---=0A=
>>>   block/blk-mq-tag.c | 5 +++--=0A=
>>>   block/blk-mq-tag.h | 5 ++++-=0A=
>>>   block/blk-mq.c     | 3 ++-=0A=
>>>   3 files changed, 9 insertions(+), 4 deletions(-)=0A=
>>>=0A=
>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c=0A=
>>> index 008388e82b5c..04ee0e4c3fa1 100644=0A=
>>> --- a/block/blk-mq-tag.c=0A=
>>> +++ b/block/blk-mq-tag.c=0A=
>>> @@ -462,7 +462,8 @@ static struct blk_mq_tags *blk_mq_init_bitmap_tags(=
struct blk_mq_tags *tags,=0A=
>>>   =0A=
>>>   struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,=0A=
>>>   				     unsigned int reserved_tags,=0A=
>>> -				     int node, int alloc_policy)=0A=
>>> +				     int node, int alloc_policy,=0A=
>>> +				     gfp_t flags)=0A=
>>>   {=0A=
>>>   	struct blk_mq_tags *tags;=0A=
>>>   =0A=
>>> @@ -471,7 +472,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int t=
otal_tags,=0A=
>>>   		return NULL;=0A=
>>>   	}=0A=
>>>   =0A=
>>> -	tags =3D kzalloc_node(sizeof(*tags), GFP_KERNEL, node);=0A=
>>> +	tags =3D kzalloc_node(sizeof(*tags), flags, node);=0A=
>>>   	if (!tags)=0A=
>>>   		return NULL;=0A=
>>>   =0A=
>>> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h=0A=
>>> index 61deab0b5a5a..296e0bc97126 100644=0A=
>>> --- a/block/blk-mq-tag.h=0A=
>>> +++ b/block/blk-mq-tag.h=0A=
>>> @@ -22,7 +22,10 @@ struct blk_mq_tags {=0A=
>>>   };=0A=
>>>   =0A=
>>>   =0A=
>>> -extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsi=
gned int reserved_tags, int node, int alloc_policy);=0A=
>>> +extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,=0A=
>>> +					    unsigned int reserved_tags,=0A=
>>> +					    int node, int alloc_policy,=0A=
>>> +					    gfp_t flags);=0A=
>>>   extern void blk_mq_free_tags(struct blk_mq_tags *tags);=0A=
>>>   =0A=
>>>   extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);=
=0A=
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
>>> index 240416057f28..9c52e4dfe132 100644=0A=
>>> --- a/block/blk-mq.c=0A=
>>> +++ b/block/blk-mq.c=0A=
>>> @@ -2090,7 +2090,8 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct bl=
k_mq_tag_set *set,=0A=
>>>   		node =3D set->numa_node;=0A=
>>>   =0A=
>>>   	tags =3D blk_mq_init_tags(nr_tags, reserved_tags, node,=0A=
>>> -				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));=0A=
>>> +				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags),=0A=
>>> +				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);=0A=
>> You added the gfp_t argument to blk_mq_init_tags() but you are only usin=
g that=0A=
>> argument with a hardcoded value here. So why not simply call kzalloc_nod=
e() in=0A=
>> that function with the flags GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY ? T=
hat=0A=
>> would avoid needing to add the "gfp_t flags" argument and still fit with=
 your=0A=
>> patch 2 definition of BLK_MQ_GFP_FLAGS.=0A=
> =0A=
> The blk_mq_init_tags() is defined in another separate file, which I think=
 it means to provide a common way of initializing the tags stuff, and curre=
ntly in this path it needs GFP_NOIO while in others in future it may not.=
=0A=
=0A=
blk_mq_alloc_rq_map() is currently the only user of blk_mq_init_tags(), so =
I do=0A=
not see the point in doing this change now. If it is needed "in the future"=
 then=0A=
do it then.=0A=
=0A=
I do not mind the patch going in as is, but I really think that everything =
can=0A=
be folded into your patch 2 without the addition of blk_mq_init_tags()=0A=
additional argument.=0A=
=0A=
> =0A=
> Thanks,=0A=
> BRs=0A=
> =0A=
> =0A=
>>>   	if (!tags)=0A=
>>>   		return NULL;=0A=
>>>   =0A=
>>>=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
