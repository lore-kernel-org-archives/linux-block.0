Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4164936896C
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185322; cv=fail; b=owt669cLR5q2NiJvAXB+FGYMOSp3jSsSo1jLmxcQmavsxR1pBPzZZUQZpu/QkTsJ/+tjNgwEttz0tPWqvcKgwsfHczBgwDWQ/US3YnB7RiRW2HFBsHJu6mM1JF6To8vBRp+N9DNkoJB5vJSzXdR3Sy+6+W51iHUTBQpnEP/7wmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185322; c=relaxed/simple;
	bh=zlr1ANj0/HxiJe4yzYEPTPXX3SxP6U5tpwlZ1SGAPRo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f3UeodoLaKgvFquyS4r/0UU5gC4f4uU4hGBP//yv7r9mlvVPYux4gFI2HKDON60nKAKpO7m3P3RiZep63mA/Kq/0Zq6hNzKM/3VruD8VGsNI5VnYfn4sshzRT7ZGxsGrwGJo2IjVYyQVuTsazDAZzZ8xH0c3fTYjM9QQMxYm2OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EaDZJyAw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=a+9QItk6; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EaDZJyAw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a+9QItk6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772185321; x=1803721321;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=zlr1ANj0/HxiJe4yzYEPTPXX3SxP6U5tpwlZ1SGAPRo=;
  b=EaDZJyAw1h5azjP4T4GXtsUBqvoIh+zjVEL4qNy/AF+yDhxOyGCUsKRK
   q8MYW9ybvcKhExP16fhIBNXldfDgXBEYZqacLLXOT+NqBIM4wOPjm/qO3
   rGuyQZh1f60ASFaFgtXD9IUS3PrNi7eoiW1IeBPFcSwlR9yzzd4xHJq/a
   z9lxyVBYwY76ViCPyuglmpr1SMkgYqO83j1TaFZ02ChgcRB52Rb4I/esC
   ZxPT3ijxwu5MUpInt005A9DKH5p4CwvELKIz8RSpcuHE1u0QGLgN7amUn
   RcGvbSIF1Iomtul83/s5k/9e3TwUJQ8joJHgG3/WFm4ifr/pc12RvhNYv
   g==;
X-CSE-ConnectionGUID: 8mdNQa3gQPyOpBZQAX7N/g==
X-CSE-MsgGUID: 7IgyoOfmRO2Gu12V4Noyvw==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; 
   d="scan'208";a="141191520"
Received: from mail-northcentralusazon11012071.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.71])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 17:42:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8jYgyDoozkCzEtalSuUm1KM6JATvGiEZ5XYpecqQZrOvFb0edJlJTkj6+l4ztcHojYp99SAPX7p1EjlSLaFN47El/7774nL74lCuPqcqgOq7x5Ca1H1fPLYrU3Q0HkXSUg1Z6yah6JAf7DgbCtelmE5cBKEWoR1JlYQG5LWxNRzEAz43sVH8qSw/KlA6RX7SHINJSpafcvZh+Hisw+G1/sagsdPgZV9Gb/wI3DUHpHhh/fnoEXhkR5sHUOHZr/UlN2ChoNtHjtjB2WEn28ZrGg26CbJ+0ZMkoq1X7UnW63m9wQ5eESgKEHEfGbZocAP3ENP1/odpborENGvxrBj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlr1ANj0/HxiJe4yzYEPTPXX3SxP6U5tpwlZ1SGAPRo=;
 b=exE/2k8Zr+zi0MffKRP85mhzhrpWep+G/wxsvn7VBzjUgCpjbQYoNjm+9usGTuDvgyf+uOurkffJLh/XOmrQc6bRvwb1BfShG1FYNn9+/jdXEimukoZEuSR8hJr+5lSwUyxyC3zDJrmf+KhdN2HPRzmH01KuXJVh8ARHXRQGrHX4+yRfdCUEjgHCnuBfmAt9F+XiTwcqgKFJzM+qDUd4kqv8fqXctzJ0e5vlDr35jXusEeD4gSo28qa4lGrqkfBYKcHPSBFT8NFY1B818SFt3ukjK4QCi+LcWQTam8ElDbBaaqi5W8/VuuwTAp0pJfgUwd9blAmamdUGoKayKmKb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlr1ANj0/HxiJe4yzYEPTPXX3SxP6U5tpwlZ1SGAPRo=;
 b=a+9QItk6dNYRELMYaiFV20EE2XaaVP2OsJfkBVfP9s0lyz0MbCW9tVBhJhMyyDZ63S1EM8Ke4EEY6gfDw515w7oxWx1TM/RwJuaeLtd019/Uwt4/AHpD1qPOVKPqzeluGSkaP0fnIfp0PKjED+MuYeuGggzd3fJW/q8lDM5zHpc=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB6397.namprd04.prod.outlook.com (2603:10b6:208:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 09:41:57 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 09:41:57 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3 6/8] block: allow submitting all zone writes from a
 single context
