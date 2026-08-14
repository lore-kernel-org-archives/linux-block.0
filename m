Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B06463B76
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706944; cv=fail; b=pIcVm1JHewb934qVBCcA0EJIus3PBdcrIbwFIiay1bibhTx6rUaiAvn7r0Ma0BE9b7+mVxIePHg++JFkRGK69uvY89HVOYOly2nhksJEszF3E965XCIimmO0oSmrJv+iD8MGU3bOZsCC/YRGikiPDnC5RjVEn1CeavPodsVETjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706944; c=relaxed/simple;
	bh=4Mk29V4Dm9jl/8C6Us4U0hfirtIAy2YFs2k2aHAQUHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RFQklZLLwgba9qoRbT7SUKZ5LoHokYk7UVR4ie0YXqh2t1JnNc6t+ZGEM8GO7uuCK2++msj134VUgREvM3o2/bUVDPymi5qCjAGfVlBUIpmhjd+7gxCHAf2vJZ35jt2nzqy9UHo8hCl5bdcdpC+JL27VRdpGKeSgdOqQ7sXT9Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QBGF9QuL; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NPkRtBNC; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QBGF9QuL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NPkRtBNC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786706940; x=1818242940;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4Mk29V4Dm9jl/8C6Us4U0hfirtIAy2YFs2k2aHAQUHM=;
  b=QBGF9QuL1zDmxdpXnV8et9QW+97I+kmbFQwtrdujFpAOCdLvAka7gWJG
   DeHrVtDM0MmZSyuJirauXpIwBcsTZED8D+UJ4QPS8b/jWwPhcvR2LygZ1
   bQoRYYDAacU2aTMHB0ItDuehkZ6PJrCCXq5RkOLmqyJuM1TWEgpgZEmGQ
   f6PSDslXSU3EURTw8KOi1G9d/t1soNqXmZyTTi3RLi/HBm8k9YTRT0Vyp
   659j4CtDPLus8F4dCk161qRO2/dzWDHwypd439sZ6m/nSseR79fhv2KSh
   EXPSzZnVK8Orocz9QQq6bDZo2pmLtrPE5kpxnvCnicdB5wYcpwdaA2a5j
   w==;
X-CSE-ConnectionGUID: RJ627bv1QgqJORIhBFLiPg==
X-CSE-MsgGUID: HCKCIX27T1i5qjzakGHCdQ==
X-IronPort-AV: E=Sophos;i="6.25,222,1779120000"; 
   d="scan'208";a="152201959"
Received: from mail-westus3azon11011032.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.32])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2026 19:28:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qi3oDWS7dWxeKB34g1bFu+ku3SKpCVPaefxWXymiDrwG5K0+Gq7fDfj8Tzoc0+rgqj1UvXvVoAAP0OkEMDgMG+2fBf47/+mW2gkmJ2NOBgv/DzwhFNzLJJ/0mNQSz06r0mRaMVWEFokkoV+ZnxmR7AePmrOW0FxA7rse0U+oTDUDoGZS5summCOEf6zCLMlx1HajAH5Rbu8qnPWcvD7g0HdaFTu0oCu19xhTZtNMkIMd2666ivAUDFPpsvyJ5UB2hluBTp9D1sKzMRSPb16gF+WTGDJQ6W9Y9ShO6yOj8eOmni0/tJW46IgV393MntqQnWQ5m3/uaK9tvHxn/SdVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNTbiqyC6JZ6rEpuNbZHDdilOzHSHHBq8rCp3/aKzXQ=;
 b=fakCCizg+ij9CCrYV3zh+Enh7Rc+gR3Ym3NThW78qrk+5vp8rzGNAlvLsqRn6PU5qXNMn+sUjjDmcN/2Ji1OOJoMLt0zCYwjwmilBNTAL8+kuIdhHC+05X6rtzwh5j8haBcRVGvH4DKG/HX0ybZ/h4Q16R/+QjmoFiSCrJygsY2lk8n1l3n9owMRxgTDo3nWFuKHxOakSFXfUGXswpwTSVh8cZvyEcOC35MMVCy7SAPrhH1ITZf5MQPA47ZUOf2dPS+ZtobuGvMsc4P2Ad4Q8uD2BaY+JmlmimVHyog/mXnfjEusfo75oNZuv9iTxF6w94AACAasaKQHLRrFXg4DQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNTbiqyC6JZ6rEpuNbZHDdilOzHSHHBq8rCp3/aKzXQ=;
 b=NPkRtBNCGffv/LMSHPdmikxy/oKwNEcsIv+kvI78mfluU/5cQpSw+c+1TYZVq1Wp/lEWR3HYifajbLRtKoWNHSBDj/aQrvF9IpZa60jWZAkMHx4hg4V/0syDeCgovfqKlxwswEthwfJiD9i2m3G+ATraI0qF++hG/fuUzxO9Tp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH0PR04MB8296.namprd04.prod.outlook.com
 (2603:10b6:510:10b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 11:28:57 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 11:28:57 +0000
Date: Fri, 14 Aug 2026 20:28:52 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH blktests 1/2] nvme: Add _setup_nvmet_port_marginal
Message-ID: <an77IhZTP02mcn5E@shinmob>
References: <20260812174503.3705830-1-jtaubepe@redhat.com>
 <20260812174503.3705830-2-jtaubepe@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812174503.3705830-2-jtaubepe@redhat.com>
