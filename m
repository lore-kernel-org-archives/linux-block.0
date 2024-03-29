Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA9E44C6A
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699587; cv=fail; b=T2dSyxtGSICUa917bSqbcTux3Whz5EW0i3G59PVAeAl5Y/PHI9i+eIoPnHxVv88OPpEFQ9tjKS9DnUprSKhE27MwpLnN5dnxs7iFPhM4N7FzsDirBphfLJDeaGNwy6407Qpl4Nl21wm08iCG4Mr5KiIC5IO6uIwgdfdR0WDh98M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699587; c=relaxed/simple;
	bh=PHjAv20Qr90tQTDIFzjRVL7I4heaLJiMsH0nneD4vnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uDIpGro0uCUutZ0pUXdeiyMOBlHqJbmemlbelfE62JkaUa9lSORgqBqjjvpu/nTricXGn1k4P5ibTAgSL2i3U9iC5H6X9nwPsiguz+iPF1WdfACAQ9hndH5zwToMurBy5z0g10swcmV/d+mioAgoCPrUbjpl6R0vFicBtZspJ9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=O/qTE8yW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SS9KB+U8; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O/qTE8yW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SS9KB+U8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711699585; x=1743235585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PHjAv20Qr90tQTDIFzjRVL7I4heaLJiMsH0nneD4vnA=;
  b=O/qTE8yWEeFXfAiSBib/Se92QFbOr+tKk76QbBRstaB9PL3Ola/RJ0q8
   iiKYk0x2EEUsgJMTSFAnz8L9IOI/5IJHmkCNy4fki8CPCCZt76Xbos7H7
   OGXZI6d615H+Z6kY+eiGGDdxpzWbXwY0y1486l1MSaS/2mCsaHG3CeaVZ
   gayyR1x152f1Caj1unpBHMxuZjySmGGoz3AOJBw1Kh8bh+vx0NHWSwST1
   S9tSWXRO31OLj+DH+3u9ATyiDUFm7oI378j/GirSU/XfEStdGlF+3GY3V
   WMTPgrvsllXz2aOOLQa4wdOtwysm2XVZIX9EmoJIm/g0CPLJ6TqPdUvV+
   Q==;
X-CSE-ConnectionGUID: LST+WlO+TpS2ewbMqYubgQ==
X-CSE-MsgGUID: wu2rCGJXSoKTk1eonP3KWA==
X-IronPort-AV: E=Sophos;i="6.07,164,1708358400"; 
   d="scan'208";a="12784243"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2024 16:05:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJl8xrm9cYxIbw2vVt2IaRRpZpLdKhWGSS9awbXzClGRtsXO4+bXNWGdPKOKP4MJw+ZHZsGlHtbKu6DehyI06z9msqKqQJiHmAZ2+HJDu8tAljq3lIhsCcr3yQP9rWOBk1avAxeQq6vOBY6uhUlTGXWp81Ii9nZG+y3shh6+7FO7WAShpACmdU4qrIBE3BYI464HzWiDaoYiwW9XBMPxPbudHF+M0Fp2dtDnLVEgQD1t7k4C7nI37E0GjWkpHZwQs713zUbi4HtPHhBhQEbYvrX2FI+JiPybY9rSsn56j000/FhERLYR4rKHwcHEwQKqtC+FHyUKCw7bJCTk2yXh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eon6ll+sjgS7HNhXN1L5jXvNEP5E2FWUOmLYX+sNHv4=;
 b=IopYWYf+1pf76Y+CAN9qY8pLMT5ELlBJG2SpzfzPaPcSXXIoC50XnjLkNtP11jPQDxevBfsXoce07TN+aGt6GYYy9ykCGLt8Z68pY10pqwDXglPYXrUjceg0587NyDjj33DHbiC2o8jWQqRBBxnuPtspejgTHsMR/6ALXgAJhdV5mtsKSv3f/aN1kOXItv3MPsUqYvhG/tRNHNAXgB8/73EqDaG9i+ep3IK5l/GJcX0xbdS8e+ejSBOjX8eJ1oZgtyeV68hLDkU2sGTDhdhSh6nvdPocAoYsF+DTvsYbJJ/gRhYzXCvI27DvZYihseA68IpmWIaHJuu4huEKIYHp3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eon6ll+sjgS7HNhXN1L5jXvNEP5E2FWUOmLYX+sNHv4=;
 b=SS9KB+U8Sbzvz9MUpkJJSUmycyY7jweNo7NZuuuwBxIPLBhZQMroj3Zhhbqq/BB6Mm74IeBvhlO8DJglY39MVr+yQkNmYXiwaJSVBaCADB07InwMVMD2os981Cq0VTu7nHVH1y9Ahjmp4AnZ2kDgT2iPde0HHvBEzglG1gHjz9Q=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by CO6PR04MB7876.namprd04.prod.outlook.com (2603:10b6:303:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 08:05:09 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::602e:e063:814:c285]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::602e:e063:814:c285%4]) with mapi id 15.20.7409.038; Fri, 29 Mar 2024
 08:05:08 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 16/20] nvme: drop default subsysnqn argument
 from _nvme_passthru_target_{setup|cleanup}
