Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65546C432C3
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 00:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DAC20730
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 00:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oz/XqFVy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0J8dM0Ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfKRAC6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Nov 2019 19:02:58 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45618 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfKRAC6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Nov 2019 19:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574035376; x=1605571376;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mrnx+oPFJed2WKSzg844uqcZkETg9msscZPDt8jmTB4=;
  b=oz/XqFVyFdAM9UliuztMzDZTAZmbABprHbqvie0PswxeqpAOfurD9/Qx
   p2dyxsu2isl4zw7tdYmzK8BXt4A/1MQazzcLYaCo+83iDD/qgyfoeVbwY
   PD6MDNAcwyGxzHUQQ/hPIHNpKjT4pyvx3oRQly/xeX9EE/DYOBsSk1IlY
   BgspT1PFcB/5o3wRHVhWv+hlraCW7HOnN7IqwdQf3RVsPhwQj1BqVuY/M
   tTrJRjPw7s/UFxk4oFZIua7o5y9rrLmZg6y4zI/a+yJWMkFw/E7fouiYf
   JPJy0RJDA7V3ikxvN9Uu/uXtjwp3ffi65jnFu1JyJxflRe0gaBnE4uohH
   g==;
IronPort-SDR: 9X1NQ7jbztuH04a24ZzKg6R2tEpBkdAMdvEi7BRpAXNYodxUlWahy+EE2A/ej84AtWHp28zFK2
 F6wNaKEyig2uxbBtkgTy6CD2VbHNp/U6R2Skd7YJslprG743SllzlTWTCSxKKRcJCan6NNEBK8
 i43SyTUDgzQK71E9EWtZrlKyAUHP/J1yEYLi/TGLKBWmojZaKFWrIVfstFCiYtBPjpXnUoRWQG
 J39dYRFr7rh3rRjgcacHlGjw3pWSln1DuccFpYAVApcU4vFSZwcufD/lZo1zictJ6LALB7ne4y
 sdQ=
X-IronPort-AV: E=Sophos;i="5.68,318,1569254400"; 
   d="scan'208";a="124871805"
