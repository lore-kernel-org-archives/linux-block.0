Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EC223B62C
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191859; cv=fail; b=d9yxxe9T25inEKnm3Y240gnvjbp2r2mf2O7Impq2zLQrekdKW9oYfW5deLX0cHbZy3P8+3H41qLrejDJ8gAobGM4oY+/7TnIUUgk4En0Y0fXVtRYm3F3vMzuAIz1K3ziL2t+erjEvi1LEo7/++NTMZldnHWrM/WEKr1TfgyWPoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191859; c=relaxed/simple;
	bh=6ePXAgwqHd3VQP5e2W2+PJ/JrpR+J+N26q1t1W74JzU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d7zMTDURusybB0wg6ZAn/KUUAtMWlOZbBSqSogDkouyjxMvaMzxf0dpiRauu+Rnathe8qC74t44zOzNIndznvTJ63jY+Ar5zeCfDk0K2TkCg96IfoMU8fxdxyFbQC7396SVRYsTBkTRatk2JqWeAkBhJZyu7NJ78osGXSWgR1nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XWfXVj2I; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=f5BbE641; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XWfXVj2I";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="f5BbE641"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758191858; x=1789727858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6ePXAgwqHd3VQP5e2W2+PJ/JrpR+J+N26q1t1W74JzU=;
  b=XWfXVj2InhOAsqsjBy+OqHOXSI06tLhPrHNKVApaucqUgtjpeExyktdS
   hU6nweX1/hU+Nx35y+2MsaBVfdcfDjA1iapyLp5yvLsX+czYi1izOxK3O
   gKnlVn3/fHTJwUll3G3oJDBI480YcSxNBzzT1f4zhjcNmAeUXWN4vDWk/
   EqsZ6IJPIZ7ywqaRdWbPhSn9L50Hf7GBcXMx0YHCtzZdgDsP5Tavre2A/
   2KnIBbuaarFNmtGp3EZyG6yPGSbwWxy1wXMgNGqoAVv9keBQx1FCM43y9
   WcKChf8AZhmuIU/td8BGRoQCeWdCCSc5+HmeHQOgEFpGOxqzXIFe1sVFm
   w==;
X-CSE-ConnectionGUID: SoUPMW64TgirjO8YWn+GlA==
X-CSE-MsgGUID: FTWVv7sAS8iv6WUa852JYg==
X-IronPort-AV: E=Sophos;i="6.18,274,1751212800"; 
   d="scan'208";a="120642974"
Received: from mail-westusazon11012065.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.65])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2025 18:37:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9KWNtNBfvr9ygkgNoIjwXQZOeGQLmjeSSB7xz0yUcQriCVlvtQxTcC1OILULn0xliSWRIp082SD9ZKJXL068wSkCI1xS6YUNQkpFzKrkO5qhWPaDi8g3EcAZidue+YNg0K57k6fQvdoWYB3qy4G9O6RNe8BKDasI1bpn8pn6O85AWs9eX0PbwaiM0aIzb4YnfwArOSrKwm2bdkXsMRieGH+mJqvujnofba3dvLPXMjRlXEr/5z7lp0Q9VuJVP9XeF+0qNdWmbJaA0plAi4BF32dYpKVIKhi2y5gF51mnbpyDE2xAn+XLFm910c+S3RkwUhyHrmhaHECRcQdVGvS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjcueNNYfgvXL8govaT/yOE8en9biH85ZBlxZL33xK8=;
 b=RGMGOkfUGmAmHTaJa7f+/AO3NeQTnE3/3wX7AOM0K0krc+HmrIBxdjB1Z784QpLJO71KDUHvYOeG7ntHSG+q17MjtMgSIm2+6iB6GRpbU8fwcxR2ghOmx2/aPwsJW6bgB2LY6Z83LL/snWhomdpdqqpxUbUgjWp5NqDnKlpOmmPfX4eI2xp1SSVYeX53ORH0nPV7yvOQr+8AkgQoUtQm0TVYi7GoLYTyd8/+HPsr0PlDMgLGwnwmBxrdtlT0jgTfn4oSdjUyx3tQWjkT8KXuS2fRjL79X6QTuxeQU9MjHZuecYahCNxNo9TLSpUtZystsyQ8cBEs1b4Pi+Cazejn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjcueNNYfgvXL8govaT/yOE8en9biH85ZBlxZL33xK8=;
 b=f5BbE641Gi187xqOFoQ6bxQhnaCoNd+5Dq+aGU+gwu8vAUiv8GRHxH1DQV/PYan4iFADEkOlbTq1v8FRaI8uC23reYZ12VDLyS1N1oREeahhXecGDibTWp2EgclWDT0+K4XHE7/APlmPdS5CIuLVNXimZ6soC0cClY1WRqU5hXY=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB7509.namprd04.prod.outlook.com (2603:10b6:510:5b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 10:37:35 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 10:37:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/7] Further stacked device atomic writes testing
