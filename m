Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F27C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 10:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCWK4j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjCWK4Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 06:56:24 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0702A1D92A
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 03:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679568951; x=1711104951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1oGXCkA6PcA8st7qbRQq+UbyS83QBTz8FyeTGzzXLAo=;
  b=l3CBd+3ny6YNN6+Jx8hThyTPmeHMxeecCCtJMiGQnffDMs3Og8GlJCgw
   e2feo8iVwFAt0n7ntD69UoKAOS/pAL3w9JywbVagRda6Z3tt5EkFfzsRX
   YAtYZBO0QWFT6+fFjCwPuAzjAo4bH2tAEKCOXU7KdeAJ7QAS0nI8HU7fP
   T2Z4rT0hPKONl2WBQQL/OE9Xy76SEFdZofdQG3MVIgSyWHlG/nEUDy/HA
   9OxlIcmjyrN6xVedfG0AW9PyxOcWz1c/YB2mAwpFZ/HHDE5yVtmRnrpvQ
   ++yf3To7RfxQMjtJTkoefOvnCwR886vaCnuRcr/YmjxqhqUitGGU+NqgV
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="224602805"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 18:55:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2n26y/IP7zzRVeTKoOcp3vEBfklESPkmtyC/5kGtl6wq2/qnPWyz9Pj/CAJtVRU9F9GePjFa19O7TcPTwiQyJ4GmuuF9kJ0sqa2FY1PL2x+cJgJZ6/QG7s8IO+s+3a85Y7ZmMDiLxwUZj2cnmjlQpoOA3Z/ccufSGoRxDb5CfjnDQ8aSVEG6j/+z8q4M8XSZzTSPpIN6zvgqbYw1m/4MByEcRzEZwVLiT5i3PPW9LcyCFl3dMJSicFj6JDgzwfG0wf60NaqbOHTcFaA2Z4QSpqXA63Ydab17hdBC+aa2Y+PN66U65PwPXI784eJQtVhUS1xSFmbW4TV2IE8T/oHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuS3b6olgEFaZiqXUh+JcuzWCuvDu9295Yj4v9PzrRM=;
 b=WWNgQLjapMslHsKNdL7fmMjgDph0HxhWgmNwuawcyr4L+TivYdh9e+ktjHnA+6Ht4dWAbuwX8sakd4SPwMMBC94LcrBWdqphdC8+UQP/GNtf1Y3wtaGirgWdAUYMuA4KvwqtlnyYuhJJ2nRVf+D0EAL2zVgVgnL1ZVvAnCx5ggQEVpcWl0t/GxMFuenJ5filb+VczI/9YegtGBRTJOO/vZUiozUtqoVG9fiwERpX2Aih5Z6dKeXC8dzmVgfWca4cQHZXyWyo0SBFHtsSHm5KxWRUsUl6LmzOSO77I2e1tTvK33N32Naavr5BUu76bbfY88Opjjbiw4gSkkjdhMsY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuS3b6olgEFaZiqXUh+JcuzWCuvDu9295Yj4v9PzrRM=;
 b=Y8mX/7S8dsZxmMMBL0SEQK9UyON646PW1HXUS8cgCTncjNE7S+rK/tZutu3m/9rrFrW3gRyb9IDCv8HZNXmL6tNhzZiV+UokRARfz8i4QCs3jgeZr0rF9972HVyW4SWyqrh0UiHrpw9hPubBrjG6Ro0MCDoszwBu6JK+yo3Uyho=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7311.namprd04.prod.outlook.com (2603:10b6:a03:295::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 10:55:48 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%7]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 10:55:48 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2 3/3] nvme/047: Test different queue counts
Thread-Topic: [PATCH blktests v2 3/3] nvme/047: Test different queue counts
Thread-Index: AQHZXKdwCbzyTIE7hkq/EY1ojaXCzq8IMryA
Date:   Thu, 23 Mar 2023 10:55:48 +0000
Message-ID: <20230323105547.h5k4cdxsmow46krn@shindev>
References: <20230322101648.31514-1-dwagner@suse.de>
 <20230322101648.31514-4-dwagner@suse.de>
