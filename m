Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794139091;
	b=HiwZDo3IYSMqbNh9ijivbMo9ZYWl+W3C9qKZHUv7WirDDNp/dFAY8hVYoi6vKPDC6I2X
	 bfBKvWN56f27lQWrRgus6I3rfp0LhS6rgdfeRifXWp64XDlrHl5L9dM3fbHYNDXnCK+VP
	 8hWl6cbL0oWxZBRoJA10j2PJI6vF+E2Fk7qnNZDiX/UGwob3iJY04E/LlPhw9/souhFNm
	 MwtAdA7+L3P42pP9ulX7Opuegi5++7sU7WRN1Q9KcqCWYwhIybFRyovga/aCKlziTsCmX
	 M1kOFUzqCcZOxMm8tlLw6HvGFPEWxt3rC6BSSkCS5hlSFd2OUe+zJWVdCBt62Ey4RlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794139091;
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
	bh=KzUdtJgY89svTzCAx4yIcfJ2n+KedbdzUqVYtLotm7A=;
	b=ydmm4rpTMWYDbSiHyTH4YyTNRvDU4bYx/4eueg6iZpDwh20nAuAEuyWj9WzC09eDILWl
	 z/20cq34PIdhi830Z2gnDf82Ipsg3VLsSNPmgSd+s7W8/lurU4+4hgQ05Ttb1tkDnA9sn
	 +7UYs4TP87jMWO3YtjjhFW4WFQn647FWc1ZnHxPkj67TdFwKmtGFczuwUCFOnJH3L9xEY
	 /5NtV/QVVFlJKt0m3SZFAO0UfDYC5LZrknbwgGo4aJMi5QomKSW4eIKCryKtXH8ThEfXm
	 mp/ZXmaJovk+3RppMc3WayXT3zIghxgwFkcg8eGSCURhw8H+Gk9kdiupvoV2KymZ2zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=pd2xAHuQ;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=Es83FLCP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185FF606A322
	for <linux-block@vger.kernel.org>; Sun,  8 Nov 2026 11:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 185FF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=pd2xAHuQ;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=Es83FLCP
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794139090; x=1825675090;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KzUdtJgY89svTzCAx4yIcfJ2n+KedbdzUqVYtLotm7A=;
  b=pd2xAHuQJIkO2x+ONUfsh2HtyXnDh5agNZbDo367K9//YoAZwxdR6ku8
   WGsMRcyCz1kKVtH+OCNwWPdpvJ8AjWAvrqeQec+k5vgoK1aE3gtZHcSna
   kh9pZcuj39yRhYbe8JACI+AxOVL2BfZmIYC5mlBV6JhUro4jgtylcdkpD
   qOHctTA+jL80jEFaxQWmL9P9nsyNcKHHKV/n7MKnqo9MSov50gP3qyd0t
   ISQMZpJiC20vElrgnbDxQXjhC3M+JDbVmZQrH8BLpIPAt8thMZCoaD8YQ
   4NQ2CZfzZ9Zko+0GYDVPo9lIbZS+eUt/tnpdGOR+ivUNt69Y6MDMAzaM5
   A==;
X-CSE-ConnectionGUID: jhCaRFDISTqTaiZP3o8g7w==
X-CSE-MsgGUID: OCXfmdNgR1O7OtIQRIzb8g==
X-IronPort-AV: E=Sophos;i="6.27,202,1786982400"; 
   d="scan'208";a="158625028"
