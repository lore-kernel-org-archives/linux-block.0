Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1A7F7EE
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030773; cv=fail; b=A2uVriT88hpOOIpLydOw7LjpZ6KCea0vOkdJfj+TCIfCCKQBwCEMGV6hOVP7RH1bQiWzP/FrhjFuF8Btzo9QE3aYhEaTfz+6tf8r+fC8edhuSvI7XMrdFhQi/iPS+jEm0u/HJQqdxKpgkUxjgIzXpIPHka1qGasKm4KNOcElRww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030773; c=relaxed/simple;
	bh=5hhXLgpUp5l2RKAabwyoSjxK+yQW6DOPhRCFh/FRfvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AkpiAkzdv+wCuy6NP9G+3WGd/85mZ/qcipn3oCpVP8nOk+EWPodulvTTw/Tdm6HV1X6MJCzcKpgm8GePfDRyKxD2IH81L5wVx/roMQuNuOXbPh3qFIB+MK8bw2odKMr75/ldaXoHDW6YwbygNDe2VcfNXF02BuY4AkH/N6J8CKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B+BgYItP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sQW+4As8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B+BgYItP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sQW+4As8"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGRU7b011681;
	Tue, 23 Jan 2024 17:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=XrbBJznGfAF3cJYvuBYMmxtEWuYoPhY74jmxu6lWZZc=;
 b=B+BgYItPlgc41wnmL5Xf+hAsANByBCllIDbu0PY4AuFTK5WI6lvVSeBW/H9FRViIKvzz
 duv4si/iS9KeDzAKXjyG5pXKqSS6FYZfW7NkLJQMihca4C8ppYdYoKXMu3aDgV51xZo1
 ht4M41Z6H/xPoJbBZ3IykiVOfRwGP86sTwe2d4kkiUI/PD2wRRR/DBIbZRcviQuRnA/T
 aCeMA3m06eUoffL6RfVkrf8KM/WyUhR7ZADUC0KeCqLmO2As7As/G3ypBpeER0U62nZ5
 UW1ZOF/Xn1WT4TUHrcy8he0ypTlLJY/pwGwN7fi+pBhuZYVclUZhlOQIyNrkydcf8eHs 7A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cupxhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 17:25:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGNb9t040714;
	Tue, 23 Jan 2024 17:25:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs315myqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 17:25:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b11jY+TpELQqyvEVlc8MTBQAFceQQJIrZLD7slPRyyCZceyuM7mqn9Qv7PDZhMYWLvwP6HJbJlZMXRZhf1fwt1nEdqNo1E+ZPWGxD4NQVU/ls71AhFA7tdhPLuIeul2p14T8KgsPnVAGf9EnpzJ/CdzT1jagNNGoEWYN7jM05zISPbmEb90smw82smcyh6RtZI1QLWq/Syjf3zivPTNT5ClwEuwcLm/89LQNA5kyWe5UoWZxezyXtfoXtcnEl3548qQlFbLzwA8stbCjBL9uFisafBvsqYL0UOv1MsG2ot+bZams+5WI/AuV6pRspvMoDwX+e/58iFJkJGfo6VRIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrbBJznGfAF3cJYvuBYMmxtEWuYoPhY74jmxu6lWZZc=;
 b=XYDG05OmuViOHkQCzLOyd7uU00JUVjv6rxwOEDmVJWYHpdu0TFaXZUv9zm2L/aqNbf4XLYM8bLnS5VQGYtyynRMIsBEQMPHuRoMeIkyeuylRDnu658TwgCn0Py4j+i94689nznGiCfJzwCXiO4jk+5XFy8epU9S8k8qbLaWnq5po2MPBu+GsWrd5IIazCYMHoy5SYUZdV9lgWqH8Ma2H9fIcXrVSuxEX00MUjfpJab94bn4vziOIVz2LkBBy0D95VDBWwHOzrBRIgFXymsmJqoH2INeVRJgJFgZzFuqEx0jX1p7EH0Y4XNryjpItvy4wxwFU39kaNcKIZTi1LlZuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrbBJznGfAF3cJYvuBYMmxtEWuYoPhY74jmxu6lWZZc=;
 b=sQW+4As8JPIDAwHo5a+LYjKV5dHI57OaAeQD7vvXUUGkUrYoBgJ1Vwhhd3TzCuCXidqeJ0ZB23str7OH6itmwrN3FIyK8MR1zaRCqv081k5u8qlhx7bIA/CbI/vp5svSRPeC9GqkcV02DKxstE6quLmTUgXV058U8nTpN+6WphE=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH7PR10MB7105.namprd10.prod.outlook.com (2603:10b6:510:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 17:25:53 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 17:25:53 +0000
Message-ID: <7d7d7855-8a37-4de1-a32b-2edf0b53a05c@oracle.com>
Date: Tue, 23 Jan 2024 09:25:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        linux-block@vger.kernel.org
References: <20240116232728.3392996-1-alan.adamson@oracle.com>
 <20240118072419.GA21315@lst.de>
 <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>
 <20240123090506.GA31535@lst.de>
From: alan.adamson@oracle.com
In-Reply-To: <20240123090506.GA31535@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH7PR10MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf7bece-9b39-41c3-3117-08dc1c3859c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iOldVYc17qIALy/Na51jBEvjyjGLO/jJ4+44nb8xKgyA5nLQ7IaHhTVdizkCzNtA4EhGmuV4QWGHodLbQungqzWn2AAZaF+NkxoYKD0MX0REi5KnPK3ADyjqhhHc6ChbbT7j+cfILdJNqbm/7j4VAlEOvicpYa2NzB1F8URpOEvKo9J0FVH9hgeh+YI52UKN2xdrv7mVCXF0dncplZ5Dwa2ZMX/BzUopnB6+9JLpKbl4M4R1A5qUsAU2eJaG37z0XpkqAF6J2rYaEXL6AW+6mqw19NkOiTr6xGc7ti1LIkHA1QjkuY8MSAWPmXZ8qnt4pk6u1xccziDU0dj6RIj4MDHMKdb7wvqZ9oiz3AIqCzCy/ZQMVfg0XWUKJj2RiPeqGh2VsAsg6S9wNN/0sKqwyyKnOyov4ulo0EMr3mAGn04q48RDYMsUc7+gHzSbIz0J19xNjvz+/pJHiZUTRF55sORHaakKd4ZxkMXQX8zVfDAcJnl8623yEsZp4P5eic/ypn8ro1zQCsr6ke2/lRh86BFECcopaOs8LYsXIDD8m7PLNEgaA+jCvu014+Fhpa3QE22zuZ2p3NoWyRmLaThM+PhnNfPRIAt1OxwSGVozBEpteZN15PwhzZZ8huo7prZo
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(9686003)(6512007)(66476007)(66556008)(31686004)(66946007)(2616005)(6916009)(316002)(5660300002)(53546011)(478600001)(26005)(6506007)(6486002)(83380400001)(36756003)(2906002)(4744005)(41300700001)(31696002)(38100700002)(86362001)(8936002)(8676002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cUNnOWdzeG9HNktTZHhtWDRQVXRYWFQ3NXU3OGZsRURuYjhJV3p2UjUxQUdm?=
 =?utf-8?B?WGdiWkpvVmhodW9YTmlzQ2VSdUdxeCs0RzJ3QnhnTFIxWGRrRExITzhRNExp?=
 =?utf-8?B?ZVdELy9IdWNXL1JJUUQvK1V3Z3hOZXNucVQ0a09wL0JqNzdwQVlQbWVHZW9I?=
 =?utf-8?B?KytXQnl0eEExOVlKV1dEMnZWTzRoRWwya2Q4QUI2c3JGeW9OeE10aVhNYWx5?=
 =?utf-8?B?K2VnQVJwSjFpdm5iNmhvdkN4WjBNcmNUWUc5em95NURRNkQ1Y0x5Y2ZzVEFx?=
 =?utf-8?B?QkxsRWIrY2dkY1BnUEZwU04zQjdIM2s1RHk1SXYzekpJdmpnVzRIRVVYaFpU?=
 =?utf-8?B?YWxaNzhUdUpzQVBNTHVYTFBsQXZ2VzlEQm5LVkhMQ0NMak91NU9sMDVRT1ZR?=
 =?utf-8?B?V2d1ZmZmMGpyQ1hLMWF0dE5ZMjZUWmpOTldXWS9meFp4Rm1qVGZmWTNjT2Vl?=
 =?utf-8?B?ZHdrRm9BWS81dUNITExGdTZnOUpxTzAybGVRRnAwc0Q3SlB6WlVMV0Q1Sm81?=
 =?utf-8?B?NEhtWTkvQ1VqZ2RuQmFKYzVocFptVW8xaGI1bitwK0tVWmhTSXUwdEgwWGo0?=
 =?utf-8?B?SURkRGNHYmF1VllDSnZGcTR0QTBKMlJzUEdvZDk2RkNpUllyZTlocm1YMkFi?=
 =?utf-8?B?R0xNM1JEY1FBZGxlL1FmT3ErL1dXZEpDYnFlVEIyb291Y2hMVnZZMDgzUVFm?=
 =?utf-8?B?Q3hXSXFsM21OcGZXMFp4RjVHUnp0dU1INmFHcEhaU1hXTmtxa0JiYm4xQ2I0?=
 =?utf-8?B?NFJ6Q2RsT0s1YUpWUGg2d1pqamFJaDlPOU1hZmVTcGxYL2srZW95WkZUcXVw?=
 =?utf-8?B?Tms0OWNWaVQ2UmRjN0xRS1pqdTBuNHpEY2d6Zk9yT0ZpMzBtZW9LMllabnQ3?=
 =?utf-8?B?eDB0ZUNSY3pJSTUxMzhncytwRUhpL1lJUnlKM3hSLzdwTis0ei9lV0lqOFJq?=
 =?utf-8?B?WXlMdUk1YWk4NUt3a3VhcTdrOHdHaUtEblh5MTRHL0krZFNkNitHQS9RM3BU?=
 =?utf-8?B?TzNBQk1hUDRyeE5jL0lLSjBNa1dDcEUyV2RKellGZFZtNWVEdFA4WXJUWjdE?=
 =?utf-8?B?aHdmOXI2aU1rQVlrZXZoalVXMXJCSC9WMlllY3ZUdXdhQ3FMTEUvbUpBYVVC?=
 =?utf-8?B?cHV2cDBYc1NyQXQyWHhXc1h2YjZMbnpXQ05hbnFpWW9yNDFyOUtTMWFOekVo?=
 =?utf-8?B?NDc2ajRDZlZmUVM3RHl0MmR4dlo3TkU0MGw0VklrMUUrK2hadFhIeXlVc2tR?=
 =?utf-8?B?TEUwVmRjZGdQeUtKVG1FVkh2amFzeFVMN2VIKzV6bWZYK1JoTWNVK25vcVhn?=
 =?utf-8?B?S24yUE5mOTE4bFo1Q2dMb2ZCczA2cU9JenlKTERnRGJrTFhhYi9Mdjc5Vndo?=
 =?utf-8?B?cllCcERXUHh4SXRLc0JySktiQk40dFNGQWdXbXpHNG5qaUFPN2ZiU0h3Q0I1?=
 =?utf-8?B?SUZTWEh0QkZWM2dTaEZscFNZaWdvbHRBK2ExN2x3YlM5ZnJJQlZiemY4Vmdw?=
 =?utf-8?B?V0ZEQTRZOUhLQ2tpRGJ1UlAzS1RUWlFYajFtTm8xU1lKNUNjdUtuOWdtdkpm?=
 =?utf-8?B?bGN0OGlTbVFqQ1BZdTZhWHU4Z0lXakp2STRjWnkvMGphdzJLMklqQXpvVFNJ?=
 =?utf-8?B?aVppK3JNM0VmTDFoUkxtcTlJWENya0U1UkNtNzNoSDhXeTUzc1Qzd2NLalp3?=
 =?utf-8?B?RnNnNThRODFjN3FpWGtBUThTTFMvRWlFUEs3REJqQWJESGFOWXF0TGhSZ1pJ?=
 =?utf-8?B?RGVWc3dDbVhyQ1hEdk5PcjdITHY1MXkxMjNYbzYxZy8vdVZTb3NFQ0tXQ3Nx?=
 =?utf-8?B?ZGRNb2ZaaFpvaE4wRWs1UUN2RWlNTVFmY2c5aXcrY2FZemFYMlZoVGVxT1JJ?=
 =?utf-8?B?Ui9JckwyYm9lTFlBeTErSkZDc25LbDJJY3Byd3VjR2JwRkN0bGJaVDM5ajdl?=
 =?utf-8?B?RnovSWFobXNCMENWUDMxUmR1ODN0L2QwU1ZWYi9yMW53Nzd4ZUNVa1gxcDVv?=
 =?utf-8?B?N3BYc3REcmk0SmtlS0tyM1BDb0V3ZlJReGtwdkl5QTVoamgwN244WStqdlBV?=
 =?utf-8?B?eklXOWFxaGI4S0dXeW1FcWRDU1o0NDBKcmF4RHZlTjhLRCtra3Q4ekliQjRM?=
 =?utf-8?Q?uniQPB4hvahDFVkcX0I2K9Baz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZQwuAGfzVqIMTglFwrTwpshT85SXladoIANvXQF/ND6IbSOaljf292SdY2f6TN+/7PREV8zeQGPmDTft7XcgFidj2loSUnHD9k9Ccs1HABCU7nLhtWD/AQygnYtfAN9Fh9r1POwgdMUn3yXx1SnnLdPH9L3VGH9YU0FKk8nr5j/dq0oH74eGm2s5qndtWL1QYLQa+Zio5S7D+2lYXIopRwP3VW51X+B40/TQ1hBgaIC+NYY4kTUcDCWwMat5h+CDFLuZn3wRpwyl5+DvhrghFW4tn/qfuwiNY8akjgLAhTLjqcsvSl3cL0crkn05tvNOjMaswal7Vu99xKnvbzrJbxGNK8ZaQg0GkdTS5GtxvlkaVGG33LJp0WUslh5ehu9oc0NGFtK7pVhFSFkYK/RcEZ8wloyDHzRYcBSIR4sWYEwY30PTgyQf9oBLONIPyajBP4GyqpntdhCNzfd0wNuzRjbMaXgfBz0rksr4ChRF0S18larrCe9nlWRJfMFQETDwf5gZ6NnvP0uK4D05grJMgyn0Tj8F8/e2dWn6ZwIqfNVCWrzBj4JExMREULCrLpBJ4W3rwc+k0r7CDVUFrL8GXRqje0/vtfApzry4b29ZAJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf7bece-9b39-41c3-3117-08dc1c3859c6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 17:25:53.0704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXCd335GprxAJTMUeNeLc7PIqWmVlctMAFNZDhjjuwIn9JqEwogd6eD4NbC5uHRm31T866RI3+qSjqYwgBm7Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_10,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230128
X-Proofpoint-ORIG-GUID: 3mg-pD0WDMwIrD_HHGtWqvXDR1TDzWv2
X-Proofpoint-GUID: 3mg-pD0WDMwIrD_HHGtWqvXDR1TDzWv2


On 1/23/24 1:05 AM, Christoph Hellwig wrote:
> On Thu, Jan 18, 2024 at 09:02:43AM -0800, alan.adamson@oracle.com wrote:
>> On 1/17/24 11:24 PM, Christoph Hellwig wrote:
>>> On Tue, Jan 16, 2024 at 03:27:27PM -0800, Alan Adamson wrote:
>>>> It has been requested that the NVMe fault injector be able to inject faults when accessing
>>>> specific Logical Block Addresses (LBA).
>>> Curious, but who has requested this?  Because injecting errors really
>>> isn't the drivers job.
>>
>> It's an application (database) that is requesting it for their error
>> handling testing.
> Well, how about they then insert it into the real or virtual hardware.
> The Linux nvme driver isn't really an error injection framework.
>
Sorry if you receive multiple of these, I'm having email/sending issues.


I get it, but there is already an injection framework in place for nvme. 
Is there no plan to improve it?

Alan