In-Reply-To: <20230322101648.31514-4-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7311:EE_
x-ms-office365-filtering-correlation-id: f3c5096f-a3ac-4c07-c671-08db2b8d2931
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dDjsHt5XIz8za94v7FOUfr1tSwGReWw5bAgKmDBAFxGr3iHpNYz70UbeTkDurqjXWS3G6i6aWTUDqKSH7b+7WQTpy1U/pmJkEknKm6pzOtuG9q8xRbpIUzvscw8EhoPb/4LVaVEaClL9E7Nb559RY6sc7/0UHhv85o9TXZ5HJOUM/Y4SLECGmCzwvql+UM8oVd3pSnJp2I9KigSYwHOBUbAwtp1lvk1OT3X7K7sjiXOSiEE/l8oqcKR23LO00JI5hwf8tZhjI/Q+hEoOQO4oevOJswxDmGmnxHhdktJ9RbJNizO9vosLOVmS2fnM8l13a1aEPTL6PDKDa/UurDYv5IbEB21pfVbpYZiVBDL8RBD8uG1TUU610mu8nKivXvo4g61Okjgnlddte6s3O+xvtJ/V99FqoeUBriOgZsg4uA+svBQsN1N9qhg1wpvOo3dtrZFdQHMlZ0ZtM4Vjx//fZW4eoOAkd/NoOyvuLBHnTGlceMqurC2Z+RO6ofLJ+xBETLQLZKy7JatoBS/VymJuvnk3OHWZfLr2BsAQIOWSPxnh6v9DTJkumeaalex28OkX9TuL1OhNwb8ENAfVe696cpRcERJUO+FsNLdslOgtjjFgE6GbJoDGFczaL2ZvtKa3VBmbwd3d7jUdY+9B9tP8u//lWf+psP5IV0YwC3PXniqYQoH8aaTg89GdS44T1abYG1CIqVh2M7ZhvTv7LKlLcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199018)(86362001)(8676002)(6916009)(4326008)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(8936002)(76116006)(41300700001)(478600001)(71200400001)(6486002)(316002)(33716001)(54906003)(44832011)(2906002)(5660300002)(82960400001)(38070700005)(122000001)(38100700002)(9686003)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ihWW/RPFhLC+ncS544byUI0kj3XBSdVVOBnH2bWZTP8VGJayb1XGeBezZuvc?=
 =?us-ascii?Q?QaZj7N939SK5AF7g3oW1HsW0JLuqBaWYvfsSOj4awlvMC3xVmFSj9Kvt4Kvr?=
 =?us-ascii?Q?1WSOOF6fEwDkQ458owJO2eRUTv0PRRer1+6n1lhoYh+DYc6chAfMAQQ+of2u?=
 =?us-ascii?Q?+dydHawIQRMGKkymb6971X+ss94ZchfWGOlhrCVPi7GI6TU1O9XbpNgT1att?=
 =?us-ascii?Q?bPtR9GQlwgYh2PS0vxM/TFmU6dP5zo+bZ83RXFrOYI0/fx6eoopOwjlqw41t?=
 =?us-ascii?Q?bRTFVnpZutyAvAeWZ/X5I5rx7OF0dD60phEE5OXJI+8GS1uSIA4P5+m6anhF?=
 =?us-ascii?Q?UUVOY0Nj8wrSTlZ9PlKk//XiAJ3HxVx0dr4KFu+j7dD6yXV3At5XYu6y4e87?=
 =?us-ascii?Q?rVwi8v9Rsht2cfUsrwPG3TdCksE3maHdZlb9ovxqVw5mBFGoIQ1Vaq0tcZTL?=
 =?us-ascii?Q?nEZBGS8ct12iAtP/hBiejjA1hm7+/GhjW1EAAyveYU4VElSwCPiKfHyThsDH?=
 =?us-ascii?Q?gsWeBzY91p47St6oShR0bTzHHQ7oa/P4V07lXvbZ6elByRnLZqMoz2UKQcNg?=
 =?us-ascii?Q?/J/UQGerv/e8icYmtCQdDjnIHNZ6qRNthAL7tuzmTNc17j3zIoSe3LVdET3u?=
 =?us-ascii?Q?WtQPefMl/Ks87zrB09RCU2cPVRMntW1s4usfPxr2fie8f0mnmMmlOUZ41jOe?=
 =?us-ascii?Q?qjp7HKp58r5r18eV7xbK1yH07fkUjiKSwbMh5Tb5zknJjSj/AcgowQeiXN5F?=
 =?us-ascii?Q?+QcXZ+b8v828+4FehuWRMn4S6Z6Swm8JQn1li1hdEYYBQ7KdsMWYXgFAMXRf?=
 =?us-ascii?Q?1Zi65X/EQ57sI7OImskolMVzbo9+rpeKsjvPfm/YArAj/nW6uqAmFUFpoHw1?=
 =?us-ascii?Q?GcjAh9XxKN5FqqgQ+Hll2dCKrwdVHZ1OcheKlMmJwEMhI+793i7mWlUKPGVs?=
 =?us-ascii?Q?3uOjgukIdGR9lOwuDWLW5EkHqHMutweHARARN0peKAlcWBMElyHTUsHtQhXl?=
 =?us-ascii?Q?zPqBeq9VtvI4mFAqfbddoHQBwHDfEObkXYtJ77oijQmTQ6I+rIusoxZiC7Ma?=
 =?us-ascii?Q?iv0WjOlYXCwK8h0J7vGtUBjK2Hw1TbuaUb2cjIrl7Xh4chynrWp/QP9FyhnC?=
 =?us-ascii?Q?i2WHOGH52nkT3kM8j0L7EWv+FMTige5TDb5SIqSF5XXC208APBrYoFstnxsI?=
 =?us-ascii?Q?Q+6KCQ0/9e+hKUp32c+v2TyBWO7qq3uqBNC+kl/JXxiQqf9wHZY8HkinE54m?=
 =?us-ascii?Q?h2o7WGw4pXMvzVbYKU491GFR9C7n0jXzXK3+EJ9PdWURPiv0nJhfEBh4l26N?=
 =?us-ascii?Q?Wtdv0uSSP5wa+7Qq1KG+kWV4iNH7Z6R5wrINy++QiG/qFGUkojXYSq1nt1Q9?=
 =?us-ascii?Q?pf2+hzi53aZN2NPHU2UWScdidsxNtERq9AAvmeaFsoAHWPDgo2MqzUWPjD8J?=
 =?us-ascii?Q?vkLyLk3LCwhMMJB2tWbMQQH42n9v91iSTB0U2EdFjmkGhxP3if5xntFdjunS?=
 =?us-ascii?Q?NrFbG/TWm//Z/P74HYX/cf8kPj6r5TMeeAqE0osxSrY1GvsUrpobXWqjsosV?=
 =?us-ascii?Q?M3IVPTb23aWj6WGFZfruD2UOqaSRX3l4Q9XckdFO3e+DoqqJLYY+VEWGRF8L?=
 =?us-ascii?Q?Ki4H8xD3hMVCuu9tEmxfdsU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B09A866B00382345810BF6B3DF0D0BF3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VttilYm28V2isXQDukMU9GhQYV+4JftcgH4UfHQM+/PMQofo5q+RD1ebUngjMeRVzMiUrHQaAx/53EMIc+vMiBqGt3v+cpmbV0oxu4UmR0JL/izbq+TX3CspE34MtsnzkxEbkD25D9l6naTJhOJ642baLn7Zdu00MwXI1znHODjFDdRo94QzEMAQKlnc3akc7uH2pNpoD4cNxrPEozoPzBYXHaLEUsubBF2iUXVCUcUOQKPx9bK6DHk0dtEnwObTRzaNibEzf6sswdiFk7eL1pnjydKe31hEqXIn46rtI7pSr+jW8P57hqhgt68aZk2PmtCEROlabqi0WIVQxy/mwZVQQRWM3sDOXE+1Byr2EQNKNjKkVBAGIFfbiIRwwWYwEJgRu2mjt2CU8KWHmClwbttmDWyDvm9wh1THCHEUc/3Fruugx1zZLBafl+73xRrKztM3jBp6LXi6G7yPaer9t47ia428KwQjfzsx8K8joyqMKAflZEurtbi+cMpAXBHp2a8EJmBIe4dMcxUDd3RKiBAt48a48Dva84bZsZA80TytSsJkGLJYGHf6GyPsm2J6D3qokHEmBaL2Xrj+w9mEfJsX5TyusMmWqBSK1UsyiB5Xvkg5W+UO9+GUcfIxdY5GVZPdyAXNli/HOaQV2xFGL2DMZOEJruVQpeiHp2SpnIbCp0rFpyqt7u7oPiMN9wx1pT2W4inU3nTyPh37iTmU1fGhaFvDhr6OQKYjkaXsDoLsbc5+sgkYyBTy2n5Y8kINFcdPa6O+adRoEJtcyN8fYGfChTfgGQF0lkD8oNHLdXraO5tSe9ZbPlLbnIotQuLm4LNRqecWf7CX0oxX01c8I4aEPsghcwRbEbYw4ni8OD8JXjyNieNl/15skBN6Dp5r
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c5096f-a3ac-4c07-c671-08db2b8d2931
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 10:55:48.4099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Unu4/YKLJYtCTZZbxE93xgzk/MQ4oeP1fwyu1kS2Vd5WHLjK0M2dGbOy6NUaNmUMBgVguztr8wzpVwK30/wP+mqsRPH9pEwVbf3vo+i0LIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7311
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 22, 2023 / 11:16, Daniel Wagner wrote:
> Test if the transport are handling the different queues correctly.
>=20
> We also issue some I/O to make sure that not just the plain connect
> works. For this we have to use a file system which supports direct I/O
> and hence we use a device backend.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/047     | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/047.out |  2 ++
>  2 files changed, 67 insertions(+)
>  create mode 100755 tests/nvme/047
>  create mode 100644 tests/nvme/047.out
>=20
> diff --git a/tests/nvme/047 b/tests/nvme/047
> new file mode 100755
> index 000000000000..6a37f7a569b7
> --- /dev/null
> +++ b/tests/nvme/047
> @@ -0,0 +1,65 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+

