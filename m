Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B5B3D3CF2
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135870; cv=fail; b=Pwnydmzqvu3XbVEb96WsNGwaavGiTQ9TFBmhUmnOlSRJ51SZi60QKe9n3Or7KQctIhtPonas5AlfvwTimsharcT0pvG1ZiDbTCmIVxrIyXkgAkK93b3ZT2wraaKNK3leZsAL4cNVmmWxod0DHOgD6Q2kYT5czDU7RuOo3oIorbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135870; c=relaxed/simple;
	bh=8Rh4wXdudcB/QYRQclGpQFDgfE60tBFovN7uDCifbIc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RGgOdqnhfJIvKtRqpOcyN+z8Tvl7OaN7H7ScAekQ3fEOUx14HrDTSl35yDilgII9ofk6lwPQGON3NcHv4g4bB3x2PIehD1Ot9ryjFgUXoayygWG4k0OQyR81ZRAbTm1+8LxKXEbKtkSRwvxTDc6pwfkiF/R6JXUSdFgVJgM3zZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gAX8qk/Q; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Wh/TViGZ; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gAX8qk/Q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Wh/TViGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792135869; x=1823671869;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=8Rh4wXdudcB/QYRQclGpQFDgfE60tBFovN7uDCifbIc=;
  b=gAX8qk/QQz0IbpcbKCXYnzbXAaj22509iqwNpgoLV1nESAe6mDz7S8/z
   cYI6pPST5Oq4TWCtX5MH+A92aFCMlq/SbI7OzOMP6XTNTH9ivwHlbeWfR
   L03ph8tMWEQpF1Ac5tRahQSuJNsN16IX8J1sbXU4wAixHY5yQ3NRGNLfn
   vYUMNwDTiFWJUZgkPdpwwVtPUugcTwSOhafT/tMn1Tyf80QEvjPUqsZZQ
   hBmJUMwXDn/pKjEfbsatm7zi0R4hEClfTSrZ8ghRXPl0tOMUWcuO+uijO
   zzVEeYpsjm/9ZD40lCUUljxuIuA3Nsij5cUsRHEwkTw9kRo7Fh6GAHSdN
   A==;
X-CSE-ConnectionGUID: ociCp/hATHu+uWAB1dqddw==
X-CSE-MsgGUID: FBenuKg6TPeM26A6BTmN/w==
X-IronPort-AV: E=Sophos;i="6.27,161,1786982400"; 
   d="scan'208";a="157288423"
Received: from mail-westus3azon11011013.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.13])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2026 15:31:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4845gsSXEP/No3oQKcN83KYiQWzaJ6Zs3BnHCzSY2wlgXC6Y5t+RqRukOCmk0Ava+AiwhUVOCa8AjqulHDemODvQUWKSyu/XyqqEnYSZ01HavNGrqUeQBV6psI/RawyRI8jsLMl0sNfb01y3t8J/XmfQWmXreJo0w8yr5He6tMB9XgGe15VulHLWetfl9w3ZsmnIK7A+r4gYT6/+AAhb0wyy3UR1x+7A0p2sGZeXzXsyFaVhN9z1NQkgHqplcMYgHXLoCGGSTDOTcwKQVbQXBMl4bkEXDJSN2/xCe7ufbLda8Q8g/gdR5O+yNwKSesV+I0880Z70bYBQMWwuTo58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksnnMRJ/CUqqi9I7m/r616NsOnltjpOxhh64WKJxJqQ=;
 b=ZehmHFSA+nhA17v4HXcpbn8bv0XO6G3xX+w1RXv6p5BTqvDwBnRmRwQkLzfonljQBLnS7ZgV4WWoL+r5uCiXwT+jxv/6zKlRldTtyo+1XYVGrkjouw7pN6vGmohtKtno1dsXm3w5L3cx9l6ZEEqX5MzKU0k8SxZawP1w/X5ikvaWGO9t/v9uD6etCwJaS6OfJlvP3HvVhBa516m6xE/N0nqlXXZssuiRfYTTgHUyefFADwT+Zy6ZEppmnCbwHcct9jyxGHI7jjOWu75k20lU+fVZwkO69asnqrDTRv0HffGQc0Tm4YXSYc/0gzoCe+c7qrq9bJ8uR1JUhSo6aV8nXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksnnMRJ/CUqqi9I7m/r616NsOnltjpOxhh64WKJxJqQ=;
 b=Wh/TViGZsuLC40TwqakQdn4I7Fvmn/m8fYnQ1aKwiBaY/6FYw0gI35DU8DptTLKjxl6fe9TuobU9htLoCkHwQhYNdAyHEsNcjmcQ6HbIokkIwVDT8ZvJNMwZgKGgFPPMMkNJTLSAtsggBP0adXvIw7EGmmq6LCr3MKRq0In2RPs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by SA0PR04MB403788.namprd04.prod.outlook.com (2603:10b6:806:ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:31:00 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 07:31:00 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] zloop: print device that had errors
