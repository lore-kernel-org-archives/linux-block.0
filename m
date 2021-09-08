Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8931CC433F5
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 11:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6516561108
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 11:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349287AbhIHL6g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Sep 2021 07:58:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47807 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344680AbhIHL6g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Sep 2021 07:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631102248; x=1662638248;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=poDgVJLDxKjSrAUVwOs2jQvnllmxtDomFYFvF2HaSGk=;
  b=Jl82IiyAUO5vwKYaDD+4BqUuiM9GjMk+PG2HATyPRd0Mwbkbyk2Jy1VK
   peyiPLiMunnwKtOnRdnhPyv1Atuq/gvyStz18sjcj9oz0IWDP8oZf+X4V
   ncDKvk9xW4+q9+YUk4w0cN3mVIh5wAqsG8IAhLGRjG/WaCxnrYdR0WXEH
   pbWD/CQlAPQExiAdR2S8Dr4kSzwjvSJuDBeyQ1i5S5SEq2XIKInw/0F9s
   rMUnfRhOOSIe0iDUfjBrMDiHQcUUQJspdb3WJ+frb0NZ6GAiD5Szmllph
   P5feL1ha5U3sjTOc6xbEZUV2qK/TL+VK0CclVe4W9SocE4fp/FWV0XI/x
   A==;
X-IronPort-AV: E=Sophos;i="5.85,277,1624291200"; 
   d="scan'208";a="179469233"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2021 19:57:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9FX8xOKbC8NgClp5L+GV/XeVyeyHNP1KnEk/CPmDrSG1HA6+1eVANAtys3ajf9Rd/6J6doAO7s+JKKZFCbJw4VPAGc0+5wpVZlzyVYdB9tIe8UDqACKLujpz09wddsAuwy62T8muGSfVnWAXpWQr832s1Ee/DA2kIqbDUZBIy8NNCSxo970x6Hr/eYhd1Ln/dFjjIxBHmmEMeXBntsIASZauGeMbWs6KO7piDbMFxN/1RPiMSZT7BI1JAd0ztNOBPXW5okBDsGPJb/GglgHdlXTN02g7QVDTPDvL6R3vSsXduB+Ylath4W8+iHmvj96QAB7AovVBtcbI8p4Rc2j3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=poDgVJLDxKjSrAUVwOs2jQvnllmxtDomFYFvF2HaSGk=;
 b=EKmsodOWDyzqGKiFYxfz4NzrEicF8T+XIHxnicxd/a6gOXLKAm7dtZIFaFmCboIqk21q8+B+Zp6lK4VUUs6Dk+LiD38Jz1XqljEZpqM9r+3qWOjqovGWX33/f2oq27GDg3j22Wyzj+1geMGjbVMDrhXC7iRoD/adKqQpoVW9r/cOcjOmmcLhdYqVN4n+QCvt2Gsx5aVTUm3CQQRd7fplkgMxKC474SftO/zscISf74f3ba9S3pCsPPbF7LFJJTduj2/Tuz2psHXQd3WOJKYD0hGdNwbiGQ+45FHudnNltbKgyKzLtu4jYu+7I/ruBDNgE9SFZiEJaOCElRXaUdFQfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poDgVJLDxKjSrAUVwOs2jQvnllmxtDomFYFvF2HaSGk=;
 b=Jpe1BqxS3IPcxH00fUnSQ92x98kmwXXKJmJnt2TXs8PhQESuypXjWEQC0zejCSGr8GlrJ/drugkZ467bS9uvi4gDgXo0vRiwKWXGsF1iam8laC+QKBU2DNe1m9MQAzBmWdZpIY70WahHkRCkwUT+Zd5PPfLFxaQcEM5Zaft27I0=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7383.namprd04.prod.outlook.com (2603:10b6:510:13::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 11:57:26 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%6]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 11:57:26 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Revert "mq-deadline: Fix request accounting"
Thread-Topic: [PATCH 2/2] Revert "mq-deadline: Fix request accounting"
Thread-Index: AQHXo/O2L+LBuS/YJECb1WaT3ju4YKuYrlyAgAAUmwCAAAxMgIABOjaA
Date:   Wed, 8 Sep 2021 11:57:26 +0000
Message-ID: <YTilJQ4sQ3dSnev+@x1-carbon>
References: <20210907142145.112096-1-Niklas.Cassel@wdc.com>
 <20210907142145.112096-3-Niklas.Cassel@wdc.com>
 <fdd5ab2a-af90-69bd-2d37-c5060ce68de4@acm.org> <YTeTQGrw41k08hgf@x1-carbon>
 <55fca3f4-4ed0-fd56-3069-c0ab343b2aed@acm.org>
