Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0C15DBC5;
	Wed, 28 Feb 2024 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151587; cv=fail; b=JpyuhKf8fjiEVGwGGGojNClKCsy8CL6pD650AKkrIu1FhJKxbm+ydEtMcOpUpcMLSw/ri8NbeXMJ65O28/iXtsHgV5wTO1e7k7h2bntWTYueOXZTviW+NG7gjEbQ4pUqw9545iAhvaAUqbWvrLMg9TXaDdH3whfK6nzeEAeffeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151587; c=relaxed/simple;
	bh=UMWJPRzjGF3+2LDPsFrMcm6dKGAAu/5EWA4sA8a1Kdg=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=tbNhxmcXxV9/HLUGYT7QJN2GhAduB8qO0AtpUVo4RXlEz5vRtE8N+0VvcAp9vzbctzk7JK26qCS7cazhqyyYRVTYvj3r0SFacq2x0sFOxneSNJdJ0bV+R660kdBSZ0+bM1IfhJ8PAwnJvdnQWH5k8biK/oCrROQ87EEVLPdujfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QLBqCokB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jmi9SpTZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QLBqCokB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jmi9SpTZ"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SENZiJ017636;
	Wed, 28 Feb 2024 20:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=b2XAPijeUifqv3hFeOahUcgZ8tU8fqUjZnD45TkPIDY=;
 b=QLBqCokBz/xWNHxAcWbwdcw5LLWWFm88qs3g5oouvespBVYfcXcVCDI9j+aYJhpleJAy
 3WO8k6iMXj5BkBpxTXeWSsmQUoYrq8UgM2RDZCauM1qB0y4HZpHuFxf1mxoqGPCfy9CF
 jKBDAHUElWtB//3cqJOBvZ9nL69XLAo2OKjmV2tbwBM4ndeLlpkqY0hBVOrqPsXgsou+
 w5/CVj1arBjEhsHmajSz83RtFDm2/IlFDI8Ve/XXcXsNWySnTX1T2m+Hv5K535xGg3jd
 ee0CIqsOsdYPb7lZRfq1PfXQ7+1xibvJa1FsWT9YpuSG9kgvzZc4uGJNEQ5wDrTkLQ9F Jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdkksu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 20:19:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SJoaau015331;
	Wed, 28 Feb 2024 20:19:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9mvu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 20:19:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fem7VJ+7kacVadf4GHyO+4D6z//mShkc2GFxpDmE3LMfV+SWaNBzdJLEc8OD8mXKeEoSGn9NXhMnWc94NWPDD1mkoLxMhi1o+toQZcwVzKOnu+UufnWPTksBJ4MdNB4syAcuRLgCOUb/tDYQ4g2Cg6vNFdqynguWeTB7rhTcrwfUDFKAr+umwEmOQrTWKrIwZD6NUY6proSA7vUPlQXGxZ67n4HWLlIT8ZlsmA2V+jLw8IaXGqGyCAMyVH19ir+CXuXKlnifJzYDi7ySe8oDiU4VG0zvqcdkDrxW1nALNF+taVusnzc8HHWvX8hKs6Q/2J6vEMczSfbNYYp7W0yc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2XAPijeUifqv3hFeOahUcgZ8tU8fqUjZnD45TkPIDY=;
 b=Dq/VfTzR+pRy5iHNrtAETCt0u8y7HUvBLcgsl4nO0dl4axhRcPCZtfOWMBGB1c0D4kd2BxEbtTpelw2df7PlAq9sGiOP4tCxDHNERjqsVyv3uyWliY0bPyQV0v2u5ihRvpdXH013Fz1zYBFIc+EFineGIMQI1z+jgPlZxCG3k90bpGr9QpVlrX29aKY0g3feSJNtgA1BrgELja0Jp2J9FaM1Ut8K5sI85v2DP1iHLQKDYnNHkhmiFnPkuhRjip94CW1SiniZ1ZY2Oa2TOi681B52dSS3CLyzhUdEoAMdLOuS20+1whv4RRpH5/uuNjbkVT54SZAldUoKhMiyRuey6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2XAPijeUifqv3hFeOahUcgZ8tU8fqUjZnD45TkPIDY=;
 b=Jmi9SpTZu715wq8RtEFNVjbBVfzqB91wULxAoCYNWNJdzD/+imfzB8dnZWkxqjpeK4X0J8rSJY/2Kqw3oT3LBnZEg1P5HMvD6nVSyzk1O4CnGmhcGN8T+wz3MpYzok6PH8cxCxc+aXw/FaWrJSRJlPKunLZ0ZvIXhskWYTKlazI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB6699.namprd10.prod.outlook.com (2603:10b6:208:441::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 20:19:27 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 20:19:27 +0000
To: Harald Dunkel <harald.dunkel@aixigo.com>
Cc: Keith Busch <kbusch@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: RIP on discard, JMicron USB adaptor
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sf1c1h0x.fsf@ca-mkp.ca.oracle.com>
References: <70bc51d7-c8a2-4b06-ab7a-e321d20db49a@aixigo.com>
	<62296d89-f7e6-4f54-add8-35b531dc657c@rowland.harvard.edu>
	<Zd9Xbz3L6JEvBHHT@kbusch-mbp>
Date: Wed, 28 Feb 2024 15:19:25 -0500
In-Reply-To: <Zd9Xbz3L6JEvBHHT@kbusch-mbp> (Keith Busch's message of "Wed, 28
	Feb 2024 08:55:27 -0700")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0250.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 53160647-2a4b-4211-6f0f-08dc389a8fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pFHB/7TKLUVyRh5YsKR+ddXhQ03AGscS8rtRdcSzY3OVmFGrqJ5WHOHXwNulAC6SVN9WhAlqG6dkk7BgaNUuCA6zIQep3CwP9heWufG4H5Onq5XgVSGGiKu1GUkmILBaBdIUB/qlJTdSjkKZecuVWcU15tQ0sv26AqcG70GYrpTI4b7FOEIhxyQyoywFTpCjofbiem01v5yxov2u3XSNeGStttjML19eGGbJvIff9j2ixkcdhj16PWRHr/Sg+uSbkFoCl/W6DWzfFHv90c8uAtLzZ0kTbjtwsjFVggmpCtjzLpCdDIz69v8G5Ss/PSpxSrOzZaMqzwb+ClZlDhytcsmfGEYcz0oTQdSqe6loIMm1JzKgWemDZrDkyXSWlHcmEd0QwxvJ8yMWU1/cvh15a9W8YHvWCyIt8l1mXyL5t0JIytAlgPUBXy5/ni4QEGCID/MfqS+dHaXIDNB/bR93K8KpdyrnVh1rhi2zUOE9qefNnJ2Ax9z2UoQo4D3zbdwpf347P9fPFHmW7o47JyM8HzIhfAGOHBUdAFexMLsxDsuUWNyUMWscWytLm9qCxrro8A0tASIUX+HJS3wqn/Ol1BcHfGIXIrMaI4fkaRh+fTT2yxcQmGoF4yOruYZY7UomuNsuQ9Ne1N1uUkwNgCKWiA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?542U/fywIYUbX6/ICC/wh43YZoD60yPk/dDNGo6Zc80T/aBrKg6KMhEZFRjQ?=
 =?us-ascii?Q?ytlSlKJ7JEVHGqJc4z6igkIU8vWeZUdZ/RiC0q+o7dgxscVMUk6dHOyHcsH3?=
 =?us-ascii?Q?cp1gsgcIoVwI6wCovhw01k8N8KRyKFL5YuIS+jJU9Iobv2gluX/El5471Y46?=
 =?us-ascii?Q?LZVgEpRnkgM26jzTRC7evwlE7QB5U0hfSPEm0YaSjow/6IF6/MdroNiQ91NB?=
 =?us-ascii?Q?ht7fQmZBi5vy423pE4PWAXANhuLT1s95PxQweeuTFk8zDXSQB5kZB+WoRSdW?=
 =?us-ascii?Q?Q5VOzoyUGRWvO84p/Dte5untYgaSJV9Pt9hZZXMS59nUc92eCtX8V+OCasPn?=
 =?us-ascii?Q?md6H0m7Mcs4BBobrNfqEep8q1cweV5Y9Bhn/tEEnucJv3th7xhSru9madn7P?=
 =?us-ascii?Q?D6vvGfA8c3/xWKihsawcl5Qexk2zScNqOtAWoXUjuSmJOB+36fNsseotqwlD?=
 =?us-ascii?Q?pVybHj6l3rgJdfykugYonFtw4/UN4N6cuMnCzc002+TrVz0wCJ1CF5zyxMsI?=
 =?us-ascii?Q?MB4MwHkjbH0RWOMGo4qPKNuq2xN6H7M4RnlzDSJSj92sg4gCXiHiTS/UZytG?=
 =?us-ascii?Q?QmbsjuNR7/ajJnRqdOzok7wwzNLIzncfDGZqWl76MVUQj9PI+lZXIjmzMgoD?=
 =?us-ascii?Q?tsAX/wxBpRlxhIwuIj9CediDnSJaY7cqfJt4aL5EhDHbhNIUoJITYY9Hd7Y3?=
 =?us-ascii?Q?E7XQv9l85FAx835Du/4VVgg2xDiFRVgXtzeuMLYF0R/Ddsdmc2UKVMQmpYw2?=
 =?us-ascii?Q?Z27wxXhrYZqAcdyhfjymmGMo2S597B0VQXpa1ExXDHzIsO4iJgNkjpJKLH8X?=
 =?us-ascii?Q?4+HIsGibAKI9kn9i3GLG8QA6Rc/JuHtrWexy7EGZsA7bJFqZYpIKCVXWn5XY?=
 =?us-ascii?Q?J/JjZA/fE2/r9oyEM0l+TtsQqGoWkktcP5j5i8x2kd37lNsYruYzhgwqhkCN?=
 =?us-ascii?Q?vVpVYXDo81d0WhVJHS/j5s9bzz/6XTVAHKQMPbdioHuuWYJBXCmj0T61Kypp?=
 =?us-ascii?Q?QdGy8Dwmd/+qCk81LdzS60OftzBA/Q3xmlc0qW04zT4wfJmKxO6bl3StU3wO?=
 =?us-ascii?Q?EMGzxmGk/1CXFtbg8oU4U6z6aJcnAEmJJpvfwo/Mpz/HyH4pgEWzVEo7eZ0w?=
 =?us-ascii?Q?RQlTYju2fYrH4UuzYn3X13Ya2xuXXYnAT12L+QsNc4v3PpiqacmVy5ZAt6ug?=
 =?us-ascii?Q?Ise+Xg5aRhhmwsNrqNK2fPRKkGTz4gQxy0xcYa1KMJRNbFPUoZC6mu5r1KZ9?=
 =?us-ascii?Q?Cd61jFKte9jKkOnfJUpnMHFzo4fz3fNLWBwZOtgajF6EiW7eZ6aRr8Ih1SLu?=
 =?us-ascii?Q?+eJ8/mumlWiq5VeYX09qoEg8ncnIkRN0tCtg1lAR9Px12oGGDq1tJin8o6sT?=
 =?us-ascii?Q?BIT7alHerCVELcxiiCUamJl3xTDbkM7fb+8Sh1v6efJ3XEzhmrgIdvEVhE79?=
 =?us-ascii?Q?zPviwEf9bHrIStSInyVharJKHPr4ZOy9bKE5YvqZmuQBxmTnVAzaTH3PaHio?=
 =?us-ascii?Q?LuX3EHLlDdtDSArSAqUh5Q0vCCTJIjhmRznELfizN5mvUy0jfsQ136EZk2hp?=
 =?us-ascii?Q?7teBJDauFbFYitbLX1knwYUMl/9zqslgTLWfLobxAZeT7FhEGg1oeKpydGS2?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ueeq0w+DRmxflfiA8EKy4YuzB8Q2vVPp/8KkWUOxRrsTznA3h0ZyAEQBNTwx6XrC0wvqStzug3d8wqxBnXodteR8cmwT9muWECCKprbOvdSBX668ym+H6VLsSHE0zCfWYwcsPDLbXkPttaY7xqlS/e6UzociZ575tIoqKpZEzHrlfUaKDF7JDeTBgRqWewBJ2FBiZuHhC+i5gi7fApdtIoPx19x6OQ7IxbQLZ0DjmOF8EwyuTyFruVGjKwDEfUmkzxHgoU1G7In2yJNtK9HPa0Z936dEmfY4voOVv0H89ljukqf5KApAOlUvaIjEUAu9YmSEB55etV1G2bwCT/0ZDKS1JtLuf9t5lMqn5AStoWY0iHSPFGZfgAFGyZFqvumjit6LjHWOIsZHEx0L9p9aGr1RsIwagMlayz0mw3T/xpmeN5VLbLjmJCIsLd2UhK8eKpinx/AQ68w/CR0+02vJx4AP1n161jnlK/uJK6QnMyyXAdenkHK3eE1VJY7qdfPX6m8VjRWQo3EATwjOMAgf4NjZLg7lloPECCMm4lMGVk1YVWCgopKrfxAEzkQZIQN4oRgp9xR0+zgjQcBzjiJqMHDe/LH0TfmmM545ENIQUHo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53160647-2a4b-4211-6f0f-08dc389a8fcd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 20:19:27.0265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USEjqFbZtIYZ0nVOfU/1ErtaUhyaoR9c3y0UAKgGr2iAFkljFJ02OuxE11CH1mYBV9H/jxJqXR2WMI2nJsRhF1rE1NswBQPivFOUZE3xKso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=646 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280160
X-Proofpoint-ORIG-GUID: S_KGbry8o_-92dXHMjH2l_98zwrnATE7
X-Proofpoint-GUID: S_KGbry8o_-92dXHMjH2l_98zwrnATE7


Harald,

>> > I tried a discard on a Samsung PM981 1TB SSD (m.2) using a JMicron USB adaptor.
>> > 
>> > udev rule:
>> > 
>> > ACTION=="add|change", ATTRS{idVendor}=="152d",
>> > ATTRS{idProduct}=="0583", SUBSYSTEM=="scsi_disk",
>> > ATTR{provisioning_mode}="unmap"
>> > 
>> > Probably I was too optimistic.

> In the code comments above the WARN, this condition indicates "the
> discard granularity isn't set by buggy device driver". The block layer
> needs this set if your driver also sets the max_discard_sectors limit.

Please provide the output of:

# sg_readcap -l /dev/sdN
# sg_vpd -l /dev/sdN
# sg_vpd -p 0xb0 /dev/sdN
# sg_vpd -p 0xb1 /dev/sdN
# sg_vpd -p 0xb2 /dev/sdN
# sg_opcodes /dev/sdN

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
