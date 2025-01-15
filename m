Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E614601C
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 01:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904428; cv=fail; b=t3t1YHWVyQTuqFWHia+PiU3KTfWyRyqcDGrFPnHbLkhpfhBYYDbrkHlE/u97R1nhaCXnVJj7cdTcwOzj+h67hnwmwuduLEnUFjuPAgXulYPvmb4KF1X507h8uDKriCFrlEhC5EZ97n20D9wqtoANf3B5MSDoMjwVN8S3zlEYVrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904428; c=relaxed/simple;
	bh=aLnB9KZq4HLam/Da8Ri0QJiFBHFV8xG8zPRyShqXJU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H67Qet3zYWR//d45N3+E/p8uufqEsQABJzBVnjPOky0EdGoDoDi8hB7XaBcYPw5En46vBAK0MLOFeCfU+ChZxI6p2D3MbI35Tda+rMOUyB2TNRQbn0ax885M9uKela1cbK4Am03kxtW9MhsyCYtGMWCpWG/tVH7DDUaNwvmsNZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cbFJbyUy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CedUrYUQ; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cbFJbyUy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CedUrYUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736904426; x=1768440426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aLnB9KZq4HLam/Da8Ri0QJiFBHFV8xG8zPRyShqXJU4=;
  b=cbFJbyUyh0fFfO16mNb8C71ACz/KhKK00UmMKnnKNBqzfNLQplMMGRYq
   54y4BaXnvc6M7RcNTFcWnvCPYneL1pbnuo9iVPmxPEtPDAe+IGR4KkxbL
   QZU0LSZM+BP/1t6meNOb/Ck2XZ0ua9VhTIuLUUSWHHbvwxdjCMlfl3AwG
   fp+ZzwETB8njqytDWSzAqBJOLekI0L0HjrXK7rTF860zbZD+uG+RSQDup
   aACepOctSDwNNOVJYePHCeWgUYLBaYB7bmWcxxlKLONmbBDlrC4mbIl90
   ZoINxjTXbJlsFdOtOzu2d+cXJfa35eIB8i+tkrFMd/WnLDKW3hSWlLIYf
   w==;
X-CSE-ConnectionGUID: +0FuHzraT+OJvtDGEjl4ng==
X-CSE-MsgGUID: SX/0g9scSjuXcZwzo9dklA==
X-IronPort-AV: E=Sophos;i="6.12,315,1728921600"; 
   d="scan'208";a="35322802"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.11])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2025 09:27:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN+wMCE9xs3XLJtFhMUNxWB7vB07v1N8kPQRVN8Wqcb/qMv2fJ3FmoxQab+9uGeoDucTfFHXaxT65Pm1amRqC2kW6eDkGfaJtJF+08fAz/iJOjvNrCG/AQvq/tBpJ2La2H2j4DSLWtP+FC4OZxHC9OfctQrb2l9pVjl97lodLb57YBim19LX4qR36e7/mw2+7j+9rytQXTOMsIP7WL5k9x1Wfy+2Ll+z2gUMYoNAZFyCsPJemNUOMIdmU/aJ/bQwtzTGMrHtP0NEN9lEbs8JKCYC4RO33i3F+wyq88YK/XVdDqvhWJSCBIDT0J4ZRSf+kyF5HE/xLc/urZdgRIQffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O9GWMXCOlwc4jZCK1RUfHeGQIgPeBFogRhD7jdakpY=;
 b=P/S+/gBQn3FdpSy5sjenLrRexu7TZ7L+dPI/0xbgyPtLw12sF7p1WB8iP4h9JYatRfUso1jVlMP125GJLSFiXy0CdK3qrUbSBfolLpBKJLLSOXHhuXkDaNp6PBKfD43FP2ghW9ajXW2hnupQRv00/zP6MrhfQEyPYqflZWg9uYBwNMTsmrP5Fjs/A1v7XNrrxmZNpllH5WBZC1UTx5pW7yTfBk/FgQndZBybJlmfYtrEOE8kw0ZFly2Oowj+ZIjqMhlzZ/DO9qKJFbW8nBs4009vj7olCFh8mRuBAeWKsYKKb2e8N3X8OmCeOGTbMIqTXvoSMDw3sJfWx3tp8UNhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O9GWMXCOlwc4jZCK1RUfHeGQIgPeBFogRhD7jdakpY=;
 b=CedUrYUQBW5M31u7Em4Ol02jOLm0tKYTB4dHOYFD8Ccuk7ClOMfQcKBHvydqg3sXtKBB53MDjB0Isxvgdufddo2LUecoe0lGXHbe5pyFeW+i1g8qVg7/m8eX3UOB38vlGsBq9kEb/mC3KClLFbQJB6tECi2OBeXenX4qPIh56mA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH3PR04MB8904.namprd04.prod.outlook.com (2603:10b6:610:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 01:27:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 01:27:04 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-next v2 1/4] null_blk: generate null_blk configfs
 features string
