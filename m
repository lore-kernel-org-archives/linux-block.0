Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ECF363C55;
	Thu, 30 Apr 2026 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556156; cv=fail; b=TprBhGFSRswKAL8+g16znhEg42DddsuqpE0BRX0nbqD+J5gDddhCkpy7uQkcRtDBR1eXeAMrwirWXOSHwoWBEDBsLy7huyqGB3DTuMgnxYMQXfwD5GiDILi5XtqzujpdatSzEToaRX4XbiBLklQ+kSucyse8joBxnRCq1bMeTl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556156; c=relaxed/simple;
	bh=3IS9Fi8k8piCxvQqRwt1UUJpGS95ZYIux/L0SvCWXRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UFUPFbDSNergWLNuh1GcBJbobAuYEn94ECqSFtQSBTgzv4fKIDM0pWgdaPTjFZh3h/Cznx/Pxs8M49SsAhw69+oa9D5h0JKXtY55RPma1TLnOirg1Zb8X0bZl+Eze5Vve4dtvn6BZ2gF07sSinCgQVQjxKQGs0rLcdBt5MDmKKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=onjv8Gla; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WoAXxNkU; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="onjv8Gla";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WoAXxNkU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1777556154; x=1809092154;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3IS9Fi8k8piCxvQqRwt1UUJpGS95ZYIux/L0SvCWXRI=;
  b=onjv8Glaw6InyE4ANl5QSs0Z8xXIu0t4ZrTRjfrmAD5qCEMQVohk+H+B
   Ezwf5ZFcuNEzraULCL+1/TVYw54JKFRHBdOdT4QmZKF7GBiPU7U35+FGW
   SiXaIsGOBmZBJqplkTkpU3/pgiQZ0XsbCAL6jmv3Ev8zdnGECcPSuDDUE
   SkR3c40HVFVM/TYJmpgAdMgWwvO38jysaYr44+EybCaMP63M/3TbIFEkK
   SN7iT8N/fV0ALPopl5HhaYz3LtbKsFPTfUImNy0+JmUq+DwdusWAlj8E3
   x410tF3nrj55hbmNWOooQGQBqOcXM6prkRepFytZCAjLN3gTZcHP6l5w8
   Q==;
X-CSE-ConnectionGUID: toP3KTk6TYG9OO5X4jAIuw==
X-CSE-MsgGUID: DjkMlRVBQ6Knar53U43QpQ==
X-IronPort-AV: E=Sophos;i="6.23,208,1770566400"; 
   d="scan'208";a="146764134"
Received: from mail-westcentralusazon11013025.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.25])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Apr 2026 21:35:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3brNbNxPKsKvyLjnP0IIk6JJanwzrD/JaNu56ovb/RzywKgksLA8ushIxmEU5/PVvDliFbl1sZXo4orPDmaJZkr3AH53IOiaIyESrnWFc9WuMLKWJ3CSTut1XxULOXUh889TV8cRYdbrfbF0b6HOPH1Hcw6eq43YEJFIBjnFZAX09esOSVnZ+TvJWIOC0B37sojt4YWenBAieJk2QAVO45vGv6VAAXw4pTsTYlwD/vAAlUF6n2AaFNc+AIXI4IMxqGq3FwigHTND9gGqhdo2HIzl1nvT6c2MladIk58smvvJBi6iSZcD+vnyeXP1hBwz+PpQ6CybOu9CP4ytG6Z3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qmwwtaZVrcj53B9oq/fC4rZP3/v0HSy4yEuECWIjmM=;
 b=LGpSdeAZMHmB8eS6RHeckd28XsZlstvox9UvxnOt5ICB2BGjgVKq7GbtnpEb/bBSh880XMp+npo2i5Nq9TJH60Kkz/6lCeN6FwUrBAoEq3S4weHhK3pNT4MPT1DBpXoyHUBN7l1fIftFgLrMXgImlpWENTz4kmv5OGzQQpBK3WDaEsryGPD/b6UuktZ76Na+2pCziupUld/xR8kvUlS4nDTcimo9+xXGGM8T9KT45hFoCtJGvQ0aZ/xtAhUpgTCqoJfU8Rkwu4hYC6LnOy9hxSaL4WUKT/tFrWtgBPBKk1DkLnJ3c7KtLAEUb3aYyfjmhukrrGgM22wuyaSihB+hzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qmwwtaZVrcj53B9oq/fC4rZP3/v0HSy4yEuECWIjmM=;
 b=WoAXxNkUzuY+nM5EHUsLLLoQygN8p2nbuHulE3B0GZnWn0ktNoXWOcLeYFjU6mG29lOfCs9vIFG+SkzDtoCQ6bH5qXQpLQVOy5xKBcdm3iE2HubAe7W5W0LjC95+jPNaXoPRGBwww8ebU3gJ3/MMjMo7NhvSN3CoVHNEb1UzM0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA6PR04MB9142.namprd04.prod.outlook.com (2603:10b6:806:410::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 13:35:44 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 13:35:44 +0000
Date: Thu, 30 Apr 2026 22:35:37 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] block: bio-integrity: Fix null-ptr-deref in
 bio_integrity_map_user()
