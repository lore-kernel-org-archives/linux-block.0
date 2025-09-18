Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D9F1A9FB8
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181709; cv=fail; b=VdPmuRc222mpdEuZkv05zSTSqn/7ZcK4dlw2SLiJQr1rgpCJIXcqCHjInemUwHrm24/4EA9OIRPP55F3Hmo8b3zadtTUS1oXo3SFQisOUlovtFlm2DwRsJmzj7FnCxtDQK8nFXDKCW5qwebVBeHO8yY7pqYK+vSOciA1CI1fXAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181709; c=relaxed/simple;
	bh=Z7ALBqpB6bMaevU5npeaUm5C8tnrwFe1G4C0zfXT8O0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qnpa991tiyuY957eDzIIDuwgjN9YV2t47w/HUStxLtLGUx52CmJysxguwBdu4ZyNeazfq3mDJg4XTdcjcsR0+r/tqt+hFeT5pywp4P/NplJf+hLzrHhNMKSAWNzoKrkU3DxzVxZED6OS5Li9KmM5HsFKIJKnrIJ95+JDXouqD3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sDUrkyxp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yyNjgAAj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sDUrkyxp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yyNjgAAj"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7gwpU031627;
	Thu, 18 Sep 2025 07:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+R3lGreh11OH8lxhEI/OJRYKFpezAJCX9ZYKLtqhfLQ=; b=
	sDUrkyxpD3qReVV0O/E1QI5iB7XtCSXLjM0hCqebSG32jxljgWyj4NIgBiFQarCY
	StvRWle1fmGnvLTogmjPdBSWcNWQTZrEZpr2zxs0obck5NYipaXgQNU9MXQePjDZ
	MRcH/qyrfpT8wBMStJu4bVvknQkDSJCz2m20epJtqz3ixl4Sl+LZkDLghEIKoMdK
	mJ5kZDmXPNOwedUm6N5ytzUttIxxthE6qPIGzdc6XR/hB6xggIgqGoqvpDubhc0M
	dUOk0yzdGeRh5Sg6rzOrbWdrsUzxXdzDaJpn1vgcoZ9I/plvTxMIA8EkR4f0ajn8
	nYujCVmphV3jiNE4F/hz2w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8jsvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 07:48:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7SjXu001573;
	Thu, 18 Sep 2025 07:48:25 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2f0hf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 07:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uR5Nl4TZf3dOb27R6xThaCmNTRXYxxE5vS/ap5kBpwOLLIzyN6qWBAEt2Xb8TEx7BmMjFvxebmMm3zUV3mMi9x7TFxc7E6uI/8y+T+/ggp4Rbt+fY9m8EoQkGXM9Rw+zprgVNRahjNFSfGr0s4jpJEATYAzX+fK61Z0b9ud1h8iNoKWKq8XqdVN8dndJUammIDFHX7WGk1E6+wFspevsJ3Js92GLhr93GhXRYZLSqCYjekgEmR+zvUDQJW+eaVlOwAWvoLV/rMh2MUGlApk1p04crET7dCHnZt4caqsJkUUPEfm6H3IIMmz0xxnPJJZPzp6QvZdEGmGKDxTDH0N8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R3lGreh11OH8lxhEI/OJRYKFpezAJCX9ZYKLtqhfLQ=;
 b=ODd/davMvQ805ugyWQubq2MBbMZ6Y7rRKzJxwpcQX6L5Hx8zywGFrCdjF5fG2Qy+bGXQVNWfXAKloNDDEUJYtE7t6I9OqGO9bFWvlNYBVuVhGmD4SRjJoN2MRe+F4qToyJjuUdUI8iL02y6I9GsOLBeTaLbaQd4KzsXeA9bdFBcZsKZ6s9Y5ejfZKUJMw5YHLFKfTVUaQnl/0/dA5bIpIqLV+JxKAXoj0yyWSkNptOWVngy8g4eIcag1JQ6lhnMjDeB+cH1h/eGc5/HMTO0cIpfrETffLlWmUgdv1KMy6o+4vpHV2DSzWwC3chRH6ooo6QODxM+jzr8nA98IuYc8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R3lGreh11OH8lxhEI/OJRYKFpezAJCX9ZYKLtqhfLQ=;
 b=yyNjgAAjiuDlCckc6pF5kolgqNFXVdg+FatDNXezcBxb8QJd59csyKUeZTm48LwQxIMuiFpQhHaxYJds+hNprVVYfEmWbCAUqxMhcW2lVGR6w3PDhIbBFkVcOzLsk2RDO+1+NNyZSAwj4W57XjfBZ3cqz9SckDTcFqzB6WaZpu0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by IA0PR10MB7668.namprd10.prod.outlook.com (2603:10b6:208:492::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 07:48:22 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:48:22 +0000
Message-ID: <c21f0ffa-5027-4bfe-a6f0-6744d9fbed33@oracle.com>
Date: Thu, 18 Sep 2025 08:48:20 +0100
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
 <0b6e3e32-81bc-4e3a-bff3-816089892882@oracle.com>
 <267b6d38-061d-4798-8af4-13ef5f0ac6ba@oracle.com>
 <zk2a2pficfjptjkjsx2wd6kxh5padaop7ge7n2georpofke4fr@lzdzzdmef7qu>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <zk2a2pficfjptjkjsx2wd6kxh5padaop7ge7n2georpofke4fr@lzdzzdmef7qu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0227.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::16) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|IA0PR10MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebda8e0-92aa-4d54-d19b-08ddf687bdee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXZRK0h1elhxY1l5ZEcvMTMrVEp2M2dIbmpkL3duZTRRNm5hYlpjK2hlcG9h?=
 =?utf-8?B?cjBqendmM0N3N0VDWHNDV2huNWtuUU1DODFKdE4xeWpXTXlyM0h2TmUrSjN5?=
 =?utf-8?B?bTVKdDR2RC9xODhJWkFobW1DSGt1VTVqWWtwbldtdXN4eXJwQjd6clQ0RWFF?=
 =?utf-8?B?YlhWcnlKaXRSaW1jd09pMmx1bmV5QTlhSHYrekxGMEZ1OTExMFRteGloNDNZ?=
 =?utf-8?B?djZNdFdxbXBiVnBYN09iZHVkYzZTZ0RDa01STndCVU1mMGR3WjB1dndjSWs0?=
 =?utf-8?B?VTA2dFUzdys3Q0xBQlNHL0grc00yYitMaS9ITjQ4TDc0R1A3RjhxRklUR0RR?=
 =?utf-8?B?YzY1VFJqOGpLOFc5UzA0S2p5TmRjandIQ2hyZXR5SE1hZ2QvbzJ6MFRBK3py?=
 =?utf-8?B?aUpLcmFVUDhkUk5hNG1CNGZraGkzQUxGMDRBQkd4c0JaOVR4K2czLzdZYkVC?=
 =?utf-8?B?UGh0a2dvMFFXT2RaUk8xdmxiTlViaUxVc3QySVk1clR0OG9xeHZLbjVrUlhV?=
 =?utf-8?B?NTdsTVhQRDJVbFJONng3ZmdkaWMxMnpzLzFtTmFHNEc3Q2RMb3VKWERQY1o3?=
 =?utf-8?B?clZQWmhhQkdHU2dTcUU1VUxrVE1CY01Dby9qc1lNYkJBekVKb0VUR2Q1OTFL?=
 =?utf-8?B?NWhwQUE4VnpkNktsNUZVRFZXVHA2Sk5hb3B3bUpMN21nTWNWN3hSb285OEZF?=
 =?utf-8?B?M0lSblJOUUtReHJYYzJianIvYU1FTmJFbGhidGovdFBXNG83VHZHTDBPVHEx?=
 =?utf-8?B?Q3UzZFpiTXhISGR2YnBrOW5jR1dFaXRuNTRPYUovdDVCMHZIY3FQYS9LL1NC?=
 =?utf-8?B?VUQ5R1N6ZjRPckdMTjhoWVQ1K3dLTWxDdVhDdjVOMkVHdFEzSWgvRHFacGpQ?=
 =?utf-8?B?WHYvL3RPSkFlbnJFb00wNnJPTzAwcVY0Qmx0K1NCQ1Z6TFlVMGlUVTBMZ3Rk?=
 =?utf-8?B?ME1mWU13eC9BZnVFc3BEZ3NEaDVWLzRGaGI3bGlqdmNsaWsvS3lOd0NaWVli?=
 =?utf-8?B?NzZld1M4ZkM0clE3VHd1UTEzUExoZGNiTnE1TmU3V2tBbWNISUJFZjRPYWlI?=
 =?utf-8?B?QmVydEVxK2daQVNPMmttZUg2L3lZR0JrWjB4WStadFdkeHF6SWRLRFVSZjcz?=
 =?utf-8?B?cjhsRTFIcko1S0VHZTd6aG43anVhTGpldlliNnpObGZMalZDTXdQR213SUEr?=
 =?utf-8?B?SHZQTjkwTXlVU2hZOWNCRDVkZ1dJcDM5d2F4YlFvVFR1QmtJL3JTM29KMlc0?=
 =?utf-8?B?K0xpbFc1WG5KcDlnYWVoUWtxeTFyZTJoK1JhQ2RtMlVaNzd2RFFtbXJKREhZ?=
 =?utf-8?B?Qkc0ZG03MVlGUFN5RmJKQnBOS1FiUkM5Z1kwS2MvU2FBdW1RY1pCR0ZaSnFh?=
 =?utf-8?B?WVpHZ3dNTkQxVUgrN00vaVBQUGJFdlA1bnNUOFNsU1l6NmkxcWxPaUFUTXVW?=
 =?utf-8?B?bWpLUlNZcCt4ME1ndGNVTktEeXBOZDBFclhaMWxSbEJ0NFJuWlNtak53cERB?=
 =?utf-8?B?U0VzcmV2TFdnWVRWSy8zcnRCNmZrR084bXZCUm02dDNKZGEyUUFtYnBOZkpq?=
 =?utf-8?B?SkZnK0VPSmJCdWFxZkJaYllQaW9IUEY1cGg2eTBZRHJ2dXpZeG04NUlRYVZv?=
 =?utf-8?B?cXYySkcwbFR6MWNqdTZqMGR2b2tPSE0zeDVDQVNYZUZuaTRuaVZzckFCa3Vo?=
 =?utf-8?B?N05jSWFTWnQ3NUQ5eUFQaEtFalpUenhHaS9ob1lieUhES3F1N1JvNkJzYVBh?=
 =?utf-8?B?aE0wakkvMkZ0cjM3cmVXT011VzNtcDRJei85SXp2cXpJSll2TGFJa3ZJRTYw?=
 =?utf-8?Q?L3jICtObXyXIVxOnl99DYww8GjgyJyyCaBAWI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODdTUXpWczgveE94TVJsTG4zNTlWZGs4K1pzanpuK0lReDBRMTVjM0prQ3Ns?=
 =?utf-8?B?RDk3K0Z5dEVjYTk4UlVsSHMwUlovL3Y0ckpjbzhxaWdzamdFV3JacThMVk5n?=
 =?utf-8?B?VDJiVVhMdE1YQWNZVkFlL3hUUy91ZEJCdGZybkFxQUVEVWRkSGVxOEZLdWJJ?=
 =?utf-8?B?dUZkeTZnS3lFaHpCZ3Q5eDUvc2JJcldHdXRNNno0cEtscmVMNWJyalVYYWlr?=
 =?utf-8?B?d1dKY000dU95OEtXUFlTZVMvM0plQXU5QnRYaU9DbDNvV3g1SHBpUXJaOWVM?=
 =?utf-8?B?TFoyM25HUGgvRklhMER2aUFxQk5QQWUwb25WZkNiVkJ4eEdSdFNwbkhXVWdU?=
 =?utf-8?B?cnlPbkhFSWk5U0ltSW8vcUpCSmpVbTV0aGxPaU5ManRKMER2TllFQmpjRFlP?=
 =?utf-8?B?eW8xRmZmczllTmRtZFdMZXJtQlozOGN2RWZ3NU80OEVhc05ueEJLQ3dzeklu?=
 =?utf-8?B?UlZTY3ExNzR1ZUNlVFlkVE9Qb2xUZ0FzZ0VCRHoyN1lGNS91dDhkOXg1aU1G?=
 =?utf-8?B?cVRkYlZIV2dUd0d5ekN3emd2YlhQajlHaExnaUR3ekZHZFQ5eFFxMEdMMmJV?=
 =?utf-8?B?SXhRUzNnTWUxSGR2YmRJZEc4Rk03b0Z6R1BOYS83WDFaMktQNzdHcWtxZnJS?=
 =?utf-8?B?MGJKVHhkamtjb3ZCOVlKbDBVM3E1dHQvMllQMmhscmNHZ0F2SlFFWVRuSnVY?=
 =?utf-8?B?RWVMM3BEUnVBSnIvdWZUR0NGamkyZVFFdTg5ZzA2aFN2MTNrVExidnE2NXox?=
 =?utf-8?B?WTZNV0pHZHNac2lzTmNhZFNRaXdnYUhaVGdabXc1aWkxbjVlcW9MNUNkS09h?=
 =?utf-8?B?YXB5S1EzQU9LVGN0b3ZtYnpYdVhXb1BvdmI3S1Q4VGw5SlBFR0g4d3dXbjU5?=
 =?utf-8?B?RnVZOTlTSjhWMXM0UUxPcnRIUUV4ZHU5Q21Bc09zUjhTWDUralhkM0FmTXhq?=
 =?utf-8?B?Uk9uZE1JMzRMSktsNUU2UU1DelBpM1F5WkdFTzEyaFFFWTd4Z1p5RnpiRXB2?=
 =?utf-8?B?VlVJNXlLaGFxTU1zOGNpYlVUcHc2SEx5Wm5ZZUdVWjM4TVYzRG56a0VkczRU?=
 =?utf-8?B?MEJsbHMrWlN3dXl1dlU4TUo3bktwU2NjQ0xZZldSdGJweEUwcXNLUXJqQmgx?=
 =?utf-8?B?cE1SNXV3cVQ4Zko5T1ovNjhRUXR3ZmsxaDE0Wk05Q3M1dU9MNlBaTnMwVUN5?=
 =?utf-8?B?V0RqaUM1Qko5cU1LV2RBblZuYmhNV21oOC90OVhkVUpqazV4N21OemhCUElV?=
 =?utf-8?B?RFFXZGYvWkxNYUpLZUhqdENBM1p3cGVUbEtaRTFBMlMwVFhvZlBGTnNFSWtD?=
 =?utf-8?B?TjRnUDUyc0E5Vm01YWhDN1JVL1VzcVBNTkNDSXBIVStNL3EyTE5hcENpa2FM?=
 =?utf-8?B?L2xSTjRyUUdoa1NMZWhUdEtjZlZEQ0RJS0l4MVdMb3h4RmwybW9wQjI4bU96?=
 =?utf-8?B?aVFVaHVmMTNqZGI2cUpjQmdtTmxXNEUrekFaWVZ0aC93cVZjUkV4YWtxYjdE?=
 =?utf-8?B?dFArMk1XUHI4dmQxRk93VmFiZ1ZJQUFBeDlRNGF3a0U3bm1Jand6ZzFHQ3Nj?=
 =?utf-8?B?MENLTkpnMUUyNDZhL0EvQnhNT20xN3hnWExVN29lb1hsVG85bkwvbjFwS2tl?=
 =?utf-8?B?MDViTHlkQ0c3MmRMK25EMVd1dTBkTnRjN2VNaFRadUJGaG1TdDIvVGR0bkRQ?=
 =?utf-8?B?M0dHSGFXQXhuNkl2OW1zOXBCRDJrRkJpRVlXa08xR212dUkwK1hIem9tMGhI?=
 =?utf-8?B?clZ5YklESEZ4ejMyMDRlQkZEWXBqTEhqcy9iY1NoWE9BMjF5ZG14Q2haZVVr?=
 =?utf-8?B?aDB2Z0dpYjFPTDZGT1VsNU5yaldzanNYQWI5MnJFb2FuZGRBR2RBU0k2c2x2?=
 =?utf-8?B?Mmx0aTlLbzZjSjVRYVBRSzN4WjVLVzVzRHZsT3cvcmYxSlZiNDBBVVVVYnEy?=
 =?utf-8?B?M0k2STltZVB5RjVIdGx3a04zWUlRQmFrdFhKTTJPZ0dTUG5HUkh4TDdvZGhm?=
 =?utf-8?B?WmJ6VHhrV2Y4WjlBWjhITVh1Y3M2Vk9mNUhhN0w3cWpxMnA0L1N5Vmdkc1VB?=
 =?utf-8?B?ZTBac09QOHpoMHpDdnFZT3ZiM0RuZDBsRDJKZTR5d0wveTlCL1Y3Y1k3ZHI5?=
 =?utf-8?Q?O7+roYD9x66Ih4abxNpXGPru0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sXvZ1mcMG3l6De/RKpxeqErUNqWj/qd3PAcPEQvw/dUUEj+leFsahIf4Y6g1pnI0pypcGKCBgqeHTTktZZ6C0xsERDH03eeJa0y1MduwSplv4H9krbiqE/CYoU6lipvWUUU7uUPV8tc00u3Uof7WlaaVEzKGbx5bgKzxl23E52ToddEXwAkEMRwR630Zn23fND+bVuRQV9itDDztdoSFgYNoB+CnTA9vuGD/gSVk8CZMJov5KH4eD4E3SZWmaSDIoSo9973Qr0zY/A8S5HJpWaoUuUbVTi8TcrZtE6NtzO+swTbOSGBObMAxcOYmtldbvwrss36V+F8+vL8IGBXLV91YJAHfcfUz7hn+61AXW1pWIx9x9t7IRXgSSns4cVJkRV7Hrfk6ybGo1t6UyYMTNLebkQiLvIqZHbRBUL/sA5MwPwzZmFur7H9D0osdFXbEMDt4ht1M+0XvslQTBGJbT+4RWw+j+r7NF//FFZeDhY3cb4PlUmtNyyyr5FLtLDggX9oCYiFbQOzdwE/y0T3G0HgI25xaHbx5kHU4t/HCA9i3qwEf+LBmbKliN9kDLQkmIEawjGqD2iRdVCgjcduo0BY6TfepFS0JsxgMQk23ng8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebda8e0-92aa-4d54-d19b-08ddf687bdee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:48:22.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bj/YZyniXNUas5l773XMDcDm5uXOfvt1dIo5QB8jVKJ5qdQKUJ2D5peccM0mKLM1SgIN9tmxd15CdyhVDS1/pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509180070
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cbb94a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=uherdBYGAAAA:8 a=NEAV23lmAAAA:8
 a=eCCYKYeD6Xqqvg7ARrUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rWCEfM9eTvUf4AVh3scAst2pDECv235_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7BCvTIsTnyMY
 56LHwmk+6BmD5J+8u8pcqLsZj1gHJThEBqBySrAqPFtVE+YUk8E7iYz6clnKN07YHUILkSJi+GE
 MJc41hW+upDewRDRK1kXtiTL0nUAK8Gzg9hi+YnVupSP08y5hEjQ3FUyYFt4dRSxWeZwiLF5SFk
 Yij4Vq+KTs2jOxo5vEYTPVt6GVtjhVcAf5QhD3UNsckOsXWMGnR78umBtdvqIk07vATKP/bU3px
 Fz6sIrsPIi5o9mcresq3EStpOrtdqcLUnhA65zXaXe0aOAqmDtBtdZV5SqfLBk6y+ymYaYMoAIf
 QIMLT3aSQHG6wl8aPtaDFnQ9QWs9jWM+E15gMigK8qVBcxsQA1chcFv5d4CUxRANQ/TORw6FhGN
 Itjf0CUl
