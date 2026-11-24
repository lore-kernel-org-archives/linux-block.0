Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528231;
	b=nHxBWfCas0tLzdoGvJOLnmQSFD8btYm1U3aJ0YhSuSg812h7Ok+EYjoq7MhNOYXNh9mR
	 I+FsmPQgOIUDcmi3qIYvS6ecWoSwa7LUwyGcicu1O9vTB3I5uCP5Eh1gS7jdguGv77kqm
	 HE7SL3mI+LvQ8JvPZv5iN/49PCchvVnHTT+jiAZPFko7z3Tgs6GPYC73rXX13jxIbyfCU
	 Sek/rKZs23SSLBxsL+rrRxxp9R1+cueYCDReKXk7DqrFCUlMkcppcHBGPCi6QrFNRlMNZ
	 Y2C9aFQF2AEUkYPPgRUGBDs+AC3DH/tcNKaTf7KKmg/rpU5jGrVaOIzXGu5UyG9qznw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528231;
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
	bh=UpXwVdnE/NbAafD2+WxqJF6pgmSn998upnsRr/A1w/8=;
	b=F1CZMEA5cldj9iSVXXoKD/7jgAbcVnoniX3sftSBqq/SS9fuS6xK5BrQ22+4kN5u5T8V
	 bC7XLgzeuiv4gG7GJdRJxXFDZHDkqd3H1EjHa/nSAMzN7ktLgqc6t52sW+QX402Gs7nfF
	 7QXSs3inaSrxUUL3Twy3aHhhvrf0JAo/mQM6Q9aFgGYSnG9FPTZKGmsQUzNge5M1Jt+/S
	 kMWLWOaWe4VVxfnFX8oA6/78QfxtaZRWvp/E+iPMWb/xwhCRFynr/zctw3w8wGDi73GUw
	 hXhNSs74JOMIRqFfYN58wVNfdMlpMMHW1oC70nMKj45TBsvTGJvG39PSVcK70rKWA0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=RmbSjG53;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=BeKLpS1x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFDD606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 13:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAFDD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=RmbSjG53;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=BeKLpS1x
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795528231; x=1827064231;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=1S0VRW6vUvFi08VjOeXNFlXx0a34A6V6Krh0CV9ZgK0=;
  b=RmbSjG53d9n34K7oItiDuwy2rveMMNauvbhQMBQb1+e9CTw7NT0wUBNa
   OwbAGFYI6B6DW4yXX/6pZi2TwQjiI2qP7Ef3yrnU5Z55tMUn4pmdJH6wD
   TXn41mdBOMlMg1mr63zC1g2H1SWi/IAWU7esPkp2BFYSYpX8CxYVawMNk
   kEuqlIiRbR4gdGMFTJoCaH4lWubYeQRJQTL/5bmMwUk6XIt6Ps8XCs5Zj
   3XskTLoa1WjlyaPKsq7BxhCcg4wRrtGMD5128SivFJxfXOILVFv0nCLOs
   uKxYbZJyarieFdDSYX0dmUsfuWIcY/Fcx3AL7Q2liQYeKsDjw/JxeBnLO
   A==;
X-CSE-ConnectionGUID: Auiqmq1HTuiYtIBTDeGK+A==
X-CSE-MsgGUID: B+Z/pDCFRvaoMYf3wmTCMg==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161651015"
Received: from mail-westcentralusazon11013027.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.27])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:50:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hnn+NWAFcqG/7ZbVO3f2aNCcBVsF51uHNoYqJwWsPxJeYhHEk1+3w6FN5VA1UrsaaR7jkhy6uFazRKXoozx4kkOoxiSggOC3j2fdtc+Kjn53EMlPXUNU5Te1wBiBm0+TCm18m9LFd5sJ9K2eV8ffj8W5WeV2P4p3UN1+lzmGsoNVLtj3ubHQrLfzyPavnRG1jPXYCwBC80Jib6lcnqfmZL9KoqRhxPQuyRcHdQEThIecmH02UWcMFJl3aC9BoSjzcY+Inh30HFMp1b70XgmGTfqbPBskBpQmKFbiUjeHDwR+v2W4/j08nDOGJRe9bHnEF86KYeVZEbWkznYCm1PN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpXwVdnE/NbAafD2+WxqJF6pgmSn998upnsRr/A1w/8=;
 b=KilWYBN7Y6+hb24cD7h0uzLQH02jd/nS+4edxU7+9RJ6v88yJnti7RMmg1paum/MtlM/D4hXATtb9n1Q4/WBMTE0LPPcsJIgHcOXC/LN8bjMMFSj8hqrRq4Dq5xDUXosmlb4nQbSjERExz/mpL0eiJDgFgY1k4BaXsVCfNatGFMhfqoxi3rVTibKgol9VCkj37mYmZNw/R+ZceCEOOvNW0qnkOdVGn8z1D+9FE+IwR4pJko9PswbeHMfShCOxkC5i1bcEMs+oSp28UOuZmBZ7E/gLy2P/Xt+8LYfol3rfk49v8FFcs826csAVELnSD5MwIZOQ+XKKgOggI6IHoKImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpXwVdnE/NbAafD2+WxqJF6pgmSn998upnsRr/A1w/8=;
 b=BeKLpS1xkVOhrOg7UuNCQaQlOlaEH0oH8hyPalmdkBVn8C6qaf3wWzrt1YTgQ16w4YZZrWZGwDuCGS+nWfrEvfOiz0RxTBNPaD+ezgRAcgkqIopzX1aQlSsiohhWDiCW0peET7ycTTdjuLUDCmD6d85qICqlPIYt1QX8Mvjkxgc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BL4PR04MB993740.namprd04.prod.outlook.com (2603:10b6:207:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 13:50:28 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:50:27 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH blktests 0/5] blktrace: Add tests for blktrace's ioprio tracing
