Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ABF46EF96
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151521; cv=fail; b=Qi+eJzCJlE7OcPVV83A5mmoOkf0fhFxFr7qI79na+YHCEzA13KmnrQNHVmshC+s3YmBpfqwTBX/y2OpV5zej88m7VioqcWOFITv9CbL+51yodGwgFqLeyv4O3hxotTxCvpq0qScMmYfWEKhVEmP0qyIWe7wBfQXNM9rFffOYBwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151521; c=relaxed/simple;
	bh=3s0N8bnjbDyPPzN2Wxl7qx1bErnzihQ1JsvnVb1y3Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jZKR0D99fv+GWrTNvHgGiVwKExGveBkRjDLtPhUp0at3DObRLpJKF+sg251L6zS3ZiMJeeFE30edfk+AM7YfSjFUNVwWvQTLf/6wNeObLu+0dpoUZHYybq/+oo4dpZZYn4uSpnORPR7JYoN72bXXRCBO3AklTuWT7Gwnp68uFyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Q4jMtYKf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=x10p/cFE; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q4jMtYKf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="x10p/cFE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1790151519; x=1821687519;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3s0N8bnjbDyPPzN2Wxl7qx1bErnzihQ1JsvnVb1y3Ds=;
  b=Q4jMtYKfr4VsmrvdsvkG+OWweXgutHRMhIoJAcDShxd+aX1+XrTybpZM
   LeIlB3paxSevaP2FyWRUcFAOM8b3r2R4DAtgGDjwCQihlA4Tgu7TN3UE6
   k/AZUaaZ5+TMxgj2EN204jP3bluzS2E3zPM26fYMGKrhGC1PGjvNfm8H5
   Ktk0W8nJ4ERFO0SOpcjQSnNx/TEcXV7XivN38awjwUbQ5qY7WiCXO4CWO
   Fh9+NAEmQAyuIIvLot3EY/IPqVJO3oeQ5MhY8BtCD9kiFuQAeBSCjf5v8
   vsxTXDBsA6gsoACpw2q5O2J9H+6JeSVykMN7EtzXNT6yi/tsO36XrrnBh
   Q==;
X-CSE-ConnectionGUID: 46jpaBeRSay+W7yxIBo68Q==
X-CSE-MsgGUID: 9Z825ZY9SoycW5ngK0eTDw==
X-IronPort-AV: E=Sophos;i="6.27,118,1786982400"; 
   d="scan'208";a="152129292"
