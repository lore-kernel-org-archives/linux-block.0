Return-Path: <SRS0=IQpB=XC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEE3C43331
	for <linux-block@archiver.kernel.org>; Sat,  7 Sep 2019 18:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FD621848
	for <linux-block@archiver.kernel.org>; Sat,  7 Sep 2019 18:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GEGgXpFg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v08h+9rQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfIGST3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Sep 2019 14:19:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57828 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfIGST3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Sep 2019 14:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1567880369; x=1599416369;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jeUPPlsk1roi7pXzNyYNHvjs64pP2G8YPJ3tr7qh04o=;
  b=GEGgXpFgCZn6XupR+SXccCXp7ofRUNDMhAJi7oAChycQDDc2ADvnmIfu
   YAjwRgHZ2Hxb15tcjkFL5ajaI0VLEYbxLHcUxBlXqto3mozTuvlkrktvg
   LdxjcQGa6Lik0Akn+wCQEiP+pujtyxtjqWbkycDuj/CQzLsq0JHFD+g0t
   YvJ3LRxqkA6TSHfMuqHWBhF+tdL+F2HMS7ZEBzzD2U0ZPSNyD6KV6/E8r
   7HLpT2uAKnkh9vZq7nt5rpDHhODqFSH5sp+9TsBgAGCL22ec/hOsUtnU9
   YG409NWR9Yw3fByDzMWEzKlu08R955KybJGVZnOyv0Mqis2TcthS2Kh0Z
   w==;
IronPort-SDR: InlaL53MzF3uCAG9WtCNcBZWjq/Dk2fMbdcDYRuZEFp2Q/kJw6Wac2J7VsDhGGxe3yo+AOcpWf
 hRYqHRBeqefTtEHD93r7mNF3UooJPGB43yr9Grp4jLTs+gialR97ZpABM0/+u6n6FchaE5qeBS
 4ht/wOdVf28HyGRdyOjxaA2r7L9b5YmYXJW/gSWkl3f+LuS3lWNSmuGRH0DVWr9Yn7choFJ+Ji
 tMgFTAOhzFqi+hSOgkHqbkOfr+LjeMykqWlfE050KUQNQ/3GUO6ePzor36VcBgr+ggE+77iyZk
 q6w=
X-IronPort-AV: E=Sophos;i="5.64,478,1559491200"; 
   d="scan'208";a="122310913"
