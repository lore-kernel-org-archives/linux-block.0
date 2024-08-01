Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19B13E03E
	for <linux-block@vger.kernel.org>; Thu,  1 Aug 2024 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722493664; cv=fail; b=BKHAGc4qOklLoZeAgSGPudAxQotVbEPoHEcLy3YmE3xtBy+5gbJMAPKWZ0FlW3pndUrDVCQ6at2KaHq4iwcD8gZ4o3I3tPWaMM0Ih9YP0RLqFortI72CPSwovhyz5+20zr3RWZw7U70kbgBBB0Kjpq7Fn/lUaJ33TUB2RpXAgSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722493664; c=relaxed/simple;
	bh=up05xKektiQ6nEEnvxjWHBnBTQYL8e49XI4Tdd5dbD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XYDplyZrBQnOAGujhcVKVHGHdthabEQM5vXBez1yKz4X49BWvVkeNyFDgpHZgkTnQNX4p2fhcOd9WwX7Bm8d7+yHGKB+OcrZqaKB66LJKDo1pfCTvvLLGKaAHX9E1v5+br+PwgYUs1Q8DIuT0QcLqwBE7djp9Q1zdH2c9nTN7Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QcZJ0gm7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uUXHe0z0; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QcZJ0gm7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uUXHe0z0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722493661; x=1754029661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=up05xKektiQ6nEEnvxjWHBnBTQYL8e49XI4Tdd5dbD0=;
  b=QcZJ0gm7aPeR5kgiNQsI1IIlARV/+idIomrNdsTxJdhd6NVjVMFAQprm
   JHwcOXo058T4P2FC2qihv+QHg0uiB2WmQFYP+iNDHD+rFs0i+FfRsDLE3
   eK3GgBiaGf2WkxOuPP1bx6UfGQ2pcTnkFp6cju9OGdVinyKcZTm72DcL8
   zevqxGzbOF8HZyoEYowHHhgMJFhqM3p6ut+x++3I1gW6F08A1isRT/R0+
   2BK6s7d7yWjiDfIth2u65s7LZ8ouoqOecFVjzoUwIBBqhteqCterLlBzX
   jWkxXc0Edo6tgxzIwK/CDoznJpmqG6KuewU52WuXzd/6WstoS436xr3iW
   w==;
X-CSE-ConnectionGUID: 29ea7Vp5SKaQt8LkjqwUOQ==
X-CSE-MsgGUID: HSF1Wo4ZTHuZ3OkdY1wqoQ==
X-IronPort-AV: E=Sophos;i="6.09,253,1716220800"; 
   d="scan'208";a="23905279"
