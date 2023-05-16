Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F1FC7EE24
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 08:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjEPIre (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 04:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjEPIr2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 04:47:28 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8448819BD
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 01:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684226845; x=1715762845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lRytFakBIHL2blLfUds1rjDmNx27qkVU1yRnG0MdKK8=;
  b=T8XGTMGUWa7dx4U/6NcF941OZMVzgtPIVstzGtXsa/Ncl2X+jqoUvXFK
   x1gYcL32bqEc4bY2ZDqpA7D2TYJ4Gw7DGII4rwpRop9jIh7WflZMVYGuu
   0SLy/0zX4EE/ASJ3K75ysFaDA1qOzNx/N3vLdxnOovSS+P2tyRXz0M+to
   rHGBtej+U18qwLn6wH11eP6RHpUrs6GMHKj7suCkjZ5+cGM+QlB0kNWJ4
   fqgqNo+qNaVAEs6X6I41AS8M5jU0ov9Z4RPtGPU8nZx6o1a/S5zBoztqU
   dzlOmy/BL+AcEMjswJTz/rDO303P6yHm+kbypUBrRljhJDV62AiS2CzXp
   A==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677513600"; 
   d="scan'208";a="335347605"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2023 16:47:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8SBTNhtHuezz5FBv/ZLwCC08xVNqKf4L0ikl6QafvgEdSWXNI8nDgK7ImHjZlIt7P/HNfIg9Q2SrHO1KuJ0LdDd+mF1hXZThqM+BeRcWT5JcQ9B7lQCDYn6Kg3bP87TBRrsZlPfcJzgQYKKK+LLMm6sQYzP7OFk5pFJ26WPuqY9gay8G10V9tRXDQONbfj7HPx0XzSwG59KX63UMZdBIA3RY/eSpqcmhRuZ7yfsGCmv4zBiuqsF84yOSuZLXBqVedXVClMN8V56qibcMwhcGNTSpv3OMWT+fH91gCW/uulVZiZ08KnKOLPedKlHRrNnL+K0THjxVI9rWY3OVVPIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGmX2eyeo5K+GRq1uMJKtUrcwjdo8VxZginvJf360vU=;
 b=NAkX1tBka698Z5mpKNF342PUN+DoASv62QZyQhVZ2Y4JaWzj4nQOQAGABgQIgqfxB/35FDfip/JKtAHrsFLhY+Rl1TCBz6A2rc22k3j8frO+vLsw5odd637vJStg2FqkFRd+sndOLAgfFGZioNBzqrbv9A/Xvm/NJTI4Q+2TBGIqgPR5K313xJzC56MKYpOZxyCq4TNO7JVO2J6wSUwtnMEpR2aFX40QFwjsKyXAx1VYUW9jcT2MyZHcfiOpD8ErlUcQIbXVLmEQuimf/vp+OFwcqtJG1pmKAvKwSQ3M3/Leog5JDtCOi1abpKnsAKm3ltVqAKfXRCSi8Tl6PuSBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGmX2eyeo5K+GRq1uMJKtUrcwjdo8VxZginvJf360vU=;
 b=z23raeoLkFAL8/KOBqGobFXtIbNkXvx2hvEpftiSGbu2WYJQyqafNcngUa9FAYoGzeXJSGvXTCJwLoKLUj4GXR7r4nQ711eSkSgOe50ME5tXpayZR0tqQy/tSUTa9jVyqXYw+7UGpGq+Bs7v8WYD1Zq/potSrmyHdiGy65wwP7c=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN0PR04MB8078.namprd04.prod.outlook.com (2603:10b6:408:15d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 08:47:22 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 08:47:22 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 blktests 2/2] tests: Add ublk tests
Thread-Topic: [PATCH V2 blktests 2/2] tests: Add ublk tests
Thread-Index: AQHZfwGvsYW5q3GqQkSpPwZFpAx2qq9cqAqA
Date:   Tue, 16 May 2023 08:47:21 +0000
Message-ID: <ktb4tdaag6xr7p6bu5dfdgpzanrrg4lnunf33yby5mklhe45eb@kxuwcvhhyjpb>
References: <20230505032808.356768-1-ZiyangZhang@linux.alibaba.com>
 <20230505032808.356768-3-ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230505032808.356768-3-ZiyangZhang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN0PR04MB8078:EE_
x-ms-office365-filtering-correlation-id: a93efed8-2068-43eb-62f2-08db55ea2a19
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lGtnO04Kw9FJPq2y//c1K1QndHVv4wB5XvedRyzJTPvNr1x3oTJOxwiMTzIkXOyt2fogHdblGpB7HvhOQdRxYKSYr7KGa6Y9VwC7dfotzvLZD7FdzuvPy9Ae1a8jGqNwcLtJxauRFbOj6FiHRp56KYcaYBZp8dQGpUQxcBmilgGhdF/50pLrfp/eUxIxQmpOI/V8GqwbAlrf/HK8he6CP0qdDNXF8CaWVIjMQKRUbciAjZazi+x7j3gK5dhh7sWHY5x6cjqfoKIeeVUmjZaNat25ydDvV99oB9Op7eQrqoOX3fYQ+HnFnd1uZTWk6msXiIaNI0qZ0/YyC3YhhpezOtZ0YrCGpFhkwfrUl9KzrqmcPxTFiU17ydUDPGTgtDr4IdXPLLrp6fPJmbd3JbNVG0ERfPiIu0ZV7uhe0Hfqd6vwRrFa6pVgpPa/Er5MVv/Jk0rHp53yFBKTsprNLGBSm0liBbMVGFsKa6qDl5mtCHxr3E+58eTf1RFF46q7d81e6e6Mm7ZN13rrbzRlp6WXe18FCPGXD5vvDWLEsiEiK+omno5AMclswxYgABgZxB01pn4JXvdZ8/HDR3K8/5nTchGe2A6cX3xks/Y8mA7gLtSWtV/BdpYgm6xN7IeH6fVqChV8PVGzn45ndcko/loaeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(71200400001)(6486002)(83380400001)(9686003)(26005)(6512007)(6506007)(186003)(38070700005)(33716001)(54906003)(122000001)(82960400001)(38100700002)(5660300002)(86362001)(41300700001)(91956017)(76116006)(66946007)(316002)(4326008)(6916009)(64756008)(66446008)(8676002)(66556008)(66476007)(8936002)(44832011)(30864003)(478600001)(2906002)(27256005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+yIeazucug5a9AyRUhLyggIuOXKWlx2knQoLgy/7npKib1179UefEnR7TKoO?=
 =?us-ascii?Q?jz8/VHd9p1zcHGg5dvU+zHBjRltWKLT2RIIkwPIwt3Fv31pepbhH/Coi6wb2?=
 =?us-ascii?Q?bFIbpdjdK2HumCGW3mFIDlQ59z7SalVBfPHdK4D7Du65aulDBSbxSX3tLrU6?=
 =?us-ascii?Q?m3RW58rCsOpEPux2Se2gNKKQbN+xe816X1IWLQydTJkaEY1y3sUuQ6h/Iqpj?=
 =?us-ascii?Q?Lp6d6k3xKEgbwmVBuKSDcm+MCDRdE4Et6hJLiyiYXOyOpxGXWAik/q8OdZ66?=
 =?us-ascii?Q?fpN8nAJ47IyVUm6/0e7l/bztITg+KHHFAKcLSJ8J69JYeiFnpYxu1AHi6z8e?=
 =?us-ascii?Q?1W1Cf3lMvUnR6ApgHiHL+apr7jN2HZbIUZY2N62c0D62LDJVmB1+xTH98Y8j?=
 =?us-ascii?Q?G2j/DunHhWCnwA/AplYsNi8wOvFN6LwBGqVz36+KPsdQAMiLiE+hC7zUgjJA?=
 =?us-ascii?Q?V3PFoNnLeVwGrtR810o743jfcR1jt/PeqWps4Zb0UUZK9HYirwPOKWYY/9fI?=
 =?us-ascii?Q?t7pUzh8gQdqvW9ZtwbEo9fPTh9rVjIPBKj8PIq9N/HiiGhB8C1o9D6GxXSmn?=
 =?us-ascii?Q?ybcwG9kI85NR+yIWOVQeEMBaz7fc8yanThdhS9nLVroZWQHUMZDAbnaUTpTk?=
 =?us-ascii?Q?ohfSG/8L/VmeHbY6hbfhdXh7Q5OyzGctFrD8/XYaZiAd5nz18JRnGFG6i5hk?=
 =?us-ascii?Q?r1YtY/2IKtO25RqIqzwHRJ1TzsE7sDJmt49UCK6qo/6mi5PLErFBtV9W7W2b?=
 =?us-ascii?Q?/DIUe4vtHerRkMEZxAxiYFImA4FCtGr+FKQ4F1jLYIP4co3Dzb2MwrrEprzB?=
 =?us-ascii?Q?PSKhfPj0t7TttGFBVqOVvs/wsSx3uRlEesjwsfDnFjzAh0TdDBWHhc2CIhMH?=
 =?us-ascii?Q?29G5dhgDQ8fxxO7270SM5SnsPrqyZs8+KUoCII5vgu+ALqKaOkP742RBI+g5?=
 =?us-ascii?Q?2WBzL/1HzghCazKEfoS1suXsrypoJzHGfXkqdUOxdQdWchVOw1QqpdyycMS/?=
 =?us-ascii?Q?g8OFmiKt1xn2B7UdoIc/tW7mZ0NMXmflkB6qK0EBcHfma8qtmNCFNyPu4RW+?=
 =?us-ascii?Q?jg2On6n0aT1egtCpkFVX0K+18PldB7RPQVt3NXTH4qtwZE9JHeiyGBZDVzVS?=
 =?us-ascii?Q?5/1kbq0+FHaohsTSqSdVTUFI/BUxedFkDFyF6FPyK7B3cU8tYtQpSzomfHEb?=
 =?us-ascii?Q?H4Xwm7ju/7uiY544umPHNx0p6+JVKI+gqDdGgbKCKlAYZZBEuO+oQc8zTxCf?=
 =?us-ascii?Q?lit35VZA1FTvkoG4Rs3m5hQ4A5nKTMinxV0ZnB5dm9KeEyIIx/h3pvXVGVXh?=
 =?us-ascii?Q?PmCwXMK4+u+AnQn5xl3H9feExI8ijb3YSclduVqzjWuRGalZ6LMTx492Zki5?=
 =?us-ascii?Q?WJ1/Pwjk8EWPJJyk2WvLmZSEowXTpvb2iBnzYhbLFXKO6W7yVIAnP+u3YHUe?=
 =?us-ascii?Q?ZrkdD2n0a01BxPWtzArCk3LNdmqQqahw7vIUJZTYTl/4Z4WZ8o9p5gRfZzWw?=
 =?us-ascii?Q?TjH5P+Bl744NDQE6uE7ydgQ8U/LfrFyaa/Sdmokr6UOYblhXc0Y/aAzJAqOF?=
 =?us-ascii?Q?LDPpTkk/bugmKb/C/w/qC0mjRKfzDXFC6Kw5ZSsL8Jxgt7Z6VL4EUm6h3Wxt?=
 =?us-ascii?Q?c5tZrTl0UOE4YCQee0GGI4E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBA7A73F3005A540A0C0EE5BDB5437B0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PzBp83izIO3SNECobx712Bk12OuO/dlzrJcVRtkmpSYngyCn8+s3Nc6imG89pUB6sb+Uqa+IKHelaE9+fL7wWthgcqKMNVFKPKaXUAcX7oTt4/e9cADTR3Pz7hw93aUzFXJpG1zXp0mVrWorRgPqHndCmd9c7ww3BURkMU6CEHDVLcLEjt4dgtSxE6d2oqyWQmTwNY8AAMyk2P+CsE+EkFQZgW2M7tQMU1/RujLS9q0N5YFOrvkFZRP3tPQFgjLLRFArEdvOS+otkKG0q3MhsaWNZKDDJtXeM1LZd+mG+3NsANS3XZqp4nIv7+KWF5ARliFjjZqqTrsohrY7l9a24IzKRSIvTSomLUcVcff+9FI0GncnMwMy6IMz7nn/mlUe4zqP8Gl6JDg2RJDoA6xnEESYZXxQH/sVC5KnT5zpV6kguC56AQcNaiTpGROYksj410pL4qr2rq8mX+qRj71NFiJjOP2x9obKiYWEQ+preOIUrLxOb1Srhte728pdfjwM10WglEkCQqr2YDp/AIQXUd8+pNNXTqchAmoHtO85+dYumtnPBW9EuRzJbujvdLhsd8DuvdPrVwCT8uE7fFu5bkyqofRxc2Bp9crdvahNDdoWbsUo2xvHkF03KQ9GfkM2672tWmDfFlyMEufLEEgYGx8D2ElDkfCwftO4H64eBmR2npdxqBT3/qe4jGywh3+HJujc14j5aZYqXcSXHB3VC1Ub2HjroSeCO8rBiP1t8IThrV6OH3rrYqCN6W66Xw3gAu6aJsL7EjbkKo8/BQtmIH1roqQp3qesqIigcMDky+CUl0k3++67F0Jhfl/VSauSRYQuhydtlaP0EvSOicURF4WzVoEcRUoKkFyDSXbIQug=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93efed8-2068-43eb-62f2-08db55ea2a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 08:47:21.9902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ONcgkzYJBNrTf+YBW/v0deBv0z5Hd3mZm52rIVgTuAbGn4IKqZGep0iwqNeJGte4YaYBzB+jai5OgtbvRaY/5DPh+iSV/jPZg7vNSKTZ48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8078
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 05, 2023 / 11:28, Ziyang Zhang wrote:
> It is very important to test ublk crash handling since the userspace
> part is not reliable. Especially we should test removing device, killing
> ublk daemons and user recovery feature.
>=20
> Add five new tests for ublk to cover these cases.
>=20
> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
> ---
>  common/ublk        | 10 +++++-
>  tests/ublk/001     | 48 +++++++++++++++++++++++++++
>  tests/ublk/001.out |  2 ++
>  tests/ublk/002     | 63 +++++++++++++++++++++++++++++++++++
>  tests/ublk/002.out |  2 ++
>  tests/ublk/003     | 48 +++++++++++++++++++++++++++
>  tests/ublk/003.out |  2 ++
>  tests/ublk/004     | 50 ++++++++++++++++++++++++++++
>  tests/ublk/004.out |  2 ++
>  tests/ublk/005     | 79 +++++++++++++++++++++++++++++++++++++++++++
>  tests/ublk/005.out |  2 ++
>  tests/ublk/006     | 83 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ublk/006.out |  2 ++
>  tests/ublk/rc      | 15 +++++++++
>  14 files changed, 407 insertions(+), 1 deletion(-)
>  create mode 100755 tests/ublk/001
>  create mode 100644 tests/ublk/001.out
>  create mode 100755 tests/ublk/002
>  create mode 100644 tests/ublk/002.out
>  create mode 100755 tests/ublk/003
>  create mode 100644 tests/ublk/003.out
>  create mode 100755 tests/ublk/004
>  create mode 100644 tests/ublk/004.out
>  create mode 100755 tests/ublk/005
>  create mode 100644 tests/ublk/005.out
>  create mode 100755 tests/ublk/006
>  create mode 100644 tests/ublk/006.out
>  create mode 100644 tests/ublk/rc
>=20
> diff --git a/common/ublk b/common/ublk
> index 932c534..7a951eb 100644
> --- a/common/ublk
> +++ b/common/ublk
> @@ -15,8 +15,16 @@ _remove_ublk_devices() {
>  	src/miniublk del -a
>  }
> =20
> +__get_ublk_dev_state() {

This will be the first function in blktests to have double underscores. Is =
there
any meaning of "__" ?  If not, single underscore will be enough. In blktest=
s,
helper functions in common/* or tests/*/rc have single underscore to indica=
te
that the functions are not in each test case.

> +	src/miniublk list -n "$1" | grep "state" | awk '{print $11}'
> +}
> +
> +__get_ublk_daemon_pid() {
> +	src/miniublk list -n "$1" | grep "pid" | awk '{print $7}'
> +}
> +
>  _init_ublk() {
> -	_remove_ublk_devices
> +	_remove_ublk_devices > /dev/null 2>&1
> =20
>  	modprobe -rq ublk_drv
>  	if ! modprobe ublk_drv; then
> diff --git a/tests/ublk/001 b/tests/ublk/001
> new file mode 100755
> index 0000000..36a43d7
> --- /dev/null
> +++ b/tests/ublk/001
> @@ -0,0 +1,48 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk delete
> +
> +. tests/ublk/rc
> +
> +DESCRIPTION=3D"test ublk delete"
> +
> +__run() {

Same comment about the double underscores.

> +	local type=3D$1
> +
> +	if [ "$type" =3D=3D "null" ]; then
> +		${ublk_prog} add -t null -n 0 > "$FULL" 2>&1
> +	else
> +		truncate -s 1G "$TMPDIR/img"
> +		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 > "$FULL" 2>&1
> +	fi
> +
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=3D/dev/ublkb0 --time_based --runtime=3D30 >=
> "$FULL" 2>&1 &

Nit: this line is a bit long, so it would be the better to fold it to two l=
ines
with a backslash.

> +	sleep 2
> +
> +	${ublk_prog} del -n 0 >> "$FULL" 2>&1
> +}
> +
> +test() {
> +	local ublk_prog=3D"src/miniublk"

The line above iss repeated all test cases. How about to set it in
tests/ublk/rc, like 'export UBLK_PROG=3D"src/miniublk"'?

> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	for type in "null" "loop"; do
> +		__run "$type"
> +	done
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/ublk/001.out b/tests/ublk/001.out
> new file mode 100644
> index 0000000..0d070b3
> --- /dev/null
> +++ b/tests/ublk/001.out
> @@ -0,0 +1,2 @@
> +Running ublk/001
> +Test complete
> diff --git a/tests/ublk/002 b/tests/ublk/002
> new file mode 100755
> index 0000000..e36589e
> --- /dev/null
> +++ b/tests/ublk/002
> @@ -0,0 +1,63 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk crash with delete after dead confirmation
> +
> +. tests/ublk/rc
> +
> +DESCRIPTION=3D"test ublk crash with delete after dead confirmation"
> +
> +__run() {
> +	local type=3D$1
> +
> +	if [ "$type" =3D=3D "null" ]; then
> +		${ublk_prog} add -t null -n 0 > "$FULL" 2>&1
> +	else
> +		truncate -s 1G "$TMPDIR/img"
> +		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 > "$FULL" 2>&1
> +	fi
> +
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=3D/dev/ublkb0 --time_based --runtime=3D30 >=
> "$FULL" 2>&1 &

Nit: long line

> +	sleep 2
> +
> +	kill -9 "$(__get_ublk_daemon_pid 0)"
> +	sleep 2
> +
> +	local secs=3D0
> +	local state=3D""
> +	while [ $secs -lt 20 ]; do
> +		state=3D"$(__get_ublk_dev_state 0)"
> +		[  "$state" =3D=3D "DEAD" ] && break

Nit: double spaces

> +		sleep 1
> +		(( secs++ ))
> +	done
> +
> +	state=3D"$(__get_ublk_dev_state 0)"
> +	[  "$state" !=3D "DEAD" ] && echo "device is $state after killing queue=
 daemon"

Nit: double spaces and long line

> +
> +	${ublk_prog} del -n 0 >> "$FULL" 2>&1
> +}
> +
> +test() {
> +	local ublk_prog=3D"src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	for type in "null" "loop"; do
> +		__run "$type"
> +	done
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/ublk/002.out b/tests/ublk/002.out
> new file mode 100644
> index 0000000..93039b7
> --- /dev/null
> +++ b/tests/ublk/002.out
> @@ -0,0 +1,2 @@
> +Running ublk/002
> +Test complete
> diff --git a/tests/ublk/003 b/tests/ublk/003
> new file mode 100755
> index 0000000..b256b09
> --- /dev/null
> +++ b/tests/ublk/003
> @@ -0,0 +1,48 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test mounting block device exported by ublk
> +
> +. tests/ublk/rc
> +
> +DESCRIPTION=3D"test mounting block device exported by ublk"
> +
> +test() {
> +	local ublk_prog=3D"src/miniublk"
> +	local ROOT_FSTYPE=3D"$(findmnt -l -o FSTYPE -n /)"

Oh, this test uses same filesystem as the root filesystem. This idea is
interesting, but it may have some drawbacks. Blktests users may run differe=
nt
filesystems, and may see different results. Inconsistent test condition and
inconsistent test results. And if the blktests user have minor filesystem f=
or
the root, it may results in the test case failure caused by the filesystem.=
 It
would be the better just use ext4 as loop/007 or nbd/003 do to make this te=
st
case more reliable

> +	local mnt=3D"$TMPDIR/mnt"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	truncate -s 1G "$TMPDIR/img"
> +	${ublk_prog} add -t loop -f  "$TMPDIR/img" -n 0 > "$FULL" 2>&1
> +
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
> +		echo "fail to list dev"
> +	fi
> +
> +	wipefs -a /dev/ublkb0 >> "$FULL" 2>&1
> +	mkfs.${ROOT_FSTYPE} /dev/ublkb0 >> "$FULL" 2>&1
> +	mkdir -p "$mnt"
> +	mount /dev/ublkb0 "$mnt" >> "$FULL" 2>&1
> +
> +	local UBLK_FSTYPE=3D"$(findmnt -l -o FSTYPE -n $mnt)"
> +	if [ "$UBLK_FSTYPE" !=3D "$ROOT_FSTYPE" ]; then
> +		echo "got $UBLK_FSTYPE, should be $ROOT_FSTYPE"
> +	fi
> +	umount "$mnt" > /dev/null 2>&1
> +
> +	${ublk_prog} del -n 0 >> "$FULL" 2>&1
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> +
> +
> diff --git a/tests/ublk/003.out b/tests/ublk/003.out
> new file mode 100644
> index 0000000..90a3bfa
> --- /dev/null
> +++ b/tests/ublk/003.out
> @@ -0,0 +1,2 @@
> +Running ublk/003
> +Test complete
> diff --git a/tests/ublk/004 b/tests/ublk/004
> new file mode 100755
> index 0000000..84e01d1
> --- /dev/null
> +++ b/tests/ublk/004
> @@ -0,0 +1,50 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk crash with delete just after daemon kill
> +
> +. tests/ublk/rc
> +
> +DESCRIPTION=3D"test ublk crash with delete just after daemon kill"
> +
> +__run() {
> +	local type=3D$1
> +
> +	if [ "$type" =3D=3D "null" ]; then
> +		${ublk_prog} add -t null -n 0 > "$FULL" 2>&1
> +	else
> +		truncate -s 1G "$TMPDIR/img"
> +		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 > "$FULL" 2>&1
> +	fi
> +
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=3D/dev/ublkb0 --time_based --runtime=3D30 >=
> "$FULL" 2>&1 &

Nit: long line

> +	sleep 2
> +
> +	kill -9 "$(__get_ublk_daemon_pid 0)"

I think it would be the better to wait for the pid, to ensure that the ublk
daemon process completed.

> +
> +	${ublk_prog} del -n 0 >> "$FULL" 2>&1
> +}
> +
> +test() {
> +	local ublk_prog=3D"src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	for type in "null" "loop"; do
> +		__run "$type"
> +	done
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/ublk/004.out b/tests/ublk/004.out
> new file mode 100644
> index 0000000..a92cd50
> --- /dev/null
> +++ b/tests/ublk/004.out
> @@ -0,0 +1,2 @@
> +Running ublk/004
> +Test complete
> diff --git a/tests/ublk/005 b/tests/ublk/005
> new file mode 100755
> index 0000000..f365fd6
> --- /dev/null
> +++ b/tests/ublk/005
> @@ -0,0 +1,79 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk recovery with one time daemon kill:
> +# (1)kill all ubq_deamon, (2)recover with new ubq_daemon,
> +# (3)delete dev
> +
> +. tests/ublk/rc
> +
> +DESCRIPTION=3D"test ublk recovery with one time daemon kill"
> +
> +__run() {
> +	local type=3D$1
> +
> +	if [ "$type" =3D=3D "null" ]; then
> +		${ublk_prog} add -t null -n 0 -r > "$FULL" 2>&1
> +	else
> +		truncate -s 1G "$TMPDIR/img"
> +		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 -r > "$FULL" 2>&1
> +	fi
> +
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=3D/dev/ublkb0 --time_based --runtime=3D30 >=
> "$FULL" 2>&1 &

Nit: long line

> +	sleep 2
> +
> +	kill -9 "$(__get_ublk_daemon_pid 0)"
> +	sleep 2
> +
> +	local secs=3D0
> +	local state=3D""
> +	while [ $secs -lt 20 ]; do
> +		state=3D"$(__get_ublk_dev_state 0)"
> +		[ "$state" =3D=3D "QUIESCED" ] && break
> +		sleep 1
> +		(( secs++ ))
> +	done
> +
> +	state=3D"$(__get_ublk_dev_state 0)"
> +	[ "$state" !=3D "QUIESCED" ] && echo "device is $state after killing qu=
eue daemon"

Nit: long line

> +
> +	if [ "$type" =3D=3D "null" ]; then
> +		${ublk_prog} recover -t null -n 0 >> "$FULL" 2>&1
> +	else
> +		${ublk_prog} recover -t loop -f "$TMPDIR/img" -n 0 >> "$FULL" 2>&1

Nit: long line

> +	fi
> +
> +	while [ $secs -lt 20 ]; do
> +		state=3D"$(__get_ublk_dev_state 0)"
> +		[ "$state" =3D=3D "LIVE" ] && break
> +		sleep 1
> +		(( secs++ ))
> +	done
> +	[ "$state" !=3D "LIVE" ] && echo "device is $state after recovery"
> +
> +	${ublk_prog} del -n 0 >> "$FULL" 2>&1
> +}
> +
> +test() {
> +	local ublk_prog=3D"src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	for type in "null" "loop"; do
> +		__run "$type"
> +	done
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/ublk/005.out b/tests/ublk/005.out
> new file mode 100644
> index 0000000..20d7b38
> --- /dev/null
> +++ b/tests/ublk/005.out
> @@ -0,0 +1,2 @@
> +Running ublk/005
> +Test complete
> diff --git a/tests/ublk/006 b/tests/ublk/006
> new file mode 100755
> index 0000000..0848939
> --- /dev/null
> +++ b/tests/ublk/006
> @@ -0,0 +1,83 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk recovery with two times daemon kill:
> +# (1)kill all ubq_deamon, (2)recover with new ubq_daemon,
> +# (3)kill all ubq_deamon, (4)delete dev
> +
> +. tests/ublk/rc
> +
> +DESCRIPTION=3D"test ublk recovery with two times daemon kill"
> +
> +__run() {
> +	local type=3D$1
> +
> +	if [ "$type" =3D=3D "null" ]; then
> +		${ublk_prog} add -t null -n 0 -r > "$FULL" 2>&1
> +	else
> +		truncate -s 1G "$TMPDIR/img"
> +		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 -r > "$FULL" 2>&1
> +	fi
> +
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=3D/dev/ublkb0 --time_based --runtime=3D30 >=
> "$FULL" 2>&1 &

Nit: long line

> +	sleep 2
> +
> +	kill -9 "$(__get_ublk_daemon_pid 0)"

Same comment as ublk/005. How about to have the helper function
"_kill_ublk_daemon" in tests/ublk/rc which does both kill and wait?

> +	sleep 2
> +
> +	local secs=3D0
> +	local state=3D""
> +	while [ $secs -lt 20 ]; do
> +		state=3D"$(__get_ublk_dev_state 0)"
> +		[ "$state" =3D=3D "QUIESCED" ] && break
> +		sleep 1
> +		(( secs++ ))
> +	done
> +
> +	state=3D"$(__get_ublk_dev_state 0)"
> +	[ "$state" !=3D "QUIESCED" ] && echo "device is $state after killing qu=
eue daemon"

Nit: long line

> +
> +	if [ "$type" =3D=3D "null" ]; then
> +		${ublk_prog} recover -t null -n 0 >> "$FULL" 2>&1
> +	else
> +		${ublk_prog} recover -t loop -f "$TMPDIR/img" -n 0 >> "$FULL" 2>&1

Nit: long line

> +	fi
> +
> +	secs=3D0
> +	while [ $secs -lt 20 ]; do
> +		state=3D"$(__get_ublk_dev_state 0)"
> +		[ "$state" =3D=3D "LIVE" ] && break
> +		sleep 1
> +		(( secs++ ))
> +	done
> +	[ "$state" !=3D "LIVE" ] && echo "device is $state after recovery"
> +
> +	kill -9 "$(__get_ublk_daemon_pid 0)"
> +
> +	${ublk_prog} del -n 0 >> "$FULL" 2>&1
> +}
> +
> +test() {
> +	local ublk_prog=3D"src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	for type in "null" "loop"; do
> +		__run "$type"
> +	done
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> +
> diff --git a/tests/ublk/006.out b/tests/ublk/006.out
> new file mode 100644
> index 0000000..6d2a530
> --- /dev/null
> +++ b/tests/ublk/006.out
> @@ -0,0 +1,2 @@
> +Running ublk/006
> +Test complete
> diff --git a/tests/ublk/rc b/tests/ublk/rc
> new file mode 100644
> index 0000000..8cbc757
> --- /dev/null
> +++ b/tests/ublk/rc
> @@ -0,0 +1,15 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# ublk tests.
> +
> +. common/rc
> +. common/ublk
> +. common/fio
> +
> +group_requires() {
> +	_have_root
> +	_have_ublk
> +	_have_fio
> +}
> --=20
> 2.31.1
> =
