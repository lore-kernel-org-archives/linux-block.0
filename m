Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB03369204;
	Wed,  6 May 2026 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050675; cv=fail; b=i39XG+PiCuM91hJlrh7/jTeIoU9w/y2IXUkWFEnlDQ2QFPxUORVh/9LDoSMukuYoliPa+2fmqeMiVigZ0xxrhFWov/aR5kRakGfos6SYrlebDq+erp0YBnqiIuHcypt93S6myV7dT8x+2OEuka1SyNb2Gv0gmIJsf6BgKhZc9ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050675; c=relaxed/simple;
	bh=WTi0+TK+RqPEazXkwM2eUaRN6H+dzNzAQKn2EWZ1VL0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CLeVO15GGs6XBfua8S/5uY1ajp+PX3a1g+49vo4H386bC/kH3uSd1iGd4AB3aKjnvdVdACcxQQZN1vjkznr6ZODwUGOCx/nvcKvmRbZKin4M9msA/ATT2j6WlWpBMOEAIjpfMQJhKjgoR3Rhutwd4f98D4RuXWtB5FCiUtmIG74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=sxSM1pND; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="sxSM1pND"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6465aZ4C531879;
	Wed, 6 May 2026 06:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=jl7WYapeG
	T4ALvFGwddL9jhuNAJWNWNTug/i88h20PA=; b=sxSM1pNDUrcpGCuqjQzlVK9js
	doPttaJhSqFrwk13Xk4Lx4UvODXtXDTZUmjl6/0HvRo/eZ82UdTcDHdqCsM/EeSP
	MFYsStCuGyBiVwiDTnGQTCwp6S/66ttCoPe+yAwdaP/ED6s5GuOoh1LjczGj8ic+
	K6k9MK5JofNxB2Dr4vwbWy2vmAZq+h/epQXWd81A0asKY5b0oeQU4tmQNF1r5hjm
	HXwsY5QI3B3XthxJNF1j2BB7c6AE7rAx/bHqlikPpWyqnvR0kl4vm5gG0ad16Y6I
	xnRtwLFB059Z/LobasCmtVOmnxNZWQZs79asezZVr7Zy8aUwoLtUSds4yDU+Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dw8pu4knw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 06:56:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVdn2eP3c6F70vVYR0LIlKAbApKjpTjCnMfEWB47Y771Aa91o0W7WTfamTNT2YSp09uxJ9BAudMnGJ/t5mpSf1Hvw6Ge4wZaZyOGW6ILFZ85TIk46MYdwrdSvElWqg/cR4aMVaPN/FClePRouyqfj8Kyc5FsnUH++/2durLsR/LueycUqM1O4dWD/l1gt5KETtG1COBS1+MdvBHiNz/oAeCeSHESatTbp4l/TtOF/7t/CkoChU/jt1PeuLnckIkZGIwKEKCPPBriGHQQrTonTW83aSIBRMb3w8gx3dsiZ8bLG+t0wujm7gY8ii6iet2X6uMQnofXamBBP3/vzE1QQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jl7WYapeGT4ALvFGwddL9jhuNAJWNWNTug/i88h20PA=;
 b=PwAN8OCNP2LAVZ8gS1VWkFW/w4HGFUayg2Rx3BuluOYiIg2zoyuxcMRaxG6LGz6jSOxECcSoZp8l1MtupQ1tcCUik/t/iYlTLIeBadGjAghpjHHItY9HlT+Di5qUxIMgEaIeiKRrunhGzFBnGnE1mZe+0ij2HcGZ4oeDcdh+B4tu+CWTbMV8y44V4KbWLKZJLQmabTOmo0F/uVTxCVjEgAVYeGRhc25T90AGu/xfUKI28txskh+Pt2Xb/SkK3R8weg+9953fXt5dYHaHamk/ei6Vw5Ncl3BPYlfbHFHr1t25wovqwt+sBX1hyj7xL7gaUQW1QXH2QSiN1/CRmOZafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 06:56:33 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 06:56:32 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: bigeasy@linutronix.de, bvanassche@acm.org, clrkwllms@kernel.org,
        rostedt@goodmis.org, ming.lei@redhat.com, muchun.song@linux.dev,
        mkhalfella@purestorage.com, chris.friesen@windriver.com,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: [PATCH v6 0/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Wed,  6 May 2026 09:56:11 +0300
Message-ID: <cover.1778048987.git.ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:802:16::24) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 870c802a-9fd9-49b8-6bfb-08deab3c9b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|52116014|376014|7416014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2EzqIq0Elun+ZzekphFAbcCHxQWdigGZBlOE85+2gEc7DdJVSU5d81hBNMymsFES2Mg4LUQzGYpNzcttCjCBDbTLvAcb6l2r9LahJhK2KjzAtGsn6BFfp1JqfBTuUO9e1voQ1AV8LR8gLcJJ4cuq8Cgu6UMKhOStymWikdERHIpU6IhzOU2mbROigqakhssXgCoThJOFyN4S6IKzuJqxF75yvPPtRPlkPnfhY3zD01IRbD/qjv5peG9kH9DfDGLNwg01ThZT+lYHwTZ0ci04m0tDNwisVjEroDuHlRXA5Wn74nlT41eYAU4lIe5lARD4LCaEu+KYCFgDMIMaP78us3DXR/DuJL9DKft/T01edkqkpro3j3UUX7TOW83CmxAkpjG5Z6ZA8hJTCzP9tVxyH7qKqf7wHAR62Agohwc4yK/+y1ORVlRgbL55fcyz0tB4szHza5IFgCw9sSsolA+dxllUPqSDFwxmx7KpVsuAC1TYWRJejpUUgTCxbgEOjWfIjsqdDwhX9qKrAJauknqWaxUj1TNl9Dm0iyXc/3siW7HJYyLoNfF+bARGa6E7GwpsN0rkvPkVKcsXUucmXvyrZa7fkLCeXoM3WEfCAmtNpqrqVMS55KK/dBDpJDJ5E1Ml66PoDOKJ9pofTyQs0wdK7Spe5M4ZUnA/Lm6u/9Ty5D2rk2s/SMS1PDw/KS6M8Qetlafcx/BiGP32bULZ0XZf5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(52116014)(376014)(7416014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DVGKZDefp9q1nz45nKPVv/Vmk5ueH/T+6yX0/FJtiViztQW1FgrcbzLnSyRs?=
 =?us-ascii?Q?KYdOEn9WwF2H/dp3KGR4VcoV/73HpZG2qeV3nOkmI1NRYGhyEITU9qYCcf81?=
 =?us-ascii?Q?xcFgQWtW7AQPzzS8lNNFvd7nvxqdV45u0p9flFTAeBe/kFnVLxqrc1xDUa2h?=
 =?us-ascii?Q?c8JSBQ+7DR53cQTd5KaC9Xv7iFVlKr9BexwEOMUL9cIceIzB+sQK9rKBWguQ?=
 =?us-ascii?Q?zI6DZavciHw9eN42vkCP/6etkURi+AWdUAGlKiV/+X9/virImiFJpx0ZbrWr?=
 =?us-ascii?Q?IYeHZEhu2hBvxSKvIe1aUNtOm/C7vd4RK4hx8cFRtQU5qql9x+RT7dcYfX3T?=
 =?us-ascii?Q?MtqtPWHKh9JIUR+uObxNY/9AI+cC2LPEfAlBLwaFbIPweLWq1hfQ4nadrAIM?=
 =?us-ascii?Q?s5hnKeJYzNV9U7OxPXgObkfdZ6cvV54w2506N19QzE4V12wQoCgfLmnjupnH?=
 =?us-ascii?Q?D0kMTRJPTH1E9+KzWwLlSrr15KGfKlfCXinFkrqsL7SHgqv8zqEq5CNPez0Z?=
 =?us-ascii?Q?ywDw1SRmz8kjTWwkEpJWbmfJKj/1yj/5MlsTvxLp6jjCe7sG/qU255Ll+2bJ?=
 =?us-ascii?Q?3JEHPfM8w0Zd1Q/i3wztbilvwMU8wIU35sziRPGLTZQ1E13BaHV6acjZH9rj?=
 =?us-ascii?Q?TLNTfSTAOWIRej9e9TKlLpmirqfUp6YSDoMnRfF+iUqUha0gjInekGemrOQ0?=
 =?us-ascii?Q?c2ejLdD5D/r39W+G5bOakFctA6p1K9czO+xc6zCOKxjacBOWWeScU80yMjZU?=
 =?us-ascii?Q?4JqKpS+rshChRCD/TkeQCYCaqrw2fwa46MkW39MOQqB48T+D3RHUshVkrNTB?=
 =?us-ascii?Q?xeD0dpbQXUoxKd6to9rBGkwWdyCLm6TtjCdp6rYv4kZ+joRTrYTTMl8e1VIg?=
 =?us-ascii?Q?Bo8udn6ilXzIbb1NEHNlC3DL4sb01a1HeGEiX30u1A04P7pTMUAOFUebaFAe?=
 =?us-ascii?Q?kfl0gp+YzHdo9+8mMbqUu9Gvg42TC/l8wsJU1kvdZtna5p08uo8+YYbax8hm?=
 =?us-ascii?Q?lBqFur2nBy5YmNwg/fC9Sj9OP3r26RU010YpKEIwagh0TDYpRH6boJSWZZQJ?=
 =?us-ascii?Q?AvMntMCLGg9TVfepO4jOE2I9xy5GwX2Jxc/QW5eYWgbOPZldVaXUKcSNy1ic?=
 =?us-ascii?Q?y+kC5duWnUi9y/cMIdi3/KTbAda6YJgYbWMfJt7+nxqlcvWGulsQLPXAnY7T?=
 =?us-ascii?Q?8811lUuOjW2wHPohVP8tGwV6hwXo45AYFy9CsnH6lQkbDO5pqKgICY2JMWdi?=
 =?us-ascii?Q?2UXTU7tOFK94ffeFOUTNTZDJl9P0peMXAAA4fI6wmf0c5bQeQpZvJWqgMoor?=
 =?us-ascii?Q?qSZOUNqPAJIWuq0KtMQQ65E6vSp7UhMIUcPmwcCFrmrg4nHhHB5hLfFLS7p6?=
 =?us-ascii?Q?AKM6JV7L727T/ENm5Het/M/PuwnyKyghj96FT1/E+OVyIDMbR0+EEKKJREu0?=
 =?us-ascii?Q?ie7FcnnzDRoCZN9ip6+RY3MiFdTZ/JnVYfUnD1RNXKJz+AYWz+uNYfkSOzUG?=
 =?us-ascii?Q?V1nTkR+J6QWzjhuVfwuvzc6Xs7xYUXpbMFy9nl19eGRCgoLjCQ4lRvVtZ43t?=
 =?us-ascii?Q?NVl0zaU3LJN4ndI6stCALinXITZCJG/AP7X0IHUE/U8ntdpYOoKAfPVpr135?=
 =?us-ascii?Q?IY7S6RcsQ7Yxz/5geffDWNS2/ap0c2iZSFKBpLn9/XJPtPmiuLT6HOpDMa5s?=
 =?us-ascii?Q?Bf6noKWP1I9PxZfbxqCONCAv4v8ludbQAHDJ4hPaQ9PFst+X7m2yvWweqkmL?=
 =?us-ascii?Q?ntcDLQXh0M8RqL78ZAaCpervK3g/1q+Pacv0776gU0P7bqftdtiwB9JdEYTz?=
X-MS-Exchange-AntiSpam-MessageData-1: nRfy6Hm6xvCm+bdLimsQ+LPr9hbgNP7uaIc=
X-Exchange-RoutingPolicyChecked:
	Xm5snv0Rd0bniQ64r9dEgu8rZcJqoEc3NDSr2bbUR615yu2KSEQrlT7uASOFtSTOxJg2ts+rQ+fydWgCrg7NTkZ8P1/YegfbCjEy4I3AgoxqfGDhhpayOJNQD7SG/CEDDCvAsoNIXXokn5D84aPCsIEJUmKt17Zylz23OklXgb2sP9wd9okuwZPYFQ247AziQ3DpKcCbVzYsoNzGJQagf4Clvv9k6OJd//4xrK52FD57/w7yT4zHdET7ODs+84WiYqWUmN54OW8bmlOiD+Rce5FLpGyIvmXfM8hqnZO1W6ZVCUSA3MbtugKXZnRgKqh3iJOBjgdUSKJr1Fb8Y9rXZg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870c802a-9fd9-49b8-6bfb-08deab3c9b3b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 06:56:32.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /S38fylRCIHNvi8bP2J7Kx0A9dqd5DqfkIibc4+Ydwo2QpRhCr2+lNLR/6s9JpgFIB3aIbNLsIioTzcWnSc/1+9h6lqMEJveQVKcqe3Bj6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
X-Authority-Analysis: v=2.4 cv=AdaB2XXG c=1 sm=1 tr=0 ts=69fae624 cx=c_pps
 a=aX6hwv3pUrsX0fnHaj1tZQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=9QH9bVwfWaJNf-r-aDcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA2NSBTYWx0ZWRfX9yQSTtZQE1A9
 AyUQT1oElFm07GKhb1/e57kvb64CGHprJJl3MUPGNzLgUbHtqDK4O3qIY1Z+WNhXUxwz4kfnxWw
 1m7/4oFrmcZWYVkLDbD0iXOuH7JMfgAmVemqfF4oaRxvZCzfnVbmtVJhcCJNCeZiCyrWUCmDZ75
 IU0Cgc6fys8/qTTaoyJOxX2fm2Zr4+wo+UEV0jzrD6GtUFhxSpVUoGTULAwU4I1aX+3T0e9oGK9
 6gBHXUkkpWUUY4qbYgE224KgNYTqAQtK9NJqjnnxxGcjYRgTxKcxC76ehwDCOEpACA/H4Egv2Uo
 wyn8pXqr4CZs+akCDTcPmRRj9ZSUERKdvZVZ4eLVKCIds8shE8mqXnqh4e9YiclP4VEf/UnrUqo
 9/YrIcstsf39mDoHWUCkzVEvpbwcCv4JBLssloZVuJeNAyw1GwAOyr5BXDZ3jY2JEf/PToJT1bR
 405GkbgqGfzqAqxHZpQ==
X-Proofpoint-ORIG-GUID: 9HYKGP3zjU4r0p9TbAkYUJznKqhg9620
X-Proofpoint-GUID: 9HYKGP3zjU4r0p9TbAkYUJznKqhg9620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060065

Hi Jens,

This is v6 of the fix for the RT kernel performance regression caused by
commit 6bda857bcbb86 ("block: fix ordering between checking
QUEUE_FLAG_QUIESCED request adding").

Changes since v5 (Mar 3):
- Rewrote the memory-ordering comments per Bart Van Assche's review.
  The previous wording incorrectly described smp_mb__after_atomic() as
  ordering against "subsequent loads in blk_mq_run_hw_queue()". The
  comments now describe the actual reader/writer pairing: writer-side
  smp_mb__after_atomic() in blk_mq_quiesce_queue_nowait() and
  blk_mq_unquiesce_queue() pairs with reader-side smp_rmb() in
  blk_mq_run_hw_queue() so the re-check observes the latest
  quiesce_depth value.
- Rebased on top of linux-next (next-20260505).
- No functional / code-generation changes.

Changes since v4 (Feb 13):
- Rebased on top of linux-next (20260302)
- No code changes

Changes since v3 (Feb 11):
- Rebased on top of axboe/for-7.0/block
- Fixed Fixes tag commit hash to match upstream (6bda857bcbb86)
- Added Reviewed-by from Sebastian Andrzej Siewior
- No code changes

Changes since v2 (Feb 10):
- Replaced raw_spinlock_t quiesce_sync_lock with atomic_t for
  quiesce_depth, as suggested by Sebastian Andrzej Siewior
- Eliminated QUEUE_FLAG_QUIESCED entirely; blk_queue_quiesced() now
  checks atomic_read(&q->quiesce_depth) > 0
- Use atomic_dec_if_positive() in blk_mq_unquiesce_queue() to avoid
  race between WARN check and decrement
- Removed the unrelated blk_mq_run_hw_queues() async=true change
- Removed blk-mq-debugfs.c QUIESCED flag entry
- Uses smp_mb__after_atomic() / smp_rmb() for memory ordering instead
  of any spinlock in the hot path

Changes since v1 (RESEND, Jan 9):
- Rebased on top of axboe/for-7.0/block
- No code changes

The problem: on PREEMPT_RT kernels, the spinlock_t queue_lock added in
blk_mq_run_hw_queue() converts to a sleeping rt_mutex, causing all IRQ
threads (one per MSI-X vector) to serialize. On megaraid_sas with 128
MSI-X vectors and 120 hw queues, throughput drops from 640 MB/s to
153 MB/s.

The fix converts quiesce_depth to atomic_t, which serves as both the
depth tracker and the quiesce indicator (depth > 0 means quiesced).
This eliminates QUEUE_FLAG_QUIESCED and removes the need for any lock
in the hot path. Memory ordering is ensured by smp_mb__after_atomic()
on the writer side (after modifying quiesce_depth) paired with
smp_rmb() on the reader side (before re-checking quiesce state in
blk_mq_run_hw_queue()).

Link: https://lore.kernel.org/linux-block/20260303073744.20585-1-ionut.nechita@windriver.com/

Ionut Nechita (1):
  block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention
    on RT

 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 53 +++++++++++++++++++++---------------------
 include/linux/blkdev.h |  9 ++++---
 4 files changed, 34 insertions(+), 30 deletions(-)

--
2.54.0

