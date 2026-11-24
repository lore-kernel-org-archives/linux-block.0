Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527383;
	b=HKByVuNkDRDb7TZchOUESP7+2OcO5ccKxf7ipZIMHfFv8T708nuuRldloB0FeGhEhadO
	 R5eHesnAil0eg/LoukjV3RbnH0PtCaJUu2C9Iz868w5mb7l07tyQHokY6f4QkUdsA5wig
	 C3bS7sH5br30mlKFur+8NzlXWYZMY6/235nIxBfX9zR10MEYmIiX2eI+vCXTrPC2i2kvN
	 X8hoilyMfrh+You6PXSdeIncKvdVUKFJLDBmP3oyUyT/dyC5KQtR0yfjHdgVfOZI6Hbhc
	 urxo8386x23S9ExO9JyXRSSDXMjV93vSgKNKHphstlDWNQOKuTcCu5S7u6MGg9M7+RA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527383;
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
	bh=PTUBd6vyL4RIzCo4BZU9VC6H0fnlxKfn3paYuqktDdQ=;
	b=KcA7pa3BsAKgHC614TElRU2BlfyyiiKK6PTAmOifw9lK9NwxVjJK0pM/dQCWui2G5SAP
	 qVNXkfGucm82msjfkAEMnY8XxI5dGEi7zcUSErU/vl5nIHOOFPcLWboM0M+BQp50CmD/Y
	 hxTRqVHEpy/ZewPy81OBAcytUuykP87o/tJt2K0fpkaNKJor7D5joXGcg3zAs0gUyXpcz
	 zBYZbOc2goy6/j4XhCFUgKUMrXrcqLwQwX6YBSHkJ5XaqBLia71srnXIAxG2+E5efOMCc
	 y4LeNap5GeZl5VT7el+zwrhaKTlt1yozkCM1q3azHnh2Ra6O/cHLg7BXDJNMXJsn9PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=j7nrryD7;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=vIcR0gDd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C180606A32D
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 13:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C180606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=j7nrryD7;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=vIcR0gDd
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795527381; x=1827063381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=U7i1y0nO4Ei59XVunYrI9jxZOiBwwTp8rFPlxP6gOJk=;
  b=j7nrryD7GWhd2lbeFVhsxYY23T4zmfKg4t0N7foK9mWtuJmUlr6PNVbU
   Vsrwg8/P4L451PFnlAnrDS6SXMlNTLdaTviUg8I6qrO914JrZBngbqrLX
   gLk3fFEOZ8/m1aJygDYn4n+F3YHdzPKpMlmev+pTmAuaD5mDIranU3467
   fPWgi7XWKeZUW1sbjPcAEy5ql2KU4Wvrv9GkDXihfKpuhjfskQIblyE2F
   KrJmam7MJN+4HT9SExe0bUhJGra/YhiRY1QRd3DKFG9D8YSKIB2w4zNsy
   QS7fAnj3z0tiZrlz0ZC1BShP+p+kfnC86lXeu9fgbbHhFS0EUl8i9/r6C
   w==;
