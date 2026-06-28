Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4743A4F34
	for <linux-block@vger.kernel.org>; Sun, 28 Jun 2026 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782647103; cv=fail; b=qC7bN61zL4eENijy8IuQUMGR10Jw1MEmWIaBaVzJcfXoWrBIVCxFZgITwrXayordvW+0D4OQQ0fm1rpwSKlOnIF/VDoGEHVexkDpJnmxg60TGoFAfCEwYFOmMqbtFW8yBETaRiaweIiA9qxDf7Sr00DnCxrb4nzHBb2Bmot5lwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782647103; c=relaxed/simple;
	bh=hcuTcnYprthRcJ2Y5z4GIvHufAcocU8l2KIVHyoHlVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p6DM6s6fnwEAQSuuw0IC5kQ6RC/AuV+XzmMUsIRM92iRGIALDJUvtLejclYTA+qYaZxCU0g+ZWXH90wlZ7UWhokSyzfw/WJ1seqoRjxCsxoD3W1DKkP0Yz55IEYo3IkF5Lmo8nx2pC4AEqmwEMG+5THid11ZxNJ2j9iVp5nADN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rOc1Ukcf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rN0tIm+s; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rOc1Ukcf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rN0tIm+s"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782647103; x=1814183103;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hcuTcnYprthRcJ2Y5z4GIvHufAcocU8l2KIVHyoHlVo=;
  b=rOc1Ukcf4lykIMhPxtcvKWrrz++e1q5FhHp97FR+ijIaftCANbUzee5V
   PyA8dpLlt35HCxlMBBcWuw/7FKqlXBwPoTh1TCmpM1gYYv0BwqPZr4TiE
   +evVjlYim+K+glD0f6Q3Hvl9fw7t6WzTlK7ZkB6GDgIEUR/BtFWfx6TXY
   8zA1ufU2IeXgWIsyqpzr3EWzKLkjJ3Z3XMX/VmV5Iosq1lluSWLY7exCk
   LEy9meOYgmhcz1HN/1GXzKHKYyfaEjZKwdXFZuQlmc3JJpIfxmUs/IuLV
   eS3l/vNom4iSfeXYEW+qlmnsLAriszqUB6aabl/jKMEOnbr6e23U4jZZ7
   g==;
X-CSE-ConnectionGUID: vWi1GfwSQ3eivhB6TAhFFQ==
X-CSE-MsgGUID: GI0usZpOQZemDxNe/EnNjA==
X-IronPort-AV: E=Sophos;i="6.24,230,1774281600"; 
   d="scan'208";a="149982868"
Received: from mail-southcentralusazon11012010.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.10])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2026 19:44:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyVkDzI+9OkulNMaxelvlmFAn0dxudkMeoC39lNtlgGY5Vi13LN0sFeGa8V28+SVuE/h1fShcHXBULS/QpFl1KK/1qJ8EUKiIC/K7BNxCMkykvpbzMCqiCzO54D/R7/55gPy3OsCbAMnlhJYenNdKLmaU+cyrn/jmzTdu7cPx1nieuyx/AUbtO5UwkW6wqUEVJPY7cs9sqijze04TdwkS5ibjsROKrNIA950cBp/obvs6nfoX/XO77I4KmEA8dNrg3VCSF9D/Bhzo5GDYElQFdhAaAFUvWXGKUd+TABgO7eUx7e2kJKe3xLSwXicKpVNTT2JLpJEcYWFGr7zgx0saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eziiL7d3z0HjpJKx5wQlx65eBNbDr3U0QIANpb4GjBs=;
 b=F+bavEX5NaYVRgGmhvLltxvPYAZ8O3tXl3x8/y2+VpNjdVXIqSYy0T5E2vQr8B8MyO7R/XjXNtITGtFpz1DisUiOwBx4Hcwb5/lwUgkGv1at5bb4zEsMx2ptDp+s8qVG9+JgaxQfweYwQ6hyxSC8pCdI322PMOr19t8cViOTaRuVgyx1RlpCy+x4jd7nuthy6IHTu4Nso+veRRe+kry1SpY6BxmVctyxr8/dX+ZJJbY/3Ou8JCIo45EST9Xka9OGPxKMxarzg0hAIE2cCRbW+ldyjarXJb8bufIEvB1IAhavma+1atbs7QiKlYRKvHMjbThJdGNPk29HresLcdlIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eziiL7d3z0HjpJKx5wQlx65eBNbDr3U0QIANpb4GjBs=;
 b=rN0tIm+s37Qn3EvZ8BgnCa6wvQmysWK5LaNZdgAfhKHyeGmpgWUoQMLl89O1cLTdPVjFzo1urW7LlhyY5/P/3SGfyj1FwC3GlvzpC8E7DeEBG7oZX/SD8wjWeN/X5DJohGIlIwuqWdxawvraRZ6BVPY4UbDS1ly/aoEIMa/3Zd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BY5PR04MB6487.namprd04.prod.outlook.com
 (2603:10b6:a03:1c4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sun, 28 Jun
 2026 11:44:50 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 11:44:50 +0000
Date: Sun, 28 Jun 2026 20:44:45 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-block@vger.kernel.org, 
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH blktests v2 1/2] src/miniublk: switch to ioctl-encoded
 ublk commands
