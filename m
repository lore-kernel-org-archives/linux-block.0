Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4022013AD11
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400732; cv=fail; b=K//qxZPfqPwkQhwleklvAu8Be7cgBhoz8C6vNACDCRhcqYvfI6ixhwYnObykYmkJ4U1cawTdLPydtt+979jHOCJ9GTCnHCueI3omY9kjG6pH9lAYaXjPbifk4Lk6h9tjoA/7RF7nOSm3s5I1KM/BXj6pfwGBKsH1RjtD87g3Nqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400732; c=relaxed/simple;
	bh=P/Xl+MljU9eV2gWGN1POdL93Xny+RMe+sXkWsKtfpzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e/myKowSUaORCvtv+nwQNQQr9iHyIGV6n7FekCkmRo4p9/xQDjPA/BywjJbFbvaVJDt9CnuxVWFFi6hcKkASS3W2apMZl+WCF5zNFjfwQTVZTPNFOjnXbaKs5DW8hDte6MoCcfiZrGGLBkuf3IZfrehhQ1HQ3CCGswUDMu98fdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hu3YhXpp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=og+2ZysD; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hu3YhXpp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="og+2ZysD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719400729; x=1750936729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P/Xl+MljU9eV2gWGN1POdL93Xny+RMe+sXkWsKtfpzk=;
  b=hu3YhXppoalPDQknVsCXtWoqx4GIyPF2OCXBueE4kVJV4hC2XH2lTf0C
   xOYhVVNilP2jkTMgfGTLcL7yXz1rHEhGObcWPx5jicGZDmrel3a8rqoLc
   7PggYrYJN25DI2tkBw9XEy9o1SfLTFs0OUsT1UoCYAe1x3vujyCkktf3c
   1TpF9+ja9opzz5QeTw1tOzy9LTa+u0GdCt8bNrf5ZRAPJuqyRcLS/vRgv
   h3txmFLIGtJVDrJIs/bwGGd0DRQa6dfwtWRCiJQDbi3CLerp/jOyJjMuB
   1fjXT7hd3vzwzEdH/UwEteskwSZlNPqy7Nd1g/OonO3H1Eao+RSULfSB/
   g==;
X-CSE-ConnectionGUID: cK2vJk2/R4yfpFm5Ms1tRA==
X-CSE-MsgGUID: MwDMIZUvR1aHZERYuz2sug==
X-IronPort-AV: E=Sophos;i="6.08,266,1712592000"; 
   d="scan'208";a="20433597"
Received: from mail-bn7nam10lp2042.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.42])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2024 19:18:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCF2+BJeX0S9piXbEAc9kINMVlfmaHI7x/XDEw5a2jgVn1YCG/EhhwRiAVRb/GlqhDr01ijddVQ4dsPaurm7bhh+wShFSSDQ9KCYkNJeIfs4pdKybUrnw7SPSf0QoQFcE53sITeWj5wQULwvvSiNsJAwhYNae/2e8dPdOkV05RjcjyXJ9LZEVtQ2B58+ueXifxzAp7Hm+aWDNGf4ePTojnDITMBdpbJRaIQBxCiN6aUglkszD/xX59gFRaI+st0o9yz+KabSrAkOvZKh6rWr+JPUC11As7MX3LWib3JnLJgB0OiQWdXGZu0AC18T+loLGvL65qRWM3yrAKl2zGDm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NiKH7QCNSO6uoSKHneE1s7DC1v9RY1C1zJCJ+1qws4=;
 b=ihUli1yVNk66dW1GISBXz/nqGQwBAhvZVnNq1rf/4vKoEADmIVsGWWDB3LFwAdE3KsawDgIRTz5nJ0VtegrcgOP1jTNhsxTvXNRso04r8JwLREgjlgyg9altpzSbiE+xwsD3Gv6e/sx/im4tlyPmTCAPNFBUJ2OimdYoJwdFoD7sNOJu6zoNnTvo0qh1toIyX2WNIvVCkoeq9FvO6BOtlsvp1kD7Jm7ylzf1KgBu65dzHR3cc5C8ljUU5VMSBoTxCwExj+9TuLZt0D94i5deKdiM54YafHjNGRQFOoz3SKvuvlZP6zg2Dzrm8nnYhEfxtFJWm2zczG80seEwuzjlKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NiKH7QCNSO6uoSKHneE1s7DC1v9RY1C1zJCJ+1qws4=;
 b=og+2ZysDD4aOCdA0EdHM/DqxpN9/GIXC/3G1oSpcZeTZn/MIFGz+2/Bd2PxrePpnTyAcptTZrugSoOx5wOaMLkUxS1TlyH+Xe7ODo8Xa6nGN3cfwK3BjOXzxk/cjZlCZjekx4qsPTZu7SpyMuxeODA0YVdM5GWus8dBJ1jwSiYs=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH4PR04MB9281.namprd04.prod.outlook.com (2603:10b6:610:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 11:18:38 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 11:18:38 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ofir Gal <ofir.gal@volumez.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"dwagner@suse.de" <dwagner@suse.de>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2 1/2] nvme: move helper functions to
 common/nvme
Thread-Topic: [PATCH blktests v2 1/2] nvme: move helper functions to
 common/nvme
Thread-Index: AQHaxiPT1BRmWl2JZUKjefql9PfXzrHZ6OcA
Date: Wed, 26 Jun 2024 11:18:38 +0000
Message-ID: <g5ob2s5hhobdr3nwbv6bdt5yg7ca4jff6g4w5nrkaqac3ozu4s@lhre6wr43bub>
References: <20240624104620.2156041-1-ofir.gal@volumez.com>
 <20240624104620.2156041-2-ofir.gal@volumez.com>