X-CSE-ConnectionGUID: 3643p7xNTSqMfrAgxWd4vw==
X-CSE-MsgGUID: MRYvfrJwQW+rmqFFABdhvw==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161579897"
Received: from mail-northcentralusazon11013062.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:36:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gT8k+E55KEZUhVYK6q1u48LqEK1dfNuZgoqSXaLAO4jXkH6iK0rZ0czC+Px19j1j9pNdUdELn7Sog4kDSYlVXql1ucJOpig5eWfd2gC8xVy8kHaEpeebVYV19G0pO2pgcHIwo2rSme0Kqnoqji/FRU2OUmRbQEefOkIqm0pK+lHn3hv18yz3a3mopbCzT05zpSD+klKsKkoB8p4u2nG24+Gp7/Kzc21UFka1PqEGOFP5HlntVnV2MFUf2S9xk5HRs9yXnlz0oGaK+Rw40ch2+NLgk0F2mIAzIh09e192kLLOk5mgd6KITK5oSwT6vA6FIUnJFq20c2PJKx8Kvog/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTUBd6vyL4RIzCo4BZU9VC6H0fnlxKfn3paYuqktDdQ=;
 b=LW3tdlhOIfNJ9YNm4u1EqO6BzdScqPTESANKt9qIsxzDBYgJodl5wu6KRTbtCuX91FfNc/x6bCMEewbDhz1P4l08agvkITeieh3Zoy5mzD36v7hmN/I+FOPyY167qafSzODd/WxytHX4RqpxuTT/xsXzDcYdHpLcO7T8Ii9Goqr+BpA0ZLSH+ENW3QNgdJtj+/AAiDQMlmJ/ALlajueRSUmdxhJeS3Qe/tgbX88wGRg0jTzHu0CEJ3KeXnApM/GeOUGMYIaAECmreR8tu8wKkJtdZTwt5BIBN4RN8IuuumEtXGlBFcUvAaYihLokgRaTJj61eLeCqyNC0078FEyrJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTUBd6vyL4RIzCo4BZU9VC6H0fnlxKfn3paYuqktDdQ=;
 b=vIcR0gDdfWuV5ljeopErpKKDINY2WVyrcFxAnuPbh/Q9jk8JrpbUf5+uMwJHWzej8xSwr4zhsYTMQ7ASS4EhUfX/OMRu6547tch51C7xVFRfU6HoH7IxG1Kp+pvHqPQMomIipBbriuGqdtdFvg4jZyVQvtqxzK7XKa60+mYk9JU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by PH0PR04MB7527.namprd04.prod.outlook.com (2603:10b6:510:4c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 13:36:18 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:36:18 +0000
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
Subject: [PATCH 2/5] blktrace: pass ioprio to tracing data
Date: Tue, 24 Nov 2026 14:35:50 +0100
Message-ID: <20261124133553.152463-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124133553.152463-1-johannes.thumshirn@wdc.com>
References: <20261124133553.152463-1-johannes.thumshirn@wdc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 905d5375-0032-45ef-0f99-08df4a2feb9a
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261022075727099003|261022105027099003|261022115727099003|261022113327099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261021121427099003|261026135527099003|261026121527099003|261026140227099003|261026130827099003|261028144727099003|261102130727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	CrJsgovaHI0ThM74HPpah0i89ZAJqF2mnfXcvXbvTL6f7AuUF2Ky44EfbkEA/fEDwdqfJwLGDBHaoPVdNFx5o42dwEtGdj2UUI7xK1nZawNz5IgwFb3Ht8KYOvQOyQN0m05Y2p2CN8uVas77Cn8yC7Pw2hi9uR+TLw14YANDtGHqg0hO2tLhD2kb4Jd+2qP7l1pERjcprlla3EnT7SLyBEVu6hJydeArgKyH7GuvloL60reCLBY7EkF3/Aq4nqkqaC8H0ikAguQq2LtwSNw2kaimNHWRa4dbejO54nVIamCYsqij4Ouv0U6okzCu++18CoZm5M2Sslr/dZa3bUID/EAdaJ1XU2XD3w35qqQK0OJj2/f2dVvb/EagbO/1M8UTBlkKlqXRy9h1pYxqirDd8/LZXh671OFH2p/eTy5wpk+CeZ6Y+IOyVK5phmwR5zAj1YTTtl0LUdBaTegUg8qjwcTz3iTaeyAUdf44crn1N0uzAcQia3Ck0vcB99D8YMC35DJCApGiab9LKYaMeq9c/M8xcoqE0y0uEulWBvCDhNMNlcu/AWThkSF6iZHuj5i7fHZU+oT8mQ7DvS4YA66vcdWIbuiiX8qGpwR1vWYQ9BPrQ5qlkx3EoAKVb15X1UoRzQfim7tEYBN5iaL0rIk7ji3EcdX9ATjWB58dStHrJXo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261022115727099003)(261022113327099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021121427099003)(261026135527099003)(261026121527099003)(261026140227099003)(261026130827099003)(261028144727099003)(261102130727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kFLduS6uVTt4sv3HV8/8iZBFoOayB/G0e1Xb0SwPm3P3PnLMOHXuJIph/PGG?=
 =?us-ascii?Q?LlHX0wzlOam0ugzL8gnMbwv4mS+BSgh6I4yN2IzvEtuSCHNFJ3dm+0k2+3iZ?=
 =?us-ascii?Q?mNUeShEgbxdyItRcessnYq5Z+0ruOmWuovnLarMmwqHt7MgY263xdMmQRnqq?=
 =?us-ascii?Q?s0C9Qi3PAuxi1TidYV4JMxd/voyWLDJcBiFjXoKizyzegZxXJIGkUxLP+xXZ?=
 =?us-ascii?Q?j/4kpx09hengkdU+C5nPThaCVFHoUol82SadtrqsumQX17qb65SnJOU884/h?=
 =?us-ascii?Q?JDuVE1dc1a3eH5Mb+VwkClONocOnnnqReyZgZ60Bm5gVrULcB5fv6+O4n7Sj?=
 =?us-ascii?Q?zcsy7S9VlBrpeGjhsobI8x5VDyw7Emjznk/y/9IiL+vzRiYnL7WtJsAKAp3Y?=
 =?us-ascii?Q?VLOx6bUBm8dFBzffg1fF/4rASk6tZBCKiB8INOv9MVyT8+zUOqMKBJRtUuh0?=
 =?us-ascii?Q?ypXv0b1WkkDqkvweomtbVNssiqG6dtN1CidJuIHnZLI3KYOJsyYPc2CsFl9N?=
 =?us-ascii?Q?fvbphn2eAZK3iUCfzKltw79J4yfFK2v7O98wTWhv5PICvfUaw0TCTa1PqbIx?=
 =?us-ascii?Q?/2u9XjBPReTeoHSpqJ7VIVAUHhJIU2JsrDCB7Eif06FvVxdS5beIReAmZHdK?=
 =?us-ascii?Q?OUhSxx1SIw9dH57nE8jylzWxMUYs3MZI9iy0Mhe06hSeFGSlYc8Y0kPuIx0f?=
 =?us-ascii?Q?/kGR7pTk0MzpKftzzr53WZfCW+SMDzLlCmFJjhWqnijhAqc7OX+JdJ7VFyCG?=
 =?us-ascii?Q?x4+vbrwXt/SQ2dk78mIzmU5rmOQLhWR1w+TaCk+XEgjnf9crdfLOE9LZVwq1?=
 =?us-ascii?Q?a33/g7/8QOnAO5QIsDTWLwlWjT7HGel3DsbnnaIOL4D2QZnadKROGCYnWzv9?=
 =?us-ascii?Q?5ZScIPnOYiyS6v/nZ4NN4weusgmWoNurVOWis6I6N7tpqeRXOzjMrWzSEi33?=
 =?us-ascii?Q?PJqZs/pfR6rvRLEd7GLCN4uZfN/j2fdAAn4RWzp4g9Eox3ZLPR0Xi5FdUcKY?=
 =?us-ascii?Q?rzbZEQ7IhULa+sGLZnzQUpy4sJN+e2w3slfAjgiQFh4tXuuL0XCAAc4MRiBo?=
 =?us-ascii?Q?S5jt8IOKP/DxO3SUnZwRB+k3XZ0uK55d+CHLeas37S40Sw7D7QI+a5bLwFlT?=
 =?us-ascii?Q?NRpLP7JNL1r/A0GJTFd+nL25kmNFb9reujOvDiJtHXilH86ClcBaZthGdIil?=
 =?us-ascii?Q?mciwueJUs0IXjMcIe1nWEy7uzBRInF3hIEEoYhjHXxtFzJfk9k9F9rIt27+C?=
 =?us-ascii?Q?+Y8TF07GyP6yQhyW+LoEa+QlFpmIfv8Ed/8ZpKQmVVorDrzm35jvDyHIIJKI?=
 =?us-ascii?Q?jZK8pFCUEiMsd2HOePnno/dmjM2DMwyYzrO977OgSPzMBIBgAgtaXi9iO3WT?=
 =?us-ascii?Q?PT1WuV8BrCCPcf0iX8whCKPi6ToT0xB7xSHcvD0xnkHL4Pp3uNSfB/KrRzm9?=
 =?us-ascii?Q?VaQZDY2Hr46nB1/BIPE1FHVd0JCKQZ+fU/NpBNA6EvsDOCeOk4uvf73GVdu2?=
 =?us-ascii?Q?srmAL+NV12FZ3pMQ0t+tgRdChJykmK2CyQs7VRmdEHkP0mPgCc/eQAZGD5gC?=
 =?us-ascii?Q?BoCtkr61NfNG8LKDH6q1QDEP/BQ7RxsrZ+pesbH/ddkBiY5kMhyQrWVHNX+1?=
 =?us-ascii?Q?AlFlQNrn0xpdB/9Fqof4QrdXo6XjCd1diGb8IjZ7wKxZcemHTcFqRYVpjORI?=
 =?us-ascii?Q?pvah9NP2hdzD98BNP11PRoLaAJTMPR2zdL9+J4uh9NLa6H519MSKMM8URR+c?=
 =?us-ascii?Q?rFG6rysfd3sevam6XObLdMIaX2+ayn++fAbA4K3wbO1yzpHv8U4zfRmM3BMn?=
X-MS-Exchange-AntiSpam-MessageData-1: Lr2d0W79jLUCboJqOcE25QkUnq2tYH7/F0Q=
X-Exchange-RoutingPolicyChecked:
	AE6o2sbU4m/hAA3UnyMx9uMFq8Lfu0zHPKNfpxWYSPw7KHdfWHUjIY9NbbGagrXFdFwa0DStMCzKcX4cRg722Q4OX1z2/LSaSR/XZv/r3tf/G/02UbTFnsUg9Gh8JMVrBvU4vC0gIq8cbgbfWzI58KL4NDX4y/CKx34dnq5Z4wQVFQQ4AydxRQvhyFy6EkaLQeXBUiicrYiqvac6bA+14R7/xhIuuN7T9VLt6fKwY1Tjf8YBdKZoRI694f7DQgBYmhvmvst6uUiNI/hawS7fYA6CY1+kvmruOn3GlBbjbN2xRvh6LxS6X+o6ba5Elmm3k1Vv56GiK12lCkEXj22tIw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fohlZGx+w5ToOaCaQOunMZUcBX7mGbYF6a/Isajoy42/MAGEMc/ovAiOsbcUtvuiUcUnuQrKI/0PKC22q7yEiCcQAjhTqKL+88FJap2Afg/nEOn9CyDoA1ui59aoJ8jQXTbSGvV+6ubssd7nTtauulZFBRHKulKmL2bPyBA9IsOifOaa0lUFtijBLCSQGFyjH8U7xWtoNmrQP5NVCw99s4LMWtbYm2vzy6zCXg/xHZrmjJCqP/c0xVWlFulE7MnHp8FhQcjgEc2FD6dP/RUHM08eTVieXDTM2TD8vK/Fu8v0/x3QsjnSM1+agDnfkk6SaGXbd/MZrkKar2Rf5f4Rl0HIJH+jzSLWkDQmuyxEDWEZNin2LEgPWwXLDTwGhdlU5VSm+syfHpjpYBljgLi69OJN1PaaXcKiBQ3BbaAHp9IWUm7Vznhv9mMf7dQKU414ykRZMsUHnxq8t/mdAwn+Y5ON2eXWe2Z2s6JnMjU1fNv1/Wxl+ZAPxMSN9/h8zyw5excV3COi/RcPtTWbs1TK5g+I1hIDjJrLhmkyElDbGUbd/dex6wtYvJFTfLvmIKCoiiiERi9izwQEZwUUiNqdK3LSbHYFTdfHzBsDtyZ1Usy4t3UdgXnLjvlXePG4n3Eg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905d5375-0032-45ef-0f99-08df4a2feb9a
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:36:18.7685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTEaRipLAKB/dqaz9AjBf/RGoCyu8n73ytVRzyQUcyvryDzGgYIbm5luq/ZGEvFcbglC2mRFDTJ69pn3o/vAgii76SNUjBoM82OtCN23two=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7527

Pass the I/O priority of the bio or request down to the recording
functions and store it in struct blk_io_trace2. Events without a bio or
request (plug, unplug and the zone write plug events) pass -1, so that
they can later be told apart from requests with an I/O priority of 0.

No user visible change yet, as __BLK_TA_IOPRIO is not set on any event.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 50 ++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 4d39edc6730d..c57df30750e9 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -95,7 +95,7 @@ static void record_blktrace_event2(struct blk_io_trace2 *t2, pid_t pid, int cpu,
 				   sector_t sector, int bytes, u64 what,
 				   dev_t dev, int error, u64 cgid,
 				   ssize_t cgid_len, void *pdu_data,
-				   int pdu_len)
+				   int pdu_len, u16 ioprio)
 {
 	t2->pid = pid;
 	t2->cpu = cpu;
@@ -108,6 +108,7 @@ static void record_blktrace_event2(struct blk_io_trace2 *t2, pid_t pid, int cpu,
 	t2->pdu_len = pdu_len + cgid_len;
 
 	memset(t2->pad, 0, sizeof(t2->pad));
+	t2->ioprio = ioprio;
 
 	if (cgid_len)
 		memcpy((void *)t2 + sizeof(*t2), &cgid, cgid_len);
@@ -138,7 +139,8 @@ static void relay_blktrace_event1(struct blk_trace *bt, unsigned long sequence,
 static void relay_blktrace_event2(struct blk_trace *bt, unsigned long sequence,
 				  pid_t pid, int cpu, sector_t sector,
 				  int bytes, u64 what, int error, u64 cgid,
-				  ssize_t cgid_len, void *pdu_data, int pdu_len)
+				  ssize_t cgid_len, void *pdu_data, int pdu_len,
+				  u16 ioprio)
 {
 	struct blk_io_trace2 *t;
 	size_t trace_len = sizeof(struct blk_io_trace2) + pdu_len + cgid_len;
@@ -152,18 +154,19 @@ static void relay_blktrace_event2(struct blk_trace *bt, unsigned long sequence,
 	t->time = ktime_to_ns(ktime_get());
 
 	record_blktrace_event2(t, pid, cpu, sector, bytes, what, bt->dev, error,
-			       cgid, cgid_len, pdu_data, pdu_len);
+			       cgid, cgid_len, pdu_data, pdu_len, ioprio);
 }
 
 static void relay_blktrace_event(struct blk_trace *bt, unsigned long sequence,
 				 pid_t pid, int cpu, sector_t sector, int bytes,
 				 u64 what, int error, u64 cgid,
-				 ssize_t cgid_len, void *pdu_data, int pdu_len)
+				 ssize_t cgid_len, void *pdu_data, int pdu_len,
+				 u16 ioprio)
 {
 	if (bt->version == 2)
 		return relay_blktrace_event2(bt, sequence, pid, cpu, sector,
 					     bytes, what, error, cgid, cgid_len,
-					     pdu_data, pdu_len);
+					     pdu_data, pdu_len, ioprio);
 	return relay_blktrace_event1(bt, sequence, pid, cpu, sector, bytes,
 				     what, error, cgid, cgid_len, pdu_data,
 				     pdu_len);
@@ -196,7 +199,7 @@ static void trace_note(struct blk_trace *bt, pid_t pid, u64 action,
 		t = ring_buffer_event_data(event);
 		record_blktrace_event2(t, pid, cpu, 0, 0,
 				       action, bt->dev, 0, cgid, cgid_len,
-				       (void *)data, len);
+				       (void *)data, len, 0);
 		trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 		return;
 	}
