Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA62572
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 04:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729831745; cv=fail; b=dMXp+LG7PJj19V6YQz34bE4RBuvHGUT/jyBJ7m3p1QYo6OZZNBrGUw1ZSLC8Yj+n1GSS2mZcBsaNjByQenZkmvrGCZEuA2b+jizYJ7CjM7xPnspsSJXNO/Z1k9ezCeAcHH+TEz2RG0pbkLMcdmY5oH3Rs/W5dclXNQilquVXius=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729831745; c=relaxed/simple;
	bh=GV6fp672ReCnJ7vHtwomnD/3lgY/D7B8dj5Z/VQAkQA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TVHxq/xhhEYRN28FwqZh9kMX7JM1So4AkUQLxiaT90BC9qBDPz9UqJVSx+h+k64V4/qtSuClhHu9d76P1c4V1A1/pYqsXUp5+XKREmLl1zTOTisQJmCUxZRRGM7Wss1/HPpdpHtf2utGW4aKXHg32VI7YFtVOFHvMIVNLvtmvDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bhhE6kU0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dRKPQYGv; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bhhE6kU0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dRKPQYGv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729831743; x=1761367743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GV6fp672ReCnJ7vHtwomnD/3lgY/D7B8dj5Z/VQAkQA=;
  b=bhhE6kU07PJ1RKueDWtPgma8VtpKlRvwvpFPCAVXSER/MEceK+FCZipY
   cWL7cnUN6UiDYF7cRBZDBlD9dnU10B4wEMuuHmBRH3zJ3Qh52JM/pFx7a
   0ndwgfcCnzEgE2lNBFCDoL14YnAk4VVavjuXK0aWtNuQS4zE04xOyeVs7
   SxYO18DlgItnoHvK5PJWbMusmJnbKpVOzswRHdls2925eY57boNoNCoSB
   J3LySMDlUOhWzfWTU1xYZNdwp4A2WDd65KXluvIyhjDiam/ewoMfBWouj
   C8yYx3p7zcK8laUKFRIkD1ogDDtO30jBu0fKypezRD67CKY5dmxxcEuHm
   w==;
X-CSE-ConnectionGUID: qsONBtdyS4GN0fYgTFzj4g==
X-CSE-MsgGUID: HHuqSg1pQsaBnOiMGreqXA==
X-IronPort-AV: E=Sophos;i="6.11,231,1725292800"; 
   d="scan'208";a="30323793"
