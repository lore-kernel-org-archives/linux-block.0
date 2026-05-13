Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A44C0419;
	Wed, 13 May 2026 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690356; cv=fail; b=rzkL/m34VwPRdiUtfEWzqBGnudN1RQM+GFkeUMKsw6pzK5E7NKFhr3wiy7gEraXu8GlGj61KXPncKQlwW+Hebo6vkSArA6Qc5wXO6E8pEHVKpdAdTFVK/xwKLW8s0ZHZRvplrZkJeFpdr1TkfZS9nE6dSltCwMt/NGKyHy1H0ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690356; c=relaxed/simple;
	bh=l4r7C1RDH3RsxmzRUX8DVE+qBwddh2k732VhMO73FTI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ggUfB7F+VMQ2Jd7xpdsfU6MRapueABm94Ox5ZBwZFqd4sQ+zbE07ItWqodK4hY8Yd9UqtOsLtQttR5siG9WqBnk5bP3PjzKnozd8bXWVvCuWQ/LERGR7jSU0rF9dWBayWjgibXDPQomyQwt4Ejs5qawmIgj9XKb7JdQD1ao49Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=JJBtmVAt; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="JJBtmVAt"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DEMxBQ1350611;
	Wed, 13 May 2026 16:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=iSWG6r9VI
	Ycro7IcIhCMZzWhkBHkWpL3CbcIdNxqfk8=; b=JJBtmVAtCil/lJqve5p+GgS3I
	18EOiK7/N1GQ1ftfv4y4l00lY1xrJcWyeVIwL/BYENJ6F/q/KIcjvfebko0Eex9j
	ytBymT6hZ/PhcmAZi0YjlE7UxhWeIo3M5sUnsQTerYE9IyJKc3A6prVwYQxk9nXf
	EWM4gAAvVw/o1ujoLiPMc5hGzbBQYcLCnwX/M4aGQf+pNYidYEhXTmUtRBf+uXBM
	ADb4WRcxZxUNaKIyH+UOHnepj0M1Hzu3oMuVd/Z3ZdScnJlSjYsrnkiGTFUK0m5w
	e4vnMY+VDEmxLQIBirZJzP/ZOnUo2b0f5b7haejiCOI53kyNLCOSNvpBoQ0JA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ft7919g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 16:39:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQik3FQNP5tzSXLSGcZZH5J+EslnJYziwU0WqMUDV08YhR3AX0dMs02ka3/NnOMvizDDBKkfltcCpjpICfZp34a8pTZyF6ViMAeRpkFA+Sf8KnYD3KdYP772M+xDNav0e9Tb53DyNCzGqLopFqpGKzNsfGnj3MWR8+Yt4xPC/Lr1DN6L5hs06VRJnl5QHQ/oajqhRA5rM0Y1l7tbV7G9Q5wfdmkExav7r/XyCpQfzR8GQZZwr3DjsOYmw4kZj7Hv3e7ivTDunWHVPQc9uTxRtiwdt0+3UguPukY4q6XB6VKx/NRWVFT02Wm8LFODrVeZ9jDv67I0ps32lA0yjFPbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSWG6r9VIYcro7IcIhCMZzWhkBHkWpL3CbcIdNxqfk8=;
 b=G0KsoPtNm39i2rV0fP663k+T0kioZLh8lhftUgJ64uQ0+unLi68cLdioH1M1CWVXV9SEK38XrD2Lit+IcH+ciqnp5/RJvDIb2njDmCH+1rvWJ/E7UvSfdSYcJrjvmhXRmfGdzngOc+AfVxlmuNMJ0tS3awltr5bIE23qcfTugIyr1e3PSdepuf2NPnX+NVlW74gjwHjDeCHGu/uLN5mDOd5qumA7RrIhsSYr8okCoOm4/N9aHGQJtUjleTlUGWVUSsnkFaKUWQFQ0v1uj74LBELY6huWd1C3KXOVDyoxQWXCm5HY/6HUHb63615Vp2T7Jj96X47cigU9Tl5tHe2GCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 16:39:05 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 16:39:05 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Christoph Boehmwalder <christoph.boehmwalder@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Chris Friesen <chris.friesen@windriver.com>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 0/1] drbd: fix false positive resync throttling (in-tree 8.4)
