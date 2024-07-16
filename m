Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2046.outbound.protection.outlook.com [40.107.215.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7F17B419;
	Tue, 16 Jul 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119134; cv=fail; b=PG+ecW7jv3J8I9k97fBH+4z8usdGUiXveOVd2E+suXBGn4EHaBH8Cn/6d7eL7q06z9OxcIH9eQqEFy19bhnvRDpKpuAD8tFjLTGrEo9hEsm+0NG1BD/b+k6isYD/UYV24oqKvr5GR6UxKnnkl3m3boydYTGp4kPdvIKvZpSCAt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119134; c=relaxed/simple;
	bh=PHH61avaQP4fcfL7xy4E77T3GQuXi/r4ZFMLPhCaGv0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dH2s2OcQXMT33J9mJTAcbaslpQMfSpNGwC74t/7ftSUC4MZa9nbAYZh9RQa7k75HLzKtuAKUcDNSzetLltGof++94xIRfNqEk4eD8x5BmOLykebFo64k7M9AsvCnV73EGRc6vC2EW071ljrRPryjsyJyyjgldf3uaK6HcjIqBHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iWGvOR1F; arc=fail smtp.client-ip=40.107.215.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iWGvOR1F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVt/07rF1NUlxE+ZHKqIgdtqImGF2Z27ESfZGaJ+Y8mSzRUqYJSnaJWErTnzC2C3x/Z1UuaxGqCFe6aLNOXfZXk7jhwoJPu1Vh4qdODpPu9DPv5GX2G6BM9b4beeDx2iOg4MqLSSs1U2FTXa2st1XEn1E2Ks3PAQSy8Ifh8eXoJdDPs8WfMM3lluktVFf9qYiooAjcSG6h14+iIcbzvgkcZqOd2eyaV5xm2ywZ88KVk3MJChJPDFFP3x0Lyqpltrlteyyju+OFyMS8/ZueWKgRtQQ+S1a8vTZhPOts3yyGzSLTp8Ty65gmSeDxzeDjuo/X7dTmS7OTEs71cjr7o+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8jAdShYLCXygWpLiTMSsbCk2Ry5gKfnJV2ytGPiSx4=;
 b=CVkhgV+0NfzS6q1q3UqeUihHCqWpDpgU9Eo83Vazf6CPJ6z8MtWAnymdMmo5q84c6VX3+PsWehcWoIVWeZzXjGO6WM+OHlGB6ZhoTlZNbZX69KZU4FOqidPdYvRUW3fG3ATbxX4J0M6JBpSTRJrCmKe4Ck7VckBfmlg9yIxbiDxjmV13fefDhxJtrCS/183Xf2MOrdeWas7YhCCgDJy+YNUuZaZdVf3Yo1ls8/o2S9M0iamo0fUr8LIdQcFE0VaixWvMZVqhtCDtE2uCC3WP0DpfR+OEVBE3mgPK7P6tN/GX+sQJaoy+bQ5piYvtIYh6IQjmwx3lToZXdjjFd8rCJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8jAdShYLCXygWpLiTMSsbCk2Ry5gKfnJV2ytGPiSx4=;
 b=iWGvOR1F8Zg478hyRCSPYZ5Fh3zTFouAPTPKdFwxUPy+k91pbF0EUgTI2uhmMFTikImPBDPTl5UZCm3ykZiKDBgmpRdB6nQpuT7FT0hv/CPvlqYmo/0IA7Rau736+gIejSESinGGs2nkNqL9DWFJkCfYennbEI43bZ5Xia2PxznJeuryKR+tAcXfflCFZCoL8pvEooUV7qFiWKq0PrTrcuk+1F6ElJ3HMO3clyn24su3ZIAIfi/LprILbfGNgTcZwTnn4BtVd2wNwBD3pc7GdruzBkEhLr4Ff6QBl5eIke8gfw06AsQGBHf6ERZuinBV6tO5MMB1WPjoYlWj9UL3VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by OS8PR06MB7324.apcprd06.prod.outlook.com (2603:1096:604:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 08:38:47 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 08:38:46 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yang Yang <yang.yang@vivo.com>
Subject: [PATCH] block: fix deadlock between sd_remove & sd_release
Date: Tue, 16 Jul 2024 16:38:00 +0800
Message-Id: <20240716083801.809763-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::17) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|OS8PR06MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 24afaac4-0a71-4682-d1b0-08dca572b568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AS5NjzDOeczTu9emHPe+JjW6WY+yFs+1kkSwQKafvYZx/pmdsKLh61pJAGrA?=
 =?us-ascii?Q?QK6WEKUAhGuzl5/58Y3ZoXO7wZwlKiceN3WmGU9xN0xVso6O5c/HNknvbvPD?=
 =?us-ascii?Q?EawypRzJdLDTDYSIjPT+OdcBV3hN/k86QpjUcch7AH2FLWxvd18QT8Spmg6L?=
 =?us-ascii?Q?1qHPAY0eK36sDcPq6kLDFYm/jtmagsOkGBsjR+DlECveAwGnbPhSjU7vddJi?=
 =?us-ascii?Q?tj8wo682PlUyk8AQXrOCe6PeztJ0VmWhDXQtyaUM6sWK/TqLe7KVjjMXOk0U?=
 =?us-ascii?Q?0shxSiU3J+XaENlq1jLK6FDXXV+sJ3qLxU7NowaXiud4G9rALKYCqo+IKien?=
 =?us-ascii?Q?HGgo+fHYFAcDuXGfFOAs4SoFu83i6sBnQi2FegO4NRBftk8yEwvU+I+1jB66?=
 =?us-ascii?Q?65xnPcWBeJ3/rqyU+L97yX/KgP6FEZkRz8DsbfjfyyU0bhyHEcFFXLkr6yv4?=
 =?us-ascii?Q?lKctNxyYNMyFnVXolUWFXCQloQJmBIIK9Ib+eS3mf3eli7iic6yKBRYawKmN?=
 =?us-ascii?Q?x3m+CbsU6fvL7PXSSEbTpINE5hvCbiKRMO4v/tmPlTBuSdFWhHlgPggIgPXc?=
 =?us-ascii?Q?JXwvhUN396GYyH86hHXer9f9FPg/y7r5hbTjByhiNjpeNGLcCDxoAvOob0vk?=
 =?us-ascii?Q?EZA1vQJ8ZlRPLFm68agR/H6SeCa95iE74p/LV7SLtI9tdCsvzoAe0z1QWJKs?=
 =?us-ascii?Q?3l3+2c9aoaXfPOJwnLzq+WM5PBXAkE0pPYIUkSFye2G1GArf3zkfTv77xXZb?=
 =?us-ascii?Q?qhl+FILKVJAXsZZq8OL6laNbufDpsXtmhbdVfLrMka0smoIEHTDbydeQkQRo?=
 =?us-ascii?Q?GBTuFnXBJaQtf0P1NtYTJ7E9RzTOuO9Fxl+Tzcf5xNFtyximO6KwVYJhC4bR?=
 =?us-ascii?Q?AvWN5Z0jCJ1/wTU4DAY3JahFWLh5YJOlOXbI8Z++/zrErcqTouzSSIMZWoaj?=
 =?us-ascii?Q?A43nvg57YgtejAVTzlBOqBxez1irIpP/0G/N5xrOdJQjEzLb7bhh7Dl2WvL7?=
 =?us-ascii?Q?meqqhtARzKXqn22boBa7QVcCo5GS9Agg7y/Jk2s5F0yayBNMUku4w96SKCdw?=
 =?us-ascii?Q?arBZ72SLtITuBLSb1JZG5L+EcpsVrdRxS+605UtfzpAP8c6y+0ierE8Uvklg?=
 =?us-ascii?Q?0TWtFNdNShsMjxcfAprHMMyGTw8u8dt2E7ZsbSh6Ks20jWfypgPKrJMDbqg8?=
 =?us-ascii?Q?OPLDrbxRkLZCdPKgUn82FrRFVF/q//jg+bK7JJ6o5cNBHI+RB6cT/7k7dKHF?=
 =?us-ascii?Q?mt7+zmRtEYoqpLXbXMrxV67GsR02jepq6w1PuDRof+hj44NFrW8QnbKyGbus?=
 =?us-ascii?Q?3uxemj9EfSpW4n3IVdfXyVDSxlbT86Fn1qfMdeNnl+msaGa0B8laVyqwEaRl?=
 =?us-ascii?Q?fPF/Z5vHtWUb4+Xm9lqLX4IkzQOGbSu5wN3jSwX0/yJOFkke6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mB1z+ZnIdbGtiCncRASNJ240+9KIQetS5YOJvzoujJAt7jHRzmM4jGTe7kyv?=
 =?us-ascii?Q?nC2RCcMymyrsV14YpMJx9vKvTevlpoq4EGgX4/AdDRMkT7pcEasklbXsNiwh?=
 =?us-ascii?Q?YAGDk+v9vhrTjDUhVbyZti1hZv/DNQFj4HRAt2PDfKbCQYBveLOTfsB4wKhx?=
 =?us-ascii?Q?UZwyLgB+4toF61Z05injOdcESmkiutxfa2QXi1x8bWtQHkfPrO+LtpjQ2TxU?=
 =?us-ascii?Q?PNPaU93zQviJEe/e5NQxlDyKR+ZC4vQOe9K5nOdQCJ+0hJYvd0mpQP1eu1s5?=
 =?us-ascii?Q?/YdNGfA1z+pVCNGQs+GyI1hqo31DQQrRGcBMc9At9h+GlcUUXpSFDQzVHuw9?=
 =?us-ascii?Q?MyhZhp6rd7iGhnbiaD7T+DXT9slRvowSBUvOEfGVaCtgoKSRRtCYyUokrzt2?=
 =?us-ascii?Q?uXdJ77KDPNtZyM39l6d0HOWxUEY34NZ14D5fVPjuLzOg57QmsCj9j9+tJOIB?=
 =?us-ascii?Q?ZspDsqY1sQuhQaCn+eJ2F6kzgmMrYufBcM3imVbt8qDx1MEan5iZ/wWeVVMG?=
 =?us-ascii?Q?VpFSJbHxNdUnQ9miDxGWTmRvft0HLsxCe5bCe1z1ie2aSUEFPQijWiOZx3UW?=
 =?us-ascii?Q?MqucaYh2XKHjuXP2jpVTOhcdTW1N4cODVom15tRiO7QL51nZDNoEsx+R4NfK?=
 =?us-ascii?Q?Jmq/p9uOLTVfvmHZoyyvWs5eZtTTFRPmE8SiAKZPyjJ/jOWU6cNWrACQWgCu?=
 =?us-ascii?Q?9+3IGetbWoIBQLHJvqd+MVUlH5SR13hwpo5shQqvTIKIWP5bt02G7O/9S1t6?=
 =?us-ascii?Q?nMh1hxFftW8+O/hGeLYKx62uE1OIYCh6jIx9XiA5iK+0K+LUNBe8JRTxhSZY?=
 =?us-ascii?Q?zyeFYQ++luHMLwMUarrPGQMQhomseegyQ0rQqWzUXjbXwh/b+WLraEpYpXUe?=
 =?us-ascii?Q?Ur4yfkv8JKmZYvZgvC4B5cBUdsFjNYndYrUhJWiqL27ECfbzrOgwt39HYOCF?=
 =?us-ascii?Q?yVkF0w7BgelI1uKwKpkrc+WiuYI+6hxR2TBdtF7gxQJkoElkoOHXpixEeWGq?=
 =?us-ascii?Q?vaP98d2u0HxXL9RhspSNijc8l1m1vkX3VKEKVFf7dIfOW7E/HT8F0Ejf+HIB?=
 =?us-ascii?Q?7wflAUlIcOYqcXW2V00R1JG4yf88rpBJxywDkVCWGaMvT+3PAPJZuyck4SWJ?=
 =?us-ascii?Q?gfW64ugyLbC5AX/55LCTVI1tZRicdW5y7eePO5its6nNr81b+x8nZ1TuPVQU?=
 =?us-ascii?Q?Fe6z/GMcggEc8JNTt/alWCK1oBxZepR4hnys2/W/Wyu44lvWAeTjzhDqsKKZ?=
 =?us-ascii?Q?+dwfqC/6prk8O0w4FQSdHqD2i8mY1/nd+erPs+RGsNUAWA0EMtue+wwY60mR?=
 =?us-ascii?Q?nYC8xU37RfMp3AWGjymKEO/462gTfE3WsvZ82ahB3UjuM0w57ioUd8ywvLDP?=
 =?us-ascii?Q?PXpxeiLYaY3giiGA+HHD3w2NrOB0CkWbUyvd4OH1NkvM0Z9a/vw2TC7d8rV2?=
 =?us-ascii?Q?JdIFY/SGzEsx+DJ88vPIYr88sOGkZwBYZ+FCgp6UCRa7Gi9VSOsdWXR5sUF7?=
 =?us-ascii?Q?pYWA29O2m9DKvCxTG6xQgMafq0pDD+HfxC2f+vNnLg5Bm6vm81v0kIPgZRSy?=
 =?us-ascii?Q?BZ4GEk8xofIdsmcMf10xVMyFoRYOn+532PBJnTCx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24afaac4-0a71-4682-d1b0-08dca572b568
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:38:46.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ut+0lFKKHMt/YidCyZPw2++fWGiYefJrSw+mmzx9setqW1xaZBzFq+dPt3yBk8iVnHz/P1TfYYjmomBzIOzuVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR06MB7324

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

This is a classic ABBA deadlock. To fix the deadlock, make sure we don't
try to acquire disk->open_mutex after freezing the queue.

Signed-off-by: Yang Yang <yang.yang@vivo.com>
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