Received: from mail-eastus2azon11010001.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.1])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2026 19:58:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOT5ip4YiqTxOwweAgJZomMgGwP5L4wZieYcghsk9Te6zxF9RiSLcMtdBA+CeZdpW4qRKgQeVSjyu5Gui4gCzhxYoZbz4vDqxc+UKgBBvGAhlVqidjqcQYguoSPFO14A8MHMj6hbC1MH7UmJ4WBYwSNRy/uqjErwkN7Kn/+XRDAN0/OIb7QoNLQnBZryoJ6sa28uQvr/qNvWh26vHM4JSImiI00ENGk4T7MDLOYaEJ/J7RHyJjPj5x2yl5thFwHx8OaopAarHiATELqHM/Z+jihV/Qh25XQznxn1VcZJVTAXqMQwtUgh8mtXJQgGwM4A79sfrhbTrw61DTKyekpcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzUdtJgY89svTzCAx4yIcfJ2n+KedbdzUqVYtLotm7A=;
 b=Oanbm14K9CmM4U/gf+GSwUML8FT4tY5A+/w+Z9/Ql06spW9/tnJjmFDnD8wg9o1WfTTNIIpf6GZ8552Vbv1uzzcy6rG2fN2S3TBcH22woHYHLv4MapZKr0Syw4kO57iFe93zCbbVT5pwJb6xq11y1iQH8KX5dpxjyb/fdvsESRxsRfCKOZpZmr6JdWdLGbyXq1gEvfAO1WPJSV2ixPxfKGoenYCwVBy5wnQAODdMCtPTayyNfaPFDl+HgE/S1AtltbALhqN3hBFhIw+bDgDMaRPT7IvYePP5mSGXR0ljkRYdL9sEN5y0bJegrGBmi+cNRKK/yxcAzDNJMIl97pNTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzUdtJgY89svTzCAx4yIcfJ2n+KedbdzUqVYtLotm7A=;
 b=Es83FLCPn+iDdIng0YoKBBuB1kwl3nKLI/R06eQ3Pdw7+xlA79BXVI3V+jLSfHliRDC0TuwsQ0nrP+dhjlrDz9VeBi9JKSfBHjt5HMSxvrw7LE9TIB55EVtHSiQ8ksAG/cSGOeFO+Qw8oLW3Ls1wCN6y0Wr+Yv+NhBHwx8UVUnU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CHBPR04MB007031.namprd04.prod.outlook.com
 (2603:10b6:610:406::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 11:58:07 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 11:58:06 +0000
Date: Sun, 8 Nov 2026 20:58:00 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org
Subject: Re: [PATCH] floppy: fix the message printed by floppy_set_flags()
Message-ID: <avBjdRJXq1Q9OPYn@shinmob>
References: <20261010111525.1337458-1-efremov@linux.com>
 <de8e07cab4eeb9861e92cd2b14477d7c02c3ca5f4dacedf8abf6e9a4be6cd271@mailrelay.wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de8e07cab4eeb9861e92cd2b14477d7c02c3ca5f4dacedf8abf6e9a4be6cd271@mailrelay.wdc.com>
X-ClientProxiedBy: TYCP286CA0224.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::8) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CHBPR04MB007031:EE_
X-MS-Office365-Filtering-Correlation-Id: 145fb457-4d05-4f15-6bc3-08df3d8f8c58
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|1800799024|366016|18002099003|22082099003|6133799003|10067099003|4143699003|11063799006|261102123227099003|261022075727099003|56012099006|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	pOoiL6XzLoubiou7HHFTBTvuhC4uoa9ohG3rREHTgdhHsKKMGYbdpkO1JqpU7njlqsP0O63jygOtRWPynqJuzqOHN2oO1cgRSoPgDwuAWa46lU80ZMYtUV1/hfKNlgGsaAa5vBBsC6fVim0LvOJ+x80S2UavPkuHd2CtvhFLtmhKrNB6NoU5X6zvgnmRntZrlX7KeVlPHfqH0jMl2dD0f7OZZnP2mW+y1wLrqtj/3rfKE3PynDAwCaILD0vSS4PQsVuincv8sl+cYnN4UYcT99wHOFKvWlkrWBGMY93ElEeIWQJ/401+FgT/0cuVa++CEBPHLuO4fKHBxvULUg02BJxEf41pyYhH8fNpcBsAMrRCwG9oDj7gwqoBp/nCPHsd4xTW1LmXAu3esfr6t0QluC6Xh0x7Pyif4iuBizwsriHrmlhNlolIw0A/gqTdSy0fPAaGkG8jvLi0F/PmJjkUbjm/gcivuLBTDGw+N23SnaTP4vXkMHZNfshZShRjHgyq4yO0pP5y7q3FaaKwgqGx7IRTyL75wVEsTpMNjKco+NdLAI+RieRor6asvfRFoQfMXYgFEbGDwd3248eUILS5n+UAdmjX0Yt7wx6nmoi3mIK5Hdrj3vftwuPP2353/qjoXgTb9o1kE9rcFT+5vHcJiSxZUGMu6JdGPEJWxHF0YbA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261022075727099003)(56012099006)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bUUzNRcmPU04r1s+/sYcaXNFIQ2L7Sm4sTi9A+5qjs0qSJGKkFGm5LL17rfV?=
 =?us-ascii?Q?wAcsIvJZNi5Al/PHt7RlHElPDbG3UfpZ5PPmedEpBf2W9uoAFg0OdNIPK4jE?=
 =?us-ascii?Q?srZtukL7ffGZki8+BGv+ZXK63O+sZAg6e14JWatn+vfmXgcmCLgtWgNjvKqW?=
 =?us-ascii?Q?Fhs9VTKERZJhTOPfe/zyCSvyGzgW3hwn/CKzlijHiWRHDgaex1nROCHYyVwf?=
 =?us-ascii?Q?43puQqk+lPD1WZrdFuxAikafCQK24DDJMclubs6nT1rLQf+CoFx2OFL0M3Uf?=
 =?us-ascii?Q?FgELqYDKh4/zZ92SBni/bxdVkuKISoA6JGmVeIX346MIL7Z2d3JKPqc+2Tuk?=
 =?us-ascii?Q?0sATVpN7xqbNYXtOUqXrVOF6Vwe2iKIoZB3iBhVGWM5+7D+M1cxK4MpBoVdH?=
 =?us-ascii?Q?3kb1PV0CaaFAq0K3WpuSsYhfLcm/sdykiizmZKwsGsLDbvU4t+EUOToWXe+J?=
 =?us-ascii?Q?lwR3Pp4OdilAse33mIPLwF8FXG4/LRAeh81h19dcJ8g37+tPSYhdxgWrk4hP?=
 =?us-ascii?Q?sLn3Luf2XdJuKjZ95ASlA/GMX3SGC8VBTCqNZGic+5hE1sg/L/MtG97Yn884?=
 =?us-ascii?Q?Un8kEdw8Cao1Sbv1oj8UcQ8IUocrUZZaXXsK5VHGuCDM5xTNElAHKHXcgeHH?=
 =?us-ascii?Q?LzqFeEIXj8YMfA3cDVGSIBqBb/HKXSQ/L+B9OgVRTBfj7iCw/tQ2+KJ5sKYy?=
 =?us-ascii?Q?VI/6w0ff7SRGa4iuowlgJ4d5ZvCPqFmYebiG2qowqFdVeA2bQsKWRoiUr4Ed?=
 =?us-ascii?Q?KFL9qu4dqZEuKZvpn2U2X0rz6du/uT20FzYDWwQDjjyPDn2wJzySg/ugPOxG?=
 =?us-ascii?Q?450dz3tTt57OX5c79iBdvllofl0qkSP91apXWhn37hRhiM9Z8vK/WXM14nuk?=
 =?us-ascii?Q?C5vw919QqUJS7JsarpjNF8FI8Y/S0Dyk2+dDx5gJpenZlkVmA+7ktsowHcg8?=
 =?us-ascii?Q?kvxnWNW0j08hEjlrxkZ0YaqDkQ1wSEPV6kXE/8Yk/rce1NNWKNp2stO14iiv?=
 =?us-ascii?Q?9jWlF9f5tU8dMJLl+NWrOEA+5oL2ywgNZ3Wj2FJ8NxXQWESaEwjZ6nxLb5VD?=
 =?us-ascii?Q?yxQYzb9P8JbZ5I5JP2TfQFMHSHLN84VnR1rMa9NzoacQJz3fj0Odmm3uNcTf?=
 =?us-ascii?Q?Pzq2D2Jm7ze+QraHWPClzvF9LFFjg02+a04hZHBebY7xI8Q9kQzUj5QIfb/x?=
 =?us-ascii?Q?nBQoZKRgEbJo+jqnPJtPLvkZ4/euFFUzI05GqcP5B9bE33Lbp+KpfVRYfCX2?=
 =?us-ascii?Q?uDxPSsj9w3K3xIWGMKqc8kN+EG6U2hnBmMIPacxgeB1k+MeU9AjNYLodqlwN?=
 =?us-ascii?Q?pisvz7dkEej5dwbIfjWZ54VqtuEK3T4vSv3UWAH7OYXKbjWE9P/HcFGZ747F?=
 =?us-ascii?Q?FOv9gYxOYGWLmv2UaHwUFkz9v8OlHh10TmpiNqMJTsoiheoroDPN4F6zMarD?=
 =?us-ascii?Q?WsXnWCmKmNXdAYqZnTaZiWQG8EX9o/OL2JuIarK/y5XUiFHqSOjeZg2tJhR5?=
 =?us-ascii?Q?zfSRUqoUIgqbuRUcz0/9cYb4uIE9aV4DnpvU0NgEjjM3TlmVSEje3CCM0jli?=
 =?us-ascii?Q?42Fh9kH9m01r7iHpZ3rhOm0/nuA8hvbGLre2/aZAaPli0Yhqn7XveatqGWyf?=
 =?us-ascii?Q?qwxFjEyPlLwqYai0nDGcY0SlVQZLVgg3xXz90swlhRWDwN02nYf6oqQg/yCA?=
 =?us-ascii?Q?BqFlqAYX+ffXvjCl+7RRq/RVyfHAin29Bu2T77+W97f5TPZwynrbz99R8KOY?=
 =?us-ascii?Q?Y69cWiJ3ThTF4ZPOpHqGtepWZxeBl2M=3D?=
