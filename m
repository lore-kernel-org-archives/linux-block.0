Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9835B632;
	Tue, 12 May 2026 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567438; cv=fail; b=f0QbnGP8yDjQsI+ZxHNrNInDo90S+vqg1ZXW42EgA/FVldb4SSJ9e8kaIvfwooZfll2bXKBa+OmUuCLN4A7Rf2m0Lff+OU+Oi9NP+FcORSp2CnVID2Y6n5gsXIpOp48WNdTce3Q/1Txv7aeF2zzSgmQhsphVNImtWaTZfjCrvAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567438; c=relaxed/simple;
	bh=At2xLHdlap8N/pikDnoueBrBLRyB92jCBMOcBTobJeE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bo2+dhwOpjQO7MwqTj+qmwTEeQw0NWEFqE7ZVlxkx8JKa2iPvni2uhw44GFae6Ab+wupBL+VJ0UJebFR6jizTv7tCNKaeekllPUtZhaKz3jBLJVS6cB70FLzCNmOMP3BHGK6HdLFjfsWEfusIYfQC6Fl7Kfe70hZA8kLFtWEOuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=EnwlDz/y; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="EnwlDz/y"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5Xc4G3495136;
	Tue, 12 May 2026 06:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=DerP8h69o
	YsNwRDazKIotIf9k4jCImsh+nhxxdNVOTw=; b=EnwlDz/ytyvpjEcflA8rAtDgp
	DkfI4Vwe7cml8e5kWG7pRypLDt1XDZdU5IlwT7B8waohnV9MYL7ajqu3+K/BCS76
	FD+GQHTWCkZid8KnSSXE5qtNEg36/BhAHzNqWd0mdp3I4dIkp6M3VnKYEjZ64J/L
	A/vvvu9zEXz7VMIHE+EhfsUzSiG/HPe2E+iXrBnpRUQn0BIj5Hu0JDsGC/NmQcqa
	EvRwMhlOTnqT8ELUnjjkUbELbUMkd1aVf0+nSymTMeu2F7gU01+5tusKRuTjeeTP
	3VEoOtb6SwBCU3GMhRNNXp+NcTFyWe118Bq4lkbTREwCaFUxdUj8t9KmA1uAg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e3nvhrgek-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 06:28:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcAuB0mp1LOBq9EFCJjPTm03auQMoUJAg3Qj9m1FKC1yXHJatjolXJ+3AuE6bPZdzgi9bIIY75I5zXmeblMM+One1iUt2he7B7n3gqhkihRZROpl+I7EazeSbUclr56ccRozDNeOxVIwd2nt5gUeE0q97Tuym/0Vo0p0Bi3m3sScUE4b9DYBEAn9klBGAzJir3WstbpgGyKQGMtGCMigJA+omstIpYHdRXnkjnGMHpGJ4MFh3TnoaJUnyGuAwDUEOp2w3Cubk8GgXWexLqlxHJPCYILu40p7B7ireQG8mn03yEXiZIdn/VmOIIfmXMKYyEOJzH7XOGWBOAPoloXZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DerP8h69oYsNwRDazKIotIf9k4jCImsh+nhxxdNVOTw=;
 b=ZCzL5oJUTmHmJqHgG0NKVdMDgRD+VbBnsFgzStVXPARdJf5LHk0inLRIWbi7ewUJ4lGr5iN+mWH5rxiB59V6ULANT0pNorpX14CmCWq4nUrEfXsbXb3HD6E39Y9j+Qyz0RsBmQwB4FFG9HCxgGK0anpc/bwI9o7phbVrv9Dq5fLGP3xzfP26Lf1MNOhthHg+4OSI6GfuLFWWMypRIlME8xk9vkzR4M36YuUhrp4xchj/VHpsDtnQulLhSohDKcPmYvUgWcGCVWXZ1C/eLUx7/HFI9e19O8hm6TaG/mg2FtStJXv2Fb1q6owVXruS15qAZI2dylryNt9FTA1lWkFHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 06:28:31 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 06:28:31 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: bigeasy@linutronix.de, bvanassche@acm.org, clrkwllms@kernel.org,
        rostedt@goodmis.org, ming.lei@redhat.com, muchun.song@linux.dev,
        mkhalfella@purestorage.com, chris.friesen@windriver.com,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v7 0/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Tue, 12 May 2026 09:28:14 +0300