Message-ID: <akEJDokK84oUsQWU@shinmob>
References: <20260623032707.14439-1-sebastian.chlad@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623032707.14439-1-sebastian.chlad@suse.com>
X-ClientProxiedBy: TY4P286CA0066.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::10) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BY5PR04MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bbfe7c-b903-46e8-4e6e-08ded50aa986
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|23010399003|18002099003|22082099003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	fT7+8I3lRpdgIm90ziLtA0YZEmy9rvHgrd4+YbuH8bu9oNRGaV1lZwZ30Yxw0O4SvUVaUErdsPfmMXGK5+tBxoXhnVm6DSoJUum/o0a4EK/0uCkGFmKcR3SDfGCYeva6kGLZ3Sd0uD6ET2O9xx2z+/Wpu2Dil+w93JhRS2uxy9fca0qIsvPc13QMBRvXwFvBxiE6yPmdD6jeqbDbc7ixaA/s2ICY4tnaj1ezs853/u/+Kubz/2PzWeDgxJKR+X30ms6ogDj+QuxvpxxipU9XSvTezeQ2BRdVy89DcMPrIme3K9PzbgeSknmHOZlmkqEjZnt1s9qknvWGxY4UDjWFoPlKEmyrQelOcx/teH2Xp0xsQLMKj+GGEVJrGIxnzFOmTWU598W3xeqy9l18rDTaE2Bqkqv3MdQHhYSx38qgn3c/9ev9x5MvoqPd8Imp+159cXMPcCyHOCFkorqM79HfeCEvwHZRgGj//a6hFgBoU10Vqjfu1oSytXFbsKO6VK9egh4eHuTucb884gW7Qzt4EbxvxFWa02G+qbfKejHHBOpLVGzP8BM/Gf/PP6BjZZOmQ4+tiYq0Uz+xf8+wvnKU0f4o7Tej00TDw4SZeVvCt5E4bMXxgpbk6cnebvb2rJeBk1Sjw/u0uxWElJrhBCl/BKb7R5sGc/fSYmQuHjU8VAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6zT9KO0NJoS4Sl4DfLwwDeYmasMw6SxsxcpFqkb1FQmjAY18+G1WwvPQORzH?=
 =?us-ascii?Q?y0q00fes+n2/slRjdzXE4fT22l3c+RFU2okQp7g1eaI83FVwIltbs9jZl1wp?=
 =?us-ascii?Q?NK1nsXf0X1dquZaZliBiYXiA0NwC+XgnCBvo1uqwGN6hTeObU+9ar3KoO5lV?=
 =?us-ascii?Q?UBpDlc1K31WSq1Mw5IB0MM40VWT+eZOXdsjxEpY5bOjl7UCj12i+fPQHKhUo?=
 =?us-ascii?Q?JyePho3T/6tVEPK+IXMYAT4kDBmznpxD47hVzEVL5AfabSanZwkFpn35O3bV?=
 =?us-ascii?Q?zWvb/TRRcUDyKbxPd3R9DxfK7e1dGD0N/OEpm9Okxak3GlNyHLzWSOMneyoI?=
 =?us-ascii?Q?a6yQZ75zJKO6cO4dbP/eSRSqLFQRzN0hobootlXS3/zrN6vEuxn66KPfDs1z?=
 =?us-ascii?Q?ZI3aWpAhzrnviMn0M7T3Z6dIl622MtGWUZBsUByE3sbhnNxAcNLFd/2lug34?=
 =?us-ascii?Q?5C37ZeZfp0J/jPesiFFW1BdTYUklstSeXwiMPKdT+aiug3ePyxOP/7R19n7G?=
 =?us-ascii?Q?pOrLQKLNiTjjhD5TaJ4DFyQ67oLjKPDxH0yZTX8ffDoMlJQN8kIV79vR9D49?=
 =?us-ascii?Q?oetkdhPukIW7iH5CFOXMc0IDd4rjr1J0DsvqXEO0QCBlAmtnJ71955fpx1yq?=
 =?us-ascii?Q?3duRe5vVLGP8sK6ysAzCsJkxtdK6DQU+aZTLD2UabuIDcObKZHfPmLjGSSCs?=
 =?us-ascii?Q?IAV1cj+MRRFqMcZf8FGr9hrowD07gghEXXYH1E2l6F4P2gfnVLpFBzLpFDLs?=
 =?us-ascii?Q?6TqOaYYmxv1RIfk4OxiAL2DbqVxVNvyXFcsRDXOROjmnyPtfoBo4w8es4sgU?=
 =?us-ascii?Q?ce5spIkDD5JhUlABdbFhiUMYsMVSNMMt3CmABnpIhp0p/ymwQxGLevucOked?=
 =?us-ascii?Q?AJBz8PXxdIK6bK52IHZFfwk5mZpS9wUYg4F2+XPA1ju6c3ezF9bMLeGdjyCs?=
 =?us-ascii?Q?20MahrCqCl/VEw0vV5Pl8wRSgokKMRd5wx9gOVTfKwV+CHW5lBQ4pB+yYWBU?=
 =?us-ascii?Q?8njXc3u7huI9roXnUKEWYgkscz63/I6odXyBxP7vng1V/honqEkzNzmGkPfp?=
 =?us-ascii?Q?LDqxZXQ0TIqTqXNcRe/P2c4aGeY4g/DtjFwqH88UlTiKkWA+AzxpnIkHRhW2?=
 =?us-ascii?Q?RkrNPIpChhlS8XsSN1gx2wLeNzvgGOplKqmPhsl564rfnMJ72Q1CS6SpuVFC?=
 =?us-ascii?Q?fXZyngdEmkecTZog2CzsoXW8nMAcVbZ23wTquy5M+vpaaqkYBQAT5lfXhg9V?=
 =?us-ascii?Q?biVVcHqocg390wSJ9Dt26yWLKpVgvEWFIWa0Tr9YVJphjLOBq8V54TyzrBzD?=
 =?us-ascii?Q?LGmSsl8uNamYV1ky8CgAodQD1pODXbjgNUXRZrJ7zHa2SqNby3p9B2Cp+fPx?=
 =?us-ascii?Q?uMoBM48KmA94Ws55lOcVb0gWYr72SGbg6rkUd7sQ/GlTiIHxGgjQWn9Jz8tU?=
 =?us-ascii?Q?1oiD0bV8uH233/Z53YknPNNJqXXHxkJ5RQXenwzN5K3dSwXBcbUPI5rwfG0R?=
 =?us-ascii?Q?JbtGm5dnI0dLuqqNM4N6Jlkg+LK9XCI59K31QCphUOMg/rUnX1fRHLFDgpP1?=
 =?us-ascii?Q?T7qQFl5t9dSRzfyqlu7mfMJrPWQAryYkPaMh5S9oSdfaBrDH/dwTNNN/qpm7?=
 =?us-ascii?Q?awC1ZoghFPd6gsRjwtVr0rPhwbjQjU5Cd5t+nDZganHpP5bG/pqAdEeiXuIW?=
 =?us-ascii?Q?eH6Ec+weyklD2bpgDgDvthmJIGzugOJ0AkZxBNs9kOe+aIYqHR30rsISR7+P?=
 =?us-ascii?Q?ymat6wSQa+RfqAEJ+915+cxFFSl6bxo=3D?=
