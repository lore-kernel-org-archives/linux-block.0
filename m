Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E8219A7A;
	Sun,  9 Nov 2025 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762711131; cv=fail; b=Q51GFi3n+DkGdaa3gcXXBqxE4SpzvaXanh0Vk9LAcdmNrQRbBcTzt8vFrn7YeG+OQam9SJhLFr6oMIJ49CnMqmI7AEk8Cziye0rLDhAf4FW8aYYluipK6dkQ/7jXxH48gakVqajiehsB/RGYLNTyxQikDGFgWZF/lP/XgiP4lCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762711131; c=relaxed/simple;
	bh=+XCOOjm+peVcZG8pWFsac7cT1eDTUXb1L4wB1Q9XZMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RhLU1HpsxcElNr5jhbAw67E9cimqxHjhMNTqvrfQcLb//uYMDJEckpwfj/WDTVhiDbEioP1F75jyNzv5PFGcjvhjZDyHoKA5s+k5zY+DdZpCI7mNg2Me6drC8jXT0bXrUYPBzZA53eD00BRociEFX+S1O/7rsfv9h6luSWBnhtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M/n8ERxm; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M/n8ERxm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8aDyv9xRcpLEi2EtCUhfNCBzsioSzRrdbQE6/E8gnXUMHpWeeF2rFa3ctz/gA+dciHBBcIt5UI5pTGsve82n5B1zjtgb76FhrHWa/60wEHbcx95Og5aIf1SrtKg43fZbJx0gXBSJlMFMLVctg8tuhDIryMeaFGEQmmfm+5gZ9/yr0U77ORnA8z5ZA4I4eapsFRFjNF8hNRHyjTmtKC8YnH7P4kceqhpumvnBWx+c0TQPJmB5dX1nAn4Q0ZOavR4Zz7YgPBR3TbIUy0vZq4BF3SgdThVX/crCwASkbAIu6vmu0x1dfG0hKJMr3cj7Q+FwtDJJpLW5VQgRU97hBKrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XCOOjm+peVcZG8pWFsac7cT1eDTUXb1L4wB1Q9XZMY=;
 b=GwwjAKCR2hFzaMdn490tvZMmAwqKTWdj0/mVTV3joNj2ItjwONJph2z5EcruD4N255iXnHW9nkvdkE78q7MoBM33QOAVhHrS86eLvcBfdx62zM8pgIYAUdYwtOy8Yvaouu5C8XdeDWbm2MOUIAowMojpf8PDUzZBuRJnvecLHUIm7htcpb3TUBgoEvDKChXueI8h62pAOmV44W/B91IOx3kmUaHhXCRnxC74b3sTXxGh332gTBwk6fE+3ap0EICRNJp4TR6V56OJkOoZxq+tv0tkmQZ6pqRiMs2QuWyCnvQKFfrMN/EminBM5cm7fX6seH61ZdFD0pnJYUmuPa0Xhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XCOOjm+peVcZG8pWFsac7cT1eDTUXb1L4wB1Q9XZMY=;
 b=M/n8ERxmuECR5JaoKK5RWOFvy/zUlznCOL8IB9rSrkIB/T8/VDIcirQwn4gyYWtHJkAf8XLYZdoZrFnlIin096hT81HQhaqg9BpY2YDWyYWeMNuI1gEQ0QCHvl6tehpjhQuombNrzJQhXsR4ASJ0FILayH6oG7QFviJRUNLzRY4EO9pIBHLeILKbJ2l0tCBKcbGjT9DMy8/GieNSXGqhaEpo2Q+SBmxxE780E/IvhlmHSFFP/IGQ49JADXISWpOGy39YIb/wflPCxfyyeu1M3EnbKK7u+1khPwESCuEg0DMR/woJ2Ej6h+MCCaFCTaJxdpksz6SMZaY+/lPXWwARgg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 17:58:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 17:58:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Caleb Sander Mateos <csander@purestorage.com>, Ming Lei
	<ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ublk: remove unnecessary checks in
 ublk_check_and_get_req()
