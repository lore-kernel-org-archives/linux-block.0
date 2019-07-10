Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C522C73C69
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 04:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF0C20645
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 04:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GgF/GAUU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AtVrM/mT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfGJEOH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 00:14:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48908 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfGJEOH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 00:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562732046; x=1594268046;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8f5hJIi+NbMNGjbDivyw8zzcwxGWmO/OAa/zlfkDGD4=;
  b=GgF/GAUUURAYFtSPnkjxeqSV7HIG2qfIgMaXWYaXtvlgvymx40Jr5ud7
   BxDldhFJjAGjHLVBbTlIOg2Hx+fw2FNaxfr6CNfKPHTqPYGQ81epuLCDr
   XZjanxrf4LVCBbeQ6/uAYMLKAShEFKLCcKZRSr5JFh160vsWLvvvl+X0x
   f3QWX+IbP+QrhQoqaTnYv5u+wfU4xqJx2PG3bTpOB4ZyWD2ETu6PhTnNY
   H19+E1xzo/klNm3Gkd0/1hAP4Rujl3D5AyxoWAlxtaG7v2OHr+3JR1gQL
   riM9b4Su0BWeCmfwtb3bJ2SlhbZlteg3sXGDpKOqh0yU7AMDnCF7+EOT/
   A==;
IronPort-SDR: cR/dUyBg/PrRxMFoPfVmXl7JcWpWNt+BTQjEHcD+J09Kv5z0Oiewvqxxee2eOk2AwRvUHUiREF
 Vg4bwhn9G0qbT9MgEimq8mO/19sicHPbwZ5fWBDSEAtkTZ3EmEguxds4JV8vFhPwDVK08wARuE
 OFQ3SF71UhSEXHngK9UqUBjnXp4q4j4TuglEuHAaHVt1CvDyd3wm2kwoGsX+3D1GT3FFpXb4kz
 OrE8KLuGYCZahQTJVwvp70gOXO2RPKZMX3REqyyYm5frApdo92jIfoy7QhiXrvJZ4EX07vtvFe
 cWA=
X-IronPort-AV: E=Sophos;i="5.63,473,1557158400"; 
   d="scan'208";a="117439495"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 12:14:05 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkp0aN0CYLpDoyso2xWXNtra2BlluOINFTqzd3tv9jk=;
 b=AtVrM/mTnGYIISMRZ/m3pzM7x/ECb1+otWAvK3ENqfNaCvGSxbCgSJZGlBmJI+dFsIW/Tt0ZFSJG5XoTC/7jZ2yzYKWZURK/TzdtLfAGIaoPDOKoAlkrdCNbMwvr8UEaTK7gQGijtoEVxb7T55bk4Wg8DqO8A4ymvflPtO1a4HM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5992.namprd04.prod.outlook.com (20.178.233.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Wed, 10 Jul 2019 04:14:03 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 04:14:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH] block: Disable write plugging for zoned block devices
Thread-Topic: [PATCH] block: Disable write plugging for zoned block devices
Thread-Index: AQHVNjUIGjEvOj9COU2i4snLn/f5ow==
Date:   Wed, 10 Jul 2019 04:14:03 +0000
Message-ID: <BYAPR04MB5816B72F0352C4D8788217C4E7F00@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190709090219.8784-1-damien.lemoal@wdc.com>
 <20190709142915.GA30082@ming.t460p>
 <BYAPR04MB58162A2087D53F27BAF8176BE7F10@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190710031003.GB2621@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b91206fa-2fa6-44ad-2f8e-08d704ed0b1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5992;
