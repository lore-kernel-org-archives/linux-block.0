Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D4E2EBBA4
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470748; cv=fail; b=WuWmgObERWLcMqQQ36V8wDzh8Apsmk6BaEFyTmYisA+XDUyuafz6VnO0CLz26107YuKVSYtCwvZRgzVTweh6EAyaPwZiiFEZsrvRNDsYUmfOjwuwEawMXFXzIGyFEH0wGwVH3rn++vnWpUb8jFAxbFwrvHPljcjsP4/C65hlZNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470748; c=relaxed/simple;
	bh=OLliCxY6EoCNlnuW+qwX8YOlHn2uEvFbGAz1ssPeLWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UuzlUbbyUA4nwmVXIRhdFarn67MJRk9fN+WDJ6ohIKb+IE6a6IsTdSGGfGbBLEi2hh0ArwrvyDLZnrFmrHULS9cypQUBnZPRiSpHV7fXCSrP+onnvTRH1sTGoppr5zyF6dAJmmO5R1JZl0kfWInPHrMHWFxm4TxNzfpMF3YmWGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S1y9oEKh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SQSDy3VM; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S1y9oEKh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SQSDy3VM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1777470745; x=1809006745;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OLliCxY6EoCNlnuW+qwX8YOlHn2uEvFbGAz1ssPeLWk=;
  b=S1y9oEKh8OZ09fT7euWgQvM7ExW10pGyp7LbXHq7BZmU+9NmFcot+7yG
   P9gDWNulaUb9MPMVH2KnSJJ8B6Oh5MzBCSJ+613gQnwq8QdAdPxrIUMEd
   /nxZS3leCnA3Orrjl2fadklJ3Axyt34gdpKwhZGbWVW8Jq4gpBiK73tX4
   N1Psp2ZcJ9R9MiFpLYWdNf7iOlk6Vtcpo55tJNtzMZ3ApQK4ffRgwHzu0
   8bCV5qmpZebD6YN6cyHpfGFHKqYWWCIWe1CUK0JffrfA19GCE55i5h5wu
   aTdfr0dnhsaao6pLtzE1b8QYIS+kUpNg7jlBgMcpQ/ISYLZXypMwZomo6
   Q==;
X-CSE-ConnectionGUID: gyxw9ML6T5SWuyexADx+3Q==
X-CSE-MsgGUID: k6gvFrkzRQaICTu/JtM81w==
X-IronPort-AV: E=Sophos;i="6.23,206,1770566400"; 
   d="scan'208";a="144412409"
Received: from mail-westcentralusazon11013036.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.36])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Apr 2026 21:52:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjcUOmse5sfsiRcJnNYVV9seVZwhkr1TyPtPpwYgWNi+us3YIlvzCss9IklKbO9dKvcrOMiF+fa9M1OD+PfYjad5wh9DUam3h4pVpSx30a8GGENAMToknE7ERHXjNarTzJ/vcLHQ649tDbL/U0eQ568nPqeH/q4w8yU1gUOwtGqZIsPilYxhLxDPXOLYfFFzfeVoEqkO9Tx96IS/Se57pLRBaCDLeLEOPGCQHNXpTfRor+RVIrWpEzEVjafLxwkiGNJqRE+at5zHnnHkeqqyTLBnjo+PPo/3CXdsrtRlMLsG+zsVZLFc1RSyHmfPAzs/OOzb3E9HQlAdif2I/O6efA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTnwMoFVu7vlmtTopr5j7ckvFUEVD9EFtqGwIk3VMHo=;
 b=qImYmRXYMTrKmC1cWnIldFd2TKZ2P1EfDwg7Hmn5khKjVdTt5iuvo1EeCOSVinXWjIAr9wnpPhfVX+cA+T3K8OMI6dKcePjbNMm6o0ITRrzbbcI/C5u/l0qXlD4H8MK2oCBQXLQg7CvFw4xf/WtRh4MrcyRbWEOE0A9NKtF/MMz9yCeD+6Y57AqIp/4Oc2JprlM5LQdN9x9b8ZcPiaIRxMiVVqmVQdsIVEYBbfaIXhmf70R04I5tNRYMNDvi+ZcBkmgLdlqk35MoEli/mxz+uVg7fR7byNi6+46Jftc7XAk9zACgC+ayeoXyi2FWHGolRnbqdfBxGmnEMY5fUWKKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTnwMoFVu7vlmtTopr5j7ckvFUEVD9EFtqGwIk3VMHo=;
 b=SQSDy3VMdzzPbwaENjd6Sd1YZkHmzcAhODHIpU0r0P68fahZnHHC82Cp4sAvZ61wKBcDxZPAseeu8iBQakUyYVwjMQmxLqW+JIGEqvoi4SgHnZmHZua3h9apw8sP57v2/XiNpIinrJp9+eioQBg4etWj+Ey+E1ZOOOuoddGBnk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BL0PR04MB6595.namprd04.prod.outlook.com (2603:10b6:208:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 13:52:12 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 13:52:12 +0000
Date: Wed, 29 Apr 2026 22:52:06 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] blktrace/001: Skip test when kernel lockdown is
 enabled