Thread-Topic: [PATCH for-next v2 1/4] null_blk: generate null_blk configfs
 features string
Thread-Index: AQHbX/4DycJCrX2bOkmyC8YKxcjEXrMXGSwA
Date: Wed, 15 Jan 2025 01:27:04 +0000
Message-ID: <ya36swcbmqb7c4zqvwzm2kj5ddfantidoei4lqxcaucdfpdmq6@cijmxgn46vvu>
References: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
 <20241225100949.930897-2-shinichiro.kawasaki@wdc.com>
 <029d6daa-a2ee-4a5f-a529-2bd12df3018d@kernel.org>
In-Reply-To: <029d6daa-a2ee-4a5f-a529-2bd12df3018d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH3PR04MB8904:EE_
x-ms-office365-filtering-correlation-id: 4a353b03-cfb0-4a55-3073-08dd3503b7e2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zCS6HoBu9Rg0z7zf4cHnsNKJ1A0VoKgXPm/DkC1LSCiKmKkUdr0PG6a3A1v2?=
 =?us-ascii?Q?5XZk2S+z2Mpn9AYHhwz4tBQCYHIv64fIDp+RxHdrXHEL2Wx6pbPRwnyAaA09?=
 =?us-ascii?Q?59eagEN2rbQugO3St55JOJbXhqftzMeivGmYfaMh7O10HYuuj2WKc9DLxZzI?=
 =?us-ascii?Q?zCX/SldKUWtUgnENLSZ30DjHGfR3zNi8ITLVpCfD4CXnbWWrdF2g2J1qNpFz?=
 =?us-ascii?Q?rBdJRnIkBy7PRqSBXb9+1c5F1f8LGyGdtdpNo+Cxvi6qSO7Fo4QivtKrRFz2?=
 =?us-ascii?Q?vqiRFuZCsvbb96ZvnzWq9uqEhyNRZXBs2Br5PgfhLLCj8eN13T7CF4d/uHfo?=
 =?us-ascii?Q?BrSis/ndTJFaP69NrooG8aj69m2ZkUWS08+KSNPa7aqQA//MrGHTt24FZhBE?=
 =?us-ascii?Q?P/AQG4jw+8x+IrrdhqK5jmbEWkfAH4c0BuuMdfLUWreaTvY615kuAm0nLXps?=
 =?us-ascii?Q?9A6HUGvHrdvM20/IxgriRY8chgJUVyjoiQfdMGgzSTNDlY/tZIL2vMcK4CdZ?=
 =?us-ascii?Q?uBC/7k5rSDGvyI27T5ppEkCgsyAVYQLQJPHp1Gp1nZYgC/U5NKJWQ5pR5NMb?=
 =?us-ascii?Q?GFY+ENB735a30mmbnhm8IjibUeVX9stqkBrRR941t65/4TQig7RgZaxfyMTw?=
 =?us-ascii?Q?t8I8VdyaaDKZb6+ld/dk2by8GRf2qMUwrUAddRYToizmZTvngXwx3CNdoQQ6?=
 =?us-ascii?Q?meG3vC2XY7PG446QT9MpHnMg6eu3KXOsAJCAC2U4JK7qUFj56x//unpLqChf?=
 =?us-ascii?Q?BDKHoVv9yj9IpvDzldWc2yAYrqJ70bq5PKCVb/QMNDjkyyRgpIAa1Phli4u9?=
 =?us-ascii?Q?3/ncafL4PDvLLGsSdvm5nwOjnVU04sTI73W/4OozB1l97IjoD1qF0UYuTHnF?=
 =?us-ascii?Q?yrOe915QJx1AmxiT4Df2ek5sGdZylM8YEITXTvBwPqJnywbXoIZ7vjGrVdjB?=
 =?us-ascii?Q?lw+nL5brCU3rOK7jXuqgyesgYSiO3PCLiXOKDqb1vBU51VGp1gWxQqhpLvJ7?=
 =?us-ascii?Q?WjKvIq3633mlfEhQhcg5+LIRHAzYLm65oaaf3ZQnyyZKvCdZl4aXXw5ZEyvr?=
 =?us-ascii?Q?rLZqu/QnQWSQlvsR+3Ky7I6r3natUFk3NlU9NXBBB4cQl2OzB6ja+y/1Lj8V?=
 =?us-ascii?Q?NSB/I5b24Gq1h1liG8po1lAp80JXQAFMBot/wKIt1eJznQdUC9NP3p+bTtew?=
 =?us-ascii?Q?lRZxzT9U9fZjgP4SQkibjFacaLRIng665r8vNPxSmxiZ4WL+ls7vr0u4XdKI?=
 =?us-ascii?Q?JYt0wH/d0/quTFJTYpI/I3brJdWctSXSSQKC3I6GKhJe2z3x0VXfE3wEgUWl?=
 =?us-ascii?Q?/cq73rZB9GcuVL2V+VTgIAIdXyawn8M9AwmZH+osC/d4AClkgHHMKv6jMoTq?=
 =?us-ascii?Q?BcF8h6fPLouOVAu5VtlAm8Gq17Ewb01tv4wdzDpXOdVreS+6PPrAC9FbBWjR?=
 =?us-ascii?Q?wDXlrvFmgTDSlyfO3RuI71XvV9aEkfs9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eu2SC8WBgClnMX4R1CRJWQbm45ey0HPth9lxSvVesKPNpdnWiuOvreeMv0hD?=
 =?us-ascii?Q?UF2sp4WaiVz3WGXiu+DY1zyadsM9IZMGuNczW8I/dCyjwniq9uOlkbiaODub?=
 =?us-ascii?Q?pto2WbDpimCO9t4g5lz/yZvtPqrwprQZqxQRcB3i5FfENV2Zk7r6MDiTmZ0/?=
 =?us-ascii?Q?MRRqzScQpUrsbCufbWSRqegwRfIxnOjiTl2r6l0BsGE4aFoqiHUXJEs+9RYu?=
 =?us-ascii?Q?SX4+B/uAgWb2hPGL1QRXp3pZRgs8RI+absqHVHAXwKIMAKJ1poppc73vhdBd?=
 =?us-ascii?Q?GjMkOC80QlnoSiq6CfoSwwODA/g+8yg28Kwo2dLfIQgi126IyXFgsPDCw86x?=
 =?us-ascii?Q?YHeon2RykBLh7NMbhzYz7bAzwmfeDoDv8aAT/85mxggIOdvaH942fdxDHn8m?=
 =?us-ascii?Q?3ANBLSRHvYdWsPERZs8gd7jIHqQOjogax0k9ZaJzW108jv/McEfD1YO7nRwi?=
 =?us-ascii?Q?/wAFt2LLD/iFzAItQM/CarSlUyU9C4hGXdtDGuf7h2rWGoThaR0zZLLNSA7Q?=
 =?us-ascii?Q?glerwPbThYRFDf5OAinwgDlVVV2nf+V6Fb+zGFuMQcyeSJC9LWT31Reg+3n1?=
 =?us-ascii?Q?zuP7vS4CBpAgdkUs+GSaRnsalSgnsn6VMx/lghuTl5vcC46R+vtwRygFMww1?=
 =?us-ascii?Q?ZvLh2db53TZVqGLz+MYXG9BMTes9ojvLpbVaYdHmKJaxWKhNsIB6h6I/Od1E?=
 =?us-ascii?Q?izUEPpnDtylSfk9yLImXjDlWjp1p1S2BT69Xhly5pLTFKo/QsAQpXMQBPmmH?=
 =?us-ascii?Q?YV+9wjg2hf6+ffcLpGlLq9Us+40v8dXhcJwRr1NO77SRU0SJZ4CnOtJSP3PK?=
 =?us-ascii?Q?oQLm59QI7Vom2AemDzU+/nO/+N5TXm++RbOyTxQQen3TFpKPAZVdtEnAHigF?=
 =?us-ascii?Q?MR3ojtkUI17See4ppsxG3AyXkoSNwv04eybS5krg1aURnkWhPFT7POIiZa6/?=
 =?us-ascii?Q?ZaRVjG0B6GfhxLPWVYJuYE2aO4WkOPWW94ufz2STQ+JeT9UJXLdOrggkhh7k?=
 =?us-ascii?Q?ZrvCB+xooHocGC9+MqY3PH9ER/ckPfIg/K8G5KwAKeA+9VKvHalJ2ZqfeHyo?=
 =?us-ascii?Q?cDmMCIan41JwVdo+GQCyDCg/h/OLUwDVut4IbM8HxTO+/sp2FGrnBpUxIy/p?=
 =?us-ascii?Q?j2u6kdwBlrehI0i8sCIG3xOwc9aVJkSF4bg5LYNHrMl04gP/OutD85PlD6Rd?=
 =?us-ascii?Q?LSFUsSrHrMvfzzjDdyeCI/AGPtwtTN5Pn31XFiAsNoVgSaoff+iAAKSbnPBZ?=
 =?us-ascii?Q?U7yOuwP8+65j/QDMdsJIaEUpqSwS+r9JQ/AI82XxDc3cnlmZ81xDTeaKLU7N?=
 =?us-ascii?Q?vT9BL4+2KOn3yqM8ztaNiZ0pgFEJTUB626Ud1gvqmd57UHKPjr1Pv7f/01sx?=
 =?us-ascii?Q?cvAV+ZNPt9GJR+HIkTuM1G7fdtMZoN0AKf0bt+JFE+B0JyoD0hB3GrcXtMUQ?=
 =?us-ascii?Q?VwNbUbfjwvRhLvQk6a9tJw2DDWdLLysSYgo0K8G+wI/eM/MRCIcSlXoEMopv?=
 =?us-ascii?Q?vKuP6UUAjXiKMKuoPNiQniuqk16kNW7mYEI6z3wQYAt/qbkK5EsjHTJl0UBi?=
 =?us-ascii?Q?8rUqaSRhppCLwn+8xwajbPVAd7hOMS82ZSDb7obEGH2fruBdWYshAJxx9AFe?=
 =?us-ascii?Q?x/3+1APFtB2musZncaM5mIY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DED066AFCB7D9A44B7A7642712BB830C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w5/FqxBOICJCToVfyD/C2ZRd4BhZhj24ClQZV/WdJsDcvu0P6uE4dTSb/IMDqAQqAla1ZWdzmbPWUGGOBhMnRYMXINW0oAXJ8oDfBz7KUZKXAdYYjoQ3UGdz/G1F6QhDFeJ8OM6s8ZAqC/DQsQB7/+e38iOHKqHHksbX5mr1VsoTkR0Inqt1uRR+abmPgCp4h6Nfch62f1HLkbLuSfotJ6UbWyAqoDqe1PzB4I2W7E9rrctbcQnWLCDFj/TIVUHluyxPE7aMcO8daL4NGbTRDOBSdejANiblBLt2/q1x0CouoYT1Z9+Bf4UaqNrBrOdGaoESQcZcA1Ep2NaGkAfIAGS/Xp3ltxS4BX5Wn/4TkltLbu3J5jThnUfx9D4BKfP7k+Swx5plQal9r9gYTRhrkOrdIm/VSquyx2GICZyMvbBoiA/Vhs3H9d9cEdzvA5TXk9/fYm5aIcOUubVurPFEINMooqMApXyeMRh1BYyXzSFb9ueZRplrAgdmHEq6VTCClqJLVyEaQGn5iPxJ8olQmu/gmFdY1/oiD+7kOiEVY2dzbvmPqXKRUQalXJj7Fb4Gj6AwW8J5MHWMdhfiUmaW7P+k1HIpF4XforZ8dWUrs1LP2RjpcKdkWbFyRXWcS5Ty
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a353b03-cfb0-4a55-3073-08dd3503b7e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 01:27:04.2542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9KIqJKvdYdpSUqy8E4yrOM0hODxo5/8TqMGpOxXNWaYBjsLdlCWWcdhag3RFPvLCTACgYq4yaPVFfWyeE9lrgtoev07DPem2IxSgOFa8+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8904

