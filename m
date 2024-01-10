Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4E1481DE
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gxpzM2Vc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="z3d6sXVB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704889419; x=1736425419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/Vbwh3Zi/J5Sh5QGCWw3LcxniaD86izPaUp6ervrLSs=;
  b=gxpzM2Vc8Lkavjwuzs0/3GEmBzo6UoFSW1sUza7UyXU7JrfMU8u2qRoa
   SbzWsODFoRb46DtoMEXigLdbj125+g8TvTLCuWWsFZhuzxqcD7PjiM8jx
   ir5yXIS6It35aOv+bjH880kOBvuFjG9m88PsUs00o5rrawQntA8Plw5KH
   4Kkn6qg+AlRAY68xlM9ruDgdksJxq1gN1/DF+7hqPUvxex/r7606HfiaI
   l1qIScA/kD6/Rdvtwr+RqwTSk6bRc5jOtIHyhLWemdXqqQxsOXS4gfUyL
   H4bHJ3DUjmaULkMxT4sh9jDVWxrZqHNHrrMy+rVHCI+gP+LAK7ha0DKd6
   Q==;
X-CSE-ConnectionGUID: YZy/RtbWS3C1/AZ5MwQ4Sw==
X-CSE-MsgGUID: lEmkKnfOSLS5Z15W7g25Yg==
X-IronPort-AV: E=Sophos;i="6.04,184,1695657600"; 
   d="scan'208";a="7028955"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2024 20:23:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1lHWr5phBpLSe9XBhspkv3C3mxe53noo7FPcA/YoocmXEKKqjivM9tgU+KASE3OfCl+q2zOixaRBzPK1kJfWpewKoZrNAPLeF9v0/es3vtbeNPBoJ7+R/SOK+Z6loSyCKPA6oGdOptRJyloW1OM+Z9h9CbSZkW1j1Pbmo2HcvHu/DKGNU9aDfntBs3ar3Xq0R+jy52l7uHqx87rRGD9PVm63ZI+gYedMCwH4RF/s/uTXC7H/DgDL8UQbfn+jsxoYBSYD84Lb0qwXSR2vLe+2pDNVqj4kVDCtntY3j38ioLVCIM5FVV6+jBGka+D1GVNvdpws6Fa9WUs1cLFLdzVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ1LnzPb7bsIpiCDayMRtNMw+SrPdgwCl0dRQfx1QYQ=;
 b=oeOdLkI60GL5slrMSWe0E0f+0IzHMrB2H4PBSRqAslDJJuFpXm/ODj8ZFqltBS2HSja5/qolU2aTttnMwDiL9KMY3YrCDc4irKVYOYWXnZockez56RAyXuzrMJ5Rlmk4TLyiPzbA44DyyVytnxOxm5OU2nmwB/p/Rer4P3NgyCsbVZDAxVV39SLuLOgnFdhLpzS/YwKeKYeXo5l85DyK/XPBxyYkb08D/7wFj6WgpljP2VLFxeo5p3VpsKUP5uT9JF4fHi8Mi+Ia+94TpurcNc3AXlmucVhgug1E1MMInRsQ9ZroKc+tvx4A9KSLNNcSS70OpUqBZSuVKMoDKv0kjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ1LnzPb7bsIpiCDayMRtNMw+SrPdgwCl0dRQfx1QYQ=;
 b=z3d6sXVB85ZNKmT4L5pgHodn2OiBGa/NiylH8xSt2epPaqzwRrjbgYncKQaJX0VTq36Z04oxaGGaAifh35WCUc/rkayqDjeT++sWaHMGpGT2gv7u+RVWSWfUyJexbVSJyDvKvpl+vGMKuFJFHUtWblhNfalqL25GC5+vCcZ5JGQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6896.namprd04.prod.outlook.com (2603:10b6:208:1e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 12:23:35 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 12:23:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH] nvme: add nvme pci timeout testcase