Thread-Topic: [PATCH v3 6/8] block: allow submitting all zone writes from a
 single context
Thread-Index: AQHcp4wsKPJQvIIfQESRxHjqA7BjN7WWS4iA
Date: Fri, 27 Feb 2026 09:41:57 +0000
Message-ID: <c76ab5b6-b59e-4359-8cdb-281cc18a0fdc@wdc.com>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
 <20260227014951.2327711-7-dlemoal@kernel.org>
In-Reply-To: <20260227014951.2327711-7-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB6397:EE_
x-ms-office365-filtering-correlation-id: 6c6068e6-cd1d-4b07-cccd-08de75e472f1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 MmA13kCSAPc81VvpS5oBQxlT+nvEggxYMmzz5GmNWQARBNmcSeZWAD/yUcVP8t4Ps7DLQBVHTD6fDtnSDZWTxUTBXUqJyq75OxUvPghtHk0ow4w9nj4++pDdOGiwTXuYuLzJG7EEa2v9oqE3V+5Hh1eh0FhdOq+gkQOzm3Q209t/SipbHzLsAdWxmaXP4Fmek7FTwgkFJm0qgx8/JM3xKwy8cAZ0rDFDv05XoLYM8Q/gfUkmfb55SA+ABJvEUU2wj79SRI5XyvXaYMsWICkjBpYBzzO9yPu0XI3rlHDD9mFUuZWH7G9wVtCvVa8jMyLAY1h7re0BID0nHrfE6KT4k/fiPdQ5W7PRsNsxqeILSeUYKdXj+kivmYM4cPMwimuBQD+5A7BxGQ6csw54cbrhcamKuCIW9wv3F7aQmZgtS2lO9EiZpVOW9a7g8brfyVplmTzA+WoFV9hdlTEXWjCrHfedE0EfxOUOQif63zMprueBnpz3IyNFjXFB0njI7erGBlFsyYkaFCPka3pNrYnFlnpdbLz1wsfcfzxd1WfndLBvIVZXZakvsU0ORoAOGMhDU5uXt6rVbGV4CHVJL/6RFhHUYG+75kt9agQAft0HEPSqOD6QlYNREBRmHhedTwTfe2Gh7iWFyiZwQuCM1DjFBLcfLL/aU5ohz0dQJ4+z/wd7eG3tybDT+PGBkmio6qkYGmqeJ8GVYXV2p1s9CZt6xyIcC0IzZ46wVfpjHrxMTRvdMWS4BLEs/GjHFk07zhLwRPmEHQ6CyaEF6njxFzJXHZY0U40P2k9N3Hu9J0FDQA4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEUzbE5DYXJLMnhjbENWMHdkTElhL0hINWVWNndPaUZRSkhxMDM4REpqQUlr?=
 =?utf-8?B?WGswVHkrSkplOUg5VDRZbUFJcFRJN1IvMXQ0OTMvRlpLbW53THNCMG5aUll1?=
 =?utf-8?B?ZjdvQ1IvOGJ1Tk9UMGxPUVRGRXZ0a0ZIZ1YwWUM2cXo3ei84Q0wwbW1tbGI2?=
 =?utf-8?B?b1BQaDJKWUs2aDVhanRFeUtMQlFGT1QrUGRFRUhkWXFUcElEc1NodVVMWkRa?=
 =?utf-8?B?ZVp0Y1AxdUFHTlA2UVM2WmdhUzRmc2hGcllsYjFEckRuSktmU0Q3UUYxbk9V?=
 =?utf-8?B?RXlFM3lYY1FCVUNnd3hkQVh4Z0g3R2NGM0p6VEZ1TWhGQW1qR3I1a2RyMklE?=
 =?utf-8?B?aXNxWVdTV2xicHg1WkpSZXVxamFDc1M3MzVHRzNGMzVpV0kvbzV3QjM2eWV0?=
 =?utf-8?B?V3IvM0puUFJnSFN6cURLVDNMRVZjRmlyYlpYaFJGWHlxc2VZdmVDWmhWUUxk?=
 =?utf-8?B?Y0pEb0JQeGxUZHlHRkRNbG5hUXluQi96a3NxZXUxU0dFaWg4RnNCRFo3cFJP?=
 =?utf-8?B?bS9VNU4rbG5DaFgyS2VEVHpHeHlqWVZPWVo0M20zK3ZwSFhRRWU4U0t3MS8z?=
 =?utf-8?B?SlNjaFhBVmJSWlI1NXV3NmJnYkNndysySVFvMHp0QzN0N1Q4MGY0YndDMDEw?=
 =?utf-8?B?MjlBYlgvZW9pbjk5WEhvNUxGbVdaLzhQakZqQy8wa002MzVEZkxLVVE3cTFn?=
 =?utf-8?B?T3JtcGRsV29kbnNZU1dKbm9Va2VpZ2Yxa29TbnRPb0R0OFZSeis0QWtaL2JX?=
 =?utf-8?B?dDU3cUVxRmx3Ynl4YlBtMW8rSU1RbEVtb2tIY0ZoVkpCQXEwOVZEOUMwMzlG?=
 =?utf-8?B?TlhiWjBScytvWkFXL2FORDZDcDVaQlovZWgwMTJZbTdVSmZES1dZOGZvUTNK?=
 =?utf-8?B?L2ZwMDM3SzRoU2FKdi9RZ1FwSDQ1R1RrMUV0SUt6L0RpR0tTbEc5bGlzcEZs?=
 =?utf-8?B?cDg1T0VNYXRSRWdrOGxnMTF0SEZ5MWo5TERoQnNjOTQxNGFLMlZHWnhxR1Ex?=
 =?utf-8?B?QXF1K3dpVGV3THVnUUdXUW0wdGxUN1QwcDJxQ3lmYThnN1NCYVVuKzlWamhB?=
 =?utf-8?B?dllaVVVxYUlGL3BGb05IWWRsdDJSSE00WVpRdUZlYkxMSStwMUJ3Nmx0dUxR?=
 =?utf-8?B?Z0wwWmQ2RWpQTGNramdCZTVYb25HRFBBT0IwRWhhdTc4REV6dFVWbjYxR3Q0?=
 =?utf-8?B?TGVtVVgyeURDc2Jvb0xPQWNXTGlUWDNlSEp3bjBFVnhxNVZBcEpwNWthZVBn?=
 =?utf-8?B?bHVEdXdoaWZhUGNEZTF6dFBYaXJkcEdwQ05qNzB4OXhwSGRTVHRjejVVQzJO?=
 =?utf-8?B?MkxqRkVOcnJiMFFrU1NqNG5zckVVT3NBVmhqMjdackhEaFhLbTd5THJqL2Q3?=
 =?utf-8?B?YmVHaWVjVTJES2YzbEFxMEpCeXQ3MmpDKzdJbkpPU0crVHUxQjd1T3p2dmlG?=
 =?utf-8?B?dWFCeEdxQ0gxMFExakpSMjg2OE9UMzBPTE5uWDNaZCtXeVBMeGNCS0Fla2ho?=
 =?utf-8?B?R25BU2tybE9FZnBrWW9KM1RNN2N3Qy9aMTIvSjI5RGdHT1lwU0VZMXNnRmZJ?=
 =?utf-8?B?SzluSGlMK093OUhqN1A5L00rcDZDRXdEZUlTcTZTUU83a2RSeUhwMm53YzZ0?=
 =?utf-8?B?WTUxblgxSjY0T25PWk95WVZZTS9VWTZuZmNWVjM0WFhISnNBTjRoaytuUXM1?=
 =?utf-8?B?MXNJRUdxYmtIemFraytsK1dqVE1tbURjVnJOTnRQdjYyd25zdTlqL2NkaHZW?=
 =?utf-8?B?REgzTTgyRjFSOFNGRmlqWldscC8zelM3bXBsRmlHSkRKUm1jdTl4K3NXdGdo?=
 =?utf-8?B?Z2ZCN0xiM0R0UnJPekl4Vm9Kb0VCaDNnZWZGT2pDcGEvTmFEc3pDUlhWVzE1?=
 =?utf-8?B?WDIwVWorczhWTzZvUjZIeDhJdnFic1ZIbnBzeXBoNWtobUlOMW9xdkV5elJm?=
 =?utf-8?B?TTd2U1gxd242M0JJRGxLR3hXNnpWTVhGOFVnb1ZGNUNoVUk4dHF3WWozdVRU?=
 =?utf-8?B?Y1Z4STRaM05FQzlhUEovQlVmajNwdy9wNDI4OGhDaUR1U3hJMjdrRmJrQk43?=
 =?utf-8?B?YUZwMmhKckx6cGhmbUppRXRIdHJJOE1SampMWi93WnFvZmVWajRtVXI1TVp6?=
 =?utf-8?B?UVlzczA2YVAyQWlwS2F6Um4zL2VhUW53eUFETWxiSk5qYUkydlBNZVcwTHla?=
 =?utf-8?B?SDU2YWl3aDhuUnRBUUVxamUyTXFNUlg3Q1BPSFl6c0oreXFVaGl4dGJSZ1hT?=
 =?utf-8?B?Wm8wNmVHRG83TEp3N1dWMGgwaWh3WEpPa0JDQ2s1Vjkwby9ZKzRSSXhGN0Ny?=
 =?utf-8?B?eWJZRXhyTnh6VFN4RVd5RzM2ZTFBSDVzQ3VoRm53U0lZVU5RRHg2b0NPRFpl?=
 =?utf-8?Q?ltDeI8/KxmX+Tc8Zm35eYU92REUS8VPezc73IUw5mtVLf?=