Received: from mail-co1nam05lp2058.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.58])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2019 08:02:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHbZ29etc3aflIfAh8L1DUbaNJ/6LmvSLB2mJ/lw1oZXBlMcDlYRpOO5ZmHXdhp/R7MZgfRu75w5JwA5ovaB6uP2LAmyOFDgJyGkieFJwOoGBg4srwE+FJjjx5bClENgTtcTAuU6y+SUwNxJEWdAwVCz0kKUWF3D6bGR+21zYkJfGbnKJlPF7EfG7FY/Hx9oEwILtNmeaffdsh9W0j+XYxuCagAlGoL7eWP5a5MsvuQKdY18g7N24lLfOJ3BqyCqaA+O99SdB3Tk02AMsx1FybO9nKY4obD2k8hvDJyieKXAu/GuvgqiIUxqD1omswXDdZdKYzBxAa7p9IXSraGw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAu68Jh+4M9uaXsqRZST0Iq7vlePCglA1BsmSVO/Yns=;
 b=UNTD0wkmvE1nY0ueBYvPud+fhrCQ3QsXlBNtzaJtgapVwQ4F+bH1FyvwMinr9KjdSFzxqLB66AZt9aejEMCJGO/dJ5+ZFLoXjrm6sxKO9iQ0dKmP0W06IXpzfVcoh/P0lPOi6qoYVm66J5mijblyg4Xk2FppXGeHG+RblQFFKAAeAiYI+89UW6r/E6qgxVn+acJxrRSDb6hYIwHcNkhuXPu44GjlJPgeH5hoa7jNquvQw+8+hO9SW0drPHLdD4vARF8xVO6m1Ku4Fko1aRn8+yyVucZiTuk/246grPmaGqWJzEnQO+vXKGk20SXk/6VfMGX1MX41vizZgrl39+KncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAu68Jh+4M9uaXsqRZST0Iq7vlePCglA1BsmSVO/Yns=;
 b=0J8dM0Ew2PUrn4Ed3lqkeily9sWCcaKS98L/DQKxDWXJrnyD8a94B0wQhnYm2y6u9yvFtxMKpgHGkgTBSgTSvXPOStePUc1xcN/RNKjEMrsuFBNUlXVZ5bYv16cmioGqKYak04AJHKEdwl5h7wFs4on79UbhCtnrQeKUrwcJHMM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5768.namprd04.prod.outlook.com (20.178.207.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 00:02:54 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 00:02:53 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     Bob Liu <bob.liu@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Bail out iteration functions upon SIGKILL.
Thread-Topic: [PATCH] block: Bail out iteration functions upon SIGKILL.
Thread-Index: AQHVlis75ysrnBQ8Tkec+aEy36lA2g==
Date:   Mon, 18 Nov 2019 00:02:53 +0000
Message-ID: <BYAPR04MB5816C1EE2D31B73F8E119BFFE74D0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <000000000000c52dbf05958f3f3a@google.com>
 <3fbc4bb2-a03b-fbfa-4803-47a6d0075ff2@I-love.SAKURA.ne.jp>
 <24296ff7-4a5f-2bd9-63c7-07831f7b4d8d@oracle.com>
 <8fde32da-d5e5-11b7-9ed7-e3aa5b003647@i-love.sakura.ne.jp>
 <BYAPR04MB58165EC2C792CE26AAAF361FE7770@BYAPR04MB5816.namprd04.prod.outlook.com>
 <272e3542-72ab-12ff-636b-722a68a2589c@i-love.sakura.ne.jp>
 <BYAPR04MB5816D18E6F6633030265B06EE7760@BYAPR04MB5816.namprd04.prod.outlook.com>
 <74a7ed17-0e2b-976c-0000-2774a1a10585@i-love.sakura.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6118a75a-57be-4ede-f847-08d76bbaa904
x-ms-traffictypediagnostic: BYAPR04MB5768:
x-microsoft-antispam-prvs: <BYAPR04MB576865DE9093DCC0495D0067E74D0@BYAPR04MB5768.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(189003)(199004)(66476007)(478600001)(86362001)(256004)(54906003)(14444005)(7696005)(486006)(5660300002)(26005)(55016002)(25786009)(7736002)(66066001)(305945005)(446003)(6916009)(6246003)(229853002)(476003)(6436002)(74316002)(14454004)(33656002)(81156014)(81166006)(8936002)(8676002)(4326008)(71190400001)(71200400001)(9686003)(6116002)(53546011)(6506007)(186003)(3846002)(76176011)(52536014)(102836004)(66446008)(64756008)(316002)(2906002)(66556008)(99286004)(91956017)(76116006)(66946007)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5768;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F426YJdqpSJ4XKYm/dHy4Wj7VOFL2R7QQ9Cr2z+T9AbtuuPEi2DKFdQSakWvH8AJSKYiuCkitAQHJvaJBb0WDS6rIsiN7fGoLN7cy9rVTDmTk/0/VsdSmEoQQwbRvDjykZS8Jx5m8ap87JlkiinCD6n2AgsUfmfbwY9ge4jtfNF+aP5wPw1z8VfJ0R5ki8Jtozv6k8JmnDD8lg9JxEg44d1jBWDxC9cEIGmyAzBwjojfNKPfFWgti+W12SKOG1iwWyWZXvZoiWB+9cL4UuMUgsFYeaq8yB7tORyqapaOw3SKDq0MS/cWjK7bi+laFhzf6tgEa05uqpwtQw2k9kygdTaRnF6GTYWx/owb6jzzq1JRyHOpY6aIBSppV1Po0V/D2XfBIQOcGpJRfeXlDt3i2mQSXB1a4CqEj3OMw50K+1u5AwZRKkjKgjB2c2Md1Mcf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6118a75a-57be-4ede-f847-08d76bbaa904
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 00:02:53.8599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U2isrxMmUKHvK4y/HQs5nBpYqjBgZ3fDTT/LKpDLwBfjIDukJ4W5FKE+JQjsW5qwYAe485QYAlth7wXTNS92WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5768
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/15 19:05, Tetsuo Handa wrote:=0A=
> On 2019/11/13 10:54, Damien Le Moal wrote:=0A=
>> On 2019/11/12 23:48, Tetsuo Handa wrote:=0A=
>> [...]=0A=
>>>>> +static int blk_should_abort(struct bio *bio)=0A=
>>>>> +{=0A=
>>>>> +	int ret;=0A=
>>>>> +=0A=
>>>>> +	cond_resched();=0A=
>>>>> +	if (!fatal_signal_pending(current))=0A=
>>>>> +		return 0;=0A=
>>>>> +	ret =3D submit_bio_wait(bio);=0A=
>>>>=0A=
>>>> This will change the behavior of __blkdev_issue_discard() to a sync IO=
=0A=
>>>> execution instead of the current async execution since submit_bio_wait=
()=0A=
>>>> call is the responsibility of the caller (e.g. blkdev_issue_discard())=
.=0A=
>>>> Have you checked if users of __blkdev_issue_discard() are OK with that=
 ?=0A=
>>>> f2fs, ext4, xfs, dm and nvme use this function.=0A=
>>>=0A=
>>> I'm not sure...=0A=
>>>=0A=
>>>>=0A=
>>>> Looking at f2fs, this does not look like it is going to work as expect=
ed=0A=
>>>> since the bio setup, including end_io callback, is done after this=0A=
>>>> function is called and a regular submit_bio() execution is being used.=
=0A=
>>>=0A=
>>> Then, just breaking the iteration like below?=0A=
>>> nvmet_bdev_execute_write_zeroes() ignores -EINTR if "*biop =3D bio;" is=
 done. Is that no problem?=0A=
>>>=0A=
>>> --- a/block/blk-lib.c=0A=
>>> +++ b/block/blk-lib.c=0A=
>>> @@ -7,6 +7,7 @@=0A=
>>>  #include <linux/bio.h>=0A=
>>>  #include <linux/blkdev.h>=0A=
>>>  #include <linux/scatterlist.h>=0A=
>>> +#include <linux/sched/signal.h>=0A=
>>>  =0A=
>>>  #include "blk.h"=0A=
>>>  =0A=
>>> @@ -30,6 +31,7 @@ int __blkdev_issue_discard(struct block_device *bdev,=
 sector_t sector,=0A=
>>>  	struct bio *bio =3D *biop;=0A=
>>>  	unsigned int op;=0A=
>>>  	sector_t bs_mask;=0A=
>>> +	int ret =3D 0;=0A=
>>>  =0A=
>>>  	if (!q)=0A=
>>>  		return -ENXIO;=0A=
>>> @@ -76,10 +78,14 @@ int __blkdev_issue_discard(struct block_device *bde=
v, sector_t sector,=0A=
>>>  		 * is disabled.=0A=
>>>  		 */=0A=
>>>  		cond_resched();=0A=
>>> +		if (fatal_signal_pending(current)) {=0A=
>>> +			ret =3D -EINTR;=0A=
>>> +			break;=0A=
>>> +		}=0A=
>>>  	}=0A=
>>>  =0A=
>>>  	*biop =3D bio;=0A=
>>> -	return 0;=0A=
>>> +	return ret;=0A=
>>=0A=
>> This will leak a bio as blkdev_issue_discard() executes the bio only in=
=0A=
>> the case "if (!ret && bio)". So that does not work as is, unless all=0A=
>> callers of __blkdev_issue_discard() are also changed. Same problem for=
=0A=
>> the other __blkdev_issue_xxx() functions.=0A=
>>=0A=
>> Looking more into this, if an error is returned here, no bio should be=
=0A=
>> returned and we need to make sure that all started bios are also=0A=
>> completed. So your helper blk_should_abort() did the right thing calling=
=0A=
>> submit_bio_wait(). However, I Think it would be better to fail=0A=
>> immediately the current loop bio instead of executing it and then=0A=
>> reporting the -EINTR error, unconditionally, regardless of what the=0A=
>> started bios completion status is.=0A=
>>=0A=
>> This could be done with the help of a function like this, very similar=
=0A=
>> to submit_bio_wait().=0A=
>>=0A=
>> void bio_chain_end_wait(struct bio *bio)=0A=
>> {=0A=
>> 	DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);=0A=
>>=0A=
>> 	bio->bi_private =3D &done;=0A=
>> 	bio->bi_end_io =3D submit_bio_wait_endio;=0A=
>> 	bio->bi_opf |=3D REQ_SYNC;=0A=
>> 	bio_endio(bio);=0A=
>> 	wait_for_completion_io(&done);=0A=
>> }=0A=
>>=0A=
>> And then your helper function becomes something like this:=0A=
>>=0A=
>> static int blk_should_abort(struct bio *bio)=0A=
>> {=0A=
>> 	int ret;=0A=
>>=0A=
>> 	cond_resched();=0A=
>> 	if (!fatal_signal_pending(current))=0A=
>> 		return 0;=0A=
>>=0A=
>> 	if (bio_flagged(bio, BIO_CHAIN))=0A=
>> 		bio_chain_end_wait(bio);=0A=
> =0A=
> I don't know about block layer, but I feel this is bad because bio_put()=
=0A=
> will be called without submit_bio_wait() when bio_flagged() =3D=3D false.=
=0A=
> Who calls submit_bio_wait() if bio_flagged() =3D=3D false ?=0A=
=0A=
If the BIO is not flagged, then it is not chained and so does not need=0A=
to be executed at all and can be dropped (freed) right away with=0A=
bio_put(). No need (and in fact we do not want) to execute it at all.=0A=
=0A=
For other cases where bio is flagged, it means that it is chained and so=0A=
that previous BIOs where already started by the submit_bio() call in=0A=
bio_next(). In this case, the current BIO is still *not* executed at all=0A=
and bio_endio() is called for it instead of submit_bio_wait(). But since=0A=
bio_endio() is called after setting:=0A=
=0A=
bio->bi_end_io =3D submit_bio_wait_endio;=0A=
=0A=
the bio_endio() call has the same effect as the completion of the bio if=0A=
it were executed: the previous chained BIO completion is waited for.=0A=
=0A=
> =0A=
>> 	bio_put(bio);=0A=
>>=0A=
>> 	return -EINTR;=0A=
>> }=0A=
>>=0A=
>> Thoughts ?=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
