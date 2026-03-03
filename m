Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DFA1946DA;
	Tue,  3 Mar 2026 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523533; cv=fail; b=TQHW7zspv+HAnQ4k05WsEBLpNHJJL5bAnQaX6wH0iHuni+A8bDPxyL2piZo2/t0HmWqlpDGk3sSuTj9OxJAEaGSqi/FFIZnU9ibHaXSMrs18rWzKhuaCY7KMyZjfWaMQRYcBgr6DW3PJ/f5Lm36q5WwM/36zn2GCTINYSevPy6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523533; c=relaxed/simple;
	bh=S1C/rSUNS0ICRpAjZSzEUnHDbn7FoQ5e89J8s+Kfdto=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H9sLhw+uIZSBLZufyc4x3imhP6+f81VziXFz6YBgO6QFOxveOTNlao/049+yDjWaFkHru8NaFMyPpZ4aytrNERfP9ZFzhGt1JxHApsizy3/o4Qwso9ImdyBO4FAHHSAf4eoVrPzaNmiDsl5QL4aijGBETOnk7aWwAA0VXnMZUBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=d9yg6WFh; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="d9yg6WFh"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6237QUcc3991212;
	Tue, 3 Mar 2026 07:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=sVdY+20ak
	bfdU+ohbuzutbed4ihsnee2pLRq9P8hK+Y=; b=d9yg6WFhJMEIekB45CRnRLGP1
	Vke4MFp13CYJbSgHZ+sjd2vgEHzg/HVJn2PwH71WVHK5SDehdEL4WT3ePNLM3o0K
	OSCB4aCXa1VXb5xGJg624N7I30Um0PWvqf0id1/XlT77/LlGA9kOcz39jb/lR9tt
	cIIOVsbWKvCQ9m1m1nY20vzB+g3O4gFq4K5dTsEKohi4hW91MSTA3na68vlHbaOX
	n04O1qRqpAyc9T00mFG4hLPxv5ltWTTMIpuLtAj3ADQlcR8BSkz+ILnirm5XbPUC
	3BV7dIyJcs83h+u9158tBh0BqP1rMWYo2n14CVOefOQgSZbylfGPHNNXbV9Vg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cknjvkf0k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 07:38:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0TO145VCN7QsEUADERGMzjMqFUEtKVlZXSrCMMgBRXSkXy1vbY/Va/piwkp2bAiMUVLYFsfMXwjX4V9FPBQKljaQE2sqMzK3lwb2liD8gg9SQt3Z1V4NcM95zXOsyjLV0cfCmysGVvC0FjKjwu5XYez+oh36KFPRPsP6t9dicRlZtmZE3TT69TQhzj66H7/hal700SFDRwzRY2veJaJplDdEnhb8vZuDuj6hdajXvSQnmJjOQPsjXD4VGACixF8JVhxcSvjlEa2X4tNeLBXMhrNFr0z2ex24X69ilTdlzRCal4FpwX/Tr7qt6V5Lx1KHTG8NUkHOF0KQGdrcWg0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVdY+20akbfdU+ohbuzutbed4ihsnee2pLRq9P8hK+Y=;
 b=qP9b/9W8VSI93VtUDLlwya7Tu+eKiPWoNepYTWBLVWIIGERk/7ZhbCsqC0INRLrv+sCXf+aS4dmCrboG1oPyzwwxcBjXZ7BjF+jFKDVHhDUXCX14AcoHi1AC3EzpUOAl1KFae3R/9bFOWPCBJndPJTWbInqYQBb4x/5TYrIbPt5MthQ+psFzBYR5+nSzmazkPrW2ZXGezkcSzlfw2C5Cc/XZC9kIorVs7vZaC8h9XIV43wPyNLWhGVKhdPvw1UK/cywPUncwyGFlm6P7VzfhInZItiacGAU0W0XvsCq1CpRhCsN1ONE8EvD3oLdjLglpbyhNgxCQTVc/7O+a/IfgKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by SJ5PPFF330187AB.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::860) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 07:37:59 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 07:37:58 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-block@vger.kernel.org, axboe@kernel.dk
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
        ming.lei@redhat.com, muchun.song@linux.dev, mkhalfella@purestorage.com,
        chris.friesen@windriver.com, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org,
        stable@vger.kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v5 0/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Tue,  3 Mar 2026 09:37:43 +0200
