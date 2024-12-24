Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B5714D2BD
	for <linux-block@vger.kernel.org>; Tue, 24 Dec 2024 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735044067; cv=fail; b=HoTvmkyyHjR0heaL0U/yYzMNE9WF9vi8drDa2IHL0wTgJgn0cuIawrn0O6Pi41h4eE5uAcJL9qwYqMUAb2NGL9Z11nA/tHBchTit412fvb4LWgFin6bp3PZR72YCr/LDRUJWWC0DtRUpZcv0GLI0Z5wUIGigbAjqllS+fct2fSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735044067; c=relaxed/simple;
	bh=gCu1eYyhJZrSLE85ykX1SxRRO6r7TQfEAWHVdQ8RKjM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iayvZE6rI94Nouj2bk0DmLL5F67GueovE+tAG0wa6aI1P8KYr0dFz79JNRJNvl6z0y+7rZJXAj59YWCFJPyuM50qgo8X8BbEiBwMwkYShGZTOVUaoD+bIDfUMbVuHD/wfVgkBjtdQlesBrg/+eCiSJmwwSkgHwyYRsSJJc05tdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bZ9AW+TW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SKCKE9+V; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bZ9AW+TW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SKCKE9+V"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1735044061; x=1766580061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gCu1eYyhJZrSLE85ykX1SxRRO6r7TQfEAWHVdQ8RKjM=;
  b=bZ9AW+TWUwt5aTRvnIBnh/II+VVR2sB+wZHVZR/dYWoslDFbGJVpTgIX
   vCft3WTuyLOdpjzy+pW2kgQOsUBNG2Q/jrNE2x5JxNaS05JurYoKjU/P8
   Ios94sM2zvq2qEnnKRBzxN8avEL2uDi9DR33EgSL5xV9Uafee9KMvgEFq
   I2ih98Z1uiX+rJny/8Zk2LSFcHgP//OyjZHfGEOQ0fMzhOtmjb5TVXUon
   Y6BFP8X3jHU8YevIZ7V+uRZc0hef4Y58SW/buGefnnUkFztya7FPrZ37c
   PsI3hxf/ORE0iX4rEWMvWaaDCpSBFrdcbrzWtjPQBzGHEqYwOOJyu4vYZ
   Q==;
X-CSE-ConnectionGUID: 8C37Bt08QrWijS+hW4kPaQ==
X-CSE-MsgGUID: frF45U4+SFGw5OynNYqCqw==
X-IronPort-AV: E=Sophos;i="6.12,260,1728921600"; 
   d="scan'208";a="34417377"
Received: from mail-westcentralusazlp17012038.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.38])
  by ob1.hgst.iphmx.com with ESMTP; 24 Dec 2024 20:40:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZkQ8qz+q1BxzgNe5+IeoZmB3zgKnd6U0kn/uhfPEpP1IXJyDE/LjOoUVnw2/nRYElRaODdknZW2b0ll12ZApls7X8FPG5oQFWWB6grkoLWA9v/0m6+pWtbp9EOVfQRjaB3sBoSTf/lgyJXUcFyy0ft/qbqXhCh+/qD0SGCv/Ka+A3HRVeCNMuMGBIlStFuvKH83/SZQN1moKcaFG1r2QwerxobYEg5I5WO/mdFZJdjJxpVU4EHLREbzukeT9jzfSFt6VdyE59HqUhi/7VCyiYKmFwhZ+5rQgXM9t+NnJ2kvxdTpUrZkUE/e9em1+07THD1bfDM1Z+iFWzMuc0GuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWQ79MYRaBamXVkhmjwOtl8NNgwqfMogxDAHbXsPC6g=;
 b=CCozHdSmcNg9yI3PfLUd7E1txO9JymeF0BgbaH0r3iV+Jg3nAeHGZ4S5FIujQ/T1a42GC1tgZu1eY4caRzhCpCKDGugsAH02nKq9//k3exiIAYqIHrNY+9GNmh+12/DQpcbnhoAHtq0s3tXVPceIJ2UTAMEQf6F9egicnGZhK/goolbltnNucZ6v96bI+/qQA1lCUnW+PIaEqMP7v8lZCE9nZ8non63F/P2NA9BGslMcEoQukg4UBSOgMUWD/FROrxefVbkjuwsSYnHZCl62W0i/A+TDdaWaZRs0gP55oCypTgne7pJxyGj6+o3CWYb1qRRJJIToJTZPHrmpok7eDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWQ79MYRaBamXVkhmjwOtl8NNgwqfMogxDAHbXsPC6g=;
 b=SKCKE9+V0YEgdyEGlr5fdBYrMhjhDzNE507We5zD2elZHgjouYj49+NcJ24Fl9sRuFaClq89VSuBackOBvopX17gS1oS/+EJG4xSwYMRt387cvChOAoSAMpTGWAD3jGmAosuEzwLpiQxS6uAGMsYwgdS+Y6UR/14bnbUYxcB9ZM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7617.namprd04.prod.outlook.com (2603:10b6:303:af::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.14; Tue, 24 Dec 2024 12:40:48 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%6]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 12:40:48 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH for-next 3/3] null_blk: introduce badblocks_once parameter
