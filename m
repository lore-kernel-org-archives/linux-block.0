Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65629C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 07:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A76521D7F
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 07:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qMlBsIHe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dgD5+0Ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfKMHLk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:11:40 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36770 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKMHLk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 02:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573629126; x=1605165126;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=61GFulrAvt3huHkt+30Y9pP8lA3LLOy/Ceh3SJsSdcc=;
  b=qMlBsIHefnSNqm9d9Eux7uj98Le242FnMfbe22fVfmwCdRi8h4d+bXmu
   81Xwt9Sm61ctTcStV76cy3s9akgEKP/L0JCH5FpHlMi9pW7sBi76tbzDR
   WZ1cXFUF06BIxc1NVjPSFwgRlK62VDdxBZzNkTE+JCA1AWYN5iU3qEugI
   AZChBs2WJ/BlOdjztzp5A9dE98RIWu6/0OjaxMDAowOmGtEOQfZrwq+b+
   eDGzHcigFPzGMoyZv4YPOkv7v7bsOXz5N5fZIvuN5/kEu2Q3c8HemZIEE
   MWCsX3fUpqWCZPxdrD6llbpPXUUVq5FGfqik9mRSmM2hI4aGRXcuyMzDR
   w==;
IronPort-SDR: gRGbNDcwj8r4rL3+4YA1TzMFSkvP5fJMO7p6tjmEQXok8Ps6J3lPw8JOKhkp1jdB1VDITCk9e2
 0ZKY53D4xSwL2x71TA92GbZdiBL7ty2ZIy2wMJ+drucimmHTbgqO8HhRYKClAlPXLz+pMSPs9Z
 l3fOfEGQ67/AeTTudPjP55sM20KK7ALNsGANbORssKD0p6zb/i4ldEfx5K7RLKdJ4Huk2U2NBs
 hIO5KPTp+XPwv+OOoquLkBDI7aPaKnqoZ1rAgCRNFwnqaf99O7QSsEcXjS7e6uXEY1Gi+MgGSG
 n08=
