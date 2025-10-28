Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4824A23
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611900; cv=fail; b=FNdee5t2715aX75LBFz8enFue/TxOM3plz6vTMRIGff0Ux0ZjG1WTLa9VSeXZ0brfa8UVmWR5VrAYxk6rcNGiZN77l3yI/Y8dwJD4uPkHicA98BDFYpb5MqC/O13cgV1mXIQpnZjsyooZmZKbFlMDWpGXcGlP+KZJ3RATgO525w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611900; c=relaxed/simple;
	bh=22X8kRcxS++R4wxRBOulf+fXY+BgKVkt/wbG7jLdQcs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Quwmxl1BFm9hAmXnk8W1rVmcGi36pDb97PgpSQehOOZvwL+4hip3WLZq2XW0OCOPGFxVQhNHrCGOjH5et3ogxGupewJ8fJpv09BYa6YLqp+EZv8uaaV2F4r/cCnlQZmRpy0Zx9T0WAHHcZw5x6ooF6my6AoeAPbdZuTqovBdLRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nBrxjogq; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nBrxjogq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNyZlTJxRAaB/9eUK/Kd2Fi7WJdjw/YF8r3Q8An6A6r4nsv0dIPUx62qMzAgUvcXViLOH7mCOLk/jVU9g102x3iZ4OvZmP6a6Ft6XwqydGhkHxUT0sl5Ii7HiJ/FHztF0XGhScwBMRMrkNWoqtdykPzhNJbeWtHh4vrZTomjxVCdngqx3hxWvJUFZLOtCiQry7xilNtxZMRHVRW1l3SUEYUi16+/3WFxC3LUTq4olGTgU7OAhJe6rjNKFbRR6Rghngm3WN9nCa8YkOigAgeYpQP6Y2k1Vu6PyQKApscRGQ/98Wy/c+iwIRzUaFYc1XYBCKvYXz6BRT0Q4/YS0coxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22X8kRcxS++R4wxRBOulf+fXY+BgKVkt/wbG7jLdQcs=;
 b=OzLEU2jgYz0ubb0nbQyy3X/RotrN2/eF1RxnLpGhRdNAehgXFdKin/qcbK/EwAgd4RRIWdpcdKnS3A29tyhuCMGKkfEN1ZRrtlUR/DAkkZbtNveqtpe/3L9o4jPxUSPIuWpN5YHanPp7YdYax8O9ivIqfqSLdVrndGirO5+RQEIDD4LRA8kPiCBJzYNiMZi2fRtbOsNZwvYWH4prEOvKU2TpgU1NXBQRAwvsDBEuyGyDuU1QYiMjHWFuTCi6mIMZtDWFeO8VrhxnaRpRpmsJ3j8W64xbCaZ4hJ/UBhY+1OqKoMghMMj1b9wvAa0IIz6P7eVuNAFrhpjV7MVlETHWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22X8kRcxS++R4wxRBOulf+fXY+BgKVkt/wbG7jLdQcs=;
 b=nBrxjogqJaqdEkAVfmDoSVxKO7AlqfWSXN+m8KEK2aIhb2yVMaZD5qmy+f5aTpQ1kmmms7Ii3aBgDileOESC2rTxI/BtWydJlCWJqierh6vIDvbMfsrpuwqZLNozRcestWNGgXaWHbpneQ0F+Wnk/JKUE+Zy9s+jvgnfs5yb9zOouYBaSFy5Acdl9j2+bggdUso+zL9A1ASO4/CCFS0ZYcGryITnrcqFhjZWaKsW87DFpik5lhrs1F2S5SSwbI1LcXRlqIASsNwPjqrffB2nD6j6RcxHYKkSF9c8ljljPZCs4Epagtd9Xju4jZf71esbCf7wQ/NWhhgCxgt06lshfw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Tue, 28 Oct
 2025 00:38:15 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 00:38:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: fix op_is_zone_mgmt() to handle
 REQ_OP_ZONE_RESET_ALL
