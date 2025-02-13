Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A925212FBD
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442208; cv=fail; b=kzM0dp+xWoiDEydtPkSheuAiBE4/xgeXS+E0E7eUxJGSAFPwT8PJ5t3KzN7Tne4pgvyPkx5OeK2D4a0MGCYOO+k6L8uj5+NTpRjbb9OKTSULENbkm8c4+4gT6orOHqsbiEcgyLgd6aqW4m9Fc0mJkzQ9nkwLj0GwDn2eRma7iQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442208; c=relaxed/simple;
	bh=+9GUrlKe9GsjG31hTPhOcCrVezbhRNKAkLGDI4/wONU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LvXTnws8FWcttwtr3FRs10GZlYxWrwuG8w1SU0IrXQ79YxkiljYTl0YyVuwViZYQF5RPA6T/5rBujBNn5GCrA+olJxArF98usA3WYaoL12Nkh8mebisEvFF0XPYbGQv9R0ZdJxFLW2Uq3M++8pJJRKaVtR0NSDe9deGvmpN4k44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mh1GGtZa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GUE7eQHQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mh1GGtZa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GUE7eQHQ"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fW8w014322;
	Thu, 13 Feb 2025 10:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ot5SpfUL+tv13dspotxf+tsRV5IGAbgUQMl6uaZEAG0=; b=
	Mh1GGtZaUqMlt3Y8pV/cVWeWBwe3ZlrL6ktVkeBxRt8eaXUp2Evbck1slvxbL43d
	3OsrTRRsTqI79gIBCq7WJ1S69FZuGkDm7IxCkgi58Ln1cyh+2QZYvKLWgdI2ZLbI
	0fGUuP4FS6h5f1nuX4GEZOhD1CxhpLZLzZsKmIzZl45f9+DfofWARtAQraTn3wIv
	pu6ALEqftqIAfDEF7FaUwh6YTyYUe74Ao3At8eNpLNZdzy7/2vO7eoif+gmLwl+M
	+5P/j/37zvi4azlLThoDsg97tIIPpZm+b2EywWAemzuoT+Qrir9WlP52MDeR6IFV
	g6QYfzzJm7/l/YfKBIVErQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qysb7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 10:23:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51D9Fv8I009746;
	Thu, 13 Feb 2025 10:23:13 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqhtvs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 10:23:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SN/BP+rU9iEIzKBZsD/igYTeYNVYwQ65M5MKrugbVnazN1T3PtRl0PKRbiHHqsE+z9nSIYGIaMeVLRjF4G4JKQvs0RFW5qg3fvcgDrScNtHrJnU/fXNPXZDizhxQqv0u1pLB/SNwsTw22OefWDMSuYchUJxxFQQ2U6dkhGiv+6pZiX+td2f96r5P2000uLhuo/lDLXyKR10nncD4+H48hg5JqcfsYHd4LlgXF37J/h4Nd5paNLjM4kyTvpZYp7sdAYjCet3DTUYtmHjQLG+G48khUctZhFjNcPEoiMrUYC/jinzBz7l+nbXKKtstGRoWG09RSws6mRgJmL0OWIcjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot5SpfUL+tv13dspotxf+tsRV5IGAbgUQMl6uaZEAG0=;
 b=q3/FRJtAxFwAKaqzF+0OHcJaLc2KzrMdxjMtcrBiWdURLDA9oJx1vQ/raHM+sNGpLfDkAtgEZ0MmTDxw/Wt4iwI/KnBBvNqYTdg1IP02XVljrQJOk7Eime95VqIFVea97Ybf8eeMqrnU5cZfDHy9Htol3BC0fApjlbV0vnRQW+BtxqheDE+wkFXEj/ZEIaFpA7Fpx6hOrmBlzaUCN1l4eiEKtFPYV8+MgwvXP1Q1/7KpQX9VCnEvXdRadsPY+U830VDSND12G7PsWtCiu8PtFP2vsZjd6xLb/F4SIpxXMw8THjgmzABhbtJKEe0dkPetij738hGbfo/HRf2dPlKd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot5SpfUL+tv13dspotxf+tsRV5IGAbgUQMl6uaZEAG0=;
 b=GUE7eQHQUwQR4xOvOlv34NoCTzWfQHSdDOU7Z5tq79oZratrofVg1gyLisyAtFhLLnUM1AiJYEpnTKWB/AoXN1xMJzxAuE1/3A2xtG/6vDxXyMwlXaQ+lCla2/kN4LtOdVc/EyOaOqkfK42X9cUT4wDqK/m6jfsptpAfI62onGw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6536.namprd10.prod.outlook.com (2603:10b6:303:22d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 10:23:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 10:23:11 +0000
Message-ID: <63bdc82a-fa01-44ae-9142-2cb649d34fb7@oracle.com>
Date: Thu, 13 Feb 2025 10:23:02 +0000
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <faf95365-5b55-40f6-82f8-195ccc3edb9e@oracle.com> <Z63CY9rE7X8m3nmv@fedora>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <Z63CY9rE7X8m3nmv@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f88dd34-abe2-41e3-369e-08dd4c186aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0M2SFBNUUtEYjlCSXN0dDNIRGV4ZE5nNUI5eFhRSEFyTFFOOUh6Y3VVS09T?=
 =?utf-8?B?VUFBMmFQcW1TSXpOVUU3cDVoMTFzaU9jSzhVQXMxd1FCa0JyaklOOUdhcWJp?=
 =?utf-8?B?UWhxN2tQRlJOWlgvOFhXdXAyamQ5WjQ1VzZqYmUxOGRvcmlnS1RGSHYzSlBr?=
 =?utf-8?B?cEhCWVRicHprd3NUWkRtSVBFdC9FcWtMZ3NjMHlZM1lqY1V5cUdMOVU2V2NR?=
 =?utf-8?B?bi84OGlmb3RnbXJLc2ZkbEFmdlRQcHd6cWNCWUZaN0l0NXFOanJlTVp4UDJm?=
 =?utf-8?B?S29hVDVBdGorNHJrSjVDMTZhc0Y1S3BjVmJJMnRybW5YRmR0ZjJDU0xydFdN?=
 =?utf-8?B?ZHAwbzBVWWtIU2FkY0NtWlN5SG9KL1lYRGFNRHhTcFpkWDNtV0xmNUVURlFv?=
 =?utf-8?B?TVpYb1hxTThUQzJoQkIxSVZOVTZ0WTZlNDZCekxhTU0zTnFTKy8vWllxZlV3?=
 =?utf-8?B?WkdXTlJWR2VQcnhPck5IUDRzckt1N20xNllJNUphaEFpMjZiR1U2Qk82c0Zt?=
 =?utf-8?B?a0xQTXBjYnRVM3BBYkZUTUtCT0xqQmUxUWlNQWQ3QWVPWXZCQVJML0xWZ1k5?=
 =?utf-8?B?MHcrK2VRc2JWV2dBQU5VSjdpckg5dWl5UGFRQ2hYbTdQY0ZWRkt2bGh1ZU9j?=
 =?utf-8?B?aFhOK3psV0VlenFZaU9Kb2lqUHE4ZHU2Z05UNEFCS0pSdUdhZDNYbG9NZkVx?=
 =?utf-8?B?eDU1RUJpZEZmL2NIY0pnWmUzVml5bkV5VlpnSHN1OWJ2QjFZaHp5MDl2ZXps?=
 =?utf-8?B?T3AyZ2JIcmp6OFZXZEgyUkQ2dVhlK2xuQmdNYnpQNi9IOHVJYTF6SFVxVFI5?=
 =?utf-8?B?OGlLTHlPa0Q4S20vZlJ4V2JIakpHNUlBbVV6dy9BNGxncktBNFZoT0JHV2Rr?=
 =?utf-8?B?azV2N1doMmd4V21DSlprUkdlQjMzL0RnNzhHZTE1aUhGSnhUOVYwS0FjUlRy?=
 =?utf-8?B?SnJtWEdTbFJWNUUyOW84cHU3cVlzdzJGWVZsblNrUDdWT1pNeUJKQ3BCRU81?=
 =?utf-8?B?Mm9tbUx3eEJCN2cxVUEyUnB4MnJ5M1gwTkEzNFlpZTNVYXBVTUk4RnRBOVpY?=
 =?utf-8?B?RXRab3dGZWxIMnY3SHN3cVhOYSt1ejVwcG9Yems0TGtJeFJvcmZsMnFONHlH?=
 =?utf-8?B?VU5QeC9xcVl6SlBiNVV6aC9CTTJENTZUTFlWOWtQMldWUjJ0c0ZXRmZmeXhD?=
 =?utf-8?B?cElqcE9qeEtRNEtEaXFPU1prNjZyMzVpdWwzT2FIbXpVWGY5azI2YXNuVncz?=
 =?utf-8?B?UHQ5WnF3RDRvUEpCTFprNmwvK0VRNWtxTkd6UThicnUvanJyY1BCa1pUdksz?=
 =?utf-8?B?QkU2a2VOZFd6UnNGR3MxZjRQQVpzZGV4MHBBcmNsTFMzSWd0L0ZVWnEwT2Ru?=
 =?utf-8?B?YittSGMvQW5uNUxwdlNkMmFNK3A5aWpPUE5LSHY5NElBUWNhajlTVVNxOWZN?=
 =?utf-8?B?eFBzYWx5aVQyelhTR3JIOGFsdWRRellDN3JSSkorL1FYMXQ5ZlNqckU1Q01p?=
 =?utf-8?B?T3h1VElJYUhkTnBDcmZsd29FUHF4WHBQZ3RwK0w2R3FOR0UwbmFDMXRlZ08y?=
 =?utf-8?B?V1B0aW9zSEVXK1lPdE85NzRGVXNKL2xEN3VBSGtEQXVxT0NaQ1hWbFlWdCts?=
 =?utf-8?B?a0dSZ3hvR2FCUW5XbVp5NVlQdXFKcWV2eDhEV3NSMzBUeXpMUDMweW45MTVS?=
 =?utf-8?B?Sy90K0JsRnZqbzQ3RzVwSTJsc0RKNmtac3JOa1l0ZVhxQVFqdno2RCtWUlRK?=
 =?utf-8?B?VENEeGJnekcwSHQ1T0tVRUdZTGFOMUc4RjVKK3ZDTHhpd2o1a3ZjVWNlaGw4?=
 =?utf-8?B?ZlM4NWdiL0FBR1hXK2tOVTFhR0U5OW9pckw3NkNrRk5PaXZYMmVPMjIyQ3FH?=
 =?utf-8?Q?mc2DVJ66tiNFE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytwSUZCMDEyN0k2bDF4OE1ra2dBT2dtS1gzektxYXBXYzJpOTRsdDBQQ3Zr?=
 =?utf-8?B?cW1ocm1waVArOUtTSHFwc2p5OFFrQ2NxNWxOdTBlcVhzenczV3ZBUXBVWjVj?=
 =?utf-8?B?aWpWQzltMFBkeXQ4YmhZSDNsTk5JSWQ0bUNsT3gyMEhTVlBBaDVKUkMzYjdL?=
 =?utf-8?B?Y1NwV1ZFNVFnc2YzNWFqenBDTDA3NFM0cE1VU21VNURTdm5Tb1poak9vRU4v?=
 =?utf-8?B?a1ljNmJnMGhUWFI1aElRV0JOb0wySFl2ZCtrcUZabDJ3ZWJCdTM2R1o2SUYy?=
 =?utf-8?B?TDdQL3VzWW03MmdFR3lyTTJTeXhyWit3M3dmd0VKSlNLWm5ZemtIdktFVEdQ?=
 =?utf-8?B?N2QwV3VZMVVDY1Y1WnphcDZFTVltd1pUZFVSUkQ3WTRwQWo5U0toQ3crNUN2?=
 =?utf-8?B?cDgrTVgvSTBLOCtyTm1MQTJ2alJ2Ymd3c1Y5WnRoV0p2cjlWekN3eE1DOHEv?=
 =?utf-8?B?Z2tZc1RlUlI5dEVjdkdZbFJWU0FVZGIrMisrV3dCazhnSWt0eWRpb3Z3MmxE?=
 =?utf-8?B?YmhVMnZjTlhRdHNkcUZGWmYwN000VWRCa3NlV1RYVEt4SjUzamZlM0Q4U25B?=
 =?utf-8?B?ZVdsNXR3bml6RllsaXoxUC9mbUEyWWMwWnJPK2lpSi95T0o2Z3M3RnVvL09J?=
 =?utf-8?B?bER6WUVLR1FZekpmQ0lXNFI4MTJVTVV0V0JJSWJ2RVowY2o0Z0dDM0Z0bXFq?=
 =?utf-8?B?UWI0SEt1Ukp2aEVaWGE4ZTUvR2ZaRWw1TUNEK3pDS2NLZThNNnVjUEFRMDBn?=
 =?utf-8?B?ak1aTHVJUWQ5QW1MOXlxVzVzVXNXQ2lpd2paMTFoY3d2cXhwQTNpa203Vm9n?=
 =?utf-8?B?cVF1b3g2bG4vQXdJV2hLTzFHUjNwU01oYytxK1Vocklwbmk0MDZBelZEQUVa?=
 =?utf-8?B?M211aHJ5SWhWTmg0NkJUSk9uZ2FieFBXYmhSamlBcnVHVXVWeFFvb1d2amNw?=
 =?utf-8?B?dnltT0hZZU1KVFJSWWlXaEVkRTUwcG8xMlF1Vm95NXd2VGZqb2tsQVFnb1c5?=
 =?utf-8?B?QVN6Zlh2M05hTzBHa1FGU3cyTE40MFFvS3JmN1hhOTBPWXBTNm5MRVFXU3hh?=
 =?utf-8?B?UFQvUlBGYzJhb1RWdVBXK05ZMlc3ZnVhMVVIRnRCRzZXL0tOd0ZtelZGTVVw?=
 =?utf-8?B?WS9Vc3lHU2w3ODZmazFMditFbVdnVTYrRXhpSVFzVU1VZkZRMkMxNll1M3hi?=
 =?utf-8?B?dko3K0NvT01WWjFOV1I4TmFjcnVwdy9sdWRrM0RpOGNqTnV0d05ON0dXdjVE?=
 =?utf-8?B?RkhSTjVFczRGWU1qRzhoNmVMSlgvTzFLVVJmd2Y0MExGOW9kdDk4UUdVZkJ0?=
 =?utf-8?B?N1hMOE4zY1AwMUc2WVphR0dmc3YxaElMTzVGQlBabWMwV1dXQklxSjE1L0tk?=
 =?utf-8?B?NU0rd2g1Mktrd2t4bXRZOWpVY3FwM1BuWHBVMDJ6STgvREl3MzNxeXY3by8w?=
 =?utf-8?B?ZjA2M3lyNVFJNVM3QnR0bEd5N1dKeFlKYkVnWDNxYm1sQ09NM1RPV21FY09J?=
 =?utf-8?B?SUQrNE8yQmpodXloZW9mMjB5K2dBNlhtdHdLWGk0V0FJQ0t2RW9sMEp6a3lC?=
 =?utf-8?B?enFKUnNzblRqYVozRkdxeXk4RUF5VkFma3pHa2VaektCYmR2TmphaDRGQXcx?=
 =?utf-8?B?U1Bnam1qdWI3Q01VQkJoSFVNa3lmMkpRcGtsTTlzWXVhMmtXVjVXaEdNZzJ3?=
 =?utf-8?B?Z0Evb1dEcVhWdHRXT2paWW5ZZzlQbEVoemxqT2RQNWRTUHFFYVoyVzRGOGlF?=
 =?utf-8?B?Z1czQnhrNHZqOW9PT2VteTE3RnF6em5nbmtjSVdOL3NXNnJVZSttNlZpTkk5?=
 =?utf-8?B?dTc4Y3JpdzNxdFp6V0ExajB6SmVPK2lQVVpRMSthbWEvVkR2YUp6TnREbVJo?=
 =?utf-8?B?cVk1L29kWDVjV3hxN2NaVzBtK2FaTHhPNGpZSERlTnMxcnB6STYvL1VJcUQy?=
 =?utf-8?B?eHRXMElKcnhHK2QycCtUMHIzck5GdVE1bVlrbjJWMTJkbGpHZWtUWnl1RlVY?=
 =?utf-8?B?Q1EweXJjVm5LYi9GUk50eGNESHdoMzVEV1g1U3hFVnVLUHZJUzBoaGsvWkdS?=
 =?utf-8?B?cDQ0alJlSWdRNUZFZ0lkUjI4SHRjNWI5MHdHOVQwN0oyQlNaWVRFbHdpd2FP?=
 =?utf-8?B?WlF6MlppNVAybmpFYVlWSkNvdWJhd0VQbitRUFl6VTY4TWR5RjRDOEpKUkVu?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ax+c7le/3S7Optn/86bMDBl0/Qn38ViFXu+q983lJRjIVvB/GDDP9+VpOo2yyIO66/mhMweohGpWjc5XrBiIx4rXZKrRWdkIHb4TJ/DSEScR/Mme1/NBhOzugf9hLXtwT5hVCH/zgEpdAHC0vw8A9oLQaNnJgqad+PHQse+5IfOUX+35JPosHsNfKbN6V3BDSW5vJ2VErcPbe1CZvA76E+TDOm6Q7zJbLHHtSY+lpJPv7ejyaZ/Kdu7EO5KSFIQE+UOVqTxHzhepF4bAUO9mahFBZXR3kKzvDV+sNh2vl5W8kmoqjGSSywQMA7mT/QKJZiqYynu6nmQNN3mE7orxaCi9SpVTPzFE7eeYa2qZLwLXbhO8dKoDHNSE9FNNk5yRKQOJEzAKQ+Nf+upHnnCYnkg6IaJLuUo95Q13FXzukVExCjXmjnIp4OrtcfaiIpqV3EfTdyhiydqxAadsZCcC9CO7n37VlQ2tbfIF58l7uUjcnDXfB0pc7DTddnl7lDClPF7FlQdqSxr2vuAoFZp4ccmnTrMCBh4pTLV5BwXerTLxBRTHxu7HQz2eLt+StxKiJ9iXZjKSkLAhEsqDyhZhIhbK5AgvLJmCb3uoYZOfEHo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f88dd34-abe2-41e3-369e-08dd4c186aa6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 10:23:11.1844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gp/dJiGbgrYWI3F6mGyncMu2yII/+R/eLD5ZYjDRqgEeKs1iKypVSpRpYHnKzRIXxKqBJaKw46tw8pMhNUfzXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130079
X-Proofpoint-ORIG-GUID: 3Hcw0nSQs_oJV522G-8quCKN9Bl2SfaD
X-Proofpoint-GUID: 3Hcw0nSQs_oJV522G-8quCKN9Bl2SfaD

On 13/02/2025 09:58, Ming Lei wrote:
> On Thu, Feb 13, 2025 at 08:45:18AM +0000, John Garry wrote:
>> On 10/02/2025 09:03, Ming Lei wrote:
>>> PAGE_SIZE is applied in some block device queue limits, this way is
>>> very fragile and is wrong:
>>>
>>> - queue limits are read from hardware, which is often one readonly
>>> hardware property
>>>
>>> - PAGE_SIZE is one config option which can be changed during build time.
>>>
>>> In RH lab, it has been found that max segment size of some mmc card is
>>> less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.
>>>
>>> Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
>>> with queue limits and checking if bio needn't split. Define BLK_MIN_SEGMENT_SIZE
>>> as 4K(minimized PAGE_SIZE).
>> Please note that blk_queue_max_quaranteed_bio() for atomic writes assumes
>> that we can fit a PAGE_SIZE in a segment. I suppose that if the
>> max_segment_size < PAGE_SIZE is supported, then the calculation there needs
>> to change.
> It isn't related with blk_queue_max_guaranteed_bio() which calculates the max
> allowed ubuf bytes which can fit in a bio, so PAGE_SIZE has to be used here.
> 
> BLK_MIN_SEGMENT_SIZE is just one hint which can be used to check if one
> bvec can fit in single segment quickly, otherwise the normal split code
> path is run into.

So consider we have PAGE_SIZE > 4k and max_segment_size=4k, if an iovec 
has PAGE_SIZE then a bvec can also have PAGE_SIZE but then we need to 
split into multiple segments, right?

Thanks,
John