Received: from mail-westus2azon11012064.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.64])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2026 16:18:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CH+O9vdVQzfnr3ZBcKWqqoTDEBafnI3P2HTCsB/FGC4eVC8JoTUvQ+9a7AKZTIPGEPwC/9XR1xHXwHlLR/sXk7Mfj6EFMDnMNuKddwB+KFznAYCcnUqVFmU+2jHl9uLSa5mdo+Zoq90kT7t6t8Vl4r9WT3wRNi8OIDKm7IkGjrqlAxA94GxGXvKwqPqhMXv48Xi7fdtR9nAF4oE4xzNvJx9jVHP5/BVWLlQ5x80V71S2CEFMeHqozIHF95eIpOtgqeGlz2H5adD5epxdrkjBSvzCuMEGzYiLDRrv18FRK1AUjdvD78GGhR7A4hvavxb3SIAElHhGe6YrauAYEYdg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeBImlZZbZyPlnCBJlQX3Hov/FfBj3b++SSrH72Q9D8=;
 b=DN9eF5sznOuJiOksuRc+b7p0EepeeCqr8bB0RFONM7GsJrEqyezg70cMPAZNyUATEjHjFHV7OjHkcGr8/dLO3yqqXISeIkuO2topzfIsZBUH9sBgfMqkYoumOu2t7jdCFql47uLJvh3ZUG/fmHoA0/mq17QiAtpKhM6MTbxR19fhswDpBOBVqlzvy+6mJzatel5Zb75mYR70he/xDrmuBNYnJxuIaZidjbefPJMFWzz78e1a3IWOy7Jri6+0xL7t+UNxaA9EZSgtKcEnP7JWcSbOHs76CFr1eEIihUnlV3OMoj+9dBn1e9IWZSnnWKh1+e52weZWxC5anTeyx2xR2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeBImlZZbZyPlnCBJlQX3Hov/FfBj3b++SSrH72Q9D8=;
 b=x10p/cFELknlY+NDYfC1lI0EemA5bBKeQFxzkDnoHJ+Eq8BihDxngi+hQ7fFsBkOvdBuVY3ES4Ym8FfnZz46HPBO+/QkKj2CRolTQ+ByN0gufT3SCaxjB3TuPBQKVxyhpIXmz8CkDkdLK8Y9px1SDbXWLopkC54IBh1/v1O/ms8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH8PR04MB994189.namprd04.prod.outlook.com
 (2603:10b6:610:32b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 08:18:28 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 08:18:28 +0000
Date: Wed, 23 Sep 2026 17:18:21 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>, 
	Jesse Taube <jtaubepe@redhat.com>, Randy Jennings <randyj@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>
Subject: Re: [PATCH blktests 0/5] nvme: detect ABA ghost writes on multipath
 fabrics
Message-ID: <arOFG9-sM_GrrbQf@shinmob>
References: <20260917020752.1672578-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917020752.1672578-1-mkhalfella@purestorage.com>
X-ClientProxiedBy: TY6P301CA0005.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::14) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH8PR04MB994189:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b5a279-04fc-4c70-3926-08df194b3edd
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|23010399003|11063799006|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Tbb6XQXp9laKip17MIC+spC6LyhHWVzS1MnWqs3Yu3T7ejmpzMRc7s6X3LzTqUpi59RjKViw/Uc7jbmjGjpId3CnLqzG0IFiRkBpcHSs7ef8tkxtxJHz0nhPYTFEjU0iaV5/9tbUJsvk5kdrKIfe7mpxmFSW3MuFcEKYZgaGWRXCldYgUGxW9j+j6eGfMrZ+EkH7a67DpDO/wL+EMCHVidGw3AmgtbYMRr3gIOEsR5LzhMIcoLlGNc1uBXHWRoRbpxIKzP/PW8ztYBVUHE6RJEQUCQ/p++RLTdKMX/xFS5dwh3l9yEw8bhbp5nQR7Qs6T1RoFaE/yO52K3pohcbxJ8Fvc8Q0miQ8CurX4tanVjI31OonYUYJsLV143bkSSTWwg/5GdxG7vI5ntUjETrATXRiONB2X3OuEeFR3pQk5c8fyjb7xyGT/s9YsrTaF8Doe/g3qxCzFNT0O7IhTDuFu8bJKXtAcqBnrOBgnPQuYi0xQPMtKHMRYssfJL2miMnQj7XyCNyUSAfVQMl3pYmo7RqtAvCsGf7PcdvMjFfLA1RB62i8TIw+URwM/TkxowII31gGrAlIWRcFlFT1o4jELIGRKauKtUgc7meohTb/DJ4FqjCPqT2md4Sb6w+8/Mfq/Bi3CKTJ+8Ga9jXOFkUCP9w7fHV2ooW3e3PAgL8wn0E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(23010399003)(11063799006)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ejBrjprPjpV/aYZ5jcI3pqXGxU3cvVvxw7xffUjNzAoUdLkoa/Wt+7bf4Uz?=
 =?us-ascii?Q?yDor/VnTKG8g7rKOtJLaxh1kq+HdYQtwc8WS7YHG6nmZaGqwAhYsMdRFNJRe?=
 =?us-ascii?Q?50qCKLY+iQfR0sUTW/BH3sa853cTze81dCwjWm/AdCnmLEVEG1m5LdlDp0ZR?=
 =?us-ascii?Q?2uX5GWbAFzBzFUIWmpby1TFXeaqZd+oAaEZbHfz2AjiSrKcsiJiG/rhUIVva?=
 =?us-ascii?Q?g1jheh+8bJWjvZ4XFdormVuDx+dBDOLQsMS00FbMJnlp42Ju7fenUDDCBDTf?=
 =?us-ascii?Q?ggfCph8OaXaXoj7i04NaU6COfQtLlScHP9N8X78/QFVs43ZIQq+zHoObx8ht?=
 =?us-ascii?Q?RTszgdyrioe3ViN1wmGVK/v7gyVvuYyJgxzfhwRgIlXCMTLxjYVWo9NvGLbF?=
 =?us-ascii?Q?PrVR4hz3p8MZcar9hItpxXwILinnMYz8RNn9QGSaUl1/C1FCDauZg5nKw1+R?=
 =?us-ascii?Q?HGiATcJl/OjJXOWinALz2LMavn+VidbDcvmccOtzMJG/1WbmCy4gmGXKz8Jf?=
 =?us-ascii?Q?ojofOwSJW8WPUx5OvvuSZAd9pK0q8ftuib6KzHdt5D45mtKxinUUaMx1yNig?=
 =?us-ascii?Q?FkO4ow9bVrTQVZbUFJVOvytb7rUtVwXBSdjztsokke+lbCDSZtZFwtM8cAFY?=
 =?us-ascii?Q?zr6L0xeIeaactuAk3AGB2P3CDr2v34lthtEd/N1uaCoCEq5jqgm0bH7My/40?=
 =?us-ascii?Q?DWM4b/YXvDbQpZqGHiVzCxq/+zTPiP6t6C9dNeX3qVLxH7RNCgEuNLrNVS1K?=
 =?us-ascii?Q?YZ/EA4k2t5kuOWnMawx6uhjzw9fx74nS3UpYxUtaxjItR87DIIZd5UKbjtaN?=
 =?us-ascii?Q?4RQpEwqyBfIKV3tD7Oj+B7f8dcAibdmMSO/ESZ1FuiyyINyie0ZH9LCZodYB?=
 =?us-ascii?Q?AGDjOoxV7H4rHDJ+TEQ/3ZHWSR8pAAMrqCJDSiZSrvZo5wrR58usrQ4cHJDq?=
 =?us-ascii?Q?P133WFfJZakYBQu6bGUVKNKi2kEkKHfjlEua6ZNJfgPjA45T0oW+Gx/QIKsx?=
 =?us-ascii?Q?BhcQ1th3REEqDS1FuC+LjJ/ZBjpY50+LHmbkedMDrbHZsBiv24MzUZCcJLx8?=
 =?us-ascii?Q?HSbbjiRjIg8UhTCALqIFLzO55UEw20OJGxErlFnEPZdQlss8baeU7kP3FIkS?=
 =?us-ascii?Q?wa/F1JuOl9aRk4LV/UYYu93YtG1u59QFlC2/mEIDtgXxvdzInhQZuVoMIHAS?=
 =?us-ascii?Q?96FV6R43Lzblte7Qyo2eBCcIpPrUT8IWxIjNqj0jG+oPflhJMpzfIp9aBtIU?=
 =?us-ascii?Q?CUxStL45nTQSHtVxJdnp/x8KGPXlrs9YyTdB7rCCorDmRERCEbRn+rGwk1p+?=
 =?us-ascii?Q?8SHxKx0sNYwWQ+g4dbjF4e5HpvRqEDbxAJXpNCVAmNT/iw2cnYfSD4Qc1bls?=
 =?us-ascii?Q?THqDNP/YP4m8Aal/dk8qxt4s5ETHDw07XP37Ky920SyCsXwC8dWh+9b2A/TJ?=
 =?us-ascii?Q?j1yxnDdcgicHmFY+bW6/ScFvJvDCa/oZkjSLX0LJVuhQsP23ajW3NTC9pNRz?=
 =?us-ascii?Q?FERs350V6o5AVb0jMLPN9fl0S8WaHdrbiQi2a6HbrmfOvRcaPDIKoXHtF/uR?=
 =?us-ascii?Q?UJcWstKpLAhA5szo7lrewG5uEcKq1VEXoTBeGlh9L8bwKaQSBrBxvJo8zid0?=
 =?us-ascii?Q?oBCO8cAF9Y8NaixvHtJJotC+U/aMRkRgZtwgGZlt6c/UMhyqhMShHDCqnwBG?=
 =?us-ascii?Q?NyY+GtygyAHIaqr9GdVbqAfLK+z8Tdsg15Pz7JUiQyFnyKy8xPqO8WcvEF0a?=
 =?us-ascii?Q?ZUr561Wp1Zh7MtmmIFo0UcU9c+xbg3Q=3D?=
