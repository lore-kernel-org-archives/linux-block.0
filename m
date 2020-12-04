Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA810C4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 01:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB81224F9
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 01:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgLDBqW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 20:46:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52201 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDBqW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 20:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607046381; x=1638582381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5aP0dn8ESRDSAU2fpAKiTxf0PHUXVutP+lvMH3Pkh2A=;
  b=MdgaoyllGpn6H0PMrO4oplNei85gzg4dYXpxkxL+TFu1v6TWasslPuTp
   CJ+5CROEGa9XkfTFAfvmDB+lfYBdZGgARKuRLZwWas6V6/mVzhmbpdokO
   7+vF0O4vUIRoxIgMNFzgZ3BL/qeCwfYwKIJdFofvRghpaFGfo1UG5ZymV
   1i13KiDaKaTofA3vyxC9QiH/I7VxsW6DU30DoIk6oy2UlA5jyVXNtFUzA
   yTicBW1B6Xv9K+YPkhgoLOmPcXyLXKU4vlXX46h1cS/fcP+bPGS0KBKZ6
   kJ53VfMviijBuzlgBD0jbdBYg7Lwamm9BihnQEhZ7zn3A7mQ7UUZH4cZI
   g==;
IronPort-SDR: DVeuPITb8a5iZqYzv4/cT62HBp9fyk54ONiUVl/YGfE2aY9vX6xosoVYdsjKAA921BmNfUJHCm
 Uu4zEPr31dWB1/tq0YRWGzAJIDXwRSsFrKXWiEIKGwj6TzEsOJ/qqF0cIat+J+GBeeVGCSYlLn
 wFT0Ri2vPHCFndBnt9tesCpxrQrt6SAl23GGo6LLfN5zWbYK+1LgLOsQ99m/t5lH0oKsa5rxA9
 4wTEfGqRU8PBJGqU7DWdyIqXZ58asdc1Ie2T3QO3yWCggbI15Xt7579ORKlqEdVy0d7I/9MWft
 hz0=
X-IronPort-AV: E=Sophos;i="5.78,390,1599494400"; 
   d="scan'208";a="154460369"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 09:45:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldvtDcZMbV74K4MlhQxD7udKx4/yB1VfNpZQMVKRDZ8ZPyuoYjdIt0EWu4E3jVWtPq9GRngAwI3ikccfOr6485EDWhMbqxX7e20vTwFNjoAurJYzhyQ19l6REMjCHSYwb0cmeMANzZfOmI+1MDQHKiRBeNbVrmUAGcMv04L2TftX7noDuHAsoh5q8kQC/oU4mtQeCkyRZr8NOjB/tXXKJiSPQ+hk9SPYdCIZc7y6S54fc9J4WIw4Hq1yPLh1mXTMolGOj6LObFgk/u0h6/7qJZzw99fCX6elVf/YGgGp54VTD9kQndCva37zXQb2P7y73hv/Rq1bnsPOC6iViGP9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/GLJxUDSS8sn1zd6AIBUWQxPe7o80zrJ7H4kVkyiSY=;
 b=U+E1cDLQFeXtnzEo5L7q0ATPzzm/a1MM6aBBFXMgGna3FT2PE9BmJZF0WRnosUmoVEFURyMOgw3N+52PBgJw5xBkcgxL2KrFNaAiv8IEvvBmhhvjOn+8pIeOdg4blloRacxGcdG7l4l3JqhSuuZWLfAawtyn6rlsXxBTjnQRFougdWgNxVjKYhJn6mIerdIaS1Hrbgh7fSZbl9r5O9yDcld5hjaHsk1A015JXUePY40ded1d5KZnghM4egnDqMEyM028pHZImWjQ4GrhnrI7mQRInFb2IdyyPY2TCI32yLLy/2R65usjbSgW017a9GcepTHdQU9XhPVYA0o5zhcuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/GLJxUDSS8sn1zd6AIBUWQxPe7o80zrJ7H4kVkyiSY=;
 b=IBdu2TC11HhvRzCilkK3bP0mzvM5wAxjm9qQHaZdCgD7aKnyWzsfBFIe6ZOWXrMzwJxVeoV2EPjrFmOvdNMR/1nkkv2kIF382EhA099kzqOq6r/RB97KJFD4fDGMU7ePCivngCrGjgNpLaZoD7xvYrywFtejHHWeaG2aPNQIsho=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BY5PR04MB6772.namprd04.prod.outlook.com (2603:10b6:a03:22e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Fri, 4 Dec
 2020 01:45:15 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95%3]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 01:45:15 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 1/2] common/rc: Check both max_active_zones and
 max_open_zones
Thread-Topic: [PATCH blktests 1/2] common/rc: Check both max_active_zones and
 max_open_zones
Thread-Index: AQHWyU2AHkB9JDvO3UW/tqp49ajpE6nmK50A
Date:   Fri, 4 Dec 2020 01:45:14 +0000
Message-ID: <20201204014514.jdua5tmcwck5g5fn@shindev.dhcp.fujisawa.hgst.com>
References: <20201203082244.268632-1-shinichiro.kawasaki@wdc.com>
 <20201203082244.268632-2-shinichiro.kawasaki@wdc.com>
 <SN4PR0401MB35985D9A6A9D57B38A06DBA39BF20@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB35985D9A6A9D57B38A06DBA39BF20@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 718c1410-c3ad-4468-3fcc-08d897f63f34
