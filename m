Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C944FC4740C
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 17:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC2921479
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 17:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o3oOhHKs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SEA6gacy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfIIRED (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:04:03 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39649 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfIIREC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 13:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568048653; x=1599584653;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IakGlJc2u5caRzbzpkFeEW3+fWxl6efCxRjL5MKvlto=;
  b=o3oOhHKs4yDggYNOS30ttFPio/lQEqoLWgzmJWeG954ti20xkR9x8XLi
   mMMC/VT7vGfgQBi10UlWKPfVi+NrUeZrMhjcAV1qcAoB07VDNNPDhzHIE
   SVkt4Ld4tsRDLsv4Dr/R78K6FY9iqAP1xTlaufQKNSug0iWgtDi9Afo07
   16ia3ovUAiLxrw6/HbmGmPn1S4tYLi2CbdsTgusi38CClC9EtNJoQ6OFX
   m5GffT8+EewX942jfNrYP03BIgK+37c/D+RbqM5wNS/vTHOoxMYmKyiof
   3TsEhs0Uwdx5WCUxGCpL1lHJTQrpQG/hMdMCkrLtw/1jL1yxj25/aON9a
   Q==;
IronPort-SDR: l9MmXwkFNEobzGHW+a73ems2OZLGTLv7slDb9fmFdPP4f+08Kw9sbUZT4G1EuaL1t0FfIkL3eW
 cj4aPAxODg7tXbEmDt0MzpjjjiAJCR4PiXDvLrtBwtq1ZvfA7L59cRVaZLfWY8EegmajYz2HrT
 fGQUO3ohsAP30adTwOjF9tryVC0WKlcvp+uM6MQmDNlyEDXrLfF4IJRYv/IxiZF/LiI4pdIY88
 EsJfT9tPav0Il2GDma3e/pNi7m9IGnNRDvmJUlpc5quGWR3h+WtCXIeNqf5Gj0XBgZqtMF03TH
 mqo=
X-IronPort-AV: E=Sophos;i="5.64,486,1559491200"; 
   d="scan'208";a="218508179"
Received: from mail-co1nam03lp2053.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.53])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2019 01:04:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezF1yBuqPgKEEqY1Z9BfaGwc/cfMsfLKx+6GcqfzdHdpUnw/pwyauaCWsMEPcvsM6cXxLO2MY+hlgcCrzouk0yS5NPgmqZPKC6oIc39BtvOuAAytEqi1cPBIj/6sjfvmf7rcUEExAPgtcwkP4BBydR5xlQwN7eRAgXqU48xnT6r79LrWm1dnL5BoIGHfYhhzEcbYdhvt32TSaftwNbproE3o1wJjGAS//VaNs6xcrU2/6p5iKDYBVCx/QeMIE8DwW4yoeh19OJGkBpvsgaEH1eJMUGVUMz6QiTBGj4+XYsdXQn00fyxvaGUslYP22JHKUqlZKw2oP8m7K1JUijP3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i7qtjOJ9mqRccxKOuDdwpd/dSxB6uMaIEBkvOaTPx8=;
 b=KHyhJcNDWFSQohcJ46dXf0ESLU/0W69VXc2p3o/7ridm4kDu3aCJ3hje8DclhwEPFqwJFGnAoIafrTWvIYIOSVQgi1KmdvtiLnpBJYzPoF8YdqcWL69Pq/26jLU9oHDBFbqUKdv0xszDaBetlEIWOCvZM2qdyQeZy9zrvcD86dQXpxevC1VVTwQhpCZHNkAmcySFEo+SYOC43IRziNKIDtVzPtrIyncDSOOEPR3rfNb89vRYV2oOixTv/fSavLQC4AVsUgPnnCtWEQ7vbLFvlonHuDcOHwVB7t1+czmsX49wpkePtUP4LEjZDBa/90VgQxl7TXe3l6f+Aq8D8/1M1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i7qtjOJ9mqRccxKOuDdwpd/dSxB6uMaIEBkvOaTPx8=;
 b=SEA6gacyRvm+kNREqy2yWuQli2jVvxg9p/gpikehn1DS/k6ZjybrsUjri5T+/nNHbiJUYCcZySBSDRER8H/60Y49vG/mjaUMOD4eCZxHpUS/8uAhN9Vt+sR6YfvFGg7GzT6CH+eDzFjCsW4Wiu/4l5Jhrc2+h3yTSR+ycGkKs50=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5621.namprd04.prod.outlook.com (20.179.56.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 17:03:57 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 17:03:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "osandov@osandov.com" <osandov@osandov.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH V2 blktests] nvme: Add new test case about nvme
 rescan/reset/remove during IO
Thread-Topic: [PATCH V2 blktests] nvme: Add new test case about nvme
 rescan/reset/remove during IO
