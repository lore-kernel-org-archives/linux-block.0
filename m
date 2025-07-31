Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB011AA7A6
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976817; cv=fail; b=heK11r+s2ARc4YvDGJnE44um49jVC4UTH3UBBIIrTCWiWKNrxHy1jPFjanL7YDC8V8U7BGOVGXUv8DfvUYXTIV1C1LEcH8eYI3jncVLa66uN7IbidUiXGLtny0csjeop8ax4V+fRYP2gWtnrGKyfknOIEeOKWqEfYw0pluiVy5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976817; c=relaxed/simple;
	bh=Y503wMWXODnF+R13df6s/i0kChKHN4WMh0vWafCbHCA=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=EGncbPgO8Ls//5ZTu/VNpCsI82H8T5gtLEzoiDKLlRrw7DGzjfKMtajD72bNghWqKJefvGIb/FAKyqMAseN+ujo7Y247SysdScIgo/hjUPNGc9rN3myWvuq6VHmEef+ORpxsCFa4/I30Iq120qedDbkfOnGAvp1LhFP9E4Nc+8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RssLArcj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gGzHtfZA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RssLArcj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gGzHtfZA"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VEuDZ5005960;
	Thu, 31 Jul 2025 15:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QbS/IzxoDfxrAiDni9
	eLQfcwe6TfDO3rE1kDubG3cXQ=; b=RssLArcjpe2xcF0+xfuCayaHNfXbcvCwzi
	TSIvLeeJ++fXGyFHuSHFFEtMymVaFVTwg32xLHdsNDX64mnV+w7f4ncVkRU5j8XW
	3LFjmxS94kMwqh3NyekYUzfbYQoxPta7dckT+vurQOHQbRBtJiwHVTl5aCGUO17L
	VywiiP8fcA+O8D4WE8R4HuQI2++sGm97Vo3Ns//GS5cjicsGrVlD3x2Ql4dB/qjW
	QWYpxkfRyvvcAqZsKiC0TuV25LBdcUcikkJxhU0YHhZZGWXfhHsreEtRvhJsREHY
	L4LNN69H+eq4aWxANJp3Rund8kVhC5ya9z5LesPEI45wicZxAZrg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 487y2p1ab3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 15:46:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VFKvpm002467;
	Thu, 31 Jul 2025 15:46:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfcnjdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 15:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+JHiVrwe2GenyprIFPra73/xfUeFS8dcRzfUxDfBvcshNd3yoWOpi9wfhBIYQW7ylKmKUaSAPLRC9D8iuGFodNHzLGwnReUg9fh1m9p5sU1cHxQK6fPUT6ROkdtP9DLN9gmKUlYpocH1lOyBGH2nC5zH74eUywf5EesgEFRluODL8/PH3k3GK3hYFjAZrtlZc6deHFygcE38nCN6lDE4DZkVIp9xkFhdmnLKXSQVBiEFtD7Yvq2qrrD0MmsQjD7CF4UKGw0D4yYmAdoDAVqB1zCqAZ55Osn6x1We3HEeiF+pNbeOrEY+/B8cjIGrq/KbRCQjqOwDk7WHh6FWDd0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbS/IzxoDfxrAiDni9eLQfcwe6TfDO3rE1kDubG3cXQ=;
 b=wOBT1TbukZEkvJ1Ttv61TgocJ0jwNxYNULib2k6Zjk6lbjJJE0Xk4bt1dS5MZT6kbn+Bylat9/kZq6ppq9PibhXLNrzltS/3mb4+Qt/UHfp4NY12gsp3dZkMZvEHf9geKUZWHS/cdtBDvJVLGTlNMTiBLLbDad+hT17JUzKtu2MKWbei46Dski2cisOpXcEFy1h+RawcvivL7hp0110nNjNtqzlEW7+EUSRbJCQ3sqksaRRlf/Q5lcIOCp8WgYSWG+72Ft4+TqJFuyn4l1ARDo76GpTd+SAzLenaef24NlhkvW3a+A9FBV86uAJQfD/BStZbuvKQ/CjKSfkBO84jXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbS/IzxoDfxrAiDni9eLQfcwe6TfDO3rE1kDubG3cXQ=;
 b=gGzHtfZA17VEcdg15GY9gCcWuAVOpH/SArFogURfLKBNxUiR8JPiWkAeb2tZRbgltEyAb/Y4R9ADjbAVHjJCpQNQ23xDf+JW1BiNBa5P5ma0M7/o+McfIy10kG7zDefWrWh4aTJGC8cxlGnPJfK7UvJXpb/XUYyOO9mGlScG1Ks=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS4PPFD14B646D4.namprd10.prod.outlook.com (2603:10b6:f:fc00::d4a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Thu, 31 Jul
 2025 15:46:46 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 15:46:46 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, anand.jain@oracle.com, martin.petersen@oracle.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: ensure discard_granularity is zero when discard
 is not supported
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250731152228.873923-1-hch@lst.de> (Christoph Hellwig's message
	of "Thu, 31 Jul 2025 08:22:28 -0700")
Organization: Oracle Corporation
Message-ID: <yq1o6t0fjoy.fsf@ca-mkp.ca.oracle.com>
References: <20250731152228.873923-1-hch@lst.de>
Date: Thu, 31 Jul 2025 11:46:43 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::24) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS4PPFD14B646D4:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d189686-6209-40ca-8fe3-08ddd0497441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?alFYQ8ppJ7FBkTHtLb0rO1wZjr1xqwZQie9zakWQIh06okrfVfm9l9TLEBfV?=
 =?us-ascii?Q?DfT+ZdOgn56SOKI93/TtO1vMQYk+RCiCZTgcWPir0TwMRDrjPvXyp+otDYHC?=
 =?us-ascii?Q?nmFGF3hSWKSrfmH4s4mSsjeG8knJoMggbiBGEQCvJ4KAh0TbhY2fBGMW/du2?=
 =?us-ascii?Q?VKIzvbL9WJVFro4TtX7YRIg7zIIgcKcEEHBVLysaHU+SPCZI5uKOf29M/mhQ?=
 =?us-ascii?Q?pQZ1CicMTBsfYQEe+ScW7pxw8E159jcwCE4fBKpQx7MgSA+iwWk7dvU+QkjK?=
 =?us-ascii?Q?imK/u9Lwi0bvsshpUg9ykNHeg0jWwxOMSQDJtEDu1cezLYSCgrDQ67zZSMD4?=
 =?us-ascii?Q?PqkVEktM4aTdfFFLkwa9CGw+7gewFnuiEQGSIe0YZ8FqXx8FmqePrKbyzzbC?=
 =?us-ascii?Q?brMEoI98DM3mpwbAnRyrAU8Jo8cqDUnzCC5xd20Z6D721g/Y8wRPp9j4wI23?=
 =?us-ascii?Q?/h3khrNAavYMfDyLc5JKFvY5Bl+Jl7j1q/d4S6B97YhwfDLCfT8emeBlXRbH?=
 =?us-ascii?Q?MQ/2pQv11YnsTKmkSrTKz6luJSZhZSVEK4x2inFFg0v9ZMx2sIzqq1Y9xrR2?=
 =?us-ascii?Q?Phlqc6Klz5w8vFtpdVvQ9aOxjM9Oj4o5O1HFCk1c8zoSdzCzCRkgcje4X/xT?=
 =?us-ascii?Q?aZu3X82JyC3wUdO3j50BzLOWcLNaYmCioQIArruOgxSfpcHzjrzYN/lVIQ9x?=
 =?us-ascii?Q?u8vULErg6ll8ZIPNDC2TZZ8lpRjBkvdY9sjBLFV4eqjSzcVYcMXHgPvIJvaN?=
 =?us-ascii?Q?8CubyMGa9sb3/b02MSVVzklXmUUJX1LFM/BymHm1Gdzffhhz9RifICASpsCc?=
 =?us-ascii?Q?j5VC+bRNYSgZAvrTYrouBqEOBbcI6yksF3ZhINAId0vCec4AULsc1InhUO0q?=
 =?us-ascii?Q?x6kjWoYisd/ZQNKKNsgPmFIhu4JbGmKhlGJNtmZSuGS4Vzh1I0NgNIYZ7YlB?=
 =?us-ascii?Q?GG8rR5t/pUwbdMr3YMYZwa2waq/ehOAKINeM/kUqXCML6As4e+5bcer1pY5C?=
 =?us-ascii?Q?hhAZk27hrS0YzvUFsyGg7MK+y6RtD8oHp+AmtOli5Wavw10PK+lC8eS/RbH2?=
 =?us-ascii?Q?K9LFMNEGOpmVgOTrsMKFpkJ8TySIXlf20TbRzcGOBpc2xvr+JF3NsKslHRfz?=
 =?us-ascii?Q?SXadMexx9xD+nwDyL7a4oLCWr1Jd1/vQMqtXONK+6qy+AoJ53btEUtMbD+iH?=
 =?us-ascii?Q?UnlUe/qkQR5RW117p3TRe7vDhsnr0BLX9Fcn7fHoCMNOnSws9503kLZEuLdG?=
 =?us-ascii?Q?WzzCEpGgFPpWwIYhHWs6R+ti9Cp6QXZf1zzUeeDf7BztC4EmnUhBAAg8PRyR?=
 =?us-ascii?Q?c0dw4Oata20VZbC5eCTRGBs8qj9FycZ25b94uUEcQMb637Ib3KUQY8fAC7f3?=
 =?us-ascii?Q?JTAVdM5e0GEB9IfVYddLkd2EN9rJ06Rhw8fiLfV2iABJzOZ+aX5lIZ4tO1Ae?=
 =?us-ascii?Q?YLBREgLUp9s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7qF0vR+QTk6k56eeVmNLdNogaxyh8v+8OC10zwkEHVce4r9qGSe4KN10ehpn?=
 =?us-ascii?Q?8S8LVHTMi7qPJSpBk5r/Yhuonk3IVq1lkW5VEx14fhB8FfS8SrMPaPlVt3/V?=
 =?us-ascii?Q?DqvjC+ozbyExLDkTICk8XFQnpP2RIwjaFbbwc9lytGB0D9fs8g7qY4awvWP9?=
 =?us-ascii?Q?pmkhZuMn+1RQbhYLvAgN55cMYdtYPNahmLxG/OszDBzwg2NxvFOmDEtpJtyr?=
 =?us-ascii?Q?yeNneCNicr1hTD4rSCAtWqhe75OVBwbUhU3+n6fPbVqiKFle75R4AA1CMEfV?=
 =?us-ascii?Q?dStDsPvGHdqV9SJ1Io1Ov0v0FZFCB9K9iABFRlaXrEch8xU8Qls3nRx8CgdT?=
 =?us-ascii?Q?7Szyl98wZ6aIpIHJ+PImf6NUOHeivdtU/4Ja9A1ZcBteSe3RMSkWLiECr5oO?=
 =?us-ascii?Q?WQTm7BbDxIXXkakREm3MSwldKmMr6aCJpxW6pp8nvWfof6zVgLBNYEAwRzhx?=
 =?us-ascii?Q?DnzEkQvzoDpowzfahlYcgFoOYa98yrfNyquMwfefmmSm8EYDz+/kY/oaL2Ur?=
 =?us-ascii?Q?v5h4qIqCgmvB7hewUz3/317BHzswxu8TECqKQ0PQ7YYd+1vvOjsnx1tiP8RC?=
 =?us-ascii?Q?hhfa3v/yMuLFUjjRfnWpz7BducFz9x2rGWWJ8yiZghzWNT85faJMpoyu7nDQ?=
 =?us-ascii?Q?htARM5LR7XI3fRonWhXAHA3SUw0qCle3IajFyG9hiGrncbxVq9OzJVFpwTd1?=
 =?us-ascii?Q?oIpa1k9sIb+lHHPqEk/6pHNV5izIyFuwFd9AhEUkHebUI9Hk7d/uYK7Igxfe?=
 =?us-ascii?Q?8CGyiwn687ZeQJezQXrrjGRNb446pnBP6XGpStc4a8JoMAG/QI7TajNSVfc7?=
 =?us-ascii?Q?IajPyNVSA70O0o+yPBWLNniXAk5/T4fuRBEpXF1pnnvgT/aZaweiCovj9iyV?=
 =?us-ascii?Q?VEhDO8X+uDA/2HK4d+k8BCjOzhTItL84TmCpaRdbrlzlVZ/Gr8xoUSlSp8KX?=
 =?us-ascii?Q?Ffn2WBRPukbXy4K+u830C0Dv8078g0QMMIlFcpr2KRMetrIGbQbRDUCv/X1d?=
 =?us-ascii?Q?yXCwr+cLR5BfCjT4M0AkdwXsNT7z2RqESmYAr6FSn1C8lUi2jM+S7xr6q62o?=
 =?us-ascii?Q?z9WSKZg/ypcrwk5dZ0PP+8cOztRNdwOeNH7Qx8c5BD8Tf1WPDZA6cQU1oWbv?=
 =?us-ascii?Q?aIgx1shcnSYRR+i8T0wg8eZoxdebJe3LTcEVg8AsAdWOQKjvXfQemv0xFlYT?=
 =?us-ascii?Q?XI5bTa0Jsmt8CR06g/jlE8nKTp25apPymbWpObhClcx1AB9U7ArLKTjbbj4U?=
 =?us-ascii?Q?GLIWrNOnJeNXi2Vjn4otGR+9HahKs8jHKv7OOASLvxnB1OFkphEVhv0kfe0E?=
 =?us-ascii?Q?//V3LzQ56XzMZfAZgwldiEV45iDnmO+odPdsCOQ+hs/CgV8Hw8GZ5ngE9oVm?=
 =?us-ascii?Q?2tfs3ehix/KRWlRJBeOEQFs7sizhQjD+IAhGjnqpiDLVYSZLvVZotleiPaCE?=
 =?us-ascii?Q?H1vpmVgrNXVhRZZbcJtpzmPgLQwA4z22yYDZANwatVM4PxE0aQBwTdxPNIsO?=
 =?us-ascii?Q?+Jsl6cGZ1Ge9BK6MQXNG8ssJMzOdRwm5L9Q6W9fXUXI87mdCAi3KWRZ3kBti?=
 =?us-ascii?Q?E17x9dGYQYKTqzXGdcdbXg9cP1oicA+WVBlHtOvPMbiKhOfYC8Y8gPThMe6o?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SxTddwJ+Wxc0CjaerLpU7nAly0Jald6AAYy3whhFMIImY5tp9CZxMkbc1011EJsAi5q9tSNcVVzvkS18ZqRTqkD7/uRZ7XxuupAzGdiXvwjr0AimLUQkK6JXcOibKFEsgEsri68QMU4EdjENgF59q1kuWG80QK+Td/jUAbizKnsGpMrcCUOYWF9gjxLMQVwweWb+isVn5RJn+l6uhoXDM24UsUmX34cy7SZ6nSZg0INo0On88mZFGB3fRoRqQatmiMlwyOlMvpC4NY8359vp53CYeKt6nIi+7eVDcUc3xaCmoWNrjjRSZZLMBybDedSlfZEOQ2JdCo8xQvjT0w8jADP+Wg1FJd/Fq4jlJR+f3gZspZDaCBAcABfbRZ3nf73AgxBQRn0CFMyOr5GqoptDSz2JXHvtgFzzh7AWaqmO/99YmH0cra5cBxFCfNYrGakRVXjbOicGQ+I6O/8sFTV+rkLOnyJjyc+3khq80wQ1N48EaLNih4HRs0lSVfIduk15Xi4nghYuMo+gh7NfVr4BXsZV6DR1f+hs2tCGr2++kpR7V+SkRsr2QfYY6tbP8MN2cQJaV94SZP7rUN3e3fmIqA9Q94aAW3Pea2dorjXVJb8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d189686-6209-40ca-8fe3-08ddd0497441
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 15:46:46.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLqytEtplqRYkIVV8C1WkISosZQ06GnDb33AlXktiv+omjQi17/kczrnLuVJdgIQ8NbUi0jt3+wqBDKbxxh5A5eAxw7rr2+wosNgu7PAKrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD14B646D4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_03,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310108
X-Authority-Analysis: v=2.4 cv=COwqXQrD c=1 sm=1 tr=0 ts=688b8fea cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=fL9r85IXUHP4T5yS2rkA:9
X-Proofpoint-ORIG-GUID: 7jz9j7SrvRmF1rdm65ryFgxWUqCni9W1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwOCBTYWx0ZWRfX+FtcTG60960B
 suIDDANMOX1dui76t7xKjdKDsRLVYdYMb5XLW5O338sCiHEKwHvAt6ELN6hM6X1uw3Sl9UcB3db
 Y9csapNLYk6cc3rG3rbPrfsAPpFg0vKRrtW3Ho3qGCebvrGQzYaewa0fQf/9U84zzkYdQmS2CQk
 FciSse9DX/mzVpDD+0mRJKMPtWlBQkV7QX3Lb0/ZZ/yibV7iF7O9JYEf5Ma1cDWrpKUIZCf9VOk
 72c9hOKytB9dsBg8mhmrjZsnaCCGOim+7SU++EJeS5eeVmCe2L1eX0gcbuiRSAUIcoR3kwfaoUj
 LALHYbNY7YYUH64HidynkPdJH4mIwyI+1oVSWfNpBD5HbdzebdwMN3cmtM4KGR/8AFVF8Te5O34
 vVi30P5POg2FdrX8og+NqAG283dN6Vstf6W1zcxf6/re1DAtN/IknguMCxDVmzY1rGQ/rA8d
X-Proofpoint-GUID: 7jz9j7SrvRmF1rdm65ryFgxWUqCni9W1


Christoph,

> +	/*
> +	 * When discard is not supported, discard_granularity should be reported
> +	 * as 0 to userspace.
> +	 */
> +	if (lim->max_discard_sectors)
> +		lim->discard_granularity =
> +			max(lim->discard_granularity, lim->physical_block_size);
> +	else
> +		lim->discard_granularity = 0;
> +

Looks good to me!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
