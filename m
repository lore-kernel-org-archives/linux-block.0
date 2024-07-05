Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2714A616;
	Fri,  5 Jul 2024 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180334; cv=fail; b=qUmk9ITR8XNn+zPP1CVL8dt/z9XjEmUMOB5VzmqCUHVuiPfRs+ayw933G/+UXGr9oeIjTvNFsUnS+p20aFmAnfoaD0IFGRylUeIH2C+SQ1JD+XXWK1ZWEESTQNzHS6ZnO3s40+G5cO8xRh57rrBXsXtkhyHjV4BLlez7/Wv6E0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180334; c=relaxed/simple;
	bh=QTtE9FREu9LFvZIJI+tHgdZY3AhwcbNdEI/b2K1DGPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NcOO9Gt5jvwnmC1gL6NS9MbpNIqCnF2RDxMUbn3vLIcuQZIrhFdmvjE4AiK+A5HJP0sTlGKhPrpFiVJ/tEs3e3sh/rMJ0KEnewCvMLguKt62tbtyzkHyN1r8NfjRiMkU5Mj46O0ZUdPFxihCM/+lA7zCoCHRw/WWsDoTgoBdMCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k2USv36w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R9+UaYJW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k2USv36w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R9+UaYJW"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465BfVI9015200;
	Fri, 5 Jul 2024 11:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=bLXXo0HCb959bva3je8XRwmaOWTLpUpEHNm/ZQh6YpE=; b=
	k2USv36wecUqL/M9gB6tZV2pd0vWg/gIMCx2meec4l7LJPl5G6OKzgN3HEBunstC
	Se5uayUm4jSt+ua4utPXEsQkpWejAOjRFQOcT3etMlb91PKa+58uEx2VKp1ECxub
	6usLneEnEqjlVhpIHILopjad1BSBe4yNuV8yhGdYEqm07T8P7yFgoPMZQ0E/I6Mx
	fKJfBTmxXxaWX0yMGY3iOazNwohlrGgL7CuP1Axm3Uk+ODnmGGXfsKkRj93XiX+L
	hxMl8X6u5k3LGDtPoNgS3rOGZru9Zs0s6sSCcGHn/jl26BYsIHURoJVhotUr6aUm
	NNJeFRYjRwCITCawoUhN4A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0utgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:51:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465BFxqL010273;
	Fri, 5 Jul 2024 11:51:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhp8x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:51:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMQvYoNrtH9LLIHePBAu44RMdmNVuXgqGtx8l6Jl5HV9aCcZxcxoSR1WX24edL93AH66jDAW5P0l2w00MJw6Y5K2UT3YA2rGL71VS4pMCCE7KSpAb8uIUieBh1+/NKt9ABXb4SO1DcPFATiRSAThBozHY8+oBPLxGoYWLnRjP7Fvs3yVcFyZpjdklt/mjdzHx2sNweb+lUir72y4cqwisflUVNEPWCDEj6ElhkEVeB4mLCSYNnovq5Iou0h1zGjS+eWUirdGBUNg81g7tG1eyql6XEgdzqSmiKAuEdDeMdHp2/tgxH7q01rppPp8SII5M9KJAjixv9L8y49O/vM75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLXXo0HCb959bva3je8XRwmaOWTLpUpEHNm/ZQh6YpE=;
 b=HBkFgm/NiXArOqd7sKkIH6NPo11zl32WwQZEPmN+/nH8z4fhs7L6BrkrD+ruMyWYzE2Stxk/Inky0VZbCjKoNOtNKJQxLRuA93pWnTreyN3XESEdBVzuE4QmfDSHtH5yd9+zedmZozoTCYARq9QGD9spPTsrSboAUxmWm23If4BKrTOaWix1FU4l2yKcJu1Nf1ppGwXENGfWyV6vPIzMjq6+Nn4vpKTql2fmnvHo8b9RtkP51lyvnqVnWbtchV2xXkwb8IoEOduKcVb7O7bW3SMU1FNDNows38yamY69UTmKNc+OMpJeSEbB+74FfbrXKtdUe9zh3mtJUgg6Cwn7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLXXo0HCb959bva3je8XRwmaOWTLpUpEHNm/ZQh6YpE=;
 b=R9+UaYJW3huzMPSdsuMTFMSpG2t29kDDd0z8zvqtFNrEvNCFCvFPaJGRCWGKIULXE0tJ7bBoiVJPy9yu2fiWxlzQ/EJv6YY3n3TB6Ml0AvE6pooJeA54CVMInMSrArf7AQMrzLjI4vCMj3/QQUS2QR5wmuFLu9JwLOdTk08F/qc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB8080.namprd10.prod.outlook.com (2603:10b6:8:1f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Fri, 5 Jul
 2024 11:51:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 11:51:48 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 4/5] virtio_blk: Don't bother validating blocksize
