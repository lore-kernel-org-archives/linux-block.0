Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFD444C73
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717653771; cv=fail; b=UPudF3ETdyDx2qVPfNgFS0hIfDnMDYL9NUMzQj2Q6VBHxz/KpSR+qY3OCsSEpRsYf8vJy88fc0yQ3GauCZedv8tvodNOnS++1HDNbb0kgEVoyNKbSAW6ZSUyw8PlMH9aesTDqoBqEVaWaV+k9JhefoswDWTph9A7E2PIbXdN8Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717653771; c=relaxed/simple;
	bh=W1EsEMezDBfscQUjSnEDnnPFEf5UypCxT/LNiLCgdxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WH4USWjPoRTU+6KzzXHRQ6arYHPVe5T0o1DnVwJgZZuGzYRReBTYKXtzlbb/M6/MQMuQFiQX/Ewip34eH4uIy+aschq/gcTOyki3DU+I4Ruuob/VnKclO6g23iB47K1oKfHxB4D9qLJ+gZ+aG+qd/7gY9YhVfquUxKqzqA2fZR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kSvAZfgB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cYyKTPWF; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kSvAZfgB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cYyKTPWF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717653769; x=1749189769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W1EsEMezDBfscQUjSnEDnnPFEf5UypCxT/LNiLCgdxc=;
  b=kSvAZfgB18b//jKq07M3nZYbqCxa2bu+Tfr89M40FyY2WhBzDkFU/mjf
   j0+whU/badd3M1pK33kHAcDAw0zNTyezWibnq9Gj+FDz2a8YdOxAoLz5E
   UuW5wf/ocVi1VzfrkCRYB7idM5W62MZMi38K3rm5GhebM5zsztGiyLNiw
   ggjsEiRfpnvHqii8nXljMciOetxpWa3fuFTtrmBVFti6nmZrhKb2/xdEN
   QezOQqwQL8LAhHIl34chzmmiUAx5p0R/X5vp0SaYIGTK83gSMZcjHt04x
   fFC4Us4OOQQFK9bv1DyVpu+pXcZaD6BXd44qwlkLP4vhNL83+0TcWDZlv
   Q==;
X-CSE-ConnectionGUID: SBhXtjVXQWGqqHpLEf+W8Q==
X-CSE-MsgGUID: afTdLfDQQ5iYa3rvkYiovg==
X-IronPort-AV: E=Sophos;i="6.08,218,1712592000"; 
   d="scan'208";a="18358196"
