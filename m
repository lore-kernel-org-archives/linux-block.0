Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B4114B078;
	Thu,  4 Jul 2024 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093104; cv=fail; b=bhjanvFhDXcK0zNkCBDkd1zlxpUBtwx9+h1LAeocPBCtBOz5OsBjsGTO66/nRln62tEfVAt2pBcQRP73+KqpZtVzHL9I/ckJpuiSJfJIPeLJQXnKJOFhkx8p5fw54pTfANcPqs/q3o2lX6bk7J4dnIy/p7DpcvOn686XrglRHqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093104; c=relaxed/simple;
	bh=DP3NtCUaWaBvENk19cm0OOYcsDpBlJHfYuQ/Z9eMjn0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BrsWx1XO1KSREVnv7dOIRhi3zdfdp5TyIJo9EMvlHX9IO9qGRCTbUSAje9hLY0SE1ah2d/21s2nGp0TYKgsurMWborgKtHerMqVNh8y3HI1rHY56bElFd1QjIEWz0CuR4E19QxHN2y5uIiqZv6vnjjlU4QGkmjX3DNw5KznmE8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i937GvF+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i937GvF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720093103; x=1751629103;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DP3NtCUaWaBvENk19cm0OOYcsDpBlJHfYuQ/Z9eMjn0=;
  b=i937GvF+gU0bDccnymKYurM6pmBtSnkhzvBuiNfIIcAx763L8Q1zN8DT
   mslK0vJlm1CYzNB+jajmt9khRYHhWE/n8DAh2Qe1lPGLurcxpTb/3FnLy
   Srao/SgVAUi3z+/6DPDV5MwPAuoRKucuaslJgMkGfWzWBwkqpzNnXFFnX
   /66Ec7wCGLohA4H1BgS6pStCLZvipONGMCnM9EnDMe1TKWo/VLfvYjnLl
   0Yl1hdmXmtReeSXpwgdgpgTCeuvJO98U/LMr8F/ntfrTHR+nJrfZnpTFO
   CZu0yEe5NdWUDJ+nUhjV7uwGomLYDxgTmnJ9CSX4wI4fzJIjGyOipC3z3
   A==;
X-CSE-ConnectionGUID: lmuVq2zcQKynilTy9PVTBA==
X-CSE-MsgGUID: KyY/0cpFTCmCork3+K0g3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17496113"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17496113"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 04:38:22 -0700
X-CSE-ConnectionGUID: b38pS3BNRvuKCM0o3BnCTw==
X-CSE-MsgGUID: abaHsuz5Q6K2W3TCYAkVZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="84129156"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 04:38:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 04:38:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 04:38:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 04:38:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfJD46DuFRmqfUXk/MhCu5Rkv2k0szdnGtDCqZHd3St6gvbdv2aYn+pnsIMZKc8AzooVX+kZTeMs0VmhVoFvbRyjoTxoqLBc2gb7MgxvVZ5v4VGu9FtlLbBnLfQQZ4qEV7M8Vv+wK+ig9eB1r9ttuYYq14JNtjKTUU6cDnScMgSvbSa7zwvdC2faImrSpiofxFM6NR2JSB6hER4eru5t3shVlRlrtjfMO40nqgxQraXZCvkRGniZ/TPzfmoV90Ph8Uc5+YuBW1lpJSIhw//lEFcPZ8SrI+drFtzEoXbWMcOoZuxBY5mro3jddxHq8z55fzBJBngohvfoV+S0infaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxGgboELsfy0IpZisONJ+S7e3EZOvg5hNHdnwOsx2n4=;
 b=SLegHz7wOLLQfUKHhjeSRy+eaGwk7GWmNNn2geYequ3O59QHrzS5AWC8yGN7dJgwSSiuR247mWLyi3ZQHKOGyzblTvbKx8y4Tg3xn5A4fNwOIQBN/Q0rXQMiRRI93Nhw1ysEtkGI+T4ydKnFdEjk4+mdNDaJvRgKY7rZT/M9OtpdZ94Yu5jFu0AvgbFCNonbrBBoXU+P32rIQ26S959wOmUZxYv+pRB29AUCgV20+zsWnoe/TD2iTHeT/f80t7xVBEDFqgbb6il7SdpAOUBIfxRv9MaWIVK344ThUxpMttDQuaWeCYqR1EVfY57Wb0D7Z6MWfXfYhc75TycLhgjvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by SJ0PR11MB6743.namprd11.prod.outlook.com (2603:10b6:a03:47c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 11:38:18 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c%3]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 11:38:18 +0000
Message-ID: <27fb4f62-d656-449c-9f3c-5d0b61a88cca@intel.com>
Date: Thu, 4 Jul 2024 13:38:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] zram: Replace bit spinlocks with a spinlock_t.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Minchan Kim
	<minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, "Jens
 Axboe" <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>, Mike
 Galbraith <umgwanakikbuti@gmail.com>
