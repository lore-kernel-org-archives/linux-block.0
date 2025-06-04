Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611F1F3BA2
	for <linux-block@vger.kernel.org>; Wed,  4 Jun 2025 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022163; cv=fail; b=opLbxc2WW/sxFiN2AdAnohQIkbLNv/EX/3YszBsJx4NxU3J4JfGDR/+iDpHXVElMMN2PqAV6Og+IiKEUpvb1fOh2UhEAcVF36slszf7njgxdRJdJqYWLVp8x4CnitnfQEpLoV52TviWZk358FV77d2uUGR3nZAzEYpnrn5VEN6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022163; c=relaxed/simple;
	bh=l9iQRzp+aQmLqFMWv5XpDeuY1/OSqAK6zdoXLLuCbaQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jpsx8mwtZAOFrDseIYSVf6GXJZ9vIKJupvh8TmRYiYPVVg1YwdxDNShfaYqA3kzhLP8Um6nYaZ9CsUOhg4AqzobbM+zMAmpsjgySsvPg8+a9slNFX4v4UEXZGOR1UKtbnTBHA7xHq+o5GNKtEO9MiEhCcGhfhF+Nz7HdJTqtGDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iGMKUg2H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sB5151yB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iGMKUg2H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sB5151yB"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553MNNGd000885;
	Wed, 4 Jun 2025 07:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WhKwDOHsEM5RCwH4emDjCDI7JfbnJXi8p7c8oVHvo5g=; b=
	iGMKUg2HLtWC0aT22zEURAhqgDSfrlJgEUwT3HU7fiFFIo53jPi9LPpne6+IJb9G
	COQdVKErCjS/KPndi8KBt7z/a88JfpAAryu386GA5KSzzyeDvCK9IYQFHOMJhfA3
	JkliMSwyxqCVhvytOiOjRwiNHY/BewD4/MCu6RiDVvUavu1C1z9LqTKZoeQcbU5O
	K2Fj4t55SMT+rXgOe0N4EKZL25EvqJ394G23CQAcv30mmVh1VVS3MG9cKdJW1A1p
	W1WXrX3bkT3DwnsN8lGdAbqEtSL3J+yiWtvvfqiJrFDj/q1f4pE70/BO84OrXiYo
	3L4Yiggls9azaFTh7L+bNg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8due0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 07:29:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5547SEQ6034440;
	Wed, 4 Jun 2025 07:29:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7adr55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 07:29:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCX8Iy7HAij85rH8mjSFYPnL8Xna3cgkONhZx+Bz3XYkiuAjC/H7oMwbfVniOy4ly8bsZLjmhVRwxIcqj7en0dA39lzJQZ/RynSIyLaqN35AQHgMJjoLO/AptwWuKYjqqeTEJ1aBfEMoY4CdiI2RRr6NqFvyswUZA86oasoyr7juREqhjq/RA36cUHAyCsM/wcoeYLx0Yuh2KXNDHjSfTcATLG80MNrm6j2ADMxfuLarDCMAE34qzdZuvsVpxyd5yGZOLO4EnPI4tiIH6mQqKq/8JZS5bYL70ZwcxSJoCcjtwcN1GEUH1HWyDRdT2AjlM4dHJYjFoMCj4LwqNtVCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhKwDOHsEM5RCwH4emDjCDI7JfbnJXi8p7c8oVHvo5g=;
 b=GC1YxJn8ZbMjUuSAycY0BXJtkMyD6Z7eaXN5Onxqcwr8Xfa6hxFBMLgJIe5so/o8881LLD9RAsLCNSokw+TK5/kTfoqMUKH9vp8KK++LMoyCGTA0iIX/HJ/Lo2I9mPCaom90d4pPNADtk+qg2Ib2OZiu/yLT5TK3saX4xs53RePG+OPTN7ug5ujsdNFVA+QdcKYtDqjQmgtdVDdJF+PS23/1dz7gwM0+1fJJmw/k+boTTDGV6JP/xUX5hci8zK43hoJrBwtr9yR/i6svr83lTWiFwFuYkwJrI1/yaeyM/MSSrLWmZnbuAG6YKMYpKpWiaNGT9qXLmaw6bAyKVwvp9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhKwDOHsEM5RCwH4emDjCDI7JfbnJXi8p7c8oVHvo5g=;
 b=sB5151yB7g1B62j7aT++APt5ihlRf00zMNGaTMSs6yTF3j7B83Gj3WCxzcWmO0prz7c+FhbMIysPMld1V/SwCyXCTnBn2WoD27U00+XiKgh09FB4DLnoE2bbWui3u9FOHSDfEjyl5wAhRIzE4YSXSOs+TDdjQPpWsnm9c267SMs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB4860.namprd10.prod.outlook.com (2603:10b6:610:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 07:29:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8746.041; Wed, 4 Jun 2025
 07:29:13 +0000
Message-ID: <2f2c8bf5-4341-4247-8a7b-f9ddd1d63422@oracle.com>
Date: Wed, 4 Jun 2025 08:29:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix atomic write limits for stacked devices
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, martin.petersen@oracle.com, axboe@kernel.dk,
        ojaswin@linux.ibm.com, gjoyce@ibm.com
References: <20250603112804.1917861-1-nilay@linux.ibm.com>
 <07cfb3a1-c410-4544-ae4d-5808114e02d7@oracle.com>
 <0747313c-a70d-482f-8ea6-ce2dff772c2c@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0747313c-a70d-482f-8ea6-ce2dff772c2c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3e1e0a-cbaf-4d2a-00a8-08dda33980da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVBId1BiYmhlanRIS0YzTUZVd2FSZTFkV1FMVWU3alFxakNuV24xbWpJODAr?=
 =?utf-8?B?VnFMZWxaMnNQR0ZSY0c2R2tPY211aTRVNnNNd1hNelNoR29TUmVuenNkNk5y?=
 =?utf-8?B?UGVEZzNCSjBZMkQ3U3g5R0F6U0gwdHpTYUpEUnFxOHdtU0JYcm1nTHZHWE52?=
 =?utf-8?B?dDBDV25Xb0gxQy9ocXFIZHJZUW8vclllQW5JTlZUOS8zQS9NbmJ5RUorL3V0?=
 =?utf-8?B?VGxuN3BDUmlySDhQMGhmNjFJSmdRK1BFc0FVWkNsTDZGNlJyODlwQjU1SEVX?=
 =?utf-8?B?OFYzV1RzM1dpbTRnc05lWG9nK3Q1NTNsUTlJZjA2eUd6dldQRVRsa2VTZm5G?=
 =?utf-8?B?VFlZOVF2M2didUZpMXJPS0JSM0RCZ29GQVRWT1JwWkZOY1VFZ01hek5pVFdP?=
 =?utf-8?B?a3U1OG45dXREQWN1MUdrMnUwMnR3eVJZM1BoUjdZeC9SZW5Cb21MUCs1bXZR?=
 =?utf-8?B?R0JxMjRaRStZOUE5QStmNkRZNlhGZFRrNHlrZ2pySEx2aXY2YVdTQ0JQQlZv?=
 =?utf-8?B?Ui8vS25UOFlyN3NkNUI1NHgwK0dpSDRnaCtUM1dESER5d1laUGQ1U3ZpWjFi?=
 =?utf-8?B?ZzBzK0FKbHhKTm42c2xORWlyeHNYMmN1RkttdnRwNExIUWlncmd1UVVwQXE0?=
 =?utf-8?B?anBid2pGeWtFeXliNmJHWHJqN1g2VEFwNWkzSm1nQm1lYnJLWW9HKzM1YnhT?=
 =?utf-8?B?cmkxNlFMMC90b292OWlmWURBV2haclFUdkNmNUpLUllNOUJ1Mk9qYjZHbEk3?=
 =?utf-8?B?L2lZd1NUc1VyYXdCK3NwRUU4ZXA4YVJRSG14dmtWcUlqQkFJZ24rUUJSNVl2?=
 =?utf-8?B?eVlKR3ByUXlKZ2JSVVUvbGJIOEVGVlVmUnUvTFVha1FVVGh1SWdiaWhyRXFr?=
 =?utf-8?B?Vkpyd2QrMi9sWXMrTlZ0dWc3RXgrREluOUpld3FWKytoVC90R2VqYndNa21C?=
 =?utf-8?B?NFhmUkV5a3RjOURjeEZmbUJMeVM3YjZIcERUYzQ4T3QvWXJ6TEpuV3hHcU96?=
 =?utf-8?B?N2Q2djVpSytiY1JLZFpDdHEzbHFyWFAvbGdoTXVvcW90UFNWS0tQdWNKZ2FS?=
 =?utf-8?B?SzJTRG8rN1Y3RS8zVEtNRHZqZTRFTVIrcVNVeXRGM2NiODBRVkJlNzVEd2c1?=
 =?utf-8?B?UmxGSzdodm1tOGszT2ZSeHA0cWpwY1B5eGNySnExdUZLVXIvN0VKVUx6TFha?=
 =?utf-8?B?NWhLTC9nOVpIM2NwT0kyejFnbHVVUms5TUFPYnFoOVkyN0VPQzN3UW1yMjI4?=
 =?utf-8?B?S0tDNjQ4cFlDa3hLWnpXcHNNVTBvcGlacjZyRUlKT1hpODhoR1dCSEZRMksr?=
 =?utf-8?B?ZmRKQ09kZHRiOXhGRHplNUlGVHF2SjdTQSs0bGxLOFlFYUd0cHhxYVVSWFdS?=
 =?utf-8?B?WUNYbE9UTnhOL1BOSlZVSGQ1ajNYcFpZaUVXWTZMemtYc2JwUDNtbFR0alU1?=
 =?utf-8?B?Q1M0N0czZ3orSUdWT0tpcmY4NlhvTkVkeHRxTmJjcWJqcEhSUUJ2aVkwOWh3?=
 =?utf-8?B?WlhNbEZ2V1lBV0ExQTRySlAycVM1a1FsT3pncXNpV2lReHBhTmpkQzBtbG5T?=
 =?utf-8?B?M0ZHcFl5VmdMZVhEL1l5aWV6QTBiUWNrM0pzb3BhUFd3RURyQmxNZFFSUm5M?=
 =?utf-8?B?UUtpdDFvYm5yN2RsZGZDRHZJMm16M3E5dEo1S3A5R1pVM2RQek5DeVdmR0lK?=
 =?utf-8?B?VEptdDdtNEpOT09BVVpUYjRIYUtNdWc1Rk4wWVpzYUlsQjFQbjdCbzYwMkRO?=
 =?utf-8?B?LzBUbU8yVXVEMXZ2QlpTbDEvaGQxUGtybGdIU3RpM1NtYmtJTXNFMkRkaXht?=
 =?utf-8?B?TFVSQ3lwYldmVkRZV1VZQlQ5N3k3RVpYWlZCdTJFajViblpMenhIZnBrOG9Z?=
 =?utf-8?B?dm9pTkdzemJub2lKMGI5WnE2eWdHMGJMbURIWFI4Y1l4S3J6cmY4Q1hKZUpY?=
 =?utf-8?Q?VoLr06z+kx4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEVLUk5sVEVtVUt4cVRQYWV1OXZ2RHdqTlVoZGFyNjk0WktEcWlYZ1lzTUZN?=
 =?utf-8?B?ZGNQN25RWWRtaHVHblZrRllKM1puUzNTbkhEemxjOG0wTXlsV2lYT1R6TVNr?=
 =?utf-8?B?T2ZsVldsVkg5cVo4cmRUVWk2YnRld0JTV2p3Q1NYYmJoVVU1WUN0VEtjMk80?=
 =?utf-8?B?ZGlmYis2Uit5N1BtQTlsaUpBcE5PRDNoWlV3ZlVhSGdSVWUzVkRNc0EyNk9F?=
 =?utf-8?B?RGNFc2F2L0lldC9EQjBFYWlxWWZ3NWZqckMrSExNMVd0TnBKdEJ6NTQ0ajVl?=
 =?utf-8?B?QWxlRk8wMUdSTkdUYXRJbkdWdGR4Lyt6ckZpL05oT29POHVZU1lCVEpEVTFo?=
 =?utf-8?B?LzI0N0tuaXJMNTJVNm02SWlWMzY5WkpmdmQzcm5VZitFSENiMVRyQ0orakJT?=
 =?utf-8?B?RGNCZllPSTlIdW10TngrRDFsOVl6UkFzS2pycEo1d2tBWFE5Tjhsczc1TXI4?=
 =?utf-8?B?Q1A1eG9nU0ltY1ovUzdycHc0RW9GVFdoZWEvaWlSekc1bFNXTnhDRnV4eldO?=
 =?utf-8?B?VzJsbnAwY252dTUvRm12eFFFVHpzditsWFBYc0FST0hzZkR0c2FVQk9VMlBn?=
 =?utf-8?B?U2lvdTRoc25FZFJXT1hhWWk4Y3RjaXBuYldnN1FFcmJ6NGI1SHZtaWtSVVA2?=
 =?utf-8?B?bUZsYXhEakF0YXJlZ2VCdVg5UkZFaVRpcitDdFZ3TERRVVQxYlJ6by9KK09a?=
 =?utf-8?B?VzFkNkJMcnFNb09zOFQ1NndqZkEvR2hmUW1rYnlOSEpOaDlzbGdJOWZ2K1lI?=
 =?utf-8?B?NU5OOFFhTkgyeFFCTllpQW5uTjhuMzFTYkRWK0prRzlvMS9KUkRnd21HQnho?=
 =?utf-8?B?ZmlRMzJ5d3dtd0hocC9sVlJiUGJDTGlPQkVTU1JaNkFFZlV6d1hQNGVLZ2Ns?=
 =?utf-8?B?cUhxak9KcXRSaFZldEl4OVcvanNaNkM3SUJPSWZ0K1JzVnJ5T1RFMGZ0S1hm?=
 =?utf-8?B?Z1pvNTR4bXJCdS8zOXFWVUhDUm92OWJjYnpsR0J6TVByajkybG9xWGdobGR3?=
 =?utf-8?B?K1hBcWtvZWJGUFpzY3U3VmphZ1RRckp5YWkxSU9QK0Q3S1F4RnkrRWFjWFlX?=
 =?utf-8?B?MUtnenpIR1FZSlVpQnFJampLNkczamFrb1FuM3Z4SENIYkxQNXphNm5QejZi?=
 =?utf-8?B?K3NicDd6dmtaSElTT3NkVEhtNGlYbTVjN1I5Vnk3bm5RMHJoeHZSSDhQNlhX?=
 =?utf-8?B?M1pnMkdCdTkrbDVIV1FIRUZIak5FditNS0tSR1RFaWZoZ20yb3EwRW9ocm9o?=
 =?utf-8?B?WnVyRUdtdW80cUJNQ2JNNVRGRGdjZmJwalZzUFU0aGw1M21LckRLeG50ZWFx?=
 =?utf-8?B?RkVzb2s3SzNiQktEemV0S1NCd0JYZnVCb2ZpSkc2MXJQQzIvdTdYakhYTTRT?=
 =?utf-8?B?Tmk2aFRVMGljWmNZZWtMQVRsM0hFT2ZOcUxQOGlBSCtsNGpPbTBzNlhRM3F6?=
 =?utf-8?B?MlZaME0xR2NHV0lONjBqY3hBbFhaaThyWUpFV1RrVnhOa2VDVEloS3Evd29J?=
 =?utf-8?B?TWJ5MGs3S0tIZlB3RXJBQ2N2cjJLSUZpT2lrd1ZjSGlxemRCR1JkUHFnbUhE?=
 =?utf-8?B?RzZlUGlLYWM4OFJzVXB5MVNkWmI3UnJaRHNzRmlQeW9vNXM3dlBSOU4yUGU2?=
 =?utf-8?B?OWhsMFE3VnpsVnVSTmVTdEhEZU54YnpkZDQ1OEVmcm1ZUFlwdTkrOGRYZktw?=
 =?utf-8?B?RVhvNnNzUHU1MXYvc1ZWVVBCMnpPZ2kzS3FYYmM2T3dVdUdPeFZDYTUwRW0w?=
 =?utf-8?B?YTA3RStQT0x5b0xIcmx6YWlMRlhKL3h2VVJEVG15SUpDVXRPVkM5SWIzWjVG?=
 =?utf-8?B?SzhERFJ4SVBUU3lEZm5nZ0lUSzQybmdzQWJ2S0VKczllTGVGOHBjZU90OW5T?=
 =?utf-8?B?ZGlDeXY1Y2dwcllrcTZWWENpTDhZMEZPK1MzaVMrYnBPT1NiZ3dVamJ3WlZ4?=
 =?utf-8?B?dStHYytFL2RwTlRjUHVPWnZzV3ZwOWp1Q1hxd25QbWhWVmM2VUZaUG04K3Iw?=
 =?utf-8?B?Y3UrQWZJNTFRWXhYdHRNSVlVQTM5T3pVWFEwT3RjREhFWGY4MlozbDU3UFFw?=
 =?utf-8?B?WXRoRmp1VSt4bk85K0VlWDRDN0oyYmRMRVZwZzhXSG4yN1VmT050UEtORnp1?=
 =?utf-8?Q?kKnRd95q91VmyILSfrd1tlt57?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5SIaU6YuYMnIMi5ioXgFrpfxvraf7O3V0AgTOSub8v2PgSY+WSccjpoqvubXTFZMisDtE+dvrzqrey3w27GgJDz9xyPDrbi2ipcPTSIk1OorlFrQDWcNDn+7v2NVvJwLJ/GBSuwwGg56fzeCsXi32g3roB1dkDCvrTeFoOzYH86GgaQUeJ5+81Fwh7N9uD63JycbSWHW82YGt25oIGk5rvCIO0afobhIIawMjzb5ClYGZ/tF00U3AMam5OfD6vOlCX3HAzXJO4gX2pw1KItyDHYXPdLVQcjw3RnqBWIgwrK88QaC07U3t/KsxpHqyxDtO35FSK87t6D9uBLSzPepNrxJmNkp92GeIngYkIig5b/ywZs2qMXPB4asWZxfq6fKyogIRATn2GlmONmw62Sgy6ngEDYtwAxhreLSzaM291AHwXRmueJSas55pqpHGQROj1jTW1zuMJmpIj8yvVrMJb0FPAfTxO8DUO6jtHLk8uLK1DByRGo2zgmDVpszb89anmFuv3v+F77gALMrkd36zDjSwDpEP5gL3kgjZ7280QPmP9rr1zWlxwQejW4mAtg2lARPW+ooVjm/Ym3H77Q9Wr2Ie/PAQvuarx/YdtKR/uk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3e1e0a-cbaf-4d2a-00a8-08dda33980da
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 07:29:13.2214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaZ5LN9ELtxscv2/1vIvuaEO4jWSY3mrmmvdkQAe/avsU3USdcLVSWTt4hfPp9cSh7/0AWEBAbfJC0Ib8ORl2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506040060
X-Authority-Analysis: v=2.4 cv=Va/3PEp9 c=1 sm=1 tr=0 ts=683ff5cc b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=YjX2WyalEdnSVqivMXMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2MCBTYWx0ZWRfX0gOItiC1VS0L 9bNAoXsij6Ksph40ORm9eVbSjNZhwHhYXBRatXRqp5N869P1x8AglcjIYzD41DUpWkxQm8d0983 gX8T9oGAdEboDgOQf4YyAXcYA1xYlbjHx8uBWhc8VdB8Fgbk8fYvA+fevH78oA1Tx0KYL1VQ/xb
 pudV3kDgJi+a1r3ZWvkWMhN7dKrPwLPtPWD9H+NfqthcHiRjRSi3ARAgOIdxJAr+66USMBcR/KO yDs5ClVcb0K1ti/6WP8WE3w225UcxLX97QncBtsysTf3xUcF3H2Y3BBxTkZ1uB/Gz3VBzfyyOlS fzeBKJWxm4upuktDJV7/hVagVj1oxrF3xpHMqZg/5fg9OkTq5HGmWyLMm1XqQUn5VM+Q4/KmLR8
 1+Cgy5KH1xZtgveTYy+/p93qKfQJinxznz/rG6q1BExTBDoBqybv9Rq6FmcjebWekplGlESJ
X-Proofpoint-ORIG-GUID: 7xANZcxzxKs2ttKWabxqlrZ2mNVjXmfK
X-Proofpoint-GUID: 7xANZcxzxKs2ttKWabxqlrZ2mNVjXmfK

On 03/06/2025 16:16, Nilay Shroff wrote:
>>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>>> index a000daafbfb4..35c1354dd5ae 100644
>>> --- a/block/blk-settings.c
>>> +++ b/block/blk-settings.c
>>> @@ -598,8 +598,14 @@ static bool blk_stack_atomic_writes_head(struct queue_limits *t,
>>>            !blk_stack_atomic_writes_boundary_head(t, b))
>>>            return false;
>>>    -    if (t->io_min <= SECTOR_SIZE) {
>>> -        /* No chunk sectors, so use bottom device values directly */
>>> +    if (t->io_min <= SECTOR_SIZE ||
>>> +        (!(t->atomic_write_hw_unit_max % t->io_min) &&
>>> +         !(t->atomic_write_hw_unit_min % t->io_min))) {
>> So will this now break md raid0/10 or dm stripe when t->io_min is set (> SECTOR_SIZE)? I mean, for md raid0/10 or dm-stripe, we should be taking the chunk size into account there and we now don't seem to be doing so now.
>>
> Shouldn't it be work good if we ensure that a bottom device atomic write unit min/max are
> aligned with the top device chunk sectors then top device could simply copy and use the
> bottom device atomic write limits directly? 

You need to be more specific when you say "aligned".

Consider chunk sectors for md raid0 is 16KB and 
b->atomic_write_hw_unit_max is 32KB. Then we must reduce 
t->atomic_write_hw_unit_max to 16KB (so cannot use the value in 
b->atomic_write_hw_unit_max directly).

> Or do we have a special case for raid0/10 and
> dm-strip which can't handle atomic write if chunk size for stacked device is greater than
> SECTOR_SIZE?
> 
> BTW there's a typo in the above change, we should have the above if check written as below
> (my bad):
>      if (t->io_min <= SECTOR_SIZE ||
>          (!(b->atomic_write_hw_unit_max % t->io_min) &&
>           !(b->atomic_write_hw_unit_min % t->io_min))) {
>      ...
>      ...
> 
>> What is the value of top device io_min and physical_block_size in your example?
> The NVme disk which I am using has both t->io_min and t->physical_block_size set
> to 4096.

I need to test further, but maybe we can change the check to this:

if (t->io_min <= SECTOR_SIZE || t->io_min == t->physical_block_size) {
		/* No chunk sectors, so use bottom device values directly */
		t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
		t->atomic_write_hw_unit_min = b->atomic_write_hw_unit_min;
		t->atomic_write_hw_max = b->atomic_write_hw_max;
		return true;
}
