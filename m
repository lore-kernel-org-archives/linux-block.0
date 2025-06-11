Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909CB1A0BCD
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636975; cv=fail; b=plzg7Jlped+FhTx1qmyYvSQqwlfLBXmzDI4NMDptAb66VmPfTbQkDIQpfY4roncn0XPgRcfWFqVXRukmx1F67GK/oZ9/vpp+4vISfWooZjztMciomR+amrRWu0CFM4cAeJkpn1vo64Aym3vjJWeHncwQJ7gSPJ85edxB+yZTEug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636975; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hjVG5X3FjPmYaYAuglaNkjuMOAcFh675SNNxa2eQkgoP9kGec7IPatNy/uf00TdqNuOMyer4SFMGVpgS0Y4zTNrCP/WYff7kpePHKvZ1hTG+ptre473CgFPddm/O6eaY4HVhvgsJaUxbvYzotx3Enr+IQR6LCknG1CQquuOat4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZbZ8Ty48; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UDmsYaql; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZbZ8Ty48";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UDmsYaql"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749636973; x=1781172973;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=ZbZ8Ty48YoTphDpCWBDl17u8LJWa5MldReSAxeT2LM0gL4A9SsdT3Bvy
   AQxP+VLXxUSauBTAvFs+Eli8yZQzQE/K2rl5FmjwHTz/cNyhgEufFejC6
   KiLDkPiGgKGMiMGJzuc6M9SKSXCPl+KZW2hr6tMx9DytmCtnsyw1ODVQY
   xF8RVMBUMF7ppaUo2K8s8D1qK7W5nL5GSOKXmscamoGvyqtDNAhfdk+/0
   6V2aF39bBAINqAiCieRc4e/kVys7aZaAHtjK6yq0AjXSVIqrPEIOyQhGo
   LrKbNMdYRp6XlLwfBSeerXBWBP4Jqae2kboHfUdfwPYD1jtTI7NiGQ4mT
   A==;
X-CSE-ConnectionGUID: GAVvOonATnukY0fuysxfoQ==
X-CSE-MsgGUID: /yMzKss8QMWI/95M1aZ0nQ==
X-IronPort-AV: E=Sophos;i="6.16,227,1744041600"; 
   d="scan'208";a="86380961"
Received: from mail-dm3nam02on2072.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([40.107.95.72])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2025 18:16:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0fnGjnJY57FJFk3cMMkroozpROJlaaTH/UXNh6VE2vH5BO7BOGE3gGl9BqTKEmhUe1B9KYTqDPOjKDuwMEpMSKD8XPYawYfUXN9qVMv1K7ICNpqRr4Ft7aB6Kq/99CSM9GuY544oYxC0+xx+Me47/lEkdrM8LbIIpEBxpqDyuj0pL1ccAY4OXEta6dg3p6XiVIEls7KnBD1fmV0dPHQBC3IEiLTHry/CF/+N7sBPgxWGmMB+EV1DmzDTgpthUawh5//ZKjNaBKFbPY0MV5WlaIBke9pFipIXSRxBAJVq3umEo03zGnu75e9fsjoAMGCi23fse05CcZATqkViEz+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=liylLbtREUV//lLgSdTtA3cv0wrevZXFVuH5fvw9q7vEtOy4QI5BwZG3IcHh4L/OAx13OVNYUfvvzN/JMVQN9q5u5u1vn1hm10Xkjp+Lav2QHzcNaR2zoNGOX5ZwJkscxDdoOh3atuHRz8czJUJQbskDUE77amBEaeHUzZikk2uReg2g45hTgzIXv2o6R0z0hT8rs8aS3Ue7p+vS/wl57Iek+mQjdlHf9Hx5ZSoEo+NSzSCR0Ms5znrq2Wvrqh7gkxjcsTPgnysW4DuQkR6Dh+CjSY8WAHW9tzvys8/pDo7RDS5E2npGyDBwqHF7SduXksfNmqtEEvmhXBdpAwYzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=UDmsYaql4Bzr9Td38lZJIon6ut8zPkDpCQrNYCuD4X13R2AVjtKR1AQtpwvxmpp8Pb00GYIeQM781aL5F1Iq3+4GbS/KjMt4TN1cPvnsZI1TXiajdGBZCu8r2a0+7RAFMrf4UE0HOcHEGjzUobDXQV/GiJqZcMXbnUTjrM3VpxI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7236.namprd04.prod.outlook.com (2603:10b6:303:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 11 Jun
 2025 10:16:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.039; Wed, 11 Jun 2025
 10:16:04 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Clear BIO_EMULATES_ZONE_APPEND flag on BIO
 completion
