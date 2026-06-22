Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4A2741A0
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128338; cv=fail; b=cQtbzVsMi5+w665Kh4pOZmAxIJhudbPSHGBq2sCsA8NRwk88o7wH8gnkHyRSFFNc9qsNsFWE3rp+hRkepkw7zEez22qLF9p12ZMsDaVuktCLWDKSbGvUIUoBj92wL+fMuhcreyfeb9LS02xTLZa7iKx6296cC1nnistXeQVO8XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128338; c=relaxed/simple;
	bh=pK/fKB2jFtbIplNf4mKawAp88WdzbyVYuqC+zSA9cmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fbwPHIirHMoNcrk/RcCl4o3i6tLJKWo6cK/5LZ4+gvWdMxS1ixXHfhoUUlRbVLWJcggT2tmCWBAUWSUWx702NXrR6ldcVKUEoES6mAmGFp6GjQTlOaT1EwCdSe/qc0x7kET0cTxIFrXN28+cwvKl6hpUQRGxtAB0i7D/F8UU9UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Gyh1sDoN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=EphskzZv; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gyh1sDoN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EphskzZv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782128338; x=1813664338;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pK/fKB2jFtbIplNf4mKawAp88WdzbyVYuqC+zSA9cmw=;
  b=Gyh1sDoNYTxCa0qbjRriz6cCp06udGK6xmUiZIVCfFO7HiKBX4KGhswN
   bZaEnXnYacs/5T2S7rxSwjSJIFJsNSyKC9Mlh5Dtqehjz7LtYMWmvsEKa
   b25piB53XvTMQ12wNZeDA/agwhlpXohjuVHGFZgaNvOe/JkO5l0biOVAy
   T9jU3iqrhifHcQV05ED5rWHmvJphVvTZVPxhgo93K1aq/0pM7EOkoX1Ah
   m9cO0yYYkmreuvyxNj32Z5ir1yxaIJJkiIHzSWfG8vBe/U8u/Ik9kBZbb
   MrL+/PSpPviNPBSFjTfy3Txp2p6V/ggdE5cDzdZ5iXppJcseu45i88iAZ
   Q==;
X-CSE-ConnectionGUID: ypYE/KtTRiqhOZfo58P3BA==
X-CSE-MsgGUID: eNu0O86sQD+3D686sp7UGA==
X-IronPort-AV: E=Sophos;i="6.24,218,1774281600"; 
   d="scan'208";a="145457862"
