Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217382866
	for <linux-block@vger.kernel.org>; Fri, 19 Jun 2026 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781839581; cv=fail; b=Fyo8kur1o0xC9nq2RkGRSfM7DNNVPk4Wsle3RRs+vCaIdMA58roVG8fS4EYtMdTuIQd66WC0ooKby18y3klQDixGII3KSRZhdXP941uYwUoks8GIzOtQHRGpmOjXi4KRqOUkjjeYsqQ12+RHSsLIGUj+dyB+LfIRnHTk6Th2ffQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781839581; c=relaxed/simple;
	bh=LoeiL9Qlzb3PdZ2iJlOAKzN9OclHy9YYjOTAeBYfhbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ha0FCl/Oh+7kGRvM+cxbt7PREilhMGjsCZAqSurj80tzTW9O4IGW9AKZwaZ2ojkhcnhFd5Uh0HJKjo8HRJMJ6Byyp64aAlLhtAfaaY59vBM8u7lSzH0FhhjZINu7l08rGHWNvlspFeXDbpFDEuQnbwFdeJed+C+z8k0alUr9DW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GGosxuK1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nuOxzg3y; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GGosxuK1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nuOxzg3y"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781839580; x=1813375580;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LoeiL9Qlzb3PdZ2iJlOAKzN9OclHy9YYjOTAeBYfhbU=;
  b=GGosxuK17QvdD6PR6ehV4FzZAJseduJw1vg5zUgGmIlsArMns8iaODEg
   P8qhUlYZCEC6qMPxSkda8N3i/iIlCL74MQSXyt0VkgNeEhugmaSk9x16u
   ng5Tah5K8MwNMzinKvzjduhm08G+E91FssP0iooDWFy3OUAgmpNxQ3vPv
   USzTk2w1AhR/wevT/UREcRXv26hv7PuZwqEmbvVES6QkT3QoNggRWNUez
   EhWdiTkoe4bv+0mAaPoF+JKp8K77LHS5njOIyy0+JUTy0+ksqg9ju3+14
   S/29G95SEIGstXUSBLgozLKfE5pAp97/SgqxK83arFnrRjA4o24z8Ecyw
   w==;
X-CSE-ConnectionGUID: LfU6UpeARgq1hqEoKgb6uA==
X-CSE-MsgGUID: yBiH41wmRKOm9uszI7uK1g==
X-IronPort-AV: E=Sophos;i="6.24,212,1774281600"; 
   d="scan'208";a="149449064"
Received: from mail-southcentralusazon11013061.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.61])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2026 11:26:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHXmP+zDwOmkUHpI/pvgPsDDhB2LiSMffRREFyUClq34ArkhJjAqWhgDlJtP1E/c72SMO3CTQk5XeIz+AXBajCDq4kaO7vNiYdNgWwyqwkErNR6ysaWmcoN490ckUMcFM5O9LjLT+hbsXxhey2W0BdL7lOg45lxX8s0ccDp5wV2+XQihNm2tb1jmJXP+iO5laG12XdLJCCecUi0GN0gyKiV2Pw8lQzwL/D6IHovlSD3eHNtqH/btCnSpxVOLCiMKBhB4iB4wjtRnqCCMb6rMKGPcPsfAl084oh0u2mc1LdV+cJE5qCODlP+R2NUVFaKFmxMRTgD0a7mi5ICyIBX7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHBLcxZ5ggmLlqj+rLDWyFuB9MiKZAEF21KlpxkUh5c=;
 b=uH9wExfossru/c60Ri80YVprCAVwn3cUy+rCBboFWz897Z9+1TeVuDTtxalLueBjHPCU2HeBwNZfUrP8/gLwwUrNn1tqBGORhIFoDyC3/EtdFgLKyBFtV/BRtAdTQWS7YQJt7dR1OTGElMvC1XiYYtLHQU8ZefR7SDH9674skdqo+TB5gJ9lKlgqxQm/nH38aCyTKdBeJgs0sBXmLE8Ub25IIDpo/uDseJUdoYboP3durbMUz4UHFEuAvhbLZKErY1pwa7CwZZamlOddadqKhHgHrp1Lyyi5WGCWzB22X5HMFmB/DdeV3ikkUShwjJnz0G0fflUZzrnxjWLVEfyXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHBLcxZ5ggmLlqj+rLDWyFuB9MiKZAEF21KlpxkUh5c=;
 b=nuOxzg3yxF/qciLEhECWNmUsQ47QHEgwvAV8ATuhLJYVJmCa4nhanWsY1QYwVf56r8LVeeeV3PkwuU7oe0hsLcfDRVvVXkwa/dadtXyqf0VE5z53XG0iV5Uybr+F1ztPbWJHUHHSTqt/mN0Q+uCZ7jgEdKQ5WQ2ocVoZiVm0T48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH0PR04MB7495.namprd04.prod.outlook.com
 (2603:10b6:510:57::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Fri, 19 Jun
 2026 03:26:17 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 03:26:17 +0000
Date: Fri, 19 Jun 2026 12:26:11 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-block@vger.kernel.org, 
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH 1/2 blktests] src/miniublk: switch to ioctl-encoded ublk
 commands