@@ -205,7 +208,7 @@ static void trace_note(struct blk_trace *bt, pid_t pid, u64 action,
 		return;
 
 	relay_blktrace_event(bt, 0, pid, cpu, 0, 0, action, 0, cgid,
-			     cgid_len, (void *)data, len);
+			     cgid_len, (void *)data, len, 0);
 }
 
 /*
@@ -311,7 +314,7 @@ static const u32 ddir_act[2] = { BLK_TC_ACT(BLK_TC_READ),
  */
 static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 			    const blk_opf_t opf, u64 what, int error,
-			    int pdu_len, void *pdu_data, u64 cgid)
+			    int pdu_len, void *pdu_data, u64 cgid, int ioprio)
 {
 	struct task_struct *tsk = current;
 	struct ring_buffer_event *event = NULL;
@@ -444,7 +447,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 			record_blktrace_event2(ring_buffer_event_data(event),
 					       pid, cpu, sector, bytes,
 					       what, bt->dev, error, cgid, cgid_len,
-					       pdu_data, pdu_len);
+					       pdu_data, pdu_len, max(ioprio, 0));
 			break;
 		}
 
@@ -464,7 +467,8 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	sequence = per_cpu_ptr(bt->sequence, cpu);
 	(*sequence)++;
 	relay_blktrace_event(bt, *sequence, pid, cpu, sector, bytes,
-			     what, error, cgid, cgid_len, pdu_data, pdu_len);
+			     what, error, cgid, cgid_len, pdu_data, pdu_len,
+			     max(ioprio, 0));
 	local_irq_restore(flags);
 }
 
