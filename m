Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F4E1DA62E;
	Fri, 15 May 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848299; cv=fail; b=et+4CxDz5SzKtF9hUy/VcOWaNzFO/JNknyQZ7kbkyGuDqtbZoO7lHJRiRIqbN1k6GUCloVyoMVmgGtEjhqplC956d2Z+VT26qsWmu3xb06ZHld9nVX9liGYF/pm5KWDieNODBYRqbL4EqPQotuAvV7Fz+/EKUNsdOkbwCUA6nXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848299; c=relaxed/simple;
	bh=vEff0ZXPSeUs/hQuTZnD3NVb4qf78EcHBp3OIVbG6QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GuAO2KVWfwY7y0Km5EFPukhoRVDpT8me6Qv4wnpKx1CvnwdQxIH93qnJlpyUcwaXkNEyvmmLx+uwOHhDT+yv0gQ/rp4LcMZ2vCN1LmgjIKZJXnl1Ri2W/BxyOOP9j+5XyUhtByfJTTRnHkeGyVRuNbO5lMcCZDr5Vb5xXxPIOfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=n93v8cyQ; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="n93v8cyQ"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBtwd11830607;
	Fri, 15 May 2026 12:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=KwkJHkMi1IfzaVjz4dQd94BMSLr+gl7QHi5TiuVlt6M=; b=
	n93v8cyQ2jrprtDCnRua0APYDeSZQOMiI/MzaiKHIP1gz+5SgFe0vqrGg9nI8wM7
	I59a6QlStFVPluCyoVh1fc6sE4aEQx9lS8uMV6JyzakBleGneuMFPy8AngPPH40R
	JTSdAlrGaiUKKejQh6f3SDLVeu3+29fTArIeiPGxtYhsN0pyR8zT+HcawUHtIJje
	NvdfyQbzPfb1N2+6+c7fXYncjWtGorze6wPORpRfAFHKN1pgtM7deAFN3I8FaP0S
	sncX12Vd6+aqPzmrHF2HVSLujr0rqd69LDejVe6pG78GDGTIS7739C2RwyxMu++S
	h5x1201+bVtVHZ8NJyU/tw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e5m6c0vjf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 12:31:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYZz6gERTKSGFVTEcs2b0KNE+TlkT/yD0hQsZIr+Artfeej/C2QpY0nf3jQJ98sp0ZhHZOTDmgSSgVZ91KqwvnRU5kL913j5DdjYkbJ84OrmUDP9aPWVg1BGdZ5Fgo382eBGikHK4NwaHYIhgq484bAHXHt/MdfsC3+xQNrT6K/r6ca167URuqObXofEGtyK+8Oy8Uq39KWP4QWB/leSFoXBUzGSHC0yAlg0aGCjIfH6B4QnJUq4NidZyx3h7PbQ8iiyHLKbANwHL4IzPVef6DdFbQq5oj3ev2EI01lfNQ80tFEVjTJoWRYJMa1Lzcnizo7VauT3uF2JWwnn6J1Oqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwkJHkMi1IfzaVjz4dQd94BMSLr+gl7QHi5TiuVlt6M=;
 b=JtHXSoo1v6dANra9x5KDpStTuHWMKFzKL/52DO6382u5kALGcStAZmZHhxT3Bn9S63G+PJ/IeJULS9lr9nWNssQo8RfKjuwTrtV5++EPNhb8AqjBTF/tyzM9ULb0gxMNh8cUTMDgbKrWBXiLdX1Uy14evkBLOmKfa8n7W2tM7kDibPq8HjetsLqovTl7dmHCMjuTdu//FxwsBVh6mZ51s1ZxUMF4Xzj3m+q6A4w1Z4bVnT7SPyYv2QwuPjmmjuiVsZ1XFoO3tvtwsgaPaatX7eeIAhLok2s1KxJIjvoSl7K87y3Cbsn6R4s75kiBRJgVHLvmRqs4lXiKreQnBg2Osw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV3PR11MB8556.namprd11.prod.outlook.com (2603:10b6:408:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 12:31:22 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 12:31:22 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
        Christoph Boehmwalder <christoph.boehmwalder@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: Re: [PATCH 0/1] drbd: fix false positive resync throttling (in-tree 8.4)