X-ClientProxiedBy: TY6P301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::11) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH0PR04MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4d38c5-b581-486d-232b-08def9f73af0
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AtQnbGtHAbrqdBls1twyS5HVyXKwDU6m0UJ1EYCJchM7M/qL1J1RVEQQ3qqePuFYfXjtOfdDFU+NtR2ThOF7CNHKfmEOPlr5IjaGOGJL09CZf6kDZiDKhRftm8CUX6tRFkdg+1eOihP+ivKQ6fPeY/o+fx3JL2wOnJQoNT2JXBBzHj77NWD/mZ1oYonx9tF4y8adlw3L1rpxmscvJ838uPYrYUG1LQUaVvP+3mnFPFF2HDt6h/9Va/kfLowc8DtVdZGcJUCWhz+9rvkvIgJyatqCkNj7TXA/5HF2SUjhm74AZb8+L/UDumm0WasXqJGGCljS/wjAZhGFUsP62PuTlaQukaRwV9f9jLIqvpQ6y0+IzpYHZ69hzuvScNsEhJXfGJjObE9ZP5ooRAZ1HG6XWAHNYXevuV5uomDkceAGiVcijI1j42k97x+KNmhXylLjIhk/NKDM38IgmGNZiV9ZeDwJx/YXqlsUQ7Wqrhwo/fLBjtNatALGMXt6Gok+L6aB/uVMxa+2qiWlnC1q5vu1EOCwTpNFOAJPh1CEQiLYpw2MF1aLWIhAz0X1lKVAmYvnlVOkVQQS8IpUfQxoAxvGrYkH92YBgn0m4Zrw/HuQCNukYDDT369jO0LDWlm/UcWNZV6cF9jmAGnvmcBAjmCRY76xIiqeStPEARI47NQZQF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?St6mTS6A9CSUnD8rqevfp0GdGnGOaH++YwvxerqXXDv6K5RE3mK7xZXEcZ9J?=
 =?us-ascii?Q?6TIy7NiUGfQJL1OV5Q3xbBIgzj+XwHBmFkzOblrFNLLkvLgzG+OLEG5SUoDG?=
 =?us-ascii?Q?D/H2UpWIzodTpw5R9fQX+SLOmgLqbpkRPWqwrRu0u02G+PU8W3sgWrKPOhc5?=
 =?us-ascii?Q?QZ3TxDqpq8UTPnBkAHEQReAZYQNGyNNUA4vmtBRtx/slFNSzwvCN0RtBBKLr?=
 =?us-ascii?Q?Z691IPMmhzbhzmmKZnY3wISlvtGKxN7l60PCyOXhMrmov9Zmpq5KZPHeqNm/?=
 =?us-ascii?Q?NC2tpI0CpdcrvSEURRt0jv+fOPxM9qQ9nAGgGoi2wuWCuiZya+VbqeK05HwW?=
 =?us-ascii?Q?aoKqYTOOjPgcKNIBiJ7ZEVfO3pxMjNKptRqR0Ea6I4Fd4Jd822kB1i8Nm6d3?=
 =?us-ascii?Q?7YynuOA9DTwCqZGUVk00BHVJG9Z7IBKOf3WjvbyP7jIx/gc3nh9BO5SNKxgu?=
 =?us-ascii?Q?sHLgaYvNWyCOHDLlZyDKuKUFvxE2Zc9iXgFS1AsaqihXQbWvTswYGfsx/SlA?=
 =?us-ascii?Q?necHHOYWTCdLIncJ2kBzujFMSLN9mfjQIpFR/OpVHjXYIyWunnzZLGSI3YgK?=
 =?us-ascii?Q?XGXIJTAuS9Beja4c1grWXPtK772TYJ6o1Bhqq92JqCmQ7/s/HyavvtF3hplO?=
 =?us-ascii?Q?oP7edfJswjYE0fEBSVZkbaN3hlmOabD3t6uTo36342ifV8ztRMt5MVurMTY2?=
 =?us-ascii?Q?2LD5l0VFzycSEk1GpqKWQsG04nnJM2m9obw6mxAvG6t9Wcl3ZiqGhvLw+pAM?=
 =?us-ascii?Q?0ZXcfzVSjWIpoBmRwYxDkpzgtsFgM7hX/xDB15TiDUOAVeqHbVmErHkGQ/p5?=
 =?us-ascii?Q?i/X2gH76dcKW+Ud6TLT3tt1FViPNggiw8RLG3HrZw1HkibsmLPAlaxjry+Be?=
 =?us-ascii?Q?mtop0YAm4ihZGtL6h6ZKhqnVjSya+8du3UqzDuw7rOvhl7vtmEM5nXoEsLCx?=
 =?us-ascii?Q?uvboeZp9exfadAeYOCDKyThzVlFbXPXS7VswywLVXOiuQdXtQGHfpOsz8eGu?=
 =?us-ascii?Q?1WaK06sjvlXoo8Y5T64ous5zivutyD8VIOnILkC9I328okfoyZQhz9u2tElA?=
 =?us-ascii?Q?17FXq6cq2iTsWCjO2Vgjt8Uzk64OVkknokXOekG8Phccid0LuftDPMJeWXfv?=
 =?us-ascii?Q?CzhW+HZb7HkDwLZ5JrX0QZYt3UKAjC92sSbmc1t9DCabPjW2g2eFYtZzsWL1?=
 =?us-ascii?Q?UxMUEOSRyZSBy+bpuHo/ZMbT5mjeTdQK+0VOdaxe4gNBcFNH9g+usDS6OQ+q?=
 =?us-ascii?Q?WoGwkYGHS4xgJElPEHufsZrL0lJ4RlYBiDcPzaOR4mV4BsmoapHGfwCxVxGX?=
 =?us-ascii?Q?fOEFAGsWCssYA4Bj2aF+tXMtFcH++uTCruoYtzmF2nPQy2cxYSTCwI3T/8of?=
 =?us-ascii?Q?8G/s6O0Kv1yqM4KwIF0+jkZr87YcGY/12Q0jeMiX/Bf+6LXSw+FGl4WQynro?=
 =?us-ascii?Q?wPk53QkHjAhSSPamRrb0LR+4JOHF8maxvSX3KQAQG/VzfLlYYM2eXgtRg/O/?=
 =?us-ascii?Q?6ZAPbbmXbwNZP3d0yhIXbvUP4BtlRj6tQa7ZytUb5Eb77ZNVs13CBXM2Hqgj?=
 =?us-ascii?Q?9F5oWZQIdn9+VK+LEXg8qSovYmuGAvGAH8p6wMuS1H0sh0aadLtDx+T4iqGu?=
 =?us-ascii?Q?PAKU+c2lu5FYRITPNAuPn6WMJCqBxEMIjsRnoq19rtQCP8cWuQdH8FKHXQNA?=
 =?us-ascii?Q?PygSQxWCHs6m8QjVEvB5MFzmyqiKIsJqdIw3OEDICuJS44jEh5jWW1TXhBF3?=
 =?us-ascii?Q?h4s7DQmPMGgzJIa828fyPJOmzazsMH8=3D?=
