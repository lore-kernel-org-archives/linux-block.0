Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9E1078B
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719458894; cv=fail; b=jNpcSI/Jip4SmoMzUyC9kKh0WcWhwXt91r7s8bYh82pj6bfXGDYmX8vdBhxIZ+WI2a8NvNg9F/+WQKyt+kBl0yHFxuubfpAmlNTr+oxlJ8iL94xNMbw6AHSkBjA+tZQwoVr8N9JVouCHIvxMg8DnQy6r39OQ2nV3fGkyFzIhqTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719458894; c=relaxed/simple;
	bh=dKH7hxJWHzPA6ZOcdE2DMUK5vEXBGR9tNp0P+NjWUhs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IoxitSOB11Ra824ZSpBhrlWS/lnj9kPqehE67EavaVrimiLS7mxFIFQ20XRLKi7luXjw3svKJOCtfU4tfzWSBg4gdgTvjwNyvVTfpGvOO5X+llntcjR/CD5EKPXn4UXKLhvH0chrajLoQNx9V0UeCu3mAVyFZMli1oDBWGaUtPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kIjjZ/Dg; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kIjjZ/Dg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhRo4eZb2yrKgdA0dd/wOouQH6O6qIjYOtygcpBogVd3UnbFm8wZ+BUjt6ofVkP8YZuXSkUaAvDp0atInH5TZMJd5MfIx8P23VgDLzCswiaspl91wdJu6nnUcSHabJldv4P4vSokAGzOdG/zSvAOCeF1fEhGmxEmdPeIvTG7mspbL5V7nJehX8j+/F67h7W57Yi9bSgj/Lop8V8EfMPWrjHtNRMZzIJmtETqHEDszSrAwK1XsmkeuoKyBDjXHFFPhhmbM03MeY5Qqlj9Simxp3R0rr2geLzzgZV5qJx323EuAXC6YUP2i/AOU9D1DbkCz39Cc69e7gVRcqAbgrGXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKH7hxJWHzPA6ZOcdE2DMUK5vEXBGR9tNp0P+NjWUhs=;
 b=fs5fMwR+UWHDk1KGz7yxnqEXErIMn3W3P9Z6EiyEgNw0KEg9OJFy8v0ZYS9+z0Shz26TvBKkWWWibJf9URXcClXRdY+bYCsU78TJuOL1Xe3o2KMIlEMYkvyj6D6UBmqFTBtx23LaprgMSQLvRQPsWffcLQuAhADFid+m/XCRJHTB57FA5lICKxgt6dtNbv/RWn3XPWPYxHKWMDSKGpQp9bKo1LygaEf0hq20HBcmsH9+685V9EIcKzZopFyn3v6CZv2OEy9R5qgQ3j59828rkMMveKh4tdugqhApqm+rp+zlJgBSF+exwjVKFz86R7dD+yqCAfgyJYF3NzEsb/pB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKH7hxJWHzPA6ZOcdE2DMUK5vEXBGR9tNp0P+NjWUhs=;
 b=kIjjZ/DgO0CunaaYtfM1H4Q6o36sVXDp2qMuOVzfB/KRAVi1lo5UzJ/vgXYulCLJm0ckatFFiJ9MnpxkEdFw17SwF3Fvqc4cZ8ZZk5wWUih23nFZR9A9+L1bHqYSbTZUHVZkt+20haomnwxH4qq3S/yowNXanL+Uu1mVRRtvprP1gkNfmlFcb/Z8VqKiEO/fcpwlZ6dl28C8Ep4WUhwljqYYEYso2p/qQARhXO3LC9iuzdQEt70XQKvo8hS3wYjQzuqC0/6O5Z/trp/ICO+108PJQIAjxYzPnmH1RhgxcqhZUqEdLmGrMXRbZxvGzyLPLNTvDqeViKVtVtZxAZ4jZA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.33; Thu, 27 Jun
 2024 03:28:09 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 03:28:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Gulam Mohamed <gulam.mohamed@oracle.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2] loop/010: do not assume /dev/loop0
