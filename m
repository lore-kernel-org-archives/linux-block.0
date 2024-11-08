Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ADA208A0
	for <linux-block@vger.kernel.org>; Fri,  8 Nov 2024 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731042041; cv=fail; b=LbH4DlhP92WRFy3FsOrxJxEfZww/Jkbt8ypRu9+5OHha9nZ8Xgn27fVgJNEonAR5KpWmo6xm9RDqwPq7N5Go98f977Y6LBN8iEfq2/V9ZGhVa/ihcRcYUlpte4RB9KOsGKkUiEzi1MDcBmXhkpb6TTnvvxax44oUqhNlGKTN0NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731042041; c=relaxed/simple;
	bh=4Atp+KexUYe1ID/6Mqf3YuOUu4JCEPvjcsTVGfnHNvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DsyU7G3S2LSYJUfLuM+a79qrYc9zP6nHEdjqH4EtMJvJ3fSmhjJV8tTFrtAXkUcsx6gLXsVOjRwI0ikpUd44s0PggApRpOMJvCKGqEh9shioGLWqFiLbx5MXCdDN4IfJ242oHJf78MkphawsQpGLR1Wtl3fboAsE8T3I58NTCUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TWmXYiEy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xDRi2bZM; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TWmXYiEy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xDRi2bZM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731042039; x=1762578039;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4Atp+KexUYe1ID/6Mqf3YuOUu4JCEPvjcsTVGfnHNvE=;
  b=TWmXYiEyVG6XuWbfKFp2zfIbTe5CnYGwClBGlARoo+JsKliKyD5qkpPd
   hZNWxC6tPkb+PgV6CJItqya8dX4x1BYtEZkzYlnzE9Tvyxg+QRQb1u55x
   ErGFHFUpTMtkls48HEk4v++viER3KP1C9e6FvhzsBQ5691XFR1FMfB4EH
   ko/mdyR1nr1ICLGU4BWyuyILdofc52l5SEmqjOfgA29vUoFYEJVk/rd2E
   ju2aHXW4xOFWWeyXq1upgYMU0ONAFeNvQEqChRHagdrqO/HJr2eynQNoj
   dDQJ3nsxvwhkrQjSmF7h4j0G8/EYp5NXunVOgN9Q+q3SQyXYtvw9Ce04B
   A==;
X-CSE-ConnectionGUID: 7+11sBq3SqGxpIzqG6ZqIA==
X-CSE-MsgGUID: cOYFJ/nYQBCbkilZiZ0Alw==
X-IronPort-AV: E=Sophos;i="6.12,136,1728921600"; 
   d="scan'208";a="32053482"
Received: from mail-westus2azlp17010006.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([40.93.10.6])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2024 13:00:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xu27WsYXgbLxV9r6yEey0GQ8+TYIQZYvNS4GC9nNx6Lp5EQR3r50Xq4rIZYFTQA5yjjo5/hYZ3QEwHQTk1gyY5jkhpuOvs3OolWY0KnSflwTMMcocBTueCLjFAWgLY3Yc0KtS4ozQ71+QgF22HdkjQ+ylqE9815WsVDkn5rg+BlclhxhkcoWwo2LhZanFdSP6SK6BZyNGIx8JuUFomhlxM248vtpjc1M0uY5Ymks5K+i1uhTF9sbYtBikKivTsB0a7352Yr+hOwf5xFez7NGBUnZJYieUL9YsMTBn6i3K8tTBSh+7sCe8Qne8NnxK8h6Kliozwz48fSjmFfLqujg1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3HvizoBPG9t3LNgW8jwsZYyg6bOf72C1kyZ4/e2X/c=;
 b=nXfDy4b4g0GKfzm5qar3Mam+AV5eHXmN+sFHCwFdNdix0XrA6GmnYxQhP0gialj57un3o2ydgH/1gDbc3jpFdZ5RPCqYO6EvvbAG/YmPCW54N0uY2gpXzRlePxW6bLbpdvtuuIZnHYCKJ/TM+3j8kDCiuJc2W5eOwXLW9IV5GPeO+8Ox5Ubm4nEdUhHT6RgSp4RjOLKhdOzc5FQUzF4xRx8vqhvR/7lWoWCr5M94xjhhMIDYkQw9Qzxa0/LK2IsS06/qDdqd09Y9SiZZ+ZDiViMym1IiDZIM0gFaplX4VKJoFZ+nGFLWlIlnhD+Y3q2hPX/oCzg1X9Wr/4dfs74vgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3HvizoBPG9t3LNgW8jwsZYyg6bOf72C1kyZ4/e2X/c=;
 b=xDRi2bZMthx+DY15Ypj/Ee+ImgjEXV18WBxgdABygHDl4rieoV1xNz1Z3LJJk2bwfgalqp6f2smBTnr/cUT2L60wDeqfTqCBKai1lKFUBhYtV/tVPzfcW4SrKsn/xWlONiwe/4Q/njOLSCv9+ohmypMYDt407eGzcQLsSU1SxC4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6455.namprd04.prod.outlook.com (2603:10b6:a03:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 05:00:30 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 05:00:29 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "kanie@linux.alibaba.com"
	<kanie@linux.alibaba.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH] nvme: test nvmet-wq sysfs interface
