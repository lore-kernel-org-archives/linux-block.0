Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB59A21A436;
	Mon, 27 Oct 2025 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547917; cv=fail; b=e0wjic5bHZu8pwLZELJxL8vC73V+XxborqcCbo4nBrGsDGD2Qskzu6uwPkZvuRz1QZ5y+fuE6tE3GbuFE0b/bpNAc4yf7oxTVXqiuwmExW4RtrFlHh0eBH58TSO/nWjTPwAm3QVwPpIRFxyiL3lFjMxl1SdKnY3S+g8Ycpfwtks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547917; c=relaxed/simple;
	bh=7cT04XAL7pVmVBSv7nZY9o5aGqIpSNka9Sv1PXeYeZw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fYrknOPT61UmzxsHusy7T8h5f9ENnOUjItSzqTbeQWlfEnGn9BuEG0SX44YlD1+bpM8fS96xkVJNFdj6AjwtvOQ+/+3n8ZDc4jKXfIAoUCZHQLSpCS2eWDLCTEaotfDcO9uuVa2m8jhKeFMjUx42Jgd1Jj46tbpS0FW5BzXUDoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HUQFKRPQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=o98UvTdN; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HUQFKRPQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="o98UvTdN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761547915; x=1793083915;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7cT04XAL7pVmVBSv7nZY9o5aGqIpSNka9Sv1PXeYeZw=;
  b=HUQFKRPQ8GCpOm5GnsmFUE6trAl62ARdCka7khlQVA0jV+UCzH5AaVCI
   Fzix0zU3LAO9yZbkRxslajve8PmGZSGVwR86ftDJZyKiT997TQrPwuXOP
   /jtZXQjAQ+d3Gwf/lKVc+AlpMhxKVsWF8ef89UFhHRpGKusQWBQ8HeOyc
   Zai3ziNMFN0+AKxrPHJg13MgRyuMJjnYfRKD47buELz9YTm5EII6AchuA
   uVNqkqfu5wd8oR3sMsvBMv5/3qBQ0dMSdTcdoaD+KIkV9rhHbWvGoQua6
   tKSU67tyCbckgg9wgLLk4enrksPz3KCj+4DNDC25dxNy/Og4pX4wE4PTC
   Q==;
X-CSE-ConnectionGUID: TppLpzQ6TvWpYHCQ+3wI4A==
X-CSE-MsgGUID: mSXs5NRXQu6b5NCz2ymwsQ==
X-IronPort-AV: E=Sophos;i="6.19,258,1754928000"; 
   d="scan'208";a="133865154"
