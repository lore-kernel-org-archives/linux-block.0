Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39B5C61DA4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 08:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBPI3e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 03:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPI3d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 03:29:33 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C42CC45
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 00:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676536171; x=1708072171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GRyAssY8/wFdb0Us0H9JB5fCatGQC6Wuvw3WWM6/7W8=;
  b=pMzU8OVFHpKPJ70wiXIQmMFPo4WvjC6PYhPDsyBiCbZh+QqZ3xb3y/l6
   L3cYAxx+B0ShfKAHT88o+teiLLFBe5uBxnk1W05PFBqKSPFOQAypELj0t
   n/B2L/Ilamq8q/2IUAx+MHNCGYgKGM5zBj8gOK+H4sXwx+ZmRy+tghBKT
   XeA7iCEm+fyaCNBXUr0w8J14c3GHwmLimSKKNnlGlxKkpcRS56yEib77s
   U3OtC9ERAxvXJO76buhFLVQJWugzFpyW4r/edxBG3j4kmsIclUHwSfqA7
   dBm5mD6D3JirZAJfFv8+5uEpoFVtRAuvNxXfKSWMZYlOB4EF6qQLoJ7k6
   w==;
X-IronPort-AV: E=Sophos;i="5.97,301,1669046400"; 
   d="scan'208";a="228417190"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2023 16:29:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsoQxbndct10A1rvzIUsOV/JOJnp6ByqaCDNUvXwkP5WD8mLuyBIoul3tJqGzDKzeNHK1SwRL3s9i4C9994aw/kpL5Abw6iLrkWREHcSJRbV7S3BQ+p1wd9xKPdkUtMyqtrl6hte9Xfr0NGjOK1CcHlTkc2+jVYz9tfZbae9M4aQVmtEozqSQdsqYCPjMmd4UEBk+cmtEbazbiXiFSrU7waFWfZ2AIP9/WBu0AXHKySo/XpvEHPWpIRDFtG4a6YBqTx6Lql8PY9HW3QhmViatWLUYOGMc/FKyFm9/0h4zBqabXGZS9rb1a9jXuKb0/9TZdsqyYBCVWeKya4Uf1AWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1CkdzHrATJAbg3HeG2aa9G6yyig8Ym14kshY/t0Grw=;
 b=mXhAIkLInL5yCpj/Okn8j02Sclrb6XHtSv+Kxfcxe80CApS67ZMiAFFupzTYcMAmrLw0EiCb0730oCkXhhsxM7iQpm1TKXPkfZeTLDY9KEs4y+qMTv5iHMm++o3J+IDjQjJY1bmRAhVghawmmnxKNoFZn4RhmQLIIzqs3F6hDNjctihLPxzIf5Bl45ypsQ0lUrx6KwcMnNTqXb8qrprgSF2aQ4Ctoj4dML8ZNMMi66RDvJ/G8Hup/ya/0nJQUH48ERTRXdwEN0Jfi1mqHWiGI9oApJO0VyqNMXcJT0VRWvU+JAWgXPVdwkXLBz7BjAk894AZOL3rFsnldX50zp6nuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1CkdzHrATJAbg3HeG2aa9G6yyig8Ym14kshY/t0Grw=;
 b=MNqnktGXg/7VHgqRzemi31o7YILSGChDlMML5dDUqEgzbt05sZugjnPFS39lYTJx5vMzEudv+bNZXrM2OjcZEgvaHdh8sB6UZ3+QT2YSo6XoQvHroW6MZ1xq+p/g6lkNnSsCe/SPA1K10k41R/1OMfttRyS276uK9kpeSq+clfI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DS0PR04MB8761.namprd04.prod.outlook.com (2603:10b6:8:127::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Thu, 16 Feb 2023 08:29:30 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa%5]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 08:29:29 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] blktests/033: add test to cover gendisk leak
Thread-Topic: [PATCH 2/2] blktests/033: add test to cover gendisk leak
Thread-Index: AQHZQbM1cXNzlNcSd0ylVLViFm1ow67RPiyA
Date:   Thu, 16 Feb 2023 08:29:29 +0000
Message-ID: <20230216082929.j4wgi27cu2rtkp5a@shindev>
References: <20230216030134.1368607-1-ming.lei@redhat.com>
 <20230216030134.1368607-3-ming.lei@redhat.com>