On Jan 06, 2025 / 14:43, Damien Le Moal wrote:
> On 12/25/24 7:09 PM, Shin'ichiro Kawasaki wrote:
> > The null_blk configfs file 'features' provides a string that lists
> > available null_blk features for userspace programs to reference.
> > The string is defined as a long constant in the code, which tends to be
> > forgotten for updates. It also causes checkpatch.pl to report
> > "WARNING: quoted string split across lines".
> >=20
> > To avoid these drawbacks, generate the feature string on the fly. Refer
> > to the ca_name field of each element in the nullb_device_attrs table an=
d
> > concatenate them in the given buffer. Also, modify order of the
> > nullb_device_attrs table to not change the list order of the generated
> > string.
> >=20
> > Of note is that the feature "index" was missing before this commit.
> > This commit adds it to the generated string.
> >=20
> > Suggested-by: Bart Van Assche <bvanassche@acm.org>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>=20
> Nice cleanup ! One nit below. And with that fixed, feel free to add:
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Thanks, but I modified the patch for v3 based on Bart's comment, so still
have not yet added your Reviewed-by tag.

>=20
> > @@ -704,16 +708,27 @@ nullb_group_drop_item(struct config_group *group,=
 struct config_item *item)
> > =20
> >  static ssize_t memb_group_features_show(struct config_item *item, char=
 *page)
