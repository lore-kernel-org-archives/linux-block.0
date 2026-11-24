Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528235;
	b=P1tMnHhsISKGdZZK+c6kKlDHI7M/1nBX5qbM7/qpfF2FhTOT/Zp/zDPb3ri8jporlPgk
	 KugOQY7yqiG7zk1d+1QW+B/jOraXhoW41ETwELvkbYH3fZd/tco5PDHGXWnL8pBzD9dKk
	 XDoQ+kCs2Zfu+K/9UbyJwy4r/6Pi6/2NACrvAKN3UcHPmgmq9kfeI7+5xnJoaphGn3Oz0
	 ggYxqGsj7dqP2cZJTT4qhwFITp53hAyrXXir60pw1bwQ7/hiFy4LG+pG9e9yY8MMpg1Zn
	 iIIZV1Uv8XlYkR6ysiWw7Sj75G1DNJvfJoyNLdvyy/5D4GAIyueySJIzJEhMbk3XEIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528235;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:WDCIPOUTBOUND:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=iZliH0cDpW0oJxG0/cBrCvY6EuInKCDMzC8bJLFy+wQ=;
	b=VbEsxBmgSG7X+mjdAHfbps/ECsXA7TeWpYgcfMizoXXRX/IiRkuapkhXG3awGSuyGw0F
	 EZ+XVtYd/kqK57PCBg8gz46avTxM1SunOVyWAgpmZpmc6WJB1/ltBtKqnvp12Q9VEzZtz
	 T1COp6kVwI8ZXdnRer9YoPkxWCLmwkYzL15BYBR6u9RJNpthaIFanjVrvRs6cp0I0IoHw
	 9YQNgOdUme7XOr8myrFd4640Uqw3KyB2QtpYgX+MpdxuMMmxjfI0YAJh19YMG9ZEb37tA
	 PUqi/NzrwdhWJJu2hMLxv6lWrTansmY3MDMx94KIGlJBey3ylXzCqEFLUlotmrn5D/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=iU+JVoX7;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=CTwBzBsv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B58606A321
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 13:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78B58606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=iU+JVoX7;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=CTwBzBsv
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795528235; x=1827064235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6lefrm2PjPoZCns9UBFAYID2novnk3gF7V5NXb7pVRI=;
  b=iU+JVoX7uDJKSsTdq1c8QL1tlZURm5/E+imdj14am5N42a4S54/JUgAF
   0D1AHMlWLmePewtsEEtvOvfw4SslpIKJNOzwKmzr+Vh3aFf4+gzkoIEeq
   0C1few4wrLduWOXuDapAc28KaCrdGCuJBfkUZYlcqaBItpv1dnFxo23HV
   jGqJSE210NWsVW+1pCLVjz8W8YDOE5mggh+G4ZS6dnMr3I4zCFE+AxaDs
   FGDkTEo9fBmrMXqaV9drSDwsXCDpm5uBn90Kg4GpoQtZyHFBZ72HMkVou
   9Ouk/cYktPyVIbi67kiKx9e8hpidhzerIsoKPlSzJy2lbArNMZsEgPH61
   w==;
