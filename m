Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5603C2BA19
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 09:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB8220857
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 09:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TDHEqwj/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z/J6shsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgDUJKw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:10:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44712 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUJKu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 05:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587460257; x=1618996257;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d/VBj/UaU8DEqiF2uafqHNXSKrPQTRqJt7D2zQysCh0=;
  b=TDHEqwj/lizDnJHA291uVVHfcDDlq/t8hYQK+rp1wB2kSmUTbjgMdN7E
   bvljimlewaI90pwXdw46Ro69rG6BstTCBc79czh25EqMGC+0WLbHrkDaV
   VwU6COAkOsS5fDBUUmv1bzFkvdCVVob/cX2O0GYzeRWOl6Hu+rnvQjglN
   yCSSVrq8ibMAaWiTfslqtTIy2t9A2SpzzvZ0i4TVIqF2D8iXc5YFdukg+
   QqSvIDTCgkUG94a4A/dJxUeamYhpVqKic2/yIjjCNXaixlEpBoRWklqpW
   Vv5QKUCZgjpz/PFbc5+mZI667mXC29AAeMJu0UmG5Tbyo8G2Ch1ACDCPL
   g==;
IronPort-SDR: uIzLZRwl+fON3uuCs1HL4fTwLZ1xPrdYovaMP8Y3jsWeENrUPbhnYXegutNAdYTFT4pqU7g5Eg
 xHfBA+q+fIAMUPq2/+6Z7cVgJK3VgHICHAF0qcmCKwVnzba1Izil/kGgi3nesdhYHjvKgKBTbE
 1uDRC+XJwWrblsuRTT4A0ybXh32PMvFXT1GLSLjGhGzG6NGs75yoF03bF543EKp9Dt3qcVkI1z
 FSf/0D9+FgUnavzZR2yzhZ4C2PBcSVVogL1aFMTXvDzlMyFnuxG+1KrbcuODl54eVXkro6jaca
 21o=
X-IronPort-AV: E=Sophos;i="5.72,409,1580745600"; 
   d="scan'208";a="238241216"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2020 17:10:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxOyjK9kdyUNvsaWjjkXeXEqywL+rJNSNE4gIiQdD8Voy8Y7vea9Jib3GlOYZ5nzthw3REf2aGS/b8rI96R6nrppPyGQG3/H7vWBR6+AVsu5vUZtJY+K0e0rUc3Jtd0Dlin9z25FifhXv7O1H7wHtfjXExAY2BzhF0Kyb0UjDxPOkWxG3SXzGAO9zTEVkJwZSiNrAHeWlPs/gz6UzkMo0T5TxQbRjSAZ44WEM4fepeJ1kIkSsSJuqpcpTOB+EEEYmdWyoBx/Dh3JhNvqAZRxJfmLSTWfzEBZefzJsNV5uYW/NX6Wp7Mj8KLPVKf7se2RfNb2s2aC282mme0HzOuc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pH5GNqDEGstVJyN5doYsjB04Vsr9jb091Xbnov5Du8=;
 b=hm7irpyka2MCfU+/cUm6Sc4l/5xL1od/0o5NB0xmKdya6pbuUSbIHQX7nrINi2xNP0NY9kmNgFwTZ5MGVijTVobr8A6reKVcJHmj++ELj1tG5fvTLUNE1jAcbtXP+l1/hQW2cXTQ5SzW90Nmwzhh1WfRlYf6z0/l8Ga8DIo8OSD1QWGifcHDy6mebRGevlwNZmTc/zQL3aXzANy0b7DUpPa4BF+6AMOJXml8r+2Cq37OKU4UHTw0g+R9Aev+uCRmYY8IMhHXRizknM/rH864ujIxMKKvQZNW2Yoodve05xvRP6W6kNtfKVZnkj2VD7OopHPIhs1YPnv63zN873bVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pH5GNqDEGstVJyN5doYsjB04Vsr9jb091Xbnov5Du8=;
 b=Z/J6shsarI7jQO3jmDCq+d8X4YXxduF2cfXMh+FQ7N7MkQ4SxmZK2D982gQenz/aLNCCgCiRtUzNciXJSu2M5kSVB7T7yXExZES2TwR1oPcbNLm3qb3qhe5M1K2AGW8+ju9/JBra+Qvee2nM19reqbWJrGJ6VTdQ2tnYLYBeqZc=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB3782.namprd04.prod.outlook.com (2603:10b6:a02:ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 09:10:47 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::f555:dffb:9f17:7d35]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::f555:dffb:9f17:7d35%7]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 09:10:46 +0000
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
Thread-Index: AQHV+xb8fD+ghKT0p0SBUqJNmRvkG6hSCp2AgDEKNQCAAG56gA==
Date:   Tue, 21 Apr 2020 09:10:46 +0000
Message-ID: <20200421091045.ykwivjccrzm5hzcy@shindev.dhcp.fujisawa.hgst.com>
References: <20200315221320.613-1-bvanassche@acm.org>
 <20200315221320.613-5-bvanassche@acm.org> <20200320214205.GF32817@vader>
 <20200421023520.3qhthit7lb6mr45c@shindev.dhcp.fujisawa.hgst.com>
