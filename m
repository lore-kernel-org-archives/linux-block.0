Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD228CF5D
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754745; cv=fail; b=ZMX40wp+mDi1FbYYN+LtfVEn0QK647bR+vF22r9FRoAX4iapp04ijitxJDhjW3/Z8oiZJgW/E6KplsV0rnua/+mBFGnMMzAttutKL66LfmUlvQTTK6J8Q81I4oDvENsndCg+xMQPvZlALotU4C4SqIoQ89JDRZlIhSjn58y27YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754745; c=relaxed/simple;
	bh=JG3XLqHwb4QGWKpIDoFsXotzPanbhWph4e/GKH+odrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HtrLIq8mJoQlsKG2VwoKRBkogol6p0eqbnEJ+DYREDtptcpt35YLDizc02q9l82L3IQsl8DJt0YMb765NjvY+Vzr8tc0ilSL4unwmdFUkf3EEqlEiIlioSr8a1JsFlZx9+4aYs6Ie7n82YoIhSaFU9Nk4mjU5hqAzr8Iu3AR+As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GVGrDXd9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GOCwvVyl; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GVGrDXd9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GOCwvVyl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773754743; x=1805290743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JG3XLqHwb4QGWKpIDoFsXotzPanbhWph4e/GKH+odrE=;
  b=GVGrDXd9iSnorEg5hInEtUuoP1RQpb+ZhvgSe/TT5cMwcoiPwqCdjlvs
   IJJ2pATbjXJNtnR7IFZ8mkmeoIwKwE4ZPAgu3mX3PWZURIzwoocOMuIoe
   RE0hVaol7qgy0fC0NQ4T6Enwdf3ZH8p+hfEpBmlpT5bJjZm7Bc/S4tdCW
   Fmu0X22X+Tzdc4jlSmgVH+jZ80pRMT7OkG1sSGe9iyvS/9Ui2xInNB5qa
   wSmv6CW6HJI/nkiTj8K94NgcUcX3YBZtjQvzp39BSCdIpCWEBFddHXoRL
   5D702IHQ8fDDwbFjNaklQ51hEb4P5A/KbjCdfFqjrXYf28jLRZDHizhmk
   g==;
X-CSE-ConnectionGUID: Y4+WUdSbRl2MUggZHol+0A==
X-CSE-MsgGUID: idG9KZBERy+MZlTTPRrLMQ==
X-IronPort-AV: E=Sophos;i="6.23,124,1770566400"; 
   d="scan'208";a="142271088"
