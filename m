Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC01E0E14;
	Wed, 18 Jun 2025 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228382; cv=fail; b=FV98HNklSKOazspdWB9ZPpfUUbptPf/X5xw2tCy39nrsGjHSDaNb5f5Fcl43DIN6pKP0YMqmj6SHRuOfB/m2vvdobHjryeILdE8O+c2hICEzIL+udOQGxT0041cGe0GPk6aAynl+KrzitACkrRVrjM70/UxDyXCsjmhnsyYsDBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228382; c=relaxed/simple;
	bh=sgB033a2UJoCFPj3LRB+JrqseLZIVq1vAKYTaIs+8uk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pKVJ7Jqf32h8HG0PacrgOvOZhcfrkHXH1e0lEaCRfb41jM/+aEnMHkGhElQNR5hNUSOTfA+YebrxAeydcUsSA2pmMplPhV/Dgt0ER3wqVL15ewrJi9VNXurbmQ1Ccq67yn6Fy4UF/35Q7pynaPUQzDj6ENL1Q1eKWu8TxMdg9UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nH4g+BxB; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eiXi97+7; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nH4g+BxB";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="eiXi97+7"
X-UUID: 0d5cff7c4c0e11f0b910cdf5d4d8066a-20250618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=sgB033a2UJoCFPj3LRB+JrqseLZIVq1vAKYTaIs+8uk=;
	b=nH4g+BxBJNZ9MX6pTFxOfg9iJFEy7TDS7D5JUHHY+arAvXqmyScxs4Se7wBy02196gAj5sXAvkxac9WUvPTX81h7bV+6HjJT75kY/Bi0dxZ7FKRfCGicWCNr0Ehp1GbuAwtwgGvlyXz30qph7Odd1n4g4n3Id2Jg03Au4IIi+Ng=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:e51ccca9-c074-46df-a4ad-c021777de52a,IP:0,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-30
X-CID-META: VersionHash:09905cf,CLOUDID:0356bb83-db76-4e00-9dd0-5c1455b2676b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|110|111,TC:nil,Content:0|51,EDM:
	2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0d5cff7c4c0e11f0b910cdf5d4d8066a-20250618
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 907110205; Wed, 18 Jun 2025 14:32:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 18 Jun 2025 14:32:46 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 18 Jun 2025 14:32:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMw7MAR1hjYozuEjbRSzI8AdcEHHTA3iIzaciBkle2Cxj/Jfhp0EgTqH5np+sNyC4ZHwH/9UqPPkhQudCXlTItQ+aweDuuuy2T8JojwXr4SAYAbgQUjFBeBDBw4RQSC1+v/C8+Rd6SYuVUFtWoU6/ttn9FO0f9023G+07M6UF67+MzjcoctFlEOSqEC8QQjSNHUPybYJ2LvH9LyFEWbUmEmcxYsf9YQAFfo2s0qQLrS4zCFiXtWb2hKSrSbF6+2raKfSCwh6ovJGZTvJIPnDvImSabk7fL0f5feLlWfabkyVg5tZgAN2NwVEFNRo5WrhmYfTwPW8HRJ63qRPPHqrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgB033a2UJoCFPj3LRB+JrqseLZIVq1vAKYTaIs+8uk=;
 b=I9KRmAhSy2P0s4W5hEyy65s9VJsImzV0gFDlBRG4WuJdfMdOo2If3BxQLjaOds9t3kS9EViyeICzj8c0xvQBJ4t9bLWtdWKwNTujlv01ujENfmGH0hFhaT+gfp7IiSNnGf08plwhUonFFR+2OsMT7WLrT4vs/tbT1ld8gQ/EJyP+jUbS2aG3WtC1m7dGtjHe1on10FMkpU+6CrXklPZUSLRFktjgNp5+3gdw+4HNbL9eNsnevDEg8imc+xlltJJC4Na6/iZy2en4vRKz4gzukbbKnwWyRA5pdCFJsQoz8jmJa6sFyFxE81ZTVRI0MMVY6zzXRhXtaAC/HGCnzEIKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgB033a2UJoCFPj3LRB+JrqseLZIVq1vAKYTaIs+8uk=;
 b=eiXi97+7FQMlQvDcm7Y/Y+UZ6HIRrk6a1LQ1nH5lkjSXnIKpnDHf8y0tF+vToyGYCZ4xYixXos7j0AR4PRbcHLSC+LtldgNCJRJEAfCA66mfCidjbzw2MdQQgucOoKi2nIN3/qAs9cqjlP+0fJ2mjaZZBkdpZTHLWsOEXLVWP5s=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 TYSPR03MB7884.apcprd03.prod.outlook.com (2603:1096:400:47b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.22; Wed, 18 Jun 2025 06:32:45 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::8b7a:97d8:96f4:2e6b]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::8b7a:97d8:96f4:2e6b%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 06:32:45 +0000