FYI, GPL-2.0+ is ok for blktests files, but GPL-3.0+ is the majority.
If you do not have preference, I suggest GPL-3.0+.

> +# Copyright (C) 2023 SUSE LLC
> +#
> +# Test NVMe queue counts.

Can we have some more description in the comment block above? I suggest to
copy and paste the first line of the commit message.

> +
> +. tests/nvme/rc
> +. common/xfs
> +
> +DESCRIPTION=3D"test NVMe queue counts"
> +
> +requires() {
> +	_nvme_requires
> +	_have_xfs
> +	_have_fio
> +	_require_nvme_trtype_is_fabrics
> +}

Do you think this test runs on older kernel versions? If you have any speci=
fic
kernel version for this test case, _have_kver can be added in requires().

> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	local port
> +	local nvmedev
> +	local loop_dev
> +	local file_path=3D"$TMPDIR/img"
> +	local subsys_name=3D"blktests-subsystem-1"
> +
> +	truncate -s 512M "${file_path}"
> +
> +	loop_dev=3D"$(losetup -f --show "${file_path}")"
> +
> +	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
> +		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> +	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> +	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +
> +	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> +		--nr-write-queues 1
> +
> +	nvmedev=3D$(_find_nvme_dev "${subsys_name}")
> +
> +	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m"
> +
> +	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
> +
> +	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> +		--nr-write-queues 1 \
> +		--nr-poll-queues 1
> +
> +	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m"
> +
> +	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
> +
> +	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> +	_remove_nvmet_subsystem "${subsys_name}"
> +	_remove_nvmet_port "${port}"
> +
> +	losetup -d "${loop_dev}"
> +
> +	rm "${file_path}"
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/047.out b/tests/nvme/047.out
> new file mode 100644
> index 000000000000..915d0a2389ca
> --- /dev/null
> +++ b/tests/nvme/047.out
> @@ -0,0 +1,2 @@
> +Running nvme/047
> +Test complete
> --=20
> 2.40.0
>=20

--=20
Shin'ichiro Kawasaki=