X-CSE-ConnectionGUID: g6NKVCijQNipB7+NkRNv+Q==
X-CSE-MsgGUID: EYzwhIXmRJG6FXDdbf3RQg==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161651027"
Received: from mail-westcentralusazon11013003.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.3])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:50:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnLbKm9QsnUOfWELdW8sx4xqhXPD4h5UfroozMSRvos+I1+VbulsE4L3u5lSpBxsgPr3DmPyjYjcey/dGga0YXX137v+TmxPcXjUEjh6VyBBZxq0KJwH9cKuw4rGG8K58hB8PPOsCqq7pB72UqA1eunAmjxw23qyfY6QrH4+T9n/gOveqT2858ShdxpCk3Xb8qznQPVEH0n63DznI7WtkLFiK5kAqHUqafjKMk9PlQ7o3pnshs8h6UBKsRa8nUUq2gbiYD3oAmchlz8dwNXBF7yPcM+I+NdSQeCcqIG6Vmh+SaxhillZxQRwhFILA1H0k3iWSEdVe4/7MBUPEeKkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZliH0cDpW0oJxG0/cBrCvY6EuInKCDMzC8bJLFy+wQ=;
 b=TTdfLbOiGeVSQ4ea4368E0qMqXfHHI2477C08MMCj9r6nWuC7BrDbhqapFPvhf+m61UlK6swdY6vhB4sKAsZSfqfvCZB96O1wrGU6GyR/lOZFEds++k9WpQUSrFbFdw2bDzsUKMfNBjQsH3/0N0IBc6HJ9qYeb9F2Jqg8KXdfH+KE9ch1cjJxZJ16M32fUvd1AnFecJi0yo3CJvKsMiFCJ+asQ0Smisp9QMh6+o2PCNVrHpQ+R2UR7kA2jUcTyQY0lsqz+phOoe30+Sr/yPh01HGbEmuUoCHqObm3YQ3Sz5eNRRg4X+AsFh+ypf7zuzpgJMJP0uj539N6/AQPkLKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZliH0cDpW0oJxG0/cBrCvY6EuInKCDMzC8bJLFy+wQ=;
 b=CTwBzBsvHRN4Rqh9Lqk/a3cKmrLuYXpDV7rNOh1C2sSg47U1E/7T3OhvLKejKchcWok3/7xCvCE8wbcLLusza6V65rZQnmQLF0VKRrA5FbXdyQTwBVmec+nyk/7D11BN6xrCatF2LbUqTXdeaPbxSkOsvziLqjIP7wMLxNVaU1w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BL4PR04MB993740.namprd04.prod.outlook.com (2603:10b6:207:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 13:50:33 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:50:33 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/5] blktrace: check that ioprio tracing is opt-in only