Thread-Topic: [PATCH blktests v3 16/20] nvme: drop default subsysnqn argument
 from _nvme_passthru_target_{setup|cleanup}
Thread-Index: AQHaf3+DzlsgXUYrGECE5jrsKNHZELFOYJ8A
Date: Fri, 29 Mar 2024 08:05:08 +0000
Message-ID: <b4ihfmeeiwlcwdfv5lpkkqhdtyjwqzd7vfd5izoajpppvra3n4@hpnwbh6pkmex>
References: <20240326131402.5092-1-dwagner@suse.de>
 <20240326131402.5092-17-dwagner@suse.de>
In-Reply-To: <20240326131402.5092-17-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|CO6PR04MB7876:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NgAxnnVdzKa8wE3YkqE4eljf8RnBjn3e8XzeKMEpTMTR024ungvw84nwQ+/lOeGWzQD45qIqVFBURhrbbgDNM5T0nDrKspeTWsaJkwMz9edR3iS1ypXTCctGTeIvc3lehSvPoiXm0JvDP0QkEypNyrkOBWxXjTDQOugDegYTDsmqXOjL/cbDsxp+WtTI9hl1Y3TjDCCcCJP86RKI8Oym2VqZkZehDa6KwnHFVJpz/1JoG9Mgg3jw1SNiCfQ3/bg9Qtafd2FR0mJuIoXEonouYPBUM2a3ED4GKMnmA00E7vGSmYEaTEuOm5rQywUbMpZKBmijfwoocjcqYkjZdlEVxZX/C3lHwfvKHp7w3bWhiEUyoR2kEbHStUtPtEhlfkg41WcS8cbTZxg3/35zDzD9yxh9dMBFFvfKLHKWXYeK9N4uPbzfS5jntLidMYUW+AGQGFsN/U5bQEJYa5dKN1n06lTksTlyCS4CfRFmaRcWm2xEWyzFIbkD2W3bXiXlh4N9veC2tmZqUJPdyxQR2IRYmxcJwPXOgvOXTNwQGw0Nd6m+fW1YM07ulNLgy+OlVJNBC6qQ/lblkNfsbn5OCnuAUD1SgShhcMTl2/caZxUiAw669nBbo+PkzS/8twO2yISASNGtIw2h9y3hYM3bpxm8fRKVAFCEHwOfBq+wyyDhZb0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P4pQPt6AJ2ZwMVtKqndJKE53YidnKBk1dM8palboCbV+zG+z/n5eW/6K2lKs?=
 =?us-ascii?Q?sOPIT3Zp4oIxfDeAOhpMFsVedU28oEgH+2sYQqh0piiAOLQ1NQ08j3z2ng6n?=
 =?us-ascii?Q?vgNyGh5gDHcGhLluAjxYtW2SlRUiSaJOn/d0MA9mstyYzmv8wixUimRZmdD5?=
 =?us-ascii?Q?jreRpx0ukM/WlyNCYDt5Hp82N38Ks6US6OaC9FDJYe/uSyVRl4p88Eeiuk7g?=
 =?us-ascii?Q?1vW5e5ckZSRcoviyWlGgZTbDqS6uDVwfOYHVFtRNf02Z/hXNI1XsJn3uWH2r?=
 =?us-ascii?Q?V7UA/wwqym38IT5q4qfsrWk3tk+c0G6q9pM2J9Xo9nls2CVB5AcHQi3iGg42?=
 =?us-ascii?Q?63qFmk856uhQ2WUxCfaTtXIukEfopOr0D9vPCaFwS6xLxZ7te7hosh+3Rg6V?=
 =?us-ascii?Q?wiQURCfC9yA3R1tVUpxpGIS7x8jnxYgmibwL1O+Tt7p03CylkoAVhelu0csv?=
 =?us-ascii?Q?5h7RiuxlriWCAnjzcTpYA3LZeTd7fhQZnvxlWh+UTWRqP4jjL6rbrJwViC5P?=
 =?us-ascii?Q?nSibVBPu9g46c0+JnpBA0mgpyCcz5lHjTC8Jt/rKJEIfRvDrWDSROk4NRUm3?=
 =?us-ascii?Q?6yWGwUZpwHzdUuuIHIzQAOqdGLnIMNH3qa3rCOmYGHdkWSn48tiJF+spoxYa?=
 =?us-ascii?Q?A7ygToUgbaa+mc46uFrkUB99dL4fOxTHDzXYf4HahuO6SWFj8tA1Ik2OQSB3?=
 =?us-ascii?Q?EY3koL983QNzyL0osclS97h8/btivxm7i4qfKf81+nwHoS8/yEll+OKD1mlA?=
 =?us-ascii?Q?0SqTFUjwPrIx+/I3Gr6/bzdAjD+XVEmulfsOjKkbrfYsQ/uXD9nQDD6Vyv7O?=
 =?us-ascii?Q?P72jZX/Iscj5qMDfRg/ltASNOQ4HKIDLMv8MiY0P3XmLjEpBogLXwps1FY0I?=
 =?us-ascii?Q?NhNnb8oQoF9QAchkHMCJCRiGnoncXZZuSg744gJ1Is5ftYCyk8Fbl19/AMpR?=
 =?us-ascii?Q?ZpA8C3dFGUzVpq08oOjTvrXwrctayf0Sc+CoWwSFxGWCgKK7uKmzDl2Mr0lV?=
 =?us-ascii?Q?BbYH3mwsou/63URIHyEd+l2Md2pU2WfJnbzvUnsDmXPT0PU+OknPmBG5sYSH?=
 =?us-ascii?Q?T0M9Vxa+JAy+VHAgL4kFnaR9u3qtJKDsRis066lTpbVtpPeiiLn+T/SNqosY?=
 =?us-ascii?Q?9tftAu4ycHnmTEqdu1HcCedrsYGEcQXKkvHen/dNKTqTMDvaXZNcym+PnMl/?=
 =?us-ascii?Q?r5h4WaofWb+vuRMkd8xXV4yDZsmRQQS/4EmLd7Dud3G499xdnqxTtDJtWZpv?=
 =?us-ascii?Q?QI2plVFum8OykHUfWhPmZTzP4BZB8ekXlikOr3A90CK3olUJTDOtTGeD91qb?=
 =?us-ascii?Q?FviRU18RXvIR+UlSjibFPPdz0NlF8AIDfdzHL6AtAKOS/XXX5R/E+6UUiKnh?=
 =?us-ascii?Q?s54eH1jCW6aQmO+HHc9bHjKBJLXyNvvkHIYPf04/UX6oxVzh41vHoPjpDsFk?=
 =?us-ascii?Q?UBG0mmPW53sm5WU1STLi7dygb0iaGSIY0Eis3XPK6eWTYSDj4eCbDvcdc5T1?=
 =?us-ascii?Q?rgRUQV+WTyFu5JM416AlxQSLvkvrgfzheJRtGnXBLw9wXmH8wiOo7CwkZ1fS?=
 =?us-ascii?Q?kjpSGjFOP8DKOS8izD6kWFqYOYtsQ16b7vS7AQ7NY8OqKiLdEi6EZtxiFGQa?=
 =?us-ascii?Q?0OKPSUREueyb1XxiP1rx+Os=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95C3A91C415F2645B056A2A1187D5A25@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MOZ5refEX7akbPA8IESFQW+6DFYQm53y8CPocSIJOpNs3rbjW+gL6CpcmIUNJL4Hte6Iik6xg7umrhbhbMJHz63/+g+tp9GtQDBmH0/gB/yZfnjPiU2WtF+tJThmuzYkZBZ14dKmts1IC4OAUBImGZHgn7K5Hyhy9Vp/Q6t7twmPpZE1vq8ZvCpr520hSQqG5noauXijuCd75sJ3hEhMkaKqNNfULITHqZupnc3/DYSNa4YJjEnkXV8EnjoYlrZp1wyV6FC2s5MxcEo3bMncpmMHL9tX0NSxBWE7GooZKxI+vGs9imfZ8Z1kbKK1cEMglZ3IukRMfgofPXpPeHTga+7271tWBv0ZE/7SSTxhv1TrfMiG/r1T/28Rc3D3Yai4RMkgaET9/4fkrFAlTWvMqkSlT3iwBbwB495rzck9a8206NA8GGGDjOcuB97FvP7u84Iqmy8UlgbMtUMCwLo7SGkFkrHnRt5LlHiEhlBJlC78cLKYSjk0YV/aWoNtl5RB1UXqMr4uc+V7e/DsmTnyjWCEh0s7KYCIZ7vcHR/+3KJywFDFRBlX18O1H6+7+rl+C2bHPIRrlMMAWNi/rUh4K9hhS4/QZT8xJvtXd2Ghq/2MFUxuUeg6/SHnaE6KY3jh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd12e674-2ccc-4acb-289e-08dc4fc6f388
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 08:05:08.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otfT81OUj1Donr1MqVZn0/sL+W2ojEkVVB4Z6IJd7xLrGR3CxHGbXhaxjbvV9F+ZuzfBvqi0J//0ELI3LB799pFp8G3xGhfc7SREgGgWzHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7876

