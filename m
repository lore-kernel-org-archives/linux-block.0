Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDD7C3F2D7
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 06:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E122072A
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 06:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kRyMULjD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="o4wbmgiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgCFGGb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Mar 2020 01:06:31 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62028 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgCFGGb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Mar 2020 01:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583474790; x=1615010790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gqt8MAuY8GyIFE4KWi7RPYaB2O606v2DB+r/xKLjY4I=;
  b=kRyMULjDpMEU/cUKPMY5IMSAiQbR0K0+rIohPpKa2J4eDTJvXBwtHIg+
   8n8XFPZNytTBECEdA9mRMyOsJ4eyN11qwrpahFIJzrHRwIT9eExYg91rz
   UPzf63ectZWKxmcTEM/CJPAsw56vWilkxGll0cMxj3rfHgWzqQEuvpK1M
   e7xeFrGvmiRTahARBE24HkwDraZRMa2x+FWpHob/0J1c3I50VtQZ+oE+0
   hueBm1I3Pq8NWMufG++C2VHtzeFG9KdJx9Kppat7oFvqAA9r55Z+FeShp
   MwNy5FJoqel3j0fhWBSUY3CuY9dIkBobiudkqkKEE7kdraPCXXOWQetyN
   w==;
IronPort-SDR: cZ6kSC8K6xDZqgXaBOWab1/FYNFGiOcQNsrP0/FRJxPKIgi8Edb4NCYdz0mBxuUhD0GXS3omL+
 LvIWH4U1sx4gNMosB+wWj8/Dij16H4vfneIH6R09c04cRilTx30QF2EH0iFnqGDFiGyyfO90ly
 2hZoneSXAk/xtDKt/w6QVeJthEPPQuqNfLCRZJQfAtPOe5egU8yZcYfaoTCCkxcDupNi+5cS2M
 So/9qZLmWGwnw+Eiu7UQ19DvisDHDrwUJxtEcKlAInxg5RxAvri485/srvUZTcrl7UKwpgUaPH
 MrE=
X-IronPort-AV: E=Sophos;i="5.70,521,1574092800"; 
   d="scan'208";a="132188328"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2020 14:06:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEk99GORZQYakQxKC4hPGEKk8gfGrGB0J+DLsFeBKUY+wwxzdn9k6ISBPUXQRkLxglZSAeVP07Ilpxb78k1b6ofOMddCb/myZSP/jKOVMWTijsbTpnSy0Sltwy+4+310zvl8YjX47mR4IqWesGbXUgIfumVLs003UyctfiumSsqgD/W8kwsw1024il7WkJ0Q2Oo8ITlW0eMy0BQ8hISM9E2SzBbyUbNjIPZbZYRsSU5glrAQUM6kMUqjQ6ay3csSrZBhDYJpEEHUm3+ZQ9DjtuFN8qBMjkPEgKafnEsXA0khJRAWudtFzlergKwubBBFV9E6JlRuj9KpiD7goOiodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ33yVtRNm8JiIDI4dwtTNTrtgi0KJZz0bIOr4WfsC4=;
 b=bOmI3F0EsA+haGJR62brkPW3Xo+tVot2mDiZ/m4ergVXMAzvb9E9JAgMY+905G9rlYdSSWpCob2tlCCR3UHWJVngTh2MInObNvakhRLN/R7OkoSB/+lauxgI9NIn5pCv4DqG3mdApaHc6fYePQBecw6w4tNzBN1E8GJdYw138wHxV0L4GtyPWdV1BcbZ8PFFVoihaYnH7DPtwm8tnJ825WlNOFvZSxlYWbVpqvjp4WzpUl9FipQUJsU1nzVwW8WTUTeo0oxlIMsjFUC5mmmxtrFpa1prCDTY539SJa4GbCHnmL/HnAXNpGPJ4pExbHGgmOeVdImPuLZdCeECYAEn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ33yVtRNm8JiIDI4dwtTNTrtgi0KJZz0bIOr4WfsC4=;
 b=o4wbmgiXoHqkt063CTNsjB/ZHFrcL0juwKIqbtxfxfM0tPmNogwb8L3tQmPYF6oEKQwKKrLKnR8p2NIN4zqlqjWZnRcCqOu7U96sGnitCnSa5NXszmXQpqRdSuCUC//lKcn9cAW9/Ae0ZF7D6l9MgM6OhoYS9ctckmocTQyzgWE=