Thread-Topic: [PATCH] nvme: test nvmet-wq sysfs interface
Thread-Index: AQHbLu/o7uVXkmU4Vkas0lacIZBpRLKoQ2WAgAFbpACAAI2qAIACq68A
Date: Fri, 8 Nov 2024 05:00:29 +0000
Message-ID: <gkkr6tngxtb2kdfhlbl3n7mwxh2qkudgjxmd6djcc5umbpqh6j@7xpviqxh4nju>
References: <20241104192907.21358-1-kch@nvidia.com>
 <5d603860-33be-42a2-86c9-a10c224c813d@flourine.local>
 <bd5ea038-42ab-433a-943f-d385ccd96770@nvidia.com>
 <ed4782f6-8fb1-464c-afd2-e03c51030768@flourine.local>
In-Reply-To: <ed4782f6-8fb1-464c-afd2-e03c51030768@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6455:EE_
x-ms-office365-filtering-correlation-id: 2faf532e-2b86-4957-6a59-08dcffb24436
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?quCq8ugNpMbnHjoXTpz/rZewNuc0x7AR83IyooXeZfD24JCnmBb9+yhJyJ+5?=
 =?us-ascii?Q?MmlzEJVIS5LU+nKGdkiY7lpTRSt7o2gZr4eBAVgm3/gP9m9Dcajz2O6SCPVE?=
 =?us-ascii?Q?oyaY3j7Zo4G7ZYirGzkNxPcDh4NlEUnNucaFHKEhSWile0VSqUpHkWCwpABW?=
 =?us-ascii?Q?7CGWpY/1RsUN11T8OS8YaUH9HxB6TvAxqFXQ9tHdhzO3AEmwDZqdRiZTZU8A?=
 =?us-ascii?Q?oV6K7UZ+wrZrI+NSzlKJtpkyZTkvk5aLVHusZiiJAfy/4hYsXWQJQYZsWFLk?=
 =?us-ascii?Q?6A3OTgHZmNrsZPcI++DOIxT1rJTt58MfavkVoVX9ZEWY53eG4WM5m6eXsRme?=
 =?us-ascii?Q?uDoLIU1EvVc7B/3RQ11ovDgT6i4ZVBlzPkUS2EV0HsLzjR/T1HUE5JAqOwmr?=
 =?us-ascii?Q?+llozSPmSOsukqcbEg4Yp/UKwDSVPD0tvIb5FQO7zk27moCAxcliBf74cY+M?=
 =?us-ascii?Q?a5KbhXjcsrtu8KL92fmXJLpkffpPkqhdHRiCX1PpqMyPf3Dxz1EK6EVnR6Ke?=
 =?us-ascii?Q?cHPlMCz5rcB2pcv2T6anUg98d0nfdAij51XoH96m4mt2PdD4Q3It5Jq828F+?=
 =?us-ascii?Q?IwEnX8Xrd1F6mKJ+TrtS8ewsO+e6JeDIpubXT5tVEqph86rh2rsyOQO8OZsl?=
 =?us-ascii?Q?ef3t2SCQioxeOakaXxZg6izPhomI4dDMZuSfp5RAM/wGPnULAQCQwK/iCANQ?=
 =?us-ascii?Q?17532Q5+S4LBCQs8Ll2v89FVcUX7hxN13k7UD7aMl3KShDnispluNm8tw4X5?=
 =?us-ascii?Q?4YX+AARox4Ik0J5pDqNo0M+W6Vvi84jK9FEe84qs6fv6CJ2c/8ykHrfHaoYK?=
 =?us-ascii?Q?wT+foKjeO2nxyDckE3g/kcxoAzo6EVuEvXCKjpru8Tcy9XhxhKUaGYQsMspl?=
 =?us-ascii?Q?iwMwKtbCE289lWkh9xdnZouqBECL7ryG8YJPxrRaBlsqkna3p2F++rVkYPPa?=
 =?us-ascii?Q?zTLEzM7FEs9qb+uTySVyHnM0fTZgqLkwBxhooFXZ74CBN1XNXtmTMuMBtQT6?=
 =?us-ascii?Q?NHkHok7+N9pG18ooEhYqMmoohJRzgQlL1u5d5e2AIUvzk1a4k6AkbeRstDvp?=
 =?us-ascii?Q?ALlRXEWCn74NwT/KqOz5RTrQ3ykNW+LTJX6qcOZpwMcqPWoO6XBWBsowBX+4?=
 =?us-ascii?Q?b4TlLThnbNGqARL71RcpjKHNn6fIy3y2nrso7ajcxpwYyMSOXH0GD60QQkYE?=
 =?us-ascii?Q?VM6PgNI6w/ywFn/INh6wRPlk02JUTy2JEIx0lEpzlISgz0c2vhHILruxg1cV?=
 =?us-ascii?Q?USBqSU1GsnYRj6Vs/G/8NZuINyLpP8mvmz24jzairPsA03Dx4mXnTy5nkWLV?=
 =?us-ascii?Q?uawNMnex9hTnLDR9cLxv1WKkIYYYHnjuoZQ/tvifLn5fib38hMm2BBItwAWk?=
 =?us-ascii?Q?6H/u1CI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jRPxKJ3ELRycYpBubkJ2nASzk/Q8iejaareCs59O2nNDVV/gPHBC5LRbpHAR?=
 =?us-ascii?Q?ECtJmXr+wxdOEUdl2hC54EqvqUOUBTVjOZlmY87f7HPyMDYgxYKoFoBizNca?=
 =?us-ascii?Q?0pzqfzNqllq78yPcFT5UKntoyG+Ssbe15uXZIqGeCiKXRYkuSdfCeWoz9lXy?=
 =?us-ascii?Q?yN/1BXDbYrY7aiB+eWoAQXnMvdGc0vvfVn2YM5quOlZLKGDuSx8ROJXG5+kr?=
 =?us-ascii?Q?ZzNSB2sWj9FOa5rZ0cnL7d7/2bRFn/17v+fGDdwqwxW7AQNtoXiiieLhGgLb?=
 =?us-ascii?Q?2R0uzRPPXgWOsMDUoG+x3b1XzsFmOlol321CkhPrQ33SBo5X4jr5IhbHP1Bc?=
 =?us-ascii?Q?jj75KIRtWPQinuI2s6cjuDiDm4CU4J62zKyym/KiVVgF4Sf5UjocobzNMw0Q?=
 =?us-ascii?Q?gdvJAF3vStonFn5YDVs0In4rBkO8IkfrbfCkmfRRWV8mYI7YNGFmCiwos1bi?=
 =?us-ascii?Q?zACN+RGbWXGlBszJ6EAshEoCiZxwgJC2RX6vIzyMuElGRBRMvlU2tJu7lpB1?=
 =?us-ascii?Q?GbqyuRTnYSfBpaIGyGR3Vu8VEb/bPfZGj0cEIHF8ya8k6buU85VLwrbn4/6a?=
 =?us-ascii?Q?jwEX138zMX/JEsHewp3Lbg4b481wM94TZIXuiwyw5vSri2z9GRCLiMCSPMoz?=
 =?us-ascii?Q?Zc7WCCsREV9uc7OgjdDmlibo8900ER+m3Mz9Z2Ro4e/sHciHjI1dI3bk0BpH?=
 =?us-ascii?Q?dUK9xKCeEt+VO3qF73P81stE8RF5TvGJEADJPEjIPJVVf4aGIjhZAIIgnOH2?=
 =?us-ascii?Q?xmaCwrbGQVcNciuh2+wXa8VlnEUQNY7w37KF7e8bJd6bhTNPDj18ZB87FYF1?=
 =?us-ascii?Q?vzRJkvcCrQVonkHcIY42Ji2d+XOnwfyl+K1CJMJxwVd+S7P5m1BGQLAP1DO7?=
 =?us-ascii?Q?YiWbqwpl8W5Mt0my8iLXbFj99TiwyMjBLCsj69fCExDZ3RUFHAp0EyzzeSp8?=
 =?us-ascii?Q?FrJ4EgSkoWhFd0POXWeSdOsIe99ErFRrK+u7RKnSTX4Ey3jAN1USeqmmbWTs?=
 =?us-ascii?Q?FELQcLmyKOpIKuGklzG4jGj4AaiRwISw/PYFdN4Dqg8cf9lj/VSw4KAloGF/?=
 =?us-ascii?Q?GdJGS/Ylaasu1L0QGPvsa8RHiL2WTVCG+t0pcFAkNs+Q3xtpo0l1OUaSu085?=
 =?us-ascii?Q?3+541T3kj9TPm42Fr6LpPT86pe27pTgIn+31YsA3rCaLM3+qJd4RYz1w1xQV?=
 =?us-ascii?Q?wkMY9G7VaiTfNS69/XhVr7FVa/aAdnOOocUV7R+nFMpDCbtquSxQkGb2wo+a?=
 =?us-ascii?Q?t1HuYipiVC6+g464IfODehiTsjrnU4dDWxKsbvVd2VhnvATsTV2c/fvcLFrY?=
 =?us-ascii?Q?HwHY3UAhbvjCVJiqEiBYxucykvVoa4sqiarF7i+j9GBWBWgxUmfzyUHkanCw?=
 =?us-ascii?Q?Z1XMTiLKH/0q4ut5ulNlt70UMHVCAo0rVd/irV1zkJyc1+a+85flNvulqV0X?=
 =?us-ascii?Q?nNAa/K4Vl5dVCpefXDEpNuJbc6yu45zqI7oadvOy08qCO6qw6fA+pbgQ0Uw2?=
 =?us-ascii?Q?vLSYJRZjOWiYRuoylsjYrUI7YF09H5BHJWcIUPd86b2rnkfjDPgKT0nFGPVT?=
 =?us-ascii?Q?uDlJMWs2UYfF+L3tXh8ebZmWto3Q1h8lUWBP3at7HjGGvryqUVk0nfwuxegH?=
 =?us-ascii?Q?8HfQ0EGSAC0ggi97zsuFo2k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7C23EB0AE8D3042A2E541AD8341A705@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JV1LasKEz/8mQF2jr0mSeWKwZi0qoV/mKZMFhnOGFn1hYP832NwtNyu0CW+G4t4vJAFNPi1YHnF50B70fZA++e8lImyXaKyprpx2xEwa/9tpKhJVsorsWmif6WvWLkX5LDBCTv86vLsOQU0T+zFw7PZMyLqCPECucVvCnQB+Tj3saS+sZPeLwkNy39ZcT1oHygp6j22y3O0xR2xTDt0ooNkTXURzJcRObd9RA/StsjjQaRUG0vi2zIuegeqVvdWd7VZT3UblQGkI8kZjkH3eoHHi6XvSNBpXtx/iv8fal1te4c47gQQ6AZ1xGcZCf4JebCoA9C0S9PNdDY0rekarwdV7FJNtCnnw0Lbb28o9aaDq+R2Y1nVhlpeeBl1/be4oO3Q2bLABTjHX4NurNIAyCrvZKCzTl+NHmp/xMZ69xbgoH4kCXTEjdiHH6GTaZEwVlXQqzaIxU3lQM2wxOi5Ysb0+R5MGmZ061p7EZAXS46gHZDJ9YMLJP/WULKSgDk/Cx3WX3tjUdyCcCwLds0sYX9Ms0WSmV9eUXqLBZMQMIZfC7iOKqwheR6nEEu3rtwfUS0Bove9ruE4oCpGZI1Dk8Ff1YPcRxEuOZmm1G7e9yMQ9rklItn07Qy0B0838Zh0x
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2faf532e-2b86-4957-6a59-08dcffb24436
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 05:00:29.2878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjQYJV5tMSQTIE4VMCO+EQ5Iu4oWTn9VUbZUbosocLdqeETBXDP+O/Cxylqv/Ss/q5yBWhSCDPN3voyj7Mcg4RF+kXasTFpO3DLcUmff+2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6455

