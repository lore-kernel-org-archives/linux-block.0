Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A41465A5
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403631; cv=fail; b=Mh7hRO6YIpDKW/q4aTl/AnnPJuEDZwuYFIkzyR+DnunNOhSM2urX8Ijdq85Dxj7zkB1NyB9A5/TPzqNRwHxMOhDD1yFyhUqT8VM/HfgQ+Z3u1PFUSslxNgjUTZTLziGsw5mIdBTu52utV2p3J9uuWxKIBELi6jdr1mHJKL1XQ5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403631; c=relaxed/simple;
	bh=07KownquVKCt5A87TraH+fFWiy6KF8fnRJVGFWOzR+c=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=gZu85EHAElaL6DhQKXE75ql9eRcKnELpAA59Noiff7F50lVxKTwaxwUQ81xvWnPGkpQ5BJN68ee2HsSqITZ2igKu1A+ez6HkHptFiT14YNSNUaI8n3lS2zil2dM517/X1lnISqMGwq5iU8vRgFY1Q45oHq4RJAacZQDzVxLIuzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ei27YjJ4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eooL1O39; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ei27YjJ4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eooL1O39"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLp1pf008701;
	Fri, 25 Jul 2025 00:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=X5Ur4GfQ6bXmrN6LII
	FQWFK1lWBPq8wOvjBDbZ8Vqoo=; b=ei27YjJ4vDMSTgHRdxPNC3k/XxhDgdzNSt
	fpeKqNFE1q5wgZaUIdUoShC+NXgIbTyozLxhDNG+L++1VB7+qigzEdmgBm1etgGw
	1XMn4BDnOqM9HIgYncJ//Ssu+Ko7lyfKw3umuabHhOGOk+VeoONYOssABLcAsKlF
	47TYLyEt6+Z8a+577dixdPk34gR0NdunF3BvX+1uUoVfaWstLzErB/SHhCh8xcD6
	XrtWgwRJn+3FsYPLpjYFZrBFZ+JfUH7PdOtm2KJiuXwCYePru8McHiPWHxE6JJ+S
	WsQQqnOiLWOSTQLEBip4Ki90/tTB5HkVDmmdDYZqKoB98BT38/jg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3wg4ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 00:33:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ON0I5u014403;
	Fri, 25 Jul 2025 00:33:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjtn6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 00:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNagnAAO4hFxLQK6FWOqArRVGEFNxbAMBJefBLtqCyzI6C9+JqnvkEn1lVc5kdKC7mhrAX5WSvLrN27u5A5dYLdz1L2I83bXGudo1CMIx2TFEEQx8E+pIAH1C0OB0ba1ERcVt1IF1pIXQBAzUdyUvXUaomoGMG5qAg6EN7qzrPnVSusbnjbGryd39WG7im2ZT1WW9Bsso9NYrTNesb29SzMM+irZRmxoO7z/MR62q0xp9boTcLySM59sENx0qh2jZg9T7zzcPAD9L7Uvd+lLRIrLUDP3VKu0DV4DiOXO4fu14u2LBBEKsVcxYTJ2gb5859Kxp9UK43rQN5VBARQwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5Ur4GfQ6bXmrN6LIIFQWFK1lWBPq8wOvjBDbZ8Vqoo=;
 b=nzE95tP5Rj8Vx6lDVkYJhA7My+eSm/wdE5DV1W3aMdREAJpQVihDHl4kcIlRPYV8w6JTRj4A35Jigl2fBwXSO2YI/051kaHysTMhWtb4uGVT+Lk1j9WKyi6QXxOLX56uuFofqgEgzzAxGB7gtgdKXVbPv1EKQEJ4Gw9Y3midKUkLs58cdBXA/HbfGZS4eBve75GH7QDjoTnDhDzJFkEZk85NYMgVi6cilEJHtu6Ypwl6/sNl9s2ralcsrOU/MlhjV3WbpCpd+ZAWFbxYbyk5Z6T1TqvzAfFyrk0tZgOqtHoU8s/fhkZXtsZljw/4mEmVdYLUYFoWR4Rl7tVzO+bbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5Ur4GfQ6bXmrN6LIIFQWFK1lWBPq8wOvjBDbZ8Vqoo=;
 b=eooL1O39B7Jd65mrpLJoBLREKKRfLN7KxTB9R/pPLYQDqL2lavhpuB+PFSRsK7Hbq2fvylAH+ibWAuAMJYvPBvGcafGHVhkfN9G+9exHZY6d59l/r1xk89Ey4/FLtqu7TNiVG/U0e2iKDF8Qs8+qM/HtFcovVjEFV+gJR38YZCk=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MN2PR10MB4175.namprd10.prod.outlook.com (2603:10b6:208:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 00:33:34 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 00:33:34 +0000
To: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>, John Garry <john.g.garry@oracle.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        martin.petersen@oracle.com, hch@lst.de, dlemoal@kernel.org
Subject: Re: [PATCH RFC 2/2] block: Enforce power-of-2 physical block size
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <b595ae91-1fb3-404f-8633-7d18efc71fc4@acm.org> (Bart Van Assche's
	message of "Thu, 24 Jul 2025 08:19:13 -0700")
Organization: Oracle Corporation
Message-ID: <yq1frelt8tz.fsf@ca-mkp.ca.oracle.com>
References: <20250722102620.3208878-1-john.g.garry@oracle.com>
	<20250722102620.3208878-3-john.g.garry@oracle.com>
	<f0605f62-0562-420a-b121-67dc247638c9@oracle.com>
	<2969b760-2f7a-4cbb-895a-097dbd88974a@suse.com>
	<b595ae91-1fb3-404f-8633-7d18efc71fc4@acm.org>
Date: Thu, 24 Jul 2025 20:33:32 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH8P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::34) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MN2PR10MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2e3305-77fc-4eea-3888-08ddcb12e397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x06IODl4wehkm97urZ3Un1MNpB+5VfZDAHE3bQ+kLVZk9nI9t/pkeChpeq3J?=
 =?us-ascii?Q?ejqlBag+HhsoPzOUhHbCTA6USb55MKl6sW41eZFNhcwE+5s7IUEM+hNHKVAG?=
 =?us-ascii?Q?AkWG2oYzYsvF8XNsraAzLhMxC0AoubZNpmgRUjaHwz/TIUfqJu/RRWQfQ9/H?=
 =?us-ascii?Q?ZzeV63RKzIWicBJAtlzFPl0dZOb8BiGD0JVvba6dDjRvBkbhfwrcitIRYpgv?=
 =?us-ascii?Q?XL4p8UX78OCGQhjn2OrxKxUNIV9bPUOlTbPHWwa57fHmIZSZ6gx0GLPfRoep?=
 =?us-ascii?Q?DXv4xxMuk/iZZp7P1+laeorP418BC/N0lwdM0eUrw5TC/YZ2lqwNvQGbyKcl?=
 =?us-ascii?Q?aG4MYrZHdReC3iW7bzdUWGNoORMC9FkvFJw2RLlJJMjEeMONklkCj9fNuwK9?=
 =?us-ascii?Q?jg/aKNnNBzm4x4nbprQtQIPePQNd0Q8B0WtF/lHZitUwu0T7ITx/ZYA+PRe3?=
 =?us-ascii?Q?ui7NzvBxEyBrLVw9QoRPNqOWXWszyG4Aq308TuPQKAWhdOC/UcnaM+ar0u5p?=
 =?us-ascii?Q?+ZxaQmMjCzRECjbYVQS7IWS9fa383jn7PTmBp0YpaQK3vYxj8JbKDMSTLss3?=
 =?us-ascii?Q?MVWS1tsefYYw2l87qXakiMLC/dE0Hv2gt9BlY+kMRy4DKiO5qvkaPmpRLBee?=
 =?us-ascii?Q?CBboAfn4baveXaB4gABgICddpzXhxCIaypKC0NxhwWBKQpvDKMlzknUkEUMd?=
 =?us-ascii?Q?nVkFKKR1FxhQ5NNUVzZDdGS7zZ+gkXvdRGARlUfarLMfnEMrzwI1i8/QfheJ?=
 =?us-ascii?Q?yyOPqLoKW3s3QPjUPsjvOOm8wDDa+nkJAQ1qvLxF/kP7yDpqP15iI5Wz/ChL?=
 =?us-ascii?Q?jKLrA37t6GASnaNbK/k7LCUi41EO7chlZnhNVDqvVFBdZMA67f+a4+mkYQ4Q?=
 =?us-ascii?Q?cpTO9tKzWIfABi4gTZ/IYQ5KvMp3EEEi539EakMUvVbifEcOokEfPs31a71i?=
 =?us-ascii?Q?s4Uv0f9Zul+jY4HChg7IvDq/x9Os6FWX7cYXI7hZHqAK1LNZmdA7RvGaWXQg?=
 =?us-ascii?Q?2R+PhOFNQ4mMilD4/JsIpRyRPRXq4tWX8S/eg4/4W7q6VQNrq5TCUZyI22mW?=
 =?us-ascii?Q?Bis6CBlWvIlqRlzVhX0JMrPI9dYLiBGAVWO8dtH/tplGtm494f3Vp8dfPJEX?=
 =?us-ascii?Q?/0zdpX5zDg8B2Quq71bvwrhW9S5RlNKSku34SMzsvvcD8lO79So/psxuOe5l?=
 =?us-ascii?Q?CE1+wrnaglLCtUMzFudQKcQVJ207A9TXneyQ8YMNet+TpTqZ+cT22T3W4wK0?=
 =?us-ascii?Q?4K9CoTzp26Ur78dl9NuzPbjyJwuypLfj3fbAG27GT9mWiZSp7GFOVcZhSNpO?=
 =?us-ascii?Q?vwv7DqqAq4hQV0IuDKW/uzNc8yw/+zKKUqp/P6RsQ+brmR2auunHGFUPa9CE?=
 =?us-ascii?Q?VMl5S+lbI/wrcorJMBZU1l1rHvHnhd4IXHsNdvsyxeTvLY80tOsy5cqaujkZ?=
 =?us-ascii?Q?TpCl5RGyo8I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FHfSUX5zm1SGosZ4N4iVugOmEVuD4XEnQdccsF6kPMkdQoB8csDv4cHP4uSZ?=
 =?us-ascii?Q?EvOv9Z9Z6MqfX7atbHqPBy5F/ALPajP2g6y5owBe1ovQ6pdraDoTv1UjRzuj?=
 =?us-ascii?Q?tFK+DKgZPdG54QiC8vqEtUiP5VzP9RyuoRGsMpk6CcHSKdW7BxO0jyFrBqlB?=
 =?us-ascii?Q?3zEi35QGJC/PHbm50zSNl/lXFbwCVjscppj92gW+0PL9j8kQ+sjnuCYWg5de?=
 =?us-ascii?Q?YnGTHTWamBGmKyfnYmQQGl7e5+jyLgM6a5xLkyesylLyGfpYDk+ic4RAPeW4?=
 =?us-ascii?Q?s9Cg+0ERSO/p8uIvUIjVNbdNP5QwNOL+pex8tIFPtzHfNnkWo/uYon3+6eGe?=
 =?us-ascii?Q?PgS/f73K7EP/fPizSP5CK7vAVgr4mafs76F5bGyN1lpOdrHwEkp1rseWexE4?=
 =?us-ascii?Q?IS5M9GZ11CwfkMJ+2EqXwrdIGIhOePt1ce5gsboKY5YDuYqloqFOwwG7m9Jm?=
 =?us-ascii?Q?pS4PpfTUhdnDezL32kRnWofi76mxOEbwBRTam5A0BtVe5hCtf3/3yhQmVHK/?=
 =?us-ascii?Q?SLUZ+GVucR0xQk7SkoTsF1kgHEQhW9ACsZe74jgGf6mcpDVBpC46gyxyouZB?=
 =?us-ascii?Q?QQLlViKLFDsEQzcFVXTy8egHjfsQ0MZZtMH6k10rLiV58aGsEzrfk92L/MzF?=
 =?us-ascii?Q?r34mCVzmnv5cp4RfHhOMET6I/SZVfR8Eb+zmbcr73vJvkd6dS7ABeaZWwelv?=
 =?us-ascii?Q?xkzUN293KvNUyzv3hPNZlMYZOf7j0xe/jL1ouBiR56/yaLaw2eHMKFF6RNk1?=
 =?us-ascii?Q?3YgEXdpjZiKY9+HgPeNIWtPZ6BvCDzPjGpQNsZ354dqLnWSP9W/i5nD1U+Bw?=
 =?us-ascii?Q?qyrzr1MTY1p/6fFW5MoOYYjpSeH3AcdddZQksiiCAzQW9oH2VQpW1m5DjLWX?=
 =?us-ascii?Q?f+ceFdrl0ftblFwke5FtViRgYIOMQBZdiDXfdAe3LEHIMiyMCzYj/PGPHy/o?=
 =?us-ascii?Q?M8Knl2ZicfHvVrlwsfQ8ADVLWs1H5NHr+pcXuNnvnPm7CFQ+aYJtqx/AE9fP?=
 =?us-ascii?Q?gETu8kJO3hLV6xgl/kKquruxuueHis4wlBtRQG+AMgJfXKv01wD6U9hU24EQ?=
 =?us-ascii?Q?451Vy/zWd1N9ZfTHoWzmMxCi2VUSsvIBTfWNPUS11OAswWxJCLi7WXCN5Sso?=
 =?us-ascii?Q?Amj25j7e4tLpvK17aPCEKpVytP4aKZDAp9K0jKOSle41P4jkLl2EXOpLR9m5?=
 =?us-ascii?Q?w/qrL4XrTUtta91JJVmiukJqCwUaxtgAi+Wbae7Bl84xQ1PtGCUPCfVHE+mZ?=
 =?us-ascii?Q?u2PRtnBmsiXg0SDD7RFmsfVKie6+QrbcN+zfMfT3ybCcpaDPJPzROPTsZ+EP?=
 =?us-ascii?Q?9/wh/xnB8/Exw2sMfYg1EPQnTXWg1QCnwQccJUaiTwn0fVUFRU58wRRhYrSR?=
 =?us-ascii?Q?jWWTAs8NF3T+mYpXtSjVq1dIrCoVq0RC5/2IRteduBQhB9ijrpRgqfUE6YEK?=
 =?us-ascii?Q?ZfgKuYFCgglOSGmZZFS+l0Ib21NLcJKPS6sxw8gUaxj6lt6KCPSY02I4IbNi?=
 =?us-ascii?Q?fGvN6BU0J6v8R9gBQbfuR96PNhCuldDm52DL4uMVKCQEgMNqV6fTOgd4adgr?=
 =?us-ascii?Q?BgVXQPcD8Q4hZblXWGv8gRUC2Z31UqY7RNePR/0R8X2UqDFf5yE7W7ymtlEm?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gx6XZTHUz/ES4eAio3VONtdpBlg5vRJ4nZiExLr+TGX8Go5tdw0+7w5FtVVRw0Hxg1UdGJKkM5EfYWvSYkVycxDzCP+3DF/ia5IS7x7jm1oZr1rY9ocQ1B/pcUu0k1Zm5WLj18PuzwOvr3MM2emuN5LjGGNB/Jrd39CNgjlnSTL5iFIoiMoLspe+SPxoyp6UHDj24ZvWnCMPhMA2IW8eJ+UM2WP3Qo/glZnrun5Ga/ykBIAP7UJbZ5upWZt6wIJ7ovFPTtox8xQizQryoa9i3xg9xBxIGwAj4Vcu5DF/21igzbmTRHlh+8VxpyIOUrejkQksCo+WqtqWpK6ylSlyHY4Nj9+3+sCAcirfwOscoVbcF97cU7FY8NERoeW054GFAwpWqhF+NX+vlrfqwlys6qFVE4QbRu9NxEYG3C9Uhh6rZszUfZp3z6mjeJ3fjG11Uess67JfHumLTHO5p73TPQTDbDqeuGFBNhypZUyHNpU4KWGTqitIZWGGAbeFCEGa+a+Il1PoVg2xyeOXDay4FiiViMkkRiW4aa8qqZzwsYiJCf6hYQBfH0GBpctsL5y+Jd7gS5vZP7Cz4P4bIVOOOjBaXTwBdjS+Nr9YJpb6TZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2e3305-77fc-4eea-3888-08ddcb12e397
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 00:33:34.6190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taWLoGa6oOBuLwV11UccQH4ZdPB9DSXvfyX0gsSdcbLyFysqf1Qps6CfUcDUENGnlcVliG0fJreTNMeUaeXuT3+G+Xa1eJ3MV0HFb7/A7Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=660 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250002
X-Proofpoint-ORIG-GUID: YTuFfeUBqC-0EA7i7d-t0IiOCoVAIugL
X-Proofpoint-GUID: YTuFfeUBqC-0EA7i7d-t0IiOCoVAIugL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAwMiBTYWx0ZWRfX2fecahs24lfF
 NUCCMAYYfSHWIFZOOZzVwm1na59IhvTyE1PndvkLormLJiMvxFcOF8Es4X82D7oxBypFC2ffmCI
 gG9rfQtRxWSnLZk/nQ4yu7Cv0sSup7ld7wEBccd9N7uv6+4+43grp44XXzQsXx9tK1GPu4QGsw5
 00LszLs4uGRq3l1Iu/7gdrXJtDYcgMw4FOpSYi4S9G1Dn54AmFpREt5J087tTXY+R1ucj0ywOZh
 2viVL7kBfURBXsiSOonwPPqvC98Lic69HSn8VmPspdKZPVRfUelZrODustb3p8OzqwmGp7gW7zp
 F8nWzlTFusagdXYr9dNWJq2TX6u4riXj4KIPJpGeKXg93B302vDERTBvg6BbHgZuvl7/syav7eY
 z/hZIloHk1oRbYYWlTx9gcFaBmHzZvEgYE2ncwPnIcEqADStCXt995A3MMccMIAlTqKVFMTI
X-Authority-Analysis: v=2.4 cv=Jt7xrN4C c=1 sm=1 tr=0 ts=6882d0e3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=Y_2mfXcCao6oKECiFpQA:9 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12061


Bart,

> I think this means that the SCSI standards support physical blocks
> that are smaller than the logical block size.

It's just boilerplate weasel wording to avoid breaking the seal of
compliance for any devices that may have done something like this in the
past.

> However, as far as I know the Linux kernel does not try to determine
> the physical block size in this case. As one can see in
> drivers/scsi/sd.c LBPPBE == 0 is treated as one physical block per
> logical block:
>
> 	/* Logical blocks per physical block exponent */
> 	sdkp->physical_block_size = (1 << (buffer[13] & 0xf)) * sector_size;

Yep. It's the only sensible choice. There is no way for the device to
report a physical block size smaller than the logical block size. Also,
there is no way for us to send a read or a write operation to a block
smaller than the reported logical block size.

-- 
Martin K. Petersen
