Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901E4C73C46
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 14:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5326B21537
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 14:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lEkXERxa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JPg/6xvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGIO7G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:59:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:12559 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIO7G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 10:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562684472; x=1594220472;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NAmm2g3gE7B2A97tNlx6WZ7OCKvV9Pa0s+EkjxcQVls=;
  b=lEkXERxaVKeY/ELzSY0YqeYRkxehY+cb+zlPAxqpeqJssLUm96dkHACo
   lwaQzFQ5XWbJoux/lNpe+TraoiClZ7CmAgJyU35PDg5C/l+oj3/nMinBl
   OR2cDx1OiP2+ZxorzdudqEDv94JitGhOkfDaw07N50JORfhk+ge3s0R8g
   FugG9RHfiw9NG5bKt1TiYKbcuioPUwhZkKNY/YZDheOBNM296r0Wa4tHU
   gh8NtpJpn9WMUInDvHxz0fKGr+/xMVqVe7LhdvmLQHDXd0KGe3Eio3wyY
   +GyiMcaWnBVoTAtyVnxzgsvmgSNJXb7KjUaiSInlQZBztwgY+4Mtqc8px
   Q==;
IronPort-SDR: g4c45tA03xX1a400je24tl8QjiMGIZHNpUwMFGKKrEiKP8SCgyIpokwBipAWEsgxjVY8geEwKQ
 IYnOJGfygYd6cMDVrCSr76EsbpQkTwdp1jneWCv2yqOTjbNDajXNwTEJH01mR0LObQISeP5Qxv
 pi16OJM6ha2x4WNsZa3UbjVrURY7fw5x+JdF15q7/KstEasrMRQu30xQOqcRVV07DPHavS36R6
 YGyEuvrhi0AdahfKLFaAPG6O5tjhkH7yIkkFgea+NdDkThyUP2yNhjr0Xbl2CagphQ4yzW/mTD
 Hlo=
X-IronPort-AV: E=Sophos;i="5.63,470,1557158400"; 
   d="scan'208";a="212451699"
Received: from mail-dm3nam03lp2058.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.58])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2019 23:01:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j05MViEiIv13q/8R5HSkgvTiJTH6jA4OkRBLs5Ydcg=;
 b=JPg/6xvADNVI8srGUWOZTkYG3w4zKGMbDThKDaVRdx4YDllWXwYxBWkMqrvTp1zhJCYcDm/KxlbhYEcOymKEU5HHF0ZEfcbAnhgPzsCjtc67PNW7CiAGjDQtt/gDFRmJNns1Vq0b765fQzNRHuaqbnZiE1IqAys6HWfxoFk1ygc=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4279.namprd04.prod.outlook.com (20.176.251.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 14:59:03 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.008; Tue, 9 Jul 2019
 14:59:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH] block: Disable write plugging for zoned block devices
Thread-Topic: [PATCH] block: Disable write plugging for zoned block devices
Thread-Index: AQHVNjUIGjEvOj9COU2i4snLn/f5ow==
Date:   Tue, 9 Jul 2019 14:59:03 +0000
Message-ID: <BYAPR04MB5816C66406E71DF324CC1F11E7F10@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190709090219.8784-1-damien.lemoal@wdc.com>
 <f5beffea-f856-c076-e2bd-0cf5fe2b0383@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e62c0836-dba3-4652-4d94-08d7047dfbc5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4279;