Message-ID: <afIGq_uV-l9_98Px@shinmob>
References: <20260424141143.64528-1-disgoel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424141143.64528-1-disgoel@linux.ibm.com>
X-ClientProxiedBy: TYCP286CA0187.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::11) To SN7PR04MB8532.namprd04.prod.outlook.com
 (2603:10b6:806:350::6)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR04MB8532:EE_|BL0PR04MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6c961c-fce8-486f-3df9-08dea5f68321
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	l1ZAvnV2q9USNfxoWrb8CiTP7qGg1uHEYM9DU4eZPUDeAuilJ0tGNL1DIRrNFk/wcPj0YOBl6ZQEOjZuttyOE9nRib9F5QwETs2wHNaiQnjoNW9u7f+qfEj5784x4h/0t+E3m+kYS66spj8g3dU/DFQC0+a62mNuMysJecOpYIVzTaIWRuPgb6s5LvD1WffrqLHCu28CKKwIi7tZ0tltgs+bbASCohXMAMlqTkuYquDXC2GFPhNUnM+oaX8UlqRDqBE1wL0wECvyjJ2YJBqM1sKPx2twD1TrHQ96Nw6ldoRZW51boK1rtqI0K0JbKUXPI0gNDBzVGxRwlba50in8snuzuvCaJv8GwvINdx9dtx6WgwIDpeo2kEsAEsTPJgyAidZxd6sf0a4bSJ4mU6bUaTuFpCmIxRQznVlyltJ36OBI1/cotVnlfaRMy97ByZZ4XmH00z0w5kgQDZ+6zeuaR+ydTeJOhkeDSDIfH0pt10HXBSr6hFG7izRW4TCVNRxGmsEH8sqjwhAo5qJzoYMBaxIulJDACv8RJKrpotmDYhyyheqGj1LDdVtMkH7v4vz4mQ2h+dqJiD3mx9Z7RMKuiYcTGdzoycle7QoWBmhpo9Jfd2W2bOQBwlMmP7gmVnuPnkOLgPq2Zj29yOiOXaZMavD8TyHcSW41kcQvvZ/zRYM1ft0gYAwqxAW0DsilQ9C136a18/P5fh8h9DumvMr7GsQsC2N8zNQbDPAARflzmOo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zkqpdxzf6q7y5OSPRXT5fcHHCHlNTVsMkdCAZftJMS2ClLS5Zet/XrAbthDU?=
 =?us-ascii?Q?Lbr4NOSyc7YR5xTUNtIwEzlylzFeoZmdilodO51eOfu8uNaDxsi1i5SFxNs9?=
 =?us-ascii?Q?PImFjQohHw4NykxO7xjE0sF5FWwJvF9tUIfgm9PsRzFHR/q7eeOd6c3TNN69?=
 =?us-ascii?Q?+vEfsYalonORZglKjMUxVLIa9cKqCyMRnsl/V/GuqOJqi81wvdqCwhjrNV8X?=
 =?us-ascii?Q?SEJ7kYob+p59t3Tn6L2pQ6UzUQCLr/w3vRkuAmKvJm0v06V3IFe3W45ZoTyH?=
 =?us-ascii?Q?JPBBeBULddS4uB+LAsAqZjgKENmYNxonO+g36a3rs7VQO4DmGiPjjzTZq5Rx?=
 =?us-ascii?Q?hgSuCLa0VS1QQ2RBA5o3FxebCp/Oem3Kw0boWHqng12P/Z0TdH6fPXxu0Igv?=
 =?us-ascii?Q?a02RzmWpfpNjQgDSFu4cLqurNe5imm6EzfyXiK9B9zE4lx1yHdNRVQlyAS5d?=
 =?us-ascii?Q?NuTg5EI0vpC4JmVI/lyg7TdR2eCw2D8s2Gs7wwBZaHPRyWdlYJuPZX1kzoGN?=
 =?us-ascii?Q?jloJlFQEJ/Uzvchd8cYyouwWBzJMmLJnqMEDcXzIQlKsY3mVkE9cfiYl4/lK?=
 =?us-ascii?Q?JLK0dwQw1dyZpSNtcDYHkh7WKs6oYDqXUKDKH4jUNlHP60hOkhNzUpXSenQg?=
 =?us-ascii?Q?rSFqA+xnRRyQMq+HrZ9pTY1JV2WQo3gQrPXtoww+3Xkymw5z3W/ow+LYxvb9?=
 =?us-ascii?Q?3iqjaUv1/aHKwK37gZ8nVaEZUtFQicjvH+epJlmrFu/p7VdutumhnvllToav?=
 =?us-ascii?Q?ia26cQOok8yC4YxcjmIZr8T3ZhS8rCa8ZFKYrLLg5UhN0/DXSGCRI5CtTzDC?=
 =?us-ascii?Q?MaUhwzSuce5lxYdTYmBdgZJz0tpK72ZtIcDxsSnUfrsLzO7HvG/9UdPvby6c?=
 =?us-ascii?Q?OWcTlzJ324BZTyBoYVOIymUgLvw6Rns5Km7LZpqvAMYYqPb+cTYMG2Ipdr9j?=
 =?us-ascii?Q?gWS2Mujo8U1s20L5kfn8iiTutbmh60KiiGXxiiCkmHGv+Qb01L+KlErJ0CSR?=
 =?us-ascii?Q?6mzio9VkaJ1/1nR9AoPcG40AAPcQdFogTYzzmuSaNwa8Voeb+XA0QSho7Sx9?=
 =?us-ascii?Q?IEsMBvx4Ck7+IwZpy0hUDwUy0oZTf3yg7CaC+J9zHlZA2d05lFPQ2MiTUeVW?=
 =?us-ascii?Q?M8Np8kNCNqMRSU6fjpPohcNzR4sswOMBdKpZEIR/uUwEjr6yDpS7rYH0lzsw?=
 =?us-ascii?Q?t1ZsT0BZE39bPLOAHf7XpcTXbkLA50zk1P+Z02iyeUkigUCJ0Ylm6TamzZ5v?=
 =?us-ascii?Q?3pF0APhFsGrDkLdqwI2CVfkUWM6VkMAoiUAyzQi/Qj7VJl5jValvESOMgyc9?=
 =?us-ascii?Q?uRaIvv8wHWS2R7xkFsAO+CEyVri2to7LXmHCg++tcGhf3irSN/Jap6hwAXvZ?=
 =?us-ascii?Q?NvCoxyZqU9zahRZciO4SVkCQH5JoTAIPJVvBmxu/Ca48LzkR3r1yDS2DbMvx?=
 =?us-ascii?Q?HaGZguizNhK5GY6Tutx5tW7qqxLlo3F0Lka43614/4Zi2Zj7eNYvUugoiTWV?=
 =?us-ascii?Q?HyHDBP+alKRKm6cZxy9Cz+Sy7E8z5zoGYCN7o1VmSQZWW8Z9dpuHxUfOVSwo?=
 =?us-ascii?Q?txo1DuIYnfzHeL2vTI1mFWV46kPtAdUqeWaL+U9UaIG8qsGV83RV7RKF68lI?=
 =?us-ascii?Q?q5MgY1z08SkRecb/CLb9pKPmZQU+9S/D4MBMv6Yfe6Je3pumtbiJlDfqOUYl?=
 =?us-ascii?Q?Z89/cHddXnz2svGy0OjnD5dJB9Bhj3WQtKctw1pgXhWIpEpnPpZ5nS0PZGNN?=
 =?us-ascii?Q?PtXyQfIN0XVlPo8QeolyZX9/RscpXDg=3D?=
