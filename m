Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015323859CB
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 05:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787203562; cv=fail; b=rBZQx2QUJK8qHtPWKIPI8hheYriGR2R8oFVgsz/HNln4mfce2En/z21A+LwQ8Wdgl8itdLJz172Mzi4Tw1jRdvctahbqHOpyVjbxjwdqQnVzPIDXB05uPymwwfTt0wZKIYoBnXvQVsLHT4lQEDW3HdAy+zPuLoKycQt1jvoxsSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787203562; c=relaxed/simple;
	bh=anG+laVOsfsBnKFR03ZTNmGViO7i79cvSmlNaIPgp9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QSw2OWUOjLdDn1KWWgIMUFnWiyIayKlx5kVxgFngmb0jdekYaxnZecl9Qm60FaV8m+tRf6TuDSLAZK30q32ZrUSGGzTUKRjqgaNyv6+/SXi9UbqE8ZvZnVdraClQ0JXz3+DHb5RjIjYy+OvCpX/u06xzfNc23hS2H0ijbIvADfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jZD9AmCa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Q7mzYxbC; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jZD9AmCa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Q7mzYxbC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787203561; x=1818739561;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=anG+laVOsfsBnKFR03ZTNmGViO7i79cvSmlNaIPgp9I=;
  b=jZD9AmCaCAMPXDX8qOROIncIhNLlutnUfbxR0i5u0a2j/hDs+aD0LI8M
   uSx8XV0Df2utkELRw4QQspbXqRt5Df8itvF/qIL+Od6P0tNIbzbSEwPbM
   GPPKOTaE2m4Cn8m/x7bLPoxjqO5PRcUftA4zFrCJSxV6O/lxLKS07IBhO
   fqxi5nplt8kgVAwrHq12AKYrEmnnnFguOCi/Wow1y0DT4ieDAt8BOY1zg
   AqoV3J13UB/hDMCB2dJfs6hJUg7pHHj4wD6vnXfM9kFKT05f9vZB0hAhC
   /w74snwZJ/fH9c36HeiosIA+Io6p/me8oFoV6HrFTUfRiHA55a8YF0eC9
   g==;
X-CSE-ConnectionGUID: j/ixlFZGTVWRv8Zj0ReLpw==
X-CSE-MsgGUID: rvpRFoutTgeQDyNFoE3VnA==
X-IronPort-AV: E=Sophos;i="6.25,232,1779120000"; 
   d="scan'208";a="153898053"
Received: from mail-northcentralusazon11012028.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.28])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2026 13:25:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRQ7WyUBJpEMSVJslLgs232MSW1M+kzxtgIsTpDqD6iwVclyMYfTgeAOlqFmiHZXEKTzM7hPaqpEwHpqyQKWHKGz9asxRI1QBBf+wX9uF7cGae2XL2svcqlscr25f6doCZeZQzyT8BDMPe3SVSK81cJcHD+m3TwSShSGa0GvPPAl1Ic4DddqT1mLajZBFnJ3M3Qzpu1kSboPJ4W7bLm6YCiwkC/Dt4mCcJJVw6gYD7g9+NRJ1u9ZlqWC47xZowIHO7D0HNknJ5kE3OleZxDQ0h0G4f2OWbdl8Fx+WL8E/WxxdrJej5OOvX07BU/EjXsG2R4S56ABItUdVmo+yyHUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRKrB4G+Ir9Up12XyuYRwh0GTnPW6DsbqUoB2pqugHo=;
 b=wXI/99yas4UZEa3clf+3ULMDKe/XgyqvA59dAVKzk+9SExJakUiFAWre+dHL6WoOVniKf+z3XOi3AMqMis4RD+kdFJswLAk1ixtP3YDPJKlcppYS9gnP9Tsr9XMODvNd+zH0tXBKrEBn+4+dXQm9SVNxW9wTdNRCDsOoI1z28HnLYUpEx0e4v35rBeZYguHbRrCpakSv0YRMRbPTxUMxJn8NSrIMRX9Fc6wHCDRm3n3NNocLWUzQ/7ERtyZA5OG2FRHzvh9rn6e0BnmlT7wFveRL1d5FMbo0GLUCOTrxkb7GOTHhPUJQYSpAV8pbWs+60tvXirQ1Q6s4dsYmNo/nzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRKrB4G+Ir9Up12XyuYRwh0GTnPW6DsbqUoB2pqugHo=;
 b=Q7mzYxbCwh+8f24EBc7/nxgoaY5hcoYuz+m/kfgiQ7hDnArOdWSnAqEV6gHFYYQisHttrhFdUOoRTqYVJTVFDZ9UgrpiouwRY4WTJaQZg8L/Sjxyyp37Tucj/Lc4ZOHU1WTvQK04V/4ndtS/rphnJh/CJ/SUp0x6FMqPREw6kZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA1PR04MB8824.namprd04.prod.outlook.com
 (2603:10b6:806:38a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 05:25:51 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 05:25:51 +0000
Date: Thu, 20 Aug 2026 14:25:46 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yao Sang <sangyao@kylinos.cn>
Cc: dwagner@suse.de, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] nvme/070: add multipath command effects log
 lifetime test
