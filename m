Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3B04CB5B
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542948; cv=fail; b=pVRBN0td7aeWHK7Hj7KnjcLgmGsYcoE4LKzKl6TpP6pSFFEPUO73FGhzERj+vSUBCiq5U4Fd8rVvvOuk7Mf7e4y/0laNxiEhgLq097WZYoQK//pvLapFJUf/8oDtiyPpGu/14iWjDrjGEPHJMthYUXzdc3exEsF07NKBgV4gcJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542948; c=relaxed/simple;
	bh=ALG6BP2XLr/uHcs0ovhG1HlhacRqv+QH5w6LD2R93vI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CD4PM+ZusVVitmdALnq+NVlwPvXGffFHlbkprK9OaEzsCfiuMOMEc/Pqz4QQLGxwF42x7nIG3GgObDH3U5AsMoBEXD7Wy3J7Rynk8MnXjdKa8uD5Z1WESNtjIvdMAgHeMmsRQwTuP7Im4xGwBq5GzkiL0NB1BHDFqVrWwJ6wD/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=m/oz7FUX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lXlLaQkf; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m/oz7FUX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lXlLaQkf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763542946; x=1795078946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ALG6BP2XLr/uHcs0ovhG1HlhacRqv+QH5w6LD2R93vI=;
  b=m/oz7FUXn4WjUf+QunM75sQimhpX1Q0ayTE5vBYB4dUiCdX0HoTNaJlo
   T0y9os/dcdqojK4s7G68NcGELbZ6MTcM5tOiyZBuTSlxb+7egVC1Xh2YR
   7DabBtUO4tr4O1/A6WXathy2/wyJ6Tnrc2tdJ01Cl6uEKO946sR+h6JUf
   HR+ANNgULp0alJcuzi68n4nz+/G/LsRNGuv0IVwuzX6PsGo7aB65G7e3G
   FijF5J8Pi+PltQAhczUbRXGrOc2w26sWCsEimNUE+QpMoWsWpHOoc4q2F
   +TfZi+Xwh6MdHW85uFZWvDw9QE9JM/JyAWyy/dDorF+Els1YDxfs03oSX
   g==;
X-CSE-ConnectionGUID: Y5WdZ7ddQdC8i/9TwCkqxg==
X-CSE-MsgGUID: 87RtHvJ4ROi4xsaGYvxf5g==
X-IronPort-AV: E=Sophos;i="6.19,315,1754928000"; 
   d="scan'208";a="135380738"
Received: from mail-westus2azon11012032.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.32])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2025 17:01:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyiXHksbSnspFgpn1RxYNsXKc+460Oh2Sv2I9mklspMCn5a/099DKx/ihftfYWllW8p9W3VY4CqK8Zh0MlpS0MX4krDGh9HL/TcZ4FEzfJCEwTUEeAOMmA5J+KJ/t7qLyLJJ3H3D7mjiapgqCHuyjucovnSM3p5dUi6oUpAMbbRQ4+lk1wBQdx+/x0fZV102T1PJdkJcCNGOrD4TQT/6zOVYJFSZzRkqQn5mD+XIzSuWdhA++DzFeO/V30EfdikXNrEJJ4iHVBdbbYs7g23Mp/YECSlCk1/qvi6y8TFvFI42EoFF+bgGTCLhmnxz08N2deCgOBDlAICb4bEUa98kqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALG6BP2XLr/uHcs0ovhG1HlhacRqv+QH5w6LD2R93vI=;
 b=lnTCnOtoolcd3aptI8Q2acg4OHpQC1hofVzwSvN11Ng+lj/HKUWYAd84x1pyebaPfbu5mnNur6G5JbJBkgxLWBFXNsS4XUtfAv91P0zkxKjtiW1UwmN+0RU4kQikNLLF5Y5vLr9jSIZaalvrcuwgF/xjrGxnUgLodparsWzaPgKXodemLcQjOdJjqfmeQ10mFZrzQdr1hGFMevoOz3vIryigCMzVip8fxhp7CNNTWUrXuCiZGdZC8cWkFp7WEGgx2qHtlTimPO3yQp/0ToFi0cFL57acA6v4HJp9S9X+1x8eYKqgDUTC20VNIfeqssRIdOHlP/6jkF8AxhQ//9eNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALG6BP2XLr/uHcs0ovhG1HlhacRqv+QH5w6LD2R93vI=;
 b=lXlLaQkfw9O28P/PEijm47pk9pXPlKP2atrhHFxg8ZdkziYqu/Bzua3Vkn9Mjyjs2Re7BYAUwk6+rMGOCkyH6b1Oj2gre8PtvF6Z2+yNHcsD2nrmdPwBEHvlzAVUumWmCskXXNxlCEye5KLRN6HKPox/npABbSOptRXczeCOghQ=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by SJ0PR04MB8492.namprd04.prod.outlook.com (2603:10b6:a03:4e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 09:01:17 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::5df3:d910:6da7:49ba]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::5df3:d910:6da7:49ba%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 09:01:17 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: hch <hch@lst.de>
