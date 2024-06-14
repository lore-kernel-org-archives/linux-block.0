Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE05148301
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 05:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718341915; cv=fail; b=udqyZxZWY2LE7H0RkidCNbKGAr+Xdp8gK2hV+PET369wKkBvKCgDjI97Tx5a9mm50BOA7D0Yt+BWnuQ5un2WSEIZbb8xwJcHXjke8bGOted7/Wd14GRCkbhkLIiXyVAB7XW6nnH8LApZZ/J7r/HBTY/6Ddeu9VARbRF3F0pgtqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718341915; c=relaxed/simple;
	bh=Va5I2uwOq4K4hUJoSD4vTrwpYIawiCqqFwO9VE6VZNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W2CuV5kQ7sxIdyVZbtPIFKbxNQ/JHbFNJBQfs203MKqdNRXWg+2eTAaZnX+KJL0CczZGjJ2HSwa5YGDbhlAlbLdtDAdxXU6TqAOzc/RHbRe8lXsU+zcNVnsElpEEQb8hPZEcql2NttmRNj7FpWlZqo8D/u2uG/qd4+EKczmjC0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IkSxvwiI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=E3G5BX9H; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IkSxvwiI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E3G5BX9H"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718341913; x=1749877913;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Va5I2uwOq4K4hUJoSD4vTrwpYIawiCqqFwO9VE6VZNs=;
  b=IkSxvwiIqzizjF47Bq6pQDoJ4Gz1DIhtL8CWnnZb4wPoxWbB/g2PiDMj
   tG41jmJ0eptQtx6UszlFU9On2RazuqXGoAa/WPC1wB4kNIgyQv8MbZcTr
   qFGP0XbSnELC54b2cmstiaEA/TPdO/VybisDYlWVYnaT7WHvnWWFU01g6
   smgQ9Sfvn2NH5nevH/IIP0aHihff/BnSd49HVNmWd5C0LWAKbtnh6ZX9E
   OdGZLkfKTxcrWnEm06yIMiLiQAp+lB3vm5aCjSe+tbgJYTdCWSajr1Zbf
   F4Iy1lA6I5UJOhrGvwaSImpW+EPH+onUQ2PxiXYjuD4m5Eo2iWKil8GEj
   A==;
X-CSE-ConnectionGUID: Vhuf0bQmQxqOfhzjLg4NAg==
X-CSE-MsgGUID: QCPA+98QTRqg6LNR8XzxLA==
X-IronPort-AV: E=Sophos;i="6.08,236,1712592000"; 
   d="scan'208";a="18816047"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2024 13:11:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVW62Po672eNd2Ux87QRByKUwJ7m7+0WYyvxvdfbSjXbHiSSmwuiUqFIeLzDU9n39ppI25aZ29G8JOlUdRZJIYSM1kEJNZBW6LX9dzdx96DJ8GDzTinJT1lfQqGijs2xMc5OPgoPnLF+rHR+hwK+dszj1zro+FZoCgy0cItviANgHiM/1TNmTdec3qNpJZ8pMgUpsigzsNLGwJKEB2FxPoE312LhJFBslp/uRecM5nVHMG8O+Dwd10WL7E3KzcP0DtDYICDWm0bxaBWxXPvbuKO27oRe0ckQzYESgxS4m1sJ3ryYbEQZdBZnAb6wiV5w33F383gZhugqAwa5Bsyalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73CijgHtU5igwgv6vyQSkh/5R/BAw4Ua4qDYfD8/9mQ=;
 b=dpKpXouqFieHPgD/GmAuhdUKxz3kXnPqunR/vlxt1Pdxpj3snGqgXsEzbFT9cvmL1zWwMHc3HZ0xZBwaHhdPVT6beXVtlESAXf+A4ay/xslcAtKVOvOi78GDlNUC4PN5U/8ZkF9BT9ZgcQjMXrtc7aPZwaERyH7u9WielIzN4KTCyHN5KvBxt1XFPqVH6V272zD1a6NlX3ydQcKPT+u9mfab5qzxzOZxu1tVQpqa7olrfSr/fRdOfJPlN0HugjDn+u9uPNdJt+rk2tpSPgLcWjmiY0N+rkUniIB8ARN/Ww17qKjSd/8XGzcOMeDLj+bsanqh2iP3nJGMtfLmnu7dcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73CijgHtU5igwgv6vyQSkh/5R/BAw4Ua4qDYfD8/9mQ=;
 b=E3G5BX9HRt41/OtmPFjWM39D+GW66zZSBDYX56qMn1qX+rAiWEAz7UpEUyzJxTcn124DBX3ijiAhHr2T72GQioeUl40TA0nL+8aRirM5phMvu9A9u5+HOFK4G8h6WltMoV0L22Td49Df/kfY4IbD9Sdt+zjet5B3D9vpl4iEnKA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6678.namprd04.prod.outlook.com (2603:10b6:610:a1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.25; Fri, 14 Jun 2024 05:11:51 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 05:11:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke
	<hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC blktests v2 2/3] nvme/030: only run against kernel soft
 target