Thread-Topic: [PATCH blktests 0/7] Further stacked device atomic writes
 testing
Thread-Index:
 AQHcI8u2iSuhaaPAf0qUtMrB+Xji4LSVh9YAgAAXnYCAABqIgIAAB+oAgAABAICAAYtUgIAAE30AgAA1QoCAAM0ZAIAANYsAgAAvR4A=
Date: Thu, 18 Sep 2025 10:37:34 +0000
Message-ID: <zbhxr3mpchdbb25c7ybwyumxbjpgsmgf5krgwmshwct7f5isir@oiufokdefgzc>
References: <5eri4pgxaqhd2mcdruzubylfjshfo5ktye55crqgizhvr34qm7@mhqili4zugg5>
 <39c9f89a-6e6f-422f-88a2-3b2730b659a3@oracle.com>
 <70d8a0c1-5000-4a3d-82c8-2ac7a76056e1@oracle.com>
 <vpds7n4kuilakmqajzmkeipkkbd3wpehuf2ku66wevq2dlfwnf@wxne2chta3ir>
 <78cddd6e-b953-4217-b6f6-deab7afc38e4@oracle.com>
 <gf3x3fisrgfdeqin2dbjhzxyf4ha5ek33jam3orike6tt76b4f@6ixrvnqmktyo>
 <0b6e3e32-81bc-4e3a-bff3-816089892882@oracle.com>
 <267b6d38-061d-4798-8af4-13ef5f0ac6ba@oracle.com>
 <zk2a2pficfjptjkjsx2wd6kxh5padaop7ge7n2georpofke4fr@lzdzzdmef7qu>
 <c21f0ffa-5027-4bfe-a6f0-6744d9fbed33@oracle.com>
