Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBD2C38A30
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 02:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107F22084D
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 02:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hOW0gQdD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GFHv19Xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgDUCfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:35:25 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:44559 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgDUCfY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 22:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587436524; x=1618972524;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NDEw0Qj7O36hGRE3sl4bqG3MyjJ/SSfm/OCrVbJ8gxs=;
  b=hOW0gQdDrZJDOoK9yZtgOlBqgWTyQZdNckOe1WubdHpnu0Gnot0uLuk0
   GW+6oF4Ac6MeOxESFSjvz7yGomGqkVkPUiVJjWKhI7/edH8wlqCeNuArF
   YCXr2WyuOPnCyYD9vi69I9/zdw8rhp5b0o8AtJUlrdU8CM97CLZtkM+0p
   UNVuXOVVlH70ht/qYMmISFM1ppQbF+iB5C8XQf0dACI1vxlyzWB+hSGQ5
   TpVx6P/IUPJ3lSYtlit2LG+lBAQLJdeUoj2cLegL73sA7+0NLufkFbx+r
   rwqaYvlwsc55GIjTsFanBpSSPYt9pUnJGotG+ce/anTuSaI5yec1Cfq0V
   w==;
IronPort-SDR: NG+hKS2jUm1j73IMoJK8z5TO/1a8YIUnpLg4TKUNzjUYRsDhtPa8PgwfFg+vzF4h0eW9wcmFQv
 dh2Sk9m6kSBp5Z2zUg8RR2pm5CTBjF45jlQCbX9twvcBu3866pof1irPEFiknKMeQnPddCCAJp
 lI6MHfj0JAV/C8bypTDQP4LMrkMx3WqHnPdQXaN/RqJdQjDHNL1Kv/9eqiIfhuT6Bj1RezI8dz
 GUwkb+4cihVKqsDB/gevve1N3G6sYkC4+HFm4PVOJSZZDixXLNFX7f4JcnJ5Y33gXh+KO/CIh+
 2Eg=
X-IronPort-AV: E=Sophos;i="5.72,408,1580745600"; 
   d="scan'208";a="244464333"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2020 10:35:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDGyr2ckePEbnT2M6ZR+8wCj8uGn8eQSr9fEINcXKYwIvvubSRHTCf5y+90kQjGglM3OyruPVSaQufSip9+We9YMW1u7wiA/FCQkkbfmKFtoIsb5zuOJ7OftJeJn6HtrIymy1Ex34oL/PoIqb4abWqu8GdqKyemLqsd3hnVU6SyNQGQJTfFvwu/MBrFOD0GYhfn0/3OO/nNItZu3d63Jr/gONnjl4PckgFzRrym70x+i4N+QbY9eUg9+O2TmUPzWNE0IlCGh2WCISiI9LhTmteu0cWTNwVEB0T/CI78wob91OT4RnRr7IWf7MmCoUZISmrHNEvkmbMGbMqhLB6oGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kFVtbBhWNy/qYgQRhOVy4Xd1KVa+vi7sw3HrH9D5nY=;
 b=ATKFU8oxqDR8/Stkbsn6FwOIk6rdfDaw/JTvKf6QE3bjanq2MumyQdyMKhwXmBKXQvGbi7rGDQy0rTbf1Bw8PafIopF21kqzV/ecwnlcNiq/RoOybL6pDX4yN3OEh82ViT1m53VrKaKErWR2ZJaiC1HWiF9uQOBxcplfsP47Ix9kUMOBgIZOQBBOCcugEZolBPl5avproUQx59EXab3WMRZfSQgjp6kjdVf9ZNu2Tf40Sr8snedUW88+ZtQZK66qUSs/wy1vSZCzwGtZyM6KyrBt27R9Cydzm/UtGYWm/9FOm3HutPyHp8093iuNZJrmdKvlipzuChQsTl0yfVM9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kFVtbBhWNy/qYgQRhOVy4Xd1KVa+vi7sw3HrH9D5nY=;
 b=GFHv19XbTud4hC9td5gzAwuHCr9SOVFigXtCQMGR7D7hd/ff8YoyH9zJaDqcwc+924MaRMD86yIh/z/yk5FUdwKVXkue1rM9TyFM09of8kXc6mX7DoFQU67zBnhW29xMZIz5gwkAD5pNfJ77GWA4labJMFTLOfZ0J3CEoBd2vMg=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB4504.namprd04.prod.outlook.com (2603:10b6:a03:16::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 02:35:21 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::f555:dffb:9f17:7d35]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::f555:dffb:9f17:7d35%7]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 02:35:21 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH blktests v2 4/4] Add a test that triggers the
 blk_mq_realloc_hw_ctxs() error path
Thread-Topic: [PATCH blktests v2 4/4] Add a test that triggers the
 blk_mq_realloc_hw_ctxs() error path
Thread-Index: AQHV+xb8fD+ghKT0p0SBUqJNmRvkG6hSCp2AgDEKNQA=
Date:   Tue, 21 Apr 2020 02:35:21 +0000
Message-ID: <20200421023520.3qhthit7lb6mr45c@shindev.dhcp.fujisawa.hgst.com>
References: <20200315221320.613-1-bvanassche@acm.org>
 <20200315221320.613-5-bvanassche@acm.org> <20200320214205.GF32817@vader>