Thread-Index: AQHVZy5TlDgBo+1cGEaw3cimxHpSFg==
Date:   Mon, 9 Sep 2019 17:03:57 +0000
Message-ID: <BYAPR04MB57492918C78F461EDF94D23586B70@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190909164537.2729-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75b256da-716d-4a56-4d2d-08d73547b428
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5621;
x-ms-traffictypediagnostic: BYAPR04MB5621:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BYAPR04MB56216A28ABF5CE1E61998E5D86B70@BYAPR04MB5621.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(25786009)(54906003)(8936002)(316002)(966005)(478600001)(3846002)(26005)(186003)(6116002)(486006)(476003)(2906002)(53936002)(305945005)(33656002)(110136005)(229853002)(55016002)(6246003)(9686003)(74316002)(6306002)(52536014)(66476007)(71190400001)(71200400001)(86362001)(6436002)(64756008)(66446008)(66556008)(2501003)(256004)(446003)(4326008)(5660300002)(66066001)(81156014)(81166006)(6506007)(7736002)(76116006)(102836004)(99286004)(14454004)(7696005)(66946007)(8676002)(76176011)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5621;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tIShDW7BAr9wZmCzgF2K02TADSluPqzpD80iV22CIZn5CfCm22R3cT4OKLsVnrWRhMgxV3lvglwWVBquAifXVWsH3TSiaF1pPFwd8n6YNStyjSaGljuhpRJWqpSiivrWRGRW0yNb66/HDcSeVueRUc8L2qYK58XSMv24svRIYBHPCBybZDkeir8Ts1OZ6wRx8S2j6yDKBewncD5w11uTfd7ATG6ipK/CC13rAXrFnkCpgw6YKryZ7jaLQ8EzjqbEd/hpY2JfICSS6HptbbB3ynawJbCYSVYNhAcgkxfC0gVinepMwYDFYzeId6TGn7L8RbnWEVKGollfs1msiuH3Xgl7dpjR457ugDUzfyATtlpkZxIJxjhFim+sWK8LLv11n+VmB5V8beVOjpXL5pi74W/pgXS6YZiuNOTJ1ug8BQs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b256da-716d-4a56-4d2d-08d73547b428
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 17:03:57.6325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzYaamgVhYJZa+JbJJYe6afyH27P718dKjW/o98282fawrJYAGJHdiYRuQWspV5811+ylp759nyXqdmYDwLmi4FgIpRKcziU3ArEo1/ZlLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5621
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/09/2019 09:47 AM, Yi Zhang wrote:=0A=
> Add one test to cover NVMe SSD rescan/reset/remove operation during=0A=
> IO, the steps found several issues during my previous testing, check=0A=
> them here:=0A=
> http://lists.infradead.org/pipermail/linux-nvme/2017-February/008358.html=
=0A=
> http://lists.infradead.org/pipermail/linux-nvme/2017-May/010259.html=0A=
>=0A=
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>=0A=
> ---=0A=
>=0A=
> changes from v1:=0A=
>   - add variable for "/sys/bus/pci/devices/${pdev}"=0A=
>   - add kill $!; wait; for background fio=0A=
>   - add rescan/reset/remove sysfs node check=0A=
>   - add loop checking for nvme reinitialized=0A=
>=0A=
> ---=0A=
> ---=0A=
>   tests/nvme/031     | 71 ++++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>   tests/nvme/031.out |  2 ++=0A=
>   2 files changed, 73 insertions(+)=0A=
>   create mode 100755 tests/nvme/031=0A=
>   create mode 100644 tests/nvme/031.out=0A=
>=0A=
> diff --git a/tests/nvme/031 b/tests/nvme/031=0A=
> new file mode 100755=0A=
> index 0000000..db163a2=0A=
> --- /dev/null=0A=
> +++ b/tests/nvme/031=0A=
> @@ -0,0 +1,71 @@=0A=
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
> +	local sysfs=3D"/sys/bus/pci/devices/${pdev}"=0A=
> +=0A=
> +	# start fio job=0A=
> +	_run_fio_rand_io --filename=3D"$TEST_DEV" --size=3D1g \=0A=
> +		--group_reporting  &> /dev/null &=0A=
> +=0A=
> +	sleep 5=0A=
> +=0A=
> +	# do rescan/reset/remove operation=0A=
> +	if [[ -f "${sysfs}"/rescan ]]; then=0A=
> +		echo 1 > "${sysfs}"/rescan=0A=
> +	else=0A=
> +		echo "${sysfs}/rescan doesn't exist!"=0A=
> +	fi=0A=
> +	# QEMU VM doesn't have the "reset" attribute, skip it=0A=
> +	if [[ -f "${sysfs}"/reset ]]; then=0A=
> +		echo 1 > "${sysfs}"/reset=0A=
> +	fi=0A=
=0A=
> +	if [[ -f "${sysfs}"/remove ]]; then=0A=
> +		echo 1 > "${sysfs}"/remove=0A=
> +	else=0A=
> +		echo "${sysfs}/remove doesn't exist!"=0A=
> +=0A=
> +	fi=0A=
=0A=
This is a lot of code repetition. You should be creating one helper=0A=
and passing just file names. (No need to check the return value).=0A=
something like this :-=0A=
=0A=
check_sysfs()=0A=
{=0A=
	local sysfs_attr=3D$1=0A=
=0A=
	if [[ -f "${sysfs_attr}" ]]; then=0A=
		echo 1 > "${sysfs_attr}"=0A=
	else=0A=
		#TODO : add a check to not print if sysfs_attr is not=0A=
                 #reset=0A=
		echo "${sysfs_attr] doesn't exist!"=0A=
	fi=0A=
}=0A=
and call above function here :-=0A=
=0A=
	for i in rescan remove reset; do=0A=
		check_sysfs_attr $i=0A=
	done=0A=
=0A=
> +=0A=
> +	{ kill $!; wait; } &> /dev/null=0A=
> +=0A=
> +	echo 1 > /sys/bus/pci/rescan=0A=
> +=0A=
> +	# wait nvme reinitialized=0A=
> +	local m=0A=
Please declare all the local variables at the start of the function.=0A=
=0A=
Do we need to call udevadm settle here ?=0A=
=0A=
> +	for ((m =3D 0; m < 10; m++)); do=0A=
> +		if [[ -b "${TEST_DEV}" ]]; then=0A=
> +			break=0A=
> +		fi=0A=
> +		sleep 0.5=0A=
> +	done=0A=
> +        if (( m > 9 )); then=0A=
> +                echo "nvme still not reinitialized after 5 seconds!"=0A=
> +        fi=0A=
Please recheck the alignment in the above if.=0A=
=0A=
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
