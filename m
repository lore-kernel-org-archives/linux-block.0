Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F347285065
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536688; cv=fail; b=BPABPzvIRkPllg7sTfwnpC1uKbcZtlTMVUUl8e0YLny1/KVFkrkymPDcv1lKA5byVmJ5hqG27NaFYSIXlyj9r5U2PN5+HL8saXXR/yggmiENAIOW/v4/fJ4+taGWofg4bd3ti7jgDFOLqaxeW43DCYr7TxZcBvCUslG8UjOcGn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536688; c=relaxed/simple;
	bh=UOnZ5Nnwqp6QVdeAhPQRfLl2EizYaQSrIU+h+uWSJ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dRvVif0dVW7KdWOmdz3jK5gAp2HTfMynDtFTRT0yBFBl+2cOtAGzBW2eqANWxZcb3+Jv9P3TzNRoO1jwz74dXL3jgZArN1PGbQreHmUzduNF42V9N9ut0ZogV30vR21VI6VuR/Quivk67nWxbQd6mAzJaPEiQuz6ddRq76kDjRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QpzSHoja; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HJrWNHts; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QpzSHoja";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HJrWNHts"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7OEje012460;
	Mon, 22 Sep 2025 10:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=VPpASUAczNtpEivQ
	Cq27dNQk/5qq0fH3I/a8S83rd8E=; b=QpzSHoja6oyEIliOmid5dM4+Hot04jn7
	IiTTrqGZQPgTAPTfcOczeROQm1qAy1Mq47l6giZbHxGp80FzgBAkdvlaHtiD64oC
	sO48KR4mBWwrRaftRVhgBvec2Tu6kyTvoxnVW+sUIJOtaRR+XG5wHFLE2WbFzYQp
	CNq/jntBqYJyK/texuivSGlOPZjf+0eFzOjUqlq4PF3t38nP8+hlPAyE7vGSMvDv
	PYDVrRz3i6OC3Ff/TGuVxM0AFCRH0Y0rfNzc60c8V4MfFsQAurBZuZxXSimfoaFu
	itSolxBXcpQNeiDN065fOdE2GcJFnNHUBZaF2I+mUV/eQ168SuVUiA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k6at4ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58M9jZcf034294;
	Mon, 22 Sep 2025 10:24:44 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a6nh41u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqAHwNj0uz86ONC1LZrw/X8c2pLq9HFLoTpKcgt1hk8Oc1YNIg/e93FHJdkZvk8bg5w7qtAXgSs5ust0g90d31AB0DMN+9Dj/6KiRZB0WPbYhnU821/u3D5dq8z1tkCm1YAJbsqNGWUc4XS7rlAqtmP8j42N3hiJCP101IfeCGtJqllfluJ25fguGaL9KqabHsWmAJj8jddZGuIRJyqyGD65LObx0msrgA28bu2p9QadGMR4Yr2+tJ7cZbM2pWllDLxMQ4dthgMl/TCXsLuWlV2VJNRVjeRvFBaQDNwg09vV1mzGDJXQOFTKT2+2mKpoWvGzu7yMrajZhGM6eAKJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPpASUAczNtpEivQCq27dNQk/5qq0fH3I/a8S83rd8E=;
 b=gkZL5O3iyNUI8eZjzjN0f18hw77I7AJGKolCTGX6A7sryaTETypl900Fap/LSYq5JNKED2TdyW/5cei1/fQqIIjZSVJfGVC2UF7t2KkuoaICpU/B6fSCbhyL/bSLWpoVdCwWcaw55pj7I97z6hMBIT5HgXiNo29V5j0U3jDzuq3fzQsM922nkIXQh92hjcK7zL+CwV0rhEV1ILcnie5dyX0i3cPWtA/jLRDfMyytEHR5Vh/VlRlfCrfMsGPbD7Pq6E1anpOWhooMDqa1mNZErlfownKhyTLF9j28nCmDu1Co3UUSZmaHs/TRx5zA0IzxLFvmYnS3PMDWtFvaWmDwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPpASUAczNtpEivQCq27dNQk/5qq0fH3I/a8S83rd8E=;
 b=HJrWNHtsiAiCgUNp1zpqbl6UiIBMD4bAVko7wrMyu2tMkpQal32w1zSNDW3paAv3eUQuh6jvW5JM1sDC/KI2Y6Ir6GQKR9h6YZ0LeM23yqxnJYBTAz9Xp6VakFDCMGIJkawDoVUiP8IiN0WXxr2EZHD2nVUcYR4X6tYRBWuBTQ8=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH2PR10MB4293.namprd10.prod.outlook.com (2603:10b6:610:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 10:24:42 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 10:24:41 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests v2 0/9] Further stacked device atomic writes testing
