Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.143.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422650;
	b=lSw7c65ItwYVQ0nkL+aXKgGwtzOGiMx43MDy3ihHptBy/bOolaiCTrvVXgucsLRiQ7IW
	 pweFlKqHNE0lWLhZl+tPTHlrKICt3ZoZgiHmA8xGHacA5adqwRS8JXtN3hdIteWGI/hVU
	 o2xVn8r/8uLc9iduO5zA/hzeGIzArZqXSIvuLgUnTrPCroelDrlvQOwuO15vS71EJ/PO8
	 boghZNpxDNOY/TS24dzhWosM2iD5yP6J865BSTGHONIBUsMyWTG0I0uNT24PN4Uv7cL7W
	 WL2Dj26eOhxl5he3Xt9ajt+OyF1dESbn/RjBOJ2OjGR/IMjIgcq7BvpJpBViEfyzb3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422650;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=zrOg1gTcUITjeTQoNee3UZ91XT7wEjY6wi7TCZn7Ai0=;
	b=ZdSK8ucFHFb6iMT2+ooH0c4vzOdY/kjsAyIxCE2BLJ+hwI9yTwfokJxeq9h57bV2qjVo
	 SZ3iiFf4gJ55FSYipx9S1rYNuj4s+YmTGWzLeqqN48Igc1+ulkyGK3xKBpxtj05Yiju6+
	 0MHjwslwMJzvhgJazrcQvopTyLuVWUMYmTVN04ZuY6+DDjZZVeisjrneDg4JcttLaUtAE
	 LUVdrL0eHAA/R+zLWXbcbUIK7W7mvplZi0Po02InU0Vt60QQDXqYC/xs3eye3Rrf4COSo
	 zcePYrqdLUnE1HUKYMvZ4F5rdXpe0VCUn8e6mI6qCaNn24IhCgxbLcLo0ejYMfDnTtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=dldRQYFP;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=EqZFBNl6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.143.124
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F660892C8
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 15:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 933F660892C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=dldRQYFP;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=EqZFBNl6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792422649; x=1823958649;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=bfQVlnXKTMS1gaIvd0mR+U5cQCXAdgtrPUj2N6EIauI=;
  b=dldRQYFPVn+K3orndk5TV5XZtnbH6BhVhgojdIaQyCjlvT1IiSXsuZnx
   UcjqQvMMzSINScNixB+cpDhDAxUWToNJirsRkapYC4fgRPracH2zZPNP/
   xbsPWOevh7rXmpdzXJwJWPZzBDAC0RzhbCGqMdVQShZrtFVZuslcrEQWg
   L1Cqs+XvAEzVizQi5KUpEoB0pxotxB8Rugjl1dLdck4mFT6qm6HA6tx9H
   i730MaqEuSzT7m45VSBncc/YfqOgK8oDzpvsZ0z1DGSv6xIPmH9Ug8Eng
   vpT7NKLHJ78Eu0/29cS0aEwIdQTrgHanb23MVgt3wx8mNiyXSPAEeZ1Tt
   g==;
X-CSE-ConnectionGUID: uSyoJQqyR5iCumIJETWHrw==
X-CSE-MsgGUID: biH3mtrwRg6dfz1ri9mQyg==
X-IronPort-AV: E=Sophos;i="6.27,167,1786982400"; 
   d="scan'208";a="159413216"
