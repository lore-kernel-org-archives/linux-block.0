Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CAD27057F
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359141; cv=fail; b=QfNBukDOfexH74/gLl3VxOikRTz8R/9jwQriSbSAGetH/W5KV1NfcK54c++ABEjdwFTWoSN/Av/gkSuY20QlCi4KTznuykmsL31twSWIqrzm6nD2aMF6bjYpYeAzvs1A1JDX+e/mU9+2hPg+Gwmv579LVDDphlgHoKxwBx7MDMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359141; c=relaxed/simple;
	bh=9RSk04MYZ00mWtS5jj2TQ2ccAuViqCN+FLHkV96LWp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X/eWr0CbRVjJtQVDc3zgHwoGdGr/L+H6pwDJVvKe/87AFW0wiczuIh8rHF4nS2dYs+vyLkE25i/ttoQVy7owSAlWIqPpMdpJxEHa7olB7w4gk0CeUsrHpjidSSg5X/qyrlUCKz4xQI7Dt0orm4HO6ILM3hqG+5RuwjVHsyeVY30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pp6BId6Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k7nZheB+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pp6BId6Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k7nZheB+"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MLO3oa019148;
	Tue, 22 Apr 2025 21:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9RSk04MYZ00mWtS5jj2TQ2ccAuViqCN+FLHkV96LWp8=; b=
	Pp6BId6YlE+1Xhs0MXllavpnlL3jVQ+TtCPBFoj2axTzUMo1tZ+QVExvr1hG9oji
	4ohBjUkECYSVeibPiceDlgKJH3U5VHFsAqOPYIynhtWPctA97cAtS6LqZGfj6HYb
	I8A8s6iHSPxwWCwlJtZe7NYVnBrXvLH5GGadzSoF8+Ob51f16nEvoJM0cyyKwQDY
	+0uJ8UmwVop/HmGKmd1oDxwqcqq9IY79tyCJ4Jwd8h0CUVFJHdrSnPOTsF5FL0Qr
	EvARSqSXeP7ycG+TuAUWWUSj5ARsPHWVWmldtOjE2mdYY/T2l6xdvMtl7/S+9FWJ
	O/oTIFqJsm9TNh9wi/9OXw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha03j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 21:58:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MLNmhj031172;
	Tue, 22 Apr 2025 21:58:50 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011027.outbound.protection.outlook.com [40.93.12.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k050xdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 21:58:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W68i8E5CRXd65i0xlYyBkplFPTA5omdSOPR6LmYtBCmSkJMoPiZufa0Fhz4GUEkt9k0VhePa2ZdVnHFpickAM50Ep31Ojf2vMX5tlXRHS++byN9oUcn31rh7Io+NYbcX+jUNgoIjc3LdeGqRvrHLLko+YQTp3C7T81ExZ9gfIdpWzW+9IMFvsRzJtkuiufxTZh+5/tK80tbvjC4aaXtVVLhYga/MWhq2oxA0EARAdx4fmPJMLlsf2DUe+st8vh1BU0MQcnuet24s7zCkq72kIbmsZBc5CFcaOPH3+w2gsjXc+xLWHG96esa7lmE2YNAtXGrbJmIbfaCcoSM7puLmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RSk04MYZ00mWtS5jj2TQ2ccAuViqCN+FLHkV96LWp8=;
 b=EwFPC28hVbA8gkp/0C+9bVtrSrE/eva8CnjFRbQxlg6I9IpJFST72XtuMdwmdzwhbMEPAqJEw/q+LsSviGlSl3GvkevfLQj5mQqEpIjvnmxbuEJztT6LkDd/Nfc2iNyt/zede78J/YXslDwbvo6ysp5Z2NXok+f1FCeOEojCWLwK/3OG0dUznBDekmKEpkfdckr5OsBakDTOEiaWaRuguLIRgdviKIw/tGAd01KMq9Foo6cnmv9a54DUHmx0LdUmOjzBOwYIQVXD1tfWqV68X5+ay6O5yL2ADZhpTfNUJdYtMPZl6cELkm5yG2cgLNGkQOJWa7NXCBXxCe052c9tsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RSk04MYZ00mWtS5jj2TQ2ccAuViqCN+FLHkV96LWp8=;
 b=k7nZheB+s3qv+qGkWiJF94h/hWBKGTJTJhdFYvYbBDNniXI5AagxE77zd63zpm1awyFiasJay2K848GG1HlYxqRcakKTq9y81Z4uIgrGl8mT9C1xCPxC4Pk01ci6qG1KUJxzdwjvsyaDWDRtwsgmC9RfbnYSlzm9wZNU/Etbeuo=
Received: from SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:233::19)
 by IA4PR10MB8496.namprd10.prod.outlook.com (2603:10b6:208:561::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.46; Tue, 22 Apr
 2025 21:58:34 +0000
Received: from SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::e454:8efc:f281:44d0]) by SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::e454:8efc:f281:44d0%5]) with mapi id 15.20.8632.035; Tue, 22 Apr 2025
 21:58:34 +0000
