Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2A2DF71B
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841732; cv=fail; b=udIXxwKhajbvpgqqacHF2/G8uwjXU/wFeXoFRWBwTEIdpf79MapaK4FWn+ZUrwfgmvVAxcxOaZsQz59K7RNpfPE6+GPidoxMw+mET48vWMXjvfhzROzAEAgYlQnysa5Jg6Ri+2Txo1DakIVZnl6unp4VeeFmBru7DgMMYgLAxZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841732; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qGLmijBBi9SiDZhYq6ZGmxc802oECLs21cjyJgmfMrqH6YMx0PyWLwAuNmV98fiPIq0wfujQpkNFShCVjjPKbr+dTbWwzPpRoAk8u9+Fb3IuSLR1I3hQsCnQGC1ttJOcHKpm6pR77zHUd5AAwJ2L1zfx1+YzZwg/pYO6SUb3oRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hyT1mnht; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SjEgBN0A; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hyT1mnht";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SjEgBN0A"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759841730; x=1791377730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=hyT1mnhtGvnHL+ZV6QJF0+UPFEsIdYee91avAR1rBB46UZzC+xWWCu4g
   BrwMIgGEiATR72AjesBpRncKFUp8LLAWiLl+SeU8pVaGdTt5NwpS4kFi1
   H4qt0bE/8LNzo9Hhh119ach/pt+U3JuybTY4g2rqkmWC958im9sMHCgZB
   1MTrVckF9kHuD7VJuKQiHBGH8Uu4oFHKX1JsML/cBlmL2uvNj6qBT8RlT
   GeZlx879UtHfsCg85VUB+X51X50hiG9eQnkcQvmJMgkH8qmndLgbPBrcc
   Mp42qcRfQSZNCw/ARCjHz/JcTlU1BOP4DEd9BhL5gjKfc7T220hgD7y+S
   Q==;
