Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F5F48BD29;
	Mon,  5 Oct 2026 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209226; cv=fail; b=kvzJ3DHSYIOvCx1CPi26bgH2n64hUSRpFMrCeSOP7+TvMrQfZD/NcDFscrScVV1oO0Nu7P+ubzsCtOdAXzEboCiEKF6qzainTPpz1vKp91vmP7Vh9Qrt6oC8jOhFi8xlWYtITh9gfd8t/Vi9HQL+qKfLbVJOKnqAiRueodzTB0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209226; c=relaxed/simple;
	bh=YD4w+SQVNSBwDv6UuVCRyaSmG8Uavi4iqt1kAB7C98c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NoUvITsuldhaUR7BLFutF7tpPw0/kLN0eR314PZDUSCKx/x6qjdY0CdB1EJarifNIM1PQqJk4eIe6cxX9MbGXugcgCFE/w6L86ft6J8K5thHmTVleygmONdQsrnfRYRLlVh0lzrACqPuJVZi+OtXG4jcvbf3Kh1AQxKfIF6l0EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lhceV5WG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=y1+GQwOL; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lhceV5WG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="y1+GQwOL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1791209224; x=1822745224;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YD4w+SQVNSBwDv6UuVCRyaSmG8Uavi4iqt1kAB7C98c=;
  b=lhceV5WGzQA7gG8doBZpe8DyTVSPmLF+uU69clDxpmhxj3q2bNeEJWIC
   TI3EoouFJMZK4BUPsgyZarWypF1CkGevzN1Du0kUBPQfJWolxJYxueH5R
   XcEnFqmkkEchI2wpE6O9owGr7FuB+tD4xEf4v9j8KS0Q5jV4OpQZfEjoN
   zP5O+7i3YhW0qWpJms2jLx31/5z0kMJdt/XilJ7pUQTsDj5iX4nj0VDXG
   jFGcu85p2bM/5HHyAZ0dh8cF/iuWnpAZ+h+8QwdLGxC2AbhslxVtZX0Na
   JJEt9cu4LO66Wou2F8rjYoLT0C4MAjr5KDbiVoXffAW0ygmPLpY0KReKh
   g==;
X-CSE-ConnectionGUID: eIYWa0IUSQSa+RsjeEpNEg==
X-CSE-MsgGUID: Nfp8UNWaRBuoXKFaJ0IEYA==
X-IronPort-AV: E=Sophos;i="6.27,142,1786982400"; 
   d="scan'208";a="158264032"