Thread-Index: AQHaQ3lJXWqCfG9takit+D8rUbx257DS+LUA
Date: Wed, 10 Jan 2024 12:23:35 +0000
Message-ID: <wa3xm2v53vsgcs3iv4f3fy477zza6uwxj64dwib6ib27kmkgxj@ovgndmtcpzch>
References: <20240110035756.9537-1-kch@nvidia.com>
In-Reply-To: <20240110035756.9537-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6896:EE_
x-ms-office365-filtering-correlation-id: dbcf0fa2-aa59-4c56-22bd-08dc11d6f7ad
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PhdW5JY+u2Qib+3d++3JBA8c+mRp/4rJ19DDGjVe+X2Fpo3/mr+cRhtdZuWfoNPmJYHrH7nqhHpHsFuLD6+aFrYOfK/LX+V408I0vATJuB7hcbRf3Txqt5XmTsF9hlk04UWVSOh+aYa1vh4kyF86cPpPC+90ZIz2snLOZTTGvgxCFu1f2dbngbDiJZjOqpCI1rmjUAE8a3Ry4r3aTmIaRTgCA+OmN7Na6B3+iWE6qE3kF3+g7PIbl31zRFaHlJk0tg1B2Tx4O1Qf7HF9vOuNkEWfW+773rzz0B/G02wfLaeGETBbGf8VMi1F1RLjqcfvACtKz/egZqwtp/9bSF8SsU99lJ2Qsw/QK+euBU0qT9NhDap32XThA494s0apq4p4BzCueSfz8KMLqwqFQtJuT7oHNlibb9TIzScIkDqHjJQdEOIcY6SRTCaYiHAZNXpeGmMbxp2iKjVGNNNliRzMnXhWTp3o6WpbU6NE75lSgtT59WPCbyM0OPfk4sz5dGRPjAS4Uf4rVCDGTzRokTUMzcO2+p7Tv6rJiliKMuOy07b7SAlUl/AIOXplv4cFrCDNqv01Zu9pxH1QDkrIg30g213OzwKLJNJf/cTKd5q63sANgrKcD8hm2isjEcyYuiVm4f9hHW9yNnCT9QxdKz3mEw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6506007)(71200400001)(478600001)(66476007)(9686003)(66946007)(76116006)(6512007)(66556008)(64756008)(6916009)(66446008)(91956017)(54906003)(316002)(6486002)(8936002)(26005)(83380400001)(33716001)(41300700001)(5660300002)(2906002)(44832011)(4326008)(8676002)(38070700009)(38100700002)(122000001)(82960400001)(86362001)(27256008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?02fd9EzASPhRSfWsf10kq3KMc1gVLLJRJkm0rtc0A9LTdqfdY/zzE7+uhN1h?=
 =?us-ascii?Q?xfwvwk24y9BlUv+fJ0ZMW7hbqnTa4aAoSQrdjPBIUvNd2Xag/E8L2hOrxuCb?=
 =?us-ascii?Q?igK1P1GUBo/vrgXBN+IQBCno62ms5XIpoX/A5KpZgeeW4GECn2AUutdh4LHu?=
 =?us-ascii?Q?yicrJglOgehm4E9xWZmlVwEKpZnsakWWsd7MSR/ywqA5I6pzMbqPVWaIhAE5?=
 =?us-ascii?Q?YzCjKrb1NenF0KM5An1yHpkqN1tlUHmuKWiha2sae93LzYwdphD1AFuQhqwE?=
 =?us-ascii?Q?j0kbTV+5bry3kDcrbuApt++yjjbMQX16OfOQFNuU8/5OSolIVvloNuakvzno?=
 =?us-ascii?Q?h1S4gJb1KzSUmEQy7sSq6q+1klurm9/xQEfpyeW6ga9OqOHiKpxvV9uDqCuI?=
 =?us-ascii?Q?cwdNvwVLWi1t/n+FyCYfSTi/K95ZRGe3YNSwyVVcJ/qRN41hDAYHdZV80zKY?=
 =?us-ascii?Q?UA+dkOKX7MDrlwX1USoIpdLFC8DvFhZppHtWfZllOoxq3rr1J3weOCA+OD6h?=
 =?us-ascii?Q?Fmclg8XWAtTfhXuPMiELv43/KlRmFS3tthdLE0tUJkAvzwsmH7YV8pUSnd+b?=
 =?us-ascii?Q?bF2UrtP6NSoCD4/b+Iau9th+8qXXtCYf3Si9/P+0+EYPzDNk8OO79fFHdmvR?=
 =?us-ascii?Q?FKM37crx2Pm7GVUUJHNO8Q/NJuEh5SkgGaGe7+CoXwqZa+4v89jny2u5cYx5?=
 =?us-ascii?Q?Tt9zDBwGI6pg38omckWwg1+vsC3ziux+V2xcZPNRvIqtDt4jp9r+aSDzh4z1?=
 =?us-ascii?Q?uGFkHbViS2M0JFEWB2WD4x7SNK7jFU8Pkw0a4egGhYrd+VJQl/Zg4dFnuHnD?=
 =?us-ascii?Q?cxbIt9jTHjN5dH+KTn0Uwz+buWqtR5leYVoLn9qeHfcI3dSpsKLx4Omsnevf?=
 =?us-ascii?Q?WvXBKLkzSio00+s8O2NtEri3XT0Yas2NhhZLkf8MlZ0+6pNEeHZBDmsVFXs2?=
 =?us-ascii?Q?X2J2tmDgRTavrdRMRvr35bCG+U30eogVC15khWC7CVgQcEU6bcY6hs87MH1a?=
 =?us-ascii?Q?XzBocHgJ5JiTJonMPbD84whd8IGYVJESOUyE/Blf1b3YV8WZ+1Z3k58qHosO?=
 =?us-ascii?Q?736NPFvWlbYSXNu234mpdMtaNhYdTH7hqW/ajgs/9w4c30XykEnT20GuBkoD?=
 =?us-ascii?Q?GbWdI8mUeAu20S/WLoV0x73On7rZ7Iacx8jjpcPTQnLM5A3c7mUbPy3IKjoa?=
 =?us-ascii?Q?YmhhDVOMtVBcXnejCWa7IvMIBxQhb05gv1ms/RoTDNHHY9k2mVzEHHhpGH3L?=
 =?us-ascii?Q?Ymo+hqBEeE0cylvXAVGZkjx9RRKgJQMbLg98eclGYUVscj9eDd7dmx4BAzLE?=
 =?us-ascii?Q?sKZPF7XuOQGTPjpzsJ7ADsObFJrklxr+qkwyjCuJvYFEfgZhtCJvcjlalcyI?=
 =?us-ascii?Q?zklZmhG1ZDuZ6Oiq/W4cV/GXDHuhZwJDcxXSxBoZKi4DqFJHoBrN05muPWLi?=
 =?us-ascii?Q?nOGKwMf/cIi3hzIeN8nM+1HWH+TzK3NhKS1tOhMSLr1gafUBYNvBIaUb4J03?=
 =?us-ascii?Q?n9e/bYmC/hKWt24wfdDekmuEuzEcGENJzJYSLIJo8qVQ0CB0j5lpM1Up6hhy?=
 =?us-ascii?Q?COS8y/Vc/91B5HJRDzOqtWkwkllacK3TtZGJQC3AlN7rs6q1xlOKu5i0uQ0u?=
 =?us-ascii?Q?CuD8aGQNkWH/xQvn4PAuxWQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E03C2AE77C89694E866A241F9E59A73B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E5Zf/wW9c10dAy4lpPJZDtm+cEvV6yZGPvqFv1kAmuVdl0mbXqpcT3zhBcvJeKtvoHMDEP4uw/a1uMxDCQKHP0aU8hTXzS+WsPa+dRWQ84M1j9TDklWyICrlll5cs5++VDsfoMa1rrgc3/lyC9JYvTtAU8tHU3/4vD+Hx1aTviTZcZmkJfozt117bOthrKCM5vs+t/GLt2NLV8t4qhh4JZX0G3g4AYI6SDI+Xv9Z70bm+8bld+rWLf0DO8a0x96kE4480JP+pgfeUj+Cr9fjH8VbNkayfaoWtPfpAusffuQtp6HzwIQn5zBMJNAHgt9xLiWhKEbiysA5HthacxcI7VKv+IzOwZ35k8Gb4Dl+BZoHg8db1p5SszG4E/UqjBF8MY9fATOJoEUSR28looKu2b+ZGw1eapJc77eN0XD6YIxeL34elrcucLI71+gakMdIr0GphG13H7MQysJ2b7U2sjcUj3rUVIikfsfQvzumH8VmI42NvdGgZFJrPfp0pxuIyEPFQO/W0l9FqyUZtQ8jJkZaSOz1TaqjXr84xFvW0uGHmb79cFlQ8Rt9hFK6znot3VCXIYZK4rLNvGsnhZGTOb842SrlWiI942xCmlUBzJTpuE6nZBql8zcKDow+JmQc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcf0fa2-aa59-4c56-22bd-08dc11d6f7ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 12:23:35.5600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpnFn3xLJVzYAe3zpUvuyBtdWtkTU3THev3o6pvLZ/OLv91FxkReVKqnaQ8Zn1OI/KjaHzwi+CZOUdD3GWqBKTa3zI1I275yQgWtBi+v/78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6896

Thanks again for this test case. Please find my review comments. Tomorrow, =
I
will try to run this test case.

On Jan 09, 2024 / 19:57, Chaitanya Kulkarni wrote:
> Trigger and test nvme-pci timeout with concurrent fio jobs.

Is there any related kernel commit which motivated this test case? If so,
can we add a kernel commit or e-mail discussion link as a reference?

>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  tests/nvme/050     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/050.out |  2 ++
>  2 files changed, 45 insertions(+)
>  create mode 100755 tests/nvme/050
>  create mode 100644 tests/nvme/050.out
>=20
> diff --git a/tests/nvme/050 b/tests/nvme/050
> new file mode 100755
> index 0000000..ba54bcd
> --- /dev/null
> +++ b/tests/nvme/050
> @@ -0,0 +1,43 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Chaitanya Kulkarni.

Nit: you may want to remove the last '.'

> +#
> +# Test NVMe-PCI timeout with FIO jobs by triggering the nvme_timeout fun=
ction.
> +#
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"test nvme-pci timeout with fio jobs."

To be consitent with other test cases, let's remove the last '.'.

> +
> +requires() {
> +	_require_nvme_trtype pci
> +	_have_fio
> +	_nvme_requires

This test case depends on the kernel config FAIL_IO_TIMEOUT. Let's add

    _have_kernel_option FAIL_IO_TIMEOUT

> +}
> +
> +test() {
> +	local dev=3D"/dev/nvme0n1"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	echo 1 > /sys/block/nvme0n1/io-timeout-fail
> +
> +	echo 99 > /sys/kernel/debug/fail_io_timeout/probability
> +	echo 10 > /sys/kernel/debug/fail_io_timeout/interval
> +	echo -1 > /sys/kernel/debug/fail_io_timeout/times
> +	echo  0 > /sys/kernel/debug/fail_io_timeout/space
> +	echo  1 > /sys/kernel/debug/fail_io_timeout/verbose

To avoid impact on following test cases, I suggest to restore the original
values of the fail_io_timeout/* sysfs attributes above at the end of this
test case. _nvme_err_inject_setup() and _nvme_err_inject_cleanup() in
test/nvme/rc do similar thing. We can add new helper functions in same mann=
er.

> +
> +	# shellcheck disable=3DSC2046
> +	fio --bs=3D4k --rw=3Drandread --norandommap --numjobs=3D$(nproc) \

Double quotes for "$(nproc)" will allow to remove the shellcheck exception,
probably.

> +	    --name=3Dreads --direct=3D1 --filename=3D${dev} --group_reporting \
> +	    --time_based --runtime=3D1m 2>&1 | grep -q "Input/output error"
> +
> +	# shellcheck disable=3DSC2181
> +	if [ $? -eq 0 ]; then
> +		echo "Test complete"
> +	else
> +		echo "Test failed"
> +	fi
> +	modprobe -r nvme

If nvme driver is built-in, this unload command does not work.
Do we really need to unload nvme driver here?

> +}
> diff --git a/tests/nvme/050.out b/tests/nvme/050.out
> new file mode 100644
> index 0000000..b78b05f
> --- /dev/null
> +++ b/tests/nvme/050.out
> @@ -0,0 +1,2 @@
> +Running nvme/050
> +Test complete
> --=20
> 2.40.0
>=20
> =