Received: from mail-northcentralusazon11012066.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.66])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Oct 2026 23:10:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVxHEpCd6M4EMCyc6DS8/V2RZBuPbKSDh+z9RWXku7ZjQjdadTnS+Gj5A8lkMBc6IEJmE1Elg/ZjzkoiJxgobl97/FpHB2aO+DBf5DTJC1nFXbB9TUQRQ8HdzeDAxlgGymAA1VRe+HOslDxpEkdN6p6IRN7sAYn4RK5mpdI6G4bAgs+Nued8Fx0klKRQteX12LE4eED2mRq55QmqCNUeg9VLc2iRgDFFYhtJHZXoHKoIfSirVx0L+V5DLgfHNbR0UNh5oysdcwPzThPKx9p+3fbXuNQPtplYGqgRfR1AzHpoAie0a7JZ8fLnT+vrLFhR9FdXhhy42L6aJbh1ZBoBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrOg1gTcUITjeTQoNee3UZ91XT7wEjY6wi7TCZn7Ai0=;
 b=XfOjx4nchkZjHRS80x25stOnUVzQU9BCuOP2uNco9rvOjU38A+IC3e1CMn3ol9fijeahVGXJreGDamDbbCN1787OFOG3a0Fv5DsmDza0zKIwmX1NWdQTIio+KOjFTa4HbLO20vZw1Lc++Y0XFv5W62gztxqf5X7+COq66C8GHhN4STtc9660ayAE0lkm4wED92f01fRgNNgUFKyfJ1nZNpCDZK4Op2umYprmTdD7j0zNGTGUCJ0wjgDwE3sSGT8AkfworsHRT2c6rz3jdYoNvWbtsPPLEdGHQBbwPQi4y8R0Y9gguq2yawUX5m/GDZGJ4HDpypCPd+0gSYtdY2W4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrOg1gTcUITjeTQoNee3UZ91XT7wEjY6wi7TCZn7Ai0=;
 b=EqZFBNl6+P27RlC6H1hxW+BOdAh/a5NhI7+tqHUKrwfoPp70gABA16Vr1xO8Rs+DNGZO4XoqVoD1YqKvtwKzdZEVwnscV34uR9xevnxA460Hd1MslfOFZprwry2+lML1C9NGFEHsV3X8UQPd3+oZiGfPBNtbIQt92ygftQzOABs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BL0PR04MB6481.namprd04.prod.outlook.com (2603:10b6:208:1c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 15:10:40 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 15:10:40 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] zloop: print device that had errors
