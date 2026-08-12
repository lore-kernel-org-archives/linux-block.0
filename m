Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C476423A9A
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530288; cv=fail; b=mB6uPyZmFpzx3GJHUdwk3QkdWw1n4fEPI0pDCZ9qZfI5IQIucf2PgkKtKHYHc1lumSwNOWsD4xTR8lNHPKkDUOjtzhWul8mycYNPosZ+4wvWMU5CkQnEG7dCBg27dCkUtwGaREc6YVbwImaywkZvv4qx3tQu9aIWnrL6BAAuM5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530288; c=relaxed/simple;
	bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i5xBF2LrIGLJ1oVC0OV3ukRmNKIe8Ow7CD7AezphucBg24niQ4fTWxAkNy1C0r1wp61rUp6/Itq1wdjHHfaO01IjHXc5BjSbEphvb57jLnltUtzFc+ByIU3Ou5rKw/8qVGYJ5EHZRFYeyb+udS/YFkOtJxO7O8uMe/kGRii6OfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=J5Yd6gUZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lZBPcvxA; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J5Yd6gUZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lZBPcvxA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786530287; x=1818066287;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
  b=J5Yd6gUZK0t/6dGxKUgR22wXTnMlPfQq1bAUMWJrqGy4TphmbAI02p0l
   Tc0Eg7iKN2TmXKPGAQM9BdwL/b8SFmqEHlVZh8aO05v95G/edtI2aYuHs
   Po62WH67Icq/I4op6t9k/M7laBlQU9CQm3EqNfg0c7/lMmMbqj6fI5m7X
   S4/kDrn2hS2vWJnZbSCxcRf9FPfN+sZ3NkDpFqoZBi77phUOqq1qjD0d3
   EvOfPg0+WnBdwVFJKWKm9c57wRnmtzMDfItHwcgxsJ6L6nm4ZZPCLeJ2i
   u/g+vEoCxSMlOE4lrzPUMrYOqW1sVjxUfP/2Q+6DHjYp5cZ+jeY4nQ3IH
   A==;
X-CSE-ConnectionGUID: SEt/d4LPTl65dTTmO/gqvg==
X-CSE-MsgGUID: UvgH7iLeRJmwICxCd/5M5g==
X-IronPort-AV: E=Sophos;i="6.25,219,1779120000"; 
   d="scan'208";a="152038617"
