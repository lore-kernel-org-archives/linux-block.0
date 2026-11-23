Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795435911;
	b=iPHLPfKTpP8KeI6MyyGHgujQisSuVhxrlXBRALYmqEqhHQ3K+Uff6sqrkbWjAzwGjt84
	 E047+PEKuUx+sa3BGXf4cH843ZpZLJablf8+nYzuZWYGwNP4Hs1GRtOwGxwNWZ0cEQv/d
	 oplre2KmgZjjLt2ASDNUlaDwaJxgj8YIKSb/1KEGlgjmcbiSKe3huKKBpVOTkT6zHr/tG
	 yoB1YpuSspxsYjEicXY4xdWjp7XyWYXgPCRKm7WzKBY4adHHz3bWgW43UHpQt6kCzJ8cy
	 xZpXt9mWXVRS9zAaBJDjp7PEepGYMlQIGO8MWe3gpv6S5DDYp1OEARBCn77P8DPMznw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435911;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=uyGD+hL9Bcb+v5668jjiFHw/votHVRwGNlKrRHWG51Q=;
	b=TpzyTQfU89NI35M8i0/pQ0F1GqU1DE01qeLN+jhjtVGk1z3htCJBP/NqwX5/JiEmP/6p
	 Hp22gQ9st3YsDGC4QKQr7bdoLa6GR33/l6U8+qUnMGQDqCeEPAaMmbbq8UUt6S/fC5EbB
	 S24m8n05Gph9WJIP41kvi3I6q7uamxp8GP1e+GAaVUkYmljNa39aspvYaapFtSQcugv5Q
	 pIfuTrkBtPjXS+egN8rPb7klSjteKvTlfxk0j+W42WJdwlBK/VeiJcX/FXd1iRgqsk6Sj
	 uHLDzZK4egcM7dGIjEzWapuQuL27gQgbt4z7PS4G8xxkaKRZYuSh91XIfNZl4rLIbyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b="cxJaB/Xt";
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=G99ZgXub;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A65606A31F
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 12:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90A65606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=cxJaB/Xt;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=G99ZgXub
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795435910; x=1826971910;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ORJA7IMt3Dk0mDAd16t/qyPG9JNypIwO+Fy8Nd7+cUs=;
  b=cxJaB/XtdvHNqyC+x2/imLu0QFoY+5Qh7e1jdVDBMnP/kPbLCzuvy3zC
   mT1o9+ly3GTMmM3MVQHeQQWokqyqnUy19fruqszNJ+osK03J+lA/RewDJ
   JFPnmJnFaj2Ut0dhP+tK/RPJ5bZ4g1KqCficLNNn83HrSz35G+4S/oMVV
   XB0nnmvwhYmGp1c4k2UX5/kR0qB6/NXoujWNS0MqwEn0N3RFcFrHLI0gA
   Gt7ZNAAQumvwvzDRX4Af2LydR1Tzhc72gyUBqq1j2ewAV1DlFHRj5HMMm
   NvV6htyAaRio51WElnIbFtcOfLz6soJXKEc8R2U95Oml8u1mPttGoIuhS
   w==;
X-CSE-ConnectionGUID: e9H5dfUXR0+k/M3ElbW0XQ==
X-CSE-MsgGUID: 3LRLN6QOTWuFP+9zanzxMw==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; 
   d="scan'208";a="160584356"
