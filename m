Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0D3CB573
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314316; cv=fail; b=LEUUd2u8+JP7qF+CrsJccLXz7FQ0CPVYRs60XnJhgxb7hDRFnFuvhZMxTbnClkAKoyN7+Q1EnW1RZ5w8gOoNmHlUimyA8UGTp/LcFZstCUqA3fWpeTXzW0JFO4nrnTgAIyHLS/whQPAMDxjVhwGDtq8bBdfcH3oC+ZQpngxDoWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314316; c=relaxed/simple;
	bh=zV1na3a/bM1TlhSw6RL3232VcMjjAQNOzBBX/D2wz1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rj3lssDDf3ecy55qy+DWhII85/FiTMqhMQIkcY1WFm2L0CsyhTyGB8ZEOzqVHuQDzQhRXqn5MLLRzkUDOEFm33xjPVNTlkoChH0BfV0NYkHTPSRZakyukOFy9OcmHRezY+Xd0MMHYHU2I5MzJtTnXQ2VCeIcuTwFkVsclGadcaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=C8eKp1Hm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BVSODAwH; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C8eKp1Hm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BVSODAwH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1790314315; x=1821850315;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zV1na3a/bM1TlhSw6RL3232VcMjjAQNOzBBX/D2wz1w=;
  b=C8eKp1HmG0MT3cI7+84wa3xDWIyFI8q25uYWm8j2eSOrLbeGwgmDPf5z
   zL3+v0+tUPbG42rPrwffNvNj3BRbw/FenZLdQqgha+UKQ+9StrVP6Uiop
   jMC06QTAcMCPI/sGCCZpyYfDSLpLUyP/pnT5h7YaWx7erVkE/d1OdZvNq
   NIUuYNWsuWkVDEr74PmQFvVX+fq+RoNwV/OO+Zq90fx5TLiLyr5ZQhY7y
   y0stWevT7kB73wD3Ps6SybHd477J+AxqKSDN9nP0LwEtSPcym6xi6zgRC
   Dli/J8bVDnMvYoSKdMuSyt8EDxJHMMnKTFLt7yepsAgLQvUdZ3K1Ovysn
   Q==;
X-CSE-ConnectionGUID: HV3UcvndSpSYGBCgnZVldA==
X-CSE-MsgGUID: 28tNEpedSR2c8XVQPnmLcg==
X-IronPort-AV: E=Sophos;i="6.27,121,1786982400"; 
   d="scan'208";a="156525359"
Received: from mail-centralusazon11011011.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.11])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2026 13:31:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3SGCfnPH5W6p7YD67HEO66PELSI8z6bhjIpsbip+tuJST0UW1uaMNwkO1uFV7xZnuRfZ5xff1J+Vl94MLudzCXpeaMDetSgTAqzsFUKxtyRpxg2IgqSKU//sUBHXbNDQetEJd0kZU3xd+6U6qyf9pw2E3pucXckFv1yKrEq3GxXDe7MuwL0maEmC6KkDeztsgAvRqqPECxk5RasnEf5sIswW6YlNmuCXoimaBGkd0PjBd2fO3xYLGUl+pb6YSKehac85G/egfzW4AuiKV21foHVqk0WBCDcl2RJEkhT2T87RVDHZRVQr9G/Pr5voI0nQwjWf4cE+2FoUOMOWV2EYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hpeiz+2PaGrLmRq3pNK9NsHW7SvzQEXGEV4jE6wTsiA=;
 b=yVtxrw0e+0McZsb//2o2o12NoVtATDneY6fsNM0Q8RA3Q07QbSxIOhZgiu9qSGGhIXl0boQhra/8qou7SJs04ckUzGqezas22Jxc1HMN7e1JizXanPMsxvu5ImZcHuXco6Z84rVC7KTp5sDqXYEAEvfMwE8rdLQdxehQ7SFliXk1Mm81bXsq6VpM4YG5Qy+sAEvYLfJN7nLxIf045N9AUfyXXjxsgSih5ewfQt8iGJjGd2USTyl1AUNb+q1vUqgYra2wMctsnwFG5977HyZTvIziFf5wNyPKZkpEe1LFM1unAXUBPcB5FH0VPpZsoHvX59xZbyGmtykr5nYPdSW9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hpeiz+2PaGrLmRq3pNK9NsHW7SvzQEXGEV4jE6wTsiA=;
 b=BVSODAwHd40/YXGGx058qm0OaFRBDFC4g4OHD8CpfVX3yf+v1zMrEHvA6FBB6eRSpdz0CsjrS020nwD+y/92mNwQlE6e4bbhAxpJlX3OCPJ3I9pCRfxw+oYSQzY73C6zuOlUOUT8BUhETmQsxKQXF1uyvzACVp8/j1lzlX6rvAA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA2PR04MB7548.namprd04.prod.outlook.com
 (2603:10b6:806:148::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 05:31:33 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 05:31:32 +0000
Date: Fri, 25 Sep 2026 14:31:27 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: 0wnerD1ed <l7z@0b1t.tech>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests] block/046: skip with the new XFS read-bounce
 implementation