On Nov 06, 2024 / 13:13, Daniel Wagner wrote:
> On Wed, Nov 06, 2024 at 03:46:26AM GMT, Chaitanya Kulkarni wrote:
> > On 11/4/24 23:02, Daniel Wagner wrote:
> > > On Mon, Nov 04, 2024 at 11:29:07AM GMT, Chaitanya Kulkarni wrote:
> > >> +# Test nvmet-wq cpumask sysfs attribute with NVMe-oF and fio worklo=
ad=20
> > > What do you want to test here? What's the objective? I don't see any=
=20
> > > block layer related parts or do I miss something?=20
> >=20
> > For NVMeOF target we have exported nvmet-wq to userspace with
> > recent patch. This behavior is new and I don't think there is any test
> > exists that runs the fio workload while changing the CPUMASK randomly
> > to ensure the stability for nvmet-wq when application is using the bloc=
k
> > layer. Hence we need the test for latest patch we have added to the
> > 6.13.
>=20
> Though this is not a performance measurement just a functional testing if
> the scheduler works. I don't think we should add such tests
> because it will add to the overall runtime for little benefit. I am
> pretty sure there already tests (e.g. kunit) which do more elaborate
> scheduler tests.

When I ran the test case on my test system using the kernel v6.12-rc6 and t=
he
patch "nvmet: make nvmet_wq visible in sysfs", I observed a kernel INFO [1]=
.
This INFO looks indicating a bug in nvmet driver. Is this a known issue? Th=
e
INFO is stably recreated with loop, rdma and tcp transports on my test syst=
em.