X-Exchange-RoutingPolicyChecked:
	FjGPma12jkPve+sAaAwNcdtBrXJTtc5vztqKPixiiZCDJ/nGy9Yzs3x4EEnBk4SnRLLfkUyPPy4eEXkfuM2lWRDG9Bu+TteL1gzZlu9duY1MkNIn7IHSlj5pQZKHEuK7OydXVqG9Gh9+AbsbTPSe7innxynrs0cSUGbsAdZ/2KcLbjzIO22DWIVRY+MZwm+xgr64OjmbZzMejXqmuxkrT1YPmTOxJE4Ph+4M1907FJMjgNtMn/X7tJq5bxu+/wcCvVb9BmozeS4dNdqYqw90ripsgwwAuhXojVKmsIZcfIEQsx5zkFyYUJP6EgVU1OgVacg1Xsjlx+o8jUWxeWsoDQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OuANESYU4DtcobdQoeZ7gtLE34jfTJv7r8fwnXpBBPZLW2wKS/fyqYquMisJ8r1GgQINULFVrG62f7Ssarq+EzeY/eL00+tnlzv6S6A4HvlchYIOmkxBgSCsnevv2DQI5w67wh7NLKKv3kWwe4s6bsU90rZS6J57UHHdWm93owb52fGSOh2PNegjqh4GOIB1tTO1qnb8Yw8ZE9qsRMugPkXOscvASoC8IzntFp6iOZX/mJHVS54Qa3yxe0RG8dJvp88AczdvGZLcVPgE9OR0FxcyHif81V4amyHe/jGBbYPv2ONPyx0/zWbFllKYZMkvE99xb+qniPDc2+evQg7NfXTa+HDsHfkY9wj4dLno9F6SBE4KDe1aPpIFd8vEBC2Qrg7Fma8d+y3++t8zbOGzbwLDphNeiPg8bZSn9yc3b0TZyMJ8FnoPFgsHu6dvmNaojrkpob7MOnP4s1HojDDWY5wSKSLh7FHUbaWfrNbK247re/8HviSTM2FxwcY3b7brNwklN+5CwTCTTgw5vWZHMiO4uRG6zDWUPgzWSvaDWFH+bBSAOPbLdCDk7fmSpOn4Otrf1tR0Q1c0q7dtqsjQogSZEoo5+TfEhAHRxXP7eKnPLOfrm1REBixXc7C2+75L
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6c961c-fce8-486f-3df9-08dea5f68321
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 13:52:12.0167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PzrUzPek7+vNxvpqQmBD3cd0X7kn2htl8zDqef1FZuPu2Wu53DSm3pQjTzH3H/fQUJN7RULzdm+5cumvtbBhJtH9Z4APyILz1ZSh3V/WDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6595

