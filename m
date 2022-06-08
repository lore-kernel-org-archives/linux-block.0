Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34095C43334
	for <linux-block@archiver.kernel.org>; Wed,  8 Jun 2022 06:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiFHGoB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jun 2022 02:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347560AbiFHF6C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jun 2022 01:58:02 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB811124ED
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 21:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654662263; x=1686198263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p86RzldPYX8Wj1BzU2Drj97l8GIu7zYVheJjGoVJ8u4=;
  b=OS1Kgd9flAQ0T0KMPGBb+R7+77VAecYu/uw18mhoMwIjREfAoHxZQm1u
   /xaLduWBZAvJO6By79dgiFjnQcnK1Tn4uRJALOOKWRGW4Bl7KfyViYs61
   wb7CLygh+BvjRu0OHDDPepDgkN6ZfbjwLOhPoiCP3JDOQfC+3XoJnsxyJ
   7M83l7HOUXr2yr3GAdJ8HcCXDTX3VndtIDkvdw9VTjshXkJN0oU/hxyDb
   zQDbMnOMpOgyRJu0SvYWa2jqkmS2VdQ9uV7JX/yY30QlI0lolGRRMUW6V
   iVQoYyPlBW5rh4KOxFR2CsQUDTL1meGqiZg/JVY+C2r25JuacdV4T3ebu
   A==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647273600"; 
   d="scan'208";a="202559814"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 12:21:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhWdcI4Knll0XGA86s2rf5fmL/GNqBbXBjc+LXhYZaX1lEde1WnJrA/tgdDxArfCbaUWLjiOyfLkneMizargwcahj2VZmP5Ucwn7NhH1ieX0j3FvTW1lZIYlBcS2XVAtkseXyr9Z4mOfAZ7/g9ij1u7hoARwFwHghKqbfO6mA1AHrMrg+OFUfhRaTnCBRMfGyaSHhdVrKybGlJpHtGBTPOfUfkYzIpn+vQ1kEG5GHXqMnyu20tJiJ1624PDreqbiQOwGLQsHHPIPq6nvgIMUG+lVJddQ5hnX/mF3RYr9HJsF0r/T4ufHDGJ8uioNwd9JfonuBYTVmrC2yBxNwhVtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4FDwZLSMkQowl5HrHewMaiYXfRW0ms6PFbyApK/l1E=;
 b=ItTOurSGS1v5xvojNjTHHCwVvTyLM9/pheckfwwjEV3wF7tnFTF8MYrh9QWGTn7IFBqTe46+yOn510Pq8bR6PUkYrW6QpezNqfAYjVIyRWvpCqAFDglsO5DGf1uJoWxE9d264B2sAmyKEy4wJdokGh5g6incyy6yZQL4jOLLDb78bPVSLIJyaJZFT+eApz4+aqnLwkVivUdHclSYKauC4Zqs5rHwnA2PZG4bnGJucoVPDZ6Lo0ENeu3FFihnleWQp0LbWIxQI56XH32eU/nq5Hbu3oHphgge01gT2vDe/IgqxXZZbu/XEeDXyqzAS8jEOagkoNlwDE5aqKvXr/W6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4FDwZLSMkQowl5HrHewMaiYXfRW0ms6PFbyApK/l1E=;
 b=z6944Njw5Nt2zFJLi/GwBeVmo9hrh7o4kTMNZoHmNOvSSeY9ce2GshLsCmUpVh4CMC347lpmSJxFZSKLLHYsvm0aal6zZNzsOAzwNXI5JiOFI8XgFP14HXBEYdoOdoePPHDO0mT7oAkJiWcb0u+6rBs5+1JPzMDRy5ypJLGNUpg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN6PR04MB4239.namprd04.prod.outlook.com (2603:10b6:805:36::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Wed, 8 Jun 2022 04:21:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5314.015; Wed, 8 Jun 2022
 04:21:54 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH blktests] nvme/033: Remove volatile output
