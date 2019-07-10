Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585C4C73C66
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 03:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F34D20844
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 03:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nATyX+Rr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aS/XKyxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfGJDAB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 23:00:01 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:42287 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJDAB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 23:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562727602; x=1594263602;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=l6sYrjhycLZ+kj1fSjQirqs/sn8rSgPCQJEZySgKj04=;
  b=nATyX+RrxkY4yOlUBgVZeUL0yIX6+k9Nl4krk4YvmonuP4c9usq5R75T
   rfuwZr8ChB9GgT6J29xoQIHvUduG3YJ/jykL15PxbcDCowDx5JNd3Dib4
   jhm6/pdGx8U4XRVRcCVQgRfOIbnmL5yC4dSDwe4EU9GUoSD2aMVTnh6Yr
   T7NfSKJADXd+MxTpIfl2vI3dF+An8V2n5rJ3MKpPZhZFORa/pysrD9rbq
   sOZMykLpWg7BwR6bbnCsFn/f5YtGAhcBqLG7o2HlZJjylBLGs4tg5B9H7
   EXzeposyRL36nacoLBP2O90MjDiLZv/2SrdYBIpIpDMgFA83q7mxSvMkM
   Q==;
IronPort-SDR: V3QGKs/vNgNt6+d4+DpeBsIkbF9KnjwMkpqv95Uzdo2qmTFi52vdp5M6RGhTsi7ZSkIwkeehn/
 MDQQPeYkrbjDyaYkvW1ZQx99t1+v6kiW2XF2jYnhq/k3i+ZC9cDMWwbQIWxquVs3SgUPcobtUG
 UJcJLC4dxDRy0CMtgW7aqsQng4jC7WuMAuKXJrAxvUl2pMHICvvBgN1bod4SiHI9bwLMCKPvtJ
 kmyP1H1I5/krTNjbXK6VOu5iKulCRQGNGeVbHEHkfw2An2YAwiJqQqy2PdoLPro61tDKsDkemP
 OaE=
X-IronPort-AV: E=Sophos;i="5.63,473,1557158400"; 
   d="scan'208";a="117435517"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 11:00:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSTFo0ENleR3iraOEm45Szh+6QfQVW0j6+bIczCSSalii7X9KnzCKbXeNox2bGSrfWwMH03uE8xdZNXyn6KilAXNkFLUeJWNIWCWNWPcvdUp2HTxDU3r7ZxiKXPUGmQjgovuJVKPEXb32L7DzjusTzPa1CTh4KNvEoGwNYyEBKJOYQtRkZ3q+syrm2/rM6+sszAgz80RUj7hMyftqWoWrNsnuiZ6jarYpnRmVCoCeN2Mgo1rXSV4hbtnl1nC59CA3PL0lsHVc1moOdy7okHN8Xj85AHBxZucU8WcdBOAkCNVU5K50+YiY34K80qdaYX5/oGOTtKnTSmy+kt7l+wPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jUerhBXYbK5ybLwVSQmPtMMFM8MJZnPAUsJq4dvGbA=;
 b=G/GZNyH27H0S6U5d4hCUhfwHeM5mXXnW0C4sfulh0wSwVlelAG5yAHbE80wvNdfi66rEJkxKOGwcIqrsCNBgyLM23toYrrOekWzL9UhrStvBdhc2elE3PfJd2IaSXlPlaSODSbjmpAed/2SBtdR4YWsap5rD6UjPHFpg0FZJTIRd45ZhC54UnHgWkHZJPHMMZT06lRvIdcPFllVsaPgEf+efSVTErdm4pMT170aK09qDSey/AI2Yfp+E1m2IBfpdeBqiRFHzVMEU3QAusHWUAbNUOos6yGJLPAMdFTL09Ulk6RRJQctUuG9VcWjATz0V9VmFo21nC9NxzgNKdmFdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jUerhBXYbK5ybLwVSQmPtMMFM8MJZnPAUsJq4dvGbA=;
 b=aS/XKyxGWi7d88JI0zBCvRiU64widyxbuzWJxl8ovmuHu+AsJkn8f6lfJHXN1RMHecb0W2PjJo0l+VbfVCKzQFXoalHhI0CFqTXk3ED5NX+vXP9/EAl25c32p65xr4dbRqhrkZod5+5uAbxn4mmzvKmCyROEusiF7efu0hhxMiY=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 02:59:58 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 02:59:58 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH] block: Disable write plugging for zoned block devices
Thread-Topic: [PATCH] block: Disable write plugging for zoned block devices
Thread-Index: AQHVNjUIGjEvOj9COU2i4snLn/f5ow==
Date:   Wed, 10 Jul 2019 02:59:58 +0000
Message-ID: <BYAPR04MB5816B43AEAACBCBCEE27588AE7F00@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190709090219.8784-1-damien.lemoal@wdc.com>
 <20190709142915.GA30082@ming.t460p>
 <341defc6-128e-3b18-9468-951d311e0993@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 238110e7-1e4f-4c3d-64eb-08d704e2b1d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5749;
