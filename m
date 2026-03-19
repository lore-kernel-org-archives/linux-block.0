Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022105.outbound.protection.outlook.com [52.101.96.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5741377ECD;
	Thu, 19 Mar 2026 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773958810; cv=fail; b=oVPXg2FWmjwC4bycrGecFCfjheNXuv860Dg3t0kxmLwVWZRJdIB1ZuXq49LLxRL+LIbSD2GUxqodNtgV6fRhxR40f7XG25BcQ4RSU5NwRUcBsrr4XSZdmIsLFPGPfkiq6ZaIlA7hFSWlkmLY+qeENuWH4X7Ek8efCZ+hCWy6jhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773958810; c=relaxed/simple;
	bh=CqEN9e7TzikPKt5vTgjQ+oXCUXipTj63Ge3CA6yVrJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MFi7JzENN/cMVHB+75CuEb0Hxn2TVvc6htHq76rTwR3Zzll2eAbjruoen2zvsxexcEkZ7KDc11oyeUX7szMfk1fVSeFEE3nrLWy516je33WIvsJ/nixiNYbpnVclHGtoPHUqxE/sfCRoOFjYoFixclBW2gxm1DrRHsCAVsJu0sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSDi8xaVzCOrbFqwHRp3u/wKLW9TH/QM+sWa5JwIGl51hlMBeg5FEnMJsxxpQeZ3u8n2vNvUHyk9LCeOz8EZuZBYXVZmDcdQ4C2nZOM7iT9StEtYAFcZ7F0RKIfvIrJ6B5LhfW8Jb6N0kuoiLf8FCQ1+/Cb6f1MXwTTIU05xeaVUEgCgMQ55ZurCRhoVW7QTHVHL77njFSjOzT+ZxwC3Thte5cE6+YKHwQY7AQyhTlN5tsUfEXadXhep+fuxJ+0I1fIMgHPcaKR7Q8tphgAPe6uI6xCIra1TvFUBIae51Hqbc9MWznKSZ5lLDZF0om9qm1SHRtnbxchASnzvCIHmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGusQqkJ6jaLdH9ZxnbPWshfgMW4H5ac4x2kHYAm5F4=;
 b=rruob19FfOaB7p/E8ubVN6Da3gscO8ttgKrf3jmCHRrpCN7AUHAv+B/N7U22jKkGcx51oXLlOpzcoraCxHz9nVSMDDGCj+O4l6vUk8NRCXRFwSS9YrUd2OyJISDYcFFKjRmytctIpmkXTY8DeohM4CgNxA+8Df0rk1AHR8UkuN7k4OezPkzr+UuOuLTZI5/O/W1N++/WmYpMY9yhClgemSKBgjKTAF9W+qOI340ExOnUidnYn3oldlJVZF2qOkCAxIFJAkKs50XL0yhSLcdGe54V5QBCPGL/vfjl2zVXVwfb9/oIhikLDgNiSqZylWnR4UFmREmpA6lUbh/Es7wMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO4P123MB6712.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.22; Thu, 19 Mar
 2026 22:20:01 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:20:01 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: johannes.thumshirn@wdc.com,
	kch@nvidia.com,
	bvanassche@acm.org,
	dlemoal@kernel.org,
	ritesh.list@gmail.com,
	loberman@redhat.com,
	neelx@suse.com,
	sean@ashe.io,
	mproche@gmail.com,
	chjohnst@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] blk-mq: introduce tag starvation observability
