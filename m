Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABC5E74901
	for <linux-block@archiver.kernel.org>; Mon,  2 Oct 2023 18:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbjJBSGK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Oct 2023 14:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjJBSGJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2023 14:06:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E3CB7
        for <linux-block@vger.kernel.org>; Mon,  2 Oct 2023 11:06:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392GE0uI010294;
        Mon, 2 Oct 2023 18:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=O7zJogZSEZ6HyUZ1CKtrCoxMpeSQr/FQBBGFQ875xJ8=;
 b=g2DdmAuA3sMrPdwb4iSGnIgijctODBSiKwLZ7n/SZmN/kayQ0TMwkBrsQDzkL2EkHATe
 PR+y7HwVdCt2qSj+qVJG1ATKZJJyGrXPUIfsA3/09A2HpkaHG0XbOM+boZsQCp1KbJZK
 69wKfbCTQRBZ7+RnfrG1I7yVV1TSmXT7/bwBPd4uqPaew/BqSJas7yxATWZKrfjqJGhH
 M1slEdeQS0jSncHIEFTy3y/aUK5Ox3DTfN9P0sOaetgZu/tc4cvD4dgjyoVUVnvurFhZ
 uEnp9W9ym8mXxmf+nXEAZ0gsukZlXBsCoWvbw7tsRz8M6e8SfwoauvN2/Bx0oUz8Aoou fg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9ub2h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 18:06:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 392GdHoM033653;
        Mon, 2 Oct 2023 18:06:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45441e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 18:06:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu2FOJnzFsh8TPA5fqUn9rUXgauwztpXOB32lbucJbSr5blgyl+GUHhybPX2inKnHIbynqebyXHtfAFRsm8myQZ+dJBNzDDdKeGVFEs2q1RVdFiB+Sm3ogBIYcocuDq/k2CJSxDWDEFwqAG839G13TilvBJNZlBtn+kxd8ZZgNxD2Nx0O8Kb925jk2ES9xT0gan07EuSJpr2PANU8dtG8v3GRogtIzuRuBhFUkosN94CqHZfv6urFXiUDZTsk+5lIC4hrEWA7cbxmh4Z4mOGGSBEXTIwSFbIx0khyhCkAib3rHMXq4sc8lNmfS4IZllSQULXkDzSF91fw6uJ4Fabag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7zJogZSEZ6HyUZ1CKtrCoxMpeSQr/FQBBGFQ875xJ8=;
 b=l4+rlCgFXFHJlFIm9RTj6VfKXhPS0JKPcp340UZ3B87+qm9YKWvwtZhuSgI++ouIchx4jreXNA5zDoTbBgU9QRIgfz4jRTL3QXvnldquXeJypukaKH5gey0zwAGQFY8SvTdLHNV0+OfuMivRrB3rF6ofA2zZw5qL+TZ6b+51VhguXijYimGHvvLy06lxZ3v9MudBVigiyat6QrngS1981Rt8AMU762hCq/NiGulXogRiqW82KOgw3atPyTWh3JUSIeBfjH1GYF4ehoDzg3fSGJRz40kEElOpbx+00APpEkykZ2KCuWa/0SDlLSuxcG+4Hm99nGGEsY6W/PWbJU3MRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7zJogZSEZ6HyUZ1CKtrCoxMpeSQr/FQBBGFQ875xJ8=;
 b=ECzEsx4vHXczUl9HpmQzwHzNCgodQWJRYbUTBRgxV/AU/mml6iYdjkzcmGMscnYMfGv6sElbF4/VNTfsjI/XqcrZM572TwRAGPyLuYpN/B2NQ2UqlBmvvFwknt3QC0Q2qXOs/WwA4X0zHQRY+C2wfE1NTLfJPPrFon+++tU4VnA=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34; Mon, 2 Oct
 2023 18:05:58 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%7]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 18:05:58 +0000
