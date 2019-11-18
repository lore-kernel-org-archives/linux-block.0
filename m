Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E53C432C0
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 01:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B9E206D6
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 01:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E0Q3upqo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XpXdVXxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfKRBph (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Nov 2019 20:45:37 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56054 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfKRBph (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Nov 2019 20:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574041536; x=1605577536;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vumVqtAVJrdIlbhUzVnrwsCzcYra/kD9a+BmIBCoSrU=;
  b=E0Q3upqoEpc4XCY3xlRvxYpxSldt6YyTMo49fbQxeiXFZt27EpNQS+IB
   aZr4rgFaMv2uvxmPBGm1z2h0HKaXghP0rBCUPLnp+xavgYBEP86euvui7
   xYeDi0MMmTdBt+xaeAFShSYhoxM8DAZAO4LquVuuxVinM9uhR7imGMDZh
   faXoanUHfpfZIMtZabkiQm82YH5WFQMPy4eT7hTzxg7XrpB908YlWVuug
   G4KQqvew62Ouh+gIvBwsN+/6kPDCR6Qx+qKkVYMNLv+yYnI+s4ibMNGDB
   kAvg2ygg4aw5YHz52mLnspIe1jPIyODM0oQ85PXEN9EvF2wnXL6jLA76t
   w==;
IronPort-SDR: byKlTjTUGYtAQ0kTDxV/TuelvXVpoBbUC8fcvFyV5nEIrACcSlqV13Z49ISduEZiLKf4HDx8ym
 ZxuQjmxvG8/RGy6rVIsurt8bN8B9bPqn86TEr/evSPhU9Gh7Z0j6bgAMw/ems7+GDLMyk5N5bi
 CPYPqOfS2eVK1cs7dL3x5NX1GfLb5huFlC5aNWotSFf5MqHt1r4iSSuAPE2C6B+XdvCyVIOq4V
 Q9k+nHlvGLe8Sr1LJUEDjf05BFqWFa7V/BJO+L8UlmnXhedGJm0ZUuke0Rbom2G35ga/75RHED
 DHo=
X-IronPort-AV: E=Sophos;i="5.68,318,1569254400"; 
   d="scan'208";a="230618799"
Received: from mail-dm3nam05lp2059.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.59])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2019 09:45:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkxbQsAokrPYB/MKu7r1Pv1cYUAlFWnNy/m//TCCEj/Ju6um9pO8SXA3/pZt/ASFURv9kEAc66PuoxpnPS4cG+8r+1gD+sv98wDhHNVb5HIJpZF6+729nyVsNlWd7P85o0HMDAdmsHoLJQWmdhV/QQ6wdoQSm/hWVm0aLTeONQ0sN1UPcHpMpiWX7fI1W5/KKBq2P8K6hcmKOC9Uwo3WGATjt3MuytyRvDXI+tYEhGw0pP0hwcFH6VVkEw6I6rJWO97ETiK9x2fpllvwU++9Oja/GCTFV/pl1Nc6V6ubfe/W/ZON9pZQfJSjwWk46GxwlgiJtEEKCD3XgEPqwNP91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMZEuV0rjwITjLRVvOsFKK77vbnToQSWWnP2+kHxWkI=;
 b=Blh48wLjTJFRskmsnnBXcndAAwCUlmJvoDR+V4C75CB4gKm5I42MPMkkhjcp5S7NI05C3U3AUMf8ofLBFJk0jYj6BI1Gs4zWms9+6CiVrLDNK4yl/SFEeQKYa33QNX0ZUuJEMuo1OfKlwf6YBFufdYkjOLCHEwDLiUSqbZNcKQ8xJIhGOLb3VwjHpWK9xi1U7o7bSoED3Ij+TmvpmVAnd0/G/pp2dT8OALFMpvQj9C6Nk7sj1ailMc1Esgw5TEZwALBXl6dBrfgv2QQLnS3vckGu5tjHNXyLRt8ZVoaFywxzGrP3Od8xcgfXBXDaAj9/JVIDvuFti3vC4cixzU0OdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMZEuV0rjwITjLRVvOsFKK77vbnToQSWWnP2+kHxWkI=;
 b=XpXdVXxRRkRNnCYffsOHAwfNCbPidG3GqwmsukdNq0pPACZDZWiN1CoKjRsxhBTA+Bf7Un0ElDHfbVgvoQVZPoy8ftuxhObB87HTSWm06Bps4OkO7x+1q1ltpEwax6dMdi1cgx57aZ4vCaZn5ix+IBSybqXwIQHM1KLbaAww74w=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5864.namprd04.prod.outlook.com (20.179.58.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Mon, 18 Nov 2019 01:45:34 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 01:45:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH v2 1/4] skd: Prefer pcie_capability_read_word()
