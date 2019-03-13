Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42322C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C022A2054F
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nd81N2S7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a9BvPRyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfCMRrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:47:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39001 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMRrc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1552499252; x=1584035252;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=77DyH2UlkBjiOUaUyGIDfuJ3Xq5nJ/NWm8+Sz2IoY/4=;
  b=Nd81N2S7FLi6FBVL+WDEPAvVVtPlc8a7MwXtmTimNz7iFo52zrLowN/I
   vcFPd/9qmXo1oS7JUGn5PMTlIqyStYD9NmPIDaMPXi91jLeWiubp4fyaC
   QcOcRAMm9i/QSEEwOEEWeniKnLLB0M7bV3+RKdqBsALT+J8af5I1hqSEp
   v9nwi2maaPe3cziOtrOsEhuAV+cx4arnV0EUHxteo09CxMhwVAx/6ApTN
   Namkylb4296Nc3XT62sCIvWIGWEQ2D1Vb+ZOueOB1dzdVn6iirR1dh5Vq
   DqnOYhlmmiz9yovwK8XsihgZ3ydcKoTFGpawJa2dxJIemBkguF8zMnRFM
   g==;
X-IronPort-AV: E=Sophos;i="5.58,475,1544457600"; 
   d="scan'208";a="104696457"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2019 01:47:31 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMmR/WVG04Kxdj9XDnvQED/KwvgTGywsmlO+a2Hv0gY=;
 b=a9BvPRytHtMUO2wlxq7qeE99a+MfqWXtdNNPkQfrACuVm2xuCToapgsnQjH8oD09OUUkIm9Ov6CpQw07NK+cg1EG5hWY8mPZRU5SeDjJAc4KVqWudYfqeaovo6XJt3c3lotslie9wQUWLc3RQRd4TlqEaQ16Gfzjft3TTqSTR3I=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4734.namprd04.prod.outlook.com (52.135.122.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 13 Mar 2019 17:47:30 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::7db4:149f:d1a5:e3fd]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::7db4:149f:d1a5:e3fd%4]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 17:47:30 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Xiao Liang <xiliang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH blktests] add checking nvmet module in nvme
 002,003,004,015,018 test
Thread-Topic: [PATCH blktests] add checking nvmet module in nvme
 002,003,004,015,018 test
