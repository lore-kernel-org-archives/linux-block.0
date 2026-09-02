Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96BD466B09
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346844; cv=fail; b=mkNbMMdlTjErh36Ie10/xpyXunw5GEyROzso5AeSzL1igLG+3vhpjNYFvwlu5BZqnxxubV7X0WaG7PX/jQt+Ru7LWieTcLkq+xc3OHLwg5HaCxFxRmEB7OycqPqCWsl2VGioMUJn/TbvvDrzJ0bHGSk0ZKHk/XjSoOqMs3OUdDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346844; c=relaxed/simple;
	bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Md6nS6VY5gifAxUzNe4jaaTHtM3HVJLzNZxfLlxtHzTK8IfaliDs1J6HcEYXw+t+K7eoIv9MkvbBLv2LwgaJ14IeBXmb60g083+QBcfOVf5x2mCRlERM1RGezhbtcpJdwIsZekbXxZOV5uf7hY5h4NZ8tdHEKXlQAZNUX5Sn7wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HMDiaLud; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XGbqbu3a; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HMDiaLud";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XGbqbu3a"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1788346842; x=1819882842;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
  b=HMDiaLudEUzwSyzM5G7z6Z5iNB5Bn5WtLYrTC69UiTFNatqauXJUGgh6
   jNf4Nud6mRANulGHGdlw1bIuWlB1UVI4p7NDXQQDGVIYhZjFZLmm3DeQF
   h1eRfCGDtlbH04bBaatLRJKejjwUWuv2dNT8jCRlGmEOTFRlUx/wZ6kWk
   Ld3pUWxcB8Txp/tYYxBSJJO1LkjSM12uaO3839qoJ2Qm5P5ARLzAKY31c
   lLz99xr9b6Wo7CKWM+vMclsHvTpP11pVScm1JQZxtWgmtqXJ7+xibTJxm
   NmVtJ0MuEJpgJG7HudhnmZeIA7P9OQ/J28rWwXhDIRnafOM3l3Lm+FI3P
   A==;
X-CSE-ConnectionGUID: +frOdoaVTzK09JDdPMd6iA==
X-CSE-MsgGUID: +WL6FY9sRmSHsz2BJv7ABg==
X-IronPort-AV: E=Sophos;i="6.25,257,1779120000"; 
   d="scan'208";a="153198391"