x-ms-exchange-antispam-messagedata-1: SdiIU3Ay0lSU9zjQCb+9J2Vh+iqfbaUEitI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5C9A402B863AC49BC433E8E0A1C27A0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K4UsmA3Za0OBLPzhHZIprfoETnJbnjUQypiFDdF2D9l6MCTENEbYpASsk6jvWKbL38l1Nz5yooxSnYFcYr0weN31MLDpflECT2yDoiEseRrWTg5nkmSASjxqYK1yBcYdrYnKp4yYrXTSq6BJsvVwOPhC7YDHH/tlUjwJtWRnxHhfRzuE+ObVcuMlLGQUFvcrbW1Rj/rriEBjQaqML07RyAMkx2QezsPIDzYIjO0LadaDjXPGLNqAyM3u91F2sbBSRLSFUnD5xe9grDbqAcPOfbJLwdq6ITLy3/zGA8DA2IAbN/9pBfHMKgM71dOe2EUd5gd64ZqkPXNp2mgH/zmOnqA3pVr+93o/dJOy/+Zc1lCdk3srpXRB5LWjaw8EvjctfhKuVmDyiN8YiMQrsEEIRZ0fXQkxWf1vcERjpCxdslETiE/iNa1R9yK98eG09D9ragsPAO2sQbhYgyYLnCaXSNItpwuiTs62ae4o7loCQitPdl5jCxTNUsxvtrzI6cG+QzWa8RCPr0r/knhkF2lmEQ3JJksN7WLgc4PW72n/4R3gmXtPg3LZKCFjlG46PaycrZDitNxUdr1RU3vP6/vOL6OXf6NtmBkhwFdCqZ+F18PArMepFEpHjmSLo95RH59Q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6068e6-cd1d-4b07-cccd-08de75e472f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 09:41:57.4176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSN5lbVGmJcMXPAIK3qKQoMDDmn/wM54vAXFbiDg8CdDz1b6eW/T3w0yBsgik3cZeCLFHD/6s89ZxvFs2X8FRJFVotyCGe+FZ1aqf8/RE/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6397