In-Reply-To: <c21f0ffa-5027-4bfe-a6f0-6744d9fbed33@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB7509:EE_
x-ms-office365-filtering-correlation-id: 17185b05-3692-42ac-03f6-08ddf69f6107
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021|27256017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?69nCGhzxqlAgxC4cZo6RVo3Em7GQ1pkNgAIRbaKB+Y2073Q9l4yJNiV/zqs8?=
 =?us-ascii?Q?H+515gKyBE+AblvJOxreuFsJxoxy6JXPRtwQANJvA2ixNKo3R9fLLgl1Poe6?=
 =?us-ascii?Q?+VGHlL0AR9feYdgQiXmBHzUZnR9S6sEf6r+ces9g4/XK+pu1r+tBkgE+vDe6?=
 =?us-ascii?Q?eRqFNICBf+UJedqF9YzpJBX1RVjen0PtX8XM5BmoAHktD/+IhJGzYQ77BOYw?=
 =?us-ascii?Q?8z6nNTWgoj+pnFUg/c2PMTjuM8hBLuF64dmc8v3EQd/4kql8ej0HzMOElpkL?=
 =?us-ascii?Q?N4uWW/Juvw08N4vLbjIp/R+wqUikPx9e/68AfjqBNDMvMcX1zJMdk2YT2HJ2?=
 =?us-ascii?Q?5XpntrCcO9TrOOE7VdyNMrbELTQ2PC+GhTOtXuFrWsZZO3lvrgCZn8Ykozqo?=
 =?us-ascii?Q?LMESTmdRfzsbjUQgK9ToO5ALSD2tRSk3GNrhFJ8WdVapuJl3M++doaFyOVbp?=
 =?us-ascii?Q?rOnUtjpZs6XoBzxr3blxwV8X/ic+otfTXzCnrr03Gjpj1D0YIV3bRR8VP89A?=
 =?us-ascii?Q?m1+FRZvkULgT3j83ArASOmMLjsA2UQv7MVmW6Yn3S+V196XmoL/qirbx5cLc?=
 =?us-ascii?Q?vjQBUw5v9s6KmzQjNv6v1YaDdACPOarNPhEAtNyEmLWRyfl85HMAxYbrvMUO?=
 =?us-ascii?Q?M221NpYgvTkv2PMXCSn1LOJqQUMrVHaZr0frH2kG/AvkSIhAcCdXxV19rc2D?=
 =?us-ascii?Q?srHtMZVcydCyrwa/nS7+u0WAqfq/XEKbnHea8fn1gy/VuqXkYqD+RW0lVW7b?=
 =?us-ascii?Q?U33VDwX5rl1uwFhkd88wli59DKRYm4R/Qlc9D0PykHUpejV8be+qEtyTGAQO?=
 =?us-ascii?Q?Q1azh8zgO3ScXEWZVpHPWB+1cDkkmSJMn8Y3SkbxWjs624JFbG3tZc3dkUWg?=
 =?us-ascii?Q?dDhoz2vfH3Ep3DZ4sXv0+G2j/ifYFKXMrJq41hfrYeE6XSexcuiPDWKrZ3wl?=
 =?us-ascii?Q?uQOHwn7CsMZgV48r1boFAVgkTMylPE+m7ijwJTDgRquvvNUIjq1uZHi+JXPR?=
 =?us-ascii?Q?BK8fTgm8oH0EyYI4TW7PkjiTtZAPsUDHj2K1L8W3RsFq3aMoqhEfNeEriifk?=
 =?us-ascii?Q?CnoX5GRN2mjtv7817CbVzE7iNV+gNvqzhGJZT5ZNw5Y8qfW/747MeZu3XQCA?=
 =?us-ascii?Q?5ORa/wp+FCLMlUPCfFBbCZ8wAClqrMvWQQozWaSnpNtpa9FEOvM6ot/Rg1pf?=
 =?us-ascii?Q?qc6V30fuXDa1iCV19mscJyOxupn6KxNSFYcdP4QFsuQn0jk4m6Mh8qwx2haj?=
 =?us-ascii?Q?wvkyfZ2w3iBf/55CT3zXJpH/9OYMIiOvvIEW+k1qrEqLdWHZLXKbO88PRO5n?=
 =?us-ascii?Q?MAiSek84BSk5x0ZaA2gLqVNErGFSMemHAnB/T6vGJcGKBHRBoyog2hNVmCNp?=
 =?us-ascii?Q?x9b5VPXIT/cYVbOdbYGC+lwKpDl9au1W5YQEwK4UDTi4GqRLPhhsj1DBiIxp?=
 =?us-ascii?Q?+BboeZlY/+0HyPt6g7iLZI+7yZHvvtoH7g2/W6a+6fryT2OIEQHujviYm21E?=
 =?us-ascii?Q?byPXwxIUycbleX05qp2fKRTISvQXT/1qo1uP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?db0z5OHU0Nmjibv+Dav06NYYnqce7YlEZR9UZFPWYzAW6YEPdVBe3EvZkEXU?=
 =?us-ascii?Q?7lNAY2X9N1TF0z3T3NHmgmyGmy6aXVbe9vkKCJPFZgsRSkedkLOmC0l2WkjD?=
 =?us-ascii?Q?BU7d0cKafdZrOZ/cWx+WygnoJp1R0mfaP17Ju3wGhb8zspnKNd7d3QOTOIlo?=
 =?us-ascii?Q?XPy+Mmkzu70M2Jn7dSgKC0nPhBiuRheDoxDeOcFVroOxMmK7T7pCrt+QuxbA?=
 =?us-ascii?Q?q5mCDnu6ySWHoX68VLmz3+/QljtTI9nZFuR6JQug/Ft09xbNdB9HuDLnRRey?=
 =?us-ascii?Q?UrnGN1AOfWwGNyWBlPPP9soOP5qh9kXImIchy/dQGo4+2C8DMkTs25fIqDXs?=
 =?us-ascii?Q?19WEfQQhM6LvNl8YsxDf4/PH/C+QVguvN4Kkurp9B38LqmsR44Ph3EeL8NZk?=
 =?us-ascii?Q?yZT1RLlGM44L0aTmpVIgOfNWeXrRqTyMAAcGO/XS13xNr8jrMyHIB0CGZcaP?=
 =?us-ascii?Q?mZTfSoDec0N/8WyJ+X3Iwqv1L+3mIO/FR29LP0RPNP0E9jMmDW1swh8B06MP?=
 =?us-ascii?Q?CaBiStW/jU4bMD4JAJnGX481u3EjI4/kqRDV/KewIxciPTyclD0nLoD7q8gJ?=
 =?us-ascii?Q?99Xd8b1aAfqaWRZvTTcJ9frpoz9jiMsJajE84rB9gXd+hGZqLX6k6of8T6n1?=
 =?us-ascii?Q?iEO+heKg72x0x6J258TolI2hvX7S/RRmr1vmjWFg5zmzqCNPhwXWmygFKdN0?=
 =?us-ascii?Q?h2SYy1EGD9+VjvrS897AfkC5K8TfmIpLTqqdZIVP1OKN5yg/tCgbMqlSuGWI?=
 =?us-ascii?Q?TRzDKNj1emuJTQAIDVozrwr0Z67xo3gQCsqoekh3DX2qRYnr9rju0e9ipqgj?=
 =?us-ascii?Q?CAJ8KjzgLIr/f9RgkOGXnf4s+SgiK83CPf6+zzYesUYGxtCzNQBj4LsUObLs?=
 =?us-ascii?Q?CBu9C18dWc1bGtCTBvZf80sPEeQ7Pb3BBJC3fKTQ3+Rwp0QhUvH81M0fT6Tz?=
 =?us-ascii?Q?Fvk37hgbuEOy6rqQ5gS7YArAcMWEc1DO2hL9J/ddApPcZu+hOAZhmDDd41ho?=
 =?us-ascii?Q?snasvMrgPqg5VPgazccXyDTrs50xER2Paw/tA0orKo2Ds6n6/ZQae13xSoCJ?=
 =?us-ascii?Q?kkBgWGc2XhKwskp34Zumtw0KSKzCj79mucNI9wD5r5Von3gk6yV3mbbxCB8c?=
 =?us-ascii?Q?6LLu3G3AdgLdYVinY1tBQNkbJvYAwg5YK0j757zmdvMhtIyGH9nJBgWJDRjm?=
 =?us-ascii?Q?MJq8hNENyux/NB7DLTU34vlsRDNfCZOLlICKkdhB8/3ApZeOQaS9rCez0eM2?=
 =?us-ascii?Q?FZEi69DZDXFZrfTbR7zKUgrk+ib/0ny8W0N4djjtjAb3Lg3NL0KeTAeDIvpK?=
 =?us-ascii?Q?GyThJPBkj+3KwwR9Wow/cEPD9R5Q5yJvCthHZa8vCTVM5FCXHBC/L5W0cSD4?=
 =?us-ascii?Q?oPV2LlilcfWHKkjuQlR6JPux53lKcmcb4tIj0nLNVfhOom3/OBh9+SPHlPQp?=
 =?us-ascii?Q?A0ZzkVmxOnHs946Hbka1+k+jRGsfJp1Rv0TO6vacJmitGpPm0L5NSX58f9yk?=
 =?us-ascii?Q?qHP1PgHd19eSnY4Chq91d3J20skS3wB+Le/cnEvQgcw3xcx3pTX4lQXhjgHy?=
 =?us-ascii?Q?ly5Sa7GB9Tt8zq8IXUygkSPED2VG8tJOnHdWX6c/rTEYqKjGsExezJzbm0PM?=
 =?us-ascii?Q?FCFGWkHUGvgMngBApHKpZS4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <706DB226A6AA1145A406A6DAB68FE56C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WQa03VyCaS1oPyzceEzHie2LrUaj5awkz0R4+9w+8ztDbovuUni23wTU8124o9LDjSFeg6ktfxBVazVXWg8vnyWoiDyb4UUwJM8xgCvP5nZzKRuxckorCeNZ6zIi7Sbb1RVFp8JWqBBky+EtOMK4ERXb4//CDZEdj6vfl+7v/8DxUZ59IWHwvtzzQQRoRE3IVK3cb9ehVB4jn2KxKI3N/1k5NW4aZcX37GJqM3Mm4z1PWNFcnzVwtF+jXU/4v/icMzkKCFgXqHBJHvsCyvhG+CBB+imeXLFGPHqweEWoAGfqb/OcnxKGV4FzBo3vzDMzsNEk66UTCsEVg/xY7Dhkbm/wASPugbt4VwMuc2gsx2LT4DzoPiXSF205mv0Ne6a6Yy7dIn/8rVRaeY/WbH2rptlGmpNvSVCOA/puJRfuf34VTf1j0YqMwCOGSUu6ROIn1bcQtXsG4p5txXGZct2w1+/raf0gL1ZKtr5EpQj9drYnnGsZH1atboVdutxpoh1iiO656df+WAAn+XKJH+g9LyKFSRAmlSITNxpiZMXkqFQZw3CEowUDcOl87PdkXtsBkEvZWR/z7PZ48thhoYf+bEeMRKibYHpcodFt3C0A6rnYEbAkO/4GQONL+ZgEVPTg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17185b05-3692-42ac-03f6-08ddf69f6107
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 10:37:34.3965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ON3pD0lQaaQQzNyeoaS+V6FAu82GLI4zuKZ8NGJfG5YjShp3za9QCZnCo/C+UhmLxl1y5UoNFSIjwBdXvMTCRQQ8CGPBlF2SNRDFRuGeXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7509

