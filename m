Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020136.outbound.protection.outlook.com [52.101.228.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D901465B4;
	Mon, 16 Feb 2026 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286384; cv=fail; b=ETB4NRGObMHWFm2kmnWMI4vnVtckfMqJGRUEO8sH0kEQ+DJH3P77YbWY1zcXpYS9itg/G2k8DOFPky0xy+vSRyNv0xsWmNH1ghP2jkey3fxhcbR3TjxKrtR1HOD5KK4pyO3q6cMDVRSDQLae2qwLu4YLIZpB1M2Wpv7QlXYNwpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286384; c=relaxed/simple;
	bh=72XWJM5KqcibFFxUVdJfrIl9aQFSd+snk5slyT7w+yA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K6ozPF2PbcjqdDTkT4w2l+XqQr8Tc171aKxD843O0yocIqzgScfG52/1U3s1b5GIpxqBxnjLI2qJLjqf8Qv9z8vmKp8OeZlkpS6w5YfCRPescg/Heo8BDpoTvV4OTokw2poBbp40OGocJvXZYrUreLBtq2CpE74yxNmdFEaKdZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nskint.co.jp; spf=pass smtp.mailfrom=nskint.co.jp; dkim=pass (1024-bit key) header.d=nskint.onmicrosoft.com header.i=@nskint.onmicrosoft.com header.b=dGGKRitl; arc=fail smtp.client-ip=52.101.228.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nskint.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nskint.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nskint.onmicrosoft.com header.i=@nskint.onmicrosoft.com header.b="dGGKRitl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeZ4k7aQlJiJ05yUmfx/edM6B4mUCqwz9nyriRM0bQQmaz7wLruCzsif2nOt5i0KrsZgjd0BdlctHpD1q6noaEvizFrssRXg71lGwFug/M3LP8cOLBBJrTGlnjUQwbjZQxc/PcXHIXTrYRJMyG6XH0X7k6kvTYb+UlChkKT9TkO387xMtJ3JQrPnvWPfNSrzYi73feD4Epa2Btbm1JbTbJMnmUxe0EPCKRwnyTo1/XiaHNAMZb1oZh8NeRwQcviswNCFBtTZHI9BHyI+jdEsWBCHdckF3sdtqIrKSUnnrWsVFOUQPeMHCWhmjsDtwQXX8LL0U1s/r4dI/Ul0sfi6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72XWJM5KqcibFFxUVdJfrIl9aQFSd+snk5slyT7w+yA=;
 b=SbF3CkXEKdHysx1yKjADyCAcsP/RzYt0fgeGcfKfjNVrTeCT+oRhsm3y2O7/TpQjpkZIyMGDqYe588e2rhhUIuxF4EjZrlxC/2uadUnxhbMSOQf1WsFovfb9YYl8qBMgriYTd3ikkhtIUh8vwewsEdDBBHbC30D6WpATV6MRD7nW5r81pkhR7MFqCgkFCwDW0eLUJof499WrU3/M31EQCqXE5ikgB0dGWfY4EG1Smd0QKTmq1xyljA5vK3PnFng9YSVxIdo3O5QxIhBfO6tek0VI890RDoX4IldsfUBT04h6D7zOD6UV1vhnGJ/h/gudartm6Tf1dMcxsgoky9Wg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72XWJM5KqcibFFxUVdJfrIl9aQFSd+snk5slyT7w+yA=;
 b=dGGKRitleTbkol+KqUNYsoNhlYbj/LjlA5TPkSzm/6VVIlJG/Lmnpcrah0fV6EAc3kbUODBMbXKNde8XzylawF9O9YwktQ9LJzEMApYey8MFaV9/BGl37Cig6691D5/nr5bO8DlcNFW1dChj2pmSeTw8W2Lb7lwYMnR/taBxSq8=
Received: from TYRP286MB5995.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2ef::11)
 by OS7P286MB5423.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:383::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 23:59:38 +0000