Message-ID: <afM2oyQTraSWa5vO@shinmob>
References: <20260427040926.987166-3-iam@sung-woo.kim>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427040926.987166-3-iam@sung-woo.kim>
X-ClientProxiedBy: TYCPR01CA0145.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::18) To SN7PR04MB8532.namprd04.prod.outlook.com
 (2603:10b6:806:350::6)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR04MB8532:EE_|SA6PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f0f134-5f93-46f0-93a0-08dea6bd6130
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|19092799006|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sGiWOan133S2DgVoG0PIihCxEnF1KdLImJb5nyVtS5EgoFxgOaQpiFLC4vERbFiKI9GvTia3cCtCc7iCg8f7I6SdaxtScuaVKgK2mJjbbzG27tdkeYIkFR4qZNs5PxR4yF0F3eFYo88tFO79tjfpBHK5+faywgaktMO3xVn1koWu9YKCjpijgIh8+cazdOE189wV/7xPIo09yBgxf9NkcFOGLdxiS6+eNe3ET82pT7TCdrSUVjyhxh6eTPTG0CV2u8KuwRP2tcGrStmNUsg1HkTZallwDvRUAa2P6TGMsv8zw4mXiVzfpUKkAdPiWh61qoXznFQQvzJcvfqPyGD0YpKtWjBIzJLN0h7Ux307Aw9jOQE7f0TGZOrj0oUli9paIxVy+4dfoI2nSg9jTt5Wnj18kDfqQiOva3fxAdAGjEfV9iW2QyWjlBMNXd4Ic/RvO7e+yDgQmXBfJGrNlCDAvkjZIR0jTfvkW7POqtVswh5o40BWy4JdF91iAXiff/jROYlJf0SB2dwRq9a9DGQNufbht3q1WWAyNJEqy8hlaLkTjUyI2EKF8qLy0OR5FYeDmWJXmapYoyhNKeUdwAFt00BDj49Uug0uLOwav7F2hKdLYZuN5ktwVU3kcRjJKeA/qdqRqY0UrciF24pMMCrRy9W7DHAUBUeCi685GQEZFSvaTjF3TG7bae2pKz3rjBiP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(19092799006)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dEmPdLwxkK41lVanqUWA1J8b3miP9wIgTV5h3JRXzRD2Qe02ANfE43X7pVf6?=
 =?us-ascii?Q?ZRPXUc4w3QCe44caITtPmm0aQtBnS/Fh/cvmX006HP3WFI7lszfkeF9WVznJ?=
 =?us-ascii?Q?TR7nhLlFVxmHuz8JBA9zGKX3KIqEX4qEsQWSXxEQEQqWW8J7M6VSV2Bs0VF/?=
 =?us-ascii?Q?AVRJdJyfuFp6EgqxfWKrEcFbz6MMFF+u+MzIUMKdrPYRZuLxs2lvYY9SBs4m?=
 =?us-ascii?Q?8mF75B7UGYHP0kTJZCJZaSWH9WNPOy7TKsD6KjhItB8T3qThE6WVqm1Sf8TK?=
 =?us-ascii?Q?ZnZrCE09ynouEp3WHGtZ6FRpZG3fBNYjvkjWM3iBX4zGpqj/uaTf0CmUlafg?=
 =?us-ascii?Q?z/SgEFeuoyq4/XeC79ne00jH1+G103ReayahxU4MMEbXd7zKTrRowNtIJbhr?=
 =?us-ascii?Q?6cn8qqD0BZsfgxGtlQ1hyesWNfg96I9EVTz7V6eRKOZGB3EFhDH/4RuOVCj2?=
 =?us-ascii?Q?6EH+H6z+DG67sap+qPa8Q1OYIndUe8hApkzFBaWbw3M9OkMPLHpR3f0mBtxq?=
 =?us-ascii?Q?m8g3Sc1PQ2AiSgwrOJTLUGt8iEGyLjDqP1AeFwO8WhsXj/EsP3Z/PIdzKaen?=
 =?us-ascii?Q?F311M1I3FyumuLTnhAKalRejE4GzlThGG9BdA8u/UFGh6NiNfyOFHYGZ+Xhg?=
 =?us-ascii?Q?OeN//GxXBc3RBQscH6cAUVa+4Bqe1LNdqCU2QKY9bDr77GUHocKePfUwcmEh?=
 =?us-ascii?Q?UqIOvixeVBdXSJVgkMYgpdwRvKDni7FFsGBQtRn9gKnBac9AbVHYRDqgJ0FA?=
 =?us-ascii?Q?mxpXhISSKiFpjoQZmFV9DjlzqoeZTDHq/nMyNpu0dEwT1bUU+JN91+FDTsV+?=
 =?us-ascii?Q?timLSCMCJsdm6u+MgPsrOhP0yZLSqq4q/rTzl0BC6rz1+q83Z+Z/b6Ch15BR?=
 =?us-ascii?Q?Fm0VeXTKGup7ZDK85T0DihLbhCIvmfilqxNW3IhrZH71fE76xg/Mt9mGYAKe?=
 =?us-ascii?Q?MBJ+/l4FtSRLHpRU/UWkn0DiI00D1GdxyKk31iPEXXsBk8WDuVncyRtsGFAR?=
 =?us-ascii?Q?ftPhe6bA+F6ZyhmJzDpSK90kb2x2ecW3429cW2HEM6tCpQt0S6QZWSBtuOBN?=
 =?us-ascii?Q?xKvZwmJeK6wzLmtn4R7v+EJ531LvwJLIWpPK99A/0fRizX6qasTfJj+/A1bF?=
 =?us-ascii?Q?/5ZYeyqr2l86nvjl8mfCogslUm0fEfBHATf8pBofLIkzihiWH+9yYy0IuJxp?=
 =?us-ascii?Q?h2OzKPMwFH9dh06xs0e4VVXOKglUAiZqRYhgBIiDl0q9umg46hnJJg9ot3uR?=
 =?us-ascii?Q?65Jt4X9n6IYMYJZvSviXq5qeDSwe5JsDPgoZodNg06lTaQjFOnBbIXiwrXTX?=
 =?us-ascii?Q?/qg3QmJtMCSfzVXgNPmUET/LxP+LXbH7R1OolnukZWfcgpiy3HAEGSwsZj9b?=
 =?us-ascii?Q?QQhb14ZaL1c0mAVVZFa7tNm6FjV1kmodiLPXhkRFncvZ1VpeZoNwsJcYxy9X?=
 =?us-ascii?Q?CHJGuo8Tn7bFmNwpQcn0NH5G5LKFZRsQP7GeCl6BgNyCwUqxtnCDEjAM2tcs?=
 =?us-ascii?Q?c9DdskqO+HMjZo8LeamCg2dvz8h2/sFmB3XUCJ4H05lvo7slDwryMS4bPQsc?=
 =?us-ascii?Q?2ApxskhJDFwXCyO0lrX1qd4vWWeof6OJNVki/7FWG0m00/iltLse9cB0btFJ?=
 =?us-ascii?Q?cu7LaW2CldbkhuSUXWlcnnSHLzI9X5Fmws+7aqvg4WvKJqUE+xbh3HZEzO8d?=
 =?us-ascii?Q?mahcKmjRWIBcdPmpEqLMskpAlNVq22kRZwHJBFBPb319ufO07Cq+LdQkf69z?=
 =?us-ascii?Q?fdEHfmg5aX9kIFPQj+2EnBDsTVgnogqSIUzOltZ0n7jJbXx7cCeL+2tliu64?=
