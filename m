Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527380;
	b=sxC2sCBiU6tiAnzRA5r/aHR5qg6V8moRSRqGIbJ/80WZCsZ7XnB/GFxc3HK8zQ4JY9B+
	 LUWA0GEHVy97JPO9tabmZxU1S8rQ+lTWRDKHJ8C9/w35wbBWbfm0GZNQ9/1dSWmdVud5e
	 RPEbeuHaAKDDHOKntWBF5xKIhfcHzQW93NAvlHHGnBE5uWwpXcr0uSbFVh0X6VtkEjnE+
	 Om9ah5de2WIxXuMNyf+zoZUBtzxwmKx3Wqy205W/ur1yBTE1M8RwsUN9S78ZlH8lUCwjH
	 0EaIMtvClrBjJxHzauiXCdT+wg5RxNzv2w6xTdoxQx6l6FQR3zQU7nu6Z2d6I/5XDtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527380;
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
	bh=ztSWZEh90JvoaQ0FtBKa0qwv7FhontWa8IG7arWGkBs=;
	b=lD2uc/8AtZdLCf93+6K9RR8c8np5hZf9mx35ED1R0ojpWmHeg/AGAadZWtyuHCPU0A9C
	 YsImKafUdpiJvwwsM+3Wt1Db9d+mIMaQJbSYEjKHWq88vd28doRbxvn/STbOtxDgpqQVv
	 NRPiGqNoWN7K++ECpDXIxzClkYusfciBcXLlETF6fwqE1YsCldrWZDnhGtomi/GiXvlBL
	 q2LD6MlhCYezbf57g+N/qp8wjxsdRyQcwp7WMpdWoleSuwYGI9b/Iy/JyHNiO6G9XyjQZ
	 WnEGzE+OlxN7ye/fVtlKg1Dzza8lGS1XbXBsrEuzAirw8RalI/SgDGOOXOhT4v6Hifg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=iAmvEs1X;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=iFvLIJ+4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DC1606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 13:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55DC1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=iAmvEs1X;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=iFvLIJ+4
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795527379; x=1827063379;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=TestEm/0Z9yqqCueqjBcIiyzb6BA+xtWHZpt2PoUdSY=;
  b=iAmvEs1XMG8YPXNM9qXa5f9Bh5ITjD02gA7cmeAATMJcrtqsPozdyUXd
   QJHtkdiqswZDDAQ8f8p2V+LykxRct9kGTS4qLCr/A2Ho/rmQdF/2H5QU6
   aj+wx5HFRZTedtetXbN/6ysBnLsu8sSf9yqBV73nCkL0n4Cwr7OuoP+jm
   F+PZiarfH9Utn/E0Hxzd/ra+NJj2pBd6vyluT/IGJT5iP2k6BAN4S0DVi
   1PGJkbeILvFBqWEKfmtAMcqwH8gERburYNxVSiH3qqlaPltQq89CafOpb
   0RXykdmSFOjs/lq+amh+mHS+Ywxbxvr4VcoHxAo/oJ7p/GVyP/sTcaETQ
   w==;
