Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78384476076
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346491; cv=fail; b=BT5Bj6Xr+P64Wrftrcy/LkEkb9H7h7vo3yVAn0Mitj5bZmFdwNnVsiBXJ5vTYdcGYak8CT3q6BFEvs7diwpEZmDYcrNOuHDnJFmr9WC9HGttm8QHeWqsoydi5uUXH93NG80wgwFeexyKiezatLOZ0E45OgQN5mL06EDDPRhqXGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346491; c=relaxed/simple;
	bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I04WqMwDYfdGXS+pZr2ybcRYF85/PdnPVN0tZO9qjDPkUe46aoCSRO2sHPqqL/nLkqQWI+1KOHVndu5pFzjO1VQFFgE9EykQpLp1Dt4T8aAwI9cEZS2Rz9omoBY7hpnH8+ROLSaoa9nMEW4fgJBa80ov8dAzRa6DSTntlaTU840=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BQu/uJXa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HLMY0QbQ; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BQu/uJXa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HLMY0QbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1788346490; x=1819882490;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
  b=BQu/uJXaT8qFry3yYiYt4E5jS8ojGt3GpjwM4AkG0AMOMUW6I1xWkKzt
   3bYCW9rJIcyRIzwo79z6Pqb0FaXsNSF7pF9anjOEo4mUf4JdpofMGJaAN
   NQBnGZL4wpCRFMm4dFYzExNhdw63PGUD/N9taK7efmr5EbYSdP0cgjQwi
   iYPk0XSngU07SOQOPAQUAjkAu9JdeIX57m49iYe5vaHgImCb0fIVsbDea
   mQpSntxcokOdIj8mTp/Ucp/5ckdJsvUJtIGb5WG2WFkNj+T09CImU1D2G
   WUj0BZczOqNYZRtdFGhA4ueqgM93O3U32I5VZL39y3tz+N5LHoSZYJIAh
   w==;
X-CSE-ConnectionGUID: 1wMDRRhkRYWja8mBwqMUoQ==
X-CSE-MsgGUID: Bi5w6T7USsqM4bEY7yjJUw==
X-IronPort-AV: E=Sophos;i="6.25,257,1779120000"; 
   d="scan'208";a="155699307"
