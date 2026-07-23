Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CD74A13BD
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811752; cv=fail; b=t0gCr5oPXALCr/Jrndz/N1ifYxk5IMLJLlqE+yZq7O3DFD17IsfAPi7OT61fu/6Ar9Lv60DyFsidvi+8gNWGuiZ0Vr2XsJU/YmZa9ERctO+rPfJB+LBc/g+C3fYrJymZjOHlRtQfU9RVGMZFvlT6lzlkyLiBgpfirLAwVqi/dXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811752; c=relaxed/simple;
	bh=kc4Bv/1G997et8kyFjgE0uTV+2rUTm6AlKi/D7MDdrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c69h+3t7gmMPAEG2k5blQvnlUg34deW0iWt9j+5PLbOo9XXrxnd8C0BdEco/KDdtD16vWCtYQYd4YXoSczd3Ns8GkqIshHTkYZ4MjVoCBD2pbTlq6VI9ivXkQsBShRh3uvyBlc2xWb0b9ugUuLAPgp+HvQew1yOWGK3eI5gxrKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eiRYbqTb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Jw4Nq+W5; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eiRYbqTb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Jw4Nq+W5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784811749; x=1816347749;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kc4Bv/1G997et8kyFjgE0uTV+2rUTm6AlKi/D7MDdrI=;
  b=eiRYbqTbzhB/MK5f2IhuHOX+ag4fEyY9eStx1kAz2gJ2QoSCxwVzJjdy
   cIrGCUIbpQD4D2WQKFQv8r3x1IwHPXhhEELaWzQnb9TmxN18SdsdKFVa+
   1AF88KbixEgVgjfzVP1N9MKgdztG75QWp7uK0uyzIXrxj/SHhHvLzKFzp
   dDfqyd842OdYWCru33RIaeDJMwrX6jXnIa9RbDv6Kmq96wkA7XBLDKNL7
   GSwZ+dTlyMe0ZDiOCmIaowR5DMDfA1k5qElu/ARFJmOn7XQ2OhQlzkX/x
   dQuHeyZPCT3FvmRjggWOwKcJQHHBe3CDMg6bHuWh0ZqhZbV4c35f94mQU
   A==;
X-CSE-ConnectionGUID: GV1Bj3TUSq2Mu1yBbCeOQQ==
X-CSE-MsgGUID: 0wr513SXRQ27UdJmxxdC1w==
X-IronPort-AV: E=Sophos;i="6.25,180,1779120000"; 
   d="scan'208";a="150682840"
