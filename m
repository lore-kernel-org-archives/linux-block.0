Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA6F1D53F
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 02:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719368875; cv=fail; b=p0F9rX1hsi79xzan/TyZdU74K7zyqlCmKbjjpZ5/jQLasEz28vdOp51qcFgEi1wAUKoG/im4PTqsOyCai4PMOtvrWd7r6luK43tiA82z8903+gC9SKU+7h25FQJrbWXmdjKindCyH2uJOy7dRBRKFyYcoRL5lJLVWmD+dX0yl5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719368875; c=relaxed/simple;
	bh=OaRh28oH1zIr5V1r3Xhb4HRRBP3zk7mFEUtswO/3dog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TJWo09jgAqIvLe60aXHV3HIRR29Sdw186ZX1yt9DYknI6xWkAk444fwiSUZpwmYOC5KevKIIjw9hY3vqXbXxvLktjmj7S95XcDL+42T4+qUena3SHP2Pkz3WQtxq98DtmHOgwNqWtgz1b+OnoUKRblhQA6iFYgeoVD9G8Fzo5Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RP3cP8gI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UfjT3Be5; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RP3cP8gI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UfjT3Be5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719368872; x=1750904872;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OaRh28oH1zIr5V1r3Xhb4HRRBP3zk7mFEUtswO/3dog=;
  b=RP3cP8gIAMdn0y4KgRWmv4Kxo92WFQz7BGmrg7SLDY4GwqK99VgDrmNv
   me+ORafSxtDQVX5PwmQvDPaXMFcwPegT+iPrZqMyyZojBJ+rxQlVGX1lZ
   R+MsobvveGcjlhU+eH6WS3jWD2gJKHe1hoU4ilVISmmzljYTncHITbOMH
   5owCL5HK2dXScSGBIBIPNj5knrEkK7omo7Ks7T16CNKd4CSYeOufDzoEV
   f11JWQHZbEHQmBCUWFLYVEw4fmrE3oX+i9FiLqh8gaIbLAlK+UjrZrhUf
   IBnZraX9zDxqUgyVeuprk7kgu/BrsfGFLozajY1n5gR5reZq3jkYTfeY3
   g==;
X-CSE-ConnectionGUID: OZ3MjiQtTYWRF10A/3O4qw==
X-CSE-MsgGUID: 2Rr1fzTeT9qbqqNrGCQ1rQ==
X-IronPort-AV: E=Sophos;i="6.08,265,1712592000"; 
   d="scan'208";a="20098138"
Received: from mail-mw2nam10lp2046.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.46])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2024 10:27:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBF998Y5b0BApC7vSQpjhlKdfjffniZJ+KEcZlq1tIu6CQQ0OW0tt9DwpHswkg16NSPgan1nv8UUGWbHJQfRwmDodDUItcoUhWlMF9Pv9wXI5ToNBpU3dJrz75BeXtdDmErh/cFD7pAwp3aRnWERSzF90DRqX79kXhETpdJ3Jpc9wpPAPqob8AafkY0upXbH5HclR9ngdGW8LsWwX8CPmQJLlXPI7c1QSrieqWu4fa4unK1ajP1FSKCtbFrSIPYwaWDTtmpiMmfOFbsdPi93+LIu7StmWxzCr0M8Qs5e9DYFNk/8dz1XsaLubQdAI5N2/0Gdxj0zu0c7yfHgSN30Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9n8CC196wyxgPTlJlCga74Too1wsRma6xzkA4eXk8A=;
 b=lKE7zMjKUTfddBlhtI5KXcmZ6GgLto8z59JaZNJXJsnycy7IY4wXU639HjSQ4pT+Alz0DPdYiomFjt6mMpE35laoZ9kWBa0h8w3i/aDQyvExXnj9cNLmEO9f7wkvRhrCxbpluVtUWUHsKqsv1CRWYA4sE14k/TuXdhpwe4b15i4fZG32nWX6/a8wU0CwQPVn/vAvcTn3Gx46c0Htw/Qi9zd9ByY+zPx1P5T11xSw+hJdJiu7kB/IfIX90dJwOxVyagyy4ws7mOj5XePcZ9KualY0f07k+TrfuYJox4Ok8lfnChxDKI7HF1ceD4LNOWHcDOAe/YuCWVoAmF+/rHqtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9n8CC196wyxgPTlJlCga74Too1wsRma6xzkA4eXk8A=;
 b=UfjT3Be5XojExCfeySLmlwlADDgArcV+y8wWFNjHNupbxA0X7WPE55bu8gyoB8W9t8AyHK5xpkykCuBXMWuWIQPYZMHKsbX7nNC8EL/JRP+wSohi0OXV8dGVPu+ENFKBpw7nS+k8fuo5X7YOltRLfNHrgbMG4OHnZOUVVDbggIQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8178.namprd04.prod.outlook.com (2603:10b6:610:f9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Wed, 26 Jun 2024 02:27:44 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 02:27:44 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya
 Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests v2] loop/010: do not assume /dev/loop0