Message-ID: <arYG96raJ0gESSo-@shinmob>
References: <CAKTh27_iPvKWV8_bLMwwhEZAD+XPXimBdpz4D8iuue8mSh2A=g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTh27_iPvKWV8_bLMwwhEZAD+XPXimBdpz4D8iuue8mSh2A=g@mail.gmail.com>
X-ClientProxiedBy: TY4P301CA0080.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA2PR04MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e08b97-3485-45b5-5201-08df1ac6424a
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NvBzkup3akhslx2azdFVQJEFyoXZ6aXzgim6gWJIWwv61tih/brwIt+j3xvIkaVbPSZ5ceg3OQbQd0eWRZ+RgYmyQXbs0CBHKnblnybBRP+B0/k9c3+wvUtDYfZamozXo+v4s4ZbS6yKY8xGOxGARMlLTsdlvHH6viiujvPUGvE8f00KfGz+DN5Xe+rNPhD7ebUKDU8Kf588xiKVmn94iUaGUi2lKywGdzNkVS31pf2xYhXx3ZqvtgWsqhgX3obxZJjGo/5Zt7tDeHP99A4I/juBDtp17NOIIKrv9SDJ5Ys6J2jEeJpfQ6o6mdntMUNozM7Kn9d60LGJiOWYdlFjKfNBRXhpQyz6rtwScpE4qIk1Q/zC9U2HZaaUctOFkNvEMSklkkQ+NMTFNI5RdO88rGb71kvXO90UTStLfIRZHPJztlQUVxAjpR7ohvtVJZmunXJBcDzdpfe2vaSHGBI4S2DlvlDxD+rJPtg/K5v9FjJuHGT7KyKRnUSkhvg4jaE/lhQn6Sipwo1Dd+B+VS5EG25pL/Pjn/pSrNk7Dp9ZZWTE2BtjUAoiv0U6gqa6tHrfFUrpo3Iao8jxZgAaDPV356IooU1kn5uyQ4KDaQCNNWXmVgOeY1i0J+VVZS99eHi/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H3+GBfBrmaST3alduHeauj/t2gXNlMAq+JADIu0ESFNYHAIR6om6Q2YMoU/E?=
 =?us-ascii?Q?0q/JZKi3hCrxs52vd8vPC7e1TjoA4VTOuedPWHvBeN/l4Z9/G5wbkAAtQt2i?=
 =?us-ascii?Q?JxdDT2tFXk0fF6JhPzDFp9EGuajzSRjI7iZHGc1e/ywnq1/BWLDJTwvV+zF0?=
 =?us-ascii?Q?XebOWqZnAwN8VxE/Ev/ey6P9ibZfDVRGix4THrGKAvl4irJc9FK2CCNXp0TD?=
 =?us-ascii?Q?G3c/1pIuEiR5cvtgSAgWZkiqJbO0lfPOFLf768oIfeSsRNmQhGaIc33XtuO5?=
 =?us-ascii?Q?+V6UlrwByxMMl8spEifMohoOGJ34ujgOs/pJZ19q+4L4LmoSMbHT3fvokrDC?=
 =?us-ascii?Q?9mJCxpH6seb66jI5JxfRQ0dV8CBjFPKYZF6SDfObLh7sFB6sTq3P0o8tzmiK?=
 =?us-ascii?Q?aJV59rEeVQtpXyXJDBpy55Pyfmgeh6Hsjr8actgdBzOKrhDNVd3vauOiaZ7y?=
 =?us-ascii?Q?7trPyLQheOjYmdo7Vo+bK1xwBZ1+TMUuBZyZHtilNjqfIle6WmqQoogfaID4?=
 =?us-ascii?Q?IIJ3DK9mI0bRuzcrZrMuQKZgr9py+pmuFsl/WFmklmZp6YFCgcmxlHayyOiw?=
 =?us-ascii?Q?2CGg5vh0sGTWUBscI8BvtvczDxSod71tqqaLd+8xTaPqCp7NqcOGFFll9wU+?=
 =?us-ascii?Q?jvTrDqiVabZyo9lHuLAU5obTUM3L0BrrGPXaUdgwGIrBW+08DNC7Y1OUjSH1?=
 =?us-ascii?Q?O654Fkxc7vbVSE+FsbuNqT3tVjFWZokD7bZ4A+oz3TF2RNwOnL9xxDBBjusX?=
 =?us-ascii?Q?S7+H7ZkCyl8sErZk/0hnA11VbDkjiVan2WSQVD6oIPh0mFajQ4yfYoDP53LV?=
 =?us-ascii?Q?SgxZS69ZRhX1v+4Q/DFYqEwqFebnwE2sxjHxU2D7FyugcLOKkz7gB0FBiunN?=
 =?us-ascii?Q?KArdBhiCNQVb1a3YCOQHQ7pZu1ZaI+ZXozrvXoezFPE3F9/kRxpGdcrwRg9U?=
 =?us-ascii?Q?/1zKLrj+LO53VvrA5q/nS9OyUNrQ2Y5Ir6PbWQhysjlFQyrzbvCvSlAsG4ll?=
 =?us-ascii?Q?tmcIosSzIx8yttbv4HpaLqR/ZsAOSeqb5xoCtkM9I11GqGCd47rnmdJ43/Wk?=
 =?us-ascii?Q?wh22u91Yfpyk1wOaTwhRZIGAFcRWXWcd+06PmkbqGSjCUKzcZd47/Z1NjC2B?=
 =?us-ascii?Q?+eUS6vWEqFncpf0fQNWkQKkzZ2gxwrls7wBYtlgfSUCzwzMbBGx/36GMnp7a?=
 =?us-ascii?Q?ryu19vzbfM8a5WXdG9xsXHAcy92LDkg2Tob+JRwvcAK30UOm+bJMNKSS4tuI?=
 =?us-ascii?Q?FWQinUnTIWgs8ToOrdTun4puVRaUwcNXdM+/K8t6dJiIANXdDBm3K4WKaEVO?=
 =?us-ascii?Q?iygqEzapvZBQQ+jlh3bovP80oOp/+5Jqq0MN21+uNbfcpw4gq66sBkJNSIEz?=
 =?us-ascii?Q?g32+6/tqKo4KF9EunywX7+uugZZVV/3kT9xo3xEipHMezNMLPtJyETDXs6Q1?=
 =?us-ascii?Q?OSSUrvCn726VwObj0VKEHXY5/uHcz8NBGUOhSaGr3BZsaM3ZrmO+j+4PJBEd?=
 =?us-ascii?Q?fvB5cS8X1FAdauwOXGjB2f07kcm/iP9hsOPmqZTn8aGrEhi99qKqt/tpdRyH?=
 =?us-ascii?Q?fAVHGLD0udwI6t3nDVLl8jNsbrMJOz519IxVfZqV6WmKeph5y0KFsGXv4iEz?=
 =?us-ascii?Q?UBEuM5vmFiERiB/A0VcjIC1cKY96lVJcWEVz71Q0KxQI5HoyzFaZJeUotwjn?=
 =?us-ascii?Q?aOwWHmklyfTgp+efqfXmQWo8M75D94Y6wm9cA4kh1HA05XzWWitPl7r6xyRh?=
 =?us-ascii?Q?+u0FG/74pchpm1L+FW7Qc+9gHlumycU=3D?=
