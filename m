Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795833097;
	b=QvrnDd5/2B9aBThR4qUEh0Sd8EW2mozfHMOCroOn9RDrol2XV+ZlbIUtdxB8IsogmZaG
	 wDutnx4wBkT/GcsPUwV4R8dhHvL7sGe+henCDkwFdlidORKcMrXCiekkrdOFhGrLdyBxq
	 qzqHolaV8tmqXTb3Yvwm9YStpr31CT7X1zeMjintfIn/23ojDwIKBpoV8YtjiAkUrinx+
	 atlDrsio3ClC86LmgaMchbBuA5PwiCchPrTcYeTndxIZu7U3RCKDzpTQE5FxJz2DT7LKW
	 cQwrNNrfofRCCDhI/WSXB9GS45U/Wz9cqZxVW7gH6mAnCCRVBZl5xM8JDruRe65NTrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795833097;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=oxLTgMGteigF2xRG8Kh5PDRz3Dd2T+1fj7ld2xqyZMI=;
	b=kFO+0J0aVWE34bl5+AJ2ymOc2s8Ppvb1VxtU7HSlyVzUPmViPn8dzvKIkFMbROxJCG7K
	 yziX6jKFTF3rSv/CK7kswrBbo+GVMDql0lKp9mjZ1+gSNcnYULP4zh61zJ5CTg9HmlUco
	 fGLqQd73+iuGKk/gRqzdIhihbaGQpfrKDzmeEHAeouJu73/F5pTyT1TBGhO/naHgvwF5/
	 WzevUpnH3qF8dVWVreG94Sb27Iax8t3JKRQ6jCE1HNGN9wrGnfeRtvUekNosRNfatOwrC
	 AECDAI47jVbYaW3bNC9EFz29hfukjgLmPxetnVMj2QCxESXf2GlEQ0IYhBt0+2Ctkmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=LrGw4V6x;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=YLwPN1pN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AE9606A32C
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 02:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74AE9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=LrGw4V6x;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=YLwPN1pN
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795833097; x=1827369097;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JBcLNQ6+6NNQ1wOunptbELJ5Uyw2kfhRKsOvONbuq6g=;
  b=LrGw4V6xTLz8R45qKWVw7cmrh4spCiXESmXD1Y5Ee0klcQgQQS2hVPt0
   7kRGjX8R3LzZOXcT95eMcm6xQ4Z1k4PO2gBKn9uFtiFn7NnUxLibjdBC/
   GyWdMmShMmPXAJsgOXA9so+x35QHSkwxcVixScJG8qXxKP65oRXUGEktE
   iu/bNbHDBJGhU+OdJxEUoRnmm5rdBfM28cGkew0M1GAyqQCxkm/0MKc9Y
   Sr/Exg3B5qoPPDUMF7kkOFbKolIr684XxsC1edTMuf8gNiHZjXXWjbLpT
   U9PFcm2tWiNLXLKd31E+0a0I7AYjvttaEx0tLTVlvmjrYpysTBT/pzzl3
   A==;
X-CSE-ConnectionGUID: PFrCnS4iSXONahAOL5JKBw==
X-CSE-MsgGUID: LRf+4LUnSwix861+vSDOqw==
X-IronPort-AV: E=Sophos;i="6.27,238,1786982400"; 
   d="scan'208";a="160972370"
