Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794393043;
	b=u1T0UgTF/EUOW2yoo+7pED5KVRTDZGb84ahNBW8lTkp+ajjfNcitTn4rEsJyzSnytoXu
	 HRSzTCMhYOtCmdcsobEp2ga4NKoyJGSjh/mUAH8GayZMc5kY4js561ZpJmnYH9eVnhjod
	 Vvb9Buiwdq9YbdQLPOBX7D8n5oyL9b3QlgOSDAYENsS1d+EpPQ30CKhNr6aVl0HVpV1Rp
	 BSYl0ZakvAtQHXES1jVV3OGvjnr9e2MB6QAuEj2uQEz/OVbnCRtad70KT3D31jWFxnItE
	 tPQI18wsCPP+pO3RVRsZ/kYcLaslHqzJeSoQaWbiexV3t4v2I/s4bjZCXjURRHqi+Xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393043;
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
	bh=71JdWRQpykuK4DUpdCkzD6AThOMlkJVnKeObSksXK7M=;
	b=epdyAC/RXk/Hfn/zEfc+rVl85MN4fZ2bINKlHlaQYQ+ZEfPJn+ralPShmuCUFA7yBQNc
	 qZuX2Kbe1Gr2aCZ0oYzkF8D5apcwH0xCxLpD+xf7TreynPtV4o1NgiDg21QJbdwOp+RSX
	 PrK/P2OGBAJFWqV0ELn4C2OSq9J9e2LYHYY81ZmLBRSA2EPo6FvvWpg8OWP2OY6Zn++wp
	 OcYRzebxpVsjmYZ4BpOD1yO+fQAOi7V1eULlVhgKBgwI9yKzIlj1/MYwHtoNhEFqtuCme
	 7DZwC7tlMxPWRceE+5+apMYSIQL/BB8OHT7/7uVYWFlTBiTQhJrcBxoHsQXYIbFPXtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=MWLqMc3I;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=DQdkKQFx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732F5606A326
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 10:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 732F5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=MWLqMc3I;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=DQdkKQFx
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794393042; x=1825929042;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L166ZngJW7PsCNdKQv3EYU9X2ErmxJHEQ/elFh0eLWo=;
  b=MWLqMc3I81hXyk/gooLt6bLy9Wc/DMD86DfWEFHS0UQ8GY9Rs0/hRZxx
   HmYWrOKu+VSFr3UQl1MBCHu6o4jmsUGP0wfSwkP3qwt3tVYSNyC+N0CiY
   texVHFb+AKiB4x3jcUC5u2jBYqmiWdTMkkB+JlhPStTkOxAFHfwkn4dnh
   LInbnt/AXzlibVcaqnr9j8CO/rTpaS5dTkWmB0IUwWJixUveKarkxxYfM
   knFAd+svQblsfRDwv/jUP6kHtFVbz7jWGfoBnohG0A90Bcgplf009JGzr
   98kgzAJu3gao87WHX9YGZu9rN7ZaHfOvViTAZjAfrgGX0Khvas5Lz4GRk
   w==;
X-CSE-ConnectionGUID: NgY4RUZdS/STYu4QUfTDjg==
X-CSE-MsgGUID: e8Pp+BhOQ3eqWrVDT1ERNA==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; 
   d="scan'208";a="156393117"