From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
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
Thread-Index: AQHbr7Yk6q+TTl/mDUWE5i2yevsSqbOuCAsAgAI724A=
Date: Tue, 22 Apr 2025 21:58:34 +0000
Message-ID: <91C42F53-51CB-4529-9139-3CF4AA2DD935@oracle.com>
References: <20250417163432.1336124-1-prasad.singamsetty@oracle.com>
 <aAYxSOxeM-mQgNyF@infradead.org>
In-Reply-To: <aAYxSOxeM-mQgNyF@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.500.181.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB5867:EE_|IA4PR10MB8496:EE_
x-ms-office365-filtering-correlation-id: 35d79965-6166-4b1f-f86d-08dd81e8d3d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bG03aU1hU1pMSXpFTHN5WnIrKy9WaTYvVFI3eXN2NXpyZXhsNS90NG1lQlhQ?=
 =?utf-8?B?UFJ5RG9Ib1l3eDZBRWdjbXpNQ0M4c0Z3RkRkMmgrcjN1TmVQWjUvdjIyV3FV?=
 =?utf-8?B?a1FXMTBYT3ZhclMvT1lkakNoN0llTEdTVS9GU0RXb2U2Qm9qd3l5OGRNMEh4?=
 =?utf-8?B?VkhCWlpNcDd5RDBJVnRLWjZjWGU4VXkyMlk2QVM2MWFnK3c0STlZM1d3R2Vq?=
 =?utf-8?B?RjZ4bkdlREMrQ1dZUmhnYmdyUUp3aGN3RVFhdlNxR0Z2L0ZBSDREcERGNFVW?=
 =?utf-8?B?eGlSTjFhUnZwTTBzTUhVNGUwNjhZbVF0UmcyWGpHMjQxc05TUkUwZXJablNt?=
 =?utf-8?B?TkR5Y2FITHN1UGt4SmhuSVgrSVBHRi9xTnpTd1R0RHl2cFg2emtWVlRVQ2tF?=
 =?utf-8?B?aVd1aERucS9VYVkvMHlMWWZVRXkzMlJxMTVDV2I5UC9nZUM3MlpldGh3TDdT?=
 =?utf-8?B?NmVQZEFQaEFxZldxcVRaRnRwTVJZbVd4aWtmZHREZFc0N1RTVWZPWGxhTXpu?=
 =?utf-8?B?eHJLTjk1a24zWmRJUDJvd0RYZzRWNk8vbnBIVjFnV3czampuMDVxYVkyMkh1?=
 =?utf-8?B?R2FucUUxd2xjS1R4dHJVWkVRemp2OG8yYVZSamwwNTJPaEdoL1hPRzdtSjdo?=
 =?utf-8?B?UUtUSEh6OEtlU2NZcGYxdTU4SnhUSVdTLzJwZndSdlBlaXJmTTVDN0tVT0Jo?=
 =?utf-8?B?Szh6bmMyYUtUL1IvN0V4L1FmTjdXclFPUTRwYkw2M0RmZW1EQUxDSUdWL0Rp?=
 =?utf-8?B?SnM5bDREamIyeDRWaEFlSmcrVWJ0WVhIc3FDY1ppUG9hbU9zWXlzWXNEUmFn?=
 =?utf-8?B?M0FWOHlDcnJtYXMvVEc4NElaeWR5aVRCM2NHWmROZDc0elhHVEpSVTQ3T2NZ?=
 =?utf-8?B?cWthWVJiSnBrT1ZnNGJURFI0U3hEYVlFdzVxU1hTMWY2Rk9lclpPZmw1cU5j?=
 =?utf-8?B?UTdicDh6QVdwZ1UzY2tHT3kvNTBRZ2Z4VE5iTVRSM3hKZjJrS0lMSXBFa21m?=
 =?utf-8?B?OHAvZUwrUFpxTHRQek5KVm9Wdkl1cll1N2VwZzBia2JBVW16d1ZFa2tMa05M?=
 =?utf-8?B?U2N5SWlMZ25FZDlFWk96dTZSMnNiaHJ2TGY0SmJrY0RnWkpHSE5xTmk0S2xG?=
 =?utf-8?B?aWIyek1sUGxmajdJaGZpMkZVS0FXcWFJNHk5d1M4TlJlK3FzR0FqY2NqZ0tj?=
 =?utf-8?B?N3J2TmU4MnpzVm9aUHVlMzlRMWpmQk1FKzVLdkxNdW1xZ1J4bngxYkNkMVFx?=
 =?utf-8?B?bmJ0ZjdzRnlUN1h0VTMzckswRDd0UmFreDFGQ3RSdzE5YnBGZVBrak4vMG9i?=
 =?utf-8?B?YVBtM3BQbThtV3NxYUhWVVpvVHg4YXNOYWpSVXJaL3hYeG10Y0xVYmJUZmk5?=
 =?utf-8?B?aml2UVZMKzhSRXA1cFhHS1BBOVAzeldVTEg2ZFA0dXVjQTBUZm9Dc01TcENJ?=
 =?utf-8?B?Wml1YVF1VmFMQmsyQll5cERkcHBuckJhbjl5Rjk3Z3UwOXE5R1pqSFlUVExx?=
 =?utf-8?B?cUIxQUxqR0k4UFJUL3lCQURPNERLMmprc1FMZXI1SHg4OWtpRXYvNWpPaHZD?=
 =?utf-8?B?cnNCYTE1RjJGRFI2STB1Wk5UeE1BY0V5U0psbCtMREVKMlc4bXV6MGc1bjVm?=
 =?utf-8?B?d1ZzZzRwQ1kyV3BiMzYyY0VnMTh2cG91YlU0ZGlnazYwUXVpVEdpeEtOcHpH?=
 =?utf-8?B?TGtMRVcwVzhXMkFXWmtFaC9HQnBJUlM1K1JMYklNVGJDTk1KNVBmVGxic2R6?=
 =?utf-8?B?QitYUWN0S3hsRTZhWHo2ekxqcDdYV0g3dk9GeEErTTViNGJ5Q3JZclJ2SHpC?=
 =?utf-8?B?RU44T0NCYzJvNCtaaXZYMG5WQVRwU0h0VXQ1ZFhKTGF3NVBtUnY4MTBEQ3Zz?=
 =?utf-8?B?VGZUZHlUVW5UWnhDVHNaNjRoWlE1d3pxNS9CMHRyYmlWU2JkK3dLTEgxVDVW?=
 =?utf-8?B?Q2R2ZW0zZ3l0c09Pa295djJKbUYwQWdrRkw5eFNvVjFEcGlvWVFDV3VYZVor?=
 =?utf-8?B?K2ZlTThVaTlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5867.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUREZmxVUDk4ZlpNblVxelNhKzhqaHlxYVBIYmNTM3F3SHI5UnZoa3JCR2ha?=
 =?utf-8?B?SStoT1dXS0w5KzZIK21ZUmIvTGQxYlNVWWU5d2JTaTN0dHBqZFJCQ3V6L09P?=
 =?utf-8?B?SjVQQnNRZ1g4SWRiRXFHU3ZIYWpMbjMzNEk5MHhCTWhpTk1MRU8vUnVFSklr?=
 =?utf-8?B?M1g0L0hFdWlMYjVuNnMvTFlyMHYva2pNd2NEcDN3SjBwMGhvaFdrL1V2OTYv?=
 =?utf-8?B?RFNjaWU3emw4SDlyNWhSNWJTWkZDNzVJdUVhbHEyVm5iVU9wUkhBWTZTODFw?=
 =?utf-8?B?bS9ESmtuRkRvaldML2F2YUtYVFNubVpmdHZhSGxuQVpWM1dkWDNrZnhmNko4?=
 =?utf-8?B?SnBXWGJZL0FBWFFIb2VpMW9tNk56Sm53aS9Qc3dlZlk0aFd1SnZYcmNwU2lR?=
 =?utf-8?B?RXBKM2ZvTVMveWZUd2pZVkRFZmw2Yk1Hb1hBZnZINzhEakxrb0NaaFdINXRs?=
 =?utf-8?B?QUs2NzlzendCRnZXS0F4S1JVcDZsZzRSNG14K2k3SG9ueVRybXFRUExkU1Qw?=
 =?utf-8?B?Q1RjK2Zsc3hBTWxrb01QbnhPdVdIUDdWdUVBaTZhNHFFa0FyYytablhEbUls?=
 =?utf-8?B?RzhDNXVta281SHNRU1BETE5VN1h5L0dvQTE4Vk1QWnRNdVUzcjN1S1F2WDQ4?=
 =?utf-8?B?dXM2YkpGNkRxdE9IVUdZRVQwWUxabzlldU84S2FJZGZwQjFkci9BNmEraFdo?=
 =?utf-8?B?SUZjVTlMeUNKQzdselVDK3Z2eVVwaGQwMXNXWm5SN2dOU2JidG41ZlIvTmNj?=
 =?utf-8?B?TkVxcWFHbW55MmJ3UWMza1JjMXdXaXRYS2VINWlqVVYxcUl3ZkVzUklCZGp1?=
 =?utf-8?B?dkF3RWdFRTBCWFo3VGFxd0lqSDVpZjZHMGN3eGNBY3NWQnczcGM4SG9zSVov?=
 =?utf-8?B?QWFaSWFtUGVncXUyOFZwOUNlQlAzcDl5NzdYem1YSzJhQUZ3cGd6YWNyUlZ1?=
 =?utf-8?B?NnZHSHowWko1UklYYjNaU1lmWnpNUDN4Y0xZd3JwMFBKdWl1bCtHcVlOYU14?=
 =?utf-8?B?UXJwa0ZtUTlmWmk3Yko5OFlCNmdLS3JTYWpOQnRoakJiVjhZaFUzTlV2TUhY?=
 =?utf-8?B?VkZ1N1lDbVNPMmRWTnVJTUcwcnpCM21FekpITHFvd2Zrb05MeWpHRFBEMEc3?=
 =?utf-8?B?d0hKUGlPRDdvVk1OcUNWelNiRnREakkrUlg0N2ZRWTNjZXpTcTFTWlFqcnFK?=
 =?utf-8?B?OG9reWNCdnhkM2JNRnZ3bFJXamd1RmN6aVVTUHV5bmtrNG52WEpPZlVwQTJp?=
 =?utf-8?B?K0U3aGpRSjFvY2J0U054QnJNZmpRSmhmT2VxY2dTY3FXdG9uUERBYVlJQUZK?=
 =?utf-8?B?TXFSWEE4WEV4ZTZudDFneXRQM3Z2aTBONXNxNGpEVEpqUUUxK2dhZ0hKaDJu?=
 =?utf-8?B?V2IvaFRXaDFlMUhzdUErbGo3ays3cmxMYlNpNVJFSDhrU292Tjcydko0ZUlm?=
 =?utf-8?B?S1ZWTmxDUlBIRUZvZUNGSkcrcy80SUIvRVAzVFg1djFqc3ovU0NWdHE0aTJ0?=
 =?utf-8?B?QW0zeU1mbTJOTXoxQ1FXSEg5bnNJekUxeWRKNzV6R2FGbGRQZ0c5a0tjY1Rm?=
 =?utf-8?B?Z2hpdVNZbDJQcGoyNHVCMXZ1NWJBR1VXa1ozbVZyWjJsTktHeXFXUkdGYmU4?=
 =?utf-8?B?SlZIT0hoa1NWWDc4ZWs4dkwrWXRaMi9kMDAwZW1aTEI1ajFQT0pkcWx2VkNl?=
 =?utf-8?B?bWNtcTg2VzY3SWZDNWhmaGQ1ZC9IUnNsbDFPdm5WWmdmZVdPUXRjdXNhYjNQ?=
 =?utf-8?B?R0tXVWZCTTFrQllNbGJJVDVsRW1sWWphOVVJY1VabVZ3VUx1Uks3KzVKUTVq?=
 =?utf-8?B?SHJXdElubXdIQk5xZTJlakpMYlNOb1I5VVdDazFjLytUeHMrZmFNSHUybmxZ?=
 =?utf-8?B?WngvM2JOUW9YTXk3SWorVG9MZEoraHN2RFZTZjBDTjhrZ1NPTnVSdEc5S1M4?=
 =?utf-8?B?dDc0cnF2WnZya1Ryb1JWL2FWOTVjT29lNkhtcHlaWHU2dFlHS3dHKzlkNWc2?=
 =?utf-8?B?TE9DZTVDRlhGeFRJKzVOMENGcXJlc0FtenVaL2pkUCtHNkdwQzJTMVBCVVNL?=
 =?utf-8?B?d3VTbVA2cVNzeU5hQXJta2RLKzU4d1R2QWpBL0xqVXFFTGlmM2dza25EQXho?=
 =?utf-8?B?eHFYL1VyZ1Y3RXNKajZRZzJSeE4rcERDakhMdEE3MHF2ZVNsY3NUQkh5T1hv?=
 =?utf-8?Q?+Q3OLDZZ7Rgl3CxRzBLyHsY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5BB3E73979C3E4CA00A2856377D07C2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RTEQR5HJbWRS3KUfZPshhZjZGfJ2aSnxWCnA/bpymXRrfSW7A8GqbJDQYP3nq7SX9uveX78CHx+VkDMsVrkV5dg1DBvob55BKF98ABi2X5NG4hpaa9MKaF0IZpgCKKfhc9JHRQB03HgsmLkIZaCTYc6mT1FXg75Es5OfJxvbT6n+OzNW1u0YrAn0VYusjK5RIkarfsatt2jErTKogI4r5bY5DMEY0hWatA/F0D6Dqf43v+O21hpZD2+CCSxMJTm8ZjI6z6WnImgSdH+8eNssyIOEPoJP8aafbK1JzQFvbohIqNRIpTNLqoNWzIt5IRvPB6qfMYX1s3gATmnGy7g7rb5OGsYm8K2cRV5NdxegDhFRUbtvnC6xPNWl6Stp3wRpNakAUa8Zp7WsKqiOK/4BI91lLjMeZo2dYTzvxPzdr0GRCmJJHilwOGy11SxDGdw2KvKYmqa2xdQHdm4tHczNzs0SjAZnzFvkJ+fLIAd+CS5Qi71iu3YQaZgaPXevB6SREBmvZlMv975f//IG7pdZh9x6/3cxaTfbUMeNf4mtawgyTth6q01C3i0IYNbdwl/Z8iPVTYN/Vid1IGOMAMCC0QwhgBIm8hGzQMO9uHJ68MY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5867.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d79965-6166-4b1f-f86d-08dd81e8d3d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 21:58:34.2360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIIYVM3weJIOEJvNYrRQrpzbq91U5gpSTzk7DpRYKfBgrUlnzFeWf5DPDmzErrXGmGdT44VhNfPRuYssxRpoohvWxuzhOlG63zAIlWYeOYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_10,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504220165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIyMDE2NSBTYWx0ZWRfXxEBoUFUUM5pR G87jsIK8tvqLW8tnsO87qIMXFdvSTIW+VM4UPL8WFGLeMMgylBd7xgD8H3X24/0aaZueCd2O6Y+ Ycqk5wXWbLveHTia+DI+Qm8GRoS97gGFCYJe4sPuhogr/55E8U8BpUiE63w30V06v7T5YqTvyVb
 wUl4j1BNlmD/uZdthXn+WFYQOvmsTgOd6ANM3/yyXuTtzuivWEmOAP7zm7m/BIkC16AfSAId+Ea QMwncN0UqQEDu9D5tH1SIyyEA3HvL1KnOxHysoQFimu2DQKgjw7Q7YEPo6yeLOdaQdZkYgshfJZ 6b93Fm2IYsUwS4hMMiVumiWuzGl1a+RBy2nyXt6rAdzS/ZinoTXxM7KpRMRHWXx8yTRkv+y9LkD iXmGp4sl
