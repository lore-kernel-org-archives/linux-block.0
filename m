Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6E334676F
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827099; cv=fail; b=o/a5GvD+nkBuShNGBJirlDgk9vOZMjhh0m54htaCip4BlhNW3wol5CY0qb+EFUZzjovCmqri4Qq4lR0hxObEz6/8EYRyVWSawl67G7SAPuySlsmmKupsUlYVLWih+AOwxZ0g6YG2Y82GMrtpIfGeve5Aib3TtR3UU/jMbJ6b8R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827099; c=relaxed/simple;
	bh=NY537iWPacmxYZUvZ++BPil+5JUJWh8V6vf28zvYgHc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b4gKYx/rCnGdv5PHBphUFXG+f8bFDEs7Ja/JtuN3uPiGzRgoonh6OUiLOKUec3HrQw//np+dD8PzSYbw3pvB3IHZCQE91mHLZdqsXBo17hrl9s7O+O4tLBqda5ByONlfE7gNo8VwuuA8UR38XhiPuQ2tFpGFFL/W980vkmYw7fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZPQCMgdA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dqhQ+zdX; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZPQCMgdA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dqhQ+zdX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762827094; x=1794363094;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=NY537iWPacmxYZUvZ++BPil+5JUJWh8V6vf28zvYgHc=;
  b=ZPQCMgdASXJ1BnVWHZt/P+f7q81iw76x6u/qpx0flBdbt1VCZ/NGDJqS
   LDM+7MrXcOBcu7N8Ry2YOwCppXmzVOdDTDo5YzMEXUNmPw6+JSvsMzbNf
   HAYJzEZGak8HP0IauZTeHCYchE7tAAwfVLhhuKQ1FnW2yexOTRZbJ1yQv
   69dJjE4PrevEEIbPS/BkC4G5u8nQ6F9vdOkjRWOHVeosIHBb1tGibw8lC
   ZEkw3U81JbmOk0OREL81eXngHm9yGrpRRwWkxZ52aM/G0ZgI2DNSbz+Hp
   5/QiQ8EPEAVt0LHok/AmrRMalWS+Czi4JvIFZc2JvsVztkZj16dcP3dnh
   g==;
X-CSE-ConnectionGUID: Ta3id35zTTCemarbk3fySg==
X-CSE-MsgGUID: ws7PNMB1RqSWy9kW/WiBPg==
X-IronPort-AV: E=Sophos;i="6.19,295,1754928000"; 
   d="scan'208";a="134889511"
Received: from mail-westus2azon11010064.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.64])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2025 10:11:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9GwAtSCrugK6CFyUDmIw1lS9/4ednxhwosAOpDZ9NTnv8jE4/rQ8gUcNoWoALgRclYygiAUJrB73b7CKPY6S2VUvEomI2b9dvokDSBjQ5x43yDfjysom0yFR9EQ6dYj/a/WaGG27gQ8KdVkOjK9l80ARayqvv7WsYrTqSYB0f3Oq2mm5T3Oe5WR+NNE8eEDXEvAQYOSfbTgnyx+M/5rMKCIY1XTc8h75ccp6nk+OUJd4BUFELdB4QVXSFxYfSecpho4HRoB/5WhpGcCoPTsmp5MSZLcyo4etFtKQDaK1R7M4ZewIgcvTeLjh/f31xeJTfcvaMJBYeoHnZbF+1Ap/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NY537iWPacmxYZUvZ++BPil+5JUJWh8V6vf28zvYgHc=;
 b=nnomwsIyoCCTEI314Fsr+zti0AuWf1MHKMjhV+kZobVoK1bBDB8kIvp3ixTcoFQ5ae20ATB88nCZQLuCNVdEInu60XWwrmQrrHiozddqcHq0sk7KtN0WEeGch5pYAAofbTYyvqyaOLUomkG2wvzwsnBFZxPM1x8IXqDdUSQz+OOAhh8xUv8CJsgkGGy8Sc/MBnDZBhgwsDP35JKluCLzYYHPcwFaQgn69J/TYZwhxEHq+4KuKdiOD/8wY3xzzjUSjcFT+lagvSlH0LhyKGKU+Bdcw0Ajubi5iDC3309XTPBGXMDBnbz0WJ9EOwjwMSPjF9ndQqf76GdSl4782dnTMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NY537iWPacmxYZUvZ++BPil+5JUJWh8V6vf28zvYgHc=;
 b=dqhQ+zdXJFqx+IyDnU+DaA3rA9wJgQ8tX72EG/2Wzqr6U7oj6+N0jtKs8t0OW3nwurMyDo0A9uC/HvbZn1wFFfyar5DsfrjoRQs2vxzfb+j/AfXXR0//diGYQBTP9ahcMSuXppnlYGOgh2t1jJZnzoUEQyx9ROjRk4DY9mhLU7I=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BN0PR04MB8173.namprd04.prod.outlook.com (2603:10b6:408:15c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 02:11:31 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 02:11:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Yu Kuai
	<yukuai1@huaweicloud.com>
