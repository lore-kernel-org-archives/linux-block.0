Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506B305940
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812594; cv=fail; b=uTk7oxpHl5OrTNhvLkw9H6wUugadU8J08K/hbbRwk0/ubkf6WdWWTwJ82PwZvfMB801FXLeFcBFQwj/LkSvUzOxlIX6XXcM8nPxFjI3Bsgs3ZVmRFqGiS5n5glNNNB0orIvbn5FmkgLUwh4y+ZAaikCObtk27QVXycOoAoCbWac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812594; c=relaxed/simple;
	bh=2dyFMgGnpvEpEiPhGNp/r5yUD/8VtkJ77ZEHyC2hTA8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PUAE7Ibj6PCLqjmQdXdc/tqpHCEoA4IVZ8kLOe9XFydI384zgB/AjzLrvUbCgq37xCOgPdMMa3LJFtjj1E2RYm/x5vbbKCxt4MQOsUl8aQhcX9ZIlx3mKcdURr0J1WFDka7dedb/gDlSJ2pB+R8sfyFRN1uIuqpLzKYiP0s3yFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z6qKWnDC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n6EZIs6K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z6qKWnDC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n6EZIs6K"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PEu3tU012159;
	Thu, 25 Sep 2025 15:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Yce4kS+1/eWaF5v7OV3yfkTPVblhFZGdmadFEr7Eyng=; b=
	Z6qKWnDCQWImnYiEhI0Du27zpa3WFcwnpXYFJRHSRs6t4NIIE3AJBszt/5vCm6X2
	U6AhYMZucSGmZJzRicF2kpX61oXtF+wHVQAlNagrMDb4IHm+ZBUKm/m7wcJ4nxN6
	Mr0QtmZmcMiqgD39mTrBijdHfKur1T+S1Z/4gQiyVP4/ZcIm6ovL4fWxH/gOIiRI
	I6xr7MMFKzMnlFI/rOXlnro8DR99jZQdwpuHY0zCI4DzfIa/1BPv3quNI+Rqni3w
	VacWc3Al175R5/WL+s3fpRAOyi4kzpdHlbCED1ArbIApzL2IyL2E/CW9CIOxDcAF
	+nPzgynezQPQ7134yJmjlA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jv1acu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 15:03:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PEdVNo030346;
	Thu, 25 Sep 2025 15:03:10 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jqbc8jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 15:03:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXyDvo3D2n+IWFEzQborMWApM8erlWi4QvOtVmdRfNIf0BSgYG3AYEmzzzAogwX6XFhEGZGUZQ+/GYGhGgDHi+Ge1gb8TJBp7QQdcdFh/Krc0mw4LdVlpO7iyn5En7+0Jd0UvNtpR96np97mj/v0p8Z84v3HoTsb0EiEK+TFKuG2lmalbs26pKxsg4iK3UDstzHcDc9yKd/5es9teGt/AIGWNCDB2WYMJqvWp84SsGgHAsRfzwlCxybjRfUxM4aUW9eqVQOcMv1a3LyyCDFQzP5ixTFOSrV11yHhRjqMdOhsTfCzqLcFobDKjefQT0zqigjkDkSVCZw9OjvM/75nDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yce4kS+1/eWaF5v7OV3yfkTPVblhFZGdmadFEr7Eyng=;
 b=IudrbSza9Vb6ofu1yPcSOnLQXC7yfMngGNIuJSolwXnpAexrb7606zVZ8Ze//UPhLNackUg0TyYumulfhaUFcuzmpKzNy5oBHymD26o0x+bDImxeHfiKndgBUsPGqA7p3x7w6nKB0ubN1ndel/G4ueVyhkTXrJHsNSfkRyRQTUr10Wl2esu6JC6oIpx/kvZfYkZoW8U9I8I4GYKn+Oj+LRzosHgs/D9jzxj1sMoWgQvMLTFR3lHmAsMRxAjdbRJD4eNQ1ljGTgMWZm4icL++qLLDzrxoPQnvIWIrt5Tr3cpNRVpBfcx0EitYrfm8SPITCqnagLpFPbtsniT6SbbyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yce4kS+1/eWaF5v7OV3yfkTPVblhFZGdmadFEr7Eyng=;
 b=n6EZIs6KIOt+wZ5Ln7n1CZMnFXN0uo7Pt6XYS7K6iC3NRj2VUsPpV1wJgXgszz++SOJig8hTy6e52cSNZy8DNImDg3cqjhqPy7rPqZVQ6pc6rAozSrYnCTq1Sicjx9HLB2jtNZIJaxraWJFc+HWjzX2MwC+QV0z2Jf3ZC+HUr+w=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SA1PR10MB6495.namprd10.prod.outlook.com (2603:10b6:806:2b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 15:03:02 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Thu, 25 Sep 2025
 15:03:02 +0000
Message-ID: <49036bee-c254-46d9-8219-a94ef485ad90@oracle.com>
Date: Thu, 25 Sep 2025 16:02:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 6/9] md/003: add NVMe atomic write tests for
 stacked devices