Date: Thu, 19 Mar 2026 18:19:54 -0400
Message-ID: <20260319221956.332770-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::18) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO4P123MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: be994c5b-03ff-4e2d-de97-08de8605a9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Mm0sU+3Wuxp5y8UT1Os9Uu+DXYon9IvYO9mZGNAw5BHFVTXfM1H04QVQ+9WMe24nimSSuhY8j3W5hv46uKORhIEEa/Chorpgl7/fcq7wx1FDxLgfCE3vrHTZ+A9K5jPeM4ry4QftK39S+BT0XAW0UAFfU3eLE1O1v7QESQAOI0HoZc4kR3OxDXOmrczTni6Tx0IgDcTRw1IYE/lZXnWS47jX67WiXLvhAgAltKiH9cK62/2Rt4NtnSK3JN1ebNc7Vw2MGPItH0NnGKwS2/Tf4wZUmdYv+RZ7xIGgpyvuT3PePDwdo6z63MBO5qgDRiXgQE+ZQdyq72xUE181SP3aT0AzVF0z/bOj8MRoHIznv1iYra1AKZ2HkeevTPyneFiW0qyw9JR66W6KidlyhJkJtIZt+VyBCx6bFTDSNjspIxRsp6KYXoC0CKimqAYF34j/2efXn190Vzya8FEFx1uCOz8g66LsLsapHTs55WQRvIYUw/F+lswZPDLa4t5Bk1I9Zf9acuLmkuG0XZnOCBxGznA4qcDxdebGDRcuH1+jKSRyfoyRZHTVIbwupz8sSHVdYnnigxIbl1A0esdKgAXOv3BJk1iw6DjygetMlbb3J6/OarpeMByhRkEYP5GeUtSucpqo26X3e3nmR1bG+G0ZmlVrGu5wYnpfPu8aE8xVojBGuGX26oyRWu2Xmqa/r7pil3iX08ffzRWq4M+ixoeQjh9exR7R5FR+viG2ic3kP6g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+zs1bDNNjbSKCTVlFgmXmB6k13Upv89k/u0fdCeB7Xt/lDmPrgNYnjm+gPay?=
 =?us-ascii?Q?4waG7XYd0q5+zZbpgDu8gjpG0HnEukoyKJZycaYSDQUk+KgHXzVrhl/3if/h?=
 =?us-ascii?Q?FMTrWgmSeWVIOaG/25w+H9EqD9/emUNNFm9a4ZLTT+oPlIFGYzrMkvrZpRg6?=
 =?us-ascii?Q?kXrXi+VefYJ17bOnLMb9DJzhPDZaYF7Rc/7/B2fVqyIWzBfnVWXvICOwplm+?=
 =?us-ascii?Q?XbE315YQC68Pnne+RltOaHUg8RYdaIbGcI859Lp7l7E0HSTNP9to42YBI7Wb?=
 =?us-ascii?Q?a0R538ohdFofmL8D9H/jdZHnzTqCN5CEDgm2WZiUjYoJ5KdjHb4qkIH2l5yn?=
 =?us-ascii?Q?vVITODY2QH2gmt9+NcnlODfOe7VPyLJ26ws9/uojMmbtzRvG9lfcHpES06p5?=
 =?us-ascii?Q?Vg8rXuF9B/+VRcAsRDN1LEjp9w8//8VVUaWKNJTAuNNjAycckWSpebp4S9oS?=
 =?us-ascii?Q?K7caQJhFRyKWu3GCYYs19sPkLjCIoqH101l1XZZ7UtS2oYIovqXKO0LDbDLG?=
 =?us-ascii?Q?Jtn3ata0aIf9Dhl27ndap/cMMRModnI7+7GGyJq1RlCGDLakMSF21ayfNXo0?=
 =?us-ascii?Q?3wDMR0RO2fuvP3JzMjEChMu0auk9ln4Vmn5GVsnthh9q/sKw1UaAZjLQd+oo?=
 =?us-ascii?Q?JV5sPpAIVU4SEAMk2CV3IowWkF6qUAwbb9n/kMMKVWKG3cC1LeEjQujJGIpS?=
 =?us-ascii?Q?w3EPiQrEs8APB9+8EtxiJ/6gw4gVSLPXv3JDPgiY0Nndy/gJuIMpba7mMfxT?=
 =?us-ascii?Q?QX/RBAF8FzRhLlNEHL0B2CGGwG1GM1hM/2Z77SNHUnNagDFLlO6lIxyq2dS5?=
 =?us-ascii?Q?MgV0HdEiQn9g0lg7Ho8CWXKUgIhSX+POu0SJ2tOZrzdgs2mNAp7YP9Av4YJK?=
 =?us-ascii?Q?dPYguSo8Nju3WX4d20O5mf8L/d9GRaHBCOLg4NIIL+atdUAZjXluZmhFUnrn?=
 =?us-ascii?Q?kFSFjWbhGPBA0EChkur2A+Awjju/A6FrULcFLYhpVEXDp0hOY/XBt86+bMKz?=
 =?us-ascii?Q?CdALVNbdA6zt85akI9bkqJVMNy/y9lD0f76je50H8N5Gd0XkVpOhr3ARDv7c?=
 =?us-ascii?Q?n8Ktp8Mym1tURl2KkJpuo+CJKuI8tKNDw6KMou7jaiTSq8/GWpLCaeF0fGZJ?=
 =?us-ascii?Q?uxbyjeZFuWaP2CW3RXFuUQnfaWiFZHItrmOw/6XAMO4I7YOfrnqEzK4M5Y3J?=
 =?us-ascii?Q?tOi2sbMJXYWXY389p+xA/QBFC8r+T3YwcVpacgUCb8hTPhkB67dhxv59wofY?=
 =?us-ascii?Q?WBQt5DKKBlgZuxKzFkDoYZ+CcQS8VybSPzHUJk7Ni75Bxk3/bX5B66Ij7pot?=
 =?us-ascii?Q?gt4VgDaSmiYWDVXBg8ZiCCx7Cc6jcdGbeXoLKlvv5ssFzFA5GE6jAu0PM8m+?=
 =?us-ascii?Q?461Ed5ZKL7sKvP9hQUCAnjmNXSrTqdIcgLAeurPBbhRB7t+8/k8RaYsgJcFd?=
 =?us-ascii?Q?iOsceF1l/AXDFvT01ehepyX8ijFeIUGZl1+73T6lrYZK0sP/wmJwGbUlfX1i?=
 =?us-ascii?Q?YHz3WE/AWxTDGNaJIWIr9flw6t5AKhnDNoLJcGcIsQNgY6Pq4G6lvXNMSY/3?=
 =?us-ascii?Q?nWhv/7rNHUzo/vCur3RwdVuICZ9iGOu8b1KLGZltd2JXr29K+0XDTrPcT9SE?=
 =?us-ascii?Q?6FxbWVjYM6anw4PI/RO6WIzbVzBgjRAgVaEQlbwCumwCqbum7Yo9fpsLnqJW?=
 =?us-ascii?Q?2psc/+6OI4JMehHGrCW3+4CI8aYsfG643FDtNjgH5+3155yEs6ERFB5TWGOw?=
 =?us-ascii?Q?aFk2WPO4qQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be994c5b-03ff-4e2d-de97-08de8605a9b9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:20:01.4791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxb76CCeJeig9ujgKF6haREOsvGHxcNJ/rBIXpdcRZ1Oh+6j5GEXswL/T30ZLw8EpdrELDXZPbu+zUBgwMTShQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6712

