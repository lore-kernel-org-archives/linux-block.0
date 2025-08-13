Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901812F2918
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084258; cv=fail; b=DP+BiTTbdRwGDw/iNd3eeQxYReRNTKlMSN0E4G+Hrjlh7RP/U8PWSw+geLwuAHAz2XnEq4jjO903DQaF2ie2ghRkfLta0SmgZPlLSwwXGlg/IyTbvs1M7ydgAeK+A4Fk64Xj8dQAFKFhZHbObqnjL3pbWbcyBoo+lDvNYYT+FuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084258; c=relaxed/simple;
	bh=+yIqK2OIbfi792mwHBgKNfKtdNTM4/J0oUedImkA/4M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ME6x2jlUkayLkqE9PmVABNChQIpgkv93g6h5Am7HgcKQcWD1Go/SqmX/apzcW6w+AjfDxTIhdQj+otUKb1CWFPU/dKZRR9JL5h/EWN3htC7OzzuKzkdNzhyS3AOM0X0RgoXznAf7OvkA4/+yKU1JpqBNtnMuo6ojYfHhzKm2wXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YK0+qcES; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VubQZfx4; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YK0+qcES";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VubQZfx4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1755084256; x=1786620256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+yIqK2OIbfi792mwHBgKNfKtdNTM4/J0oUedImkA/4M=;
  b=YK0+qcESobiMEe0eOfTrnC3keGoeCFZmiDK+QR5jAQ/dP21Uk17POqiE
   pKg4mOHL4YtjH3xA5iS/yt+DE82a6c9+ybwI6pKRz3DsOAsSt0x7AQGCg
   amH5Sp/+2RkdqVnX1PEONyIHCupLd772QJ11/lo+SSdoZCei71hMrDxvW
   rSDKe4ZpkYtViyHuZw//CPQdZraCxa84vRn68mur837VLPaLI/KOSq7EJ
   JakzGSiauReeAPT5OUA6sa5v4c93n5dsjc6+XM+4afRvyJ8xDQOXqHBI6
   Cz/8hP45FHIJJdDV5wVrfBYyQRVza8WKPEAQZZopZdk06o/u28bEVzOsw
   g==;