X-Exchange-RoutingPolicyChecked:
	deyg4YDinQRRkHgIceI39V4ZKJejS25eYhn3SBhLf3OymQySEXGZZxysOxGgSG01QOlWljpozKCIFRTQvcQGj8T6ob5nhqE0HD23lDCybEr0esFAyEZ8OPXyTVdP6N+mknaM7lOvSeC30x7e1DfBbinSnV2bfJbVN17CMSGZmoO7ZJ0y/v4mit+BpaXTztmHWPDR7R4Nzkod7swZpcTKZ1k/MPgWPi3q0ri450K/S48MUeAPkEaNdrvv+Hk914NGUpwyyOP5M78I2IKqPi8AK3PwEp3Dhd2uslM+rbd6XQFqo3E8X3JVAxs1mXZLH3/LAelWwOzP6twVzx+/C0MywQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m8+b+Vh63s3ijY+PtL0r+j6svcieOB4wdzkI0haWhrEP1SGIPG8SEUcNWnbTiPF+nk+cBWWiG6YcpX8BXp1KB+l73loZI/9GZiCZv4ZB3opmICpY4TWBDGDp1QK7Kte5jgQhmRJioJLa8Bq1SFJ1aKbgDn+/HASt5UfHvQ7oMojoctR/TYq21Kp0Pya/iTDsLKooLIgF5OR8Rc376/0GVbpujGyq43GtJW1W+OvY8j5ACgPlXUc7L6gUDdVQGKSp48zsLFUHYLMQes84LeKvTT24fr4z/dEbRjmqRMdKBPKdztcbOCnUp6SnobxFZT0Huw2BJFAVdwqFBD1BeG1FKmXymCJ5bC1z24YKvdcQaY0w5qCoKCumT/dz9UcsGHa602MxIXVgauIFjPYUD6NS45qov6wfAW5BXpxsGa/uuhvGLvjWmt1/Gklp9HgrBptvRyRxvplDcGwue7k7EKeO8gtMWLXirX9qKrEjzTYfF3w6hb5ps8sOnTViRSVciUukpF3pTJLWklDzQC0jw9nOIwmIc4do0Q2ZKJZ7gt8IRG5JsYbkejBoDYgx+nsxD5miUWtoHoBZZf8XpxFFTNDigD79YFtiqsd92JWh6f00yHhQRw5+mpO9//RdTUqSb2Re
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145fb457-4d05-4f15-6bc3-08df3d8f8c58
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 11:58:05.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMi8GQNkWk8oP4i10ZGhbqNsZFgFtrVpl5yyMhRNdVS81m5WDSfW4RrRY7dqCYQn2L08hi3EK/nNEULaamECGjBF0RoPygAmhgJc6KGT6Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR04MB007031

Please ignore this report. It was sent unexpectedly by blktestes-ci
misconfiguration. Sorry for the noise.