x-ms-traffictypediagnostic: BY5PR04MB6772:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB67729B67005FF0869F6D1ECBEDF10@BY5PR04MB6772.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0oH/N/8uApRvbcJ5jh59hR5Njp26Pahz11znuR4semlZKFygG3PArOdi3wsqTNQWWFVp6ewAwjaPEZ12GlbC8HSK7qMOQwjYrfFlaAp5tizs9tTVeIZbbpCthikfeUjA4BBW24wPOpqxH/mLI6PQubNV3pVm2uyR54n/q1s5s/NR1mB28L2vY5KR7Rf2nhXrKn/2z9wirUbOzf2rt28vnaNOeM3FK8squi/kv9aJAUse07WZWTV+ftTAmzpoNxdmrubCzqEnH/kwFjq5XzNFUJu9vceduRBFySDi9EMsNJeIdNL9H/r8L7xZCcoHTYM3wWrcly0ASUPCMcN5c4QLuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(64756008)(478600001)(66946007)(66476007)(66446008)(44832011)(71200400001)(54906003)(6486002)(5660300002)(26005)(316002)(76116006)(91956017)(186003)(6862004)(53546011)(66556008)(9686003)(6512007)(4326008)(8936002)(86362001)(2906002)(8676002)(6506007)(6636002)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: axW8tAsQxLGUPrF0PIvPgA8iggAFgvuXELOL5Hm7a1lQIbJoQXalu91avJX/3I3vSETZTmtLZkIYfFh3Kbwkm8gZMPWVV4Rpvn4iAvqUpWWxuUpC8PDapPcp/ut2zilW0c9nDwqhe9oR1G9vaI07p0CYUBCPzw+9ZLfnMl0fFyLadWe3ekXddOm2WkbCYnISiuaxRUttKys/QSWc4/lJJpPA9PtxWfYsiNGXH+f1DO/xkiOpzYiX2ff9Nyc+PZOdvjR6QHRKP6/E7JBuGkx2rxoYZ1yvXksZgaZYF51nZu+fG93HHlnha7hW4lcQvcsyI0qZDQVyqiIWL7qDzjO2u0Ln9aeH6DRFEbprdWCj7REC8baMIEXN54K5zJadk7aqHwMQAEQHMnce1ec1v2QTRWU3iUNTR+ltPcgBbo6HsRB8obL8sKubxzTD2mqgwSgQE0HFQQmd0RSVs9DQwjjSP31xkXq8XvRCAL47TU277Mm7AD9JNjfrKKnXlTT6RuvXbB9b6tUw5DWzdl4QlJBfXxpIMflQuWYuIKdWSOEpz+tAZWGfhHAJhzxRMQtr0TUXIn3e4euEiqFib/sPYpi/RPw5oU1wKDjjbK76JeI16nHfLeyzWL6E/nQ1bu4GJmGJ+jutHgP3NlLvTpfvi7QmZ3pYK40Dx4RW1ZZPseI9rvVTT3NL7aE1PFpHBbilYW7LB2VXqjnTz9YGtt4FtUi9dzzDRyQpTP864wEeolUo3mNQPHhVtsO41Z8k4S9BWTNW
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3B8D96AA44EBA4BAA0AE170149F2949@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718c1410-c3ad-4468-3fcc-08d897f63f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 01:45:15.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9m1jsOoFPHFZdRagjeg8BnPHcFqP2wrmcdc2txnUMun1gey7HJFhclbP3aHRffJ8sVoUCmLohNEFlDCeslSYfY/0i/sSZ6pRv0NpOMZfC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6772
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Dec 03, 2020 / 09:50, Johannes Thumshirn wrote:
> On 03/12/2020 09:22, Shin'ichiro Kawasaki wrote:
> > -_test_dev_max_active_zones() {
> > +# Return max open zones or max active zones of the test target device.
> > +# If the device has both, return smaller value.
> > +_test_dev_max_open_active_zones() {
> > +	local -i ret=3D0
> > +	local -i maz=3D0
> > +
> > +	if [[ -r "${TEST_DEV_SYSFS}/queue/max_open_zones" ]]; then
> > +		ret=3D$(_test_dev_queue_get max_open_zones)
> > +	fi
> > +
> >  	if [[ -r "${TEST_DEV_SYSFS}/queue/max_active_zones" ]]; then
> > -		_test_dev_queue_get max_active_zones
> > -	else
> > -		echo 0
> > +		maz=3D$(_test_dev_queue_get max_active_zones)
> >  	fi
> > +
> > +	if ((!ret)) || ((maz && maz < ret)); then
> > +		ret=3D"${maz}"
> > +	fi
> > +
> > +	echo "${ret}"
> >  }
>=20
> Maybe change $ret to $moz and then
>=20
> if ((!moz)) || ((maz && maz < moz)); then
> 	echo ${maz}
> else
> 	echo ${moz}
> fi

Thanks. I agree that your code is easier to understand.
Will reflect this comment and send out v2.

>=20
> Otherwise looks good,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20

--=20
Best Regards,
Shin'ichiro Kawasaki=
