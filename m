Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE918C034
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915901; cv=fail; b=p7JpIjKo69Qy4TFdvwI/U/nei7yt5cUhhBNkMGazetOj2g9z6UGm70oah/S/bkctDpzZ1EsScpMXubPtJYjYFF++Vs/BCCsPm0okxi4ZCS2H8QTt401R7rvpkNObWwzoCiyzuHCThmMf4fcMGRoImb7g8eTAa+xVUiN0cOZIeGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915901; c=relaxed/simple;
	bh=jqDPkJXMV9JJbxoQyIKbHf6l7F6imzgb+Lq2V4o+SGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zy9y7FQVw4i7HxJf1jYogBzHWv67ft3h1psk5KEDYRQWNsNCZyfoKDK2fxpLke0ACGkJkaLE18tBoUsr8L3exM/WO+Rm6w/uQqCyHDlz/TdLnNYedCU/2IXtH6pdqgabrFf+m6DyNAg3InnKYZUVxNhcyRnzAtSy4khCR549uZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b+n7zDmO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hg0ya5AH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b+n7zDmO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hg0ya5AH"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGMqC5004754;
	Thu, 17 Apr 2025 18:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jqDPkJXMV9JJbxoQyIKbHf6l7F6imzgb+Lq2V4o+SGc=; b=
	b+n7zDmO76qP0E+VwHnwq8ug/OaTIE4lreXRXkub5Obc7SqeRLI3pVX4TB/HT26+
	pzoJDlc30cyOktE2dmr1WgZXgYnyT0oZCSuuZBmUIh73Zjz8GRgqb7br+/qnb/cz
	6ji6f6rbZFhaJcit263bOOUrpnDzuxEQOfc2sk89oRDcbyhybxD4gHn+ZxJzPR9V
	lFhieFWpkBviO0V1M1isgEPcXgO9eaW/0ubZlCgTTv/uMrmmyCGSvKje2TmbQ8mu
	dIh6c+EqqiCNA8FLAigHUTabHFnzvOexPmjVCSp3wC/YtL4ZDMM2J3x9w6TpglKy
	IOJSL37cqa5ljOf2pcnRXQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46185my0tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 18:51:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HHZFUZ024658;
	Thu, 17 Apr 2025 18:51:32 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d53wmhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 18:51:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HonC3R3suaHeY8pz0+sg+DvcwEDGf4ihv7ExogIBT0iExvXOGZbNQVxkKlJvYlrcFEZWPYtADvJTHBeGA5fC0rZv+27WimvxlmurmligR3i6/251frBjFZeBuf6Hc0XQ2WxQjg68Br6R3QE4PhRaRs6fn1hRzhe4TOyG5v0oOFzSe4LQf+LbA+qI9o2H+qIT6Zz8q3bQ6FMIeieg4Q57FWlI6QXrDzrSojGDVU9T7IOAtJWaIBuung2LUCcQ40dBiFt1ZyfDDH+Dq8m6py/dzos893+ma3ijn8n9KVlRHbs7ZSnvZ9p6FFQ3Of0pQFIUlMNt4su3tUL3O6vkEdXSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqDPkJXMV9JJbxoQyIKbHf6l7F6imzgb+Lq2V4o+SGc=;
 b=dLpT2jO291N0qEgc21Wn5SMbup4gu5+urtE8QOgm5qCf9mpm0b1b2X6C+oPJLfAee4mcNZUadv+GA26T4cYaBm8S4ud7/FJjIitb7qGC36sxBvOn8GEKkrTmXKeQDFfg7gR69rxHdTt7zIDdLWEknvCwOAbkVPztHlULNt9BQpy1hCWkmK6rQYQOpHU111qJjQdEiyDdGBS7icy8FPYfhYZd0ZB+kHpHG1CAFAGmhoCD3FqxuCIPdq85V7gCEm0KH4Nq6lyrTq+l4HV9Q5O7VitM2MHRZuHbeSTD/IJtiXuApEaIrUByFGrqkr7RJQLmbv9iO2GjWQczU7PiU4QB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqDPkJXMV9JJbxoQyIKbHf6l7F6imzgb+Lq2V4o+SGc=;
 b=Hg0ya5AHbm/c3w0I3sC6kWltTPM9xXUsZlDqObl9+LAFu6Sh7R4gy55xLZMyM7GSrVMogq5zdm/3r1krG/NGl50Zm7a1zWQBWFCCGeGUcKuyVPf+GxffJn9/S1vl0Y/v7XfwPJ8olJUc4gA3MMAqgy6ayim39LAP568Rp2o80Pc=
