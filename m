Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4624C73C50
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 14:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665BC21537
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 14:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IgJ04ZaS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kfbLzqOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfGIOra (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:47:30 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59665 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIOra (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 10:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562683689; x=1594219689;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=881fdYuXJzMxFyx3zRhTsMRMfRwPvjA48AOYbQleQ0g=;
  b=IgJ04ZaSr8oDXL1H9ejWAtnYJ/nHJ6rZGHIjnOtKdVy8YzGNkEoJZLaB
   Ydx962QYKl1uW0TQvWxTYnmjFL9k5Mqurw+ut8bRrI+tW6vHqpgN49ENO
   EexjtVm8N16G6TW0s30pgTx1DIzpgPqXOoMDuBkZ/130aMUeaWOWNL293
   gH6hfwZXuWPeitCAIKeWuTAENYHjeigiAx6+gqAufvnRqAYvDhZMc9Hu3
   2KketJgUWjgq+Ar0MD9HFW3pAKSvCTZbWCLKH+4KFT6YxLu1dTDycfsFL
   YE6R2AimmYrJDPlCW2k9ZUPq9JCbbulMJMihCgDuP42jWREerZTnHxGnN
   g==;
IronPort-SDR: CDhbHO3tb0daY50m/R3fT5Ap/ZeiqcPE7hWadAtJtDMCvY+us6KsUmgDEfuoicoACXeyrjBgDV
 HQOD7eHFmVVDi8Ho3Q1jRlbfGUT0PZ4t80Nrrr4zpF6J4ru1d0F/d9Sam5pN/WYdsWnWt2BzcU
 aut+lkUGDgfG66XsseDkoaS347114hhyNzWpyhHeeGTtHsv7b2b5pAQROP09LsSAMzGP8S5D3r
 8lgldqnEOZtoge1UeGNrqlTxneuVk3+0b7PYoNGB3cY8MprrkLFHW3FWLKhiHquE/cOjEWe9fa
 La8=
X-IronPort-AV: E=Sophos;i="5.63,470,1557158400"; 
   d="scan'208";a="212450765"
Received: from mail-by2nam05lp2058.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.58])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2019 22:47:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtvyiy1sbOuMHadXREx2sNhgvF1tP9J4O5ld+nrpBIA=;
 b=kfbLzqOjr8ir4KFbKdaM1rdkcN6/wXVablcmTD0tpJC0RJMkIy3lr3eRPcu/SLZCtSIl8NZlWuL2LM16d204dolQjxN4knq8LtPxD43SxoXRyvs64NGq96O6a5E4+KVphPRtw7O5uz9S8pkkJsszN7T0fVqYYlYrX7dRIoxzo5k=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB6200.namprd04.prod.outlook.com (20.178.235.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 14:47:13 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.008; Tue, 9 Jul 2019
 14:47:12 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH] block: Disable write plugging for zoned block devices
Thread-Topic: [PATCH] block: Disable write plugging for zoned block devices
Thread-Index: AQHVNjUIGjEvOj9COU2i4snLn/f5ow==
Date:   Tue, 9 Jul 2019 14:47:12 +0000
Message-ID: <BYAPR04MB58162A2087D53F27BAF8176BE7F10@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190709090219.8784-1-damien.lemoal@wdc.com>
 <20190709142915.GA30082@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e7884cd-dfd7-4d56-8b4d-08d7047c541b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6200;