X-CSE-ConnectionGUID: pKQVyEMaSoqDhWiFLtDETQ==
X-CSE-MsgGUID: /mR/gc1CQXGPdZ/10/NsNw==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161579891"
Received: from mail-northcentralusazon11013062.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:36:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8FcRqyRonJw3blm8apY8fGQXtxm7uMN0mRJMNMetigc9g6iJ4TA0pLHFInUt8+BTOSJWjGayrqZzhS1WTh2uh2dmsdEBlhJNejwlUTOLF1zNXe2fSJaSZ79zRcH5xqklWIfFsKOsuNEChMEHT8kYVoHi6RtlNXampwcCb7VUKxTNXbdp/q4JILj4VIHdbQbfF/bNLUT6VgTh9+M1XoWk5mDNVtJFcOpUw7QIihcE2aX0tP3hu8jvUCixNwRSL4AzhxErz950ywK0tTt7lq2KmtVRnVl43XyS3Pv8+oMoVMtNWhL1R24xZuOzSFOq5tDpMD+H2MVPQEgl7lv4EPamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztSWZEh90JvoaQ0FtBKa0qwv7FhontWa8IG7arWGkBs=;
 b=wXf6xSmC5D5o6GOePwLioTpYED2MYzDblu5DohOtlPkoqEqjjju/k6VrQw2lz5It8BRTaxe1ZgikXnWQj+2hAXiUtRvljWEgxKKlB+oRcXqsnBd+PfvJw96CkFfUkX3AtSrGn1ePaGISbG37za18OTMPMmYm5p8ml0XlX+7mE/kYtzJ/BFldNfJZSA2qxCiX5J4xTRvsS/1tTYAwgejphQ5g0UMf0Inhx3HcsiUvRo+ph2rytaRcltdg3VZmaB816ZUTkEVcgxJNNTNouIh8JDle1faXEJVkH2+i6tb9LPrtp/T8htH24t04COo57cMBN/ecd9I6YeYBnOGqlG3iYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztSWZEh90JvoaQ0FtBKa0qwv7FhontWa8IG7arWGkBs=;
 b=iFvLIJ+4NeDhMaxUHTK2xeaudaoqtab5mLIaXdBIfx93fz3TeAO3jJXSHeWysTE/WgdxxJgKi0SGfkoFkcNt8TsQ0crF+wI5/84P6MqOM8jlE/95Dgrxt6IJqaeXnUQwcBkeUYQ+/cRCaKDtHXMr3BS2TYqX6Zi1T0DDqM+UwNk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by PH0PR04MB7527.namprd04.prod.outlook.com (2603:10b6:510:4c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 13:36:15 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:36:15 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/5] blktrace: add support for tracing I/O priorities