Date: Mon, 22 Sep 2025 10:24:24 +0000
Message-ID: <20250922102433.1586402-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:510:23c::7) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH2PR10MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 307b50df-b0a8-484d-72e8-08ddf9c23dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9CTiGwHZgsEcVAUKgtNj4iuwBwA4EfQfAF8BRanPjazirjcjJlfb7uEZABMV?=
 =?us-ascii?Q?qWfwAPmo1CpDjkPMmH7jmJ+ttiDWwRfzqmpFpyuYl3bBOGSrJYqdIsl6M/SR?=
 =?us-ascii?Q?u1vEOU+uD+bjFCDVPCcddqNkzoq50dlBO9ZScy/sSp2db9O4ppwQICmvQ6ZJ?=
 =?us-ascii?Q?CdXWXFOKCHiI5JVz83WfKYhSWPtSI+aeZsRN/c1V7Uhlo/p+3py8vrbqryMI?=
 =?us-ascii?Q?in5UUExN1QA7abgLBicpyOQ230ljgfn+FnzwFPa+hmN2fJOfy793897xd/XP?=
 =?us-ascii?Q?604/46XwfRc4LYw+OcEs6Q9VCOcvSPFLXL6w6dZY1Ko6k20Iz8Ozd8FqRfyA?=
 =?us-ascii?Q?Se3NNVfT+TRi8yfaCk6Ybrc8hqYFFA0oNBq0uAdcnypYMqpy3dH/fqadqwyC?=
 =?us-ascii?Q?74IIQ0G1zxqkbwyZjwSl7q1mi1qONo6q2vt1RIM4kLkQw8IM/LLBZ8acqTyb?=
 =?us-ascii?Q?JZ/pPSKYmCS0N2LoX3Uu+iNq6lPcr4gof43DvJUd4kKaR5dELWq51SNgLuCv?=
 =?us-ascii?Q?Lh9lJ7gUZ09uRID6rAWdz3aZNw4cKOtRQ0yczX+n1V83DI+Td1p7BTibudCQ?=
 =?us-ascii?Q?aELpWqYA9oGgelBTdx67eWaQtA8Oa5LrYShwrjGyQcWSxEZ4/YvHvzMGTKKb?=
 =?us-ascii?Q?VezGS+g/UV7n47ShL21IuvMNhIIyW3r7ViFXmgSes9GxQxdXnQX+wgmFC0qG?=
 =?us-ascii?Q?suGlBzCZjeR9wSodKSq0JYYLVclAhIYdjb6xJHQy6JU0+/YOUhZ3p7Q0WP8M?=
 =?us-ascii?Q?a0oNDVtQ+wjfwyrQQs4/8vLHKWdeVjrRMR2sfVxjFF6Rid9MKE3fpn2QS4y2?=
 =?us-ascii?Q?g9GEb/WAB9H+j/dTa7LJ8U8DFHmeSAhaFRb3wpbrvuwXIQVjtU1esuIMud0g?=
 =?us-ascii?Q?sRYxs1pu+5ZSwLNHts63qkn5LQXR+EVeHf5IpUlP7cJ1lsx99He2vrBohIxQ?=
 =?us-ascii?Q?Cf8rzFdNse4QhemfnnN4RiKvhtyJmIQyWTg00ROpLu71lHfmVa25QxcI+5t+?=
 =?us-ascii?Q?HoNaYlxYgriOxRdCIjK1NfLj6TKOKIHekdNemXansThRrSHWy2R40P9GlDZE?=
 =?us-ascii?Q?jkvd85KPMO69q2r2PVo8pL0TIWWp7wokhZ/lsRsUyIszAnjKJg6EnLx9h8Kc?=
 =?us-ascii?Q?5xiZT6L7geY8aPpxbtHODZUZD40NYsyo3NeJVvgx1mA2C6+/+fj2XTDUSQrM?=
 =?us-ascii?Q?xBr3Unud+Ih7sEFv5vRa/VUM/J+H5seBUyUgSOrr6AJJxX6R96kW8/Bq5Ukw?=
 =?us-ascii?Q?iPcyyflHgoB3E/WZ24Tt35xKqCAGMeAOcM1+8C++AW9rA6swLhiseNUYK9dA?=
 =?us-ascii?Q?rw7DLOL6VkVXiMz7LJs1hV+z43cEFkbo3T16JO6SoK/tb0WvDnrgZ1yGbs9O?=
 =?us-ascii?Q?sgrI1X1rkU1NXvWfxsiTuAM+Gy+2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IRBDD//5EPYWh7+HCkLtY4JThupibCd+N5VQoEBC81p1QmDZLwA3F9T6Kqb6?=
 =?us-ascii?Q?zgYpB9sZIAFfItjbxBGenAOUCUn6ry+4fLeQfiQBksElCQb9QV+ig1/GT4Is?=
 =?us-ascii?Q?DASkjx/ZUl+m+nWd7/YmqbmjQhRhW5sY3mIudlyuafua3urgzQNxTHk70yGn?=
 =?us-ascii?Q?Dm8jbomGrs2QcJ2rsizTlOMJS15X5o0qbKuixOaoU+wRrQxuGc6FLlE/0HAo?=
 =?us-ascii?Q?vwlLj7MNUJVwlCNo0cxgzns4pD2qFHtxqQhgH/fH2Kq+rRBNN4ZufMbtnPeb?=
 =?us-ascii?Q?qeR24BuhNHs+nRD7BtOLyMX7bmyuvImABSDIm+Baf/+K49u9S5enNywFhZmI?=
 =?us-ascii?Q?hs8Ua+hTAHCdx+1d3gACcv2JA+H0UviaF7iNgAcRgtD2h1BS5DsWQYJZ3z49?=
 =?us-ascii?Q?8lQoWIutYtd7n7wM01jzQypDXYKWMiov0T9KqOviLpoSy/RloY0h2vh2PSW7?=
 =?us-ascii?Q?rrI8+dZC7hReEb88RVDfhyC1hBjDZN853f5X3VKZLAg05bfB2LhoUTT4SEgz?=
 =?us-ascii?Q?ncoGUnFQignLV5utYv5nOqRIsohfeV2uV6oVn9F7hQGxTRQ00LDntdkAUILZ?=
 =?us-ascii?Q?ZjiytCh54iug73aaGqp+bYdG4MFDt6u8FLvR/lTHdjwAffkbu4Lh1Y3+qiXw?=
 =?us-ascii?Q?gg4ivppxvv95FEulwheC4DKw+0UNzrS/wtDk2UsLaNiLwCQoy+46RMuHirPn?=
 =?us-ascii?Q?rt7GPUbsVZU1GeAOEbkk9IG6jJS+yP1tYxtF7l/r3kde9xAkcbMzsSPpvVY1?=
 =?us-ascii?Q?BZcovaODrufEo4iA5FpHsjZVooIbkmZwC5MFDzqMcrfOiCm6XozmCcL2mYdx?=
 =?us-ascii?Q?Lwp28zXrJbcpXmVWMf9gZrinIMtEW8SNyOWp2AWuMMUAnYrq6GASjuH8TCcM?=
 =?us-ascii?Q?Nz0g98Pfs65JdYIRtVycZF7jWqtMVmys+17Pb4eD5qIYqC1O0e14VnGhdANQ?=
 =?us-ascii?Q?3BJw3TKR48TM2/fwyzqapKdEWzHtXSkKv44HPtGYjgpmYDMQinJqSQeusThM?=
 =?us-ascii?Q?dWmudimHl0ut+e+HrgIC0c41Xf3URcgJOohSviv6MUqmz4PYzZxcneOENpow?=
 =?us-ascii?Q?syIjIXmERiY9ISXJMmnuRm+EpdAMGJ2Wn4gRIJtk2GC0Tn+vrdpyNLPWuLER?=
 =?us-ascii?Q?A/4KTuXeX6G/6DmbtYqyhzugCf3drCI26LzN8yFckMhrP/AjqSj/IavsjXyO?=
 =?us-ascii?Q?2QfHotpiHcZxRT+TYwApHvXZGvqB6Ttgc6DuexiJH7nUfjIIYp9/ZFukVrmE?=
 =?us-ascii?Q?ZLH8qbQrsIWGbWtwfdvvBysAP64kUHCtz2K+q0miFNQah+t9IrXapi7151ED?=
 =?us-ascii?Q?j7GxXjBFUCW6EcDUgL2UCsnkx8ypjBV6l7byeBYIaXKPQNZ7qaPJNAT8h4y8?=
 =?us-ascii?Q?oYePd1aLOEMEwNzgfsJf20xEewooxjnMrEptO/tVtqwoOutmAoOh5s/AW0gA?=
 =?us-ascii?Q?rs2P7N5Evra33lLy/Ag6BX9wySJ53lMxl0WhRzz5ywJsER0/Fdc7Y1fi/5XD?=
 =?us-ascii?Q?ENCkPVK1CuwENkYgKv9EHkZRwck/fW4TLSqMXpT/QOyPnGWbptDGluOZxQoW?=
 =?us-ascii?Q?3WnfbF7TLhXdzAdYRmno5KhsjrO5ZLgQQrZR+BKtDJk/zAqpXX7vFki9Bl9G?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hWc7NnInBh7nTMztJnfnwebMWWSojnH+rWdGc2qF8S/ahT+KABvvfo98Kg4Lf5tulTzov9UZNls6kRA7hYBKzqhXbRYk/PVRfgxJqCgSQw7v+grtJ2dsfFkE0eUagbfmIHZ+iNtmQAqOnF74HAZwtO8mOdcaxqnDl5GTOV+eUFc1J9vRFyo6A1xAQYw4Q+K8W5htz6Ik0me7cv927CGk+QJqZUYaTnni3intfK3jy3zrYBkOGurs/H1GPxAuNrydMuktxo+s68KqMBtHUfHN9/qGXgr3KTX/aYC0VbYm/ypW2Sn/CAhLnCltSO488hWO8Um29a8KE/Rs/9UvriGtd10FmU8YmXPrVa+FhIy08X9mePFtnZ0KnaARVWphcB3B83tAECKxnbnddBLQP1Qw1QMjhQeI83VpI7+GGNx7Qqk9c9c5ltuoFmg5nHHiUrslv//QqDRa6p4AN04RcjU3zLHUZISEBvDpGSmm1DhbsvIgKJUoLlnfwz0U3ttLFitWC0L/37Y+EllEkcyiW4BHvHdEfVyT03WyRVc3umGHdQWjnwykjTJze/V66ccK60lvnPtpI5HqHxkz0VOzqRWcRGQ9MC1/zg1svbk+mGNN8xM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307b50df-b0a8-484d-72e8-08ddf9c23dba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 10:24:41.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ed74ePnVvHT5WeMOtMh6KiU6i8rmvDVPhR5b5nhqjhDzlDIx71L47G2pzKnUmQ0g25eyAfSYuQ1zfHN5vIrK+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=844 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNyBTYWx0ZWRfX6BFTp/pDdTJw
 KZ4ET4BknMBZFFKLMH8aql3X3q0TC/LfLm+d3rivIQP5IRD2aeOvEFF4uzFRpg0acWBlJQQDMqc
 3DZiSlfbmgIpZsEERqt/VbSxdHozlJeKL4OtfXYIvmulEX+j6+A9N+30QTSUikpRr4Wl/nz8anG
 /sPwkFLY2+TEc2I9bwfwlzEDTcBGzt0VWDK4q00syr3wUe97iDvpZ2GpNjvk2/IxbhXNY0Hez18
 j1pE2dnCtY/vbOCASPp7q4B93G2CbGMVTZkLn1gSnLWrCGGM7YCILcguWFa7W4PsoH0HFwXsPQE
 WDsqq5IkmS0KA8le7A8kbToaGlK6iYYuJZO2Gn/EP9ms7PN0pb1rP7vuMepeYtz/oFuEzuoVxgi
 aW5AUOHe1mDd+MaedrJiHDSP5xuuTw==
