Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4A7335567
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392630; cv=fail; b=ez8Inp1Vgl7QZ2jkE6kcA4phiZtUB2k0pMWBtsq3uMpGU/DwlKLgo4VZdgy1DwXy07dBpEfOEdKDAjJwtqp8BQAbZoybMMaiHYW57s8IVTCqdQw3MaaPztp6hULOwOjv/Q6qnP/QyLXKvVCTzJmg4vCs4c6+/9D7VeiXoTheuZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392630; c=relaxed/simple;
	bh=mDyEtZxJfXlWxnCinI1DnIqdBks2jwVM7eoZrDIxxvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BGCH6zO/L37HBEtLsn/0S7/tSy10ZX5lXP/nqJM8rPSvzhVnlGgYbY5fZYGpj3qePm4JYrLBGYpZmnK+uEkkEs7sP21hTIY5qTJU5nJXX5/NeaX1RtWOQ+X3I0H4vhkFvNNSjRxQss/Fg2rBk+R8v+hxWUTwuWKRwHApYaM123o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=A1Zg6qTR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QlciyE1/; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A1Zg6qTR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QlciyE1/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768392628; x=1799928628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mDyEtZxJfXlWxnCinI1DnIqdBks2jwVM7eoZrDIxxvc=;
  b=A1Zg6qTRP2UYsZSSSCbqbXnuRJnXJUySxrKQLxsiRf4TpQhrgxIsGT2Y
   eyqAMKq0yEiIKXm+uMamvS5FLs/p0RheEMJJGKQTpD6Dwzq6P/PZRlPyD
   8uFtJeBHIEu79odBLdOjKLt0nh269MBXv7chduWX1iS75AlRhdtsbAJYB
   UKyDefYOpZtWXEnYTuDKVadPKLRE1/cD76tS0l2ogW34vtoXR+I4uabjn
   bFAbH1BaK979awY5+GdFy6rl34hOtnwqJVsQBcmVNIdo91GaNr4huth4W
   TuaipiIP82lJ3opkmhn7CjcZ7Urvl7sCtkQyhIIY1pVEWLu56IIpiAUBr
   Q==;
X-CSE-ConnectionGUID: 33CaRnCKQL2/d4rMq7jNYw==
X-CSE-MsgGUID: Z5E+6X5oQOWNdEWZS9GF5A==
X-IronPort-AV: E=Sophos;i="6.21,225,1763395200"; 
   d="scan'208";a="138541149"
Received: from mail-westus2azon11010042.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.42])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2026 20:10:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CS00iZh2cNiT+MyOZZqkpR9RVf75sEoc/JtsnHQ5ACxVOWqOZr+p3sBEbGzqswnjsEVO1CW6VHSUU/ZmI2YuesfAM6SGsr3e5TRKELFqPC8JfNZKUHm3hK8dWvPyCIs//+HF1dMj02XledXpLJzZZeE+zqoGiCvNXpC3SX6ENVi8DHGTLzVupwmZomURokny+E5dpcFpkR43BH1xglYcfDwACXQNQLZXJKRJ5e6bIr7JWJ5JwpBXyqiw/H0Fgm/hNDdGsn1NYzQk6GPNAp1N9vCHbzEIJPR+nAMH3mALZ2fk9uDAk+rLYj6CM2YnpM7zXZ/KT0MStv9ugwTS9LVUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UwfQFm7L1NK6zdpZeIxTlY28s+kl0HlfvzM5YcCOCM=;
 b=ctBEC2wG9ZXNUTQsgq4xVSv3Q7NWnRwqmbF8w+CBZdIZt0/3qCXBS6r3fkarxVcTLskPEiH4r5JBU+EvXzLJmbquy9EqHaOzib9qR2G6rOWolEMpMPtlYsJc2Xuu9U/b6i6E2V3Pf6LfNAWeOGaHosa2i3QgW8xsKAEw2fE9uiBPj73rG30/fuzbomGa7fLGd0RFu6EEAIMLUrQF4JtCoPx7N2G14IiWMSfmUsRwR4F24uoASusLvYp+gexG96StHyE1YXdQToEwzjWjUoFPhEvjn+W3R6qMf0SYZB0D1Nh6Ue92fSg+nNKlXqPtCKfK4RmZH7BGMaiMOfonISUNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UwfQFm7L1NK6zdpZeIxTlY28s+kl0HlfvzM5YcCOCM=;
 b=QlciyE1/1o+ON+UfVULegYEXiYPvDLukXJwjkWrPxVhYru4tb52iWyh/6fNPRsp98oET4OZPK4oSUYl/IhkX/v2m5FrI+fVWtA+YzzJh9caz6ZM5WzVH0kW86eg316knAf7Dk/y7OIqr+ogk8SGGFSZpqpUHAu2Ovsi8faUcJ5M=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH2PR04MB6949.namprd04.prod.outlook.com (2603:10b6:610:97::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 12:10:18 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 12:10:18 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>, "sw.prabhu6@gmail.com"
	<sw.prabhu6@gmail.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests v6 1/3] check,common,srp/rc: replace module
 removal with patient module removal
