Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976963EA967
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819015; cv=fail; b=lfo3GC7fFz81YaI0DsVioskDjhjGQtJUr1CiAdujmhKYW8jD/66hR5sBnY5A9w5pl0zvuBjunBPriG0vSsFa4hqwXUMZhc6HsYgb1gvCfJakyLsJGn6pcaRTJ4sc5I5aBK6T3aHRs6QQJfclaoLZu1Hp6ou7UEJFCksk6kKnMI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819015; c=relaxed/simple;
	bh=+dhIx7Rl7Q+telWuu69zkQn40d3qyMgrA0DkSwKcPyw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a79KVla6ndoW82LmEu/tJlTcQakvdldy/Ia/Xg4afiE0bx3yuK6M0YvsBhPeZ7A3BdvPZgeD4nDJ2yqQnYZs8ZvzS4PgHTxQT1+7LfVJ73MPja+B04cuF0nfDrFdDgaXJSFcW3KBsWywubjR0oNcYT4lsozzN8CuePNgwIkejkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=npsqNmFi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jNvQEu1y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="npsqNmFi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jNvQEu1y"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TNaRqY2181098;
	Tue, 30 Jun 2026 11:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qYkeWK/FBiT1PdScGZhJNLxvTjUDt3HwNn3kkJQkB+w=; b=
	npsqNmFiTNeNRYUShgI/YMguYD4VMeB54Zb2HIaQTHKxtrNdn7ARHtoM2fXBjAWS
	FXdEQ+vRSUN6r/3npi5/evEg8t5Tt8GbK4eg3QmsslOKl6mzhk5s8TEkG5vBGH88
	Lga4HsroFhLN0VY0SxjIikaj3JVXxI2uifq9Lao+LFw6pquCbqDd+veIo+3uUAZg
	sMhNUkgJYPF+QnMYdRv104wzlb6nDDLZObyLpjJ1QCDPvxmcbzpwGTRPoCwW9bWk
	o3r8R+n5lR4Nx3kuSLY2F8aaoBFpMVehDgR20dfgPQ3mhvVA1/DL/4thIkflpcJd
	18Zu2iw1j4MYZzTZqqBioQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26p8kyc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 11:30:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65UBN8rt029676;
	Tue, 30 Jun 2026 11:30:05 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f24ye9fr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 11:30:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6lFfyXrg4cS6QD6FKN0fgol+h0kOYt30lKYkklT86aPKDekzJoKd/kE9fwgZt98/YLxWghBy02iGI0MLs4qKS4hNmBxP1q9EJBOIAoFhLq4/RHkLsMkJXiDEJdUsrWy17ijn+HX3yUxk1UWbLGEWnwUEvPsAL0Bp2rElM0k4APgM47ihJuUpiOom7y+5APTbleal+39FmC7QgjtPCDIi3A6ygbZKRywIJSzOJ82SNwpDFCeahQT1oR9eodC1SBxWUv07Ag0FBitcE/nLA5KFkxXHbLGYZg1lBEQig8xEzhGPUGVPr778qPIF8Ym250M4TsgZXj/WBVvLr0dR5lSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYkeWK/FBiT1PdScGZhJNLxvTjUDt3HwNn3kkJQkB+w=;
 b=VoYDlgak7D9y1l/Sek/cxLD+KWzzf407O8tF0ULSiE1XEseN8AaJ1U1z8fmuvAu2Xm9pOgZQq2xlQXM3cNEa6GpK8IUsqtPPjxqVpnGFpOAbjjvHR9+yy1rn3q+SyaMPTVLk8+oQp7VTGtrGzeTlGfgxKlXwblSnY+hVn2QSeXYlCJL+t5jbLBXJHIDjuwP2366yFiUk2rrfczJjhNt/ICW3Ojn6Yq7XWmYhpDWvEDY4S3nxz78rO7zfrVp5ZUu264qmAyyK4x9FLTS3/fG0/dSO0eqNX9Xny16jK2MIRHiX6RAIWzTA1e2IHccb2VubsgSv9EytoppYz5IsjBBefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYkeWK/FBiT1PdScGZhJNLxvTjUDt3HwNn3kkJQkB+w=;
 b=jNvQEu1yxKyptGuwqBr4VA5ZaGz5ipWuLqEG3wWiW0ZNfXPCBqFOHsAc5Mm4pXymkdK42plmg4fIo1dZW2+KBrJAikKYXGm3iLeX+ZmHQC5uOwcFhopu0lGo5aE3l6ut1ydzhEeZi5X093DaHEpU72ichw4bEHMyZmKnIbNF55c=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 CH2PR10MB4229.namprd10.prod.outlook.com (2603:10b6:610:7a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Tue, 30 Jun 2026 11:30:03 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 11:30:02 +0000
Message-ID: <e3bce895-51e5-424e-8e86-8f5f295a9ae1@oracle.com>
Date: Tue, 30 Jun 2026 12:29:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/039: drain udev events before passthru
 error injection
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260630101936.2371-1-mateusz.nowicki@posteo.net>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260630101936.2371-1-mateusz.nowicki@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::17) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|CH2PR10MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b4dce2-07a8-4fff-02f4-08ded69aed27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SaHXpHgsP9o2lpanZ/lh0kLBsc1g3+dNTNXpqdwHwQ9Qy94qZkrxBtmNCydOl3Yeg7/w1eS69rU1Hy+krIVSfs9JfntswuvaCYgpok6SbGDCh0/DeaWucO3jaTCrw/4wFy/BLw+nBkjLO8GSP2fNFI1uEMsqoUp/YiHEETMk6mS1W5ue0qNJ/CBJlHbeaTWzviOjODql1HCaJXh2e2ylWH/qGc6eR38G4oTn2+Vg87fdpaW6P2HQhW0eSYwmqjyqQ5YcsuFCYow6jYKJG//LPF8lZgsBOMlz/f8B6HS/zlQYUvjHW6S/cyGfvE1zL3ccFfEYLCGH40zq3ySZBxRH23mWHkHzjfkmtqm6I2YxDz8ntXE1cUMmpBoNUxJqccAbxr2/aDZIrA2FEcOc2DTCiLZuP1pkg9yfczzClJSZxl5yx2OYyUvw6oO2kazS3K6Q/6og6WFNwc+Jvmhn1WGgiKUvJTd5/19bnj3EgYCIzJGPCrvoBFZjPemXwOv3JpCHSjQkuwx17SKpMiYEQ/vMkqJPBzpg3T9iO7U+ZqCCnmzBOUjudFdnLWK/uJAIgxilmLWIu7BFe9taGbFhxJXGpOURMMllhuqDF/E7Nh85tYDSVq1GeEeqez/iBFAkGYnswIPzS8RttqBfCNLXojMh2j49ZKjE5LIYBawwOvqEuUk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3ZoZVZuTGxsUlBxNGVZN0tGakhWMy9uc0QyY3RvSFRUQnVJcTZ5RWZ3OWVz?=
 =?utf-8?B?VGV2U0srSFJ3ek5nZjE3OFV5TzU1SW45alRTT0J5RzU0M21YOXRRNWJaYjM5?=
 =?utf-8?B?QlRUWldCZ2diSUJlUGhDRkNOMmhHczBKZk5ic3ZJTXF6K2ZFOFdKWDVlTll4?=
 =?utf-8?B?cEQydnJoVlllQmVhOVNNOUlnOGVNUUtjVkxRUmVBSzMxWE1zSDBuWWwwK2g0?=
 =?utf-8?B?ZEl6THZoTzBITEVWanQzWWZwZzJqTkMrV2tQUVBjZ2x4bXc1Q2F2alJkMW4r?=
 =?utf-8?B?VWpTdWVUT3JOQXhRclpuSE9ONDdjZnREa3JtOTdFUUpmRWVleWVxM1pCYW9D?=
 =?utf-8?B?Z2l5eEh3MlRITzdJeHRCVjNJNjRxTTFXbS9ac2ZETnRBUjhZV1FaNXBMYkxo?=
 =?utf-8?B?S0JWMkNNS2ZzTFdSU3lyRnpLckNEU3dOYkJWb3phcTRUbVl5VGJlb0k0emxp?=
 =?utf-8?B?dFhpNXZzUmNUaWJDUHgwZlNobXhGTnNzUndlc0J6NGhiYmxpMklCWWRHZHp4?=
 =?utf-8?B?V0hWUWcra1lVTHhyTzdzSnovOFJQL0dZUFR5OW4zYVEwOHNON2dBVmZwMFRH?=
 =?utf-8?B?MGNXdXpuS2d2OEdFUFVJaVN6Q01XVHRpMmtUUkxJRXZLQW9TYURmRDNzVHZM?=
 =?utf-8?B?Tm83am5PU0FqczlXeERrZDN1dm1ndmlWU0tlZUo2UURLY3JWdDVzd0pZS3dB?=
 =?utf-8?B?YUtKZEplYWI1b0N0WFFJUFkxQUswcmVGak9ZRzNDRzlPYjNWZ1M2NGhFb3lw?=
 =?utf-8?B?TjJ2b1lCbXhMTFhYMW5pSlpvRzE4ZDJoVWV3RXl6UXJNVUlrYTJ4c1V4L2xK?=
 =?utf-8?B?VkQ0a3JwSnZGRC90WnpFa3IwbGNoQklBenc1VDBweERpMEh1dXZSUVFVRVlB?=
 =?utf-8?B?NDhXRU9TRDNFMjZLcXErQ21wTkk4citXd2plZVVZM3VVZGxmb3N4Y09hOVdt?=
 =?utf-8?B?U0pCVmtZdERObnBsQzY3WnI1VkN6TFNKZE8xaVB5dnFueExaaVRhNDFqOVRv?=
 =?utf-8?B?Unl6VUN5bEI4bXM4eE5QMWt5WGwvTWhNTWpPRFA1S0lZRUpUMGdQNWtsUHBp?=
 =?utf-8?B?b2pyNE9KMmNYYm5BWk9vOXFMZ3ZVSlVtRFNOdmE4eVBZMGVDL1NBNlZLWlkv?=
 =?utf-8?B?aFV0aThHdUlKTzNTb3NuNDVIbFJtQThINjNNamo5VDFtaGFnRDlUZnVwbE9P?=
 =?utf-8?B?aDVTcWs2c0kzT1VqNW14QjdWa3ZSNStTdDV5d0lzTnJxc29nZUVmUm1ERThz?=
 =?utf-8?B?NkY4eXBpNDNGaXpBTi92QUl0U09pcTQ0RFYvczlWektUL2kwdEpuc1l1Nk5H?=
 =?utf-8?B?ZkdramtxQ2tNajdxVGtjS0N3TWZBeFVOYWkwS1NML2cxaHpQWEl0b05ES2Jl?=
 =?utf-8?B?Z3E0M0I1OFNXekl4eDdGc2U4L0MrdHJTUkNXbXhuYkhCMlpZUzBQMVQ3TGlL?=
 =?utf-8?B?SHV0Z0lwRkpiaEtVQWVMWTNqbUlXSmEyWkxiOUFUNG90Nm93N0NYRnVKdzAw?=
 =?utf-8?B?cWtsaVRxN1h0K3lJdmxReE55VWk3NTBRQ09DNHR2bi9pYkNHdjlxUHZRTm43?=
 =?utf-8?B?Mmt1QzRxWUNqbVIwYW5oQWNtbW11dzJSQWtBYjV4M2dmR1paMG90RVdMeUNE?=
 =?utf-8?B?UnNzVTRZTmgyc2JvanJERSthYTBRTnVjQUQ5ejdidEUvQUdMRWR1eHFkMEV6?=
 =?utf-8?B?ZEptVFFoRnFoaEZhVUl4bnM2RXVPZmRld1g5NHhzeFZuSmhsSk9hS3JJVzJi?=
 =?utf-8?B?R3o0NkZlZFJTN0hTU0lKdDJINVNPcFdpSjcyQmpYN3N6cXdTY1l0VFVNRDFR?=
 =?utf-8?B?cFpKbkdoNk9QWlRxRGh5Z255Y0puTEorZWY1UTJLa2JPQ0ZkUXNWNm0zUE9P?=
 =?utf-8?B?dTBSQzUxU1VIL1pnMVhEQ1cwYWZiN3NuN1NQQUJaTjdQKy92Ym1Ec1h1bzZB?=
 =?utf-8?B?ZFBWeEQxdnluYk5vbVNyZi9UQU4vZE5hRHI0QWNGVEcvUjhWWmFSOTBhVWNy?=
 =?utf-8?B?ZGJhOElLaDVocEx1UEFjczdpOVFTNGF4WXd2L2V3andmd3ErNVhENHBZYVVB?=
 =?utf-8?B?Z09OL0NwWTc0R1lIdXk4dU5LNERYTWM0MGZFdEFRYjdxZVVnL1hwVWEvZW5E?=
 =?utf-8?B?Ym10SS9YVE40Z2FEYUVjL0EwRnpQZUh3NlNzYzkreFRiOXJ4N0RaZjVNTUpn?=
 =?utf-8?B?aFltT253cHhJUlhDTTY5L1NhSEgyVnlhK0FtcFN6VXM3Mitod2NiSktwSW1n?=
 =?utf-8?B?QUUwbTl5Q1NyanplTkdDaWlvZUM4aklKbFYzWlhOV1dsb1Vla2xCYTVHM2Z6?=
 =?utf-8?B?cURDU0hESUNuTm9mbXNjU2FBUHU0dEI0d1FXaU5MTGtiOUhSSE13NVQyNHl1?=
 =?utf-8?Q?fiafcq+qoQfgfc3U=3D?=
