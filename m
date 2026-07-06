Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CC0351C22
	for <linux-block@vger.kernel.org>; Mon,  6 Jul 2026 02:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306524; cv=fail; b=DH3/v+QXsY96tjKzrzl5KrqgJKPzR88lVDp08nWphGp0UGDDV5aV28PoqBvVUWliurVqAy/VUKYOr+PpoCQz2r31PWxO9J1W0Zc2wevga8/huccLomEwbb75g2F+b7XmMw5jlVCw239AIJ8yamI8PuWp/w7WohgkTxS90mJvsZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306524; c=relaxed/simple;
	bh=HIMKkGvwFcDNM3Euq16aKooB86tqcE2Bi/sIyg/UV6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A+creTpLXvNjcjX+TdXA5fKkWrqhX3VXjscJ+A0uW2epiH30btr5a9Y7Jc2SreYg7APT52pCFjqGEv7J2hAk+oYsCj8CUCNmZmqr91gUjf5chOHBSKaX2A0ln/6lNjSVpjc2L9Ca4Za+ia6pNtNt9jXIUdHYc3iGgUH434BC/98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=et8YZr3L; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ciIdLmIG; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="et8YZr3L";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ciIdLmIG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783306522; x=1814842522;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HIMKkGvwFcDNM3Euq16aKooB86tqcE2Bi/sIyg/UV6c=;
  b=et8YZr3LKgVeFT8jULDAGHge9a6dC3QrPxrnzlM5uy5fuNdNSCnwFlQj
   7dfE7KTVy1GVrZ8PEiPUe5Q42SkUD95DrRTs4WKivvO7VKMVqSz6f2m5h
   iNJhp+EozVVSI9WEd+yGiFgST4M1SqUqSy1pAinhT2JMmqFx+oaUpUJ36
   usnUBHSG63XtVt4iOOeIxV42ql22FfeU/p2lBXfvn6GgOJWt+cG+rZvyt
   8WoBvMOpIvL6c+QeDRxmmy/xu9Bh381dyGuSKUON79XKQ8AzMfAjDvwg7
   ja4foQGdtjBFC82oobvfC9e+NfpC2Fa1h9wN9vHBC0naaaqQb2srUtw8X
   Q==;
X-CSE-ConnectionGUID: BG4erz1GQqqgSOSxNGTgWQ==
X-CSE-MsgGUID: kLYDxB97SU+rSX7OeNB3XA==
X-IronPort-AV: E=Sophos;i="6.25,149,1779120000"; 
   d="scan'208";a="148909031"
