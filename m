Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6FD34D4CB;
	Wed, 11 Feb 2026 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770842413; cv=fail; b=pokVMc6teg6XLhBCZN+rXvf3mndBeIenOnrChUL9tv3HKmjvMAmN1GqZ28nzhVjIuaQZfUOediYNK7RovK21gb0faLjDRJlsmaPh/9S02hyY8hTwT+FcrsimJs6r7MXZGMszlYxKYGJSgEi54CI+y5I703un72g+HLdwWG+yxpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770842413; c=relaxed/simple;
	bh=AiY3JEdrg9BFU4K27s5xoBBukc4ZgHhXKAIkumblTUg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IW1D2p4Jo/SIxRENtRwvUnLTmnnJQs49PGbdj/VsA/1NL4Oad15MfqsA9ZUrcPCVhPY+g1We3Zlylp+3q2tu6HZMi5wczlLC5b9T396bRC3VKhNhDMKR37qQp+4q81i3qSDvaxzuwKGzxdH0JkwxB6mCb2h+D1s6uLIXXMIp1d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=g0cFVLrX; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="g0cFVLrX"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BJaDBb3316021;
	Wed, 11 Feb 2026 20:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=AdsSIF4N/
	CZUoeUNnoDJOn66lv4San8Ep/+geXAAA+4=; b=g0cFVLrX+1PcTNaaCxpi2irNA
	+UOPJUSQ2Wd4iSvS2NQ/b3tq2Q0yr0ZCibtwwj7bQBkxLeePtArlPPW9vwfs9fCq
	/0oyik85ICJZai8cwwkVbraI+BrI87sKMaFKfdHaDfa253adGxTSJXUfwTSQFrfP
	gtgTnXEMxzeTRESmUUt9i4Ab7SYi7AJZ9tZZuorb2oN/4Yau3qXLzcxO3fHE7wZC
	Sn2dRG2/Pkn2kIoP/6I2iEHNn0Si49MnCjGN2GRN9wp5wex+QUPB2M5chO0sJmUe
	/IoUn3SqBJEqaeUj98JF0qnMWUGwnwtzduhBU7IGW6kHRfzWghTZYCK1nw1iA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c5vc5d7we-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 20:39:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSDKBxv6lV8Tb4V+fxRPcidSqCIqYRUu3jlE8DQaV4LSQd+pbwxpXdk1mV8TwMQHxZvaJmxA96gMk0Hom5m8wEk66YY3zNaU9Zdnp8MNSdW2hcRwGxMOYxdcs4JwCssfJ/16OdCREnB2hFTuQLQ0tjrfXfBVJW+8oKOEJLuDIIzDtv3tmXSqTDZv3xZmU33GXf5jvs1PArV/gXXOed2juu4IHV2bisj7TXeQHa4t9HrT/YRdpOpfSMNBpnI8NcSM8O7/z+7iDzjKVFzaNW3JNPllGNRp+63b8z4mQw1TIByd+oU73bnbmTPhUGB5amAV/I3QMmz3avKUfI3k9KxxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdsSIF4N/CZUoeUNnoDJOn66lv4San8Ep/+geXAAA+4=;
 b=Sq54Nb4zfm+yoliBhg2ya6O+bsmRKvTnglwOXx8CoGroCQNzVLHSOtu+kgSvZgX6FGb+/q+b99DEQSOEpWNIJScvT5aZs/icaXhgRjocVw+zBkZjGd0i4uWHrv3ALx0FHWVInweeuFE80OEGTUPFoS//9gN6eHeTTAWyN4AB6eDGF9+qieU9jgsY7kLwZ+8hFDjea40LVnPGeK/PvA3siAs1Y3jxkteGLbYf+/qaGNqaz+hII1i8UJEhzkeeTs8My8QtpnAU67n3QI3eJP/PkkrZpYxVO+BNJdhRsSghxlsGbw1EwaYYzvH+LpkU++nl2zfP6ngJ8Ut5BWxFpu4RMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB3878.namprd11.prod.outlook.com (2603:10b6:a03:182::31)
 by DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 20:39:55 +0000
