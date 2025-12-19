Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010029.outbound.protection.outlook.com [52.101.228.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4911BC4E;
	Fri, 19 Dec 2025 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766128639; cv=fail; b=f4a2fOwjMXP1eDGCL6oyam6Nt+9BcH5s19mDn/X28rNpHUvCUmTdZAjVpgFRKJy/8LDhJioxqgdxrk9U/32n5wBW+H9fqQxR32RCzrhRBQw9YYiJAmSLrLw1FKODVmdg6omUorJEAES18TFiU1HrxSH7owZl3IksFuK0MScC9jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766128639; c=relaxed/simple;
	bh=1Urc/ppo57j30IkrbnoPTex8Z06g5Xe1KZadWeAQeSY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LywkBjGu4wDL/SN2NU6W0BYDksu/9FmDABPISKtsYCRlYPbEw9EAqjXnscYnuKAY2IgHpPvlIteuEHuW327b00a99rGMvrmUre7viqHUsnex6CN5q6UrkssLKVt4585iNWVfow51LCiHqcVFk9LzDbRc6ktdpVqVRg8D0QnjiLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pWSbnQhO; arc=fail smtp.client-ip=52.101.228.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pWSbnQhO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tosTrmnKQA4AIXzaJV3I6zDLwgDyZH5W+Ya6gykjirQgUte+dOn3EWUaMCX/IJi8lQtkmw5vrP2cpIEGV+F4yb0ODes+AYLXkUu9YtO+z9YREXxQ6k85mCI0uST6UCoOnG2Z0EGsf0f979Kp+MnicSD6EnKLoKk9XhJ3oHqN6m5Il+ADWLSateuhEkK+wevEdPXYTmZ9YpqEx6UuJ0dPkN5UkafWt9SZpHH2ft7/0b7tZtMw7pERmzKghz3zQvezis+LZZ5/wEJ+bhb0t6fusmQjiW9VbWwAyKUW2cIYeqxAc6LA9nXcwNky1qURPMxgi3mcRHy/RTwV8/QQ3Sj3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9wtY6qhWS8I0e7RS2ZQ2UWic9dPAmIR4BneSwRD5yQ=;
 b=K2NK8C77lPO5HUSo9w4fulq97/v1bbRpbCAtOGy4KS+OhDJDXSX8oCeRdYjfWX94t/QLykADRV51/aemrsgd9M3l+QE94+8SIT8v/huNIqBTx9wqs6qlpDR7/ZaffRPpFs+oMWgJnxEHBya8ho1/aEM9sgBcGV90GedLh6EvNmzbpBz1NPVsFquJjKbfOFGQuFNw0BL8JEr6CCkz7x/SFtj/b95wAmAGsbdWAFu3JglnJHELczKb6uGo7LJwIzZNoxcZsno4PESfSNT9hENCXPCUEZtKdPSZqfN+dfWYZ96w+N5eCzTJhybWs0rPSHwoTdEEGc2q1x0ZOP9HfFQ45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9wtY6qhWS8I0e7RS2ZQ2UWic9dPAmIR4BneSwRD5yQ=;
 b=pWSbnQhO1gawQMpVbGazCX+L5Vp/AsIasKdsCf7Wot8kEMSu7+TfIrfduguq0xcy66oihlwDdc2nReGCmhDIb2FTkNLCi8E3ja1/iyaJIVdfkUwHLZ6+q2zbMM5wXhi53y29qgxO/4arDyOpNmy9Se/BYZtLzEcyRKXCvxIxoxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2957.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:308::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 07:17:14 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2b5:5bff:7938:b48c]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2b5:5bff:7938:b48c%7]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 07:17:14 +0000
