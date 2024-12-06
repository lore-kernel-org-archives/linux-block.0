Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC0F2066DE
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493101; cv=fail; b=RrYYMgzskn3pgMC1lzYQIdJ0uKXr+R5W72eKhd6afJoJgSAlR0meGEGAeV3ZGxjT2vax5K2fAYiNTEBUF7WYi4AXLZPcWuwGyCVLoEQDPB/ILYJVztbijrk5uFXbbW6+G5DyNkFto+kTFYeqx2S45i6my3ZRgHu3qd8vvKcud+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493101; c=relaxed/simple;
	bh=OJKPOLs9nlig0q2ngXws9Buuykqbr3LuqjzdbdQwGHE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UCHh11x2v3TgGi0kdSI6vKB6Z5nQJgxM/mwNsnztlLgpBVR7/UYe9zf2N1r3eV/DeuxNlIjj7vHZM6FGgOqvc3JdrvRKJOmHq4UqvsH9g46dHgeqVDEyttU7FNvxXyOT6zn8CiJC0XjFqUhg9axZ2mkNQmrrez/uKWt5LY1F9i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WT6jq6G0; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WT6jq6G0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hhi+jrEFli5qkE3yjZrFXjTroIB5z2nbSGcpSa//0Byw+pHITAD3u6pXeeHZfzsHqqpbNL01Dj0fGl4N1qHb33opm5yi+/g2GH6K7aj5+wJGAsnePRKvBkGh0Et6UI2Ko+4YZgdI0wFD3SzTPkhPi/j7cOcFUXf6kT0qlNWQlqPlatTaKdTYA1Zd+CH96AyeAsQJffiGaqQ+A8BBxhRvNZZEQk74T20/33KubQm3YdNw8Lieqid7hfv/d6L95Bz+QxMw3J2hggWdYsqpu8c2458M5KfE/2UNkF+u+OSc8U1qm5BwgOsFPgjfW/sddgc5/OXL6ytZQLrXMDQ4rqnLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dAbjBdG7G19qFEvQxdfoCPLdOm+eDCduLnYQKh7O0Q=;
 b=hCTaKvIcFdxNkxF6gpv1icvdPkppPJh4ci7wPYtBGkI4mrf27wRTUkQ9D5NTcJTP1nsV9bVMaMd+ouRIwh+4SCkJnBOO4YU+A/6zaC+2jF04nalAvKGR9Jb5Ltd0B7nIp0klK4VSJaJr2aBdQD5iJQGO0KgUjqPmzX4H+mzl7yOVKVtdV6Ik10TXwALFXY8p1k6AOs1oxRJO00S6kSJVBnzieTOyP4gJRZNiGUAq8LIKo9NfMpkCQQuVHLggzbOzqpYIQ8i/Ge3A1GZPEQMSXpB2EGb1SaXcGSdNEfxyBNHXqNAL5SJYOyY4tngtJphZxOuQSLrJcedHpHKfMMD+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dAbjBdG7G19qFEvQxdfoCPLdOm+eDCduLnYQKh7O0Q=;
 b=WT6jq6G0XvV6xkK0hNv7e9VnLeCf7yUb7/OOQwAqZYDmOrFc7mQOP3Odc+s1YQ/zMKtCVB0g5dnYdzI5+07PyLjWMOH7/KD7frXRYQF2vU7AiKIRfVM6SXS3/NhqgCTmKFUIgZHyYJXJIoCgsQ/yJgR6YCX+xNTibMVzYbexMxn4uuXeu9OG2IF3k/tQ9el3u9sY2sMnFD4eVxZCswEiEk94hqxC2weKwCPCeQxUl3Vc+wGrIa+1gS6qtQA98ersmyJsfykeoZ+LELTBIjTMquONdhTHv6yMbmglHjGEmutEs9TXTR4qrHzeRATwpwClUmn2YRpnsFMhCmVENLpAtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 6 Dec
 2024 13:51:36 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 13:51:36 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: aaptel@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v5 0/5] Add support to run against arbitrary targets