Thread-Topic: [PATCH blktests v2] loop/010: do not assume /dev/loop0
Thread-Index: AQHaxvGr1eV0hMYF8kiTBDKKW5DVdbHa9iyA
Date: Thu, 27 Jun 2024 03:28:09 +0000
Message-ID: <9d4de12a-d546-4335-9145-b18fa1f4e64a@nvidia.com>
References: <20240625112011.409282-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240625112011.409282-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB8916:EE_
x-ms-office365-filtering-correlation-id: 4ecfaf59-d4e4-4c1d-6038-08dc96592aed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWdDOXhwN2I2M3NKQk13U3FDZnhtVm9JUzFnand0WmlZd3p6Tng5SWhoVVEw?=
 =?utf-8?B?MkQ3eE10S280a0tMMU1SSzBlLzkyOENOQm9URnZpb3NyMmZsdGRySEVzVkZB?=
 =?utf-8?B?RTdUeExpVjdJUmVtNGdHckg0dTAvZWgrTlBpZjBmT3BJQjl5cmRBaE1UTjZ5?=
 =?utf-8?B?UnljRW9HdlRiUXYyVTVROTNQQndneWhrR2I4TytCa1h1WEJZUEs0VENFekJX?=
 =?utf-8?B?WWI1amJjL3dkbU9xUkpCTDBmajU2eFRBU2lmU0hqMGt3amQ2THhtZzNleTVB?=
 =?utf-8?B?YlgvaWJZSTNqYkVkZlRpK0tvVHZ4UVlsSUxweFN0QmNvTFdjNGl4TTBNRmNZ?=
 =?utf-8?B?S1pwbnJZeGt1cHlkOGZHMnd4QjBtdGV0SVNSWS9RenZOeTV1bmYxWUlYbVUx?=
 =?utf-8?B?OVVhcUszQ0grQ25hUDh0ZnlyYzByQlZkRVVnSTAzcmpRTHVJaHRGV0dGdUdw?=
 =?utf-8?B?bEE4RVl1M0tFSVFITWRlY2FLSEZXclhqbUE3eUxXSHZHZk5IazhQd3NpUTNh?=
 =?utf-8?B?Q2doaWdnWXJIYVUxNDBhZGg4dlFySjVmeVg1eHJUcjdkaFYxUkk2c3h5S3RO?=
 =?utf-8?B?VzhPU251a3BpK0xsUjVRRVc1OXRUTENQZ29wbDlYWE1YK0l3aWorcjEvbWNw?=
 =?utf-8?B?KzBxNmRGdHF3L1VENXFBMlJYUVBlOG5hZGo2T1J3emlPblBCQmZXb1JuWmxG?=
 =?utf-8?B?UkdaVUErMXhWM0ROdzZqYTBydWpWSE1xWTQvbXFxRlFsUWEreUtIa2dHbDdo?=
 =?utf-8?B?bjNZSng1M2lJMTNLZ0Mwd05UaCtZOHZlV3F3Tk1FaTh5MFdHY0lveHY5eXJZ?=
 =?utf-8?B?Ynk0eGtUV201TGFxa0xaRjMvSjFMTDB3TjB5NWpGdXZoaUFPY3lOOUs0SnU5?=
 =?utf-8?B?bWsrSlRuL0FqdGdtVnl5ZnQ3VHB6ZTR3TW9WOUgwTU51WXRIc1hmQWdLQkhy?=
 =?utf-8?B?V1QzNlBoRHU5VUlxYWxHdEZ0a3RZUkJtWTVnUHpJR2JNWmhVaDhhMlFsZ205?=
 =?utf-8?B?UllkWHVPV2VGd3ovTFVvMGdwYVM0dFhXTmVEcWdUaUI1ajVHemNldnl3Z2RI?=
 =?utf-8?B?NUMzVCsrQWpTaUh1a2pnNmQwVUxweFlnNFFoTVdHT1M2czFheGZiZlQ0QTRx?=
 =?utf-8?B?SUxscHl6QjR1MHZhSWd2dGNuVjNqSkJ6eW9PMGRUZnBDM3IwWk1YWWRocSty?=
 =?utf-8?B?cDMyS0pXcHNDTFUySzB3OGZSSU9SZUdJNExaSEZRd2d1KzFhUklhbnFjWGRS?=
 =?utf-8?B?Ym8xdmtJVU1BbkhkWU8rcWNzZkJkL2w2M0taOUdEVlY4dGxmVlMzeEljT0ha?=
 =?utf-8?B?TU5ZM1lpZFdrSUQrdkVBWmZ0THJucUV0U29MRndEM25ZVVVnbEhjc1NNUllW?=
 =?utf-8?B?akVLNS9OVHlvZUhMemhONFlzb3ZEclg1SkVHS2RtUWJCcVM1UlRzZkIyK1Mz?=
 =?utf-8?B?M0k2YWRUMEJ0TkxUMDBSSnoybUNTSFBTTitHc25Wd3JCeDVWMW92UlcwcWtL?=
 =?utf-8?B?ckdKTXhnTGxQT3JoZ21BWjNvajRySEFqREhGTnc5Q3h4MzhkZVhNZGl6eXRk?=
 =?utf-8?B?T0F2WUtUakQ3TnhLaFVBTDQ2MDNXd1A0SU5SbUhQWXhlWld4eGJFTVNobWNG?=
 =?utf-8?B?QWRBSG5uR2RlRXNBek9HZEhncW15Sno4Mm5KbHNBaXkzVmtFa2tWVUE5NGtT?=
 =?utf-8?B?S3hmeVpSeFFiM0QvenRrZTZaM3I3RjFFRWlzU3M0bVlkeXViTjM1VTJjR1hx?=
 =?utf-8?B?NndVSyttQi9xVVd2TUlFODBjYjVneDZWMUdPWFlic0I2Wit2NzhZWnFDZi9E?=
 =?utf-8?B?TXUxaENPYnFjZmx3RGY5b0RlbFQyR1hCV3JISEo1allmMm9VdkpSSFV2TmRX?=
 =?utf-8?B?aUxXUTZGRzlqSmdXVHNLZ25wNDh5QWprOHE3bzRQSUlTNkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3ptR1FSN0NXSEgzODJ1UUk0V05meWdQQnlTQXByVEpwKzQyVmVvZDZPdUVP?=
 =?utf-8?B?RDRiRjk1TXlvWDM2TzdiZjRpSGlvM05FNjRJNEdqUTBnb3BRRXkvRVlMVXRO?=
 =?utf-8?B?M2IwaWpkUXFQMktWQi8xRG5xTHRxblVUcUhFRXgyQ3RjMUY1eXdiMnVkVGp3?=
 =?utf-8?B?dS96eXBmbzNJQ2lkeXFLVEdJTWVSWFQrSU00ZWhzK0M3TGN2MnFuUTNnSVNP?=
 =?utf-8?B?TlJNTkFuTUM5Z0JRK2JxSnZXM1F6NElyVDk2andYRktlL1FhVzRDMEd2M2Yr?=
 =?utf-8?B?OG5vckg4ZDFsSG1VOXVQRzRTaTlwZ2x5UlMxSzc4bEkwS2czaFdzMXJ1eE9s?=
 =?utf-8?B?UnJ1cW5RMTRES1VPb2VRSkVjQ3RtNE4vdVUxa1FYNzZYMXlaWXlKVHVqZ1Nu?=
 =?utf-8?B?cmJqblVJVkZEVld0eWI4cDdLMUhvd2RnMHZHS1RUVHFKeUhRamhqdkZjRWtZ?=
 =?utf-8?B?S2FYZXFuWmtRNi9Ubmt1N3pYZ0hjYlB3T3dqUUhLQTM5eC9vYXpLbDdWaUFL?=
 =?utf-8?B?TVBWRmRmc2M1WTJtR0pRcUNodzAvUkc1ZzNkWkJ1YVQ5MEd2SGNTODFoSy84?=
 =?utf-8?B?UENMT2JOekVsV0NnUDJGOCtOUFpKRlJIRXZCR0tmTGpTSmV6QUEwSS96VnVH?=
 =?utf-8?B?ZHRTUytCSUFNOSt3UGY2YlVPSDZhYnRWcmZMK3k4S0YxenJOYVNPSUNONFYz?=
 =?utf-8?B?enhWd3VLU0hiYkZ3bGFaUWZFSEFnN2NTVGxIYmNtRTl0bHNhNTRMMnk5WE5M?=
 =?utf-8?B?STdjL0h0RE81NVZjcUlLQnFJZzdkS2lweXVuMkEzMnVSem5CMHp1N3NxUm82?=
 =?utf-8?B?MjFOQnRkWHJKdWpnRmZ4N1Z2aTFjcmZja3ZnaFdoMXAwbUxXc1ZoM3p4WE1Q?=
 =?utf-8?B?VVBzVENqYXNFT2lNbEorZVlPUld1TlNnY1VjdFdrbmpzVEVyRE5nYWVsVDlv?=
 =?utf-8?B?YStmQnZ5b2l5cjdEcXJ0QS96TVZqZFlZbnNvTG9GZ0F3UVlEUWtlaUk1TkdO?=
 =?utf-8?B?MEJ4cXVYMlpDZHRkR2RNaUs5Ym56NWJ3QzlzajRsVzZFTmx1N2lzdmFpZDA5?=
 =?utf-8?B?dlVJZ2Y0NHhRaDhZcjNTTHZIemVaTER4bEE0V2gxZnF1Y25rZTFjeFVaREJi?=
 =?utf-8?B?MDl1WlhxMi8wY0cwZ2g0TXl2ZEFVTk1wS09LZVhhQjVmWmdkMjY4MnlmdThs?=
 =?utf-8?B?R2k1MW1IUGh4YllVSm5YVllHeW9zaE4xR2NLdEFETU9EdEJ3SXQwYUU4YnlE?=
 =?utf-8?B?SjcycnZFdmxMZklITmcwTFlBeU9Zd3B6LzQwSWZ3ZnJlRnArRHI2aEQ1WWZO?=
 =?utf-8?B?VUZDYUFJQzJxenV1WW56MUR2ZG5WQ25UUERPZUdudUJFdVM4NlRHSTJYekpJ?=
 =?utf-8?B?TmcvTHkxZlo2bEwrSkkrZXV2L1RVTDZJYnZBb0pFUldBRTlSd0p4VTFhazND?=
 =?utf-8?B?eXRDMHhiNGk1RkN0S3hjck0vajlxZitjRU1PVjVtTXJGc2NGd0dKWXROUjFn?=
 =?utf-8?B?ZXNCY3ZKeU45MkY4WG5zdlJveFdQSFJXRjQ1MU8zTFZ3bHhvRWQ5dWtxckVy?=
 =?utf-8?B?ZGY0eVM5NnB5OThrWGVQUGpTUVJKVnRwcmIxSDB2dGZPNy9QRUdDT1A0Y3JU?=
 =?utf-8?B?eDFUSXNDY3BzWHlsWDBvbFRkK1U0bkRuNVJHNEh2UFF4S0NZbmVibzNzOCtN?=
 =?utf-8?B?SEdadXN1NVRrbUo0ak5DMWRQVWtrNVVsZ1pXNnNscUVISVhGYnVrbkNOa3N6?=
 =?utf-8?B?bVphSWJjV0FSMWhnN2VxT3RHcXNQeHlkVjNPV01WMDVJbTZzZk9qRXpxYTNX?=
 =?utf-8?B?TE0yNi9OTzZONk9XUFI0SkhtOHdaTWQwRERvVkl0RHl5NytjK2pQV3cyelBh?=
 =?utf-8?B?N1lqUitxbWEwdlNVd2QwL0ZhZUtRcVBrZkxlV3Bvb2ZMemZHd2MwOFl1QmJs?=
 =?utf-8?B?cHBzdHNFd3NJMk1SelhEeWJZT1dXdGZKYWpEc0lmYXVvZFQ3VzV5OGZtYVdG?=
 =?utf-8?B?cHQycEN5MXdYMUVuN0dDandzTkR3VUZ3QllrUDZ4WU05VUlkeWpCRHEyUjda?=
 =?utf-8?B?MmR3dzNiaFl6eDhrV1hERjhvOTJMZ0RjQzlTMjVsS3dmcXR1NlhVWmdwVlRF?=
 =?utf-8?Q?wKTPQvgyXvzuG+xLzSfsPPATB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6AD1D0F5C1FAD4F94B4BDE2F1A2ECDB@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecfaf59-d4e4-4c1d-6038-08dc96592aed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 03:28:09.5593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WBdMwCe+X5RSpGA+GzRJucgajClPpwoGTfFrmF+BewozgEBfXJW50YMAdXhtbC1gWrPJB+jfVAQKNzREFnn6Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916

