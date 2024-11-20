Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0D147C79
	for <linux-block@vger.kernel.org>; Wed, 20 Nov 2024 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732085987; cv=fail; b=qLXlODbYnYysFhAXNvlTDmuESxPCfijDoRqgVE/yiKf4fNvr2v6trS43sxtVhGMvGs7BGVIRkrKjfToQAl6uv/grKu31MfmpUn/ygk6fcb96iTjPYbJCZfhale3/pMB+dqu8Qmf5JItH3u01MaaPnXveHbOth+nGz0vVeSgiWUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732085987; c=relaxed/simple;
	bh=AkrLdU+Ar9U2i3N/IMkCh9kCPDZS13va9l5yoktR1Rw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ea5/jFzIxFNrVvmfr75PfvdiZwTEselF+cNV+3n4290k3N/fLpxUai0jcMi2liFZNkzSXKteOhBYdLKeWzATbhxXlzqB9S0p5lKRsFicwwSR/2zYmasnbfRH1lEeLD99ZMKNn2uFy35V24huN28KP7nIwd4mwviC+2MLmyKmGQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ajh6pt9R; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=legbBxwV; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ajh6pt9R";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="legbBxwV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732085985; x=1763621985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AkrLdU+Ar9U2i3N/IMkCh9kCPDZS13va9l5yoktR1Rw=;
  b=ajh6pt9RXHAROh7nXsQchhBBNCmyO8LNcWYiaoVZRDVkCUyhTvZtUxcT
   OOZQ4RvWKZoiXZMSSePbe305RoIkN0jqbtIwGmAEWArKJ9XhJD3iB0RYL
   btqPWGouh0lkJqRst5g3umKxdCBjooop+VzLwSIXt7D2afGb6tifYjBfR
   9bcSJ91VifLtQPlRoTbtKQjEnDSqUHDZFbeITcn7jrYFoRkGj829srAYq
   rgxXhgMVbC5+Mcdb7isQ3fKA0g9++burbjx8+5wYhxLuNHn8XxmGh0akv
   ne1NprOaiXblMVbfeZ2FvUnWrgMyz1aN93MA/HESTlwzbJXZCtr/hupCA
   w==;
