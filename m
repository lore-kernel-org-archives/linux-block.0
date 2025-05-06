Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F74283FD9
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746548989; cv=fail; b=fkLroeO0ZT+GBCOxpRzE8HvvSg/Je4/UTKLafCVABRlKkigR0zHisGOvVt2rQpDtqdQz5g4wl1/LtEJWNjFM9M7nZYGQcR8GNLtVOATwHZelCviQiFPE+03XOEZwTPyRSnOo1C2H+bJT7IU4E+UrGEr31PVVifrvT5vguVwiEOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746548989; c=relaxed/simple;
	bh=7N9M3ZCtCXudebresZ+Ad1j1XqIJrDLAJdr/uf+1rOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uyXLsR+73npEH0M5Xo4G/vOrMNRBgH2PiTAps+2dixniUYpBi9z2yVGJ0Yi0fcf08eFnLZqC+UoeJDkE8t8k0NxNPn18Rj9fzpkYCHiTZj5gD9gh/VNyUkK6ZKLi5lblUsSiw3wdaNcBhrn9cWJ9C8QfTDuVUANw0VQw77x5wgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Y7glMOA7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=A46+pXL9; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y7glMOA7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="A46+pXL9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746548988; x=1778084988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7N9M3ZCtCXudebresZ+Ad1j1XqIJrDLAJdr/uf+1rOc=;
  b=Y7glMOA7dQbU8o12OspOrHEb4tldryQ/kvGgW/5WMxV88Yauvn3ccT2i
   70TUsuun80CoFYfJDt1awCx9Wiqr6pXMcOsjWBAiC713ETmthnlNaaIL3
   pmVl1V9RmFc54AeL6GJz+9UI2v1LSJ7+ayoOjiDTtqv03G0zHSOCXM5hQ
   5b+aDeLn0nqYyy+oJEVo8+YCYz6UtebBN+Mlmx7V0PR2TMQ5p9IjXybni
   PByuRs41hxM5EznlHzsxXloKr5P3BgWXBJtrTRT207QecZ09qPFIkbyPZ
   TOa/DGJqRl6hxs6uOeaViDiCBylrOD0ieOnw2Ha+4aW497NXsGosjXKUn
   A==;
X-CSE-ConnectionGUID: EhGw8410RyaIp/zlRPBH5g==
X-CSE-MsgGUID: TwGoAGzVTNmgMuUywmBy6A==
X-IronPort-AV: E=Sophos;i="6.15,266,1739808000"; 
   d="scan'208";a="81324466"
