Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB231CA82
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320289; cv=fail; b=IrZMyZc+ineObUirxtN4mgNHw8fCfnMF1Qo1DeXg2THHtcEfc17KPLAj/OViD2Ip6mrm+t1OpuhZWrLxjR2KExf2ngkOrrfaxkjQTBUVU4bZnHJ1yenlqGELn0N8Dx3bJo06sbEQLKEDY2FDeixw8eEnvatKd/wUvWpJ8cgrymY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320289; c=relaxed/simple;
	bh=K1UWjrMmG0v2RKlCAObzecSV8w+XcWGBStiUAT/MUw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FqaE31yXcGeDG8vZKxp7hM+y3szFfuKLZf3Syz0K07ufITWVegFHyR0IitAqvItVqxIR7LGjvTqtu3KHUjTETtV2GHHJC07P1xOozDOeXPCUvsa93lG2z1VO/7OqY2LTym0CuqLUmIPQ8yvmLqF5tIP2yv38jEoBA81a+eIa+SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WtAjKoBV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PVDqJcRJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WtAjKoBV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PVDqJcRJ"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4358YV08018837;
	Fri, 5 Apr 2024 12:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=apCCQgdnXUQK0CejVohOYVx2OefnBfj3md5vkU6xy2E=;
 b=WtAjKoBV6czTGVLjO85JrWmI6UBExWQql7Ris1kG0LGDbkg+xHv/ciMmgV9Zli3onzLJ
 6lUIxpb9KmMTJ5w5vXGHmWnLZ2I+68F77+1veL9G0yTp/cn1TiIEuTge6ctpOLvBA9AA
 5hepp5mcgdEPkAhV5Gc67Dryde2Chu5wFgzFGmuUWz2xs65Wozd6jLJJ7pBTje7AVTaP
 gk4S5KjNy9FrPt0ISOXBAFlypS1ExJWg7NPaLCOznksKu51EvxnK1v8MuC4aPxvXgLuT
 XqWMrSEzk5cOqSOf01EmKQmqtcDYQXSoIUG8KRvf1duyjL2lTJIEt0Q2sByz4cMWuCy1 ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com ([138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9evyud3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 12:31:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435BwO1v027132;
	Fri, 5 Apr 2024 12:31:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emnwuuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 12:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OV1CBehxT2y3EP3BVHIRE2uro3Sb2/TDQRu7yDwAOPdAD8lQjSDL//jFUM+Q/47UHO0huQu/QmWLOqJ3l8WDE/8gkkBmPD415pE2j+d3QBhnwbwDeIBcR5Ar3ktrxRJNuPzBdy9lpNUcMBUbSoiYrBDJx8NIPO1n6QFIFvpc+QWDFk3ivciZvWGvXWpX/5rhbWVvC7Je6kGbkZ5fONC3mHzsHJ8bPO2mjF8Wmhn7PopwvhRzRryDtJiP70CZ4b3b2mVGOchuykmLLV1ZlbfIdLKHfKUJD+NReGlEUKyQR8lWvZR3wDBR9fAcilMU7q1ktTtPTr9bDLhS02jc9LpGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apCCQgdnXUQK0CejVohOYVx2OefnBfj3md5vkU6xy2E=;
 b=bVSi3QMkwX0RNKJ8Hwsvk4kryqC5f1abFgo4fpXbGIrDg4gIOhPja+m+T71VYg+VRH0ELxA3RzSd/AnLoNLT4GSg0mjzL9dKLouVaKFNIeZ6HqBnSuCmdX6lkU5iUCczMNnffW8z0vy1QJpKqC2I8kFQm1h8fI3GsPmyo/mCEws6FqUFEu9AHarK50zLxLKh91/b7UUFg+yfOWeXxAnehZ/2rDgVq4qX3MYuhenRTxAMXf26lw9ekNcfCdvtiaUtAmWFpvA1qD2r1LqRd/sOBCgQKSdiEanyKblJzVRHZKDLptdZcuT8pUIN047nzw/7AFN3zuL4q/IsCc6vVj4Lag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apCCQgdnXUQK0CejVohOYVx2OefnBfj3md5vkU6xy2E=;
 b=PVDqJcRJVSYn98oJ/2BPwCo5mYCCqrydCeFI9XDEViRiBsGQmpRlS9bXkfKvmsUkaMQIHSAgjbGrIfIO4ZvAzJhkSYK+C1MP1efeyC72mKvjOHFfouZCt7GA2xUhGzKsxCmfu0/esXPaxYyMgjgr7yx3XpM1Bc6dzhVHEV1NGYw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6460.namprd10.prod.outlook.com (2603:10b6:510:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 12:31:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 12:31:18 +0000
Message-ID: <65a7c6b1-ad4e-4b27-b8b1-44d94a66bf7a@oracle.com>
Date: Fri, 5 Apr 2024 13:31:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: work around sparse in queue_limits_commit_update
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20240405085018.243260-1-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240405085018.243260-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6460:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YDOLaQeBRJbbri6wQ2X+wiLcj0j5UPu3MNkqWZhT1pihWchMxLG+b3WBGWH4VEVvDIZ5TQv/P0Gnx1jtzRifwFkapELu0cHj9gqF+60LSrmQyVp8SHBHWkM+iAsRzQ9OWPunUZDz8ZPd6on0tguFraA78QI/R/yXrFZlqmvnxwm/5tS+9Iwwzz9XJvSmUsz2dQxoGMOg2SC6azx08H/kOPkV1fEgA0212+sJfpUdeTG7NgpQtqHUVeMgGkQ5ANiBX9cgzUBqpB5K+BBX1LudGYtaRuyJbTYYNsBCGdqGijCKytCGqOVAxmaQtxZgJmI34iyR+v9lkfHq3rNiMOzK9c4meso8n+OYAJPeCG9LF4vklJ/Qhgc5CfOvRKOLUiFhncFDJmHUR8eevJELcjT+mERI1i3i+DjDmRKpJLT3v7u3IKnxfh641C7QVAN+QVoJ06vfa7hsk4KhS+tH/kRdTFykCEagVhjrfQJplrfM0dmCZRLlIb1eDGs5jAU2owpUxOwyDqS2KpCquiPgadLryIr7ZcDZJHhvXvXNBvyCnKpYWoTDsMrs/1aKm6tlIPuNrMX+qWc8W+CM/2ckN4pT8GcPBChJN3gRHzb5J1XHjRf+a0Izh4M/W3iVHWM+I4F8Nyx/qz9Gv/zCFDhOIDZ/BqSQbECk489QQ8CNhviWt6U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TkZTRXFkT0FrSnZkazh6dnlRbEdpaTcvdDN6VTB1dm1aa21mZy8ybU5FSFV5?=
 =?utf-8?B?b1lYc3NUVGdEOWdhVWhXRlRXMXA4TGkzd0ZNQjVNd3VzSzNZWVJFUm5qUXZV?=
 =?utf-8?B?cU5Ic2lWMkxwUlY2ekdnazFWNVlBWmQ2QktDTmRkRWU5akJIY0I4MVgyYldr?=
 =?utf-8?B?U1J5Nk9VYnlFcWpDUGM1QVIzUlQxN1labVFndXJVdFJDdytwbGQwNWJUSFFB?=
 =?utf-8?B?amR2S1BxNzREb3ZvYUlaYXNsMzN1ZXVrb2FRYkM4N2VpTzdVNjBzQko2eXc5?=
 =?utf-8?B?WFpsWTJpQit3OGtJdmJDdmE2YmlvMXVxcFF3WTdHeWxURVNxczJnNlMvVmtv?=
 =?utf-8?B?MGlkV2duVHVWbUJBSS9sUkpmL2dsNGxaUGtDQUdzbjk5N3JrRitGanVucFpt?=
 =?utf-8?B?N0VqOXpPdGJ4K01HRGNDbC9IcW1vN2pBUHJOWXdZblZaRHVrQkZ5WTlTZEZi?=
 =?utf-8?B?b0pVMVE4blhZN2NYVzc5Tk0ySGdHZmhhVjZHY1RORXM2Y3pmcHphWm11WnhN?=
 =?utf-8?B?dFZ4dmNJbFVaWkk3ZTMwODZhd3dCaVkvWDd4VTZrZlUzbE9VK2gxcE9zRlV0?=
 =?utf-8?B?dCtPR0ZtbVJsdVdUSnB5UDNuN09xYzNkY1gzZzlEelczbFBLOTdWU1JyLzFG?=
 =?utf-8?B?SmlHRmllRDlyZFhvaGNoMDh5dW9IQ0pxOXd3M3RVS2VTbVhjNHI2S3dLOVNL?=
 =?utf-8?B?T1Npa0lvK1ZkbkFhR2hXZVVFdXZQY3Q0WHdCdHBYcDFQT0p3S05MU2xjZzR5?=
 =?utf-8?B?NGM3WGlnaCtKd1ZrUlBSb0FwU0o4aStHcFZhVndvd1JxTGtLdFF4eWRiWXFv?=
 =?utf-8?B?Q2R2RStVdDY2RmdTYTRlTndkZjZDbmMwNktJbjJHaVhFZkNkYTE3emg0OVdJ?=
 =?utf-8?B?Q1dGVzJmWmxxNTJtQkUwdlRBa3BpdVQwRXFtZ1NJcXltM2ErSWt2bG1oaW5K?=
 =?utf-8?B?ekJJL3pVSnN1aE50YWwwZmZNQVZEcTdqVmcySzZYMWp1OGt2ODViU3Mya0Y4?=
 =?utf-8?B?eTRxTFBSL2pzSnhvdktFeGNoQUszUWdZeUVXWTdRWGlIV0tLN2V2MHJIKzNL?=
 =?utf-8?B?dGY3QVBOWngrc1FBMnpXbG5TUHZ3akRTYUk1bzlvT0prbEFFMGc0ZnpCWDk4?=
 =?utf-8?B?THZXYW5iQThjTGNJbWVJdEhuOWhoNUNzTjJ2Q05weGxpKzFERkRyK1A0ZjBz?=
 =?utf-8?B?U0RCNFJxdlNVRHBvOXNwUGlRcXA3M3U3dnc0bW1zM05jK3BXOTZpYnNJVEM4?=
 =?utf-8?B?a3JjcW5EaVVFRUh1QUdOZHZJakNIUjZXVHdBRUhZcjN6QjZRRVZVdjhUcWF3?=
 =?utf-8?B?NzlKWldEY1IzK2hrYlgra3FuZWEwRVdNbklaZkFkRHJNV0VQTzR1ZE1mSk0v?=
 =?utf-8?B?WDNBbVVVRWlIeUVjL2ZxeEFpMmRZdzYxQ1FnaW44TFRxU3dYbUUvWVQvT2l5?=
 =?utf-8?B?NHNGcjVJZWlFRzBMb1VYM3BsT1Joa2ZTcW5aRFR3bVh1WDhLeGJuM2tFREJW?=
 =?utf-8?B?VmlUT3YvamxYWnArTmYyVnUvUzZRUHk1Qnd3YlJLL21xT1lUaWs3U2VZR09H?=
 =?utf-8?B?dXFsNzNMUU54aEJvMnhaeTJwQjRjMk1MNllKT1NUYWd5WHlpVGQ5dWk1LzR5?=
 =?utf-8?B?SXVodFF5VHowZG9seVdMNTZpUWRXQmp4ZGR0anA3a29DS3RVaVNzb09jNmdF?=
 =?utf-8?B?YlU4eFR3ZWNCYUF2M0o4ZXVYbnNTZE11Zk9jb3AxeXQ4VlJTT0IxZ2o5Qkly?=
 =?utf-8?B?ekNVQjZmU0R4ZmFaOXZ5Y05GVUdVbnNiMmxMRW0xSTRZV3QwcFBDdXlXREVV?=
 =?utf-8?B?RUJmRnFLaWlzU2Q3L2xNd2lNa3ZRY2ZoNENiSVRXQjlCT2c3QnBvVkxFSUVO?=
 =?utf-8?B?S0h6MHR2dEhKVmlxK0xxdDdlbTR6Zmh2OEM2Y0pKczhaKzlYY3BRbDhCTmpI?=
 =?utf-8?B?Qm5KTHNndUxhWHNCNXF6ZHJpb2p1RThOdk5yTGZ1Q2R3Z3Y0bG52aDNub1J5?=
 =?utf-8?B?bEdMSlh4ZWE3YngxaVlFYkxBSUVwczZnZ0VpS3ZDOHZMckZhTVJCT1RkSG5p?=
 =?utf-8?B?YXBPdHF1WTlSZE1ZbnRqNUNYL3NpdjduZzhCZzFCc21XVjRFWnQrK1g1MkhU?=
 =?utf-8?Q?NdNqvya5hD5ch+jM7IDKHdhuw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Paav0E6RP0rKKsSmqOs+He3gGXzSo56PxRNjQgBDGcrHbBYAptoXWAl/BmlaAmbHKnQtNxfJ/lGcyajN6auLUSUPMVRglnYICLvKsmtxt0Wq6cxBXJd9CRsog9QX+My0aiENLXcO5y5x68pPDGMbzG4jhztNQntHcTyV8fGXgSPjMwbCToS4V0Xkdk4bWW257E/L16jZPKvNM6LgeO11gvJKOi6S9Np9CF70x5uiKKFl7AgBiCBIjrGBGhiURx1/+d8P6EL1hfLu8D+xxH73j7e4fkwB2y3yeOYE2QPxxddP3c9vdjleCXJiz1CEsSDLLfIxoXEKEQqdQbvt0t+C6ibLToYZ+cGvdJ7ZlcTyAe9p71OyUtGZnSgUEliLHgVvDZIKaMHsS2wjCZN/R9VMn6i3RAFtK+uoceE59cfZJJA6xORNN9HVasS6XUM4v2PLNcJwzodfkLhuSdS5vaKRDhDo73SCLKvplqfwm6O3LEmqiQUOqIAS16zV7E0ZSMj/Yj3L8gS9HWLsc0lPrugohri6yN+3D4ruGqTreT5GQw7F+Hs22rSwqZVypev/fTASDP8hJiVRzVREDoaDNmB780cRpFfv3bk3w1rbG2PTOfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2871c7-2c9c-4a0a-cca9-08dc556c4b1c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 12:31:18.7988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+BoCuGEjdPf8zsWwkuQx/KCapt36GkwQ9Xe9X2isqq6JqDjkayJL+Y+rHjFWLAG84v67Xo2UTlg18RQa0btNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404050090
X-Proofpoint-GUID: bHH-pdp_j3oJhdjEVphdMNeFMwz9pmmQ
X-Proofpoint-ORIG-GUID: bHH-pdp_j3oJhdjEVphdMNeFMwz9pmmQ

On 05/04/2024 09:50, Christoph Hellwig wrote:
> The spare lock context tracking warns about the mutex unlock in
> queue_limits_commit_update despite the __releases annoation:
> 
> block/blk-settings.c:263:9: warning: context imbalance in 'queue_limits_commit_update' - wrong
> count at exit
> 
> As far as I can tell that is because the sparse lock tracking code is
> busted for inline functions.  Work around it by splitting an inline
> wrapper out of queue_limits_commit_update and doing the unlock there.

I find that just removing the __releases() from 
queue_limits_commit_update makes it go away.

I have been playing around with this and I can't see why.

I'm not convinced that mutexes are handled properly by sparse.

Here is a similar issue for net code:

john@localhost:~/mnt_sda4/john/mkp-scsi> make C=2 net/core/sock.o
   CHECK   scripts/mod/empty.c
   CALL    scripts/checksyscalls.sh
   DESCEND objtool
   INSTALL libsubcmd_headers
   CHECK   net/core/sock.c
net/core/sock.c:2393:9: warning: context imbalance in 'sk_clone_lock' - 
wrong count at exit
net/core/sock.c:2397:6: warning: context imbalance in 
'sk_free_unlock_clone' - unexpected unlock
net/core/sock.c:4034:13: warning: context imbalance in 'proto_seq_start' 
- wrong count at exit
net/core/sock.c:4046:13: warning: context imbalance in 'proto_seq_stop' 
- wrong count at exit
john@localhost:~/mnt_sda4/john/mkp-scsi>


static void proto_seq_stop(struct seq_file *seq, void *v)
	__releases(proto_list_mutex)
{
	mutex_unlock(&proto_list_mutex);
}

That seems similar to the queue_limits_commit_update problem, but no 
inlining.

Changing the q->limits_lock to a semaphore seems to make the issue go 
away; but how to annotate queue_limits_set() is tricky regardless, as it 
acquires and then releases silently.

Anyway, changing the code, below, for sparse when it seems somewhat 
broken/unreliable may not be the best approach.

Thanks,
John

> 
> Reported-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-settings.c   | 40 +++++++++++++++++-----------------------
>   include/linux/blkdev.h | 32 +++++++++++++++++++++++++++++---
>   2 files changed, 46 insertions(+), 26 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index cdbaef159c4bc3..9ef52b80965dc1 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -239,31 +239,20 @@ int blk_set_default_limits(struct queue_limits *lim)
>   	return blk_validate_limits(lim);
>   }
>   
> -/**
> - * queue_limits_commit_update - commit an atomic update of queue limits
> - * @q:		queue to update
> - * @lim:	limits to apply
> - *
> - * Apply the limits in @lim that were obtained from queue_limits_start_update()
> - * and updated by the caller to @q.
> - *
> - * Returns 0 if successful, else a negative error code.
> - */
> -int queue_limits_commit_update(struct request_queue *q,
> +int __queue_limits_commit_update(struct request_queue *q,
>   		struct queue_limits *lim)
> -	__releases(q->limits_lock)
>   {
> -	int error = blk_validate_limits(lim);
> -
> -	if (!error) {
> -		q->limits = *lim;
> -		if (q->disk)
> -			blk_apply_bdi_limits(q->disk->bdi, lim);
> -	}
> -	mutex_unlock(&q->limits_lock);
> -	return error;
> +	int error;
> +
> +	error = blk_validate_limits(lim);
> +	if (error)
> +		return error;
> +	q->limits = *lim;
> +	if (q->disk)
> +		blk_apply_bdi_limits(q->disk->bdi, lim);
> +	return 0;
>   }
> -EXPORT_SYMBOL_GPL(queue_limits_commit_update);
> +EXPORT_SYMBOL_GPL(__queue_limits_commit_update);
>   
>   /**
>    * queue_limits_set - apply queue limits to queue
> @@ -278,8 +267,13 @@ EXPORT_SYMBOL_GPL(queue_limits_commit_update);
>    */
>   int queue_limits_set(struct request_queue *q, struct queue_limits *lim)
>   {
> +	int error;
> +
>   	mutex_lock(&q->limits_lock);
> -	return queue_limits_commit_update(q, lim);
> +	error = __queue_limits_commit_update(q, lim);
> +	mutex_unlock(&q->limits_lock);
> +
> +	return error;
>   }
>   EXPORT_SYMBOL_GPL(queue_limits_set);
>   
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index c3e8f7cf96be9e..99f1d2fcec4a2a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -869,6 +869,15 @@ static inline unsigned int blk_chunk_sectors_left(sector_t offset,
>   	return chunk_sectors - (offset & (chunk_sectors - 1));
>   }
>   
> +/*
> + * Note: we want queue_limits_start_update to be inline to avoid passing a huge
> + * strut by value.  This in turn requires the part of queue_limits_commit_update
> + * that unlocks the mutex to be inline as well to not confuse the sparse lock
> + * context tracking.  Never use __queue_limits_commit_update directly.
> + */
> +int __queue_limits_commit_update(struct request_queue *q,
> +		struct queue_limits *lim);
> +
>   /**
>    * queue_limits_start_update - start an atomic update of queue limits
>    * @q:		queue to update
> @@ -883,13 +892,30 @@ static inline unsigned int blk_chunk_sectors_left(sector_t offset,
>    */
>   static inline struct queue_limits
>   queue_limits_start_update(struct request_queue *q)
> -	__acquires(q->limits_lock)
>   {
>   	mutex_lock(&q->limits_lock);
>   	return q->limits;
>   }
> -int queue_limits_commit_update(struct request_queue *q,
> -		struct queue_limits *lim);
> +
> +/**
> + * queue_limits_commit_update - commit an atomic update of queue limits
> + * @q:		queue to update
> + * @lim:	limits to apply
> + *
> + * Apply the limits in @lim that were obtained from queue_limits_start_update()
> + * and updated by the caller to @q.
> + *
> + * Returns 0 if successful, else a negative error code.
> + */
> +static inline int queue_limits_commit_update(struct request_queue *q,
> +		struct queue_limits *lim)
> +{
> +	int error = __queue_limits_commit_update(q, lim);
> +
> +	mutex_unlock(&q->limits_lock);
> +	return error;
> +}
> +
>   int queue_limits_set(struct request_queue *q, struct queue_limits *lim);
>   
>   /*