Thread-Topic: [PATCH for-next 3/3] null_blk: introduce badblocks_once
 parameter
Thread-Index: AQHbUXIkItdsY54CY0eGSQmKGM8jP7L1XziA
Date: Tue, 24 Dec 2024 12:40:48 +0000
Message-ID: <mp2sx66ha45laynsq43snccne2yk63pm42eeirgc36wl3adb7l@jjt27flazxxq>
References: <20241218074914.814913-1-shinichiro.kawasaki@wdc.com>
 <20241218074914.814913-4-shinichiro.kawasaki@wdc.com>
 <cccb6cb6-1582-421b-b9a5-6f0b2673f384@acm.org>
In-Reply-To: <cccb6cb6-1582-421b-b9a5-6f0b2673f384@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7617:EE_
x-ms-office365-filtering-correlation-id: c67e3efe-b91a-44bd-b877-08dd24183180
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?V8JjFvjdQ3Bx0BydGYoqWyK9ggU6O2CFqllMG/lI7PNIrrox4SszwSPIb1aC?=
 =?us-ascii?Q?maMCczqQSs/Bhumx5HPjtyvyaSuCoG2p+rMalK8gLR86RV5CDtP+Yt4GB4vB?=
 =?us-ascii?Q?TLIjAsD5pwDO6w5RgJm4XO6lS4SfEC9Gyu06B3EwdS9uJCodxN7WWXUIEZzc?=
 =?us-ascii?Q?n1N74KMz8QeW3vhXoPXrDkcrCU9gqi3hmoF1ZLYEDDM61xUMWvIU005S1th5?=
 =?us-ascii?Q?EG4ztKvB6AwBqjy8+j2LzMDh6m6H/8bkFiY+HCC83mKuLivPyGHbly3E4nep?=
 =?us-ascii?Q?3drzq5rjh/s463FI9Bm6+8hW1CKZEDSYHWkmHBc3atZ+0QQSuAV2ImzaGvLh?=
 =?us-ascii?Q?5KU0wf1RTdXq9XfMibi6DPq+2b6oQeo0DTopeFPoA+mCc1B+iyGDbDwoZUyN?=
 =?us-ascii?Q?69p3U8AbcXPyIqzJrnYvWukd4nZ3AmQtPRb66gTFwiq/Hui6DimwkMMvLVl4?=
 =?us-ascii?Q?WHDcpCTR7+lh07W65Z7f94mDjSzdjOm1FvT6fJTWf5hoU/yDsLR9B+B9xtXS?=
 =?us-ascii?Q?Zwt9R36cShv6NhmlJthaDQWMuuk5JwQta8jAv6dqoM32VO0Q2VycuaSNP12Z?=
 =?us-ascii?Q?93pNROmZYZijohXZdarEH9D6w3j6VzyoSp424SG85QSWD/jhs8jkuyHGgoIL?=
 =?us-ascii?Q?vK0zcf59Qih2VKnlez8aKsni7oWoJf/rSB7TuKzceQpYP8BZGDsxvS6TmTFr?=
 =?us-ascii?Q?3SpDvJKY8gU6QSLMWzQb+X/rvyXc7vE0tVilcwYjZ7DNJlchFWYOsk1gtFFW?=
 =?us-ascii?Q?XB6PA/KJrzJf+/kWVFdYzzJcgZQ3w3/iYumNZwigchtit8bS4qDXw8ltgaNW?=
 =?us-ascii?Q?a/Mpjk9aSLbk2pSKPI5ugVERgwrJBo5cXjyfc+HgWEMWtuHQCA2+EYBOcelX?=
 =?us-ascii?Q?OBr/ih84s3JNozlRgSDlXQ5j4phbxT+wdvtHcjwEN8wFeXZczYuzYxn2aERD?=
 =?us-ascii?Q?cXH9lvxfV83QJaTT9HU41oJgrEMY6YEMsN32PwRWydf6VP22UFdSYmnf2lHq?=
 =?us-ascii?Q?MmfgWcVtEDFgrSbqpgm9AwUVN4GTTC0fFixqbGU8+jQBJo1LsxSml8bDNQ9o?=
 =?us-ascii?Q?x5VZoWSl7RaqluRzqXPf/uB5hnnjuTNL3NajCmCSDVJvcPxA1XPh6qbh0636?=
 =?us-ascii?Q?S81AchSesKtf3xSyL761dFwCl55vUekV4sSKGNdep2t+tKDUJLraIi+e1TxB?=
 =?us-ascii?Q?HuRWwq5/H+1jWgRicId7BACez1Uyl72PtRLwp1rGHrv+BT//VzLPHCfkQC3q?=
 =?us-ascii?Q?AlK9yWxkTnBz3vZ3MDHHm1JY94tY6eeLsFHm8x656zvqwyQk4iB8lepzb/RS?=
 =?us-ascii?Q?V3Z4DL5BDMST0ssVHEbz40hfemOcxOfYE9ANYaAID9EvmNiV+B7DIBYgHCXg?=
 =?us-ascii?Q?gTrL7WdEytX13tVXXx5nbcAArfMb8rOHLmqwHkXZ3DA4k8NJb02oYJ85g4SN?=
 =?us-ascii?Q?5c6tAHoPbNVry3vNzbMJvnkCHEcS8OnD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mPje76FoNLLnmKBlqRbdnvlDo4lutIwbVeZoCa2KzCDCNJ2prAGgqRx+cluJ?=
 =?us-ascii?Q?kdjqvFDK2wMhxSQF7BIJzOsm5V+3Qn2jlFhLWAj9NCuOLkM38WTTEb7MKf+P?=
 =?us-ascii?Q?U4MWwg7HbeHqxFfA1kPBntc6Ar9IQLcEV9so7IP1adE03O8J9tVoXAshRKAq?=
 =?us-ascii?Q?BL2bzlXp+V8I4PxjMNTU4rDezeZvFYEYloY2Igkx7lyBw5lD+VzaHa+J2kX5?=
 =?us-ascii?Q?c3H9G0qeuxqA2zO04ZaqonGT9+uOTKTIz9WceQEjRqmn15Z1lt5biGnnT2mP?=
 =?us-ascii?Q?G1e5GBz9ojh0ewwlTlSNzoaWs1BeJs1/VPk1VRqB6A4Xwn+Z+WUtvNtKPW6s?=
 =?us-ascii?Q?xFfKzfZdGt9PeLnaEz1qQ0kST1qT1F2674IHydLyhVhhcZ3K3/yolnDfGN0H?=
 =?us-ascii?Q?MHiCQzPsVqFNMKoapn+d+0+BmQBEv6AQI+Rd2QtlrNGaifcAlOh7KtY8B/la?=
 =?us-ascii?Q?HAc3f7cxtq7xZM3XPSDcR8jjPa15Tfm/yq2X0xkgyx1kxd/ZvoaZBWQQIYXe?=
 =?us-ascii?Q?nU6ZB0YVUUvz5RvY3ZlyIGqkCdD5oTLdWJHo1zrYOUAPw7hJz/s6/coAjrdW?=
 =?us-ascii?Q?yv3yxwzibt/l1oFY4dnB5TLMGGuWwE7oyQpJ3b6ovxApsnWKBqzlK0vosqX1?=
 =?us-ascii?Q?nIOnAKcYrbB/hjY/Qydd1avga2lOJJ2yFb4whDtmFIybDDDl4Gu36VRJMF+e?=
 =?us-ascii?Q?CRjcgr2lE6UCgxMUDD7jRmME6t37XqjOUndrIQ/WckzbLPEM3taOLcdws6uF?=
 =?us-ascii?Q?exZG/k5HD3FypYoR9AbEGNdAj/spcxdQOV1E40HC2fixOn9DcC00s0n2jHos?=
 =?us-ascii?Q?PPlCXFWzFX0/WOWM+lPgTyoeqVpe38kvwDDxTzAdUzIubdoqGYjzv1/P56CN?=
 =?us-ascii?Q?451iRUOGT86uk2LS3nYJ9pl6tuvpn0ygfzy3WDwOpfX331CmvhQcPV5tZioT?=
 =?us-ascii?Q?tbizcpfzj6YywDU8X3TV+T7xzohIk9r8eeqmbUAvIVt2TzFyZXFZjgCApsMA?=
 =?us-ascii?Q?1MTW46V+dOeN8/c7YDQxgeWqKA9RCyYOr0s1IdpLsnxGHPJVnWP6PLdqFEaq?=
 =?us-ascii?Q?WOzxdnkvG5PY/zbIFvN+TeDYNUolW1suEpnOnVEWIAcxmS/y2Vmmv9Cobp3F?=
 =?us-ascii?Q?lhxdvfefuxuwCcEugVBlHubdC1S9bMMURVvLN9Az2NMlVXFrh45D7iFO9Z9B?=
 =?us-ascii?Q?yxiFK8qX+1Kz34EFFKpK/UbHdgKaO3JD+LpHAZ4lCVT+s9BK81/kWWXAN6ZK?=
 =?us-ascii?Q?je0l9i6zTcLc3laChBihsuduKrEhl3MrIQM11TC4q4+nhAkTsW75f1/xtF66?=
 =?us-ascii?Q?0KQjmTwHR4jQAmoRuYzZ3GZQ+dKvsgN1R0fCDSLiQlZeDhRTqKDD/46PGzKu?=
 =?us-ascii?Q?KdQqqWvJtM+vBZVbs4HKAXPS9zeRiRtGFOFb6JzokAYHKxW2OfX1IYqKlUo3?=
 =?us-ascii?Q?urtphqPZ/wVSqGvbiGKep/5ZlhuMQ7uKHzTjvQwbOvia0sP5on2DtjUwSzr9?=
 =?us-ascii?Q?OZRZDWDDfrC5xyE/FjGs76BXbVhwT+8CIx1OO7YnYFqPEMkmoOlqscAmeMYL?=
 =?us-ascii?Q?3Xrmw8o+BRPP5SduMwbZkwstdrrS56b2lSayVFlXtdyZod1xXPcf3L8Yt6/o?=
 =?us-ascii?Q?vNPN1fuAzkQlPNm2YXdgyzY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25CE705B438E5D47B4C0E2A1756FB8B1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IhiH5nnL5t1M27ivtPyysqfyDJph6wubTUbiPYvfET8pbEpZEOvzX9MUSy5AVwzDWpNsPgr4lNpgkA6RiWXDJuVDdqXkS6IX4QKvv+pSEZb9DbL8zzhGtG1tFZt7OWQVo69UR3vO5mivfgDQ5ggp4YHrHJbh/Upw4xlyxoW8NIwcVtsu0mxEPLxh5ZTuRYXV9mQtStj2lEAAufbhyoaQbfxzerZltSOfTCfQ06s4vq1kxlH/x5gVeG1AcNt1lWaRQlHMX57jk+o2JmfBYE+kq72yrHwgMkVPo9uihCpP3qUc0ePiHzz3IxsgursJadiuFCLW6wZfDdhfl/FkKNO6zW81grvXa54XqejoMhX2sPV+xWkXPxwa8kn5ftDaUcm19XT6cFOkp+cJsBR0p3iknyV4Z9KkJQ+urTG84hZHmYvao6OPqPrYg13BrqhLUj7WyEM5IhIZWdWd4kUKuRHiuwGotagBcjL4bWNVUVAwKve7bIqJYVDPmPO35ytQQW/VhENdk2xyWRlJu2DkEK9KD5Bb8g5rn2DWCE3Ft+BSTTRJ6Jyzl0Pq1DteItiW2ig85Yn6vnCZLgRFD3u1HDKU9fXL4cLE/xadOE6/4E30R7Ih2JNoWLC2BLk01GUvvGmA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67e3efe-b91a-44bd-b877-08dd24183180
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 12:40:48.4501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htaeo8GVa/ctKuRZOP7ZrAdrKIBASEteFlqqhYnEFoaMdy81hfosOd7gFSc9O7p/Evz6ekn3vxBiHqhrCo++jHzn9cCl+P7izVWoRx8EWas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7617

