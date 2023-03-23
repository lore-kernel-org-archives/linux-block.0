Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7495C6FD1C
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 10:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCWKrt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjCWKrb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 06:47:31 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F423C44
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 03:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679568308; x=1711104308;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yijz02FvF6Jxh3HY1TcKIXzShSRxFVHvfWX2zZl+V4A=;
  b=Zk2CgOHzfjEADT8pb8ZFoBzOp3JlNn2tzX+YXItPgo23IQZAEg8vmgvX
   50rc9cBgZPKpCc4Gyw+3xvlNHBuAGCG5aN4Cic2E6P9TbhSgEHWJyerIv
   GhKWFFaYQE4aYAEa9kskpXDoWtDSopLj4VKzKkccwYA3NfwN85m82NVX0
   Mhwe2v9xTw/ZKkZYYGRT3C6J/FMZzoHcA+aAtv0zdYpg7Ah9faSVK2uO9
   9ByyAuvd1gF1hy9VCw4yqT0A8fjjyTtxwneGokmQNS/6Js1c8Yp9/I4jD
   GtyezTMG3TDfkpq9rE95rlPm+eFwbWq32vUmhE0Mmccd8UD2UI7nYmNMW
   g==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="330738983"
Received: from mail-bn1nam02lp2045.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.45])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 18:45:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO0y4oa8OhCP96XKa3fzI56YfxaM7iMtP7r2hdH4rfqebXIzSXaxzKyd0VhD6+HeG5gTnBARWtSFyAox5RMScZ9kBffY0YBq1prmXCeXTuiZsBj9mZdwg2I8McmVsG2hqN7vjnJOI/M4nILGO58qXXJafU0r1z119ml2vr4aUtdViEsDU4Qi+/5x3kpJPRTy9SfIU4XA49N21PhbVYyr78jHrCakKLDLm2ycjVBaUWTRRU42gzAnMIPBZtPSd+Maa+JDFZWA73R2gB4RJmobIwiqPc6T987zMSKkrUjP2PyPnPi8TP2HKv4Zebovwtlqb+5Lax3S3WQSw8opCVxShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRs89Rll+n/XJ9B38Ae8wFdGDQi/5jpHAMxO+iLjHyc=;
 b=geQMfrdwD3kUpWWoJKRgWH+N1HFBq1u9z8uSTmUORjLXdYFRgPD9/CzwjdoVKDW5+3DFzGNCXYP/WTvSzjtx71X0xetNZRL1/nODG1mGtbHqsyNzVV+c7B3bDuAvHf+0FcpOIngUdD7DnAqpNvEorLV2jUWXKvBzvZqig5NGbjo8BfwOwTrYEIRAQ8g6PBqtltwvTcEAD2TQCti5PE84VH/0Tn146XB1KMWaabVwmjaCla79Gh/XXW3/wSaLL9XpCbibcdOScdlbhzgWBMKy4xP8eOaLqlxLYOyKmLyv6uC31y6QrkiVZk+tkq3eUwIuYEn27EZ1gaZKTyI84eEmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRs89Rll+n/XJ9B38Ae8wFdGDQi/5jpHAMxO+iLjHyc=;
 b=R/Bg8W7+2FuhvMH15LGzn0hCeC4J2bCq2bYnTW75gSs9P7lvMHmGlJH+PNmllVO6MPwLbKH22+D0gnyGd8KAZfktbVWkMzJ4dfmUfGR6KEA0AbPEFA9SnqxfVv78vWGVlrHmxDFBIWMEIZkcYosWKLiXxO8Bb21Ob/WHmmvNzao=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7431.namprd04.prod.outlook.com (2603:10b6:510:16::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Thu, 23 Mar 2023 10:45:02 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%7]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 10:45:02 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2 1/3] nvme/rc: Parse optional arguments in
 _nvme_connect_subsys()
