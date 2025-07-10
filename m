Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3228E575
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141605; cv=fail; b=eex2qC/h3ugTG5Ek/2VKBrc/En5GEE5kQRuMJqadnMAzfefxr2N0ngQed3TTtZSpg2a4b9ry8KITqppG0KMtcYPL3bfuJv/AUfx4kHu5bZAZxWdS0DhcMjzIz5Jvrx2Rq97w8snU1IFBBFZJOxWk+wqZ/f4YA81xIi9r0f4zQJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141605; c=relaxed/simple;
	bh=kAvjg9s6jrtLg4seSCxcmhpxqwx86CxIKw5H2MhjdEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JUWlYo0I898XmE98qAV2j0wsXE24DChI9Gmnx/sbPdhk0sWShBwQByiJ6nrtu167L/XWEIKfpt+aUtU4dNLyUqwLmALvkAPYW+eItDpcWjmuEqaIALJVqpu0pKeEQLS3F1+s3fB8UyiHZGpOQeGEGufYutI7j7jO/z6/DvOuQmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kxU1u+DO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LoG3ZPdN; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kxU1u+DO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LoG3ZPdN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752141603; x=1783677603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kAvjg9s6jrtLg4seSCxcmhpxqwx86CxIKw5H2MhjdEE=;
  b=kxU1u+DOoplC+8Ye2JZjYve1UzeI3B+zkVlQNgxNiV0QhCw+8xsygPAS
   Dl3z7E199R5MCrWYqqjf7r/U/KaBTAxsBBuvquRivDDrPQSRQtYUW3tzb
   bWzwB3dLRYMCUT+ZcWHCfhLFxbZkxRcd74nD0UEyk5jsQyNfzLkzK7b1c
   hQS/K3uiIVRqXMYl5LlJs2Lsfs8/CzGZ6OnOqD4NVypiQjItcjTLebuHe
   z83uofuXl7wBQvhF0m6+GMCdUvkvzEmthZ1ZQe7UiCOVwF+1DoZX1l+IR
   HoowUdwi820U1qH5RyHjPn37pGVILNx5HTKzMMKFEFkHOwTeb7zwzXL+m
   A==;
X-CSE-ConnectionGUID: frtQFkxoRmCDtuDwUS+tUg==
X-CSE-MsgGUID: k9sWu+MQTNi6U5eKTF9vxQ==
X-IronPort-AV: E=Sophos;i="6.16,300,1744041600"; 
   d="scan'208";a="86763402"
Received: from mail-bn1nam02on2055.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([40.107.212.55])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2025 17:59:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nycoWcuSCODmkCKVGVCKEir3zFLV3Y9AOq9buJJtlk4N1Ap2YjF+94iDQHHkPHn3kX/ESW8zmTuybEC9t52jD+oTGPtsdjSTNgnLiUW9jqzcDcU0/SrtTPj1oNUPsocW5FVgI+TBYYdnhNuMjyhh+EMR+v0mUQHHND/l83lLl7XgBMJ3ZLKnjzM0SXKVgpy5ygjyqf88FJFlqkAa1BbvVXzRFmcSyTbt02WyqbA5smjqII0hXQKZZV9IMB1pVEgCHpkhI5Em0SfNhrdaba7xlafXik5qQO9rPnRsu+n20tZPuNdXa5BaEFdh0yarYPL9e+KN40S8XkiOLAOT56uNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAvjg9s6jrtLg4seSCxcmhpxqwx86CxIKw5H2MhjdEE=;
 b=lNeczFsQ3ZRwreN6N9UtUXlUztZqbTjgXqoEdej06JY8XciNwRRPNU93Vn/ogjCEpYg4Lnhb6kyMKPjgUWXoz+o7up/WNRKxjzz2S+U4GE7jv2qFkiiSD46N0lCBqg6BiOF5uI+jA3ouYXDuepPubpneGwz8Zr2Q2Bn713eztnJ/W7X/SVTtwZrnyE15c+qDc4VaZJCfaRpYpxcFtNljFMWapP3MXkP9z3mQ6kT5J0CbaOYeuYsYMFCV9r/gF52EM+EcrzWAN0slzt5kg6EizgVzkizP8hTfE5aYR/nCLZcpeYFBJ+vPsCHNEevcz0NktIpRUKmYafjaotMC+V7Ttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAvjg9s6jrtLg4seSCxcmhpxqwx86CxIKw5H2MhjdEE=;
 b=LoG3ZPdNELs9bB5tRQB/N5RniQE/y9HEX2fqE68U7agqS6woWapyFu5bc56FgibR4zonqH/7OQDm7u4re3T0x7w1rjevXcwgWnlF0H6rGsdBmEwTdhLiTMgAq7/D9h456ippyfDgBpNsgCGec25iMRPMwSVYpxSkqZswYzbzZ+A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6999.namprd04.prod.outlook.com (2603:10b6:610:91::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 09:59:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 09:59:54 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC: hch <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 1/5] blktrace: add zoned block commands to blk_fill_rwbs