Received: from mail-westus3azon11010016.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.16])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2026 21:39:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP4sW7ZItYUL2O5yDkCogQUgm1123PsBPsyvAvCSXVXj1aPgCOyCUAirY8fvv8hv+bmRCyWzTrUvokBqgYAZDYKSVnOmf4EvhBO4Wm3pnp1oyZdeT9ZMToD9OTSBrfZ4IDQ6r0NmAu/4jCdQHuaQh2n8tML65V5zMH9HUT9150nD9euft6CpFY8r+ZlUL1re4nGIL3V5q83OiRE/C8VWs3zHRX81ijJGMiMIdPmlPsnVyQDnepw4v+v3tHOTu8GYrC99yYQqUlCCz0q40zSsdm/w7oY0ZqrwB8K+0OCZfM1+p543h0JrToYidNg4140kiYZ8vP8aPFF7xWRwnDfyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JG3XLqHwb4QGWKpIDoFsXotzPanbhWph4e/GKH+odrE=;
 b=P2oNmzMo3GqGNyToGMC/7Rij+v1ByRag9KlI7guypmtTf+rC2rmNOXKEi0ijLkBc2bs0ULwymf0r6o6cfIkTmQQV2ReEpCZljHnh+JDgY1by6tqUpiQl5tUdIYUtWGTio09gHD1VgNYnkRQPBVzEm/0NsaS2+pMoBXA4Ji8MXqzPM6UPLWA4QT5apRvlJPK5uQQfBvDDV6+nRGdF5T+JiSsddl/X59HqRjay4t+fZmEkzpvanguO9Kga2YhrKzgiTu87OIjMFk0HYMMDYyCFOs29t7ie61vlRugVC/mfrQPQZaNvDPUHUipj/XP7E8ym0NU5AE0A5qU3Bw27LDIjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG3XLqHwb4QGWKpIDoFsXotzPanbhWph4e/GKH+odrE=;
 b=GOCwvVyl2cYrHW6u3tqkr6YCfonuTkb4jyA76DWi95DC877hJgLTG2S3q4+9IehzfB1nTb1Q12hMm27F4KkJq1yCNF5LbK9TqRWBZlRfl6dNiiLP72WfCHEz/Gg9HgPiEsCdgNSJCbYCjtkPkGhcDbEmbLUN2O3N3FXYMF/Vans=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB7801.namprd04.prod.outlook.com (2603:10b6:510:ef::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 13:38:50 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 13:38:59 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: mark bvec_{alloc,free} static
Thread-Topic: [PATCH 1/3] block: mark bvec_{alloc,free} static
Thread-Index: AQHctWBC+jOiLQNg40qUpjlFULYufrWyvBCA
Date: Tue, 17 Mar 2026 13:38:59 +0000
Message-ID: <cde1f78c-c92b-4a95-a665-f327a3c2259b@wdc.com>
References: <20260316161144.1607877-1-hch@lst.de>
 <20260316161144.1607877-2-hch@lst.de>
In-Reply-To: <20260316161144.1607877-2-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB7801:EE_
x-ms-office365-filtering-correlation-id: 7ebbea32-662e-4ed3-d4c0-08de842a8b82
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 WhzJIAwYpmLtkRmd7XLcaA7bZ+aOVFmyHBifPvtgjKd/SyhR5Lh8ovD6t97H1bUb3/U4JabTDTEzDIAVB3vHFVOEJEQdq5HXZE1LMqzTwoQF3Z/xFx56Rrm2TAbN6MtNQeFrOpfNEJ4yZks+vjKPEXJ1vVO7zITi7PCNfXnRP/7297a0d3qU3IavJ94p1j+XZ42V3fxY8K34mZ1JqrNNP0qpFc811njD1tbsum8LpudDKMRqCftFSuA4UfBF6/VAGmNRMsfJOtIfHnTkIsn4kNyxTUrBNOqRy4v2JQSJYFgjXsLvhxrbRkhLK9SJIF/eLg68y/pYNILoBfZ4M7Fh8gCxUtM1vXpbpTBYibEyklKvt6VfeGZ7TPpk7vVaOWFPmQ6SdarqOxXYnZ4gIg4gAAK7Qm6dcuiFKkyYybQ9RLSb2sfwJdh6Hzimwl7Zb7Gy0gJV3DodpiGh3c/W+C4XI+BU3ZFG//Wo3hyooe9w4eb7ps18T1aTCWxSLLy8Ip3CKBIxvfcxxzRab1pOBtxdV7eKlkBrVDynx+UOQFG5yFdilqhKp9m+z2+quRj/bw3TFbJYWJySsjRxmgKIIdxD4untwoMgi6jWUbj1AL5Wtk8/yutvDYDm8yEh99/jFdCkVS2sPC+yGQx7SWenBqrzEjVq1rSu6Ahs3c89gBcHIlXWysN/JOtGzkznwHL038tNrD+1iMDeWb9UOjFhahAxVE5HDGPDuYOjdQBHnSUNBHDGrqjyMQ83Q5tuWXrvTJgEBCkomPRyOaBAoy29/9V50GSTgBanaJETDoYkvOz8v2w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dm5uWFgySWdVWFlranF4REs5c3BmRzg4eTNHYlVmOGhEZjMyRmQ0ejRhTFR4?=
 =?utf-8?B?bVp5a1dPbDYvWThFdi9tVzhoaEZLTTRVQ1RMbUR2Nm9KZjFFUm5FK0dER25Y?=
 =?utf-8?B?WnI0Rlo3QmhRQ0hrR08rL0hHYjYvMzQ0cGhoWHZiYkVLaTBVMjU5akpZNHNs?=
 =?utf-8?B?cElRcEt3L2xSTEl2MGNTazU2bFhKaWpHVm5xb1RudzcrbUZKSDcvOTlxQ1dU?=
 =?utf-8?B?S2gzVThDeDlvNmV2bldDaWRHTkZuZjIzSTdYUk91dzU2QlluK0pzK3FsckdN?=
 =?utf-8?B?OFlSU01TUUVVdFJDZjNUWEhsYjIzMDU1MVVMREtnNTgrbjBla0FqUlVTelV0?=
 =?utf-8?B?YzlIZVV4VWJjcHptdWp2RXpYVFlNWHdLblhGMjZvVG5SWGZVTVNFVERxK21O?=
 =?utf-8?B?SzdsUGk4Q1ZqQWx3aU9mU1k3dkV0cWJhOVdiOGxSSmtiU0hvSXFvUi84Ny8v?=
 =?utf-8?B?RDNYWXpNNUNQa0Rhb0tPYzV5NnhzQ3cyZmpLdlJjQmROVzFNR0F4WHBDVlgx?=
 =?utf-8?B?dnVnd1NOc0J3NE90MWhPNUFMYkVJL1BFSjYvQ0VsZGowRVR2bFh6SlJJMm1r?=
 =?utf-8?B?R2kvU3RuaDhSU2RLMWh4M3dtODdtUXF3aWtvNW5ObGpCMUxGbitRSzcxVFA3?=
 =?utf-8?B?K2F6cnREdTNOR2NSa0diRFZmMThFZ2ZaVUEwSUs5QXBWbkJuT1hkNzJ3clNM?=
 =?utf-8?B?ck1aQlRpS2cyWEhYekRDc05NcEEreWpudkZUSGhZZU5NTWVFcjJIeXgyU2Zl?=
 =?utf-8?B?Z1JjWFAzb2lWY0diekN3MGI3WTcvbW1mNUFXd2RlQTd6UVl2R3d4czZLYm82?=
 =?utf-8?B?OFJvWlVWWHFhc0tDNEh1cm1jSG5NdTc5cUY4d1lqd2pTcURLY2F4MERBa3o3?=
 =?utf-8?B?UmE5QVo2QXpFeUpnb29zLzZmcE9sV0hYK0lkQ2dUOWRRVWtIZEUwSmFNZjRR?=
 =?utf-8?B?cytXa1RSSmJkUWRCZVlGQnMxQUV3K1ZkT1huc2NQNTYwR2o5MU94RUxsellt?=
 =?utf-8?B?Q0xzU2JzenlncS9RZ0prUmNZL24va2VjUll3bXE0K0w2Zms1TTNjUVdhNGNy?=
 =?utf-8?B?THNRNlhsMHFTck9EVGhPV2h3NHpiUEN1NUJnQnZCa044ZmFNWVZoMkY2VWJT?=
 =?utf-8?B?Z0pleGxnSVFIV3R3N3J4OGRzK05PN1pjTVZGK1ZuTU95R0xBUjJqTjg2NkxG?=
 =?utf-8?B?eDdadnVxRjZwNDdiN05tTXJjOXNhdjYzMkhFSmoxRG9NM0dqMVpFZXN4dEhW?=
 =?utf-8?B?Q2txOVJhZ2JvcEpJYnI3UUUrMTN3NVY0cDN4NjQ4blRwY24vUWZQT1gzbmZS?=
 =?utf-8?B?WXJHSVBVKzcwRmh6Z2dPbEZmeVJGcWQ0RkF4MjN5Vkhldk5GaEV1RjN0bG5w?=
 =?utf-8?B?YXltUVEyVytpRmIreHNUNC9RMWNGL0JYajFnd1ZxRXp0a09CWjgzNGZ0eENN?=
 =?utf-8?B?Sk1qZzdBdlpuUXJTS042dzhyYVpxOFVvR1F0QkN5Q2tSaThvQnZNRWNKNHJM?=
 =?utf-8?B?b0kyVGZyTEdOSzZUNDlRTFI5ODZjSm1XNjY1YjJqaDk1bFREcjNLQ2ZrZlJk?=
 =?utf-8?B?YXpMV0tTM1NoK0MybUY2cDlUUTdTek54MFRwVjRuOHRxU0dTT2cwcnlOdjd6?=
 =?utf-8?B?cng2cEw1M00vUHJSUmwyRW1tWDN2a1pwdXRWcnVQQlpBcUFnOElia3JXMXdl?=
 =?utf-8?B?NWVXMWJ1STlvTHRqWHhmempoUkxORmFPcUg5OTlaUGtwWTNiRHpxSWJoM3or?=
 =?utf-8?B?S1BqRmdqVld4dm9NMzVJMy9tTkl4aW9GZ2NhN0JHUDBwZFhyZUIyYS9wSkty?=
 =?utf-8?B?VVJUKzgwQnVvcWdvT1ZJenJnMlRHVGppZFIrbWZpZVhyVm0zelRGbmF1cTMz?=
 =?utf-8?B?MWgxWEszQ1JJVWFOTkxUbGVuYnY0dUZGbUx5eEVFWi9sYmFUSGM4UEhzRjNy?=
 =?utf-8?B?MmFRbnhpRURMVHVicWNOeG1kbG1oOHlhVm13NHE3amtVSlh0RTZlOFRqTG1K?=
 =?utf-8?B?akdmeTdKcUt1cElTYXlYUk4vK2QvRDhHVlpRYW1hS1FiQ0U3L09PVFlkSTJr?=
 =?utf-8?B?d09QQzd1UW5YWTBLdWFQSDNFTHdVb1o4cytsL2VUS2dKVXRYd3JEbk9GWUhj?=
 =?utf-8?B?RWM1d3RnTDJ3Zyt1UnR0cURneVZGNFQ4KzQ4L1dtWWVDaTB3QnBOTXlPZVNx?=
 =?utf-8?B?dWFnVnAxaWE2QzVuOUh3NW1kK3lzRjVMUnhQYWxQZFpSeFArUUxMSmVPdVVp?=
 =?utf-8?B?NTZ2MHNBSTA0YXBzNW9uWjU3MHlOMzRvVlU0RFc2aHAxRUlTd1g2dERXRHlY?=
 =?utf-8?B?elNSQWpIaldKT1VHODYzaUh2ZkpxYVlzRHV6NURIdmM5dHQzYXFWV0JEWlJ3?=
 =?utf-8?Q?mWpgD/vBL/kZF0I4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5616D0FFE423274F93C01844E60A64A7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mSrgVbASRTrjYyAfH0aUjNgz0poLms3dB3tKKqi7aZ8KhEkSh8SQQUf79oslekSay4/UAqnJxfdEevHcecJu6XizRIuspRWILR72QNWry2P0a26dxv7c+0DxTQSeSPbs5UXzIiZFbW2gE2r6QABSQ+yXlHmo//iF6Qs79LgLV20Vg1TTNwFMCXQPmUEiLMIbrGZcXHoK1EX1z0KM97sN1rYCxrFJyEgmUBVsru/gxpu+JFS/n0OLHOVTA+C8Zg0rqdbTzvrI+T2nwFGGGT1LSP9st7nWx3cg2Uf0gRmJidmU5IOmUjHVV9kT9xUaY72wM5q4PZyzkeTUMeR7cpx7uA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DOyqA78jukKXNw0qd3um7R/3+cApa09+02gZeCfw43P+DlVRV8ChhUV0i2dr5urBAvg/Sy8x+KZh+ettMDQWN1J7pHTXT+6SRz59PCUlYD6miy3TdntrLjODeIiS90d7+8n1D/QkNy/oFfKWfqkkuQ8FoBjfB/n3+Kv9NwaCORwfNXg4e1k8isXYDTy7OK6IHwnFwijVuSVPTYW44GTOGBVHqoyP/bkzSh3TJ19ZR942tjh5wtqF1rAeVz5CtJC1dVkmCNwXvpxKIjzjzMzpBDo1uqbUvstpP5fqqEONXJ65viRGhSLc0xnzaetIqQI6rMMgESKbuHhL7pC7//8JzU4Z/JohhUzMQOfY8E8gIPEQFKZk9+zlaIukk/VXA9ilfG4sEk5/NKoAzvlFyKKTgIRExd2SF1d7WDwAySS4RRbmS5K6x35YiLJAHChQAS1PL4LEAyTpPmvMm4I8lO4HQRFRqsNszB+VseB1ymfIRCR7H5Eekb63OTC8DlEtlQT8r5R0kLGiK6s+Lt5cdHnztgNgDbTRUKgPnNlKDDFZlrrxo/NAG5hnjFQgJFBg+oYKy7UshyKB7P9nQSrr53kz15JMWB2xufHepzbDR/lMQnjNtSvhCLjm848FPCkGpMpn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebbea32-662e-4ed3-d4c0-08de842a8b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 13:38:59.6823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Em8Zv3B2TRGtcWkl/CbW4EUJW0TCbQwvJkwKm39P1uYblC6JqKZnAzpbOsscHK4+/o2XNrqWbh9Qj7Onx0h0aE1ARqoKtkef3c5Yfi0WyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7801

TG9va3MgZ29vZCBhbmQgSSB0aGluayB0aGlzIGNhbiBnbyBpbiBvbiBpdCdzIG93bg0KDQpSZXZp
ZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4N
Cg0K