If this is a new, unknown issue, this test case a good test to exercise nvm=
et
driver. It looks worth adding to blktests.

As for the runtime cost, I think the test case can be modified to reflect t=
he
TIMEOUT variable users set. This will allow users to control the runtime co=
st to
some extent.

[1]

[   87.365354][  T963] run blktests nvme/055 at 2024-11-08 09:32:42
[   87.433572][ T1011] loop0: detected capacity change from 0 to 2097152
[   87.452511][ T1014] nvmet: adding nsid 1 to subsystem blktests-subsystem=
-1
[   87.478018][ T1019] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[   87.565565][  T226] nvmet: creating nvm controller 1 for subsystem blkte=
sts-subsystem-1 for NQN nqn.20.
[   87.570700][ T1026] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for =
full support of multi-port dev.
[   87.573064][ T1026] nvme nvme1: creating 4 I/O queues.
[   87.577041][ T1026] nvme nvme1: mapped 4/0/0 default/read/poll queues.
[   87.580437][ T1026] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", ad=
dr 127.0.0.1:4420, hostnqn: nq9
[  101.337422][ T1073] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1=
"
[  101.383814][  T104] INFO: trying to register non-static key.
[  101.384456][  T104] The code is fine but needs lockdep annotation, or ma=
ybe
[  101.385136][  T104] you didn't initialize this object before use?
[  101.385758][  T104] turning off the locking correctness validator.
[  101.386392][  T104] CPU: 1 UID: 0 PID: 104 Comm: kworker/u16:4 Not taint=
ed 6.12.0-rc6+ #361
[  101.387197][  T104] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.3-3.fc41 04/01/204
[  101.388109][  T104] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nv=
met_tcp]
[  101.388868][  T104] Call Trace:
[  101.389203][  T104]  <TASK>
[  101.389484][  T104]  dump_stack_lvl+0x6a/0x90
[  101.389927][  T104]  register_lock_class+0xe2a/0x10a0
[  101.390444][  T104]  ? __lock_acquire+0xd1b/0x5f20
[  101.390921][  T104]  ? __pfx_register_lock_class+0x10/0x10
[  101.391479][  T104]  __lock_acquire+0x81e/0x5f20
[  101.391939][  T104]  ? lock_is_held_type+0xd5/0x130
[  101.392434][  T104]  ? find_held_lock+0x2d/0x110
[  101.392891][  T104]  ? __pfx___lock_acquire+0x10/0x10
[  101.393399][  T104]  ? lock_release+0x460/0x7a0
[  101.393853][  T104]  ? __pfx_lock_release+0x10/0x10
[  101.394351][  T104]  lock_acquire.part.0+0x12d/0x360
[  101.394841][  T104]  ? xa_erase+0xd/0x30
[  101.395255][  T104]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  101.395793][  T104]  ? rcu_is_watching+0x11/0xb0
[  101.396271][  T104]  ? trace_lock_acquire+0x12f/0x1a0
[  101.396770][  T104]  ? __pfx___flush_work+0x10/0x10
[  101.397266][  T104]  ? xa_erase+0xd/0x30
[  101.397658][  T104]  ? lock_acquire+0x2d/0xc0
[  101.398089][  T104]  ? xa_erase+0xd/0x30
[  101.398501][  T104]  _raw_spin_lock+0x2f/0x40
[  101.398933][  T104]  ? xa_erase+0xd/0x30
[  101.400167][  T104]  xa_erase+0xd/0x30
[  101.401359][  T104]  nvmet_ctrl_destroy_pr+0x10e/0x1c0 [nvmet]
[  101.402767][  T104]  ? __pfx_nvmet_ctrl_destroy_pr+0x10/0x10 [nvmet]
[  101.404235][  T104]  ? __pfx___might_resched+0x10/0x10
[  101.405558][  T104]  nvmet_ctrl_free+0x2f0/0x830 [nvmet]
[  101.406900][  T104]  ? lockdep_hardirqs_on+0x78/0x100
[  101.408192][  T104]  ? __cancel_work+0x166/0x230
[  101.409398][  T104]  ? __pfx_nvmet_ctrl_free+0x10/0x10 [nvmet]
[  101.410726][  T104]  ? rcu_is_watching+0x11/0xb0
[  101.411938][  T104]  ? kfree+0x13e/0x4a0
[  101.413073][  T104]  ? lockdep_hardirqs_on+0x78/0x100
[  101.414318][  T104]  nvmet_sq_destroy+0x1f2/0x3a0 [nvmet]
[  101.415556][  T104]  nvmet_tcp_release_queue_work+0x4c0/0xe40 [nvmet_tcp=
]
[  101.416912][  T104]  process_one_work+0x85a/0x1460
[  101.418064][  T104]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  101.419266][  T104]  ? __pfx_process_one_work+0x10/0x10
[  101.420427][  T104]  ? assign_work+0x16c/0x240
[  101.421486][  T104]  ? lock_is_held_type+0xd5/0x130
[  101.422555][  T104]  worker_thread+0x5e2/0xfc0
[  101.423574][  T104]  ? __pfx_worker_thread+0x10/0x10
[  101.424639][  T104]  kthread+0x2d1/0x3a0
[  101.425587][  T104]  ? _raw_spin_unlock_irq+0x24/0x50
[  101.426644][  T104]  ? __pfx_kthread+0x10/0x10
[  101.427637][  T104]  ret_from_fork+0x30/0x70
[  101.428596][  T104]  ? __pfx_kthread+0x10/0x10
[  101.429562][  T104]  ret_from_fork_asm+0x1a/0x30
[  101.430535][  T104]  </TASK>=
