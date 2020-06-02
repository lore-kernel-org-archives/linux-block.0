Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7624C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB47620679
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h/VRCzK0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZLU5WgtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgFBJjV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:39:21 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22760 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgFBJjU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 05:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591090760; x=1622626760;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fOyFT10CbG5ywGEa5eC+F4dtnkGGuqp056pGKoRYP3c=;
  b=h/VRCzK0E2kS3OJuz3y3MIPsNw/QktTu82pGBhkTEOM1w4XouRqCs79p
   pdtXZffNVaQ0NhFmzp+Sxzs+pq0Ixf0+cGU4a1bgCkchmn9VowlfziG5/
   agURiyita8KCkQb1MI8NfOMELDvRXzTvg3RKfauuxtMr2fiWZC+fgR6iM
   5rOev/RoTonMy9BoSBMlihgL61FC/rPPi0rAXW+mmijZO1uyZQOqh9+nR
   vG5uQlooLfeiUgE4r5UOAIinUAOMGl+CUJHDNcaegYKu6Rjz9+kELsA3D
   LBEtMEUsLve8nu8HPEaBd8PFcgGOK4Exh6MFQ0+F4eIp3KXG6p/9htsYQ
   w==;
IronPort-SDR: EZ3+WvXM0Dw0ikOA1aSy4mbJ0NS9vq3jGmX9gqNeJHHdk36uzq7guDYHW/GkWrDDaXOJr8LkeI
 +qvU+xH872cv+rVOJMgC72/uh2041pX49NqCNhbHXBL6cyvJgKKtYcqTToCvDffMz7I2dA3e+5
 qZeuneTR9FizrIQekaATHIEwiEgD47kuuVrfmsQL4/Ben4jMbHA9/jiwUGbAezAdZLTwbTbKDK
 NQdOWGrWyOnYXHSaUqFF1a3eay3NidZGHWsPe/bOGe45/xcIufAiKheiAXJ8sYhHeP1+c8i/2o
 H88=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="140439138"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 17:39:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU0PMR0S/WMinAbp8qZJrJGpaGwTr/T17GNPOmKV+bIN3MCBhTVu/JCQSvf3rJQNxwFEC2RABtoYCstMZjmfqNpYmQiynJVI4skrY/XF7N7ddRhX18lSgw4uCeG5XoZwkTjQ9GC9feIybpfVO6kZr1Fe8OScqWbDM15dYwbz4LeTqJ/8SF7sL9uFfL6lB8NpDxjAywUGLKAq+pGWqcLEcfau3AhB6W095Ekk9RJMMzyGTb/ObOxe3kyVDe1Fv18njoI7Scq7RtkRrCoWZPspoRjrqxxcr1GjACsucTXUCStSRLOb7VO1Ml/a60Tr7McTUjHFNRt1cYZq4y/lzLe19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89KvetaDkQ5tiH+CFCHtaNk8RvWljtlAlzk9DVPJAAU=;
 b=EfQV1aWqP8bcS+YUzrr/2N8O3caDQR9bw66Kw0gGxThhgLyw+Jiyl21ao0Ng3AhG1bKI/hBUXqOdRZS4n+xYVAQYu4R7noWo7R9xNPsGHPXx1dXsLtPnNDY4+R/c767tguBv+db57czB8/+rMpPHVnAs8c9z7bwKnK00rC95r70wMB7109IxR9gf9xZ7Flb4pi+EqtShQBv4EIQO/Is3bbzoHVPF+XNMUpSrCy/HopfCIPTBvXBGOOJjpGsemGmuRiO0J+oSuYwzbbQuFs2/C3cQxQa5Ti7STB5E+TkBmqG7RzOPxpyUVk0HRqdMLDwS8KrmpjiJ+O0AJAjkxnhanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89KvetaDkQ5tiH+CFCHtaNk8RvWljtlAlzk9DVPJAAU=;
 b=ZLU5WgtRGGoD8UyJdoQ0cgv9gz0ATxBt3V0USmATsgtu9N3gm6OU5dE6j0zpUZgD6WaZROcKdttKguA7+/CoebynFb+teesAbz3Ps5q+OAPtdWln8DPpz7JfQeS4IKobKg51lxL967QtdDlS81C8bcMGH+5jn7stfDomWrdi2W8=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0823.namprd04.prod.outlook.com (2603:10b6:903:e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 09:39:18 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 09:39:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V4 2/6] blk-mq: pass hctx to blk_mq_dispatch_rq_list
Thread-Topic: [PATCH V4 2/6] blk-mq: pass hctx to blk_mq_dispatch_rq_list
Thread-Index: AQHWOL5iseEcgxJkNk6kYf4/2sZnyQ==
Date:   Tue, 2 Jun 2020 09:39:18 +0000
Message-ID: <CY4PR04MB375131F4C9F24369D00D0F3CE78B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200602091502.1822499-1-ming.lei@redhat.com>
 <20200602091502.1822499-3-ming.lei@redhat.com>
 <CY4PR04MB37517114D6BD53D212D8F0B2E78B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200602093220.GE1384911@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 048f196c-9cf8-4e70-dac8-08d806d8d233
