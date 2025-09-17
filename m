Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025B36D
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114811; cv=fail; b=qlW6WjEiTeT+SZWIwFoAVbcr8EZ/9lrbzQte5I32oIhQ7nPPv3SNNGjWN+g/DHaNTAIR63Hx+f3mSjCSLeWmLudsYYFEvUi+55goVvPjep9tomMn9YnuRFnc4rEbH9YzcO91kqiQ9E2u5iUbugmfiaIa/rXzEiNLi9gTTvgPGiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114811; c=relaxed/simple;
	bh=6sgnHQR1/WBH/XqIPirvTHwFUI1dPoAQt9bWrBt3CGU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fOaPmwKrG2tgrRUg9axgS5QdNDKCQm51ElqQrh8WlGzAeIbEpgn9Hc+qeuEO+88Uh3QrCNosy7PAvIrEBrXKPZT+m0+cOVakqUfUWH/yeVCE9/P9VXyxaa7fcFHbA1pIsStp4ZE35RNIJjZqZA1vy6OFItLdXTHzvT5YhzY/WfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HSZ0JWO3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K2mO/+U3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HSZ0JWO3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K2mO/+U3"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HAQgSU010075;
	Wed, 17 Sep 2025 13:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4cDg8/qZP8N/VRif7iWUZK34tuA270/JVHfAw/6mqC0=; b=
	HSZ0JWO3hDx2J3gfObMiJOVNnjIeOWOJCqBGy+/B65aRdqjXdhOV32ZI3Xws8ASj
	44Lnr8zmOKty6VWKg6cQIydoNGPzgzusz82dOc6LrtzVuqNNHvQTOxEYxrTqPjU6
	edq4g+HHU33zmzReibdEyjG9WIhbsy+ILlixFrPnxneXXwgS+7uQfvXdJwfHfIJu
	KPzaCm/ski55kQKwzY9YBZ4QWDwcZTtUaQXGoQ1nAgfW4CYMsr1rJLnePpeL/aLu
	FHbxrZc5IPShLeJfweiZSw1EvHMccUTGTSqNpCZhzCX8Phs05yujbPLPh0snLlEI
	nuEAHgxsAMtB6U/GIaS6KQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8h4x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:13:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HBNJWS001461;
	Wed, 17 Sep 2025 13:13:27 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2dyyp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMKULLGX7Xh7FjH5a1HXMVJputQOQrmKD4IK5cmXJMpMttm/p8fmLwtYvhXK5Bxdw33CrT+YRXnREbSjpkbA8sS0KmY1n0PaS2cszrS3GmczqZf7o8J2LCCHEAR87drW+Vz3yafk9ZU0B3QEeau2uCgsTqzF8Lw98zUrwBZXqWTMi3b43yb+dnv9hNxT54spQErly61KQybgrEElyv72OphDHAmvMrPAkkW5pkVT6vWzO63aoo2DiKESPT/nzLuLF5qS5puO3qiOejOM57M1YdUEAQ1zfLzPpOafjPT5eg1Prh/nn9UNJiPoYs5eR7OD8c0HzX1EamsqMC2SnKKa0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cDg8/qZP8N/VRif7iWUZK34tuA270/JVHfAw/6mqC0=;
 b=Y4uArKTtTqCAz9LskxLRLUQ3H7NOuL6VrvffOMm6/ObJAlKSD7EE1Td55FQsKsryKxINA4uO6bekV2z5sWPzKgzzGRkCvDyN8ANtcz9ulWU/Oe1Zgpy9SJ+3wic1Pro3kx1Mk3R3PGbKs1f3VgjqDKYH1AjEZWMRFCVzi/52ixtlCnM8p7CSb1jE261YqHAewx3GEhq5TXxatj5U9w05KYlQXdMKALSeoSjrHYvtHQEHZgNs5X4jTy5uUulOdAdw69BGnw3Rvu29Al3rBH0rLxltd73WndODQIVpk/mn1EOe+ML4N1WOjc7Sv1e8L+crSHjFK2UBBsKxP/Yj2yokoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cDg8/qZP8N/VRif7iWUZK34tuA270/JVHfAw/6mqC0=;
 b=K2mO/+U3/IpcQMlVVNzBSTTg8qbqdlgCDNV+FwHMrL4J5LthCeb2XQSmquclCk97evrxIDo3D7c6G3PPhlEjXtqXlSihSr71W7BzejxHk6e1QJZh+4jrZYeF0jQLTfluPGUcZFLgSpps2/nCpj8lleHeJL3p8M1NYFxt6f7uhlg=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DM6PR10MB4169.namprd10.prod.outlook.com (2603:10b6:5:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 13:12:03 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 13:12:03 +0000
Message-ID: <0b6e3e32-81bc-4e3a-bff3-816089892882@oracle.com>
Date: Wed, 17 Sep 2025 14:12:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/7] Further stacked device atomic writes testing
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <5eri4pgxaqhd2mcdruzubylfjshfo5ktye55crqgizhvr34qm7@mhqili4zugg5>
 <39c9f89a-6e6f-422f-88a2-3b2730b659a3@oracle.com>
 <70d8a0c1-5000-4a3d-82c8-2ac7a76056e1@oracle.com>
 <vpds7n4kuilakmqajzmkeipkkbd3wpehuf2ku66wevq2dlfwnf@wxne2chta3ir>
 <78cddd6e-b953-4217-b6f6-deab7afc38e4@oracle.com>
 <gf3x3fisrgfdeqin2dbjhzxyf4ha5ek33jam3orike6tt76b4f@6ixrvnqmktyo>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <gf3x3fisrgfdeqin2dbjhzxyf4ha5ek33jam3orike6tt76b4f@6ixrvnqmktyo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::25) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DM6PR10MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9e4b3c-2e5e-4fd4-1641-08ddf5ebcae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nmc5QmRubnNYY1JFVTBzY041VnkxTGNkUFN1R1lOSVVUQllJZ2dIZ3BSRVRI?=
 =?utf-8?B?NDN6MGxuWEJDVjY1U0xwV3pCWjJRend6RktpUUVNOTN3dHVRZFltMDR5NGVH?=
 =?utf-8?B?SzQ1cURocEhlejk4bE9mWVNBYTFORjU3UkhmeVVKbUpjT2hqQzVWZlVKYThQ?=
 =?utf-8?B?M2VTSlV6Z1BKeWJldmpBckMzSk5Hc2Z1TU13WVIzcnNJMStrdlBTalh3Zk4v?=
 =?utf-8?B?L3hHVUxXcnJqZUhVTEc5KzRwcERTR3RTS2JJanNRSjNZelNMZU81M2FzUDJm?=
 =?utf-8?B?cml5NHpZL2xNSVZFOFJVV0tRQk56VVNjVkh6WVRMN2NjSkZVcTUzbEM4OW0y?=
 =?utf-8?B?QjZOd0xDV29GV2RMUXUrNzBjTmRla1JoMEU5QmxTR1FRV2lXWTN4WXg5U2Ft?=
 =?utf-8?B?MXNjSU1FOS83azhPRWJ2Q0tRTWpTWHFFWjlPVGw3R2hETC9nZHVEczFNc3Iw?=
 =?utf-8?B?dmFoajEvSmRCdkNlQURUVHNpdjZwak5hRjNTUWtOamNWbDRIUnZuTWFCY2JJ?=
 =?utf-8?B?OTM4dG8zUExna0YxOGxKWUl5S0duZTM3VVZWZVV4dmp4a3VEQWlDK1JTZmJ0?=
 =?utf-8?B?Q0IxcXVqcE8wYU41K1JVRldyUFVkT2d5VXZWZ3YvUnY1TWdRKzQyeEhOYlJz?=
 =?utf-8?B?Zm94VTlnYUxUOVZVZGkyRmw4cDQvRU94bnlCY0VXSFlJNjMrT1h4Z2o1TlZV?=
 =?utf-8?B?MDN6QkZqcWF1aGZSdFlTMnJjMTVzVmpBYXMvSXd6NHQ5YnZsMDVjcHZiVkxB?=
 =?utf-8?B?MjNmYTh6eXJlcXRZUWllSCtwNVllclZNOHZ3endkNmZZVWhaano3ZlZXOFdD?=
 =?utf-8?B?VEEvTVRYK1hjeGFmMEI1NUlRUTJIQmxLeiszUi9rbXUxM0xNM3VhQWVJeWp5?=
 =?utf-8?B?aTljYk5BYk9zMTkwVzkrbk82a3k1ZUVOQllGWnZlVFVzNGxsQWVjMHVMdE5s?=
 =?utf-8?B?RW91Wlk2QmtTeXMvemdYME1ZaFN4YUVmM0l5ZGE5TGhYYzNKRzVKVTNwejc5?=
 =?utf-8?B?N2VaNjgyVytrTUpiN21ZYlJSTlAxdk9HTEFZQ01XNloxQkwzbjFkVndxYTd5?=
 =?utf-8?B?c2tRajdRQzhjYTIwQ0gvZnJNVmk3S0tvVmxMV1c1bFJtZ3pQZTFqbjFmZmg4?=
 =?utf-8?B?VGp3dWQ4OFNmbGZuR0x3L1dWMlltb1h3cUVGVGMyTGZyUHBEVEdEUWVaQ0hy?=
 =?utf-8?B?eFl2Snd5cFFKUVNqZm9tNUNYTU40bG9lT1dhS3c2elhKL3diYXlGTXB1bFN6?=
 =?utf-8?B?VEF2cStJZnEvNWh1YlNTRjFYaW9leGQ5MzF6UmVKMkRCcUpMRTcvQXFBYWZ4?=
 =?utf-8?B?MkNTcnN3SDBmenhTeEp4MTJmRGk5aWR3MDRqdm1lMGFuYmhwM1VNWTRQZk04?=
 =?utf-8?B?Z2xmc253Qm9jNklwSWlySTdzdUEvQjdrNGdyQ3BUUnFOSzlxdXA4YWgvWmRn?=
 =?utf-8?B?aGtsYjR0TU9ORlRKU2RTSU1PYk5HV1JUZTY5R2FpNjFoZ0V6b3MrRUhNZkZ3?=
 =?utf-8?B?eUhzRFhsME8zWnpvc29yT1pjNStIME9mMXIyZ1N4L09XdFZhdU1kNkpoMTgr?=
 =?utf-8?B?MzhYaUN3dWpwVmNrK0hKUFhuTjAycmlZeTdEejdCNXdwdlgvWUtSbDFVTytj?=
 =?utf-8?B?UHBGalNZaEthNFlsblZJYUo4TzhRa0V6Z1U2aTZSM3BrUkQ5aUN4Ni9mZDNV?=
 =?utf-8?B?aDN3ZGNqaDl5bEp1MW1Jd091RmlSeFJlWFppK3duTDlDMldyUW5ZN3V0bm51?=
 =?utf-8?B?RGRRRk0xdGxDRStKOUxmMFBkbVJiSEZKZEtkMWlMYUJjaE9TWEFtUXBZWHlu?=
 =?utf-8?B?MnI3b2g0cVdSNi9wNnRkWmdmUlhyb24yRWpZVmhmZXVpY21mS091UFlHdXJQ?=
 =?utf-8?Q?d5cdJgeSG8Ziv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVcxcE1DbE14NE8zMGdFcXhVWjI1VFkzZUdlVnhpWDd1bWgvZW83V2xBbzdo?=
 =?utf-8?B?dkNVZ2RjSUgyeVI0YWo1NDRHZnhsUkpVck9xbUdFWVR3Z0xaejEySzJnS3Bl?=
 =?utf-8?B?VUxsMEZ0VHJ6TlFmaTh3Y2RGanptdVRReWRzaVRneUJWRlo4SktXZThIR2Vo?=
 =?utf-8?B?Nkx6V3VnUTNjT0huNGx4TllzemVrT3ZtUHJ1bktaVEtxaGdQSy9VeWIrYWt4?=
 =?utf-8?B?M09zakVTR1hta3dmREFVaDcya2h4MlQxKzZReU91Wm1CbGR6SGNQRGlqNjBX?=
 =?utf-8?B?RXN6UkhjMkFSRy9nNlpFc3hSdWxFanVoZ3Z3elk0MUp1dlJKVm9QaHdITTJ3?=
 =?utf-8?B?TVRxREs3RkxFMVgyZDFjUXZ6a1R3dkcvMzRsdG04Z3l5eVdRejZkM1hMVjk1?=
 =?utf-8?B?Y0NIaGhsM1JHeTQzdVFjcEUxZEl4a285a2R6RVl3V1Vjb093QUhIV3JDenk0?=
 =?utf-8?B?K1FyeS9Jb21Nci94alNBZjdGN3RobXQ3U21CRGhjTzZRREV2OWFkcVEvdTNj?=
 =?utf-8?B?SW1meG44TUVNYVVWenJZTXhMNGlrWUttUmx2K1FrN1pLRWZ2YVZVQ3lvQmtp?=
 =?utf-8?B?QXhYZDNoNFVmQjdvcmdhWW5aMUliQ3BkUVdyY0JvcHFwZWN1N1ZYem1QZ2d3?=
 =?utf-8?B?bkQ4eWJDbEpWWWxzL21yL2NoZTlRQXRvOVg0SHVGNXNvWktwaUtVQUVxTXJl?=
 =?utf-8?B?V2pMK2JpdFI5WE9UbE9tTU9ZMmM4VjAwRit0T3Z1aXYxeUtOM3lVNC9rb21Q?=
 =?utf-8?B?UGtXZERrcElqdExaNStLTG9HL1lyNU9HQkkzcUxMd2w0Z0hjZlgyb1hPdHJM?=
 =?utf-8?B?WDF6UVpLcWxDbWJ4aHV0MDczYnlpbWRubUx4MTJIMVJ6ZGVGUGxPNzlORmJy?=
 =?utf-8?B?ZXVrZ1pqalE3NXJOYnpSdlJ3Y3I5b1FnNHJrTmJHamo3Mk1kUFNRZW15VkQ4?=
 =?utf-8?B?NnZoOXU2ekFUYTdVZ1owYTdQTGpNRzJSWXlhVXRMM2cxYmFYdjZlRGs1R0pW?=
 =?utf-8?B?SUNPSmdkZzJrMTNUckxLVFY0c24xbndqek1sNzF4UkZVQlBleG4yUi8zWmhY?=
 =?utf-8?B?ZFZUUHBGcktob1pIRkd5MDVwcGhSVW1tRVozc21TcFAyQ1BRaHpockdwN3VP?=
 =?utf-8?B?TzNsQWxoOENwMXJVMk5NNjJ3Y1l3SFQ5bEticlluWnhtS1p1Zk8rWWZnSFhF?=
 =?utf-8?B?UUgwamNGd090cE5rOFcxQnJyVjZuS00xSXl1ZlRVUkFnbDYrajQ0UW9Pclcy?=
 =?utf-8?B?RWNxUit0ZXhLNzZRYWFIbW9EUExCMXpUM1BGS3E4YUZpWEh5eFYvekFvY1Vz?=
 =?utf-8?B?Yy9qUzVIWkM5U0NEYTVpenBtRkplckxHR1BJdFVTMVAvODBpRDk1MEg3WnZO?=
 =?utf-8?B?M1N0aUcrRzB0R3dXd2svdnhtSjFTL3RCRnhiUFI5cUxJd3VBVmhCV3I5OTdQ?=
 =?utf-8?B?Rnl4MVU2MkNWZTRrTHQ1TndZeksrQWdMSGlFOG9IUmFoUEY5QVRJMFNRVm1x?=
 =?utf-8?B?M0xwZGtYMXZpcU0vOVZsMnRPMllkbnF1YUxNcm95Z0xqQXBXWjlRYWlOMUFG?=
 =?utf-8?B?b3c2N1NoQUo4aFRnalpoTDg4Q08rMkpRQXJGUXllOXZyR1hTMGpTa25YWXRw?=
 =?utf-8?B?MHRBUjNycjR4R2RQZHdkWTZrZmVZb0lITzN6TFA5S0VsS1RvK3ZON1Fyd0Zx?=
 =?utf-8?B?Q091UFdHVkN1ZitBRUovTXZjbzJtVzFJdHVMcTFoQVM4cjFDU3REVm15d3BG?=
 =?utf-8?B?MFpSS3orM0hUVDM3MVFhc0ErU0NVN3FoOWdrWllkd1c3dDczLzRla055eXkv?=
 =?utf-8?B?OUF2RWVWRFZpZ25BWnVtZkcvMVZnRUphUHliNXNDUVBiOXEzZHdLcGZydFlx?=
 =?utf-8?B?Wk95NWtGSC9PZ2FzRWpiUnE0QzlrSWpWd1VQRWtYLzhBUWFtekoxU1B4cnRk?=
 =?utf-8?B?aVZ0Z2lreXFxNGRVVXBUVVBxZ3g5Y3RyZkIzZi8vSENJaXB1TGNHa2R1ZWMw?=
 =?utf-8?B?VEJEcDM0cWZ5a3V4cUtwMlNNVUU0VWdaQ0ZGVkQxS1EwdDhLaUF2cWxEWno0?=
 =?utf-8?B?NUZqSXIwTjVGVk9OSDNFb01XZ3hqd3Q5VWtFY3ZQOUNNdEtkUzVpQkF4ODBF?=
 =?utf-8?B?MGRqamtHdGR2ZVpsb1hlMUoyTFMwREk2VEQrRWk2Rmx6azJRYnA5VklQUXRh?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jQg3N92wd0fWDNIbDg2LWwHbwB1JbUNXM88c/7oAJKO+mzYaU6ObuVd+Y6ceR/O+Sgghbo5DTCua8o8+MWKAR7YjDJ65y7l8h8sIIQcDfpIoDi9i27S3fxyGxts/9bDyepIywBwQzXSBgEzPjx20qxRvkGcOWPiAw3/0ZgDcuLmcLjjxfSB6NvBpzHMarvS9cd03w+Dd720kDrsBtnX0GTIPjpQXMtkcvpA+0AaN9P4p8xZJyrRnGJeWf4LUNh6/FN/lU14V0sQtbXfSOCHGNZ/sUTPlNS/BRk4c0gh+1DlnEKMEYf6ODnc+1yRnrUbM9UJybk/NoTipc8kMvINnf8rHmvrGd0NYe1Dqqd+N66tqff754IL+0xd/2P8BpuElCOE4L9Lw0ZJNhXJ55yf4ow74TEByPe7ZS11fXKAlWck3yBqov/+LO76W0D79ReBu1onNH+mWi6mlNQAiIK9VnZx8j6MAG38mSdkCesEEj5/urfTbgXtWYfaGo5y5nGtJ1LoVmzGQO6WrdZyx7qGTxiUOBsJMTIxyktyKhs7HzD5TmwD9bz9yV8qn3rXBQIOFCr6X/NajULiDeqYq2OJnWOj/MP/ew5IkWzZ4sgIgoY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9e4b3c-2e5e-4fd4-1641-08ddf5ebcae9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:12:03.6891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7iwPWoiib7lorwANCMisYmuKiejMlAOod+sKW9ZNUIu6dUMErI2TixBxs0EY4qnToMxXMwiHhSWSxP/lCMbKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170129
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cab3f8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=JF9118EUAAAA:8 a=cUxo5OUxBrqf-o4PUrkA:9 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: X6n5P7sgyKZbLf0BhuQon4oTfNNeFAHZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXy21Z3nuewoTC
 EDfCyRm/078eMpDKQ9FJB29PGifJwFJhgtthm2DayVuVibx32xWvDhg4y+QopU/6pJuJ+XjSp4m
 ao4IJ4CL6SoBQHzWPUpoAO3QpIHmUa0a+0hqgcP6gnO17p0myAHv68nLWtl/fma3MTY5u4GhEEN
 v3yPrvqcDsYXFL039kY5RINZ8ZR/DJjot+R733q+94zN7yOodwYrwcIh0wOqjsk4WTcfc6XVevi
 yapwEpyI3QaDNq1ICGJ7/HO2pbjgvGvL20cUMQM2gJTmfopXIEpmTYHrR+YcfHstp/9LDeo33+i
 pbcmNCA/o+iQU/xtwWDJXptIrf0ZH3lcg2FMFPfIj7tOnmGmmCRzdeoikkblnsiBIdqvlOFdVRy
 NQxNjQ8L