Received: from mail-northcentralusazon11012056.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.56])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2026 10:55:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0+t/EtWv+m142zlIsHOlZQZypBLgASiKaMgD9Sis1UvWrwC8YqfLosAi++9sSDzRIHsw8qx16Ef5WNrs+zA4Ahm/bXzkBFL95x8RJkXtRuz25dNAo4mjqbDECDS7yz+77md+6/V06NKFDa0vV8aJqrV1rxx9/5V8F/xx/616lOWVsayi/lkHIOrr/XF6d3pd218lRTdaH5StNDqhvGIHSV7T20XCCi/5oppuXpl/N51B7rirWsJe88KWDexUJEZwGv4XFcYTSd1/xPY7oWBptt5s/Rb/bJbScMYTw9GFU9mGcYRIJXxULBAxMgVYhJnU72cvHFzsXBnScVMo3f39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RizWeACyD9oLDJVu2KlTDYJ4RmyC70r2bkEBsZ7IJVA=;
 b=qSfw5KClLC30PF80XUxd5ksc9zy30WNCPrwLXUabOt7ei6c/2El5RtiAe7ZLCc4qzB+NcwCabLCmGWwIAkqj4b8Y340JyuwamPISg2TDbFj/f9LvvtIpDQF7PFF31gqaFBDWDAL1PyoRJN4R864yDZ6exOuoMspB6vWgmODc+XHdLlrcysTLn2VJtFhy6H/rHN5y58dTKXjZ+6QcV7MPMgqTXaTtXtbUC/mC02Suz8QiLnOzMuEFqC8MzZXNHJt8GYkp4G/9GuIFVkQ1xY/ZN+sug3xh1W4UqCDjqDAeeSc/HD18AbOjIfPTNEps3zhpsPm5rGJ/LqQhh48ajUCYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RizWeACyD9oLDJVu2KlTDYJ4RmyC70r2bkEBsZ7IJVA=;
 b=ciIdLmIGnHWq+RNBdlx4injVGGxY4HlmYrGlmevytSsoB1pXjmpGtDJL9RU6d/fU9etEKZeyzWsf+tHDdmTmceG/hZH5ChMfXwiZ1uOV7E2YCs83ZH/dLgIzupEC3RTQddb9QgiiY20Z2g668XGmNhUQBNBwwGgod+LwZf6s/9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS0PR04MB9817.namprd04.prod.outlook.com
 (2603:10b6:8:2f5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 02:55:20 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 02:55:20 +0000
Date: Mon, 6 Jul 2026 11:55:15 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] Fix _get_page_size()
Message-ID: <aksY0-MFextyvx6n@shinmob>
References: <x497bnvlxlc.fsf@segfault.usersys.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x497bnvlxlc.fsf@segfault.usersys.redhat.com>
X-ClientProxiedBy: TY4P301CA0094.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::13) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS0PR04MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d08fd7-e622-44a8-243c-08dedb0a0468
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|366016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hewV0A4V+18SWBUsYLeoXjkmhu7JN7R7oT3fMB4ypLTH9YY1Sm/Uxg6a7DnWQPZZaVEG6kzFH8WdgoV5eHwcpkWw5abf6f1RVLJ8uP0F1stjtbJ1VxDAv2YRVgn/n4zG5gurhmIdnvpTG9uQ7exySDk1fTwRMM7mgDF/qMb+iNOjM4frlTc84Yb+PFOjbjgVTcQWSEA0pX2A8rI6QP0l1SXh+r4gUc72hjC48A4vOCAp7wFCBqvsiu8C4S56FsWRYJ+nFlW4Fxq8/3Hrgt1cu3rwFP0KRfYeA9PKPyHHaeOt2EC0LbgtXi0T97ScbOOpAXcKu7paU6syA6UgyqfV4eYxE71APp1cz65FAQhnICUy3n4PKmB/9lwOiyU7hq8BB0f05qyqkRx9p8Tkk85Naq4t7j37fbWW8fOifLwS2Nw3x7vnXVJkdlyv9e03EAihS+z2WkHusQfdfnP0w1XByi8x0HkvCOCh3YUF8te/YBio5sjx3goDkkJO4Myg3xw1Pbd9RgLEyyPjXVPWmUz+ZvdN08N5Baalp/gS8ADe91jbcWsxrflzUQPuHXwmIqskPQ3Fhn3GkFGYkBcHfrNNHBmqDfAMIk3Uhoo7BgLC3vco0YADQKBt/0T6N6KKIChCpj9GLKS+5AKFuvWd63Ye35qni01jWlVOoL1rUEKiXh8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Er4ZKWHz0FkCKXqRTG/tJqRttVOY59DJl847tpf6tn6gvJoIcWErWf91Xn9A?=
 =?us-ascii?Q?r5v2wN3o+XfXiEDYp20zFxzXUCI1H273bJ4phyTF6+g+zLznbLsjmeaPFQAJ?=
 =?us-ascii?Q?neFwykd//2rXu0iIHTuRckQuuZJ8ZBPIgrmzE+97L15PRIx4TPH3S+tUR1az?=
 =?us-ascii?Q?T9OTX4SL/LSSWXNwMAnSJyiUP9jhcQB44wP//hHK7+HPi9l27dQPqwsEGngr?=
 =?us-ascii?Q?ViqgGCTJgRWeSAun1kq3cz77ant0N2YB57LhmTLj7kSp2VmWsRznpzaloaKT?=
 =?us-ascii?Q?ME0jwei5KkopUJQ+lJ+pq3IT1dU0JfJUjPjIX7Eq3OJaUev3G0hfNqqXZOv/?=
 =?us-ascii?Q?2FhCmSFYuSZOoNnkcSXM0VKeY8ou3QN/A4VC7qZms+m7YRDgsFcIWGr5MEHm?=
 =?us-ascii?Q?marJZqAlpWaNcvfFbJr+/H1q3K3zRB4pHsiKNMAJJTKLp7eW4sxS4PZXysZg?=
 =?us-ascii?Q?FUDt6zyv3RALFvE9EBVdvlm3baYt2X5pz1fttfA3EMewhfNud+HItzfl0u5t?=
 =?us-ascii?Q?YuRQyhppiAUtSxSC+WE6z6XUvidLTVBDdFgAc14DJP1c0PBkK1mlgsTIX+q1?=
 =?us-ascii?Q?pkBfZQfPS5mCTevlIWy4F41NMN79OFLwCCM7s7IO1SM5ZvaTFH000XWYiCvF?=
 =?us-ascii?Q?nBTTTIpIVvfVpKHeEnYiA3cfmP/5U38XVFTbkQRaxvYAY8DOg06s13VFB1iy?=
 =?us-ascii?Q?jFqRK75aeGi5LPUKyjI2zWeTPs4JgNHOpT3+s3bkFB0SmVhRxbbe7O9Xjscw?=
 =?us-ascii?Q?DnJa+A2A4oLiAPRkL0PvHM3IDHJEFmXFCMRQANl2daIGIqianzHPo/T/c9GC?=
 =?us-ascii?Q?yCtEIdUI52g7MDPM6wwZv+mKbXsoEnCp2PbBymy/TaqokpeQ618bOkTjQOys?=
 =?us-ascii?Q?UFNH7YgkcsB4U0i5V4mzzhyEVARt/8BZiewO+yh0I71LbgzvvyjjlSs6AAWZ?=
 =?us-ascii?Q?u0jD+6iC9fSZPXrMpu8HWfSbrW/8hSgI8nRqzDKJcHDxesIkGvAsDaNn6Kfn?=
 =?us-ascii?Q?QQynMzzzhyiOJfGpncMe4ickopK3T+djVS4PYWUTmzcW88U38RTdTMkMv6rs?=
 =?us-ascii?Q?MEAMz3Qwq4JK5QxRuzrQoHHKdhWiQLEjIfyfM4WJumeOPG4arp6/dSeMVPU+?=
 =?us-ascii?Q?rRonnswpoc3K2LNosEY7gcrjR3VzhHsXFVN0QALV0BMU7dNCe96GFma5Qlo1?=
 =?us-ascii?Q?dr2q16w9Z+znQr+egKrx++sNNFPeafSEnkK9T1zW+BzQaK8lrewzaiD1I4io?=
 =?us-ascii?Q?cc1yo5KDyzaXVOOfIHsss/DQZ5Wr/RhIRunmUAx/z/EI+zcB0F6JX4/pHXtF?=
 =?us-ascii?Q?fegwMc/8Y62ztakiNMJPNon/dy3vV0X//yFjOsVi5QakuXoG+3WBpDcfIPI8?=
 =?us-ascii?Q?iAt+G5xN0IvcrE4Jn8k64csEhMvxrNe5zGVxyhDxSMFDg/wWFAsQDeFlUMxL?=
 =?us-ascii?Q?7XUn78kIHTZkaQpF+/8BkPiTmh8lVohMhyHAzO8HncmXrhFeUxngenYJARim?=
 =?us-ascii?Q?f8YLZk6O+CxVuHTRFkjdQNuM4TEe7mKe1c/s+tnmn2ocmUWu6y2atJQg6mCm?=
 =?us-ascii?Q?xlAqSC2524CcSSA7RuwOFMT+Jbb6yiMNaS6WqJ4zPswlGGQvYefqpufgKTCS?=
 =?us-ascii?Q?6uLUopkVGHjyzrB32RszOZpuHiDfaGGw1OJFA4ImzsK9dTwkVGJqeteEed4x?=
 =?us-ascii?Q?Bh1iYHe1zblF6ffa2pp2IqRoGPLlebVFon7dGdwQjKJndTnKJ0iMI1aTjO6D?=
 =?us-ascii?Q?CZFDh6kD2kPWpI+dFTGOJJjBr/hpVrI=3D?=