Thread-Topic: [PATCH blktests v2 1/3] nvme/rc: Parse optional arguments in
 _nvme_connect_subsys()
Thread-Index: AQHZXKdwa2pk+ZWsW0uL9B9pnp47Mq8IL7qA
Date:   Thu, 23 Mar 2023 10:45:02 +0000
Message-ID: <20230323104501.yo7psenh26jjqry4@shindev>
References: <20230322101648.31514-1-dwagner@suse.de>
 <20230322101648.31514-2-dwagner@suse.de>
In-Reply-To: <20230322101648.31514-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7431:EE_
x-ms-office365-filtering-correlation-id: 09d98d3c-c542-4763-20ff-08db2b8ba813
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fEusYFdETN4GPMAtPT5PX8Y6ijgnLKkH/Mv6ug0fP7sKqZsXXpM7QtUXWi7k0UZWStPa2gueQs+4abOL3a7GO7gSwwMkFJbAmgGdRHkjsgIdadCrUJLpPgSgcK4EZm0ZL1bV9R8e+0fMWYhh7+sqwwUEkdB3EQtXx2jcALh9vhj9wPEIehb15sCCkpZPFhDp+qzrrR6t9UE+QOYzDTpvty/cQKNP74Afsl7tW7zjFCgrvBkfQ3TtixjzSirD8L5SveW40eshknUwyz734p9/PLLigx9ToryN7elPb+kqFAVUaO9Nk/ixaAcS8iGI44JIKNlOFv0S+MHp5Cohwpmy05wqgB425RWaMlA+f+PCNGloWmIy+zjE8VbqQ8K2SYYfuxS4Yu5hDuWhHQtokkd8Dgs5e7RFUiwYF0oa2HRFF22W/CMIt1kJbOQtSJe03C2bwUl4oT857gNHiQMoBkppTyjwFqaVAf+hkzeEKbbsrkMrjzWlpaiM2y4wUpBALP4fOGbJT4bOfM7szwwI2kpEIUAo0xCMh5TECqYjvP/9Z8lW7ejE1BW6hl9uTCzc1O9Kq70dNJH7yk3MhNFWll3VMk5F15neDsDd11sX2YmIBegq+RDVG5J25R+xTJ4zxxY1qEsneXN5k6cxFoLafPRyoMsxoWIz4GDzBdeWegKMNdmC4Hatra5D+FuaZZx8rTUNH53GwS8hk2sQxgT26T4SIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199018)(86362001)(82960400001)(38070700005)(122000001)(38100700002)(2906002)(44832011)(41300700001)(66556008)(66476007)(66446008)(64756008)(8676002)(6916009)(4326008)(5660300002)(8936002)(33716001)(66946007)(186003)(9686003)(83380400001)(6512007)(6506007)(54906003)(478600001)(91956017)(76116006)(316002)(1076003)(26005)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s57GMW7UdDkRgtJsi6QwVhoQ2tjI47E/sGTaMzEOCRhvaZgGhn1zyNHkBYpj?=
 =?us-ascii?Q?rSllYjFAg4NNNsRBQLyXtAmctRcrmpSL+z1FgzJ/Cuhe04HPkCv4hW0/j9i5?=
 =?us-ascii?Q?xNwCLKYBM4naB3bzaG8XJcS7OMMq6kFNHR0p+HRT3TOVnrFBayRdw2uxBXVW?=
 =?us-ascii?Q?uY64Zi44uNbZP/Hj1IhY8EtJy77m6z/ukR4z6HVsKSzmuzwaCsvFvLkWrPWi?=
 =?us-ascii?Q?BZk1U5fBTkQVN6fSpuA9zaEV9TghgBUz6YGmO7YLy9TEeaTNxQ50OMOyFw+j?=
 =?us-ascii?Q?pdh2rM0emgR+gSlM+H6u51enCFOz2he3hl5a7te6PuFMaTOk/0ivXTkqilmf?=
 =?us-ascii?Q?/GXDCmQaL7imN+MnHnCNkpjPRR+zSUkDEV2+G9VKJT5gQliKaPmYwyeO6lkA?=
 =?us-ascii?Q?1uQzE+hAlfHMQUG0j387cvSJwenUK0yOsgMAwWVbvpmombaeDbVT3/alzyCv?=
 =?us-ascii?Q?1/LJKWj29iE3OU4Wh68R+oF9rbYbODc0KDFCVO/OpV133Q3zARP18AieNXfH?=
 =?us-ascii?Q?GJu6M3lWtjfk3NXujbFKqUMvivEGuqJFMKpJBUkdL2UvLazcJLX60Pc5D/U1?=
 =?us-ascii?Q?01LPkQ4fYV6TmHtFSQdcXwu+MYz/L3qIQmxdnpytPw6T26Dl7Ueb/EO8f64P?=
 =?us-ascii?Q?Hp3IKNUpRKbIkjPw42tF1AhW3bFljG/miiFc5/iIXkaix0oirbiCKSOzBn/9?=
 =?us-ascii?Q?E0d7tHyvrnoNhg63KqPiGe08nnq0O2Wmdwb0hOaUttODSxV+RTkXxCJBZay/?=
 =?us-ascii?Q?hetroozC8KOclzqJVK4W/c8tXI9W3nMVxme1Qg1aX2kEJ1NWLBkBv5RQJl50?=
 =?us-ascii?Q?CHs8Pc36u4YP6cjaZT8homu5pUZe1RCKc5kbRysTVkK4XkDoBx6RrgyPIPUZ?=
 =?us-ascii?Q?Gt3R1ioEjGxuz/zgSC/ZSc9yg9ZsIuJ0uyd/2Ide7GODanV2b5OkkOBabhvF?=
 =?us-ascii?Q?8Wsb/4FRUohi5a8EmUUM8xNAuGphKmA/VrFNtt9z/ccvdUOnH2kL8l/h3hyp?=
 =?us-ascii?Q?jA7iegtz1y5/pepmEtbtMLdVq8Iymg9N/1/9KkXC5PUmrTQh4Y+m01K8l/QE?=
 =?us-ascii?Q?9w3FdfQnfhesUO7986h9XWhQ8kVcSaWXO834OGxb6WOJLvVQZnJDlV0c5OYz?=
 =?us-ascii?Q?4PdmWy5fbgQwVOvpyvcfGDRWbF4L28a1EBLDzLkHK9swd83n4OgEDqoYYYse?=
 =?us-ascii?Q?t5FUl7IXgNj8U/GnZg+E6tbPlQHPUKDaJXJOfV6oMfMgLacpIIxob5cOlvpK?=
 =?us-ascii?Q?XeILwypJWvwLXEk3xIzApCSMEVzOK4H2pymzhCxcZZXPvqehBl3c8FtbCV1d?=
 =?us-ascii?Q?y+FFDh4MHPyaP5tHhncvQ8pKNDRRZwOn1G1bWvrPcgQjg2q1XkSaBY+CbMe7?=
 =?us-ascii?Q?pZ+ivGiynW1iF0r9SpndicRayqhgJhDRSlrhRHo6FnQRJRwZD1rlJgT/WTIy?=
 =?us-ascii?Q?/xhsLZm+yUY8yf5xrvRkQK5DxbA1qKUj5qA7pTkuZI+tYWZKRLGSr7ZyV7GB?=
 =?us-ascii?Q?Twf80ay7GtbJzfqOq5RapFY2XUNCFeG6i4iILyLhq9J9bAlbvtCQZ45uDVPr?=
 =?us-ascii?Q?AEszh1vdMWdrz9TjS2B0S/D4OilfJPQZub6jmGO/GvNPBC3JQrOmD1+HawcS?=
 =?us-ascii?Q?TLlE3Y6EcP7IC07uP9jWaoI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9159EFE48011BC4098302B2C5CF22EC1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Chdv24DvTkAD+r63oCtj0SbJ3qEjKu6X/Na3FAz9SDaRIVMi1MhAO7kY8Pe3dAB069qnVJYFdIbEQlKMZlRl+YBPhVqnpiRabftOXWO0oikKmOqwzS4+SaCrBrDL7qr1q+T/3IuU61OshNgN8hoJt4QgEfilRIvvicaEnrlqWoRqjuhT4bKnziK8Tsp8FCWDeXJWM5e2o3l76XFrSRKEX5USGe7ul8YOllH6plqCwy/OqBOUpphdWYREN3JLeMocogoRDRi8Eeqx7+wqgO5r1OhxbkZg6ByDsF4AyiO5C1p8fVEiIhbn69cdCbH4XmNEgtMLTkDce7CK0b+nlwUpF5K/kCGcyMeWhd6P0e35lLfGjooEP+4KIBYl/jD1PdmtZr5vYi7tTiHBXvmKiQ84+q8As7DgllPtMTpBTyZJjm6lx3JFYJqjHDVx4gJMy5Q3irur35krz6U/XoLTXxjCOuzY/umgQI3GQ/HHhZwObebZ62X+YTBCnCshgAmi1JolY5eeV4n/Qnx6AW1BIRhhnFraLXpsLm7Jvz5zHAlzhRk1EkZykoP3lZR1mLU88ztb3nUnuuuBthYpkMRSOjpZNZkGqSlCSGbODRH6P8yc0uWigwhYJwCzW7Kh8cA8oDgehVOQ3w1HWyBd70Fvebwu58uCok8xq4RyA69+q5Vhqzm9vMznVdN/der8uFCr3rDotLe0YGZ9uxAITIMSuReb4O6tm7cPCf2WMa4dsFwRiQiWYoFaYVXTqIGOM8O2ruVEIGgFJAlKuQzRy+7pGh3U4IFPawlJl7WM4iVGget0x3MqGAz51mCdF47bRb0IvqcH8B/QMXhPtbXEvCPaRRL+OO2KYY/husF5GZe5UsX1OiMg/QrXsbHO/hKxiYsh6Ejn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d98d3c-c542-4763-20ff-08db2b8ba813
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 10:45:02.3019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j6Yoi+jACsYZMH8oHZd1CfdRf4kbMyAywdS0xAvLddi+rbFXkVG2UIIQoUdTS4Mq1hieSzAMA9CzHCHEfgqMu599KJqZ2XxMyXIV93rcie4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7431
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 22, 2023 / 11:16, Daniel Wagner wrote:
> Extend the nvme_connect_subsys() function to parse optional arguments.
> This avoids that all test have to pass in always all arguments.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/041 |  7 ++++--
>  tests/nvme/042 | 10 +++++---
>  tests/nvme/043 | 10 +++++---
>  tests/nvme/044 | 23 +++++++++++------
>  tests/nvme/045 |  6 +++--
>  tests/nvme/rc  | 68 +++++++++++++++++++++++++++++++++++++++++++-------
>  6 files changed, 95 insertions(+), 29 deletions(-)
>=20
> diff --git a/tests/nvme/041 b/tests/nvme/041
> index 8ffcf13a500a..03e2dab25918 100755
> --- a/tests/nvme/041
> +++ b/tests/nvme/041
> @@ -55,14 +55,17 @@ test() {
>  	# Test unauthenticated connection (should fail)
>  	echo "Test unauthenticated connection (should fail)"
>  	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> -			     "" "" "${hostnqn}" "${hostid}"
> +			     --hostnqn "${hostnqn}" \
> +			     --hostid "${hostid}"
> =20
>  	_nvme_disconnect_subsys "${subsys_name}"
> =20
>  	# Test authenticated connection
>  	echo "Test authenticated connection"
>  	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> -			     "" "" "${hostnqn}" "${hostid}" "${hostkey}"
> +			     --hostnqn "${hostnqn}" \
> +			     --hostid "${hostid}" \
> +			     --dhchap-secret "${hostkey}"
> =20
>  	udevadm settle
> =20
> diff --git a/tests/nvme/042 b/tests/nvme/042
> index d581bce4a9ee..4ad726f72f5a 100755
> --- a/tests/nvme/042
> +++ b/tests/nvme/042
> @@ -58,8 +58,9 @@ test() {
>  		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
> =20
>  		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> -				     "" "" "${hostnqn}" "${hostid}" \
> -				     "${hostkey}"
> +				     --hostnqn "${hostnqn}" \
> +				     --hostid "${hostid}" \
> +				     --dhchap-secret "${hostkey}"
>  		udevadm settle
> =20
>  		_nvme_disconnect_subsys "${subsys_name}"
> @@ -75,8 +76,9 @@ test() {
>  		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
> =20
>  		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> -				     "" "" "${hostnqn}" "${hostid}" \
> -				     "${hostkey}"
> +				     --hostnqn "${hostnqn}" \
> +				     --hostid "${hostid}" \
> +				     --dhchap-secret "${hostkey}"
> =20
>  		udevadm settle
> =20
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index c8ce292ba2e7..c031cecf34a5 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -56,8 +56,9 @@ test() {
>  		_set_nvmet_hash "${hostnqn}" "${hash}"
> =20
>  		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> -				     "" "" "${hostnqn}" "${hostid}" \
> -				     "${hostkey}"
> +				     --hostnqn "${hostnqn}" \
> +				     --hostid "${hostid}" \
> +				     --dhchap-secret "${hostkey}"
> =20
>  		udevadm settle
> =20
> @@ -71,8 +72,9 @@ test() {
>  		_set_nvmet_dhgroup "${hostnqn}" "${dhgroup}"
> =20
>  		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> -				     "" "" "${hostnqn}" "${hostid}" \
> -				     "${hostkey}"
> +				      --hostnqn "${hostnqn}" \
> +				      --hostid "${hostid}" \
> +				      --dhchap-secret "${hostkey}"
> =20
>  		udevadm settle
> =20
> diff --git a/tests/nvme/044 b/tests/nvme/044
> index c19a9c026711..f2406ecadf7d 100755
> --- a/tests/nvme/044
> +++ b/tests/nvme/044
> @@ -66,8 +66,9 @@ test() {
>  	# Step 1: Connect with host authentication only
>  	echo "Test host authentication"
>  	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> -			     "" "" "${hostnqn}" "${hostid}" \
> -			     "${hostkey}"
> +			     --hostnqn "${hostnqn}" \
> +			     --hostid "${hostid}" \
> +			     --dhchap-secret "${hostkey}"
> =20
>  	udevadm settle
> =20
> @@ -77,8 +78,10 @@ test() {
>  	# and invalid ctrl authentication
>  	echo "Test invalid ctrl authentication (should fail)"
>  	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> -			     "" "" "${hostnqn}" "${hostid}" \
> -			     "${hostkey}" "${hostkey}"
> +			     --hostnqn "${hostnqn}" \
> +			     --hostid "${hostid}" \
> +			     --dhchap-secret "${hostkey}" \
> +			     --dhchap-ctrl-secret "${hostkey}"
> =20
>  	udevadm settle
> =20
> @@ -88,8 +91,10 @@ test() {
>  	# and valid ctrl authentication
>  	echo "Test valid ctrl authentication"
>  	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> -			     "" "" "${hostnqn}" "${hostid}" \
> -			     "${hostkey}" "${ctrlkey}"
> +			     --hostnqn "${hostnqn}" \
> +			     --hostid "${hostid}" \
> +			     --dhchap-secret "${hostkey}" \
> +			     --dhchap-ctrl-secret "${ctrlkey}"
> =20
>  	udevadm settle
> =20
> @@ -100,8 +105,10 @@ test() {
>  	echo "Test invalid ctrl key (should fail)"
>  	invkey=3D"DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
>  	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> -			     "" "" "${hostnqn}" "${hostid}" \
> -			     "${hostkey}" "${invkey}"
> +			     --hostnqn "${hostnqn}" \
> +			     --hostid "${hostid}" \
> +			     --dhchap-secret "${hostkey}" \
> +			     --dhchap-ctrl-secret "${invkey}"
> =20
>  	udevadm settle
> =20
> diff --git a/tests/nvme/045 b/tests/nvme/045
> index a0e6e93ed3c7..612e5f168e3c 100755
> --- a/tests/nvme/045
> +++ b/tests/nvme/045
> @@ -65,8 +65,10 @@ test() {
>  	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> -			     "" "" "${hostnqn}" "${hostid}" \
> -			     "${hostkey}" "${ctrlkey}"
> +			     --hostnqn "${hostnqn}" \
> +			     --hostid "${hostid}" \
> +			     --dhchap-secret "${hostkey}" \
> +			     --dhchap-ctrl-secret "${ctrlkey}"
> =20
>  	udevadm settle
> =20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 210a82aea384..1145fed2d14c 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -316,15 +316,65 @@ _nvme_disconnect_subsys() {
>  }
> =20
>  _nvme_connect_subsys() {
> -	local trtype=3D"$1"
> -	local subsysnqn=3D"$2"
> -	local traddr=3D"${3:-$def_traddr}"
> -	local host_traddr=3D"${4:-$def_host_traddr}"
> -	local trsvcid=3D"${4:-$def_trsvcid}"
> -	local hostnqn=3D"${5:-$def_hostnqn}"
> -	local hostid=3D"${6:-$def_hostid}"
> -	local hostkey=3D"${7}"
> -	local ctrlkey=3D"${8}"
> +	local positional_args=3D()
> +	local trtype=3D""
> +	local subsysnqn=3D""
> +	local traddr=3D"$def_traddr"
> +	local host_traddr=3D"$def_host_traddr"
> +	local trsvcid=3D"$def_trsvcid"
> +	local hostnqn=3D"$def_hostnqn"
> +	local hostid=3D"$def_hostid"
> +	local hostkey=3D""
> +	local ctrlkey=3D""
> +
> +	while [[ $# -gt 0 ]]; do
> +		case $1 in
> +			-a|--traddr)
> +				traddr=3D"$2"
> +				shift
> +				shift

This patch looks good other than the type you found.
One nit: the two lines above can be single line with "shift 2". Same commen=
t
for below and the 2nd patch.

> +				;;
> +			-w|--host-traddr)
> +				host_traddr=3D"$2"
> +				shift
> +				shift
> +				;;
> +			-s|--trsvcid)
> +				trsvcid=3D"$2"
> +				shift
> +				shift
> +				;;
> +			-n|--hostnqn)
> +				hostnqn=3D"$2"
> +				shift
> +				shift
> +				;;
> +			-I|--hostid)
> +				hostid=3D"$2"
> +				shift
> +				shift
> +				;;
> +			-S|--dhchap-secret)
> +				hostkey=3D"$2"
> +				shift
> +				shift
> +				;;
> +			-C|--dhchap-ctrl-sectret)
> +				ctrlkey=3D"$2"
> +				shift
> +				shift
> +				;;
> +			*)
> +				positional_args+=3D("$1")
> +				shift
> +				;;
> +		esac
> +	done
> +
> +	set -- "${positional_args[@]}"
> +
> +	trtype=3D"$1"
> +	subsysnqn=3D"$2"
> =20
>  	ARGS=3D(-t "${trtype}" -n "${subsysnqn}")
>  	if [[ "${trtype}" =3D=3D "fc" ]] ; then
> --=20
> 2.40.0
>=20

--=20
Shin'ichiro Kawasaki=