Received: from SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:233::19)
 by SA1PR10MB5784.namprd10.prod.outlook.com (2603:10b6:806:22a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 18:51:29 +0000
Received: from SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::e454:8efc:f281:44d0]) by SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::e454:8efc:f281:44d0%5]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 18:51:29 +0000
From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe
	<axboe@kernel.dk>, "arnd@arndb.de" <arnd@arndb.de>,
        "ojeda@kernel.org"
	<ojeda@kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        Martin Petersen
	<martin.petersen@oracle.com>
Subject: Re: [PATCH 1/1] block: prevent calls to should_fail_bio() optimized
 by gcc
Thread-Topic: [PATCH 1/1] block: prevent calls to should_fail_bio() optimized
 by gcc
Thread-Index: AQHbr7Yk6q+TTl/mDUWE5i2yevsSqbOoJFKAgAAPqQA=
Date: Thu, 17 Apr 2025 18:51:29 +0000
Message-ID: <F2079CEC-6B87-4766-8F77-39672D65B2DE@oracle.com>
References: <20250417163432.1336124-1-prasad.singamsetty@oracle.com>
 <CANiq72k-i-hDCWgfqu2OZU=FGKe3MJh5FxnnpGx1Jz866tXY6Q@mail.gmail.com>
In-Reply-To:
 <CANiq72k-i-hDCWgfqu2OZU=FGKe3MJh5FxnnpGx1Jz866tXY6Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.500.181.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB5867:EE_|SA1PR10MB5784:EE_