Thread-Topic: [PATCH blktests v2] loop/010: do not assume /dev/loop0
Thread-Index: AQHaxvGomRv4xIlE/UWpUccZkyX3PrHYhR6AgADN14A=
Date: Wed, 26 Jun 2024 02:27:44 +0000
Message-ID: <guygrhoo3xlu2h7jcyaijhv4ygg6fiv4dvjgtxb654haoqgwrc@ob4utekymehs>
References: <20240625112011.409282-1-shinichiro.kawasaki@wdc.com>
 <IA1PR10MB7240EC86C6A11788A324915898D52@IA1PR10MB7240.namprd10.prod.outlook.com>
In-Reply-To:
 <IA1PR10MB7240EC86C6A11788A324915898D52@IA1PR10MB7240.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8178:EE_
x-ms-office365-filtering-correlation-id: 5744e018-ece3-4dd9-abe4-08dc95878fc8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|1800799022|38070700016;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?537xeMlEfQOeqM5CKK+V4nMcL+IJCkOpRnl42vQi2Ypi6/qunHaASjCXluQi?=
 =?us-ascii?Q?fYBqNPIsqVOz8pB0uj4LWf2GQP0t1kno05wWATuBfINSqERhMFB1sAenPOU8?=
 =?us-ascii?Q?zkF5KCVLM5UHAEtKQiAcrUGyepON/p/3s+E0UwBXSq5VV0heLkTGoiMeVMl6?=
 =?us-ascii?Q?gKL0vJXr6DuA/zc1wDPzDws65Y91kRaLJW994cjw1xEEMBoyzsJ57rLTzu1b?=
 =?us-ascii?Q?a+m4MclWwKHhEBR3RzzsyK4RTvC/v+aKo0CmSVXQKC+9prHkbyRb2mbKUb9W?=
 =?us-ascii?Q?syjLZMtxwaR2LBr5S3YbK+3cLpagLHkXp6zf6MXfZ9zssc19dsR/f63WE2Gc?=
 =?us-ascii?Q?fH85yNAE5elIKLa7G0a3lJBgC/d4VQoTkhlFz1Ikamw7hfR5rN2IPSgS/DDT?=
 =?us-ascii?Q?XG9mnmEFyAte/HozhUdvSpK60nehs7DmgwkK0D74PNKHXrydEOD8KG9HHPh9?=
 =?us-ascii?Q?ap5amJ1PCqITAv+pYAM296w+DtabHw6UiznBCTRK6iXBLkzYf9bo4NC1Een0?=
 =?us-ascii?Q?0nCMtKVYySvstlJfkV8sIszyJSRNE+Xw4GRa+wDzNIriDrunp7NNC4h6jttk?=
 =?us-ascii?Q?GCaVWJeCIOiZ655RWNPN7S8n5442abKvq4z156fgPbTySwvmqU3yignGuvPA?=
 =?us-ascii?Q?8FwD5YaMeVyf/44/DxWJDhdSp6+NJuU/iV9NQbgQEj7EAv3PD1JuzoRGN11x?=
 =?us-ascii?Q?1SJOyixKlQr8ElwKJIby3+iJZLg8/iNyTMhj25CvT+b9UQW1+r0mC85eLo+v?=
 =?us-ascii?Q?xi0cZk6fkdyJMmYxa2o9Tk1ww5SVHviHPne8GRK/wX8r1+Od/XBRMu9W8yds?=
 =?us-ascii?Q?aViGcua7E+xHgeso6IYiNumVP/fF/mo7a+wlvc0B+kYddvW7bx9QBrozuE2e?=
 =?us-ascii?Q?34XCbwOlXBB9987xSViENd9tZXd21jOnVPNwgmLAwg+r+x5nJeAe0O9bq019?=
 =?us-ascii?Q?xC+jp89OqAp9q6JXMwWFr5ZhSl6oYQOT6/Xpnbzb8d+TEK9o4hFu4lLCXmwi?=
 =?us-ascii?Q?paWpkTBxcfZrB/CA/M+gbMaZp/IEQu/55mYJXvtF2hVhnEg3cg2vm6WHMvJX?=
 =?us-ascii?Q?Wyp2hs/srGna96NLFgAiXZoN45tcTTUUOTWwlXebhF1mlbDVGd1OEOkeyUS5?=
 =?us-ascii?Q?QUT5mYaxSjl1rcLpIfNZtHomE/COfOQsZVaxnkAdy6abaqkxbFkIJww9ITrV?=
 =?us-ascii?Q?DAqkTDlTnrcs70dwHgtNIeFE/1PYFvb0Ni1+cMuki03rmwmggqUzLf+cnoyF?=
 =?us-ascii?Q?RP5EMAV10MWT9rmaoVpL5F0A097D//dT0HrOkuP9M74Iv+BkREyrDMmeVApF?=
 =?us-ascii?Q?YCabpJ4c7141gW6W4B8pSw3x6JKzs2KILICSROUJ4juBhRiDCtKEQwVdt2vG?=
 =?us-ascii?Q?yzr7yI+75Mzutzf2ng9sLHOXMO1csRVuq88Jce29we1wPrAYpQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ArCMbG8Grysz0S1fWpg25qf/KBvj2o5hc+v6FXjI8D7Ck0qxcvKIFdTyFcIy?=
 =?us-ascii?Q?QiCZBaJ6DWZ9z+qGEZgwhz7r4OgMW1zdVn8BFVdfncx0Xo+/JVR2ILtbaL2a?=
 =?us-ascii?Q?soR9cMqTU6VBM0F2EygBCh69Vo0Ahwa5CMOV176Wg93yp38I5zvMsXsskea/?=
 =?us-ascii?Q?+luxYWP68bHQt9BYnK1XluvnYUJwK4/tn5x0ABLdrd3syjAlUi72ds++VRw2?=
 =?us-ascii?Q?Q8fWjIWxImPTv+lRUi3kPnRP5LonZSvzx/LsVGelOmE9PDKdoMIEgOuQ7In0?=
 =?us-ascii?Q?bSR5u3GWvpxO+euVSpZ4uj1NZBOuza7HxN9xrfvUdYUs3cldbJ0k+mOYlzTj?=
 =?us-ascii?Q?NqdfVJW+2nk3UUjOVinCW+K7zDeVwDR5MMtoP5Vilb6dahvy6QLSGjqvqbF1?=
 =?us-ascii?Q?tuBGHB89fEw+KVboXV79EAKSPQxhCJjprZlmCWaxQTC3azndyK3eyOLyGu69?=
 =?us-ascii?Q?yoniyiwGUwFzxs+mSuHepYiirSmDSPs/sGFknwp+2+3DXM9nM9V1fNpVnSNF?=
 =?us-ascii?Q?F4SIrnJ6yox27EWc5Twn8YXy+KScadeZL+VBtBcRbO8Cpm5tp5p7SCkolXXz?=
 =?us-ascii?Q?js6QMl64NOulPjkFIh5Tq8NlANCwYSDimHQyRu7G2suEKl/egsYNPwew3YR6?=
 =?us-ascii?Q?5H8iIvsKBgmYFgt28AhVjc+OLWaJAt8oER3aERxbszfk5ov15igJRtRaN3NA?=
 =?us-ascii?Q?3ZBpcw1RFW0kLgU5O2bWwXee9erV5LNbO1DmRLMXKIBkG/J5EqzXl/1NwI20?=
 =?us-ascii?Q?LiHQ9KILtWGziBqx8FZBD/C9yaGXYM4hNtwbi/djhu97zPKgisCAFvlHG0nN?=
 =?us-ascii?Q?u1/cYkckQAGG3uZRybX4FPkDlQs1A4JrJtXpMCKAylVOMHk7on+3UC7jlsb4?=
 =?us-ascii?Q?SZrbvTArR7urlIXe3U0u6/rOT0T2bf8QrGs2JvqO+vD07pw6bYzJl1j9yyJh?=
 =?us-ascii?Q?MEdouGNEFFGJOAA6jDDLcORNjpKeySyU0FJWtWmoWOB7u4vTmfHE3haCMV7g?=
 =?us-ascii?Q?bnPEBddx77EKAavNh08i86GaTeLLs+UriOK6/RK72hyKJYq/FNr6KVxdX0mo?=
 =?us-ascii?Q?57JO2SIdIiTgQLKKs2fikxREt3jHWU85n6kqw86THfxUNbEAjsUJV3YRvYFG?=
 =?us-ascii?Q?kLoLiOdh7w0E674ssQbebSxMEH4eK3J5OKRQ7TGCOd1eROqWYSj9amfCfHQh?=
 =?us-ascii?Q?vfkmq3XP5otEKD3AUIdhMnMYKwn2azL01s8oR3kr1LPdhVAlv1xocD1WEplO?=
 =?us-ascii?Q?p+C7hRsOCwjiepLayGufEeBOBVLg2bQdsuK7xZ8Kv/hAktJ1FsKHGrrbmzFB?=
 =?us-ascii?Q?mAg/ZX3lvu5WtAx+JInlbwax7cKWZLtNtFCIAPnnKN0yRN57AKZzCg9vngOU?=
 =?us-ascii?Q?y45P2PP7AscfRslCowiXE3giBwQj7WEK0z4sXh4K2WRR3z9aAq9YUJbVaAEC?=
 =?us-ascii?Q?Trsvchq3QBM6vveew/5SCOCsUQb4aGZAmJgR+hGvEiPKMCdruUnMHx5I0WjD?=
 =?us-ascii?Q?B3KCKsu7NvvJCrbi18J14OLrgO7oV0wUTk3iT2USTEkKKLOvnblRlbJNpGFs?=
 =?us-ascii?Q?Yjk8pKNtAKQtlScV3io7u8UyFIQfrHjve4I366nkehR5GBWzzxIw1oObN8u7?=
 =?us-ascii?Q?jOvkDSJ5FYc6L1gEQym7Ug8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A991C6F856318478A2884F6009951D7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zo6Eqwkb2w/WdLLoSuqsNRZzbFInwSf9QWmjP4yuH+M4nXhcvloMNnOGQy3kY3yU5l4kcYJvX0T8+rMnvXCsk7zQ+UcdBZx+7ZzbrJbW04HOfnXsoUkqlYZceAYC2hIXYvoAEZQcGJX4ns8Xonkt8i4AjWvmIZ6VY7g7KFoVISzmdlh3582gKu3PsaL2tlhEd60xp2kmSUCmw24RFv+KI015+if6vKgVbOTsaQ2SxveMrt249AgwaveoO45hhOC+N+nU2XtFgpWZss35GXmh92aRltSRKbHVI5NQs6/UYuVy9W55Q3H73KjioRvNrgVzrWhUSqOxFJz0IzppAFY4RpcFjvpfXp+Qg/d73tiAGgKhbt3FNYVNHbEdKLYn9gyzQ3nseqDdIGpIBCdbUXEGEhpsynnGVffN2HkCrt1L7zLe+IT63zXIoKN0qjrt4RTLXK/TZNY+E6DVJuhfkBFOWvsnU04P3CUrTsQraAmyAJPkwqXVKd+yHa6tY+QFgeX/if0LLocFICkRLkN8uQPw0jsMwIpKpligt1BYTCHHG43EKwcTvPBIUSqE9UK8VyFLPta0m0PXFUZgOKRGSmlYHlFluqRAZFP8FEOr0KJ/O1LBjevO2zFltKrfcSIqX7zZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5744e018-ece3-4dd9-abe4-08dc95878fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 02:27:44.4709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEvjeJqgrA6yEvhbVr9gF6or+2mpk63YOgEhZiR18KdpGuvDFE53Rv0+qKVzv0gv/BTqkj5JPDtR/SWMfdbpnQQkzN5kcgcV5zbRfLlfuvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8178