Received: from mail-westusazon11012002.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.2])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2026 10:31:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCOCpGcsEqkDpiGEI1XCLvHAoAVo35cpHzIy6HfSTdgiiP/06Wvxu0b8Z6u9uKk5qJqhs4cVMIKcPe+jn14VkyzHyI4Ul91cDWacG1H3Zpk3WWjNLz3WAVl8f8e78ZcpGTUlbUvVUd+W9ezFWxGh0SBYhAMAJjjrtT6i+7R414qKAJEB2Ihh5EzWEMzXQiUcWFwOFg2oXuO6w88thugS6EPwpu0JZUZV3kE6QMwPXwTakWBWZ64Z8sW7Bqc/ury4WbVL7HzEafliNRHHkiZGcidkg/R70zjlH/7T9vS3JQtEwgPCvbeVeOygcGWMCp5HHIzOUbZsmb+fQe1MFb/l6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxLTgMGteigF2xRG8Kh5PDRz3Dd2T+1fj7ld2xqyZMI=;
 b=YSp24ZN8NxjrYX6eE9YIWi2u2kH9S1ScQFnL9m8aYY/BAjCv/ztflhgbSLB1NI0T853aiLVYCHr/ao8aOPw+9tXOsysDkO+SaP2wJ8jXd1ZcTiFjtIMo1nxTGvVoZIw8GipFTtVfQ/BEHKgm8ZeOoNA8jh7ZmGpcHpwCvsZnG6iUvCcL+K5HVbMpyXHSrx3q1BoKNUfyK6rO/Afdccemz0wSrMDNtXZFQcUCZTewcSDJDGxDGuKXC8LkQgWR/5XsPQMzbDyg//hoYdbH4LwpUg/SWUSAyu8gqlnEVgKfKKKUIAUHOLChHN/SX1aXpmr3MXm8RGvssbdE8YY4lVy4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxLTgMGteigF2xRG8Kh5PDRz3Dd2T+1fj7ld2xqyZMI=;
 b=YLwPN1pNPp6Kj3/NQvrEMXdtAxr3wS7THBpA5Qskr3xyNDTT7ZLuBRfYPsRvCeSgD7Bb6PegG2lCIHNy5NOSLTi6LPxYYw6YcAy4d01uX2zHSnD5fh1AbmU3MPKqRrHLAbVIB0Mysa3t+zzecLFp+8AGV02gjJDQ76Dc9t7oc30=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA1PR04MB8563.namprd04.prod.outlook.com
 (2603:10b6:806:338::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 02:31:35 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 02:31:35 +0000
Date: Sat, 28 Nov 2026 11:31:30 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v2 3/9] nvme/042, nvme/043: iterate over the
 DH-HMAC-CHAP hashes by name
Message-ID: <awo808-hS7_i6PNm@shinmob>
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
 <20261118-nvme-target-control-v2-3-d191bbbf5dd6@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-nvme-target-control-v2-3-d191bbbf5dd6@suse.de>
