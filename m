Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F83D5C06
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792038985; cv=fail; b=GcNpX5VpbgmMpdtp94kMgbQpbb8LNC1RyPFJW90hxgWKlzgUx85j8cGufw4Rwsb/85zCwK2pw822DJtcMS6R8v10WX8KufcdxV4ytmVIMeOsExzMbymjdt/9nW2Kkwbxl3CCxTttu9yZjS9ZP8Jf9h/lUxr2DefKjjBL928eXAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792038985; c=relaxed/simple;
	bh=7AN48fS+jiJy8+qozA1g7im7klOEUW8HGXr8V4b8sAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F+Qyh3dMnj4kKq59W5h8Ypt/xMddOWlNq97085VuoMQEUPBgnDCoCgEE0ou0VDIJdH1OoX00xJdfu2p47Ji7asWVOl5n7nmhnKfvROYSvmeVEv4pBa2WA3FG4+3Pnu1LGBU36u1U4lg0XJrTgfYwsVI2BdDQlRIe4VkYWxhu4+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dThLXBS1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ufVohITb; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dThLXBS1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ufVohITb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792038979; x=1823574979;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7AN48fS+jiJy8+qozA1g7im7klOEUW8HGXr8V4b8sAA=;
  b=dThLXBS1NXg9VtrkF89S0Ieykhc8jMTr8Pa2weEBf5KMSUApTAbukLgS
   27UWaF02p23jo86XGhiJteyTYcqK5FmKXQF+u0bCNvVy1+Hz70AEf58gL
   ygUvGClnYBpYJCQwK9wnE9m1pE+1OzUjRaoovK6NLlUul9B93ft4JEsWg
   6GeyNXWelvC3nGuURsJj3PfQEB6UiknP7g2ZsVyrU2uLG3MFwdjrIZj98
   MCZsQWkhSxVTDY3baRKs4aTSZgTCxos8pqLMAOtBi30Z9wOrmBjliGEQ1
   QlCdbcl2uV9WAkoYjzFspmjT5Y8/mTXW8cI6E5qL2QdBnZUTRwHoakCkf
   Q==;
X-CSE-ConnectionGUID: 1/ugKLr7SFSEjlU9VX5tdQ==
X-CSE-MsgGUID: Yxp3/tQ+RxS8kWcGm0TvBQ==
X-IronPort-AV: E=Sophos;i="6.27,159,1786982400"; 
   d="scan'208";a="153917524"
Received: from mail-southcentralusazon11012005.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.5])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2026 12:36:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/xLzvDKOOxx6iU7+kIUGkey501elGfUilJxzQ0DeQq4pfOTpHASkt6D5pfcMZZXdEKawbQUyMfKTOYzVOhLaMIv6RAmYB+BTBr8nV3F3hFrv+eLbSnn2AMF/W8CQwfsyhTs/N3S7HexQ6kLt3N4yZUTie2sxVvW+SQEDMZwnNsH9W2sMtpwjtA1q03FQ8OuCwQ9H+LtsDSqUnyqq2W11MHjLR0uPRTRwN90+ztugCcCQeU1EiA++pxXskcz04mrsVP8XKTaEkzAMFquxbMGRDghr3I36ddd1VlzMytBxC1c6Tas4wle1pT9yIBSrz2rqlsVkWWHZNYgbSOcRNQzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBn1zjUkSNwLWhQr3O6SClmsW4+ym2Ljpsns1DOGUgA=;
 b=TSuH6mxRq1Vfrm65a2WUv3XCN8AcHDMZ/tZdp1YMB6n/5LRIIgWAjPdqtihpjQU3B6lGeRhSHDTq/SWSMXdToxilvVstuwHjCJ9eDC25Jsaa9PPOVql6Rs//n8rBfgjloBx/fzF6axcBzwEbHRsGHFNae48V0PskX1BUj9fHaLZGpmrVI+YmjXvkYNuJom2v7cr2sgI67BSw4Tmpr8ZcIt0zLyos8dzQ9oZEsmYc95Nvaor81cfeYQhqlHqq7CggcpHc3uqlKnwIjEi69DtRN/RWAlwINvODYVYvfSLCgw5TW4vperux4MA4ETE3zcrc2atA1XKNFKUS+qzSgGetVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBn1zjUkSNwLWhQr3O6SClmsW4+ym2Ljpsns1DOGUgA=;
 b=ufVohITbIz1kTPri/8HjRQ7uJZnnYk9NEyTF1J7R8+F8pNe8Z63856cVD+tUnvfXmSGvx/K43FnUhDGVQFi8uHv8Qvm5VyfqPzCbMr0A2Job6bq7L2W7928elAoMynuCqQZ2IGjPWDVkR7jWVcEKtPncaCMz7cADBLG7UbU3q6E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH4PR04MB192972.namprd04.prod.outlook.com
 (2603:10b6:610:514::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 04:36:16 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 04:36:16 +0000
Date: Thu, 15 Oct 2026 13:36:08 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: linux-block@vger.kernel.org, Daniel Wagner <dwagner@suse.de>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v2] nvme/071: add a test for fcloop LS request
 use-after-free
Message-ID: <atBXOkGBUE5FxZXO@shinmob>
References: <20260921145659.17151-1-ngocthang2710.1999@gmail.com>
 <20260923134938.12673-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923134938.12673-1-ngocthang2710.1999@gmail.com>