On Dec 18, 2024 / 09:27, Bart Van Assche wrote:
> On 12/17/24 11:49 PM, Shin'ichiro Kawasaki wrote:
> >   static ssize_t memb_group_features_show(struct config_item *item, cha=
r *page)
> >   {
> >   	return snprintf(page, PAGE_SIZE,
> > -			"badblocks,blocking,blocksize,cache_size,fua,"
> > -			"completion_nsec,discard,home_node,hw_queue_depth,"
> > -			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
> > -			"poll_queues,power,queue_mode,shared_tag_bitmap,"
> > -			"shared_tags,size,submit_queues,use_per_node_hctx,"
> > -			"virt_boundary,zoned,zone_capacity,zone_max_active,"
> > -			"zone_max_open,zone_nr_conv,zone_offline,zone_readonly,"
> > -			"zone_size,zone_append_max_sectors,zone_full,"
> > -			"rotational\n");
> > +			"badblocks,badblocks_once,blocking,blocksize,"
> > +			"cache_size,completion_nsec,"
> > +			"discard,"
> > +			"fua,"
> > +			"home_node,hw_queue_depth,"
> > +			"irqmode,"
> > +			"max_sectors,mbps,memory_backed,"
> > +			"no_sched,"
> > +			"poll_queues,power,"
> > +			"queue_mode,"
> > +			"rotational,"
> > +			"shared_tag_bitmap,shared_tags,size,submit_queues,"
> > +			"use_per_node_hctx,"
> > +			"virt_boundary,"
> > +			"zoned,zone_capacity,zone_max_active,zone_max_open,"
> > +			"zone_nr_conv,zone_offline,zone_readonly,zone_size,"
> > +			"zone_append_max_sectors,zone_full\n");
> >   }
>=20
> The entire list of attributes occurs twice in the null_blk source code.
> This is error prone. Has it been considered to modify
> memb_group_features_show() such that it iterates over the
> nullb_device_attrs array instead of duplicating information that already
> exists in that array?

This sounds a good idea. Will create a patch for it and add it to v2.=