Received: from mail-westus2azon11010051.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.51])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2026 20:11:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgEkRTARY+aOMTFFzmOdobqOvRSFmo1/05BQRKp8Ah1k5MwyfZOZN9QuWm3Nd7MiEXfhMEJHhx5yLlG7gnFH6jiohN3hgOdDEMjfXNkvU8vsGTYpgorY8f0X+dxZiRrabVXUD5EHmtUUw+okPTGQQgTBK0dg+dy80IUNkusLaXHdulPb1rPuAFkhcksn0fQDYQbHnuGiBAeOR+tP3U+bSCRI3eENMkvr4u4+jIFZmOL/2cCtnE7D97r2r4EH5SlNskMKTdAgDRfZ4UBI7bit/KzFlaK4rbhPno5gswy+kub90UIS9v3OXb7q7rJjRCYOxMwAPM91ADu5ZXlmZz28Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyGD+hL9Bcb+v5668jjiFHw/votHVRwGNlKrRHWG51Q=;
 b=ABeZzq0OIoRKdTq/fm6ia9Ifr6nzd8EJbLock4QptwnbbmixDVpk0ezn5Pt078wSSrN10CmndmWj4OxybwygjwN1ZCTLvc64yHxh0XiJX7j7renCtkr240/h3R79KvIeVio6k7oGr1wv3gdcJ7iMcTyfnGvBoZa59ZotYjzZ5gRvO/4RGsAkJ3ZzPpsJluSBE+N9NsnyY9sexTLSKsxQdUvVuDQxZEEvtaAmfYEvGoA8aMfAawF54ZRsH+W64i5TTgXKrAWU3mYFvTuqVMlFhfo7ns63Su8GUh9mJEk+bN8A6sQYuNcoaWyKkpyHU9FFF9jNz9vy15MAtaRyUSExAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyGD+hL9Bcb+v5668jjiFHw/votHVRwGNlKrRHWG51Q=;
 b=G99ZgXub00XtmAUGEZnceiN7x+pHjYhC59DG1PO+65nBmZcy2KhWo1Zm5nDbGPcJvx3O5XImLK7aVpvxM1G35Xpt6BQmXCHsL0jm8B50hK2JWnwJN4GYI5x41bTVVhhngKYYCJoWSo1WUjb5gs99NDktrPR0m0aM9JW+PS2OTxc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BN0PR04MB8031.namprd04.prod.outlook.com
 (2603:10b6:408:15a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 12:11:41 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 12:11:41 +0000
Date: Mon, 23 Nov 2026 21:11:34 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests v2 2/2] nbd/006: Measure NBD IOPS with a
 null_blk backing device
Message-ID: <awQaJh_NFpD2_-PK@shinmob>
References: <20261120213434.2945873-1-bvanassche@acm.org>
 <20261120213434.2945873-3-bvanassche@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120213434.2945873-3-bvanassche@acm.org>