X-Proofpoint-GUID: MygLkquXLeQQeV9wI2jZC35AktuLHGXD
X-Authority-Analysis: v=2.4 cv=E47Npbdl c=1 sm=1 tr=0 ts=68d123ed b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=vAlbc7qllH1ULR5Eh7cA:9
 a=xVlTc564ipvMDusKsbsT:22 cc=ntf awl=host:13614
X-Proofpoint-ORIG-GUID: MygLkquXLeQQeV9wI2jZC35AktuLHGXD

The testing of atomic writes support for stacked devices is limited.

We only test scsi_debug and for a limited sets of personalities.

Extend to test NVMe and also extend to the following stacked device
personalities:
- dm-linear
- dm-stripe
- dm-mirror

Also add more strict atomic writes limits testing.

Based on https://lore.kernel.org/linux-block/20250917114920.142996-1-shinichiro.kawasaki@wdc.com/#t

Differences to v1:
(all based on comments from Shin'ichiro)
- Rebase on "support testing with multiple devices" series
- clean up "make check" issues and other coding style issues
- Relocate some NVMe helpers
- Add _stacked_atomic_test_requires helper

John Garry (9):
  common/rc: add _min()
  nvme: relocate _nvme_requires and _require_nvme_test_img_size
  nvme: relocate _require_test_dev_is_nvme
  md/rc: add _md_atomics_test
  md/002: convert to use _md_atomics_test
  md/003: add NVMe atomic write tests for stacked devices
  md/rc: test atomic writes for dm-linear
  md/rc: test atomic writes for dm-stripe
  md/rc: test atomic writes for dm-mirror

 common/nvme      |  80 +++++++++
 common/rc        |  11 ++
 tests/md/002     | 219 +----------------------
 tests/md/002.out | 238 ++++++++++++++++++++-----
 tests/md/003     |  45 +++++
 tests/md/003.out |   1 +
 tests/md/rc      | 446 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc    |  80 ---------
 8 files changed, 784 insertions(+), 336 deletions(-)
 create mode 100755 tests/md/003
 create mode 120000 tests/md/003.out

-- 
2.43.5