Message-ID: <20260512062815.10815-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0119.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::17) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH7PR11MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe55502-81a7-4255-fbdc-08deafefaf64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|10070799003|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9aB+cn5iMTmqq8gYutF3nVAJbNKygC2FRS8HeZk8T+ktA/PJDe9Yr9/+Mkk2YXsnumQ09Y6n1We5xjZgO6AkBAx9hb3P5hnaz3FW8QoUSG3pSrbgwnGQjJv8tvm+ImyaHmElZDVfnbZeU1M8iS+LOrcw0tnxxkphDKWBW9B1hj8W1PoEaw4ySCJF5DvBIhiveoxAQLH5s5UTs2bujEvWO8fhi53eW4l0YHdMyrgk0A8dHqEhr93SRqAu3RmDOv5D8bTWMwcaEwWm8cBLfbiFFhzwnGldoKF+35T/UsSh6FoKayhBnFqVijEONuD4X9NDnpJqiDV1R5A08wtSUIR/b8WsReTeJpLfrLxr3c1HWXpxTVXYsLQwnBBD5Y4SKxCW4yEcNYuxtrqpDsGDyxuPbG89HYQh7u/gi+fyQ867draLl/Q2t/hVsApfHQpWWQCCsk77kx/vHYsOkBfnYE1MRg94CTCeUEpyN0dHjsjplhhdYE03D93N5t6nvFkK042NKp9yNOjTeqClRmBkJgRMvoOdpQO67cayNLhm2CoTH8FTBSAGjo7FbH0iOExMkHygwd2x/S0Fxusg2/kpm4gbsz3EU7H8cBaeIgfTPJqT9MdrIQ+6PBOXoYms00R3v/Il8xGDEn9rgAD1w+2yWDfGJuGO8oqtTjzx4aooyA6pWOTMgLc50H6yrZKJB7XMQ6uI5tHkcmmWo9wVsMbkyj1PqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(10070799003)(11063799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d53MYgr/+s46L9SGZ6R4M3yb4ansBHfH1XOT5fuMT+3or6gmRptBY1lxb+KF?=
 =?us-ascii?Q?DnXXnWsl2q6sPt56A/uJC+ON7YsuGhZNACjWhit9hHnYGl07oep7Svzv76VQ?=
 =?us-ascii?Q?6ORw8uvhQuJjtFh/C+/9KJAyAvj8eVR5G4w+BoT+sQAuTMfef8apcejypzT4?=
 =?us-ascii?Q?B5RMgizeEXlV13XRyEUa/VfsZc0wN2cfxz0dZqKkIp0xzItZ+uyayT4NnVD3?=
 =?us-ascii?Q?BVkVkG5TFaUpiTZJpDS7u4eVj3s+erIeJWaqbFyndyMcAr7h09dWF39Gj8bR?=
 =?us-ascii?Q?QdgefHCNgVPd6lTiqAdXKkniUT7I4Nt/SOVchkXuMxswaynkD4C/x8SZ41Vt?=
 =?us-ascii?Q?TOXyPWqUQBKgp+0UKdyuw9Z59nPN+3xjrS/5CMMNoC6kNtr6N3zgXdo/l3K7?=
 =?us-ascii?Q?V6sY/ySLGauc/7CIw790yN2I9NwwKTeNuMyrCKDdEQrXuOAQtfSYJsQqEnfL?=
 =?us-ascii?Q?8q1LgTlGc2hPMCln/FbhyVZCXuWJivF1cNE9WRlakQh6WBqyzj1W+gqMQ2U0?=
 =?us-ascii?Q?NlWs3A2Yo3cjXNnFHtkZWO0Kgt2FLEKBxoOk5EjWRpvtNhMX1nZ8J+LsgjjE?=
 =?us-ascii?Q?555BUkwiAhrNI+5HeTODYsA6SekvN0pd2Slhzx6Rzz2yHr6e4xNsf83kJbwa?=
 =?us-ascii?Q?og9rbO0AATXlrZN9CIGlBPjf9pAiPWEYf2A4OfiuZD6tBfXylKIRd2GBRD22?=
 =?us-ascii?Q?Ofax1FJVRoR3YbZOMVfFWw1cOSlw5EO6J9n5SIu+JEOBlKmNXKUTWlTniggc?=
 =?us-ascii?Q?TWWXd1Re/bOJ5RRHLp4LOLvyMkic+iXP3Dk3IkS1xDKuoqOogYYHtu1EhgGD?=
 =?us-ascii?Q?v0HoAqlB7/jKUhWnceb19UBqKfOtkA42B2Ndg5t2533AXCYllHFSjcAfn+Uy?=
 =?us-ascii?Q?xZFs8Ypq7612zobji7DWnHnt6zsIzxiSjaKAcOTDqXiq45EtUnP3mpAvTNhX?=
 =?us-ascii?Q?QNbefzQ2f/ZAZd74GW6Z/DTRx4UF71iB+QyqLPO+nOEzXomvB/XlfwGczvjg?=
 =?us-ascii?Q?bgnMeSuNhIa+Q75JwQR8gpmi4xsrpsQhDDPeTvMxRG4DaD9v2YTAsjD+Nv7C?=
 =?us-ascii?Q?7qt8c25l8iydM+kCa6+1a1epv/eNtC/bK1RKNV/16HsXbrKA+9ik61w5gvYK?=
 =?us-ascii?Q?78oe6I9ykF79L9fLACOaRbxa5+AyUWkFXt1IlcIZFGgPhsEX6KK/0AI6HBkH?=
 =?us-ascii?Q?hXu5DXqDYnJAc3Bumc5hhq4+of1R7gTRHlJsh2FQnQ1vWf93eRGozBIli/N4?=
 =?us-ascii?Q?Id/719xv2rHQCoT2/iLw1igi34FKGtjGOTZU8Bt+RlfEDloFo3cE77Ue3pYg?=
 =?us-ascii?Q?LksnOMuY1/mbdi9YUaURLMlqEirRW6OoagKCwBded4d5mpilQtkoRvC/BYB5?=
 =?us-ascii?Q?NSPBSoxfYZVbBFa0MDaJyMEplTr6JOmTCldC3LSSo67UFVEv6+5rWr/Vd7GR?=
 =?us-ascii?Q?GOr8qK/ZIq4qYeL7nybycwdpIKucLJ/fNudz2JU0kAuUTdRdxFxqmXc3sITc?=
 =?us-ascii?Q?ZOeq7MtRKH2w96zdDOBeEIwmEXDprac1lvdEYIRTenV3hqhYstSf5pTULSqq?=
 =?us-ascii?Q?tfxw64TXeuCZd9667CboU+EQ6BLLE7u2lxfBQknJ7UuTuW9ig9mRZA7/gNmL?=
 =?us-ascii?Q?T/C5Lxm24DEFJd/ELjejWXbMilDMEgFtYeeyfql/WtmmmVwZQ1JvhhiLUnrd?=
 =?us-ascii?Q?oz8xaCphRVD9ELeU8DSayZMCoexbyin33fmRecLFb5cWJcUU8l2Ru0Q6CSBV?=
 =?us-ascii?Q?HNt7hJuYzTqimifGtev54QAowY6p3/0avHTHdCXdezJ5oijrrT7k0n7BRn/i?=
X-MS-Exchange-AntiSpam-MessageData-1: QWR2IxS3LJuKoODrINECOVuM7wIo9hpRQ7k=
X-Exchange-RoutingPolicyChecked:
	LDXvC/dJjDa6RHwlkNPjRf417RKNrEku6ADfORYZbgDamJGecqYjCOx6zXtfcQuPR+LLI0KWfrG4qkHVdUtfuOVmp+3OF7pG0Fd7SVM2FqeWAK4BCmx/7WQymQLVa+rXmInkIfjURyr8g1Co2F2NGG+iXtJiVE/i/RgpLZJWfQhlEYfKvJky97Hq+mnNuqRGdkxxPjTeTKdwIYnObTuMKeAIwBA+Yld2gTYc0yV+rSq+7ZAlLB/GhkUffc+eKxG4y6n6brzPcDtrhuSZY0wCndLfjjTsLaRRyy0uBn0FqUP87vOpgrhPMEvSBUNEYxfDT7IJW1/a2cWnAaZAWIDh/Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe55502-81a7-4255-fbdc-08deafefaf64
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 06:28:31.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kSLantPCUupsXeZY/h3IVy8ZJCRo/YsYWVxNDxTfEblzyAk7+m+kCUjVYSdOysYw+mXx0yumJ2tKYdkXPf/xRbeCc8bVwT48UI4rzH3V9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-Proofpoint-GUID: rzU6iQnX_fRV9JE4wt6NbzZLBnYo4oSy
X-Proofpoint-ORIG-GUID: rzU6iQnX_fRV9JE4wt6NbzZLBnYo4oSy
X-Authority-Analysis: v=2.4 cv=b4mCJNGx c=1 sm=1 tr=0 ts=6a02c892 cx=c_pps
 a=MmwiYf2CWIeG5bfvH5NISQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=sDdoM26yXg4Nh-bVvhEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2MSBTYWx0ZWRfX71ir4thUa67A
 XMrHUxfwFw/FWJJWFS9HXuDFQy4bBbBDzw/ojHHW06/zXWiIVkcsfhSQAq+SF6DhGkcIF5//wEr
 ZD7nEj24jgSV1fHIMWARt6zev7uXjNZ6wcZ+3XKupVS2Vr6VdJKW9lots6SBK6DcPAEqX1lGEqT
 9p+vIAzJCAYnL6DJ0bBwtMOUYsPjjf1JNZSiDcCLN9QD0/6iUl3Ly4YSyuds4CHdTZ3jzFh6/AX
 hsdaNrnNL/gJOhBMdKR437weHn/Oa386ZvLr97LhIjw8TMDOF9lPDNeL3e9CuXljy+bDHZeFqZX
 BS5z/SQtQH4ZsKIxJoyN9wHGTTaFcrk4bLVEDwUUIP0TV8IhczXIaiTdzFi2xcP7tv8mYyWwtgm
 0eCm3HXX/YBN2WVV3FEZiyTaqRFZkzUp8LUAoNbN47obT7r6Bpb7UrfyFR3xZP0m/WW1wfR78Vp
 1/GL7k/+XatKOJBibyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120061

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Jens,

This is v7 of the fix for the PREEMPT_RT performance regression caused by
commit 6bda857bcbb86 ("block: fix ordering between checking
QUEUE_FLAG_QUIESCED request adding").

Changes since v6 (May 6):
- Reader-side barrier in blk_mq_run_hw_queue() changed from smp_rmb() to
  smp_mb().  The race closed by commit 6bda857bcbb86 is a store-buffer
  pattern: one CPU inserts a request and then reads the quiesce state,
  another CPU unquiesces and then reads "has pending work".  A full
  barrier is needed on *both* sides, not just a read barrier on the
  reader, so smp_mb() now pairs with the existing writer-side
  smp_mb__after_atomic().  Thanks to Bart Van Assche for pointing out
  that smp_rmb() was insufficient.
- Rewrote the in-code comments and the commit message to spell out which
  ordering the removed q->queue_lock acquisitions provided and how it is
  preserved:
    * blk_mq_quiesce_queue_nowait(): the lock only published the state
      change; the actual visibility/drain guarantee comes from the
      synchronize_srcu()/synchronize_rcu() in blk_mq_wait_quiesce_done()
      that every caller invokes.  The smp_mb__after_atomic() is kept so
      the helper stays self-contained for the few callers that defer
      that wait.
    * blk_mq_unquiesce_queue(): write side of the store-buffer pattern,
      a full barrier between the quiesce_depth store and the
      blk_mq_hctx_has_pending() load (atomic_dec_if_positive() already
      orders the decrement on success; the barrier is spelled out for
      clarity).
    * blk_mq_run_hw_queue(): read side, a full barrier between the
      request insert and the quiesce-state re-check.
- Also note in the changelog that this is the memory-barrier alternative
  commit 6bda857bcbb86's own changelog described (and rejected as
  "harder to maintain"), and that making quiesce_depth atomic_t turns
  the lockless blk_queue_quiesced() read into a clean atomic load
  instead of a plain-int read racing with a spin_lock-protected update.
- Rebased on linux-next (next-20260505).  No other code changes; the
  atomic_t conversion and removal of QUEUE_FLAG_QUIESCED are unchanged
  from v6.

Sebastian's Reviewed-by is carried over: the approach (atomic counter +
barrier instead of the spinlock) is the one he suggested and reviewed;
the only functional change in v7 is upgrading the reader-side barrier to
a full one.

