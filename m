Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30EBC433EF
	for <linux-block@archiver.kernel.org>; Fri, 20 May 2022 09:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbiETJhX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 May 2022 05:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbiETJhV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 May 2022 05:37:21 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814073819D
        for <linux-block@vger.kernel.org>; Fri, 20 May 2022 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653039440; x=1684575440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=44AYEkHwwvqPKNwUh0h18QP8POBKNd/3hPueT0JllVE=;
  b=QgYuZkUVFYlg+POdpFM/Fm6wsSRCNZpvCw1rPWwd13fBLTU5zOmbqKhN
   DtAK/C5oykudcEIfKQ4q2V+WP6uusukJhXTC3lW0wtMb4BNn+SRHyjkr2
   N9XRXc9hCIFVoCQMb7Jxdk4i7iYEcGp0CurK2IbJS7mJ+gWkKAwKXlhhT
   CzIIuJeu7vrkgQ3T1ynTs1XFTM8wL2eJZ33APSwGUbytj/sLmKC990IaX
   eGA4bxG+KPzr1kFyPEWp+HrHvMNUhoRt0tg33YUqWg0PdTYy0cTXKT4Pr
   klRLvMX+ukfgY4Q+8CWxINNN8Ivz11qot8zyiqY66RZmArapOAmEuJ31E
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,238,1647273600"; 
   d="scan'208";a="305116983"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 17:37:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=megLEazfICCNww2sjKiQgBA2ScCZmC3UP8QmqJZq8FYuPmUnUf+jdApbkKrNiHBmfzA0AywhlqtCdsJX+NG0Za7khIJlzHboWk43iuLgXKbnHfpGMtAWcKpRxipQ98eBo7io7dFbtG+y6OGg3//Fx4iHIik+7Ajim1+nD9QyI9HZT6NhO13QjZx+3inX5SDX3U/We/7kEkFFOQhVcaesmbGC3G9jiEX4B5E2p6pdxwdXAPqwhdIJxX+RFNWr3mK/C4Kad9JwTqVYMkgknnjOwlz2uwkMG5NUPnxvPlhJLToZtOAZVkm/TGE+RSWv6MMDQXEclzXSS3y+TIEw23NY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNvEfXRwA5PhYSu/IjmPPeDA7FppmX1kJI023sy06IY=;
 b=Oi6TnsRHE81PzXyFYCkOZ8endRQc/8kopeNDS3722ZcRIeAheziNPs4rJky8AWuCO9KCFLhnvXewjiXL6wu8zKAsIpRcFLib0beBPN4B8HC6OCbgRARi9Yuk60pAoXr6sG0oepWYU82L838U4dsbFJg+XJ3yKoc+YjRVOKidVM9ZL56/WOUmDd+PZz6g5tETuaPwd9RGLYK2/ynHCW9nFti/PvMfJdGF26xB3v1BIfkX6a/RtJPYOzd34k/MSx1LiMuo00yUiF1ACr25yfyht+hfSwfuefXgA7W+oESWZxkIk2KFk4Rv2VnpQ7/T0tWAwRwpVEM+y7j6xGrhDxenig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNvEfXRwA5PhYSu/IjmPPeDA7FppmX1kJI023sy06IY=;
 b=NMkYi4szmxn9il40OCCSgN/cDMUo+CxVMuGAj2iBlblFEW1h45Y4BoPXIkY7TZinGZeEYhVxBHv8uoOO4a63joBKE96wGx/NOF2tWSujOq89WhQNssPFxEA2DVnMxYMlG15OuJaTcDo0vhZxX0waHEyrPhAV3DIhx25/kzhtazY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CY4PR04MB3718.namprd04.prod.outlook.com (2603:10b6:903:e8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Fri, 20 May 2022 09:37:18 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 09:37:18 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] nvmeof-mp/001: Set expected count properly