Date: Fri,  6 Dec 2024 15:51:15 +0200
Message-Id: <20241206135120.5141-1-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::6) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbbce11-de74-488a-0818-08dd15fd19b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a1vS+32/Ee5nrjoTVNNhkvC5gojBoBo7ZcfTmdoQJvo6Z3QdxiInjfW4xzYr?=
 =?us-ascii?Q?NEE1SZXCmMx/H+2M6/CE3DSXFl4EC7IbO0MydIAir0LTJprnm48TzYAPSNr5?=
 =?us-ascii?Q?99ylK3SgAunnH2MN2Ng7yLHBLlvOsIq5qHZ3NJAGTkCpS/yh7ty9328tD77V?=
 =?us-ascii?Q?d3i9QnpdrTk8VPeV3yuRBF8zUu9YeZ972Q+nv23LWwdXSJ4SeZnFBmfMxPfF?=
 =?us-ascii?Q?0MUrxyI7FRda1ChSzUCWMRzAjj//HcX6dAZTCxHRMKnpfaIe+WucQZNCH+MG?=
 =?us-ascii?Q?onLPuIrn/AtwRyRhPLsbmmKJ6aCvd5GcGGHsaaJE5feeRB3tzK5QCAziZJUx?=
 =?us-ascii?Q?aXCwjFSrJIl5dyFYZOIm2xYBRKkpNtaXvWCRSS3vpRh/GcZnynK0IuaAsEbE?=
 =?us-ascii?Q?/fg1kRSh2i7qTvk3IW3JJc9k4D9AbWVa5wGwV/8XU6ebnVNITVD5Yg6/JwoN?=
 =?us-ascii?Q?QTfvcMDDkV6RFAZPaYGU9BUiGoKkHMyL4wZ7xlnNEL1hLEi8xyUHQFRF+XSZ?=
 =?us-ascii?Q?KNen2sNgEiN8Jqw/23NzO2ThBG/WdcS9MMnccDaScZtEtvIYbSIPWaP9OKlz?=
 =?us-ascii?Q?8nufTfh8Dp4P+6XKY0MGiQMkgGOYMvEf5hlYi+8AJIelFGGcvekYOjuwIq/m?=
 =?us-ascii?Q?9j32bWNgJXFufwpgoO/F7QjBETRrKYESdY7CbdfvPZPXtXVriBU0nLFpWHPB?=
 =?us-ascii?Q?f/gAYsaQ68ajA3vu/ldWTFyPXptIdNJnm34nEEpbppTe/ZtE4tdWhFRJNT44?=
 =?us-ascii?Q?X0LFaKUix16Eee217eUPh5lr50ZtBplMpefOZNWNmEDVsiNb/zQmi2Yf1m2q?=
 =?us-ascii?Q?jUEqDoZuoOzQUJzq3xpWB18Pmu9fODqG5//pzOsooBixF+oyyvOjmFgaoXd6?=
 =?us-ascii?Q?6agEJgNsHC1qqhJC/WACjUlnVHhtzR5tK0FPhOm69rd/hxVdryHBdxvSIv+d?=
 =?us-ascii?Q?NILC4hMOR6u3oiQcYTppBMx4eFfz3/xvvAQoQN/7561h3W7yRcjbr8y8f1nL?=
 =?us-ascii?Q?NR3KQwguvmDbIWRL9+e7rPKf68pFMJs/3/xAKjCnkqUXRNu4fDwJmOdNE3so?=
 =?us-ascii?Q?SnOiOTax7sHpPE4FlHoX/2paUd1xK0yajgtejuSymqqlQrKtD3MwROoiOz+N?=
 =?us-ascii?Q?dHqSL72pf4tVvZwR4EwHhqU3lky4rVXTs5MSh/dQpe40ktxdVSznAza6jvvr?=
 =?us-ascii?Q?yCjGrbNGoVrqQtXzA9U1iQxyI1/4T/QioX2cCllur7szQeiYZrTH0wVm+M06?=
 =?us-ascii?Q?E20jiC4vB1EryqDrgeACvmY93M6DwkkeNm8xC9ICbgkb6bNlAO06mQw4bqj7?=
 =?us-ascii?Q?9YuZAyvHphaVZZ2x7HdKrIONIa4AF8tN8FxxTxbs+tAJUNRXf3ynk1iIh44+?=
 =?us-ascii?Q?DPbX4Kc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7mM9Mt/UDvjDVk3v/GaQgp6V0inRfVavRG3xIx+mXxBmO838MbaJaipuIZ1z?=
 =?us-ascii?Q?/7qBmb3nx40ETwtMxdmr4fAh2y4aCf/5tjBqfQ0kTGGEsNtWKcipF35BTpGP?=
 =?us-ascii?Q?k3cfKrcsePDP1S/Mbhuo8J7Lzi9C9W5+DZd7ldj9eywJbaHToMMsiq3UVD5u?=
 =?us-ascii?Q?9dGFXpNkpXzA02C172mjRjAKxuPPhcpcOsoF8X5opFuSvV6yyU87zzMHrnmS?=
 =?us-ascii?Q?+DNZi8RkDYyJ0SjPCiKFN4yFVOreNULOx7s17mf7y/9nA4vHTwWIhEIUVoSr?=
 =?us-ascii?Q?PD3pMJFf9kr9pVF8e051KbYlBrwhQxqe62piWX/2Xkuyh18HIwqpinY2zNWe?=
 =?us-ascii?Q?byJNmyYXxxrDceAyns3UlW3dZRwRJKsbTp9405w3k18m9b1NM6m6cxj1z0j+?=
 =?us-ascii?Q?dLGYrQSzvexWOnOgEw3pTIFg/6f7iual1ktYAmR2uQfx8BfN03ET3SpxLWk8?=
 =?us-ascii?Q?tCH33VkzoG3xa+Z8Kq1r2WFebzti30g1xCzcgXM0kptxcCTtdzmqasc78L6B?=
 =?us-ascii?Q?CzkrddVyfxDugTU8sMN+NexEiSrLbXOCCLI10md/cxbWPKpXKM1ORdeWYGap?=
 =?us-ascii?Q?y8qe66+QXwp6Ehds528wzvEWEim4xdOQ1AaaOcOMYJ82Y3vTgqA2PHcU6Jo9?=
 =?us-ascii?Q?IhEh2oQ5LgrOsNZ21pdsU3kZF7X1AA3phM83ShlMxyRxXM1R2f2ZP+0uRMi3?=
 =?us-ascii?Q?/jEC1Auj7m+Dx6Bles+ZJQu3d4aEYnnTFZAugun0Wp9tWHuEzvE09BmmltKM?=
 =?us-ascii?Q?vgOrEjD4ci68n3SZXURd5j/5poPmCd3KisjAe8fT5y4GltYkeo/ipNqSyVC/?=
 =?us-ascii?Q?txwTXncYIkvsJSkGzmk/6j3Uo8Teuz45fABsFUifucocESZRN3bcHe5ACMNg?=
 =?us-ascii?Q?yHShMXpjtqNepaj7wN8FnQCsaZdX5nIEQPakIMEYiiIdqKTlRAvJAYTik/uC?=
 =?us-ascii?Q?KN0YhixJh0tQ0NI5ImQ2kKp3VPTmPV1eCmRvBhxKdj2BTAE0DZ3XE+V+K4ja?=
 =?us-ascii?Q?PD6Vm60+2K0AKi0Nlm1fzT4pRAmHcW9pM2WNTZ+Ueg1UsSLC77iAdwq54Js1?=
 =?us-ascii?Q?p2Z0XWPdUaqRtADd3zk0rYeUu2HZFx0iEjlkCVTwBDn00e06wFSEuKuY2Ykf?=
 =?us-ascii?Q?VfgxWOIiXKNzZvRIWQ4wJEBmdID+lJ0MAc/XKCf4EGzuFRiS5UZoOUdimI9L?=
 =?us-ascii?Q?WK85vmR8hJX3NtWaQ69U+QlOT2WWhJOk5Lkau+ONAwdjWAoalPuPPFRZtjAU?=
 =?us-ascii?Q?/78ifl3FLCZL5ZjPEX6hFWgw4MNRSjvX1pUolApasNSI3sYZ1QLbcPrO8SyW?=
 =?us-ascii?Q?OdFVK+2FnURKA2VG5p21ft9zf92m/lSRyIWUwpJ0yWwlR1e+g5FS5KOEQRyl?=
 =?us-ascii?Q?cUedAJq4XU2MkTRkSt1U2hK1GrDwXPNDhvypwciT2O/nOOseKdKWAY1OWFfg?=
 =?us-ascii?Q?WDDMD1LI8kQbQcpEnWmgb6ejAj+J1+ZNoEDnVjREZx80kf7nLGV7aVCHlbDl?=
 =?us-ascii?Q?86ut+7t/jEO2K6GA98Ce5UppfCG0N5HekxKhtxgCwUi2QryxPEJ3HNDOCW3d?=
 =?us-ascii?Q?QSoiI3UdbDkumJX9EOOy29M4CTuyt++6cgNaS856?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbbce11-de74-488a-0818-08dd15fd19b8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 13:51:36.0048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuJ1B0PD2q3oAGZIly7d75gNFMybFij3ostymxTX6Gy6zw7FyPkGx12L4lwPWkq8/1DR18TgPTIgwolRpoT+xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209

