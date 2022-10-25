Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD88C38A2D
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 02:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJYCtc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 22:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJYCtb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 22:49:31 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404C91C2
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 19:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666666169; x=1698202169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aXkxtG0VKpGXqL2zhEsHYIFhPk2Vy9ejTQ7/waWUAf4=;
  b=THL1NjcmPZHMOYAg1RI8k7Q0WNnrABP98DHMocEoO7zEuA9okXPTJ41b
   JlAWywBpjXNU4XyiZWmCvyf0QgJWPbYetcYk/KTXA8S4HF4oI5l2QOWvH
   3B0sDBvPwjqx4FX9j7fbxZR9v7w5ZdUrRKAuTid7blP6WXEkywF9GJYiN
   FLsQX3IrAU74GCA7BknEbviQGf7F+OjIRzSrgqFZ9dMGcoM4mKuD+w3AD
   J0PjVODUbfAvI7VFViN8H+EBQvcKqm6L/M/cZrP4bgUeyhFgHmqGPqkQj
   lz+YPag28cnGeZKwxh1STNJ+tENGM7Dl18cWJHKZg/rmLGXbLA95PkmNq
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,210,1661788800"; 
   d="scan'208";a="219809268"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2022 10:49:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7Fh2/71P58JatGiUBmAnPiUR3C+WakaQQfXpBV8oVntTZdWwmI4S1sSNX6q98gckvXxgL3hdFZGGLvjW63qQ63Fij+lbqyyyGNk25aWsZrgRO4X2/XlROozTTVzWp2bH3RncKX3yRAjAEsHznyd5Jldy+5lglado1eC4qaoqD4XFOpfEEdjLcbmr6QzoMCWLW+eC3Uvhf8jEHQh9QqnpxPVRD9Ms3O+0IK3Cdvk/l0S7abU7Ieo6uw0AAu1ZOqHSuCAMdQb9GbWHlwXJ973JjRhGjnrPbA8fZOWRil3bq6i0YxCNh7aVlDKORSYSIqAfYEthGL469CB0tHq4k3uXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIdrlN9XAIUlUH1dhVO2FcYS0FYPCyoorIokk9e8Bys=;
 b=cw0qrXbpfEHfEdfpx6dIiaY2hJmxgpJzf/QToD0GwO63j8uDUaPcoR6QQjKiLe0FuhOfWGK9gTZeIywkaE1/3L+uWmdoR37NCJ7vwCyk/YiqTsTghFopLAQJ9l/OYTqcez0Sby4KiT3t+ZoSEy7vLhiZWgAXnGVHr0LbPaGiUp6FbOjGbhrprazbuzFCE+QC47i9bWqJDpU6wPMV2mP1Rv9baiz1WpEbvzo8r4l7mzeCCqrHqEH88catnzt9UQUbEmVSBKBuc+fg80J7C5khOqqPfctybyTvt1PAatnlFB2nCQDyzvpqJWTrtbUYDenhX+O91XpklKyrzjerirjvaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIdrlN9XAIUlUH1dhVO2FcYS0FYPCyoorIokk9e8Bys=;
 b=yuPmNnUPzpJEtKpKpPgSZm5UNWS2PIcrPG8OLBlOQgy/AUtQM0R2MEpCPerLCYxoXgi2JciGUr084J9QsdBMmu7ZfN1pHJiVWMBArMMEZoQcKhhgXW4T6fPVc4zYkGtF3igtf/G2I1XxMhMoIhe3OKcap/SJpj8iZWi81j1k0Ts=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7558.namprd04.prod.outlook.com (2603:10b6:510:54::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Tue, 25 Oct 2022 02:49:25 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 02:49:25 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 3/3] common/xfs: update _xfs_run_fio_verify_io to
 accept the size parameter
Thread-Topic: [PATCH blktests 3/3] common/xfs: update _xfs_run_fio_verify_io
 to accept the size parameter
