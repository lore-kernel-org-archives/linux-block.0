Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57114D98F7;
	Wed, 13 May 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690358; cv=fail; b=lr7L7lr0G044TvSJKjaXi1Ft3MnePz98Q6rnJfJ60ixNkKLfK5LYN7C5H9LA4QzLrK4hCTOb23hjCrjANNsF72vsAyOi6vKFaIGTWAxNcCYnFFsPzC/qgJDNBIncbHUJhK6VZcF4wcf48eD//zuCIz1jgS2m2SFUjVKacg5JLpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690358; c=relaxed/simple;
	bh=Y3IrGijx7WCuEh1BPcDVZaqm5RLdHUOzny+vIAQ/v8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qhgsSQzuIse+uvb2Nu5T6zxtkeGGyDv6cgXL+wWhcjPlg7bSXUoJor28lB8XKBbVFirE9jwNvRa3JeXBHhaJYgKC4HFhuIakUjsr531Zfs+OIu+revqoch8f3DOtKlNrkvjXwNTDn1i2mgnrfjkbKnUCJjOcz44UDk+oLYdWlSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=eYD4dL3Z; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="eYD4dL3Z"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DENAtA1352300;
	Wed, 13 May 2026 16:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=b7Dxy3kAPLTVlTCSpAlpVb6l4s6+IlDzXuK35IBsx4c=; b=
	eYD4dL3Z9M1OdLMrTRMxgm8mQdVW/5f8iT8vJpsImSlu974gNQaRP8Y+baoFFw87
	2+X1YVKGFrZVOHwAd3b89tXgx6byVG99hbZN7Igjh1M8CIwUPws7jIgRbHNX82Ye
	M0zIbebgErGSBk5dKbzfH8PYmX2gscaBBWnX8PVKR/40IkAx4cfy3EkZry6LoEm5
	o2h5iC2TZNjZ+1FAdXrju5YAo1hQLP3AXqjB1Dueh3au41Z1jfNAtj4ryMdCDtti
	ZIKImOZRb70iYNcK1USbok9gDPjJJMIJN+rg9x22fQ2d9xQw/CE5G7dHbDAkLqpu
	z5/D+pHV64BFKG0S3Yf+Dw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ft7919m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 16:39:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIgWsgDD8qyzuEznChbrDkEPB9fSoihQDPnDLw9BBpsbWiVRUX7IKOz5JaWlbvryqlN/Z6ebrz43zyRO8jVjR3enQTEpK0KQnalIF4hRz1QjXQ1JzbEY2FJfE7UUd04bGqVUFa3F/c2NSgVkdj2tqCCQeLb5vrUpShAGWzRytRqcgsr6O4anoL5fmj6OXni4vEKuc3QaiYBqsN4ityJ1nq+lzaIeeeU5uL8EzvZyieONWO9arAEEHDxkxx0Dzi7DORBUi9oPTej4SZ6ajURIodkvpiT2pdSqxro0cas9yrxH2MGU5+wlAZxfbuHRXBLyiREElXGQtqHvmJ5xvipoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7Dxy3kAPLTVlTCSpAlpVb6l4s6+IlDzXuK35IBsx4c=;
 b=OvsNlGIovSM5ULyDGiWmeXJNEz/yFmNWn9oAhY0MxRUXHNNH17jqyhRCTrEGmKscTmICPx0RRmPX13mGHNTCM11UpORsJqqrhLCdmntamKUtAcrAuWXUZsBgfLyyyhlgXrm29G/BuXXUlWKERZEbrXYyPg2ddLTGuXkzaQ5Eakc9eLhp3jXZrvjdr09Dzs4f5jT61J13H89qv+FgLf22H+uYaVMOcLVsnE6uykaoL/XuSe8fbovxP9Ib+6OT7xEQpPprVBvMmK+G0/xox6cPJH2WYzCf4oIsyA9Ve40ttDY7YB6qlmnmKNmXYGbGtGffj6v6WxXar6o5bxHY0cVHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 16:39:12 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 16:39:12 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Christoph Boehmwalder <christoph.boehmwalder@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Chris Friesen <chris.friesen@windriver.com>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH] drbd: fix false positive resync throttling in drbd_rs_c_min_rate_throttle
