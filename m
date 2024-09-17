Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9277641E
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726574126; cv=fail; b=tAP4fe+tHULroxzXq3g+o8z0qcIc3IMvswafB0zjm6ZpROMpz+4QGtygdFRILj8kRvwFjUsc5NVUSMWRVULXXfOAHWSw/G9F7BppBWHJurf5W6VVqVVcU3u9tXgJUeAG5qAEaVmPzCxGPH/iQbN7V9mi81DX5a2ZZFY4yC/DImY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726574126; c=relaxed/simple;
	bh=DLPQ50tlDDvmAP2QssOR7RD9rzKUYzucv50ri55igJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SznGDpaZHeObZNkcO30WUKky/bVsXv5WKk0ZKBpseb/CdBLnXVDuvz8Uh+iaATkkY4EqrctP8YNVHkuSC2i2VWKLty2Jgkr/D1lct2fe7Nu6Po7RHlpV1xCG3zcj5ds2EXJUxDFMzExsrBmaGE6b/ryCThI4qIbtaWg3kQXbdCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JRjRfipA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Rn4vmO+U; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JRjRfipA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Rn4vmO+U"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1726574125; x=1758110125;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DLPQ50tlDDvmAP2QssOR7RD9rzKUYzucv50ri55igJw=;
  b=JRjRfipAqyfOOqnUJxNjJnbqzAmXWoQzHNDBdBriMQvcKeLGw7RNacuR
   iJ+LSimoLUm3Y4IgGwIbjUXPMcTL9YANSsHqchgZpeftBZJAqb2b+sO4x
   Uod7TFl/aFoadAX6xVfVRtut3PGAzfJAZ+uhEzpP8m88mkhDzozc5E+Ij
   VPFphmUrkWAjn/3qNNZ71TuLWVcZdMf+CQT3P374up2vr5DGbA81nqm0n
   ozDC8U4KifL4gmkcpy+LEv9TK6PcMu43afklpMw8fJL2u2TeoRROsbojo
   fD86BDYLgUiAzC399U0sdwPfJK5pXh82bkV5X2h1I0shLnIVx+40Iimc8
   g==;
X-CSE-ConnectionGUID: cFgQPQN2QWmDD3peuduk0A==
X-CSE-MsgGUID: ErirhWsSQQKIwrJkXzkkyw==
X-IronPort-AV: E=Sophos;i="6.10,235,1719849600"; 
   d="scan'208";a="26880973"
