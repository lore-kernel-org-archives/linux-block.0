Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179F9C433FE
	for <linux-block@archiver.kernel.org>; Mon,  9 May 2022 10:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiEIK4q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 May 2022 06:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiEIK4o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2022 06:56:44 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC9A239DBE
        for <linux-block@vger.kernel.org>; Mon,  9 May 2022 03:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652093566; x=1683629566;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7I2kmCPRO/TOX+pBoKMwGJfdFvL5d05+wD6NcMMZ3Wk=;
  b=S/Fx1jbp5XhretnKmy8b9Y4tuawQke/ipZTigzrTO4cHkJF/kCOYpMSu
   eY4KCZxSorFPBl2rIw8Cab409xKYSF0uUxORU1iSrl3ADlQT0zv8mW+m3
   8qBumicHsNdMG/I0u/w+5T77ZVJeAwvQtKdf30A1Ku6gsoVdrys42XRDY
   Q761R5i2jvesj2u9GXJ+uG9U/XRY8rrdvHrATXAXlc34J+n1/lnBsfX2X
   a0eRrTsvSPSf2W23VIQZn5dWR5fa3koOHVPdESoqJeHUbty3W3yLwyWMX
   O6fOzMDL4wUF64inKjZMEmzkv+ubsZr1DxtKDx/yqpxf1BM0g5NdecDD9
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647273600"; 
   d="scan'208";a="204726668"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2022 18:52:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/SX/3cLIuZ5Gi6FGc26gQstkES7z+phb03lm9ZxUYXVxhl5u1iBRz5w9EI1r2NkQfo3H9TIChcXLESNLZ9dTdN3o2BKnxVJrPVGiXxNl8kkcwrOgVjxDm4LYzxlddocRE9MtQXCoa+dtWYgG6M6eaqaZCEfnHyJVnaDHoN5J/aqWWxx01OHTdpvd1xYQvd1fTmAQXYybnIAqe35ElWuMdl8inMufZXFjd/r5F6e4xZqROLV8TKSBu88oyI4/Ykp2h/xkTtNnbgRHI5WXrgB5XatZduXDv+GcpKuvYnrf98spJhXxN0pnCBR/wAboWspr0xsFOou3kQ+YY2rXfiNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+T1q2gG7tRFooHT2Q8Z1LDl5KLp6DWPgRfQ8PB5wlE=;
 b=XRwVPb+ZVWfxh4bgdXM5TefGi9woRtDESmeJkMgTnVLbXq9v+BE9su6iy47HilEGCwAg5+r+a5zqkrd69dCp3nQmAnhTloHayeNUljDl2EMAva9F5hBqokJLb6gbepPirk+YQwCTtwqcOL4bCqljigWwlVVVAwfggjSWk90hjH+Ey4wt74wL2KvyFPeQzLSOLnSjSIBIyiWjr9AXtU5omAPIxUwAJHFGWC5EoKOMJ6H/QUztgtldxbGcjGU2FCSWs6qd8yqR4d1wvJ0d4fdALuHVzULcRhT2Tt9frh7mRf9hktO1YonN/wNe3BFNvIhvh+6Ax5RUDVeqTkpiD11aoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+T1q2gG7tRFooHT2Q8Z1LDl5KLp6DWPgRfQ8PB5wlE=;
 b=N+4i1VJS8BV8i/qzQUZZfFN2x00CTtDB4cERk0pEN1i4TZtYkJN6OVhJuWNJB7kwMmR/fa6NhAEMLhmoRksoSqXCj+1giXjCXWuqKULGQuuP3y9D5lhOYt7xDlfV+6Sywxr9/zspixR2/YKaEPPkEFmA1l2mFiw1bacsf/OANXc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7806.namprd04.prod.outlook.com (2603:10b6:a03:3bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 10:52:43 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 10:52:43 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Alan Adamson <alan.adamson@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH blktests] tests/nvme: add tests for error logging