Received: from mail-eastusazon11011064.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.64])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2026 18:24:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6t9nsX+LTVPrwflGIhlnI0XUK66v6I/6z+xApRLbdBKknS4+fjvXSfqR90vpbddInZWn20aCNRlc+lNGiXeEhF7a1x1ZSGXygy/e6afiZD8w6pqgVK50PQ1WBc5E/rqRJTEg2yKG7Yui6qymsaeRrdEflEVhW0Vp2/xdkqaEHTPuf3DW8EAvoRmRpDNq/CSPLIYXnI9wvvL+P+5fRlMWkgdhT9dT8MLz8YfjAwS/q5VX06VR9xeKnoyAragnDXT4PygR2/wAuyuXN+WuNJmeWSl3AxUH0nSS/fsqcxTUW40GZNKwHTNln94Pq4b78/wve5txFxuh89mzO2t60+auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=xQ0s0w+CJey49ihl/J80GT5efD4DHQM2Aq1GpgatXRuPkAPzrrPWA2+rrpexNmjSavRMaGQ9aPZ/41XF50mWUVCT+Z9VkayYGl/siIwIwgjPlTEFxCGncbr1yoBx85tpdfdD2qWr15Eb1LEBdNILewdHVD10nwneItgnESZur2f4hSd99RIoydqm4DRxFbFsKDET4vyfasN7ptiEhtWnGYB+3drpP3sN1JKMPGi7G4DtQ6jRmfqGKLWowJKgLVRlbJC6L0hwnzgmI7mXcEa2QswxKvRlwg+ukiF28y8GUNkHkUdMpD/R1XNKD77sgq1CDRjQygvaY2qtOU7tmzlHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=lZBPcvxABaD2YbMG4JNqxgdMev8A9q+eAg5mXkOJYCtlBq76LFTfN2A/Riu2Nd4NP81/fPqjayp7JR6PKZBbJxnlus1RWK3KDk8/MWOfI7gsSE0R2+y0PqeSZo3si+tsIHdaYsPrILjvxuT25myM07sry+PJxyjHlgZR+4fwr3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by PH7PR04MB8633.namprd04.prod.outlook.com (2603:10b6:510:245::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 10:24:43 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 10:24:43 +0000
Message-ID: <3786b0ec-7f63-4af9-b08b-30930fab3893@wdc.com>
Date: Wed, 12 Aug 2026 12:24:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] block: refactor bdev_zone_is_seq()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-6-dlemoal@kernel.org>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260811105852.1245357-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0413.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::14) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|PH7PR04MB8633:EE_
X-MS-Office365-Filtering-Correlation-Id: 645d6eea-28a9-4296-5f6b-08def85beca6
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|19092799006|376014|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	bdYvRUsrGho3L5HlQL2BKKgsm0HW7M2SUOjz7Q3XCr4eB/bwwaRHax9hz9dZZxKiFnhcJ4PuVU7tml8HZKuRZePMVu4yOim3XevClVHJ99q3e6Z52/NzGM/m69Mk6Hve/OTF9psJLP81VAgb1xfNe/qtXYX16IEMd9IR9hovY8I+Tq51I+jtFtbYDHXeWmn3gXiHWSpwvmY8/nuC/h/X82FcQyrK6ppZtkYLvgOCu/O4p+SF1Xm7FrQ/w//3sPIz6gPxr1xAFPXNE81M70ew3IDd0Ajf9tGRp8jvL+1L1CAgbgKfeWNsZBU0ViRmAHuDHouD+Cjb7+ukIvYit1D8p8AEL6Vnxn3o+F4i36zkiaAxg0aQgMtrPeWh5whnOSiAiqAzA+uUzoasvoANUOW/8JgTFB0mvbI6BqbtYcQVDoDmZ89KQ8SYkjsXszJthdDKUAYL+oIYvzBAD3gbXnGpn58v2TOiTg0HXN02thbCSZ+siPf19zQBAre0uOwHCyd3ciYnozmWeyWQwM0KbSVsKJ6Pludx7ztY2WURehqYeR3UsbVhy7bgjhfxIOkDEvSG7fB/25Z9KA8zAJMianlGjlQ9Hdwhk3HbEx/hasCmbZfLq5AtZzfbH4uHT3Akktmo+BzJXUKSrxJGMOejncM1accsKmYO7CT3ZD8KrkGzYOw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW92MjB6T3NLeGNQbFF2d05IK0I0OG1YUzRiODJrSWl3Smd1Q0NTSkdsRUlk?=
 =?utf-8?B?UEZremo4NnRqRitjWE93Nzk4NWQycENsK056QkdJTDUydUp3ajNFM3R2ckJ5?=
 =?utf-8?B?TlFyT0Rsd2E0NDNQbldnTWtoTS9TV2NUWlk4ckNYeDhoMUFrNk5MN3BCdVJk?=
 =?utf-8?B?MjZSeXdUeTVGNHVEaFM4aEwyYTJXU2NVSWNFWEU3aVdWMS84M2htZ2U0NG1k?=
 =?utf-8?B?TitUQjQwUmNzcDVqeHhHekVmYnh3c1l3bzhjaE5XM2xpbmxnTm5XbmM5WkI1?=
 =?utf-8?B?RE9mWnhBMUdaRUcwWndqQkdIdm1PdmhhM3FEWHo2OHRvMGRTcW9oR2kzdDJo?=
 =?utf-8?B?QXpYT1JiVlg0NDFOM2p5MTkrU04rdHVoSzk0ek9hamZpRGlsTDdoalVKeTh4?=
 =?utf-8?B?Ti83cmx3UjJyN2FOU0QrUGVTa1c5S2owZktGdDZRMkNRa1F6OUpUVXNTK1kz?=
 =?utf-8?B?ZEVMS3FkbjUxQVo3TS9kbjB4cTI3Mm54eHppeXFnVnRsLys2RzUyWXNHYUt3?=
 =?utf-8?B?dU5ldEJXVEd6SXpkaEtvRTZGc29aNTk3TFU1VFVGdmNqTGFsNlhZQThyR0gv?=
 =?utf-8?B?ZFV3MG1uWEFwOHFDUmpabWFEbzBjdzl1WlQwVXAySGx5c1pBTGFNak15TC9O?=
 =?utf-8?B?MFBGUlVURG9qVERrWlcvaXl4QjA2Q29RM05jeWo1MlJueGw3d2xGeGN3R0RG?=
 =?utf-8?B?cHlYUGR0ZHloWDJhWjRLcTJET3FrZVZicWRPTFZKK0JyV1czV0pFUGpNM1h1?=
 =?utf-8?B?cURTUEc2VDdXY3pOMG9VWExXMjZQQjlpNGIvRnBjdk9pdC9aTWV0R0lOMUNq?=
 =?utf-8?B?RTR1TDVKZmVDNDJzRnJQRlk2ejFYMEhIVlRuTzJEeHBnLyt1ZDB6Ly9md1Bm?=
 =?utf-8?B?d0JwSGNOa0p4U1hVNGt3RE01S0FQYzloTW83VFdYNktjUmJFQVNwekdvTXFO?=
 =?utf-8?B?ajExRHYwOGgrTnNCWW1aYjY5YlExK0pxUGFPUUxQRklxS1N4eUlwYkt2RkJu?=
 =?utf-8?B?Ykcwa1l2bVJ4ZzFVWmhKK2NUanpHTDVxWjhMNy9CQXJLMGJpNEVpU1JJWG1y?=
 =?utf-8?B?aW43Vkl4NGZMck94TldlTi9HUXFucElNNStVeXdVZDlIbXZIR2Y4TCtDOERq?=
 =?utf-8?B?MnF6N1FuYzBFaEgxUmJaVUVhczRKZ0REaFdsMThybGRTWU5nTFROVWQwTWhH?=
 =?utf-8?B?V3EwYUNxNlVqUnBwY2gwNlFCTUxHQmRLRGx2MkdaZGpoTFFTdEJkMGRmZzlJ?=
 =?utf-8?B?bmkrMFBoOStyWVFOMUEzMmJhajl4SFh1ZGJJd2FveGljV0t5VElGTU5iTFhX?=
 =?utf-8?B?d3BGLzA4d0tjT3R6VG9NWVNhd1c5bG9pc3RJekVYa2FPUWhyKzcvOEgzUDhp?=
 =?utf-8?B?ckxlckZYNmkrbDBPa3dzL2Rkc0JZR3RXa2U5OGRrRGFjT25hOUVnNlh6bWZP?=
 =?utf-8?B?UzRsZFhQTnFERG8vWm5USmZaOHpqdEdxand5citFOVZibkVmZVhteXU4UXU0?=
 =?utf-8?B?VitWeXVRVG5uRU1obkthQWkzOFZ5YVplVjRZMmpDNnVnOGtVdWlmOG5OeTJo?=
 =?utf-8?B?VkFmaHR3TVo3YTBMbjNjc0NlME16NTB1SkJEZVVxZ3hJMi9LZWFWcjJkMlpi?=
 =?utf-8?B?dEFzNk9xMHpqQzMzU05EZXNxUHpuMXhzU3lzdkowb1hVM1BpMkh0YjZQQVFH?=
 =?utf-8?B?NzhBOVBtNlNCK3lTZDVaMXVKZEQ4Qi9LelBVeTRBVCtiL00vNUdoYm1YTmFt?=
 =?utf-8?B?cVdzNXVVMkVDRE4rUzdVWmZjK1FkTnRrSzQ0Wm5tRFlDWnFldlBxcjB0R1R6?=
 =?utf-8?B?U084YmtMOFNoa2pLaFNZajNEZjF2YVRTdnlOQkh5di9pR08zV0xsUkc4VFdI?=
 =?utf-8?B?YUVBSEtpNnZTQ29pNkRNREJrTFNBZDUwMmVNTVlrdWtnTEFqZ3N4TGJuenQ1?=
 =?utf-8?B?N0N4VlM0NHMwc1BnaEUzaUU5V2VZV09DdDNvZE4wL2ptaW5ZaTlvcEdNamgx?=
 =?utf-8?B?N21QSHRBZlR5NjNIS3hNVElEc1hXTk5tSlBidjI2SDI5MDhUVzk4bWZIdnhV?=
 =?utf-8?B?RGxnRG4vVTJmTTZrRUtCbEpybzZ5NG5YNHh0MzhlY2tybmhHTXZHaGs2V3pF?=
 =?utf-8?B?TWZiYUNuenpTVHFpQ21RMHpnOFR5UjZvYzZzc2U3VlFsSWRLV3lIYnlReUJ6?=
 =?utf-8?B?azVyY0hkQm1hRlRFMGRHK0VnNXhVcDB3WXJIMEI4UXRvUTBreTExTnhpTmpu?=
 =?utf-8?B?MGNrY3l4Zjd2c2o5QU1xQUViVG10dmpSYUR3a0hDMjR4NStaeUljanBwQ21H?=
 =?utf-8?B?dlpabTBpWTRhKzQ4ellwWVVpQW82YmRyKzhyWEdSZ1JnWEZ0RXIremRtbzE3?=
 =?utf-8?Q?3H/L9SuY7sVTS+Lzzhnir3Bdk27k5bz+30UtwGzX8khTU?=
