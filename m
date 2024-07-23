Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023076.outbound.protection.outlook.com [52.101.67.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFEA13D24E;
	Tue, 23 Jul 2024 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717787; cv=fail; b=MAlcHAdObtEA4Dl2l/fOdYJv0x2jZteNES67YKwhup1EKvDv2vLeAwOt9yXaquqmt8kXRkUXvhhfVNCEhYYZj+RnGYJU3Sq/isnupdQ3LzaWV+ypmH+3au9trwonsIYLc6H5TKWWDoanBj9CmKWE3T+9MN9P06uioBQZ8cH2uAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717787; c=relaxed/simple;
	bh=7iG+aKHhR6VE7PLXisGx8QutNOglD8jnMjVRzTny3d4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qAdvE4KC7K7Jdq9ri3jXFhJNscMU3GLfFYJ2r6+cAFmnIewkU8QOFzZdLKFBUgLrwvJu9UarTse890MHvSAUlialcGeQTzUQGlJVsgef5iuUdbHAcfcwpljmA1fCpxMJH+f2jq/PRKnvmyaPrrKzzlJ4ot+5eExxn4BiOkGhT58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=J+NapzJ9; arc=fail smtp.client-ip=52.101.67.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="J+NapzJ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhBW3EV+08rV+Ja5gXCKZR74X4v//MAOpOYBCQznghxvRk1Z2+423SiR0isYZ0neYCBNyXuvFegPa7gYAbbBhddfo0dQA9/afq6pXbT/wZFiTQsIUXco6tIMvAe9Hx1itSZnAp/LWdWZUIuElpa4kQ+1Po2iyK3V25dJR4uXBqMJ533/ZD2Rv2Jen8yXambC/O2D2MccETV3J5pixCm/9J/hb5r5zniQefdjSI8RPRogHmacHCVlnvE+gqpP+AkgLQSQ2M7+DM4zcgcF5JGQqRVodEB5n5P4UrVn4Qy+HadGZGIp/248pxOxQCl0Yg5cqMrYObuUrFB5yHj9M53DaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIeglkQf2Ce7nUekoDC7ByWrJIPsL+R+qVXXvWoowWE=;
 b=hvi2pqpG3+wSZKpMTNRnphIp93LUURqMK2sjibzzzL5tuZKANRl9+jxOmA/zdhhnDDUw26WbLv0wBstsvhbVrsU4z3a5p/XSZx4hyKtMqRMAidtkxYxJIec3bMeS2pKyKIOoEjZvscOs71qL9VgTQXvNjhF4PRURf8DzC4hma+6daRhclxeP5Tcoikk0UhPYZE+PL/cUXhQAPjOWAOnh1I8oJMeHREyVOYQYd1mH2r1CotO8OW3ZqYyW6WXxIwnhXotUq6b7zjr3ISPV3y4q0fPGnt7hIZfMoEJ9Nlycvt7Tm5RRz/diD0Fbs0UVs51Xl6jlsdmd/bFxgDKD46JalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIeglkQf2Ce7nUekoDC7ByWrJIPsL+R+qVXXvWoowWE=;
 b=J+NapzJ9ZteDAd3IvVLpw7H2BWy0G5KS4Xmc3PZdv/Fws4xcQ5QuBXBC+fhriE66GOxkk+DxQ5Lkgo4gVHter5nns0SRaCPsCGSFG96RkcEBebzs4PEtQ6mdmaMXMOYyqYIPswzvqTp0ihi6Gg/9XMLm5tm5mZeMfssJ34AQhp8P6c4pihc+fmqSXDJ/YEnFHr1u3BGMnzhrzMk5Txtn/qqFs+d3VYzf62nPfTsAI3FEDfpBzJ1OhC4OrMMxbqdIeJqocJ5dBCn+INUN0AyIeTMBW8JXHeYLQ1+t14mMCVY3fzMolZRWPP9VzOaH+vOvpvKTEdgHLKSVEcWUhzopgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 06:56:20 +0000
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7]) by AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 06:56:19 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: davem@davemloft.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com
Subject: [PATCH v6 0/3] bugfix: Introduce sendpages_ok() to check sendpage_ok() on contiguous pages
Date: Tue, 23 Jul 2024 09:56:04 +0300
Message-ID: <20240723065608.338883-1-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.45.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To AS8PR04MB8344.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b3::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8344:EE_|DBBPR04MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: b585b092-f820-43d1-c6d5-08dcaae48e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkhuZXRFWEVBWDI4cXJlRzBSMXpwYjlWeisyR2ZpemFyVWhub2pTK1hHUFZv?=
 =?utf-8?B?OHZsTXJHa1pINTVHTFNuYzZXUFVVVTNiL1ZwMjRQMDF5emNpQlV1Z3U2em15?=
 =?utf-8?B?MzQyTUROVzFvNXpZdHAvZU1DTlBSQ0Z6Q0diZ1hrN2hQMGYvNFdlaytJSWNT?=
 =?utf-8?B?dDd5dXVWSHJWbzZOR09xL1Q3MEhOSEZDaHpXUDdSWVI2Um9Ebkl3ODAvY3JS?=
 =?utf-8?B?TGFqbjlNRjhLNTFUOTBRaEVDYiszT3U4WkNaZld0cUhGZDdUcTdQMlJ5eWJ1?=
 =?utf-8?B?ZHBRVGNJRGxsZzNIMmhHOXYzVXo1Ulh6cmd1Zk90Y1E0V2hlaDRMTXFzSFBx?=
 =?utf-8?B?bVBCdmthZUdmem15VXpsSDc1dDA5R1dicUpFbXZvWVRpM3RzZWNqZmdlSlNx?=
 =?utf-8?B?YThoejNrNUZBa2JzRS90SjYrL0trRyt3WDR2Y1pQOExJdmhtUCtaY0l4T1FQ?=
 =?utf-8?B?Q2ZROTd0N2RUM243cWxYVDFtVHZtTklWM2NpTjJNWU50YWtpQTI3d25BZ0pa?=
 =?utf-8?B?WnBvdjhpcXVWaUttRFpZUk5tQU95N3FyL0MrYzUxUU9XQTRQU1dkdzdMU1JN?=
 =?utf-8?B?akI2WU1DdGw2YnVpbGhaZnhBL0RVN3g3VFhPQVNnZTdzd0E0bEVBdWJGaTJv?=
 =?utf-8?B?bFMyK3E2dUZhUTR6MEtSTlBjVWM4aDJsYjRLOUhkRHlpV3A3QlhMVktUeVpD?=
 =?utf-8?B?V2lIWHcybEFSK0d5TVJTbUhFRXZoZFcxb2RaNkhaOGptRnNudHVpaEhGYXZ0?=
 =?utf-8?B?V3FTMTZYbzdFYTdHQzlLMGhZd1k0Y2JNeHFadmJCUTJIbXdBclpRV1l6eFg0?=
 =?utf-8?B?OE9CaHJMVzh6RHRjYlduSXZQd21sdzNJaUw1Tk9rMGtiSnFvRmlqSHVEdGV4?=
 =?utf-8?B?Q3o0aE9YOE1wVWpuKzVWeHM3d0kvL2Q0dHliVHdYekZhdGZpeGpib1BTSkcv?=
 =?utf-8?B?YVlhTmZsa3huaHdTQVEvRnI5WnpoQThHVVhvWXlKekxvOXBtVVZHZVA3S0pT?=
 =?utf-8?B?WDZjZkgvZTRGN0R6V0VyV1MvSWxHR1NsNjVoVnJON3hQekdySmw3UEhxdS9T?=
 =?utf-8?B?a2xOZHJYZEhKQURac2p5NEExVW9JMXlSQWZ5SGV4bTRZdSt5dExhcTJHZCta?=
 =?utf-8?B?eHN1czZjVW9NVFZiUEtqUWJGTGV1SWN5aWNoVm9JRDJJeUFCeU54MkZhUno2?=
 =?utf-8?B?QVhOeHJnaHlGM2pyUTNkamVqR3RuRjhLOTdneDBST000ZXlmWHR0TVFBaUJo?=
 =?utf-8?B?M29CaWF0M0FrUGliSlF0WjUyZGZZdXFCczcwTStLZSs2YlY3NDgzRUF4aVgv?=
 =?utf-8?B?NC9WRk1weXEvZW43VDI3Q1pIaGV5TTJSNWNWbmt1dHhCZnNFNUtvVjUvRlhB?=
 =?utf-8?B?cTYzc2hOdE1xS2F4ZDhmY2NDK3pnOStxQ0phZEpzUGtOczJiaGk2MEJmMS9N?=
 =?utf-8?B?NUx1WWZhTlZ1bUIxUG94eENvWUxFNHNkdFI0WGlqUGxEVmNiZnV4NUt5ZUd6?=
 =?utf-8?B?UkF2UTdLZ1BSd2FzckJodU1XMDFTWnhJU3llT1NiaWM1dStKUmIvOW9UMmxz?=
 =?utf-8?B?eDFhM2tHVVhzYXlwck9XRmFlZzlJNGg2MkxiQmd6MEw3SE55TjNiT01sM0Rv?=
 =?utf-8?B?ZUFkUmRqWFNsWmFUcDNQOUNQL1pIMFI4cjB3YkpNZEVqUlFtN0ZkK1BTY01w?=
 =?utf-8?B?bTZ5ZENUZ1gwSWEzTmtSaFNJUGhiaFpjR2VXcUhqZHF1eDIvZ1phUCtHVTRW?=
 =?utf-8?B?ZTYwS0QyZU5xUjBEa2tXZnV3U1V2QThLVTUzang0M3Y0UG1UL3E5Wnc3MEdO?=
 =?utf-8?B?c25nZ1k5Mks1RlQrZEVVWGxzc2VuNTRGRXFydUlwcnpERy8wUml1R1FaaXBR?=
 =?utf-8?B?bXFNU05sZW92OHphdmlHcWY3cUxrZFd3SDd2ZVFlSm9jRUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmJ2eDlFWEZJMm1zSHUwRUhGeTE4R2hmUXVOR3BjUm1sa3dVYmxRcVhBZFdi?=
 =?utf-8?B?NGsycVduY2FUbEcxUUZHcHRsNmtINGRZOEtYbTZOY1ZiVW5xRGhBZWNsM25N?=
 =?utf-8?B?S3laSEZOMzZvVDhLWFEyLy9YZmFBRmlLN01MZWpLMG5RWXpmTGpXMEk2dWpz?=
 =?utf-8?B?d0k4aE53L1RqTWxFRWxGb3V3TVlNd1VLZDJMQm9YQk0rTklxN1dkci8zVGhE?=
 =?utf-8?B?bHpNQUpCNHB5OWF0ODlvYmNkM0Eram5XVEFjTUVNU21OSE41MHNRclJBSmdF?=
 =?utf-8?B?SmI1TWhuRHZqUlczU2tiMHNGNU1Gbjg5ZzhOakV5U3BZcVZvRDhSNjlFVWlk?=
 =?utf-8?B?M3NqMjVlNkROQVlCaDU2Yms1c1VzWEU4bmZUYUh2M3FPNFpJM2NVcmtRRDNG?=
 =?utf-8?B?TlkzWjJFUDNmMk9LS0VwMzZzSWIzelJTd2U0bm5OdzMvS0lRNWYvSVUzMlFO?=
 =?utf-8?B?UXRRaHJhRHRhNG10b1RYK1g0VjhWZFI3Um9wSy9PeDZldW81WGpWdkU4TEdx?=
 =?utf-8?B?MVFhL0p6MWNZdEErSWhNNUorUWplUGIzaVBLYitpV1dQdHpDblB1RXZtclVX?=
 =?utf-8?B?UkdydCs3VXBpbk5Zb0l3ekxYWk5wakkwaTJsQVI2UmIzbisyNWdoUDR3K1hK?=
 =?utf-8?B?RFl2NlhkK21tQWt0cHhucGFINkNhajBPNFlmUkZDaXZPaEJKeUlJV2NTZ2Qx?=
 =?utf-8?B?c1hmN3FGTlNYR3hLOGpwcjUzZDNza0dqeTE3NUpGdk96MmFQakZoT2RDV3lR?=
 =?utf-8?B?UUtxZlQ0WmhscG9jdDgwODZvSktWUFM1SU1HdG1DUTRvK1VOdnpZajNOWlcz?=
 =?utf-8?B?YzVaRTRwdTByOGVDVGk1NEt1L1lHMGdtSCtMcG5TOVRhZ0lSY1lFNlhmdEht?=
 =?utf-8?B?QlhVRWo2NU5KVzRoUzJsOWtVY2RHcXliSWJKSmt5RjBtOHZRb0FnbEJEbThx?=
 =?utf-8?B?N2t2SkZwc29RbzdiR3o3dEpLdXk4OXkrUnFPN2ZQZ0ZRR1VyOGUyYmRBTjZt?=
 =?utf-8?B?R29vU3p0Y3lXcVhMN1dCT3QzenVnZVhXQVdxQjBqbzhZajYrRDEvZFZvMjlC?=
 =?utf-8?B?ektSNUp1V2k2Q1FnRVY5NjF0cjUwU1REM2NGT3Q0RXRQcUtOUXZqZ1RwKy9J?=
 =?utf-8?B?ZlljckRBS2dqdm1ob1hFY2FYeDJLZjVIYURSRVA1VFBxamtzR3FuOUM1NmRO?=
 =?utf-8?B?STRGdTloTTkvNWZwR2xJRWtvN1MzMDFsTyt4ZlNSNDUvUnQzdFMyVVdMVURM?=
 =?utf-8?B?UzRPOG5SOTg1YlZuMXY5anlJWFNtbWZuMFBsd0U4ZE5Vb0xXeExXeTFZSlUy?=
 =?utf-8?B?NDFDT25TcWlObStyd00rUlFSeXphaCs0dFFhZ1RaZU9HeHQvclpDSXpreW42?=
 =?utf-8?B?V2l3NmtEYzBHQXNpOVIvMG5QTG5GOEJ6V2Fpc3hGb0tUcDcyNTR3S1dJY00y?=
 =?utf-8?B?QllTNDRFUkNBUDQrdWVmMk9RaWZFd0RMUnFvU1pydzNlK1FUTWJLczNkV2kv?=
 =?utf-8?B?aW9sR045OCtSQllUTHRDemc3SHl6cFJnYTBSQndIcHJJTzZoS29IdkxmYzlS?=
 =?utf-8?B?MmZ4Y1lRdngvU1Vxd2FMVG0zMDNyMEk1eU1NNmVaQUM4WlplM0RKdzZBOWhT?=
 =?utf-8?B?bWw1UUpaUStzY3JqS0g2Z05uTGhvUkV0UjVMTjVVYlJHMWpoRnBIT1FDTWoy?=
 =?utf-8?B?RFB2cGdZa0hzM2FHTDhyTG5neDRSWEhweDZVWmE4WU5nYWZJMDBoVGc3aEE4?=
 =?utf-8?B?dFZHd24yRGRyOGRwMGMydDF2Q09ZM0Z2QjljSlNodXZQU2FONHRJOFdHbEF4?=
 =?utf-8?B?THZDSS85ZnYwRmZJdVFlb3hzSjE0TVk1L210NW9ENmsxYTJNNUw2aEU1WHJC?=
 =?utf-8?B?VGpidnpVYXJTdlFJNkJvOUxEWllWY1FaZVZzdThyRTVnWkx2bm9VVXNQY0hq?=
 =?utf-8?B?a1VqR2hjREQwSzZpUk5xY1MwSUFqK0dFZXArWnJuTXREV1VLL0hGb0ZEQkN4?=
 =?utf-8?B?VHZrdUpwQWZhamkrK1RiMmQ2Ry9pWVBITjFOSWNURnRtRUE2cHJzeUZKOGFX?=
 =?utf-8?B?ZkVsNUZPeFFQVUc4V2tKN3JLdnl2YTd2YUZCdTZMMk1TakZiME1Wc0VwTUR1?=
 =?utf-8?Q?iGpyB/oAtCgBQ3aoEYvVaUNJn?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b585b092-f820-43d1-c6d5-08dcaae48e30
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 06:56:19.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yuicnl3iYa2BMTND7L2XkbShOO9AYf4s0eidFDWwg69BwAgAgcDmyJNLdImwcMB7UCW8lZHCZLWLq5LVEYj4Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044