Thread-Topic: [PATCH blktests] tests/nvme: add tests for error logging
Thread-Index: AQHYY5LoxN9/E1n1A06/XzIzJlIIEg==
Date:   Mon, 9 May 2022 10:52:43 +0000
Message-ID: <20220509105242.hv52nmc7yqd4chnz@shindev>
References: <20220429220946.22099-1-alan.adamson@oracle.com>
In-Reply-To: <20220429220946.22099-1-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e54bb663-d632-4435-f1a7-08da31aa0b9a
x-ms-traffictypediagnostic: SJ0PR04MB7806:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB780611E9CE758ECFF8AB2AAEEDC69@SJ0PR04MB7806.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4kHtRxR6IjamqOruoWGetlAxUnn2OQqElfBRnE9LRY36qd3UBCMTfMJTddYqXalzlZnqNYBNoojW5mHYYtTS8iXJ7fCR0GudOB9ONBB389dZ+2fbSmfT1ANDRyyCwJa8U1sGpgDW3gKbVGzSpTs+8hpwU/jDET0ZX4uZFau1wJo60j8gTbjhy9OL4uILGa1XoR34G6jvw5D6E4TGLN3HvICJYlc3u/cnteZI6Ipd5ewPlwUBuRil9PjyXsQ71x70NR0OelqI8UXzrZC6/rQ9YVJKGKL+DUARxHZ1TufXyvidWK2hiifdzT1mmaSrQIzFBynMaTTygi/B9XY443sRZvvnGFFknOea6WhmPPw5jQLDIKEpZPEi3iWfCjOf4tK8Sa28v4+jvp+t03YW6/qz0TtfA6m/Ei+5CEvvEihv/KBJm3d0P2lKfc8Pcl8CmggQiuQaKBypEr4uKhfpEvto5iQM35M4GhyhAlJ2hn+tMluFQ9oVozxynWwVxdpwpRyj4GmQTCHCzG4IC2WLmCeHuTxg2po/iJZaRN3vbLEKJdqMiXAwU0zOsw4SuwmnZgKdu6VRlz6Cutf+xqtPuEKKGqJU7CWk+hssytIQILk1m0m1BBOVqc/Q1lbr5CfArHb/NzzJQu74eJ2Kf/ggRKcpEXw+OR4hfiM/Ud3weZ146vv5Wi/KaDg3GqeE6Zt6yfs2FMSrY8RyHbsZoslrxK5N8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(76116006)(186003)(66946007)(91956017)(66476007)(64756008)(66446008)(66556008)(44832011)(8936002)(6512007)(26005)(83380400001)(5660300002)(9686003)(8676002)(4326008)(1076003)(38100700002)(86362001)(508600001)(33716001)(6916009)(6506007)(54906003)(6486002)(2906002)(38070700005)(82960400001)(316002)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TT2+Ni7beg92/KS1MG8oQuHo3qbI37J2er72U/0VFa1mP+vC6gWqhXVUeEKn?=
 =?us-ascii?Q?BowMw3B04X9HjDeNV7P22/7G4nutBCW9u49bUrdzkvrUHN/EuWrX+6ubwJi3?=
 =?us-ascii?Q?g/kDGr6BrfgbHO7zVPgPX++dRpjfmg5OO1x41+KJgZVJ9cbt36qbSYO8cOpN?=
 =?us-ascii?Q?MlZrAzV4xhi8qdn4erF1dR94sRKpaW30qUO6Bp1e5HWo3iIMfZ80cApJLcaI?=
 =?us-ascii?Q?W2t8mE/83etF6Qp6GMKt8MdTgeCjBMJxZjMexNtwEVCsHoQX7DKNTDi2SrzH?=
 =?us-ascii?Q?EehOoY28UA+HAmb4kCxEOKQHOPqiZ1++YRTnU4oLg9IplvMkxfxxT5aU102v?=
 =?us-ascii?Q?TYqRO6b94+p3Np12+WAeU9dGmlqFoqEvjIkvIEza4ngUmx3M6HnOjoS9YJlp?=
 =?us-ascii?Q?ufFcRgFvFlSgxmdw25P/McUqrFxE/hX2yvgT3rqMAQS6vYPOJ0BXHu5fS8KH?=
 =?us-ascii?Q?8LgPw70i8lLLKoepQBeUaqwZ7639zi+K0+P87o4p3271+85w0pAR5brRmBaw?=
 =?us-ascii?Q?r11WHz5dnrp0LiD591BLJJiJ4FZbjdmhUWt1KYJYz+xpPzrcCxNqVUqCgxkA?=
 =?us-ascii?Q?laRtjQQcJfB+PrgL/ZD9JMcOjck8e4UjXbLEi1GvfQXUvfSI8i/bPexWZcYv?=
 =?us-ascii?Q?cEeN+c4N+RycGM62WZ7zE9XvlF1L09XkzniyHw2KXh+JSJSCywC5zIlCfuyH?=
 =?us-ascii?Q?95uk8JV/0J8qfQ8GYVWKtSe4dN8z4435vn7NH9Umtk32GODVPOiCzajfgxN2?=
 =?us-ascii?Q?gxEsNdTFBVDbtKsnCrfllVgv2V3RS4hC+Szw8p9slTaqTL5rM0vfBYuwnMMi?=
 =?us-ascii?Q?yvKzlwHPkIvuikN3rkQ9OSm5VVoEnBHarxkjQy6wRh0lJM7kVLMgw7mfyBOw?=
 =?us-ascii?Q?dXbdObGP9M0ZZkj5IpmrYy2Z7T98EkzQR+76NfDwmZbZy5Q22w1Yf/Abysn/?=
 =?us-ascii?Q?Q1JrBVUR1tODUorc8qmDHeQ4glIus64SoUKTt6KLgPDGC8v3A2RbFp1rgubs?=
 =?us-ascii?Q?9UUh4CeKeg8dLlJkg647DXYUmP2qWPgM258m+OwwlOvYpEqMKwwVoReCKjkv?=
 =?us-ascii?Q?q7PVvUlO6xW2fUdIcqOclT6aEx5VC/zDlhu43+ZEkVOu71/CEqp3owvKpif7?=
 =?us-ascii?Q?Ffl84GTdO5jzosArEVjcuu8gcZmFhsWJqVbxhhdriW/xeWVR20FKLv83p3TE?=
 =?us-ascii?Q?uPemWEx9QtGEfGswVWqqgdy6xUqTQunkO9WjR+qWnYYt6zLCugmsFFBccjrk?=
 =?us-ascii?Q?8jMCGUmWWnwxHCn9Nct5N0+Rj4kBWz9BWbWo6FKmCXS3N/L9KcQjvafzLHkS?=
 =?us-ascii?Q?1Xh7lOKEYBMUIUwHawhbwrtNYq8X94QH2Xh/uTbtC1ttbC9f0Y+QvfiE6dVV?=
 =?us-ascii?Q?KUNU2L1m9SlAFNUcTaiy329kE6pU5hGxV4mIfT7rjGVjHUDx33BAsPBgbpOf?=
 =?us-ascii?Q?Y6a/KKogo3B8CX7pJkQUlh2RfQN7lDE4Cs01SCzEv8xVscGWmqYXZjRKQq/0?=
 =?us-ascii?Q?gsoOxdwlxC/1EclCiUA1Voq7P75rOWxJ6a7Pd2haYbHPQ1y06bsZeNWWI2Mw?=
 =?us-ascii?Q?nG6JB77mem5qMI6Bgqjvi4Smw15sOAkV6sZa0wDc7gri0oipfY+7wVJmP8y/?=
 =?us-ascii?Q?+naqU6tISpr0oBAHcicfPT+BM4qTJ4Dip7xSAfkQdcar7QEFq9rUX8VvGJV9?=
 =?us-ascii?Q?vil4mbdbQf24rjmHFwSTNMQdvbnhWC9wLPX/7OjmipNUVXyd/7JWhhTwvqlC?=
 =?us-ascii?Q?cdPlyCpLCVpidNtAdV2wcjSnA0UG2IW2qERY3VgONBk1b6OJnDoI?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1FCCE1ADE2E29C4D88A092EAA8A7F4E1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54bb663-d632-4435-f1a7-08da31aa0b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 10:52:43.5095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0FlHwjzfTjTitXoBOZ9YyMcJ+xrKk0XX3zFlVgx7NZtpw+wfoOacixLcq/bvdcKxQE6kFpu1Ts9aAoZtJuwJ+kevdBHz6qK7yzijZJsT9zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7806
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Alan,