x-ms-traffictypediagnostic: BYAPR04MB6200:
x-microsoft-antispam-prvs: <BYAPR04MB6200631B1D99481BC0DD365EE7F10@BYAPR04MB6200.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(66476007)(5660300002)(52536014)(66446008)(64756008)(91956017)(66946007)(73956011)(76116006)(66066001)(66556008)(71200400001)(71190400001)(6246003)(316002)(53936002)(2906002)(9686003)(55016002)(229853002)(8936002)(81166006)(81156014)(8676002)(6436002)(86362001)(102836004)(6916009)(4326008)(478600001)(68736007)(446003)(6506007)(53546011)(76176011)(14454004)(33656002)(25786009)(186003)(26005)(305945005)(74316002)(7736002)(54906003)(7696005)(72206003)(256004)(14444005)(486006)(476003)(3846002)(6116002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6200;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tOUAQfFdOqdKtZDro7pWO3B6t3NqnbMdMKHH51BfMO5eUCT/DI9E6ydHsp0niRoKilZSsLdxKoMophkXScvN9V72WKyBeStTzNd3/OEdNMtPVHjKNgd/O3mf2qmkOf931xy1LdwsTF4KUywfqDDtPFa42vB0EsoHmQ8hcuMIj7ngJ4xwYwYkEj+W8vEsAHx+HuPXUIo/2LVHfgJdgvzqF4b85rdKyapa6Y7fPh8kJ6emqfgncOmvXlWG96azCbzUrmNlYBqHVW8SI8V6wube5ZixOb9A0uGIXTeTTtpBkF/VE2QhwgAJffgGAMPDW9XnDdhTUEQQqvdOgOTHBxEuBaBPHXcw14ld/HbFRR+C2UxWoNaramXHB6804FFL+H6KyySMhkx3LiHHN4EXqz2DTq4PtK/FsmJOJgeJUIrOuy4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7884cd-dfd7-4d56-8b4d-08d7047c541b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 14:47:12.8812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6200
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,=0A=
=0A=
On 2019/07/09 23:29, Ming Lei wrote:=0A=
> On Tue, Jul 09, 2019 at 06:02:19PM +0900, Damien Le Moal wrote:=0A=
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
>>       Context A                           Context B=0A=
>>=0A=
>>    | blk_start_plug()=0A=
>>    | ...=0A=
>>    | seq_write_zone()=0A=
>>      | mutex_lock(zone)=0A=
>>      | submit_bio(bio-0)=0A=
>>      | submit_bio(bio-1)=0A=
>>      | mutex_unlock(zone)=0A=
>>      | return=0A=
>>    | ------------------------------> | seq_write_zone()=0A=
>>   				       | mutex_lock(zone)=0A=
>> 				       | submit_bio(bio-2)=0A=
>> 				       | mutex_unlock(zone)=0A=
>>    | <------------------------------ |=0A=
>>    | blk_finish_plug()=0A=
>>=0A=
>> In the above example, despite the mutex synchronization resulting in the=
=0A=
>> correct BIO issuing order 0, 1, 2, context A BIOs 0 and 1 end up being=
=0A=
>> issued after BIO 2 when the plug is released with blk_finish_plug().=0A=
> =0A=
> I am wondering how you guarantee that context B is always run after=0A=
> context A.=0A=
=0A=
My example was a little too oversimplified. Think of a file system allocati=
ng=0A=
blocks sequentially and issuing page I/Os for the allocated blocks sequenti=
ally.=0A=
The typical sequence is:=0A=
=0A=
mutex_lock(zone)=0A=
alloc_block_extent(zone)=0A=
for all blocks in the extent=0A=
	submit_bio()=0A=
mutex_unlock(zone)=0A=
=0A=
This way, it does not matter which context gets the lock first, all write B=
IOs=0A=
for the zone remain sequential. The problem with plugs as explained above i=
s=0A=
that if the plug start/finish is not within the zone lock, reordering can h=
appen=0A=
for the 2 sequences of BIOs issued by the 2 contexts.=0A=
=0A=
We hit this problem with btrfs writepages (page writeback) where plugging i=
s=0A=
done before the above sequence execution, in the caller function of the pag=
e=0A=
writeback processing, resulting in unaligned write errors.=0A=
=0A=
>> To fix this problem, introduce the internal helper function=0A=
>> blk_mq_plug() to access the current context plug, return the current=0A=
>> plug only if the target device is not a zoned block device or if the=0A=
>> BIO to be plugged not a write operation. Otherwise, ignore the plug and=
=0A=
>> return NULL, resulting is all writes to zoned block device to never be=
=0A=
>> plugged.=0A=
> =0A=
> Another candidate approach is to run the following code before=0A=
> releasing 'zone' lock:=0A=
> =0A=
> 	if (current->plug)=0A=
> 		blk_finish_plug(context->plug)=0A=
> =0A=
> Then we can fix zone specific issue in zone code only, and avoid generic=
=0A=
> blk-core change for zone issue.=0A=
=0A=
Yes indeed, that would work too. But this patch is precisely to avoid havin=
g to=0A=
add such code and simplify implementing support for zoned block device in=
=0A=
existing code. Furthermore, plugging for writes to sequential zones has no =
real=0A=
value because mq-deadline will dispatch at most one write per zone. So writ=
es=0A=
for a single zone tend to accumulate in the scheduler queue, and that creat=
es=0A=
plenty of opportunities for merging small sequential writes (e.g. file syst=
em=0A=
page BIOs).=0A=
=0A=
If you think this patch is really not appropriate, we can still address the=
=0A=
problem case by case in the support we add for zoned devices. But again, a=
=0A=
generic solution makes things simpler I think.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
