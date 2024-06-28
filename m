Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5CD2139A8;
	Fri, 28 Jun 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566763; cv=fail; b=gESGKPgd/oMQuWeVPQfLbSkkkqlx1vv89+yNpZALEc9qQy9/3sLlxK37UbGKMErYFXhQHVXvobgToLpTPP2slpisPqcUDXKOWU6TF9eN71PHoSt6Mne9sGO0sv0zS6e7+jAPxsGTHFiV+MyeTpq7ktGEWOKP55QVojBBC60u13I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566763; c=relaxed/simple;
	bh=ffKD9OyAzUvfs8JDOPWD7mYnhFKbKbZugLpJcS54gIY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G3o9ymRz9hghugWD+fq1w0ggEg4xmN3P3CVdJ9sYS+UhVi92h6xqbLyt2iI6J0GRNAI5lxo3dRZJ/pXSeLXMYgMzGOnhv4b3Ay/HZY3g+2zOd4OE2UkHCC+j2iRsKyzY0ex/nlHNX8ZmOnXuD2ASVeyg+8Wo22c8ldloJNbkLQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PaailPW7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CVSQV6fl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PaailPW7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CVSQV6fl"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S8MV2L009179;
	Fri, 28 Jun 2024 09:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ffKD9OyAzUvfs8JDOPWD7mYnhFKbKbZugLpJcS54gIY=; b=
	PaailPW7muhdGFeK1BnpwlYuzLYa9TmLeNCjkyPTb3BwFz/IXOYS3ZzO9VmZXT6v
	om2dRsdMcIseUauF3hXRt6+WqqVKqTeHtFNYlprTctsynFkJZexgpb4N9Q/cNEbM
	f9Xe7ZBnrOacwxoupUYvFzxswM7LI+wh8Nb5320oJj7KaNOl/MIVIX5n8SECbjc4
	6p4YV27SpCWnu7ELMKbpSb7bPkRLowHbklevWklNvl8858ntKXbsnGQCX9ceIpvN
	67CQkorVvhq/iJu48akLnzUU8fCw2aFaBNDxv7uknbd6Xk29qf0B2qk6miW1915D
	9DL6pQzvEO65kwtA/Qt3/A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7sqtx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 09:25:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45S9Ivp1023309;
	Fri, 28 Jun 2024 09:25:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2j3892-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 09:25:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUcH5hJWNIYMnq0KI2sricUa039bKWMIXaYlR7Pc0dvNdX6zAfGUIJoEFgi9W7YHtABLGvrPDSNSPFOi7tSH2oZeo7ca6eKCiLZdqW1C82yU8SIupjvHJr+CNi0OidqCgo+vtfOIIxNfUSZa08hbSTkx08GDbUqbBABHsCXCoL+9g8SV83zhJSUih9z8M2681HjrdGB2cf7a3C3XFG7Vjqqt6r38AyvLdk9pbodE+CAzYeQ9nnvugPLXOURCrF2h0MyIBvaGcfpn84PJLMLu2XVaHhdhA8PR5K5L3ufYduFSv5A1MvsvjikUbTJ2LGwGMxte6ifcEGm2KHHuce8XMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffKD9OyAzUvfs8JDOPWD7mYnhFKbKbZugLpJcS54gIY=;
 b=gwlAtghjD07bJiJQlAWmEEGRCgFpVoWcAMT0YCJpDk4j5CeM8PfNTIzY1xnahL5KW637qwYHoqD+WWYuZIptKNnTecQbegoIVLOfAqeXDMEPJB9O370kl8W7iSL9PsoipvxOtXqyOAfDRXefAWpaQB3FQFgiHG5i9AQpQoCwffFvcTXHXJ/Li85Is4YMHipISK0ZWj3QSNOArMxgK3Xs5VobOkFOjSkiFvLrgsHkclKYBP3zt+JLTNJ6hsBoZN8zs/Du/jSxqNw+EXcGKWSO88LuuojrXt38lP4xq2SFt1C5ldHI9Ry3kcxWXL+uHHM2OXSStFOAyToeCR/5WfOojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffKD9OyAzUvfs8JDOPWD7mYnhFKbKbZugLpJcS54gIY=;
 b=CVSQV6flVt9HfhMnx+uFTc/rHNU/uG3tpyKOB5YqyvCjN0cf9RsyAEgj9hQONeYmBbQTijw7ANmxnRhViCoLiCy7XwHaGfMUCDnQXXuU5ernU1c/FsQMAxseBRzJU5ShGiKzv77I8A/4//3UP14ThegnXf3/pbCYW8JC2w7I8UY=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by DM4PR10MB6840.namprd10.prod.outlook.com (2603:10b6:8:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 09:25:49 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 09:25:48 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        Christoph Hellwig
	<hch@lst.de>