X-Exchange-RoutingPolicyChecked:
	n0AvTDj0OLWnqtuIOA2xtWKK0/kVM0NkyVsDzK3wyH8eivsQhIOd0tzdkjl6RANuWKn5s2zt6MpDcdI5UdIwWT5rKkaHE62vb3GAyh7J0ho7282sQTX6quLS09rzQMcbjuIb+F3CQcolXlFwKkXJu+N3LonXgFICF5g1glhikJHyZTToeuMI6sF5rxeZHWo198kN5gK/sx9LXuEuauap0zPOeHc+tvPPZdAkBBfZ+/eVy80r0W6iKLk6PIyEzyBIx5+/AniTWPkjHZmjkTT2Kon0wSYa7BCwpHBcMpjEctqWYjcwI9R/ZAKBQKZC9DDBVZzf85q67AywxGfz3IpP9Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ox6Ux+uZQQx36GYz6jDwWwmvMPIu0XIAhmA+uIN14loKh+6AxeRpvdHqx8a5vm5B9PqVfwQL4JDljft2KPD8J7sbEbAF9k9FIZ+m19Lm0xSB7w8zsH4XaOW5/lRHyqyXYHe4RojuVRcJfRdyBPo32SBeimb96zyV/PFVF247VnmMAQjDU4c3fonM23ety5QFDwbwFjQj+jPGN8VCMCXMDBeWhd8L70aSmM9LxFbWpgsXoE3BLvPGFLSUF6j0jeGMSM62U1mSa230f1CrS49YhWmvJgtdp118sIMxFzJyyUStj7Io2VJVnA3BJLU/4x4TN+V/19ElqtsX4EWID2ZIZsoRlPHAPUPAeHz/JcQhEU0K+k11q3Jvq8sT9GJ104YsyXWVlJiZcpuKkNLMey9Py9qVJcOiOaAIvrDQqIKiAGeL97jok9Hk4zfHU9xMgbIgp3zwGVXduBP32cv2EKMaKvu17YkBYJE1H1bZ9cdJaRTVlXk+P+b/pt/0grAOaBslbFTF8aRqRJewyf+DkVOKbj22nDcEXz2zRBhOltkNgLc3gIB1+UfAEiVGePhJRFdydl8Hd3LxcM85Y6eMx8HPZHrvyRDNSHjUNYSFRyYelDVY3Sg2fkJ3nYkQOrjQXmT5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4d38c5-b581-486d-232b-08def9f73af0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:28:57.5045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4FLEh6WA1ufiOVYxQnKwILXjuLeBQHvOO1YFsEjNWNKrHrPNmYU4vuHlu5ihS7ByqzeGR9b6oSdEQzjAb9/2r/2mJb/Au6VNPOEzVOf6L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8296