Received: from BY5PR11MB3878.namprd11.prod.outlook.com
 ([fe80::5836:a4f7:7e05:d23]) by BY5PR11MB3878.namprd11.prod.outlook.com
 ([fe80::5836:a4f7:7e05:d23%6]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 20:39:55 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, ming.lei@redhat.com,
        muchun.song@linux.dev, mkhalfella@purestorage.com,
        bigeasy@linutronix.de, chris.friesen@windriver.com,
        stable@vger.kernel.org, sunlightlinux@gmail.com, ionut_n2001@yahoo.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v3 1/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Wed, 11 Feb 2026 22:39:29 +0200
Message-ID: <20260211203928.324307-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:802:2::41) To BY5PR11MB3878.namprd11.prod.outlook.com
 (2603:10b6:a03:182::31)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3878:EE_|DS0PR11MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 10331655-47f3-4b5f-80f2-08de69adb6fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lc41Z5oCCM/vcnUuLPkEFXv/cVuKuNraYm5qaxXWMBOmo3g45ydLzqeaMFK1?=
 =?us-ascii?Q?QKB085SHU08uiFL7v0nJcGCSGPedO9kgUxjIK6PX4S2d/azSVorZf/nMzT1Y?=
 =?us-ascii?Q?NL3G0Ka0o7kYqB2igHp6rRYpcz5h5aTmn/aZ4I1Na9ItNpvO4OMUpkJZ/zSw?=
 =?us-ascii?Q?S1/lYflhDgaKGiusFoy8J08iac/Ijl06PtGtiGGM3c676+4e5Qts9ir+8ikS?=
 =?us-ascii?Q?rNEUmIlRkHK5MWBK/qPxgyU39eUB6e6F6AkTVDd8CfkdR774QMvo/Gl+kuSw?=
 =?us-ascii?Q?Qay16KF44Cf7ob2qUI49MpPfXybdss51PqrkgiJxGQdco9ckJ4U2gRO6gCP2?=
 =?us-ascii?Q?cBUH6kykloLT/g7hCUPxAV2imDTtBypRlieqpmoTPs57Dez4Xkm0/7tKoOvU?=
 =?us-ascii?Q?hBMZAqBgcLuhYB21FEcpSTTY9+mPS3c7RC1w7ZsbmX9qvNtz3WGqsXoBSBdr?=
 =?us-ascii?Q?ldBp10mIXP6iNSZGceG8CddIvMjPFz0433Aom+UVOJOsDeb6laRs93vMVPVI?=
 =?us-ascii?Q?9ERWgA5d8tWKYjuCV28mcyRa8NGKu8z97NUxgIp6vZgck5UBIjB+dT3NV5VN?=
 =?us-ascii?Q?V0rcO7i+x21IzC+CnzcZ5HGqEKMemTwqu7xm+30eDTMa0eo7PchWVTEsbaLp?=
 =?us-ascii?Q?MU2MH8XJosMlZJmaRbf/FcLMOMkEznUqqlIaqBRogqBuCubKcPlIPoDhqEkB?=
 =?us-ascii?Q?zCU9D9vUmhNgNO8v2YojqJnbuB1Z6P2OiUGXfFjlhlnWiO3iRUNCrWg8zrgY?=
 =?us-ascii?Q?m6g8s6I4xet0sIY+lxwUJ+kk7zO5mUdZZesDneB4XPxZAZt9LdUd49Y7RzfJ?=
 =?us-ascii?Q?Lrd9b4gDtRUrnH7iUtMSj41nhTjb1j4M/sVO4NzjqWVM2AEmqHZe18oYK+DX?=
 =?us-ascii?Q?o8W9N5MUu6mGN7LGd09PF+7AVxmlUR9+5rZVWr0F1bi3hk15snrG+TuOMbFn?=
 =?us-ascii?Q?bBdxqQpjISHfVLVH4ttFyFb1ycZEvQAIRV7xJLrjoKk/6pm4xaS7+nW8b3lf?=
 =?us-ascii?Q?e5+aEoLNYbBk1ejs6jaJLRtz964oekra7Z9MGytM6FqwoCrOsquRRcKblr/a?=
 =?us-ascii?Q?EHD33q0g7O1E5Cns5z+l+ErWirtKgdG4UUhJqATFfLCrE3gTDHpjSQ0+HMpq?=
 =?us-ascii?Q?bqgUJAOzV7MZ68TWIHjFKDo5EIaP5eJ2K3BGc5W2WHtEn06vNOjvhIZrdxx2?=
 =?us-ascii?Q?sGifQjQPJObohOC/3KvBdM8LgPwR7N11wSomsasaJgNnTtIsyzqLOg9Ra76x?=
 =?us-ascii?Q?BQbtBxMLc+uVM9R3QR2qUZ8OC1iDwbDWFx2zppt+2Aya5UGCJukVMm2N+n24?=
 =?us-ascii?Q?3hIOKr/ccS0p7sS3CTXfDxe6RBtIqQUQ+Qnb80zxqPU1GM5gbar4wrRyncPH?=
 =?us-ascii?Q?rS6kq8BB1+T5f0906iUkkgHsuK/FHh/76AzZT1X/MmPNcWow5YLPjtRpPfjB?=
 =?us-ascii?Q?wIINPJgb9Kw9DkcQqJng/wWBDNVFje0YYAMRX/BRfTizCTTkpaKLHjgcj0d7?=
 =?us-ascii?Q?3I5K8sqQ3eTwgMa+iV/vcOzTA4zX6St6szLPmKBdXAbw28s2FBCFL5CW0T2P?=
 =?us-ascii?Q?BzQK+ZdQ34w6ji4dH/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3878.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y822q5CfMyfHZ7dXEzjRreSSdOr/Vhhfney8Z0tN/iaFrB3ZNdr9aQib6MYy?=
 =?us-ascii?Q?GnmhTTKv4O5c8eWXnSGHhxht1PHqdQ59ztmxBvWzxuF30pn9CnvQLhizYnkd?=
 =?us-ascii?Q?GK9JrapTfFobbgZmF2wSWfi3rTsmmR9rhwlJFafocvxEX9b3dixayNC2prRU?=
 =?us-ascii?Q?Ld7rB0MGD8jJgk4jbxAwcgBLVGu00NIKkMJmvgVZhNeTm2o5YV1hMjoxyLwI?=
 =?us-ascii?Q?uB4lVa3ganegVdpTYcy86saFi4Tqk7nxuzSO9KmNQFLDpl3KyPHRqPT+WBsc?=
 =?us-ascii?Q?Q/c6lhDrvEEjeAZUo8rjcaSuiZrciZ+N/7g2jiUlayguXEJWQg/43muqbNor?=
 =?us-ascii?Q?H7otunTkTmPeXEYrKjv/lX5yg29CeJD2VbfES3f8WCzkJKCD5dmTsAB3kkoN?=
 =?us-ascii?Q?lloUmuoRylWDOsPmlFJRi9ajCrLJU6pW22vlSA0NYRy0h1Ze7bnQ11GqtR3k?=
 =?us-ascii?Q?PC9qKp3pbUDWi5KXiUKVmVoCN3LteFPN++5fRmN2rb2X//zM48NSsHQxMLBu?=
 =?us-ascii?Q?MjknehMcA0PfHdlRX8cDC3RLuNzYS2Xpfa2u0Om8/sCYaN8YHDcwBqsR9XZh?=
 =?us-ascii?Q?eRGI3sojzwKE1f4+0Q7SxBHJU8ZasZsuoP3m3jZZ3XP+RBDssMomKFUw6zJp?=
 =?us-ascii?Q?FZk9JMNIU7uDEy79lb7MvRjOqQj4Kw16e4zp6P6as8q+REcucYzmctWCzgAu?=
 =?us-ascii?Q?NyPKUIbujOid/9/UJDPzD8U1igbwT4rqgBNruDOHl+qGrXWXz9cjHUzzZA4c?=
 =?us-ascii?Q?V8WEiNXJe0Yap9gItrt/r8ylZf2CMDMmjBLXR7I2n5QrCuleuyJEAgSiHmOG?=
 =?us-ascii?Q?k4hraKjfL8VGJC7ExQyPtebU9nAgdOb/IZEMEQW9TEdKEx5jazJCwy6FfPR3?=
 =?us-ascii?Q?9a05sSktOVRbcgSCULIpqrQvxvLALYJVZe2zDx8f0ENV27VnhYrkFE6/i/gA?=
 =?us-ascii?Q?cCqmaW1HEBj6s241lNzfJayDyQddiXuFBdqblwJn/UCNFUjoueXl5obZSjcn?=
 =?us-ascii?Q?BSHAruzhc0GXY8PgHlgU1EEHIVtJZ7GOqv/imM8w2VzCnBRkxlrg9za/u/F6?=
 =?us-ascii?Q?4PN3x52OMDrJNOovHai4szqvZ8304DixpdwBWbq6P0bC6KuKXEcFh24O9kOD?=
 =?us-ascii?Q?9OeSrcQxEScSOqKt3uTuSKDfpx/daOG0QIF3a22KGywjCMADrqnf90+2h9Ue?=
 =?us-ascii?Q?96VlEVQd3OdYXeTIMjTWEquMpFkHmfhLgaTn9XF99UAZCnDH98a2dHDPT3WX?=
 =?us-ascii?Q?377CSnEMCyvqkeTKqdMen9r3qRHUHO68psKwIlgNtnY7OIHHZ+57/ZO+rAS8?=
 =?us-ascii?Q?kiPzKG/+styZG9s/pmnynFSrOK1RvceGg1x3Nd3z9hfu6DsqLqIZM0tu3Rat?=
 =?us-ascii?Q?NbMjHahBE7x42t5CNMfLvyXH/aDTEb46inHjv52shGQiChEUZs9fnmajSTy0?=
 =?us-ascii?Q?5Yu/qjyEg6cXALO0IfyLE/eN0vYTuB+m1Jy4SkJ8UKB3sZQZGwxhRjNYKe9i?=
 =?us-ascii?Q?VJxGYk5qC/Q8oOJq5tAz+Jtu28al0mZ6z/Z8q5Dgt5V1uOHoTKQbZtQ+VSsB?=
 =?us-ascii?Q?Bl29+O3/AxcS/4TSilPSf3Qlzp30jgQe/meS6SJSjZMYiPfMMyQQUMAxe4es?=
 =?us-ascii?Q?cRCrZygJqrnGuTvHbAUChxOfEAJ/ynOd05lbuYTnmqOkIWhFKflsqRIgdAuD?=
 =?us-ascii?Q?aOrSDR1iBuwd95VF+7rTwqcGC5hCO9JgevM1HNlTVeWxMtXMXlzK2G4GKI5L?=
 =?us-ascii?Q?fu3eOvIwTh12/c3sZ3e6+4czciS1iD/IB3Ci/LLVeA8x7uYIQOouDnooyYAa?=