Received: from mail-eastus2azon11010005.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.5])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2026 21:02:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uANmDq8MGKgrFQuA41Pd1SOwhRFG+LtmrAb9GD2rsv/Zgq+TxN273YicG7UflIQeDqDKtMrhAE0HdGb3UTHGYSwuK46j0vTajX/mhkr5KyibdcQ+0Im6WhcQBQ5BR5pqH84BajF1vr9a3uTvxkZ869m2WEBw26JkmyboWK83/IZmZRUHXrdDlssqkN8epdJW4Ta6eZ0UuUrRniNaTi5VtGEgkgKgOejmoEPabHi63mNyhJ3Iw3euhraQW/WTkOIZ/Hx7NtRL3eXSKNYfBUBc29IVQZqFvVgvDKPn3cw0oOJvsoh8QPSAYL66GX4DRxvqoYm68Oj+Rej4Au4dOxrtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LkQyjoZ1QKcBmru1BKJzW/nXhv5tAK24BX3gGvVXaw=;
 b=nOanuOOLopa/b8lxlc/qGzebhe54dTnQWtct9uIsfC3UsJNsGlHABlYN+6bJJaic2EdnelHOYlf2Uq7TAhL25ZNg7QDJyvugRdvw12uWg1dCt5RRNX8H2ZTFLZuAf8qlTmz/WY+Sx6EUYeWvWlWR/uz7Fpr0XCGPEKnMcuFl2+T2yLucVVScr4fAb8s1dkchabtxywHGLYeBV8TQ7Ebp5PvVjyeExCpFZHCHJuOTFz4grVSygnip4icE2dALWch1LXe+DtDy7b4oeFnsT4B8ZJ8gysmXgj36ql+W7k8XeqlZ3Ni2N62X9Xuk8mjO1Evu7wZ3sxDaQgdabmfDbODCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LkQyjoZ1QKcBmru1BKJzW/nXhv5tAK24BX3gGvVXaw=;
 b=Jw4Nq+W52AnOQgH4KY8cfEAYfquwP0Jcs3l/5tZ5ac70Gpgro8abB1vPaFZhmsCW/9rvl0KUoS8laQnbB+wxSRGzcqjnDvmbJQtMvwjlrZaoFu03xNbMvfwsIFAwxdKAZB0JE2OrtmYy1dGdShZ4uvWb/SK4+OPJYaMvAiIqYKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS6PR04MB9939.namprd04.prod.outlook.com
 (2603:10b6:8:368::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 13:02:24 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:02:24 +0000
Date: Thu, 23 Jul 2026 22:02:18 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-block@vger.kernel.org, 
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH v2 blktests 1/2] common/rc: add _have_debugfs()
Message-ID: <amIQbrH6iRme2z0l@shinhome>
References: <20260716100832.30570-1-sebastian.chlad@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716100832.30570-1-sebastian.chlad@suse.com>
X-ClientProxiedBy: TYWPR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::7) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS6PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d6185b-5820-47f5-2b79-08dee8baa398
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4EH7ZlQYwdAOhBQ2MgNLHO/Ilzl42aVG1qkFJJe2JI9Wahl/242ZcSzrJRLOVnB5dknx4bijx1qL9hNygi7B2Qt2tXP8Kbg7APD2qEAyyrhw9YcRFrduFRrmiEJNnmWgT+RyCnQn0YIdaBhlbWcjK9V11hQ+Fx+Xnzh709kAS3QNBLMTlU3tdEYWSnzm7UXSs9ho8CBJsb41aPL38HTftfZIiCMgebSyTalc7ZsHmqnox8yI+Vfa0ssmNxWa8aQ2FttP3IhHaORTaMn88yv7hRlWMu7sQNsCDKUHGz9D3dSBV5OuWEfTHLfVFzX+OdlLwa5f6sWSKHkXfPV4L0qyI5KdAA8oBtRrTYaD4kKjp067L3mjj3PRoeiF8h/dRHt7GCRypW+gPFzkVyvl9dqZNULHKmairamb41eIw20I8FaPyvGEuHOUp10lXfiWgjAbBohYPFdPpRBLd0vnnClBgUFxzRc2ONKsDJ35M6bNy8xkQrVvp1PTE91lsV3XmUlr/E7OCf42f/eGluF75ceUxhKS46O7TP70tM35u+WldqxmNJ5kBChUVpzi9VnFeFldX9mWMFtFv8qnG/fwvpF0NGSkKUCS5vZba24XYCsRMDGAPn8RPsi8mzmxMtX+ob0ebA96J26+RqPFU2WtupW3dH7Wz2JL3q87qXIQKUS3HF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VY47qbHDHeRtYgrQBJzqLgdy2R9rgm6NWRkQT/s+lYoSNxOE2BD4W14deQrv?=
 =?us-ascii?Q?sUADSRqcc1atufUuFeiDTp1xy90YmbaMFs7KU1UlOrITVv6c7X+s8s+y77Ui?=
 =?us-ascii?Q?HwqS6ddYtrSH5M5Y4O8S3LrVR2fmBDVPKov+VViciDfZpwTEZZaRrhwoxUfA?=
 =?us-ascii?Q?z569vdah/ViPJ7eRYp6tEGqBJI0RW5/JbVL0V+7Tm2H4x8NqHqkw36/N1tV0?=
 =?us-ascii?Q?UJYwxwHVEFI6Yb5tfcrFF38G0DD3j26toaoxqxn9j/oBM1Wleg1Bm5zix7Pj?=
 =?us-ascii?Q?lJHhn4l2Dio+erOYl+5JSV2AaQp7AhODHEXRZVkgYu9BLHthoj9oBMNCL1l0?=
 =?us-ascii?Q?ln1lMLAEP/4aCAV4fM7KTfQBUolb2/b6y/FgR4cgZMnNMZ8ndesUcyOcJ42b?=
 =?us-ascii?Q?U5Abam4lVAO7fYeqpiF+J/TK4al3ygN45r8oo++WAAsSLX3yudNCH9z93Ibq?=
 =?us-ascii?Q?qHNXko41A9uI/j16sDigpf7oNrNN3gtHmVIg1u9HRCM7/Vy15XHHdC9p5kV3?=
 =?us-ascii?Q?bMjc7TjiWcamBT/d2QdIh6Gdpj26ZLt4BGVDTDttN69vRJgfGSlDaculWwjX?=
 =?us-ascii?Q?7G+ii4N/hu/nQe3K3bb9WYxPG9Fdqovz/p0tx81l9w+4j2JUShEgXVE9DVeo?=
 =?us-ascii?Q?85rjRcd/eIDKpjnvnfbvTX2kW8wtxCcnb6vmX3HPDaoesXbyPurZuqEzjhsI?=
 =?us-ascii?Q?yLs7jKSJPovyldRsgw/urHExluZxwLLkse34qa6pKGs6XS/FEmgCAffoKeuS?=
 =?us-ascii?Q?d6ROhk9RmcgMxCrscRPpVSaTKEuXt4S63rdUwq/dPwHK54WsADeMT5E/u6CM?=
 =?us-ascii?Q?g0m5GoZGf9bU07jkjl+0Ymq4v7eW5iR4ac21jWfe/4YpmcpbqSlWGlsBZJuU?=
 =?us-ascii?Q?wzX1G7QoT+WUwY6w0rxQq7tQQ/sPu+p7g4g0BaLKK2FbSFGMZ0sRoka8T7uv?=
 =?us-ascii?Q?FHyi2MVSmyjWlfLQgLAy803QyAHL8gjfG5khycBQcWVln/tMWuWBQW/fXH/w?=
 =?us-ascii?Q?hY7g0iMedzwCf82Z+YpMxBpIKtFq1Ih3EpVaszRT95h+uBAMIF+bt8TmvPY2?=
 =?us-ascii?Q?VXehIsezKiV+aQF0U2QT33EZgWHUiMfP1ASfqFkXeNuvSwSuTpi6X5TgX/u1?=
 =?us-ascii?Q?1HjYvf9CSPYxaAC39kyoGeRw1r97cpBtgdyZrj4kULwpnlW2N0oUP/b/FImX?=
 =?us-ascii?Q?dPEPMGLYo7GYuVRAmwH3oKtJUuQIYAo7RoF7g1ws7QOsPRJGU6rBmm72DCP3?=
 =?us-ascii?Q?6Z5tyhKHVB4yPzAlKu38AjhveMlq0ldb6kpQHcJrDsG4Rc0oSnPC3EXyKkCR?=
 =?us-ascii?Q?M6wqckuhfDvryB7KlEoq8WoilniqJ9QMxC+O7hiAf48s0ZvO17evKUkE+TWT?=
 =?us-ascii?Q?F5pu3+lSTmy5c48o0VY4ToxeJaON2qObhTHC3eQRs+0AMisxB8sc3F/7955x?=
 =?us-ascii?Q?7DBNfA8JJA/6snzw5ULvapiaYlumxEZIVPj19ceV14snemXJZIuKPT4rTdB7?=
 =?us-ascii?Q?6fDN3vzOhljYhDDFDfdPO171BPT3D7tbHtepibp/xJDwjERvKHbBv19rDu6S?=
 =?us-ascii?Q?40T3/Hm94nBwHvAaNaNgbD9kpknC3n306MLPChVKaAnXgIU5uIjwz6BNMvkB?=
 =?us-ascii?Q?NJRS+JqJnyR6zwWW1cvNQzkIvVEDVc1kSN3G+4BovjATxXuyCWlT76nilDB+?=
 =?us-ascii?Q?JW2vT8bxLjLgX4+ZKmV8pCZgBahI19xX8Eb095ZJG9LvtDJui+TVR87+J1AW?=
 =?us-ascii?Q?Zf+1qHzwXGr3KVleFAi+Mz60F9zpsYY=3D?=