Subject: Re: [PATCH] zloop: fix zone append check in zloop_rw()
Thread-Topic: [PATCH] zloop: fix zone append check in zloop_rw()
Thread-Index: AQHcWQ5dQxWLbGBpV0irLvIh0t1kf7T5tAMA
Date: Wed, 19 Nov 2025 09:01:17 +0000
Message-ID: <7cf2644f-e56d-47ab-a4fd-27386b1db37e@wdc.com>
References: <20251119043423.1668972-1-dlemoal@kernel.org>
In-Reply-To: <20251119043423.1668972-1-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|SJ0PR04MB8492:EE_
x-ms-office365-filtering-correlation-id: c3f2598a-8f06-4df7-bbb3-08de274a333e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2l0TnZNUW8yU04wUUhVUXgwd2t5R0N1cllueWpiSlBnVlg2NXVqUG1Qa05h?=
 =?utf-8?B?L0pIU25ac1NOdjQ5TVZIY0V3bjRZYkVteWM1SEllcGRrYlk5T1hxTE0xWjUz?=
 =?utf-8?B?Q201dm8xTHJpaWFFcHhWS0RzUWdzdkxBYjljVCtqZHFFNmFoa2l6TGx2Mm83?=
 =?utf-8?B?NlppYjE2dWxXNWhJM2hpSnNSbWZVWStaOUlMWVY3VU5Ba0JMWHZ4Z2JXM004?=
 =?utf-8?B?QjFsR3VRZ1J4SWIvZEIreTh5SE8vcWFEdVp2amZEWXprQmN4MjkwMFRTa2Vm?=
 =?utf-8?B?RTJpQWxxc2FTSWx5a1hKSmJPbUZLTFJCQ0VVL3JvVElyZkw5M1R0ZFN1djdv?=
 =?utf-8?B?TUZ2aktrSVhrcUwvMHIvSlpsbk9scmFBb0w1RVpSdGp1UGZPNnFtZWhTWlNU?=
 =?utf-8?B?MVpod1M2aG9vbTVZYkUrMGZiZWJ2WW9tbXNFTXhrQkp0R0RCWkR2SnZTVmdz?=
 =?utf-8?B?Y1c4UzNnVklIN2hvSDhhOE1KMElMVmpEV1hMWHB2c0Ruc0pVWURoeG9aamNF?=
 =?utf-8?B?bC85Wk0vNXFHcHNqaVR5ZDN5MGNWMlI1N0haUkx0cEFnSDh3UlNKRWFIc0Jr?=
 =?utf-8?B?NWd0QnFJL3U5YjBLNGNPNEZ2U3dQbUFicGxWeUNPdW5zOURpRDRXbWhlMVFX?=
 =?utf-8?B?TXVEOFdkWVc2YmlRcWgzeStsNkMybmVqY0FCSS9LSXVxQU5JMG5acERhcVNF?=
 =?utf-8?B?alU3YzFQMEV4NitOcHZLTFViLzVUbDU2ejVPUGxYL0NRTmxDWE1wOHhScCto?=
 =?utf-8?B?aDNEZnZoQzJWczQzMmRqR1NsRzFaOUtnRVRUeUs2Z0hwT0p0T0FYVkl2MmRZ?=
 =?utf-8?B?cnRzWWlYWGhIbjJyZVZGaDl4VE5rVnVxQzhEazFobTBLRHhzeG1rNDg4NHVT?=
 =?utf-8?B?cHdvVFhEWUNEbE1EV2RNNVhYQ0N5RW9iUW1ZazR3dVJOcVFmem5pTkZzVWg2?=
 =?utf-8?B?ZHBjcGwrMTVIMExPdWxZQTI3TGVzZXBNMmthK3dtNkVxcmp5YlMwYjZFdWdm?=
 =?utf-8?B?a0ZBaHVhRGFPSjN6Rk9NdHp3bE9BK0l0K3pPU1ExL3BkeTRZdVcxdE1hb2NU?=
 =?utf-8?B?ekpRV2lhZFJhSk8vNnAxbzcvRHhMNTdnRE1YWVdlZUFiL1ROYVdBcHBLTSsz?=
 =?utf-8?B?UkxSOFNKRTE3aE5LZ1NqL1N4UjRrVFhKYzBXWTJTN1VsZGd1OUtwNmprQmtp?=
 =?utf-8?B?TWZLZ1IwMW1BVWNnWU9hNDRmMW5oZmMrNVJaVks5aU1DSWZUeUxBSEVWYXFx?=
 =?utf-8?B?a0tHUTRtaWlDSlRpWjFiUDl6M0xWdWd2bUEyRVorczRTemJZRlY1VFVGTmYz?=
 =?utf-8?B?WnNTSXJrVGtXc0Ivaml5MDd3SS94U0FyTTZxY3hQeEQ0ekR6S0ZwQ1hWVGFm?=
 =?utf-8?B?VTMvM3BFTUJ6M2JDYUp6b1lQc1FxVUdLOFR5Nnkxc3BFaE0rbGhzR1VKQzlh?=
 =?utf-8?B?UFpoSWlDM0ZiMGZEWlBXZEx0RzAybERTQURVRGk4aDRUMkRKS2ZsalRVb3VZ?=
 =?utf-8?B?aGZSWEpvaklVaS9CNzlGYy8valgydVZtUFJWQ1hJNXhTa1NIU09IVHZBY3Fa?=
 =?utf-8?B?QzQ5M0x2d2xSUGJaZndpeUJxbGRzZ05nNGR5WnlXQ0djS2g3cHI2Nk5zeXYv?=
 =?utf-8?B?eGtkbkdIS0F1VlhoT3NCUHVIS05nK0RZWmppK1ozVnFIYktpTDhsR1ZkZ3NP?=
 =?utf-8?B?WXprNlQ1Ri9aV0JYT2x0MlFacU5kOWFkK2hEVFdUVVBJYU0wUHMxcUdPUEdt?=
 =?utf-8?B?bTVzSlpvb2Z5NXRKbkVtYk1kYzBBanoxNlpDbU9BY0RRWVFnTkVzNyt6WmJQ?=
 =?utf-8?B?L3ZieVlzbllQQnA0NjFHQmdnaTlobTVrWGJKNWRyem0wc1k0UzZ4MkN6ZEYx?=
 =?utf-8?B?S0JDbk51bHdTNVdQUTMwTHNUcmZUcStlcUVvYnV3dDVZZUxoTG00dmg4c2RT?=
 =?utf-8?B?eEJzT2ZHTThpS0tBdSsvT29nWnNibmhlclpIRTBsQzJRcXgwTk02SUI2RU5W?=
 =?utf-8?B?VnlnWUlzd3ByRWxCSXV0N09OZDRscTk1ZUg5M0dab2VHd2MwckpFRVBxRGxw?=
 =?utf-8?Q?YBfwTi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2o4R0wxQ1ErR1B4b2xBeVI4bWRTLzNSSytPTUVlMVVrRkloS2liWkxrUHVn?=
 =?utf-8?B?MzRzNVliNGxLaml2eGVIbzdVVGRLcDNJYXl5US9PMGNEbkZHU1Q2VC9jK09i?=
 =?utf-8?B?ZTBsdXdTK1RrYjJBaGwwKytNSGlQNHJXNTViQkI0YmU5ZmkrM1pEbklmUVR5?=
 =?utf-8?B?ZjdDN09nODFNWWs4cmtLZ0JtZGU1cStJejZ0UmIyZUZFcWVJcytLSlBaeUVF?=
 =?utf-8?B?YkZhc010eGtITnZzMlkzbDdzOGFkSFRpeWx5VktaeGRpSlR5MHN6blZVQ0kw?=
 =?utf-8?B?dlJOblB6czJ2RUlRM1M1QUFkYmlxTkEyaHJMTncrSEJ5NGhuOVJaNERYcG5o?=
 =?utf-8?B?Ny9pN01mNzE3eTA4Z2hJR29paXhYL0dTRDZXa1RaUjR0QkhCcGlEQWhHZUtX?=
 =?utf-8?B?K3hlWUxVS2pDZ0pFWXlBRlhyNWxrQzc0aXRRSWh0Q1JRa0U4MHUrQnhXS1Aw?=
 =?utf-8?B?OHZXc1M5MUp0YmU1UE5oWGhDcUY2NVlGaFZzZWxvYWV0dlVmSGZmcFRTM05W?=
 =?utf-8?B?YVZabXg0TVNpT3ZhMC9pZjhIYkNWQXhQbWdiVmZVSEJpQVlWcDlvRmU2OXhp?=
 =?utf-8?B?L2hWMkdFYzBCOVZibTlqRXVpVlN1R0dGV1RhVzR5RFNrQWxLc3kxalZUYjV1?=
 =?utf-8?B?ZFFWbFgvUnVYbUFBblNVR09Rb3pXR1pVdU5nQUJrU0E5SVVtTkxSamFrbGtF?=
 =?utf-8?B?cUNYcWFoVEppRWRCWHlrcTMvdG5NQ1RnMW14ZlBZWHBDeEUyL0dMdlRuc2c5?=
 =?utf-8?B?SWt0N2VHZjdNbi9sVWgrc1FmSzc1Qk5YZ0J5elArZ2pwTTNLcWtQZ2htSkhQ?=
 =?utf-8?B?ZDJIZkd5SWw3M09rK3BzMGEzY2JSU1lNZzg1NHB2VW9jUUFjSHRxcmYzSUhB?=
 =?utf-8?B?bWRpZFVhVEI4MlgydlZVY3EwVDJybmdUOHo5OG91NXlhVXE5cTRUZ1praHpI?=
 =?utf-8?B?aVJ2TURKWEk5SHlxby9MWnJSSi82dStWMTdtUmlvU3NRVEl6bTl5Q3B3VUNw?=
 =?utf-8?B?QWV5M1ZkVlNDbC9CaDVZTUxOSHVNZkgxelAreFYwM1J2YnQ1azlQK1lsdGs3?=
 =?utf-8?B?YVJuV2VkOTJuRDd0M0FTUjJjbmlFS3E2SUlFNlh5cldvZXRBaXBvU05vTWMv?=
 =?utf-8?B?c2tzRXJBV0xmbE9ZWTlUeU5MN0V2U1pRQWQ0bDRzSjdwaDFmRzBrRE0vbXYx?=
 =?utf-8?B?cFZ1NzA2YlV4aTNqVGRjL3dUWGlJUG1Ec3NBUkZGdlhGcFBxbXUvMjJVWmd2?=
 =?utf-8?B?WXhPeWdkWkJjRFBnbjl1dDVVWFJXWVVRZmd1cDA5ZjJmd1YvOFFlTTlVTC9L?=
 =?utf-8?B?S3NSbW9tTVdUNjVkWTlraDhmcEplRHo2ZC9mUExXcVo5QlRacWxVcGZGdGo4?=
 =?utf-8?B?Y0FuSmd2RHhCTDNKT3ljb2ZFMnBjb2JmVm5ic2dRRmM2enAvM2s4c3RNZHp4?=
 =?utf-8?B?MHVaUHViTWFDakMySi9uWC93bElDdmxSZTdLNXB2dXhDOUh6dXVBa2tvdzZC?=
 =?utf-8?B?Ky9FVjFjdW1LUU5JM3ZKTldTRlFVVGlxMGZQVk9nZVdaMlRzb2Iwd2FxUTlI?=
 =?utf-8?B?R0tiVVFKV2s3emJqb2lhNmd2WEpOMnN1ck0zbWJqYlVKSVRiNzY1SzhhMHRP?=
 =?utf-8?B?N3NXWGxscjlWcjVNUFN1RElNbnVXNEVpNCtkVzJoSFA0VWEyY3lxY1plYmNx?=
 =?utf-8?B?R1R6VWdQTzZFRlVIaFRkTDl3QkdGSmZIUUpkbkllU3RiaHFPTVhGcmdSZkdT?=
 =?utf-8?B?N3RobjU5RTh5SUhuSURoN1ZON084eit2WW44cUhsS202TXNCZnhKWGhCN01w?=
 =?utf-8?B?TVNFeHpJdzJXdmw5d2h6WHRDMUhaUHdXdTdXYVVDU0Z5bHJNU3A3dFd4NDYz?=
 =?utf-8?B?LzV0Y0hPZzY3dkhPUE5pZ2M4cDNHdUxwY213V3oySXp1MGFscnFkazREWE5k?=
 =?utf-8?B?L1VOaFRQbEN5cFV4bmY4UDM4SlAwdUh3NXdGWmx4Ny9jZWdOc2lDZisyVDRR?=
 =?utf-8?B?dUNVeHRxeEpsbHVvb25tdkZFd0hKeWZRZ3AwSldWc1FMUFB1bnFuTkl4b3dU?=
 =?utf-8?B?TjJmckVSQUdWY21LRGd6cmQrVHAyN3krWEUveUxqVm5NZDd5Z3QvQzVpbWtq?=
 =?utf-8?B?M3hSd1NvWnZmUHNyK0xveTVKRm5rbnYvdm5BckpidG14SmE1alErZ3NlT1JJ?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C35EA645803291409A1F54CA550C8FE7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kpuF1P84fzQly2PkdwIbLsqLmGofjem4uiwcxOPJbgbSe3veAzX6Z4cz7v6doZJdNjrGoE6/z29QTgAg9XSo2xgEzRaviU+geSvHBbz8dfHICh5pf6U6cdocvUE+r/W8dhh5a7wDW6S4LSZDO2DyXj0hJTDdkMjo9Z02EN7YPmSgxdrGzir8ZQQkcVlz4IE1aNA+VwNRNJ7hbTqVNh/5cR4LLjHxINJlQgRjq8hHAwynYiKGTkRI8npS4YpeTXHyu++0peOdmFNHy3+94aFFxLePhCjBqVX8SYb2fGf9z0umZbBn7jL5EXuFl3+7fedm+vA3aPYPnU7YkEYqrs701weGZ3r/ZWs9CKYzYnVCgz3UwTgcUS+T5ZVISurpuRN48IX6hKW6ZmF//k8Hr1IoI629KM06jbuNHYZsO+eZgDIAQesGSxmdKOu/fCypATm2yFkCcd/5GWKnU7+1Ym5bTChc4Wt0hEO7z/lItU1YaEibW7cxGDLZyGK2GraFb3obKiYdfa1pc0RIAt4mp50dC2jvUfnVbhXnLhuz6yTf/tZapDY8ThF71H/+w9fXLGKJ3UfShkXKdqLR7BhRW6GaAlMddTt6Io7hyyChxJdfuIeHzkW74kY1HvTc+KYEyyIr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f2598a-8f06-4df7-bbb3-08de274a333e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 09:01:17.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmrERRfKPKEmTOBRfis40q9gV9vqoTACcj4FFTLObA0dIDa5ehlRT2av1I1PIAfF8BmZDvJcVfVHnnXLCfz7OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8492

