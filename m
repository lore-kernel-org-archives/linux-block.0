Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazon11010001.outbound.protection.outlook.com [52.101.133.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326F801;
	Fri, 17 May 2024 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715909501; cv=fail; b=PUJCu0Ij6iS/zG3swRgnZUs0m4N3RSrZjR2JSa5Po5BzKAEomNM3fJi4d/S6JRj/0JwPvwYwIALJbxCLARBbLsen/1HeZ9rAYNhdVXqshBHjRQA27DNAGcANcyGjF07Y6jF7TJjCaMJMUOJLK4aDCc4M3gvqv6kqMsfKW7E/4tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715909501; c=relaxed/simple;
	bh=Ui1cdJidKqNmbK4IdycvbBmovTyH2Pj7wAK/I+ow+50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GgRjGCd1ryILCGpsuogpZUhHJDXgS3FeZRvLEhcnhmdTIUOvgPgNYwOof8/xQKYB8aemSEM+BGgY6P2ZkUsgq/ugc7uPWduX/rLiM36MOiMDQTZIQ0RNY71S0gK9MhS80m3lzIaEnA0GlX/V6La1yDVh/wuMPr2k1fMvW0cbzaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=C6o/YfM9; arc=fail smtp.client-ip=52.101.133.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="C6o/YfM9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyj+0/U/ioBrcetEWojRsAnvlk7FqOM6lFy52nMzut6dKRrY/tDF+eiFXij0ezXMzj8hCbvW+vaVi1o4O0Ta9izpkrNLuNxxHq9qHPQScWNsqSAM+5VGHT5CT+V1FIkF5x8man+LoXES1pUyCr116JoH1zR4IZHzr2abpM8gHD8s7K9nZWHIC7OkG4DwMOR3NDrQmf7/PU1c532WmdJ+WJJHizmMdbTmzaA0kRZ4+68UswVUy9HoL6uXUJh2BWJ3yaFdc0+tMuTyrezu6FYX0L8LUIKJBK67RuoQPpiIG6L6XhpNXATejHDlwUPkRCZ72ZRCCwt69997PVPx7TdR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrI2jW+ifdAuRb5rTx+K25EalWb8H/o2qA/bZbVye0s=;
 b=MPP22y1xipthtodTQzBnu5aO1idaxa/JLJtrLB4h3X2jRwUs+jgWlbnjQia21V11avm48vb/34Nyl7lX/bg0kR9V8zX8LGMwcibSd8sIaHKiLZQPoDqaTwesyN9L++GX2aRoIhPTZeIaSF7dqN312NiBmAHSi5E+rd8aYK9gadqigsbgXNe3ple78nJMV6e8dO9AKxmZhAAeoFIJb4ehH82Ua7dwCeWxvAbksf8PBtpYjj8l7s6wS3PqbW104qes+YWjkPaeGcES3LCpvhiUas3YC9tu85tFFYFGPhBBEGUESW67MHnpIeRVV2mdNrNeYVCrLUzpEWzPPFFDxDnNaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrI2jW+ifdAuRb5rTx+K25EalWb8H/o2qA/bZbVye0s=;
 b=C6o/YfM9fvVPEYFnu7gSgiq8xr99UXvJQAYdEc1vKhvOu/p3qhTH8SbzZDi1NuG6RgcNJUULRK2BaxZaBuZ2dipt1Hh3ojhiWoOJZsN7qBvEfrK2b+gQafWuGcBB7jsa9L6vb65dmzarLknPxIyc38Onhvf3YFjc8VJq9lEEJNLvAGDzclBdHpF0dZ1/Vl/cqCClo9ywzs6RVV0I+aLG/wz9ZheSkWS+MCTb/GbXK5edbv9vetGuEKFsNHNHWiwiJCwrfv8zk5tqXTC8U5InO7/kfeD3KjE0VhyXimIY2Yw1CiINxnq0QIS9r3VBY4UJq35N1r+bnYvLkP+ox40xJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by KL1PR06MB6845.apcprd06.prod.outlook.com (2603:1096:820:10d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 01:31:34 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%5]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 01:31:33 +0000
From: Wu Bo <bo.wu@vivo.com>
To: bvanassche@acm.org
Cc: axboe@kernel.dk,
	bo.wu@vivo.com,
	dlemoal@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	wubo.oduw@gmail.com
Subject: Re: [PATCH stable] block/mq-deadline: fix different priority request on the same zone
Date: Thu, 16 May 2024 19:44:56 -0600
Message-Id: <20240517014456.1919588-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a1c24153-007c-4510-9cb3-bc207e9a75e8@acm.org>
References: <a1c24153-007c-4510-9cb3-bc207e9a75e8@acm.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|KL1PR06MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 118a9b20-ad21-43f8-b4e9-08dc761115af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ASv1C4FYHJ+F+W+Il+nhTEwY2nqMXpnQjIbTIFv0RQNiYt7iaTbUDlexnOWp?=
 =?us-ascii?Q?IA1N9zy6N8HAGrDnSmBREzlVMy9kWn55jMFEA+t0qhBXHksrIVLtJA3lLrDJ?=
 =?us-ascii?Q?Fp36MtxzGhWOibvsj6SID/Ne7YifTsd+Amx4P3gyEnOp+zvwwS2LwrcjAAfB?=
 =?us-ascii?Q?AJ0TJNjVn9ZqEGBUPd/9ooFP5oBDGSYOCp3rwp6HMwXH/ajWRgABdre0x34Y?=
 =?us-ascii?Q?X4IcCCZAokK7K9Ygy+XDdfyGt3eNf0dDbfjDFc/1TEXo5rO2rcLLzihWgv68?=
 =?us-ascii?Q?Ka5GTE0VJFPlpuhgMc6RIdloj+vpYDvnd0eaq/NgF1wQqDtElaY2+zxaUfrh?=
 =?us-ascii?Q?ck8Ge6kNo4IxFkugrrmXmYcS7VstqGqs5MTLSyx0VtDe6HPCP/YrsrVgkAwr?=
 =?us-ascii?Q?XoR8QHK+v5c7zFxisXbp05G6JnQ8hj+BXYOQtvi4VSY5+baNllkWuOml/AOP?=
 =?us-ascii?Q?vMz4G3Mu73EM/4uypx6Kc67/V/vojdTOoL9TXWzKtQvaC0KtYkc7IJfjIgIG?=
 =?us-ascii?Q?kTWFTEqN7eOipNf39UbyJma6zfsUHdlDkN+vavzhFJWNjKfMIrDKb4AXL8bm?=
 =?us-ascii?Q?rx+FU0LAthQELskoNFdCNxERh0aGzeJgBZBx6s37gvkhxXcLoguX3pbuGzx5?=
 =?us-ascii?Q?cRZwK6sF8XgXzwsl4KQORnZ9TxAa1FHXOEPXWrqDWeRDT/2MNwws1Ur/BoNH?=
 =?us-ascii?Q?BX14sm+pmVL6gIcUDhi/fq+MTQdRiQqjw2vMik9vclyKVBCqO7viRCmQGJYM?=
 =?us-ascii?Q?lHV9c82etgi6hA60YXm3CbxI7xNyyuhVzPpjU4fWLQaPSy6xuWXf4MSxyccv?=
 =?us-ascii?Q?Ucp7IryC0cnT64VZyYbmLpSfVeSIGtsKiVISc0wA4UlVe6NPDan8D07flIwq?=
 =?us-ascii?Q?Et+Ov8rZ53NUzXcLktBQJbPBngGSJkW0w3Y3bet5r5zwHQh6GV/iXs0oboWl?=
 =?us-ascii?Q?bFWeHKqz18fGvEzermW6T0RLs4CD9tWILTH8f8SM9yqqjty5YkKU+VNRdziS?=
 =?us-ascii?Q?35l22r7VcrWFO1MRssHAhEoiBPi3YE2c5ODZB6ip1jVYM0XghbK/xZ/p5zkv?=
 =?us-ascii?Q?smjlsBPUYyTFJ3nQ3rsCcqJRoTchq+8tJKzLKTG1U8L20zEdWC849Dlz7pAz?=
 =?us-ascii?Q?806QkpTnLpJMi4mS4E0SR5q78ATpfgYiebU+AKW0vEvBQXyojwnPVTQnTmEY?=
 =?us-ascii?Q?pHoljV7pwDFIYEYNA12tjMIllTwbl0Ax1H4tKofaTAF8tAKLL+j90Jq3w4bZ?=
 =?us-ascii?Q?U/LbcLpXyNbFa+FFytY+/WXf3zhdQG1SthqQuzO2PQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EwEILxXHJonrp0RTJOwkGgzWApvJMyRnWccc5xm6rnwZTDCJG0Z2+HpK29ZR?=
 =?us-ascii?Q?b35HNVwxCViW9BI28+GgPwkCwDa+BkGRraRKjZpc8EzlHHCuqdiwihtU+aY8?=
 =?us-ascii?Q?IpelO8PGNYwIhxXqnGpBCCC6CKmnsWBwJpeVHU7zMeb4RxX675LXxLu159RK?=
 =?us-ascii?Q?5S0+dkLegTnm2gSMREGzm93/TDM7WdLu9gbUW8+r0ISHrdvX5nMYUTIyl9iw?=
 =?us-ascii?Q?HgkokVpnCEQSW9+y1fwXxW5sC6vZpgKg+BL++ffH0WIyCE/lcc+MXACl6hrL?=
 =?us-ascii?Q?1DK+/xMXxgfWH1KiVfV4fdTOVocSF9RSqu6kce8HG7oRKHz0bjURgeXnGtml?=
 =?us-ascii?Q?8QyQy+4zmn62LhaKTtUPoNMIExY9h8r2haBnTbEwRaeXh70hl2Uoj75fHfTb?=
 =?us-ascii?Q?5dw2hGzXl8xAR2gRf4YHi0sxCfotTMiWlfd7AJ8wEc5lgUD/B2zNyOWUEu2F?=
 =?us-ascii?Q?tTqNIfqqNAlz0fY9XdLXbis27E4esBK7oTySRj91LDU/WcpnK9AuqBT7jI4V?=
 =?us-ascii?Q?lNwTwR7C6tOErKivPsz/txLLBM1OnLCHZF0s4X+e7boPm1Jav/wZu+jOeqlO?=
 =?us-ascii?Q?GEHL9s/NOhBRNa2DWv3m2Ry++56TfjZv3vWIGZcwSe9PCQJyjfJnhmwaXzq4?=
 =?us-ascii?Q?NCkHZREk0V2DyGEr4L7uSlYYdAfeplnr2UzdcjjJoqgYPAaeLDW1+60F7vv6?=
 =?us-ascii?Q?f2hlsU6IN5sousK3LtO9Gy6dK/1ojZfpb07luH3N5v78GQR2lxmSVia22Ztp?=
 =?us-ascii?Q?lPlmIuQt53Gxwq2eZIQVfpXdeYQSMmjvSY2DbI5VUSzTqnnm1/JEJqpLDctT?=
 =?us-ascii?Q?cXOTctvOtI0lUaG9KoIU+XyQBgX9TZgnHHZ6MFCtYHvOsQvv22EOxc9Te+k8?=
 =?us-ascii?Q?kb+F4mrSXaJ+kowcgSSwMAdfHDkjquBQ3sxqHNfRKvzQqsgnBrK6cHOyfrvl?=
 =?us-ascii?Q?SQTg+EZ6Zxa+Zq7TUY9pqmDpqMlMMyhhh/NWW7zviX4+OVVNyOcNKX8Htbbs?=
 =?us-ascii?Q?v+nZXvvbmuduAeSukQ4cttCYEADIVO22AZ3dT85AvBHH7RXW/m0JkAQy99pm?=
 =?us-ascii?Q?ERB4e5bTG+tFX60yhmaMmxLqkBX1Gdv9Tu0IJm+EugguUiXPkmU4V61ybO7T?=
 =?us-ascii?Q?FBcoDtiaHwQruZW+Wdpc3ap+0bRokS3AqLP/InsuqMqHc2opNYsDU+Oi2vWB?=
 =?us-ascii?Q?s738FAQahwiAlgXOhwLuCAhb5EQYjEuLLT2JPXdNboOAmjbx1Aat37bBCuei?=
 =?us-ascii?Q?kvg8e8At4+xLTKKLCWyzmAtG8eTZYxRFRufwWicYbSet3a9SSoWTuqqv1G03?=
 =?us-ascii?Q?jiXxFOO7qXuKaJRYCFzrKARs1vvCOCnva8sWBfy4JrHld59GWqCXQRZMM4Au?=
 =?us-ascii?Q?EpxsEeMrOUrFOAI17kJulbNHXgS5m+9YaYRVGtoKy7JeM2hLUWyeGDNLgCGV?=
 =?us-ascii?Q?5rki4ETjP/+o/hyX1xlStko1BN5GauLGa1pG6wFLQ/EI7PCe+4qw+dUDHKsh?=
 =?us-ascii?Q?0f/XLgUvo+fLSUl8o85n+n+Wyz1ytTLDYWjMqBVWNqK+JY8jsM/Og7Dr7Xq3?=
 =?us-ascii?Q?zbQprhU1QHXfhTrTYld6A9YFiBmPDSMbABc8CY99?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118a9b20-ad21-43f8-b4e9-08dc761115af
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 01:31:33.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSy/eAgYrqGTY2CHidQnA7/s0RRVqoIJItyqMpx+Y3NSbq2yBxKHgYvdimHU0A+xYFXKFZRu0U5LErWz/p5Cmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6845

On Thu, May 16, 2024 at 07:45:21AM -0600, Bart Van Assche wrote:
> On 5/16/24 03:28, Wu Bo wrote:
> > Zoned devices request sequential writing on the same zone. That means
> > if 2 requests on the saem zone, the lower pos request need to dispatch
> > to device first.
> > While different priority has it's own tree & list, request with high
> > priority will be disptch first.
> > So if requestA & requestB are on the same zone. RequestA is BE and pos
> > is X+0. ReqeustB is RT and pos is X+1. RequestB will be disptched before
> > requestA, which got an ERROR from zoned device.
> > 
> > This is found in a practice scenario when using F2FS on zoned device.
> > And it is very easy to reproduce:
> > 1. Use fsstress to run 8 test processes
> > 2. Use ionice to change 4/8 processes to RT priority
> 
> Hi Wu,
> 
> I agree that there is a problem related to the interaction of I/O
> priority and zoned storage. A solution with a lower runtime overhead
> is available here:
> https://lore.kernel.org/linux-block/20231218211342.2179689-1-bvanassche@acm.org/T/#me97b088c535278fe3d1dc5846b388ed58aa53f46
Hi Bart,

I have tried to set all seq write requests the same priority:

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6a05dd86e8ca..b560846c63cb 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -841,7 +841,10 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx,
struct request *rq,
         */
	         blk_req_zone_write_unlock(rq);

		 -       prio = ioprio_class_to_prio[ioprio_class];
		 +       if (blk_rq_is_seq_zoned_write(rq))
		 +               prio = DD_BE_PRIO;
		 +       else
		 +               prio = ioprio_class_to_prio[ioprio_class];
		         per_prio = &dd->per_prio[prio];
			         if (!rq->elv.priv[0]) {
				                 per_prio->stats.inserted++;

I think this is the same effect as the patch you mentioned here. Unfortunatelly,
this fix causes another issue.
As all write requests are set to the same priority while read requests still
have different priotities. This makes f2fs prone to hung when under stress test:

[129412.105440][T1100129] vkhungtaskd: INFO: task "f2fs_ckpt-254:5":769 blocked for more than 193 seconds.
[129412.106629][T1100129] vkhungtaskd:       6.1.25-android14-11-maybe-dirty #1
[129412.107624][T1100129] vkhungtaskd: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[129412.108873][T1100129] vkhungtaskd: task:f2fs_ckpt-254:5 state:D stack:10496 pid:769   ppid:2      flags:0x00000408
[129412.110194][T1100129] vkhungtaskd: Call trace:
[129412.110769][T1100129] vkhungtaskd:  __switch_to+0x174/0x338
[129412.111566][T1100129] vkhungtaskd:  __schedule+0x604/0x9e4
[129412.112275][T1100129] vkhungtaskd:  schedule+0x7c/0xe8
[129412.112938][T1100129] vkhungtaskd:  rwsem_down_write_slowpath+0x4cc/0xf98
[129412.113813][T1100129] vkhungtaskd:  down_write+0x38/0x40
[129412.114500][T1100129] vkhungtaskd:  __write_checkpoint_sync+0x8c/0x11c
[129412.115409][T1100129] vkhungtaskd:  __checkpoint_and_complete_reqs+0x54/0x1dc
[129412.116323][T1100129] vkhungtaskd:  issue_checkpoint_thread+0x8c/0xec
[129412.117148][T1100129] vkhungtaskd:  kthread+0x110/0x224
[129412.117826][T1100129] vkhungtaskd:  ret_from_fork+0x10/0x20
[129412.484027][T1700129] vkhungtaskd: task:f2fs_gc-254:55  state:D stack:10832 pid:771   ppid:2      flags:0x00000408
[129412.485337][T1700129] vkhungtaskd: Call trace:
[129412.485906][T1700129] vkhungtaskd:  __switch_to+0x174/0x338
[129412.486618][T1700129] vkhungtaskd:  __schedule+0x604/0x9e4
[129412.487327][T1700129] vkhungtaskd:  schedule+0x7c/0xe8
[129412.487985][T1700129] vkhungtaskd:  io_schedule+0x38/0xc4
[129412.488675][T1700129] vkhungtaskd:  folio_wait_bit_common+0x3d8/0x4f8
[129412.489496][T1700129] vkhungtaskd:  __folio_lock+0x1c/0x2c
[129412.490196][T1700129] vkhungtaskd:  __folio_lock_io+0x24/0x44
[129412.490936][T1700129] vkhungtaskd:  __filemap_get_folio+0x190/0x400
[129412.491736][T1700129] vkhungtaskd:  pagecache_get_page+0x1c/0x5c
[129412.492501][T1700129] vkhungtaskd:  f2fs_wait_on_block_writeback+0x60/0xf8
[129412.493376][T1700129] vkhungtaskd:  do_garbage_collect+0x1100/0x223c
[129412.494185][T1700129] vkhungtaskd:  f2fs_gc+0x284/0x778
[129412.494858][T1700129] vkhungtaskd:  gc_thread_func+0x304/0x838
[129412.495603][T1700129] vkhungtaskd:  kthread+0x110/0x224
[129412.496271][T1700129] vkhungtaskd:  ret_from_fork+0x10/0x20

I think because f2fs is a CoW filesystem. Some threads holding lock need much
reading & writing at the same time. Different reading & writing priority of this
thread makes this process very long. And other FS operations will be blocked.

So I figured this solution to fix this priority issue on zoned device. It sure
raises the overhead but can do fix it.

Thanks,
Wu Bo
> 
> Are you OK with that alternative solution?
> 
> Thanks,
> 
> Bart.
