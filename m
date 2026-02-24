Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE9A37C102
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939161; cv=fail; b=KyuIL6IhuXzo3pjMJNs774orIOXBJJs4W7bF0N8t+ffppNk88OCZDsS1fY+mWtt+P6HJ/6U8xM0YSWHU0LH2XB4Bkhm0Sad+r7gdRD6tTU5UFHgZ4CWljLdqxk7mPgi11ln5bwNGVCOYXiZ+Rl9E5GtJykVkGJ3F97AVHsZC1Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939161; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C+1DTGie1S+TKw6gVZ8R3r0WJ3NS4FAG/n4VPRlqGR4xSxs+dOmKoZ28xfb2oMu16gZjxWqeyY1hwMIiZYh98wKJVFuVXcGP4bOmQnPTsKXPL+cX8UA3tLr8ofwRpHLQCps+hxbNEoo8m9lkJgZfhDidwKSLNhsLIH+R7BQnybg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fpQLUj8R; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lCGq9Heo; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fpQLUj8R";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lCGq9Heo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771939160; x=1803475160;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=fpQLUj8RmdBppopt6Y+yllC9BWatM7GjEDDrpLDQAaV18iEwKaV3OgsT
   wrhODtNmDhWePs6fOOLtdLI1XKSZQg+sIUPYtnaL39B+AhKhhHg5IaNoN
   GGfqCHtMawIgItiTKnCdgLonhwmCCVv4LAIcWNBkmzIz3uEgTUUFBUs+1
   xoduXvKe5H2QWXE+jLNOn/EM6G8ef/n31XTsreKZgsrLsn23cXXBg+MM7
   5H4lNEyO33jCVu4KkeoWHo7XNhMg4mR4hHgPhus8KHFF3PEZy8i6pJlqs
   YQSGBna2rAxRKJSA7QgprVpAI1k+o4J80yt6qKMRr003k0PgnbqPzEMy2
   g==;
X-CSE-ConnectionGUID: 3bMoFR97Qk2vdmHEwHivng==
X-CSE-MsgGUID: /F1/xePpQX2JhBNojdHTdg==
X-IronPort-AV: E=Sophos;i="6.21,308,1763395200"; 
   d="scan'208";a="140393822"
Received: from mail-eastusazon11012031.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.31])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Feb 2026 21:19:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uO7a8Ng9AJu9u3dvYD5LzeuRTjWXiR+T8ElmCp38zYu9vKPOJiZZBTeXmaCHKhXClLKgGAzlgnib71wdKGqGWin5qNcB2A7z+V7w4qOkvW2QlDTiJuKzPPZunUC0UqWGyCyELZqrXvGGoXjrLPYA8PWFSXiBqS3ey1msdCPVvU/mDnSKswCiObrobUYETXX1t0obx54bWGYMrTEleDgce+EgYBtrAeHsAG7JcB+fbkWltudjtumu2eTUh5CAYmRcxQBK1BKuJF1XwdxdUs++Km2EErKVfJLceBt6aAVKeBNcxRN2GHAbDMuXyBRdoRnz7y8b1a5/ff6QlcoLrF8xWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=CUWct3L+EJoPigK7er6oBhuHr4GUkpOLoSp3jSCCMTxJtVDswlagouIc+2OplesLr2tRuqPx6Hjy/PagYj2zQ0U/GY7/S/1S4Jk6xaGJufG6dBFvHZSNbsCRESl1S5vxbd2txbtMfHfw3f3D68GR3vNyEbLW1gp75oT8ionxkuUfVSDFhXdHvhxEzY9AewBL8jfhVyKZCMZu8wvzi0nThQ7JL2kGrLespfx71P4bkR8HnOtlylkQQwGOpeTpZBsf5sCHNnBxRXzpipzRfKU9tEl9NIG/ICZtdlGehBhH446QyxCUoV8DT2geIV59LuYfnaesChxCSWHyX16xD4a6Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=lCGq9HeoNM7T8up+9zcnwJDOZ4dUtKroVDQ3aDTQdjxI08/K1wmFOL1VqZdO57H/qVdMGwy3MS6JZ1xpSpiu5BkntiiDWdmkZgJVznDnxoGOa/j6uB6aDOTEUOOtWpaMOsJ/iSRriJxEqJo1g2Oh4wi2GJwYg1iuQOF0V8R1nLI=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by BY1PR04MB9564.namprd04.prod.outlook.com (2603:10b6:a03:5b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.10; Tue, 24 Feb
 2026 13:19:15 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Tue, 24 Feb 2026
 13:19:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 5/8] block: rename struct gendisk zone_wplugs_lock field
