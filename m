Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5DD2FD660
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766086873; cv=fail; b=ClslU+wf37SZPnHT0Nt9vsk35p3nVFssbzJoU2y2O0mJ7u3NCfnmWILs7yhOkqmFqrWngkHcAu7U6CjmJMJQ6nC00ksWzYkT7lxV1JazUHCRawKhMF3ldHyimdvV/UIgEKnlV7ImSouOi/8J2cU+mVW2GMhtpXbDowOGErBXSko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766086873; c=relaxed/simple;
	bh=ljSD/jfjR9YokBRsM2n735QxrfMoptWbm9UpRWPSEVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EBUMFpVx6+cnWa5/5YSoheyUIW6/OaoEjhT3fiVgi+VGx/hCqE74a6TMKxqGhQKHzJ95KAJbf5N7KuXhc73pd+d65404oi8d8qaA2HIZWpHeAXA++ComrdcbSA3T15cWZqq5kTd9hO2+5Fm8IqO9kKqPqU2hEUfCpBag5PDesCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mg6w/JPT; arc=fail smtp.client-ip=40.107.209.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mg6w/JPT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiJgCPeC2TbFhioHT6WkAoV+XI1JyH/EuDKCPCSxSZYaZDA5YuN50idoAXmEKqR2rv0VOzvD9jb06jFu6C7nL28JrbbFHLWAwvwfe/wks3T2zkh3C/yvGkw6c5bp+TijoBP2BPH9GRmq1w/DhUplx5MKCKHdAuGrhVuyzkxkE/fqdKiA1JhgRL7Ir3wc64De9Xgq0hmP1B2YswJ07NiKInI5SIBRuC2tooBrjQ57Pk9ovhsqpPei90sPLBock5cDRmmcjAoKOL3Fq0Eo0Nu4bXp0lydNLXIi/MVqdDRKmWJgTGQT32I76ohq3HYna2W/Ip4XXPOrC9uo+jw8BUZh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljSD/jfjR9YokBRsM2n735QxrfMoptWbm9UpRWPSEVY=;
 b=BfHCFB4Phi8T8dJpYEg5L0pRboG0ZyCCHuN6mnBbirsYLDSjA1EMkf+QYvEgl+EjSNYCOmd8zHIkLKZ78CbGfygRuZ+gHpElUH0ePMmkS5BYxXIvrEslpvkzI7yGEKGB5TsPe2sxKSg7VO8axj2k4EFVHz52wzCtlOWN5tqgqS17gtIDHbqUrzJspD/0Ihw9R7gobs6/R/sRcqfs8lpAhgT440as/4wzeIm/axnLVakBYqB7A84139iOXcauwz7tAmVZeqBnGU6RLttxP4Z4z3JI7WMkkDu9VAb1w/34iTgX+I9omhdrDPPRqab6EZzY7H8glSFKMNFYyJ0KGLcQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljSD/jfjR9YokBRsM2n735QxrfMoptWbm9UpRWPSEVY=;
 b=Mg6w/JPTDMWrCSDEVYttu24cV+mpRJnuPIdHPe5GdeldDPN8QNpZ+iw4GQ342ax2vWLeqC+ODU7N8J2LRV0zn7P8JBG4idVgkj8NtF5Ab+aNn1M0Uj0cTXRPhnAvUE5yankAnfP0VzAchV3gYKj8cZ9CTL8bh4aisjqidS6gBA18cS8ii11VfzDtVgzg3n9Z4DyeO4wC0DxsI7uFYm8D20RXr5xWBpjJtMVvhTwQDPb8CteDyRBeV+lL+rg1LF/r0Diqg1ykt7z/KFfCUJDB+hMj6sAICDYKL+n7puqUFtdg6PbQVnPRTA9J2mS2SexnosHu7daRTwtmwo+pcmjpcA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Thu, 18 Dec 2025 19:41:07 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 19:41:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, Yi Zhang
	<yi.zhang@redhat.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "open list:NVM EXPRESS
 DRIVER" <linux-nvme@lists.infradead.org>, linux-block
	<linux-block@vger.kernel.org>, Daniel Wagner <dwagner@suse.de>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [bug report] kmemleak observed during blktests nvme/fc
