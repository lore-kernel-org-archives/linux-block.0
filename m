Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4B17758
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716361386; cv=fail; b=Hons6ngHt1eat+LmwdpBqnAmAyDAGVw0NGi6n7fPx0xo7DEB/u8mUIS45oWH1uSjN3x8HjEIumfJOyMzZaKXe7jDJt9cV553OBweNDZY9s7RpWTQHLHI2WrpqnI2y4YwCP56wu+gB41pRNFP8SQODsFnYUgqqOizLcH9t2B4VrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716361386; c=relaxed/simple;
	bh=VwsiHvcfytK1Fz8Ny0m42+wgfUkfsz3IAHkEDV7zGzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQwCIsqiNqtGTGWmAk7k7eqiPKaRlaiSB7u2rIPXe3W0HN4MS2JEQlxgivqOn7kQ297cip0puHy7aPGYt/Q1g7CBu7xYJhjj/Rqx0opAPYG8BWwDWglLUUouY4mGuouwbN1Y/EInAU32CcC7yEfRdAetmFjEiIcE1qiL5yA/50o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KPsDDcHp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=F/d6uBUR; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KPsDDcHp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="F/d6uBUR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716361384; x=1747897384;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VwsiHvcfytK1Fz8Ny0m42+wgfUkfsz3IAHkEDV7zGzs=;
  b=KPsDDcHpIUFtS7NM80G2yU69MvzuIUBVo0BIl0AX6SkNjT3bt0sLX0pc
   muoNT8M7A/HhzozNtBhKi8yed77hpdc4rVGZK+vqEPzWBaI9BXrwpVt7B
   XuyBxJi9Yxz8OQ/jwzkoSm6Cn72PVlHpDfz5jNiodwybNy+7QncZlfJsv
   VCrAjeS5P5+/5JOtD4JrxYoRGpaQCh6gecwKJsE3G80Zf1LhKmc1ZCwZW
   AL1ikgIVA/CwRNZrv7e/0B/JFcMIeNC4dpikOZrYpMNPRr85v4DJ+e8Q9
   uIcAtm77qECN/ItGDIqAqvuoC5rcRIHYdCAc+8RTEaBGAWTMwaPmvSSoV
   Q==;
