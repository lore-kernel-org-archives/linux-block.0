Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D115D2FF144;
	Tue, 17 Mar 2026 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764317; cv=fail; b=WrvE1tLZo+wvqK+QnEklLTYfWNxVpcc6iyeMkK0xeeh1Cp3hpXZEzu2yM9MZkDCDxIAfpnPuodP9dX+/cy/7N6NfzyXVl8EpR2NcFCj2VGolGebx9ueVRg2A71jdkhqv3lgZH4SBe40oRdyDTUlzdAo/zdDtTMUcU7z1JMxg7LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764317; c=relaxed/simple;
	bh=UsbOWicLS9fXdHc1lbGxdUsKQ93RtjlxKpd1W+AzS34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bg1vHmpCOUZ0EqW31uU1xk7hj2I33eZtwIyTMysyFq7KfEPsCxelp9GpN54htL30wFKqoMhapjasxl7kEF2KZspaYwlcQVf70VU9BrGKUwz5GdSjJEaDQeI4cL+H2+ytcHEf4jcJHnMOjlVP77czbXPmYq3Us/r8oo9sxPOBCfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZmVA4thn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Iz0IpPnj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZmVA4thn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Iz0IpPnj"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HDgCVd729985;
	Tue, 17 Mar 2026 16:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SlEjWwvRZOm77rdvu/vVMucoKMx2XroF/dwuHGJQDZg=; b=
	ZmVA4thn8rf9FX3WHt7sTLgP0pv5NoeO1LZc8kKOVtHEiqFvrGmo6nD+nnuvz37f
	6qsljptAoV5fcS5olhjhfr68/DAb/R2XSUVqIdJ163+rgapSs7X3Sj1a54B428EP
	TYY2c7DpsOjTye0PU2CtnBR7csAHABRkUyl245dVzqHUi9+P9eDste75msUwYWb0
	DR44qqjjzU8Zeu3OgydNRAkd22z+Z5WSAuHdpKBA5cEWJ8OPYwVB2+iIaOlHKuur
	a3o8j4fhTRNhY7t3zeZtbCp0t2aF/my1qKEZh7H4sQEHgtAezAaMVxKbdLvwQayE
	AiyjIl7Y3o1B0SBThg+krQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8cg47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:18:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62HG57iP014169;
	Tue, 17 Mar 2026 16:18:30 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011042.outbound.protection.outlook.com [40.93.194.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4ab0fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zReLVhD76cKhZPl1JUhHghbkArKsWtyXcqzdLNNNC+nRRGeYNv1V48aXdu3gPQavi/ibrYcr2gDmIl3QwJr13B4lc5Dwnlf8Osy0YyA/tBBknFe1K0r5ueqhYmspa4/oioLgwxTfmx/CYr4HcSpqCFzWR2jzVCgblq/UpOMKWpVJZnFv74mw57IzTbo0Sd0ktPMRHVtvWpyYwb3EpW43w1Tn2WAkL2Ht/LKx7SfCFvPfxVAV9q2QV0jPhXuA+wlx0kY8uV0AfWhwDzGdaW6Mcrn+BbiIpozG7hZL2z3TxM2F6sQ/qkSLf56yJzfkZPXVBNgCeYcF6Ix/d4keH3jhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlEjWwvRZOm77rdvu/vVMucoKMx2XroF/dwuHGJQDZg=;
 b=q4B5HlZVwV16SM0ize7GZNlzT007zZd5zjwW4ou2PdqFv7jiS7amcYpeVNT7PW8qVEdFg+KAoT2h3zAUHjr2MqC1PZo2W+jqfy22mCOGQiwi5yvplhSJj3vZPaqCCKMs7Up/Y5ezeWfzz3X9zSJ6pc1WRwmry9Bb1nSCd9XGNsk5HNCa7qEUQCxX98RwA2Y0zn1M6vGlq6amX67SokyEJazFv6V6bsMN2fEjCA5IICl87PJeHHH0j5PhZZdvHNnIKQzuFDW38hmmg1zw921ZNVbLd89h4mX7i8mtznUGPqrQxl3A3giC5WqQM8KEVBUSz8L/1spMnNWdYkRNO6+rjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlEjWwvRZOm77rdvu/vVMucoKMx2XroF/dwuHGJQDZg=;
 b=Iz0IpPnjs2RAAqLdpcGixGToTYRo6iNsA5g/i+wybzBP3IHunMkPhKeeprFSVyGsqj8eKEHh5fbcPwSu63Q36N3AX8vpPFFejxHRormK5EnfjHkOHtIiivkmucDjm3WMAmBzv9BgTkVOK17q+a1qIXvlhXO+K49n9Vm3BgUP7NY=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by LV3PR10MB8178.namprd10.prod.outlook.com
 (2603:10b6:408:28c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 16:18:19 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 16:18:19 +0000
Message-ID: <b98e0c24-2ccd-461f-b5dd-0ec315c0c61b@oracle.com>
Date: Tue, 17 Mar 2026 16:18:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] block: make queue_sysfs_entry instances const
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
 <20260316-b4-sysfs-const-attr-block-v1-1-a35d73b986b0@weissschuh.net>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260316-b4-sysfs-const-attr-block-v1-1-a35d73b986b0@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::19) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|LV3PR10MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf554c8-3197-4b55-117d-08de8440cd90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	XjrhU3NHTTY1bxnLGVTg8oJ92uGrRnpUzDklUbQ3tcDIZ8udVIjkQYn+OoYA1ENn8U9O5aHyZWj8K/06llQnS25GbV0vwFe39tQqZfVjKyEfg5RE3rjLWq1KJZDoqF1urcN97HlUfTQuP1M/0+2r6bg+VWp/lvA3wyFCumllpUAfC2uDnLnRR7E47Wlgb0EbUdloIaAmEMoFqDsrNARlSlWQ3Gk3W9vavc4eE4A13Sk5ZeuyQLMdW0bnU/eYptuOX5cs5TCeOM1Wb89vhnrUWKOoTJwwlOeQQzUFB5kt39Tlup9wK+lXAmzptjEzXaLxmUMRlK1rOKB5UbJuYZ4M/rNvmyn3D0P3P0YW9fM678zguVPgUKr6rGS8iCR7PtjfCFpFbKgRUKjaE78QKCIIq5Yg4qjRUgztXOSOBXMRXaaZXVW89L4XQEqwv25RbhyKen0JHYyBhCeVN4tcyJ98KCe7Ll+hOMpex9XfexjVSpjtMYN0zmXW1ZePdiRr1QWVvCU5nBDLy8VSLP32TKKmOlpOrO+Tw40fEzzgJHsD9zqPdS1Un3TcFggsaE92fi6CsWtU9ZnVhltu34SMisSVBg+U5pP1zNGsLa03LRzZdmZzpN/lgflO4yc2je7j4nT4L/CyI+295unec13ED6vR1xCWny08kBgoFrVg9cP1ROcyO8zLCCEkHkIlppJ9YJ0PFfyhTDYmDzgiRWki7aKQmzjeGNdYcmsEprF37FUEtTc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STliMGpCWkV4VGl0UnpMamw2UndXbncrRzRyQWYwbXpibGhmUFhRbFk5OU1W?=
 =?utf-8?B?bTB0endiSmlMNHkzSHNMKy80d2lFT0NVQ2Zma0lxck0xZnk5cld4Qm5YRnkz?=
 =?utf-8?B?SmlMQXZ0K1drelNmOHhHK2ZkZkdORmU2QjFzUDhWZEJwZE5RVjRGeDkwNE5n?=
 =?utf-8?B?aFMzZTlvaUY5UlBEcFBBYXkvbE55VlFCRE5jODVDUWxzZTI5TjVHbTJVbE9m?=
 =?utf-8?B?NXhnZTFUeUdheW1qWXhXaDY4MkxxdjdxUmVCTXRVMDBNdVUrbUFkRkxXbjZC?=
 =?utf-8?B?ZStYSWlHWEYxRHY0eTVhbzBvRGo5enB5T09FVU9mcnZLZi96V3ZZdkFjVEh0?=
 =?utf-8?B?VFNLbXdlaVF2Q2dBcUtKdVJLRUNXT1l3aCs5NThobmlkTGx5WGhyeGg5cWJh?=
 =?utf-8?B?UStIanlpNElrUzdTNDFIOWszbGJoUUNBY2VGR25xOVhnT3psN1hUVDlvb1N4?=
 =?utf-8?B?SEp1UUY0UXowSis4WFhIaFFSdDJVbldpdlBGTmxhdEY4OEYrNWlGR2V0OXk3?=
 =?utf-8?B?N0h1a1AzWlkrOGFmQlVvbUV6eVRlMnQ1Y05DaXhuUnlSdlM4U090U1JPczJ4?=
 =?utf-8?B?SHJxdkdqZnpqUHRsNVd6ZzV6VldpaTdialV5cFNKSDF6TXlSdGl5N3FaaVdI?=
 =?utf-8?B?OWZjOFBOaHZjTlRXeTlNYkJOZExWdG1xZndwV1JuZG9EUDJZMmRpWmoxWEpn?=
 =?utf-8?B?cG1HaUk2aXVCMVBjU1ZBd212TnE0NmZMS0pRVkZhK0lRUm40MDlveUhpL2xx?=
 =?utf-8?B?UUlEWHhrbmRCTEVjaE5LRE43YThkRi95Qjc5SzV1S3FTdmZKVVNVTWxFNXd3?=
 =?utf-8?B?QzRTa1lVbWtZbUtqMHVOYTNndjVoYkVUYlJVTDFIbGduN2lTTkVPMEIvYnZL?=
 =?utf-8?B?S1FYSDZyb3BnRWpGa0FUVnAxZWtINVRpVVFxTWswdW82UUJqZDFmdTRpa0x4?=
 =?utf-8?B?bDRHNE92VSs3QWVncExpeGZGMUs0SXdNSTBQalJJODc5TDhqSFhlK3g1WTY5?=
 =?utf-8?B?bGZaS1dFQWlKMUxJY3VXOFMyMnJJbWY5QjZrRjJTcmJGaG0za0hOeDJWK2JR?=
 =?utf-8?B?b0R0VWpxZlZmeTcwRXg5Y1FSMUpxSk4wL3dPYkJabVFzTVI2QUk4Qk9VSUNZ?=
 =?utf-8?B?TnNzNUFvYmRUL3ZJbXl0M2FLNWovTXJuVUM3a3NERW1QR09OM1Fwa2tCV3BJ?=
 =?utf-8?B?bThaakVLU1NJcVVFaDU4N0tWS2lQRDU0SldFU0VVbHBNNVFhcVo1VmVFc3Nn?=
 =?utf-8?B?RjJrWC9jeC9jejFVZ0cxaU9lUEVBUTdZcTNtclZ1enhWTjRxK1k3RFNUKzla?=
 =?utf-8?B?OU4wQlhoMm5NRm9mU05YSGREYldEMWdmbjNkZ1V6ME1LMFp5dmc4akoyV1dE?=
 =?utf-8?B?S1BGMkhOZFN3ejFudW9Qb2ZseTAwREp6b2F0N09RQzhsYy9KUjRzQU5UVXdn?=
 =?utf-8?B?ZWZWSjNCUkxON1k0ZFB2cUxNa2hDc1ptZzJjMXQrRE1wTUttbkw0VDVxcHNC?=
 =?utf-8?B?OEE5RGhBcW5FY2lPQjBvZEhnUEhueHIzcDA4V0tBTjdnMGNNdzVmL2Vxd09k?=
 =?utf-8?B?QW54VCs2QXpvNmRoaXhHNzU1MTd6WUVjSGExblpDcG1seTJlc0M3eGdueFQ3?=
 =?utf-8?B?WGlLRlZDTFpOYmM2amdnYVlOZklCUVM5cEhNdTEvTmRqSzFaQUQwbVp1bHVG?=
 =?utf-8?B?dXVzRGZWbVZaSTRkTStUbStYSlpmd3ZDdythZVRqcCtaTGpzc3JnSXUwbTJ2?=
 =?utf-8?B?bVFDVGIrYXovNFIydXY5N3Z0UFRDU0swTjBoUmRzTkVkN1lIRXhLZFlsd2s4?=
 =?utf-8?B?RzEwKyswT08xaFhCa3UyN296a2N3dlZsRHdHVGQ0UzQyNEFraFUrRDBWOEhH?=
 =?utf-8?B?Z09ocVkwTEc4VkkvYjBaR0dKUTVTcTFtdDg3emhTZDJyc3BCWE1oMytiUVNB?=
 =?utf-8?B?L0Uxbms3RUNZb3Y4a05jdnVGcVNyb3hqTE9CMGhnVGJqTmhsbnRTSk5IZUtC?=
 =?utf-8?B?ZEV4clJNZEJQVWNTNDdlaVM5c1pDWjBQWk1IRlMxcSt6b2U4ZWZHZG8xUnBp?=
 =?utf-8?B?dldNUGxNSjdkd2FianpBWVppM2p5dkttdzhFcFZtNUJ1R2NXV3dHT01QbnlG?=
 =?utf-8?B?OHRWWnpNUzVpblA2S2tmVjRzSkN3RG1CMTZFZWNrLzE5SXBkRFlBZnZWa0xv?=
 =?utf-8?B?bUxvRmFRdmRrRXVvRUhoaHdPQU1sSnpXREd1NDMwOWhFVnJ6ZjVjRll5QmUx?=
 =?utf-8?B?Q1FPMXNCZk5Fc0xIMUFUSHNTQ1Y1aXEzT244N3dtR2VUdTR2MXZZeVFqUjlx?=
 =?utf-8?B?QTh6MkRxKzhvNWtXNUxSbHA2b1ZjMGhrMklVSlp3WGMycTRGTCtFREp6M1Nu?=
 =?utf-8?Q?PO/t5UMq0RO3UPMI=3D?=
