Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4299B472061
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342481; cv=fail; b=dKwKV5VkOr7gSgnVsiaMao7hF4GbkrDsqDnfuqf/gCgRxDWEcvtwlQr8gCJnBZgCi7S+f0z7cAV+JteDPNVSUw8H1hdgak5Cz2txUGlZ1FFVrfFy+Qcd2t3oRmqqL9+G0Ys+MBlNOesOqyUEzo+3sTmv+nkw+ojmnTpfVfgdlDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342481; c=relaxed/simple;
	bh=o4KwTA+/Tgj7uC1MTuB5Rcmpga7BUIImUt0NSfXuSoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KfWZ5UiKPyoawOB8tRHZFI0ZXHwZCLkNWpfQ65KYlU0b33tD4gXmGBz+F/vMZIfCjST5a10xeFsAdlgdSBzVoZp56W8JHRJvy1S83RYiGRDnRj3RTTxxy0e8cYAQxlGBxx0e0boAQyYi3Lc3iYC3EctmSzFBk1RqvcJJ1IwMYao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IvlA2jvu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IDy8pBj7; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IvlA2jvu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IDy8pBj7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1790342479; x=1821878479;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o4KwTA+/Tgj7uC1MTuB5Rcmpga7BUIImUt0NSfXuSoI=;
  b=IvlA2jvuoDmQJjcWxfIXg8+p0a7U/OEEMjFDsRh4dSt6egqtjmMSA2yt
   IR/CjSnKgjueKITN3PsYfqrmZkXKVL1Hzf6ATW3WBo6UjSZtOnlFt/x/U
   mnxURgNj9DKVLB0SeRrvAMrartP0c5pcO9TCEk1QZYo5HXvLM1MY0Bb6a
   KNIqZ/boL9vCqndmft9EaAJ2tyLroT3z+Paormuh7f2u02yxLtua/D5rF
   X82x+B5fCAyI3EoSBWrANvmnu4knQqTWf8GEPaCcFIQ9M51GADEiKtuuo
   oKwgYEJ8CcQTs/aVheZmZGxWG/2ziYdSAfn/k/b/WARbxwyXRnwdDR7Yw
   Q==;
X-CSE-ConnectionGUID: Mxv56lnUQQWn2/MqJ2lW0w==
X-CSE-MsgGUID: RDgUUeRXScaam7EYcsb9nQ==
X-IronPort-AV: E=Sophos;i="6.27,122,1786982400"; 
   d="scan'208";a="154953580"