Thread-Topic: [RFC blktests v2 2/3] nvme/030: only run against kernel soft
 target
Thread-Index: AQHavLhb5Md8q1XXD0Kbbdw/fRDgJ7HGuUgA
Date: Fri, 14 Jun 2024 05:11:51 +0000
Message-ID: <avz3npwlonxwxnylhkyi23kphvzwjq7gbsgjtcumo2cagjkbbo@qdalayt5wxux>
References: <20240612110444.4507-1-dwagner@suse.de>
 <20240612110444.4507-3-dwagner@suse.de>
In-Reply-To: <20240612110444.4507-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6678:EE_
x-ms-office365-filtering-correlation-id: 62a83804-522b-422b-0c2f-08dc8c307fdb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1pdq0KKJCit5zz1JhggsowSk/J+c6Gz/ebpjK/F8pxckEFDc5wQeEZA7mw46?=
 =?us-ascii?Q?EBWmJNbdJcqk+DzcGBoJSWUCgywrqlXQp2V5qotuS/qonYoij56aDUGL/M69?=
 =?us-ascii?Q?a9jkp2D5kgLK9dFiuiaDQkS9VQGP3EziOv1NTkKJtoO9gW++Fj1SwNSf+vhy?=
 =?us-ascii?Q?Ue+UuKTWWgRVwl6ZQKdtAf9bSvlFE3nOr34fdLG53Gx7S62p3KsC1zYkhLNp?=
 =?us-ascii?Q?rR44IIXBl7rH00gxiLk8fwXCd8ANxCAXryTYqPiCkuDj4sbrZJH4Wa+BjQPT?=
 =?us-ascii?Q?8jWYwsXXU1KHbl+np4C7e9Q+IrUzfhZQKbllpDp/td+o3tQCwejrrFZIgTem?=
 =?us-ascii?Q?W/QJi8zuKISywGEpA5zZvo/7ns1iDgyeGdl063UtDckniItEMHjo0f4F5RTr?=
 =?us-ascii?Q?grTbaSkn14Ts1WoakV26NRCWi2gYP3EC4TYe1vdw0SIbSj59E9szhccO2VXo?=
 =?us-ascii?Q?6IqXhjEs6H4lr6faHuzUHUeXfEMlnuUEitDljRAOrjuTdlabF+e4ULG4v2bT?=
 =?us-ascii?Q?sQYmM9jMP18S9UK4Za4QO0gsBRk1+YIdJmhqgTf8fGEc0TsL5QkMzlt15iLT?=
 =?us-ascii?Q?9KOqPeWsbHs5coOuCpqzjNxpBIESyA5ievq/11L/hM5YDC1il1htdb14IE2T?=
 =?us-ascii?Q?53c0eR/AJ6hgbtw1/KLymgs7UEMdKIGiPxKX5bV0wfjwWir6Hoq622UaxFlg?=
 =?us-ascii?Q?VkDPS++NNcemRP6Bd575pYACeV3LvJsQPPzXW7GqPBuRjZTtyNb8iuWEhwDF?=
 =?us-ascii?Q?z//SZissyRrkiceidCxMMThcu3Xg+WVHFrcYcyWu9/0fGtTui8jba+IJfDQa?=
 =?us-ascii?Q?UJWMy3shlym4/Kg4F6E75lJ+YrUDbzzvx1PZdsgOiEUx6wUAZEhGlquPauja?=
 =?us-ascii?Q?BI4WoKuar9XzX9Obxe5PebsEUt1mLh/8bxOLqLlGTJusACIFWReBhLZz6X+M?=
 =?us-ascii?Q?SvxdlxiVdnAj+qCHbxq+TlQfuBv2l/cLBlmOH0IINT//CeY3J6i1P41IAH6j?=
 =?us-ascii?Q?Io12ZCA7Qrj+bEsABefssjHebT++vnIvAS8ssgojPH8tmRN3aMuHTOzgQTyU?=
 =?us-ascii?Q?kt5/hQDkJMc6E3QeSe8hnsU50UK1VKpJsMf9HoiP5r8A3zHtCJaKKIDYxxNP?=
 =?us-ascii?Q?U4q57c6I0Uuk7dexLM9ww2JKpE9pNJBbS2PtMrPK5M0nU22Kt5whQ2dSKlG8?=
 =?us-ascii?Q?uS4QQuHiej6je909Rpo+RZEd//HPtjPIioOGkF5Ntyx+ezHCm0deE03D1rDo?=
 =?us-ascii?Q?XX9tKrcVituTpukIfuR8kv+EN6yypXZICu6yVUUSBa63hA2syR8rfqTKx0K8?=
 =?us-ascii?Q?r4+upFFqJku1B3znPI/jLG8+z0y8D4rHeQZAvWyvXH09G8AtzrCD+mewX4/q?=
 =?us-ascii?Q?+z70he0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RJRqVnuniXH32fqvUpl/BMGjfhYcsqKHH0mfdMo24tp+bL1keIWEV4cKrRYu?=
 =?us-ascii?Q?Vv/n3zSHGafjp++cVw5jQZ9MwhPBm84WCYN0TFinRG2mX/caq+kXlwC5w5LU?=
 =?us-ascii?Q?PI+rKjHDa8lm2SdUYHl+qOmf0PnKwroSEOHFSaCUV0t+N5RlvIsd9uGS7xtx?=
 =?us-ascii?Q?bED88UXV+IRDMs3tnoSC3BJkHDUFQrcnFqHIJoe3eVg+G1NWZOAI+iNYXD7P?=
 =?us-ascii?Q?FaE/1fDvnop2qe9QL0jbzn3yYXAXKvykmmyVDS1+n9MAnrlzgpJ7yukpRWxr?=
 =?us-ascii?Q?lEQ+09NsJs99SSPNdjEhXxCfgQ9TsbeMPN47yQAUX8e26VkV+k1BRcu11aIt?=
 =?us-ascii?Q?C1juXrI709hCtgvs1oSsLQe0nEux1opgbEGZfDCNVqGrEUkUbekCDjfG3oQ4?=
 =?us-ascii?Q?Qh+vcwXrM57EJqPDmzgUMQQ1lKyEwgtogHxwO+vuNyL+DHHxPJgeVdieP8Wi?=
 =?us-ascii?Q?08QTwU64VVIldZgz3UeaHJ6OJic/TQOCfJtq3LfLhQgk+/YclRwBBpGb7ckJ?=
 =?us-ascii?Q?jOLlH/OvbuS6i5TCMuZlDzOPeYTwKQeZ6DIKmUJRfRlrqGljGK6jP3kFHWwo?=
 =?us-ascii?Q?2tYhldKAzDoRXLIyJEi3kp/1LDcHqCD7/DrPj1StpB1+DFy5dccNd0yMUp1w?=
 =?us-ascii?Q?bL3p29pejxsBYzEAGBqFOSI8AccNkp98/hrY7iytk0JnRrT2DgrVebYg8xap?=
 =?us-ascii?Q?42CDJaeH2uxteHy0J7sz+YAOjLD+YOovsDftqzr3ZcaTRAiDGu//HeA3/oMV?=
 =?us-ascii?Q?Z4LDzAoxoAFhGN9W6O1mCLs9+v2qgrYq4cvf5QrVscTzj92HcuJWLye/GAeY?=
 =?us-ascii?Q?X3HtPYq4sx/D0s/RcHLutCbN0pMgqJnB/pj0L9hSe9RZHgjGvNZfIoTaPwd5?=
 =?us-ascii?Q?rthObiR3DCSdBjr/IkMRfBON+/ZgwqtxBCj4+ABuZVRKNUHXGWVl2rCbVU9H?=
 =?us-ascii?Q?oeaaFXjiy10Z2zDrzVR+6mkAtvGjoloZHxUhNz1gw6HxWImtG6Og4H/z8xXN?=
 =?us-ascii?Q?z3slmBRiO1jqY26PMBGehQKpAZtHARXSzXIG7/s6F0YCC7EkJp7XEgfAS5BZ?=
 =?us-ascii?Q?iMnsSUp9u9JbmexR77u2Q0wOJ7pD8iO7QT6sPvqYM/pFjqc3pHcDv6maeC6A?=
 =?us-ascii?Q?LyNKBi2eSztutotyU5RrftxzbH0CcG1mW6LnHEI8ild8ogmI+9vpVwJKHEei?=
 =?us-ascii?Q?x0jNKs1FH3xYFkhBwK+TVhC4mrUk03a1rZcOVt5JGC8BNXwfqxdxjOd/saOe?=
 =?us-ascii?Q?Gkgurklo7GcAF0aAvZe/LLbiTSk8ANfVvjvO1xQ0DaPt/DNNXSRWK60KBZ9q?=
 =?us-ascii?Q?USolKuxL94X8xf1a/GdqU42SoqPPXYXjWQxRIQ8YobTt/+1e+MniGLSIj2Tk?=
 =?us-ascii?Q?66snLh3eyzcQDmWmyowCMfyz3192SX1HCkz9b1M+/vEZE0Kc9TmnTFUyW4rE?=
 =?us-ascii?Q?vrUe9JRwCEs0CvvpG5W2gpJN3vUGDDAuVdxqNvIQ1LAFNAgn7hUBzMbhKmv0?=
 =?us-ascii?Q?yvNjKON68EY1insAQjKK3bWeMmxL0GzFWJoP4rxiVatR4dxCH5G2asBg8FNM?=
 =?us-ascii?Q?F7bzeHra5rigWb7fxFVGxt0Z6MVh3YV1lZQCl/m6xRboF3m4yHRklQ4WM62b?=
 =?us-ascii?Q?LGWsKzalNxwT5AeYc16My6c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA7D7CBB6EE78C4EBD5DB947B1CCD6B8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tGZgmMXN76z6fjLgqRrsbeomEgzBt3HRWrBJCKtmT4BS1XeEFBHf7TXvr+dsMTLrfKcGj4OSwihH7U7zqPwYqPfznWubTXXC0kLQCaMVIH0jw1EE9Qi1gYGJNF0pf/ZExplFZHiGeofV1Wnk2+rZgr0hGxIJseGXd4zZRyGQryVJi8XIUWuIwoTIbgQ/vChHfH8T7S3fUflz9bpk91pDv+xsaLaEC3IVer0aPQn0nGsV/MEpyQFZOqMIBeBwaAfMf0Q3G1Zo3t/GnROWLHTjiHHEkTtoLzozQx5RWzEvTjpJBWgRPrC1PP9ITQcNpoZ1+5Pxa0bcVLRvE9624nRhNa0VJ0Iwi0yakXq/Zt1NV9rZY5Rf0h5uRfNgzBcKJWdndQSUKgnvLz/lkYzHLTcvSOT5igCe7LbBJWtluxtubLGE05IGLnkw1DWScx8rMyydd8wjNo/oyJXIh0yovSLq1kLJKOfHy5FLBEm9aItZnJlmhSZfvsAluXWbb04oAzjxl2LdhQDHVZJ/NXmB6B3wVh8J2x8g4X5235rS84E0KNYsagK4wOBCRz6CxMgFZV0HqogaM8QQiSolOkUTFX1SLEz/9Lp58oqULAFIZfY9/UeI8mjQg3ZDRBBPyCoEVLRC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a83804-522b-422b-0c2f-08dc8c307fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:11:51.1008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iQ3cy5DW40eoWmKa0eHYiK+QF+yY4V9UQXLWBoGjRYSFODLMMrJ78bZW2OQ8VhE+APZ8QHQ70hvSPen4szFdt4mUq6pj/5+WBqgqQdiK7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6678