X-ClientProxiedBy: TYCP286CA0252.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::10) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BN0PR04MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 615ea34e-3e0b-4970-e373-08df495aee8d
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|10067099003|56012099006|11063799006|4143699003|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	CjIE9/W/7dXHZWPBI+D42dnIsR9rKPvfOx70WGl/hF0Fo4ex80m9ZJDo4ly0AT8XbdQIIClp0qNohahCJMELnFi+nTdiSawebWGGfTd3cvqRZ8+z35kgEBFVNq/lfiOt1AX2o8zplYIaoeDBbeqRD8buhdRKuKjyY6x3a/E3ibkB4eg+qLq96vyCKFjB3Eex6KWYjUWuZaiXsFdwYWqziMaFWghESLa2TxUTu43i3ZbppPXgB12Z9wovrCpZXdyMhN5F3qg4ewBNU4BwQjXYbCkwxUSRwxlyNqOIrU7b8L/2JVw9yl0uqFAHdDQB9mydnw8POHTe2/AAiU0JIe/rgfK25Pj9i0N9k7KqtIbgQAaWBVxcCnYTjj66pI11H1Qy9OsW2uznpULs7K0ZTxP3avQndfkuCD2U0wKgMao9CF4fiWVytaPSEX/kGqPHwLF4+QBMDJbJeH2ZhUz80knG5N9x8dVdI4kpTKTEcecKKW+kRTMgWttpg807CakxAPXLACy6z1x9zmEN1YNM3yHcuGHaWEuiC3eQXQP26zG6GGidR+WUVG6mrmCME5TymfkHt8OurXLPUpKDG4HKvlfJ1hmZYjo1lXRQIHIruxvauDgLyoDR8nPuejBW0Nhd9JHLki7U4fZ4dq8qzpe7+U6ZwQVdS2pNPd4vpCxpT0uwviY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Tu/0jlUjXdHx4imjOI7Ec5mdkQ8ROtGRr3wjVivbZxyMjZrHfwOUgKvePrZ?=
 =?us-ascii?Q?/s/Al/QMsYEIzhLP5JogrXNonZo6/HFyr/wlq4NzA2XnpQCCyt0vt5M4QyZt?=
 =?us-ascii?Q?I6+pOaD8TcI3a+OG3xxGvWqpE12fsIf9onpHjfPw+R3P5zgcH64z6oiRo2Cb?=
 =?us-ascii?Q?ZiNc2GnIfnEuHNC9DfMjhkgngKWD6UKkaE0FjgzFU5yRtzebTazz3ZbucOyj?=
 =?us-ascii?Q?riAYHaN9u362p0MBQhTjpVON/saslrvIUG/pqisZSWB4XQsMOinCKx/5QXEm?=
 =?us-ascii?Q?95akoRAgOs2zcS3VaYmVkJV/qljG/3atLvXtvSWK4DHFnaU0jfmYasZrF1uJ?=
 =?us-ascii?Q?s3LpwCWHtXvKNO4gROeqnBZjIXGUq4+G4TXTUmi53CMWjRhK+qyHwiiPceM5?=
 =?us-ascii?Q?eNXxMXq8/7zzyC1SKFzotrwwkLn/gm1D0AsY4r4VDXFdHTplukKPF7FfmRQr?=
 =?us-ascii?Q?4QdpisLRzd6U7V8kQzvBK1sexO5hBRWDfaBgLO4uUJzEA5QKrHdoeopBkEtI?=
 =?us-ascii?Q?XyQThkiI8JJMjdfxO3lEXL7fgZFOHA8BuWU35/Fepzvg+YchoQ1jV7nLkUGY?=
 =?us-ascii?Q?Wh2H7fEkoCZhPI4tSQ+AjK4iPqT1fvYtQzPlXiVNUP9+pVQK1tIhP+Hqpv4Z?=
 =?us-ascii?Q?U6lShRBQeQbFYb9nsZ5L4ApNuJkNXA6/yzo02xQwUm3jPghGwVUY34fLKgcf?=
 =?us-ascii?Q?CvAwGAs6EEQmz8j1dsGDxut4mAW4fGZbyUhvsd8z/ykXVoM6c6ylonTpGUTB?=
 =?us-ascii?Q?OasuLMTjAwIsrwLGICuTLvAaQMGgykBJOvy7E3VyZWVj1cXrUaoiPhuBBvNB?=
 =?us-ascii?Q?9v+2JYU5OpusJcB1z0Ll+9KW3rXVkHcIZv8TsPdqzdZGa9zBOgGfTXLXmifw?=
 =?us-ascii?Q?ZhGatE21wV5tz2CImz5iqeZ2qZZf0+BX8od9kC4CpOcKKQdUUG1zDxQ2DfW3?=
 =?us-ascii?Q?SGzqEusFILoRxLiwA7IEerxV0aTQLNHWVJOny1C/335ZHyYCtEgH+0dMNamj?=
 =?us-ascii?Q?05x+pguRS3KdzfOJhFXjFEaJsmZIfRBPLv1ANxQsGJS0ulkZAVqnmkfJA+NI?=
 =?us-ascii?Q?KbIrPNtijjGLfzyTnyQS4znS6rByI0Ctdx1zaeHVoY+ELx9cX8dp7CZ0hhS4?=
 =?us-ascii?Q?y0FIrPgfVA+PeVsRoa7Ckr2mwpiFOpzJSZFRDp4K8FI9XDQEhMprspSqlsuy?=
 =?us-ascii?Q?TUVejqzPzMoXoy4fexjK+qMg6JJ3f81fRutNvH/xo3TbKvoFaI9wRUsSaxBl?=
 =?us-ascii?Q?LiuNoDO07/nSAYeSSEBQpRTXMmF1Jjj9Ur+mbfakjjxCi2hJemuyJW+Tg3mX?=
 =?us-ascii?Q?npOuQmxCHxlWHQ8InKHox/dr4Dqo7sGgahgPAkJ+MWCe/mjlWmaUWbcSQJyQ?=
 =?us-ascii?Q?WsRv35xPkEC2r5w8mr8FbIjpBz22+S2rCFGmjz2tJsfLvbMhcuGtcLQ3pDEh?=
 =?us-ascii?Q?nZHqeeqI8ZuPL3BLtfziLnkJEwO/I1eRoLIj90yHDrMyN+VJZh/F2FH6fORS?=
 =?us-ascii?Q?n3D9F8yp00mlbGr58KbYRCZyZkI8Jmf5SbVp61K0PkY3cdwBonGzflCjn9NH?=
 =?us-ascii?Q?F/QMa6hST9VsZif1CDPQA3X9TKj3CeWalPrOMuIufvUxHiovYXEgWO6Jo2Mp?=
 =?us-ascii?Q?WVlg7jL5qUDuX/uK3HRgJyiVV8q3oWeEYNg2Ih7Q9vQY0byjhhGiHajz+k99?=
 =?us-ascii?Q?Lw7FrHNMrPt8LlfnjXmr+gOed3PMoNbmbvBuS2gxmdElrkjAargSKGajq8Qw?=
 =?us-ascii?Q?cO77gtCMZX80CTgdtWSpfeI2aZ41lJk=3D?=