Message-ID: <ajSud4Y4PmCu2X_5@shinmob>
References: <20260617072516.6238-1-sebastian.chlad@suse.com>
 <20260617072516.6238-2-sebastian.chlad@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617072516.6238-2-sebastian.chlad@suse.com>
X-ClientProxiedBy: TYCPR01CA0209.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::14) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH0PR04MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: e515d6a4-ab12-40b2-0fa5-08decdb28646
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|23010399003|22082099003|3023799007|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	8ibukInU3kohHY6BE/wOdsRn0jqyCe6GeJJsdQ5TJcOXLxF5w6o0ZK4Q6RvO0U3/qETTPvKVvOvecy1yoFF9U1Z1781ntets71gujFzeR+SLFv2Qty3zyyBt84kj4n1wTLGJO+jSNzFbeSUUfCTPPF1W1DM5DBJqFEM7GsdeIUmlHQAg9X5ucALj6AE0C61nFomPvFQZpgQNQaXhLxxMyjb4F5pBONSu29HNRJCi8kzzVzype94UMUX4Ns6tb4ychkChA4oGIBgTXVkfG9k5I6p9pJmN+nhVEtVF/qTC0rUw+iPc/4+lBs7tTxNcCI27bSXPT5MlMy0Fw6sfOtwzELm2CNVAeda/Gu131Ot4/RCHknxBFC+o+qh3RFh0ZkrsntKQSF2xPtao8vrARJ9Ji/pm6yj2i6NLg63zUphI04HJYmAOr8WvzzbwmL2CrDgGy4lbNRMUcSgu4qmfMdJt2DnBOuM3kmlfYgcK/Dn9RNnuwxXtZ9QvlBLs8zQro4ZSP2O+j646a80XEkcwy193XFUuOkilpW+EECuOI9Bgb2O41tKG+G07TKmneUcwBs/EsuMg+ICJ0TzlOMe/dKQKE35LPJF9pqMIv6yBm957kYJDzx+9WDs4Dra0fC4evh7btfONjLsFgmVz8HtU+wYZ1oyI9RbkS2Cgov68u5Pu52o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(22082099003)(3023799007)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BLN1U550X3QcotWN49Pd6ofwCdww42TTiFWVWW8/Euo1TEzdllEnFnf9nanm?=
 =?us-ascii?Q?O3paFtVUsVM5YIYT8i8R9U56hrosiHqqXklCZQmdVrM2wUcOaS06PPjrUXVQ?=
 =?us-ascii?Q?Jt2HLkfykmG1buvn/52V/Qhw2VDfyt4P1w6rIcta0dnd8xoxyR3b5xy3JA0a?=
 =?us-ascii?Q?n0te5G8Bj4C5QyIoh9OvZtqpEFXLyXqrhcMvmHhjOBuHPr8w2dvX/J5aHlc3?=
 =?us-ascii?Q?Wd/2WPN95ufgU5fihs59SIIz891t0yCsKcEbjTi9mcUxtZ8hCp51S1GhKsPW?=
 =?us-ascii?Q?Moh9QpFb/TXdzzF0Es+01sEVUfRCWr6aWuRU9gUMANcNGWQtppuxlb1mEy1s?=
 =?us-ascii?Q?SGoy+fF9bcno9zz+52oGbfhhTtNRT/VgUWWJb5lXedNrKnL4w1E2bsZ/Kzh1?=
 =?us-ascii?Q?4kA/kUbcsNySRb4lZhsdHE6n7XEwbOQNaetBS+XUXadFwMbgyLImDFPwoX0t?=
 =?us-ascii?Q?z+zmJMQOu0tqa+XBzQRDR6Qj5xoLOAT4UirXHAi/PrxvNNVIdCiH1c5SmCW2?=
 =?us-ascii?Q?97YxIvd68JQnGCGO6EDFcMEJul9o3t1l2ifzeXhX+UWcAkhKD5JKqZESdRgC?=
 =?us-ascii?Q?Mbkcw0Rckvhp5gMJcu3H2mObaplCflCOmQJZP81EFEllnC2hw3OZ/x1Qioe7?=
 =?us-ascii?Q?oi9xZtm9BCjxiderp/8kmyLv9Y7rsnMqqRR45gnMHTYabUsfMe5ztkcM+1sx?=
 =?us-ascii?Q?ReWPTp5q5DZzn1Q8mFbN4PbKAZosoyqzouymz+5Qro+L6sQeYKafXw0ClKO3?=
 =?us-ascii?Q?0terPtu/88WLhXNpM/cg+Zf99z6xBqnX82vmN+B8qb0h0d2XuYpXYNrfhgfW?=
 =?us-ascii?Q?XwurMf/wNrqblk7/3CwaMuG/faYhkoaN35Gko3F9yga/QkjeresGBGqI8WvI?=
 =?us-ascii?Q?1EDaToPURI3REhEntcMn7eWzQDBYQiYtTwy6HXB8TsiITYBBQw+cJt0h5R3f?=
 =?us-ascii?Q?qrdeawVvE4b0UJeNuuzzTH3v6XBa8m9hZ+oDJ0F2BoGm/dF2dBLE2NDIkspu?=
 =?us-ascii?Q?fMf8ojMFNClkTLYGZg3LxT5Z5WnrKnf9XBFwEQvKFWBDaTfG/vAB66CVvdp2?=
 =?us-ascii?Q?zLPqGOYWvvsq34Xc+ovgX9txALxdGTmKDHGM988CZK+afqdL8Lm2VAsCX5jf?=
 =?us-ascii?Q?IoFZjMlFT8ueR5jBhTH1plerB0Xzt1p70hx7GAMDXrouopoa9IYeBzDRIisI?=
 =?us-ascii?Q?Tfmyvy1jSyjr07BIMm7gwQSUJuRwr15FcwJ5JCkgRMHNJh9D+FaQkrfTEqF4?=
 =?us-ascii?Q?zpFEkJ2PWDVg990E8xzRKYA2AO0Mgowd19D6NZQ2zrXpPORh/pHfsMfFjtRg?=
 =?us-ascii?Q?JM5mrqXor7jQVCZ7/NJ5UNV1MBJdntp/amlWKEVfQUWuTvlOOnP5GxdxHoip?=
 =?us-ascii?Q?GJQt7sNs/3/scB84HrpjdF0UeSRo9aOPAEKi3BAXfo3qEKJqcjLTPlbSltHP?=
 =?us-ascii?Q?scc1ivk/htei/JrtvFB8PFe8rkr2MyfzIqbDydRmp5uFlRxfEidi/wC3udGO?=
 =?us-ascii?Q?DjU4UVMfuiFYjpxaGWAdDnivBfdL73c8UMYsC7VKmZuS+A20RpqDYRFKzV/b?=
 =?us-ascii?Q?nTogFf74coJLTCZznUEwYGxWnUsGNtcYwrcWOVINeyge2FPykBe2NE/DE3Sp?=
 =?us-ascii?Q?avsokPUXKyACKTzQPMn9jKP5JcbSaXvm+1XKbS/ODmBnjvCxgvRU1BckRGQ9?=
 =?us-ascii?Q?TQmzGeeYD9wVFptRBaXptUVl0xjXC3nuG4H9XMSQRVcMaaoBSdRWrgkYp1S6?=
 =?us-ascii?Q?3Ijhwn0gdJO87uSn3xik0m6E+dtaRSc=3D?=
