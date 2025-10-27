Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5A296BC8
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548211; cv=fail; b=RzjAJrwi9NCSoE5rmdl65jPNRRxvAQY+5fEhbCtBcT04H+eoqntjxpJS6IXpxxrHkOvELPpIXDrnkJz/+7Xg4il8IMTwQD55hn7LpQuEmmVIDrnqI25qI+RFMJ6ptqSJb9Gv4WzitXrzlD3LrRsOO//pytkBJA8MCFL3yJh91c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548211; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UhfpV8I53QyR91zYg4DejH67E1dfsLlDyVNsIhiLrFCK7ZKwJTUqiXHAi8xs0U1U9jxCQJihSXvMD1G0zzeJAd7gnwb4CeH4EyEmYy55iCfioQ3Yn/dYuNPCJKAUD+dWlDpExkS8OqRTyknWAdmPy8SyhDExwDxfyScepuPY+nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VHM5+hkD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sorJ5Nmh; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VHM5+hkD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sorJ5Nmh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761548209; x=1793084209;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=VHM5+hkDJWvKOcvyhGrS81BGccBUZ51MGtN23NGIBl0pZ0LaUGbhQdoo
   NA0udYGmFbPxRpcVI10K8rHhm2uk2xmb6al6DXVX8zHDc+P4tVBI5Ar0D
   mh2nvzHGzpNtik8VPKKilge93Cr43wRMPt7wNgv8+dU7eVsEIY3sdYFqI
   8Imngk63RPEdvJCPycSsCsTQBfmm5kxAbbdgTQa2mW1Gk6s00voHbLaiI
   IBvQ4+pYS1T8b2PkC4B1gp6mvCDdoYuBbJqy5jUZxuOZMOJGkLgBGqauS
   fF249wgMzHADTM3I+vJidvOxVzLZTL6rhXEZD1IE6g5kd0UffxhpTHo51
   g==;
X-CSE-ConnectionGUID: k/9rf+CfRdmdjpQsZRrpEQ==
X-CSE-MsgGUID: zKpcPOsLQ2W4DjLAeg3s6g==
X-IronPort-AV: E=Sophos;i="6.19,258,1754928000"; 
   d="scan'208";a="133865366"