Received: from mail-centralusazon11010062.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2026 19:00:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwbnXxDnqvH/wausEFfMnlqQ+IncjD/rRMpnp+Ka6qB+fQWxcNar1BGomWWlhyx6utqgmK2DID5yPn5s4O/QSkAoqI3c68IEeio2FqN9z/1hO+gqnuyt8/euoMMb3zOnKqSzgswI7Gzy6lDEdICl4N0w1Hm+tD9r+0SnWQCqyS0SrQbfryYYx1ZumC1gxxP/lGXyzjhjfAiJETpM2wlsI3ai51P+ibc1sM6vjnc5/1e4EUwt87M3drRojBSgej449yZ0IpEhaspNcjSXm+DfMweYDp7R1sQuTTvkgXIZfyFdwDdcLJcv/854qifq91SLGhj3aO/UtWWHgG9pZTg3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=FSbXToMjf0gy5mJgtbenQsPBV51hm88S4zI9YZ5MkWSYBDSnCP9kzzzNoSImHEO/Q5w+6iNSMfDnPrnVQ5QW9yXg+224fvGU5GnhaOdtmXeFpUPh5QBs1WcT8bH4fOyDyZLDKas87FrytdTP4lzDjr/otNFBuA0F58EjGJlm25HCCFOm4W5XFtiTa8yBWZv2dB49OCku9l3EyrPDWnPRIBiyTCed6MwjtmWD+kRaEmqjw3i5DXWEx2z+EwVpe9hp6f9ghQByi74/Zx/0DBhzTCWoVQMuXExwTptMlhiRsn6m5l7b5g/3kJVaEQmpVrAnTWzyFvdB1ibLvKkg+oGW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=XGbqbu3apDye9G8Gc0JIMtNf/x8/kzprLQGAHPp9vg2TCp0Se4U3Hbs1Ad5sHStNfs6bkx/+Euz9hmAbeA0vxyo6onkY55QyE5mtBUq/VxpCHsLbO3J94y3eqjzt1V7fC4UR0BWFrD5TtAD6q8UVDJyIr/adZ8YIwFssaICmG50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by MW4PR04MB7331.namprd04.prod.outlook.com (2603:10b6:303:79::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 11:00:31 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 11:00:31 +0000
Message-ID: <44e1249b-4921-4524-b2f1-8c190c57443b@wdc.com>
Date: Wed, 2 Sep 2026 13:00:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/12] block: fail zone management operations to
 read-only and offline zones
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260831034109.744039-1-dlemoal@kernel.org>
 <20260831034109.744039-11-dlemoal@kernel.org>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260831034109.744039-11-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::7) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|MW4PR04MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b9d422-ed0b-4168-e1c4-08df08e167ef
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|10070799003|366016|23010399003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	T8jftdsj1VawvcNj4Ac2ObJXZXiUREMcq/Jx/NHjdJCRHtJxyGrumgDVCY3Vk7YKb3tQKvfFF8/nDxIbX+42tDjLsfiY1BgnGmVjNgU4yBlEP6Th7963Nwul95cGC0Cz2njwVR9KoC0Hh2HcJput9KWEkDe7YVLDr5aDLYpuPznKmUuqUaqhbBdrTKSAfu2gzftangCo66lRY0V7QtkIb26YYFIlghv2zWQlH3MQDXIXxZOwLlRgZMq6DZcQ9PM8r8Pu39q4EjRrLSqj6TybzeD4O2b7WDt2CsJjIHFY3B+bnwZTWhjO7kgHhGNVpI1wwgDrp3JP9lpl1ophZPLTAFBw58Aan5+1TjjKX9NjCntzBkBNd96RWcfiUiUa3simy/xmcp10dcFjEZYjSvoUsyAPF9kt3fbvFtMC0Vxz4nS+nYbjVk00dblDSIzYB/J8W/RyqfLJN8B72kYlL/VxVepNk+LBufjnPGQNJqCo8MD3ycbhDLxjvk0FEv7Cl+LhScPY10qvy2+v8FxdU/X9ZImkRaLJcrXlsIrBMxqZXSgtfeQqa+Tt17e82YVHWpKIRegudz7NgcM2mxRnOhb2YEFdgNY0qWPgn+sqRQVNNIAEasKVcacNffov/DXhiKcMOnCDl5AKxpXKDugRI8bTNad2vuxiD/MtMF7jMkF2qME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(10070799003)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0Jyb1Z2ZmV6OUdEN2NiRE5XSzV2TmZpTGN1akhaYVlGTUFta2prblNhdElk?=
 =?utf-8?B?UEJZbFc4eTA2aUVGTGowclllblpBS0pXNENJWDA3U3k0SCtMditUS1RwRHhk?=
 =?utf-8?B?SXNuYS8zSUlQUTFIUDltMXp4Z1JUU3RsakVYR2VEQzRDVEYzMi9UdjZqS1hv?=
 =?utf-8?B?OVVkY2cyY3F2ckJwbWlHVG5MbElMZXgxL0RwalYzTnZLS3F1SnAwN2lyQTBr?=
 =?utf-8?B?OG1wNDZ2aUVaZXF0dXdQcFV2eGdpc0YvdGFNay9BbForMmpQbVBSRkl1VEFy?=
 =?utf-8?B?U2ZoS0UzT3FnZzlUNng3VTlFR2dpeCtGTlBibjBKRlVDNjBpRmtZWEUySGFz?=
 =?utf-8?B?TWJsS2hsMU8wWFEzQU9tZEtQaFZkN0VHaGJmUGxSb0lpVmZpcktlSUhWNDc1?=
 =?utf-8?B?anN2c3lrRXJiN01wVVhROEhVSGxzSmFWSkVUYkFQdXdRd3ZZbGIrWVZta0RO?=
 =?utf-8?B?bERwdFRmK0dJUFB1SEVGZmRYTGlYYlNMbDU0d3hJQjI0SjFZQ05Sa2JTNG4v?=
 =?utf-8?B?SzZKd2s2VzVHbDlrNFVlQnhjNHFqUExJRDZ4dFlxK3ArK1czYi9uNjBuM0tq?=
 =?utf-8?B?SnZVMm9Qb3p5K2tKRzg5NzhTbi9qdVJjZUMwVDhQQmhWOFo2SnBpMFV2Zjg0?=
 =?utf-8?B?VUxpZDRtaVpVUzRHZ1B3RERxL21qeGI0S0tsRDExVWdaSkdUdXAvNUFBdGJk?=
 =?utf-8?B?V1RCNVk1UDNwNDQwQjk4WVIvRDFGKzZZM0hrSUZlbExMWEZ4U045WTBiVFlu?=
 =?utf-8?B?azJpT1ZLZFdiOTBzYUdFYmpDSmpYZUhHL3I1QldHd0RUa0FwSnNCMmVnMDMz?=
 =?utf-8?B?by9MRGt6SzNkQlBIQnRHbHVGOVRYVmVDNUtyOUpoMXdnNTQxNFpQei9oRUZm?=
 =?utf-8?B?TVFpY2JTRXhoWHA2NmE5bFgvRE5WVVVrc0g4WWsvZjdvcmZFSEE3WGhZKzBB?=
 =?utf-8?B?bm9uanJDaW1KZ3dqUU1WbDN6ZEhuUE1zV2xTd3BYSEhTUzE1aktIVDFFTGZD?=
 =?utf-8?B?MVR0eGorQ0NsNXFGNmhzZXl4UUowcEhtWldUNSt2c2FRR1NQUksvSVUzbFVD?=
 =?utf-8?B?S2ZkREFRUGwvQzRENGEyZkRZRmhSN0syQmhoL0JBcitqaEpUNGE0em5Vakhh?=
 =?utf-8?B?S0cyQnB3RFZaOUFhaldyMXdQVzk4UUQ2bG5DMUgrbmhET1E1Y1Nzczg4SHVY?=
 =?utf-8?B?Ny82Uk1iSFVSTU9iVDh5UnY5ODdBVU5Bd0hTV0lMbm1rcWF0RjErT29uRVl3?=
 =?utf-8?B?OHhqSmtpblVkOE51aXRxQ010U3NuMHcxcVJNSkpRUFQ4RXNaaDBIZFB2Qlll?=
 =?utf-8?B?VHZobWQ5ZitOSnpxYTlGN0svSDhYVXhUU2dWeWRpcEt4VC9EZk14dWZmbDFQ?=
 =?utf-8?B?clVCenc1Zy9FOFNHek5VQ0NEcVlKRUhKV1QvdEZwR2JzTWpGQjJkZkhZOWo0?=
 =?utf-8?B?b1NqQzJOU21jZzZOM2xGVGJINk9JWHZ3NTVYUUUyVndrREtETkRLdEFuVVdX?=
 =?utf-8?B?UHAzOEFtV2xQcDM2ZnhVMmV1dVhBZEQxL2E5RlhWZ1pRQlAvVE5FYkxNeXhG?=
 =?utf-8?B?UzBycVNQcCsxUUhQdndPMUNGdzhURkJRMUVPOGhEcnRWWE9uY1QydXZwbTJ2?=
 =?utf-8?B?Qi9TSXNpVVU4SlVJS0JpaG9wdDRHWUJrdnBPcnM5bTA3SGQ1blNoRVcrU21V?=
 =?utf-8?B?c1MvWTgraEVSdnJ4bGRLUnBEcWIzWTZxR1hxWW95UkpEUld5WUNyb2RkVU1G?=
 =?utf-8?B?ZHpNbGRtclh1WmF6R3c2NzBUbnhSdU1TYUQ1K3l0OGhBbFhuYkN1dkpROGJW?=
 =?utf-8?B?QWVzWnM5aEhQTkcvZE9SUXpLVHU4N3doWElBeGFWYUJ1N1lZYldWT2FsTTAw?=
 =?utf-8?B?MnVnRFRFNDFuVDh6TzF2U1ovcDJqNGVSUzFPR24wR3N1dUFEVjVaY2xZQUdT?=
 =?utf-8?B?M3VDVmUwWHlPR1BJSGs2ZFlNS0t6ck1oZ002aHRRNEtkL1RCUkxZTERCdkpM?=
 =?utf-8?B?NmExQUxSdEx5SHBmUTE1U3pJektUZWVQRnlUdlEzQzhiaUpPOVFxWlp2ZzNC?=
 =?utf-8?B?c0RtVGZCQUY0OHJFZnIwZnFyTVBCVXpmV2RTYUZ6U3ZBWlp0VWIwTzJJR3BE?=
 =?utf-8?B?RlFIOFdHTHlFWFhkUkVGMC82bXRHTk9DQ3pBcGpsSk9zclQ1ZVg1UC9YSG4r?=
 =?utf-8?B?YllVTmlpc1RCQ29qVmk2eFRKMmFwY1lPN01LeTR2OXVYYzNNU1Y3dldVS0N5?=
 =?utf-8?B?UVFSZlFJckVEYXcvMm1oTVpRWFJFSkZ2dld2RUZlUHBKN3JIVFh6N3hMN0M5?=
 =?utf-8?B?bDAzbnRDVGU2MEZ2ZXNDdDlIbTNoRCszd1JhVWhWWGRkS3N6am5ucE1iL0tz?=
 =?utf-8?Q?kXz3poMV9vBfZDloxFx/K+U41Dh342GvmQBYbhVzV6VbB?=