X-Exchange-RoutingPolicyChecked:
	Iw+JnpJ2Q9hZ3gjpMFtBqJperYaYxMkGLu8zwtrp687Gy6PF5Sea8GA2z8+ObrugA4lN96rh3jlwlm4gnTF0csdUcY/qTNPwbgUBoPSCE91Dygmz23Ix6f6crekyCdZMkgD/U5l6CioT4G28MRsyzqMW3Ch8D2gFbH0FH0vfVF7BRiIv9lRuKFud+zMmEtVyYvNxnMwxhw9y647Kh8J3B9Gy3jNYXgNJ3Z/5GrLj3u7RPFXRlji/cQqoqThIfxnAd2b+3Q+2K35uE4pyEdxR6gIqgEpFz76ZkesyU981Uwlqv01VVRzhA98TYnOZ0hh3LWUW+8CrtV2L3Qa4CUgFtA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FzTIhzF0XnkVNgaCMmtcB+pLhOTRHJu0UFMolWy/l38jaRNLnhHf62L5EkC19zIn2z7dETUkJ2yC70Lr/P3GuEEOAkKI8qMWKFPuhmWHlYNG31NeZjAxm0WW4l2q6ENPFmCsrvW6USwd5HXv0fzjzxrRS57pj9bYns93WLhWRk9k+Nkn1Pz/X+gOY/8rX77yo2HyCGsFYMWsDvAFGL9BWvCKiqi4vkoLkzVT3cbTiy2g+xuGTUsQEnVd7Ldl9gf7D9xapgDhGilKcsdxRQuJl+04lhaOrL+2lFdztpiUA+1yZNGJnQJr6OC45a+fc4epaM8tcV0FOaKSAp1ZmpWm3ZPM/PBLZWuS23LrrbnasA2P1+4xhJ9C3RSvQUQF0p2XX2iOVr04eA7BejcKAzYZos/1SVgMG4/IhN1MGNXsRsyLKHT4FnWNJJVxi/F0G+BKfIs0Gljgp1lXnPd+hMNraz3mPStW9xYeQWiOKELx+T/+nLXnrF76pHELM+IANnRuxElTLDI6KOq52Q77Afftt4r878GaqSjfuAgUk/cOCe+rPwVlUnqrfeVzmjdrK14D/apKRQc2Ch7rqcS/J1upfRj6iUfI6+SRed9Wcf2kN5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b4dce2-07a8-4fff-02f4-08ded69aed27
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:30:02.8380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aa3YvP4sklWyaajafmTHNLQBMXfEkQ8UuZMaOh3AZ/uVKH0JTL8tc+I91s0ER0NFCymOfyIVsn/u1YmMd4etg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606300105
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEwNSBTYWx0ZWRfXyVdUtOofqmME
 G+g54NeO0QARQX25EqJvOqLESCLzhMP5MXRKvRxZlEED0RXqHLSysoWJIRxz8EL/jmPoO0WtdC1
 cZNmwEZIk1bGZsFC0XVriE8XENzDhpulwyVFM5TXU7Ap8e7TuzuE
