Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1AFC10DCE
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 05:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9BA2071B
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 05:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GYmoAMtd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yqIAnyna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgCJFyV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 01:54:21 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgCJFyU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 01:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583819660; x=1615355660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aGIweIVzgLSGLGQg8gSEp913CHCs8Lb30tpD+Xj3dDc=;
  b=GYmoAMtd9umospRd0KdMekqvnxr987dWHGqYeDTwT+XO+8OxXAriuIFB
   Bh0jcODZyFmv9+VmgxvmpnXMBzGb/lSC6faupfzqnI3RTv85rdoBrHDtF
   jZiauKpxmXccst++C/B8S3Af6PkMAXBr0cyltXpI926LZBN+bP0IoDX0/
   m1BQfokCPDURjgg6hKk0PYZz0RMt2isJukczffMvbIv13uhOrH0eXTF/o
   kS1YjJCmjqmZQyJg5mYz5hqzE7LyibpW/AlhaqAbgnji22wIMcvOvZPCH
   rzodvMeqIgUn3Y35P2hfaHfzH/K1NBARplVbim0S8xPUUHHs9QD6qpXXq
   g==;
IronPort-SDR: Ht8HpN08T0ujmLlCvXcKPOXQa7QNbzPT5pApYhKWc7SZqiy45shGfepxj+npVlU3yoKmtk+vIm
 i970ap7PJGvIHGahdG51aYxFnk/etwa49cUHa23/uhy8a3xrOjrHU8VY//YMQ5q2sn7Td/E4YU
 mAKoJmLllljSXcsFubAlDV7QgmP7aiU6Hm1MEepjtEKL5fUO/fPK3U8Q9jgedGNzCnY6PrBIF1
 C7Crlig5Agb+z9FDNMP068x9hXCCFqPVJ1crJ2BSCi5JzCVlu9lpDIqcdaI43eN2gd7lRdbBt9
 eYE=
X-URL-LookUp-ScanningError: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574092800"; 
   d="scan'208";a="132499367"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2020 13:54:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwN5yU94Gxnxs4Bl8XJODUqBwCXKrWMvWki6ZPo1ZvUv1EeNyO8Kmb+9oo8MWCOpgM0exaK74glVaMdYuUfdOqjF9oHUwdfINIbjvL5TLvp6lLjHj2pu2ithcHg2x3FTdiBDHQ9eCoh6qKNcObB38lXGaWg4V/b27ItvT911l1+gD5u56kBOJDtXHCytH0y2gF/JhUCuX3bP6F8OQhO5VP9GMLSaspC9EwCkoZVkCD5iaBy+6MtPHKSz3tNlIs/JMUeTTVpelDVdsavcVe1YJVOPCTHR9aiBZQ4uzLlx3I+SPtCmgViMOQhDy6/xRMnpEr9je4UmDnxNrywYAZzr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsCAklWGc+Dzv7avlGPQI+DRL3/NjaAbxnlHbsecY4Y=;
 b=iMyYyOrPQSUqPPsj3oOR77SREoWtfZyL3s7b4tL+NWM7FJ0LS7cU9xw7dXD/+efCeHfzrcuCB4RSb/FYpvpZ1nJWfKkHYcmTYJugBuIrPmcW6pq0XZBvx3GIbtNy/0IPK+G4byPDpOuNC9n7pW6Bc57R2OOkqbngrJ9v3cwhL/lMJtcxZn30sAvsIxpN9lCE9lKMjr/WYnQVWJKf2jkxyUSfQmKT6YPUpjX/LMusOcsGR3HM+jva2Du91Z1u2DIecK+LINgEibZsrOycHhOreVU+iyXObXn3SSY5ocI6Kq/mrsZufVxCIu8UaOu8SCNOHIXifBt6pEEf+ekR+UFURQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsCAklWGc+Dzv7avlGPQI+DRL3/NjaAbxnlHbsecY4Y=;
 b=yqIAnynaOptphXWiE+zNZnqG7LpEJCD5ClC61SeL8NeA4wRqYnJKDuARwzz8S3J3TnanYWP6EmGr/UpIFl3wWAS74Jf8NTp/zDfnDzbaiAlBpBCD11HS61TGXKnoVSFQtVynsiyfhmjeWEaYr6m83smt9qVitWSlzZTKRDXZ/o0=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (2a01:111:e400:c61b::7)
 by CY1PR04MB2377.namprd04.prod.outlook.com (2a01:111:e400:c638::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 05:54:18 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2986:c2cb:aa36:a25d]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2986:c2cb:aa36:a25d%8]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 05:54:18 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Thread-Topic: commit 01e99aeca397 causes longer runtime of block/004
