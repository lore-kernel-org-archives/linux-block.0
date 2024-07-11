Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B44152179
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686270; cv=fail; b=K62jwAKYiKf8f29VBa7nrMxhAzMZiK74b7mO7O8eeN/ZLce8wZH594nnE7+VL8lTj9mnarSGdIKxEfoR/8CaVhCNzxjqAkSzqGt3bysFnLrVYx4IwUXW5rPsVKDKb/QO4yz/NlJIRgnns9WbnkOigNs0uFc2C3xXz9s7VylO+LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686270; c=relaxed/simple;
	bh=E+Oq98i7jwgK3g8WDSL+yxHXTbUWzd4N/1ctR8Q7QSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ivff2cHNVrXb4VaqpTNvlNclTEDb6k1qWkIsjVtw558+5qkdNRgC8V0SckpxdLjivPYOittEM+QEtuFP3rpnavgnyHtnXkVMh4iT6LFueNMXbfE6METMP8/jzXEuHqHE2bSH0Z3BFaCbEj//2CBQhYADu47gB7iWSjsDdeX7gao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ebnIC4Au; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zIuZXybd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ebnIC4Au";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zIuZXybd"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tVU9014042;
	Thu, 11 Jul 2024 08:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=65jJ7WI5WIEGpbRips6GAhApJV1IMjq44LLkllJpyAg=; b=
	ebnIC4AuTU4t5kpV7yI35cdX02KlWjHjnpB90XATYhvH4F4hpmbV2PGdLI7grtbh
	gVJBdLf9Ft+kezQX4scWV5vmxdBiQIMROzpG2LlBTY7qaJeDB7Z73FQ/szDF3MhJ
	8+QLG14IKtjgJguDAZ8YfD2VkxnWLVIWdzkn23wEMGqJ4rZctvGSlLh1C4zwpJef
	yo/rpm3E08PX2eZgcv76VyhunODHvk2k0F3eMvfj8Nt0BvoB8zVdVpCaIWph/zgd
	u6unBbRA4g7gHFAhhntcPcsH9AAgRIp4zmDnBhjLh44ySRNTaiT3H4s3FkOHphwb
	1nxIMTYgkXp2aYjFMNT8ZA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkch046-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B6Yj8o008910;
	Thu, 11 Jul 2024 08:24:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv478fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=um/tISSrOXiIln7FVGMjuv6tjhO2nBybVCq0Vl8TJkVFZwwVviA3rXoum88zyW+o0MdNIH1WeYyRYFTY0W1ahaXk8jBI7wltLp2qn5DEWjrRwL+ub0PCjl5vSZKWxIBMIsFPQSQwszq3nRjGb4Iz7dxi2C5UP5AGDMBQHftHHemQip4eP3gTxlhj1p/UECHMjmTEBiSn4TRrMtkWo3u4kBbWt+sP7ogZIOkpbmw+voGsM8l8VObt+R7yGxpJ7b4jI9yrB8HHOWERL4fLnVvm8ctwNBKTXno2anuZWreDC3hKq7OiJdwWZ7VaVD7bQmR2S9rY6BgYKfSDjj9LPzk7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65jJ7WI5WIEGpbRips6GAhApJV1IMjq44LLkllJpyAg=;
 b=JCnZhNCR0X7t+sCVFFZi6JoLY7rBYymRH0tTuQ1bpjmnmUy9A9+At5Hn11biHmDDNo0j96uv/DS/6DtbZ1xxiF3YwgPi9UaH+ztWPQBpGJ9k3Lnc1g3q13VzSln6YPgJEbtOikz2c+DHNIIkrEce5U9aWxoeyBWlywkiUG+oYvbMctYFdUYpeS56JvP7JU/dDOZ18B4BDlKda3OyPvWgfgXO/zmCXdcV09o5YC9gZ7EuFDuKwyI4qmOkjTucPJPVPbvzimcwYEE6QeheVdyUKzbQWsTGLWnldq97Ul6cPoLf/G1b2PHd1xakmbC5d+ZOLbIohHzn2gQJM15hrCn5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65jJ7WI5WIEGpbRips6GAhApJV1IMjq44LLkllJpyAg=;
 b=zIuZXybdadpsJQQkAZ/W5tHpzk/q7CBGJtPjqjMgA8fVThjzB0R3nN1yrw103Q50LnZpcC0bQW/QCD4ouAjU5jWKCsvHX8Auw91Z1lsANVemFwjPjQN7R6m+RHSGlKaJqS0g0v3Oob79ThQxqddg2TLJRa4y1VU1qjDdnCHvqgE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 08:24:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 08:24:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 07/12] block: Add missing entries from cmd_flag_name[]