X-MS-Exchange-AntiSpam-MessageData-1: OJywtXQLMNqzhH5tjEKu+RkRswabYHvL0Vw=
X-Exchange-RoutingPolicyChecked:
	D/v538DUeOlEsDSTZ2dDSpF6mBuapJswNjswcfTMMAhlbm05A5QxC4Z7rBJjSycx4sQKgAgV4wUIuspApfzlnetCGBlTgFAvup19gawnnhi8lvinf1CsRZ+4xU+zfCT4ojHX4WRY3h6xtChK/dI0JZYMc/SpyqZLpLQMYHI5LcT13Zs2KD0RnSmCS303h8vpQgPltt8J5vdXYAxevatTFOh7dYBMg9GHD4eptMOHnYu4/Vw/NLbIt70WGAmGM4s2o6h1xZrchwmC+ar+uIZII+ASugYk9bEXKVgd384Bqb1uGRshWbr8vXyPx4TbzUkZbWM/hwQPjJ3rYvccvp1UIQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ziOnQQQfn3NGAVBARbDDyc7cmBPWU6s5I+mKCHPvO3Zo227gmap/0hptJ5DKEXTlcwqDJTS+pdoVgCiq19jJ31cXqXEbRqD20UMc6oX56O9LzX15cBQytdGYo+jguy7rIMSvgBFCvu8vwmIsypktWulRSFaUWVQHEipIUq2GEyBsr9PLQLJtQCj9LHPAcCZEEBZGN60uIxdTVEky9MsE66vFQMiEx3oB2mobjP24Csw8XGaacbkiUO/COjS5IIvEiWNgBDqSFG9hAsK0inT6vGlQDGccMjtTbnd10cINyosO3FKeWBzc1HpQdbLTo1nji44wqA/WjSZkk1njbAZzpSIlNqu+yxIRydWvtnu1ieo+3klfAYtNljsxEYSVWh1ZjSDey1iBGw/oQrTLg+pQ4aRCHzZ/Rg3TPjxdDbUhQW3Hyh6B/wVvuxNgWjNzKpVu8kPlGE54row/kWjVJijzfG0H1d10PW1I9Xu2wrsuqND3pcZB4w8t2YfzzJeJXxBLXDRiw9y3+nCiY0YHnQbAfEW8EPoZL88g5c1Fmx3eZVwOeARybMBeL36aByExlHnoHeXucNEuCsC24rY+bPx93fhYpveyTIUgoQSRQ1fDsbhTBQSO+tWddgd/LjXmBiNJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b9d422-ed0b-4168-e1c4-08df08e167ef
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 11:00:31.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBQc9LYGT9MItDu5jSnQ+OXS23inOEh2jdqjFtCHTfXTAyXMX77q9xvWseq2tvWz4rF11PGuIUy38f089ASKCHW+CGq2+E/hklwAHNEoXlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7331

Looks good,

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