Message-ID: <aoaLLOaNlLd-p3zg@shinhome>
References: <aoVkX-G5f4WNiU8e@shinhome>
 <20260820005532.1564542-1-sangyao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820005532.1564542-1-sangyao@kylinos.cn>
X-ClientProxiedBy: TY4P286CA0082.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::9) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA1PR04MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: be46c0cf-f3c2-4351-9619-08defe7b7fd0
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|23010399003|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	D+XVXclzutyx5GVHq8bCfFRqbsFT+sVggYZXJThJ38mo37JD/Ab6wH/0VLBJbO1g7GNQUhfBxSLmVF3hs8liOVFlNaCcRbhU5csxwpQXwkooiuCujxpG6ijTypsY29V2NdI8KQvg03SZxejlpGozXhL/8rHiZSTYbSYPyVbt/+6VxrcF+neSkwq5WdFZ2Pdjr19H3HuxjyHVm40+xwGi9gersmapmWMnGnczHyUdk0YI0UrtkU+kDA3olbH+5D6GTUFrtEPCYxgLROFojKzChH76g+TPaKccIEt5dTlU3HWGHppbRE0efu6b+IO/7mprc3eaTNAWITJhxMkFn6CIxWytdA/sTUmxxzOL9mMoZ1JiOwv7LfPhvQh8sTe2IMx/bzOsMObiZWu4xyMLdtWfGSN/qdYKFlzZsQw/kJoNlEvIt2JYBvBXVirusyOL9omLB4d2NwP5RgjtPv9tcDl5soePhR3lkwcticQM7L/Fv4+kZKO1YamGeBfMerWoel3edzeJSsqZYFITgmp6YVtSYHT616DWWnXlDzf+m7HUR6h8WiWvZtdYxKaYK8fAn3V2rj77innDAaDjmF1pcn6nkbc51M9phjZTR6gsVvqrhWBcjCU876DGUWNcUkXPz6vjIcP08bEu6dYSKCDmDUbbqOPGeYs1rKdutsa+Rtc2Eq0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ajRzTBhs4FpBuKaVHdZQ/dnK3ioIwUExZkZB8nyI1Coyci7XpcCogNCF/H6a?=
 =?us-ascii?Q?NdtJgA8wq4XKz4EVgefZtYPNnnba42datPzOxqg7fgUeYlrSZAwD9L8StyFT?=
 =?us-ascii?Q?DybpAQtc8GF/Uc857FNXrksPs4n8OV3dj5NHz/oYAWFb2ctgR+qzrhPwHIE+?=
 =?us-ascii?Q?wtySaRc8X2hFYXAGPefN+U8LgBpKjoLkCkFGJD9LPz8T/RN98cw31GJGK2df?=
 =?us-ascii?Q?DqBn60oi1pAK1+drEtBatP4leHGJkfwttyF/W4FZ3ZgkEF4P02jABT4+hmeu?=
 =?us-ascii?Q?RPLwJyv71VKn6WnqWb6Rl4arKv1NhB8vC8inTh170/NJRApxEQ00YLM67cX1?=
 =?us-ascii?Q?1nt1a4AyuKkS8Lgsd0eBsBV9ZJxuHArFNW5ErTTPlIDTB2DK0Gsz/m2GXv9e?=
 =?us-ascii?Q?EO1BA9eMFFzei0m3VaVIT2oRQj//GGI+ktMYQHFZQAnff/qULlgFuNg8eFD4?=
 =?us-ascii?Q?jda5Oc+IRC8Xq26Fn0kGbyV1kOdONvnQ9+X5XERP+J9v9XuCkvBY7j27UUKK?=
 =?us-ascii?Q?aUtWELoV4Fh7IKzKj+EEJGRMAqrYFDCBLQC8HmebKNxmqPZXKGquo6SMlKIw?=
 =?us-ascii?Q?13xx7xbGFNeVH2vEE3NwvpTv6NWW4ksUkHV4AHcZLtQVpENu7n9So4hIK5FL?=
 =?us-ascii?Q?SxrD9wS5xA/77rkEzX8zAgJJ+EVMwEH75e1533gaCDzo6jsLW2NP9oxsPSZZ?=
 =?us-ascii?Q?tnYIqXhQ97KNvkMO5glT7j/YFODiABo+AqIGjc8mi6Tf04DhhEWeSThn89ZQ?=
 =?us-ascii?Q?jThzISfVrZj2NGRRoL5L2o0kyYur/D2Pkza5T/bf/ggZQbl1RSSV4MBi+osI?=
 =?us-ascii?Q?E49TgpnZ4FeDD1TkmHj32OIyDv2CFw6RBbD6qA4N91OISv7f3gdvT6+7UTO1?=
 =?us-ascii?Q?kr096E78zjrfg8IRGH9cAqC0b8+to5bTSRmhJyP51wH5u+xajpRmTLQLwQTc?=
 =?us-ascii?Q?uibUKVJ5jTud4GHtmjZH6nW0iA/L2EJtjMOQXNwXoHiOlfx/j6ILnFz7TF9e?=
 =?us-ascii?Q?hziAjOuXbqdGCh1IxLl0bs51eI35tvh2E2Myc3ucn19W6D28NCtL7uGHy6yY?=
 =?us-ascii?Q?vQH/Buy9YrkscSIzcevqAHpQxDEyU9j00MEJLqnlK+1yxJb9k22fJLohjZSU?=
 =?us-ascii?Q?p74UNvDx6B1ZwJxYXZXxmGEd1Tt1Y6UYoYoTJQZgBRy6UQG49lSHw65wg10L?=
 =?us-ascii?Q?SCmEEzyrfcs/QT1o7qgjEHjRqT8ilVfMPucGbR/myyWP5OgDgTFBQtgANWqi?=
 =?us-ascii?Q?OZyUWs22w1/IoWGVpDwwTKgiNjD2cUqkSm4sFTe0u9exAv6ObNDmr4l3ULeG?=
 =?us-ascii?Q?aw9bsIG0oWa0ieIqvKlQutVwlsudZGEK99TlAsTtt3QNPxyJrXzuRKhCtUnx?=
 =?us-ascii?Q?3VegedzwPzlMHv8LHVg1p4brBSpVkh0GiOs4Yx1zzACYh9CRwH/REuIOJ+ux?=
 =?us-ascii?Q?oUNs47MdrNPNhYI0lsKQkO6pC77uMl610Fjd0itUYCDOU9oDMGcTtUjoZl6a?=
 =?us-ascii?Q?IgoP108WMQvJ7FLrfw+cZV5duOvMAsBQCewbgxpkQxcuOfT2WgXy1yUTfiHt?=
 =?us-ascii?Q?KFS2Ogn7dTaoOjsBvKPmMgBJwQ2H0l2OLC8XNCVgJYqJ9WXXmJRAAARM9/Jb?=
 =?us-ascii?Q?CeWWyBUSnuWQRCgPNKWS5YYZZ5walwFvemnnAGJt2Fo7yh3NMOfdSQS+MHUR?=
 =?us-ascii?Q?um9SKp90YeAeUdva8VfoBipE7DSd42Mwco1cULybHMIESncweRGfnBZ6vCOX?=
 =?us-ascii?Q?xBRU3tRop/P7soukGXqxcKpD1PbL57Y=3D?=
