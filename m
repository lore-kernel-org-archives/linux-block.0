Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6DE188A3B
	for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224879; cv=fail; b=pFkomv4g+X4fr0aVn5FJIPVQf+uLlRcIRxUDucC+8qSdPFhEuJeyPJPN+APqOraqIWn6+7Foi+VSPANky9YkGuxxVY2+bCu+Kd2FNzdqxyFtsHcLjjun/JnbmFWeAy2IostBb1aGrVVDnqJ8ISXdL5QXj1q03A/TlqvOMGo2+go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224879; c=relaxed/simple;
	bh=mxYNrMYQi97iixVCkUXiH+0DluiN9JeXhmEQ1zolNck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SDi3mc9zSQNpubmSAIR+zf7BF0wHnPstsag6bQVn3TfgoCvKY296PCpDSywgf57XmaUt44iQDCjaWwgamGp+uVntG2z7B27IvkNlZJYzGotFShInSliX8JLAa7O9bBFn6lmBDiQkWGQwRn8IjbIegC0pPbDOYQmY95LolVPlAUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZqOCBCpg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ncxKC1g2; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZqOCBCpg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ncxKC1g2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724224877; x=1755760877;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mxYNrMYQi97iixVCkUXiH+0DluiN9JeXhmEQ1zolNck=;
  b=ZqOCBCpgB/Gwuk3eh6Dm3so1g91QGbzXeLXceOjZZNt4cL/r20s7bBga
   8EFoDkhHrZCg8XqX524onpyUVMvRAAU57uGLIVnGMkhvC1Hto6rfLan7U
   UzdKK2alg8MYGFNPtDod7uCyol8M1k+bfisP722BVWwd8zFvTrzkvNXKH
   211taRq4XHAONkDXfe7lNw3q/UjUC2Fux3wgXwvqewhPLjJczEPHycJOd
   iF7P0Z19gT65cp2DcWMQi9uprZaXoC9OZ5u0JcUeUb4lMr2faA0vWWb40
   0BfRecW/gN+jQNUr71U0rdYECr+sjX6HpArrh5f0gsBurykdhPYrPPYer
   w==;