In-Reply-To: <20230216030134.1368607-3-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DS0PR04MB8761:EE_
x-ms-office365-filtering-correlation-id: e13b59e6-fbb8-4e0d-34f8-08db0ff7ec3f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /gVRgT08NtMmh+QZjC0FzLZ6YFkdBRYNqmRSznzRaNFjTpPwZAEnBqXUJpYVHqzQ2vjjyWBaMo3y9j4qAqvjqS55HjTNQvFRNmDNS0JmY0gZ2Y5aCzfqVP/eRN8reLGrphsHwIVPZZnoQV4NxkCIXnhS7f32GSZYmcWpXLWKz/f8kL99U2BwtJig3qRdvhMkq0Y0eYbpTiHYST4v0KFzzg/71DKlVCGBKSmZcWZdznjX31GwQxx7ZxhLAgEObeyBbwJcn9EhJYxVHbMlgizHrBVM7DZr1oKswgLs4XWUa8veFydO1Lq+S5Cj3TKSCzCndMBXAHwfJxmPdQYbT5flDkK/0iq5fIyXwztpcw7bjtjpbTfikyyy/ldB6/hPJIy+OMkn3ESbyNWm6EvE3klLuaBHiqxnIU73tSF59rzgoeXVxEvFg3mQnQQVCWmoCo5V4UtoZU4DFR5R9690FIPdkuexatXAoh/dzXedDGcKgc46YimF5W6UrkzcHyFB0ZXbtyyw6rCvoDIAYSQb3QtJLy/kRMuQytfCZqING9mf+Z7Jidx37xYDMrrLfuYAYE4uZomdg1ilfaT/MuUEqMPEUlChOCBHMw/vFZ2VqQphob+8IPlAkVFHJkYAtZZQ+hrUuziG1UgyuiABB2cquVE5HXIor7iR5dQicovCIEjWJQcKzxUH9kakMfSxZY9zgSiQbvai8cBD1R1oTVP6AzfH8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199018)(26005)(186003)(71200400001)(2906002)(83380400001)(91956017)(38070700005)(9686003)(6512007)(316002)(6486002)(8936002)(86362001)(38100700002)(33716001)(6916009)(122000001)(5660300002)(8676002)(76116006)(82960400001)(44832011)(4326008)(66476007)(64756008)(66446008)(66556008)(66946007)(41300700001)(478600001)(1076003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8C3A8HstJhPO1EWJnQeBwqT5ukoOaW1sM192ER4L2Ey7oRgFLOO54GTWv2Hm?=
 =?us-ascii?Q?slIbH2cAw7Nf4qUYAqq2Fr/BSNekMKZpCBYLxbIbJ7tXi59TNGWWcUoz0e01?=
 =?us-ascii?Q?QSCIDUwgseH8BhzTaxkXPapGWjy7I+SMQ+VSwi8tRLNEk4D84gufNFjZ/IZx?=
 =?us-ascii?Q?pVUYBZgyyOadK4Hl7gcz7it5w6TxpSTzKT5OoYXXprnydWOZZTnfvmUpeqKh?=
 =?us-ascii?Q?KF/Y6hSgAp62HjdJDPYzib3yKMo0KnE9Gs6fQf/3fAwdslJ2kkleLAty4S8p?=
 =?us-ascii?Q?szVbRyzEnEPdewVHA7wB+XdyC2bPd1B5cb83wYShMlxM+ruDvrNXyzjP8oSd?=
 =?us-ascii?Q?Usqpj/QVMwoE48+uJuoTeiVoQyHeQIcu1swpHgiZJNpbpJOqlXyMUEJSV4cZ?=
 =?us-ascii?Q?pXDppvHcLrxC1LI5swnvYzHZP7MYyuk38LWs5+BLSUA85PdoRn/oDcL5WM4q?=
 =?us-ascii?Q?V+yee5yjePI1Kks299q5B33fXh6zdPp0ghKJgy/58BO+GdlseMJZ3AM1NGmC?=
 =?us-ascii?Q?ZVxzqoBTQyJbYHDit0ZCkMFDYttg3N3ByiNdC13Rj8phVLAWn5pQiT47za+1?=
 =?us-ascii?Q?UAX1Ts3OQyR9+Zhtn6QQuwY/AHy8ujGmxuHGDJq4PxPNqMk5WX76+lywGVVO?=
 =?us-ascii?Q?JLhZZxSZhTQWkmqQTn3AkDdszpAyvkuXQoMK7eVznM//Dcb5fxS4RzZ4cEZS?=
 =?us-ascii?Q?BCWfylMh/H9WaLJ4E62exGboh8i37g1kLS0k0l33cItsDVO/wDDiiQXZMNIg?=
 =?us-ascii?Q?zjH/EZ4UioXWKUgvJ6Lvg/MCvP80/Gj1fPE3x0w7QkL3wBIvqsLeSb3Q1d+X?=
 =?us-ascii?Q?T3FSZL+9ubOua8/zkk9XSAnj5FDycrUdE7gmwcsYt6FOJMkJW0lRpexjrqnt?=
 =?us-ascii?Q?repwTH//4v1pjeAfgO0hfdIRJbcX7QItt5ILqZHB3aoZAIIbWqadJQl9OTcd?=
 =?us-ascii?Q?QurjdOuqMlHchdwkm4c7wJHlPhVYvZlEuHFrk5fsXx6XxV6DQwbeABFLVN4f?=
 =?us-ascii?Q?0z9I8AGXQOC2EKNZQKCIS4eIdTxqvxlQb9wAoE4GEYJgq/hp4ZCrMCQ04yOJ?=
 =?us-ascii?Q?A+N/Lh8UwWbz5FT49c3lC4ZUrHl7HsxB9P2oEOmkm2iNxqXTPBIrDFez/Z3t?=
 =?us-ascii?Q?lWGY8XIaCSHzL4lRhcAWfp05Bge0HH/z4LSRqLm2wvwjerSTkmiTWKmkrR87?=
 =?us-ascii?Q?9+hJarhZ65bVp4EtP4rYIlcleFpohzF50kY9dSVFd28mJ4K1MMCXnxF1djbw?=
 =?us-ascii?Q?m2lqEWT/g++VjFNUfN83DHRFuh46JR66vsM20OFfKYwELKApsW3WmyQDmH+3?=
 =?us-ascii?Q?sqx4CA7GKT8J/9PP+C+Hc10d4FdW9pBNZCwLqsMV/Bh03xkLKw1pcU7HBM+v?=
 =?us-ascii?Q?nToIrzM6s0ijy1lneAGqLmctnBLueLmmwr8R1vUV/XWFtFLMFyYT8yXXGeJI?=
 =?us-ascii?Q?BENVAc2A5m9C9KpGQ2vOYCwsZm+LEZ/7oZQ5UntkqKD44JH9mTynT2NejhQ8?=
 =?us-ascii?Q?NJU6iyfBEEzhwhC60zYCGlp/tKiCBGuaIE//wjq18mE+otvYefwIF2jMtZtM?=
 =?us-ascii?Q?n2fcG8mSMbYH0p9oIbCZDTdvwNj2SowOKvh6LtMkrOcDLGmZQIRY2RTJOkUz?=
 =?us-ascii?Q?oxfqDD2PN+6AUl7n2JCRD/M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0935724EBBAEEA4CA295478B476862D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hFKbxnnLbGXjaKMJ5pnAMIQCFJBZRorpHSv8XEp/7I9MxPar3AKFn2iBwesIqWRPA5IDiGjsk8BfdHh98tvPAwJfPqLTY4ADI4JVzxEplXknPPK1o37E3eqDMXzCQmCzsrvP17P+cuEf0YOpP7uGFlA5VkjmSQF6oSB5DnuBVYDIFLL3L8+vcruLpAQjLhAb/GyUJ8cqzBVgc0qLBkd15YWiWFUV+s0qExhuT/3ITodfqEz+Q78RTm0w7n4gU6qXVLQvMwAHPzZS1Q0ELpuNQdNBDSl6P9Tw1XTDuBz4CRRnhyi+Chyrz8Q1kqQDu3jamGG2mD5s4UHeQOyWyPxukoI38li7ThcyJeb+GfSEaVPW9DxR83XuXzifCrWK4bCuOoZ0crU9Eyll1N4LRBsUx+97ApdKUQq38jB7KjZmGCQYISxbgtobf8NSVObVNpknF+dYvbD4ziv/GD23x9h30UfyecqMupWoBSztJi92Y8BRVXjubUWLK1pKhyq48DIkQ8Nd2J+7/NshBN9LzDt0VDxhN6IpZScGJ+eeAj6f8hhUaD+0wyzRXMLa62+1IpTH93lOtSA5rVsVieKwp2B+pXYrsUpSwRBy620bwGWQg04PTHmaFo2v7OLDaVGE1paEemegb1r76WLA+JxpqJMtQXmK0ffVWKOCwVGObMUt6h1tH77U4fe5tn3ko5hgzZQECe+Ggx5G6m54l/VOGSmILCEAmBtI1ehrsrvRm5IS7ZgVeYfU3GU6ClgmQ3XJgihS5TkBcvpaRU41NMGDNBv+GZyEzf7bnx5BtpeD/O0PNBUgFC1LWmYGl6h9X8LLvl6Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13b59e6-fbb8-4e0d-34f8-08db0ff7ec3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 08:29:29.7961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FI9Kiqqg1nRl9Ws2HpMExBDkGGNz11klPYYbnrxSKeoO2jFduU5x0aAFqCv1dxCaVSlhF3S178W4HrSneJqatg5lRm56XIj34Rhos2NuBnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8761
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org




I suggest the commit title:

    block/033: add test to cover gendisk leak

On Feb 16, 2023 / 11:01, Ming Lei wrote:
> So far only sync ublk removal is supported, and the device's
> last reference is dropped in gendisk's ->free_disk(), so it
> can be used to test gendisk leak issue.
>=20
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  common/ublk         | 32 ++++++++++++++++++++++++++++++++
>  tests/block/033     | 33 +++++++++++++++++++++++++++++++++
>  tests/block/033.out |  2 ++
>  3 files changed, 67 insertions(+)
>  create mode 100644 common/ublk
>  create mode 100755 tests/block/033
>  create mode 100644 tests/block/033.out
>=20
> diff --git a/common/ublk b/common/ublk
> new file mode 100644
> index 0000000..66b3a58
> --- /dev/null
> +++ b/common/ublk
> @@ -0,0 +1,32 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ming Lei
> +#
> +# null_blk helper functions.

I think you meant s/null_blk/ublk/

> +
> +. common/shellcheck
> +
> +_have_ublk() {
> +	_have_driver ublk_drv

The _init_ublk() below looks assuming the ublk_drv modules is loadable. If =
so,
the live above should be:

    _have_module ublk_drv

Of note is that some of the blkteste users run tests with all drivers as
built-in modules. So it is the better that the new test case can run with
built-in ublk_drv, if possible. (Or it can be a left work.)

> +	_have_src_program ublk/miniublk
> +}
> +
> +_remove_ublk_devices() {
> +	src/ublk/miniublk del -a
> +}
> +
> +_init_ublk() {
> +	if ! modprobe -r ublk_drv || ! modprobe ublk_drv "${args[@]}" ; then
> +		SKIP_REASONS+=3D("requires modular ublk_drv")
> +		return 1
> +	fi
> +
> +	udevadm settle
> +	return 0
> +}
> +
> +_exit_ublk() {
> +	_remove_ublk_devices
> +	udevadm settle
> +	modprobe -r -q ublk_drv
> +}
> diff --git a/tests/block/033 b/tests/block/033
> new file mode 100755
> index 0000000..342ccf3
> --- /dev/null
> +++ b/tests/block/033
> @@ -0,0 +1,33 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ming Lei
> +#
> +# Test if gendisk is leaked, and regression in the following commit
> +# c43332fe028c ("blk-cgroup: delay calling blkcg_exit_disk until disk_re=
lease")
> +# can be covered
> +
> +. tests/block/rc
> +. common/ublk
> +
> +DESCRIPTION=3D"add & delete ublk device and test if gendisk is leaked"
> +QUICK=3D1
> +
> +requires() {
> +	_have_ublk
> +}
> +
> +test() {
> +	local ublk_prog=3D"src/ublk/miniublk"
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	local ublk_dev=3D`$ublk_prog add -t null --quiet`
> +	$ublk_prog del --disk=3D$ublk_dev > /dev/null 2>&1
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/block/033.out b/tests/block/033.out
> new file mode 100644
> index 0000000..067846a
> --- /dev/null
> +++ b/tests/block/033.out
> @@ -0,0 +1,2 @@
> +Running block/033
> +Test complete
> --=20
> 2.31.1
>=20

--=20
Shin'ichiro Kawasaki=