X-Proofpoint-GUID: 9rx_cpFRDID28shNy9TnLvRdoXHrGyiU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEwNSBTYWx0ZWRfXyVAULZ7D0maU
 UTjVqa+ZTiazxEpkPmEyb1Tw5XypM47wMfJQAza9fnz83xLErVwaAjj9iVKnwLmhCpf3l8lOcO4
 0pKD8ZAWA5q2+b6dGEEX4GsJkq2jGTV7KBkeEJGqr1RjG0Nk7MC9NQKR/oA+1cqMFtrpy5izpYO
 cllRIXBD24LgC1cvifxzFKY1Yqbe0G7facdyGg+d6xOlRvwAnOIZyslNo9BOI4tNdbxT4EWdnVj
 BTN8GQ5SCkRjTY2nKC8gwFEncS/qDYeWmzuGC+MSA//dr9yRWa8drS9m1qXUVFhgSgyM/A7ChH8
 nkNJ9pI7Zx1mFKYvAWD8e9Jrx3h79fJroADxrF0bXVSgu2/NTM64CyB4FLcE8cwiFZTcTQ9a0ed
 nZLiRiKmni89FwrIt0QpPjOz1pr8AL1tWy/0J7yWSZPXAlDms2kW55uRMkIgGnAk8P2MGwXeoA2
 2ZSr7enk6VAls53eUXw==
