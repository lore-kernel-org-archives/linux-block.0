Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B784199BC
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 05:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752123696; cv=fail; b=LMGdLZs0sIYV6oMdRLUu2nz3Lj7lFabyeknXFXozQ9I1kVf/C1w5jOVG+ZDziDdaKBdg0qHT75DCUpKQPAGr2sMbYdExwTI6TihPcoYAzO+Y17eBQ30o+3/z6qLZQKY6YIe/8tgEv6wCQpujYHRrXCkpQOwR+rqZq9Ri7X/FNwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752123696; c=relaxed/simple;
	bh=wCCGxzGXgaMZP1YtrpyUekRUTxnKbQWHvnKvEWoitl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WSERTIy0KoDCG5oWoCIVCz/LbF+YgP9SL80RWHkSnutdof93yRm2/PEH1gcWsJ7t975q7WzoEDSlRVxiKa0cc0zIeR2jLEMdFkoiMVD+1vKURLnq+5TVh3gcSv69XxqhxSwbJ+YERm/DNXxN979f0cH38MQeQAxDrulphKQ7q90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kJGwEXDi; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SDwikpE4; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kJGwEXDi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SDwikpE4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752123694; x=1783659694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wCCGxzGXgaMZP1YtrpyUekRUTxnKbQWHvnKvEWoitl8=;
  b=kJGwEXDivp8PrLRjXgJXKK4Yp417kuOVT8/z+hDCdCviEzfveSFKEz0O
   Gs5Lo1LXeIKpNsHVQnAyIHTIISQ4Hb6ByiLYcByeJFjdCiuBHUMSEs7g8
   E00vy3x3juLm5FdKvlz5utUm5pvKbw5zsoBGR6nMDTpzWaVZVfaFi4RRG
   6vll2FqJ1s6hYKI4x1aYuBBgIwHiUr1BFyC9J9HUMWsThXZb2qrl/Lvsw
   Vfpb4BVXYdo79DXSGbEgbQRCacnbiybfo3I33hsn0vblXctxTEykWD1i+
   zoxjpzEtfpqtXZSIKOu2PNqyLaAMIGx4V8cpHzTS9daLIlc/Ddl/2Z5QS
   w==;
X-CSE-ConnectionGUID: xJ+4IcItRHGZVGtO7L0vfQ==
X-CSE-MsgGUID: LYrol+0mQs+OeKQDs6xUQw==
X-IronPort-AV: E=Sophos;i="6.16,299,1744041600"; 
   d="scan'208";a="92595571"
Received: from mail-southcentralusazon11012071.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.71])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2025 13:01:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7vMzB5SD0WZR5oFPFmjZc6XC4GyrnKmFiSR1ECzTIsGNeuuEISL2i8/TouCLwp7a8/hpb4wjPrNaqN8VTS0rDqNDvU7OsB03R5DL+MCdAKzx7ILsLRTJkjauvdooAjLHV1xxg87f0QnI0xCEkWxe8yCedKJ4Fzq34h4MPsFVfZ9N6h0V8n7RUx098bEQXpwS5t+Nh68x5/DAFH0LaVLn5zGtpgzO80HwEMlm7QUMv5RQY5GJ1dxyGT1yLtXsBkGzNsBtscURzDfhgHbYoU5UzcO/CssUMDOoncPKQm3GQfbOJj+Q0G/DGQzFxNEV6E1g2EhQxb1lk3r5oE631cfZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCCGxzGXgaMZP1YtrpyUekRUTxnKbQWHvnKvEWoitl8=;
 b=bwhcthf8d+ygFUPcj26T49qwK0g4UgYaQPjYWAjfvIulkp8eLFHBV0aLLUucUVNpii81Rc+fH7CV+k9aGaBcuD9Dy4Hn94uierryvLyY5y+1HYqBGyY5m9nN6oP4Z0SSwNWcK3Q3iD/lH4wtvtZFjPtyUY032NLXekfIaQXNJRKrHTxAr6YeraIvJwjDLK6I/Ew/R1qpppSvoGYmATnsDAUrBdQn8SN7a6cGgiNAZSfyaHXrd1tSgFLNhA08vjkSMoDod5YWhWSyr9yocXdTALbkTrMNII16C0md8XO92BDRvUNpuJlsoeRD6it1cihnXVYjSQKPpAeFmhIP3UXkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCCGxzGXgaMZP1YtrpyUekRUTxnKbQWHvnKvEWoitl8=;
 b=SDwikpE4M501Kfbkpff3fKr3qDrGfqRYjsYFRuM/ttz73Ioqy6GY9pNrIxN7kQUprd3jfcrCsvbbi5PNV27wmsR1YkRikNWmK9WdySjZIds+p/OMj1IXZM5CpH5biw3th8s4C+HAjQzk4/Y9ao9viXmitIMF0p0p0YAuF2F5hlA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CO6PR04MB8316.namprd04.prod.outlook.com (2603:10b6:303:137::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 05:01:30 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.8901.018; Thu, 10 Jul 2025
 05:01:30 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "alan.adamson@oracle.com" <alan.adamson@oracle.com>
CC: John Garry <john.g.garry@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2] md/002: add atomic write tests for md/stacked
 devices
