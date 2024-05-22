Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2254B20DF4;
	Wed, 22 May 2024 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716405076; cv=fail; b=uIiAVkP3caAJ0YgJpAKL1FMs0YKYfWRWW9NrxdHdiqmFmlPEbMQVnMCAcEasvJxgKx4zjzt7m/vck9DavXwdVrhDaQZhIRxgx1vC1nxI7at6qN4TJr282CfnrmV6FDbdYMTr2vGVMyE6/I/fviW31ojqXRSx/dKUdVSpC1kxm8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716405076; c=relaxed/simple;
	bh=VDYuGZSoMMfPdXoXdt77OoZhujr4z5xEBHexFKJbEJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hFgiLQ3EEbca9Fz9DJnIdVHsNIBd0WSMxIuI3XtkmveWdOpxJLQ8cWrcBdjq0rCNP/F7s8sWwTlNTzDjzvXFeIEyt0t2HAS/q2y0eSyVwO6ZtRs0njT9NAIv7HhJTi4aOfzgSwrsVwsgJwy7hDD1Q72H0cW5Is55TmIhSlzy5ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JwWpDeaQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ufr8kTzC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JwWpDeaQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ufr8kTzC"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MEp8AX006036;
	Wed, 22 May 2024 19:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VDYuGZSoMMfPdXoXdt77OoZhujr4z5xEBHexFKJbEJw=;
 b=JwWpDeaQfIm8CuHBVkjxvh4uQaMaiiI1E475+/70T+83/6Pn+hlB8HCFaJBVUGfJ8sgM
 lv8mA31vlQf5ErKA8O8jhvA3rvXcZqNKvprIBEsMimgn9OHyNZKXmtYkQAZRKv4Ip5qE
 oW0MxFnSA1o/75rqzO6wLkHgcvc7XVIEPwz66BuaWx+h81MbiscebJ0TtWmC61eaaNtT
 jpSJzfiUds3PnIIYBrne8YclqZnpAr8xrphthx5tLZTdd3Yt2e4FYQ67LY8/w2keesWo
 tLb86NrpE9fagcozxS+0KJ2KVcFNPVLmz1X36VXojM98GBxVsHK6x2wVmN9j7Qe4mCO+ hQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jx2gf7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 19:11:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MHZDb4005021;
	Wed, 22 May 2024 19:11:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js9xg53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 19:11:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBYXL0aZ1CAN5A5JNAE2ilD7T4WTiVlbLMobnI3t7XhdiFp7tdOAFphPG3g7AZUQNsFsaPOo6ZeoADP63Yig5yGLzG+oZ4ffAETAwCefoOggo3iZkwINPoWrFkA5EmnAMLyY4jicG/jvryFC/gDgiw+/fPP8FqOMrYJwNMvX3wxv6HGf9PgTUtXlJRuwhIjBzF5AiHA/UoW8br0ootSslKVNdxBTsAgO8jxz3PISXejY/goJ9nq4ko8A43I7OEeemCPYjwIm0RbgkrTeBl43Wp10IHE+H/zSKGZby4LrlUwrAmZQE35xJZyb6k/lFqOBfXMa/5ADJxHdO9NXt1DnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDYuGZSoMMfPdXoXdt77OoZhujr4z5xEBHexFKJbEJw=;
 b=GD/uLL/df54po11wLQuOXnMu7jRwWGGLjY2We5qYiqAQKuz52zD6D4QT1j6QhgGE20kYRblYyw5H1uyXMVhM/kLjImAyI2bkZMnXwtbPd+oeMT3WVYntFi4rPF2cALbxEgkkHmXfT6kMwNrJ6C4FGv3+LPLEZWqQGws2Rv4smQKiVILn+PbSb/7EtahNQ1HpEOUgFzdMW5IhI2A1HKqI3CMdzl9UvTY7+6kEafUfpqXUhv4WPuNite8wIO7/ZekLhTQx5PO84+QOQiDFy61TiMfwuMJI2sWlQi9AY60qw2rRzxqLtpB5XUkOvDLgp64iI/9uX6zlSYYIdkpuNxeWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDYuGZSoMMfPdXoXdt77OoZhujr4z5xEBHexFKJbEJw=;
 b=ufr8kTzC1Ichp7eR9ScA7UXyJkQfgxEAgHPme/Wc0XM58meRHa4L+lsiQafLHhfi/hqYw40A+Z1pfIxofzEiuX4QBTJPrnjvEXsnhh5/sarmJW1GjFtTerK7ylFAJh9AnR/D1XZaP57LdhteMTsedJhKn7YGomx3pWM1mgs+BtE=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by MW5PR10MB5739.namprd10.prod.outlook.com (2603:10b6:303:19c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 19:11:02 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%4]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 19:11:02 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH V2 for-6.10/block 1/2] loop: Fix a race between loop
 detach and loop open