Received: from mail-southcentralusazon11011069.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.69])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jun 2026 19:38:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ia5dMK0twpN+tCFZqTkuH1hItpGoaEgzsb1ELxEqtn979VE8GqH+3FuOFgKuEMN9dkyPR4f1ggdqxGNFjysNLIaJKKdE+zLfuI/dwzKHOI9MPzY6KIHMDjZHo8qUsj/zOYoBR7g7U0ylxfwQQl7ZqrdxYvzq2pPLQWpBkiFu8LDllXUgCF8NaAcYzUodJopeIyemRIoCaJ68m4jHm562U/SKi24toHbX9Vazer9/VgmQPlaIUoLz7KM07+ciCjaRE3EB/rqaz31agCPyq/k/Esmpu9lt5hQR6PmRBY+2biuSsSUuorMjGPf0YAqeNNQ5R2+QB1Mondueo84hSWL7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozSJIDcuhbUi2LrWJVEQaPJJDMAsLpP9FjXt+2sSVdY=;
 b=XuLxMKprFnOf8ytbTlQwxMKZmRzRtxDJYDD3qCfT7/Zo8k5aMFKdrDcoFRswZlAvgz+FvmHqHF56RSfzG5w63QI90IpPwO373GA0ZjXeJ81HJDLH7obdAb0pk/0nh9zj46yKM3yJPIyHh9Scg+CrJkqN6UgQcdj29Kmddd5AH9v2wcLDKUUFQ7uqgpC6FloNZ7s9xTNoSVyA5pP3oVQcOavsQ+m4v2ZT0tXXafkXs+Za9UxNNjQG+lvGdkohv/2lAcbtL5r61iXICjfygJNd9ePDU2yZX3bnOSJ3M1Kvfi2PtiBuYJk6r0HDz7EXEF6DdQHKgBZijFQKDHwPE7KpHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozSJIDcuhbUi2LrWJVEQaPJJDMAsLpP9FjXt+2sSVdY=;
 b=EphskzZviRStujh3ogtlwxOHmqBB6AGkILte18k96TUB506SsR1xy4uBC/2Qdh48s0H+9T329p7UyONnwkC4KGp3yWagZQ6g6T+sIWBTHDHYj4x1XDgJU5oJAeaVidb4ZfT3F5DBFc/EIVFhF3ATHQzAQLO5CONE5EIArGREEoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CO1PR04MB8265.namprd04.prod.outlook.com
 (2603:10b6:303:150::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 11:38:53 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 11:38:53 +0000
Date: Mon, 22 Jun 2026 20:38:48 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org, 
	osandov@osandov.com, kch@nvidia.com
Subject: Re: [PATCH blktests] Fix _get_page_size()
Message-ID: <ajkeGQd-0LnKJbHN@shinmob>
References: <x497bnvlxlc.fsf@segfault.usersys.redhat.com>
 <ajXmBu9lDZwgMG7_@shinmob>
 <d0432702-ac0b-410e-9586-2cb9be079033@acm.org>
 <ajYabLMbEo6zyOWh@shinmob>
 <089e0281-4df8-4358-91ce-1f5cc0f0ec4b@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089e0281-4df8-4358-91ce-1f5cc0f0ec4b@acm.org>
X-ClientProxiedBy: TY6P286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CO1PR04MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb7b2cf-6af1-4048-d834-08ded052d670
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|23010399003|1800799024|18002099003|22082099003|11063799006|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	W/50YaMeCewi3lN0qZe/8i+9UI8X35srbXMKOhwWREfEwQpDbMzZ6TkZFgaMNIJvWvc6MOLxsp7nBz49CNksPfXFd0PxyJt6aLMwMFBjcPtXo58/4Z0sz7Bj+VfApsuidiYvsAyE1HcQ1dBMoNUx89X1au8sen2jw+2dwHGCKk+YQb8sUV7aBoBMGoRqGT7fKbdP6LEf9EaeSzUOYMyIfXlMe1E68ym93Tw29IRyZ/h6WPZegVJsV7hacXWFZY0s9YmQipL9+sRTwqBSv219kBbp+6RFq/1B9XsCd0NpxhvyW9+Fpc6tkBsYeyFjRM+D+PRJL1TGtFUckdPmNzQlsTqsD+lv91bGU2xS1gAJpaqEfujFtVXV43xTmoVGlZmWgF0VeslChbRl9co6U13ww0KCVKP8s9EWXx6ndRMefvlwxm52LvDQSh1VNGO2EqFI4yJ2mp3QWucDyFDO4/5S/+Z9b/E8lPaHhn7UfV/fj8Q3LnuAiLmr8sMJ8BbseWNNub/65QMT6+u7bpOZtM6RfNE1RjmAMIOrMLQ8z03TglQrw0R7RbXjnbRyu1JD1W7uAos0JUENsPS+7lelb4Fk8O7m3S0nWdqARARlJGXINwUptn1omF4TkTtufElLZ8leaRptIb2OBzazrdM1nWon5sZh3eEVto04h1901a/E3kE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O88myrGhyZVcwIV+yf/ba0GEfu69GENNmT6cwIKtYPxNy/fOu9D9Vfq1c3if?=
 =?us-ascii?Q?NFbcpJkIGZ+0CJJWLlbvJlSKmuWW7JRv08OqflIm3thCqmJHfDpfoktcda8t?=
 =?us-ascii?Q?Yxie2vTs4mx+s1F+HGPm2DYnhEBeMMPVq63PTtHrAhwsDvnDOqFCJMB0Kp1p?=
 =?us-ascii?Q?R0EHozYRwGJKt5KCloF00WzTwqb3XCZvRPaeBvrffwqEqMMpdcW78eoDCbHK?=
 =?us-ascii?Q?4+8TB3IwOGPv7WVFeJ+cn5NfxP2wSpCtM+Wwgc2CMjiQgbsEgc85GR2hYwqL?=
 =?us-ascii?Q?sCjOja2G4Tn3v1mwdmGs1KTmMyIvcSjlGUzLPyL6mHKS0Z+WFxkVyBCtwF2N?=
 =?us-ascii?Q?w3XAvqiR1DpsG2xTw67NjgLVTnjCsB5E0JMHa9rfz104ZCOJGC4n4qWgflQC?=
 =?us-ascii?Q?oTIdCVsA9jPHTyDokDiDZh7XRWQjuBBOQtGG/mR/cIiteelB0AqkjTXEcSXA?=
 =?us-ascii?Q?vBLM7z7R945SzEj4eRK+H18PHX6LPTriCyeAVtRbN/bZJ0jnlMtVwAW9lJ2T?=
 =?us-ascii?Q?rJfqgI7C1aRK3GFx1KoWoIPFKx47um7M3xYa4/WYO5kRiRAxsoe/85CPAIf9?=
 =?us-ascii?Q?RvP9IZp9POfb2yMaXMlS0Ho06599ICn8A7KrGRnPEMeCxa6Br1mbW7rdpDaH?=
 =?us-ascii?Q?GzBhXlEaF/zqOVIKuN0DM593pPhn5yGrK/dtGVUlNBSDO0HE9Ct+MhO/OOox?=
 =?us-ascii?Q?0T6F2zrIouOEn7nlVFDqLue4e/4CiJ3D8HkxiSHVN5DqHxh8cLGOpmq30/Wt?=
 =?us-ascii?Q?5y/wHMKj2r+Gpoc+MPcaVd06Sha3ZNgzS6hC7AJBVVhObVdTdLD92yRDe/WL?=
 =?us-ascii?Q?zBSz1hItQYOKy6Kdsrcu7YULdt2CZbmpYkN21Wipev12hxX6DdvSqmEmHzyj?=
 =?us-ascii?Q?GKte2TnFlbVMWgvfiIrCrq8HbpT/H608n0aJD1eqRCRcAMFr1zGA4pIkHHtx?=
 =?us-ascii?Q?+lyhgE2IKA4BRH6xvYZcMwsSSLveMHvYb7kpJbEil28uquLK0SqsMExcQNP5?=
 =?us-ascii?Q?bbaBIIXkfuIEgGx6jVxH+E8pZGNZ5w1+UBrCI7kspQ32ODQ03DGSfU24jfi8?=
 =?us-ascii?Q?XSUhXkYc+ns1Dlsk2B136mfWFwfAPxUI/gy5kmAlTQ5bw692T0bYhZRf/3Vf?=
 =?us-ascii?Q?GKmsxwNsi9DH7BzZ3px0prnY7aR4HKa9ayjXkcCoqTbaRUz+YDgjcw9mKjhF?=
 =?us-ascii?Q?D+OtuxBcb3ok47pPfPn1BTVo2HKo206Eqn2IBmYs8Sy8ksAZI0jLcIoFU5sn?=
 =?us-ascii?Q?BBOE/rAn9ZY8ENijKHNter3HMPoLmr+A5QZJCjmpSjN7zI2f5B4msSMzm+ai?=
 =?us-ascii?Q?TSpQ+oGYoTqVLqnsHnL/gE5jOWtQJAbvR8gLwwKf6MnIAEQ1WaSpHKI7IjH1?=
 =?us-ascii?Q?l7IsxCjg4U/RGvGGVgy3bUiR9hFJu+BI5IjJFlQV/gTxD+U181xVBqbQzN84?=
 =?us-ascii?Q?6GNATfBOscjMNAbpIFzz/nIDLEvre7SelQ/30HrQSZ8AwETUiqb32XbACeYq?=
 =?us-ascii?Q?zaafU0q2H3yRP7ghSfPpAOkNPYxQWRHIJgXGaF3qMKL1232KJHgyZXbkVqFb?=
 =?us-ascii?Q?d7V4L5RwFJj8Wm+Zh5moD45n2gaPIHd7oQ5qNXMaqLA5NCvLpccymCFP+5VE?=
 =?us-ascii?Q?QWC+zs6pU8uXrw0cfomiZAQKw2xFxUp861AwxO9eOrh4I4r8PThtEJ/qWGX+?=
 =?us-ascii?Q?n7sLqOHcIzcl/llRCgyJV/yuyepS+6RoTRwVO9gN/35kQn9gIn9VLNgbi18y?=
 =?us-ascii?Q?cpDywLiojIwXM/lpKQ2RXXOl6EYEilQ=3D?=
X-Exchange-RoutingPolicyChecked:
	P8cIzb0VwVXQ1PeWOdUxL1Qa9mpcAp7O8re3Lf9fz5YqlcIEZvWDVSRVGXBHmubK1wCqcAicdekgtr0PXgdZcquHEdompRGhNK/FPpr1JSXNkdFo+IhilnnHQ3Kzk55aoV54TW/IImPAuidSuRsKhLM/paTOlnR4+EL2yRynEp+2WUaeFNqaHWI2Jz4Vn23whd1SIIgyV99nYLVthtt3PSDQUWLVGMKjayS8qyz1xVmfCGdLmS5XhxmtIAaiS95NVCGx4VxaWIQyLIrCRLYfrFOeJh83T9fMPmIXsUb06ikFPf3197LuhEXfu7Gk6If+sR6uxuuXT+nn4iIRM5WHvw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rkXtDCdzy1wfX5eUqOKuLjmacIZSSxPNosNBLtsPCp3/RidWsDSCkayCtgkkyNdqNx8pQh7mvAZtE8OtNnDukZKomCKjJlH5BFucodKtS/FMqyHNKDaUvlHgacdG4oJ9uMbbq1kZ7yBbMeU5smQUGDFmB6sqDTWiB+XOMjbXxOhqBSEZNzqbk5s2mHPEIqpMwrPoJfXy4DOEZBc8X5P3ayHfonkYHDnsd4N0HwRX/SvzlcYn5c6HL/wOygXzKkqVOCW/b4EhnUQlVT4EEm/TijaRwA8OqIdsmW8ZdAnXjsA37DUOwhw8y2tMfyBlfon8w8wghV0K9s2SkZMnbDQ4xVxtAy4uzOGug3CIRAzzBtr2/j+/SO4TBbrAc4Z+CzUprYGD1z0SsS15t6x62CSMY8cAkyxLCyN2N9PLVXYubJ4GaL/SSod7rTtPYYv/nmcfhFZwxIVAVDQiK2sgWEYfWl882r6rmeNLjFKdOS9OALFXewSjEARqLK5/aoqg6pwEEDpsfm65JcKNy2A/7pJk9pC3CPss9qvJqtmLIzoUj3Da+MswFBxG4Rcs1zly6bbC+BzvmROOzbbhnYhSZ8OXX4xTsvmqwaR4FJPV+wYNI8gcWyJ4/yQis1NxKU8Fy9dy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb7b2cf-6af1-4048-d834-08ded052d670
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:38:53.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBURXGblJzyusvBmsJii65061R3Sksmoy253OnNhJ+/TV/lo1Xjirah5ZF9Yulf4Yp+xFBFd8FF9AGm8RPopH41fGSP/JMZIm4o/YRVKcQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8265

On Jun 20, 2026 / 09:11, Bart Van Assche wrote:
> On 6/20/26 6:51 AM, Shin'ichiro Kawasaki wrote:
> > On Jun 20, 2026 / 05:55, Bart Van Assche wrote:
> > > On 6/20/26 3:26 AM, Shin'ichiro Kawasaki wrote:
> > > > This is a rather fundamental change, so I would like to ask opinions from
> > > > other blktests users, especially Omar and Chaitanya. What do you think about
> > > > the idea to add getconf to the requirement list?
> > > 
> > > CONFIG_PAGE_SHIFT was introduced in the Linux kernel in February 2024
> > > (commit ba89f9c8ccba ("arch: consolidate existing CONFIG_PAGE_SIZE_*KB
> > > definitions")). Older kernels had CONFIG_PAGE_SIZE_4KB,
> > > CONFIG_PAGE_SIZE_16KB, etc. This means that it is possible to derive the
> > > kernel page size from the kernel configuration file for all upstream and
> > > distro kernels, isn't it?
> > 
> > I checked the commit is in the tag v6.9. My Debian bookworm system has kernel
> > v6.1, then the config file at /boot does not have CONFIG_PAGE_SHIFT as expected.
> > But it does not have CONFIG_PAGE_SIZE_* either... I'm still afraid that kernel
> > config file approach is not reliable.
> 
> Right, for older kernels CONFIG_PAGE_SIZE_*KB is only available for some
> but not for all supported architectures.
> 
> It is not clear to me where the desire to avoid the dependency on
> getconf comes from? As far as I know it is available on all Linux
> distro's. Since it is typically included in the C library package it
> should not introduce a new dependency.

I think less dependent is the better in general, and wanted to confirm that
it is fine for everybody. If there is no voice to object, I will create a
patch to add getconf to the requirement list.