Received: from TYRP286MB5995.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8871:189c:6e56:c54a]) by TYRP286MB5995.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8871:189c:6e56:c54a%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 23:59:38 +0000
From: Ken Kurematsu <k.kurematsu@nskint.co.jp>
To: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng
	<boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, Miguel Ojeda
	<ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross
	<tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, FUJITA Tomonori
	<fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Lyude
 Paul <lyude@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Ken Kurematsu
	<k.kurematsu@nskint.co.jp>
Subject: RE: [PATCH 62/79] block: rust: add `TagSet::update_hw_queue_count`
Thread-Topic: [PATCH 62/79] block: rust: add `TagSet::update_hw_queue_count`
Thread-Index: AQHcntT8BtbNEnysHUWZ7zqCk2HS/LWGAk4Q
Date: Mon, 16 Feb 2026 23:59:37 +0000
Message-ID:
 <TYRP286MB59951867FB2026AAB52DA80FDB6CA@TYRP286MB5995.JPNP286.PROD.OUTLOOK.COM>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-62-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-62-de9a7af4b469@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRP286MB5995:EE_|OS7P286MB5423:EE_
x-ms-office365-filtering-correlation-id: 9158489b-3ccf-45cc-c827-08de6db7713a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SDdORDU5eXdEc282K3I3bEZpWGtMK3ZVNzl6NEtMcWlnVVVCNG9VRS9NZUFH?=
 =?utf-8?B?OFJQQ3MvZWcwTUFLRTRoQVN4cERIU3NuK2I2VG5CRHdic3NRTmZVQVlqejFX?=
 =?utf-8?B?SWtGc0tsUm1Rb056N1R0R0htTENQdVA4ZHJzVEdoWHJVYnY5OVlwRWFTVGV6?=
 =?utf-8?B?MWx2anRLSGR2ZUpWRmhQZjdSbXIwdXpVWnoyNmNXVmNDdlVSaEwySlEyTVls?=
 =?utf-8?B?OGhKT1FtdGRGa043eXUzbUZsV3IyUDFVTDdLekZqcmpQUFJyRm1RWEhVRkZP?=
 =?utf-8?B?UUQyakpkVjNUTzlaNURaVm9PeDcvNzZCV3NMNTJqUmZjVUR0ZmtIOFp2dHAx?=
 =?utf-8?B?MEQ4ZUtMa1EyMEwydWVUTFZnWEVvaVR0R0Zpb0FPdXdxT1lINXdkYktrMmdS?=
 =?utf-8?B?bEhWSllQK2dUWFJTR3hUd0RHVlRUTVVxUHRZWUJyeEpYWC9EK0tzMnkvTFhT?=
 =?utf-8?B?NTE4ZHh0YjFVZngrMXF6a1F5VHZTSUdTTzRZeEQvQjZydVZZY1R6N1dtTnlV?=
 =?utf-8?B?VGFsWEtwSUZBU1Y4WEtQVDZCWXhPNFAxYi93OUhINjc4R0d5cDJidDdadXRo?=
 =?utf-8?B?MWxwUkE1Qk95dEk2ZlZianB4VUUrRGRUc1NEYVdrMlFJVVR6elYvaFdpRmlK?=
 =?utf-8?B?a0RzMENuKzJwWWJNUkpNcDV2U0Q1S2p3ZS9UNlVJMjVlTVlwTDJ5VjRJcE92?=
 =?utf-8?B?Y2VLSTQ1WnZpSTlXM0dZVHZTbVZLcUNTVGpiMnVNcVk3Q05ZWTBzRTB5dWNj?=
 =?utf-8?B?OE5lcGhjVGVoYkY0R25RVnVkZklJUGY3UExkY0NGUFBRcnFIQXdCME9QZzVC?=
 =?utf-8?B?ZlJHSHVRTjM5V2sxMkhTQ2tEQ3pUVDB2V1ZrQ01uVkhXNVd0enZrSHMwM0VN?=
 =?utf-8?B?N0QvZ0t3d1B4cjFsdG8wVSt1ZDlDV1hObVBsUTFPMHhVR2s4ekVMQjlkR0xO?=
 =?utf-8?B?SWwwZWtSWGJ2bEdxdmxjQnFXcUVyTmEzUFpsaEduVUM2VEJDZStXQVBmRjBJ?=
 =?utf-8?B?NVltM1ozVDZzMENsMmhJQnZ1Uld3SGxkQUgxRjBqMUplMVlPQU55eG5lZzVx?=
 =?utf-8?B?d29HRDUwNkhqSTlhR2NFQ3ZqQUNJL0ljampkU2J4eWZzbk03SkZnWncrUUdV?=
 =?utf-8?B?bmlGV3lkNGlNemQvdzM0bnpjOWZPNGROWndmRTR3aDlzTGtMVWdZOEh1Nlo5?=
 =?utf-8?B?Wm5IY2ZxNUIyUDBXNVUrMnQ1Q2hsQ2cyc05PcjQ3QWpZZHJ5NWdmT1RDTWI1?=
 =?utf-8?B?VTErSXY4Mlp5VjBYcXd1Vm9Td0RqbUdWQytlbkx3NGpMem93a2F6MW9udVpk?=
 =?utf-8?B?TjcyVkp2UjZCY1hhUTg5ZzNBQ1lHODQrMUdJdU8zVVJuTUZlKzZDakpPTGdO?=
 =?utf-8?B?aitSdHJEYVRoUlN6RWhDUUxKbTVFOFpydTY1Lzd5UkNKMDZwUE1mcHdrNlB6?=
 =?utf-8?B?OXV2dlZSZ1BmOFlUTFNRRXgvcFBjRmtWdlF5TjM3Y2JkQVZjSWJHMG5OMVJs?=
 =?utf-8?B?RFhxWkFteWViM0tZbHFlcEVjOVNwcEFIUkJWY3IwUlFUd0tRVTBSUnpKQys0?=
 =?utf-8?B?NU81VkMzYmZ5ZFVxS1lES2ZYbzRMWE43ajBnR09kOGdYa0hyY1VHWEpIMmQ1?=
 =?utf-8?B?dytISVJZMWN1U1RDSDZ0Qlp2bmRneEdCUDF4VlE3bEFiVkJLNmgvMlJEbkl2?=
 =?utf-8?B?bHVMaXI4clVPZm9nS1liYWEwODFSMDRPZlV6dHZFSXR1V3lmUEZPczVNWDZC?=
 =?utf-8?B?VXJXUi9HeWdMdS9CRDdkM1V2QVoxc2ZhKzlsMlk1dmtPdVNOVWdTU01PY1Rr?=
 =?utf-8?B?Z1lVZjB3NThKb1NHOUVxeHlWU2dEUjA0T1Z5eklrUzNJdjc4YzFPVjEwUUJ1?=
 =?utf-8?B?T05lMXdHamprUEd0aGhNak1HRlNmQ3NBWHNOVjMva1pBNmR0VDlVb3kzYjNz?=
 =?utf-8?B?UVpsclVTUEhVbVZVWUVDMndhdFdja2dpWFVDdjF5MHFaVTZ6bEVQalNsMmV1?=
 =?utf-8?B?cEk0Q2VaQStxNmFRVlhIL1dZVkdCWE1yWlR5blBlaFBlOXlXOHQwckNwa1NS?=
 =?utf-8?B?enhtL0xMdy8zOHArS3JUTHUvN3pwdW9POUFndXVpR2dBMERoWU02Mis4MGt2?=
 =?utf-8?B?THRoKzI5Sk9GM01WOVFlN2VVby9aNVFlWDZiMldPbVBlcjRSYW9qSnU1K2pq?=
 =?utf-8?Q?vUEsM1dHo90fIxuoM/0+He3XUbd4sqpyYD3pBX3cbEBu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRP286MB5995.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3V6cXBpL2NZUjdIemhvd1Zid2x4TUhMWFR5bUF4QjN6ZXdOZ1pNWHJPZkpZ?=
 =?utf-8?B?NTBNeUxhZGFJa0hCZ0hCQk1FMnpUT253OCtTS3NxMkhUbkdKMnlwOXFMN3E3?=
 =?utf-8?B?c1lmSitGZnRwMThKandtRVVoU2tDdjk1NnR6RXZySjB5SDZlU0F2ZFNId1Nk?=
 =?utf-8?B?TWZEMlJKYUt6U1hlTEltOFV4QjBnem5kVzBlbHNDRGZOUmYvVGhuMFRDL2da?=
 =?utf-8?B?a2haVS9Zakc1TEZERTFHWCtOZmRuMXp3OExiZkpkMXRxYnBaUzRrWE53bmpZ?=
 =?utf-8?B?dEJFM21PNitieHZkREpHbWdqcDYzMGJaVWY5VU5LOVVCMVBFU3JQaUtzaG9Y?=
 =?utf-8?B?TTJabmo4OHVBTTJ1Y2FvNFJ0ZXVWV2x2dE85MDkwWHZnUmQxWjh1dDFlTHBX?=
 =?utf-8?B?ZmE2UUxYSXU4N0JrUTM0Z1MrODMxMmlZeXBEWU55Z0pzK2RVZUZmbUR6bnRv?=
 =?utf-8?B?YmNtNUV2WnNEaENTVkRWTXFwNHljc1Z5dVJkVkZ2THhNV0NGb1VLWWI1QTVW?=
 =?utf-8?B?VXZiVjBCbEUvNFRFZG0vc2hVOEd6QXlRaWZURFZkM1lqVnVMWCtnZFRuVTlL?=
 =?utf-8?B?bytZZVVRWVVSUk9GZnpteU9EVlhLcDJtZFdxdkt3UUFUbi90bU5XdE8zaEZ1?=
 =?utf-8?B?TnVmdXV1aDVCMjcrcDF2aWhKckRmMkxTcDl4UnJoZExyQ2dPUUVJVlMzSElP?=
 =?utf-8?B?eXNKWCtaVFhTaXFwSGFjNHVtRDBVUlYwa2x2b0dRT0VvVnpFZndoNm5aVjdE?=
 =?utf-8?B?R3JVNmNmSzVieWxjZ0hXV2dtdjhRQW1TUXRuVlVGOGZ5WFE4MzdzY2JLNmN6?=
 =?utf-8?B?RjRYZlFqOTkwY3ZYb2M2TE9rS2xpVjFldFF1VFZ3MEF4YTJ0L2VyN3JNWUlo?=
 =?utf-8?B?L0dRSksyaGIwUG81cHJPUmRpSVdVVTJnNFVUdlYxN3Arcmk5WFpHSDVzSUVv?=
 =?utf-8?B?ZkRLbWdMZWhoTmNRK2hTbjM0MjZ5U0o2amVHNEVvWWI3a1lwVkdQdFVWS1lx?=
 =?utf-8?B?NjUzUzd0OU1IT2l4TEJBM091RTZFVmRiWnZvcSt3bGFYRExNcFVqYzRpV2ZW?=
 =?utf-8?B?MFhMdnJRUzM4VHljY2ZRclpvQ01rZiswWmZoWW9CR3JGZmtGSUxsVnZmNlRD?=
 =?utf-8?B?RnUzbFQ5cldBa2hMbC93aXo0YW5ZUVprRWdPOEE4YkxYcDRKS3NBRDMwMFgz?=
 =?utf-8?B?bDVCNnFDRFJ3clFCT3lvdlQ3S0pub0RwUGxQaHFabVBodnpPYVBoRmRydUJM?=
 =?utf-8?B?emxXSVNsZW5aOW5tWkdvT1RIT0tJakY3RmNhL3BIbzk4aCtITFppOW5wV2Ni?=
 =?utf-8?B?Q0FVb0k1VTlwU1hVT25jUnlLRlJWUVd1Z0N1Ry9vLzB0dnJhNHhjNnkrMjBK?=
 =?utf-8?B?SlZBY1BaOUN5elJiaEZUNnQwRGJBYlZLUWNnSFJLd3pkdVJld3Q1cCtJK2Jt?=
 =?utf-8?B?US83YzZ1aHNVdnlpSkRmczY2ckNyNXlGeWNyT2dJUzJkNW9MekVZd2ZmUnNu?=
 =?utf-8?B?TU9wL3QvVldERzcvNlo5K0V1T1pzaVpVRXpTZWVWSnV5VGRndFIxaW1zQ2JJ?=
 =?utf-8?B?Rm10czBZbDJ1SUFkSno5WTZvZWZVcHpVMTFDUHBqaTNhR3l4dmNERlpnbG4v?=
 =?utf-8?B?SSs3bkhFZnZCTVhvcWh6Qkp4YTcvcTAvbGxHdm45a0RLODFUOUVrWmVOVFB3?=
 =?utf-8?B?OHRlUFdSVXMrZHVDSXRsQ1hRSmZBSTQxK2FtNVRiMDBWd0lvUUVpcDM5L3BZ?=
 =?utf-8?B?M0F1K1lXWldXTHM5TThNTGZHV25Gc256Rkl1ZlphdmJlU0RVMmJNSGRiTU5V?=
 =?utf-8?B?NEJPd2pOVlZqN0pxT0lVQ0RUMmdyL3hWR1NOQjFvZnhDZEJ1a0RBRVZiNURl?=
 =?utf-8?B?TllsQ09oblRZc1BFQjc5YmlVM2I5VzRpTXRTQ3RISVFBbHZJUUtrRXoyNTVn?=
 =?utf-8?B?aFZaMWFOblNENmFzczhVdGhEMTN2eCtmZFpCS2NKVG9VQWl6QjBLaGhhVXk0?=
 =?utf-8?B?d29Fand1RFZ1aVFpU3ByT1dMcDNpbFpPa3BrUDNtRDRoWk1lVkt4RnloWTdq?=
 =?utf-8?B?bDdZL3VxL0dIbmxEQ2t5cW5TZ3Y0bHpnZ3I3TXZLS3diYmJ0d0d3UkVIK0Fo?=
 =?utf-8?B?R2g0TElDOFZWeXRQTVlaU3dmSGZFOTg0anV5N0dYMHNoRm1jYWZEc0tpNU1Y?=
 =?utf-8?B?V1NBejNFQnh0TmlDbmp5clNkdDAvMk1iT0IrSzFBS2JBL0F3RmwySlJkUXZD?=
 =?utf-8?B?Q1BLV20zbEY4MFFxdnNIMEdWUXpKSGhuM0M3RVhRanF6MFBJanR6Vm1Ydm03?=
 =?utf-8?B?QUxOR1A5NHBoZUZWazRnOFhQRnpKWnpiWTZZR1JYWUI5WDNSUHVVdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRP286MB5995.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9158489b-3ccf-45cc-c827-08de6db7713a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 23:59:37.8871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlAPPvMur+Kd8ptsvtKPRuBXRIUjDpMFiGm+Z3JofeXqAVC/2nqxgMniHSTSLH8hOiQBXH3TvKYu201DgSO65fKcjHU6GeroS+/qXak5lO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB5423

