Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D625770
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597396; cv=fail; b=Lq3YQbgFgwwkNQ+PtgvIZ2qplHisdjclgYHGv4rvXbRzZkuEN4ofcxprx2TLgyRp3ZqXNJt6qNt1DQRhTCSk8VMrhpuLnff5GL/P+5kqY4E4qcPIJzYh7Iho06ZWLZFN27whYlXmE317tuYk5eU0QG4NfVCT1xDKCXtdlX4exkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597396; c=relaxed/simple;
	bh=ApeOLdOhVHLtTcLLIlaIwv8y/oviZjj6DBXHQQ1+lN0=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID; b=RyhCKscNRra1OR8krTAnrJ3GWllIx4fDDc9g0aW1qe3QDHcC7IfUJkHYv6lAhhPiTQEKfh+VrCi57t3hy4cpIakL8yZnkqU9vQUbujVD6uUuyQfuPro06AE7p18UYX+wZJpGB99heCZDrEvHp9YBxdp2bldbCvw8xHvXNj0iASc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D3V/4Hzz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fNFtqg/9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D3V/4Hzz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fNFtqg/9"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40IFT9bA011550;
	Thu, 18 Jan 2024 17:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QynFEicG6lLim8cCzFF4UYSHAn2NlL4tqxWrKuhMKoI=;
 b=D3V/4HzzNGrkvLmZrAjDB/pj1Ec+PJtbZjjHSzFH4N+qfX7U1lwblyJpHgGMGB0Pmi1Q
 AvkhR8l6AZOtaG3mYtLqLC2LYc/iW/1cs4aUHm94PTRFBqZlYgK1T7aJG2h/w4Z5Kga3
 NsEuiHoUcl2Auz+DrVXEoZvQX6iYxywZOoeJckAWNYafggaSafJq8M2181uTZYrZEv6m
 5rg0SYgiiAQ4hGqsy10soJR9U6C26Gi9lL61zpStkv1f2s0inbPvCVC7Jlr96oUzqfgs
 k6kGqHXux8lu28mTZUJ0HU7gB3geBbyTslLRZUPmuLrCosKXRC+yBI4/6qQFxsnDiyTH Tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vknu9u17p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 17:02:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40IG4WhS019949;
	Thu, 18 Jan 2024 17:02:48 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyd3ecv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 17:02:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hf4UtnTCZoNiS4KY9uJgTsAbzPjGu87tqCKUQYJv4UsYXCry5ixBOiRbuD3ABVISeUFaIlv+ba3UIuRw35/fxjK04R3569AKdqK65Hjq332ny7+OSJKcHcIkY8UlMlT2gjXppwo7P2Z2QX+nIU/98VFbeM1/462kA3ZNT/bIA259evzDVXE/Zkmanea7MPBnzn02eNIEX/IbKWkiienAoNv3DuF3BaP25TwTs76EwFcniMCfJV+BhuGSI/GJiiwQcUqrEKS/o4sJn7rynQiUwHD8j5/c0ARCUpqGOoqDRfJvGU4BuEIiAst5MhodIjaOjdevD20FaCUmkvRHnJs2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QynFEicG6lLim8cCzFF4UYSHAn2NlL4tqxWrKuhMKoI=;
 b=S9xrsgA05CeJNANJ9qJjWCQfOzi4LWYeAYjudogOJSsOk3pqbCPkqaLksC0TPLnBtDbd2GiYkj/WA2kpCUeWd9/2aZou+qYmxUl2vN6CAQ8fqrmY+bU8Y8p1fR1+bexqrobrNl1x3llzZtqeMfkus3th7fN2YbXA0tkUvEhqY3MHFRgpBbkl4PvkSc4u3ksABdHywjSb/gWRUPkgTU7KbGZ51A0twD9lNHxiacHMWN33J+5onbYd8k5Ekra1TRrwzgSdOY1UTX1y83Ed7b4ZF8SzuZghDlV1YBQhSHdhPN3N7UrofaO3SldSZB1bWwqRnJjhaaJGgQM4EXidepkudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QynFEicG6lLim8cCzFF4UYSHAn2NlL4tqxWrKuhMKoI=;
 b=fNFtqg/9HtfMq7iW0nMzegE9XS5OvzNKJ3VdepO+J/Z5tBJMf7VwaQtrtCsLVYWk0drOdrfuQiNBEF+E3qPNKiBDYbbWKkDbAKP8FyexMzaN3oZg10XBrzQR0sRjWGTQYJsJawGlhQ4654KDZ9uUBYBxrEHmOYDyZNkHdGxoUgA=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH7PR10MB6310.namprd10.prod.outlook.com (2603:10b6:510:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 17:02:46 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe%7]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 17:02:46 +0000