Received: from mail-centralusazon11011063.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.63])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2026 22:05:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfzUGXi0bQaaVHqFxWWBMcLFscrY7Xom4Qi3Vyax5tuwYYADfHpaLjMhNv1HvEwc6/OF5C07U4sq0amPfI01VA5IsYZKK+wpRnXOHpYn5W7KRmiZketYo6f7uVYp+vS9uFzzqWRbRDGSaO5CrQCjTBfRWATCZ9f8tMu2ZBmD+fzjF/jWSG7QqFreVTva2cHHFoJBllTWCTfg6UgR3MG4VCaPyzafGvBWO+B4aniU6xABLyueqL2+eenoIXtztfiUGANx+SkedrLJG+nejk9q2sNiHddctpey/ssWOh33T8EtbBL7N85R35XvnsRU0/ayIHWYSJZ001/SK52iRbMCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxLSTcxKDVC15Txzz5RlAe/jJyUM1IF+rmwhTo8MKdo=;
 b=BNsUffhVgDSzwL9a46AEbvkJCubw3GtqKNdD+SoTAOHKjk+Njdw77y8d9CHKCr7NtViTTK92qF3QhqB8WUiRcms+xo34xSqO8lsVKeMaAphEZvKYlVteKUSiXcSRQ3U04aZ1m+1GPx9ouk7PASnUhincAmJmUcIQrXCfQS9adkEBbBa6dz+Wu8VpYL/psn8o6tKK31hNCMRmxmym4gwQxyAb+q/XU8QE51Org5F4FgZGgxrNTQthuBSZjGDlwOq0xU60MsEW5PBVcbEs9h8GpoxjJI+x4bHEw7TLKyeG+fJLoGkR0RDX890TKRtO2ltP/ygErqXXbdWdBViRiqRDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxLSTcxKDVC15Txzz5RlAe/jJyUM1IF+rmwhTo8MKdo=;
 b=y1+GQwOLcu7SVlbkRwB3Yz/mM0rwPKUM4cSWnV4f+kGbJ2ZgpZgd4ul091UWjF4d+9p9nh5tvXcSKL+ybF06hONeaw4gDeSIX5KZvexowwp06QVU6tnh9bi5u6iK5E+k7qkwCjtGHzEDC8vOlqpdY2e5F5N7G0LbLyDgcTqsQPQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS0PPF82559E27D.namprd04.prod.outlook.com
 (2603:10b6:f:fc02::4cd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 5 Oct
 2026 14:05:02 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 14:05:02 +0000
Date: Mon, 5 Oct 2026 16:04:46 +0200
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, cuitao@kylinos.cn, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] loop: defer the queue limits clear to a workqueue
Message-ID: <asOt_idu0XzUackX@shinmob>
References: <20260928093512.3153646-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928093512.3153646-1-cui.tao@linux.dev>
X-ClientProxiedBy: TYCP286CA0270.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS0PPF82559E27D:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eacb43d-4d98-41dd-65fc-08df22e9a611
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|19092799006|376014|366016|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	r770Sc9ICOob0AME7clf7ApzSq8eHHEWv/PyaIESmlLRLaEjtnZADthubpKU+1MLfDl+F/Ppu6Fwz4UKtxPv0mrk0J/ShOp3fgXKFvA1kd7xxz3wXl9hkybTe+vxAOM6MmFiLUvs+AHPeXkiRefhYrpApj8McLGJlVTATDs98IH0r2xxwfnEImSZ7VEjOLXjhblAU21DQiKB6azD9M6U4D8DfLQ81dRXC70n6idhDJpitO88oDFahUwrv17uinRZGxfq5prGM4t9wpH7ElDUs7UHlk7hoW/wPrPWhg8LIDI1qtNKGuYvzSFsaGPdqBlh5+UQZyYNqJM0V+ytb0zDdMcS7vuzcLOkgGlj0kXuiCv4T32kByLDPyNh24wf6T2HBu75X/dWP/cX3JgmpSeiIyZWwhtpgRv+tK27aPiSId7THsBn2OuKQwxqgrFrKtIocdxiOwt5mSDAu20zUsIg+p+Mb8KQsuGxFVUvKmLv+g/Wh/BoERkdxbklHLxea7htYSnMdF0Sg4p6XN/bTkNSFqvu3hCSK+itO8+E4nTEQm6JWYzs61Vz73xx9V7Vgq0xi9MlgrUdx0A7GyAuIqiJW25g/sNDo+ACWJhJ/V0N+jryfss/IlmTgXpdKWU1DYwqFwa5Yh1lf3R+h4BV5NRXRpamYGuS/Nr9yYY2GnrBK8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(376014)(366016)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nNrKzPcG+q4GrnQ3TFbQGTK4x9G7moTcOiVe1EfT/3mnjc0W0rCxh2ILTqTB?=
 =?us-ascii?Q?X73FkqJjhfKQhK6AQ33z1aOEpxBrntHCyuTUytwiv87aw+5mJ8+qeRPLNBO8?=
 =?us-ascii?Q?RsWxDwrrJnXaHsPw5hBtsTbl7VKIr3gwmeW612Y4UY/QIhOvWk8Ub4nzs2Qa?=
 =?us-ascii?Q?72B2N/dNwAWxKdIx26lvKKIHHo3tgcDsaNymOM8rhXiC0Pdi78+LkJJ4ZkmT?=
 =?us-ascii?Q?LGnf3qy4YEP3EJ3NJsAuRNp3vnIQrxth3kIW1uB78IHlUKhxWN6i1Kbt7O+d?=
 =?us-ascii?Q?ZgtKSpWrUu9xNCUIFyqRG51rIlJQKAQ9eyoJ0SPnc9i0wFK/tIBXQxSueQEe?=
 =?us-ascii?Q?ErAOH8DydH033Lg7nBXFVQ0I8OrskZDQU/TyNKqMWyeaUrICDPvx/i+8xEHh?=
 =?us-ascii?Q?IbdD6FP8toX/qnj/sI1TfeFl+QrMGY8M+MKXVrjfcsNRLgMe8aGsUyEnv0Ey?=
 =?us-ascii?Q?W5/2fCHfEblb+JItgdw77zkg7LWN3G/WJrLI7cAkRk/Key7W+R8y89UsTDVu?=
 =?us-ascii?Q?obYulJ0i4bplMyZhXnMJgAIvu1H4Fqj1i5ZUYGn++dvUViqN/YwR3pRfuWVL?=
 =?us-ascii?Q?540xcvBd8ZJNL++iIZsmUTjl80cUirGgkrt/UF3T841Z9GCf8T0yGqKTA8M2?=
 =?us-ascii?Q?9/4Je25LXpuoTNYz78iOpNucOOu/HFVxAYjojddLbSUXGj0m9kxr+PZ75g4r?=
 =?us-ascii?Q?vgCHAMHcTaRFGVJrKYfuWj8kpcvgi8huVNVuM+j7SdV5DoqNTVenzSIHQ6qJ?=
 =?us-ascii?Q?AyDRjmJsgmFX3tXUw++95VviOQ1u2yVSu9j5SAl2UajVqCPxMwRyTVteWn3H?=
 =?us-ascii?Q?7vVWzRHbsN+fn97Rn9R8r4B2KgxJdQG0U6VOAdkEXhXoGU3VZYLSQqDliSq1?=
 =?us-ascii?Q?auNgp/BdfSWtN9P9Jmxnjh9DQ2TfoldHfBLEKJKWpUSAzN+/UeXqfebz7GEy?=
 =?us-ascii?Q?WFkoo0gRkZCtAisshC+b4NfcCLj/ax0Yk7LHOIRuv3PnIIde3pwLP1223bZZ?=
 =?us-ascii?Q?BSjx7a1a8NlqdfQELjbegcsr1AeWrPFJk5mZ0tS0DqESgdF9UkS/2vE1QZQR?=
 =?us-ascii?Q?EXGwJRoQ+AYUwj7v15Xpt7QemhZB9Cbtbv9oXkFAoI3l18HzLo1Ugs45jrSu?=
 =?us-ascii?Q?kcgI6mGT9wrSJiCMUEumm+q6DlKnMfresB2F/ZutYF+BGvwZPG6/wLgP03VW?=
 =?us-ascii?Q?CIEMItFMvZpT6/rEYxJSPCyluk4EA628h/tXgHa5ou0ekb5ycDslq6B8+zPZ?=
 =?us-ascii?Q?KmDq1D7xubW3ij6xNoPwzqlZFw+KgK1mKuZreUWcS4zCtd7b2wmuhyiEFKCW?=
 =?us-ascii?Q?7E6NyN4h8EtKvD0SwTlp7/XMwGKvR+j+UqIMmdhQl6hS6LeP07k0gKED+A+h?=
 =?us-ascii?Q?KdRDSQqZmTTXZS0ymKYkVS5PwjU90a/hhcJlXxYKaxxIgxlEis1eFFYfA1KL?=
 =?us-ascii?Q?bsX0ejES0+5b8qNymkRXKbGKC4DV8eb56DV+69XDO9xB5IibLpMPdYLiP8bY?=
 =?us-ascii?Q?ZVHbJBEFm7S51tGiFsPVVzvTE6/VM3HPaDLFUGhk1C0+ccNa0dbrpfnjAN1F?=
 =?us-ascii?Q?UFWkhMll+jQg+qfwa31P1JNP8qjPiW4Nfi73ZXt9W367KcPE2KFwX3w3T806?=
 =?us-ascii?Q?Z01OiClJFh+ff6G9WVHw1L6zEbkqYWif49hDk/alWRNaPosILs+FuNHBKeM3?=
 =?us-ascii?Q?u+KRqqlHlFxcJcDx+Pu73I8xJrOqA5N4WaLJB9/r6B06R5Iz3Uyk6OslKOM5?=
 =?us-ascii?Q?cwbLTyaLfZ+J1vAP5+A6VW/iiFeeyN4=3D?=