SGkgQW5kcmVhcywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRy
ZWFzIEhpbmRib3JnIDxhLmhpbmRib3JnQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgRmVi
cnVhcnkgMTYsIDIwMjYgODozNiBBTQ0KPiBUbzogQm9xdW4gRmVuZyA8Ym9xdW4uZmVuZ0BnbWFp
bC5jb20+OyBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ow0KPiBNaWd1ZWwgT2plZGEgPG9q
ZWRhQGtlcm5lbC5vcmc+OyBHYXJ5IEd1byA8Z2FyeUBnYXJ5Z3VvLm5ldD47IEJqw7ZybiBSb3kN
Cj4gQmFyb24gPGJqb3JuM19naEBwcm90b25tYWlsLmNvbT47IEJlbm5vIExvc3NpbiA8bG9zc2lu
QGtlcm5lbC5vcmc+Ow0KPiBBbGljZSBSeWhsIDxhbGljZXJ5aGxAZ29vZ2xlLmNvbT47IFRyZXZv
ciBHcm9zcyA8dG1ncm9zc0B1bWljaC5lZHU+Ow0KPiBEYW5pbG8gS3J1bW1yaWNoIDxkYWtyQGtl
cm5lbC5vcmc+OyBGVUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+
OyBGcmVkZXJpYyBXZWlzYmVja2VyIDxmcmVkZXJpY0BrZXJuZWwub3JnPjsNCj4gTHl1ZGUgUGF1
bCA8bHl1ZGVAcmVkaGF0LmNvbT47IFRob21hcyBHbGVpeG5lciA8dGdseEBrZXJuZWwub3JnPjsN
Cj4gQW5uYS1NYXJpYSBCZWhuc2VuIDxhbm5hLW1hcmlhQGxpbnV0cm9uaXguZGU+OyBKb2huIFN0
dWx0eg0KPiA8anN0dWx0ekBnb29nbGUuY29tPjsgU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwu
b3JnPjsgTG9yZW56byBTdG9ha2VzDQo+IDxsb3JlbnpvLnN0b2FrZXNAb3JhY2xlLmNvbT47IExp
YW0gUi4gSG93bGV0dA0KPiA8TGlhbS5Ib3dsZXR0QG9yYWNsZS5jb20+DQo+IENjOiBsaW51eC1i
bG9ja0B2Z2VyLmtlcm5lbC5vcmc7IHJ1c3QtZm9yLWxpbnV4QHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBBbmRyZWFz
IEhpbmRib3JnDQo+IDxhLmhpbmRib3JnQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFtQQVRDSCA2
Mi83OV0gYmxvY2s6IHJ1c3Q6IGFkZCBgVGFnU2V0Ojp1cGRhdGVfaHdfcXVldWVfY291bnRgDQo+
IA0KPiBBZGQgYSBtZXRob2QgdG8gYFRhZ1NldGAgdGhhdCBhbGxvd3MgY2hhbmdpbmcgdGhlIG51
bWJlciBvZiBoYXJkd2FyZQ0KPiBxdWV1ZXMNCj4gZHluYW1pY2FsbHkuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbmRyZWFzIEhpbmRib3JnIDxhLmhpbmRib3JnQGtlcm5lbC5vcmc+DQo+IC0tLQ0K
PiAgcnVzdC9rZXJuZWwvYmxvY2svbXEvdGFnX3NldC5ycyB8IDE3ICsrKysrKysrKysrKysrKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3J1c3Qva2VybmVsL2Jsb2NrL21xL3RhZ19zZXQucnMNCj4gYi9ydXN0
L2tlcm5lbC9ibG9jay9tcS90YWdfc2V0LnJzDQo+IGluZGV4IDRkMDA5NzlhODNkYmQuLjQ3YTE2
MjM2MGU2MjggMTAwNjQ0DQo+IC0tLSBhL3J1c3Qva2VybmVsL2Jsb2NrL21xL3RhZ19zZXQucnMN
Cj4gKysrIGIvcnVzdC9rZXJuZWwvYmxvY2svbXEvdGFnX3NldC5ycw0KPiBAQCAtOCw2ICs4LDcg
QEANCj4gICAgICBiaW5kaW5ncywNCj4gICAgICBibG9jazo6bXE6OntvcGVyYXRpb25zOjpPcGVy
YXRpb25zVlRhYmxlLCByZXF1ZXN0OjpSZXF1ZXN0RGF0YVdyYXBwZXIsDQo+IE9wZXJhdGlvbnN9
LA0KPiAgICAgIGVycm9yOjp7c2VsZiwgUmVzdWx0fSwNCj4gKyAgICBwcmVsdWRlOjoqLA0KPiAg
ICAgIHRyeV9waW5faW5pdCwNCj4gICAgICB0eXBlczo6e0ZvcmVpZ25Pd25hYmxlLCBPcGFxdWV9
LA0KPiAgfTsNCj4gQEAgLTM0LDcgKzM1LDcgQEAgcHViIHN0cnVjdCBUYWdTZXQ8VDogT3BlcmF0
aW9ucz4gew0KPiAgfQ0KPiANCj4gIGltcGw8VDogT3BlcmF0aW9ucz4gVGFnU2V0PFQ+IHsNCj4g
LSAgICAvLy8gVHJ5IHRvIGNyZWF0ZSBhIG5ldyB0YWcgc2V0DQo+ICsgICAgLy8vIFRyeSB0byBj
cmVhdGUgYSBuZXcgdGFnIHNlIH10DQoNCklzIHRoaXMgYSB0eXBvPw0KSXQgbG9va3MgbGlrZSBh
biB1bm5lY2Vzc2FyeSAnIH0nLg0KDQo+ICAgICAgcHViIGZuIG5ldygNCj4gICAgICAgICAgbnJf
aHdfcXVldWVzOiB1MzIsDQo+ICAgICAgICAgIHRhZ3NldF9kYXRhOiBUOjpUYWdTZXREYXRhLA0K
PiBAQCAtMTQyLDYgKzE0MywyMCBAQCBwdWIgZm4gaHdfcXVldWVfY291bnQoJnNlbGYpIC0+IHUz
MiB7DQo+ICAgICAgICAgIHVuc2FmZSB7ICgqc2VsZi5pbm5lci5nZXQoKSkubnJfaHdfcXVldWVz
IH0NCj4gICAgICB9DQo+IA0KPiArICAgIC8vLyBVcGRhdGUgdGhlIG51bWJlciBvZiBoYXJkd2Fy
ZSBxdWV1ZXMgZm9yIHRoaXMgdGFnIHNldC4NCj4gKyAgICAvLy8NCj4gKyAgICAvLy8gVGhpcyBv
cGVyYXRpb24gbWF5IGZhaWwgaWYgbWVtb3J5IGZvciB0YWdzIGNhbm5vdCBiZSBhbGxvY2F0ZWQu
DQo+ICsgICAgcHViIGZuIHVwZGF0ZV9od19xdWV1ZV9jb3VudCgmc2VsZiwgbnJfaHdfcXVldWVz
OiB1MzIpIC0+IFJlc3VsdCB7DQo+ICsgICAgICAgIC8vIFNBRkVUWTogYmxrX21xX3VwZGF0ZV9u
cl9od19xdWV1ZXMgYXBwbGllcyBpbnRlcm5hbA0KPiBzeW5jaHJvbml6YXRpb24uDQo+ICsgICAg
ICAgIHVuc2FmZSB7IGJpbmRpbmdzOjpibGtfbXFfdXBkYXRlX25yX2h3X3F1ZXVlcyhzZWxmLmlu
bmVyLmdldCgpLA0KPiBucl9od19xdWV1ZXMpIH0NCj4gKw0KPiArICAgICAgICBpZiBzZWxmLmh3
X3F1ZXVlX2NvdW50KCkgPT0gbnJfaHdfcXVldWVzIHsNCj4gKyAgICAgICAgICAgIE9rKCgpKQ0K
PiArICAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgRXJyKEVOT01FTSkNCj4gKyAgICAg
ICAgfQ0KPiArICAgIH0NCj4gKw0KPiAgICAgIC8vLyBCb3Jyb3cgdGhlIFtgVDo6VGFnU2V0RGF0
YWBdIGFzc29jaWF0ZWQgd2l0aCB0aGlzIHRhZyBzZXQuDQo+ICAgICAgcHViIGZuIGRhdGEoJnNl
bGYpIC0+IDxUOjpUYWdTZXREYXRhIGFzDQo+IEZvcmVpZ25Pd25hYmxlPjo6Qm9ycm93ZWQ8J18+
IHsNCj4gICAgICAgICAgLy8gU0FGRVRZOiBCeSB0eXBlIGludmFyaWFudCwgYHNlbGYuaW5uZXJg
IGlzIHZhbGlkLg0KPiANCj4gLS0NCj4gMi41MS4yDQo+IA0KPiANCg0KQmVzdCByZWdhcmRzLA0K
S2VuIEt1cmVtYXRzdQ0K