Received: from mail-westusazlp17012036.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.36])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2024 12:48:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSed0U4j569vGDTvrWnP0ZcJDyR0J4ETxetdZKVzys69LjRsxWoJ1twt3cZjRlHkaw3xYK8bAKAmJW11ktmmyyfOl+/v9SdkCEsyNsa96ninPGvdwrGKcBuqIQBqfOTlTUQO8Ia+4UEQNTI5iCBlvC9uGjaXAnyY4L5bkpYvxLqs75Gpfg8PasCzACmLVoSXdEpu+g6uXdHeZlV9PFpxXquL44ov/Xgz7ohzvZG7pzAeupPV4Kq5ycqv9xad1eujYqYnepM/udYFvM6CcCHeiwdsfDzoT/QzskBfwbd0N/0Ao25VrrYWnBvVMG9MY/1TJW1wVnCw8VONTnmlnoRV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GV6fp672ReCnJ7vHtwomnD/3lgY/D7B8dj5Z/VQAkQA=;
 b=l6k9+YDtVIIxQgzBRtG7liVo6zlUSu/MwsEX2Tuic9ogUYpSwcuGyNbMz8ZsU3vWYEGKtfHhYn4epC17oQF+MHovTvN9fcZH+D2XRGaVfl+YdMGhxzIRx9LWfeK6xwl4XJ20RK+sBDQCvvvkntQD2EIoDryLQGbryWgjSvw/xubIuUlH3UybHWJ7bP11Fukhx3hB9i8MMSSqaH63QGBiRdrr5lRAKDdDH/ZzpFeAdFT2jEqnRASNm38jFJ7lYCiFqLnbnsFR72Ftex5UdWzlHAKD+qBv8bKJycGiZ8KZPpYYQO4nhbSNtyWOwSvcesuwsTxVEEn1iU0Aoyod1Hxh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV6fp672ReCnJ7vHtwomnD/3lgY/D7B8dj5Z/VQAkQA=;
 b=dRKPQYGv+c1se8YCOwFBehUI3GD2rko8EjwN9793/EWna/Xc8LpfM0LILuK8DHXij9pig+2UTCTArwTSdEXS4c65KfEJsbWLaM6HemiJCDHKXsyXnXjxMc0I8vOeHXiLk40hRkRNhEcNtJvdmQnYfuRk9eQ8nYi6H5X5Ad+c3sU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA1PR04MB8827.namprd04.prod.outlook.com (2603:10b6:806:389::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 04:48:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 04:48:54 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block/027: setup scsi_debug with MQ
Thread-Topic: [PATCH] block/027: setup scsi_debug with MQ
Thread-Index: AQHbJE1qMZWLbEWrVUWbX0/i1kELDLKW6caA
Date: Fri, 25 Oct 2024 04:48:54 +0000
Message-ID: <vfv56uyaqfy2exidfydelnuzwisaoy24o6bn75facpyan5qymu@2qo7ho44ns7e>
References: <20241022064109.3303704-1-ming.lei@redhat.com>
In-Reply-To: <20241022064109.3303704-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA1PR04MB8827:EE_
x-ms-office365-filtering-correlation-id: 3b5e5556-ddf9-49aa-1c9a-08dcf4b0546a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eE5Ft/bw6xLU2ItXo4slLjF5eJlSmE/JaHNfat0BHn/Z59ieRsNfWn1eX4t9?=
 =?us-ascii?Q?OkyvUBzH9JVRQTEKSjfDTkxhu5un0k+HtKWJofJmrJeDQAdMh4tt7Uark+Uv?=
 =?us-ascii?Q?dxeJzMdDD+RZAY10dYZ4SUSfncTKcr4vRwxJeJA0koBivjXJCY/6+DGuxTmW?=
 =?us-ascii?Q?peuMFJyfig4OGVEnTR8AygMZ+30eFRrjtl+vazxtCkrh/gopqlbscUROcixF?=
 =?us-ascii?Q?aOdkh8Ro98RYbrxZEzAyQXCM9Zwawu5jzeT4x9RyuoM6SoMd8BCRiczy20Q8?=
 =?us-ascii?Q?ZHIOQYE2qyabsZyRL3eFd8+DF5f3ysc8CQ2JZUK7tF+RYZB6VfQ2yiWJZ5SI?=
 =?us-ascii?Q?zHsxd4w09VkDUXA56ELPzefIigBlQx1VPf7OqVkW4TE/0Hy67qpzlx19Mwgv?=
 =?us-ascii?Q?O1hylXLphdj9q0VO0CKGDVrUKVW7yBonNN4g/VL8VDftaNTwNYcYuiqOz+z7?=
 =?us-ascii?Q?sWO5AgTHUDZNG8ox/jQFMBtyC+Ud8JDLTOR6rXHTWpsPmtaaf+0DVegZVA/y?=
 =?us-ascii?Q?usHk8z4f7YTt3ebwD9UAJ1+cIigSFJQycuiObyFjbMAUZLUeuK3bDNnV0ihN?=
 =?us-ascii?Q?Nbgmgrerk4Smznc4Hxsblrdvc0rtihzufmCo8AKwCgIo+rVLu7fzh7CQ3C+K?=
 =?us-ascii?Q?jdN/QBzuGMid/zjOYIImBSsXVbAESKRDl0rRfdxDyAW3VV39ECoksRXjdNcy?=
 =?us-ascii?Q?yjJuojoy7L76aMgvjXzI5l51bkPM25vZMHm3Wm5XJJ/xPIdyZStwQDE0WXjO?=
 =?us-ascii?Q?Rzmb7YpNfIO/TWr+vLi7UFffAgzvXCuhiu38dKGZ8JjDMGsWFl+Vvii9lvWP?=
 =?us-ascii?Q?57H2IK9984zUaUxfn0YItKCTD8hSEh+ESM/YmlUuyqXn9ysJXjT+FFKEmkJW?=
 =?us-ascii?Q?xqyVln32d4n+u8QH9zkCdneftdLVOG7yt37+SITfpvpSFTmQ7YmbVVUwG/oN?=
 =?us-ascii?Q?xtwZNYoXV0Sa9WjhL3G0TBDVUeaidDQZv2/rNbAsQqv2473CiTVmecANPnZo?=
 =?us-ascii?Q?p8JBGR4jqltyfhKoLWjxNVrUTKmVlxAIuR3yyg3eIEBGgdw1viwMQPOxKzJR?=
 =?us-ascii?Q?DIKyL9kZPyk1CsJrbZA2P3co76+hdiwsp4NoXwBjkEZnOP/vNhnFXHQEAAFx?=
 =?us-ascii?Q?Bc/unx8m61Hx6ADfP1ldV02ceBXJGXgb949XWCIlbKCfVYZxrwS07KwjTzA7?=
 =?us-ascii?Q?u3qz/ObKAwA6cU8WjE/NW/nGCRTjINQl6aozEJSQx+cLvsF28MckJU4EQeot?=
 =?us-ascii?Q?AXhfEjjVbJWRpfIRpjGWaVhDF599pzFd20qpDExzQHseJ/+t0vjPHLz0Nvad?=
 =?us-ascii?Q?m6FmUlc0NCpqa/4K/jFPBICdQvmDxlfbkqzyMadTMkI313XfLsnePdWqHaLe?=
 =?us-ascii?Q?4Ktrzgg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jByAwhP7tAiLt9N3wgK/pMd6krJNwuOMgPL2HCsem7ehsJpcrP5YpkMIGxNO?=
 =?us-ascii?Q?keo/mxvUdRopR/tA/GQaRCaUIb5X93v5MpscbVkLebuJ7gtaB3DLvy0KR1Tq?=
 =?us-ascii?Q?OPKzHSOGOichOcJtLfRWsGCyAcE17/OSMKDWQYBOjSgwPO/32zwXLQSWzldV?=
 =?us-ascii?Q?1PsAcQjrPs2Ifa3CWWm/xFXNbPd6t5Oy6CsHELnHBI8B3ktiz8B9k0e5j5op?=
 =?us-ascii?Q?jwsl7CJFVIJsCKiR5ozHGPR6N7s3WOKs3tzbHxkA76Fkkyf4bZlBtU7wo4Dj?=
 =?us-ascii?Q?ubSsQSL1Vemdfq7LaE6pBaMB3bKlqQd2CUP8VE9i6XLc/0cPVC1v4YRNG+g7?=
 =?us-ascii?Q?4KTcidTlfrSopd082mRM9angiDMjuyVo6JyBKEIyiaS/AyxQ4mi/i3P7HU/P?=
 =?us-ascii?Q?31mhvSjP6M1DiJFWKnwqxBCSqKNGKw9wXszkNMAOvYr81UXlpFHD4NEB65KG?=
 =?us-ascii?Q?JMb8b/BDlUz2iEkh+7UfAntDCrg6Bs/5n12waG7gDDkgMNQYT1LRjPdhbNFq?=
 =?us-ascii?Q?IuVcWdr+Vz59QIkg/ETpu9jzTXDM2xUaZCutU0Y2maJ1jN1j+DTHMQnxD6b6?=
 =?us-ascii?Q?SbEJ3V43fvgPC9G8DTZJk52eA7FrNfU6GS40RlEInDzBHKE0JlYhEgX4RTmX?=
 =?us-ascii?Q?A6SlmnXtqfk20O/nqm6mLLZTxbyAVJc+Vqu3SdhuUS+bg7ol2simGtnmLxM6?=
 =?us-ascii?Q?FVBUD60BfPLmF9I4QqCeC6jcd2yULR6Sjx6Pc0UYiEFQlVjq6mBa2tKWAJfu?=
 =?us-ascii?Q?Q1YL7bh1XHJE1LJxNzcmZIpStmRma/iQWhyw+jEJf+yEz+fhHrZxU7mEKuSs?=
 =?us-ascii?Q?/+0Ij+HWEK746OncoEXuRMvO/hq9/3fsCbq1JzszCXYrl5+0TOO6LiiGUtRu?=
 =?us-ascii?Q?6uygZUTZzWBlC1HDG4ZXKJzUB4EQSKilaTTeyu51v4pcH/63gdcTCA5lh273?=
 =?us-ascii?Q?SdR50yLn76Tlev3Qt8hvPcc2b8IQH+dflT7ajPZIvGKst9aTyVdXreQxWAml?=
 =?us-ascii?Q?qSxHH9tk85Es/vx9OdWNck+OTlsR8tlMDg2LriIhvgiMBnsvuFHzyHUa+7HP?=
 =?us-ascii?Q?5bcpI0AxS3BiDybHC41dICs2MmikbhUGQaPvlGkpcjyk1MN1phGmWkIJChAv?=
 =?us-ascii?Q?j4DlUUWE7iRBiKFvbqRRu3gEyF/H2DZ1Mjam5ALyi6FX6szGU3H+MaOPDDDK?=
 =?us-ascii?Q?ukvDigdWPTeblDLkrSUPJoNje0UdvaXIEbm2aonwe/OELjHirvE7wHZp9sKL?=
 =?us-ascii?Q?WCzGjvpxVXzgjnV8jkOq8rOejTt+RhnD8aFx+qtSPK21FYAGPOqclNNH3Txu?=
 =?us-ascii?Q?TfHLfRy80eaFMx0OeyGX0dr5ADXA0vA4QXTWeSoW+bWE+udYGg839r5jffld?=
 =?us-ascii?Q?XFq2ufHpbbjUC+YdSiuMkFzIS6P/FH8VwJ1a7Si9yZr16+/k40fUP9Qj2git?=
 =?us-ascii?Q?H4WA4m+Qc/w1LlWORxrTsV2Sf0h30idPS3BgoggDeYOHQMTi1lvA1t+NYB0q?=
 =?us-ascii?Q?gX0Wt4E9h56PPAJNZPUih+HWG6KvtKUMrnWrWB4vUT0q5FhxTZwJMO0V3kWu?=
 =?us-ascii?Q?zDnFIM/8gUJwStp/RW6jxhDfHW1cBZIpAu9CrXtALOszDwvspT8EdrFgHIGh?=
 =?us-ascii?Q?oL5tUbxMNUrRVRPOY6e51+w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D70950C60EFBC54E87E3E60D5DB1FFA9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GTLuRrasRluDQ0N9sH+GUWde/8oRDHLukRcbArVrXzCBp4U9/gQBRaeu7uLRNPBahuaaGAALo+7FSrxA3Thj6zuKg4k+y+mdc3tyG6asSa555p2sTSHUe09/jvQcyP4ULETy2pVhDEGdbQxX8o8623R+DZSRv4h7LGr5QXUmtEL4Xq6vvKpKHquEltew7vE9K1CX78MwQKFWgmA+9Ds/wuEFEoRtszuoVIkr5HPWu2zzGk2dai1p2I+S7C99wK3HuxtVJ5jDT3fG444pCt2jpsByLr0Z3OuRb+/51sPhKltqtaUgQKUtE2by+xgqXObojcfnheRxCUtM/CDgFIx0LHv9TiZMfRRqp1A17mPRfP3vQAKYyFgndqvwPrEN2exfHTrFKfrFOoo18NhgnFbXjQEO+XxLWGBhnE1nhxIEuCH2NMg1aHxM6j8BXg49LxSN1sJ4H60q3bbmltIS15FQGCz0uyMsclVN5h4GEDe1n+BSdQrMJiivC3GF3k6/HfDYeWrHJ+5PzX/YGYCJHn+hGDhB7AGGS9lcOjxlZMKv/W+5MVYWiBdbaav7L8LvenlX6Z05tD9WG1C0bK7S0sUbkJdOutQ7xVPx6nlNOmxLSv1vAHjix9IMwICt8RMD+ObU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5e5556-ddf9-49aa-1c9a-08dcf4b0546a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 04:48:54.6841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CR8ZIbQUwM2CrzFi6NAKukXvjHeoTd3MygeXiQ5Wv467/5DmX56Zkh31Zd8jFbSqk+w8b03WW3AuTPnx1XlXUsdqoTw8XDyKVzjX61rFn3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8827

On Oct 22, 2024 / 14:41, Ming Lei wrote:
> block/027 focuses on race condition between blkg association and
> request_queue shutdown. Unfortunately it is a bit easy to trigger
> lockup by setting scsi_debug in the following way:
>=20
> - single queue
> - 21 LUNs
> - small queue depth(110)
> - 10us completion delay
> - fio: 4 jobs, with iodepth 2048
>=20
> The above setting creates big contention on tag allocation of blk-mq
> code path, especially scsi_debug takes memcpy to simulate IO, which
> doesn't match device in reality.
>=20
> So setup scsi_debug with MQ and avoid to trigger lockup which doesn't
> exist in real storage device usually.
>=20
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I applied it along with a shellcheck warning fix. Thanks!=