X-MS-Exchange-AntiSpam-MessageData-1: zvdzohbJyoBF2XdX82nIsDjhKaJ30S+tdks=
X-Exchange-RoutingPolicyChecked:
	HPEiPkPIqFi/JXOzKGqqcCbrC//9yMzu2mzuW4zALf03n2A1fu7hCchDlq5LWVPNyz6h21HLaZZP3Gwsvo4j8trFfEvKzz6CxavyYKur8x8Hnqoi/dG3AEOYdfveVcO29dRJjTU6ud6YqKtDL6GP8bgYdvApykD8qWGXDWc+g2EKjrYNJamkoye7luh0DABa8EB+GZzHOx7j3Aeowed3KFfDjDCR1ay08qOaFrXO/AgNzoUqYkAl4GCC1XjY3YqzuqL9fl1AhoVDuxv96o+/v5Dnc6OkP9nse6flg2vMupxKnnkz+38LDci/Vqeo8n+zgIKTyjh17UzOzlsb2+lTlg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IV6aFv3pv4sSy5fK55wwY4Bm0t/dPZ4a9Y0QNmmATeyfDMfJdTDdM66jUYwfpsCwA2vrd/nX+JvzuM4SvtzvoshX7oGvm08ZZ4rxpi+pQXb27KMZNnYDXlGLDmDKwyiPJTtw78RqPAUdQ1pcxgPyTzNvhZODgNEvRbkOC39HAy+eZB+T25H+v8qJRg2pcomS6gdtTjys5NzPqjGw8gywkFmJJigC/beX+dbYzfzOQu1NDR5fS+izpkICjJmN+Os2ZdiZAc0jF5TJYo67ChptMleTyM3lg87L1jSvDDTRfbxfC7ng7WgL1OinI/QkSBgeEOReZCkbQ/FTdGwTb3PnWERqAOH1M72JXC00RGe6EU1nS9oiad2tCMEtmHVaViQeVACvCFsK/n3rVt+nUlX9Db7eMlFIEGDXplnVf4y4iF++0q72qpy12cLxWA6Dwes5NCZQiPtXdJD7zg8pWJqsV+ErO4FcPFj6a20wk34rqBcv92hTaOKTFXCBE8OXTOi2z1hCqIZbUCVa9IXfAdnY/jf90fmojWk+ZivZ7AqXbVZlK69PwVGI/xtxMjVQlEf1IZFKLXR8o4cMdMuL3lT1MBz5j5732rR1U9t7aGqduGbqe7Ba3VLpkuAnp92rWZoK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f0f134-5f93-46f0-93a0-08dea6bd6130
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 13:35:44.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7miQwzPr9vkHyjcmQ72NzC4IW6jZJ67m62jxwUxfNuF2kYoJ6ukP9VzALhggtUMQ+8tu/jtQiuuO0lL20pGJRS9Hl7S68KFBpapJHUb6cg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9142