Received: from mail-southcentralusazon11013039.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.39])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2026 18:54:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8CKMS3bxNU4DrpWWO8kD8elBqQ0mUVUADHWGQDUyoXQdcX59akBTb3B84ssgsuqDUct+ve8q2J9QtNwddlpOrYeEyRLuoAJpdMSpru3Tp8Y/egBMFk/vih6KyfA7uEvgQfUqe+fc7RfI9fj2SJifTkFoGvQ9JB9NguUhIVyoz+OsyVeoCxapXRxTHmg5SrmonlRJKhn2Q+HRIqeqaKiONEh9OGgHl3DKozIXTSDksKCAgBEVl5S7R7vxKVAatSbTPvLlfDPlrdGLmRVLnTjfdjtnKc3hYXe10tOD7l5xf/QkgbuSpMcerDvU+Qg9YLRymFdvGTzaC261FVzLQCAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=LOQFexSt7V0FrjFliQEv5e0+RVAsczIx/Hr3smHDpqyDrvZSRj1Irzxw+c+4eM9syIPIEfFhnfvFrmZp7Yr14RpFecZb+6LpyCAcVuIbnGNaluOxF63Qcfq7VF0zi2TmHJRZwnGs+0S7mRs1RsjuD6H3Q4Sy0lxk2Skc/pCYUq58inyxv9FCtr1OwAvp+0yvYAxT+o4knqDijRg2E32lcRY0HlLaIccOwTwqZprsiC2jlIfZNu9EmfkYeYgER8mfy0iYk8WORlShqmpi/QKa1nm7m+IqyWN50rGqIieXmeEojbKtOrIJ2FyTRFx8yVhw8IQXRZfKYfAZxTRrmO/HiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=HLMY0QbQ16mbXAmFdMgaHdcI6QCucqJ6F7Ao/mQNFRugvvC/DiMHehvMDEgZ++VeQagleb1SpbxHh5QDuM/4qvYQyOVT4GTOvg0WSB/K8y/CR6E4XQfRveZAJJGeScx337X9vtJeTpe8IO5BLiza8QGUxBVyL3IgqSuOhiHLZjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by MW4PR04MB7331.namprd04.prod.outlook.com (2603:10b6:303:79::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 10:54:47 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 10:54:46 +0000
Message-ID: <f63b10bc-8562-48f2-b3bf-8f13bf93ae19@wdc.com>
Date: Wed, 2 Sep 2026 12:54:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/12] block: propagate readonly and offline conditions
 to zone write plugs
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260831034109.744039-1-dlemoal@kernel.org>
 <20260831034109.744039-9-dlemoal@kernel.org>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260831034109.744039-9-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::18) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|MW4PR04MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b13220-d0ac-450d-1e8b-08df08e09a64
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|10070799003|366016|23010399003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XilVaQcqWSXkR32H5NI9EcJEozAIJOI8uA1SBLgRQvpwwoZZ6RfLsdnfrz8V3R0PNOYXbzymYF5zILapRQRXvvfKQPKSPrTA+xiRpw7veW5CBuCgLirBssk/N8BKThCqAeyPfFS6USv24dsk54SBqym/KxSAzaXfKVIAPKtlcjXmuFy/n5vA5ksvMfn1Y8YiaBa1CJqHeCSfOhHSnLQxmfwfnKAtTjc/FlE93rF8eE1q3c7A+sl3QkBV91IhkcnxmlAW6VktXbj7L1WmtOfCz/eDx+fKHgxVco4zRlQDsUzBRX3JWpf2A2zf/+BgW4RJOdzD0xRYNG/3mWB2ONtqtVTWWCO7VjNSUlaKrqQG57rGpR6sLYGawD2MkSXOipsKeRUkQpwvoyxYYi2VHmWY/S3ssD+T1+2E1B72eByJdd1/FqRM/ulOR5/3891cilmFZ2pxjYwXRAETfc7tLhomcmCrUP66ghV1mDE40/xPkLcMFvJ+ebV+ex1D8pkUAJJTVjaURo2jodfSqT5iGvpfFRHnti9HcbdEWcEKTGwG1vo/HUSRlb38xu2PGv1JnCIO2hedYjpcYJWvrHtyOyCrQALVyX7HWoHLiVz/vMNia2RHDQ48so/K/l9m7xjC9IEdx4gyFMMtLVuMo1axaLIyivXsdF2Uy6NTic2hi4PmQXQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(10070799003)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUo5NjhFN0VQeFZNYmExeTlCNzBSRUdYMDRtWmZmOTFTNldSRkUyOVU4cjQ1?=
 =?utf-8?B?bzJoRmhtL2xrSDJqdjV1NWVkWURxcVdvQVVGd3lWakF2eG1NYUVNZWJVOC9L?=
 =?utf-8?B?alBPRGErS0VwSE04ZXFTdXV1OEFCaWl2WDloQ1A5emJYVzlseGNNdGxaazlT?=
 =?utf-8?B?aWVWcEJlcU5NRnN3a1Y0bVdRREpUc0lmTGgwK2tFVHhPbEh4ZFRWMFRkYmUw?=
 =?utf-8?B?bWVkRDJPY1dmZDlGVFFnbGpSbmNvSjg3aGdxUGQrSE1Rb0hKVmF0TTduTzZv?=
 =?utf-8?B?TjA5WGpZOVhSZEJsYnQrSkJOOW8rUDZmamZnTDVGbGx5eEdZUDNNa1pHVGZq?=
 =?utf-8?B?YVd6NUJvOXN6S2RxVGQ0OXZQLzNVbFlOcnhKUEM3SlFNMS9jU0EwQmduUWpy?=
 =?utf-8?B?ZFQ3NDIycVlNNDlGZmZUZUlmSURqR0FwZ1BBWTNaS0dWVHhPaVBLYjhzZFZR?=
 =?utf-8?B?SDNrU2VMcWRCbjYxY1NoTkFsWU9GRDI5QjE3S1UyNnA0QnFhdjhMWGVBOU8v?=
 =?utf-8?B?L2hUd1lJQXQyUjhXS285eFVsSFZFVm9PdUhjelZnZmw4ZWl5Q3ZiQTUxS2F5?=
 =?utf-8?B?RUx5Mm1GR0lTM0s5Z2YrdnpMZ0IzRXE0TVJTVHg2TE5DQTl6a29hRUJrdVVP?=
 =?utf-8?B?cE9OSTBHRG8zZ01KUmoyNWFtb2QvaUVBU0oraVJmVVZCU0F1Q1RQblZoeEc1?=
 =?utf-8?B?cExvZTNuU250RlVaL0Z3dyt1cHFEVERCbi9ETnp5SHVaUGROc3hwRWo4akQ4?=
 =?utf-8?B?R2hlSW4zZWppYkJ3a0h1SGF0YnlOUGhtVlNnSlRhY0ZEUm1EY1ZBSUtFQW5m?=
 =?utf-8?B?SzhSUXZGaVd2dCs0T1A1YU9QdmhjaGhnejZQOEZYbjZCOFM2MkZUd1BhNjJ2?=
 =?utf-8?B?NVVHWVFHWGw4THk5U3BlMGFEd25sMGNxL1ZMV2hMSkxrcW9jZnJLVmwzZUs4?=
 =?utf-8?B?SWdpdXRVamNZNVhJaFFHWEpVbm1vbzhwWkE2N2ZHZlFERHEzS2JURHdwNDBt?=
 =?utf-8?B?anlUNXgwMkdNbmNyaXUzUkZBenFKS0w5ell3RDlnTmNRemNyRGZERFMrOHhX?=
 =?utf-8?B?YmhEMExZUkN6a1A2ZjZJZ2pvTGtmMld6YzVrU3UxcGxPNXkrQjhPc05TMzha?=
 =?utf-8?B?WHJXdFY0bGFFTTdCK1hSU2FyVnB4ZXlQVThCVFFiMCtkSU5TeXJFdmdoOCtL?=
 =?utf-8?B?MWd1emszb3U0ck0xdEpuQTRxZ1pzbVUwQ3F3Q2R6T2ltck4rNjl3Q0VvcSt6?=
 =?utf-8?B?UkNsNlBDdXlIejVyWTNaYXE2d1hGU3VOem9HbytHOGxsRk5QVDN5VjQySnJE?=
 =?utf-8?B?bHE2VjUwNnZWMGNFM0c3c21FeGdVaTVGdXNtNUdZWmxuYlorbDk1T3dkQ2lE?=
 =?utf-8?B?M0Z1SU9XTnBIS2xGVXlDaGd3RDBZSldUdE9DUVFER2RwZ3RzaE80cG54eDNw?=
 =?utf-8?B?NXhSemY0NDYwZ0ZBck5UY1JwQmE0UE5QbjdkdWEwaW1CL05MbmFkTVRzSmNz?=
 =?utf-8?B?NUFnVjhYZ2gxTWxQbGVUQ203dXVnaHpjMW9QZUVxSXJSOHg0OGw4S2RqNGg5?=
 =?utf-8?B?VnMrdDBjaUVzakIrN3IrS210eTF1TkFIazNTdU84VTIyaTNyK3J0OWh5a2R1?=
 =?utf-8?B?Mk8rT25FdENCc2I4RWxkcHVoYlUzZFpYQnVBR3U5N2htN3R6RUJXZ2V6SjBL?=
 =?utf-8?B?TzU1QWgxaUU5MUp0RW01LzVRdFkrSjVFdURTbFAxMFdOWElaSzh2TEpRU0c3?=
 =?utf-8?B?TnR5N2hRdzZtaVk5UlZpRkk4TUE5bi9Ed3NvaXc0S2d6eU95clFyWnU1NTJ6?=
 =?utf-8?B?VjBzejFYN1Z3c3dDZWdRVFVRQXBBck9hamJjaDFidmx6N0NkYmpvYmlGMDZk?=
 =?utf-8?B?MW15NkJrVnc1cnZnNkVFdWUyQWN2eFRUS1d1c0N6MndoOC9wbkpxZUJnc1FV?=
 =?utf-8?B?aHVvTkpWNmNNc3ZUajRxTmRjS1FXOWc5QzRGWWYzck1yaXMrcUQ4TERhV1JC?=
 =?utf-8?B?VTl0NS9pMnNaNW1vSG9FMEQwOTM5QmZpNlBzckdYdGZjWFplTm84TDFDL2VG?=
 =?utf-8?B?cFRCTzgySGMvWmkxcGdKa2ozRlF1eEdGVldwRy9iVUpiWEkwZVhxTHFIM3hS?=
 =?utf-8?B?VUFuMXFYOVQvOTJUaUwvN0p3UXlITzhJOWtFVUthRkozcURINmw4L3JtRDhl?=
 =?utf-8?B?cjZBay9xTyt6SmlDdnA1bjlrV0xGU2VqSVBqTGlkYzMrMElSSkxYRGpBRzE0?=
 =?utf-8?B?bjFmcFpVUUw5OEpzMjFGYUdxU2ptWk96RXdBQityNk5pSllWN1NRL0Q0eGpk?=
 =?utf-8?B?YkhPN0lianVWQ29uQUhzeDZMVDQ0RFNnU01Janp6QnpXVDNScXBoNWlGY254?=
 =?utf-8?Q?PoTNsUihoul3FQ8jkKiHk/HJpxNQSLq9hlYl1M9krvSkZ?=
