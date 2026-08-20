Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE23DA7F3
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221964; cv=fail; b=pOTrybFOzNE+SqkSlG1RMGI53x20DNBR0xOTTZGBc5F1Cc/FsTgvY/JQBnZIW79EtD7H7ZwfndxPApVWDCLVcSJC74UlrR3dvIfoJQOgVCqN7L5bKC1slvd7e3ZjnUlSASOZn8wCzfyuU288c+FZP9dMd9Wq2LGtXDJWJD3hCB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221964; c=relaxed/simple;
	bh=TQohKVWL4RvY5Lf6lqghV8IInoSPDDCozQG2gpXt5x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CAdTh0Q9dA0sdqUoV5OXiTOMBeSjtYBjBjoUt0QmRb3zBnQXAI/erw6dcbf3zcS1cIf/tUf1aW4UWi+ep6eH6nAMjvRJEBxdWq9yPgd+0z+ZP/qxGpDk1H1x9OZ5pcN0/LzCbN9/WQdhXQQJLxPJW1ZOovt732qt0au4JhNbQL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KElH/l4w; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ROXJiYT0; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KElH/l4w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ROXJiYT0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787221962; x=1818757962;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TQohKVWL4RvY5Lf6lqghV8IInoSPDDCozQG2gpXt5x8=;
  b=KElH/l4wE8wKpWBkbQwZ/BcHbCmAjVeHxOOOqGoA0XBd7f+qKhOeuDUK
   1QcS/JXAjznh5NJBUrsuN5a5CJdf2gpjJBA4XrIQgDvPqi1kKvpiWzlmQ
   oCl5YebwhKWUkHt+5yKwS0PVkcGFVI3QtTBiRulhGdi5hyTQwY0YGB5gO
   pAaKZkuMHFAW5kYAvIx+F2DGkHPE1LSU4ZPA+XniyWIZY34y0bHvgdB5E
   Ig8DHggeZCDD08WMa+7zRpETztlBVIshQw+9+eWjY3E7lwYZdr/mJaRBn
   W3l9jYWI/qhvjaciSnn9f26nqLSBnYMt7na8RxU9k+jGKTrcpIuaJ2xNm
   g==;
X-CSE-ConnectionGUID: rGyik/iKQoeCbRnfolRWcw==
X-CSE-MsgGUID: /r2p1xFpQW23yuCWpKNK9w==
X-IronPort-AV: E=Sophos;i="6.25,233,1779120000"; 
   d="scan'208";a="153682547"
Received: from mail-centralusazon11011023.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.23])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2026 18:32:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIm4NYdjzoIHavUwLFfQKVyVZosR+TfBnVyG1zxQ17kwj7G93cw3ftAxkDalGU3OBCRHVo31//CV9OqknukYZJdVA3Gka/zJp/EA+aj7pIAO5gVxyAJk+vWr9bqgizz/L/9VWkS03GLUbBI3YJmSBna6Mi3CRwrrxZtG0gQl5cEAhqIYpMhUT46/9N93IQf3cU+u30khRvrqVsTL55osk3a6VlqS7s15Djq5SpzW0dygwuu6LTPoldiKZsIP/EWuivm5YfCraybAznEFJl/1nh6uMYcmtRxTCK7L/Pu6Kp7yGSmbHQYfsuTdorv4ubFlLCP+QkVk590NfPzF0nrsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+Cs0y2N02h5i0/a3G0M7Yyxc7iVGsWugPKwQFz5kLo=;
 b=HxLRUKeqRR0l/aVYg4RKyklkzOKeF1ZHnAzWCcP9Xl+YYJPFVPukUx6c5qfQ5ztD7jRPZpIAtKxzVGW8Itvy1US5NX0T9t4tX+JDYpufAPNVxEBG6xfez1b8FC+77tj81OBWPyDp83+h/xis/lODp0w1bEH1+u4Q4fXMt97NNkJlCk7x+kGBiBFOauZuAnWANfl1Q3c3+V5HcWZTK4w409kxkEGkLn7+H0tGoUyWwlyPWzwWEut8j9+zBD4l3w0fh7XIQvUH61q4fgw8UNHJT8oXN12OVnaJFWRXqxdzwWtQLZL/sqO/6hB3/uVw885/CZkpgjbejQrsU/mwjULT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+Cs0y2N02h5i0/a3G0M7Yyxc7iVGsWugPKwQFz5kLo=;
 b=ROXJiYT0hD8zAXmrtKpoHZFNP3neI9FNkF7ipis78pqr27zSE5KhfBMdVWyIpOerGxWeVR8kVod94NI8vCdAPq32ZKCHggii1G3OlWT7YYjKsmoW19vRXOXswRRtB7aOEdKwFdWF/wdpqTB+NF2SNjiib44WxGAfFGmBoUqqoHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH0PR04MB10296.namprd04.prod.outlook.com
 (2603:10b6:510:110::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 10:32:32 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 10:32:32 +0000
Date: Thu, 20 Aug 2026 19:32:26 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: linux-block@vger.kernel.org, hch@lst.de, yukuai@kernel.org, 
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH blktests] tests/throtl: add a new test 009
Message-ID: <aobVOj_vlrqDkbcC@shinhome>
References: <20260813144041.1715866-1-cui.tao@linux.dev>
 <aoRRlY5AeMaRBXMh@shinhome>
 <8cd35439-66b6-4bc2-94bf-dd2dde47aad7@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cd35439-66b6-4bc2-94bf-dd2dde47aad7@linux.dev>
