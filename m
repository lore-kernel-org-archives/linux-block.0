Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46981EEA5F
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767100863; cv=fail; b=Pgtt7hlA2wZOojCjUoPiLXs7vp47xyvzE7+DPYNcM2eMvoo7JPChojicsjno68VFEj7FD9/SMgUB+1K4VOTE0SaM6vTYxXaTuprrlYvdQK9y1eycJwpnQltbXzPvzhttafB1xbDeq/RINiAaKvzOHK3KLqBWwo7vbu0F3mhbyWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767100863; c=relaxed/simple;
	bh=cO1F0AoPo6EpxT7E+XMEalGTV2WqMByjxi9NNT0abPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JhIRxlLthi/MfM6/8LG0qKgr4RiUEA36lF7c8kp4XEqCvCc8h5VjNKHeXAc2A/jLshBm3m8C9v/JYha21ibbhhAeVZO+YbhK4+fhoA9EtZrEvCxr8BL04UVJWv1bqmTm1XoWylKnRyOACCkqNGJ+uloQew6tlQPwgcvfLozSOl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YTUrOpVM; arc=fail smtp.client-ip=40.93.195.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YTUrOpVM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw1lPrX5hHw4J+UeQcvkig3/L0bLVq9r0zZNE/kXfp3l+Trofo90laU9ykRtfJQxhQt+C56lC2/qJKziPecuMD0fXgzgZveloIM9RU7wOj2ysPXHKk0SDDwegc75H6/7t2Vs4B4z+UGbo82oZirHMoMWhjj2BLsaXqy/X8yNpShY8Jvo+/tmD5KlnmoqnRlA+5edfzp8taeEUOPhc/piJqeXDYa13MMg5E2rKRA5DTKJAzmiglKkO/z+RSjTkjPHKGm2TctxXDqa2eoIjF4Pa9AyMtFDlrqpQrJM7DMHRYPc9CN0EzXIImGVYfYvkl3NknPOXu0MdfU/vS0erDaWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO1F0AoPo6EpxT7E+XMEalGTV2WqMByjxi9NNT0abPc=;
 b=GZPFDJCyBtG1prRc/qmYaCqgTjzCGuU3mEIfGMV9QYZuXq+5Gg3KjeKVdb+t5/FdceFMOyWVYsRAHq6byGDpnQevKk7yItKC/6rW9Ns6TsUMD9ZJ+ARg1H6IzsotfgTtsPzOTswMtsJVrxj/naZy2s3tQGemA9NaKQbl76s5C9rT+/UIoJpQ9gu2hc9pX2EZwqOj/gehDxmLzSseGS3NFG9QLrEeH8yNuc9NckhoE0gjt6yUm+x8hSZdAnSoo6Nm3v8uETgJ5W1Th6mJKnFR8ue+jFhF1T7JsP39CQbkNQDSnSuI6AoQL7Bje+AbI6tnF/+UredJBMAvxZ8MsMhnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO1F0AoPo6EpxT7E+XMEalGTV2WqMByjxi9NNT0abPc=;
 b=YTUrOpVMp/5nPM6e22ZX0h3c1LrqNz6Mkp0jEvcEMg7C2ndfKgJ7zyAZMs83MbdjoRtkRQPxXn2kW6x1g8/hoWhuH4OiLxUk5UpkXOoa/v5qWk3aQdlOzJHUNyBCZpGY04lCsWOndiy3gTWtJ4hShCQt+Lo2+srMjaeUC9JHDBmdgvIVrMa6mkQbjO5emydapu6YPBxSD1oCkZ0bPND4yXTc+xCWvlCbWaprCq3Um70LNYVVpvHYo0ZW9lohAvK1toumh6vmK//vG0u2Z1/RihdLWrRljtjA1Vfu0/kr1fqD3nQuZZUOFkH/bq49Yg5VA9CxHT4EHqn70R4gdFSkiA==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Tue, 30 Dec 2025 13:20:56 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%5]) with mapi id 15.20.9478.004; Tue, 30 Dec 2025
 13:20:56 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Jared Holzman <jholzman@nvidia.com>, Omri Levi <omril@nvidia.com>, Ofer
 Oshri <ofer@nvidia.com>