Date: Fri, 15 May 2026 15:30:34 +0300
Message-ID: <20260515123036.286798-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513163905.562722-1-ionut.nechita@windriver.com>
References: <20260513163905.562722-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI4PEPF00000148.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::88b) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV3PR11MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fed4c2-5418-481a-459c-08deb27ddeed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014|18002099003|56012099003|22082099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	B4xur1fTZ2AyhvrFr0enGzys6DZazXZ/1hmZCG0hC3NJicFBjfi5F/A5eamlDdrozwReU9KYCxN2Hjpz3P+2bR8JjwvrIySI2ZUwpecYZwpJEvs95YM9xz/TWcxv/OYfyXzfaOgmiXCR+kMlx4jnwWtzdvhid+C1cRiaxbiHzEQQL8+gauduDkHooPvKfMOnGK9qtYEO50HZ7z/OzA6zjQeEcVyazwaMDZxUqRfay9nlr2TRakJrS/ERCm/LHk6oB9RQWtH9gU3swUavdLRgMrQNqY2unDn3CImVzl+Wz8ec7Mlor7HTsE0OMRB99mi/rOVSgj+BP8YjsLS2YXHvOmyFOPUwccK6HZ6j6uDGGsWpm+7ReTP/Y/rlckvMUg7UFTprDbcLLttHLX45Fi6Y597wsBl1l6qzAAJWtVAs0Ci7YLpoB5J7AtyTwZdMwLyBujnOtTgs0W3Bq+T4d9VrhfmlfgSJVmN0CYC5PDkN0cmDPX3Z5868JHJmec9Nwg27SSZOYDIBX1O+S+Yw+opv/Gp1SYOXrWStjOujrMkDkKi9bDEr5krx9p7kzuZ9ssHDiXoDsu+MOJJP/pyIVKQx9jkq9kgoOJgC8n8OYvJdW7dcEURyz1LKUWg16u8AJjJmQKSzAwejO43eGc3zBIJq4441xULz/vhCl3+gW0w9XHLjT5P/7Ref7q/PfZ7RFOU9Yo2latz71o2il2TG1A6s4O8Mn6+o9bP0pFfRUrQnf79t+qn1m3rFNO/rip73Y6Tb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014)(18002099003)(56012099003)(22082099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWtqd01BVUJhTXNkbDkyUEl3YXg2WkNQRk80R0hXZXovRFdYYXBIZWNmOE44?=
 =?utf-8?B?YTNFUFNxaFh3UjFzUk96cUlINjRIUDFNL3ZuY05NaDBZMnVmRFdtL2pab3NO?=
 =?utf-8?B?VnJRUklGS3dUTEZMUU85WmpuY3dOd2o4Zlc5NmYzZ25TUWlIVmFnTlF0RzQr?=
 =?utf-8?B?Nnh4cGNPa2NuV1dYV01lUG12UDc5WGtQVUovYlhhQTdjV1lVSE1XaFJNbVhh?=
 =?utf-8?B?UUQvdVBrbDRZUFJlaXJBWFo2QUZUT3hhODROQ3hLT0tLWXUxQVpWSVBYNkhH?=
 =?utf-8?B?VWVicWFub2M5dHU3bUI0SmgwM0V6SnhTNHNzVjdDVzN0RG1aeGFnLy9GYzNI?=
 =?utf-8?B?WlJwcmRacU5yYlRxU3BIS1JZcWY2OEVkNUVlL0V4ak5yRmVNZW1rQ2d5dExq?=
 =?utf-8?B?MmdQSkdEc2lZZGZ4MWdFSXc0U0VUYWlpL2V2WGI5R2IwUGRJSndLeTNBdFph?=
 =?utf-8?B?bVVIankvbXgzUjI4Wjk4dWtvc0FHcmNpS0dOdlNKdzRjNVFsZTZPYVpEaUtk?=
 =?utf-8?B?aXZYbjFUTForYTF3dlJyWGhDTzNwOEVrNERWRUxJSndDY29MVTdENC9qTzFY?=
 =?utf-8?B?SGVod0pHcHlYWlZnbzJESXR3OHJMZXdQd1k2M1NNZDV6RFFoRHlIY3d0aFgw?=
 =?utf-8?B?bTJTVCs4MW90cGVSSE9BeGMrWTk5K28yU3JWcnpuTldIS0NKaWNnVG9qOGdK?=
 =?utf-8?B?SCt4QkRXSG5XL0pXM3RYV1JHcFcyOTBWajVkMzhKTHBlOXpNanhVMWovMHJ5?=
 =?utf-8?B?OEpVdENDL1g4K3FjUkVNODNDVko0Ky8zaUVKYTV4SytwSzkzRmIyZVZIeERu?=
 =?utf-8?B?cURHTGxieDFJL0lCWDRLaFB0dTFkZk1sNmt2dGhBYVNBa2NLRSs3UnJ2ZkJs?=
 =?utf-8?B?R2xwc2xtTzFOQzI1UmdMMzRwbTloL211QUJNcVVHTWQrUzZaQ2NBMjFadGZO?=
 =?utf-8?B?bENRM3pvNC9mOXFMUVZiRTA0aDBUZ2JzakFFUFBzVllReHJSSGJ1LzZiSkVP?=
 =?utf-8?B?dnJJTkFwdGRkV3ZJT1ZnQjZwd3RFNUpHYk5sMVZMYUZDbHowb0FRWWJYZ3hP?=
 =?utf-8?B?a0hzdTBGN25SbEJ2MmZCYWJzYmNkUDNndzdpZG1McEZmcGFXOEFFUFhLS0Rl?=
 =?utf-8?B?LzV4T2hkVUU2Ti81NXV2blovOVBxbkFBVmhuR2xYKzVqZjhldDR1blBydFZn?=
 =?utf-8?B?c0xaMkxHbk1ZS0FyWHJraWRjVDVrQzFhU3lkZ0J4MTIvQzVxLzR2bCt1V0dW?=
 =?utf-8?B?a3BnazVFRTMxM0hyNU5hS1Q0VmlzTEtjS0s3N1dENzlQN2hJbXlFN2dTdlUx?=
 =?utf-8?B?bFFLaXhaSTFLUUw3c0ZrNWxnVmY0akJNemFJK0JkU2hLZjM3c3ZqREdScGl2?=
 =?utf-8?B?cEV1cVRhbS96WlU5UnFsdVRMSmFYRzdmSUpRTXhqOEdRbUNHcVhBdDViUkp5?=
 =?utf-8?B?ZWJmb1JVMk9yZUtFSzNvWkZzeDFFK1BsdTMxSEZvbWkyZGl6Q09Yc1VKRW1H?=
 =?utf-8?B?cEpCTWNrTmtpMFYrMURaMzhwTFloYnhaS0NxVXp3dXNFZUhsRkRKektjb3VH?=
 =?utf-8?B?ZnVmZ0lDRS93UUdSaHI5K1BrZjRlS0Z5Z1V0M0hDOWNTUFVkOG51VHoyQ3FC?=
 =?utf-8?B?YXRTUXVTSlFXNXpoVkp0NXdxbHdTQ3ZWUkVqNkpVSnN1SzNkUTVOcDZkbU1R?=
 =?utf-8?B?NUZnRi94UzlTblZIbnNObWwwcytoaWtOSWFSMXhxTzlDSkk0K3pvL2p5bjR5?=
 =?utf-8?B?anYxbytKdTFTcXR2YjQwSzgxdEdnRkRlSk1YdWxKa3B0ZDM1c1ZiUjEzRFlM?=
 =?utf-8?B?OHI0UDJiS1p0elFxd3NRdFRvY1FqSHlaL1Z3c1ZtWWlieVZONVJEblJYbWR0?=
 =?utf-8?B?aUxMU016RXlEOUI3dkJBWnFqYXZzSGk0REM0c05pSWlGYkRCSFBzNWwrcUZK?=
 =?utf-8?B?UU9VRWNIMlB2c0VMdUNsVCtQaXdCTll2bmQwSFJOU2Rtd1BTSXcxb1V2ZndD?=
 =?utf-8?B?amhuRVhCeHpvSXgvSEU0RmhUYXRBd3FPek9qeUVWUWhTZ1NXanhLODNjbU5Z?=
 =?utf-8?B?NzNlR1c3NXRncW9oVUN6SGIraG5nZDFWemZSR2dlaUNCSGkwQTYyZzBzSVF2?=
 =?utf-8?B?UG95TFZsRnd3Njd1V00zWS84UDkzSUc1cWtvZ2JiMXhBeWJTc2FqRkhTRFBX?=
 =?utf-8?B?N0Jyek1VQ2RveENsd1NNaGx6OE1xS2dLR1kwbzUrbitpUkgwZWFZb3hPZ3BJ?=
 =?utf-8?B?WHhwRlFhLytuSk9IQlBUdGxpUm9idEN1TWQwVlhPQ2paSnJMVlZZZmVMZEM1?=
 =?utf-8?B?SDladWlWcW5wczB2amY4Vk5jVTdIMnFVenM1RjZLeWZWb2lLTVZzYU9SaHI5?=
 =?utf-8?Q?KEBmj1AiOKKhn6UI=3D?=
X-Exchange-RoutingPolicyChecked:
	A29OLPRQ8eB5DPgC+BfmgiFmB+e9UG9EYSW2TXO9hExwX61enUuHZ5w/jOPeyLmrpqxbHUCyESwFEt3yjUfU9Quj8Q4hhhWWLgJOWikHYZDzbpJG7+SVkFD0z2kufAaHqboYe2oqdFhejJCHtWcfEpvmGv/XcV5URvHwI/4TTavSvdlPaazY/EXzFRC0IbJ3ojdkptixeexSZWOhWMkvMnmVAtL90N2xOPHz1Hf4CC874Sq/+k/ADsJSDjtKKzZe3Q0j+2ySkfIaTRyh/Y6ZzWpU2BCZ/BU3phT4C4CjTP0yUtHl7mkV+r59+U3vklW2rIOBDuAFMk4hU40dLI1WxQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fed4c2-5418-481a-459c-08deb27ddeed
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 12:31:22.1367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0O6JW4z7cDCrMvzPYPGJnvGQZY05HfIICkkFlQXN5bHL/jhFnLjxjgwCGtB+NS3t4wBsaP3ttO+Pk7UaLz8v3GpTUBHUefUF7YpSNxZYGiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8556
X-Proofpoint-GUID: ITWx0DeGngsB_coTCkUuefWcwGw5NzrR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyNyBTYWx0ZWRfX1NjSWe6VTqan
 h4Fxn5r55F52XHleJNpKGQtGxDZ544GYoJr/fMMebNuSP9hm2oqAMbgRweD1p8s01vygEEtEAlg
 8rLFhbMOR00LwIwQ+TDpa0YlvljCxtCeqNSCNza5fh9SfOttCV7GU322ORYwE1IG8oQisRCjWTm
 X2Ha5m2xZ0lUAIzMNhjKl7l1zswpaHxDQpv4AbYHZgCi9bErML9TCW37gpmTPXfi8Lw0K2ImN0R
 VGXZo1rh+AEuaTKenAhG9uV6GEt9W98aRAO1u8csqpLaGZfL10CVzNqB9tJQjdOU9YrG5feaOpA
 jBOd6rNWIta97JMK0pD0u184MaAVyT1w5BFFCme/IvsB0EMPsy2aVBATqjW7NCtxZQVobmZVcou
 ZGEoq9qeBhT+xlJ5AI6lG8YG9/X6P4A651aisZbTMCIIJ7s5fbz1bi440tC5jnLVTJHzLPBkW43
 OjHJIIZ/dSh8ca49yqg==
X-Authority-Analysis: v=2.4 cv=ZYUt8MVA c=1 sm=1 tr=0 ts=6a07121d cx=c_pps
 a=6XSCBLYFY2RPGp+89yprvQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=t7CeM3EgAAAA:8 a=8Agna--pecVBTFzI4fQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ITWx0DeGngsB_coTCkUuefWcwGw5NzrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150127

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Philipp, Christoph,

Friendly ping on this patch. We are planning to integrate it into our
next release and our engineering team asked whether you could provide
a brief risk assessment or a Reviewed-by tag for the in-tree 8.4
backport.

To summarize the risk profile from our side:

- The change is confined to drbd_rs_c_min_rate_throttle() — only the
  throttle decision, no data path or replication protocol changes.
- Worst-case failure mode (ap_bio_cnt not reflecting reality) is
  equivalent to c-min-rate=0, which is already a supported config.
- The approach is identical to what drbd 9.x already uses.

Could you confirm the patch is correct as-is, or provide a Reviewed-by
/ Acked-by if you're comfortable with it?  If there are any concerns
or suggested changes, happy to spin a v3.

Thanks,
Ionut