X-Exchange-RoutingPolicyChecked:
	speA6NLe1w5eKubiVSgF6yUK6v2IH6pUj3lEyQ/37tMINu9TjIj9e9eZcs+5iRFEJ3eA6aU1QrBAIHXeN4wRfn3EpFJsLci2EbjIJ4IPCIrXZWxs9pDkRbmmqxx3ZJDhbzW5J9lJ10ZiMlsDmF9C96voyhMLu24gOA01MKiKJ0aZm3WqwwZKt31AIyoKcSPwbzKOtjAtsTNco17rAYOX6lEVbDayi+9Dx/6TQ/XO4XUDnyFu4+ufUE1anhmYluEvEk/YbdNM7hgoXQYNxbGNyT8ZzVXGjFZ+MCZ6XoSKhx/VIXu+G4ldrwuNeFNE37b+80rz8F10XI6KASUBvnGWYg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+tJqEtdf3pmw/0WrA/CvgxNWmKFlxt40JKCCTFjdJ01W3x6h/YT16yAZtNbgtChUVvleEsq/z/cEOOR/NxI3X/pXiGIXM7AHSrMvKTWIqMi+c+ZQM5S/OuBMsmyMjuiJ1wvMvcefj4mnQTOPArSXy4+146M0VK2iexTY7npElvJP+P8+gYjCWziAKIEC07G9BlIXNfA6Q9DpSU6/qRPzn9BSPx9007f2GSTyETOK5uFe28IUmyWBoHx4rn2RvZQEn+Sr0LSKincIq3RKIhoPHjukYLxnpLN6y7CWo/64mQTb+Rfhp6a0EjtS9+IPzW1fUDwpONU8u9EwIV976CqVtEp4UZS81upZXMoNF3MbywJqqaqbqhndtcJKU1xskBGR4QmlqJ4gmYoBqBcwhI0lDnE0s1KYj4SLXGoc0hgIpwUxdLWnJQazcA5KwW+NwLm13bqe9Wl5l4m9V6T8guQ7DV7NSHRMDKoAipBhNNhd07kMbDrwMjII3WrhYMEOOd+eylEjVCQfWhse6E4iboMZp4Q7hst8ifAZLBG61SMt7vgkmaTt7fRUZhNc+YlBt2gNi+jy2e3mFZFr6wamlwUCSxpDfALLkCSvPyNpecq6p3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf554c8-3197-4b55-117d-08de8440cd90
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:18:19.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZuN2CqQ7Yds+0JBQJ6bHWnhIM4CRc+XqVr6kD4TDHW7/kwjGiMJIkeDFOc4rQAu+vbLveU7r9xYKzO1wJuwYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603170144
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE0MyBTYWx0ZWRfXw3C00Tkn+fXO
 TsIAoV3st16wFcBTfPwGR5rsdA8oXIr0ELeMuoxumLHIWkiAjJklqBwm9uI/2NwkXr1nagqsk/Z
 zundC59kZ/gnc23PmrB87GhmiS6XbuNwXIO5b0v6UZ8Yr0SnE54KR3+j894XPugdfAWXR9uZxG0
 nC/wAQtkPhG+w4IjY7VZFDZeWF9Xt0fSB4sbMyE2PyN/mtWpKRKaYqjCkqi7V5YcmhfD+TcQJhZ
 MFCZOhd1Xwa6lEuREjesKfxd8pDyDPCRlykAaCGWeSJ1NLdDpL195JyK1SvTml7HVkKAt2m7l46
 nl8KKdThC5f5W/JcPd5yIkPeeRS0oTAgcZJpc0dcgdCFBsC5ZB3drK9V8XSdXCP8BmudeUg8RGI
 zmBUmcOnalhiqpbH9PRaMoFN+h8Ou0WolQTJn/ertnSOnp00b+VETRPri2mzsHKrWCmRenRkt+9
 CBpsfM+F4DTaeZcRP8w==
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69b97ed7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VTue-mJiAAAA:8
 a=yPCof4ZbAAAA:8 a=iWsA0UxvWSGQw4ePjqsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=S9YjYK_EKPFYWS37g-LV:22
X-Proofpoint-GUID: NKjmtX2flu_N65K42OVETEM1L4eaOfFf
X-Proofpoint-ORIG-GUID: NKjmtX2flu_N65K42OVETEM1L4eaOfFf

On 16/03/2026 22:43, Thomas Weißschuh wrote:
> The queue_sysfs_entry structures are never modified, mark them as const.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---

FWIW,

Reviewed-by: John Garry <john.g.garry@oracle.com>

>   
> -static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
> +static umode_t queue_attr_visible(struct kobject *kobj, const struct attribute *attr,
>   				int n)

This now spills over 80 characters, I am not sure what the block policy 
is on this (but I generally try to keep to it).
