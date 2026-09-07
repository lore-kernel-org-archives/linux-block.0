Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497541D223;
	Mon,  7 Sep 2026 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767453; cv=fail; b=gynU4Tugobgcgphdgl4Ac/kBC6qhGMHR2K9+PXly/5LqvKz945+ecDhtUCsG6sA3zQ2X/O8azPWX+Ep7/m8CDbA7b6DU3A5nzC5VmNCbVQKcL/nFsww0rWw7WIc3Wz8CAnC1str7g1IoE9pKmwbLRDxoJt2MXmQ+XJM9rXRas9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767453; c=relaxed/simple;
	bh=issZ4or+wtIdymG4KgU4U2CxwxmwoUvPaDhl6Jz9r3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fP1fxlQi+U5hkSyn69aUJV2NWtf7keW74yxdDbQGTV8693Blkqpi/1NN0go66JiGrJIfVrVRWxf8O31hALybqs3Zxa5cYf6zqkv6+alLypVS1wOg+Wp2jsfiMuHe9+X1iE1oMSD6pd0bNfIN4PV881uNVATf3iEkvvfaNjKM8oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aNQnhhU/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rboTawsB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aNQnhhU/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rboTawsB"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6871oaaR411585;
	Mon, 7 Sep 2026 07:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=q8lrm7MmnQCPZpGSensTkckoRM7A2of89JMkMDGFYTM=; b=
	aNQnhhU/0bd4rb//brAZyxa/VpxH/3vGM6FQqwKyZPjaawi/AgI1MbKfM+J3Qam1
	h4b7mlRIn9w+Fx+lbdnayaVf8EUsVzqe8HW6yLoSaROwE+mWcbghTlrvfOHvMhks
	UJ2l6gsx22yPTC9dBRJvn6u1rMTLs2bQDBJRt3gRWtRsuy3jm6HNtIsClifCpSKl
	rNcUG/b5TaFYeOim3Mmk3rqSlx5L2te9uV1WFC+ZrMWkMNaZgDORMBxYUntsA4kg
	40N/FJKA8t0ugqFSB0ZEsgxT/+8jyJK87ZxR2tWSMoYnI4I3lDOhpydLnA8j85OG
	WYiXC8YdeQJGlFG7ps0qzQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ggbg1sjgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Sep 2026 07:50:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6877o6qE006254;
	Mon, 7 Sep 2026 07:50:09 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013034.outbound.protection.outlook.com [40.107.201.34])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gh711tfdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 07 Sep 2026 07:50:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyGllRuAp+nhapLVXkq237+30laWwZVKI6rW3T43HmtoUlmSlAot3oTZyLV7dXu+7bF7engN10INrdKYlWdkYvRvAmZH+jONJxw+ZWSTWObSI54Kiu5mXscQtT8hsV0tsnmisWXLSaEvVZpf567FX66LYimntJWa/OfWuPGSTrErTJlKbV+o1gigFHOABjIZ5Q5SL7XPsE3d2TT4SZPm9Qpzmq/uzohbzYGcSCeRGJCV1KNeL+N4G9MTR5GOf2F63IqnpBmwyPiNpk/Ze8hdXb/j2ypwDutLoZFfD9f9IKfHWkgIeITsnLpgWPlac8jqxiRRHcWx48SOuIQFbyX8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8lrm7MmnQCPZpGSensTkckoRM7A2of89JMkMDGFYTM=;
 b=BMjfVr3gNEE9qSreqUWl0qVbcLVnGJF/ZhU5uMVbEEwC8WJ/79mp4iR0hsFKrjD3V07rDeyebsZe4bkwDN2iCU7n8KHqqu25q7Kydn+GT7UNTGwkpICsE9UpD00BxA8tlEblrlbL8B7TjcQcr1ufV2p/nDCYxIbAZpuPo2u8GlTgR7Awg/7eHHW29Uv59hpDYGz1RqSh280Lwj3Vo0U4FKswdwlE6mzgh6cpYFImnrdeA/wCkQ7CtmNdz4r2t8JWLpXrjJctl619rpU9fImbF0wP534fphEO070ghGutVuVD3HnEN8jl9H2sFbIEXZsMMcv8cq+ue/KrrZMjpk8j+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8lrm7MmnQCPZpGSensTkckoRM7A2of89JMkMDGFYTM=;
 b=rboTawsBn2G2qhyr29rOTXEFacF/A9fpJWyNtHgq4CbwlnFV4JYHIh9bzfSKTu7H6/nmczCfIicqfRcdBYUXDkVImDoQ9i4xVxn/bctoOCoazGvh6mMddOpFc7UE6ONU5SsooZN/KVlWxdgATJhqTDsvNKSQlYT70axeDgWQRl0=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 BY5PR10MB4243.namprd10.prod.outlook.com (2603:10b6:a03:210::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 7 Sep
 2026 07:49:58 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0406.005; Mon, 7 Sep 2026
 07:49:58 +0000
Message-ID: <a7752d1e-8ec1-44d1-a266-c287c315e8ab@oracle.com>
Date: Mon, 7 Sep 2026 08:49:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] block: fail atomic writes instead of falling back
 to buffered I/O