X-CSE-ConnectionGUID: /n34Lxw5QjWjv+2kg4gApw==
X-CSE-MsgGUID: 7aod3IWtSKKXJn+H4mJFVA==
X-IronPort-AV: E=Sophos;i="6.12,168,1728921600"; 
   d="scan'208";a="31830136"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2024 14:59:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qECsebBQtj6tUlOXyfwkWc4zUawyGAeYANzvoVoHzmkzSYKM+uTd727kerO/Y2co/RlkivJPNH2/z7FlSg0y357ZYL7BC6QSex2zGHgau0PAfuxAej2RyFKnRUE1YVwkTykSGB6IyIQjBcjfaq4POUFfRHGSQ763ANN4TVqDjPj4jK+E/PC+H4wy5XNrSd47koqXi40XQDOlf8OCG7/es9XHBz0jr7FyCElW/vm5SV9+/rMNfjN+qzDcC5qTLb+sFir3tlvqml3/cB2gk80T1pzttLXxzCkQC6du0VU++KhIDaVe6Q/fPU3LYlYsFVVC7UYWQTB8YVt1DZpCDgDZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZeaRxSR8fsaypMVix1z2yieWhpVN5JBJ3xkQK3XM3M=;
 b=mqX9ynSjNU86AXu3NArAG4PlrRhLCpLiwS6ppNigOoFF3n4nvmQf38mkIMmO4yZYnUJDlSklMiQHbogfii11H4Ry+9biWrdjaIinYgbvamya+Qa/8oHm2Qt8h3FYgPMzsgzoTG6BKLL8mpExaZXBwJo60LpgFTCSK/1IbpadVSksYIYg0JTIa+3hGhYCgzFNMB9RDbbAa4PFGf0y20Qe6n+FVFByURWHECsj0QGSCmZg3HCPzFSAu5Wk7oTmX8b050ybKpG5uatv+fwuEoUoiHlmZfl5vCTU8GYiuHOQydbBx+ot2+pxxQMXMqheeyAafZwAc8/EJDskUNadfUms3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZeaRxSR8fsaypMVix1z2yieWhpVN5JBJ3xkQK3XM3M=;
 b=legbBxwVIL151YwRJJ0NISvFxO4A3F5SOOlsnm5DxlIV+ZgUdV3XmNyNwRY8T5uP1tkr1utZiN+owDVIb9updg2U2GMHKlVUtXIqeK9ly7JeSpnUrYne/4mN9jWeOAaJ9ku7rMV0ctiI82GxGT1Byn7ONvlAS7Tnl5MEqA3n8/U=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8555.namprd04.prod.outlook.com (2603:10b6:510:2bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Wed, 20 Nov
 2024 06:59:41 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8182.014; Wed, 20 Nov 2024
 06:59:40 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "hare@suse.de" <hare@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/052: don't remove the def_nsid namespace
 during the test
Thread-Topic: [PATCH blktests] nvme/052: don't remove the def_nsid namespace
 during the test
Thread-Index: AQHbOvjH2ffvwQEAQEaCDBed0TPE/LK/vZgA
Date: Wed, 20 Nov 2024 06:59:40 +0000
Message-ID: <wdz3ricugh365t2vtgqwt3x5u364g33gjku23zzdxo5lvj7coj@lide7mm4v2kg>
References: <20241120024925.1397864-1-yi.zhang@redhat.com>
In-Reply-To: <20241120024925.1397864-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8555:EE_
x-ms-office365-filtering-correlation-id: 1212366b-d0cf-407b-34fb-08dd0930e7ce
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?elqfZuPKNA5SgFyYwpPt2+Kbd7/wNavWSPckzRCgue9uIm1g5UKaesMfoi3B?=
 =?us-ascii?Q?lxCEac3Y0Qonb8uJjboumSqlBAzw0kA82MtnuUGWCrw68zD4wzy7n/X74S2R?=
 =?us-ascii?Q?52ZLEKes9M2dJDRvXkHzRq7z86bG58fH4YDrI4izt6L1Af6yZXBcKUbXPo7c?=
 =?us-ascii?Q?Rk7AZuauzUIWZp/nHJPL/Mem8iU5PdiJHxTGvIB4dZigCxEnZHb1D/BsImNW?=
 =?us-ascii?Q?o/lmorF+a7cs+wb3VxXHJ1LwSWnF+6yWgLiFGiIkH0oSxutD8uQI+Kh4N+cC?=
 =?us-ascii?Q?JkIQ4wDMpub3IGBZfjjDvL2nx8tQk98dlbrOXNPHogWxPdo7tLoV1jEER5ZD?=
 =?us-ascii?Q?5lc0XCc2GwVkienD3XBAzPS+cCVnXrHk7WqA3kd6FRL7tt256B3co4otE4y7?=
 =?us-ascii?Q?vUn3dH96Pmnqi10VfmxhhaB+CgRRFYsVCNtofmYq5NmiQUwBYCNF99R3MZkc?=
 =?us-ascii?Q?HOrS+e2nN/76fNgEubesGdlEE183ZZKZWA3A+XG+mwHxKKRDd0YcLXTO81Ue?=
 =?us-ascii?Q?OtA8rcJ4HnRjxhCdB6pztmS2ss2z5WVzlRrD0fB7TobcHl9Ej/DG30aLlyL+?=
 =?us-ascii?Q?1UY5Qv8ikXKricyAz6CekEyU9CWsqAm9vv6N1uGzPMwPBqRzrGGtMIuZEiyz?=
 =?us-ascii?Q?PVtBvs0MWBN8BmhndidLSHfxzyoNGg1MED9+n22LUnKs2v+r6wdIFw22QPQZ?=
 =?us-ascii?Q?8UuMMUNtqMoVfTq0RP4ZqYljnMJFdmdevPte71ppc+U+9uR9bz8Wtn/eLbwi?=
 =?us-ascii?Q?CPYWuV6UKS4HQTUCJSie50L0eJzJwTuvZ+i0XePRjF9F7gMsb/qKMQAhTFJ4?=
 =?us-ascii?Q?WcWsaq7bHNPSvXMMw8g5rY/02O1k4mOeHD8JFARkSHdXptIbyvSs9r7LqNSU?=
 =?us-ascii?Q?MtXPLaIlHcgrHw7UsI7ejI2KQZkuhLUyXWQ2CTZKYnptW6Yc0TgxOHInOnL1?=
 =?us-ascii?Q?vAXJgeoW+tIUBGz8Mf/mWRZIHCkrA60tahCew7chrIN11sT61y6oL389lhiE?=
 =?us-ascii?Q?79g0DLU5m3PPfkrk43T2T5gXgtE4JcXSiNnFM1CKcx8Owc4kZPRTXN8t5ZAi?=
 =?us-ascii?Q?2jHEyNUIIaK+XcD8E54RoJBHRbPJGhN/ETu9uweLVmet2xMJZWGkaiibuUiw?=
 =?us-ascii?Q?noDJcMnqWeYDQwGsoQtFJ2B0JpcWh4bN9FkDJMEMjUA1kdIEilHMEVffivS6?=
 =?us-ascii?Q?X6wSi+04tzhP+dk/8v/JSzexiIsP8hq37ojj7JHqZwWrLDoXj6+YNgMXqpKs?=
 =?us-ascii?Q?aKrYLHCKJTs9liwKvFGBfWsaBVebMJOqj9RKcCVVigHtKYf523ttwFPl2jji?=
 =?us-ascii?Q?4RcNYz4CgR98TRv1ODqe0daHImBj2pD8UynRVVAV+XWbmsuXpT8ANwTNUp2t?=
 =?us-ascii?Q?6ul5+GO4s+l+Yy6OQRTNQlOXQojc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8VAQM46HxDjWOXH8Dq0Wd2/kdB3v8oYdW5xbAkSUqCpQqMChxqOuEcof+0PL?=
 =?us-ascii?Q?TmF9kjNGpZIEqwISAuzb+R3WyiS4aYFs0VUzFb6ggQs7lABoITryxqKWkHng?=
 =?us-ascii?Q?GN/nDmzJxdpod10vklV4Zu13o4zQoviU31fFjnhIrZ7tiiWYQP1yHvWInzIX?=
 =?us-ascii?Q?JbBE1O5pOlgxEDK2VyW0riIfVPfFtwA6Wo3b9hGACfTpSzLlrbQR2i/Ku8TU?=
 =?us-ascii?Q?9Fie1Rxh//lUb6fAgJ0QpBwkorIyv7/vtlcKd2GCKArwfxZQVzhp3pjcE478?=
 =?us-ascii?Q?Uw/PDmZoU7rVcIk+IKVNlBEMtc0Usu5XnIsxyBSJhciU9hb6qfhhsi6yUEiI?=
 =?us-ascii?Q?X9wggfaAJx74vhvA89QFA6hqvLs/knYzHaWrHmzL9TgUDdlXslohbXct65kB?=
 =?us-ascii?Q?xJoC2SUsHLqjppS+/abmlgoswUZB7mXI8PNJnqNeeFGRXyTDqdVlwGKQigJA?=
 =?us-ascii?Q?v+V/jBB4Ui7KZyAbtI2riLG67bCiSU7DiQmoGs5628NyRyIcFZOCVQTksrBb?=
 =?us-ascii?Q?1Fp9OBUQ1G6mGoh78tIWY3sq49mSKGr8NU9OpU89bcoiWleHkhYPeUWet1gJ?=
 =?us-ascii?Q?NjxzKs48zrCbfTjTg38ahLuJcJVZqcHIbt9rQFOEb3vvc9WaR7//TSa99tfl?=
 =?us-ascii?Q?8Phj8cs04BtXhQ7soZnnDFLYrKZ8B7I8FcKxFnj/Xu/LePIEHw4SmPlPcC/O?=
 =?us-ascii?Q?VwQn374CSdyUkVu7gSpm6khOnd4rLcdpeFCgo/K3UmhlKqWya+yoj+lvrWL9?=
 =?us-ascii?Q?+9u1aNUU70LykarF6XnbotCKTwp33d2xX9ylId7f9JbzIu94jc2wp0CZzagd?=
 =?us-ascii?Q?zMPnQET/CSJxnlbisDABXirKKI6Vtor8gXem7DbTa/V2vGWyCJrmdFDM+FEB?=
 =?us-ascii?Q?4yc4mep5fD3BWjaOBHRtdJN2tp3QrKH2UbPoF1X33KC4AH/rRNgY5g43awkN?=
 =?us-ascii?Q?ENFmnCscF+CZQBsmqRNJbXUnUPrzDOLBDe7VejzqFFK9LjrDZ/RZttNVZKjR?=
 =?us-ascii?Q?GrlRCjImBU0TftZ+Vl/PRengKB9sELjcOhtTo6zpxEmdZ32kC4hkL1WuQu+V?=
 =?us-ascii?Q?9/A2x9KjfPUlXp1S7nfxySNFtSpQPUurubkcd47XrfcR2nEomjMdORz/Xrr8?=
 =?us-ascii?Q?lIRWnXNif8ZePR8URxAsCdT4ZDbWPGkzvuyqDgFa2Y3TkOfZLWY8m02DkTi1?=
 =?us-ascii?Q?T/RnUuh87rV5Of7pVLMO2it/GDFm0Z4AmJZe8DzL91sFqPiLxSbQ5Mv+CAYQ?=
 =?us-ascii?Q?QhK8KHqlucWR8W5AfnDibSB6wbHLswvLAgCdL25bqL97jmPWc1KADPKTmN9n?=
 =?us-ascii?Q?WBRjVk4DkocKPy2BC15jbgiQC97y0g975bggUkU59OITlHVWMfMhaScoCP++?=
 =?us-ascii?Q?ZdH5gPv3fgxGNA6eWjqDda77fv1O7B4bCUvqo0TG6xkFR//p/17m7heyn+bz?=
 =?us-ascii?Q?O/3gh+tParpokk0OKRlp5BGyY+6/0GL31WphvDHs0Ex8U6TVquIOD7CirBmg?=
 =?us-ascii?Q?6i3pX07n+ZliiQo0lwx+jrkiKWYQM0KtrPOMqAZE7JGpqcpXp3xK6kCkAS98?=
 =?us-ascii?Q?PGSkjAVR7REBTgVC2cqQjjDEVli8weH7gDCNoF6ce3nCYR7M/4jq7sEYDG3w?=
 =?us-ascii?Q?lid22JfCY9pu+prowj4KFdw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F3BDD32FABD954AAC7ACF88691C04D7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PmPEaN34XOUOL8UXbXLGse3yw9uGPku4H+gdiIH4946prYOAiXCNTaM7ccaeuIg5ystbvz7vloz5udjaOMlutVOu0wfbXH+22AcADsRcpAvdLCGb4jy3v7Pxaggf7+JVn3br+lrxCuGgIdJmICHXDGghVOAY7JMjJ142+ZHrjyDxAqLR5NhaNAX0dyzDQepwqXAWW2sABDrJa647wMwIpbTNhMLQ1c5GaWlcW2fWoaNGxq+WAKNKPzRDAcJE4yWF5eyeL1EBA9W1QY3JdDYcR7TTtvsJ7xPC3OJb99Puadomkk1LzQ2djqpwr6abjK9DlMgs9V6L3ovfG0JnbP5BGkLdMxqZe/YUcrTyuz1g7LVu5WavC/4jghSswuq9VP53yNuaheuifCNsrE5zH26/8vtRo5BqDSDMJnI9WhkEqHpmY9B5oaNHlMXVq3YpgNukBMSDOKwDUUw/shYABae7mq0QmL0VHV+ekzqwejp2oliuxFerq9pdO9d58tnrlTiCJT+mlSWFDVAmIW3tcdZQMTOvZTX2a1E8Eh4o8IXI4h565Nz7TsRV6YJiK7IeKIsna0m/e1V5sJjUkv4V0xhZadq/cYrZq528BJCsNeAKZkzArChPetxVGpk5HGYld6pG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1212366b-d0cf-407b-34fb-08dd0930e7ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 06:59:40.7980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiDH/ze06JxIJ0YrFZkC5BXDTl4WeiRkqERDT5OaOTvlXQBPQmf5KIhco5yChemuGSuNZtKWk+3s+fQBCjXjB+Zf0O2c9Cbz+Yce5rMuOf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8555

On Nov 19, 2024 / 21:49, Yi Zhang wrote:
> Skip def_nsid(1) namespace removal during the test as it will be removed
> from _remove_nvmet_ns during _nvmet_target_cleanup phase
>=20
> $ ./check nvme/052
> nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subsystem)=
 [failed]
