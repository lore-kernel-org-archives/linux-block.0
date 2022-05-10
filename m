Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C22C433F5
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 23:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbiEJX32 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 19:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbiEJX31 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 19:29:27 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D982689C5
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 16:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652225364; x=1683761364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DqMW8hGJCO7W0aYMxoJq26/5p+a3HgnCp4vCK7W10MA=;
  b=j4GXAe4lhIqOJfyXusNbpaVadkCAA5cuBL7hc+4afwAn+Ff69KRGzouP
   snq7lPDC3wAiju375cVPdfi1PREyFFQlfuUvDEPBPSHAn6dYXRYj2xCvn
   qhUv17EFWuhFr8NAAImqg+p02jUhPSpHgMMN+X7pTsZoPO8+c76XEqxDt
   5ZTCGFjJ6vkFm8uxgkPOtKLNfkHIibkpE38sldpd36XL/mZ0wE4hZKXGl
   j8B6fCPBb44ajdOeWlvE2+l6pXo4MSyUEzjW3g5zVdNR7NhGms6zoOeW/
   NOaWFB4wVukcd4BUJSbyoWRvzQ6zb7bhWzOBvLpw3wY4gzq3c6jA43CBi
   w==;
X-IronPort-AV: E=Sophos;i="5.91,215,1647273600"; 
   d="scan'208";a="304230540"
Received: from mail-mw2nam08lp2171.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
  by ob1.hgst.iphmx.com with ESMTP; 11 May 2022 07:29:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB81JIHRWBlU1Mq/oIWSU2fEfdGz276v7vyFlONWye4rScxt2vCVUtUH9Gk7JgKRdvmZ3HWwTr7HwgkN3mupzEN0VpCoZBfMLKejzSO/fIF9bmmDqOC/LFvQjHVLQiNGm8zBbG8k0S7/8D84oZV4j4AEc/kFGk4NO3qeGlAnYdwPivJl2yyS9V3M4OSuRyPcPqkdXx4Fgu2xRLjga4oy6qceqfUtYpKc4wqKUS//YGKx0zqxrUGmCv1MUUMM/ixHsqvbFOSmXU0QisjEYoZSwUNdyVTDTciU2lAxe3vzUoOi6LL38/LutWLgv5qJLa7D3gKh+gaVWBN/VqHOKjhXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx46Q5AalEnKb1lwS5MGOPpyGWP6yUVMNS0ByR/CWtM=;
 b=c83EG1nM29gADG7zzbooV+tAvXYiaY2oz2k9Z7B7F0yY9Xv/yacPOwaAEOld+AvorGHdVA4CZYC1WMAMehQXWgyHYXwwOJDCd7irRQY5Dhpq+RaapJ9eCfO0vmlIH0pDBtqEmJb848vo9/jsMxV3k1oPjgX1rr867QRyZEK6H/vNomcF4MwzwpMcyq4Dr6luxD1C/5+udIUxBr2FNJRpzUjbYmmlE0LTJpsRQUs1PblzDV+OS5Jv+gcosCsXybi83p4g/ahD6kKfjMb4XOKGG84rRR1Vd04JKJxCUUJahm0BH2u+SyCDtn1Yfz5KTL7e0CwZP2h06lXFDbqhPNobhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx46Q5AalEnKb1lwS5MGOPpyGWP6yUVMNS0ByR/CWtM=;
 b=im/a2amqioC0tIkOs6yCg5As/t5rIomAD7honfAh/aFUCowrGVegi97QAn/jdsvkjoxWcgIGyo3Org4DYCUqyrUQEWPsQbSrPTB+oYdRiAinxNWSa1tQuaxw4wGZnt5GGv4eDJ/8d3iFRAuU0Tq+aa/A7veyH9Q+YwSGAxDbCrg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB5665.namprd04.prod.outlook.com (2603:10b6:408:a2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.20; Tue, 10 May 2022 23:29:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 23:29:20 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     Alan Adamson <alan.adamson@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH v2 blktests] tests/nvme: add tests for error logging