Hi Jens, Steve, Masami,

In high-performance storage environments, particularly when utilising RAID 
controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED), severe latency
spikes can occur when fast devices are starved of available tags.
Currently, diagnosing this specific queue contention requires deploying
dynamic kprobes or inferring sleep states, which lacks a simple,
out-of-the-box diagnostic path.

This short series introduces dedicated, low-overhead observability for tag 
exhaustion events in the block layer:

  - Patch 1 introduces the "block_rq_tag_wait" tracepoint in the tag
    allocation slow-path to capture precise, event-based starvation.

  - Patch 2 complements this by exposing "wait_on_hw_tag" and 
    "wait_on_sched_tag" atomic counters via debugfs for quick, 
    point-in-time cumulative polling.

Together, these provide storage engineers with zero-configuration 
mechanisms to definitively identify shared-tag bottlenecks.

Please let me know your thoughts.


Changes since v2 [1]:
 - Added "Reviewed-by:" and "Tested-by:" tags for patch 1
 - Evaluate is_sched_tag directly within TP_fast_assign (Steven Rostedt)
 - Introduced atomic counters via debugfs 

Changes since v1 [2]:
 - Improved the description of the trace point (Damien Le Moal)
 - Removed the redundant "active requests" (Laurence Oberman)
 - Introduced pool-specific starvation tracking

[1]: https://lore.kernel.org/lkml/20260319015300.287653-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260317182835.258183-1-atomlin@atomlin.com/

Aaron Tomlin (2):
  blk-mq: add tracepoint block_rq_tag_wait
  blk-mq: expose tag starvation counts via debugfs

 block/blk-mq-debugfs.c       | 56 ++++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.h       |  7 +++++
 block/blk-mq-tag.c           |  8 ++++++
 include/linux/blk-mq.h       | 10 +++++++
 include/trace/events/block.h | 43 +++++++++++++++++++++++++++
 5 files changed, 124 insertions(+)

-- 
2.51.0

