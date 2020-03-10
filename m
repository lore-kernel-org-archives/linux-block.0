Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B12C18E5B
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 11:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A714A24694
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 11:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TMBHM4I0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TC3qxmDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCJLHL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:07:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20283 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgCJLHI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 07:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583838483; x=1615374483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=90Et7OOaqpEAgjMT1MBd+1/Qc2iMzUJ4ArzSKN7sJU0=;
  b=TMBHM4I0FiWYaNRwFAJ58cjXtYm4lwrP0JhC6PZQqkPoxJYiNMW/1ztY
   vaHceKlvXFA6tteLXJbXpTXlP6eekKwFSOMlqblCO473/aT3+4LyEmXcm
   VXWPFeW1Bs8TQ6+G7DGpxJKrp8vrGpSnRiisMDHTdt/4Rn2PYk1iu4JGo
   5DG1R12S0jeZTdFsSFF55JsCDCIoeIV97P6fN2e69GYmSAM4n7TzZDLCr
   Y0Ch3fFt4pmal83RiiZHNCQsGNwAOy38EgzHLtRSBf0Wz1dGVms0RMtn/
   u1bd7K8WYScTlzw+VjLKhGHaVM+VyCscaQ4etAXuEBmiekGanm29KU2qu
   Q==;
IronPort-SDR: qHFUbmyBwj4Yg0jCEh1W5jUf/fHlZIaq4jaU7PBitHocCFHdMybrrQFpYWLhpa9rrqAQzGBdaM
 7R8L8OMbpIOjdep4gdLRGIx/+gzabN0hduC6v9UjOVbJSBokpAYINQVEvQmCzMU7jk0lQVD3zM
 EznB8OOy+s1FUF7zd5wNEgrRD6pH9GdA5YYbCAbc7T6eYaaTqOS09yFgD6NZOlZpG2n9nFgwbn
 W7FADQtU6I5J85kPr/JZfynErp+HeuYzF8N2VFOFYEYRGDi6CGo8gUwDKArwVimC64iGk0CU+a
 iHE=
X-IronPort-AV: E=Sophos;i="5.70,536,1574092800"; 
   d="scan'208";a="234087705"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2020 19:08:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khosQFjXtw6Ftzp5cXiIi1O0E+YL5tQiYHPY6dBIzhWsCMY8hNAeqKHJvKUiDkbIX/TiOSoqfjPYAtKNn+oSfCYCFKGSIDleqzA4wksgq4QHrSssIOyRkJBRh0dPKMDW0SzHakifTw6qUp6v3p5np41hlIk2po/fFJuYzVBRsLFbK4puVyQyQS47T2rOwq45DccVB3Shj1DP+a0wFE4SiQN7WyiufqVNkml6G9GAZK5RD1Z9yqk3wIBBsQlRQnnzpFNTA7e9QO1VSpg2R3eNF22VhJOnJNNAL5ANy+N4m0yd2rApeXgw6fAvJhbZ7kzefh1BBSgNcIIT9my//F37Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDi4+f00F2OdH27ge1poSc1KBkC/FD2I/7xK2+ySL9g=;
 b=TSWQo5fOv8ugUlf6MYxTJlNqcJ+yF53VrCB10p29j+FkjvFPfsOcodCU9ycMf4vR0N/SLEoPnN4hFCGaPmDcldckrocRM7plJINhIGWg7+kpPXtZRnFz+yK0VZ7YPNKO0erzEnx8JV2lp3QegQ2x1nDUtmgse8ICNYMakVfJdSgNIUwFK7NdZqmiUvrz93lTpUqwqn749y0JT6pbZ+ODnmgY3xTFCRyc2oo+nhvlFPxoVs3RqaNJdfVUFJBSotQNudonvdtRIUAEl/Tj/fk3M1BqeooFZD3FpblVy1K/IKqzCYw91h0K2H7suhj3GC2x05KyqwpXkCHjvvHRxbZjNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDi4+f00F2OdH27ge1poSc1KBkC/FD2I/7xK2+ySL9g=;
 b=TC3qxmDd2HGLuDvk9O79PMgsv3zHR0VzH9zB9VUSDiCDNNrvPnaLEngRofQm1kKvmbpv5ODEBN8eY7fz3w5MigScb8uGjKSePa2EW/dsk/Fani4ZwbX65qdkGvedwKJuuIr0vykrD4q9OEovMrQOFtvaa5IqnxsdN/W/3a3be08=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (2a01:111:e400:c61b::7)
 by CY1PR04MB2332.namprd04.prod.outlook.com (2a01:111:e400:c61a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Tue, 10 Mar
 2020 11:07:05 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2986:c2cb:aa36:a25d]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2986:c2cb:aa36:a25d%8]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 11:07:05 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Thread-Topic: commit 01e99aeca397 causes longer runtime of block/004