Thread-Topic: [PATCH 1/5] blktrace: add zoned block commands to blk_fill_rwbs
Thread-Index: AQHb8Mc5SBDvG05QgkaafWBcWGVVyLQqwHiAgABgvIA=
Date: Thu, 10 Jul 2025 09:59:54 +0000
Message-ID: <8641c74d-e527-4005-b0b6-d2dc41fb9afe@wdc.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-2-johannes.thumshirn@wdc.com>
 <41730c5c-33cf-45bd-a0eb-44057da37eaa@kernel.org>
In-Reply-To: <41730c5c-33cf-45bd-a0eb-44057da37eaa@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6999:EE_
x-ms-office365-filtering-correlation-id: efc09296-3e4f-462f-5c5e-08ddbf9884f7
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UitrRkxvbEpOSUdUVkxHanFRQVhpOFFmV3g5bHVHb0gvVzh4T2IrZ0ZaMzFT?=
 =?utf-8?B?QzNCeStsWW9zdjhxUzhDSHhqNnYycXN3RGNYbmVXTWdEQlQ3M09zWmhCMmti?=
 =?utf-8?B?OWgyT3IxM1Y3VXpkZFk0aWhpVzhMUk8xT0ZPeHVHT25TcUFveWFpVE5lY09t?=
 =?utf-8?B?ZmtVQ3pGaHNoNGh1Qi9DYndBa1RpNkRCMzhuWW5tck5QaGt6b09ndmNNY0NE?=
 =?utf-8?B?VkpmSnBpZ01odDI0b3V2T2hyZTNSZGcwMExkbmtIUGdNOE93M0RCTUU3ZE9N?=
 =?utf-8?B?dUYrWXp4NlpxRGdXTHJiYWlGOXdnWG9ZY1IvdDJleUZMWUMxVFlITUppYUh1?=
 =?utf-8?B?R0lqbjJIaFNFTytnMTk1T29DWlZBNndaWnlIQVpYN1hMMG1NbkE0alFTNmkw?=
 =?utf-8?B?ZVA4eFE0MWxRVHdFek5Jeis3Y2VDdUx6VXUyZ21ncnFTamVwUVg5L0tIa1pY?=
 =?utf-8?B?L1o4UnEvSUNqS3Rha2JLamhJUjR2QkJaYklQaEp4SmtrTmJPQ1FQYmtIMitZ?=
 =?utf-8?B?d3JGL0ZEZ3ZaUzhCNi9XVjlGWEJMWWVLZzVvakM2VmFPbWQ2QklURTVBUnpW?=
 =?utf-8?B?UGVVK09ZS2lUQ2taZXRMekVISlN4WDcvc1NrZE9GelNSckpPbGVKK3NwUU45?=
 =?utf-8?B?V0RNdnE2QytZSEhWNFAvL2thaXh6elVHd2NwbEo0eUQvZ1RSTHVadnFoc1F5?=
 =?utf-8?B?Q0dFYlBlcTkrZlhVT3RBNThPZk9qanp5NHhVWlZGN1ZYYnh6VVZSbFpPd0FG?=
 =?utf-8?B?R1FIZVpUckVnNEM0UWoxcGg2RGlRUFBwMU1JWmxQY1dVaWZ3aERxU0piMkZQ?=
 =?utf-8?B?UzgzK2E5UytsTm12R2VyRlBFSS9Tc3AxY1NKT2xNOU9VMEh6V1JOU0E4WU83?=
 =?utf-8?B?K0lYOUw0cnRvOXlQSXQ1a2xhWU11bll6cURhS2pGTHR0RmtvaGl3eWRaK24w?=
 =?utf-8?B?a05RQlI1YWpNL2hiRG14NXRKMmN1dGRpeXNCMHd3MWRaK0JWL1BQQXJzRFBa?=
 =?utf-8?B?VlpBUnpsWEVMek9sWW9UNFQyWjYzYXFMaG96a01EUWFMcHJQM1pvd1YvWFU1?=
 =?utf-8?B?UFh3bVFBd1liZlhQYjNjZVp4QkN0NnRjSUcxR1lNeFBsUG1PNkdKdXlTQk9X?=
 =?utf-8?B?ZXljY3VWVjUyUGl6eEs5YTdEZHBYVURFMEtTZVZHZkJpb0p0WTk3T1c1c0lp?=
 =?utf-8?B?Z1RHVWxIc1RBSXhJN1FoWDZhbHNQRXhFMEtOVXJqdGZWbG5pendlWlJaOWcx?=
 =?utf-8?B?VDE2L0JRTzhmN0QrSXFyYSsvTmxtVWQzMkhzNDQxT1VqaGV3RTdyNDVBaUxt?=
 =?utf-8?B?Um4wYnVjbXNPM2RKUFpVWUluek5nM3J5Yk1YZ1MweGJYWjR6OTRteVoyU1FG?=
 =?utf-8?B?N0RCL1UwVUxEN1UyNTN6N2FpNE4yR0RuektFRWJGT1ZYK3ZSYlZjQ2dzN0hv?=
 =?utf-8?B?N0FsYVY4MjJrSHhLQWpzOURTMXNVejVwbzh0eHRIdFJvdjlDL0RwVTc0Y3k1?=
 =?utf-8?B?UnM5NWxIRFZxN20rUmZZUHcrM0k5VFlLdk1WUWJPTlI5RFZDUjRZb24wN0ZH?=
 =?utf-8?B?cE1oclVLSFBrRUNrN3VGRk5ub0IrNzFqOCtLNnhoUVcxWVZHYnR6TjJiK29B?=
 =?utf-8?B?SlZ4eWljVGJ2dHdDdVl0MDNTUXVmZnN4RHJzZWtEQWdZd1oyNnBLYTRJT0pN?=
 =?utf-8?B?QzhkRDNINmx0anNMU3ZFZ2h3TDlmMVM2SGF1RUQ4TzNzL1JhWkdpZDFQaXZw?=
 =?utf-8?B?MWVpdnJJbXlqRzRiNVRTR01UYWNOcklpMWdTUXovd0tIQmw1TmJONVoraUVh?=
 =?utf-8?B?UVUzMEpYMW94WjBuTEZrYzFDNDljNVpZVmUxZ1lVZWtBbmlSY1BFeGZqVVNw?=
 =?utf-8?B?V095N0s2djYwK05OTmVyVkJHL1lQL2g1VUFkTFZ4Q01xdFBTRGhPKy9SK3dR?=
 =?utf-8?B?YXV0dTRBTGpLSXpraUh3YjZRdWdka1dHaWl1ZDBId0J6TCtRZXB0eTlHUEds?=
 =?utf-8?B?dVhMdFlYWi9BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUt0RGxGNSs0b25ESDlIdmt6aDV2VnNwLzBUTmh2VExwL1pwL1ZGaTkxL3VI?=
 =?utf-8?B?dmJ6K254ZkcvcG53eVFzY25XZUVvNFpQZkJLdjd2OW1BY0VRYk5kWk1Qd3VL?=
 =?utf-8?B?VTU5VHA5Zml3WFpEcWw5OGt1bzFMSlRGL0FQRDBnRTQrTjIzRi9VOVVxVVJo?=
 =?utf-8?B?T1FDZmRsMGp1UGo2ZEQ2WVJiUC9sZGJSSEUwUHdZbnpnKzZ2dG11ZTZmWFMy?=
 =?utf-8?B?YjFJd05KQWdvQmF0Z0Fkd0xDTmprck5ZYXN5eU9iWjkxTkRvcU1iSEllR1NF?=
 =?utf-8?B?eU9qTU1YUWR0VklCekdyd014SXg4RXppdDF2NnpLQkp0THNCU1BPRWEvZURR?=
 =?utf-8?B?enE3QnZCc0Z2eGVzTURZdDRpZVk1TzBKZzBkRmlVa0NDbHAwMmdaaDV6MlYr?=
 =?utf-8?B?cVdvR0ZMc3dCUEViOEdLc1BRYjR2U0Y4ZlM3THViSm1ZViswM0I2V1ltNnhJ?=
 =?utf-8?B?aHJRb3B1UkVmeFpwdDVVMmVucktHcStwUExWaDZQLzhRMGJiMjJEc0pFbnV3?=
 =?utf-8?B?bnU4WlVUcEtCTzU4R1I5VVo0OHp1R2hoeU5xaXAyNGF1N2YwaEoxZERyWjJG?=
 =?utf-8?B?cGxkd29YM0ljUFZHSUZLb3Y3RVlzbnJZWkZiaUF6aGlNeGpWQm9xNzhBbjRZ?=
 =?utf-8?B?M0FZWVNlcUJUMCs3VElldzVqYkEvMlE1bUI1K0VIRStnYlpsaWJ6bERPLzJu?=
 =?utf-8?B?Y2FmcCtLWnMvVUhldmtvNVlpMm9Rc0Y3OVV3emh4WithREhJalloOUk4R09m?=
 =?utf-8?B?K1dmZzZHL1RiMEc2YnQ0cDcxUnl3UnNXT0dabVVaWUVxSlQ2TWNTek93UlIx?=
 =?utf-8?B?Zlk3Tjh3UEdaSVZpaVF1ZDZGeEFyUDJJeXBZTXVpMGRDRFRDNGM3N3d3WnFp?=
 =?utf-8?B?VFduZ0dqcE4vUEI4MVZxVjVXYnNHT2lHQ0pSQzNoSmtzNXhPTzROeENIVW5P?=
 =?utf-8?B?dVRGQ0R1a3lwYjNVR2tLNWx2TzAxbENhYkpIR2NRQkZ2SkNuY2huTWZqTEox?=
 =?utf-8?B?WWx1b1Qvam0wQUlnOVd3OWJsc3ZpdGk3WnJlOGYrT0ZtQUtHb3VNcTF6OVRs?=
 =?utf-8?B?NmJ0NlFQdTJMaTRxcUtGQm9sTW55T2lXa0xBbkhsT3BSUVcwVURhbmFabEZZ?=
 =?utf-8?B?MWx0NFZ2cVZLK1BUd096dmVOZkhxdEFyTEtIVFNEcklFVzBOT0ZycHJMZTdR?=
 =?utf-8?B?KzU1UldCcDNUem5nS2hRQ3ZXZWZJWk5kR3hLQ05zaDhabTdLU2ErNTJRODg0?=
 =?utf-8?B?WVFxK1JiME45cWVoSER6VFBzM0FHSDZnaWwxNkFRZUxqdHV1NnVWa3FJUHdG?=
 =?utf-8?B?dEJhN05hUlpnQTM5Z0ZxRHdEQlZ1SWd0R2lrOTEwU3pSRlMvVUU2d2V4cGpB?=
 =?utf-8?B?WER1VmlSWnB0Ykdvdno5am1hQkhGVitLN0VhY3lBQWlSMmpSeVZpYmRsSndp?=
 =?utf-8?B?NWtkYkhsVktnVXNJak1kV1JQL1BTZDRDMTRHZDVnb3RqYUQ3UEl2d04rTzJv?=
 =?utf-8?B?NnRCS3hOWFkrQTFYZVorSHJoaGg0bU4vSURob2pwbDI3cUs5RWNIalRrZXVF?=
 =?utf-8?B?N2xQRHM0YitEWkNiSmdJOEorbWF1UWkwMmtaNlRiOHpHNXp0UG1BQ0Z6VTZl?=
 =?utf-8?B?Nlg5WTFOUWdoOC9QRVdlV1ptSXZTc2JaRlBhZ2VMbE0vOFNaNnphRlp4ZFN5?=
 =?utf-8?B?N0VYSnRVSXp0blV3OFBTeS9RY3M3dlJZUXhQc1B1ZXJ2SXFYQzIrUk1aaTEz?=
 =?utf-8?B?UldzL1VIZGlNYXk5Vk5NdkhXd3JzTTZJTWtYb2NTNkNMeHl2RFlIK2Y2Y3dZ?=
 =?utf-8?B?ZzNqeGl2aURtZUV3THQxdDJpMlNuclZ6MFB2QkgwUWxJbkRhK0dqQTMyZHpK?=
 =?utf-8?B?MktLdGZpcTRHaFhwUmhSQVp0em5qcUIzNjliY0FUSHlaY1ZHVEZGWjlVdGpp?=
 =?utf-8?B?TzFXeXhVU0tLQk91d0UzR24wYWJKOWhXakhVenJhRFBrQXFBQkxLd3FVUnlS?=
 =?utf-8?B?WUhJZGxtQ1hwTDh5UWVkMWZZdmxjM1lUNHpkYXU4cXBDZHU4NWtwYkRsVXht?=
 =?utf-8?B?ZWRDZTUvUnBJb1dDcmhOZ2ZJemlYS0NMT3M0L0V6TkwzN3EyMk5XSXUrcXhn?=
 =?utf-8?B?eVYzNGpsUDN2Q3pqL21vWEpkUC9BeHA0dzJDMGExNkJmRHdqZTVrYzJHNm5J?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F50308E090134F40888E1DC6EC65AD0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oLPnOpt4XRb8JKlD1ZSfnhfLtm6hq5k0znV2F5xK7aY5WE4Weoty1CG9wmYTWKl+l/Wk5wHFMZh7sqKXYNKVoLqWsSmdnww2pRQEjcRBP3cv1wM7CSRy5y/BSnKVN1nRlN7ILmJMeaDcQc/ddONkzg3aRqBpALxlumca4BDSZ/tejYXcPvkpmwIeazYj6fKL9G1OcfC/QNYb/uVVMNKaNdLL+gYrum2MDKRjFAW468RnjCatqjganWiloqcctHegb9KjwE5U4mNnKYdWCSuKj8OExGFhQp8+bmMrlY7/6Qr2upPP5SHsFUWsjkNhdhKXTiGYMdnsG9+GTHNDdQuOHIHw5vcMbuUyUbwe5w8kuZ6YK26CaWCxSaDPQFv786i2DYqczFXDLOFlnYkllbjo1IvgBKEbTyWaRyLzNkqdC8tem0H0Sg8pUJFLziunwJ9PbNSkFBZ5+Xk09f/l2yvCpCCC08T4Tj4LyEi0JEwkDPqQ7F/IaF59DK9jo+zXlV7CRdttxtbfBXrWaUvB7q4lfFsNggtoxEK4HF0n1AKaAy3aA5hTUVIOeot90LLg9josLgNuW8SfvIgdWa2LbPVNwa/IqTsCfBO9bled9fsdmGLJwinlG1WV7NjdntdpLF2g
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc09296-3e4f-462f-5c5e-08ddbf9884f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 09:59:54.3046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCR0UHHs/KsRXqH7iQO9QULYYRzt01kEVr5U2ZhkhelQpbl5m/OOFFOqOoMmfAXIrLtDMgJG9uAhY8Zc+sWmZ3KKQb9T1339S9ZljSekl3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6999