X-Exchange-RoutingPolicyChecked:
	tRrWu3C+teS8eTOG52YHpm3X9Z431P5u/ThRWNTnfylTYP8G0e1YmisiKGXVahVpxMGp4P3aTaj34736EHRCRgwdumB9jxorUD9tVM7IUKjzvEi5TJH2ZIa3RIPxXb+5o4FEgfRiEw+eLxj/0TmWwNnYo+kwpqACFzLpx+n4GvzfMgkCxWhiN0dpf9q/sXLPY+DcRZeSJPnzsvzAmx/VeoabHATGIVLujUCK4/3yUUm/yInSaQQn7YHDqVVaHz2fXietnk10zsa7FzpYpuVKt3YLdif9odY3hHmai5u8XyucWMzNR02Q2JEhnHQ+aoWYEcde+ugXh+6uc2EoB1/++g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7EpxJen34aE65XiWavG9cHW+nII0arxRn+HTQAJa0Ew1xO1IIiblW2Lch77oIUPhsUEKQIyHRLpJE3tvYmjjScyDylwV9rocMT0nSdqLQFgLoYNYKLNSM6OdOEgNsajEa2ZYt+gcXE4rfKDLweD2galWwIdlbEQMO9YubcQPZB1HV6EAzaSAwauF87KG5FDQ8tdph6oV05W3gKIhxycshk+EljSUS94HiZ3BUMBpz8G2FzTRWFq6Nclkij3qO7I3dUBNKGxqTQCD4DTXs8VJP0HpXlHLZuzPZG8IesTH/NpNx+lHQNjLG1Xd+78ec/zZfdU/J3eBFxzlhtqvB61BsWlsVWgjXXaY86IbXHKfQ+jCpTG4nPoSYKtHJJpuQUCnfXE/Sd+XjDGprUbG4/2HqeRGijGgiD4pZVdxMBPuCVdKT2xf0cj76RUXkgZWhE5iBm5C+PmNRi6+TOzjHfZhfZdK8HfAADn6azrudaa4E3MIQLHpEfrol75MgmNHlbIK+YnJ4c9YkqXO6wl6JzXFzNRH84Ho06m8tBq2hqWz8rGtN7vjZfT9rgyzrCCaIMoU88TUxSgAWOjuJ12Yv8ko5PVdnvJethjtshefLNEnLIruBO9HPYLBROpMu5LUJfei
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eacb43d-4d98-41dd-65fc-08df22e9a611
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 14:05:02.2814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wd/g/2QeX+W6W4KJZlZfoyoZYf57elCWXknPeTV869V75dhmUx2oVgglKouGQGmQdaKc9w1rzjVQnATQ70Uwz9FA0lH+h/v9LAlDYzodDow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PPF82559E27D