Thread-Topic: [PATCH v2 blktests] tests/nvme: add tests for error logging
Thread-Index: AQHYZMXGygGC9N91ikS3jQdoRqSzkA==
Date:   Tue, 10 May 2022 23:29:20 +0000
Message-ID: <20220510232919.xoxet3k7cxboixmt@shindev>
References: <20220510164304.86178-1-alan.adamson@oracle.com>
 <20220510164304.86178-2-alan.adamson@oracle.com>
 <da090342-f3c5-b3fa-d062-553a4f8a522c@grimberg.me>
In-Reply-To: <da090342-f3c5-b3fa-d062-553a4f8a522c@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecc85efa-cf46-4ae1-5a9c-08da32dce8d6
x-ms-traffictypediagnostic: BN8PR04MB5665:EE_
x-microsoft-antispam-prvs: <BN8PR04MB5665E8EE6930268701F23BF9EDC99@BN8PR04MB5665.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qhMxKAYm3ej3AJHEeoXZXkcQ4zWo582osn+spOgC/vWiNS7WzVC7f3Ks7++V/WmU2C0aWq6Clmv1Wg9RRJTRHwOpbPISLjIS0RZUU8VwbmSCgU5mpwtG4HBDvBXr/07W2SxD/nq4/UXr6F0prmNtGf5wk+7dqBoarWX+6auxwm4JBZY3LmIQQen42H6FxxpH/NmangOnriZP2E02q+SCNgdFH7r6EL0Q/mCVGiALqKlPQrwLKoChrrpUxz6rt/xnanJ0MVT50qnucbF9yL/lJgc8M3+CsXjfW5Q5FkhUDpK5PHc9dY4PkPedgb1tW8I4MfAsZ3tNjaGz5L8o4HIz2l+WbNNesekTMDBbpnPReeELuTRfT93Gpg9awrBX4yjLULULrbIoYPldtsa/cEneAFX03U0aiD1U5cXO3sZcGrafqAQeTX6guh+PnMW3qovYykPJN1huxLFkn+4LJgivsi1NPTqQa8xASVohTaHkr6Jv+DM+ZQZ5w4pyhTgm4PDeql2bIQY1+KF8Wi9o159yNUMGtMR+7egfFQz5Vw5/S/xM/01BESI5zernBaRJ+FdFw4lpnDhGYtnA9RYZCn02twzjymZNrS1b1dSaZJR17Glvz90fVAutHWRm8oxyFEJOEAaMINaSVmETEhl56aOlrvRhw9zJYP3gPx6VYuABYvNa5khx+AnZ/PaqR2n0dIjcwGz7MiyhC4BBL0OE1dxaZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(71200400001)(86362001)(6506007)(8936002)(6486002)(2906002)(53546011)(5660300002)(44832011)(83380400001)(508600001)(26005)(33716001)(82960400001)(9686003)(6512007)(38070700005)(38100700002)(122000001)(186003)(1076003)(66476007)(66946007)(76116006)(66556008)(316002)(91956017)(54906003)(6916009)(66446008)(8676002)(64756008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AXqxL85I8Y6+7gQfSGid4pPVkBqsnc7n6t7Q7r2cGVWkv1X3ku0iaPrHPNAD?=
 =?us-ascii?Q?Dmhsu052qIZQdG3wezd80s8G3HuFs6T5Cnnakhm9j8TlGfI3p1R65nvkFJXu?=
 =?us-ascii?Q?SAXqZzPRbHsFofc4sq0px/ZZ9HcxB8Zgz43DJJTr9ohy81BRegNNz1G+60J2?=
 =?us-ascii?Q?E/8nxIJhyYvHNN+AVaBr9hhzcxAEoAuaOdBMIUO+Gyaa/7KTqQeEgB4tYQ6b?=
 =?us-ascii?Q?xBskvwig8JMxxaR+uuLZJ61u3eRxVN8Zsr50xXlBUG/ToQ05eDLwUUqqXPFz?=
 =?us-ascii?Q?y1NQoTUxBlJDtfudN3zN9BqM6ew05UDFHDQpcVywyIymJx1gqNqCLtm5qJY3?=
 =?us-ascii?Q?IDprJLKysoWfLIVIz13fDDQO2FOLpaZ8MYIHgesQklCpGhrsbQBjAD5Ytvv2?=
 =?us-ascii?Q?3ZR0kvh7zPPfiugzBJFQyUJjpiZUD2ISX3/RJaULkCFCY7mg+BqI4CiixRKI?=
 =?us-ascii?Q?2T7OS42JHiyr6tWRMq3WAx2zRqwB1APZcz6usClpr91WlkD5D595A64eO6tM?=
 =?us-ascii?Q?8umW8aXS1QcLsYK/y2NMMDXYvCc0Ltv5S4kXNkyelLUeiXdXyj9XloO6beW3?=
 =?us-ascii?Q?Zu5yXOa1AFcjJnDIg9SmD85U8wWzxXJ6FDPRW5UO2LL7Y2oHFWf0FXAjU/2s?=
 =?us-ascii?Q?TfXSdR4f1WJynvh1p8YDcgNIZeKqxAhgasLJP+0bv7xTXdECUUYYmQhz9XdU?=
 =?us-ascii?Q?IvFNjSFMwO//nOawCnoP0lHUFo1qUjr1Wqd8hvpe9BOowhEe3FZqPbN9LH6z?=
 =?us-ascii?Q?1IW4N2sytQL2bCtya7cMy2Gt2WUBywraplKzdv+kXsr2yxaLknBBDm5mMm0A?=
 =?us-ascii?Q?1a8YihoJLm+8cDLgVR90m1f12MUqzRr8l2SCszaUOzgdhMoiaclL1GF5DpdN?=
 =?us-ascii?Q?yHOSlxJOBLO1PcwpaE+Fs0qgtkw+Z6FXqhFOhl/yiZQd1RpmLW1gdhVNh6o/?=
 =?us-ascii?Q?Pb7+ruyjYjM8+dpzrHyiS3mvA6tKEvV/+N9l6nqJJCtmAiTtwceEWHD/BFHo?=
 =?us-ascii?Q?GsHXV5b2ntdwn7EmLdmeyZUL6w2AFoOk2q9sUCuoL8ETQAX7DD3LvgyG2I58?=
 =?us-ascii?Q?Nge0Se1YvPBfyEZg8juJXgss1IeIZCkYVVK61/mnw+ZwpfM+3X5zoWWkuer4?=
 =?us-ascii?Q?JyWYSxSTC9JmUlQWpBeF+Y7gmtEDWPwJ9s3FxCUSzAeqKzUdxPzYP5YwuvzU?=
 =?us-ascii?Q?x/4MShKeNOdGUqVqzxoK/I0hxGEpxbD0Gj1+XxyHLZCFimnTaNTICNVfnH3G?=
 =?us-ascii?Q?ec/bn0Oz5eLZZu+k1VT3UeGP5Wx7CcQlDKjmWW/VLKKGFJBlyFFPFkzTkxxa?=
 =?us-ascii?Q?pTtQAXezvmEVrlaEnt3W46ou1NMueH5EuwI0oGCm4GWXnDcYvDw7/09h/c8g?=
 =?us-ascii?Q?6glCqm7HQqMmCnSxmP+HMDe8AGRfpGGtrtjv3Styclf5cN2z+t4G8j4z+Dio?=
 =?us-ascii?Q?O3CsRHel61WHl9jcHA5qNU2gM0yeMWDZCMVYdSiXdEWDJEHVrOoVHnSRV3j8?=
 =?us-ascii?Q?Km8D29aXyKKgu3l5XKXU0bm1xBJ/ShskG+M2fAPnCIFgPpufyppbDXUDb0S5?=
 =?us-ascii?Q?HnPj3kakbdAEJvVPpFKUuL8l9Zjb3jul2ukun1qJg94qDmlpr3BGvmgsVQTz?=
 =?us-ascii?Q?04VHwxiI4HX9l6ZEin4IWfOwqiBOi+/eHrEekmeTGU11uiViDPfSybGFX6qq?=
 =?us-ascii?Q?l9IoiHEyp4xYyMfyjXTE0MCFMn/KGUHO0T3xvCAtwuyYFG7dbZPU8mUX+BIl?=
 =?us-ascii?Q?ivIVXgzz12hPxIPjRfoA8rqceM+xQGEa49GSEM5m5M6i0IZk9A/r?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A1C7EC504E1C04BA31708E793D95373@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc85efa-cf46-4ae1-5a9c-08da32dce8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 23:29:20.6277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hc70IK/r4sM5zfTAFEBK4J0leLd4NWgTtn7jxxGp0h9rPE1KXP8ARvpHorGyotrcz4j7RC9GTuyAt7EY/VnZcFQQiku9jCpJepvjvcX9MqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5665
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 10, 2022 / 15:25, Sagi Grimberg wrote:
>=20
>=20
> On 5/10/22 19:43, Alan Adamson wrote:
> > Test nvme error logging by injecting errors. Kernel must have FAULT_INJ=
ECTION
> > and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests ca=
n be
> > run with or without NVME_VERBOSE_ERRORS configured.
> >=20
> > These test verify the functionality delivered by the follow:
> > 	commit bd83fe6f2cd2 ("nvme: add verbose error logging")
> >=20
> > Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > ---
> >   tests/nvme/039     | 185 ++++++++++++++++++++++++++++++++++++++++++++=
+
> >   tests/nvme/039.out |   7 ++
> >   2 files changed, 192 insertions(+)
> >   create mode 100755 tests/nvme/039
> >   create mode 100644 tests/nvme/039.out
> >=20
> > diff --git a/tests/nvme/039 b/tests/nvme/039
> > new file mode 100755
> > index 000000000000..e6d45a6e3fe5
> > --- /dev/null
> > +++ b/tests/nvme/039
> > @@ -0,0 +1,185 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2022 Oracle and/or its affiliates
> > +#
> > +# Test nvme error logging by injecting errors. Kernel must have FAULT_=
INJECTION
> > +# and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests=
 can be
> > +# run with or without NVME_VERBOSE_ERRORS configured.
> > +#
> > +# Test for commit bd83fe6f2cd2 ("nvme: add verbose error logging").
> > +
> > +. tests/nvme/rc
> > +DESCRIPTION=3D"test error logging"
> > +QUICK=3D1
> > +
> > +requires() {
> > +	_nvme_requires
> > +	_have_kernel_option FAULT_INJECTION && \
> > +	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
> > +}
> > +
> > +declare -A NS_DEV_FAULT_INJECT_SAVE
> > +declare -A CTRL_DEV_FAULT_INJECT_SAVE
> > +
> > +save_err_inject_attr()
> > +{
> > +	local a
> > +
> > +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
> > +		NS_DEV_FAULT_INJECT_SAVE[${a}]=3D$(<"${a}")
> > +	done
> > +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
> > +		CTRL_DEV_FAULT_INJECT_SAVE[${a}]=3D$(<"${a}")
> > +	done
> > +}
> > +
> > +restore_err_inject_attr()
> > +{
> > +	local a
> > +
> > +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
> > +		echo "${NS_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
> > +	done
> > +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
> > +		echo "${CTRL_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
> > +	done
> > +}
> > +
> > +set_verbose_prob_retry()
> > +{
> > +	echo 0 > /sys/kernel/debug/"$1"/fault_inject/verbose
> > +	echo 100 > /sys/kernel/debug/"$1"/fault_inject/probability
> > +	echo 1 > /sys/kernel/debug/"$1"/fault_inject/dont_retry
> > +}
> > +
> > +set_status_time()
> > +{
> > +	echo "$1" > /sys/kernel/debug/"$3"/fault_inject/status
> > +	echo "$2" > /sys/kernel/debug/"$3"/fault_inject/times
> > +}
> > +
> > +inject_unrec_read_err()
> > +{
> > +	# Inject a 'Unrecovered Read Error' error on a READ
> > +	set_status_time 0x281 1 "$1"
> > +
> > +	dd if=3D/dev/"$1" of=3D/dev/null bs=3D512 count=3D1 iflag=3Ddirect \
> > +	    2> /dev/null 1>&2
> > +
> > +	if ${nvme_verbose_errors}; then
> > +		dmesg -t | tail -2 | grep "Unrecovered Read Error (" | \
> > +		    sed 's/nvme.*://g'
> > +	else
> > +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
> > +		    sed 's/I\/O Error/Unrecovered Read Error/g' | \
> > +		    sed 's/nvme.*://g'
> > +	fi
> > +}
> > +
> > +inject_invalid_read_err()
> > +{
> > +	# Inject a valid invalid error status (0x375) on a READ
> > +	set_status_time 0x375 1 "$1"
> > +
> > +	dd if=3D/dev/"$1" of=3D/dev/null bs=3D512 count=3D1 iflag=3Ddirect \
> > +	    2> /dev/null 1>&2
> > +
> > +	if ${nvme_verbose_errors}; then
> > +		dmesg -t | tail -2 | grep "Unknown (" | \
> > +		    sed 's/nvme.*://g'
> > +	else
> > +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
> > +		    sed 's/I\/O Error/Unknown/g' | \
> > +		    sed 's/nvme.*://g'
> > +	fi
> > +}
> > +
> > +inject_write_fault()
> > +{
> > +	# Inject a 'Write Fault' error on a WRITE
> > +	set_status_time 0x280 1 "$1"
> > +
> > +	dd if=3D/dev/zero of=3D/dev/"$1" bs=3D512 count=3D1 oflag=3Ddirect \
> > +	    2> /dev/null 1>&2
> > +
> > +	if ${nvme_verbose_errors}; then
> > +		dmesg -t | tail -2 | grep "Write Fault (" | \
> > +		    sed 's/nvme.*://g'
> > +	else
> > +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
> > +		    sed 's/I\/O Error/Write Fault/g' | \
> > +		    sed 's/nvme.*://g'
> > +	fi
> > +}
> > +
> > +inject_id_admin()
> > +{
> > +	# Inject a valid (Identify) Admin command
> > +	set_status_time 0x286 1000 "$1"
> > +
> > +	nvme admin-passthru /dev/"$1" --opcode=3D0x06 --data-len=3D4096 \
> > +	    --cdw10=3D1 -r 2> /dev/null 1>&2
> > +
> > +	if ${nvme_verbose_errors}; then
> > +		dmesg -t | tail -1 | grep "Access Denied (" | \
> > +		    sed 's/nvme.*://g'
> > +	else
> > +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
> > +		    sed 's/Admin Cmd/Identify/g' | \
> > +		    sed 's/I\/O Error/Access Denied/g' | \
> > +		    sed 's/nvme.*://g'
> > +	fi
> > +}
> > +
> > +inject_invalid_cmd()
> > +{
> > +	# Inject an invalid command (0x96)
> > +	set_status_time 0x1 1 "$1"
> > +
> > +	nvme admin-passthru /dev/"$1" --opcode=3D0x96 --data-len=3D4096 \
> > +	    --cdw10=3D1 -r 2> /dev/null 1>&2
> > +	if ${nvme_verbose_errors}; then
> > +		dmesg -t | tail -1 | grep "Invalid Command Opcode (" | \
> > +		    sed 's/nvme.*://g'
> > +	else
> > +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
> > +		    sed 's/Admin Cmd/Unknown/g' | \
> > +		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
> > +		    sed 's/nvme.*://g'
> > +	fi
> > +}
> > +
>=20
> All of the above seems like they belong in common code...

So far, this nvme/039 is the only one user of the helper functions above. D=
o you
foresee that future new test cases in nvmeof-mp or srp group will use them?

--=20
Best Regards,
Shin'ichiro Kawasaki=