From: Koichiro Den <den@valinux.co.jp>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: enable RWF_DONTCACHE for block device buffered I/O
Date: Fri, 19 Dec 2025 16:17:07 +0900
Message-ID: <20251219071707.3295393-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0115.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2957:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa996f1-e1b0-43f1-c52a-08de3ecea241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dSh3bcg8k8wjL0SLiWMM0zULg/fypxbSbljxfg4C2c3CoCY1p1M+6DnHlcR5?=
 =?us-ascii?Q?j17ff19X+tI09cDv9LsWPhr/WiSE5Gop1nOU6U5Z6zAOYTHtb9FWZ5jalmeF?=
 =?us-ascii?Q?DiRKswss02X1e8AYAZsd+SmvnayhXQ4mAZ53AqEq4C8qDlw6dHhbuyJ87GuF?=
 =?us-ascii?Q?HjMuJkMqM/hjVTAe9xctLgL5UC/NsniHO4rOfu3B5K8LlIZTuFhUwe99uLsr?=
 =?us-ascii?Q?C52shR5qUhXsQZRLBBOFjZ5GpYwWCWf35tWqxuwr6bw2NzoQPp42//BxEGHa?=
 =?us-ascii?Q?biLUBcrzdwH1Xo8u3/fYWJlsM97CVX1rMPlkjoQ8ddPKB6oMx/SHF+ry3VI6?=
 =?us-ascii?Q?aevYK0OrZwV8p8Vy5aGUdCSWbMi30rEwQ0e8UOgvZLYGpEioSNRiqDV12VXY?=
 =?us-ascii?Q?xJEUjGzYgBA7Tj9qWuyBYcvv6mSaGsG6Bg/hZSCz3+CI9z5WVyEC5DrOk7nj?=
 =?us-ascii?Q?Xes8/HiSX3nA1M6Qqi3rw0CnKYput2BCMmjsJ8wzTC68/4Fe6YVWHp7m9PL7?=
 =?us-ascii?Q?4v4rpm3Zu8ptD+Da/R5fUALU+Lv7/DC+NK6AeYeeR20UCbmJAoRWnzVW5m9z?=
 =?us-ascii?Q?gAd8MfAzPLvoNRyWSGY8W86MrjY7KPQyEiVeva+elrZoJKUqPfdMZiwIUlB4?=
 =?us-ascii?Q?PgVp6Q/AeLt3FeoP95iig7T72qSBuW/+SPlIGS2BfmtmBggeW68Z2svALziu?=
 =?us-ascii?Q?0LhHPEgvA50BxXe+Vl5Z4BBUw1TWJjpJXDN+CS3nrxTi7OMGyBN2Rgx2lMI6?=
 =?us-ascii?Q?7y4G4zZ1LXi5x7q94kPo4g/haPC4UP9X50E6DO3OwgtvYLN6vq/Qchz6GAdm?=
 =?us-ascii?Q?jMomRwjDkHbCAcnn2UzZY4rv2H2I6rCravfYNKUrximou2vRkCYU4zcaqYsM?=
 =?us-ascii?Q?j8fzN2y3RNWfSAuwmu3FagdsE5ymIUL/cOvL1zdb8n8Nyvv6wtuaeWfFfT78?=
 =?us-ascii?Q?ohKEvCUE0nKdwuTEZYuISC4YCwD/5WpZV9OrcafVhpDlcLpkoirpbZpPfC1b?=
 =?us-ascii?Q?Qd6B2fPu3iq+HzN6LFwdN4fN6tKMk9CNwRCOBSv2XXstmFGRrwGHx0F9l6cQ?=
 =?us-ascii?Q?EdMlP4Q/z4AZmF0SNjTMKMjzRGWAi5Gw/tNHR0HlU/gfN3e+i/3yQIvUqvbM?=
 =?us-ascii?Q?QC5CsVOFJfZfbD2gsflrxj6pErYW3Oq96eaC0V74qUHUJY0rtWYSURMa7mGt?=
 =?us-ascii?Q?QGEdPX/aMYlG5N7xfVoCzuZqpu0GV+gkqKbO2VvehMN8UAilyRE+ATruSTex?=
 =?us-ascii?Q?FhskjlhXQRJVRCym1R2H1q5r+HJT04XXtOJSQaIS5k89K7hl4wN4AOSyVq0t?=
 =?us-ascii?Q?qpbKAZZ+YGDTH9NqGaAhoXgnyr2apk4BTmK9BlGqPHyBGnDHLWPMFA/IzIcH?=
 =?us-ascii?Q?PhiyLRFVs7V5yb9ZiKQNWm/C+nEvtU8UyGhD2K1KAfVEmNi2uoxx/H/gKh9Z?=
 =?us-ascii?Q?LP6M1KDf8E17kE0u+F0eFf7ig2ra00kv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mt3A4jsn8PB7c/lpqQNUy5zzhruxT/CYLEqtf9a6tgExR64v1Iewej9CcYwA?=
 =?us-ascii?Q?n6HMPhEcnrZGxqWqqc/Dtm68ILiKSbJIoMYdltde9fLsw5779pq/sNsKMWQQ?=
 =?us-ascii?Q?iN94Lwxq+8/5bD0Q6pNeaZmjSHMdCgE3YBcIw1H3lfsY2BThuKk9V06cbNbI?=
 =?us-ascii?Q?LlTD0+DWoizZ9DIZUnqHCIrgDKu6WQTI8RFZt+zCHL9av5zGJt2REoCyecgE?=
 =?us-ascii?Q?Fb0c0/6jdk7h0RfUEcB8+N2RIXXJRGhDd06nuLiyMF5gMLBKnLPLQ5QyV5Dl?=
 =?us-ascii?Q?mV8YQGNiN/J28a4uWbVXg6OWSrxHX780Q6FG19hVcKA4LnMPC4ZvGOGddFZw?=
 =?us-ascii?Q?Lbt+6gKDugc0eTSu5ChylmakZohHAX7zYk8bZZOBeHZd7rks7L2f81ZWzFz1?=
 =?us-ascii?Q?135qWvaSaGQBxcQXAnjhNImA5wmTUsI29R4G1xPmzs9iTl8uUpK/7XIdOUgL?=
 =?us-ascii?Q?swyLYBZGu/Uxts5/m4cyuGBu9pFlN2edzmG/89MSwr6N4/SQDCyXBTUvZAxx?=
 =?us-ascii?Q?ue0MUrSj0j9zi0NGC/iK5z4Z9Q5v6IbygxmlVU6ikIQpzYkEYOY6xGXBlI+Z?=
 =?us-ascii?Q?h2ro0tofVRk0ptJCboB2ucXIGQqWJqOfGj1SG0kL8SgpyTcMnj5vMtaAbb2l?=
 =?us-ascii?Q?k0mrBSWFij9zyRnefJEW7Cq5jV7Kltqb56ae7zEY+Rxa7fgd7lT89qIHYaMQ?=
 =?us-ascii?Q?YqhnlCfbbM3KB2+F74Sb9J9gAjGaUuMCUxURH4Nyf1E/rR+Pa5+wGr9OLKhf?=
 =?us-ascii?Q?EIZkao9H1q4Dg7GaVIo3wArYJrGbgZizuV1uNf1lwL2UNfazBNmJExUr5dFt?=
 =?us-ascii?Q?wbsh/wJ701TI6dcEUSU8FZHRqI07wnbXCoP7EYLm/9G8V+lHF8BjFLwS2Crl?=
 =?us-ascii?Q?fAGMvamy9CcE0Bn7Q6DV9GlfAYskgbwBeH+IBByxPWyJTWCm/EOc43uM3/Mx?=
 =?us-ascii?Q?VfE50ghsG1JrVmScC214B/GHpgWKNOXGCyM0/JQWdafUD6F/C27YBn4u7sYQ?=
 =?us-ascii?Q?F/pVHALPfkChOY1d3QylJF5VFcXWH9QonhZFw/0D3D04HSkGN6Cr9Q8LM8jd?=
 =?us-ascii?Q?hSsrWBAF/LWSPDJn79wbWqhTV0ZeB/pPix3FPs16OpxTW88FVsqzqJ1MJKzY?=
 =?us-ascii?Q?8GXZriC+T7CjUalnXzB4UHd0ToRzQzL66c+jON8eoqThXQus7d0C5TwKOLmu?=
 =?us-ascii?Q?yRwOr+L33QmtrtWMGNSFn7IpVHHJAMzmsCvSWWU374P31uLlRZGS15JrF97N?=
 =?us-ascii?Q?De/6yEY5pH9+zxyqP9qFh07u2DC/8Q65nxG4VilqGAhBI+gNqH8vqZerNZg0?=
 =?us-ascii?Q?qQTQypJg5+dVo6LfTWEybEQI86Wbh7/KZXJsapuoE57FdIJEsEsh4Bw8b5gF?=
 =?us-ascii?Q?4gwpwhnZMy1jHWjyTR+ebyPAj2Thb4q/0hja+jW2rU9lIsLhV6D88T0KNr+i?=
 =?us-ascii?Q?u9ifSP63N8ePpog4iEeQLrDIsfvdKPFOss+dp6ticAlqn28BuazDfAF+oSvB?=
 =?us-ascii?Q?Lorn5LVEZkkx+5UTuLt9SdacihHSu6CI9ZBSmjAPDSP+V06gyPNvbyCjey1q?=
 =?us-ascii?Q?fEDzUFEiJcVN/tmcTkoCN7c6k1DQ9GUCOVkLi9xC4ndlt0uZrJOcmgfRsMCA?=
 =?us-ascii?Q?S+2ZX/fhwiMfMyW58YPFDT0=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa996f1-e1b0-43f1-c52a-08de3ecea241
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 07:17:14.0120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaXoaT4MXPl0VdTl9N20FC1kEf6hcGpzRyO/yj+RMY9ykGB0qjCTbK+Uuih5QOvwep7F2yhyrldCuTCJn0+OWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2957

Set FOP_DONTCACHE for def_blk_fops so preadv2()/pwritev2() can accept
RWF_DONTCACHE on block device files. The generic page cache and iomap
infrastructure already handles RWF_DONTCACHE semantics for the buffered
I/O, so simply enabling the flag suffices.

This lets userspace request drop-behind behaviour and is particularly
useful for avoiding double caching in virtualization stacks that do not
use O_DIRECT (e.g. virtio-disk backend for xen).

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 block/fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 4d32785b31d9..9db41dada818 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -967,7 +967,7 @@ const struct file_operations def_blk_fops = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 };
 
 static __init int blkdev_init(void)
-- 
2.51.0

