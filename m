Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FBCC77B7A
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 04:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjEZEhf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 00:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjEZEhe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 00:37:34 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C270119
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 21:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685075853; x=1716611853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rn+KzQP8JD0YMl2XfjpDYqke+PDGHxq2qzkWekDrSaw=;
  b=ib8qL54cdwjHlKS+1ykgxYnCBJub4TrEKAXqPnuqerivypdbO8H0yzCO
   zWCrIHCHYPMzMIHlwwjSHEQUblGRB3E9EOGEW3yZ9rer9eHMTc5VT7QSr
   VwLOwvioYZbG35JEJpv+sJpxrE1VnawFaanPI5mi1OyVSc1wPpSE9c+Vk
   tre7DSZieaKiRU5pTU4bcO/hmZqYsy01+1y/H5HQE08Qj9eBb/x4lYGpn
   bD0zwfNDSMS8iPy+VFh2w9PNwVsT4FaFUxc3urhqkElyOCPbAi985qZtG
   bn9Ddlt1piW0ty+D5JrJKeIiUwwEwlKaoq8fuhBjJvLWywqMjoNnfvq8l
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681142400"; 
   d="scan'208";a="336165781"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 12:37:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwjQan/2VbzoltMx9KiOwBTzyiGgBt5ToKL8ZxO4SIZgwMIy0tpb46z6pGmYZBM9pBfznYBfjXkylVSz7F1K6z54DoV9W6iVffshTVhMqylpSCWnG8QED51wvexKSQwi/ZjEuLd0jUEe6dOpHCv2TKQdKjvqVErPKI8HhYfDxOpwQ8D985sjBienAmCOaOlv+XKHgjeM0VI0MzFO7id2s6nyNwUeuB1q6WdrDWAyza7eBWE7EA5XB5e4DXYmHcPIcS229/IsPiBojW66kKTCeBKk2IDAOEXM2pGYwAFberFCuPUziKLJ7srGxTCTojaNsGmG3KTpIto4rYADRfalnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se32w0HdbON537+6/psf3Bb+PM9EXg6Q3KNmr15fl1c=;
 b=Uunk07TALculwX0j5L4vdeaqA37FPlAR9uZAxlTmfFt+0frRVDMUePtVlwvuWhiil6UZUMQIeBFSx0scAgSIGW7SlMQeEJwz6Jo7k2x1LAOUq8RBGcyhulKwXxOh+kfjXIWSfSa0nI9YoxtTqw4YX9ynfhKEyp5WeuTJ4RXui7+6/GCwKIDJhkhyPTNo75ACxR4obEblc05c01BZLoi3VMpWupPuFUarSRs+WBPqK0W0BeClUSmotmk2ou8C6W8ks33ksIOCi/K9+7kfa3j7Cw1biWBXGn7jc+xpS1/OiPdoV3w6HIWt36USJvuljx2qLSXcoB6LuU/Ut5RZrtUuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se32w0HdbON537+6/psf3Bb+PM9EXg6Q3KNmr15fl1c=;
 b=Gv//MASXXuOxXlMzJMsepkU737wGPeoALjRF69A/Ndkxx2n3zbozL5dYCc4cpMZUYnD32wTLDLWgCBoHxVRUFBt1fkcFEGLXW3ChXpGe7LjZpd9xoH7n+P3n7k3tx3USQin3S1lZmc5CtJ0eREE1ZqHRh9pevhL2Gmcezj8hnlo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6720.namprd04.prod.outlook.com (2603:10b6:208:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Fri, 26 May
 2023 04:37:30 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%7]) with mapi id 15.20.6433.015; Fri, 26 May 2023
 04:37:29 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 blktests 2/2] tests: Add ublk tests