Date: Tue, 24 Nov 2026 14:35:48 +0100
Message-ID: <20261124133553.152463-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.56.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::10) To SA6PR04MB9447.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|PH0PR04MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: b4637372-a529-4040-c692-08df4a2fe948
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EnnyQqYkAZB/UaVYLy5wKOGk/fk8mVp0VPp37GWpJU+aoVlumjlvZJQUpYlrzQLYXffcYvBHA8sZvMZEglKOwpS22W/wAGCoym3pPng2AI1513d1jpOwWXAr1Ikh6DPBXLq4ioVcc+1WQ3/c8lxDntM5P4F+EnhyR2bgCIl2mpN8P5hjtmsT23SK43+rBlUCL8ZoKzlLRqdNZln82r4hjk0/wfcyCv2w4vcn5ypPueac+4ZYoqET0JiB/GJf0k5AiD9fV4f2bpqOxy++8YSYpDkrW4UL9u2o1mMtV/8uz+XAeTeVz9rs40RyOVdj+NDDpMyuiz72+T837Gp3OY2a5WgWqFhAB8U3q2yNf945jzL50k6HVh9maItUohFEsnhqLCYTlXQWMSBG/xUJ4HEd1VZ9JZI7YZ8sfmGFduXvFWxgRAL3uIziJfdr01APUrKFo8XbC4LKbSHnpFVbGCeR3/6MpSXEsO1sk4vKUHjInwb2cE6tZimradssRyCjG0CvBWy2osP5Slq0WtWbAz5Lu/Zpujqlyb3nRf3ENg/PM31iFw3HZa6U9tsQYwsVAv3KLNnV+yH6qIaYItwLkWloXmEnNCYkIRbmUdn/FbxxB3GlL7qET/JXG963F9NGwugwoLGjOHw7ZVZ5q97m0FUJjkVH2ZK4vYSdh2ksWJPg/2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rlyY1GiEleZsqIlII4V/geY8atnJMWb2PgFbNWNiECDzu5D4bLDR7xUAEZC5?=
 =?us-ascii?Q?31b/qcvcJumzy/p7D6o+X9jBieHZ0R0SrA9VjiUvbB8oVlcT7YwGAJxhbTPx?=
 =?us-ascii?Q?a9IP+LwRxKEYQ5a/mgUuvoqdyzuSYugxepvXwONU6TuYxKURKZIftuRxPzXN?=
 =?us-ascii?Q?C6POs9yOHwiMerjO1Fg3p+y+mpyO4wYNmAtuna+bkXJAwatBzrXTpelh/NMW?=
 =?us-ascii?Q?S20PlzlUrtkfffLGRy6pR7HZvKK5qdZtQO4yY3JUvu/sgAl6YXkO+TDTkwJF?=
 =?us-ascii?Q?M4LxjiS04OQ1mUFoN/sofwRB3+exz9jwsE7G0LRQ56zDzLRw/7mG0ZdcKJzu?=
 =?us-ascii?Q?CZu+YIkA1M9uWSO0HOjd79YSVjkjCn9QEl3bPFxKlK0G/ZvV9hZEpXGIlK3F?=
 =?us-ascii?Q?nMutgyLTBaDGWbVU8EGdG8rGaDf9guriibWCqXtb4YCpzY88P+r7wJ007R+Q?=
 =?us-ascii?Q?uCEIjrDcmjqGEunnCqbk1Vo6hYFO3GQaEZ6TSm/ILOqzwBAkylHZZ9MrzZQ5?=
 =?us-ascii?Q?VRmsDhhwWi0Pr0oSxEScGYKDxA7TQ9uDKGe8WhGjNxDzD5v7mBXtPW+oeDLU?=
 =?us-ascii?Q?c8MUR3c0TDIIfh4+T70S4XxN2o+bvUgNdM9t59dNJKEef+1ecQ3uCN/oOLNb?=
 =?us-ascii?Q?PG/lFJk+pBIErmmCVdaglCmAln37lZKNxVsJM4vPhVlwzVVEDgwx8s5cZf8z?=
 =?us-ascii?Q?uA9nNxxJbBv0p4Rvlu65FWPEh5rJdSC1Cx2WToSDyxjFRiW1QKSAzinfUqHT?=
 =?us-ascii?Q?q9Mc5LIy7FHgnxTs8yuhg89hcZDJpEhBzk1GL3axkjX/6XJ3yjuxNLEob0vi?=
 =?us-ascii?Q?jFPQyH73n0kzCbRqsy/Nt+izUJpCkq77l9Q6SXk233PRZWdnnT6N0LglY76+?=
 =?us-ascii?Q?kqILT5sSR2uegf8Z8Bh2FXykZ9aVCEJTFY0rdTCGNxhRUQGvRL+tA0Q5UCll?=
 =?us-ascii?Q?7nmhsams063GzMECWqqrkB/JiIUVp+ErNhqZoxV3lAm3Q4SPK5Kp3bb1K8mO?=
 =?us-ascii?Q?tYOiAiG8JXeg3giFRb4W2zRN9zxFWXjL0Nzkr5biplQSZqZGYIojaufvwAQ7?=
 =?us-ascii?Q?aFXd7dcDUCwTmV3FUT/5HM5m3fwuODqBBeUMdCw07/4NV+5h63Cf+YdO1Tex?=
 =?us-ascii?Q?h+Nd535S0p1cnJNx31tVcvj5xlGjbCf6CSKmcPlGM6XrZTrn4kue+Xg87i1x?=
 =?us-ascii?Q?WRWv2yJURrzyIF5uW+d7/V5VQobWhxpQ7mwXrJQFEcAGOqXzaVOUNdF6Tgoi?=
 =?us-ascii?Q?6TnS2wRj7rx6lsb9vPnzzXU0l4r6Nf8dg0dThAB5SACwSw3Md6Yy4zzJar+f?=
 =?us-ascii?Q?bRJNuxM30A8zwPg8S2ggNxOlpzgz/uiiEgU6skDPa7ObZJJB12/c1DROellc?=
 =?us-ascii?Q?BObUxVwlCv4/J4HfK1UoKEpvlpjrOccTdtiMGy+KWEI0nqlCsNIxF1ikDqSd?=
 =?us-ascii?Q?I+0Tje1mn09oV75HM4sJe/mGxNW80VoRVMu3C+iP4uyq4xhCx1Gnf9VAUjnp?=
 =?us-ascii?Q?NkMTsPR3NF1J743OybznxvGmdX9beZSr3ZMEMbnuBzLQESaRLJ2KL2dom/RJ?=
 =?us-ascii?Q?ChucHpDOu5grni8OjD4mjI8a7WfJ8lUlQaq8YRI2GKru5IVjGaFyE2pawD5r?=
 =?us-ascii?Q?iu8Uzpd1BssHoMdXjy5f3QRtXJHWFrjHyMnKF0E3V+lcsoIDIbX4dk3ROyJi?=
 =?us-ascii?Q?VcBmKiC4c/Ay/RZ6ryqoYv8syA1/98ND0sswJti0lVdaDyZfUBEI2pIYUnqe?=
 =?us-ascii?Q?ypX7OWq6WVCL3yX8KyDp74kzlJOXbvkaA4vp+ZSc3hTP0x16oeDBGWXnZTxH?=