From: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "chao@kernel.org" <chao@kernel.org>
CC: =?utf-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= <Chun-hung.Wu@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: f2fs: possible circular locking dependency detected
Thread-Topic: f2fs: possible circular locking dependency detected
Thread-Index: AQHb4BrNUahTte1Mckicu1+PEqxXVg==
Date: Wed, 18 Jun 2025 06:32:45 +0000
Message-ID: <94cbae37522acf30ae30d8f42d8b2d9d62c0c18b.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|TYSPR03MB7884:EE_
x-ms-office365-filtering-correlation-id: 92d85f85-f173-4ffc-0bf2-08ddae31ef87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MkJkb3M5eTYrbFlVbnF3amFkZHFDelZsYUkyOW9pN0tVVThSeU1CRm1lWFpE?=
 =?utf-8?B?a0FDT2FqMDBRVENnODFic1FRRmJkSkQ2UmtoS3ZURnMzSklBMkxUQ3VWaTVh?=
 =?utf-8?B?NDdNMDc3TkhrWnA3eUg4TTk4WFJXcExEMnUzelVrMzZuOFUweGdwaUhFUENM?=
 =?utf-8?B?Y1RMakZ6bVNYR0k1UVJ1OEFGQmJyTUlBdHdaK3ZPSWI5WUxPc2lVVWlCKzA0?=
 =?utf-8?B?Z1RoNVROK0wrMitjNHJCY2x0M0NVS0xKNVJpUzFWYXdPRFJ2VUd0WEFJa0FL?=
 =?utf-8?B?NW85VllhQlNwc3hPVWhaaFJIM21BVytLRWdVYlZSUTVVeitqTkhaVUFuM1ht?=
 =?utf-8?B?OGdRRWdYVytpTzNrZDZyK0hlWVlnWm5yelN0NmFOQjNkL0syMGErbTk1clFD?=
 =?utf-8?B?MU1PTG5mZ1dHai8xbHZ4aGU1Wi9LcGd2ZHlaQW5rSkZyclJGa2N3Ry9NV0hB?=
 =?utf-8?B?aUo5aldKajFPYzJtMVo3NGhpVlRXcVhBR0IwSE5DWml3MzYzS3R1a2JVd0JM?=
 =?utf-8?B?TVZaSU5odlh2N0paZ1UybjFjblpWK1o0ay8wVmh0aTNzNCtIdVo3eDRaQ2ZI?=
 =?utf-8?B?RDdjNXdyWnUzYWVoeTFISjJVSi81N0EzbTBWOEY2dWloKzVvUjZOellDa1Rt?=
 =?utf-8?B?bjBSZElPZzVWTGN0QjdKVjhjOEx2YnQwMG1uNzJzb3RERzNFY3lyZUxyeVVq?=
 =?utf-8?B?KzJ4bU1zTDZlZ2hYelpZVk1FTVBNNU5NZXovUGJzeTNiRjZmTmxvNyt4VS9Y?=
 =?utf-8?B?OGVQanpja0Z4STd4RkZXOVV6U3JZQmtvY0w1YmU3T0QyTXFpQkxwQlZUKzEw?=
 =?utf-8?B?VlNZM3JTU0l6ckFFTTBKOHJsdEU3Zldmb1BEN0VrcHRNdzFCeTlNeHBZVlJm?=
 =?utf-8?B?OFVMUWpzNk1jRlJnNi9QQlowaG9ZdnJQVnoxQ1lENEVSOThmZjdLVXJrYmpp?=
 =?utf-8?B?NkY5M3pLU3ZPdFhpWW1mRzVSTngzeUh6STVzMWU4cHVBN2ZzcG9iSmUrL0pq?=
 =?utf-8?B?L25EaGZ2STdyNFQ3emNzNG5vNjdJWHlFWW9nVVNRTEd1Um8rak5Ud3JzOG16?=
 =?utf-8?B?WlRJOHh3aGV1cWJjZEZFSGtMZmdIMVRESndxaTZRZ1hVS2M4WHNaMXBpczRq?=
 =?utf-8?B?R1NhaEUrMURBb256ckprdkZvOUYwTWhQWGdTL29reWxNaUNUSkVodGovZUJH?=
 =?utf-8?B?UzRpaFo5ODFtcXF2NlV5c1NoT05jYWdYQnI4YnhJMFN6N0t4dEFXczAxUzN3?=
 =?utf-8?B?SHdMU3p1dG53NUVsdTNJSE12Vy9HTENiUHlBZ2k4NXNGaFFDR0NpaEVkbnBQ?=
 =?utf-8?B?RXd0UmttbU14eWsrUjdBMzdvb0ZWL25lTVdJOFZNMHRpelBueDZCdktPaTg3?=
 =?utf-8?B?cnBzUWM5RHk2Y01kQ2RMQTZFWTlhZDJ6QS9mK09TSEw1dHhSbS9xQWUwOHZU?=
 =?utf-8?B?SzgwWUMvWis2OHJ2SFdqemdmWkxIZkJ5NWZXTkFOUU9ubXFoWmdXZ1lYa0ln?=
 =?utf-8?B?QWloeW4xdHUxdVp2OVE4V0dLa0p2Yk5YZG1ZdVhzSDA1eEZpbzRrQUFJbFpl?=
 =?utf-8?B?bU9ZK09ldlg0MFIvVG1LbWZNeEpyZnAvNnVYelNqTW9UNEsyY0R0aU1BL21Y?=
 =?utf-8?B?ODFqWGswaW96TFYwQjY0ZmphcnRkQWNnYm9HVnVleGs5U3RYdDVZSDI4V3I5?=
 =?utf-8?B?L1pDQVBTTk85S1lpQTFCRjkyWjJFcm1tVExOMEYrQkJ1NHMzT252ZTZEMklK?=
 =?utf-8?B?cUhrMjgyb0VPQXRQdjlKdmhZVGhENjNUdkZzZjZ3dFIzaEQva0x3bWd1eUhZ?=
 =?utf-8?B?OVRxb0xBa2luaUxCQ3FqcFl1R09pRjFxYmJIRUh1aG5OUGo0VFRPVGJRbEJk?=
 =?utf-8?B?bkxxUHZHc1NOTGdMUHFWQ0RITWFQNXU1d1gyZlNFYUh2RlNOa2NmSk9Ja29N?=
 =?utf-8?B?aUVOT0ZPQW10cHZSendZSU9EU2pvK0QzWm9FbHJibkk4QVdieGI4ZmV1STlz?=
 =?utf-8?Q?6gUdaHgeBzBJSC2kmb0P+7fKLPssQQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d091QjdpVFQ0QkdKT0FadTFxUmRPZUEyNkxxT0hXM2JkdW5JNGJSMU9qSW1w?=
 =?utf-8?B?YW5XSGd1d2xCenR3SWRVdjc1azJTaU1wajFuYkVnZnBpc3Z4TmNkMGJtc0hs?=
 =?utf-8?B?SDdrUkpDczRIODduSG9ENjZabFhUazgvelF6Zm5VNGZTUEFHZm9DMnYyT2tp?=
 =?utf-8?B?K3lTbzE5dXNpQUc2UHBFOWh5WmdUS3VpTlVnUDR3SytnVUYwVTBjWmxmK0Vz?=
 =?utf-8?B?Rk9jWHVIdS9ucUVkTWYvSldEckRZWURpVHV6dDM5UmZvMGlibjJha2d4dm15?=
 =?utf-8?B?RG9NV0FVakEvODVxQ0VBQjl1bDJYUXJNT3VRc3ZPRlhYYVpFY3B4N1lFNjZ5?=
 =?utf-8?B?Q0tFSXZKdW9kaWhIV0dPU3pDdXBxMFRac3FzanMrRHZYMHl5VEdFSmk1K1Ni?=
 =?utf-8?B?SnFOVEJUWVRwNzEvQmZpZlpBeVV2WGJ2YUtuNWorOHZRbkJwK1lwTDdLeUJk?=
 =?utf-8?B?bXFUR2FBTFRWTjNYQnU2MW5DMm8xRmpRUU1wbHp2dGU5OWxVWUF2bTB0ZGNW?=
 =?utf-8?B?VUVRcjdUMEdqSEtpcTFsSldCbDA5VmZ4RU9DbUl4YU1LYTF2WFlMOGZDZjR4?=
 =?utf-8?B?KzlpdlNVemx3aTFlWVIzWGhaQlp2TEFMTlBpNGYwL24wT1ZucG9FV21OdzBa?=
 =?utf-8?B?T1ZqSmRuSVF0b1RMTGhRMFQyeEZXUWZiQkx6VUVLbHFXa3QzNG14U0M2Mksz?=
 =?utf-8?B?QkkzY251S1EyRUFIL0lXK1dManRydnYxWDRNL2dsRDBFZGJDbmhMUEN0RENI?=
 =?utf-8?B?WTloSm9xZEpFMjRNZlBBcVFzNGlwYWlHMEFjS0pQVCtFTmZ6TGJGb2dwL2M1?=
 =?utf-8?B?dFhHNGRkVXYvK1RsN1NlU3Zrc2JVakJBUnJPM1pSMDNWWVRkcjlHRldESGFt?=
 =?utf-8?B?UW0vMjd5Z1NXMjlKcTRmRnRVVlJYUzE3bzhYMFpZVVh5S2xybU5VaGtWQWJF?=
 =?utf-8?B?cENlSEVPeFpHTUE2VWlWNjlGQTRNUFNGMWJJU0VSRFNNRTlnYTRnSTZXVUN3?=
 =?utf-8?B?cDZKNW5mVFA2cTc0d1dTN0QyVmNSeUE5dHpvU3ZKdDBxbVQ2T2xFdUYzU1pm?=
 =?utf-8?B?TzJDVE5EeElSWDlQWWZxU2YvOE9OcGRFNThHT2lyNW8xZ0xvZ0FsWG15QUJH?=
 =?utf-8?B?RHVsUXl0SCswQjQyNi9mN3M4ZG5BNVVQOVVXTmhjNWpBZHkzUEUydHB2ZHpY?=
 =?utf-8?B?eHo5REdYQzNjd2VPQXZmQVZsWEtud3BDTWdRUk93dFdYMUhwNTV0VXRuRnNt?=
 =?utf-8?B?Vk9Yek1iVTUyZTNCVGluZnUyUU1kREJQRkR1UFZvWEtBSDlkVDdHN3Rsb1M1?=
 =?utf-8?B?S3FUaDhLVUdjaHRXVXVnVnowRkxLUS9vbVVDSytSb2xBSFNDYXZ5ZHhqRWp3?=
 =?utf-8?B?cDl3aitiUTM2Q3BiOHFnaGxRVzFJV2FoS0d6eU9XK3NiVS9DRnRvMGp2Q2JQ?=
 =?utf-8?B?Y21yMU8vQkNDalk5azFTbTZZa0ZGZWxmR0dMQTRmUG1TL2lzY0NneE5LWVNp?=
 =?utf-8?B?c0cveFZ5d1BBMExXNndYeFFvcWxuZVc5Z1BmK2EzZTFzL0kybXhMUHRqRi93?=
 =?utf-8?B?SEJ4ejd0MjNxRWVnRGlMVE1vSlJlcWdGVzZZRXRXV05DTGFsaU5BZmU3aUZp?=
 =?utf-8?B?djVJaG9sU0I0RjVtbWdwY0ZVZC8vaW5oNEJaZVZQL094dnJmOWVIRmZGMWtW?=
 =?utf-8?B?RlIrNWptQmlZSkNCMFRPV2hQaFovbjZtaTVVTXorK3l2TDQ0SDNTSW9wcXpY?=
 =?utf-8?B?OGRJZVNJSG5mT0FTNlhhSzgrRjBZY3M5SUJsNjVmUVdTUWpZQ1BKVXhZQnE4?=
 =?utf-8?B?aEV5dE5oUDZHYXh5UGpXWkJsb0RiMjBrc1BvMDZ3d2tmclpkeHIvNGFhK2Ja?=
 =?utf-8?B?SklvYzg1U09mSXFzM3NXTVBKS2YrUkkzNUNHcjdKcVoxMXF5bUlPUmk0aEdX?=
 =?utf-8?B?UHJDYXFPSVdpZnNpQ0tsV0N4bDNhYWs5SDZtNTVDQnJVSTVEemZlRmFQS2ZY?=
 =?utf-8?B?cmVsczMyYlRTS2crUlV2U2UwT0ZIOS9adlhRL3JKa1VURTRxM2E5aVh6SXNy?=
 =?utf-8?B?c05FMDc2OU5TYjduRksrNUpkSVQ2U0EyR1pERTdtY2xsVEpZbkJVTFJtUkVQ?=
 =?utf-8?B?cVp0Ty9DUnd6aXFBWUQxZGdZQ08rUGFoc0VWS2RzSEZnL3BqYnoxSS81aWJT?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66A0E24CB815BF47909B470333070F94@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d85f85-f173-4ffc-0bf2-08ddae31ef87
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 06:32:45.1294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nhxn3CBV+iGiafRkT3XmutvdAK6E/cDRIIPzVwMfoLP2wjwZO+YtCrlfDpzjPLGITtLFi3gljdLl0PpOoTxKzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7884