T24gMTkvMTEvMjAyNSAwNTozOCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFdoaWxlIGNvbW1p
dCBjZjI4ZjZmOTIzY2IgKCJ6bG9vcDogZmFpbCB6b25lIGFwcGVuZCBvcGVyYXRpb25zIHRoYXQg
YXJlDQo+IHRhcmdldGluZyBmdWxsIHpvbmVzIikgYWRkZWQgYSBjaGVjayBpbiB6bG9vcF9ydygp
IHRoYXQgYSB6b25lIGFwcGVuZCBpcw0KPiBub3QgaXNzdWVkIHRvIGEgZnVsbCB6b25lLCBjb21t
aXQgZTNhOTZjYTkwNDYyICgiemxvb3A6IHNpbXBsaWZ5IGNoZWNrcw0KPiBmb3Igd3JpdGVzIHRv
IHNlcXVlbnRpYWwgem9uZXMiKSBpbmFkdmVydGVudGx5IHJlbW92ZWQgdGhlIGNoZWNrIHRvDQo+
IHZlcmlmeSB0aGF0IHRoZXJlIGlzIGVub3VnaCB1bndyaXR0ZW4gc3BhY2UgaW4gYSB6b25lIGZv
ciBhbiBpbmNvbWluZw0KPiB6b25lIGFwcGVuZCBvcHJhdGlvbi4NCj4gDQo+IFJlLWFkZCB0aGlz
IGNoZWNrIGluIHpsb29wX3J3KCkgdG8gbWFrZSBzdXJlIHdlIGRvIG5vdCB3cml0ZSBiZXlvbmQg
dGhlDQo+IGVuZCBvZiBhIHpvbmUuIE9mIG5vdGUgaXMgdGhhdCB0aGlzIHNhbWUgY2hlY2sgaXMg
YWxyZWFkeSBwcmVzZW50IGluIHRoZQ0KPiBmdW5jdGlvbiB6bG9vcF9zZXRfem9uZV9hcHBlbmRf
c2VjdG9yKCkgd2hlbiBvcmRlcmVkIHpvbmUgYXBwZW5kIGlzIGluDQo+IHVzZS4NCj4gDQo+IFJl
cG9ydGVkLWJ5OiBIYW5zIEhvbG1iZXJnIDxIYW5zLkhvbG1iZXJnQHdkYy5jb20+DQo+IEZpeGVz
OiBlM2E5NmNhOTA0NjIgKCJ6bG9vcDogc2ltcGxpZnkgY2hlY2tzIGZvciB3cml0ZXMgdG8gc2Vx
dWVudGlhbCB6b25lcyIpDQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxkbGVtb2Fs
QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9ibG9jay96bG9vcC5jIHwgMyArKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3psb29wLmMgYi9kcml2ZXJzL2Jsb2NrL3psb29wLmMN
Cj4gaW5kZXggYzRkYTMxMTZmN2E5Li4xMjczYmJjYTc4NDMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvYmxvY2svemxvb3AuYw0KPiArKysgYi9kcml2ZXJzL2Jsb2NrL3psb29wLmMNCj4gQEAgLTQ0
OCw3ICs0NDgsOCBAQCBzdGF0aWMgdm9pZCB6bG9vcF9ydyhzdHJ1Y3Qgemxvb3BfY21kICpjbWQp
DQo+ICAJCQkgKiBhbmQgc2V0IHRoZSB0YXJnZXQgc2VjdG9yIGluIHpsb29wX3F1ZXVlX3JxKCku
DQo+ICAJCQkgKi8NCj4gIAkJCWlmICghemxvLT5vcmRlcmVkX3pvbmVfYXBwZW5kKSB7DQo+IC0J
CQkJaWYgKHpvbmUtPmNvbmQgPT0gQkxLX1pPTkVfQ09ORF9GVUxMKSB7DQo+ICsJCQkJaWYgKHpv
bmUtPmNvbmQgPT0gQkxLX1pPTkVfQ09ORF9GVUxMIHx8DQo+ICsJCQkJICAgIHpvbmUtPndwICsg
bnJfc2VjdG9ycyA+IHpvbmVfZW5kKSB7DQo+ICAJCQkJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JnpvbmUtPndwX2xvY2ssDQo+ICAJCQkJCQkJICAgICAgIGZsYWdzKTsNCj4gIAkJCQkJcmV0ID0g
LUVJTzsNCg0KTG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEhhbnMgSG9sbWJlcmcgPGhhbnMu
aG9sbWJlcmdAd2RjLmNvbT4NCg==