Thread-Topic: [PATCH blktests v2] md/002: add atomic write tests for
 md/stacked devices
Thread-Index: AQHb7/zMUQ7F13m4mkqgF5JDLkAsm7QoS3aAgAB2YACAAg2TAA==
Date: Thu, 10 Jul 2025 05:01:29 +0000
Message-ID: <djvvzndvrpk2mqchs2c6ykv4rqqxuklvkd676uqk3xq6aa3vrx@ceacca5h4dqc>
References: <20250708113811.58691-1-shinichiro.kawasaki@wdc.com>
 <37df2f62-f5d2-4d6c-903a-de56a6ebc6f8@oracle.com>
 <9a425680-3bb5-41e6-8d3b-89ea63916fb6@oracle.com>
In-Reply-To: <9a425680-3bb5-41e6-8d3b-89ea63916fb6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CO6PR04MB8316:EE_
x-ms-office365-filtering-correlation-id: bebfc2c2-c4bc-41b6-9435-08ddbf6ed528
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Rh0XByyZWn4KlLpVzVGOYjJJqfUPkXUneeoRzV9K1ln1bLc9C5AH0kRBkJ?=
 =?iso-8859-1?Q?uEk6cYM38PsmhOEZadKaU5gJPhwO21FGMGWLPVgykCqittPG/UGo7qc+gz?=
 =?iso-8859-1?Q?+4dtD+DiHk4BjpnQNWBNDCOeVNlBzyYJ05bYEQmXo2jeV+ZVbvdhA94WG5?=
 =?iso-8859-1?Q?KQ3F8hF19Vk6Y6tfLBVSXkUORlGfe5P58c11Uk83fBhURVePIE+EtKvr0B?=
 =?iso-8859-1?Q?K5YSFyo24Zyv1ko8mM1a3YbjdmIdbpPUpLjPYpV+c6JhMRhYiHg8EGozgO?=
 =?iso-8859-1?Q?rSiw2N58BXIcYaOKbJWE61VdWIln9x0LC3nbvOk68ki5HolKDbiF9Il+oY?=
 =?iso-8859-1?Q?No8+MDyqrIYVN4Rg0k26dNZdsfAiqOO79RrJtIXmWCPgcyJIFuif4TVNIa?=
 =?iso-8859-1?Q?jjxIvYan/b52xa3uGWF5F9UsSbfd9vvAykyXA5DqOypaEdIS1YtJyrDWre?=
 =?iso-8859-1?Q?fyPMF/9/N/tgEzQnlecvszyiAbqHhMSvmf31PWVH1rgk+0TJfz8B2ZRjwf?=
 =?iso-8859-1?Q?pDTz4DS++K+tuZTgYttUEe8JPB9UcsUSCnm1z9P5la0RgLKxqMBVuOrDRc?=
 =?iso-8859-1?Q?0F2DZOeSkSOMssgOS/Oe89AM6EXWGKEdCweCfmlPsXSCHB5Mynz+1xyfxC?=
 =?iso-8859-1?Q?Bj5RC6kRQ7+hk0W9Xgp+AjIkai6yItqTcqJYDeGd3th284lFdxONEgONum?=
 =?iso-8859-1?Q?CitasOkF0HRXM/50Qbvv4XbOk+xc1fMEFICPyCy0jisH7wuqjCAjsppH51?=
 =?iso-8859-1?Q?RPaIIUKWPmLidvL4+mAzIplYxMBThAJP2kYR0aYIeAdXDWgrNbwvLrBzzX?=
 =?iso-8859-1?Q?+dA3kpsMNq1bBJ1sGDkjDznOVg4+CweKF+SPqmtq8kVIlha4AIb606VB7O?=
 =?iso-8859-1?Q?ZnNz5kX5QKzuFB6SZLXWrTcTkxMIwWgdO8X4kyajwQlf/1Kpw2DYzwW+Ai?=
 =?iso-8859-1?Q?SEHvKottLDSBdH0d24z9qyrzTQeIsru3toUO2VayiDsvEvnEduZLTLpnka?=
 =?iso-8859-1?Q?p9TP6nzo/bwBTHhoLScspmHzXr9qU9xRMBPEkCYEg1SdLHb0ADcpdlwdN7?=
 =?iso-8859-1?Q?MBA0/TiIeOoU+bPhPXnvlINEoieihzYL4ESJNDuOOThChTKpFMcwysUFKQ?=
 =?iso-8859-1?Q?LP5J5o4TV1XZY/YJr3HSstzYPkdb9ELftXJb5lt6FvYdNr2weN+m/8Loy2?=
 =?iso-8859-1?Q?a8aA+74Ojf9HsA3na0pOxsc2RqlJPUztVhS0cM1w5k3GTTIHlQnrRxWL/Y?=
 =?iso-8859-1?Q?65575+GcIHAXSQVZqcU6o4EYDML6p3+p4fCEkS1VMDKQ03nLX23Gxqqf+a?=
 =?iso-8859-1?Q?b9yi0quq5WBpdIKBFYseW2ar2v16H16UDKNaUenZDxkXtWI0V92tIiwDT2?=
 =?iso-8859-1?Q?zcuy9cH8fOHE03lgy2cAh78V2Cl4sFgPKaZjgteZ1SYt1whjZBOA1+KOUL?=
 =?iso-8859-1?Q?egIxVNN7nAL1kGPfwqwysMC5zE0yEbpDKYYyNd/Rc43TdVpc2HEZulUUh3?=
 =?iso-8859-1?Q?ww+++IZu9F/DrYE8+kiMyj4mDbW69FTbSc8tnq/x2Z6w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?IDFswHT//63pMEyizL3EyUSo3EeyAnS7/BJUau9N+uEzkPiHQWD/P8yGl+?=
 =?iso-8859-1?Q?gJqmbmVvEu4p3C8/tBX6xTXv7OZb0iuUdBAieH3JrACGQYde1NgDtdIclX?=
 =?iso-8859-1?Q?ZvL1qYvi7HD97EnuHIAOnbswxbK//NBisn8Yf31aA6O0ejcl5rzsz20SfZ?=
 =?iso-8859-1?Q?9hcPVuCIRPf/YGgrHqwRl2EK+6JZaQbRIb1WfZWhil2VLQJKHZzjJRxy+S?=
 =?iso-8859-1?Q?gdFX+7Zhy7ibhzuSB17e7KCjcmQviHlVgEZJC1FfX3QAzQhqyBLxekuQev?=
 =?iso-8859-1?Q?ofoW57fCVViNmbLQXGFJ9lxExQcqaXrToHwOUlrQ/oJZmcZSIIvO84yvfY?=
 =?iso-8859-1?Q?FOb4YAFz7JReMbgvo/nk+3tRXsV3uAOx11/MTDSda9lET/NIqGUeIEZt57?=
 =?iso-8859-1?Q?RbXU9vpCTk0V4nFN3d7EyeQbgfRoMoOiKvttZsUJT4xu81fRSECPxOyAPC?=
 =?iso-8859-1?Q?8qcz/1jxyxXqu4lyuNMYuNakGeIKhHXfnxvN2o9NNOxnRycMf57NCaaAqh?=
 =?iso-8859-1?Q?UlfhAVHMNgZGDqoXnDBzRGPZ8R2eLjrDCjW1DGeCqY7IMA18HjH2IbqcIp?=
 =?iso-8859-1?Q?PxibC0ZSauCoI8OFpkMULWD5z9NUQ9CaiZLbsn3GS2k80/fcdadA0LTcjc?=
 =?iso-8859-1?Q?Ig98L+UwzQSa10ZbJD38K1iN940cY7hXSJBYg3pyyfF9PQ+j7xjPJb/a52?=
 =?iso-8859-1?Q?NxqqF7OdGQsql4OX7eZRcuSLnpA6g2Sp29q/YjpToqCrgc66Dvfm094eyV?=
 =?iso-8859-1?Q?KEwgIYey+v2nLLO1Rz8L/IgGQfSFuRCwHOpSzrovc0+M6dFz2SIx1J3BMn?=
 =?iso-8859-1?Q?tflRtOtfe3isEIz14NUbke6HJ1hkPYdrDSFhqU0Iiz1ZnHs9704/8ss+wP?=
 =?iso-8859-1?Q?JwVaOOR6qHpfy7sZmQkraNA+dyDonJx0GUKWERWKIrJkTG+ABC+ZMn7CCZ?=
 =?iso-8859-1?Q?tzBJwgp4LeyXPOTWCdglGSA6+Mfd5IzMqzSf/mJVYcIPeGK0wNeHcD+QoK?=
 =?iso-8859-1?Q?fpewYKhKIvtBnIXRW9gf/nzP+9nwoMvdehglKjDCNje62FE8mcRQzTdozn?=
 =?iso-8859-1?Q?nAL/GNwwUaIcHC/5mdOEt4LmbQBV29N78fc5eZK6mBqBj2wRNiLn9E8r5p?=
 =?iso-8859-1?Q?5pjjILQU2y6RjfCzPg02gpLXnkHVNkerpGaQ71kmhRP2cmmAqFEpu6gVZ2?=
 =?iso-8859-1?Q?d1ox+uO5uuDGcsIBq3Nbk7HVAOYFMVwTjY2iu8Ixntrty8FGbR9PwVfKRk?=
 =?iso-8859-1?Q?eiKlbsajHAgcWAyX5yWHFSWeNUIT140xOCdEwCRfTQ5EXeZUYKgB8Y5ZOR?=
 =?iso-8859-1?Q?Y74L9AkHqvw2ONxJgl391n/zEIEFDePC5Mgpp7a455H/cyMpnzZJ1GFSF6?=
 =?iso-8859-1?Q?V3zOoT5qR/NWIIahMj2zR33pwJqxu3aOt/yspZJbSdvwDMfcXLGTwyYLVf?=
 =?iso-8859-1?Q?sVckMTY/L6tehBk2wvR1xDBeCP1zXwaEXZuyg4QlSCb0Zhb79tMNzgz+4M?=
 =?iso-8859-1?Q?x05R+70IDycE+wObAitvHvoP2nXbYH3aCByV2lNgA1xFSZ63VvPoVjjqe3?=
 =?iso-8859-1?Q?GiSD4aOLL/gNJ120x9r624KPy/4QEccaXILwbPfMqLP/2F1MYmu6wTxUg/?=
 =?iso-8859-1?Q?3vwF8nwgN+hF8l2wd1TG8+h3MFaBvxdBCfIY601BMEEus5WbMAs3QPZQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0B6D064540187D4489AA5946926F9C33@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pRB1bSDxJ85QWz5o2YofguaK7fLvBnEDe5ltcNlVGQH1EoKx9I22pSUJ4dKF6SzkAiEAqUg40uXdptrjw6d39H1u+9AfhX9zcNcH6KLvCg8+CgDjE8yziKRZqbOuAWKT82lZRr9xs5GV2Byd2KPCXZuroW1NgOldZRfNpnZgg/GDbteeWBhTYBksBQmpnaZREw2lcHabm1OTCzvmjGsv8cXQruTAP6DEzVDBntEHoRwzuk55GoFHhQYJS4Y9PaiLr6f4oz64pTfcSIpjYFy20OcymJ74/XGhaNYsCv9hL5wf0QF6q+EhhcqOFQNiqziFuWZgzVjAVhqUUy5BZgmPKnJi2Yg5kKujenPO7poenlywyza/+smu1MiwoBXtg8uGRHaGGy5rg5/bifUM364CAeOUZYUYdMC7jMxrWXcPvRAZpTdGastbVJxGZhmRApI2zxZi0V/8LUaQ2LpqJ4IoA4P+rSrV2Ql30qcyGHyY5ZAHeICW52IpCJlByS4akLrqRTLvNxxFHMxe8lqX/9sIzGRIYpj5Ea+/INI18WwnYNLnCetAFMaj9tFPJLKCDm21V+suyCGFPRPrXym+dfQZziCwcEJTuOmycuLvAHc+K2512mOdEUTA2XnAwDgD/pt2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebfc2c2-c4bc-41b6-9435-08ddbf6ed528
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 05:01:29.9426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZJNrFGISJk2w+JpPzWAgG4aCYTil4sFGCp5UUV2bdheNqfwuBX02kLZXU+hSYAIAqJjGnttZ2DRoA21iJuC5CIjUeS5wzH196r+UG/70CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8316