Thread-Topic: [PATCH v2 1/4] skd: Prefer pcie_capability_read_word()
Thread-Index: AQHVnaYWjyRplcnjK0O+FGDAzAO+yA==
Date:   Mon, 18 Nov 2019 01:45:33 +0000
Message-ID: <BYAPR04MB5816EDC3676A964C2D1D874BE74D0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191118002057.9596-1-fred@fredlawl.com>
 <20191118002057.9596-2-fred@fredlawl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08b95a96-1079-400b-75fd-08d76bc900ac
x-ms-traffictypediagnostic: BYAPR04MB5864:
x-microsoft-antispam-prvs: <BYAPR04MB58643D81E8A33B7F1DEEE42CE74D0@BYAPR04MB5864.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(186003)(3846002)(71190400001)(6436002)(2501003)(26005)(7696005)(8936002)(52536014)(99286004)(8676002)(76116006)(102836004)(66946007)(66066001)(91956017)(86362001)(66446008)(66556008)(66476007)(64756008)(53546011)(478600001)(6506007)(33656002)(446003)(256004)(6246003)(14454004)(316002)(71200400001)(76176011)(81156014)(81166006)(5660300002)(2906002)(55016002)(476003)(4326008)(9686003)(486006)(74316002)(54906003)(7736002)(110136005)(305945005)(25786009)(229853002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5864;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mja+PGxkUZlpE4c2LW/GZ/CXPT/S/1drvdtfP8Kdzv8S8w8gQz3MhQu6e2hv25Kd1Fg+5Y1c+yEVHSKlOl1sfwvISBFxpDsQOxEXantJcmRKnw7LH6hKuLrcO5TWEQuhmQyX/5W3oBZ+mTeWmK6HysDPLmkAfHWASGmD70BVux2p4I5aweiqd+GluRHLR4FENVFzh3OB0fap+fVseLHDih2G74/AInM8skjv112WNVZLRlpSKCZWqx3EnbcVvTDdxatYfEvw+tIOgBOGke54mDh4XzTvXnjgFZww7X54f+FptiR9lNaKNOQuAj6hnWaRtwXut/sXnXdMCbIQQk3/UaaHFfO3S+tiS2B6r7b+aDfGFNzxJoys3Ps3jGPToM9Zz982sIDwlrW4DQSU8gYfus+jwlzKRL3zhfyk+uM+5oEkPSx9iCw/Vi0it+WFqYZ4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b95a96-1079-400b-75fd-08d76bc900ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 01:45:33.7996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55ASD1BBdMAqZr41PApXP2j5YVhBr12Qw4TM+5LbKeieQkATKDPma9stvygm/drMYf4a3w70cE8+uC6gAGLC/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5864
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/18 9:21, Frederick Lawler wrote:=0A=
> Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")=0A=
> added accessors for the PCI Express Capability so that drivers didn't=0A=
> need to be aware of differences between v1 and v2 of the PCI=0A=
> Express Capability.=0A=
> =0A=
> Replace pci_read_config_word() and pci_write_config_word() calls with=0A=
> pcie_capability_read_word() and pcie_capability_write_word().=0A=
> =0A=
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>=0A=
> ---=0A=
>  drivers/block/skd_main.c | 8 ++------=0A=
>  1 file changed, 2 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c=0A=
> index 51569c199a6c..f25f6ef6b4c7 100644=0A=
> --- a/drivers/block/skd_main.c=0A=
> +++ b/drivers/block/skd_main.c=0A=
> @@ -3134,18 +3134,14 @@ MODULE_DEVICE_TABLE(pci, skd_pci_tbl);=0A=
>  =0A=
>  static char *skd_pci_info(struct skd_device *skdev, char *str)=0A=
>  {=0A=
> -	int pcie_reg;=0A=
> -=0A=
>  	strcpy(str, "PCIe (");=0A=
> -	pcie_reg =3D pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);=0A=
>  =0A=
> -	if (pcie_reg) {=0A=
> +	if (pci_is_pcie(skdev->pdev)) {=0A=
=0A=
Maybe return early here ? The reason is that if pci_is_pcie() is false,=0A=
then the string "PCIe (" is not terminated with a closing parenthesis.=0A=
So something like:=0A=
=0A=
	if (!pci_is_pcie(skdev->pdev)) {=0A=
		strcat(str, ")");=0A=
		return str;=0A=
	}=0A=
=0A=
May be better. Note that the "return str" is also rather pointless since=0A=
it is not used by the caller of skd_pci_info().=0A=
=0A=
>  =0A=
>  		char lwstr[6];=0A=
>  		uint16_t pcie_lstat, lspeed, lwidth;=0A=
>  =0A=
> -		pcie_reg +=3D 0x12;=0A=
> -		pci_read_config_word(skdev->pdev, pcie_reg, &pcie_lstat);=0A=
> +		pcie_capability_read_word(skdev->pdev, 0x12, &pcie_lstat);=0A=
>  		lspeed =3D pcie_lstat & (0xF);=0A=
>  		lwidth =3D (pcie_lstat & 0x3F0) >> 4;=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
