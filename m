Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D0246797
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405798; cv=fail; b=IZ1eXzvbNwLsYOpA6s+PqSeJ/ha6GZQYWLaJ/cyu3UoV+fIMUN7GtE+vH1i6i+tiFuRZgNVkTPJ5Csm8VrFnJWUUZIRfYBbMP35TP5IGAkBfzUHfPSP3V8Z8YkVO77nMvChB90uoOIY+eoxKWwzxd7kBDDsx0EsLOtKcQ9cNuKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405798; c=relaxed/simple;
	bh=3AJQsuQCfyGjXn/IwewBd+AyDEHL3pxZf9FsMj4kUWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T3RFSAjklpyfuK5MGT1x2f2AFKqLqs2MT1skn6OzW8SXVa1KmZsW9b5YbjaCD4wSc0Rf7WawqYuyXbkISP06jUF5l0z1fT3ki2eAypq+DemtAGz2dorv8wFeV2uU1tLuqjQIDjRgOwZo6kCeQD5b313jCgO0FsFwVH7OWyQoHBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lH/vgpXC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xG2wZieR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lH/vgpXC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xG2wZieR"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897gRtI021891;
	Tue, 9 Sep 2025 08:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9GKu0AK3nRDI6iDUldjKuOo+ZI2PNus9cVaNqXqTLqk=; b=
	lH/vgpXCrD598t4Vxc11HmZLYbTOZt0JaObSvDkiS+tN9GaGb0lU+sHrzImi+9T/
	SxBckOKQImQLEb+cF7pDejl+EHb+LkmxfFhPzon9KMyj7hgVAbfj3149UEjd9hA3
	tinGuZuezJybVTgxWTyAXUyV8Kz5Rx0J0v7RFYqkBmx5a02EvHKiH6eUqp30cJ6b
	+cq695nMFdQoObWYC3QlYtYuR/DE8xNvIVicjW2HBwpgdIA7acShuxD9XSJJxWnY
	WemGnHM1kIJAG+3QoE7s3XuXGHtjaTPKh3g6IS7DowanaZ7Pv8mo4TQSjKsfqmgw
	zL5ZjUZw2OnovKoiraAEJA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pe9da6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 08:16:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5897OgvI002760;
	Tue, 9 Sep 2025 08:16:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdft1p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 08:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umEaIOdiOH0XKJxMwGEpzuS5S1fD4NnMTL1yRdDX/t77SdM9AVrDDSTIOmmFw3JnmPwEC7YvftaXvocx9HNkozlIT9yVhx3jpBNDQpsLB0qXB0wReh0IuiqPsdkLGWoyu+WdGvaZvi2/4ow6x8zGRhEX+m7TtTKRcGD9uHHxDCkkZiU/4DuvjmventSSW/3bqSn8Z/nwh+6C7LV2J/FslLZmoN5x7hhiLlX9d9pRnGvOhGsBKTKFdTaAEmycrmK/2lCoHoW/Bmx3gcfi1BKs24qp0Jr8SWj9sBK/aOmHhrO5MrGsIDan55Oz9V7ItiLfQ05VmZfyozfjPs83y9zKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GKu0AK3nRDI6iDUldjKuOo+ZI2PNus9cVaNqXqTLqk=;
 b=fOFbUtwJPaw5gRHbmZzPabeZu/Z/CaI4MR+MRkeK36StMwHjFl4G+mAwJF2Gk4Ur1eIFPyG4ZBRJtLPgGu3R77R+xWkD2rW8D+29cTDE6Dr7dLTzBSlG6AZEeI0O3Sjio6YHNaQGU+ulX9ZDlYZ4o2g8FeEZ/6rGkxeDzu1EzWaGWTtH8RQ1D6oLHuH84EyNUVjY4SoWD956kaGN6tqgokFxWkabnYEzjx5uAJuAb9Tl82YrDDUZXF2uY+AYWpSBqapjzpqzqJTp+Obq67ysolXKSxwyVZPxaPbszEdXZ15Tf7IWiotUGgPEq1tHaxVJy2+XNM35Osn3VSRoFSIprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GKu0AK3nRDI6iDUldjKuOo+ZI2PNus9cVaNqXqTLqk=;
 b=xG2wZieRSa4Y4zP59mqT+EOTJrDTQI049SCqWxYdk8ZaZDddDWqd4vKvDjn96wWv4fINy5ibRIVI7AwgHZan1x23AAq2UIIMsaSOxEu0BKhG9ALLgK1p68vh5M3C11Pp8kyuvTjMUxEHD7ER5klv5/E05BbQSDv/Siz60skADOw=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by PH0PR10MB7063.namprd10.prod.outlook.com (2603:10b6:510:289::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 08:16:27 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 08:16:27 +0000
Message-ID: <42becc1c-e842-4eba-a7ad-5b1e60594243@oracle.com>
Date: Tue, 9 Sep 2025 09:16:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: remove the bi_inline_vecs variable sized array
 from struct bio
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20250908105653.4079264-1-hch@lst.de>
 <20250908105653.4079264-3-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250908105653.4079264-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0025.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::18) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|PH0PR10MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 162a406d-0706-4d65-9cb2-08ddef792c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1U3Y3hUcEVtNmRGOEQzTnkrMTFoVU1XY1hadkEwNmE4aEw2bnEvanpKa3ph?=
 =?utf-8?B?d0piZW1aalJ1TGVkbVdmQWIrOFZKdnhjN2JKMW5lV3liWUY4blZXQW5FODhm?=
 =?utf-8?B?ZUNPcnhPbDdyaE5pcWMwTkhOYnpWZlg4UlJ6Q2tJQ1U4RE5uQnFTWjdjNThV?=
 =?utf-8?B?WHFQSlVSaEhqbmJybWhyYzJDRDJPWWxDZGNRQkZXQkhKNzltTDJoZE1kWmMx?=
 =?utf-8?B?bnozdG5FVnNQR2xqbTVRUlFUNWZDakIyTGVZOUhHQ0svb3ZQVm8zYmhWWmI2?=
 =?utf-8?B?dXozRmpCdlZrdGIyN3Rwa25wdjVXTENOQ1JVekxvRmIzMDVTOUxrUXFMRjI2?=
 =?utf-8?B?b2N4SGxmOG1EamF5WVUvcHdjeUhnbWFyZjdWTjJRSGFQeDk1T2MvU3Y0eUN0?=
 =?utf-8?B?WXhMWG1IL1RyZTl5NkhzYklERTBEODNncVB6dlRTVld6T3d4TlZCVVI1dDhv?=
 =?utf-8?B?akYrbmYrY2tQUEd3M2pLT2xNd3RjbWlXd1VZZEVGaWRLaXdlRHFDb0pBQjk4?=
 =?utf-8?B?d3dQTWV3ejRxVnFHbElMMmIybUEyaDg5YVVwQ2NndjcxaGluU3VIcTVObEls?=
 =?utf-8?B?SWhrYnVpODg0MHJQZ3hnaVgvV0kvaFRick13ZmNIODhzZXNZcmhXZGhvaENM?=
 =?utf-8?B?SFBnTEMySXlFUW1RMjM0dWJMWkxrUDgwUE41WmV3cHpUcHZaOW5KUlVBeDBt?=
 =?utf-8?B?WTcyZ0RpR3ZTcjJ6NVovVHZFQll4a0U1VXlFc3RJcVUvNlRYRXljSy9na0cz?=
 =?utf-8?B?a2ZuNEVrKzdsOFR3Uno2b0ZwbWRMMFNYWlQ4c1hjak55L0RWYkRwQ2VGNVFV?=
 =?utf-8?B?UHg5NzdwUG5NTnpzM0NsMWM0eVY1ZkUwK3NVcldMTWx5Vm9oUFJRM3h4ZnRv?=
 =?utf-8?B?eHlrRGVGbktZV2Z6UW84TWp5b3l6eTBvTDIwVzNHbXF0MitNTXluMExFMlZF?=
 =?utf-8?B?UlV5ZWFKUzRqWmZuNE1BTEg4WE5udkpjUXlGdG40NTAwbHB0YkhSSUlUZ0ZQ?=
 =?utf-8?B?OE1OVEthUCtGeU9Yam44VW9WREtQNXA5QUkweFA3Kyt3bkoxbVdrK1pqVm56?=
 =?utf-8?B?aG1qeUcrSXlTNFlqSnpaajdRMFA0bVJ5MExMa3FQMkF6c0hNUGErYUZMNG5a?=
 =?utf-8?B?Qk5hRVVJNjhOaWF5NHhLc1FXTVd5dUJMcFRBNkFoaTA5WkxacTlCNG82d2Z2?=
 =?utf-8?B?S0JTWi9UZnIxMUVCdGFxNmFFd3ZQWjFYc0RlK3d2SU1oRFNmak1wNzRDTzJP?=
 =?utf-8?B?ZlUvMDdpTW1GL21HaHZKaVlVOTZaMHU5ZjBOcmhHSXorZ25Va2RFaWYxME4v?=
 =?utf-8?B?UkZBVTNib29xVDdhZmtuVjl3MzZxZUhoSXhaZFJ4L3k2Vlo1QjhXNHArZ3Na?=
 =?utf-8?B?R1lqMGI5VGkveXA4TTh1NVE1TENoY1VHd0g0eTdwSFJlVi91VC9IS05OT3Nu?=
 =?utf-8?B?cnkzV0ZiQXJVbXdQR25SR216S2xUd0RXVUlRdTA2bFhsdEhGdm1FK2hqQ2w3?=
 =?utf-8?B?SHFtaGZxNnFac3NNVVBUTHRkUnBxMEpkTFFoRjZZTE5XVnA3ZEpMaWxHMTlo?=
 =?utf-8?B?OHlhUjh0dXIyMTk0RlQ3TVJzYWVpZHdkUjBJWnl4clpJNXhkbUx2WXZhdWtJ?=
 =?utf-8?B?L1VTYWwxZnZRbk44dnhoZlU5YzRTdWE1cmdKV0pHRUMzbkJNMmtFZUdWeEp3?=
 =?utf-8?B?b2ltdktDYUV1YUlYcmtJbHhwU1JPK0ZpeURFbm1VR1l5alZZOHpzSzduZmZ1?=
 =?utf-8?B?K0NRWlhMb0dBZkg5N0E5T2NBeW9vUjZ0UFVuUVltSEJlV1ExZS9VZlFaaXNY?=
 =?utf-8?B?ZnpxOGh0ek1LTC9vU2w3S3Axd0c1b2VaRmxxVUxDT1R1WUJwN2l3NTM5d2Ux?=
 =?utf-8?B?dm1sUkUzbTNKZmFpUHhGLzBKNXoyTHlkcGplRk5pYWJ2VjZrbE1sbnJrOGhP?=
 =?utf-8?Q?Rmib0g7L89U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anZGZ2k4UGxkSmUrQ3p1MmtBWjRhbU1HZGsyUUFHbENqNVBRa1lLcWdDWkUy?=
 =?utf-8?B?MzZUbVYvSk4rYllFdzliTDlpa1BSSS9aTlFRblloZ25qSzFSa2xEbVFZVWp2?=
 =?utf-8?B?cmN0bHE1ckJOY1VvOG11dUFSZkV3THBZTnV3ZlpQbC9LSDF5Wmo0UmxzRURx?=
 =?utf-8?B?VkJHYUV3NncxeGlZcnJNczU4SHhzak1SRyttakdIS3RYRDZUZHpRL3BXOFNu?=
 =?utf-8?B?WGNmN1h1bUJoRTkwMjdONURrVHRqSTdxWW0vdVpPVWE0MGc3MldPRFZpN241?=
 =?utf-8?B?SVlKTjN5ZlgxT0R4WWVQZlM0NlNnYWtOUUJhOXA3VzQ5dHppV25DUUVhNGtL?=
 =?utf-8?B?U2cxWGVFY0Q1T04zdmo3NTZTSnlQeUdKeUFzRTAwcDE5TDZxK3NQUjUrNm9W?=
 =?utf-8?B?eGVRTmQ4NkVkRGJIWVRMT3VISGFOd1BzTkxBQklQNm5wVHJ6ODhYZnBYdUJo?=
 =?utf-8?B?UGd0bllyRnpoSi9RdUFrcTB5UEhYM3czSHBZeGpSOUpyUVBJRWR0Z2pyMUdq?=
 =?utf-8?B?cEZlYTBFaTI4V25rU3VPNnYrbFJqNXlLRjB4U3Y4dDkyc3dYTlI4enN0ZENo?=
 =?utf-8?B?MTJFQUdvYkpJWkdOUHFzMHNueVA1ME1yUmVaK1BLWkdJek1GRHl3cmQ3SjlF?=
 =?utf-8?B?WXgrVVpONXV2cjNPc0EvMDVXOUJBbnI4Tlo5THQxWlFJSnVXSVc1VStyOTls?=
 =?utf-8?B?OWVnbFdadWZXYlFreGFOanJGSlV0VFJiMkliQnMwaEo1bzZCTmVNejJicnFX?=
 =?utf-8?B?QTVrNmVUUkx5NjFyM0pTNzZEM0w2blYxb2pGeFBqR2UwRHpBZWU0dFk5Q2g2?=
 =?utf-8?B?QjRiVlZFL3lRTkZzYktVaHlCQ0Zjcms5WGp5c21TVm14eEs4WkQ4Ky9uY3p5?=
 =?utf-8?B?RlFqTUYrL3NhZFZFUm52NXF5ZVBDSHdPL09CZENrUmd0bGloS0xUV3JoVWVm?=
 =?utf-8?B?YXdPR1htazFPMWpaenkzVy9iOEFRT21qK04ycEo2enBDdUp0MFJmdXJEMzJu?=
 =?utf-8?B?eGFZbm1JN0hKWTBqUlRwd2wwR0ZSekNFN01VWmRia1gzY2dGckpWdXhIKzJv?=
 =?utf-8?B?ZnI3eUd6NlV0dm0zaHljdDY4TUlHcFQ2WmtMV1lXc2lIQmFLSFA2YmR3ZFA1?=
 =?utf-8?B?dDhubUorNlZweXJHVlRnNEM2SmwvZ1Q2bW1YZzEzOFg4YXJTRlVZZ0tScERM?=
 =?utf-8?B?clJ4UFYwbGFhSFJQYjgyVWQ3NHBaNHcxcG1zTnNpSTVlR0xWRTF5TmhoNlFl?=
 =?utf-8?B?YytsTFo3Tm5iRmRKUjFJUTROL3hxLzVPMFFjOEM2Qk5aUkV0a2dHalhrMHZx?=
 =?utf-8?B?RExzWXcyTVpDWHg5R3Bia3RBMElzRGp1VDVWNVBvSTNKaytNQis3cmhwTHBy?=
 =?utf-8?B?dlRXQjRaaGtuRXBPalFmRk50V0RGTnlEemFxZnFQZXc1R21nZWk5dW5PN3BN?=
 =?utf-8?B?d25ZSjNOUnFqcEFmdFpJNVZBSzhXZElVR2RMK215WCtwQ2l0UVR3b2lJNXFU?=
 =?utf-8?B?TUVSWWZzWjNtQW9HZVhTZHAxM2pTRk1MaUVxNG5HejdNU0Y1bHo0a25RZ202?=
 =?utf-8?B?WEVkSW4xaVMrekpxRUFUdkNlK0V1VEVDa2VKRVBYWFV1UFlybWVoekxjVWVT?=
 =?utf-8?B?ODJ5TFJVamhJTFRtQWhtdmtCREtUQm1pK3VkMU5Jb1l1VWYzbndDbEZ0dWxi?=
 =?utf-8?B?bjdwa3FOWlRkUXQweXhYZUhja0ZqdXIySjc5QWJzd0VWSE5GZy9CbDVKU1hm?=
 =?utf-8?B?STgyU0RuS3VkZmhMUHY3TWlWTTB0MVVEeUdmQzJXeVNJaFFFUDRoTXVKN3dC?=
 =?utf-8?B?b09KK3ozeUljS3p1R2Faajl6ZnR2ZlFBT0oxOTdWVk1BWjdRc0ppb0oxcFhK?=
 =?utf-8?B?OEovUzk4YW1WdVZ6aE1nenVYM1JyQ3lIalBSb0tTOGlRN3ZuT2RrQVZHWDBs?=
 =?utf-8?B?OStIbWhjeEhsVDl5dXRYUUNIR3ZlOGxncndyY0VaeVBIWk5YQjUwM21IVGlX?=
 =?utf-8?B?cXBsOUlwV2g1RlZPQkpSRmNzZnBSYWJ2OWV5ZDFqU3dNdEFqOTRWaTBYZHpS?=
 =?utf-8?B?c2RZcGRKTWRFMVYvUi9qQ2lwczU3MjZtZ1B6Q0RxTENSN2NlNEJNVFdyeE4x?=
 =?utf-8?B?Wmtwa0NGQ2VQVVR1TWZBd3ZsVXduSGdDMEFDVW93Z0NWb1c1S3FjWEhRekov?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rqsgSn2TMQcKxSIDYs8tkhmfNwKAbqLnhdOwCpoYIJgAtJ+mKanGLBBtPu6AOtVUqROpov8y0QTqcpt8nGSmBXiJdlb4VoBtUa1uFKPh09GBptVTXntQq2o3jFMacSbN34KyCCjabA2mjLVVmDvyP9DW4RmFEgJ+IGoNQMz6fjtlTT5OpMn18WSeaQYwXa532CVRyBQuW8hUk/7msJhK7smHoUN4SSsz+YnYDqCINF+Am1ATlFX9K1tTKujJvUG2DetImzGbGf/sA3AGaGEqvfDVmWo7aw+Ml6W67O2/ocEk8auCPRyw2V6egwQNcPTh3jiqdfYReG4dezO/V0TKBFwx0OhBdIIZ+BMLIWRsdmOf9iu4KKNw/olZxIoB8sszolUUUp13rLBGGASUur8QB77w7G/hAlp6c+g1qIWoMKmsJusYsSAZtJ+DD4wmzPF6KrRvMiKzz8MRNnP9Pt4ir3IeyqXQxt16FD9LyRxZw18DmILvXdJm5iV19eOcCHXTrfLgXkcEmBfXVaccryEs+xKJA7xe3mayF2r3fCGuYhOKTaEl7B4Hmo/1iF+NiSi/+aNiiXne4qlRTgyOw9m6On34R732fpwYQyAtX/AtvoA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162a406d-0706-4d65-9cb2-08ddef792c72
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:16:27.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0y1F8+u9mbjkdBjQeC/rUULLgeJXXsaVWPo8YvuTqcRtc9cOawk5zwIwTonAfogi4uqtoNFHV4k4c9kYDVQ2Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090080
X-Proofpoint-GUID: ZmmVBjNBDcQtkXExlao-EUx2RoHL2tJe
X-Proofpoint-ORIG-GUID: ZmmVBjNBDcQtkXExlao-EUx2RoHL2tJe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX70+nwz3vwVHL
 s3U0dSM9K2yqARd1dkPn6EPqn/K6AuCtowYz7q+ItO5EVBlp2gPx9FsiCwTaP8f04LZEF6GOyFL
 AIOPX21WOBeNn14sCYS7AfElkWa5COblcovniNDieLm3+lxOICCEdA10fX1QE6Rl8w1LkgYwgf1
 ou72t71yB14BX7O+EcopNCSV68Ucu6RNorb76hjzaCOua/4NgpqwDF0KZLGhx3Ng+/H362Hg0mG
 s21SIuvvzFhh2DatXSqe+FMZxd5AT6A9ugTHw06BS7Ae0MiCigML25zTE5td4NyC8QnSpYdC7bj
 +WvHP9BxApU0xMOKAJ/pbodUyKsDSXBTLfXmQ9n8L9P8kQrHTiUle1tOWHotxn8SN4yXbqAifPi
 UDEsNZfJ5nKPRZB4Qj/2zfaLsM40qg==
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68bfe25f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=LEtnfFJRK95xkD0HXpAA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12084