Thread-Topic: [PATCH 5/8] block: rename struct gendisk zone_wplugs_lock field
Thread-Index: AQHcoswE8xKr/yFDok+jQT6fEzpNNrWR2sCA
Date: Tue, 24 Feb 2026 13:19:15 +0000
Message-ID: <4dccdf58-136c-438f-bed0-968e042313e9@wdc.com>
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-6-dlemoal@kernel.org>
In-Reply-To: <20260221004411.548482-6-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|BY1PR04MB9564:EE_
x-ms-office365-filtering-correlation-id: 3227cb1f-0707-4695-e13a-08de73a74f10
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Njh6TTR1a2xaRlRrOEJFN2gvY0pXOHpxTHFlTFVMVDFkNHFBMENoUk9HeWZ2?=
 =?utf-8?B?QnlqSGRtUm9oL0pad1V5Qm01RFJaQlZ4TTRPUGVMMWMrM1BDUmFDK1UvUUxj?=
 =?utf-8?B?cUkxV1VMN0xIRzJmb0o1aTdyOHBpdEl1dWlyeVZUbmJwVmdMTzZOMllYbGM5?=
 =?utf-8?B?K0NaYzYxM1ZSM0ViYnhxNFdGV1JiMmMzRitTT0dOMDFHZ0tOSHdVS1RsT3RS?=
 =?utf-8?B?MkRUVUMySDFoQXVzZE9ENGZOSG5LS1NzM0ZDS21hTFFMaGZJMVYzOWRBVG5m?=
 =?utf-8?B?V1FPWEtIWTdkMGNWZVVhTDA2WXdBMU1FNEVicng3bDZ4T1d6UHQ5R0pNWDZ0?=
 =?utf-8?B?MHJDTzZoZ0xtWDIzWVl1U2VsbkE3Z0hVTzdaRFRnVjdSeDc4VnZMZDNnRXYv?=
 =?utf-8?B?cG05M3lYUlFETjBGcWYySHRUS25mSjdCTVFMUHczUWoyWnFqWVp5bzBzVkRP?=
 =?utf-8?B?c0dUK0tUcmNRdFBWZW9ZNjVRa2RQNG1XemwzSmxUa2tMWVFsZStvSU5Qa2hn?=
 =?utf-8?B?dDZRWEtzdnpMaGlHM2d5QlA1NTlNUGo5Tlgya1pKS0krTkt6RUs5TlBoMWNx?=
 =?utf-8?B?K09peWpVRTV0cS9YY09uNEFSZm9yRjZRK3U4RkNoalRURlB2RENpaGNNU3lY?=
 =?utf-8?B?b3FHTjFxbzZaWFZGS1B4dGpwa001NE9ta2hMVjhtajF1K2ticWdJQVE4UlFL?=
 =?utf-8?B?K2trQ0NnVXgxaWRWS3RVK204S0M3ekU1R29Sb2tjYnRDWldid1Z5TmtPYzJk?=
 =?utf-8?B?dFh4TjZ0dTdQWXc0YkwzdU13TFBPc2l3djhLM3owTktGK0lXZlMwMTY1VGZH?=
 =?utf-8?B?dm5ROVd1clZRT2NncFR5TUZVTjBwZFVGclRycXFneTI3V0M1V3NoNyttNzRl?=
 =?utf-8?B?L3drU2FEVnVzUElsVy9lLzBzOEFBaTJzM2t2cWtxajlGeWNIU0Noa1dSeFgz?=
 =?utf-8?B?MXIxTEVTTjdKN0M0UUE4UWx0bjY5eHFYNEZjbzRxZko3Z2hWSWg4V2hQMnFM?=
 =?utf-8?B?blZRYnRBZDhGL2FTNEVFbU1VbTNDanhiOWV2VUFZUUxVYU9hU1hXWGc1SWUr?=
 =?utf-8?B?N3pQWEpqQkxhajYxWEQ2aExWTzNnRVpUQzRYd051YWxZRmVVMjFFb2VzZE5z?=
 =?utf-8?B?VDZjZ2gvMXc2UVBTUW9Bb3F6cHQrUE5QN2ZtN1VMb3hhK3hYM29mc1BxU05n?=
 =?utf-8?B?YXJlU1diaFBIMUF2ZTRWd3JRUnhWWDdYL0Y1V3h0cHppbXpBU3JpUjZ2L3Vz?=
 =?utf-8?B?QkFGZDJmRjJyTTdWa3F6azQ3dU5CQk9BRDI4Qiswb0pEc3V6bVlOVVhpanYw?=
 =?utf-8?B?bDBReXQ0NnczQU1OZTFpTDQrMzVNbE4zQnFMMzFsOGJOa0R0bzQ0ai9BVVFt?=
 =?utf-8?B?Yk5HVmFxSVFNSE9MZzNIUFNrNWFlYWQ5cjlldm13OVZBSEsyRWhwSDVHZWJm?=
 =?utf-8?B?RXN1dGI1eWhZRjJaWmRxYnBEM25BR3R5YnVDdS90RVN0MXNnYlhlUkdwclJz?=
 =?utf-8?B?aVBKQm5uRzNZc3VnbXorVWhyQ3RXOTQ4SEVjbldpTkRLaDhIcEVqdmFPS2U5?=
 =?utf-8?B?d2ZtN2hWZmxrKzBJOXBGa1VOT29KNDIyTWozK2pCamZMYXI1aFA2TGhZYU43?=
 =?utf-8?B?K1VKM0dRWHNnN3FiZGc4dldsL3FZTWZ0My9YcGtLOTVRUGZxN3gwTTZVcGhI?=
 =?utf-8?B?Tkd4ZnMwTmVtNTkzTWQ4aGo1RWZiQTlIWGRzcFZVWWxEV2U0U0Ivakg1UDRp?=
 =?utf-8?B?bHg2SWJxZ1BjYXNRUVdwalkwZnZyTlZhSWZxb3RjL0tlR1l5b3NPYklHNFhw?=
 =?utf-8?B?cE5WdnVRTkJWRFlqaXFLZk51YlVkM3dxTnM5eU50OWdHR0ZnWC81dXFwYllU?=
 =?utf-8?B?RnNoSDhncXF6V2pSMUdneHhCUks1Y1VKallvWXg0bEN2Z1dGZWQxekd4ams4?=
 =?utf-8?B?YW9JWXBGbzUwdUFmRTBVUkFYT3IwOXp3VFU5Z1ZUTEVJb1dITjYvMUxISk9J?=
 =?utf-8?B?UVJZYnNMK002V3RiM0I4VXdHQWNCSWlIUXVseWs5MWJpbjR2Y08xaGYwblNI?=
 =?utf-8?B?U1VObEJleDEzSlpUSDBaaXd4WTl3Y3hUT0JRQ09HaE10MkgxSFladm1tYUpy?=
 =?utf-8?B?d2ZNaWN5SnVsUExWSFQ4Z2N2L3dTOFNSVzIvRGVVZlZJUEI4SW1kcGZzNm53?=
 =?utf-8?Q?Ghl/XNI7UxHLGGeQJ+NdCQU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blNKVnBwSXFiNXkyR0g2eUV5cUVIQWZjVFBpbVdFY1JhT0t3V2JVTHl1NTZ5?=
 =?utf-8?B?eGdzMmdPMEkvaklrSnpJN1I5a0dGQ3dUTU56K2Nyb3NGcWVmeFZUSHJaNFVx?=
 =?utf-8?B?S3IyK0NkU3FYdG9kaTZmQ0FWczdQSkVEc0xLa0pjczErTzdsUjNsNzZnTnl2?=
 =?utf-8?B?V2xQOU9nTGZhYWlXNnZvYjZpaG1YeDF5UUVXWGdKZ0pEUVMwQ3BLNTVkVFQ3?=
 =?utf-8?B?ci9xdmRSbkQ0d24ydFlkalE3ZzFqSktUcWhYdnNxczhzM0FoaVhBa0l3RzUz?=
 =?utf-8?B?VHJjVitzSnFibzJGNFpjdE41TDlic0Zaa2J6MjBpaDFNK2Zwek1ocnNVQ0F6?=
 =?utf-8?B?Q0c3cXVlajh3UnZCOXQ0aUV4VmRsUnRJQXU4V1d2SFo4UEN5ckdmZEZmcUo1?=
 =?utf-8?B?aXFnODVndnBQR21NZFFHN2Q1OE1BTDRHakgxb1VtZmQrQmhqYWlrMDJxNTRU?=
 =?utf-8?B?eVRRcnp1SHpBRysyNVpsZ1dSM2Y5ZGRFMnd3TExzSXpjK1A5WEU4S3Z6ZHcz?=
 =?utf-8?B?ZTF3NFM2V0w3RGtRaUtBZEhMS25tQU5EN1BaU0JuL3BhNjZJUjdwTmlJMFZk?=
 =?utf-8?B?NHN6UVdFTmhpSXEwb285L000di9qVzIxUFFRLzhOTEFQbGVDWmdTR3kvZEw3?=
 =?utf-8?B?V2YwQVg3T05BTk90S0NBakl3Q3JZWTdsM2g1TmFiSGlBcmF6YjlKNjJTVHRq?=
 =?utf-8?B?aTdjQTJDWnlZdG90bmpIbEN0NEFpNEJQb3kzdFNkNDBOTXVDeE51UjRxczF3?=
 =?utf-8?B?Ynk0bUtmRy9iWG05anZqdWRvam1Cd3VCVHR2Y2VmMVdZRWROVlVxMFpwL0dB?=
 =?utf-8?B?Nkxsczc2QVh6b0RmTGZBN0g1R0UzOTlXc3JyOVZiQnV4LzFGV0d6cjlNTXIv?=
 =?utf-8?B?SldobWZsd3VId1R0OGtGaTRQVGhKUTZmbURkTngrMjh6Y1dLSkoyWU9tQWdF?=
 =?utf-8?B?cWZNLzArKzNxa1NVYUlZSWg3OTd6TytEK1ZmWWZsUlIrNytFeFZxTEs2RFhr?=
 =?utf-8?B?UDNzK0NUWndKV1VXRFdOTnkrajBxbUE2cUk2NjNnemZMOEFKekI4ZlNZZHFM?=
 =?utf-8?B?enpaV3Zyb0xaa3NJYTJPSjZGZDZxRHljUmM2TmlBbDhUclZXT0VnM05peXNa?=
 =?utf-8?B?RzBNQ2czR1ltQmllUlY1OFBRWHpZczBUSUg5ZHZjeUpoZGZ0ZkRydGpObEtP?=
 =?utf-8?B?M0tCQm05WWE3VDdKN1M2TVhuaEdpSk0wRnFkWW5yZjdnSXJaN2FhYkcxdndw?=
 =?utf-8?B?WWZRZkFLdTliRmNITkpIazZwckw4UW1McU5uZ2pNUVBKZWtJRlJ0S3k2S2ll?=
 =?utf-8?B?OWVXbFhhbExuZlF2NDVjZUVBd0greTU2YlZtWmFnY0xCekg0RnpaN2dMQmIr?=
 =?utf-8?B?cllJdUJkcitybjgrRm11UGxtYVBkUGlsZ056RXljdm1FV1puUHlzSXl4cDhC?=
 =?utf-8?B?VkV3MnJLS0pxam1RRCtuSEh5TVBXS1htNXFpNm5yTXRSSWNkREE4cXdvU1Ra?=
 =?utf-8?B?QU42a0QyelcvUFJVVXlKdlQrQ21mVUFHZktjMHlvL3pyRm90K05XU1h4aHBW?=
 =?utf-8?B?bDczc0JhNnpaZzltVjV3dmtzZXRlZktBTjFHZWYrVHU2NmQvMEhQRXZOaEF2?=
 =?utf-8?B?VWlTOUgxRnV0K3E2SXVBT0xvZ3R3MDl4OEFJVHFrNzR4VE4ybmNkUkdtc0pO?=
 =?utf-8?B?d1V2OVRjaTIyLzU2bTh3ZVJ4VUJKSVNOZmFRRFF5VWJJWlV6MWhsNGJIS0F1?=
 =?utf-8?B?NzFjeHFpOUVobEQ3SUZmZnFKTnNINDlwMmhDR29zN3UzbXN2ZzZWbU9MeTli?=
 =?utf-8?B?K000bzk0ZEhkOE93ZVNpQ004TUhYa2NzYVV5Ykh4SHQ2UjdENUUxOVZ0KzFu?=
 =?utf-8?B?T2d1d2J6bFdpN2lJWVk2NTFQdzZEZjlWU3ZZU0FaT0FBeEVBaXk1TGhWSFBu?=
 =?utf-8?B?Tk9MaG1qMXJpTWZGT0Z3QXVUYkVFVzFvMGdjVVdRenNWZkdDV0Q4dGVVZUwz?=
 =?utf-8?B?SjQ4SCtsc1R4eWRpNlZ5dDJCSnhBdHl3TnYveU5scW5PaWhncjllY3h1Nm03?=
 =?utf-8?B?QkdzM0FSNStoMk5DcENoWVNYMzQ0bnpzQ0kxZjQ0UUVHeEFmeGFBZldLbnJm?=
 =?utf-8?B?c0VEVksyd21iT0c1Nm9hN25PUG1yd0lUNTgxVzl4ZXdmNXRzVGo4Z21uUHhP?=
 =?utf-8?B?K0lwTmdkbVN6UlZONzl1Q095SjBwdm1IMUZuR3VabW5JTEFES0g1MEpMRGNP?=
 =?utf-8?B?K0trYlRpSVZkYm5FMi9OT2JUaWxPOUxRZm9Wcm5uanBCSVJ2Y20rV2VjNDF1?=
 =?utf-8?B?NlpNK2dhZy9kd2J1Zy9VYlJ0QXM2WE00MnRlL213a0ZBMzB3QVp0dFR1QnBs?=
 =?utf-8?Q?b8VurB4dDKLpwfUI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2178B19573D44040B96EF53FE99ABD82@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2m2j/aeXkCOURyE3QStug2d3K6w49tTEFJiJKAGI8DYjDBu2hNVcbQfr8r9Al/jFxwweHmomKhAvyk/sY5m2DbRYT9hcl4gXvNj/o96HO+VjTYb4FHYY/eAx29kzW4HXFa9ygTNMvTlD9xePDgtfL9ftqAsXU9+eBdgvWJdrP1QzNeR9JL+KJbd4Q7NwZHtLJUGX0VK1c5nSf/rwKOJ0MFvNOJfsv6GITHqMOeWaI1jYNcheYZkREfPi7r4DIFziC58e9Ok2wkMgXcOBXIV/j0Z7K5fQibWS48aaZAq/X1w8AjPzGKPGAs4gx8mElkTSDKmg/5IiSxZfQZRZhKH2xsLY54/ZnROZk0FoUuHk9coeT1/YnMSCjDvS+ga2TPtuUJ/z/5S2wHP1zKJyG9AhEa9iQTME8gcWROr/U+h/KiS6/fR7hA/DvL8p3aYYg2UWI69kDXvO26DTENIeqyENoLqqLAyVftJKhmQEV/++3+f/YWIiCbQ+msUNbK671Aqeuk2u2qpz2LV3XVSK3CMNoIQ7saAQ7TFTtbgeAP52j3bEKduXSglw6eZJyLDfPLsO7crCzKyF2MUvUFpa2H6jf36ScDK1v0GaNVHOOV8RONUFo3NQLBHcQlh/zQ4DnxO0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3227cb1f-0707-4695-e13a-08de73a74f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 13:19:15.6043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fw3Vl/ZMSlE21N3Hx3HMDx9DCHfaQ0CVhHr6qPyKEYTLHmorZQnb8TTT4U1GcQtSHeYvqzcYIKH0HbO0cE9OgtZlv9Yy3lf2bEfjRJs4Wc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB9564

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