@@ -1038,7 +1042,8 @@ static void blk_add_trace_rq(struct request *rq, blk_status_t error,
 		what |= BLK_TC_ACT(BLK_TC_FS);
 
 	__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes, rq->cmd_flags,
-			what, blk_status_to_errno(error), 0, NULL, cgid);
+			what, blk_status_to_errno(error), 0, NULL, cgid,
+			req_get_ioprio(rq));
 	rcu_read_unlock();
 }
 
@@ -1114,7 +1119,7 @@ static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
 
 	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
 			bio->bi_opf, what, error, 0, NULL,
-			blk_trace_bio_get_cgid(q, bio));
+			blk_trace_bio_get_cgid(q, bio), bio->bi_ioprio);
 	rcu_read_unlock();
 }
 
@@ -1154,7 +1159,7 @@ static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 	rcu_read_lock();
 	bt = rcu_dereference(q->blk_trace);
 	if (bt)
-		__blk_add_trace(bt, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, 0);
+		__blk_add_trace(bt, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, 0, -1);
 	rcu_read_unlock();
 }
 
@@ -1174,7 +1179,8 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 		else
 			what = BLK_TA_UNPLUG_TIMER;
 
-		__blk_add_trace(bt, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, 0);
+		__blk_add_trace(bt, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, 0,
+				-1);
 	}
 	rcu_read_unlock();
 }