On Jun 25, 2024 / 14:10, Gulam Mohamed wrote:
> Hi Shinichiro,
>=20
> > -----Original Message-----
> > From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Sent: Tuesday, June 25, 2024 4:50 PM
> > To: linux-block@vger.kernel.org
> > Cc: Gulam Mohamed <gulam.mohamed@oracle.com>; Chaitanya Kulkarni
> > <kch@nvidia.com>; Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Subject: [PATCH blktests v2] loop/010: do not assume /dev/loop0
> >=20
> > The current implementation of the test case loop/010 assumes that the
> > prepared loop device is /dev/loop0, which is not always true. When othe=
r
> > loop devices are set up before the test case run, the assumption is
> > wrong and the test case fails.
> >=20
> > To avoid the failure, use the prepared loop device name stored in
> > $loop_device instead of /dev/loop0. Adjust the grep string to meet the
> > device name. Also use "losetup --detach" instead of
> > "losetup --detach-all" to not detach the loop devices which existed
> > before the test case runs.
> >=20
> > Fixes: 1c4ae4fed9b4 ("loop: Detect a race condition between loop detach=
 and
> > open")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> > Changes from v1:
> > * Replaced the losetup --find option with the loop device name
> > * Added the missing "p1" postfix to the blkid argument
> >=20
> >  tests/loop/010 | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/tests/loop/010 b/tests/loop/010
> > index ea396ec..ade8044 100755
> > --- a/tests/loop/010
> > +++ b/tests/loop/010
> > @@ -16,18 +16,23 @@ requires() {
> >  }
> >=20
> >  create_loop() {
> > +	local dev=3D$1
> > +
> >  	while true
> >  	do
> > -		loop_device=3D"$(losetup --partscan --find --show
> > "${image_file}")"
> > -		blkid /dev/loop0p1 >& /dev/null
> > +		if losetup --partscan "$dev" "${image_file}" &> /dev/null;
> > then
> > +			blkid "$dev"p1 >& /dev/null
> > +		fi
> >  	done
> >  }
> >=20
> >  detach_loop() {
> > +	local dev=3D$1
> > +
> >  	while true
> >  	do
> > -		if [ -e /dev/loop0 ]; then
> > -			losetup --detach /dev/loop0 >& /dev/null
> > +		if [[ -e "$dev" ]]; then
> > +			losetup --detach "$dev" >& /dev/null
> >  		fi
> >  	done
> >  }
> > @@ -38,6 +43,7 @@ test() {
> >  	local create_pid
> >  	local detach_pid
> >  	local image_file=3D"$TMPDIR/loopImg"
> > +	local grep_str
> >=20
> >  	truncate --size 1G "${image_file}"
> >  	parted --align none --script "${image_file}" mklabel gpt
> > @@ -53,9 +59,9 @@ test() {
> >  	mkfs.xfs --force "${loop_device}p1" >& /dev/null
> >  	losetup --detach "${loop_device}" >&  /dev/null
> >=20
> > -	create_loop &
> > +	create_loop "${loop_device}" &
> >  	create_pid=3D$!
> > -	detach_loop &
> > +	detach_loop "${loop_device}" &
> >  	detach_pid=3D$!
> >=20
> >  	sleep "${TIMEOUT:-90}"
> > @@ -66,8 +72,9 @@ test() {
> >  		sleep 1
> >  	} 2>/dev/null
> >=20
> > -	losetup --detach-all >& /dev/null
> > -	if _dmesg_since_test_start | grep --quiet "partition scan of loop0
> > failed (rc=3D-16)"; then
> > +	losetup --detach "${loop_device}" >& /dev/null
> > +	grep_str=3D"partition scan of ${loop_device##*/} failed (rc=3D-16)"
>=20
> Can you please add this also "__loop_clr_fd: " to the grep_str (please no=
te the "space" after ":")? So that the grep string looks like this:
>=20
> "__loop_clr_fd: partition scan of loop0 failed (rc=3D-16)"

I'm not sure if this change is a good one. The added string "__loop_clr_fd:=
 "
will distinguish which function reported the error message: _loop_clr_fd() =
or
loop_reread_partitions(). This will make the test more accurate, probably.
Having said that, the change will make the test fragile against the future
function name changes. Once the function name changes in the kernel side,
blktests side change will be required. I would like to reduce the possibili=
ty
of such work.

>=20
> Other than this, it looks good to me.
>=20
> Regards,
> Gulam Mohamed.
>=20
> > +	if _dmesg_since_test_start | grep --quiet "$grep_str"; then
> >  		echo "Fail"
> >  	fi
> >  	echo "Test complete"
> > --
> > 2.45.0
>=20
> =