x-ms-office365-filtering-correlation-id: c81ce2db-67f2-47aa-89f1-08dd7de0dd0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZzZiLzN5ZkhkWHVpUitPTzdmT3B0Ui9ZUldwa2szVDh6RXdNV3F3UldOSUJp?=
 =?utf-8?B?eEJ2aThEVW1xenNRZzI0S0lQK3FJUzQwbHlWeXlHK1BOZDlXaWEzWHMyTHdm?=
 =?utf-8?B?MzNVRnNIL2pGTXlOdHNZTEh3cDhob2lQeTRnWDFGcURrK296Qys4dEgya2pX?=
 =?utf-8?B?WXQ0UTl3Yzh0UnROMHAvY0ZkYTZxTVVobFNzTklTQkFYK29nRUlUdWg3dmRy?=
 =?utf-8?B?TWNweTJWbHVoWWRlNTlkczg1QlZDbFl0V0RVSExwb2N6RHRvTW5OdFdGMG5L?=
 =?utf-8?B?Tmd6aHE0cVBpTXJyWTc4cG1KeFcvQmNRRTUyY084QWRZckx6SE1Eampob3do?=
 =?utf-8?B?cms4QXl6SVJjMGF5RERQNlJzMXIvY2VmZi85WkNUbTdVMzRFMlhoWEowSHhC?=
 =?utf-8?B?TFNvYkZjSHpOQ1MrWmpySUUwME0xVzRZYit5VThRQWFXd1IvQ1U1T0pnQ3g4?=
 =?utf-8?B?NmpLMmRrSXhuWnJRUWFxeDdmUHVueTJxUkNFcG5xMVI4SnpWK1BWNVV3YWlH?=
 =?utf-8?B?eFBMK0Vqc0RuU09HY2ZKcjhKcTZHNUFCSHBWckRpeUZlQ2Uydk5KREpjL0xx?=
 =?utf-8?B?RUVqWGkxRmg3c0l4bE1vczlETitqUW00VXFqYjlKeEhJdWcrb0xycW9HRlEz?=
 =?utf-8?B?S091VjNxVGMwM3pwakk1clNydVZlWG9FT0w5T0VuTUYrbGlMMFhSZDAyYnpl?=
 =?utf-8?B?RGZlSlpVdUR6VHExNnJRTUVucGxtZUFBV3JhNEFLTVA4WDkzWkFKbzFPOTBt?=
 =?utf-8?B?d256SEdIbDhNb2g0VjUwT1lDUlBOdmpsRGRGblB3ckh6czl5VWJWeHZlc3pC?=
 =?utf-8?B?QlpkMGtuWjJFampYNmJNZDdzOW1GQmUxcFFZK3ZxZldJQStnUWo5Q3JncEdr?=
 =?utf-8?B?VzV1cFNEK1pSbHRWLys3b0lJV3NvcS9YNGs2OWxKNTJHMXZ2VEZVTFhpU0NF?=
 =?utf-8?B?YzQ1OGFKSlNWT1RKYWZNSGI0eFUvN2Y2M01RRVExM251M0d3VXcrQmgzS3Z3?=
 =?utf-8?B?dVYvdnN3RDI1MEVXaEhCaUIyeHRmeHRXZ1AvbzRlaVBRSm4vdlZLTStWbWRZ?=
 =?utf-8?B?OC9rdVU1ckswWjU3ZFJyYkh4L1d4RjFGbU5iNjIyaDB4aEpGbVlWNm9MZjZs?=
 =?utf-8?B?dGZ5U1JMdmgxRFkvMGdweFREMFFZcmZaZUlQSWVmOUdFeHROUzN6dUZKcllH?=
 =?utf-8?B?Qnp1d3lUVEhHY0hra3JNR1k3Q2doMllnaGkyM2hBQS9kaUFKSGI3dWFZUW04?=
 =?utf-8?B?QXI1TFdSUzY4aitvcjl5TjczYWxCSWhDTm01cXBzTnpmcG00NXQvTFZUYTVS?=
 =?utf-8?B?VUJ5bFlLWEFOTnVvZkJtL3VkTHBCN055WVhhRC9OUVlxVW1wK25GM1o1Q1Ru?=
 =?utf-8?B?YXBtcVNvdzlxei9iajJBTjJnUWx5aXpGTWl5b1RsS0ZCYStsaVU4VHY0aXMw?=
 =?utf-8?B?L2hGR1JiWjVCUjQ1RU4zUG9hUWxmcmRvY2xoY2NOb2ZXSExDNEUvdDUzNVlN?=
 =?utf-8?B?MnMwZVNLRHAvcjQwajBaNHRZYXRLbFY5U2FKRHN4L1hodlZtU0F0cUFXZWhy?=
 =?utf-8?B?RzQ0YmRDWkpOR0Y1Q3c2OWFNNUVSN056a2pRbi9lUk9DcjMzUGwxeE9HVzlh?=
 =?utf-8?B?MmZOWm5ZYXZ2clBiWnEvY3F6aWN3dVovVlhyN2ZjaHM0NmVabVE2a3Y2QkE0?=
 =?utf-8?B?Q2VkU3ZqRGJhaENqK2FtTG9RL2wrYWd1TmQ2bzJzSjJRR2t1ZWZ0K2Y3RE1n?=
 =?utf-8?B?U0VQRnNFY1N5dHZNaExKK0cvWFhJd0E4WG9qR1BkVHVHZlE0a201U3ROK0RV?=
 =?utf-8?B?VkJXcXZUSDh6Ulhtc1VKYUZ6SFJxbnR2Qit6ZnJZNm50ZkdmSkd0eTdwSmEx?=
 =?utf-8?B?cHRZOXlnQlBKTWFoNG90QkpNUUt3Y2J6UlBKMTJOVlhtdE5QMGZ0N3ZRc1Bu?=
 =?utf-8?B?YTZrUXJMaXZ3RFBoZXpUUnRiRWdHMlZlT0ZsQ1QwT3hwVWJqNzQ4M2FtVFN3?=
 =?utf-8?B?K2l2dUY4dTRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5867.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0JkMzdudWN2Ni82YXJHbk9Xcmp2U0ZCTkE5L1N6TFVnOW9FbGFCSExYbDFz?=
 =?utf-8?B?R0NENWlwY2dKZjRtd2dHam05MnVQbVhDMTVibEJyNUpjSVcvY0pSYUpxYlQx?=
 =?utf-8?B?c2xwMURjQXlPUURIUndiMm9udC9HMzI3VVVlUFVEZzVHcS9BVTVtZEdQWXBj?=
 =?utf-8?B?K1ppRFpkTllNSk91d0RLZUlhZnlWVUxXNml5SzZkQ3oyUmVKVE81ZEVzVnZw?=
 =?utf-8?B?NE13TDBCcWMrTm1qVGJPcm1nUnNydzBQbzBhWVEwUDRwS0FseDU5TXYzZmVv?=
 =?utf-8?B?NitOOHVrOFQwdzl3U3ROTDgvU0xnL3UvRUY3cVQrMnU3ZXo2MXJWQklObE8r?=
 =?utf-8?B?YVJ2S2IxMUdrQm5xYkszQVV5UjluUmlLNmRKOWJwN0kzTG9lZHNNVk50dDQw?=
 =?utf-8?B?QWwzbit3OWNJcWFIOGNwVlZpcjVhRzJOYXhabkJtbFRQUVYzQWY0bnBWQUJL?=
 =?utf-8?B?MFNzSnhnc3pJVXYrVm5OUVZUTytBV1hSTTdXc0NZd3pLcW4rU1J6QkZ4NE82?=
 =?utf-8?B?U3pvQmNFcnRwTm9GbWJnTnhCei9HaWVmYkphNVRsTGl2UzM4cEwrSHYyYUpF?=
 =?utf-8?B?akt3dHBjRVhQZmlDWk5vcisweTRDamkyd2FyZzBLTCtGRjFQZEIxWDdxZW9Q?=
 =?utf-8?B?THF3MmJtd2k5eDZYNUV5enU0MTVZVHptTVMwaWVCeTZydXZ4bEwxY1ZzaWRH?=
 =?utf-8?B?Ylh3MStXZTU1VEsvVEVrQm00VGpzaVVndCsrWEo0d21RcVlEWFZzaTlYTWZO?=
 =?utf-8?B?SVZsUWN1a3lBQVdNLzVzeXhnbEcwRlpKMk5ta1VHWkRCdGo3N2loSWVOZVVB?=
 =?utf-8?B?SkxENkZDcmhTM2VuOEhyemdIQW16Z1BRQ0xsMWliZE9aMXJXdWFHbFVNL1Ro?=
 =?utf-8?B?YWkyZExsSFUxeDhQc3JtZXdxRk1JajU2bHhhaVBIM2VrZWx5YllucDlDbkdt?=
 =?utf-8?B?dzdQMlBiQWFPMlNDaEovMHJLMHdTclRTRVJ5ZHdHaDZtSjBDVnp2NFYzZWhi?=
 =?utf-8?B?bjFpSGQyUDFUdkM1YUg5QlhTMFVWRGwvTm9hMjVmSUZTSG1UR0FuL05aRXJu?=
 =?utf-8?B?VXErUDEvaHlxUWRwRHk1U0pKbVd1TkNTTGVsbXUxb1hFeEVOR2lyeXR5VDUr?=
 =?utf-8?B?SUxZSkN4VEV1YnF1VEJhZFE1TTUrMTBUMytLZlhxWWlXQkFhT2dVQURXM2xS?=
 =?utf-8?B?U3prVnlvOGxiNE5JVTgrMzJqbU1rT3ZFYlE4d3Y1TjVNeHJVMnVMOGd1dVY1?=
 =?utf-8?B?aytyanVxM2lwcy9JcGFtUllxUlJ2QnUzRWhSSmtwSEZGeC9aMGs0T3J1clFi?=
 =?utf-8?B?alp4VmxLbG4waUtZSStyVlZzMUJIb3U3OFJZakFkRGRUdVo3cEFXdGJRRngw?=
 =?utf-8?B?WTBvTGRYbTZVZGZmcHphdmg5bG9CMTYrRkxTUE9MbEQxQWZJd0VjMWdpK0ln?=
 =?utf-8?B?enlzSzQ4bE5TS3dIK1dkMGcyS2wzQldVUTlzakdKN1Y3Zno0dndtM3h4cGlM?=
 =?utf-8?B?dFE2QWMyWGlheXcvVU1aby85RTlwcWZoalY5Z2tqaHgvT2tpM21yM01QSXBX?=
 =?utf-8?B?TFduTWl5dGxZMisvMVJJZCtDbUlVSXdUQnFEMWhJYUVPbXpZcTZ4WkNISHJY?=
 =?utf-8?B?WHRUSTZoMmdlSitoS2UwdmJiZ1B5L2JkWUlQR04yRnFZempoR1R2ZmJHQVJq?=
 =?utf-8?B?cDBZL2M4RmpLcE4xR1VtRlFkVHQ3TDdPWGR4YWZKZWdXUTY5alRKWFZiZllt?=
 =?utf-8?B?K0dBT3BsZmdNOGtnekFTRHpBeUNUcHc1ZXZrSnltWUtSdFB6QVRNWEs2V3Za?=
 =?utf-8?B?YmVyVzRDTDZaT1E1cEM2UHFOYUNjbFlKRVlXKzZWM1ovYXNnQXRjeEF5M1Nl?=
 =?utf-8?B?bzV5bnNRUHAzYzBNREo4WU9URUI0L2NGODZVNDhqOWhTcEpwUnlxOW5iQjY1?=
 =?utf-8?B?MUEvdG8zMHFrZDkrb3YwSDRZeU5Uczc3V2NwS0V1MHkrajZQQWFpalRsek5N?=
 =?utf-8?B?bDdxTXNpV2VBQWRuUHh6ajZzK3NYYkdQMXZyVVRXR2laTU5hSTdJSWxFZHQz?=
 =?utf-8?B?Ly94L3hKZytlbURtOFFKODhmUmlIUEpRL05icGJwT3JOd20zZGYxQ1ZNcmRM?=
 =?utf-8?B?ZkU3NmxOcUJSRFp0ZU1aZEpnVWxBM2sxaGlFcG5PTVFMeFZkS0pGZ2NqMlFE?=
 =?utf-8?Q?XUgC0Klj+6KO/27/L09/1pI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5F5B869836A904E97852CEF78220283@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K8OaSFX+59sDyNofhCn8ID98wEftLh8rjo3819yQrwZtUWACnmesNA8ewqgrepVmHdM1FrgAUIxaxPxIBvN4dbUx8bFyAgLbnKLmEgBkVVxgt0F4D5Y9M/zvT7RPUd7BvekH8mQBfKrr4bVSpzyGiMLjCwujRRLGTYi+o3a5BURBlSKLbUwRNIuRcpc4gyPqqWawzOjs7VE159mK90kVo5v6foHqM9ryhY4j+bxCiO14nMjFV3RiM4beW+27o90IxuxLiixqksiZhTVldVfPlTK2uu77ELcCQaQNlZCSJ7sPi1rOR+/he/b2ju3gQX9DS5BptYBOdwsIdgkjD8khWTaeG0L15rOSmf1DtFxuH0Vk52qfOV3FEt6UWOqr+Xvc8JlqTYD49DkRl0jOmWFgUUtPFo1MLv6NWrmw3AQREw1o/z8IvXAoSYV3y0omH6Bcjzz0NEvrL4ZawKuM+IaGYeAjt2zfJ/KrdPSCZdWZL1SHPUCwEykpLc9o1IdHxtweo048Q7kYMkZ21fdgGTErnTSzzwhb0BULwxjqnTmJ3EYWpxwCY0QFympV1F4b9PCTufW2c5og/8YRdRXZ+Q5p9Fmw02RUD2Sm2j1k7fxLpwk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5867.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81ce2db-67f2-47aa-89f1-08dd7de0dd0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 18:51:29.0956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2rSzORMZogWrgBOu9AeyCKi32l857+T6rXe3ASPXucsikvcqBj+3Dj9ru2oTTVTntiS4ZFU2xy6NadIhsiAIDXNRSOn++f6kpRgXSy84rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170138