Thread-Index: AQHU2WxLto7TbN2jxEWsl+vRw6+xng==
Date:   Wed, 13 Mar 2019 17:47:30 +0000
Message-ID: <SN6PR04MB45270673ABCE84037271E14F864A0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190313071317.8723-1-xiliang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfe993be-6b74-498c-636b-08d6a7dbf759
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4734;
x-ms-traffictypediagnostic: SN6PR04MB4734:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB47344223F3D1969E5CE5B7DF864A0@SN6PR04MB4734.namprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(2501003)(25786009)(6246003)(97736004)(229853002)(86362001)(7696005)(2201001)(6116002)(3846002)(2906002)(74316002)(52536013)(7736002)(26005)(14454004)(305945005)(478600001)(9686003)(72206003)(105586002)(106356001)(55016002)(53936002)(68736007)(71190400001)(71200400001)(186003)(66066001)(446003)(102836004)(5660300002)(6436002)(8936002)(256004)(14444005)(53546011)(476003)(6506007)(486006)(8676002)(33656002)(316002)(76176011)(110136005)(81166006)(99286004)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4734;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dYN/X4AvbHK6Y68s6Hv6updMHJpL1LpI29i/HjgjBXl4+xoXlUoWRh6KM57yAXVMn/TgE1nXVpy+3CWgsmy6fiksGyJtd3B2V+C0AkTcNUhfToZrliS1RxVe+5Dop8B6FSoKr6U3NGQ/9YrGPs5Bsq6NrURbbmALtxy9YVwUfCEfhttVKtuHH/TEoEa/Bt9Gl8fabY2ptmRrYx7AS0dULCTexLiKm/nAKTPgGyF0gtqej1pcUNAN1pP0+/4i/gfMmfzBtdO6GgdOCAIVY2i7l6tEx4GYgZkLyjhxp6SqTB9w4Y5/gDamtfRJud55IIIQpF+u//n+rsQaTCPWOYm+9Uw4hPjH6TDBBSatebsXIhkQw5Kua9qKN6vULuxTqNgfpmKUWPK8d0RTwAb/8QNtVvhz+gVjn96XgxUTvrQXzXM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe993be-6b74-498c-636b-08d6a7dbf759
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 17:47:30.7960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4734
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 3/13/19 12:13 AM, Xiao Liang wrote:=0A=
> Signed-off-by: Xiao Liang <xiliang@redhat.com>=0A=
> ---=0A=
>   tests/nvme/002 | 2 +-=0A=
>   tests/nvme/003 | 2 +-=0A=
>   tests/nvme/004 | 2 +-=0A=
>   tests/nvme/015 | 2 +-=0A=
>   tests/nvme/018 | 2 +-=0A=
>   5 files changed, 5 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/tests/nvme/002 b/tests/nvme/002=0A=
> index 0132ac0..106a5a8 100755=0A=
> --- a/tests/nvme/002=0A=
> +++ b/tests/nvme/002=0A=
> @@ -10,7 +10,7 @@=0A=
>   DESCRIPTION=3D"create many subsystems and test discovery"=0A=
>   =0A=
>   requires() {=0A=
> -	_have_program nvme && _have_modules loop nvme-loop && _have_configfs=0A=
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_confi=
gfs=0A=
>   }=0A=
>   =0A=
>   test() {=0A=
> diff --git a/tests/nvme/003 b/tests/nvme/003=0A=
> index f304071..c6b3d40 100755=0A=
> --- a/tests/nvme/003=0A=
> +++ b/tests/nvme/003=0A=
> @@ -11,7 +11,7 @@ DESCRIPTION=3D"test if we're sending keep-alives to a d=
iscovery controller"=0A=
>   QUICK=3D1=0A=
>   =0A=
>   requires() {=0A=
> -	_have_program nvme && _have_modules loop nvme-loop && _have_configfs=0A=
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_confi=
gfs=0A=
>   }=0A=
>   =0A=
>   test() {=0A=
> diff --git a/tests/nvme/004 b/tests/nvme/004=0A=
> index 346f309..0506fa2 100755=0A=
> --- a/tests/nvme/004=0A=
> +++ b/tests/nvme/004=0A=
> @@ -12,7 +12,7 @@ DESCRIPTION=3D"test nvme and nvmet UUID NS descriptors"=
=0A=
>   QUICK=3D1=0A=
>   =0A=
>   requires() {=0A=
> -	_have_program nvme && _have_modules loop nvme-loop && _have_configfs=0A=
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_confi=
gfs=0A=
>   }=0A=
>   =0A=
>   test() {=0A=
> diff --git a/tests/nvme/015 b/tests/nvme/015=0A=
> index 29cf954..47e1b04 100755=0A=
> --- a/tests/nvme/015=0A=
> +++ b/tests/nvme/015=0A=
> @@ -10,7 +10,7 @@ DESCRIPTION=3D"unit test for NVMe flush for file backed=
 ns"=0A=
>   QUICK=3D1=0A=
>   =0A=
>   requires() {=0A=
> -	_have_program nvme && _have_modules loop nvme-loop && _have_configfs=0A=
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_confi=
gfs=0A=
>   }=0A=
>   =0A=
>   test() {=0A=
> diff --git a/tests/nvme/018 b/tests/nvme/018=0A=
> index b09c29c..e29fa92 100755=0A=
> --- a/tests/nvme/018=0A=
> +++ b/tests/nvme/018=0A=
> @@ -11,7 +11,7 @@ DESCRIPTION=3D"unit test NVMe-oF out of range access on=
 a file backend"=0A=
>   QUICK=3D1=0A=
>   =0A=
>   requires() {=0A=
> -	_have_program nvme && _have_modules nvme-loop && _have_modules loop && =
\=0A=
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && \=0A=
>   		_have_configfs=0A=
>   }=0A=
>   =0A=
> =0A=
=0A=