Received: from mail-centralusazon11011016.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.16])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2026 21:21:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QP8ApBH8ofO+8s7rQexPMS5LqTSLaM/IV00au+P6iHbbQAeVEhe8xvfFWlv7kfNXuOsWQP27+6hYKUrnfdhWMMwP+9x8F/5JDajONqRtOlKpMq0Ve60D2ZOw3tfEwJGs5FpuCJDudL5kVDi3rDClgGS/mrV+272aNbXCGUIiGkFmzC+CQnoVNSiMpx5svTJJBvZ0FBIJzQibDcZ1mL2TAVyraE5+K7h7iJxCxUeyNo7sSbHtXOTayyKKfzNZre59xTuLWpDhMxOofpC2sYLG4MP/N6rAOTnAt4szOLsrpFttoanu9tEIN5gaoIw9jrLsCuE3Ofnx2mElawd+HBlTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQEINZLauzk9sV3pA/PDuf6I902NqMLGzbC8bHvbG0g=;
 b=gajnt+BYHb9RvWXPgmqju6WzzXKZqhC10oxivlizybtLUQzTl2+PZG4rPmhjog95ic3b4huSzk4du5rHEWywf/stUD29Z5UHuFoyMN4mykoEuG6ETceXK9sxBzl9ZN9TZEgKMYyEZVx4SHHBuX+2T4H6GSZcoaCQ5gmyXxV9MDCrf9cZ37PZPyRBcDQCHDaO+uXoZ+GYliR7tTfGVQ+cVo/2bXzBQZr8qk3PE75pOONhSlUJXSdewkc5DCfx6t+qTm9Upzbmu30bCTr/axf8bOmQekH1woXCrIzTAt7RzYFTNNe1q4OAHMvuqMx/VX+yqeLisIkaA0nXIN60LJgwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQEINZLauzk9sV3pA/PDuf6I902NqMLGzbC8bHvbG0g=;
 b=IDy8pBj7hMjhiSFUGPfXp08KuPj5sae+IMmEyy8sXjX0WYuQM9A5OTZ4U3tvfWvoW2I5BCkYGE7YmooPXoUE7eJUQM9yHbqNell1YcKg/3VDdkM9dfL/1bmv4uqZ37zJJ/I8Vb18/pqqaz3IF/4rqY1CWOwkovl/1JJYwcHAJd8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA0PR04MB7260.namprd04.prod.outlook.com
 (2603:10b6:806:e0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:16:37 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:16:37 +0000
Date: Fri, 25 Sep 2026 22:16:29 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/049: test polled dio with user PI metadata
Message-ID: <arZyUmncVJSolXLg@shinmob>
References: <20260924025526.298050-1-yangxiuwei@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924025526.298050-1-yangxiuwei@kylinos.cn>
X-ClientProxiedBy: TYCP286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::10) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA0PR04MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd08357-3ef6-41b3-d979-08df1b073a99
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 b/bhy6t/UzRh8Bw0SV76RGNLQ9HYXRNG9S14D7E6v4FdKvAhYIwYMG1+jFjKayLNRSIcqT31bCcuWE6950Dxss+EeV8GxPbbmWs8MtOV1Chn5sLcdEsriJj/uObfsci9XHtiUfcIv/spD6E0C4U9TtkSaEHcFTnFfobFDNET+nl9ndD1CRtFof72t+iNPw7zYoBTrwtAHzw+fll+BVbtDkXnhqyxKZt/1SinuJCsZlZVX7MaXw8B3v0JWFusl97rw7j2ZiHQW9X1E8LWhdKCYxyx/XkK/Xzo8e3gqvWLG0AckeXApNmwUDV43zvijD9PlqxQuxX8W44zuoD84ug7PL+Vp6r7Mhjv5WIRQEX/t4aiPBx8Ex1WjP+PjZh/1dwXb5GNZIT4wlzfFZ9BPSTc6DHPEwLdGX/2bDb90IMfK28oZiingi4ZabXAHrt+XeK1JnAVYVCQLjiY+mK7O+Fj3lVVeDC9nc3DPS7Tpe/IllHAQ7VaFwr3G2R5Nhi5LvUTIa9UQTsuN29GD45qEoAw0hyRlKXFyiRrSKqCs9FQAcJC2+spp4QyRTZdZvsj9RE1O0OfPJbx2zB0C5TLuY5uVzgA4odrKjZAiHMrIkC0TXBdujiZs6b0IdxKWFqzeOzi
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?S1jKS8okp6qeiT7qk6nq7YDLQKsOSVb5bHkL+KanJgsIUdn6bto0Zj51DeTl?=
 =?us-ascii?Q?NzMt5xppEeHEZerMuVF3jeESCxLTs+/+QYU20uiLbxptoM0eyvd/wzAC9cTV?=
 =?us-ascii?Q?qYmNrxhDTQFY6++s24yuG0+pk7W1wu9SWpL4VC42NVCfgF8nC+p59sVgNBGL?=
 =?us-ascii?Q?eHFJGXwyvMsuMzZFX6SF8EZctJ85eDRZExvgqLrOM1hGDwbSdogsFSQInUCM?=
 =?us-ascii?Q?R+13aLWs1J5m98ABh8Zc4ZS6GyDXWgg1JklyB5fLTjEzRqbpSYQibQt95cjx?=
 =?us-ascii?Q?0qc0zyClNwNY280Bx+NHGQGm5zjbq4MMnl/vnIRSYIwKYjvX3pguct8q5UEy?=
 =?us-ascii?Q?nx1f/XeDyTpaP8bYzFrHqBGeL1JG+cmcP62Hq8FALis3wgPXVm23u3ILnsJX?=
 =?us-ascii?Q?qisQC10TkrCoeCtUvygqlC41IWZ/+GblkouPNh+SnWKIDk0EsuKb/FSNCZWE?=
 =?us-ascii?Q?jTgSml9Wty2vaWNN7Lt4u38Pa6Rp94k3TrEcNB4l19paDJIjj7bwzfXDNqZS?=
 =?us-ascii?Q?hv8Kx/R9rj8vZFvFWtLUkZeYayFk6QPJxZsCRsb9qrHRqTp8Az8jQmwjgU++?=
 =?us-ascii?Q?85TAYOdsgRgzojSY3e+FhiJBy8oTTj1crwumSNR8yqdb8bVP7iuJV0UnQaXv?=
 =?us-ascii?Q?lw+z2awGtEtvbuvYNl0fBBmqx15wt8hIiG8Qg9ZCG4nx0CkJoOdXjhlVyR+u?=
 =?us-ascii?Q?eitOEMCFyWC6n/7uIr6/W9dvm/gN2TYuy6og0YUqU8wNB+Q7RZpWHkAGjEkV?=
 =?us-ascii?Q?WNnZl8b8ZMeb4cAT3j27HbzrC5J/YfGzXd5uiv0zop7n/myIPuyJ2R7dBYnH?=
 =?us-ascii?Q?2t4w6Uc3NWkrxsQVeR95mE2YLrRHXiZEbduGhmMuk4Sq5L9rk2zmPNBLSTkz?=
 =?us-ascii?Q?GJyaOjR46QG0ylTyIGbfQ4fy3dior6ly1hnRpsqB4H0zM8P+YA9dd1o/pKJp?=
 =?us-ascii?Q?CzKh1lOBCX75iJjNoIa1Wfm+jEPkviJ0TPt/00UOu2Ln0KXy8lkREWHRNog3?=
 =?us-ascii?Q?QqzfMQ5JysizPbaST+UMLqaWuVzl0phXjtPR/BQNUQek3hfjngIcdjNczrID?=
 =?us-ascii?Q?IHT/KijKtMvRq5+dOPMFTAHPH82dsPB/r608q2X+Zv1AwmH0ab16oa3hiSu8?=
 =?us-ascii?Q?K3MY0oWrIPQFtjIDLk9ldNiAGoTVjCqROkSJ90I/RdUSvqje1LQGIJ75UWYp?=
 =?us-ascii?Q?eOSe36Spxc3Q/a0af9jGsVVjglUfLoUKsIZ6cprMeq28PU+JihKyFFMjNxMd?=
 =?us-ascii?Q?SdbX92ezvU51ntCQIX6bK699JEEfmS7aCSECWkbRM5T7rWpETU9kAS0PGkJu?=
 =?us-ascii?Q?5DwWz25dkWOmqlGcXG+Xlkr1nuCDJ923hPipWHrJzZZ/wmLxNWYg5+Es0dnL?=
 =?us-ascii?Q?zy0/r91LiMQh1pA5Z2nircv4OZnGd/rAZ+L6NyViFwldV2MHxCvgDuVOL/yB?=
 =?us-ascii?Q?lcmkzCEq0K6oKndIskT1WnHEHwOdb3Zz0aMtBM/d+fTqoaaMuLM8FkfXw4wS?=
 =?us-ascii?Q?ObHbyf9yXpcL1yQ/NGu3MR3ysXCbfKNKQZw1e+b27xRZKE/l9lkyEbs19kZZ?=
 =?us-ascii?Q?Aaestu4Pl9r0GltdK05bDjV1NfDJl2Wr7Irp7/wdsOWF1va5/NgzTdlmATE3?=
 =?us-ascii?Q?zGHXH8MbaYLjBs9L+oCcBXn5SZBO8TrGQJaBeRPt/O8+q9HalbenufE9uqi3?=
 =?us-ascii?Q?5zoSCVJpRChwVQV/rxbQRIoRbvuxYVAdcmXBLevrh5K4tJsCxMHz0U9eCVTa?=
 =?us-ascii?Q?a81ogcLiaCjem8+wIO/ZKPUW6DQRn1Y=3D?=