On Apr 24, 2026 / 19:41, Disha Goel wrote:
> The blktrace/001 test fails on systems with Secure Boot enabled due to
> kernel lockdown preventing access to debugfs. The test attempts to run
> blktrace which requires access to /sys/kernel/debug/block/*/trace*
> files, but kernel lockdown (enabled automatically with Secure Boot)
> blocks this access, resulting in "Operation not permitted" errors.

Hello Disha, thanks for the patch. I tried to recreate the "Operation not
permitted" error on my test node, but I can not recreate it. I tried the
command lines below, and saw blktrace worked fine with lockdown=confidentiality
condition. This means that blktrace can access /sys/kernel/debug/block/*/trace*
even when the kernel is locked down.

---------------------------------------------------------------------
  root@testnode1:~# cat /sys/kernel/security/lockdown
  [none] integrity confidentiality
  root@testnode1:~# echo confidentiality > /sys/kernel/security/lockdown
  root@testnode1:~# cat /sys/kernel/security/lockdown
  none integrity [confidentiality]
  root@testnode1:~# cd /tmp
  root@testnode1:/tmp# blktrace -d /dev/sdc &
  [1] 1014
  root@testnode1:/tmp# dd if=/dev/zero of=/dev/sdc bs=4k count=1 oflag=direct
  1+0 records in
  1+0 records out
  4096 bytes (4.1 kB, 4.0 KiB) copied, 0.00274992 s, 1.5 MB/s
  root@testnode1:/tmp# kill 1014
  root@testnode1:/tmp# === sdc ===
    CPU  0:                    6 events,        1 KiB data
    CPU  1:                    0 events,        0 KiB data
    CPU  2:                  658 events,       31 KiB data
    CPU  3:                  797 events,       38 KiB data
    Total:                  1461 events (dropped 0),       69 KiB data
  
  [1]+  Done                       blktrace -d /dev/sdc
  root@testnode1:/tmp# blkparse -i sdc | head
    8,32   2        1     0.000000000  1048  Q  WS 0 + 8 [dd]
    8,32   2        0     0.000013242  1048 1,0  m   N bfq [bfq_limit_depth] wr_busy 0 sync 1 depth 256
    8,32   2        2     0.001495890  1048  G  WS 0 + 8 [dd]
    8,32   2        3     0.001497997  1048  P   N [dd]
    8,32   2        4     0.001499079  1048  U   N [dd] 1
    8,32   2        0     0.001574560  1048 1,0  m   N bfq0A new_ioprio 4 new_weight 40
    8,32   2        0     0.001577177  1048 1,0  m   N bfq1048S allocated
    8,32   2        0     0.001581069  1048 1,0  m   N bfq1048S get_request 00000000e21f70ba: bfqq 000000001cef6c8d, 2
    8,32   2        5     0.001583291  1048  I  WS 0 + 8 [dd]
    8,32   2        0     0.001584861  1048 1,0  m   N bfq1048S add_request 1
---------------------------------------------------------------------

I would like to understand why the blktrace error happens in your environment
and does not happen in my environment. It will affect how to judge the skip of
the test case blktrace/001.

Could you share your system set up conditions? FYI, I used Fedora 43, QEMU VM,
Intel server and v7.1-rc1 kernel for the trial above. I'm guessing any
difference between the two environments causes the blktrace behavior difference.

P.S. I found that kmemleak does not work when lockdown=confidentiality
  condition. This indicates that the kernel lockdown feature works for kmemleak
  as expected.

---------------------------------------------------------------------
root@testnode1:~# cat /sys/kernel/debug/kmemleak
root@testnode1:~# cat /sys/kernel/security/lockdown
[none] integrity confidentiality
root@testnode1:~# echo confidentiality > /sys/kernel/security/lockdown
root@testnode1:~# cat /sys/kernel/security/lockdown
none integrity [confidentiality]
root@testnode1:~# cat /sys/kernel/debug/kmemleak
cat: /sys/kernel/debug/kmemleak: Operation not permitted
---------------------------------------------------------------------

