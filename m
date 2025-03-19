Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E74191F7F
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403248; cv=fail; b=qQiv1kQgR5E6qURcoI2kGPs6Il7wU+1DIEwbn9UrLu3QYZnY4yblEw6dbRoHfg0Lf+VtbPJu65nFigQt/8U/y5fbFAt7BYI8oML2uCEBpiqH+un1IMR9AxzpPCKgcyu1XxDG+0D79Y38f5AWzF4983OgegVYcDSe4+TOR0dp2z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403248; c=relaxed/simple;
	bh=y85/vS6VugAJhnlJj2g1gEibZY2EQxYylXbw1hUp3GU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D5hYOc8aLM0CQEGHNlyBUCRATg5mPCFGNfVJKrvtcCd9p7sJWdV6RvDWIWj8IFFpe+CT9bwIyGvDw/63lkzccHAUVCFrGo8HSCJbgz9ja9tlflLe+6OHbOfv2840HpYr8kvfb4NnEqbAThBSq97CvizOOMHavEytFFWSn2WB7+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G/F0cKEP; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G/F0cKEP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIc1dhVrufyOe1rGj4qTVNJvY5aUDHLPD1KuhgWTaoeYZDMgUkwyNcTfoa+IKAp+xDf1EKPDqGYHoeFTsM8s4PcA7alcf0Va/alQcRT7OovqSsoLgu4kTYtQA+jbuV3GKNDN3aAKe2ljIDIf8tjxYnAtR/dOYUdOY4uxBC3NQ/C88e8w9n1X4WqxLHvuelIgYelMfl1R6eSSF4QEiHAC/e5gyfvkIl/9n/JFccTTrRqZNH8w1Mzk+2LK3MbuXBDK05BRVNW3iTKvGLmeIFo1hZwgPzUZ7KuiSN/Kr7DzITprzAq0Xfu/Cih4JJwrIYSWS063EndZNagrEKZ3xLqXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y85/vS6VugAJhnlJj2g1gEibZY2EQxYylXbw1hUp3GU=;
 b=nOZ+gF8Sllb336z9KkqExVwRIbBda0qGYdd05uh63sccVEijjxjCPtADhrSH8QMpFpJh8S6TfkY1r86GJdb4Og4aTEepsFT2n80fv0BEE8RRwumc+DaovJc7s/gnFniQH96vZv7Cyb3v0shAFC/nyY8Dbnq9pFm2BU6mGsUkfYpxcIXrUDuIZgQFRmBZzsqFKx2YyqlEdZ5NkFMzgUF5xn7k/Dn3FfKRJSZ5pcSukpV/1oH3dV6+lsaUpLq6JvqMUUZv0PE+H50e31CVnO1ksKDAKYg1CM1wqhArQwwKXRJJ0lOdPi4a4tEMTa9GrfsVsnnlXd5PzuZ/0PxKSMEkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y85/vS6VugAJhnlJj2g1gEibZY2EQxYylXbw1hUp3GU=;
 b=G/F0cKEPg6MuHVIxLIxgiED0W6k3JdvPsYeMGq+0hcG4AsA2XzUKI2vdRC2dD3QPFX/v0fkLRiiC3aMo4ibCfuroebo5eUsPFT2BTcSFUYKyZMKP+JQ8f6vy8vcqS5cjpbxSxh2FX8tzW9ytauJWoX0tiziLc/nYBdk8VWuZBdJT8v0iNfpy09TdxoalDJNrcfBRRfeicIjz8bkdLRbyGO/RjVFZvlMeTH6cW49qsRBVoWPtPz4vBqTe/crH7ugBWn0F9rGTxHrB+ODMuAGm41pxlWFu1DOij51OeKaOkLaEdB3x9/fskcq1LiImo1rZVZrPtgU5i4I5teZoXBbhtQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 16:54:03 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 16:54:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Daniel Wagner <wagi@kernel.org>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/3] nvme/060: add test nvme fabrics target
 resetting during I/O
Thread-Topic: [PATCH blktests 2/3] nvme/060: add test nvme fabrics target
 resetting during I/O
Thread-Index: AQHbl/IXg+UsERowl0G4c2riNFe+TbN5XCCAgADWB4CAAHz9AA==
Date: Wed, 19 Mar 2025 16:54:03 +0000
Message-ID: <d9e7020d-9516-4f67-befe-86a47fcb3f49@nvidia.com>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
 <20250318-test-target-v1-2-01e01142cf2b@kernel.org>
 <4b2433c7-5291-4b44-b7c7-ec4521b0a3d8@nvidia.com>
 <040089eb-aee4-4311-b1d1-d8d11d242804@flourine.local>