In-Reply-To: <20240624104620.2156041-2-ofir.gal@volumez.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH4PR04MB9281:EE_
x-ms-office365-filtering-correlation-id: d9b133ae-8733-4dfe-afca-08dc95d1ba64
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|376012|1800799022|366014|38070700016;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dl5/mvAqhEdJx1CXfsKDCbnRlDcLjLMmeXe3TLxgyg45YG96EiUMeKL2pIXd?=
 =?us-ascii?Q?t4yehYHaZBPwkZeG7bH7K12kJDIwY7s3RRLaF9PwQodSguCXlAfncO7Wi0e/?=
 =?us-ascii?Q?7V5gM7Qf7R/uVB4lUtrPBqm8iBFPqgwUn5NHk0MzswjpgrodmE0M0mDHcq4x?=
 =?us-ascii?Q?UAf8NGqJSICHmj7tV75sp3DpMAfjbuzWNeA684XwD5p3kFLoWFxiaf4uxNM8?=
 =?us-ascii?Q?5vkRw3BqQc1/+PLvknVeqxjYynxOhrxi7Nl1jSuLQnwBMKUDazi/Uf7UC2XD?=
 =?us-ascii?Q?/mPkIEXnl6jJZVk6AzeA0yDmgnGvmmVW1ri97W3j/kjI+lL66A6KVHVtTOxf?=
 =?us-ascii?Q?qv8poqE27/X5aVKpGPZgLXIlTfI0trdEuyG5PK5n8GTwhbdwMhEWrZNzNv+6?=
 =?us-ascii?Q?CpItdINfLcMkkJYzcKW8sMGHWpD9RUVNL61PJtX2sEGazLALuFKC3/NaWcqa?=
 =?us-ascii?Q?FQlIvjRZ2EgceCVajrQohjQRdu1m1J/fsjAvo2QbXpbZc4dsVLjcbNpI5Wax?=
 =?us-ascii?Q?PRlhycuqrx6t2HL8Bod61PbqrNxO0d9sLZStVUe2Um6EgtfHh6ugvoEwdSre?=
 =?us-ascii?Q?JkcYckbPxtk/4Eajy1SYMlpIMERkZhUrPooLLg1XRutZP/5U0cfYDJUnKjEU?=
 =?us-ascii?Q?FIyAyoF2yU1oh9oS25cFYmGez1YremJAiPl5oD/HvJVPEcNb8wqMRHKH33Nf?=
 =?us-ascii?Q?4WeJzuxDnBnsqRdgWAUrhh04gV2SN2jDQT8BMr5S/mqFG6q1KwuDsEPW5I+e?=
 =?us-ascii?Q?zQMFl9tuQJ1zGaviUA8RWU+unnUjTnNFqBxWE/UlMy6NBheZLb2ezGLSZIU9?=
 =?us-ascii?Q?S35G7JuyhfpZXcWDgkhVd8n7EuUZZAJAWBj4Tq53MOEUrFQWldAIsL/s2q7P?=
 =?us-ascii?Q?6DV1IfGpsGl+P59ZQQBWFof5bSQXgUuRhrDGbS4xJluolYeOgBpnE4vfRAq8?=
 =?us-ascii?Q?cw1QVKgAFTfaydSp+lONsVwqUeYO9u1jEehcfNpYOCf86BiUWJU5wwgQksHR?=
 =?us-ascii?Q?AkKvEPywvz0GtFZZLOme9bRICpilmLiHLL72VdGxJozpVVUBaDOQ0wStgnh7?=
 =?us-ascii?Q?H6EqmoAIfI8umJsiD1GRxYm972TP7ySDDgOnHaTgu6zWO/QK1V9+MpLHJiPr?=
 =?us-ascii?Q?V/7GnzNeZFLCI1Mqe0eoOieq8NOkTrnM5yN45tfetTjSjTgbiQw+6A6wbKRC?=
 =?us-ascii?Q?cDArAMB0FR1Y6rBYYyCCy4ktlWJIU+33WpSZcLzMvTWv8cza0B9EEXPp3Ucc?=
 =?us-ascii?Q?ymIuGZ0tB/jfMG6ZR2YuEV88q22CH/Pd7kuUrSVx+Eafb0GcX/Wo2Z8sBpZW?=
 =?us-ascii?Q?WdSsqqPrDs0yOdsEyNgsY2WPkzhW8KD/FvprbzROCghenRAeraYfoRyBcTiS?=
 =?us-ascii?Q?yFIPY6FqKOkJpmm9fFNbBJ4RN2P7fWOlAhy4SiDj32QUOrVMVg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(1800799022)(366014)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+BSIfGoSTDOAnSgS+O7MS1kMI+wYZWGTE0Gz/DzURbsnL9SN5DVXUpNE9H4n?=
 =?us-ascii?Q?5NizB3cYRkqe8jon0r5G57Wq4hW8/xoCMwIpzk684eIRycDStyd//Oyfpcz8?=
 =?us-ascii?Q?cgyij9+2Td//IYf5wv2XI8kA1Ktkpdh4Wda9NDbvWAnnEUuXLp3EPur5+smQ?=
 =?us-ascii?Q?BSUegXmMWwpYbNh0reJwJAz12rkXq3rl4qmnECTg7M/s06Hl0UVkAySo55Ju?=
 =?us-ascii?Q?zUIwyJ6DwjicwGaekEEfU/Ea9/NfCYCsWzDYYe/iQSRazolNaJZGxu0OvfTK?=
 =?us-ascii?Q?VU6ZK9rBkyo0D7xeiyUEO67MgedTiDivBJOHA7BymOl0V23aRKPuw10hPSa7?=
 =?us-ascii?Q?+6j82++T9Wz30UpGWPmgX2DhV/YM1MFksvDl/dQEKxC17RxBjkUhUS8cqh8X?=
 =?us-ascii?Q?VSECV65MRlWPIP2IMk5vz77zQ2N9oBLhKXGr2xo84gjn5Ki7LMHpNwW6itXB?=
 =?us-ascii?Q?uxKsL4wIVIRcETFXuW3MZjWJHdpX1/N7hDWulGAXNOkbNcee3eAW+Y1V71Ge?=
 =?us-ascii?Q?YZ5DRpKFe4WztWaGRukzlf5DT1ZPZO3Couvlm1By4wyJJYanfxHyptkmN5WS?=
 =?us-ascii?Q?CD+NtNvQLAZ6Xnqt/5BKVJuuYFPmpB6EHAmemtm4Fs39bLsH6EA+6kmQVr5q?=
 =?us-ascii?Q?PcwajWYGuM7DgNgD8Io3oCXg4WVPcU76zUN2mYhEzXb7oZdT6U78Wr5zCCaB?=
 =?us-ascii?Q?+lqZVDb0OU+i7Xk2P3m6zXIAiZdNkmXfY383faeWFbNjLi8FyowJVxqV26WV?=
 =?us-ascii?Q?87RmoSDESWv0XYy/+uDB3wAKOZTKz0jLLHknxs998qG4x+OkuxHmPXr0H8g6?=
 =?us-ascii?Q?m1z6VaExYJcba5uzk+hDPnoG+5oGXJGg9zZGXK3PoCRcS4uWiJj6fcDNiLPA?=
 =?us-ascii?Q?wkt9cHlFBLjI1/FjhkKA1oZ632cegqpd4k3s+RWpq/kT4udP6wPhh1DGQM42?=
 =?us-ascii?Q?JkgdtzyrNjmEE5jrsOEtqM9NNTGzpsPu9oEjKJPhSWN7W3USIdjyQs8Fovig?=
 =?us-ascii?Q?vYvR3YpXlqixHuVzK3ruv/1d6MkdA/a2mIqdhUptho5jLvIFIPTuGNW0Cokq?=
 =?us-ascii?Q?9kolZvPfMCBUPRyIAm+HUAtjRDZTsX/Yy2OScCGViAw7F24qDgTj+ssiHhPv?=
 =?us-ascii?Q?aMZrpDk3Gf537H2aasjM38YOpJFT3OtzKzsUwdPNn7M4m5cLR23s980vwtwE?=
 =?us-ascii?Q?85cUUGTS4klHuWT3BWoaWvqdEUev9PWeIFIiKRblH0Ta7dBSrOylRc9uGbn3?=
 =?us-ascii?Q?s4FQUREdpbt5fsq8PVgJ+UVZnNRyxJPAe4MZp1aJnWfJy3uTxAeK3llGM7Ll?=
 =?us-ascii?Q?xjV/Ng+z1aI3BmzdASe8RuxsmGdW5jJNW+A8vAMBFUo6T2U+u6kwZS5LfcDi?=
 =?us-ascii?Q?H0cevEoOo09RfhRP8SXfw+3pl1CeVzmFcgPZA+esdH25plSE2YcopfUyd4K5?=
 =?us-ascii?Q?q5Kt8nTmWC1BMvbYY9FOuM7Cq5ojBkNe3Q4mpjWG6VkgUPQnyBsYxxXlrkkJ?=
 =?us-ascii?Q?6aZvMH9tprqnWyffPIlkbiKxvWyU0KPpgd+fcQ/Vcs+0y4rk2fDm540anMGV?=
 =?us-ascii?Q?N9KmU7fO5fAZOTk9euSDMzhATsxhce4Z2QuHJppY2/b8Obh3dENRrZXDsr2k?=
 =?us-ascii?Q?yilM0D5sP5MVnbju1P7IdXU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1AA15C218289A34BBAAA03F11D7955F4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FzRchrwGfcZOO2YyG68kydYPG7rqETISdleGYku415TMHNxQc7DY0RwYOgVOdSJAS63XI4x50nqi5W33s8lKGC+8Ce2uvNs8lrrOZOdt7KhyWv2tDYTNIuvjKqoKM95jjsaKGqukYN9dwVU5LAePMlv027Bn1DkxKqx64weQEPaO87WWRoJtFOifKzntfsK6PyvI3Yh1gSJbL2LeXH2RAH3GgKNWLofU8wDCkTBeQLnRD1YfZDykZ6aYZMQ9ogNkA2u4DFam44dmbEFHmPHnvM/QlnhKG3Blovaijjjxqp1fC7NBHVsmK3np8fDKj3vHzE7NgQa8sMJRR3CfCRQkBrHEDMWeNLziC7EcCcrCxFFK/If+gf9FS9eDDYxpyt7vvCD3VieEBjTbjawoUUMrR3a7L0LFqlDslifYuVk9HzHyR+fhxlu5eAum7w117BKBPF6MiK76xbhJYsv4jwHYiWLNehWWUuXn+bGHThtmy+DXe6VdFXXUz7vCW0un3DarfnNEWxMS8YtB78g0s2UAoQfRWWCeR5EqnTIjBDd9BAi/Ognx0u4JiwMB6E+KkxcLQGv17vamR8FPoKFVVd5d4tTG1oUz1tt4qx7AsT9v7POtq4Ol/OJS4i6d2/HCf2P3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b133ae-8733-4dfe-afca-08dc95d1ba64
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 11:18:38.7284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3FTAoo+3MZCgDXLrqND5WQApHRKpiNdcjj2EC+XRpq2Du2T5VGKlKL0kk5cBV6IoB1b7u6fVMkV0/0qPFBLyNQzmJtOGCBU2ZLviHgbAj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9281

