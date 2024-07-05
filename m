Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC41442FD;
	Fri,  5 Jul 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180960; cv=fail; b=R4JbxLlcIQJIBUJT6MzI6j+/aYgTDbDBN7umfBOHu1rJw/nxBqjb1GPKdpc24OhdZB9VceSHV2eHFWdK60n4gZYd49hH/pAVGF3miWZEkIPe1lOVNEPYC1gjEnvvlTQ9tIGmcuyv+2GdYuH96U+0UmJYlotK1b+ff2bNldy3nbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180960; c=relaxed/simple;
	bh=Ti0rdEOBKZoUuWVmvwpJDR/9mTaI/tXjcOCoiAmS0A0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MLPjy4niRDj9QGxJfi7XyVIwYnUGu2Thpr7pE8bRyIMEhq3mUSfZULiAdIuuH64jZhoM+hTvi1r4NCXgA+LOm6X5RUWGWQc11USWd0InyFc+ojFUjpOziBlQP0wtz4vAYnEk0wMFh7kGvKkfbDh9w24um5M6UVoxFkb40Y5Suog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVlk3xVm; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVlk3xVm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720180958; x=1751716958;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ti0rdEOBKZoUuWVmvwpJDR/9mTaI/tXjcOCoiAmS0A0=;
  b=TVlk3xVmhiXK7w3mgxr/qDYP3I/MAm/9DxykcqzzvB0XywqIHQz9dyvz
   qjg1BxbrLSMcE30TpBR5mRzJ61k1lpWZGwVUJBngoVf80EH3+6SgkBlR9
   DccCSO4pRr54f0AmnkkCAwHG6l+5/U2bhmdcxMxcSZw+wVcDhOJCB/50D
   afgkwGb6zm20irPcsDblBSs+5W7zc9K3wXZxhd7rOUv0xgF4ntf2QFL1/
   GHlnor5DY5gtvv16YQdrZPbmduP4bcTLb6R1RySrWWlW3opEV1NJ4FNAm
   BfGzROOaf6p/G8L708MdQcst1+g6wQ8VfKijKePG4pGRV2RuiNb3ELZ85
   Q==;
X-CSE-ConnectionGUID: Nlu8D6ynR3GFYdaYqrgMXQ==
X-CSE-MsgGUID: weetobX6RSqfzsdWcXoTfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28871167"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="28871167"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 05:02:31 -0700
X-CSE-ConnectionGUID: 4K7SXYVmTAePjtQfAKSymA==
X-CSE-MsgGUID: zNlkvwsPTpChE43lnAY4BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="52043841"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 05:02:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 05:02:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 05:02:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 05:02:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 05:02:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya5xQ1un/eCVbfB/pGcLre6TQddn0o+NhFesfZU1Wugl7D2gPMWYzpu1oKtahA2ukby4sTs84B1cZ2QCtkhPh/yHwBxWYA6Jt5c5yYQbM32vhcX8X0oom/PbBJuO79bBPtBVh1I3R6DmZ03JPW0a5GxPeSRUKfLjVRkCcCbjdZqZFfE0cak1ktFXkfu58ekvqjQKAiHLwX8J1g2JaLUREzVRd5SGWqjIdy2LtyjqzAYEHTnpEeLH7NuGfvjC6b7qHoGg5PXDoWprN1NR81ep+4rcwaXYi1uIlVCuQYcHaSgs91J2kZMa2Pn00Yzh+KpdkEaR5EqnzfQPOZjOjx4XyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYOChaLjAKw0Ghc3GGqQDxAG+7S1znxoXn1bzyzn5ZQ=;
 b=RLzgLUdjT7exMoMQtDbh9aezVESGF8Zt3tMeJOsVDNpueo2SC1QiPcPaydBEXVOw2doJE/yfuu7uVEatQyZUakQAmrTM+EqvRX6SJH8te2v8kHh0aUJzcvQxIlxeODN3pD+RJIJsexKZ9/IjmevaxBar8GOas4VJCyF/xscaMjFCy0bWw8T6SRs6wObDYl5+xbiEUH1zyeVubgthL1hAHbOexD1JdO5cOLWsCn90AeEQ5OSuGW91uEsGAqRTrxs3VcBHkOt1IRZo1kB2KaXnVsqjNviDVsEBoli7C7GxSAfHcYFMVevol/nZvy5RaakC2/SS+shYVLqRd7OdX574ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 12:02:27 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 12:02:27 +0000
Message-ID: <801cac51-1bd3-4f79-8474-251a7a81ca08@intel.com>
Date: Fri, 5 Jul 2024 14:02:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] zram: Replace bit spinlocks with a spinlock_t.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Minchan Kim
	<minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, "Jens
 Axboe" <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>, "Mike
 Galbraith" <umgwanakikbuti@gmail.com>
