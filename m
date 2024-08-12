Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7860189B8E
	for <linux-block@vger.kernel.org>; Mon, 12 Aug 2024 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490288; cv=fail; b=AAFEAXFNWLXitLJsP7v6dvHZHFW1ulKumK8ZME/R+yXQ79cFRtfaFbT38fkXUJFXR2zzsDj930yzRw4eZh04jDJaJDx3lP4yLNSrHC9Me3hgQIGA+bG4jQYNVkdf54dILA0fQTNPiJVWgov+JOAIPrlHx18XClj77rJua+0hdck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490288; c=relaxed/simple;
	bh=hmSKNO+iDoLE6E+Y2+iNCNs78PwZxJzEtYEVC9XOR+s=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=FVLZ3999aJr4RpqzQkMOXQUsg8MNZvcewUDwy/jFWVCkICu6TIrlVAB5Z0rbC7qWoGmtb/24lZHC9Ae54o9PQ/QZMYEf0c45HS3zJayLTBy9MDWxr1yKuMzc2gxDN0mUnHVFWLLlJw1w9A70Utu7JzTy8gWv/HtGSUfR9Ym1rCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nAySkRyj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YbFV11v9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nAySkRyj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YbFV11v9"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CHXxVo018577;
	Mon, 12 Aug 2024 19:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=PoRIMj45Z5fzAg
	4lkiKjHHvzGn3Vb4rRzx4FDHAv/6c=; b=nAySkRyj7jYYe3ACv0Gt4ah92lMWDi
	1GVKskR6kN2zFCdY6dKHXlvJ4iZypBlQBvBp6sb6Ab7nDHNuwkgi4AToe5NI0V5z
	ELJudIhMjCY/VU3WomSwdj7KCuhkPjgkpnakxC0qPeaniAWpH0jkzOU3ZMS/Ro28
	ImO6cQUb76UQh86tTWqhIw9WAyRGZkvE74PWflRHaYJOi+qG5D9LFv4ut6N9Vq1h
	/Wll4PEHsBC8I5vInZSJXjwxhc4XCOBYPd8r4LCQch9+3NjtPBvJ+jcoQqDs141e
	c4uqdWyLq4LxJdLgdrc4JpfM/3CegOBYJo9AOhDgk8M/n/OODHpCwXmQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0393dj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 19:18:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CIBsuv003447;
	Mon, 12 Aug 2024 19:18:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn7hadu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 19:18:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvHT4kYp7y79xh7givYfsAiT+dqrt27T+hw98G4UIGW2AazLHt64Wi4fwRCTgNrH4yA8+Y3fILVEz/G9VG9E3KQL0YPVp/VKn0DJnjEZVrzk7aE2cbLC4Uh2kIhCwMhJXoQx4cowixfnqTM5rSX6A8PvV0eZXxbzAmXJnw78YmoQyivFdw0QY3zavmuRa9uIzVXP3du/E6jeNpvDCpq+O90z4G6mU86+HHQgXYnH36IGLcKg9awj6oFKOsK95/KiVTz62gCzePr5agZ8Xtw1BAa3nEfz7ox5Byo37ohKlvWQAwMxlEvA5hHo8qwTzHKhjjvjI/zIXGf/UDDjU6Y99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoRIMj45Z5fzAg4lkiKjHHvzGn3Vb4rRzx4FDHAv/6c=;
 b=MOLTZwBcoJk+7P6tfPLTlGqRI8zrBR8f/ETXwpzZ2a8VMSYLXNxqzAzxljqXONhC6d35aHtuiDCSM23BuVjeoqtuEF/dUdB97CXlyWJ+XCew3TmyIZfJbXplWxtT/qCrg5h0KlHBbn6qlKKgz6GwinM0+71hwqHxFDYkEW6sNfD7LiyNnob/S0UQOlFu6YBgLbHpqvXbWyq80MNewJhwzX/5W6z/0ySVDJexXNc+lL9waeElzPi6yF2i1ldGtCOzn7p3rJTEjBCh8Qd0PG5b7ctp56VXMSpkZRErg3odm8VLu0GsVG4ycG/21tGnqkB0e9V8YA969wQumCI6n7L4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoRIMj45Z5fzAg4lkiKjHHvzGn3Vb4rRzx4FDHAv/6c=;
 b=YbFV11v9NUy8GrEJV2hnczCL/dkPn/TYJqmpgvN/T925G/9nSzSmv/RPAmPJDpCElrjwLm2ncVOBefNb6wpWShXggBpVqyHinMCmqas0O9beJl3xIY2/Mnnf+zJGlQBqdkS3g8OdWpQYR6UfJdmTqGR9+BE+OkuXMQp5dASdXxI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ2PR10MB6989.namprd10.prod.outlook.com (2603:10b6:a03:4cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Mon, 12 Aug
 2024 19:18:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7875.015; Mon, 12 Aug 2024
 19:17:59 +0000
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: constify ext_pi_ref_escape()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <d24611b3-dddf-473a-903d-39290db03b11@p183> (Alexey Dobriyan's
	message of "Mon, 12 Aug 2024 21:12:10 +0300")
Organization: Oracle Corporation
Message-ID: <yq1o75xzh29.fsf@ca-mkp.ca.oracle.com>
References: <d24611b3-dddf-473a-903d-39290db03b11@p183>
Date: Mon, 12 Aug 2024 15:17:57 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0198.namprd04.prod.outlook.com
 (2603:10b6:408:e9::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ2PR10MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df96019-1c4b-439e-ef46-08dcbb037a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w9bngn2vVHmNDmqFtu0XLr2fobyUUlUZCajPyxHou1fz7GFUALLhZRNoutBc?=
 =?us-ascii?Q?4rKxn9Jen49k0itfEhBu1APxQb8jSwrjalX6VwUVYrKkWWXChFE4ST0kunlq?=
 =?us-ascii?Q?AsMCvaxobkE4/vT2lBKzjlijGHUsDZsgob2g2nzrodtfhubvVJ77sMm7n7M6?=
 =?us-ascii?Q?AvdXoC6BMjZf3LuPeI5b71ZV5ZpjstwAPcO1KkHI7gPgTv289FfbjeGhigVm?=
 =?us-ascii?Q?9uaN4ZFpV/MmDxKsnLRZ7GJRpCYrxttMdAswmmn5JNhg+oihLdt7BGxTlqcL?=
 =?us-ascii?Q?DiVk6ELl9GV637VnY4l85hGLba0Keq10UC94S48Cmb8dtVqwaCKPkCowXqww?=
 =?us-ascii?Q?P/6dDI2WWCUeSVAGI0yWSSwYe5Y5dCsdEAcWiosR3Y+ga0SzpMAlkRjlCHH8?=
 =?us-ascii?Q?gmZuGZDOG7I/3NBrE1aTQTRUI8oNCo07+L77SZhag3ikCj3+0oQ0Ky1aofg1?=
 =?us-ascii?Q?kFIbQkM25pqhF0gih2D1PXS1YUcHwb56CmwKMsyg/clF4PLsJeG0RcCdmq20?=
 =?us-ascii?Q?gWmTDjezjfPugezwEuM/0KFTxS6qBuQPc8/9BjDk2FCoB/VnTz7u0aOWR+q8?=
 =?us-ascii?Q?DOupsLSAjLgjskMFAG5O+nYh2LMR5HheU67e3q4OlKd01zJA5hXTE44SFz5m?=
 =?us-ascii?Q?mtAXelXr7456TS97D/VEVM8Z+A06Gj1ZXnEIZJ28LhTaNGCyi1Gz2H/QlE5/?=
 =?us-ascii?Q?DdapuM5hcGM2WlHLzZNDPBkt8kuFxIl2Y+RysFzHZBWis2Tu8rduA07sxJpr?=
 =?us-ascii?Q?A1J4umLfq62F50GDU9+TpRe0Y1d9Gcj6+VMSyOdWp9/hlQTyGtyn6QYdK7c2?=
 =?us-ascii?Q?sRbl3CO5JoDETsRvrP7COyuiOfy5f/hdkJ6lvsN7FHvjMtiT7AcFIkAmw1jS?=
 =?us-ascii?Q?DW0BHuUMfWg1cgm0kZuM3t9elIdchpgxsrXhhoTnFco/1Lqu2W0RooLUPfWs?=
 =?us-ascii?Q?e1w2ZUyfRM+WMbPrSAgufxrX8fPH90OULkDWNUNBE0V1opXMpNT9wf+Cvsog?=
 =?us-ascii?Q?2FtnuDfxuaeIZUPxXlLs/e7G5lhIf5RwMgZVfzQkrS/8wOLCh/WhLIZxsjHe?=
 =?us-ascii?Q?AozfOTZvMUZ19gbBWtWKA4n8tEoybRrIbWmkvv4FaDqvYYhzrvirOxw3orvk?=
 =?us-ascii?Q?n+IXVSlHM/stegy7SY7jFGCKILf0BlWt78CBod2itPwMR3RnOzNh6Z+yDOA6?=
 =?us-ascii?Q?QofKlHeCtJbsGpEZo6R7w9VBtulXjFqlSvlgBKTmOxyVEw7H05umBzKrXceg?=
 =?us-ascii?Q?t+lexFG2b79kDiPTP3/3m2sHLtcf5WJYLiNnwCgvNmtyDiD92Ip+aWq2ibJJ?=
 =?us-ascii?Q?H9Odvgp8TPE9xPdUEc3HLRnOrHvpMZK4qbURP+pBJkpSTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a7fQpxyk4CGHjTnk1OYKcFESMQj9uhl+crKqbK+KhK5vH9kB0lbMJv8LebHT?=
 =?us-ascii?Q?p3wEoIY0fwMsgIljP3Y33N7wj48DY7ZAZJv5ciIIvU4O2rmTwjAL5BuhXMxv?=
 =?us-ascii?Q?C5AgDHdXpa54bige+q4tEPecKzBqUin96SQhVlvQ/ZhUV/lWxuFrhSOBFIrW?=
 =?us-ascii?Q?8bYoOa8sT6fvlzEiM0QEyy0egVZZBvhLG8Jr37BFzkETDzhkg+7XPRGI4F+J?=
 =?us-ascii?Q?uYl7bx8ElG9NDVXF9M7zXFA0T3ezICFTHTbP6IahvT/p57p1vxuTRJnP5Zus?=
 =?us-ascii?Q?1CiyviXM/jSzuCOmWT2Zwhl6ZGORt5oE5zVsArz++69/W2cpUKihYL5MdB64?=
 =?us-ascii?Q?WZVAc/BdAXTL4kmsBcVwDNHHFYIrNcqEQs3IYez6i61MHBvDpiXAgE6RY+6/?=
 =?us-ascii?Q?pTESZuV4g8qA0wX8Ycpg6xvKps0OnOoT89r6gmj3Sg7CGxYK/FX38znxdY/S?=
 =?us-ascii?Q?/EJK3+7Dw7aBWJ2FpOBFnDm1Z687BfdECE5wdtxru5GO1Z4meWxwIpxvgJ3a?=
 =?us-ascii?Q?HpsS7XANIWQmNrV0QVSFvI7azqZGBCAtbwKGxfEgK7FErsXjMNrXj8ZIJ2GJ?=
 =?us-ascii?Q?d45s3yynmdVnd8XGj9VQTnpOtQ/ySSI/+uhuSIx3GTtdb7AhQQx70JbDkHrU?=
 =?us-ascii?Q?1ORydEaRLngHeGDeA4lCDD/Nl3rlis/52T1olaOO3agUQWtO+EjKP52//+Tm?=
 =?us-ascii?Q?wgkuDPiTvBo2l266jDXZVJqzhMdfbT+kuH532nIjkQ1ckIpi1rLG1+9pF2jC?=
 =?us-ascii?Q?znJZ1KqN6LwI3L99dA/JdTbmYf00RePWfkyl0i42ZIY11eUhol13usGlCu4O?=
 =?us-ascii?Q?rSUPmxFSDY7KO9T0juqLDjTb63lVP0cqR26wxKNnfHN/pg0SnXkjAp0tb/Pi?=
 =?us-ascii?Q?jGHh/4IZO3yEiIz8GYT6PwIZCNdbqdhZ91AJS6e8UfHFaGFM/gPjG4Cciw3T?=
 =?us-ascii?Q?s6YF8LoqSEPz3o3GjqYLpC1ZJOQot7coFGX9rRphPJlZ18iQrN0aztSOqLwj?=
 =?us-ascii?Q?as0NpBUYLkXgovKkad0ZEPr29biiUxgR1DNlfGaI7q8m62LB9mzjOhV1E4Rn?=
 =?us-ascii?Q?W8HMKH+zzbNB8nvdiCL2w+GpDkIU2WQN4SuNPFa1BANHxPF2mH0y9fbGc6nO?=
 =?us-ascii?Q?qnSYvkXRmCw2b064rYMOefG7nBXbEOjx2/VqBWLp61muJVx3u/mQtlMValvT?=
 =?us-ascii?Q?gzOU+1HQs/k/LsFckOsvVxOigRYVWRK9Bg946SnaElG2OMmVWFsR2Ui2SY8v?=
 =?us-ascii?Q?4RyKBAT6Soc3FSoJd6oJp6Uezs22k8i1LkMSJqnP7xg2QAwC21ssNJLgH9HK?=
 =?us-ascii?Q?05S0jhbB8AuHnw6eIDf+wXFWJ3EchZqV6dZZE3jsDBD5gkQa+Hl7FdjZVhOg?=
 =?us-ascii?Q?/nFUsWyjS12RNkiYJuSjWA6jdS1boGxaRZ4oJ7Pm5YIHJDeNtov78DEmfVXw?=
 =?us-ascii?Q?wdET8gwXXUL2/Yx8iXFbUghHGJf8DfoUox5bnEN4EUz1rixkv0JNN+k20aHM?=
 =?us-ascii?Q?bETksc5yoIGr3efaLuUlIKJfKaLWQZfZ0MHfXFIO/lOJTyF8jZhY7x3kNDSZ?=
 =?us-ascii?Q?zCcUWCiP7DINzVFkGbbebav2z44HjPLGPnMenA0VnqPN3A+ys8BivKj3PT2w?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JG88+xWR659JlzxljBk67q85wwQnN57rTVZN86vkMwZ7BL9YQFvxpxA0ArQ6IdB4+mSIHwo6YnJ6/rpBg5VKMTivIv8TLqhWeehNYCdDUYqZXAEv8v4LzMIZvLMSfbqOdikACPYywVstPu49eaps3frTJ+w8BcPTi/7NOof3Na4nNGI8XmR37XNGVBf6/q1GwkiQDcozYjcbzJZ4N/auL9be8MNKuUdcfbfJj1fwvJyZ/C2L14fLPg7pybl6yPr8yllHcMsd0RbeSnD+MAVVpZyEkdGJuS9OetxJmIcq1lCsL3p3OrhKNKwrSuc7dFBdFHkLrMyBUuU+miGVRtpTYwpg9eZn9uPyvrYZ8V9yPNCis4+lLqye1F3VVVoait04GsamkTpwKYbPLnU9DOh7fPhbsAG8FXA4EUt26td+wbUHaeYFF25ewEay9PoYiDmtEKDOmsE/BNvxvVWRwVsmVZox9riGzOB3soWZIgLR8sgjWGkWEZrTKyLycQb20IXddtPYGN42lCNDQT051lpk5QqGcGYtnTCNKPKW77WdwYnIB3bnCWb2qhY/bYaKi3nSa7fOC2NVXNsAo+/xzGyssUYd1djmNfljQSpBSrgTL/0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df96019-1c4b-439e-ef46-08dcbb037a32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 19:17:59.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85Ftualqk2TRVq2DJ9vlVAIAV06+CCDSENfvoamX0TsYwrTzU70JgtoZKSHjcxTKTsgXDGYwbzTV0g79tVJxef+z/u/OmMopheaSTt92Zfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=865 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408120143
X-Proofpoint-ORIG-GUID: _DUKw6Hp2HdpHRKQA9rCxg_vPqlAGJU8
X-Proofpoint-GUID: _DUKw6Hp2HdpHRKQA9rCxg_vPqlAGJU8


Alexey,

> This function doesn't mutate data.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
