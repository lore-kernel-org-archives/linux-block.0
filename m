Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8627913D61B
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007750; cv=fail; b=As7k6AttdbKGwGD25hmwzRDxUE7vY3RGhnSUGVBjLSLK5B3sDQ7zRT+n82WMPaPV5Sy9tJxh/QF5Fdh8WY4IhrSFlY7XiLh70UtANsJzjG4lEw6AGNtY/O8EGGRqS0okIABYYQxUvXGx2SvJ8zEJepUBRtgWeppgBHcDRCKg6ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007750; c=relaxed/simple;
	bh=kwqrvT0WcZViRCBDPdXI5GnDgD1wTM2PUkPfHtdwj/o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XKobplAeavosQokbgJOs5m70xbcMCJJgQFiTCtolZhnlvC/41T3jopa0QERfCDs61JpJORI8/Q/04iHMLlcgx6tBik7OdrZuZVUUyfN3HJgTon74SUME6LLh5vjp9Swb6+XeOqdJpbqBIRNU0GgBjSJQGYMVhsHQMtHzW8VlAks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CheuSRZF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eShB/QuH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CheuSRZF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eShB/QuH"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638O91T008124;
	Wed, 3 Jul 2024 11:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=R5Iw/a4z38tp0sZTxRbF73NUdQSqeq45T8YbyTB558A=; b=
	CheuSRZF6IYJg7pVK20M/VUhY2S2pKC/e9JQGEwiCpxZ78rN8kZ/Qw7yBZyMluLx
	t1dX2hMgADaTzxR91fNKt5F+tORzmo146ogBpY/uduMFuFqrNv80zYrSJTeyoHox
	cQ0uERFNFToXfVZZ9nPRo+XYXdmFMJybZsMwsZkNK74pHuTORjeJIJcwQV7cpq0o
	u8mUfRjmc5m6TAJTkBTXSE4q9yVXnVHTR7MkFNEp+yS0sKQ1gUds3rDP78LeFjce
	QC94HVPh+1NU3r2y9K1if0xUI8Epy0xJCYm0QXc+YkyBrJDWHws+fMP5rODYgT4i
	18RyGsDH1EeYb4i2NZL02w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0r1p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:55:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463BLqJf010422;
	Wed, 3 Jul 2024 11:55:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qfehvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjM9Gyt766mpiY3BIGwYw4rBQctjZYG1H/Lj/67Js370lSRdYgUu/ocggJw+KMyD2B5xjHLCCrBxFTyY2d+y3JgWmLjaNch6QhC84UmrdhrdlogNP8OxNHmv2WgU/efI1X4HfFzTu7343NppweL3bp32ImzB5pMNMuAGC5s1jfE1Hwe1W1TUv6omeMf289UoOAidDMInqH4BPOOqr/y8HYSuTfwWRjGLuBj1ptykZut5GDJWR4ps/ECX1NB1fxyiUHOWA9EiJLwwzTRrBACVuJ/fh0B42QVy/t7MWGtip+6cfYrqTSxlNG+MK06zp01pOuC5E0jPLH+J/P4Kx8Ixew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5Iw/a4z38tp0sZTxRbF73NUdQSqeq45T8YbyTB558A=;
 b=Agiog6ug8TnH8fYDadDXL0+UJWm/1BIDJXXO5u0E2Br//TtguKkvALugSGc+eML/cvhuWMqb/wm4LQF+iLtTl04XqNg67ylOTu/5Dq4wueEwwa989f5kOa3vigZVUdGVYwnGXoBA/XSNH1M+l8uB/Lx/pj3zAY+3EQR0jTfja/fB7scQmH+k3en7noK9M4pEpqbkrtFXc3AgmRhRt06Ei28n8sNNkDqrlgnhvNI/UCJEm4PrNMGj0WTDSe/rxV801vcIPIzvM/K4z7ZQ1gsQTdP/HYTj77Z1DC/jIpbD54oUuSb4hICXOJ7fpILEtbC1fYhkS0JsWpTNrOc0u4nzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5Iw/a4z38tp0sZTxRbF73NUdQSqeq45T8YbyTB558A=;
 b=eShB/QuHA4Os+2RKgkYTYsf1kMC7XFX1l0EOpSSvm5ACfhaxcwqduN/vUDvmRSpHmJeOpnMNqzebxh3lfq7nIFEoV7xjMj55emLDax1VdFmWzVMubDxurjih10phZS2WPbGGVjV+l0r3tByLVzOT9Lz3eJYp+JkLjxWdd2t8PKE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6732.namprd10.prod.outlook.com (2603:10b6:930:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.36; Wed, 3 Jul
 2024 11:55:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 11:55:40 +0000
Message-ID: <41cc6c36-d1ba-4010-9334-55e061eae5b5@oracle.com>
Date: Wed, 3 Jul 2024 12:55:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove QUEUE_FLAG_STOPPED
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20240703051834.1771374-1-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240703051834.1771374-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0232.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: b2274179-f9c2-4da2-1619-08dc9b570f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WW9JU2pVbkpiWCs3OGxycGVDdWFUdWRYUFJ5cGFGd0NsTktqM1BEZlMrWkx2?=
 =?utf-8?B?NktlUmdNWFF5cG5aakQwaDhaNlJ6TkxhY0VlV0s3OUVnYXd3UVRtZTI4eVhU?=
 =?utf-8?B?U1pWa3ZqV1pOdTAxZ2h2VFkrMEYwVVVEZVhwWnMxeUN3K3REajJNVXFyY2l6?=
 =?utf-8?B?Mml2Vkt0MWxyRkZTQXUyNnFjUkh5OFEvU1duTE9HOXhJWDEyNVBBanN6VWRR?=
 =?utf-8?B?Z1RaaEFKSVBYNVBzWXZvQStTc1cyWDkvK0JFRzFhZ1ZSNlVsZ0RlY09YRjIv?=
 =?utf-8?B?a29sSGdFMlI3T3ljdlM5NVloNUxGVC9tSWRPeGFvRDRBYjZyc3ZOdHdIL1N0?=
 =?utf-8?B?U2tTOEtSRWh6MnZQcmFDc08xNmlLRmYvSEtxMXBWeVpHa0ZjYWxtM25GNDBp?=
 =?utf-8?B?NlBTRVVNb04ycERKTVB2aURjYWpRaDlPaHFyVkZVdStUTjVPOTVxcmsweVp5?=
 =?utf-8?B?QkxpN2tiYWpOL2JTKy83dmFCdzNqYi80UHpnL2FBQ1U3clNpbzhEOG45NjZO?=
 =?utf-8?B?NXlkSWFMbUdpQTZJOTFWRHJHRU1HVndmY0NTM1MwYmY5L3M0TnA3MzNQMlVN?=
 =?utf-8?B?VDN2Z0ozN3R0ME1GeEJ2Z2RZV0tZaUhZZlZTQkpJZ1lQUnJVeXI1QnBWRHhx?=
 =?utf-8?B?STdxdDVsbHdBcHRYM1B1VS9yNEtoSk0rQ1lxZTlNaDJFU211dFVHS2kybVZO?=
 =?utf-8?B?VktDbXVDUGRtMVRHVTlaem1qMUxGSHk5OEo2TS8wTDdlbU0wUGNuN0cwMHlk?=
 =?utf-8?B?WVV6WHhBaXlVdXgyUXVZL05hbkFiVFppd0xRYVRSbFdyQ0tOQVlMaXEybDE3?=
 =?utf-8?B?dURUc1cvVkJjOUs2VmhnNVFua1BMNVcyQW9XeEp4VnJ2WHI3VWJ3Ky83M0RO?=
 =?utf-8?B?Zjc0Tk5RWFNZZDFCWDNsejBJbys1QzFzem5OZHE0L2Rtamc5amR5cC9rS1F3?=
 =?utf-8?B?R1ZFK010MmlFa05jNWNiUTgzeUdYSXhXbWo3eFo0bVV3bVZIQWxJUWhvRnBi?=
 =?utf-8?B?RVB5ZkNSNkxSRU5TdkZFdmpVbjRTWFlWa3p5OEtOdnY4QXNwVC9lM2tPVWZr?=
 =?utf-8?B?cCt3RnVKWExLTGxJYy96eW1OMmljOG43RlVWZU9JL0Z4dXZsekd2VHAwc0Fi?=
 =?utf-8?B?VkNYek5nL3Jya0NxRGkxSnZXSm5sN0JTdXlFRFVBUmFmRjVjSHcySEgvdE1a?=
 =?utf-8?B?NFkxUnlqWld4MERkc0ZUU3JkY2NvS3E5NG9hZEpKeDkwNlNCUkx0WXVzVS9R?=
 =?utf-8?B?NFdXSytjUzYxL25rSlRNT25GUXN2TUpiR1B1VE1oZVNNZ2FJckZRcGViR2Ri?=
 =?utf-8?B?VFN3WTBIWkJiY0QvRTY2Mlo5WXVrU2V6OGIxbzErZWNod0VRWnBhZ0FOWHBq?=
 =?utf-8?B?ejd0dnlKZmpSaUxtV0ZsZTF6SE9GQmVrK1VIMlJkMnNrOXVXNTBZTzhTeGFo?=
 =?utf-8?B?ajJ1QVc2cHZ0amJiNUtRaElaV0QzY09GNXE3N1N6eHpET1BYWkluc01uYlVq?=
 =?utf-8?B?anVjVHVaZEFDSmlGZ1RrRTV2NG4xYWluekUzR0lHaGFTYjUzMWVOVXo4UUxH?=
 =?utf-8?B?SWJHN1ZMZHdUMWdtV3ZvQ2QzNERlYlR3NlJnZHgrenBwRlA5VWhKNjE4S3FG?=
 =?utf-8?B?ay81WHhBZEVFU0Y4YjZKMjVXaW01T0pERVEyaWd5d0pRSHJvczhyRm1SWU5I?=
 =?utf-8?B?K0t5bUZrQlZoRWszUllzcE1KdnBMNFpTaU9IdnFCd3VvUlE3UXptbG8xRFdp?=
 =?utf-8?B?Tjg5aEpEWHZ4ei9BbFJCQUxCT1IyaEtOTHVzTUNHakdDRFJpMGY1TzA4Um1p?=
 =?utf-8?B?a0FDNFgxYkp2ZjgvUHl6QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWtyY2RFSTQwMEtndWhYZFpseks3aFNPNnRIT2RPYW8wQmkvYVB5K1NHejhz?=
 =?utf-8?B?N01yWEg0blMrT1FqOHhPdDBlYzFpcHVMekp3RnlNcUFKVXkyNFp4ZlBveFd6?=
 =?utf-8?B?ajBkVUVqQ3k5MWljUFR1WVdCLzAvU3kyUDFFOWc1b1NYMzNVTzB5LzBjMUZa?=
 =?utf-8?B?TmJXMlBjUDFTMm5kWDVJVnZBUSt4Z1NuSTh5T29NMFdQaGRaSHZ2djFtbmlz?=
 =?utf-8?B?eldsTndkTzBEMUZmQlU4OXNwYU5Eemhxc2hPZHA5K1pFdFNxRkxGWFZKRFBt?=
 =?utf-8?B?TG93dWQ1MXF5NFJadHllUDNZSjZ1dGpiQ1kyNUM0bDJwazdhbk5MOEI5dENh?=
 =?utf-8?B?QmIzZUNRTWg0STk5MmMyVGEydzhueUV6UDY1SVJDVUplVG5sZTNSQTJPL0dJ?=
 =?utf-8?B?VWJBVkdSOXk5Zm9wUWFXS2RWcHBUaGFmV0NodmxlVjVZSUtPenVlbThrR0hZ?=
 =?utf-8?B?d09OYjYyZ080QklQR3Vod3RXSU53K1h6R0ZpcHFnNW96L2JpWTdFdnpkK2lV?=
 =?utf-8?B?cHc2bCtwYnh1bitzbVovOGFUS0xHcWlYeUU5MkxWbGcyU1o0UjRCaitJblRT?=
 =?utf-8?B?NzYrK2JCY3l5cnBLZldPRWg2NzR0OHVkMVBISkMxU1ZjNzQrOHk4dkMvUmhZ?=
 =?utf-8?B?OGRWQjdHKzhqMFJSdHNNdjZLQVBtNUcwMzBPN2w5QjhLR2duSzRpTnBmQWxM?=
 =?utf-8?B?bWJ0dW40YmRLNEtZS1dIYzkvNFd1UTh2ZktucXhsRjY3c2hhUm5kYnd3ZGs0?=
 =?utf-8?B?Vytza29sR3dLd3dPcG1JWmtqZjlXVFp3UGdobVBGd3Fxb2ZKK0o2K1gza1ZC?=
 =?utf-8?B?eStXaktpalR0Lzl2VVJXazVHTjdDUnExTkZFaDlLb2RiSUJjdythaVZ4L1dB?=
 =?utf-8?B?VXhSNlIzSzVZd01oaS82Zys5NGg1Y2g1aUdIUzh6NkdQSDdEcHExZ0I0WGhX?=
 =?utf-8?B?d3JPMXJxbmN2Tmc5TWsvZDgrMXRpcTBZZTVvZWcyY1N6cVhNa2pPZXcwRTlo?=
 =?utf-8?B?UWlKN0dHSnFhR0VjVGlEVlR4b2hDRU1MemlUQ1dkQUNtN1IzQ1NDNUZJcGV3?=
 =?utf-8?B?alJNNVBhU3B3SWxNbUtRYjMxQWVrcUk4K2tja3pkWUZxcmtqbWVwcS9SdmJl?=
 =?utf-8?B?Q2tNd3QzUndncXBhNWljdUQvZ3NDS0wyQmpjdUhidkJXS2dZb1lEMmZ2aU1N?=
 =?utf-8?B?QStacVViajJveVZKRVo0T3NBOE1RcWFQaE1ZNG51RkJxSWZRS00wa3N5SFU2?=
 =?utf-8?B?TjFETjdmSTIvcHBiVEFYbTNOSVgyYk1ObUtrWVhyV3RELzQ2VkVubVhPdEkz?=
 =?utf-8?B?QVhJN2tIQTV0dEN1cmRHUUpiZ0IySVpBYzZSVHZXREVsZE1LNWxZYTZoWWEy?=
 =?utf-8?B?OFN5UXFzTnZ0OGlHMCt2ZURJN3hGMXBWYjNCeUFjRDdYM3IwempFd29MNlow?=
 =?utf-8?B?UkZLU1lVVUZaUHU3S1c4aklZSEV2dXJXY0l3TUJOc0Y1dC81YWtEdjlzUUd5?=
 =?utf-8?B?aGkxaC83blpZL01yVGRLTWhuYWtlTzhmTXFMOTMyRXhackJyRUF3TGloSHE5?=
 =?utf-8?B?ejJLemtRMXplNHpHdG10L0NCUytOSGF2VmVCbm8rT1hnNGdFQ0JLeW9yMlE1?=
 =?utf-8?B?dm5yL0hRMldZZUVIRURSVndHekI4Nmw2bmJWZzVZd3FMdDV1eDdsWTZtb0Rt?=
 =?utf-8?B?MjNHc1JvNGZGQzVPT1ZITDFrMlRrWEUxSGJPOTBhM3NhTDY5STRkR095Tzdq?=
 =?utf-8?B?Z3VlMnhvQWhpYmQzVmJ0cGNoY2YrUitoVkMrRWNaUkxRVEFlZW5aNjlIbDlD?=
 =?utf-8?B?Wm43SFJudGRZNEpTcDNvQWlSdkp5L09qQmhJTGg0akJFbGtzOXVQY2s5S2xK?=
 =?utf-8?B?b09BdlFiMkFFdXlFOTRXRmRmNVNCTXlzeENXbHpPWVhLcGR0eVhFNXlRRmJI?=
 =?utf-8?B?SXhERWk3VWtwajJuZnRDdnVNS0R2R21KeERjeUFYNDVjSDRDVXJiODduRzBq?=
 =?utf-8?B?TmpiUmQvVC9VcWI1VU8vVFJJZVluRmNFV3cvckh5ZTJJUFNRUW9TaVJqZDF6?=
 =?utf-8?B?ZDFvbE1SUWx0a1JJdGQzQ3hPZlAvRkZLWXJuQnQ0dG1rMGo2NUIrZjgwU2Z1?=
 =?utf-8?Q?qPdZLElmRnym0leKSHC6CzctZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	noLP5HBN8UnSuC6WbAIy+hk47ggLSCZGNf5WBemcjXOvRqtpNqBcPxJUF+cLAxP8HN5BQ8UC25BSFiDMYqu9lQ19IKxzlFPnKdG5Eyc+RPGscjeCdwH/Rcz/iOE8w/FGniG3cOoSzzahafdfsPTn3VkIa3tNYa0cj3LIfH3CX3e9j8ODhv91g0w5W9WZedPqJMLWtLnSmruYPggGZVCFrEZc/5x3GRc2p9cvYxgMn32dh4RwSWkBJ4d98gTKv/9vdUOkb5gczG3VC6Z9Z2rf0VjtROijD6OG+kqHa89uXOIRnf41SP6QUWRflM4AHBnl9KZgP6p675pizJYfDjRaNjQOqRwhHQy3HSMogkDwshP2XGRSjvhPhQ9+4dtT1RxpEND42ZtnA9bdQ4qyxJifnBMI7K3qUugHtyKvC7d7Eg76ZnOspryb4kROeKtOpJf9KcMXPx64Pdeg5dvEOpL85S/n+p/tOCXJpHxPZ+VMKlMTq4Dw1HCgLIx2NYUGP1G2wJG2jD4paFcXpq5wAVVK/pgvdstlFUMqE1P82av21+7lhAPWlnu1PwjbKFuUqL9/opu+GwvHqL51591D6NkMmlNibeRzG/RLpZIczu+eQg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2274179-f9c2-4da2-1619-08dc9b570f72
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:55:40.6087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtpSWffm/mrfWPEM4k/1fuPIyit8ys1WrsuuU7githKNXGTC5Zh7vfN9hGuUdHRUobqlo0p0jqFUoRQn9KFCMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_07,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030086
X-Proofpoint-ORIG-GUID: NczAhsiyGJBitE5lSdUSo20kznoJCsdu
X-Proofpoint-GUID: NczAhsiyGJBitE5lSdUSo20kznoJCsdu

On 03/07/2024 06:18, Christoph Hellwig wrote:
> QUEUE_FLAG_STOPPED is entirely unused.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq-debugfs.c | 1 -
>   include/linux/blkdev.h | 2 --
>   2 files changed, 3 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 344f9e503bdb32..03d0409e5018c4 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -79,7 +79,6 @@ static int queue_pm_only_show(void *data, struct seq_file *m)
>   
>   #define QUEUE_FLAG_NAME(name) [QUEUE_FLAG_##name] = #name
>   static const char *const blk_queue_flag_name[] = {
> -	QUEUE_FLAG_NAME(STOPPED),
>   	QUEUE_FLAG_NAME(DYING),
>   	QUEUE_FLAG_NAME(NOMERGES),
>   	QUEUE_FLAG_NAME(SAME_COMP),
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 4d0d4b83bc740f..26fb272ec5d3bf 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -590,7 +590,6 @@ struct request_queue {
>   };
>   
>   /* Keep blk_queue_flag_name[] in sync with the definitions below */
> -#define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
>   #define QUEUE_FLAG_DYING	1	/* queue being torn down */

I suppose that these should be renumbered, as I think that 
QUEUE_FLAG_DYING now needs to be index 0 in blk_queue_flag_name[], right?

>   #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
>   #define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
> @@ -610,7 +609,6 @@ struct request_queue {
>   void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
>   void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
>   
> -#define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
>   #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
>   #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
>   #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)