X-Exchange-RoutingPolicyChecked:
	TodtvDw5G3YAgWdsi4Ssgs9kS0paAz//GU0BzO93oS2PmTBVQO//2bFVtD6aP2+xx6WK23u6BBQkPItc9sAxGI7pjVIuDXHZZvZsQ7wno7CVmgEOXweZPq/k4WtEjRwW49+sUSAZSqbbidYbLUseB7KAlPsLEQe3hbn2tsaHec+yv1tC8xD/uAwaj9a6h+seUmXPcp8Nyi/tKaagbDhMOJO1AYA0DDhUrInxEoOkKk+wXpcNEWqCPwF9z//LD9EaPfUSUKeod4BYLLx5x3Hnz1i6c1h07xcDX/Er7EtMTsn8Rkkbeq2SAHpn+lKgvqRiY5xlwrEpqqoVhCgH+zwz2w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QZIPI1RBpTl4Fow0onBkvOkDLuoO/GY01wYJRq4RnPX3WzQYakDPp9IdV5XN08oM5SZXsKBg9m7KNS2jftcP4RbJ5B0AHfS6xEUQ8w9M6hsKU4qCTUStBrd3ZLD21KIQDg/xrzzSTrG/wFWdNRonMPq4EkpOWIavP5wwRoBfdemUEFaiuamj1msArUQkOc5DwS2uf68hLU0FnedhJsigqidcyPv5ZpszleuVf90GbhSD7DxWdB9Q8EKAAWPYeuiI2lrqthJR9ZbHa5U6+Js5ohLkggQ7hgCn41Wv8TWEgKDHIvSPd2HQjhBoUBr3Vn5xZKbT5SclNItGcra2K/7/uPPraPaXfEVQU2SaEDsnnK3dMWL8j60T7CmD1O0os8PTonNTANPtrmzOBtUazjF4lhwvfERJiS+YYvnELnSi1H8ysEIldRKNDEm3btrBbXFRNTIfY7FBE0vzwto8Iw3VAr+XIbomRRhPjMqMBh+nrWd7DXM45LFZi1vfCrIddMWjLY5k0wi8XtDq8ao1RCLRdAt2CYtwUfJzA3XjNNkaqiEdxP498NIJp5ssxpbhrhmCMJmxsndZt+y6fk5fuL8nd73dQJCnxvrIh1scQHRY+KA3EZG7/+E0K6YmxI1Sh9Lo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d6185b-5820-47f5-2b79-08dee8baa398
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:02:24.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eq1m5KVMshMldLwDkxcNY+EAcAjoaOBkSZYE5VXKrTis/VSiOZbQw9ZQ1qtrU4FqAxnk/v4xJAlEj5PIRMB0wQjLI3IzPKVEbRU0JUNEMVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR04MB9939

On Jul 16, 2026 / 12:08, Sebastian Chlad wrote:
> Kernel options like FAULT_INJECTION_DEBUG_FS being enabled does not
> guarantee debugfs is actually mounted at /sys/kernel/debug: on
> systemd systems, sys-kernel-debug.mount may not be started by
> default (e.g. SLE).
> 
> Add _have_debugfs(), mirroring the existing _have_configfs() and
> _have_tracefs() checks, so tests that depend on debugfs-backed
> interfaces can skip cleanly with a clear reason instead of failing.
> 
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>

Thanks for the fix! I applied this series. Of note is that I added one more
commit for nvme/050 that has the same problem as nvme/039.