X-MS-Exchange-AntiSpam-MessageData-1: UROrHnNc40kxd94zF2vK+FeDgVhHcScesn0=
X-Exchange-RoutingPolicyChecked:
	Jm9BSC1VkY3jjcPDk9VLIF7Rys67DVV0o9DOXOfHZqQo0TqH9W0Nf7F6t517uW44Pj+Wx4to0wtOguX7J7wtL/dnjtk0h9sQRn5nwFePQRwKF9BhDPb85Zcc/i056xzUzDybOjFTZRO7RDjTawT50OW+bks0y+Pnfcw0XYGtXNxcB0zmE2uwN4AufIsSOzZuDfWThWLG+lAvt46t0tPh/om6b8xSZ3sR/uY5InZwsQgVzUszAyxONKU0/1Ru8WvqbSlVsNOaRdAwvYLac5evl+7ujlVhVAz6hfza73qqZ0k1VuzvGHeOCKFEe2AL6GjAB3PE9fa5KG87mAK/Ecy4wQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T9kykxe1M3jv5z8QExPzgxcWqmdcm54Wb3B0e1IXOV9pEYsa1qbENPqfwiqAf0vx9C/3+iwNRQT1wMBqdYOpaLFhx66wDlBkCzwtR/JmLuE8vRZfN2kZzoLoPFyYj33PEH+cuflLUVCR3EPyoCK//1nBygQOhk54GcH/OI5INY5Av0UZUc/CYIANsiN+tgtfM2h+pISgzfLRGu6TZG/227Erk8iYAULYY+TZtXlrLu77zOVkNUkmL3u6N3gVZkrfV0/bKlZH/vZtlqcyEobZv1OLrH4j9aZp5YDDX8YSGkh6hH4dz2Yb+8lUyX7kmvl+hBVLe6ROLW5Pjj2bGTZQw0jDlsJgiU96qApwjVwpQwGX6GCPt2ZRM9tXec/eA88Eah4vX7BeOnu1aKnxWTU2hG+XdQ5ZtJax2i2KUiHgw87xioO/QUldyT3kfVKy7jFP6WVAOhBeRtFO7KHFyCq/cFKyLdbJVBqVHHIazl76b+tYSR7yvIxWIEfuFHmAZgaGTZ24CaDUr+uWkiSugVd4JZYXV1ASMvf+cdwlStzfwMR3XYso0yibjs7ZMouGZUIrtcw0pgJYUeFrUv+0lnvixcl7pyyBoDQ/SIJ64402+I1H/d2FL9PbKAc9QwfTB0R2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645d6eea-28a9-4296-5f6b-08def85beca6
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 10:24:43.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMz79q4fD7S7xadsLEVSWRXi3oGH5yZpxcjVxMrbgZ0x2kFJBhmFtZnxyWJ/HEmqSmL4RWegQ7N/vJY4U9ac2L30bEKs4jKAR4H6qTPR+xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8633

Looks good,

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>