T24gMi8yNy8yNiAyOjU1IEFNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gVGhlIGZsYWcgUVVF
VUVfWk9ORURfUUQxX1dSSVRFUyBpcyB2aXNpYmxlIGFzIHRoZSBzeXNmcyBxdWV1ZSBhdHRyaWJ1
dGUNCj4gem9uZWRfcWQxX3dyaXRlcy4gRm9yIGEgcmVndWxhciBibG9jayBkZXZpY2UsIHRoaXMg
YXR0cmlidXRlIGNhbm5vdCBiZQ0KPiBjaGFuZ2VkIGFuZCBpcyBhbHdheXMgMC4gRm9yIHpvbmVk
IGJsb2NrIGRldmljZXMsIGEgdXNlciBjYW4gb3ZlcnJpZGUNCj4gdGhlIGRlZmF1bHQgdmFsdWUg
c2V0IHRvIGZvcmNlIHRoZSBnbG9iYWwgd3JpdGUgbWF4aW11bSBxdWV1ZSBkZXB0aCBvZg0KPiAx
IGZvciBhIHpvbmVkIGJsb2NrIGRldmljZSwgb3IgY2xlYXIgdGhpcyBhdHRyaWJ1dGUgdG8gZmFs
bGJhY2sgdG8gdGhlDQo+IGRlZmF1bHQgYmVoYXZpb3Igb2Ygem9uZSB3cml0ZSBwbHVnZ2luZyB3
aGljaCBsaW1pdHMgd3JpdGVzIHRvIFFEPTEgcGVyDQo+IHNlcXVlbnRpYWwgem9uZS4NCg0KVGhp
cyBpcyBhIHN0YWxlIGNvbW1lbnQgZnJvbSB0aGUgbGFzdCByZXYgdGhhdCBkaWRuJ3QgdXNlIHRo
ZSBpc192aXNpYmxlLg0KDQpbc25pcF0NCj4gK3N0YXRpYyBzc2l6ZV90IHF1ZXVlX3pvbmVkX3Fk
MV93cml0ZXNfc3RvcmUoc3RydWN0IGdlbmRpc2sgKmRpc2ssDQo+ICsJCQkJCSAgICBjb25zdCBj
aGFyICpwYWdlLCBzaXplX3QgY291bnQpDQo+ICt7DQo+ICsJc3RydWN0IHJlcXVlc3RfcXVldWUg
KnEgPSBkaXNrLT5xdWV1ZTsNCj4gKwl1bnNpZ25lZCBsb25nIHFkMV93cml0ZXM7DQo+ICsJdW5z
aWduZWQgaW50IG1lbWZsYWdzOw0KPiArCXNzaXplX3QgcmV0Ow0KPiArDQo+ICsJaWYgKCFibGtf
cXVldWVfaXNfem9uZWQocSkpDQo+ICsJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gKw0KDQpJIHRo
aW5rIHRoaXMgaXNuJ3QgbmVlZGVkIGFzIHBlciB0aGlzDQoNCj4gQEAgLTc4MCw3ICs4MTUsOCBA
QCBzdGF0aWMgdW1vZGVfdCBxdWV1ZV9hdHRyX3Zpc2libGUoc3RydWN0IGtvYmplY3QgKmtvYmos
IHN0cnVjdCBhdHRyaWJ1dGUgKmF0dHIsDQo+ICAgCXN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxID0g
ZGlzay0+cXVldWU7DQo+ICAgDQo+ICAgCWlmICgoYXR0ciA9PSAmcXVldWVfbWF4X29wZW5fem9u
ZXNfZW50cnkuYXR0ciB8fA0KPiAtCSAgICAgYXR0ciA9PSAmcXVldWVfbWF4X2FjdGl2ZV96b25l
c19lbnRyeS5hdHRyKSAmJg0KPiArCSAgICAgYXR0ciA9PSAmcXVldWVfbWF4X2FjdGl2ZV96b25l
c19lbnRyeS5hdHRyIHx8DQo+ICsJICAgICBhdHRyID09ICZxdWV1ZV96b25lZF9xZDFfd3JpdGVz
X2VudHJ5LmF0dHIpICYmDQo+ICAgCSAgICAhYmxrX3F1ZXVlX2lzX3pvbmVkKHEpKQ0KPiAgIAkJ
cmV0dXJuIDA7DQo+ICAgDQoNCkl0IHNob3VsZG4ndCBiZSB2aXNpYmxlIGZvciBub24tem9uZWQg
YmxvY2sgZGV2aWNlcy4NCg0KDQoNCg==