Subject: Re: [PATCH 2/2] ublk: add UBLK_CMD_TRY_STOP_DEV command
Thread-Topic: [PATCH 2/2] ublk: add UBLK_CMD_TRY_STOP_DEV command
Thread-Index: AQHceYsmMEhmkShld0WpONv9QdgRwLU6KyuA
Date: Tue, 30 Dec 2025 13:20:55 +0000
Message-ID: <b6a70713-4832-450f-a60d-908efd02c984@nvidia.com>
References: <20251230125140.43760-1-yoav@nvidia.com>
 <20251230125140.43760-3-yoav@nvidia.com>
In-Reply-To: <20251230125140.43760-3-yoav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|MW4PR12MB7336:EE_
x-ms-office365-filtering-correlation-id: 5b32cbaf-44a0-4eac-4505-08de47a643c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dVg5OGhaUXdvTFNNaXhSb2x1U2xXaGhGcW5BV2RoYVlRdnNvVkpwUVNyMCtH?=
 =?utf-8?B?RmtjZjlCNXBsbnFhZk5BdzF5dTNMWkw4cDNiTWZGcWI3Q0QvYWV1UnUzQ2NX?=
 =?utf-8?B?RnhGL09PdjBqUXV2TXNPNndKK2E3Y1hEbW1FSm9PZUdXZHNNRGtDVU94aFdT?=
 =?utf-8?B?RHk0V2FUbi9NN2R4ZWtCaVNVazB4OFpSZGZBeVpsczg0UzBQUU9EU2w1VXpC?=
 =?utf-8?B?cjZyUW5talh0MHl4Nmh2azBnbEJzWVhKSForRjk4UG9mY2h1UWhPNllzWngr?=
 =?utf-8?B?cGFmUkF4clJSRDczaE5RU0NFS0VDbkROcVBrYmhTMUR4aDRwNy9kY3Q0Snp5?=
 =?utf-8?B?dEo0WHNwM2svWS9pN1I5VnNwZUowTGRYaHlTQWFOYi9NTDVwck5uQjN3bU5Z?=
 =?utf-8?B?Y2xJSXVFc00rK0tSdFR0ZzdMVEp2VmdFYU53YkMvWkhIYk44d1AyZ0JKRjNi?=
 =?utf-8?B?UWdkU0hWNTVGZjc0aDB3Vk5hZlJXT2xjd0hobjFLVDRCTEcwZTVCdHVMUVBp?=
 =?utf-8?B?VGpZbWU2M2RPYlV5UWdWWE5rMiszRXhxaWY0S1JVOXJSSkRYTjA2ajRKSkJk?=
 =?utf-8?B?TXg0YkQ0b3k2Yk4xRHBMY05UcXBRWVRXZ0VUNi9yVEdrcmZ3MDVpMG9ZZHgz?=
 =?utf-8?B?dFNUVnRDQjdIRSsramQ0L01jcUYzWW9Ydm1KZVZ6QmR0elc4cjUzb1ljdjhj?=
 =?utf-8?B?eURvdDE5MmljeENiTk9ib2RadmtOSGMrczU5OVQyWUFMM0lYc0tGRXZLR3hR?=
 =?utf-8?B?WXdQSmlCMzRlMFFwQnBSaXZ0V2hHTTI5akxPOFJMQk9vTVkxcDMxWjAvbmRo?=
 =?utf-8?B?T0t4bGcxcFQrcG0rdDBZL1JORkFnUlhmTVFVUTZuWlJBbkJKakNhNjRCd0R4?=
 =?utf-8?B?VEgvL1Q2Qk10SXNQSHkrRW1CajNLdTczZmkvNFpnVElFWEVXeVoxK2JOR1NY?=
 =?utf-8?B?VWhkN1h2SnplWVB1eGJIQ2VKaHJneUVWN1JKcVdncGYvV1Y3dDBPSlBRYUZi?=
 =?utf-8?B?WjZXTExjeDh0SHV2SHh3ZThBRDIvQXJ0d2t6UnF4MmR6bzAwcEI0MWg2QnFu?=
 =?utf-8?B?UkpYMVYwQmdiS1lsTW5HNUNNU3JEVFY0M1crK3VpUDVXN0FzUWZ2WUdQN2Ev?=
 =?utf-8?B?Znovb0tNcXdORndTTXcxR1BBNnVkdGZWZzRjN0xjUkM1QklhTWEzdGJTczVv?=
 =?utf-8?B?ZjVubER0MWx4bXNqMWhDcXBmVzAwamNRc0IvVFpKZXcxbTVhNS9sa1dkNDBn?=
 =?utf-8?B?U1ZZTThyTnRHYnBMNFBqbGhuaGdFMkJjWHp3bEtTUkEvUjFoZDZ3TFB1a0dm?=
 =?utf-8?B?YnVXM2NlNU5wWjhzQXliMC9YM01sMkRQbWFkcW9hZWRWMi95MG1ONFlNUkM1?=
 =?utf-8?B?cGdFNkJDRUJzRnJoenNKMmp5bmNKWEhzTUpPMzVuV2VGL1g3U3NjdEZ5Vlcv?=
 =?utf-8?B?Umh6WlVJZkhvOUVJNDJINkdaMWsyL2w2Lzk3VWF4Sk1qOXludkkvZmFZNHo3?=
 =?utf-8?B?a3NEZmdYZ294RkVodzdVYU1aTnQ3Ry9DZFJOUVJqT3NlNmJvNEYyMHA0Vldo?=
 =?utf-8?B?Tk5GMEFZcEZmY1FqWTBSSmNGN3hNaTFTTGZmRFAvUUV6bVZmemk2YUZrMzNH?=
 =?utf-8?B?UjBldmJEcHBJQ1ovSmNsZW9Ec0RabWVTYUtoSkxnRllmaFF5REpPNnRFMWhR?=
 =?utf-8?B?V1kzZDR4dXd6MS9KR05oWDBJMnFRWVVqVmxDREYxNUtCVlJ3ckF4QytFQzc5?=
 =?utf-8?B?QlIvbzdzdkV3cFU2ZExkRGVNYzdjVDhsUTFNaVJFRDdUaU1DN0ptTElIU2ww?=
 =?utf-8?B?MXpBNDN6ZEh1ZGN3dVd0RDh6a09ocmRNY3lmKzd6WkpkY1RzSmdRV2pKVXV0?=
 =?utf-8?B?Y2RINUdLRzA1b0tNaG04eENYYXlTQjFvNU5NVUxKUG1Yc0JXYWorWi9mK0xq?=
 =?utf-8?B?Um5sc0l1UHJIUjRqbHE0QldDaHhKNm1GMmFMb1AyWGIrR1hRWk1tUVJmc054?=
 =?utf-8?B?MjdYM3NkL3JrZHFycE4rOGdVaE13UGJBZ2s3SHFiS1RkZXVaSVV6a25PajJS?=
 =?utf-8?Q?ltp0sb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGhETk5tWGV6UFBCM0hEVkFuaSs0bEJSa3VzOUQ2dkgwZjFqY1Vja2ZHRVV3?=
 =?utf-8?B?UUM0MWxGaVhmTVdtVmkxMzRub2RlMThkYWxkKzMwTWpKemd2WXJ5bWg5bFB5?=
 =?utf-8?B?aVJSSEpsYjZlcVlOVEk2Rm9zL043MDJMR2F1RnhLY0wzR2h0SE53MWo1NHZS?=
 =?utf-8?B?Rys4QlJrVTZPR3BzYkd5a0pwTVh6amNTL2ZkcGppT2cxT1BOZlBxOGQyOHh3?=
 =?utf-8?B?RHF4SlNFZFJxbGxEbG1Ka09mS05xN1NIa3Jvbk92YjJqZ3FXSEJGeExPUEdK?=
 =?utf-8?B?bDNxVmE5REd0N2hGQlNFbG5mTFZpRFNWdlp6VUtaUUJDLzNpRE8wakJuTDV4?=
 =?utf-8?B?cWxiSmJaNUhpdmRMZzQ4bW9VMmhWMlh0bVE1TTZBK01nVkZKWGswNStpZlNl?=
 =?utf-8?B?VFhyciswcUhMV1FiKzdXSVJVdysyOXRNZjZGcURiSGw1bVN0YkZYVGE4SHRz?=
 =?utf-8?B?QU5SUG9DSkVzVUhWcEJPaHh0R3ZKWEg4eEVXa1VyaWt1U1VrZEh2QmNFa0ht?=
 =?utf-8?B?MHBJV3Fxa2JhQkZyT21HNFBwNWpibGIyZmF2RHJKSnNGcC9zN2M4UXJHOVRQ?=
 =?utf-8?B?RHZ1QnZQNDlSNjc5VVBhKy82M3I0MHppdkh6TFMwR3ZQUkdMMERmaUIwSFdM?=
 =?utf-8?B?Um9WS3RCOEpmU0pMMXpuWkpsRlpLMS9FZGg1a3lRZXdhU0tqaUtIbGFjMzZj?=
 =?utf-8?B?MmR5YURZd3R3ZXRqdUdzamdNSWN4TzB3NHE5d01xWHdBTUs4RjZRMVU4Qyt3?=
 =?utf-8?B?NDVwTkNrbjlnWlEzY016T1RVbVY5ZTEyQ0N6RGxaY0MveWx3bmxQNjhPTWhx?=
 =?utf-8?B?WXdsZ0owZFkyTHExNks1ejF0UDc0NlFETU4yaEdudDBVK2RrY1NRV0JIRmxr?=
 =?utf-8?B?bEU3djJlYmRHSmoyTVcyVmdjMUlXdDJvT3UrS2x2NE9ZaWJzWFFxeW5sY3k5?=
 =?utf-8?B?SHZjMHdQSEtJRkNKNUhIL3p6TnZHRDIyMlc2VkgrNk5ybmVmbk83dUJ2Z09a?=
 =?utf-8?B?cktMWUt6M0dPUzZnN0xrZjF4Rm9DcERVNWw4NWVsSHo0aFVWbW5vVEdPR0FE?=
 =?utf-8?B?NUVxV0lMeGVPWFFaRVhydDlldDAzVEMzM2FVR21uWmowdFBsQjlTUHdaRllJ?=
 =?utf-8?B?VEI2b3craUdXRzBiell6R3dKSDFoM3RJZXBXS05Ha3p2a1Q4ZmNsa0hUbXcw?=
 =?utf-8?B?R3JLZGVjQVVjcU4yVGwwVTBDdFZSYTM0Z2ZLZHVJczlYaGRhbTdLY0Z2VVB0?=
 =?utf-8?B?WVEzbEpyT041enBzRENlOE5ORGxRRmhuV1F1S3BJWjQ2RWZDMXN4enhNWEpX?=
 =?utf-8?B?emtVS2VocEthUDZQUm9zazIwY2Z1NlE2NHhFWm0vQnBnakNpMTc2SmhPa0Zl?=
 =?utf-8?B?dnk3c0Z4QzYxN3hIVlhOaGIwMVFEdWxUeEdFWXdmNC9QTnhzZk9PcGNLbWdF?=
 =?utf-8?B?eXRuNi84QXlKc0xXN0JZeGFLZWt6YUdqTWRIazlNMEVSL3R0dkgrS3FDeWti?=
 =?utf-8?B?Smg2Y2szU20wUXBRR0NMWkRnMUpZbVYzOTkrSWM0Vnl4YWI2NkJReU80eUFP?=
 =?utf-8?B?TE9xdUNnQjRSeHJzUHY1UCt5YWxuQkk4U0RxWXNzK21RdHR5a0x3NFpzU2RS?=
 =?utf-8?B?YzdIRldkc0hSWDdPZ3kvbFI3blRpaWxSNEQ0MkJyOGxaMjB1K3lsbmlhdDBl?=
 =?utf-8?B?V3lWS0pncTNEcFRGTGNIYjNuNTRUWFBBb25rRVdXcmFWa211UXBPQmVqVWxH?=
 =?utf-8?B?NTBoV2VDMk8yajB0QzdvamZudmkyVnNzUjFmN3VUTmMxb3QwK01kTERYMHBT?=
 =?utf-8?B?aEp2bEthck95Q3djVXEwam9TU2pWUGQxWjRRQW4zMzNuTnNKTzkyTEdndlp1?=
 =?utf-8?B?RmszWnRtUnVmNG0wZ1IwRTREclNOTnIzRHJYVG5oMVZ3eVFvVEZoRHVBMW05?=
 =?utf-8?B?ZWhwdlZvQXBGWXFha3dic2NOeDFQSnRkY3VHRkVWT0Q0aE5PU3ArMHIreVJa?=
 =?utf-8?B?dEUyaWFUR2d4alNZNXBjMHZWclBmalFyaTYraHlhWER2eGo3d204Tjk1RWtz?=
 =?utf-8?B?QklicmVXVThXejdFNGpZNzRBZmdZQSs3bXFlbDYvc3gvbzFkWGNWaUtKQWFl?=
 =?utf-8?B?RWVUYXE2NmV0dGd4cGJ3ZyswVVczWThuS0xuS3MwRG5aZG50ODd6ZjJnOHNW?=
 =?utf-8?B?dEZRekxuT2lHenE2ZC9BTFhDN3N0b09kMmRNSHVpc3QrTFF4L1Y4QzI0RlBU?=
 =?utf-8?B?RUk0U25UN2xvandXVlhrS2lYZ3BCbjNsTk1sMHVCbTN0SS9vTTI1eVl1NUt1?=
 =?utf-8?Q?iAGY+0wN8f3rxU2rOR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F5233653C96F74EAFC281718B87C243@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b32cbaf-44a0-4eac-4505-08de47a643c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 13:20:55.9845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZR9p8sKQkw3E9aL6gKGP+g/cKnqA5680FY13e6UavmWEdPaRxwykwxXjxHkpIQoi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336