Thread-Index: AQHV8c4FlOkNXDceTU6Nwl3i3vnr/KhBXQ+A
Date:   Tue, 10 Mar 2020 05:54:18 +0000
Message-ID: <20200310055417.o3jghx4sl5xtztci@shindev.dhcp.fujisawa.hgst.com>
References: <20200304095344.GA10390@ming.t460p>
 <20200305011900.2rtgtmclovmr2fbw@shindev.dhcp.fujisawa.hgst.com>
 <20200305024808.GA26733@ming.t460p>
 <20200306060622.t2jl7qkzvkwvvcbx@shindev.dhcp.fujisawa.hgst.com>
 <20200306081309.GA29683@ming.t460p>
 <20200307010222.gtrwivafqe2254i6@shindev.dhcp.fujisawa.hgst.com>
 <20200307041343.GB20579@ming.t460p>
 <20200309000715.sqgsssrauzmmpli2@shindev.dhcp.fujisawa.hgst.com>
 <20200309161430.GA4871@ming.t460p>
 <BYAPR04MB5816C428F1E23B1030579887E7FF0@BYAPR04MB5816.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5816C428F1E23B1030579887E7FF0@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37af4996-deeb-4b0f-2e5b-08d7c4b778ed
x-ms-traffictypediagnostic: CY1PR04MB2377:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB237795968C457872BD540B21EDFF0@CY1PR04MB2377.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(71200400001)(54906003)(2906002)(478600001)(86362001)(44832011)(26005)(966005)(8676002)(91956017)(81166006)(81156014)(8936002)(76116006)(186003)(316002)(66476007)(4326008)(64756008)(66446008)(5660300002)(66556008)(66946007)(6506007)(6862004)(53546011)(6512007)(9686003)(6636002)(6486002)(66574012)(30864003)(1076003)(148743002)(60764002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2377;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VJ5V07ELhRgg+qbb+TcXggvlb1sf4Un+EOybvVfbSo8nUsYn5LEvSfktPh8cORuKyikklUQFMxLkWy2bDGZQ4Ex06SwSIkX7jC45wBbvHd7422a5FHM56mKrup9m6jEuU2X885bQGm/1/ZIaZNc3IeRCi9+7HuuNu8FEbjwM5acs95C8yaN6DsYA1jJgZFXb+rTnfAZn80u1n/HOikjTM8jSOIM5ih6B/k6w3mKmLrLfxLF5KOHmhc6Imr+CJXJsVUpv0dQgtMIMuPBUUP2eaUJUQo7ucnIxxwZ69Mfrs0FwhpzDigWUnU7Nah/kwHZv6mMtNv0MpEyGtqeFtogoCkopchdBv2wq4FZuWSqYnUBUvDdnl1X0ycxCy0me/CLZ8BgfJmwOPiaddRydIih+wTROcQDsAe421Q+VnXOTieSkfAgWiOQoCcUkHBFYLcDALRmffYZdpQcWXGQkp91M8TabY5xYe8QJjp5rf5oTd+QdaBI/CuN3NdGAzGlE90p0brImXtQRw4enRZkZv9yFOm9SJvFW73ykNatU/gWrtPBgrjjsz7IedX9Unz274i7RLRDsnQtZlUf4OSNT/j092Mw/krNfVqJKqNtnz2VUNw1hAnH4e5Ma1FLbZNweYPGk
x-ms-exchange-antispam-messagedata: h0V9tQH/rSvEELhyHdVExExff27mWcEqGHDEZTmDTfegZlOWnZMTtdbplhTTDCKOEAvXNJIsl6FHg7XZzxW3yuhfJOP/6X6PY9FTOtVel6FlJcjERTw/z+c4a/Lv6tCZgRb8HPEU4WVicBH0M5i0eg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3DF8402D5E0224EBEB037DD1316F47F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37af4996-deeb-4b0f-2e5b-08d7c4b778ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 05:54:18.1304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRMFEoEcfrpMDWuRyKbzVcPqhui+phADixgyhNDu0w6WHG0/R6N4jzR1ElxhA5l9f9l0gTRnYZw1uZ+W0YlrmG7P8ZwLP3aUup3RgV0NeeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2377
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming, thank you for sharing the log files and analysis.

On Mar 10, 2020 / 03:07, Damien Le Moal wrote:
> On 2020/03/10 1:14, Ming Lei wrote:
> > On Mon, Mar 09, 2020 at 12:07:16AM +0000, Shinichiro Kawasaki wrote:
> >> On Mar 07, 2020 / 12:13, Ming Lei wrote:
> >>> On Sat, Mar 07, 2020 at 01:02:23AM +0000, Shinichiro Kawasaki wrote:
> >>>> On Mar 06, 2020 / 16:13, Ming Lei wrote:
> >>>>> On Fri, Mar 06, 2020 at 06:06:23AM +0000, Shinichiro Kawasaki wrote=
:
> >>>>>> On Mar 05, 2020 / 10:48, Ming Lei wrote:
> >>>>>>> Hi Shinichiro,
> >>>>>>>
> >>>>>>> On Thu, Mar 05, 2020 at 01:19:02AM +0000, Shinichiro Kawasaki wro=
te:
> >>>>>>>> On Mar 04, 2020 / 17:53, Ming Lei wrote:
> >>>>>>>>> On Wed, Mar 04, 2020 at 06:11:37AM +0000, Shinichiro Kawasaki w=
rote:
> >>>>>>>>>> On Mar 04, 2020 / 11:46, Ming Lei wrote:
> >>>>>>>>>>> On Wed, Mar 04, 2020 at 02:38:43AM +0000, Shinichiro Kawasaki=
 wrote:
> >>>>>>>>>>>> I noticed that blktests block/004 takes longer runtime with =
5.6-rc4 than
> >>>>>>>>>>>> 5.6-rc3, and found that the commit 01e99aeca397 ("blk-mq: in=
sert passthrough
> >>>>>>>>>>>> request into hctx->dispatch directly") triggers it.
> >>>>>>>>>>>>
> >>>>>>>>>>>> The longer runtime was observed with dm-linear device which =
maps SATA SMR HDD
> >>>>>>>>>>>> connected via AHCI. It was not observed with dm-linear on SA=
S/SATA SMR HDDs
> >>>>>>>>>>>> connected via SAS-HBA. Not observed with dm-linear on non-SM=
R HDDs either.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Before the commit, block/004 took around 130 seconds. After =
the commit, it takes
> >>>>>>>>>>>> around 300 seconds. I need to dig in further details to unde=
rstand why the
> >>>>>>>>>>>> commit makes the test case longer.
> >>>>>>>>>>>>
> >>>>>>>>>>>> The test case block/004 does "flush intensive workload". Is =
this longer runtime
> >>>>>>>>>>>> expected?
> >>>>>>>>>>>
> >>>>>>>>>>> The following patch might address this issue:
> >>>>>>>>>>>
> >>>>>>>>>>> https://lore.kernel.org/linux-block/20200207190416.99928-1-sq=
azi@google.com/#t
> >>>>>>>>>>>
> >>>>>>>>>>> Please test and provide us the result.
> >>>>>>>>>>>
> >>>>>>>>>>> thanks,
> >>>>>>>>>>> Ming
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Hi Ming,
> >>>>>>>>>>
> >>>>>>>>>> I applied the patch to 5.6-rc4 but I observed the longer runti=
me of block/004.
> >>>>>>>>>> Still it takes around 300 seconds.
> >>>>>>>>>
> >>>>>>>>> Hello Shinichiro,
> >>>>>>>>>
> >>>>>>>>> block/004 only sends 1564 sync randwrite, and seems 130s has be=
en slow
> >>>>>>>>> enough.
> >>>>>>>>>
> >>>>>>>>> There are two related effect in that commit for your issue:
> >>>>>>>>>
> >>>>>>>>> 1) 'at_head' is applied in blk_mq_sched_insert_request() for fl=
ush
> >>>>>>>>> request
> >>>>>>>>>
> >>>>>>>>> 2) all IO is added back to tail of hctx->dispatch after .queue_=
rq()
> >>>>>>>>> returns STS_RESOURCE
> >>>>>>>>>
> >>>>>>>>> Seems it is more related with 2) given you can't reproduce the =
issue on=20
> >>>>>>>>> SAS.
> >>>>>>>>>
> >>>>>>>>> So please test the following two patches, and see which one mak=
es a
> >>>>>>>>> difference for you.
> >>>>>>>>>
> >>>>>>>>> BTW, both two looks not reasonable, just for narrowing down the=
 issue.