From: John Garry <john.g.garry@oracle.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
 <20250922102433.1586402-7-john.g.garry@oracle.com>
 <zz4lnyno7yejb33tqqi3vpjbvlvj6nceqciclicrkbqaqwt6oq@nyu7dz7xpwaq>
 <5d9a2005-93cb-47b3-a708-e0db50328142@oracle.com>
 <mlkg5dr4ipq5722ye5owxppp7t7drkvcnijcinsryc2fe4t3y6@n7e4l5hc5zo7>
 <1a108930-59b8-4055-a065-25ce8ede25be@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <1a108930-59b8-4055-a065-25ce8ede25be@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0566.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::16) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SA1PR10MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c39e8c2-1e0b-4f73-1e34-08ddfc449fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1RnU1NXUnpXODJ4aVROWUczUW0wUjg0UTZ4bEcwOHlwSGxPam5mVlFweXl6?=
 =?utf-8?B?c3c5WTB0MzkzZE5OSGdEYXF0Q0Z6VEpkckY5QkRYYXE1S3JDUm8wYnNsaXZ6?=
 =?utf-8?B?MU5wOHdCa3d5YXdhd25sRUJ0cTdpY1RlUnh6dTRQQktZTlpqYklIVUZQbkN3?=
 =?utf-8?B?YjBxNStKd1dGZElMRnd1cnZKbjBrWlNSRGNISno5dzRaQ21UL2IwT0tFMHdG?=
 =?utf-8?B?Z1RPZGpScEV2c2kxRFhMVnhhMDFrbStNRUIrOHVLeEtyM0hjMFlMc0kwSlFz?=
 =?utf-8?B?eFJtbzNxOUNlS1BVdHVwS05OUDdBdXRmdlFRc3pTWHVPaVZzemlwYzg5dkN5?=
 =?utf-8?B?S0hsQkZ2V2JodGFtd2RBV2p2R2VUV0pqc1Y0TWw4MmY5Q0grc2dqbWxEUm9N?=
 =?utf-8?B?Mm80TEVvdTNUOXd4dEcxOUNXQ3BZQ2NMNEhJU09WaGRDeUZBOXdITFhBTDZO?=
 =?utf-8?B?V1VtMDY2S1hDY0EzV3pHcXFCQ2pKdFNCYUlzYjgvVEMxQUJEZitmalJ0dk13?=
 =?utf-8?B?a1pFZUNka0hBNW9xZlJlNytzRnN3NytnOEpxWEFsQVJQb3VkUlJNRFZ3Ylg2?=
 =?utf-8?B?dkN2Mm5YWEd6MHE1OVhrd3VuYldTZmV2T1hreWlicmRKUUs1NW5jY1NpVzdM?=
 =?utf-8?B?eXB3RmhyV0gxa2xZQkszOWtCTnFOM2RWWnNLQVQ5VC9SMS80YUlja3p1SkJa?=
 =?utf-8?B?dlVPdjR4cjZHdTZPOCtpVFdTZytGU21kZyt2RDhZY1U1YWFUZXBUQ0FhMUta?=
 =?utf-8?B?WWRoejlCWng2TkNXQ1pQSFF0c2wzaHJidVVyM21tYURYd1FxUFFwL09vVCth?=
 =?utf-8?B?SmU5N3M0ZU55dmlSdHVmVzJZOGJxdFdKckdKblA2OEJIeXRlMnBqZUswanVU?=
 =?utf-8?B?VjdwUVN4U2RqeWtTeGZIeVFuT2llV2QzcVR1aEV4MFU0U0tKTGlMTngwTFZ3?=
 =?utf-8?B?ZkJyQ1pwMmF4MXJobkJlRjNla0pzVlFldmlLS0dRdWdNYkd0SDYvSDl4bG01?=
 =?utf-8?B?Sm84c04rNHNmOXpVektlZjVnMEdDcUJ2YXkwWnE0dTVtR21vUGtLMkRnNGxw?=
 =?utf-8?B?RXE1enA0VllvdHduR2Fjd1dDb09KWlcySjNYd2IrdWFWZ21Odi8waG9BQ2VQ?=
 =?utf-8?B?MThaUG5ZUUFEMFBwd01DY2RnT3hCa2czUG5kZE5KUVJRdmhQRU13alRJd3dH?=
 =?utf-8?B?VElQWmhIZ21pSnBqRGhya0w5Z2EwU1FDTS9YTkF0TlMvRUxyVHVNZGRNOU8w?=
 =?utf-8?B?UlhScFRMcTJRN05qcWFXTUxRTENWaEhyWlVwdkx5YWRmRTZ1dllrNzFHYWYr?=
 =?utf-8?B?MEd2Mko5RlI5TDhxVVBZT0FPR1Y5TnkvcW4rQ2tuTVFQUGU2ZkcwcE1VbG11?=
 =?utf-8?B?ZHdlZXA1TWdMZWViYXV3N3VMeVcvOGc1SDU5NHhoSEtjQ3dGZzNMMERUcllo?=
 =?utf-8?B?SFJjMGlDaVhuNGRZVC91UUxRQ3B4aExobVIrRno1a3RQWU8zWkRXdVIxMURD?=
 =?utf-8?B?OUY3bWc0T2tZb05lVlBUOUc5aldaLy9LOVlKaUxPQ1NERzlPZUdmbU1VTGZX?=
 =?utf-8?B?cGlhZmtNNllFSWFPSnlXNG1kaWNCWGEyS004M3dEVUJPRENkZXhMTS9rZ1U2?=
 =?utf-8?B?UHBzZlJ2QnpXcHU1cVd3cXlLYy81RTdGbHZRQ0xRQlUxR295N3Y3QTBzc3g1?=
 =?utf-8?B?MDRDTmp2dG5JdktVZndSYmV6WEFYam1JbGxjcUUyOWNaZ1JtUjhUWnNzVlJ0?=
 =?utf-8?B?citqcDdnczBSQXErZGJ3YThoRWJjbyt5WllMVWd0V20zVExoWlplSjRqWmpE?=
 =?utf-8?B?SDZsdmFvYlArR3I0bEVCWk8xNmNYZE1Ob2swSW0zT0lPWlVXb1pTd2NKZXBo?=
 =?utf-8?B?dlVmbit1WW0yWEtDMG5OK1VyckhEWTNDbFRDTWp3WUZ0aXNabmpSTFN5cFBu?=
 =?utf-8?Q?IYpuasWzvW0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWhFSzF3YkJrYmpXVlVuN0d3ZEVJVDVHZ0dPdXpHdkxVTWZNNXNyOXJjTjdj?=
 =?utf-8?B?eEgzNWRBRWtTbU0vTFg4VXhYR0d3L3ZVTmR4cThqdTlGcUxtRkpZM0E1a0hz?=
 =?utf-8?B?aUN5bjVnRVBzZnhxbDYwSnlKd0I3dHE5Ty9aNCt6Mng1T280U3hYUDVIajNU?=
 =?utf-8?B?aWNzcDl0NTYxZS8zaU13all0aDBOQUw3U1ZLRHRyaTRoaUpJNTdUZ2NqZGJS?=
 =?utf-8?B?V0hNZHRJR1djU0R0LzBlMXNVdFFUems3cWpDbDRsRHo3cjdFS0xIQmZMNjYv?=
 =?utf-8?B?bXdWSDdQYzFUdVJKVW5FZE5mcitHUk95NE1FN0hMSnNZd0JjSnJVRzBYR2Jx?=
 =?utf-8?B?cG9iSWFGTWtremQzT2NYR3VZaEgzU3hhNzhUWGZNbm5TUDVoTVlzT29NMXlH?=
 =?utf-8?B?U2xKZUJwVWNkSUtmSEg3M0R4MWdDU0lHbkR4QVVtb3lkekpldVkvSGlLcWFY?=
 =?utf-8?B?QWlXRXN0NjF3VUZNNW90V25kbDhPS1V6TUdLTnAxa2h6MktwRmxDc3NHT3Q3?=
 =?utf-8?B?OXpOWitTcG5ZU1pKd3djVEEybzRFdUN3QTNmODFmaFA5a21pQW9ocEVBOFNZ?=
 =?utf-8?B?MzRNMDE1c2h3MU9GM0s5UzBBa3pEK2FZRmUxUHU5eVM4QmpPazZsakc3L3F1?=
 =?utf-8?B?VUhMcDZ6b25RVnRCZm4wNmN3QkY4Wm52TllZZXZhck5JeW1qMXlGejFOaHF1?=
 =?utf-8?B?WWhjMUdWUW12ay9iaXF4R1pZK2w0bEFBbGZqTTBUNXBvWG9iK2pvVmxqb2pv?=
 =?utf-8?B?TTR0ZWI2QzhkWE5zMHlNQ3N5dDc4S0dOUjhXc09WaGZhYWtycnFOY3ZZQUxh?=
 =?utf-8?B?d01hd0dYdUZEQ1d4K29LQXhKT3FYU05nS0FPVGx2cDFPNkN2OFM2UGVqYWpo?=
 =?utf-8?B?andHTHFUaWNhMG1Rc2MyWDdUL0k1SUFEUzhuQ3VWQ2tQL3FXbGtKRVlMRWVX?=
 =?utf-8?B?bE1tbU5sRlc3c0Y0djd6NkdXZmRBVmhBakR6aFUzSDR0dll6ckd3NzkwOFYy?=
 =?utf-8?B?bVM1QTM4YmhaRjhLM3pvWnM5Zm9UWDlUNkRXcjYrNVFTRnRRRnNQdkpCL3ZB?=
 =?utf-8?B?N1dlNWlGS0x1Y1IvUU9IWGxIc3pFby9oR3d5VEp4WGltM0tUVDVOVjgyenBB?=
 =?utf-8?B?MXhxdFZHeWpZeUFidGFvUHhqNUgzOExHOHcyL0huamMzUStnT0hHN0gwcEdS?=
 =?utf-8?B?dDVPZTQ2aWtkWG05RnNvK2psa0xsZEZWb2QxL3ZJWUswaTkzaUFPK2FTQUIw?=
 =?utf-8?B?R2dzUEY2RE4yWjRZZ0lTeHZ2YjdEQ0JtUkoybXpFRXRlNGtHakZza1NXVjhH?=
 =?utf-8?B?YklVbzBpRG9mZlJBbHA1R1VuMGhNdWx3c1RWRG94V3MwWG1IQVR6ZXVJQTRB?=
 =?utf-8?B?Y1FWUy9iSU1QQzFIMDdLN2pEZEV6Y0I4QXpVMXlrcUFPNU1GbTNCdXdJdXhU?=
 =?utf-8?B?bkl5ZFBNS0F3RGdnMTNkbHI1TWlMVXk3M2IvZUtVWXhxek0yTWRYam5DRXli?=
 =?utf-8?B?WTZDVE12S056R0F5dXh5WUkyZlplNjFpNUM4T0EzV0VRdFVnMVV5M0tEaEdP?=
 =?utf-8?B?ZkNIZ1RwTCtuMXpySnI1bGJSTkNmRmovazhzdDV0SzlaWEJZcVVSeGl4YXp3?=
 =?utf-8?B?UTNrR2ZpeXpjenoybzB2YkRpRXBqak5NL3NQNERNOElPQkxtdWdIbmduaFdN?=
 =?utf-8?B?S3ZUNDAzUVlWZ255YVJldFBkL1RhMDV2MXVTYzlXYVUrSWxDNWlzN0tTdGx1?=
 =?utf-8?B?T1o4M3Y0TmVtQjg4K1ZzVlZ2YkQvRTdhcENXRzhOK0hZQm50V0hZMHRxdEx1?=
 =?utf-8?B?VUVCUk9DTzZnQW1BK0JtVlZjUlFENVNuNXF6L2hDdHQwdGh2UmlmUUFLSkFw?=
 =?utf-8?B?OW5MbE5jQ1pVb05hTlNaZDZZMDE3bHJpVktWMmxjSGFvZUxNbzBrbG5jdk9S?=
 =?utf-8?B?SDJZNU5DWmRXQjRIUmVxUForVW1IQTA0VVhrVjFmSkMyVWNsd3hNMHB3WERR?=
 =?utf-8?B?anVIdHlhMVJ5UmdRdi9DVTF4ODlEOGZoakNES1hZazA5L2tYeFM1anppYWFE?=
 =?utf-8?B?Z1RxYkdoQ0tqMzNaRm1JQmJpK01IVDczL3NHTkF3RzBUSGNZY0J2eHM1dFF3?=
 =?utf-8?Q?wOtLZLwUL/yAAJzXQPg21q6gt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nkmaY+9gozIB+bHTSUKJm5OQI/4cc8qgjUzhZCCGS5veE11kln/L9Hs31LkjwPq5O4tPsedsD2FmD5HxSZt24PwWnyQH6D92hnj6iGq5uTe5mUmtAL2Xe6SLVNhIew7/lZq4Hiqr0lAwbe/Kwlof4VpwqZsDELd2Huthy5uEE9IEuyAhQRRR2GP7R5zMrfCOpTb+eiCWxJAiHTVRshlk8+zsmKNRrdDz1iv23bkfryI64LddzkGVXYeR/O+7m+DYRJ8qrXzf9rCt1LKTNcieeRBvUt8ZTa72iPVGjxsCde/BTmhpl8CS9+gMS8fX7OLTISBqA2DFh6K+yPCeFk6FC+I4U26LmaaloIEAj/1G1j362aAli8udPuwS1OBQA+fL4hFcNeDgTT2yvjrdKjLZ/lE7wWTGldYOLshe6Eb96vLG0xkX/90UCFxHOM6ilywVP1Vu7C1SAouK+JYAjExxmTix+e9rH9pfSFIq9Uw6me6pSOK9AU2aca8GGytMHCG0GsCDVJgrXNcltcBVwVFa2zw+l89USyRcZAYlGGq+N+X22OPs/O0YWM5d49QuyxmTqurPceQ17JZT+SPaiJ+wR+tBiwRMytOkAPFWhDKGu2g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c39e8c2-1e0b-4f73-1e34-08ddfc449fc2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 15:03:02.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USoGLsQ4/tO8utiM0JwJDrhVveZcHccN9XUyMMyr2rQM1+6cDSedEEWuXu7V6sbVbkQaQX8o03il5Y9DuypcVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6495
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMyBTYWx0ZWRfX58bneU/Obe+j
 vu0MNdizofvjWeLM2njfsY6HLfjIzxBzUa6xVtWyGp/SmgHModEYxhkuyyhJTJdFujd+aAtcBmN
 NcQF7h29XNq+aGM5l0G0R39pwO8xPInqOG/2CJ2NYuXeMXfB4RRARF+ovEwDmYtlIOfBwAMrv1L
 aFMCjdRgX7N21J/yGby2/XsnWHC/HuavVqnl3eW1AO5x90raEe2jPrzxBOVkBKEEeWlI0UPr8m3
 oYqnb2B06lPV4G8RvqQ9GFcMbbQ0InQ17rtXsobvoAoEvMY2A2KvS1yUzN8Mq3UHrVbPKFp+wWH
 Px3+Nznti5XBFNmDNrFZiRJ12Cs/0npR6tSAqhiEPdWatHRJabWQTJC1A4nJGkh3ax6i10mnPP4
 WHeJ25Ex
X-Proofpoint-GUID: PIE2Vi76jCkpb1PSRKU6KQjWJnil-Hf2
X-Authority-Analysis: v=2.4 cv=YrMPR5YX c=1 sm=1 tr=0 ts=68d559af b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VMD2vbaLSGvuo939_4kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PIE2Vi76jCkpb1PSRKU6KQjWJnil-Hf2

On 25/09/2025 15:14, John Garry wrote:
> On 25/09/2025 15:12, Shinichiro Kawasaki wrote:
>>> Let me know if you have a branch you want to test with all your changes.
>> I did test runs using regular QEMU NVME devices, so I have some 
>> confidence that
>> my changes are good. Your confirmation test on the current blktests 
>> master
>> branch tip will be appreciated.
> 
> Will do today/tomorrow

it works ok for md/002 and md/003, thanks!
