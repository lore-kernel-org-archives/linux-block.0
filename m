Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2087.outbound.protection.outlook.com [40.107.117.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D737D07D;
	Wed, 24 Jul 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804682; cv=fail; b=MJo6yQakNvITn5EQQk6MkcPnknN8iDhXCK3dgMO9FonEsQXVcunAdngWchMx1fA55tUvRHya/0+gkYUGcbHVj3pJRRqPD+MaeZmnISu8OTKdXecvxAmOq5fwvp6MJ0Tl6Xg+1LSxTnoEUE2hInh1dsCEe5q4wCdRgvAZoJ6Dtz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804682; c=relaxed/simple;
	bh=tO7WtbNmuRMQto9gWS7cD6fTpUbfeqJk2w+7vkyX9xs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mnpLDrMeJ87fnC2fe/iN4qUdsE7dkN0/b7FJa6YspRc+geNw5fTWdvF7cCpZNaa7OHsyMwE3E8/WbDNAVUM2KDPiSzeINdPELZLUWwxvB8O9GcafqXSHvbHwHKHFVMmfHCysUjWavsgdn0Za6wKWdUbZh/HzlcSmuF1GDDKmvDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kLrxML4V; arc=fail smtp.client-ip=40.107.117.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kLrxML4V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCXNI4pyZUqpHL7HdirPhQiPFjxSoyDzFnhiT5U63pKBezZPVJljEia5GLlibz5VDi9f9J0Wv013Dbtsy8CrZfMlQuJf9age9D7AqHGnnavdhiQDWlMON3BfWKdyBlq/Mv5kpcAvl1FtbtoYH6oK7nfVK3xri7ZsJhqM890eXKdYC4knQiHrbTtVpcFPs2m/AE93cJnzF0wv5l6vkO/cVLpYOLaUEzozuXjj1EkqCdcRdka3Sv1zqjpyry2shPb8CnF2YIJc4tibBLstMb1nwvT5EM+8KHiOuHVuZtYMPUSTD4sUA1dDfl/V+9OJPNBhArKZIoKfHY3Pmyy2L8VvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUfEurIOKZy4ZZZ/GWfAdDAhZEyytZ29YUBLT+phZgk=;
 b=pKhr8mJyF2b0q+wbvwxWs7byljyIqv5LJtoZtU/mImvx6ri5bmaiSEs4gqj166Hu/NIBahvZuu8LgNQXksBibyOhJBqfD05gGPHhvZOUDqwJq4OLkgawCn92Y7YvgIi9ptEL7nPnc6jhGCMBp5h9bLh+xSGqERjZCwWTBYjGef3XFRmitt//oznv5pSjKHwPCPos1hWcFsatzbeRKfBZx1Gvua/uxyyYNTRMuICtq5r4s4PkuyLXtL9m0v/6YRx1SUha2YKtDelxrt7ZT20bGq6guEufnkebzKQMAL/VVHKe1U2cTa7F8cLFJcRjf4+dSENImkh7hc9FP1JMAAwDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUfEurIOKZy4ZZZ/GWfAdDAhZEyytZ29YUBLT+phZgk=;
 b=kLrxML4V6BhyAQ+EMns0UrvSOBVrVgdwCwiC14s6q6riy5WL4P4cX3AexCjUbEFqLKArXzH/eAAi045aS3dlVEL25zY/8Ugo7TlOqJcAr/aPn5OkwhkdYWk5tU44QrDcjZy5XtU4ZkGnr7VUS6FQ1Sk6YpORvXVXrAPnAyz3c6CU17G2ds88L1+HeRp1Trqi/pZ++P1cwW4T6R7WqPx0brL9pFiiRSg4v7CKsePk8uyDdqx3VLMpacqgygLp4mLBfntPfBTBiD20ChaL2coJdd3k+/S9E9cVeIjTnKZHWi84EbfB4cCSMLjOU2h8UVDB6vK5h+/Jbsczcse/sak7sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TY0PR06MB5030.apcprd06.prod.outlook.com (2603:1096:400:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 07:04:35 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%3]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 07:04:34 +0000
From: Yang Yang <yang.yang@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <dchinner@redhat.com>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yang Yang <yang.yang@vivo.com>,
	stable@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3] block: fix deadlock between sd_remove & sd_release
