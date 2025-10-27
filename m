Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49727E06C
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548144; cv=fail; b=kkaIGj237qXEBPQSn84zNy+jhBKCrAM+4YhU8RVVlEno1UO/rYJ+fHrEEpcvDAAec8DtgldJzu+JR21ClJI/pWQtkAd7MBsIVrT1K/jpDTIQrMq4iMBugKWw+8+uCKIGVAuQBBGuazYNDkhOxi4+MEhsnry5Kxb7HDQOMBWK//A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548144; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I24bg7QW1WbebCi9Ohi86muAt/BrVcumHHO5N5MXhuIXucl06ZhlhJOvdGXQ0Hd464XBOK2/KLdxjzai8H2svSivhP02RM1Bl/uuZkrwZV1dAfLq1SLePvWTPVmz5Unjv30j3CTc0/gtdaF1FaXlV4RGHg7b/Fo+/MrIJGBS3vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aPSMUFZr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=axXe71+n; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aPSMUFZr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="axXe71+n"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761548143; x=1793084143;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=aPSMUFZrugmiYchEgWv3qyHEwBmDBb2K1s8X6hdPLYXwyHIjbBJ/0WSa
   xrGDvkIKEy+8g/yB9IJxD78munKV3uPkyE2yVYQhXSs84p9GcSq5H8/ei
   WhPJFRJHf3GgZPc++8sme80yY4NYk54vsm8XCbpbuMfDtJBjumqeTphub
   eW7Wgijcs3GP0kH91UlRc7elqC8uWwb6zmceDq7ivlfzA9+AEqne85xYL
   K0SEoVORPM5A/rLW3gaybniHaBDfuciQcsm4E0GVcSEdU42Liks3y5jzh
   e4ioMRXfXyH6qoVGC4FusMjxvt3ys6djaDX94c1tJTU3zTKFho3silLte
   Q==;
X-CSE-ConnectionGUID: zzhZm/RvQRO+obRB83d/CQ==
X-CSE-MsgGUID: OFPQTKpIS9OZ5CoYpWjtiw==
X-IronPort-AV: E=Sophos;i="6.19,258,1754928000"; 
   d="scan'208";a="133865326"