Thread-Index: AQHV8c4FlOkNXDceTU6Nwl3i3vnr/KhBXQ+AgAAlSQCAADIagA==
Date:   Tue, 10 Mar 2020 11:07:04 +0000
Message-ID: <20200310110703.hvaek3opc67lcr74@shindev.dhcp.fujisawa.hgst.com>
References: <20200305024808.GA26733@ming.t460p>
 <20200306060622.t2jl7qkzvkwvvcbx@shindev.dhcp.fujisawa.hgst.com>
 <20200306081309.GA29683@ming.t460p>
 <20200307010222.gtrwivafqe2254i6@shindev.dhcp.fujisawa.hgst.com>
 <20200307041343.GB20579@ming.t460p>
 <20200309000715.sqgsssrauzmmpli2@shindev.dhcp.fujisawa.hgst.com>
 <20200309161430.GA4871@ming.t460p>
 <BYAPR04MB5816C428F1E23B1030579887E7FF0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20200310055417.o3jghx4sl5xtztci@shindev.dhcp.fujisawa.hgst.com>
 <20200310080744.GA7618@ming.t460p>
In-Reply-To: <20200310080744.GA7618@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ecebaef2-a8ca-4111-31f0-08d7c4e32ac9
x-ms-traffictypediagnostic: CY1PR04MB2332:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB233260DE702C4FAD2EFF3C3EEDFF0@CY1PR04MB2332.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(189003)(199004)(66476007)(66446008)(64756008)(66556008)(76116006)(91956017)(71200400001)(966005)(4326008)(478600001)(6512007)(6486002)(81156014)(81166006)(8676002)(6916009)(26005)(186003)(8936002)(9686003)(66946007)(6506007)(53546011)(5660300002)(44832011)(86362001)(1076003)(30864003)(2906002)(316002)(66574012)(54906003)(148743002)(60764002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2332;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rnmIRRrVn686Nybx5hvhbcVYkvFvLtSchGFaNV/VOo18QIfdF03XoOkN3dY5P6JP4ERudxt6ZNlfVlJ5ZzfauDRCq+qSQbi324YtHzlLmTY5AT/Fp7XyOgYeqMUPfVQzX9edNmw200P9EzWveUQwobEGbu1cTrJFE/srOPPKAmmSW9Obiqt63vJVzhpSEHoYNVtia9u+UgiIXMD/9KLuKBhmdYCguGXxfcCFSq/f0tRIeYHubgdUBkKbJkwS/6W/nCX0AES7jvKQizaupIiG1lQiiIn27O3EKvK6hGx7/zbT96i6JURb8o8w3SQzjs7fGzNB8SUAmpr9iDeZb3plmHKe9bUkviJseN39ZOo9rBtIFtuVCU6EJ4Sgk+rhHr0nLapYL5ZfNt7XZbSarFV0JyuanV4c0khnb5XTl0C+2uaTDQGSGFTK0JnhrMv1FbQaSMMumQgrC1a+hJCjvVMzp/FbqRPZ9u3PNqeqUFm9s84aCjcx5Bo89vQjh79+oPkx1K3atjNfbEryhVqezQquGHzjehTz+KWxSzTBS1jREGO1z9aDsYvvhlNr0vSVQQpyz4INto/jTm1evSPke3lOX4/nrMZvW+aDD7KKy/vMFukAdkGTUZdWuMDAqBNvxHD8
x-ms-exchange-antispam-messagedata: JuM3BMlgxz4w7woAioU1opfuEFX1QdSJpcu2Ay48/Y2MkhRwvR6E/KCYzP2dUumORF3fLsp5WAjRdeynkirA8zN9RRE8eydv/VDuACjV8F18SW73FYv7XDi0XBA1lvLQJ5AATrlAbQ6Wlyq+Rd2L+Q==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FAE9A64B60E27640A30DA190DB379DFF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecebaef2-a8ca-4111-31f0-08d7c4e32ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 11:07:04.9743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8uVU1YmpX8wUmz1VTSZK6vwajCpJ7bL4hj4Ok3Ed33LOEzO4jxtiHkFE40zyVnxb3zSAb8CLdHQtbV5n/S6QdUtLw9rqcuIeMqs35F8wOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2332
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 10, 2020 / 16:07, Ming Lei wrote:
> On Tue, Mar 10, 2020 at 05:54:18AM +0000, Shinichiro Kawasaki wrote:
> > Ming, thank you for sharing the log files and analysis.
> >=20
> > On Mar 10, 2020 / 03:07, Damien Le Moal wrote:
> > > On 2020/03/10 1:14, Ming Lei wrote:
> > > > On Mon, Mar 09, 2020 at 12:07:16AM +0000, Shinichiro Kawasaki wrote=
:
> > > >> On Mar 07, 2020 / 12:13, Ming Lei wrote:
> > > >>> On Sat, Mar 07, 2020 at 01:02:23AM +0000, Shinichiro Kawasaki wro=
te:
> > > >>>> On Mar 06, 2020 / 16:13, Ming Lei wrote:
> > > >>>>> On Fri, Mar 06, 2020 at 06:06:23AM +0000, Shinichiro Kawasaki w=
rote:
> > > >>>>>> On Mar 05, 2020 / 10:48, Ming Lei wrote:
> > > >>>>>>> Hi Shinichiro,
> > > >>>>>>>
> > > >>>>>>> On Thu, Mar 05, 2020 at 01:19:02AM +0000, Shinichiro Kawasaki=
 wrote:
> > > >>>>>>>> On Mar 04, 2020 / 17:53, Ming Lei wrote:
> > > >>>>>>>>> On Wed, Mar 04, 2020 at 06:11:37AM +0000, Shinichiro Kawasa=
ki wrote:
> > > >>>>>>>>>> On Mar 04, 2020 / 11:46, Ming Lei wrote:
> > > >>>>>>>>>>> On Wed, Mar 04, 2020 at 02:38:43AM +0000, Shinichiro Kawa=
saki wrote:
> > > >>>>>>>>>>>> I noticed that blktests block/004 takes longer runtime w=
ith 5.6-rc4 than
> > > >>>>>>>>>>>> 5.6-rc3, and found that the commit 01e99aeca397 ("blk-mq=
: insert passthrough
> > > >>>>>>>>>>>> request into hctx->dispatch directly") triggers it.
> > > >>>>>>>>>>>>
> > > >>>>>>>>>>>> The longer runtime was observed with dm-linear device wh=
ich maps SATA SMR HDD
> > > >>>>>>>>>>>> connected via AHCI. It was not observed with dm-linear o=
n SAS/SATA SMR HDDs
> > > >>>>>>>>>>>> connected via SAS-HBA. Not observed with dm-linear on no=
n-SMR HDDs either.
> > > >>>>>>>>>>>>
> > > >>>>>>>>>>>> Before the commit, block/004 took around 130 seconds. Af=
ter the commit, it takes
> > > >>>>>>>>>>>> around 300 seconds. I need to dig in further details to =
understand why the
> > > >>>>>>>>>>>> commit makes the test case longer.
> > > >>>>>>>>>>>>
> > > >>>>>>>>>>>> The test case block/004 does "flush intensive workload".=
 Is this longer runtime
> > > >>>>>>>>>>>> expected?
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> The following patch might address this issue:
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> https://lore.kernel.org/linux-block/20200207190416.99928-=
1-sqazi@google.com/#t
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> Please test and provide us the result.
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> thanks,
> > > >>>>>>>>>>> Ming
> > > >>>>>>>>>>>
> > > >>>>>>>>>>
> > > >>>>>>>>>> Hi Ming,
> > > >>>>>>>>>>
> > > >>>>>>>>>> I applied the patch to 5.6-rc4 but I observed the longer r=
untime of block/004.
> > > >>>>>>>>>> Still it takes around 300 seconds.
> > > >>>>>>>>>
> > > >>>>>>>>> Hello Shinichiro,
> > > >>>>>>>>>
> > > >>>>>>>>> block/004 only sends 1564 sync randwrite, and seems 130s ha=
s been slow
> > > >>>>>>>>> enough.
> > > >>>>>>>>>
> > > >>>>>>>>> There are two related effect in that commit for your issue:
> > > >>>>>>>>>
> > > >>>>>>>>> 1) 'at_head' is applied in blk_mq_sched_insert_request() fo=
r flush
> > > >>>>>>>>> request
> > > >>>>>>>>>
> > > >>>>>>>>> 2) all IO is added back to tail of hctx->dispatch after .qu=
eue_rq()
> > > >>>>>>>>> returns STS_RESOURCE
> > > >>>>>>>>>
> > > >>>>>>>>> Seems it is more related with 2) given you can't reproduce =
the issue on=20
> > > >>>>>>>>> SAS.
> > > >>>>>>>>>
> > > >>>>>>>>> So please test the following two patches, and see which one=
 makes a