Date: Wed, 13 May 2026 19:39:04 +0300
Message-ID: <20260513163905.562722-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: dd79cabc-213d-4b9b-47de-08deb10e2522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	gCCpJwnQMT2DuWElKOa9Ko4/AONdndwZiUX/NdAzNo1lROduBIYMihgpkSfnyYx66f2qg/rpJAfj5pOv1PNAOmxVkx+ZL5ZCHdbWnwkf8/nLUSrvoyzaOe3DUpUFa2VYHhH3elAFMijYK/J7OePmhtGkqZtVSMELDWy1+00GeDvN7W8bqa+4AoviPp6CELrxk023k3YaBn52bwGAJWYGPlY4H6748pShF3opSjPCO9of74jhIX7jjbCyLyzQzxF88igY06rJd2inKvi44p+AhVAd3Yb2/kJn3bBQqYo/hkkJVvR0qpe9PyOreFChXMhEn20/g3reUqzIx1L3t88TW37LbBggRGxAfTTwYePen5pc2O2miajS62Gs8bVO530UX6JK3PwwiTu0F8Am0L7oef2QV7DmYintxQMu7TXRu4ThBmWeZv3mz42qaVxv4x2PuRoCmAvkfCqjKMI/419dthfi+3mF1qGXtBZE92WuCZ1BfUdwea1NpY5swvg265lmq1XVjC5uF1dI0V+qoYhzEyv9o4w/S+v+qJIrWPcjRP6OLi86RN1RrCA52pw5QAdLdakGhGwfLtLHtdSLruHEcBZN8Tmd5ugHi3rbEwz9d4msSbeuEUG9iGJs6ejUeFj2r6sPwySNN4kXMM5Ex98iV7WBmBkR75XlpCrHZZQw7AW1vSGwB0dLmCoge1JhXMbUJymQE7H2gfxnHgGUEEdmhQWNy4k7vqAAz4DMXvd2IyPS7Ms/I0C3eT1yBZ/pS5D7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(11063799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/uWws0stwby1Xavav0sPtfvzSopPjlNlbbQm8VWa+kLWkRX6DARItvFyvVMt?=
 =?us-ascii?Q?qJVFiJ6ZeXsn2Op2V2CkKpMN5yuVGF99niYJVIw/9Wn6UqSY0c0bm1iOL6d3?=
 =?us-ascii?Q?faqh6/Io1YhmkDFN/GneWEwsGiNENlhP42GgvUBvjnnaR8Z/gKzJB5uUPD2J?=
 =?us-ascii?Q?nE+KWKwMNsBX7ecv3ua0ZgH1ceOvS189QiqAE8Ss7R+vHj3hqbDaWeR+ZiOh?=
 =?us-ascii?Q?/eADcFLpDmqiJRYm8rBAjZL0t/tHq0ng0YeXG48X/NZqQ5DsBHKGX1z1w3K/?=
 =?us-ascii?Q?uXemiWVFghwr4GU8lAe4JZVO4SBfQmI+AOo7gGuhY2LTSPSxZDK3V4oJcnq5?=
 =?us-ascii?Q?jpRbVeUpq/QZDJTpO13/3TKLTcA+VYnCXOJI+sKvyMCzf4E14eiBa3Q80hMr?=
 =?us-ascii?Q?w0yFYER8AucRDpUvx9wwx1LKB3ZCvTozQRfiMhUXRxgSXr3PePXjp4rPyPek?=
 =?us-ascii?Q?6zT996wdL5sdZch+lHp+o/dvcUmwCvUsX0dwWSp/0JfAaF0P0xxpeRrYF8Oj?=
 =?us-ascii?Q?EDD6fNac5seRj9AK7plSV2A9Gfxhhl09gOuYY7iq0fK/QarrFQCJpGlWMGe6?=
 =?us-ascii?Q?GWOHD7rYE9/jdhVp5chqbTPDm2TXHRNSNb+CqjEU+ftXKdL/R5bSNmNjgorW?=
 =?us-ascii?Q?5zSKAaIQo0JkxyzK/r7vs1WlJA+8RgDAcB+w1sfrij8//xiLCtQ0j2JXoauV?=
 =?us-ascii?Q?Bk85PNsm7L++uvM3/MO/+KaGtge7XIJp6xHS+bZPS/o3RRWlG2+Pf/w1QZ7+?=
 =?us-ascii?Q?BQ5zjuDO+2KyZwFeXSbBbGWMc+mXYmiEkmSRbRUrjCx4ZSdT/sveLWeAgozs?=
 =?us-ascii?Q?tJoRbL1zOVtPW8siAl/yzlAAhrbFM3hjkZHH8bZDSH1YdjeuJ7lgLY0gMl3O?=
 =?us-ascii?Q?otoe2cmBMpOuYsuRg5fqI6mCfBElMW0r5b+3dAvXmn2S+0KS8fLe/lB6WfUE?=
 =?us-ascii?Q?rCR3bBR7cwNeytO8Eu7CBRMS3uwPiTKKKhbMlVU5Jm/D4WsKWbvr2FORJCUz?=
 =?us-ascii?Q?5X6NouhDn+N7Q8UJooVgIZ1MNQYJyzv1lYtGMAzoa9cL74pAQGuDi1VhmKbv?=
 =?us-ascii?Q?sGINPou5f9DX1MYhzEa38e1g7j0l7xnI/rxxDFNbBh7DlaN7T9dDTuLhty+t?=
 =?us-ascii?Q?+o0Zo9Ysf23JSp1r2urYCO/D1WTRSiKNGJFwJNmGbzdIFFmx1jGjLKqgEixS?=
 =?us-ascii?Q?ZoHG9okWIfvZvNZ2ZgeHef/pbg/fGKgDuIyEhhjTiOVgU95j3LaezAAtdxV0?=
 =?us-ascii?Q?MP70BWcIbn96LuM+jbsxU377qntpZEhZM4jiDzd2sLSLDqoxH4M3fu7kD+GW?=
 =?us-ascii?Q?2vQUbUmsLlFyI/ib/lzOq1zY89A9x2Ff+bs50S6C2mWG/imb65DS2nfK94Jr?=
 =?us-ascii?Q?jpb/yiW3E/rhrZG8epO7L5eovEizSXYdjsfl5IX7xsNKmgiQ7SIqnxqsCBqn?=
 =?us-ascii?Q?nypTo/kmQe0KEkvhCDvTSGHt4nAfk4E5FPxpOijAUOYiyRypQ2C/Z42+ra6n?=
 =?us-ascii?Q?0i2Z2DiFWG6JYhu3syrEzOuLrZEEr4y6389Y4XM1LYgOp7tRbuid6EerMxFR?=
 =?us-ascii?Q?zcf3RZG/MDwCNnn4ySgzjkCQGnqMuGKDgEFFDzy/6TxozF7qvkMgUuMseqah?=
 =?us-ascii?Q?U09hVcF/2t1nkRVsJl2VV0bhE6RwvsTOaJPLoR0jbzQnfLx3P1++gOcna+Qa?=
 =?us-ascii?Q?PJ7ymmQzO/SVJpuRzqpvKpnW7NScMjrgQ0yzjUUyLCKjcxafSRZZJ+siGHWK?=
 =?us-ascii?Q?VZHbz9g9+pHH8FFd3xSF2/iD5k8RK8g=3D?=
X-Exchange-RoutingPolicyChecked:
	JfEkmMu7MS/Oa1KdoWpGaOmKgXix0gZPRqL2W9FEOM/srLls/WuvMPERs6ta7ZzGnmYwYUnq597XEoju/sCHrnSJiKVepQeTR1UvFWJ9ZZVkJieB5UmZ1x2HYHnKQcxLl5V33LdcB674m22Fzk7RAAx/CTMoT9KxWNa7dhhwhrjyxXbqRTJWgh18EGt8ZynH0n3T9//nnkXSLqEBLMg0DoSKO+VtUzLBOCzvM+sjgBxEn0Sa4+25muNQTxQg2Z5noKM+73yNP6vvCxw93cVrEABqAqw6CiIFhLdUgWj6sXcIFYaT1V17nkGcgjQNUnFtTRi5f+E3DJqguENzH2OwGg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd79cabc-213d-4b9b-47de-08deb10e2522
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 16:39:04.9831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HE6p1kc1A1LZkMBSpJtVwbUPVPacEDxUb7vGiD7Gsv2yAMzxpP4KZELeUdB3gGVQTm9LtSg7RNhKhVev72YaMEdk11q2L2CM9K8bze22jAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-Proofpoint-ORIG-GUID: yxTmu7dfOWHetKiZOBbFr-ksSdqAdfes
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2OSBTYWx0ZWRfX19XWYBF+5Chy
 kkN+sogBOjoxtJmBbPLmUroNvZxaQNHIVTWqirCbEKAndEVZdWhyzrJEA+o0DTTMrrLvQE9Qcex
 wkNBapLGwwDXgIouuF+kYBaoCfMy2WSsA31Gic49xegqNxmP7veqGnTO6svnA3zIn3zIA64k0Vs
 vV3BrHunUqaDOXNVgWe3q+4ieajcv1r7oNCZwi1Nb09f5dPYcWKVzBZpTy/ofyVHv/fQ/D11QDk
 3V2yyyINO/IoGdCKvnViTOAN8zmn85QzBvgYugYIaM15tgePDfI3nov51AsZFYEO5pMHpwOiFxb
 3LPFSUsPQoL3R7+1osEyYM+tmG2sHigOFr7EnFVZm5gvG22G9CjdCH3DLAiVy1gaF/4TjAtJiuD
 wXyjc70n9KBFjRtSx4A3BfA/zdAY5dIVrgUpwMUgyDzBXOz6qXjUCG9ui0UkbM2UKfTDZJaZjWk
 hkDvFTPXfsJYp7eeSng==
X-Proofpoint-GUID: yxTmu7dfOWHetKiZOBbFr-ksSdqAdfes
X-Authority-Analysis: v=2.4 cv=G6As1dk5 c=1 sm=1 tr=0 ts=6a04a92b cx=c_pps
 a=u5a0R1DJIqwdmu/eAz29vw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=jHVks5QT5gNeL2fn0xsA:9 a=FdTzh2GWekK77mhwV6Dw:22
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

Hi Philipp, Lars, Christoph,

This is the in-tree drbd 8.4 backport of the ap_bio_cnt throttle fix
that was previously sent against drbd 9.3.2.

The drbd 9.x version (using ap_bio_cnt[] array) was Suggested-by me
and Signed-off-by Philipp.  This patch adapts it to the in-tree 8.4
driver where ap_bio_cnt is a scalar atomic_t rather than a per-direction
array.

The fix replaces the racy part_stat/curr_events heuristic in
drbd_rs_c_min_rate_throttle() with a direct check of ap_bio_cnt,
eliminating false-positive throttling that caps resync at c-min-rate
(~35 MB/s) on high-speed links.

Tested on a Distributed Cloud controller (StarlingX, kernel 6.12-rt)
with 10G/100G Mellanox ConnectX-6:
- Before: drbd-dc-vault (100 GB) resync at ~30 MB/s
- After:  drbd-dc-vault resync at ~340-350 MB/s (full link speed)

Based on: linux-6.12.y (6.12.87)

Ionut Nechita (1):
  drbd: fix false positive resync throttling in
    drbd_rs_c_min_rate_throttle

 drivers/block/drbd/drbd_int.h      |  2 -
 drivers/block/drbd/drbd_main.c     |  1 -
 drivers/block/drbd/drbd_receiver.c | 62 ++++++++++++++++--------------
 drivers/block/drbd/drbd_worker.c   |  3 --
 4 files changed, 34 insertions(+), 34 deletions(-)

-- 
2.43.0