X-ClientProxiedBy: TY4P301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::15) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH4PR04MB192972:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a12732b-0e77-4770-2131-08df2a75d968
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|23010399003|10067099003|261009223027099003|260925021911599003|260925022911599003|260925021311599003|4143699003|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	pA1hTdMwpA+BRZLDLrE+UKrh/+Mu/yDAhlHqlkyPciZj35WUgfBS7z82HkefWMJro/pQqd8hpV/JYov+N/7GpM8clQBSL9CxZ2PS3DnzBanTP5WYICkfewx2S2QiwKx+ZcLj6yHWOzdDriM+vKeEAJAZetXkMbVGuHshaDkRKw8WfzrC9uIaEjYB4RKo2TQAF0fqlxMgfeMcHgYtH5y8TIm+pDVO4Rb4K7xmfhs4+x/aR4Z5WaeAgUhjn1qQStHWB+0/EkRro2sqHPVlHZy2LerPw4Z5WFoYKu05EXk2GMNctZDMRug7hiPStR0sesFVjhUg7cmAZIfNZcMx9RbkfXIMLqV1C4k9pKClKyr6yXE/OyE9UufXZNlGzVu291veM9QuTSkxVUI0vPOkfVADlcCZdI56eeoT1D4uYBEB3P1XPlMuQKhzsIFG4BrCqmfnpQI7otBfAtbQScIGF9BUnyI6GTwqs2qrdzYXm4ngs5He4Q1N0hQhKJph0imLBj90MbhId2OhobKVQ8oAv8L3Qj3PHW30N0c6cKMl5+3gPVgJJAsH2bJkFJD7BuPepAgcpZ8RwxhWkCDBavZIoZEg2Y18FFos8UodfTUBthgr6d8FB+s8Xgihfh4vrdLjpTuB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(23010399003)(10067099003)(261009223027099003)(260925021911599003)(260925022911599003)(260925021311599003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AO7iZ/NKUOLiEZsuCfTgyTj/O30lhw7mPjOisTfUwC2WYLQ0IR9lB6DbXUZg?=
 =?us-ascii?Q?zuTaHl5M3Dbz2iXAZy+cDmnBsh6Ub2SaZd/9U2Azd+Qz/hCUsEMYABlCDfUD?=
 =?us-ascii?Q?TQMPWzjA8blAuJid1EFc7Fwv9hcEyRNl7RmlA+77fG+N+bNYBqELS6rowKvG?=
 =?us-ascii?Q?AloSYzK+URjX1lGXDMEsuLa5aRkItNx2OREFycZPgX0OAd74WKyisTMauzgY?=
 =?us-ascii?Q?tPNqCi4cJIknnx2rJ8l9iR+LtDFAJfb2qMhnFUUNTk2wgsHDlKBWXeHF+QaH?=
 =?us-ascii?Q?2R/S43o6vx4kcDbe3V2rJbwipXXw1oBYDyzU96nfCZ3l5mC1uXbg1wwmNeWx?=
 =?us-ascii?Q?q7hS+90S9gMjhxYaEv7TZB7lNIewawZR7/00A3cxPl0JV8nrCQ9iXPvYLYy8?=
 =?us-ascii?Q?smgU0ycvdL+2m2k3hxNC7ylYWX31/OXpyHkjuWwY5ZcAQM/1i7IJOzD5XuFF?=
 =?us-ascii?Q?DYnDr+VBpfrOHqeKh2KgVK4BNolsXmcAuOoHa7LutKqmDDA1KqJKQRYeHXgD?=
 =?us-ascii?Q?+i2JzV3LSUzsxtLWnFDJeT387fkJcCBtQ4Hg1nOceyd0XVuZKGHcqdGgqfuv?=
 =?us-ascii?Q?h+xMuhAPtD6HiX7JGoHqOgrmh/rqQB4P6LNfvC2Yg/eVThe3Dp9Z4Y7WtS3t?=
 =?us-ascii?Q?jJHdLiO9cgFtmjxqKGobQim16R5f5fh45MP59XbkrKgJ1rT15kyUnWdgxyBF?=
 =?us-ascii?Q?ZN+QG4eSwLGONlWl1SS6lJEhJvk9o90oYeWDJc0aiKTg7jBQHit9MdikGhwD?=
 =?us-ascii?Q?AVkVaIuRn6tnrBD3a1k4E1ulvNs7yWBh3YKy6hWtnZLbI2XFA33jrNSXiYZI?=
 =?us-ascii?Q?naWLa1ACf/dXQ5YWVYxh/rMrhKPByuF+K52ogaeA+BIc8X4AxGXgo+Ygg1BM?=
 =?us-ascii?Q?WDBLvoMGtZ3YT7Xe2jFjZv9tpxv97Wvu4Su+XdvYR0Z3DUq2MA36WjUNkkF+?=
 =?us-ascii?Q?wbSoUo6JwSyZEJrCa9yJDwdIg2O+gs1lxvxovi4X9SzDUKj+Fa2UMuIiUuwQ?=
 =?us-ascii?Q?CzPN11EJPLZZRxclmzOXdQSur2yTTxP2I+C+uMjzJlfi5NzzH+vq8ew7RpGd?=
 =?us-ascii?Q?wQcqzfv5Dc6p19VCTTBp0hr9RJ9cqsHy2zZoM7WvY1S5LKdP1unsjE7NENqS?=
 =?us-ascii?Q?vVN6Tb/KVQ9B0pbIg24BGBfvFHtoAOes5ETfhR8ONROTmN1lrZNFP4cp2346?=
 =?us-ascii?Q?cSYq5q7zGk6gUzls3ugzHfc+3oZRn8gp32gwpE/YvsWt6ZMza92oQgTYUsiK?=
 =?us-ascii?Q?1gUR54tp8CJdxsgv4AA/Y/laE1zHgPijhUF8JYZLst6DCtdkQ1swYkldrDWo?=
 =?us-ascii?Q?NwvMb4OLyzUuvX31JRuzIaDc2BU+sTI1kAoCm7524TmCOCAL0MxLoHYIIYxU?=
 =?us-ascii?Q?E0JbEcATL+0CKi+l01COn597BUueQLuNcIykn+BewT4lSAq3GR1YwqKfQCgn?=
 =?us-ascii?Q?5bstWckI232xfRwPga+EpI5iYT9Ckw1f+c4rANAWfKJp6HHdwXyuKI28FPQX?=
 =?us-ascii?Q?NKOVs+V1hN6IwIrxapCRS0SZSQb9RnXlXBjEYv2sRczUs6fpAox7+pAqLEJW?=
 =?us-ascii?Q?IRajRauaFcDyzK+LPBQOPPs6nPleuNlPgSe9LQ5B9yzcFbMXXVl+vH1VTGLm?=
 =?us-ascii?Q?l6xUNPAGHSc7dSO4Xv+BRTdpXO9iR4zpSQNFGmgU3RGP5mwJ8qz+oYlJWI72?=
 =?us-ascii?Q?j7uw8aHLwsgfYnFpEZvLnHZgWONx7XUWUjnVBVRNCB7MWJ9yLBbkjEqP2SY4?=
 =?us-ascii?Q?+OwhUOneMRfJJXxD52U3eBTYs63xgK4=3D?=
X-Exchange-RoutingPolicyChecked:
	1ThOxHuevfPPsHwcVKtEE49Phpgu6lac3Ephtka2JRaAKJDT2Uekm8oUIh/Q2IAVi75rjD9X+VFV2olqklLgZINCTeqT1jAxr+k3eHLlzSlwe2qEwsdjLKaFv3F4nfxMyqHSNN9YOvqqqbq/7SFw3IW74pJdYkr7iCmPNrrevb1Z8iebzIkb2zb49aX5bUfi7k9L9wNk6D5uXgj95hPLJgcWY8fvuXBTqS7qZKZPGGunSclYEdOaJGuc/WHRdxgfN/8h5TqIGKY5/fAKfmIdAm3MvVOSfKDTIbcmyAN5sh3uOVTYNw6FF8LyF4jbTdv8BDsbia5iTMrA0jTDPDDUgA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RT19UaUOGqCcNe2PRaktCF84+DyeiZUjN/VDPHqX9B2xItGBWLDAnPtgJ67B2303PFz9uwAEGfiuZFpoz4ac7M/5j0yrIedrJWYWG+r3FJTcZUHP4fqSq61tqatwV9iR00Zk83/wcr8aeenfSpRxjT7YKpsKXV7Bxvd+N4Ug86zEcvyWxLp152RtYfOLzvqoWTW7nqD8PbPygnjPP7+3dnDhseR8aAw8mZN9BYfe3XPEN5BU9YqG+TRJ7HxvSq0jdobt9N9wMpSJPtASP/PDawdHZjPKfSW5k93PyhKQTzWuOgm3jh2pllG+/dZaulXr6/4idn8FUFDO12Xg1HQWhKcSxD+GrWNQOOoRbchoC9YlCvkXDbNokJBVSJagLzM/5m2OzX1TjAiet/uXOhbuLZ3yEo5m/PiSB4YXc0Xboj4HcoH78VI9kPTSy/emoOVDU3wNeA55m0i+wXwgEfDkIcchlwzUVrLCAnKhpaIF2q4JkvMDCFroh93FuWOCsCEpjWDk3V4qKi7dqECKzdz194DR4t6TbCwX8xm+NxA02eK98DKLRI5LCdYCEQIeVRdI8zBgNwfuau+9/GM9UxzoEYe6TRdb6eQmwm354bS3x3l9yTd/z6xrs4B3Jgz6r2Q1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a12732b-0e77-4770-2131-08df2a75d968
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 04:36:16.0424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epTCtNI1e7G7H/XE2GsohXrRMDxvf3Yn3qcLovP6Ast4DyHKxqkyAIDaS+1s+p2mXccDGKHy80VyLX5mGJuy5jzXkIgDhmOFig6WuAu8Wmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB192972

On Sep 23, 2026 / 20:49, Nguyen Ngoc Thang wrote:
> Delete the fcloop remote port and then the target port while an
> association is being deleted. The Disconnect Association LS is completed
> from a work item that can run after nvmet_fc_unregister_targetport() freed
> the pending request, which KASAN reports as a use-after-free in
> fcloop_tport_lsrqst_work().
> 
> Kernel fix: "nvmet-fc: flush nvmet_wq twice on targetport unregister"

Nguyen, thanks for the v2 patch. The patch looks good to me.

Said that, I still observe the hang when I run the new test case in my test
environment. I applied the kernel side fix patch [1] on top of v7.3-rc7 kernel.
FYI, here I share the dmesg observed along with the hung [2]. Interestingly,
"KASAN: null-ptr-deref in fcloop_t2h_xmt_ls_rsp" was observed. I think it
indicates that the kernel side fix may not be good enough.

[1] https://lore.kernel.org/linux-nvme/20260921145651.17131-1-ngocthang2710.1999@gmail.com/

[2] dmesg during the test case run

[   83.072796] [   T1008] run blktests nvme/071 at 2026-10-15 13:09:32.044211665
[   83.260301] [   T1088] loop0: detected capacity change from 0 to 2097152
[   83.303966] [   T1092] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   83.633007] [     T92] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   83.634138] [     T88] nvmet_fc: {0:0}: Association created
[   83.643306] [     T86] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   83.670654] [     T92] nvme nvme5: NVME-FC{0}: controller connect complete
[   83.672386] [   T1122] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   83.901409] [     T96] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   83.902177] [     T89] nvmet_fc: {0:1}: Association created
[   83.903916] [     T89] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   83.910515] [     T96] nvme nvme6: NVME-FC{1}: controller connect complete
[   83.910948] [   T1125] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   83.921434] [   T1125] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   83.939194] [     T86] nvmet_fc: {0:1}: Association deleted
[   83.951992] [     T46] (NULL device *): Disconnect LS failed: No Association
[   83.952634] [     T86] nvmet_fc: {0:1}: Association freed
[   84.213042] [     T89] nvmet_fc: {0:0}: Association deleted
[   84.238009] [     T86] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   84.238415] [     T96] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[   84.238501] [     T96] nvme nvme5: NVME-FC{0}: resetting controller
[   84.252940] [     T89] nvmet_fc: {0:0}: Association freed
[   84.256006] [     T89] nvmet_fc: {0}: Disconnect LS failed: No Association
[   84.256064] [     T89] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   84.256172] [     T96] nvmet_fc: {0}: Create Association LS failed: Association Allocation Failed
[   84.256248] [     T89] (NULL device *): queue 0 connect admin queue failed (-6).
[   84.256279] [     T89] nvme nvme5: NVME-FC{0}: reset: Reconnect attempt failed (-6)
[   84.256306] [     T89] nvme nvme5: NVME-FC{0}: Max reconnect attempts (1) reached.
[   84.256475] [     T89] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   84.257318] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   84.526046] [   T1168] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[   84.728884] [     T86] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   84.729279] [     T89] nvmet_fc: {0:0}: Association created
[   84.735450] [     T96] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   84.755011] [     T86] nvme nvme5: NVME-FC{0}: controller connect complete
[   84.758210] [   T1205] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   85.031214] [     T89] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   85.035363] [     T92] nvmet_fc: {0:1}: Association created
[   85.037893] [     T92] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   85.045280] [     T89] nvme nvme6: NVME-FC{1}: controller connect complete
[   85.046357] [   T1212] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   85.063078] [   T1212] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   85.080865] [     T89] nvmet_fc: {0:1}: Association deleted
[   85.091015] [     T89] nvmet_fc: {0:1}: Association freed
[   85.091839] [    T101] (NULL device *): Disconnect LS failed: No Association
[   85.280093] [     T86] nvmet_fc: {0:0}: Association deleted
[   85.315177] [     T89] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   85.315522] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   85.316308] [     T89] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[   85.323233] [     T89] nvme nvme5: NVME-FC{0}: resetting controller
[   85.329395] [     T86] nvmet_fc: {0:0}: Association freed
[   85.335144] [     T92] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   85.336745] [     T92] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   85.567414] [   T1251] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[   85.780213] [     T89] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   85.786475] [     T92] nvmet_fc: {0:0}: Association created
[   85.791061] [     T92] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   85.802724] [     T89] nvme nvme5: NVME-FC{0}: controller connect complete
[   85.804657] [   T1289] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   86.087536] [     T92] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   86.091224] [     T96] nvmet_fc: {0:1}: Association created
[   86.095555] [     T89] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   86.100596] [     T92] nvme nvme6: NVME-FC{1}: controller connect complete
[   86.103146] [   T1297] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   86.114534] [   T1297] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   86.132749] [     T96] nvmet_fc: {0:1}: Association deleted
[   86.141123] [     T96] nvmet_fc: {0:1}: Association freed
[   86.142881] [     T28] (NULL device *): Disconnect LS failed: No Association
[   86.324024] [     T92] nvmet_fc: {0:0}: Association deleted
[   86.361779] [     T96] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   86.363773] [      C0] clocksource: Watchdog remote CPU 1 read timed out
[   86.363795] [     T89] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[   86.363801] [     T89] nvme nvme5: NVME-FC{0}: resetting controller
[   86.369331] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   86.371702] [     T92] nvmet_fc: {0:0}: Association freed
[   86.376292] [     T89] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   86.377069] [     T89] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   86.613682] [   T1335] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[   86.804657] [     T89] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   86.805728] [     T92] nvmet_fc: {0:0}: Association created
[   86.809841] [     T92] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   86.828500] [     T89] nvme nvme5: NVME-FC{0}: controller connect complete
[   86.830067] [   T1373] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   87.126543] [     T96] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   87.130001] [     T86] nvmet_fc: {0:1}: Association created
[   87.138170] [     T86] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   87.149857] [     T96] nvme nvme6: NVME-FC{1}: controller connect complete
[   87.152530] [   T1381] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   87.167014] [   T1381] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   87.193714] [     T86] nvmet_fc: {0:1}: Association deleted
[   87.203339] [     T28] (NULL device *): Disconnect LS failed: No Association
[   87.204552] [     T86] nvmet_fc: {0:1}: Association freed
[   87.383982] [     T86] nvmet_fc: {0:0}: Association deleted
[   87.412179] [     T96] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   87.414085] [     T96] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[   87.415489] [     T96] nvme nvme5: NVME-FC{0}: resetting controller
[   87.420529] [     T86] nvmet_fc: {0:0}: Association freed
[   87.420898] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   87.426819] [     T96] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   87.427897] [     T96] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   87.670911] [   T1420] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[   87.874125] [     T96] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   87.876349] [     T89] nvmet_fc: {0:0}: Association created
[   87.878692] [     T86] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   87.894752] [     T96] nvme nvme5: NVME-FC{0}: controller connect complete
[   87.897846] [   T1457] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   88.188396] [     T89] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   88.192816] [     T92] nvmet_fc: {0:1}: Association created
[   88.196409] [     T92] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   88.205016] [     T89] nvme nvme6: NVME-FC{1}: controller connect complete
[   88.206759] [   T1466] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   88.225464] [   T1466] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   88.240784] [     T86] nvmet_fc: {0:1}: Association deleted
[   88.244845] [     T86] nvmet_fc: {0:1}: Association freed
[   88.246320] [      T9] (NULL device *): Disconnect LS failed: No Association
[   88.437143] [     T92] nvmet_fc: {0:0}: Association deleted
[   88.460965] [     T86] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   88.465427] [     T89] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[   88.469697] [     T89] nvme nvme5: NVME-FC{0}: resetting controller
[   88.473613] [     T92] nvmet_fc: {0:0}: Association freed
[   88.486328] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   88.486466] [     T92] nvmet_fc: {0}: Disconnect LS failed: No Association
[   88.489632] [     T89] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   88.491682] [     T88] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   88.910497] [     T89] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   88.911610] [     T88] nvmet_fc: {0:0}: Association created
[   88.916776] [     T92] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   88.931874] [     T89] nvme nvme5: NVME-FC{0}: controller connect complete
[   88.932889] [   T1537] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   89.221886] [     T89] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   89.224131] [     T88] nvmet_fc: {0:1}: Association created
[   89.227820] [     T96] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   89.233168] [     T89] nvme nvme6: NVME-FC{1}: controller connect complete
[   89.234080] [   T1548] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   89.243268] [   T1548] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   89.265623] [     T86] nvmet_fc: {0:1}: Association deleted
[   89.273232] [     T86] nvmet_fc: {0:1}: Association freed
[   89.274084] [     T40] (NULL device *): Disconnect LS failed: No Association
[   89.541224] [     T96] nvmet_fc: {0:0}: Association deleted
[   89.572908] [     T86] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   89.575544] [     T86] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[   89.578316] [     T86] nvme nvme5: NVME-FC{0}: resetting controller
[   89.580418] [     T96] nvmet_fc: {0:0}: Association freed
[   89.585798] [     T96] nvmet_fc: {0}: Disconnect LS failed: No Association
[   89.585830] [     T86] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   89.588174] [     T89] nvmet_fc: {0}: Create Association LS failed: Association Allocation Failed
[   89.590291] [     T86] (NULL device *): queue 0 connect admin queue failed (-6).
[   89.591261] [     T86] nvme nvme5: NVME-FC{0}: reset: Reconnect attempt failed (-6)
[   89.592136] [     T86] nvme nvme5: NVME-FC{0}: Max reconnect attempts (1) reached.
[   89.592964] [     T96] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   89.597869] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   89.833849] [   T1586] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[   90.015943] [     T88] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   90.017004] [     T96] nvmet_fc: {0:0}: Association created
[   90.019224] [     T86] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   90.038352] [     T88] nvme nvme5: NVME-FC{0}: controller connect complete
[   90.040265] [   T1624] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   90.322459] [     T96] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   90.324349] [     T92] nvmet_fc: {0:1}: Association created
[   90.326555] [     T88] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   90.336371] [     T96] nvme nvme6: NVME-FC{1}: controller connect complete
[   90.337223] [   T1632] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   90.345215] [   T1632] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   90.354773] [     T92] nvmet_fc: {0:1}: Association deleted
[   90.366727] [      T9] (NULL device *): Disconnect LS failed: No Association
[   90.369543] [     T92] nvmet_fc: {0:1}: Association freed
[   90.572062] [     T92] nvmet_fc: {0:0}: Association deleted
[   90.606290] [     T88] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   90.607310] [     T88] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[   90.608257] [     T88] nvme nvme5: NVME-FC{0}: resetting controller
[   90.609169] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   90.618147] [     T92] nvmet_fc: {0:0}: Association freed
[   90.624571] [     T96] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   90.625943] [     T96] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   90.857570] [   T1671] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[   91.063878] [     T92] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   91.066594] [     T96] nvmet_fc: {0:0}: Association created
[   91.070555] [     T96] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   91.080934] [     T92] nvme nvme5: NVME-FC{0}: controller connect complete
[   91.081849] [   T1708] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   91.379055] [     T92] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   91.381004] [     T89] nvmet_fc: {0:1}: Association created
[   91.386067] [     T88] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   91.390536] [     T92] nvme nvme6: NVME-FC{1}: controller connect complete
[   91.392087] [   T1717] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   91.403457] [   T1717] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   91.427975] [     T92] nvmet_fc: {0:1}: Association deleted
[   91.436784] [    T224] (NULL device *): Disconnect LS failed: No Association
[   91.440223] [     T92] nvmet_fc: {0:1}: Association freed
[   91.617891] [     T88] nvmet_fc: {0:0}: Association deleted
[   91.644513] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   91.644524] [     T92] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   91.650201] [     T88] nvmet_fc: {0:0}: Association freed
[   91.656801] [     T89] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   91.658020] [     T92] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   92.066978] [     T92] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   92.068066] [     T89] nvmet_fc: {0:0}: Association created
[   92.072480] [     T88] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   92.087810] [     T92] nvme nvme5: NVME-FC{0}: controller connect complete
[   92.091395] [   T1792] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   92.378957] [     T88] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   92.380901] [     T92] nvmet_fc: {0:1}: Association created
[   92.383025] [     T92] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   92.387733] [     T88] nvme nvme6: NVME-FC{1}: controller connect complete
[   92.388522] [   T1801] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   92.396510] [   T1801] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   92.415847] [     T88] nvmet_fc: {0:1}: Association deleted
[   92.422709] [    T224] (NULL device *): Disconnect LS failed: No Association
[   92.423606] [     T88] nvmet_fc: {0:1}: Association freed
[   92.606998] [     T88] nvmet_fc: {0:0}: Association deleted
[   92.626165] [     T92] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   92.628198] [     T96] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[   92.629407] [     T96] nvme nvme5: NVME-FC{0}: resetting controller
[   92.633564] [     T88] nvmet_fc: {0:0}: Association freed
[   92.638840] [     T88] nvmet_fc: {0}: Disconnect LS failed: No Association
[   92.638904] [     T89] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   92.640449] [     T86] nvmet_fc: {0}: Create Association LS failed: Association Allocation Failed
[   92.642128] [     T89] (NULL device *): queue 0 connect admin queue failed (-6).
[   92.642753] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   92.642896] [     T89] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   92.644853] [     T89] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   92.868751] [   T1840] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[   93.095953] [     T89] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   93.097051] [     T88] nvmet_fc: {0:0}: Association created
[   93.100496] [     T96] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   93.120195] [     T89] nvme nvme5: NVME-FC{0}: controller connect complete
[   93.121085] [   T1877] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   93.424624] [     T88] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   93.427153] [     T96] nvmet_fc: {0:1}: Association created
[   93.429614] [     T86] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   93.436529] [     T88] nvme nvme6: NVME-FC{1}: controller connect complete
[   93.440201] [   T1886] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   93.450336] [   T1886] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   93.470591] [     T88] nvmet_fc: {0:1}: Association deleted
[   93.478971] [      T9] (NULL device *): Disconnect LS failed: No Association
[   93.480735] [     T88] nvmet_fc: {0:1}: Association freed
[   93.644148] [     T86] nvmet_fc: {0:0}: Association deleted
[   93.684838] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   93.694817] [     T96] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   93.695043] [     T88] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   93.698709] [     T88] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   93.705142] [     T86] nvmet_fc: {0:0}: Association freed
[   93.709989] [     T96] nvme nvme5: NVME-FC{0}: transport error during (re)connect
[   93.942984] [   T1924] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[   94.147543] [     T88] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   94.148637] [     T96] nvmet_fc: {0:0}: Association created
[   94.153136] [     T96] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   94.169673] [     T88] nvme nvme5: NVME-FC{0}: controller connect complete
[   94.170470] [   T1961] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   94.454702] [     T86] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   94.456634] [     T88] nvmet_fc: {0:1}: Association created
[   94.458717] [     T96] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   94.464608] [     T86] nvme nvme6: NVME-FC{1}: controller connect complete
[   94.465495] [   T1969] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   94.478642] [   T1969] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   94.498988] [     T92] nvmet_fc: {0:1}: Association deleted
[   94.508572] [     T92] nvmet_fc: {0:1}: Association freed
[   94.510263] [    T224] (NULL device *): Disconnect LS failed: No Association
[   94.693883] [     T92] nvmet_fc: {0:0}: Association deleted
[   94.717334] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   94.731177] [     T86] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   94.732576] [     T96] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   94.738577] [     T92] nvmet_fc: {0:0}: Association freed
[   94.977291] [   T2008] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[   95.168642] [     T96] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   95.170103] [     T86] nvmet_fc: {0:0}: Association created
[   95.176727] [     T88] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   95.194400] [     T96] nvme nvme5: NVME-FC{0}: controller connect complete
[   95.196069] [   T2046] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   95.496596] [     T96] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   95.498468] [     T86] nvmet_fc: {0:1}: Association created
[   95.501968] [     T86] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   95.505739] [     T96] nvme nvme6: NVME-FC{1}: controller connect complete
[   95.506556] [   T2054] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   95.519219] [   T2054] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   95.534767] [     T12] nvmet_fc: {0:1}: Association deleted
[   95.541523] [     T12] nvmet_fc: {0:1}: Association freed
[   95.542363] [     T40] (NULL device *): Disconnect LS failed: No Association
[   95.713992] [     T86] nvmet_fc: {0:0}: Association deleted
[   95.752655] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   95.760840] [     T96] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   95.763498] [     T12] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   95.764790] [     T12] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   95.768316] [     T86] nvmet_fc: {0:0}: Association freed
[   95.993538] [   T2093] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[   96.195931] [     T86] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   96.198943] [     T12] nvmet_fc: {0:0}: Association created
[   96.201883] [     T96] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   96.216425] [     T86] nvme nvme5: NVME-FC{0}: controller connect complete
[   96.219500] [   T2130] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   96.513502] [     T12] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   96.515745] [     T86] nvmet_fc: {0:1}: Association created
[   96.517881] [     T92] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   96.521486] [     T12] nvme nvme6: NVME-FC{1}: controller connect complete
[   96.523688] [   T2137] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   96.537639] [   T2137] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   96.553809] [     T92] nvmet_fc: {0:1}: Association deleted
[   96.558430] [     T92] nvmet_fc: {0:1}: Association freed
[   96.561090] [    T101] (NULL device *): Disconnect LS failed: No Association
[   96.747158] [     T92] nvmet_fc: {0:0}: Association deleted
[   96.771685] [     T88] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   96.774445] [     T88] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[   96.775698] [     T88] nvme nvme5: NVME-FC{0}: resetting controller
[   96.786522] [     T92] nvmet_fc: {0:0}: Association freed
[   96.787529] [     T92] nvmet_fc: {0}: Disconnect LS failed: No Association
[   96.789252] [     T92] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   96.790748] [     T86] nvmet_fc: {0}: Create Association LS failed: Association Allocation Failed
[   96.791555] [     T92] (NULL device *): queue 0 connect admin queue failed (-6).
[   96.792363] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   96.794608] [     T92] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   96.795849] [     T92] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   97.037971] [   T2177] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[   97.242396] [     T92] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   97.243489] [     T88] nvmet_fc: {0:0}: Association created
[   97.247554] [     T86] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   97.265264] [     T92] nvme nvme5: NVME-FC{0}: controller connect complete
[   97.268901] [   T2214] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   97.557177] [     T88] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   97.559041] [     T92] nvmet_fc: {0:1}: Association created
[   97.563643] [     T92] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   97.569891] [     T88] nvme nvme6: NVME-FC{1}: controller connect complete
[   97.571720] [   T2223] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   97.579424] [   T2223] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   97.599998] [     T86] nvmet_fc: {0:1}: Association deleted
[   97.605731] [     T46] (NULL device *): Disconnect LS failed: No Association
[   97.606585] [     T86] nvmet_fc: {0:1}: Association freed
[   97.772943] [     T86] nvmet_fc: {0:0}: Association deleted
[   97.799688] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   97.814597] [     T88] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   97.817950] [     T88] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   97.826244] [     T86] nvmet_fc: {0:0}: Association freed
[   98.057136] [   T2260] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[   98.249624] [     T88] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   98.250797] [     T86] nvmet_fc: {0:0}: Association created
[   98.252999] [     T96] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   98.274328] [     T88] nvme nvme5: NVME-FC{0}: controller connect complete
[   98.277169] [   T2298] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   98.583169] [     T86] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   98.585599] [     T96] nvmet_fc: {0:1}: Association created
[   98.587863] [     T96] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   98.595286] [     T86] nvme nvme6: NVME-FC{1}: controller connect complete
[   98.597156] [   T2307] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   98.606390] [   T2307] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   98.624796] [     T86] nvmet_fc: {0:1}: Association deleted
[   98.633105] [    T165] (NULL device *): Disconnect LS failed: No Association
[   98.633764] [     T86] nvmet_fc: {0:1}: Association freed
[   98.814090] [     T96] nvmet_fc: {0:0}: Association deleted
[   98.840907] [     T86] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   98.841788] [     T86] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[   98.842589] [     T86] nvme nvme5: NVME-FC{0}: resetting controller
[   98.844562] [     T96] nvmet_fc: {0:0}: Association freed
[   98.845369] [    T165] nvme nvme5: NVME-FC{0}: transport association event: Disconnect Association LS received
[   98.846147] [    T165] nvme nvme5: NVME-FC{0}: resetting controller
[   98.852057] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   98.859836] [     T96] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   98.860624] [     T96] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[   99.090026] [   T2344] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[   99.294501] [     T96] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[   99.298469] [     T86] nvmet_fc: {0:0}: Association created
[   99.301685] [     T12] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   99.324825] [     T96] nvme nvme5: NVME-FC{0}: controller connect complete
[   99.325632] [   T2382] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[   99.604534] [     T88] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   99.606588] [     T92] nvmet_fc: {0:1}: Association created
[   99.608736] [     T92] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[   99.614571] [     T88] nvme nvme6: NVME-FC{1}: controller connect complete
[   99.615588] [   T2389] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[   99.625222] [   T2389] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[   99.643413] [     T88] nvmet_fc: {0:1}: Association deleted
[   99.650137] [     T88] nvmet_fc: {0:1}: Association freed
[   99.651719] [     T46] (NULL device *): Disconnect LS failed: No Association
[   99.862069] [     T88] nvmet_fc: {0:0}: Association deleted
[   99.882871] [     T92] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[   99.883712] [     T86] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[   99.884468] [     T86] nvme nvme5: NVME-FC{0}: resetting controller
[   99.890352] [     T88] nvmet_fc: {0:0}: Association freed
[   99.893838] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[   99.896988] [     T86] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[   99.898138] [     T86] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[  100.147172] [   T2429] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[  100.338237] [     T86] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  100.340750] [     T92] nvmet_fc: {0:0}: Association created
[  100.342649] [     T88] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  100.353610] [     T86] nvme nvme5: NVME-FC{0}: controller connect complete
[  100.355467] [   T2466] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  100.650314] [     T86] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  100.652190] [     T92] nvmet_fc: {0:1}: Association created
[  100.654940] [     T96] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[  100.661259] [     T86] nvme nvme6: NVME-FC{1}: controller connect complete
[  100.662162] [   T2475] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[  100.671340] [   T2475] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  100.689603] [     T96] nvmet_fc: {0:1}: Association deleted
[  100.695402] [     T28] (NULL device *): Disconnect LS failed: No Association
[  100.696383] [     T96] nvmet_fc: {0:1}: Association freed
[  100.884394] [     T86] nvmet_fc: {0:0}: Association deleted
[  100.911343] [     T96] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[  100.912214] [     T92] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[  100.913115] [     T92] nvme nvme5: NVME-FC{0}: resetting controller
[  100.917768] [     T86] nvmet_fc: {0:0}: Association freed
[  100.923252] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  100.931847] [     T92] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  100.932635] [     T12] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[  101.165060] [   T2512] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[  101.377896] [     T12] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  101.380655] [     T92] nvmet_fc: {0:0}: Association created
[  101.387208] [     T86] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  101.404987] [     T12] nvme nvme5: NVME-FC{0}: controller connect complete
[  101.410554] [   T2550] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  101.707942] [     T96] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  101.709825] [     T86] nvmet_fc: {0:1}: Association created
[  101.714153] [     T90] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[  101.720095] [     T96] nvme nvme6: NVME-FC{1}: controller connect complete
[  101.721901] [   T2557] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[  101.731589] [   T2557] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  101.754755] [     T92] nvmet_fc: {0:1}: Association deleted
[  101.764603] [     T92] nvmet_fc: {0:1}: Association freed
[  101.766524] [     T34] (NULL device *): Disconnect LS failed: No Association
[  101.927082] [     T92] nvmet_fc: {0:0}: Association deleted
[  101.962278] [     T96] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[  101.963439] [     T90] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[  101.964535] [     T90] nvme nvme5: NVME-FC{0}: resetting controller
[  101.969131] [     T92] nvmet_fc: {0:0}: Association freed
[  101.971259] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  101.972109] [     T46] ==================================================================
[  101.972880] [     T46] BUG: KASAN: null-ptr-deref in fcloop_t2h_xmt_ls_rsp+0x141/0x450 [nvme_fcloop]
[  101.973643] [     T46] Read of size 24 at addr 0000000000000000 by task kworker/1:1/46