Subject: RE: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Topic: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Index: AQHawiDxSOf+1W/UnkG1CxXEGa2wWbHcF+oAgAAhzgCAALwrMA==
Date: Fri, 28 Jun 2024 09:25:48 +0000
Message-ID: 
 <IA1PR10MB72402551956A99124643E89298D02@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com>
 <20240619081601.GA5434@lst.de>
 <IA1PR10MB72407980A58E57E91F80777F98D72@IA1PR10MB7240.namprd10.prod.outlook.com>
 <dd7ab5dc-51f7-446e-8250-ddc62f6f66ff@kernel.dk>
In-Reply-To: <dd7ab5dc-51f7-446e-8250-ddc62f6f66ff@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|DM4PR10MB6840:EE_
x-ms-office365-filtering-correlation-id: a1323441-1fd3-4493-738a-08dc97544bf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dnBoZkh0U1UxQmZXYm9yUndJWFQ2R2VtYTFmVXNURnJSYUtRNWhrczgvZlQ3?=
 =?utf-8?B?SHQwdVB4TlgxaUF6cGJSTkZUeXVNNnh2WnFZdUhOUnh5ZjA0S3luRm5UdkJx?=
 =?utf-8?B?eU1HbVg2ZDBDVGRRZ0hQNEZGVThvd0tTL01TT2IvenlwY0NNdWowRFVwSlFj?=
 =?utf-8?B?d0FKSjFNeXRLYVE1TExsQmV4WWtON3BvYnpna0ZQZUk3L1lXZkdaR3VuelFD?=
 =?utf-8?B?MDVPV2F0Z2R5azRneTdYMXhBd3AxSzJZN3hodWQwM095dW1NR2NSTC9tbVhz?=
 =?utf-8?B?ZC9Ud1J2Q3YvYy9kYTFJZk13Y0orUmlCdnRUTkxRb1VhdUlQUnprNWVjT3ll?=
 =?utf-8?B?YzYvWTNvNkwzdDBEMVN1U1o2U1FId3F6T29MKzlMRFBMeGdITlM2VVI3NnNh?=
 =?utf-8?B?NHEvaTMvL0N4ZEQvRUtvNVBVS0VoRElpcnJxaFJGYkpjUFVNdU5XdW5Lc3V1?=
 =?utf-8?B?SHN5NmJ3UEh5Ujh0QVp0WTk5d3hBbG5zNXNqVFZGMUJNcFNoV0JteXU0WCtw?=
 =?utf-8?B?UXNtcFRWL2R0VmRBUTBoL3hwVEVtQUZ6UzdWWmdlVGVjUU5iR0FieFVVWDBI?=
 =?utf-8?B?L2tZeVJPOHE3elNqODU1UXh1UHlkaHhhUTM5OGRlcytHdDFyc2Y2ZnQzQnli?=
 =?utf-8?B?L0xjR0J3Wk5MaDVhZytOL3dKZlh0Nnd4aGJCUFU1WXc2cU5mdENJOStRS29U?=
 =?utf-8?B?cXdVZG1rMEg0UkM5MkFNdXpXSjN6bTZjaFF3WEs4MDlyc1BWakVNVXBxb0FW?=
 =?utf-8?B?TmloZHZhdktMZ2lNU0ZXcmJweDFVMkZwRUttWEI2dkVPbFpXa1o3MXM1V0hL?=
 =?utf-8?B?ZWp0eFdvaWlBSEhJamlaMkl2SHZLcGVDbm5ONmhQdjF5eVBBVngxU2FmSHJR?=
 =?utf-8?B?eDZoU0V2WHpxdGhxeVcvQW9BY2swZklTWi92U0RZaWcxeTFTeEtreDRvTTAz?=
 =?utf-8?B?Zmk4SGc3L1lWVVhXWmd4WlJQNEtkZTU0MkJsUlZkMlo1RmUvYnJRcUhNQjdB?=
 =?utf-8?B?ajE2c3oxM3lTVWJ2N05NTlRzNzRXQkxWeGtsclhCRGRrRG4wVEUrSm9Da3pM?=
 =?utf-8?B?c2hRNnM1eWZvTUNPS3dMVVM3NjJBd1lCdnRTWitZSWhVM2RmdXE1RjMxQnRs?=
 =?utf-8?B?bTdKSjhZb2JRM2VKZDFJNHMydmZINzBPenhFejhpdUlyWmJEeUlYSnIwWXhI?=
 =?utf-8?B?MjcySnc5a1EyeVdoOHBSRGFOMStqOGVyYk9LR1RRTFFhMEl0SjVFMEkxOVVZ?=
 =?utf-8?B?QzNQVnV1bjcvWjI2bFZGWTF6NnkyRjF5Q2xJNHcvUUppYlZpNEtDdWpGVVAr?=
 =?utf-8?B?ckRGQS9lK0RHaVNVaHIrL0s3V0xRekJaYjZCWnhJRU83YnJSUHJUUSswMzky?=
 =?utf-8?B?NURNOWpFMDBFeWZYR1dzNk1WaFdjc2ZHOUxQbTlLVTZTTU9ONGQ0TDZvMHVy?=
 =?utf-8?B?cEIzaVR3bEQwUU9uVGRqNVdGUGJ3M0NiY1RlendXQlZJVHhOeHpielUrcitw?=
 =?utf-8?B?UHh0NjE5cU82blVqRUx1VkpZaGpsU0dOekoxYW96VFJJdHREVnlqRDRrc1Fp?=
 =?utf-8?B?cG13cWV6OGNBUUZzVWUzM1VKQ0k1RHpON0o0RTdXdVQ0bFgzYWVIR2FncnRP?=
 =?utf-8?B?ZjRPNlpQQmVRYnFWT1pvd0kyWTloWUdhcXpqMjk4U0ZZdENuTFRNRlRXbXVR?=
 =?utf-8?B?WURRK21lOHpkdVFyLzlMU0E1T0Y0V2dxaDN4VHNRKy9reGhWTHJjNDllb0hP?=
 =?utf-8?B?ZjFKanhIdXBMejZUSDFGckRTdnJaQzZOa1NtazZ5ODQ5cnNTVGVtZm1JckVp?=
 =?utf-8?B?S1JIUmMveVlnaGw3b3cwY3dPTjBQT0dsMGxFSDRkNTR5eGlDckkvek1rbkx0?=
 =?utf-8?Q?Z7EnyL2zXn1gd?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aVd5dHJHbXc1SVZFdTVZRkI2T0swODNuRlo5dXNIU2EvOE5zdFFHdVdkNzVz?=
 =?utf-8?B?WE1IZk1icHMxeXFuTm0xTTNid29Qa1g3bkNiVVZwS1RTeHo2ZjhmaFZRNWo2?=
 =?utf-8?B?ZGphVi9oTzlpNWNER3hMY0FBNFBRblZaSTh5M04vdFppc1hndTNnclkrNWI0?=
 =?utf-8?B?UGpvMHdnNEF5eVRBNjc5S0hBL1BrdCsxYmp0NnprTU45UjJFUk9tbk9rS0JI?=
 =?utf-8?B?cG1lS1UwN0dRYTdNUm1qRXNEL0ZlNE1JMlhCdnYxK0ZQazBWTms5cG4vVm9F?=
 =?utf-8?B?TjFna2RyQ0pCWWZqMEk2cFNySUk1c2hvM0FMUUdwWXkxeC9qaWxJMTh0U0Fu?=
 =?utf-8?B?Ynl6SGpqNUVwbFpKNlBuNThsbzdHRGsxR1lQSmJZSkVRVzQvKzFLUU9CS0t4?=
 =?utf-8?B?RkVFZ0ZtYnkrd1dtb0lLLzQraDYrak9pRU4wQ2ZjSXdzM21WZlNNeW1Ybjhu?=
 =?utf-8?B?ZVlQb1l4WHFmTC9tNC9iQm5BVlRrQmFoWHpuY1hYQ1B6Ti8wVytLVS9WY29Z?=
 =?utf-8?B?djJjMHRRK2FuRU5zcmFjUU1TSzB2TTNwK1djUmhuT3NxRjhUUStqYlA1ZVZq?=
 =?utf-8?B?UFNGQ3JMZlcwMk11TDZFcUJuOHNwTURCdTNoZG1wclRTc3hqQVdqUk9yMVBj?=
 =?utf-8?B?aGFmY2xvSldteS83MTFZWTdYYXlOK0JjWFNhZVV3aEZhZlgzVGRZMlNXTklM?=
 =?utf-8?B?S3lBNWt1end1dE9TZXFORG5WQ0UxN1Joa0hsVGI4NzJxRUZYVGt3RU9DUjBw?=
 =?utf-8?B?WG02TXdPNUQ0N0tWSHdtZTdZUnFjWmY4c053ZTZ3VzdFTFBEeUdzRzdFRkEr?=
 =?utf-8?B?b0hRMGtJVnRKUjNSVFJlUEJiTWc2cDhNOE50QUQ2elYvWkU5TWhWVnhKdjEx?=
 =?utf-8?B?SXlnd1J2TzVQMUNySFArRENoWVh2b3MzdVpiamUxVEtJWjB3Z1VDN3RoOFMy?=
 =?utf-8?B?V3N5WUpEMndpaXhQS295cW9Id1BRaW5mMVM5RGN3RWdYRFVLeDF6eXp4RnI1?=
 =?utf-8?B?ejhsZjNGV3lNZ2pRY2hpNlBxYVZFb2g1VWlhYllMVDd5eExiUHY4eHM2NzJq?=
 =?utf-8?B?bkdXZTlJRGlmMWxoNG5WRWlhcXVjMkU4YzJYVFdGYzZTVm5YdXBNSkdCNGkz?=
 =?utf-8?B?WXo2YVk1ZnBSL2J5MDhKTUg5YkNWQlJLa1p3U0hGZG12b0J1NVJQMUdhQkFP?=
 =?utf-8?B?QzRRS0RhaDMrWkZodDNnTWlBc1BDQnl6T0luTDVCTEtRazBRMXJnYXRhYXNZ?=
 =?utf-8?B?OVY2NW5XVDYzUjg5UE9YNWUvc3ZrSHA0Sk9zN3FiNW54bHRRSC95TWVvcW9y?=
 =?utf-8?B?YVdBK0JFdnJUYWRlSVh1TnlzU0poZUVJV1NqL25MS3ozYVVzejlGNXBVemhK?=
 =?utf-8?B?S0gwTVpUTHMvckZybnpuak1HZDh6LzlDek94aFdtQW0vRVFuZVoraC9ydld6?=
 =?utf-8?B?UjY0RnhGWmx5TkJPTmh5dE52ZWdqS3NMSjVnK0RZWWxKRHh6azA1YnltSmVT?=
 =?utf-8?B?TkxvSENvbDlUcTZNclZJdFNFTHBXN2Fqdkl5bmJGTG5GM0NDbVpaVW5HM0JU?=
 =?utf-8?B?TzNMVVlZa0pYcHZkT3JZdXhtc1JtYitPZXBjanFzMWJ2N2wxOHloSitDZENF?=
 =?utf-8?B?VVRueWovOW9pVjVQeGFWUnR1NXpOU0cwQWFjOE12VGY4QU0rSXdYN2grVmUx?=
 =?utf-8?B?c2JuSzF3UFJGTmRYVDR1REowTEtQcEVjQTV0Q1V2aXdLaTJhc1duSzVwYW5I?=
 =?utf-8?B?TkQyNFlmOUFVbGVWNHhvNnVQNzdldW9sS3EyV1U0dWVTd0lkOUNLVmNydkQ1?=
 =?utf-8?B?NVQ2ZlRpdVJ5SzJZMTcyaE5GeVd2OFNOZEVYUVMvdU5Kbk90NXZaY3VVZTVE?=
 =?utf-8?B?SWlqNzRLTW1PcmdTajBDckFRTjJhK0pFTDgyaW4zelhtbmlJUG5PMlRTVmpi?=
 =?utf-8?B?RnJkLzYwQ0ozRjJTaWNRR2c0Rm1SOFM3LzdNOU1rRXFqMEdZTVhWNzROaGJu?=
 =?utf-8?B?cjRLdVlSbHkxL2poMjF4NFRPeEpmeTZobUFmZHdtdkU2TzQrYkU5MHE2VDA2?=
 =?utf-8?B?c3NDRCsycmpkdXZmWkNMZGQ1VXRtQVdzL01uNlc4eG1VejU5UnZ5NFFpdk4w?=
 =?utf-8?Q?RDzvtrPW0pAaUkSFhEg7iNZ2z?=
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
	V3VcjyOJ3MpExwt3NZx9J7oVdu3+uctuisOQ1GNQn2cfIwXRAzLm8Sypk39/9xovEFij/Kbx8Bd+4qw71HWi7u4zH7prmEBbaZ3b/teWicryvSNly7HFj2K9wkYqLgLsPQ+PMWHGWz5M0fe6zPMDWXCApPAVUkhUWQghn0CpM3c1HefeHFR6/S6gtbkKwuxVJivuj+Iu8lpyO41wqj6IrfEvoTbQ8F/z9Pm3Sb0r3LRRdqnVVFhHC4jRARVvRnH5R1SrEzheJSknBBBolQvl2k5e7A1qv8yVSBnkj9dXz/pmJO2RhEnC1pOeq5l79QOgF9U4siU0L42OkS7F69ZUneubQJFszb2u/CCWn7za/coY18Kx/NWv646oz7R106vJoYU0HQmYcaIFQl5BAtHHvrBmmIqWhHLCZsx/a8+XvbLFLhziKOY4RaDkeoSSREltny8n99EQ3m07b6DFv5Y/UDj73qj7XSZbgoOoH3SKM+KSJwvqIbYH+gtcAqlPUwmQQRXZOQN/aIi58eq+KuFIazFRZwfQkEYwaM7NwBD2SuDJBaE8RTTakuPeCyoHqTKcbxOY82tsUfALmRBgjcl1U6OhrXZ8U8jVcHK7MRyX9YU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1323441-1fd3-4493-738a-08dc97544bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 09:25:48.6969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttBatAuMyroSL8mFImriYhDEFbFkwZ5cMcoTg9+8KoJN7odKCooDOpwVoygPcFn9naePqNal9W8F0X3OU+Z7+Yvxu+iY+q3s9lQWToRLzTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_05,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406280069