Date: Wed, 13 May 2026 19:39:05 +0300
Message-ID: <20260513163905.562722-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513163905.562722-1-ionut.nechita@windriver.com>
References: <20260513163905.562722-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0021.eurprd08.prod.outlook.com
 (2603:10a6:803:104::34) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SA2PR11MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 023ea512-d7e2-4465-c803-08deb10e296e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+pCsccJgivVba3xZ/dUVU9apvSxX8WQV7DC5NNp5/2kYgT/1vgiB5C/F+kRasdqamKqPHdTj0FlRWe6xsIury/lZlHFDs/GszWrIrq93FCS2Br0zuJQTaGYENfVE6XNesby3cmk86ak5l5Qu9vv1Jftz0nsusqoTmxwnFj4QH1NRZjc4ZdC4kW1qvodFORyWM/07etE2TnKea1WPqfIjBb3hKguRChUFnXZ4KGxxWZ5jfAvflRT5YQEg2SRECzbL7d1hAuvneI7EfZI+we2n760HIjwn16Rnty1Xw6T1Hx0wyqd79XIskG4EqbzVMEC62qGOb+4oBpkDahJbmDCO1YVe43FqRvI78wK9AEpaK9KPPvrmoqvFo7OYjazELJMTpR5/cvzJ73Js7BCrdCONhbnCG680cILlsHJ6UIabHFD15Xp7OjAy+c7z9g4QV5U+k6lPZTJOrXDbY+7FV4Rreg3csGQSX3KNYkkvBcha93N9JbQEj5q/ABz4usmXRdo59GwVUOjWXYdcbcvjwAIRivmMi4KPvGMGyezLhSWjQCooSN0CFYNAG+arrMoaD3a7/Xwh53D6+XmdFjWi8I5Q7u58yQ/QxMJ8cnbdw0hrGPOaMMGfefmEFDH5epyOw+OmE3tEP3qAlkTI2sGDPNlJTti5rxIa90knpO6AGr84Mjnc7IT9AA/IgJoGhZllx2TK6fIfBiRubtbdyNO/jnaCyAVGYsgTkHWYJZJMXl06Y5pXlzmhOPtZxvTX2/V+cgIq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OUDqdsr6sNnrt2qPvlNsrtF16AKMv/b3MQwd4BJpb2Lk9Ajn4NMHyU6bt6Zb?=
 =?us-ascii?Q?lAURPF3Wif1aTYeQTG5EozF5GXboudXQQesq3tsGqPMRCUiJbCBDpwETwixL?=
 =?us-ascii?Q?KDfAphvYJT3koZXWkDJ7/OIXIjXZD2vm+7vt6wSI6K492MFzOvptZNleEWpG?=
 =?us-ascii?Q?nu9AvJRvpWpgj2HJUk5AKlzl0dHrZxTp2GKfghEJW7ytiveIWF5hmTW4dz8z?=
 =?us-ascii?Q?w65Z7oo3ROq7tamKTh9AFrNXJtGSKltZ9KeNOlWjiJE3f5goM5ipPVlIVoPE?=
 =?us-ascii?Q?qpdmlOY3U38Ml+Z98tCVHKmdUIfPe05a7pHNL9WVcBp3g0xx3AozubWFJdCw?=
 =?us-ascii?Q?vl5tWOl7JmpPkQHcoFTzjG08vDQEglC9ASkOxNRuq3eKz5KixX5cUchI4myC?=
 =?us-ascii?Q?jlSp4BEztZxmClIen18RC8AZo8T1hMnB5uf5aTMPN+ac8BQv+/yPl7LdboJx?=
 =?us-ascii?Q?juDtWixUqnKuH2I69McaqFXXZGdqvCMxemZQyfc6KxUAOI6RlBqJ5Qt6JMSI?=
 =?us-ascii?Q?fvJlS+M2W4lV6UxqQGIa7hH+l2ITo4szJN30jbUMhLec2yGzzzcZcH3t0Jzi?=
 =?us-ascii?Q?msp5GGll/aBysfioc+1zHTMrkP1+IhaNsxa/05C0e98aLMNjXfIZz/DGA3g5?=
 =?us-ascii?Q?btQH6YiW2WP5cvixqa3uJTJxWsumwU/gTPm+ztur+v/NavjVZL32n9xNCPTx?=
 =?us-ascii?Q?PbLuovsobi3pjezp8/ATkVcNQz0hRD7Ml9xx42GJ7LQK+VzCCU6buPhTGnp6?=
 =?us-ascii?Q?GVK+QZwO30xX/5TAXUcEdgxtGT1hcgrqK9i7gDBooTTxbl9bYneDTeCEByLi?=
 =?us-ascii?Q?gWnBuCOVjJd5l1DA+eoxIY7JC5hMgGukAzq94XdCvQkfbAVHVvkqJQMS7OPB?=
 =?us-ascii?Q?/+fD8z3M79K5muNy91NVDdmfO7jjDmPTU9lquIjgIDQ+9vrxFOhxq+M6Jkxr?=
 =?us-ascii?Q?ll+SE1QzkFlo0V3zMXCXgoJakmTARrgpLKx/xl049cV6HpMhqnokaDEwgmMI?=
 =?us-ascii?Q?Hg8IQT+qeYdqqj1mw9/mHJHSu7xVzrqcsSX5Im5VsYQE4moFK2IQPGIPDZNs?=
 =?us-ascii?Q?UBzXdIdPgkRiieokUmI1JPJXoIoQ610l/+hKC/K3UU5wSaRvQYF6ZFlRGXNU?=
 =?us-ascii?Q?63jVkpCMLau3OUBn39LYqx+I5pyy3XrfuboMo0xOiLk/jbRFOhsmDvyQlR43?=
 =?us-ascii?Q?4HXFHf4JL+TtkScSqphF3yiKlKg0DGL0eP3fJHtjrh+ITBXGRxmCWttOeZfJ?=
 =?us-ascii?Q?4FbWfz/+nq5Cbi8gXnSGmztPzj3cqCwSuhhhaLV4sBBWgeNJEahT2PhFMwI0?=
 =?us-ascii?Q?Qa+tXMhIgPu2XMw8JSPIIVt8ArbHhYlVVmfAEAp4euEiP6zI5M249lMeWqxP?=
 =?us-ascii?Q?X+cL8Qpa9Fpw2KUoTKkqQkUH6xe6l5AsSAQNuMSvEdAfooFs1zelNrylKGqd?=
 =?us-ascii?Q?HzUIeqBJf97L3plqxDDpEMqoF7Q56uK/2/BfIZw7ZPEVSjmPQxomS9VVxXma?=
 =?us-ascii?Q?0QoG37are4Z6MtpN/lwnSwMiZMb2C0AfKbYMtIOUSNWCCezEO9DYtZdmNkHS?=
 =?us-ascii?Q?fBlAVB4LkhdTcwKoIlC2gOFFHjW25gRX1RVUQjl2LzDywOsGWe3L6NkBt3dL?=
 =?us-ascii?Q?yBSKyS99jYD/R4wuBTbGsKZbDV/YtT8SBFokigBw/I4OmNH/weaSewvGn01K?=
 =?us-ascii?Q?hZxFVqI7gqfx1tkBmCBq4rb6VqZUjEmV/ZGXlky3d4YSuZ9hlbJ9LzX5g+89?=
 =?us-ascii?Q?0ptT/yvJ7IPRKyoAhynGB1Ry2wbnmWw=3D?=