X-Proofpoint-GUID: X6n5P7sgyKZbLf0BhuQon4oTfNNeFAHZ

On 17/09/2025 13:02, Shinichiro Kawasaki wrote:
>>>     TEST_DEV_ARRAY[md/002]="/dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvvme3n1"
>>>
>>> I need to do some trials to see if this idea is feasible.
>> ok
> FYI, I implemented the idea above, and it looks working good. I created a
> blktests patch series and posited [3]. Let's see how the review process will go.
> 
> [3]https://urldefense.com/v3/__https://lore.kernel.org/linux- 
> block/20250917114920.142996-1-shinichiro.kawasaki@wdc.com/__;!! 
> ACWV5N9M2RV99hQ!NNGuj9SVoLIwKksQudWC5ktgS6vIXTX1dGSmibli2- 
> httSpUBfSHAIL1i2z-aCmYSXUZxmwGZswO2KJ6Ei8gwkK3safu$ 
> 
> The series introduced a bit different config file variable TEST_CASE_DEV_ARRAY.
> If you give it a try, please define it like,
> 
>    TEST_CASE_DEV_ARRAY[md/003]="/dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1 /dev/nvme4n1"

ok, understood

> 
> It also has slightly different variables for use in the test_device_array()
> function: TEST_DEV_ARRAY and TEST_DEV_ARRAY_SYSFS_DIRS. As an example, I made a
> quick commit on top of your patches [4].
> 
> [4]https://urldefense.com/v3/__https://github.com/kawasaki/blktests/commit/ 
> fae0b3b617a19dab60610f50361bb0da6e0543ea__;!!ACWV5N9M2RV99hQ! 
> NNGuj9SVoLIwKksQudWC5ktgS6vIXTX1dGSmibli2-httSpUBfSHAIL1i2z- 
> aCmYSXUZxmwGZswO2KJ6Ei8gwmoYAPTl$ 
> 
> I will review details of your patches tomorrow.

great, thanks.

I'll test md/002 and md/003 today with all these changes.

John