Received: from mail-westusazon11012011.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.11])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2026 18:30:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TByyJM5RjTUNlxJuxSUHzVTjeAf42vqIUeajkgzr+YAuOvltVrhkF/nC73n5kTuQ8BvhXc0Xkc3svYp1CDU+B69So9JQO+y3MheVeLI3MCy8x13U+Nsz6C1pgD5C9KqVJqFv4OJPkSMy3LwHWDlSsl55Ucwl4d7u1Cv/mty/TEMo3nf5iDxPVr559q/ySnZDi3qmVzxHN4WGbZQiVHp31l0mmBZjQGJUcfdii2pMZGT++wmHaSHj3a18EvGMw35J5Lixf96+xnM15IzInEabIiznk/XIQ/9uwzExrvJTPfeg1878iZE825hBT0Oe2SiciYzgqIH5i7vxDGyTWSAJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71JdWRQpykuK4DUpdCkzD6AThOMlkJVnKeObSksXK7M=;
 b=Y8PRFkBAApfmvekPHkJpnU/OTZkY8cyyytNpLANTrdmgtvzW1q7fzMEto4rprICG2rQjkjs7k/CTXB65Stkf7/OyDZu5Y6nwjZyR2Eepl8F2xrGdBoLzKE0AdfFIm0u+X44+CnyuCYyESRzFQfqCz/I51RLTc0116fTJRE7akO+HAEAxr/v6T+1K818NTQwPLUZ6vnOSZWoZ2ZRsX+jz+7RMngbiXQx3SeazI+ZFaG5YtRLL010Aoy3hNN5Ofgd4p4G+xsOtJH+JBbbEfGsQLAPajV6VFAew4nYVK0kycDUE5G65QRZNQPEXuhZQ10e9od/Tyk0R/dZQ205rFhQRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71JdWRQpykuK4DUpdCkzD6AThOMlkJVnKeObSksXK7M=;
 b=DQdkKQFx/luoyt3VJmJH3foxEMSJKeSCNRV7+sd/y+8f6NB/wl42rPAq/l3wuxGrCVGZo394oO9ViAaJtYV9aed7lUS5Jhosg4gBv/qjFF1RMqBF7PBomVC3gMTAylADsskR6+JtDQJQSyKvund4Z7gOFcKRFmXazgexGH54CUo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH0PR04MB10166.namprd04.prod.outlook.com
 (2603:10b6:510:3bb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 10:30:33 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 10:30:33 +0000
Date: Wed, 11 Nov 2026 19:30:27 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 07/10] common/nvme: support the ports of a
 remote target
Message-ID: <avRDFXYVmzax74cy@shinmob>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
 <20261104-nvme-target-control-v1-7-b31b40537bb4@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-nvme-target-control-v1-7-b31b40537bb4@suse.de>