T24gNi8yNS8yNCAwNDoyMCwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFRoZSBjdXJy
ZW50IGltcGxlbWVudGF0aW9uIG9mIHRoZSB0ZXN0IGNhc2UgbG9vcC8wMTAgYXNzdW1lcyB0aGF0
IHRoZQ0KPiBwcmVwYXJlZCBsb29wIGRldmljZSBpcyAvZGV2L2xvb3AwLCB3aGljaCBpcyBub3Qg
YWx3YXlzIHRydWUuIFdoZW4gb3RoZXINCj4gbG9vcCBkZXZpY2VzIGFyZSBzZXQgdXAgYmVmb3Jl
IHRoZSB0ZXN0IGNhc2UgcnVuLCB0aGUgYXNzdW1wdGlvbiBpcw0KPiB3cm9uZyBhbmQgdGhlIHRl
c3QgY2FzZSBmYWlscy4NCj4NCj4gVG8gYXZvaWQgdGhlIGZhaWx1cmUsIHVzZSB0aGUgcHJlcGFy
ZWQgbG9vcCBkZXZpY2UgbmFtZSBzdG9yZWQgaW4NCj4gJGxvb3BfZGV2aWNlIGluc3RlYWQgb2Yg
L2Rldi9sb29wMC4gQWRqdXN0IHRoZSBncmVwIHN0cmluZyB0byBtZWV0IHRoZQ0KPiBkZXZpY2Ug
bmFtZS4gQWxzbyB1c2UgImxvc2V0dXAgLS1kZXRhY2giIGluc3RlYWQgb2YNCj4gImxvc2V0dXAg
LS1kZXRhY2gtYWxsIiB0byBub3QgZGV0YWNoIHRoZSBsb29wIGRldmljZXMgd2hpY2ggZXhpc3Rl
ZA0KPiBiZWZvcmUgdGhlIHRlc3QgY2FzZSBydW5zLg0KPg0KPiBGaXhlczogMWM0YWU0ZmVkOWI0
ICgibG9vcDogRGV0ZWN0IGEgcmFjZSBjb25kaXRpb24gYmV0d2VlbiBsb29wIGRldGFjaCBhbmQg
b3BlbiIpDQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpPHNoaW5pY2hpcm8u
a2F3YXNha2lAd2RjLmNvbT4NCj4gLS0tDQoNCkkndmUgc2VudCBhIHNpbWlsYXIgdGVzdCB3aXRo
IGhhcmQtY29kZWQgRFVULCBhbHdheXMgZW5kcyB1cCBpbiB0cm91YmxlLg0KSSdsbCBrZWVwIGlu
IG1pbmQgZnJvbSBuZXh0IHRpbWUgd2hlbiByZXZpZXdpbmcgdGhlIHRlc3RzLg0KDQpMb29rcyBn
b29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cg0KLWNrDQoNCg0K