References: <20240620153556.777272-1-bigeasy@linutronix.de>
 <20240620153556.777272-2-bigeasy@linutronix.de>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240620153556.777272-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0249.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::16) To CYXPR11MB8712.namprd11.prod.outlook.com
 (2603:10b6:930:df::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|SJ0PR11MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7ac6f2-164e-4c5f-4e6d-08dc9c1dcbb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEJheEFxdkx0RjJzWnV1dkNxcDJTaEIxQzRYdVF6R0plZEJtSHNtdm1Ba3Zl?=
 =?utf-8?B?Wjk5UHBYajFlTUxHQU8reTBrbklWbFFqYm5kMVpZbThvWUJwMTRDY1ZscWlL?=
 =?utf-8?B?K3hKUFU0eDBlSUErb1dmUjlQZVNuQS9TNC9HWElURElGUmY3SXVoMzVJdFVP?=
 =?utf-8?B?ckw2R0J6cDE4NWhScVpKcjdZcXYzQ3A5eEVQN2IzNVFhVUozaHJrcVAwYzl2?=
 =?utf-8?B?dFdoRXBRMkppZDc1QVN6ajV5OEZhU2UxeVRZa2U3NktlT2NLekt2TElxdCtt?=
 =?utf-8?B?WWdseGZudC9HSFFCS2loOCtFcWZHQnVQRUk2bXZsVlE2aUhHZHFPNjBraytW?=
 =?utf-8?B?eHExQUNhU2NlOENwakk3U3p1U1d0TGN0clZUY3ZXdE5ZUC9MNUgvQlhzb05t?=
 =?utf-8?B?ODR2OXV3OGNLckp3ZWh4TTgrNzVmZ1BIWm1leHFTRUtsaGFkeVVnMzhSblJG?=
 =?utf-8?B?dHQxamtQNExDamlORUNWTG82Mm51YW5HOG54aWdOTmZzaTZNUHVvOEZycVZ5?=
 =?utf-8?B?M2RCTGI2ejhPeGFSN29ScXV4WHJUeWRVblNkTnRvREZNVkZOR1hSTzAzbjZk?=
 =?utf-8?B?OXRiRU5uOGNXVmNIdmo2R1U1MGVpUHRSUUdkRldhckFqbUtyMTdHd0FaL2Rk?=
 =?utf-8?B?SVgvdVRxSXg4dU9XcWF0MUt2V2t3eXl4eHhpU2lneTRGZTByZHJTUWdMbjJS?=
 =?utf-8?B?ZW9mREZaV1BqWkxnVlBIQzhCajJjQU05cmhwbW11ZHRnRGFkNENNRVhHTVkz?=
 =?utf-8?B?bjlGU0lVUGJrdXdqbmFmU01maFFmSlRQdTh4d3EzenQ2SGhqMklQUENKRWZp?=
 =?utf-8?B?UWJuK2hyRUE5RjB5MnU5NEpqWUtWMkFLS1FBYS9jUDExWUNseEpkZGVBenJx?=
 =?utf-8?B?OWZNMjJuZjRsVjlIeVBWSU8yUkwyZnpFWVNQQzVHbVNuZEVUNzdpNW95OHU0?=
 =?utf-8?B?UzgwMTYxZnFIbnpmb3ZmSG1uOFdQVTFoc0ZrTlFySGxlSjZQZDUzV2Zpd3cw?=
 =?utf-8?B?dkdBcERjSHJUTVRGdUxLOHpFeGd4dmN2MXA4L1VVUmJLM2VrbzNjdEc1VEVz?=
 =?utf-8?B?L1FRTW1OOW9QOTVzd3VjQnA4VG02ZHV4RlJjd2wxT3RiaG9abEEwak9NbExr?=
 =?utf-8?B?Zi82aWkreDR5Q2U5S0pyKzJ3QVZSKytxUGxsb3NTQktkd3ozUmZaZFdrdUVI?=
 =?utf-8?B?akxBeUpoT3QzcWpYcVJVbG5Ba0pIS1cycEhnVzhaS0k3L3h0Tkp4QXFNN0lO?=
 =?utf-8?B?czRVQ1BQTEhGVmtrTjgwdklrVnRUZXc4S1gxQVkvVG5aUk9YUUNuYUowSGxS?=
 =?utf-8?B?Nk5sMlF0bW5DOXRwUnNaWCthRVlISFlOcTB5ZHhzdDIzdVZ3MmlnMjV2NWp1?=
 =?utf-8?B?WnNFcnB3NFFGMWpVSzlQV0ptemFGSXJNYTJtL3dLRXMzWXRUclpkUDBOUWJn?=
 =?utf-8?B?WktwNlFOUTJyY2tucVhjOUJuY0hHcHBucVVQNnAwR0prSFhybXVBeWpiVnBY?=
 =?utf-8?B?Z1pzczNTYVJXTFVYaWFYbXhmd1hFVEU4TUgzSG9JTUdOOFRZNGU3RHNQZTNp?=
 =?utf-8?B?OU55aUwybTNNTGFvdjduTTdzUWRZQS9QNzJtNzBSMkN6TVEvZ3FkTi8zaXhq?=
 =?utf-8?B?NENBYnJDc2JwZ2Ficzc2MXMwL0syWm1oYlpSYVZlQzZ5SWpqbVNnRUJWc2lX?=
 =?utf-8?B?djYvcVlLQjhqZjdxOW4yeXpjOG0rNHRsejF5dlhzL1ZxaXJGZlBvc2podzc1?=
 =?utf-8?B?amZmSkp6YlVSemhHcDFmbUJVVmlITk1xQ1pNRTRpYUVRVVEyMzQwUnNNSFAv?=
 =?utf-8?B?bXhVQVVEMDlxZ1dVZHd0QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTE3ME1CR2JEUkVqYXkwMU9XM2c3M2hSSkZSQkFQUklJdjBhdDZjVnBlazNQ?=
 =?utf-8?B?bTk2VjJQSnM2dXE0d0Q0dGlBSlBIWGpNeUV0c1VFays4UjFlK1p2dGRtd3pI?=
 =?utf-8?B?amNBWmkrVFRZRXlhY0dHUjBIbkpMS2JreU9YYlBXRzB3S2l1M1JEOTZqRGRR?=
 =?utf-8?B?eVhoSm55WFR3NXcyTXZQVENqVkwwdnZNVTlVNUdKemlObVMrc0gyTDBSei9T?=
 =?utf-8?B?Mzd0YnMwdU55T0VHRktseVpuaFIweTVQWlo3SXBnVGxsWXRKZklTQTZCMEZE?=
 =?utf-8?B?UXBhK2RBVWNRN3d3a1haempBZkNjQXVkbjlZUUl4S3BaYjFFeTRsSEc4L0x1?=
 =?utf-8?B?NnIvZW9DcmRFNk5LWXVGUnpJWnYwWUxteFR5MEVFQnVYUGxxR0l5RmlBdGR0?=
 =?utf-8?B?ZEgwR2RxU3BIL01QeG4zTk1qYlFSc3hBZFBtaC9mZTMvbm83aUpQNHpxelZl?=
 =?utf-8?B?MmR4T21wZ2NYRHA4aHFSQUR2Q24wY0RKWTBnbldiejlCNkQyRk1NTC9vek1q?=
 =?utf-8?B?ajFRdk1oQVg2aWVSV0RDK1RWWTZ2dXlwQzVKMG9USFhRN3pNZjQ2TUVDaHln?=
 =?utf-8?B?SUIrYjBPN2tsZXc4ejROb045dDNCS3pqME1XcCtsenFKUmpFYU9CaytiSlQ3?=
 =?utf-8?B?dkd5SWo0Sk5RaHhjTTZHbW9KL2cxbTN3UEx5cXF6SDhFakZlRitnYnlidUxX?=
 =?utf-8?B?SzFwMHpUMjZFaUxnaGdQdDVsNFpBWkR2NzJ0OGp6em1Oc29iaTJlN01HV0Jh?=
 =?utf-8?B?NVlJV3VYWHB0LzR3d2FSV2FRZ0lLMEpNeUhGZWVIYzR1NkdWL2FOVEhObExY?=
 =?utf-8?B?ZjBjaS9PNWExSU9ycWxhbjRPdHZMazRIYzdNaEI2TExna0ZXWTlZQldhRWVD?=
 =?utf-8?B?U1dhWmtTOVIwTVpKUE5LR2hOWGhIWHp0b04xVGJ1c0cweVU4ejE1RWpRbUlO?=
 =?utf-8?B?aUwvUE41MkNmSGFreXg2NmRxYkFQZHpCTFJidGR2WVQzMXB5VHJoanJzbWVF?=
 =?utf-8?B?TTkzU0luRE81TGpwWDlRZnc0YVdkaWxLSmhVVkI1dWVTd2Qra3U5ZmpQbTNO?=
 =?utf-8?B?VU1UNTdpNXYwZ3JmRExmSHBQcnRYbnc3V3JtU0FWVkpJak1QcWtTV1VlblJm?=
 =?utf-8?B?Tzl1MzNBWStadXZMeTkyTnNRMUZEc05tYmlrNHZEM3FPa1JSYkhBdDFtSWlm?=
 =?utf-8?B?OTEvNmkyYmREZmorbGtQdnpNT21jSVBKZ3JJSEE0Z0JKYjE0bmpnaGtQWFRJ?=
 =?utf-8?B?VE1RUzRtTUMvZDdZQzJTbkRNQWpTZm1vWmdQc2JsNWNING5TaXBVSTRGc3Zk?=
 =?utf-8?B?Q1RXbGs4LzY5MktTcVJGTkx2QUdKVlFibVFmWUxVR2kwWkpmcHFUYVVucXVC?=
 =?utf-8?B?RnRZaEtnMFJkQnhkQ2l4RFpxMkhHbjhYdGQrVmFKQnc1ZEMvNXhjTkJ1NzBk?=
 =?utf-8?B?eWRyU2tFVlVvWVFaaEE2dit4ODRQMlBxY1Y5c3FVd3BteVFjcjR4VU1YWExa?=
 =?utf-8?B?VXVjMVp2TWJmRzNydkl0RS9YcDJ4M1EzVGhyS2hqMTZzTEpPRXhkRVprRzJH?=
 =?utf-8?B?OE8zMitMZVNvRGlzT0dMY2MraEh1eERWeVlqU09Gb3ZheHB5R2h2NmwzcS9o?=
 =?utf-8?B?SzAzb21LVHJvM0lYTSsyOGhDTUI5ZTAybnBjZHFNS3QrRFdUdkI0dXVzaVRs?=
 =?utf-8?B?MmozdWlWV1hnNWZlMXBiMlFqU2s0UkQ1Y0xvTHRaazNVa2N2alNCZ0U3eHRX?=
 =?utf-8?B?VWYxeE0rZFBFWlc2cjJnWVlzTm5jUVZHQWR0cG9kakZEOFpnUzFNYS9RbU5W?=
 =?utf-8?B?Uzc0ZzgxRjVLL0RSU3k3dUU4ZnRNSm5RUkR5K0czZ0E3Wmpuek5tUkpINFB1?=
 =?utf-8?B?WnBxSXhvTzhYdWRxVU5yemxWRjJIUmo3TGVVZmdYUkhqcGlSWkxlSFFiOW5i?=
 =?utf-8?B?MGlicThGblY0SG11bHVkRTY4TnFYODdSeTMyVDJKeUtTUUdkVjJLU2VBVGtv?=
 =?utf-8?B?eVFNWkt0c2x6cWs5NzVzWHc3eUxZYWRacjBmS3d6ZzhJOVRTSFJSbHNCazJT?=
 =?utf-8?B?UGxsZzBwaXhaWURnVkxGTGY2bW5zcy9EeFZ5a3pJRUI5SHRMT1F2Z1Z1aFlv?=
 =?utf-8?B?VjIwa1NlbWpUTTdFbXR2VzcvdHp6ZWQra2E1WUJrc3o5dVRHWWtIMUFzWDBI?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7ac6f2-164e-4c5f-4e6d-08dc9c1dcbb9
X-MS-Exchange-CrossTenant-AuthSource: CYXPR11MB8712.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 11:38:18.7819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wT50szfXfIuT8giR4fL4kW+ePuaH0+ObTgUK/yccaAZAYiSOB5Nl9733MYWqtKkVKDa6g6mktENFJQkiRkn1pFLaUggMQXAhCCgH3Y0VshQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6743
X-OriginatorOrg: intel.com

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 20 Jun 2024 17:28:50 +0200

> From: Mike Galbraith <umgwanakikbuti@gmail.com>
> 
> The bit spinlock disables preemption. The spinlock_t lock becomes a sleeping
> lock on PREEMPT_RT and it can not be acquired in this context. In this locked
> section, zs_free() acquires a zs_pool::lock, and there is access to
> zram::wb_limit_lock.
> 
> Add a spinlock_t for locking. Keep the set/ clear ZRAM_LOCK bit after
> the lock has been acquired/ dropped. The size of struct zram_table_entry
> increases by 4 bytes due to lock and additional 4 bytes padding with
> CONFIG_ZRAM_TRACK_ENTRY_ACTIME enabled.
> 
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/block/zram/zram_drv.c | 22 +++++++++++++++++++---
>  drivers/block/zram/zram_drv.h |  1 +
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 3acd7006ad2cc..036845cd4f25e 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -57,19 +57,34 @@ static void zram_free_page(struct zram *zram, size_t index);
>  static int zram_read_page(struct zram *zram, struct page *page, u32 index,
>  			  struct bio *parent);
>  
> +static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages)
> +{
> +	size_t index;
> +
> +	for (index = 0; index < num_pages; index++)

Maybe declare @index right here?

> +		spin_lock_init(&zram->table[index].lock);
> +}

[...]

Thanks,
Olek