X-IronPort-AV: E=Sophos;i="5.68,299,1569254400"; 
   d="scan'208";a="224137228"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2019 15:12:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkhJ1HpkJ+PYjHL/cSeBW9td99jhF6h/+D0thpRMScLJASKFaXcmRkzZ0rb+mrygQRpfmvL0ZI0hviNvGaidqMb0AHKdsLuA5cpBXXYWJ75bWMRVWupUuz1wBgBceaYjCawfonc8XdBFIuLYwu6goBC5U+VR/iEol2+VG2cnFgxQXcly9FSF4VoWYQnFdOaEH0W/gWBIA2HqTsrDqztuM29RzGBK+40njKiXzdQhDQBsQqAsyQCgcSFsrKLq9GpD4RWlEfcL4VQaorJuqssyTiBLumOvb95YBSvxo40LZ4OwDGUs7msnNajiKqm4aUoXuxlE18Fy0XPhFRqU0uno5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmx6lVQNBX9IqsDNScLjhIZdVb0OoNEItMT847djDBE=;
 b=ftyqGRo37OUv8BLhH0b6tVzMu0OuPkZBbIRqxxixAdutLBqaKIz6GqScbnHLd99GXUrn3ZoTXRoLuwpQcWMYk1CFkhj74U8KhWKlGk++XIi3Blmr97ihmQHf63je/mDq3QEpy1ZSblKz6QZwPRSv07RDaze1Uh2+a95wOQ2N/3i7oulWgkDceMOT89nNQR1ibjD2Pt7o6IDwSMkIAFlTEqMHgDhwYy/d8mytI6KjcKVPL+cfHprpTZBaGRKsZ9h6Y/JVv+dwVeZgUzGTGtbgkqV25K8SAP3f0oF+f3EIyIcWMXLyL4uCQ6ImjAZIqWOa3WSqInhcQtSi1Pbgbq/92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmx6lVQNBX9IqsDNScLjhIZdVb0OoNEItMT847djDBE=;
 b=dgD5+0AoS061YR99+HYpHpJ1RT61ZfWzGGRUfRfCduIhQHEbE7NqhBygzAd6yXCLO1thvk2byKOQx3tCO3by/1ZmsUKMP253wv1gydqMYHfpnHkQPt1RXoL7CvRxo8+uxheyUu26d1QNQk8A1IM4vIWiWa5cUUssJJxzi7oob8E=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB3944.namprd04.prod.outlook.com (52.135.215.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Wed, 13 Nov 2019 07:11:36 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 07:11:36 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bob Liu <bob.liu@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Bail out iteration functions upon SIGKILL.
Thread-Topic: [PATCH] block: Bail out iteration functions upon SIGKILL.
Thread-Index: AQHVlis75ysrnBQ8Tkec+aEy36lA2g==
Date:   Wed, 13 Nov 2019 07:11:36 +0000
Message-ID: <BYAPR04MB581697D2911048D329DFF5B2E7760@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <000000000000c52dbf05958f3f3a@google.com>
 <3fbc4bb2-a03b-fbfa-4803-47a6d0075ff2@I-love.SAKURA.ne.jp>
 <24296ff7-4a5f-2bd9-63c7-07831f7b4d8d@oracle.com>
 <8fde32da-d5e5-11b7-9ed7-e3aa5b003647@i-love.sakura.ne.jp>
 <BYAPR04MB58165EC2C792CE26AAAF361FE7770@BYAPR04MB5816.namprd04.prod.outlook.com>
 <272e3542-72ab-12ff-636b-722a68a2589c@i-love.sakura.ne.jp>
 <BYAPR04MB5816D18E6F6633030265B06EE7760@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20191113065523.GA1985@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 72b19cfc-7de2-4098-f2df-08d76808b8cd
x-ms-traffictypediagnostic: BYAPR04MB3944:
x-microsoft-antispam-prvs: <BYAPR04MB3944624049C72CB9E0322583E7760@BYAPR04MB3944.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(478600001)(8936002)(55016002)(6246003)(25786009)(6436002)(33656002)(229853002)(7696005)(71190400001)(6116002)(54906003)(81156014)(486006)(66066001)(316002)(446003)(9686003)(6916009)(8676002)(4326008)(26005)(3846002)(81166006)(476003)(99286004)(71200400001)(186003)(2906002)(86362001)(5660300002)(66946007)(102836004)(64756008)(76176011)(256004)(66556008)(66446008)(91956017)(7736002)(6506007)(53546011)(14444005)(52536014)(305945005)(14454004)(74316002)(66476007)(76116006)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3944;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TjBf9qTodleypvPOv2+crxDTUq9keL3RH7edJ4iywdCdSa8MWJnji+rMBT6kP1lFTOxJjOdrUCFcEgpOpK+05RlDsdmgwg5TrzEfFad8E+qLN26niMyBei+ZF7jBNQxWK0jvTBkS+NKRP1t9tDj4FNiDmUT5iGmPemddK/EsJxXZreuTUDW5dlUWGCYIT8OzqGhbAMJH3R1RHJXYMECUhFy7Qi3FnelA2g50oPJiDp4veDWvAi7dhxzk1VxZbFwNflctRoYmvPwGmf+K0mGRGhKYubE2SfLxzuWyXnX/ZG23/2HKy+uDuWej9xR+3lu/u3pTKwnRjFtnxLDxUpNXYvhMTcs6gYji9uEXwqMPivsRE4cHxulI+ADfNdrINdm0sR4LTN8IVCKOYc8GrDmoLQamfkcsErC0fdoKI7RllP9pA+1ltQdwMAkXCjn8NI8H
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b19cfc-7de2-4098-f2df-08d76808b8cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 07:11:36.4776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /l9EJ1ib+oofx/hAD8mYnU3lVzK9YuhxVfC2Ll01hk/aq52hB9fydWSt8B/PLPpitBbRnnXL+9Et7hlBHFY5Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3944
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/13 15:55, Ming Lei wrote:=0A=
> On Wed, Nov 13, 2019 at 01:54:14AM +0000, Damien Le Moal wrote:=0A=
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
>> 	bio_put(bio);=0A=
>>=0A=
>> 	return -EINTR;=0A=
>> }=0A=
>>=0A=
>> Thoughts ?=0A=
> =0A=
> DISCARD request can be quite big, and any sync bio submission may cause=
=0A=
> serious performance regression.=0A=
=0A=
Yes indeed. But if the bio issuing loop is interrupted with discard BIOs=0A=
already issued, I do not think there is any other choice but to wait for=0A=
their completion before returning.=0A=
=0A=
> Not mention blkdev_issue_discard() may be called in non-block context.=0A=
=0A=
This loop is calling cond_resched(), which checks might_sleep(). So=0A=
certainly this function can block, no ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