X-ClientProxiedBy: TY4P301CA0114.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH0PR04MB10296:EE_
X-MS-Office365-Filtering-Correlation-Id: 495b12b3-e686-4118-3575-08defea657ae
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|23010399003|10067099003|11063799006|56012099006|5023799004|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	d0dZtrwkf7KaoMuXv8tR50aRRxBkIs2YaRS+edJIx/EHhvtBVG5uSB/0nU95FpFvpOhMuw+NRHVDlVnxxhcYlEkN/GR5jDWErcbMecmgnhkBdAWpSp9gO1ElS2Aqa7iy8i61UlUL+2fUvo+CTadJ6971Q7kpkgHAMPw6FjOlWtqk4JFfCBJNqjdJgSbQ/pa6d6GQYXfvRVkrvI70Wg6FjAH0ELMX+1e8jcohYyQ1TEntfG9l3LQpuKDWGy+ZVBUDvnnEAGbCW9khuXb0g88LJJxod3o3AOU7NP2DpbANHEV+8fLSM6NiWCYqgaOmdeqKyeBKphu4kQjneJ+2l0/zxTDNj6hCBRe1IfMoMWy6+qoVU6u68QzC6YCmITwKNJm4bCDdHbIloF3Z9RhrW+PBHOJZDkcNZrF6koyP8QsXIGZTkV9bhBDJLt42EfPzlpriIrTa999jgeDyWtsTX91N2fkAUNZEbDpzv1M3NMVEpcF+ElY/AoJW9F3M/ob+OjeoAcL1UIsr1Uwy8ebUbCYAGaS+cenl2/VukGr5f6QAR5DoDQWLjrfd1bfRNDAz7Lu2Bn2rww+ibEtkKnmnvwwa88zA32a9Izebfs2EIFATz0zBtS17sg54C9qrtUOMuGm9LPXcLEpuv7uh2DtndYC8tCstfrKQFy9aa0fuIF2Lkn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(23010399003)(10067099003)(11063799006)(56012099006)(5023799004)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzdEajFMMmgrVDZuVnowdjNuNWM3UEw1QXdEOVRIYXVVWm5uU0ZuSEFYVEFR?=
 =?utf-8?B?U25ObDF5clVRQWZJc3lZdTBTWE5hVTd6cnhLTUcxYlpEV1RMUm1uNmIxTVJP?=
 =?utf-8?B?N2VUMExBUHMydTNINi9UWnNQdmJSS0hkM0VZT29wNkVUeHhGSW5ObmljeEV4?=
 =?utf-8?B?d0ZZL2liT3R2MXh5SENqR3ZWdU5GKy83alNSZE1HMTd5dFRHbTJycVZLa09y?=
 =?utf-8?B?VVp4OHBmZUtkbGxnRDVlS1dvSzFrRVh6aUsyejY2RExuM0duc0VMaGhuS2ov?=
 =?utf-8?B?VnZ6UDVGUGx2RlBpRHcwQURsUXFUaHdrY3IrS3FGTXNkUDY1cElVeHcwUk0r?=
 =?utf-8?B?YmUxZGpOaGEyTUVjNHJvd1owR0JjZ0hNM3JFREdFbEZIN2U0WTVWN3F2M3hS?=
 =?utf-8?B?UC9QY3EvMUMrQUxabUdLaWNaY0RibEt3VnFLZlV6ZlpBcUppZC9TZVpNejNM?=
 =?utf-8?B?d01GeHk5cEMvTjNhdWhTQ1c3anFUT0ROdDFtbk9GaGhQTFg5U3lEWmhxdjdt?=
 =?utf-8?B?TjFJZTVOTEE5VTdiSE9XMDYxZUhZRU5WK0VmaE5USEJxeERQL2M3aHdoQ05L?=
 =?utf-8?B?ejdITVp6c0wwbzhxdGFrVGVTQW5Nd0NmS21mUUtJSFVLTU1POXRiK1dGaXZ5?=
 =?utf-8?B?QnFJUVliMVdhTUcyaVdSQjZGUjUzNlVHS1V1Y3ZNSEs2dHZMT2ZMQi9kdmx1?=
 =?utf-8?B?WVkzZTNGVVVTRXVOSTV4YWlTek9meC83T3dSQzlVbEdJODBVZnRCb1VYbUlq?=
 =?utf-8?B?WHo0blllMDNhTlJWVlcrcWwwdkoxN1lEWU9ON0xQWGVLZGJ2TEpDRVZ5WEU5?=
 =?utf-8?B?d2l3VlB5RThtSkJ4N3VzdUtwSldyT0ZvT3BlSmFmTjUyY0JwREpDdUtMMXRU?=
 =?utf-8?B?RnFLREU1RE9GYWRyVWR1ZW5FWkNmRWpRUlVzWk82dVMvdGRuTEpscEZuTCtQ?=
 =?utf-8?B?YjZSRks3aE4yeUtGMDMyOGFZY1FBS25QK3JzZEhiZld3cjNhL1A0Slk3dSt6?=
 =?utf-8?B?Uk5BUDRsRHFlc09vNDVVRTFuZWpHdmRKOElaUDJSaXFJcWx0bXpvYVV6Y0NE?=
 =?utf-8?B?NVRhU2l2dkpzRHJWNFdIVzRyQSt3OWVpN080bzl1dVFsV0lYK0tqVXZPS0sw?=
 =?utf-8?B?WHByS3I3ZXVvaG5yZXJKRUZQZDhDblpGakhHRzJINjNmMWFpdGlSQ0pKK0xm?=
 =?utf-8?B?V0VLYXZ0MEVWaXQ1ekwzM1BRd3NUYVNmUjZVYlh0U1BJOHpBZSt1OG1vd2pH?=
 =?utf-8?B?RzVTd25RWEh4cDdDTVVTN1dYS1F5cjZWWWMyTFZDalY3L2VzUlU0d2lOOWlW?=
 =?utf-8?B?SnlrTEc2Qm9oeUo3RDRpQ2xWcnNNOEtIRTI4WndtODJPbTZlRGtIbjkyeENj?=
 =?utf-8?B?U25BNjZrb1laczhpVUVlRTk1cUZpS0NoWkVOL1NvZEpELzdhTXRkV1l4aC9L?=
 =?utf-8?B?Q20vWjZiMVYwLzRBYmtRRWhHYzAyVStYclhReGRKUXg3VUZibVdOdWR4ZDdq?=
 =?utf-8?B?UkM4ZUR1Zmg2RHFKZk9Ha2ptLzFnNmdic0cvR2drZ0lZS0dUUVp6YTI5Zklo?=
 =?utf-8?B?WE5nU3kxTksvVlFxV2FKemk1TXpxNWYyQXg3S0xtNURHakpjNlpqT215Wndw?=
 =?utf-8?B?eEk2MEo5ZkViN0JONUVkOWRWRk1od2JrN2xBZXc5SDBvK0lnSnVVMU5WUndX?=
 =?utf-8?B?UlhRM2FZNW1kMXlOcS9ISVNKTHZyc05wZVc4d3NXUDlOR3dxbzFEd1VrMnJD?=
 =?utf-8?B?ZTRLSEVtdytuN0prZ1JDdk13RXlnUE9aVzlHMGs3dlZybXN1clFLTVZyeDlz?=
 =?utf-8?B?d1NQWmRoK3QzaWo0TU5BcldUWGJndkdMd1gySk9tZklPcXVZRmFtcWtxajZX?=
 =?utf-8?B?SEplZTF5am5FcXIvTmYzcHlvbHBKWm1Bd3FubHJCWEd5a1JjdjdtNmJoRERv?=
 =?utf-8?B?YS90TnMrMmNDSDhxSUNOeFZkOXUxMDVZVitTU0c0aVFqMVdKdjlZbEZFZkVG?=
 =?utf-8?B?YVVQV2VDNS9hbzNERHRSRDh5ZDFnUHYwK0E3RmhTR3AzS1lTaHJSSXVBRXBU?=
 =?utf-8?B?MU1LZHVJMnhlUldLL0ZLa09BbGd0WHdRaS9YbXdQODRUK0dPTzVJMnRPQjJ2?=
 =?utf-8?B?UndXNytKdi8zZ1RiWU5nV051R3ljS3RSOUUwa3lVaklhZWhCNTdGcEZBdFph?=
 =?utf-8?B?R1pkcnhCSUJCWFJGbVV6VlNwMXUyKy9meFVaUVNYN1BnUVJaTTJ4N04wdHB3?=
 =?utf-8?B?UU41bGJEQWZwcWl5VDMwSldITTY1aVhETTFVeHpmWXVHQXdrUUhybDEweVIw?=
 =?utf-8?B?d3hNU2FYeWJzOUdYQklrb3VqK3JGLzNXTGlMNDZUWVVQKzVWNnM4b3ZQS0pn?=
 =?utf-8?Q?3jbHhyxJSzvPIRoE=3D?=
