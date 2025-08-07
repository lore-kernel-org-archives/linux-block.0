Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013065.outbound.protection.outlook.com [40.107.44.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE1125E816;
	Thu,  7 Aug 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574974; cv=fail; b=Q9NscEBuiY3IYmKbmdyqwCLGTQ5SOE5xeAJEtZ3GDF9/QZbG3mYc53Z0j//hOaUfzqeM/e0WZBKLABlPIxLHCPi365hIjJYIFxYNsnHl6NjQ/J1O6zuiDtGcLpA8m/FFKv5/M2dr890QwHXKVAXN35YUSU7zVBKPqgF1anT6UT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574974; c=relaxed/simple;
	bh=Klc4G+Z5S8AEOOPEyy2gZQu86ettl1EKxTpfOq+rwcU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VY4UucXQEXbPYk+JngLtvPVnikL3dzMPWyJAcK7S5C8ENuRjW4Zfi+ErPxSZnzDJbcCtjScf6dLj8zywaWkCahbVoemWXDqaer3xVg9MtnTuWexPZEbt05iKXTXuNY1CLebk3KSopJ0Q6Ol9lUNpECZpsy3s9QnPFKvYy5yy/+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RbRaX69u; arc=fail smtp.client-ip=40.107.44.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RbRaX69u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZfkvVwvazAuWeMiOKA2FnqYeDqMqzLNi7+YdYhtG1T0NED5MTPrdlZijzVQZmckatZQ5emTr1IDB7pIbDPZQbnGz1m2vZJUnjemU9a5ZDxZQ50uFZJIR+lx+pQ7+SeY61i5PHYiIX9QJWg1P/panRTuhWI7jh/kCLpVgTp69imA+PLO+0uNmTEXg8fMAu5lLI2zID4XC/Bpa3Jvdk0mbMMiNV2SrxRBwlI+ceV7rkI2Aco2Q0BBKBByQZspip73kraC4LTjRTX3SMPAk4NNH5Z96IX3TwNOHOdrS+fS7dQkqZNdVpyQXj0c9Iy8buH7FyFTf5A2FwQFMoTp8/1IPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xye0zUfjHoxPcKU0CPp0a8CUSJxIsR348jdqpVBLEEM=;
 b=SLPujDvG92B3ChuCW0Y+XNcNmmyY1z6hzRKWjKfHyp97syUQymBMqUsQhZv3TZ4//vEzv7qFRttbxZM6zEP/gUqg+eq7+8sCZpVKZzYqhMhesSJ/Z0d1++YrXAehsy/by99rAL1QW/e9T+KtWWspPNrFF43rKGfTCPq4EEtpRbWQfbGx/EgUL1/Hfk9C3ydkz5+lOP0paI91A+1aQfWbgofsT6QRWOhZvWAyOdCpLqraeLl7tR+1RxYfe0bTmtFEniC/reXqxmzyQ3ugr+jmROgy2ND88FpxO7OdRhGiq5gDMWG068yxBPRjUqKqiHJwAsBLHjuwFzlvG1das0h42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xye0zUfjHoxPcKU0CPp0a8CUSJxIsR348jdqpVBLEEM=;
 b=RbRaX69u0CHWkrI2yJmmAkF2XQrUwSIHL+VBlRNS0q5+IjGMjZSaAqyvg4QAJ0lRMRRKptDnzzq2kMGVA84xwpEkSGM0WETQAqBYS+bmoEeKEIjy6P9rcYvReYskcT4iLGRV+hk5oTn4yZ6kpQaeZZ50tKndjsSlzOn+B4tslkJjBjokfHKeACA8j18LWj0IM7U3qtA1sQ2veRZVjzSm1rMjajYN5W22j6aEvj+0RoprTFNJ8HwtjxZ10j5sek0v5/j1KTu7SFfdiO+fRrvtri+BeROKKdKNtL0OdGu3NJpDzls4CO8/FWrYOx6B5cmnzxUhAmkl0itDQw2gpNyWow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6614.apcprd06.prod.outlook.com (2603:1096:101:177::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.16; Thu, 7 Aug 2025 13:56:09 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 13:56:09 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] loop: Remove redundant __GFP_NOWARN
Date: Thu,  7 Aug 2025 21:55:59 +0800
Message-Id: <20250807135559.560837-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0226.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 57afa243-22ea-4317-6ef8-08ddd5ba2997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xncPRMy6AbGs+J6HQna0g3gR04mKdCYAB9N5qihSGO9cXAqLN6KzkhEAV3e3?=
 =?us-ascii?Q?3nHRIkHcL2F/pukUH85DnNy7T6Q1B+19RA34gbHfW/RGfBBIAPH6ivXCTdTN?=
 =?us-ascii?Q?lGteZ64h7TnXi7igvgiWPxTs/H1G990J1oRYEPt696VQPYE0qYdhZr5e3LAx?=
 =?us-ascii?Q?EDiNExyygJXB4myJ8ITf7BNLHAowwa3+j41ADI58wcS5vH/Ep3UBvrco55ts?=
 =?us-ascii?Q?DWApkBICL4BYeweuIn/Q+dsbOVYn70DfxyxIaHkojWWzsr7w3QRsDn4Uc+a4?=
 =?us-ascii?Q?ZvluORbx0tNYwgcWQACjvmA2oebRm1gQsjX0WUujCaL0YV8k7bNZ/map0Epa?=
 =?us-ascii?Q?W+jLNeNzXTda6bkyGfS7268znvk7xJQGAf49XBPyipcEiojE3cZk0eiwMMJ7?=
 =?us-ascii?Q?DKlEyk1R7peU0zS3aOsjZmilvaByfCFHl9WY8yjxHQA+aDmm1UuVz+pGcdPH?=
 =?us-ascii?Q?1BCXnLQJuex0Bl6VPO6AGPp2qx8fkDJgDiFiEnLo0dBqsdTBqXxVNnLkYPG2?=
 =?us-ascii?Q?IlNQHoszwDo5LfwVSZoPjs4WlSVTxe43MPx3+h/AMAxOkcrHb0L+T0UVUuMe?=
 =?us-ascii?Q?mbxjhYjZCm3ByCqSY0c70IxduVI54IAupwTJ9K3RFdmvKKdiCFoFENWYuOVj?=
 =?us-ascii?Q?5uAaKmmnyz6yB0vMWFChnFbJOnYiGee2j9RMfbROMxaV4j36iYfzS2UOXPKb?=
 =?us-ascii?Q?fy9tWUGcjYVr0e5j1Fm3CCvE9qa/JRUkzAC0DB7ObwcWSElv5BflZE51uaVL?=
 =?us-ascii?Q?CqIFm8bXShhQC+DX7koPWCJzjWbLu8CsO9TN01bN12PVV0vftpJEGaCphsvV?=
 =?us-ascii?Q?Zp6UHQ6OdImqfYhNt9+LEhoMAeu8zOQ/IzvH195hWW0eK4nTL5XjsCkY3/Xj?=
 =?us-ascii?Q?bspO0lS1linU9ldLpzK8XV5SPqfNgnl9y0u0UBRO53qQm9NYokLeJtf/sgpY?=
 =?us-ascii?Q?pbvNr9pY9FtUmHK3lO/a9PztrvIfROwAoHZIyhtHvntQLxu+xTEEfl+Y6KmP?=
 =?us-ascii?Q?6A/aQDdcv8b0WzmD5sMoPg4PaEJH3vNbmCC1+kQo1X4eXBBuC2qEbbiq4jIP?=
 =?us-ascii?Q?nrRYQnJpQ+E6BBK7ETh8llsGewvVjikcwj6mmdwX8Gezh+9rD8rXyR53tsv9?=
 =?us-ascii?Q?ACIGo1sXnmlSLWnoTQAK/HgzNKYhTFdxtZRUZj7qfSiCyVdsZtqQCPAZ4Vop?=
 =?us-ascii?Q?QMsSJj2sgInAw/nnHCL3jPCsffYky0dLQwky5xhhnPXkhlHJU+XyVhKarH/2?=
 =?us-ascii?Q?a9kBFf3dKwQ5PMEkvtU0c5UKns2nLjk81vVdzDxVYzk/8yOChlB+e2Kl8Is5?=
 =?us-ascii?Q?UdF3BD+X5Jz04QMh7Ile7AO39EB+y8eB7/J0PjDvBFhM5TFcxJ2cduUNzNsu?=
 =?us-ascii?Q?UyR+buMnxZ2AZr2dRiG1xjN7i6dMMS9XrZT+IWymu8emo60N+Y5BzNCej5iM?=
 =?us-ascii?Q?06TYMb/1gPdDBdkPpLEq+Cd6aYE3874SOP7Ubci6FiSH3ssJELeeJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NLMWE/Brz0FIKuVawX0lRw1P3Qj5aPPAc3+JSiGocJyTpHVfa0kKu36e3WJd?=
 =?us-ascii?Q?4rDbNyDTASnKFAglpkkq8EiQP2SYoslxHNWwL+NnF5ZOZ/Iobn7KKL2Dp6Gn?=
 =?us-ascii?Q?lBC4uOV6nnxtzp8z32N2r0/8aqkI9/Grfq4JvT95fcC8jw6ttbGMMW6kIaNQ?=
 =?us-ascii?Q?1UhzWLknfgaN5EloSi5gnVMjeNxCkNd9aCdwW5v9mjBZplRlMZmGqH7ckYM4?=
 =?us-ascii?Q?9YdakwoA1tMbv/lACs2JEtvvXrbkrKq3XJcM5oeof6PgJRQ9wHNJNJLXnu4Y?=
 =?us-ascii?Q?YKZjR0t0Mt5eFrFIgyJWpQ9SvDiTpzGPTwdixfOG51HdOE1oH58+1d2wf+Fe?=
 =?us-ascii?Q?/mJCk4D02uZQ89k7HcZxgjz2rj0m+S2yk39Nx2ZSaAznW23RcgQ1KJcwkPI9?=
 =?us-ascii?Q?dZbF8cFYYhNvGJXL8wm/m1CgYZbTFewZIh1PZzyidFQs13BxDOkT+6lqEo7l?=
 =?us-ascii?Q?r52tLtu2bQzf0BDqh9b609pztG4MdOE/sDmctpf05Ov/LVYnAerS5LoaNWMD?=
 =?us-ascii?Q?NK5FepTvA5NSxzxV/pnoh7/MzGyUI9BTU6TGyF+DrwowHWQDdPEiAnvq0Ckt?=
 =?us-ascii?Q?Lerlaj/xPM9lyBj5tHNE1VF8V7fYTyDMESzZtk74LDJgutoudDi9NK3IwIkV?=
 =?us-ascii?Q?VPW+6yhsIGyYzg6E4aWr5iPxdH+MTfoPVkRjLevnu0pBbAHfVmVjOz/1+rZQ?=
 =?us-ascii?Q?DAhl8RE4Qz2oge/M+HAdmygkYF0GcNfcapQDnrxrer3CSeT8/QVSS56MpfBZ?=
 =?us-ascii?Q?W6o7I5AV3WkR3gLWxjyu7EAM+1QcXuW/VnICSaghl0t7csYxVeBRKtdmnvJM?=
 =?us-ascii?Q?m+2Cz0Q5rC9ECVEXDeVU+U0C1lZQzGwMYJKaNeFnMDErrUM0iZRmXYyURBcE?=
 =?us-ascii?Q?BDhyUi6GKpEtq5vcdC8nQrnWY9QISmGAGun/vdjQeG74GHim0uX/GQkZhpX2?=
 =?us-ascii?Q?A6i07hF9PVLIhhHxZcSFkeZW6DjNAvUs4FrnQaob4PnuCS1HWmWNwjzUjgbw?=
 =?us-ascii?Q?gbbcCevbT65gZXNTi4bm7cr+Efl33fr24Iewa/V1RvWHItmcApD8XrMrVogE?=
 =?us-ascii?Q?7FoipWUkYwMtnTDq6bV7yygNivHg4Nkdbeu1Eq1xp1TkKdfkdob1RluCmGGZ?=
 =?us-ascii?Q?flS7td46xHVGUsQje0/TBV32EOezejXuxCfytsyNePA9gEIPLpfuEebxKm9O?=
 =?us-ascii?Q?/gHkxE6R0BrHDlAQcxu+PR4ApendM4b5IdDJqQZ5Qa8OzxmNV94upS1nSHuR?=
 =?us-ascii?Q?MLPVqmrlR540RujOonp1d1T1ai5400ot7CrLFZF8ct1/uHzi5E5fNwH275ap?=
 =?us-ascii?Q?NmZgTO/YIEJGDjf5ldqPxKwtXZa7T+WmbE98V43oOlqDH+t7zjeCD6BUJKNM?=
 =?us-ascii?Q?3DsGGGMBlJ2QH5cDSKos9VQ0O00t9qrBgjztmb+g84RUFiSOlgpj/hWk9P/L?=
 =?us-ascii?Q?gqaamrVeJN3beOcuHpZ45zhOLziCDHNZ8nihv0YaLgNlGBInjnDvALP81oGU?=
 =?us-ascii?Q?aBnmzxMPQQ2AHuM1gHulWUytNQlApaWYA/jZfEwP8i7IxXmsd1cTigHAgUYx?=
 =?us-ascii?Q?7rgShkqVheqmgfWK2bfoSD905DgAuxquvbURVVer?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57afa243-22ea-4317-6ef8-08ddd5ba2997
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 13:56:09.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2xNsaIDwnGpymmHEW8wbMkHVYuddtRFpg6jLE8EyatedBHKHW6HmY+cMqlm2UUI8Dxk5HLed9sb5ENp1bugiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6614

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
made GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
(e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
up these redundant flags across subsystems.

No functional changes.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1b6ee91f8eb9..8c90b43b348b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -812,7 +812,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	if (worker)
 		goto queue_work;
 
-	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT | __GFP_NOWARN);
+	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT);
 	/*
 	 * In the event we cannot allocate a worker, just queue on the
 	 * rootcg worker and issue the I/O as the rootcg
-- 
2.34.1

