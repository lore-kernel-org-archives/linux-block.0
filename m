Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189020AF66
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445146; cv=fail; b=G1f6PhiqfkA+LAwN9QFVvOLotgEvgYmbLLSwRCtGrPk6vmtpkpPlagCMaZGOQ6Q/ksA4FXODyXFnNTmAJWd/G3WLZoGbD2caD9Eo4+iioIARYVbLcGImeNHftrunh5WUio2BVQXXnVkQpLB/MoqkKi5Pg3g0VuFgfL1aZ6B1lgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445146; c=relaxed/simple;
	bh=ZLOtxVE33a35vATh8Nb4BUBGLDh9028TiEs/FQXZer0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bNudZVyWJjyC3Wbk93MTFTPE5T6HFIydxDHg6pKoTxzPU+Oh6YpiGxK4oFiwAHsjqhXbVFsoOZ16BMfv2JvNHOMPbijDWJiKE9SjZoB8zfc+0aVz6f35wZm33RKyhGMaz0SrxmtpZzFDtoY/4Reh19aYxg6u24b6WvRqItkY4gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I8VPUk69; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k1xVP2sK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I8VPUk69";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k1xVP2sK"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fVPP014282;
	Thu, 13 Feb 2025 11:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=N+kw98gX0+2WGXpujieFYbpITOBpVVIH/cAFFoyNdMk=; b=
	I8VPUk69323vHKvNc9uOWQzagmtn4e1TTUlI2wgbRvkpEyuNcs1RqQ6IK+MW1N7E
	3yqhbQNQweHW9k6zVDKBabkL0nVEw5x9QA9RSraVLZeJzElYsZtYQSOdDd9FrWug
	s4g4t/S5/9uGr5LoCze9LrgB9m0DTIH3VKAXMY4h6j5MHArj6v+cLA5MhPTg+bgK
	rt0VtSkCAKS2B8f16+aWiJF+MQuNYvlUnmSefjpd9bOUTQjDrEMpxAXutug6BTGv
	H/MCHnIZZS+n17lwBBtmHIWsmIjPxzwIYFLu5oFXpVzGZiZLCbEBCY5xsdK8ljMz
	xg3uW/r3gpmzhhmi/PdbMQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qysdj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 11:12:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DAUNYA002651;
	Thu, 13 Feb 2025 11:12:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbksmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 11:12:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEOAmrUSvp6yp+cDrk6OY5MnH0DJ7J/mryguh5ArP9prE6Me72eoQaht9qFaz/PLWeULgNIvadIYW1I/b4vlvwQLf1z1s7b8UhutDZQ2LMXaASUFBAdvaj6NydD1Lx7bs8NDbazk1MUKm1zG0zBK7G/ucVpWVWGmNRgHyDXxfJnmo/8bleJGZe1MD7qoX7svH1FgiKYUBRqi6KNhoj307m8EnnD3ZHCj56Pahc+jxOF16Ee/haAnIdVJBsAvlOAsDAzBi1oT3O7e2j3QtItPUpbVd9V4xslaFwArUBPORpau57XP9Sm5XAiqTDF95HX0/No8VEe7ak5JEShMkBos6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+kw98gX0+2WGXpujieFYbpITOBpVVIH/cAFFoyNdMk=;
 b=Q/Oog/ZIVQiGIkzNYwywvGK0FlymDpqkjrRO0bwVfdG/oN4ib68tqKi0ZRqpR7I4NY4DnTdsj8YEc9oSsxBcT61QxCeNezZyhqPEZDkTQuKxAlr+KceZDZh31iMiLB1c+ytWTyC0dKB4k5nU/hal6otWXTj4zKbi+r9HOi5lSCAHkez//sMzOpXQhmdDXb6/evd+Iot2tK+F5sAP6u/wN/v3KHBDib+IAs2yeEaW4TCJdcrHkUEBt4X4dJ79fRpuKqSyFj92K2R6DQOwsa/NaMMkGsqOBQP7UHB4we1qUFEXqFHjpbT52E9q42DLw/goniW6hW/VsT+FR3sEeiWeHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+kw98gX0+2WGXpujieFYbpITOBpVVIH/cAFFoyNdMk=;
 b=k1xVP2sKM6KPTl07BMZ/xCGUExgxjXoWhXxiU64AvWhQyDHshOzv1JmVaxbK3WmjEwHdUMI4cUl3Y5+YVBp4vLoyGR9W6QrDfulK4iWrNATntemOmLZquhd52oE3CQNMrBS3HVufaj6vTpHpnqoDQL3PZDq3yTAg3vJLHiOn1Ec=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6401.namprd10.prod.outlook.com (2603:10b6:510:1ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.23; Thu, 13 Feb
 2025 11:12:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 11:12:11 +0000
Message-ID: <80fb598a-ed65-4e6f-9781-7742086a1d19@oracle.com>
Date: Thu, 13 Feb 2025 11:12:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <faf95365-5b55-40f6-82f8-195ccc3edb9e@oracle.com> <Z63CY9rE7X8m3nmv@fedora>
 <63bdc82a-fa01-44ae-9142-2cb649d34fb7@oracle.com> <Z63K99wkFLWqIfxW@fedora>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z63K99wkFLWqIfxW@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 904ad11a-92f1-4369-a939-08dd4c1f42ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Lys3TkVHTEhxVHBGdW5GRjVVZ0dFOGN3Zk5vUmZieDNrU21SSzVCa2FoeGYw?=
 =?utf-8?B?a2I5RVlDdkdkOFd2M0ZmMmw3TEZKRXBtenZiKzdSVk5laktoeWRGTmtaWWUx?=
 =?utf-8?B?Q3gzRFBOMnZCbVZxM2pMSmtmekJ0cWwybFl0bVpLUkU2WGYrNXQvK29UM0dL?=
 =?utf-8?B?NUhLU2RRdDYrS0tkd2hJRlA0bW1GU2NsTlhlVzF3NEg4ZHkzTll4VXozdVJj?=
 =?utf-8?B?MHl6SVI4Nit1VUlQQTliS0ttdHd6WkkvOHN4emc3d2wwSVVOUkx5VXNiR1Uz?=
 =?utf-8?B?YVo1S0hYWDhEeGF4eDdYTVkxREI2TFlMQ0IyOUJYdHk4cVNKNWNGdWR5SGFN?=
 =?utf-8?B?M3BiSjhDNnNRN2FndUhBejQvOWsrWG5qMHE5NU5YZEVlbG1QdXVodmRQSWJE?=
 =?utf-8?B?L08wY1o4MkFrTUk5KzRNVXcwSHFYVVFUUkpBdHJnOTdRRGs3U3VWc1QzZEdI?=
 =?utf-8?B?TitiRXZxNElkNGFIR1FxY1lxYU9VSlhSUmFvTXZlTU0wN3VPajNUblRFWWpO?=
 =?utf-8?B?S0lnQ3VQdEdjR3loLzFIZEdCSEc4TThJYU51Z0FFU01LZjBIK25wVldKNFZs?=
 =?utf-8?B?cGpTaUNFSGw3RlRoV1d4MVVsUVV5VFpuWjJlUTdLaFFhSlZab2U3R1BZY1No?=
 =?utf-8?B?RUw4MzFqbzhWNTZ0OTFLa3lhTVk4SzFnNGJOTndtMU1GUGlpMm1YODhVMUJ4?=
 =?utf-8?B?ejJnWVVHZlkraE1IZkxuamdHbVVDQnZEa0tHNlZteEw1bHVmak52SzZwRmJI?=
 =?utf-8?B?NkN3RDYyN3lSOEpkdXFjNXV6ZmpPQTNCTE1iK01BTmIrWlBCZDFCTitMM011?=
 =?utf-8?B?YjVtbVBNbDVQSG1kNTVlYzJteUpZUWlDSU51MjIwQ3hJdjVOK2o3RXBTYXBO?=
 =?utf-8?B?ZzZQSnEwU3UzQ2pKZk5pK2R1QjNJVlNWSlgwelovZjU3Y0VsM3BxS0lxWUMw?=
 =?utf-8?B?OFpJUjhJVGhyTkY4S0NDSGNjdXBXa3NSRWlnSXdFZ0RGWlE2TFJHTEtUYTZj?=
 =?utf-8?B?M05KcEZjQWxnVnZ6SUN5M3BsbkVVa1lxSmovcUFRaVRqeEY2Z3ZrZzFlMCsy?=
 =?utf-8?B?ckhoSXJ3VGFZSDZMKzVPVkZXaU8raUNhaWh4RkF3amMvR2Y3VGpRMTVVS29V?=
 =?utf-8?B?VkhJK1lGUFozUTJCc2VueVh0V1V2d3NiNnMvYkVQdzgyZmFpYnZ5R25uQUtG?=
 =?utf-8?B?K3kxUndjTE8vWnVwOWVVbnJHR3JXNlpXWm1jbERwbEtRTjlPYzJxcHN2THpM?=
 =?utf-8?B?ZzZHR2dtMEpWL2RXTUtYT0tKNnpXZ2ZGbEJMSDFPNllXaTFzakRNQ3psZWxr?=
 =?utf-8?B?aXE5M2JCUU45THlxNnpIam40djdXQzUvRFpiMFlQZ25hUXFyMWE5OFBXNm0x?=
 =?utf-8?B?cDBxZ3dFSHVJUlhPQlYwcExlNk51bjIvQVpNRi9ZdUNWeVRXTTFxSmtpMW1M?=
 =?utf-8?B?bjI0bmRWQktucEpMRHBORmVySDA5SUNvd2E0WlYycDhJd0NuRENCa1FnTURE?=
 =?utf-8?B?K3B3eU5uV2NEclNZM3AzNUhGeHdBcVc2ZWxwUnlQWjFhKzg1Sm9BajFkUFRY?=
 =?utf-8?B?Z0cvUjJyZ1RnbUQxd2VRby9TRG9JV3hLU2NaMUNiTk1jNTdPY1V6cU5QM0Ft?=
 =?utf-8?B?dXJEUFI0cEcwRWhEUU42VWREeXBFVVFKWWl0UkJYd2dIbHhiTmMxeXZZRUp1?=
 =?utf-8?B?L0Fqbmx4bk9DQWVQYy9Lbi9TQUZ0Mk9GVW5LbHk4cjdkVHZOb1kyNkdiSW8x?=
 =?utf-8?B?UXhjd1RYZ3JRY0FmbWdPNDdONXVnNEFGeVlRVHIxK3I5NVdNRWRkTkxhRTgz?=
 =?utf-8?B?dEpPMFdUQTFCMmN3cVhCQVlBMmRNU2hKNE82NTg4MVVSSGd5UXZCMFJZRXRS?=
 =?utf-8?Q?BoWCkyKbEs8zx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2JBUTY5VWtaWFM4RkZhWFdqZHVhS1NkcVcvYzBaZTIwTEpSQlVzOWtJVjBl?=
 =?utf-8?B?VUVpUW1UUTZJWERORW9vbEpsMmVsT1RUa3MvNmNETERqemVJUkczNHMwOVdD?=
 =?utf-8?B?cjZ4Wi93T2sxU2I2UWNGZXlVcytUS1gwTFhkSWJvcWMxU3dMbWxWTXN5NHJJ?=
 =?utf-8?B?UjhXVjZNWVhoMVFhRndySnBCSVhVb2pwcUh5dkN1ZkhDdjBKNWVLbGFOM0hM?=
 =?utf-8?B?YmdmNFpWaTA0TFVoVlJjSTZTV0ovd1l6ZnhIbEF6UzJrUjRqK2I1TGlYNi95?=
 =?utf-8?B?aVd0VXZoUFVVSSs3UFlaZUVqK2FqSGpCT285SDVIZ3ovbXFLeEtGVnJQUVJV?=
 =?utf-8?B?NUcraVROQ0ZuVitMNnFQeGZ3cFVPL0JxMGFSZXZ3Z1hmc0RiMEovQWtEbTdv?=
 =?utf-8?B?aHBhT24zdXE5bFJjL0VoSlhXS0JoSXI3SnF2NDNlVHI4WXJ6azhsWnFHVys0?=
 =?utf-8?B?ZGFXTzlCaEZIVnh1TGU0bldFK29zK1NPYUhRYUU5b0VwcmZFN3BPUUpMZHJ1?=
 =?utf-8?B?U0hkVmpkbVFOcG0rZlI1cG05eHovUEhObm1EQWkrTU9xd3YzWTJaek90WDE5?=
 =?utf-8?B?aitWclp4cVlqQkgwcktKdjM5QVJJdkxXZTBtRGpXT0x5UVZyYUI2UFJJYXlw?=
 =?utf-8?B?dk5lUUJOVGx2R2JNWVMwcjEvMHgvSGt1RHNBL2N6c09Gdk4wUVBMVnQvbW5q?=
 =?utf-8?B?UHpQeVZMYkNVbjI4YnBkeS93a3JrUmJtYmhwVmZvNkFlY3FwSkNWSFF2KzYx?=
 =?utf-8?B?UERiZE9yNzJvNHE5cXVkeElZRlIwR25RaWpGS1dSbTRuSXplMlRtK2k2QUZG?=
 =?utf-8?B?M0lpcW4wSkRRY1o4Mm9SWUpKU21BS0NvRW1mVkl2WHlIM2xjenZETUVYMXBx?=
 =?utf-8?B?WXp0SzRncnFWd0lEYVdxT0Vadk9SSGhLd0NXZ2FWVmNZekVoc1VkSExBYVRh?=
 =?utf-8?B?bU5ZTmJncmE3ZDRFbGQ4T2Y3OGQ0enh6MGVkdFZQaDdyR0VJQWpBVUZrSXpm?=
 =?utf-8?B?bkJNYlJpRXJ1TThLL3d6MUNXZ1NpazhrOUtpY1J2a1NjaTJ2UWR6VllRNjZX?=
 =?utf-8?B?bE50alJPZDJ0a05sR3JTS0J6MVZZY1VTZDVwRlp5UmQvVWppVVh6QVhmY0Nz?=
 =?utf-8?B?TXhqYjkxU1BPQ2VqT29TekRJQUw2VWMyVUZxWVM3YnBjL3BrZkM1SDBBTUtD?=
 =?utf-8?B?U2h5b09aTDBRZlVhNHZETVNSbzhLS1c2OEJOMzZ4dUpmYkpVcU5jS00yWm43?=
 =?utf-8?B?bStNMHJicm0vNk1SclYvR1M2UDlWYWJ0TXdJOFZLU053QTM1ZGZKTGQ4SU9o?=
 =?utf-8?B?dG9tY1JyWXIyN2xvUFp2S3l0anZoajg1VXpseG5QMzRpTE02b0xWTW91T2x6?=
 =?utf-8?B?MmRtcmVPdnlCaklGUTQ4dnBCWjFlK0tpNUFsWlRMVUxpZVBzQ2wxV0dqbGhE?=
 =?utf-8?B?VUIrSE0rNlpzOUhvaFVqNUVyOUxVNHNseFBKRzBDakxIODRQNjFvYmsyZDVJ?=
 =?utf-8?B?dUZPVkwxU0Q3NlZKc1ZiMVNYK29VRDBhTWdFMkZvc2tINmJMSWZiRk5mdWt5?=
 =?utf-8?B?SWdrcXRXaGVJTEZqTjZkSEtIMGVNV2Q1MG1iRmNHZ0N4K2REaCsvcXpHZms4?=
 =?utf-8?B?ZDhPNkJ6Q00rWFNuOFhFU0YvZ0thcVl2Mm56VHFTaWVoUEFyVHJVSHEwdVcv?=
 =?utf-8?B?M3V5eTE0WDVPamV1dVBkUDZORElFVlFuSWdiQ24rRjJxQkQvQTIvNmoycjNV?=
 =?utf-8?B?aHVTM1NydUx0WHZYWE1KU1NzcmsxTWZ2d21mNUxBaVdIN0lpL2ljYnhEa2ZK?=
 =?utf-8?B?Smxlb1haOC9PR2YxUWFlbGNhRHQ3VVFjMWtKM2JrZnp1S2hneGxjUWRhWStU?=
 =?utf-8?B?T2NlcDJ3UUFDMDBSWjdhNTB1ZGxpalRxZDJzRWdNdkYreUhsVXRGcXRvSThq?=
 =?utf-8?B?R1JaUjVQUENEN2tPdWpIYllKZEdFOElXcll1U0ZIeXVqeHh6eXA3Y0pqUk5O?=
 =?utf-8?B?YmVpNVozV1FOT1hwei93dDhIU01YSlhEZjlMaU4wOXJmZHZtR0NuT3ZBSytx?=
 =?utf-8?B?MEdYUzlXUjNHSjhFU05BbnZZcXZPUnhiblhRdnVTYVE4a3loVjVXUWtzdlFO?=
 =?utf-8?Q?R4gkgll8Ua5yLyTiBiLBQ5FpO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5DjNNLtf+B5OpGlzfGOkDWQqX40MDm6OHMX/tbUHcHFLcRqS4UYR/xudiSP4DrP9F9ScvGlQEnBLeLWHK7fNi+Td/OjbXJtCuqTiS1yEWyDW7C1Y1Z/dXV8BbeOUSFoTTJM55W19O0zeXUw00FXMMXEJ+qBBX9y9b2gaqGwmxOGDv08bBW3vInsgv1/eomhc5BkSRrVsH5Wr+kt+TA1lqhAhKnVn6euGb+SgKFg9AsIsfoafUCC0gDB9FM+Q+gjvfBHcuSkmsL/7GA8BznxG9/0bPKqRBhr4ntRdqOxeBzi0fuA6n/G4wvpK68oedzV49dEbaE8vcpDUivDSWDFgr0RsQe6AAFnBOi8jpDHbupiKIGyheP60ZZWVqOVaL4Vupn6Pl5utp0U6a/b4IpV/w5yTawxQGi8TA0FRBD1sbZ3bIqjyznosuSLYwEYY72Om0a/8F5T/+T9Y5z0Bst7CVJEq1m5Hs/H8MeQQEh1YTARf3lWI8A1hBtj9tNVOxHP1pR6HJqZ/we2ft3/1w4KIPLGmM8uHALk7URwXfhqOsJIlG/5Kzit940YAtUHrxAIvRmk6q6ZLQwriDppszSd4fdbdL4RL/F4mURUN3EkWERQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904ad11a-92f1-4369-a939-08dd4c1f42ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 11:12:10.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPaKe1dLWaIexadmPMrC86wM6PLyYyx7L1E0KIVxzJ2dY+drQRrV4Y66SH99nfjwFyRQTsSSZiLzQtc4+tpu9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=948
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502130085
X-Proofpoint-ORIG-GUID: -h9421ULMhhCACrNm4mteYT171y_MU8t
X-Proofpoint-GUID: -h9421ULMhhCACrNm4mteYT171y_MU8t

On 13/02/2025 10:35, Ming Lei wrote:
>>> BLK_MIN_SEGMENT_SIZE is just one hint which can be used to check if one
>>> bvec can fit in single segment quickly, otherwise the normal split code
>>> path is run into.
>> So consider we have PAGE_SIZE > 4k and max_segment_size=4k, if an iovec has
>> PAGE_SIZE then a bvec can also have PAGE_SIZE but then we need to split into
>> multiple segments, right?
> Yes, hardware limit needs to be respected.
> 
> Looks one write atomic application trouble in case of 64K page size,
> and it can't work w/wo this patchset.

I think that we need to take max_segment_size into account in 
blk_queue_max_guaranteed_bio(), like:

static unsigned int blk_queue_max_guaranteed_bio(struct queue_limits *lim)
{
	unsigned int max_segments = min(BIO_MAX_VECS, lim->max_segments);
	unsigned int length;

	length = min(max_segments, 2) * lim->logical_block_size;
	if (max_segments > 2)
		length += (max_segments - 2) * min(PAGE_SIZE, lim->max_segment_size);

	return length;
}

Note that blk_queue_max_guaranteed_bio() is only really relevant to dio, 
so assumes that the iov_iter follows the bdev dio rules

Thanks,
John