Thread-Topic: [PATCH 1/2] block: fix op_is_zone_mgmt() to handle
 REQ_OP_ZONE_RESET_ALL
Thread-Index: AQHcRtkHFhh5VC2b9EiRJDHa68v7GbTWuJcA
Date: Tue, 28 Oct 2025 00:38:14 +0000
Message-ID: <4efb89c7-05a3-4c6e-ae4f-7ecf20c57d36@nvidia.com>
References: <20251027002733.567121-1-dlemoal@kernel.org>
 <20251027002733.567121-2-dlemoal@kernel.org>
In-Reply-To: <20251027002733.567121-2-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN2PR12MB4271:EE_
x-ms-office365-filtering-correlation-id: e06e7e25-1c6c-423d-c82e-08de15ba480a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1pZTkFwYzFJMEMycm5SbU02UXFja1NwSTBTazhncTUyc3dZcVNGZVFaczJH?=
 =?utf-8?B?NmlGT0NIdExKZHFPQnhTL2tkb2J1Rzc5VklwT1lNdkQwalh6TDVKTkRES05D?=
 =?utf-8?B?QkZDNVVuTEZ1UDFBeS9WdmhnR3NsREMrY0pLREl1QWN0anhZOWd4RzdDMEpU?=
 =?utf-8?B?L1ZXV0lNaWYyTGhkNnpBeEg3SmdMK2FjVWovVFFNTFZvKzBQTXM0djNsK2Fq?=
 =?utf-8?B?WGFrbzRVTDVjUk9xaGRVRG5OeFArM2FPak40SU1sb0Fsd3o2dDEzbWtvL2xD?=
 =?utf-8?B?ZS9neXVUWjFSb2ZBSTZpUWRjYXFsOWNGZWNrV2lnMHJ6RmFOSVhzRzhwV2lZ?=
 =?utf-8?B?MU8yNnZnQ0g0djlGWHUrVnh3cFBlNDZkMTEzYXFiVTltVkJxOERmZ3ZuTnNP?=
 =?utf-8?B?UkJDTEhqRmlwYW9jeklDc0NGWDdZOTNodVBsUzR3L1hZcStsaEZOZHRNVUpm?=
 =?utf-8?B?cEJYU0plSlZwT0JyWEhRaEE4Q2wwclBVNTBiazBmV3JKVUlHancwTldPWDRZ?=
 =?utf-8?B?eHUreWdWNHI0bmQzQkpaQmNGVmU0bFNMMTRBRG9iY2xFQllhZzM2NFIwQ0tR?=
 =?utf-8?B?d0JoeithemdpbEFodTZsM3U0SjQzSGZOQ1o0a1M5MXR4emdoWDRhd2paN25o?=
 =?utf-8?B?bThBZVFwKy9lNGZoaGwvSCtJazhlTGFCWlFlVnRYSzNHdDhQbXB5NE1NR1E3?=
 =?utf-8?B?ZTIzR1VyMm9WN295TTVsRG1uYjRneW5xanhIbm1qVVNTYlVhaVFRMVNxNVNI?=
 =?utf-8?B?MllFUlc3UndwWmt3ckhDc2RPeGttNmd2bEkwWUxaRDlpSFBsZXNEUHE3QWtQ?=
 =?utf-8?B?R0k1eWpXSGROSGV6N3JUZ2FlSng3M1hQYkxqZzUzd1FEOFhDbHhzVWp1TFF1?=
 =?utf-8?B?eGMyU1N4NS84a0p1eTNpb0NmcXpXOE5SNnA5WXRxaW0wUElWb2VDL2lMZzU3?=
 =?utf-8?B?L0tuRjdTZ2h1bHZwTmVMZnZKRnZiN1NIUWs0WFcxWnVmOHRGNnYxZXJ2Y2lK?=
 =?utf-8?B?bDdmMnhxWjVhZ1A4ckdOWkpWa3NQM3JrRmZ4eTYxSk5oYU5rMzJ0bnZGMk5Z?=
 =?utf-8?B?MiszV0NtL1NQREdaUVg1dWI0SmZuakFLS0FCZW5GdFFqUGNyMS8raERIV2Ey?=
 =?utf-8?B?K0VKSEVFVjB6czRIS3Z3RmE1dHdabkNOMGMzRlliSVh3RzRSWnhpQ3pyOCta?=
 =?utf-8?B?YXJKMCtWcVd2eTYxYXZKc0ZMWE44S3dUZEtIMkw5NFBDUnA1OWxqWXlCTW9G?=
 =?utf-8?B?N3EyTUM0eUkrTmc4UWR5Y2tsU3E5U1dCam1jK0E1T2tDRWdnY1k0Nlo5U0N1?=
 =?utf-8?B?NzVhKy9MYWxBY3U4WE96OThGUE1LZmNtR1VnNnYvTC9uZFhONUZNY29aYUkx?=
 =?utf-8?B?Lzhtb1pTNHhZY2t2RWZ6cEFMMXkyYlVpRVJhQTdqMGxmdkpkVUtaL1VFSG91?=
 =?utf-8?B?MVFQOGxnc1loaWFVQUQ1bk5JZVZDand4VTFCbEl5TjREYVBtWUpweUYza0Ey?=
 =?utf-8?B?bGFvRjJITHRzNU1NU3AzSnZmcUcyM0gveGJoSG82R0d0d1NjbFp4SkUrcEt5?=
 =?utf-8?B?eHVZNFVYOWRTQVNyT3BkaEc4UVFMU21tT2dweWJnRzkwMnl4cENXVzRpZ2Q0?=
 =?utf-8?B?RENIU3BpQWxuN1N5UW5sSUZjZm5zbnZwczFDd0lJYnBqdmYzcDd6dEUvRGpw?=
 =?utf-8?B?UzI1aGo1RlVXS0NNMVl5eVE1OW5SeFliNmRwdUJQMkxHVzFmZFpERjFRYXBE?=
 =?utf-8?B?a21VanF2Z2doTjFGeVBaRm1CSGJqcUNwNzEvUUQ4QVorZTNTWFZxZi96REY1?=
 =?utf-8?B?R3R2d0IyMGpTMG8xK1RaWE9EdEsyQWZqN0t3c05CT2g3WDdSckthOWsrSDF6?=
 =?utf-8?B?NExEY1hmZUhmRXE2MXA3Sm5JSWxOTG9rTVF3c1VleTZsQytyQnZ5Qnc2MDJz?=
 =?utf-8?B?WFpycVVvR2ZmUEg4RFF2anA3VG8yNTVtSVl1bFppOEJ5eUlMUXVLd3JDc0s0?=
 =?utf-8?B?ekRMbmJiaVFFN2ZNVHlqQThQL0xCUzBtT0lHbnliMUVzaTB0aTN4WGxKdjFY?=
 =?utf-8?Q?baPqj4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWxGUUNzR296M0I2d1B3OVdoR3R3bGxtZ3A2aHExUWtzR2tMK2psNVpXU3Av?=
 =?utf-8?B?MWRpQitnMGhiWHdFaUhlR0FTSlNtN0hSN2krZ1BiZGNnSFRsVHVWNkxmelF3?=
 =?utf-8?B?Tnlkblo1OWdCSWo0K3I5dzBWYVF6SXJ5RVpTNFcrSmdwOXBoSGtodXNXc2sz?=
 =?utf-8?B?Y2FtSDRQajMxekRpYmRBcUkxcVNCV294eWV4RHlYRzFCSGtrUkxoYWpPZUFk?=
 =?utf-8?B?L3dFR1NaYWdqT0hEbHVETGNkK0I4RmNxSmhTUlNtaTQ4MWkwOU5WekRSamJj?=
 =?utf-8?B?b05MK0VPTkJjK3lDUm4rMlZUdjFYTTZ4Q2FhWHRZLzNwNmFkcTBmQ3lJOWNp?=
 =?utf-8?B?bGJMcG0rTGpEV3F4a3pwWURRdTBoUEcrYU5wd2JKOTRITW9mWm5oV1UwVXlL?=
 =?utf-8?B?QnFveHRZYUxGa1FJVXhnb2V1T3FjakMzcHBpZm55YnA0Szc3TU5PSkR2MmM0?=
 =?utf-8?B?ODVlNDI1USs3OWpsSUxBcXdYKzNNU3dmdEt4bnhjTTF5S0p5OFp3RkpJNkY4?=
 =?utf-8?B?WXZGL0tGQ0IzTlovQzZhYk1ZZ2puS0N0T0dhcWJsSlNmZ3BDMDVlYVg1MER6?=
 =?utf-8?B?SkVzU29jTzFEY0RHRUVoa2hRNGs2TXkzSUNpZ242UjJmTU1nOE9VT2hsTjdJ?=
 =?utf-8?B?cXlBSVM2SkRLNmpjV25YeXV0K0UyRlpTcjZSd1hoVjZiZmRJSU1BbDBYQlRD?=
 =?utf-8?B?ZnNqZ2FHdWF5MWJ6MGJpSlZhZkdJU3cvcFJ2djdaamdwR0N0R3RKMkVSQ3lm?=
 =?utf-8?B?ZGZVQVB2eGFHaFliUGJobHRMdVl0RjNXOFd2YU84SlREOGFycUdOdGQ1ZmFG?=
 =?utf-8?B?bXZ2eFNwUUJwdHRzN05rL1NiekYrc2NTT2FrUWZTRWFtZUFOOFB6Vld1K3Mx?=
 =?utf-8?B?RStmVEcyS2hXbThsZDhSRjMxaEpnU3FNUkZSQnNqMGdaUzltU2hwc3RERHBt?=
 =?utf-8?B?WExZMlQyM0NnY20vM0xrZFdPRjlrYTIxN0dxbmFNbHA3bEg5RElGU2E5YlRy?=
 =?utf-8?B?blBUYUtHajY4blhhOEZMZFpUOXcyWUNuanF0ZjVXZkpVZjhqRklsQzNzYllw?=
 =?utf-8?B?ekZscFYrckJ1QnZZVHNONVI1Z3BUdEVZVCtXSmlKVzJ2YnFwaHl6c2IyUGJC?=
 =?utf-8?B?d2NCanlwRnVoUmNIdUkwNGxubGlEc3RQa2hpVFFzQ3VsQXRDZXlzZEFDb245?=
 =?utf-8?B?WEs4N2JJNzk0anJTeXZQb1c3TUZJWGduWWdLZlFDRThuRTg2bmJVbmFIUXc2?=
 =?utf-8?B?cm1peEltcXRrSlFiYXJLQktySFlvMi82WTQveVd3RFZOczU5bWorNDNrTGtV?=
 =?utf-8?B?L3oydkNxTXlXZmd0YmVGY3QxNlU4MTBEQk9aN1A3VTZxbnJPT1VNWnhmS2lK?=
 =?utf-8?B?UjZBTFZGdEllTTIvSnZZbDVoZGMwcnpqV0cxSkFlRFgvaVJjN2UvKzRjd21H?=
 =?utf-8?B?VzJsVm14ZHp0TnpGZWkra0V1ZERvY0FRQ29IQlJ4WWNYaGNyV0tPZjhsR3Bt?=
 =?utf-8?B?VVZISDZqR3ZIeGtkS2tLVXFKazFTdTR3K3NNcUF1MmR2ZjhHaGtKTXUvQkxh?=
 =?utf-8?B?MjB2VDlqci9EamYxd1ZsenB4QlJSK1BiUDQybGxXMXFwamZuVFd0MXpRK2hE?=
 =?utf-8?B?b3NDbXdWeEx1WFlhclZiNkZwNGtUcFllNVBFcHkwN3RBdHFaQU1XZnpySnpD?=
 =?utf-8?B?U3dFQkl6NzFoMGVSQmJXTklsSXQ1Y01UOFIyL0hSSVJZMUJWSHdUYWFoUTZL?=
 =?utf-8?B?c1NSR3NsMnQzNmY3WCt4NmNkbHU0aVk4dk5mZjhTZm9jSXF6V01HdXVEbUpZ?=
 =?utf-8?B?RVpGY3RZU04xODBuUnd1N00wOXZzdUxIN1NuS2o0Zld1REVHOFFWYmxQQVRl?=
 =?utf-8?B?ZDY3VHltZkVvbjBYck41V3kxbjNvSkxvajZoT3RHeVh1Q0xyd01XNSsveEUz?=
 =?utf-8?B?SURLVEVoSFlYZ0s4dDRpRFpLMTNCU1h5NTgyTk1MdFdLZzI4a0t3eGFpRmp3?=
 =?utf-8?B?K0EveCtRQXRBb1JHTmFCUFBoakUyWllmc1VnWGdGV2xpbW9QR1diTnAzRzho?=
 =?utf-8?B?eCtMSGloM2paT0laZzVLYTJTMTcwWU9zQzRjdTBwVk5hem4zNXpFMXVsOHRF?=
 =?utf-8?B?UUdmTW1wMkZCdGI3WVRheWo0TmpQQy8ydE1ud2xxOE1ETnM5djNSamovc2Vh?=
 =?utf-8?Q?uk9mMEyez19rTr+9BfRayQ6ExlXDLSjilMMJuJT3HZ4X?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36E3FBB25D95D84FAC231D0B4FAE984D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06e7e25-1c6c-423d-c82e-08de15ba480a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 00:38:14.9631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qMkIdMGExEodybX/F5Qv1bbphbOi4VNIhond+v6kl0UXGUUCP/j+HnggbUo6OkJ1vkIyZBgeJ3f7cOrPfmi/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271