X-Exchange-RoutingPolicyChecked:
	ReW5ei8rOpyvfWk5wAdlbVeA40b40JkbG8usWAJ6TBGaeBuCk95/2v0LTzmfV7wL3WgHu2CgXrzd9TOMu23Qvg4GCOYAx4FyqOqcA5z9ULukpgJSrcW38dTXWKKV0VdPA81LQaaWg8DirRJ1main9IKo8dj2y3PhIGK4C/Uj42513pq1Yidh5JJhFM2HHS4Q+ZQZTu6/PNafPK0LgwQV1URMEl3bXKPEq9Xru5oImPcSu3wjycOBpuR/o8/5gY4HPpj6b1vSW7H+eVCXuOAs4eYL2j5hiFjwNvMzm/XDSoq/MxBjFbY9VNR+u/QY+yEmvVB723hIs6dFk/Lma0UEmA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rXCqtJNiwg0ophby6lxHCZQa/JpBaVAbvwRMxHEALysP61wntsSSKiyDrogSG0XbJJTDVmLTQKm+EqPGaTb07UPFRqLAD8UGMMuNhQieRtUYYEr/y/P+D+mWuRlMRlct12SAlOvyrYc0iRejRePCE1is9tlLAmojgqAQxIGzp50ugwL790+vzrKnIQESi/QqzU/WSAVbXb9/kCVWyTH2GFycWfEJbTMA84xvY6kYjpfXptO77rvPyYanqR4kPpE/P+0KKJfH8je+1JaeqV8iFcBAvZ1ObCZNaD1Eqi5YQ+zixekgv08Y5s7D7Dufwtj7YpGnwDNwmIiIl5dUTAKdA7opT0Qqdz57idgpZ8LMCpI9xlkgQZ8D+7bnVWxU7rskYF9pbrq4F2ouBTzukD8pIem44JCMDG77cXEe9nxBEcF2bfiPzx1p3xUHS7+PQnL2HR9hQFCqOmk2Stn9EcJfVRD0svt5jW7B388T3PRKQFoM9oMJ3qysN86M7n0YLxJ1t8RH3FhdAY8nQ8591zStWUPQnHneyx1YWwmJb8emXcMlZsKJpNKJ4WRmmCtD2KF5nk0pAvtZwpYG0DAqHD7xW6UGVKxlVZnbjD/XtJ0tvsA2pTqA9pipy80pGELD+Ksc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bbfe7c-b903-46e8-4e6e-08ded50aa986
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 11:44:50.4556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wo1K0D6IYiwFzOI7wAEIoKEsnPeZtLjDPLxZt7I2EDX6vQwjZBK+STQ1P0Qw/BQ3Z1tktmNTDIkzhf2/KSTC4NL1cpEMiTObvIHiU292hUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6487

On Jun 23, 2026 / 05:27, Sebastian Chlad wrote:
> Kernels built without CONFIG_BLKDEV_UBLK_LEGACY_OPCODES reject the
> legacy raw UBLK_CMD_* and UBLK_IO_* opcodes. Switch miniublk to use
> the ioctl-encoded UBLK_U_CMD_* and UBLK_U_IO_* variants defined in
> linux/ublk_cmd.h instead.
> 
> For IO commands, the ioctl-encoded opcode is used for submission while
> _IOC_NR() extracts the raw NR bits for build_user_data(), keeping the
> user_data tag encoding intact.

Thanks for this v2 series. I applied the patches.
