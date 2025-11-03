Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780F302CC0
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169228; cv=fail; b=JlRIby7ozHxRhTT998KLsq3aJf2GMBALL6wAzch5YvGMyNDLuyEuGpOQEKYD38m+r7D2K+a9U0G5NKteoxGzgR4CI3cquuHO1heK1ys7LThkijYJx06DE/saO9Vpptd0m2gLSaVV9Ci78RRoV/YuORgnmRPzOr8d5min0rF+7G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169228; c=relaxed/simple;
	bh=PPzl1QwQeEbxcQqamso1oizHYyyTPyFmdmqgLf2Gx3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MkhZIS4unbtM4VFn4kVVOkdORQJw7rjwHQH6Zgx6uj8yMhYEjf7+dtvW1Mstns0h4fJY5rrF4VkTNuligAPmwLbgKlydpACZwbLnAKR7PUmsXfJauysUqwGhFds/jBi4t5wQp7LmEkuJCq54El1U/kwNTqdIFbDaqegvHBAZS7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pVAYL6+K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IjLinrvm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pVAYL6+K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IjLinrvm"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3B03G2004895;
	Mon, 3 Nov 2025 11:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AJG1w+veorI1RbnXb0hG63n+Jtw6CxYbcF9nph2jClI=; b=
	pVAYL6+KX1lojI88aCGEQD3+ZQYjP2ir02tzMmhYVjCMSJnkJgA1Da0pgqlVbntY
	hizN0ATdBUii2uL0XNnLOcjUIyJLfMHdaRm2fl1MhBoKO6excqmXR0fnrwfiPb7Q
	HxhCqZu6PxUxVLTTms0eW5RfTElvSF18KWQI9fAs7FY4OeWSPjZQk64vHn4TXsRC
	veeS0SFpHAmcbD8N83NRDb6NJGLXsdrU2KOkMO8UXkBy+MEEA5ie7iJ+xhQe4UXe
	rxxJCku96+R9pO0MxyZ7UJ1W1/pi9NL6fOttc+fepOY8nkRaELP8Z0cDM2WduAY+
	G62EL1Pumm1fnLn6i0nGSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6u4gr1vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 11:27:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A39QSH9010193;
	Mon, 3 Nov 2025 11:27:01 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbha3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 11:27:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w74UWyUpwbcUKdPdvZSKQFXzaUjxnuWWYAsju6frEV4QtnoJuQoNcfCKuIML46FFoKLvld/LBzYAipBg2JWyTtHHXK6rFrzhCzdm5+kwhXIdHQLkW6XCTLpqQxeohqzl75AMqOX5xfSx+WQ6Px409MjHRbSZZmClMGuJSqtBJ5VrOwQhuFsHirVV2qI0x/ZENDq65LJ8Czf6BXmnRpFciNhG1AFB+s+WU+HghT8AGnO+H59V1kfSU1X/KG1aS3Fz8nQbkwg3kD2gV3K+EqQ+cYb3GdTlNYTUNVCT2tyDzRcyLQ+Tj6s83Opa8oT31K3IAIxgLyGMu9kR/7jYnDDOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJG1w+veorI1RbnXb0hG63n+Jtw6CxYbcF9nph2jClI=;
 b=vrEk77b+QQeYvIqPy5pMveYysGGkiJ57uOKTY+OBbpmFPJ6UDofTzC4Do2rolKrHyYmu02il2V9ZZlMwnlpkEbwlOxQGJX0+mG9kzmCRUXFXDzphMFtA1RC5ubuC+rTd5K/+Q449Va8mgr1gRY8XWVPV0st4OTidFuQ/pJ1XZSoQJplou4SsR4H8npBjeJ83ImesXIagzrBiB0yxKRnGqCuOgCoMKuHYlM9HfqTy4VyP4ZlK9ALAlWJsFb96sBh60WD54bGn+8vjKyCUlfBRUR89BH3vQlJCVnhX7f8DGvO+n6ljrk7zKi56AQkWeVp6vWn0sil1XTxonOUGIkTrYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJG1w+veorI1RbnXb0hG63n+Jtw6CxYbcF9nph2jClI=;
 b=IjLinrvmVtgDyKTh5diVsubMyEs9wXZJv0zi7XqGSOy0D8IHsqwh5sXzBdF5VOvhtvUP2mLmYOkdpeSOFj4iULHJx3E42Fzc7BUjk1Cd7viTnG6LZzWdDfGK4z09ZCWYgJT56CSEuedODsWKW80HrCPVBWCXQUD+eblvE4ICFYA=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS7PR10MB5119.namprd10.prod.outlook.com (2603:10b6:5:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 11:26:58 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 11:26:58 +0000
Message-ID: <65386bdd-6cd9-44ff-9c43-2e9343f6ced9@oracle.com>
Date: Mon, 3 Nov 2025 11:26:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: blocking mempool_alloc doesn't fail
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org
References: <20251103101653.2083310-1-hch@lst.de>
 <20251103101653.2083310-2-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251103101653.2083310-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0331.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::31) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS7PR10MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: c57de30c-c621-4437-3596-08de1acbe686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnRzajlVWFN2TEM5OHpsK2VIdE1DVVowNlFrckFXem5uMkpVUG1wbHZtZ0J4?=
 =?utf-8?B?NUFOTjFQdGNlVCtkbmhOMk4rb2FXdjZSZzViSGlBaUVIOVA0SUZzdzdnQ1RQ?=
 =?utf-8?B?VjhMVCtCOXBTcmlxTlpMbnVXWC9mZWxpcnNqTEhzL0t5MlBIc1pGY3lFWlhy?=
 =?utf-8?B?YXBzYXBpSDJ5UmRUL1dBdnpTc1lJQUhCVktURG5lM2VCZjVydE5CcnJBY09W?=
 =?utf-8?B?NTBlK3pYbDcyeURiYytxWEtwOWxseVFWOVEzcmt3L0lxZTRNOUV3cFhVRWFU?=
 =?utf-8?B?b3ovcUsvaW9qaU1wZmdkSzBxaUk5RHhYMkw1QVNqQTBWWWRZenAyS0l4R0ZN?=
 =?utf-8?B?Z213NE1JTzBDZ21yTk9TeFNoR0tVMEJsRXhRTGtMeTd5c0MzdTJhNVpGTjlx?=
 =?utf-8?B?aEtseFBXenB3WHY2dEM0VWUzVEc1QkxZRTE1djhkVjRYTUxlTXdmMlNsM0hx?=
 =?utf-8?B?a3VabGVCVVREenA4UWJ4M2t1MW5Xd1pVbEJNUUdTMGRCQXo4Nys3NXRpNjZ4?=
 =?utf-8?B?ekxqcnAzOElKTjNSYmRDMW95NmMrRlluMG9SNGxORGRPYjVhOVF6V3BnSU16?=
 =?utf-8?B?cFg0UTQ0bWVRdHRjaDM5Qkc2SkJ4RHVyTUdwMWJZNXhQQkVUYjFPTm9uZTUv?=
 =?utf-8?B?dHppVUc4bnFoSHFvZkNOYjBHSW8vQklXZ0s5V1VpWVljaEVydWdRdUlMcW9l?=
 =?utf-8?B?N0wzUXRWczJXWTkxcXpPK2tYMGtzLytOZ1VwRC82akZCSnp6RlRXZnl6Z0x3?=
 =?utf-8?B?Tmt1STNCM1NDbXJtYm9DVjdLY1d3cFU2QStVSkZ5SFdpajd1MFpTNHMvZG9T?=
 =?utf-8?B?UHpYckFXU2VBZzV6K1E0aTlEWFMvdWFGYzRBWkRvc0IzZkVkV2VGODl2UkNr?=
 =?utf-8?B?ZkcvWWI0SWs4MDdJSW5sVjNick5UOFlINllob3pMQXJoTTBYLzVYQnBQU0NS?=
 =?utf-8?B?alVtd1F3WENURHRHUnFYdEFBMUFscTFDc3MxRGVBc1BqUXpVRkJxK2RIc0pv?=
 =?utf-8?B?TWhGSis1ZEdaRUpFY2Rhd0dYVG1nMW9USWN4Vms5QlV6UDVJMVYvWk1BZUdT?=
 =?utf-8?B?QkNxREdWb2xyaVJoVCtqUVFYZDN5WUxqRm94YVA4OGloSXpWUlZEL0o2bDdw?=
 =?utf-8?B?WmdTeTZHcHVTYUpFd05kWFB2MUpITGZud0pYcDhxOFhOVEkyTGUxcWdsZXBP?=
 =?utf-8?B?dFpjTVQzWjZTUDRTMkE2WDBaVDRnVVB5N3l1OXlDSmNMa0ZnSlByMDd2d1Jy?=
 =?utf-8?B?b1NwVkdxTU5ta1AwdGdDdDcyMWJwc1UrUVBMSXFqRXNSUTRta295SDZqZnJP?=
 =?utf-8?B?M0lZT2hzeXhzaUh6cjZxU2xzSjNmSFZLYlA3em1BSlhtU1ZCQWZpeWFvSnpl?=
 =?utf-8?B?YUpFWUpVamlMUzI5UE1mYmJBb0xkZVgxYnY3NDduTmZLZjJ3SE81MnVwN2ZY?=
 =?utf-8?B?QVRudWFqcE5QOGtMVUNTWXlrQys4UzFPbWhlSWI0SkJ6dEpnNDM1MmJnS3VC?=
 =?utf-8?B?RGMrMzlqOFMraEFweGlIKy9HV0EzdUYvendBYURZRDBmTU1kOFE1WEtQS2dZ?=
 =?utf-8?B?ZU5rcEFBZDdVcnFwRTZiR09ZRWlIM0U3ZGZqK3Vjb2h1amg4S1dTTlBlUUQz?=
 =?utf-8?B?dmhyeTI1d2s4TXJUbDg2WDhuOHdTYXE5R3kvY1hpcWk1N1NDT3VMT00zR2Np?=
 =?utf-8?B?ZEJlK1B3UUdkdUdkM0dObDc5LzNaVkUvdkNSL1RoNzNiUkhFUkdQUVQrb2p5?=
 =?utf-8?B?RVU4TjVJSmI2NElETktyblAyakVnZnZIbmFkUGJHcUNuaElFaGgxRVBXRDdK?=
 =?utf-8?B?ZkJCeDl6dkI2UWovd3cxazc1ZXBHRGF4LzBQY0orRWNrcjBpb3gydUtOSXFF?=
 =?utf-8?B?ZTRrdTg2emd6MHcvVnFRblVROEdTVGZuNU1NaHdwM2ZGRVRVTi9zNThJaWNI?=
 =?utf-8?Q?//qfutPGfkMtOeUxNIhrF/ja0uLjE3z0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHRUOXZONUJOeWNZeEVISmk0SGVtcUt4TEg5Tm5CTVJ3YXZ6L2dmTzU2dnAv?=
 =?utf-8?B?ZFgzTWZNZjBFTVlscXRhc09rcGZXSE5XVm1mK0ZpMHB5Y3o4Y2dGSU5remRm?=
 =?utf-8?B?OEFsbTk1QXA0djhsdDNwUXN4cFpZTFNLb2RRajU4M0hxUU8xQXVMYXVzQmRF?=
 =?utf-8?B?T2R6T3NPRTNTMzdQNXVha2E2VkRyOEhlMzkwZVpzYU5SYkh0VWZaMFYyUG1p?=
 =?utf-8?B?T1RsUitVSG9GMjl6alAwbHRQQkwzeHRQZU8xRVFnbDhjVjNSSkxaZWozeGFu?=
 =?utf-8?B?QUdUL0NPUlQ4S3EzT0hDUXhpUTZvNFpqdHIxTXllLzFqOWowS2tZR3Q2YVA4?=
 =?utf-8?B?bzFWd1U4eDJvRDNWYUZJWXZrZnBEUmdTMVRNcG45OWdkcHRIemp6NDJaTEVY?=
 =?utf-8?B?enlBYUxKRFNPUDlNUEluT3BVaUJoRkpKZFNGTGdySFFMK2lnVEZLUjc3MGxR?=
 =?utf-8?B?dndrNnVZNG9ZQkNmR0VHQXlQOGtrRC9LUkZ5QlhFUDdXZERWUHJQcVF0U3pV?=
 =?utf-8?B?Y1FERU8yQnVhb3JidXJ4QWZ4RVZFQ0preWF2cnkvaHZLNEM0ZEl0WWZSRFJh?=
 =?utf-8?B?NWZaQTJFekRkeHJrZjlIK3J1NTVUSlNpT2hMSitxcUdOdHZTeDc4M2V5b25L?=
 =?utf-8?B?NGg2SWVjMUx1bFUyVlJaSlBPZlBtVWdCaUNqNW9VL2RBNG0vSTFNVGd6Y3ZH?=
 =?utf-8?B?d3UvVjlTYkpjYUZVZEVNSWhTbTljQy8vQ2V5OWdmT25HZXpHQ2NWQlRPdlg4?=
 =?utf-8?B?Z0grZHJmS1VleEg3Q0tEUlZtTTRjT0tBTzdLNFZTUkUvbDlwS3RVTGlVNDFz?=
 =?utf-8?B?ZTdtREY1am1xVVNLZndySU10aGQzMCtXbXcyZU5uajRYUXBRVnZrc0doTWpj?=
 =?utf-8?B?c1c2MG1raFBqZ0M3WEhYOFZvaU0waHZGalRoSm5JMnlkOXVWaWM5VFNsSktS?=
 =?utf-8?B?T0J4cWlEOFhxdnRuVWtZNEdJSG0xei9uY1FVQjArZU5FM3lYdTZDQ0ZrYjVi?=
 =?utf-8?B?VForUGtqbnh3MXNnc1dtR000QWY4MjIxUzd1TGNRN2FkWGdKQVBVYmY4c1ZM?=
 =?utf-8?B?QnhlSlF1WURzOEdDLzJMdksvMVo3NUNFK1Joa2pVVWMzcjJlczZjWHNQcElR?=
 =?utf-8?B?M3ZoYXRmZmVpYzREd2xTbTBnK0tNWXdkaEh3QnhxUHYyUVVTUXlPQUZRRlhi?=
 =?utf-8?B?d1g0aVU4TTRTUjFwUjQ0eDJjSnQzc09VR1c3Tkppc1ZubjRoUGxVY0R6ek53?=
 =?utf-8?B?NDdMRFhDdmpZNGw4TTNROWFwZXdpaTIrdS9IU0JlQnRwU1pYek82MFc4dHM0?=
 =?utf-8?B?K2ZnQ3RqcmZsSE14bk9YZW5WSmxkbkFLeWFEKzZHK0JSYS9FZkpIOTNVTExQ?=
 =?utf-8?B?SDVSbFlOZnJPUGJnVkUrSnFTZXNwc2d3UytVaERweHdHTnlVenhseVlrQTlY?=
 =?utf-8?B?ZTFiaElpRThnNDZWd3BadE5Hd1drdEU5ck5VeHdHR0NETFU0c1cxZTRTYW5r?=
 =?utf-8?B?VnRaeW85bmp5WXVBVTFEUlZibEhXT1dRb0N1YmpvSEJ1dEJ6Q2Z1ZGtrU0x4?=
 =?utf-8?B?RjlyMnlKU0ZiUXMveHB2ZHBSeU1RYXJhWVhITDJFN3ZZZTFpUnV1QThVOXNq?=
 =?utf-8?B?UTFSOExFNUJPYkNvVTg1VnF3TjZxMGxqMUtwa3JKeDR5RG50cDcvL0ljN2pN?=
 =?utf-8?B?RDNyN1d5UDl4R2FueUtuRDFOMjBFMnpkNko1L2JGbGd6a1h6U2Jqbk83SXd1?=
 =?utf-8?B?MkxQMnY5c2ZpVGgyeWxYT1RXQmlNbHh4UGNab1ZER2dDUm9kTFFMV3AxVHNp?=
 =?utf-8?B?SHFESWJ2RVpJV0xOWTRPV204dkNQRm56WndrMFp0Q2NtSW1WeEp1M2lHa1F2?=
 =?utf-8?B?dW5ENzZHSTN1V1BFVy9obHBQdkxsVFFMd3EvMFlNTmwyblY1TS80d1ViN0Fr?=
 =?utf-8?B?QU5yT3NqK1dCZmdLd08yaURMY0VQKzlBbGRrNGV4QldERXo4WmlJNWQ1M3dz?=
 =?utf-8?B?bjdyRlpuK0ZMc1kzalMwVFQrRVMzRmFUb25QZnJXdWdBQXAxTENMbktabUJh?=
 =?utf-8?B?RjdvQnRKYUNKUnQ4TXFFdWxXUVVVUmRXdXpyaVlXeXJsMk1zSDB5VjZTVVla?=
 =?utf-8?B?c3lzWWFRN0FPTmovblJKWjRkUXFDV2ZSdGo3TjVaSjk5U2dSVytiMzREOTlH?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pDykW18rFUfmuJ1a+C1O1OkXjE5Tbov9ka3YXS+GuxRGt7p6gMAu+Ql31fq+6kK0GXz01+fy63dpYbUjnfVSaLGFFnY86paALD7fOuQuv1lhtrxq+aTRZohKKf/uwxTje+FdaZ0dCx5aLSaogXT7siU2Sx4HDIECP1m3aPwkP119zqhql+LzLYWDoJeb3/VeOgQoEdTKYb0r9FBNXKmbghQpHXpDEFTgX3k/dnzrNZjccCK5PpqImwV5ShUr1gn6dAnebkV1jTN54AmA7rKjqBQ+RnivKaxveOQgSkqKiqKDnFODqX47AbzNulWRzknNPFuB8P1joOxzKESk/rlYqx9T9khtwyFuDGRtqdsD9UNPE3fp6F8x6n7vNYwqKnDykxf1KFWK2RpwPUl1Pz4pBjTQXvltW5rzo2TNMM//PqKvIheiafwQvnE0BXyw6Tqlihv7EvwI6OSKDfqu42WB4s/1rtPdU7KyXZQjOKTOK+9ZFaUAOUOSkSkfMhMOkyO1/2Yuz4lT04b42aYiaCTNrCHevNQaqkVkrph7nFrKFgHmHYOQoePon3dDkxp9q1IzMuyZmUYwkiAvJph2QA+Qg/dr3A/az8iUZ9EYzEaMDHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57de30c-c621-4437-3596-08de1acbe686
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 11:26:58.2789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhVsPbokFnzmEEswDK8VYNQojSmpOVl1hNkqhD5S6zKvwKVc2vX1SR1Q8Y65evoJwz4fvnqANA5yy8nsMj/V4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030104
X-Proofpoint-GUID: crUPfi6CrnY3cAFKPf5bgoGwJfQt8K9V
X-Proofpoint-ORIG-GUID: crUPfi6CrnY3cAFKPf5bgoGwJfQt8K9V
X-Authority-Analysis: v=2.4 cv=WtMm8Nfv c=1 sm=1 tr=0 ts=69089186 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=FSRSA_bIkzERjJDGtNgA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13657
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwMCBTYWx0ZWRfX6IYI3bMOnTJu
 KmA6aA/gCYsJRocj6s0SYwz0v3rYzdGc2H1jb/09M1AQO+x8fjWyzZRFpvPS4oH9X3zm5bwv6zd
 kLSk9dUD6tWmb63buE3wSmflGrAl2Na59HYhYvl/ouzT+ucZzNoQFOIHAq1kDgNdFkEPqNXTYq3
 IpGGMj68NYE1y2IJnYPSkmksOjRWYv7kB5DSoVnYV0TkALC9BI1fKQUn8LMwwfJGTyLb/NhDAV1
 HsHyblJBqFpUDD/zuDGX1USKc31S9bYHlm41zjesdThGbOOTmolNfED8o47/337rYsc+rO0lB2z
 ABrVYeJ+Edh7AcKKVVOxasEwic3UpZ2HHhU63GDmn6suzf9TKuR2JZ6boPJ8gYZ0/1DoNBqb6fz
 q18OXIBhJNFYjMLGsMXRH4cZeVfBUQGf1c7+We073yUpvhJc5LU=

On 03/11/2025 10:16, Christoph Hellwig wrote:
> So remove the error check for it in bio_integrity_prep.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>   block/bio-integrity-auto.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
> index 687952f63bbb..2f4a244749ac 100644
> --- a/block/bio-integrity-auto.c
> +++ b/block/bio-integrity-auto.c
> @@ -158,8 +158,6 @@ bool bio_integrity_prep(struct bio *bio)
>   	if (!buf)
>   		goto err_end_io;
>   	bid = mempool_alloc(&bid_pool, GFP_NOIO);
> -	if (!bid)
> -		goto err_free_buf;
>   	bio_integrity_init(bio, &bid->bip, &bid->bvec, 1);
>   
>   	bid->bio = bio;
> @@ -187,8 +185,6 @@ bool bio_integrity_prep(struct bio *bio)
>   		bid->saved_bio_iter = bio->bi_iter;
>   	return true;
>   
> -err_free_buf:
> -	kfree(buf);

Is the original error handling code correct?

I would assume that if the call to bio_integrity_add_page() fails (when 
it returns < len), then we should free buf (which does not happen).

Anyway, I see that this code is being changed in the next patch...

>   err_end_io:
>   	bio->bi_status = BLK_STS_RESOURCE;
>   	bio_endio(bio);