On Aug 12, 2026 / 13:45, Jesse Taube wrote:
> Adds functionality to set up a NVME port in marginal state.
> This is useful for testing the behavior of the NVME driver when a port
> is in a marginal state.
> 
> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> ---
>  common/nvme | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/common/nvme b/common/nvme
> index f399937..d389e18 100644
> --- a/common/nvme
> +++ b/common/nvme
> @@ -153,6 +153,15 @@ _nvme_fcloop_add_tport() {
>  	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_target_port
>  }
>  
> +_nvme_fcloop_set_rport_marginal() {
> +	local wwnn="$1"
> +	local wwpn="$2"
> +	local marginal="$3"
> +	local loopctl=/sys/class/fcloop/ctl
> +
> +	echo "wwnn=${wwnn},wwpn=${wwpn},marginal=${marginal}" > ${loopctl}/set_marginal_rport

Nit: Most of blktests filess keep each line within 80 characters.
     Folding the line above into two lines is a bit better for small
     terminals.

	echo "wwnn=${wwnn},wwpn=${wwpn},marginal=${marginal}" \
		> ${loopctl}/set_marginal_rport


> +}
> +
>  _nvme_fcloop_del_rport() {
>  	local local_wwnn="$1"
>  	local local_wwpn="$2"
> @@ -763,6 +772,27 @@ _create_nvmet_port() {
>  	echo "${port}"
>  }
>  
> +_setup_nvmet_port_marginal() {
> +	local -i port="$1"
> +	local state="${2}"
> +
> +	if [[ ! "${nvme_trtype}" == "fc" ]]; then

Nit: it can be a bit shorter:

	if [[ "${nvme_trtype}" != "fc" ]]; then