On Jul 08, 2025 / 14:40, alan.adamson@oracle.com wrote:
>=20
> On 7/8/25 7:36 AM, John Garry wrote:
> >=20
> > Just a small comment, but regardless of that.
> >=20
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> >=20
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 md_dev=3D$(readlink /dev/md/blktes=
ts_md | sed 's|\.\./||')
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 md_dev_sysfs=3D"/sys/devices/virtu=
al/block/${md_dev}"
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 md_sysfs_atomic_unit_max_bytes=3D$=
(<
> > > "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_desc=3D"TEST 12 RAID $raid_le=
vel - Verify
> > > sysfs_atomic_unit_max_bytes <=3D chunk size "
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if [ "$md_chunk_size" -le
> > > "$md_sysfs_atomic_unit_max_bytes" ]
> >=20
> > you should also test that md_sysfs_atomic_unit_max_bytes is evenly
> > divisible into md_chunk_size
> >=20
> >=20
> We could do:
>=20
> diff --git a/tests/md/002 b/tests/md/002
> index e586daf..215d672 100755
> --- a/tests/md/002
> +++ b/tests/md/002
> @@ -226,8 +226,10 @@ test() {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 md_=
dev=3D$(readlink /dev/md/blktests_md | sed
> 's|\.\./||')
> md_dev_sysfs=3D"/sys/devices/virtual/block/${md_dev}"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 md_=
sysfs_atomic_unit_max_bytes=3D$(<
> "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_=
desc=3D"TEST 12 RAID $raid_level - Verify
> sysfs_atomic_unit_max_bytes <=3D chunk size "
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if [ =
"$md_chunk_size" -le
> "$md_sysfs_atomic_unit_max_bytes" ]
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_=
desc=3D"TEST 12 RAID $raid_level - Verify chunk
> size "
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if [ =
"$md_chunk_size" -le
> "$md_sysfs_atomic_unit_max_bytes" ] && \
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 (( $md_sysfs_atomic_unit_max_bytes %
> $md_chunk_size =3D=3D 0 ))

'$'s for variables are not required in (( )) arithmetic operation. Let's re=
move
them to make shellcheck happy.

Other than that the suggested change looks good to me. I folded the change =
into
the patch and posted v3.=
