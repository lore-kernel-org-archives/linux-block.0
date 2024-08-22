Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2071.outbound.protection.outlook.com [40.107.117.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EEA17CA03;
	Thu, 22 Aug 2024 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331052; cv=fail; b=Jj217xNHvakRFQQu422E/VP5FG+SJowN/wzpTx6jJrC0f6APG4qwKqBr7WNOc3bwyYs/jUKxIcafAZ8SEwNyScJwZF+BYBv/PmppPOkdj8V6qVfmmPA7ajjwIvCW0zG07/etaiHfXCm13SIQbhfQ/xTkyZeeOc27WoTXBG6XsGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331052; c=relaxed/simple;
	bh=ubjKZsd/Q3W8IxJp6Uy74nj5IUrcVQd32KJtLppG+MI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j273gqq1h5eqMQbQR/HEEZxS7DvfgbZKorxdHYk7+7pm6lcRyHWigPzgNl+Ua2YIMKyNYJrVG8HO4f/2iNvQqXOh4Nedn4TFbwOZQrOSMk0fmJaMUMjeRQLApDZszuQOJg9ZNKFzvzW6r/MwsqmMzpb7HVchTI+YdlDoleZPJ5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=rGZHFsh2; arc=fail smtp.client-ip=40.107.117.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="rGZHFsh2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jT+p92LTyTDDI6e5fkFgdgPEVuF9dovCeVGHZgt9icKrzaAxuuKHm6XCepZDTLBRfaNWhX8nKuHfRF8TNgoiJeDhxPhVMP2kJllizMJ+wJyY8chV/An0CLqZxRPyFS9m4rW/o7t4KOBj1lYyEO+LUlrmKSNNcTvUVSlRL75CITu1L0m/K2ySxfUtt8rUCOWeXZ9fUxxhL44XGRtmCNZeynrUiNa8Bg0P41wtaiTkvrwVbBUZ87K+xE6kuP4V7goL1FADSUMhYI9DEyd10C9cC0RG0I0OFO/Bpbhsk50DFQziZRwn+VJj6gsTByRvJATubPRwRgIXRbE77sSP6H1f9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p0soeQT0W6X3+dwZkibv+3aDTOQA4u3h9Sa8P3UtAA=;
 b=HswRNADJxbc28HfM1cGm3clrxOlCfFPBPe2/FTGc4YM9iqC7z+FtLeibJWl53N9Sm498uZyzE8F0u25Qh4n7Z5xri/pPG3wdzvTwF2Boy5CxvczvBLO0yrsumtPwtNimJ1sgNDfDq2SpqzwpTs6+Mb9IlosllYQcvbTMH8vFBmGBozKIS/SvXU43SMx7p2Rg+hCl40iBp8kUnekbxwsDqbw6ysBfemtVwLWIsiiQwxUgaRY7pgAp+ms0VVKI3Q3nNoXBGeOBCuQMzvXI9oO8tneUTNXzAiL9a9sScAIYibxkX1YKwZNKlHCnAfIUVMJMJ7QEXy3eZCEOAcse/H1+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p0soeQT0W6X3+dwZkibv+3aDTOQA4u3h9Sa8P3UtAA=;
 b=rGZHFsh2myNQp9NOHU0iUCOW+MF686Nu2sZb/ah2OuhgaK3UzCWpswcmoSQsKtGBNNwrDFAXj+1rxym0lCaMzO0OtbdnbkmLafdZs97xEjCcnCmlYzibsTmwg6M8fKKEax3DZveKFmduY35o9Ypt3LdJYEygwEb20tk/H0qhCSVCEZvEYFWwTiUKUQuAkYr72VSYOn6XYi6v4MOphMa8QNge6BC+cvVkMlCaf3ALOds4HKRHoFYPsPeh4Fyp56DwsYFWO8Sl+ACcUa8od546sZnQQxfnWv+ufaT4A2udC8gGEA9IO59pr178xm29i1TyJ7vBiIe2Hxo3XjKa41Q+pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by SEYPR06MB5742.apcprd06.prod.outlook.com (2603:1096:101:ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 12:50:45 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 12:50:45 +0000
Message-ID: <b6d12fa0-5642-441f-8289-a794435b2f17@vivo.com>
Date: Thu, 22 Aug 2024 20:50:42 +0800
User-Agent: Mozilla Thunderbird
Reply-To: 11162571@vivo.com
Subject: Re: [PATCH v2] drivers:block:Use IS_ERR() to check
 debugfs_create_dir() return value
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Borislav Petkov <bp@suse.de>,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240822124109.2259697-1-11162571@vivo.com>
From: Yang Ruibin <11162571@vivo.com>
In-Reply-To: <20240822124109.2259697-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0151.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::19) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|SEYPR06MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: 3156723d-f72e-46ce-bb7f-08dcc2a909f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elBrMVJYRHZUeUJibklweVI0NmFQYUlJbXFLRmNJQ2lHSUNDS0sweEdobEdT?=
 =?utf-8?B?VUs1SmVCRkpDakRNRFg0VFo4cEQrcXZ4SWN6WUpiNTg4TVN3RE5OTFpjOTV2?=
 =?utf-8?B?Y3d6ek1RMWZSTlkvN20zaG85UnVCNndzc042SWJZSnhJcnBvQmRFM3ErOUN5?=
 =?utf-8?B?blpNVkxWYUZqeU15bEhCeGdrSU9Wb1J4VnpuTWtCM2R6dlFNNlo5czZvQ2Fi?=
 =?utf-8?B?a0pVYmZnc1loVVdQYUx1VWNoQ1g5SERac0xsV2w0ZCtTN0h5Z2Irbm1YOGR3?=
 =?utf-8?B?UXZ0R1VPdXlTUWMzdE1GMUprM1dDNk43L1hXTWZITC9oVUk0d0p2YVNrTUYx?=
 =?utf-8?B?YkhzVndIanJnNHo2Smk2YmU4S1R2aDBkaGpRR0plRWMxWWErT25WMDJVM21l?=
 =?utf-8?B?T0J5Z1Q5enYxd29qSzYvWjQvM0RPRFd6TEpVZ3VjMXdLdWZ3d0RMM3l5c2ti?=
 =?utf-8?B?b1BCaDVOUTJQdWJ0eFQ3T2VQMUl2NVJFRlJNbUw3VmMrQkF0V0FIY2MzQjQz?=
 =?utf-8?B?aUxQMW43UE43UlJKSFgzVW1lOSt5aHhLNzNERU9VK1pTa2psMG1lZnhWaGNY?=
 =?utf-8?B?Y3JiaDlpa24vamM5UWdmMDRrZXFtRXM4VENyQzUxTzhDRWlkNXBRU2tHd0ZT?=
 =?utf-8?B?RU4yWjRiNHhEVi9hWllzN0hpQ2Ywa1ZTTEhlblI3NkV4ZjVCb0lSNkVqSHY3?=
 =?utf-8?B?WlRyZTRDb2hZV1RzRjVkWG1nT1p4MzE4Mjl2RlFwekdTWS9CVFpRZmFlLzFV?=
 =?utf-8?B?THNvWCtQQXIrdW95NEt1ZTJwVGhDZG9rdXdVZ3ROT2dnTFNZM3R0WWxVLy9h?=
 =?utf-8?B?ekhlbkZtNFVkZDhtY0FHNUJaNlVzOFNjZnNUQjJ1TGN0Q09SMWlaVFN5eTMx?=
 =?utf-8?B?NHJOYkEwVmRKY2JHZDltaFhIUEJEelJaTnN6TmVLTXJ6dE41TGVOWFZpS05s?=
 =?utf-8?B?YlZDWEJyM2NsRkY1OU0xVHVPNXB2NmNDSkFMY2p0NDZHSW1qb0kyN0hiUUhI?=
 =?utf-8?B?QzMybzNtbkx2V3F4TjVmZGZ5eTNObFVxektRWExUUkpHUTgrVlJFTEFWTFAr?=
 =?utf-8?B?UnlmSTFLb015Qm9MKzYxU0hkYmJyQjNXdnVGM2dJeTdXYVkrc2NRS2RWSmNB?=
 =?utf-8?B?TWYvbTBCYUM2MVZFQnR3UlpXQ1BseTQwVDVGa0p6Z09KMmN6cVBNSk1ib3V3?=
 =?utf-8?B?THp2SWF0dzl3U25qMTVYaU9LNzhzbklVTm42d0JscXZUSUFGWUJZYlZjOEdO?=
 =?utf-8?B?RitUOEZkWDB0blpkKytLRUxxNERyeEM4Q2l3THh4c1FnVDQ1NjNxQ1EveFZt?=
 =?utf-8?B?VDRIWkJ4WnlBRXh5RjhYRDFFc3pWQXdtT2pjUEcwaUhTNWwwMlZGQW96UjRs?=
 =?utf-8?B?d1ZUVnhXNnpxaXpxWEJaTWQ0WHd6eWREUDFQcGR2Z25KdjBIeEdnQnlKOHhR?=
 =?utf-8?B?VEhJMFcwVDdSVnJqUXIzcTFLMUhDSGUvNmlYQ2FFTS91bENEaDUwdjQvNktL?=
 =?utf-8?B?L045NFhzc0VMMzh0NDFla28zQk1rZG1wT25DTFFVSUt0ZjRWYi9BZzFPTjhC?=
 =?utf-8?B?U04rZW4zV1QrWlFjUDN5SlpoOTR6dXBWOWdZV29TRCs3ckZSVU1EZTQ1a3k0?=
 =?utf-8?B?MEt6K1NFbXR1Tjc5ckdnUVlmSkRsSmF0L3NqQitjVXhmd2NOSFVZNE1mdTdq?=
 =?utf-8?B?VnpUMTNRdVB6c1lJWDlrTXluaE9zenVIL3BzMkEzM2owc3FoV3NqQ0xtSEg2?=
 =?utf-8?B?ZDEvLzAzQ2JwRkU1RDNCSnlweFNvNHVTTUROaWZtSGZrMGx5RWlCREt1aUdt?=
 =?utf-8?B?R3VTanhXVVRWMktCaVUrdG1aNzRFSkZISnN6MnNHYVRseVM3am53c0lmSTVD?=
 =?utf-8?B?a1E3QkpaR3dHU3FiaTJZM2wyTXhHK3pPQVY4OExrd0F3OHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFBteEYzcDVtZHRVbGwrb05SMitUWUoxUW8zT3dyaE9ZekFWdmNWTS9pZEFS?=
 =?utf-8?B?akpXUDVUY3BDNGQ0Tkl2RmZhaSt4emxMZkZ6V2hvUHlSbFRxeHI3SHNsNkFn?=
 =?utf-8?B?ZGd4SU5kRWlyeEY3WWtHY1BRSG5iWG1ZUlJKbVlVTlhocm40bE5QSG1GcGgz?=
 =?utf-8?B?SVd5ZGM2UGZuM2JaUUJMSStRYU5adTlnb3N1Z3NzUHBQRm9tenMxRmluaFZY?=
 =?utf-8?B?M3loNFZFZ1JFT0VkaUVoRzJzUHZWeEVuejlxQVNuSjFRV1ExWUZ0SEtydmpz?=
 =?utf-8?B?UVpZTk1lRk1uR1VDNnk4a21WclJhay9LazYrNnBsYkhSMCt2U1JXRTViNWho?=
 =?utf-8?B?dzNqTjR3VWlURzBxTGQ2U3BUTE9ET09VeUZIOTM1Um9EeTlIcHQ4LzVuSVlI?=
 =?utf-8?B?clFvZGFlRFlVR0toVEZva1ZWcmN4YnNOd1pJaDE2cjNCSi9aeVJlakxpSXc4?=
 =?utf-8?B?QkVDc3lSdFVSTjVhQTloV09JZlQzcVBReTlDZG1GU0JCL0wraUlCa3lsUHRt?=
 =?utf-8?B?VVNyMFM2S1dIOTB3ZDVoZmNVNlFQSDdmdmhTZ01OSWxROUQ5OXFaa0dETzgr?=
 =?utf-8?B?QS9oREM2TjlhNjNROUpWNWxZWGErWkFuRGM1ZWNiQXBJNk5EWnRaeXhhNHdM?=
 =?utf-8?B?eHFSUDFYZ1c2b2g2V25VaExzZ1ZlWGtmaFM3Sy8rR2dhOUwxeUFyUEYvNHhJ?=
 =?utf-8?B?eEtqajQvUXRkZ2UwQkZQV3FiTkJZYVlOSmIxSGM4elc5VHZTeWRtM2hRMVhZ?=
 =?utf-8?B?ekxSdDA0MEpCVTYwdGtON0kraWNDNTRzbVlsRDhDQW9MTVRVRzg5eWJuS1dT?=
 =?utf-8?B?dWhTVmREWnlJaXhHb1I4Z0lQd1dQcG9BWXJTZlY2a0VhekpZLzlFWkZCUDdn?=
 =?utf-8?B?Nm56RVNCWG5KVWRxb3gzZXMrZ2hZNnpVQktTcTVLWU14VnVMN0tzM1lFbkVm?=
 =?utf-8?B?UUhGTUNnRlQ5dFhqZlQzdGJ0bC9wcWd3TkhWd2c1Ty9OanYyWWVnNnMxcVgv?=
 =?utf-8?B?TTlqQ253dUVFQStueEoxTG1YOGh2bXNiOVIwWjBZWXp0ZzZ2c2thTVVLQXVv?=
 =?utf-8?B?SUhnRGRIRTB1RURLRUpDTTJwdER2cmM2blF2ZEdQdjROeHRaSHlERG42Y0c1?=
 =?utf-8?B?b29sYUVZVWYzV1poWjBFRFNzcC9OWW9oWGVKNFZFNXJiZXVzWW1JenYxckRH?=
 =?utf-8?B?TTFyNTZjZGEvQUFJUE9mZWRZZkY0Ri8wK0tFald5QzVwNk8zWldzR1NFRjVH?=
 =?utf-8?B?ZnlDWjljTjMrUjVpcXByMnorSUx1NS9NMzhCZTJIVDkrd0Vkcng1YW5IT0Fq?=
 =?utf-8?B?UXNxcWpQMW1UNUM0TWlKb3h5RWJLQTEwSG83TlRhZ0VmKzlnM1ZxLzI5MG0y?=
 =?utf-8?B?U3B2V21pUE14dktuZml0cDJtZkdxRE1yYTByOXk2VkRUeStxSlFycVQ1SWRK?=
 =?utf-8?B?bE1rTVJVQnlwMnlvMFNHZW5SSmdxU2xIM3ZmNHdEcGk3Vk9YSkFUVDNYdFU0?=
 =?utf-8?B?TU5qNXg3M3JmWnNaRmxPcFA1aGdjaXd0N1ZmTGQ4SFBYYTJFRVNlc05Zc2Np?=
 =?utf-8?B?T2hXSnJiOGdKNktndTIxdFFualVPRldQenJsVFJIU0hpMVFXWkRVQUNtRjc0?=
 =?utf-8?B?NU9zVUIzVTB3TFI3Z1dJcVNRTmhwVFJaSVhoVmpCWXVCODN2YlloQ1p3bVFR?=
 =?utf-8?B?YStmc1ZvSjgrbjhHNkllR21IbXJyamV6U0x2bGFxQW9BTndKcUU1TVZpT1J3?=
 =?utf-8?B?U2plc1p3OGhqU1g2VjVPWmhoSWF6L2NiY3ByVFZZTVRKY0F2aWhPb1ZBbWRo?=
 =?utf-8?B?ZTNKR0E5Nk0zU25aSy9HT2Nxb09TWkZES2w1UmM0ejdYNXZ3NXljT2Q2YmZm?=
 =?utf-8?B?anMyNjJJVlNnQUhHdmo0TjI4OUlmdmowV3VKOVd0TC9KbzJPaFBFcmFBS1FH?=
 =?utf-8?B?dVB3dnh6UStZMWtqMjB0WjVNaWM0elBnNnVNWUx5N3hwZmdtUVlCVTE4Rkp6?=
 =?utf-8?B?N2dta09FNzJIZWNNeVppV0NjcGFpOHQ0T3RjOFJTbVlhRTgybFRrNlllSlVt?=
 =?utf-8?B?bnVNQm41RkNlczdBRVJWZzhwQkNmTE81QVYxaklzRWhkc2RMWnFTck9rZWgz?=
 =?utf-8?Q?wRmQ67NAjD03zNQmn45/K7GFK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3156723d-f72e-46ce-bb7f-08dcc2a909f8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 12:50:45.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkjZRjskZ6Mtq5Sf8TBhhX48pB3CPx4R8e5KJnt4u8gAiznFqss7L1uuNvyCe1WmlkQrYzifmJmbDiYEVZ0IQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5742

Sorry, please ignore this patch for now. The wrong Fixes were used. This 
patch will be updated later.

在 2024/8/22 20:41, Yang Ruibin 写道:
> The debugfs_create_dir() function returns error pointers.It
> never returns NULL. So use IS_ERR() to check its return value.
>
> Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>   drivers/block/pktcdvd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index 7cece5884b9c..030b7a063a0b 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -498,7 +498,7 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
>   	if (!pkt_debugfs_root)
>   		return;
>   	pd->dfs_d_root = debugfs_create_dir(pd->disk->disk_name, pkt_debugfs_root);
> -	if (!pd->dfs_d_root)
> +	if (IS_ERR(pd->dfs_d_root))
>   		return;
>   
>   	pd->dfs_f_info = debugfs_create_file("info", 0444, pd->dfs_d_root,
