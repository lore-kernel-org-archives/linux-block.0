Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAB1369A1
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998927; cv=fail; b=ZComHtV1UciMXyVXylFJmABpK9EB1jff7VUvWyouZCkZNWrz0t9nPsu9V+V3lffDVEO+O5+gECehVdpuolIOvkGBVRUM9BXurtytStS1yBsOsFoOP6+2bVcXn/ZhWHCrGm0Lf+gK4NIRJU0b5hmFxjuiaVA3nwdxTgJ7GvBB0rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998927; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h62Y6hfQ3Vf3Z2ak/y5SojLCFJfilfl7zjeeWc5CR2FDmqEwOP7gNduafy+8L0lOb3zR5H4dKmY9QRCfKNvqh1MxAHCZxE2ygFovypI+/iOx21Mg0hA0Nbcgaih1ddXk5cqtvrucpB1A6S7EAgYRcLUC8Hvbao4FpXs6ZJJ11Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TJVmHArZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0Hzohzmz; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TJVmHArZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0Hzohzmz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719998925; x=1751534925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=TJVmHArZsEdl9oOzP3hN3jiyml54sKUEEcVS9NzNoUNNiOuZDJ5zodHd
   H2rtYqbiO1aLjf13PoEFZ4BURxyiNa5FQzrM3A8o9+s38iD8+meiw7diL
   ozNZlvcIUkKFP6weR1hPmaW/cVTiBjaYqh5LE+xWj+zr9vwMNrzBUu3Lj
   OVb2xLNh5b3G25HahpHGMOW0LBJZvG0DertESLO5TrwpNmMvxjm5qQMYI
   lh+TR+Lr+rrJCwODCf7SqO9FhBWxqqpXFCzPT97ENYQ1bEZMEvZYtvR6d
   PbCBiJGzZtMVnsrB/vLaD1htQKfTobYTRPwJVCKy1zkObp29tjMVtcpIt
   Q==;
X-CSE-ConnectionGUID: svmvQOuNQYWAmENAyJ34Ew==
X-CSE-MsgGUID: ekhO70V6Qo28XKuU3EQoSw==
X-IronPort-AV: E=Sophos;i="6.09,181,1716220800"; 
   d="scan'208";a="20456100"
Received: from mail-eastusazlp17010007.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.7])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2024 17:28:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIDy78IR4Sr7160s4vhm8GgKQQray/h+m6FYVCaHiSdcx+PY8921zVZhxnxEIqq9c4Y7zUkZv+xdE0hUyzqG30Ugd3032QAazMSexsvbePb0lb0EuYsQIqvZdpc3i19cPpMV9U45pESgbOwDYajnoJ880nM6ZvZpjJozaBcPvBJdLijyKleGErBXaxCRNtTnWO6l/71L/E8FvK+sV/dQhOSThGk2ff9X2mHjLr973mC6cMYo0qSLLh3PGeXUReul/eCu+iZV/8jrAfv5TXjK0rab/E2q1jdI/8w4xVmo20wnRKqOS7SkLXbthPhQPY5OC18mk5vkL/gPH3lIRppqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Pb0xOOoulpBUlFs8lFc5sZ5C7epU+AreHZFGFlt/E9ct26bH68fSjFpmvZQlu8XQ9QfT05fxBbuHN21Fs7XCTbxiisCc242GnvD/EJPmgQeWhCX7FWAOUibxDs/r6XqH0iIcpNhf2hv1kPjIhKyoZ/yhH4W13pIHFghKOJuOOYCfgJGIDTe/h7oBD1sGz4Hd6O/zx57j4uKGZHQRqvp80yPeZ3Y2ur3YW8oLfLwqpBmNDpspOiBXUhRxVEMbtVy+bjA44iuwAOHk5ll13P6qFWcqMNPX+1O6Oz54AhrhgDrI0Lsm3IsDndrMbisH0NfSuOq3u4fM46z35By2WqP+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=0Hzohzmz9aMonAPG0Vi/VaAw6KRNCRWhfwliCl0Wsuj7v9w4l1ya46jCwa+s5H/UF/e5/0c8q/7f4B0fkJ96J58MH4+nw8ApLJxHLY99PHK/6pAgXm31XqnUx80rZESymMkOewsghpt383vgFWcB5JJSYOrEmeITuo6c08t5WyM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6381.namprd04.prod.outlook.com (2603:10b6:208:1a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 09:28:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 09:28:40 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/6] block: split integrity support out of bio.h
Thread-Topic: [PATCH 1/6] block: split integrity support out of bio.h
Thread-Index: AQHazJISV16iXAsEjEC5QJTevB/4FbHkvaMA
Date: Wed, 3 Jul 2024 09:28:40 +0000
Message-ID: <fa20c5cd-aab9-47ef-a0f2-fb3ed03bdd51@wdc.com>
References: <20240702151047.1746127-1-hch@lst.de>
 <20240702151047.1746127-2-hch@lst.de>