X-MS-Exchange-AntiSpam-MessageData-1: L2O2p6nsmvNdwDlBEq0bye7jog2rg4kS0rY=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10331655-47f3-4b5f-80f2-08de69adb6fd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3878.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 20:39:55.4757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqaSW8U10VXDOaoHHtFlfPZrmeIevViKl+2nrsiz2o2JLy520uIUh9pvxGnOxXex5NbhqLirdknOW64KU+6sS4AAa9Z7jR2kpjzWK43VeOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8182
X-Authority-Analysis: v=2.4 cv=dPyrWeZb c=1 sm=1 tr=0 ts=698ce91d cx=c_pps
 a=97Y4xzKGYTGm8d2IOhb7pg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=8F8sayd3OLXzmNd1YCMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE1OSBTYWx0ZWRfX1MbwoygMtxxt
 FxGmkqWVYGgPjWjtBJ3/WanfRxLrYWUL5KnIccWC15CnUPKTJjSdIYGRrupyA+/NNwYekAHmnw7
 XEVGRY+jU5Wqfxnz5OH6qORcRDVlXJur9hS280xid/aFBbFN2YRo1+jJ3ONwE93DtuEZb5frEAK
 g1HqwviiRm5/Of1zhoxekKfZc8vpf1RLyiK56/1nJPIA4YwoOiR6UJpeGgIz63bh4dUzNXUia5c
 ZVwA6aVDs097goWSXITIibc6kkfDSz+8uliLmPuTlnUiF0HhVwsHV4QgTp0jgCzO7bJUWOOhzgy
 sgM+/wXWPioGZTL3sT0BeVfli5qxnXWi0CJNRk+wvAh5J928Jqr60CBCa0aaAmFgexF//iF5uaY
 fvBvUqeocyyFkiksJqtOscDBcpRLQmjSVoykL/r/C9gdSjoN7xi6ESRXkPi+tpC4VBdUBoVGKj1
 suXzhbrzljSKi54V0vQ==
