Return-Path: <SRS0=IQpB=XC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361B3C43331
	for <linux-block@archiver.kernel.org>; Sat,  7 Sep 2019 18:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00097218AE
	for <linux-block@archiver.kernel.org>; Sat,  7 Sep 2019 18:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l584OHZ0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DA1NnsbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390697AbfIGSXp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Sep 2019 14:23:45 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:39090 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbfIGSXp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Sep 2019 14:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1567880624; x=1599416624;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=t0Zu1bsGnsXH54Wk5OoG1c7+9HkQvig7fvIfEFYMV0E=;
  b=l584OHZ0eAhV7H5fd6K69UGzVRnXvVad4s96TA4RoCZyM83Eu88vgcvx
   djAopJjOgIookwQRrRQkGsJ+xajR6YtZtrOCcdiWKml6FeGoU2+vK7thU
   9wKF6lguAJT60WAq2gMtkhjpXricTxv18evvPnhjJIhMSGX4btn1MXvSl
   Za+khN+wwWGN7YapaLaFJY0tPXwkfoOdq0qjPNIL+3VLs9S+kWZeJX27X
   cl1jfyGgIckQPxU9cSH1DhSz9b+oXGXwKhryMdv6RGROL0jluIzAsVkVE
   lo3VUfZsI1qVJ8SeRTUXxdQQdf8eW1Q9Hz+4bu1CxeonDe60wdbAJMDxz
   Q==;
IronPort-SDR: ep201SAjKcu0p39tCmA+BmkTF/mI6CURlFSQG0CkCzucOd4LfUO5HmtXo3CH6ThWTDXIasfIx7
 JhZhnRznTyZ4TNv4YBwhLjlAjqhZw+ppZW/jTUAatbhvt6ZYyj2dpl5qKyx6TDNbydDGiot05d
 rk/ohJ0MlshlrpjG+v34ipnHpOCVJzc3FZSFIYVktZkaNAiZDyR58T0OcSBDI/K/L7cdB5BLSs
 NM537kCZaaY6JQsE2EdZQvfe4dpgv6mFbEZKUNtap6B819lBRK60omnymd5+5we2P05ov0+iUM
 Gao=
X-IronPort-AV: E=Sophos;i="5.64,478,1559491200"; 
   d="scan'208";a="119323688"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2019 02:23:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U22o9hxTQOsO2r31LS1EzC/Zhv7NMSmE4saN9s+nlE1v3Eg0mebgUeV19Kv0n7rco1Wpc+LJs0dVp9RPlLUTUNxqV7v70fObVkOBndOBrEfFCwE1xFokreMh7HQgiSdaK8+HI51d8iOGktA1OLDYp7dCZd3CD5l2dwrm01WrHI8h/vkydsRYkEibJsfTHFnVUGVvARSwMOyLi5f4atwx75o6batlgqrXyC0x4aIgMOikkFyEEoLn/3U2F+C3sunXFtzX6k0zJTggwCG2NCqg8OrX4Uk3tFjdPpuQG31oJj55gW+jvSchHds4lWme8Q7+j+9xVcU8FZGdu0Kvdqh37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiy5ZruqSsm8joy45YnWygzgEcwyPIyfR/zz0EJ1Ov8=;
 b=mPfyzaqDmSWX/fOAH99pRyBebfFICCJxyjivQYTiMSl1m/CIyMcErOiMlhPaf5mAVbKz6TYqesEaEganlwrb8bYrubobEQeZ1cJjdyvAj7PgaSAz6+wqrwbYN9aGe+L55S4m7vvn1apBRXs1630Dk9hi2wgdNmxHMlgFGtMtyZBpsLi2BVxdzGUNSG34u8TQSTRx7vtWhhmmKoyI8oJy9Ksnz1K4qPx2L5vD1zwDqfFBKyQmfT1ZtjvXwKu/ft0BnN/e9ZcqdwtQLxx535k23X09qS4Sa4meFxvThgEwebRLOMvRpoXbfRPBPxTDoeUG0HPzRS4iN+kBsCNO2AsMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiy5ZruqSsm8joy45YnWygzgEcwyPIyfR/zz0EJ1Ov8=;
 b=DA1NnsbQG0Dt7Lg2vKrlas16dOW0cd0LAiRvvF07WR+GpZ1jr6o6aQj9Yz5wt8nWzeiKcYfRNjjhGaKjttC7xeIb3oo83Kdr0VolJepqitq10Xacm2BpaVIHB3W/F5hB68zZl/nDsrJfNHr1QTXjiLEekcGWdhaduGitCZjRkYI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5639.namprd04.prod.outlook.com (20.179.56.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Sat, 7 Sep 2019 18:23:29 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2241.018; Sat, 7 Sep 2019
 18:23:29 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH blktests] nvme: Add new test case about nvme
 rescan/reset/remove during IO
Thread-Topic: [PATCH blktests] nvme: Add new test case about nvme
 rescan/reset/remove during IO