Thread-Topic: [PATCH blktests v6 1/3] check,common,srp/rc: replace module
 removal with patient module removal
Thread-Index: AQHcgho9/lzG1an0Bk+6aKdYZjogVrVPTJGAgAJMuIA=
Date: Wed, 14 Jan 2026 12:10:18 +0000
Message-ID: <aWeHiRQ4vkbS_0kE@shinmob>
References: <20260110101642.174133-1-shinichiro.kawasaki@wdc.com>
 <20260110101642.174133-2-shinichiro.kawasaki@wdc.com>
 <777aecd9-4978-450f-8688-74f85e24c372@acm.org>
In-Reply-To: <777aecd9-4978-450f-8688-74f85e24c372@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CH2PR04MB6949:EE_
x-ms-office365-filtering-correlation-id: bc8e3fb3-118e-444d-c478-08de5365e213
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AQFTpSDcOGWEPQCoSEOU1ekeT+3SYEZB1TvIyeelQyPm0H5mRq1dqfkXHqn0?=
 =?us-ascii?Q?xxrYKozdAPN60pt3UqNDp2cr0GJQ7yPB1uMw636ZEjfTPot1t99ckPOFFbmE?=
 =?us-ascii?Q?5gMDrKeWBJn2e4XG03KX46Z9WG5j8swXQD7I7GlcQip032S38KtDoioKwOP9?=
 =?us-ascii?Q?z/ywot5TBq22TEOmTYKg+rzCu5WypDFo49Z5g95mr8+8N3ZdZIKN4nzBlSlV?=
 =?us-ascii?Q?bq5ehMYQlO7xN+CsZwDVfk5pHg3a5joZpwfUONRtxwqTeNIH4HoICZz/ymG+?=
 =?us-ascii?Q?R9FPQjCZ5YZYV1/Dg95+H9WE/GTU2PWvXNdMb3OUA0HKft3vlByg2TZTdRIj?=
 =?us-ascii?Q?pOPha85j8HJbbKRyZGd2YUGrpr+V1o5TKK1nAO9iKWdeHGMQbisIRqp+1H4T?=
 =?us-ascii?Q?RwNDbnsneaTov1DcNc3Vquadzb/1hhSKg0tzetaY4Swaiy7Rq8gmaZK2Xrro?=
 =?us-ascii?Q?1ZBxw1G97W3numBjDzBSyTU4SPqlmcn3jQNWTYsDgrhJskqFQUlXTQViX3QF?=
 =?us-ascii?Q?tuTKxfpsvYxByCfaSzwL18JNd5K2aw0mJj+Fj9myQ9V12P0vukpC75trVjZu?=
 =?us-ascii?Q?9TIVVEvdxeF4S0aDwy4VQ54IYHxmqBelz55jn3OvDfwtItrLATge3/tumr7e?=
 =?us-ascii?Q?QLV3Di/NfRRUWI4JoTM/nquxWyLVnoJYc37aiompJ466aTbCDgW3V2H+fmnf?=
 =?us-ascii?Q?uyAVApDxMT15tb5RYsW0DDIjbftbbGgo5YbhRK+g0XOhK3D7ZMEoaLMwzQUf?=
 =?us-ascii?Q?atmvJTDqzEnR/Hji0F7syHuveMeSNLivpOZXV4rC3ir3jt4ByPEjU7UtXFq1?=
 =?us-ascii?Q?PQGQt8GNRZIYdTbI76zfQJ6kDJwR318klCtEtHuEDYx5uTR+DTPH5OMo9tCB?=
 =?us-ascii?Q?ZZVDGch3YfJs6FljVN0gd7lRWgmwnXmYWkBYr7i2dMAt2DHj9KLRXK3Emazi?=
 =?us-ascii?Q?9Gpw+dRoM8sG2UYD/5xeEsKd7uuBPsuwFlWUHWmY9h4zJnqox3UgGvwDJZXK?=
 =?us-ascii?Q?YI30/gjUi9stK+GUfBB2eqgs3KLWEEK/6IS74IKhkWW0BfhcF+0FQbRr5tAw?=
 =?us-ascii?Q?BBlZUCrfcd6fH36BFlQThR+YMSxRvgwO23TI+rNs0nyITUG2Z9uEFVfN7jpr?=
 =?us-ascii?Q?5yX8zCdZok/uJW6awL38EYMCC6ckqtmjyLhCiapfDk34IsXbYz8pVkJvZ0aZ?=
 =?us-ascii?Q?fZru5ehfhEMhpPNrxWKxYegecYcjixCeTzCTruKXMi9ozpCxN1xi0cSfGW6w?=
 =?us-ascii?Q?hvEJ9OM9aznDRYuBeyF1NfADk/0JcjwoEVPgg77prTlr5cuT844/4d+3+rHF?=
 =?us-ascii?Q?TA9CjegaCTYaUOPPcCkJ4IG9O0OIa3jLkdNXsvz8zD8PWjWkHGGPTFhzdNx4?=
 =?us-ascii?Q?pvTjj2+h+6FUfL7rn3wMV3M8vbZ8jmu5cW72kfcJp/HEP90ax4Jq6zoTQSsD?=
 =?us-ascii?Q?Qqxnnk6c580aoUs3TAVUQugkekAie/inwUZeP8ZLRl2haM8ax13kbzFEB9mc?=
 =?us-ascii?Q?rUCykTIHBspIfGNuAQoRpudmHIoI+9hOBKqD/nJ38ljM6j5adrsDsxyOWsDi?=
 =?us-ascii?Q?SZ+NrDFxSLKTG2StjnPxKp0suIM0VlTxESjldYxgaOAkyjcuuOZSj1ODutzZ?=
 =?us-ascii?Q?XjwW2tMOiGmyoTJG84rdvVU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c3V4Ft/iW1rIjDSdfwew9IWd7Li3OqIxN49MwCmPKEKL3oFGJkYp+ecqR/o7?=
 =?us-ascii?Q?tN0jgFfv/X4vdwu2BIYdpVfKTBWJd5zQz54ReiVWaUds85FccKBxt7mhJf3o?=
 =?us-ascii?Q?y7R3Z9zyX4ZNjue4zHUa8uyVzU71pDHOI4M0proYLRG/DMBZOYTjKiEungeT?=
 =?us-ascii?Q?BGokNG++0ZVlx0ntrtOM3JsINasfjNOM/LeRu02c/Jod87U8t0j8xgP6G6kL?=
 =?us-ascii?Q?29KNHn2czjzRMWjHGTPFYtbUyI6M0aJN6IJAPbAEDetUCaaJaV3FVv2gF8/i?=
 =?us-ascii?Q?FaeTvq0/AGuydeO6wa1cXaPVpMG/eJP1gbihpAkY3d9unUJKjTpqdwaXUsFX?=
 =?us-ascii?Q?oTXsQJUh4DMIECuRva5cFuaJP9ZMsc/XUV3V7lBrECl/DS1x9/yJX2LhZK8O?=
 =?us-ascii?Q?5oJIU/jzjXpxSoUHeFqc4f2YhD/ioMx5xbd0IrNNKHes9OAc6WLVXR1lVNH1?=
 =?us-ascii?Q?z9AqSulju3O85xgJKJhTCfOWhX2F+QqZXIIxiLBTVQluXAlVh4QbWieiVdmk?=
 =?us-ascii?Q?wxw/NhDDLVvYmI5Z6GZP9Yl7KYEjYPywU1x0ATp+5Bud6Gd6w1W3h8g8H3Hn?=
 =?us-ascii?Q?Yt/+KF0sQ7ERIVGfiXhS7ya0sVQ20bO4mw6HujE0N+TQAp5DMvdicBhvdaNv?=
 =?us-ascii?Q?ZlWES6rkPQ/h1An97pK4JfzE24jed22Vb8jo0V2LLxm5cULQ+qbVBXwFVQw6?=
 =?us-ascii?Q?uaybtEIetU2+/E4m7MKrcHv3PwuurCMuJBR5EzpTSuOX+nt5jlD3uSmte+jZ?=
 =?us-ascii?Q?AUbFMm5G/HmbklZ+u4X2c4Nj+FgBd4I/x/wjLRT0Y+uhE5+sDkOjBDjC8TqT?=
 =?us-ascii?Q?+OOEnLnNEqEaZ7kgjyZ9QULRshUl4nUyfrLNDY98JjW8lZRdzGJjVdfz82+5?=
 =?us-ascii?Q?JMBe8nWy6npV5yHkRVcupTX/ouUZXC7WwxcLy5/+R67lB0JAzYpRLzeu3Hj1?=
 =?us-ascii?Q?5ehuOBSes5iN4WHz31EXy3XLNn9LskNmBAI7oV4y/yCVMoJyQHHULbk8fVZA?=
 =?us-ascii?Q?j6gC9xC5zYqSEgSOqBcXIGUQuppfckl8fqEdS9DcaAbvB03EK+AYHZKnMyqQ?=
 =?us-ascii?Q?H5FP8NgjY/nOEsxm25f/sGqG9iHmmqh7D5j054uNDge8x8ltZMx9SmokGr2f?=
 =?us-ascii?Q?Ee2UHsMPy0UKxen7N0UbP/O1sVGbFSg+ahFM6R9mHQqmhP/TUm5VCMHC9f++?=
 =?us-ascii?Q?QinQhdLYC0DrTT6QaPjNhX12TVhWpzMvTAyhmUtfGAasY9QgDAC7rboxJI86?=
 =?us-ascii?Q?rak57IMvpOrpVEkHL+hu9ZPipP1SfBEqk82d1Iwo3aTaJxmNMYj03Zq3e1wX?=
 =?us-ascii?Q?gxH54mMZlGjCMLkC4m4/+4563YHObbRsrF/CrQw0x2LG3/K3J6DTay72yvX3?=
 =?us-ascii?Q?adGfhFra0cl6Tz6pVKritbdw/q/oFmUqJdbLsICHOTC1Kk/bqjv9t6/BhwBO?=
 =?us-ascii?Q?8ASDU5c0GCiubcXBW8IcxSajyJthOr4a2bmzDkX1hwJPGarFiMFSqIs+O1GS?=
 =?us-ascii?Q?1np4fne5c8H4YE7jWc7Ho2rwQrcRAV2GZhtm2c3Rd47iVPHl4l2jZZCrNx7G?=
 =?us-ascii?Q?bRs6p2jjctNRyFbqcy9fuVkMx73O2aL4BT77YICyIQWOtDzxmUVdiyTSWRQ3?=
 =?us-ascii?Q?QIzxQ+sgdy2BjPOcjWfW5zXMpk8WkI9XmCLlvT5pPqBH+v2AMwuMmLGGN5Qj?=
 =?us-ascii?Q?NXUKcYBCis38WI/Mn9Da0dpb9Mvo1RGNJj83RRAY7Tf5twhIYaVw1zixyW/5?=
 =?us-ascii?Q?KXFENoAHPj8B0JavyxUUvvaMLZHvYS0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9AFC102934B0C74993357ACC778B4D6F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lr133/Q1UJoRhTtF2fT+UBOLkTs9CLszCsisJpHdap0ya81LgDCVBSJDkROELT+0WTehXSV3YJk0fWt3E2lmN6G5mkjJpofgp8czLpBRn8DiXLXNjxP4afFvTHXeqyjYoqH/UTOhQCGyuiU+5mC19caT3BqJIeuXwql0dGcpHp8ewbkjeXVPnSXDp8cyNdENdOEQVqaRf1wu/6fx/m3gqIZMM08h7D1KeSoe+WsFaSJG/Nov2Y6z6GuO+OLEAl5CyMr9ztRanb6RrEIlXcvq1PiBbI4irW8zjSe+5+2EgEqjR7LlHsiMdRnt55fWSNBB0zcU5XxOOEP05Nv0Qtf9CodSUmyS7l26qnaPVLuDI3Eh8o3lBg6MAcmnPspnsC5MV+PUOGNgfwcQOpG9XX1dMB8ZZyYBSL2jmY90AFqkzw7N4MJmbdk1IvLrY4WbfbLUmglPaaRN+iZwbJu3/IljtYgSxxQ9fSu5xwnRteBa7rNiN3HiIkvsk/Smp1iPY1oA9+AZez+UZHBL/QNDebFemRZ5IgjiUdV4+ihnPtyew5qh+wIUUetejSvSxRxRL1si1rjSaxZd2x2xQUGT5q+yB2RrOaLZ065BsXmkSVbm9YET7ShvgHhQo8stZi7lA2sC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8e3fb3-118e-444d-c478-08de5365e213
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 12:10:18.2508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFlAD2sF+c/29sy+bngTnGX1w+pKmQ9htwiOiy388SjZ7faBemlg7QBuBxS41afOhx3/cE5iRwjWY6mt2LfrcZWqJ2AYE322zqu8z8guhLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6949