In-Reply-To: <20200421023520.3qhthit7lb6mr45c@shindev.dhcp.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24b92a79-774a-4304-6c87-08d7e5d3e0ce
x-ms-traffictypediagnostic: BYAPR04MB3782:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3782F908E5B7E8A6F8169319EDD50@BYAPR04MB3782.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(4326008)(76116006)(6486002)(8676002)(54906003)(71200400001)(6512007)(6506007)(91956017)(186003)(2906002)(9686003)(86362001)(66556008)(478600001)(66446008)(5660300002)(6916009)(1076003)(316002)(44832011)(26005)(66946007)(8936002)(66476007)(81156014)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gEobSC973W2gR3omvPuSxhOyuXRqE+UgdifM9O3+eA5mUdq4/aEXC2hB9jAQu0em9AOCoiyRT9YxbkWA3/Lrpq85WKgetdgFvh6vcCedLnWrNUVxOcjeyhVyIJkDVzCTcZb86YicS8+OdbK6W+0mubLLiWZzaixZkqvsGVm4PTzIho59vIYEa8uVI8csHOW+WuXf4qiZUPRVhabOCvqUqjAq3c5wPwBdDD0rBvGRN58ejFJXPNQClRvxcQPPmdVpl69q69QqtxeE4a5dEg1+7QoeFV4u+KDqHkqv3zqqTFpoEVbHO5NGG9jSurw/CuTYZqVUu2IVNyicU7Uddx4jNu0uIONeFR+zB4RRhKblU7C+9ruWOTP0DNdIdUUJ6uPAw6oczCBb0nuFkckKtT76k73TZa8NW1ZsRpUzKu2Kp9sYT5g9zbLC8q4yyxqObUrF
x-ms-exchange-antispam-messagedata: zqx9K7BR1v7tROmB1coFYIFc8AKr9gzyH6yDxowJMFEqoqFxx4b+d/iVGTfJUeVWBDWuFpKAyPs77CG8KaWO2fc3/wRCdEKw3kMmDnffE7E5F4lvOJtLAo0LFub28M8i9egLBOxUkXwkKXbkP0l8JA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79B8090023224442A9F0E863408450B0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b92a79-774a-4304-6c87-08d7e5d3e0ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 09:10:46.6250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4Yvp3WrpMtS3NHY2Ty9RuHWAK19AUUuBDgXypQQxmwZ3LrxxoEWfhsmIliarM+1ydbkkRRSANd6ylCQ5UDnjnGtIr37juOq3+dqyt29OdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3782
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 21, 2020 / 02:35, Shinichiro Kawasaki wrote:
> On Mar 20, 2020 / 14:42, Omar Sandoval wrote:
> > On Sun, Mar 15, 2020 at 03:13:20PM -0700, Bart Van Assche wrote:
> > > Add a test that triggers the code touched by commit d0930bb8f46b ("bl=
k-mq:
> > > Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()"). T=
his
> > > test only runs if a recently added fault injection feature is availab=
le,
> > > namely commit 596444e75705 ("null_blk: Add support for init_hctx() fa=
ult
> > > injection").
> > >=20
> > > Cc: Ming Lei <ming.lei@redhat.com>
> > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > > ---
> > >  tests/block/030     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >  tests/block/030.out |  1 +
> > >  2 files changed, 43 insertions(+)
> > >  create mode 100755 tests/block/030
> > >  create mode 100644 tests/block/030.out
> > >=20
> > > diff --git a/tests/block/030 b/tests/block/030
> > > new file mode 100755
> > > index 000000000000..861c85c27f09
> > > --- /dev/null
> > > +++ b/tests/block/030
> > > @@ -0,0 +1,42 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright 2020 Google LLC
> > > +#
> > > +# Trigger the blk_mq_realloc_hw_ctxs() error path.
> > > +
> > > +. tests/block/rc
> > > +. common/null_blk
> > > +
> > > +DESCRIPTION=3D"trigger the blk_mq_realloc_hw_ctxs() error path"
> > > +QUICK=3D1
> > > +
> > > +requires() {
> > > +	_have_null_blk || return $?
> > > +	_have_module_param null_blk init_hctx || return $?
> > > +}
> > > +
> > > +test() {
> > > +	local i sq=3D/sys/kernel/config/nullb/nullb0/submit_queues
> > > +
> > > +	: "${TIMEOUT:=3D30}"
> > > +	if ! _init_null_blk nr_devices=3D0 queue_mode=3D2 "init_hctx=3D$(np=
roc),100,0,0"; then
> > > +		echo "Loading null_blk failed"
> > > +		return 1
> > > +	fi
> > > +	if ! _configure_null_blk nullb0 completion_nsec=3D0 blocksize=3D512=
 size=3D16\
> > > +	     submit_queues=3D"$(nproc)" memory_backed=3D1 power=3D1; then
> > > +		echo "Configuring null_blk failed"
> > > +		return 1
> > > +	fi
> > > +	if { echo "$(<"$sq")" >$sq; } 2>/dev/null; then
> > > +		for ((i=3D0;i<100;i++)); do
> > > +			echo 1 >$sq
> > > +			nproc >$sq
> > > +		done
> > > +	else
> > > +		echo "Skipping test because $sq cannot be modified" >>"$FULL"
> >=20
> > I just pushed the support for allowing skipping from the middle of a
> > test, so now you could make this
> >=20
> > 	SKIP_REASON=3D"Skipping test because $sq cannot be modified"
> >
>=20
> Hi Omar,
>=20
> I noticed the commit cd11d001fe86 ("Support skipping tests from
> test{,_device}()") have side effects to some test cases. The unexpected r=
un
> result "not run" is reported to test cases as follows:
>=20
> - block/005 ... for non-rotational drives such as nullb
> - zbd/00[1-5]
> - zbd/007   ... for dm-linear device
>=20
> Some helper functions _test_dev_is_rotational, _test_dev_is_partition or =
so
> are called within test_device() context, and left SKIP_REASON with values=
. It
> resulted in the "not run" result.
>=20
> To fix this, I can think of two approaches. One is to unset SKIP_REASON a=
fter
> calling _test_dev_is_X helper functions within the test cases affected. T=
his fix
> is straight forward but it will require similar care for future test case
> additions and changes. The other approach is to flag the test cases which=
 judge
> skip during test run. For example, SKIP_DURING_RUN=3D1 can be defined in =
those
> test cases (block/030). The check script validates SKIP_REASON only if th=
e test
> case is flagged. This second approach looks less costly for me.
>=20
> Please let me know your thoughts about the fix approach. Thanks!

Now I found that Klaus Jensen already reported this and posted his fix patc=
h.
My report was not necessary. Sorry about this noise.

--=20
Best Regards,
Shin'ichiro Kawasaki=