On Sep 28, 2026 / 17:35, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> loop_clear_limits() calls queue_limits_commit_update() directly from
> the loop workqueue that processes the request.  That does a
> non-atomic struct assignment to q->limits without freezing the queue,
> which races with lockless readers of q->limits on other CPUs - bio
> splitting reads max_hw_sectors, the discard path reads
> max_hw_discard_sectors - and can let them observe torn values.  The
> trigger is a discard or write-zeroes request on a loop device whose
> backing file does not support the corresponding fallocate operation.
> 
> The code already has an XXX comment saying this should move to a
> workqueue.  Do that: schedule a work item on the system workqueue, where
> it is safe to freeze the queue around the limits update.  The pending
> modes live under a new mutex, lo->clear_limits_lock.
> loop_change_fd() and __loop_clr_fd() cancel the work item before
> changing or dropping the backing file, and loop_assign_backing_file()
> resets the modes, so a stale clear cannot hit the new backing file.
> The work item is also cancelled before the device is freed.
> 
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

FYI, blktests CI observed the failure of loop/011 test case with this patch:

  loop/011 (Make sure unsupported backing file fallocate does not fill dmesg with errors) [failed]
      runtime    ...  0.737s
      --- tests/loop/011.out	2026-10-05 09:59:42.755411625 +0000
      +++ /home/runner/blktests/results/nodev/loop/011.out.bad	2026-10-05 10:42:15.607566132 +0000
      @@ -1,3 +1,3 @@
       Running loop/011
      -Found 1 error(s) in dmesg
      +Found 2 error(s) in dmesg
       Test complete
