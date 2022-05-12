Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11697C433EF
	for <linux-block@archiver.kernel.org>; Thu, 12 May 2022 11:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353398AbiELLzG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 May 2022 07:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344488AbiELLzE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 May 2022 07:55:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6A368F8B
        for <linux-block@vger.kernel.org>; Thu, 12 May 2022 04:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652356502; x=1683892502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R3ur/ntj5Wk9yH1wSG6QmcOjEnYxwHcClbKSYkyDbIs=;
  b=WhXe+/zfUQbqFgOVLgcbXxHGtWjszJvaPfL96AqOiLX+HRuluq8qlwhg
   nYcEu+E0ehpFTHSvVmVYx3Kz5ZfwKLhMWjmJSrOMHEYswTYRY0qmpgJkF
   HvoEeeywnICfO71EMuZaEiivrIynN19rqXmCvkmGWxFSgkke1PBW0wd/q
   CZqTE9paq+C5gSColwqojDOOZ6tOJ7ySlzQ4x45M7YdW+B+6ihE7dE8HM
   aSldtcmuZ917SK7PcHC+RWVShBY+aWoPIh1OV51B2kj2b4YEOf0J1cOMu
   cVHFoBBE8gKZ0RFF7N3BheaV3fJgueU6n09gxL+ogqtt1iJhpYT2BdJUx
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,219,1647273600"; 
   d="scan'208";a="198982555"
Received: from mail-sn1anam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2022 19:55:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xg810MI0f9FS0S8zk5TBgGt7oP7xGa3SbCUNQE2M2jrJCQq7gXT1d45LJuOPh2dNqr3J0Vs/BdH+bZeGG9XOLdPdumQFmFRb9e3660yGjKs7vC9lSxef5mtPW3dGl+v/b7/bIoP1Nlch8/BYB5aRPFrwIgiewN33tLyJO1F+HUKCHpE8G3sTMdriUUNwcOPHZycpfr1FYnp9t3tKZtSlagbpikBfDeM8AfQDjcgNetS9L8c/UgiaBdsVJSNPi8HGuJxv9pHjHKZ1a+bYphkokO2e3x3fps7lpCX+NY3Cqsu+SFEx9EmOlwTTBiaGlWJ3Cq1Dr6J795FAGPfNJwXQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZo0QRYY/unUJqf3DwQ9j9j9krqDa9FFM4C+YfQZ+9c=;
 b=WFPiWbtGfpmUxZvVSM6/35ReEauVup1Z8aa2GurIOLvB5wNvW8B5myJvN0ERl9Xj9C6DjfTPdE/gsbiNAu4m7NvC2nddIJfCZPWZaVnevv1CelQ89kcOI3hPDzfdTrBZwgVnyHUJ6ci3Ckvf+gPbupCM9x7zRowrAYk/XamdDbmwQnQe42Pu7B95fmr+reJ9xRNrVg75wMBYNrfglRwaIQK/OL/eqxm6WIEGXI+RclAguw+fHu28UEaFX2eNFIBHDMMP81RqA9zvOpMqfB9MPFUHqMDTk4gIQH9gpiazD+RQ/GyqL7wUKk1L/vjIW6tFGpU1Qo/4wnP5D7k6vqtCCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZo0QRYY/unUJqf3DwQ9j9j9krqDa9FFM4C+YfQZ+9c=;
 b=mmErAWHINxl5AUUR5lXCWNcfw7xgLSVGbN3aVJ0yHkf84q83frNz4AqeSiGoq11yoAr9W4ekkTzFcm8+dZy/mJ6wrIZKjQJKynxmUCONAg1Xzi/YVp2K4y9/kSpXembFP5CNgNMeC8vcQV3Of+Y6Moj3pKrw9HhMbdec+uXHtDw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8196.namprd04.prod.outlook.com (2603:10b6:610:f0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Thu, 12 May 2022 11:54:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 11:54:58 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Alan Adamson <alan.adamson@oracle.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH v2 blktests] tests/nvme: add tests for error logging