X-Exchange-RoutingPolicyChecked:
	JoxwDbGD75A++mCGgv84GN+gLsCaQf38jW7dkMtmiRmyNNEYMJiedU+99QgDRIpvg5iQG805OfI3XZ79NuOIrK1vHfB4Nfp+mCGxs9vhB1L7xegaeRAgLjtqAVuQ0r3SleBHrSMxJtLNhiLWUf24daE5jJ9Y6qyIFJtUwZQYv/Z4vPHe7vasJ2ZXwQOuwsf9qG+VdHZPb/XkYG7Kaa3C6BXG+LGuui5fuTVmCczuP4X3PWq0j0veevbHljD3nnOqbxabYV5EiLtjUh45vhgQImzlClGAuVZCuyF7EGMyoO29izsM5Fu3ABU6NXNfHcrbaMfiEb1JXrhBplmjRwcKaA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D/OAgM/xu5oymg6RhhXY/OHksghHibWOu8fqEehTcVAAAKFyv34PSMw3M4pnMBDErPyglyhDzKez/TlmaX1R0jp/yjNDFCU+/ZH5cfVDVS6QdLN68nfddKtjz3nNC6V+W1g37fV/oGOzZRhs4SO+Dk+l04rFiDvQUmKIRXJImOI/ywDnEjs1kh5v1im0xitMQyGuHIJImaRZ67BzjIxr/pg0kU/TROS1EIFpZaYuIbjkYSGBZSH5umfmpi9JdBXtfXqpjVg19nY5BGhd2a5oS1+jDAEBSfjoXR01m669D6799a1PHxrUeYwSStjLIX9SfXaRHSzvlhliqt5ZRvIcuL1wPY7oybvjaV/YgqN612nG4A/ivRe7+TWch8MeUxmaNUfN5wpAGtgPcmwwHvMTwxX9JZaBSI5hkefW8en87XlwSWp5UJUn45/WV0+bpHbxGphjlFFMSu3YSUB++P4KuYtpQeRRERLTa33CPWjGT5+ceRKKQ92DYaKA0q0+daRP9pCJXZHmEFFK82QqX3+oTeJL3sMW6QUUGXFxzEGEuYqD9Y6i4wugb0tYUCoR6jv0MYw4S2n0gzve8+1A/WGYb6cvD9MZajsqVBxnze1SmnJkYCeuSW3Tk38kpCx57jXV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e08b97-3485-45b5-5201-08df1ac6424a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 05:31:32.9381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQMDti6Melyxaa88FBEg04jFC8khZzBWs8C8vQddVyFB5CwaVi2O2xGtXRz3mI1+Y3BNtK4+BF8eom+1gW3QI8bAMsZdjfoMWPkFhEOOxgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7548

On Sep 21, 2026 / 16:58, 0wnerD1ed wrote:
> block/046 uses a deliberately misaligned one-byte iovec to exercise the
> special bvec layout in bio_iov_iter_bounce_read().
> 
> The new XFS lazy read-bounce implementation no longer sets
> IOMAP_DIO_BOUNCE before extracting the user pages.  The ordinary path now
> rejects that iovec with EINVAL, and a later patch removes the legacy helper
> entirely.
> 
> Detect the per-mount csum/read_bounce interface and mark the test not run
> after cleaning up the XFS mount and null_blk device.  This retains the
> regression coverage on older kernels without treating the expected EINVAL
> as a successful result.
> 
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Link: https://lore.kernel.org/r/arDN1UdZIydNLUjz@shinmob
> Link: https://lore.kernel.org/r/20260921082240.GA19833@lst.de
> Signed-off-by: 0wnerD1ed <l7z@0b1t.tech>

I applied this patch. Thank you for the swift fix!