Thread-Index: AQHY52/uj4dlNRsCUEWW9R8wiZgBlq4eaecA
Date:   Tue, 25 Oct 2022 02:49:25 +0000
Message-ID: <20221025024924.mmtyrb34jvbzyotl@shindev>
References: <20221024061319.1133470-1-yi.zhang@redhat.com>
 <20221024061319.1133470-4-yi.zhang@redhat.com>
In-Reply-To: <20221024061319.1133470-4-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7558:EE_
x-ms-office365-filtering-correlation-id: 15ad5da6-e825-4977-ca0f-08dab633873e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yD11b1NRjOFlXOt8GkDBYiPzYgLU/CdCxZqDnVhp/7JreC8IBEjzoJzQ233Q338NZtN1u7oF98g1iaFhy7NzXbLUymhKajlvIcorv2lhbwA2o4I471IfLDI1wUdpH0jNhj25wn+Mo3quXNFpe7slR3pTHuzp0oPPFWJSybZ8ixg/wVSlsrfXn2aFruNUisfVTv5PXS7INJIqgj65Pz50UXjIGTVOgcYMlrUZt9ml1wSrjRdQb19GBCbngD2yNUL6yE3jIujgsFENfj4ZHwjzghiwiaDguz3uAIYfj7PfY7L6u2QqvUNGgLR0TnYNZ1d7rqCvCWqUTtbDjtGUeu1NqczL5Oee/DqzHcmmcvHzc0qC3mEReBwIqMAeS37YobDzwPk5Y8MNpkohxxwbxM/58jfuE5s0d2Vn7+iQu2xhvCtwD9LwttRxB9H9O84wKw6W8ZWbRPLMM7wfUJJpyY7WN3TEoXXo8a78PHEF7WoLExJ75PNnCQG7aOS6XajYhJvdAn30CviPkGs3CmXPInkAGKlW0XvtFggaKRu98N73Vyagw4R8jI0Y7g27v1cMYeu9N/eYj+lEjfgbjPLmDDHOMymF3DLxKB9CP0k0qHurgWXT0Lx/zai02nePT9I7Yd7AmGdtCOMrftY296yaL8gLeJcuxLn6yIwiKZj7XB0eOTV5cDwQV6LT4EPWJuGbYofhqKjG3Hw7VKIh1sfIlpLedKnvKS8/W9SmsXYCW3gUg4HLoQ2A+h+UPLbwEP9glfxeIZnJbHDMMTUC1lPDDhn23X/7goLOosc6NQXoJGy0/L8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199015)(4326008)(8936002)(54906003)(6916009)(76116006)(66946007)(66556008)(66476007)(66446008)(26005)(91956017)(8676002)(5660300002)(64756008)(41300700001)(6512007)(9686003)(6506007)(186003)(82960400001)(38070700005)(33716001)(38100700002)(122000001)(15650500001)(44832011)(316002)(1076003)(2906002)(86362001)(83380400001)(478600001)(966005)(6486002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0YzYptnFt8W/6wpwWA/0J7jts8x7kz5tJagkVhqw3D/WuFW8n/3QG2BbVIEt?=
 =?us-ascii?Q?/bP4aGgJq7I4ZRVWjokfVhNyWRPMkGMVh8rtQO6mXIzSSJ38NXZXFMWs8kDs?=
 =?us-ascii?Q?NDYIY6w31RUcQ0Lq5WoLxmodg62LIuhNsoaZv5F5TyrFy2yv69pxI14IR+Sr?=
 =?us-ascii?Q?LuBOagGdDOrW2L7e9tfGlVdtbIFL9WYwWLa+616kV7UV/guz0kmNb3CHJ8PT?=
 =?us-ascii?Q?A8K8oJiQMf0oW/RbIDzohY1LRnxy/sSx7T8bbsZzJINEB3dzsBAyGERU4Egn?=
 =?us-ascii?Q?VqQwcBdYDUeA4kcIxs8ChMtmdya/ZzMAawH7nIgbtftm6XKutVpSi7DjRRgW?=
 =?us-ascii?Q?t4BwWkAzKHFTZ4QXIZBZLM92rr/+lrBqLoObXkuQ4RiEvg7Mq1C7gUlbBL/c?=
 =?us-ascii?Q?VwUOWndFwzT6NkjviAHqCPwqo1YsoG1JP574tED00XrrtbyiC0bgq/tH9pG+?=
 =?us-ascii?Q?S2khw5evH805Ykl2sPwsQfivu30y/yehy+ZfbDiiSJt5kkMbv2KwRk5ifM/1?=
 =?us-ascii?Q?87c4ESSSNeCAzZSSdfKS9EZJhoKQuBKKGkzkr84zNxJi6ZnzyfWEih8fVTs6?=
 =?us-ascii?Q?Z4GJcNDT+Yzr8sl0Squp3iHCGsQCpyXh24Qi5acxzymL7PyqmPSeR8mW+cO/?=
 =?us-ascii?Q?LU43pnCDJw2ISyKSdhySVVPRTw5xPXm6IyPJbr6R0o34zVF1wOTKkd1NM8JB?=
 =?us-ascii?Q?M4nusux55pM+y3jzRbqqejSYBs37wgcT8iiz4jqXkWw+5HceA3C6th1K/9XC?=
 =?us-ascii?Q?urXz4dEvaxsbtdVXd6yo6xrrGz1i1upHfaNSVpwfUqq2gyCIk1BzZ1eH8fyA?=
 =?us-ascii?Q?URmx1KSPoAdU6iwXjXNfwwkHkI0rVF2rabT3Eqzm7oxINbvXB9sWsf1nuHTN?=
 =?us-ascii?Q?E9i2HYLgMaIWGCvfKXP2FZEOLPiRkihofQ0gzThc3eOjRWE3rAWtfftfu78X?=
 =?us-ascii?Q?gADrbsZIeu/HDH89JUhTVBOpt2NxrFNkyz/PG4caSPyfQyG2Lqg1e/BQsIgK?=
 =?us-ascii?Q?uwa/wHB9RKFzwo888GZBAYOLtRT4X6knKUVeMWN/aCEnhEVXaNmu6eHT4V/6?=
 =?us-ascii?Q?TqPYJ2jkQwPb2i+uHqeHm8h5TSnhhFb06rlpkpV1cLg8yqItdVpsl/tV4Wmx?=
 =?us-ascii?Q?3E6fyp7DUT45aVlb5b1AYA5uj3258U8tHUDIhxVjAEYn2nYZxOib/+mixQdo?=
 =?us-ascii?Q?g8WPFRh7Kk2OcyiS1HJ6lvkh2E9n88Qp6cbnrUXVf6xsqKhy4YJqGcSKyj7B?=
 =?us-ascii?Q?/m0zmAmdAekT1x65JN+mAdCY5vGqAH9xLupSmIEFEKtc3cfhcbLrcUQHSqmy?=
 =?us-ascii?Q?NSLc0yvJ0Ogx2br1YdqBx9Slh6sqAiVvMM58kFQzSYOvVRvlaGPcs80lGws+?=
 =?us-ascii?Q?6lXotR4vTqISB9+cDAT/tcbYLnnYOFmA/HaRrZHXT9fkFtU2tH3zyvg9izWn?=
 =?us-ascii?Q?W1U+iDxhRguRfHZLGBkZy1Db0wemxOteYHA3RjAQ//TiiTKqqpkifz7zE31K?=
 =?us-ascii?Q?VlTycuuOLAOVzGHrsWw7O/RyzGk71FX9VSFdSJDI5oMCu7TxMI6O7URs2xy/?=
 =?us-ascii?Q?YBC5nGR0Unns0siSVG77ZHN/amo6oEokyQ/bE7qSYiLZkKZbs4QvLtzfDU4q?=
 =?us-ascii?Q?Rawv621uE5/GI1dk6m3u+WQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01B17085A8208742AD1F7A39C69BCF57@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ad5da6-e825-4977-ca0f-08dab633873e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 02:49:25.4335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfHRYEWKob3sxgTP9PU41vBJp9Z+GEp0P97cRwhvsciPMrwQijwL8KjEc5kraXHIPPrmXen5hQWyyL78ISfSJtW5TwSedvYhwZb9DLeAPHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7558
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 24, 2022 / 14:13, Yi Zhang wrote:
> This commit alo updated nvme/012 nvme/013 nvme/035 to pass the size

Let's note why we do this. How about this descprtion?

  Change fio I/O size of nvme/012,013,035 from 950m to 900m, since recent
  change increased the xfs log size and it caused fio failure with I/O
  size 950m.

  Also add size parameter to _run_fio_verify_io. This allows to move the
  fio I/O size definition from common/xfs to the test case, so that device
  size and fio I/O size are both defined at single place.

I think the commit title needs to reflect the motivations above, like:

  nvme/012,013,035: change fio I/O size and move size definition place

> parameter to _xfs_run_fio_verify_io
>=20
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

How about to add "Link:" tag to refer our discussion?

  Link: https://lore.kernel.org/linux-block/20221019051244.810755-1-yi.zhan=
g@redhat.com/


> ---
>  common/xfs     | 3 ++-
>  tests/nvme/012 | 2 +-
>  tests/nvme/013 | 2 +-
>  tests/nvme/035 | 9 ++++++++-
>  4 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/common/xfs b/common/xfs
> index 846a5ef..2c5d961 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -23,10 +23,11 @@ _xfs_mkfs_and_mount() {
>  _xfs_run_fio_verify_io() {
>  	local mount_dir=3D"/mnt/blktests"
>  	local bdev=3D$1
> +	local sz=3D$2
> =20
>  	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
> =20
> -	_run_fio_verify_io --size=3D950m --directory=3D"${mount_dir}/"
> +	_run_fio_verify_io --size=3D"$sz" --directory=3D"${mount_dir}/"
> =20
>  	umount "${mount_dir}" >> "${FULL}" 2>&1
>  	rm -fr "${mount_dir}"
> diff --git a/tests/nvme/012 b/tests/nvme/012
> index c9d2438..e60082c 100755
> --- a/tests/nvme/012
> +++ b/tests/nvme/012
> @@ -44,7 +44,7 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
> =20
> -	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
> +	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
> =20
>  	_nvme_disconnect_subsys "${subsys_name}"
> =20
> diff --git a/tests/nvme/013 b/tests/nvme/013
> index 265b696..9d60a7d 100755
> --- a/tests/nvme/013
> +++ b/tests/nvme/013
> @@ -41,7 +41,7 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
> =20
> -	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
> +	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
> =20
>  	_nvme_disconnect_subsys "${subsys_name}"
> =20
> diff --git a/tests/nvme/035 b/tests/nvme/035
> index ee78a75..31de0d1 100755
> --- a/tests/nvme/035
> +++ b/tests/nvme/035
> @@ -21,14 +21,21 @@ test_device() {
>  	local ctrldev
>  	local nsdev
>  	local port
> +	local test_dev_sz
> =20
>  	echo "Running ${TEST_NAME}"
> =20
>  	_setup_nvmet
>  	port=3D$(_nvmet_passthru_target_setup "${subsys}")
>  	nsdev=3D$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
> +	test_dev_sz=3D$(_get_test_dev_size_mb)
> =20
> -	_xfs_run_fio_verify_io "${nsdev}"
> +	if (( "$test_dev_sz" < 1024 )); then
> +		echo "Test dev: $TEST_DEV should at leat 1024m"
> +		return 1
> +
> +	fi

As I commented on the second patch, I suggest to move this device size chec=
k
part to the second patch.

Other changes looks good tome.

> +	_xfs_run_fio_verify_io "${nsdev}" "900m"
> =20
>  	_nvme_disconnect_subsys "${subsys}"
>  	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
> --=20
> 2.34.1
>=20

--=20
Shin'ichiro Kawasaki=
