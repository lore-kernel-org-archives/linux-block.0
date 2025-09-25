Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FF339A8
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790005; cv=fail; b=JLMOiRMLftHMjVKfVCtcDWmzA6ra/4N042+pDMfZpoxr0ZQEmEb3HaMWD+tyc+7TVkrQrxtipBosmk0m0seXy3/iFcZo91IgNdMh2TvGrmMhGduvyat91oaR58OUuBoFeHFGUMF6dZiXrEd5ngnyCtirfRGcQuj8nNFzR7TVXwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790005; c=relaxed/simple;
	bh=lgU4/MiQp7Dti1A7IUAZFmAdjpxoC8YBYB5dT5HNgRk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tTpg0TZX7jRbivjDB5dePl720bJ5JJofc9bvOhLnsXI1hnYYlQxdwlzKNZRdoqTIJhvo/+LlLtiXBmTT8lzHS1yYPmFOz5321kn32WEo+9CvZvF3VUiGOOJjZopAagXndxTq8/sxFOQ8Qjmj/bruR2VE/lj577YsqQp1b1ylirA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L/7AgvQB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vRMi3KZY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L/7AgvQB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vRMi3KZY"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P7txG0013862;
	Thu, 25 Sep 2025 08:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BR1uTa50KxBABLpVywYAwbQqHTPHzElQLehyQqqOAsE=; b=
	L/7AgvQBXcmobRAt2JVBDVUQyzmle3VV5juYrvfT4lRAVUodG74JbRPU7Z5EZ8AB
	9ZpEni1u4tygABv00iXK3nBjjQZT2R5Myh8j9vcC06Xddm/IvfmboByitIXk4xQ4
	Bmf90l74VV1H7YDRSkm6UKTxbgrfavjLCFsXIfRKmmpkrl0UFt1rY/dywRS22+wc
	q7jDpi8s9Xsb0UkGyqps5bTX0hKmztwasKf0DLL9BrllkVM25xOpr0Mgcn/eCAXb
	p8GwA1eqOQjtCj0fQiojFPrUWqnFO0kwBdJQmoqaw2I2hjCZk/dGjQJGqo/+DM28
	63rLtLObkmR9eFe1QX4+bQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499kvu1exr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 08:46:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58P7e98C021738;
	Thu, 25 Sep 2025 08:46:41 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 499jqashs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 08:46:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOSevNECVg7A6f8ROB/ciCov8f+e96Q+wAyvyqZ3fPaJ7nI+lTMZSPEw8hLQ2+UiOnNp/ZIgtLxDNiKNoyNKoUf1tFFzFDEOLMBwuGcVd7ee1UHQom/CNXU9Z/lrXb+ms71FgRdYbQNKjOP0xqFkncyxilLpNSpDC4497bNUdIF1P1bXbAEkDzg9Nn9HCMWSEvcmA2O8Q6SHjTu5o6JGWbVmGVHcmiGkyAGJh1VXRQchsuXwkS/9fRix/PeOZo92hyksxYC7P2HjaYk7mYa/zj1ZO2qPWHE9UyFH03tfn109t0TzNd7SqVpQCD3MoMkHq9Ez4xdA+89a1D6qS7W+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR1uTa50KxBABLpVywYAwbQqHTPHzElQLehyQqqOAsE=;
 b=AQ+hl5qmxcj6bb3HPP+0gLZ5fHuqVJNdMWuHs963Ea8p47YkGAATrsJLIVDMD/BKU2CSCzj94RiyU7Qkd6QI5ER+cXpouFGV2vOR29iGdbMKehIqdlzwSU7Vpygls9QjCF1PDZ7Fd8jqsFj/XXaoF08LLQiR/7GxDlqLNW4MlRgDcNAqZrrxKhuDso5aZcQdZg2hnv/6mZ0UwRcFPnkNXD2StD7SoKI/QHWqfUOQYa7bdmVhLrBWjAps+WCT5Zn1bYbXE+6aiZbE4DR+OLvBwUgAA6S8tP76/4/uDpir+7elTqDb5p5JhudXwCJPjmTNyX/nXrhMOWFsz5ztH8pvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR1uTa50KxBABLpVywYAwbQqHTPHzElQLehyQqqOAsE=;
 b=vRMi3KZYe1Nq9PVaJFAFBbGguBeiZGbqRqD0LHhE1m+oS4xSi42Y94wn65U1/HXbhaaBNL5bbZ1BdJFYs0DBFW7UwjWEzpIVSoH8tL9dzVJWJ8qbOvR+iQg3lrMdI3QhwaqNKqbg/FrzX8wOkwn5KWb0WmJgEFJDBjdk6eivyHI=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by PH0PR10MB4456.namprd10.prod.outlook.com (2603:10b6:510:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 08:46:30 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Thu, 25 Sep 2025
 08:46:30 +0000
Message-ID: <5d9a2005-93cb-47b3-a708-e0db50328142@oracle.com>
Date: Thu, 25 Sep 2025 09:46:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 6/9] md/003: add NVMe atomic write tests for
 stacked devices
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
 <20250922102433.1586402-7-john.g.garry@oracle.com>
 <zz4lnyno7yejb33tqqi3vpjbvlvj6nceqciclicrkbqaqwt6oq@nyu7dz7xpwaq>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <zz4lnyno7yejb33tqqi3vpjbvlvj6nceqciclicrkbqaqwt6oq@nyu7dz7xpwaq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::33) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|PH0PR10MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: a51ad9b0-8bed-47f3-215b-08ddfc10056c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3prY0t4bS9Rd3pSMWNRNXYxbWZwWkRDSVRtNWxVZHJQZEIwUjRoWVpJVk9B?=
 =?utf-8?B?aHVMQzk2S05ZZ2svY2d2ZHhDZDd4cGtCTUxIeUUvcjlDL3BSZ0pxNFdpcExP?=
 =?utf-8?B?ekd6WmY3TEd3OU5YWndYZ0J1OFVpdHVxV2RxczVCaGZJekl4NHJyRDJuMVpL?=
 =?utf-8?B?OEdRaTZxWDgzQUFBZzhxTEI3UTB2OEEwTnRaMm5pVmVJSVloRDdXRi9sMExm?=
 =?utf-8?B?Zm9OL1MxeEFhdHNnbVlObm9wTVRyMW1nR0xJSlNKdllOc1dDUG1GclQrUFpj?=
 =?utf-8?B?ZmdTL1V4K0RZK2NMRG9oTkJCUy9ja0c4TythRGFlbjc2UXM0TnRDb1RzaTFZ?=
 =?utf-8?B?L3N2UFdoNU01UHk2TTRCREd5Y2lMVzVMdFh0ZkVvMWFlSm03WWtTcHFpdXBh?=
 =?utf-8?B?aDdwdnZlVkFIVnkwTGVFUVZtTDJqVnhiYk1aSkZNbkVsN09Nb3VwUjdKYWR6?=
 =?utf-8?B?Mm01d1hDbzZjK1BSU0xsc2hiY2hhZ1JIUzZ4bkozSk1LNGJwU0tuN3h3QmRC?=
 =?utf-8?B?azFkeS9INmVZOTIrejI1QVlzR2FCVjRGZzdQVU1QbFg3RXMrT0RIc1Z5Tlhu?=
 =?utf-8?B?ZDVwcUE1bTM3U1dOZzJYTERVM3pZSWkvVW5VQVltcDh1Z0hvWTBwUjdiOEtn?=
 =?utf-8?B?MWdJb2U1SXZqZENURlBscDRGcml4blJrZHM2cHJMcDRXUnFMWStZN3hUeS8x?=
 =?utf-8?B?Wm55R0VlYUtKMkg4SVQyVGhxcGhHaTI3WVlWdzBnZmxLQmJYRStqS1E3Yzgw?=
 =?utf-8?B?Rlh2Y1JjendvNUo1U05MSnAxOUttVkJwd2FBWUNyVHA3Q1llekpWSGt1MmR6?=
 =?utf-8?B?QzR0L2pzem9QWldNUTJaS01vWHo5WUJVTUJQc2t5S29QUElYUUVEYURwMCtV?=
 =?utf-8?B?S0k0OGJpUFpod2xmdWhxdm1kUklqb3M4SDd1VFZxTlJqOTVrbU1TSUZiUEFz?=
 =?utf-8?B?UWN0U0U4TitrRGt4OUY1NjJ1eUR0RVZTWnBXRjZFUjJrZEoyRTE0NDRrY2sx?=
 =?utf-8?B?NGRHbUN4bzBXeldpV1E5RnpyekhRT1N5R0VJZk8wZDhqUDdoTWh4dG96R1Ry?=
 =?utf-8?B?d3U0V0tNQ3hoQ3V5cFJDMGxQTk10NkdYdHRXam1jQ3J6c2pPN0N6R1Znak1l?=
 =?utf-8?B?MHpBSUFha1RXMWppdHY4SXJqamY4ZlhhSCtackhiRFhCZlB2cDQwKzdPUmZx?=
 =?utf-8?B?dHFMbGJTRURHd2t5TXE1S2hOczFKNHBxemh5NXpWNHZudUFlSVhmaitNYkgy?=
 =?utf-8?B?UndvV052K0RVVnpZTEF0NC8rWjdlb1N3cUU0MFpCb0NUWTJSTDA2TzBFQS9R?=
 =?utf-8?B?UXd2WTBRMjJLdWQySUN6cHZsamZLajBBc2Q0WGJTU2VPdHhCNGhDdzd4Y2Np?=
 =?utf-8?B?Tk8zV28vbS8zeVRiTGFpUjJEM3dqeHBqYlhsU1BPaWVqTzB0NXhGdWpkM3Zh?=
 =?utf-8?B?UEw5Tk02bmZOQjFvSlZ6TnFpcURHaVFWN2JiVXZGaExLOEJla0pGT05MeDB2?=
 =?utf-8?B?RVBDb3ZSeXNQMDh4RVhwMDFCMkhPZmpYRWNaUnNrcFp1VG43QklWR2NreCsz?=
 =?utf-8?B?QUFWaEdpZHFvd21QMWFRbEU2QlVVNDRreVpxa1Q1aFVwR3FrT1pQQjdBajIv?=
 =?utf-8?B?NTBVT0FBdTFxOTVHemx6WDlxSW1DZXZCYmNiOEpwMjdlSmYwcEVxVW1GblBB?=
 =?utf-8?B?K05saFZ2NW5CdVR5UC9ZUWthUm9hcExZMEI2WGUzVG5NZmFCUllVdWd2eDdt?=
 =?utf-8?B?NHhoY3hjT1I4ekNOYXdOSXFFOExHb3c1OEJZeWU1VjBTay84a2hiWnRmOHZx?=
 =?utf-8?B?RFZmY2E1UDdOY0R6MEJFOTluWWlOa2RYd0VnNyt0aDZXZDJTZmxsMmRCS3Uw?=
 =?utf-8?B?aG9OWk5pK0RJeGlPUlB4TG8zK3lCMjBUK0Y1VjByWHcyUDYzaVpMQnRJbXZR?=
 =?utf-8?Q?0hK/B036zSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzFWOWZFbDZubVZqaTI1SVlyU0NuOVRESytMSGxVZUc2STVscFcwWHc2cld0?=
 =?utf-8?B?TStBZW9HNUY2MlhTUHovYnEzTndYdGMwYXlTNUcrM2hzS1JzWHozZE1NenZO?=
 =?utf-8?B?ajNJd1g4c1hXZTh0UjJpQkRGOFRvNXplMTlIbFRFMFVwN0Jlc3YyU3BqMXJt?=
 =?utf-8?B?SjZ1MWJ6RG9Ia1hSMkpwSkpJMGlvVWduSk40bEQvaVVYV0ZYN2lkLzR5MlVo?=
 =?utf-8?B?b2ZGMzdER01heGdVU0VUcG90cjFBaVJZVVlvcXpKNGVZbWdjY0p1ODlyQ3Q0?=
 =?utf-8?B?V3RSZXViaWoxcVg5R1pBQ25Ubm9jS3J6Nmh3MFpNYnNwZ0Y5UjJtdlc0NDBH?=
 =?utf-8?B?cy8vYVVaSGNXWXRUczNjR1YraWFuZyt4SURvRUFWQlR2WUdhQU03dXVJMVBz?=
 =?utf-8?B?NDhUalFtdllvWGdQbkx1MUVid21nQkZLeEpabEx6QVRXalNvaTA4YVprRUhj?=
 =?utf-8?B?bndsTzlvdTFNZCtyOHdici9FVG8rdDBhdDZ6dnhQYk9valhwK3JqOG9Kc3Zk?=
 =?utf-8?B?QTdaSlRVajRiU2pZTVU0cGk4WDJWVCtSS0I2MW9aTS9MOHNXWlpOZDJHSVZU?=
 =?utf-8?B?Wm1iN0VXQmxhSXorb2lnMGhFdzl3b0pCZU1FVnhOTzdveE03dmdYWVNIdUI2?=
 =?utf-8?B?cFFrRTNPZG5qUS9OUWRqVExCMGxtZ1dzVER0dTZTR0lFOUVkalB1OExLdFo1?=
 =?utf-8?B?NitvSGhKTW4rMzFmSktxRmR5cGFkbmVjaHZIakExVE5lbGlqNXNodnpKOFo4?=
 =?utf-8?B?a3Q4SDN4Z0dKZzh5YzZWRE5CNk50bkFpNVBLWFkvY0Vmb0JEbXFDc2NaV3NQ?=
 =?utf-8?B?MXJRSHRwWjl0NXdSUEJrV09qa0JnQjk0ZWFkd3hOZ1RiRGd1VWtPanFYUkFt?=
 =?utf-8?B?MlRNQWpVTkVOM3h5dElvN3BGcDlsZ0tJUHBRL2ROaEVVUVBGbTMrY285VURW?=
 =?utf-8?B?R0NYMGFQMjE5K1g3SVFhV0sxazJ6R0tOZ09VTk5TYjc5UXpkVlVxc1JQWGdW?=
 =?utf-8?B?dUhJM293ZDFLVDBLVFYvWEV4WHJMZXhXdHJWa1ZqdDc3WjFDenJLdUFJUU5s?=
 =?utf-8?B?Q3ZWeWhJdFpyUzV6RDJZRFhVcTY2SmpzcXpVWldaTmZaVXFDaHlZbUFRaVQr?=
 =?utf-8?B?NWdCdWhoV05vRnRVTFF3UU81Sk96MFFkZDBQMlhBOE05K0lsVmRib0FRdE1Z?=
 =?utf-8?B?cTBMVEdlVnhmL0ttV2NWOVRBdnIrTkMzSW1wZ2E3ZUYyTW1mUno1T1BOeEpz?=
 =?utf-8?B?RjhVWTNTN3VPUTltQ25sWWtia1BSL09ZSlpxejZoM2pzZlRlM0cxenZReGNq?=
 =?utf-8?B?czBrcWxnTVUzc0xseXdwdzk3ZTNzTi92L3JhbjNNWnY4Mm9sRmFtUkRlaVRp?=
 =?utf-8?B?SmNzMmw3L1UxZDFPNlRwVVZFUGY1WWx3b3hwWE9HVkxTNno5UXlEMVNMM242?=
 =?utf-8?B?VkVkUTk5SjhESWhiVVdBRFRleWduZEVXYWVYdVVsZ2pBZDJNT0FFbmQramFO?=
 =?utf-8?B?clpxZmJkQTMrMlRydEg0dnlaTnh0OURiR0lJYnVRRVhROEw5WUE3K3RDQW5Q?=
 =?utf-8?B?Y1M4a0txWnNGbXpTOFJJQUZSUm9oWXhYUVF5SWNaQVFUNDNYWHVCMXpuQVB5?=
 =?utf-8?B?NVNpSXY1Q0lnaU9LankyMnM2UjIzcnM3dUR2ZkxiQTZYSEx3ekZRZGFxWVZX?=
 =?utf-8?B?RnMxQ0NBV0duak5RRVpBZkZ0VE9Xbnd4a3NFa1hmeTRoTHNEZ21FNWRnUkRh?=
 =?utf-8?B?UGg3MEUreVl4SndhalNZemZZNG1ZL21kNTZWN0I1Mk0xdnVYZzRBYk9GaTlY?=
 =?utf-8?B?MFEvT1ZMNW1JRWFOVWJ2WnliZ1l0Q295K2xpRjY5cFJVdnhRWUpNUXFXK3hk?=
 =?utf-8?B?VFBZcThoM09iUml6akhlMmE1Z05KQjRmMWMwNDUwemRxN3VLR1AzcTh0WGE3?=
 =?utf-8?B?clRZYnQ2TDZVVHI0bDM4SjdsaGM5ZFBHUUhocnhKekk2U3hqSnVZckhOMVVk?=
 =?utf-8?B?Ykx6Q1E0Wk1rK0I2RGQrZExxQXV2aURNT1FXUHdxMGI1dTFraDJLUVFjMGZ4?=
 =?utf-8?B?RkJYS3lLQXNmbG5zQVVUNGJQQ2wvbytnRVdhMG9ZQkcxdFZCZDJydFJaTkhH?=
 =?utf-8?Q?qXkVQEW/QocoIyAyiNUbRw6i3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	InVUOKUt2YZyw5Teqp5EdMZtHxj6qVXV/32e+iSPDkchEH9/EZFhb4iWXrwzMVnJkUWb+tJL1zae/dVWCKASY+zL6vNyvHJA89DSHrJYWYxRmIyAC9lFK54AOmoDVxGp0+PUvMj3kwVnTpqIY0cu7BVBQ8d4Ca2g/2FwIm6cM8Lew0DOFJYBn32xOAHaYPwI/YGOvtax5y281f29Thk7sgQ1dWV0KlS6IctVBFNZ+qolNrD7N96W8Clunm3UPdPzl/ZRTKF6cPELyOvzbJePzDCc2ZdDfw1N4e3GW3dhE4yPapXKn0+koTOCNHTcelXBnJOukGEcAIs+8Zdj4ZBxR7eBDdL8APVJxEs5BWGnO/SReGRu4QQOR6leRvr51VdERuPlf85XAo7+lU0oaxXdF6A3OyRBMNeuaZWGJRfSEy7vNYkTfcb5wOVV8YwP2OevBHCJh45XkGawYS3MjK9fTeVfRZPNaefWpOa+PmebwId4AoMXk4NS7vUqzXf+OASOAyVOVDuYZ77LZzqiUO7topTmNxbkmLAyAJLvayxdNhmmXngpMWBNmxu0aZ6UEVUOFbS4/+Ux2cahusMQ4u5ayrZSvgRvaPrEzasEdJRA/m0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51ad9b0-8bed-47f3-215b-08ddfc10056c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 08:46:29.9574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l00uXcgrB/88kVceVWLjauaEJtmd4iK6Lv4AzCCzcaU96qJ4+0ag7KnZZtndyarrtTDLwnCnrggswbDZiGR+Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4456
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX9z/f7JAUSDQ2
 B4H7iqCpuvsNArf88iiDyeugOaf37dxokdqvi0NQxW6epnNrXJ1EkozDXn3weMHRxSL0ZWnxKqA
 /tIzhEQ+sPHTBgtQZLFUmOPNPfYqlqgTPsRbE2egfYXJm3REj70bsbeJq4eQtMLFKaiwBLWqHD8
 OLL/hnlT7KCvwdDKsjgDR2X7y9kJ+7rdJV3v+60ZMLmt6i5o0wR0cP9FIq8Rv0hEWIyP1yAaUa+
 qzesEal65QQMEIrrtP5hgRw+HS3fnBlX3qBF6USTQVCUA2n6vFSj02++AmaLBz8H06jMenKpjXV
 rLt2UwhBgzXO/a5Ojgexw49E2jsyAqRRVRlntaimQtqT12BybTvr3+hCQ85kjxpaRKRZxWjKwzL
 cU/+2JxBDAL0qvKOte7yCSYCdvdY0w==