Received: from mail-co1nam03lp2053.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.53])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2019 02:19:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFsBS/FIlSheso7XyoC9DGSG42mCHZTYveJvDo8C91ABX8DqTRNUynwg/uC7y+euOHwmPqATItLCHjJ1Rmo35+9ZqkwZzuLg6lQdui05d4M2B7CM+E4Gk0vV7Zl9eYpxpTTKfC1S5k9wU+b3u/W/v83AqZkr28O080vcEfA/Hc926PGtuyapWFNIyiybBgocDZjdrj5rWsd0S8mKUIsSuCcRh7KGqgFdTUZPvUYHooDZllGacxMYOVzqnQqvZMgvah6ZP3+yaTwn9i23TwYmHv60m553p6A8fzNcsPbcY4fM8fm42CxjRUg53n4Iahuhhn1V8E3ugb4Ygz5JV8v2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHfKOUQro8jgPq/LQoM8wnyLahSclTo3CK3OCt50oKc=;
 b=A4ksj4uYn3DBxQVRUJ4K6d+2HUo9IKC0IS+Vwj+2Ei11ictB4nbK+pHodDgAZQtAfsXziTQCZhKjpe+TGb33c+CNUWxynPHkkX6q+IyCd9rFqEyv8mMOUnrFY6J3UCoTFx5KCf/4NlPkPE9c95aURxhULsngQkyueNLd6HLuIm4y2I1hNbo2nxm4kzO3iqH554fFCivsgRo+uD05hRbWAFjkzahU1Vbkr0sDstDENZLTc7lg655KHoUfkwauE4CoVSl0ZMX8t3sup+xrKCEgD6V9NeZTw/XvBrNau0/1SD9lX5bIJGiKRPLM818P1HeCAJCirKfrM8SJkPS3PBlpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHfKOUQro8jgPq/LQoM8wnyLahSclTo3CK3OCt50oKc=;
 b=v08h+9rQazt1aeY4cTcaPHaEMKkQcXjV4Z0MT1G5aHrz37XfbwnwWLE/7VBO7BFaWu4R2+wxUnYN/k4TAb+L5pyso5yokid+yuAQEveK9Gqm5zUd5cGE5TgbFfQofRN1WKol6nS/MEQJJVAq+6GDmt/gwd0Vni1jDPyiRR23TK0=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5639.namprd04.prod.outlook.com (20.179.56.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Sat, 7 Sep 2019 18:19:27 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2241.018; Sat, 7 Sep 2019
 18:19:27 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
Thread-Topic: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
Thread-Index: AQHVZBGFOhLove2B20W3iAzHm6F5Cg==
Date:   Sat, 7 Sep 2019 18:19:27 +0000
Message-ID: <BYAPR04MB5749A3E9B06514AF589FE13B86B50@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190905174347.30886-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a78056d-4edd-431b-1078-08d733bfeb26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5639;
x-ms-traffictypediagnostic: BYAPR04MB5639:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB56393D079216B0BBA724249F86B50@BYAPR04MB5639.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0153A8321A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(14454004)(53936002)(229853002)(71200400001)(33656002)(25786009)(71190400001)(478600001)(476003)(186003)(6306002)(966005)(2201001)(486006)(7736002)(81166006)(305945005)(81156014)(74316002)(76176011)(2906002)(6436002)(52536014)(55016002)(8676002)(64756008)(6246003)(110136005)(256004)(5660300002)(66556008)(316002)(66946007)(66446008)(2501003)(8936002)(66476007)(9686003)(14444005)(3846002)(6506007)(86362001)(76116006)(53546011)(446003)(6116002)(99286004)(7696005)(26005)(66066001)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5639;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: omMe5ZxokF4eXjbStNhhOHJnvdIgPonoPQHXkehn5WNBJt5mr4xIzaEiW80HbU4aPY1xpcKhj4Gs5UJutD70MkQOJ+K9Hzv3mRqF3xUyOFYg+gPWfabT+XggOw0iXts5+M2o9v20c5MpIo7MMf4o4LPoRX7fLM6xLOWvQbJ+47gCsxVVjvh23tJw3EbYenMIkQMGTX2tVHf05yfN56NDpNqIfLmn1LjKfzfcRmIoIj3BNDshRMOy0xK+iW1K7/cxSSeiPRmyHo2hIi5oo/DHJZ6Fbzf3vsw+R3WguWDaRercJdEd1nFlUaPYH2PkC/k8W0Q8ci07gd73x6hA48t68hp83UUcJvylkDK2xoeweNRikhegrw6SGx/5tuqKOBzfMYUWgZ8NbZOKKVLTOZGjOj8jeuNC0Z2MGsys68ui24w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a78056d-4edd-431b-1078-08d733bfeb26
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2019 18:19:27.0256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRSqn20pNVXyH0MvRArWBzk4XuZZFK3uQ6mLyvWkvuY9MZviyzKyoVraO4oQJyjaQBqkGlSVzKW9qscNl26uuk5TjuuKxaO7ys1LzUpf6wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5639
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/05/2019 10:44 AM, Logan Gunthorpe wrote:=0A=
> A number of bug fixes have been submitted to the kernel to=0A=
> fix bugs when a controller is removed immediately after it is=0A=
> set up. This new test ensures this doesn't regress.=0A=
>=0A=
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>=0A=
>=0A=
> ---=0A=
>=0A=
> This is reallly just a resend. The patches this tests for are all in=0A=
> 5.3-rc7 or earlier and it passes on said kernel version.=0A=
>=0A=
> I've rebased this patch onto the latest blktests as of today with no=0A=
> changes required.=0A=
>=0A=
> Thanks,=0A=
>=0A=
> Logan=0A=
>=0A=
>   tests/nvme/031     | 55 ++++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>   tests/nvme/031.out |  2 ++=0A=
>   2 files changed, 57 insertions(+)=0A=
>   create mode 100755 tests/nvme/031=0A=
>   create mode 100644 tests/nvme/031.out=0A=
>=0A=
> diff --git a/tests/nvme/031 b/tests/nvme/031=0A=
> new file mode 100755=0A=
> index 000000000000..16390dcb380e=0A=
> --- /dev/null=0A=
> +++ b/tests/nvme/031=0A=
> @@ -0,0 +1,55 @@=0A=
> +#!/bin/bash=0A=
> +# SPDX-License-Identifier: GPL-3.0+=0A=
> +# Copyright (C) 2019 Logan Gunthorpe=0A=
> +#=0A=
> +# Regression test for the following patches:=0A=
> +#    nvme: fix controller removal race with scan work=0A=
> +#    nvme: fix regression upon hot device removal and insertion=0A=
> +#    nvme-core: Fix extra device_put() call on error path=0A=
> +#    nvmet-loop: Flush nvme_delete_wq when removing the port=0A=
> +#    nvmet: Fix use-after-free bug when a port is removed=0A=
> +#=0A=
> +# All these patches fix issues related to deleting a controller=0A=
> +# immediately after setting it up.=0A=
> +=0A=
> +. tests/nvme/rc=0A=
> +=0A=
> +DESCRIPTION=3D"test deletion of NVMeOF controllers immediately after set=
up"=0A=
> +QUICK=3D1=0A=
> +=0A=
> +requires() {=0A=
> +	_have_program nvme &&=0A=
> +	_have_modules loop nvme-loop nvmet &&=0A=
> +	_have_configfs=0A=
> +}=0A=
> +=0A=
> +test() {=0A=
> +	local subsys=3D"blktests-subsystem-"=0A=
> +	local iterations=3D10=0A=
> +	local loop_dev=0A=
> +	local port=0A=
> +=0A=
> +	echo "Running ${TEST_NAME}"=0A=
> +=0A=
> +	_setup_nvmet=0A=
> +=0A=
> +	truncate -s 1G "$TMPDIR/img"=0A=
> +=0A=
> +	local loop_dev=0A=
Duplicate declaration of the local variable ?=0A=
=0A=
> +	loop_dev=3D"$(losetup -f --show "$TMPDIR/img")"=0A=
> +=0A=
> +	port=3D"$(_create_nvmet_port "loop")"=0A=
> +=0A=
> +	for ((i =3D 0; i < iterations; i++)); do=0A=
> +		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"=0A=
> +		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"=0A=
> +		nvme connect -t loop -n "${subsys}$i"=0A=
> +		nvme disconnect -n "${subsys}$i" >> "${FULL}" 2>&1=0A=
> +		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"=0A=
> +		_remove_nvmet_subsystem "${subsys}$i"=0A=
> +	done=0A=
> +=0A=
> +	_remove_nvmet_port "${port}"=0A=
> +=0A=
> +	echo "Test complete"=0A=
> +}=0A=
> diff --git a/tests/nvme/031.out b/tests/nvme/031.out=0A=
> new file mode 100644=0A=
> index 000000000000..ae902bdd36d4=0A=
> --- /dev/null=0A=
> +++ b/tests/nvme/031.out=0A=
> @@ -0,0 +1,2 @@=0A=
> +Running nvme/031=0A=
> +Test complete=0A=
> --=0A=
> 2.20.1=0A=
>=0A=
> _______________________________________________=0A=
> Linux-nvme mailing list=0A=
> Linux-nvme@lists.infradead.org=0A=
> http://lists.infradead.org/mailman/listinfo/linux-nvme=0A=
>=0A=
=0A=
