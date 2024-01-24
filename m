Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5F7F7C2
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116302; cv=fail; b=NLaZTa80qhtD7SD7AgJwvgugfNxwANVN85RE79splLqFUCFOBgzlPqnYvLMqpAN1GrT0ThPpAv9qK3DNJTL7vFw5CkR/hsi5+9KWLT//54oN6HDXZ3oQg7UrOYLFWqLMxSLhkYjxay2k54JJJhN6TfbD1PVE7XPi8U9c3/qhYdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116302; c=relaxed/simple;
	bh=0VLUip+BzwfomW/gHFPttXsIUhHwgYebyRtQqdsDRNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qf8D2k901OiCKxO28U7l2H9v9ABsl31cD/Cnmj730W6htH9HtSIuCAKsWVagJHY91BhLszEcm7T33CSZf9EbuM5M6TsKLqEkQuD9P6F3z+OgUZ3AeezoWNb2iazmRVUODO3sJDmED6sYnabvFAKPyj2O43laIXDmsUxTzxspPc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OlhfKKjv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hZPfyOxj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OlhfKKjv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hZPfyOxj"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OH2fPN001622;
	Wed, 24 Jan 2024 17:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0VLUip+BzwfomW/gHFPttXsIUhHwgYebyRtQqdsDRNc=;
 b=OlhfKKjvgAZDWQlxhWSLvDNKeb79BZkGrK/1tHGUHNruaigyac8efl9IyXwm/wQeHZQA
 pTO3uZl0uk7CxObqkBlI5AeyOaTEvmeYXLGS/bKhMP9Afd+HYWjwpPf61G+ASp2YcHEK
 WsUUS2w1xF6NUYAzIfW763At0Kq/KzOHrN5mqhdcwhkI+vCqxWj368zkrdetFoGRsUux
 xMWLaJeHP5mq08RrNiw5cSbn+VANL2FLygblOzrxgIpiqdd15yc5ODN2t2OjCA+zZqKH
 /bIVrTgUBV12ngmfvZm16CKTTFCKc5OhFW+tVdG0IGgV1XKuXkyiDU88cQHU5SOPYrtx KQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwm7dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 17:11:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OFx7w9030892;
	Wed, 24 Jan 2024 17:11:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs373gep5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 17:11:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpFjGsqq/149UEhRhsZw6DVyXFH9zmGguQ7XmBW86cJj0zLwKIhN9yjy2iJInyRi3LgqKrCr4UKmqD49sRiyqxxJCS1S+1I5RL0d1fFjSdU9wVHyLmYvE6ZRPOVDj0keuJakObHEjGbTnRv+hxJrGzlC1Nkdtp0lPzhoI83+HfKdw5RPperBZofisWVNV2nhDoMUOokl9CDvjkpc3xSFB1WOEA0S5Rd1Ys/fAlRKeWZcPJWDf7GfWsJO3vSA9krlCJnk/OQcQUO4GcDb8ygXnY5XdrK+MY1/su7a5jFsMuY1gIQHJvOyqfoJ/fDxqHDL4zoUz3Hf86owq18hSR/Wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VLUip+BzwfomW/gHFPttXsIUhHwgYebyRtQqdsDRNc=;
 b=lPnwna20HdVLKuu+WsXfH2DeTXuLMVeGNz8gle0Xx4r/gvXb1AWCQyQRU+zdHb1XS91hB0FobPeskBEhnYAQCvKWNOmEyBDQsjkkqzy8ysTXTqsDea6CJRVv9UvkZgVh5ucrsd+KquCmoi41rK0Ux+70+9g2AuJYiD9HAig6Wbh57zP6yXMKMw3Eavz7a2fh57oaxU8zB0k9a8L3S6lao8MXV4IqSrDjCDNmQkj7ZtDWeEBBoIom9aNAdZQtJMLXLAt2AKq2THCLVGqwT1l8YG6Upq6M0ij3fixI/brPNAhlVkITdijwGWZGddHd25Jf+p4dUIQowx+nwNv9Zk6iUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VLUip+BzwfomW/gHFPttXsIUhHwgYebyRtQqdsDRNc=;
 b=hZPfyOxjox+TvDdTvaKm31iy5kZotYsujUYW0SQN8pO+lWarjoRcruekFqlJxqfPlnbUfUO64ABxuWPcWoBx9U6uW8xRrwI0Cl5bPv6KiPVF16Je4isb1+dMAZz7ivrmEdb8216xNoc7ezp91yzrTB7WqSTa4A5mVNKwElzwnyA=