T24gMTAvMjYvMjUgMTc6MjcsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBSRVFfT1BfWk9ORV9S
RVNFVF9BTEwgaXMgYSB6b25lIG1hbmFnZW1lbnQgcmVxdWVzdC4gRml4DQo+IG9wX2lzX3pvbmVf
bWdtdCgpIHRvIHJldHVybiB0cnVlIGZvciB0aGF0IG9wZXJhdGlvbiwgbGlrZSBpdCBhbHJlYWR5
DQo+IGRvZXMgZm9yIFJFUV9PUF9aT05FX1JFU0VULg0KPg0KPiBXaGlsZSBubyBwcm9ibGVtcyB3
ZXJlIHJlcG9ydGVkIHdpdGhvdXQgdGhpcyBmaXgsIHRoaXMgY2hhbmdlIGFsbG93cw0KPiBzdHJl
bmd0aGVuaW5nIGNoZWNrcyBpbiB2YXJpb3VzIGJsb2NrIGRldmljZSBkcml2ZXJzIChzY3NpIHNk
LA0KPiB2aXJ0aW9ibGssIERNKSB3aGVyZSBvcF9pc196b25lX21nbXQoKSBpcyB1c2VkIHRvIHZl
cmlmeSB0aGF0IGEgem9uZQ0KPiBtYW5hZ2VtZW50IGNvbW1hbmQgaXMgbm90IGJlaW5nIGlzc3Vl
ZCB0byBhIHJlZ3VsYXIgYmxvY2sgZGV2aWNlLg0KPg0KPiBGaXhlczogNmMxYjFkYTU4ZjhjICgi
YmxvY2s6IGFkZCB6b25lIG9wZW4sIGNsb3NlIGFuZCBmaW5pc2ggb3BlcmF0aW9ucyIpDQo+IENj
OnN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogRGFtaWVuIExlIE1vYWw8
ZGxlbW9hbEBrZXJuZWwub3JnPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
