Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F645C07E9A
	for <linux-block@archiver.kernel.org>; Wed, 14 Jul 2021 11:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D0661374
	for <linux-block@archiver.kernel.org>; Wed, 14 Jul 2021 11:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhGNLQC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:16:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:51317 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhGNLQC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jul 2021 07:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626261192; x=1657797192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vWD4PQk16hQL4aLf3pd6yMUXIVXVwFBsaFKZD73ZChs=;
  b=m6FtNIQiQL1mHfZ+VSuN5T5POT/ZMGLEO0gWzZ9lz/hepGaWDNh+A1Li
   fo4ZvrmrPkkCALSWlwmDmtI9uCuxsop5Y2lTqB5J9/gjjlyk6kZ6PoOki
   ngMEflcRydqfaoJPEmLA/sSemEXYwtGYCNDPnnpPbYseF/+syxXMwRAcI
   N3XY7KLY99YjoNMX2V+zpLvnnrwPzWuUXQG3hxK9CN354dUscljL6InSa
   2SW0IqksrlrHwqF55oKUi1ajCqouuKEamWuUx73itSRFmtmU98gkJHCvc
   gnQ/IayL1JFM0YJ6uQbGTFOTT2mrjiPvK3H/DRctKwhvo7V3o1jvTUDHo
   Q==;
IronPort-SDR: mA+qISgHgemvfINHLTLmjQOmScugmjMCFU9oM+TKIbW95V2JU5U9wjlBBoSQa2DKR4BZwlhDjy
 5s0JT1aYiNe6lEi3vb/fGQ1BnANcOwgYONyC6kmDlU3YewyeGNj/e8eRb2+PPWc24bXpCquh3O
 RrP1leQkKq8kI2gj3CXJopldJOLhrnDGxvSh4IYe6QajEJEWZHVK0aRCEwqZZX1MGvVOGsg26N
 czUkGu3iByk/v+34tCdgiColw18oHNGBRzLK7VjSo/5YFDxAv/J0UpOz6kPKwiZUy47fSuir2f
 fSA=
X-IronPort-AV: E=Sophos;i="5.84,239,1620662400"; 
   d="scan'208";a="175122388"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2021 19:13:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi4z9b2/eWTkJ9oFE3HVQJHjVPQz6AUJsadQKNamjX20tN58NFm7dJg9dXDzgo/6Acu1OMjI2ctfQkCwgHBq1a8QhTJ5Y2b5TG7cHjzbSQ4ppqGVogorIqk+JUU5vReUqPZHNb9SqwikxlGTD494IzfM82LBvTtaIHlu7epbUlz4X0U/a0YEPKx1nFc0MWXusj0qRPiZKxtIBWT84gPAYgbOOhxIRI7B9NE/Rmbi2pXfUN/8QiXAWwBj6AutDAAEyGu/0rV305MK6yocLaIC62uTgWaBsk1t8U5M4c3jPgWdM0RpAe9OYQhvWY+IF5OxFc/IavSRnz7W+YWK5tU9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkDmuZZsHpDRz2eVp39u75PnKnKS/QgCDQeNZSKFbRs=;
 b=mbVkq3ulVnz+PlPkVHq3w9HeY8IntZOEZPmY976UhtpFMDK4+q5yHnMMyUTNKZXUj3tf3InMVFn7MxRg9zz/bRakBKiLa/g2/fydSRE0z6e5gVNVWKSlOymwp/uSVn0uWOxODS8ukIt2LXEnOoVYIaFoRPYGrAm8gV6tQ1FY6pCjcUc9iHvbBiGKRt4dRotulHTDvYZBKzpfsOaL2dU03AlV2odyNmjMGi241S7PCx/RE80EZO3U/WDIWzgXOl61ao9ND3iqj11ODDmI5ew0lRRscAjh2wfqZyjP7XJl2gn76fu9k/pP/33aL98O2CpGlb680ZymZxpZ4llxhxtoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkDmuZZsHpDRz2eVp39u75PnKnKS/QgCDQeNZSKFbRs=;
 b=jcctYIkk1rQnujFnnoRQPtIm47LOQL732ih9eNb3DfWjmDo5Gki6ph1IeWyraGMZCZ5OuhD/gULun+1ApEiDhJtthK8ml9Udb1gs72X4UYjs+gWUrZWv0wjqhxkPuVxhn5v8zEq5o/i0HFFye9OmYUcRYR0FiRYaQ9JlzRpDBv8=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB5206.namprd04.prod.outlook.com (2603:10b6:a03:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 11:13:07 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::801f:2817:2957:5625]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::801f:2817:2957:5625%4]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 11:13:07 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 1/2] zbd/rc: Support dm-crypt