Received: from mail-eastusazon11012004.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.4])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2025 14:51:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjBhTJzv1puTMbpbewVbpdBAq0eVnYA9TJ0RQUqgI8HIMYQi+sgKXC1SE8yhKImDhyvmzjcPfuFzhHzj62apHuYw1mkrKPAY36W5YNiujuMBh6EWZH24FvKbjMSn11uAy452laEDvgFpMiGZRp6W5XhwrKPU0tUoU2CWVQZXlwLimMA3hrxqIJXTfVhiiU8HCG05rLzdb3MjuUHR5xcAY4QS41oJptPZOLMIO62X3+BykFxQAsf0BrwDXVtcnL6H797nRcQWct8H6IIytk4jQ8IZ0j0YxJczgY+KImWaAwgEVaWUSkjjd/clupTqGT6grTWfVIrVQheEZyzoQTm6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cT04XAL7pVmVBSv7nZY9o5aGqIpSNka9Sv1PXeYeZw=;
 b=Yim+ktIntuGSFnRUTXPdtIsDFKAK4gjG41i0WdDwjevPX3rV0Ns14ny9aREXbVt1ypcMW4+qEzPqEsv3jNRy0QvA8VrCeXzZ4biLbmhuSs3Rq6Nd8p+3fPLGdqPJUMZxguM0omzHUb9jAY9uj8EQA1yFGP7u/NnvUDhLoq7rp74w2VvGqpKxLMSP+obBPpCdhRLt1TEIvhDVEAvK3DfakWBHP0lijmvZbRgOAmiJnLxBvFpD9Bc6JLIu09Ka+v1pck2KxqhkURPZ1e1R1cjGcoctDi03Ash43lwEv45vnAQt7SpOxlKIwW9jeE3Nm8ALqqIC1E28fO20H+T1ItGXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cT04XAL7pVmVBSv7nZY9o5aGqIpSNka9Sv1PXeYeZw=;
 b=o98UvTdN4v/vt3PX43ITcOFlk8nekR8IZxAViqL6r88ec0al8XmXRzRkWoQzgWPKduWIuWkwhj7gLIOdFjD+kq5RsN0pZ+Fsd+lJ5FDSt5zDeE/L1ne3JABS2VA0SmmEMzCuHHoFmPFNbLKIINjOHxcWMzMKjpEEswEjqAWLU+4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN4PR04MB8366.namprd04.prod.outlook.com (2603:10b6:806:201::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 06:51:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 06:51:26 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: syzbot <syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [block?] [trace?] WARNING in __blk_add_trace
Thread-Topic: [syzbot] [block?] [trace?] WARNING in __blk_add_trace
Thread-Index: AQHcRTuQBmz8bHYovEi5WMhw7r+WZrTS3e4AgAEBJQCAAbKRAA==
Date: Mon, 27 Oct 2025 06:51:20 +0000
Message-ID: <f41782a9-7e2e-46f6-84a0-2484c75d9716@wdc.com>
References: <68fc07a0.a70a0220.3bf6c6.01aa.GAE@google.com>
 <c4ea8d7c-e449-47d6-b4a1-54fdbe86ba01@kernel.dk>
 <cc31bf15-5c9e-43b5-9615-2475aebd1d53@nvidia.com>
In-Reply-To: <cc31bf15-5c9e-43b5-9615-2475aebd1d53@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN4PR04MB8366:EE_
x-ms-office365-filtering-correlation-id: ef13cfee-de39-4af6-ffad-08de15253c57
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SWg3cFFueWhMK29RelJ3TjN0RmZ6NFpLMy9FUHlFYWpuOXhFZ0c2bUxjTjRi?=
 =?utf-8?B?ZS9ldVJxZTg4dWRQU1FPL3BxZGxsL3h6c0kyM2tMNmFLQmVyRzV1b2l3SCtx?=
 =?utf-8?B?ZFlOMDZsSlQyTzJZVzlvTFlVaHBIRGFDRmQwU2x4VTU1Yk5ZUDQ5RGZkQkIv?=
 =?utf-8?B?bFdBTW5yWWRsS0M2dXBGQ092L0p2V3NXR3FwelNNWERrZk1NSTJ4M3JtcGlZ?=
 =?utf-8?B?Q3A4QVFxTkJkN3RsVllCSkZOZGJjY0M4MmpER0NscmNmU3FGclU2SVZuMVQv?=
 =?utf-8?B?eHVvZzlYUDQrUWtHdkQ3dEp3MnF6VmxHeTBqMHZiOGllM0dRYk4yNytMaWgx?=
 =?utf-8?B?WUxHWGlkQnkxNjNEcm5OTXRBT0ZMSDlZRnVSc0lIZ3ZuVk01MERkR1hYOFZF?=
 =?utf-8?B?OWxwZSt6czlscUF2V1loMDFidWdxMEpDUEEzcHg4TFUram1ON09NYkg5MnI3?=
 =?utf-8?B?eUt0U1JQVVMwSDlWSE9Pa2RmNHN1S0UxY2g1eU5PN3U4dnVLR2dEaHJvOFRj?=
 =?utf-8?B?MkRuZmlHR01pYURac05kWml0dFQwMkpUY3l1K2RFRjJqYjh4L1E1MEN4dkx5?=
 =?utf-8?B?ZURxWWxtZXpqRlJ0cER2OGdSellIbUNPZlNvK25vYXFqNlFlcDVjZ3hmTmVh?=
 =?utf-8?B?SXkxMGhnek9YK04yaU1BbDRUVVhEeWtjYmwyYVZIOWNYd3I2dVdTTjFHSUNi?=
 =?utf-8?B?RDhIdE5tSjAyVGpJcDFIUUxWVG9oSkcxV09LRDVWelB6dHVhRHU2d1pUaXFj?=
 =?utf-8?B?aVk2djgrdEhpc3ZBRWFvV3pLaTc0elBDbmZ0bEF3RVpiK3dtMEdkZm5YMkRp?=
 =?utf-8?B?NUl4R2c2cGFnanFtdjV2bFFjMVc2M3lRd2VHV0dkQzhYVXVOSkJMRGpGdklB?=
 =?utf-8?B?bGdjWkx3SmhFY3JyTDZ0RGhFYnphMHA2anNUVFZQN1VjTjBidkZzUXZBczda?=
 =?utf-8?B?cVFZaGxnL1lXcDYwOGVCK0kyeHlaK1doODU3YklJcitJWEJCNDdRcGNZNzNv?=
 =?utf-8?B?c3dPNG9pSEtZSytJMEtJNDcwRTRpdVlTY29reVNIdVBwSFdBWS9mNldhOXNi?=
 =?utf-8?B?d3BNVjluVVFQSENhT2VxcFhEdGJEanNMdmUxYnlldG15QU1WZU01S1RNampU?=
 =?utf-8?B?RmFMT3gwOGVVRk9TMmh5K1BKd0ZUVVAvaVc2bDhRYWFmSGhkVW5GT3ZTTDI2?=
 =?utf-8?B?alpQVU1RU29Rc2V1ODRlT3FhTGJFUEJybGl4clZZZWczSExmeWZWdnY5eHRl?=
 =?utf-8?B?NjFac0N5Sjdzdnk4Y09QdG9PamQwQkU2cmE0WGxEV1hFUGhFZnF5RmJPRjVq?=
 =?utf-8?B?TkxkTVBxT0RwTTMwOXFDckxyaGc5dzVxTGQ2bWV0TkU1TnlUOCtyNVU5MTBi?=
 =?utf-8?B?WWpkOTRVTldUSXFvVFVXRklvTEVhcitRaVhCbXhJVEZiZ0QwUER3a0xYbzJS?=
 =?utf-8?B?SU9GRFFkTXMvUmV5Z2VPZllOblp3UHU3N3JMU1F3c1NNb3dJREJ0VDNXcHlY?=
 =?utf-8?B?bTNsUTJkVEZOSnpaQS9NUFRaV2VIL1o2MG1PNFBQSUdTRTI1U0FiamJGVGRM?=
 =?utf-8?B?Y3BKMGxhcHdqQ3Z1U20rUVNHblhwWDdBQ2dKNGRaYUE4Y1c5cDN5b1VQYzcz?=
 =?utf-8?B?bHM0bHh6ZHZSZ3QwN2lUTTV0dUZ6V3JyL3k3SmVoOEpoQVhxckI3OXZWMTBU?=
 =?utf-8?B?MTJzRFIxYkRBakw1MThUWUJqOWZPcFRFSUh5UUdIcEd5VnZLZzlRVk1lQUJG?=
 =?utf-8?B?cVVndUVNRUhmZWdLMUhXdGZuSEVDZzRUSGppV2lVY1M2K0RibTEzWTBBQWtR?=
 =?utf-8?B?N0swNTdJUzY2TGtyWTQzbStNU1dDTk8wdFFDNm55WjNjS2Q0UFZ5TXZDTUZ4?=
 =?utf-8?B?Um9zNGFBRnlGbW5Bb1UzKzRidm9GanVFU1prZSs1dW1RZERabDRqN2JvcWk0?=
 =?utf-8?B?SVJpbmhGRmF6OUhVUW5QWlgzUStpbXBXdDRlRnM5eWd1cHp5UWhiZy9SR3RV?=
 =?utf-8?B?TmtoUGFSSEwvT2tIb1p3UVpVdVZ5WDZwQjg2bmk0L0VsNm5walpIQzhPYXJm?=
 =?utf-8?Q?JsJEAi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzU3NWJwdGRKOHNyRzFOVHlaZ24yWXlzNTdSaDV3dXBiR3lDMHdPL21sR0dt?=
 =?utf-8?B?Q0NDSDU0OXUvcllKRVJIU0ZmSmhlK204QVhwby9TaVhuUGE1OEJieTd0L0xC?=
 =?utf-8?B?aUphZmRzN1V5ZGl3OGt3Z0tPaEpkcnhqNDEvZmlYVUZKZHlCcmp1MFR6V0lS?=
 =?utf-8?B?YVVjcXN5SThxZDdYQTRjYlRTbEpEMkJITUJWZ2x3SDJXSmZ2bFNycmFqL0JS?=
 =?utf-8?B?d0dRalBHbnJHOFBCWmlhT1hxMXpzWWF2dWd4U2t1ajRzNlVkbStlL1pITFVL?=
 =?utf-8?B?d2lUM0d2M2FQM0hXYk5RU1RWSGVGMnd5WmNiYmNtWFBZZFAwU3Y2R09BY3Yr?=
 =?utf-8?B?aWk1OFN3KytRZ252MGgxY3l6YUFYUXBSMm1IMEpieUxWTUtWNHRBQ0hIcnpI?=
 =?utf-8?B?U1V2Syt4cUpWb1NkcU5xU0JseEFHV0hTdG5WNE9DaXJhWVZ5REFEV2FTNUdL?=
 =?utf-8?B?Z2NQL1RSZ25ZZ3ZuN0tORENyc09EYkJmQjFNakU0ZWgyMHlzeitlWk9xbzIy?=
 =?utf-8?B?djVRNk5LTlNFY016eDBiY1A5NTJjUGdEUkJBc2hocUJYTS90LzZwcGR1WDVh?=
 =?utf-8?B?cG9COTVTQWN4Yzg2M1ErWVZYTTlpNUJ4STdkQkF6V1VvRlNJTy9VV2tsU2Ft?=
 =?utf-8?B?OVR6aUNXam55Q3BOQ1Z1Ym9kb29LeGg0QThINjJIOGpockdQeWtaMFBTZVpL?=
 =?utf-8?B?a3Y0MFNBOTBBMm9mRmJoc3JZY2l4STZNbHNvUHdCU3lJWHZEWklLMzJuc0ND?=
 =?utf-8?B?OWkzSGczN1FmVzZmYkt2ZTdEUUUrVmxscDBKb3RBSkYwRGNTS0hjMThYUVp5?=
 =?utf-8?B?SWZEblFBbTBTckFoT01MbE84N0UveUJxMU9zVEVWSnhhUkJEcVhXa2R1dkZY?=
 =?utf-8?B?UG9pM1QzbFp6Q0VLVVhrWmNGOVk0WFNIRmZsSUl1OTBNejFqaCtlb3JMdGhx?=
 =?utf-8?B?eU85a3MySXBYZU1KUVVUKzJ3UWRYbTVvM2hHVmZXUUl4ay9ISzdxbzl2MVoy?=
 =?utf-8?B?bmJ3cTlNbUJwV09zTFJBcjBKWDdlT3g3L3BLbzVvbml3T3MyNng3cUdLZjBH?=
 =?utf-8?B?SGVlYWFzZm55RC9ITlg5ZHRZQ3d6aitXMkg4dVBUaHg1YkFlVXRkOCsyc0Nu?=
 =?utf-8?B?SGxOd2QrVEIxTjZJOXU3U1RXemJ6eEVIbm9tT0NKV2FkTXZWbXQ3UkNWTFNO?=
 =?utf-8?B?MXhtS1ZJWXdIOUd0eDhqbXc5Z0F6ajUrV3NuditxU2dLOGk3UFc4MC8wYzNu?=
 =?utf-8?B?aGRlNDBnVGp2WFFRamcrM3BuS1lYV0xreXpYeXVzYTUyRkJidVdwbmtmd2k3?=
 =?utf-8?B?dk54eUo2dWFCWTRjNnZWTEowR0VkUVQyNUVxUHdob3AzUFNXNzB1cjN6OGo4?=
 =?utf-8?B?SHV0aDhmak1SNFdmUFFsa3Y0RHZrNlJJRWszTTgvd2c1VHYwZG5ZZzlTcDFE?=
 =?utf-8?B?Rk1JMkNwbEdUREFqUis1Y29USVlycWJadjVJcnUvV2JIQzR2T1JIbStLNVpq?=
 =?utf-8?B?Z092bjAzVk84b3BPbWl4UWFSY0xnRFNvWmM5eTdoL21qK0R1VGlCL3VzdGlO?=
 =?utf-8?B?Yy9PdktqbUVGSjU0ZmlHOWpqSklhOXZJdW9SY0g0ZW90c2IzMHdyL1Q2eHlD?=
 =?utf-8?B?SkYxdDdFZ2xUWnBVVVl5Ly84bnFjdFFMd3VSQVh2NnpvY3ErZ1VMNmswVGhH?=
 =?utf-8?B?b0N3WW9VdWwyV1BrL1ozb1M0Rnhpb2NNZW9IWmNRaEVmalNWVmFxakR4YXZo?=
 =?utf-8?B?Smx6SnVtZmdNcU1HNk1vZzFPRFcyQjZIUlZ4Uzh0L0JUWFU0TkFwUmpud3Nn?=
 =?utf-8?B?Y1VvWjFlOGRLYWN5TjBHVGVPczdyZE9QTjV0bHFRbFZnV3g0azlYWGpTVi94?=
 =?utf-8?B?THdueDJqczdETXUrYTdWZmlyTXp4NHU4L296eC84aldCUWc2WVo0b3gxZDR1?=
 =?utf-8?B?dHYvNlRXanhpVDV3VFY1dlF2bFJTVHJyck9Uby85UTdZK3Rid2NVdFBCaGdQ?=
 =?utf-8?B?ZFc0emRaK2U0dk5UV3RaNmZYL0hPNkd6QThlOHlWQnF3NEw3YUszUzdFdGk1?=
 =?utf-8?B?S2l4RVRra1piTXF2UDRnR296bW9NZGV2cW02R1BYNXlReWUra2g4Ty9KWm92?=
 =?utf-8?B?eHBidXcveDRFellHQjgyb1NIbmlBZGpuS2ZYREtNRys3M2xnWk9wYkpBcnBK?=
 =?utf-8?B?TTdDcE9saHlvSWovelJJRVdoQThGeWFncmtKRWIyNUdONXpuNExBOGh1cHZI?=
 =?utf-8?B?eU9FNjlCbURTMjNwazY3eDlScWNBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6EFA5384ADDD7459DAC9B1148853EAF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a0zQKSF0ollckw4DCsx0dGcvTW8yfzfIuEJRfy4f3szvm02B9WC1yLKZVdq72peUvFO5THHs7++pLx1hi/iJ8w/vDrxCdriarS7CfsW8ZSpinIfTGmknCSIWDzR281IKTsvvkIJdWsh3q90ajRotu7YLZvsBIx9PgevYL/eJSjhDf/HcmmtWJjaLpYnMqDueznVpl/XXPyvHgsdEDZgidGIn5t7I/osNW0EWLDOeC2FNdo3dLJgzM5hYynyySX/CJTxazuRKI+jUPNahK+/SpjHUrH08qlobM4NokGM60xMuSTkZNH0WTw3dRNF0jUVhNrqbqfPSrp+mFa7PFxQIwBgIYVibFdczrWuCDi9J+BYdMXveu1wsSs1/L44WamaN1LiA5oVDG6M/4AScvD1cHLdNpKq5FHPTZtpB8IuBLHeAErldQ8yNwaZ9Xv4EWWgtxbidFwDJ5KiZ+9gYAWdkbGJMJX+j3LFNCEhHBxynBN1aydkaisOsgKl1YDuCbR3TyokpP9X0acOJxEbhucOiNaphvINZ5GGrp9XaYEU1RNvmn/RLlG7Y7DRzGxNUZHFGoD/fFxOKh0AJK0ub/tj/gg98gQHprjrfuIbTFZiaUnpNxxvy84JyP9zekHz0Jwc9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef13cfee-de39-4af6-ffad-08de15253c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 06:51:20.3514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2I+YVgdhAJRw+r1/iBir24bLNFIUcgXiAQzpiRMtENN4a7iBrnuRLcKizmO+fXUDGR+wHFKyDGCMkfhBdaMPucYvzxUYmyQpKnqJXKvxTAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8366

T24gMTAvMjYvMjUgNTo1NSBBTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBPbiAxMC8y
NS8yNSAwNjozNSwgSmVucyBBeGJvZSB3cm90ZToNCj4+PiAtLS0tLS0tLS0tLS1bIGN1dCBoZXJl
IF0tLS0tLS0tLS0tLS0NCj4+PiBXQVJOSU5HOiBrZXJuZWwvdHJhY2UvYmxrdHJhY2UuYzozNjgg
YXQgX19ibGtfYWRkX3RyYWNlKzB4NzljLzB4OGQwIGtlcm5lbC90cmFjZS9ibGt0cmFjZS5jOjM2
NywgQ1BVIzA6IGpiZDIvc2RhMS04LzUxNjMNCj4+PiBNb2R1bGVzIGxpbmtlZCBpbjoNCj4+PiBD
UFU6IDAgVUlEOiAwIFBJRDogNTE2MyBDb21tOiBqYmQyL3NkYTEtOCBOb3QgdGFpbnRlZCBzeXpr
YWxsZXIgIzAgUFJFRU1QVChmdWxsKQ0KPj4+IEhhcmR3YXJlIG5hbWU6IEdvb2dsZSBHb29nbGUg
Q29tcHV0ZSBFbmdpbmUvR29vZ2xlIENvbXB1dGUgRW5naW5lLCBCSU9TIEdvb2dsZSAxMC8wMi8y
MDI1DQo+Pj4gUklQOiAwMDEwOl9fYmxrX2FkZF90cmFjZSsweDc5Yy8weDhkMCBrZXJuZWwvdHJh
Y2UvYmxrdHJhY2UuYzozNjcNCj4+PiBDb2RlOiBmZiA0ZCA4NSBlNCA3NSA0ZiBlOCA4MyAwZSBm
OCBmZiBlOSBmYiBmZCBmZiBmZiBlOCA3OSAwZSBmOCBmZiBlOSBlYyBmZCBmZiBmZiBlOCA2ZiAw
ZSBmOCBmZiBlOSBkOCBmZCBmZiBmZiBlOCA2NSAwZSBmOCBmZiA5MCA8MGY+IDBiIDkwIGU5IGNh
IGZkIGZmIGZmIGU4IDU3IDBlIGY4IGZmIDQ4IDhiIDdjIDI0IDMwIGU4IGNkIDUxIDAwDQo+Pj4g
UlNQOiAwMDE4OmZmZmZjOTAwMGU1NGY0NjAgRUZMQUdTOiAwMDAxMDI5Mw0KPj4+IFJBWDogZmZm
ZmZmZmY4MWM4MWI0YiBSQlg6IDAwMDAwMDAwMDAwMDAwMDEgUkNYOiBmZmZmODg4MDM0MWFiYzgw
DQo+Pj4gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDA5MDFlMDAwZiBSREk6IDAw
MDAwMDAwODAwMGZmZmYNCj4+PiBSQlA6IGZmZmZjOTAwMGU1NGY1NzggUjA4OiBmZmZmODg4MDM0
MWFiYzgwIFIwOTogMDAwMDAwMDAwMDAwMDAwOQ0KPj4+IFIxMDogMDAwMDAwMDAwMDAwMDAxMSBS
MTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiAwMDAwMDAwMDgwMDBmZmZmDQo+Pj4gUjEzOiBmZmZm
ODg4MDc1Yzg2MDgwIFIxNDogMDAwMDAwMDA5MDFlMDAwZiBSMTU6IDAwMDAwMDAwMDAwMDAwMDEN
Cj4+PiBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMClHUzpmZmZmODg4MTI1ZjIyMDAwKDAwMDAp
IGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4+PiBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAg
Q1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+Pj4gQ1IyOiAwMDAwNTU1NTc3NjI5ODA4IENSMzogMDAw
MDAwMDAwZGQzODAwMCBDUjQ6IDAwMDAwMDAwMDAzNTI2ZjANCj4+PiBDYWxsIFRyYWNlOg0KPj4+
ICAgIDxUQVNLPg0KPj4+ICAgIGJsa19hZGRfdHJhY2VfYmlvX3JlbWFwKzB4NGI4LzB4NTYwIGtl
cm5lbC90cmFjZS9ibGt0cmFjZS5jOjEyMDANCj4+PiAgICBfX2RvX3RyYWNlX2Jsb2NrX2Jpb19y
ZW1hcCBpbmNsdWRlL3RyYWNlL2V2ZW50cy9ibG9jay5oOjUyNiBbaW5saW5lXQ0KPj4+ICAgIHRy
YWNlX2Jsb2NrX2Jpb19yZW1hcCBpbmNsdWRlL3RyYWNlL2V2ZW50cy9ibG9jay5oOjUyNiBbaW5s
aW5lXQ0KPj4+ICAgIGJsa19wYXJ0aXRpb25fcmVtYXAgYmxvY2svYmxrLWNvcmUuYzo1ODUgW2lu
bGluZV0NCj4+PiAgICBzdWJtaXRfYmlvX25vYWNjdCsweDE4N2IvMHgxYjgwIGJsb2NrL2Jsay1j
b3JlLmM6ODA0DQo+Pj4gICAgam91cm5hbF9zdWJtaXRfY29tbWl0X3JlY29yZCsweDY2NS8weDhi
MCBmcy9qYmQyL2NvbW1pdC5jOjE1Ng0KPj4+ICAgIGpiZDJfam91cm5hbF9jb21taXRfdHJhbnNh
Y3Rpb24rMHgzNDU1LzB4NWEwMCBmcy9qYmQyL2NvbW1pdC5jOjg3NQ0KPj4+ICAgIGtqb3VybmFs
ZDIrMHgzY2YvMHg3NTAgZnMvamJkMi9qb3VybmFsLmM6MjAxDQo+Pj4gICAga3RocmVhZCsweDcx
MS8weDhhMCBrZXJuZWwva3RocmVhZC5jOjQ2Mw0KPj4+ICAgIHJldF9mcm9tX2ZvcmsrMHg0YmMv
MHg4NzAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYzoxNTgNCj4+PiAgICByZXRfZnJvbV9mb3Jr
X2FzbSsweDFhLzB4MzAgYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUzoyNDUNCj4+PiAgICA8L1RB
U0s+DQo+PiBBZGRpbmcgSm9oYW5uZXMuDQo+IFRoaXMgc2VlbXMgdG8gbWFrZSBXQVJOX09OX09O
Q0UoKSBnbyBhd2F5IGlmIHlvdSBmaW5kIHRoaXMgZml4IHVzZWZ1bA0KPiBJJ2xsIHNlbmQgYSBw
cm9wZXIgcGF0Y2ggOi0NCj4NCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS9ibGt0cmFjZS5j
IGIva2VybmVsL3RyYWNlL2Jsa3RyYWNlLmMNCj4gaW5kZXggNmFkMzgwN2E1YjczLi5iNDY2MmM1
NjM2YTYgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC90cmFjZS9ibGt0cmFjZS5jDQo+ICsrKyBiL2tl
cm5lbC90cmFjZS9ibGt0cmFjZS5jDQo+IEBAIC0zNjUsNyArMzY1LDcgQEAgc3RhdGljIHZvaWQg
X19ibGtfYWRkX3RyYWNlKHN0cnVjdCBibGtfdHJhY2UgKmJ0LA0KPiBzZWN0b3JfdCBzZWN0b3Is
IGludCBieXRlcywNCj4gICDCoCDCoCDCoCDCoCB9DQo+DQo+ICAgwqAgwqAgwqAgwqAgaWYgKFdB
Uk5fT05fT05DRShidC0+dmVyc2lvbiA9PSAxICYmDQo+IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAod2hhdCA+PiBCTEtfVENfU0hJRlQpID4gQkxLX1RDX0VORF9WMSkpDQo+ICvCoCDC
oCDCoCDCoCDCoCDCoCh3aGF0ID4+IEJMS19UQ19TSElGVCkgJiB+KCh1NjQpQkxLX1RDX0VORF9W
MSAqIDIgLSAxKSkpDQo+ICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuOw0KPg0KPiAg
IMKgIMKgIMKgIMKgIGlmIChjZ2lkKQ0KPg0KPiBhbHNvIHdvdWxkIHlvdSBwcmVmZXIgdGhpcyB0
byBiZSByYXRlbGltaXRlZCBwcmludCBvciBrZWVwIHdhcm5fb25fb25jZSgpDQo+IGFuZCBhZGQg
ZGVidWcgcHJpbnQgPw0KPg0KPiB3aGVuIEkgc2VudCB5b3UgdGhlIGNvZGUgZm9yIGJsa3RyYWNl
X2V4dCB0aGF0IGNvdmVyIGxldHRlciBoYXMgc29tZSB0ZXN0cywNCj4gbm90IGRlbWFuZGluZyBh
bnl0aGluZyBoZXJlIGJ1dCBpdCdkIG5pY2UgdG8gaGF2ZSB0aG9zZSBpbiB0aGUgYmxrdGVzdHMN
Cj4gZXNwZWNpYWxseSBmb3IgdGhlIFJFUV9PUF9aT05FWFhYLCBzbyB3ZSBhbGwgY2FuIHJ1biBy
ZWd1bGFybHkuDQo+DQo+IEVsc2UgSSdsbCBhZGQgdGhpcyB0byBteSBUT0RPIGZvciBibGt0ZXN0
cyBhbG9uZyB3aXRoIDE1IHRlc3RjYXNlcyBzaXR0aW5nDQo+IGluIG15IHByaXZhdGUgdHJlZSB0
byBnbyB1cHN0cmVhbS4NCj4NCj4gLWNrDQo+DQo+DQo+DQpMb29rcyBnb29kLCB0aGFua3MgQ2hh
aXRhbnlhDQoNCg==
