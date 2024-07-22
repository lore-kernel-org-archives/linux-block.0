Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2086.outbound.protection.outlook.com [40.107.117.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D0214B945;
	Mon, 22 Jul 2024 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639832; cv=fail; b=swr2ApjvcQT2PLCsmzOx+1//4pAtg75nH3CIg+z4Qib/xOLpZQGEhyI0+EvggMgcCRWzWA+qRok9qnRK9WxffdYWHubPw+PYBjBtDovj4yqVTKyg5kEU96yCsIIG9T8+8csgf7IMxY28FVBJCnm0U3kXXIZpixgImnMhOnkaG4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639832; c=relaxed/simple;
	bh=2H95D7ggIbVc3t0t5BOo6nrLZiQack0flJlqJaB3KrE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uAgz6iE0B3aMYydqKJgYWCutJa5yEcBk3kLL3MNRNkx2NnsD4itgw3uMwEcnav/oujbaxBWLfh3vjDOGEeGtqpO3ccY9Xx8oPeEKf+5R7xlXN8mq9DeTac0Z5j6+UL5P2pP2VcCpvAzdKltLqf25euCfW44wyW/DzQ0E6n5J5eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZN2RLNkk; arc=fail smtp.client-ip=40.107.117.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZN2RLNkk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuGvC8CMTRIwvLDF0CX1b4BhIGxlEDr8JHxN0dUfa557avOQYZ7XGi2iqTbv8CTHsc1ZP7SHfkChU2bEGiyPzSXYjrspBhk/u6AzauVRNCfIRH2UTru69zRAzyLWbqWjbEy+I25Sjlpvr8y/43dUNlOuqKWMHGwZxYVMg9bkP0EnVLT8e1ONuRmlAONIwpJ19L4XdvQH2sDbaUxiVmNzPAkACzuoURe289NPKh9nSFc6y8CIXbC3l1MFAW+0zxWjZLDrobwBH4kNz7QXSkr0vnwyRj4sLllQ8vdgxg32MOWOT8UTr15S3aSrCEQMPi+JkKLkVFDLkCupkwyKB5kQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDX8NLyXEF1NMzkNjWrhLMaHXwk6R/hy3s+Rglb6CAo=;
 b=TFzLDPdTnt0iAtVnT09pHqx4YvJGij1UQuu2v2UeVVuFab6QAayPrBBvynHB3/qsPkZMzQQTofHvPuTg76lN1tdYdFOvinjoVWtludsKjHLlvKK1eoeAh2pvOSXqi+buSEoXaQ8BAvYUzVDhOG6nq7BtkQ5W6RaVdnyBROfG5fV0oblJKzLBvhZRgTg3hbR0dVg7rCmB2qHO1MMTXKwwfbzEbb0Jm+QYoQcJisiUOJ6q02nuNLWfzQf79mqBoXUN37lu7Xsi2ZYKKANc6+D8UypoHimP8t8meqRyFGe7HgI+OrDKXUUfLzkyGK2rixtlHkzMS7XIgwkCTS2M+JHq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDX8NLyXEF1NMzkNjWrhLMaHXwk6R/hy3s+Rglb6CAo=;
 b=ZN2RLNkkeGBmuimnaZ1OeZLFTaXs6yyf1l55nsd9M+hR/R1B/iNvHRQyqDmg5tL5q6Xuf5WT85P6UoywnfJzdZ/kL/6ujQpJE1yvVWRfXfSIRvX3PO5PIhTVqcCRoiliFOBJA/26SYIbNF+xTmy8HXYXOlK35+mPN9T+ConCt/Oe7xX7LW7Km4qoI+5uogiiHmOwUXDqU1JYldUl6g+Chq9gaRp5g/WEY0GlOGdes9My9vjk+TuOuFG+Ea3JiSB4QqrX5JEJ7bR/1iM678ZD2h2rYMDXtubAC4Fx0t92C/iLqPG8cwoOmU4QSr/wMX8/tgJ+/1snefkhhGIrIw53yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TYSPR06MB7260.apcprd06.prod.outlook.com (2603:1096:405:84::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Mon, 22 Jul
 2024 09:17:08 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%3]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 09:17:08 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yang Yang <yang.yang@vivo.com>
Subject: [PATCH v2] block: fix deadlock between sd_remove & sd_release
Date: Mon, 22 Jul 2024 17:16:33 +0800
Message-Id: <20240722091633.13128-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0212.jpnprd01.prod.outlook.com
 (2603:1096:404:29::32) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TYSPR06MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 76843a8e-0ab9-4ee6-cd7c-08dcaa2f0f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?00cKrbZ4WSgiPvbZrvKr9KUkgP3oLkLBc8pnTrunbcPbrzub94oCl1Hmqjbj?=
 =?us-ascii?Q?zLKWOE21CwxcreyYiPPHk+9FCV6HhYpvPPtrB4ZCibumWm25ryX0yE4aOf1b?=
 =?us-ascii?Q?5lakvVj/Gis8KSRKasQgKbhXa7KK46Jw9GCgMMV6F4SEdQpU2s8WQNFaZ76Y?=
 =?us-ascii?Q?OL2GX2u6AE4E5H17qWbf0WFQwGrikIYCR9vS4/Bmxo/h0mAf1PxFq2//fKg0?=
 =?us-ascii?Q?SZTa460v/MGtFyQhZaNoE0Rx40UTE7qfrLaTK2DJDshn0zf98MFv5ayWoFCA?=
 =?us-ascii?Q?s9pMkwwueEbJwWG41THL5baqvA04V6kkgVNZ8Qnf2d/2ZjBnekikiBm/Wfc7?=
 =?us-ascii?Q?omzkflFgjj10EM/nSb1byrgOvxE172K3Jv+u7wXK1brd0iJ79y7zQ8+fAEea?=
 =?us-ascii?Q?zQYxdmptYCIw66iZdT1ittTvzBndEDHOtm97AMb/EXGQ0xDcvjFOVEvx5nWA?=
 =?us-ascii?Q?49eTeamb95Eaikg2s2aF6cojdrmNzq73BX8pXLMG7sM53AnU2IY4JkMNdTWU?=
 =?us-ascii?Q?rgdaUc63CoIQMDOH9L2Bj9hP9Ggjoh4FfLx9S6wOYlFivMI16Tf2JH729KGU?=
 =?us-ascii?Q?mpVNezZWuKXcjNcGskE6LrNLZeAUyaHBWyL5J+wx2HycGdCFkbrwdswXcbi3?=
 =?us-ascii?Q?EZ5fZslPIWT7My+brxcPPFTXAOdrX2ugtQUu3k7EZZEEijXMHjf9+6ICoBkP?=
 =?us-ascii?Q?amHIqhFtqsiHhiGvsdEY7YYpHcHs3XhmB2jMaqnZsQ8qX2CM0PzETzSekI7Z?=
 =?us-ascii?Q?DWupuYMlz46xz++wNACx67DPXomnUgXcHnlE6vIc1UU2uZgLSJ8Gj0LjUEva?=
 =?us-ascii?Q?Bxu51/MCjbycejV8L6FM1fQfQ98WeUTc5fRn+CtLgTf52s/WauihYXLKf4UN?=
 =?us-ascii?Q?13n8iZ492XiPyDIsrP5HCwrt906ZMjMRHkedlqKNpN9JzF+vIESVlCs4FQIR?=
 =?us-ascii?Q?fbrJMQxTG7LOv7eeRUW15/w+/tzol03rF+cHhjTQrhkECdvggEXLxs+l75up?=
 =?us-ascii?Q?N8GCkYfg2SKk7qXzFrD08vUd3LRZNBl/7JW4i5afN/2h6yqsfhBFl0Vv26SE?=
 =?us-ascii?Q?JwGWG3qm48Tg3q/o7NDjakG6uh6S77tj4Os4iUFmdtYGf0/eAsqjX0tdOBwW?=
 =?us-ascii?Q?EMdaaOL8hMReoloF0To5DfYOPYkSc+Czz9o2VDtD78ZvV16yfziiFxhfMpTi?=
 =?us-ascii?Q?7EUt380Bd9g/FZ1PjTZm/kR5C1qdPB/PgVdUrXbqApqgZT15CZe3vPdDWh3M?=
 =?us-ascii?Q?hXAue6Kfifmk44j8U06nM2zoV6fCeI84D5+POnCjkfKSx4E5EHCmr5FVzkhB?=
 =?us-ascii?Q?r42VhWq3EmO9pTq01MwVG1IS2WadmSjSDsKLLGrvAAQHThlloj+KC5noXbdQ?=
 =?us-ascii?Q?BekNyIh6n0/rKXCHr6t4cO32lCeyC0N+PnHiIXnicLOazZQjXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TUI/BzOLbRESnn2D9iPjc1NA8Nl3vrAEPRYzgBimMVC3iXXfNA3IJY9QMlxt?=
 =?us-ascii?Q?/rgKQqPJJ6TO6KDRgtNaiVTThwawg0Q3LsFC2FUA+2rzYXrigxGBvCE80Q/3?=
 =?us-ascii?Q?jtkpicFbjwUKU9uZB/IHLtdZLBNC3+YJASU/VJLUXKtAvfpdh/BHKinwzH55?=
 =?us-ascii?Q?/soOlz127NMRPIMfXzUgob9rfSR3tengMc92B+6UaJzOKUXHys/wu8TFqmni?=
 =?us-ascii?Q?kA3gYZlaJMdYdrweMiIh8Z0/3F9TLJAs2m1nD0eXHOTH4EiBmwtWih64pPES?=
 =?us-ascii?Q?pmN9WI7sFkCP+0BeUkt+iyK9F6N2ygSoBNL42TYAhY7WrIN68qy6gMyogq7w?=
 =?us-ascii?Q?vZAufsv4rWZIFJDsDLNCzb9XXL+4ARw9grkDX7JGCKxYCYd/IkDc3KzgzOjV?=
 =?us-ascii?Q?JUzENvZi9EyxBnlW2c3oU+H3oumqV4Gqf9MgGDELaw8Y9TwKyjl8kxZHdlhx?=
 =?us-ascii?Q?jfXOL67ykYFY87OawP1tAYr4JIhQM6+ySCuBkfXZVv6ZysOVc7guUoMsr/Oq?=
 =?us-ascii?Q?90F+ZdvTiSNDqRma+ZFbsFdl15lrMnrISgQvfVReA1ZNqHacvR551SItvZJ1?=
 =?us-ascii?Q?BAXxS7rvrqCL0MWSMm6zXJhuIsMnwZyfwTYDpSvDVi8gcnBKWKAcSeSJJiNY?=
 =?us-ascii?Q?OC0sLMPiEexlx4I229yEnr4b0VmllY5nwia6PcnbO4cYig4+qYanH26X8vi6?=
 =?us-ascii?Q?7xkx0mXnzRZU29Gk+YtdBg3oX1Bm5EFd2AoOTjEozLDRConXBBfJfRpEcFga?=
 =?us-ascii?Q?CmQDKVYJQ7ykYDnR3t8vuXqYiHW8vrVgdTWWkyi01KyCZTzzaCHziK5BoUIW?=
 =?us-ascii?Q?py3yOUkD1t88/Rp8LiFL4Ngdx/xkKm+EanB5ph1OeokcxtL5/3FfRNXBkonf?=
 =?us-ascii?Q?iHdqTW+U7d589uf0GnN7TvIgZsEmEmMXNFNMnabiTUpetBp/9ynFS+PF8kPd?=
 =?us-ascii?Q?U1wGtgNoi89J9RKdhSTgKwBZDnSeMyhtUYzgbClUiaL+NuopfMS6aNZ5432c?=
 =?us-ascii?Q?l/seP+8SL4X3M3wdr3ZhgSewORpUiSD/KzXZY2ZK+BuPpur3odF4/+wedU7r?=
 =?us-ascii?Q?tTPyIcWhprTcw+vzxAcL7mPkRcoDPrgsILmJIhIPyBGGvw2elLYf3QWfipYR?=
 =?us-ascii?Q?vQitnP1LbcZbrVJOToUajAr4tZ3LbnjfkQL3AlapoYpnr9wPgj/9+5RLO2Yq?=
 =?us-ascii?Q?2l9SIQOtUEeR790kCz8uJQwNJBuFOMA1xUHNhb8eaUnTzfPJ7RyX8ZqhmXnJ?=
 =?us-ascii?Q?Fo6faicTf7bq0FUyTzg02zt2mlI85gwv11eg5D+yza9XrmF0QNWCTgmBZBUM?=
 =?us-ascii?Q?jFvqzbXlOvsPFnPeYth9HgB5RI/Z6j/mgoGraKrQikI4dCm4iQk/05KXHNQv?=
 =?us-ascii?Q?acpqHcwzVK9Ys3vmu39VhkXcDE1wEugu4gfNBMcCQcbamkSGNM+s/NhP/Xpj?=
 =?us-ascii?Q?gss0QfDWpxzhEOYOCavHUX0kpqVR9Ma3dZ8ohGNV36+YMTb5Eov8nBProXSj?=
 =?us-ascii?Q?FkyxEscuuMTlgDmBDYH6wwBfdxxNriJ01l5yZaPH6/64L9EaMCSMWB+O2TNf?=
 =?us-ascii?Q?/+4yfHAtZbT4LqamEIPbexaHhOkppgll4sSxX/Jd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76843a8e-0ab9-4ee6-cd7c-08dcaa2f0f5d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 09:17:07.9562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwdoBWFHW2jvWlCPKg2HjLSIKzi363bv0fVWbYXLzMDSeTiXaxwLVOFQdFwf9oDY2JZfwo7Noa0wGJhFtMqfiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7260

Our test report the following hung task:

[ 2538.459400] INFO: task "kworker/0:0":7 blocked for more than 188 seconds.
[ 2538.459427] Call trace:
[ 2538.459430]  __switch_to+0x174/0x338
[ 2538.459436]  __schedule+0x628/0x9c4
[ 2538.459442]  schedule+0x7c/0xe8
[ 2538.459447]  schedule_preempt_disabled+0x24/0x40
[ 2538.459453]  __mutex_lock+0x3ec/0xf04
[ 2538.459456]  __mutex_lock_slowpath+0x14/0x24
[ 2538.459459]  mutex_lock+0x30/0xd8
[ 2538.459462]  del_gendisk+0xdc/0x350
[ 2538.459466]  sd_remove+0x30/0x60
[ 2538.459470]  device_release_driver_internal+0x1c4/0x2c4
[ 2538.459474]  device_release_driver+0x18/0x28
[ 2538.459478]  bus_remove_device+0x15c/0x174
[ 2538.459483]  device_del+0x1d0/0x358
[ 2538.459488]  __scsi_remove_device+0xa8/0x198
[ 2538.459493]  scsi_forget_host+0x50/0x70
[ 2538.459497]  scsi_remove_host+0x80/0x180
[ 2538.459502]  usb_stor_disconnect+0x68/0xf4
[ 2538.459506]  usb_unbind_interface+0xd4/0x280
[ 2538.459510]  device_release_driver_internal+0x1c4/0x2c4
[ 2538.459514]  device_release_driver+0x18/0x28
[ 2538.459518]  bus_remove_device+0x15c/0x174
[ 2538.459523]  device_del+0x1d0/0x358
[ 2538.459528]  usb_disable_device+0x84/0x194
[ 2538.459532]  usb_disconnect+0xec/0x300
[ 2538.459537]  hub_event+0xb80/0x1870
[ 2538.459541]  process_scheduled_works+0x248/0x4dc
[ 2538.459545]  worker_thread+0x244/0x334
[ 2538.459549]  kthread+0x114/0x1bc

[ 2538.461001] INFO: task "fsck.":15415 blocked for more than 188 seconds.
[ 2538.461014] Call trace:
[ 2538.461016]  __switch_to+0x174/0x338
[ 2538.461021]  __schedule+0x628/0x9c4
[ 2538.461025]  schedule+0x7c/0xe8
[ 2538.461030]  blk_queue_enter+0xc4/0x160
[ 2538.461034]  blk_mq_alloc_request+0x120/0x1d4
[ 2538.461037]  scsi_execute_cmd+0x7c/0x23c
[ 2538.461040]  ioctl_internal_command+0x5c/0x164
[ 2538.461046]  scsi_set_medium_removal+0x5c/0xb0
[ 2538.461051]  sd_release+0x50/0x94
[ 2538.461054]  blkdev_put+0x190/0x28c
[ 2538.461058]  blkdev_release+0x28/0x40
[ 2538.461063]  __fput+0xf8/0x2a8
[ 2538.461066]  __fput_sync+0x28/0x5c
[ 2538.461070]  __arm64_sys_close+0x84/0xe8
[ 2538.461073]  invoke_syscall+0x58/0x114
[ 2538.461078]  el0_svc_common+0xac/0xe0
[ 2538.461082]  do_el0_svc+0x1c/0x28
[ 2538.461087]  el0_svc+0x38/0x68
[ 2538.461090]  el0t_64_sync_handler+0x68/0xbc
[ 2538.461093]  el0t_64_sync+0x1a8/0x1ac

  T1:				T2:
  sd_remove
  del_gendisk
  __blk_mark_disk_dead
  blk_freeze_queue_start
  ++q->mq_freeze_depth
  				bdev_release
 				mutex_lock(&disk->open_mutex)
  				sd_release
 				scsi_execute_cmd
 				blk_queue_enter
 				wait_event(!q->mq_freeze_depth)
  mutex_lock(&disk->open_mutex)

SCSI does not set GD_OWNS_QUEUE, so QUEUE_FLAG_DYING is not set in
this scenario. This is a classic ABBA deadlock. To fix the deadlock,
make sure we don't try to acquire disk->open_mutex after freezing
the queue.

Signed-off-by: Yang Yang <yang.yang@vivo.com>

---
Changes from v1:
  - Modify commit message by suggestion
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8f1f3c6b4d67..c5fca3e893a0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -663,12 +663,12 @@ void del_gendisk(struct gendisk *disk)
 	 */
 	if (!test_bit(GD_DEAD, &disk->state))
 		blk_report_disk_dead(disk, false);
-	__blk_mark_disk_dead(disk);
 
 	/*
 	 * Drop all partitions now that the disk is marked dead.
 	 */
 	mutex_lock(&disk->open_mutex);
+	__blk_mark_disk_dead(disk);
 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
 		drop_partition(part);
 	mutex_unlock(&disk->open_mutex);
-- 
2.34.1