Date: Tue, 24 Nov 2026 14:50:11 +0100
Message-ID: <20261124135016.153657-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.56.1
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
X-MS-Office365-Filtering-Correlation-Id: 2a7c0665-1451-462f-21df-08df4a31e5b0
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261021121427099003|261102123227099003|261009223027099003|261009221227099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Vf4PiBKWmtdmukLYsYWeUqo2LxtajbahvHgwvfyLpc0tSPtdDrbQtRGQK9F5jKGaf3vGolL0kTDR/dCIe0zCKFZJixFWH0BHem76pXN+juzui/Rkko9YtkQK9M69snJ8SYU/6seHEw3je2m5TcObrl3NWmHqYjJ4gKUbdD1Hk3oWwpcP6ZcFG+bnlONQtJRowKJ86vHcnKE1s9JProQv+TPmfHIYmTTsiViX1wYDupKTpz3fFerQmBuSaHPMhmfv4wySaRD80IJDydeNy2imOH9HpDc+/hRnBGKaeEqE4vZjukV0Sy9T2JYvxsbsBgEi45v8bb6oc6j58a6dOu1tXFxtTPJzYC5j4NIu69fmzF48e1yCGaVSaMCwRHGsIiP9spGDOphwpJL+nWGTT+LNtAZ5AZCyu+Gz14nu6wYrKPvrEE4G/uyHHWhZZPMuJ8BD7ioNJh/w3642AciYehQM5q0CsRQrGsqQ6vGFeVrPIZxSacwzK+XlW0W4L1D2rt6lwFzTaVhdUvDFYpRdIM4ThgAZrCNKlEpnLaXKnJTLsm7l+xznscE9RsWxdH92qBpiowUf/xU/B9VwkPPSWAEpi05jKBVQ9KpjCNqC4myeAUB6DItO7CfD7d745udbYiTg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(261009221227099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gwagO0LXjU23Wo/ZVArsodJcgO6j0iocBqI4N5nTc0qHRWHMA4FKLJ7FwQsv?=
 =?us-ascii?Q?Rd9RqH1iISXA4GI1YKQ3HimuFg4vVOJ9JC2LQQhb/RhKhCmu/scE+gzphd9s?=
 =?us-ascii?Q?EZ0/GZYeRhSl2rOnppp7qqrZI4U2MOJHcdyc3oMrIy9rhUsiYe2AyeQiAeRe?=
 =?us-ascii?Q?MLGZow+pp3TonYBRAL6TAnj9Nf4JiQeFLfpWq/zVLVxfwkeIMuKJgfuxAeHG?=
 =?us-ascii?Q?SvN1kU4XryueHz23RI/fL2Q8rOb20Bgz8HUpOlWniXlnypQB+h8dbXpI8YmK?=
 =?us-ascii?Q?7t/7Pq9BZyVOvWitJ567zp+hiT+AkxJJdsrHZLUh825ikBpQLRMyl2Rq9ski?=
 =?us-ascii?Q?ZGmW84WkMinexxA6ogYUeb0Jl39CjiMcn9JXCZlXx0wQ0tEScIExyhEY2vZW?=
 =?us-ascii?Q?hQ+RuhuI1hDeut3iux1nQ5J/8IyOPKsgTmopzn81HGflZL6oIHd0IQbuRve2?=
 =?us-ascii?Q?3UAdQT/ezW8ykWZ1awAWtSk1yFEJum7vNNcPjnsIbpSI7aaZ6tSce5AjTNGl?=
 =?us-ascii?Q?mpyeMGDqoR+Fk8JJfzIdHu6yuZdqcVG7il5QnT6v2FVKd101WyUkuOd0stUI?=
 =?us-ascii?Q?5ADF3ppQQRCpPHmFh2avFrMkDGIqR7ZcPMJS/ttuI7zaBu9vceCTUMAIQFlz?=
 =?us-ascii?Q?rMH8B7GAyLI1pAQLiNyDKUqHsAyZSESgV3eEs6FxaPUuizEr4syPdFB95n8t?=
 =?us-ascii?Q?fFEKZhJ5Ag5mgLxaoZqELOZ7kqrFU26Gm+l5mzpo7jmxqhZQ76DtBCSGXNVO?=
 =?us-ascii?Q?Uj0at6hMB0VfPfXYDEg6Ss0zwyubFuUIgzKLPMHYmiUTkRL+GlrK77R0W/yr?=
 =?us-ascii?Q?yRuuSlco0qzcKQcBB1Tu+7wyNdMjAOC7fw5vBRHYekdTYf/jNH9Rbp/m29df?=
 =?us-ascii?Q?SEWfG8M4uGlBOZywBX/ctcW8eeVH1Rr1w2Xw0hOB+/XrI1FObxLA9HIhLE8h?=
 =?us-ascii?Q?Ho+2bgujra90QvW0hGNeChWZvmHkHGw5Q5MntPlt11Br+XZ2eijxxPGP2uEJ?=
 =?us-ascii?Q?0BWrBNYQmRG0dsaFmFWIGljPRyfsoY4p5jknPWa4kEfPTNsGVtW7ybymQxvp?=
 =?us-ascii?Q?IvLvQOCaj4qURxg0D9bvKkHJMF0JsSk5EmANEaadYxqqBhdvVKgWhs23YJJR?=
 =?us-ascii?Q?NuU7ziipAMNqhKak091LfT/Hs3oqzwKTg6JO3B+T1+paLu1z/03E7zdNaF/U?=
 =?us-ascii?Q?kXpldg5Wu7ksuezUH64CfzwQYT3vQnX0cFtgcPsPQ/v/tJWMa9kWpbFvqbq8?=
 =?us-ascii?Q?I36a5l/d+GdDxS1BKMEQCUM3xEktQ4RHVSBM1yBiddHfJTlK1Ql/nPjE7jlv?=
 =?us-ascii?Q?uoCjWtA7Q3n2kfj8KIZVHkaGczxzo9uOhIj7WWTyFPtC3VUjznS+P1zgUyX/?=
 =?us-ascii?Q?/r6vczGi8xdfpu87ms0xjHjQyJnrlMWy78y/nfj299Y0xkn76qTlYsFyEJQb?=
 =?us-ascii?Q?72qRW/A5z4QbbAIrV/lo/XW4kxiTPPcxFHkqX+VLh3J/yAOTZ6B6h5Wp3oep?=
 =?us-ascii?Q?JPY2IpAf+wgcKh2oIY0rz+PJvMXcVARpxpw3whE5BIzaG1Ks+zc93yCikl8w?=
 =?us-ascii?Q?hYY9QyHYq3GSpTT5M7wSbBdCj6EcYLDKxxKnc56vQl+dyRahcRoG+39PydbK?=
 =?us-ascii?Q?xdUL5pq+V4JiqgIKamuDlFAFmmqE2zo/ZcVDae/Lr+gfN4z9LKLgogf15lSF?=
 =?us-ascii?Q?EUzB1zZoUUlL+HB3SlC5jqvq6veK8SUC0StVrdkB8+eYvQBxdzKHG8j2shaf?=
 =?us-ascii?Q?ZmgJ33HNTVbKV6Jm/ftxVKUVzYkSA4J9K3L6DHlFhUmbFUxTBr86+aFFAzpq?=
X-MS-Exchange-AntiSpam-MessageData-1: cWjn5jle+m0l2XySVGUVJS+MmALXMQkovV4=
X-Exchange-RoutingPolicyChecked:
	SjGycGwJ9ydi9QjiuCW0OATxaJIkBGm4gxc/k7ifSavPSmzpxJtje5m+GoeW/n7TwFg5143GftluMN3O4rx9LrGMDT7UxG1fuqMwWWri3u8H1+8UJBXM8rxwieYm5+Eg2zMPLgtXX/HEU0rzpzCR5wSXOpdIpAR+l7NVpnz3swa94fTgPljudvpEzvScpDDjpnaUeAzDmgyzSeZLSGZkjbwXV+P9z9gdQWwzbpqm745VtIoOnyU8wYcCGgnxZFytOjGNPPQjNCXORvEDFFTS2W7LO9Qk3upHfGUI4ShttNgdaJw8Ywg8n1aumHcmjo20iZMoovWWehbc3E9x2HvQDg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+1KZKxqxJsPp4wejpCekpfsWhpkFg79+TioUp4K7Jpp7CRz8PJB1gbhebKRhPHcVrBd5hoZPxZAcOM3zBYGBGOlLUkUfeOp744A2R1U7xmhWL47ZoDXz+SOxraXW65izESB39/RXJRoWbrJunGoGWfK8lrV8t+x3XBjzWJgiqVwB0Nbsrr54QYYJVMcnof+5+T7CusKT5Njw6uRG8Ffg8nUC0jIZpA5selUDWNWiYXil0BvUrdHscx6feXP1lZtB3zWF5ylrLywQvZ+3SzXoOT9/S21I2q1u6k0iqNFIABhPn6LFdtNf0WfhXqS7akOP0E5L5B7ywDnuai9vIMB0QbzC7fLD/rVyxtH7c7Q+7LnKLQPQ6GKjfBH8NbkzK/BZD3cwHhfyPkXA+YDRB6riNgMlTqYA5vW/6vHtUe1pIibj0ASIZkI5lyaKfTLDyouski53xYwOGxCKvOW6q33gzrUdooFX4yHAhuPd138J4c60unx4PROPlNGPiC16ZABP4yV5CTWa7g9Reg2QivaVl3T8HStYTgo6Qy3ajfaO2nIkSShKc3vuQvAzIny28zqLpCmxY0QzhwtOdz1siWRLf4DgpA44kBLDyjLnCzN8Dz453ZgAu9cJxPSjssKyhkKf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7c0665-1451-462f-21df-08df4a31e5b0
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:50:27.8326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzuwYgGMMoypordEWj0zNPlxLPB9t4rHrfdjD7m/OS/gz7vOSE3OZX9XscodM/vtniz+EeCefRp0kS1fNf6+ftt+Rlmob/29XBITmUUYqIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR04MB993740

Add test cases for blktrace's ioprio tracing.

The kernel part can be found here:
https://lore.kernel.org/linux-block/20261124133553.152463-1-johannes.thumshirn@wdc.com/

The user-space part here:
https://lore.kernel.org/linux-block/20261124134602.153239-1-johannes.thumshirn@wdc.com/

Johannes Thumshirn (5):
  blktrace: add blktrace ABI compatibility check test
  blktrace: add iotprio recording test
  blktrace: check that ioprio tracing is opt-in only
  blktrace: check ioprio output of ftrace blk tracer
  blktrace: test bio and request tracepoints record ioprio

 src/.gitignore         |   1 +
 src/Makefile           |   1 +
 src/blktrace-setup.c   | 108 +++++++++++++++++++++++++++++++++++++++++
 tests/blktrace/003     |  51 +++++++++++++++++++
 tests/blktrace/003.out |   8 +++
 tests/blktrace/004     | 107 ++++++++++++++++++++++++++++++++++++++++
 tests/blktrace/004.out |  13 +++++
 tests/blktrace/005     |  79 ++++++++++++++++++++++++++++++
 tests/blktrace/005.out |   4 ++
 tests/blktrace/006     |  77 +++++++++++++++++++++++++++++
 tests/blktrace/006.out |   4 ++
 tests/blktrace/007     |  84 ++++++++++++++++++++++++++++++++
 tests/blktrace/007.out |  14 ++++++
 tests/blktrace/rc      |  96 ++++++++++++++++++++++++++++++++++++
 14 files changed, 647 insertions(+)
 create mode 100644 src/blktrace-setup.c
 create mode 100755 tests/blktrace/003
 create mode 100644 tests/blktrace/003.out
 create mode 100755 tests/blktrace/004
 create mode 100644 tests/blktrace/004.out
 create mode 100755 tests/blktrace/005
 create mode 100644 tests/blktrace/005.out
 create mode 100755 tests/blktrace/006
 create mode 100644 tests/blktrace/006.out
 create mode 100755 tests/blktrace/007
 create mode 100644 tests/blktrace/007.out

-- 
2.56.1