Date: Thu, 11 Jul 2024 08:23:34 +0000
Message-Id: <20240711082339.1155658-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240711082339.1155658-1-john.g.garry@oracle.com>
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0087.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 740a63b8-03df-4cda-0706-08dca182d517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DvAGrL2Qkkycx5i6rsvs9nk428TllaUZBWOTTGTaiuVt+6IVu5+hqYHzzRbO?=
 =?us-ascii?Q?IF62sbAQP6TJy95lkiocqiEPwGwN/MB7J+NTcrZ9v1vvGdvzIPq8MeLuP8y3?=
 =?us-ascii?Q?EqmX7KZgLrGwJ2ca9t4oscs3x2m8xRlNEkHT7zNP+46po11tlsZGqS3ZGaVX?=
 =?us-ascii?Q?Y3ZeXFEUdsFYLM6imDNvQ+FnQqkANm01hk+eplxG3io/VbZhzkCNWZV1GWw2?=
 =?us-ascii?Q?9dsvhKTVyMj1vZ0Ynlg2TLFn6k+oRFEZeJE5tWRPRheuCoyZc6k3nk8hYkTK?=
 =?us-ascii?Q?cKPyOAl6RsgUkDxUE7lELWtWsx56FgNxsTkrEMdwLhK8HQkScup+k8h3La/R?=
 =?us-ascii?Q?xTQJ25bvT2DJvFVlVXJpAvPxWZvbZc9MrMd6Deb3QKW/cIhhOs+1WHfoO7kD?=
 =?us-ascii?Q?ZP5gOz6Eg0qB4cCRCQ8vxB2qENOSub3OH/erfXzNwslLCJEpBVcDf5kvzbfX?=
 =?us-ascii?Q?I1FtxLTDDG6LayvSNzfrshogZf3KvK8pseWI63oRMJ0GepUkc896Xxaft+DB?=
 =?us-ascii?Q?Bj+9E3MyuCFIbUizhXrB09yTX+rfDXkqu17xDa9ebFrhwsfv828s0tZWT3wq?=
 =?us-ascii?Q?7VYEmnrovb9m7lSYyZD+uj0sSNv8ul2KWWZqlUOXBOoRIkkmERrRiwvt8RHl?=
 =?us-ascii?Q?haHJct8kzdrwqRTQFTfIMttoqFJUgQ8CKWthot2SiqUOIOGTAWjATwYe3fYv?=
 =?us-ascii?Q?GSxAxhTfFY3QKtPvPufgb2U6pDZIT6a7f9vF20XaWL6LF+25Y5ePmvpR1F0w?=
 =?us-ascii?Q?z97ocVRif8tGCNdCaDDaccCfowLcfOejwmf4DB/ljsEYucfdxwi6Gf/iCb7J?=
 =?us-ascii?Q?6V9gOl2F5KTWrqiBQVQpLIwCHK9bxWYbYHqYtR+J2ffvbyG8WUiJpWa3nS5K?=
 =?us-ascii?Q?7HCmBwPh38PTcckqmU2zEfzbhoMEVUtWSsqh8tKz7wjLyBwaTQrVPs0cPfvb?=
 =?us-ascii?Q?Z+DUbkYGqiMItpxzkg68qVhSyKdXa+jStikcQKJc/WUgHAt3lRKA2ioB0Qam?=
 =?us-ascii?Q?OxPQHyCLIduFUskvzeIYR/bd9u3CCAjWc453dsqsWQoKk437CeJCiNRyo/I7?=
 =?us-ascii?Q?GGmdfr3kS+YSZb9nEB/tX+nNlSCYHushHUOMxe28mwjUQzxYvDT83de6ISVD?=
 =?us-ascii?Q?PFiNCaXUdiQaT16f+ITseOEDTr64dBvhqf9IpKPR7yu0bMl0FsReePB1lxnl?=
 =?us-ascii?Q?XTCsjPPbQNcUeFQUhgCx0x5F94wNpqCa2rsLUzffEgJ9KCHC6MX88zViQ3K7?=
 =?us-ascii?Q?God+o7KWL2vk04ejqLp2rdqSBa20TVWNVjOKmW4KlNfq6xhxKbWeuZUmh5B/?=
 =?us-ascii?Q?meogGCkO/77YD3WVa92emyjiEgeKswaSFbkqvYqJjwNvKA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j4n4O3z1RAQzcdszouApZ+ZmZf+MszFxLhFqgRT99FFVTq+3ZLQaX03LM3dv?=
 =?us-ascii?Q?+XLsxI2IzSoquJYyLbfVcozSeh7Hi1IMNXlNmTRkIyOoO6MzC6hR4V/degHh?=
 =?us-ascii?Q?H5+Z4Sy4VxzzEZWjyR1dx4EFXq78IjOgribNPPe/SNHWVFDGdbRTifVV0Fs0?=
 =?us-ascii?Q?bBEdV3usccgvkvbPQrrmIwT/YnCaEmPwqLqRjG8U1EEKhnEWYAkk4+mcBy9R?=
 =?us-ascii?Q?PySjaRYT+6CKtYcNbBIfVzO2KPVFzFCoiwOcwxEBhgL0JqbqjhXeimpe3Pw1?=
 =?us-ascii?Q?TPnD0fel4teGpHOShxgwQYIN12JXObZB3hHWwDpfG48XqxZUo2yqRVPml+my?=
 =?us-ascii?Q?tTcpH6579ExZ5iErIESkTJ9baTAqMy7+awKpsOaW1xJ1s4jyAsE7DFmCJd6F?=
 =?us-ascii?Q?NN1pzKK2k8yUS//q1rauFvvv0C6QH4duCFLyT2BFOGkTOrrwCXU1/qDdpRC3?=
 =?us-ascii?Q?4AtpMYeqcbknpy1vrCiDBnf6KrGZigp1FSw0BPK01mGnF3qmdVYWlHreSJ8y?=
 =?us-ascii?Q?vNOOtnc2NcKSqpxb3NxyAogR2mBubE75C9mBQbdLN2DcuLkhhwKfm3rTT9x2?=
 =?us-ascii?Q?9yuHmZ/A054LIge+cdwCCSV2w6weF+LsFJx+sLNcu0DLZbAuv8NTW7TmIrWz?=
 =?us-ascii?Q?xf06ttm7fNCwOhLJlLS7YsPa4ewg/yMjdYusbdLWanAgzfjT8Lbu/k8ued/c?=
 =?us-ascii?Q?tOWbMyzxewK2TPtyZ/LWYhMBoAS+ZkYgVtw2m+xlDU2v5xojlFqmNZE0S/ah?=
 =?us-ascii?Q?Vae7eTgQjIAkn2zh52XbV/ufHPaz8gjmkCwPe0auIdteAJXi23Dj6nLjjLbO?=
 =?us-ascii?Q?Ta+5jnjuXEfcdA95gkz9iDso6dBz/RkgfrvFttUxem6YvWDTzsIUOcIN5rCF?=
 =?us-ascii?Q?x+M2aTnVeJKJnnqh8Ra2rOXfLPrT95ni1mQ5ipStVJiobwSrLXpbg4AXdRpy?=
 =?us-ascii?Q?7o9Qsb0SVIXcXaVWUjn2Avt3QfmqkwQz/t0CdDKvTfixLMTwPb6tD8pwNqiB?=
 =?us-ascii?Q?sLX3EUVX5Q1AVzoxa4ofO/XOewtVm5JaqpiwHse526pn5Z6c4aAWc2Pa6jAw?=
 =?us-ascii?Q?ho23QLepcQDbs/G2REQPiZcYNEHK680Rt8uY9WZD4OTIXzBdOigy1OB5GUlQ?=
 =?us-ascii?Q?EF9LsXQ7/Y/O9a3wncqsdAaoFpySQMYrnbJ0XkROLhVH0YNQPV6OMny6Meb6?=
 =?us-ascii?Q?xTijJecwtdnq/7lpDZ1/EZyAQHrnu4+whb7QLhzhYABkX133ht+t31OKkNKm?=
 =?us-ascii?Q?F1JQws3J980yRHy2Hhtr5W8X/zumTPE7T40mqAfH3ATIPSyrx35H6T8H5yXk?=
 =?us-ascii?Q?Cne4jjsP3FV1MN0c4DoxocaN0UrhQZuzbAZXi62/nOuCyssLBRXzCvTpLJVI?=
 =?us-ascii?Q?LOKUQKg7/mHqO1iXV5vTjm9bZ3zf5obIL+Mlq/GSQRDFiJv9ONIeBE/3PuQN?=
 =?us-ascii?Q?1dWsGtoq/QhaJ+isy4ty1XSL6ucKk5q6Sy3kNQNIdDlG7oI78FVeX54RAq70?=
 =?us-ascii?Q?ZMVEv7dnTM/WWDLp5d24OT2iiZ12g+ly/Nd8q16Y6F2I6wjOgOXj/qqLBf9v?=
 =?us-ascii?Q?8K3uFioN5tjkrTC+fII6r3rCqN3np5rRe8MbQSly2Hin5L04JBYHRlair/rf?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9+7hozd3mWxJk+6nBPKvPffeYU01Wf7153ExY+u/1FJsSneAHXntafVZZ8tikShHkbb9FpwV1Ns7+xqWLGk8dUH0QCW2fggi3askM/7o+c2eCarhe/S1JfNXh3EqbGfip6MqoAH4iuqzXrMCDJ0KIdF/nwvw1BS793tCGogKmuVxqpIQtbqR6wfXD5u9EwARVGzkmknhxivaeHgZXew7YQvzcSTr7A8gumiIYLY3c4+pdaNIAf56jK6aO6C3ahq+rV/AS40w2QRydbV+ro93NzFqj2GBLlMvHz8PMSjDQ2/P5Xbg+GO245AxunBK/sNFb4S/HTus44l5NK86LvLarkzrgLTj9GdAqCgjKjK7N0hm+5Ro1Y9+scIRae/DtmAtB4Vycf6Z8vhbCPUraqFckZBn4K7Nb3T0TAsiHi2Z/Yq7Apqls+OOqnA+FRwgXkCzTI+ZIn078SbVsmQKBdI3o2s8qoPYwVCMHUN4NDvbdwSNNa3MdSR42mMUlcjwe3Twu+JOLP01mMQio9qSxmV0ZDijLIKQAUa5UcXGfsTrdUuQWJTPlAeG3V3RfhfxjUOf87ynU7tLLp/B2gNNs5zJ4D1xL/urUtcuSg0GMS2Jl1w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740a63b8-03df-4cda-0706-08dca182d517
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:24:07.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4R2yCXtVK/Dj6G3+y71Yf9NqLtPNktDc1TiFC/ObEOO3Y1g604mpRZ9FpgURTWK0ejJO6RDFlsraEa23as+jgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110058
X-Proofpoint-ORIG-GUID: 7GVPROUhD3SbAs4x4i927R7qcvGJD5uu
X-Proofpoint-GUID: 7GVPROUhD3SbAs4x4i927R7qcvGJD5uu

Add missing entries for req_flag_bits.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 91396f205f0d..cb22e78c1070 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -230,8 +230,13 @@ static const char *const cmd_flag_name[] = {
 	CMD_FLAG_NAME(RAHEAD),
 	CMD_FLAG_NAME(BACKGROUND),
 	CMD_FLAG_NAME(NOWAIT),
-	CMD_FLAG_NAME(NOUNMAP),
 	CMD_FLAG_NAME(POLLED),
+	CMD_FLAG_NAME(ALLOC_CACHE),
+	CMD_FLAG_NAME(SWAP),
+	CMD_FLAG_NAME(DRV),
+	CMD_FLAG_NAME(FS_PRIVATE),
+	CMD_FLAG_NAME(ATOMIC),
+	CMD_FLAG_NAME(NOUNMAP),
 };
 #undef CMD_FLAG_NAME
 
-- 
2.31.1