X-Exchange-RoutingPolicyChecked:
	ATuWGXOygmRJlGA4llPowv6x9pOsEKbPnBEhBsc5M9MKBwuP/vjYr0L6DaVPZG7r85I90KHYHvSiCEPvhbBRWjwdUtaZ3wUQWJz52YglFN+tjGZn2CR87Q2WUokT1tS0HlzBmOvLI7riDHAfdRnUg5uaFLjzmun7tDVpsXXii1dfbU8FCrKXST8aQaWKTkXQovQu93A3Lny4bpPStS8SXTdATVYfg0UqsMOBMD1IRNSKsGNucFD1LORrD34N5ZeuHWoX4E9gYP4nczKH86L2D0qBQNZUNosVPo6Qkdu6usfhoZIfLCl4ptHQ4Gi1mPXnHwRtRvzxwFwH4lNcLQjnkQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023ea512-d7e2-4465-c803-08deb10e296e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 16:39:12.0267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9oh8JsvMXDceUKcWHyiLIznGulhhKTrblaoHNVSmEWYUQ9vuja0YkO4pa1KnUkFZ5KaOohiz0baTxsbWZKJCaaATtfCYgoMXr23c7icGf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-Proofpoint-ORIG-GUID: iVozSAUM8wyLTdcG6Z1o_BuujgfQCJp8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2OSBTYWx0ZWRfX9dlY4rxYP50n
 jjgdkLUlihyrNzLxFeYCf1mqSMf6zyHQEfW5mVmD4Pcpz4Q1bCgHx6m8ChPk/IQDb6bnnKnU5Jx
 ejxx3H94b4EPKztM5EMPI75Je0Yq32Sw9gzTpJ5Pxqt+AWcBJvfwPxBNcdkjvnakzruXgJgUuVr
 m3eBjRJnz3AQnnnVHo6E5KD8/AdyV9R2gqB+KCMZrvhAEkD+Kd1QzLiv+PWKQepDObkkQk2s5GM
 bwbUea4nStDoWNKLbZownfdMVJXMmTzcduncXuPr9Cq9Evd38qSH5lSOQP0EB61nFwpgoF0gKeN
 bXj4XnpfaCsC8Fhidc0JZQUQtSWg5xhZ8sP1v4gh22eKncajca6lWtBrCuOALnrSH3zqqjeeWip
 b5g3Jzl5rVSlED1FELnU2ZMjYdf7FF8X7JlABzFRIrxoOq4kW9mK8qcrC19KNfjvVHHgp1dxNQa
 36IbYUayGAIYKeuxq1A==