I ran the test case this patch adds and confirmed it works as expected. Goo=
d.
I found some points to improve in the patch. Please find my comments in lin=
e.

On Apr 29, 2022 / 15:09, Alan Adamson wrote:
> Test nvme error logging by injecting errors. Kernel must have FAULT_INJEC=
TION
> and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can =
be
> run with or without NVME_VERBOSE_ERRORS configured.
>=20
> These test verify the functionality delivered by the follow commit:
>         nvme: add verbose error logging

The commit was already up-streamed. It will be helpful to add git hash of t=
he
commit.

>=20
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  tests/nvme/039     | 174 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/039.out |   7 ++
>  2 files changed, 181 insertions(+)
>  create mode 100755 tests/nvme/039
>  create mode 100644 tests/nvme/039.out
>=20
> diff --git a/tests/nvme/039 b/tests/nvme/039
> new file mode 100755
> index 000000000000..e30de0731247
> --- /dev/null
> +++ b/tests/nvme/039
> @@ -0,0 +1,174 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2022 Oracle and/or its affiliates
> +#
> +# Test nvme error logging by injecting errors. Kernel must have FAULT_IN=
JECTION
> +# and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests c=
an be
> +# run with or without NVME_VERBOSE_ERRORS configured.

It will be helpful to note the kernel commit here also.