Thread-Topic: [PATCH v2 blktests] tests/nvme: add tests for error logging
Thread-Index: AQHYZMXGygGC9N91ikS3jQdoRqSzkK0Yx1qAgAAMyYCAANeGAIABeP6A
Date:   Thu, 12 May 2022 11:54:58 +0000
Message-ID: <20220512115457.hoa6lhk4as63xrq3@shindev>
References: <20220510164304.86178-1-alan.adamson@oracle.com>
 <20220510164304.86178-2-alan.adamson@oracle.com>
 <da090342-f3c5-b3fa-d062-553a4f8a522c@grimberg.me>
 <20220510232919.xoxet3k7cxboixmt@shindev>
 <6eab7100-168f-e371-dbc4-a8946925099f@grimberg.me>
 <20220511003415.d5s5jjpw47kejcb2@shindev>
 <8831D794-47EF-4094-9D81-B87A14EFBBA1@oracle.com>
In-Reply-To: <8831D794-47EF-4094-9D81-B87A14EFBBA1@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d5ea922-8838-4969-33b2-08da340e3d04
x-ms-traffictypediagnostic: CH0PR04MB8196:EE_
x-microsoft-antispam-prvs: <CH0PR04MB8196411F3A77E512E6C5DFE6EDCB9@CH0PR04MB8196.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lj2b36yyLMPlRX+48jLkF8knX+2YSpJ18FM9HqJtkCObTxNwjL8n0Eux6IERU8OhQiRS+gk+p3QO3FoKUMAsuxH5cwTl9TxXLBRLuxmYudLYb3bKVmN75g+Qo3lCnytYgUaKe/bGho9WvnM1UpJz5M2uXhvPiXhXWzejD1SO869QVjAiWfVom6u+J4U0/JuQdYgZ2D5bnVrrxLolRHOdDIPrSuSB4i4buGOdVpgLbul9HzCfTGpU9JsiIRaw0433+O1ENW/j7drZv8gRInbiY2ZW0tAfprqioOZ6ZrNmbGz3ql7KvGMKAycBB0ecKF6JcHjb1Mi+6Kw71KURCvtUh8Ey8SASiOe3LySXKGl+jqTDN249vdcRlQCssDgnmtQTM/lRDkIs/JYgKBOMzvs0wOd16HG+xvr+WyTrhHwiCKHYnK1o+maiMg1PzBQ9jl3LJz/qUOTicQ17lQx9IM8inqQekOJh+5p9oZxy0rl+U2710yopBmrozGnC2Qv5JInRlj6KT8SJuV2pRAk1RJ/nGvmkIMSi2Lg7GeE0Bz3CuEKLImEQWtJN6aaAPL1l93RBGxQxSvmPahfNIIZwZpAJSl0DYvaOP770HkHyC44m96WTow1j+hVvNjUuelzqFt61p1oW3aqhhi6l35haqtvyyPAgLwfWOdp8Zsg2XXuKPGcLPFGyE8y05HZ8hPRdBVvvZttlGVNBZkgQVv8we01ZnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6506007)(33716001)(6512007)(9686003)(53546011)(86362001)(5660300002)(26005)(44832011)(508600001)(54906003)(83380400001)(1076003)(6486002)(66946007)(66446008)(66556008)(66476007)(2906002)(71200400001)(8936002)(64756008)(186003)(6916009)(316002)(8676002)(38070700005)(38100700002)(91956017)(122000001)(4326008)(76116006)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e/hPYMsrjnBid+QsF78qJJUysbpK+DqeTQVqaBxYhIRXP3ABRmurPrRi8xG8?=
 =?us-ascii?Q?ezknJrzCKCHy5qhuzodGkqdarXP8ahl0eAxMqSQxsUI6tHNrgrn5U5taL3fu?=
 =?us-ascii?Q?9jflKNRoejHE+Cb/Xqtc/7uDxTVWoeGSWzdaNAAJN6iR81W+C3AutvD0KrqD?=
 =?us-ascii?Q?sLxdm9FasAdf+aufVl93GBugb5XqFlDqq/1eKYbrA4DiAi5SfZCVF0meJ2KE?=
 =?us-ascii?Q?ronJWTWRtHgmzoQOUopm4OTQL6lTGmYLofMr3+2Yg2hkIYnYMwvocxUOWAen?=
 =?us-ascii?Q?j9e/2Nd8ycoO+yUhn9WpJJj+VSyoqba/rj/tIEaRFEnBHrjKFym0ado9+dLI?=
 =?us-ascii?Q?aHgfyJC0xVdO+lHf09u/FHXqS+ZcDm2ozRvcl70uB+GShpxn9DAt/L4LMdBz?=
 =?us-ascii?Q?iMDEWuDECEdn1ntWBUJO/Kg06y7S4xWYpKnTizXaLytleIXKOCfNegodb0iT?=
 =?us-ascii?Q?afLOzJNUQzT6QTgBrCQg/0LdKYzM1WRJ5NKaSRZIcpnXv8xnrXvfmCINMSr4?=
 =?us-ascii?Q?iYipNx9v/dQsayd/MDZ8MeOyYyd/2qZwBM4QPqRq01rIrDttQHWwN8TiAr0Z?=
 =?us-ascii?Q?ZTqOqF5Vomxt/gtj5I46OTfjknFPxSdQgKgWctqTzYz3dBTIox9gPWF0nNMu?=
 =?us-ascii?Q?ZJLs1aDrA8dAiYEHrb/r1ULs3TSuyp5ZN7jW4d7kBbFhalCL12gwQVu2cKof?=
 =?us-ascii?Q?mAes4NdtpuGe2gzGUICsz55fdzMD/kW+1hyl3JCY+GZXt0RIoEAsMUswJ8eg?=
 =?us-ascii?Q?8Ej5kfJYW+k5vvtbyS7UAqvRxyLzudrwgON3+faGsjC1QaTIQevJfptciCdI?=
 =?us-ascii?Q?x1noHOKC0/XRrujMeQa0Sx9BCCzUJgHAMEhx9pCSs7oGOKK51o2KYt2TqNHr?=
 =?us-ascii?Q?Mpitt/JyQLIUJ0QPiLgfIufROl/d+krBsAN+pAfuYJLE9xSOdWXWkLigr1BX?=
 =?us-ascii?Q?8vSzadroZqEhCj0OsOMKxlOACb5nGE2vlSUyyU6SKNWuFjBSjxjVhAuTgaH3?=
 =?us-ascii?Q?ZapbS3Ey2dh29qdhgjF3CH2GV92Sy3ipQ61FNrEMgtk/mVqCsjcRYUDeQJfK?=
 =?us-ascii?Q?tUj2rF9Ic31WZ/qt7wETpuwyNeep7jk7wv9V16g6/VnGqraDXiV0WBRBwwjt?=
 =?us-ascii?Q?8QWRsZikchjLJhp/ULOosniuNpc1iBu98nUeogTYQmQ8+JSRi8ICPOw3WuWt?=
 =?us-ascii?Q?UV9Pt4byXVupkBKOabUC2Yh7yWAAESrskL16N+TFQvbdH9OTTVCFtxA2MtM+?=
 =?us-ascii?Q?75V1/NjHKc6vswnUBY4B/W1IYtcF5sPyyqBIC8qbXNPSMQxtvXhCUArz6yAi?=
 =?us-ascii?Q?Ki9xaUYUTbimy2CmmzVp4niqQGs46mLQXsBVu6r6V145pzhrAL5SI3amCX4X?=
 =?us-ascii?Q?orje9RinMUUalhhkdJ+f7wR6zRh7TceWDDi4JWJZ9kYyBEOxEy7eX17v/GLY?=
 =?us-ascii?Q?GjQDVHp/oY+4KIroLRTQAyuVjiaUT7nb1jrVN0SuRrOminsDBSF+mz9hChCR?=
 =?us-ascii?Q?px2eWZGAU+Dbeqbil8GRoC81SdCcNeKkt+sKQiG+CkoWeyxT/RRnWtPELmhG?=
 =?us-ascii?Q?+VeI3CWdmejQhx2H4CK7ZpCB4qku727OPlrNqUxezdPObKk+T4M9wHH+UcmI?=
 =?us-ascii?Q?rs8IFdQXRzApEaNPIm3VcP0Qj5NkeqwzHgf1nxPrbiDEdvr8OlTu+GSZpoUe?=
 =?us-ascii?Q?1mGOraMQsP/665T5cXmjd2ffnfkfkiZl39k83jyQFmFA07W1dvU/IRpsHB1E?=
 =?us-ascii?Q?1Loh2ebc7QlGfXE47ddWieLwzQMdN56IKGv0Qy84ZsJM+c3zYudt?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBFADF44C6BBFB4C8A31D6192EA1A9D5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5ea922-8838-4969-33b2-08da340e3d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 11:54:58.4062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSYcTqOcod1RJHppedJNrASwvD+8Zgs5AtUVpMMxbEajEtwR0/073eCz1BCvCErDsuTENyBSnpWqMpUrwWiIWYMIsTuA8rTFAnwXRmMdlkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8196
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 11, 2022 / 13:25, Alan Adamson wrote:
>=20
>=20
> > On May 10, 2022, at 8:34 PM, Shinichiro Kawasaki <shinichiro.kawasaki@w=
dc.com> wrote:
> >=20
> > On May 10, 2022 / 16:48, Sagi Grimberg wrote:
> >>=20
> >>>> On 5/10/22 19:43, Alan Adamson wrote:
> >>>>> Test nvme error logging by injecting errors. Kernel must have FAULT=
_INJECTION
> >>>>> and FAULT_INJECTION_DEBUG_FS configured to use error injector. Test=
s can be
> >>>>> run with or without NVME_VERBOSE_ERRORS configured.
> >>>>>=20
> >>>>> These test verify the functionality delivered by the follow:
> >>>>> 	commit bd83fe6f2cd2 ("nvme: add verbose error logging")
> >>>>>=20
> >>>>> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> >>>>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> >>>>> ---
> >>>>>   tests/nvme/039     | 185 ++++++++++++++++++++++++++++++++++++++++=
+++++
> >>>>>   tests/nvme/039.out |   7 ++
> >>>>>   2 files changed, 192 insertions(+)
> >>>>>   create mode 100755 tests/nvme/039
> >>>>>   create mode 100644 tests/nvme/039.out
> >>>>>=20
> >>>>> diff --git a/tests/nvme/039 b/tests/nvme/039
> >>>>> new file mode 100755
> >>>>> index 000000000000..e6d45a6e3fe5
> >>>>> --- /dev/null
> >>>>> +++ b/tests/nvme/039
> >>>>> @@ -0,0 +1,185 @@
> >>>>> +#!/bin/bash
> >>>>> +# SPDX-License-Identifier: GPL-3.0+
> >>>>> +# Copyright (C) 2022 Oracle and/or its affiliates
> >>>>> +#
> >>>>> +# Test nvme error logging by injecting errors. Kernel must have FA=
ULT_INJECTION
> >>>>> +# and FAULT_INJECTION_DEBUG_FS configured to use error injector. T=
ests can be
> >>>>> +# run with or without NVME_VERBOSE_ERRORS configured.
> >>>>> +#
> >>>>> +# Test for commit bd83fe6f2cd2 ("nvme: add verbose error logging")=
.
> >>>>> +
> >>>>> +. tests/nvme/rc
> >>>>> +DESCRIPTION=3D"test error logging"
> >>>>> +QUICK=3D1
> >>>>> +
> >>>>> +requires() {
> >>>>> +	_nvme_requires
> >>>>> +	_have_kernel_option FAULT_INJECTION && \
> >>>>> +	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
> >>>>> +}
> >>>>> +
> >>>>> +declare -A NS_DEV_FAULT_INJECT_SAVE
> >>>>> +declare -A CTRL_DEV_FAULT_INJECT_SAVE
> >>>>> +
> >>>>> +save_err_inject_attr()
> >>>>> +{
> >>>>> +	local a
> >>>>> +
> >>>>> +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
> >>>>> +		NS_DEV_FAULT_INJECT_SAVE[${a}]=3D$(<"${a}")
> >>>>> +	done
> >>>>> +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
> >>>>> +		CTRL_DEV_FAULT_INJECT_SAVE[${a}]=3D$(<"${a}")
> >>>>> +	done
> >>>>> +}
> >>>>> +
> >>>>> +restore_err_inject_attr()
> >>>>> +{
> >>>>> +	local a
> >>>>> +
> >>>>> +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
> >>>>> +		echo "${NS_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
> >>>>> +	done
> >>>>> +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
> >>>>> +		echo "${CTRL_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
> >>>>> +	done
> >>>>> +}
> >>>>> +
> >>>>> +set_verbose_prob_retry()
> >>>>> +{
> >>>>> +	echo 0 > /sys/kernel/debug/"$1"/fault_inject/verbose
> >>>>> +	echo 100 > /sys/kernel/debug/"$1"/fault_inject/probability
> >>>>> +	echo 1 > /sys/kernel/debug/"$1"/fault_inject/dont_retry
> >>>>> +}
> >>>>> +
> >>>>> +set_status_time()
> >>>>> +{
> >>>>> +	echo "$1" > /sys/kernel/debug/"$3"/fault_inject/status
> >>>>> +	echo "$2" > /sys/kernel/debug/"$3"/fault_inject/times
> >>>>> +}
> >>>>> +
> >>>>> +inject_unrec_read_err()
> >>>>> +{
> >>>>> +	# Inject a 'Unrecovered Read Error' error on a READ
> >>>>> +	set_status_time 0x281 1 "$1"
> >>>>> +
> >>>>> +	dd if=3D/dev/"$1" of=3D/dev/null bs=3D512 count=3D1 iflag=3Ddirec=
t \
> >>>>> +	    2> /dev/null 1>&2
> >>>>> +
> >>>>> +	if ${nvme_verbose_errors}; then
> >>>>> +		dmesg -t | tail -2 | grep "Unrecovered Read Error (" | \
> >>>>> +		    sed 's/nvme.*://g'
> >>>>> +	else
> >>>>> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
> >>>>> +		    sed 's/I\/O Error/Unrecovered Read Error/g' | \
> >>>>> +		    sed 's/nvme.*://g'
> >>>>> +	fi
> >>>>> +}
> >>>>> +
> >>>>> +inject_invalid_read_err()
> >>>>> +{
> >>>>> +	# Inject a valid invalid error status (0x375) on a READ
> >>>>> +	set_status_time 0x375 1 "$1"
> >>>>> +
> >>>>> +	dd if=3D/dev/"$1" of=3D/dev/null bs=3D512 count=3D1 iflag=3Ddirec=
t \
> >>>>> +	    2> /dev/null 1>&2
> >>>>> +
> >>>>> +	if ${nvme_verbose_errors}; then
> >>>>> +		dmesg -t | tail -2 | grep "Unknown (" | \
> >>>>> +		    sed 's/nvme.*://g'
> >>>>> +	else
> >>>>> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
> >>>>> +		    sed 's/I\/O Error/Unknown/g' | \
> >>>>> +		    sed 's/nvme.*://g'
> >>>>> +	fi
> >>>>> +}
> >>>>> +
> >>>>> +inject_write_fault()
> >>>>> +{
> >>>>> +	# Inject a 'Write Fault' error on a WRITE
> >>>>> +	set_status_time 0x280 1 "$1"
> >>>>> +
> >>>>> +	dd if=3D/dev/zero of=3D/dev/"$1" bs=3D512 count=3D1 oflag=3Ddirec=
t \
> >>>>> +	    2> /dev/null 1>&2
> >>>>> +
> >>>>> +	if ${nvme_verbose_errors}; then
> >>>>> +		dmesg -t | tail -2 | grep "Write Fault (" | \
> >>>>> +		    sed 's/nvme.*://g'
> >>>>> +	else
> >>>>> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
> >>>>> +		    sed 's/I\/O Error/Write Fault/g' | \
> >>>>> +		    sed 's/nvme.*://g'
> >>>>> +	fi
> >>>>> +}
> >>>>> +
> >>>>> +inject_id_admin()
> >>>>> +{
> >>>>> +	# Inject a valid (Identify) Admin command
> >>>>> +	set_status_time 0x286 1000 "$1"
> >>>>> +
> >>>>> +	nvme admin-passthru /dev/"$1" --opcode=3D0x06 --data-len=3D4096 \
> >>>>> +	    --cdw10=3D1 -r 2> /dev/null 1>&2
> >>>>> +
> >>>>> +	if ${nvme_verbose_errors}; then
> >>>>> +		dmesg -t | tail -1 | grep "Access Denied (" | \
> >>>>> +		    sed 's/nvme.*://g'
> >>>>> +	else
> >>>>> +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
> >>>>> +		    sed 's/Admin Cmd/Identify/g' | \
> >>>>> +		    sed 's/I\/O Error/Access Denied/g' | \
> >>>>> +		    sed 's/nvme.*://g'
> >>>>> +	fi
> >>>>> +}
> >>>>> +
> >>>>> +inject_invalid_cmd()
> >>>>> +{
> >>>>> +	# Inject an invalid command (0x96)
> >>>>> +	set_status_time 0x1 1 "$1"
> >>>>> +
> >>>>> +	nvme admin-passthru /dev/"$1" --opcode=3D0x96 --data-len=3D4096 \
> >>>>> +	    --cdw10=3D1 -r 2> /dev/null 1>&2
> >>>>> +	if ${nvme_verbose_errors}; then
> >>>>> +		dmesg -t | tail -1 | grep "Invalid Command Opcode (" | \
> >>>>> +		    sed 's/nvme.*://g'
> >>>>> +	else
> >>>>> +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
> >>>>> +		    sed 's/Admin Cmd/Unknown/g' | \
> >>>>> +		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
> >>>>> +		    sed 's/nvme.*://g'
> >>>>> +	fi
> >>>>> +}
> >>>>> +
> >>>>=20
> >>>> All of the above seems like they belong in common code...
> >>>=20
> >>> So far, this nvme/039 is the only one user of the helper functions ab=
ove. Do you
> >>> foresee that future new test cases in nvmeof-mp or srp group will use=
 them?
> >>>=20
> >>=20
> >> I can absolutely see other tests inject errors. I meant that this code
> >> should live in nvme/rc
>=20
> Should the helpers inject errors itself (_nvme_inject_write_fault), or ju=
st provide the functions to setup the
> error injector (_nvme_set_inject) and let the test specify the error stat=
us and do the IO that causes the injected
> error?

Per Sagi's comment, I assume the 4 inject_*() functions similar as the v2 p=
atch
are desired in nvme/rc. So I assume the helpers to "inject errors itself".
Having said that, "the functions to setup the error injector" sounds simple=
 and
good as the common helper function.

Sagi, do you have preference on this?

--=20
Best Regards,
Shin'ichiro Kawasaki=