[  101.975116] [     T46] CPU: 1 UID: 0 PID: 46 Comm: kworker/1:1 Not tainted 7.3.0-rc7+ #473 PREEMPT(full) 
[  101.975120] [     T46] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[  101.975124] [     T46] Workqueue: events nvme_fc_handle_ls_rqst_work [nvme_fc]
[  101.975139] [     T46] Call Trace:
[  101.975141] [     T46]  <TASK>
[  101.975144] [     T46]  dump_stack_lvl+0x6a/0x90
[  101.975150] [     T46]  kasan_report+0xd5/0x100
[  101.975170] [     T46]  ? fcloop_t2h_xmt_ls_rsp+0x141/0x450 [nvme_fcloop]
[  101.975175] [     T46]  ? fcloop_t2h_xmt_ls_rsp+0x141/0x450 [nvme_fcloop]
[  101.975180] [     T46]  kasan_check_range+0x134/0x210
[  101.975183] [     T46]  __asan_memcpy+0x1f/0x60
[  101.975186] [     T46]  fcloop_t2h_xmt_ls_rsp+0x141/0x450 [nvme_fcloop]
[  101.975192] [     T46]  nvme_fc_xmt_ls_rsp+0x1bf/0x270 [nvme_fc]
[  101.975198] [     T46]  ? trace_hardirqs_on+0x14/0x190
[  101.975201] [     T46]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[  101.975205] [     T46]  nvme_fc_handle_ls_rqst_work+0x3ef/0x1c70 [nvme_fc]
[  101.975213] [     T46]  ? lock_acquire+0x1b1/0x340
[  101.975218] [     T46]  ? __pfx_nvme_fc_handle_ls_rqst_work+0x10/0x10 [nvme_fc]
[  101.975224] [     T46]  ? lock_acquire+0x1c1/0x340
[  101.975226] [     T46]  ? process_one_work+0x7dc/0x1760
[  101.975231] [     T46]  process_one_work+0x940/0x1760
[  101.975237] [     T46]  ? __pfx_process_one_work+0x10/0x10
[  101.975240] [     T46]  ? lock_acquire+0x1b1/0x340
[  101.975245] [     T46]  worker_thread+0x5fd/0xfe0
[  101.975250] [     T46]  ? __pfx_worker_thread+0x10/0x10
[  101.975252] [     T46]  kthread+0x367/0x460
[  101.975255] [     T46]  ? __pfx_kthread+0x10/0x10
[  101.975258] [     T46]  ret_from_fork+0x653/0x9d0
[  101.975261] [     T46]  ? __pfx_ret_from_fork+0x10/0x10
[  101.975264] [     T46]  ? __switch_to+0x16c/0xda0
[  101.975267] [     T46]  ? __switch_to_asm+0x39/0x70
[  101.975270] [     T46]  ? __switch_to_asm+0x33/0x70
[  101.975272] [     T46]  ? __pfx_kthread+0x10/0x10
[  101.975275] [     T46]  ret_from_fork_asm+0x1a/0x30
[  101.975280] [     T46]  </TASK>
[  101.975282] [     T46] ==================================================================
[  102.002810] [     T90] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  102.003507] [     T90] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[  102.004464] [     T46] Disabling lock debugging due to kernel taint
[  102.004484] [     T46] Oops: general protection fault, probably for non-canonical address 0x66ce8cad617355c1: 0000 [#1] SMP KASAN PTI
[  102.009223] [     T46] CPU: 1 UID: 0 PID: 46 Comm: kworker/1:1 Tainted: G    B               7.3.0-rc7+ #473 PREEMPT(full) 
[  102.010915] [     T46] Tainted: [B]=BAD_PAGE
[  102.011781] [     T46] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[  102.012975] [     T46] Workqueue: events nvme_fc_handle_ls_rqst_work [nvme_fc]
[  102.014206] [     T46] RIP: 0010:its_return_thunk+0x0/0x10
[  102.015234] [     T46] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <c3> cc 0f 1f 00 66 66 2e 0f 1f 84 00 00 00 00 00 e9 1b be e7 fc cc
[  102.018324] [     T46] RSP: 0018:ffff888101597a70 EFLAGS: 00010246
[  102.019475] [     T46] RAX: 66ce8cad617355c1 RBX: ffff88812c36d890 RCX: 0000000000000001
[  102.020821] [     T46] RDX: 1ffff1102586db15 RSI: 0000000000000008 RDI: ffff88812c36d890
[  102.022176] [     T46] RBP: ffff888102552000 R08: ffffffffa252aba6 R09: 1ffffffff50370a0
[  102.023518] [     T46] R10: fffffbfff50370a1 R11: fffffbfff50370a1 R12: ffff88812f42fc00
[  102.024857] [     T46] R13: 0000000000000018 R14: ffff888137374000 R15: dffffc0000000000
[  102.026194] [     T46] FS:  0000000000000000(0000) GS:ffff888404581000(0000) knlGS:0000000000000000
[  102.027649] [     T46] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  102.028827] [     T46] CR2: 00007fa070605b90 CR3: 000000013a772000 CR4: 00000000000006f0
[  102.030191] [     T46] Call Trace:
[  102.030967] [     T46]  <TASK>
[  102.031710] [     T46]  ? fcloop_t2h_xmt_ls_rsp+0x16c/0x450 [nvme_fcloop]
[  102.032923] [     T46]  ? nvme_fc_xmt_ls_rsp+0x1bf/0x270 [nvme_fc]
[  102.034055] [     T46]  ? trace_hardirqs_on+0x14/0x190
[  102.035047] [     T46]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[  102.036142] [     T46]  ? nvme_fc_handle_ls_rqst_work+0x3ef/0x1c70 [nvme_fc]
[  102.037386] [     T46]  ? lock_acquire+0x1b1/0x340
[  102.038365] [     T46]  ? __pfx_nvme_fc_handle_ls_rqst_work+0x10/0x10 [nvme_fc]
[  102.039637] [     T46]  ? lock_acquire+0x1c1/0x340
[  102.040614] [     T46]  ? process_one_work+0x7dc/0x1760
[  102.041640] [     T46]  ? process_one_work+0x940/0x1760
[  102.042663] [     T46]  ? __pfx_process_one_work+0x10/0x10
[  102.043712] [     T46]  ? lock_acquire+0x1b1/0x340
[  102.044680] [     T46]  ? worker_thread+0x5fd/0xfe0
[  102.045659] [     T46]  ? __pfx_worker_thread+0x10/0x10
[  102.046680] [     T46]  ? kthread+0x367/0x460
[  102.047592] [     T46]  ? __pfx_kthread+0x10/0x10
[  102.048549] [     T46]  ? ret_from_fork+0x653/0x9d0
[  102.049521] [     T46]  ? __pfx_ret_from_fork+0x10/0x10
[  102.050542] [     T46]  ? __switch_to+0x16c/0xda0
[  102.051502] [     T46]  ? __switch_to_asm+0x39/0x70
[  102.052479] [     T46]  ? __switch_to_asm+0x33/0x70
[  102.053454] [     T46]  ? __pfx_kthread+0x10/0x10
[  102.054408] [     T46]  ? ret_from_fork_asm+0x1a/0x30
[  102.055416] [     T46]  </TASK>
[  102.056175] [     T46] Modules linked in: loop nvme_fcloop nvmet_fc nvmet nvme_fc nvme_fabrics nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr sunrpc 9pnet_virtio 9pnet pcspkr netfs i2c_piix4 i2c_smbus dm_multipath zram vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock xfs bochs drm_client_lib drm_shmem_helper drm_kms_helper nvme floppy sym53c8xx nvme_core drm e1000 nvme_keyring scsi_transport_spi nvme_auth serio_raw ata_generic pata_acpi i2c_dev qemu_fw_cfg virtiofs fuse virtio_console
[  102.065198] [     T46] ---[ end trace 0000000000000000 ]---
[  102.066336] [     T46] RIP: 0010:its_return_thunk+0x0/0x10
[  102.066826] [     T46] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <c3> cc 0f 1f 00 66 66 2e 0f 1f 84 00 00 00 00 00 e9 1b be e7 fc cc
[  102.068956] [     T46] RSP: 0018:ffff888101597a70 EFLAGS: 00010246
[  102.069432] [     T46] RAX: 66ce8cad617355c1 RBX: ffff88812c36d890 RCX: 0000000000000001
[  102.069913] [     T46] RDX: 1ffff1102586db15 RSI: 0000000000000008 RDI: ffff88812c36d890
[  102.070385] [     T46] RBP: ffff888102552000 R08: ffffffffa252aba6 R09: 1ffffffff50370a0
[  102.070851] [     T46] R10: fffffbfff50370a1 R11: fffffbfff50370a1 R12: ffff88812f42fc00
[  102.071306] [     T46] R13: 0000000000000018 R14: ffff888137374000 R15: dffffc0000000000
[  102.071757] [     T46] FS:  0000000000000000(0000) GS:ffff888404581000(0000) knlGS:0000000000000000
[  102.072201] [     T46] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  102.072637] [     T46] CR2: 00007fa070605b90 CR3: 000000013a772000 CR4: 00000000000006f0
[  102.185392] [   T2595] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[  102.326027] [     T90] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  102.327377] [     T96] nvmet_fc: {0:0}: Association created
[  102.329613] [     T96] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  102.339005] [     T90] nvme nvme5: NVME-FC{0}: controller connect complete
[  102.339583] [   T2635] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  102.503598] [     T92] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  102.505153] [     T12] nvmet_fc: {0:1}: Association created
[  102.506334] [     T90] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[  102.508444] [     T92] nvme nvme6: NVME-FC{1}: controller connect complete
[  102.509617] [   T2644] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[  102.517453] [   T2644] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  102.532985] [     T12] nvmet_fc: {0:1}: Association deleted
[  102.537522] [     T12] nvmet_fc: {0:1}: Association freed
[  102.650861] [     T92] nvmet_fc: {0:0}: Association deleted
[  102.678473] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  102.682552] [     T96] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[  102.687809] [     T12] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  102.689289] [     T92] nvmet_fc: {0:0}: Association freed
[  102.690369] [     T96] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[  102.826901] [   T2682] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 combination not found
[  102.920700] [     T12] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  102.921627] [     T96] nvmet_fc: {0:0}: Association created
[  102.923350] [     T96] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  102.935300] [     T12] nvme nvme5: NVME-FC{0}: controller connect complete
[  102.936501] [   T2720] nvme nvme5: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  103.107042] [     T96] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  103.108957] [     T12] nvmet_fc: {0:1}: Association created
[  103.110721] [     T86] nvmet: Created discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[  103.113541] [     T96] nvme nvme6: NVME-FC{1}: controller connect complete
[  103.114663] [   T2729] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[  103.119206] [   T2729] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  103.133216] [     T96] nvmet_fc: {0:1}: Association deleted
[  103.137070] [     T96] nvmet_fc: {0:1}: Association freed
[  103.243796] [     T86] nvmet_fc: {0:0}: Association deleted
[  103.264999] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  103.272464] [     T12] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[  103.279772] [     T96] nvme nvme5: NVME-FC{0}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  103.280751] [     T12] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[  103.283595] [     T86] nvmet_fc: {0:0}: Association freed
[  103.453973] [     T12] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  103.457230] [     T96] nvmet_fc: {0:0}: Association created
[  103.458562] [     T96] nvmet: Created discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5.
[  103.463712] [     T12] nvme nvme5: NVME-FC{0}: controller connect complete
[  103.464881] [   T2770] nvme nvme5: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:8b69566c-e209-4da7-9024-477185a658e5
[  103.547221] [     T96] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  103.550924] [     T86] nvmet_fc: {0:1}: Association created
[  103.554381] [     T12] nvmet: Created nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  103.562135] [     T96] nvme nvme6: NVME-FC{1}: controller connect complete
[  103.570448] [   T2803] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  103.902750] [     T92] nvmet_fc: {0:0}: Association deleted
[  103.903537] [     T96] nvmet_fc: {0:1}: Association deleted
[  103.903536] [     T12] nvme nvme5: NVME-FC{0}: io failed due to lldd error 6
[  103.903557] [     T86] nvme nvme5: NVME-FC{0}: transport association event: transport detected io error
[  103.910966] [     T92] nvmet_fc: {0:0}: Association freed
[  103.912399] [     T86] nvme nvme5: NVME-FC{0}: resetting controller
[  103.916056] [     T92] nvmet_fc: {0}: Disconnect LS failed: No Association
[  103.916803] [     T92] nvme nvme5: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  103.919368] [     T12] nvmet_fc: {0}: Create Association LS failed: Association Allocation Failed
[  103.920146] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  103.920151] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  103.927406] [     T90] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  103.928150] [     T90] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  103.939195] [     T96] nvmet_fc: {0:1}: Association freed
[  104.091920] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  104.183536] [     T90] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  104.185528] [     T88] nvmet_fc: {0:0}: Association created
[  104.187126] [     T96] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  104.195376] [     T90] nvme nvme6: NVME-FC{1}: controller connect complete
[  104.196285] [   T2887] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  104.525753] [     T96] nvmet_fc: {0:0}: Association deleted
[  104.539396] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  104.540087] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  104.547478] [     T88] nvme nvme6: NVME-FC{1}: io failed due to lldd error 6
[  104.550628] [     T12] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  104.551325] [     T12] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  104.552247] [     T96] nvmet_fc: {0:0}: Association freed
[  104.738998] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  104.841561] [     T12] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  104.844258] [     T88] nvmet_fc: {0:0}: Association created
[  104.846112] [     T88] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  104.855783] [     T12] nvme nvme6: NVME-FC{1}: controller connect complete
[  104.858161] [   T2976] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  105.164856] [     T91] nvmet_fc: {0:0}: Association deleted
[  105.189487] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  105.190746] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  105.190883] [     T90] nvme nvme6: NVME-FC{1}: io failed due to lldd error 6
[  105.198160] [     T91] nvmet_fc: {0:0}: Association freed
[  105.201397] [     T95] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  105.202091] [     T91] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  105.346499] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  105.435637] [     T91] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  105.438902] [     T95] nvmet_fc: {0:0}: Association created
[  105.441421] [     T89] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  105.452345] [     T91] nvme nvme6: NVME-FC{1}: controller connect complete
[  105.453144] [   T3053] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  105.764874] [     T89] nvmet_fc: {0:0}: Association deleted
[  105.793678] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  105.794871] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  105.802034] [     T95] nvme nvme6: NVME-FC{1}: io failed due to lldd error 6
[  105.805773] [     T51] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  105.806660] [     T95] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  105.807994] [     T89] nvmet_fc: {0:0}: Association freed
[  105.950869] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  106.035842] [     T95] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  106.036739] [     T89] nvmet_fc: {0:0}: Association created
[  106.038921] [     T91] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  106.048621] [     T95] nvme nvme6: NVME-FC{1}: controller connect complete
[  106.049414] [   T3129] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  106.339790] [     T95] nvmet_fc: {0:0}: Association deleted
[  106.361940] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  106.363044] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  106.369906] [     T91] nvme nvme6: NVME-FC{1}: io failed due to lldd error 6
[  106.373747] [     T51] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  106.374577] [     T51] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  106.375562] [     T95] nvmet_fc: {0:0}: Association freed
[  106.516014] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  106.600221] [     T51] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  106.602305] [     T95] nvmet_fc: {0:0}: Association created
[  106.603606] [     T90] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  106.612403] [     T51] nvme nvme6: NVME-FC{1}: controller connect complete
[  106.613470] [   T3205] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  106.949194] [     T51] nvmet_fc: {0:0}: Association deleted
[  106.974937] [     T95] nvme nvme6: NVME-FC{1}: io failed due to lldd error 6
[  106.976166] [     T89] nvme nvme6: NVME-FC{1}: transport association event: transport detected io error
[  106.977288] [     T89] nvme nvme6: NVME-FC{1}: resetting controller
[  106.985135] [     T51] nvmet_fc: {0:0}: Association freed
[  106.986527] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  106.987361] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  106.991855] [     T89] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  106.992631] [     T89] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  107.147907] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  107.229276] [     T89] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  107.231255] [     T51] nvmet_fc: {0:0}: Association created
[  107.233152] [     T51] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  107.242162] [     T89] nvme nvme6: NVME-FC{1}: controller connect complete
[  107.242970] [   T3279] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  107.550840] [     T12] nvmet_fc: {0:0}: Association deleted
[  107.576918] [     T51] nvme nvme6: NVME-FC{1}: io failed due to lldd error 6
[  107.578067] [     T89] nvme nvme6: NVME-FC{1}: transport association event: transport detected io error
[  107.579379] [     T89] nvme nvme6: NVME-FC{1}: resetting controller
[  107.584081] [     T12] nvmet_fc: {0:0}: Association freed
[  107.584671] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  107.585867] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  107.590801] [     T89] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  107.591569] [     T89] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  107.734512] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  107.818416] [     T89] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  107.819289] [     T12] nvmet_fc: {0:0}: Association created
[  107.822347] [     T12] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  107.830516] [     T89] nvme nvme6: NVME-FC{1}: controller connect complete
[  107.831206] [   T3355] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  108.130885] [     T95] nvmet_fc: {0:0}: Association deleted
[  108.160423] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  108.161685] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  108.167893] [     T12] nvme nvme6: NVME-FC{1}: io failed due to lldd error 6
[  108.172819] [     T90] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  108.174083] [     T95] nvmet_fc: {0:0}: Association freed
[  108.175280] [     T90] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  108.318255] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  108.400592] [     T90] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  108.401443] [     T12] nvmet_fc: {0:0}: Association created
[  108.402676] [     T95] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  108.411277] [     T90] nvme nvme6: NVME-FC{1}: controller connect complete
[  108.414369] [   T3431] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  108.714898] [     T12] nvmet_fc: {0:0}: Association deleted
[  108.737944] [     T90] nvme nvme6: NVME-FC{1}: io failed due to lldd error 6
[  108.739194] [     T90] nvme nvme6: NVME-FC{1}: transport association event: transport detected io error
[  108.741831] [     T90] nvme nvme6: NVME-FC{1}: resetting controller
[  108.745941] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  108.746939] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  108.747339] [     T12] nvmet_fc: {0:0}: Association freed
[  108.755779] [     T95] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  108.756603] [     T89] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  108.904081] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  108.987251] [     T89] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  108.988260] [     T95] nvmet_fc: {0:0}: Association created
[  108.989611] [     T12] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  108.998631] [     T89] nvme nvme6: NVME-FC{1}: controller connect complete
[  109.000243] [   T3507] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  109.309893] [     T95] nvmet_fc: {0:0}: Association deleted
[  109.323409] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  109.324065] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  109.330793] [     T90] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  109.331459] [     T90] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  109.338205] [     T95] nvmet_fc: {0:0}: Association freed
[  109.472212] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  109.554387] [     T90] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  109.555300] [     T95] nvmet_fc: {0:0}: Association created
[  109.556875] [     T51] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  109.562453] [     T90] nvme nvme6: NVME-FC{1}: controller connect complete
[  109.564676] [   T3583] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  109.872084] [     T51] nvmet_fc: {0:0}: Association deleted
[  109.896987] [     T91] nvme nvme6: NVME-FC{1}: io failed due to lldd error 6
[  109.898383] [     T90] nvme nvme6: NVME-FC{1}: transport association event: transport detected io error
[  109.899837] [     T90] nvme nvme6: NVME-FC{1}: resetting controller
[  109.902865] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  109.903937] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  109.906963] [     T51] nvmet_fc: {0:0}: Association freed
[  109.913815] [     T91] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  109.914681] [     T90] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  110.062934] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  110.150757] [     T51] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  110.151632] [     T90] nvmet_fc: {0:0}: Association created
[  110.153346] [     T91] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  110.160240] [     T51] nvme nvme6: NVME-FC{1}: controller connect complete
[  110.161495] [   T3659] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  110.467819] [     T90] nvmet_fc: {0:0}: Association deleted
[  110.491554] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  110.492756] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  110.499253] [     T89] nvme nvme6: NVME-FC{1}: io failed due to lldd error 6
[  110.505087] [     T90] nvmet_fc: {0:0}: Association freed
[  110.506892] [     T95] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  110.510730] [     T95] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  110.646198] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  110.729011] [     T95] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  110.729888] [     T90] nvmet_fc: {0:0}: Association created
[  110.731145] [     T51] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  110.740164] [     T95] nvme nvme6: NVME-FC{1}: controller connect complete
[  110.741406] [   T3735] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  111.045817] [     T91] nvmet_fc: {0:0}: Association deleted
[  111.070182] [     T51] nvme nvme6: NVME-FC{1}: io failed due to lldd error 6
[  111.072125] [     T51] nvme nvme6: NVME-FC{1}: transport association event: transport detected io error
[  111.075790] [     T51] nvme nvme6: NVME-FC{1}: resetting controller
[  111.080405] [     T91] nvmet_fc: {0:0}: Association freed
[  111.090265] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  111.090828] [     T89] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  111.091194] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  111.092669] [     T89] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  111.247381] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  111.330018] [     T89] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  111.331209] [     T51] nvmet_fc: {0:0}: Association created
[  111.334652] [     T91] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  111.343278] [     T89] nvme nvme6: NVME-FC{1}: controller connect complete
[  111.345196] [   T3811] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  111.649858] [     T91] nvmet_fc: {0:0}: Association deleted
[  111.674986] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  111.676199] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  111.677735] [     T12] nvme nvme6: NVME-FC{1}: io failed due to lldd error 6
[  111.687378] [     T91] nvmet_fc: {0:0}: Association freed
[  111.689641] [     T95] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  111.692491] [     T95] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  111.837566] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  111.918572] [     T95] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  111.919488] [     T91] nvmet_fc: {0:0}: Association created
[  111.923922] [     T51] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  111.930161] [     T95] nvme nvme6: NVME-FC{1}: controller connect complete
[  111.933204] [   T3887] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  112.241821] [     T90] nvmet_fc: {0:0}: Association deleted
[  112.267970] [     T91] nvme nvme6: NVME-FC{1}: io failed due to lldd error 6
[  112.269521] [     T91] nvme nvme6: NVME-FC{1}: transport association event: transport detected io error
[  112.274335] [     T91] nvme nvme6: NVME-FC{1}: resetting controller
[  112.277440] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  112.278669] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  112.281972] [     T90] nvmet_fc: {0:0}: Association freed
[  112.290635] [     T51] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  112.291985] [     T51] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  112.429197] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  112.514348] [     T51] nvme nvme6: NVME-FC{1}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
[  112.515331] [     T90] nvmet_fc: {0:0}: Association created
[  112.519864] [     T91] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  112.527403] [     T51] nvme nvme6: NVME-FC{1}: controller connect complete
[  112.529939] [   T3963] nvme nvme6: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  112.832850] [     T90] nvmet_fc: {0:0}: Association deleted
[  112.856147] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  112.857229] [   T1008] nvme nvme6: NVME-FC{1}: controller connectivity lost. Awaiting Reconnect
[  112.867907] [     T51] nvme nvme6: NVME-FC{1}: dev_loss_tmo (0) expired while waiting for remoteport connectivity.
[  112.869240] [     T12] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  112.873034] [     T90] nvmet_fc: {0:0}: Association freed
[  113.012644] [   T1008] nvme nvme5: NVME-FC{0}: connectivity re-established. Attempting reconnect
[  113.055830] [   T1008] nvme nvme5: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
[  113.270004] [   T4064] nvme nvme5: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