X-Proofpoint-ORIG-GUID: 9rx_cpFRDID28shNy9TnLvRdoXHrGyiU
X-Authority-Analysis: v=2.4 cv=D5N37PRj c=1 sm=1 tr=0 ts=6a43a8be b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=uChsZFC9AAAA:8 a=bQQ6AK0MMJ2q2UfkJW4A:9 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22 a=ULtXvzFHYWHLyBAuiDia:22

+ linux-nvme

On 30/06/2026 11:19, Mateusz Nowicki wrote:
> From: Mateusz Nowicki <Mateusz.Nowicki@posteo.net>
> 
> When run repeatedly, nvme/039 fails intermittently with a regular block
> read error instead of the expected passthru line, e.g.:
> 
>    nvme0n1: Read(0x2) @ LBA 0, 8 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR

This is not the error which I was seeing, however this change seems to 
make the test pass reliably for the me. I have not debugged why the test 
was intermittently failing for me.

Please also note that I did trigger a kernel warn previously for this 
test and I posted a proposed fix in:

https://lore.kernel.org/linux-nvme/20260630102717.2671475-1-john.g.garry@oracle.com/T/#u

thanks

> 
> inject_write_fault_on_write() writes LBA 0 of the whole-disk device,
> whose release emits a change uevent that makes udev run blkid, reading
> LBA 0 asynchronously. The following passthru injection arms a one-shot
> fault (times=1); if the stray blkid read races in first it consumes the
> fault and is logged via nvme_log_error() (no cdw fields), so the expected
> passthru line is never emitted and the test fails.
> 
> Drain the pending uevent with udevadm settle before the passthru section.
> 
> Signed-off-by: Mateusz Nowicki <Mateusz.Nowicki@posteo.net>
> ---
>   tests/nvme/039 | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/nvme/039 b/tests/nvme/039
> index 7ca48ec..8c70c5c 100755
> --- a/tests/nvme/039
> +++ b/tests/nvme/039
> @@ -206,6 +206,8 @@ test_device() {
>   	inject_invalid_status_on_read "${ns_dev}"
>   	inject_write_fault_on_write "${ns_dev}"
>   
> +	udevadm settle
> +
>   	if [ -e "$TEST_DEV_SYSFS/passthru_err_log_enabled" ]; then
>   		_nvme_passthru_logging_setup "${ns_dev}" "${ctrl_dev}"
>   