X-CSE-ConnectionGUID: A46nHU3sRx6++1xQL7KGBg==
X-CSE-MsgGUID: W2j4PLx/TICkqH5yB++GRw==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="17761122"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO outbound.mail.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 15:02:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5JK5WUuUw8k//T2fTTzl5a7NNhnLJIKyL4Rn13JO3Pl9kVmoL4m2802qXDjmUts176eyR0X0b/ECsMQ/ICuD/2FgIYEKQZlhOckczi3N6tVnWgxPWdndS8kKKeljwPrpiGvYRuWUIFgF/Qx5AoqsDj/r2IRILv+lPl8d85it4Nm7De1pnSflGoOtbkXqwaz59o+u+0aphxPRbqjY9xEIFfwmHIulkfoHJUHT69FsAgZACKIvNoxkOlWpCUAAc8yuc6/g0bqJkgQ3UIQ++CV20cD7+XYtVY9G03QeYgS9UGdii6Zecv9oKGmnIXL8kaWwhatfBKnp3P/MCyEZU88iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05KIDX+Bx8bZXMyEgVhIlAI2RVl8rei0wnAt4bxzyfc=;
 b=aoP+6z61+gBHmOElvuOxq3ZdyZjaj4pq+xm7vMHzpezCua3yKKSPSot6MInkCxiC+6OQbs4XoaXTx9nFz4IeaUSSjTSPjHu/rgcbszKu9nFPzrnBSFIvDJnIJ2pswSFurZc1hbcjJ1Pe/XXeKMWkdsFt06PapcccZfIUyzGv/Znm/F7sIqDne7f3wu9uZ4Sy+yQzW9uJjZj+VG949CQo8mL0AmcNsJGZDuQZguyMViXO0TJ5fmHsvFmm8tA33GVj58Y8oX5fK7i+Nv+hvrdnBExWWX50GVXBwXw+puSQDfIFMVPFCsEIt0qd0pZeE7LE7L5XC8UitD5KdeSDsY5EkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05KIDX+Bx8bZXMyEgVhIlAI2RVl8rei0wnAt4bxzyfc=;
 b=F/d6uBURw3UPyQF0+qqSHIYWN9jg086W0L8SEob0hpv4Xnsy+KlS+tDrKpY+k4g7/Y50cYtDCw9CMwVM3R1PmRw7l/4hD7kuqC1CarLgs5X5mCZBUtdvJUzQTCRLmK9ZGyeZLrAp94jsGvaemO3uTO8SSN9Q9kGZylHu2mV1Tmg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6924.namprd04.prod.outlook.com (2603:10b6:5:24d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Wed, 22 May 2024 07:02:55 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 07:02:55 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktests: fix how we handle waiting for nbd to connect
Thread-Topic: [PATCH] blktests: fix how we handle waiting for nbd to connect
Thread-Index: AQHaq6POIzbQh7y+cUGT2zs6FG/CorGi1NoA
Date: Wed, 22 May 2024 07:02:54 +0000
Message-ID: <p7qubalwunuxohkn2rfxejl2jkfpcfqp2d722xra4vmqpiofid@7niwetngzy5u>
References:
 <9377610cbdc3568c172cd7c5d2e9d36da8dd2cf4.1716312272.git.josef@toxicpanda.com>
In-Reply-To:
 <9377610cbdc3568c172cd7c5d2e9d36da8dd2cf4.1716312272.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6924:EE_
x-ms-office365-filtering-correlation-id: 390b972e-1844-415c-3610-08dc7a2d3467
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bb6ICGCFTxfQ7Jx7DBP6nqWDqZnAP3jRXK9oHvz3MCIbJO8FC1NEwfIDQFsD?=
 =?us-ascii?Q?7nvsykVbTShaPNrN8hMry6fty+lFn/QQm21+OOgLqz3JXltTwad1uvoqSqiQ?=
 =?us-ascii?Q?ruIuhWepzOYWhD1WDALqOTSojKl3FwC21d+H/Qeo+l3YKXknX/+D43oCvRqp?=
 =?us-ascii?Q?ZkqUZUNDbeFFqzxsgmMIsqiqiq2+75Pxt8V7uLEZAFAC4eupEqrQHeOWW0MM?=
 =?us-ascii?Q?bn5Pr0bpDUiWWtRESicyB3suvyChLg9sS9zxbD8EKPt20n+RWDExd4yl3CpH?=
 =?us-ascii?Q?3EIy69PC9h6/xRwlgGooXGhESWE37RbteMNHjhm0ljRneJLNN0caGJ1TgwKr?=
 =?us-ascii?Q?C0xnAAuT3Twkc5QNH9bbcaVKg3+lIsV2XcuZDdpEcaXyF50ICtJuz7IPf6li?=
 =?us-ascii?Q?o2sBirOp1tZoRE4YAhxT8NaSnqmBvBv3rwsMYsEMXeqfnrakKcvKGSmcqar8?=
 =?us-ascii?Q?BMR84PmLYz4SREPNunk01dw1cF4NKpSq2MHi997KT/TsdZ5KCZYvphli47de?=
 =?us-ascii?Q?SIZfGjzt/luH3e1+cHT1frL+qob4RtTJpxnIsL0L08M2OHXvBU9SRuONE/2Z?=
 =?us-ascii?Q?TB1iQraW/g1+IMJihyYWt9spGO1hlyuxN2fwwyOAslr9V1+6O6tGj123ubfv?=
 =?us-ascii?Q?f6CwNxbaU+/YwtFHFEkvXoOArgrf5E8ueTwrX1ihWpAAl+o1kBnIG410rVqG?=
 =?us-ascii?Q?Z2QjZTNIStXtkZ/FndOQD9j9hLA6hBPnQX3IT08NlKLszxgp+Acn0UP41Ybs?=
 =?us-ascii?Q?Jfsbm1A96E29I7LEk3TwOunWym5/rZGRM2BSJms6cmUktbXKCWeYv9BLE95l?=
 =?us-ascii?Q?tjEWkrR0JNaZ9lKEpCOz9sWu4+DC2lPK96txge9HaxGrAAEKAg7jWTNdw6uO?=
 =?us-ascii?Q?oEsCZ0B1kwlDor/k7ZkOC3Kp1rWhzTCpsbkdRK1lsRQY8zQ436BXw9LFRcb2?=
 =?us-ascii?Q?0MvmWyMxga6sGWT/HhYqDZe1nfMgcicNlOFJu65goAvPyDtFFMVEMt2ggRcd?=
 =?us-ascii?Q?PJYGXfH2Ot7DtPP0miLCi7bgRcIAmpwzF08q/e/zSL/xTOEn7TdNl+Betl5G?=
 =?us-ascii?Q?tGogCuT4BZpTBog8DD/Mm8I19ygyeOEX3r5ADObWhoqCExDn29dtg/ESVeFn?=
 =?us-ascii?Q?N1kwp4m6n1GFbtFrqP0yV5gDMAXLB7TezKQ3C0RZvuY1ZU0Pgd9asCrGDzLy?=
 =?us-ascii?Q?2y06zKQ2Srs6QxbFUhHDDYuAPFPJHYcKPaureK4GzaVR9+ZnwFKleUXW/JNv?=
 =?us-ascii?Q?actcorF+aqR9WccSi04YKbzSDKyLcBvkQaGwNmKIphqGlK3Ayme2iiJKAt8b?=
 =?us-ascii?Q?+jbA13fqO4sUpyzNSm/voFu3GtyjZ6yD3aZ4K6q6vbK7gA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oQVTXwp6rpWM1+afd5D4vXiREtsPP6A5v6fmyAfdn5v2eooc1yGPBPQsKCyH?=
 =?us-ascii?Q?odBqloqn+yvUgsMt8THIhj7+Td39Cgn64AJwvv1J/AaEtSc8sFLDhrh4oq2s?=
 =?us-ascii?Q?RG6f2Isjdz63StG/+w+kuceKj/RwVm9DXFK36QZSzDmAghiMtIxXVvESqQZZ?=
 =?us-ascii?Q?+8ex6MFKLWi4VT2b3mpFN5WcsrL9IfNmLAjIUn1PGfMLdQe6umXBCX8Clqcg?=
 =?us-ascii?Q?kd+7Vtr5BrVeMFDtxvuvXPCDDkHj3JhnZD2DM6Rc3HvhIQsec2+yFk5Qo3Ru?=
 =?us-ascii?Q?pT+Th8VLxvgWBObQuQYAodUVOjQcAv8Xe/bQnG5AsadXX20deSDKvrdcfKd9?=
 =?us-ascii?Q?0YvSoTJCt8PXl9YyLOzTCSJ/MfjSyLuTy43lofy/P5CQnim9jHvpGzGVxpU/?=
 =?us-ascii?Q?1+rpGgLQcr5Vb1dgqMFU0NJTP8N/S9P2UIJIWixfidPHl1cgaZ/wFv54wfPs?=
 =?us-ascii?Q?85sKylGslxKBgfiPHD9l5TxYgraY/WdllJYU6tT/0hVq5Q54vqFiYHE+UNaK?=
 =?us-ascii?Q?7ZcdT7tSJchcoCsVbTnECtqg+Q2O/R4A9DOqbuKaLcgIP1LaMoM0odpwZv+L?=
 =?us-ascii?Q?rP+fQVYXlH48r1a1Q5mjL4AtuefyWhjj/PpzDzc6Nx3pCV9fUgpSYvML+wZj?=
 =?us-ascii?Q?9p/MhZhEj0yUwf9i0YVWlP6tD38JqzrXDUlDJUTBaE5d2J7vF8g993GvdbD+?=
 =?us-ascii?Q?gDlz+BM21v1AvTW6wtRHITDfy0wiVgUJwjgKpJ4v+Ox40E1lMTp9VzEnWeUu?=
 =?us-ascii?Q?UzZBVR85mmtFIc225VPwKYb1ZoR+jLQXlh89oio/vgIm8NrpEJq2iShcqq4I?=
 =?us-ascii?Q?SAMavLeiqmRJ6BOOp0jgimMBdKSkiRcjJh9nqjsj57gS53ZDFFecZfeWyK6O?=
 =?us-ascii?Q?QTi+P9ywMQGM5NeJZBppkc21sKwCVLAnW7bIDDk8nocoU7IIM0pKdyxMqTMM?=
 =?us-ascii?Q?MyKHK9uuyavHjLS4ldUatBzwofjNO3ukP95qSD2IeiW368pDskGlyzVp3R4/?=
 =?us-ascii?Q?KTok4mpyIA+qtRrZms07Zjg9/9UkG86J3IuFZuDGqC2mata/OE4RQYEd/RPH?=
 =?us-ascii?Q?FM3fAh+cqyrcpXXUjO7Jwuprxs5u0xpVJO5e80Fzdrj4JimiBkUPiYSCRnXU?=
 =?us-ascii?Q?TkePyGVwImDyPfRev4KEYcYk6cU1eRitMUoiFtfGHTkEDst9e+mwzmNgnkwn?=
 =?us-ascii?Q?0mHpTsfv1Y0BL9jK5+fzXZw+O2Zau2mLhzWtWskmqp1Q6u+HKwbfjFWyEL1j?=
 =?us-ascii?Q?oeHUvMHFB85m07AR4FHbL82wh2vef9sMF9BE1HR7oQL8NqPyeIKVdmloYb1S?=
 =?us-ascii?Q?bqVZc1RrCUWgStNWOWbLJeNM1AuRFXRdVtFMcyOREy9zp+4WOgSVI0Tgqi2Z?=
 =?us-ascii?Q?ru+F86z7p6ML30qeIzknzgw/F5QybJRXt+7DGbyaD2QDwwoMYF+9ns3dnZjo?=
 =?us-ascii?Q?mzB26LE3zvtYmjeX87bHncc61KCONL4+fFoPEMSfxGi8aevu2UDla7SBlrVF?=
 =?us-ascii?Q?BduPRgSEd0jxOa/I7UWeQy+Duv540emi9OeySyLa8NGxIJ95tOAzhgjTqgVS?=
 =?us-ascii?Q?6H21MH2iSs6fNElXg9bn/bb35y3DqODay5NZGmlV1aKkEhs9qN/GiRmeiozV?=
 =?us-ascii?Q?C07oZuCxLsT2kLWBlhkCy3o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <330CAFDC2051D8428467FEFAC063AEC6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8RFpErDpLSVylshJC8GnS4FR2Wbma9fez+6DhfujJLlKBG0bySDDRg0LLpkaOtX8jTbBLeoFnawOulPRK/VDWFIXkhuw9Htngb2igfazsBvIji5+Pv7nWdl3IhTmrBvwH2u+nCKGBVShVXlDHWO491CqGdfVpa53AO1GjWUFMnMtIjLHxCBZYTfC1dRWJgm5e8CS9kyvw+gVXXiv43bHFpZvs91OeUO0zQJB1kvuYZ6qPiBEwtK47A1Qj27+9CRVjbrN41+O1XD/wN8PoMq6aUa7RXCXGSgPrwvvrBy632eczWO08aQ8keOGj5A/cKAK28Lj0/9xJgJxUGs5y+rqySrR34vwm7qTqhElhUNiw0g2LW2PeTt5oQ9CB6r/5og/s0ChGHJhwD2oWSzxlFmFc83bdEZrrsY43b7XEwM8GxVGFabgO0Q0cWdUW9GGQ4Y9j2pAtpYi3rlRJgayP0+otpeHUmOEooIsepVd7V1o9fcLsEIIcnWUs/jGKEwZzlLiG96RIC1oacwE2UFNTqdChYOXTKefCSiJroF1inYVMA2vG66aX+Ls8NuCHQLsJDcBPv2cELkc4iBWO78Fh6wj/XCZQ37TnuwgBRmVITh6lsfMu2R6Kq/Ru84c9Qh9N5zJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390b972e-1844-415c-3610-08dc7a2d3467
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 07:02:55.0574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKcvV+0Um7IdvgRorho+Wwf5OlWCNnWCdrvCnEWtjvi9fB6OewytZ2bTLrdUc40oeQ70xWAbx+r5PGtRaHrAj6GrpkpQZtbUDuJ7WZBP7MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6924

On May 21, 2024 / 13:24, Josef Bacik wrote:
> Because NBD has the old style configure the device directly config we
> sometimes have spurious failures where the device wasn't quite ready
> before the rest of the test continued.
>=20
> nbd/002 had been using _wait_for_nbd_connect, however this helper waits
> for the recv task to show up, which actually happens slightly before the
> size is set and we're actually ready to be read from.  This means we
> would sometimes fail nbd/002 because the device wasn't quite right.
>=20
> Additionally nbd/001 has a similar issue where we weren't waiting for
> the device to be ready before going ahead with the test, which would
> cause spurious failures.
>=20
> Fix this by adjusting _wait_for_nbd_connect to only exit once the size
> for the device is being reported properly, meaning that it's ready to be
> read from.
>=20
> Then add this call to nbd/001 to eliminate the random failures we would
> see with this test.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Josef, thank you very much. I've been seeing nbd/001 on my test system and =
this
patch avoids it :) The change looks good to me. I will leave it for several
days before applying it, in case anyone has some more comments.=