X-Exchange-RoutingPolicyChecked:
	Zhp73bteUDszDqoq3Na6UGzYYP7868UqH+xrPr9OgV5aWwPS4sPg2ZHQptqIXvYZctOlVbe+oRuUnWfyFfyINi75LTB/GblP2WgYBcfSbUZ1S88gcQQSpHIsX97EWMrxR3leogRrEzTgbKjK/QbTB+aLA67fnhbpwVagUxh+PcWnPtVPExpTrzckuzDX9QAfgxzK1EW8s3DKjQcojljqtVMmOPpOVuOzBrGehnHyZW0qXdSIUG6sIKdtmNGleVU+Umbd3o+dBqgqOKRpVGvj871WbPdE8OG8vliPr2XkFCdgT6uzzBRy28YZzByNs27VfBakgX4wVuL9IeFI9wS7Pg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q12Bs20pKnUl75gb2fq/GYHXuVSxiMrNKtaMmef4eFdB+dHHtvIVrNufO+gb5z5Z83REKHvuWTjipdxCeHyfUSHM4VLxwhMGcx7/j57BThtppblXwmYIjKXtyryZZAUNm9LX+NyQhZila1Z1MzBBMBxd3wFkfhkSvewGBpxVNpDh2VjtQNNUfMexKSvRonim/hp9Y5Sa+BCLnpuyPa5EnWEX83UgrpGpKKDTXtZafrXRCbUgmgdvfn0hNFoiMMO/LbYkc1hqXcwdMRn97L0Uw9+cDyZGgECThfCHlDgoSDMRDiE2RvZaF6LuHttev0nupX+ayXqoOmUYjJGAvdIWJbqeYgbgB4K1wlggT4VfFe/c1p+nAfvoUWK8H+RG3JKLzGuOfvbv61rq/sAIk6v9DmpcD0CMNAQoJy7sQXk0fDw2JKNXyNqG4NyYPvy3PicaJ2F8BOf+9lRS0IoXOIQK+Wryxz4zj7Wzzv8Apfa3BlIRz1DGuwfVJ9RgAvCjUfpZXzjBqmI1wr+a+F20mYyHjUq5a/J958KPTk1JQYzS2Q7jjVKvfxATBYBbf5QjflJdVPjDDbxpSDVsQ0CgY+0jdTj9/YkIltpUTaOmtXjz0rnZoCINmlyR4Ll0dusof+VS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615ea34e-3e0b-4970-e373-08df495aee8d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 12:11:41.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0PXgDPYCY3UE9WCMgHs9gsWR4sy2d2pjjNvsv+Y6czkbhgfubrnYuogPgCo30yq6YxP/fcuOFlgsr2m7I/1FypizJ1kxPz6wUvqZHp6REY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8031