X-CSE-ConnectionGUID: k0qdFBlIRsyK6DAqa4hXRA==
X-CSE-MsgGUID: 4NPrC19kQZWnG0NIHzkQTg==
X-IronPort-AV: E=Sophos;i="6.10,164,1719849600"; 
   d="scan'208";a="24783318"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2024 15:21:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+jLHhrlE/kWmUcTsef4lsIo4l1qtUiSyrNKl6Qxi+K1GVkbiuFpexQcXrTdI1dKa+slR91YaA4IY2KgU29oVnyL3aVuVW4mMtjBOigs1GbsIJBBJn8um4O403TszrIxoKlcY8bRCOO9pz7VV2TsNaUG/U/9/lNVAczz7gR3kV02HAtnffhIsbtEdujaAXHpv+KE7G8jlYch2IzPCowwJBzlrwl9mX6KfO1ZhaggCRXttH+/wzvXTyfJb03ILBzY+1CUKA29RAvwhu92T95+hkedQrr5EdO+eAqPDoIQnlnZD4Z3T2S4PaW10L1QfTSOSdJFhalJ7P3ZDRtScW62ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmpPnuLTX614rB2ZsooLiE3BV52zkFNYIxHMjjkBTzA=;
 b=ZZ7ovjTw5eh/ObTY03/br9ceR9LFRoPilTYw8CtwNLETa7gCJ9sQSCzNnoNVNWfgrbbuorENDOa+5vkCFjHlb/jTDo+36/0JlwuA0Cvmnw3toCluiFyHnvyZAPwqPeDkIn6j/es0oCKmeCAuT750k46eiS00n2HgxdMU4ZoQ7iHdWnzIlroDTiPnolCIrnNIchYP8oDSY7/i+tXmKKaodAnxMdZXKNV/EI8YagpbAptMGHLaSG572OCxuOMPqJW0HbySyL33GbeDpnfcrgF9VFE+JQUVa9eD116bUJckJAz9ycmTOfO2iBlaOgb1UVSS4Zs2VcoKGjR7/+XgVooq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmpPnuLTX614rB2ZsooLiE3BV52zkFNYIxHMjjkBTzA=;
 b=ncxKC1g2zxlv+SjK+5+50aj1NNndMyD3ky8WnEhjnsJzjmsM0bt9LjRX0kREG0+r1mU0dhdnHUXmKjjrnhR6z9R/lHw1db/+Cs7u1wEEJP2Ca+0SQfRqva0sFTRhdbFmPlpC8brMWgBGRH93ffgBqolytEkuUJN+GrCnCY/qot0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB8331.namprd04.prod.outlook.com (2603:10b6:303:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 07:21:13 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 07:21:13 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Yi Zhang
	<yi.zhang@redhat.com>
Subject: Re: [PATCH blktests] nvme/052: wait for namespace removal before
 recreating namespace
Thread-Topic: [PATCH blktests] nvme/052: wait for namespace removal before
 recreating namespace
Thread-Index: AQHa8uqR0Nq3uU3VMkila6SfAwK3vLIwXbgAgADx2QA=
Date: Wed, 21 Aug 2024 07:21:13 +0000
Message-ID: <zzodkioqxp6dcskfv6p5grncnvjdmakof3wemjemnralqhes4e@edr2n343oy62>
References: <20240820102013.781794-1-shinichiro.kawasaki@wdc.com>
 <d22e0c6f-0451-4299-970f-602458b6556d@linux.ibm.com>
In-Reply-To: <d22e0c6f-0451-4299-970f-602458b6556d@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB8331:EE_
x-ms-office365-filtering-correlation-id: 7c7703eb-cdb9-49e9-ddc1-08dcc1b1d6b4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZP/4lEOPebXQskauqEkmENYQNky6Xm3E2aa8um3XzlGE/uXcw2rpuuMZd7eY?=
 =?us-ascii?Q?+KAbii4HUYN1HzxzDaNHFMIXJO8H6CqDqFlOx7YTXVmEXkVLw9axM8pWyxgJ?=
 =?us-ascii?Q?tx/KYTUkdqcCUV50nrBjbCdow/3+B0ovJQOjm9SXRasPmZrTA3xsopkxo5zk?=
 =?us-ascii?Q?SpVVwPD8prLrVn9DiIeEUedUf11pWD7ZU/Rdjsvr3xRPfmIf5jNs2NiLJgnq?=
 =?us-ascii?Q?jfeO5QQPcuDiaMD3b03see9iZHW7ypEOu9AvUkBMfeqv81Dmr6YeYOOcNHNa?=
 =?us-ascii?Q?VdZS0WqiKxPquPr6J2JcbW0W+0RKZk+O57sTO6xqDoorb1TBDUy2DpkZxDjh?=
 =?us-ascii?Q?R95U5Zwcl5XemJ6RLtLKxy3VKvP8pftZBHzYa4V85vYtv5Ta22qs9stTxjS0?=
 =?us-ascii?Q?a1WrHwDND9LbGoFhFwCiUtbk6oNZWsHaqtvsJeBkEFeevDN33hFwRFUhh55f?=
 =?us-ascii?Q?hvAkYEKPmL9iDSQ7XGawI6HdrEZ0lfff42FFeocYDvQm5Zw49Aen8gygxSrV?=
 =?us-ascii?Q?cUY7RESv/PK7W7LczpwPI7l5a+hW61kVzmtQViqpjMWI1wyqKtb+VOLFKFtp?=
 =?us-ascii?Q?dtPy1ywtykdCRUk+a3N5CvV2I8hg85IKTPBpJHhUuT48UQFauJNcyVTVGj2j?=
 =?us-ascii?Q?kTTd83Cqt2lnrPksRQEXy0AetPueRyunybDE5qUPz6xl4oghEShToFb7iO3Y?=
 =?us-ascii?Q?3E5MfYOpuYlO7FGGU1exS88t+Zx0NT3bf3IeivNBvk2a0x/FfmJZeNbc843J?=
 =?us-ascii?Q?Dl2mtOw0Bqvtd5ez0KOIUt1ZzgKemkBSr44dxnDc9rXkMCPsKNQPrOJqSoEW?=
 =?us-ascii?Q?y5IKzi1L8PgZiuupCxp+y1VuhuLrkY6yKBwK5c4A7LuBp3MYiHp2NVQuyic0?=
 =?us-ascii?Q?NRJyrjMLFRh29qd2sLXlOxw8gxmKdFqPXZLuErbZUAuvB+5U8Y22fFWOLj2n?=
 =?us-ascii?Q?0kN47B3m3yD7q5GYxlk8N6M7FIdTh1YghY1t1paY2EoGjlf3hwQFZdoNxbKU?=
 =?us-ascii?Q?KkbGWK2ZSEOhWdvCUZEc5EoT+F1DJLtcNOrCobvowzUwY9iIrQ3STgVeUm7b?=
 =?us-ascii?Q?+/5aGQ8Equ8yA2ioPvXgBxux2WG6I6EevDe2zlh/GOLdmLblwI7gWKd8PgXu?=
 =?us-ascii?Q?gXaNAepq55sx7tgsQBfoTyNoQjBMmo/i7pN6FaSP+VokGiMuQUXvsrwT9zUp?=
 =?us-ascii?Q?zBQ6/zzAUoiJaVf4OrnYVe8AXaUJZ4DHgZ/lKpMS0ZEaeMXUxMk5Jzh1j9Kt?=
 =?us-ascii?Q?/wKazNZiQ7Ky6r0AdYccW0QK7q7MxH7cFxLPqLg3IagxXMo7fvhHcry53lt+?=
 =?us-ascii?Q?S0xOd17itKd6elIKrHg75QffIhoKttoPoikWMj/fTnq2x2aiaKv33oR81bwV?=
 =?us-ascii?Q?dfDxhSf87Vg5iWlKLytwW10ZrVOSPSx3osIKVVkGU0+I5rymsw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5JeZVnYw3/OSRlHZWRPizaQjAcT0q6aIMnlWDEm68Z2/xe36MKzzYZkcox9k?=
 =?us-ascii?Q?loSeT01mrSsmrVnlbynKcKmPfehNQoCWUMIwOObtWdVZs0trKLRuImAwNgY+?=
 =?us-ascii?Q?wWxtKHmW8PqwWqspT3CPXHbFyIf20Pqg6CHX9tV2gP8vPlpTulmhUpaUQ5JC?=
 =?us-ascii?Q?/k3pQS0dU4HozdIh4MMy7kVe8idWTVbD16PNXFyYYqsxqppIhPTvikRpBgl1?=
 =?us-ascii?Q?BWsXK49bBrreKjM0z3lZ4oTd4GsgocNzKx02lqIgO6s3mDy3sNcgpjBwRFz4?=
 =?us-ascii?Q?v8BBhJg926NQyhCziHDKQIHJI3/oMQG+Sxz2X0OS30SyDQ2m4/PtiujsMt6O?=
 =?us-ascii?Q?YAJ+ZK9mdtR9K+KdMVKKK5wJn1OYK5nt6/+J3MJ7e0pRzuEXEPCWVBXOjzSp?=
 =?us-ascii?Q?wtgkfFF0eH1xH+t/l/OJItY5NvQR5gMg/ywNEbRasI+gq7fFqhHBR9Ky99AW?=
 =?us-ascii?Q?MLfDOcfqClMyRjxj0P13810ewoWPiKPriqcpG+VSrxnAZVwODJsi2YBxb/Wj?=
 =?us-ascii?Q?5tzDEzoscKv3vD9oDcedFcWiA7S5V0DHwZuQ77qULJjSBdwGNyIr+q1uPRgz?=
 =?us-ascii?Q?/TERTUWPeOYYsCVi2pCzVLDvnckHRVBHLqaZtR9Uy8U63ZsDNN1QswT12rhr?=
 =?us-ascii?Q?U9reW6S7JEu9OBCJJTQu6yu/C1LzkMHAVcI7VFmJmmDj1anMUG1TIFSFl8Rr?=
 =?us-ascii?Q?WgtRP0Pd4dmnV8wBDFxtEXMgCYXzFvCx0SY4KBbWHfXX8G3MwQJY1v67OUyH?=
 =?us-ascii?Q?vjJg47ufyRz/rBGFsMSUUmrwCU7oryW9ehbpaFuOvaIyLpatlQ+nqE21Qq0K?=
 =?us-ascii?Q?8do03K3m33lR1N630Zm/HyWwMvU68adVwhnp3ynEFRWCDzP8mzOnES6tkRtB?=
 =?us-ascii?Q?A5TKz2rHolzJlBU9zlNqpwlFGfSy8PxvlJgezpcnfkBM6tUMAiu1/Lyi/UZw?=
 =?us-ascii?Q?6pSCMFDSGxwpHxc1sT/Kz2DOi4KTgov4EoJMSOTvyTlpmKNbM1/6OkBIys5R?=
 =?us-ascii?Q?pZF7vJvHFQvzd+j8ZwTC61BeZD7k9Ufwncyl0C2SxvieeSqA6+Ax9X5q3NSO?=
 =?us-ascii?Q?z+xr58kTuw50K7/MelW5bj/DpFyLKIU1DLw14ejr65PRF3jMbeVH1yWYNGfs?=
 =?us-ascii?Q?5RIKqu6shF6UjmpH/sG275XUF1JxbA4tovgeH5Ay/GO2TKIlutQuag/8b//e?=
 =?us-ascii?Q?q+MHCTaMF/3S192LavBKHiZffcKyKpv8pvDo8PIDY18iC5N0fihSFH08I93r?=
 =?us-ascii?Q?xqUTNuvm1QKjNO2kXNdCOvrJ2XqoA/UlKlLBgL+bxDuVQw4YVKOWxQmcUHkD?=
 =?us-ascii?Q?kSDfGSclvkv6Gfx3wEGcsh8Tu8YX5lWxO8DM4b0QzsFO7w69yz8ngdCQ7Uou?=
 =?us-ascii?Q?nVAIOLfymoZOgj9nH1C5uo0qRzQZ/VnKb1q3XloN/nmzWpQWfR+A1yrhtLyY?=
 =?us-ascii?Q?rlDtuTNQJhQf6r/kjt0qh0yDy2gIC59LfqIeJE8mPHPzcVq7K0yGEHPbWj8W?=
 =?us-ascii?Q?6DVPpzmAY+HN5VJZ3eNZ1xbMycR1XKWszLQXWoRQmU2enuUbdrOC5Nu39euV?=
 =?us-ascii?Q?LASqEvoknYC5PLvk4tFqFDl0x02sdRYqOThxAR4k4e20BonWp5yK53RVd2N3?=
 =?us-ascii?Q?YRyD2vsTt6GY/Wpw0yUA4z4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F5D8834451D1041A5095FBC5301EC82@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2nkcqZ/4PkdDXwe976vVLWlFOVc6/QMAtNC3fSW8AnYoos2WB5wWrLrRo9yz/99/w3r+YEMc2lpR8ojk5DInyvmhU5r1Kf3axqUdyAXI3zyWQM7PpwOgXuYtX4P1H7K1TbfCzDMfRD2s88cw6ycrCHqxU0jvZSao94Cc7G6qDebO26bHHqez+zsJg33i+g78LCVBDgoOSYV4ZVjZ7JcDr0xrJ5RSqtuVatKDR2nohWmMrgBRIRLSJQ2Ftkgc9yexLB1h/iSBYMslHRyM55n9nSoFaz4GoT/DoKwh2PFJOYAXAqCKD3ktfHyr+HJi9hkKSt+GcM7vHlATkoJ389ZCEp1y1i3WOm9+mkMRViphTYHKjy5pG/UjSPhdULBiagQ9DzqWHlZiv4FlgS3B+A+oExlKMJr7AUo9arxky4/iUqI0BjTLcPbDWH/jtoxiu4wnF48ymG3rEC3dXB9fiBwW6MIi8ql+IszDr5iQ9fIBJet43IJC4XRJVOd9NTXRqo6IlrXrzkmxq2JEkZ63byFkkovtXASuZ5xNtS+UbuXJ/D9BhdeBgCjlns02ItsGlynxHE4NTDnbHTzCDK0C33XNADkjAenS67SPyjZiP5QT3QPzktKI0MBqq6Kx9VHsoJ+j
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7703eb-cdb9-49e9-ddc1-08dcc1b1d6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 07:21:13.4983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KE3B6Q/w5fzMr0/VqVOPzQf/lVusCUMWn7TRzTkgqvYTObt24gOrePb9+6lpB68/rPs5wcFqNDm4MBAH4MtoN3JvJ+0d6iSYyrXBVSEs7OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8331

On Aug 20, 2024 / 22:25, Nilay Shroff wrote:
>=20
>=20
> On 8/20/24 15:50, Shin'ichiro Kawasaki wrote:
[...]
> > diff --git a/tests/nvme/052 b/tests/nvme/052
> > index cf6061a..e1ac823 100755
> > --- a/tests/nvme/052
> > +++ b/tests/nvme/052
> > @@ -39,15 +39,32 @@ nvmf_wait_for_ns() {
> >  		ns=3D$(_find_nvme_ns "${uuid}")
> >  	done
> > =20
> > +	echo "$ns"
> >  	return 0
> >  }
> > =20
> > +nvmf_wait_for_ns_removal() {
> > +	local ns=3D$1 i
> > +
> > +	for ((i =3D 0; i < 10; i++)); do
> > +		if [[ ! -e /dev/$ns ]]; then
> > +			return
> > +		fi
> > +		sleep .1
> > +		echo "wait removal of $ns" >> "$FULL"
> > +	done
> > +
> > +	if [[ -e /dev/$ns ]]; then
> > +		echo "Failed to remove the namespace $ns"
> > +	fi
> > +}
> > +
> Under nvmf_wait_for_ns_removal(), instead of checking the existence of "/=
dev/$ns",=20
> how about checking the existence of file "/sys/block/$ns"? As we know, wh=
en this issue=20
> manifests, we have a stale entry "/sys/block/$ns/$uuid" lurking around fr=
om the=20
> previous iteration for sometime causing the observed symptom. So I think,=
 we may reuse the=20
> _find_nvme_ns() function to wait until the stale "/sys/block/$ns/$uuid" f=
ile=20
> exists.

It sounds a good idea to reuse _find_nvme_ns().

> Maybe something like below:
>=20
> nvmf_wait_for_ns_removal() {
>         local ns
>         local timeout=3D"5"
>         local uuid=3D"$1"
>=20
>         ns=3D$(_find_nvme_ns "${uuid}")

I tried this, and found that the _find_nvme_ns call spits out the failure
"cat: /sys/block/nvme1n2/uuid: No such file or directory", because the
delayed namespace removal can happen here. To suppress the error message,
this line should be,

         ns=3D$(_find_nvme_ns "${uuid}" 2> /dev/null)

>=20
>         start_time=3D$(date +%s)
>         while [[ ! -z "$ns" ]]; do
>                 sleep 1
>                 end_time=3D$(date +%s)
>                 if (( end_time - start_time > timeout )); then
>                         echo "namespace with uuid \"${uuid}\" still " \
>                                 "not deleted within ${timeout} seconds"
>                         return 1
>                 fi
> 		echo "Waiting for $ns removal" >> ${FULL}
>                 ns=3D$(_find_nvme_ns "${uuid}")

Same comment as above.

> 			=09
>         done
>=20
>         return 0
> }

I found that your nvmf_wait_for_ns_removal() above has certain amount of
duplication with the existing nvmf_wait_for_ns(). To avoid the duplication,
I suggest to reuse nvmf_wait_for_ns() and add a new argument to control wai=
t
target event: namespace 'created' or 'removed'. With this idea, I created t=
he
patch below. I confirmed the patch avoids the failure.

One drawback of this new patch based on your suggestion is that it extends
execution time of the test case from 20+ seconds to 40+ seconds. In most ca=
ses,
the while loop condition check in nvmf_wait_for_ns() is true at the first t=
ime,
and false at the the second time. So, nvmf_wait_for_ns() takes 1 second for=
 one
time "sleep 1". Before applying this patch, it took 20+ seconds for 20 time=
s
iteration. After applying the patch, it takes 40+ seconds, since one iterat=
ion
calls nvmf_wait_for_ns() twice. So how about to reduce the sleep time from =
1 to
0.1? I tried it and observed that it reduced the runtime from 40+ seconds t=
o 10+
seconds.

diff --git a/tests/nvme/052 b/tests/nvme/052
index cf6061a..22e0bf5 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -20,23 +20,35 @@ set_conditions() {
 	_set_nvme_trtype "$@"
 }
=20
+find_nvme_ns() {
+	if [[ "$2" =3D=3D removed ]]; then
+		_find_nvme_ns "$1" 2> /dev/null
+	else
+		_find_nvme_ns "$1"
+	fi
+}
+
+# Wait for the namespace with specified uuid to fulfill the specified cond=
tion,
+# "created" or "removed".
 nvmf_wait_for_ns() {
 	local ns
 	local timeout=3D"5"
 	local uuid=3D"$1"
+	local condition=3D"$2"
=20
-	ns=3D$(_find_nvme_ns "${uuid}")
+	ns=3D$(find_nvme_ns "${uuid}" "${condition}")
=20
 	start_time=3D$(date +%s)
-	while [[ -z "$ns" ]]; do
+	while [[ -z "$ns" && "$condition" =3D=3D created  ]] ||
+		      [[ -n "$ns" && "$condition" =3D=3D removed ]]; do
 		sleep 1
 		end_time=3D$(date +%s)
 		if (( end_time - start_time > timeout )); then
 			echo "namespace with uuid \"${uuid}\" not " \
-				"found within ${timeout} seconds"
+				"${condition} within ${timeout} seconds"
 			return 1
 		fi
-		ns=3D$(_find_nvme_ns "${uuid}")
+		ns=3D$(find_nvme_ns "${uuid}" "${condition}")
 	done
=20
 	return 0
@@ -63,7 +75,7 @@ test() {
 		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i" "=
${uuid}"
=20
 		# wait until async request is processed and ns is created
-		nvmf_wait_for_ns "${uuid}"
+		nvmf_wait_for_ns "${uuid}" created
 		if [ $? -eq 1 ]; then
 			echo "FAIL"
 			rm "$(_nvme_def_file_path).$i"
@@ -71,6 +83,10 @@ test() {
 		fi
=20
 		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
+
+		# wait until async request is processed and ns is removed
+		nvmf_wait_for_ns "${uuid}" removed
+
 		rm "$(_nvme_def_file_path).$i"
 	}
 	done=