Received: from mail-southcentralusazon11012028.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.28])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2025 14:56:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3Mx1JmVHASMoLiSK1GIRSKkCE6ImkKfpZnv3plI7oeBXdP34uv0NyxE+Z7pP2YN2q5UvJZ4vNNTJC9Yx0RrMQyR6YiZpeVaGH/lLJFfSkWiSQ4OLWNeMFSCIlqvBNM5tp/TJbXPl2Aq7bCXTHtywLz17o3E9ZHxgnI0YV8My1DMm9dRtLe61a4rDDZHw1IIoq+UXLqqKqIUXtoWwXGjIfWWsPapkWf/BRr21dW6QHMLiszGau8gPlKMuvd8iZmN4liekjo8G6cKa4CNlYq5YE0l4H2YRKlEhjvsMLC0HTPe6qChkFoTyc/0aaF1xsD5y8eRIGwYHmtrW+xC/gXfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=s/YoCmSgD31F10q/QWEs3N2Ud76hlOVp0NKXQsBimzLeqS7M6WrmUdu8irRtjyqXNdSsfN6r0Hj56ZUO4v8Maild0OsPorXg9QIDqBnkqgKamV4cTCK4o/5jk2j6fU3oehKkHJqPA0lc6WRSLvUf4sJgq2xDzGoT3/L2Zede1n60TI+RG59M9rbWWtGHx100bJjX6tCkkwAyaULOGbXDaqipqUIR867+M3/RijgHiKZY53zSxRrI2dHQ8n5jszbbN650XPTSrwSwZD8D90N8X26o4GJ7O/0rDmFrhBWY0dCAcZv7Eek1A68vDDWbCGDILoVUriAfCYw4BWO0wdKevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=sorJ5Nmh27FV2iy7IeE1UM6eLVb+UGf5zxsmuLEQrvDaV/qxwTkNxA1PyySksJxjX/eBTxmXQvrsvVVVmc1Vh4cUKpWH/VfUPi4pMM6kIEk5koHlbZBvI3tp4I+5hxPv4QnM/n1ue/PMaJtIwgPOA6MS8psO7kNf/SWZZouPGv0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB9059.namprd04.prod.outlook.com (2603:10b6:a03:537::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 06:56:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 06:56:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: make REQ_OP_ZONE_OPEN a write operation
Thread-Topic: [PATCH 2/2] block: make REQ_OP_ZONE_OPEN a write operation
Thread-Index: AQHcRtkSODkAW/SneUKpk2YHT0wC37TVkAUA
Date: Mon, 27 Oct 2025 06:56:46 +0000
Message-ID: <04fbc5ba-9368-4add-b09d-64ae4752eee1@wdc.com>
References: <20251027002733.567121-1-dlemoal@kernel.org>
 <20251027002733.567121-3-dlemoal@kernel.org>
In-Reply-To: <20251027002733.567121-3-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB9059:EE_
x-ms-office365-filtering-correlation-id: 77899033-bb95-4ff3-0f05-08de1525fee9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dG1RYndudGxkSEh2SlBQNkdxc081dHdOSjdIS0MxRXVEK2dkay9OR0tYeHdt?=
 =?utf-8?B?bld1QWR3c2gvK2ZPVTIxUVRhSUVDTTR6Vk5nMCtOcHE5ZE54YWUzQWlFUTJK?=
 =?utf-8?B?UXlDOUFpdnFyRitnNUhMZ2FQT3RuN1BXQUJZOTNJYitmaGdpWTJRUmQxbUtF?=
 =?utf-8?B?ckJIT2R5c3JTckxlVzN3RG9MUzRlaFcrem1nSVVzWU83TUN5cldjcnRhVFJo?=
 =?utf-8?B?aUl1UVFGU0l3M2NYRzNKMDZ1akpYTmIwZElYc3crTkRadzFaNkpOQ2xWK0lX?=
 =?utf-8?B?WUp2Zit6WjJwN1ArY1FkWlB4Skwwc1lFUitVcmh6SGlwWkIrNU1INjlpeHNh?=
 =?utf-8?B?Z3ByM3JPMDd5WVZJcG1VcTZRenNtSmZXcU1wK2ZZeHNwdk92ZU9qM3JrbWVM?=
 =?utf-8?B?ZE1tb3R6dXdTU0RwUlZlUDJyc1RtSlNkYW9nVnJDZjdxbGxnV2hlWGZ5c2Js?=
 =?utf-8?B?bHg1alE3Rm1KaVR1ZGw1bSs5WHkxKzRaMDFWQUZPcmRNMDRnSW5WVUE4SXNv?=
 =?utf-8?B?d2lJaitXZEN5dEMyQW1XandZdHFPTmgyKzVjRjl1cmZoY2RoZXJJaktoalUr?=
 =?utf-8?B?Y3dmRmFtSHZDamFJWGUzK2FjSjNnMG1NUU9ad2dCOC9BTXBvRUtKdjRUZ2Ro?=
 =?utf-8?B?VTNSeHBOak5tUnF3WitTTXZwbitSNGZSMUF1ek5ETW10a1dPM29mVUdhazZy?=
 =?utf-8?B?dWRnZ2x6MWxLNG1sa0tVYjM5K21ieVN5Q0VNK2NiQzN0dXJMUERqMyt5UkJM?=
 =?utf-8?B?c2g5UkpjU0x1bGhTWk1DZVJBVGE3a3ZyN2Fwd1NyRDQzdVNlL3JxS1hlSVRN?=
 =?utf-8?B?RkZLRzUvdGF2R0xFWW50UVlYZWlHYnhHcmdxY2syVFJPRTU0N1RMTWJVUXkr?=
 =?utf-8?B?aG9BaTFUMFN3YlNhWjFpUDRkZkRGZEJBRkZsMHZiTnM2d1JEeUtSSGlVK1ZY?=
 =?utf-8?B?R2pIRUVaenp2dVJQQWdPVE9hZ1NVQytuQnYyMGN6WnJvOC95ek1CMmRtS3Z0?=
 =?utf-8?B?VDM0NDdqdmtnV01xaEZLYm5KSjZZVVVrYjBQNElxWk5BOGlIM1kzRUZZRjh5?=
 =?utf-8?B?K045YklsZkJYU0MvNk1VaU55ak90UGJHZUxzZm1kaTNxYUFQR0s3dXgwc0ZK?=
 =?utf-8?B?L29tekZBUGNRWk5Zd3JRMG5Sa294TG4vcFgvMXJVTjNYZ2RaaU1Ka2taZUZs?=
 =?utf-8?B?RVoybDFLN3dDRHZ4QUd5dC9NZ0MxTm93VTArZzgzMXNjR1EweCtKQ0k1cUdD?=
 =?utf-8?B?TUFXa1BjMFN2aGU2TkNXbmdDNkFlVTFvcytZKy9MQ2RiWEpFeUgxSlIyN0ZH?=
 =?utf-8?B?TEsxWkt1UDB4SFJEcm9MMnU2SjByUkhFcFh2Rzl4Z0ZxaHl0dTUyZ2lMZkJT?=
 =?utf-8?B?VzBscGNyTmdLaHppM1Qxamo2YVJ3S0pQMDQrL0xOVGxkNUcrc2d1SmZ1VWZy?=
 =?utf-8?B?KzdPRmVNWnZrM1l0dEQxTnBtRVRBSjBCSjJYSndybHJsQnQrR2FWWW1zc1dk?=
 =?utf-8?B?RjBwZ3ZCSExqR1piWlozc0FtV3RTeTFRWEpFajljQktZSDJKZ0pyNzI4RDdK?=
 =?utf-8?B?WndtOTRYaHJqS3lJZFpGRTNWZ3VsZlpYL01MM1RROStTNjhHQklNMktJckFn?=
 =?utf-8?B?RTMwUkVlcjVmZzRJUFNyK0ZhSmlnNkFyNEM5VmpSTmpWUFhZTDhxbFoxaHpS?=
 =?utf-8?B?MGFOT0UzcEpDYklmZGtJOUl6VlVFTWJaU2ZTZTlEUTI3WGV2WUp3dmNIekJU?=
 =?utf-8?B?N2NVVXFMQ2xZQk9WL1JTS29BWndaZXFXUEhab21sVnhMcUhnYWl3b3dmTEdQ?=
 =?utf-8?B?ZEFscFdaSUdEelBYdEdEbit3ZDlCY25vVS8vUzI2ZHIyMmRKM2lwTDkxaG85?=
 =?utf-8?B?NjFLVmcvN3RqZGxPOEFiQ0JySzlLbHRRbGkySDFmMmhIZFRlQnFkMks1c0g4?=
 =?utf-8?B?Uld5dk9SQS95V2ZoNlVVUkQzazZTRFo0UFhPK0EyYkMzZlB2emJYcHZUSWps?=
 =?utf-8?B?dmZtQ2xqUFJlT3VIMC83b3hTNVgzMFFQcVFwVWI3SGt4emxYN2g0NitoS1Fa?=
 =?utf-8?Q?mXPTer?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGg1Z01ENmVweG1DWW54SzFTSE42UkoxdE1MQWFYQkJMdzVvNTFRZGFZUnBv?=
 =?utf-8?B?SVlGaUNZVU1oQTYySzlEM0g2TENncnFKZU1hcTlPL1l2Uk40eSswdlZOMndD?=
 =?utf-8?B?VkZ5bXJvS3VJVmkxYUwyaFM1U2xsb1RXQXhVOFdpQWh6dGRROFgySmM5dzR1?=
 =?utf-8?B?bkVLZWU2ZFNtcEFacDQyaDNodHFQUWZlOGYzZHhuOXYyWjN3SEFheVRnUG9J?=
 =?utf-8?B?Q0FDR1JjYllHREZIUHhpSVA5WVMzYXZmQ2JMWStCWGJkb2g0U1VmUHhuTytj?=
 =?utf-8?B?VHQxUWs1Q0dhWVp6aXBrcVNMUEd1elo4eVF0ZXdQenA5aFVoMk9kV1VEL0hL?=
 =?utf-8?B?WFZtL1hnemtGVWZrOXJ5eVY3K2M3OHlycHhyc1Y4OTA4YVhOQUw0QkVsWlRV?=
 =?utf-8?B?SHV2Y3EreXhvdHZQTVRYZTh2OWppa1RCckZvenByUkswYWNpMG4wdzViQnAz?=
 =?utf-8?B?cysyZDZmQm1PbnZDUWxvNUYzTmVzRXYzNERWZ2t1dzRldjRDVms1cGdMbHRD?=
 =?utf-8?B?ZHBsV2I3bENma25DUit4aTJ6NmpibldSbG1iYlp2bnFQN2JYMzFCWUxLVDZk?=
 =?utf-8?B?QVhZSkg0TkVidE14T25kbWE5T2I5QWd5VTlRMEtmM1JJaWVuZEZWTnZ1S0R0?=
 =?utf-8?B?bktZTGVjQ21mbzhWZlRkajYrNzFZQ1pUczRPNDE3Y2VRdHpvNXFQZHc1WkFK?=
 =?utf-8?B?Szhmdk5HOHI3azZ4c2lkMGJCNkJ2dWRkOUpQbm9LYUFtWUMrZnVhWDF5WkJq?=
 =?utf-8?B?Kys0a3dmWkJjdUhrRVYwcG9Sc3lwa3pNOHJXT3NVVkQzTlhqUy9zclJnWWx6?=
 =?utf-8?B?ZTQzSGpVUGVsVlFsSFJPL09EejVJWnNEZE9QWUl2S2xTZ0tWaXJyUW4vVkE1?=
 =?utf-8?B?VlRGZmtHWjBJZTBRZE5vUldwZEVUVitPUnZ4eXR6c0Zkckd3cTR6VzNtdlNP?=
 =?utf-8?B?ZGhsWi9Vd21rRWs5RXpjcFVqZzRzZ2dpend0L3JSSkQ2VTc3UWh2MVMrak1I?=
 =?utf-8?B?Yy8vK2tDR1BidUdMT3hOd2c3a2syNUJXUFNkdndXNnpEVHRFc3FKRmRYTTZZ?=
 =?utf-8?B?WXVMNFgyS1kzNlJyVlY0bXl6dWlYZjNDVXIrZGovSDJhQ0ZqRFpPTzdPc2Nk?=
 =?utf-8?B?VTl5U05rSEdlbUdaYUpJUjk2M1ZldkV4Zy95S0dkdTlKdDJHSElXeFp2SUJI?=
 =?utf-8?B?T3dLc01zcVgxKzBJNnl6V2N1MEFqVEdzZjRYTlZiZFovMnpldGgzS1ViMHp4?=
 =?utf-8?B?MkY3SDhEZWMzL1NqZWVQaEVSMllMQ0d6RG5IZVVHMUdkc0psQ3g4SFIxM2hw?=
 =?utf-8?B?YU1lS0RnWXdPdmxobXpnbkdWdHZhbjBrNWlGNUs4SjNRK2RhdlpJc2hiWUh2?=
 =?utf-8?B?SVJvdVZUN0o1ZGxQcURtZWdrQ1YwTUpBTlVidERkaEZnb0hneHlpMTc4NVht?=
 =?utf-8?B?ZEpSaTFCSEF3QXVpaFpzYU5MTmU3ajRsL01OVGtsNy9pUGwrNjFWV2oyVnp0?=
 =?utf-8?B?M2hjYW1VMGY1dE5jalplOHhpUXNDcU9UaEkrcmxFUVE2Y3FjWkRCUjZiU1Zw?=
 =?utf-8?B?bTRwU1A3NTRGQW0vTjVuSGRkZnY4T0taMlo3N1ZaSWxVUlQwckpzRnFyNzdL?=
 =?utf-8?B?bXFSdFFyMXhjdFVueGtwN2lWaUlYeTNvVmtlSHdzbEE0RzZNdkRHbHZIZmJ4?=
 =?utf-8?B?bnVjcktvZHZ2ekxFVDdRTVA4U0gxc0FXa3dqY3NlRTZ5OUg3MUhmSG92L25p?=
 =?utf-8?B?ZWNRK1BKcXpUdy91OGF1b2xKeGo2Y2NYa0xCb0ZRWUoxZ2dhcVgwcnFPRE02?=
 =?utf-8?B?RTVNb2p4TitqeDUrZ3Z3cDdRVXVDRkFXbnBCdFJ2SnVwaHlXeWtpYnZHbkZo?=
 =?utf-8?B?VkZnb2x3aXhWaXd3R3EyeHdZTEE1aE05WTIweDI5dDE5Znhkb1ltN252bDNh?=
 =?utf-8?B?d2hEdlcwb3ZPY1o5RlZhS1F3aElBV3YrKzJzbWNRK0dMQ3U0ZWptcHg3SjBY?=
 =?utf-8?B?MWhJNDhwa3RhNjRSV3BRRHVzd1A2N1Z2OW9QWW92czdpQm9YNW04ZEtLUDU0?=
 =?utf-8?B?MUFPaGdsQksvUzZ5WFd2RGNkZ1BJT0s4YnN1SFh6NzU0Q0ZRVE5qYTZjK3Fx?=
 =?utf-8?B?Q05wcForYnhIQnZWaXlBWk14NlRjUVFtUUtXYkJQNDFBRjRlV3N6TWRkZ1M2?=
 =?utf-8?B?ZnprV1UyMUpyanJxTElwSlBmdXpKdTlnbHZaOXFGZ3l5Tlh2YTlSdHJ3UExx?=
 =?utf-8?B?a0ZFdHcyUVo4Ui9KcUl6Q00rVjFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C79421B51FE53446B0ADF1D3493BDC4B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7/gpE1/AIFckeOWZ+pxvs2mKb/32TB5IV/7w8/p++UOTSV9Ey7jq3d9sc8K02dID5QXhOwdQ36ueTJBfgBCLfrh+X7rP2BFPDdawjdDBIjhhN/lh1kpDE4SGkYZgCNY7vKxTjOtPeltRkzoiE3UZYLcI/7zQ73pI5PVRrKLiGucc6EWWhq2M+qkluQLfBHPLvbHni+8Z7mmZwlCYSFPdmx05xeRaSCqa5EhPWtPEHBEe3LULHh9uy7ug+qF7GVco2qysUqSolYzOHFJwzggWL7aViCYqtcGhUUN3Vcw/svUI97mS7XsQY04XppNG1dZkulo16qwsAaDL4m6GVbStKDWOqlKqWTqrlIJrTp9KbRerIByYUx73XzRU+WjysO/VC63CKwKNj/eu/JogiMhUyKoppK9udQpiAO5O3/1rn7y45m6RFZ3yCrhpsfyMe/e5vmj0ope4zz9CQlBMEvTBw0Dr+HTfQ6Z1vukDc9m9rV1bpBv/138X1+KR4WRU14rNELcrrFq9Oe+rwzkNAmjYCh+ppZxpJoHGLLAAgaIM2dwxo/J1ffQSJW6XFULjwSzDlLmHm3dxY+X/nG98zlZg9FXTPgljg/y7twAlavOh9VLoZLh8WRj/GgxrJhERZGby
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77899033-bb95-4ff3-0f05-08de1525fee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 06:56:46.7562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IchYbi8eGopWsKOkU9laO49Om6Q9rrlApmHeSzcrGadLM3Mh+IICx1SbV/QvSNCgrtPWjkwuZEjBh/44+zvCGRudEm5CoZ7bCweXcLumC8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB9059

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