Date: Fri,  5 Jul 2024 11:51:26 +0000
Message-Id: <20240705115127.3417539-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705115127.3417539-1-john.g.garry@oracle.com>
References: <20240705115127.3417539-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: c462d2b1-ea50-41f7-3ea6-08dc9ce8d9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?u33YUBO4iNnTepJtiSvO/tkGle/1VnNGLP1kBX6etA6+sxQ2IwPvxlxRof8q?=
 =?us-ascii?Q?rxVfyDERmuQDnnuGlOtE08BjrYhjNOR0yM5GxAf/wcL/nwgueh2HhZpxCmPY?=
 =?us-ascii?Q?45/3i9kwhJwUvDXQH3YD3N69v91a+j8fCUDzd703cpVNO33fzqG38VRK6kXa?=
 =?us-ascii?Q?XcBq0Ze/pqRdairMqG1FZOuuk/HlK7yxofY1GBvPdh2xm1V7hNwwGn9/RNiY?=
 =?us-ascii?Q?VQINO8CIVks3LmG6dtq2dGvRyRdP+45cerKiFaT46QNlJJUFO3RzHqAdSTPC?=
 =?us-ascii?Q?2XPMWq5N7acInDEeZpEoXDCUlQIAT6X/Ekvhgl1TjhgJv6PyStAUNGIjI7TW?=
 =?us-ascii?Q?KytN0JBadYYoBfA7DBjUbNJN84sSOpPcREr1J4KD0kee/vIBKCVSpNqXajlX?=
 =?us-ascii?Q?vOyXPAt7l8UZhYRktGv71BgG1/LOfirnTfx3TdREW3SOTyOkE1p5izWeURXY?=
 =?us-ascii?Q?63gp8O6f4Qwzm8JjsrhRGvQU8mXUCvPT85jp4991fQXgW5FJWiRxTW+f1CoO?=
 =?us-ascii?Q?UwtvksViJoZ0JF1EVkIAFAlE4RheMH6DrTGxT9b1PguUWS6jzkpSm7uB1BQ8?=
 =?us-ascii?Q?7yGyO/crE2ljNR810uvP7rtLlFYS9YVBLxX+CUobVjZhEFCA+Jy18EpPWAOR?=
 =?us-ascii?Q?9AxjqYU3+R/9TJdB55IE6MtFzt4tQaNKNtviYfuTFI+zteAs0WTUkti+waRS?=
 =?us-ascii?Q?1rUULl9HqmlPj2KR24NH/YRTKjZ8pYx094hVIhc3QdSPFmVV4UfUpDYqSXbb?=
 =?us-ascii?Q?XAuGFjOh5lPfmmSm7npxa3G+fl9XJVboWfVqyyCO424dEjij5mxD/weetKw5?=
 =?us-ascii?Q?Xu1/MNYmYu7STPIDJ3rdINdwHRRf3em+7ARGNTN5ouKIT/CvuCzR6VOJYvCz?=
 =?us-ascii?Q?KkDA68cHz8/41sJXjV/LqTaU5jWulngnFEqXMw/YTMI79K+e6Ackp+ykgIj3?=
 =?us-ascii?Q?WAgWlajuJWJD34jmT439uOC31K4/36JmekIDWbGkgP77zpqBCKuAfkyNxzl6?=
 =?us-ascii?Q?jDRJzRI5QdjxZksi02fqDajxqvqJQXI4cY+SQIkXZpfzhjMpDKaK8qyiAKnr?=
 =?us-ascii?Q?jptvoF/trJwz9iH0L7BU40Aa00gqa3VBN3jpTjcJFsMbjgRtMI2/S6jN6SJM?=
 =?us-ascii?Q?Gx4wDJ2RsF4lFaamU05KSa4MLKxjHudzm/CfMj7gGaTI3Lp9ovzvz8MNNEdT?=
 =?us-ascii?Q?ElZ7ixZI1ZslgKlT9X6NVZRUYrE1UH/37NeMZrZjvwifHrzqlvR0p58u6rCE?=
 =?us-ascii?Q?jh93ZefrNwxwctOpvDBWcrEC+9CUnsn4kzvVv2/cViwdev0QLgx0fYCfNkRt?=
 =?us-ascii?Q?VVBbUwe4JyVjVMKAzCrYPA1WF/1/RE3dotoveCBwFwt0d3YncFDTkeLh0O11?=
 =?us-ascii?Q?2IZR5w4YJ90G1wHPeZrdLE3DeAJv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?764rI0DcnFjVe41KcTLHo9BmKYsoX9pjLFh395VQR8TAin0E/cOG9bZSX/De?=
 =?us-ascii?Q?axCFaXesKdPA/HlWIJlCc20nXcNFIchhDFpkcIxXRa8uBPccoFqt2NAQCCDc?=
 =?us-ascii?Q?+q+fXgxZHbsRUwJeonpv7SNfvlJnwPVIWoBCx4ONG6CiQWBNqiVerhEmxZA9?=
 =?us-ascii?Q?z39pg8yZP9CcvivRltQDgIu3olDOVJKkReS5m2//pOF3jaxHdRH+p5MaCLiM?=
 =?us-ascii?Q?4yF+OqTnJb2znNeYDdn7sVjo3gYDZ4nLFXQev11JiO+etLaR346755gbdJB2?=
 =?us-ascii?Q?7WqbJ3TPvYY4va7BrTNwp74MsQLERFox92mH9wx9KDAXujlhEEV+Oz2HXT87?=
 =?us-ascii?Q?JdH4tGwY11+rNnUOUjCRmR4bW5nr/bWJ5R3LIwRy3TzNYfqHbH360R3EiUfX?=
 =?us-ascii?Q?TXfUYu6V8b2Z8myKCGXgH6hkdZRVhiTLmrsNqWzIaRLOeCmz6suTykAkzGHb?=
 =?us-ascii?Q?5Q5I3ydYvL2vnXdFcKuSHVQlHRNpf9yqkd3wcsshiL6MaJG1epEDbhlS4XZE?=
 =?us-ascii?Q?UMo8tLDD/BKLYHvLHjkS+FZ/OZPXDURH8fDOSHuF00jz+/8W/1DLWTsqTtBr?=
 =?us-ascii?Q?8uu7Ph9gG856PxWo6GGIVzOB/ovyjO7gdxV4yjRBPMWhWpjzP08liN8AgCFi?=
 =?us-ascii?Q?ZYxc+uQKFxMpYDxJeKhn2ubh7+dQewCu2v2ze5mUkYhhVu4oDAXLITVGkqaA?=
 =?us-ascii?Q?GkOf4cJgVhQ1rSJ0sqvEOlb2sXSEAXoRmTI7pqNHySXKo3LTml/632f0xCtK?=
 =?us-ascii?Q?2mNnekM25tnUJULiYU0kGPe671cmeCDINcN2RyG1XsnHbLkH3LutXCjOTd2f?=
 =?us-ascii?Q?g3tkpnSbGpnjNmnHe2nxdXKWeH4ikBNmbu5boypoFWzzhnSjTcCqLNSkn8AJ?=
 =?us-ascii?Q?OxnCKuyjmZd5EkyAf+ke2RfgEHcNpsKWfJIp8MGChpPjkQge6dWqacyAGwE6?=
 =?us-ascii?Q?s/WI/+gmmVHri8U6B5S88oF38QIq0tN52IoGoOWd2ltC75IkGzX/vVbbiZCi?=
 =?us-ascii?Q?z7zeXE1IVK4GogOuKKg1qkZVnYnbvlrJtz7tiBzAvruv5VqKrzPfvb6lX0iT?=
 =?us-ascii?Q?u38fFSvX20aDtJlZYYSyIZ3/8HOzfXg+kriBq8V6VWhWOXcpLVwhpbWIY11j?=
 =?us-ascii?Q?tKi+wt3D5GCUp13+ZgRaxt9w3+c/owZwX//UXv/d4OO6Q7LtpKw/1uKCCFl4?=
 =?us-ascii?Q?88fjA8DLrl5IlLd0L5Dso0gzcHdLrt6tXKIox8ItqdT6y3WklaVvDmcmBJVK?=
 =?us-ascii?Q?iGUAGuSbQdzZJeHD6QaBJlbEzq1Ze8zdiCeTwazRe4YxZWVDPPJrid110NcA?=
 =?us-ascii?Q?PWY4+bSqYkzmFjcZzRnX5aA59Lm1sifsu8qjbh/OQdc6tCjRnnGi6iNihoBc?=
 =?us-ascii?Q?fDPwUn/xCB7Y9TolSjk1OrtjybXySjVOUz28OLwjFIcLFAQFD9PrExKF/VeG?=
 =?us-ascii?Q?O0IF9jjB3h8dFxqRyabs2U5ZkXOHFTnivPayv70bG71CW5xjzYYaEOfj0WK2?=
 =?us-ascii?Q?RjQY3m1r/35UXCD8Q6B4kPGA4CmU3Eyz48SFXe9f62RisedXLYOcY0sbhF//?=
 =?us-ascii?Q?0s3rpWGRn56GKm5jCc7XHRb+b9j52Y5wVJXHgQaR8twgnWpyalzon6v5vBqC?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CCD966KYDUe+ZtJBP+rcrnoa3NklIh63vE6IKlhE2rSNp5aMtSt/4bWDzro9lZtBT31dkeL54K2/O+u2ytHpdvZRzB7SmbI3tKBXy6pvnONRNRnSHW6KplE67sC9xoe5KBwzdiPKruGSYhAgpVfB2nsk9di9H29hxbUmpoY+RgYNWmQhQixPOBPLL0IVt2+ynUZpunw3g1Z7kB298vA/Y8Q9AQIcmJJIq4YK9WWaBgVRZtFRZjVfbtIx4Qc7sZn/obXiSrbLrC7103X8wmY8usZcTlr+kN9AIOYSpxzBMhiv7K+tsDWP1JdXlPnLq85O+bTOoOHokyQeMBpMMcko9bQcguGkUR3koNb4M/bqNUMUED4bacJEpCcaEflea2a6IaX1xRwPyfMRMNWdcvLPaV6hWJUCN0b03BEvtX1kxHLtSw0PzCNbwDfJaqRYAIG8mFbby9o7O21bvi+wxyEj8aqaTHh4GNHh1S0fvbxUeDi+fBKaGCq+xMgr9KWzxUkHvk5YofaI1UntZa5W916TGuKl2CVFCQgCXUhQ1u3bW8J98pXA8Q9G4iJ44Aih0jD7+cxshqSh2MPNIC6O3/794rDv0EGyiMJ3skGAClA5t/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c462d2b1-ea50-41f7-3ea6-08dc9ce8d9b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 11:51:48.0226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSo37p+BivGqBL2csNEnYm1Tp8YkK57vzlWR6EnkoZ3LdqY/pTf4ZKydApuVATfvFthn3CQSAg4DILzgomGIsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_08,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050088
X-Proofpoint-ORIG-GUID: ML8KvbufN6z9niSFk5IpCgPD7oP7S2oz
X-Proofpoint-GUID: ML8KvbufN6z9niSFk5IpCgPD7oP7S2oz

The block queue limits validation does this for us now.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/block/virtio_blk.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index f11b0c3b2625..e3147a611151 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1289,18 +1289,9 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 	lim->max_segment_size = max_size;
 
 	/* Host can optionally specify the block size of the device */
-	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
+	virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
 				   struct virtio_blk_config, blk_size,
 				   &lim->logical_block_size);
-	if (!err) {
-		err = blk_validate_block_size(lim->logical_block_size);
-		if (err) {
-			dev_err(&vdev->dev,
-				"virtio_blk: invalid block size: 0x%x\n",
-				lim->logical_block_size);
-			return err;
-		}
-	}
 
 	/* Use topology information if available */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
-- 
2.31.1