Thread-Topic: [PATCH blktests] nvme/033: Remove volatile output
Thread-Index: AQHYeC//oX1vsB2AfUyASd1EGJTQMa1E7i+A
Date:   Wed, 8 Jun 2022 04:21:54 +0000
Message-ID: <20220608042153.qz66axh7bturp7q6@shindev>
References: <20220604160638.1118-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220604160638.1118-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1757752-50c6-4fc6-218e-08da49066b2a
x-ms-traffictypediagnostic: SN6PR04MB4239:EE_
x-microsoft-antispam-prvs: <SN6PR04MB423994E90393C810EBB8B82BEDA49@SN6PR04MB4239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KpICnYYKOzv3pDH6fZViTnxA7WHeluWTwgi1/0UN9HLgcUNGDFwOrhIeof6GLLUE4Uod/VARn+IlHqMFo/cvyjdpAPJVuDfQQCZxgMouRV/XRpiOPQlo3Vmhq0ybZhYMGAvqwz7q3WnXWHd75AURteqZYkF3wE92LCyz6/DZXlytaFQ5t9mDT3kZkm+tibiUa0BW+CKsrXSRh63S3/JcW4Kkt8u1Pwtu9RGdtVZXCNHHcV4UfEbGB/dVsMeUv0KFw5Ql2Lcb4pYNroxxqBLozpxsMj0c2k8HzgkZqeYMNC6xA9+GGAuw73xD/A1NvhLeSfSbHieFGYyUaoI41Er+y001xFv6PQ5adLAnEGvwTKL9rFPPdsidEix1OfyXkALZJVvOjRpFusdjR/zGNPHQYUVej1v15JEAfpiEeSL5VWeCwe1DGlcFKoeHj5/fcPqKnrpi4IlQNEG8hGkGy440ugNTIn3epm3vi551Eoxjmj18V2atRyVOd3MXM4IjXS93sRbwtfVIieMEQ1IGWBoGgO4wEv2gw0i4tS6mXgu4Cv4yvUa3c5cZ8xlHMUYudHzRlu3MQgICvLacKvLtUxba14nTNgUT7hfiiPcbtX8+sKNWnm71mg2T6Kxzk8XdhCs4+lIXg8IM/D1uX8CXZWSHrcFHBpeqf/MnRerEp9cL161zq7Y1PUNecmuSgpcf02U8ZNYI7gzXy0icoMXsuHz6ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6512007)(4744005)(9686003)(44832011)(33716001)(5660300002)(8936002)(508600001)(6486002)(6506007)(1076003)(86362001)(38100700002)(122000001)(316002)(186003)(26005)(2906002)(82960400001)(54906003)(6916009)(91956017)(8676002)(66446008)(66946007)(64756008)(66556008)(4326008)(76116006)(66476007)(38070700005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k5YrN21KNg0ao/MyuxOLwGQG2OaL3HqOgSrkEYQS4Kpk65aXw6JCX505PdEl?=
 =?us-ascii?Q?1O3QGuAPesi/Qhn6zCiK6mXONsfr5FRIkZcVCGr28hxetWgNhU1c3F5agY0Y?=
 =?us-ascii?Q?x1u9BoaeKjFg0rEB/PmkrIWkQOuLuo6jSLbLr5n1g5mrnlphJ6rRHw1oPzFv?=
 =?us-ascii?Q?V+DUnw3Pw6CySulw4yGUdI3WS2WdTp3TW2LeyH75naMo4S41tz4bzxzm2ah4?=
 =?us-ascii?Q?Xpxe9sIW8BMSFpeec4IdUt3/kO/RaaiyVcGYd1doPqvkUdKympXJA7+Dkaa4?=
 =?us-ascii?Q?NzJ/8+kLHScp/pBQt9UhDLUHUzdu3hvRdvLCRWbCcTszTacxFzp9jL8Z5hB1?=
 =?us-ascii?Q?U/+GTBXD2bcChE4NbvP1voNEB97Ocxv7iNb34ukKsHtKFVy6P5FTGe8mvyuV?=
 =?us-ascii?Q?3DfY4sLxzzqyR9XoQo0idcEeKHzPJyj3HP6Foamss6DG4+VTSYHvKd0xsi/Y?=
 =?us-ascii?Q?81/gCb8T+ZWbzoNfIQ73jVqJ/LOzt5gwlMep3+Ktn/uv1ERvX6LAo83skWm9?=
 =?us-ascii?Q?Hy+MLhyoOew9fakGRj3JnmORPCn6sF7/wUCtFwjW3Lz4BwxEp+ZpdcyUVgsu?=
 =?us-ascii?Q?lIoKz562uh3aYscp8U8i/Z3Cd4uv2Bb3jX/WRFfp1AC5aIeJZdHbDUr712Tv?=
 =?us-ascii?Q?hhpGlD6B5CuzJwemRK4ntOEaHNOPuFnAA/f3ugXxpVMWDWyQDJtbapxDxzwU?=
 =?us-ascii?Q?AEsfJakgmqNBXD1/MkwIIZZycVT12reFn7/7TIw6HV0dgp7z2kF9UU3EvOPG?=
 =?us-ascii?Q?PaxmIwfNTdq6p+ZQCcKYFGPdPx4UHFslAT3vHAGBLAHNFFh0kn0+ZNYpV/ow?=
 =?us-ascii?Q?NslxVdxpL4+Bngonnhnzzoai54uIPxMZJVQkjsE2+BJizpJKhQtX8pQqEcQa?=
 =?us-ascii?Q?eg1DSelMUH+b37L2vx1KBhsa8cuv1YH0+zyu9yxgg5FJE1MEefrDfuhScLRm?=
 =?us-ascii?Q?gJhLS3VSbJlSF0/fT9/8ufaCgPt0CV350zq80QrP5OSWHuoSR7+f4Bb7f4v3?=
 =?us-ascii?Q?FMr+AjlykwGnhJxDTHujO5CrPwrZkmdiZLJYAG6N5C7ehWFS/xFxbswHo0Ai?=
 =?us-ascii?Q?1tpu7FCzPZj83UPbnMfG7p4TXYQalF/QaGnM73DHI/rbzibYWkWDqZYwx3hZ?=
 =?us-ascii?Q?gS6taygeJTsnnXeb7wic4Gg2GwJQ2RQWucreFvc2U1Ue8BYrK+7oFgg8/tJj?=
 =?us-ascii?Q?ZYplnTmS0TK31Pcf6KrtjebBpa0Da9FX0eVUVWeiLHN4fZZySN7XZKOfcIoy?=
 =?us-ascii?Q?hi5e+2JILdw4fNE5tTaZwyQFaizH6mToD07LYEEnP2tAWTNCtqn7XfBVQOMr?=
 =?us-ascii?Q?ZpGDxXy1vEGaScM5ahkVBWU1nCA+YY7I9AAbcZixpPf2vsLoGvacXPrSMdir?=
 =?us-ascii?Q?IAloyCrYZwlSMZr8JSdVnv18gwWvX7Z1rLDZaaYxgvDQSP1roykO/k+dQB0P?=
 =?us-ascii?Q?VjVTE1jQIG1Fvon3I286mrf9Umuuz7IU4rjzyqEd+H/ouqLIO2/V0oBfllIY?=
 =?us-ascii?Q?KZ5agxoXcTir5Ji4OXHd+kiLy3COkOhr3IMf8JYuwXp8zWZbIlOBjRllxOP2?=
 =?us-ascii?Q?X4ocrhVfXUDYzueV4+ISNZXxKzRmWNBUGDg+UQQJ8CY5lL0ffHOCUxiDUEOU?=
 =?us-ascii?Q?1FTvT8XiHm5S9aJHn0ND0ceDcyBohb2VgUsmegZssFwB7ICGkosiEWcACpyZ?=
 =?us-ascii?Q?M/l1zZPeqEmp2Ty1IhaMcxE/GPiANB0LaDhHsTXZcnyV/JgeQ+0wnsyze4aC?=
 =?us-ascii?Q?5g0TX8Bag1L4+ouxPZY1iDRvTysHvUcdaN4v7I8oLZ6k2UEiKvIS?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A28022A0029AF4599E1711D858A88CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1757752-50c6-4fc6-218e-08da49066b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 04:21:54.2744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUpAIe8GihnEvSzoboML/mgHUpjiJhfgeuR+UUvDhuAH7lnIR6Hx/j4OXn0Z2agteLryyOnJwWQpWeoD/ZZiQGTjGgUm9OBl/Whzpgek5wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4239
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 05, 2022 / 00:06, Xiao Yang wrote:
> The output of _nvme_discover() will be changed according to
> ${nvme_trtype} and the number of NICs. For example: nvme/033
> with nvme_trtype=3Dtcp and two NICs got the following error:
> ------------------------------------------------
>  Running nvme/033
> -Discovery Log Number of Records 1, Generation counter X
> +Discovery Log Number of Records 2, Generation counter X
>  =3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> +trtype:  tcp
> +subnqn:  nqn.2014-08.org.nvmexpress.discovery
> +=3D=3D=3D=3D=3DDiscovery Log Entry 1=3D=3D=3D=3D=3D=3D
> +trtype:  tcp
>  subnqn:  blktests-subsystem-1
>  NQN:blktests-subsystem-1 disconnected 1 controller(s)
>  Test complete
> ------------------------------------------------
>=20
> Remove volatile output to fix the issue.
>=20
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

Thanks, applied!

--=20
Shin'ichiro Kawasaki=
