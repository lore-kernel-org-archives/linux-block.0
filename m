Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D5DC10DCE
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 00:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660B020675
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 00:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gqJrWcMF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cLInkG5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgCIAHU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Mar 2020 20:07:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53943 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgCIAHT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Mar 2020 20:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583712438; x=1615248438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eZymKYEpIARXC8CPY39SpWiRgRKqsfd04M4lC46TUIk=;
  b=gqJrWcMFNmHIOvyGYK5eNh98iIcHcIFmbRMV4fd1rX4ftUC+3HogA0CW
   7jxZzjmRu25qMramvnbKmFA32cyuENImzCcZ3wfsUONWqqkpIw3TyadQ1
   yg8fTvzzsS4LlBkPzEa3BopYYrAz+WMOefTbkpZ0GTL9ed2ntKwyFxMTp
   NC0tn/URI8DP09z6oJpefcRtBN8x/ItsNfo0BFuh5Oh66ugcXNNgsebNy
   c3cMDB+UcC2lD2R8YJ4IMuFaIZ5LdV1wiNq2e56+uktbSibDFPTWPBMNW
   RQIRQvN8jhtYaYX9tr2lXXC9NvVnXQmcoBzP1lPFlGIBcuONV1RcyD114
   A==;
IronPort-SDR: cQGPXhMQTpPb3NiALQwzkcC/487aQekPj/qq51tE/wZc7YyB5TyAzG1BhM+TSpZJA2dyYr2n5Q
 GUpjpVZJ4Q4287ezf+PpMUnLUaRKafFkTEvsC2o7gKyeXUEPeAEN2AI2yj5bpztnFK2Fv9v6Au
 GoCCBGJd5Wd+jCTHOgcMRs1cCMCqEOvmRjaIsr+wtlUbIeB53ThCct1nyeguBY6//XQzuk+Jd9
 T0Y8fK+O+bS+YK/0fWdx9I2TbrHxDLVHlvavQCTw751c9AIBpv1OJ3Sm8PsIVoZsKzp05qT/wP
 bAE=
X-IronPort-AV: E=Sophos;i="5.70,530,1574092800"; 
   d="scan'208";a="131929172"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2020 08:07:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCDaM6rt6dnT4dxdEocrrRQ/IC+oVW5mzfAZckMmbfUdxM11W1wtyK1tMUrStug092Xu25SZV4NOxSpqe3MQRyzhHlvAbKyXo8Cxv8zE8AnP39r+8LdYAJLfC7ZWHxqYSvH7AcKb4s+gtBc5LoGwtK3+4bWq3LzRCBC4yOqzosU6c5D614Eow9UAlzx54hY+FZdOIIO8bkn3VV+skjuiDSaRtU+Da8Wg/sDKTsa7sDHUrZOtCM0APFTACjL3jpvsL0H6D39DURzNGtbPd985gtasy7GohrZzRGa2w5yFMgca8n3y8unWfD0mIwzLWR3RT9zu9RO0089oXiQ6hvzMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrXgEzjv1BE8gz7nS3Ds1XaNSeUaERRRWSWJ2k65MTY=;
 b=LoTKzx2U5qD75n472VR43b+zVH/qE3+JTlSqbEJXLiwrse4ibKux1F9ImxVNVRF1FdcRiJTFtfonfNn190MC3e5IQaMZ+OV4R3w6jhW2d8CH649CfyQvtDS6+Y1dhKCyMRzF38fRgBTK/lpBx6+WOBTyFMcj+/YOO+rQHdLULyiSV28othTw03WCNK+4cLHMBGqm548I0imJrWG3TEYKulcLfZXEJOUFFrp8zrDusoD3Xp3DLDciblq/+3hc5/incOZNCzwpui0fUIqr1CHX3BEkMQssoXx/23FKbLABXyCIf9RR7Y+lEALlu9kFUwwih7HaA1hgXSZhKdznBJjt2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrXgEzjv1BE8gz7nS3Ds1XaNSeUaERRRWSWJ2k65MTY=;
 b=cLInkG5Uukk2ILYetO82znUt/fN8lGVdC//3G40ca1pyO0XrSWsPtRIzHWvjSQDT2SE/EKWY/Qxszph4377bw0Z1WnWYnytBMGhiDwS2E7ny0RdwQQszxts+LyP24bwCt3b+ebWQK3CLVKmFKRSUoYxSkZyFLR6DDliMH8Dm7MU=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (2a01:111:e400:c61b::7)
 by CY1PR04MB2380.namprd04.prod.outlook.com (2a01:111:e400:c618::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 9 Mar
 2020 00:07:16 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2986:c2cb:aa36:a25d]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2986:c2cb:aa36:a25d%8]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 00:07:16 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Thread-Topic: commit 01e99aeca397 causes longer runtime of block/004