In-Reply-To: <55fca3f4-4ed0-fd56-3069-c0ab343b2aed@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 983fe865-eead-4ead-e5c9-08d972bfd3a3
x-ms-traffictypediagnostic: PH0PR04MB7383:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7383E9DB01BB20ED982398D6F2D49@PH0PR04MB7383.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ouDGHgc1RYS/n7R5/Fo4uIvaUzdOmvHDpavJTthWh+J88BZWhwQnFy/bwIoOUuVlqhVUQvrFtJbm63LDxHKCTshVFgB7V9PY5ma6pqqdCtengbUIOwjRr4cJJhSnb2nOwjGsCeneT+rsI+0FaJETBxYDWe+7bNjQBlGlWGvksK54oWcdeXuFgkeiecfiYOugF0T+z1FVt9ajCZkZbdVgnjT/9By7HzXrAFWdfBk0wBF/fEWpzFGuCQT/wQpw10zMEloKymCBsYciBjGG4H64IE0zWbdnkA0uzNeSYiiSBAwbsbqAV8Z8B0PKKwYI/Z1JOARdOTBYmhqHOEZY5DJGYHquCAzXkWgNIYDHE/pgjzaLIXw1cDbjRTwnQmbllEfsw6fFHhxI/tgt9CNWsvXFVt/Gqn9rcZCmNdp+P8r6WyR6Esv6Ihd1oBzY12JQTNB68i5WgmQefQq61yb3DmKIlr+ITZ2eQu8ZUTxjTaUhHrJ7dNt86TwiXohC1S76vu2pVnIXfji1C3swt0cnl31wNCZdbNcpZL5+bFJ2daDx1g4ZQCVtnL2Sc8rKZYSgALMz/ItSQl5+lVGdPcakZ4AQI0OcfsMau2dQ46TxppfK8fW4eGBx9kizCYWdFlJ9hJtEWX6lOV6AyMAj2C0+wM290X9QPDNjF95M2wYoWAqrV/HSUUjl2FVNSPfZOl3dI6DDk2XK5y6zG0e5vwbsKdL5l0jzCQWXcPwiZ4LDZ7xf29rj6JhKzgn35zkhNQs9oOI0uTFIPT98VZ10xA4MKciYRxi0DbUCkzqVOun90sy3G4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(33716001)(8936002)(6486002)(8676002)(478600001)(38070700005)(26005)(71200400001)(83380400001)(6512007)(5660300002)(186003)(9686003)(966005)(86362001)(53546011)(76116006)(6506007)(64756008)(91956017)(2906002)(122000001)(4326008)(66946007)(54906003)(38100700002)(66556008)(66476007)(66446008)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BWF61Ug+K2Fs/TKFPo1qhm/d9ncyMyPyXVLymkgN4buOIfMuVkOrMh2Sw0aH?=
 =?us-ascii?Q?XgHGmJXjfM0DdOm3CXkWH1dn+pkyPzpLxGa2vV5wXn51eqxlqPpM+8yk96c8?=
 =?us-ascii?Q?GgX8hCGbPFRXgn2XzVDospLQ2P5sMPHmunVJtWLGJiqTa5bmB2WKxTXoLSHU?=
 =?us-ascii?Q?raXMv+9e+mpNvMi76/sG6U2Q+xgP1DRmm5lyGZ0XLLtMUyUYzQLmxA6JrKf2?=
 =?us-ascii?Q?LcZIuhEWA91GRbGSEbXfxH5zjBWjjR/9ViMHF2tP/7Qd22k6bMJ4EH/TbWA+?=
 =?us-ascii?Q?VakWRIZhn0ZA7zM6Ho4y14WSDLaXXU/Y70TOKTgaULOQtK8VdYFnRQg8TBy7?=
 =?us-ascii?Q?B9Dvxk1wWJ666PBMU5203gJWnvV3NKrjmrh0WpibuWZ7g+XXcWBpmNj95St2?=
 =?us-ascii?Q?kvYQONMLLVyLiwiC3YyC2oq0Zidtfzh+uPVr0EX98Mv++gOG/THajAh3TsUO?=
 =?us-ascii?Q?676gtCZxTnOVkN8GbFwrNhAO73AhbiNyYz3YhGRQevpe+BRs1asgdKFKeItH?=
 =?us-ascii?Q?nWGLd3pDtgzy/By/JOG6YnFSgVNJBhdzFVIEzr7JJOoTHFnzqZNI73OFoOIL?=
 =?us-ascii?Q?ulNqcWK2gAiQRMLcKhX/AzM9SGU93klryUpWCVGszoFyXPlQqexIuR57jfCA?=
 =?us-ascii?Q?c1OhHJUSZGmva2mr87ep1vYZIXkrrACVChKj+B3E2WXBZN2DA3M3kqvhK6Sx?=
 =?us-ascii?Q?jQIzsKoZst514d1g9823nOIbTi6MuuyXhSRkrjzaF/UjykZNAqHqt2jP/Xn9?=
 =?us-ascii?Q?xCcdmsXZv6/ZcJaVArr+NHHllOvhhrbRQSafRIvLb3Ks8RamREFPOjPM8pXE?=
 =?us-ascii?Q?dKaD8bH8r9mi6BkXgl02lk2znDBxqrbKFG9OAm2zDtCo407u382dcZtyN/Qd?=
 =?us-ascii?Q?lZ+WP7UCIx487yUG01szjpqNVp3jgbYdFzS1/yd3tJF+0XU8IN2hjMWwWMhy?=
 =?us-ascii?Q?hRQoi1NUlMsrJCw7ME9b9rVpBzMpsIetATO7Q7WWSSzk6TQXpu74/PPOtubP?=
 =?us-ascii?Q?9ey2IxqaZvhtTbgiDmWAwafgEZms6hJqCwnRF2chOkeL3AYfKv47MENP6F3X?=
 =?us-ascii?Q?B7GpDSNTIcyxx5bN1x3+1rXgd6VC/mxE3D4sd1njYmY6Rg6d2+pIBOEByw+n?=
 =?us-ascii?Q?CJCTuMPH4AYl2eZKsGz0gLml6sxz8q7TxNS/mgeKKUV3SqJnEGUGJfy7ImMe?=
 =?us-ascii?Q?8HZLvlGXRjH+/As9zLmn/gpT6+VJwRnNGCRrIfbT3ickkM46iDVUAQtBLV5a?=
 =?us-ascii?Q?LCDR1IYvG6m0RMY81CLyonhZwgN7unvn9YZ5wgQHoUDz0Uv7B1Uea33/xKBd?=
 =?us-ascii?Q?FEhHHhieQfywNLA/7zRWHjo+hPzaA7cBEtyTdxXL0v1toA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <054C2ED7753FB343932B98198E7C8AA0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983fe865-eead-4ead-e5c9-08d972bfd3a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 11:57:26.3345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnaEbzSvShrfn69dFfe7/IQKHtVvMIMyI33HecRMg/9GIuDO21XKBMQrTRnWOfLI2J3Ozh76i4bk6r88LH8mOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7383
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 07, 2021 at 10:12:49AM -0700, Bart Van Assche wrote:
> On 9/7/21 9:28 AM, Niklas Cassel wrote:
> > On Tue, Sep 07, 2021 at 08:15:03AM -0700, Bart Van Assche wrote:
> > > On 9/7/21 7:21 AM, Niklas Cassel wrote:
> > > > blk-mq will no longer call the I/O scheduler .finish_request() call=
back
> > > > for requests that were never inserted to the I/O scheduler.
> > >=20
> > > I do not agree. Even with patch 1/2 from this series applied, finish_=
request()
> > > will still be called for requests inserted by blk_insert_cloned_reque=
st()
> > > although these requests are never inserted to the I/O scheduler.
> >=20
> > Looking at blk_mq_free_request(),
> > e->type->ops.finish_request() will only be called if RQF_ELVPRIV
> > is set.
> >=20
> > blk_insert_cloned_request() doesn't seem to allocate a request
> > itself, but instead takes an already cloned request.
> >=20
> > So I guess it depends on how the supplied request was cloned.
> >=20
> > I would assume if the original request doesn't have RQF_ELVPRIV set,
> > then neither will the cloned request?
> >=20
> > I tried to look at blk_rq_prep_clone(), which seems to be a common
> > cloning function, but I don't see req->rq_flags being copied
> > (except for RQF_SPECIAL_PAYLOAD).
> >=20
> > Anyway, I don't see how .finish_request() will be called in relation
> > to blk_insert_cloned_request(). Could you please help me out and
> > give me an example of a call chain where this can happen?
>=20
> Hi Niklas,
>=20
> This is a bit outside my area of expertise. Anyway: map_request() calls
> .clone_and_map_rq(). At least multipath_clone_and_map() calls
> blk_get_request(). I think this shows that blk_insert_cloned_request()
> may insert an entirely new request. Is my understanding correct that
> blk_mq_rq_ctx_init() will set RQF_ELVPRIV for the cloned request if a
> scheduler is associated with the request queue associated with the
> cloned request?
>=20
> Bart.

