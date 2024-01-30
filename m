Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941966B37
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616923; cv=fail; b=Tp3ExVyht7qcO42j/Wd+glu1AgywQJoVgm1hUSkYKrBruzztmQ6xCjOygansfMtBNyKwFf3yum6BXGASYjZodry26d5iXB53WCmiAc7pnXht9HXI4+XPN2ezplGVA49oS3Ad54lToJJQFl3P2W75jr8nH5eh66A+ocKmcrU2Ku0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616923; c=relaxed/simple;
	bh=sp+uLO8sFPU2f/IbOsuN7k/jA5VGhglRfKf4RSh2wro=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZrbUoGS8ZNb789QVxEtBpCHN1in92ZZCHX0HlEY00TmO2ZK7AzpgobqC173fPQzu0rFDfCiSkruLM0VyQY7wdgW20UOru10OtlspcsAr68WUP0xI+QsZblS8/Pgu7hattNGSEWAUGtXPPlyrh4p8Juvl0aPrTyixmaUHbPjEioo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DjOY1DxF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XdXCyFBb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DjOY1DxF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XdXCyFBb"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UC9xQY006576;
	Tue, 30 Jan 2024 12:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kgpFdSZRiKGy2F3j5c8cDmtgkXg/2ZHylmFMGYs6ClA=;
 b=DjOY1DxF8Int4pVN+cur9t5mSsBNGbfFl7PIwQrHTHPldAmmVKmdtrHpMyI2aBwQIr2g
 XBdnfcnQN1m9n6BEBMYyWYhxdKbm8ZhMnAtvOxlqa9TTSnFF0FCbdeaap0wUcumPy1Eg
 Cba0Bh1laoGF6EcGLioC/50ZDxT0odSHU4t2WEiXSQtclhtm/P//StvkqKjhvZ98wlFE
 feTYkG1h7AcCOKgO/Q5JTybaoS3wCdn3lym4P11MyK0DAq9c6OJScJnvcf2gLO1Ao44S
 48evVYATTRffPRx1tfFSj2CWOUL6VskWglqoeItqRv/YLn2Xz6Z7g7s3jiQrcwlL/s11 UQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdpjv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 12:14:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UC9CZV014551;
	Tue, 30 Jan 2024 12:14:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr971nv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 12:14:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTEJk7adc86kJqcHf/40Vny2CCIjspkAWIIOrambFamJiUCm9vMHQUl37GM+9uU4n+SO8QvfM1UDBLk1QWENXnF/cVXU2OVexu5gmTjQaYzYdvV6IaeRaJWeBheZ0Zy/0XfyvfU5NPfgbMS7s/q7BBQG7SRLG266yB/FeDCtkX881Kkd4rucdWUNBRSTyn113L1DSDpGx2AxfThazciuRGTrFC/rKQGBb2ygibZh59rYskE1kZr/YWQzt0fnZrBEmA0zpMnsXRbWcolaP79K2COP5b+dUbqsvM6lujDLAY+h3RUZ+BU0LUkA5GokCBfxghMBqQ5dn256Cw7domIW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgpFdSZRiKGy2F3j5c8cDmtgkXg/2ZHylmFMGYs6ClA=;
 b=FB1NzTVcUaerLDbtdl2U/80Ja4x4vP6EvypQdSh6q+LdH/8GOlx2g6qfcztq/vEKYb+13sBbnVGEa2pKzvI6Rilvp6c5Yf2m5b5J9sMmCeIF2xwurZfxr+ppn1FZhEpzRhUq6wrYYPOKq15Yej9rAqXgVWXPEttFE5BwWLTHLXCbOvJgUC7m+aAMn/ntx9Dtq1nbZx6Li0I+KryXkYsv6nfZda1Ah/4Jqiz8Y+0MBMlx4zo/KF/gGmYdh+TiJlspetFs2etfPV8FiTQgF9PJ4kQnPn3Kx0gOrFZ4IBo8EM1Hdv4HKgI3dAIu0eLQf3GiKroNTvRoGdQWaib2e+tChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgpFdSZRiKGy2F3j5c8cDmtgkXg/2ZHylmFMGYs6ClA=;
 b=XdXCyFBbcTyCuVvrkscyYBJF/4BdIQcAffE8JnhWkjI6HBakhHqpNaCH5w2cwy2iDZznz9eaV7qAPNrD846ws/gAJHLMGx5TG7VGcnbFX2edkArqKqvy2fEcR9u8XyWFJzF3yrKrTN9TXKl4TO6brOdwRGK/3zAr1dswDO+LfOk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5975.namprd10.prod.outlook.com (2603:10b6:8:9d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.32; Tue, 30 Jan 2024 12:14:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 12:14:44 +0000
Message-ID: <e65301d3-7274-45fa-a64c-5039257aa333@oracle.com>
Date: Tue, 30 Jan 2024 12:14:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] block: use queue_limits_commit_update in
 queue_max_sectors_store
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
        Hannes Reinecke <hare@suse.de>