On 08/09/2025 11:56, Christoph Hellwig wrote:
> Bios are embedded into other structures, and at least spare is unhappy

sparse?

> about embedding structures with variable sized arrays.  There's no
> real need to the array anyway,

"real need for the array anyway"?

> we can replace it with a helper pointing
> to the memory just behind the bio, and with the previous cleanups there
> is very few site doing anything special with it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

FWIW:
Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   block/bio.c                   |  3 ++-
>   drivers/md/bcache/movinggc.c  |  6 +++---
>   drivers/md/bcache/writeback.c |  6 +++---
>   drivers/md/dm-vdo/vio.c       |  2 +-
>   fs/bcachefs/data_update.h     |  1 -
>   fs/bcachefs/journal.c         |  4 ++--
>   include/linux/bio.h           |  2 +-
>   include/linux/blk_types.h     | 12 +++++-------
>   8 files changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index bd8bf179981a..971d96afaf8d 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -617,7 +617,8 @@ struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
>   
>   	if (nr_vecs > BIO_MAX_INLINE_VECS)
>   		return NULL;
> -	return kmalloc(struct_size(bio, bi_inline_vecs, nr_vecs), gfp_mask);
> +	return kmalloc(sizeof(*bio) + nr_vecs * sizeof(struct bio_vec),
> +			gfp_mask);>   }
>   EXPORT_SYMBOL(bio_kmalloc);
>   
> diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
> index 4fc80c6d5b31..73918e55bf04 100644
> --- a/drivers/md/bcache/movinggc.c
> +++ b/drivers/md/bcache/movinggc.c
> @@ -145,9 +145,9 @@ static void read_moving(struct cache_set *c)
>   			continue;
>   		}
>   
> -		io = kzalloc(struct_size(io, bio.bio.bi_inline_vecs,
> -					 DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS)),
> -			     GFP_KERNEL);
> +		io = kzalloc(sizeof(*io) + sizeof(struct bio_vec) *
> +				DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS),
> +				GFP_KERNEL);