X-Exchange-RoutingPolicyChecked:
	ODsTWPCUC0ka8hhnKwBI4VQ67lK71BbSKK5prbeFMNNYaBaj6mWOQlqAO8qTDaM8LRmZvcDPqvvn7ZWzlZ+UtyJcDVOVr1UiS+bUauqqjIKN2hPqdylg/41hx6j/ire/o3EYZdyC3eKONheG3cs5h1VIbucl5M3bX+K7IIVuiJ4Wgm2MVxZMbFhR3B+wfMp5Ps3ZYR+yYMZJpoECuh07RcCJWl/EkmexoPGd25yckhw5264o1gWoDrCglDOikkGXA6lSLIl6aXhgBMi42V/zClqHV6OtPkDwliN12Pw3bIEddR2ugvzdA00kTrcXh3GazFOSOmXJDGkbg8OvgSozdQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1x8WmZ0Blx3MgbsxKXP88xqpgH360D3ZD9GEPvdUuZ0RYbYivJMGJ5oEEl1SE88yLC/ytzDujtfxBCM3re7ZqUnWE+69ok9NLfreNQo30ey9x7JG5n3D0yE7AH8K+AaW2sUmLdqYGqnaGsi/Uggarue6YqjWcIau4KOkezcUs1RO3/rvz3LVfcsm+Rbe5LSXGjFkaOmsXgS5uLZnhceIo2eUUc686ZupYUNRCm/WmkKmyYJk1gFDv1/nAnKk5mccIAzbe00Anj0THVJqMpSQtHpdyRa9KeGcH+qhzGy406ZKBS9xT2DsyHjAy59pfyPCl7KZJopqbCpGUwq8R0NMiVWXRgSj2JJ+avWSKgQmHG2CLrcMHKEhIP1NCtlrQoeFh9eUMfB2wRZoOIPytwbflOmiXb/UyKqluGX3aUJ5fpDVLZywlfMPARvqb+2lGWZUe6OkN8wnq2SafFJDtyKfZapF6cUMeL4UvxEVru0uy6NzweWPO3eRwlVIsqBQDfZw7wfGcXW5TK0Dmlal0XT739bk3EssIPjV97TwFqKV2QnByG5f+KQ/LxV+bt0S7O6KEMPtrUFsrrn7yfAiFq/Ej1Ad54JzprSf/iJNdywzm/AbTuJtn1KPKZHLrsx9xh3P
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b5a279-04fc-4c70-3926-08df194b3edd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:18:27.9286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOonJvpAkoDuvTkU6JCi4VncCgI4GXsrNjXvD72QY09yenKKavCF0h3xaunsjNU/8AP1p54HnbwFifgdncnSbGPS53RztEXZi02ZcJqhEzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR04MB994189

On Sep 16, 2026 / 20:06, Mohamed Khalfella wrote:

Mohamad, thanks for the series. Before I look in the details of the patches,
I would like make a comment below.

> Reproducing the race needs an IO that can be held at the target for
> longer than the host's io_timeout without being failed. The first three
> patches give miniublk that ability, since there was previously no way to
> talk to a running ublk server at all:
> 
>   1/5  adds a loopback UDP control channel to the daemon, served by a
>        detached thread, one reply datagram per request
>   2/5  adds an INJECT_DELAY command which delays a given number of reads
>        or writes as an io_uring timeout on the queue's own ring
>   3/5  exposes it as "miniublk inject", which returns only once the
>        daemon has armed the delay, so a test can start IO immediately
>        without racing it

It is interesting to implement the delay feature to miniublk, and use it as the
testing tool. But I'm not sure if this is the best approach because of two
points. First, scsi_debug has jdelay and ndelay options. I wonder if this
existing feature can fulfill the requirements of the new test case. Second, when
rublk [*] is available in the PATH of the test system, blktests detect it and
use it instead of miniublk. I guess the added delay feature is not available in
rublk, and the test case won't work well. What do you think of these points?

