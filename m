Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3668C3F2CE
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 01:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C7C2084E
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 01:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qDH9CGLa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lBM9DXyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgCEBTF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:19:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19690 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgCEBTE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 20:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583371144; x=1614907144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H0zZLTJOP1Fcyk3XMVXeq14S3t7OGgFUBijuH08Wdsg=;
  b=qDH9CGLaIFWaSY9oOAQaONZbyVoAf1swBzLHrCItpBpTBFTSkTn++DUi
   tysLxf8IHA0yPDxEUixsABRLuyCGAG9ebQNm6h+gLUH1+zZyWNMk3QxGt
   p9NJu+6beyyiUvSGRRVTPrqW7blXHzHAQH1J71WqKQt6974tbSGKfiLE1
   BxYLimGqCtydKjPwpzYT/xrAMoldxLAnNRDYVDAcB21DpXCvCa07YevZD
   ilLcJCe/p9LPUnUjQTlx01YZc2kGe5wFxIsbeKroQHB3kCvMxUHZA+vNF
   dK4EHFMqEdzvx3/3Nav8JnhZ0enTRDdMrJPUuXbfF5rtAQG49apNhRp1U
   w==;
IronPort-SDR: fOaMJrgkkEVuqEIH8rBJVdcQpCFgqTEyydS9VIQEjOF0qPGsajf9XEi4eE9CkpAjgz68k1N1ym
 J9FS/pHoL6X6ytBxC/bYMbxBw5alFPZLJSqsPVdl8xFWzZACvFHmafM6pYI25RUM2OlgNQv357
 sV1EIOINKPeohJuh8cVkZISWxBvxLBij6H0bhZnd51mhWZahPtaGBk54/hCYM4LkOeas47BIfd
 Ovb9V+xk2ZFY9CfCDBenXAExKEYMPaFbJasPgTO5gVmmb38odu5TCCKfRCsKT5Fi7uAMJEnJBU
 5AQ=
X-IronPort-AV: E=Sophos;i="5.70,516,1574092800"; 
   d="scan'208";a="131491051"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2020 09:19:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrmvF09QwsQ64l8r30A8GYI5OQMGobvr3gNnIWyrz4UBlN2QWDjBs2Q6I49/yWOk+WFRHAOqwuAeI7n6aVSBllmrisVI+e1GJvwOVyL73FZAkwK8sq1SBP/UujtF0PrYzBzVoTZScxKR0orWzMoD5HgK49AfxZh63QrINfX4OGWNNBJ9qqHZ0KBdtbIt8mH5Sf3mgV3O4TrGIjqcRZb6dRjSc1qkNQfevRHXm0gfuBVINzaVEq5umYBFSg5rIfaYa6BplWudh6U4ooKO4zPTK6f4H8DMfx93Wau7umHqmsToO9bdlm8v84B0PVsW+TmRvC82EwK+CIRu+ASbIaJKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qU9pPV1RG+Zpie1DKnsWhnKx0mYsJfFw+1YyVVQ2KM=;
 b=KXk5m5ZsKnSxeKNy9KRTqiAM6XwAnW7yJw+YlVW38Nnv2YBIkjuRJr5CZjqkvLC2LkK44Taw3YCMrRxtv0VVLMYJeWem0sjTDbPM+mndEuN1Q+CowuylUdb0Uh0CTrp9YSYsxY+Vbw3+vc2CWqCzs4kFgrIehpNa2XkSIV2cFAEcNzwGOl6fiiHlRSWrknQz1y0WVq8RjxtT2/TgzEb2Zj1IW/kxLIN9mdsVlvISS9eDSB+FRozfCMmQXXNOuWjVdvFZQCl6nTkkX0W2yCxiHdQnaruJXLxkjP8yewcj9b44P8Qg4tavLyWdWYh7OLjFxQV7/orB12WAVJSp/VZI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qU9pPV1RG+Zpie1DKnsWhnKx0mYsJfFw+1YyVVQ2KM=;
 b=lBM9DXyZY8yn+3J8lQOtGz5zdmaURL8Sn1GmDdv27LGfQGlKpUq1afAm9yTXpZSfQmrpB8Qcz/ZsznOeYSG42qhiPKr/a3Cj78zB4XN91Y1gu9D4fQLpel4kYeTG5ddDlBmeKqFu9DyF3fmaAG8VsZ9Cwc7bTAvo8yWSlGcAL0s=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (2a01:111:e400:c61b::7)
 by CY1PR04MB2234.namprd04.prod.outlook.com (2a01:111:e400:c636::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 01:19:02 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2dad:bbd2:9457:ed3e]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::2dad:bbd2:9457:ed3e%9]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 01:19:02 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Thread-Topic: commit 01e99aeca397 causes longer runtime of block/004