In-Reply-To: <20200320214205.GF32817@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 273d4275-bb12-4ce4-d049-08d7e59ca372
x-ms-traffictypediagnostic: BYAPR04MB4504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB450409DA6E1E2B9D509A4239EDD50@BYAPR04MB4504.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(6512007)(86362001)(71200400001)(2906002)(26005)(76116006)(66476007)(4326008)(66446008)(66556008)(64756008)(91956017)(316002)(66946007)(6506007)(54906003)(9686003)(81156014)(44832011)(186003)(8676002)(8936002)(478600001)(1076003)(6916009)(6486002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WJP5jBlrkHQqCpSCZogWpnJSjpeh3CbkguYn+T/sqAXxJajTgejxcP34wjkcjtGErmXPAp4CSfCtdwC0aCVQBJi+KC+8SWmuaGbuGAfS4nUa9Djqc1tL6gKjrvcCRAQY84cRSd0wMkK75SFindaphgKSdt7xzY2cAJ1T3fx779GYaDxCg1UfWBVRTRcNvqV/1/NAY1JBGbAA3Yvc7GM9MYnfTBtNwhf25W369Rq0dp9nyhYk9zkqwl0iF2HGnPbvMTxxMwcvqmA2sQfnQsSsNoWwg+94GNcy2ykYBbvuWWHHynEZ7r0msQrEbdY4LlIlbVXnzyAEoB/YmA+K05otUThEUof1QBca9kUnPATnw9dyt1GwtooXUue65PqbmbOKNOSz3RJdYj0tDqExJrKOpdSFhR0LZCzapPP2wwvG5A0xptIOLxiBmO/E9UVNwIUt
x-ms-exchange-antispam-messagedata: mJl+5XNbOURd5WdZgJaIDPGkMH82Y4yRRWkTNx82O0Ey8sofvWXKlzOlG9eXQ2JfL89fkD2gnBjqp4ieheUniDK5t5OPKYv4offpjdSV6qYMtt/NoMN5h8AAr6OUa9xe4124RmeprR73jSJWfnC1sg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A643F94101DDA04496AA803880639DBF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273d4275-bb12-4ce4-d049-08d7e59ca372
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 02:35:21.4674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qPZxjGLqTtRcndH95T4XB2pHPfnxwACHnADliWGgfFwyc2UnRvh+9CQQxy14x0jn4vq0HGEiPGRkHt7lRickHwX9yaIRMtlCtxjxPkFm0II=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4504
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 20, 2020 / 14:42, Omar Sandoval wrote:
> On Sun, Mar 15, 2020 at 03:13:20PM -0700, Bart Van Assche wrote:
> > Add a test that triggers the code touched by commit d0930bb8f46b ("blk-=
mq:
> > Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()"). Thi=
s
> > test only runs if a recently added fault injection feature is available=
,
> > namely commit 596444e75705 ("null_blk: Add support for init_hctx() faul=
t
> > injection").
> >=20
> > Cc: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > ---
> >  tests/block/030     | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/block/030.out |  1 +
> >  2 files changed, 43 insertions(+)
> >  create mode 100755 tests/block/030
> >  create mode 100644 tests/block/030.out
> >=20
> > diff --git a/tests/block/030 b/tests/block/030
> > new file mode 100755
> > index 000000000000..861c85c27f09
> > --- /dev/null
> > +++ b/tests/block/030
> > @@ -0,0 +1,42 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright 2020 Google LLC
> > +#
> > +# Trigger the blk_mq_realloc_hw_ctxs() error path.
> > +
> > +. tests/block/rc
> > +. common/null_blk
> > +
> > +DESCRIPTION=3D"trigger the blk_mq_realloc_hw_ctxs() error path"
> > +QUICK=3D1
> > +
> > +requires() {
> > +	_have_null_blk || return $?
> > +	_have_module_param null_blk init_hctx || return $?
> > +}
> > +
> > +test() {
> > +	local i sq=3D/sys/kernel/config/nullb/nullb0/submit_queues
> > +
> > +	: "${TIMEOUT:=3D30}"
> > +	if ! _init_null_blk nr_devices=3D0 queue_mode=3D2 "init_hctx=3D$(npro=
c),100,0,0"; then
> > +		echo "Loading null_blk failed"
> > +		return 1
> > +	fi
> > +	if ! _configure_null_blk nullb0 completion_nsec=3D0 blocksize=3D512 s=
ize=3D16\
> > +	     submit_queues=3D"$(nproc)" memory_backed=3D1 power=3D1; then
> > +		echo "Configuring null_blk failed"
> > +		return 1
> > +	fi
> > +	if { echo "$(<"$sq")" >$sq; } 2>/dev/null; then
> > +		for ((i=3D0;i<100;i++)); do
> > +			echo 1 >$sq
> > +			nproc >$sq
> > +		done
> > +	else
> > +		echo "Skipping test because $sq cannot be modified" >>"$FULL"
>=20
> I just pushed the support for allowing skipping from the middle of a
> test, so now you could make this
>=20
> 	SKIP_REASON=3D"Skipping test because $sq cannot be modified"
>

Hi Omar,

I noticed the commit cd11d001fe86 ("Support skipping tests from
test{,_device}()") have side effects to some test cases. The unexpected run
result "not run" is reported to test cases as follows:

- block/005 ... for non-rotational drives such as nullb
- zbd/00[1-5]
- zbd/007   ... for dm-linear device

Some helper functions _test_dev_is_rotational, _test_dev_is_partition or so
are called within test_device() context, and left SKIP_REASON with values. =
It
resulted in the "not run" result.

To fix this, I can think of two approaches. One is to unset SKIP_REASON aft=
er
calling _test_dev_is_X helper functions within the test cases affected. Thi=
s fix
is straight forward but it will require similar care for future test case
additions and changes. The other approach is to flag the test cases which j=
udge
skip during test run. For example, SKIP_DURING_RUN=3D1 can be defined in th=
ose
test cases (block/030). The check script validates SKIP_REASON only if the =
test
case is flagged. This second approach looks less costly for me.

Please let me know your thoughts about the fix approach. Thanks!

--=20
Best Regards,
Shin'ichiro Kawasaki=