Thank you Bart.


dm-rq.c:map_request() calls .clone_and_map_rq()

one example of a .clone_and_map_rq() implementation is
multipath_clone_and_map().

multipath_clone_and_map(), to get a clone simply does blk_get_request(),
which does blk_mq_alloc_request(), which calls __blk_mq_alloc_request(),
which calls blk_mq_rq_ctx_init(), which will set RQF_ELVPRIV, as long as
the request is not a flush or a passthrough request.

dm-rq.c:dm_dispatch_clone_request() calls blk_insert_cloned_request(),
which will bypass the I/O scheduler.

So, a request cloned by e.g. drivers/md/dm-mpath.c will
bypass the I/O scheduler, but can still have the RQF_ELVPRIV flag set.



This just tells me that if someone wants to clean up this mess,
we have to do something similar to what I proposed in my initial RFC:
https://lore.kernel.org/linux-block/20210827124100.98112-2-Niklas.Cassel@wd=
c.com/

i.e., set RQF_ELVPRIV flag immediately before calling
e->type->ops.insert_requests(), and only then.

It seems logical to simply set the flag before actually inserting the reque=
st
to the scheduler, rather than finding all the corner cases where we don't.

Anyway, I'll leave this potential cleanup to people more familiar with the
blk-mq code for now.


Kind regards,
Niklas=