X-Proofpoint-GUID: _XoQY5aAxJUnAmqzpqGbSeGYL5b5yIww
X-Proofpoint-ORIG-GUID: _XoQY5aAxJUnAmqzpqGbSeGYL5b5yIww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110159

From: Ionut Nechita <ionut.nechita@windriver.com>

In RT kernel (PREEMPT_RT), commit 679b1874eba7 ("block: fix ordering
between checking QUEUE_FLAG_QUIESCED request adding") causes severe
performance regression on systems with multiple MSI-X interrupt
vectors.

The above change introduced spinlock_t queue_lock usage in
blk_mq_run_hw_queue() to synchronize QUEUE_FLAG_QUIESCED checks
with blk_mq_unquiesce_queue(). While this works correctly in
standard kernel, it causes catastrophic serialization in RT kernel
where spinlock_t converts to sleeping rt_mutex.

Problem in RT kernel:
- blk_mq_run_hw_queue() is called from IRQ thread context
- With multiple MSI-X vectors, all IRQ threads contend on
  the same queue_lock
- queue_lock becomes rt_mutex (sleeping) in RT kernel
- IRQ threads serialize and enter D-state waiting for lock
- Throughput drops from 640 MB/s to 153 MB/s

Solution:
Convert quiesce_depth to atomic_t and use it directly for quiesce
state checking, eliminating QUEUE_FLAG_QUIESCED entirely. This
removes the need for any locking in the hot path.

The atomic counter serves as both the depth tracker and the quiesce
indicator (depth > 0 means quiesced). This eliminates the race
window that existed between updating the depth and the flag.

Memory ordering is ensured by:
- smp_mb__after_atomic() after modifying quiesce_depth
- smp_rmb() before re-checking quiesce state in
  blk_mq_run_hw_queue()

Performance impact:
- RT kernel: eliminates lock contention, restores full throughput
- Non-RT kernel: atomic ops are similar cost to the previous
  spinlock acquire/release, no regression expected

Test results on RT kernel:
Hardware: Broadcom/LSI MegaRAID 12GSAS/PCIe Secure SAS39xx
  (megaraid_sas driver, 128 MSI-X vectors, 120 hw queues)
- Before: 153 MB/s, IRQ threads in D-state
- After:  640 MB/s, no IRQ threads blocked

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: 679b1874eba7 ("block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 45 ++++++++++++++++--------------------------
 include/linux/blkdev.h |  9 ++++++---
 4 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8387fe50ea15..4eea19426cc6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -434,6 +434,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	mutex_init(&q->limits_lock);
 	mutex_init(&q->rq_qos_mutex);
 	spin_lock_init(&q->queue_lock);
+	atomic_set(&q->quiesce_depth, 0);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
 	mutex_init(&q->mq_freeze_lock);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4896525b1c05..c63fe8864248 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -89,7 +89,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(INIT_DONE),
 	QUEUE_FLAG_NAME(STATS),
 	QUEUE_FLAG_NAME(REGISTERED),
-	QUEUE_FLAG_NAME(QUIESCED),
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(SQ_SCHED),
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 968699277c3d..1e0f5a311bef 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -260,12 +260,12 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_non_owner);
  */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&q->queue_lock, flags);