x-ms-traffictypediagnostic: CY4PR04MB0823:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB082347FE768DAB3A3DC5747AE78B0@CY4PR04MB0823.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HJ8gFvXbit9Vd6PhE76XHriDOZfF2ikB9M6cjbFk3Dt3t+DBAEVK4q+0xUbWfxFvCD/u4MlDfD3vI1L5ckSzo662coE4EEHt/jJTWFiWhb+RXR8zKZUrc8r3R1sXOtm7WVFeZfLgtVqQRel2MYbK5vq5kS2ezEs3drW6tD542xuDlmXFw++C4oQ0CiQ0BBQBrz6aIZk8+IqDi50wo22v+3Yhx9/EVICi2UFTnRD9895gEjY0bdI+Llv5kaikkiTK8Yxp+kswzloEiptdRTNnSkqZxUzxn4kIn91PuB6qoZXjYhtN6aJ+13l/z3d1OgEl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(8936002)(52536014)(64756008)(66556008)(66476007)(66446008)(55016002)(5660300002)(26005)(9686003)(53546011)(6506007)(71200400001)(83380400001)(6916009)(8676002)(7696005)(54906003)(86362001)(478600001)(66946007)(33656002)(76116006)(91956017)(4326008)(316002)(186003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7Do318BQiRO9kR+WlbTbyH3pH9Xi4qKEhcVUMSBihxNdLdrTOyxGBwQ+JZ90HD5SkDEDFigy1lepYAXBm4HWERWu9vWpP2F7a+qE7gik48ZxO4Fmy4IB/6AZK+NKX8pac1eQGcZVJQikC6gGRtuqfazCOzSh0nRSbFKxsiNNtO5gaK12vQn5JAz1pb2Qm1/BZY2hPehZnYx6ezUo0T1dkhvPJFiCR/DWl+GDIvt9HxFrFVwmhXmTA3/CKIyzLIMLxQnE+oo7qUvQTH0ir8MSu+GUhPFP9Xfye/sip6l8N3ABWI9wEsdobLuh0+ov31kkDsWF8Psf7iQb/3jBSEgZafISsgAo+OILtYX318F2ZkTyj3ZuJsCVAZDh5k+FagZAPzQoqJBwV32e62BkEEwXScHQP94GmuhNL2+mUZrhqhrYxEoqPPmSoaZ20UaE9pOXA/qT2wVkx6IiZdhNpeRiBjZVlPTCXJL5ewQNrid3Z9ZJM2kO5yCH2Rh9cmIpXMVa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048f196c-9cf8-4e70-dac8-08d806d8d233
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 09:39:18.0792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfRQDtdCKSApPX2Y5fR0IHPfMpWe37mggUZuE1z1rByxXRh/kK3EpjKNsdZRcJ/deOdZFysAlVXH844PRQxxgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0823
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/02 18:32, Ming Lei wrote:=0A=
> On Tue, Jun 02, 2020 at 09:25:01AM +0000, Damien Le Moal wrote:=0A=
>> On 2020/06/02 18:15, Ming Lei wrote:=0A=
>>> All requests in the 'list' of blk_mq_dispatch_rq_list belong to same=0A=
>>> hctx, so it is better to pass hctx instead of request queue, because=0A=
>>> blk-mq's dispatch target is hctx instead of request queue.=0A=
>>>=0A=
>>> Cc: Sagi Grimberg <sagi@grimberg.me>=0A=
>>> Cc: Baolin Wang <baolin.wang7@gmail.com>=0A=
>>> Cc: Christoph Hellwig <hch@infradead.org>=0A=
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
>>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>=0A=
>>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>> Tested-by: Baolin Wang <baolin.wang7@gmail.com>=0A=
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
>>> ---=0A=
>>>  block/blk-mq-sched.c | 14 ++++++--------=0A=
>>>  block/blk-mq.c       |  6 +++---=0A=
>>>  block/blk-mq.h       |  2 +-=0A=
>>>  3 files changed, 10 insertions(+), 12 deletions(-)=0A=
>>>=0A=
>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c=0A=
>>> index a31e281e9d31..632c6f8b63f7 100644=0A=
>>> --- a/block/blk-mq-sched.c=0A=
>>> +++ b/block/blk-mq-sched.c=0A=
>>> @@ -96,10 +96,9 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw=
_ctx *hctx)=0A=
>>>  	struct elevator_queue *e =3D q->elevator;=0A=
>>>  	LIST_HEAD(rq_list);=0A=
>>>  	int ret =3D 0;=0A=
>>> +	struct request *rq;=0A=
>>>  =0A=
>>>  	do {=0A=
>>> -		struct request *rq;=0A=
>>> -=0A=
>>>  		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))=0A=
>>>  			break;=0A=
>>>  =0A=
>>> @@ -131,7 +130,7 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_h=
w_ctx *hctx)=0A=
>>>  		 * in blk_mq_dispatch_rq_list().=0A=
>>>  		 */=0A=
>>>  		list_add(&rq->queuelist, &rq_list);=0A=
>>> -	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));=0A=
>>> +	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true));=0A=
>>=0A=
>> Why not use the hctx argument passed to the function instead of rq->mq_h=
ctx ?=0A=
> =0A=
> e->type->ops.dispatch_request(hctx) may return one request which's=0A=
> .mq_hctx isn't same with the 'hctx' argument, so far bfq and deadline=0A=
> may do that.=0A=
=0A=
Ah, OK. But then all requests in rq_list may have different hctx. So is it =
wise=0A=
to pass hctx as an argument to blk_mq_dispatch_rq_list() ? The loop in that=
=0A=
function will still need to look at each rq hctx (hctx =3D rq->mq_hctx) for=
 the=0A=
budget. So the hctx argument may not be needed at all, no ? Am I missing so=
mething ?=0A=
=0A=
> =0A=
> =0A=
> Thanks,=0A=
> Ming=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