X-Exchange-RoutingPolicyChecked:
	FtwQd5zZq+L5XiV+H3oSSXQmb6iXFHKtJ/7ROao/D9xMRRDu9R7medG4SOEENycc2RA3mxQX8ee3aI2UKDUAFCRobZHWrtvvQjrYpZoOhrSDuo4QJbjViAezg1o/qlVh2VxOKrTQzp61bulZsAN0uyrSFZi8XT/eNOUGnBX142xvrKkSwo61G8BitajyI/iGvXyF1aIm+mG+V0iZaxh33uQ/UuuoFtrDp63TFr2lkkaZul6JvoZSQx9sOfMVLI6LG09ottXoaGTuWtT4fFhYuBR+MipKyrLSnezAGX1HcUE5Fj8CDIHze4vgma7ZI+chGnyxR2KusFe0pGbWTXoJCw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G8nmGmflxHPV88wn7yCE3iiRv7uLpWY76NB4pSfgCQ0tj4t+nPzXN35ZAJA7uU2puT7wZKsW/Gx0goO9Wlyn2GYf+5BXCXWg4LTkdhCajNlAAAtQmfocfSYkPsZyV9uHlgaWnepQ8bpiNWX4nLHd5hIciWs33a+b1XrxgRw96/HRez+6VqE8BpakA5zzTm3bHTPGwETKzroOfbSINCjOPdKui+HYR2AZTdipA+HJKt2MT2cS6roPQq6HjzdN5xb9zy3i3+Jf2W5IefBHD7tIo8aLLoLVQPBdEFYeZdZ9GISqJrCBMRQ5TU0ktpnksBNBF9kCzJP2x0cDm4CIkvwRMk4ifLSobJxLV/frkiOp4wIAQq2LjQtU3CY/3kpQ3RnkFrNbFJYTNLxVEBJjnng35ioiq1yF/sh6lXdLs2uYXZDdefDV7lsdJ2Q+KdZKWW6VMmj8eRfmYtBUcwglKCpOSN9wgEemLQ2AekCC9OCyzssyhDdta6Qe8XGIDHEOxUbMlhA7OxOH5pVNWxT2sqE2W1WubXDOTdhosuzI+zkiZg8U9jlpTsFBif2puoPf4bbfVcXUCQzeaq1FSA9S9xG7cU8blFcDUf08W3nR4urMIcE5tP4kg0rHkAX3hgJ7LU6q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495b12b3-e686-4118-3575-08defea657ae
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 10:32:32.3191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IinpfmIVVcDdI/hsyO4TKPNMz7kb2R0qmlsq+wYqa2Y4xw5HO2o9jvjht6VnyC57M18izj1lP0G/D6seoyYEqpe/zav2b8hwtEgLJ+3AwDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB10296

