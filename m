Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7132C923
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764603372; cv=fail; b=c4j+UOKJoNPdVyJTVRla/T5ymO4WwnkXBQx0Ze9F69NWzwJ/WkxJ5ykfcwxu4LrcehBD5ZOjWdhLfOdQBNj7Ga2QX3SC6u6GoQA3nD5KaQi/LR2d/ue9GH0/G/pEZXCTXEpsZQGHmd2eOLLw4jUNi15uMBsNLPexFzvGdqXL36U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764603372; c=relaxed/simple;
	bh=nvGHHdV6nfquLuCLhdRwzpQAOnX97pkbX7paux1tRTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OkuEsVfwm/gystxoiDmdrVElQO1olNc63DTuQq6aYO6etFTLQ2vzJCn85j5cInS7WKGxXbh7Jj2+pKKaInW446Hrr9fW5tvaPYXcW1IeK/lvgesEkJSDQXQ6zm9YeyZaQfx2uT/KYPY45iGw0280X/qyPzbGnHVYNA+8f4aGeYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=I8UHHotq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cB5c/92V; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I8UHHotq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cB5c/92V"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764603368; x=1796139368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nvGHHdV6nfquLuCLhdRwzpQAOnX97pkbX7paux1tRTU=;
  b=I8UHHotqije/AgAveGlwcBBMg6rOCKetwTnrGUEtBIz7ONap/Gbd7Pz1
   RJDMnvvamADXtOt5V1XM2VN0U6q3e3LleZPrOR2nXDrSjinnMpgbdIeXm
   sqcq4Kzew092J3pMW5PCuPMbQ+cCRyfvuNm+53nCmPG0j9w8T11pUseWl
   t9NjKETTrh4lAU5p/FjbjpWiaGDfsZDXVV+UQgAIXEM9r6f1o5BicZLD1
   MTOezbCNeZ0hhGMWWXkdFoRBfJao2Mm80Csd98yY067ugOft2xPYi4g3a
   owzXs0nUMKPHpcWgn1Qrq8FwyPWuQPSNwQQuDp5LoRTHts0mKqEkNUkmy
   g==;
X-CSE-ConnectionGUID: 1TlDXPsaQFCwGQ3Vt5rpXg==
X-CSE-MsgGUID: 8pU+MN6cTd2px8MbvHTamQ==
X-IronPort-AV: E=Sophos;i="6.20,241,1758556800"; 
   d="scan'208";a="136161818"