X-MS-Exchange-AntiSpam-MessageData-1: 3wO1pUyOLDWJiq0hb3yc7nq4p1teFyrGbBo=
X-Exchange-RoutingPolicyChecked:
	eaq5r2G7bdpgTGG7Yt+7McN58cQAYch4zgyjAn3P2zNQUuW/DdrMOSXZN0WmuxTfLed0o+yVvSvGy8ZBmR5M07OvnDtfornHsk9qvQX7Dl3RQvo4EcOMFqciENgKUKE+K89G6YNQpx9M8mE6ksv0I1/bP7dQMH/8V8ttCYto7gTjLtl02FjPaiYD5mMJP6r5JQLcuBVhoWxVTcY3t9rLr4MXqVk2rQKZmO/fxR0xCg4dS+iOg1EV14lhjBzWlHeFaviHIW33qPnkhkGhUY2Qz6l9iFXuwWgesX5od4AXcuK1UcfloU1EnO8x9bQhUxoG/CuNCyPS40eLWDe/Zf3Vbg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iQ4xpSJkI/RHZ01nnDiiAyHmns2NhU6vfQuLky3kSm2z7YLfQw6SnAlU360/UF0y2aAUkZPXuO3z3O5q49ZxMXeJSSEFtj87N7Z6S4eTWvYtEn4KiLHY1hesLzLesgie7DWIxW3E6dYyGdkqCUvnL6W7ZP4DK1uQqvjDJBoaEEOHl+5ZZLk+fru3Wa0x/qu8Se0DmD9z0yLQmkZOstFNrFv8/6oL/vNTazjV/1XlLBmVxgiEUAPSWQaDMejPkSbGNkK4+JZ/cKuKT7OwL27iowh/QjP+uCKnPrnQwQXbjTnSkDhgurT6VPiiS9Fqs6EPiMwadvAFplVpTebVwTF1eGTJKAIqZE9wAWmukfr8A9b5KatpIVscJYRe+X3LXWGZKp/X05qnaZs3nBtOJ8llg4HVAclPAeSxoeMNcHaYVTHnqsxXhzz/PMdwEPm7OximsDmeN2tBZ820u2rQPaDuTMkKi7HmjeBMoD7P9ucC+WUdMD97OXwDl7DrCJPkkzzc/s925vzPISIx0jHjiW4w0jO7eXP2VACttfIRUWtAeOFRWEiBRduyjDwBJDkNWejPBD88sZW3jCGDBF6a69WmUZsxhBciV+uX+aRSc1Mug6ddgVJGgUehcfcm2GYsqicX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4637372-a529-4040-c692-08df4a2fe948
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:36:15.0392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbJzP8LlIAZMfeRsChkRDIK49FNvzvmnbmyivAy3oTdTXSWnJj2RvxuktiGR8/wVd5aBYwu1geDFpT2OCBd+yV7m1C6bLb3QzWCnAFOhOV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7527

Now that we have a new format in blktrace, we finally also have a chance
of tracing I/O priorities.

This series adds tracing of I/O priorities to both blktrace and the
block layer's tracepoints.

Johannes Thumshirn (5):
  blktrace: add ioprio field to struct blk_io_trace2
  blktrace: pass ioprio to tracing data
  blktrace: record I/O priorities if requested
  blktrace: decode ioprio on ftrace block tracer
  block: add ioprio to the bio based tracepoints

 include/linux/blktrace_api.h      |   1 +
 include/trace/events/block.h      |  50 +++++++++++---
 include/uapi/linux/blktrace_api.h |  10 ++-
 kernel/trace/blktrace.c           | 105 +++++++++++++++++++++++-------
 4 files changed, 131 insertions(+), 35 deletions(-)

-- 
2.56.1