References: <20240128165813.3213508-1-hch@lst.de>
 <20240128165813.3213508-5-hch@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240128165813.3213508-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 482b2c17-3191-47d0-0702-08dc218d0b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	U2r3RG6UDhvKRaoowesoZWCtnDcQ09AEXvFUkV75frEc4/vxgdkk6YZ4o0Mov8w41B7BlwT6Bo6wE7gD4xLC1Xdb6T7nL3uZcQHUqqCf2uqOCFyZHXqZy7FhvRf1tPvoBAoUeptiMKOrR09rqC4wnQDGZG3SvzzyIm/eVDOHH2RYoXFoC4XkpACXqIEJuHTA74YJ8WjhNjcYjVv83Y5CTUja6TtFkDmFcsXdZvED8ug64yudAEfIovADPC+TZ02EXLkZTpB+rK1dXpBOLV3HJ4kdwaYqU3AwFvadtlD1js0Jj90BRxNHXznlyH27VDFqu4tdqHk0I/C9zpbIE+8TXlYsq8XDon+9zy/6q34MS0uDahTwc6Ot84i8izUnUYT0DMRzWkXfWOQdSt/WnzrZjmoH+escLFAJXExDOLERDHqVgAHIpXvP/y9Cie2HEx+axkpyupaOLHARg8otPTgMcwwSTdTwSON2wsAhCH99mhK1auGH8Dbs4DuBaMubx9sBWhJgZtHmgxIa8ULMANgfFFNiAMJxh7Q2OEQTTqAtfe34xrcG6khTYxya/vo9EZ3pN9qRuO5pp2FUcdIaGTP/VPujduOE0oNNstl41EnLw9W/lcUAO2zCXv8jRDVLUG0WosQoZotXyxSlwLb1iVz2dA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(31686004)(6512007)(36916002)(6506007)(6666004)(53546011)(83380400001)(36756003)(31696002)(86362001)(4744005)(8936002)(5660300002)(4326008)(41300700001)(38100700002)(66946007)(478600001)(2616005)(316002)(110136005)(6486002)(54906003)(66556008)(2906002)(7416002)(8676002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UEtLSFlRV25KMm9FWUNPZEJ1S1RVYVIvQVgzR1N3ZjBLdHhRVHhIVEIwc055?=
 =?utf-8?B?YWx5QkhHRGVoem5PRHlMdmFjUE9qekZ5RE9nRk1Udml6UEpXWk1LUUFoTWNa?=
 =?utf-8?B?ODh2ZmtjSURqR2kvSCszcXN3aFVvTmFHTE9EOTBHOGE4V0U1Znc1alFvcmFP?=
 =?utf-8?B?OVljRkNVOU1yN29laGlrTWxBbVlyOVQ4NHVpQjVrbEJTUitoL1VVeWZ2RUlZ?=
 =?utf-8?B?VC9hc05pd2FlQVE2K3FVSEU0RDBIbFJBaXgrWDRLcjlvRXk5SjRrYmdVMWFz?=
 =?utf-8?B?T25pRGVWYnlBRC8wTGx2UWhraWRDaDRJZk0wT0VqK1NvdGxKYnE3c1RJZGM4?=
 =?utf-8?B?cHlmMjduSXVDRy9wdUFiTlRiN3J0ZGp5ZWUxVnk4b2ZHcEs4VWxBR1NtNUti?=
 =?utf-8?B?eVJkYkxldllrTS81VFAxMDVGZnkzbG9hZlRmRzBFQkE3OVFvZUpGSzdxR0xF?=
 =?utf-8?B?QkczTkFDV2JVMXE1VEZHZTRTdXNxVFU2TmowSnlweGJsNUF4NVFxRURGSnBO?=
 =?utf-8?B?L25rS2R0SkYycWRUSE5qMUt0NDhBOVYvbXZmRlFaWkh0S0ZOeTlGWWZmVUxt?=
 =?utf-8?B?by8rbmtPWGF0cjk1TDlNd1I3bDZSakVjN2plenJmNEg5NHAxaFg5MitBMk9i?=
 =?utf-8?B?L2RuS2h0K3BnYzRvK29ERExjT2p0MS83V3NlUDlFZm1TQ0txZE1zT1d6UkJl?=
 =?utf-8?B?R2lnZE5PNWl4YjVrSXhLT0VUbVJwbGszcEJTZ0lGekU5TVAzeW5CWnBldDds?=
 =?utf-8?B?SGNDMWIxZVNDQ0tqZDM4cHF0UzgwQnJVcy9XZWFOY0NvKzlGMVRndUZ1dk1i?=
 =?utf-8?B?UWNhbjBaRmN3b01ETlRKaWhIcHp5U01lMFNyZVFSSXFhOXFRQ1Myd2NiZGRi?=
 =?utf-8?B?ZVJiWTRzOWx5c3c1U3U0R2RVT0FyK1llU1I0MUJxL3c3M3REUjZVYkRiWTFW?=
 =?utf-8?B?VnBlL1Q4YklidFVEejJuRWQ4RW5UVlU5dFUzWlpXNFZVUHV0VDZ0UGxRRUdz?=
 =?utf-8?B?MWV0TkdIYXVVMWN4R1ZWTmpxcDJsclZUNnI2MHZwd2dIdmV3ZkcwSTRtU3BM?=
 =?utf-8?B?cC9JcHpXUHVrOG1VRWRIR0doeFNWT1d0Rld3SGRRcjFnMmxHVGgyS3RHcWFL?=
 =?utf-8?B?MWVDZUZEY1g2VWN0MTBjbHRCVGZERnZSWk1OWG9MQnJreEs4LzMwUVlPb2Vh?=
 =?utf-8?B?dFJBcC9MOGdyTW5ZdEFUUzhoZEJ3YzhDUm94NlFZQWNHRm5TUWs5TDllUTgv?=
 =?utf-8?B?RXdJRnVCaFhyNUJhcDdBd0NDZ2NLTEpvYXErT0xpSzY2aUIxd3RkOFlKQ0t4?=
 =?utf-8?B?R0E1UnJidnV0VkdjSU5PK05ZS29IazBMbmwzbGw4dllnaHY0eWRlRVpJZGJY?=
 =?utf-8?B?WFBnVEdqZVgwYW1uaUFMMHZnaWFjeUhDU0hnOUlweWdxRTJDajR6cWZtMTBD?=
 =?utf-8?B?bVdacDNrNVdPMCtkTjVXR2NoL0p4WFYzd0VmV0thd3podWdIZVBxVnBwc1VG?=
 =?utf-8?B?enJtQ2QyaDJrTGJxWStlTTZKV2xWajgwRUJUOEg1WlJRd3NaUjl1SG40OVlq?=
 =?utf-8?B?Z0hzRXRUMStScEY3NXQ2OFNqSDlsSFJnVnhkbGxvM0hXVVZNVGdlVWFodVdI?=
 =?utf-8?B?dDNRakZvbjdlb3djV1VFZmVieUFoOW4xUDBzNDV5bzg1RUdOeFpQU3A5aHgy?=
 =?utf-8?B?MzFzQ2thenBMSkRKcXZTaHpDY1hITUZZMkFPMnRaa3pIcUlpRjZFVGdNdVd6?=
 =?utf-8?B?Y0lZNE4reWVocnZhNFVvdldQR0VsRVVSSElDbkt5eGQ0OU5SRVZqSUJjUTd1?=
 =?utf-8?B?dnErK2haMnRFSnczTGJkbEZGYkNMVVBJS240c0cwTFAzaWhnNVMwa1YxcGV3?=
 =?utf-8?B?ellRclF2bjFDZUJRYVZ1d1JsbVcxQ3d5bjF6eG9rbDhXcUNkNmJMc0VrSTRH?=
 =?utf-8?B?RUFGdHd3TmNyVDUyTWFHTVJKZy9HQnhQeUhnWVMrT0FacXhtNVZKc3NxRmZi?=
 =?utf-8?B?ODVmUWhiY0VMZkszNjdZT2hiM25FRlBIcmFKVjZ3SnM3YVZUZDBHaUZWVmxt?=
 =?utf-8?B?eDFxbXh3VkJreTNSaXRQbGhGem41STJTR3NFemx6cXc4R3U4WU5HV2g3OVpE?=
 =?utf-8?Q?KKg2GM5m8ZywC47ev+3DKaMtJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Om58Uqa5lfFOYyeYpGGOLIKtU9qDubbtorzp9jS1/N2NXwhrEeQh7ah/8yUpLkuGnh0QsKMy6SkozOVD1QRbtHhtX3WzUTz4rnPLxVA2ThPY0NDBc1RWClr42hQP8qnre7yayl+q0NrJ8x2dhJIzbMcKQUGW0qhtlZ1XtYTCK8R6+CoWDGkcM6tKkA7tAsQt912FeKq6p2xyqIXOxHxBZ0i/lGmi+x0VM9NROqQVqe5bISksWsGUw3IIii3RSbEUIf0kTtH6EPyaHM4C1P+D8DqrxCw5L7Ezk1DP6VeO37NE+D+rfNVS+BtYhOV0qtOuhcrq1FOd5Xyn5hPBgmPEN3C3lPcVdHb1a0KgcMd2EEaIxopSD8uR08/xMFVqnzvg1T+Q6nlOWQBfPm3q5vmX2Rjjhu2FnYmG4dwHAKl4rBbMS1KtZm7WujAdUSUYf7kMWDmu69limWl7B+NOizKJ67rLQdECxVN5mY+ajDYSz4dpUcvlZYi0BeULbSHptdqP32lUO1O3P1hwBNZRViu5xwgzvf/srM0EtoH+e+rtifKghLbXickUKg36ozx2hnQDl/whPslaZvn3H1fxdEIAxB+tP7wvukrN0O1NSnpoFAI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482b2c17-3191-47d0-0702-08dc218d0b5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 12:14:44.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnDWB+EJAAqEweL4Otdy0huFq8swgefdR9bXba7BQwwPhk3nx04+lLXSD1mpXhFuFekX6C7XX7eFbtJpi+fIoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300089
X-Proofpoint-ORIG-GUID: D5HMiYtoMR6rGxEK2Y_9jweHzChSsrnf
X-Proofpoint-GUID: D5HMiYtoMR6rGxEK2Y_9jweHzChSsrnf

On 28/01/2024 16:58, Christoph Hellwig wrote:
> Convert queue_max_sectors_store to use queue_limits_commit_update to
> check and update the max_sectors limit and freeze the queue before
> doing so to ensure we don't have requests in flight while changing
> the limits.
> 
> Note that this removes the previously held queue_lock that doesn't
> protect against any other reader or writer.

I don't really get why we specifically locked that code segment in 
queue_max_sectors_store() previously. Was it to ensure max_sectors and 
q->disk->bdi->io_pages are always atomically updated?


> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Feel free to add:
Reviewed-by: John Garry <john.g.garry@oracle.com>