Thread-Index: AQHV8c4FlOkNXDceTU6Nwl3i3vnr/Kg3y28AgAAoe4CAAD4PAIABAoQA
Date:   Thu, 5 Mar 2020 01:19:02 +0000
Message-ID: <20200305011900.2rtgtmclovmr2fbw@shindev.dhcp.fujisawa.hgst.com>
References: <20200304023842.gu37d4mzfbseiscw@shindev.dhcp.fujisawa.hgst.com>
 <20200304034644.GA23012@ming.t460p>
 <20200304061137.l4hdqdt2dvs7dxgz@shindev.dhcp.fujisawa.hgst.com>
 <20200304095344.GA10390@ming.t460p>
In-Reply-To: <20200304095344.GA10390@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6dc455f7-e251-4e0d-d65c-08d7c0a330d6
x-ms-traffictypediagnostic: CY1PR04MB2234:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB2234E3C8EC57E6D280E2FCB4EDE20@CY1PR04MB2234.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(1076003)(66476007)(71200400001)(966005)(2906002)(478600001)(76116006)(66446008)(91956017)(66946007)(186003)(26005)(64756008)(6916009)(66556008)(8676002)(81156014)(4326008)(54906003)(9686003)(6512007)(6486002)(5660300002)(6506007)(86362001)(81166006)(316002)(44832011)(8936002)(148743002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2234;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sSS4F6eEkv1K9Zk61/XrVoJXZ2QQFll6LjDXdSo13M6Sac5w/3yikF93hASCwDT5eRc+lO1OvEwK5EFZhK2KN2QzRJjwPPxroL3AIOaXSR37JNxqSguOtg7+eBc7Pv45cpQJNrViz6iXoForNzeOE0Jxd5g+NSiEGiPDD84U9xMleUPrQpNYa0MT+yEa9/MgEoFSYYYM0DlkwAX5LCjsK2tcrcyNH2BsHcVp5U1mlgfRvzU1yZJyykbrUcUJaz+zhmwcL5VUPJMtDvbqCw94iMZwPP1t26SCwLowz5fZjZaPq0rDVKnfhwxWDxiwn69LzfYfz+dicg8aWFQp45M/y1VX7cKRpQDs0BxR4FVPnza0VGfsUfMzv5ZihMcdGEEQDCzgDNDkmZvkg5D4aZUnYFPG0TGGuF44fAEzXce9Mw91O0ZSsve7Xud2bolpSiuAH1kWbf4qlwqn76MxkKNlDAfdWmURZg1Zb5MvaBYjpvlD8quYtq8k3kk5uKxGgNY5NBpHZbl0AeDttfoPO0v45Y0TPOHLNcSPdL0o7mFnUlGo0VUBmyMjkqC22CQ5fAdo2bPYXBvVhw6SoX+okfU1DWAz9GSvfTOm17cRaK9AVU8=
x-ms-exchange-antispam-messagedata: Ny6C/vRW/mql7sRdwwS88kUFTVecBQ8GVU9NIE2qCbT5iLTNHBcFczPIpa1vfLjiyGJtWf7YKaKQYXOEBYWJE89CpAY85ZCzDAZZSth2Ni7HK/I/lamURPv+Lw7kNeCppyK1pSocPFEH/G/toFnmAw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB81212300D59C469C1B29F6A46A4C08@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc455f7-e251-4e0d-d65c-08d7c0a330d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 01:19:02.6513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OAJizJiJxihWbgWj0Ma3uXn/oubBFCv/BMPz4DAAkYMePV/T9IJhR2OM6sVKYGJDf52itypGuGotQb3GJwuTqxcS9cndspJ38MMP9xbxrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2234
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 04, 2020 / 17:53, Ming Lei wrote:
> On Wed, Mar 04, 2020 at 06:11:37AM +0000, Shinichiro Kawasaki wrote:
> > On Mar 04, 2020 / 11:46, Ming Lei wrote:
> > > On Wed, Mar 04, 2020 at 02:38:43AM +0000, Shinichiro Kawasaki wrote:
> > > > I noticed that blktests block/004 takes longer runtime with 5.6-rc4=
 than
> > > > 5.6-rc3, and found that the commit 01e99aeca397 ("blk-mq: insert pa=
ssthrough
> > > > request into hctx->dispatch directly") triggers it.
> > > >=20
> > > > The longer runtime was observed with dm-linear device which maps SA=
TA SMR HDD
> > > > connected via AHCI. It was not observed with dm-linear on SAS/SATA =
SMR HDDs
> > > > connected via SAS-HBA. Not observed with dm-linear on non-SMR HDDs =
either.
> > > >=20
> > > > Before the commit, block/004 took around 130 seconds. After the com=
mit, it takes
> > > > around 300 seconds. I need to dig in further details to understand =
why the
> > > > commit makes the test case longer.
> > > >=20
> > > > The test case block/004 does "flush intensive workload". Is this lo=
nger runtime
> > > > expected?
> > >=20
> > > The following patch might address this issue:
> > >=20
> > > https://lore.kernel.org/linux-block/20200207190416.99928-1-sqazi@goog=
le.com/#t
> > >=20
> > > Please test and provide us the result.
> > >=20
> > > thanks,
> > > Ming
> > >
> >=20
> > Hi Ming,
> >=20
> > I applied the patch to 5.6-rc4 but I observed the longer runtime of blo=
ck/004.
> > Still it takes around 300 seconds.
>=20
> Hello Shinichiro,
>=20
> block/004 only sends 1564 sync randwrite, and seems 130s has been slow
> enough.
>=20
> There are two related effect in that commit for your issue:
>=20
> 1) 'at_head' is applied in blk_mq_sched_insert_request() for flush
> request
>=20
> 2) all IO is added back to tail of hctx->dispatch after .queue_rq()
> returns STS_RESOURCE
>=20
> Seems it is more related with 2) given you can't reproduce the issue on=20
> SAS.
>=20
> So please test the following two patches, and see which one makes a
> difference for you.
>=20
> BTW, both two looks not reasonable, just for narrowing down the issue.
>=20
> 1) patch 1
>=20
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 856356b1619e..86137c75283c 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -398,7 +398,7 @@ void blk_mq_sched_insert_request(struct request *rq, =
bool at_head,
>  	WARN_ON(e && (rq->tag !=3D -1));
> =20
>  	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
> -		blk_mq_request_bypass_insert(rq, at_head, false);
> +		blk_mq_request_bypass_insert(rq, true, false);
>  		goto run;
>  	}

Ming, thank you for the trial patches.
This "patch 1" reduced the runtime, as short as rc3.

>=20
>=20
> 2) patch 2
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d92088dec6c3..447d5cb39832 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1286,7 +1286,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *=
q, struct list_head *list,
>  			q->mq_ops->commit_rqs(hctx);
> =20
>  		spin_lock(&hctx->lock);
> -		list_splice_tail_init(list, &hctx->dispatch);
> +		list_splice_init(list, &hctx->dispatch);
>  		spin_unlock(&hctx->lock);
> =20
>  		/*

This patch 2 didn't reduce the runtime.

Wish this report helps.

--=20
Best Regards,
Shin'ichiro Kawasaki=