skb_splice_from_iter() warns on !sendpage_ok() which results in nvme-tcp
data transfer failure. This warning leads to hanging IO.

nvme-tcp using sendpage_ok() to check the first page of an iterator in
order to disable MSG_SPLICE_PAGES. The iterator can represent a list of
contiguous pages.

When MSG_SPLICE_PAGES is enabled skb_splice_from_iter() is being used,
it requires all pages in the iterator to be sendable.
skb_splice_from_iter() checks each page with sendpage_ok().

nvme_tcp_try_send_data() might allow MSG_SPLICE_PAGES when the first
page is sendable, but the next one are not. skb_splice_from_iter() will
attempt to send all the pages in the iterator. When reaching an
unsendable page the IO will hang.

The patch introduces a helper sendpages_ok(), it returns true if all the
continuous pages are sendable.

Drivers who want to send contiguous pages with MSG_SPLICE_PAGES may use
this helper to check whether the page list is OK. If the helper does not
return true, the driver should remove MSG_SPLICE_PAGES flag.

The root cause of the bug is a bug in md-bitmap, it sends a pages that
wasn't allocated for the bitmap. This cause the IO to be a mixture of
slab and non slab pages.
As Christoph Hellwig said in the v2, the issue can occur in similar
cases due to IO merges.