X-ClientProxiedBy: TY6P286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::19) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA1PR04MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 855ef281-3470-45e9-f757-08df4cf7b8ec
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|23010399003|11063799006|4143699003|22082099003|18002099003|10067099003|56012099006|261026140227099003|261028144727099003|261102123227099003|261022105027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	eiB8wuQdmSGev4KgtZAz4TFHN7nkBvlECYMblVehyyaX8A02i0wUYShhNJdrK2gp8vwUw34eXvvtV9rUht7HatIMDwqGrBsj/+PtsDOBqXKqj/0CPwiDvrx93p4Tl4TrGDWT2B9D+XCf8E+99HQPS2uQ+D6gQWEcLogmsiY5UlLqGGZr1KiJNZ2Y4DS6NVrNoThxqLAogvjusKOzUK10n8i+WYSVpX/O5FiaNkIM5YGzcO/JMXAmQDnuSZdhlNG78n/Xjjd2UjTD0gf+nBbfmTnNCfBDu+a5mou3AN7Rd2f5sdmLWk9TpBtmt95iShIRloU8X3SjfMatbXuXV1fJ6ie7QzG7CxqmcAtm5hvTeRT4Cn89gYKdIClllWK/333zVx6bzrmm1EGyuymwk3a/LNHXugZt7CT8W/rwC7Y/Z6VZcfGsju/f3P2WMNtehddhWXBialkLcOi9mfK41YOMItBak2mA40emlAVUmJJcBgw2kyOmYOYhy2zLIGIl06WUDjZwjEZy1Muek+/rw8sBtKO59pcNAqEgvld9rZajEvJTx/pejaocDZlXhPDgIJfKo8WO+u/z7aujKGjqaFxSwf/A69EQ2PUu82ek2UoN4mXzlSnKj6t0G26010F60JJiRO7vGbPGtopqV4CFZzrgSnIrIwl3hAVikFq+Mbn/xKQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(23010399003)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LeYwOiY9wQ/EZ/mXgeLOXHtIAivX/4JodS9yF4owKiECXGLeRHr4Naz0M3AC?=
 =?us-ascii?Q?C/oEqgbJTAGPq4lt/uNTjxpP7hwCfLRVrJCNC7N4h0UIjs0nn6f0JLgjnl9M?=
 =?us-ascii?Q?t7Vx3mD4/aENoyTudq+NzbIpNBM7Zbo8RHjDC/iClB+xYfN2+nwOCtlq1teW?=
 =?us-ascii?Q?0ED5mTS3M2dEgQRoWwtk8zPvccrIe6UCPOqPyNvs7cMNYkANmYCEEYd9k41f?=
 =?us-ascii?Q?uTkncXoLU8EFi+emF2Ej/3kZyTWuST8sopKNeHNl7j0B21g2pSMKnvrClWMj?=
 =?us-ascii?Q?5buCXF21jIOMddCj07TrWZeDbUnqMBwKyjG5IFTN8KxRkKaM4tm5Rm7l0t5N?=
 =?us-ascii?Q?LrGzrL0tKwqbifU0uxiPs6uXzkcNmrQ5veCVgwy5IhEbBk300Ohpl/AgeHp2?=
 =?us-ascii?Q?42HDc/cnvNZ95/L82prR3e0O6DvKSr9lYRwUCeTtApeq5u03D8t8yLq2EOYM?=
 =?us-ascii?Q?7jYEjHckC0g6oxe6Pg7kdWwKGmb07VuFGiNm0i48J3j/dihwGYzKogxsqdph?=
 =?us-ascii?Q?rD0Vp++syNuwFhVDh0fnrDA4msxaoy7p4p5ApcvNEKnDcHC9aMfPn9NSIbTm?=
 =?us-ascii?Q?0qQgYimaObRTb4EQaFULjLTFnHWZnBNhO4vXTuBErjTBQmY0CUYj7XIZ2bIs?=
 =?us-ascii?Q?otpCiAqbKY7OAEQj2CpZJWCHUnXLWZ8TtaVk3DXWV9AKSLZsXeenIp/wUDqx?=
 =?us-ascii?Q?aCpJqaAv2NLXtF7f3LAgzKZw1kIwFhu30mgkdqu+Y7SEPCCuHlebThJ8qyFa?=
 =?us-ascii?Q?NlTaO/OCPk2yTy5nkh67zGkap+946Rvl9uFQ+MlioKEQx7vzXFgy44+Imh81?=
 =?us-ascii?Q?vsycfVtOJn0CBQzAKf+AZNKtf3DjSQNkERkp2xPVaxmjrK+PCHbI3LwNsa7F?=
 =?us-ascii?Q?RKlYqEP53vSlW0wykrmtJyHSJmexiBb9N1pyzBhcRYOn8OJrHl0ToltrbtOB?=
 =?us-ascii?Q?ddhOTeGenQjgpZ/NJdAA+KyjDK8CTgfWil6nUeIwhOaDxrGWkscAN5gt+5JZ?=
 =?us-ascii?Q?UEDdgR+ulUCauFWDEtKRnqdxnbW/bKUFXrJDHHUwdsGAC35LMzgIA8/ZTMtB?=
 =?us-ascii?Q?+zcBvjdZuuS2AtwYFLT4zkIj7OJiTUEm0ZuJk86pe7iPIkTCDObiQX0w9Mxc?=
 =?us-ascii?Q?QgZ9dy9u5pC+63Dc+hpqhLHwtUQRBNhQN3oxlPyJNQ2XbfLqylPGnIkxrZzE?=
 =?us-ascii?Q?B08ySTiZdu/1QGt9EW04YcRSeCEO2dyThH9kI5KObvBD2xtG9k/6VcE2fPAu?=
 =?us-ascii?Q?ar9dJ8oN5csVJIspiCaHPmuftzTC2gMSwWIE1i6NLBgbXuGo6HoarjgGplqj?=
 =?us-ascii?Q?XKgd291M+jQo2AQvEZeUp1sv5k+Dn2UrhD82aL/I8eYcRhsh7vPLQp2fA4F+?=
 =?us-ascii?Q?71Uk8DRYdnlFEcFhrudcRcovRfVQM3g1qttTPOnPdPsT0PaXZwXkWF7BP/yK?=
 =?us-ascii?Q?p2S8BMPezAA9n9w0i/bg3Oi5M8+pc3Okm8cW/OsTgMI6mI8HaTzzUUBp48PD?=
 =?us-ascii?Q?fp4OY1a5JLB18d1+20NVMcn1VYaS/vgNiuZ+HUJlzILpm8A+zM57VU4IP0+k?=
 =?us-ascii?Q?a4/HlGKndUoU27HtaXtTHd4HV6y+4T8R4lIgd6rO4yzDWXyNa2W6WnEBEiSm?=
 =?us-ascii?Q?RzmCDWEtOgRp/hwP0gBR/+TRb/JyfrGOTs0PF3LrZw548zAZB9g3FLb/ZP8q?=
 =?us-ascii?Q?cF+nr4hCPeQvzLUw0v+ypaWpxium4Ctw0GgmkEiRfM/HwHDwR70TTG7/YWp4?=
 =?us-ascii?Q?aCho2NXf6p7TscwMY5sVrdwMqwAM21M=3D?=
