Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0D29D0D
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854229; cv=fail; b=qaf83F0dW7VTOnV0zqY7HJZCJBaola76fIeZz6leu02Q9Cf6VeonXoFlTgN0IpD3QQALSKwfTwyFHoerL3jJcQByuMfonhSP0LEVfSaHezUfXuDLQZvHqplkM2dt3gaotm41kE4m1TWAgLaUwpBpjfmLHCwXLqUSfdkFup+PKQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854229; c=relaxed/simple;
	bh=QzXjLRQ63O5Lb/KvNSmYGdzsWn7SsURKoYFsTZaG38E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gmDzK9ckjZ8GkVb6z1vZiln3ke8AJIkIymbd5kF7eS9PPb30NIwucYWrJVC2Qtwzv93fuuPqvDZeEcP04BndrDVnlBfY4XUS/D8yzRQyxpB4BW040PkP+mWVs02Ac6QhVRUm6W+6qbsrpIT1+BfyhBfyjpCROcQghfrwfY3Xr8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZWKbrBU3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dwE4pEsW; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZWKbrBU3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dwE4pEsW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745854228; x=1777390228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QzXjLRQ63O5Lb/KvNSmYGdzsWn7SsURKoYFsTZaG38E=;
  b=ZWKbrBU3bnQ4ZLGzJ8pit+luu9ZF6ENr2Gy11RlmvoqseX2IDmJkTl1+
   QuCKyYcKOP0w3oNviv2F6UK9Zp8g+dwIs8b085tX0C1djiFOhNj38iSZP
   5uomfiDoeWfTONRFB8OwTVZu26TIHf61JPJMfEe5XrQYj7Bt399NQ/bQO
   ykjCgNP8b5MTk+xt5TrRwiLugM1S99drv4d5whu+Ie2GABMveUdevvg+q
   cZZBsvQbxQub9Ty1+hDJQh9SlMazPsu94tjI7mVTH1Hv966ObbfIOHW8W
   BMn2d4DdFldO5qok5ozljcWpF2hlKrrQP+M3r3/AYDaGLgNxTjYMfTt9Z
   w==;
X-CSE-ConnectionGUID: tVMj3gJRQBKRCF3gFsfMKQ==
X-CSE-MsgGUID: OUp370niSGqWgyFuV2ECKQ==
X-IronPort-AV: E=Sophos;i="6.15,246,1739808000"; 
   d="scan'208";a="83589090"