The bug is reproducible, in order to reproduce we need nvme-over-tcp
controllers with optimal IO size bigger than PAGE_SIZE. Creating a raid
with bitmap over those devices reproduces the bug.

In order to simulate large optimal IO size you can use dm-stripe with a
single device.
Test to reproduce the issue on top of brd devices using dm-stripe is
being added to blktests ("md: add regression test for "md/md-bitmap: fix
writing non bitmap pages").

The bug won't reproduce once "md/md-bitmap: fix writing non bitmap
pages" is merged, becuase it solve the root cause issue. A different
test can be done to reproduce the bug.


I have added 3 prints to test my theory. One in nvme_tcp_try_send_data()
and two others in skb_splice_from_iter() the first before sendpage_ok()
and the second on !sendpage_ok(), after the warning.
...
nvme_tcp: sendpage_ok, page: 0x654eccd7 (pfn: 120755), len: 262144, offset: 0
skbuff: before sendpage_ok - i: 0. page: 0x654eccd7 (pfn: 120755)
skbuff: before sendpage_ok - i: 1. page: 0x1666a4da (pfn: 120756)
skbuff: before sendpage_ok - i: 2. page: 0x54f9f140 (pfn: 120757)
WARNING: at net/core/skbuff.c:6848 skb_splice_from_iter+0x142/0x450
skbuff: !sendpage_ok - page: 0x54f9f140 (pfn: 120757). is_slab: 1, page_count: 1
...


stack trace:
...
WARNING: at net/core/skbuff.c:6848 skb_splice_from_iter+0x141/0x450
Workqueue: nvme_tcp_wq nvme_tcp_io_work
Call Trace:
 ? show_regs+0x6a/0x80
 ? skb_splice_from_iter+0x141/0x450
 ? __warn+0x8d/0x130
 ? skb_splice_from_iter+0x141/0x450
 ? report_bug+0x18c/0x1a0
 ? handle_bug+0x40/0x70
 ? exc_invalid_op+0x19/0x70
 ? asm_exc_invalid_op+0x1b/0x20
 ? skb_splice_from_iter+0x141/0x450
 tcp_sendmsg_locked+0x39e/0xee0
 ? _prb_read_valid+0x216/0x290
 tcp_sendmsg+0x2d/0x50
 inet_sendmsg+0x43/0x80
 sock_sendmsg+0x102/0x130
 ? vprintk_default+0x1d/0x30
 ? vprintk+0x3c/0x70
 ? _printk+0x58/0x80
 nvme_tcp_try_send_data+0x17d/0x530
 nvme_tcp_try_send+0x1b7/0x300
 nvme_tcp_io_work+0x3c/0xc0
 process_one_work+0x22e/0x420
 worker_thread+0x50/0x3f0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xd6/0x100
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
...

---
Changelog:
v6, add acked-by tag from Jakub.
v5, removed libceph patch as it not necessary
v4, move assigment to declaration at sendpages_ok(), add review tags
    from Sagi Grimberg
v3, removed the ROUND_DIV_UP as sagi suggested. add reviewed tags from
    Christoph Hellwig, Hannes Reinecke and Christoph Böhmwalder.
    Add explanation to the root cause issue in the cover letter.
v2, fix typo in patch subject

Ofir Gal (3):
  net: introduce helper sendpages_ok()
  nvme-tcp: use sendpages_ok() instead of sendpage_ok()
  drbd: use sendpages_ok() instead of sendpage_ok()

 drivers/block/drbd/drbd_main.c |  2 +-
 drivers/nvme/host/tcp.c        |  2 +-
 include/linux/net.h            | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.45.1