References: <20240620153556.777272-1-bigeasy@linutronix.de>
 <20240620153556.777272-2-bigeasy@linutronix.de>
 <27fb4f62-d656-449c-9f3c-5d0b61a88cca@intel.com>
 <20240704121908.GjH4p40u@linutronix.de>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240704121908.GjH4p40u@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CO1PR11MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 586d3a78-5988-43cd-1f6e-08dc9cea56ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFBEUlQ0S2hvTFhJMUF6VTkrUFl1cG14a1ZuYmRXU0Q5YmRvSk9SS0lFZnh2?=
 =?utf-8?B?UG5QVEpUOUFobzhaeW1mRGx3NVd4K1loa1hPVGp3UTZoMzRKa1N0RFNQSmox?=
 =?utf-8?B?VTBVM3BrYm1OcXRUUWdpSnRlUjlOMUJHMXRWSk4rdW5KbXlJclVRbG9ycEpV?=
 =?utf-8?B?RDZ6TXE2VG9qbGhMYWNVazYzSm9NT3VxdjhjbzRGNjFudVliaUcweTRqRmZj?=
 =?utf-8?B?K2gydENHTndLbENSamVST0tRbk9ybjRxZzhPamtGalRsMGt3SktjaFZRd0xI?=
 =?utf-8?B?WFZNeHZVQU1SanJJV0xJdk4rODRMRUsrT3Y2VFpkS0RVSFVlMEZCemVGTmpy?=
 =?utf-8?B?ZDgraUp2RDhJQjFBQkk5aW95MW5sTVpwVVM1RTl5QmdRYyszUEJHbmN3cVBQ?=
 =?utf-8?B?aE4xZUY2dDByWkNDV3dFRmtKUE13R2NEQ3V6LzBRaU1IQlB1MWRTYkllQmNJ?=
 =?utf-8?B?aGo0UGV0UWNwVU02a3B6elgyejNXMlBoYjd2UFNtSHZpbXBuci9hcDZ5QUdx?=
 =?utf-8?B?cVVsVXp6dzZHa3BvUGM4OGZJenF3SC9LakJJdU81TStlZi9CcDMwckM3eUpH?=
 =?utf-8?B?NWF3US83MVRjTUpTd3pqczVsTWRqQlpWenFCcERjaUUwcHVIdEh1bk0zcTBE?=
 =?utf-8?B?WFp5eDBlNlhGeXkxMngrL3BZcWFjUHZvdDJMN0tieGVjaE53QU9NWFFHcDk1?=
 =?utf-8?B?enNzUFVycGl0UHl1b29laUdvdm5CUE9UOW1Za2JpOFphcW0rcytZUi9OZXJO?=
 =?utf-8?B?dk8rSGloSlJQY3Z1RnlSUWZYcDQ0SVU4TzB1eFZMVG1tZ2E3U0tUdGY2TURn?=
 =?utf-8?B?SEloSlpqUGpTdkxwSGpLbVZzNmp5TmZUSGtNNkZPRUFVTjA3ajZ3dGJVNU0z?=
 =?utf-8?B?ZjFpa3ZjWWY0OEt5eGozVEZvUHZWcVhYaDhub3o4OVpMRUdvU1VWcWw1aENx?=
 =?utf-8?B?RWMyczdYNzRtZGt1Y0hveStRaWs2OGYyb1gxZmtQUGxFb29UbzlZTnkzT2RQ?=
 =?utf-8?B?U3VTeHhnTEpBaHhMbkk3ejZCQUtZU1VmYWJ6NG9SYUovYWFSR1N1eElJcWxo?=
 =?utf-8?B?ZzB3eVBtNjJrbzl0VTZCZytOWHMrd2U1SFBhMUtROFltRkZyYjRXU2NIeVV2?=
 =?utf-8?B?enhRSEhRY2JLV2VqSFhEOVNzbDRhWjRrZTEvL2ZFMCt5cnY0K2EvZ3h4K3NB?=
 =?utf-8?B?SGVSRHFjZlNoekNLVUM5KzZ4R3V2OERGc2NBTkZYRlNYWEExU0lVUUZGNXo4?=
 =?utf-8?B?bms0ZG55UDlLakZMU3JQYTZLMVdxeVI3Mmx2QlJBQ09rOUVyTXY3cmc0Yi9v?=
 =?utf-8?B?cU5FTjZjNy9MRTI4WGRHdWFFUUQ0N0l3czZmM1NqZmcyY0I1cE52bHdjR3Nk?=
 =?utf-8?B?WkdSSklLdjJWN2ROZVhmZFkxR1VhajZtTkFEWlBwRzd5RGRuNlZLWXloTUZN?=
 =?utf-8?B?bUxiUk1FR3IwSjdraHRYL0tzakZwRGI4eVNRYUxJS1Z1Y1RPa2V2YWNjcENr?=
 =?utf-8?B?bHVBMWRyMmh3UEdLK2wxVWFWaFF6NlZqZldCcXFDU2lMR0p2NHlacERYVGJZ?=
 =?utf-8?B?K1E1UVdVSkU0bG1neDN6MUlnL05OVDNlcklGbURqaHN3b0hzbDlzZnB0aVRL?=
 =?utf-8?B?ZDUyTnNpUHg2UEl1WWdEN2pRME95WUxSRlRpVUhBR095dDB3Mk9ybkQ0cVM1?=
 =?utf-8?B?b1hZbm1uY0hkUTEzVExZZ0xhNEE0WkZsc2tQeGJJTHZZWkUzVEdhNzFlZm9Y?=
 =?utf-8?B?RWN2UER3VUhVd2JFYnZmMXpNVDhYeUl4aWVaU0hVZS9UOEF6VnJzQ256YWpB?=
 =?utf-8?B?Z1NBbVNnRGhYSnNmYzFxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXoreWRodlpmNERaUlE3NUN5UkhySEZHNzJFaEhwaHc1U0Z4VGd2MmNqNTky?=
 =?utf-8?B?UzhRYkhBdndhTHlHZ2N2d3ZPcEt0cU83UUZCeGFONmNXSTNCYW9CZDk4Y3A4?=
 =?utf-8?B?ZWYxVVkwdVg3cW1vaTV6UkN6aEFRaDYyakluNENlQncxbGhSbXArVUxkU3du?=
 =?utf-8?B?bGVkdlVJNXpsVU8zb2gwZWQyQWxtSmFndHI4WlZTUU1MdnZlWldmRU41UVht?=
 =?utf-8?B?VDNtZWJKSnVmcU9TNGlrR092MFlqTGxpYko5U3o1dHA3UUE3RlZkWTFLNnJv?=
 =?utf-8?B?TDVzek1UZ010NW9KVWZpdEkvallPUnlac3hoaFdUbkNicXFBNTFReTF2djVa?=
 =?utf-8?B?SkoyMGdIMGdQWEQwemJpSE1mSjNPZW5RWE13MmRmV2QwNFJxWTI3OGphSnli?=
 =?utf-8?B?dzlQWjhXUWxubDZRc1lyVnFqQ2d3ZUhUQndaSGFpSUNvZ3lvKzhnS1lLZVM3?=
 =?utf-8?B?aVlZaW95NkhuU1VqZ3ZmNW9KM04vd1VXcGtGUGRDMDY3VTJkRUZ0NnVSaUJS?=
 =?utf-8?B?ZXpXcTZhWVFmVkZMeEJEbFd4YVBzdGhEUFZhYWVJS1MxT2l1d0kxZmcxclNJ?=
 =?utf-8?B?ejVXanYzWWpMOURwRXZaWG5mODZwYVlseXZoZGtqUWlqdTJyNXp5d3ZFakhr?=
 =?utf-8?B?YzlSM1lCbVc5SkRDdHZUU0xzOEcvQ2dDa2JzVGM1TkZzZkNuQnVBMlNpYnNY?=
 =?utf-8?B?QzVLdEhNdUx4VjF5Yjc4OVYraGJQMDhSQ0lqMVhXcm1uMUl4cnBtNEhiY3R2?=
 =?utf-8?B?VUdEcXNjaitVZktpOGgybXREazlvSDg5amhTaC9nVmxlaWdoWFVPQmx3Rmo1?=
 =?utf-8?B?M1hpRVB2SVRFcmZxVUdQYWlrMXVqMml4T1d0US9iMmFRSUUyNXpablZ3N2hV?=
 =?utf-8?B?UnhRYmFTK1VhbVpYdlJlcEJSbUhMMTRnaWRnVmxrZC9kUENEUVcxdVdHS1I4?=
 =?utf-8?B?RlY4cTdYRVk2bGJDY0NHR0RHdkxQSkxlWlFxZ2V3SHp2MW1NRDVNbWNPSjVS?=
 =?utf-8?B?SVZlUWhMTDJ0R21SckpDNE9uV0VPbDZJejkyZTFKZWxSREZTNjBMVC9idU0v?=
 =?utf-8?B?UUI3UnBTZmVIZFhxZXFlRk5MWnpWcEhhSHVGdElDRU5YeHoxV3diNWtjb0Iz?=
 =?utf-8?B?WHBFV01SQVYzanhjT2tPOUNLSllBbmg2NGw4NEpiZS9aUUFNT0VSa3YxZnp6?=
 =?utf-8?B?eE9sOEkrb0twN0RtUyt2RW5rT1NTZCtrVGhHUTdvdUVLbkxYdHpyNWE2cVQ4?=
 =?utf-8?B?VmZSYk9WdHhnYjA4ZXd1ZVY1NUpMV3llK0RaRlhnRTAvODBtOFBqdTg2cjVZ?=
 =?utf-8?B?Y0tneTBieHNEalc4WkhVRDBjbmZ3L0JhemZCeklTSk9lUm1yWEtDKzllNWR1?=
 =?utf-8?B?K1RkVk5VaUEvOVFaUDBML1dZQy9nVWVXRU1DU2J2elNueVIxZncyOVZqcGgw?=
 =?utf-8?B?SUpKOXFFSmtsempGL0VFNFNIbXhlajl0b0NSTUppNHN0RkRkaVNUTHNXUnZh?=
 =?utf-8?B?SGxwYnBVNGdzT01RaFA4dnRJZVRLVU5tL0M4Q0dPd0JJcnJwb2ovRFE0RmxB?=
 =?utf-8?B?bmpOdERwSWxlWTM3RFpCS3FMSHg1T0NHSi9qblVxVnp2SW1vUFpIUVVLaEIr?=
 =?utf-8?B?RnhyL2IvNURnTlozL0dDcXlFVHFmNGNSRjNLOHFaeWljUmdzemRlemRldktU?=
 =?utf-8?B?UTBRYXdsazN2N1NFV01rNGpobnkvcEkranp1cFFLSTl4cFgvblNIUXNaWng3?=
 =?utf-8?B?TGpoSEw1VUhpT3cwMTJ4clBtZFBoSkJHSFRkWWVBNkgrMERpZ2lyeHllTExu?=
 =?utf-8?B?V2JjSnZGNkd6M3BUSmIvcllKQzMzTFBFR0ZpTkVzNDlhVmdQYnhldDEvZkRP?=
 =?utf-8?B?UENMVWtOd3ZuSUk1OG1XVXlxOG40VFJPVlp3ejQ4UVJ0OHdPYTdOcGdpNE9p?=
 =?utf-8?B?UDBFQUR6YzA4em0xS1ZxRFNrdTdLMVZYcGVEZkVpOVc2RVplMk1TY1N3bE9T?=
 =?utf-8?B?ZFRzNUo3YkpZM2t4VFBnM09hMHpuYm5UOVJGTGljeE11UEo0L3lDbEdldUpz?=
 =?utf-8?B?Sjdpb0swaEdKT2RJT3hKZ2ZFVFlBeDIxajc3Szk1UlJzQTBvYWhnNlQ2Tmcz?=
 =?utf-8?B?RVZ3VHp5UjRidFEvdjdYL2wwSmlXUzJ0VkpTcElCbzVMTFhZaU5DYnBsSmJz?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 586d3a78-5988-43cd-1f6e-08dc9cea56ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 12:02:27.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRbmAuKKlHTJHSwIJ7vOnYmE1UwK4i74Xfm5jHJAUxNYaFNEwbPu8iC1qYU5FZ8sLyY4g/eBKVOUfkrl/CqgdvO4MGb82IVuHKdpiEhy02M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
X-OriginatorOrg: intel.com

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 4 Jul 2024 14:19:08 +0200

> On 2024-07-04 13:38:04 [+0200], Alexander Lobakin wrote:
>>> index 3acd7006ad2cc..036845cd4f25e 100644
>>> --- a/drivers/block/zram/zram_drv.c
>>> +++ b/drivers/block/zram/zram_drv.c
>>> @@ -57,19 +57,34 @@ static void zram_free_page(struct zram *zram, size_t index);
>>>  static int zram_read_page(struct zram *zram, struct page *page, u32 index,
>>>  			  struct bio *parent);
>>>  
>>> +static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages)
>>> +{
>>> +	size_t index;
>>> +
>>> +	for (index = 0; index < num_pages; index++)
>>
>> Maybe declare @index right here?
> 
> But why? Declarations at the top followed by code. 

I meant

	for (size_t index = 0; index < num_pages; index++)

It's allowed and even recommended for a couple years already.

> 
>>
>>> +		spin_lock_init(&zram->table[index].lock);
>>> +}
>>
>> [...]
>>
>> Thanks,
>> Olek
> 
> Sebastian

Thanks,
Olek