Received: from mail-westus3azon11010058.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.58])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2025 14:55:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWj2YvxO6wVNJhlzRZQICkZWBoWzU+fgNnuzG8XWzveBB4pOiFbpx05I0k34T9ihKSWsM32u/jWqfv0fA9gsxju+YZwLWJSJQJiqp6DMAkWAxLwyVsa6s6ys9icL7XuALsIba0MnR6BLEMJS7zjr2is67ti4SJQeBx78CAs/ZS0EtBEoqRDt0xVzWCnyWWwl03L7U+gmGiK4+Mw41vdpCzLDUlO6tu93oH8NZE/AGHK/mNK+NUBcC31lrUQQWOk+SVanUzyi9M+6nV437a9YBLhFC7k8FZvUmXR4q2nthpAYuLu1Bf28Sv32KtNI5u9q0YRrlfAogbCQhAMBSpUgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=RVLhvRmNMa0H2WQToPMvytMDl9SoBUrDmjYqdJWnX9Qr7yqURYKnbI+4ljKz9kbUOGOomVRUJuWEPi4WvWzXAU1Z4rjhkETcreRZrz98yfbWwxoPAXJLlAO93jSQnGjIzYfuEV5VYRqVfTO1rhNYn4Fr01qupwbMEbhrVGlKo0jOILAfyAI3gvIXL6AzFH4YUyrDQ7L5GqcJsmUJ2VrV3fJfh2WHlcKQjBVICqGk5HHb2C5Ac7sXeEmQm/YdsGScAC1zFWbXNZZblXxIKq+lYY2/43hLi83+bgwQ3uTPQlzeU93GuP7zuI6u9a2Dem8f4APbSPKAarRPlPPFFHPP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=axXe71+nC06N0cFjiAzNTvWK1Z07k3QIW84X+hxjJgMY7VfSMKWZJ3Uq/G3jScDrkCahM+GQDUwa1IdwfhR0Px/MYBydM9Lyl5Uh1n7wwdF9NDSpDJJeJ9hjTIPObwvYo739tZusdm5XbQWnP/yKryB6ZLCgQAe8ibbEz1M45qE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB9059.namprd04.prod.outlook.com (2603:10b6:a03:537::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 06:55:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 06:55:39 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: fix op_is_zone_mgmt() to handle
 REQ_OP_ZONE_RESET_ALL
Thread-Topic: [PATCH 1/2] block: fix op_is_zone_mgmt() to handle
 REQ_OP_ZONE_RESET_ALL
Thread-Index: AQHcRtkHTxtg6vVOR0+t+PG3YRknZbTVj7aA
Date: Mon, 27 Oct 2025 06:55:39 +0000
Message-ID: <4eb43a9e-a108-4307-a4d4-613ba99c5b9b@wdc.com>
References: <20251027002733.567121-1-dlemoal@kernel.org>
 <20251027002733.567121-2-dlemoal@kernel.org>
In-Reply-To: <20251027002733.567121-2-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB9059:EE_
x-ms-office365-filtering-correlation-id: 65fbc507-718b-4235-fb50-08de1525d6d0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkZoTnlYOTEwaHVxd29xNGtRWXgxaGFrSEtVbUptZW9QSGJtT3hYZHZ0SlFF?=
 =?utf-8?B?N05Na05qZHUrTW43Uy9PMnZ2TXloR09xN2VGWjQwSGQ3dWJoWlFGeUg2NDd2?=
 =?utf-8?B?ckNWWmQwNklUclFaQnlCL0ptTnl4RXpkS2VXVVFTWVBHY1ZIak5Lc01mYlhJ?=
 =?utf-8?B?UDdBbEFiRG5pTEFaNE15TDVkcGlzYUk4NWpXWitPWWdLS0NaaVlWZktYZWxC?=
 =?utf-8?B?Y0VZMlN3ZnBaRHJFRGwzMnpmQjhBUC9rZkNzTnJVRTlVdnpkZStva2ZqUnNV?=
 =?utf-8?B?VncrY1RqMUl2d0hNa3FtWjloQ2loMjlTVW0rQzlmMm9aQ3dkNk1XNzVwbTdz?=
 =?utf-8?B?OW5mSFVqWjA3bElLaHZqY0xpZVpUaWM3TmdraUFQU2txZUVGQm1yUFRybjlP?=
 =?utf-8?B?VWxjd294UlpNbjRRSmhhaDlOSTF4YXhQYzBBZ1pXdWdPeEJoVkdQL0JUblR4?=
 =?utf-8?B?TWU3a2hsbkRWbFhGNno2NHpLVmNqU004NnJSeWgwa3B6cFFGM0RFUEFVTklM?=
 =?utf-8?B?MmRyNzRGenUzaktWR3Bkd3hQb29mTytERHQ1cVBZaWNoaE0zMVdaV29oWWY0?=
 =?utf-8?B?Y0l6d0dVbWdMVkdGTldqaUtMQnhyVnFqVDYzQWpjVXlIUXU0ZHBEeXlkTEF0?=
 =?utf-8?B?Mlp1LzJuV0VnQnBtU2tjNTZYVkVmS0tGTSs2cU9BcC82OVFMMU5QNzlCOERG?=
 =?utf-8?B?MW1YOVpWK0wybUVvM3lkRkNkRHloQ3hxWndLamNNN0d2Rjc0WGxiQm04Q21O?=
 =?utf-8?B?SjJ3QVNob1dveXkwZy9iZVhrRVYvVksrK1QySDdPYXBWc1BBMncvb3pRUktF?=
 =?utf-8?B?bFN0SUMySHVIN3phZzFjR2JlZHpmTnFMc3hlbWNqK3lHNFVBYXRiSXlVWHlm?=
 =?utf-8?B?MGdBZEI4MU5lUHBaaXJYVU03Q2tMTGM2R1FzNFlMRGgwd0xHeS8zVGRRT0hG?=
 =?utf-8?B?M256ck1aWXd4ODJNOE9GQVNVNVY1M0tHdTVXZE42UElWSE5kVS9MYVpDVkV2?=
 =?utf-8?B?dTdxdEJubXpBOTMrbE00VEpjK2lZUC9uSDBzR3BTQnVCdjY5VDh1amNpZzFp?=
 =?utf-8?B?SE1DWDZ6SHRGQjA2aHh0TFNDQkdYNXFaaG1zYkdEN0ZNWWxwdVdmckpmYmQ0?=
 =?utf-8?B?dXBoeDc0eXptd1I5cHJWbEc5QzZOclNBOTRvdGRDVDUzSFYzdGo3bitBY2t2?=
 =?utf-8?B?d3VWb0w3dmZ3bjd5cC9WT0JTMk5GYys2Y05EUERvczdyeVF2UUZLb2YwWk9x?=
 =?utf-8?B?Ri9nQ2xqbUE2c2NFTGRkQVdxU1dsNHlCbVoxTVZtRk5YNWRjanlOZFdLdDQ1?=
 =?utf-8?B?TnJheTNyWmJqNnNFYStnM1F1S3NoYisyc1JBc1VhTGRQck9DT1dvanl3OVZZ?=
 =?utf-8?B?L3pMZU0rUUVHQXdpbE4zMlJycG9VNk1ubGNXVDdlWjRUR3orWWpIN3ZIQldF?=
 =?utf-8?B?YXlxVm5YcnFUTUlwcFBWWU1jSUZIVHhXVG5zb1hZN0E0R1ptMG5JQ2xwYjFu?=
 =?utf-8?B?UzN2NTl6MjI3NHdLRWRwV3ltOFMyUU84Nm5qSStSb2ZoM0FHRmlTWW9sQURl?=
 =?utf-8?B?djlqL0MzdDcwVjluZVlzMVU2bDF2N2xQdW5qQmI4N2xvVUZKd2pxR1dPclBs?=
 =?utf-8?B?Z01zRFlFSzF0VkV2UFZyZGN6ZkFrbEwrd0pRaHJDYVFqK3pXM0Q0T093dnh0?=
 =?utf-8?B?UmpiVi8yUmpoOEd6bHplK3hML0tFWFYwbFluZkV6RldLMkdVTEZUTW9YZzhZ?=
 =?utf-8?B?UjI2R3JxNk9Zd3BzUGRvRk15dWMrd2cwZ0MrankrN1RUR2NxNGcvM1BDTnZw?=
 =?utf-8?B?ZGJBMkxmenZISTZoUmNDTDM1TktwdTYvYWlrT2NLcDhoUFR6T2RHZzFHcHRW?=
 =?utf-8?B?OFdGb05XZzlza0ExRldGZlRyQ21WNjJ4em1ZUzkxd0lmWWFtd2FxRUpBMTQz?=
 =?utf-8?B?QU9wUkhTbFB3bzluR1RyZWV3ajIxbjkyUjQyam9HTEtLT1owM2VZbWpqRnRl?=
 =?utf-8?B?a3RsNW5ESnoydGdpRGtiS00waDBQRFNxRDd6dXRJK0VSclJ6TlFPU3c2Q05r?=
 =?utf-8?Q?bOgtEZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZW9oMnB0QmdSYWdON0ZVcmZ2aklLYUpyMGY5VW5BVmFUTGZsWVhHVWxTY3RQ?=
 =?utf-8?B?TVE4NXlsM3o5UnJtLzNXYlM3aC9QVUh5ZHh1aHRYSW0zbWZQcmg1UWN5c2lM?=
 =?utf-8?B?MHZzc3ZLRWhyZ1duWlNIZnBRdVVFZTg0QVVhcE83aGF5ZDRzYzBMV2lKaXV0?=
 =?utf-8?B?WUs4MEZwaDJjRmVLZSs5K1lGT0tRWGNaR3o1VGRSMzU3QWN4YWc0TGhjVFNT?=
 =?utf-8?B?a2hsY1ZFdnZGYTVoeEliWk9Sc0prYWRJWkwyK2ZWZWJHb3c0WG1PbWszYzls?=
 =?utf-8?B?OWhtNm5Od3d2RlVva2VXNFpzODhxck9vYkEwYmZrY3VxU0pOZEtuYlBuZm9S?=
 =?utf-8?B?R1hJTlRnSU1TS3ltcUZKeE9SbStNckhCVGlya1V0YUZWeE51NVhRZ1ljMWhQ?=
 =?utf-8?B?bWlTRzRrSnZ6WEwrdTM4TkF1VDEwdEd4d3loZlJqY1RTRXg1TEYxSnpsMXN4?=
 =?utf-8?B?QWIyczZtS1JlRDR2YWZkSW85cFRnWU10amEvb1lDL1RPMkoraFd3UTZaNEIv?=
 =?utf-8?B?ejZncmVzMEhFa0huWFM2RWNwNmU2VzdVaHRqYVVPTE43bzJmOWVDNkdYMHl4?=
 =?utf-8?B?L0lOZHZZYVFzRTFFeGNwYTI2ZGF5SDc3Zzc5d1BDSW14cTJaU3pWckVYc3VR?=
 =?utf-8?B?RlhlR3NpWFZYK2NXUmpHeE9ZNDZhNDVKNmJva1NRN1BMT01rZmp5SjkvQTRL?=
 =?utf-8?B?d2w2QUdZMnlLemE3a3h5SXdmTFVXenBzdHo4Y1dVWjRveVNLU3dxbmVPaTJ0?=
 =?utf-8?B?ait3VnphMjBNT04xSTlrL2dwRk0xTmJJNXlER2VId2NCd1huTXNPWUhFbG54?=
 =?utf-8?B?R3g3RUlXUXl6RE5HUWtnbm1mUkx0TmFXOEY5V1ZiekR4eENxWXdxS2NtZXhl?=
 =?utf-8?B?OUw5dFNXd1dXeGY3b3RBMEpVYWZtU2xuSEhsK2JVV3RFaDFzUDlwNFU3VUNQ?=
 =?utf-8?B?SlZpMnptT1gvbFFlUzBZcXZnaHp3dG0yQzFzQ0hvcllPSzFEWDA2SkdaYlJt?=
 =?utf-8?B?cHROTHBmQ3ppYms2SU4yaHdlZE1GMW80YkZGMnNhbkRFMlhXQVdzY2tSZStV?=
 =?utf-8?B?bDVTR1NJZDE4dExYUm9SaTR4b0pFanp4LzEzVWdrczg5bUhaZWJQakxtMG1o?=
 =?utf-8?B?QnRKQmFEdk1kaEZudlR3QlRvVm80ZURQQ0hpcWhSWVMzR3g2MlpCMG9ieU9s?=
 =?utf-8?B?RzZpS1hSM3JDakdPZG4rSWp3VE94eVpFWktHTXVUZW4yemRmdEwwWWNUbHpp?=
 =?utf-8?B?RG52bGJERUh3ZzVNSWM4RjNzT0UrbzV5MGttY1kvemhlWlRJOHp2R29VVkIr?=
 =?utf-8?B?NkNDV3B0bk5FbWdCcUhCNlJTMG13Qk1ZSWpmU2J6dFFXaUg4eUhWK1pqc0Ey?=
 =?utf-8?B?aVNaR0RVQ0gzejZjaldRMzlZZDlLRUZwZUduL1FMWW45U2YraW5DT1V2ZVNo?=
 =?utf-8?B?bmdNZUg5NTdFN0RnUmtSR1RMSlNTcllydDA4MXFMQTB6R1F5eFVEUmNhTDlm?=
 =?utf-8?B?YUkzK3hLbDdXV2JTM1lxT1Y2YmprLzdHc201Q0k4RzRqK1JzY0lpODUzVFU1?=
 =?utf-8?B?anJVVzRUVk5RMi84bmVSZ1k3cUpOaTRlZ0gvQXNJTU1aWktRNThRelJ4NFRX?=
 =?utf-8?B?QWlQSVIzU09idWFocnlSV3hYVDdVNnVubStrY3hISGxFRG9aRWhqNXd4S1RE?=
 =?utf-8?B?UXNQUWNobWJDWkJSamV2SmhKZUh2VDdkZzdmSHFxWU80Wk5vcWRKVkR5cmZs?=
 =?utf-8?B?VjdOSkJhdHBvaW9YYVFkUkVEYzRRdDJrOG05WGphVjNrNWJPNzc1WTNCYnFQ?=
 =?utf-8?B?elFqaElkQWJkYU9iQ2Q3aXlYc3BpdWVRcDZOTHE3ek9WOEVubGFmWkFINmtO?=
 =?utf-8?B?dzJLMEhIdXJpV25DT0w2QjdVa1RyUDBTNUc1aVJSOVVER0VDTUV1ZEd3NURv?=
 =?utf-8?B?L3BVOU9yMjhDd3NObER3elNCSjNEeUY3UEF4Z0UvUHpDQkRDaGpPa3JwS3pu?=
 =?utf-8?B?WnZnWU0ydkNocnpyUFA0a0hMdk54TzRZMGd6NktEU3F6STVtTGlGT2JsaDlE?=
 =?utf-8?B?MXJZMVh2djV4Q1NCUnRheTJZTUNkVllxZ2I1cmdCZ0dIVEFFbGRXakl0NWlu?=
 =?utf-8?B?b3IwMEdMT2Z6UVZ3Y0Y4RkJpUXV3RllrUlk2cVF3VkxScE0wZ0o0OEo1TG5x?=
 =?utf-8?B?MzloN3djaXhabSsvWS9OSzhTT2VDRjVaNjk3QkR4WXQ1WnZXdEJ5KzJWRTRh?=
 =?utf-8?B?ZHh5Z0ZHWmgreXNVR3BtbDJTUkl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA56D0138B2A7242B1F4E4CB73FA7FCF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p/XQt+HXU7eyWEvJP6ZEAI83nuT2lyjzfZoSGeJUU9dT1fQ/VqrTwW0LegiPGvDKNFwmor98hvYke3bf1LY2NHTClSo1qCiSVGiQKfbSjeDk+SmDnZSrYdoqEv2HXomZ09QlY5QGth7V7OrRd7+EthikVAbJ/+pc9TVNPhb5BV1wVHExPJtDhtoIDJq3e2KrFBWa7thdtn87OjQAHFJ3BVrdXook3rvW/Ef2YG/lPi77yMoEczeFplRwpQMIgJSTIuhxDnGu7hktWhS7YVqkIHWylO5fNB6/vB49fSn1iihVz5bztqE3E23jLesaqLuFp+cLxuwgPP5PG/8rLnfUWqaySYeXSdZQH2lhz7icg1Yw82LdzQOpxaUhfIBZaVKWYsLSKxIkNeVR4W9srjsysKUAKrzbXtdoNgyGhC32s7MCIJHDKj0viCmvgbUSetnmEYA7kClEg1Tqr5FMHRep/Bo4j36eGbmH6wXqIMpYuDxFSoMHX6/0WQDD2UlEHMIf6Wj/A2OVZ4ScWMaEUzwSLMQuaakJW1IT7Dr+CCF4kyLB7lsyZ8aydEfcieuZwpnPBbRkwMkSaaZpz6Oia1fvHEEw6kWGlRWotne5rPEYoAQvKEN7JMt5K8bGaKjsMWFG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fbc507-718b-4235-fb50-08de1525d6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 06:55:39.4667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSJ9YVwDjLAVgGHAd3lyxhlHHRg0l9Csf4B93nUSKs0OttCK4mwNbiBuhDyKeKaWvsYx3LVsPLG2UzuidhmMJF1BHo3mNtOt7l5+nsKlNmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB9059

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