X-Authority-Analysis: v=2.4 cv=UPPdHDfy c=1 sm=1 tr=0 ts=68d50172 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=G3P3ke25N5t53vfJu9kA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12089
X-Proofpoint-GUID: N35k8WT7iIIDc7nmebFM3AbgYw28j0bD
X-Proofpoint-ORIG-GUID: N35k8WT7iIIDc7nmebFM3AbgYw28j0bD

On 25/09/2025 09:39, Shinichiro Kawasaki wrote:
>> +	echo "Test complete"
>> +}
> I noticed that the function above can be a bit simpler using TEST_DEV_ARRAY
> instead of TEST_DEV_ARRAY_SYSFS_DIRS. The patch below show it.
> 
> John, if you are okay with it, I will fold in the change below. Or if you want,
> I'm okay to keep your code as it is. Please let me know your thougths.

Yeah, it seems ok.

Let me know if you have a branch you want to test with all your changes.

Thanks

> 
> diff --git a/tests/md/003 b/tests/md/003
> index 83746ae..f4f35db 100755
> --- a/tests/md/003
> +++ b/tests/md/003
> @@ -22,24 +22,15 @@ device_requires() {
>   }
>   
>   test_device_array() {
> -	local test_dev
> -	local testdev_count=0
> -	declare -A NVME_TEST_DEVS_NAME
> -
>   	echo "Running md_atomics_test"
>   
> -	for test_dev in "${!TEST_DEV_ARRAY_SYSFS_DIRS[@]}"; do
> -		NVME_TEST_DEVS_NAME["$testdev_count"]="${test_dev##*/}"
> -		let testdev_count=testdev_count+1;
> -	done
> -
> -	if [[ $testdev_count -lt 4 ]]; then
> +	if [[ ${#TEST_DEV_ARRAY[@]} -lt 4 ]]; then
>   		SKIP_REASONS+=("requires at least 4 NVMe devices")
>   		return 1
>   	fi
>   
> -	_md_atomics_test "${NVME_TEST_DEVS_NAME[0]}" "${NVME_TEST_DEVS_NAME[1]}" \
> -			"${NVME_TEST_DEVS_NAME[2]}" "${NVME_TEST_DEVS_NAME[3]}"
> +	_md_atomics_test "${TEST_DEV_ARRAY[0]##*/}" "${TEST_DEV_ARRAY[1]##*/}" \
> +			 "${TEST_DEV_ARRAY[2]##*/}" "${TEST_DEV_ARRAY[3]##*/}"
>   
>   	echo "Test complete"
>   }

