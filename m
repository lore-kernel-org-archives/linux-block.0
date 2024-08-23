Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2040.outbound.protection.outlook.com [40.107.117.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6418C187336;
	Fri, 23 Aug 2024 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412181; cv=fail; b=lGzS6bccWTGsolFIMzsbWA1t4t5BnFR97MffR6+1fzET9dTRhr2rCAhNF/3JCqBa0yCfjcfAKjPkp+bDiuFarFO5nL3uUmIXviR1S6UjrjEkNWwUSYw5sw2UmiL4gLS0t2V7I9P3mmUx41kNdUS9fgK7R5Kdu8Z323aytOn82wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412181; c=relaxed/simple;
	bh=cfGkYQCcmNAUc95Nat5pEz7uCWdxmfyhHpMmYoR99vE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AGaylk1hvhD8SAAEkQQzw8+xzzvDdn2fLVT5sNyEPeGPD8JUL6BxzBnaeB+WGsshhQBYNIBrvfNngz8zy0RGke6FaoYU+6mIn43XNwZ7xLVyZkKqnEgDJUd8haOjXE/45jJp+5izxcN09BHKowQp8OSEMAZ5qNtLFy0ftHe1VRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Rtux/xMc; arc=fail smtp.client-ip=40.107.117.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Rtux/xMc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gv2V1vtG36yrchgEYDo4tNEKpYkyuHET2tgkyA6nkL7TgnHbEL5Ix+O/cT25vKwqOyNGB7PJglhOKUFqE241g1TcUKiSepjGTZWiJ4fy03KFOb9VehTqehU+YIlRNGNmhBKi+xsaiDhr3eV6Qk08DAHWt++1QKRskvWgLfNgmCZJJAUxsl+7uYAxFfFpjXfow5/SMpwfNdli+kD8xDK48OjFUwk8PJGQ5ZDj0fUXP5CboHjTGHwhrtK8avTo0Bculy52JHp3acSNO3G2/utwTDE9qjkN0wEeD0X/3uK8ED8znzE+5LSi7BtpwmuMazt3h7Dc6O0g62QG+VjuuWSs0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9hbtM4HCHIb7KJlrzrX4pX+uhXEuibZpTzJt6XFzWI=;
 b=TlgzXZhv836wr5+8nK2csIXGhDLmlwGObZTuPOxRFgpZeYM/71nRXtI4v/Kwj7PL95T4xSgM7pn49h2lyFuItIOQeVpl3LMYGJ0zwSeyGFH8P9D/+U2Qi5re9HGsoa2PSPLTwX1WF1R4oTBUZ0xXWReZ68xCfLfKJHI5XRX/TIV8t8kIZo3zIJkeCgJRxz0Q6gEGGf2BUkOjkn0qdl6te9F0oNP8NMxvKZpiwgp9VpFkWCSElMomYxsTaoP2N9r1bUt3IHxScITOD95vLu1AVygpR+w6GPlWIWD/Yclh9yMfnmCYm5Kmw76hCQPanfJRewTTbnP8hufVFZAb73agOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9hbtM4HCHIb7KJlrzrX4pX+uhXEuibZpTzJt6XFzWI=;
 b=Rtux/xMcdk2xaAEUhsRBFW4k0LSN9CDxR/8UsGjhmbcKlgduz9RIZB07L3Yhj9sV4+LrAg0wO8AGt1tHdLJes7dZvfou4ax3WdzgDgn5iJ/uMXal0hrm0NQeYiY2ASlPrBq2lidA64DNcbgkjUacptro0MGhup6UmPxeec1nkk/ic3V/hKAjAqRJ/yuBiDNkOh2JcusGrmmd7JEy6iHAt1ZFGUEMHFJFVbsrh9qdE0Iv9b4wb37FlZwr74+vYnPxVuNdttAmwRHRHOfPcHXIa7BD0LtZVIm47u39REUs70ZUHQiB/yDVJO1uPMry21/MG13Iz9JuyipXjduIQ/QYYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by KL1PR0601MB5551.apcprd06.prod.outlook.com (2603:1096:820:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 11:22:56 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 11:22:55 +0000
From: Yang Ruibin <11162571@vivo.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v4] drivers:block:Cancel debugfs_create_dir() check
Date: Fri, 23 Aug 2024 19:22:45 +0800
Message-Id: <20240823112246.3905118-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0020.apcprd04.prod.outlook.com
 (2603:1096:404:15::32) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|KL1PR0601MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1efbdc-372f-4685-18af-08dcc365ef32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G/22u/wTQmAzlQ1bV9iLnQrluYx50C14GrbKo9MCrYhm8HPF7WO2h0N/ue/t?=
 =?us-ascii?Q?6miT0Y6ble1VwuR40gMb01Tw/Ru6hz1RnGv3HgBgT2WibeCWmXOCeVJLFpvE?=
 =?us-ascii?Q?yYOwjx1DzfNKLBy3LlBzak0Lk6LZgkCoFP0qGVjXI13byDrWkOX8QOBjDW1j?=
 =?us-ascii?Q?xsIe/y4Rl/cXpq8a8/OlN8GuuI3oYQtB2+V5xQmFbwfiRTVYXiFJURpGf/RL?=
 =?us-ascii?Q?K4zzhEDyQw6bFcr/A5NBAY68R3Dp8LE1iagnwRlbw9Hwi1s6fES4rLVwdp8K?=
 =?us-ascii?Q?br9HVOz1pF4cqPGzD/pCjaau9GPy4yfuXyTww01wYqiTrzSd20yttEf/zPGB?=
 =?us-ascii?Q?cCpjS2RgF2LKU8ArVMaCawP4Ctzy3LG1xu8TuIiDVeOg4BbUX8/zN/oSZIVU?=
 =?us-ascii?Q?GLT5MzqhZwitfa7Smp1+YRFef2wo8/QpWMafRvdgxkQs+ItArSQSKvuW9BZn?=
 =?us-ascii?Q?QkEK/KDWdntEgXhwXzqmCl4/EpWYqromfFRTws/aZolzSSG7gxxdzTS+4YM/?=
 =?us-ascii?Q?j/6dVyKUOY41MTHWdYIe7MYN05f6rmJpOkdMQaE5uFQLtecL4H/fEnDmsEj4?=
 =?us-ascii?Q?uSe4zR5y9vc6pdnxkKkKaZsSgwmdEVQUcnF84p8cx9KWAHSeKOpD/dIbSVvK?=
 =?us-ascii?Q?7KHIjGH/oFDVDBxv70jxBIxR6LMUrmaWhy3mRwqX6IhhzO7EPhPJdEVyyi45?=
 =?us-ascii?Q?KCBqMWp0onkxaC0ia7Tz+PlVetXqncXSx4szdiLFZanh+YTb+GdSTtMs/PMN?=
 =?us-ascii?Q?WI6cOilhzIdE8wXLrBdUz57EYNk/bib1XWpEkxFmuszVvPZWiOOH4O10uwd2?=
 =?us-ascii?Q?mXpuis+o9QjEo/aQfo14cY+vS3cEAz6etcUHHc3pkrA0g9U4hbWhzUfxN1du?=
 =?us-ascii?Q?RwmM7Gg3+jIrWrTKrwI2OFt0QI015+QcrJiP6R1TbVOFX05oRbJy82lE2JZJ?=
 =?us-ascii?Q?K8iqy6vcQcLdjqZ5WM/k0oXK6vcfGv/KTdRzi4tzk0g520N7zb9vMaIA+2cr?=
 =?us-ascii?Q?2KTAu7EACNT4Pzuk9YqRmCMu1v8v4Pr27eULLgZx1KMZBW/PrrCFPz55aMTL?=
 =?us-ascii?Q?Bptlu3MO8ZRTxmT9GtUmGLR3+ZGXdV5JpB4F3NaAc1TAw4RmVT9QMZzdOGKM?=
 =?us-ascii?Q?leDjolhpluWP6/4e5+kyt9TTPhadHRYCdK6VHQmR/yEJAZYFwFitcPr+XFon?=
 =?us-ascii?Q?qFo5qBcAyx7P5uedGkBThk0tPGTS5Vs7cuvfXfgeMy03fB+0WynvFtqfjykl?=
 =?us-ascii?Q?swCrViKkXnE4vAuTPe3dWRxI6Rpu2+dLRbVaFR8qhi/J2rSWska0Znahel8L?=
 =?us-ascii?Q?gGKoInBdSh8CIs4RJrwFzrLcJVoYKlHtJVKpqEASf3dwNSdNsINKqjMR32Pv?=
 =?us-ascii?Q?vx338v8Xibcu5+pWr4MHE1VJgF1CrfNp+34jamFh5SWlXZnqm0Kq/UMOUGRD?=
 =?us-ascii?Q?8f/Jqe4gpPY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xTNL7Le6o4j231x3/8xfStoMjiikOfKXj6UmtBhxWyvgcKT1yksMnym64wvc?=
 =?us-ascii?Q?7IG8rA6ep7Z4bjGtU0N44TR2wzgnp61NxoSroucrfX8Twg9WRjkzcJvdSpHm?=
 =?us-ascii?Q?+JvuSa6JCyob73Xbp+Ym0XDOstxyyQ61k4jiSLKUFWvdxVrrAE5CDQGZiXlC?=
 =?us-ascii?Q?HxTsnFH/a+LOwH8Rkhf6dxDznnE2E2LZ0I3gQIrGeAK3LDPsGAqX015Nvr1Y?=
 =?us-ascii?Q?2MBorNPNzbTk0q/1Cis0m6pX5e6ifdc2AuTwY/s1Z3s24T8XskFGw2iKRdld?=
 =?us-ascii?Q?xPQykXsieRiJK5LrX50YwOkH+3jM5uG/fvtWvFkhNYERIRYbHPiudmVQ0zvC?=
 =?us-ascii?Q?Gqc0Q000xCjSRF2I3L6M5QVtGIujE7ZeenrIKkAEyuRQkKBcC0W0bJM99rCl?=
 =?us-ascii?Q?4e3xb2cPCyl8qxErHe1n+686NYGbVRqkz/xLyhOyt8dZ/jWWg5brvXq4QiOG?=
 =?us-ascii?Q?DwaxuttnhhNBI41Dgw4iNw8f28zMRkhH118jeNRXkDnHaYS3xJRUiGJ2Hle8?=
 =?us-ascii?Q?TsxnFCc71eiKrGUNNELDG0HBHiciQMcnZYnQ8nG22fKvecF4jb3AVNSQBUo/?=
 =?us-ascii?Q?QtbznNll2CK3A5VVT87/0+NHZhzmL61POZ7q68IYws643pbQbxS2a6p6ZX8f?=
 =?us-ascii?Q?kAkvARxVxsVw7vyVbNgK1RjaEn7e9f5+chUwfQyDtSesk3QA+f5zCgnmjkk/?=
 =?us-ascii?Q?uCDF5dARDdZXzrgjv14xSXT+iCGcnrJxamTp91LrTf2WsE7J1tVE/J3wFI8q?=
 =?us-ascii?Q?VGQoILfDEJrtI7JxTXSxCglvXA6if42iOKfzSggL9c9x6+N54vyzr6GI9PwQ?=
 =?us-ascii?Q?ui4MmaUW9Xzy49u1iFY9ibxE0ddlW+gL5NyyGQG+e8kbNW7ficm96DmozptO?=
 =?us-ascii?Q?SDT6wmeqXRD1T9ylCXj1V01WvxlxN7/y/RjoNVUtzGU9jHUcUZzxXpDjqy8w?=
 =?us-ascii?Q?dOx2TyqHNYn2EzydEqY+8NGkwkkGO4UsFJKZ/T66Jb5Fpwtb2cUxpbTzmVC/?=
 =?us-ascii?Q?etAnfK2tqSbYmJE5DdtvsSoREbA7NNGUAuT87ogGB7H0+8HGSepRO96Xbci5?=
 =?us-ascii?Q?0axR4I/UBfZEifLeeqLkppGvuS8/yklWmcZklCyh4JpjJOILPM+LamP0rlVu?=
 =?us-ascii?Q?aOcdeEY33FFyH4Zg9V4lC+i1rE//Y6o6+m1YDCqzolFJrcwxnsOUBXALR/rs?=
 =?us-ascii?Q?X5Q2TmbUYYTmF9dVOXR+7bGib6v57iwmhV5g/VI5n03nYAnmicCq2lGG9k7J?=
 =?us-ascii?Q?dW7eZEzKJjLd6U5H8kvk2I+D1iMPnFXf+wxjR9KLMPF7Y0/LQOufgEIiUGKr?=
 =?us-ascii?Q?m4a3w0XgobKzceI5CGlUU36ReEELeI6cuL0BPAObDiMP9FFT4eUKJONJ6TkQ?=
 =?us-ascii?Q?JYv9FJYKwNF96CzVHqzfhndPcvYFdIjy+Rqyh1w9S/4Pa46xLg60EEFQQBZe?=
 =?us-ascii?Q?O5+dLRGe7PyzeT17PKPFegoekbHHeBwfLwe0BIqn2bn4aWCxCFYnGOsFKk8N?=
 =?us-ascii?Q?XlteNkYInjdizKfbK0zuWxQofaf3FHVz3CklLo0F0F5Ysm1XA4VZyT+/+hH/?=
 =?us-ascii?Q?5wg4SESHLuc+TltSBdWmnWfHtbF4vcKYhirJuYv0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1efbdc-372f-4685-18af-08dcc365ef32
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:22:55.4077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EQ2fEc3b47/BgA8YgnJ80XMaHaLVN+bMhjFVyW55w7WuaBYR8S6FJy2kU31ni75QuZtn3za3QfKCKvnLZkRvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5551

No need to check debugfs_create_dir() return value.
It's safe to pass in errors that debugfs_create_dir() gives you.

Fixes: f40eb99897af ("pktcdvd: remove driver.")
Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
Changes V4:
- Remove the check for the return value of debugfs_create_dir()
---
 drivers/block/pktcdvd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 7cece5884b9c..3edb37a41312 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -498,8 +498,6 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 	if (!pkt_debugfs_root)
 		return;
 	pd->dfs_d_root = debugfs_create_dir(pd->disk->disk_name, pkt_debugfs_root);
-	if (!pd->dfs_d_root)
-		return;
 
 	pd->dfs_f_info = debugfs_create_file("info", 0444, pd->dfs_d_root,
 					     pd, &pkt_seq_fops);
-- 
2.34.1