Received: from mail-mw2nam04lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2024 14:02:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n79IW+yqS8RnD0O72M0eKwcjHQF8Lk7OTnGH3b9rpctGeqYP0InZevKQY4Gs9klmE+6oxVZNGdj0Fv1MQkPchOcKGY4gAGIqQ+AAEQG8Wc38Do7YLkpFkgg/DOHcdiMhFuBK9a5LBGrCmWCdHK6YEUdZimTbnrCBH6Y9hFFSKIjgGwV3TdT3zpFeIjuHgxtujOvH45sumsCuUj/aUxo0P2xz3YOyzyeI+PTReHnr7auKq+e2x9DL+EC4alFSDxGSMk/NJIRfiW7p03707DF5fxHAZJclQHszKEv9/9oZw84DD7xe9ZH1Fn4PIv4ruvFfnOwHoTvxzPJCBjlsgAN0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1EsEMezDBfscQUjSnEDnnPFEf5UypCxT/LNiLCgdxc=;
 b=gmMpWJkxf4aWkz2z36fAZV4Pm20RIOe0zWeLILW6Wmgz7q8D+Dd/c0WoRTDtPtmEbeubGh0Q5QtoV/hxDtXy7s+M/nfjrUFQdPNMT11/XWUf0sY0XL/2IgQCXXnNRzYSVVBTrjC5Om8q/nqCF4LLG62yrt6x7LOrI758iOLUTVcTc2P5lTnAYPF0ivMuWkwcsGlGMUFFQi+/joc6wdOBzhfSr76Ug10vlTHEJQ/3r//Jpwyfg7h188Z2//QkvtUY2LL06KBPsJKqWHqKT7eiIpcGw731xDEhJjD3wNzoKk22iUJJj8SDCVyviQVRoIU5ID92N1Ru4TLcLdbgIGQNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1EsEMezDBfscQUjSnEDnnPFEf5UypCxT/LNiLCgdxc=;
 b=cYyKTPWFyHW7CW1WJKPFRFFU9LbsTzpfD1qsDqe3Brxm3PHKPXjd/jzMSLRqiesTOGj3LEb5/zydz5Mc2g/WFSPul4dYeoIJCJWuzPa90HxL728Cn9hJQ8GesGQMHcpugzUWT5Xrf59+adecH5xfDbXIaaNGwR6i0C1qrGuWtmQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH8PR04MB8760.namprd04.prod.outlook.com (2603:10b6:510:258::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 6 Jun
 2024 06:02:45 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 06:02:45 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
Subject: Re: [PATCH V4 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Topic: [PATCH V4 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Index: AQHat2P+Ro1b1U/u0kSTKICB4pZR2rG6P4MA
Date: Thu, 6 Jun 2024 06:02:45 +0000
Message-ID: <ymanwmgtn76jg56vmjbg5vxcegfng2ewccgntmtzskwl6qx42d@g3iyvqldgais>
References: <20240605161815.34923-1-gulam.mohamed@oracle.com>
In-Reply-To: <20240605161815.34923-1-gulam.mohamed@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH8PR04MB8760:EE_
x-ms-office365-filtering-correlation-id: b0e372c2-8d39-49ab-83b4-08dc85ee4916
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r0aTjTfqFlSfhbYZIeeqz0lnxXHACk1c86FJIoTdMnLBstWLnQX/OfHAoX5O?=
 =?us-ascii?Q?497/XZrTkWdyeNcJYutRu9/BSly+1wBOV0xu7yEgMXbDV/ijbrly/K9uBkBo?=
 =?us-ascii?Q?swohxpHlFSefhVe/uFBXxgARNxl4gbGIm6lt9pgjDFCY54fSUfZA6BPI0kOa?=
 =?us-ascii?Q?Aeq2qQtKE5AlwJhRzIirqqTRUC8ztDYvOZAbZbyOylcAeQoY8CD6xCpUZ1Sn?=
 =?us-ascii?Q?SBhR4H0/4HOCKdjATNQu7aOKxIkODkjbWrruQyaFXiUJlq7b/DAwP3T3QaCB?=
 =?us-ascii?Q?721iJtAJjBe6GJjtGA18yPGJrkIov91qveqOckSgeby52lTEo6arw7e47b1Q?=
 =?us-ascii?Q?PIhTbr6JaVKQ2+sfKDVJ/ESd21ToLXfRZoEbllum5r+50Qf9VPSXvN72zvCi?=
 =?us-ascii?Q?drEdAYRic66kQ3oFt5WWTmz0+TLCCRaJXrXfYP9fTRqmOZMNcuKXJVvZZeIt?=
 =?us-ascii?Q?9KBuDKLSglrJ4gaQuC/+ofzWZ6QZVrQLYXifdgNuDu1VXyuBABInlT5CDGbV?=
 =?us-ascii?Q?nLf2klTBeSBC+Z5Dng2TsquM0a3xyPjQZDIBxz1ULj+eWYBrCFIPdPDKUyvs?=
 =?us-ascii?Q?Ui9RvYugM4I28ecbvE4XK4DEmmELvClPwvDszDaJYOSYhOJwTuEvbtTV5djz?=
 =?us-ascii?Q?tz+yXW1/PM5c/+LEXZia75TUzIaaVU3uT26+RFl8ZNtr5wGAD0PGNc9YKXlh?=
 =?us-ascii?Q?8p959/D7HUvk/XPG/BIMXclI0ysyg11DLXG1DZwFisifpZnpz1vCLrUkbMNc?=
 =?us-ascii?Q?h7De0peRnMEanfrvxJNscHNm0Q/wZk3I5nALBaCPd3SOCrRgszhck8xUZbtU?=
 =?us-ascii?Q?QkhTd+RjK4VEvEjxIajJ9/bYFTP4/vQyMJDER4q4PsVoAKrcwIiER7qSIxgT?=
 =?us-ascii?Q?I/YcQlruH8J8nsJO7tcA1xXKxaLTkex/Gf1LbIAeAXPiQd/etZPK/XHuYtBX?=
 =?us-ascii?Q?yG8QbABtkfrhK5NZ2CfnTstQkf6/dQpRUSskIsjrC4cC8x9WSe5ZmHcr7tJr?=
 =?us-ascii?Q?AaIpU+ww2xDlFwqElx591un743r1wJwfuUs2AygSBG69avxCam7t59E9miKv?=
 =?us-ascii?Q?sYlOP7wbFOo2vud6nhajDKixI61kJoEkA8r+0WVCf7jZMxUkqLiAr+GVbkke?=
 =?us-ascii?Q?DEJrGUQ6mEAE+zcczbNT4IdXtubjA5UWU0i4O0P4XIVE8GvBQUxuKBW3Zl5p?=
 =?us-ascii?Q?DT0PKqZftQdBl56s/ZeaTPRPCWVuDAXs9zCZnka1XL1p005t8aqi2S3GzFdP?=
 =?us-ascii?Q?U8FfzXT3VN1gCO82hVBFRAr12ZQvT03LZZUXInxsIleQhBCPG4bWw999iVuP?=
 =?us-ascii?Q?8j99S7PZEMCe3ULBZutIdJHALPUwl6noeI467t7U+aa9xNsONpN5pFQW05T+?=
 =?us-ascii?Q?i/PywJ4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0erG8NMvUKWzCKn4Ua6TPITCdS0c3bhi98HMjVJvn+rdt9chqSc+4SniEaW+?=
 =?us-ascii?Q?AK2fL16T/Pfkr0Qo+uVxzGhsA1Uek7CDSH6TgjX6k8lsdTQl4md43J/dDzwv?=
 =?us-ascii?Q?x86sHmtrrgryMbu6sc00GmxdJ1xpkP2m+CNM2A4G4hfBMSXveo5Drkswn4rl?=
 =?us-ascii?Q?BimlC6OzpsE1yoDuvHVQ2nr3QSgUq1/9nsTzyjpXUXjzOCmZyyWj2UkFgza+?=
 =?us-ascii?Q?Q2yVv+lgqzN7Cj8pBi0I+RbRiM3Rfhf18jwUNYFp9FqjdMZMuyYHS17+9Zl6?=
 =?us-ascii?Q?RcH0vQcuU14YLN0b6P00TyEe6P452ts6fOvVwCgOPxB747jBH9lxhJ2EKM6u?=
 =?us-ascii?Q?8LYC5vkPhhe3taysAxdd5nwfIZPGxqoYe4JuoPN1ciRGgv/6jpRbFP9Gjm60?=
 =?us-ascii?Q?zN30m5lJERJZMc8BgSu9x/7lyRjKUdneGe6/M3uydraK9yIDCu5YGZRY+ER0?=
 =?us-ascii?Q?vFnO7S1vs6BG3Iksqd8e/+O9s8wq4MPvg+55w3IOzWw2Ytwx0WGdHn15E4RH?=
 =?us-ascii?Q?qmEjBitkeTPg2noJCb89QGqNUW+LnEa/YUin1c+DHuFP8pIZ4Dyef7P38mlK?=
 =?us-ascii?Q?5bFzaSovahzRxbuB22NOf9pDe7ErR5aQ4xZqirUQfxuAFqCvgQ/33oVcXJh7?=
 =?us-ascii?Q?NiHW6Ke6Y6NUAZ6gZrVK55DeGuWQe9aQUHreRqnazheKbGHNEHacifE7Wn/p?=
 =?us-ascii?Q?vr4fkg47XhPhM+akh84Ek+qfB0aldjiiuD/lhToXFPLAWarpLKbzAeiHnTAp?=
 =?us-ascii?Q?1MG/czUyApGFzbjGXk/6hdryRZu9yOugYo/FUa/CBZ1z+qx4aVLJtkBxmZGz?=
 =?us-ascii?Q?bWTSyTi3OVaY/EwNOT5etCnaAJVHvi+0+8J0udWK+VmJBwZAjxwvvPfuIAwW?=
 =?us-ascii?Q?qRSyFqkWb0xwqjcmY3wchTEIKWV/AHuY7hA9ggvbyjpI8qPtgymQpoTRHm/l?=
 =?us-ascii?Q?wydHMQjAMDOvvLJe7EIWdJJLjWTu9pmdIy2AdFMXkd1sFAm+0/ul+1t0bEfW?=
 =?us-ascii?Q?XLFsspayxJFeYenW2GetZG3CVxv1CzScGRmX0UtOh99pRX/L05Uf6DaCkBHV?=
 =?us-ascii?Q?T/FdCNomC2rHXCp3YCxJ+/X5vwnU9CswcLRdoK4Zz8cpTrgGtLR1VhKFFlWU?=
 =?us-ascii?Q?6JNk0IgAhGcsAx4DamooEJ5bNz/pxVEWSa4WJedgygfLSbhocKa3LhdtJlb0?=
 =?us-ascii?Q?pgCTfKdpAVfu3rZTsNkEruvgWUXsKrZqN4d6Ln0mwP8cT6btJ02KyiZ7pxxl?=
 =?us-ascii?Q?GAPGIjYThYw3W4cP2dmbxxf2Z2tQTKD84oiPuSzt6HQCi+m/fB9lyAJtJ7hi?=
 =?us-ascii?Q?jNwp1Hmj4YVeMIzAKPDkidIxnPThgkx5nbuir1GugxPLgTqchP2ThJHegxn4?=
 =?us-ascii?Q?tiH0DRmOrXkBlCp8TT515o2hNAhSxxUf2fYPUlCQ8bxQsgBYSeLfAF0jh4A+?=
 =?us-ascii?Q?lYy3zHVt8wrMF3qvZTR79JUYvmiEAbvl+H1XWBA5hjtCrqiBkpIInOTJWYGK?=
 =?us-ascii?Q?01XhE0hLMNC0PKhX98dxMR006dbSwxjDo0XQSrhzbxwUn248WQUNW3Kw3sJi?=
 =?us-ascii?Q?5BHxU8z/leE91l1B67n8GFouPAilI1j3Dpjt8CRo99+f3kRHWeVypcpVF9/j?=
 =?us-ascii?Q?6S6i6rcwTXWhuHwQsU7pRLE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA9E21D7E20AF34AA0248C7D0C27374F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3UEWcoOpppbJ0osyW2q+elwORVCkqKJqBScpRCZgfxoaai/SRCyM8quAuZZ7lhpSqydYFQMFZiiAHRRv/e1TRNxYg3YhMyVqgipRh4VWQezZlY74zpODX03wRXogEGWu1+GTlRAGCdmCZtDTGichSB/QoSjOk/Y++Md7Ljuf07ysfM/yy6S6KkOB6EfSsWmoeWpcDFBPP8Fsnc5j3wPTa8Y+1ok1jvUvmGnBE6vcsSSuWbx5kcN3iXcpEocwsmfl2+7HaqeX/gNQb+CnLiZ5qaLYmjgZecwKkG+uJdRjAXpliYOzM9vmKvi6FX5hrigQJYPIaiNrhIeoJGzd3WWWpATKiwGwYSmKvR7RY65MLEW9AZLTxTa6RaY8LJx4EMmaDdkUNAgTzNbfxFQfmTCKWqusQZxTzPl9PknlkktfRIRz8w0U0MGwLXzk1KkYIuoh6DVCtGQjoJzcy/zOe32PNxg7bybA1n2Qg6nCeesvjWXwobpf4FZBN9sknVv2VRK1w/BJpvCnA2TRBjPOCseLaFwrK1Z3TVQONlNp+YdaYONf3N8Psbclj22lNAfL/lOtV5M7ej8hm9kouUPvPPgrM4gcFvFhDbgGzjrhBqjAEOTUEsb7QpPzt11jX2P//ZIQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e372c2-8d39-49ab-83b4-08dc85ee4916
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 06:02:45.2698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikG0svKMgS/DVYDxeDtgAnGBf8rQrUBlQYHX8aGHuSMN4I059fy22aYkZGBecWd7K/aPmP85zqy60EX8O3kZYY4jAUGhnqDcei44YLg0KRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8760

On Jun 05, 2024 / 16:18, Gulam Mohamed wrote:
> When one process opens a loop device partition and another process detach=
es
> it, there will be a race condition due to which stale loop partitions are
> created causing IO errors. This test will detect the race.
>=20
> Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> ---
> v4<-v3:
> 1. Resolved formatting issues
> 2. Using long options for commands instead of short options

Thank you for the v4 patch. Looks good to me. Before applying it, I will wa=
it
for some more days in case anyone has other comments.