> +
> +. tests/nvme/rc
> +DESCRIPTION=3D"test error logging"
> +QUICK=3D1
> +
> +requires() {
> +	_nvme_requires
> +	_have_kernel_option FAULT_INJECTION && \
> +	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
> +	_have_program dd && _have_program nvme _have_program sed

I think the line above is not required. dd and sed are so common and we can
assume they are available. And _nvme_requries checks the nvme command.

> +	_require_nvme_trtype_is_loop

Can't we run this test with transport type other than loop?

> +}
> +
> +save_err_inject_attr()
> +{
> +	ns_dev_verbose_save=3D$(cat /sys/kernel/debug/"${ns_dev}"/fault_inject/=
verbose)
> +	ns_dev_probability_save=3D$(cat /sys/kernel/debug/"${ns_dev}"/fault_inj=
ect/probability)
> +	ns_dev_dont_retry_save=3D$(cat /sys/kernel/debug/"${ns_dev}"/fault_inje=
ct/dont_retry)
> +	ns_dev_dont_status_save=3D$(cat /sys/kernel/debug/"${ns_dev}"/fault_inj=
ect/status)
> +	ns_dev_dont_times_save=3D$(cat /sys/kernel/debug/"${ns_dev}"/fault_inje=
ct/times)
> +	ctrl_dev_verbose_save=3D$(cat /sys/kernel/debug/"${ctrl_dev}"/fault_inj=
ect/verbose)
> +	ctrl_dev_probability_save=3D$(cat /sys/kernel/debug/"${ctrl_dev}"/fault=
_inject/probability)
> +	ctrl_dev_dont_retry_save=3D$(cat /sys/kernel/debug/"${ctrl_dev}"/fault_=
inject/dont_retry)
> +	ctrl_dev_dont_status_save=3D$(cat /sys/kernel/debug/"${ctrl_dev}"/fault=
_inject/status)
> +	ctrl_dev_dont_times_save=3D$(cat /sys/kernel/debug/"${ctrl_dev}"/fault_=
inject/times)
> +}
> +
> +restore_error_inject_attr()
> +{
> +	echo "${ns_dev_verbose_save}" > /sys/kernel/debug/"${ns_dev}"/fault_inj=
ect/verbose
> +	echo "${ns_dev_verbose_save}" > /sys/kernel/debug/"${ns_dev}"/fault_inj=
ect/verbose
> +	echo "${ns_dev_probability_save}" > /sys/kernel/debug/"${ns_dev}"/fault=
_inject/probability
> +	echo "${ns_dev_dont_retry_save}" > /sys/kernel/debug/"${ns_dev}"/fault_=
inject/dont_retry
> +	echo "${ns_dev_dont_status_save}" > /sys/kernel/debug/"${ns_dev}"/fault=
_inject/status
> +	echo "${ns_dev_dont_times_save}" > /sys/kernel/debug/"${ns_dev}"/fault_=
inject/times
> +	echo "${ctrl_dev_verbose_save}" > /sys/kernel/debug/"${ctrl_dev}"/fault=
_inject/verbose=20
> +	echo "${ctrl_dev_probability_save}" > /sys/kernel/debug/"${ctrl_dev}"/f=
ault_inject/probability
> +	echo "${ctrl_dev_dont_retry_save}" > /sys/kernel/debug/"${ctrl_dev}"/fa=
ult_inject/dont_retry
> +	echo "${ctrl_dev_dont_status_save}" > /sys/kernel/debug/"${ctrl_dev}"/f=
ault_inject/status
> +	echo "${ctrl_dev_dont_times_save}" > /sys/kernel/debug/"${ctrl_dev}"/fa=
ult_inject/times
> +}