T24gMzAvMTIvMjAyNSAxNDo1MSwgWW9hdiBDb2hlbiB3cm90ZToNCj4gVGhpcyBjb21tYW5kIGlz
IHNpbWlsYXIgdG8gVUJMS19DTURfU1RPUF9ERVYsIGJ1dCBpdCBvbmx5IHN0b3BzIHRoZQ0KPiBk
ZXZpY2UgaWYgdGhlcmUgYXJlIG5vIGFjdGl2ZSBvcGVuZXJzIGZvciB0aGUgdWJsayBibG9jayBk
ZXZpY2UuDQo+IElmIHRoZSBkZXZpY2UgaXMgYnVzeSwgdGhlIGNvbW1hbmQgcmV0dXJucyAtRUJV
U1kgaW5zdGVhZCBvZg0KPiBkaXNydXB0aW5nIGFjdGl2ZSBjbGllbnRzLiBUaGlzIGFsbG93cyBz
YWZlLCBub24tZGVzdHJ1Y3RpdmUgc3RvcHBpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZb2F2
IENvaGVuIDx5b2F2QG52aWRpYS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvYmxvY2svdWJsa19k
cnYuYyAgICAgIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICBp
bmNsdWRlL3VhcGkvbGludXgvdWJsa19jbWQuaCB8ICAzICsrLQ0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgNDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYmxvY2svdWJsa19kcnYuYyBiL2RyaXZlcnMvYmxvY2svdWJsa19kcnYuYw0KPiBpbmRl
eCAyZDU2MDJlZjA1Y2MuLjdjNGM5MjBjMzVmNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ibG9j
ay91YmxrX2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvYmxvY2svdWJsa19kcnYuYw0KPiBAQCAtNTQs
NiArNTQsNyBAQA0KPiAgICNkZWZpbmUgVUJMS19DTURfREVMX0RFVl9BU1lOQwlfSU9DX05SKFVC
TEtfVV9DTURfREVMX0RFVl9BU1lOQykNCj4gICAjZGVmaW5lIFVCTEtfQ01EX1VQREFURV9TSVpF
CV9JT0NfTlIoVUJMS19VX0NNRF9VUERBVEVfU0laRSkNCj4gICAjZGVmaW5lIFVCTEtfQ01EX1FV
SUVTQ0VfREVWCV9JT0NfTlIoVUJMS19VX0NNRF9RVUlFU0NFX0RFVikNCj4gKyNkZWZpbmUgVUJM
S19DTURfVFJZX1NUT1BfREVWCV9JT0NfTlIoVUJMS19VX0NNRF9UUllfU1RPUF9ERVYpDQo+ICAg
DQo+ICAgI2RlZmluZSBVQkxLX0lPX1JFR0lTVEVSX0lPX0JVRgkJX0lPQ19OUihVQkxLX1VfSU9f
UkVHSVNURVJfSU9fQlVGKQ0KPiAgICNkZWZpbmUgVUJMS19JT19VTlJFR0lTVEVSX0lPX0JVRglf
SU9DX05SKFVCTEtfVV9JT19VTlJFR0lTVEVSX0lPX0JVRikNCj4gQEAgLTIzOSw2ICsyNDAsOCBA
QCBzdHJ1Y3QgdWJsa19kZXZpY2Ugew0KPiAgIAlzdHJ1Y3QgZGVsYXllZF93b3JrCWV4aXRfd29y
azsNCj4gICAJc3RydWN0IHdvcmtfc3RydWN0CXBhcnRpdGlvbl9zY2FuX3dvcms7DQo+ICAgDQo+
ICsJYm9vbAkJCWJsb2NrX29wZW47IC8qIHByb3RlY3RlZCBieSBvcGVuX211dGV4ICovDQo+ICsN
Cj4gICAJc3RydWN0IHVibGtfcXVldWUgICAgICAgKnF1ZXVlc1tdOw0KPiAgIH07DQo+ICAgDQo+
IEBAIC0zMzA5LDYgKzMzMTIsMzggQEAgc3RhdGljIHZvaWQgdWJsa19jdHJsX3N0b3BfZGV2KHN0
cnVjdCB1YmxrX2RldmljZSAqdWIpDQo+ICAgCXVibGtfc3RvcF9kZXYodWIpOw0KPiAgIH0NCj4g
ICANCj4gK3N0YXRpYyBpbnQgdWJsa19jdHJsX3RyeV9zdG9wX2RldihzdHJ1Y3QgdWJsa19kZXZp
Y2UgKnViKQ0KPiArew0KPiArCXN0cnVjdCBnZW5kaXNrICpkaXNrOw0KPiArCWludCByZXQgPSAt
RUlOVkFMOw0KPiArDQo+ICsJZGlzayA9IHVibGtfZ2V0X2Rpc2sodWIpOw0KPiArCWlmICghZGlz
aykgew0KPiArCQlyZXQgPSAtRU5PREVWOw0KPiArCQlnb3RvIG91dDsNCj4gKwl9DQo+ICsNCj4g
KwltdXRleF9sb2NrKCZkaXNrLT5vcGVuX211dGV4KTsNCj4gKwlpZiAoZGlza19vcGVuZXJzKGRp
c2spID4gMCkgew0KPiArCQlyZXQgPSAtRUJVU1k7DQo+ICsJCWdvdG8gdW5sb2NrOw0KPiArCX0N
Cj4gKwl1Yi0+YmxvY2tfb3BlbiA9IHRydWU7DQo+ICsJLyogcmVsZWFzZSBvcGVuX211dGV4IGFz
IGRlbF9nZW5kaXNrKCkgd2lsbCByZWFjcXVpcmUgaXQgKi8NCj4gKwltdXRleF91bmxvY2soJmRp
c2stPm9wZW5fbXV0ZXgpOw0KPiArDQo+ICsJdWJsa19jdHJsX3N0b3BfZGV2KHViKTsNCj4gKwly
ZXQgPSAwOw0KPiArCWdvdG8gcHV0X2Rpc2s7DQo+ICsNCj4gK3VubG9jazoNCj4gKwltdXRleF91
bmxvY2soJmRpc2stPm9wZW5fbXV0ZXgpOw0KPiArcHV0X2Rpc2s6DQo+ICsJdWJsa19wdXRfZGlz
ayhkaXNrKTsNCj4gK291dDoNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICAgc3RhdGlj
IGludCB1YmxrX2N0cmxfZ2V0X2Rldl9pbmZvKHN0cnVjdCB1YmxrX2RldmljZSAqdWIsDQo+ICAg
CQljb25zdCBzdHJ1Y3QgdWJsa3Nydl9jdHJsX2NtZCAqaGVhZGVyKQ0KPiAgIHsNCj4gQEAgLTM3
MDQsNiArMzczOSw3IEBAIHN0YXRpYyBpbnQgdWJsa19jdHJsX3VyaW5nX2NtZF9wZXJtaXNzaW9u
KHN0cnVjdCB1YmxrX2RldmljZSAqdWIsDQo+ICAgCWNhc2UgVUJMS19DTURfRU5EX1VTRVJfUkVD
T1ZFUlk6DQo+ICAgCWNhc2UgVUJMS19DTURfVVBEQVRFX1NJWkU6DQo+ICAgCWNhc2UgVUJMS19D
TURfUVVJRVNDRV9ERVY6DQo+ICsJY2FzZSBVQkxLX0NNRF9UUllfU1RPUF9ERVY6DQo+ICAgCQlt
YXNrID0gTUFZX1JFQUQgfCBNQVlfV1JJVEU7DQo+ICAgCQlicmVhazsNCj4gICAJZGVmYXVsdDoN
Cj4gQEAgLTM4MTcsNiArMzg1Myw5IEBAIHN0YXRpYyBpbnQgdWJsa19jdHJsX3VyaW5nX2NtZChz
dHJ1Y3QgaW9fdXJpbmdfY21kICpjbWQsDQo+ICAgCWNhc2UgVUJMS19DTURfUVVJRVNDRV9ERVY6
DQo+ICAgCQlyZXQgPSB1YmxrX2N0cmxfcXVpZXNjZV9kZXYodWIsIGhlYWRlcik7DQo+ICAgCQli
cmVhazsNCj4gKwljYXNlIFVCTEtfQ01EX1RSWV9TVE9QX0RFVjoNCj4gKwkJcmV0ID0gdWJsa19j
dHJsX3RyeV9zdG9wX2Rldih1Yik7DQo+ICsJCWJyZWFrOw0KPiAgIAlkZWZhdWx0Og0KPiAgIAkJ
cmV0ID0gLUVPUE5PVFNVUFA7DQo+ICAgCQlicmVhazsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dWFwaS9saW51eC91YmxrX2NtZC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3VibGtfY21kLmgNCj4g
aW5kZXggZWM3N2RhYmJhNDViLi5iYjE5MWQwYWZmZjcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
dWFwaS9saW51eC91YmxrX2NtZC5oDQo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC91YmxrX2Nt
ZC5oDQo+IEBAIC01NSw3ICs1NSw4IEBADQo+ICAgCV9JT1dSKCd1JywgMHgxNSwgc3RydWN0IHVi
bGtzcnZfY3RybF9jbWQpDQo+ICAgI2RlZmluZSBVQkxLX1VfQ01EX1FVSUVTQ0VfREVWCQlcDQo+
ICAgCV9JT1dSKCd1JywgMHgxNiwgc3RydWN0IHVibGtzcnZfY3RybF9jbWQpDQo+IC0NCj4gKyNk
ZWZpbmUgVUJMS19VX0NNRF9UUllfU1RPUF9ERVYJCVwNCj4gKwlfSU9XUigndScsIDB4MTcsIHN0
cnVjdCB1Ymxrc3J2X2N0cmxfY21kKQ0KPiAgIC8qDQo+ICAgICogNjRiaXRzIGFyZSBlbm91Z2gg
bm93LCBhbmQgaXQgc2hvdWxkIGJlIGVhc3kgdG8gZXh0ZW5kIGluIGNhc2Ugb2YNCj4gICAgKiBy
dW5uaW5nIG91dCBvZiBmZWF0dXJlIGZsYWdzDQoNClNvcnJ5IGJ1dCB0aGlzIGlzIG1pc3Npbmcg
YSBjaGVjayBmb3IgdWItPmJsb2NrX29wZW4gaW4gdWJsa19vcGVuIC0gSSANCndpbGwgc3VibWl0
IGl0IGFzIHBhcnQgb2YgdGhlIFYyDQo=