X-Proofpoint-GUID: hOhQ-9GJMfsPlUCuXFvbB9hRbtkRz88L
X-Proofpoint-ORIG-GUID: hOhQ-9GJMfsPlUCuXFvbB9hRbtkRz88L

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVucyBBeGJvZSA8YXhi
b2VAa2VybmVsLmRrPg0KPiBTZW50OiBGcmlkYXksIEp1bmUgMjgsIDIwMjQgMzo0MiBBTQ0KPiBU
bzogR3VsYW0gTW9oYW1lZCA8Z3VsYW0ubW9oYW1lZEBvcmFjbGUuY29tPg0KPiBDYzogbGludXgt
YmxvY2tAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiB5
dWt1YWkxQGh1YXdlaWNsb3VkLmNvbTsgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjYgZm9yLTYuMTEvYmxvY2tdIGxvb3A6IEZpeCBhIHJhY2Ug
YmV0d2VlbiBsb29wIGRldGFjaA0KPiBhbmQgbG9vcCBvcGVuDQo+IA0KPiBPbiA2LzI3LzI0IDI6
MTMgUE0sIEd1bGFtIE1vaGFtZWQgd3JvdGU6DQo+ID4gSGkgSmVucywNCj4gPg0KPiA+ICAgICAg
VGhpcyBwYXRjaCBpcyByZXZpZXdlZCBieSBDaGlyc3RvcGgsIGNhbiB5b3UgcGxlYXNlIHRha2Ug
YSBsb29rDQo+ID4gICAgICBhbmQgcHVsbCBpdCBpZiBpdCBpcyBnb29kIHRvIHlvdT8NCj4gDQo+
IEluIHRoZSBmdXR1cmUsIGlmIHlvdSBmaW5kIHNvbWV0aGluZyBub3QgYmVpbmcgYXBwbGllZCwg
ZG8gY2hlY2sgaWYgaXQgc3RpbGwNCj4gYXBwbGllcy4gQmVjYXVzZSBpdCBkaWQgbm90LCBJIGhh
ZCB0byBmaXggaXQgdXAgYnkgaGFuZC4NCj4gDQo+IC0tDQo+IEplbnMgQXhib2UNCg0KU3VyZSBK
ZW5zLiBUaGFuayB5b3UgdmVyeSBtdWNoLg0KDQpSZWdhcmRzLA0KR3VsYW0gTW9oYW1lZC4NCg0K
