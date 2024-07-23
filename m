Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023076.outbound.protection.outlook.com [52.101.67.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF85E14A616;
	Tue, 23 Jul 2024 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717791; cv=fail; b=nS2rX8TpH366g/DYRXBOPXaqzSPZQpeC6UbybtzZMdJnKPtTPQqzgXel0o2CLoWGArCy3kVSdn/PTkHfHgATsqHmh9/eClY7fqmIoKiiCJHEn/LJOjDWLi+T4XVQyx4it65JXE+s5aGIKtcpf6gdgtsbW+ZWk8XPhCfts6UjeUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717791; c=relaxed/simple;
	bh=q/4FhTcQw8Ct3qXSg64D5CY8N29ave52dAbM4g5K8+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SR0x2DLjo4brm0PAP5o5aXulg/kDraMXhcjwYFh7zSlOBeGY/K9FST832eJrEBjIHKTSmUCtBVMqhSvFPxtnFXMX+aoGPp1+OCZm+mnIwR2BFZpbjNCnAVjg68jSeSA7SeV1G3a2uKzoMiTcSNUg4urnvO12byB6v2+LY5eHdgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=jQqDI2ZA; arc=fail smtp.client-ip=52.101.67.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="jQqDI2ZA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpaw+9uMWMZPF8Y38R9Se+n2e2caxD1eTNgiNwG0MyZnd/Hhek6l+cLs5GrfSH/gKCogB6UgQQq4M0TEi6CcKbf3qL/S2KqWiO10vslho9JrlNIgvBYBFjz66RxVJr0AWUEBbgIjW3JhC21di3gdz/gWdfeaAxEyppg20rTchm8cKt62Vdl0GzCOd277jj9di4Fwgpbj9mTcdERhf/Md49cxrQg2R6pK1k7krA8AvPX9sg0ser6Ubm3NO+dSjLO0+tCZGwYGbt+Q0HbokbuuVUCURXEP6knYaZZVNZVTLG6MdNRp2hxR3ckwuQYqBULyFth1Hg4sHFIxwMpTj7lPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZ0tWBiQ2iqQ8K+UeCzLmCv2laXrL4ME8WggNX5AW9w=;
 b=VW/onWWPBEUyysGXhsYtzpg5OQclUWaMxrPp/ov/iyPLSWoAwU/YfWctg9wEB8Q9LN1tMVU07RppSBQAdZvSS4erTYJJ0euJrG+0JxbKcWxiTwf+mCcxhsBX6lkE0eNYV8VkvJe+9ASGLRTtJy328TpF73+TvPdVEpF9mRMu82G3yL4b4wQaNELGnbREZTkkL1v5K46NmO0o8fQvRKCeSUzU6bMklzvBxKi+UdAQKuiwrkRGHveDHsvd9A/JEmBZvcTMw4HVLDFY/yJU+DWaIt1Wk/eaALwADA6tVS8T3KIwCENgiLYHKn6TxYkzC9l+28owrRHZl7JXW/ECmUNHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZ0tWBiQ2iqQ8K+UeCzLmCv2laXrL4ME8WggNX5AW9w=;
 b=jQqDI2ZAbicn8JxnRl0z0v0EgwB/XtvmmimVbNEBCuexs0i5N08MWndQIvxjml7zyRBxhx7KuVT2d61M9DY36Qey9T6vSFPOLu5S3dkmEpEj1M5cZUyodeBoU1lceNQbHOaLTjQKorD38OyHrJGt9E36M25CQtgdOqgvVlmfmL5TVS6dd4H8JDc9anCSWDpvAB50zNfwzykIeMSbgSIpYfEVHLaiO1w1mzvVVPOb5CbKkNl3GO4huO9rFYR5MN2lvJL1C+bPMoc90QtfJrhxfr/OrD7k/ypFVQTy/OuX1uSncv69BELNGvyBAaAlHzxSLwVbB+BLIPo7j6DProYpoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 06:56:24 +0000
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7]) by AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 06:56:23 +0000
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
Subject: [PATCH v6 3/3] drbd: use sendpages_ok() instead of sendpage_ok()
Date: Tue, 23 Jul 2024 09:56:07 +0300
Message-ID: <20240723065608.338883-4-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723065608.338883-1-ofir.gal@volumez.com>
References: <20240723065608.338883-1-ofir.gal@volumez.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4a455ec-78f4-4893-3656-08dcaae490c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGhSTU5CZVpIWGdheWdpY0YzSS9yQ0pnenJZelN6ZHVXQTU5M0Z4N2E0ZndP?=
 =?utf-8?B?c1ZtdnFUaWFrelVFQk5TcHUyK2xsb1BuVDNhS2EzWW1yTVpwOGJYWUZORnJz?=
 =?utf-8?B?N0dWd2xMN0MrRWhNNDB1Z3RRRVBxNG0xT2tvTkNOL21tZ2RkMXFJOXZNcTNi?=
 =?utf-8?B?emVxajNoRUdiN2t3TTQvVzkvNDZNR2NXK0VvK2xlSFJDNGhUS0EvemJpY0tl?=
 =?utf-8?B?SGR2YkJ1R05vVWFWUS9mNU5aR2ttVmszbFVvVFZ6b3JtV1NrY1JaemZqSlZD?=
 =?utf-8?B?Q2RRNDhQSEVpczE2T3orcG93RWRXSjlRNTA5UGZkTzVVL2xrTGdlUTQ2MU9G?=
 =?utf-8?B?QWtZL0REbWVMdHcwTTNNcS81dlRFTW1odVVLRUhRbzZQRjZEcU0wWFNxeUQ3?=
 =?utf-8?B?aWZEUEU1Y3c0UEQ4T2IrZjhQSWJpT1FBc25zZlVoTWdmUk5Mb0tVQ2dVbkhi?=
 =?utf-8?B?MEpDOGMyTG5NdjdJT0tSV3JHaFRrREVORUhtdEwzbm8rQVJYWkVxdjdXVzM0?=
 =?utf-8?B?ZkNUdFNBWnJKNXdBOHNuSVE1Skt5NUtUMU8vNCtydDVtWFhDY0s2SHhQK2kv?=
 =?utf-8?B?dHVhMHdPTDVaVmpWblU0S1czL0VkQktaSWxabHBPQjdsdUhLV3Fob0hXaXBG?=
 =?utf-8?B?UWxReHcvZHlidjNKU1lqWDlRUGdoWis2eGppak9Jd1dNcHVrVXVPdURHT3hu?=
 =?utf-8?B?d1pwd25MdkdoaHNtZUNWbVZ6NkFHTEZNeVdsUDhubVRxc1dZd2NQakpLUkt6?=
 =?utf-8?B?WHVzeEdCRDRLZ2VvcFFlK0VUR1h2ZUNqaFBKSWZIem9XYTNLTmRwa2dYSXJ1?=
 =?utf-8?B?K1IxMzVza3lVdUNMSE4xN0Zkb3NCN0N3dlJRTHVQMjlOMmh1WHpYWFcvdk96?=
 =?utf-8?B?L0tCOVlQWTdiN0lPc1Z3Tk43UGtyTWljTHhoMFFSZkJtVExTN0NEdkRlNkdG?=
 =?utf-8?B?ODZuV25VRldWVlZqM0pXeFJoK2FVeFU2Q2xoR0lOamRaUTM0ZWFuTDVURVI3?=
 =?utf-8?B?aXFWbVdZOVh2THRveEZyVWx5U3IxWHU4M3JCVnZtV2w3alArcHdQZVFkYUlp?=
 =?utf-8?B?REVHK3JTY0VvR24xVU93KzFZbjh3Y0hWTlJPZTRzNVhQN1lZQktMYkVheita?=
 =?utf-8?B?bXA1K2VoN0pNTEFCdHpIczZSUmhiQnExL3pRZThidDFRRjV6Vk9jVU14K2Vp?=
 =?utf-8?B?RjQzVGw3M2lVUU56c2YzOU5iREdFMWdPU3JLcFAvUE02VU5FQkV6eWVVMjY4?=
 =?utf-8?B?b1laMWhQcGFNQmdQZjZxZDExcTA2WmxJaUhqeXdZY0QzQlVIdFNTbjQzb2ZD?=
 =?utf-8?B?YWtrWUZhbnVHclpBQlUyemZsaFg5QlNXRVhkYS9vS0hFdlViVnFTc3ZQc3hF?=
 =?utf-8?B?dVNDa040RndKV0t1WkU0TVBxRlpmVlNOSG1IdkR2cjV2dVpFRDZ6NkFGUjNW?=
 =?utf-8?B?dE9nWjN2b01xN25SM1FhYVNoem9JN3JSeXV5dy9oNHhUQkRSb0pjRWtXa1Zi?=
 =?utf-8?B?NjVGODNtSnJJTFUyTUswOUxIZ3U1SllzR29VYmdhVmttRWcyVzc1N3YzRDg1?=
 =?utf-8?B?c1JMSFVDeGRQemdyMWRUQ0VXb0Q2bEtPbkpHeTU4WU8zeFladTZ1MkE2NG45?=
 =?utf-8?B?bzdDTDAySTZ3eU9mK01ldE81ejhuczZRWmg0aDdYTW1lRFM3eEJzZ3pXSlBD?=
 =?utf-8?B?ek5lNWFRYmtkU2tCOVRONEFFWDVuK0VvTVBmcTBTNjJzekNDOXpUQ0cycVUv?=
 =?utf-8?B?WjVOVUxiaEYyU0NITG1UcTNEVDRvd3dDQytPYVM4czM5RkxLUllOMUpuazVo?=
 =?utf-8?B?YUpQSkViNlA4dnNZVUs0NE81UGY1dzVIUURSaU81MVNISUFVQXFNQnl2ZDBX?=
 =?utf-8?B?amdKUnViLzVSWGptek5oSGYyY0tseHkvVnIzNmdaekNMNmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHB2WFZFQnVEb1A2R3NsM2NhMC9jcWt0bDNJZE9GakpxNGUrRXQ1K2dPUHJq?=
 =?utf-8?B?aWJXeE1KYlBybmZQdVJxanNxd3FCVUMwVi9PR25nbXVZVW1qVyt1d3p4QlJP?=
 =?utf-8?B?cXRsV1E4YStXK0sxdDA0dWdUdmVsUUhpeXYwZ21mdkNRWFZEVHFuMXhkKzBr?=
 =?utf-8?B?QTVkTHNKWEZwN0hUM1JBeWdYQ2FZZGp1QVBQejRoMnBiSlVtOXB5cG9ZVWNP?=
 =?utf-8?B?a1RkaVlSbTVJUHoyNkZmMThpdDE5MW1BL0FpTVFIbCsrMndwdG8rZ0VxbG0z?=
 =?utf-8?B?U0NrUmxGR1hnN292RmhYU3BEMjQ2eUZXeVBhT2JPTUFDdmovVjV1cjJZVUFN?=
 =?utf-8?B?Skw3UkVmd3psczgxRCthZy9QMUllWnhLb2NUNXFCL1JzU09ZbGw4TlVGcTJQ?=
 =?utf-8?B?UTFLdUpWQTdlS1Q5QXZwOVhjbVJhMkF0bFlzTEQ2WTdUaGxBSDhPWmxSZ2g0?=
 =?utf-8?B?RHhKc2E1RkxhNU1mUTZqTVc4QkxaOUpad3Uyb2lHUGNlNlNLM3hIMlJoNnYv?=
 =?utf-8?B?c0tWMjhhM1NPREVYMlFUVFZsSWVJc0N0WFdFazRJU29kZDFmY08wd2ZJeVhJ?=
 =?utf-8?B?MXVPRDhod09xTi93WUF1anpsWUVWUk5uWDhJbzYreVl4aHFpcTJ4aEJSeXRv?=
 =?utf-8?B?L3grMzRFYUVyWmpuVUp5NnJyOTNqbm9YNWN2blgya1NoS0FrU01VTlBIdU9q?=
 =?utf-8?B?d256UzVVcmhjOEhUYXQ3bUNKK3liS2x1VGdRYWRZVDlodGI5ZCtaN0hobHpi?=
 =?utf-8?B?bDNKa0w1YnZ5dmRUYUZOdFpMNnNLcFNjbVFDajRXeDRaTjZvSnJMQ3J6K0p2?=
 =?utf-8?B?ZUFsQlNNUWZlWnlMMW1BU1J1eEhQdWVOTGRoLzNuR0ltRkJhYlVKVUlsUUZp?=
 =?utf-8?B?QUxpU1BvNFpSTjloSmY0UWJJMklJNVE3WUFiQVpjakRDc254Tk16NkpnV2g0?=
 =?utf-8?B?N2FpOFQrWEtmVGdDZytLNEcvRVh1azV1UkZFTCt1RTY5V2xINm1rRksxZXJV?=
 =?utf-8?B?UWhzdTlkMVZ2ZUhNb3JwMmZWVzRlMzJRWGJ0M3pXL2tHb09vSnBoaEpUVGJq?=
 =?utf-8?B?a2lSeHBOdWEzOS80UURqazg2MFdKOVR5S05ObUVtTUo0d1dzMjR3SFdDdllX?=
 =?utf-8?B?bmd6bnA0Yk5EanVMcTFLTUVlL2h2Z0F1R0dIQVVDdHlIcG1jU3NzZ1AwL251?=
 =?utf-8?B?UjMwL05KMHg1WEczK2hTUTlhR21QRGtINlQzMDlGSTZYSVdqNzZGNEJVNmNV?=
 =?utf-8?B?Rm5wa3ZHOTNDRkJRSEpJZE5tbW1qWGpPVDhJQjVwY2VYQnZzMW5vampUU2ly?=
 =?utf-8?B?cW12KzRHaGszREg3WmFydXF4UXdyR2lacWtCMEVRMTBLRVM5ZWQ3ZENSSnJy?=
 =?utf-8?B?alBGbE42ZU5KU3FhU3RoSDNjUG5UWUt2TC8wbHVFaEtpbGNuQ1JhRjFZTlNv?=
 =?utf-8?B?L2ErY0l3Q2JjVXBKR2V2U0pSdDR2amxBZXpxZTdCV0xvZklaOThGTjVUMGND?=
 =?utf-8?B?bG5FS3ZSZ1htN0hEbURVcFhQdFJNT2tIdEo3U1hMVUJOWVczMURhNEFvZG9G?=
 =?utf-8?B?bnJzdEp1WDBCcTVhMnpHQk1FYTM5WDVCVk1CUGo0MTArMHJMdzRrTDlZMWlZ?=
 =?utf-8?B?L1NNZFJHekVwMWlvdk05UVBKa2RlS3kvMTU1Qmd0WGJjQVpjRkwrZXlrU0Fl?=
 =?utf-8?B?T3BpVUovVXZ4S3FDTUZiakNObTBOVFIrOHlhUkl3MWwwd21Vb0Y2SEQ1eGRQ?=
 =?utf-8?B?bkJnMU8xbzA0dmNEM1dVWldXSXBBU09KYzEzbGlJVU9rODJ0eUU0Q3F1dFBl?=
 =?utf-8?B?STdtdGhtcnNQMC9oME1kMGh6YlJOSXNEVHZLYlZ5U3BhY1h1SVNvWVNieHFC?=
 =?utf-8?B?QzYrbTUzQlRsWkwwTmU1dXdMVzhhZG8vYnp4RTlrTDBDV2JSeDRTVWJ1MWRC?=
 =?utf-8?B?UlhvV2o3WnNSejRoV2FaVUN5cFpsTUFVbUhTRU16YVNRbHNRN21kMWZhSGFx?=
 =?utf-8?B?dzU3MUQwdE1yb01FMXJkczNxSnZWbzgwQ1lYV0s5dTRUQ3JWUFFrSklKSE5Q?=
 =?utf-8?B?anIwTDRtTTVYS0UzaXZNNTc0aDk2QXpXQWRsR0pBWlhCSUhka0kxTkFJcUpw?=
 =?utf-8?Q?XgrVsr+7jwsNCjtZL9OE6lu3u?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a455ec-78f4-4893-3656-08dcaae490c8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 06:56:23.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbnasO5W25erGYPS2lkUb8g92aHINibf4xZjIJfUyj0Mjkxs9L75Fq8pJ+YUeSoPF+va7vyciB6JIdRd63AhbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044

Currently _drbd_send_page() use sendpage_ok() in order to enable
MSG_SPLICE_PAGES, it check the first page of the iterator, the iterator
may represent contiguous pages.

MSG_SPLICE_PAGES enables skb_splice_from_iter() which checks all the
pages it sends with sendpage_ok().

When _drbd_send_page() sends an iterator that the first page is
sendable, but one of the other pages isn't skb_splice_from_iter() warns
and aborts the data transfer.

Using the new helper sendpages_ok() in order to enable MSG_SPLICE_PAGES
solves the issue.

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
---
 drivers/block/drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index f92673f05c7a..3d02015c1ddc 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1550,7 +1550,7 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 	 * put_page(); and would cause either a VM_BUG directly, or
 	 * __page_cache_release a page that would actually still be referenced
 	 * by someone, leading to some obscure delayed Oops somewhere else. */
-	if (!drbd_disable_sendpage && sendpage_ok(page))
+	if (!drbd_disable_sendpage && sendpages_ok(page, len, offset))
 		msg.msg_flags |= MSG_NOSIGNAL | MSG_SPLICE_PAGES;
 
 	drbd_update_congested(peer_device->connection);
-- 
2.45.1