X-Proofpoint-ORIG-GUID: _bPD0CzL__xfL1CgfzASYYGX1OaxpCJu
X-Proofpoint-GUID: _bPD0CzL__xfL1CgfzASYYGX1OaxpCJu

DQoNCj4gT24gQXByIDE3LCAyMDI1LCBhdCAxMDo1NeKAr0FNLCBNaWd1ZWwgT2plZGEgPG1pZ3Vl
bC5vamVkYS5zYW5kb25pc0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBBcHIgMTcs
IDIwMjUgYXQgNjozMeKAr1BNIFByYXNhZCBTaW5nYW1zZXR0eQ0KPiA8cHJhc2FkLnNpbmdhbXNl
dHR5QG9yYWNsZS5jb20+IHdyb3RlOg0KPj4gDQo+PiBXaGVuIENPTkZJR19GQUlMX01BS0VfUkVR
VUVTVCBpcyBub3QgZW5hYmxlZCwgZ2NjIG1heSBvcHRpbWl6ZSBvdXQNCj4+IGNhbGxzIHRvIHNo
b3VsZF9mYWlsX2JpbygpIGJlY2F1c2UgdGhlIGNvbnRlbnQgb2Ygc2hvdWxkX2ZhaWxfYmlvKCkN
Cj4+IGlzIGVtcHR5IHJldHVybmluZyBhbHdheXMgJ2ZhbHNlJy4gVGhlIGdjYyBjb21waWxlciB0
aGVuIGRldGVjdHMNCj4gDQo+IGBzaG91bGRfZmFpbF9yZXF1ZXN0YCBpcyB0aGUgb25lIHRoYXQg
cmV0dXJucyBgZmFsc2VgLCBubz8gaS5lLg0KPiBgc2hvdWxkX2ZhaWxfYmlvYCBpcyB0aGUgb25l
IHRoYXQgZ2V0cyBvcHRpbWl6ZWQgZHVlIHRvIHRoYXQgdG8gcmV0dXJuDQo+IGAwYC4NCj4gDQoN
ClRoYXQgaXMgY29ycmVjdC4gIEkgd2lsbCB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIHRleHQu
DQoNCj4+IFRoaXMgaXNzdWUgaXMgc2VlbiB3aXRoIGdjYyBjb21waWxlciB2ZXJzaW9uIDE0LiBQ
cmV2aW91cyB2ZXJzaW9ucw0KPj4gb2YgZ2NjIGNvbXBpbGVyIChjaGVja2VkIDksIDExLCAxMiwg
MTMpIGRvbid0IGhhdmUgdGhpcyBvcHRpbWl6YXRpb24uDQo+IA0KPiBJIHdvbmRlciBpZiB3aGF0
ZXZlciBjaGFuZ2VkIGNvdWxkIGJlIG1ha2luZyBvdGhlciB0aGluZ3MgZmFpbC4NCj4gDQo+IEFu
eXdheSwgZ2l2ZW4gd2hhdCBKZW5zIHNhaWQsIHRoaXMgbWF5IG5vdCBiZSBuZWVkZWQgdG8gYmVn
aW4gd2l0aC4NCj4gDQo+IEJ1dCBpZiBpdCBpcywgdGhlbiBhcyBmYXIgYXMgSSByZWNhbGwsIHdl
IHRyeSB0byBhdm9pZCB0aGF0IGtpbmQgb2YNCj4gImRvbid0IG9wdGltaXplIiBhdHRyaWJ1dGUg
KHRoZSBvbmUgeW91IHVzZWQgZm9yIENsYW5nKS4gU28gaXQgd291bGQNCj4gYmUgbmljZSB0byBm
aW5kIG90aGVyIHdheXMgdG8gZG8gaXQuDQoNClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24u
DQoNCj4gDQo+IEZvciBpbnN0YW5jZSwgaWYgd2hhdCB5b3UgbmVlZCBpcyB0byBrZWVwIHRoZSBh
Y3R1YWwgY2FsbHMgdG8NCj4gYHNob3VsZF9mYWlsX2Jpb2AgKG5vdCBgc2hvdWxkX2ZhaWxfcmVx
dWVzdGApLCB0aGVuIGFkZGluZyBhIHNpZGUNCj4gZWZmZWN0IGxpa2UgdGhlIEdDQyBtYW51YWwg
c3VnZ2VzdHMgaW4gdGhlIGBub2lubGluZWAgYXR0cmlidXRlIHNlZW1zDQo+IGFsc28gdG8gd29y
ayBmcm9tIGEgcXVpY2sgdGVzdDoNCj4gDQo+ICAgIEV2ZW4gaWYgYSBmdW5jdGlvbiBpcyBkZWNs
YXJlZCB3aXRoIHRoZSBub2lubGluZSBhdHRyaWJ1dGUsIHRoZXJlDQo+IGFyZSBvcHRpbWl6YXRp
b25zIG90aGVyIHRoYW4gaW5saW5pbmcgdGhhdCBjYW4gY2F1c2UgY2FsbHMgdG8gYmUNCj4gb3B0
aW1pemVkIGF3YXkgaWYgaXQgZG9lcyBub3QgaGF2ZSBzaWRlIGVmZmVjdHMsIGFsdGhvdWdoIHRo
ZSBmdW5jdGlvbg0KPiBjYWxsIGlzIGxpdmUuIFRvIGtlZXAgc3VjaCBjYWxscyBmcm9tIGJlaW5n
IG9wdGltaXplZCBhd2F5LCBwdXQgYXNtDQo+ICgiIik7IGluIHRoZSBjYWxsZWQgZnVuY3Rpb24s
IHRvIHNlcnZlIGFzIGEgc3BlY2lhbCBzaWRlIGVmZmVjdC4NCg0KVGhhbmtzIGZvciB0aGUgY2xh
cmlmaWNhdGlvbnMuIFRoZSBhc20o4oCc4oCdKSBvcHRpb24gYWxzbyB3b3JrcyBhbmQgd2Ugd2ls
bA0KdXNlIHRoYXQgb3B0aW9uIHRvIGZpeCB0aGUgaXNzdWUgYXMgdGhhdCBpcyBhIHByZWZlcnJl
ZCBtZXRob2QuDQoNCj4gDQo+IEFuZCBpZiB5b3UgYWxzbyBuZWVkIHRvIGtlZXAgdGhlIGZ1bmN0
aW9uIG5hbWUgZW1pdHRlZCBhcy1pcywgdGhlbg0KPiBgX191c2VkYCBpcyBhbHNvIG5lZWRlZCBp
biBHQ0MsIGJ1dCB0aGF0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gYWRkDQo+IGFueXdheSBpZiB0aGVz
ZSBmdW5jdGlvbnMgd2VyZSBleHBlY3RlZCB0byBiZSB0aGVyZS4gR2l2ZW4gd2hhdCBKZW5zDQo+
IHNhaWQsIEkgaW1hZ2luZSB0aGF0IGlzIHdoeSB0aGV5IGFyZW4ndCBhbm5vdGF0ZWQgbGlrZSB0
aGF0IGFscmVhZHkuDQoNCkN1cnJlbnRseSBHQ0MgaXMga2VlcGluZyB0aGUgZnVuY3Rpb24gZXZl
biB0aG91Z2ggdGhlIGNhbGwgaXMgb3B0aW1pemVkIG91dC4NCkkgd2lsbCB1cGRhdGUgdGhlIHBh
dGNoIHRvIHVzZSBhc20o4oCc4oCdKSBvcHRpb24gYW5kIHJlc2VuZCBpdCBmb3IgcmV2aWV3Lg0K
DQpUaGFua3MsDQrigJRQcmFzYWQNCg0KPiANCj4gSSBob3BlIHRoYXQgaGVscHMuDQo+IA0KPiBD
aGVlcnMsDQo+IE1pZ3VlbA0KDQo=