Thread-Topic: [PATCH] ublk: remove unnecessary checks in
 ublk_check_and_get_req()
Thread-Index: AQHcUP2NjWug8eJxlk6AxejioxgD67TqowKA
Date: Sun, 9 Nov 2025 17:58:47 +0000
Message-ID: <cd973fc3-cac2-4bc8-8c58-1d06631a781e@nvidia.com>
References: <20251108221746.4159333-1-csander@purestorage.com>
In-Reply-To: <20251108221746.4159333-1-csander@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8969:EE_
x-ms-office365-filtering-correlation-id: 7abbd92f-89c2-4cd3-e3ca-08de1fb9a1cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2dveEEzU2hSZFUxZlo0bEVYcmM1R3M1V0t2NGJWRGxsTDkvNFgrZUNIT01M?=
 =?utf-8?B?TUxLTFBNRFovRnJ1Ujh0cjFyYjBnSllCdFJCZ2dqK2k0NnN5cnJRYlBxemRn?=
 =?utf-8?B?UzAvdWZvSi9qV256MkRuY1ZzZ2RuTlFFT1lTWkJwT0NkTDQ2S1pVZTdITUJ3?=
 =?utf-8?B?bWdQQ2pLeWF4cmpKRWg3ODNMK2luMC8rVVllWFlYWHNVSndGYzBVazVOaUJi?=
 =?utf-8?B?RXlnamZPaFFzSWZyc21rTFpBQkZUYVpBNkFCNG5ndlpLRnRSbGtyZ3huNWN6?=
 =?utf-8?B?eWZoZGI1ek5uK3ZvbGZqa0hFWWJBTDhHQkpuUWx1R2xrNGhXQTJpZFF3UTdD?=
 =?utf-8?B?bWxOc0tiVFJkUm1VTmUwWmtoMHJJZFNrejdLenJSd2dMT2NHL1VxVjRaa0lk?=
 =?utf-8?B?TGVMRjBiQ3lFN2toOFdhVjFPb1ZuRFVTeTFWZGxwM3EvZ2crWW1KN0pwZW1B?=
 =?utf-8?B?NzBVWHE2blFuRVVZMU1YVTIrckVTdkZCeml0V21tc3ltdjFjZ1JBbE5HWnd2?=
 =?utf-8?B?RmNIb0JkOWZHb3laNlhvaWFPWEtoRE9Xbk9ybWxGbTlmbjdhUUpZYWtGMmlT?=
 =?utf-8?B?bm1xRmt6NDZVYUFNZU5xTkZ0TlVFWTV1N0xxREVmek5YQzhqUEdGZjJxSlNL?=
 =?utf-8?B?ZktUOU43ZXhjenlYUzVySktZb2ZCenZISGRaRWlBZGtmNVVCR3VCUzBXUUdo?=
 =?utf-8?B?WUJxQytaNlBaZHlSSHZHcENjeHdKRVA0Y0h0SzkyWXZaRHRQMjhNTkJIN0VT?=
 =?utf-8?B?eUs3aXN3d21YVU9TZDFUNUM2SmRyWTVDZE80OUN2WE9LT2lzNi9SSStkQlY2?=
 =?utf-8?B?UlorZVQrbEtmcWdXNENpVkN1T0V5UVRYc3ZvNm4vN3NNUy9nVzhndEJ0U1FK?=
 =?utf-8?B?UDdJNURHUXZaY0JOb003WG00OCtBOThvYmV5cnhCY3FQVXpnTXNwWk1PbktD?=
 =?utf-8?B?bTc4N1VvMTJJYnJtYVUrSXNHRHlrU3NKWTFHeHZIZk1maHFIODR3V2Q1QzNQ?=
 =?utf-8?B?ZGVVRWl3SVpFazkreENhN1h5cmVLTVZ0a0pXanM2WVpJUnI4dmxDTGlHUGQ3?=
 =?utf-8?B?L2U4WDYydzhCdXFEQkZJU0lpN1Jnak1Pd2lLcFVTUmVKZDVqWkNCVUo2QUVh?=
 =?utf-8?B?UVBKOGJkck9iZGNacDVDQmlLTElWdDRUcmVXdEU2N25OcWZKOTVuNCtUc1Ri?=
 =?utf-8?B?bldEaGdQTnpubUIycWUwUTJJei9yb0NQTkI3c1FrQlFObEcxdGJnbzVBY2Y0?=
 =?utf-8?B?WXkyUHdyOE1PTDdRM3RSbXNFaTJhN3BnTHEwQmVkYVJJM1V0UjZnOVR0S0dB?=
 =?utf-8?B?WDFRZXp4ZzFzeUV3ZFJjeFBaZ2U5V014TDNKcW15QWZnSUVhQWMzeDI0a2Nt?=
 =?utf-8?B?MDJ6Z2V0dmVvT3hTOTdoV2lqSGhwZGNGQ2t3ZGFXSkQ4dHBIeld2bERhMWtH?=
 =?utf-8?B?bnNKUWJEeVZobVEwc1VmeTd3ZXRhcWk0bm9KVWk2LzhRUFJDWGtWVzlYTjNL?=
 =?utf-8?B?TnZVaWk2d3FqRTBtajZXRG1zUDNTR3BRQ2Eyd29jbHBwV3p0dEZCU1pDQXpY?=
 =?utf-8?B?YjZ6VkhFUllYa1Vxb1ZxMnh5UVlPcFFPZVpMTWJlNUR4Rm5JQjFRZ3E2OHJC?=
 =?utf-8?B?NHU0cWprVVM0SHVGVzkxakxrSjg5VzBmNUg4VjF3TnpvN29uVnhNbzZlY1Mz?=
 =?utf-8?B?dmFpYjdJSWRkbm5GVmllSDlTNW9XOTF6cEo0MURUTE1IeG1tWEE2TFZsOUVO?=
 =?utf-8?B?bU9qR2ZFcmsyQXVWcnVPeXVuTi9xS0tQenlaMmc1Mm9SYVJBSVFqT3Y0c2c1?=
 =?utf-8?B?QjNmUEtaTXFNK1Q5MEVoR3prQjFsUUVEaUxaQ2MvS0kzYlMyK3huVEhvb01k?=
 =?utf-8?B?ZFM3RjlES1VURXVCL1F5MGFmc1BqalB5Uk1Hazc0TmMxT25DUk5UalVnMlhE?=
 =?utf-8?B?TDZBL2Z5QnJJcVUrd0thVDBHSWZLUi93WDM1NWlhZlkwd0YySGQvaG5wL2c0?=
 =?utf-8?B?U21GMWk4L0VUUWJDMU54TWFqcCtpR3NRdUtwK1FSMWNWTjdVWUJTcjdmQlJx?=
 =?utf-8?Q?z2LHFY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aW5vMmtTSEpFdG9RUEhoYnE3ZGk2a1pNZ0h3bFR1SzFFOTJHdnVDNW40T3E0?=
 =?utf-8?B?U3VSQktwU0RIS3dDM0QzL05BZGFGN1IrdmFIVWxCUktsa0V0bks3K2tIRUxv?=
 =?utf-8?B?R3R4NVlCQ29sRUZrT0drMnBIcU1ORTlKbUhBcHZEbGoxbVY0OU1kMXNqZXVq?=
 =?utf-8?B?S1ptS1JuTFFhWmJTR2E3TUxKUUd0K3FRbnBMZTFpbUJyaTRnTXh6WGZFd1pa?=
 =?utf-8?B?cXFabjBKS2liOG5ERkYwYjR0NlNJa3YrQ3NONmlkQlkrc3VWaU9xbXhMMWVQ?=
 =?utf-8?B?eEZray83dFhycG1iRTlJVkRVaWs1T05zNHNWeHNTU0swOTR5MnlFU2s5dWpG?=
 =?utf-8?B?bzVwU1haMEpUbVl0NHpRZ3ZSektuaFNmQjlMaEZpbnlLOThiaGUwcTRFbDF1?=
 =?utf-8?B?dWlVSUNoOW9tMjJyM1hlVkJ4WWYzRkFzK2ozWWRtRU5HU2NxeFdZMzFIUVFk?=
 =?utf-8?B?ajJCaytXZFBpTEd2YlEvbktGYkR2VmYrYW5NNlVBOC82cWdRRnlEK1lsLzBO?=
 =?utf-8?B?RGtBVUJCZG82amhTOW1rdmVRMXZIbDZxZDFwQlUxdFlZdlZubVZGVVM3UHVw?=
 =?utf-8?B?ZXRnallkdFNMbFQ3aTZtck1IY2RZa0Q1aUlsdmtuajFUN3lGUSt2Sk5ReGlu?=
 =?utf-8?B?K2puN2pPWXIxS0FhN1FkeVQxZEMrdHE1eUtXRlR4RjQrS0V4WkJiOUxnb1J4?=
 =?utf-8?B?dWlQMG1VOVQ0eWlpcW9LU3ZrRTlRZGlpcU4xOXpDRWg5bk1nVm9DSXNURElk?=
 =?utf-8?B?TDNrQUtNelJ6MmRieVMydHFzZmFzUkZnN29xOVlZZ25rVnZqalVWSllOT2Ro?=
 =?utf-8?B?ZS9NcFNKYzc0NG9Va3lZQVpnNndSaTFiUkdoTDZ4czF1WVlPSkhnUkR3M0wr?=
 =?utf-8?B?V2Y4eUFVUndpVkpPY1pqTDl0alZQMnQ3Vkx4ekQ4dWF4NzZlNUZqWmt0OEQ2?=
 =?utf-8?B?YlcwbVVIeTJTaVEySWZ2SWJaMEZ3b0VxcXA5N2RFeGgvQi9lREx3TVRKS2dL?=
 =?utf-8?B?ak8yMXFWUm5RR1AzRllFMk05bFBRcytCSmZNYmxtVjFweG1TOGJ0QXlUSFFa?=
 =?utf-8?B?OGhLczNkbXd0OXlVS1FKZHZjT3ZybnB6eU9XbVdDellxeDV0RlYraGJkVXUw?=
 =?utf-8?B?dzZvUmJvMVlNUUtleGxHbERYRm14cm5uUGxTeVZocDU1ZTJJaytWK3prbzVH?=
 =?utf-8?B?bTJ6Ty81UW53N3RmaDBVaXRNT2swY0FOTXNUUzJDSHlSMzJQd05EMnVERm9l?=
 =?utf-8?B?Z1pFOWI3VHZUaUhDZitRWG5Cd1c1WmMvbHphNmI5SC9QakhYOWN6UXQwZnhF?=
 =?utf-8?B?T2V4Z25GZUdiSkdTSlpsQXlWVEV0M1ZobGRDRzFZYzZ6U3FRTkVkSE9ZOEUv?=
 =?utf-8?B?M3NncDc4dThTT1RZRFJKWEdta2FJbnZLZHpJQWZPUnNYZ1J5M2VBZ3h0aC9D?=
 =?utf-8?B?OWZjUW9obi9HWW0yZzBBRWNmdnZjZTYrdTQxR1FGelg2SlR6bjRNOUxHTEI0?=
 =?utf-8?B?N3ZWSm1ibzBHNkFMUjRyeFA2aUNiay94OUdFcWhNSHdqYVZZWnhIWkdSeXI2?=
 =?utf-8?B?VzhBWXhOOEt6cFlQaS8zUmtjN1E5Ym1nUHJxbHlWTVhaUWRxQWt3QTlUU3JF?=
 =?utf-8?B?K1czeXhjOFBjOCt6dHJwUUNYeFlZWFRhYzVJSnpQaklaMG4xcnFnNXI0S1Z0?=
 =?utf-8?B?R05xY2xodVJIOHRIYnRnbS9hUEI3ZVFIUXRuM2NFdURjVG4rQWtOU2dPK3JI?=
 =?utf-8?B?UjlFMmtoYWRkU05xOVNjd2N5d0ZpM0pHTXZoNlRpUjhmd1Z0STZJNFNZbmg2?=
 =?utf-8?B?ZHZEUjFueFN6RWtuRElRUm9VSXlWODV1QVhobllINURiWG56UU1BUTJDeW1u?=
 =?utf-8?B?aVlZajJ5QjNPM3NzZVJjNG4vdzBpbHcyaTJGZ3JGYkJNWGZjN2hGdnpQd3JH?=
 =?utf-8?B?ejRtU1FXWnJvTHlzQlpZRDZmNEV5QW5sNDVpRXkxMjVNNFNUenQ0Wk5tT0J0?=
 =?utf-8?B?SWJhSjkvRTN2aVk2M1BTdmpFRzFCOGdyQXJmdXhUNGpsdExVMmZycGVxTUtV?=
 =?utf-8?B?ZW85MDYrdk9nOFdJY2ZtbVd0QzBXclhrYkpmYzlzbzhCNm9tM2lRU1lYRmFa?=
 =?utf-8?B?VUNoMk1HbHlrOEZrZ2srNmdNeDVVVHVBcUw3TVNmOHZwN2cvMVR5ay9OQXJ5?=
 =?utf-8?Q?70mQH4jYyPxjllXimkT+y0kUB0fnZritbNnQ8lmh6nS2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E43CD2C54A1E74CBD37DFCCAE214771@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abbd92f-89c2-4cd3-e3ca-08de1fb9a1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2025 17:58:47.7077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S46IXCYXXvzzAHSGSXTxoXo87gPi7X68CoVrkJ0hjZ8X+o8RkhCTrrMuz1ElfI04M1Aml90bIIOOgyiIYpvgsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969