X-Exchange-RoutingPolicyChecked:
	SHnH8tQNlO5B7cQybe/U5KHCuqdj3677HtT8AzYA1+vSYIFXe25e1CJMCET2Bl6A07P1B+FpG0c7C0NUC5JZLxhx1eI97RyEw6Nxxuhc/tfuakGuAa1SqJ4AIVtpb+Rwjwfvui5BpsdSINS3juy4UBf9PfoiZ55vDOK28KlZALQZQREHwqSIo57gr95VfnPqWIMwWOVCg2TzFjG/Ch9Av8jYn8gggDWnyqBtdrc8GLMM4a2ACkX8t7REdb6FgVNoiZVtdrhntu8U/S4VpjyHJf6FFC0ApmHIGMPDoXAU08IM+3wjEYgLLqJzj735RCt6oInz+SWQrm+uNXtr5XLqbA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qvX7oG7fOyCc2l+6dA0in3YtVY4BSZ/1fs7MrurkTU6qbZ6sXDtXciaalV9WcoKPSVn8cFIWJcMQAzjmvP9dHAlo0UEoKx1k7L5KFypCEFDmP6Ki24SGe+tx0bLU2mhNyPylSImoLesujVrflz1/LEw11X+v7jsyzdvhtf4v3bzgGxNgDf/HcdFDtmbCmSjg8MMQPFVwG6Pz4FZ/CdXQ8CrWRzoaWaFqoaiWCQI/u4aYq62k5hFw0WYj9J3OS4QLBkIIREIvdo4PngquoQ1IiGAS4zhRjM7DeWB+i6LbHasjCes1oI/XukDTBo51Qc6Jrxij0p9/SU43L4kSA6SzhDKjvwMG5GHa7gJ7X/EFPlUShUCvOD0maF3kunMTWJyPaPePB/2Rx52HMEK9NYCmBCZzeCDOaGtirPTpJDvi8lJVRMnsBlWsiuecYx4ha2S3GG0Yss+y/USjgjoUnLsjR/woIBS7rHY2TDcIC5ms2d5a5k9jOVss+spZ7eZ8QMiyMxj92Sv7erUzVQpo/6XpeGjkA6xMtWsaRTLVsixq/pWWDAaCtvGQiQVKlGoMwD/LRCup4Nx15Wmktq4rjyu7dZ9oj0qtagxsQZi4ypjQYFFOWBufUhVq5pNYsjxMjix9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be46c0cf-f3c2-4351-9619-08defe7b7fd0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 05:25:51.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrImHHyboXsHbv6gcs3lmCCKMLmnpjpGG0VflA6FZNLueLKoeGEE0vvpYfiHAW6V4YGX0SSt6hxyl7WUnih9kW//lb7VB3jjMKCugpEqukk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8824

On Aug 20, 2026 / 08:55, Yao Sang wrote:
> Hi Shin'ichiro,
> 
> Thanks for the review. I agree with the other suggestions, but I have one
> concern about dropping the KASAN requirement.
> 
> The issue is reliably reproducible with KASAN enabled. Without KASAN,
> however, the test may pass even on an affected kernel and fail to catch
> the bug. Given this limitation, do you think it is still appropriate to
> remove the _have_kernel_options KASAN check?

I rethought about this point, and now I think the KASAN check is fine. Let's
keep it.

As I noted, there are pros and cons for the KASAN check: if the test
case runs on kernels that disable KASAN, the KASAN check will decresase
code coverage. Said that, now I agree wint your point: the KASAN check is
straight forward and it clearly describes the condition to recreate the failure.

Actually, the test case nvme/069 also has the KASAN check already. Let's keep
the KASAN check for consistency.