The two functions above repeat similar lengthy lines. How about to use
associative arrays to avoid the repetition?

declare -A NS_DEV_FAULT_INJECT_SAVE
declare -A CTRL_DEV_FAULT_INJECT_SAVE

save_err_inject_attr()
{
	local a

	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
		NS_DEV_FAULT_INJECT_SAVE[${a}]=3D$(<"${a}")
	done
	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
		CTRL_DEV_FAULT_INJECT_SAVE[${a}]=3D$(<"${a}")
	done
}

> +
> +set_verbose_prob_retry()
> +{
> +	echo 0 > /sys/kernel/debug/"$1"/fault_inject/verbose
> +	echo 100 > /sys/kernel/debug/"$1"/fault_inject/probability
> +	echo 1 > /sys/kernel/debug/"$1"/fault_inject/dont_retry
> +}
> +
> +set_status_time()
> +{
> +	echo "$1" > /sys/kernel/debug/"$3"/fault_inject/status
> +	echo "$2" > /sys/kernel/debug/"$3"/fault_inject/times
> +}
> +
> +inject_unrec_read_err()
> +{
> +	set_verbose_prob_retry "${ns_dev}"
> +#	Inject a 'Unrecovered Read Error' error on a READ

One liner comments in this patch have weird position of '#'. I suggest to p=
lace
it at same column offset as code.

> +	set_status_time 0x281 1 "${ns_dev}"
> +	dd if=3D"${TEST_DEV}" of=3D/dev/null bs=3D512 count=3D1 iflag=3Ddirect =
2> /dev/null 1>&2

Some lines in this patch exceeds 80 characters. I suggest to fold them into=
 two
lines with backslashes.

> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -2 | grep "Unrecovered Read Error (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
> +		    sed 's/I\/O Error/Unrecovered Read Error/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +inject_invalid_read_err()
> +{
> +#	Inject a valid invalid error status (0x375) on a READ
> +	set_status_time 0x375 1 "${ns_dev}"
> +	dd if=3D"${TEST_DEV}" of=3D/dev/null bs=3D512 count=3D1 iflag=3Ddirect =
2> /dev/null 1>&2
> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -2 | grep "Unknown (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
> +		    sed 's/I\/O Error/Unknown/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +inject_write_fault()
> +{
> +#	Inject a 'Write Fault' error on a WRITE
> +	set_status_time 0x280 1 "${ns_dev}"
> +	dd if=3D/dev/zero of=3D"${TEST_DEV}" bs=3D512 count=3D1 oflag=3Ddirect =
2> /dev/null 1>&2
> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -2 | grep "Write Fault (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
> +		    sed 's/I\/O Error/Write Fault/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +inject_id_admin()
> +{
> +#	Inject a valid (Identify) Admin command
> +	set_status_time 0x286 1000 "${ctrl_dev}"
> +	nvme admin-passthru /dev/"${ctrl_dev}" --opcode=3D0x06 --data-len=3D409=
6 --cdw10=3D1 -r 2> /dev/null 1>&2
> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -1 | grep "Access Denied (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -1 | grep "Admin Cmd(" | sed 's/Admin Cmd/Identify/g' =
| \
> +		    sed 's/I\/O Error/Access Denied/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +inject_invalid_cmd()
> +{
> +#	Inject an invalid command (0x96)
> +	set_status_time 0x1 1 "${ctrl_dev}"
> +	nvme admin-passthru /dev/"${ctrl_dev}" --opcode=3D0x96 --data-len=3D409=
6 --cdw10=3D1 -r 2> /dev/null 1>&2
> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -1 | grep "Invalid Command Opcode (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -1 | grep "Admin Cmd(" | sed 's/Admin Cmd/Unknown/g' |=
 \
> +		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +test_device() {
> +	local nvme_verbose_errors;
> +	local ns_dev;
> +	local ctrl_dev;

The semicolons above are not required. Same for nvme_verbose_errors substit=
ues
below.

> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if _have_kernel_option NVME_VERBOSE_ERRORS; then
> +		nvme_verbose_errors=3Dtrue;
> +	else
> +		unset SKIP_REASON
> +		nvme_verbose_errors=3Dfalse;
> +	fi
> +
> +	ns_dev=3D$(echo "${TEST_DEV}" | sed 's/\/dev\///g')
> +	ctrl_dev=3D$(echo "${TEST_DEV}" | sed 's/\/dev\///g' | sed 's/n[0-9]*//=
2')

The two lines above works ok. Just FYI, they can be simplified with bash
features:

	ns_dev=3D${TEST_DEV##*/}
	ctrl_dev=3D${ns_dev%n*}

> +
> +#	Save Error Injector Attributes
> +	save_err_inject_attr

The function name is self-descriptive. The comment above is not so meaningf=
ul.

> +
> +	inject_unrec_read_err
> +
> +	inject_invalid_read_err
> +
> +	inject_write_fault
> +
> +	set_verbose_prob_retry "${ctrl_dev}"

set_verbose_prob_retry() is called for ctrl_dev in test_device(), but it is
called for ns_dev in inject_unrec_read_err(). This does not look consistent=
.
It would be the better to call set_verbose_prob_retry() only in test_device=
(),
probably. Also, it would be good to provide ns_dev or ctrl_dev to inject_*(=
)
functions as an argument to clarify which device the functions use.

> +	inject_id_admin
> +
> +	inject_invalid_cmd
> +
> +#	Restore Error Injector Attributes
> +	restore_error_inject_attr

Again, the comment above is not so meaningful. And helper functions in this
patch abbreviates the word 'error' to 'err', but only the function above sp=
ells
it out and looks weird for me.

> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/039.out b/tests/nvme/039.out
> new file mode 100644
> index 000000000000..162935eb1d7b
> --- /dev/null
> +++ b/tests/nvme/039.out
> @@ -0,0 +1,7 @@
> +Running nvme/039
> + Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81)=
 DNR=20
> + Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR=20
> + Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR=20
> + Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR=20
> + Unknown(0x96), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR=20
> +Test complete
> --=20
> 2.27.0
>=20

--=20
Best Regards,
Shin'ichiro Kawasaki=