X-CSE-ConnectionGUID: XdIn9GpMTruNdc39/H1V6Q==
X-CSE-MsgGUID: 16YtBD/aRuiCan58BbxvIA==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132746580"
Received: from mail-eastusazon11012038.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.38])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 20:55:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2TXk6hSZEsu13/HhMQc+wRGXUatd3xxZSrpEgJSD9xQMJN74RMxC8T/2POdW/rFsUy+4cVxfDK7cJ2uoYaXJiQp/K/3RJ5Vkh+m75qYI5qo1Amne8/AD3HZc4IMLFAS5+Y3zeaSz3ZHA0Gm2oCGrY8UZfVd9dsY2ekGIvNBCcvH0mG2daxljA/zaG5piZpDGx9ErPrFLP78hUjgY/OIMiY03JECm1oGCmVIpEXtblK7Oxa3JO2ff0JtTMdMx2MoFjS1iUhUoQSp9aCMM5Z+XLk8xOjYNsPCaRQXZok/Fal+rEPTtPr51DdLdoSifxyTS6ZnYzJTeWDQBfHJAe0nQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=JX8BLfIrQQoA+y0j2RHd7DzViFlrMaPd2riAIOLCa7uO6DYPyZAUgljRtJdzklc+FzwOdq5kPtVe5Bfd7FW3dW1q2fEHUwdi85Y6vx+XPgAJ+8mOEI0sl7Se8jDhyrrWulS6XXFMqIfiEZIe9qXKDKBO70TSZxL8fyqKfzcNMH/lMbG8SbhETxKaH/g5ppTbe/5gJtJg5BFhbgqgR7EGN3a/LJWEYiA94OtXGQNTJx0emq8IfcmjF0PPmz3GFSSfd+CyX7tEo78sMSC6iMxfD6i2J0dCbOxMxSvWZOVfAqtxlotSwv2n0EtEc2YrPXgad/fPw/wdT0gu82yOgCcTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=SjEgBN0AiaFG0R6x4AYtoZj8KUQLM2FQAUw4xAQp8hQa416XZWtBxjxGu5P+LfqY7xyWloiyKpZYTRRNuBxpwQ8fIE7h8B3R3Br6xKhMBdNY/QILRIP8z4cyev4JKy3Cf9qiwxIi8I0DyKb8dXctRynomL+RnBmVRxCYjOTKSTo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by LV3PR04MB9442.namprd04.prod.outlook.com (2603:10b6:408:28c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 12:55:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 12:55:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Qu Wenruo <quwenruo.btrfs@gmx.com>, Keith Busch <kbusch@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: cleanup for the recent bio_iov_iter_get_pages changes
Thread-Topic: cleanup for the recent bio_iov_iter_get_pages changes
Thread-Index: AQHcN2m998dovULFJk6iwhdlHpUtmbS2pHqA
Date: Tue, 7 Oct 2025 12:55:27 +0000
Message-ID: <fb80d907-b983-4929-b3ff-4de7de1a404d@wdc.com>
References: <20251007090642.3251548-1-hch@lst.de>
In-Reply-To: <20251007090642.3251548-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|LV3PR04MB9442:EE_
x-ms-office365-filtering-correlation-id: 40f5730d-cd71-4ce4-6d80-08de05a0c9ea
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVd1cGkxbGRVK1dUTUdwUFRIOENTWGw5RTI4bkc4ZkRJaVAwRlJGUmNJUTJl?=
 =?utf-8?B?ZVB1bXYzd0NSdkc2YnQwSlI5aEN6S0VWKzlta0xFNkVUaEgrSmZReUp4dFFn?=
 =?utf-8?B?VmFKcjdTSTFLY2tCTlhaYkVpazE5TFdHUHp3TXRqU0I0VXVSU1JyVGtteHlX?=
 =?utf-8?B?ZTNwQ3M3TDV0VEwzajRIbExXWlBvYUMzYTBIUXd2QzdSYzRUUnJBVnVvdkJ3?=
 =?utf-8?B?NHR6dURuaE9kYmU1MEIwUVZKSWZqQWRXbEg4TE9ockdSaWVYcmExdFVGRmQ0?=
 =?utf-8?B?L3dtV0o5VCtaVDVoN2RuRm0wd1Rpd0JPSHpFOXE5bnlQRG1tcVBiZXkyMlFZ?=
 =?utf-8?B?OEZudjdXR1RlWmFkSHhPS3J3Y3BkQk9Kd0FVM1dGYUVGRHFPZTRxengrNXNn?=
 =?utf-8?B?OXQ0dDF6MVg5ejdJK3BwTVU1QTBsNzdlYmVuUWg5TWxQUFVCMXBNcGlDVDdy?=
 =?utf-8?B?UzRpejNab1l0QTNtZXltdkZ5ZHNJN2dUYVBFM2g3c1p6N2tHN2JsUGdwN3lQ?=
 =?utf-8?B?QUxkaUpZdldXTXdxSnRJenFQUy9xcG1nTTlENWtJWFc0RVE5WkNpaVMzandE?=
 =?utf-8?B?clFFVGk1UlZPYUJ2SEpCallSVzRlbEFCZzR3ckdhTnk0eFRRME1xMW9nMDFX?=
 =?utf-8?B?TXF5TWgrZjFUR3ZtU3VSdlBKNmN1b1ZFT2xWWDlCOTI4Uit5eEZXQXhmUEQw?=
 =?utf-8?B?YWh6NFJkUlFTTy9xcVdpQ3FDSlhTLzlzZmZGZkJtS1pYTWkxUFFTdGhGN3gv?=
 =?utf-8?B?RFh1YTB1dCtLTWNTdXNrYnVBNm80MElXKzRlOWdrWmRwZklvYVVrN3dHZC9x?=
 =?utf-8?B?QkF6VVJkVWc1SUNPbXk4aU14SVV2MXNKVFY5MFJzWlVDSlFmSDkwOUh3NGkw?=
 =?utf-8?B?SyswM2RJN1ZZTnFWaEozRjAxQ1BIckF0SG9UQnNaZjMrNWR5LzdQTG41bDJq?=
 =?utf-8?B?anRSYy9qakpWaFFLVjlHZitHUjRBZkRsUk53RXAzenh2amorTGV0blliVUpX?=
 =?utf-8?B?VXp6d2dRUW9LblRpRjJnUzRrOGpkUTkwMzFHaFVtZVQzNUNYNVBaR3VoT0w5?=
 =?utf-8?B?TE92SVhPWEdCMlJFZFNxbGJpMEsxNnV6eFhWTDVaSk1HaDZ4U3pBOXZCdDFu?=
 =?utf-8?B?YVZjQ245cW1UUGpnOUprbmxSRk1FYm9DK3NmcDRWMWY0SlliWjluYlE2bkFW?=
 =?utf-8?B?My85UmdWcnQzQ092THJUSVhMNHU2cUtwNG9kTjBUSjVhRm1YbDhUeGYwMXNB?=
 =?utf-8?B?ak5OcGhrMzNpQ3N6eFJwVTl2UUpNMHdjUWhrQ1NrczQwZkw4N3F1Y0VhTkxt?=
 =?utf-8?B?M2czNXUyaFZqWGNBdlVIWkZrTks2M2x0b2xyVGdIV2NPenhXL3IrUmhyZW5V?=
 =?utf-8?B?VmJYZEhWeEE1M1lrbklPVU9EckV6UXhYbkhrK3AvcWMzbDdSM25aRWY5bkRV?=
 =?utf-8?B?YUlibjhtZ2JiTk1WeER4WCt3MkYvNlhjemx6NEg5bnZRazJ0SDcxekQ1dlZW?=
 =?utf-8?B?b2VMWmJhV05NdGtwTHR3cFZSdlplTGtWVUhlQUlxRTZjRTNPV1d3bWJrN0M1?=
 =?utf-8?B?OFJ4SkRSQVVERm5qeTNIRGY1T1c1UGQvenFCbEdOL0wvZHNjU0hkR2MrdXRT?=
 =?utf-8?B?Q1lHbWFBUThZaGpGdHlGUkx5VEVOL1lRbDAvRUdEdWp0dFZwVjlnMVQyQ0lU?=
 =?utf-8?B?cWRWMm9ORVZ0b01aQmR0QVordllxbXhtL2VRNk1CTDNuaWx6cVM0OVJJRTBY?=
 =?utf-8?B?WGFMY2I4RjRucHE1VlhGWDRXQ2JxMTRMa0FZbFFqYWpQQ3IzZVZUK1F2ZUtW?=
 =?utf-8?B?bkZacmowckxIRnhMSyt1OHUyeStzZXp5SmNWMUQxU0F1dUZqcXpjV2NtdXhH?=
 =?utf-8?B?TFU0NU9lSmswMHFxcVkveHBFRTQ3dGx1bzFOZG9Hdi94cjNoekhpS2x0bm96?=
 =?utf-8?B?ditmVWF0aktpY2JCbitHemtxbVpKSnU3YzF3bGd5WjFleEVVVXJTclRrNEdt?=
 =?utf-8?B?Nkh0WjdDS0dBOHlLdi82c0QycnJTL2FwNExzWE9QY3JPdHp4WXk5bldJZS9O?=
 =?utf-8?Q?fpiL4T?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDF5c2VWWVNRVzc2RER6L2hpcllobXUzc0Zkei8rZ0N5QjdUazFKM2oxKzJk?=
 =?utf-8?B?dDdOZlhSTldZM2llMGx2WGxzazMyZSttc1I2RTF3MFRPek1zcm9LQ1Awa29y?=
 =?utf-8?B?NWtRNW5Rdi9NUW5vVEtEbTMvcFJ2SzRLR3hxcEFPVWl1NzVkalB6U1VUNUdW?=
 =?utf-8?B?T1Y2Q0V0N3BKdUZKRHRZY0toYVFNWVFkQUFnMDhvYXRqelBNblRCeTZUWHE1?=
 =?utf-8?B?SHpmZmxmbUtjV2x3b0dGWHFUSFhPRmtnZXFncEFSaVg3NlRKanNzdG5jMUQx?=
 =?utf-8?B?Y3pKamx6WG42UG5Wb0p5azJTMmhjMmJialh2WkpKa2JNYm51ZXJiVkRhVHcw?=
 =?utf-8?B?N2JmTEhJSkUrcXpENnRwSkdHOEFiMVdnV3cyazFNc2x1VnBCYlBwQWRJNkhu?=
 =?utf-8?B?djlZdlExN3c0ZlpkRVRTL2ZsbytTUjRsUUMzZ3pUOXlaUTY5d3NuTFZxaCt3?=
 =?utf-8?B?MURGUmlGMFM0VVU1WUVDb3d3bC9YTWFBSlJHc2JOQVVjQzJDV3pPa2MyVkgx?=
 =?utf-8?B?emNRRFZBcFdVSy80T3BrbWxwSzBPRzhER0wySExlV2NUR2RZZStIR2J3b052?=
 =?utf-8?B?d1gzTU9aSEEzejZnU01MSWpGSDJhWUVrSDZVeWo1VXNHVmtqaGhGWWdhcmtD?=
 =?utf-8?B?b3NUU2VnK3VYSE0rdzFnYW1HcFgrQzJSd3kwdTBMYklRL3RIc3piK0dNRldI?=
 =?utf-8?B?MGdoTnJhTERZRTRBc2g0MXZsQmEvZ01Hd3FDcjhwcUR3Q2pFUE91S1pDcmp5?=
 =?utf-8?B?RG1rQlUzblRSZExxK1hZMFBMdFNFOTREZWVuMTJ2T0NLbjY0YnBMQjZRMERq?=
 =?utf-8?B?NmthMVBBckpYWjJidllWT0RIVk5MRTFQOVpYQU5JTkxzS3BjUWd2cFdiOHdB?=
 =?utf-8?B?aHZCUFlhemZjcFYzOVVUSVZ0MVpob1lONEI5UjYwTG1VU1NHVFk5QlR4OUlB?=
 =?utf-8?B?TEYxN0ltdnpUcjQ3N3hlME90eVBQYkh0dW9FZDdlWEhubmdnSzN0RWwvQUZp?=
 =?utf-8?B?ajNtbFY0UFJDSmwwbEhYZUlFRDk3aFc3ZnplbGF1WFpVSUEyNlRKRCtSaXlY?=
 =?utf-8?B?S2xHbndnVnAzZTJleC9IYXJWZTNLL0ZWR3BqY3NjcDFqb0hBY2FTdi9hZ014?=
 =?utf-8?B?SHBpRm54TG9nOVk3aDV4M3BlUDlEY1V5NGpud2czUlpZbHM2YlN4bS9pNVF0?=
 =?utf-8?B?bUtqMUc4TzFrc1k3V3Rmd2E3L204ODFRWVZka0ZkOFZtNGw5OERxaEJjNmpV?=
 =?utf-8?B?Nms1Rkc0Vm5vR25mNTJPVjc0a0VObUdSQklEZ0p5dlQ3YVZ1WVBja3NpalhQ?=
 =?utf-8?B?SU1ZUllUMWhldHhqcWQ1Qi9YRUQxK0pEaEFqRHYrdnFteUlWbHpHNU1lakQ3?=
 =?utf-8?B?RDhWK3lkMmNkL21Ec1NocU1GcFY0bm9qZkdVakNoYzVrQzRVb0RyYVVpNDlH?=
 =?utf-8?B?eENnL0FRVkd4N1VDdEJZdFlVVXQzNlFoRDJMcU1VTVlSaUZJcEVUamlBdDlZ?=
 =?utf-8?B?QVVQalZCVG1BcDZiais0czhiV3R0OXd3bUtNb1VhZXUvVUN5N1BkeHdxK3g0?=
 =?utf-8?B?ZTVGR3ppbmRJbUhZWnYxSXBXQmtNb3dIYnpueSsrcFdYREpjSEk0ZEtHMlhr?=
 =?utf-8?B?dmF0eWZMK0hoL243enJ4K1RLRnhMZkJvWnduQmV6TkcvSkJ1dThVN2x4SEhH?=
 =?utf-8?B?RXlBeXYyaE1vejJqWkMyVjdVU2xzRXBwRlZGNk40RmJ4NUlkNjdqL0hpUXZa?=
 =?utf-8?B?NlBKc3dZc1NEU3I4QitEVzVaa3I4SjU0aUpFdDlYcHVKVU1BNUJmRmN4dWND?=
 =?utf-8?B?MlZQWTE5a1JXbU1lWnY3NmYvVGU5Q3pqdEI0YzlqQWZWRGVUUTc4R2ZRSUxa?=
 =?utf-8?B?TWorcVFycjFyTndLZTRsNXNpaS90MzVXSDFrVzVlaGgvbTU5bjZsOURhTEFY?=
 =?utf-8?B?WFNPbGNreXRtSHIwTmZQaE9ic1VFOXh1VGZPVk1iRWxVeHpKaHRyaVRtUmFS?=
 =?utf-8?B?SUgrSkd1R3Uxd2NFOVRURkJnalZhWTBzeitCYkZnTHRqZWV2SytTVUdRSDE1?=
 =?utf-8?B?eHNzblN2aVVaODBEbVhUUXR1czBobGVKSkpZVFNlU0tNVjIrSTJEUmo0RWhB?=
 =?utf-8?B?N21FRVVzVUFIZjNHdFNRd2h1Z2RGU1dkNHJsWGMyN3YzWjlMa21sOUl2ZXAv?=
 =?utf-8?B?R1lpTUd6RFVReXlTbUhCdytFNExoK1Nac3VwcjZvZXV3OGxLUXl0UWdVN2pB?=
 =?utf-8?B?azNaaXRHdk5XWjlqRWs3YjZ4VEhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2446055C2497A44AA418F60A3DFB5FB9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ppIcsj46w/XnP4e+kPDCl5bYlwefplSmZUCuKuaoG2snejmAElBIqKZYTA6iIzXtMsDMmRmSHKgejEKVQYUVnjsn2wWR1HsQHUlC+cx3lz86/iyn8xk54kHQ/s69pk4AETnOdp3gTC+NP2+oijQ9r9DKYqe+sc/IrntVcVZO3mcVnrHpsM9/DtMu49B0SVTCFTUWqMyMdcXJhBsMeJtpq73qM0AwqVkP575HmpKRPLixEl8o+sPPaIRXP2JJvJo5BQcm32+ebiFX5M18WM3vVHEEDmyATd39rNuUPMDLW/7JFywI/YK8sN4AgUf+6Sbx9j2vX3A2dWvxxf7gV5cdq8Dyt5TUKMZ6pDjFTHix9J83OdJWu1nz1v3o0S2iR9DcSPkZ58vtodddqKFg7asY/uDASMbZVRVwEi2+iVviXoMH89v+HC+VLKqm9KUUNQmPGyYJecS43tKjH4lH8+SD4L08bzAISRF3HX+CQGbY+TreiVCMleHQeLJTkIWm9LpNZo/O1yE+gWzEuBQNTVWBXhjKyDYPK9jgmGkyhqpyXdCzBVLFttr1IubqCyFupG8QXKYqk2OfHCgccC6IdatDBKxl+ATBb+mruNZV9jM+5eXip9r4hr40o/1Kl5FHfbxL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f5730d-cd71-4ce4-6d80-08de05a0c9ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 12:55:27.3235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWTLYV/ew8dBGxtsVIOov8EerI7GXPR4uqvCFzkE4MN3LlYx4EueS89cYHsUMRSmeK7wVZenbAfDJSrYYZnpFgbtkYAMR0Bg/Uydj9QLU6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9442

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