X-Proofpoint-GUID: iVozSAUM8wyLTdcG6Z1o_BuujgfQCJp8
X-Authority-Analysis: v=2.4 cv=G6As1dk5 c=1 sm=1 tr=0 ts=6a04a931 cx=c_pps
 a=k4cRz1n5LqTufC1gTxF42g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=MRXkqwc6AAAA:8 a=tG1RvngGnRzdYoEhFbwA:9 a=FdTzh2GWekK77mhwV6Dw:22
 a=tmQuKXRa9JHWtioalwAU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130169

From: Ionut Nechita <ionut.nechita@windriver.com>

drbd_rs_c_min_rate_throttle() is intended to slow down resync when
genuine application I/O is competing for the backing device.  It used
to detect "application I/O" by comparing the total sector count from
the backing device (part_stat_read_accum) against the resync sector
counter (rs_sect_ev), and throttling when the resync speed exceeds
c-min-rate.

That curr_events heuristic produces false positives:

1) On the receiver path, rs_sect_ev is incremented *after* the throttle
   check.  The current resync I/O is already reflected in part_stat
   counters but not yet in rs_sect_ev, creating a persistent positive
   delta that looks like application I/O.

2) The per-cpu part_stat counters and the atomic rs_sect_ev are not
   read under any common lock, so transient skew between them can
   push the delta above 64 sectors even when no application I/O is
   present.

When the false positive fires, the function compares the resync speed
against c-min-rate (default 35840 KB/s ~ 35 MB/s).  On modern
hardware capable of 300+ MB/s resync the condition is almost always
true, so the caller sleeps 100 ms (HZ/10) per resync request or stops
issuing new requests, capping throughput at roughly c-min-rate.

This was observed in production on a Distributed Cloud controller
where drbd-dc-vault (100 GB) resynced at ~30 MB/s instead of the
expected ~360 MB/s.  Setting c-min-rate above the actual resync speed
(e.g. 350 MB/s) or disabling the feature (c-min-rate 0) restored full
throughput, confirming false-positive throttling as root cause.

Switch the gate to ap_bio_cnt.  inc_ap_bio() is called for every
application bio at the top of drbd_make_request(), before any
activity-log handling, and dec_ap_bio() runs on completion.  That
makes ap_bio_cnt the authoritative "application I/O in flight"
signal, independent of part_stat update timing, per-cpu skew, and
activity-log fastpath outcomes.

Backport of the drbd 9.x fix to the in-tree drbd 8.4 driver.