SGksDQogDQpXZSBnZXQgYSBwb3NzaWJsZSBrZXJuZWwgY2lyY3VsYXIgbG9ja2luZyBkZXBlbmRl
bmN5IHdpdGgga2VybmVsDQp2ZXJzaW9uIDYuMTIuMjItYW5kcm9pZDE2LTMtZzAzY2Y0NjQxZGVl
ZS00ay4NCiANCkxvY2sgYXBwcm92ZSBsb2cgaXMgYXMgYmVsb3c6DQoNCmtzd2FwZDA6DQprc3dh
cGQwOiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NCmtzd2FwZDA6IFdBUk5JTkc6IHBvc3NpYmxlIGNpcmN1bGFyIGxvY2tpbmcgZGVwZW5kZW5j
eSBkZXRlY3RlZA0Ka3N3YXBkMDogNi4xMi4yMi1hbmRyb2lkMTYtMy1nMDNjZjQ2NDFkZWVlLTRr
ICMxIFRhaW50ZWQ6IEcgICAgICAgICBPRQ0Ka3N3YXBkMDogLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQprc3dhcGQwOiBrc3dhcGQwLzk1IGlz
IHRyeWluZyB0byBhY3F1aXJlIGxvY2s6DQpmZmZmZmY4MDFiNmY1NjQwIChzYl9pbnRlcm5hbCl7
LisuK30tezA6MH0sIGF0Og0KZjJmc19ldmljdF9pbm9kZSsweDIyMC8weDdkOA0Ka3N3YXBkMDoN
CmJ1dCB0YXNrIGlzIGFscmVhZHkgaG9sZGluZyBsb2NrOg0KZmZmZmZmZDVjMzVkNjA3MCAoZnNf
cmVjbGFpbSl7Ky4rLn0tezA6MH0sIGF0OiBiYWxhbmNlX3BnZGF0KzB4ZTgvMHhlMTANCmtzd2Fw
ZDA6DQp3aGljaCBsb2NrIGFscmVhZHkgZGVwZW5kcyBvbiB0aGUgbmV3IGxvY2suDQprc3dhcGQw
Og0KdGhlIGV4aXN0aW5nIGRlcGVuZGVuY3kgY2hhaW4gKGluIHJldmVyc2Ugb3JkZXIpIGlzOg0K
a3N3YXBkMDoNCi0+ICMzIChmc19yZWNsYWltKXsrLisufS17MDowfToNCmtzd2FwZDA6ICAgICAg
ICBmc19yZWNsYWltX2FjcXVpcmUrMHg1Yy8weGM0DQprc3dhcGQwOiAgICAgICAgYmxrX21xX2Fs
bG9jX2FuZF9pbml0X2hjdHgrMHgzMTgvMHg0NDANCmtzd2FwZDA6ICAgICAgICBibGtfbXFfcmVh
bGxvY19od19jdHhzKzB4NzAvMHg0ODANCmtzd2FwZDA6ICAgICAgICBibGtfbXFfaW5pdF9hbGxv
Y2F0ZWRfcXVldWUrMHgxMzQvMHg2MTANCmtzd2FwZDA6ICAgICAgICBfX2Jsa19tcV9hbGxvY19k
aXNrKzB4YjQvMHgxNjQNCmtzd2FwZDA6ICAgICAgICBsb29wX2FkZCsweDE5MC8weDNhYw0Ka3N3
YXBkMDogICAgICAgIGxvb3BfaW5pdCsweGVjLzB4MTE0DQprc3dhcGQwOiAgICAgICAgZG9fb25l
X2luaXRjYWxsKzB4MTg0LzB4NDY0DQprc3dhcGQwOiAgICAgICAgZG9faW5pdGNhbGxfbGV2ZWwr
MHhkYy8weDFiMA0Ka3N3YXBkMDogICAgICAgIGRvX2luaXRjYWxscysweDcwLzB4YzANCmtzd2Fw
ZDA6ICAgICAgICBkb19iYXNpY19zZXR1cCsweDFjLzB4MjgNCmtzd2FwZDA6ICAgICAgICBrZXJu
ZWxfaW5pdF9mcmVlYWJsZSsweDE0Yy8weDFjOA0Ka3N3YXBkMDogICAgICAgIGtlcm5lbF9pbml0
KzB4MjAvMHgxYWMNCmtzd2FwZDA6ICAgICAgICByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0Ka3N3
YXBkMDoNCi0+ICMyICgmcS0+c3lzZnNfbG9jayl7Ky4rLn0tezM6M306DQprc3dhcGQwOiAgICAg
ICAgX19tdXRleF9sb2NrX2NvbW1vbisweGUwLzB4MTk0NA0Ka3N3YXBkMDogICAgICAgIG11dGV4
X2xvY2tfbmVzdGVkKzB4MmMvMHgzYw0Ka3N3YXBkMDogICAgICAgIHF1ZXVlX2F0dHJfc3RvcmUr
MHg4OC8weGYwDQprc3dhcGQwOiAgICAgICAgc3lzZnNfa2Zfd3JpdGUrMHg5OC8weGM4DQprc3dh
cGQwOiAgICAgICAga2VybmZzX2ZvcF93cml0ZV9pdGVyKzB4MTJjLzB4MWQ0DQprc3dhcGQwOiAg
ICAgICAgdmZzX3dyaXRlKzB4MzQwLzB4M2FjDQprc3dhcGQwOiAgICAgICAga3N5c193cml0ZSsw
eDc4LzB4ZTgNCmtzd2FwZDA6ICAgICAgICBfX2FybTY0X3N5c193cml0ZSsweDFjLzB4MmMNCmtz
d2FwZDA6ICAgICAgICBpbnZva2Vfc3lzY2FsbCsweDU4LzB4MTBjDQprc3dhcGQwOiAgICAgICAg
ZWwwX3N2Y19jb21tb24rMHhhOC8weGRjDQprc3dhcGQwOiAgICAgICAgZG9fZWwwX3N2YysweDFj
LzB4MjgNCmtzd2FwZDA6ICAgICAgICBlbDBfc3ZjKzB4NTAvMHhhYw0Ka3N3YXBkMDogICAgICAg
IGVsMHRfNjRfc3luY19oYW5kbGVyKzB4NzAvMHhiYw0Ka3N3YXBkMDogICAgICAgIGVsMHRfNjRf
c3luYysweDFhOC8weDFhYw0Ka3N3YXBkMDoNCi0+ICMxICgmcS0+cV91c2FnZV9jb3VudGVyKGlv
KSM3Nyl7KysrK30tezA6MH06DQprc3dhcGQwOiAgICAgICAgX19zdWJtaXRfYmlvKzB4ZGMvMHgx
YTgNCmtzd2FwZDA6ICAgICAgICBzdWJtaXRfYmlvX25vYWNjdF9ub2NoZWNrKzB4MWE0LzB4Mzkw
DQprc3dhcGQwOiAgICAgICAgc3VibWl0X2Jpb19ub2FjY3QrMHgzMDgvMHg0OWMNCmtzd2FwZDA6
ICAgICAgICBzdWJtaXRfYmlvKzB4MTU4LzB4MTc0DQprc3dhcGQwOiAgICAgICAgZjJmc19zdWJt
aXRfcmVhZF9iaW8rMHg4Yy8weDEzNA0Ka3N3YXBkMDogICAgICAgIGYyZnNfc3VibWl0X3BhZ2Vf
YmlvKzB4MjYwLzB4MmI0DQprc3dhcGQwOiAgICAgICAgcmVhZF9ub2RlX3BhZ2UrMHhiOC8weDE5
MA0Ka3N3YXBkMDogICAgICAgIF9fZ2V0X25vZGVfZm9saW8rMHg5MC8weDRjMA0Ka3N3YXBkMDog
ICAgICAgIHRydW5jYXRlX2Rub2RlKzB4NDAvMHgyOGMNCmtzd2FwZDA6ICAgICAgICBmMmZzX3Ry
dW5jYXRlX2lub2RlX2Jsb2NrcysweDM1Yy8weDc4OA0Ka3N3YXBkMDogICAgICAgIGYyZnNfZG9f
dHJ1bmNhdGVfYmxvY2tzKzB4MjY4LzB4OWE0DQprc3dhcGQwOiAgICAgICAgZjJmc190cnVuY2F0
ZV9ibG9ja3MrMHg2OC8weDEwMA0Ka3N3YXBkMDogICAgICAgIGYyZnNfdHJ1bmNhdGUrMHhiYy8w
eDE3NA0Ka3N3YXBkMDogICAgICAgIGYyZnNfZXZpY3RfaW5vZGUrMHgyOTgvMHg3ZDgNCmtzd2Fw
ZDA6ICAgICAgICBldmljdCsweDFlOC8weDQzYw0Ka3N3YXBkMDogICAgICAgIGlwdXQrMHgyNzQv
MHgyYzANCmtzd2FwZDA6ICAgICAgICBkb191bmxpbmthdCsweDFhYy8weDJkMA0Ka3N3YXBkMDog
ICAgICAgIF9fYXJtNjRfc3lzX3VubGlua2F0KzB4NGMvMHg2NA0Ka3N3YXBkMDogICAgICAgIGlu
dm9rZV9zeXNjYWxsKzB4NTgvMHgxMGMNCmtzd2FwZDA6ICAgICAgICBlbDBfc3ZjX2NvbW1vbisw
eGE4LzB4ZGMNCmtzd2FwZDA6ICAgICAgICBkb19lbDBfc3ZjKzB4MWMvMHgyOA0Ka3N3YXBkMDog
ICAgICAgIGVsMF9zdmMrMHg1MC8weGFjDQprc3dhcGQwOiAgICAgICAgZWwwdF82NF9zeW5jX2hh
bmRsZXIrMHg3MC8weGJjDQprc3dhcGQwOiAgICAgICAgZWwwdF82NF9zeW5jKzB4MWE4LzB4MWFj
DQprc3dhcGQwOg0KLT4gIzAgKHNiX2ludGVybmFsKXsuKy4rfS17MDowfToNCmtzd2FwZDA6ICAg
ICAgICBfX2xvY2tfYWNxdWlyZSsweDE4YTgvMHgzMTYwDQprc3dhcGQwOiAgICAgICAgbG9ja19h
Y3F1aXJlKzB4MTM0LzB4MmIwDQprc3dhcGQwOiAgICAgICAgc2Jfc3RhcnRfaW50d3JpdGUrMHg1
OC8weDE1MA0Ka3N3YXBkMDogICAgICAgIGYyZnNfZXZpY3RfaW5vZGUrMHgyMjAvMHg3ZDgNCmtz
d2FwZDA6ICAgICAgICBldmljdCsweDFlOC8weDQzYw0Ka3N3YXBkMDogICAgICAgIGlwdXQrMHgy
NzQvMHgyYzANCmtzd2FwZDA6ICAgICAgICBmMmZzX2V2aWN0X2lub2RlKzB4NzAvMHg3ZDgNCmtz
d2FwZDA6ICAgICAgICBldmljdCsweDFlOC8weDQzYw0Ka3N3YXBkMDogICAgICAgIHBydW5lX2lj
YWNoZV9zYisweGEwLzB4MTA0DQprc3dhcGQwOiAgICAgICAgc3VwZXJfY2FjaGVfc2NhbisweDEz
Yy8weDFiMA0Ka3N3YXBkMDogICAgICAgIGRvX3Nocmlua19zbGFiKzB4MmUwLzB4Nzk4DQprc3dh
cGQwOiAgICAgICAgc2hyaW5rX3NsYWIrMHgyMjQvMHg4OTQNCmtzd2FwZDA6ICAgICAgICBzaHJp
bmtfb25lKzB4YjgvMHgyMjgNCmtzd2FwZDA6ICAgICAgICBzaHJpbmtfbm9kZSsweGQ3OC8weDEw
OTQNCmtzd2FwZDA6ICAgICAgICBiYWxhbmNlX3BnZGF0KzB4ODE0LzB4ZTEwDQprc3dhcGQwOiAg
ICAgICAga3N3YXBkKzB4MmZjLzB4NWE0DQprc3dhcGQwOiAgICAgICAga3RocmVhZCsweDExMC8w
eDEzNA0Ka3N3YXBkMDogICAgICAgIHJldF9mcm9tX2ZvcmsrMHgxMC8weDIwDQoNCg0KVG8gZnVy
dGhlciBjbGFyaWZ5IHRoZSBzdGFjayAjMzoNCjB4ZmZmZmZmYzA4MDdiNzdiMDogbWlnaHRfYWxs
b2MgYXQga2VybmVsLQ0KNi4xMi9pbmNsdWRlL2xpbnV4L3NjaGVkL21tLmg6MzE4DQogICAoaW5s
aW5lZCBieSkgeGFfaW5zZXJ0IGF0IGtlcm5lbC02LjEyL2luY2x1ZGUvbGludXgveGFycmF5Lmg6
NzgzDQogICAoaW5saW5lZCBieSkgYmxrX21xX2luaXRfaGN0eCBhdCBrZXJuZWwtNi4xMi9ibG9j
ay9ibGstbXEuYzozOTQzDQogICAoaW5saW5lZCBieSkgYmxrX21xX2FsbG9jX2FuZF9pbml0X2hj
dHggYXQga2VybmVsLTYuMTIvYmxvY2svYmxrLQ0KbXEuYzo0NDc2DQogDQpCZXN0LA0KRWQgVHNh
aSAo6JSh5a6X6LuSKQ0KIA0K
