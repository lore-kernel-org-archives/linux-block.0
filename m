Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9564514D428
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745847091; cv=fail; b=rCinjzwVAnC2UeQZ4bIR76jcwQMMVfrSdoWLxpFpBPJ69HRuLbpqJEjKaKStvhEH+Bv1wkBwYEIoC8PX6A6H1JQclDLsv0VAQcquycBx/tQceRZlqR7+Yi9JhdHjnv4tIOXesLWio8vuAuYVglY1jVXH5IdbChJYomcgSWKoxNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745847091; c=relaxed/simple;
	bh=VpcJHa0QCAtSbHjsLDfnrmV6kCI0a0VbUJiGvxsvk7k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OXbSgNGJqMz/DtUo/lZ6D3/gsY5RT7AeUTFzaZ2MZiCs4qsA01e9Jh54Zs4nvO7cN5ka0J6NB4z6qdnAebixP+73WqNKt0roji/b3tHi4L8J097aoI1ttyQFGxG8mdzk0ZxMhI1mEK5YClP8w12tA+v6pxcy94MKzLDxcMUEpc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LLCr/URD; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LLCr/URD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dgkq3aDJXPix0F83UNG4jeROdfKT7g+J7JsmqVPp9v3Tl21YOL4BO5HsUF5/7U3lFB4wWgT9SnuGj06d0zvJozln7YIOgFEDumTre2YifsnMIivLe7yAUbaEDifi/l5srreySlxOHaYBYOZ3d6Dm+cIxj1l3muyb9BS75Z5ElqBDCSiSZKzvDtN1IrYgPc737vRLSp4/G68/whptNquga/8AK4M8SuZJBZc38zWjXR/lyaUROZSH6PdSBm+7AfVbQIgvynekDb1Kh0CEkuljlmIWX+2gjhawfC9c+oq73devKySICmOOyyOeFqBv3UrQ48p9poOlYcnKDwvtcK+N1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snh5aIyp9qzJXD8WlYzWbLJ4gcNXyHJGk/aWocQ7OS8=;
 b=SJMF1qufIOqRNY5euOq6u+/PRkLF/tMh3Asd18cB66441M4aDNw4ohFHuNlcc5TFR9oaXE/mYqREMBluDwySmtmadZQaZIQMkNqhqbU9f+UVcE3SMZxnwoV9V87Kopkl4IRqtxYZtL6LyqwaxBN0Hp/ehAhZIzG3UMIpmG3J19R/+7nHRyFKQ6xXmQPp9StcaeBw3CkQYMW+3ucLqlUA3k522gk1kwEzJ57LAQEznpycNst59p3CbQTLZFYsmR3tEOusLVTKSd14XhsARWatoeGWtTOecDMYb7jC6ycyFjZhEKYqoC8VnDvjOcKHZDbwl5R8pmKXu3pT8LkCwlOjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snh5aIyp9qzJXD8WlYzWbLJ4gcNXyHJGk/aWocQ7OS8=;
 b=LLCr/URD44v2uQM67NDKvc3jmMTrdMK0e8h+6jaab0+S1gw0xMY1RO/NUSX019vRXHE6FovENDqwx29Qcdq9FYTqjw8HhN18iYVbDWnzGJDzHNUgqfY9aZliTDaScN6mokeEN0EBZKe25pFbo/sNUL2Nj588uQJiP/XHGPrCBXFTVTUP4gYbZJ7iydouSwN/tFiMi8Gr5uO+g/TO6niRdHo2nzGA9xSKwP0SexGeFFRxk0YM9xB8Wk9pW1Pn7UXYIPonhoNFT6qoHtL8/RCZ9rbfKxni54i0w/vzvrfx6FtYQEE5urdx5BCViyRd5naiqUK/rX0B5NM6yOKUS8kNBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Mon, 28 Apr 2025 13:31:25 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%3]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 13:31:25 +0000
Message-ID: <76bdc68b-04b9-4e47-b184-702a281456a5@nvidia.com>
Date: Mon, 28 Apr 2025 16:31:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] ublk: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Guy Eisenberg <geisenberg@nvidia.com>, Yoav Cohen <yoav@nvidia.com>,
 Omri Levi <omril@nvidia.com>, Ofer Oshri <ofer@nvidia.com>
References: <20250425013742.1079549-1-ming.lei@redhat.com>
 <174554599841.1088672.7136612395116492771.b4-ty@kernel.dk>