Suggested-by: Ionut Nechita <ionut.nechita@windriver.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
[inechita: backport to drbd 8.4 - ap_bio_cnt is scalar, not array]
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/block/drbd/drbd_int.h      |  2 -
 drivers/block/drbd/drbd_main.c     |  1 -
 drivers/block/drbd/drbd_receiver.c | 62 ++++++++++++++++--------------
 drivers/block/drbd/drbd_worker.c   |  3 --
 4 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index e21492981f7dd..9ed613775e9e2 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -883,8 +883,6 @@ struct drbd_device {
 	atomic_t rs_sect_in; /* for incoming resync data rate, SyncTarget */
 	atomic_t rs_sect_ev; /* for submitted resync data rate, both */
 	int rs_last_sect_ev; /* counter to compare with */
-	int rs_last_events;  /* counter of read or write "events" (unit sectors)
-			      * on the lower level device when we last looked. */
 	int c_sync_rate; /* current resync rate after syncer throttle magic */
 	struct fifo_buffer *rs_plan_s; /* correction values of resync planer (RCU, connection->conn_update) */
 	int rs_in_flight; /* resync sectors in flight (to proxy, in proxy and from proxy) */
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 8c5a7bcfa82b2..0371fec05befa 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2019,7 +2019,6 @@ void drbd_device_cleanup(struct drbd_device *device)
 	device->rs_start     =
 	device->rs_total     =
 	device->rs_failed    = 0;
-	device->rs_last_events = 0;
 	device->rs_last_sect_ev = 0;
 	for (i = 0; i < DRBD_SYNC_MARKS; i++) {
 		device->rs_mark_left[i] = 0;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index ac18d36b0ea84..da59e919e20e6 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2757,50 +2757,56 @@ bool drbd_rs_should_slow_down(struct drbd_peer_device *peer_device, sector_t sec
 	return throttle;
 }
 
+/*
+ * Throttle resync when application I/O is in flight on the backing
+ * device and the resync is running faster than c-min-rate.
+ *
+ * The previous heuristic compared the backing device's part_stat
+ * sectors counter against our own rs_sect_ev counter (similar to
+ * MD RAID is_mddev_idle()) and fired on a delta > 64 sectors.  That
+ * comparison is racy: rs_sect_ev is bumped at submission while
+ * part_stat is updated on bio completion (and is per-cpu), and the
+ * receiver path bumps rs_sect_ev *after* the throttle check.  On
+ * fast hardware the transient skew routinely exceeds 64 sectors
+ * even with no application I/O, capping resync throughput at
+ * c-min-rate.
+ *
+ * ap_bio_cnt is incremented unconditionally for every application
+ * request in drbd_make_request(), so it is the authoritative
+ * "is application I/O in flight" signal.
+ */
 bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 {
-	struct gendisk *disk = device->ldev->backing_bdev->bd_disk;
 	unsigned long db, dt, dbdt;
 	unsigned int c_min_rate;
-	int curr_events;
+	unsigned long rs_left;
+	int i;
 
 	rcu_read_lock();
 	c_min_rate = rcu_dereference(device->ldev->disk_conf)->c_min_rate;
 	rcu_read_unlock();
 
-	/* feature disabled? */
 	if (c_min_rate == 0)
 		return false;
 
-	curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
-			atomic_read(&device->rs_sect_ev);
-
-	if (atomic_read(&device->ap_actlog_cnt)
-	    || curr_events - device->rs_last_events > 64) {
-		unsigned long rs_left;
-		int i;
-
-		device->rs_last_events = curr_events;
+	if (!atomic_read(&device->ap_bio_cnt))
+		return false;
 
-		/* sync speed average over the last 2*DRBD_SYNC_MARK_STEP,
-		 * approx. */
-		i = (device->rs_last_mark + DRBD_SYNC_MARKS-1) % DRBD_SYNC_MARKS;
+	/* sync speed average over the last 2*DRBD_SYNC_MARK_STEP, approx. */
+	i = (device->rs_last_mark + DRBD_SYNC_MARKS - 1) % DRBD_SYNC_MARKS;
 
-		if (device->state.conn == C_VERIFY_S || device->state.conn == C_VERIFY_T)
-			rs_left = device->ov_left;
-		else
-			rs_left = drbd_bm_total_weight(device) - device->rs_failed;
+	if (device->state.conn == C_VERIFY_S || device->state.conn == C_VERIFY_T)
+		rs_left = device->ov_left;
+	else
+		rs_left = drbd_bm_total_weight(device) - device->rs_failed;
 
-		dt = ((long)jiffies - (long)device->rs_mark_time[i]) / HZ;
-		if (!dt)
-			dt++;
-		db = device->rs_mark_left[i] - rs_left;
-		dbdt = Bit2KB(db/dt);
+	dt = ((long)jiffies - (long)device->rs_mark_time[i]) / HZ;
+	if (!dt)
+		dt++;
+	db = device->rs_mark_left[i] - rs_left;
+	dbdt = Bit2KB(db / dt);
 
-		if (dbdt > c_min_rate)
-			return true;
-	}
-	return false;
+	return dbdt > c_min_rate;
 }
 
 static int receive_DataRequest(struct drbd_connection *connection, struct packet_info *pi)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 4352a50fbb3f8..632281afffad4 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1676,14 +1676,11 @@ void drbd_resync_after_changed(struct drbd_device *device)
 void drbd_rs_controller_reset(struct drbd_peer_device *peer_device)
 {
 	struct drbd_device *device = peer_device->device;
-	struct gendisk *disk = device->ldev->backing_bdev->bd_disk;
 	struct fifo_buffer *plan;
 
 	atomic_set(&device->rs_sect_in, 0);
 	atomic_set(&device->rs_sect_ev, 0);
 	device->rs_in_flight = 0;
-	device->rs_last_events =
-		(int)part_stat_read_accum(disk->part0, sectors);
 
 	/* Updating the RCU protected object in place is necessary since
 	   this function gets called from atomic context.
-- 
2.43.0
