Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38013370AFD
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279197; cv=fail; b=XbPs7Np1sIvZeLRnTSFZDc/NtObPRqvNfqXLbyY5HJa+9iAluo04nM8VHtNntf003ADZfwDG/bpdwhWpsr3egYVESyoUq983xzw94w6elUFhkSt92I4QA/0GpGnhaG0a7PgTNWmDxaoG4z63RuEW+xYdH25qp3LIDbhM4LfKu70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279197; c=relaxed/simple;
	bh=HjFfMZgrYLKeMlk955UOjItMWiLbMtpxputjVLcI4j0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=l54BEy3c9nb/452CChmAdZQeDgrx+mDfPKWuVYBEJUFkiYJNOvEY42MwFT3XlZwRPA7lqT2xyMZLj9imT78Zlmb6sw9s5Unt5SLkq8LoFPZrX1CJodUZajnWXzfjGC2oR4rQ1q3+YoitHOQzH1nXBoxF3etALYFZQmbAtrvqp1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rpTtgblC; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FxZSnRo4 reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rpTtgblC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FxZSnRo4"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H3Bf7i2127878;
	Fri, 17 Jul 2026 09:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oEhkc1dF2Mg62zAMrzN9Keo8KGcJ1ycdIQdrak0VkV0=; b=
	rpTtgblCwGGSexapLsVDaeZtUGs+IM5glz66OpXhZ7alF/Aew8UWSYJNWUeEQVB3
	PmTdR8geDRP8hxDGsJVyesd0x090ib3Bq1B4myeOrAqgLruPuTaq/k4pYHFbEgJw
	zpdHAdMw8bSTcQ17p4suw/0HaLPOGe4v1D1HVyC+/BV7/dND0vln7rbKhKcViFjl
	N+HbtlbnWq9746cED5zDcub2OgpVrds3GSAzPYmzQkxE4L/WONlA0xQReIZBJ/1H
	2Rbhdcj36RBEjS4lYy0j3rvb1gTZJzi45l/r13HB2dO2Rbqw6F17SK24DfCCqzmM
	pqhR3ItB99+HDtJhYelCaA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbef11yb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 09:06:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66H93Ze7034931;
	Fri, 17 Jul 2026 09:06:15 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9muumv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Jul 2026 09:06:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frwxDBcX/JO/OQDpfNIuvUj54MT48ktv0RPLAHpOSq/TLu7FJmAjgmWQ+p6kiCiafxzNgzHfcIxeeyRem7MS3zGDE+VGmMfNUJuDQtXkIsFvx00Dhcy2KXKd5JFEeq4QVflHCasYVfrmpIAuNcPd0Od4znyUmin6lRUAQtRx+DkZLR3/NeU785JvxNymyeHN7UOEm498xGmOOPdFp4SjTBYI4+8oQz+/RCCKCN/A7jdCxd35dTsq2kMtRjcfVnWbkJIAL0laxthky2zDU0IJtcHYEMpB8ADGN7XybHPFNCSaeJDHhpGLTwzXqDYzOxboHEIIpNhzx/BGaEjZaNQMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vehWdYXIdK+BM3ts/iCQlFrrbFE42nBv8lEbk1tO/D4=;
 b=R9aYB9Bjd9QxN1nK4ksek51rAkWEWZybboB5jO4jL7lXKh8BQQZ+4OGfefQUZv2ix4VSfb6D6+0y1gbmQ295Q+Jc6UHbNAtiKBlu9dEHltPu3IvbAEDzS7TKtSY5GIhWXTlNLgMZl6pf4hC1mGSZDXLZjxX5Wg8zeOy26YSGyG/r8r+sgjVR4DSxV44jimADN3N+LPsc6VrcJBkGYfQ8dgldRTzn4FWEf5XgdA7EVisKkJS7IPBw4EXwoAkZDvarN/SzCX/mkQljv+GB3frFqEPG8Y8PCsUTdEb3yEU1iPw0AZQ5CPdiuBfIlbRUn+DcBUEuxm54c8K6kixue1Eh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vehWdYXIdK+BM3ts/iCQlFrrbFE42nBv8lEbk1tO/D4=;
 b=FxZSnRo45elN6B8RA2ahCm/H55D0zRGaqFAuzJSA8xHYUIEjynFzRYlG+7fqHnK261w3Y1J9GHxg4V50bMfv9oYW7baDtWUSOinkTceR3GDTl6VGbCv0Q0tAPXU+H+dmBfC9sAakNosqCrrMzt22woUuv+qXNu7VDz7bFE1nZ5Y=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 LV3PR10MB7981.namprd10.prod.outlook.com (2603:10b6:408:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Fri, 17 Jul
 2026 09:06:12 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0202.018; Fri, 17 Jul 2026
 09:06:12 +0000
Message-ID: <4a7868c2-a67c-4bfd-bf61-58131a98c97a@oracle.com>
Date: Fri, 17 Jul 2026 10:06:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme/069: add a test for multipath cdev lifetime
To: Nilay Shroff <nilay@linux.ibm.com>, shinichiro.kawasaki@wdc.com,
        linux-block@vger.kernel.org
Cc: hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
        John Garry <john.garry@linux.dev>
References: <20260716082927.4053505-1-john.g.garry@oracle.com>
 <a4f4f444-967f-43a8-becf-465a3007ade8@linux.ibm.com>
 <ae3a2f44-b26d-4040-b9a4-cd6122dca29a@oracle.com>
 <99842431-3ffa-412a-af57-e284888342a7@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <99842431-3ffa-412a-af57-e284888342a7@linux.ibm.com>
X-ClientProxiedBy: LO6P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::17) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|LV3PR10MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3c01d1-7ae7-4b88-15e1-08dee3e2a5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|4143699003|4133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	J+/EfSS5YQDy/+SUcsxJG60DG8e8EV2Sxm/yE3oFA/Lf4ESNw8R6obtXnGOfOhRmegFG4s7QOV9gK7weIG2pp81gAg2Nswr5GvmVtG0o7bQIsY8VGXD/TvyEsqZXuQNH9tOmVQB8DqjoFQYYRvcMzLMwAG/Hh8nfjhb6W+0HZxj9mYuU/wM78DOFq0vgJWL1R/i1jJvTSAanuD/4UICDZimu9QLbZyuStkyNz3Y49adjACWvXTp+dIM7cDPqcoH+QaswfGEYpprTNXzynaXuOrrk9qVqBiPqT1wHyn4LTg9l9q8CvaTFXMk0W13UoiXhTEZaQFzjkRgynx6N3r1ECMJ9yU9XcTsZHEalian8OO9PK4Pugunv7GFlZFrd0FiR4PBCYhJ/tWowiX7LsqXoIIKO3DEiIDrj3Z8mMq6iF8KbHUkch9hNPsm0J0E5r18prT5+1YldKHkPjS5JIY3qPvWY62Smt6hoyhLOsGdqVjuaPW6Ew5IkotxEpR0BhDFkRwqxLd7aqRXJ2ukCRVi+LtK10RSjXTne5qQibYCv5DsY+DA6wew6FiIVv5XYwXeGqSwWLZVIJx/eEhsKDHBvgqxSLWFbSL+rGXgONc1KJ40I0AjsM17YKXmm7SGuArxHzWc5IWU2ZuLpCE6S7IF8/6fbgnFWq2VMWRtbfggrU04=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(4133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk1NaUdXblc5elJJekJNVExHZTdPREZsTHF1MVB4Uno3RGk4djhncTY0ZDIy?=
 =?utf-8?B?b3NiUy93R0x6VDd3cmRDZ0pMSGlGaTB2dUJ3UGU3cHZhQWNiT0ZDSVhKenpI?=
 =?utf-8?B?OCszYWNxT0xVRkdkYU5ScUpmVVdYQm5ubll6OW1Eb0lvbjNraGt5OUpQZ3lB?=
 =?utf-8?B?bXJCd3ZLNFFBRjA4SjRVeGM5bHZ4U29xMGVmVVR6NU05WkorcEU4QjhzeWFC?=
 =?utf-8?B?cGZNbXpDc0FINEFTQml6aWlUOC9EMUVNZGY3ci9QZkw3c2xJK0twZWFYbFJk?=
 =?utf-8?B?MGdUYjJVU3p3Z2t5dVlYNWl1YU5IN0JiVlFLZHJuQlY0bGViV3JidllmMEVh?=
 =?utf-8?B?NnJ4TWIvMjU5S0tQWkNlVXl1V0kwZ0VCbGRhSWdLbi9vZC9JUW44UUs1R2gz?=
 =?utf-8?B?UGtmMHVwT21OellNMjQ4RTIwUE9Gd3BLQlNtTDVyRHdYdVl3OGc2VGNMd0tz?=
 =?utf-8?B?clJvK0JZd21QejFVL1VSMVZ6ZVVhSTl1akpTQ2hQbUZwRW9DaTNiN0ZzeWhS?=
 =?utf-8?B?NlJtU0cxdmVLV0hGMTRkZEtqbjNtMXRaelN2QjViSWZKQm82aGNlb0hIZ09F?=
 =?utf-8?B?d2M0NkhROE1GL1N2bFYrVkJXR1NNUWJDYjVDemJ4VGJud0daeHVvTUwyNlFa?=
 =?utf-8?B?S3c4RjFwR2JzMElrLzB5ekRtUUw5RFZIcDlFR1lkMmZyQVJGZk5EVWhvMHNQ?=
 =?utf-8?B?OVk3RWl5UWxNK28wY0JDakIxQko0SzJXYWdSRDRCT1BtelRPOVBrVGJjaktS?=
 =?utf-8?B?MXBhMzZpTk1RTDJZTW0yd3FtYnk4MW5CSWpVQzNaY05BSUx4N2pMWGRkOUhz?=
 =?utf-8?B?cnQxWEw4bU8yeHlGazVZeE9JUDcwa285d1ZpVDZRdW9xbTArcnFyMlJvQ3E3?=
 =?utf-8?B?UTFmSmxHU3ZqMDcweFVrZ1dwY0loclpFYVRtK3l4YW1QbHVGcWlIYXlJK3kr?=
 =?utf-8?B?U1Y3c2ppcVg3Z3l4YjdlSmk0TExKQWN3TlFPU3JmeC9jcUJBL20xelhHWXJv?=
 =?utf-8?B?YlREYThkT3lSdkNXb3FVUlk3NTZNT3UvdG4rNHdUL1U4OXBMUFJuRW4yaXpo?=
 =?utf-8?B?a2JkWlBjL2ZPakYyUzZHRzB6K05XaFdMVGZtYjh0a1VrWnhQUVFuaExGUkVB?=
 =?utf-8?B?ZU1uVWhuZXBqZ0VNOEl5TUJnY2p2TXQ4RE5RQjNUT2VqeG8vZEdaSUpuSy9O?=
 =?utf-8?B?UlorY2NtNUx3MzJrVUdOWElsdW9WMmcrTkZnTTc3NUcrbTRKekdCeGxzRU1h?=
 =?utf-8?B?djQyR1lmb3RsSVdJMmJ5NjRJTEFUTzdoMUF3akFhMVYwRmlYRk4veG5nM2Vh?=
 =?utf-8?B?RVAybEE3QnE2M0lhYjJOam9lQUxoSDFUcTdZeFF1NUFPWjBLNFhsam1xWDdk?=
 =?utf-8?B?QXdoRlBzaFlEY3dUNk1yaTVwdWVZUVBlMkwrQVlvZSs4KzI0amRNWE9scTJ4?=
 =?utf-8?B?NzRNWVNPNytZMzMvTmdFWUtIN2ZKVklNeVl2WDRXNldhSlJPS2puTklTaWNW?=
 =?utf-8?B?R2l1L3ZRQUN2OXhQK2h4NG9lVUFENWtQUmVXSDNOUW1QYUlUWGVEWERHUngy?=
 =?utf-8?B?ckxQOW5JZXJNbzRjOEdDTWFsWnB6MitHcjNSbWdQWkU5QVdKdnZuMmp4a0E3?=
 =?utf-8?B?RmVaN2YyZWVaTVpYUmtodEYwOVhhRHNKTHVFNndUWXpIN3duOGF1VUhsMzl1?=
 =?utf-8?B?ODhBbnRDMDJZVFBHc1lSWTdBdzZtN24xTWJ0Y1pMWk53SVNsYW1RYk5WcXMv?=
 =?utf-8?B?S2hVSTBIbnhGdTNKVG95N2lPcmlnaWRGN1NjN0JQRWxpUkRhZjgvYnk2NlhO?=
 =?utf-8?B?aWlDaktqbFh1cnRWTEx0U2tBcjEveno1ZjhOMUZndTg3ejhTVDRsbW1NcXBz?=
 =?utf-8?B?UGNPRFZIUnN1SkVhSW1Ob0R0Q1kwTTNKR3hla2ViMk1IbFBsUzVuU25CUG9v?=
 =?utf-8?B?M1YwL3VTYW0vNkdia0ltUmVuVWNEa011eUhtaytvM1FObnhxNkNFNkprUXJC?=
 =?utf-8?B?VERTVUd3YnRsK254cTh0cnpmRzc5TUY4dERnYlZzZURLQzZZRHo5NHNuWFVR?=
 =?utf-8?B?QVBVNkJjcnVSMEMrL2RWaTVZRHFQNHpaUG4yMGpPMmRyNnh3SlV5cmRIUXcw?=
 =?utf-8?B?ckNxcXN0TzlNMEkvVlBaUDhEaTEzRnlkY1JkSnZILy9GMGU5RG12S0ZsaDR1?=
 =?utf-8?B?dFhkMXIyV2pjVFI3U2ZmY3Q4SmQ4UE5pbU9rdC9NYzdIOWg4djBjYzh1MGdX?=
 =?utf-8?B?OFp3UU5CYmNYUEgrdzBGSTh4eTZqMW4vcHo3TmVvZGhWK0toU280bTBYODFj?=
 =?utf-8?B?a0svanlybUFDOUY3eFFLeGJhYlc4dytCSjAxVWgwRTBMcHp6dFVIUT09?=
X-Exchange-RoutingPolicyChecked:
	l6HOeH+ePvYom1HQ1TRLclYfSwayd2+t3V6Bl+I8jmRKr0qg6Ik9nPXWNk9GCftdGI/zLxdvEb0Ffj84D0lropg3K4NMQqrtsWOJGEum73teHg+A+FLEGBS12KTLXbh40NOoQVnRSMXhvmkuFloS+t8Qz/l2IaSi63JIqrM1OlcdV/W7UVCUghqaAnMwQw1dAYJA78Agb8wiDQT1MH+2e+04xcLHrJZ9umqEFG3SnLhjezI+RZGrW/RdwYXSu6Bu3iHptmg5CHP+dYStNfXj8vuUSFLjEV0n2ilg9euFfiCMThetaqh8Y8NqWjx5y7MYgb++cMlMQREiufX6XSp44A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hmTUagpZcAzqgA7bK8QCucOUAxQNjDnAS+hPQ1QsGqlxsrx660j7Twp9YAFev+6/gRVtfxHR2qRfnB3hsdLK2UHcil824eNwWVqKmNlhNoM6tIK1SAVkttfzWW1GkXVLoBPnzQkmISX5FB5IQXZ8ZW+siGM8FwVBTQxwqlVvRqsFnUVREsmBDkMZFn2NOFXe/AwuAadqG/pR16sUZsdPgiK4VyBprRCqxe/Zofm6dFmt8rywKxVEG9Hx2lDk9MSiw4/GrSTQ0Ff/m6YIkPTyeIxw/6VIKmHdqHGaZamwqEBNzRzgNLDpfA4bN1bYmmwom10llOeKeFwPHSAb2cEhFAtXlp3Hv5iuM5CyR3iTDzG9/07YutXfxnW+HFndwhL3rMfAYa7lzKSDp0hF1h1uoLmSSHRcom5dHYy8TOAAhAjz1SqTYAhf1G6XKE3UWS/l4wvBH9gBBdlJs8cZ0sjoGhhW3y98EZWZJXEL9R5uVzsyQqQJ6CPTpbKytNu83m2HLL/JK86lCWa/wyEX3OVTeATMcphLM2o8XJnDLORq65/hCNUrFXeZNHgFAB/wsFdTDAmVxiN4bErZSsv67iUq54ekoKTKl2UPledRkr4u4n8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3c01d1-7ae7-4b88-15e1-08dee3e2a5dd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:06:12.0679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0oVFFJTyC65zuFMZv3LA6Xtswte0Na4TC4ulGotskKB4AT3jThTKU46B/hEsba75G/BQ9EgxSoOMShlWxYl1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=850 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607170090
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: jb2WPwiIUuX0RWpbtBGiCwSMY_LovtX5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5MCBTYWx0ZWRfX1o0a7Vekj9Qu
 iukOdul3r5+1Ic/O2ywbzy/JpZU+ReL1JLsZyeh31UVxtXdZIv5YPHz8jXczdHEdc74T2ha/gxh
 5RFiFkxppbg+j6g2uG3MBxq1GBnnjyOmiAiF8cu7UQ9jBILwUqNJ
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a59f088 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=RpNjiQI2AAAA:8
 a=9xlnhOEHvXtCLPgmSK8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12218
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5MCBTYWx0ZWRfX3aBuR4M1mNcO
 XWkzDHUfCSM4bXGbKEjF3U9Lmomupz6/6XcF1xeIKflupFgtfy/bc4DGuykMkFkSgXwzVOcRno1
 7htlzv6cINE/IqtqWz0QX776iZd5gR7LAyMOnRB4/oqMTC5NR6JmiHRXB31Z5pDI3W/UY7TeLYk
 QBFOlQoNdUVhk9s6g1eNu+VRiMhv7+pg2NXq8HxeCdiLQLbRBpOpUI23zJASuWG8hVX3ph5ThE5
 SgCdQIO0feKnJ812MSvtHyWBbIk3AoG6/SAWUXtpHPxsZrr7cwGkvS6SwQL/eSl4oPRAUhECQNT
 IIANFbvoEnFCXloe1Nu8EONF74qC1KYfothNlclUxI8/c3vwjJLrCIH3ldCT+CXFPhHUYBWohvk
 bl8Dl/JadHr5ww9MMYHoMWzboQ/TXbVX+6+3eF/tbywsmZ2YIj1q4eRKlpbEYYZ1NfxYvvOGQ6P
 W0swzmWl0tLCwZEuUK1aK4BiWxAocVOElCaun3kc=
X-Proofpoint-ORIG-GUID: jb2WPwiIUuX0RWpbtBGiCwSMY_LovtX5

On 17/07/2026 08:00, Nilay Shroff wrote:
> On 7/16/26 10:=E2=80=8A06 PM, John Garry wrote: > On 16/07/2026 16:=E2=80=
=8A16, Nilay Shroff
> wrote: >>> +    kill(getppid(), SIGUSR2); >>> +    count =3D 0; >>> +    =
for (;;)
> { >>> +        fd1 =3D open(argv[1], O_RDONLY); >>>
>=20
>=20
> On 7/16/26 10:06 PM, John Garry wrote:
>> On 16/07/2026 16:16, Nilay Shroff wrote:
>>>> +    kill(getppid(), SIGUSR2);
>>>> +    count =3D 0;
>>>> +    for (;;) {
>>>> +        fd1 =3D open(argv[1], O_RDONLY);
>>>> +        usleep(500000);
>>>> +        if (fd1 < 0)
>>>> +            break;
>>>
>>> Does it make sense to check for errno set to ENODEV or ENOENT
>>> before breaking out here?
>>=20
>> ehh, if the errno is not ENODEV or ENOENT, then how to handle? Would it =
to fail the test due to unexpected errno?
>=20
> I think yes, something like below:
>=20
> for (;;) {
>            fd1 =3D open(argv[1], O_RDONLY);
>            if (fd1 < 0) {
>                    if (errno =3D=3D EINTR)
>                            continue;
>=20
>                    if (errno =3D=3D ENOENT || errno =3D=3D ENODEV)
>                            break;
>=20
>                    perror("open");

if fd1 < 0, how is it open? Or maybe this message is too vague...

>                    return EINVAL;

So are ENOENT, ENODEV, and EINTR the only expected error codes? Others=20
are just unsupported and we fail the test (if and when we get them), right?

>            }
>=20
>            close(fd1);
>            usleep(500000);
>=20
>            if (++count > 10) {
>                    fprintf(stderr, "%s still present\n", argv[0]);
>                    return EINVAL;
>            }
> }
>=20
> Thanks,
> --Nilay
>=20