This series is based off Daniel's patches. It is rebased to work on
current blktests. It is also available on github:

    https://github.com/aaptel/blktests.git branch remote-target-v5

The last patch adds a test making explicit use of the remote target
support by testing the new nvme-tcp offloading.

changes:
v5:
  - remove duplicated code, truncate regression in _nvmet_target_setup()
  - remove def_host_traddr, use of eval
  - fix shellcheck warnings
  - cleanup test nvme/055
v4:
  - added nvme test 055 for nvme-tcp offload
  - added 'blkdev' setting under [subsys_0] in the control script config
  - added workaround for older python versions
  - https://lore.kernel.org/all/20241126203857.27210-1-aaptel@nvidia.com/
v3:
  - added support for previous configured target
  - renamed nvme_nvme_target to	_require_kernel_nvme_target
  - use shorter redirect operator
  - https://lore.kernel.org/all/20240627091016.12752-1-dwagner@suse.de/
v2:
  - many of the preperation patches have been merged, drop them
  - added a python script which implements the blktests API
  - add some documentation how to use it
  - changed the casing of the environment variables to upper case
  - https://lore.kernel.org/all/20240612110444.4507-1-dwagner@suse.de/
v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20240318093856.22307-1-dwagner@suse.de/
Aurelien Aptel (2):
  common/nvme: add digest options to __nvme_connect_subsys()
  nvme/055: add test for nvme-tcp zero-copy offload

Daniel Wagner (3):
  nvme/rc: introduce remote target support
  nvme/030: only run against kernel soft target
  contrib: add remote target setup/cleanup script

 Documentation/running-tests.md |  42 ++++++
 README.md                      |   1 +
 check                          |   4 +
 common/nvme                    |  78 +++++++++-
 common/rc                      |   8 +
 contrib/nvme_target_control.py | 190 +++++++++++++++++++++++
 contrib/nvmet-subsys.jinja2    |  71 +++++++++
 tests/nvme/030                 |   1 +
 tests/nvme/055                 | 268 +++++++++++++++++++++++++++++++++
 tests/nvme/055.out             |  44 ++++++
 tests/nvme/rc                  |  30 ++++
 11 files changed, 729 insertions(+), 8 deletions(-)
 create mode 100755 contrib/nvme_target_control.py
 create mode 100644 contrib/nvmet-subsys.jinja2
 create mode 100755 tests/nvme/055
 create mode 100644 tests/nvme/055.out

-- 
2.34.1