X-Proofpoint-GUID: 8xz1v5jwFihHBCNruWLPiowXFbGTDchp
X-Proofpoint-ORIG-GUID: 8xz1v5jwFihHBCNruWLPiowXFbGTDchp

DQoNCj4gT24gQXByIDIxLCAyMDI1LCBhdCA0OjUx4oCvQU0sIENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEFwciAxNywgMjAyNSBhdCAw
OTozNDozMkFNIC0wNzAwLCBQcmFzYWQgU2luZ2Ftc2V0dHkgd3JvdGU6DQo+PiBXaGVuIENPTkZJ
R19GQUlMX01BS0VfUkVRVUVTVCBpcyBub3QgZW5hYmxlZCwgZ2NjIG1heSBvcHRpbWl6ZSBvdXQN
Cj4+IGNhbGxzIHRvIHNob3VsZF9mYWlsX2JpbygpIGJlY2F1c2UgdGhlIGNvbnRlbnQgb2Ygc2hv
dWxkX2ZhaWxfYmlvKCkNCj4+IGlzIGVtcHR5IHJldHVybmluZyBhbHdheXMgJ2ZhbHNlJy4gVGhl
IGdjYyBjb21waWxlciB0aGVuIGRldGVjdHMNCj4+IHRoZSBmdW5jdGlvbiBjYWxsIHRvIHNob3Vs
ZF9mYWlsX2JpbygpIGJlaW5nIGVtcHR5IGFuZCBvcHRpbWl6ZXMNCj4+IG91dCB0aGUgY2FsbCB0
byBpdC4NCj4gDQo+IFllcywgdGhhdCdzIGludGVudGlvbmFsIGFuZCBhIGdvb2QgdGhpbmcgYmVj
YXVlIHdlIGRvbid0IHdhbnQgdG8gcGF5DQo+IHRoZSBvdmVyaGVhZCBmb3IgdGhlIGZhdWx0IGlu
amV0aW9uIGhlbHBlci4NCj4gDQo+PiBUaGlzIHByZXZlbnRzIGJsb2NrIEkvTyBlcnJvciBpbmpl
Y3Rpb24gcHJvZ3JhbXMNCj4+IGF0dGFjaGVkIHRvIGl0IGZyb20gd29ya2luZy4gVGhlIGNvbXBp
bGVyIGlzIG5vdCBhd2FyZSBvZiB0aGUgc2lkZQ0KPj4gZWZmZWN0IG9mIGNhbGxpbmcgdGhpcyBw
cm9iZSBmdW5jdGlvbi4NCj4gDQo+IEkgY2FuJ3Qgc2VlIGFueSBhdHRhY2htZW50LiAgQnV0IGlm
IHRoaXMgaXMgYSBicGYgcHJvZ3JhbSBvciBrZXJuZWwNCj4gbW9kdWxlIHVzaW5nIGtwcm9iZXMg
dGhlbiB0aGVyZSBpcyBhYnNvbHV0ZWx5IHplcm8gZXhwZWN0YXRpb24gdGhhdA0KPiBhIHN0YXRp
YyBpbmxpbmUgZnVuY3Rpb24gYWN0dWFsbHkgZXhpc3RzIGluIHRoZSBiaW5hcnkga2VybmVsLCBz
bw0KPiB5b3Ugc2hvdWxkIG5vdCByZWx5IG9uIHRoYXQuDQo+IA0KDQpUaGFuayB5b3UgQ2hyaXN0
b3BoLCBmb3IgdGhlIGNsYXJpZmljYXRpb25zIGFuZCBjb21tZW50cy4gWWVzLCBpdCBpcyBhIGJw
ZiBwcm9ncmFtIHRoYXQNCmdldHMgbG9hZGVkL2F0dGFjaGVkIHRvIHRoZSBrcHJvYmUgZnVuY3Rp
b24sIHNob3VsZF9mYWlsX2JpbygpLiBXZSB1c2VkIHRoaXMgcHJvZ3JhbQ0KZm9yIGEgdXNlIGNh
c2UgZm9yIGJsb2NrIGkvbyBmaWx0ZXJpbmcgYW5kIGl0IHdhcyB3b3JraW5nIGZpbmUgdW50aWwg
d2UgbW92ZWQgdG8gZ2NjIDE0DQpjb21waWxlci4gS2VybmVsIGhhcyB0aGlzIGtwcm9iZSBmdW5j
dGlvbiBkZWZpbmVkIHNvIHRoZSBicGYgcHJvZ3JhbSBnZXRzIGF0dGFjaGVkDQpmaW5lIGJ1dCBu
b3QgZ2V0dGluZyBpbnZva2VkIGFzIHRoZSBjYWxsIGlzIG9wdGltaXplZCBvdXQuDQoNCkFncmVl
IHRoYXQgYW55IGFkZGl0aW9uYWwgb3ZlcmhlYWQgdG8gdGhpcyBjb2RlIHBhdGggaXMgbm90IGFj
Y2VwdGFibGUgYW5kDQppbiB0aGlzIGNhc2UgaXQgaXMgYW4gZXhpc3Rpbmcgb3ZlcmhlYWQgcHJp
b3IgdG8gdGhlIGxhdGVzdCBjb21waWxlciB2ZXJzaW9uIHVzYWdlLg0KDQpXZSBhcmUgYWxzbyBh
d2FyZSBvZiB0aGUgYmxvY2sgZmlsdGVyIHByb2plY3QgdGhhdCB3YXMgYWN0aXZlIGFuZCBub3Qg
c3VyZSBhYm91dA0KdGhlIGN1cnJlbnQgc3RhdHVzIG9mIGl0LiBXZSB3aWxsIGxvb2sgaW50byB0
aGF0LiANCg0KVGhhbmtzLA0K4oCUUHJhc2FkDQoNCg0KDQoNCg==