Received: from mail-northcentralusazon11010052.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.52])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Dec 2025 23:36:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDLW7VJWgPWVeuXy3hF7Xhbee8o1JcMt+3kFy3nm4uKeMZ2ze1qNSYnfOcgnlDiM0Vpm1y23lZIyaC4n5Trlm9br341bkXPAeddAViRgoT7JK/ntIGSmiZckXBB/sbbTQtcvsf9XEsX2LAqHHfO4+9c9uPG+ToTTytdDoLDpDsXiN2EnYU0pHGyvK0Ls318go4hQmqdxMxkUrrkg2ummL4Bb0zAg/2V5NV1dav2t8hl3iH7zbsY+N4UoBuuGU7U/op8HRWFKjoTdm5o/9Ja/tup55RN4WyGwXjVoQjHq98kJrc4869vPyGOkR66LQWfV0HvvYPgThNU/acre+yrQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvGHHdV6nfquLuCLhdRwzpQAOnX97pkbX7paux1tRTU=;
 b=irZPP3JD/MAJThE8vm3viwX1L0f+bkccRwa9XZm1LwmKP6B4TXd6gN3bPTmbWCGXZfYLJg31XJQddynOjKt2b9UaFWBdf5SwCNP5QVbizk2/xZpZcBsTPRFUHKfdGhzqsUgjHHmKIBt1ArFQQg0EeKBcow48ClOc92raZB18PoORtSA7CZUv4nB8fK7nb4b4OQwLI0Ys9SfD4dczjHQWLjmQIH4pn16GIk0eZDUMtRcXKSF340eoLhhaJ1igkhGuHCaXQWQR7aYjukHpOduPcpGAmr36NJ2fBDn9VgShbTqGMZG8hRhokdIDvUCrJzynNda50gnT4a7nS8Z9wQN0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvGHHdV6nfquLuCLhdRwzpQAOnX97pkbX7paux1tRTU=;
 b=cB5c/92V9IiBMLZyeWjZcZrOor2gSKt+/7HgDPU8XeLvQndVpT/+PeiY+9s3t8h9b5PG6nupVyYGpp+I7VIm84ief6G2nSNwlANT5wBJEEUDcQgEnY7n/grbAlG760uriXuEcM/ZZ2mur2cv3wHa5XoR0LzuzYmAxmIj+F2NtRA=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH7PR04MB9546.namprd04.prod.outlook.com (2603:10b6:610:24b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 15:35:59 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 15:35:59 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: fengnan chang <fengnanchang@gmail.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"hare@suse.de" <hare@suse.de>, hch <hch@lst.de>, "yukuai@fnnas.com"
	<yukuai@fnnas.com>
CC: Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH] blk-mq: use queue_hctx in blk_mq_map_queue_type
Thread-Topic: [PATCH] blk-mq: use queue_hctx in blk_mq_map_queue_type
Thread-Index: AQHcYr2zC4fnrfkUc0aTYm747qbnebUM6uUA
Date: Mon, 1 Dec 2025 15:35:59 +0000
Message-ID: <678e49e0-e466-42f9-8dc7-7aa3101d7c9e@wdc.com>
References: <20251201122504.64439-1-changfengnan@bytedance.com>
In-Reply-To: <20251201122504.64439-1-changfengnan@bytedance.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH7PR04MB9546:EE_
x-ms-office365-filtering-correlation-id: aad7f4c5-1a1f-4086-f1a8-08de30ef53cb
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFpUTXNXUk1PMmNrRDAvYktkTDNDV0tabHdxVmpRb1dSWUNuUFJiK1Rtd0N6?=
 =?utf-8?B?aFkzb3NqOGNBYk9nZXhwY2dLSld4bUphS0JlUkJZaWV3Um5nUkQ5Z0hscDdZ?=
 =?utf-8?B?NVVDdnRSZ0gvaXhaR3R3OExlWENpbHZVYTl1L2I4eHVvdG5uYWhqNFdqd2dC?=
 =?utf-8?B?aEhxN0hCYUZpRm1RU01hWXVQQnAyUEhRa1NqL2J3Q0lYME1KclJWampYOFZ0?=
 =?utf-8?B?ZUVzUDF3UHJWcWIyV2liSHphMVlBaDVUUTBNeVJTMm5qQVVhT0dWRjE5UWVB?=
 =?utf-8?B?czFycjBQWWJWNTFqSmIxTTVPOHhha0wrSGZXK2tyZ0lUYW84NVlaeTU0bUJy?=
 =?utf-8?B?MDZ1eU9ZNTI3VEllQWQyUVdHdzMrVmh3ODVrTVBHaml5bE5xanMzaDVWMkNa?=
 =?utf-8?B?dXd0dTBwOWkzVm9qVm9ISWpSQlV2UU1OM0RJa1ZTM0JLYlhiSEk5L0lreFVh?=
 =?utf-8?B?VkdMNXBrTFVLS2x3YzJTUkpibEM0TmJJN0xObFZkeEpBY1RRVEVGRGpKNms5?=
 =?utf-8?B?emVoZS9LNHNJdFVSZmtXdVB6dnQyaXlvVDBWODRyNWhMZ2xTOWpMUTZQVWNO?=
 =?utf-8?B?clZyelBKVEN3czJuemlyeVp2SFZVQ1lHQ2VWUmRrbDY3QnpjclN1cFZDenF2?=
 =?utf-8?B?RjNxVUZoMnZYYUQ5VVlUTVJ4NmRYUUJmazBZTmpvWDB3WkhzNE8rbEs4QzAr?=
 =?utf-8?B?RjZUVmtPU3U0eVY2NlNLVHBXaFppYjdlbmhvYWlYMVg3SVdwaVU4T2FDWjRt?=
 =?utf-8?B?MUN0TmV6UUk3QTF5TGFrZXNBRlV2YnAwRkZHQm1pSUhESEhTU1MzY2Q2Z3pt?=
 =?utf-8?B?V3hsZWp2MUJCT0JEeW84UlFCajUwdEo3S3AwdXhtb1RsTVBUUkMydllGNjl0?=
 =?utf-8?B?TjNOLzB5K3VDdWNMM3FzUktqVDZBbWN3TGF4NStpTENQZ21jUi9McXlQMmdj?=
 =?utf-8?B?bmxYaVdrclJYeVNORXI1VjVjTWxINy9iVWNKQUhmUDVyQ2NGT1R5RW5hR0o4?=
 =?utf-8?B?ZzErL2piMDhGZjdiSFkxV0RpanZubUpBM2k4bW01WWpwRU5WSU8xOWdDZExK?=
 =?utf-8?B?K0ZEZFFLREdVZnY0OWtqeXd0b1BqTGNJbFh0MUI2akt1TlJlSXdoczlpL1FF?=
 =?utf-8?B?bjVpakwxQWJicGVnRlFVKzNqeGg4dXJUL2kvTmdvYTBFYnBseVIwT1hYc3BH?=
 =?utf-8?B?UjZ1Rm5JRDlzekVxRHBtYnpYbHpKSllKNVQ5cHJkVXVTeFROYURTT1czV0ti?=
 =?utf-8?B?T2dwSW9BOGMya1IrOUZJaHlXc3c3aG42T1dvdmkxYnhXMm0zUkV5NTB1ejRJ?=
 =?utf-8?B?VU02dUpkQVhVU1FrMDdUTEFobk92Ynd4Zk5CbHRkK1R5VXp2enF1QnFINUtN?=
 =?utf-8?B?MWxHN0NQRDA1N3dIZFFrN3ZNWXBQMkFOY0hpT01yUEpUdzVPWGFPR3hFbVJJ?=
 =?utf-8?B?UC9yM2ZNS2xyYmNnUEhTMTNONzk1eGYzMXE2bnNUZGlBN2d6NUY1MHcxSjNn?=
 =?utf-8?B?QXloYVJwQ1JHci96b0RTYS9TQmFmcE0zOTJmNUNHZEg5ekN0SEg2Vi9GWWh2?=
 =?utf-8?B?M3hEcWpIL0JWU3Q1RGg4Z2VSclc4MXBOenNXbGh1bEZQUUJPbCtoRmVuOUNj?=
 =?utf-8?B?S0ZiYTBrOVB5Ukd0TmhjdkJpalpxTmRXanlueTlYOFBxR0dDSGFpRTVPM3dm?=
 =?utf-8?B?MlVTMTNNWDU0K0JqeWd3WE5kUFlWZDRUWjY2amZ0WXZ1RnJQRGUvRjhTZldZ?=
 =?utf-8?B?K1dWSVhjckRrZ1orMkhRTWtNOFVlK3VNVWM5dm1LZlNlVGRYSFhhd2w5VXJ4?=
 =?utf-8?B?ZEFCeThLSjhJOWl6a1VwU0cvR3NPdFU0c0U2bnI1ZFNGbUFSUkFHMVRkRUpL?=
 =?utf-8?B?OHF4MENXVFpCbnIrMFE1Ny8xeXB0WjdEenZvNFdzZVhiZm9jeWRTWnFneEVn?=
 =?utf-8?B?aU5TYkFmT2NIQkJhblVsWThkV2lNUGtodWp4OWlmc1ovbUFSMG5WQnhVcENp?=
 =?utf-8?B?VFd3Nzk5ckNrcWlXYmRUbzdKRkJtQTB4ckEyNnduNWZBejN1Q2xxZm5EU0p3?=
 =?utf-8?Q?DSCnUB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWVHc3hsTlRDSE5IeDg5bDdJYlU3YmlvZ21DQStaOExlMStYUjlZMTZMeHpC?=
 =?utf-8?B?dW55VkFZNmppY1doYW1hMk5XTnJ1ZW0ycktnMTV3VDJscktXMWdNUW5ZZkcw?=
 =?utf-8?B?MG5SUGlESTZhTVhhRDh5Tm5iTTdpcmM2a0dvVEt2L1hzaENUWmNRbERZOU9L?=
 =?utf-8?B?MGlvUUVQOWVOcCtsM0duZXZjY21NamlNSVN0amlCeDZFVndZaEdrbFY2Zkhk?=
 =?utf-8?B?STViQzBRNmpmTzBQakFnMUp4MEZOdXlSa29FWnRjRlFvY0pXLzk4c2xLbzdi?=
 =?utf-8?B?MC9JZXMzRGZMRm1wWk8vbGlvUWx5S1MvTGs1MnBSOXNBNUdmUXpFZ0lraUV1?=
 =?utf-8?B?MVJVbVRaQWpQWjdaUlFuRzVndnJiV3lXcU44Z2ZkUFR1MVhSZGlRcU9Wcnhu?=
 =?utf-8?B?MnVVUkxkbGU5aDB0YmJHa2pValdaU1luQVovTGkrTUVhZ0RzaDlRV3VINEVo?=
 =?utf-8?B?N0JqaVFDcFZaU1pNSCtUVENPMXdFQTNGNG1RNW9YTnFIR0Z5T01kVHZkcWFp?=
 =?utf-8?B?cXZYZ2UyV3FPNmQzdVg5SmpyL1Y3bGZEeDRtZUlHdnFUN3k3a0dIWUlucHpt?=
 =?utf-8?B?V292UDIzNzlTZXpsd1NqK3pJU3Y2YlJxVnVxMGozTGdmWEhqSHhGNHJyU0wv?=
 =?utf-8?B?YjdaRitBdXdoSE1wTzJuNlVtQmNBZW5rc3F2V2lNdXgzNDdxN0RjLzNLWHZV?=
 =?utf-8?B?cEd1VWd5aDh0M1czQm95YkNZQ2o5TnN6bWJLMlVrNjR1b0ZJVVNnRDZVNDZq?=
 =?utf-8?B?dXdZSzMzZUpGeGliTUNtYzlweXVVdWM3OS9RcHFEdVptNnFpTFR0T1hNbUg2?=
 =?utf-8?B?azM5ZmFoRnErb1BXKzdXYldWSmRGUXdoMEpRajNkd2FLWVBDUmFqY0lwU25z?=
 =?utf-8?B?dDA3SnZmR2RrQWo5Rkt4OThTQ2VzS3l5QlNYRnNkeDJkQU9zbW8zNUdyWkl6?=
 =?utf-8?B?L0IxMkdkRkFLcGJ1VDZDZVIrSzVFU0pKamhFUEVwWDZJUDlkU2Z3WDc0eG93?=
 =?utf-8?B?RGIzdmN2SXpxMFhmOHVSa1pmZDBIUzJtbEVUeU5pdUpkYTlGOEhENThRV0ND?=
 =?utf-8?B?UC9hUVZYRU4wUFlHY0xVRW1aVG5SWm9DRVZiVXlKcEc4U1hDN1hodVBhajZG?=
 =?utf-8?B?bVJkQ01jSXJLdGhBbzJmNUFXSFEyc3VPYjlmUW1RYnV3UDdJZWtFNjBWRXVL?=
 =?utf-8?B?YUNoWTZZNmFrT0dNeUR6RndGeHFWQzFyVldvbmdZOEI2MytoSzIvYVhybUlu?=
 =?utf-8?B?S3hzOFM4RE9XZVFsVFA1NlVRL2JZN09McVBEcEswVDlXT2pRN3Y3RkI3YURI?=
 =?utf-8?B?V2lMVFlVazVBV0t5MW1Td3JiTkRaUlFiWU1Ncncyb1lGTVFwQXhqWW55WE9t?=
 =?utf-8?B?bTQ0V0lXb2E2d2EzL2JhRWMxUTNQVVpiREdvS3FRWW5neE1rL1FWUVpUR21I?=
 =?utf-8?B?SW1yTEhnb1hobGJ1SHEyOGg2bTI4SWgwTlI5c0E3RVdyK0tOd2VCMGduK0tB?=
 =?utf-8?B?bWphemFndDgvN0pvcVlsVXZwRkxGSCtzSVRqNVVjNE9BK2xTNmpLOE9OR0xG?=
 =?utf-8?B?cXZVR2lOeWdTM2V3ZHpkQVRCWU1FcFEwUGlsSlZCNVRiVG1heHFNalptZDZK?=
 =?utf-8?B?VHprRE1Pam8xMWpqNlN4bW9qY0RScHRXb3dBVTJsRnVERGVIdHkwVmlEMllO?=
 =?utf-8?B?dXhHS3V2WDZpSkVFa295K3loa1FSQ0pMQlRPbHhMR2dVUjVDbTREbjdHdHRl?=
 =?utf-8?B?aGFidWtONzVlQVArMmd2SDRHVVVNNXR4VExXYjlvVUN4MHVzVEc3TlE2V2ZJ?=
 =?utf-8?B?U1dTbG80ZFhCMnJWWkZPYlJGOXVKZEFpcS9iUnp3aFdKb0d4alBTYmlhZTlX?=
 =?utf-8?B?a1Vsc1RMS05waTd6alV3Z3JxdDBVdjhaSmpZZkxBNVVZM1Rzd1I2TGYzSzR5?=
 =?utf-8?B?THc0NGE3bFU0UTNhRWFGcERtUjU2TXdEQjVmaVlIa2dEdERkaVhFWGorU3Fy?=
 =?utf-8?B?Z3lEb0ZwK28yNTlpQTIzejZ6TjhPMHVXaFQ0WXYzZ2hqc2hCYjRoOFdLdGJl?=
 =?utf-8?B?UGxmb2FhYzlXczRDaHFsakFMQWRVTWhrUFRCMW91djlHSS9wcnI0NkQ2SUl0?=
 =?utf-8?B?dC9RZzFwTlV5WGNjbGFqeERGRzlRaUxUSmlMMEIxM0VUSnhLWDI1WG5GSUdx?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <992FDF779B37A44A900AE7D96B9F3544@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ziz6s2XIr51Z8kCwXRLPqoyi/Z0V02YnH3ICEwfcovmockL2gRwoVdRvYyDK8Z7KJEhVu8460Hy+BF48LhTS4VKb6d+dKLdQKVcL8E1k9KwVS6gY/Rkq258upzsFLoEx/RujORkHJvunvMxtxBI4ac4Q2zJuwCOkD7wRxL2LwpZA/J66j9jr8R2uxfC3x5P+KOsz0mA9/RgXnSxK+Ds6THaUrwcdKYl/byliBHv5239ESNxrV39C1CqPPGsDNgRF7waRbm3Gq5hSW9S9GT2ZPek8isrbXm+DcIRfMkKQdk7E3/wLD9GHyiXM4TsmCEa12Z/cCPzU8obA5s4766G5vkz5+LHmYjYEtw0Wqg6m2abFlkOuTq5k+t3gS1JZeUYTldOFnyobmXm2Oa2lZVDEDnhda/vQ8it6Y6FNYd5m7j3GyQMrDaboYUPO036zAENI6Lij5DbAIPjLagDQiXs/GwdppEwnoLmqcIEIa0KaQ/ufQ/IMffLfW2a+ELm/38P/kj/tRf941zr8UVm/jhyWXPL0YcjlUMOL735sEgGtdrCa/RhfshIptdWmxci37O2CGAUN9kCq28AvBkKXFkM/X2GWZHTn/85FFhS40R22shXeLE0vgjwOBaEVkJtuDeiR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad7f4c5-1a1f-4086-f1a8-08de30ef53cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 15:35:59.4030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mUq4Jg/dsTipJ6uBQueaWjIZHvAzsssCuVBbzIYFlF1TKK01lXQ1tPNJuqNACM5/wdWSZOYXd2VJ094jmBUm8gkuQVJ3eBfxDZvp3u8HZqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR04MB9546

T24gMTIvMS8yNSAxOjI2IFBNLCBmZW5nbmFuIGNoYW5nIHdyb3RlOg0KPiArCXJldHVybiBxdWV1
ZV9oY3R4KChxKSwgKHEtPnRhZ19zZXQtPm1hcFt0eXBlXS5tcV9tYXBbY3B1XSkpOw0KDQpXaHkg
dGhlIGV4dHJhIHBhcmVudGhlc2lzPw0KDQo=