Received: from mail-bn7nam10lp2049.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.49])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2024 19:55:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4zZPUIikG6mBLdY9WSSkXSL/mFT9M3HxghRJbJoR7IanC6zivLWpJqQ+eexYRsbOuWttzPTo2mPnv/X+vgTY9gfznVjKrPUBvuHoQjIbXSMFcyDKy3JvmJk98YU1EVr2J8kCSK5LN25HalhdIrknmaycur7wlVkV5pNhqfG3f408xkLdqXB89Q3ExgbOU1Ne36AM7snj3w6Yx9KHx3qBx2h/KOQKWwwodX/MKoysaNvGojQDb5889G1BV0kNuUzd4UtW0zdnxB5i7Bgtbot8UaJdtZEKo42bi/oaETEWGjAC6Ya80f0/ESLSqHph8t3YxKJ+fCLE+6+asTTi4OAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLPQ50tlDDvmAP2QssOR7RD9rzKUYzucv50ri55igJw=;
 b=iBCRLP3dDDdk9ixQBAHXZm87BmDJUYBAiKHudsaRHeFc5eWDO65MM8oNm3sBCsDslwZwk5LFJDdgR+J43+z7xDwt4c2iAA1Dc/FrhQQE7KBGTnHzbIZd78/Pe1zc7iXAt47LhK8onocKNsoVcWfp4yFC4LOMlRZ3/VTnnmyWImLStmd/Cy8gBsxaU2IjsNx1k1nqPoxPd7z2n6BdCohxrhNxb4C8P4sujyQg739jrRPg5Mtb5eL27DbkRSFsnedhn/ZWSV/9jQ2OwMub7Pd5Rls81zWjCYmOHY1VnKzDnF8rruBBDR5fq7Xz1PjRzEwSGonoeE4SxxmgqVwYHlDG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLPQ50tlDDvmAP2QssOR7RD9rzKUYzucv50ri55igJw=;
 b=Rn4vmO+ULALi/hRoav+uQjsfOzdkX/nRnbugnKBFwqFJ7ClUroDuIwQMHNXIFCBAjxKaebUJgojeXJlDkOiGT/kfVHUYiQjeF2wkYQpAvbBay+c8KuVC7q1P/+OmPMp5McERhcDobRjmcbYgvFLInkxAmdEVMFi2ORTK9t3GaYc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7287.namprd04.prod.outlook.com (2603:10b6:510:1c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.24; Tue, 17 Sep 2024 11:55:07 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 11:55:06 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "Richard W . M . Jones" <rjones@redhat.com>,
	Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>, Jiri Jaburek
	<jjaburek@redhat.com>, hch <hch@lst.de>, Bart Van Assche
	<bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: Re: [PATCH] block: Fix elv_iosched_local_module handling of "none"
 scheduler
Thread-Topic: [PATCH] block: Fix elv_iosched_local_module handling of "none"
 scheduler
Thread-Index: AQHbCMMVnCOmldIqM0GH8Jy9oylIPLJb31iA
Date: Tue, 17 Sep 2024 11:55:06 +0000
Message-ID: <xz5jgxpcfnirz2symt2yetudyup2gexzroe2wcqtpxfyjm4qgd@vsc4vlx6pxuq>
References: <20240917053258.128827-1-dlemoal@kernel.org>
In-Reply-To: <20240917053258.128827-1-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7287:EE_
x-ms-office365-filtering-correlation-id: 920c2a80-ae21-499e-48db-08dcd70f92c5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TJn6UMHjVh1000JFQbu0P6SOHMT66sNYb9m0gH6JB1pkH1UGKQRZRjbobX6G?=
 =?us-ascii?Q?lZZKIL9mAWLC7Y0BmdFltTeKYjyZJf+XUDlzYMgu2gQ8zPXuu9uBGJuIlsgk?=
 =?us-ascii?Q?AkBQJ9yJXuPq6llKHaWlqwPRg7ymkGd1wZAgYMrWn1rXJSclIoVwRNyN21iV?=
 =?us-ascii?Q?AUHJYYVmDGvs1VOpC6HqwOHb1FCcJVwOJXKM3p+buGlGj+oAE+hLqNfbIOpx?=
 =?us-ascii?Q?rmti5/JJoYR9KW58nQcTNm54yDP6wNpU76SS1jxu+soybNY7wDNvlu5ePr77?=
 =?us-ascii?Q?n0f5dHBNaKeaxWEO1O1x9sKIhcx2tI3wgpGld/URi16C+RuZ1lYTln7X3Dl4?=
 =?us-ascii?Q?vJMe8WUpl7O6rvVoTYKz5TT5Jv3i5PBySlh4AsZJM3piw96RZMgG2oZvYfNK?=
 =?us-ascii?Q?vrXD5NT7/2jyrTPTvbxT497bwCwovi81naPx0fO7XbZp6MoceZ9ucAE1L6IF?=
 =?us-ascii?Q?DF1r0/jnzKS8YJENYwcxgdeP+rXcYh4W0s8V6y6QpvQg7AA9Kwe9bL5xbkkx?=
 =?us-ascii?Q?H+A7k5+B4jfFr6p38SS/uMR8XfT3YX5H+NFnD//loEnkkHUS6OgdHhBJt+/6?=
 =?us-ascii?Q?dYL/2eXJYwFsiaXX5qVEiGCGRB1t7unlhDTCewzd0F5D/h6ECuFqfVBaNkJK?=
 =?us-ascii?Q?ypaA1eaMbjInZ9zxgUhL4+UBfdZ7LAKnIQupKns1oBNzFsFO3X4smL+Qfybl?=
 =?us-ascii?Q?aI4BriRWV7iYQKtHGoJzXBCnVlU53hd8m0mdZOgoN9f0+44e/Ty21Z1W2gV4?=
 =?us-ascii?Q?GgGtbRtSRmNeuUD++ubGg1RsdJzxIwpqtBtFQn/+4jmgqBJGWYcPpVDz9e86?=
 =?us-ascii?Q?K1w32ZkvoG2PjE95zbR45GUm93w2uy2wU7GvJYhViv4H+YGAFgHWK0JC0FRb?=
 =?us-ascii?Q?69mHugW3QYWAXjMA5XJj5AV7e0CjO9ZIkdGUeE6wnREqZDAEv2PY2n5jg45F?=
 =?us-ascii?Q?D+S8LQxtKMxb7JBhUGAsD1Y6BREhr6P5ck8hyVNyQ6X8qBgyvSkUKYxPp7EA?=
 =?us-ascii?Q?M42t9c/x3iJFLJcyl8oUN4oy0OnmB0wWgH/1LlTHVqLcqCPn3570vapie99h?=
 =?us-ascii?Q?EZIWa22Hb3pNRECWCsRs154ihAT8wnXk3nIB4ZaRlGdj/90ICiiXsj2Msf2q?=
 =?us-ascii?Q?AnHDlAA/WP07Rx3fa5d3wfVA3wNLsDNaovTnp1Q2c7bkj6171URpofWM2wvF?=
 =?us-ascii?Q?jyXZenPRQ5dNA9nToONoYuvojEpLfiPlPGK5MQJWP4xcEdoLJsMrrGEucFa5?=
 =?us-ascii?Q?uQW5Ax3QJq9jCaSXQEc7/cEwgFpsJPuuDe1ydL9l8lB8HLJCq8bbtsYyW9gW?=
 =?us-ascii?Q?gDaOjSahEQNrlv+aageJnfgK9BtghhngdfvRIRNmt65IpTG+KqxlATbvNDlm?=
 =?us-ascii?Q?pPEG8ijunCYhxaN39jIcDLlQrfLHZj4nUm996rcQMl6VMIzUpg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LKMHtrtLi6yJCT5Q/QxWKaxddoPt/eI0gUbXcSvGhGn/+xhNZiZ/oCBh9XoV?=
 =?us-ascii?Q?JGlTZ4ZvUeoxxB9ItQODqZ/Kc8nE5qQ3FfFNlmm2F5y9D2lkvM32D3dHdD67?=
 =?us-ascii?Q?g3ZQEe1BhNalP2SYg+n6vsVDyEh6FXKwTRghLr0ioTmQFSVWfWyzC4mzcFU8?=
 =?us-ascii?Q?edMD2ksX0bNWAM8IKxQ41FO/fWKxO3GQkRT/67BFWe2g7yVh9HeLxnycFqD3?=
 =?us-ascii?Q?PwkRY2cZBuQYdT16tVMXEseXvvAIi4kQFw8jTl6Ask/Io7+qdDxef6GM65PK?=
 =?us-ascii?Q?KC16X4Ht13h/p/emIMdjTp+ow7fhMFG4u6JG4jTVkrPrJVXWFXFmjZ3d0u6d?=
 =?us-ascii?Q?M/0Cn1Yzo3WxnoWqLvQukVWErFUhz1gII+S+T6ci/n5UDyqxAQ8i95T8wsw9?=
 =?us-ascii?Q?ezzvSNOzD2uYCoj5GG0Hza9xL5pAiHj7a7Gby0D+wSDrqQ1KWNSh5IJzD4HD?=
 =?us-ascii?Q?ce3R79jS+eJCk/Ik8EZebILXutKxJcQg51xwK93f82mdZetkjN0lqHou4neW?=
 =?us-ascii?Q?5k1Y8sgr1I788hvfJkaolEbUcKGelPbWrJ5t8e5YpLVzPEGxfNDyrV6FdsBQ?=
 =?us-ascii?Q?xzQfUP03djF2DIn2y1iKnMgI4KXnsnODBmCvP/cGu/P5/cmNzPWBd8v3Icdc?=
 =?us-ascii?Q?chUPrHJ0GiRuX1r8myPehpt30R3EZBqWdi85S5B3atV5eSgiYGytmhyNXwn2?=
 =?us-ascii?Q?Y9Xm2wrkOo1zqP0L50VX8WPziw/4CreFO5G9zChZn+fBB2CSZNrD//ONcCPW?=
 =?us-ascii?Q?MwtPX5Z2BoAEYtjQSU6Y4EnXuRXmysAljjfGQ+QRMJBzPaKoF5A3YJCZyilH?=
 =?us-ascii?Q?n4DmgDvFHdzyisIpjM2pGNcKUqCYQz4GB/DSJomI3T1YfNz0unD8ftXjIHzW?=
 =?us-ascii?Q?LuDfC+BaqdyMPEZLesyjJLV3OILRQG3jzcKiIEEd/qnDC87edC6xXTRdvltL?=
 =?us-ascii?Q?5affSH/j/9a0yfDKfAB/6hANzx8dSQgwJlwYD5ORxpY2f4T2+G7Nsq6zq0po?=
 =?us-ascii?Q?QVF59UuSjLhdyi2xYVUYH1/eZ8ZQ8Az/jWvKCRqfhFqjybkFTDJUIe7y1ZF+?=
 =?us-ascii?Q?VNWW/Y5svQF2FCAEWgIf1m4g97B4tVPeQJwf8SfQhv3FRrL/+XK/gp/Wr7us?=
 =?us-ascii?Q?PgiJ/r5k+ZlP9oBbX070QKaa26jjoFdRpxToDY3JvB5rUvMypdcRpiEb5RgF?=
 =?us-ascii?Q?Lm/1jz8U08nZDEkJoZX56LJqEn6uJx8FWhgRGjAtUgfhcnM2EeG2dWBbFTv6?=
 =?us-ascii?Q?PS3rS020F8HyUkaVXqjyTSK+JgHkg0CFDyGhF3Legf8y9STHcqmdV/65yaM+?=
 =?us-ascii?Q?M7cbTLh4qhkvgdtXKgUCnHSSd3HXCNPzuJTgURINqhuwIHYNYKbkbgzRmRyP?=
 =?us-ascii?Q?PHZL+5S42zgfhRqPHe2X43YdqaClptVVKOsMgRJh0q1RsXdQpxjr+Nfq/zEo?=
 =?us-ascii?Q?LFjR+QDggEwOh7YjgjBJiKifyAbedEEzhnrVdVmhnoliWd1AhrZB7Ph/b+RC?=
 =?us-ascii?Q?WyNnwmCda/ROnIDj67ZWLiqanSGwfcRKFcaYAbWdtD7Y0FcfmoRXfRQdKfIg?=
 =?us-ascii?Q?8IQLhQxCD0zQS6bCc/wqsaeTAoiosGV+0fQQ01h1fdXS2quNwX7UIIvrLxNO?=
 =?us-ascii?Q?LHicdXtJQcliXCwnsLCoit4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8EA32E6AA4867449E4BA908F6BCBEA2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cPUMMWrgDKe+YytLH/KOnfp7cz7mKEWyZAbi4MvD6433IeI1ZHqdvROa2m4Mrf/KUw4YB4bxOG8ysKBIRKumz1WmdMNY3Nlw7aqFOVoQqVualsNiWojG+WcWkFMwD8mVgjER9UqzK+b3/h2xMsYDsq+kCG1soVz3rWEOMETP5MS716sNwdE2yonj/9+r1Mit89hG9c/wjrfCRRwck/iYPfbUSYtIHjV/wm47hd4yMLQkwJUMV5gVbOG65DQq/Pkai8GkRjWVWpDp+aNYpxBOQxqDOL1a6M57xLN7kSW14bcLIO2c1NZB/5MZ+hDfJkZIAnplvip/IN6VZ30e8cyxP9Xt43sIF6ou43GV+1r2WMKb+FprXMDDKywWYamna6IbvHDvdd2GMqzUDhQIucyOCoUTxYLGVIRKIG8ryYANr1gxB8cYA3/VKnl3f4M69WYzphUwyguFxO+WtqL/nHfNQNZCSGtx+P3Vu7gXaDTlIfQrj/PN1qBt3IcX3xee18SXrlYVrcmv6tAH4WNkUrBZHVdDDTg8c+iLBmdJ4j9/V5cxXmxQYAKkHXwwbQkepZfbW5AtNxyBjq9TzkH3oYBp0jr8gUushws96KeVAEb4Tjm0Q15jnqEqJCF5qZn1T+up
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920c2a80-ae21-499e-48db-08dcd70f92c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 11:55:06.6561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2LqjsbEm33BWV72ns0WsCznOGW5U9A57YGZCOfPW8A80nxQtOwMXF39zTehnekCL0ohGvE+JrnQquLOAjnMZR6Z7kfKs/M/YIU8ZmbnM68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7287

On Sep 17, 2024 / 14:32, Damien Le Moal wrote:
> Commit 734e1a860312 ("block: Prevent deadlocks when switching
> elevators") introduced the function elv_iosched_load_module() to allow
> loading an elevator module outside of elv_iosched_store() with the
> target device queue not frozen, to avoid deadlocks. However, the "none"
> scheduler does not have a module and as a result,
> elv_iosched_load_module() always returns an error when trying to switch
> to this valid scheduler.

This unexpected behavior (setting none scheduler has no effect) was found
by the blktests test case scsi/008 failure. This test case invokes the fio
command with the --ioscheduler=3Dnone option.

>=20
> Fix this by checking that the requested scheduler is "none" and doing
> nothing in that case.

I confirmed this fix patch avoids the unexpected behavior, and makes scsi/0=
08
pass.

>=20
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 734e1a860312 ("block: Prevent deadlocks when switching elevators")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

I also run whole blktests applying this patch on top of the v6.11 kernel, a=
nd
observed no regression. Looks good from testing point of view.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=