Thread-Topic: [PATCH] block: Clear BIO_EMULATES_ZONE_APPEND flag on BIO
 completion
Thread-Index: AQHb2mxU86js0q3zp0erwp52ll790LP9vtQA
Date: Wed, 11 Jun 2025 10:16:04 +0000
Message-ID: <f6947bfb-1000-4051-aee0-779c1a340841@wdc.com>
References: <20250611005915.89843-1-dlemoal@kernel.org>
In-Reply-To: <20250611005915.89843-1-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7236:EE_
x-ms-office365-filtering-correlation-id: 0005136d-f30a-425e-fd41-08dda8d0f96b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZENHbVlGeExrMmdKeS9tbnhBU2lCTUQrRzU0WU1DaXl0MVVTTHpMNC9nY1k5?=
 =?utf-8?B?cHcwM2VPTHNKK3FLa05COEZtM3UvbzZxNFdZMjR1L2s3d2l5ZDZnWkIxVUwy?=
 =?utf-8?B?U21rMFRYek5rM2tPbE1lQUh0U1ZyK3pKTzNPb3ZHT3gvbEVHQUNHV0ZyMjdi?=
 =?utf-8?B?eFNsM2NMT2NnRXRacjdXQ0NuVzczVlZKYXpDbEhBR01wcXV1aDZKdmEwckkx?=
 =?utf-8?B?dWVCcmZwNGg3aEkyckxkbkV2clZwM1p2R2hibGQycXZNNGZyU3lTK1dXNTVs?=
 =?utf-8?B?ZENlU1M3VGJoNVZidklyUWV2UUkyZlpNL0U0ZmxFRVBUa2xnRWJRWElkU0J6?=
 =?utf-8?B?aERQUFZIQkdXdmJMUExQK0F4UmRDeVVIOE1Qa3dhcmYycmNzM0NwUmRrSGZr?=
 =?utf-8?B?YVlWOTZQQVFwR3JEMkY5Q3NDckFwclBMelk5SVdRNFVyUmd2MThLdWZiU25i?=
 =?utf-8?B?YVBCU2kwUGZsWjJRMFQ0bm1nMVpGQTRodU5JRWt5OXpqMlJJZXhmTHFvTTN6?=
 =?utf-8?B?b0lnRSs1NitYaGkwNkNuS09oTGFYQ3dOZXBNTERMS0xiWktoelFpa0FtVktO?=
 =?utf-8?B?Y1l3TGMrVkduNXRtTCttMVNUeVBBM3FHT0RXSWNibWxDNlk2TFQ4M05HRWEx?=
 =?utf-8?B?bld6Q1lpNy9VT1Q2emtXTHJkSHhvc2UyMk9TWkRhR2F2V2VvTVh4ZzhOR1JN?=
 =?utf-8?B?N1pnLzFWKzhCV1pBOVBLeUprRGI4aCs1bVd5UzkwL0pWTWt4TXo0ZTFlTVpa?=
 =?utf-8?B?M2Z0QnhyWDRQZGFQZ1hwMlFwTHVxZi9HS1RaREc0b3pGZlZheHJrazBvY0xB?=
 =?utf-8?B?blF5Mnk3bFAxcmR4Z0hRekloQ1ZNZnA5UEIzRnFrNXBPYnA5a3RLQU4zbmlV?=
 =?utf-8?B?YWR4Y0dOZk4vWUtHU2ZnTDVvcXZHWGNlQXZVR2dmamNZS3hMcEtVbkpuMm1O?=
 =?utf-8?B?QkN0NS94aWREUzljb2VzbHZ4djhxYjhrdFhnTDdOY1pMbU5iSTV0amdKVHh3?=
 =?utf-8?B?Nzd4cVJiOWFtV1gzOGRna1FCSVp1RGZhdUgwbmdaK1FGT2FEMmJHWnBYcU9O?=
 =?utf-8?B?MUVlWWQrdWgzdWI0bnVSNmNIR2w2UzdkbzRkbmRsb2hQSUtjekwxTmdIWlBM?=
 =?utf-8?B?cGYzZmp2dEpDbDJSNUJMRzlKSjQ3Qm14SXF0K1ovM1YzbFpzd0lHTUtQWkIy?=
 =?utf-8?B?STJlTmZ2K3k2aThrZTZURDNOQUNjSU5jbkxsZEQzVkxmYjVwN0o0U25DeHNq?=
 =?utf-8?B?U3Yxck5yTHFlbUJmUEtMMjk0NHhaNFRMSG9NenhIRVh5VzEzV01aZHZXcEt1?=
 =?utf-8?B?NXdrN2UwUCtiNEt3N2xMaTBnNEMrS2FKQWRidjRHYlM2Ui9kSGJoQjBaTDc1?=
 =?utf-8?B?NXJNVk80cEUxWTVyY1g4Rm83RU0rQjhCT1ZzWkdVUTVtYXIza1F3VHBucUtP?=
 =?utf-8?B?KzBXZkd0MFZxV1VPWmloQmdqczVWTkdMN3FEZVUyeVJNUUhOT29lNHdGeisv?=
 =?utf-8?B?UVpKVkxWNlFwWGU1SlJXZVMxVG1CVEZPOTlmZGNhR2tFTEZoWXRpdVpqaW93?=
 =?utf-8?B?RUlzMHY1MlVhNVhob0tvNFZsWUhXM0w3NXBDTkVCczBqVG9PZHRLWGVHYkk4?=
 =?utf-8?B?dm9SZ3NwdTc5TEhiRUdwN1V1RW02dlJMdkViL1dKbjlPS2taZGNCVG00NzVy?=
 =?utf-8?B?VjJsRnc4VU5paFFmL25qeDJ4SXF1RDg2U3J2T0tzUk10RCtBNTJoQ1p3VE9i?=
 =?utf-8?B?WUxSOUhhbmNjNE1LZUN4ZWdaSjZOSmNIdkROcnlYZUQ3clVlNm5WL2ZBN3ph?=
 =?utf-8?B?L0kxSk5sWkxoemRIb3BsWjVlV3RDSDlzYW1hc3hveTZuTXQ5RUZFd1RnR3A3?=
 =?utf-8?B?ZkxISGhSMGhLYVlrbjhFWGhQSnJxMDVITnNNdDhxNWxmMXdiMER2YTd6TUZa?=
 =?utf-8?B?c2JMSmhKRjQ2SzloS2tpOGM0NHZZMUhYYmtSNGt5S1MrUWdHSTVBYU9NczI4?=
 =?utf-8?Q?eJxSFYnmMiI+UkWxs2MKnM5JcCAsJk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXNNMzNzeStFUGxjbUxlZFErUGN0SDVHYnZScWpZM2pqZ2JTYWVXaFFmTVlW?=
 =?utf-8?B?NExnUUIxZm1pQ0JxZExYQWREQTlqbFNpLzNsbTJuNEVEWDI3bTRVRVY5Mmhq?=
 =?utf-8?B?Mi9KNWpoM2FQQmUydURIdXBDT2pMRkJMbUdEZGIyazc0UGZuOHNLWUZTUG5Y?=
 =?utf-8?B?NURlbklOSG9ITGorZHVtM0xSekdyZXZMZkNTbGxJNWRuZ0ZNZzNMK0VZWFZG?=
 =?utf-8?B?MS9zd05ET2xocmZKTXlVNkxFZWl2Z2pNSTlCZG1TRzNLWUMrbytEMjBXbWlG?=
 =?utf-8?B?dDZYYUl5RmRraDl5eXFrUjU5UTQ5VUQ1ZzhBTlB4b2htbFdZcGxCUjNDalJh?=
 =?utf-8?B?Um1tZ3N0bTlHdTlkQk1MYndmMjJJRTltM2ovcXBDUEtuaVJmb1k3MWxPN09i?=
 =?utf-8?B?TXZSNnBUQzg5bWs4MTlMRmRqazQ3UGFPL0xoVkJlNGJrOWpuUlNabHNVR1Bs?=
 =?utf-8?B?L3VkN29kU25KT1ViaXNMdHNXUG1XY1lPaDljbFV5OWFPTFpWOFpiYm1rMlpQ?=
 =?utf-8?B?blVPa05LKzBKMHFVcjhBMlhmeHM2WmFYMXlTSEtGK0o2cXhLbzBRbWx3Qkhw?=
 =?utf-8?B?eVg4NTlsS2dES2ppQUFRM1hRZmJ3bUpuVC81UXdCMEhmQUorWVkwTGpKd3c4?=
 =?utf-8?B?d1k0K1hacnZqU2dNRWtuUkRET1ZQdk9RcE51U1BlZlBXWjlWVDdqRXQ2Zkgv?=
 =?utf-8?B?aDBFODAzd3NJYmhsQ2tQTXJwT2pLSGVYZms4eDhGbVlnRC9ZVGpFWlk0eUdN?=
 =?utf-8?B?b1RPczdIbTlvZDJVdUdhN2ltWTdYcGYyL2hGYkk4dEdtSloxcThBTEp6SDhH?=
 =?utf-8?B?cHBCRWZQK2t4YkxJbjBvTGVmaXJoYlBoVFBGTU1TbXI3bmQyb25EclEwUTBU?=
 =?utf-8?B?Qk5RZ1lDcjUxaVlmZEdzR2lFVFVON253Q3FVTTNlY1ZUQ05iVXpxSzRnZ1Rk?=
 =?utf-8?B?YkM0c05WbzFSQ0NJendOdEZLdTcxVklEN1RYQ2hPZ1RwN2dDNUdESHhGamY4?=
 =?utf-8?B?NExIVlFCQVdmaTZYb1laWUF3M0Z6YkQrQWoyMnN5TjM5bDVsYW5KTzRGZWhV?=
 =?utf-8?B?ckxuamNVRmMyY295Q0lpNGFiRzZuUitaSFdudytsSEdMTDZDcVQxMHA2bXMw?=
 =?utf-8?B?R0RDeUs0OUpWS3hYdTRsZkpySmJHNzBnU1gwOEdmOUVBYmFLNXVYaXAyRjd3?=
 =?utf-8?B?RDNRQ1dTcnJqWWVpVnVBUFltOUxUeGZnSDBRSnFaOFhIVWRhTE5haWdVZ0JZ?=
 =?utf-8?B?UDFkbTJDZ09TTzhueDhLbjNaRFM2blF4V3dzTXBjOEx5MnJ0Yk9Qclc2Qk1T?=
 =?utf-8?B?eW9HajhqVks4V0FxV0haQ0RpZWdzeUFsM00waEFIanNJMGVqd2dRdFYyMjF3?=
 =?utf-8?B?WnlObVBBS2wzMHNCWlFCcDRVaC9NV2pxczFoNTE5eFBWZzl1V3MwMmxhMjMw?=
 =?utf-8?B?TitNYXNveFBQYWVITmVBV0poOElOQXZwS05iaHo2RGhNc1BQVWx1bSthQ0Nn?=
 =?utf-8?B?ZXBEVXhKUHBKZzBCWElpUjhlTmtuRDVsck96cGN6aERWRU93THBBOTZmMjRQ?=
 =?utf-8?B?cVlaOHVMTjBZZFV5ZFhQMVUwN0J3bUdxdzRMSjNlNmZRMTJIazZOTVBhTm5U?=
 =?utf-8?B?djg3WmV0QXAvT3dNczJWS3Y3VXV6bWpvODRxNC9HMkh3MXI5bzFIRDI1MHlC?=
 =?utf-8?B?ODFWMnJSOVpOMUhtU1VvSWxkanVQVjdLOVIrNGQxeGtsQit2c2pYYUVoNG1z?=
 =?utf-8?B?MitBeG9kbkxIKzhQWWw4U1NTZHFPS3FXZmMxV1R4MXZINTRjSmpST3Z3UmpW?=
 =?utf-8?B?RjBJVHhMZTUxZkp4NGJQcm1FaU8zMmRkWVRwNExlb2x2UWRmcW5BenJNNGVY?=
 =?utf-8?B?T1lndi9nVmQ1Nk53TTFVNyszUW1FeEZqUklyRS96ZXBqaTRCK3lqQm5GcVg2?=
 =?utf-8?B?OUkvZUdIUWMxQi9tZWNuZ3NXVm1FWTJDbmFkekxxeG9WVlVJd3kzcFo5RGN6?=
 =?utf-8?B?dVE0WWJYeEw5eEszUHFDNit3bGcxQ0Jyci82ckFhR3BGUWFTWVNIK3Y0S21U?=
 =?utf-8?B?TkRLSmFiL0VtendXdDdTSVF4aFo3NlJYVFN6d3l0ZUZDQW5oaFZzM2lrMlBu?=
 =?utf-8?B?R25xN0hkbzZRaDJaU3BVMDVHMVZDMlpVTHFRR1ZHSlNZVFdMS0llUmlCTk5y?=
 =?utf-8?B?M2lYQ1dReTd4VUlnYWt4VDVNekxueTJVWmlmeFRiMzVsd1gwbEJKcFJyd2Ro?=
 =?utf-8?B?Ly9wbWlRa0dNcWhjSDFZaFp2dlhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <135D96663D636E4EBBF0E2910FE6F8CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FC+hiSjQiTwtqrn7j82S8i9lv8L0P5atxi68gqBvf6wn7jZhu9n3O9yYm1Y8J/Q4ZKEVKERmLpO/Woo4aze7rzYIe9Ts+/hqgzRouLIO0OeBg7cR+uEsvIYneDkh4WtcfP1k1D8UdfcAm/bsihC7CRrZZ5Ci91t0xI3R85+e36vctrchxHpWFGT85QMlsKxuLkCnepZMYnwfBGEn0oZIT1agVqVskQgDbKTF3cE+AW6eLZd8HKZIjtesG19A5LW9JsPvUvQF/+DQdjUx3UZSmz8ewQ+j8DMKgHdwZQSwqnsSS/O234VPBnuX+vFvxW3Ov/pZcMspTIxjdlJQnash/uZ+yaUIT8R7jQICERo4bmnc630asbNVq1GypdbKJUwy34CAK2TQNntpSo2k7LPLvjQvNN8i4xmccbSnQMFawDtB9JO3yHhRbz/JAwFs2jFxU7tMXChkK9/1fVGkNu5Cww/Edrka7lHnZW8ZlhDpVH/xZwLfnaB1MxWpxzH3W40UgFZh7pPaIXGlr519wCX1rxUfr0iNF7R6Naug+zMl5azwdtdJK/fvpkVW9tXChGBVaHbYP9rx9GjEnTtmc6N6epdcI2HU+zQUCZZvyZStXnzfFqmobrCVzj0Bd6e/CHpA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0005136d-f30a-425e-fd41-08dda8d0f96b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 10:16:04.7718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXtE/PjwBjhDuulXn8T1P4yQRWSrQobXKjcsDE2TN77gEeyafAlNlmLwN86IuKyhGH0C3zZck1tzGJUVplauEKnrsClhUMXFSJ2PWVacYag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7236

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