Changes since v5 (Mar 3):
- Rewrote the memory-ordering comments per Bart Van Assche's review.
- Rebased on top of linux-next.  No code-generation changes.

The problem: on PREEMPT_RT, the spinlock_t q->queue_lock that commit
6bda857bcbb86 added to blk_mq_run_hw_queue() converts to a sleeping
rt_mutex.  blk_mq_run_hw_queue() runs from every MSI-X IRQ thread and
hits that lock on the common "nothing pending" path, so all IRQ threads
serialise and go to D-state.  On a Broadcom/LSI MegaRAID 12GSAS/PCIe
Secure SAS39xx (megaraid_sas, 128 MSI-X vectors, 120 hw queues),
throughput drops from 640 MB/s to 153 MB/s.

The fix takes the memory-barrier alternative and folds the quiesce
indicator into quiesce_depth itself: quiesce_depth becomes atomic_t,
QUEUE_FLAG_QUIESCED goes away, and no lock is left on the dispatch hot
path.

v6: https://lore.kernel.org/linux-block/cover.1778048987.git.ionut.nechita@windriver.com/

Ionut Nechita (1):
  block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention
    on RT

 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 69 ++++++++++++++++++++++++++----------------
 include/linux/blkdev.h |  9 ++++--
 4 files changed, 50 insertions(+), 30 deletions(-)

-- 
2.54.0

