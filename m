Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D413D2AF
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998878; cv=fail; b=MLLHUJS1jKK2LBE3TWpbNg/jrItmYgucX+/Xc0iwcMCquvfiqZzqfuASWmer09CZwXUHdoh//ZsYHbT+RF7j0heeoBoml9F1zgBtZJq0bESABEmq+7G/pltVbrAkue9Arf0iU+w3TmCvMasW38CuanSIABNdPOX7obbjwcG/uf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998878; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=byF/LLHES8pXYnn3uNP/7s5tGh0rXGXx9JYMbHniG+D0WRT37FV8VDSwlU9q3bNMj22OJfU83nxu3g7ZuuDxOq4ogg8qhsL47ADjoS95FKsAZUx8pkIPV53gCmBpSi3J/iykHS6Qs2NV0CFKmKw6hf6c8DshJuqLWNyV1zP33nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=myNTXNGg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=MeL/BsTD; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="myNTXNGg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MeL/BsTD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719998877; x=1751534877;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=myNTXNGgtuu/XjV3ufBL9E3NgW8DJZ/tRw7R9vsebj3T5MM9khENfPLR
   MZaqAYOCp1dJNpZ/TyU6NZNbCctehPaw6G32FCa8aAruyCRFB0HWR/FNk
   JpEMVd4bThnjAIIv7JVDgVclM0Wsju67Lv96RFUxdt5lWoLh+cvdFrMk+
   +Hpvd/q6rFdbu9qcd9h+anb9BpH9Bx0OY9knwIOa3/rUmA4QpBoynYHGu
   KK1ZtTO0zhwsQurEVaZvDB7xFmMYSkhvxivNxwNo8sEULlBOAjYMx46rS
   0iGV9a2F5Tcg7mg6Q9/aH2i+da6iPAw9WCbAQf/Ry7t0iZvAah0B5Tc57
   g==;
X-CSE-ConnectionGUID: TK0sErJfR4u8oo8bI0EV9Q==
X-CSE-MsgGUID: +Fj+hh5uQrSd3raUR7cZAQ==
X-IronPort-AV: E=Sophos;i="6.09,181,1716220800"; 
   d="scan'208";a="20456042"
