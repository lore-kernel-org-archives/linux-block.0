Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD31C433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 11:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiEaLRm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 07:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiEaLRl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 07:17:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D5964BFB
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653995857; x=1685531857;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X0wcQOoURccvBz5IJuIS9lS6jdm1kd5aVVb/RWaWI68=;
  b=jXcRIuzDntoj6udnCxxNCUXluJ6aBxKYTlpNnv7lQ4/RcQF+/MiH+rVm
   3pKbV7j1d0+tdH0tpb+kWyI8mKPNBgMxarowwF3YbNFpoaQ/LgQfy9aps
   YFfkKg7ZAzegqN19rvRvbUe3jI+vwETyN47iiaerCSx/WBcKFgW5reWz7
   VNhC2357gU1LT/WJEfBlSaZYe6+Tmgm0okA0OYJB4xqkFNetkAh5e+zuj
   1D2qVVe9sdF09ly1enN3RhWqMvv0A52RT9oOwfT8hg/zW4421nsvPwtX3
   zuoYs4Q/GQRKdBxgBuKsEkUIECqrzajTaxtAlvTdN57i1hzj0Dr6E02FL
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,265,1647273600"; 
   d="scan'208";a="206743351"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2022 19:17:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOOKS9ClLwgqpLU771A/AauMXTDyfrPMV+4gSi8EBv3pNhhgSu9iy04o8/t1AeeGlyaW/MB56Sj5iwUylpqKAl0TlBZNOfuCTFwrWdsZH41+dyjzU305JPAMafHyD+LqCvtBBI4DC2iY+bmkpPYxVpk9+dMT3JhL/8ChVmeOElJZUyzz9LTcCXoW997RSaDOrUGX681X1ZcCgxLLTwfdrSJr/+HrsEHaX2neCADw68wttcOXSdjRz2O9LP6RXQSkvQDo4/VWRawa2TT3mxX5tHNnaD3WpcTTeWVVO0WafoaQGKpgIESGqRQ0kgs5Fubz16umEVyaWcqvdw1wmY7UTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvtQr5RalCwC+cPoA18bLLa5WUS9v1S66dKQkq0JFdA=;
 b=XkOMt7sMu3WjoSOddSszRgfGOi4SPKEzDOZj7oGqkGwTvLeU69M5Mi4kJGblwOy8Mo/3GXA57qp+3+TzNtF53Hnkr/jjMjCgkV9VBKmuEk5rAGM24bqupt6GMq8ynfAREJx3wg2Dquu6PDkt20G+8IljsZ97+27rc0qgpoXLz54IgGEwCM3x8hp6PJa6n9WIxZwBCN8sQ48naDvYhmh/88rdvhbVXgXOlySSZ2REpeOGQNHbTGfdcoxjgmq0VNiXJVnxdspPcVqmxQ64n2aAap225mPxbu+Z7QrqHju8tKT3DVM0r5cJJkxMB5gKbpF2YbWfAnyuWhfN7SMbRss5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvtQr5RalCwC+cPoA18bLLa5WUS9v1S66dKQkq0JFdA=;
 b=vqNkYLRdSSyucbDu6yLsRFgHzqQBMEwAM/98R2zHPS+EmbszD+Ee1eyR0lCLoKaKV0ejQKVstrteH0bJq1MnVEB0I05BaJhJXi/SfBJss9pYyzJtRIX69EL+0IhxTs2MFOa97Vnz527q+lEHir6W8SeNcDDcUMqspKqKI6buoKw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6608.namprd04.prod.outlook.com (2603:10b6:5:1b7::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Tue, 31 May 2022 11:17:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 11:17:36 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 3/9] common: fix _have_module_param_value to work
 with built-in drivers
Thread-Topic: [PATCH blktests 3/9] common: fix _have_module_param_value to
 work with built-in drivers
Thread-Index: AQHYdCZaebJcLkSEhkuErbSpvaY+Wa0418GA
Date:   Tue, 31 May 2022 11:17:36 +0000
Message-ID: <20220531111735.mrgsmzs3mn7couss@shindev>
References: <20220530130811.3006554-1-hch@lst.de>
 <20220530130811.3006554-4-hch@lst.de>