-	if (!q->quiesce_depth++)
-		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	atomic_inc(&q->quiesce_depth);
+	/*
+	 * Ensure the store to quiesce_depth is visible before any
+	 * subsequent loads in blk_mq_run_hw_queue().
+	 */
+	smp_mb__after_atomic();
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
@@ -314,21 +314,18 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	unsigned long flags;
-	bool run_queue = false;
+	int depth;
 
-	spin_lock_irqsave(&q->queue_lock, flags);
-	if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
-		;
-	} else if (!--q->quiesce_depth) {
-		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
-		run_queue = true;
-	}
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	depth = atomic_dec_if_positive(&q->quiesce_depth);
+	if (WARN_ON_ONCE(depth < 0))
+		return;
 
-	/* dispatch requests which are inserted during quiescing */
-	if (run_queue)
+	if (depth == 0) {
+		/* Ensure the decrement is visible before running queues */
+		smp_mb__after_atomic();
+		/* dispatch requests which are inserted during quiescing */
 		blk_mq_run_hw_queues(q, true);
+	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
@@ -2352,17 +2349,9 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 
 	need_run = blk_mq_hw_queue_need_run(hctx);
 	if (!need_run) {
-		unsigned long flags;
-
-		/*
-		 * Synchronize with blk_mq_unquiesce_queue(), because we check
-		 * if hw queue is quiesced locklessly above, we need the use
-		 * ->queue_lock to make sure we see the up-to-date status to
-		 * not miss rerunning the hw queue.
-		 */
-		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		/* Pairs with smp_mb__after_atomic() in blk_mq_unquiesce_queue() */
+		smp_rmb();
 		need_run = blk_mq_hw_queue_need_run(hctx);
-		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
 
 		if (!need_run)
 			return;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 72e34acd439c..9ad725af81f6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -516,7 +516,8 @@ struct request_queue {
 
 	spinlock_t		queue_lock;
 
-	int			quiesce_depth;
+	/* Atomic quiesce depth - also serves as quiesced indicator (depth > 0) */
+	atomic_t		quiesce_depth;
 
 	struct gendisk		*disk;
 
@@ -660,7 +661,6 @@ enum {
 	QUEUE_FLAG_INIT_DONE,		/* queue is initialized */
 	QUEUE_FLAG_STATS,		/* track IO start and completion times */
 	QUEUE_FLAG_REGISTERED,		/* queue has been registered to a disk */
-	QUEUE_FLAG_QUIESCED,		/* queue has been quiesced */
 	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
@@ -697,7 +697,10 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
-#define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
+static inline bool blk_queue_quiesced(struct request_queue *q)
+{
+	return atomic_read(&q->quiesce_depth) > 0;
+}
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
-- 
2.53.0