Received: from mail-westusazlp17010002.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.2])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2024 14:27:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUbEUCDySa/UwhguWOVfzRy0RcAUVeB5Zql9Nr9EHTUsYI2YwpDjpu0Z46sH8FVPLSOQAh1cQkt5BphzQXxYwvAB5boTNrQBJs+QXb0b/OZ0A/NP12Yc18/wKu3dhGUUmb0pj96yfyJQ3fCq87rk071upKq6ZtBADSn7L2jU99/i6CoQLf8w7h7PSpZIkjX4kujPz4rjqqKruP+2yrK0BavVtBPwkXWCjC2KJv2c7rYby8eJzWDi0YunRRFY6mkPSC2OmBeR1jWK8l2nbEpjveYTzlVLrZbcTio7b5qjHadgix2PwqWAN9M1zUzcfFOouwWEC5J8EwENhkEW4GVKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH+X0exkQPt/6AuMC/c6hNRhyKmPTQTio3e0nQtEKVo=;
 b=C3u9OaMbpo+nfuo/SlZjloVEjPKYhQ0iyEbONLjEjI+NBSIEWfqHuKPbF3EOD+XIMmWyps2qlCrlBOjohz1xViaekTnzveAxGRifzBOxNpwtjgnJ2naWXeUhMr9qDikmDqc6KsqxDidHbhtgYgpHtnzSowu4l9pzhZFmZxayW0sVI696sL5oRalAwq1Zt5e3RoZ1RKI6bR0rsfidJK9vJu15HNfPBr1NdGz8DQdnQarmocM+LvOhxc7xIMXN4jijIEiiPLKqqip/JXCIcjYnP8qFa2vhtf0Y0Dk0LH06Y0GgOOB/3ry5rm0N2rQ9goQorVzQqLg7ouKYhS1IhCcmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH+X0exkQPt/6AuMC/c6hNRhyKmPTQTio3e0nQtEKVo=;
 b=uUXHe0z0EnH4PFdvifJw10aWiz3ir7F798jt7oWYDC2f3ScKAMYQTeNVQfw/wjfb9iioD7jxNF+TAumOA+1KGlHL1FpbsrXDc/v2w2yXNWhScsyQCMKFilUIZ8tm02d1k+nGksu0ASZodTkFMtVM5DGdSK1i5y+d44bzjNTLFK0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA0PR04MB8891.namprd04.prod.outlook.com (2603:10b6:208:48a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 06:27:30 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7828.023; Thu, 1 Aug 2024
 06:27:29 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: Cyril Hrubis <chrubis@suse.cz>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCH blktests] loop/011: skip if running on kernel older than
 v6.10
Thread-Topic: [PATCH blktests] loop/011: skip if running on kernel older than
 v6.10
Thread-Index:
 AQHa4ztkti07JU5pQUS56LiY8/ivu7IQsYkAgAAK2ICAAAsYgIAAAUgAgAAUewCAARQQAA==
Date: Thu, 1 Aug 2024 06:27:29 +0000
Message-ID: <4dhpiheoz4qjgg3zq67tjnkpx36hop2gpsnd5rublsht7zegyh@nw3mtu3zl54n>
References: <20240731111804.1161524-1-nilay@linux.ibm.com>
 <ZqoelLy4Wp33YAGD@yuki>
 <yuz6jvqbsctjhm47fpftvfpgea3x4sbji6kdmk47e5s6hz63ig@gvbiphrvl7wk>
 <914eec96-eb46-4cf1-9cbd-0e1f98059d1b@linux.ibm.com> <ZqoyDjCpaXPaU1uN@yuki>
 <55ff37a5-a6fd-4f73-affc-d432a31a8bd0@linux.ibm.com>