@@ -1189,7 +1195,7 @@ static void blk_add_trace_zone_plug(void *ignore, struct request_queue *q,
 	bt = rcu_dereference(q->blk_trace);
 	if (bt && bt->version >= 2)
 		__blk_add_trace(bt, sector, sectors << SECTOR_SHIFT, 0,
-				BLK_TA_ZONE_PLUG, 0, 0, NULL, 0);
+				BLK_TA_ZONE_PLUG, 0, 0, NULL, 0, -1);
 	rcu_read_unlock();
 
 	return;
@@ -1205,7 +1211,7 @@ static void blk_add_trace_zone_unplug(void *ignore, struct request_queue *q,
 	bt = rcu_dereference(q->blk_trace);
 	if (bt && bt->version >= 2)
 		__blk_add_trace(bt, sector, sectors << SECTOR_SHIFT, 0,
-				BLK_TA_ZONE_UNPLUG, 0, 0, NULL, 0);
+				BLK_TA_ZONE_UNPLUG, 0, 0, NULL, 0, -1);
 	rcu_read_unlock();
 	return;
 }
@@ -1224,7 +1230,8 @@ static void blk_add_trace_split(void *ignore, struct bio *bio, unsigned int pdu)
 				bio->bi_iter.bi_size, bio->bi_opf, BLK_TA_SPLIT,
 				blk_status_to_errno(bio->bi_status),
 				sizeof(rpdu), &rpdu,