Subject: Re: [PATCH blktests v2 0/5] throtl: support test with scsi_debug
Thread-Topic: [PATCH blktests v2 0/5] throtl: support test with scsi_debug
Thread-Index: AQHcTI1gualxmmIotEa2v/LBDFyberTsx+EA
Date: Tue, 11 Nov 2025 02:11:30 +0000
Message-ID: <q5nagi4wd2zq2apg34gecalr35ev7wmfsgjhnt4cpud2wzsodm@imxolxx3w6l2>
References: <20251103064454.724084-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20251103064454.724084-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BN0PR04MB8173:EE_
x-ms-office365-filtering-correlation-id: 3f893616-22f8-4924-4c1f-08de20c7a18a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iJhDeReTrVTWjS519PWByv/O8kDAjdMZjaI6kq4EkgzhITV8kpEHt53l/7TN?=
 =?us-ascii?Q?VatMAiNveaxTWTG8HZ0Z3EFRO3c4790fly2zBVS5zWwZhSvYUR9bmTptwLM4?=
 =?us-ascii?Q?f+j1OpUHi9Cr85aTEkwsI1er8JATamMA/4b/oJXcvVtijqVnvo6+ufXhip+Y?=
 =?us-ascii?Q?U4IEj/I/WwRA0exZwcW99mF6A7ZNn9KbzoiG+6MgFB2bQKDp/e7F9bSAybA1?=
 =?us-ascii?Q?Biq6iNqtEnDTe4yMV0VLXkXIralsPqZqpOzu6aeH6zp4GC/cFLySmqVMr95k?=
 =?us-ascii?Q?nD7MghYjyo5Q5jTqUNbOLI5Pel5hY2m08tfMVMWD26j/fBpQolZ19JTipxMU?=
 =?us-ascii?Q?VLOmQ7D7bc6rjaMv9m5kFMJy8nXcWlJ42ESTUH10AEpmy4lovoyCqi/NUKev?=
 =?us-ascii?Q?8tMcw57XN4CGbRkXoGOMM20ZL/lYYRontsX3XU/xkRFoooWJNX7DWEpmXF1I?=
 =?us-ascii?Q?pX1W/wNFW1+plEzn2mtvi/la/W+h2wjPAiKMRQRhliBPwuF7Z+9LBE0VkKxT?=
 =?us-ascii?Q?VKZP+IXRARCx5Aqfjl6Vgqo7YdqZJ+pEBo1dleYrtgU2ju+H4RahZV9+Ptn3?=
 =?us-ascii?Q?SVR9Bti4SYlPCX7mXTUUJ/VAnZAnNPbxeQB6SBbUSqoDKLMamhqZ32/QCrUS?=
 =?us-ascii?Q?49EPhwsYi9B2c8NeorUbSa9ygbWzzPYiAzWxo1P8gPFTCfjqE3n9FzGTMxwb?=
 =?us-ascii?Q?jAYuZhx8F8vS9i4XcQGCqc/U5HIKkmD/HGy1dQS2OxFv1MzKDiE4FsoTij8V?=
 =?us-ascii?Q?w1U4GOQ/j/h35TJuRl13eRA4zE/3gegCEVJwqOfdT15cB7goeM3TWn5pMPsV?=
 =?us-ascii?Q?rpTc812sM7To3rq3m+TeE5fsMphiKjmfHWLumgL9xdRI1lEnSdsiUIq/iS2L?=
 =?us-ascii?Q?qbl/NnKUlVllV50TQkfPsVYh+WTXYuGgr5eEZIZYnuvgUeILBjO6H43KNWF7?=
 =?us-ascii?Q?EjrH7LMMy4pDMIRbRhm9DvSYvibLs3mVc2e25axtEUu3NCp+i3V7NnipNKI+?=
 =?us-ascii?Q?BiJP0pc9iEmGGrjb79xgLdrDdDqhZ/nwCi+RNxHLH7HsvZUgOMnQIIj4DR5H?=
 =?us-ascii?Q?dZB+Pm4CoT0uIymBGR/at1tNHK+2SAUDSG3TB+BmrHLXtuTqM3N80UPcByck?=
 =?us-ascii?Q?yhutvqpteBJ4OwtNSNspHYsYZYzaqss1cq+UwGoGRMpJ6XK6POoHEoE81pWn?=
 =?us-ascii?Q?MhteqAFQk6PwaM0E8+igmPYxcxbdICzAFNjrscna8R/NiZI7CJmKLRoEJ2BL?=
 =?us-ascii?Q?tU6RVUkJWRgKf0tpgU9Cku1S5ytZxdik+L0Y5ghHqqEeJoFvbnR+d/8hiU1u?=
 =?us-ascii?Q?Y/cWpu4OSQw2vPvCfSsornPQeZcistM4jqOSk/GT++UMPKiqJoF4jyZloSo6?=
 =?us-ascii?Q?8+baNfBpdQvQI47pKUbpBKKXHVF7XYbIAce5u5s0vMxlXGd/GpfGXCTu6sIS?=
 =?us-ascii?Q?E4/ZsOOhfShKwsvQuFGu83USP0wKQX10TNmYL6uRkUITNSL/0KOUEICXSroa?=
 =?us-ascii?Q?jqRwBC5zY/6VPA1nMUVSWEY20+aH8dsaKBAN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HhSTs3ET6kp6LPE/7A6XhUgbRo0euVMB442NfqqN3Y34GWNp8QvG4jFYNgJ6?=
 =?us-ascii?Q?YvvKOkyVe3C3hLqlSYQOX/iGK9xTPzIEIFbWmNcro/yarcvjmKpbFqAaKSXH?=
 =?us-ascii?Q?czWHJt0cOk99GcMB6Ya/pS0rFnnLKsIRSa7Y2e2t+uhT04zUckCf3mYb52F6?=
 =?us-ascii?Q?IPPNeCii4UByyu3aAbSlnzP4S3oNTGvjgziFC+hpw5iIBuRfjUK7IIrfPFbj?=
 =?us-ascii?Q?pp/WDvrp718U0JXueF0kBL+zg0/KdYyWfzRzBphloKxdVYXpWn6JL3d6ft56?=
 =?us-ascii?Q?g1Nl4ul0dKuhSufFP/xsxEK+zt47pkgg+B5OrbXmse5HV0cfmQ8sBvhRJg83?=
 =?us-ascii?Q?Vton0ydhjDd1NlHH1DKDS5ERCHFiiP5GxAqYi+wnNINfzUWURlLfHnXCPJ+t?=
 =?us-ascii?Q?XUV2bUaSacuSJRoNTIIp8Da62RfMRuQkoOdskFQl6ik+AkhtrOsBmenIo565?=
 =?us-ascii?Q?r3J9t2Cpjx1fIlwSNEKbMYcYTFfSEfbNOjm6GP50PI1sXByAkhynRolZMrUN?=
 =?us-ascii?Q?iKc2fn7p6rXyVzxj7bXJ/M6X////eyv90YaO+q1jopgvcYVCIzu6O3NhCQN+?=
 =?us-ascii?Q?TZY2yaAvfdgNFYiGOaKHJUVHSv07KTq4QLANlp6Ysi7OoGmClykBq1JkJNlM?=
 =?us-ascii?Q?WgJnarAGaKRjQ8qYx+3jE5vtB4DAbQfX6x8XyieVlaas7y7Ju0KhgejxTsid?=
 =?us-ascii?Q?QYo7X1SM+/vDujFyiXKadqo08P92vGGHkJOZuteGGu4sQ5i85CBDlbZe10P/?=
 =?us-ascii?Q?BgZ0ucvGBf202u9lwOazU4PmH/4L60W9/X8SkyKNCAov5ejn6StANPiFibrL?=
 =?us-ascii?Q?g2FqUGryUIJ8NE6UjrcsYhw+Le3wny1MKlH4K8psxWGXCHkQ2J7z27evIX5W?=
 =?us-ascii?Q?YctUVu5GS9LW8b/9H4bpu2LmRpIZkj60XSoETdKDVRFEARxcByKlvcvZezI7?=
 =?us-ascii?Q?rvwR+34519ARVBa9kY73IurnzGeGVciHANzeBC9OJRoZ9e2YVmvC8lfIpV1e?=
 =?us-ascii?Q?Mvqj9pD0pJG59B1kDcTbgtkAlb4wIv5hRv0rknnY8C+qIw5yGjbnuMfMh3Qo?=
 =?us-ascii?Q?FZlyLLV68GT1zAhbgCFOdjZIz2VbfC0O/Cx/m7Bqf4FM4jER63f8MM3O8e9i?=
 =?us-ascii?Q?S3y3o10yjNveqtHNzOgngS8zURc0g7W4bBXTMp8pSf44YKQlikLOv2fgv5Ai?=
 =?us-ascii?Q?EJkPcd8XvIfzEHsdyKCENf1Sp9mH9M20hNg294mNMuCnm/O2FzB/cc4AwlF/?=
 =?us-ascii?Q?hMhTxRAD5byXsoxioHsvKuArpvfIn9XEb9+WXhfRdv5wUhwgtRI14TV5VU2c?=
 =?us-ascii?Q?0o3zSP/ksMRRe+5wA8DfoDCSviCv2nXH1ATyYlFqyM+d9PXmz3rAVsZQjOJj?=
 =?us-ascii?Q?LXUbgCiiLTv1HLAIx3B3qw83Mj+fKYHw1e8Vj+l8pawcOlx2u5pE1CnAEwdT?=
 =?us-ascii?Q?BQK2bXAV9rotxxe98bQhUr/ECG/6uLN55/UcIyIM9NX4rtLkvJF+jUwFGIa9?=
 =?us-ascii?Q?1oxMSVaTZyvT6wsNqllXbciicK8ggwGjjqtyBpq6C9EOUJsO3tPqPt0ifMmN?=
 =?us-ascii?Q?HfO34f6dyNUobWfE4l+YjLBrOekUt2Vfh2FMZ2yfG60H5zZk5tgom0ESFrKQ?=
 =?us-ascii?Q?EXeAjaXkwM4eWkrvfzrimT0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45343CCD2DEDC048A6826FAD5CF09DCD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yV7IElQYqB8BZYBq9x4c+Kj8jek1jsf07RTP2xNpl4vg7d5Q0mfU9ToE7m+Fp6oaZS3IhE4zdQD+uQMQ5P1ItjxkIRvvEwAJJmlrHJ5lkl6+E5HxbfEDwALlLUwMOyyJBGXerH2KrqVnR6HGdoVKgrK3RnaYWj9GugMcW8ErnBjAbOIxFNs+Ju9vVzVxcyJbCRi1F25j47xsVOJZxMwKABGzH5jSJb/gVXQ+tiEdk13CBuiGf3WR1n9GiptZ9CQ59KLG4ovLVTIuVdo5blIiqmR+WBArvYxJXp3pYbhjGDh29lGV9/nyy4+AjisUzeYMhJFBtrJMudOGw+eWUpY+4R/gRZ+UAa7OHbtuM6wJ+16T8jOhlWvOd5ygvcG5bmlbHy+B8iSlS5BZYf6gk4WsWmNDcznV6XLLLiP6PVuWFD4ZzfdBVi1AuWCA8PgOxjGSqi8/Y61aZZo/AUP2Jq0+iSV5Bqmp4Oxgd545uCHoPcwQ5IKOn2CT1o5VNn8W1A/wUpohaPLY4cuq3vkEmk6P7lCxSEgdWBG0LvCMLq0mvcajvew976fFDT12tnFopFE8A/USsvCR/W0DfOeZubQrB7pI7rChHLFKpuXvEMG3O+KY5jIn93dHMrX2V/eqDngm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f893616-22f8-4924-4c1f-08de20c7a18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 02:11:31.3526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUo1H4XXo5m1Le0rrOlICy7OOnaeacpNxdwUoLapl8Iv4q89ySGyQM54k4Hl5tEjxG/y6lHuYqQ3tKdoDki7xGckrbn7IrYpZXaBRvLwtA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8173

On Nov 03, 2025 / 15:44, Shin'ichiro Kawasaki wrote:
> Currently, the throtl test cases set up null_blk devices as test
> targets. It is desired to run the tests with scsi_debug devices also
> to expand test coverage and identify failures that do not surface with
> null_blk [1].
>=20
> Per suggestion by Yu Kuai, this series supports running the throtl test
> cases with scsi_debug [2]. The first three patches prepare for the
> scsi_debug support. The fourth patch introduces the scsi_debug support.
> The fifth patch supports running tests with both null_blk and scsi_debug
> in a single run.

FYI, I applied this series.=