In-Reply-To: <20240702151047.1746127-2-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6381:EE_
x-ms-office365-filtering-correlation-id: 35f1f890-d2ff-4c41-2d55-08dc9b428698
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SGE3cE5Kajg3WXp4Y3R4NngzUkVxcVN0TEdmSXkvQzRyUzlUS1F1dUpEZ2VS?=
 =?utf-8?B?MmNnVTV0bWFmeFhNR3g5elRYdjUrVnlOSFpZckFDRFRyQ29NNVZjendKZFR0?=
 =?utf-8?B?Qzk2bTNxZmZLM2NYT2RyREpUckpXemJSeVhBOUY1RVZzQWpRYzM0TDhwS0VS?=
 =?utf-8?B?dE1RVks5VGcvSjBSNHZUR0RmU3EyTTJHcWh4NWRPWWFxZ1o2RTE5bU81ekEy?=
 =?utf-8?B?c3lENTYwaDdNZHQrWFIxUHhFMk1kclRvbDRHL3I2b09NL3dmdGgxMHkxWkJk?=
 =?utf-8?B?aUp4SFB6NnBOZFpvMkZhSERxWGhWUUxGTEpFZEdKSXpxV3ZNUmhJWEIxRThO?=
 =?utf-8?B?a2hOQmMrb0FVc1BkaVc1UDVEMDF4MkRkT3BaRW12c2FDZDFDeFMwNi9YcGpI?=
 =?utf-8?B?SkpXQXFZWU83c1dTOXgxbC8rSEhCTUJ5WVo3RUI4cnRhaU5Ra0FSQzE1TFVp?=
 =?utf-8?B?T1lVVjZ3TEhxS3lhRjdqUGpTRkd1aG9QMFJ6eU0zaWVXQVZXdkt6L0Z5Y0ZV?=
 =?utf-8?B?Q29OSW9OcWtKcGdCMEJTNTdhQkdscEhjSW51UzM1TEs4di9vUGt1c3ZwVE54?=
 =?utf-8?B?QnZaU2xxS2hWNHNpalZFYnlkNlBFMEpRbWtSYm1yUVVUQjNYa256bnlpaFZK?=
 =?utf-8?B?VFdvUU9CR3U0SEc5eit2RnNpeVlLeTJjNkxENHJXNHR6bTYxU0NVelN1a3o2?=
 =?utf-8?B?NjlKTzBFcUZLZ2lvdHQ3MXlWb3Zsdks1Q0RjWDdNalBqMUxzV2tRVm85dFZn?=
 =?utf-8?B?anB1ai9hb1lzRTB4SkpoUVllTy9xaEFkRWh0VVU1SWlmbFMxYTVqdXdvUVg3?=
 =?utf-8?B?WENmK0h2WlpXd0ltOHVaa1A3QmExTUNUa29JWFIwUmRRRy9WZjQ5YVZJVER2?=
 =?utf-8?B?bUU2c2ppTUpMQTQxRnhxQnVmQk1RNTNXWS9makRYYm5MMkxLaHRlaTd2OVIx?=
 =?utf-8?B?TEMzWDFuRHROQWVCejZhdTlhOTFMVnV5dGs3WXpWTFRtKzNaUW10eHArLzZt?=
 =?utf-8?B?NHZDZk9aajdJMWhBdk9QSUJicHJkU0VDaHk1R1BTaCszdWhoeDJWMklNSFhB?=
 =?utf-8?B?QWJQVkVTWnVxUlNaVUdhdFdFajE4Q1U1STBac05laGZyMlUzSkF1TEM2dHFJ?=
 =?utf-8?B?TnlxM2pvR05ZeDdXNzlBa3FwdEk5dmdPU01BREYzVVhaZUE2RkF6bENGSDh4?=
 =?utf-8?B?QWNuWkRSeUs1YnlEMzc0T24rc1NyLzBlRzVNWmloV3NaU01jajVZa0pzb0k5?=
 =?utf-8?B?U2I5OXQ5Q3BPQUJRRTlMeWVycGdPMlV4WWVjZ1RqRXZZZ1QzOWhoQ3d6V3FR?=
 =?utf-8?B?dis3Z0FQYURKWitXd25Xd3BBMjVvejlyWUh4YzBBakE4RmtZcmlpNVFGMEk4?=
 =?utf-8?B?Tk1zNHZud1NuNlZoNTBRS1ZxR2xoQkZDQlVrQkJDRExjWkxIMVNKRGJkSnNx?=
 =?utf-8?B?aWY3ODMraS9ZNUlCR1lTMWZyMXFjM3hEQVd4RnY2bmJZMTk4eXpod3FXdUtR?=
 =?utf-8?B?Q1QzZlgzTDd3V1hvL1lOY05qVUpuOHBnaU83SnJSeisvZXJDNitVNE4wSWND?=
 =?utf-8?B?RXZGU2hZM2ZrRTFXMHdHTERJaEpMK0puTWgwN05LYkx0eDh0bGRITkJCaHlH?=
 =?utf-8?B?dHBXSkVxK0prSWIvL25aUHJCbGtwemYrSGlUci9zS3NZSkh2b3FnbHRBOXdO?=
 =?utf-8?B?bjVZZXZsSnBhckR2a2xZa00vTUFWNFNwOFgwaVFaU0lySE1uUEY3QTVma2Iy?=
 =?utf-8?B?Z1BKM2lYY2ZtaDlCRjM1K2owOVE0UmRjcG1KWWx4dXh2MnJyZ0l1TnVCaUVV?=
 =?utf-8?B?elExbFJDNFpOUlY0RVhOUVNFSmhyRU9JdjhhbXZBbmdxLzNUODh0cGlEbmtw?=
 =?utf-8?B?YU5TOEI3TGtKbExVUFkxaFlDN3dOb0FieVV2Z2o3YW9EbWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXhZWlcrZE5vM2ZyYll3VCt2eFVDVFZvSWM0bWc4US9qYURPWGprc0NYZEFm?=
 =?utf-8?B?UGZCc29OaFJaRUE1OGJBUzltMDl0OC9Fem5wYi9VTXo4b0NKNVFYdGxHdTJi?=
 =?utf-8?B?Y0tXZnRETG1OMjNUdnIzQ3hoWFgrNFhJblBIUUcySklJMXhMUFA0SXZvVWlY?=
 =?utf-8?B?aGp5N0ZOeGM5L0xPcHVtelNCNjR1Y3k0c0RZOHhpblBRV055amlQSHNMZ2hV?=
 =?utf-8?B?WG9MeFh5cEJZOW4va3NSc1VkeXNCNzVzd2NsMm53a3NTYlhUWW43aEtnbGNx?=
 =?utf-8?B?djFpYzc2VVM2TC9pa2t5eGNRb2FnQkwxNlJsMS9OekJCeklQc3ZJZU9pUUsr?=
 =?utf-8?B?MmZCa3JNSnF0UHpqd283UmR0a0tGcnVLQnNMSERseUpzaXdWQmdsdzk3M2JF?=
 =?utf-8?B?MUhHaEtyYW9MTUZ1SzMxeGs3NkZQZ3E2bE1iNm05dDFUanRnS1Vla0JKbnl0?=
 =?utf-8?B?elFuVTZwMWVoNUh4eFYxTTMrSGh6aitIR2xVOGphbDRnQVloSHA2OGkwTFdU?=
 =?utf-8?B?bFBJdjBMbEJZZGl4MzBDWitrTVhFdjJjVURNZGQ4bGZWcTZ0WGMycG5ObFBE?=
 =?utf-8?B?cEltdSsxandzSnYxNlJteElqeVFJMkM4WkgxUCtXSFVwQWxYWXY5U0dCVzl3?=
 =?utf-8?B?VGZyd0V4QWZYZjh5ckh2ZzV2ZVYvOUxidHllVkY1NzdFditiaFpPakRRSW11?=
 =?utf-8?B?dG1qNGRUcXZUZHVGbVpOL3RJN2xVOFVrL3ZYY1BQRVpQdXFhNU1jaXlWRUwy?=
 =?utf-8?B?TXloZVlROWp2dS9tN0tEei9Rb0RQUTZTVGYwQ1JzMnZpY0ZycDNXU09tSGpw?=
 =?utf-8?B?V1cvVUxkb1ZMMUlqVVdaTUdzcUpLK3BTTVdJV081ci9kMVdRSUJIT2lqOUdK?=
 =?utf-8?B?dEROQTdtNG5nN0Zmbk9ONUprV1pSeG1ldExoWGRRTXA3NlNJRW9uVzRiaEZB?=
 =?utf-8?B?ZVhQZG4zRlJxbmVGWkE5a1FNMVZtejNPRmMyTkV3d2l4bHZoTTBnOXNBT1lB?=
 =?utf-8?B?OVMyb2dYQ0JCZUQ0UlJVb3ZiNHBsbEcyMWZ0SnhaVXl0YzV6bU1mUjBGWWdn?=
 =?utf-8?B?T3JEbXo5ajFYbzBZTEt1QUZyRWxvMGVtcG9kWW0wRkdMK3pWTnRKVUJRdGZI?=
 =?utf-8?B?WnhpNys1T21YVmo3NE1tR1hvMFV3U3dzcStqSWxxRGo3VC9jZ2s5TFc0U3M4?=
 =?utf-8?B?OEZxTktCVmE1eldiYWtzQkdXMWVPM3ZCeEhxb1Q4bkQ1SjZ6dlJRWFBXdml1?=
 =?utf-8?B?N0NHUDJwcFR0clZhcTVoUzYxRWhNOTdQRUNEMVJTT0VvaWw1dFc3MjROVkpx?=
 =?utf-8?B?QWR1OGdaZ0dWenBFVlQzYzVBcVdrVUZSdk5pTGIxYS95STQwYjdhZmhYb0VE?=
 =?utf-8?B?OGsxSUZlU3Vya0FRK1BhS3hHTzdrNlNDcEJYaExsaTdMN2srWXk2VXNiMWRp?=
 =?utf-8?B?N2h3SkczMDQ3NmVhV3ErMU5KVXhhcnRNNEJvVWZKWnFacU9ZSGg3aSs0S3Z4?=
 =?utf-8?B?d3g2ZWFja1hmOWEyYjVMemZwaDhiSEp0dXBDNnFIbXg4QVdNV3I2QjN6UjdH?=
 =?utf-8?B?UnJoQytHa1h1WDdEdC82V0NCczVhdCtsL1hXSWdQWWR0dGlLV240NEN1YzNY?=
 =?utf-8?B?T1NGdVRlczFqcC9nSUhZNFBTYzRCcjNSWTRkNGUvUkhtM0h3R3J1eWZCVUdT?=
 =?utf-8?B?eTdzVlJEUUdJc2hsT0t5ZlNMdml0YWxNM3VIWDNTZldoeXpNdUtSdGlLUmJz?=
 =?utf-8?B?SFpVQzNKRytxOGFwWjRiLzhWcU5JZG1lMERCWGY0aXQyUXc1RkJILzBtdzNL?=
 =?utf-8?B?TWZxQkI0UnpEUlArT0xYYk9INndsQTVjRURNalNNMW0xM3NPNlFNajA3S2s2?=
 =?utf-8?B?VzRpSi9lVTczWGJHUW1rQmdiaWFQQzl3QmJacTJlNVV2YmhMamtpOTAra0JG?=
 =?utf-8?B?NmpVVzBuWnhVNVQ2cHVkNlNkbDNFVHRlcm5sNXcveWdLc1JmTnpySWxaSERU?=
 =?utf-8?B?MVE5M0Y2TEtsdFNmRUl3MjhsVm5ET2NsWUNBc3JBcGF1aGVvc2UwREtueUZ4?=
 =?utf-8?B?U1dIVWFBdzEwUzZzWkFOaDJucXVuRmpHcUFsRWRoNFoveS9EODZmbklHVWlK?=
 =?utf-8?B?MUhIZXloUlZYdUFQS3V5UXNoakhnTDhqNHUxTHd1YU9NUEUrbzVMUUZTNm55?=
 =?utf-8?B?YWxRNU14RUMrTVRkZ1Zubnl6cmc2UEE2cGkxM0dkWG1tcTFVRHBBdStZdFAw?=
 =?utf-8?B?cjlXOG10YVRxY2Z5SGNXYzU1d2tnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7D1C0C700C1294FAC84992D70ABF3AD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GzsoL01IG0B3rDr/X+p8+2tf7Iz3HDunjyKc1yZYGOEylE8jfcM4l4KyctOCxjq9gkatO4XRKkC3bWD+caA1efLTf11Un7UzaJLOALwFGRDykrWgN51OK+MJXwJ8BNAyEhdX2HEFFIbacTEOTU36CEXU0I9NheUVlix93hIrqrf4YLcX8eGhixVwVLVbJH/GHSSMh0c1GxC0gYW76rMSrwAv3aYJlGq0Z5SqiL5LIl1pp6+vnxIJiV/OBJYIAfLwTzxyjDOrWRiImlB+Mvc5WvGrryX+gaqdWthuPn+HTtFYx0Ydi7ABlIPZbhjJ8KRffSzTz7IuN23zdd8XKhiMJcgUtDpHRbhtndvIGH2SupC5D/lO2BfCsYEpggj83ws7UwMEyMNAcMEUz8MqMAIdm6g/n2uD3Jc4jhLgpkIV09KOoJkEVr+cCAd98CjIqmJSC5rAUU7o1QureIqri+xgan53En+TA78vQ8TGg8LXGY8FBP1VQSDIntPG2Eb1X7m9fSei+aDBlu6K2eLCO8iCgUiOfOwwSNsccexu2nGNiF8jvkYuC8fxOymy3DrRSSHUolL0//+j2koYqZkyl5ZdGhlj01onInWvi0mNa+MoSjZmSEhf7TKrvryTFsKCKYNK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f1f890-d2ff-4c41-2d55-08dc9b428698
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 09:28:40.7491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4pA6Q4x5kM07iQx47eYlL8V8l0Ym97sHVeSfywL1TSW67fiK0rzDb/xgjhEn/LBtHk8ebt1IZ57bG6M3hB0oq6glOwIDbpZjd2bNIRj6Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6381

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