Received: from mail-southcentralusazlp17011026.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.26])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2025 00:28:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0vc21qNu2vZ4Blpow3xl7EuXN2c8zXDiS7B1mdDEu9/91ms7ckBUO4v5wZtXo6HLgLO3HBvteFJrphZZYPDEUraaMyPv1NkJiENsHX8yZu93b93/PJVAYwbfZW7DUM+8srObyzcjJruOLRRU1fmub510bd45ZiWRICLDftQbHHS338nxl2HpfU/0XyS4JvVdgJMueVF2ZSZ9vdUyuZHVEQGPtmyp/6CtY0ltd2MS9t/p4OIhb6Sum/ipQjb16lgFoXXt692C6daUJjhFhdLQRQDy5tVHgbKg+qLn0r/En9Yi8JsaOvmvjCW1i2kEcNLwrOKE0Pg+kss02og2grSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7N9M3ZCtCXudebresZ+Ad1j1XqIJrDLAJdr/uf+1rOc=;
 b=ZUxYYWRr0sAnldjHi7KIo8IHaAc0TmQFukCTZ36LDDMyLlEjJ1f5wOjYwBX/Z83lsxWlxfry3w5Ctcs1b1ucMIKspr31NNHWzQ7mduW6hfgLRCp3Dim8uIrTA028Nw2qZuMxPyqMW37kIABf4D+GQLOEwTpwCvOa1PJlwQQTXAEdIkXexfb/BII4p/GuIlTSZkauOXlKUuHskaRLemiXSwIxiWeywdzBFmeyWQkUI/4sYGFfGXMqH7iZLPIicPL9V/NjTFuHPFENivfTfnH9TIXT7Q96z01Hd+v00Q/IwzLwjBc69PTO7ETjmCaLS36yjkrD+QSuw/ARteZEazoQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N9M3ZCtCXudebresZ+Ad1j1XqIJrDLAJdr/uf+1rOc=;
 b=A46+pXL9m9dTlx3gznnXl0BClqF+1Dslu0LfZCHSA7f8h4k7sx1IHJqR3xs3FEwFdpkPoQDWKHMu8bqPGC0DpSlyvmmksx8TyTR/RopOr95eUUuK2f/NySjtT5hvCKiR1cSe2DoUp/fHnIH0xk6r+j7LyBc8IV05iryeVl8pBBs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS1PR04MB9162.namprd04.prod.outlook.com (2603:10b6:8:1e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.29; Tue, 6 May
 2025 16:28:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 6 May 2025
 16:28:34 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, hch <hch@lst.de>, Johannes Thumshirn
	<jth@kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: only update request sector if needed
Thread-Topic: [PATCH] block: only update request sector if needed
Thread-Index: AQHbvnnmwXaDW1Tvd0eHedaFi6EPMbPFf7mAgAAdigCAAC2agA==
Date: Tue, 6 May 2025 16:28:34 +0000
Message-ID: <189a5c6b-0392-4f6a-8864-67a55a35f0ec@wdc.com>
References:
 <dea089581cb6b777c1cd1500b38ac0b61df4b2d1.1746530748.git.jth@kernel.org>
 <20250506115937.GA20817@lst.de>
 <a562c00b-6675-4bb9-9148-c212bab8eb41@kernel.dk>
In-Reply-To: <a562c00b-6675-4bb9-9148-c212bab8eb41@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS1PR04MB9162:EE_
x-ms-office365-filtering-correlation-id: d9c916dc-ef00-4db9-547c-08dd8cbb0bf8
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SE95NDF6NzhtbFczKzJzSlNzYjVPdiswNkRpVndBU0oyakRVVFdPb2ovQmZq?=
 =?utf-8?B?b3VSSVhpUjN0cXFVY2RpdUsyZkJpaXJINU1Fb2I5dEVtSlpMOGp5Z1liL1hu?=
 =?utf-8?B?RUw0bFFjSUlkajY3OE4wWUpUdThpRExlUmxRQW9CVjU5UDk0OFAyYnNiRGhS?=
 =?utf-8?B?VlhvQjNRL1dva3ZzOXptN05Db1pKWTJzdk9EUS9lVFhXdEtiRlQ1b3JJczZE?=
 =?utf-8?B?V0pmdWRhclBrSDQ4YlN4YlJlbWRQKzJFa1ZFUE5SV21EeE16NVY1d2tKRnhu?=
 =?utf-8?B?OCs5N3UwN0FNbDIrTjhyTmgzV3UvME9FVlFhTDVXWWxGbDEwOXFtTElEN08y?=
 =?utf-8?B?V3ZmS1RIdGxjMFVSRnp2MElGM1NGQnM5ZVNvYjZJbmVxUFIvTGdhSW5ZVE13?=
 =?utf-8?B?NmUwT0RWaDVZVm4wV0cyM3J4bnQ4OEJlb3d6Y1h3YituQ2I4NjV1Rjl2VVVX?=
 =?utf-8?B?K3RKdU4wVktKWWdNeThSamw2S0RXMXlleUNIQlI1NEhxYlF2R1AxaFJwRTJk?=
 =?utf-8?B?ZDBjd01pZnJKaWhZNzg5M3BYSkJiQWNpdjNseG1uTWNtam9tU0p1aWdENzVM?=
 =?utf-8?B?NzRnQlZTYkdOUkg1T3J0cmRQWkJZRDF6ek16THkxMlRLSW52dXJ3SklHbzl6?=
 =?utf-8?B?V3NsUUtBK0hmcWhVaFVaMzFYZFFXNUp5R3dCTFBjMHZCbEQwSitGSzBIUTZ5?=
 =?utf-8?B?Q3RyYkF4MmFuYmlTS1lxUFdLajEzeFpFMXBPaFFMNHNzQ3RNQnVkZzYvditT?=
 =?utf-8?B?TTJuV2VtTHVtYlF6cUs4QXc3azlxbkFETURvanBWQWtueVJPRElNeWdWNEQz?=
 =?utf-8?B?U0tUWXlseWl6SEFUVklrN3RqbG1KY3cyWmh5UUVzcElGd2I1ZHlobFJBZU0v?=
 =?utf-8?B?bjdnVXB0UnN6THZMRVphWDBMQTBXRkFwa3BaZkpjREhwOUxROVpDWk91dzlq?=
 =?utf-8?B?K3BZck4wckVoR3VGK291ODRBcy8yZmpKeGd3NzhVN3VRTGNwdlBiMVc3VFRF?=
 =?utf-8?B?dFJNa1lhZ2VTWmxwcWlTTnZxZlBYRkQ5U2xEZ2ZZUjBUT1NYTHZDVW55RUJO?=
 =?utf-8?B?U08ySU15YlU4SDlDc012VzBCand2bEtkekt6V3dudkxNWXhVVEZSczkrdmNp?=
 =?utf-8?B?ZklQc3lFT204b1VQQitmKzA1UllpZFRWZUtTTy8zT2lKeUgvUzFkYURxNmow?=
 =?utf-8?B?SnAwaW10cVh4Z0dIQnFoa3l3alYrKzZWNW93YlhxSG52S01GOFFpU3FTczA0?=
 =?utf-8?B?L3JxNlc4QVlXMnlMdllSWFhqbHo5TERUTVVCVGFwMmRxWml6b2JURGxnSERz?=
 =?utf-8?B?R2JyYWdmM3NmK0dRUXpvdUlQMDI3ZnI4QW53bU5vQlZzQ2xNWGtWc3FjNHE4?=
 =?utf-8?B?SzdhZE5HamRWSVd3TDc5bkcycTRXdjdkd2dtZ3B3dDdoSVc1ejNGOERUTjln?=
 =?utf-8?B?YmZGY0F0N080ZTRxVkZLRkpna1RHN24yOG5QalNwWXR2N3YwbFVBNmMydkxh?=
 =?utf-8?B?azJYN3UyenZZaXVDR3V0M0dRSklyMENDVW9MVEFIdlh6QW1LMUFPQVJFK3VK?=
 =?utf-8?B?WEhJZVptQ0lvSUhMSHdLdFc2cStGM2xUcktVTE8vL1I1RkE5SzB6N1kydzAr?=
 =?utf-8?B?a1paY09MQ29wZm8wSVZqYTFLNHNMQ0RyTUxpY0s5VXFtcFlwbHk3ZytLcVR6?=
 =?utf-8?B?Ti9uRm45T3ZtaFVzUXM2L0EvU2d1dFhISVBncnVadUtLWUM5eXozVU5uSVFl?=
 =?utf-8?B?Ly9LTlBSWHBlUEVTcnBQRHJGNTFURTJwWThwbk5CSlo1SlNWVDZpRmhNRmhv?=
 =?utf-8?B?UTNMYkEwbFJ4MHRhTlE2QWJHOVN5ZTFzSVdGbTFNQVVSZXIraFpxVUttKzFw?=
 =?utf-8?B?MWVQcjNlT3pDQXJKRzVLNDZ2Ym93dEx2YlZMc000YWVMc3dQLzl3UUNsSFl3?=
 =?utf-8?B?cmR2L01TRkFYWEJUaXNxVjhibnlpa09YZlZCbS9uSWNkNHdWalc4VVZqK1Ey?=
 =?utf-8?Q?47tpx6/Ex3tFjupEfzl/xG+Quysg+s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTY3dE1kMTV1ck0vRVhseFFjZXB2THBNNk8yQmxKc053MHVwRE1JcUlaZDcr?=
 =?utf-8?B?OTIrSmtiZ3g5Qkd1NGwrMWM3a3I5THBwdDFjU2pyb3U5dWU3T1pjMVhJZTB2?=
 =?utf-8?B?Rm9uUzVaVWZTY01vOEZOQkhSOFVCM1NhYjFSeStrdEFOaXB3VXVTeUJMRVMv?=
 =?utf-8?B?K2I5enRWVHkzZzVEVmw5NFM5OEE4dVAxRFI4UU9MQ1VNbmNhYVVIRGRiS3V4?=
 =?utf-8?B?Ykt6QlBiVzlqcDhHMENqRm1KK1g4VEI5VDVSV09VUnBscVFCSFdwWFZDT3BG?=
 =?utf-8?B?S3RMUmpZb2VJRENOMytVTm81MGVrUFJ0OUNVWm9sRENMcGFCWGJodGFMb3Qv?=
 =?utf-8?B?VGdpTVYyWEtQQmpXa1ZGZ1ZhN1dhU2VJM0VDV0hJVEVBQXhzZTZKVWY1M0hU?=
 =?utf-8?B?L1dNcm4yY1JzZi9QaDYxeUp1WUh3cDFEcncvOWdMY01kaFhGWHRlc2E4K05K?=
 =?utf-8?B?QjhPTGQ4eEdXY20rYlp4alZBZUU5V3k1bWNKa2NzcE1EWDVqM3FzNjIzbktM?=
 =?utf-8?B?eWpIVkhYM2FZNENWZldBbjlaSFJRZUJ1anovbHppaXZTd2REZlZUK2wrOStM?=
 =?utf-8?B?NXFCdXY2YzRBT3JKY2FWZXY3dTVSMnUzd3BUbTRUblhNTzZvR1Zad0w0KzBu?=
 =?utf-8?B?MWxVb2ZCQUNub0hjeGpoWS9kS2NtVjZPRy9rMlFXWDd5b0JDQVc2R2QwYzRL?=
 =?utf-8?B?Ty9TM1h6NVplY2FJM0NpQ3BqN212K3FUTzh0UGN3b2NUdnZOTndtNVRxamFw?=
 =?utf-8?B?NjNxQzBQMzRMRkd5ckVGVTVFVHNsdnJDcmp5ZVJTbHd2eWlrYSt0Y1lNUDRk?=
 =?utf-8?B?NjVEYW5SOXJKTnpvditVZmZUV0RoVGxoSHNGMXFLRTlTS3ZTakpwbmN3a3ZG?=
 =?utf-8?B?bTZReTBiOUxBMTI2TjBNV1pQWnMzdVpZSWdNMjdsSFdveGtPWFNWNzB5Ny9T?=
 =?utf-8?B?UFpCM01CdDRveXhEMGdVMXpJeVZ2ZDVtQlBudVdRNDBlTWNxbmpVN1dpUXdM?=
 =?utf-8?B?WHZmUnY5YXpVNUNWcVovQ2FzekNsNS9LMDdyTnFMNm1iWGpiTjhrZVpJRHpG?=
 =?utf-8?B?R2hUby9ObFZPb3NVVHZ5N3djSVBMc1VHOU1yVzJ3dEZsUi9FM0g4aXFSc3J5?=
 =?utf-8?B?MlZXeHNQUW42N3dNZjVSeWN4anJVSlZ5cVVuV2ZkTzE3Yzh6YVdabGlRcVlk?=
 =?utf-8?B?L1AyQTVzZ0JNRGwzZEZZajlrSXc3MmhXekFrdzJSN1EzdElaMlprVVZiekVl?=
 =?utf-8?B?VEluaWJyTlhDTmpBblVydWFPTThYUnZ6VHN0RHJEZkJ6RngrNkNxV1duZDdp?=
 =?utf-8?B?M2ZCUEdFTW5HanFYelZFRWpiSE5yRTNZcFdiMjVUeGhHV3BEUW9XbnZpVW9r?=
 =?utf-8?B?Wkh0VXkvM0RFRm9DMEVwSmh5M1Rscm5FdTZBYy9nNWQyNVpNTi81bTNwN3hF?=
 =?utf-8?B?WnVsVXd0bkpBK04yKzhnemxUSDhmSzMybHhjeXJ4dkM1WmpMUExoaTJmVWZy?=
 =?utf-8?B?VFpZK1p5Vnl1bXl3UGI4M2dmMXFMSXVjSzB2K0x6SlY1aDh6Y0hkbnBZV1Fw?=
 =?utf-8?B?TVF5Q0ZZd0w3TlRyU3I1dlp5ZWdBVmswNGJyKzloWlNRVWQ2ZUc1OHRnOWpL?=
 =?utf-8?B?aG0xNS9Ea0c1UFBKV2lTR0VrUW5OTWwrMDlsajR5YlFZdVlKZ21zU0VRMjgz?=
 =?utf-8?B?KzRJZHNpRGxwZzI0VnVZWXRHbHhOK05lT3hjMURQdTU5ekNQZmFXbXRzRTFz?=
 =?utf-8?B?WEJZazRWejVtNmZiQXlsRDRsaE85NFVJNzRWRDZnOFdkNGdXVHhUMW01all1?=
 =?utf-8?B?MElPMUdYNFVXRndOZ3JiTktucStodGptemY0djRramtTREMycmpDTmJqUkho?=
 =?utf-8?B?ZzJnVjdrZHkvUno0SEpYeUFOM1hUcE0vcUYxZUk2dWRCNUFOMEkxbDEwRTZX?=
 =?utf-8?B?Q2RZeENwa0JyamRLWjh2ZGxmNHpjUG92dUV0dmd1Mis4MXBCZWxjT3lRd2NF?=
 =?utf-8?B?c0toREp6Q2RtV21iSCtGVmZFN2R2d2J5eWtOMkhpcDN6WFYxV0lwSVZpaWgw?=
 =?utf-8?B?QytlTEs2NnllekhPa0pwcVZwMnhWZHVIWWtvV1VNUENBM2VDVjlYcjVkNnNp?=
 =?utf-8?B?V1hPc3BEVzVFSVB6QWFRcW8vN1lqVWxZbTJaL0svLy9ucXJuQ29IMHVuRjVR?=
 =?utf-8?B?bHhFYWtocURCckFZVXVRUEhpM3lRY3g1RGJKRjZVY1Y3QUM2TmpvNE4xUGQy?=
 =?utf-8?B?VDV2ck9uVzFYRXFhOW02RE1xUTd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2240D2DD40B9743BCFD9CE992FC302E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FMaP5Q0JnWWSTt9cb+16CXt4r9/uYsuYmHd4jXoTwFyVq4MeKUE7LSsNnXeu8eylsyX6g/sQ+4+ymaK0v1Yc3V6H0XoTfzXN0L5TG8Jfi+UyAHq2nZlmhvV68j0WPftjXwsh6nq8DCfpLnZl+s9am6vlPQU4N3nuoZw4rK1y81zVh/Jq+xWXnH7eTJfDwEvyNVY1Pb8l0/e4pJfl8zKXdKmSIKQYp+TE6L6MYn05eyoz8cG5bzV71owb84KLiF9KsYPve9CTQWXXOXcf0AhKHr9JHQ09WZTFi6U35XHH8Ch5I1cfJaeKvFh9OnrJ8OW3hKwuBy01guEvAwgwhLaZgXiAR8YYUU1S5NNMHMf/eJSE1cuK7jbeiu6pf0A51bfaW4yipGxhp5v9Xe+HdwWERbBUyNYesJm6zofhTQ1IFkbaicmBI9hxoMzGypMBWPG+sGGmB5uijUzoOo+BLLklLteooJAZHRmmYgDsniB6IoGe4aeROxZeTRmY3L4tptrqy2WuWETBf2J8QBYGu3i+9rTCsY6SeSSfqYVZ1PrKK46Xl6Xu7a5aFYE1lYACOBmlPwXdnJh86oBHRCOVVO8ZJwW/8ugYF5XZC4cLD2icfwuW31E6ogAZG68MGnu5HNq0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c916dc-ef00-4db9-547c-08dd8cbb0bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 16:28:34.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNRWFnEnMR1UBTVt1jz5eUy5T8ReV2P57MliQK39nM+B04g9gnKtpyCcfsn60JVFvzef/x+nBcOhI9aLoaH1FlPTfrLY3oT8gL7XqK1/IlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9162

T24gMDYuMDUuMjUgMTU6NDUsIEplbnMgQXhib2Ugd3JvdGU6DQo+IE9uIDUvNi8yNSA1OjU5IEFN
LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IExvb2tzIGdvb2Q6DQo+Pg0KPj4gUmV2aWV3
ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiANCj4gSm9oYW5uZXMsIHlv
dSBuZWVkIHRvIHVwZGF0ZSB5b3VyIG1haWwgc2V0dXAsIGl0J3MgZmFpbGluZw0KPiBhdXRoZW50
aWNhdGlvbiB2ZXJpZmljYXRpb24gYW5kIGhlbmNlIG9mdGVuIC8gYWx3YXlzIGdldHMgbWFya2Vk
IGFzDQo+IHNwYW0uDQo+IA0KDQpZZXMgaW4gcHVyZSBsYXppbmVzcyBJIGp1c3QgdXNlZCBhIGdt
YWlsIGFsaWFzIGZvciB0aGUga2VybmVsLm9yZyANCmFkZHJlc3MuIEknbGwgdXBkYXRlIHRvIHRo
ZSBwcm9wZXIgbWFpbC5rZXJuZWwub3JnIHNldHVwLg0K