On Aug 20, 2026 / 16:43, Tao Cui wrote:
> 
> Hi Shin'ichiro,
> 
> 在 2026/8/18 20:42, Shin'ichiro Kawasaki 写道:
> > On Aug 13, 2026 / 22:40, Tao Cui wrote:
> >> From: Tao Cui <cuitao@kylinos.cn>
> >>
> >> Test the boundary condition of removing a cgroup while it still has IO
> >> queued in the blk-throttle queue.  The queued bios must be flushed through
> >> without any blk-cgroup or blk-throttle warning.
> >>
> >> The dmesg check matches any blk-cgroup / blk-throttle warning rather than a
> >> single call site, so it is not tied to one symbol.
> > 
> > Tao, thanks for the patch. Does this test case have corresponding kernel side
> > fix? I'm guessing that your recent kernel patch is the fix. If so, I suggest
> > to mention the kernel commit in here and the test case header comment below.
> > 
> 
> 
> Thanks for the review.
> 
> No.  Christoph asked me to add the reproducer to blktests in that RFC
> thread [1], that's how this patch came about.
> 
> The WARN it catches came from yukuai's "store blkcg in bio" RFC v1, which
> is not merged: bio_pinned_blkg() re-looked up a blkg that blkg_destroy()
> had already removed from the radix tree, while a queued throttled bio
> still pinned it.  RFC v2 fixed it with blkg_lookup_any(), and mainline
> passes this test too, since the blkg stays findable until queued bios
> drain.

