Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE027143726;
	Fri,  5 Jul 2024 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182912; cv=fail; b=de+Eo+9I+PkjUfPLhRgpXQosAXfFtT799kZKHYJ6TstrIf2zRVNNwDTzibRhG3NGiVmKlXVdYxiLMBTlYiomRMvZGwCJUYuV2VEwEij9btTbx6w1T0nx9hmOlrdIwWYcpcFheWMYgTqJVORWOHaU0JMudvrwvdpIxBmxjtT/FIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182912; c=relaxed/simple;
	bh=m8SfvUGet+YQaG3rxSZM+e51ckGF3WoBMXLjikAO6h0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Iz5aDJxYIOeB/gZvNRL2njVRFNIx9WtMu+ZGvKMOo10aq7y7bDWzjyHbyVMxzpF7i1+oKL+QG+C0D3Rm96+k7t3KrgsBuy3zZGmeyMZtwqSmC1z8oi+ItwdksBV7hRp/QtnuEqUIFImRjxG7nPsanhNBYduXIJfuZ1Wiq0+rEf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dERmH7x3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nqEw4UbO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dERmH7x3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nqEw4UbO"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465BfSK3012607;
	Fri, 5 Jul 2024 12:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=CEd/WOy6XXWIFP1zZklliHWdN18HX7skSk9scbEGSkE=; b=
	dERmH7x35sjvN0DavnhfYXreAnyFdvtDjx2urHPDbcVHNmCH/yi6qi2yyMg3Xe5X
	+fyDLFJ21xfCAoCYdIVGeoihdamLB2o9VRvwbD+EGvfmbjaT/VSsFhNDXUb6KnOT
	osZhJKutNztzcGvs0jdHvc92WEByChiz80aQaKEviwkwevLNRcBWPCcArfqdL/95
	avevc4/b51FFljF+KbRI+kBuyTBBhR3xJEFQSLtw5ulSUJNPdBI/KIcHliPlJ9Yu
	bhApSuULZI6hZXuEUj5e/GsmFUa+3EEvy4YH2R7nTQX/xp83rnR/+niBedg+C6rD
	TPi+LD17XsGIRQKBtCGzBg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aackxr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 12:34:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465C9eDb021526;
	Fri, 5 Jul 2024 12:34:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhdves-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 12:34:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4bAVX16s1fnj9rmF76/jfFF95VSobhKFMom0xsi8VdqucIMxDSCO6wLEpx/mYhcTpST72mtShRlz/XcLEBHa5ZNPlRFEkI6vVyc9o7i5z96RKzGM2nWX2qNbX1xC/7Y+S/Yd6V/TB+Jcw3p7C5noHqzxh+YGV5i2Pv3U1xW+eMGZ4fEO+8sjVSHJNz2hvzec1VGJOK0oCwkscTDyRxuhbltJp7wOyjiOm98ox6596maQU3sIcvrCrr6oWbQn/Vn0TXNaiWtA+CZWVgkDZ8LziyzcHQiFxrjlU6AmsAaFd2aBgnbTbqd/wgYRZcv5THgOOCaJ+7Rh2DVlcQuz3V0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEd/WOy6XXWIFP1zZklliHWdN18HX7skSk9scbEGSkE=;
 b=c+NWVdcjAU+g1sxiWrycowsz+rJhb2qrrCbad29Fy8S+wwgWY5TG2mp2BjCZaMuf7VYHLM+nV0cB8j76Yl7qm7SxdZOyYO4ckWzyQ+BbtelrDmfQ+ts4Zuakgl+v2WNFH323yTVnY65uzw5bAU2+NBR4ITecFrTQplHFiy6Y1782IS/KYkEZBWMVlfRKt1XFl0gN/BL5PGO2t09/v5ijzKy1bmF4NkW1V2PM1OoA3WHGwf4g2ZkzBwwoqcThG6i9BJkUXmdzf+y9LETJac2qJkNjqSh2MTatK5/Ath96iVqBoHeldrptUnTjO+H+wOVQb6+Q/kuuBSOgpPaUHFlCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEd/WOy6XXWIFP1zZklliHWdN18HX7skSk9scbEGSkE=;
 b=nqEw4UbO+9V86FwnALR23jQF85SJiKCvwE0afm1lF3KjY4/Sobshtz6vDEj14Qnw00y2G0UIIFec/Qn5WR6Rh/6eurQcNc7TzICqs4ppSOT9BWxVt9G59+WUhkztbCZKnnUt1JHChLy7BBajwOWkhTXcduABg7BQ4CRDScCKfpI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB5734.namprd10.prod.outlook.com (2603:10b6:806:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 12:34:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 12:34:43 +0000
Message-ID: <d4f02398-977f-47ef-9868-d3b08313c126@oracle.com>
Date: Fri, 5 Jul 2024 13:34:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] block: Validate logical block size in
 blk_validate_limits()
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, hare@suse.de, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20240705115127.3417539-1-john.g.garry@oracle.com>
 <20240705115127.3417539-3-john.g.garry@oracle.com>
 <20240705121600.GB29559@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240705121600.GB29559@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0121.eurprd04.prod.outlook.com
 (2603:10a6:208:55::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: c126a8f0-c169-4c25-49db-08dc9ceed8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eHVkL01hNTVYemlQQWlJZ0dvR01aSG5lV2tUaDRTRVlla2JHT3pKSUo2TzFJ?=
 =?utf-8?B?TkhrSVp0eWNSdHVibHdFcG5reklhZ2FkOWNHWXBySEo5N3kxN2JlOEIvK1dX?=
 =?utf-8?B?RUoxS3JQMnVjMzk5VWJKTmh2cWtIMlpWWG1lYXZTN1hhZitUYitEMjYrRVAw?=
 =?utf-8?B?UFZpTmQ2TEFPWTZBMDFQVjZObkViT2lDUkZvSXBwVWlYUWFvL2pQUHZkTGhO?=
 =?utf-8?B?Vm1NMDVZc25vVHFsSEJWRVJXRVJNYXQyVVpENlBtVm03MkhKVHBqbmFYOXdB?=
 =?utf-8?B?NjlXVHFBd25CM3BrakgwL3FvSlArbzBKSG8yT1NYVitId3VBVXBjaFNGUUxZ?=
 =?utf-8?B?bGpyVytva3BoWktQWWo1bUwyb3RpL290Sm93MHNFQVBSUWY3Q0JUYmZOalVp?=
 =?utf-8?B?K1ljc1JyS0dLS0UrWXVBZW5yVDJ3RUc3S2JSbjFZdUtwS1NpU3lqNzhHbmZL?=
 =?utf-8?B?S2M4K2JGUW4zSE1IU1BUbmhqZkg5clZwNnQzUW1PMGZpUDUrMko5dmVIcStF?=
 =?utf-8?B?d0ZFOUF4TlY0azFxVzFFY0hObWRLUTdPQXIwQXlCVkhhaG44d3JleGtmWVVZ?=
 =?utf-8?B?TWJucXZTZEFhTDlpTWlqMERWS0RJdGgzL3dSS0lKTzlYeWZJSGlibVVvWDBH?=
 =?utf-8?B?by9zekVRbU1iTE43QW4xdWdZYXR5STlnRml6T1hlYk41UlRoVmluWFN6dnF2?=
 =?utf-8?B?M1hPZFFIQWE3c0ZEeHJUb013aXpWekM4bFUyeFRXTTJhbmtXeEU1Mm9PaE9V?=
 =?utf-8?B?MmpzOHB6cXR4S3lBTmpJdHdkRmYyYmJETWNNa1h4VG8wdVVuRVBnWVNZOUxO?=
 =?utf-8?B?Snp6SERnWXQ2UGVjTWp2R3l2K2Qrd2FsSlJ0cHl5SCsvSHIrK0ZMN3NTLzR2?=
 =?utf-8?B?cWc0VEdMR21iUy90alVOMUdGYzBYUW1iUzQ1L0ZIMWtsMkd6UldLUnRIUHdU?=
 =?utf-8?B?Qm82OXpMaVZTMFczRG56OGsrM0NtZEs1Y2ZGRUZRdGVnUXhDVFFoWkl2SktQ?=
 =?utf-8?B?N3FHbFhmNEw0UnFlaHRuZStBcE9RUGd0N0t4bGFLeG1DQllab2pMMFRIMjB2?=
 =?utf-8?B?dnh6RllRcnlORmxlZVlrN0VISWY2OWpNWGZBZHFZbHZndE1uVk5DZUdLMXVO?=
 =?utf-8?B?TEVCNTZFQjM1bDhtN0RJSm5YWkFOdlZ0U3B5dlQ0TVJZb04ralZsTHBkZi9O?=
 =?utf-8?B?TytkNWhDMUI4dCtzcHMyQVk2dk1BaDR5UEwxM3BMekhwdSt3MHBZS1d2YjAr?=
 =?utf-8?B?TnZQY3hSTkl2OVhKK3lqbXlOd0U2RWM3S1o5LzNxcldkZGNYdzc4bVNaUE00?=
 =?utf-8?B?dE1nY1gzUG9KUmphNkdlODNoN3lvYnF6RTArdXN4UzhSVW0zZ1pDdjE4bEZO?=
 =?utf-8?B?aHFVRm9oSEtUanBSbFFyaUxhWks2SEw0T3pld0Rha2VyMWVDSnN4WUJ5U3VZ?=
 =?utf-8?B?WEVTcWw3ZXdpZ0FPZXR2a3hrTHdWbnNtdVh4d0NGS25QNDJFZmtjd1JIN2R2?=
 =?utf-8?B?SzhhWExxRnVjN0p0aEhvb3B0T0g1SVdkS00xbkdKd2l2TmloM3VJYmNCT0o5?=
 =?utf-8?B?bDAwNlZwWFByR0UzUFp5bjJCUnlkSW1wcUFOZUxZZVpER3dpTXRsRWJIcCts?=
 =?utf-8?B?S3R3TzBRZ2IvMFdYSk5hUjY5N0FwcGZiaTY1NkViNmJHcEZQd3ZHZmZUZlZN?=
 =?utf-8?B?ck1CQ3lyOUpzaEpHcE9XYWRabnpiVmM4c2xhZUp5ZE1uckVpWEZ0clUrT3h4?=
 =?utf-8?B?VUxwbGttWGY0QnhDeCszYUdsOTIxOWVJSWxuSHhuWStLV21JQkJ4R1ZNNnJm?=
 =?utf-8?B?eGJMNzE5bDhWWDI1cU96QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dURlWncrRmEzSktzSkkwL2FyTVdUUjVPWS9vNGd2Tytrb21BZDVkMS9GazFJ?=
 =?utf-8?B?YnNOSkVGOHJER0wyd3VnYnlJdUtGWklmY0liNnd4eFBtYzRnZGcvMjkzcEIw?=
 =?utf-8?B?NVBreW8xamhaaWFNdjBXaldPSksrSjJCdUxTY2s1MzZxZVJ1Y3d0ODc0bThE?=
 =?utf-8?B?em1oTSsvVnFRSkc5UG1wc2ZCZjFLNWYvbzgxcUZoMmo0V3JwNkxQVlNLcVZt?=
 =?utf-8?B?eUJRNlh1K1VhcEJmbGVKS1gzeWkxY0VJMU40Y1dYd2ptanVrc2gycmRWeTRY?=
 =?utf-8?B?MGNjenI2UDhLeE81bWlkUEMxeVV4d2ZVSHBoODlBNFQwUUQ2S0xRSEhDV2FB?=
 =?utf-8?B?cjFNQjAyVlhsd05zaENqVWhtWWJYQjBsUktqdk5JeUhRakxURS9BNkd1VjQ1?=
 =?utf-8?B?VWI3RitBK0RRL1NGRDRXK0ZWdDlVRzRJVkdIZERZcTF5Vi9MRzB1K09IZDFW?=
 =?utf-8?B?c1h5amgvWVY3YlBINXRNb2ZncWt4M2JMdFQrQzhjQks1SHZrZHI2SkVMc3ZE?=
 =?utf-8?B?MjJKTno0WWlWYlRHV25NWFZKV2wrR25LeFp0blJ2WlQ2bUZ6R0xYSGh2Y3JR?=
 =?utf-8?B?cU5RZVh0M09xaWtMTDh6Ym52WWRIS3hCc3VLTm1aOUZRcU0vOW5Va2FER3VT?=
 =?utf-8?B?Z1hNYzN0aFhnN0VqbWxkWHJYa0dIMXU0MkQyakVIU2IvRit5RmtGbFlGR3ZU?=
 =?utf-8?B?RkV3a3ZKWTIxQTdCNS9NVmlqTndONi81Mk9Uc1hEYlM0ZlNHM2ZRcmIvbmRs?=
 =?utf-8?B?VTZBdnhUbU9RWEE5b2lDbWRzYXYxQWdRVUFrNm5UZ2pqdlc3bkJWamlKc05K?=
 =?utf-8?B?aHNYKzRTcSt1c0FLMng0T3BoNmpTUkRuRFFBVzljanBZaU5PeFpXUzc4YTNO?=
 =?utf-8?B?cnh5Z240QndXd2ExUHlVWWxvLzgvODFVL0F1NUt4aTRkQlVzNjBtRTZLWHBz?=
 =?utf-8?B?dVloKzF5NkpiMkFGa2pzMk9lMXUxbmRDOVpSWWhqdFIwa21BYWgwcGVHb1ZY?=
 =?utf-8?B?TDB3M2xVeWEzN2pFLy9wVzVqakxZU0N5YUFkRGdJU2svNUtkbmhhbGtxVzlT?=
 =?utf-8?B?LzNRK1o2cFltWENzakx3WEw3cEhOTjU5WUlvdDN6dXd4NzBRNmJoV2Z1M1NG?=
 =?utf-8?B?WWMwa0xqSTF2aU83NGFyK3pPTjlQWGtJZmR5TUlFemlCbVlsS25QbVh1ajEw?=
 =?utf-8?B?ZDdFblJzKzlHU2xyRTA0dlJETTMzalVDY05uRUVvNng0MC9tcDN1SVhuUHpK?=
 =?utf-8?B?bW90VFhZWENXSEsyV1RXR3BBK1ltZ3lLU0xlNFlOZy9vYk5mWUl6dXk5WE53?=
 =?utf-8?B?cnZJS1lhMzN5b0FibnJ4dGtTSHQrT2JHdVI2OWlVc1djUXZad3IyUUFaZy9R?=
 =?utf-8?B?cW1jZ0lTZnArTXB0aXlUdUZERFFibkNQM1k2QlYzeHdrVTVMTEFpazJ3cnJL?=
 =?utf-8?B?dEtiK1pnZzU3V1Rnd2MwZ2Zva1d1SU1CMFEyRTVMdTBrSmZ5N2J4N0dnZ1Vj?=
 =?utf-8?B?M3AvSERKT0dVd0UvZE9EcEpzS0h6SGtxT284Q1B1bXZsdWNuQVR5OTNRNWc0?=
 =?utf-8?B?cFdQWDN2UEVoZkpCR2poZ3lzVk9ZNVloWGpRejZ6VUZlcE12Zm0vTzR1N1BR?=
 =?utf-8?B?N2VWeUprb3pvYUozcy9PZWtFQVF5WVcrSVpuWk12SFoyb2s2NER3MmRra1lH?=
 =?utf-8?B?SWc5cWdtc0MvMllra0pyd1hydUwwSUJvVGVvaWFUZWx6d05XejFlanYyc3ZV?=
 =?utf-8?B?eCtFWTA0RmE1OEFFS21BbFUvL3pZbzdXRWExelBIQUhQS3pkYUlQaXlQeUdj?=
 =?utf-8?B?bzNjV0ZMMmIzT2lzcFh2TGJSWGp2eUlZcHI4KzhjNFk4bGdCV1pNZUVLTlc4?=
 =?utf-8?B?ampwYXdwY1FnU0tsaTZNSzNCazVpeExkZmU0V3ZDNXM2NEx3RkVGN2x5MDVT?=
 =?utf-8?B?L3BqYTk5bS9TM2x0UU1jRXBUMTMrK1lmL0VwUVllSE5tRjY2ZFFSbkxPL2tm?=
 =?utf-8?B?NlJjc0VIWUo1L0RUUGs5WnFqeXFlTk5BY0RnSGZvdG5xN1N5cDlrYXVPb1hB?=
 =?utf-8?B?NGt5S1Jldk9FVWx5TzQzaE1jUVg3dHlUeDErTC9ybnpPeDJqbFhTQXhobDhT?=
 =?utf-8?B?ekpxTHZaZmR3NGsxT0FnelZrdzdjdjlaYng1c0RzY0JzNHFWWFE2QUJieXcv?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jUYsqG6L0+wIgg8Z++jA1Jf27o0hNAFNIEPB9gUmGyBW2HGwSLrB6G+E/tN6ln5X5MXkaDizKSYRKXDcutljVBvqqr45EOPxvveUI8Z0Lpg8EE9ksb0XdX3Cp+B7R/R0ozDwmSakcNy8qdRUViqdNw/5DP14/t84GmXP0qzfnmaLh//moh2N2urkF5q+jCm4jJnKn+/vARqI/FuyH/a79TEmdiBQyONLfMvoJGThuhAIehmriJdVGjnRtptZ9ao3iXtDPDSfu+YTnA8Fvi8gLx6GyEJtWpUOm0vQzG+ErraN/L0f/7NsYWf5MpMSl8z++gwwNN0dv2JAX0klCidIaAliFm+iLhtjE+5uQTnxibhytZdsG7J0H2Oli3tq42C01kwAKRsAn4ihvkL9PjLkn8slGnpTcwHU/hsA5an0DN/0v2HhN9Ivouc2j0GVT3WpdiTkwxHv5SJ4ZQgjjYoL+o56qHvYFfgsbGf2rG9+MANIB1uEzN4EzKumvEnmByiYMsh3pKKhd5RJoL1i12BydJZaljCu+aecfyeMoiKT6UKN17wRphy2RGCtvyrkFYY+7OMffIll3fdu13ZQe2Zai6PiXm2fxVndn2mtOUqPIlk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c126a8f0-c169-4c25-49db-08dc9ceed8f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 12:34:43.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTgG6lcx2WFr79F7aKgto+4b23KYrs5qZBRYX1/2s4o+40lLXZDR/MOti93tMKn17ORCXdfU2GU3OALsxFFXcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_08,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=996 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050091
X-Proofpoint-GUID: fpYSEYXUngyPRCWSpLMJTEIdNMDyI5zN
X-Proofpoint-ORIG-GUID: fpYSEYXUngyPRCWSpLMJTEIdNMDyI5zN

On 05/07/2024 13:16, Christoph Hellwig wrote:
>>   	if (!lim->logical_block_size)
>>   		lim->logical_block_size = SECTOR_SIZE;
>> +	else if (blk_validate_block_size(lim->logical_block_size))
>> +		return -EINVAL;
> 
> This should print a message.  Unfortunately we don't have the device
> name here (for that we'd need to set it at disk/queue allocation time,
> which will require a bit of work), but even without that it will be
> very useful.

Ok, I can print a message, like:

	pr_warn("Invalid logical block size (%d)\n", bsize);

I am wary though that userspace could trigger this message from the 
various ioctls to set the bsize.

> 
>> +/* blk_validate_limits() validates bsize, so drivers don't need to */
> 
> maybe throw in a usually or normally?
> 

fine