this seems a common pattern, so maybe another helper (which could be 
used by bio_kmalloc)? I am not advocating it, but just putting the idea 
out there... too many helpers makes it messy IMHO

>   		if (!io)
>   			goto err;
>   
> diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
> index 36dd8f14a6df..6ba73dc1a3df 100644
> --- a/drivers/md/bcache/writeback.c
> +++ b/drivers/md/bcache/writeback.c
> @@ -536,9 +536,9 @@ static void read_dirty(struct cached_dev *dc)
>   		for (i = 0; i < nk; i++) {
>   			w = keys[i];
>   
> -			io = kzalloc(struct_size(io, bio.bi_inline_vecs,
> -						DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS)),
> -				     GFP_KERNEL);
> +			io = kzalloc(sizeof(*io) + sizeof(struct bio_vec) *
> +				DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS),
> +				GFP_KERNEL);
>   			if (!io)
>   				goto err;
>   
> diff --git a/drivers/md/dm-vdo/vio.c b/drivers/md/dm-vdo/vio.c
> index e7f4153e55e3..8fc22fb14196 100644
> --- a/drivers/md/dm-vdo/vio.c
> +++ b/drivers/md/dm-vdo/vio.c
> @@ -212,7 +212,7 @@ int vio_reset_bio_with_size(struct vio *vio, char *data, int size, bio_end_io_t
>   		return VDO_SUCCESS;
>   
>   	bio->bi_ioprio = 0;
> -	bio->bi_io_vec = bio->bi_inline_vecs;
> +	bio->bi_io_vec = bio_inline_vecs(bio);
>   	bio->bi_max_vecs = vio->block_count + 1;
>   	if (VDO_ASSERT(size <= vio_size, "specified size %d is not greater than allocated %d",
>   		       size, vio_size) != VDO_SUCCESS)
> diff --git a/fs/bcachefs/data_update.h b/fs/bcachefs/data_update.h
> index 5e14d13568de..1b37780abfda 100644
> --- a/fs/bcachefs/data_update.h
> +++ b/fs/bcachefs/data_update.h
> @@ -62,7 +62,6 @@ struct promote_op {
>   
>   	struct work_struct	work;
>   	struct data_update	write;
> -	struct bio_vec		bi_inline_vecs[]; /* must be last */
>   };
>   
>   void bch2_data_update_to_text(struct printbuf *, struct data_update *);
> diff --git a/fs/bcachefs/journal.c b/fs/bcachefs/journal.c
> index 3dbf9faaaa4c..474e0e867b68 100644
> --- a/fs/bcachefs/journal.c
> +++ b/fs/bcachefs/journal.c
> @@ -1627,8 +1627,8 @@ int bch2_dev_journal_init(struct bch_dev *ca, struct bch_sb *sb)
>   	unsigned nr_bvecs = DIV_ROUND_UP(JOURNAL_ENTRY_SIZE_MAX, PAGE_SIZE);
>   
>   	for (unsigned i = 0; i < ARRAY_SIZE(ja->bio); i++) {
> -		ja->bio[i] = kzalloc(struct_size(ja->bio[i], bio.bi_inline_vecs,
> -				     nr_bvecs), GFP_KERNEL);
> +		ja->bio[i] = kzalloc(sizeof(*ja->bio[i]) +
> +				sizeof(struct bio_vec) * nr_bvecs, GFP_KERNEL);
>   		if (!ja->bio[i])
>   			return bch_err_throw(c, ENOMEM_dev_journal_init);
>   
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index eb7f4fbd8aa9..27cbff5b0356 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -408,7 +408,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
>   static inline void bio_init_inline(struct bio *bio, struct block_device *bdev,
>   	      unsigned short max_vecs, blk_opf_t opf)
>   {
> -	bio_init(bio, bdev, bio->bi_inline_vecs, max_vecs, opf);
> +	bio_init(bio, bdev, bio_inline_vecs(bio), max_vecs, opf);
>   }
>   extern void bio_uninit(struct bio *);
>   void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf);
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 930daff207df..bbb7893e0542 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -269,18 +269,16 @@ struct bio {
>   	struct bio_vec		*bi_io_vec;	/* the actual vec list */
>   
>   	struct bio_set		*bi_pool;
> -
> -	/*
> -	 * We can inline a number of vecs at the end of the bio, to avoid
> -	 * double allocations for a small number of bio_vecs. This member
> -	 * MUST obviously be kept at the very end of the bio.
> -	 */
> -	struct bio_vec		bi_inline_vecs[];
>   };
>   
>   #define BIO_RESET_BYTES		offsetof(struct bio, bi_max_vecs)
>   #define BIO_MAX_SECTORS		(UINT_MAX >> SECTOR_SHIFT)
>   
> +static inline struct bio_vec *bio_inline_vecs(struct bio *bio)
> +{
> +	return (struct bio_vec *)(bio + 1);
> +}
> +
>   /*
>    * bio flags
>    */

