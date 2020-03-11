Return-Path: <SRS0=mBf9=44=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1EBC10F25
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 04:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599972146E
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 04:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OTrksYxB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lAvb/0PA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgCKE7b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Mar 2020 00:59:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3118 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgCKE7b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 00:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583902770; x=1615438770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kxTIfNGHi2oH4OnLU65Xdpyw3Y2yGMFKsIvUrIpTCpg=;
  b=OTrksYxB7E8Vt+Z9VW4RgCv4XJAVM0fq1eADVGp+UHPbZiybqjxQh9Fr
   NK10OJqX6KqAp/xfnEuOPh7IuAEYrKQVH0knwgsjjsc9+bfYHxvuKbKYa
   0NtZeZzj3AsZfpawRU6f5gqFtazysgn/4+TbkslJXTsamPy/Gh8FKscwQ
   lOmG/gns04TU7Iief4EeQBgrSwEyvepOXrI8HGea8+uMUtTLVbxBKom8f
   yc8paceT5C9sNGaFh7jilgPB6ROI57m99I+VwriczJ87Mfpnbqx0RejWu
   MWPWJR47OA7xCjbZs+8Nl21UErizULP463X4Fpzy1uAcbMWWaQB1PCcVB
   g==;
IronPort-SDR: qD7XNawmYmirogi0qP/Nz8jgdhKEoPJ0pdVCZgwS8LGlsL0CihAcQeBtqG00hni0Skm2cBE/TC
 vmaolV+VSgv+LjQjEvEn7/pcVIhOVCOLQrm78BbByppM5DaOBIgGAafI7DXT4rEFKEs7ujt2k6
 FljJYiZOy9VY2UzsTFaECiSur/PGB8ZBo0FkpB2xRIfVctP1omsDtFhEgUXIK55hRTBGy/wqyI
 3MuPR6FpqoHGIyyx+7ElJ1rN+PeWUBSuzADsj2Lq/3iKcXgnHVpycpRuX3Ex25OI9uJUk3/GqF
 oZA=
X-IronPort-AV: E=Sophos;i="5.70,539,1574092800"; 
   d="scan'208";a="240399740"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2020 12:59:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeQRpTk2Ox5R10gKBCStpgk409obcjW7mq5r2TBiY6SQJ5dxYMKO09BOztoKaacUW+kHp4fPBtZ9VcKtWxC9Icr4Wk2miOAUV48sWS+GX/dkAAz05trGotlEAXZugmLW0crUj3mjWFfRkVho8SdJMG5CWGS0R1k8Ovtfl/DdtVqGFys7m01aq8spM15GlPUonXPr0ENAAVOxnsHD2lOSnJ02Bhl7ZMcNMhCoeB7/BKbEAGYVQQEXFAMegeAwT2nSRCXvRenHwb8lx23Lwo6KutayKjUnd5r0AD8ZnFFaaJEmDXllUNOoD5BegpAUqWATa5H8b/sanGWCKrLPo5RKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaC0K4Gpfkqdn33Tb5+7kWoJT7/iFvBRiwp6O7jGJfk=;
 b=YxjBMYGunnVgV9CqVUzzFBsyCqxZDK0l/qNgcsC3hjb0CdB9Ip9QYkQPtUpo692UUdmeynNH5jTRIZL2Kk5s2IW67ErdGM4AEilQ+cg4Oh0osvFyWV18QyI8RvwbwNK7Twkf5uDYg4UsGJyEN7p99J7bPFdjNA9Dfe4vYTtTVWkPEIL6mbwLgXYoUlGZW7WjTO/Eyl93e5HxafxdEonf2b2apfzfDuPn3JWPh0LzIaw9U4w37bysHgeSOZ/QaOVGVjSGcZ7hiRhzbyBICZae6u5N7OOFVGygXk91pEC8u3alLIvM0AJK+e3Xs3pS+Dj5W4UekvS1zmFkxhhxH4zo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaC0K4Gpfkqdn33Tb5+7kWoJT7/iFvBRiwp6O7jGJfk=;
 b=lAvb/0PAETNtfjO4ttehFouUGMBf+QjAReqw13dzdfQW0RigoPpMbi46GpnN1N6uKMvJT1YBuyMwt1SHyRQSXnn1BSUgMlCBNAdMxbACzA1t0x6rTtoV9z1LM4P1kWOEvFShqurAc4t/fHW5BmzPVg8/yscRNd8r3SN8jiaNB2g=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (2a01:111:e400:c61b::7)
 by CY1PR04MB2252.namprd04.prod.outlook.com (2a01:111:e400:c61a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 04:59:24 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2986:c2cb:aa36:a25d]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2986:c2cb:aa36:a25d%8]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 04:59:23 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Thread-Topic: commit 01e99aeca397 causes longer runtime of block/004