x-ms-traffictypediagnostic: BYAPR04MB4279:
x-microsoft-antispam-prvs: <BYAPR04MB427942026A62FE430C611C59E7F10@BYAPR04MB4279.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(52084003)(6246003)(9686003)(478600001)(72206003)(55016002)(53936002)(6436002)(25786009)(14454004)(2906002)(229853002)(6116002)(3846002)(4326008)(2501003)(316002)(110136005)(54906003)(33656002)(446003)(486006)(76116006)(64756008)(6506007)(53546011)(66476007)(476003)(102836004)(305945005)(7736002)(66446008)(73956011)(66556008)(52536014)(66946007)(74316002)(8936002)(76176011)(91956017)(5660300002)(66066001)(186003)(8676002)(26005)(256004)(14444005)(81166006)(81156014)(7696005)(86362001)(68736007)(71190400001)(71200400001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4279;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cRmvp/rNWIbtgP5tX8IiqQ6mZ/yc/9pubehXYNyZF9Og/Ume//Aj2oBYgGc665CtmgbLJQ726ckKcDznISCAEyaZguR/EdtzzaEkuvh6T4Pqd2gcr2x9SJ2akI/ZWpAZQFI3QHJDUQo/YQQAR7WwCFhUFKso9dqjX7ns5TTtagngR5uJlY7I+AK+kFM3L48AdPPs0uWb5G991kJJxd1MUkHuRt9uHIfXinqCRcqdDeF8WrD6vDNY3UK1q9+0kKDr3Ui0gUu5RuoLXVZyDSzkHT7MUezdL5i25WJxKYKa0vnuvspmjoxMqq7bhrCm5MM4nRYeZKrrhvB1mWauJyJmaHIJgRndKtffH+ERRWUA5SSuVxtJzE8b9wQE8m1KJI4+j0g5A74ZEYbbzXR9g/atP222kjU6JspmMjegLp0y3PE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62c0836-dba3-4652-4d94-08d7047dfbc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 14:59:03.7039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4279
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/07/09 22:51, Bart Van Assche wrote:=0A=
> On 7/9/19 2:02 AM, Damien Le Moal wrote:=0A=
>> Simultaneously writing to a sequential zone of a zoned block device=0A=
>> from multiple contexts requires mutual exclusion for BIO issuing to=0A=
>> ensure that writes happen sequentially. However, even for a well=0A=
>> behaved user correctly implementing such synchronization, BIO plugging=
=0A=
>> may interfere and result in BIOs from the different contextx to be=0A=
>> reordered if plugging is done outside of the mutual exclusion section,=
=0A=
>> e.g. the plug was started by a function higher in the call chain than=0A=
>> the function issuing BIOs.=0A=
>>=0A=
>>        Context A                           Context B=0A=
>>=0A=
>>     | blk_start_plug()=0A=
>>     | ...=0A=
>>     | seq_write_zone()=0A=
>>       | mutex_lock(zone)=0A=
>>       | submit_bio(bio-0)=0A=
>>       | submit_bio(bio-1)=0A=
>>       | mutex_unlock(zone)=0A=
>>       | return=0A=
>>     | ------------------------------> | seq_write_zone()=0A=
>>    				       | mutex_lock(zone)=0A=
>> 				       | submit_bio(bio-2)=0A=
>> 				       | mutex_unlock(zone)=0A=
>>     | <------------------------------ |=0A=
>>     | blk_finish_plug()=0A=
>>=0A=
>> In the above example, despite the mutex synchronization resulting in the=
=0A=
>> correct BIO issuing order 0, 1, 2, context A BIOs 0 and 1 end up being=
=0A=
>> issued after BIO 2 when the plug is released with blk_finish_plug().=0A=
>>=0A=
>> To fix this problem, introduce the internal helper function=0A=
>> blk_mq_plug() to access the current context plug, return the current=0A=
>> plug only if the target device is not a zoned block device or if the=0A=
>> BIO to be plugged not a write operation. Otherwise, ignore the plug and=
=0A=
>> return NULL, resulting is all writes to zoned block device to never be=
=0A=
>> plugged.=0A=
> =0A=
> Are there classes of zoned devices for which the plug list is useful? If =
=0A=
> so, have you considered any other approaches, e.g. one plug list per =0A=
> request queue instead of one plug list per task in case of zoned devices?=
=0A=
=0A=
Plugging for writes to zoned block devices is not really useful at all. The=
=0A=
reason is that for any user of the disk executing requests at a queue depth=
=0A=
larger than 1, to preserve write ordering, mq-deadline must be used. With t=
his=0A=
scheduler, zone write locking will prevent dispatching more than one write=
=0A=
request per zone at any time, resulting in the accumulation of sequential w=
rites=0A=
for a zone in the scheduler queue. This creates plenty of opportunities for=
=0A=
merging small (i.e. single page) write BIOs with preceding pending requests=
,=0A=
which is exactly the intent of plugging in the first place.=0A=
=0A=
A per request queue plug list would work, but it would require a single loc=
k,=0A=
going against blk-mq design principle. Such method would also result in a l=
ot=0A=
more changes for no real gain at all (for the reason explained above).=0A=
Performance-wise, simply disabling per context plugging for writes only has=
 no=0A=
measurable impact and is far simpler I think.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