Thread-Topic: [PATCH V2 blktests 2/2] tests: Add ublk tests
Thread-Index: AQHZfwGvsYW5q3GqQkSpPwZFpAx2qq9cqAqAgAyQvoCAAuDBAA==
Date:   Fri, 26 May 2023 04:37:29 +0000
Message-ID: <gecc2z4pgwlo6br67cqhmiky4ylbqqemni4j7fgicuoyzyccoh@qrymyvf2twrr>
References: <20230505032808.356768-1-ZiyangZhang@linux.alibaba.com>
 <20230505032808.356768-3-ZiyangZhang@linux.alibaba.com>
 <ktb4tdaag6xr7p6bu5dfdgpzanrrg4lnunf33yby5mklhe45eb@kxuwcvhhyjpb>
 <3859c73a-a390-86d9-0101-969bbf2ace11@linux.alibaba.com>
In-Reply-To: <3859c73a-a390-86d9-0101-969bbf2ace11@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6720:EE_
x-ms-office365-filtering-correlation-id: 7da71f2e-798a-4796-7469-08db5da2ea00
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qC/YFuqqvbLyU0hlg1crhHT6Jj2+seujUuw9rpqVTXVKTD4VuHalR33NWncq5BUaV1LWcUnMrlWnCtT0Wv3w3a7a8AOKqlzQQNS6zBHyWWNWtE5ZvdC8p/+sjFo5TVC3CE3FEyYHvno1K3IvK4xsZ6leeyjTks68RUahv1Td+WlmqsgDTTo7wCaVyOadM967EFbWbG2an1hx/fHmgSYrZ5BKW5QPlsZcZxctuP8bRua30eSXigyKB+iUkSZFkddkJdImyn0yl6BkZNw15aBmnucrqMEqas9y5tedO8gFLIllAh4bJ3EOrbWhIydvfBOZ6EZF/5C3pGdyeKOpebVg+rHI/GtfP0BzktP+9nYhN1gqM1ZirQGK6gWzKXgg0YudzzIJDevmqyZ/ZK43NzMVFdq5AFQ91wCi7Y4Dfk054OSKcfbuMfH/gBt2D+2g81anQ2En0HQfrMDuGJ/liq40iyADw7FfhMG1dLPYLyEEofTnuQf0usnVy4lB6EgUeFqW5N4lJ1IDVExGn/UQ1XvILX/vbsaEu9MyHmg0ucWC+nulNyoKgUEJE7QzykjEGr023airfB2RAfj1js5+5ZGhNSD6fRrD0CExcFLxGsoshB09GWeV7RE1OVyTQCFNpOYD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(53546011)(9686003)(8676002)(8936002)(6512007)(83380400001)(38100700002)(82960400001)(33716001)(86362001)(38070700005)(122000001)(6506007)(2906002)(41300700001)(76116006)(64756008)(66946007)(66556008)(66476007)(66446008)(91956017)(71200400001)(6916009)(5660300002)(54906003)(6486002)(316002)(4326008)(186003)(26005)(478600001)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KqiaKztUW/GH4pDcaLS2EpGAqgRK/1RdZhnJ341gDfl1/6MtfKA3oPWrocKE?=
 =?us-ascii?Q?1pfz4rsk4j6NLck+zBIcbuWlAWm6Il4a1oNqI0LM3mz4HVxMM09WivGMM/2m?=
 =?us-ascii?Q?nRneAOKmcUaHVRimlA1T54OOzUcpFaRk8d7Q9y0CM/AA3gNlTf3VlZXM0caJ?=
 =?us-ascii?Q?mU03wpEhNTZ5VnBmPUeKDQc10uTha2m67qwpP89xFu64THBoLrBd0AEAMiNs?=
 =?us-ascii?Q?tIHlacMy7/eVjytRODa455JOz+fqvyLVPiKw1u0+lxcBkE544JO2F6/O4mxp?=
 =?us-ascii?Q?rfm04Kwn71NyauZhe9veBLMIQqOVDJDHXPgBAKgMhTsOFNnipKpwDHDuEInS?=
 =?us-ascii?Q?bi1Weges3KCBTa46gHYx7kQEoNkqkruw/qBbjUncWVhKacAY/9cVvHtAPBFT?=
 =?us-ascii?Q?1047Sn8FqyNYyF7Hg/R7ysPTLQyVWQUDZlUIV3epmx+09EDgzhdKY5AIQKDr?=
 =?us-ascii?Q?BEs0c+CnhLX5chC8MPyV/8NpdRTpfEcPmWAft4QXCuU445IyLetRLVzK2szr?=
 =?us-ascii?Q?rItd/neg1E5w9BA0OWjUVl0fiCo27Ks+Ao8elmcG4Me4m09CyFtbjZcP9/N9?=
 =?us-ascii?Q?vcsfEXKJbNRwaQfHwDTOLmVOQH6y1LEEWUOnpjAw0zqN+5jvsP/VFpeAArCg?=
 =?us-ascii?Q?dHyQJBPNAXLGraisiQK4/awd1Ay/odXK1bLQIqkAcrg/pgfkZzenxk0+wXl7?=
 =?us-ascii?Q?XwS1Qw8E5TOZTwJlGhaasQ+/0saBxUtH3J/6GbvLdedO/vkgR81JYopAHxra?=
 =?us-ascii?Q?Zofxp8lJyMsSGURTpUnXvW0MhzkYDe42pemfchgckepzdzG0sBYDTaeblVFj?=
 =?us-ascii?Q?quxsuH4uMM7MQhkHHP4/xZ8kxCqv5c9brcrBz6z0jEIv1hj7dO7nlt7r95lv?=
 =?us-ascii?Q?QrBwlgZZcToCAW7LLkNvZihDAHEOJXesUORsUNHh1jtVTcLtduieUTCdGIHn?=
 =?us-ascii?Q?zfTqXIda/6pTQ0lDGD+Psw1HtqaLntjxaU9bqfF0rWvvnLcLifJ7uNV+4+nj?=
 =?us-ascii?Q?piaO57kFkk1Q7YO+lpTEjKMfiCPI275w3CEl5ezfMCGt1pYOnfKuXz7ENRyz?=
 =?us-ascii?Q?63IVGNNS6MsA3U5hYEO2rTz2Mdih0HMW37EU60oA+g9RbD/kvP1wNDNavwmt?=
 =?us-ascii?Q?rjMqv3IA0lq2QGra4W+y2A7GzXX6DLT4qlv3wPEvImmQbIOFtYcK3Odu7cpC?=
 =?us-ascii?Q?2EZVIhWR+kqIVDIt2fy7nkUP37AJk3kfP+kXn5LlXS0SDlKDYfwE9wBoHu3I?=
 =?us-ascii?Q?zna8e5b5BZnB8hYEqJkzgpSwG4OMZWKsu4oe599K18AjFozMt/wMwQiPMPUt?=
 =?us-ascii?Q?hUDOL0eqFxOemPEOBHoD0hCSwqo9qIoNGXLMe2kT5yGzYZF6wtSz61ZdXH3a?=
 =?us-ascii?Q?rJZXDjsQKKDDtePQ9bGS/ShgUwwjn5qP6eC897qt33+JXrgMScxZgbheqqeS?=
 =?us-ascii?Q?i2ikKDQenLd8p6LgBH0Q3/0pO98tJ6Zet7Hyjmrp/CPccyY47iRwhQVY/uFI?=
 =?us-ascii?Q?VsAWNNUoKSwdP8Z8jf4Mc0/SFTY288ljZaQsd0Dv7j3vtw9wIR0GoMiIUOG8?=
 =?us-ascii?Q?2MS9IKxGvoduflWJqqCtg7AcWSG8+xPNyRDn+V5nmGV6QvaJcwp02QSgkwB9?=
 =?us-ascii?Q?Z7gJvJSO9bDiTzEQFWlcg4Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E01EE0278DDBEC478C12725471FF843F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iR4EyHjrxGMgjxKlCUqhKSiKmhxVJj5LrqAErspvfHvmqvqf7Z42RD8M4XZLvWD6O/6JVcMf8FvWzxF45rXeC7iBy9WSeOgCOMJH/90Xb2glsDwvt7e+Hjxc25i47DwerU628yRgcTuv//nnQH0kb+vS/iZLIU4Dqn9wo7+4Czt7rHkq6c3HTa+h+outd+yNymuav0FtZdRucK5XTW/yURut+MWqsAjnNxCMEcG1EnusV1dBhKuQc5+e7jFMaHi/YpU6lZPHduzh75QzM0nbi8PsjI9IzRRE1WgZoSRvSsQEUj+jie9W0QFPjCBQxOWogLj5TsnRbmGL55WbLwk74aKYlHRQPc9Kt2PNYbIoc8C6S49TLJ3CleiP9vLC6za/n875h8P90TKlJMx7ZXiIkUGjxMd50hoXUhp5cXKDkLJ07aJqKyLQ/8rHLJAZ5z+UaX0X3EofrVXCQ8gixoNxTyJfTpnGXQWR+QyOEtD4aOIebTRNn7uJ/VWy0/LadTrrG1s5pWFHyMvtW8hdaoPw3RwXKwYkrk00RbMg5whZUp1BUfV49jZjByZkfIdmocy2YBedrPcw2VX40v+CnId99HTAipXxT/ngPtMpyBeQ7oq797m4o39v9CQTxZ6gMr3jyPT4+LHEohpe7YaqUaqV19MMxLFul57B1517BHNFKJypUiNByNIzOYwKSAszRybt7CgeBgTzsRZihx4suome8tXN/53oE84dANVOGQMnLpnBeMVW8k1Mh0gNKAIP+iUUamyT9+wEsyNnVf3RprnJ9xI3iXBjxz8DWhZ10AZans6A4hZ55ultxhoTnv5D0eDclaqcpp2fYbAymTfdUzMvvefxNuTDACIw+bO2GDIdDcI=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da71f2e-798a-4796-7469-08db5da2ea00
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 04:37:29.4568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99MVpFA7Mi4mRhXl8hNJjYpakgDNwAKF84MinARaJJIWQ5ckoKh3jXtgvMPr/x4IpXlKXD8PjBt/JRZLttj718/1pTxtG+8TC/NeELTiVK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6720
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 24, 2023 / 16:40, Ziyang Zhang wrote:
> On 2023/5/16 16:47, Shinichiro Kawasaki wrote:
> > On May 05, 2023 / 11:28, Ziyang Zhang wrote:
> >> It is very important to test ublk crash handling since the userspace
> >> part is not reliable. Especially we should test removing device, killi=
ng
> >> ublk daemons and user recovery feature.
> >>
> >> Add five new tests for ublk to cover these cases.
> >>
> >> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
> >> ---
>=20
> [...]
>=20
> >> diff --git a/tests/ublk/004 b/tests/ublk/004
> >> new file mode 100755
> >> index 0000000..84e01d1
> >> --- /dev/null
> >> +++ b/tests/ublk/004
> >> @@ -0,0 +1,50 @@
> >> +#!/bin/bash
> >> +# SPDX-License-Identifier: GPL-3.0+
> >> +# Copyright (C) 2023 Ziyang Zhang
> >> +#
> >> +# Test ublk crash with delete just after daemon kill
> >> +
> >> +. tests/ublk/rc
> >> +
> >> +DESCRIPTION=3D"test ublk crash with delete just after daemon kill"
>=20
> [1]
>=20
> >> +
> >> +__run() {
> >> +	local type=3D$1
> >> +
> >> +	if [ "$type" =3D=3D "null" ]; then
> >> +		${ublk_prog} add -t null -n 0 > "$FULL" 2>&1
> >> +	else
> >> +		truncate -s 1G "$TMPDIR/img"
> >> +		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 > "$FULL" 2>&1
> >> +	fi
> >> +
> >> +	udevadm settle
> >> +	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
> >> +		echo "fail to list dev"
> >> +	fi
> >> +
> >> +	_run_fio_rand_io --filename=3D/dev/ublkb0 --time_based --runtime=3D3=
0 >> "$FULL" 2>&1 &
> >=20
> > Nit: long line
> >=20
> >> +	sleep 2
> >> +
> >> +	kill -9 "$(__get_ublk_daemon_pid 0)"
> >=20
> > I think it would be the better to wait for the pid, to ensure that the =
ublk
> > daemon process completed.
>=20
> Hi Shinichiro,
>=20
> As the description[1] says, this test wants to delete ublk device just af=
ter killing
> the daemon. So we should not wait for the pid here.

Thanks for the clarification. I missed that point :)=