On Jun 12, 2024 / 13:04, Daniel Wagner wrote:
> This tests is exercising the target code and not so much the host side.

s/tests/test/

> The problem with nvme/030 is that it depends on interface to interact
> with the target which is not covered by the standard. Thus we can't
> run it against a real target. Just skip it when we run against a
> real target.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/030 | 1 +
>  tests/nvme/rc  | 8 ++++++++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/tests/nvme/030 b/tests/nvme/030
> index b1ed8bc20908..672487734332 100755
> --- a/tests/nvme/030
> +++ b/tests/nvme/030
> @@ -13,6 +13,7 @@ requires() {
>  	_nvme_requires
>  	_have_loop
>  	_require_nvme_trtype_is_fabrics
> +	_require_kernel_target

The function name sounds generic too much for me. How about
_require_kernel_nvme_target? (The current name reminds me SCSI target).

>  }
> =20
>  set_conditions() {
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index aaa64453fe16..4a2d107bd532 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -219,6 +219,14 @@ _require_kernel_nvme_fabrics_feature() {
>  	return 0
>  }
> =20
> +_require_kernel_target() {
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		SKIP_REASONS+=3D("Linux kernel soft target not available")
> +		return 1;
> +	fi
> +	return 0
> +}
> +
>  _test_dev_nvme_ctrl() {
>  	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
>  }
> --=20
> 2.45.2
> =