On Jun 24, 2024 / 13:46, Ofir Gal wrote:
> Move functions from tests/nvme/rc to common/nvme to be able to reuse
> them in other tests groups.
>=20
> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
> ---
> I have moved the function that are nessecary for the regression test I
> add. Let me know if we want to move more or all the functions to
> common/nvme.
>=20
> shellcheck detects 2 new warnings:
> common/nvme:35:10: warning: nvme_trtype is referenced but not assigned. [=
SC2154]
> common/nvme:234:11: warning: nvme_adrfam is referenced but not assigned. =
[SC2154]
>=20
> I have tried to figure out why but I couldn't figure out what is
> different than the upstream version. How can I fix them?

Hi Ofir, thanks for this work. Please find two comments in line below. One =
of
them suggests a fix for the shellcheck warnings.

>=20
>=20
>  common/nvme   | 595 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/rc | 591 +------------------------------------------------
>  2 files changed, 596 insertions(+), 590 deletions(-)
>  create mode 100644 common/nvme
>=20
> diff --git a/common/nvme b/common/nvme
> new file mode 100644
> index 0000000..1800263
> --- /dev/null
> +++ b/common/nvme
> @@ -0,0 +1,595 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +#
> +# nvme helper functions.
> +
> +. common/shellcheck
> +
> +def_traddr=3D"127.0.0.1"
> +def_adrfam=3D"ipv4"
> +def_trsvcid=3D"4420"
> +def_remote_wwnn=3D"0x10001100aa000001"
> +def_remote_wwpn=3D"0x20001100aa000001"
> +def_local_wwnn=3D"0x10001100aa000002"
> +def_local_wwpn=3D"0x20001100aa000002"
> +def_hostid=3D"0f01fb42-9f7f-4856-b0b3-51e60b8de349"
> +def_hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
> +export def_subsysnqn=3D"blktests-subsystem-1"
> +export def_subsys_uuid=3D"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> +_check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
> +_check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
> +_check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
> +nvmet_blkdev_type=3D${nvmet_blkdev_type:-"device"}
> +NVMET_BLKDEV_TYPES=3D${NVMET_BLKDEV_TYPES:-"device file"}
> +NVMET_CFS=3D"/sys/kernel/config/nvmet/"

As for the shellcheck warnings, I suggestto add two lines below here to sup=
press
them.

nvme_trtype=3D${nvme_trtype:-}
nvme_adrfam=3D${nvme_adrfam:-}

