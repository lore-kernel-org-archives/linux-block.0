Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2EE6A350
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618959; cv=fail; b=IXWLDie9C/PTY5KmrQ/UlxexT/ooOfGIUCnPHYoGg/y1qs2I1cCSQq8boYJFb376s4L19GISlsmGVzISVDFpPaoZXbetDZaz7KWXH9bv4UwbVCBpFjP2CuD0quHSqJRo5dYgMl72BmaglJltPewDr7CPro6AjVwg3Q6EBezhCHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618959; c=relaxed/simple;
	bh=ANLLjYL38hsdsIPI0kvT3dxRXOUjeZjiLwAuEb4FBc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ov0wbQxuLq/lmVXKxS+xeyd0j6v0YPHexLIoh+GlCeWpuUhAV1S7hiDh5PyhTMeG4kIpPoQmVhrgVq7DlXWd94dknKmS0hL1iXEoEvxBBZ7Lgfl/AM7kSwo09u1Ec0a2hJpBvX+L5q3PAIkBBwTWl5OPWH6WQ+8881+JPCzr7J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=axS+BUQL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=irabGwmL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="axS+BUQL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="irabGwmL"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UCAGqv008051;
	Tue, 30 Jan 2024 12:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9g+VY8jm2cdhCO7ljGfh63fxrpB02lsfZjPEsLQapEA=;
 b=axS+BUQLaaQm0LMfV/nkOb/qyWi+SPbkDEvdBUE91AxzME9yzddPtXNnmjqL+729Ur/1
 iR4UaqLRtovdNDURpSSWMTL0UPPbp7hLgGMZeEI8dATm9pEuxjsL5ZK8YwUuMNVy2dyR
 3OoWhIFuIDMgg06ZQpea5I14VesjLMecTm4kdW4TUnh82M92EgPJZTnoTt8Co8aRDFLY
 vuQEvIwYIhRlV1xvTIKk58ZhxsQKtQTIrjusXHw2KoOytYbZ1EGg2WrUp7gfCkULXNAk
 G4CmtS3gP2y8HZrmuTyeZVCOuny/nzPDEaJYe5f3ap7v7qixlJK+lITJN7jdqZOC2k/t YA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrceq9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 12:48:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UCiDda008481;
	Tue, 30 Jan 2024 12:48:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9dkeb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 12:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF4ftZpj4zETBvZzrZVpE+98177cQjlLds7AkkSCzAHVEr8EHdST73TGiINAONxjxR0FUNmZQ7hh8tNLv2kgZ3pga+ZMW8H2eVU5DtttK1KtzmXGUr6nYL1G5Gwy2ZG365hE5NRHOXdgU/ZOqyzeJuS8uR0Imo03JUifdEl0Xjt9MR2AtoP8u8+lC4jgScZmsfmCoLR+2e+e6TRoXNGoBCxUquxVlNkJfJDtfTakkrY4GhXkf4pUYeUbNAk0UM7rf83XNj/ty3zl/PYThFEjxpl7TtgScdmWOscUhfR35DCk12C06anocx9sa2yeaXY/mFkDwj7GXLpxCkusV2cLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g+VY8jm2cdhCO7ljGfh63fxrpB02lsfZjPEsLQapEA=;
 b=HQA7/VP9dCv2mqLCG2B2GOQaXcHN2m3Gh5qvQw6PEIJXVOX4hSs7L4KRdakLt9spLfEnf9W6zakjqNnTZSU+axdH2R76jDgR/wM7him9fYkSCKYzbaLWBofYFmzNQ/L8SP2ctFICmCem2rvwVoj+OFdAIM3kkRoGoByv587QTgpbKnSEtXdPgJ8T+0rUo6Uzci8A6IWuxFtwPNh3OEFZnS1/k+vy2ZgaOzag210haV4KeOpNS4xzz8KbzUyHMt9KTRpguXe1K0TlV4q6Y3NShDradNnZCg+oe6WcSmeCzjJxlp8JC9sQaJw6DEr+y0eVD14uZJHsKmNL/hGNWCjXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g+VY8jm2cdhCO7ljGfh63fxrpB02lsfZjPEsLQapEA=;
 b=irabGwmL6TZhP0VeQFZFsklqwKozRKs5AcjkJ4sXi9FRMP0s8YARL1xB8JoUH5OMw5P4QxqlJwTeKn7B/Y+DGHzU3iuz9miWlUhHV4a0qMQnQvy1O6b2/TaLx0fhFB6jpvLWpPTGQUJTvtekIuoVDCPspKskLbFLBQkBYTILTBw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4526.namprd10.prod.outlook.com (2603:10b6:a03:2d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 12:48:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 12:48:52 +0000
Message-ID: <4dfa7797-b724-42eb-9589-b0b7f8255eb2@oracle.com>
Date: Tue, 30 Jan 2024 12:48:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] block: pass a queue_limits argument to
 blk_alloc_queue
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
 <20240128165813.3213508-8-hch@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240128165813.3213508-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0170.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 0891cb2d-f566-4d96-7d1d-08dc2191cfb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5UaAB5ldkPS6omFjjeM8gTgv8Er/81FY9TYj5vUaH/tENvJ43f+05wb9NSDSSerPFzxQ1hiHsK0oBFLcprbK/dAMsIY2/pCwZAyrZMn6G7WZ7G2vXXn9IYJon4peg68aj+5KRsLYVCeSodatLPTR5nKhRZj8qvkFha1ZiQwNJv7ecKEi9HQJMCSnYbEXFxK4EDHt9+PNrPqqxGdpuojMfeR5NkTbLttjL7jF70vr24eYsQwvL5/1FbeLPPJXe+gi2vXUzCITZp96C62g6DmouTkmR6I5ZQSHGsY8acloFi2Ai/J59S62hab8wiwWDbPsIA62ypOr3XCnPZCfNpydXZ5Xf6gpaX1moYRqveGOLWuhvgHMI15kurWZyqq+Hs8+gB2f4lReWhjtqOtIFZZyu0jbuLwl1nURdOkufigXHyGcHxyKTKJL7kj85PjPNDtYNEY7pDRwa99Zm8nUDhIN3nJvBYoltdgmpMytmLItMX2rc9FdqCcoZmSCLe4Fg/5s6mDXa3tds3shdVzEaChvEKtDb9ZiOoogUobLyRcqEmf2VV2MUqvm4qqPtVoSAcvRe7TFTep9818zl1bv7lobET4Zoyex42pkyNYw++yf7q4sxjZTRj+uoUT5kHb9+EtBeTIB4gzkk7jQcNkyAKAgcA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(31696002)(86362001)(66476007)(4744005)(110136005)(66556008)(66946007)(54906003)(53546011)(36756003)(316002)(38100700002)(6486002)(6506007)(478600001)(36916002)(6512007)(83380400001)(6666004)(2616005)(26005)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RVRQNk1oY05uZG1wZkhaRDU2MlpTRWMrdkowSndZNk1CNC9GVkpEQXkzUFFX?=
 =?utf-8?B?QzRZVE4wbUlmTGFQM2NBUlVnaUpVQW1VeHZMTWZNZitRUVFHV0hHdXhCcW1q?=
 =?utf-8?B?MENEMEtpekljUWdXUmUzcVpCRE0zSXVDcE9HNGQwQmRYeTdGd1l0Wm9ySS9q?=
 =?utf-8?B?eEpwS0dNZzlrVk8rN1piNmszeFd4TlY3NDdxQTF4Z0tyeWJ5NjMreVd3OTAx?=
 =?utf-8?B?Z092c0RabGxxMGkwVElvVm82NUt4NGRBdlF4V3dnSnBOcXgrQWNlYmZUY3hY?=
 =?utf-8?B?UFhTcHNzWVFmMkdOM3J0c3dXOFFyMWRqTS9USUxGL0FYL3AzamZRYjNrVDJo?=
 =?utf-8?B?cmhiL3JKRW1tSzhEK2pjYmVWWi9NQVpuQXFDbFRrU2JmckVYajJhdmpvWDJU?=
 =?utf-8?B?U2RpRFRtdzQxZjB1MzB4UUV4dHRORUl5K3dxSU9BOXhSbkhPajBNampLcVBR?=
 =?utf-8?B?WWhHMTZld3pONzBwZEM3UW5vajVTc3FsNkpteHpmUm5ySktUTXpyTGtkU00v?=
 =?utf-8?B?MCtpYWJaYTN0ZXg5M3FibjNacUhGeVFaSU1FNzRFK1M3ZWl4SVAzRzBRNXoy?=
 =?utf-8?B?NkI3WEZYeTQxV2U5ZHltY0ljdWJwNDdGSHFDdXFReFQrbXpnVWNFWStHSG4z?=
 =?utf-8?B?c2dUTERsaVJWQlowTThMTEs5UDFxNVhWSGlUNFB5WTl5bWNDSnhueEsxT3Y1?=
 =?utf-8?B?ZzJtU1IzS2xiTEdKZ0xESHRkZ0w4eUE4YTBjejVZbk5FcHJPVXJYQTJ1a3BR?=
 =?utf-8?B?QmQ1TjZ2VXVZQlZhT3hVOHc4VnNWa0c1eldNYkVoT2wwMllRN3l6WGxBaXdC?=
 =?utf-8?B?bDl4VUEySzFWQTQ2VWZTZHBhbVF3cGcrbUNqR01LVnFGV0hxbmZQTVVJb3hK?=
 =?utf-8?B?ZzZ3cGppYkliTmV1ZkFjbFhkNVNob0F6cGgvNlcxWW10YktXOW54NzZhZUw0?=
 =?utf-8?B?YTUrQlRrYTVhTkZUa0I0c2tzcDc3RUhMQ1hXR0QwaVR2dXo1ZDM5WVY1dnJm?=
 =?utf-8?B?RDRZTGFHdmlFZW9xNHJWRk1NdWIyV2lhdEVhTG1jSjU2bnBmbHFLbHUycURU?=
 =?utf-8?B?SVZpTkdmTWlGbnhZSHcxVVFSd1ZSUFUwWmdXL2NjS3pkT1l3L09maWlHYXBU?=
 =?utf-8?B?OWF0OVhHSCtLblpOeThtYnRjaEN3dGlBbC9uOWdZc0huRG14Slk0Zmw5ck9j?=
 =?utf-8?B?aTB1ZUllZ1V3WVI0akhEMFRlbkxhQlJ6QzJmek8ybVZQd1lDZDBNSk1NTVVB?=
 =?utf-8?B?T25Uc2hNOExIZkI4WXl2MUJlVHlrVHUxVFkwVXdIWFhHMkxtZFp3ZnNQVFVZ?=
 =?utf-8?B?Nmt5NTIxcFo3dTJNRnFpZWNmTnVwMEI3V3pnQVNmSzBvMWtXWTZpK3J1VDR6?=
 =?utf-8?B?L2lhOVlteHp6UndBWGJiUjhFYUJSUHhWb1BGd2JDMVZiWEVLNUVFN3p5OFI4?=
 =?utf-8?B?eE9QL3lZYlU2bEViQStBcmlkQVpXWkliZWgrOWlKTmJZZytQclZQOUZNb2tU?=
 =?utf-8?B?SmdSS0ZrTUJuM01UY2VQNHJhUmVjdTJRRlJWaWtZbkJhcW5XUVNFbkZSMlVC?=
 =?utf-8?B?THloQWVSdUI0YUwrRFZJbzJVRDBrNk1ZalhQN0l1NEdEOHQ2Z05PSERrdFJR?=
 =?utf-8?B?YWxDbzFVU09DZWEvaStqbzNCK0lNcEpycDNoVTBJTXJxenNHOHk3NktBRTVw?=
 =?utf-8?B?WmFmQWZZL3J4emlYQUp3RzMxYytnTExRMnhndWppWlJjK0Y0Ulc3MW5Tanpy?=
 =?utf-8?B?YjQ2VXBwUmt6VmJwZHh2SGluMWZUVGdkVDlHSlVyVU0zeVFRaGxxclJLaWRw?=
 =?utf-8?B?empkU0tGNXAzakR4Z1ZKL0xjT0pxYzRDSDc1K1RGdytSRERzTTNKVnhUNHV6?=
 =?utf-8?B?Ri92SWsyNkdLTEM3Q1YvSUh0aGdVSWFIYkR5cmIvZzVnUlBaNWViNVdseXdu?=
 =?utf-8?B?U0ZmQUY3TnNJRTIvVG1ISjZucUpuU0tUb0Y1SjNyRTVJVWtHMWo1cFBTdlox?=
 =?utf-8?B?RXlMbzNEUWxwdlVWejNVQWJKZE1SeG5MUXlkMXRtSThheVdsWGVJUkZiaUd4?=
 =?utf-8?B?RURVa3FEeW1xa0pmejVpUGxnS2Mwak0vTlZsWFFScllEVDFmbHRDbUxHM0NP?=
 =?utf-8?Q?8SLzHnW8rdq0fzh7bp7e9c9ba?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aTAJubv6I6WSeYSOsg8dN/NpCAPDXbsjNS1FCS2/jkIPpZcpIeITbKvcUqdgNFRw0aISD7aIuS1BXdKwX/VPC1BbkPb5qF/z8mXh1F+bIUQVZpVwSi8S1rUL/ac0NHNJAYH9K0z+NX1Mnu4ubyNSfWMO5QHud3IZ1//JbNtWtnafMp2l3/Q8puDuKNxdGCtJ8HPSGvqq0m/WWNBDpfhAkOOlyYa8IO9eMMqkaBLIxe1J6VOp2cqwvCdWaRMIdSveBf+wLgM91hPGg1XTieXwR9xXOkzVSiD8ypSWTPKjx4PedkeWHn7xNiYRNIZdgrfR4bkS8AjaBHaGTJ2ruepHn2PsJYY3NBwC8CjMU0AZ8Z+aDKzczANDweGiP0EJ+0kNKQFehpKG3KSz+HbyQT9TB3/7srR0m8kmFTrIi9dS/+ywLep953Gof5gs7R8JkLk8NQJwobddwN4RKx79PDcSCdjbIbviXpRIWcEtA1Wg6BJeVaiPpWnXWlGhXEZ6Gcn6ORgn5UB1uX1d/CJQoHY/QBiLJDDTsmPr8BB4D1LMxERnTb4yPIh9nWuS8wHZ9BnWpP023YG/GCnTfGLpBc335qBQ1NsVMQ61dhdOaonFE28=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0891cb2d-f566-4d96-7d1d-08dc2191cfb0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 12:48:52.0519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoR/xsLtEs5ihy2E8SO+OcHX3b1mI53fTKBHkeqZ89YaMQ+026SIy2f4ZCKrx1yK7WMsVwaJP08tczBOcV42QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300093
X-Proofpoint-ORIG-GUID: EAH7oSHgdNRAvQTyQrrH4lApZ5CZxGp9
X-Proofpoint-GUID: EAH7oSHgdNRAvQTyQrrH4lApZ5CZxGp9

On 28/01/2024 16:58, Christoph Hellwig wrote:
> Pass a queue_limits to blk_alloc_queue and apply it if non-NULL.  This
> will allow allocating queues with valid queue limits instead of setting
> the values one at a time later.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Damien Le Moal<dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke<hare@suse.de>

FWIW,

Reviewed-by: John Garry <john.g.garry@oracle.com>