X-Proofpoint-GUID: rWCEfM9eTvUf4AVh3scAst2pDECv235_

On 18/09/2025 05:36, Shinichiro Kawasaki wrote:
> On Sep 17, 2025 / 17:22, John Garry wrote:
>> On 17/09/2025 14:12, John Garry wrote:
>>>> It also has slightly different variables for use in the
>>>> test_device_array()
>>>> function: TEST_DEV_ARRAY and TEST_DEV_ARRAY_SYSFS_DIRS. As an
>>>> example, I made a
>>>> quick commit on top of your patches [4].
>>>>
>>>> [4]https://urldefense.com/v3/__https://github.com/kawasaki/blktests/
>>>> commit/
>>>> fae0b3b617a19dab60610f50361bb0da6e0543ea__;!!ACWV5N9M2RV99hQ!
>>>> NNGuj9SVoLIwKksQudWC5ktgS6vIXTX1dGSmibli2-httSpUBfSHAIL1i2z-
>>>> aCmYSXUZxmwGZswO2KJ6Ei8gwmoYAPTl$
>>>> I will review details of your patches tomorrow.
>>>
>>> great, thanks.
>>>
>>> I'll test md/002 and md/003 today with all these changes.
>>
>> I gave it a quick spin and it looks to work ok.
> 
> Good to hear, thanks.
> 
>>
>> About TEST_CASE_DEV_ARRAY, is it scalable to index this per test case?
> 
> I'm not exactly sure what you mean with the word "scalable", but I guess
> you worry about many config lines of TEST_CASE_DEV_ARRAY[X]=Y for many test
> cases with test_device_array().

Yes

> The series allows the keys X of
> TEST_CASE_DEV_ARRAY can be regular expressions, I think many of the config
> lines can be combined into single line when they use the same devices Y.

How would that look then in the config file? More examples could help me 
see your idea.

> 
> BTW, I made the detailed comments on your patches. Other than the comments
> and the adaptations to the test_device_array(), the series looks good to me.
> Thanks!

thanks for the help

How to co-ordinate posting and merging of these series?

Shall I repost mine based on yours?

Thanks,
John
