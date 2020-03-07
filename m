Return-Path: <SRS0=wE/y=4Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14756C10DCE
	for <linux-block@archiver.kernel.org>; Sat,  7 Mar 2020 01:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DD8206D7
	for <linux-block@archiver.kernel.org>; Sat,  7 Mar 2020 01:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eDEv+Fn4";
	dkim=temperror (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AJkqp4un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCGBC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Mar 2020 20:02:27 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10820 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgCGBC1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Mar 2020 20:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583542947; x=1615078947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UodtnMSjvAguYvKxhYFaMlohhv50P840lXM3OV3mFCI=;
  b=eDEv+Fn4ESs822ZMA05AL72Eu6dbu31BZSFp9djfsemz4bXnXVZ3E6ls
   kjYmSvvS6i4103MdJX/1nV4XvotHAvwVresMONY0SqxjyiawXlfPlQWuZ
   jyBMgS1XrTMDpIzsWF9OUU1UH6Yr1JWxkxYmZEDgIPX8d1aJhrEim+/r/
   ntB1KXahClzD5xQbc0rUjSGwDTtpwzdw0j/gvTYZ58QXlg2illgGL/YyZ
   N0umFsLJobusT/HMt0+fswbeSkf31PGzU6DYyLUmHGlqZ6x7uWLRIUxxf
   vsxpPBLgw+mUbNhUSYs7SU+q9pHcIp/A6eJwtlPDHQNGDMKdZ5j323t2m
   w==;
IronPort-SDR: us8FlvDUsrKDBLOh5eOkSM7VkA4+mfEDeiMmcbP73Fyryk0ZDjONDq3CrY7SrwUZ/wjQTgcImu
 o6mJ6r/nLFXTxvmHx6oniBV2tYM1ilftpVFy70aMb3suI5Ts6ttqnRv0DotaEhxW4H29Z2oIPE
 WWrBYxJiZq+NFCf9JsWZMQhSt9DEyftDYTUXcIwQDRmAulvMQXq5UO2fb6P4/qdGNwMawg1byz
 N06g1s0v5ugphIrv4zzpqGNuivZJtGWS+x1+UlJm9xe439SVzR+lPZCfvjAwmyvwusXvZ5ftyH
 de0=
X-IronPort-AV: E=Sophos;i="5.70,524,1574092800"; 
   d="scan'208";a="136200558"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2020 09:02:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEjsdrToESCFzjdxNG41+pK6P+mPyNfvayDZpyu28wyfLkRwHva160XFq5RdKgvAgCG2pj7MPmZTYwDIiiKAIgCAg8jWpxUL3BYAdfTVFPVf906KWl3Je1xeNja7nfS8XF5Tds4eulRI9pBf4gj099F0qtCQZlmUItK1GvER4+a4yiORZXdLoG6J/Iy82xKnNLFzz1tExeduuHEorDL/HU+EqVuUw/61O5YSoO4lEebWLVAAY6Zjv+fCCDIgsgZTQ78zevWVslDKQ9vqra4W78yJThUHnPgSXRKNdzTOBX8XSrkNoNV0M/F3e9laFUSUV4UsPdx7ev+Mueg8RfvBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6epqV1LFLQGT3Hqq0zmxHe+ognvgwkIDyhfb+yJ/6ag=;
 b=LHjQBuL5+DR4elG+pjfHX6B2qSNJCpDtPOoa947pc8NebvbVQcmXWFUy8ypWbn/eC9FtrtelpliWr4gP/4zWOCA1Ym/KhhBFCxIqtwx2xIfXJtPSeZMhFj/GiZb8nQOlpjkh1Q3pDCoNKNSwWJXsEdVhhGuVoSOPVoTY+VXwO+1dJuCz7B8qZZDFbpXonVC4hhJtbASjKF3fBt4PK3VfAGedrynYOrQnvYodF7pyRl1P7zUo7b5n8vUAhyZNMxYotHeatqpPRHXiNQa+g9VdUD+GeRtMNFCg1MSid0AUw7mUEenlcQsXhAYpygHVpkwHuF4svgNp59IynrJsZcQFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6epqV1LFLQGT3Hqq0zmxHe+ognvgwkIDyhfb+yJ/6ag=;
 b=AJkqp4unt47+gTOrfvaN8O0KT295dWfy94L12anhWJxQWXZqDEMFrY/1cUn+xqBC9eYDr50Mw0zGfhWvaw3W2jtYsXs+sybw/qbcpc6BUwhvysEZPXX01Sz4jIUNgpye2RChPifubl73pnJo1Lg+Xh+J0EXaWGfHuQzUaqxhsEw=
Received: from BN3PR04MB2257.namprd04.prod.outlook.com
 (2a01:111:e400:7bb9::20) by BN3PR04MB2322.namprd04.prod.outlook.com
 (2a01:111:e400:7bb9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Sat, 7 Mar
 2020 01:02:24 +0000
Received: from BN3PR04MB2257.namprd04.prod.outlook.com
 ([fe80::58dc:d030:4975:3ac0]) by BN3PR04MB2257.namprd04.prod.outlook.com
 ([fe80::58dc:d030:4975:3ac0%6]) with mapi id 15.20.2772.019; Sat, 7 Mar 2020
 01:02:23 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Thread-Topic: commit 01e99aeca397 causes longer runtime of block/004
Thread-Index: AQHV8c4FlOkNXDceTU6Nwl3i3vnr/Kg3y28AgAAoe4CAAD4PAIABAoQAgAAY5wCAAcm4AIAAI2yAgAEZ+QA=
Date:   Sat, 7 Mar 2020 01:02:23 +0000
Message-ID: <20200307010222.gtrwivafqe2254i6@shindev.dhcp.fujisawa.hgst.com>
References: <20200304023842.gu37d4mzfbseiscw@shindev.dhcp.fujisawa.hgst.com>
 <20200304034644.GA23012@ming.t460p>
 <20200304061137.l4hdqdt2dvs7dxgz@shindev.dhcp.fujisawa.hgst.com>
 <20200304095344.GA10390@ming.t460p>
 <20200305011900.2rtgtmclovmr2fbw@shindev.dhcp.fujisawa.hgst.com>
 <20200305024808.GA26733@ming.t460p>
 <20200306060622.t2jl7qkzvkwvvcbx@shindev.dhcp.fujisawa.hgst.com>
 <20200306081309.GA29683@ming.t460p>
In-Reply-To: <20200306081309.GA29683@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a398c23-3420-4128-03f1-08d7c2333258
x-ms-traffictypediagnostic: BN3PR04MB2322:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN3PR04MB232272D42E9C02C5706D3B18EDE00@BN3PR04MB2322.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 03355EE97E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(81156014)(54906003)(26005)(81166006)(2906002)(8936002)(6486002)(64756008)(66446008)(6506007)(6512007)(1076003)(44832011)(8676002)(71200400001)(91956017)(66476007)(966005)(478600001)(9686003)(66946007)(186003)(66556008)(5660300002)(86362001)(76116006)(316002)(6916009)(4326008)(148743002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR04MB2322;H:BN3PR04MB2257.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ApPdEvO3JWVTuZNC8o0QvsZkv+TsZADLmwXXZHf9Bd84TmjnfxtUgasObUt8qBMmYnuo7aKKzyHG/KAhyro7pZ0HC+ut9vmLG2YMt6SuDD6v8mUqdvZTI/ZGfsad2vHZAdGkKU1XyVmi8lF4TiopRjOJP5+NtFxoM/OvI12gMaLbpQbALBYpVFdeY/ZBtE1tbLgwb1ap8vaLmkI7JZa9igltoVTraTljGn1tDb1O1N+Q1HlkzS8fF5tKdUbY6TnYsz6IuhVvlWMMD1X9EBSguQbakfLVzgLWgPJVTsbtCYF/pklJ8Kw4f8n3cbIqVHI4sT48duFZ8/nrcttTwok/2e1NTIMEumNMWEGuxuncfHQfMseqH/JAb0UM9fH0O8gNtbs1pVbCMTmV3gf+huhoyUibPdpknWMJaehG32gFdC0GKtD7wiw3xuLzi+IudYzul9jYGCoEFuBAZUyASTf76wlpjNFq0ep6jjHMGxQ/hmbLVzFKJtjteWBgkWmypUtrH4ZeALVCadSM2ZRTcalseXOtPNCybqCpoBFaOkSr3XcwJE5XUk+1knzU+JPmbKf+5JctTIaxt7L9jgxq18VP9GtTzCgdSwznL20BlHcpep8=
x-ms-exchange-antispam-messagedata: 7/6xw8gl8JzHZziKMMgoEXJ1KEkOSP5AkC46rGEOdPxXZnfns+m55kM1IfcBCw+xzg/OXxDrKiu2Mhgd1aPGdewGk3lO8hxt0q2BImhM4Rv7u+aQFoMOHUG7nkyGgGFgu0ccmLLinvyIfN5hlStCyg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <58C2472F586A574094071A1CB0C4A4E2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a398c23-3420-4128-03f1-08d7c2333258
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2020 01:02:23.7895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8yt2SfGuAg40b5Y8OaJdxqYR/jZrJ4dcJnxH5k+HWHXP5NVGLCm8MleRmy1kDPn86SpvOAurZ/sYfDmY53x3LrK6ETuX/7D3ShHux1xu1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2322
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 06, 2020 / 16:13, Ming Lei wrote:
> On Fri, Mar 06, 2020 at 06:06:23AM +0000, Shinichiro Kawasaki wrote:
> > On Mar 05, 2020 / 10:48, Ming Lei wrote:
> > > Hi Shinichiro,
> > >=20
> > > On Thu, Mar 05, 2020 at 01:19:02AM +0000, Shinichiro Kawasaki wrote:
> > > > On Mar 04, 2020 / 17:53, Ming Lei wrote:
> > > > > On Wed, Mar 04, 2020 at 06:11:37AM +0000, Shinichiro Kawasaki wro=
te:
> > > > > > On Mar 04, 2020 / 11:46, Ming Lei wrote:
> > > > > > > On Wed, Mar 04, 2020 at 02:38:43AM +0000, Shinichiro Kawasaki=
 wrote:
> > > > > > > > I noticed that blktests block/004 takes longer runtime with=
 5.6-rc4 than
> > > > > > > > 5.6-rc3, and found that the commit 01e99aeca397 ("blk-mq: i=
nsert passthrough
> > > > > > > > request into hctx->dispatch directly") triggers it.
> > > > > > > >=20
> > > > > > > > The longer runtime was observed with dm-linear device which=
 maps SATA SMR HDD
> > > > > > > > connected via AHCI. It was not observed with dm-linear on S=
AS/SATA SMR HDDs
> > > > > > > > connected via SAS-HBA. Not observed with dm-linear on non-S=
MR HDDs either.
> > > > > > > >=20
> > > > > > > > Before the commit, block/004 took around 130 seconds. After=
 the commit, it takes
> > > > > > > > around 300 seconds. I need to dig in further details to und=
erstand why the
> > > > > > > > commit makes the test case longer.
> > > > > > > >=20
> > > > > > > > The test case block/004 does "flush intensive workload". Is=
 this longer runtime
> > > > > > > > expected?
> > > > > > >=20
> > > > > > > The following patch might address this issue:
> > > > > > >=20
> > > > > > > https://lore.kernel.org/linux-block/20200207190416.99928-1-sq=
azi@google.com/#t
> > > > > > >=20
> > > > > > > Please test and provide us the result.
> > > > > > >=20
> > > > > > > thanks,
> > > > > > > Ming
> > > > > > >
> > > > > >=20
> > > > > > Hi Ming,
> > > > > >=20
> > > > > > I applied the patch to 5.6-rc4 but I observed the longer runtim=
e of block/004.
> > > > > > Still it takes around 300 seconds.
> > > > >=20
> > > > > Hello Shinichiro,
> > > > >=20
> > > > > block/004 only sends 1564 sync randwrite, and seems 130s has been=
 slow
> > > > > enough.
> > > > >=20
> > > > > There are two related effect in that commit for your issue:
> > > > >=20
> > > > > 1) 'at_head' is applied in blk_mq_sched_insert_request() for flus=
h
> > > > > request
> > > > >=20
> > > > > 2) all IO is added back to tail of hctx->dispatch after .queue_rq=
()
> > > > > returns STS_RESOURCE
> > > > >=20
> > > > > Seems it is more related with 2) given you can't reproduce the is=
sue on=20
> > > > > SAS.
> > > > >=20
> > > > > So please test the following two patches, and see which one makes=
 a
> > > > > difference for you.
> > > > >=20
> > > > > BTW, both two looks not reasonable, just for narrowing down the i=
ssue.
> > > > >=20
> > > > > 1) patch 1
> > > > >=20
> > > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > > index 856356b1619e..86137c75283c 100644
> > > > > --- a/block/blk-mq-sched.c
> > > > > +++ b/block/blk-mq-sched.c
> > > > > @@ -398,7 +398,7 @@ void blk_mq_sched_insert_request(struct reque=
st *rq, bool at_head,
> > > > >  	WARN_ON(e && (rq->tag !=3D -1));
> > > > > =20
> > > > >  	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
> > > > > -		blk_mq_request_bypass_insert(rq, at_head, false);
> > > > > +		blk_mq_request_bypass_insert(rq, true, false);
> > > > >  		goto run;
> > > > >  	}
> > > >=20
> > > > Ming, thank you for the trial patches.
> > > > This "patch 1" reduced the runtime, as short as rc3.
> > > >=20
> > > > >=20
> > > > >=20
> > > > > 2) patch 2
> > > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > > index d92088dec6c3..447d5cb39832 100644
> > > > > --- a/block/blk-mq.c
> > > > > +++ b/block/blk-mq.c
> > > > > @@ -1286,7 +1286,7 @@ bool blk_mq_dispatch_rq_list(struct request=
_queue *q, struct list_head *list,
> > > > >  			q->mq_ops->commit_rqs(hctx);
> > > > > =20
> > > > >  		spin_lock(&hctx->lock);
> > > > > -		list_splice_tail_init(list, &hctx->dispatch);
> > > > > +		list_splice_init(list, &hctx->dispatch);
> > > > >  		spin_unlock(&hctx->lock);
> > > > > =20
> > > > >  		/*
> > > >=20
> > > > This patch 2 didn't reduce the runtime.
> > > >=20
> > > > Wish this report helps.
> > >=20
> > > Your feedback does help, then please test the following patch:
> >=20
> > Hi Ming, thank you for the patch. I applied it on top of rc4 and confir=
med
> > it reduces the runtime as short as rc3. Good.
>=20
> Hi Shinichiro,
>=20
> Thanks for your test!
>=20
> Then I think the following change should make the difference actually,
> you may double check that and confirm if it is that.
>=20
> > @@ -334,7 +334,7 @@ static void blk_kick_flush(struct request_queue *q,=
 struct blk_flush_queue *fq,
> >  	flush_rq->rq_disk =3D first_rq->rq_disk;
> >  	flush_rq->end_io =3D flush_end_io;
> > =20
> > -	blk_flush_queue_rq(flush_rq, false);
> > +	blk_flush_queue_rq(flush_rq, true);

Yes, with this the one line change above only, the runtime was reduced.

>=20
> However, the flush request is added to tail of dispatch queue[1] for long=
 time.
> 0cacba6cf825 ("blk-mq-sched: bypass the scheduler for flushes entirely")
> and its predecessor(all mq scheduler start patches) changed to add flush =
request
> to front of dispatch queue for blk-mq by ignoring 'add_queue' parameter o=
f
> blk_mq_sched_insert_flush(). That change may be by accident, and not sure=
 it is
> correct.
>=20
> I guess once flush rq is added to tail of dispatch queue in block/004,
> in which lots of FS request may stay in hctx->dispatch because of low
> AHCI queue depth, then we may take a bit long for flush rq to be
> submitted to LLD.
>=20
> I'd suggest to root cause/understand the issue given it isn't obvious
> correct to queue flush rq at front of dispatch queue, so could you collec=
t
> the following trace via the following script with/without the single line
> patch?

Thank you for the thoughts for the correct design. I have taken the two tra=
ces,
with and without the one liner patch above. The gzip archived trace files h=
ave
1.6MB size. It looks too large to post to the list. Please let me know how =
you
want the trace files shared.

Thanks!

--=20
Best Regards,
Shin'ichiro Kawasaki

>=20
> #!/bin/sh
>=20
> MAJ=3D$1
> MIN=3D$2
> MAJ=3D$(( $MAJ << 20 ))
> DEV=3D$(( $MAJ | $MIN ))
>=20
> /usr/share/bcc/tools/trace -t -C \
>     't:block:block_getrq (args->dev =3D=3D '$DEV') "%s %d %d", args->rwbs=
, args->sector, args->nr_sector' \
>     't:block:block_rq_issue (args->dev =3D=3D '$DEV') "%s %d %d", args->r=
wbs, args->sector, args->nr_sector' \
>     't:block:block_rq_complete (args->dev =3D=3D '$DEV') "%s %d %d", args=
->rwbs, args->sector, args->nr_sector'
>=20
> note:
> 1) install bcc package
> 2) pass the test disk(AHCI/SMR) major & minor to above script
> 3) start the script before running block/004
>=20
>=20
>=20
> [1] 53d63e6b0dfb block: make the flush insertion use the tail of the disp=
atch list
>=20
> Thanks,
> Ming
> =