T24gMTAuMDcuMjUgMDY6MTYsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBPbiA3LzkvMjUgODo0
NyBQTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gQWRkIHpvbmVkIGJsb2NrIGNvbW1h
bmRzIHRvIGJsa19maWxsX3J3YnM6DQo+Pg0KPj4gLSBaT05FIEFQUEVORCB3aWxsIGJlIGRlY29k
ZWQgYXMgJ1pBJw0KPj4gLSBaT05FIFJFU0VUIGFuZCBaT05FIFJFU0VUIEFMTCB3aWxsIGJlIGRl
Y29kZWQgYXMgJ1pSJw0KPj4gLSBaT05FIEZJTklTSCB3aWxsIGJlIGRlY29kZWQgYXMgJ1pGJw0K
Pj4gLSBaT05FIE9QRU4gd2lsbCBiZSBkZWNvZGVkIGFzICdaTycNCj4+IC0gWk9ORSBDTE9TRSB3
aWxsIGJlIGRlY29kZWQgYXMgJ1pDJw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRo
dW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+PiAtLS0NCj4+ICAga2VybmVs
L3RyYWNlL2Jsa3RyYWNlLmMgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3Ry
YWNlL2Jsa3RyYWNlLmMgYi9rZXJuZWwvdHJhY2UvYmxrdHJhY2UuYw0KPj4gaW5kZXggM2Y2YTdi
ZGM2ZWRmLi5mMWRjMDBjMjJlMzcgMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwvdHJhY2UvYmxrdHJh
Y2UuYw0KPj4gKysrIGIva2VybmVsL3RyYWNlL2Jsa3RyYWNlLmMNCj4+IEBAIC0xODc1LDYgKzE4
NzUsMjcgQEAgdm9pZCBibGtfZmlsbF9yd2JzKGNoYXIgKnJ3YnMsIGJsa19vcGZfdCBvcGYpDQo+
PiAgIAljYXNlIFJFUV9PUF9SRUFEOg0KPj4gICAJCXJ3YnNbaSsrXSA9ICdSJzsNCj4+ICAgCQli
cmVhazsNCj4gDQo+IE1heSBiZSBlbmNsb2RlIHRoaXMgbmV3IGh1bmsgdW5kZXIgYSAjaWZkZWYg
Q09ORklHX0JMS19ERVZfWk9ORUQgPw0KDQpJJ2QgcHJlZmVyIG5vdCB0byBhKSBJIGRpc2xpa2Ug
I2lmZGVmIGluIC5jIGZpbGVzIGFuZCBiKSBpbiBvdGhlciBjYXNlcyANCihpLmUuIHN1Ym1pdF9i
aW9fbm9hY2N0KCkgd2UgZG9uJ3QgaWZkZWYgYXMgZWl0aGVyLg0KDQpPZiBjYXVzZSBub25lIG9m
IHRoaXMgaXMgYSBuby1nbywgc28gaXQncyBhbGwgcGVyc29uYWwgcHJlZmVyZW5jZSBhbmQgDQpJ
J2xsIGRvIHdoYXRldmVyIEplbnMgd2FudHMgaGVyZS4NCg0KPj4gKwljYXNlIFJFUV9PUF9aT05F
X0FQUEVORDoNCj4+ICsJCXJ3YnNbaSsrXSA9ICdaJzsNCj4+ICsJCXJ3YnNbaSsrXSA9ICdBJzsN
Cj4+ICsJCWJyZWFrOw0KPj4gKwljYXNlIFJFUV9PUF9aT05FX1JFU0VUOg0KPj4gKwljYXNlIFJF
UV9PUF9aT05FX1JFU0VUX0FMTDoNCj4+ICsJCXJ3YnNbaSsrXSA9ICdaJzsNCj4+ICsJCXJ3YnNb
aSsrXSA9ICdSJzsNCj4gDQo+IEkgd291bGQgcmVhbGx5IHByZWZlciB0aGUgYWJpbGl0eSB0byBk
aXN0aW5ndWlzaCBzaW5nbGUgem9uZSByZXNldCBhbmQgYWxsDQo+IHpvbmVzIHJlc2V0Li4uIEFy
ZSB3ZSBsaW1pdGVkIHRvIDIgY2hhcnMgZm9yIHRoZSBvcGVyYXRpb24gbmFtZSA/IElmIG5vdCwN
Cj4gbWFraW5nIFJFUV9PUF9aT05FX1JFU0VUX0FMTCBiZSAiWlJBIiB3b3VsZCBiZSBiZXR0ZXIg
SSB0aGluay4gSWYgeW91IHdhbnQgdG8NCj4gcHJlc2VydmUgdGhlIDIgY2hhcnMgZm9yIHRoZSBv
cCBuYW1lLCB0aGVuIG1heWJlIC4uLiBubyBnb28gaWRlYS4uLiBOYW1pbmcgaXMNCj4gaGFyZCA6
KQ0KDQpBZ2FpbiwgSSdkIHByZWZlciB0aGUgMiBjaGFycyB2ZXJzaW9uLCBhcyBhIFJFU0VUIEFM
TCBjYW4gYmUgDQpkaXN0aW5ndWlzaGVkIGZvcm0gYSBwbGFpbiBSRVNFVCBieSB0aGUgbnVtYmVy
IG9mIHNlY3RvcnMgKHNlZSBwYXRjaCANCjQvNSkgYW5kIHdlIHdvdWxkIG5lZWQgdG8gYnVtcCBS
V0JTX0xFTi4NCg0KQnV0IG9mIGNhdXNlIHRoaXMgYXMgd2VsbCBpcyBwZXJzb25hbCBwcmVmZXJl
bmNlIGFuZCBJIGNhbiBnbyBlaXRoZXIgDQp3YXkuIFdoYXRldmVyIGlzIHByZWZlcnJlZCBieSBl
dmVyeW9uZS4NCg==