X-Exchange-RoutingPolicyChecked:
	r91CX2v+ivqJYz5XHfZJhql/aJ7Q7Zex4srVpYjfZ30v/qrr9g4EhNQ2QdaRT9u/YV3nPxtWkKR8vzYkHczzmsBQ9HyK2KtqHZ1ygDSBfTra653RANgXzCCjHWG7TIB5ld45FkH7EBIkxKhd2bLA4I22z/tgzf0HI1eD1b4RdNm8CHabWm6YirCnsvIhS8VOKdzL2IzU/TugFe106P2s+qHJovGt3a8y5twV1/JijDt9mkqOaknhebQ0ZD/c0z+tNNOkdkSosramExPcs80MnhV2PajyHdjQNi51UKs6FaKy1u6wfsmeqjNGCpfqKrtSYfVz8qlbAQjtAflhAMS8zg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WK29XI2p3O6iVvDefF13uDs4vGAAvs1WJFgW7FBmO+jNx3/3yyqcPmJqT1jruNuQ9dQoVKjvWVGF1wUEuh8qBfmMuN3IPjb2pN0cR0/V7i1ysIBROLq1MwQ2tmNE894YD55vjizTYpQAiXbm8xBRjIglvv0KYzybvZQ+T6IlpqxYj9Zl0NFiLK68LETh1v3g1MCC5zWlKYtXd/ZRZcQJkXlSeFxfd7hzFVBRHyqlWTHqwY3S+p6OI3i9AWCoe/sY5J8FRm71jk/8YjJp+28YbevwWXshlelO5P8hjvUf5HLSPT4male0cQQ7OOK5wyFXSbxqhoSljRwr6gxlUnH+PqCXEf4XBcMLKsA+jMunXSCMhUaHgrhkfnajtqjdD+VPWsIjdjuedsdKz1yMhbt2zWYnGtySUE71o6VBB9n/r+5Br18F4yHRVQM5COv2Z/sCQUMVhVSlLVmhqs2HhsaAOL1eKPvFe3F2ysRPpBWkz2EA5oxhuWugF0SUu4yhJ1cGSJVxatBGnoQwE2xdbM80m2JrrB1byUZYgbOV+EwzT5AayVG69D0oi784grAgfiOQOE3e6GnAkUvDdKf4T9eNSLY+hOSi5RFKXvyAuM0tqLQwZcjJycudQl9Eziuu3OLk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d08fd7-e622-44a8-243c-08dedb0a0468
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 02:55:20.4052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wsHJ1xXC2o216XOs6G6w1GwMKIrKy/C4TnNRrVzTKAjhhRrzYEdD6ZpCnXmYfSXnEXlOYPm+MNIJ8nYRoqOdF+7NyZZj9wuAqjK5qugcH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9817

On Jun 18, 2026 / 10:41, Jeff Moyer wrote:
> There is no CONFIG_PAGE_SHIFT stored in /boot/config-`uname -r` on RHEL
> systems (maybe all systems?).  As a result, tests that make use of
> _get_page_size() were doing the wrong thing.  For example, throtl/002
> used it to calculate I/O sizes for direct IO.  Those sizes ended up not
> being a multiple of the logical block size, and hence throtl/002 was
> failing.
> 
> Fixes: 8eca9fa ("common/rc, scsi/011, zbd/010: introduce _page_size_equals() helper")
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

FYI, I applied the patch together with the other patch to require the getconf
command. Thanks!