X-ClientProxiedBy: TY4P286CA0107.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::7) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH0PR04MB10166:EE_
X-MS-Office365-Filtering-Correlation-Id: 625248f9-8078-4170-8995-08df3fded13a
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|19092799006|3023799007|261021121427099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|261009223027099003|261022105027099003|261021123027099003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	L5GXKWUsyAUFk3wfdlgkz79PDlNkPb6967e8JFMNhXqBgfHBeP4xSxp2flU2N/1g1lFv6kQ5Zhiv2XFCswu40J2QvULFmS7xoaWuaTInQCZK+jcZaZXbrxFiRKtHcpATUVAUtgNBa27u5m9yWMz5BXg2ymAOky59GZLsovl5UhBd+2JVHtIXD3V9Iq0c2A/rvQVYdp2jfoa1vIhiCim7FpPCpQwme334HF79KilSG6obFRaMqy1d4bZfyf/j17mmYPuw9NaEWBLb2/ktMkdXiG6JRglrrGTFcUNcLsHw5k3m8F7cBon6tMTDa32DzAXVRIgelWdJtS3OuMxB1fGyWtQXrtjyuoqh46MQJOgQkqal6usZnvNZj1e9jtmt18RA3wke5rbosUbK+CF/e13zDnfzOc/JWXcocSIHh8UKVkEPgdPtIifMGP/vyif1QYWunOXRNW+9apOy1/rWoHKnWQ+1gvmImuc8gDCrBGERfIpf4wWrr0Cgr6+cgyfpeGf0uDAPmvyimtWvFuN02kEX2yKCvhrC92wjYi+8AB8e0DaalbR95+yLU/LVr8Ctn0hlA48KMsiFS0c3oYOFyFk0J8WQM7TRD5xsjXuqZQFsNI591fl8kDOEHKwzAZm1R8cYB61zBksOSezaAzebj3i58VrtzPq+ngF3zn5HUSPSRTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(19092799006)(3023799007)(261021121427099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(261009223027099003)(261022105027099003)(261021123027099003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/8M6J3Xppqbc8Q7TTlqaCVDjt7VDbleI9kBmhoJRcLLjky02waVUIE3chkaz?=
 =?us-ascii?Q?W2tFc+khlv36prRgueUcf8MIad2ncfDkUfLg2MZZrZ09xJlD3DfisaM4g38U?=
 =?us-ascii?Q?bTwKjbdGYFUn3BnsDY3mBWu7nJwc2AlQ0B+MTqs368ly3RQQPB00XdqtaUgs?=
 =?us-ascii?Q?htg2RRiBMR3/SzxEnSkw0F62zzqnJor9VlY6Yd+pLpEtmguMMkZsndqNtsi/?=
 =?us-ascii?Q?89aBO6FbZWdJ3K7/wnk/rV2gF5FfF25uJsjH1YSiYpJ3f8kuIOpQAvz8Xdgx?=
 =?us-ascii?Q?iDptAs0oEQ2o3nFSKXqV6Z8/V3/UtwUQTinZu3Mi4SABRt7QNKM7IbsPD+JW?=
 =?us-ascii?Q?vCxy8CyQTcdL1r9xWaVuoq1dwGd1kWtOaFRY+ke6qjWLJM7vqkScdKW57uFr?=
 =?us-ascii?Q?Bd+IWTR0HK+Viutx+09eJGI2/r9YkbcuFzAA46hpN7hbxtNd6iHvLMeYDofk?=
 =?us-ascii?Q?TLIcnd75L2plaflwREkc8t064DYeAH1LgIZHgve5aCFl1P5BODFB7ihya/Od?=
 =?us-ascii?Q?NbLTQ0nqvtewl3NShsH1myKe/NawxWyz4MsAgygoSETGXuGsT8twUyfOvvaE?=
 =?us-ascii?Q?zVBQ+g5UedoXLOtw+t6pn7DrxeiIHJzMtYI2SxaPYWuZFkAlO5pTdJoMCuPp?=
 =?us-ascii?Q?eW4Nl7RfzmFK0x+Fn1vUGuw6TP3x3XxfMmdPhMGjoP59aK3WnulX3Pvegpl2?=
 =?us-ascii?Q?2RIZbXS5liBFkBCrJo+F4AyCgSarxTxwno8PjwkgOiUAp9aLgOupOBjdnvop?=
 =?us-ascii?Q?qUwlA5uBcpy+KtumXsoTtE45vfs5qQR6A2iXbQqoqAaTDo2zZYjr+O6/FoN9?=
 =?us-ascii?Q?JXPzEz5DFMcWo6k6nRMYO5dd0u8tQvKod77ioWSQM9LjoBlR0g3l5tXd+ZIJ?=
 =?us-ascii?Q?9iUdUSjzfvfaaW8plDEuP2mkRkvZSGz81Cran7/2/pFvAZxkouR1Oh3hdUhm?=
 =?us-ascii?Q?+OBwY1IqAmvhrVCN34WBPrMaxlUNHR2GlJGAUX+WGO76d8I+5kUwB48bqBPK?=
 =?us-ascii?Q?hwNCVIeRjijmKNsGMEBAzipPD0n4zwlvZWe7nyWU1cTZYGJRM2yS2ryzZAKu?=
 =?us-ascii?Q?5w9pH5NZ8W0ffBWRjIMoL82nTnQZff0IYvCrTEY/48A0bNb4CxeaQG2fKbEL?=
 =?us-ascii?Q?fAQitjY7ocf21DxIMrKYNBzX+WC6gfq+JzKY+463c64x/EdYQ03ZBg7jhDvz?=
 =?us-ascii?Q?3onL2Z2/t00Sb5dnBOTqlUH70xextvsaBRIEgA67QotYYMZ/hPGjYRQQvSsq?=
 =?us-ascii?Q?/Cfo5g/lv5lAzNZ2+PAisoa4+utSZi88SOtdexHUP/30MdlXom7ru3UNAQZg?=
 =?us-ascii?Q?vUF9QzN2AYTfmY+yeyt56/XRT50v/cP/T8HpVGDtPyPbCXQ5qPJZ1IVsP2ML?=
 =?us-ascii?Q?9065yFHqfN0Nd8RqueTNV2J3FkzVU6jiYCyvGwo2xCdFqjGeIe6Xd3vRaKMr?=
 =?us-ascii?Q?+OwW7zh5PW8f79EAQuCj8KDLKfiee5rR0DSpvi38lbUyS1ZZqLzbQdX13Jud?=
 =?us-ascii?Q?ZmpM1NhG7vReM8VmhdCxMc03FC/lpHN2frEjfOLgF1Yg0Car/YK/e0kqixa6?=
 =?us-ascii?Q?WXZOqNvksgYDSzw9nIIkFq+KK0Ge/Vm8yH7XwDdit2W/yn0L1IWICnNGJBN1?=
 =?us-ascii?Q?U2bDWc2GEW9MimO8eOFSYVSnO1rwsLPri0hTW+lHSRLmlRSmGE6KaJtFfvtr?=
 =?us-ascii?Q?bsO6Esud/UOVBTSASXgIaQz4Zqia/PnfB4v7MvZLgkrqxLULbo3K9Y9pwUEo?=
 =?us-ascii?Q?rgsoP8BF5T7YndkfEhvGppIEzqxDdak=3D?=
X-Exchange-RoutingPolicyChecked:
	linn67aAMsdOGbqoyqwaCxwdSX+ppEhBOvp/61L+epBEQoi92wzeYMNQba6Lqv18/TYt0rho8Sq/C0rn0IWCy+feWv6bYKImfLa9f/Mony7s89iM4uJt5aiNwg3nSn916YENJzzGm0kNdFRtANaMmSy3d5RsTL7gt3lynG4XuCzoqvZ04e+Qisot/Gma/mNjRAzpKGj23VkINAi11kLu29INV7I7NXd/ggCZa7HvaG/BTC8LDSyRo7i7Ow+hpMAZgwUrvGuVCuK90fgttLCKkS2lxp4jekZ1L1X3qfZzuhC2bs7E7Rwy09X2EsucrTsY3peiL2vi1ETNIqnMT3tKvQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	byCUnSeYD3v5y+FTyY5W1LNEpgtE+YvaYFz/Hzmsmsul45An48gyfWTJoJAymFk9WD9NMT+xXL7hrTVM4o8FoXnlYbQp/QOZ2bl77JnOnEcM3Vc5hVopeBz8S+6R4GbEfC2TcwB6IbnINmz1hflaIJSNX+jLMcspi8nYJ45oxOG6V3y5zZjzk3tTsdBfPhyzO39HY7Blz3oPQEoQUObVOHA/mUfojB9eSU1GsxlNfCiOePfd/2yp36XCNJZFHd9usDatqu6c+4ZIb0j7EuH9Xwyd51z2z+EBsKiQh6rujd0kfr1k9+1Y68/Jt/O4epGuXCUOkCrkhSC3JlrAfsi7ixtOtCrXj1boBjXNbYaZbN6rZzlAi90vTZtomuXoilmTOaFP4k9zHkW9mFUpGLaS0ThzqU0boLVS43OXzXSIkA/6GuCPlOIx4iOyP9RdRl8NC05A/8aTmNPXWFQ3thEp3Bt527ycFl10WjmB1W5B7REujXxL6UFdC22bv8op3y8H5zNEJ1tCLKEgcUf0GlYyo8DwMuznVM99LcUyteOmRqcMSo6EeS/mf35sQdyVHyZU9I8EcviE6iQWssHMz4lAVzWncieIka3Fur+Zen6p6/bWibv6T5f3HLkbrqN70gTB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625248f9-8078-4170-8995-08df3fded13a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:30:33.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+3oGXeOYoLDZWrcwam5/jmOcWPpRpRkS6qwQGt8/vhQnNe7HZBgNf1z2lBCzx8VCavtqUHL+EO7lBCXz8e2IyJ7a3LvGlW4MMwiWHacWdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB10166

On Nov 04, 2026 / 17:44, Daniel Wagner wrote:
> With NVME_TARGET_CONTROL the port helpers still use the local nvmet
> configfs. _create_nvmet_port, _remove_nvmet_port and
> _setup_nvmet_port_ana write to it. _get_nvmet_ports and
> _get_nvmet_port_params read from it. The ports of a remote subsystem
> are not there. _nvmet_target_setup doesn't pass the number of ports to
> the script, and _nvmet_target_add_ports only reports that add-ports is a
> stub. The tests which use more than one port don't work with a remote
> target, e.g. nvme/057 finds no port and connects to none.
> 
> Use the port commands of the script instead: setup --ports, add-ports,
> add-port, remove-port, list-ports, show-port and set-ana, with --tls or
> --force-tls for the TLS mode. _nvme_connect_subsys finds the port of the
> subsystem with list-ports, as it does with the local target. If the
> script lists no port, e.g. for a target which is configured already, it
> connects to the address config shows, as before.
> 
> Document the port commands in running-tests.md.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
[...]
> diff --git a/common/nvme b/common/nvme
> index dfe85b6e281f..698d6bf780ef 100644
> --- a/common/nvme
> +++ b/common/nvme
> @@ -888,20 +888,21 @@ _nvme_connect_subsys() {
>  		esac
>  	done
>  
> +	if [[ -z "${port}" ]]; then
> +		local ports
> +
> +		_get_nvmet_ports "${subsysnqn}" ports
> +		port="${ports[0]##*/}"
> +	fi
>  	if [[ -n "${nvme_target_control}" && -z "${port}" ]]; then
> +		# The target doesn't list ports, e.g. it is configured already.
>  		ARGS+=(--transport "$(${nvme_target_control} config --show-trtype)")
>  		ARGS+=(--traddr "${def_traddr}")
>  		ARGS+=(--trsvcid "${def_trsvcid}")
>  	else
>  		if [[ -z "${port}" ]]; then
> -			local ports
> -
> -			_get_nvmet_ports "${subsysnqn}" ports
> -			port="${ports[0]##*/}"
> -			if [[ -z "${port}" ]]; then
> -				echo "WARNING: no port found"
> -				return 1
> -			fi
> +			echo "WARNING: no port found"
> +			return 1
>  		fi
>  		_get_nvmet_port_params "${port}" ARGS
>  	fi
> @@ -1079,6 +1080,18 @@ _fc_host_traddr() {
>  	printf "nn-%s:pn-%s" "$(_host_wwnn $port)" "$(_host_wwpn $port)"
>  }
>  
> +# Print the nvme-target-control option for the TLS mode of a port.
> +_nvme_target_control_tls() {
> +	case "$1" in
> +	not-required)
> +		echo "--tls"
> +		;;
> +	required)
> +		echo "--force-tls"
> +		;;
> +	esac
> +}
> +
>  _create_nvmet_port() {
>  	local tls="${1:-none}"
>  	local host_port="${2:-0}"
> @@ -1088,6 +1101,13 @@ _create_nvmet_port() {
>  	local trsvcid="${def_trsvcid}"
>  	local portcfs
>  
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		# shellcheck disable=SC2046

I think the shellcheck exception above can be by,

> +		"${nvme_target_control}" add-port \
> +			$(_nvme_target_control_tls "${tls}")

adding double quotations in the line above.

			"$(_nvme_target_control_tls "${tls}")"

> +		return
> +	fi
> +
>  	local port
>  	for ((port = 0; ; port++)); do
>  		if [[ ! -e "${NVMET_CFS}/ports/${port}" ]]; then
> @@ -1157,6 +1177,12 @@ _setup_nvmet_port_ana() {
>  	local cfsport="${NVMET_CFS}/ports/${port}"
>  	local anaport="${cfsport}/ana_groups/${anagrpid}"
>  
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		"${nvme_target_control}" set-ana --port "${port}" \
> +			--grpid "${anagrpid}" --state "${anastate}"
> +		return
> +	fi
> +
>  	if [[ ! -d "${anaport}" ]] ; then
>  		if [[ "${anagrpid}" -eq 1 ]]; then
>  			echo "FAIL target setup failed, ANA not supported"
> @@ -1173,6 +1199,11 @@ _remove_nvmet_port() {
>  	local cfsport="${NVMET_CFS}/ports/${port}"
>  	local a
>  
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		"${nvme_target_control}" remove-port --port "${port}"
> +		return
> +	fi
> +
>  	if [[ "${nvme_trtype}" == "fc" ]]; then
>  		_nvme_fcloop_del_tport "$(_remote_wwnn "$port")" \
>  				       "$(_remote_wwpn "$port")"
> @@ -1446,6 +1477,13 @@ _get_nvmet_ports() {
>  	local -n nvmet_ports="$2"
>  	local cfs_path="${NVMET_CFS}/ports"
>  
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		mapfile -t -O "${#nvmet_ports[@]}" nvmet_ports < <(
> +			"${nvme_target_control}" list-ports \
> +				--subsysnqn "${nvmet_subsysnqn}")
> +		return
> +	fi
> +
>  	for port in "${cfs_path}/"*; do
>  		if [[ -e "${port}/subsystems/${nvmet_subsysnqn}" ]]; then
>  			nvmet_ports+=("${port##*/}")
> @@ -1473,7 +1511,12 @@ _get_nvmet_port_params() {
>  	local trsvcid="${def_trsvcid}"
>  
>  	# When port is specified, get port dependent parameter values
> -	if [[ $port != none ]]; then
> +	if [[ $port != none && -n "${nvme_target_control}" ]]; then
> +		read -r trtype traddr trsvcid < <(
> +			"${nvme_target_control}" show-port --port "${port}")
> +		[[ -n "${trsvcid}" ]] || exit 1
> +		args+=(--traddr "${traddr}")
> +	elif [[ $port != none ]]; then
>  		[[ -d "${cfs_path}" ]] || exit 1
>  		trtype=$(cat "${cfs_path}/addr_trtype")
>  		traddr=$(cat "${cfs_path}/addr_traddr")
> @@ -1621,10 +1664,13 @@ _nvmet_target_setup() {
>  			ARGS+=(--ctrlkey "${ctrlkey}")
>  		fi
>  
> +		# shellcheck disable=SC2046

Same here, I suggest to add,

>  		"${nvme_target_control}" setup \
>  					 --subsysnqn "${subsysnqn}" \
>  					 --subsys-uuid "${subsys_uuid:-$def_subsys_uuid}" \
>  					 --hostnqn "${def_hostnqn}" \
> +					 --ports "${num_ports}" \
> +					 $(_nvme_target_control_tls "${tls}") \

double quotations in the line above.

>  					 "${ARGS[@]}" &> /dev/null
>  		p=0
>  		while (( p < num_ports )); do
> @@ -1719,19 +1765,20 @@ _nvmet_target_add_ports() {
>  			ARGS+=(--ctrlkey "${ctrlkey}")
>  		fi
>  
> +		# shellcheck disable=SC2046

Again, same here,

>  		"${nvme_target_control}" add-ports \
>  					 --ports "${num_ports}" \
>  					 --subsysnqn "${subsysnqn}" \
>  					 --subsys-uuid "${subsys_uuid:-$def_subsys_uuid}" \
>  					 --hostnqn "${def_hostnqn}" \
> -					 "${ARGS[@]}" &> /dev/null
> +					 $(_nvme_target_control_tls "${tls}") \

double qutotaions above.

> +					 "${ARGS[@]}" > /dev/null
>  		p=0
>  		while (( p < num_ports )); do
>  			# Set ports_to_hosts so that _get_fc_host_port() can return the correct host port
>  			ports_to_hosts+=("${host_port}")
>  			p=$(( p + 1 ))
>  		done
> -		echo "'${nvme_target_control} add-ports' is a stub"
>  		return
>  	fi
>  
> 
> -- 
> 2.56.0
> 