Thread-Topic: [PATCH blktests 1/2] zbd/rc: Support dm-crypt
Thread-Index: AQHXd8+fpW6PtIayCECHSWx11Pv5RatA7xYAgAFjuwA=
Date:   Wed, 14 Jul 2021 11:13:06 +0000
Message-ID: <20210714111306.lyty7pekcqygg3vz@shindev>
References: <20210713101239.269789-1-shinichiro.kawasaki@wdc.com>
 <20210713101239.269789-2-shinichiro.kawasaki@wdc.com>
 <17ed9d08-ecd2-abb6-544e-33bff88b7504@acm.org>
In-Reply-To: <17ed9d08-ecd2-abb6-544e-33bff88b7504@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61094f98-c274-481e-1ce7-08d946b85b64
x-ms-traffictypediagnostic: BYAPR04MB5206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5206225E9ED7980AC743AAFEED139@BYAPR04MB5206.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qrBFTytPmEj3Ws/yHQ+3QvYf8bu6x6Cuc8ILPsP7lRVTkErgoCyPwDBua0Zi1UGL1tnQ3MoObVw987YeGDMTaCgPvLLwRYjL/aEnm6/VE9KbgQJx1i6qBfmRJxT1WG0UcPtqPFZ4mTjKmr3aAiKYLrbVhqxRrQPYlSL4qMxlVoZQYh3lRp0gdrAm7YHkeh11jITbrlO93ezLOJ/B1JLZYjB7SAe+qwxr0SfShIeV61NKcYFc+7Oi9VNhTjtbMTq0g0fv8TCSAhX3s7/H2Qllo1shG+Qv+dHSML0FtnkR4JrxvQBxSuBLsFvzOfQXVD7n6owHbjfOvOcNtpEBdKiawlDdfrDTLsAz7DH60h5U5T1EExny77FUZblyBxkD/1NGFu1sUV5JDPAwK7gZ0vdhlBe65ynmfDdoUtuNH12UWkEgLPWUdqHCHg1x+BhfhJ62pj3G8j+b/rBIqOaaYGUp77Se3pLECtKlkWPVEdoPf0X941wRxsMlE9bcuQgWsKKJQiRMMG34FJY7K2/b6a0qYho7YMO6maprdwX0FuaEfGiFa+dGY/OomRuXWncyNc2eY7/E4R/BgWeu9zRdWJJgPsDI72YoPpPYX/cmE8cooderSR1TrD+N2Oc/CcuzkqnXiye8M0DPWfYG8wIS9CRPJ0rEjKiVzWipVXkx+qfsB7wWCJR7rzz+tB7ovGuWsf77aLMjng8GgIOQjGCyz19CvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(376002)(396003)(39860400002)(136003)(366004)(33716001)(2906002)(6916009)(186003)(478600001)(76116006)(316002)(91956017)(6506007)(9686003)(6512007)(53546011)(86362001)(4326008)(66476007)(66446008)(64756008)(66556008)(6486002)(26005)(54906003)(66946007)(38100700002)(5660300002)(8936002)(122000001)(44832011)(71200400001)(1076003)(83380400001)(8676002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+EH5V+uxftICK+QaiJgF/YBhnm6axAzUKceIycVg17/ObuzY0utdzJsgBIuL?=
 =?us-ascii?Q?yJ+2BwBpkGDeUjZj5Jl/4v/AkIx2h2gVc7z9PzxMf6mj52Ol5REHLmaDo2Dd?=
 =?us-ascii?Q?F7hNPFiAb4IRCGpUvx+cjkoAFalugWzh9QcaLlc+WJ6oW1NQBZWo1iJQ0gs0?=
 =?us-ascii?Q?i7XNxMFiCWzS+eHDrBLeMa/w+RJW0iRy5zy/GKtFjs47iCsM6dLKli7Tgwsu?=
 =?us-ascii?Q?+Vwj7rk/R47mtt455g8JFaZeDSDQN7sz9SnPTHpnXX/1PNgLtjCU1JtwWM7q?=
 =?us-ascii?Q?5NBqlYgE6XS98KJNDM3v15/ToJP2O/DJcQw9M0XKOrmu9A4UQtTKx/cDaZf/?=
 =?us-ascii?Q?H1IrJLJWAyxniX/7hXVLNiUb9LvVy3N2pRqsNbm4P8+QuhBpd0NjNbLWgtgq?=
 =?us-ascii?Q?Y6JDch5Wa6tv6fzBy4BJCPPiPtTQiZ2FNiTLmUjQEf7z+BfqghAEEnaegB6t?=
 =?us-ascii?Q?KdTnjOWGGtxyFyvw6PILhKoNt5EtqlvapOlIuqY9LrIxx/7vEfXvQA8lQiBT?=
 =?us-ascii?Q?+aa7ZdjinCZKog3FvZzV0KMlgL0ocjbl+zyzy2ZTmo6L8I36iK//UxKWIr0r?=
 =?us-ascii?Q?gnIftuVM0rH+rtawV8Nw0qpXXra+A0e55Ze671Rs9gRkfBVTLw6XRzgLN7/s?=
 =?us-ascii?Q?WjcTSyG6gyqmHmTCm/iEfSzgjb3EXFLV4olrh2+Dchd3t/bfviYd5rWIfnbq?=
 =?us-ascii?Q?pZb2lFUIyaCSkeUQRP48c0craUJf/AAR3GD5Gz8kfzzebImaV0eFWpolaZ8V?=
 =?us-ascii?Q?95fU5UmnZFH9HzWU8UZZxzmV3Sf1MXUFclllhlF2MLhhrxPkltgGzCmVO2si?=
 =?us-ascii?Q?dWXUu8KFEEF1IkPsnqssXqGXn2sJQbfFfgt9rcs32gWTShYYLaqjPKE+aBRy?=
 =?us-ascii?Q?B4beMOXgyQ9fnqF/P3jIQmlVK5hzaK+XEAcmyWObzuAU9APOuOqJdUO3vhAL?=
 =?us-ascii?Q?WW8r8/zjdbWif4o1szEETc2hWn/zROSDkwfvek/do4hSDmpmmVhs3CtBNejV?=
 =?us-ascii?Q?r/nuO4aW2ItHEbFFeSF8cto7fbaSw3W0HZustCQ9mZoXklVhImdp+vSIFoJn?=
 =?us-ascii?Q?1e8POKD9VbsSvY/itHtNEIRQt568N9t1hnmNc/CkBb+nw1tTsQLUMDbvi4dm?=
 =?us-ascii?Q?+Zam0VFqmTRHQ1nuD04K5dKN0wLV92PDtytq/M8PGwOLE2fnYrNoeZowLXPg?=
 =?us-ascii?Q?g+T3TMReQac8A/Bjyh3d8i25KNPxezcUR6/Qv5y/6Z67DL+oI479nQbYyDqt?=
 =?us-ascii?Q?WeODfrNsO7hlgT7ZmPX0gsyPRJBgN6vLba0I8P8FVlesxoVI6UH+FIwYGKfc?=
 =?us-ascii?Q?Ws6IWnQqu4UHmwvVh5/gT7gf3p8UuABGzWxszz8Pzhywgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD1C8E1AA87FCA49BF2D6518005F7397@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61094f98-c274-481e-1ce7-08d946b85b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 11:13:06.9844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kiPKdIymTB5PfduvYexjuYAkJ7S+fhQOKpm9ekIykNPTXXTdeXLvkW2oJlZtrRx7c8z/4mU8jbcwgAP/TJhVlGV0ti56uowUuSqzvUOE8vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5206
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 13, 2021 / 06:59, Bart Van Assche wrote:
> On 7/13/21 3:12 AM, Shin'ichiro Kawasaki wrote:
> > -	# Parse dm table lines for dm-linear or dm-flakey target
> > +	if _test_dev_has_dm_map crypt; then
> > +		dev_idx=3D6
> > +		off_idx=3D7
> > +	fi
> > +
> > +	# Parse dm table lines for dm-linear, dm-flakey or dm-crypt target
> >  	while read -r -a tbl_line; do
> >  		local -i map_start=3D${tbl_line[0]}
> >  		local -i map_end=3D$((tbl_line[0] + tbl_line[1]))
> > @@ -355,10 +362,11 @@ _get_dev_container_and_sector() {
> >  			continue
> >  		fi
> > =20
> > -		offset=3D${tbl_line[4]}
> > -		if ! cont_dev=3D$(_get_dev_path_by_id "${tbl_line[3]}"); then
> > +		offset=3D${tbl_line[off_idx]}
> > +		if ! cont_dev=3D$(_get_dev_path_by_id \
> > +					"${tbl_line[dev_idx]}"); then
> >  			echo -n "Cannot access to container device: "
> > -			echo "${tbl_line[3]}"
> > +			echo "${tbl_line[dev_idx]}"
> >  			return 1
> >  		fi
>=20
> To me the above code looks like code that is hard to maintain. Can the
> above parser be replaced by reading /sys/block/*/slaves? An example from
> my workstation for dm-crypt:
>=20
> $ ls /sys/block/dm-0/slaves
> nvme0n1p2

Hi, Bart. Thanks for the suggestion, but I don't think sysfs slaves attribu=
te
will simplify the code. The helper function _get_dev_container_and_sector()
requires pairs of 'map starting sector offset' and 'map target device'. Dm
table provides both of them, but the sysfs slaves attribute provides only t=
he
map target device. As far as I understand, the helper function must parse t=
he
dm table anyway to get the map starting sector offsets, and paired devices.

--=20
Best Regards,
Shin'ichiro Kawasaki=