Message-ID: <b899074b-dc76-44cf-a613-ec6c62523264@oracle.com>
Date:   Mon, 2 Oct 2023 13:05:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ublk: Limit dev_id/ub_number values
To:     Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
References: <20231001185448.48893-1-michael.christie@oracle.com>
 <20231001185448.48893-2-michael.christie@oracle.com>
 <3fc0be94-8fdb-43c9-81f2-0ca053f6212c@suse.de>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <3fc0be94-8fdb-43c9-81f2-0ca053f6212c@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS0PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:8:191::14) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|IA1PR10MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 665904cf-4a3f-495c-83b0-08dbc3723ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWZixqyGiaq+rc+evvVDRmbEdJm9rHfBM9eN/I54Wd+gdJVw/hjmh021jIWsJfSJsYZ3gra18SBgNEHh6k0xD6xJxRkokVyg0I1GLj8ajwRU8IGPn/pgbplibUuzv81dIJODNyJqb7Q4TpSux1g/BCMZLnRwPCVzpFgfTPVRX2LsHkiYf2awthzOpkRFUmx5uPYLpHnZ2I5+qGTs7yZb+x1WI5J0vY6x1IGmr3XXbRkxdGwB/rRpM/fPnU20ZhamapJCyiSxAR79Ok92UtWG+wlzV1AX9FXX5XVbHc8AusBf19hgeRlKncKRDKZhVIohLIAJJIqI8a+z/ckuh83/ze1utCgJNRrrPdmNK4LulXcjwlbIkUJ1Vm4gwzPhzevwbtVXzYTFg0qP8JnQFdEOIL/aXZoobTJ5ny1LI5i+oPZ/HGahpoKFQoYic9B7kjwB7jTm20N901rF4CC1Kw10EFhymmpaA0h7zNH5Sdtrnx0ZZheelKvvDemV3gXca0fYdmw1dob6epe1ul/Xa8wI4tWlbmh8kUNOu8U86AqrhkcBBpCr5wpz8OwOEQtum6ytuJCTNlF3/wKOYHBM9cBqNhy13Wxe/H7UAIOJFPd2xPknWMrv93Aadvx18NOIfXtGodfG6p32rZrlgXwglVNQWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(38100700002)(31686004)(53546011)(478600001)(6486002)(6506007)(83380400001)(86362001)(31696002)(2616005)(36756003)(41300700001)(5660300002)(6512007)(26005)(66946007)(8676002)(8936002)(66556008)(316002)(66476007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0Q3eCtlYllsZVZSKy9jQm4zTnFqcDFsVG5RTDJOTWNuQ1BtczdhZFh2WjVQ?=
 =?utf-8?B?ZmRvZkdkR3JoTjRwOE5YT3VmaFQ1d2FOdTFCUGl6S2VZWFFwbENZUEdlMjdC?=
 =?utf-8?B?UXpqd05NRm40QWc5MUwrcE5KWkJubmhLWjBZOUtZbjJnZ0R5L3gxL0pmN2Fn?=
 =?utf-8?B?SFBaVTlySFIxY1ZWZWdYWThMSmh5Mlo5ZHp3d1RZWnZCVy9zellsd014SXh5?=
 =?utf-8?B?UUZSY1FqNDcvbnJob1l5Sm5CZ2NweUFMbnlIWTBYS1BHZC90bUgyUE40SFUv?=
 =?utf-8?B?T3U1dTV4WlZtZDFPQ29UUVVUTjlXTWpyZk4xRkdFWitJSVpHclk3L011ZEZU?=
 =?utf-8?B?UGJPTGhhRVlETjlCL1hXdjZ0WWtNU1lIanVJUFdRN00zc1hMUi80WHZPNDBx?=
 =?utf-8?B?cVFhRDh4Zml1cXlyNHdZQVBlTGJLMmpIUjBtNzlwY3FCeWlsU1h3MnFTMUVM?=
 =?utf-8?B?WE5VbHhMZjZBNmh4L21TTVB0V0hBQ1o0Q2h1YWJxMVFLY09uVURiL3Vtd0Nr?=
 =?utf-8?B?VHo0WlM4RElSS0Z4RkhZcDlqczV4dUJEOG9tdzZoNUM3ekJhT3E2alZWTEQw?=
 =?utf-8?B?OWI5TWpDeEswSktrRWowelJxbTRlME1zNW1YQ3VvYktMVXdyMTBqMEJyOUtF?=
 =?utf-8?B?aGpub2toSFVCd0J1Q2hjTDFrcW4yc1Z4dFc1cnRCTXZPMFRNeGNBZ1owZkI4?=
 =?utf-8?B?NW5wTGZUUlR5QkJPRkJlMkx3WFcyWWlGN0Y0T25wNmRoTlB4a3NnUXRPdGwr?=
 =?utf-8?B?aVMzSzU4UnlHdEVMbkk3emdmTUtyMmhXQnZyMDQrNHVGYml4ODFWcllTNWlF?=
 =?utf-8?B?a0pzaWZNSHlLdlFGUE1iTjIvMFd0dDFndzZDNGhtVDlTOFpDZGw3R1NKY2pH?=
 =?utf-8?B?MVlOMmZTSEpWS1VlNHN3TTRhSUpkWU1nTXk0OGMwQndyVDZpN0locElYWVYw?=
 =?utf-8?B?SkRGYzk4Z0VNQlpvaSsvWGo2b1FESllaU0tZazIvM05IbGl5ZGE2QXd5UnVt?=
 =?utf-8?B?VzdXUWlUc0NwSzRrclJPNWNzNXpHVHdVMkVJKzVCMHluMEdqUkVGa2tWdlB0?=
 =?utf-8?B?TFY1d05aVk8zeS9jbzVReXVBdk5SM1JXeGk1dDdZZ3MzWmQ5UjVpbnlMNlNw?=
 =?utf-8?B?VEpBdkt3QWY0bHZ0cEhqb3dwNSt0QTJFQVplOW5EVFlJbSt1RTdNZ2I1RVZr?=
 =?utf-8?B?dXE1am52K252Y3gyeXEzRm40aVRsY2x6REs5UGVrV1ZkQlk0OU1oQUFjWCt3?=
 =?utf-8?B?dzdRRFE3R25HVURBUCtHbDZJS0hBK1lFdjdqQjhSZFhYQW9lbXhRRW9LcVRx?=
 =?utf-8?B?YXluSnhhalFaME1jTXU4UkFibDR5UGZld1RBRk1paHFVRkMyOG9IMDZJQVI1?=
 =?utf-8?B?WEhMR0RZY3NqZXBmRU1nSXd5dTdRVDVpL0hCd1ZYZWpsenE5cGxpOENSNk8x?=
 =?utf-8?B?YzdjSUNhdDJ0c3VESE13cSs3VGRXdXl5WHFxb1M1djgvRlFkNW9uU2VtOXNN?=
 =?utf-8?B?RWg2eHhMRzVyaExyQ0wxRGc5VjBKZUJkZTVoMUZwWjFkT1Z1ZjVDczVxaXp5?=
 =?utf-8?B?eitmMDltcDRwcUlIdVJpVEI3cW1mMjBDa2Foa1doNFVGdll1OVYvMmZyQzlN?=
 =?utf-8?B?TVdLaTFJR05Tb2xRUHFOSmY4TEFrbWFRYUN4YWVZenB6OVhCTjlOR01vOEpH?=
 =?utf-8?B?eUd2Sk9keUxsSW9WT2RvN25vWFlSeDJPeHlyMkhoVXpjMC9uMzRZdkdzZHBj?=
 =?utf-8?B?R2N6VUxRVUl4UU56eGZocWU0eWIycndqSWtxRE5XTTd1OFN6LzljblZ6RThq?=
 =?utf-8?B?bm1VcjYxdEpRN1BqL1JJUGFoeHoxOC9WbWgwcjNZa1NBNzB1RzNCTlhaR2li?=
 =?utf-8?B?Z1YzTkp2NXl6dHBkN0VrMk1PdWhsSmVSSy9wT3F6aThMTmFUUDJpZTJmcDhu?=
 =?utf-8?B?TWVJblhUcHhpVXZMS2pEdCtxTTFjWklUWVJkWnlnb3NWeHF2YVBEcHVnSllk?=
 =?utf-8?B?U0pTREhIQUZiZitGMTRmRnpTOUgwQzA0ck0wSFoxdlNXVzJMZHYyMk9BV2dh?=
 =?utf-8?B?MnNYQkpVL1doSVZTNlBSdmo5b2JDZ0o4b05jcmNIWStpZkhFemF3VHNuS2Vm?=
 =?utf-8?B?eGJOVW1icllsdm1PdDN0dHBHbkM2OUl5WjJkU0VxZUxmK0Y2S3NUSG9rWGpx?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 49Bps80FkHWWsOMi+GxW4dvvsChvz7+DyZjDQ9KjhNg23YMUMqUgypJzYzUjt9WhOIDyZughmXkthR8QpYyQ9ugcC+TVmxtrFSQobnh0I8GVD+4QDylXd8CT+Nmwnxa90Y4ZD4JWg3R4caNjqUixgHo8eQqG/xpTUshfhd8531UzwaXUWp6PY5oQQIJqEr3BX/TE6d9RdZ86nCz6yCakhPfgN7jdGOZdXrR1UpmzTIFHSSz6noUVqwogK3LNvCg/mdakYkkJDQVYXDhQZ2GJlQky6pTFi8AJLcEGc3+ftcPQ7G3/CH0GygfU6JNzLdbK4/dRVrj4UAOGKEZFa2buWOHgj2OEciQJPay1A9Bu2n3kNgDNb7SqJxSl4L07E1DkDKTlTpMYKJCxQ+vHH2lA84gXOB4hTqKw20Gf2c6/E5mGKNIMlt90dypw+YuMBLtfnMB2LgEqNdEDnibyyWtoHP6TVWNrHWjgj7u4D1Yxri2yfNX7lQzg5XKSuCUqwxKt28e9r1HQjqDnDuVR5ksxWWg4IaaUvdo63oMQgptWxbhhEfQeeYQPKsWEN+rzlZnXIi0injTojmzow6C+g7yZzg2pxRo61V6XggYC6VRuU0iqk7taTgkavsUlnrmuAz4m29IP12sk20RmP7yaLHqpuFHU5oa9mWFjcw/deBurRZz1HZ1GaPZoW5vyPURLoFU46JuqSIVAaBWnC8XR0Xmt9howCCvxLI80tnL2GEQYqDl2j6v4HpEfxlJPDP7jX1E2lFDdo3dV5msJ98tbDmvqcL404oBXvkk/KbD4S+GEGK6Doz8Jw7D2lXWh4gjFp9Mb3HrWTFatGmWXluJJtAB9Aw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665904cf-4a3f-495c-83b0-08dbc3723ab8
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:05:58.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7KaWhz8X4trlA8B0xIpijHNRGdSkyXsQS85GnPDjkynQ8BXp6cv19/MisFfDSYx1RgR4jnHj7AcoGPApMR/Q0kc30n+0zu+BJj/R+q18TQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020140
X-Proofpoint-ORIG-GUID: W9FHxcNoLnSkRgmBXhlCTyOzF_d8CmyA
X-Proofpoint-GUID: W9FHxcNoLnSkRgmBXhlCTyOzF_d8CmyA
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/2/23 1:08 AM, Hannes Reinecke wrote:
> On 10/1/23 20:54, Mike Christie wrote:
>> The dev_id/ub_number is used for the ublk dev's char device's minor
>> number so it has to fit into MINORMASK. This patch adds checks to prevent
>> userspace from passing a number that's too large and limits what can be
>> allocated by the ublk_index_idr for the case where userspace has the
>> kernel allocate the dev_id/ub_number.
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>> ---
>>   drivers/block/ublk_drv.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 630ddfe6657b..18e352f8cd6d 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -470,6 +470,7 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
>>    * It can be extended to one per-user limit in future or even controlled
>>    * by cgroup.
>>    */
>> +#define UBLK_MAX_UBLKS (UBLK_MINORS - 1)
>>   static unsigned int ublks_max = 64;
>>   static unsigned int ublks_added;    /* protected by ublk_ctl_mutex */
>>   @@ -2026,7 +2027,8 @@ static int ublk_alloc_dev_number(struct ublk_device *ub, int idx)
>>           if (err == -ENOSPC)
>>               err = -EEXIST;
>>       } else {
>> -        err = idr_alloc(&ublk_index_idr, ub, 0, 0, GFP_NOWAIT);
>> +        err = idr_alloc(&ublk_index_idr, ub, 0, UBLK_MAX_UBLKS,
>> +                GFP_NOWAIT);
>>       }
>>       spin_unlock(&ublk_idr_lock);
>>   @@ -2305,6 +2307,12 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>>           return -EINVAL;
>>       }
>>   +    if (header->dev_id != U32_MAX && header->dev_id > UBLK_MAX_UBLKS) {
>> +        pr_warn("%s: dev id is too large. Max supported is %d\n",
>> +            __func__, UBLK_MAX_UBLKS);
>> +        return -EINVAL;
>> +    }
>> +
>>       ublk_dump_dev_info(&info);
>>         ret = mutex_lock_killable(&ublk_ctl_mutex);
> 
> Why don't you do away with ublks_max and switch to dynamic minors once UBLK_MAX_UBLKS is reached?

My concern with dynamic minors was that userspace was assuming the
dev_id and char dev minor matched and might have been doing something
based on that assumption. If that's not the case, then I think we can
just switch to always use dynamic minors right?

Note that there are 2 cases where userspace can pass in the dev_id
and where the kernel allocates it. For the latter we could use
the dynamic minor for the dev_id right now (swap what we do now).
For the former though, if userspace did want the dev_id==minor
then your suggestion makes the code and interface more complicated
and I'm not sure if it's worth it since we can support up to 1
million devices already.