Received: from BN3PR04MB2257.namprd04.prod.outlook.com
 (2a01:111:e400:7bb9::20) by BN3PR04MB2193.namprd04.prod.outlook.com
 (2a01:111:e400:7bb1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Fri, 6 Mar
 2020 06:06:23 +0000
Received: from BN3PR04MB2257.namprd04.prod.outlook.com
 ([fe80::58dc:d030:4975:3ac0]) by BN3PR04MB2257.namprd04.prod.outlook.com
 ([fe80::58dc:d030:4975:3ac0%6]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 06:06:23 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Thread-Topic: commit 01e99aeca397 causes longer runtime of block/004
Thread-Index: AQHV8c4FlOkNXDceTU6Nwl3i3vnr/Kg3y28AgAAoe4CAAD4PAIABAoQAgAAY5wCAAcm4AA==
Date:   Fri, 6 Mar 2020 06:06:23 +0000
Message-ID: <20200306060622.t2jl7qkzvkwvvcbx@shindev.dhcp.fujisawa.hgst.com>
References: <20200304023842.gu37d4mzfbseiscw@shindev.dhcp.fujisawa.hgst.com>
 <20200304034644.GA23012@ming.t460p>
 <20200304061137.l4hdqdt2dvs7dxgz@shindev.dhcp.fujisawa.hgst.com>
 <20200304095344.GA10390@ming.t460p>
 <20200305011900.2rtgtmclovmr2fbw@shindev.dhcp.fujisawa.hgst.com>
 <20200305024808.GA26733@ming.t460p>
In-Reply-To: <20200305024808.GA26733@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a948a573-adb0-43df-21dc-08d7c1947f98
x-ms-traffictypediagnostic: BN3PR04MB2193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN3PR04MB2193EB0F1DA9F361CCCDBB07EDE30@BN3PR04MB2193.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(2906002)(54906003)(316002)(86362001)(966005)(478600001)(64756008)(66476007)(66446008)(66556008)(5660300002)(66946007)(76116006)(91956017)(26005)(71200400001)(1076003)(186003)(44832011)(6512007)(9686003)(6486002)(6506007)(6916009)(4326008)(81166006)(81156014)(8676002)(8936002)(148743002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR04MB2193;H:BN3PR04MB2257.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+Dgr0m2y/DZ6we5BTNNoSF1F+DNZkaoOTAWDsKD0b+XT2cHgQdxgHsiZ4fR2FK+oJVNQ0TUTOr5ofiVX6Fa3Pv+Wg7Wb4/Kcpvy7IKtSpibeQaJsZgXBXMZsYuIMRrt8FRMBS/J2rd7TVYeLSRnGiPZgnvrZ14txovt6/q7csX4lffnKIpQL8xqBE+7F0dJYlM3lW7AmgQunlnNyY1Y5OT7hVROzziO6YHpAKJFvJ1K34fp365iQIJsr3ZO5LqyR1eCLh6+JN3Fj+d7tHB+4CxKuKOXhv7O2pOC6UxPJIFusB3odaWIMk6BXXD0thvy3YvLIdo0wHIdJJd+WpSvhQsXgQjFCpKA9p/eviH+u0iEkz9zLW8z9C5KcA9zjxLT/Yqeg9Bmvmneaub7PYyjY/iJ9zkb/oBaJdwPEkmyYNkm8uhed+7qRtk0gPCtNGc/EF/eFN/2jOkG4r9QRYrtK1Kiwh9U7U8sDAnMY69azxpGdwlttR576aibiZnsMqpkvpK+HyN4Qm46quV+R7/NhiqlkPVnNVMuHcQ4qQMbBgKxBPrGo+Xk6W63OVUVFVDPowNIfVqqDYWG9XBZt0Fk3kYqUfr+453J4TB1IRu5thE=
x-ms-exchange-antispam-messagedata: BvHSFDHhvm6eJblv6/HopkVhF2qPQIA0OWc0eVioVGwUileucMD1TKDlA2CLEdrEhGQ7+oz/zS9O2pXtrw+bXi6n1bEAe1Me9e79TDK6a3don/SXbMS5N3j/EjW6PQXeOkUQXLbsdTQn+o9KRMFV/w==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B9AC1514D81B74B8F76E362B118C768@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a948a573-adb0-43df-21dc-08d7c1947f98
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 06:06:23.3422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJm0Hfm94VafhQ9UFnUADtn5jFvLXMJQkvYancjXZPJ6OwxkBSMmlxV4NdWgNq8dKMCGz0QDVKtASs0OZ6eo5B4KsYHlKCQPdMCPnzJ5lUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2193
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 05, 2020 / 10:48, Ming Lei wrote:
> Hi Shinichiro,
>=20
> On Thu, Mar 05, 2020 at 01:19:02AM +0000, Shinichiro Kawasaki wrote:
> > On Mar 04, 2020 / 17:53, Ming Lei wrote:
> > > On Wed, Mar 04, 2020 at 06:11:37AM +0000, Shinichiro Kawasaki wrote:
> > > > On Mar 04, 2020 / 11:46, Ming Lei wrote:
> > > > > On Wed, Mar 04, 2020 at 02:38:43AM +0000, Shinichiro Kawasaki wro=
te:
> > > > > > I noticed that blktests block/004 takes longer runtime with 5.6=
-rc4 than
> > > > > > 5.6-rc3, and found that the commit 01e99aeca397 ("blk-mq: inser=
t passthrough
> > > > > > request into hctx->dispatch directly") triggers it.
> > > > > >=20
> > > > > > The longer runtime was observed with dm-linear device which map=
s SATA SMR HDD
> > > > > > connected via AHCI. It was not observed with dm-linear on SAS/S=
ATA SMR HDDs
> > > > > > connected via SAS-HBA. Not observed with dm-linear on non-SMR H=
DDs either.
> > > > > >=20
> > > > > > Before the commit, block/004 took around 130 seconds. After the=
 commit, it takes
> > > > > > around 300 seconds. I need to dig in further details to underst=
and why the
> > > > > > commit makes the test case longer.
> > > > > >=20
> > > > > > The test case block/004 does "flush intensive workload". Is thi=
s longer runtime
> > > > > > expected?
> > > > >=20
> > > > > The following patch might address this issue:
> > > > >=20
> > > > > https://lore.kernel.org/linux-block/20200207190416.99928-1-sqazi@=
google.com/#t
> > > > >=20
> > > > > Please test and provide us the result.
> > > > >=20
> > > > > thanks,
> > > > > Ming
> > > > >
> > > >=20
> > > > Hi Ming,
> > > >=20
> > > > I applied the patch to 5.6-rc4 but I observed the longer runtime of=
 block/004.
> > > > Still it takes around 300 seconds.
> > >=20
> > > Hello Shinichiro,
> > >=20
> > > block/004 only sends 1564 sync randwrite, and seems 130s has been slo=
w
> > > enough.
> > >=20
> > > There are two related effect in that commit for your issue:
> > >=20
> > > 1) 'at_head' is applied in blk_mq_sched_insert_request() for flush
> > > request
> > >=20
> > > 2) all IO is added back to tail of hctx->dispatch after .queue_rq()
> > > returns STS_RESOURCE
> > >=20
> > > Seems it is more related with 2) given you can't reproduce the issue =
on=20
> > > SAS.
> > >=20
> > > So please test the following two patches, and see which one makes a
> > > difference for you.
> > >=20
> > > BTW, both two looks not reasonable, just for narrowing down the issue=
.
> > >=20
> > > 1) patch 1
> > >=20
> > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > index 856356b1619e..86137c75283c 100644
> > > --- a/block/blk-mq-sched.c
> > > +++ b/block/blk-mq-sched.c
> > > @@ -398,7 +398,7 @@ void blk_mq_sched_insert_request(struct request *=
rq, bool at_head,
> > >  	WARN_ON(e && (rq->tag !=3D -1));
> > > =20
> > >  	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
> > > -		blk_mq_request_bypass_insert(rq, at_head, false);
> > > +		blk_mq_request_bypass_insert(rq, true, false);
> > >  		goto run;
> > >  	}
> >=20
> > Ming, thank you for the trial patches.
> > This "patch 1" reduced the runtime, as short as rc3.
> >=20
> > >=20
> > >=20
> > > 2) patch 2
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index d92088dec6c3..447d5cb39832 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -1286,7 +1286,7 @@ bool blk_mq_dispatch_rq_list(struct request_que=
ue *q, struct list_head *list,
> > >  			q->mq_ops->commit_rqs(hctx);
> > > =20
> > >  		spin_lock(&hctx->lock);
> > > -		list_splice_tail_init(list, &hctx->dispatch);
> > > +		list_splice_init(list, &hctx->dispatch);
> > >  		spin_unlock(&hctx->lock);
> > > =20
> > >  		/*
> >=20
> > This patch 2 didn't reduce the runtime.
> >=20
> > Wish this report helps.
>=20
> Your feedback does help, then please test the following patch:

Hi Ming, thank you for the patch. I applied it on top of rc4 and confirmed
it reduces the runtime as short as rc3. Good.

--=20
Best Regards,
Shin'ichiro Kawasaki

>=20
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 5cc775bdb06a..68957802f96f 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -334,7 +334,7 @@ static void blk_kick_flush(struct request_queue *q, s=
truct blk_flush_queue *fq,
>  	flush_rq->rq_disk =3D first_rq->rq_disk;
>  	flush_rq->end_io =3D flush_end_io;
> =20
> -	blk_flush_queue_rq(flush_rq, false);
> +	blk_flush_queue_rq(flush_rq, true);
>  }
> =20
>  static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d92088dec6c3..56d61b693f2e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -724,6 +724,8 @@ static void blk_mq_requeue_work(struct work_struct *w=
ork)
>  	spin_unlock_irq(&q->requeue_lock);
> =20
>  	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
> +		bool at_head =3D !!(rq->rq_flags & RQF_SOFTBARRIER);
> +
>  		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
>  			continue;
> =20
> @@ -735,9 +737,9 @@ static void blk_mq_requeue_work(struct work_struct *w=
ork)
>  		 * merge.
>  		 */
>  		if (rq->rq_flags & RQF_DONTPREP)
> -			blk_mq_request_bypass_insert(rq, false, false);
> +			blk_mq_request_bypass_insert(rq, at_head, false);
>  		else
> -			blk_mq_sched_insert_request(rq, true, false, false);
> +			blk_mq_sched_insert_request(rq, at_head, false, false);
>  	}
> =20
>  	while (!list_empty(&rq_list)) {
>=20
> Thanks,
> Ming
> =