In-Reply-To: <55ff37a5-a6fd-4f73-affc-d432a31a8bd0@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA0PR04MB8891:EE_
x-ms-office365-filtering-correlation-id: 25a305bd-040e-4a5c-d37f-08dcb1f304b5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+vPAIT6ZPOBHd2pRdgHnQNQ4CVqG5m69Fc7N0x+MIbnQG3gLo4tYKJ+/fzMc?=
 =?us-ascii?Q?beaZJHW1Io0xOt4NYhNXwAoeX2w99N+i4jmianluKi35WUvQuJZEncsI140N?=
 =?us-ascii?Q?FQuZ9pWAWR4H1uGEreUfIS2/TapNb/sG8KLnU+Q781dOF8sLG0uhOmcmS3NB?=
 =?us-ascii?Q?Rbno7t9p0XmbSWG1eZgWI9km8DRZfP6qbCRo8hgywuSIuOwt3umNav9LR3t0?=
 =?us-ascii?Q?A9tXz4vzHHpYW+vrKEcaPQoWtIWjjpdw9lGfp/eFrKhyWED0PZn0hmrDpwqU?=
 =?us-ascii?Q?5kUQenngNmP03MV+b2fHTapQYMz0ad42LIryDePwkvzTd0T40O6GnjKnnpCP?=
 =?us-ascii?Q?sHgLEP4XUM7BSjq9sjxpf/xYQletSPEmeNoJPYyEfbDIRszbXW2VVyjCO/vD?=
 =?us-ascii?Q?WRhVwGjRFaj2a65JYepfTqWY4AxzJ8QCRhzmXSeDys302iUD3jSnCTqG6+Jh?=
 =?us-ascii?Q?JDmmbhSodMvh0hO1IorER//a7LZLRd4QwVsOwV4F2YJZWKlJrlcMxteAKn6A?=
 =?us-ascii?Q?5Wti5oa2DkGvs6QP/8dBGb5B90Lgso86Oj+o+beA0fBdVLPMtqTShCK13lqF?=
 =?us-ascii?Q?b3ZIW1ZrsLwas+gB53INNY7ilYwyn8jNUxZFl6T6qQv267PuOXRUhEcuAT0y?=
 =?us-ascii?Q?KvZ/rXUR6SCetzBgd9OLKAfNtd3NyxTLn1VvrSVfqxcHuXWBovcFEAneDKXX?=
 =?us-ascii?Q?H0QoNWsjPQMVJcWs36/US5XSbOQHOIi4WCkoaR9fdPcMB66e9JZnovWm9a4K?=
 =?us-ascii?Q?aaXAWYeVJ6eiN5r/iLvpHHK8ZbXEH/gcLIbgGrrA/0W6p6iUB1sAG5EZJJL6?=
 =?us-ascii?Q?UGFALOlwROwFjETAw59MNFCtDX6+fWVeCQHNBLV10U/FveR1ixyOP095t4AE?=
 =?us-ascii?Q?hzG/JUyj5HtNXnoU8LqmMFZOW9PnRh5GpiDtl7tdb+uNCTDLr7iORwY9iD2c?=
 =?us-ascii?Q?2HoYK3aQpPKqenHtnCdZmCHTUZl2aOAuFM3s2JPMdrwcGaxBP9BWBA+xBK+U?=
 =?us-ascii?Q?dAKFUlT3i2i3hsxLnC/YDoPB+PSocIgfw68wj4OrmcygPCpwLPwVNetxcbiv?=
 =?us-ascii?Q?Fr0+lMkW+05J+CsfovRUIWZPVDpLUfKT/S7QzklceZItSKu79axnpUWWImEc?=
 =?us-ascii?Q?GH4sS379xUSkoiF06G6VtV7oqdVynW+BvG+UoixxoPMcPK4/MPCKV2/x+r8o?=
 =?us-ascii?Q?McRPTSYKI6U5LGB6IGZKOG8+CZsrRKdonRDFXPawiimUX0NLJiA/1lZ4VDoA?=
 =?us-ascii?Q?xxZGBKNtWywBEgxYFYlaYoqBZq3aNGTwgIADQQRvTWc40C8f3CJtQubWFM+/?=
 =?us-ascii?Q?Bj0cOe68r2IB2sQKI6l/mWN59dtSMNWXOdF9nJbA8ajmGYr5nz3Glpde5k6d?=
 =?us-ascii?Q?lBdYt5g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q7DRqDcYKGwPHcrTJT2KpxTyFdrJg0pq9p0mZKpHvMNIXJ2wl3eLlHeOzBP5?=
 =?us-ascii?Q?GTzUZfYIzYx39bq0FUgUj+Ie8vk8p8AlObFw/MBHoziMNLsOVQ6NpqIFKAdE?=
 =?us-ascii?Q?z9n+bSeebMn990Kx0z4CbwROV8LiHgPNgafsYnSPiAoPXKr60JPqTjCRJECu?=
 =?us-ascii?Q?0i1uH/ZnHEFIyrVmuj70bjXk0FIeO/imlaoEgoSlf1he2Ba9bVT+YoXgkoKS?=
 =?us-ascii?Q?k3y3h1Vwg7ZRf9+tEfWctGAEMj4iSwyya5vpB0/G83a8MuHfIalOovmC3mrB?=
 =?us-ascii?Q?OkiFa7l2+hJwDGSREimK42HVIATuCVgLq8PXdLIf9/4bCb+JS6psyPek+y60?=
 =?us-ascii?Q?25kDG/RZnYp+CK0/pBgt3k4bIIfXn0wLB/wAKuNODL/PqnXXSIC8ZP2X5Ss+?=
 =?us-ascii?Q?xq4kVx4zu8V4sG6vBHNM63VGK0CCxaCnCVtRyz/UZUVPaA8fjyXd1IwLCZtb?=
 =?us-ascii?Q?ZhcSBNSqoFhj6v7LTFBp+a7hmbQ+uptrcjTJtCAMe5+a9MDovDOzXGB4culo?=
 =?us-ascii?Q?SCzSFdcRCkk0xM7hIYRKLI/L+qogl67TjlRozEIuF0wJmJ5tdmQZ/ZHrC+pF?=
 =?us-ascii?Q?APqgie8ApSjBFxJc5za3z5q64uCB9cPSWTRC+I5MJq7fBFzPpchAQGV6Zmky?=
 =?us-ascii?Q?0OhM5zloELoerAlikISw9pCrdBvzISz+rDZ6Akx4/hhu0j+iojUEJXrKYHmH?=
 =?us-ascii?Q?yLjllZpbicd6kxHhpBmIHGEHMDsz1/LTAneKmcWy1lTzepbre+k3BUp841CU?=
 =?us-ascii?Q?I9/K2cDtTyXAXFGFawG/Y2KS+AFBp5SFNEU+WYiWIzYDlQrTcivBFQpXi1My?=
 =?us-ascii?Q?5Y4FwQGA8/V+q5qGbuACzxARk5IAc6cJsoBFxexzRc7oZhhZ2jMqV4idvY5Z?=
 =?us-ascii?Q?FnILJl/3+672a3NVMARob2aTF3dg9wt7mYijwwHwwQ18pc83lv1AkxVpx/N9?=
 =?us-ascii?Q?W6h21WbrTpP/bQiOgYvai8B9aRrk1inIJDfsUhU6TVlM3cum13m4cRqtt3SH?=
 =?us-ascii?Q?LzZqJFXUU5GajgACMuTNN7WSFzHpFkdiaFCn8xbJ6kNUqmIYvOMionmRi4sq?=
 =?us-ascii?Q?cX+Z4z+FuqSD/bOaYmY4nem4jVUgkUy8o7RpBj5y0a4pqhmp46x9/5WfRyK9?=
 =?us-ascii?Q?ENH3WZfP4uUyhnCFmqaotiRcFUtJPjGkBUnqinY8GtE/V8DbJ2vioIfaWCvY?=
 =?us-ascii?Q?iOJ+mTdP3dYgnfuY2rpRMH3lR5vxH18ghpn4xRKxJQ3wjnDwRmrLZkaMUnzJ?=
 =?us-ascii?Q?zV0HgNeahCqPXrqxHMEAe61tWUyGwKJfNveGBkIREMxJ6VSX6nmqAjEZOUsR?=
 =?us-ascii?Q?pd1ojqZmUEb5KnXJseZoI+xqAJAF2QooMXnla3264aeYLZ0eS/C1X9U/MTyi?=
 =?us-ascii?Q?doP+XTsYwoEyOqiJ5s/JMc8ygu+lBgZVohqzTK/rksBba80IOCPq7U/qmqV3?=
 =?us-ascii?Q?z5nwvJLcdP/6c8n6o3D/xs53hwYePz5c09kXNXnzzugN+l1hGQEddN5TEC2u?=
 =?us-ascii?Q?DPzrLPJbTH7dPK7lpE9VHU2b7YcgGv1Qn8iLHZhRfb6UzzyjUeoC7qabMMJc?=
 =?us-ascii?Q?B9GBhdmHjtticPIh23A6RLGuG1T85ubd3v4dpLJokvCY4BlBvdTHg6K3L3Gy?=
 =?us-ascii?Q?11rfQDRzyu/TQ0218WG3w3A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D87B1D2865C3F045B07A41CE804CA092@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YIW+CkdqwIb2GFTobdWGKyK2eKe+uMPZQmtRlP9KsJEjgEQaX1mEPsSF+7URhoalVu2Vm/ncdFss3mX0Iiv/Q8nN026UT+5+9ipS2G5el+vc1USEUeuOAk8R3+wdzDEjY8BUmRWZo1HDH7deTGW0mKY5lWphsie20KlrkCSS/crkoTyEqjDCUMp5oupx4tKLJTYT9vEvxrw6/pI7RXhjXgtPQ7g/uz1TiRoSes86GuhY3yprLCGZJe4O9rbTs5oy2bkbANiONiiOQbxlVY/BeuzWz8pDNXC++Bzfk5U3jkDu5gyLArCVt+Ycp6sejyK23Rz8LK2jhx9o2BsK2RMTw2brcWed7g1BOXI/qJWOtqxTjbH5tJogdKWXHTMSov/hX5/UBpgaoXvLG0kUqvaDoKV9Jpd3PdQy/CzucfDlAgae0bykMrSn15Yr1XfI0B1zIt5LBCWS36dLE2+aFUSDSIlBIW4QOxygKQcl/1lsw1CZVgqAdfLckqhJqX7fVhcoEAgqfO+NH4hXOGIkOexFtJIR/Eu+uMrHKl/iUHNm3gt2O6+raYpLE9IkiZlAiPQV2fchw1dUSBcXkQkJ28beMRSNY4i4JGABb9/zSlLteC7lPtExGdSgUz+Xw/FDxDxL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a305bd-040e-4a5c-d37f-08dcb1f304b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 06:27:29.3442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FyC5gBr6/GoVFIe9VQr8SU7Aa+8K5W75kYj/j94Gvy41+8O3Up+GDL4Ic9bwZ3rp1BAChe6JITeEexkxWn4aXYDzSM6YDjsHQereUU+zgbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8891