Thread-Index: AQHVYjAymmeG/rz9xUG6+bkJ2WIU1A==
Date:   Sat, 7 Sep 2019 18:23:29 +0000
Message-ID: <BYAPR04MB5749BFB675992BCE031582E286B50@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190903081752.463-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd3d951f-82a6-4249-40e9-08d733c07b92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5639;
x-ms-traffictypediagnostic: BYAPR04MB5639:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BYAPR04MB5639EDB46940466396A130A586B50@BYAPR04MB5639.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:257;
x-forefront-prvs: 0153A8321A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(9686003)(8936002)(66476007)(3846002)(14444005)(110136005)(256004)(64756008)(6246003)(5660300002)(2501003)(66446008)(66946007)(316002)(66556008)(99286004)(7696005)(102836004)(66066001)(26005)(446003)(6116002)(53546011)(76116006)(86362001)(6506007)(186003)(476003)(478600001)(966005)(6306002)(71190400001)(25786009)(486006)(229853002)(53936002)(71200400001)(4326008)(54906003)(14454004)(33656002)(2906002)(6436002)(8676002)(55016002)(52536014)(76176011)(81156014)(305945005)(7736002)(81166006)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5639;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yoe7k4EMm72+jgBv0CLa/9lcVZkEh2wtiMhSwiHFSP+H2l5JM1LjD5HgRuum8He4ko7FOK8UIp6xI3xFN5zR6PwX3tA1D8aCkqcvk7yQgruXi+8lWdF72df/T/peOZp0a3UU5qW7rNPm0HdTfu6NLspqPldD4s9v1v9wl9S9PJIjejOyTikK6CZ5MpZ4u+r/pEhHRa8eMNzYPHvcl0iHyh2/0zE6Pu2duVEUJJcpcJ0UMsqf6zHdXLEcKZ2QsdW7ecVGybL5EIWdMhtD4XWPKzlCPJ3Eqvw8WL5zheOtvQuyTlCh/FIHumMFJnynRDs8yvL+4diOl37+JreK+9MdKxhnEiqc3KPZItaC7c82gNxSKYM49FjIPbTkoA9igcDFfughrWbhNw1Zr/+JzMupYclkdppALMBoFnG0ptnyios=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3d951f-82a6-4249-40e9-08d733c07b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2019 18:23:29.3835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KI4LBTiANmlQ6BXTm5W0cw7xt5WRY9Ur4YYR+xplDXSEatJjyL6Dlxhn+yrcFsEqEGo4WYliZdBSCCiAeNjil1Upmt1AEBwzGiRmukMbrcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5639
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/03/2019 01:18 AM, Yi Zhang wrote:=0A=
> Add one test to cover NVMe SSD rescan/reset/remove operation during=0A=
> IO, the steps found several issues during my previous testing, check=0A=
> them here:=0A=
> http://lists.infradead.org/pipermail/linux-nvme/2017-February/008358.html=
=0A=
> http://lists.infradead.org/pipermail/linux-nvme/2017-May/010259.html=0A=
>=0A=
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>=0A=
> ---=0A=
>   tests/nvme/031     | 43 +++++++++++++++++++++++++++++++++++++++++++=0A=
>   tests/nvme/031.out |  2 ++=0A=
>   2 files changed, 45 insertions(+)=0A=
>   create mode 100755 tests/nvme/031=0A=
>   create mode 100644 tests/nvme/031.out=0A=
>=0A=
> diff --git a/tests/nvme/031 b/tests/nvme/031=0A=
> new file mode 100755=0A=
> index 0000000..4113d12=0A=
> --- /dev/null=0A=
> +++ b/tests/nvme/031=0A=
> @@ -0,0 +1,43 @@=0A=
> +#!/bin/bash=0A=
> +# SPDX-License-Identifier: GPL-3.0+=0A=
> +# Copyright (C) 2019 Yi Zhang <yi.zhang@redhat.com>=0A=
> +#=0A=
> +# Test nvme pci adapter rescan/reset/remove operation during I/O=0A=
> +#=0A=
> +# Regression test for bellow two commits:=0A=
> +# http://lists.infradead.org/pipermail/linux-nvme/2017-May/010367.html=
=0A=
> +# 986f75c876db nvme: avoid to use blk_mq_abort_requeue_list()=0A=
> +# 806f026f9b90 nvme: use blk_mq_start_hw_queues() in nvme_kill_queues()=
=0A=
> +=0A=
> +. tests/nvme/rc=0A=
> +=0A=
> +DESCRIPTION=3D"test nvme pci adapter rescan/reset/remove during I/O"=0A=
> +TIMED=3D1=0A=
> +=0A=
> +requires() {=0A=
> +	_have_fio=0A=
> +}=0A=
> +=0A=
> +device_requires() {=0A=
> +	_test_dev_is_nvme=0A=
> +}=0A=
> +=0A=
> +test_device() {=0A=
> +	echo "Running ${TEST_NAME}"=0A=
> +=0A=
> +	pdev=3D"$(_get_pci_dev_from_blkdev)"=0A=
> +=0A=
> +	# start fio job=0A=
> +	_run_fio_rand_io --filename=3D"$TEST_DEV" --size=3D1g \=0A=
> +		--ignore_error=3DEIO,ENXIO,ENODEV --group_reporting  &> /dev/null &=0A=
> +=0A=
> +	# do rescan/reset/remove operation=0A=
> +	echo 1 > /sys/bus/pci/devices/"${pdev}"/rescan=0A=
> +	echo 1 > /sys/bus/pci/devices/"${pdev}"/reset=0A=
> +	echo 1 > /sys/bus/pci/devices/"${pdev}"/remove=0A=
Can you please use a variable for "/sys/bus/pci/devices/"${pdev}"/" ?=0A=
=0A=
Also we need to validate above files rescan/reset/remove with if [ -f ]=0A=
and report appropriate error if any of that is not preset.=0A=
=0A=
> +	sleep .5=0A=
> +	echo 1 > /sys/bus/pci/rescan=0A=
> +	sleep 5=0A=
> +=0A=
> +	echo "Test complete"=0A=
> +}=0A=
> diff --git a/tests/nvme/031.out b/tests/nvme/031.out=0A=
> new file mode 100644=0A=
> index 0000000..ae902bd=0A=
> --- /dev/null=0A=
> +++ b/tests/nvme/031.out=0A=
> @@ -0,0 +1,2 @@=0A=
> +Running nvme/031=0A=
> +Test complete=0A=
>=0A=
=0A=