On Apr 27, 2026 / 00:09, Sungwoo Kim wrote:
> pin_user_pages_fast() can partially succeed and return the number of
> pages that were actually pinned. However, the bio_integrity_map_user()
> does not handle this partial pinning. This leads to a general protection
> fault since bvec_from_pages() dereferences an unpinned page address,
> which is 0.
> 
> To fix this, add a check to verify that all requested memory is pinned.
> If partial pinning occurs, unpin the memory and return -EFAULT.
> 
> Reproducer in blktest: https://github.com/linux-blktests/blktests/pull/244

The blktests Pull Request modifies the test case nvme/064 to write with 80KiB
size metadata. With this change, I confirmed that the Oops below was recreated
on my test system using the kernel v7.1-rc1.

> 
> Kernel Oops:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 UID: 0 PID: 1061 Comm: nvme-passthroug Not tainted 7.0.0-11783-g90957f9314e8-dirty #16 PREEMPT(lazy)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> RIP: 0010:bio_integrity_map_user.cold+0x1b0/0x9d6
> 
> Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")
> Acked-by: Chao Shi <cshi008@fiu.edu>
> Acked-by: Weidong Zhu <weizhu@fiu.edu>
> Acked-by: Dave Tian <daveti@purdue.edu>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
> V3: https://lore.kernel.org/linux-block/20260420020327.1667156-3-iam@sung-woo.kim/
> 
> V3->V4
> - Addressed a sashiko's comments [1], if it makes sense.
> - V3 wrongly assumed that iov_iter_extract_pages() always pins user
>   memory.
> - V3 insufficiently handled the return value range.
> 
> [1] https://sashiko.dev/#/patchset/20260420020327.1667156-3-iam%40sung-woo.kim

I applied this v4 patch to v7.1-rc1 kernel. With this, I confirmed that the
Oops goes away. Looks good from testing point of view.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