Message-ID: <20260303073744.20585-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::9) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|SJ5PPFF330187AB:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c40b259-9819-44a1-b1e1-08de78f7cab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|10070799003|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	oUJAzBkeyhykslA++dTJ587D3XdhoBN/ZGJYcWDwI2+bVfwFZA46VgTSbwqO7prAY2Z3nhtEMrqxisd9yMb7t6+U1MwdkSLhyzegSbB2UdPvTlHTYKC9qOp5LLdme4289RBbLnZfSEB9MemnorQeVMUljI2pjX+IGL8uVkHqtU7PIo9GI+2ZT17mmQ5V3VzvzgMRa66GTTFFZPZdeO+WmwBSqWOfCZsSCRhod+gQmfi3v4lZEod9ZC/xkBPhsxZ3X6r/48TfM/WSVt+GDYP/3Dmy+XHmLqhMYIsY5M1BuDFSJppXyxVrvlZOmhjgTLOW3r/GNmBy1OA/EQN6kXsRLW/xJmB43RpvVRqDyIY6cPRGcGGRN2v5xUtws/OkT/V3gCKBurEvBvNMPk6ylfO5TLjHGAvrZgSKVcXudte+X8iuVDlbf5V1y0/M1a8qayRqcFzAuIGa/lj2QHtYj2IAINjvG1mZo7NzR4jvBcyZQ3rjeB4i6OuIUAEIILJOlSkq2OIgA/aWOauKzlNZROi8LUJmCc879Sn0kcts+/j3i8S3PFNks4comj6P+nmRRuoP32MOw9xdnQtZn60HKgxWdKXLOlmysaK2HkNDWkOSJsP9v5LMu4+ehiduWekdhZ9MOAzfHEdP4f4JnPdiK5PGETerrZh5YK4gaS2PxVQDjew4hXprQjpTyzVSaxLrPtbveOnpkTkLQlKGiYetv942gNEUL1Gc+A5+2lEjCbdtTbg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(10070799003)(366016)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IzJwAVTvssVN1MF+9PgWS35EreOBwT+7Ok7gGGv2jKwXaZHDLr2QQ33Mvgeu?=
 =?us-ascii?Q?V9i8nWG5bqWxbMPEL964878ENm51JxffxoIQfQSF8ZHocAk+uJQbTxJeQ5iP?=
 =?us-ascii?Q?ulgA82HKC7f6A/k1PkGhFKqCFYzZYMutYfGF9dJ165Ppusaq8HUPlSk/NJaj?=
 =?us-ascii?Q?Kufubx0kTnKIEombKstTVnaEnioKPm+C2XDEc4Pt67CSi2FwqZ1BOAiSb4HM?=
 =?us-ascii?Q?+qNPSuHxtfd/U4ZG4EGfe8ZCm+k1BjrCYsyFM373+XWsHwn8FL3O8aDFxt7D?=
 =?us-ascii?Q?BWCxOtdc7LMZQxM5jflvlFbgveCyLK3qA61J0zltqholQJyPpYLL8723yL6K?=
 =?us-ascii?Q?R03KCR+W8+ppl9JDzS7htMAk0jLrYnXXYvsiXmb3d0MCHJ52DW/ePiv1vAD0?=
 =?us-ascii?Q?CsZvAvKXTIj22sL8fnUbwrS/atUtcpPiDHITfZhp+0wcRr+8q8iB84ipO0Zw?=
 =?us-ascii?Q?X8FNFO6xoZKfLqGuDxRxupyaZjt6KMqcdpLpDcJ0StG1hssmAxZitQ15JiJO?=
 =?us-ascii?Q?XXSVSNOPPapcZB3sN2zlhvTDximz+bM7Dy+2/S4AWX13WqGhGspSKVCEVmcE?=
 =?us-ascii?Q?fBe0BcFv9+qltR2t4ZL68L4NUPc2SqHzbzSUaYgycFkgoGEnVZC+jC/Gnjex?=
 =?us-ascii?Q?CtGRu3GCw0+noJ3o5Y/+LUeXLBkxyyexiYMC9JlNBEdrrg1MlhlR1R2Eqi5D?=
 =?us-ascii?Q?yfOC65jnt474Zrj5AEYnF0UfQY79EFZO7gkkxqaH6XOC3wprvG/pB5uKa9MV?=
 =?us-ascii?Q?89CbqhTo068Vp4DKLPhPvsogJLwwfYwkaEUWfZ40YBT8K+lLsl3Yv+KqkMGi?=
 =?us-ascii?Q?ciUNVkqUBWZiUgWN8wslCvSzemzN1Od22qCtO1UBOupAAb1tpeFRz4u9m4je?=
 =?us-ascii?Q?/CYZ5NymjWPaEOSY2zmPn0EYScowJjvXKeFZMRywxbtcYqChkI2Ka2aMAP+D?=
 =?us-ascii?Q?1a0SXHnpuuBV4rlUuGMNdsYPWMvnTCpWLJgAycRi+nhsSeh6lCV6gpuIoSYZ?=
 =?us-ascii?Q?Ii4jGcDeIBjwlYSR3iDAyHAMvmULmcEsmscx1JI1Ez8mW6QKH8oj/AeOHpxk?=
 =?us-ascii?Q?JmrB5cezUYc0hV2eCSnTIKksxvyfAQhFlMfS0MmG+717zAHS3F5/473TpPQ8?=
 =?us-ascii?Q?wHC04JvnPovqk6SulElSlnh7cLkteRe57Q0h8rACtchhh3PyOfh344OiQWLG?=
 =?us-ascii?Q?gyfJUES1q9OoA3VjNMOx0zROG69L1gdmhrH51Lry/QurUMp0dXbtCYQ5RyBb?=
 =?us-ascii?Q?q1DiWtWTE/esDUC9MSFPmBomfrUJtRDrG8R/iuJrSMUKFwyE82k5pEVKTuEj?=
 =?us-ascii?Q?sbmNd+r8sqkV/XlJX6KqJGiSDcFfc3aQc0YGm5a0BFwMeY1g4kL4L1ONG4UV?=
 =?us-ascii?Q?MyggiBObQD6LOshW/WmYssf03PiJ/ddbdTKcWNdtg4mD1ey74Rc8CPYnKa0N?=
 =?us-ascii?Q?4YxbgojzqaXARrbdZA8x62EPwfTYqOcYgcwLtEIimmAdtPoQbYp8k70zQk9S?=
 =?us-ascii?Q?l7jBy4ungsmL8+6Eg6WwLhUUr/AfGJSL7beiS8vTi4a2j7Zxs4E0CVmn6egt?=
 =?us-ascii?Q?00JXnkua0rUTgXo8CcKpwGSshS98bw/vtNdAaj4U84AVfmQM3Z3vkh4Cz6jI?=
 =?us-ascii?Q?kBjpCnrcxu3Y/zYWmTnA0GMccoAfGwUKKR3TgQrxlyvS+Hgp+VIYTLddhj25?=
 =?us-ascii?Q?Qzo0Syose2kGxOha0HatkxKTXn/oIMUpJHA8q/BQcBCTy94twbw1FMevjYs7?=
 =?us-ascii?Q?nA6e/egYZ4sFwol8pdtm8dF7yKOZx80ePcivUBVaC5v2OzMakvSUZov4cr4l?=