> >>>>>>>>>
> >>>>>>>>> 1) patch 1
> >>>>>>>>>
> >>>>>>>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> >>>>>>>>> index 856356b1619e..86137c75283c 100644
> >>>>>>>>> --- a/block/blk-mq-sched.c
> >>>>>>>>> +++ b/block/blk-mq-sched.c
> >>>>>>>>> @@ -398,7 +398,7 @@ void blk_mq_sched_insert_request(struct req=
uest *rq, bool at_head,
> >>>>>>>>>  	WARN_ON(e && (rq->tag !=3D -1));
> >>>>>>>>> =20
> >>>>>>>>>  	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
> >>>>>>>>> -		blk_mq_request_bypass_insert(rq, at_head, false);
> >>>>>>>>> +		blk_mq_request_bypass_insert(rq, true, false);
> >>>>>>>>>  		goto run;
> >>>>>>>>>  	}
> >>>>>>>>
> >>>>>>>> Ming, thank you for the trial patches.
> >>>>>>>> This "patch 1" reduced the runtime, as short as rc3.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> 2) patch 2
> >>>>>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >>>>>>>>> index d92088dec6c3..447d5cb39832 100644
> >>>>>>>>> --- a/block/blk-mq.c
> >>>>>>>>> +++ b/block/blk-mq.c
> >>>>>>>>> @@ -1286,7 +1286,7 @@ bool blk_mq_dispatch_rq_list(struct reque=
st_queue *q, struct list_head *list,
> >>>>>>>>>  			q->mq_ops->commit_rqs(hctx);
> >>>>>>>>> =20
> >>>>>>>>>  		spin_lock(&hctx->lock);
> >>>>>>>>> -		list_splice_tail_init(list, &hctx->dispatch);
> >>>>>>>>> +		list_splice_init(list, &hctx->dispatch);
> >>>>>>>>>  		spin_unlock(&hctx->lock);
> >>>>>>>>> =20
> >>>>>>>>>  		/*
> >>>>>>>>
> >>>>>>>> This patch 2 didn't reduce the runtime.
> >>>>>>>>
> >>>>>>>> Wish this report helps.
> >>>>>>>
> >>>>>>> Your feedback does help, then please test the following patch:
> >>>>>>
> >>>>>> Hi Ming, thank you for the patch. I applied it on top of rc4 and c=
onfirmed
> >>>>>> it reduces the runtime as short as rc3. Good.
> >>>>>
> >>>>> Hi Shinichiro,
> >>>>>
> >>>>> Thanks for your test!
> >>>>>
> >>>>> Then I think the following change should make the difference actual=
ly,
> >>>>> you may double check that and confirm if it is that.
> >>>>>
> >>>>>> @@ -334,7 +334,7 @@ static void blk_kick_flush(struct request_queu=
e *q, struct blk_flush_queue *fq,
> >>>>>>  	flush_rq->rq_disk =3D first_rq->rq_disk;
> >>>>>>  	flush_rq->end_io =3D flush_end_io;
> >>>>>> =20
> >>>>>> -	blk_flush_queue_rq(flush_rq, false);
> >>>>>> +	blk_flush_queue_rq(flush_rq, true);
> >>>>
> >>>> Yes, with this the one line change above only, the runtime was reduc=
ed.
> >>>>
> >>>>>
> >>>>> However, the flush request is added to tail of dispatch queue[1] fo=
r long time.
> >>>>> 0cacba6cf825 ("blk-mq-sched: bypass the scheduler for flushes entir=
ely")
> >>>>> and its predecessor(all mq scheduler start patches) changed to add =
flush request
> >>>>> to front of dispatch queue for blk-mq by ignoring 'add_queue' param=
eter of
> >>>>> blk_mq_sched_insert_flush(). That change may be by accident, and no=
t sure it is
> >>>>> correct.
> >>>>>
> >>>>> I guess once flush rq is added to tail of dispatch queue in block/0=
04,
> >>>>> in which lots of FS request may stay in hctx->dispatch because of l=
ow
> >>>>> AHCI queue depth, then we may take a bit long for flush rq to be
> >>>>> submitted to LLD.
> >>>>>
> >>>>> I'd suggest to root cause/understand the issue given it isn't obvio=
us
> >>>>> correct to queue flush rq at front of dispatch queue, so could you =
collect
> >>>>> the following trace via the following script with/without the singl=
e line
> >>>>> patch?
> >>>>
> >>>> Thank you for the thoughts for the correct design. I have taken the =
two traces,
> >>>> with and without the one liner patch above. The gzip archived trace =
files have
> >>>> 1.6MB size. It looks too large to post to the list. Please let me kn=
ow how you
> >>>> want the trace files shared.
> >>>
> >>> I didn't thought the trace can be so big given the ios should be just
> >>> 256 * 64(1564).
> >>>
> >>> You may put the log somewhere in Internet, cloud storage, web, or
> >>> whatever. Then just provides us the link.
> >>>
> >>> Or if you can't find a place to hold it, just send to me, and I will =
put
> >>> it in my RH people web link.
> >>
> >> I have sent another e-mail only to you attaching the log files gziped.
> >> Your confirmation will be appreciated.
> >=20
> > Yeah, I got the log, and it has been put in the following link:
> >=20
> > http://people.redhat.com/minlei/tests/logs/blktests_block_004_perf_degr=
ade.tar.gz
> >=20
> > Also I have run some analysis, and block/004 basically call pwrite() &
> > fsync() in each job.
> >=20
> > 1) v5.6-rc kernel
> > - write rq average latency: 0.091s=20
> > - flush rq average latency: 0.018s
> > - average issue times of write request: 1.978  //how many trace_block_r=
q_issue() is called for one rq
> > - average issue times of flush request: 1.052
> >=20
> > 2) v5.6-rc patched kernel
> > - write rq average latency: 0.031
> > - flush rq average latency: 0.035
> > - average issue times of write request: 1.466
> > - average issue times of flush request: 1.610
> >=20
> >=20
> > block/004 starts 64 jobs and AHCI's queue can become saturated easily,
> > then BLK_MQ_S_SCHED_RESTART should be set, so write request in dispatch
> > queue can only move on after one request is completed.
> >=20
> > Looks the flush request takes shorter time than normal write IO.
> > If flush request is added to front of dispatch queue, the next normal
> > write IO could be queued to lld quicker than adding to tail of dispatch
> > queue.
> > trace_block_rq_issue() is called more than one time is because of
> > AHCI or the drive's implementation. It usually means that
> > host->hostt->queuecommand() fails for several times when queuing one
> > single request. For AHCI, I understand it shouldn't fail normally given
> > we guarantee that the actual queue depth is <=3D either LUN or host's
> > queue depth. Maybe it depends on your SMR's implementation about handli=
ng
> > flush/write IO. Could you check why .queuecommand() fails in block/004?

I put some debug prints and confirmed that the .queuecommand function is
ata_scsi_queuecmd() and it returns SCSI_MLQUEUE_DEVICE_BUSY because
ata_std_qc_defer() returns ATA_DEFER_LINK. The comment of ata_std_qc_defer(=
)
notes that "Non-NCQ commands cannot run with any other command, NCQ or not.=
  As
upper layer only knows the queue depth, we are responsible for maintaining
exclusion.  This function checks whether a new command @qc can be issued." =
Then
I guess .queuecommand() fails because is that Non-NCQ flush command and NCQ
write command are waiting the completion each other.

>=20
> Indeed, that is weird that queuecommand fails. There is nothing SMR speci=
fic in
> the AHCI code beside disk probe checks. So write & flush handling does no=
t
> differ between SMR and regular disks. The same applies to the drive side.=
 write
> and flush commands are the normal commands, no change at all. The only
> difference being the sequential write constraint which the drive honors b=
y not
> executing the queued write command out of order. But there are no constra=
int for
> flush on SMR, so we get whatever the drive does, that is, totally drive d=
ependent.
>=20
> I wonder if the issue may be with the particular AHCI chipset used for th=
is test.
>=20
> >=20
> > Also can you provide queue flags via the following command?
> >=20
> > 	cat /sys/kernel/debug/block/sdN/state

The state sysfs attribute was as follows:

SAME_COMP|IO_STAT|ADD_RANDOM|INIT_DONE|WC|STATS|REGISTERED|SCSI_PASSTHROUGH=
|26

It didn't change before and after the block/004 run.


> >=20
> > I understand flush request should be slower than normal write, however
> > looks not true in this hardware.
>=20
> Probably due to the fact that since the writes are sequential, there is a=
 lot of
> drive internal optimization that can be done to minimize the cost of flus=
h
> (internal data streaming from cache to media, media-cache use, etc) That =
is true
> for regular disks too. And all of this is highly dependent on the hardwar=
e
> implementation.

This discussion tempted me to take closer look in the traces. And I noticed=
 that
number of flush commands issued is different with and without the patch.

                        | without patch | with patch
------------------------+---------------+------------
block_getrq: rwbs=3DFWS   |      32640    |   32640
block_rq_issue: rwbs=3DFF |      32101    |    7593

Without the patch, flush command is issued between two write commands. With=
 the
patch, some write commands are executed without flush between them.

I wonder how the requeue list position of flush command (head vs tail) chan=
ges
the number of flush commands to issue.

Another weird thing is number of block_getrq traces of flush (rwds=3DFWS). =
It
doubles number of writes (256 * 64 =3D 16320). I will chase this further.


> Shinichiro,
>=20
> It may be worth trying the same run with & without Ming's patch on a mach=
ine
> with a different chipset...

Thanks for the advice. So far, I observer the long block/004 runtime on two
systems. One with Intel C220 Series SATA controller, and the other with Int=
el
200 Series PCH SATA controller. I will try to find other SATA controller.

--=20
Best Regards,
Shin'ichiro Kawasaki=