Thread-Topic: [PATCH V2 for-6.10/block 1/2] loop: Fix a race between loop
 detach and loop open
Thread-Index: AQHaq+jr9QOSb4ihfkuolttTouVFhbGjn5uw
Date: Wed, 22 May 2024 19:11:02 +0000
Message-ID: 
 <IA1PR10MB7240B371E051F8B1D0845A7598EB2@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240521224249.7389-1-gulam.mohamed@oracle.com>
 <dcd2dac3-07d2-4ee8-addf-b9266a84f7fd@kernel.dk>
In-Reply-To: <dcd2dac3-07d2-4ee8-addf-b9266a84f7fd@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|MW5PR10MB5739:EE_
x-ms-office365-filtering-correlation-id: 5e47fd8b-98e9-4e25-5226-08dc7a92ec11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?b3pCK1U4M01jejFRWkYyQWVObmFVMWZKeWc2S3N0dGQvRzYwVjE4KzZxamNo?=
 =?utf-8?B?WUhsTXdNc2h4amNTVW84WG90OXJYeVpuOUZqTEVxTGU3NzZQUFg1dnFKR3JO?=
 =?utf-8?B?N2x3eEt6WjZKN1lGWGcvTWd5SVZnK0NGTkZBeUxteTRZM3p4UW5PalRLcEI4?=
 =?utf-8?B?K0ptSGZTR0xyelViL0hMcWVpYW9KYkIrdEY2N21lS1JXb2dpb3R6SzJwVW5R?=
 =?utf-8?B?ekVZM1ZHSXBEWXNBSFhvbUpwYUxNL0dOb3NaTUIrTUdUQm9hbXgwa1hWNXVL?=
 =?utf-8?B?bld0d2JCNjNUV3huNUwxVmZVb2o1aUxCVm5tOE4yRVZDV1hwMFVKSFNSNFI1?=
 =?utf-8?B?WUxHNWZScFZBT2k0aXZZeUhTSkdiMlFES1I4a2xGamx1UUc0MXFuMndGdVE3?=
 =?utf-8?B?aVFnUngxWUxvdXYxS29hWjJTYVpUVzkrZjFqdWh0d0UyZVlHWUV0WWZkOGV6?=
 =?utf-8?B?bUJFZGNHc2VTaFlWWGlmKzZlOGQwMnNpM1UxdzhNMHFOVy9JQjV2SW5iOWhM?=
 =?utf-8?B?ellQQWN5SjJNdzFCMXM2MFVMT2RJYzVJU3VEQjMyUTZGbjhrdlF3WHB3ci9F?=
 =?utf-8?B?dDFNWFBwTWVjQXhZSG45YjU1UHBWY1VCanBVb0JVajE3TStWc1duUmVXeHFB?=
 =?utf-8?B?YmlpdFJOd3hiN0JrK0c0SnA2ZzFlaGJZVllTQ1lEOHR5cUZKbnphTlZmWXdx?=
 =?utf-8?B?RnF1S1VXbGY5QTRING5JMlFXb29wTnVwRm5iSVpTZFo2bVZHVXBoS1UzS1RX?=
 =?utf-8?B?WlYwaytwTWZ1RTNOYllDeDI2WW8wQ2JUVWl6RzQ5bXhVOFI3bnpObVluZ0Jh?=
 =?utf-8?B?Z0VFb1lBdElCRHZ4dC9XR3EzN0xGL0VTNVQ3T0FFRTh2dGpxSzlQYllrNVo4?=
 =?utf-8?B?S3ZxWWJRZVBjbnRCcU9TdUJMUXlMWjBoNW1ZSW9Jb2pPZU5DWnJXSEJNRFA5?=
 =?utf-8?B?djMwbys1ZW03VW9OQVk3aXJUOFpLZVdKem1FYW0xcE8wa3dqKzdoaUpMT1lW?=
 =?utf-8?B?bVVkY0hFTnd6bjAvWnBxcFpjaTIwaUxDbHhiU2dEd3Q4bGxDcE5vMEt2RWJ4?=
 =?utf-8?B?dTJiN1VYVUdnemhmZ1JRcE5nS0RjbDRSbHFkNU9tZHV4LzI2Z3ROL3MydHAw?=
 =?utf-8?B?R2Y1MmZ1QWIwUjZLRENlU0w1NmFDZVNjRURPNmlMbmpuVXVTN2ZQdG5JK09N?=
 =?utf-8?B?K0dTY3FwcnE2L1BoK3pzRFF3bjRiQjN3ei93SjFCQnBzb3VRYUp5bXJJNVVl?=
 =?utf-8?B?eE9yaDZqR3lRVEFXZG44UENnSnJYYnVsb1NiNmpodkxyR3JyZ0xRTXQyK2Js?=
 =?utf-8?B?alFIWGt2Yzd0QmV6UkFoV2R2dWhnQWhtSFg1M3h1cGxtbjZIYU1FdTdtYUN4?=
 =?utf-8?B?R0VabVVJaEJXVlF0TC9NMzlyS3dWcmROTm9rRDBaQUJOOWppMlZJYnE3N2JD?=
 =?utf-8?B?emphb1pmWGN5UE1lelRMdGlOTHV6T0NybUxRcTAvZEpxbVZydHBweTF5aTI1?=
 =?utf-8?B?STBVNjArK1pRVnhKaDdGdzBvR1ZSK21DV3E5SFZnUDMyQjl5ZzlIc1hXK3Y5?=
 =?utf-8?B?UWQ0TG5nTlRYcGlXeGFtclRzK3RIdEJVUG50anExVjhuUjg0NXFRajEveWZn?=
 =?utf-8?B?V3ZOK1lLVDA3Qm4rU3F2Um85aW5CeW1zV1ZUSU1hOHNlZ2NYQVFyM2RBSFZv?=
 =?utf-8?B?Y2hkN2RZbUYxUWhRek5MbWNxM0NrSkQ3YjhUNHlCby9WV2RQTVlRajNaU0c0?=
 =?utf-8?B?ZVpCa1FqWHNRN0JCRFo2NkxzQUZTQXQ1SjFpc2JkT01jZkhLOWg5RXdrREx5?=
 =?utf-8?B?K2w2TWlHcm9CR2VJMEJIQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UXorTnYyOEo1MkJhSFFjcFhJcTI0UHdDdnBLRFl3T1prWDdWNXhKc3JjRDdu?=
 =?utf-8?B?ZmpqQzIxWjFuRno5WXVUTGlBMnVPQnhBK04xV2VtWUpGM201bUR6RnhLbWtH?=
 =?utf-8?B?YXllYnc5cTRmWlVERUNtREdjbVRzekc3RWY4Y3ZLdVFJekEzakQydlhnSjFk?=
 =?utf-8?B?QlpubFJVOG16U2phekpxa1dwdXVyUHJCSi9DMCtwdlptOG5XMUZwZVgxU1Rw?=
 =?utf-8?B?TG4zRW5aQi9lbXcrUm9pcGJFVkc1dGlJeVVtZEdrVWZEWVFQV3d5cEh4NzBx?=
 =?utf-8?B?N3Jxanh2dkxKRGZQdXAzUUtxemplbDh0Vk5EL0JwNjc0bmJVWWF4UUFpS2pM?=
 =?utf-8?B?NlhmTm4zMmkvcE9oY0E2Y1k1ODVXbkpUTUFkbXkwdWIwaklkYVByRmsvZkZD?=
 =?utf-8?B?UUQ5cnZnOE9EZVdlYThPSnZ1WlJyekIrL3pmNmRvb0VRUTlUZHJLMHQ1NW9D?=
 =?utf-8?B?Q0xkRGE0QmUwOFVZcGJNUkd2aWRDSGdvM2NYSHkzVnRRNk84TVhqMk9PTE1k?=
 =?utf-8?B?UmFZTklMb1NkTWdiY1IzWnV2N3FKZ2JnWjEvTEtsRjl2RWFDcDJLempNenJM?=
 =?utf-8?B?K3FWZlBhQXh2bTdhL2prNkZPYjRVb3lrV2tPOUl1QnBNQ1cvQjhGbmFiL0p2?=
 =?utf-8?B?Qmd3Ry9UUFEzd1phaDJBMWdoMVI3R3k4MlMwS2wwOSsyZUY2WkJqWGFvYWhH?=
 =?utf-8?B?clFlRTh4d0JrTjIyYzlYQkh2a1RKZldTRDJobDcxRHZCV3hPeTlERUdadFly?=
 =?utf-8?B?KzdXWExTTXZpWEUybnAvUkNSUW1HMzluZWJmR3FhL0pEMWJ2dlB6WmtJajN1?=
 =?utf-8?B?SVdmVHlYZVhyOFQwbHFOeUZWcmtRS3I0c2RoTyt2dUxzclRLVFR0TFlraHI5?=
 =?utf-8?B?M2VLZWFVS3ZRSS9kRlJhVEFNdkxNMUVhRE5JMW9XUE1oemxvazcxWnprTG9T?=
 =?utf-8?B?M29NNTg3cmRYOGVlclJvVkxYdjRFTnJhMUpndWh3dkZxcHVSdWlQU1FHRkd4?=
 =?utf-8?B?dGk0QU9VQ1MydUVqVzBtTCt5UC9uOWdYRHZkQTRldmR2dTR3L2drRGRRNG1E?=
 =?utf-8?B?ZlMrNmE5NU5NeVRzZnNEWGlydU1KQ3dTd0RZRzJ1NWZ6QS9NeFNHY0FSMzQ5?=
 =?utf-8?B?MTArYVFpc245dTIyalpYYnFQTHhQTVh5cXpLcUxtZlFVNGEvUzVOZG5PNzI1?=
 =?utf-8?B?Zzk0bEptYVcvd2ZUSEJhSU1mbkZTTzFNZ3pXNU1wUSs0TnArRDJhcDdlTXRm?=
 =?utf-8?B?NmczeUhKcWJFczM0dVlSY3dkeVRablk1ZXBEeUZyV3BtU1FFVndnaEZETk8w?=
 =?utf-8?B?SW1xekxEVnFFSEZEUFBKSTQ3dUQ0N1A0OEl4SXhzVHRzSm9mdnA3dGtjb1ZW?=
 =?utf-8?B?SnRtbE5icWxaU1FVTFdKTUxFTUhyK054VWU4THo5U1lHcW8vUkIwdXNtRjNx?=
 =?utf-8?B?Nk5SYXQwblJTUVN5ZGZ5RUZoQTFYUWZVVUQxNHZLWllrS0FDcjRoMGdIb0RU?=
 =?utf-8?B?THJ2Rkw4RGNCL3dsdDlRdDJDZURONTUwU0VSb3VGbExEZzR4MWsvemhuZHFi?=
 =?utf-8?B?SkRiWWIrOWRreXhCQVRRa3EvZ2FqaFZ2dnRMTTF6S3VjWUVTQXk1YVgvN2VK?=
 =?utf-8?B?ZEtTb1BmVXRna3RQb2s1U0l2U202ektYUnVSdWNtdzVEcmFuVmVaWC9UbjBa?=
 =?utf-8?B?RTBKZjNrb1libjNPRUZsdExCQk94bkpMRGNDOUZOKy9HV0xUT296R0xkR29X?=
 =?utf-8?B?UzJmbm9zUHQyTXp4eU1pQkpmOWpvZ1JoOGYrVC9TTDI0MnZyR1NkY0ZqR3NO?=
 =?utf-8?B?WDZ3aTUyNjdqcWJESkwyc0lac3dOKzNGU2l1NFl4UTczeW9udTAzU0QxQU5S?=
 =?utf-8?B?bmZzZ1R4S3ZHVXJyOVRhdE5PcW1na2c3d0NZUkNOM0V5aDVxc1hNeWdiUTho?=
 =?utf-8?B?MkZMSVMrSlMweHJmMnQ0M1F2bWNRRmNNTWZDQUNYMHFrbWtaRDRHbm4wTXdY?=
 =?utf-8?B?L0tuZGwvdDg0TmlLZ2Z3bm1ES1lUZlozYmJWYThSQ2o5UXJONzVBK1VPVG5p?=
 =?utf-8?B?dSsydFh5aWJ2eVZ2Rmk1Q1piRzFXWFYxaDhyTUZoMTU3eHQxeFVockNvUXFo?=
 =?utf-8?Q?Mqd+KmNK24h8BQrIk4OO74hbx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GqZ8CiWgPcy6cw+tBHpvXwUEUljq/Z2+ls5aGuekAxy8bMPRd6C9rAi2N2fTf/ZWKKd6pwOqvGlgZHtvSpGKvGfNk7rDDFCYXTDxMI77b7ZYeqSIalHnGX5BMJ6ELLkVbCgOdm+tFOfvM/l5zSgmhFZ4BpXan1yO76N8oXgZ1B7UqxNE6qUkcNDzQXtA4UXqQu/lqdu40g5xJWKn2iQPj2VpRhqz55JkJb16238eBB0EwSVvFIBLCF+sQ+wW9GBUKh8JCZpEexbojGh/T5n+2S11NDDZFE6V4xTQ2qYzzwRsdnzCqMYohk82B8oeFP8GB0fadwmNvekM/Q1Pd7xWe+sbBPsqU9a2eueW2kUapQmNDyr1yryLkqS33rqn4Ced+DVjo7Zyo5vqbj35pZ4EqAOgAO9sqnIW4jRUZIMWC0PR6sf2ig4tmwKRenJ9SfT7J0gqafU4yH5B4EfbEFF9poVIHQbwVLop8fGgJd9c5ac0rp4PKW/ghUjvP5ocfYAZqHrh8xxscPWEPTzDfCCNejx/LXYGgoXewZbXGpE+tHWK36pXMW7tbGB/J1qvHl6YuKNa0wAKTG/Dhpz1b8px2O7HvcKz7uWZP2pg0dcUJKo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e47fd8b-98e9-4e25-5226-08dc7a92ec11
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 19:11:02.3875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MjZBrJ02KJVbRrIyNutob9T6l8tCaf7eQz5XyqRBeFmAIoroplZ70M41s9Z0uknYaboF1igFPeLwmaDvyxvzK7knO+3kR6H0NqBx2H4LIx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5739
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_10,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220133
X-Proofpoint-GUID: x7cI44BpXpa8gLmoA7YfFuYzp56vPNu-
X-Proofpoint-ORIG-GUID: x7cI44BpXpa8gLmoA7YfFuYzp56vPNu-

SGkgSmVucywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZW5zIEF4
Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDIyLCAyMDI0IDc6
MTAgQU0NCj4gVG86IEd1bGFtIE1vaGFtZWQgPGd1bGFtLm1vaGFtZWRAb3JhY2xlLmNvbT47IGxp
bnV4LQ0KPiBibG9ja0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbTsgY2hhaXRhbnlha0BudmlkaWEu
Y29tOyBoY2hAbHN0LmRlDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgZm9yLTYuMTAvYmxvY2sg
MS8yXSBsb29wOiBGaXggYSByYWNlIGJldHdlZW4gbG9vcA0KPiBkZXRhY2ggYW5kIGxvb3Agb3Bl
bg0KPiANCj4gT24gNS8yMS8yNCA0OjQyIFBNLCBHdWxhbSBNb2hhbWVkIHdyb3RlOg0KPiA+IERl
c2NyaXB0aW9uDQo+ID4gPT09PT09PT09PT0NCj4gPg0KPiA+IDEuIFVzZXJzcGFjZSBzZW5kcyB0
aGUgY29tbWFuZCAibG9zZXR1cCAtZCIgd2hpY2ggdXNlcyB0aGUgb3BlbigpIGNhbGwNCj4gPiAg
ICB0byBvcGVuIHRoZSBkZXZpY2UNCj4gPiAyLiBLZXJuZWwgcmVjZWl2ZXMgdGhlIGlvY3RsIGNv
bW1hbmQgIkxPT1BfQ0xSX0ZEIiB3aGljaCBjYWxscyB0aGUNCj4gPiAgICBmdW5jdGlvbiBsb29w
X2Nscl9mZCgpDQo+ID4gMy4gSWYgTE9PUF9DTFJfRkQgaXMgdGhlIGZpcnN0IGNvbW1hbmQgcmVj
ZWl2ZWQgYXQgdGhlIHRpbWUsIHRoZW4gdGhlDQo+ID4gICAgQVVUT0NMRUFSIGZsYWcgaXMgbm90
IHNldCBhbmQgZGVsZXRpb24gb2YgdGhlDQo+ID4gICAgbG9vcCBkZXZpY2UgcHJvY2VlZHMgYWhl
YWQgYW5kIHNjYW5zIHRoZSBwYXJ0aXRpb25zIChkcm9wL2FkZA0KPiA+ICAgIHBhcnRpdGlvbnMp
DQo+ID4NCj4gPiAJaWYgKGRpc2tfb3BlbmVycyhsby0+bG9fZGlzaykgPiAxKSB7DQo+ID4gCQls
by0+bG9fZmxhZ3MgfD0gTE9fRkxBR1NfQVVUT0NMRUFSOw0KPiA+IAkJbG9vcF9nbG9iYWxfdW5s
b2NrKGxvLCB0cnVlKTsNCj4gPiAJCXJldHVybiAwOw0KPiA+IAl9DQo+ID4NCj4gPiAgNC4gQmVm
b3JlIHNjYW5uaW5nIHBhcnRpdGlvbnMsIGl0IHdpbGwgY2hlY2sgdG8gc2VlIGlmIGFueSBwYXJ0
aXRpb24gb2YNCj4gPiAgICAgdGhlIGxvb3AgZGV2aWNlIGlzIGN1cnJlbnRseSBvcGVuZWQgIDUu
IElmIGFueSBwYXJ0aXRpb24gaXMNCj4gPiBvcGVuZWQsIHRoZW4gaXQgd2lsbCByZXR1cm4gRUJV
U1k6DQo+ID4NCj4gPiAgICAgaWYgKGRpc2stPm9wZW5fcGFydGl0aW9ucykNCj4gPiAJCXJldHVy
biAtRUJVU1k7DQo+ID4gIDYuIFNvLCBhZnRlciByZWNlaXZpbmcgdGhlICJMT09QX0NMUl9GRCIg
Y29tbWFuZCBhbmQganVzdCBiZWZvcmUgdGhlDQo+IGFib3ZlDQo+ID4gICAgIGNoZWNrIGZvciBv
cGVuX3BhcnRpdGlvbnMsIGlmIGFueSBvdGhlciBjb21tYW5kDQo+ID4gICAgIChsaWtlIGJsa2lk
KSBvcGVucyBhbnkgcGFydGl0aW9uIG9mIHRoZSBsb29wIGRldmljZSwgdGhlbiB0aGUgcGFydGl0
aW9uDQo+ID4gICAgIHNjYW4gd2lsbCBub3QgcHJvY2VlZCBhbmQgRUJVU1kgaXMgcmV0dXJuZWQg
YXMgc2hvd24gaW4gYWJvdmUgY29kZQ0KPiA+IDcuIEJ1dCBpbiAiX19sb29wX2Nscl9mZCgpIiwg
dGhpcyBFQlVTWSBlcnJvciBpcyBub3QgcHJvcGFnYXRlZCAgOC4gV2UNCj4gPiBoYXZlIG5vdGlj
ZWQgdGhhdCB0aGlzIGlzIGNhdXNpbmcgdGhlIHBhcnRpdGlvbnMgb2YgdGhlIGxvb3AgdG8NCj4g
PiAgICAgcmVtYWluIHN0YWxlIGV2ZW4gYWZ0ZXIgdGhlIGxvb3AgZGV2aWNlIGlzIGRldGFjaGVk
IHJlc3VsdGluZyBpbiB0aGUNCj4gPiAgICAgSU8gZXJyb3JzIG9uIHRoZSBwYXJ0aXRpb25zDQo+
ID4NCj4gPiBGaXgNCj4gPiAtLS0NCj4gPiBSZS1pbnRyb2R1Y2UgdGhlIGxvX29wZW4oKSBjYWxs
IHRvIHJlc3RyaWN0IGFueSBwcm9jZXNzIHRvIG9wZW4gdGhlDQo+ID4gbG9vcCBkZXZpY2Ugd2hl
biBpdHMgYmVpbmcgZGV0YWNoZWQNCj4gPg0KPiA+IFRlc3QgY2FzZQ0KPiA+ID09PT09PT09PQ0K
PiA+IFRlc3QgY2FzZSBpbnZvbHZlcyB0aGUgZm9sbG93aW5nIHR3byBzY3JpcHRzOg0KPiA+DQo+
ID4gc2NyaXB0MS5zaA0KPiA+IC0tLS0tLS0tLS0NCj4gPiB3aGlsZSBbIDEgXTsNCj4gPiBkbw0K
PiA+IAlsb3NldHVwIC1QIC1mIC9ob21lL29wdC9sb29wdGVzdC90ZXN0MTAuaW1nDQo+ID4gCWJs
a2lkIC9kZXYvbG9vcDBwMQ0KPiA+IGRvbmUNCj4gPg0KPiA+IHNjcmlwdDIuc2gNCj4gPiAtLS0t
LS0tLS0tDQo+ID4gd2hpbGUgWyAxIF07DQo+ID4gZG8NCj4gPiAJbG9zZXR1cCAtZCAvZGV2L2xv
b3AwDQo+ID4gZG9uZQ0KPiA+DQo+ID4gV2l0aG91dCBmaXgsIHRoZSBmb2xsb3dpbmcgSU8gZXJy
b3JzIGhhdmUgYmVlbiBvYnNlcnZlZDoNCj4gPg0KPiA+IGtlcm5lbDogX19sb29wX2Nscl9mZDog
cGFydGl0aW9uIHNjYW4gb2YgbG9vcDAgZmFpbGVkIChyYz0tMTYpDQo+ID4ga2VybmVsOiBJL08g
ZXJyb3IsIGRldiBsb29wMCwgc2VjdG9yIDIwOTcxMzkyIG9wIDB4MDooUkVBRCkgZmxhZ3MgMHg4
MDcwMA0KPiA+ICAgICAgICAgcGh5c19zZWcgMSBwcmlvIGNsYXNzIDANCj4gPiBrZXJuZWw6IEkv
TyBlcnJvciwgZGV2IGxvb3AwLCBzZWN0b3IgMTA4ODY4IG9wIDB4MDooUkVBRCkgZmxhZ3MgMHgw
DQo+ID4gICAgICAgICBwaHlzX3NlZyAxIHByaW8gY2xhc3MgMA0KPiA+IGtlcm5lbDogQnVmZmVy
IEkvTyBlcnJvciBvbiBkZXYgbG9vcDBwMSwgbG9naWNhbCBibG9jayAyNzIwMSwgYXN5bmMgcGFn
ZQ0KPiA+ICAgICAgICAgcmVhZA0KPiA+DQo+ID4gVjEtPlYyOg0KPiA+IAlBZGRlZCBhIHRlc3Qg
Y2FzZSwgMDEwLCBpbiBibGt0ZXN0cyBpbiB0ZXN0cy9sb29wLw0KPiA+IFNpZ25lZC1vZmYtYnk6
IEd1bGFtIE1vaGFtZWQgPGd1bGFtLm1vaGFtZWRAb3JhY2xlLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9ibG9jay9sb29wLmMgfCAxOSArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ibG9jay9sb29wLmMgYi9kcml2ZXJzL2Jsb2NrL2xvb3AuYyBpbmRleA0KPiA+IDI4YTk1ZmQz
NjZmZS4uOWEyMzVkOGMwNjJkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmxvY2svbG9vcC5j
DQo+ID4gKysrIGIvZHJpdmVycy9ibG9jay9sb29wLmMNCj4gPiBAQCAtMTcxNyw2ICsxNzE3LDI0
IEBAIHN0YXRpYyBpbnQgbG9fY29tcGF0X2lvY3RsKHN0cnVjdCBibG9ja19kZXZpY2UNCj4gPiAq
YmRldiwgYmxrX21vZGVfdCBtb2RlLCAgfSAgI2VuZGlmDQo+ID4NCj4gPiArc3RhdGljIGludCBs
b19vcGVuKHN0cnVjdCBnZW5kaXNrICpkaXNrLCBibGtfbW9kZV90IG1vZGUpIHsNCj4gPiArICAg
ICAgICBzdHJ1Y3QgbG9vcF9kZXZpY2UgKmxvID0gZGlzay0+cHJpdmF0ZV9kYXRhOw0KPiA+ICsg
ICAgICAgIGludCBlcnI7DQo+ID4gKw0KPiA+ICsgICAgICAgIGlmICghbG8pDQo+ID4gKyAgICAg
ICAgICAgICAgICByZXR1cm4gLUVOWElPOw0KPiA+ICsNCj4gPiArICAgICAgICBlcnIgPSBtdXRl
eF9sb2NrX2tpbGxhYmxlKCZsby0+bG9fbXV0ZXgpOw0KPiA+ICsgICAgICAgIGlmIChlcnIpDQo+
ID4gKyAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiArICAgICAgICBpZiAo
bG8tPmxvX3N0YXRlID09IExvX3J1bmRvd24pDQo+ID4gKyAgICAgICAgICAgICAgICBlcnIgPSAt
RU5YSU87DQo+ID4gKyAgICAgICAgbXV0ZXhfdW5sb2NrKCZsby0+bG9fbXV0ZXgpOw0KPiA+ICsJ
cmV0dXJuIGVycjsNCj4gPiArfQ0KPiANCj4gTW9zdCBvZiB0aGlzIGZ1bmN0aW9uIHVzZXMgc3Bh
Y2VzIHJhdGhlciB0aGFuIHRhYnMuDQpJIGFtIHNvcnJ5IEkgc2hvdWxkIGhhdmUgY2hlY2tlZCB0
aGF0LiBXaWxsIGFkZHJlc3MgdGhlIGlzc3VlIGluIG5leHQgdmVyc2lvbg0KPiANCj4gLS0NCj4g
SmVucyBBeGJvZQ0KDQo=