Content-Language: en-US
From: Jared Holzman <jholzman@nvidia.com>
Organization: NVIDIA
In-Reply-To: <174554599841.1088672.7136612395116492771.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: c393afac-c1aa-4b44-3f0a-08dd8658f902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTFtWVNTYlhSbFE1M0Vsck92T3ZQSkNRMTdjTkNtSjBwZnZuN1Y3K00vOXU3?=
 =?utf-8?B?TlpXc1o5Qkl6bEF6cEJUdlFCSlhleGh2LytvbHF3VGtGVjYxMldVNTVOK01M?=
 =?utf-8?B?VVR4ZTJBejhMdVBiN2s3Y0pyeHhxYk1OMXN0eUpWVm5scGxpUmt2ekxYbXRS?=
 =?utf-8?B?SUxRaWJSeXNJdTFEcXI4SFFRRHlBbVB2NW5rWlJwQmZzRUFlUC9Bb1dCRU42?=
 =?utf-8?B?MEVKbzB3a2xjT2d4QTZFYWVwZStER3dGZG1lSjFtaU9wNVlqa29vNXk4ODNG?=
 =?utf-8?B?WkdXeDdhc2hCbzI5NjQ5QkdwMG9KL2FORjVPWFN6bmdIM3F3bXNLSTFucS80?=
 =?utf-8?B?K05sOU92MzFhdlF4Wmdva1dZVURmcHd4czRscVlqTG01a1JmVDJidGt1emxQ?=
 =?utf-8?B?L2RXeER1REh4UEEyd2sybGhvQlpQcFlwbndZT0tZWU9OUUJYcC9HR2s4c2Jl?=
 =?utf-8?B?S2dFcXRyTHQrMUJac29FR29JaHJiUVlJd3VsaGdsVm9lNVBoUkR0cVBsVlIx?=
 =?utf-8?B?SnNCOHluK1BxQldtWnZCNlFUU3l6M0VzajlXajFaeVVEQmczQ3l1VFJIRWpV?=
 =?utf-8?B?alh5dHFuOW0yNjZhaU1IQk9iTHhZMHh2NS9zZXFoNFZySkRTQnNvRytIeEdO?=
 =?utf-8?B?bG40M0RuOE5rL2JrUnBCWERpc3pld2ZtcWxvbGR1bklxb1ZVb0dsNHNzcGVy?=
 =?utf-8?B?UDYxSmxIVUhBSWc2OUVUZnhEbHVjMnIxZnJ1NVdCcGpEMC9BMGlXMWlSb1VB?=
 =?utf-8?B?WmZNS3cwUVBjZkJNSnM2b1NJNU5RWXVHRnlHeGZqS3VOeGVFR0VTRHpSdFJZ?=
 =?utf-8?B?UFdRUk1MUG9FMGVqVkNNOE0vd3ViNU8wSDR0ZzFxeDROYUhQem5rMmlPVTdi?=
 =?utf-8?B?NnBsWWpuZDlxWU8xMStTQVhJcDc5TlhVR2ZHRENjVVR4Mll0RXhRTDBLYTBN?=
 =?utf-8?B?WmpMemFId0Fwem5iaERGSnpRMlJuVHdoREtlQU9GMDhLL3NLM3dRVURWTzdu?=
 =?utf-8?B?YndJNFZVc2xWdFZsdGtVVlVqZ1hwY3FVOEtoTVZyTXJNcnZiRFJvUko2VG5T?=
 =?utf-8?B?OEM2SkhBaDRCNjd5TW5FWDFmcUI4RU5TT3I1dlBmdHJRQ1A2RmswcHcrRVJM?=
 =?utf-8?B?OW9keWRVUURDUytNMnlrUldkK241cG5RQng0bGxIK002VDVMVGxzZlVtMSsv?=
 =?utf-8?B?MkhLc2RoUEI0ODdXWk9oelh3L1ROMXpXQjBVNjZUQjhhUmNBSDlCQnZFNVVa?=
 =?utf-8?B?K1l5TFlsemFlbGVzMzQySXJwekU2VnR3eGVrbENja3Y5aVBpb0lleTBJaVlh?=
 =?utf-8?B?OFljWDFFa005ZzI3T0g1bnBJL29Ob0hldHFUaGN4VzlPVGlRWTh5N1R1ZEFB?=
 =?utf-8?B?RFRZSU1zVzI0NmhzSzYvaXJUTCtYS2pqRVVHMWtGZ3ZFVHhMR2pzMHNrcVdT?=
 =?utf-8?B?YzhXcWcrK05HMlk2bWJSMGRPUHlCNGRMcU1qQTRrY2hpMm1DWmltOXMzUFVs?=
 =?utf-8?B?aXptR0NvbWFoYWR3NVhQTzMxQnhwYmd0Z0pqTjhtNmhZbU5jSytCTkdmb3Rt?=
 =?utf-8?B?cVNDZ3I0a05nZTVnUFN0MzRvN1M0UHZEaVVuRmp4RXpOYnkyUk4xQjFMdUFH?=
 =?utf-8?B?WksvRzRhOEpkdHNKMXZGN3pLTG9qMjZZbTFBZnNWTVcvZUVtdWJVZmhqS3B0?=
 =?utf-8?B?UThySU1RNHlUS1AxUHhXWWVDL0hVYkY3QVk5QmNORThBaUxzdjNsV2lSanYr?=
 =?utf-8?B?bzVmM2FFOXFOLzJLa3RJV3JPNjgrN2dYb0lBVWpwRVZZT2tHSW1BOUROMEFm?=
 =?utf-8?B?dXB2ck5wbDdHeGU4K1phem5NSTBjZHhkWUxyeHFCa3FUVnFDb1ppZlQvUlAx?=
 =?utf-8?B?dnhmeFovVDFsbDgyNWtxcERUNUpXbmRYelA3M3lHbUNNM0IvYkxrMi96S3hy?=
 =?utf-8?Q?kbQGocEaPfw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODdxZStqb3A1NW1mZmFkVUI2U3FMMC9jaFI3Q0FRTldOUkRzTFl2WVBIb1Q5?=
 =?utf-8?B?UVh6MldUeEZXREJ1UHFMSGV4bzJWUUdBZ2RHcFdrcklsWFh1R0tQWnZ1TUpm?=
 =?utf-8?B?NGhGTXphYUp0RHluTzcxcWFRTlBVYU5URkgzM1VtYzN1OFlxclFiK0toMnpL?=
 =?utf-8?B?TnhvSVB1N0VmdU8yRHRhS2JwKzJBN3k1bkpRcDVrdytVSW5DYksrd0NxaVZx?=
 =?utf-8?B?eFJTWHZPNjJ1blk3MmNzNXJESmxyNWNjbTBWVUVCRU80eHEycEU3YlFOVnZz?=
 =?utf-8?B?YU9PZ3h2aTZ5UkNNdWpzeXVTMFNMektacVl1ejhpMjQxa1Y5NmQ3NDdGK1oy?=
 =?utf-8?B?QmZubkc2ajhmZVVWblRTekN4aG5hbHcvdnBSN0JpeDcrZHMvb0lOWUNwYzRr?=
 =?utf-8?B?cGRmUmFiOFVnWGNlQVNyWmlYcDI4Z201RHY4cHlhdzcxTlJ2UGtaZ0IvYXVL?=
 =?utf-8?B?eXFNZlZNMUxjbW8wd3VqNkxRdy9wdTV5dHhOT2dBM2VwNllpaFRZanhERjdl?=
 =?utf-8?B?QlZzQ2NMSkQzY1pabVV2NEN4TE9nVnJkbjZJTWMvWXNsOTY3a1NqVU9RYnpM?=
 =?utf-8?B?R09iRkVmckFpNnBzemZFRnRTK0FCWHJzaVVBamkwK3VxMFBwY2E3OVRLbkVh?=
 =?utf-8?B?bkZZZ0E0SVAyYjAybHhKbnl4T0k0OHovSWE4cjZyUmV1TjBER2J2YlBnS2Na?=
 =?utf-8?B?OGlVa3lXMVZkRDNSWUxrd0p5cVpJSERKaTM3aWMrQk1IVWxnaWhmK0tVM0hk?=
 =?utf-8?B?c1lveENkN082Q1BvOG12TDZTNGx4Ti8vMGVEaTJiVEx6Z2RZdTRJNVRBT2Zj?=
 =?utf-8?B?cnJXcGlpZ3NoalRmV0dPTXVWNHB2TlNSZlRJTlU0Yy8wYkUzcmgxVEk1TG5S?=
 =?utf-8?B?TEozRUlaT0J6ZDNQYk9pOU9hTHNIdXFuc2ZHb2c2Zm1XU2gwOHJ6bDZsdVFn?=
 =?utf-8?B?a1loVjFldEZkeFJNQnExUEdsSHJGS3JVbEFvSGZoTnh5TTRyaGY3MFh6L1JL?=
 =?utf-8?B?Z3BDNGM5U0haRWNpdHE1VGcwRTcya01HMHU1djdLQW0waXplbXh6NG5mQ1Nl?=
 =?utf-8?B?UHNUbm9ERXVlWmZzeXNPR0szQnFiUDBnYjZqVnQrQTA3a3hVR014dGU2OVhw?=
 =?utf-8?B?aWhHejROKzFQMERlTDMxWlc4dm9NdzVBbDhPVURYMEZKVlNOZ1hSR2YvbHRu?=
 =?utf-8?B?YXNnMFk1QkhhZVIyVEFBc25mUlF6cU44S0ZwSmY3NDBBeGQ4ekhlSkpzL1pI?=
 =?utf-8?B?bFplYkRMYnJpVzgzdWlyd2daeERXZmJjME54bFRtK3BJU0cveEZDM2dBclJm?=
 =?utf-8?B?Vys5N3A5Wk5HYVBPYXJIeG5Vckg1R01oMmkzcHhkbFBYNGM0U09NM0pGZlEr?=
 =?utf-8?B?R1o4ODV0Ym9vNE00eU1RZmh6dkdDazd6QTVGeXJRbWE3amdKZ1F1UE1hcVlG?=
 =?utf-8?B?eTdQVDk1bXpHK2t2bTV2TGZnTjJHTHN0Umx4d1J6OHk5Um1jbEh4c0RPRC9O?=
 =?utf-8?B?cEdESHJmTkUyeDZmVmhvMS95Q3BiMU1vVnZ0bGMyQmp2TWtZS01RRTByRUUv?=
 =?utf-8?B?Y2VPeHppSm1nd1FhSEZrRzEySWJsb2JRLytmOHgyemMyQXB4Y0tKM2pUTVlJ?=
 =?utf-8?B?U0MvZTdYMCs0bVNpMEtUY1VjbERJU2VRY3B3emdKakd1bGhCbEFhcFpERFJy?=
 =?utf-8?B?ZGtiUXMrdHp3eVNreFVydFVoQ1Z3eEFrQkRzWisxbUpmOG95eU1DenpVNmlH?=
 =?utf-8?B?SjduWUhlMHNFZHNCalhaVTFyakpCakFlajlUM3EyT0FBVjdVZzdXZlF3czBj?=
 =?utf-8?B?d2VLam1mR2FGUGhWS2xzY0R3UVl1MzY3T0M4SWswMUFWSkYxR3dnRFJJeUJ5?=
 =?utf-8?B?aFVHeERheklUTlh0WHpGanNPaHlqRy9xRmVvTCtyUk00MFVXN3dLM3U4Qzd1?=
 =?utf-8?B?clkzWmx6MEp0SG9pNUpBMVZVU3Y5R3RXYkJQVFM4MnEvYVhEVFBOckdoNHhr?=
 =?utf-8?B?TUNPTVlPOEF3UHFqSUxRNk1GS3hISkk5QkhhMVhJcXRyM3UrNUJ3WWtPQUEv?=
 =?utf-8?B?TFdLeCs4TVk2UkZBc29takFwbmJnUHc5MkVRWkg1c2M3MDBPcmpoL1l0R3dS?=
 =?utf-8?Q?d4ZFJeL+UNASy6zrtzeCev5w/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c393afac-c1aa-4b44-3f0a-08dd8658f902
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:31:25.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMHHBdLPSSd6fjUlfpz+nws6W5+cvDrItHQ2Vb8iDrt4ATcx0gCGjp5PR4svm9TUotcmHVV9VILcBtYn6XwQQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469

On 25/04/2025 4:53, Jens Axboe wrote:
> 
> On Fri, 25 Apr 2025 09:37:38 +0800, Ming Lei wrote:
>> The 2 patches try to fix race between between io_uring_cmd_complete_in_task
>> and ublk_cancel_cmd.
>>
>> Thanks,
>> Ming
>>
>> V2:
>> 	- improve comment and commit log
>> 	- remove useless memory barrier(Caleb Sander Mateos)
>> 	- add tested-by fixes tag
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA
>       commit: d6aa0c178bf81f30ae4a780b2bca653daa2eb633
> [2/2] ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd
>       commit: f40139fde5278d81af3227444fd6e76a76b9506d
> 
> Best regards,

Confirmed that this version also fixes the issue for us.

Thanks,
Jared