Thread-Topic: [bug report] kmemleak observed during blktests nvme/fc
Thread-Index: AQHcarSjkiZ9qfYnSEyyV1+PS2fWGbUiFM+AgAXCSAA=
Date: Thu, 18 Dec 2025 19:41:06 +0000
Message-ID: <7d718bc8-64b6-4e8f-bad7-7e1615c577ca@nvidia.com>
References:
 <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
 <262c8ac1-e625-4e4c-8b3c-85f842aba6fe@gmail.com>
In-Reply-To: <262c8ac1-e625-4e4c-8b3c-85f842aba6fe@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6285:EE_
x-ms-office365-filtering-correlation-id: cf191533-d589-4f7d-3981-08de3e6d6338
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlpLVkJMc1BYUm45dG9seWQwTTN4b1RkWTlQNFAzb1dNMmpZc0ZkMDlUWlJh?=
 =?utf-8?B?VmkrcDJsdWtnTjlxL1RKNGVOeldzMklnUWZ1aXN6eENSYTBJSHVMTlV3Mm83?=
 =?utf-8?B?cXdvMW1JWXoyc0FoVHdpN1Z1NDRTSEwxSHZwa2l1eUd4TlJQMzhEZzVjR1Mv?=
 =?utf-8?B?NnVhdjRlNVNNSldKeUdhRHZwL1VPdzBycFNYd2ZvUWdmdjhwRGRzRnp0K2xF?=
 =?utf-8?B?OEV4UHg2elFDS0huRm52ZlBYL0hYUytzWlN6OXIyVEF3SlVoVDBNeXYrVTQ0?=
 =?utf-8?B?eW9EOUFCWERNVmJFMXhsc05sbVJ0enNtOUFTbXFuYm5GTkJLRVA2dEZ2VVBr?=
 =?utf-8?B?UzZmSGI1ZUFwTXd4RWNzeTg5UWNWbkNQZDZxVlRJSW1TdmdHbHdQZVBYMVFP?=
 =?utf-8?B?SU1JL0RQMUxCd0FuTlBBakUycUxWMVFxZU5mSjBxak83R3h4VCt6dUt6UlFm?=
 =?utf-8?B?OTMvQnpOOXlxbWdyS1FjbU4rWkliMFN4TWd0QzR4WnhvN0xnRkx5c3VYRld1?=
 =?utf-8?B?WENIczY5dmtHWlpudGhXMTVyOWVtZy8zeHRSS1hVTTdkeVhzK2E3cSt2WnFR?=
 =?utf-8?B?N0R2NGtlSzd1YTlna1crbEJwZDZjRzZRS0U4SWJlK0Z1bFpkWkNhL2lMZU5a?=
 =?utf-8?B?b3ZOMXVvY0h5bEs4ZTV6eFAyRWRDeFRmRUQ2NnY4WHBMRXkzWXBJVW80RHFD?=
 =?utf-8?B?eDhZenhFTTBvamlzditJZjM5eXh0UEtZUzM0d0l6cHJXRHRxYTBsdnlJY3hl?=
 =?utf-8?B?NFMrSDU3Q0tLTVN6eWVGUEZyeVVNdVRtMzFtc2hKZ0lFODMyRmgzQVJDUG5W?=
 =?utf-8?B?L3RhTXgwWHpZdVZka1E5OHYwakhDTHJTTVdkM0YvVVZIRVNUcjJPZno5aTB2?=
 =?utf-8?B?TUdFUVJmd2lHTXNnNVdKRytJQ2M2dGRqTXZZcnBCaWpFenNncU1xcXlXV1lR?=
 =?utf-8?B?VEk2RSt5UERoRmdFb3ovS1oxOGI4U0dpTGZWc2w0bm1RbExZSUdNeE9qdDNC?=
 =?utf-8?B?aDM3bE05RVhFb0pDejV3Y1JvR1VkK3BJTzVlSXZRUWh0ZXNKejR2eStTcjNP?=
 =?utf-8?B?Z1poSkt6NGNVR3NSQ0VvODV1WEQ1ZXpKVG1BYTE0bHFyekVlc0YyM3dVWTlo?=
 =?utf-8?B?cjVSVEdrRUZXOG1rSVdmTllhdjB3VkZ3VjBDQzR4TlBVeDc2VnJ6d1ZVcWJH?=
 =?utf-8?B?TjVYZ25PamFpNWlXRXY3VTRxQzU3cWxmV2kwSjJaVW85Mm5LNGIzUjFZenBu?=
 =?utf-8?B?SGgyU2hPL0g2ckIrTi9HblpocFRYTDBSOENJK0FiZnd6OGZBSXFtWmMxQmhy?=
 =?utf-8?B?Uyt5SmdHMDcxYWJKWEhKZXo5TTNucllUNTg4UGlXcFhhMkFCamZqVWJmTzhQ?=
 =?utf-8?B?WTBYRXA4T2JXZUpGNExOT01PbWJocFpnaTVVRmVCZEIyeXFhdUVCcTRhait5?=
 =?utf-8?B?UVBTS3AyNHE5REJMT1ltRHFpcE9QRzI3WHcvSlBGdXhTVHMyV1VEYnVGeXQ2?=
 =?utf-8?B?ZWZSbEVwNE5ocmJtMFhBV2ZLcy9tNUc1c3plVXlic3l4aUFDRWw0eXFzbSsz?=
 =?utf-8?B?MlU1a3RTU0d4NG5qVEgyZVJSTHZNaFE5RXJlYThoVnBUT0ZacW5BVHgyYVBm?=
 =?utf-8?B?UDlZVHpLQ0NtOS9TZFVPSi9PQ3JWRWRpQnRJeGJ0NXk2YkVmQ1B1eGZiMFdX?=
 =?utf-8?B?QklFd2hHcm9DL2pQQWJqSjZ5ZDNPUmtpNlBkNnpPczFkUHJ5NU9XS0ZWYU92?=
 =?utf-8?B?MHAxRkk0VkltaWtoUTJ4dDRReEI5ejN1dUpnV1pvQkdUSjMweTNxT3R5N3VB?=
 =?utf-8?B?N043L0JzYUtUbTNiaElucUpRL0NBc3ZIMkd1VGUwTHYvWU1GOHE2TVRKYWhS?=
 =?utf-8?B?NjBVNlFaeDl1NHE2QXpWTkVXZ3NSY0N2NUxZVjZET21wWHZTeEg1emtQdXd0?=
 =?utf-8?B?YjBJNFdkVnQ2UUI1VlJ2aFROY1NobFR2ZHpjYnJhNWF2OFpPZFFlUFc4bXpr?=
 =?utf-8?B?RC9hUEwvME9mUEErZXBUQnhJbExuVGlHMjg3VGNKNjJVdXJYS0d1RmIrcUpi?=
 =?utf-8?Q?twr9df?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1c4VzlTYm5RMTJxZjNlZWs1bjVyemZZMDdIUlBubDBrem9ZTDkvQUhiYmRV?=
 =?utf-8?B?c25KSzJkcnVWcGZkQnFBUE8ybTJobml0ODVMaTIxbnpxakQvY2dndVVLZFV6?=
 =?utf-8?B?V0dkRHhKQ214Ykp2RjlMdno5K0RudHhicUhDU2tQaXM0Yk5PV3oxZHNONGNp?=
 =?utf-8?B?ZWlOZmVsOTdrUkZSOGQ5MmpsaHh5dzE4M2VuL3hSaTloLzU1NXpWRllEY2p6?=
 =?utf-8?B?UzJIcmtGT2RWdjYrc0w3czlEZFFNSkE1OVlNcXlPTXZhSU5PQ3pOVEhGVkN1?=
 =?utf-8?B?SE9HWnFGTVU2QldIMHlZd3dmNktqMkFoWWZNRlMxQnV2aWFSMVdTckRDK2ph?=
 =?utf-8?B?WDNRSmo0RU5aekFKekx2OVNiTnh2MUlPTTd6KzQrcEFhV2tCMVpySVVwL2lh?=
 =?utf-8?B?cXFIZ1VUdWVqQ1hzd2l5ZG05M2poVXgzWlV3Q2toMm9ibjhZZWRGcWxiK0ph?=
 =?utf-8?B?OWFzZ1RTTUZ2RThLRC9pMTlRNVJrdnU0TkZlZjdsYU1udjB4UTFURnhtUTJz?=
 =?utf-8?B?N0pzcForUUQyWTkwZEVzWDF3TU8yL0dVQkpLRlRVOFViK2phUi9WQU40SWZW?=
 =?utf-8?B?emlaMGhNa2p0NFJoZmZQU2p6eWVIZE5JZThxSy9mRlJqOGJqQnRjNlRuOFli?=
 =?utf-8?B?MjVPT0hzeWgyN1k2ZStSWGhybVZObkdmdmdsSHBEdXNRc3pRcFhLck9kZisy?=
 =?utf-8?B?SG1MMmhHckpaakIrUld0TDFUd1Z0T1EwRUVLWXFPbkJVY0hxVFd4M05VZ1hr?=
 =?utf-8?B?TnBMaTRJaHNLKy8vSWszYUlKUTZ0WlQvMlNLZ2k0QTJ4a2xLSFZJTFNac2VV?=
 =?utf-8?B?WUZQWUVTR0ZtcVIxUnJBblljK0dBcXFtVjdsNFBZOEY1ZDJXck54Ulo2ZDBt?=
 =?utf-8?B?a0RaYUlwcnF5aWsveUZ6VUUzYVk3M0VDY3QycGk3YWpxdXo3aStMRWtEcGx1?=
 =?utf-8?B?YVBNVy9ZbDNueGpMUUhpeXZlOXRFVXk2cGRXeTduSDY3V3RBcTRkNkdVMzBG?=
 =?utf-8?B?OGR4VEZOYU9KSlhTVkJ6bVFBb3lkTW5pM3V1ZjN1MGdKcm5oUW9mWDhnSm5i?=
 =?utf-8?B?N1ZjNlYzTHppampuTFBhSGZ6QjNvRDhvZ2lrdnFaNmdpM3MwK1NsaGZJdHhG?=
 =?utf-8?B?aVlud2E0bjA4UndQRjZMYzlYNktCUWdPMjBnR202Y3IyRzN0R2tUZmh0Ulpk?=
 =?utf-8?B?RXlqUmhNc3dGZWFxZXZLNVJUVnNmeEp1RXFyK1BUbXhjTVlabzFIUXBYRWFj?=
 =?utf-8?B?amNhUmFjckFiUTh3YW9WZ3VQdytwaWtJMi9FRURRdGkwa2hXVGlFSE9obnBn?=
 =?utf-8?B?b2xONjVaazgva1JHRzBXUGJ0SzRiV05JTWUvZlYzMVViN0ZSWXd4ZFk1S3JB?=
 =?utf-8?B?TzV2TEMxczhSbmJZOTBYK1ZWT3d2ZDhVVDBoZmR6WncwSGYya0NhZ0paaXRt?=
 =?utf-8?B?QXcxa292ZWw0d3NkdU9UbWJYVVRPSEkxTi9PRTE2ZThqcDQ4dHJEWi91bk9m?=
 =?utf-8?B?a0FhVjdTS1Q0aU92SVdZZHFzeXFrYzZMckZiQ1RPUlM1WWFDakhHbWNiUmNH?=
 =?utf-8?B?WDVac01xcWFsZDhGdHgvNmYvazFuNk44WlR4NlJ0Q0ViS1U3eVRhd1dYb0FJ?=
 =?utf-8?B?cEVEOEcyRUduZ1NrRlNqdm82REU5ajYzNkZqQm9YeW44d1plVEdiNzh1YU1t?=
 =?utf-8?B?T2VuS09DVUVpdWEycXk1VmhhclVmYU4vNXlSL04yUXVNVXc3WEM0ODZwMTNC?=
 =?utf-8?B?U2VyREtpT3pRREU2allVQkdFa2cwNHFRY2JoL2lERzJmQzdSc2dHVzNlUDFB?=
 =?utf-8?B?Yjl4S2JlMW9oOTZHYzZ3RU9ibVYvdG1aaTlzWkYxajM0R2FkMDJjenJrbGlL?=
 =?utf-8?B?cjEzMStpODBMM1dUVGsrV2hRSWkzdTNlb2VFNXdPak1DSzZzWEJYOHl1SFlj?=
 =?utf-8?B?SmV3eXRrbk1TbDNKTHFNTldocUNmUDRyUjhNSlBaTXY3K0cvc0p3MUlZMkhF?=
 =?utf-8?B?MzdtRUs2SitIbE1DNm9ZL1hFL01laTIxRDlZUnZuVDFIVEZoSVptYWoxSC9n?=
 =?utf-8?B?MUNyWnhnSlZWaUZHZVVFSmc0eFMzQTRRcTFqZ09FTTMzaGkwaVlVZ2J2SGQ1?=
 =?utf-8?B?MExIS24waWRsanE1cnovNEZCQXRyVzR5L3VXZHErem9DTEN3aXJjT0ZHVUZv?=
 =?utf-8?Q?QrW+pTVeHINsZvSgKWzAIVZP45V6a9GB9ymCGQlRsLA4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0843F9016788E34C8D7594260F2D9B8D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf191533-d589-4f7d-3981-08de3e6d6338
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 19:41:06.9918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pg5jLEAiMANJHvviZ//DTp6XVnN+lHI0Bz72eJcZhr2EJOxSw0/orMTJ8QeCzk9twQEgqHcwlVHPbjDJE8IjsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285