x-ms-traffictypediagnostic: BYAPR04MB5992:
x-microsoft-antispam-prvs: <BYAPR04MB5992500F8DE161D1CAA303DCE7F00@BYAPR04MB5992.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(199004)(189003)(25786009)(478600001)(14454004)(7696005)(3846002)(6116002)(5660300002)(99286004)(55016002)(4326008)(2906002)(66066001)(26005)(14444005)(256004)(6436002)(102836004)(6246003)(33656002)(76116006)(91956017)(186003)(8936002)(66946007)(6916009)(66556008)(64756008)(66446008)(76176011)(66476007)(6506007)(53546011)(229853002)(52536014)(8676002)(316002)(74316002)(71190400001)(71200400001)(68736007)(86362001)(81166006)(81156014)(9686003)(446003)(476003)(486006)(7736002)(54906003)(53936002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5992;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FzKmm9+gFHqq30vDKooqqBgqMzbXDQTO3+YlYsqDgF8cnqfbq8Ioo09Tc7wW5RrDcTZlhFVMydT8FPFEc8VD90/L4YSrOp5vvXokgji7wVbMGa4oKdOzr1jxOihgzMx81Yq2lzleT8eHNseuHL3Cylbw9b/s0UJPiUEJMVW4VPhLLUNkJoR601zWa/XaQjSm/7BD/uxU0lsRfo6xvkdsE7+JQXcZFf7W5a6IjKvgSr5m0BQE9cwT6jROtTkJi6+I/rWo9bPOTx9CakS5Xs7eVxgu9PwbF553KnAcZg9bumN72RJKN1txyb9h6Ru00dTUjWqDEIj5d+271UIuZO+Y2g+6zW33wVEngsh/SbVvlMtoyAB8FqKX4yhYHEt601BzMx8Rz7ROMNxvOlchTodKxXUzW/6EXRlaZTNjLLNGaBw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91206fa-2fa6-44ad-2f8e-08d704ed0b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 04:14:03.5247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5992
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/19 12:10 PM, Ming Lei wrote:=0A=
> On Tue, Jul 09, 2019 at 02:47:12PM +0000, Damien Le Moal wrote:=0A=
>> Hi Ming,=0A=
>>=0A=
>> On 2019/07/09 23:29, Ming Lei wrote:=0A=
>>> On Tue, Jul 09, 2019 at 06:02:19PM +0900, Damien Le Moal wrote:=0A=
>>>> Simultaneously writing to a sequential zone of a zoned block device=0A=
>>>> from multiple contexts requires mutual exclusion for BIO issuing to=0A=
>>>> ensure that writes happen sequentially. However, even for a well=0A=
>>>> behaved user correctly implementing such synchronization, BIO plugging=
=0A=
>>>> may interfere and result in BIOs from the different contextx to be=0A=
>>>> reordered if plugging is done outside of the mutual exclusion section,=
=0A=
>>>> e.g. the plug was started by a function higher in the call chain than=
=0A=
>>>> the function issuing BIOs.=0A=
>>>>=0A=
>>>>       Context A                           Context B=0A=
>>>>=0A=
>>>>    | blk_start_plug()=0A=
>>>>    | ...=0A=
>>>>    | seq_write_zone()=0A=
>>>>      | mutex_lock(zone)=0A=
>>>>      | submit_bio(bio-0)=0A=
>>>>      | submit_bio(bio-1)=0A=
>>>>      | mutex_unlock(zone)=0A=
>>>>      | return=0A=
>>>>    | ------------------------------> | seq_write_zone()=0A=
>>>>   				       | mutex_lock(zone)=0A=
>>>> 				       | submit_bio(bio-2)=0A=
>>>> 				       | mutex_unlock(zone)=0A=
>>>>    | <------------------------------ |=0A=
>>>>    | blk_finish_plug()=0A=
>>>>=0A=
>>>> In the above example, despite the mutex synchronization resulting in t=
he=0A=
>>>> correct BIO issuing order 0, 1, 2, context A BIOs 0 and 1 end up being=
=0A=
>>>> issued after BIO 2 when the plug is released with blk_finish_plug().=
=0A=
>>>=0A=
>>> I am wondering how you guarantee that context B is always run after=0A=
>>> context A.=0A=
>>=0A=
>> My example was a little too oversimplified. Think of a file system alloc=
ating=0A=
>> blocks sequentially and issuing page I/Os for the allocated blocks seque=
ntially.=0A=
>> The typical sequence is:=0A=
>>=0A=
>> mutex_lock(zone)=0A=
>> alloc_block_extent(zone)=0A=
>> for all blocks in the extent=0A=
>> 	submit_bio()=0A=
>> mutex_unlock(zone)=0A=
>>=0A=
>> This way, it does not matter which context gets the lock first, all writ=
e BIOs=0A=
>> for the zone remain sequential. The problem with plugs as explained abov=
e is=0A=
> =0A=
> But wrt. the example in the commit log, it does matter which context gets=
 the lock=0A=
> first, and it implies that context A has to run seq_write_zone() first,=
=0A=
> because you mentioned bio-2 has to be issued after bio-0 and bio-1.=0A=
> =0A=
> If there is 3rd context which is holding the lock, then either context A =
or=0A=
> context B can win in getting the lock first. So looks the zone lock itsel=
f=0A=
> isn't enough for maintaining the IO order. But that may not be related=0A=
> with this patch.=0A=
=0A=
For a raw block device driver, the zone lock is enough to maintain=0A=
sequential write sequence. This is not visible in my example, because it=0A=
is too simplistic. My apologies for the confusion.=0A=
=0A=
The reason is that the target sector of any zone write BIO must always=0A=
be set to the end sector of the last issued write BIO for the zone. A=0A=
more detailed and correct typical sequence for writing to a zone for a=0A=
raw block device driver (e.g. a dm target) is:=0A=
=0A=
seq_write_zone() {=0A=
=0A=
	mutex_lock(zone)=0A=
=0A=
	/* bio-0 */=0A=
	bio =3D bio_alloc()=0A=
	bio->bi_iter.bi_sector =3D zone->wp=0A=
	zone->wp +=3D bio_sectors(bio)=0A=
	submit_bio(bio)=0A=
=0A=
	/* bio-1 */=0A=
	bio =3D bio_alloc()=0A=
	bio->bi_iter.bi_sector =3D zone->wp=0A=
	zone->wp +=3D bio_sectors(bio)=0A=
	submit_bio(bio)=0A=
=0A=
	...=0A=
=0A=
	mutex_unlock(zone)=0A=
}=0A=
=0A=
Doing so, multiple contexts serialized with the zone mutex can keep=0A=
writing sequentially, no matter the number of BIOs they issue and no=0A=
matter the order in which they grab the zone lock. Note that here, the=0A=
zone write pointer is a "soft" write pointer, not the actual device=0A=
managed write pointer, because this latter WP is updated only on=0A=
completion of the write commands, so visible to the host only on=0A=
completion of the write BIOs. The "soft" write pointer is thus always=0A=
equal to or in advance of the device hard WP. The soft WP must be=0A=
re-synced to the hard WP in case of failed writes.=0A=
=0A=
For a file system, the zone hard WP is used as a starting point for=0A=
block allocation. BIO issuing can then simply use the allocated extent=0A=
sector directly instead of the zone soft write pointer. The block=0A=
allocation code will manage the zone soft WP and do the resync with the=0A=
device hard WP in case of write error.=0A=
=0A=
> Also seems there is issue with REQ_NOWAIT for zone support, for example,=
=0A=
> context A may see out-of-request and return earlier, however context B=0A=
> may get request and move on.=0A=
=0A=
Yes, but context B will move on from the last successfully written=0A=
sector so sequential writes can still go on. It is the responsibility of=0A=
the user code to deal with failed writes and how to recover from them.=0A=
=0A=
If REQ_NOWAIT is used for a BIO and causes submit_bio() to fail (=0A=
BLK_QC_T_NONE returned) in one context, that context may retry until it=0A=
succeeds and increment the soft WP or bail out without incrementing the=0A=
zone soft WP. In both cases, other contexts may simply resume trying to=0A=
write from the still valid soft WP. Any number of methods exist for=0A=
dealing with this. All the responsibility of the user (fs or dm) because=0A=
sequential write issuing must in the first place be guaranteed by the=0A=
users. In this regard, the generic block layer is fine.=0A=
=0A=
>> that if the plug start/finish is not within the zone lock, reordering ca=
n happen=0A=
>> for the 2 sequences of BIOs issued by the 2 contexts.=0A=
>>=0A=
>> We hit this problem with btrfs writepages (page writeback) where pluggin=
g is=0A=
>> done before the above sequence execution, in the caller function of the =
page=0A=
>> writeback processing, resulting in unaligned write errors.=0A=
>>=0A=
>>>> To fix this problem, introduce the internal helper function=0A=
>>>> blk_mq_plug() to access the current context plug, return the current=
=0A=
>>>> plug only if the target device is not a zoned block device or if the=
=0A=
>>>> BIO to be plugged not a write operation. Otherwise, ignore the plug an=
d=0A=
>>>> return NULL, resulting is all writes to zoned block device to never be=
=0A=
>>>> plugged.=0A=
>>>=0A=
>>> Another candidate approach is to run the following code before=0A=
>>> releasing 'zone' lock:=0A=
>>>=0A=
>>> 	if (current->plug)=0A=
>>> 		blk_finish_plug(context->plug)=0A=
>>>=0A=
>>> Then we can fix zone specific issue in zone code only, and avoid generi=
c=0A=
>>> blk-core change for zone issue.=0A=
>>=0A=
>> Yes indeed, that would work too. But this patch is precisely to avoid ha=
ving to=0A=
>> add such code and simplify implementing support for zoned block device i=
n=0A=
>> existing code. Furthermore, plugging for writes to sequential zones has =
no real=0A=
>> value because mq-deadline will dispatch at most one write per zone. So w=
rites=0A=
>> for a single zone tend to accumulate in the scheduler queue, and that cr=
eates=0A=
>> plenty of opportunities for merging small sequential writes (e.g. file s=
ystem=0A=
>> page BIOs).=0A=
>>=0A=
>> If you think this patch is really not appropriate, we can still address =
the=0A=
>> problem case by case in the support we add for zoned devices. But again,=
 a=0A=
>> generic solution makes things simpler I think.=0A=
> =0A=
> OK, then I am fine with this simple generic approach.=0A=
=0A=
Thanks.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