Date: Mon, 19 Oct 2026 17:09:36 +0200
Message-ID: <20261019150936.1819956-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To SA6PR04MB9447.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|BL0PR04MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e73ea6-27b8-4831-2487-08df2df32335
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|376014|10070799003|18002099003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jIWumi4SqGpPtmxEBEgzRYvMLQ38phmIl4hwz7Jsft9hnPKhW7Pv7EskfP98gJx8IUDEWDAorWnK2IwVKJi/1xYDXoUzqnE7H2PhZMW75fE7Fe9eAN3YCXpC+kyB2hvbv9z5XjwZeSkVCTI0h3D2Yf/zQzq7qEeY01fJ7hDPEgotYadhxQ7eugJ1XqqpqGAiXbiOxPm7eYWi6l1WMezntZXT7odn60Rw+o6kOe6ZQxl++XO7u7Dn4H7oltfEpwNcWriG9dNtDU/iiHCE1Lyzl11PJNTDcKrjUTm0TUcNbD+cdpT45uWz9i1OH4qsTFiHjK/T/HwUinw+DrfGZDYg83ggsHInvWBGX+tYnP8Md0x3FmpGgdQNRSV8A4tb446j8N3hywK1jNSjIenB031dxlALitIAfFLrsUYoWfLEZq34QCm5KcAlRCyyt3XfRze0GAuzd5UD4lpH1IWmwTkXVmZNGffscZGXEozzVX5m6cxuCoWYoj0FNWb1FRTJYSuT2rhMU+2YTHMzttYtr80xOFbg7Ti06WOs0PJ0FAXk2TjXEGWjiS0zBTbz3Hfm+qMKturnEIwUyn/ckzJqSQbZzphUeSB9vOZ2opSmYXmAbBIwtO6x8vKL4jfPYSmAfcl5BdsL4b7OEYCAxqk06lLa6g/f1BWWEspQR4M/oj3s+Y0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(10070799003)(18002099003)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uA+rkPPGqoN+xkTpK6+SlMPmd76/ItDabc2dNttG7IUVNuiJ/2B7w/dQ9xsw?=
 =?us-ascii?Q?nNxrjk9THyumVBXMie55clFSxIxn3Da9yd7jsZxcFOU06NQWlLuVWR6roC/6?=
 =?us-ascii?Q?cR/GBBToV9ppvx4lnUhAelqTGw+9y5J5csD87GRcej9DLUaXSlD2SJmKD8SH?=
 =?us-ascii?Q?/aS70Bly4U4rY7liHaf+qBZdUh9VP6PWMH0gQLQ9iQbPlki2o9pKeZz/O+aP?=
 =?us-ascii?Q?tDT1Y+05/vSrtJgt2vMJ5xTlXD6EnCTSUFwc3/dBqfN4rEtT8bK2YPHPWa21?=
 =?us-ascii?Q?HgcRYa8aDc1OjHok1qG17lFvtl3eZNRS0ZiCsEAN4jRXxaJwylzTWWvOwP1c?=
 =?us-ascii?Q?rBv46mfVAzUQm6+DK2Ic+xxjy9BHr4fsYSuBCSzs+ZunaJYzqjkhSOMtruA/?=
 =?us-ascii?Q?Ku+m6IcMLBjtkqqpMyelOhibymFjgV28yxLH3M5ad90XEfcFArd6MIiIdmIv?=
 =?us-ascii?Q?DbEN/suWsC1KZebvdC+dfZ3/YepOy/WyL35UzcfNE1XynrmxxOBYt2Vo9O0I?=
 =?us-ascii?Q?8+O0RnMFAisxC5vS2Lzi5Snc0dGrzlIj9g3P/4oUPkkqsnLSlrKE4gjnFD3J?=
 =?us-ascii?Q?uxQXKqfO0GvxWj1wKpS73K8z5Ekpxa82XBay/Lu3yGXDa6Ljrhhunk9HSk9I?=
 =?us-ascii?Q?BidAjLbKmYdgbTt0oVhqzBkwvMwdTQD/hmI/SXUl1bZOV+q7MWxs9cfzkwHK?=
 =?us-ascii?Q?IqDPgElgJSNUeH3eYiU8aE4L6bLoa5qUgK/JBQ4q3rROEFTHjmlmEcIAFAPz?=
 =?us-ascii?Q?6WtaU3hujUIU3hndgRkVvjDe4XdsMKbAyjVuN8YerQPiKwZS3rQDMRYb1RzJ?=
 =?us-ascii?Q?lOyiziQYqJpSZhuH89x93+sIaSmuNvrjQgGLcCHVJnmsZ7LNbv0qe6pmDEa5?=
 =?us-ascii?Q?mIeOQVVtmAkwCzt7SvoJgFOLlHtzV2IEKjkqC2xWi1/lDWoFAsBpDBqusCRU?=
 =?us-ascii?Q?idyyQYWXG8uXcnahw/oiwAStYdoe8Ycv1JPES8oIX4hzdHpz9OoCunpVW3Ie?=
 =?us-ascii?Q?be21XUIAidwDfwKFPUch3UjL8knudo57fu3HxYz/8AXAZzwq53HzYTJQwvt4?=
 =?us-ascii?Q?kKE1MOsWhLqbcq335e8iJJ3Flp21tg2c/7MPpBgyRkUs2L7QQttX7OSt6LW5?=
 =?us-ascii?Q?MHWZ8H38X/rxZQDgUTZD8EXkYN03zIKSWGKkHq7FRbp3XBZJQhEPtVt+7M4/?=
 =?us-ascii?Q?6RkXQjTB1Cs9ur2uIwSnQMaQxLcm+3MZKaJsKcCeSQjPSmV+BAfwG0YONzX8?=
 =?us-ascii?Q?015VqsvgLBGwyIUomSYgcMMnZUwqMJUEl6XdEAe1cbm5N1ZCjmR5ZEJ0nVWa?=
 =?us-ascii?Q?tMw732X2QKPVBnW6LOPHW/b/KUlGUrgbzGitZR/VdQvU5E3tfn+jZsaHRq8S?=
 =?us-ascii?Q?EPcsK/cvHMCxvffP1Sa2fmHfw9oixyiwQ3WqYcOxcf9njYxCLbtqm0wSi/Wt?=
 =?us-ascii?Q?r93t6evhN33SmZdcGPwLH94rhmMhLtDy5vXTM0xwS1DPax1ABZswbPIDR3tN?=
 =?us-ascii?Q?AZAeK69vuG/OkGJqKP0N+DloZ0KTE77LQ4VNWAVdW+RZOiuJU8LHFl50vLrq?=
 =?us-ascii?Q?a8T7A14bs1pkMjFKZSaX3g3Pktdox6+p7QGEkugMencX8J3NbOe38U0QSTb2?=
 =?us-ascii?Q?k9QZKwPWcIFy7SB4i68VbtQv+ccw9ZT8KZzq6nlnh//TghUynYFLPoDlTHcn?=
 =?us-ascii?Q?FcloQjLSlq0Lku2IX220bwTmoMeXj7rkwweLN0knKHMETIjxtbNPaXr1OEXN?=
 =?us-ascii?Q?7ijsgEUOABef/+7OUA4yKf9Zm+VQT8ck1eqCXlzWlQbJD+FVo+2/Y9IHcYJ1?=