T24gMTIvMTQvMjUgNzo0NCBQTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBPbiAxMi8x
MS8yNSAwNzo0MCwgWWkgWmhhbmcgd3JvdGU6DQo+PiBIaQ0KPj4gVGhlIGZvbGxvd2luZyBrbWVt
bGVhayB3YXMgb2JzZXJ2ZWQgZHVyaW5nIGJsa3Rlc3RzIG52bWUvZmMsIHBsZWFzZQ0KPj4gaGVs
cCBjaGVjayBpdCBhbmQgbGV0IG1lIGtub3cgaWYgeW91IG5lZWQgYW55IGluZm8vdGVzdCBmb3Ig
aXQsDQo+PiB0aGFua3MuDQo+Pg0KPj4gY29tbWl0IGQ2Nzg3MTJlYWQ3MzE4ZDU2NTAxNThhYTAw
MTEzZjYzY2NkNGUyMTANCj4+IE1lcmdlOiA5NWVkNjg5ZTlmMzAgYTA3NTBmYWU3M2M1DQo+PiBB
dXRob3I6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj4+IERhdGU6wqDCoCBXZWQgRGVj
IDEwIDEzOjQxOjE3IDIwMjUgLTA3MDANCj4+DQo+PiDCoMKgwqDCoCBNZXJnZSBicmFuY2ggJ2Js
b2NrLTYuMTknIGludG8gZm9yLW5leHQNCj4+DQo+PiDCoMKgwqDCoCAqIGJsb2NrLTYuMTk6DQo+
PiDCoMKgwqDCoMKgwqAgYmxrLW1xLWRtYTogYWx3YXlzIGluaXRpYWxpemUgZG1hIHN0YXRlDQo+
Pg0KPj4gIyBjYXQgL3N5cy9rZXJuZWwvZGVidWcva21lbWxlYWsNCj4+IHVucmVmZXJlbmNlZCBv
YmplY3QgMHhmZmZmODg4MjZjYWI1MWMwIChzaXplIDI0ODgpOg0KPj4gwqDCoCBjb21tICJudm1l
IiwgcGlkIDg0MTM0LCBqaWZmaWVzIDQzMDQ2MzE3NTMNCj4+IMKgwqAgaGV4IGR1bXAgKGZpcnN0
IDMyIGJ5dGVzKToNCj4+IMKgwqDCoMKgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIC4uLi4uLi4uLi4uLi4uLi4NCj4+IMKgwqDCoMKgIDYwIDFhIGJlIGMx
IGZmIGZmIGZmIGZmIGMwIDJiIDA1IDczIDc3IDYwIDAwIDAwIGAuLi4uLi4uLisuc3dgLi4NCj4+
IMKgwqAgYmFja3RyYWNlIChjcmMgMTU1ZWM2YzUpOg0KPj4gwqDCoMKgwqAga21lbV9jYWNoZV9h
bGxvY19ub2RlX25vcHJvZisweDVlNC8weDgzMA0KPj4gwqDCoMKgwqAgYmxrX2FsbG9jX3F1ZXVl
KzB4MzAvMHg3MDANCj4+IMKgwqDCoMKgIGJsa19tcV9hbGxvY19xdWV1ZSsweDE0Yi8weDIzMA0K
Pj4gwqDCoMKgwqAgbnZtZV9hbGxvY19hZG1pbl90YWdfc2V0KzB4MzUyLzB4NjcwIFtudm1lX2Nv
cmVdDQo+PiDCoMKgwqDCoCAweGZmZmZmZmZmYzExZGUwN2YNCj4+IMKgwqDCoMKgIDB4ZmZmZmZm
ZmZjMTFkZmMyOA0KPj4gwqDCoMKgwqAgbnZtZl9jcmVhdGVfY3RybCsweDJlYy8weDYyMCBbbnZt
ZV9mYWJyaWNzXQ0KPj4gwqDCoMKgwqAgbnZtZl9kZXZfd3JpdGUrMHhkNS8weDE4MCBbbnZtZV9m
YWJyaWNzXQ0KPj4gwqDCoMKgwqAgdmZzX3dyaXRlKzB4MWQwLzB4ZmQwDQo+PiDCoMKgwqDCoCBr
c3lzX3dyaXRlKzB4ZjkvMHgxZDANCj4+IMKgwqDCoMKgIGRvX3N5c2NhbGxfNjQrMHg5NS8weDUy
MA0KPj4gwqDCoMKgwqAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzYvMHg3ZQ0K
Pg0KPg0KPiBDYW4geW91IHRyeSBmb2xsb3dpbmcgPyBGWUkgOiAtIFBvdGVudGlhbCBmaXgsIG9u
bHkgY29tcGlsZSB0ZXN0ZWQuDQo+DQo+IEZyb20gYjNjMmUzNTBhZTc0MWIxOGMwNGFiZTQ4OWRj
ZjlkMzI1NTM3YzAxYyBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gRnJvbTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxja3Vsa2FybmlsaW51eEBnbWFpbC5jb20+DQo+IERhdGU6IFN1biwgMTQgRGVj
IDIwMjUgMTk6Mjk6MjQgLTA4MDANCj4gU3ViamVjdDogW1BBVENIIENPTVBJTEUgVEVTVEVEIE9O
TFldIG52bWUtZmM6IHJlbGVhc2UgYWRtaW4gdGFnc2V0IGlmIA0KPiBpbml0IGZhaWxzDQo+DQo+
IG52bWVfZmFicmljcyBjcmVhdGVzIGFuIE5WTWUvRkMgY29udHJvbGxlciBpbiBmb2xsb3dpbmcg
cGF0aDoNCj4NCj4gwqDCoMKgIG52bWZfZGV2X3dyaXRlKCkNCj4gwqDCoMKgwqDCoCAtPiBudm1m
X2NyZWF0ZV9jdHJsKCkNCj4gwqDCoMKgwqDCoMKgwqAgLT4gbnZtZV9mY19jcmVhdGVfY3RybCgp
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoCAtPiBudm1lX2ZjX2luaXRfY3RybCgpDQo+DQo+IENoZWNr
IGN0cmwtPmN0cmwuYWRtaW5fdGFnc2V0IGluIHRoZSBmYWlsX2N0cmwgcGF0aCBhbmQgY2FsbA0K
PiBudm1lX3JlbW92ZV9hZG1pbl90YWdfc2V0KCkgdG8gcmVsZWFzZSB0aGUgcmVzb3VyY2VzLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNrdWxrYXJuaWxpbnV4QGdt
YWlsLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9udm1lL2hvc3QvZmMuYyB8IDIgKysNCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvaG9zdC9mYy5jIGIvZHJpdmVycy9udm1lL2hvc3QvZmMuYw0KPiBpbmRleCBiYzQ1NWZh
OTgyNDYuLjY5NDhkZTNmNDM4YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvZmMu
Yw0KPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9mYy5jDQo+IEBAIC0zNTg3LDYgKzM1ODcsOCBA
QCBudm1lX2ZjX2luaXRfY3RybChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCANCj4gbnZtZl9j
dHJsX29wdGlvbnMgKm9wdHMsDQo+DQo+IMKgwqDCoMKgIGN0cmwtPmN0cmwub3B0cyA9IE5VTEw7
DQo+DQo+ICvCoMKgwqAgaWYgKGN0cmwtPmN0cmwuYWRtaW5fdGFnc2V0KQ0KPiArwqDCoMKgwqDC
oMKgwqAgbnZtZV9yZW1vdmVfYWRtaW5fdGFnX3NldCgmY3RybC0+Y3RybCk7DQo+IMKgwqDCoMKg
IC8qIGluaXRpYXRlIG52bWUgY3RybCByZWYgY291bnRpbmcgdGVhcmRvd24gKi8NCj4gwqDCoMKg
wqAgbnZtZV91bmluaXRfY3RybCgmY3RybC0+Y3RybCk7DQo+DQpkaWQgeW91IGdldCBhIGNoYW5j
ZSB0byB0cnkgdGhpcyA/DQoNCi1jaw0KDQo=