Thread-Topic: [PATCH blktests] nvmeof-mp/001: Set expected count properly
Thread-Index: AQHYbC0yyY3KuFA5xk+PPTPW3T8YDA==
Date:   Fri, 20 May 2022 09:37:18 +0000
Message-ID: <20220520093717.gecy5qngf6l3xpm3@shindev>
References: <20220518034443.46803-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220518034443.46803-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3464a6c-5955-4ed3-e8aa-08da3a4454f2
x-ms-traffictypediagnostic: CY4PR04MB3718:EE_
x-microsoft-antispam-prvs: <CY4PR04MB371805CBF916ACBF7BB3882EEDD39@CY4PR04MB3718.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zysbvxqVKl3JXTAhTceg7FYHoiBTlqxtiwR0I0SKNyIOaYDQQ3Bs7J0NEQy79xWAoDRUnH07qdLRAcTN2ZLtP69fpp0ApVFXSqIdo+nDKbeucG0Gp62RQlq/28CAuLiPaC+gP41fNiAwIcbX8vR69jpp6hQYFEfWo1MVuQzs7lTK10pB7Mm2l7slLCvfZVZtLt7ZhnTZmmyI7wCssIYjS5C87hegZB2CpVDzjULdC0modg4BKziGoCu5WnaNtGlVA2n7FgmB0Vrt78JRjxLXUp3AVKYSFQyvzUjBhHdnt1uiEBN8IqhSEPbUgeN9WdnE4UsYk1+Ms/CKe4qrVDlIWxMJPsGe9NwKFz8V0pSP/XWtlEdJYLFV2hwS4vd8xiSqriYxkD7JST+gCtW8toZ1oWAr7ekq4tx5kPcQDv/K+Rh8SlquFOsRONu/LA4XRKmhNxwlDhB/xDBYc3VrhqHKK7V61axWlK3dp3urhXA3EDpa3MpA1plN+IX2IHDcJ1fPMkOmEEUiAiHFZpwr3sT5jFZPid00rB9J9FPGDojqSaXpa2k0GGahsrSksVv1Fqm0hsh73uPKfA2k9gfA7sg/ZZ+A7ZA4p3cpgs7PVTCKPBb1cZczj5jK9C9DZSGRkfM4ZeEn48M5vGguRCFSLaqAU1yIkT8aP9Lvb9LcmjvA6RSdIa8Wb7CO+IPzD6NGeu7T+Ju1S8EA+hMEGQ4XHxnhxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(33716001)(508600001)(6486002)(83380400001)(71200400001)(8936002)(316002)(54906003)(6916009)(44832011)(26005)(38070700005)(38100700002)(186003)(1076003)(4326008)(66556008)(122000001)(8676002)(91956017)(66946007)(76116006)(6506007)(5660300002)(6512007)(9686003)(2906002)(82960400001)(64756008)(86362001)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f+P1ndxXwvgU/7h7GeF++ASwn6umLhk6tTXEWGgH4A9ueSaSDgzKnLb8LVx3?=
 =?us-ascii?Q?mc/q39mZ4q4mXVO8QLKksqNT1OFRirDJLuyec1eUu5IrG54I7vbCcv+LJ+by?=
 =?us-ascii?Q?OVyZmJZViGbftQA3IuW6NBb3jGPKst5jmRjf6WiHriusJ+t+LaTywfmDm6j8?=
 =?us-ascii?Q?7TPN+N18SkNQpr8QGIok5tXtsALtc1R3h30+/kyoTrci8ITlWhorSsQqZ/Hd?=
 =?us-ascii?Q?HvDyqdFkBLMDNWVe6yBDRsgW5GDKh/kN6wmnG6er3rzC8Tw00l6qYY6A3txw?=
 =?us-ascii?Q?OioN3a5/0ac5vCVpbYefgeUErT7S71impTopUxU6g59tj0IobtaH1fTd1KCz?=
 =?us-ascii?Q?X4QvIO55wcrmO//aK37biuYemZMDKf4+jyySxD4EnvVmk2kzXZ3/at9mMdHH?=
 =?us-ascii?Q?mKOpV6amJCYVLJ3Puqt0J3oEMVi+ypFeoRPYyLUioJe0OEIxG4sJfV3VbWxJ?=
 =?us-ascii?Q?W0fULOtE1xXhq/Vhuf7IQESEVqM5K+qFfZ688G9aDm9Z+UVGJY1ChizavCh5?=
 =?us-ascii?Q?gGmQ6jv9osC59hcpxRChxOSWb0I6oyXRu3fHtNywhsuOVDOQStjOKj/k/dIo?=
 =?us-ascii?Q?x51lpRQbIH0vZdBLVI57jZ16/5nqnlEIP6QK0hwRw8ZOQVDRHMWzUJCKAY3o?=
 =?us-ascii?Q?FUWM0C0Y92Pdn6RvA23S+gIR1Jh3TE8LbWQDJRmjJsdcJfxqprNK2Bd+X68o?=
 =?us-ascii?Q?pH58oA7gE9ZAjIm16Sx1fTqFHkb83Bt7wOmR1017DwIo5tD5mrkQMFrp/ynu?=
 =?us-ascii?Q?l+nDRaFIWVBH5KjD+uBCWSk5ebVyXHNPi1SVVEttG1dCdkSY1cOx4d0YW0eU?=
 =?us-ascii?Q?VyzIxsi7dqBNfNaeuwdF8Zscoeing7neN7ZF5pfpI8NmJnsDYKjUhB1Irt0C?=
 =?us-ascii?Q?5/7Q7K5bPMhJDcIREVOWzxhXZy2lgV09/TTlP66laeo63QtV83H2G4JYM1r3?=
 =?us-ascii?Q?lZqTq3H8wMwnEugMtO/rvicm8YkoU4cnTDfWVouRz3Yp4sR5rJfHBD8wx/4q?=
 =?us-ascii?Q?wz4CLkxk9aWQJHG7s4W76Nl4RJmC3Jy88D4sOZ1Tyt2LWxZ6/Poy67o9yXXU?=
 =?us-ascii?Q?KLeUB0NCsFzKBJ5l7ipjz/uK7H1PDjUwv49XNQrspjV/JCXuCy0vkPdhPEHB?=
 =?us-ascii?Q?S39sPY3//KcUSlrrNztmFUuT7qE8bYlfJiHiAkLzF+G3/If+o7i21qSIc4ZS?=
 =?us-ascii?Q?2xZmV5YEVmP8gICA3y2RIOMQzXKYTYk0HsmDVy1niFa252jf95lxXz/NbsFV?=
 =?us-ascii?Q?rn7cX1jUgnFEJWjKIOOTUuN9uVOV3w23rE9Cy9/RbTQ+CgiSJ+fucWjAaicl?=
 =?us-ascii?Q?ZcSKe6h5jiMW9o4YF/u+DeV4jPGaXbVcwtIYiRkfrmxnzciruJ8D8Cej40lF?=
 =?us-ascii?Q?7RT18LVuNRZyrqKZ9UgS8z5B0s9iUHkrrtxGB0uxBrBE2VysIJtDN7iJYaGF?=
 =?us-ascii?Q?hUwc/3aBSoo3BuIlP1GBqPVwHjtaUQJbL0xmuHfBReOMzR6ZRntCYBV0rjof?=
 =?us-ascii?Q?xFtBtl2FZl1V4ikA75VeKpFCAFX7kuceU8qt3LZGicJALRrLxTJJvnwiMmRV?=
 =?us-ascii?Q?WBnfDW9l5aLx4v7XIHfSpPnJywORVhpEUnpFYmDaWLZFSC72ZvFnUcVHEQPv?=
 =?us-ascii?Q?9OsmD9xAUUWTMQJwFUoCF80xed8Wiw1/t0gKWgdVdrQ2sP9gqy0aYsRq8W2d?=
 =?us-ascii?Q?xK/lFRI62qv5gnOnhtcD0cBnrTwUDnYZUjGdw9xHrkf/DMYcbkAS63iharkB?=
 =?us-ascii?Q?TTbFkd7IoCWmR7aLCzasT6dxJNZq7KkZnhVo/ZyPPku4UzzIBcRp?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <384ABE73F3C462498BC0C02A4C312F91@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3464a6c-5955-4ed3-e8aa-08da3a4454f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 09:37:18.3582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCMZIVHwXh7H2hnTn8oMnhvvNq7Q3ltz7NN3ba3p8FRHnGHqnGnU9ZqynGFw/R2Lkhql2dRkDWiBr/Wb8x/hd+gWNBRXUndjn1X4Q0g36vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB3718
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 18, 2022 / 11:44, Xiao Yang wrote:
> The number of block devices will increase according
> to the number of RDMA-capable NICs.
> For example, nvmeof-mp/001 with two RDMA-capable NICs
> got the following error:
> -------------------------------------
>     Configured NVMe target driver
>     -count_devices(): 1 <> 1
>     +count_devices(): 2 <> 1
>     Passed
> -------------------------------------
>=20
> Set expected count properly by calculating the number
> of RDMA-capable NICs.
>=20
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  tests/nvmeof-mp/001     | 7 +++++--
>  tests/nvmeof-mp/001.out | 1 -
>  2 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/nvmeof-mp/001 b/tests/nvmeof-mp/001
> index f3e6394..82cb298 100755
> --- a/tests/nvmeof-mp/001
> +++ b/tests/nvmeof-mp/001
> @@ -18,7 +18,11 @@ count_devices() {
>  }
> =20
>  wait_for_devices() {
> -	local expected=3D1 i devices
> +	local expected=3D0 i devices
> +
> +	for i in $(rdma_network_interfaces); do
> +		((expected++))
> +	done
> =20
>  	use_blk_mq y || return $?
>  	for ((i=3D0;i<100;i++)); do
> @@ -27,7 +31,6 @@ wait_for_devices() {
>  		sleep .1
>  	done
>  	echo "count_devices(): $devices <> $expected" >>"$FULL"
> -	echo "count_devices(): $devices <> $expected"
>  	[ "$devices" -ge $expected ]

The change looks good for me other than a nit: after applying this patch,
shellcheck complains:

$ make check
shellcheck -x -e SC2119 -f gcc check new common/* \
        tests/*/rc tests/*/[0-9]*[0-9]
tests/nvmeof-mp/001:30:20: note: Double quote to prevent globbing and word =
splitting. [SC2086]
tests/nvmeof-mp/001:34:19: note: Double quote to prevent globbing and word =
splitting. [SC2086]

As the commit changes value of the variable $expected, its references need
double quotes:

diff --git a/tests/nvmeof-mp/001 b/tests/nvmeof-mp/001
index 82cb298..70a4455 100755
--- a/tests/nvmeof-mp/001
+++ b/tests/nvmeof-mp/001
@@ -27,11 +27,11 @@ wait_for_devices() {
        use_blk_mq y || return $?
        for ((i=3D0;i<100;i++)); do
                devices=3D$(count_devices)
-               [ "$devices" -ge $expected ] && break
+               [ "$devices" -ge "$expected" ] && break
                sleep .1
        done
        echo "count_devices(): $devices <> $expected" >>"$FULL"
-       [ "$devices" -ge $expected ]
+       [ "$devices" -ge "$expected" ]
 }

 test() {

--=20
Best Regards,
Shin'ichiro Kawasaki=