Date: Fri, 16 Oct 2026 09:30:43 +0200
Message-ID: <20261016073043.1164325-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|SA0PR04MB403788:EE_
X-MS-Office365-Filtering-Correlation-Id: caaa3ccd-ebb7-45ea-8d7b-08df2b576ce3
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|376014|10070799003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Jj9OkQgSIz2anz8s+oD1Pxg7O3mcEsF729zIRsDw/reMqwp28X/+eCv+jhIAluuIPJdDm+JEGKdtsPY3YcGsU/Gr1lYauoXUKUyYbzj2dOz43H731dOsTzRs0V8v5+uohZX0kAF0ywcCWqH+Rn9dkz0mN/aM+8BimTXIYZqgYjRni0Y06rSEjkXTtRVjkFleEQV3VexZToiJF/tdRaOwGqbwMGgx9Wt4FLPtNk5bMbGdNo/WJPfIhUSvVPcuBP2s/Dfz6kKXCpOtTT45hBkv4NK0GU8s/EZDvz3Ll1B4Fz+mbTMYzlS6jo2nTZzmLPBGg3IWm94VbafIZcSzQgv4H+tqiRrR7Ec37Y6kr7x/+eSCgcX5rCsqB0W+3ImQI1VsVI4n0gmuZZcnHCBmAlyV78SmBMiMYCZyddTg4rZlsSnkfsYZhgm29Jbcf08fYNNBmK1Dsqzb/hQRwU1CXYaU7PG954y5KqeW0HilCOXvHHSCQhO2hcPAB2ME+gK7gEAlM3xs6oPD7/eCFqua++bLBzJ0n8LY2Bgx37SuIfMibu3bre/+u63nSltJzUl2W16ZGhrRmkDqRd+57DqGcesEp2JHozJwXNADtX87ITTdqXaZFK+iulQbya4NI8fLDFY8MtpVBHmCnndTL3/AaPVlW7WaRwHEOydeCwyVYjts4E4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(376014)(10070799003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VNi19Mut5VHD3uynpMMNxMcMgQ9HGUTOI/pmfdgjqngIIPYSL2xXrU0nZgod?=
 =?us-ascii?Q?F3NUrPaaCgQh67XEp24eiihhapYMZ2thlxK7Hbq9+UnAFpPaGsbPD1WoaYD9?=
 =?us-ascii?Q?CtHvzq5PTXbOLMCZGjqnkNRPDo3bprTA+vG+NhLMUHjts9FNkwQpG6dCLzeN?=
 =?us-ascii?Q?ChmuktMt/1pnzK5FltA6ASUyKZ3xH/LAeGokAetVg/4eXPH2XZfEjldkt3DG?=
 =?us-ascii?Q?bgucczQ/Zby/RF1KuLJ3IjoOMm6HpSX1QnqMMEQcpreacejgFKuD9TBWCIqe?=
 =?us-ascii?Q?8yIjv58gI6ciVIv4Ead42Zd3fgI25j5HrFbrzkf/Z1bpKqDzd5xPEpUHkd5T?=
 =?us-ascii?Q?+N5cm6lBHJ0Z0EqX9V62yD74SXoIbgvate7OlO+9gARjQIyeze8qkZc+/6dq?=
 =?us-ascii?Q?uUQ1wqiFV+lO6QjvZtdNWCDRc1CLLgzerT4yV99SUOF0ky/AJxwK7/S8beZS?=
 =?us-ascii?Q?PaQF9muY3ssltKtqcQFcbRNhEIC8qBp7bkUZWoNy51cGvgYBTbOoiKIhWemu?=
 =?us-ascii?Q?Gr16H4dLdrN8/aZoC8HbyMAwcPZiHuzBhcuyIvnGWPvUdqAkZBqTjsXeg21K?=
 =?us-ascii?Q?d3+d9/PbAmSOd2M4Jh4T17/JDjguhRYCmhLhKKXe715ElXiiYWKkhdJHWLFU?=
 =?us-ascii?Q?gEvAPnk9H51PoZq8tu0DCJKM5ux/R0tZ5jbqoGdQSXl1hr7MtytTtzIwFC4b?=
 =?us-ascii?Q?lbs3894Tfjs+qe1iA59NPDM1sqfOtwABm5tPmMTESoWnNYqDroWoLnm6MJ08?=
 =?us-ascii?Q?rxxDOfCD24qc5gxkjHvfP+wbHLGoQdqRHYAWGV6F2NL5bdCS7sUyxg1WOTgT?=
 =?us-ascii?Q?VHBKsVQBFjWv8r7MznRdGJr77BkSkMo1VSx08DdzTL9tNGQA9Np1mrl2Mi4x?=
 =?us-ascii?Q?8ilUtpJMKofAZiiiZAohKxOv6RXqtYso6ffpbiGAzvx1A4Q4CP1+8oYeFfg2?=
 =?us-ascii?Q?vHB998iKGB6ZfsQ1kQaX38O6sSAKT0kbOFpYipSCAA9Km1OcwK0sMf628ekK?=
 =?us-ascii?Q?Hpcw+/TPG45NjtuK9U7VDi2fW+x3pIAfml3jNMwGEnpEuVPiDTyddjeqixoJ?=
 =?us-ascii?Q?uLhsdA109Y5Sp1+/b88/hBqg3A5pfCXgtydv57m7lnp38BEsxZLd039D0CP4?=
 =?us-ascii?Q?SEJ6DcwqqU0uyH7qyxJrf2j8S37QY1hVN3g4wox6vaZFrSvHrb0YDAhTCzbK?=
 =?us-ascii?Q?y5ji2bGQnhTOL/QnEaaIqikoC3t66+eluZTsDPGJRGXKadVhzAl/LlUz9tFY?=
 =?us-ascii?Q?QsHkIkSvFTymuY6YfHDtKxW4g/9XE12TCspSEtfKfZ5zPD4nSnlKX2j1TpRv?=
 =?us-ascii?Q?qfSDQ41Plb6Y8d1VZE9ZQ5sYLsofWI9PehgInlXQFKyHuBXAqP4LghPhz0ve?=
 =?us-ascii?Q?UR5MmGbhhlXgimXwlGmc85DxgC3JFopWvVuDCUAiQTKL3Qxt37WU1O2MdNz0?=
 =?us-ascii?Q?FgTQTe0tnReGuoky2rseEqBuFWiaGdSVOLshNuVrppAnWvKYpF+WbgCbPGPh?=
 =?us-ascii?Q?Fy5QHCkHvdV3i0VhmTA98M3fP4xZxwqH7OsToP5E/R78vJ8fif1WrG8tt69J?=
 =?us-ascii?Q?dvyJEM3tESRFTh/50Bdh5JRdZOBnObLQdKfxm/34iwo4l3399EuntwEnCSDB?=
 =?us-ascii?Q?VCi1TPcYFqlaaWA10AKGvM22AgA+b3gyofzYx2TP+4xvpjJcW1nQ1RkXbE5e?=
 =?us-ascii?Q?yv9D6AtQW/qhvsK8dLLbCnfXizv5FByAhrq55WEMko0iMOEwzmXO7VgdvmVS?=
 =?us-ascii?Q?QpZzwnoHIlwpGabkh4VZH/6I/UfUFiWOkUDvnt+zrMisJqmb7FalmVLT5XkF?=
X-MS-Exchange-AntiSpam-MessageData-1: 6oJSAQ6BBOFM0aSTdom7byK5FDF9Gyu0Mh0=
X-Exchange-RoutingPolicyChecked:
	f9scijRuW4J9/s9taW4Yp2SDTtGXmw2g+U+7sXlwZJhAG0+1ZLqYf/U6LbsNf7yXoRaIFROuKg2WgdTIJl7/P831TcJVQHofzdh+0Ifhc3UwqB+2/ZnG6HJ4VhmI9o9hVit2EmEnp+EId947B3YZ/ceYt+kN61wGuFyei7gmJCJtJCaKfEbS7csKuGFt8goJ4Jy5ttRk9UDmMuRVcEsTSTQSZAJVt+vW+FFETeF0TYm3qyxX0z4RLYr/I97H6QkSIs37waguwHnrs/uo4eHsk6EMMxrXO+RdgGWHU6isvcW4xVO33AxsoGp48U8OYc+WfiorlcQtALguHi8RsvL0KQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1ZpZrnsu+oNWHi2vucBgi4yh+/csowTUW4e4MVZECjzYCzIJDD22Y7COzAFst+ZkNAnv10i819eoxIoayZm4hgqgt6sxMUM4T3IDCM1pvPKMUY+iLK1g4eW3n2+4FmA3kI4MpAGTTUWvpP2wXkMeO0rTI6HsA68dn85G6KoQTOas/AQNv41hCY95PjLLDFvuNxW+juivwRso8ND4YyG/YIxZpqZCn++DnpnZ6iJKkfGSdRzO4WFkshoxklL96b3wQ+yjgw/fUfilSGIabGrIZFf/qgrqtRLUZwQaREkskmErSqSvNytTs/z0RJLcNjEcHo7W/pdghTLA2WM3n3WX+UBYfcsLl7/cV89YtN1QfETtaUWs63TZ8u3FE9/UYYdhfTgV0KVcz/yoZs653TtfLRcmz1PGR0LVGGw8CF/Cr/wQY3VyywMhRRMYk9+49pBrz55q8Q3FSXdPwwnOlhQLM72Ydk3eP2GBrkvPUpxhp0SY3HZgsz5ynrL+6TTgHkaUij7BA0X9CkhdqiG457Q9bJlsu/ORu+aqzlE5GxERqcGvnm2dzaS37wwsqC/FsZwN9VU6KwNR+TzZh3RiPC/3fWwVhAwp6Gye1NMT8b4R3JHjC1xKftOXqi3iYMUaKbQa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caaa3ccd-ebb7-45ea-8d7b-08df2b576ce3
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:30:59.9811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bt8GUh3tbx7cFBfAJqSQkz2lHXNoiRCpS/8KpMwMmDwWqTNnj2MnpYTalByaoXkJE/FkRchOSU5jCpy7XG2gGZG9uDy9N11hwDuSje4edU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB403788

When testing zoned filesystems that span multiple zloop drives it can be
difficult to figure out which devices access caused an error.

Prefix the error messages where we have the disk available with the disk
name.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/zloop.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 8f485ef51557..9145e0f98d56 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -318,22 +318,23 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 
 	ret = vfs_getattr(&zone->file->f_path, &stat, STATX_SIZE, 0);
 	if (ret < 0) {
-		pr_err("Failed to get zone %u file stat (err=%d)\n",
-		       zone_no, ret);
+		pr_err("%pg: Failed to get zone %u file stat (err=%d)\n",
+		       zlo->disk->part0, zone_no, ret);
 		set_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags);
 		return ret;
 	}
 
 	file_sectors = stat.size >> SECTOR_SHIFT;
 	if (file_sectors > zlo->zone_capacity) {
-		pr_err("Zone %u file too large (%llu sectors > %llu)\n",
-		       zone_no, file_sectors, zlo->zone_capacity);
+		pr_err("%pg: Zone %u file too large (%llu sectors > %llu)\n",
+		       zlo->disk->part0, zone_no, file_sectors,
+		       zlo->zone_capacity);
 		return -EINVAL;
 	}
 
 	if (!IS_ALIGNED(stat.size, zlo->block_size)) {
-		pr_err("Zone %u file size (%llu) not aligned to block size %u\n",
-		       zone_no, stat.size, zlo->block_size);
+		pr_err("%pg: Zone %u file size (%llu) not aligned to block size %u\n",
+		       zlo->disk->part0, zone_no, stat.size, zlo->block_size);
 		return -EINVAL;
 	}
 