X-Exchange-RoutingPolicyChecked:
	nsZrwlbMjaDWzSiZvm0rs21eVvc4uZOIrLQwJq8tv+0ZLJtf5rnQcdqr0CRV15QuV18xrruSCWmwE03IW632vDf/Rfmw3pQI+3Alm73IAQOeIhdS7+EgHUJ/2E5r6HeTa7J3sjUGyyZYmqTrokczFhxTArdC7ME7gFLzTzmPfc5n14zuJXwE2yicYO+STTUEreyWNUchBomk/2gJn95SFJCQB/dmvC9ovENhDz+Pc0Bthbc5CFBPp5vqc5/+kccFybxOGd4ZFHRD0CgtOW3ZtlyIoVA9OXLDNnbPR7+DSj//Ew2NhnnSi04UZ4aQGPF2ipB4UoMXlaGXt3mXizhIcw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kIj5+w4t+U1M88AwsEky0qTLrroIULgSu0hHUJlt2dHB3v76fmH+VvAWo84K/NbCN0TdSjjGN/Z9rX0Qkdnb6qh9HAHExFpeIgKLiqbe41VG5Ksto+ood/1yMs8yD5Y8ej4fA9YqUUUoE8ahJ7TQ294Q1qbsV7nx7ChUkvePAwZzhnx8GjtUX9xphyo1WYTc7pb3kGaWwxqUQEDghFsPf3FjDo7vY7+x1McOzZ6ebwCu9nEprXQXgLXkjPtHqK7AYDWHPIBLhmt7WqgtKnVidfc5UzNslcpsZT4/m6eeXkzSEBf5OSHI5RuAI4cZWZpOeSw1melOpZ30O9/qvMkAUWLyCeI9Pl+h+l3n2OejifRJrW5cqbikBUrTllgBRWc9HQSnGJC2nftAxcdpvrENmlwwLiFSkadzZkWGpKJoFl3tCFm6YWJVhUeR4nVJeKTt7fsPPbjDedvc+Dux7w3OCBslZAw+7BHPy8NubLl4AQzCrl4afZFyiiAT37WEcHcM162t/2i/wKe5cMKQDPDkeOouSIYZso/KlmOmWcY8ou+oGgkmEMxFvEwJubKXhRaHpZ2pjh0aap5cixkRRe/YM4f/tZsAo/72jYutaVOaIgQAZ124kVzRD3hJ8hPoaU4g
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e515d6a4-ab12-40b2-0fa5-08decdb28646
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 03:26:17.5742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHabME0QlEsNpl+mYyTUIkqLKmfhD4/X6Qm0AqkcLMfDk9PeWnmg9aWyvkbkkfIAG6w+mZwU/haE5hQVaer3x5zvCE5EP5n4OhHWbpAzNWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7495