X-Exchange-RoutingPolicyChecked:
	PS6681ophJwj6uyvFZ0yvJU0qJG2IjkbSPGzatnh3wglyvP8D/FLTNCVSF9dXxm9TO0k8j7pd7Jb5iHZn0y1LkJig4L4gqdIgfXE2tjjOUMM++X+/ZW4ilUo22XBI2nOt9BnNi0ptLsPds24adga7W3/vG0PrV2cIq3TPeYcK5edMlVYodVeVi3ENJi2PI+hNEGaCfNGuGG+ZLW8kNBoRB1lK46wZG6mv/mGZSXgCC8T3IexAU26UkSnV2mGguVKPdZGI53RUXo1DSLnZrkHAS74vddM/wKtjcRSQtLMNI2K3CYc2YRy9GqFvAgZRBubnVwmrsCRJC7yBWYl1P5WhA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N3UqjVQo4nq6tL4wkMxsP5g6L8af7N6eQQhuKU+U6/EAcKyElgYnZaeFAoodw5Xe+Dp8e+1IuiAcxID9BoZ+1OBOoWAxpzpQzXEFLzpHylsssJiAss97JufQ7qZuu6tDLsakDvhLAWlVKpA/a6usQo5zjPDV4jQueMBYjDTMntpkoKgJZPr12Rv7z83ww6uwPCn8/RX1wZLbdtHyJ5pmKgMPow7aZgfloiu/GmrxLFWqPPy3frspb2/cHSMKuRBzqLtfxmMb+I0aCDIMBie0UyHjWeWYInVMUO9Wbu2mNOQ16bFfG8cPuPs8m0z/XKuOVwge8lGn05WuJwT9UyW4E99WqNMjA/awiM44jBKpS19SCvjcJi1Li7l6YQXqcmpOHJEY0NFOFGvlws6Y+el/VEllKpothOdu75Iw+pI9YKTtwjWNjUmSEw468uyNYCN0/Z2Bdr7ghMLH5DxNqezXstqkObG7tq9Hs3s1TE7VEUAUKfZZVuoabosZn2Z5LP+FmYZIXg0g64O4ajH9wJOwRLqbK8FJzmrrNbWsnIkFXuiQ+RtekkqYw8BYVR7EvHCSVbJBZJg4hjO8EesTCouAFRMYfkiksfO1ME8BAdRli+Yu/DW98GD9SYX0y5Jc1WSd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855ef281-3470-45e9-f757-08df4cf7b8ec
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 02:31:35.4045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYAelHpy8TjFKknws1bFJZR2MsTQNWBWY8pt+DECFNL57GhWmXRf/fyjmVkuSorHKoBXIZLvZ7buZTeGGN4/Dz8ZkLgCkw8D7EZNEWZATu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8563

On Nov 18, 2026 / 10:26, Daniel Wagner wrote:
> nvme/042 iterates over the numeric hash IDs nvme-cli takes, nvme/043
> over the hash names of the nvmet configfs. Add a --hash option to
> _nvme_gen_kxchap_secret which takes the hash name, and use the plain
> names in both tests, and in nvme/063.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  common/nvme        | 18 ++++++++++++++++++
>  tests/nvme/042     | 10 +++++-----
>  tests/nvme/042.out |  8 ++++----
>  tests/nvme/043     |  6 +++---
>  tests/nvme/043.out |  6 +++---
>  tests/nvme/063     |  4 ++--
>  6 files changed, 35 insertions(+), 17 deletions(-)

This patch touches nvme/063 also. When I apply this patch, I will
modify the commit title to include nvme/063.