> +
> +# TMPDIR can not be referred out of test() or test_device() context. Ins=
tead of
> +# global variable def_flie_path, use this getter function.
> +_nvme_def_file_path() {
> +	echo "${TMPDIR}/img"
> +}
> +
> +_require_nvme_trtype() {
> +	local trtype
> +	for trtype in "$@"; do
> +		if [[ "${nvme_trtype}" =3D=3D "$trtype" ]]; then
> +			return 0
> +		fi
> +	done
> +	SKIP_REASONS+=3D("nvme_trtype=3D${nvme_trtype} is not supported in this=
 test")
> +	return 1
> +}
> +
> +_require_nvme_trtype_is_loop() {
> +	if ! _require_nvme_trtype loop; then
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +_require_nvme_trtype_is_fabrics() {
> +	if ! _require_nvme_trtype loop fc rdma tcp; then
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +_nvme_fcloop_add_rport() {
> +	local local_wwnn=3D"$1"
> +	local local_wwpn=3D"$2"
> +	local remote_wwnn=3D"$3"
> +	local remote_wwpn=3D"$4"
> +	local loopctl=3D/sys/class/fcloop/ctl
> +
> +	echo "wwnn=3D${remote_wwnn},wwpn=3D${remote_wwpn},lpwwnn=3D${local_wwnn=
},lpwwpn=3D${local_wwpn},roles=3D0x60" > ${loopctl}/add_remote_port
> +}
> +
> +_nvme_fcloop_add_lport() {
> +	local wwnn=3D"$1"
> +	local wwpn=3D"$2"
> +	local loopctl=3D/sys/class/fcloop/ctl
> +
> +	echo "wwnn=3D${wwnn},wwpn=3D${wwpn}" > ${loopctl}/add_local_port
> +}
> +
> +_nvme_fcloop_add_tport() {
> +	local wwnn=3D"$1"
> +	local wwpn=3D"$2"
> +	local loopctl=3D/sys/class/fcloop/ctl
> +
> +	echo "wwnn=3D${wwnn},wwpn=3D${wwpn}" > ${loopctl}/add_target_port
> +}
> +
> +_setup_fcloop() {
> +	local local_wwnn=3D"${1:-$def_local_wwnn}"
> +	local local_wwpn=3D"${2:-$def_local_wwpn}"
> +	local remote_wwnn=3D"${3:-$def_remote_wwnn}"
> +	local remote_wwpn=3D"${4:-$def_remote_wwpn}"
> +
> +	_nvme_fcloop_add_tport "${remote_wwnn}" "${remote_wwpn}"
> +	_nvme_fcloop_add_lport "${local_wwnn}" "${local_wwpn}"
> +	_nvme_fcloop_add_rport "${local_wwnn}" "${local_wwpn}" \
> +		               "${remote_wwnn}" "${remote_wwpn}"
> +}
> +
> +_nvme_fcloop_del_rport() {
> +	local local_wwnn=3D"$1"
> +	local local_wwpn=3D"$2"
> +	local remote_wwnn=3D"$3"
> +	local remote_wwpn=3D"$4"
> +	local loopctl=3D/sys/class/fcloop/ctl
> +
> +	if [[ ! -f "${loopctl}/del_remote_port" ]]; then
> +		return
> +	fi
> +	echo "wwnn=3D${remote_wwnn},wwpn=3D${remote_wwpn}" > "${loopctl}/del_re=
mote_port"
> +}
> +
> +_nvme_fcloop_del_lport() {
> +	local wwnn=3D"$1"
> +	local wwpn=3D"$2"
> +	local loopctl=3D/sys/class/fcloop/ctl
> +
> +	if [[ ! -f "${loopctl}/del_local_port" ]]; then
> +		return
> +	fi
> +	echo "wwnn=3D${wwnn},wwpn=3D${wwpn}" > "${loopctl}/del_local_port"
> +}
> +
> +_nvme_fcloop_del_tport() {
> +	local wwnn=3D"$1"
> +	local wwpn=3D"$2"
> +	local loopctl=3D/sys/class/fcloop/ctl
> +
> +	if [[ ! -f "${loopctl}/del_target_port" ]]; then
> +		return
> +	fi
> +	echo "wwnn=3D${wwnn},wwpn=3D${wwpn}" > "${loopctl}/del_target_port"
> +}
> +
> +_cleanup_fcloop() {
> +	local local_wwnn=3D"${1:-$def_local_wwnn}"
> +	local local_wwpn=3D"${2:-$def_local_wwpn}"
> +	local remote_wwnn=3D"${3:-$def_remote_wwnn}"
> +	local remote_wwpn=3D"${4:-$def_remote_wwpn}"
> +
> +	_nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
> +	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
> +	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
> +			       "${remote_wwnn}" "${remote_wwpn}"
> +}
> +
> +_cleanup_blkdev() {
> +	local blkdev
> +	local dev
> +
> +	blkdev=3D"$(losetup -l | awk '$6 =3D=3D "'"$(_nvme_def_file_path)"'" { =
print $1 }')"
> +	for dev in ${blkdev}; do
> +		losetup -d "${dev}"
> +	done
> +	rm -f "$(_nvme_def_file_path)"
> +}
> +
> +_cleanup_nvmet() {
> +	local dev
> +	local port
> +	local subsys
> +	local transport
> +	local name
> +
> +	if [[ ! -d "${NVMET_CFS}" ]]; then
> +		return 0
> +	fi
> +
> +	# Don't let successive Ctrl-Cs interrupt the cleanup processes
> +	trap '' SIGINT
> +
> +	shopt -s nullglob
> +
> +	for dev in /sys/class/nvme/nvme*; do
> +		dev=3D"$(basename "$dev")"
> +		transport=3D"$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
> +		if [[ "$transport" =3D=3D "${nvme_trtype}" ]]; then
> +			# if udev auto connect is enabled for FC we get false positives
> +			if [[ "$transport" !=3D "fc" ]]; then
> +				echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
> +			fi
> +			_nvme_disconnect_ctrl "${dev}" 2>/dev/null
> +		fi
> +	done
> +
> +	for port in "${NVMET_CFS}"/ports/*; do
> +		name=3D$(basename "${port}")
> +		echo "WARNING: Test did not clean up port: ${name}"
> +		rm -f "${port}"/subsystems/*
> +		rmdir "${port}"
> +	done
> +
> +	for subsys in "${NVMET_CFS}"/subsystems/*; do
> +		name=3D$(basename "${subsys}")
> +		echo "WARNING: Test did not clean up subsystem: ${name}"
> +		for ns in "${subsys}"/namespaces/*; do
> +			rmdir "${ns}"
> +		done
> +		rmdir "${subsys}"
> +	done
> +
> +	for host in "${NVMET_CFS}"/hosts/*; do
> +		name=3D$(basename "${host}")
> +		echo "WARNING: Test did not clean up host: ${name}"
> +		rmdir "${host}"
> +	done
> +
> +	shopt -u nullglob
> +	trap SIGINT
> +
> +	if [[ "${nvme_trtype}" =3D=3D "fc" ]]; then
> +		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
> +				"${def_remote_wwnn}" "${def_remote_wwpn}"
> +		modprobe -rq nvme-fcloop 2>/dev/null
> +	fi
> +	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
> +	if [[ "${nvme_trtype}" !=3D "loop" ]]; then
> +		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
> +	fi
> +	modprobe -rq nvmet 2>/dev/null
> +	if [[ "${nvme_trtype}" =3D=3D "rdma" ]]; then
> +		stop_soft_rdma
> +	fi
> +
> +	_cleanup_blkdev
> +}
> +
> +_setup_nvmet() {
> +	_register_test_cleanup _cleanup_nvmet
> +	modprobe -q nvmet
> +	if [[ "${nvme_trtype}" !=3D "loop" ]]; then
> +		modprobe -q nvmet-"${nvme_trtype}"
> +	fi
> +	modprobe -q nvme-"${nvme_trtype}"
> +	if [[ "${nvme_trtype}" =3D=3D "rdma" ]]; then
> +		start_soft_rdma
> +		for i in $(rdma_network_interfaces)
> +		do
> +			if [[ "${nvme_adrfam}" =3D=3D "ipv6" ]]; then
> +				ipv6_addr=3D$(get_ipv6_ll_addr "$i")
> +				if [[ -n "${ipv6_addr}" ]]; then
> +					def_traddr=3D${ipv6_addr}
> +				fi
> +			else
> +				ipv4_addr=3D$(get_ipv4_addr "$i")
> +				if [[ -n "${ipv4_addr}" ]]; then
> +					def_traddr=3D${ipv4_addr}
> +				fi
> +			fi
> +		done
> +	fi
> +	if [[ "${nvme_trtype}" =3D "fc" ]]; then
> +		modprobe -q nvme-fcloop
> +		_setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
> +			      "${def_remote_wwnn}" "${def_remote_wwpn}"
> +
> +		def_traddr=3D$(printf "nn-%s:pn-%s" \
> +				    "${def_remote_wwnn}" \
> +				    "${def_remote_wwpn}")
> +		def_host_traddr=3D$(printf "nn-%s:pn-%s" \
> +					 "${def_local_wwnn}" \
> +					 "${def_local_wwpn}")
> +	fi
> +}
> +
> +_nvme_disconnect_ctrl() {
> +	local ctrl=3D"$1"
> +
> +	nvme disconnect --device "${ctrl}"
> +}
> +
> +_nvme_connect_subsys() {
> +	local subsysnqn=3D"$def_subsysnqn"
> +	local hostnqn=3D"$def_hostnqn"
> +	local hostid=3D"$def_hostid"
> +	local hostkey=3D""
> +	local ctrlkey=3D""
> +	local nr_io_queues=3D""
> +	local nr_write_queues=3D""
> +	local nr_poll_queues=3D""
> +	local keep_alive_tmo=3D""
> +	local reconnect_delay=3D""
> +	local ctrl_loss_tmo=3D""
> +	local no_wait=3Dfalse
> +	local i
> +
> +	while [[ $# -gt 0 ]]; do
> +		case $1 in
> +			--subsysnqn)
> +				subsysnqn=3D"$2"
> +				shift 2
> +				;;
> +			--hostnqn)
> +				hostnqn=3D"$2"
> +				shift 2
> +				;;
> +			--hostid)
> +				hostid=3D"$2"
> +				shift 2
> +				;;
> +			--dhchap-secret)
> +				hostkey=3D"$2"
> +				shift 2
> +				;;
> +			--dhchap-ctrl-secret)
> +				ctrlkey=3D"$2"
> +				shift 2
> +				;;
> +			--nr-io-queues)
> +				nr_io_queues=3D"$2"
> +				shift 2
> +				;;
> +			--nr-write-queues)
> +				nr_write_queues=3D"$2"
> +				shift 2
> +				;;
> +			--nr-poll-queues)
> +				nr_poll_queues=3D"$2"
> +				shift 2
> +				;;
> +			--keep-alive-tmo)
> +				keep_alive_tmo=3D"$2"
> +				shift 2
> +				;;
> +			--reconnect-delay)
> +				reconnect_delay=3D"$2"
> +				shift 2
> +				;;
> +			--ctrl-loss-tmo)
> +				ctrl_loss_tmo=3D"$2"
> +				shift 2
> +				;;
> +			--no-wait)
> +				no_wait=3Dtrue
> +				shift 1
> +				;;
> +			*)
> +				echo "WARNING: unknown argument: $1"
> +				shift
> +				;;
> +		esac
> +	done
> +
> +	ARGS=3D(--transport "${nvme_trtype}" --nqn "${subsysnqn}")
> +	if [[ "${nvme_trtype}" =3D=3D "fc" ]] ; then
> +		ARGS+=3D(--traddr "${def_traddr}" --host-traddr "${def_host_traddr}")
> +	elif [[ "${nvme_trtype}" !=3D "loop" ]]; then
> +		ARGS+=3D(--traddr "${def_traddr}" --trsvcid "${def_trsvcid}")
> +	fi
> +	ARGS+=3D(--hostnqn=3D"${hostnqn}")
> +	ARGS+=3D(--hostid=3D"${hostid}")
> +	if [[ -n "${hostkey}" ]]; then
> +		ARGS+=3D(--dhchap-secret=3D"${hostkey}")
> +	fi
> +	if [[ -n "${ctrlkey}" ]]; then
> +		ARGS+=3D(--dhchap-ctrl-secret=3D"${ctrlkey}")
> +	fi
> +	if [[ -n "${nr_io_queues}" ]]; then
> +		ARGS+=3D(--nr-io-queues=3D"${nr_io_queues}")
> +	fi
> +	if [[ -n "${nr_write_queues}" ]]; then
> +		ARGS+=3D(--nr-write-queues=3D"${nr_write_queues}")
> +	fi
> +	if [[ -n "${nr_poll_queues}" ]]; then
> +		ARGS+=3D(--nr-poll-queues=3D"${nr_poll_queues}")
> +	fi
> +	if [[ -n "${keep_alive_tmo}" ]]; then
> +		ARGS+=3D(--keep-alive-tmo=3D"${keep_alive_tmo}")
> +	fi
> +	if [[ -n "${reconnect_delay}" ]]; then
> +		ARGS+=3D(--reconnect-delay=3D"${reconnect_delay}")
> +	fi
> +	if [[ -n "${ctrl_loss_tmo}" ]]; then
> +		ARGS+=3D(--ctrl-loss-tmo=3D"${ctrl_loss_tmo}")
> +	fi
> +
> +	nvme connect "${ARGS[@]}" 2> /dev/null | grep -v "connecting to device:=
"
> +
> +	# Wait until device file and uuid/wwid sysfs attributes get ready for
> +	# all namespaces.
> +	if [[ ${no_wait} =3D false ]]; then
> +		udevadm settle
> +		for ((i =3D 0; i < 10; i++)); do
> +			_nvme_ns_ready "${subsysnqn}" && return
> +			sleep .1
> +		done
> +	fi
> +}
> +
> +_nvme_ns_ready() {
> +	local subsysnqn=3D"${1}"
> +	local ns_path ns_id dev
> +	local cfs_path=3D"${NVMET_CFS}/subsystems/$subsysnqn"
> +
> +	dev=3D$(_find_nvme_dev "$subsysnqn")
> +	for ns_path in "${cfs_path}/namespaces/"*; do
> +		ns_id=3D${ns_path##*/}
> +		if [[ ! -b /dev/${dev}n${ns_id} ||
> +			   ! -e /sys/block/${dev}n${ns_id}/uuid ||
> +			   ! -e /sys/block/${dev}n${ns_id}/wwid ]]; then
> +			return 1
> +		fi
> +	done
> +	return 0
> +}
> +
> +_create_nvmet_port() {
> +	local trtype=3D"$1"
> +	local traddr=3D"${2:-$def_traddr}"
> +	local adrfam=3D"${3:-$def_adrfam}"
> +	local trsvcid=3D"${4:-$def_trsvcid}"
> +
> +	local port
> +	for ((port =3D 0; ; port++)); do
> +		if [[ ! -e "${NVMET_CFS}/ports/${port}" ]]; then
> +			break
> +		fi
> +	done
> +
> +	mkdir "${NVMET_CFS}/ports/${port}"
> +	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
> +	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
> +	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
> +	if [[ "${adrfam}" !=3D "fc" ]]; then
> +		echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"
> +	fi
> +
> +	echo "${port}"
> +}
> +
> +_remove_nvmet_port() {
> +	local port=3D"$1"
> +	rmdir "${NVMET_CFS}/ports/${port}"
> +}
> +
> +_create_nvmet_ns() {
> +	local nvmet_subsystem=3D"$1"
> +	local nsid=3D"$2"
> +	local blkdev=3D"$3"
> +	local uuid=3D"00000000-0000-0000-0000-000000000000"
> +	local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> +	local ns_path=3D"${subsys_path}/namespaces/${nsid}"
> +
> +	if [[ $# -eq 4 ]]; then
> +		uuid=3D"$4"
> +	fi
> +
> +	mkdir "${ns_path}"
> +	printf "%s" "${blkdev}" > "${ns_path}/device_path"
> +	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
> +	printf 1 > "${ns_path}/enable"
> +}
> +
> +_create_nvmet_subsystem() {
> +	local nvmet_subsystem=3D"$1"
> +	local blkdev=3D"$2"
> +	local uuid=3D$3
> +	local cfs_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> +
> +	mkdir -p "${cfs_path}"
> +	echo 0 > "${cfs_path}/attr_allow_any_host"
> +	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
> +}
> +
> +_add_nvmet_allow_hosts() {
> +	local nvmet_subsystem=3D"$1"
> +	local nvmet_hostnqn=3D"$2"
> +	local cfs_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> +	local host_path=3D"${NVMET_CFS}/hosts/${nvmet_hostnqn}"
> +
> +	ln -s "${host_path}" "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
> +}
> +
> +_create_nvmet_host() {
> +	local nvmet_subsystem=3D"$1"
> +	local nvmet_hostnqn=3D"$2"
> +	local nvmet_hostkey=3D"$3"
> +	local nvmet_ctrlkey=3D"$4"
> +	local host_path=3D"${NVMET_CFS}/hosts/${nvmet_hostnqn}"
> +
> +	if [[ -d "${host_path}" ]]; then
> +		echo "FAIL target setup failed. stale host configuration found"
> +		return 1;
> +	fi
> +
> +	mkdir "${host_path}"
> +	_add_nvmet_allow_hosts "${nvmet_subsystem}" "${nvmet_hostnqn}"
> +	if [[ "${nvmet_hostkey}" ]] ; then
> +		echo "${nvmet_hostkey}" > "${host_path}/dhchap_key"
> +	fi
> +	if [[ "${nvmet_ctrlkey}" ]] ; then
> +		echo "${nvmet_ctrlkey}" > "${host_path}/dhchap_ctrl_key"
> +	fi
> +}
> +
> +_remove_nvmet_ns() {
> +	local nvmet_subsystem=3D"$1"
> +	local nsid=3D$2
> +	local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> +	local nvmet_ns_path=3D"${subsys_path}/namespaces/${nsid}"
> +
> +	echo 0 > "${nvmet_ns_path}/enable"
> +	rmdir "${nvmet_ns_path}"
> +}
> +
> +_remove_nvmet_subsystem() {
> +	local nvmet_subsystem=3D"$1"
> +	local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> +
> +	_remove_nvmet_ns "${nvmet_subsystem}" "1"
> +	rm -f "${subsys_path}"/allowed_hosts/*
> +	rmdir "${subsys_path}"
> +}
> +
> +_remove_nvmet_host() {
> +	local nvmet_host=3D"$1"
> +	local host_path=3D"${NVMET_CFS}/hosts/${nvmet_host}"
> +
> +	rmdir "${host_path}"
> +}
> +
> +_add_nvmet_subsys_to_port() {
> +	local port=3D"$1"
> +	local nvmet_subsystem=3D"$2"
> +
> +	ln -s "${NVMET_CFS}/subsystems/${nvmet_subsystem}" \
> +		"${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
> +}
> +
> +_remove_nvmet_subsystem_from_port() {
> +	local port=3D"$1"
> +	local nvmet_subsystem=3D"$2"
> +
> +	rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
> +}
> +
> +_get_nvmet_ports() {
> +	local nvmet_subsystem=3D"$1"
> +	local -n nvmet_ports=3D"$2"
> +	local cfs_path=3D"${NVMET_CFS}/ports"
> +	local sarg
> +
> +	sarg=3D"s;^${cfs_path}/\([0-9]\+\)/subsystems/${nvmet_subsystem}$;\1;p"
> +
> +	for path in "${cfs_path}/"*"/subsystems/${nvmet_subsystem}"; do
> +		nvmet_ports+=3D("$(echo "${path}" | sed -n -s "${sarg}")")
> +	done
> +}
> +
> +_find_nvme_dev() {
> +	local subsys=3D$1
> +	local subsysnqn
> +	local dev
> +	for dev in /sys/class/nvme/nvme*; do
> +		[ -e "$dev" ] || continue
> +		dev=3D"$(basename "$dev")"
> +		subsysnqn=3D"$(cat "/sys/class/nvme/${dev}/subsysnqn" 2>/dev/null)"
> +		if [[ "$subsysnqn" =3D=3D "$subsys" ]]; then
> +			echo "$dev"
> +		fi
> +	done
> +}
> +
> +_nvmet_target_cleanup() {
> +	local ports
> +	local port
> +	local blkdev
> +	local subsysnqn=3D"${def_subsysnqn}"
> +	local blkdev_type=3D""
> +
> +	while [[ $# -gt 0 ]]; do
> +		case $1 in
> +			--blkdev)
> +				blkdev_type=3D"$2"
> +				shift 2
> +				;;
> +			--subsysnqn)
> +				subsysnqn=3D"$2"
> +				shift 2
> +				;;
> +			*)
> +				echo "WARNING: unknown argument: $1"
> +				shift
> +				;;
> +		esac
> +	done
> +
> +	_get_nvmet_ports "${subsysnqn}" ports
> +
> +	for port in "${ports[@]}"; do
> +		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
> +		_remove_nvmet_port "${port}"
> +	done
> +	_remove_nvmet_subsystem "${subsysnqn}"
> +	_remove_nvmet_host "${def_hostnqn}"
> +
> +	if [[ "${blkdev_type}" =3D=3D "device" ]]; then
> +		_cleanup_blkdev
> +	fi
> +}
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index c1ddf41..3462f2e 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -5,25 +5,9 @@
>  # Test specific to NVMe devices
> =20
>  . common/rc
> +. common/nvme
>  . common/multipath-over-rdma
> =20
> -def_traddr=3D"127.0.0.1"
> -def_adrfam=3D"ipv4"
> -def_trsvcid=3D"4420"
> -def_remote_wwnn=3D"0x10001100aa000001"
> -def_remote_wwpn=3D"0x20001100aa000001"
> -def_local_wwnn=3D"0x10001100aa000002"
> -def_local_wwpn=3D"0x20001100aa000002"
> -def_hostid=3D"0f01fb42-9f7f-4856-b0b3-51e60b8de349"
> -def_hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
> -export def_subsysnqn=3D"blktests-subsystem-1"
> -export def_subsys_uuid=3D"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> -_check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
> -_check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
> -_check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
> -nvmet_blkdev_type=3D${nvmet_blkdev_type:-"device"}
> -NVMET_BLKDEV_TYPES=3D${NVMET_BLKDEV_TYPES:-"device file"}
> -
>  _NVMET_TRTYPES_is_valid() {
>  	local type
> =20
> @@ -70,12 +54,6 @@ _set_nvmet_blkdev_type() {
>  	COND_DESC=3D"bd=3D${nvmet_blkdev_type}"
>  }
> =20
> -# TMPDIR can not be referred out of test() or test_device() context. Ins=
tead of
> -# global variable def_flie_path, use this getter function.
> -_nvme_def_file_path() {
> -	echo "${TMPDIR}/img"
> -}
> -
>  _nvme_requires() {
>  	_have_program nvme
>  	_require_nvme_test_img_size 4m
> @@ -144,8 +122,6 @@ group_device_requires() {
>  	_require_test_dev_is_nvme
>  }
> =20
> -NVMET_CFS=3D"/sys/kernel/config/nvmet/"
> -
>  _require_test_dev_is_nvme() {
>  	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
>  		SKIP_REASONS+=3D("$TEST_DEV is not a NVMe device")
> @@ -168,31 +144,6 @@ _require_nvme_test_img_size() {
>  	return 0
>  }
> =20
> -_require_nvme_trtype() {
> -	local trtype
> -	for trtype in "$@"; do
> -		if [[ "${nvme_trtype}" =3D=3D "$trtype" ]]; then
> -			return 0
> -		fi
> -	done
> -	SKIP_REASONS+=3D("nvme_trtype=3D${nvme_trtype} is not supported in this=
 test")
> -	return 1
> -}
> -
> -_require_nvme_trtype_is_loop() {
> -	if ! _require_nvme_trtype loop; then
> -		return 1
> -	fi
> -	return 0
> -}
> -
> -_require_nvme_trtype_is_fabrics() {
> -	if ! _require_nvme_trtype loop fc rdma tcp; then
> -		return 1
> -	fi
> -	return 0
> -}
> -
>  _require_nvme_cli_auth() {
>  	if ! nvme gen-dhchap-key --nqn nvmf-test-subsys > /dev/null 2>&1 ; then
>  		SKIP_REASONS+=3D("nvme gen-dhchap-key command missing")
> @@ -235,216 +186,6 @@ _nvme_calc_rand_io_size() {
>  	echo "${io_size_kb}k"
>  }
> =20
> -_nvme_fcloop_add_rport() {
> -	local local_wwnn=3D"$1"
> -	local local_wwpn=3D"$2"
> -	local remote_wwnn=3D"$3"
> -	local remote_wwpn=3D"$4"
> -	local loopctl=3D/sys/class/fcloop/ctl
> -
> -	echo "wwnn=3D${remote_wwnn},wwpn=3D${remote_wwpn},lpwwnn=3D${local_wwnn=
},lpwwpn=3D${local_wwpn},roles=3D0x60" > ${loopctl}/add_remote_port
> -}
> -
> -_nvme_fcloop_add_lport() {
> -	local wwnn=3D"$1"
> -	local wwpn=3D"$2"
> -	local loopctl=3D/sys/class/fcloop/ctl
> -
> -	echo "wwnn=3D${wwnn},wwpn=3D${wwpn}" > ${loopctl}/add_local_port
> -}
> -
> -_nvme_fcloop_add_tport() {
> -	local wwnn=3D"$1"
> -	local wwpn=3D"$2"
> -	local loopctl=3D/sys/class/fcloop/ctl
> -
> -	echo "wwnn=3D${wwnn},wwpn=3D${wwpn}" > ${loopctl}/add_target_port
> -}
> -
> -_setup_fcloop() {
> -	local local_wwnn=3D"${1:-$def_local_wwnn}"
> -	local local_wwpn=3D"${2:-$def_local_wwpn}"
> -	local remote_wwnn=3D"${3:-$def_remote_wwnn}"
> -	local remote_wwpn=3D"${4:-$def_remote_wwpn}"
> -
> -	_nvme_fcloop_add_tport "${remote_wwnn}" "${remote_wwpn}"
> -	_nvme_fcloop_add_lport "${local_wwnn}" "${local_wwpn}"
> -	_nvme_fcloop_add_rport "${local_wwnn}" "${local_wwpn}" \
> -		               "${remote_wwnn}" "${remote_wwpn}"
> -}
> -
> -_nvme_fcloop_del_rport() {
> -	local local_wwnn=3D"$1"
> -	local local_wwpn=3D"$2"
> -	local remote_wwnn=3D"$3"
> -	local remote_wwpn=3D"$4"
> -	local loopctl=3D/sys/class/fcloop/ctl
> -
> -	if [[ ! -f "${loopctl}/del_remote_port" ]]; then
> -		return
> -	fi
> -	echo "wwnn=3D${remote_wwnn},wwpn=3D${remote_wwpn}" > "${loopctl}/del_re=
mote_port"
> -}
> -
> -_nvme_fcloop_del_lport() {
> -	local wwnn=3D"$1"
> -	local wwpn=3D"$2"
> -	local loopctl=3D/sys/class/fcloop/ctl
> -
> -	if [[ ! -f "${loopctl}/del_local_port" ]]; then
> -		return
> -	fi
> -	echo "wwnn=3D${wwnn},wwpn=3D${wwpn}" > "${loopctl}/del_local_port"
> -}
> -
> -_nvme_fcloop_del_tport() {
> -	local wwnn=3D"$1"
> -	local wwpn=3D"$2"
> -	local loopctl=3D/sys/class/fcloop/ctl
> -
> -	if [[ ! -f "${loopctl}/del_target_port" ]]; then
> -		return
> -	fi
> -	echo "wwnn=3D${wwnn},wwpn=3D${wwpn}" > "${loopctl}/del_target_port"
> -}
> -
> -_cleanup_fcloop() {
> -	local local_wwnn=3D"${1:-$def_local_wwnn}"
> -	local local_wwpn=3D"${2:-$def_local_wwpn}"
> -	local remote_wwnn=3D"${3:-$def_remote_wwnn}"
> -	local remote_wwpn=3D"${4:-$def_remote_wwpn}"
> -
> -	_nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
> -	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
> -	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
> -			       "${remote_wwnn}" "${remote_wwpn}"
> -}
> -
> -_cleanup_blkdev() {
> -	local blkdev
> -	local dev
> -
> -	blkdev=3D"$(losetup -l | awk '$6 =3D=3D "'"$(_nvme_def_file_path)"'" { =
print $1 }')"
> -	for dev in ${blkdev}; do
> -		losetup -d "${dev}"
> -	done
> -	rm -f "$(_nvme_def_file_path)"
> -}
> -
> -_cleanup_nvmet() {
> -	local dev
> -	local port
> -	local subsys
> -	local transport
> -	local name
> -
> -	if [[ ! -d "${NVMET_CFS}" ]]; then
> -		return 0
> -	fi
> -
> -	# Don't let successive Ctrl-Cs interrupt the cleanup processes
> -	trap '' SIGINT
> -
> -	shopt -s nullglob
> -
> -	for dev in /sys/class/nvme/nvme*; do
> -		dev=3D"$(basename "$dev")"
> -		transport=3D"$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
> -		if [[ "$transport" =3D=3D "${nvme_trtype}" ]]; then
> -			# if udev auto connect is enabled for FC we get false positives
> -			if [[ "$transport" !=3D "fc" ]]; then
> -				echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
> -			fi
> -			_nvme_disconnect_ctrl "${dev}" 2>/dev/null
> -		fi
> -	done
> -
> -	for port in "${NVMET_CFS}"/ports/*; do
> -		name=3D$(basename "${port}")
> -		echo "WARNING: Test did not clean up port: ${name}"
> -		rm -f "${port}"/subsystems/*
> -		rmdir "${port}"
> -	done
> -
> -	for subsys in "${NVMET_CFS}"/subsystems/*; do
> -		name=3D$(basename "${subsys}")
> -		echo "WARNING: Test did not clean up subsystem: ${name}"
> -		for ns in "${subsys}"/namespaces/*; do
> -			rmdir "${ns}"
> -		done
> -		rmdir "${subsys}"
> -	done
> -
> -	for host in "${NVMET_CFS}"/hosts/*; do
> -		name=3D$(basename "${host}")
> -		echo "WARNING: Test did not clean up host: ${name}"
> -		rmdir "${host}"
> -	done
> -
> -	shopt -u nullglob
> -	trap SIGINT
> -
> -	if [[ "${nvme_trtype}" =3D=3D "fc" ]]; then
> -		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
> -				"${def_remote_wwnn}" "${def_remote_wwpn}"
> -		modprobe -rq nvme-fcloop 2>/dev/null
> -	fi
> -	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
> -	if [[ "${nvme_trtype}" !=3D "loop" ]]; then
> -		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
> -	fi
> -	modprobe -rq nvmet 2>/dev/null
> -	if [[ "${nvme_trtype}" =3D=3D "rdma" ]]; then
> -		stop_soft_rdma
> -	fi
> -
> -	_cleanup_blkdev
> -}
> -
> -_setup_nvmet() {
> -	_register_test_cleanup _cleanup_nvmet
> -	modprobe -q nvmet
> -	if [[ "${nvme_trtype}" !=3D "loop" ]]; then
> -		modprobe -q nvmet-"${nvme_trtype}"
> -	fi
> -	modprobe -q nvme-"${nvme_trtype}"
> -	if [[ "${nvme_trtype}" =3D=3D "rdma" ]]; then
> -		start_soft_rdma
> -		for i in $(rdma_network_interfaces)
> -		do
> -			if [[ "${nvme_adrfam}" =3D=3D "ipv6" ]]; then
> -				ipv6_addr=3D$(get_ipv6_ll_addr "$i")
> -				if [[ -n "${ipv6_addr}" ]]; then
> -					def_traddr=3D${ipv6_addr}
> -				fi
> -			else
> -				ipv4_addr=3D$(get_ipv4_addr "$i")
> -				if [[ -n "${ipv4_addr}" ]]; then
> -					def_traddr=3D${ipv4_addr}
> -				fi
> -			fi
> -		done
> -	fi
> -	if [[ "${nvme_trtype}" =3D "fc" ]]; then
> -		modprobe -q nvme-fcloop
> -		_setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
> -			      "${def_remote_wwnn}" "${def_remote_wwpn}"
> -
> -		def_traddr=3D$(printf "nn-%s:pn-%s" \
> -				    "${def_remote_wwnn}" \
> -				    "${def_remote_wwpn}")
> -		def_host_traddr=3D$(printf "nn-%s:pn-%s" \
> -					 "${def_local_wwnn}" \
> -					 "${def_local_wwpn}")
> -	fi
> -}
> -
> -_nvme_disconnect_ctrl() {
> -	local ctrl=3D"$1"
> -
> -	nvme disconnect --device "${ctrl}"
> -}
> -
>  _nvme_disconnect_subsys() {
>  	local subsysnqn=3D"$def_subsysnqn"
> =20
> @@ -465,141 +206,6 @@ _nvme_disconnect_subsys() {
>  		grep -o "disconnected.*"
>  }
> =20
> -_nvme_connect_subsys() {
> -	local subsysnqn=3D"$def_subsysnqn"
> -	local hostnqn=3D"$def_hostnqn"

It looks weird that _nvme_connect_subsys() is moved to common/nvme, but
_nvme_disconnect_subsys() stays in tests/nvme/rc. I think it's the better t=
o
move _nvme_disconnect_subsys() also. Currently, md/001 does not use
_nvme_disconnect_subsys(). Isn't it the better to call it in
cleanup_nvme_over_tcp()?

> -	local hostid=3D"$def_hostid"
> -	local hostkey=3D""
> -	local ctrlkey=3D""
> -	local nr_io_queues=3D""
> -	local nr_write_queues=3D""
> -	local nr_poll_queues=3D""
> -	local keep_alive_tmo=3D""
> -	local reconnect_delay=3D""
> -	local ctrl_loss_tmo=3D""
> -	local no_wait=3Dfalse
> -	local i
> -
> -	while [[ $# -gt 0 ]]; do
> -		case $1 in
> -			--subsysnqn)
> -				subsysnqn=3D"$2"
> -				shift 2
> -				;;
> -			--hostnqn)
> -				hostnqn=3D"$2"
> -				shift 2
> -				;;
> -			--hostid)
> -				hostid=3D"$2"
> -				shift 2
> -				;;
> -			--dhchap-secret)
> -				hostkey=3D"$2"
> -				shift 2
> -				;;
> -			--dhchap-ctrl-secret)
> -				ctrlkey=3D"$2"
> -				shift 2
> -				;;
> -			--nr-io-queues)
> -				nr_io_queues=3D"$2"
> -				shift 2
> -				;;
> -			--nr-write-queues)
> -				nr_write_queues=3D"$2"
> -				shift 2
> -				;;
> -			--nr-poll-queues)
> -				nr_poll_queues=3D"$2"
> -				shift 2
> -				;;
> -			--keep-alive-tmo)
> -				keep_alive_tmo=3D"$2"
> -				shift 2
> -				;;
> -			--reconnect-delay)
> -				reconnect_delay=3D"$2"
> -				shift 2
> -				;;
> -			--ctrl-loss-tmo)
> -				ctrl_loss_tmo=3D"$2"
> -				shift 2
> -				;;
> -			--no-wait)
> -				no_wait=3Dtrue
> -				shift 1
> -				;;
> -			*)
> -				echo "WARNING: unknown argument: $1"
> -				shift
> -				;;
> -		esac
> -	done
> -
> -	ARGS=3D(--transport "${nvme_trtype}" --nqn "${subsysnqn}")
> -	if [[ "${nvme_trtype}" =3D=3D "fc" ]] ; then
> -		ARGS+=3D(--traddr "${def_traddr}" --host-traddr "${def_host_traddr}")
> -	elif [[ "${nvme_trtype}" !=3D "loop" ]]; then
> -		ARGS+=3D(--traddr "${def_traddr}" --trsvcid "${def_trsvcid}")
> -	fi
> -	ARGS+=3D(--hostnqn=3D"${hostnqn}")
> -	ARGS+=3D(--hostid=3D"${hostid}")
> -	if [[ -n "${hostkey}" ]]; then
> -		ARGS+=3D(--dhchap-secret=3D"${hostkey}")
> -	fi
> -	if [[ -n "${ctrlkey}" ]]; then
> -		ARGS+=3D(--dhchap-ctrl-secret=3D"${ctrlkey}")
> -	fi
> -	if [[ -n "${nr_io_queues}" ]]; then
> -		ARGS+=3D(--nr-io-queues=3D"${nr_io_queues}")
> -	fi
> -	if [[ -n "${nr_write_queues}" ]]; then
> -		ARGS+=3D(--nr-write-queues=3D"${nr_write_queues}")
> -	fi
> -	if [[ -n "${nr_poll_queues}" ]]; then
> -		ARGS+=3D(--nr-poll-queues=3D"${nr_poll_queues}")
> -	fi
> -	if [[ -n "${keep_alive_tmo}" ]]; then
> -		ARGS+=3D(--keep-alive-tmo=3D"${keep_alive_tmo}")
> -	fi
> -	if [[ -n "${reconnect_delay}" ]]; then
> -		ARGS+=3D(--reconnect-delay=3D"${reconnect_delay}")
> -	fi
> -	if [[ -n "${ctrl_loss_tmo}" ]]; then
> -		ARGS+=3D(--ctrl-loss-tmo=3D"${ctrl_loss_tmo}")
> -	fi
> -
> -	nvme connect "${ARGS[@]}" 2> /dev/null | grep -v "connecting to device:=
"
> -
> -	# Wait until device file and uuid/wwid sysfs attributes get ready for
> -	# all namespaces.
> -	if [[ ${no_wait} =3D false ]]; then
> -		udevadm settle
> -		for ((i =3D 0; i < 10; i++)); do
> -			_nvme_ns_ready "${subsysnqn}" && return
> -			sleep .1
> -		done
> -	fi
> -}
> -
> -_nvme_ns_ready() {
> -	local subsysnqn=3D"${1}"
> -	local ns_path ns_id dev
> -	local cfs_path=3D"${NVMET_CFS}/subsystems/$subsysnqn"
> -
> -	dev=3D$(_find_nvme_dev "$subsysnqn")
> -	for ns_path in "${cfs_path}/namespaces/"*; do
> -		ns_id=3D${ns_path##*/}
> -		if [[ ! -b /dev/${dev}n${ns_id} ||
> -			   ! -e /sys/block/${dev}n${ns_id}/uuid ||
> -			   ! -e /sys/block/${dev}n${ns_id}/wwid ]]; then
> -			return 1
> -		fi
> -	done
> -	return 0
> -}
> -
>  _nvme_discover() {
>  	local trtype=3D"$1"
>  	local traddr=3D"${2:-$def_traddr}"
> @@ -617,73 +223,6 @@ _nvme_discover() {
>  	nvme discover "${ARGS[@]}"
>  }
> =20
> -_create_nvmet_port() {
> -	local trtype=3D"$1"
> -	local traddr=3D"${2:-$def_traddr}"
> -	local adrfam=3D"${3:-$def_adrfam}"
> -	local trsvcid=3D"${4:-$def_trsvcid}"
> -
> -	local port
> -	for ((port =3D 0; ; port++)); do
> -		if [[ ! -e "${NVMET_CFS}/ports/${port}" ]]; then
> -			break
> -		fi
> -	done
> -
> -	mkdir "${NVMET_CFS}/ports/${port}"
> -	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
> -	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
> -	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
> -	if [[ "${adrfam}" !=3D "fc" ]]; then
> -		echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"
> -	fi
> -
> -	echo "${port}"
> -}
> -
> -_remove_nvmet_port() {
> -	local port=3D"$1"
> -	rmdir "${NVMET_CFS}/ports/${port}"
> -}
> -
> -_create_nvmet_ns() {
> -	local nvmet_subsystem=3D"$1"
> -	local nsid=3D"$2"
> -	local blkdev=3D"$3"
> -	local uuid=3D"00000000-0000-0000-0000-000000000000"
> -	local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> -	local ns_path=3D"${subsys_path}/namespaces/${nsid}"
> -
> -	if [[ $# -eq 4 ]]; then
> -		uuid=3D"$4"
> -	fi
> -
> -	mkdir "${ns_path}"
> -	printf "%s" "${blkdev}" > "${ns_path}/device_path"
> -	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
> -	printf 1 > "${ns_path}/enable"
> -}
> -
> -_create_nvmet_subsystem() {
> -	local nvmet_subsystem=3D"$1"
> -	local blkdev=3D"$2"
> -	local uuid=3D$3
> -	local cfs_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> -
> -	mkdir -p "${cfs_path}"
> -	echo 0 > "${cfs_path}/attr_allow_any_host"
> -	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
> -}
> -
> -_add_nvmet_allow_hosts() {
> -	local nvmet_subsystem=3D"$1"
> -	local nvmet_hostnqn=3D"$2"
> -	local cfs_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> -	local host_path=3D"${NVMET_CFS}/hosts/${nvmet_hostnqn}"
> -
> -	ln -s "${host_path}" "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
> -}
> -
>  _remove_nvmet_allow_hosts() {
>  	local nvmet_subsystem=3D"$1"
>  	local nvmet_hostnqn=3D"$2"
> @@ -692,54 +231,6 @@ _remove_nvmet_allow_hosts() {
>  	rm "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
>  }
> =20
> -_create_nvmet_host() {
> -	local nvmet_subsystem=3D"$1"
> -	local nvmet_hostnqn=3D"$2"
> -	local nvmet_hostkey=3D"$3"
> -	local nvmet_ctrlkey=3D"$4"
> -	local host_path=3D"${NVMET_CFS}/hosts/${nvmet_hostnqn}"
> -
> -	if [[ -d "${host_path}" ]]; then
> -		echo "FAIL target setup failed. stale host configuration found"
> -		return 1;
> -	fi
> -
> -	mkdir "${host_path}"
> -	_add_nvmet_allow_hosts "${nvmet_subsystem}" "${nvmet_hostnqn}"
> -	if [[ "${nvmet_hostkey}" ]] ; then
> -		echo "${nvmet_hostkey}" > "${host_path}/dhchap_key"
> -	fi
> -	if [[ "${nvmet_ctrlkey}" ]] ; then
> -		echo "${nvmet_ctrlkey}" > "${host_path}/dhchap_ctrl_key"
> -	fi
> -}
> -
> -_remove_nvmet_ns() {
> -	local nvmet_subsystem=3D"$1"
> -	local nsid=3D$2
> -	local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> -	local nvmet_ns_path=3D"${subsys_path}/namespaces/${nsid}"
> -
> -	echo 0 > "${nvmet_ns_path}/enable"
> -	rmdir "${nvmet_ns_path}"
> -}
> -
> -_remove_nvmet_subsystem() {
> -	local nvmet_subsystem=3D"$1"
> -	local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> -
> -	_remove_nvmet_ns "${nvmet_subsystem}" "1"
> -	rm -f "${subsys_path}"/allowed_hosts/*
> -	rmdir "${subsys_path}"
> -}
> -
> -_remove_nvmet_host() {
> -	local nvmet_host=3D"$1"
> -	local host_path=3D"${NVMET_CFS}/hosts/${nvmet_host}"
> -
> -	rmdir "${host_path}"
> -}
> -
>  _create_nvmet_passthru() {
>  	local nvmet_subsystem=3D"$1"
>  	local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> @@ -765,34 +256,6 @@ _remove_nvmet_passhtru() {
>  	rmdir "${subsys_path}"
>  }
> =20
> -_add_nvmet_subsys_to_port() {
> -	local port=3D"$1"
> -	local nvmet_subsystem=3D"$2"
> -
> -	ln -s "${NVMET_CFS}/subsystems/${nvmet_subsystem}" \
> -		"${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
> -}
> -
> -_remove_nvmet_subsystem_from_port() {
> -	local port=3D"$1"
> -	local nvmet_subsystem=3D"$2"
> -
> -	rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
> -}
> -
> -_get_nvmet_ports() {
> -	local nvmet_subsystem=3D"$1"
> -	local -n nvmet_ports=3D"$2"
> -	local cfs_path=3D"${NVMET_CFS}/ports"
> -	local sarg
> -
> -	sarg=3D"s;^${cfs_path}/\([0-9]\+\)/subsystems/${nvmet_subsystem}$;\1;p"
> -
> -	for path in "${cfs_path}/"*"/subsystems/${nvmet_subsystem}"; do
> -		nvmet_ports+=3D("$(echo "${path}" | sed -n -s "${sarg}")")
> -	done
> -}
> -
>  _set_nvmet_hostkey() {
>  	local nvmet_hostnqn=3D"$1"
>  	local nvmet_hostkey=3D"$2"
> @@ -829,20 +292,6 @@ _set_nvmet_dhgroup() {
>  	     "${cfs_path}/dhchap_dhgroup"
>  }
> =20
> -_find_nvme_dev() {
> -	local subsys=3D$1
> -	local subsysnqn
> -	local dev
> -	for dev in /sys/class/nvme/nvme*; do
> -		[ -e "$dev" ] || continue
> -		dev=3D"$(basename "$dev")"
> -		subsysnqn=3D"$(cat "/sys/class/nvme/${dev}/subsysnqn" 2>/dev/null)"
> -		if [[ "$subsysnqn" =3D=3D "$subsys" ]]; then
> -			echo "$dev"
> -		fi
> -	done
> -}
> -
>  _find_nvme_ns() {
>  	local subsys_uuid=3D$1
>  	local uuid
> @@ -924,44 +373,6 @@ _nvmet_target_setup() {
>  			"${hostkey}" "${ctrlkey}"
>  }
> =20
> -_nvmet_target_cleanup() {
> -	local ports
> -	local port
> -	local blkdev
> -	local subsysnqn=3D"${def_subsysnqn}"
> -	local blkdev_type=3D""
> -
> -	while [[ $# -gt 0 ]]; do
> -		case $1 in
> -			--blkdev)
> -				blkdev_type=3D"$2"
> -				shift 2
> -				;;
> -			--subsysnqn)
> -				subsysnqn=3D"$2"
> -				shift 2
> -				;;
> -			*)
> -				echo "WARNING: unknown argument: $1"
> -				shift
> -				;;
> -		esac
> -	done
> -
> -	_get_nvmet_ports "${subsysnqn}" ports
> -
> -	for port in "${ports[@]}"; do
> -		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
> -		_remove_nvmet_port "${port}"
> -	done
> -	_remove_nvmet_subsystem "${subsysnqn}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	if [[ "${blkdev_type}" =3D=3D "device" ]]; then
> -		_cleanup_blkdev
> -	fi
> -}
> -
>  _nvmet_passthru_target_setup() {
>  	local subsysnqn=3D"$def_subsysnqn"
>  	local port
> --=20
> 2.45.1
> =