Received: from mail-northcentralusazlp17010006.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.6])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2024 17:27:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffcTfWgXi9oRQycKI2Stsn4OwCxIgbEzjgvRnTFfkbT3R5XwE3oqD8A8f2Jh77h4P9Q6hcmPlWXLMIdoLog2qNxqkk4mandlsmaWXZV75jfD9lOyU1bheBFU7/XmKy+KaM+tv6jJvwh+hTQaVd6pVpGpozTobanQMzYRCTzBAgDuOlYMHbW0Yb1bInePib0BW1EvC1QhKduEsLgNXjg3p27HPUoPZzfhuqh/oqebXTbHi9SRyXWWtoWrJ6o9VGe/iwo4HhF9Y0Mul7k42C1/PMaRovfiZmrBkSeArYeCzc8ldZZmqxKSAmL6sdg0prPak2cfd0++6pFghLJhkX6iCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ViXbS9B01LeUlqzkeglYqGK1qUrKfZno8FZOvhMxEH+Kj/bK/yIoAOEB55v6KADoMig9ehQPt3Wyoultt7z77gaAF+rTZQ7o9lXjM3k/DBWZ6Co2BgJP3FsqeUKB7pulPqgDryYbGTqbug6pN+n2hiv4YOTJTw3La0/z2OIBCmh9Rd58CKUS06OskXrUQZ4ZiCb+NiMTPeQeF/8G2y1QbCVfmbJanKqW4sfZ2TVymXyj9mQ3WIQM3VAvlBkEvSgKX3bW89aQHYZ5wLf0ACYwJD1ELuW3fT7YhXdLWWmHpKdilxndyfFr6Tw/dJYRdMgAJHv5YQ6iLAdyTLrtsQFRFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=MeL/BsTDFoW5KR9tgMIlgvfRDOjaj3fw0Bha2WEFHpFTguVTSdJpt9c1poWZ2+q9lCs5f9RGP4cLl0OglqBIqq/oPKWMKLB4fhXrW0FFKh42fgqWxzX65xory4j/a6Y4Ho0oilqnpDK/CYTWLw5b8MEWKlyI3Y2cL4mPwZrsrOk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6381.namprd04.prod.outlook.com (2603:10b6:208:1a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 09:27:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 09:27:48 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove QUEUE_FLAG_STOPPED
Thread-Topic: [PATCH] block: remove QUEUE_FLAG_STOPPED
Thread-Index: AQHazQh+OLS0teN0v0iFGR1WH3CoQLHkvHeA
Date: Wed, 3 Jul 2024 09:27:47 +0000
Message-ID: <2a35274d-bd59-458c-ab48-1bf93fb81d9b@wdc.com>
References: <20240703051834.1771374-1-hch@lst.de>
In-Reply-To: <20240703051834.1771374-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6381:EE_
x-ms-office365-filtering-correlation-id: 23b453d0-ea6f-44e2-d3a6-08dc9b426707
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWdNK29vVUxTdmQyN0RtcTNkSmhBdE8vS003MWdGL3JFVENmWmVtaDBUeEVa?=
 =?utf-8?B?dXVTSWNhYnBXZHFsYmRZZVBnTlkxekF0cjJsVDBPekdLdkR4dTlVbzl1OWF5?=
 =?utf-8?B?N3ZGR2RQNTVqSXZFV0tBcGVqYzVTNC9WajJUMDdrMWpHUko5SS9NKzdXR3Bi?=
 =?utf-8?B?RkdaK05YREJuZmRIQUY5Vms4dnYzTjlaL3I0Q1VYaklRZFNGQm1GdlJxTC81?=
 =?utf-8?B?Y2sxd2I5Q3E5NWxXanppZ2JpNlI5RjZvWVVlYVVsak1aSW5hWkFCSUY1UHRk?=
 =?utf-8?B?WmZJSkFzc1EyajlabjVtUHJMWmlqNEw1UnRjVzQ5SktLeGJJMlBlZXBOMHR3?=
 =?utf-8?B?dFlaanRCLzF4WEFVNzdZdmlsOTQwVlk1c1NIVUYrQmN0MTE5UUtzUGFCZTZN?=
 =?utf-8?B?TU1GWVpjeC92K0pNUjIwVlR1VnNHYmFKRm9zcFJnQUhiZWNuZ3FXd05YcktX?=
 =?utf-8?B?Y0owMXlTZmYyeC9Oa2lsL3hVNThXWFhjMjFObER3ZmhDWnpVT1h4WWsvQ1M3?=
 =?utf-8?B?aURLQU03bFVUcURvd2RaQXlqcEJQT3hEdlpsRzRGa1dML1hibzZGQm5uK0No?=
 =?utf-8?B?dzRFN1cyR0pVMS9YNnBPSEdIdUhicUY3SXVSRTdNSHJUbHptclpRWmJ5SG5Z?=
 =?utf-8?B?RWkwTHFsbHhOQ3dYWnhzRFNqNlNRbVEza2UweVVNQkNwRTlYdjRtaE4wWFRz?=
 =?utf-8?B?WFlPRy9VOUpJbTRFT2FSTDhVakJnaHVxVWxXSFNKVmRna09zUTNuNU15bWJ4?=
 =?utf-8?B?N0NRM0x0Q0lzL2lWUzV5VWpGbjI2bEVvckthU1Q5ZDhnNXQzaHZvd01WcjRB?=
 =?utf-8?B?TTJ5a1NkaGdMY3NxTDBkdm03Qk9KWVFRUDNhdXNGa0NieExQNTk0SXZ4UEVa?=
 =?utf-8?B?MVZwSExBL3ArWFlsNlUrME0waDIvMVYxUkdKcFE2dWZYVHY3QU12RGszUWZK?=
 =?utf-8?B?cytrZmMwbTFveWVRRklmb2JvelZxbXNXSkJZVlpTSXJaZ2h2aWo2cHZDZmtv?=
 =?utf-8?B?bkpaWkwzY2w4R1Q0OTVSR3UydHpIcmYyblI0VW5hSFFjQ3hGeGkvbXFHQXk4?=
 =?utf-8?B?Y2p2YkhrVU5TNVU5clNDMlMrbFZVeFZkd2VBOEpBQnlqZURNM1RUM2JIeWxm?=
 =?utf-8?B?SGVDcGhNV1JMblVqejNDajJxMFhkRzJnMnVsaDl5UzBKMG40blduNHEyUjhQ?=
 =?utf-8?B?RnZTMzBjQ1Q1Q1d4WXppcmlIYndGYnYyajcrSVk2Q3lRS1lWa0QyU1MxZktm?=
 =?utf-8?B?SFdHdThjd0MzRXR6UGl6VmxjVk5vS3FTZE85M1pkT2lNME96WE14YmJOZWlH?=
 =?utf-8?B?dGlUbHZXdXJLQldLajlLY1JNY0Q3THF4TUxPWHE3MnpRcS9QZFE3NzY1TmUv?=
 =?utf-8?B?aTJBSXJEU1NxTnJ0K0x1WTVEME1lTXVkYUdRMDRud0I3VGpYQ1FZQnB0TGl4?=
 =?utf-8?B?RFA4S3U3Q0NyQlAxRnNmK1ZXVC9Kd1JiakpkY1NaOExlemtUbjczWEJpT2Y2?=
 =?utf-8?B?amVKSTlwZlFKQTh4TlVvM1ZFd0QyZHBpbHViMGNiVVdPNzQzRWdBWWdjdWJK?=
 =?utf-8?B?My9pdkQ5eTNxZnZCdlAyN2xmN09XNEZ4bHVmL29pdk9vbXJEc2RJSmpENnlv?=
 =?utf-8?B?YXVoTTBYaVFUQlNKTzA4bWdqY21sTXdHN0NOVVFySkZTTzM4azJsaDJaZEQx?=
 =?utf-8?B?amU1cFo0TW9TKy8yNzJIdjFhRVYzZUpvc2MyZjB3QXVwRE9RWEhPS3JocFBy?=
 =?utf-8?B?dElUWlJranNyRFZpRjBqcjY5VGVycjRwL0NGVE9vcThqUnB4MEtjT3JNYXlR?=
 =?utf-8?B?VnluNUNsUFdBL1U5YWwrS0ZZN2MxdW42SndFbUtoaEFkd0lOd0E1eExyWXR4?=
 =?utf-8?B?RVFXdXd0NWZZcHRWMFdiWUREcXRORlRTREZlOXo5RzlYTGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDgzU2FJNmVDaVI0ODRpeG5qM3NaNHZoZWhNNTVsQVRyT21QamZQcllScGRF?=
 =?utf-8?B?NlJNWWxDSzQ0QmR1TGY0cHJEUFgyVG5tK3lKUjJseU9jcWdsdXNvbnBtOTBX?=
 =?utf-8?B?azBMYnBJUGRxQktjUVdycHJacFM2TlpsUkJ3SDRRNDNzaHFPMjNCaFBUM21I?=
 =?utf-8?B?cHBUZnZ0VTFDSGFJc2o2eEFkMUgxUTFSRUF2eU92OHM2Z3IzenEzdFFLNzFm?=
 =?utf-8?B?bUlHcUhtdys1aTl1S3NDT21sV2xhbjVuSWVOMzhOOW53S2xPeUhRM29hS3VD?=
 =?utf-8?B?K3hiYzh4T2kyeFgrVFRDZVJ6bEtYR2ZER1ZTcktER3lpQkVCYjAzbmNocWt6?=
 =?utf-8?B?OFlydHZ5Z3VYaThXUzdyVG11SW5aR2ptQjR1VWZlMXZDZWZCbmtVOG1uMXRt?=
 =?utf-8?B?dXZsMkhIajBjTzhoUW8wZHQ4WUhPRzdsUEFPbzJ3NWk3QUkrdkJ4QVA2MUd1?=
 =?utf-8?B?YnZBQkh4OGlhV2pXSnpYUkY3TlQ1dE1GZjNGVnJyZWM5OVRSM00wVHp5M05E?=
 =?utf-8?B?bWlaamVvRUpDdGpUWFN4bDBvSzV1MGZEeXNWdzlwVi94NThWVm5LQWxRK3FY?=
 =?utf-8?B?aHNtaFhCbmFKTGJJTnZoTDZkYXpGTXZYektscUFQb2VNaXA2MEg4ZTFPVGVs?=
 =?utf-8?B?YkQxWkxST3VwZlBNemhIaS9seVl0ZWZpUmY4NUM3aDlQVlRUTmt5VVNDNmg3?=
 =?utf-8?B?OTlQdzMvZzVRSDRVVzZ5Z29SYzVoRFhaT05BQk1peUV3QUtCeEtlbU4xNHJ3?=
 =?utf-8?B?aXV2Q29qaHJMM1VWWXp6R3BzeTBBc1ltTzljcmsvR2JWQTJWaG9WR0ZQUHpF?=
 =?utf-8?B?ZFlBdzZhM3I0NHNRQWp3Vnl3SGF0cGxKTlNUODlTbGtIeGkxNml6eE5ZRnJp?=
 =?utf-8?B?RnlkeElnL2k1RlVYNzdTajQrcXVtU0VoUUxOTS9LamZGTzU4MFdnVVc3WVk5?=
 =?utf-8?B?L09VSmJTRVdjTVczZGFTaTJVZTVQMTRvYnNwekErSkNIK1ZTN1Z5QWhoRTBu?=
 =?utf-8?B?dHpvVDFzU04rNjR6eUgzOHo0K2NHOHg0K1pTaVpsQmJ0TDZEdG5Wa0dpNnRy?=
 =?utf-8?B?Y2d0aC9LSkFtTUY5NXFDK2ZPeE1vdldFaktFUHNwTjBheEl3SldvTG5VemdQ?=
 =?utf-8?B?YU1ESjRBejBLMzFrQndZTVNlcXEzdjZ2UWxHNW11N0UyTmprNVh3OXVCb2VE?=
 =?utf-8?B?Z3ROaFFmcEFDcE5FRVlNa0xBYmRRWVNJcTlDUTNoc1VqMWJUL2lveGI5Qkxt?=
 =?utf-8?B?YzA2Zkx3SWRBWHIwbTRHcEFaOTlKcnNsTmZQZkdGOVhVaCtJNlFhdVN5Z1NC?=
 =?utf-8?B?a3EveHdFOXBIRGM0bzgyUUVncXlsSS9NblpZNU5mVFdFU2pncXlCRHh1ZVpD?=
 =?utf-8?B?Y3dKTEJoUEZ2Nkt0VHg1YThoYlZhMVI5T3AzUWsvbEhIVkQ2V2oxcDU5TVdl?=
 =?utf-8?B?dnJPcFB6NzNrcjg4N0cyc0ZVcXlaZDdCOURIcFZ2bytuWTAzNWtKalM2TVRH?=
 =?utf-8?B?NGRWaWxkR2NiN2Fld0kreEswdHIxRSt6NHdWNElEL24wdnBYaEc0QmtLalpa?=
 =?utf-8?B?RWFXZjZWWnVlRlJmOUNHbFhBMm8vR0wzNjBYMVUvTFA0cTlxZC9MaGJ5V3Zi?=
 =?utf-8?B?RzI2N1c2bkZ1MGxQSmJ5UG5JRXJqeGQ5SDR2L3Iyb2lGYzQ2ekJ6S2daNk5W?=
 =?utf-8?B?dmIxOEJWaVFMWHFOWkxtQ3JZeG9Ec09KclphMlVNd2xFOUNYa2kyUUNqTnRr?=
 =?utf-8?B?dTVKV3ZmWmdCdzNYcGZBcWlQd29WR0I3bUp5bk9vOHBSNWhWbFcrczB1dkUw?=
 =?utf-8?B?T1F1czNHQWYwWkp2MU4ySDJGNTN3cXhQQ1QzNnljalBZNGFiMWFOcnp4dnZr?=
 =?utf-8?B?bzd3TXNoTjEyak9RSThWMkZOZmtFQ1NwWVo2N2I3blNLMmxSUlJrbFY2OVNo?=
 =?utf-8?B?a3haNEhubmFXVWxrd2xaUzZwcVZZNWJBQ2htWEt2bjlwcmpJeVJOMkpvSGhN?=
 =?utf-8?B?VDEvMXk1bWo2eFR6aHByZUo4amtnU2hhMlZXc3VSMWpxM01IVzgyeHZZNEll?=
 =?utf-8?B?SXF5VDQxWU0zNkxNM1dyTnpxd2hETk5pZUZBTlpUUXJsRVpzazRaNFNvYU9k?=
 =?utf-8?B?NG1xczB0U2tDeWRsT3hYWTdnTlc2OEtnMjNPNlpwMHdYSnZuQWxjU3duYVRz?=
 =?utf-8?B?V3pXVGVBSVU1MUxxK2kxMC9LUVhEZit2NXYxNVZwK0N1OVlvc3loekV6ZnVi?=
 =?utf-8?B?b0NZRm5XT2VjOThYY0NHbUtMRllnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A84A562D6016954B826DA51B111B5289@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3C4p2+hSsZHpjzfmBO3m+0bPekOJ4wka6mcWNNlb9SNX9iybW6Nzb5FARAJi2gJTqmA4YuKFI8jbHu7VEhTKUHAdtX0HKj3MT1alA+4wNkowunU1Q1utwm0+cK7WuoZH2qBXa0w/kTs5IwtZCrhL3Byxus921BAOVdNG41EonhLBAMFEq/Mx/9jfUynq2vRsDGiRC0Q3CZW9Hb1XAf70htcgV7HXFQA3IoRY9HWPIm0gGWA59SpQ2YtajQLl/Jm8c5JZiIEBEqjh/LoSsFOGz5DWhvZwK4hdPKGnK5Bit0/fys9O4PKfX/AO5hr98RMcdyJsjNCbW1RepLUlc7L7O1iibUdNLmfy/K1Wxu51sp4tlmYr7bltGJ16MVKT/prfyCNPSGkoJiVdXSl8nn+kY/3J54gmqczDoS338LQL02jWcOhw0nUYOtpBlF8Cpln7tlB1LNQgyAWyxGr0UUW9vuKE6xooXAJC/wXFqR3w8mqCymHJGKCWuE+37JS8M24bMETSSw8uAB+n4bvwYsyQhT40RQp3KHXvJ7/OOxDLFV6NjUi8tCf+13vLkaMnMALnrqPQx5oaV0rKLQszI2MkRhmlriLQPbP59+90v+zgDy9d5OYhw3HycaROIblQP775
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b453d0-ea6f-44e2-d3a6-08dc9b426707
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 09:27:47.8212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvvC+Hy8/qrbhOnd/nfthlcrDA3AUweeRh6fGU5tgKD9GcyfTcxA6tFEqg+qQWRc8R1bUUZT1mqx+QipB6uCKJL8qs8Jhwd4N1aMeemIzL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6381

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