@@ -604,12 +605,14 @@ static int zloop_seq_write_prep(struct zloop_cmd *cmd)
 	} else {
 		if (cmd->sector != zone->wp) {
 			if (zone->wp == ULLONG_MAX)
-				pr_err("Zone %u: write to %s zone: sect %llu\n",
-				       zone_no, blk_zone_cond_str(zone->cond),
+				pr_err("%pg: Zone %u: write to %s zone: sect %llu\n",
+				       zlo->disk->part0, zone_no,
+				       blk_zone_cond_str(zone->cond),
 				       cmd->sector);
 			else
-				pr_err("Zone %u: unaligned write: sect %llu, wp %llu\n",
-				       zone_no, cmd->sector, zone->wp);
+				pr_err("%pg: Zone %u: unaligned write: sect %llu, wp %llu\n",
+				       zlo->disk->part0, zone_no, cmd->sector,
+				       zone->wp);
 			ret = -EIO;
 			goto out_unlock;
 		}
@@ -837,8 +840,9 @@ static void zloop_complete_rq(struct request *rq)
 	switch (req_op(rq)) {
 	case REQ_OP_READ:
 		if (cmd->ret < 0)
-			pr_err("Zone %u: failed read sector %llu, %llu sectors\n",
-			       zone_no, cmd->sector, cmd->nr_sectors);
+			pr_err("%pg: Zone %u: failed read sector %llu, %llu sectors\n",
+			       zlo->disk->part0, zone_no, cmd->sector,
+			       cmd->nr_sectors);
 
 		/* Short read. Zero out the unread tail beyond cmd->ret. */
 		if (cmd->ret >= 0 && cmd->ret != blk_rq_bytes(rq))
@@ -847,14 +851,15 @@ static void zloop_complete_rq(struct request *rq)
 	case REQ_OP_WRITE:
 	case REQ_OP_ZONE_APPEND:
 		if (cmd->ret < 0)
-			pr_err("Zone %u: failed %swrite sector %llu, %llu sectors\n",
-			       zone_no,
+			pr_err("%pg: Zone %u: failed %swrite sector %llu, %llu sectors\n",
+			       zlo->disk->part0, zone_no,
 			       req_op(rq) == REQ_OP_WRITE ? "" : "append ",
 			       cmd->sector, cmd->nr_sectors);
 
 		if (cmd->ret >= 0 && cmd->ret != blk_rq_bytes(rq)) {
-			pr_err("Zone %u: partial write %ld/%u B\n",
-			       zone_no, cmd->ret, blk_rq_bytes(rq));
+			pr_err("%pg: Zone %u: partial write %ld/%u B\n",
+			       zlo->disk->part0, zone_no, cmd->ret,
+			       blk_rq_bytes(rq));
 			cmd->ret = -EIO;
 		}
 
-- 
2.56.0