To: Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        john.garry@linux.dev
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
 <20260828-blkdev-fixes-v2-5-32f3f40cebed@columbia.edu>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260828-blkdev-fixes-v2-5-32f3f40cebed@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0069.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::20) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|BY5PR10MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 028d573f-8bf6-4e4a-626c-08df0cb49d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|13003099007|4133799003|56012099006|10067099003|4143699003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	F0bPYKtFLW6bkm4LlRvMdkadWohZ5k0eiCC34DUotGJuwmq0vh2P0fa7QmgZCiyWh9jtdrVNM0tFEnfc7nreNEBHyYJyv+85pQvz23NQA/7A0MEWDgDxrxGpd1BEAspLu6KrsVH7ZdxEb75lSVpK2jr6wZ+2Iom63AONIUri+Fg5JC1IIFD2t5ijJDqmmZCQeSYngRqLinG8pdisNEh4vXbjSjXqCZ1pxTdz6Q0ld0841AfMnxQg2VGgWLGqGUPKfGLyzs/UoW1czIDu2oOQ0ffyh3BkLWkCzTNxLNMJHMXeAkjXL5YN4jxqTK357xAvaao9F1+PVyMHgQLvqGVOnyOkdUJ4AWxP/FJaOQS+ChfktnySX1x7TAl0aWRX2szjOQ9CZkTYgAWkK93OXyhpG76CBZlQ1C9rdEvuGmXZuqVp6Dm2f61Pc6PSIOPkliQIkWM4A/d28KZX3pErtWLijRadrKFjna56b4yjiH0u39+BbbblskfeiuQ8Fs7CMeI2HL4Cbp0io6R6BQTC2WfHIYcrnieFuN8yXIuoAx6Y0YwifSp0My1CPhxczJJaVf9olW6+QAJyREtmFz0qdoAf7Fo9Fo9k4Ad0NJ63Kk37BwkGOQFV3UC27wS2BU4dAHamQjS/zMpnu7jg36SRQGmBQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(13003099007)(4133799003)(56012099006)(10067099003)(4143699003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmI1SEE4dlZGMndyL3ZSUFQ3YTdUT1JVSnFXS1paV1lDbUJEa054Rmhwa1c2?=
 =?utf-8?B?MUYzbi9FVEdScnVRN1VRSVhpUjBpcEdzOUhGd0Y1S1A3Nm93YWxoWmJZSG50?=
 =?utf-8?B?czJhOTRlUTRqYlQxNGx3aGVzK3Q5WnVEak9TeWJ1VTBGTXBUeVBQTU51U3h5?=
 =?utf-8?B?eXBzMFA0eURNMGdEVGhXdzZIUW1DV3d4WHc2QitiWFcxM0RWOEhlN1ZhUUlC?=
 =?utf-8?B?d1JnR05sSTFucUc0eGxKVEYweWtnVm5jUnV5QmhlaWVxNUo3Tm8zWTY2dEtR?=
 =?utf-8?B?ejhvMU5ZWVk2RW53VUFhZWZrcXBkSlR4eUQ5Zlh4N3BCVEJ3MmJmWFNOMnZZ?=
 =?utf-8?B?T2taeGZGRmZDRVo3UXloRmV3bHVDZXdWc1RLSHJIWVZJSzlLTkNRVWY1eDgv?=
 =?utf-8?B?eitUemlxUkNMRWpUamtNR0hyMWM5SFQ2TFBQVVlzNHRLeDJXR1Y3YVJVRlV1?=
 =?utf-8?B?dWxMZTUvQ2R5VkZWVmxlYURibTBFZWxtS3pHQXo2WnNxTW9ZTXp6bWgrZS9W?=
 =?utf-8?B?V2lSZklXMUJzdGJqc2EyZEJRZUVGNExWVWNQaW9SOVJZMmFlVVlicThDaFNE?=
 =?utf-8?B?d3JPVlVUOVlnOXQ3Y3pRdUV6MlVsUmJ1MFpMK0c5R0l3N1ZRUks4VmRUcHdV?=
 =?utf-8?B?Vm9QUDJidXluZUR2aStaaVZXS0ZUR3IyN2N2YjdmMEFIZXBTOXViOEVsSEs4?=
 =?utf-8?B?cG1IU0d2TmE1NEVHem5VMEhKbWFXdFJQVGFBYXpiNlRxQXkrdXFzK0F2anZ2?=
 =?utf-8?B?NWtObUs4N2JyNUJuZE14dTBKakd2Q0RTVmk4N1U0aWNiTXQ3L3hVdW9ZVHpr?=
 =?utf-8?B?YVNTUlhpMitWYjFmZGt5S2w4M1lTMFkxUXFXMnlaaWk0MTRIckZyRzVZbUpq?=
 =?utf-8?B?YmphSVBBbnBMcWZlYUFzbEhlUXFMbkpOMitYU2N5RVlhQXg0TEN6bTUrOHBu?=
 =?utf-8?B?VThwb2xrNFE2bDNqT2xSZ0N4eWRSdmx1TFExbXZCTFlORDVQQ1hEaldTYkx0?=
 =?utf-8?B?MFRVSDVkQ1lkc2ZaMUljQTNSNEYxVTJzTld3NmVmQ2FFNGhLMUJ4dm9hMFdy?=
 =?utf-8?B?bWVURDFRdHg4Q1JLZzRXU05FbEFkMWorNkM3VGdySzlnVWZCNXoxYy95ZjFz?=
 =?utf-8?B?bDJMOXh1WkkyRllmUkx2UWxrMkQxT0NJYnlMZ2xHajlWRkdWYjluaHRZWXI0?=
 =?utf-8?B?ZE9ibnBRdml4eHdIY29CSjZZM2JvOS8vY3pZRzVGYmhpZ3Njb1dWakJCUXdo?=
 =?utf-8?B?WTRXWW43bHdNc3ZwRHZIbGNVQi85OWZDejl5NklDcnBBZTBqZzFHdHBFNWE2?=
 =?utf-8?B?dUpEZEZ3QUtmQytleFowblRjMi9nZjVOM2IwbGMvWXVrSkxGbjBMMDJjTHJR?=
 =?utf-8?B?cmMzVFkyU21XWElsbkVsdmdsUW5SNXJZVkh4UXZ1UnBnRERSdUp2dVNKcUdZ?=
 =?utf-8?B?dTJVbEwyM2VQenU3MlIvRmh0c0ZqaFlMcWVaWk40dzVZaFpUdVhieGpKR3hS?=
 =?utf-8?B?ZkhEVDdRN1huZUlRU2dyVjJRZDVLV2txMi9qbUxqV0VIbGEyaVRkTHlxTmpK?=
 =?utf-8?B?bHVjZUcwZzZsUmNhZGkzdU5tTHNtVzU4N09zaEpmbEh6UmowTWpjWUpaWEVI?=
 =?utf-8?B?RWVraWc1MEhZM3JQRlI3cGF2RlYrdUxWWVNOYlBoMWRvMTlIREdzUjhjT0ZB?=
 =?utf-8?B?NzVFb1lGajlzemxmYnFjcjZNa1ZCS2NtOWlEUW1tV3VoTS9XaGlJY0VteGMv?=
 =?utf-8?B?ODFGY25HQUR6NWFNbTFTc1lNZ0RkWDJXeWlvYXRjZHBGR1RNc29zWS9iUzhx?=
 =?utf-8?B?NW1ieVdxbTZDUU9nbEY4L0VhaVhoVkZVaksrTzZQU0Z3Z1dHTG1VNW5ibjRD?=
 =?utf-8?B?WitUUEE4VVZoUUFjLzl4WEVxbmRScVJlTVBxL2JHa1VzUXpZVERVNTJJTitm?=
 =?utf-8?B?MTFEWjd0U1h0ai96VUlJSnhEaG5VOGw5bm1tWkJVOHg4QjVYNzFlcXRjejFC?=
 =?utf-8?B?Y1NDbHgvT1p5ZHo1RjZZelFraFR5ajQra1hna2xMeit6UURLNjdPcFE2YnE5?=
 =?utf-8?B?TFdtN214NlZSS0xPVi9LSHJEdGo4WFk5K09PU281R0t3T3k2ZVhoOFpBbWI0?=
 =?utf-8?B?UHMwNWdidWZPTnNBYm5keWFlU2NpM044QklwOFRHd2ZLdlRlNkhOajlSN3Fv?=
 =?utf-8?B?OEtlWTBsT0JkUlBPdUdpYXJPV3gxTE1pMTY0U1F5SEN5d0NQNzJhdnc5bnBW?=
 =?utf-8?B?dE1tUURodDBzNmdaNW44VFlnUUdzYVEwVXNEWEQxQkZ0L0owQTdkcXR2cGhX?=
 =?utf-8?B?RHc2UkxCWVJFbGwzd3ZuRk9oZDdrQWdsSHcyaGNsZ2lWdnYxZkNmdz09?=
X-Exchange-RoutingPolicyChecked:
	N1db1pQaR98nMPsauBs4yTeAixw02qCtj30MsT4O+5nwSWur2jDnm4vJ/HcMPQbNNVc0PIFi4vp3Qe96yftGT1t1Upu9DwN8k2wt9OqEuXnG2dHTvuyzaOR4WwwjqcTE3kb7kwRbfonZvNj6C+ZhM4kHvqI1FCA2XsaDoe3Dv5h+lTd/1k3WCNx+MOV/8hA2lzXiCeLnp2fr46QfupmOMD4EsBSFX4y4CiTy3+QP6mC7inq+PFMvv9H1epyVqE85HuIctGSDyZZ934xzXNaALdiPoA8oNd/y4Ippo6f3S8sgGfxiECXQilshz8ZUsuaAB8cD+itPeLUYX0Y5EhQHFQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U2G71ajH/BJQDnNYfbyam2F6mP82VdS75nxrQscgQ1wf1VXDmb+dGR7C7h1q3pMBlTw8ksSNH0buCQAYoArL0YfLbzgAVmV1Qu6Owf2aD9IdXcbExpxwh8g/VITvlAj4B5mlzAkQFB2paU7uqjLxI1Z+6din03iKniXkvbIzIyRoEGkCBMKVpEnHwnuznVzF/+EoYj8jHMysGMI/hYP3UL7TJjSZSRTavGLdim03tkHEFU+wu/nuMV7cNFZp/zrQdj2XwB5zjLAXvHHwgx01fUVojAABezQ5x/aI1FGTKN7T6IVlqeBe1NGec33t4v7pPv3V9VZ/13XPjrWzchUxX2GNromOEkTH4USjAJ6ZsjWurL7zCjeq6IGPoBFQpBV1nEOWifM66QLFQgFfuX/liAUqEmqBFQmaZhguGhTlDt5IVDsylOVcVh6Zh2mi2uvCWRXSjUTnwdmtt2ujtIXnp/8fKoGQxU8rTxFZGGiQXInlSAl32mdvqGckre2H+O+ktpSGUtXL2L3IDWfu77NFvH4loQGr6fH+/vx4yCJ6awx3NCr3978Jd/nwsj3WDPDdPRV5fdpon/XGkLpLcSH+s3542ngpgslltwgpc7W60KY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028d573f-8bf6-4e4a-626c-08df0cb49d1e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 07:49:58.2191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyrlsHyDTvXJsWyD/6qAxsT2Dl0viBRLVgLa8jJxxIhjasGMIrGBVEzagcYgESib9/qaIaY5ct3G/8G57EXBNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2609070084
X-Authority-Analysis: v=2.4 cv=VpYTxe2n c=1 sm=1 tr=0 ts=6a9e6cb2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=uherdBYGAAAA:8
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=zZKeZtA-gzGhcAFhDNoA:9 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: MG6WTr8kUFbl9IS0_aCguNgxzMPIupIO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4MyBTYWx0ZWRfX1hvXwpv9oczJ
 kQuY0d72KscGynlWXvL+s3azd0ii9AuvTiOew9QP8pPZrMTzfCpzhByt/tahJfdZY5/l/fkhkR8
 xuCUOgmKUjvle/n9URmrEqNP2KzYADqGgRGPEeAgdnkUnkofRKYA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4MyBTYWx0ZWRfXzlAO75av2nSJ
 65tf6xePRskOQsIWk6J1Cq9cAnGVFjMtEmhl4nYCc4rn7RhdDMvpOAXUKEzw4GwmROg3kGTjriW
 Niq8I9DMR7v9ySDvGCRXiJwefjYM0dItQvOHGaBp3fITrFBJMM0/fyi3JfFYXNEoICUPi0UNQWn
 A+yp4klSh0bnPPdzs59ca8Qh2n6svXA5seWluF3DrKHK0WksGvzRzgUZdbS8Bk5WHhVRELOh3G/
 ODljTKEaCOhcYH67ue2peE3m10JRY4ZNksvn8iPtPkl1jJyBnvQZCQpw4Xoywu9WkS39AuJB8A1
 xmTN5hwhMFBY/TETkj/MjuozN/4SDpZHVLim7cCHHmc+o4UaPuxbwunztDhYUivLa6701VKLxH+
 z/O6PDlp/V6jrDwAybLiuMT8+MiO4TE2NUXDzyRDAST5lQYBckjCXFwV9QKVYp6ZnMva+QqYwxQ
 Z6zzxCYf09HbTZwgizQ==
X-Proofpoint-GUID: MG6WTr8kUFbl9IS0_aCguNgxzMPIupIO

On 28/08/2026 14:49, Tal Zussman wrote:
> An IOCB_ATOMIC direct write to a block device can silently lose its
> torn-write guarantee in two ways:
> 
>     1. blkdev_direct_write() turns an -EBUSY from page cache invalidation
>        into a 0 return, so the whole write is retried through
>        blkdev_buffered_write(), with no atomicity guarantee.
> 
>     2. On a partial page pin, __blkdev_direct_IO_simple() and
>        __blkdev_direct_IO_async() submit what was pinned with REQ_ATOMIC
>        set and leave the rest to the buffered fallback.
> 
> The second case can be triggered deterministically. A 16K
> pwritev2(RWF_ATOMIC) whose last page is PROT_NONE, on a scsi_debug

If there is some scenario which does not allow the iovec to be written 
atomically for RWF_ATOMIC, then we should document it in the man pages 
description of RWF_ATOMIC.

> device with atomic_wr=1, completes short with only three of the four
> pages written, violating RWF_ATOMIC semantics.
> 
> Fail the I/O instead. Return -EAGAIN when page cache invalidation fails
> for IOCB_ATOMIC rather than retrying through the page cache, matching
> __iomap_dio_rw(), which treats the failure as transient and lets the
> caller retry. Release a short atomic pin and return -EFAULT before
> submission, which is what a direct write already returns when none of
> the buffer can be pinned. A sync atomic write can then never return
> short with a remainder, so the buffered fallback is never reached.
> 
> ext4 has the same fallback and only warns in it. 

It should reject it, as IOCB_ATOMIC would be ignored in that path.

> For block devices both
> ways in can be detected before any I/O is submitted, so fail early instead.
> 
> Fixes: caf336f81b3a ("block: Add fops atomic write support")
> Reported-by: Sashiko<sashiko-bot@kernel.org>
> Link:https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260802-blkdev-
> fixes-v1-0-a82fc549fd74*40columbia.edu?part=2__;IyU!!ACWV5N9M2RV99hQ!
> Ot6CcSo02WbMqinlLCziLAkOQYQGgeUA0ZNlGPWcDEbGge8zNfHyjKzp4_TU7rV9CEVu9_fWOEwt6d_RQBbgVw$<https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260802- 
> blkdev-fixes-v1-0-a82fc549fd74*40columbia.edu?part=2__;IyU!! 
> ACWV5N9M2RV99hQ! 
> Ot6CcSo02WbMqinlLCziLAkOQYQGgeUA0ZNlGPWcDEbGge8zNfHyjKzp4_TU7rV9CEVu9_fWOEwt6d_RQBbgVw$>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tal Zussman<tz2294@columbia.edu>
> ---
>    block/fops.c | 21 ++++++++++++++++++++-
>    1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index a3a709697b40..8769bb13df1c 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -87,6 +87,12 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>    	ret = blkdev_iov_iter_get_pages(&bio, iter, bdev);
>    	if (unlikely(ret))
>    		goto out;
> +	if ((iocb->ki_flags & IOCB_ATOMIC) && iov_iter_count(iter)) {

Could we even move this check into bio_iov_iter_get_pages()? 
bio_iov_iter_get_pages() is used in fs/iomap/direct-io.c in the same 
fashion, i.e. it's expected to be iter'ed only once for IOCB_ATOMIC.

If bio_iov_iter_get_pages() does not give all the pages for REQ_ATOMIC, 
then something is wrong and we should error. For this to work, we must 
ensure that bio_iov_iter_get_pages() is only called once for a 
REQ_ATOMIC bio - that would be the semantic.

> +		/* a short atomic write would be torn by definition */
> +		bio_release_pages(&bio, false);
> +		ret = -EFAULT;

Eh, generally we return -EINVAL for something which can't be written 
atomically - like in iomap_dio_bio_iter_one(). -EFAULT is not documented 
for RWF_ATOMIC (afair).

> +		goto out;
> +	}
>    	ret = bio.bi_iter.bi_size;
>    
>    	if (iov_iter_rw(iter) == WRITE)
> @@ -352,6 +358,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>    		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
>    		if (unlikely(ret))
>    			goto out_bio_put;
> +		if ((iocb->ki_flags & IOCB_ATOMIC) && iov_iter_count(iter)) {

At least this check could be factored out of 
__blkdev_direct_IO_simple(), right?

> +			/* a short atomic write would be torn by definition */
> +			bio_release_pages(bio, false);
> +			ret = -EFAULT;
> +			goto out_bio_put;
> +		}
>    	}
>    	dio->size = bio->bi_iter.bi_size;
>    
> @@ -691,8 +703,15 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
>    
>    	written = kiocb_invalidate_pages(iocb, count);
>    	if (written) {
> -		if (written == -EBUSY)
> +		/*
> +		 * The buffered write fallback cannot provide torn-write
> +		 * protection, so atomic writes must fail instead.
> +		 */

Would it be better to have this check in direct_write_fallback(), i.e. 
always -EAGAIN in direct_write_fallback() for IOCB_ATOMIC?

> +		if (written == -EBUSY) {
> +			if (iocb->ki_flags & IOCB_ATOMIC)
> +				return -EAGAIN;
>    			return 0;
> +		}
>    		return written;
>    	}
>    
> 
> -- 
> 2.39.5