Thread-Index: AQHV8c4FlOkNXDceTU6Nwl3i3vnr/KhBXQ+AgAAlSQCAADIagIAAKgIAgAAQ44CAAPC1AA==
Date:   Wed, 11 Mar 2020 04:59:23 +0000
Message-ID: <20200311045922.swskt7kwfkawfhba@shindev.dhcp.fujisawa.hgst.com>
References: <20200307010222.gtrwivafqe2254i6@shindev.dhcp.fujisawa.hgst.com>
 <20200307041343.GB20579@ming.t460p>
 <20200309000715.sqgsssrauzmmpli2@shindev.dhcp.fujisawa.hgst.com>
 <20200309161430.GA4871@ming.t460p>
 <BYAPR04MB5816C428F1E23B1030579887E7FF0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20200310055417.o3jghx4sl5xtztci@shindev.dhcp.fujisawa.hgst.com>
 <20200310080744.GA7618@ming.t460p>
 <20200310110703.hvaek3opc67lcr74@shindev.dhcp.fujisawa.hgst.com>
 <20200310133724.GA25034@ming.t460p> <20200310143751.GA29474@ming.t460p>
In-Reply-To: <20200310143751.GA29474@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d13cafb-dacd-4b93-2cd8-08d7c578f7c2
x-ms-traffictypediagnostic: CY1PR04MB2252:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB22525FC702D07B5AEA8116AAEDFC0@CY1PR04MB2252.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(199004)(26005)(316002)(6486002)(186003)(66446008)(76116006)(91956017)(66946007)(66476007)(30864003)(64756008)(66556008)(2906002)(86362001)(5660300002)(1076003)(54906003)(66574012)(4326008)(966005)(6512007)(8676002)(478600001)(8936002)(6916009)(81166006)(81156014)(9686003)(71200400001)(44832011)(6506007)(53546011)(148743002)(60764002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2252;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gZDTTDSUiau911JQr4v3yfQV82Kcy9BvJskbs+AkhePgzVcpY2Eyxwj1xKJDT4UWVOAzykuoNdhuIheo2EhyCQ+ZguuEpzWawYlfo0ZucsuD2qfT/US8UusuQcuAQbz7ygSQQ+blW4ZzFlDOs9vGn1Osmyj+wNk/Hx05PZwn3wDIMYGPCrREbCtBp16UA0KyFTm4N6nPQr70JUwrlGKt4O54nKSKHBY63ng9VdMsXOQOldNK5kBru5j8ZvpjhgoWUwOcNqEYhb789dbwcMhOF+J/E7MP4H5DBF6V5dfJDdAuyo4cwiEUsz7WfjzJh72lRYovxdRIMxZSpnQ+RIYVWaSWBh9emELxQoZT0ffEAW6pjxm7XSm03hZFxuQg11d0X0mA8Xpss1o6jITd8cUrv6/DbjmhL3LMBpuVWTUO62SYbSg26iU67BqgIdY4//Op0OsxRoxezKaL9i4xl5DUlYsM/4iMs1IrB/zOjt04A6/mdhjFj8SDejrsdW57VrfQxENtef8NL1nGAcqfRBoZwNOBro38tr1bMpWpvO+mAJNuVc06D6dBkakaeeQqf9N+IcxlHu99mcWGxyfvnj4PqEqZCT6V/bxRAEH4RcIZ4j+O3lvjfonqsyBjfVoNKcC
x-ms-exchange-antispam-messagedata: NT6yW+3y9QEBHlRIl4H+i3IlaYOFtlL/9IAWcP46gau5dcdGLRfSxZ35fX4E6Tl0ZdJCBOtagcEWZZMkdbmOlKelNkBkyUohXojIgximylrx2tcN7HTuZV2E6PCF/MwwNspVFl8GvZ4l5oBGeVQJww==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C52901BF87F49B4BBE6AB463658E3DAF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d13cafb-dacd-4b93-2cd8-08d7c578f7c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 04:59:23.8290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyNWOIq5bjTGlTX3Eg63x9FKyVnhHmHTh6fwDbePosnflycdnmx5Z8vDX5FCtTQPsIiDeNatxRTgsqRrcQYBwRed+7Q3xIChKvNXWM3c4oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2252
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 10, 2020 / 22:37, Ming Lei wrote:
> On Tue, Mar 10, 2020 at 09:37:24PM +0800, Ming Lei wrote:
> > On Tue, Mar 10, 2020 at 11:07:04AM +0000, Shinichiro Kawasaki wrote:
> > > On Mar 10, 2020 / 16:07, Ming Lei wrote:
> > > > On Tue, Mar 10, 2020 at 05:54:18AM +0000, Shinichiro Kawasaki wrote=
:
> > > > > Ming, thank you for sharing the log files and analysis.
> > > > >=20
> > > > > On Mar 10, 2020 / 03:07, Damien Le Moal wrote:
> > > > > > On 2020/03/10 1:14, Ming Lei wrote:
> > > > > > > On Mon, Mar 09, 2020 at 12:07:16AM +0000, Shinichiro Kawasaki=
 wrote:
> > > > > > >> On Mar 07, 2020 / 12:13, Ming Lei wrote:
> > > > > > >>> On Sat, Mar 07, 2020 at 01:02:23AM +0000, Shinichiro Kawasa=
ki wrote:
> > > > > > >>>> On Mar 06, 2020 / 16:13, Ming Lei wrote:
> > > > > > >>>>> On Fri, Mar 06, 2020 at 06:06:23AM +0000, Shinichiro Kawa=
saki wrote:
> > > > > > >>>>>> On Mar 05, 2020 / 10:48, Ming Lei wrote:
> > > > > > >>>>>>> Hi Shinichiro,
> > > > > > >>>>>>>
> > > > > > >>>>>>> On Thu, Mar 05, 2020 at 01:19:02AM +0000, Shinichiro Ka=
wasaki wrote:
> > > > > > >>>>>>>> On Mar 04, 2020 / 17:53, Ming Lei wrote:
> > > > > > >>>>>>>>> On Wed, Mar 04, 2020 at 06:11:37AM +0000, Shinichiro =
Kawasaki wrote:
> > > > > > >>>>>>>>>> On Mar 04, 2020 / 11:46, Ming Lei wrote:
> > > > > > >>>>>>>>>>> On Wed, Mar 04, 2020 at 02:38:43AM +0000, Shinichir=
o Kawasaki wrote:
> > > > > > >>>>>>>>>>>> I noticed that blktests block/004 takes longer run=
time with 5.6-rc4 than
> > > > > > >>>>>>>>>>>> 5.6-rc3, and found that the commit 01e99aeca397 ("=
blk-mq: insert passthrough
> > > > > > >>>>>>>>>>>> request into hctx->dispatch directly") triggers it=
.
> > > > > > >>>>>>>>>>>>
> > > > > > >>>>>>>>>>>> The longer runtime was observed with dm-linear dev=
ice which maps SATA SMR HDD
> > > > > > >>>>>>>>>>>> connected via AHCI. It was not observed with dm-li=
near on SAS/SATA SMR HDDs
> > > > > > >>>>>>>>>>>> connected via SAS-HBA. Not observed with dm-linear=
 on non-SMR HDDs either.
> > > > > > >>>>>>>>>>>>
> > > > > > >>>>>>>>>>>> Before the commit, block/004 took around 130 secon=
ds. After the commit, it takes
> > > > > > >>>>>>>>>>>> around 300 seconds. I need to dig in further detai=
ls to understand why the
> > > > > > >>>>>>>>>>>> commit makes the test case longer.
> > > > > > >>>>>>>>>>>>
> > > > > > >>>>>>>>>>>> The test case block/004 does "flush intensive work=
load". Is this longer runtime
> > > > > > >>>>>>>>>>>> expected?
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> The following patch might address this issue:
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> https://lore.kernel.org/linux-block/20200207190416.=
99928-1-sqazi@google.com/#t
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> Please test and provide us the result.
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> thanks,
> > > > > > >>>>>>>>>>> Ming
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> Hi Ming,
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> I applied the patch to 5.6-rc4 but I observed the lo=
nger runtime of block/004.
> > > > > > >>>>>>>>>> Still it takes around 300 seconds.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> Hello Shinichiro,
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> block/004 only sends 1564 sync randwrite, and seems 1=
30s has been slow
> > > > > > >>>>>>>>> enough.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> There are two related effect in that commit for your =
issue:
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> 1) 'at_head' is applied in blk_mq_sched_insert_reques=
t() for flush
> > > > > > >>>>>>>>> request
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> 2) all IO is added back to tail of hctx->dispatch aft=
er .queue_rq()
> > > > > > >>>>>>>>> returns STS_RESOURCE
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> Seems it is more related with 2) given you can't repr=
oduce the issue on=20
> > > > > > >>>>>>>>> SAS.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> So please test the following two patches, and see whi=
ch one makes a
> > > > > > >>>>>>>>> difference for you.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> BTW, both two looks not reasonable, just for narrowin=
g down the issue.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> 1) patch 1
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sche=
d.c
> > > > > > >>>>>>>>> index 856356b1619e..86137c75283c 100644
> > > > > > >>>>>>>>> --- a/block/blk-mq-sched.c
> > > > > > >>>>>>>>> +++ b/block/blk-mq-sched.c
> > > > > > >>>>>>>>> @@ -398,7 +398,7 @@ void blk_mq_sched_insert_request(=
struct request *rq, bool at_head,
> > > > > > >>>>>>>>>  	WARN_ON(e && (rq->tag !=3D -1));
> > > > > > >>>>>>>>> =20
> > > > > > >>>>>>>>>  	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
> > > > > > >>>>>>>>> -		blk_mq_request_bypass_insert(rq, at_head, false);
> > > > > > >>>>>>>>> +		blk_mq_request_bypass_insert(rq, true, false);
> > > > > > >>>>>>>>>  		goto run;
> > > > > > >>>>>>>>>  	}
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> Ming, thank you for the trial patches.
> > > > > > >>>>>>>> This "patch 1" reduced the runtime, as short as rc3.
> > > > > > >>>>>>>>
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> 2) patch 2
> > > > > > >>>>>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > > > >>>>>>>>> index d92088dec6c3..447d5cb39832 100644
> > > > > > >>>>>>>>> --- a/block/blk-mq.c
> > > > > > >>>>>>>>> +++ b/block/blk-mq.c
> > > > > > >>>>>>>>> @@ -1286,7 +1286,7 @@ bool blk_mq_dispatch_rq_list(st=
ruct request_queue *q, struct list_head *list,
> > > > > > >>>>>>>>>  			q->mq_ops->commit_rqs(hctx);
> > > > > > >>>>>>>>> =20
> > > > > > >>>>>>>>>  		spin_lock(&hctx->lock);
> > > > > > >>>>>>>>> -		list_splice_tail_init(list, &hctx->dispatch);
> > > > > > >>>>>>>>> +		list_splice_init(list, &hctx->dispatch);
> > > > > > >>>>>>>>>  		spin_unlock(&hctx->lock);
> > > > > > >>>>>>>>> =20
> > > > > > >>>>>>>>>  		/*
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> This patch 2 didn't reduce the runtime.
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> Wish this report helps.
> > > > > > >>>>>>>
> > > > > > >>>>>>> Your feedback does help, then please test the following=
 patch:
> > > > > > >>>>>>
> > > > > > >>>>>> Hi Ming, thank you for the patch. I applied it on top of=
 rc4 and confirmed
> > > > > > >>>>>> it reduces the runtime as short as rc3. Good.
> > > > > > >>>>>
> > > > > > >>>>> Hi Shinichiro,
> > > > > > >>>>>
> > > > > > >>>>> Thanks for your test!
> > > > > > >>>>>
> > > > > > >>>>> Then I think the following change should make the differe=
nce actually,
> > > > > > >>>>> you may double check that and confirm if it is that.
> > > > > > >>>>>
> > > > > > >>>>>> @@ -334,7 +334,7 @@ static void blk_kick_flush(struct re=
quest_queue *q, struct blk_flush_queue *fq,
> > > > > > >>>>>>  	flush_rq->rq_disk =3D first_rq->rq_disk;
> > > > > > >>>>>>  	flush_rq->end_io =3D flush_end_io;
> > > > > > >>>>>> =20
> > > > > > >>>>>> -	blk_flush_queue_rq(flush_rq, false);
> > > > > > >>>>>> +	blk_flush_queue_rq(flush_rq, true);
> > > > > > >>>>
> > > > > > >>>> Yes, with this the one line change above only, the runtime=
 was reduced.
> > > > > > >>>>
> > > > > > >>>>>
> > > > > > >>>>> However, the flush request is added to tail of dispatch q=
ueue[1] for long time.
> > > > > > >>>>> 0cacba6cf825 ("blk-mq-sched: bypass the scheduler for flu=
shes entirely")
> > > > > > >>>>> and its predecessor(all mq scheduler start patches) chang=
ed to add flush request
> > > > > > >>>>> to front of dispatch queue for blk-mq by ignoring 'add_qu=
eue' parameter of
> > > > > > >>>>> blk_mq_sched_insert_flush(). That change may be by accide=
nt, and not sure it is
> > > > > > >>>>> correct.
> > > > > > >>>>>
> > > > > > >>>>> I guess once flush rq is added to tail of dispatch queue =
in block/004,
> > > > > > >>>>> in which lots of FS request may stay in hctx->dispatch be=
cause of low
> > > > > > >>>>> AHCI queue depth, then we may take a bit long for flush r=
q to be
> > > > > > >>>>> submitted to LLD.
> > > > > > >>>>>
> > > > > > >>>>> I'd suggest to root cause/understand the issue given it i=
sn't obvious
> > > > > > >>>>> correct to queue flush rq at front of dispatch queue, so =
could you collect
> > > > > > >>>>> the following trace via the following script with/without=
 the single line
> > > > > > >>>>> patch?
> > > > > > >>>>
> > > > > > >>>> Thank you for the thoughts for the correct design. I have =
taken the two traces,
> > > > > > >>>> with and without the one liner patch above. The gzip archi=
ved trace files have
> > > > > > >>>> 1.6MB size. It looks too large to post to the list. Please=
 let me know how you
> > > > > > >>>> want the trace files shared.
> > > > > > >>>
> > > > > > >>> I didn't thought the trace can be so big given the ios shou=
ld be just
> > > > > > >>> 256 * 64(1564).
> > > > > > >>>
> > > > > > >>> You may put the log somewhere in Internet, cloud storage, w=
eb, or
> > > > > > >>> whatever. Then just provides us the link.
> > > > > > >>>
> > > > > > >>> Or if you can't find a place to hold it, just send to me, a=
nd I will put
> > > > > > >>> it in my RH people web link.
> > > > > > >>
> > > > > > >> I have sent another e-mail only to you attaching the log fil=
es gziped.
> > > > > > >> Your confirmation will be appreciated.
> > > > > > >=20
> > > > > > > Yeah, I got the log, and it has been put in the following lin=
k:
> > > > > > >=20
> > > > > > > http://people.redhat.com/minlei/tests/logs/blktests_block_004=
_perf_degrade.tar.gz
> > > > > > >=20
> > > > > > > Also I have run some analysis, and block/004 basically call p=
write() &
> > > > > > > fsync() in each job.
> > > > > > >=20
> > > > > > > 1) v5.6-rc kernel
> > > > > > > - write rq average latency: 0.091s=20
> > > > > > > - flush rq average latency: 0.018s
> > > > > > > - average issue times of write request: 1.978  //how many tra=
ce_block_rq_issue() is called for one rq
> > > > > > > - average issue times of flush request: 1.052
> > > > > > >=20
> > > > > > > 2) v5.6-rc patched kernel
> > > > > > > - write rq average latency: 0.031
> > > > > > > - flush rq average latency: 0.035
> > > > > > > - average issue times of write request: 1.466
> > > > > > > - average issue times of flush request: 1.610
> > > > > > >=20
> > > > > > >=20
> > > > > > > block/004 starts 64 jobs and AHCI's queue can become saturate=
d easily,
> > > > > > > then BLK_MQ_S_SCHED_RESTART should be set, so write request i=
n dispatch
> > > > > > > queue can only move on after one request is completed.
> > > > > > >=20
> > > > > > > Looks the flush request takes shorter time than normal write =
IO.
> > > > > > > If flush request is added to front of dispatch queue, the nex=
t normal
> > > > > > > write IO could be queued to lld quicker than adding to tail o=
f dispatch
> > > > > > > queue.
> > > > > > > trace_block_rq_issue() is called more than one time is becaus=
e of
> > > > > > > AHCI or the drive's implementation. It usually means that
> > > > > > > host->hostt->queuecommand() fails for several times when queu=
ing one
> > > > > > > single request. For AHCI, I understand it shouldn't fail norm=
ally given
> > > > > > > we guarantee that the actual queue depth is <=3D either LUN o=
r host's
> > > > > > > queue depth. Maybe it depends on your SMR's implementation ab=
out handling
> > > > > > > flush/write IO. Could you check why .queuecommand() fails in =
block/004?
> > > > >=20
> > > > > I put some debug prints and confirmed that the .queuecommand func=
tion is
> > > > > ata_scsi_queuecmd() and it returns SCSI_MLQUEUE_DEVICE_BUSY becau=
se
> > > > > ata_std_qc_defer() returns ATA_DEFER_LINK. The comment of ata_std=
_qc_defer()
> > > > > notes that "Non-NCQ commands cannot run with any other command, N=
CQ or not.  As
> > > > > upper layer only knows the queue depth, we are responsible for ma=
intaining
> > > > > exclusion.  This function checks whether a new command @qc can be=
 issued." Then
> > > > > I guess .queuecommand() fails because is that Non-NCQ flush comma=
nd and NCQ
> > > > > write command are waiting the completion each other.
> > > >=20
> > > > OK, got it.
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > Indeed, that is weird that queuecommand fails. There is nothing=
 SMR specific in
> > > > > > the AHCI code beside disk probe checks. So write & flush handli=
ng does not
> > > > > > differ between SMR and regular disks. The same applies to the d=
rive side. write
> > > > > > and flush commands are the normal commands, no change at all. T=
he only
> > > > > > difference being the sequential write constraint which the driv=
e honors by not
> > > > > > executing the queued write command out of order. But there are =
no constraint for
> > > > > > flush on SMR, so we get whatever the drive does, that is, total=
ly drive dependent.
> > > > > >=20
> > > > > > I wonder if the issue may be with the particular AHCI chipset u=
sed for this test.
> > > > > >=20
> > > > > > >=20
> > > > > > > Also can you provide queue flags via the following command?
> > > > > > >=20
> > > > > > > 	cat /sys/kernel/debug/block/sdN/state
> > > > >=20
> > > > > The state sysfs attribute was as follows:
> > > > >=20
> > > > > SAME_COMP|IO_STAT|ADD_RANDOM|INIT_DONE|WC|STATS|REGISTERED|SCSI_P=
ASSTHROUGH|26
> > > > >=20
> > > > > It didn't change before and after the block/004 run.
> > > > >=20
> > > > >=20
> > > > > > >=20
> > > > > > > I understand flush request should be slower than normal write=
, however
> > > > > > > looks not true in this hardware.
> > > > > >=20
> > > > > > Probably due to the fact that since the writes are sequential, =
there is a lot of
> > > > > > drive internal optimization that can be done to minimize the co=
st of flush
> > > > > > (internal data streaming from cache to media, media-cache use, =
etc) That is true
> > > > > > for regular disks too. And all of this is highly dependent on t=
he hardware
> > > > > > implementation.
> > > > >=20
> > > > > This discussion tempted me to take closer look in the traces. And=
 I noticed that
> > > > > number of flush commands issued is different with and without the=
 patch.
> > > > >=20
> > > > >                         | without patch | with patch
> > > > > ------------------------+---------------+------------
> > > > > block_getrq: rwbs=3DFWS   |      32640    |   32640
> > > > > block_rq_issue: rwbs=3DFF |      32101    |    7593
> > > >=20
> > > > Looks issued flush request is too many given the flush machinery
> > > > should avoid to queue duplicated flush requests.
> > > >=20
> > > > I will investigate the flush code a bit.
> > > >=20
> > > > >=20
> > > > > Without the patch, flush command is issued between two write comm=
ands. With the
> > > > > patch, some write commands are executed without flush between the=
m.
> > > > >=20
> > > > > I wonder how the requeue list position of flush command (head vs =
tail) changes
> > > > > the number of flush commands to issue.
> > > > >=20
> > > > > Another weird thing is number of block_getrq traces of flush (rwd=
s=3DFWS). It
> > > > > doubles number of writes (256 * 64 =3D 16320). I will chase this =
further.
> > > >=20
> > > > Indeed, not see such issue when I run the test on kvm ahci.
> > >=20
> > > I found that the cause of the doubled flush commands is dm-linear dev=
ice I set
> > > up. I mapped two areas of single SMR drive to the dm-linear device, u=
sing dm
> > > table with two lines. My understanding is that when a flush is reques=
ted to the
> > > dm-linear device, the flush request is duplicated and forwarded to  d=
estination
> > > devices listed in dm table lines. In this case, a flush request is du=
plicated
> > > for two lines in dm table, and both flush requests go to the single S=
MR drive.
> >=20
> > Got it, maybe dm linear should avoid to send two flush requests to
> > single drive.
> >=20
> > Can you observe similar issue when running block/004 over the AHCI/SMR
> > directly?

Yes. The runtime delta is smaller and I had not noticed that. Without the p=
atch,
block/004 run on AHCI/SMR drive takes from 115+ seconds. With the patch,
it takes around 100 seconds.

I also took the bpf traces and counted flush commands issued. Numbsers look
similar as those with dm-linear.

                        | without patch | with patch
------------------------+---------------+------------
block_getrq: rwbs=3DFWS   |      16320    |   16320
block_rq_issue: rwbs=3DFF |      17051    |    5866

> >=20
> > > This doubles the number of flush commands. I changed the dm table to =
have single
> > > line to map single area, and observed the number of flush commands (b=
lock_getrq
> > > with rwbs=3DFWS) got reduced to 16320, the same number as the write c=
ommands.
> > >=20
> > > This means that the workload I observed the longer runtime of block/0=
04 with
> > > kernel 5.6-rc4 is really flush intensive. It has two flush commands p=
er one
> > > write command. It might be too sensitive to flush command behavior. I=
'm not so
> > > sure if this is the workload worth performance care.
> >=20
> > The story may be something like below:
> >=20
> > 1) sometime, suppose there are two write request(w0, w1) in
> > dispatch queue(hctx->dispatch), and one flush request is just done,
> > so blk-mq starts to dispatch requests in hctx->dispatch via wq
> >=20
> > 2) a new flush request F is scheduled via requeue wq, and the flush
> > request is added to front of hctx->dispatch, which includes (F, w0, w1)
> >=20
> > 3) meantime, given there are 64 fio jobs, one of the jobs just run queu=
e=20
> > and queue one rq from scheduler to lld, and hctx->dispatch isn't observ=
ed
> > because of timing, so sata switches to NCQ mode
> >=20
> > 4) step 1 or 2 starts to run queue, and try to dispatch requests(F, w0,=
 w1).
> > .queue_rq() returns STS_RESOURCE for F because F is non-NCQ command,
> > so hctx->dispatch becomes (w0, w1, F) now. And the queue will be re-run
> > after one write request is completed, so one write IO latency is added
> > to the flush request F.
> >=20
> > 5) when flush request latency is increased, chance for flush request
> > merge is increased, so much less flush requests are issued to sata
> > in patched kernel, then issuing time for write requests is decreased.
> >=20
> > If flush request is added to tail of hctx->dispatch in step 2), one
> > extra IO latency won't be added to flush request, and flush request
> > can be completed in less time, meantime chance of flush request merge
> > is reduced much. When more flush requests are issued to sata, more time
> > is introduced to issuing write IOs.
> >=20
> > Anyway, this problem is NCQ specific. If it can be reproduced on
> > AHCI/SMR directly, we may need to fix it.
>=20
> In short, when adding flush rq to front of hctx->dispatch, it is easier
> to introduce extra time to flush rq's latency compared with adding to tai=
l
> of dispatch queue, then chance of flush merge is increased, and less
> flush requests will be issued to driver/controller, finally this kind of
> flush workloads is improved.

Ming, thank you very much for the description.

>=20
> So maybe we can add flush rq to tail of dispatch just in case of NCQ.

Reading the line above, I'm not yet sure how the fix will be. Do you mean
to check if sata driver is in NCQ mode, within blk_kick_flush()?

--=20
Best Regards,
Shin'ichiro Kawasaki=