X-MS-Exchange-AntiSpam-MessageData-1: 5FidG1WsW/IMPec4GSz4I9TJ/VOG79fB3QQ=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c40b259-9819-44a1-b1e1-08de78f7cab6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:37:58.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wt2HqvGF2TNrMUAZ+lO40FDpAaLjTcXV/ukYGQQBJVmJBLSIs8nIFdET9sg28vvv1UlV7tiZgQ9ZJo7oeuoDLDFf9xNvtJ618SRgydI2HCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF330187AB
X-Proofpoint-GUID: dS785k8KrZAnMPv5hMB-o7dy-WqZCqYo
X-Proofpoint-ORIG-GUID: dS785k8KrZAnMPv5hMB-o7dy-WqZCqYo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA1MyBTYWx0ZWRfX21IDuekUY/rP
 osZ7VdIhkAkZjqNT+0nNOOmDvpxzqYgdG9jMpN5bg9jFgVDLao1ZILSxEMhsj2U74fKT+tZMtTo
 IH7LTWq2BPgCMy0SVtlhZrSCoH7aR+KQ9Ltkh+iajZ0VYDlZrPRbjbIe2yntxat5M/Tf392aN+/
 vwKDcdU6Xhq3cKQEvfG3qYwF2y6ZEcrSqd4GdzsYEtPfWYMGcGaGZhTXGJvuuDnalrmekwzo86o
 yJGC66hgyOE6r5sngqNqngPK0Ip2MSEfS66i0eYzPC82DtxkPBiSXiyPsPpaOCQ2rhGPNwurftH
 kG8hB2F8AJ0dkZE1K38sZiGgJlIeKwfQyCWtwIH4uGNsTWIvaAjq3rreqQmPjdB34vIrm3msZjj
 TlkgzGW5agCS6AZtMP86E6HTlHS4xgc55N70ym2V9qTh4iifXSrKiA5Z96M9q7X1TtWk2SD3HG4
 CGdqSi/y/yeKLeETYoQ==
X-Authority-Analysis: v=2.4 cv=P/g3RyAu c=1 sm=1 tr=0 ts=69a68fda cx=c_pps
 a=cAYAfY5XwGGlFG+HVYY7CQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=9QH9bVwfWaJNf-r-aDcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030053

Hi Jens,

This is v5 of the fix for the RT kernel performance regression caused by
commit 6bda857bcbb86 ("block: fix ordering between checking
QUEUE_FLAG_QUIESCED request adding").

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
after modifying quiesce_depth and smp_rmb() before re-checking quiesce
state in blk_mq_run_hw_queue().

Link: https://lore.kernel.org/linux-block/20260213072412.28863-2-ionut.nechita@windriver.com/

Ionut Nechita (1):
  block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention
    on RT

 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 45 ++++++++++++++++--------------------------
 include/linux/blkdev.h |  9 ++++++---
 4 files changed, 24 insertions(+), 32 deletions(-)

--
2.53.0

