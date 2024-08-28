Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB10F1448E6
	for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829940; cv=fail; b=mC8PIou+Q+x6raRGAVQrdvoWSUgRXlDpnCfWbpQR/3+FfRpx6cbO1uSjQ9c5/ItAtg+bbv6FpRMjJPjMNH0egfvjS6avtj5gxNFrte6z79K2Ze9VNN9BY1HO9dj8PMpDC+mzPi9+W99KVX2QbUIV8N+sjRKf1S4C6xMQV2NmpTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829940; c=relaxed/simple;
	bh=9Trxq6Gd9Q2A8tnm+KKhI7LGjjYbNm222rKUElwZpmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TrF/LogmgTtFUnLUky3AHMVXxXVIENmnp6IqSNzMV0aci5wDCm7FZy+Bluk9cQk5eUxXCqxrZmupOymHsg27E9xGEfqtTVCtpwm2VJ90HeVyFW4PmxQU3KIZXiK0bsDtuaBCO5adNUoqUghGWwnmBGm/ZFZ7Vh2wkJJB5l1eqYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WuqjoY/A; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eGc/Ab0V; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WuqjoY/A";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eGc/Ab0V"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724829939; x=1756365939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9Trxq6Gd9Q2A8tnm+KKhI7LGjjYbNm222rKUElwZpmw=;
  b=WuqjoY/Axn5BuM57abdmNXY3FrkaACLxfopUSoHuYF9zm5oL/A1IFqro
   Ppe7c+oVt7YB0tXPFLbQASnrHwrcwciRP4E0dIkgruKcotu18Gq7TLVGC
   4o9kAVFMYWVTs0RcYtlxJfNw0A/VMW4oprjc/AVWPc3/6F0EimbgwCCf/
   QU6AIfvELR9T7VoCcdIVMt5aPkRusFsL7Y4bfkSpG7q3o7B189AT1YnlM
   l3z4OEOJF0v7vRNLsG0DsUxqIoLJzOGum9nTOmhIjSFcHBri67nSgaosC
   4iKd2beJdAvTwZTUlhVqc+pTEnhftdaFg+t8ICsC1KjoFCmvSDbv0VjMr
   g==;
X-CSE-ConnectionGUID: FICf2wZYRZScg1DHe+JlWA==
X-CSE-MsgGUID: nPYFgMa0Ttea2oqfQBdx5w==
X-IronPort-AV: E=Sophos;i="6.10,182,1719849600"; 
   d="scan'208";a="25346921"