> > > >>>>>>>>> difference for you.
> > > >>>>>>>>>
> > > >>>>>>>>> BTW, both two looks not reasonable, just for narrowing down=
 the issue.
> > > >>>>>>>>>
> > > >>>>>>>>> 1) patch 1
> > > >>>>>>>>>
> > > >>>>>>>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > >>>>>>>>> index 856356b1619e..86137c75283c 100644
> > > >>>>>>>>> --- a/block/blk-mq-sched.c
> > > >>>>>>>>> +++ b/block/blk-mq-sched.c
> > > >>>>>>>>> @@ -398,7 +398,7 @@ void blk_mq_sched_insert_request(struct=
 request *rq, bool at_head,
> > > >>>>>>>>>  	WARN_ON(e && (rq->tag !=3D -1));
> > > >>>>>>>>> =20
> > > >>>>>>>>>  	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
> > > >>>>>>>>> -		blk_mq_request_bypass_insert(rq, at_head, false);
> > > >>>>>>>>> +		blk_mq_request_bypass_insert(rq, true, false);
> > > >>>>>>>>>  		goto run;
> > > >>>>>>>>>  	}
> > > >>>>>>>>
> > > >>>>>>>> Ming, thank you for the trial patches.
> > > >>>>>>>> This "patch 1" reduced the runtime, as short as rc3.
> > > >>>>>>>>
> > > >>>>>>>>>
> > > >>>>>>>>>
> > > >>>>>>>>> 2) patch 2
> > > >>>>>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > >>>>>>>>> index d92088dec6c3..447d5cb39832 100644
> > > >>>>>>>>> --- a/block/blk-mq.c
> > > >>>>>>>>> +++ b/block/blk-mq.c
> > > >>>>>>>>> @@ -1286,7 +1286,7 @@ bool blk_mq_dispatch_rq_list(struct r=
equest_queue *q, struct list_head *list,
> > > >>>>>>>>>  			q->mq_ops->commit_rqs(hctx);
> > > >>>>>>>>> =20
> > > >>>>>>>>>  		spin_lock(&hctx->lock);
> > > >>>>>>>>> -		list_splice_tail_init(list, &hctx->dispatch);
> > > >>>>>>>>> +		list_splice_init(list, &hctx->dispatch);
> > > >>>>>>>>>  		spin_unlock(&hctx->lock);
> > > >>>>>>>>> =20
> > > >>>>>>>>>  		/*
> > > >>>>>>>>
> > > >>>>>>>> This patch 2 didn't reduce the runtime.
> > > >>>>>>>>
> > > >>>>>>>> Wish this report helps.
> > > >>>>>>>
> > > >>>>>>> Your feedback does help, then please test the following patch=
:
> > > >>>>>>
> > > >>>>>> Hi Ming, thank you for the patch. I applied it on top of rc4 a=
nd confirmed
> > > >>>>>> it reduces the runtime as short as rc3. Good.
> > > >>>>>
> > > >>>>> Hi Shinichiro,
> > > >>>>>
> > > >>>>> Thanks for your test!
> > > >>>>>
> > > >>>>> Then I think the following change should make the difference ac=
tually,
> > > >>>>> you may double check that and confirm if it is that.
> > > >>>>>
> > > >>>>>> @@ -334,7 +334,7 @@ static void blk_kick_flush(struct request_=
queue *q, struct blk_flush_queue *fq,
> > > >>>>>>  	flush_rq->rq_disk =3D first_rq->rq_disk;
> > > >>>>>>  	flush_rq->end_io =3D flush_end_io;
> > > >>>>>> =20
> > > >>>>>> -	blk_flush_queue_rq(flush_rq, false);
> > > >>>>>> +	blk_flush_queue_rq(flush_rq, true);
> > > >>>>
> > > >>>> Yes, with this the one line change above only, the runtime was r=
educed.
> > > >>>>
> > > >>>>>
> > > >>>>> However, the flush request is added to tail of dispatch queue[1=
] for long time.
> > > >>>>> 0cacba6cf825 ("blk-mq-sched: bypass the scheduler for flushes e=
ntirely")
> > > >>>>> and its predecessor(all mq scheduler start patches) changed to =
add flush request
> > > >>>>> to front of dispatch queue for blk-mq by ignoring 'add_queue' p=
arameter of
> > > >>>>> blk_mq_sched_insert_flush(). That change may be by accident, an=
d not sure it is
> > > >>>>> correct.
> > > >>>>>
> > > >>>>> I guess once flush rq is added to tail of dispatch queue in blo=
ck/004,
> > > >>>>> in which lots of FS request may stay in hctx->dispatch because =
of low
> > > >>>>> AHCI queue depth, then we may take a bit long for flush rq to b=
e
> > > >>>>> submitted to LLD.
> > > >>>>>
> > > >>>>> I'd suggest to root cause/understand the issue given it isn't o=
bvious
> > > >>>>> correct to queue flush rq at front of dispatch queue, so could =
you collect
> > > >>>>> the following trace via the following script with/without the s=
ingle line
> > > >>>>> patch?
> > > >>>>
> > > >>>> Thank you for the thoughts for the correct design. I have taken =
the two traces,
> > > >>>> with and without the one liner patch above. The gzip archived tr=
ace files have
> > > >>>> 1.6MB size. It looks too large to post to the list. Please let m=
e know how you
> > > >>>> want the trace files shared.
> > > >>>
> > > >>> I didn't thought the trace can be so big given the ios should be =
just
> > > >>> 256 * 64(1564).
> > > >>>
> > > >>> You may put the log somewhere in Internet, cloud storage, web, or
> > > >>> whatever. Then just provides us the link.
> > > >>>
> > > >>> Or if you can't find a place to hold it, just send to me, and I w=
ill put
> > > >>> it in my RH people web link.
> > > >>
> > > >> I have sent another e-mail only to you attaching the log files gzi=
ped.
> > > >> Your confirmation will be appreciated.
> > > >=20
> > > > Yeah, I got the log, and it has been put in the following link:
> > > >=20
> > > > http://people.redhat.com/minlei/tests/logs/blktests_block_004_perf_=
degrade.tar.gz
> > > >=20
> > > > Also I have run some analysis, and block/004 basically call pwrite(=
) &
> > > > fsync() in each job.
> > > >=20
> > > > 1) v5.6-rc kernel
> > > > - write rq average latency: 0.091s=20
> > > > - flush rq average latency: 0.018s
> > > > - average issue times of write request: 1.978  //how many trace_blo=
ck_rq_issue() is called for one rq
> > > > - average issue times of flush request: 1.052
> > > >=20
> > > > 2) v5.6-rc patched kernel
> > > > - write rq average latency: 0.031
> > > > - flush rq average latency: 0.035
> > > > - average issue times of write request: 1.466
> > > > - average issue times of flush request: 1.610
> > > >=20
> > > >=20
> > > > block/004 starts 64 jobs and AHCI's queue can become saturated easi=
ly,
> > > > then BLK_MQ_S_SCHED_RESTART should be set, so write request in disp=
atch
> > > > queue can only move on after one request is completed.
> > > >=20
> > > > Looks the flush request takes shorter time than normal write IO.
> > > > If flush request is added to front of dispatch queue, the next norm=
al
> > > > write IO could be queued to lld quicker than adding to tail of disp=
atch
> > > > queue.
> > > > trace_block_rq_issue() is called more than one time is because of
> > > > AHCI or the drive's implementation. It usually means that
> > > > host->hostt->queuecommand() fails for several times when queuing on=
e
> > > > single request. For AHCI, I understand it shouldn't fail normally g=
iven
> > > > we guarantee that the actual queue depth is <=3D either LUN or host=
's
> > > > queue depth. Maybe it depends on your SMR's implementation about ha=
ndling
> > > > flush/write IO. Could you check why .queuecommand() fails in block/=
004?
> >=20
> > I put some debug prints and confirmed that the .queuecommand function i=
s
> > ata_scsi_queuecmd() and it returns SCSI_MLQUEUE_DEVICE_BUSY because
> > ata_std_qc_defer() returns ATA_DEFER_LINK. The comment of ata_std_qc_de=
fer()
> > notes that "Non-NCQ commands cannot run with any other command, NCQ or =
not.  As
> > upper layer only knows the queue depth, we are responsible for maintain=
ing
> > exclusion.  This function checks whether a new command @qc can be issue=
d." Then
> > I guess .queuecommand() fails because is that Non-NCQ flush command and=
 NCQ
> > write command are waiting the completion each other.
>=20
> OK, got it.
>=20
> >=20
> > >=20
> > > Indeed, that is weird that queuecommand fails. There is nothing SMR s=
pecific in
> > > the AHCI code beside disk probe checks. So write & flush handling doe=
s not
> > > differ between SMR and regular disks. The same applies to the drive s=
ide. write
> > > and flush commands are the normal commands, no change at all. The onl=
y
> > > difference being the sequential write constraint which the drive hono=
rs by not
> > > executing the queued write command out of order. But there are no con=
straint for
> > > flush on SMR, so we get whatever the drive does, that is, totally dri=
ve dependent.
> > >=20
> > > I wonder if the issue may be with the particular AHCI chipset used fo=
r this test.
> > >=20
> > > >=20
> > > > Also can you provide queue flags via the following command?
> > > >=20
> > > > 	cat /sys/kernel/debug/block/sdN/state
> >=20
> > The state sysfs attribute was as follows:
> >=20
> > SAME_COMP|IO_STAT|ADD_RANDOM|INIT_DONE|WC|STATS|REGISTERED|SCSI_PASSTHR=
OUGH|26
> >=20
> > It didn't change before and after the block/004 run.
> >=20
> >=20
> > > >=20
> > > > I understand flush request should be slower than normal write, howe=
ver
> > > > looks not true in this hardware.
> > >=20
> > > Probably due to the fact that since the writes are sequential, there =
is a lot of
> > > drive internal optimization that can be done to minimize the cost of =
flush
> > > (internal data streaming from cache to media, media-cache use, etc) T=
hat is true
> > > for regular disks too. And all of this is highly dependent on the har=
dware
> > > implementation.
> >=20
> > This discussion tempted me to take closer look in the traces. And I not=
iced that
> > number of flush commands issued is different with and without the patch=
.
> >=20
> >                         | without patch | with patch
> > ------------------------+---------------+------------
> > block_getrq: rwbs=3DFWS   |      32640    |   32640
> > block_rq_issue: rwbs=3DFF |      32101    |    7593
>=20
> Looks issued flush request is too many given the flush machinery
> should avoid to queue duplicated flush requests.
>=20
> I will investigate the flush code a bit.
>=20
> >=20
> > Without the patch, flush command is issued between two write commands. =
With the
> > patch, some write commands are executed without flush between them.
> >=20
> > I wonder how the requeue list position of flush command (head vs tail) =
changes
> > the number of flush commands to issue.
> >=20
> > Another weird thing is number of block_getrq traces of flush (rwds=3DFW=
S). It
> > doubles number of writes (256 * 64 =3D 16320). I will chase this furthe=
r.
>=20
> Indeed, not see such issue when I run the test on kvm ahci.

I found that the cause of the doubled flush commands is dm-linear device I =
set
up. I mapped two areas of single SMR drive to the dm-linear device, using d=
m
table with two lines. My understanding is that when a flush is requested to=
 the
dm-linear device, the flush request is duplicated and forwarded to  destina=
tion
devices listed in dm table lines. In this case, a flush request is duplicat=
ed
for two lines in dm table, and both flush requests go to the single SMR dri=
ve.
This doubles the number of flush commands. I changed the dm table to have s=
ingle
line to map single area, and observed the number of flush commands (block_g=
etrq
with rwbs=3DFWS) got reduced to 16320, the same number as the write command=
s.

This means that the workload I observed the longer runtime of block/004 wit=
h
kernel 5.6-rc4 is really flush intensive. It has two flush commands per one
write command. It might be too sensitive to flush command behavior. I'm not=
 so
sure if this is the workload worth performance care.

--=20
Best Regards,
Shin'ichiro Kawasaki=