Date: Wed, 24 Jul 2024 15:04:12 +0800
Message-Id: <20240724070412.22521-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0201.jpnprd01.prod.outlook.com (2603:1096:403::31)
 To KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TY0PR06MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: 225c5c75-2955-4bf8-d00b-08dcabaedfb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8CO/H1dtu0qwpP2a0RH8cqZD3nRdXvHo+8j2godsfiHUKkeVPUPw5NPIDRX5?=
 =?us-ascii?Q?KKtmTpE8R3U6/wNjQNCOvJaQt4Y/0q3Z1FzbdpndeDyN6ukdMCqtY9N0U2Hn?=
 =?us-ascii?Q?4N4DCalflpF+38JXDKe682Do5b7llps5WW5q4qqt7PTn8qpB3Fw92LvtYPhC?=
 =?us-ascii?Q?afQ+z3CVgMxuin1uowGbUy1y9PYWIj4gnDTN5/3kJ+TaHaHjhBXANRVMQrFM?=
 =?us-ascii?Q?5zJ25rp9XJk+g2pxMt5siyMBa4YqFjBMRwOm5VSh7aOQi+E9iORrVNUxzRhJ?=
 =?us-ascii?Q?qw3Bq35luSEQp7DghdBRb1Gv2/f8ofTqCzqggOiDeEcRQc+aVEvJDP9Ym9Pn?=
 =?us-ascii?Q?9u5IyaUjb71ve9eN8OqIrJjWcKkhvMAq9aMbOejGJDKkLwJl1b163Z/8/bwJ?=
 =?us-ascii?Q?nzKi3rFUeWDFyvt5eEqGgrd+D7dxCcpOX2mIRP2HDiHPJcuqc/rFudwYP/q/?=
 =?us-ascii?Q?AT7QNirrxGg4IFApKzhQjeTiuj2U0ycWkLF30nOQd6kCe80onGWODn2MHNdG?=
 =?us-ascii?Q?Nbdim8Gnz2rysT8OSfI6920Us4EAkW0kfWbi57dKZeNnEYHuec4g5UFpnWny?=
 =?us-ascii?Q?WZCDsSe5tp/ifrDz01ZnrV9VtiBzR5LaPW8UJi9hFI0FIKhH3oAlQT83WcI8?=
 =?us-ascii?Q?aW3eTleHXssJuxXqy+WeF7LyzOvUGB6dxVoDPPYwE+zLnaIthDDVZvRuSOjE?=
 =?us-ascii?Q?MueXeO+4tftwdfuJZhPP2AeUbHAdW18PlTKLT4wgaxlmLFiqtsRnMneZTpCr?=
 =?us-ascii?Q?QNtum9UY9W7GYb9KDmbTvztkk/XE9oOTdwZ+mbScOMrs/jGEUhDCehORfqhd?=
 =?us-ascii?Q?q055IW6xS54VoZYB/YDQ0p2bIxRleNqcaP8VTZBJe39/uj07rHIcykF/3rRR?=
 =?us-ascii?Q?8FrXPNdHx1Yo1E3THJZ6WgaKFE1rbAm59to6iTShDctE3c96//CECHUFKq2O?=
 =?us-ascii?Q?MxrOkmEquYDNBXgXgMkRPUCV0u7c4V7klNM8gNf0yHRcPDgE6o1k43rTQnIa?=
 =?us-ascii?Q?TtmThODO6B0AiSsuTRhaj7K/hbayCSdUdA8wgT3mOJLuZhbc1o0EJMBFHKvV?=
 =?us-ascii?Q?K1DPIJzyT2tABLVW4c4pTVUZiPbjoKB/gaAaAPYrA3iukljXovly8PTrMNHU?=
 =?us-ascii?Q?IPDqFm1tK6zaUtGLXvRn0TthD2Cfy+XYBLNG5yHmF7JYDs+E6Mm+XZeWzsC/?=
 =?us-ascii?Q?C3f+uXe/UpEgVC/3T91wfs0twiW3Ei9kuShj3j/BjqDQZRa2E+7kGGNvreP0?=
 =?us-ascii?Q?+YknCPtQLdTO+zwkfPzgqpX0dIxt+PkT2rINZdH941SDUDxBNKIsz5fJ8Jym?=
 =?us-ascii?Q?LDNSYrAyqLQCSSHrVeVeEPdlKriU3huiTkYizZU8UMcWqIhhuHDLw+x5kD56?=
 =?us-ascii?Q?6z4D0hj5otxsnltUCII3Ypn5PQGvci1uABEIRM95VGSrlG5QzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+sRVzRA+zIVqfJ/nZ9g5pCYDFIxhkcBbxwIVo7tbdbpONfBueDZDKl0HYW3D?=
 =?us-ascii?Q?sSjEwnsmX01m9rZMbl46GDGSXHXEkQkchgjkoLasQA4+nTXQYuRNnqPg6REA?=
 =?us-ascii?Q?pwTwPQNAsiYt7Y9iZJj8zm5yHOsAL/6J8m+MCZm5xHhatU9a9zEq4lXNe0Fd?=
 =?us-ascii?Q?jf4hYNGuG/7cxA7nFc9tmTM0qqVscmHXfHAyk5Wn9vbpEpKbvbWUTrZVhb3C?=
 =?us-ascii?Q?TnhrKI8dgRkVYJx8xYlxoLPR+Zc8dMb8KbyGPeBIWKmp28vvKaGuqnjmKMV7?=
 =?us-ascii?Q?4QIV/3lI1GrUYw+X0Ub3HJc3OUpPL5p45aEpwtd80dhoODgENhHYrLKrvBIe?=
 =?us-ascii?Q?er61GL+oO/1dlP0gF7AsIwOi5cr5ZA2CQH8B9TYlNPTzb6FQk8vItkbKwvO2?=
 =?us-ascii?Q?unq6iIHOjrTMLXMBEY9TZJEfBi13ZmJXp5h8+d5pNVPmUwyYf/yq8ZBN8ghu?=
 =?us-ascii?Q?Z26UdAHCH878rdrCBlEwzXNraTOByZ3m3IpIxsfH2J7uKfUeyVbbdm+1Evqm?=
 =?us-ascii?Q?wN/uVkZZYdhGosjSzjj5uIofGibuAss/7D3wrJNTdKY/ro4ZCbfgYlKAqHJo?=
 =?us-ascii?Q?vEbGruJDK2Oarn+OoJ0vCsI4idIoQH70OwZj/xm3i3FyXR76bvgerGOQ54+V?=
 =?us-ascii?Q?gynuVX0W0lXahMaVq6stBJkPbcpcbYGCwWBuMKZ9vBkRCz7cKVqxlZA5m/Oi?=
 =?us-ascii?Q?HUkPnYp18dT6ph7+3BIeXbVDy1E1lh9OvQ26LFY83T/XyBIDkfzPkIDgoXRJ?=
 =?us-ascii?Q?TD6ehVsTPe4A9BrD8a08isaqM4o/J1sItvlBUaj/0JahaNdOiioUzgmfvdcG?=
 =?us-ascii?Q?Ym/JPkmEl6NdTrRX2vEc+8swBEVGo5zqReb8YWhYSwtWjsaUhJ4LFgluvVBY?=
 =?us-ascii?Q?7ima+IohWNu1GOcNg64JdWDPyk+CkvypyL5EWkz4uyFvvXD4Fg1oGt+RoAaN?=
 =?us-ascii?Q?3GJAJclHtJwCwgzKxr4xnjynd7tZpWbeYmZNisyc03ML5hdzfNkjfS9gksxN?=
 =?us-ascii?Q?ypG+trFiaAPn+Y5Bty11RVP9Rwyzsf5D+fZ+Ykq9xXB3IfsMagp2Wv/BzWbm?=
 =?us-ascii?Q?7k8MPAhCRprAuYFBB3klWo310z42bXZOt+H9CHhNoINEgexakchxmHZsQVuM?=
 =?us-ascii?Q?pCaIq0hyOftzSt7SHT34oTA/2licNIjdulY8RE8l43BCkhGPfwnbIAoujMa0?=
 =?us-ascii?Q?bPmSwvCdeapvaecRmKrFnT1Y2TRFStSCItbVx9ub39QtxcEsyNwLxKsjTHSK?=
 =?us-ascii?Q?45nLVe08v5TweDM90QHaI/rmfJo/cGwVyrO7Pi1oog7DfM48UNe5yMvIN77C?=
 =?us-ascii?Q?vXdOUt2uCEUZ9NjxJGu0ziHe0hdZ+0TbWbip31/z1C+lJt10k1wuEPZV5nt5?=
 =?us-ascii?Q?BzF2r4iZEmuUWQr98kaiviWZtYXGTa2TYz6KiFMY6l6p8KnyTQD3fL0GaKE2?=
 =?us-ascii?Q?0RkAQ08DmxM4BPNJjLQZkGqDdB1h9Yz+3rn/Q1e9BMBOUseWbI5WQiZzpGyK?=
 =?us-ascii?Q?+73eYUmsxHeHwFqkxD8dEesG8Ik0TsHZHlR51GZJJgXDrd5BDHYMxCV8st+a?=
 =?us-ascii?Q?8hJHRFadgwuK5Fg/Ds+DYGKou2nNtHgsj+YS3P85?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225c5c75-2955-4bf8-d00b-08dcabaedfb8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 07:04:34.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuq0MocLxvrl7KYmUuWFfo1j4XyL6AE1pjwPg+i60VfTK7XhpEelhTNwW0dSwsmrUocf1oYBTV0JgpjF/oSn0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5030

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

Cc: stable@vger.kernel.org
Fixes: eec1be4c30df ("block: delete partitions later in del_gendisk")
Signed-off-by: Yang Yang <yang.yang@vivo.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

---
Changes from v2:
  - Add Fixes: and Cc: stable by suggestion
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