X-MS-Exchange-AntiSpam-MessageData-1: e8QzZ7s0Y5+qr1WvcZKqyJ4BFgHX4vISfIk=
X-Exchange-RoutingPolicyChecked:
	cswOrTgknnmel8J2HV0eGPKU9nb4i1Yg1SZPuK2PfPrSEE8PQvQyhNlMtOR1NHFAL8vtLYEEpbLUFvD+psMUMr6LKe5HZWyS8llaPS4P3sP+qr3jiRwTjWdSqHTrscRm2tiw9t47UZboPcC7EYPk/1Q4z/0QGrPku5adogzTV9BA+F2yRH1ATh/pnT8QtWT0+TIXYjLWXlQicdcCBm+WuewqfsNAgwB6CZLq9XwEZDfezfl00j2/R1JdXrhjDLZxsY46NU9ZQdSrRFpgW7wZ3WH7ZBR0zol2ZeHSH4Vnz/c2P3sR5Uuh5n8bbuSUwyUOB84rA3Gibpn6dp1Rq31oNA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MiqxYl1womoeMV6LaGPvel/StNQ7wCrOpn93RMvOyKDKqj4yfvhFCi26q4yUy0stVlrBPrLA+W0hYVoRPqqsb2MO+I7FEtxQb85Fj7ElPLLjydop19caVak7rRI1zaXCppXUjPbYq4fiz5X3MJA91vV+/U9RgJMrQKvOgNnvcrxXk/rIBvfeWMDpMDaCYlhDUi2uUbsormjWq2etiKn2AIrcLjO5wIHq/lqP/huS8n4FbsZbGeY7maRkhw2Lj5Zv8HavzmmJbTFjVCLHPpBvXGjwONCfEX9IDoeCCwReBqrkbvG2MSQ+zD0Dg/UYJKQVTw9/TT99uREQ7FBlWjD1hdiu3mQaQO/peSUmE2ec+l8SfyHvpCBPJ4ZrUdbmqJdsvgzvc4Y07UplxoBcdx3yVps6OC+NVcJ4nDN0/ziyFh62rx/aFW2YRy/DBeec6dfQK0/nR/foZ302k2fsiyHqZTzgQy5Bf7TTgcWNsQ932IkTAIM+Ikmnc/qz5oAml642ecOb95NFErbdo8Iy4uFSMnpH55ci4k03frOiy2T+YneSZ+M5RryF9e96hbDA4NDLBeuHchPLxzdBBPsxReuvTtsnzERW7D+JF5SygR71KB31lq4N696RjXyNWAz610ym
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e73ea6-27b8-4831-2487-08df2df32335
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 15:10:40.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSxSt5ARbO1JQlV+QcgASOEMrlwSnIRZALVqcifHO6m4zGGBjn42pjruflmHj8l7AFV81h6dvUc2EPPnLAXC+WJuOjVQoTJ5F1VHElKB5tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6481

When testing zoned filesystems that span multiple zloop drives it can be
difficult to figure out which devices access caused an error.

Prefix the error messages where we have the disk available with the disk
name.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes to v1:
- Based on for-7.4/block
- Add reviews

 drivers/block/zloop.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 509d9727835d..73d9949d01e0 100644
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
@@ -816,8 +819,9 @@ static void zloop_complete_rq(struct request *rq)
 	switch (req_op(rq)) {
 	case REQ_OP_READ:
 		if (cmd->ret < 0)
-			pr_err("Zone %u: failed read sector %llu, %llu sectors\n",
-			       zone_no, cmd->sector, cmd->nr_sectors);
+			pr_err("%pg: Zone %u: failed read sector %llu, %llu sectors\n",
+			       zlo->disk->part0, zone_no, cmd->sector,
+			       cmd->nr_sectors);
 
 		if (cmd->ret >= 0 && cmd->ret != blk_rq_bytes(rq)) {
 			/* short read */
@@ -830,14 +834,15 @@ static void zloop_complete_rq(struct request *rq)
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
 

base-commit: afc9cde716b29ce814798d649a95f9128ba42b43
-- 
2.56.0