T24gMTEvOC8yNSAxNDoxNywgQ2FsZWIgU2FuZGVyIE1hdGVvcyB3cm90ZToNCj4gdWIgPSBpb2Ni
LT5raV9maWxwLT5wcml2YXRlX2RhdGEgY2Fubm90IGJlIE5VTEwsIGFzIGl0J3Mgc2V0IGluDQo+
IHVibGtfY2hfb3BlbigpIGJlZm9yZSBpdCByZXR1cm5zIHN1Y2Nlc2Z1bGx5LiByZXEtPm1xX2hj
dHggY2Fubm90IGJlDQo+IE5VTEwgYXMgYW55IGluZmxpZ2h0IHVibGsgcmVxdWVzdCBtdXN0IGJl
bG9uZyB0byBzb21lIHF1ZXVlLiBBbmQNCj4gcmVxLT5tcV9oY3R4LT5kcml2ZXJfZGF0YSBjYW5u
b3QgYmUgTlVMTCBhcyBpdCdzIHNldCB0byB0aGUgdWJsa19xdWV1ZQ0KPiBwb2ludGVyIGluIHVi
bGtfaW5pdF9oY3R4KCkuIFNvIGRyb3AgdGhlIHVubmVjZXNzYXJ5IGNoZWNrcy4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogQ2FsZWIgU2FuZGVyIE1hdGVvczxjc2FuZGVyQHB1cmVzdG9yYWdlLmNvbT4N
Cj4gLS0tDQoNCkluZGVlZCwgTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg0K