On Sep 18, 2025 / 08:48, John Garry wrote:
> On 18/09/2025 05:36, Shinichiro Kawasaki wrote:
> > On Sep 17, 2025 / 17:22, John Garry wrote:
[...]
> > > About TEST_CASE_DEV_ARRAY, is it scalable to index this per test case=
?
> >=20
> > I'm not exactly sure what you mean with the word "scalable", but I gues=
s
> > you worry about many config lines of TEST_CASE_DEV_ARRAY[X]=3DY for man=
y test
> > cases with test_device_array().
>=20
> Yes
>=20
> > The series allows the keys X of
> > TEST_CASE_DEV_ARRAY can be regular expressions, I think many of the con=
fig
> > lines can be combined into single line when they use the same devices Y=
.
>=20
> How would that look then in the config file? More examples could help me =
see
> your idea.

One of the patches in my series added test cases from meta/020 to meta/024 =
to
confirm the test_device_array() feature. One line below in the config file =
below
can specify four NVME devices common to these five test cases

  TEST_CASE_DEV_ARRAY[meta/02[0-4]]=3D"/dev/nvme1n1 /dev/nvme2n1 /dev/nvme3=
n1 /dev/nvme4n1"

If these four devices can be common with md/003, the line below can specify=
 the
devices for all of md/003 and meta/020-024.

  TEST_CASE_DEV_ARRAY[(md/003|meta/02[0-4])]=3D"/dev/nvme1n1 /dev/nvme2n1 /=
dev/nvme3n1 /dev/nvme4n1"

>=20
> >=20
> > BTW, I made the detailed comments on your patches. Other than the comme=
nts
> > and the adaptations to the test_device_array(), the series looks good t=
o me.
> > Thanks!
>=20
> thanks for the help
>=20
> How to co-ordinate posting and merging of these series?
>=20
> Shall I repost mine based on yours?

Yes, I think that will work. I suggest to note in the cover letter that you=
r
series should be applied on top of the test_device_array() support series.=