Thread-Index: AQHV8c4FlOkNXDceTU6Nwl3i3vnr/Kg3y28AgAAoe4CAAD4PAIABAoQAgAAY5wCAAcm4AIAAI2yAgAEZ+QCAADV2gIAC382A
Date:   Mon, 9 Mar 2020 00:07:16 +0000
Message-ID: <20200309000715.sqgsssrauzmmpli2@shindev.dhcp.fujisawa.hgst.com>
References: <20200304023842.gu37d4mzfbseiscw@shindev.dhcp.fujisawa.hgst.com>
 <20200304034644.GA23012@ming.t460p>
 <20200304061137.l4hdqdt2dvs7dxgz@shindev.dhcp.fujisawa.hgst.com>
 <20200304095344.GA10390@ming.t460p>
 <20200305011900.2rtgtmclovmr2fbw@shindev.dhcp.fujisawa.hgst.com>
 <20200305024808.GA26733@ming.t460p>
 <20200306060622.t2jl7qkzvkwvvcbx@shindev.dhcp.fujisawa.hgst.com>
 <20200306081309.GA29683@ming.t460p>
 <20200307010222.gtrwivafqe2254i6@shindev.dhcp.fujisawa.hgst.com>
 <20200307041343.GB20579@ming.t460p>
In-Reply-To: <20200307041343.GB20579@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0f7a9a3-8c83-4f8d-1c05-08d7c3bdd3c8
x-ms-traffictypediagnostic: CY1PR04MB2380:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB2380BB5B06F2ABF0EB3BAA08EDFE0@CY1PR04MB2380.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(189003)(199004)(66946007)(1076003)(66556008)(66476007)(64756008)(26005)(8936002)(91956017)(76116006)(66446008)(8676002)(2906002)(81156014)(66574012)(966005)(186003)(478600001)(81166006)(6916009)(86362001)(71200400001)(44832011)(5660300002)(6506007)(6486002)(54906003)(6512007)(9686003)(316002)(4326008)(148743002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2380;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nw2UwtVX+njRVpFgO0Sogwqo/CMyV+3/MgHBSg4J9NW3D9Xyn6McEi+bjUBZbkMZLj7JQK8asjfkAA5qsKGmrEFshPNi2l1dMZZgrRroy2vMbJKwPKlZ7SAJRX8luexrFPB4UQr0TIkFMMCVS0u6DmeENEZWVBw17odmjhGfVc1Sssm67+QCnnxlHgoL+HWzpPBJHNiJtZ6s5IK1cOhaDQlAbZYzJoS3nlZP4Ux1jPHJrPR0+GGKWwnirFUpetTQcfpDgSW3Go909tRUZ/ZC/+JyLn0KyJKxD7E+EiTxgWn/dn1aDQmccxOPa3k6T4y76k4+UTJAc25Vc84tOXnrf3PFzx0vHRRLRrkjTAogFi3Kv60dwKVAsGEAr1gt4ks0h9m+b9fFhS+23Ic81cNVLqs6C0LQvrXJuaWmCPPZcd5Wg1d6eegTiLizHnxdCdxEv5nUUSeU2qmxv5jyGRAA8v+lMkgJRaAYi5+YD4wWeHHznCPbHHxHjlzyzC316N1jglSuf5PPdC05QEoBvn22XmNmGhCxbL5tw4U/Zjbh69t942PYQtn4AjdCZfu8wZx6f7kcEE0SDo/wQBzyYxS0OrGJULxf2CEZL2FV5J9MwCY=
x-ms-exchange-antispam-messagedata: 77GZ4NwxiEPue3t7QyqTGAoIvT+kaT8bE9P5+1Y6Yy9thFfhwKw9BACp3Fke4gOh+wOYSwcGY15HnC1FQZQCh5QVuJrTAPn055Bl3AnfOM1Gnrw4L1QgR4TGymQVeGZiK+gIDZ9eQp7j6UV7bcgmDQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D4050A94C81304E8459E55B08C9D903@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f7a9a3-8c83-4f8d-1c05-08d7c3bdd3c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 00:07:16.3887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyMyYoayd5z0Hsc5ihnKM6D5EnOxViwR8dB/7bvYXJPPbC3TC3gk6E4H7DXyIxUH+zqt44piz8hkrqeWXoNSVGdcZi/J64UjngLgF5FZjCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2380
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 07, 2020 / 12:13, Ming Lei wrote:
> On Sat, Mar 07, 2020 at 01:02:23AM +0000, Shinichiro Kawasaki wrote:
> > On Mar 06, 2020 / 16:13, Ming Lei wrote:
> > > On Fri, Mar 06, 2020 at 06:06:23AM +0000, Shinichiro Kawasaki wrote:
> > > > On Mar 05, 2020 / 10:48, Ming Lei wrote:
> > > > > Hi Shinichiro,
> > > > >=20
> > > > > On Thu, Mar 05, 2020 at 01:19:02AM +0000, Shinichiro Kawasaki wro=
te:
> > > > > > On Mar 04, 2020 / 17:53, Ming Lei wrote:
> > > > > > > On Wed, Mar 04, 2020 at 06:11:37AM +0000, Shinichiro Kawasaki=
 wrote:
> > > > > > > > On Mar 04, 2020 / 11:46, Ming Lei wrote:
> > > > > > > > > On Wed, Mar 04, 2020 at 02:38:43AM +0000, Shinichiro Kawa=
saki wrote:
> > > > > > > > > > I noticed that blktests block/004 takes longer runtime =
with 5.6-rc4 than
> > > > > > > > > > 5.6-rc3, and found that the commit 01e99aeca397 ("blk-m=
q: insert passthrough
> > > > > > > > > > request into hctx->dispatch directly") triggers it.
> > > > > > > > > >=20
> > > > > > > > > > The longer runtime was observed with dm-linear device w=
hich maps SATA SMR HDD
> > > > > > > > > > connected via AHCI. It was not observed with dm-linear =
on SAS/SATA SMR HDDs
> > > > > > > > > > connected via SAS-HBA. Not observed with dm-linear on n=
on-SMR HDDs either.
> > > > > > > > > >=20
> > > > > > > > > > Before the commit, block/004 took around 130 seconds. A=
fter the commit, it takes
> > > > > > > > > > around 300 seconds. I need to dig in further details to=
 understand why the
> > > > > > > > > > commit makes the test case longer.
> > > > > > > > > >=20
> > > > > > > > > > The test case block/004 does "flush intensive workload"=
. Is this longer runtime
> > > > > > > > > > expected?
> > > > > > > > >=20
> > > > > > > > > The following patch might address this issue:
> > > > > > > > >=20
> > > > > > > > > https://lore.kernel.org/linux-block/20200207190416.99928-=
1-sqazi@google.com/#t
> > > > > > > > >=20
> > > > > > > > > Please test and provide us the result.
> > > > > > > > >=20
> > > > > > > > > thanks,
> > > > > > > > > Ming
> > > > > > > > >
> > > > > > > >=20
> > > > > > > > Hi Ming,
> > > > > > > >=20
> > > > > > > > I applied the patch to 5.6-rc4 but I observed the longer ru=
ntime of block/004.
> > > > > > > > Still it takes around 300 seconds.
> > > > > > >=20
> > > > > > > Hello Shinichiro,
> > > > > > >=20
> > > > > > > block/004 only sends 1564 sync randwrite, and seems 130s has =
been slow
> > > > > > > enough.
> > > > > > >=20
> > > > > > > There are two related effect in that commit for your issue:
> > > > > > >=20
> > > > > > > 1) 'at_head' is applied in blk_mq_sched_insert_request() for =
flush
> > > > > > > request
> > > > > > >=20
> > > > > > > 2) all IO is added back to tail of hctx->dispatch after .queu=
e_rq()
> > > > > > > returns STS_RESOURCE
> > > > > > >=20
> > > > > > > Seems it is more related with 2) given you can't reproduce th=
e issue on=20
> > > > > > > SAS.
> > > > > > >=20
> > > > > > > So please test the following two patches, and see which one m=
akes a
> > > > > > > difference for you.
> > > > > > >=20
> > > > > > > BTW, both two looks not reasonable, just for narrowing down t=
he issue.
> > > > > > >=20
> > > > > > > 1) patch 1
> > > > > > >=20
> > > > > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > > > > index 856356b1619e..86137c75283c 100644
> > > > > > > --- a/block/blk-mq-sched.c
> > > > > > > +++ b/block/blk-mq-sched.c
> > > > > > > @@ -398,7 +398,7 @@ void blk_mq_sched_insert_request(struct r=
equest *rq, bool at_head,
> > > > > > >  	WARN_ON(e && (rq->tag !=3D -1));
> > > > > > > =20
> > > > > > >  	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
> > > > > > > -		blk_mq_request_bypass_insert(rq, at_head, false);
> > > > > > > +		blk_mq_request_bypass_insert(rq, true, false);
> > > > > > >  		goto run;
> > > > > > >  	}
> > > > > >=20
> > > > > > Ming, thank you for the trial patches.
> > > > > > This "patch 1" reduced the runtime, as short as rc3.
> > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > 2) patch 2
> > > > > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > > > > index d92088dec6c3..447d5cb39832 100644
> > > > > > > --- a/block/blk-mq.c
> > > > > > > +++ b/block/blk-mq.c
> > > > > > > @@ -1286,7 +1286,7 @@ bool blk_mq_dispatch_rq_list(struct req=
uest_queue *q, struct list_head *list,
> > > > > > >  			q->mq_ops->commit_rqs(hctx);
> > > > > > > =20
> > > > > > >  		spin_lock(&hctx->lock);
> > > > > > > -		list_splice_tail_init(list, &hctx->dispatch);
> > > > > > > +		list_splice_init(list, &hctx->dispatch);
> > > > > > >  		spin_unlock(&hctx->lock);
> > > > > > > =20
> > > > > > >  		/*
> > > > > >=20
> > > > > > This patch 2 didn't reduce the runtime.
> > > > > >=20
> > > > > > Wish this report helps.
> > > > >=20
> > > > > Your feedback does help, then please test the following patch:
> > > >=20
> > > > Hi Ming, thank you for the patch. I applied it on top of rc4 and co=
nfirmed
> > > > it reduces the runtime as short as rc3. Good.
> > >=20
> > > Hi Shinichiro,
> > >=20
> > > Thanks for your test!
> > >=20
> > > Then I think the following change should make the difference actually=
,
> > > you may double check that and confirm if it is that.
> > >=20
> > > > @@ -334,7 +334,7 @@ static void blk_kick_flush(struct request_queue=
 *q, struct blk_flush_queue *fq,
> > > >  	flush_rq->rq_disk =3D first_rq->rq_disk;
> > > >  	flush_rq->end_io =3D flush_end_io;
> > > > =20
> > > > -	blk_flush_queue_rq(flush_rq, false);
> > > > +	blk_flush_queue_rq(flush_rq, true);
> >=20
> > Yes, with this the one line change above only, the runtime was reduced.
> >=20
> > >=20
> > > However, the flush request is added to tail of dispatch queue[1] for =
long time.
> > > 0cacba6cf825 ("blk-mq-sched: bypass the scheduler for flushes entirel=
y")
> > > and its predecessor(all mq scheduler start patches) changed to add fl=
ush request
> > > to front of dispatch queue for blk-mq by ignoring 'add_queue' paramet=
er of
> > > blk_mq_sched_insert_flush(). That change may be by accident, and not =
sure it is
> > > correct.
> > >=20
> > > I guess once flush rq is added to tail of dispatch queue in block/004=
,
> > > in which lots of FS request may stay in hctx->dispatch because of low
> > > AHCI queue depth, then we may take a bit long for flush rq to be
> > > submitted to LLD.
> > >=20
> > > I'd suggest to root cause/understand the issue given it isn't obvious
> > > correct to queue flush rq at front of dispatch queue, so could you co=
llect
> > > the following trace via the following script with/without the single =
line
> > > patch?
> >=20
> > Thank you for the thoughts for the correct design. I have taken the two=
 traces,
> > with and without the one liner patch above. The gzip archived trace fil=
es have
> > 1.6MB size. It looks too large to post to the list. Please let me know =
how you
> > want the trace files shared.
>=20
> I didn't thought the trace can be so big given the ios should be just
> 256 * 64(1564).
>=20
> You may put the log somewhere in Internet, cloud storage, web, or
> whatever. Then just provides us the link.
>=20
> Or if you can't find a place to hold it, just send to me, and I will put
> it in my RH people web link.

I have sent another e-mail only to you attaching the log files gziped.
Your confirmation will be appreciated.

--=20
Best Regards,
Shin'ichiro Kawasaki=