In-Reply-To: <040089eb-aee4-4311-b1d1-d8d11d242804@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY1PR12MB9601:EE_
x-ms-office365-filtering-correlation-id: e233ba20-c9a3-42fc-fa4e-08dd6706a76a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aW05Ym9ZUFVLOHA2cGZqYThKOUJ3amJXQVI4cGpHUzMySmFQSDBUdlNMTEc0?=
 =?utf-8?B?blJ3WUNwMzNRU2U0STFIZGJIU1VPSmVGdTRTQ0JrTHV4MzZPOTlZZk5ERUN1?=
 =?utf-8?B?UHJRN25OeVdzNTBNWldZYSs3d1kxNFRjdDNqYXdGeTF1YkorZEo0bGpPTGRu?=
 =?utf-8?B?RHFMSHJrQ1Fab1VxOEozTTRpTEc0cjBzdVFubUs0T2IycEpOS0lrdnZKV1dP?=
 =?utf-8?B?aVZmNlUvN3dVR2QwcDRBbFR0cHdxWklMY29UY1J6YkRkYTJISlN3NmZDTllu?=
 =?utf-8?B?NkdtdjhtZzBvSkZKazFDR21EQTdLTmRDSGh1b3g0dlRhMTZCMjB0Wk9ua0dZ?=
 =?utf-8?B?bFc5MHhOZGVmektmczR0V2NNbktmYzhVcDZJbXo3d2VHUWlLWUpaQ0VnVGxS?=
 =?utf-8?B?eXNXSHQ4dm5GY2lENFZOR2lJU0kwZGJIWGljYnBva0JCaDVmRnFjamZzd01V?=
 =?utf-8?B?OUc5aVJqVERuTEpFaDJWSXV1RE1VeERrSmxtOWQ1dS9nVkhsanRXSTlkelJ0?=
 =?utf-8?B?Z2dtMytBZlJPK0FLVENWQUg1RC9EU0ZKT3dOeC9rOVdYTXFjY0h0SmtnQ0Fw?=
 =?utf-8?B?bzBENjM5cnBDeXpLNEVFSGkxcWkyTUZiS2JyWUdrY0VpUjdJZXJGOGNIcElp?=
 =?utf-8?B?YmxYOVFpTUJ2dTY5b1VZaXNTMVhtMmgwK0VHV3lxTFVMTzJPdktBUEFRSHNy?=
 =?utf-8?B?OU5zdTc3RFNRcHdCdzRVb2owSTR5cmU3T0dKV3E5MEZzODl0bHJYZjYzdDdz?=
 =?utf-8?B?OFZ6QytnUkVzcFpVNzlRUW9RbVZqaHZUMTBPUEMwbVRWUmc4RTZ0S0VRSWE0?=
 =?utf-8?B?Y1dUd2NpS2dGVjlTRVd0YTNVdHBIS04xZGJ4Y3FFSTV4SVVjY09PaGhDWkoz?=
 =?utf-8?B?dFZiejNmMGhCbVZNUEpaZ0dtUDc1SHJzMXpWRUlCbFl6Yk16azlYVTI3d2lK?=
 =?utf-8?B?YkVSMUt3cWxGZEZTZVJCbWVlVTBiQUdtOW9JbVArNkwwaStTTmdkcjNtN29q?=
 =?utf-8?B?bkxTQWJoSG0vWjVWdStCMkZYbEdicHBsazNwanN5RmZGbmRlMURva1I0bzhP?=
 =?utf-8?B?TVQrUThyNmJUOHRaZmdIRy9MTDRHd2tYaU0rQmZCZFl6ZThzZy96U1FxdHZU?=
 =?utf-8?B?bjNtOW53MnFyTk1JL0NpbTlHcnduc0Jia2pJV05teDNSMkVNaXpNcy9jU3dX?=
 =?utf-8?B?eUd0QWdycm82eDhXNnJWWDVxYmNUeGR4a2p0VTNGWEZBaGl6RHR3L1UxV2tK?=
 =?utf-8?B?cURrOExlUDhZOWpjNGxCM3hsN1FpQldNSEU1OE9vNHpVdmJyU1dkMWhMV2pm?=
 =?utf-8?B?d0ZtbnFJSDQxRDlWYVBzQjRDM1o4S29aTER3WGJzRDkxa2tRM1BwRUkvTHE0?=
 =?utf-8?B?ZGhoejRqNDl4dnloLzJpaW4xbnMxT0lwUVB0ME5sSUtuYkZ4YXZlcDIrdHhV?=
 =?utf-8?B?WnhNSHdJOGNzV1ZqaW5tWGMzMTdUQm9JSnhsQnZiQ2lxWWVxVjZWbmgyR3I2?=
 =?utf-8?B?VVJackthVlFlQUh1VXp0b0xZWlAwNUFOSjl6NEVUNnlMZzFoTGw1cFBwWVps?=
 =?utf-8?B?bTJzUkN4NjZpVXR0eFBjT1Q4cjdRQTZXOHI0NXdTcytWTm9NK094ZHdZLzFv?=
 =?utf-8?B?ajVkSXdOSVMxOUVHTldzMmNMU01jWUpNV2E4WU8rc2NZTjNhV0lSSzV3VG8z?=
 =?utf-8?B?MlIyVmw5d0hldkdhWWVtc0VRNFZiUFdwQlFaR1p2aC9IWDFKUlk1RlNWMmpU?=
 =?utf-8?B?M0wrMEV3cW14S2VUYVMxK0VMZ3NxS0dLcHJ0OWJ6RG83MTNSTjZ1WWJZV1Fa?=
 =?utf-8?B?VGtEM2JmWitTOVR5cEpPNmhyL1JZSmNuQmI3bHRZSFc5NnFCcVlEOU83V2Rj?=
 =?utf-8?B?dVJoalBaQnZLL1IzVFRQZlYzTm9EQVF3VklKNzFhTEs5d1BrdUtqK3MvU010?=
 =?utf-8?Q?dN/fSLxVsPaxQeF27Aqchii7UmweG7LC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nlk3cWZ3MTJ6UElpNWhDanI4WlRVb1pZeHpwOWptaEdIMk9xWTRqNjA3dG01?=
 =?utf-8?B?TGRXc1lsM1YwQS9HMVIzenBBNlhUK0ZyY0kwTkJVREg1bmp6WTkvdkNxZUlv?=
 =?utf-8?B?cCtXM0h2bWRhQ2NPS2dGUWVSRUhwb0o4ejZaTk1zZGpYOWJzM2RQdi9Fbndh?=
 =?utf-8?B?OEh6YUNhV0h5K3ZDQ3QzL1A3bFVWVmFOYXdYWnIyZG1BY3haMTNDU3p4L3lQ?=
 =?utf-8?B?eGFITi9RRXJncDN3T2RrcU5EOVVVQkZrd2J1eVRIczRiRnQ3aWpGeHBVM3Vs?=
 =?utf-8?B?bVZyMXVVWjdGMERKNHVMbW0xaElEeHd0RmJoQ2s3SmVUc0MrSHhKUGJCMWtt?=
 =?utf-8?B?aDVtcXVITDI4d2hPbzFrMS9TRXk1SnBJL00ya2xGS3lab2dqWW1BdlNOWDFy?=
 =?utf-8?B?Ymx1VnVuVmVtK2ZCZUV5Nnh5dXh5cVBlMnNjV3dHcU04UjRjUWk5a3RjLy9k?=
 =?utf-8?B?UTQrMjZFaUdhZXM1alZISmErbjVTb1NxazlCdFlxeVNQNnYyZGU0anJ3cndZ?=
 =?utf-8?B?Y2ROQ28rU2VwRUdXY3VwOUhGQVBEeS9GbmlPUUpYYmNDdkpHZVVzYVB5Q3Vn?=
 =?utf-8?B?czFuTlU5TW44RmRVZ25UUVVTbXllelBKOG80bXlUcEhqcUdJU01jM29yNkVK?=
 =?utf-8?B?TE5ZaDR2aHhYdjRQdEs5ZXNkZXd6U08rSnBPbThNSldzL1E1WDRKZ3FjeU0x?=
 =?utf-8?B?YzlhQW1UelIzZndJQTJ3Q1ZSSk1QaFhTYmY1RGtIN1o0QkUxcmlvUHluMjJ1?=
 =?utf-8?B?SW1Uckh1dGhCMmdjR0NxMndkY0lmTGlnODZiakE1Mk5Ka2poQWRmZktpTm5Q?=
 =?utf-8?B?aHMybU5tNHdBRXcveFAyMlB6NlN4b1FQTjlKTlhZTDYra2FTbEQ1UEtqenVp?=
 =?utf-8?B?bndqK0FVTG4vMTBMa2dWV01wRWVEbGVIUWJNTFg0dmpyVFFIVC9sNWhvdHZ1?=
 =?utf-8?B?QzgwY0ttMW5QcVVCQmVOTVBKUTRLL3Erbk1KSDNpZVArUVJrbThCVE5CSGxG?=
 =?utf-8?B?Q2ZsM2VPQng2U3FYKy83ZDlmZWxFbmwxTWtTdTl2Nk1PYUIzNnU5K2sxbXBm?=
 =?utf-8?B?cG1FM0hGMGpOSzY2VW9YZkcyRXVPdWQyZGdtcGEycUR5TzFNcVFsZzFIMDNH?=
 =?utf-8?B?MmgybWpETGl2anFDRnF2WURIN000a0UvVW9VYy9xMmcvRnhaMWR2ZnhRZkUx?=
 =?utf-8?B?RlVWTVlhcE5ROFhYOWVoMWxGdnRqamxJVnJRMmJPNTRkd003cGh4YzhkR1lk?=
 =?utf-8?B?TG1leHkrVHpFY0M1Wk80Sk5YbzA0NGZ6YndIT2lpaUtuV1Jxb1Q2QUl1M3B0?=
 =?utf-8?B?WGlxN2pQZkU2bEdoV1dSTXNUVmM0QityN1ArYWVNR2xBVkJ3aGg5aEhEbmxG?=
 =?utf-8?B?U2dBWDYxYWNyVkVTcGhMWHVwM2IwUytHVlRta3NiTTVlZm4rSlFWdkwrWmZa?=
 =?utf-8?B?c1VaVU1KVlU4TEVUd0VRZW02aDR4QVBPTklQWEtUb0ZsU3Yrem1xSjRLSTFF?=
 =?utf-8?B?NndFYTVCNE16alBUSFlPTmVIS1hoaDJLR0w1MDRhNDFQRXZMVzVKQzk1aHlF?=
 =?utf-8?B?dldjWTE4NEljZmNCd1ZsNVZhUGkxdnIrZEJlb1FuNlJQYUdUS1pBWXREUXZN?=
 =?utf-8?B?SFlYVGtEaTFEdG1RWEljYVJtcFVWZzBETlE0R1RJeDJnQ3ZPd054WXVLb0lT?=
 =?utf-8?B?MHB6MktuNEhLS3Z3OG42QUpEVzJ0VHFlOGRVV1VLSktpMkoydWQrS3dzTGxw?=
 =?utf-8?B?T0RiY3ZVQ2E5ZmpmSURoVVFJd05oLzVVYWZ5OWoyZ0h3SkZJSG56c2VqVVZG?=
 =?utf-8?B?Nk4vQVlKeUE4c2pvemZZSWV4Q1dYQm5qK0kvM2FsTVhxS2V0SDZJMEVKY0hl?=
 =?utf-8?B?dkFkRTlNbGlaS3g4NGkrcVlqQXJnR0tpOUtsUkM0SCtVVTdURGpybDcwV1Vt?=
 =?utf-8?B?dm42RytFMFR5RHVCRy9mRnYzTDRMeEFTRDM0dWw2MVpZNUtvRnp0TndTOG1C?=
 =?utf-8?B?bmJlWG44RzY5dk53U2JlU0hOQjJBbVZSRmNVclBRLzhMNWtFRmRmY3VXSExO?=
 =?utf-8?B?Ry9pWTJ6L2NkLzhoQVh1S1dJZERsL0NhR2VVdStUd1poQmJkNlJLOU9XMk5O?=
 =?utf-8?B?QXRXL1pKTHhZd2l5ZlR1S1plU2g0U3ZNbzR6SXlad3ljeTVib0pjR09sQmVm?=
 =?utf-8?Q?QJ6oVcE9HRKyMJP3a9hbah77CzBnn1Ju3fZxt9nqsG6k?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B0FD724F770BE42B385EB8BD52DBE21@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e233ba20-c9a3-42fc-fa4e-08dd6706a76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 16:54:03.2551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kq04rUNczWmcwFssaZ553gmBaT9dgYDWyKNLvUJ/7R/sWEBtULlZfdkpZYcD7Crjgbl5g97gPhivDdzQGMeELg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601