On Jul 31, 2024 / 19:29, Nilay Shroff wrote:
> Hi Shinichiro,
>=20
> On 7/31/24 18:16, Cyril Hrubis wrote:
> > Hi!
> >>> According to www.kernel.org, the 6.9 stable branch is already EOL. Is=
 it planned
> >>> to backport the kernel fix to other longterm branches?
> >> I just checked this commit 5f75e081ab5c ("loop: Disable fallocate() ze=
ro and discard
> >> if not supported") hasn't been backported to any of the longterm stabl=
e kernel yet.
> >> However I don't know if there's any plan to backport it on longterm st=
able kernel.
> >=20
> > The patch will not apply into older branches since the in kernel API di=
d
> > change, so I suppose that nobody will invest into rewriting the patch
> > since it's mostly cosmetic.
> >=20
>=20
> This commit 5f75e081ab5c has been backported to kernel v6.9.11 and per th=
e above=20
> comment from Cyril, this commit shall not be backported further to any ot=
her longterm=20
> kernel.
>=20
> So is it reasonable to assume that this test would fail on kernel older t=
han v6.9.11?

I have the same guess.

> And if this is true then how about rewriting the patch as below ?
>=20
> diff --git a/tests/loop/011 b/tests/loop/011
> index 35eb39b..a454848 100755
> --- a/tests/loop/011
> +++ b/tests/loop/011
> @@ -9,6 +9,7 @@
>  DESCRIPTION=3D"Make sure unsupported backing file fallocate does not fil=
l dmesg with errors"
> =20
>  requires() {
> +       _have_kver 6 9 11
>         _have_program mkfs.ext2
>  }

I think this change is reasonable. Would you repost the patch?=