On Nov 20, 2026 / 13:34, Bart Van Assche wrote:
> Add a test that measures the random read and random write IOPS that the
> NBD driver can achieve, both for a single outstanding request and for
> the maximum achievable parallelism. Such a test is useful to detect
> latency and throughput regressions in the NBD driver and to evaluate NBD
> performance optimizations.
> 
> Minimize the overhead outside the NBD driver as follows:
> - Back the NBD export with a 1 GiB null_blk device that is tuned for
>   maximum IOPS: no memory backing, immediate completion, a 4 KiB logical
>   block size, one hardware queue per CPU and a hardware queue depth of
>   1024. Keep the device small because nbd-server opens the exported
>   device without O_DIRECT and hence all NBD I/O passes through the page
>   cache of the null_blk device.
> - Select the "none" I/O scheduler for the null_blk device and disable
>   readahead such that each 4 KiB NBD read results in a single 4 KiB read
>   of the null_blk device.
> - Connect nbd-client and nbd-server over a Unix domain socket if
>   nbd-client supports the -unix option and nbd-server supports the
>   "unixsock" configuration option. Fall back to a TCP connection over
>   the loopback interface otherwise or if the Unix domain socket does not
>   appear.
> - Use one NBD connection per CPU, with a maximum of 16 connections.
> - Measure the IOPS with fio using the io_uring I/O engine, the "none" I/O
>   scheduler for the NBD device, direct I/O and 4 KiB requests.
> 
> Run fio four times, each run taking a quarter of the test time:
> - Random reads and random writes with a single job and a queue depth of
>   one. These results reflect the NBD round-trip latency.
> - Random reads and random writes with one job per NBD connection and a
>   queue depth of 64. These results reflect the maximum NBD throughput.
> 
> Report the results via the "read iops" and "write iops" performance
> fields, prefixed with "numjobs=<n> iodepth=<d> " to tell the two
> configurations apart.

Bart, thank you for the patches. This test case is interesting. As far as I
remember, this is the first test case dedicated for performance regression.

Just for curiosity, I wonder how performance regressions can be caputured with
this test case. The performance numbers are reported as described above, but the
test case does not report failure even when the performance numbers get worse
than previous runs. How do we catch such regressions in automated way?

Does this test case have other value than the performance regression check? For
example, the test case uses Unix domain socket, so I guess that this test case
extends nbd driver code coverage.

Also, please find some comments in line.