T24gMy8xOS8yNSAwMjoyNiwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gT24gVHVlLCBNYXIgMTgs
IDIwMjUgYXQgMDg6NDA6MzlQTSArMDAwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4g
T24gMy8xOC8yNSAwMzozOSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4+PiBOZXdlciBrZXJuZWwg
c3VwcG9ydCB0byByZXNldCB0aGUgdGFyZ2V0IHZpYSB0aGUgZGVidWdmcy4gQWRkIGEgbmV3IHRl
c3QNCj4+PiBjYXNlIHdoaWNoIGV4ZXJjaXNlcyB0aGlzIGludGVyZmFjZS4NCj4+Pg0KPj4+IFNp
Z25lZC1vZmYtYnk6IERhbmllbCBXYWduZXI8d2FnaUBrZXJuZWwub3JnPg0KPj4gTG9va3MgdXNl
ZnVsIHRvIG1lIGdpdmVuIHRoYXQgaXRzIGEgZGlmZmVyZW50IGNvZGUgcGF0aCBpbiB0aGUgdGFy
Z2V0Lg0KPiBPbmUgdGhpbmcgSSBmb3Jnb3QgdG8gYWRkIGEgY2hlY2sgaWYgdGhlIGZlYXR1cmUg
aXMgYXZhaWxhYmxlLiBJIHRoaW5rDQo+IHRoZSBvbmx5IHdheSBpcyB0byBzZXR1cCBhIHRhcmdl
dCBhbmQgc2VlIGlmIHRoZSByZWxldmFudCBmaWxlIHNob3dzDQo+IHVwLi4uDQoNCnBlcmhhcHMg
Y3JlYXRlIGEgY29udHJvbGxlciBhbmQgaW4gYWJzZW5jZSBvZiBOVk1FVF9ERlMgc2tpcHBpbmcg
dGhlIA0KdGVzdCB3aXRoIHJpZ2h0IHJlYXNvbiBpcyBhIHdheSB0byBnbyA/DQoNCkl0IHdpbGwg
YWxzbyBiZSBoZWxwZnVsIGlmIHlvdSBqdXN0IGNyZWF0ZSBhIGhlbHBlciB0aGF0IHdpbGwgY3Jl
YXRlDQphIGNvbnRyb2xsZXIgdGhhdCB3YXkgYW55IGZ1dHVyZSB0ZXN0cyB0aGF0IG5lZWRzIHRv
IGNoZWNrIGZvcg0Kc3BlY2lmaWMgZmVhdHVyZSB2aWEgY29uZmlnZnMgZmlsZXMgY2FuIHVzZSBp
dC4gVGhhdCBoZWxwZXIgd2lsbCBhbHNvDQpnZXQgY2FsbGVkIGZyb20gcmVxdWlyZXMoKSBpbiBv
cmRlciB0byBzZXQgdGhlIHJpZ2h0IFNLSVBfUkVBU09OLg0KDQo+PiBkbyB3ZSBoYXZlIGFueSB0
ZXN0Y2FlcyBzaW1pbGFyIGZvciBub24tZGVidWdmcyBjb2RlIHBhdGggPw0KPj4gKGRvbid0IHJl
bWVtYmVyIGF0IHRoaXMgcG9pbnQpDQo+IFRoZXJlIGlzIG5vdCBkaXJlY3Qgd2F5IHRvIHRyaWdn
ZXIgYSB0YXJnZXQgcmVzZXQgdmlhIGEgbnZtZSBjb21tYW5kDQo+IHlldC4gVGhlIHVwY29taW5n
IFRQODAyOCBicmluZ3MgY3Jvc3MgY29udHJvbGxlciByZXNldC4NCg0KSXQgd2lsbCBiZSBuaWNl
Lg0KDQo+IFdlIGhhdmUgYW4gaW5kaXJlY3Qgd2F5IHRvIHRyaWdnZXIgYSByZXNldCwgdmlhIGNo
YW5naW5nIHRoZSBudW1iZXIgb2YNCj4gcXVldWVzIHRoZSB0YXJnZXQgc3VwcG9ydHMgKHRoaXMg
dGVzdCBjYXNlIGlzIGFscmVhZHkgdGhlcmUpLg0KDQphaGggdGhhbmtzLi4NCg0KLWNrDQoNCg0K