X-Exchange-RoutingPolicyChecked:
 P5b40HDoJCSW7NeeLBNtkmKydZGmt1cp2x05X1LNZ65vQalx1AKGkjAdxL5M+VlTnDfpbYxg5YfsCehZSPnsSrI6Qdp4dhShZCAUimqrzLLKxOwSuGrRLF8qc0ThkijM/oD+HDuX9JwvhfunIdA3O5zAWhLZeU+eAZMQJ7HbXXjupmeRcuMMJ3AHrpU51Lg4/21JR4Tj//No8GV/hYPTCfnlTzc2Yrq73k/A3Qsly1TWwkpzQxXi35vgy5iXmPiJXjKbGLu/eyZSyoQum3FyCjiGZrxy2NHnymcb65qqkB/iDWfhIcAJyO6g0KyHYvMlvbNV+osJDXLCboKJKHiJNw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 5Zaxf91ePjIwzQILzGdTxxj6fdncCgYE51+C01gW2SRxCn0rGXN/rvlzVj8NWL2LBf+I2JwHytqn+NfTSjVJNS3tNfH7gHqt19f6yT8yJx24HvG3KQwNxwXO/c22z3a94g340QZNru6Z5nLFIaArS5TnmWVRIi/7KkTpotSp/lvspyFoaxJU7H9dVaq90IQxZ5CFvGVz97zGwgcH62ydlY3e1+fw9SmxLSA8FdfHQrMHW1qlDPnhLr2Q0/0J0HJYWLUKj0w79FR2Y0xmdAvy6TvEOQ6watJlw257BILQjS5vVl4hDZAuulFNookj26yDPuVx+7JCRbVBWG0kWLbfbiLo3FbmrPNVppHOTlYsAI/5dcc+snTacf91dGrCysNxzK+l+JCald62NNIT9YHI81WqREZzs6qvsdVZ4jQrEyk/LRSJNt5ufVsxnr1dZBq2PGhZF4NO5OwgGpXfA3uSo3vnOObqYBuXxtu4jz9vnZRMdkrVIZSWbnqP7BQd0KYbTRIBtj9drIzRWKvUPXQTWC782DunyLOj5AuwET6hM5dShIcnWrLzVvx1ppybe8tMJXEHEVh9xsLBl30oyDtPtuHVs6KpyqLUT8LYlRSdfMVeTDGtHElSsqXB6xKCfVA7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd08357-3ef6-41b3-d979-08df1b073a99
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:16:37.2764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOYGKEyhkBFx9C41HYZsUuxnJmngfF2J3o8AiORf9dctmeebepw+C4q11QVe9oHfUGoiXZLLdvteSS7TK59XA3RnKRSr9AO+dPsf2yW4MTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7260