> >  {
> > -	return snprintf(page, PAGE_SIZE,
> > -			"badblocks,blocking,blocksize,cache_size,fua,"
> > -			"completion_nsec,discard,home_node,hw_queue_depth,"
> > -			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
> > -			"poll_queues,power,queue_mode,shared_tag_bitmap,"
> > -			"shared_tags,size,submit_queues,use_per_node_hctx,"
> > -			"virt_boundary,zoned,zone_capacity,zone_max_active,"
> > -			"zone_max_open,zone_nr_conv,zone_offline,zone_readonly,"
> > -			"zone_size,zone_append_max_sectors,zone_full,"
> > -			"rotational\n");
> > +
> > +	struct configfs_attribute **entry;
> > +	const char *fmt =3D "%s,";
> > +	size_t left =3D PAGE_SIZE;
> > +	size_t written =3D 0;
> > +	int ret;
> > +
> > +	for (entry =3D &nullb_device_attrs[0]; *entry && left > 0; entry++) {
> > +		if (!*(entry + 1))
> > +			fmt =3D "%s\n";
> > +		ret =3D snprintf(page + written, left, fmt, (*entry)->ca_name);
> > +		if (ret >=3D left) {
> > +			WARN_ONCE(1, "Too many null_blk features to print\n");
> > +			memzero_explicit(page, PAGE_SIZE);
> > +			return 0;
>=20
> Let's return an error here. Maybe "-EFBIG" ?

Thanks. I checked errno.h and found -ENOBUFS looks appropriate.

> Note that we are nowhere near to hit this though, nor should we ever reac=
h a 4K
> string length for null_blk features :)

Right, I have same understanding.