Received: from mail-northcentralusazlp17012050.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.50])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2025 23:30:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2MiQiKrkKg3z8lcavaByxVPE+PFrik3lezHnM3vQ7uO0yHCUdrRoInGzlxXAZKxmRF7tJQXhbX2u8rq7GjaWoq8ydhPFjwZLSF7q15Q5u8zUEwA0zDVJAZBiEUR5KulpINiM9Y/BKyW1bDzNDMF/y1urAhkB9hFlwZirfYYxZ/9Dwgk2XZZCxSbmo3kmtBJPeYkeSdKHRzh1naZE70et77QMaCwLx6+Wv5UdcH9nNkswyi0j1s+iA0lpIqly30sSaVRBqEY8Ku6wiTOvq86GjUs0CNeaTNuCUhHVYm/vWeJaL4IakUnqzz6u/+uYBWVThgaSTYZ9+1fI6JaGbpczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzXjLRQ63O5Lb/KvNSmYGdzsWn7SsURKoYFsTZaG38E=;
 b=BUZCnoiO1eiO4N04FCchT1ilmNcw8SgyORy99NHhel43R6BLj+OUM4jMICstAKkS5q6u/23JPS20gpKiflJpzSLDghFmsF7tXXMrnSpeCPLy8SRcHkWgzy+dWlgDzw5ipc2ze5Bo1E4WMsEugDh0dZ2rDbA+1Fo5lkqE4nkTvm5iErgeNPxdWyZ3EKGLMSij4gc3iDiZSNG1ZUlub/kkMzQ6f3FjVXCP7hATQzb3twYWSPe+m9n900QKxHQSpg/JsKNqdeS5tCgazXN7enx8jq/oz/qiSJvZkT8fe9gzXkMva8JKa/2U/auE30pXlGNDEBuXhkfIRDLFNnJuvft3WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzXjLRQ63O5Lb/KvNSmYGdzsWn7SsURKoYFsTZaG38E=;
 b=dwE4pEsW18iCM87lM8+I3U+c3+0KsvCjuwOFWEgQ2ZP+S4h3r7NK8E9+ZbqJ0N3mdszZpuJNFIbSm9JZmAhwbhxmVC2mzmuZ/EjrHkO7UDGSrVQlEw4uA4pkjlDWD2wfr0qx977nZEZoRLRMckundjrYxRs6bHhHvZPmYqk2ptU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7605.namprd04.prod.outlook.com (2603:10b6:510:57::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 15:30:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 15:30:25 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Yu Kuai
	<yukuai1@huaweicloud.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: brd cleanups v2
Thread-Topic: brd cleanups v2
Thread-Index: AQHbuEdLVzCeF5AUb02JY06zKErb97O5NFwA
Date: Mon, 28 Apr 2025 15:30:25 +0000
Message-ID: <25bad830-2c09-41d2-8fab-00237814ecc2@wdc.com>
References: <20250428141014.2360063-1-hch@lst.de>
In-Reply-To: <20250428141014.2360063-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7605:EE_
x-ms-office365-filtering-correlation-id: 94b356be-b8dd-45ca-ed5a-08dd866998f2
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ellDWWFBNllZTWZaUExIU3I5blRuRGdSZDNrWmsxaGN1bDUxU0FVVEVwaG9s?=
 =?utf-8?B?SGFjSUxNQ3I3Y0lyVTJnSHVVeE1NTlIyM25wbUNIaURRVnQzTk00ZFlTS0tS?=
 =?utf-8?B?Y0x3aUhRYTgyMlFzUEh3eXRMR3JmQ2Z5bTIvUFdWME9tdGpCNHgvc0pOSGVO?=
 =?utf-8?B?Y1NkN0VNNExGSCt0RFZkclNlTDJxT2c3OE9CN29vSmFKcVhhTFFZNE9VOWVJ?=
 =?utf-8?B?bnM5RXV4SFFJWjYxM0ZuSElzUTFnSVRGaGl1TWF4dVcrV2pEM3Y2emZwNW01?=
 =?utf-8?B?UUFBRjJrQjM4QjROb0Q4cjVQeVZOWEFXQm45a1BxandmdDRKOG1PY28zYkxZ?=
 =?utf-8?B?WFFibnBaTGFLNy9qQ1V2b0gzeVkzczd6OFo5YUd3ZmNta21VQ0hHQ0F3YWVO?=
 =?utf-8?B?d1h4eEM2VkgrdVJQcXVEelpBOHpIN0RuNDhremJEOTNPWHJEWEVOT044RXNs?=
 =?utf-8?B?cGpZSzd6OVZyWGZXNFdQTVBtMmxPK3ZCWFBRbUU4TG83QlhPalJmdHFjOUlL?=
 =?utf-8?B?bS95UThSaE1BY1RWaDJQWjUzb2J0ZEJwOTJWSWdDMXFuQ2FtcEEvNkk5UGgy?=
 =?utf-8?B?YjJNdk8yekRWeDZ6Y2puWUp1VGJWUnQvNHl6ZHNhWWUrVC9Fd2huYzJ6T2gz?=
 =?utf-8?B?Z29MUm8xWXlPVHQwTUs5OXR1RG1mcTNpM2s4SXNYL3g1U3Nmd2s5QTVpak9J?=
 =?utf-8?B?Y2o5M2dvcGJyclR6VVlxMGxxRHlWamJBWHNibVE2ZUlzQlVRdXdCQ0VoM1p2?=
 =?utf-8?B?emc1ekhLcDU1UUxtZjhUakxTTjAzVjY3OU5SVU1ZSDZuRkRuekd3ZFlrZkQw?=
 =?utf-8?B?TGc0Y1JuZFpJYTdqVmZtdEcvd3h4K3ZuUi8xUmgvSko5dG5NYVlSNElUUTJG?=
 =?utf-8?B?V1BPN0hIY2g4K0pIUStQUDNJVlc1dzhIODVMRDFYSFpmVFJRTmFtU2Rzalpy?=
 =?utf-8?B?U0VTeFExTkFFZkZVV3lWZUZ1UVFncVFnbnNOL1BFbEE4eVpycTVPdk5sdEM2?=
 =?utf-8?B?UkxYYXVjVXlwTEp0U0dBYWtFazFCM0VTNlkyQmpyZVVPMjJDQ25FbHpOcGRz?=
 =?utf-8?B?YUFmNzNPWGV0TFFzMUs0c3FFTjhCMmJRNUxidkJ0bmlncGRaMTQxb1BSQytr?=
 =?utf-8?B?N3VRWjNmQ1lGbTRsSHdvcERFZlowdHk0aEE3Sk0xVEsyRzhwaGhlUzNmT3F6?=
 =?utf-8?B?dW44ZC83SGVYUGk3Q09aQ0RsS0ZpZlovRDUrbkVBWVBzdDJGdzFlZVRlYXhS?=
 =?utf-8?B?RWtOUXMyNG9GVVk5NytROVpiSWoxNTU1TURqYk9tRkZaMHNQbXdQSkk5dnJx?=
 =?utf-8?B?YjlEVEc2dmVlakdSYVVzNEhBRXJvV2padUszaEZsZEdnMEZqaFQwTkRaTFZx?=
 =?utf-8?B?bDMvWUVueHl5WnhaYkw1M1Zrb2I5ZHYxRUx2NUJ1ZWFsajRvWjNFUTkwVWZy?=
 =?utf-8?B?amN5SFkzdlNKbUZRQzJxZTlpV3lBMjhaRXJxQjJCOVpYY2duSS9sUlgzQzd0?=
 =?utf-8?B?SG5RcFNueEkvZDFYUDhpZ2M4NU5yL1phTVp2d0hmcDNpbjAxSmEzdTh1aE5S?=
 =?utf-8?B?M2J5aytQeXYwbnBaRHh0cG16YzZGS0JuMmxqR3Q5Ym5aQVp1STArdThMNytJ?=
 =?utf-8?B?dmlaKzV5dXd3akRGekk2eGI0RUM1ekZYaEIrVHZuVkhYcW1adTMzZjR2c0dN?=
 =?utf-8?B?REl2QnpTYXVPMkZFU0tJMWJrSmZ0YnIwdVkwcnRMM1J1blFZZ3dEZ2FicDcv?=
 =?utf-8?B?ZTBjQ2VhTjFpckxlRjljbXp6dGV4U1p3UVBSRUdLOUNjSHN3M2lXbnVtMzJm?=
 =?utf-8?B?aE1tMW9pRkVFd0VNTzQwR2Y0SVYyeWNDZS8wajlrSEhGandRMjB2NWhBZDRU?=
 =?utf-8?B?TllXZHEybDJYMUI0Y285M0Y2SWE1NkJDRVRzQ0VhbWVCaDZxUGUxekNQN3RV?=
 =?utf-8?B?ZlVydWJMT09JTXBOWHpremlrWktsMUdPK1FtNGd3eE45YUo0YVhTK2hyMDhn?=
 =?utf-8?B?Z3Z3SmFCRHdRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnRpSEpzNzdSL0RGbHdEVThJQVdOTk5taDRQektyTHRnSEl6RC9RQytKZzNl?=
 =?utf-8?B?YStZWi9BWnRKUWpVU0NkdmxsQSs0OGNQanlNOUZrQm1MN3Y4TTVPaHorTkth?=
 =?utf-8?B?aGpxd08wdWl3eHlaNjFNTHAyTW9ybFQ3M1JURFZzRDlwbXZlWmRvSnhLdXRT?=
 =?utf-8?B?RjhLQkFXTW5GaTJncU5iblNXSnhUVkprbjRGNkI0MTFoVVg0T1l2UG9HYUFH?=
 =?utf-8?B?S3J5VlllcXUzbXJWdTRDRjRZWnI5ZzBCYkZleEczQ1BmMTVPd1QwVjRkd3ph?=
 =?utf-8?B?NVFLaEUzWkhvL1BFanNtRERYZTZ6cXE0WGFCaS9hcGpNY0E4NzBNenVWZER1?=
 =?utf-8?B?RlhmT1V3VkpCbk4rY0syUitZMFRIZTI2MTJDU25GWXUzWHkwRnQrNFhZam9y?=
 =?utf-8?B?TnZpNUVqVVhzVTZsSkpwMXRnbVk3QmlkUlhEM25vOHg3Nzl4RGhvSFRuRzVl?=
 =?utf-8?B?Vkt2VVlpVFBXNEoxOHhkK2xtc0NmRHpZRURqTndITE40c2ZJbE1meG10M1ZJ?=
 =?utf-8?B?TTFJd3JVVVVka3dxSVkwZlV1R1owWlN3aWd3Z1V3eGxlMVNoaDhLZElCY0M3?=
 =?utf-8?B?WThYNzBsSHFnbDBJdEJWbG81Z2VEK3RyVzJhTEdqcVYrMFpOZnJZNkJlQ211?=
 =?utf-8?B?ZWkzY2dIQVJYWEdZeVVNZEJ5eFJCOUx4TEZrN05KdExKenRSV2Fqb0swa2Y2?=
 =?utf-8?B?eG1RTUlyV1Z1bGZWWmkxTEpwMFpKTlFZRjl4YnZtVUNQMkxnVTBWV0JmTjBy?=
 =?utf-8?B?c2ZFSVN3bEtLVXVLcStKUzZGNWVuNXFnaHNxMGZzTnZSMXl0TVhheWxub1JK?=
 =?utf-8?B?amNmRmViTG9CSjF6ZVd3NC85bkVrT0tnc3g1YjRrTGRCSEFJcnkwMDQwUmpm?=
 =?utf-8?B?TUQxTmhqTnFOZXFrLzR2N2RnNWpMR0Izd1FFRFlVSk03OStzMzdOdlJGWGV5?=
 =?utf-8?B?V2NpbVgwdFFvMXh4OTd2RUlMSys1dEZnZU94eW1ISE5ML2N1bmxURXI4dnVk?=
 =?utf-8?B?S2RkZUxXNHU0NEZrSW9mRHErdllZaUdseG5UMmlkMHFvMkdWOWNsNDFmRmtI?=
 =?utf-8?B?Z21iNnd6ZlZoc1U5QXFnbE1TUTFsZzNKTkpFNUlydElUYk1mVGdITkJDTVhP?=
 =?utf-8?B?aFdlUlNtais0L2VCQmJUdm81S1c0WURlUWxHZFNTVUdReGQ0alZYT3A2bzBF?=
 =?utf-8?B?Szkwek8xVzBMWElZUTJIMUhweHFEQjBha3pwRlhTWWM5Q2hVNjRLL3dLWkJK?=
 =?utf-8?B?SWhTVGxmNi9OZWc0Q0hTWXNxWk9zbkxidUI3UE9aRTRaRlJDNSs3TzFoZ0NO?=
 =?utf-8?B?MllaZXM2b05BWWlXUnhjVld6ZktHZWVYazhTQjBRcGE4R3pTNHJDSE5lc3ZG?=
 =?utf-8?B?NWJZMW1KVC81aitZNjJqK1ZpNTlZUUo2V2NIMWxra0FTdGlKdVNNRzRqNGdq?=
 =?utf-8?B?Ky9pTnhCWFl6bGJpL2FxQkQ2VGJ3OUJsTTYzTTh5ZXp0L096cmt2Z3dVUi9a?=
 =?utf-8?B?UmRCTmNoNFUrTzFVVVBDVW9URDlqTmhrT3dMeGlydE9lYm5Wb0I1NlExeUNK?=
 =?utf-8?B?dTFuR3d0MzhlU1hqYlRuOVZuSTdxRXczQ21qcjU5K0NmOXVlcHJmZ3ZUUWNk?=
 =?utf-8?B?ekhQSlBhb05yai9xby9QN3F1Sk9WcmF6UjZ6aEUzbkVJM1JpU0x1VzZyZkdm?=
 =?utf-8?B?NUltVFlNdEtQdEd6TVJ6cEY4UWRSdnkvR251L1B6dVJZeXFLdGVJZThoRWlF?=
 =?utf-8?B?QmFHZXhLeFJBQWhoWlJRdUJaYWRmT3F3M1NiU0lMTzRWUnRJVTNsYzJ3bmZP?=
 =?utf-8?B?U2NiYTdEYWFSeDNRTW4yeGMwNkJ6MXF4Y3JBM1Rtd1NsbWJZZE43NXJ4SHBI?=
 =?utf-8?B?WE00QjdoYjIrOU9ndFRXOUtsbTZxSTlSMlVNSTVmNWhKT0FURDdCMVd3QjRt?=
 =?utf-8?B?REpnTXVUQS9EVGJjaHVsODVrWE9ITGd6cDBSdWN5TU1qQmRkMGhVbkJOVjdP?=
 =?utf-8?B?bWRUNXI1L2xEU2o2MU00VTdBTDl2dHhaQWR0WUQrU0g2cWMvMVBTOHo1MUdO?=
 =?utf-8?B?M0RGL2wxa25qYnVJTTZaOFpqS2phVllsd0Q2NTFzS244czlnbjR0aTU3WVdj?=
 =?utf-8?B?dm8reGxrb2ZNTmdSeEd6Yzd2Q2N1RlhIaFZ1UWVwbTQySmcvb1V4bm1JemJx?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <312358FB76BABF4D8F5F6A38F6909D5A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7qKwJj9t/I34/MRjS/t2W8r/PdKGoor9tZx8tbilVJIN5ZpQFOlJqfdotCnC9B4EZETBXVJM1PAXw05BlOF2YJphTdaAWpdoC8M6aBvmcWij2u12Vc+GerMxUc/RQEfn2ShBSTY7HmbsNUzVxaYthNN1RaEmnuYfPcupEb+eo4g5q6OKlCrRSxTtfKqHHt15Jid7O6tVIv793fzLtqxDxrjqMUIbY41epT2j1e+PfhQoQ0LHUdVZr2DRPLLgny7yWpY2BVEqdAm1R9+5GF3G1edv1aHsyFSJaC6IMr5JJmBSkkeJZRVcV34XVtmwKLl7RN9avX1ET0qI4EEyJzJKEgcWh9+qFYe3hiYr5TFlscnIG/pv1+20vBsm6b7ZNtpLN3XjGvHqZM5vWKc/+NK7p7I0H5a3SePElgPmuhlcm4jrsfOgKTXtcQbG3l5bj4bvFMLLrzwhmodqHAS87H70871Sa4rvE8lXe3MHcqO2ysYhaZXnuQBaroRYQbeGxeaHxOFeda8p8N/J8PBfvqNnhnQLOSCGUzf5e6eCAsUBkoPlus4qEYCbGrbp4z83yhP+rqD+VuQHRk5dgYYbUBRj7bveyOa8HGawcJ6zAAqfedosisvnBLAW/fps/cV8NM6/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b356be-b8dd-45ca-ed5a-08dd866998f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 15:30:25.2073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4ZeQoHPJIoQN9+KFCNkfJYwatTpILoUrfT41og9/HDx2krDu7+F28kQ3PuhUZemz1TRjV+E47eqX94HSk7QT13qZI6Fx4tYUA12h0JbqjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7605

Rm9yIHRoZSBzZXJpZXM6DQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5l
cy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