Received: from mail-northcentralusazlp17010003.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.3])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2024 15:25:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOypY1fFf2WKVolxoLWtHaBJM02/ZJkMEJyNOtVyKZ2wNWgWJkyj+Fn6T9H8XN9Ns3jYOuZRGIskBSShy+XCIP5++Uhm5uUOGZ/g7lKxNt/lLIi6hml/EgJawjoz9vZZ4P/6rPxYmAQ8ZkCk7q2ZcD2v2u9WBi2evaoFc1l/M44CD999sXpqD6Zivh8Z5pSNjBc3MtSxnTg4Tam0mi0/gr7VguH9VjjhW1y7uIVPosFy5QL4alg7csipfAEFaNwaLIVb/BsUD4z2jCMeZ+A16kNt2CGnbGYX0um6ZEhKjmZyA/CBQp83MVzv05EYEpuwIiny07FwL7lweS6fyUUGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PwuRmoXpjgG81Qq3E+Y7rQMJMk4h/ETAVPLZYifx1U=;
 b=zKx1C9Bdi9phh2lQcEIUS5xcBqm9uVe72utfYUROxS93cRK3j6PvIa2U7Bl5uLJ6grtHm6MiICQLsrQPzgKRBqlgi57D8wnsboHIwvXHvByMAyMvpYzM5SteU6aARO7t0z8e8Jn0rBIQSXfPLJv77U9is9JGGF0x0LjQr+dnniW/0w1w/Wnr/PvQEUDrwedRxvMVSgfrnZsgvHkOx9jHZGZyltR3NipokemgRQ8PnY0+zeGYsPk9yI41xWaQha7i3AmdNWu31TDB1mLAuJlmrpccH0t4K5TsDEmJ9XEhXj1bcgXjncvHprsPcDCcD+KmcLDjxisvderLbwHw+bG4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PwuRmoXpjgG81Qq3E+Y7rQMJMk4h/ETAVPLZYifx1U=;
 b=eGc/Ab0VCS7pH/31rzM8hetLOdgRjPGagHU8CHVI4PpAdvzFdfpbmS/rci8cvkziL8Bi1ISqVu1HrO/meivyGaBgLONNtf2WNOZVrw+XNvkNSaY+AL+c90qaJ745AbBDRqpIBfwgz1vKMGU7SmLH6i6lX/wzuN4P0oTlDWj1ULU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6966.namprd04.prod.outlook.com (2603:10b6:610:95::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.27; Wed, 28 Aug 2024 07:25:35 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 07:25:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: hch <hch@lst.de>
CC: John Garry <john.g.garry@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, Damien Le Moal
	<Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
Thread-Topic: [PATCH v2 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
Thread-Index: AQHa+Rof8iMZmiM1k0OquITGJPS747I8QnqAgAACQgA=
Date: Wed, 28 Aug 2024 07:25:35 +0000
Message-ID: <2nc7wgdzk6lmltftletcflq42twpwgpspb7axwiuk5ramugie6@6nz262uhkvfd>
References: <20240815163228.216051-1-john.g.garry@oracle.com>
 <20240815163228.216051-2-john.g.garry@oracle.com>
 <jxozlplk5fforzhc5hgmanqszw7pb7kuxbo2f23e5xtu3yozdy@tneiyvantisq>
 <20240828071729.GA1653@lst.de>
In-Reply-To: <20240828071729.GA1653@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6966:EE_
x-ms-office365-filtering-correlation-id: ff1054a8-c873-4519-4218-08dcc7329b8f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fp8iWyLsN5NuyKiSw3WgXP7KIHAOX822dOvg0AoCKOyf3s8MOOuaIT4IuPJ1?=
 =?us-ascii?Q?5osszLURu7hGLBVXIN1T5Beibh4pAeplM3volXAyyE5OiMjvxtbAA8N5je+a?=
 =?us-ascii?Q?gBM8EF0tj/N8pcJp1y0o44FaBz2Bck4Mg7FBo09bzQ+MyYEJzczxLH3HAs5A?=
 =?us-ascii?Q?vh25mzISH3ShiY4WgC9/dn5rPQUZXmf5yQ7DEf3vO03Qm6BPVZy7EX61KcHp?=
 =?us-ascii?Q?D5M7ea80WfNZU97zvTC8xVBLEHRa6f4HqpVbALvjJJDOKeJjCl1r+xx2aPdA?=
 =?us-ascii?Q?gXL34WTlJsCGToednC4aHHz5FRR9emn8+wk/BR6ddbhjQnp5VYVXmWy4Qu+G?=
 =?us-ascii?Q?0h/xMQyNLe/23dA/SIWsxmiz2md3FdvxCC7gDgf9UdMZqJhY9XwJuheje47b?=
 =?us-ascii?Q?W3M5iH5qLmmGWjDfJJVcrb4oRbjL4zmRN0CeE7fbJtZ9mfTCPryfIST/R3Gi?=
 =?us-ascii?Q?H2RbiiJEOmiQ13NanGinxucP0U4jZmYikW1ihHef1plM6vyCuzY0Sd3aCL6x?=
 =?us-ascii?Q?7C1ifuEE/7eOsLPynlcpDBeVrzVKbAq4jJmJpcCCrt+Lt/I76r+3UmxuGrSV?=
 =?us-ascii?Q?tzDDj0kQAOU8k0M84hfIaw39Q8yXILdwbj6xyGNK6bXFN6h3qCI6/NskzMhI?=
 =?us-ascii?Q?gkujceuqKYKqRR1T2OOu11c86dcRy2zuLaZlYvTrDbLDggX1LYkY+Ob0W1vF?=
 =?us-ascii?Q?I38XX+0b0tOfPRYzlwZcOkncxP9mCz78gtnaIwgEfweEHAtDE9MxpyRCCXXM?=
 =?us-ascii?Q?/FuOV5ujH5Pl3+EuQWJdKZb6JCtrG5zRinkRF2lcuODdNd9GYasoLbfOzF0b?=
 =?us-ascii?Q?xvc2PtIqeqXVA1MOFpT4fX8fYKIefFVv6AzuNeW9R2PlDVBZVZy5uglAf3Hl?=
 =?us-ascii?Q?HZdiOx4MkP/9e6ynpxnMgEQWxeVobjI1u8j/Rs70y7c0CBlzjs75OmZhl5M5?=
 =?us-ascii?Q?yQzWpLI947YErUKlFo4Zc2E/tGqxF+NZgLL97XubRhXux6eJjzOWLuMuTxIy?=
 =?us-ascii?Q?qA6VRyOkca40GJg4aGEP2M/k3XW3w19AE9yd8FbiP2tOlGIBNIG89RlXPv+L?=
 =?us-ascii?Q?p4bf0tt3tlNiC5D11Pxa+CjCqjCR5/crBhIhb8o76Oi/c7pfmHnMKNK/08N4?=
 =?us-ascii?Q?HAR9/fgRFQCMaqVDxUHyNZq3ssOWcmUevRVXvlbvVkjEsoNoeLM//4DsQFk+?=
 =?us-ascii?Q?pgKjekzZhjDunEyxLQk0ZePn7ODpI4ct1zg9p7bZ//ziQN9pjpB6RJ4LSZUw?=
 =?us-ascii?Q?VOVOOkZqbT0XlVK2lqGQJQkkboEFQ8XaHCDaLBRffb+8XkWDXGmJ03O6CT9G?=
 =?us-ascii?Q?ICcyf9uU/MSCfyYPUWrrmFYRdqvVEaOnw/ckkxtbgOs11VhEDPBw3//6kRRs?=
 =?us-ascii?Q?ECJixqxY6XtPresl7+x/txN8dyB87SDnSAcZrPZNh2DKj2LnMw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oiDIvXJfRpAV/I+aUvuJ18hAShmaT715BErdbQI1/FcREeyaVneZ5u1iaS3P?=
 =?us-ascii?Q?NnQbpoP1tVnlcgAf8ie3veaoapG82HdyzMcJ2CdsykgKsRBfrD4tFwMT+gpc?=
 =?us-ascii?Q?UAmOkp7+03vDyFAKe3GNK2xFyNC0bAp4RfpprUe3rGd0/JeYwL627UWkjAml?=
 =?us-ascii?Q?a2kwr+O2pkKE40n+AaRyR/rY2aDRm4AC+2FqY1w0Kc7KnvguoaDnEvgKwunT?=
 =?us-ascii?Q?+3wwC3BuElseC06VqWE+QSkoKv50vfIDYQqo2psvFC100vS/OANqyAMkgJjU?=
 =?us-ascii?Q?5GwADVRQ8H2DXzLLq/dKf+/vYOZqwwNxF3EoUwEkK0i2Qklxo0dcuJLMiPCV?=
 =?us-ascii?Q?MmMuI8uWfv2uwjhR6I6PBx5mOeleEWITl0xlxIdgK485Jngd6tdz+SbrbD2G?=
 =?us-ascii?Q?Lis8cUz87N1gKNYgor4IRydEc4cOKgVQ1KzsAQbSA46S7wkQerlH0sdzA/MC?=
 =?us-ascii?Q?BjDzTVgQ5PxHZCGTgQXE31ghZrUd+LV9DOnWAYkDzOZPeI/QBb55F+pP8QUm?=
 =?us-ascii?Q?LaTeUSyB3efVJPO4ZKeFfIHBy9SQe7k1CCkMFnRZKKgMJ16aIGe366raiPRz?=
 =?us-ascii?Q?8qh9KYzfnjSEr/ktdAUKJsfF4dSOlIisHojt3dIbU8iH8Q8Vm2LVz1izOrXs?=
 =?us-ascii?Q?d+st1ylW0asbcVn1SnAuO2i1XJYNLlyddJleuY5TpUcnoquiaPes+QbgXeRW?=
 =?us-ascii?Q?E47vVS1sHgnUFW+4IKDZ+jBdne7IpQTiFhdUbSWtTJ4lDqkxwNKmZg94ynmp?=
 =?us-ascii?Q?CMvv4fwSofYSvPhHsoB58aJum9LOMAye/qaJfe45Ga9M0ffR6nhbqtQakCAY?=
 =?us-ascii?Q?ajs8B+kL5qWaXGM3B20ftG3eqsS28n0liWbPmRN/cIZVbR2xgNtF6iG76iZE?=
 =?us-ascii?Q?MzB3DmrN9c6L7GNrD6hIMKqyfjxR/ljzvUAKq9z8Y6GHozGSSHvojUU0Hq5E?=
 =?us-ascii?Q?g0qsUAkObebamvW8vQ/2pdXQU6mgUfGNkwZB3rNMlX+PnSeyH0Em1LDcxawc?=
 =?us-ascii?Q?TZjcT5sRXMt+ny/AjoT9U92FFXJvL1bvNFxZ/4Ap1SPQyeuJfkIVIt+EOlyL?=
 =?us-ascii?Q?RzOqd3qa+U8I03ONUUjmDIQp0Oi1+KR17zPvO7wJo8Rbq04v/10UfIRSl2yv?=
 =?us-ascii?Q?hkYDNPn1At502rFZnT+g9DAcuEA0xq3+1/4LyyJf6eVSCDExj/EM/51G/CO+?=
 =?us-ascii?Q?YOflbhUAc2IwR0m1qJ+phltUPYSz1vS1zi+MjBMOUEzQ8E1JUjGmCZruPFOD?=
 =?us-ascii?Q?2BlB4VVk0Fw2puA3L2xQBVjUKXXnUeutnFCkjYNQYOUAYgF077ft6xJLT7xw?=
 =?us-ascii?Q?nBziYSwMq2WVAu9TJ01ntTghW/2olYrnt/yx1wKVzRJ5GX8jorJMAb7o4rt2?=
 =?us-ascii?Q?62QKV5PlxZ/b6OefcJrymWAHpU0V2QOhXkxUi5LdnuIRCXfcv17fd6SKkHUx?=
 =?us-ascii?Q?GdF9d922sc/y/Tdql+VHpQW7nT6jsfVq7v9CfWZ1Ag1BXvf5+1zm/CZpojsI?=
 =?us-ascii?Q?KuWV/GZkXpgtqNo3ToW4VuVmgbU4A6XF7YERWmvuIY8ysfghq1jHJlXSNAip?=
 =?us-ascii?Q?gMTuqijWGN2tLVLqSK5eHue6qV3L2HWWyIJly4xnQjOKKTRMf6qxbo9yAk6f?=
 =?us-ascii?Q?RDws2zY+yffdWScmyFr/Lwo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88D6E7A40BF35C4195767B6B3D7176C0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i7ZFwF79nQ+5RwMQlnjPZAkqkDAbDIoGrFE4dvvDoNoF+C3zD5k5PUr/kHtrW346ZcdxdCeo1DP4R404a/F3D2J6R+qDjdwKaxt+5YLlXkfcqfoGqfCHn8XJmZGG3WWT1Wccp76RQNcxZe8R2W8OnGihZW8DW3bw9/ffyGQ7q+pzAg4M2E8SzCUiKo7pXyQ+AAsBtKjPoUs8z7PrSDQDxnFkgdpCAe+k7IBP3wvcRSYqHR0ow3CplzOugYW/q5swX7A1/z0Z202DN/RsfgqapiKq8MKc6Ecan43wnTC+am+TLp7tK+M3XhaEo4MfcZD1zuZ8Elgf5vfqF7wz+TLc9iM1bhxY/MQh/dWJUi9GZgKpFFpsyEF2cjw5TRurYPX5vTHKkquPvnsHNlHx9ZYoYBc9UmSfX/+RkhREhPlX6MyPAsJCZj3h1hzf8gttBliSFEkFPDO4L+3sZUnUdBUPu4QdZb0FW+waz9SrBvlqhybnEZqjVUONChf7WlVJKM5XDpz9pxPy03T81CMC8CIkVw+as26Mdp1i3bujYRs99q129H6gz/zgynioW4wqSBnt6X+b2FHtM8cBu6CzVwK3BzgryC1Ga3Og3kne7s9K4OehfKT45ensS0qiWN2JEND+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1054a8-c873-4519-4218-08dcc7329b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 07:25:35.1318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXqYSu3y0KDuMD5ELvMHWtYT4NH++JWEe0DERTXiliV8zcsFXPxVE+3IblSRuwBC92IpDG+N6L9cD+HRiOQWFq4IfrCf5ALpVULjH6BL1XI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6966

On Aug 28, 2024 / 09:17, hch wrote:
> On Wed, Aug 28, 2024 at 07:15:55AM +0000, Shinichiro Kawasaki wrote:
> > I ran may test set for the kernel v6.11-rc5 and found that this commit =
triggers
> > an error. When I set up xfs with a dm-zoned device on a TCMU zoned devi=
ce and
> > filled the filesystem, the kernel reported this error message:
> >=20
> >   device-mapper: zoned reclaim: (sdg): Align zone 19 wp 0 to 32736 (wp+=
32736) blocks failed -121
> >=20
> > When dm-zoned calls blkdev_issue_zeorout(), EREMOTEIO 121 was returned,=
 then
> > the error was reported. I think a change in this commit is the cause. P=
lease
> > find my comment below.
>=20
> This patch should fix it:
>=20
> https://lore.kernel.org/linux-block/20240827175340.GB1977952@frogsfrogsfr=
ogs/

Oh I should have checked the latest linux-block posts. Anyway, good to have=
 the
fix patch. Thanks!