Received: from CO6PR10MB5537.namprd10.prod.outlook.com (2603:10b6:303:134::20)
 by BLAPR10MB4948.namprd10.prod.outlook.com (2603:10b6:208:307::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 17:11:27 +0000
Received: from CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::a6ec:9178:f73f:e03c]) by CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::a6ec:9178:f73f:e03c%2]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 17:11:27 +0000
Message-ID: <ad763f21-9431-465d-8c6c-286370313764@oracle.com>
Date: Wed, 24 Jan 2024 09:11:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, linux-block@vger.kernel.org
References: <20240116232728.3392996-1-alan.adamson@oracle.com>
 <20240118072419.GA21315@lst.de>
 <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>
 <20240123090506.GA31535@lst.de>
 <7d7d7855-8a37-4de1-a32b-2edf0b53a05c@oracle.com>
 <20240124090453.GB27760@lst.de>
 <d63f74b2-b455-4fd4-9b32-2657c6d81588@oracle.com>
 <ZbFCDQlFXIvpDHeX@kbusch-mbp.dhcp.thefacebook.com>
From: alan.adamson@oracle.com
In-Reply-To: <ZbFCDQlFXIvpDHeX@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0491.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::10) To CO6PR10MB5537.namprd10.prod.outlook.com
 (2603:10b6:303:134::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5537:EE_|BLAPR10MB4948:EE_
X-MS-Office365-Filtering-Correlation-Id: 844e1f59-a509-40bb-021e-08dc1cff7fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	I44/Na4AeQ1hDIQtroCTl9fYuHqwMbXJBS76Pb0A47StNN6C7sWHP/nkDNb5jJD6+90RruNahWmISude+6upqOYFQV/RhK+Tde6i4DDGM+eeSIO1nPV7imBidGNF8rhC8t93NjUuKtHTQgcrTphFuWLmOgHvFFuCXwlImM+TQBbKKko9Az1HZydhKMNH4myeUcaykX4AQsu7pDpUTsPMLstdEycBNm4IzFSbMc2fPb0GgJMQoNZ9qPTkwe3mBPwZHfB70/PvWwfRTPiWwfj2UxAz2V+jV9iEdTVfSeA59PdUgotnQwaRZwbevbwhJNpWA98ryD7Yrwt9ZKgdkvlNJsIifr0pGos3nuCIi3Zml8D86tWdu8ud7bkfNbYyxq1lHxf592JA/FW9HYcW6oWzJIIcKpRq2GJXCTcsQqj+Y0f1Lj+MgTmtcu1WYIQeQfI4RGRudR3ZpEEYOhrLcAAGalRIh4SjjQpewhYRVEgeVkECEq9kJmb5bQ/73S2jG7oKd/nUEA9SgBGLV3urXH98dCITg0ESn7PvrH5V8YebqRJr1h0amTo9X/4OKBCxwc23OS2uIEF8KygM7PtuxMQUdPo9SkRpJ3W5Xcw1WtvRCXPjhalgzG9ZfFvFJ1j2r5Nv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5537.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66946007)(66556008)(66476007)(6506007)(6916009)(316002)(6666004)(36756003)(53546011)(6512007)(86362001)(26005)(9686003)(2616005)(478600001)(6486002)(41300700001)(38100700002)(31696002)(83380400001)(4326008)(4744005)(31686004)(2906002)(5660300002)(8936002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWpFRzZTRE1PUWNvaHJPaTVWU1ZyNmFUMDJXdlFCZkF2ZWhreTcvb0I0K1ht?=
 =?utf-8?B?ME1NUG94QnBTYURTMWZ6MXE3MG1yQTg3TnN0OXVrZXhERXloUjBJSnFuSk0z?=
 =?utf-8?B?Q1NlbkJwQmJ5V2pHL0pWdDNIZXJpVFlpZnl6ekRmQVRZK3k4bDhSVmJLTXpx?=
 =?utf-8?B?VEc1RW00RXdEeC9KWEZhbGNQNEIvNXdEZHdRRW9MM291RmhBbkxzWG4xV0Nm?=
 =?utf-8?B?QUdoOWNvVTU2NmlWUE9rbU94SzhwdjRmNFkxYk5iSmhKendISU4ySExjZG1B?=
 =?utf-8?B?VmNVbmpPNlI0by9BRkJwRzRUY05PandKdkNmYlNUQXlUdlZ6amhHUWREWDQ0?=
 =?utf-8?B?MUk1QWJ5emIza2FhZDhmb0paOGhBOE0vSkJpdnJRZFNGUStzY1h5U3V6cWo2?=
 =?utf-8?B?QmJUTXdCMlF1L1lCeWhINW5pRlVLdk1IWFI0Zk14WkFVYWpGeGgzZ0VYdWVz?=
 =?utf-8?B?eVlVR3MvYzcvQ3NzWUUrN3ZlcWFHRmVoVWVSdVlNRnhZZmpMZys4ZzJyQ1c0?=
 =?utf-8?B?NmVYUlJIaVg1SWNtTTlpSGJ5aFZSWW1JcDdCYWY4NFplYXd5eURKa2tHY0NL?=
 =?utf-8?B?SkZZOTJRUk81OWpSUEg2eXJVV1lyaFA4Z24vTndZeW1zYUpwM3ltWDM2S2FX?=
 =?utf-8?B?UlEvKzRxSnFlR2Z4UCtRSmtOTG5ZZ1pmNUFQams4L21IelVLejFPbStPaWNH?=
 =?utf-8?B?eEtMaTlUWDIzUTVnbWpmNE1IYzlnT01JcGVuVTl5L2lZaHJkOEQwTjdZdkV5?=
 =?utf-8?B?djRpOUZJQmwyT3k3Vmt3UXVOTkhWb0IyZHpYSnJHbFBGUEI0dGdURWRUWXJy?=
 =?utf-8?B?Z3BmMWR4cTVuOW53d3pRQVVCZlIzY0VTbEdlMS95Z3ZsQVV6T2U0R1ZFa1Rx?=
 =?utf-8?B?OEFXUGN3RUF4bUo1akRIb3dVbzJUTkhIcXJ1U3Ixd1kyWFdDd1o2OXpndGJF?=
 =?utf-8?B?dUE2SVZOYTVmcXc0VDk0ejhqSnJHNEFUZDQ2ZVR6eXZHTUV4U2xqY0lCWFV5?=
 =?utf-8?B?cUgrWWxyUWMrTk5UUDRRZTBzdkhnaHZEZE5rOVBGS3pLTm9hby9UbVFVdXd2?=
 =?utf-8?B?dHluNFVBTnRMUzE4cTRXQ1lOUHJKcFhUazJiZE4rQ1E5UGw5d2tzTjZDbExN?=
 =?utf-8?B?WU1Fc1REUWFhMUh2WDdOZis2SUZXRXMzTVEza0VzRGd0cFkzWE12MzlOWHMx?=
 =?utf-8?B?V0Y2ZWdVdGtCN2Q0ZVNtZW1HeWxtR0xHQ0FESWR0dG1PY2F5RlUzMHNzd0lN?=
 =?utf-8?B?YWZ3L0JLVkhJcEhIMGgwdE9ORVR1cFdYMXFROFpiK29xVFB0WmZZVnBzRzZr?=
 =?utf-8?B?RnAxYm5oSDNPODE2UnlHYzJuM3FZRjdXZE5vVG83dUpzQmFydDM3c1Nwdnli?=
 =?utf-8?B?MitUV0toTmJITVlZMndWcjdrb3p3RitlUFJ1aW1XUDhmRjg3dTNkY09ROVNv?=
 =?utf-8?B?V1VkSkhSREFyMlNhUFBLUS9kMWtKWWE4UFhmbmhXNXFiNlpDZkY4ZjVrRGpm?=
 =?utf-8?B?UjlodzAyamE3ckw0dTFpZmFYUG5BMXhxUUV3K25naUt2Tkw4cHdMYmJsalN5?=
 =?utf-8?B?VUtvYVBTVkNIQjlweHBxUGp5R1hSVm1BT3ZjSHhqM3FBY0RxS0E3anJ4RUlp?=
 =?utf-8?B?Mk1MR2ErQmtNVUloTnZIelQrVTdLSFBnWVFYVGlueGhGOTN1UUVkRFVzTFhH?=
 =?utf-8?B?UmdkZ2hoVnJaMThJOWJFcm55ek9rUTF4V01Pc3BHTVhKTGJCMnBuZ0x1L1Q2?=
 =?utf-8?B?Zk5ncjIwTTYyRGVnaUxQNzVIekhreFpERDlidUhxQkhjZTdDKzVZVUFqVEpM?=
 =?utf-8?B?dVhPK1lzRElLS1NQL0Y3L2diTnZXVXJwdmRINUFFV0JwZ0d5U2RmZEl0NThR?=
 =?utf-8?B?dy9lc2JCZS80YSs3Sm4wQWU4S2QrM0NXV1MxNGJSU1dxbi9BSkpJU3FFNGR3?=
 =?utf-8?B?ZU1TKzg0bjNoNUdiN2ZHSSsvVEJubHlYWmphck9pTWRrZ0c3K3dGTStRaWhO?=
 =?utf-8?B?N2pvbmk5cHk5bGp0a05vVDV5dDhiWHM4bC9UZGt1L0dpWE9wNnBxK2l0Q2Nk?=
 =?utf-8?B?VHVreTFTZWgzdTlQekhzTUE2UW1YUXNWU3c4ai8yWU5GOXJ6cHVaNjZLM2Ey?=
 =?utf-8?B?V29wQ3cvbGJKUERIYm9JWEY4TmJpY3lCeGhMMDRIcnVGSU9OUHBPTmlhY2hD?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QEuZK/z4NsMJ9YCSHCLwyCU+9aSKEP4DEqvwCgxIewpsmv1E66dff8qHPtdvJmfWI3EdENoqpkJ6tlkI2fZ6Buu/zaSoYSv61rQNaGhUjF37gSR16TNEr0+Xr0tkrh6reomWIvY1otm++o3Yjb6oXiycIOPtwJTwq5V6Pd4e+l63v72OqzmKe4QHMMC2aLwkuo2+tFhgtVb8bTywUdB0fX+x681Vz1j0dLFOwv7RVSgEb73SNoeGS0f1wCTm8SZ6dYE0AoSiVrU05a7Ji6lwRCBnt7ktB3I0tNsX+tkv93HY6zU25cNym5XGgxDaRmjAUpz56XYkclYDue+ch5KstFjSc2oS4G98ZpRTaacOgQES9hoz4qDWka/hYBo71GMLvMPp4Jo/MyYeVPInVEwRVnijTf4vxvTSBBgLxXeYx5h/SKXxYnB/r7TPRrOeulUe3j42mfw6CoxozroipRJcHjVA9CYXQr6uhziU0Thsm4lWvcDpovg1thRB91pTaUW6GaNicfBelWtmKZIX5i3fQlFiWOTGjkXHG5arvnDqeRJCKdmSf7jyi55EUNzRLeOHsYTbMPWOa/bQHsOhReS8xEI17vzeF0MUSzSLoNyotvA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844e1f59-a509-40bb-021e-08dc1cff7fee
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5537.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:11:27.0265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaxhEFXHWUVAJNhEG0Bt5eLrrhuP09UDt+WzEFA0tJ0VTyfSxM5481lcZJ7GOBRQtB6CskWaO88XDgGLHOXVrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240125
X-Proofpoint-ORIG-GUID: kmdyaHnxt_d4ZROOSrmM4i0TQ003NqTv
X-Proofpoint-GUID: kmdyaHnxt_d4ZROOSrmM4i0TQ003NqTv


On 1/24/24 8:59 AM, Keith Busch wrote:
> On Wed, Jan 24, 2024 at 08:52:54AM -0800, alan.adamson@oracle.com wrote:
>> Thanks, I'll look at the block layer for this.  Do you think adding error
>> injection to qemu-nvme makes sense?
> I frequently added custom error injection to qemu, though it was always
> pretty hacky so I never upstreamed anything. Klaus may be interested in
> getting a feature like that integrated upstream if you're able to put
> something together.

Thanks, I'll put something together.

Alan