x-ms-traffictypediagnostic: BYAPR04MB5749:
x-microsoft-antispam-prvs: <BYAPR04MB57491128AF530C23BDEF853BE7F00@BYAPR04MB5749.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(199004)(189003)(2906002)(478600001)(26005)(74316002)(229853002)(446003)(8936002)(33656002)(316002)(256004)(14444005)(6246003)(81156014)(99286004)(7736002)(76176011)(305945005)(6116002)(54906003)(486006)(476003)(81166006)(110136005)(186003)(8676002)(3846002)(4326008)(5660300002)(66066001)(14454004)(76116006)(66446008)(7696005)(64756008)(66946007)(66476007)(66556008)(91956017)(68736007)(25786009)(102836004)(9686003)(55016002)(86362001)(71200400001)(71190400001)(6506007)(6436002)(53546011)(53936002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5749;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BBXPue2LGFtudyn48dcvAztxaHa+4YFznEHMWha81bbJ0Vr6J8Zu1BrWuhW9YHd7y7J0qA+Ef5T1eZITgM3E6Lc5SDZYojgwjiZvfWeJr3K9cH2OYuwSjWTHvB2nKJHThEZ8DxP69T15khjc9S33NJIyIEJR3RSDCyErGJEdPAWPYE3l0Hluo6ykDqikYHxqZaZolxiSAwdKmcTodP8bnSMEgYJMf1w4U34oksi2wBCdAI6nfVpjB66KqgbdDcxm7hzgajgx9OytqteZC7Xly+r5nPq4OhbD/z+M457ucRK1yEat8CO3pNpEOAd/EYH5a3H2atBMrjaCcQcDyeRqYVAJA0yg1yvc2Ntofh/PXf5taOK/KH2n/3kksGnSqeBwBVEoFFHeskF5MsiarmIOR1kEKRKh8sxZAQy5YJWkLgY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238110e7-1e4f-4c3d-64eb-08d704e2b1d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 02:59:58.7575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5749
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/19 11:55 AM, Jens Axboe wrote:=0A=
> On 7/9/19 8:29 AM, Ming Lei wrote:=0A=
>> On Tue, Jul 09, 2019 at 06:02:19PM +0900, Damien Le Moal wrote:=0A=
>>> Simultaneously writing to a sequential zone of a zoned block device=0A=
>>> from multiple contexts requires mutual exclusion for BIO issuing to=0A=
>>> ensure that writes happen sequentially. However, even for a well=0A=
>>> behaved user correctly implementing such synchronization, BIO plugging=
=0A=
>>> may interfere and result in BIOs from the different contextx to be=0A=
>>> reordered if plugging is done outside of the mutual exclusion section,=
=0A=
>>> e.g. the plug was started by a function higher in the call chain than=
=0A=
>>> the function issuing BIOs.=0A=
>>>=0A=
>>>        Context A                           Context B=0A=
>>>=0A=
>>>     | blk_start_plug()=0A=
>>>     | ...=0A=
>>>     | seq_write_zone()=0A=
>>>       | mutex_lock(zone)=0A=
>>>       | submit_bio(bio-0)=0A=
>>>       | submit_bio(bio-1)=0A=
>>>       | mutex_unlock(zone)=0A=
>>>       | return=0A=
>>>     | ------------------------------> | seq_write_zone()=0A=
>>>    				       | mutex_lock(zone)=0A=
>>> 				       | submit_bio(bio-2)=0A=
>>> 				       | mutex_unlock(zone)=0A=
>>>     | <------------------------------ |=0A=
>>>     | blk_finish_plug()=0A=
>>>=0A=
>>> In the above example, despite the mutex synchronization resulting in th=
e=0A=
>>> correct BIO issuing order 0, 1, 2, context A BIOs 0 and 1 end up being=
=0A=
>>> issued after BIO 2 when the plug is released with blk_finish_plug().=0A=
>>=0A=
>> I am wondering how you guarantee that context B is always run after=0A=
>> context A.=0A=
>>=0A=
>>>=0A=
>>> To fix this problem, introduce the internal helper function=0A=
>>> blk_mq_plug() to access the current context plug, return the current=0A=
>>> plug only if the target device is not a zoned block device or if the=0A=
>>> BIO to be plugged not a write operation. Otherwise, ignore the plug and=
=0A=
>>> return NULL, resulting is all writes to zoned block device to never be=
=0A=
>>> plugged.=0A=
>>=0A=
>> Another candidate approach is to run the following code before=0A=
>> releasing 'zone' lock:=0A=
>>=0A=
>> 	if (current->plug)=0A=
>> 		blk_finish_plug(context->plug)=0A=
>>=0A=
>> Then we can fix zone specific issue in zone code only, and avoid generic=
=0A=
>> blk-core change for zone issue.=0A=
> =0A=
> I prefer that to the existing solution as well.=0A=
=0A=
My apologies, you lost me: do you mean that you prefer Ming's suggestion=0A=
and force FS or dm users to manually unplug in the case of zoned block=0A=
devices ?=0A=
=0A=
Thanks.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