Message-ID: <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>
Date: Thu, 18 Jan 2024 09:02:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        linux-block@vger.kernel.org
References: <20240116232728.3392996-1-alan.adamson@oracle.com>
 <20240118072419.GA21315@lst.de>
From: alan.adamson@oracle.com
In-Reply-To: <20240118072419.GA21315@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0086.namprd07.prod.outlook.com
 (2603:10b6:510:f::31) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH7PR10MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7fb1c7-a63a-4024-74fd-08dc18474aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sicOAAt8runY4zAL6MpWGybHeRsFlljTGDkIj+Vopojtfivn8bOyRv+TXTT+rsy0XI2S4akyOgIkOoqKYe9z8h453KQnZ7jYAd1UcWGFcUOjHzTVVzbUcI6bDoP8tUsjRCMq28V6rkZ3G12mJOoZ9ZoDFQvdg/xbQEqaiP8ojDlVArc+BhFZUgWy7UOf9EbBAmPHEwAucNFfFxbC+G/YEpHQpf4BO95x8aRZw7TdKCSpoX5itTmaV53Vrf7dFHUz3KxyS1rQCI2xnTTxCC/KN8KF9L+MWcFxtYgrGEGppPP+2XBCU188fK2GFJGBCKS8u9GTu8bqNdKA/+Hlndl4rrvnJ8ehbSgejwV533rriigzVPmf8F0BzYnrFD7O2huvJgwK+Hc2ucryFsfE7u9s6l1qrt3IvSfA+JaYBjTtJ56JaWaGufmjuwTmnzRs6COjTpocCWmer1NagBUitboOLzXfnFoqafhcuPD16ztFfu6dCTAslErTgV9d/MO73r2T6vtJ14Bq7FIIR2h/PtQZ8opU+dfw3tzJpCDv5CzCgYIYftrH4tSxk9quN7FCjGhComXyJXQbJafGKUefV7Jm7TKyVMaqCic4Yf/sufL5pAGTM2JwlHGjkzk57gsOOR0K
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(2906002)(38100700002)(4326008)(26005)(2616005)(6512007)(9686003)(53546011)(31696002)(86362001)(31686004)(4744005)(36756003)(41300700001)(66476007)(66556008)(66946007)(6916009)(316002)(8936002)(8676002)(6506007)(6486002)(6666004)(478600001)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YmtsbDZmc0szUUdzLytCeG5GUzBybDZlT2hWMWpiMHFnYzNLeVM1anNaVW9C?=
 =?utf-8?B?SXRaT2V1VzVXSWNMUUdyWkZHRTZob1Z0RlFTd2M5YlNtVkplM0RKTU5jeDEy?=
 =?utf-8?B?bW5iS2J4ajEwNERHaU5KVFNWK2Fsb2ZOYUltelJpUnZNQnYyZFhKMFFkemVx?=
 =?utf-8?B?aDdOQVJHSUJUNi8yZjd6VEJaSzJUUXVkL0FLbFRQS1dITUxyQkJ6T3V4UTFD?=
 =?utf-8?B?V3FNOFFIckFPblJvbk9KdG1nUll0T0g2UFZYWldUQVB4NGJoV2lTSlNmNFdr?=
 =?utf-8?B?ZEZpTVVwMm52Z09ndHY3b3QxcjdhaHNXS0M4WUx2TDNlMlBuelJtaW44eFkw?=
 =?utf-8?B?NkNJU2RUeUpCMFpLYjZBTFdJblJlWEhJNFp1UUtuN2RBRUxjbjNnSEw1TmNS?=
 =?utf-8?B?b05KdFBNUmwyclhRSG5UUG5XVm1XZE44YktNVyt3L2pOUFMyZENTY21yNER0?=
 =?utf-8?B?MUhicjJPS3pZUDNuaDlLQW9rL1R3WG01c241YVc5eWJ3R3AxNlZQSDhuazRx?=
 =?utf-8?B?eit1QkNHZlB0eVBvMktBUy9RVzNzVkNLNHNkQVJleGNXaUFUaGVIWGtlM2to?=
 =?utf-8?B?eFZ2cU1TRFhyaDhwZXJldTN3YitCWXY5ekdoZmovNks4eGJPWlBFV1JpTXRZ?=
 =?utf-8?B?M3NuNWtEaFYrZ1hBZmh1RkxsdXM0OEJab2RwWVY3ai9zTmpwOCtpdHZCeitX?=
 =?utf-8?B?QnUxdEpKWGRQanRwMG50blRaTzg5UzF0Z21BRDhGRFlzUyt4Z01NZlZkZWhO?=
 =?utf-8?B?MzQzTUQzM1NGL1VLbUxaME1uaFBxZU52K1lJZUd0ZnBIQnRJSFZYRlUwdEFC?=
 =?utf-8?B?cGhOaWZUSmp6ZnBxQmE2Y2s4bFhpN0tDc3l1Q1RBTUQvRCs3ODBQZWs5cFlJ?=
 =?utf-8?B?bXlxbThnSXVqOWRUNGpmdVJSVzhBejVrNnRnSUZ5Q3oyOEQ0NlhZYytoK09Z?=
 =?utf-8?B?Rll2dzJNdWlZakkyMDY2c1FhN1NoaUs3MWl3WTE4Wkk1ZzZoeGJxeW5mYmFx?=
 =?utf-8?B?ZWpnZHhVd1pkUm1FYTQ4bEh6VlNSNGhUeEtPTkZYRXFicXF6c0V2NWdtcTBP?=
 =?utf-8?B?QjFCUVpONmRDRDEySDJVaWZ3Tjh2VklmUzFseVB6ckJWbnprYnhERE53UEpU?=
 =?utf-8?B?RjVxVTZIdnJ4RG11YVFJYUY3emtlcDNOVnh0eVJjV2d1K3lJWUxmOXVVbytW?=
 =?utf-8?B?aXlPSENHRXI5YVlXeStUUEtCM3ZqZzRjVVVTbDZZaTdjTDQzeHo1SzhoZXNp?=
 =?utf-8?B?WjJyaDlYYXNoRUlwL3RKNzE4Z0pLWVl4blUyQmhNWlB6U2t5MlIxRGpxYVVN?=
 =?utf-8?B?dWc0bEp3VTdrV2NJclV3WnV6UEtqNDFFbGZqSU1XSjNXOUVDNDBudE1XV25B?=
 =?utf-8?B?aFNsb0JvVmxyazZ3NldkdG1WeFpEVTJxc09Icys1enZJbk9BMlo1OThTZU40?=
 =?utf-8?B?cUdGRmtuekF5M2hqek5OY1ZNMjZxYWJDQmVKa1E1T0t2bldQU1R4TXVFWm9M?=
 =?utf-8?B?My9mWGRCK3N6bk9wV0pFYnFLUUVvUUk2ckVhRE1CWllyMUx1VFMvc3NwTXhF?=
 =?utf-8?B?b1FBYlQwSDlNeCtuRFBJMDkwUUlRVWZucmdSK0JjTVZnMXRwVnpVWktnVDRj?=
 =?utf-8?B?cExVWWgzQ2lFVEdpNkQrSk1mSEV4NVg1bW1iUTVtOHFScnNhSnJOK3VTOTg1?=
 =?utf-8?B?bFBsNTdLUWNrT2tvM01tKzVNNndaNDdKV0hhRVFmN05SUmxYSUNWSkFod2t6?=
 =?utf-8?B?YUVmZlA4SEhJY0x1Y28wcm5kV0tmNEp0MitUK1JQQm16T0pXWk1QbjlpQlZw?=
 =?utf-8?B?Y2RONmNmcFQzTUtNR2lrTjVPOGg1RjBLZXZlSkF1czdidFYzdXFFazF0R1JU?=
 =?utf-8?B?N2pQYmtmOUh1ODlVd3ZXOWZKRGw0UXB3a2pMYTdSbGZ2ZTh5cDR6VElIWEtC?=
 =?utf-8?B?ZHNaS0RvS3o0Y1ltWmZrK0YvOWJGWDgybklaU2FuTDJKQzJhVEg3NU91dlg2?=
 =?utf-8?B?RDMybEJMM3YxYjE5elBRY0VuWVV0MGZRUnZtMG0vcmZWeGd2V01EcVFtNFAr?=
 =?utf-8?B?YmZaM3FxblIyMUlnV1JRYlVBWE1kN2svZDZGYWRpSGtrL0lndWJ0MGlMRGc0?=
 =?utf-8?B?ZG5UTmxpZTdsVTk2ZjhWSGgvQnVDU3cxNzlKaGwyaEo1dUlCam4vVXJOcWtL?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3FPIUnSN39qlVadsJTDFZj43iXkfF6uROwUtXgq24orMy1D8IkzAbQEtUINe2ljZzbMjwyp61esF91kQqRfi+YWBkRf+g36dNzQZ+hx52/X2ks/0B7OuHj0bz8VFwgyHH8QjgginzazMRpHgsu5itcGCNxMWtLLVIk6nOk7SibHzF+/qIaL6uXqGUAy4DZ3n2WXBQv4+l7ZheFIO+edOZ/IXj1/EH0wO5CVtKVD7QbM9jt+Q/lKYprzV+IA7aawR1Tz+U5idB+q4htwEPi8PoIzpL4cydwwC5RqlugaQ1skZkyYU9PPi61Af808SY4fnF/bAlgrlFIJLqFOD5rwJgEif2LwSyjBaDRKKM5+qTgy0LPiDdwfqd7kagbr6oUzORS8xsNcG1XxEK8dIeuYNuf05/IySWIFt0AMVCfW7SnJ0/nFhGVk1ygKhXHdeDH/L+FKpOc2OVjNeRo6puf63H4qED/yvSRRekJ2LAKO29e7WHUq6uTRF79NYzyg1gzC8IbXTvwWXqJ3Wv1c5A1GXeVl7ANgOt2g7JBIZm7fvvrIvD6RYIkXi9gKCRlJ1derrlSriZAbxag5EBGGO55bmkdQap+CMOMqhzrAiZdktn24=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7fb1c7-a63a-4024-74fd-08dc18474aee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 17:02:46.0483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHQJ25TexTvjshPZXbC6qF3so/6ehFd88YzyiAw+DV2Xe+ruG74LTwNEl254BZH+Mdom8O7FEV1/oJGLtrAQrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401180124
X-Proofpoint-ORIG-GUID: K4zL4o0zygUKmUYqMnMaCj21hXPBXK53
X-Proofpoint-GUID: K4zL4o0zygUKmUYqMnMaCj21hXPBXK53


On 1/17/24 11:24 PM, Christoph Hellwig wrote:
> On Tue, Jan 16, 2024 at 03:27:27PM -0800, Alan Adamson wrote:
>> It has been requested that the NVMe fault injector be able to inject faults when accessing
>> specific Logical Block Addresses (LBA).
> Curious, but who has requested this?  Because injecting errors really
> isn't the drivers job.


It's an application (database) that is requesting it for their error 
handling testing.

Alan