X-CSE-ConnectionGUID: 07uL1fAhR7yJ/2SuUtyD0w==
X-CSE-MsgGUID: YMk57PkPSV+JHo6DRlJvoQ==
X-IronPort-AV: E=Sophos;i="6.17,285,1747670400"; 
   d="scan'208";a="105758646"
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.80])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2025 19:24:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOqYvxIPtoHE6pe4f6IjxxbOFHKQruI/lh0PZHi+MJrxQrL+eNlCgGxuYlB7BO/qOugfkxkCmUrbC/nZsCU8ec8MWbqlWFz+uZcqg1w3Q1qA8wMz9PEgrmimeuVnKU9a/nxDZkZJrnQJuTzBX92qhVHf2eI2rLaatF+mHrAuKjlX9VRGhNzpDnyeh52Py8gNS6ZCFkByj27rYgxhD87hIlAiKRLzGrgbfIJfu3jGEqyHSaPmE9TBhLNa7PGTl8RcV8GKnYqPKYyJA8+GBmZ17v58U5LSi74YPojmSBrLp8sv/GCn16VzoeaxfpzsnfgslEL55iAI+3Pcbd6pZfkfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lDEs3VEgO2AFZL9FkWmvgpsgxZtr8Z+tizI7yoR8jM=;
 b=KHn/vlg++5TvCnpeZPydxbIZX6Y89CifNDr80VSKeDysbLjW1ZHuiZHe6unteiidIzMuNmMnLzPVHDALFm13/tJ9Vw2M0tW9KNbXIHUocZHSDuW12UyUyFVCWPq7WVrOPNIJflRnrgwTfDaTCnQRv6/UnXgZ2EijDP6M6sYvsxigA2wBCV+AtO1QLRePVC170R6AcZgsJTOwhVu6XVVcDm6qnYj9ZPT7ves7D2KAmZ9Gu+gd3uzPoxKoqOdZAZyB0tJEX4zl279uVMn0/NlhYc+ELUKHP87WLy8oFiKmFKBUa5AGVJunQ0VGUs9ITOaLfbE8zH8H/MXe/os5xgVhVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lDEs3VEgO2AFZL9FkWmvgpsgxZtr8Z+tizI7yoR8jM=;
 b=VubQZfx4MpncQEre/0KZkQx43THN4xe7SnrDH/KZM+RH6fgxGncVSLcGBkiTazhf+YDsHiCbbMLIZaGoN3f9m9AJ7O2EeblLsHQdSIoXSDm6S/7GdPGlcI+0hO0iiYKLjf3hM8jVHxOV+5XmAnHRu6SVcN6ngVTKitZZoHMPu5k=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA1PR04MB8496.namprd04.prod.outlook.com (2603:10b6:806:325::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.25; Wed, 13 Aug
 2025 11:24:05 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 11:24:05 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
CC: "vincent.fu@samsung.com" <vincent.fu@samsung.com>, "anuj1072538@gmail.com"
	<anuj1072538@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"hch@infradead.org" <hch@infradead.org>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "joshi.k@samsung.com" <joshi.k@samsung.com>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [blktests v1] block: add test for io_uring Protection Information
 (PI) interface using FS_IOC_GETLBMD_CAP
Thread-Topic: [blktests v1] block: add test for io_uring Protection
 Information (PI) interface using FS_IOC_GETLBMD_CAP
Thread-Index: AQHcBdJo1Y3vqBce4USJsy9bd044ebRYpr8AgASsoICAAyqIAA==
Date: Wed, 13 Aug 2025 11:24:05 +0000
Message-ID: <odm6y33y4fhk3tqtxtnldvqmw4l37mbuhztauofsttj4y5i7dt@a5wogxejzpki>
References:
 <CGME20250805061730epcas5p4ae7a8eda6d1d11cc90317a80738eb2ea@epcas5p4.samsung.com>
 <20250805061655.65690-1-anuj20.g@samsung.com>
 <v23bumua6pdez2kizqihersvyp4c5i6d5mecagtddwl426aaec@wfnq7zumao5n>
 <c1d4d4b6-ef17-4726-bfbc-0ac1cd04c1ed@samsung.com>
In-Reply-To: <c1d4d4b6-ef17-4726-bfbc-0ac1cd04c1ed@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA1PR04MB8496:EE_
x-ms-office365-filtering-correlation-id: f9185599-ed7a-4dd7-d33c-08ddda5be991
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u0IexayJb855XyuvjJ259VAsLEAwBm/e2fUNqaNxKT5vDUu3LT0KDC0vdtwm?=
 =?us-ascii?Q?JYgmtYpMP8t3KBv0y+RneSp54jrBd8htfeQ+RvWuNDVoLHRN3ClBk7z0SPiP?=
 =?us-ascii?Q?5jK+klyEL+iR/nu8BohbJXM/acUjVd+w9cLd2OBz8VfxyzLvuALwuI/nFYjZ?=
 =?us-ascii?Q?U++3qBUhXxGgbFmIH+Zl4lRgGtT1MjYIE8prDVA3tngncU54ogjpYb5whNG+?=
 =?us-ascii?Q?f2Dk8z5bcIHoHMY0fmSfxCDRlNZH4vf4iroFPWjt4xQoQMzuiFZP8+Ot6GAB?=
 =?us-ascii?Q?8i9vaog2ezxlFRUaMnV0EnY9wJonYqQgmL+8+EbLT36yupJJ+NGpQ/grt3qR?=
 =?us-ascii?Q?T13vlpWTUnLFfRKqJU6JKkjmj36uiwwDpGZz/fiDbemS9uRr2iNZQ34TawD7?=
 =?us-ascii?Q?g696+N7tWst7uF3DywqmYbg8ZT3kJm0ziwAjrlMKpun6ZUe/FJb8qQ8lQW8Q?=
 =?us-ascii?Q?gBFAuDaVO2t9fJbYf5vW014XxaKgrlzbUCHNd5jzW5I1Gmtb+1sttY5rj1uc?=
 =?us-ascii?Q?7IR1WU7tXwiho7lmjCrmkE2gkRDqDl29ZNZrSs1Y6Qa5J2vjtAR3hqwdqKP/?=
 =?us-ascii?Q?FKizDPqkXYXIoQ6+t1lEJJOd9GweHDeBORqOQisKqSXYwxHb/a0B5/0ufqmb?=
 =?us-ascii?Q?S8U5dTB2u0TsDqBLuB5Q71eykhX/ahq3oRinJU3ht6fqSZ6pS10q2mp4tAuJ?=
 =?us-ascii?Q?xpsXtB7rjPnIDijDH2R4kXNd8GHzNNr4JdxH3a4Et2ESRJKzZcYOw3odOWIX?=
 =?us-ascii?Q?x0o4HQUt1RVbfXhZ6+KU9dtR0t5GyA0OCcCe/H58eYNck/qWmzg1kOEYUmJ7?=
 =?us-ascii?Q?d/MQ8kqb3MjwHctsHVt33FPnJ+L81T5uYhlbq2LsA7PmirDOMY8huZHiQd5o?=
 =?us-ascii?Q?97htjO5vpd9lXVRZorhNoIlMUZJXwr6oNAOVCTNY3S76rjJe9WM/Lp1B1hyJ?=
 =?us-ascii?Q?wYWn2iusJjRgVBbgG3TgoQm1mNlvCBSKy2sgj1i06+lIXEcyYmX9vbh7z3AU?=
 =?us-ascii?Q?Yjj8nsswLTzuWUPXNhnomuDggqUG5jpYXGnbNyuZP7ca8CIOK8ymhqBzASCV?=
 =?us-ascii?Q?gTv9lpPCWOZZvY7UsSfB7vkIgrvhhBIxorpvvvD+JxT8YQNB3UzRkhCuYyBE?=
 =?us-ascii?Q?/lsoGz1x3w97PewINCxrcGKpCoD70mKa+y3YJAWqgAi81vL39Ly9LHorfZVX?=
 =?us-ascii?Q?6BxFdImBURv/rGI/IZraYWlDHwVXYxOFpvaEQa73a/qQYGz7lNii/S45Uu0M?=
 =?us-ascii?Q?4eR0R56JyVp0hbdtBxWfg0Jzzi092ZhiExCo2RgASL00/bkunPKs+DjM/ojk?=
 =?us-ascii?Q?w9n5STgUD8cOHqZc4I+kXyi8q9NAemo7HcAqLP+QTJeh0UoCZRx+tvDAT/4S?=
 =?us-ascii?Q?RUE2Zqg7GVkXo4cVqIyJs47O7kBBgNhTXI0wg9JYMri4SUb6+b7JhEm1wQT4?=
 =?us-ascii?Q?gIQmYZY1t9+sv2x/mwGycpPVxUgNfh/XOF9nw/G0TrSJe/TDcS35uQ9tdOjO?=
 =?us-ascii?Q?4O0EOB3JB7vzOFw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VUcgJBTSPq7ONeftFd4YNuwvH6q75PjZawmnqZmhc9IWO2hDeXBs3Avleqlp?=
 =?us-ascii?Q?YxXW4l4zcYq4NhWcAUopCkj9r9uJJ1Q8KZunocXRGC5hSZ9JSb4fqLYJDUC9?=
 =?us-ascii?Q?Apgc5JhbcsMBymtoYqcRJkkWzmpumeHAU0i7qwBALrz9MsDll4HyBsSNyd0e?=
 =?us-ascii?Q?r+oxvUYQLL1VC+JFmYEpaffP3v2tegJQrLwv+v+QZXNZZMrs6EzLwy0s/Qn/?=
 =?us-ascii?Q?5eISyTHfPx15kN8ApyibL4LEr8s5Sb1tnJXND/fTZA5hItrLZqbogMQM/a+Q?=
 =?us-ascii?Q?yWY6Il6Gc7TyER545OWYKqCGZ+JK29AXsq/cCFQbePNh3/ROPbx4ro3BYqlj?=
 =?us-ascii?Q?cmQXW9xs0OdRE+OWsIJWMcVmnqJ6cG1gCbA6rRuMG2AIOcKcjZniA/pFkZSu?=
 =?us-ascii?Q?fWFwxCW3Vgy/X4CrHUoohzPJq2VCFN57uB1x92mBgPdvvYkVeynExm0z+sta?=
 =?us-ascii?Q?hPrdk203aEkgym7+JXURpGbONXAp+BwNPC6pCbCn+6mJFk5HMy5mSyzZ7xrF?=
 =?us-ascii?Q?eleuAYlyGlZ/2EISc73Lzxjxdr6w9jJ8QKMRY3Eo+9PdDxmVmwHDzNEEETWY?=
 =?us-ascii?Q?QKFPHE0vTMB8G1vOArZqvusYQpmu4S9OODF5SLlPEyZ6kiRF39SGq2uRssWP?=
 =?us-ascii?Q?IuyB2NxUPgeyip/ZgGxskApSCGI2K+3yT/uCRs6cXrRILCXoNG/NzHppmIw4?=
 =?us-ascii?Q?x/59xgpJ2E2YbZ6qy/f4g4+WFZOHruv5YctiEVBVejAs3Rsj+TflJRJyzGZw?=
 =?us-ascii?Q?VSAvJVQjZspFHCg2uJsINUuaq3/tj0bhrjqDu78/gx4rxQoRb/zcsFtagiTP?=
 =?us-ascii?Q?nupBy4O4bk3dlrVvjYYa2MgU7yTwDIyPhSo/bGjSoVhVxXPL0F6/fCxhNh/g?=
 =?us-ascii?Q?FcMKJWqS/pA+iqRBfnZMdn37XAqpOvqyZdEn0mRrCs1nFV7hVhSj6nn7c74H?=
 =?us-ascii?Q?ahFee4QNTX9oyLyyytrQK3dj24FUxLHiPyFROiD16U2r5ALl1dNdeCOXBFUR?=
 =?us-ascii?Q?GGsTXhweucqkpdsUCYHmZYzZdfjlCLTRPebgY5tTx7YJMS6AcOa+BCYzbLtO?=
 =?us-ascii?Q?1emLSO/tHG5XopEZnjDpIacN7I4jmmHIOyhqFYmh/AumoPb8gejQEdNihtCR?=
 =?us-ascii?Q?wXXFX5XzsNOGQMBbq7KN9zqUyufb+hNUhkBmW7P/8rqkvzlpQnp64phsruvu?=
 =?us-ascii?Q?n3B8YgLyYxKHdR8RJOzV90UX6uuYAQ84owD4WqC8RNqGJEKqOBUS6CCGDP6J?=
 =?us-ascii?Q?D6DGnnbz9/ld8dznBtOtUlUey8+P7zarIVK7BYOMKGvirSTVEgbdVLVJoj4k?=
 =?us-ascii?Q?kh2a0p1k0s/ShMU342nndiVA88wugVfGdCDVe241JYBWW/LpFuHgpQopLQ0m?=
 =?us-ascii?Q?AR6pcXL/0Zs+5hKMOaOd4BaFXgABUH5uuXhKEnwwzGLVuLdcdoAq8hgYGjn8?=
 =?us-ascii?Q?/sWSPxGa66htGGzPH2BAbwzVOLSQ/Qw4h3D6KVtrdXgKfXJ0ZCRhIz4FkDqH?=
 =?us-ascii?Q?Ixtgk89Hr2wOwnhonr7BMD/ovv51P9j4TPkz8nMhlsJtLJE/WFULEeNOG9iQ?=
 =?us-ascii?Q?gOEXwMJab7tBRQnLsM5CDMFscEIGPENo0skbL7Qu8N1E3sKsvh2/ytu6/z/3?=
 =?us-ascii?Q?mdoZm25Sm+QoFEwhsxeuxsM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D5B7272C86C6740B2663253E85A38CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u4CMvAXl8EizFQmBQi1DLwyGrG9eHY8e03qVhQ+lTwJ8/qv2KeSZO17/lDHC55+KEQBfuNcTuMKJw6n+CZu9ylCVBsVMj4zitnVUBuJsqo73Dw9kBzvy0xLPLUHNyMkn8gmc3tvaWBf2PJ8Hhw6leUCRApu/VtmG/oK5QGlRo2pGM1Kn38UPzG03+RVgrXsJlkUanv9bg2U6qbjLZQiaMHs22oQcKwb/e97gQSfyJtzsyK9CD0fQLpHPWaCVlUajkxfyxChEmyo+zybY+8wE3AsDtTZhEBOKwsZ7qi9B9o108cWumhDVxsDJ+EK8TIq/wkXw1XpUuN8GmM6aB5znLCBE/vURD4UTIA4QwjgU/7/J1CweR7hjBVf9/T9ihx9lLI8wBUbYFNzzZHzSviP5QtaTv80I5eEx5nuHhyL42Sr9zUEEUPKgIl6FmwV+YRiHOxSom2SPlgpwBlxmvC7dYGSz9UaTW/KgWSSQVVp9BGx3B/zZ2GF3j1wnEXSY/lJVyjjtmjbA5jrSOJfoH7r8DZ6EpuHPEnaFQ6AVqkArN9oQGat14KEPLMKMUmDtYuTsccoDSJjnpZpwB79lrbKAsSaR1Il7Lb2KlCVu/tDyJ85jllj+0hk8i+jAGpAavbhO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9185599-ed7a-4dd7-d33c-08ddda5be991
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 11:24:05.1723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oy1qCskwPP1GmrRc5Zkk8uixQE7BKlwOR+YHFZbNKGeEu8jnXc6UJcH6FJCJWGnhzadOlPiRJubGd2ZdQ8FXkzaZeQUHKmEsCwdTzMbS9Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8496

On Aug 11, 2025 / 16:33, Anuj Gupta/Anuj Gupta wrote:
> On 8/8/2025 5:10 PM, Shinichiro Kawasaki wrote:
> > On Aug 05, 2025 / 11:46, Anuj Gupta wrote:
> >> This test verifies end-to-end support for integrity metadata via the
> >> io-uring interface. It uses the FS_IOC_GETLBMD_CAP ioctl to query the
> >> logical block metadata capabilities of the device. These values are th=
en
> >> passed to fio using the md_per_io_size option.
> >>
> >> io_uring PI interface: https://lore.kernel.org/all/20241128112240.8867=
-1-anuj20.g@samsung.com/
> >> fio support for interface: https://lore.kernel.org/all/20250725175808.=
2632-2-vincent.fu@samsung.com/
> >> ioctl: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log=
/?h=3Dvfs-6.17.integrity
> >> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> >> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
> >=20
> > Anuj, thank you for the patch.
> >=20
> > I wonder which test group this test case should go into, block or nvme.=
 IIUC,
> > this test case runs only for nvme devices. Said that, block group looks=
 good for
> > me since the test target ioctl interface belongs to the block layer.
> >=20
> > I tried to run the test case using QEMU NVME emulation devices with som=
e
> > ms=3DX,pi=3DY options, but the test runs failed. The kernel reported a =
number of
> > "protection error"s. Can we run the test case with QEMU NVME emulation =
device?
> > If so, could you share the recommended set up of the device?
>=20
> Could you please share/paste the errors that you encountered?

The errors were as follows:

block/041 =3D> nvme1n1 (io_uring read with PI metadata buffer on block devi=
ce) [failed]
    runtime    ...  0.354s
    --- tests/block/041.out     2025-08-13 19:56:15.487074413 +0900
    +++ /home/shin/Blktests/blktests/results/nvme1n1/block/041.out.bad  202=
5-08-13 20:06:23.199291948 +0900
    @@ -1,2 +1,12 @@
     Running block/041
    +fio: io_u error on file /dev/nvme1n1: Invalid or incomplete multibyte =
or wide character: read offset=3D12288, buflen=3D4096
    +fio: io_u error on file /dev/nvme1n1: Invalid or incomplete multibyte =
or wide character: read offset=3D688128, buflen=3D4096
    +fio: io_u error on file /dev/nvme1n1: Invalid or incomplete multibyte =
or wide character: read offset=3D630784, buflen=3D4096
    +fio: io_u error on file /dev/nvme1n1: Invalid or incomplete multibyte =
or wide character: read offset=3D905216, buflen=3D4096
    +fio: io_u error on file /dev/nvme1n1: Invalid or incomplete multibyte =
or wide character: read offset=3D233472, buflen=3D4096
    +fio: io_u error on file /dev/nvme1n1: Invalid or incomplete multibyte =
or wide character: read offset=3D540672, buflen=3D4096
    ...
    (Run 'diff -u tests/block/041.out /home/shin/Blktests/blktests/results/=
nvme1n1/block/041.out.bad' to see the entire diff)

>=20
> The issue occurs because setting ms and pi in the QEMU command line is
> not enough, the namespace still needs to be formatted. Could you please
> run the test again after running the nvme format command on device with=20
> the desired LBA format (PI enabled).

Ah, thanks. I ran "nvme format -i 1 /dev/nvme0n1" for the QEMU NVME device
prepared with QEMU NVME option "ms=3D8,pi=3D1", then the test case passes. =
The
test case looks working as expected :)=