On Mar 26, 2024 / 14:13, Daniel Wagner wrote:
> Remove the last positional argument for
> _nvme_passthrue_target_{setup|cleanup} which most test pass in the
> default subsysnqn anyway. There is little point in cluttering all the
> test textual noise.
>=20
> While at it, also use subsysnqn as variable name everywhere, instead of
> subsys_name.
...
> diff --git a/tests/nvme/037 b/tests/nvme/037
> index 159d9d990bb7..2fe37a7a7340 100755
> --- a/tests/nvme/037
> +++ b/tests/nvme/037
> @@ -22,12 +22,13 @@ test_device() {
>  	local ctrldev
> =20
>  	for ((i =3D 0; i < iterations; i++)); do
> -		_nvmet_passthru_target_setup "${subsys}${i}"
> +		_nvmet_passthru_target_setup --subsysnqn "${subsys}${i}"
>  		nsdev=3D$(_nvmet_passthru_target_connect "${subsys}${i}")
> =20
>  		_nvme_disconnect_subsys \
>  			--subsysnqn "${subsys}${i}" >>"${FULL}" 2>&1
> -		_nvmet_passthru_target_cleanup "${subsys}${i}"
> +		_nvme_disconnect_subsys "${subsys}${i}" >>"${FULL}" 2>&1

I believe that the line above is unnecessary. I took the liberty to remove =
it
when I applied this patch.