Date: Tue, 24 Nov 2026 14:50:14 +0100
Message-ID: <20261124135016.153657-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124135016.153657-1-johannes.thumshirn@wdc.com>
References: <20261124135016.153657-1-johannes.thumshirn@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|BL4PR04MB993740:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a74ad21-0f6a-45a4-c8f3-08df4a31e8b7
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261026140227099003|261021121427099003|261102123227099003|261022113327099003|261009223027099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	qRgGeJXitTnRqaRWYSTddjha0qNFQaCqsgo1Cxqf+03qj37qBMIsQuRUwbW6KTjw0IycU66MI2G4GRk80R+PZGkeZlk6KqIt0DwmHxxaBviZBphRuLEfJ9bZyu2R0cX04b7Ee9LNmhGcTbQQKdnhO5TfJrFMZwqFtJb50K7eEGuPaI78r+ugd5LGc1asrJU9caC5e/3LPEoi95YDL8yOMqpngSgMUuphajavaUNsH0pNGBpCf5c2+OG3/iAU2dWt8gtPfeBiWFXS1zQ/uzNX7zaTFySD7xs/dA9xiY3uTe6Ib/e7JYmSXiUYUJ0GYEEEIVHeg8/+rQRaJxN8z81SPDwF3D4Yfk9tVaokFXE9Sig/KGmV/j/Mys5aC5QuwOEDE2YHJzlRSNT3cKP+I3JnJwpINwIHXbDXS/AeZUR5Nv3KjqHGIHewPl5U3Gw+0xhNA7Uh2PCvB1z21AfrUV1SwYmJqg+nBtSThNRt6KPFiVpBYOgjGcn27WwX6uI0jQZWmZJeQgSroVNXI6Mnir419rX0uux0uy2a1pokldeZbF+05epXJL7b2tubmH3tn0RVHbIPTcBF6yx9nZPbno53we5SvCsZkKmYsH9chLgx4NL96uVbKMUBvAamqCsIvJ2g+CDOzJcEaLyHDsvO+dsTojhzDr5lnuKOx43iMPw5CF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261026140227099003)(261021121427099003)(261102123227099003)(261022113327099003)(261009223027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iJMB8KavSPPGRrQ36ipndRMUxe13mhHSFIEFBw6n+std3wKZ7FvV2bfkaXbv?=
 =?us-ascii?Q?jZ7XDq3IvwFLbwcoYoFIJOuepiAhXkqH4Zwzd9tbtHQMPFdlHBmwKcA4lIEn?=
 =?us-ascii?Q?Q1w3Z424o4dObDYz6ZiEUTw8IjdPHeA7T89CQ4uBSGnHsATYsM2eJ4ECN6lV?=
 =?us-ascii?Q?IWqbS5dgqcLY5u8eaZkNlkQATxAqjOSEP4kMDlru7Av6N9ILoF4/1rlDnoNp?=
 =?us-ascii?Q?b5R7p+jGyftX4rWg4YQ+QRiI60dQWClCoqOnC9dYmpg4dGoACnQ8/spja8yr?=
 =?us-ascii?Q?s+3KAuDXDZ+BDAMYpmlL+NONamezIDJbDz4H2FNGNVNZfqMYItxuJ7zIQtV3?=
 =?us-ascii?Q?wboQwUCSqpyh+rynGsWdGcaBavRwl33+1SBne0DPloPTrsUTfS7tWMmuD37T?=
 =?us-ascii?Q?b7K6Mlbg64eOqEREsmTPTOitreIY5zBl7AdBpH/7NJju0xfgHuNytc/B5Av9?=
 =?us-ascii?Q?KQ6ncSWYolWr8qNTtK/M3T4JeDFBWLZEIKoBkLLj+RL07ISelue1tHO2lkS3?=
 =?us-ascii?Q?q1WZLGiuwqM+dTExA+2ZVh1ylrAMfjdo+TlwhiND1V4ifmwvfPyedlrll9ed?=
 =?us-ascii?Q?FSMv+Ox8WIlHuPIQ6kmE+pH1fjYKEt6hCYzkEoirb0XI6NsDdaAl1Rxf36F9?=
 =?us-ascii?Q?9Fg+00yCeF99iY58Pl3ZxB+/HTQpyxXH+hnA7EoI5OMoX6zkCMGiMz8w9qaI?=
 =?us-ascii?Q?5iHo0Cx6d9KwlXn2KQxgLyAGQFXX0gOlD5nGNCawQ6R7Iom9GV3DVQnBnLDp?=
 =?us-ascii?Q?eUtF9XLrKupNUzHDcaO2hP/E6isZcfEABs3XI96Fr6+6KiPWX+Km+fWskSv/?=
 =?us-ascii?Q?FlBIfQEmLygoujXVIukeRUZGlnCI9Kr9mKfN/SF/u9ow7DRYcnAdL/UMyRXo?=
 =?us-ascii?Q?TMTVyFetT/T6vtMe75+EYaA81Z3PWaI/tlFJYopcMZUlPcgUWuol8kVVmCwH?=
 =?us-ascii?Q?0LdxWnkt8038ZYq+UANR9NlzM/tTr+1TRKLdDD1CULVJvEPUdAJIH6rRkCTo?=
 =?us-ascii?Q?bMHE9mU7C6VKo5QCmbs4t+PiA+ESt3W7k0S5h+GliJNjMVtuGFOzypspOnr1?=
 =?us-ascii?Q?++dbVXRdsYOx3vVURCMIdNUtTBFq4dEahNgxV3WphAqTGcx3CZFWnohSJUXW?=
 =?us-ascii?Q?jvdun3mUrU3yaJHvzwwgEa2cjxcUDXb7MumFBiEMDJc/YCQsNGyIhV8AGIL0?=
 =?us-ascii?Q?vv8U4t7/Y5glFTRPY8aplqI0Ui7BI/uMAPLDWS/sTvE4sv9pUZSS/mXT+UHl?=
 =?us-ascii?Q?aZANIzXZrJPBqpkhpZAMCXGElbfaa9i2PRiEtG9lL/RUQHTma477/NhZw7Y4?=
 =?us-ascii?Q?5OOph4l1pmpE2fgSgBtpDt7ZSJvPu7loZJFq2bmTTHbFTQbtFjzO8d7MGhyX?=
 =?us-ascii?Q?G2y6awgi0qvw1ty+abfCfr4xDJXIn6YyBZhC+YaJTkMXytSv6wIqFmuaFVdK?=
 =?us-ascii?Q?2iPYRLuKb1GPNA0uyO0BDCojD8Ah+WmshP421pMDE3rHtcx0wCgLc+TwrEgP?=
 =?us-ascii?Q?gip7LmECxZFzHf0Wad0h1IkT2nWIslgpvakNMWCA/gujMRHjsp21rvQRWYTp?=
 =?us-ascii?Q?lRWa8K56fuwQB+w06vif+euvncvLzO5Mh4gU3m/+pepFcc/CFWEu0CWJ81DE?=
 =?us-ascii?Q?KRhgJhLh4V3ylNnSzhPc7NM2tsktrQajmfX6OYL+KHQFem2P1KQBpHCJY304?=
 =?us-ascii?Q?Buk2M/X3s2reH0oORlB5eSPxnyKhmkhJFWcuB6h0DZYzSwg7WEhxwsvYHLL2?=
 =?us-ascii?Q?iBZcGFMABU32t8jVrh6dnB0OMPt3nxHZ5BToQ5x5Q6Al7/HqfYIs87VqtPBE?=
X-MS-Exchange-AntiSpam-MessageData-1: N1d8wS06CIyIvajn2jHnLDrLCZxg7HEIPRg=
X-Exchange-RoutingPolicyChecked:
	NIWc2VAgPfdiFjQQc/PwxmAStmtQZIMLTAKPRwEtJwmkt9I1WV5Rt+3ZTqfrDAfCTEl8lq3ZivyK/k+tWNA91BkXO8Sld716bzWxBnvwyBF5p7nwULl6WO1mX5jpCrlZPdYhcIdLCeyEnzZDzFMFFNFQ6idkmeHjPwhM2+XnKji2XBRfgpYnFuXcjC5s5FtUjL3V5m5LNp1ymwW2Oer7NhybwnH0Nhh5L7T2c5rinbY0jBdc0Xd3+gNIwlKvGkmdJXgH4JFR/ujLjKV26FUW/12P4RLq49bVu0FFYx8i3MvP9RgmY1nk14nJ0Quy8Dhqmd2Z29gkmhZULuzU6rujLA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bcRATg+hMIxrSHmAsgOUHDs54cqy2UDyNfto8ouNB6KD50ndgwuUcHiRnPktjOoTwTGOStO/iF66y/1y0fL3R6cx8gPKqECBAxAf/fWByMBmbT4ToKUcEujgxPjbGoMPmF5d+zYAdk8DIf9I/RGzGZVzD/qwjH0lSIZZDb1VoCvrSbMOTDoW/gNPcvZRZqRHvXwOwA0xW4PSqFgp6qLzLZq87UlXqKcT5g/w0X1J7/J0/DKp/0GHi0J3FRiw3THlOss3m/hfNJBz8Ktcdvdp2S35SgO89Mi6cAfLVkM/W5L5Yl7/tDTdDp2qMg8mGLFtRJG562w/q0HUkMGcJwpWdrXD0sWBu2I+cUtgb8PmDaC1qIxSFQJerd9h1f1SpRsb9Kj5JJ8NF+UOUrQ5LZfljOpIuykAJSp8UuU23xWfxNQ16VjgmYzRgN6c2EJ+Wkkic+YtY5sc5UcbBGHPB0mTFb0L8vtWwOl600u+3m5LTxQm6jPxMlLAG6uKD078ODF7l6C7DKnmx7UZzSwdmKPxQgWN2SUypboXKXcv3mlZ/453wj5dVQ3Fax+raFEpHSiy/+otfA6FVSDko75q8lxzOjp7KHgw7y6Ia+4jwapKVzcYbO9ZZnonXIiExE9wzUO4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a74ad21-0f6a-45a4-c8f3-08df4a31e8b7
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:50:32.9090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tu2YCi0pyikMD2Y7Q5NNFFYU4VYKlD/vf/nclL78/WXb6qlSQTiywlj74BBMLKvRwobuPxdz8EHyRggp9NF6p4uFy/dog0FPvm9TVWyVYgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR04MB993740

I/O priority tracing is opt-in. Check that traces taken without
--ioprio, with both the v1 and the v2 trace protocol, carry no I/O
priority and that the default blkparse output keeps its old layout. Also
check that --ioprio is refused together with the v1 protocol, which
cannot carry it.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/blktrace/005     | 79 ++++++++++++++++++++++++++++++++++++++++++
 tests/blktrace/005.out |  4 +++
 2 files changed, 83 insertions(+)
 create mode 100755 tests/blktrace/005
 create mode 100644 tests/blktrace/005.out

diff --git a/tests/blktrace/005 b/tests/blktrace/005
new file mode 100755
index 0000000..8fddfae
--- /dev/null
+++ b/tests/blktrace/005
@@ -0,0 +1,79 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Western Digital Corporation or its affiliates.
+#
+# I/O priority tracing is opt-in. Check that traces taken without --ioprio,
+# with both the v1 and the v2 trace protocol, carry no I/O priority and that
+# the default blkparse output keeps its old layout. Also check that --ioprio
+# is refused together with the v1 protocol, which cannot carry it.
+
+. tests/blktrace/rc
+. common/null_blk
+. common/fio
+
+DESCRIPTION="blktrace output without --ioprio is unchanged"
+QUICK=1
+
+requires() {
+	_have_null_blk
+	_have_blktrace_ioprio_userspace
+	_have_fio_ver 3 36
+}
+
+# $1: trace name, remaining arguments are passed to blktrace
+trace_without_ioprio() {
+	local name=$1
+	shift
+
+	_blktrace_start "$dev" "$name" "$@" || return 1
+	_ioprio_read_job "$dev" be 4 5 1 || echo "fio failed"
+	_blktrace_stop
+
+	_blkparse "$name" -f "%a %S %i\n" > "$TMPDIR/${name}.fmt"
+	_blkparse "$name" > "$TMPDIR/${name}.default"
+	cat "$TMPDIR/${name}.default" >> "$FULL"
+
+	awk -v name="$name" '
+	FNR == NR {
+		if ($1 ~ /^[QGIDC]$/) {
+			events++
+			if ($3 != "-")
+				bad++
+		}
+		next
+	}
+	# Old layout: "maj,min cpu seq time pid act rwbs sector + n [comm]"
+	$6 ~ /^[QDC]$/ && / \+ / {
+		if ($8 ~ /^[0-9]+$/ && $9 == "+")
+			dflt++
+		else
+			bad++
+	}
+	END {
+		printf "%s: events=%d default=%d mismatch=%d\n", name,
+		       (events > 0), (dflt > 0), bad
+	}' "$TMPDIR/${name}.fmt" "$TMPDIR/${name}.default"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local dev=/dev/nullb1
+
+	if ! _configure_null_blk nullb1 size=1024 power=1; then
+		return 1
+	fi
+	echo none > /sys/block/nullb1/queue/scheduler
+
+	trace_without_ioprio v2 --trace-version=2
+	trace_without_ioprio v1 --trace-version=1
+
+	if timeout 10 blktrace -d "$dev" -D "$TMPDIR" -o v1ioprio -w 1 \
+		--trace-version=1 --ioprio >> "$FULL" 2>&1; then
+		echo "--ioprio with --trace-version=1 was accepted"
+	fi
+
+	_exit_null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/blktrace/005.out b/tests/blktrace/005.out
new file mode 100644
index 0000000..ffcd687
--- /dev/null
+++ b/tests/blktrace/005.out
@@ -0,0 +1,4 @@
+Running blktrace/005
+v2: events=1 default=1 mismatch=0
+v1: events=1 default=1 mismatch=0
+Test complete
-- 
2.56.1