In-Reply-To: <20220530130811.3006554-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75829313-ac77-4a45-ad04-08da42f72acb
x-ms-traffictypediagnostic: DM6PR04MB6608:EE_
x-microsoft-antispam-prvs: <DM6PR04MB66083C9BA3C886964B1C17A3EDDC9@DM6PR04MB6608.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lvQwFsA4HjFGRk6O+CBCSWQRZUeNlQcrfzLFnO4b8NeZChRi9XmLDJhCZ/ZUK6aTik6kl1ask8bwRhUBAlOQ5dHzM3os9xcBqDnvK3ornDQmFAY62u4+MSO6qB5SpxMyWIcyCCQKF6/4K+An9nm/6M6+pK0uJDUaoLjyJUIUc6KMZe6z1SP0M41BjPn2pqEpc4aC9yOzynGmFlEMym7c7OQ+DTL4s4snwIiRkk9bjZ0zK4tJJqcv5p36hbZmW07EyyPBPObAIxnG08o8d3d1Vj7PDEajQ9UJMLw6nW5AgL4H6sfGQ2oeQ3nR0cffHfP/vKOaz1NeVq+1RNktU7LUXtAD6W94tKV+8QZGiA2bI6Jxn4AtV8JRVd4cJtruNjImiJz1+oUMWGoKauvD2F+KcF/HdeSFJfmIBF0Fx1zz2T2FqCwYg4xYNY7PoOWOAWxSpLMu44zpvwfLN517fRxpoe3tOOlpf3GVsA+ptgunACUr3X9p0xZhSFK8xQJIHTZfhiWkS2NxmTaHBqjU7TzJ2D/AjqPh0xpL34xKOi6xpkgNgWVOmcd2oDbVql+lTk75JCqXAqkFoNtrjaTCT+h34h/Rh4+VBgyfE2WOCysvzs8xaLR6+xXD10LxGelD8qLC7qlMmq9OiKjgPMWhg1/7SdEVij7v/X6A7Ihky3LzIiHIgFoo3KMo0JYjqV8xJv2hA7LUUMxG13AMQTBcyz0GHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(38100700002)(186003)(86362001)(122000001)(71200400001)(91956017)(64756008)(76116006)(44832011)(5660300002)(66556008)(66446008)(1076003)(4326008)(66946007)(66476007)(33716001)(8936002)(83380400001)(38070700005)(6916009)(316002)(9686003)(2906002)(6512007)(6506007)(26005)(8676002)(508600001)(82960400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GLaB7bX10KHGqVH4wvgh9dpBnnzlivw4iC82APnWuVPcGheS+sCBoWbZxBAK?=
 =?us-ascii?Q?hmJ/4PtuZYiZkBqeQZV+qiUFxPtybxHN/szhqHK/oc8L9u1+zvnb6hdC2ytu?=
 =?us-ascii?Q?xGqc1pkP3fD4nyGeLvJ2zzDk/vwPFywv39z0/eWza4tJ3SlMAU/RNDeQQv3W?=
 =?us-ascii?Q?/0GaEAqyz4qw8EwhVsfORBYFhtATahOG9LB+phcwfWy1ddnsJftJV3SnDQLn?=
 =?us-ascii?Q?K4F1zMZtDJOPLE+JItimQB/bXwmwjTX5JPuXgcjjg7WglHpnDFoUaOrlOJ+2?=
 =?us-ascii?Q?moAhgKCMY0fmto+mcZ+ZGso2bR4//KF7WwNUHm4hNMSnnAMJpON6WeNZKGF7?=
 =?us-ascii?Q?iJKL/0qoTZAlKmr2TX6bVa0N1VYHEw9+8fQcsl9MJZOY4PqZ8kG5fHSqxuUE?=
 =?us-ascii?Q?Ng2nWr+uD6Xw0/Pxt5KNZwaGSBOx4TkDSpkASm2t+sGmkU02wKbm31f3RhXU?=
 =?us-ascii?Q?LGCBdit/NbmrZpqiEFVFu6PAr4k+MoJH4tvlibwlFyxmyMctdYNyyuylYS5Q?=
 =?us-ascii?Q?wAH0x/z78eTj9UQs7xj7PMCtUz28tyubhFhbZ5dDK8pxqiwEKNiJokYJfz2y?=
 =?us-ascii?Q?EBzaOVJC+l6p3g5YylC7KdTRQFZnulFxyH7XOho6EONJtReeNi3aI0ypuBkR?=
 =?us-ascii?Q?VB7ow25STvjI2pdAVVBRBwENiHz63fBp3XxxpB+FAFrQOZlCth1eDqDzWnz3?=
 =?us-ascii?Q?ihQB2j84EkaegEwr5XTwEGSLi/0xb8l/Go5b4lZwzlV5xsKhr7g1kqP2sxXb?=
 =?us-ascii?Q?DLytCUCz0QTWsAxw1A4BpZNSSzRw561T/Xp6TC/C7mrDlywrYtFuBthuXxse?=
 =?us-ascii?Q?V0R43E9y0XRqpNY2RLRsqVT+UU3B1XxSyVAp2uS6aDhzOqggtLzroi9JbnIw?=
 =?us-ascii?Q?L0Ouc3UrFilGD/dBKtSYXu50KvBycmulTqFVlL0hdXZuKEJCoPcLETtU9UAW?=
 =?us-ascii?Q?GwZJBLXY18fHQunm704h287HBQjkByHfMzNZ5QSC9KfFyvz5psdP21UzJ/bg?=
 =?us-ascii?Q?G90SwJRyQHy6nvvThFSsyQIuD4C/5Jm9W3hC8R5U6zF8UBgKaSjvgRryGjg4?=
 =?us-ascii?Q?oQCuN+kkUVBwzwgtn+K6/Yde/wTFBsL8k6LoGWorvCAUNw3z7T4z2Q1qHbun?=
 =?us-ascii?Q?WrlMneadAj2PXHM/SjQMPBQM/VzjNZRggwtO7etAFiLRskofvW0fJugqi+tp?=
 =?us-ascii?Q?RkiR5sg1Tq7dG1o3GD6s1WLXN9UigofrgtUoqVuEgX+mHpcv9ZzGiZ6DaMn8?=
 =?us-ascii?Q?hsh/q3VXHBRVigayLzTMycIJrQu1OIPTJuAlxLBvVBlBtYWT9MOwu6xupkt6?=
 =?us-ascii?Q?Ue3hgVENpU5bKC9TepV25b9mojAFFdNFg/caKCf3Cb9CWPmOsQKHeDp5zSbj?=
 =?us-ascii?Q?MXSeG/E5A6p78tZ7ukIXlnOtXLYt0QXHLXmHjV6tchzGCsWw6c6DEhmagBbA?=
 =?us-ascii?Q?jGsELewz6xG8atJyba707G1Un8YybiZGAcu/Td+sfOrbirRSASH2leRsOORs?=
 =?us-ascii?Q?+2LsEnemvxHmt58O4Sh1KZZpfOFLJ+Paa8fNsjqjwUcPfQOYmVjv3it/Txg4?=
 =?us-ascii?Q?Rx34x1yxJhqBMRTv1nxewNmFxYwtlS1v9LkBPPN+3vFRcbJjdEfDtXeWJOZC?=
 =?us-ascii?Q?eeDymunyTr3As8ezEQajoBqmvq5nFS8ZhEEUtpa8tT57HHmoWhGDIuY2gi5q?=
 =?us-ascii?Q?b/UiCwaU08sqjDBpXR/UgbHgi0+qdBZv+x6ac5KE7GWITyzACk/UWCP5dLRT?=
 =?us-ascii?Q?44jk2wK8kLyrdqIBacjExkY8oZeDljU8wrQHkpxyczIzgACwbTRd?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D17134CE762C2B4EA31A8D996041D5A6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75829313-ac77-4a45-ad04-08da42f72acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 11:17:36.8379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OSPoKM32hbz5WJYbrPQpMA5VrnUUdbcahJ/qeaFXnwW9ZV4ZJljC73gL618cd6uvBemdJhRyANbdUXH7cD94SL+spVvV1vFYZ3ZV2el5vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6608
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 30, 2022 / 15:08, Christoph Hellwig wrote:
> Don't bother to call modprobe directly and just check the /sys/module/
> directory.  Also switch to using descriptive variable names for the
> paramters.

s/paramters/parameters/

>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  common/rc | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/common/rc b/common/rc
> index a93b227..ffd15b6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -74,17 +74,22 @@ _have_module_param() {
>  }
> =20
>  _have_module_param_value() {
> +	local modname=3D"${1/-/_}"
> +	local param=3D"$2"
> +	local expected_value=3D"$3"
>  	local value
> =20
> -	modprobe "$1"
> +	if ! have_driver $modname; then

Underscore is missing for '_have_driver'.
Also, shellcheck requires double quote of $modname.

> +		return 1;
> +	fi
> =20
> -	if ! _have_module_param "$1" "$2"; then
> +	if ! _have_module_param $modname $param; then

Same here, double quotes are required for $modname and $param.

>  		return 1
>  	fi
> =20
> -	value=3D$(cat "/sys/module/$1/parameters/$2")
> -	if [[ "${value}" !=3D "$3" ]]; then
> -		SKIP_REASON=3D"$1 module parameter $2 must be set to $3"
> +	value=3D$(cat "/sys/module/$modname/parameters/$param")
> +	if [[ "${value}" !=3D "$expected_value" ]]; then
> +		SKIP_REASON=3D"$modname module parameter $param must be set to $expect=
ed_value"
>  		return 1
>  	fi
> =20
> --=20
> 2.30.2
>=20

--=20
Shin'ichiro Kawasaki=