>     runtime  3.273s  ...  3.299s
>     --- tests/nvme/052.out	2024-11-19 19:29:36.873210200 -0500
>     +++ /root/blktests/results/nodev_tr_loop/nvme/052.out.bad	2024-11-19 =
21:29:26.016088521 -0500
>     @@ -1,2 +1,4 @@
>      Running nvme/052
>     +common/nvme: line 635: /sys/kernel/config/nvmet//subsystems/blktests=
-subsystem-1/namespaces/1/enable: No such file or directory
>     +rmdir: failed to remove '/sys/kernel/config/nvmet//subsystems/blktes=
ts-subsystem-1/namespaces/1': No such file or directory
>      Test complete
>=20
> Fixes: 67e25d7 ("nvme/052: do not create namespace when setting up the ta=
rget")

Oops, thanks for finding this failure. The test case always fail on my syst=
em
due to the other kernel issue [1], then I overlooked this failure.

I took a closer look, and found that the failure cause is a missing patch i=
n the
first series of he ANA preparation work [2]. I dropped the patch from the f=
irst
series, and planned to include in the third series. But it was required for=
 the
commit 67e25d7 above in the second series. I confirmed that the missing pat=
ch
avoids the failure on my system. Will send the patch soon.

[1] https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w4623c=
nxj3knoobfcanq@yxgt2mjkbkam/
[2] https://lore.kernel.org/linux-nvme/20241024010025.2216242-14-shinichiro=
.kawasaki@wdc.com/

> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/nvme/052 | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/nvme/052 b/tests/nvme/052
> index 8443c90..2ff9e53 100755
> --- a/tests/nvme/052
> +++ b/tests/nvme/052
> @@ -71,6 +71,8 @@ test() {
>  			break
>  		fi
> =20
> +		[ ${nsid} -eq 1 ] && continue
> +
>  		_remove_nvmet_ns "${def_subsysnqn}" "${nsid}"
> =20
>  		# wait until async request is processed and ns is removed
> --=20
> 2.45.1
> =