-				blk_trace_bio_get_cgid(q, bio));
+				blk_trace_bio_get_cgid(q, bio),
+				bio->bi_ioprio);
 	}
 	rcu_read_unlock();
 }
@@ -1259,7 +1266,8 @@ static void blk_add_trace_bio_remap(void *ignore, struct bio *bio, dev_t dev,
 	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
 			bio->bi_opf, BLK_TA_REMAP,
 			blk_status_to_errno(bio->bi_status),
-			sizeof(r), &r, blk_trace_bio_get_cgid(q, bio));
+			sizeof(r), &r, blk_trace_bio_get_cgid(q, bio),
+			bio->bi_ioprio);
 	rcu_read_unlock();
 }
 
@@ -1294,7 +1302,8 @@ static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 
 	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
 			rq->cmd_flags, BLK_TA_REMAP, 0,
-			sizeof(r), &r, blk_trace_request_get_cgid(rq));
+			sizeof(r), &r, blk_trace_request_get_cgid(rq),
+			req_get_ioprio(rq));
 	rcu_read_unlock();
 }
 
@@ -1321,7 +1330,8 @@ void blk_add_driver_data(struct request *rq, void *data, size_t len)
 
 	__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0,
 				BLK_TA_DRV_DATA, 0, len, data,
-				blk_trace_request_get_cgid(rq));
+				blk_trace_request_get_cgid(rq),
+				req_get_ioprio(rq));
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(blk_add_driver_data);
-- 
2.56.1