Hi Sebastian,

Thanks for the patches. I agree that this direction is good: it's the better
shift away from the legacy interface.

One point I noticed is that src/miniublk.c can no longer be built with the
kernel headers of the LTS kernel version v6.1.y, probably (v5.15.y does not have
ublk and v6.6.y supports the new interface). This is a rather small window, and
may be acceptable but I wonder what you think about it

If we drop the miniublk build with v6.1.y kernel headers, it might be the better
to check before building miniublk. I quickly created a Makefile change [1] for
that purpose.

Also, please find a comment in line below.

On Jun 17, 2026 / 09:25, Sebastian Chlad wrote:
> Kernels built without CONFIG_BLKDEV_UBLK_LEGACY_OPCODES reject the
> legacy raw UBLK_CMD_* and UBLK_IO_* opcodes. Switch miniublk to use
> the ioctl-encoded UBLK_U_CMD_* and UBLK_U_IO_* variants defined in
> linux/ublk_cmd.h instead.
> 
> For IO commands, the ioctl-encoded opcode is used for submission while
> _IOC_NR() extracts the raw NR bits for build_user_data(), keeping the
> user_data tag encoding intact.
> 
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> ---
>  src/miniublk.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/src/miniublk.c b/src/miniublk.c
> index f98f850..5a35ca7 100644
> --- a/src/miniublk.c
> +++ b/src/miniublk.c
[...]
> @@ -624,9 +624,9 @@ static int ublk_queue_io_cmd(struct ublk_queue *q,
>  		return 0;
>  
>  	if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
> -		cmd_op = UBLK_IO_COMMIT_AND_FETCH_REQ;
> -	else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
> -		cmd_op = UBLK_IO_FETCH_REQ;
> +		cmd_op = UBLK_U_IO_COMMIT_AND_FETCH_REQ;
> +	else
> +		cmd_op = UBLK_U_IO_FETCH_REQ;

The hunk above changes the "else if" part, is this intentional?


[1]

diff --git a/src/Makefile b/src/Makefile
index d8833bf..adfe3ef 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -8,6 +8,10 @@ HAVE_C_MACRO = $(shell if echo "$(H)include <$(1)>" |	\
 		$(CC) $(CFLAGS) -E - 2>&1 /dev/null | grep $(2) > /dev/null 2>&1; \
 		then echo 1;else echo 0; fi)
 
+HAVE_C_DEF = $(shell if echo -e "$(H)include <$(1)>\n#ifdef $(2)\nHAVE_$(2)\n#endif" | \
+		$(CC) $(CFLAGS) -E - 2>&1 /dev/null | grep HAVE_$(2) > /dev/null 2>&1; \
+		then echo 1;else echo 0; fi)
+
 C_TARGETS := \
 	dio-offsets \
 	loblksize \
@@ -27,6 +31,7 @@ C_UBLK_TARGETS := miniublk
 
 HAVE_LIBURING := $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
 HAVE_UBLK_HEADER := $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
+HAVE_NEW_UBLK_INTF := $(call HAVE_C_DEF,linux/ublk_cmd.h,UBLK_U_CMD_START_DEV)
 
 CXX_TARGETS := \
 	discontiguous-io
@@ -37,8 +42,12 @@ SYZKALLER_TARGETS := \
 TARGETS := $(C_TARGETS) $(CXX_TARGETS) $(SYZKALLER_TARGETS)
 
 ifeq ($(HAVE_UBLK_HEADER), 1)
+ifeq ($(HAVE_NEW_UBLK_INTF), 1)
 C_URING_TARGETS += $(C_UBLK_TARGETS)
 else
+$(info Skip $(C_UBLK_TARGETS) build due to missing new ublk interface(v6.4+))
+endif
+else
 $(info Skip $(C_UBLK_TARGETS) build due to missing kernel header(v6.0+))
 endif
 