I see, thanks for the clarification. I suggest to add a "Link:" tag to this
patch's commit message, to refer to the background discussion [*].

[*] https://lore.kernel.org/all/20260804133208.GB8078@lst.de/

> 
> >>
> >> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> >> ---
> >> See also the related blkcg "store blkcg in bio" RFC:
> >> https://lore.kernel.org/r/20260804065313.2092022-1-yukuai@kernel.org
> >>
> >>  tests/throtl/009     | 67 ++++++++++++++++++++++++++++++++++++++++++++
> >>  tests/throtl/009.out |  2 ++
> >>  2 files changed, 69 insertions(+)
> >>  create mode 100755 tests/throtl/009
> >>  create mode 100644 tests/throtl/009.out
> >>
> >> diff --git a/tests/throtl/009 b/tests/throtl/009
> >> new file mode 100755
> >> index 0000000..1f4ed67
> >> --- /dev/null
> >> +++ b/tests/throtl/009
> >> @@ -0,0 +1,67 @@
> >> +#!/bin/bash
> >> +# SPDX-License-Identifier: GPL-3.0+
> >> +# Copyright (C) 2026 Tao Cui <cuitao@kylinos.cn>
> >> +#
> >> +# Regression test for removing a cgroup while IO is still queued in the
> >> +# blk-throttle queue.  The queued bios must be flushed without any
> >> +# blk-cgroup or blk-throttle warning, and without leaking the blkg
> >> +# reference they pin.
> >> +
> >> +. tests/throtl/rc
> >> +
> >> +THROTL_BLKDEV_TYPES="nullb"
> > 
> > Is there any reason to run this test case only for nullb? If not, I suggest to
> > remove the line above to run it for both nullb and scsi_debug.
> 
> > Is there any reason to run this test case only for nullb?
> 
> The test just exercises the blk-throttle/blk-cgroup path on cgroup
> removal and doesn't depend on the device type, nullb is simply the most
> convenient.  Dropping THROTL_BLKDEV_TYPES is fine with me if you want
> scsi_debug covered too.

I see, thanks. The other tests cases in throtl group run for both nullb and
scsi_debug, so I suggest to do the same for this test case also for consistency.

Once there was a failure in throtl group that was observed only with scsi_debug.
IIRC, the test case does not depend on the device type, but the failure was
timing dependent and observed only with scsi_debug. Then, I think it is useful
to run the throtl test cases for both null_blk and scsi_debug in general.