On Sep 24, 2026 / 10:55, Yang Xiuwei wrote:
> IOPOLL combined with a PI attribute used to leave iocb->private as a
> uio_meta and oops in bio_poll(). The kernel rejects that combination
> with -EOPNOTSUPP. Add a scsi_debug reproducer that expects this result.
> 
> Assisted-by: LLM
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
> ---
> Depends on the kernel fix that rejects IOPOLL plus user PI metadata
> with -EOPNOTSUPP. Without that fix this test oopses in bio_poll().
> 
> Link: https://lore.kernel.org/linux-block/20260923093732.1504291-1-yangxiuwei@kylinos.cn/

Thanks for the patch. I confirmed the new test case recreates the Oops, and the
kernel fix patch avoids it. Good from test run point of view.

> 
> The fix is not in mainline yet. Is an oops on kernels without it
> acceptable here, or how should the test avoid that? _have_kver after
> the fix lands would still skip a stable backport, which keeps the old
> version number. The only userspace difference is -EOPNOTSUPP versus
> the oops.

I understand the concern. My current policy is to wait for the kernel side
fix gets upstreamed to Linus master branch, then add the test case to blktests.
This way we can keep blktests runs healthy with Linus master branch. It can
cause the failure with stable kernels, but I expect it will work as the signal
to encourage backport of the fix. So, let's wait for the kernel side fix to
get settled on Linus master branch.

Also, please find my inline comments below.

...

> diff --git a/src/metadata-iopoll.c b/src/metadata-iopoll.c
> new file mode 100644
> index 0000000..95e2bc9
> --- /dev/null
> +++ b/src/metadata-iopoll.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-3.0+

Your copyright is missing here.

> +#include <errno.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <stdio.h>

...

> diff --git a/tests/block/049 b/tests/block/049
> new file mode 100755
> index 0000000..b932414
> --- /dev/null
> +++ b/tests/block/049
> @@ -0,0 +1,46 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Yang Xiuwei <yangxiuwei@kylinos.cn>
> +#
> +# IOPOLL combined with a PI attribute used to oops in bio_poll(). The kernel
> +# rejects that combination with -EOPNOTSUPP.
> +
> +. tests/block/rc
> +. common/scsi_debug
> +
> +DESCRIPTION="iopoll dio with user PI metadata returns -EOPNOTSUPP"
> +QUICK=1
> +
> +requires() {
> +	_have_kernel_option IO_URING
> +	_have_kernel_option BLK_DEV_INTEGRITY
> +	_have_module scsi_debug

I recommend _have_loadable_scsi_debug instead of "_have_module scsi_debug".
It will do some more check for the scsi_dubug module status.