X-MS-Exchange-AntiSpam-MessageData-1: FDquAjvi6Ug0oFsUhmpznFr6e2WgDhpmCx8=
X-Exchange-RoutingPolicyChecked:
	xVydi12E8ilT5bAUhES/9coATTkLZCDwFHFaWiNUtBdVjlYBP7SmMKUzg1aqualh39rdAsELiJsNCGqOR4T1KTnS8iKQA4oq0OdH7IRCiRMuo8rJlUqlgNIT2KKGltNsE6GCX3p5npyXGIEjlhrZknh910WLZOFX16ZHKW05voT6a0KdX4X8Dj2MC4qnzLZFyDM9idNa8ZFWsxViUUo7TE/9zYh5wcaOretCXhuxOV3iLoYHJiD558w76Qdi7dcWNubmtFek2t24c4lVLSjVliy5jAI2+baMiwI+N/Et6kJMAFmGnXmMwrFrslFMmSp0jivk/ekRRVDc0LGk+S4DTA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xppruu1v/BZwDe84wQllnmfC7Tacxsw86jPDMsk4x5jV5SsL/o9s9ZjR9v8Wgaa0PMa+m5UixZIKdgVNXh+4UlDJ0jySLPzu4OKrrlqDTZ+4UzgYXQr91/CwdVR6ogku6m52jMgcpLA6oAEjAszpRqK4JQph3/a9jAhz9WmC8qUN923B0yCphBn55HyD9SDXvoXTvWKW66cw7H/sDmTcD6I/rROkMp6vOlmI/+CE2eQ+FPG8mvlhRIdpyjCS2gfSqFVFAYIwlZ07+hkMLQ5jS0hDahx1Qv6fwxPV2pSfj1JA/6gSSFDZdbYUk7lcjpTbFp5pTr+q04iJtlz4pATdQIndSzjjTevudyQvYtj7K3JeDLyv2hq9BPgw8EtX59iuSYV6D6+9+PYgxMS6ZxzM5IhyPzI4wNYsMLTqIJ/d5ub/10hhGbS0tglOK0PLCGsO2uS8Ek1In1l+MonOFBR5dK4wLVerJhN9+zaUc+GjQK7MQzppv4X8U2krA4SiZh1IUJYUZ0ZayCx35piwZyani5vYTMNMaT4eg5rJUadxSBI1SlhSBpfA1x8ycr/e54VLxlv5lG/2/k5XeC2W/KC9Dtwfr1MpsQLhT0OKQXeLUFZtae+FpPPHljwLCHR8imLd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b13220-d0ac-450d-1e8b-08df08e09a64
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:54:46.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/V48MSjPsatiIdtcywksbVd1Py2Dq6ZT9zBRczPQj4XGhL8nEM2sa6pTMKacxVSphhCcwS9abYL90UUvivfSdn508a5oMRz5+3LTftt66U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7331

Looks good,

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