On Jan 12, 2026 / 17:03, Bart Van Assche wrote:
> On 1/10/26 2:16 AM, Shin'ichiro Kawasaki wrote:
> > diff --git a/tests/srp/rc b/tests/srp/rc
> > index 47b9546..517733f 100755
> > --- a/tests/srp/rc
> > +++ b/tests/srp/rc
> > @@ -336,14 +336,14 @@ stop_srp_ini() {
> >   	log_out
> >   	for ((i=3D40;i>=3D0;i--)); do
> >   		remove_mpath_devs || return $?
> > -		_unload_module ib_srp >/dev/null 2>&1 && break
> > +		_patient_rmmod ib_srp >/dev/null 2>&1 && break
> >   		sleep 1
> >   	done
>=20
> I don't think that this change is useful since there is a sleep statement
> just below the rmmod call. This change unnecessarily slows
> down this loop.
>=20
> >   	if [ -e /sys/module/ib_srp ]; then
> >   		echo "Error: unloading kernel module ib_srp failed"
> >   		return 1
> >   	fi
> > -	_unload_module scsi_transport_srp || return $?
> > +	_patient_rmmod scsi_transport_srp || return $?
> >   }
>=20
> This change shouldn't be necessary. Once the ib_srp kernel module
> has been unloaded, unloading scsi_transport_srp should succeed.

I see, I will drop the hunks above in the next spin. Thanks.=