> 
> Note: since nbd-server performs buffered writes, the write IOPS mainly
> reflect how fast nbd-server can dirty pages in the page cache.
> 
> Fail the test if configuring the null_blk request queue fails or if
> nbd-server does not start listening on the TCP port in time. Fall back
> to TCP instead of failing if the Unix domain socket does not appear in
> time.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  tests/nbd/006     | 202 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nbd/006.out |   2 +
>  2 files changed, 204 insertions(+)
>  create mode 100755 tests/nbd/006
>  create mode 100644 tests/nbd/006.out
> 
> diff --git a/tests/nbd/006 b/tests/nbd/006
> new file mode 100755
> index 000000000000..03bb0fc66bb4
> --- /dev/null
> +++ b/tests/nbd/006
> @@ -0,0 +1,202 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Google LLC
> +#
> +# Measure the random read and random write IOPS of an NBD device that is backed
> +# by a null_blk device. Use a Unix domain socket for the NBD connections if
> +# supported by nbd-client and nbd-server and TCP otherwise.
> +
> +. tests/nbd/rc
> +. common/null_blk
> +
> +DESCRIPTION="measure NBD read and write IOPS with null_blk as backing device"
> +TIMED=1
> +
> +requires() {
> +	_have_nbd
> +	_have_null_blk
> +	_have_fio
> +}
> +
> +# Whether both nbd-client and nbd-server support Unix domain sockets:
> +# nbd-client must support the -unix option and nbd-server must recognize the
> +# "unixsock" configuration option. Since nbd-server does not report which
> +# configuration options it supports, look for the option name in the
> +# nbd-server executable.
> +_nbd_have_unix_socket() {
> +	local server
> +
> +	nbd-client --help 2>&1 |
> +		grep -qE -- '(^|[^[:alnum:]-])-unix([^[:alnum:]-]|$)' || return 1
> +	server=$(type -P nbd-server) || return 1
> +	grep -aqw unixsock "$server"

In my environment, "nbd-clinet --help" doesn't report "-unix". It just reports
"-u".

  $ nbd-client --help |& grep --extended-regexp -- "-u"
  Or   : nbd-client -u (with same arguments as above)

Then, the test case falls back to TCP socket, even though nbd-client supports
Unis domain socket. I suggest to modify the check above to match with "-u" also.
I also suggest to use long options instead of short options for readability:

diff --git a/tests/nbd/006 b/tests/nbd/006
index 03bb0fc..ad6100e 100755
--- a/tests/nbd/006
+++ b/tests/nbd/006
@@ -27,9 +27,10 @@ _nbd_have_unix_socket() {
        local server

        nbd-client --help 2>&1 |
-               grep -qE -- '(^|[^[:alnum:]-])-unix([^[:alnum:]-]|$)' || return 1
+               grep --quiet --extended-regexp -- \
+                    '(^|[^[:alnum:]-])-u(nix)?([^[:alnum:]-]|$)' || return 1
        server=$(type -P nbd-server) || return 1
-       grep -aqw unixsock "$server"
+       grep --text --word-regexp --quiet unixsock "$server"
 }

...

> +test() {
> +	local nullb=nullb1 nullb_dev=/dev/nullb1 nbd_dev=/dev/nbd0
> +	local sock="${TMPDIR}/nbd.sock" pid_file="${TMPDIR}/nbd.pid"
> +	local conf="${TMPDIR}/nbd.conf"
> +	local -i nr_cpus nr_conns i use_unix=0
> +	local -a connect_args
> +	# Setup progress, used by cleanup().
> +	local -i null_blk_loaded=0 nbd_connected=0
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	nr_cpus=$(nproc)
> +	nr_conns=$((nr_cpus < 16 ? nr_cpus : 16))
> +
> +	# Load null_blk without creating any device and next create a single
> +	# null_blk device via configfs that is tuned for maximum IOPS: no
> +	# memory backing, immediate completion and one hardware queue per CPU.
> +	if ! _init_null_blk nr_devices=0; then
> +		echo "Loading null_blk failed"
> +		return 1
> +	fi
> +	null_blk_loaded=1

I don't think the _init_null_blk call above is required because the
_configure_null_blk call below will load null_blk if required.

> +	local nullb_params=(
> +		blocksize=4096
> +		completion_nsec=0
> +		hw_queue_depth=1024
> +		irqmode=0
> +		memory_backed=0
> +		queue_mode=2
> +		size=1024	# MiB
> +		submit_queues="$nr_cpus"
> +		power=1
> +	)
> +	if ! _configure_null_blk "$nullb" "${nullb_params[@]}"; then
> +		echo "Configuring null_blk failed"
> +		cleanup
> +		return 1
> +	fi
> +	# nbd-server opens the exported device without O_DIRECT. Disable
> +	# readahead such that each NBD read causes a single 4 KiB read of the
> +	# null_blk device.
> +	if ! _write_queue_sched none "/sys/block/${nullb}/queue/scheduler" ||
> +	   ! grep -q '\[none\]' "/sys/block/${nullb}/queue/scheduler" ||

Nit: I suggest to use the long option --quiet instead of -q.

> +	   ! echo 0 > "/sys/block/${nullb}/queue/read_ahead_kb"; then
> +		echo "Configuring the ${nullb} request queue failed"
> +		cleanup
> +		return 1
> +	fi
> +
> +	_nbd_have_unix_socket && use_unix=1
> +
> +	{
> +		echo "[generic]"
> +		echo "allowlist=true"
> +		if ((use_unix)); then
> +			echo "unixsock=${sock}"
> +		fi
> +		echo "[export]"
> +		echo "exportname=${nullb_dev}"
> +	} > "$conf"
> +	cat "$conf" >> "$FULL"
> +
> +	if ! nbd-server -p "$pid_file" -C "$conf" >> "$FULL" 2>&1; then
> +		echo "Starting nbd-server failed"
> +		cleanup
> +		return 1
> +	fi
> +
> +	# Wait until nbd-server listens on the Unix domain socket. Fall back to
> +	# TCP if the Unix domain socket does not show up.
> +	if ((use_unix)); then
> +		for ((i = 0; i < 100; i++)); do
> +			[[ -S "$sock" ]] && break
> +			sleep .1
> +		done
> +		if ((i >= 100)); then
> +			echo "${sock} did not appear; falling back to TCP" >> "$FULL"
> +			use_unix=0
> +		fi
> +	fi
> +	if ((use_unix)); then
> +		echo "Using Unix domain socket ${sock}" >> "$FULL"
> +		connect_args=(-unix "$sock")
> +	else
> +		echo "Using TCP socket" >> "$FULL"
> +		connect_args=(localhost)
> +		for ((i = 0; i < 100; i++)); do
> +			nbd-client -l localhost >> "$FULL" 2>&1 && break
> +			sleep .1
> +		done
> +		if ((i >= 100)); then
> +			echo "Timeout while waiting for nbd-server"
> +			cleanup
> +			return 1
> +		fi
> +	fi
> +
> +	# Use -connections instead of -C because some nbd-client versions
> +	# do not declare that -C takes an argument and pass a NULL pointer
> +	# to strtol() if -C is used.
> +	nbd_connected=1
> +	if ! nbd-client -L -N export -connections "$nr_conns" -b 4096 \
> +	     "${connect_args[@]}" "$nbd_dev" >> "$FULL" 2>&1 ||
> +	   ! _wait_for_nbd_connect; then
> +		echo "Connecting to nbd-server failed"
> +		cleanup
> +		return 1
> +	fi
> +	udevadm settle
> +
> +	# Measure the read and write IOPS twice: once with a single job and
> +	# queue depth one and once with the parameters that maximize the IOPS.
> +	# _run_fio passes --group_reporting=1 and --runtime="$TIMEOUT" to fio.
> +	: "${TIMEOUT:=60}"
> +	_divide_timeout 4
> +
> +	local fio_params=(
> +		--bs=4k
> +		--direct=1
> +		--filename="$nbd_dev"
> +		--ioengine=io_uring

Some test environments disable io_uring by default. I suggest to call
_io_uring_enable and _io_uring_restore before and after the fio command.

> +		--ioscheduler=none
> +		--norandommap
> +		--time_based=1
> +	)
> +	local rw numjobs iodepth numjobs_iodepth
> +	for numjobs_iodepth in "1 1" "${nr_conns} 64"; do
> +		read -r numjobs iodepth <<< "$numjobs_iodepth"
> +		FIO_PERF_PREFIX="numjobs=${numjobs} iodepth=${iodepth} "
> +		for rw in read write; do
> +			FIO_PERF_FIELDS=("${rw} iops")
> +			_fio_perf --name="nbd-${rw}-iops" --rw="rand${rw}" \
> +				  --numjobs="$numjobs" --iodepth="$iodepth" \
> +				  "${fio_params[@]}"
> +		done
> +	done
> +
> +	cleanup
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nbd/006.out b/tests/nbd/006.out
> new file mode 100644
> index 000000000000..acc8af5bfb2e
> --- /dev/null
> +++ b/tests/nbd/006.out
> @@ -0,0 +1,2 @@
> +Running nbd/006
> +Test complete
