Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0E0E7AD6E
	for <linux-block@archiver.kernel.org>; Tue,  3 Oct 2023 15:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjJCPyp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Oct 2023 11:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjJCPym (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2023 11:54:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2812DB8
        for <linux-block@vger.kernel.org>; Tue,  3 Oct 2023 08:54:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393Dwjeo024405;
        Tue, 3 Oct 2023 15:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=V0+QLFwQLiOntQBq8k1bU+JHAEFocxWRu6xusfxVBvY=;
 b=3uCNpiARwN4AFeyAzgznzlcixTbJ1yFhno3687NGpv0lyIjjmrvErNs7A6NSz9KhLIqm
 MbtBr4qXc4/uDByj8fVQ+UQP1d/aiUCB9IuBeqfYBKM3SkApyDGmzV9fxuTIFoETUCf3
 Sbmd80DnwW6gA5vKsBH+nQ/aTYYevtXfvq4kSgorb7KKpVJq1yJZTgq0ak8Wo8ip2neQ
 /LlvTliDlh6PWGD4SaAWmb8Ero0i2+Sq6WDzVur1xd7PdCxSatLVIRK8Rb6ulEADLnYS
 6rJkzIml2/30vKBaCBGIkBGrEcrQW1yq4d0peY8kt+oNckLrZdWLhnjz20Qfkiz1PQvO mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf453sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 15:54:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393FMZ5X005789;
        Tue, 3 Oct 2023 15:54:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4683u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 15:54:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evgrfDCNl9b2YmzuCZO+Rqm6fZOt7G4W6zJpvv5X8U79UwLLV4WkaofGPhtx4VYfyRxgGj+6/E3lcQAJ/+U2TBmGXdVmSXvlWC+87zmEOkZT22mgscoEGFNJmt2/0CnECdpzrLyrWIp6C5OCCcBrHXb9/ofW4qPlSDKPZt+yEvxGO4If0LUb7CBzzFbeAxF54UAmnLXf70obhHGR3M1qmY7sTEuGGqEVHP0LAIyGiAPHP6qF8CIxfez+Xswgxi8RR6c2jTAIO6rJAQ1QDzhPPzesI4Ad1PlORXZmGJxFiQ1QS3iBmPaTBj4FRcBOW/H5Hzo7qNb3Q5aizO3AwpjrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0+QLFwQLiOntQBq8k1bU+JHAEFocxWRu6xusfxVBvY=;
 b=RYEP7PJXPb0GnA3E9fLv1LaBXe+c0x8OaonxgN4TcP306DZ0VkVp0aYC/ggcNfUqkOp7WTa7ZFiOgpAlVJ4hoMLGpWNgHBOvNJU61QZ+KXmy4FyK3zseKDq6Pp3tR6ZgMPf7FXpZMaGgXoJ42XIUUzm6S4ijosafPNTGZKLvg+ODe/pRt1XzWV939h2iC/ZLHSLzBbh8+usI+fNfW3Jrs8tiutVIjJV64WNco/aFXxSh6lug7oyfzAZiEKDXoj3DEmZN7eJN1XvGFPdPGWrbs12+OqnCfytI8XxPdlmpRVAd8rxibPBL2uJq/xO3OT8a15DPBd2pno5ESfC96oB9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0+QLFwQLiOntQBq8k1bU+JHAEFocxWRu6xusfxVBvY=;
 b=YgzMV+cXYou3af3woyIY9T9uQ9b4sdCEUm412sjRM3ucszWIF5QuOUG+oenqo9agxxZLibDNrIZpOgRsGfzDvQKHtRsKtO1Mo+Le4F2O+b+aGg5NDPBRb7ZxDaC4E4A/Hdm+MTGljUkEtoRVJwGyQxrWp3prO5ixL06uKmnstLo=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by MW4PR10MB5840.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 15:54:26 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%7]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 15:54:26 +0000
Message-ID: <14824c1c-12aa-49df-ac44-ad4e95060cab@oracle.com>
Date:   Tue, 3 Oct 2023 10:54:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ublk: Make ublks_max configurable
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
References: <20231001185448.48893-1-michael.christie@oracle.com>
 <20231001185448.48893-3-michael.christie@oracle.com>
 <ZRw3hzwTkvA4D8Ee@fedora>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <ZRw3hzwTkvA4D8Ee@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::34) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|MW4PR10MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 00832577-bfff-4555-f556-08dbc4290574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/MuMmhUiaNp8mT3Kp87e2LtBMdG/EDnHMSxOaRILDaVWh4xQrxPsxE8y80otPUSjJtEgtdtr6jeKqFOv8xxMLB+X1MUv4r06xk3pYxcLsc7DQJ1nxMm/muD/BoJ+/r+aHb9mveU3lpIJM6hDBV1xl9BjXsR4yLpoplL+U3tixL1Hc6TzX3So6IkQ2sfJWVo2HWv5W+yaa+z9QXzHliMQDWLfRy53rSWovwBJixvQzD8pYDashryHl7JbiXrHs7JjDqLUPCcOm4zFwt09USD3fbF75xkUH4zp8ZZNFC/SwkLFi4bi0blJyfgIFIvSUFMWPVDl/8U0PnPBOrQNXGQo7SldX+VF0BdPFR/BbziO3EWcinwwXTYaCPEUCyPFEqXZZpzpwykOsZUkuozrlZNQ/UPDPFH+gCHMLUeEK05TGLgFTiyB8Oh7UgvIjaKToMQDd/3fv/4nY8CjCxXxJurINF1YML6n7QgylivXsDd+gGjgYZfU4ZHsthuPIVWmHI/AJ5ZWjN2ljn2yNun/xe3/3FdP0xxIHhgN9C+q04slabRx61ATbz0yPToIby5vrFYIrdWNOkbeEngydWK+63eh5WAj52UWlf5Qv7kw2q9oOm5mV0JjCmMKO/9qj2ZuX2zVKykJlZf7ltuFV3CEV0YBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(66556008)(6916009)(66476007)(66946007)(4326008)(8936002)(6512007)(2906002)(41300700001)(8676002)(316002)(38100700002)(83380400001)(5660300002)(478600001)(6486002)(53546011)(2616005)(86362001)(36756003)(6506007)(26005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW02cWFyT2M1ZlpGb2pxay8xanZkVEVsZ1dZSk54Mmx2Tm5WWVZhS2NENXll?=
 =?utf-8?B?cEJveXZHWmN1dFM1Q2w4ZWRZTS8xcml4bnd3RElNR1p3YXpRMkx6cUQyT0Mr?=
 =?utf-8?B?eGJlV1hhZ2IvTG5JNVZNWWlpWmlZUi9wYVZoNHFQN00rdnI5K1ZTcGZiczFB?=
 =?utf-8?B?SzBpSHc4dkxRM0ZDSGpCTjJUYnQ1dkVTOEdyQXgrUHErYUcxcDRvZlZNMjNU?=
 =?utf-8?B?QytjUTVUNEZTMXI4NzR3d0hrS3l6TTVsVWJJZ2MrUjA2WVNSRmtSN0ZOYUVq?=
 =?utf-8?B?ajYwaWtjc3RxZnRwb2FJemtQMWcyTWRYT2ZYOGpmeFJFV2hPSm1BQ0laKzBK?=
 =?utf-8?B?TVhLNWRiNGllbXh2NExTNmY2bHpUeGsxVERZQzh0OTQxUE5NQ2VBbXNWenBs?=
 =?utf-8?B?ZkZ2eU5CVmNXY1lYRW13WmxINE9UODVIWkNRcGpqUmFIRExFc3p4Y3hzTmMw?=
 =?utf-8?B?YnRBbURQTkhUUVNqOC9RKzN0TFRRNXFjS1N2Q1ZYOVBDV012SFE5cmxBdGF0?=
 =?utf-8?B?YU5vK3ZCZW43VzR5WE9EYzZVUUR0anpiWmNSYzZiZGNOUy8wYXNnWDhiYzZX?=
 =?utf-8?B?cmUzV2NZVDBsVWZucXJna1BlUTBPeTVKUjh3a21Gdk1uQ0RKZXluVzA4UGQw?=
 =?utf-8?B?K2NNMXZGbVFmcWZhNHdPTHl6T2hCL2d2UjhCMlVzTUlGUUtKQkJzNmhhV1pE?=
 =?utf-8?B?MHNXRmg1eE9nMllGZGR0aWw2VEdmbmswZ1VkYVpDYjNJd2szVjJVajdRZ0lJ?=
 =?utf-8?B?N2pQRU41Z1NKZkt2OVlSK1NQdmM1OTdXcmF6am5BY1AzWlVkUU1YR216UktR?=
 =?utf-8?B?UW15RmpKWGdlYktSeXhXV0JLdWxPVnZmSmVHTE9pWVFmMzJuaGNwL0VPWm1Y?=
 =?utf-8?B?amVrSjJ4aVdmcXRLSnhVT0pTTWduNWVvUi9ZRnlHMVZaOEpBY1BDSTB4R1Fa?=
 =?utf-8?B?MGJLaWd0ZjI2LzNFKzNBam0zWUV4TVA1VVRNUGoyeHRCcGxoemsxRCtBZnVx?=
 =?utf-8?B?UEN6Z3h6UU1Da0hMZ1NaRCsyYldsNTg0YUdldTVKZlV3NEM4NXpucFNONFpG?=
 =?utf-8?B?cjFjb0VFeUswZkZaOFR3ZzhNU1NSeGUvWXQ0em1LbXVKMHFmeGFNVUt0bmFU?=
 =?utf-8?B?MDl6NWc0eE92QzJUZk44YTFFMTJCN3Y5bTY1RVFLSGFHZjhTUE03dHNzd3VS?=
 =?utf-8?B?ZjlTWnZrWkZIRFBtMThDTy9GSzVoRVJTTnBzZVZtMHFPZ1VsMmtxTGxnOFdu?=
 =?utf-8?B?Y3liRkhkVEgzTlJvT2lDR2pscUltTzN5alZLS1NnQmRQT2dDdVNtRlY3RG9t?=
 =?utf-8?B?RTh5SHhHdE5pL0xTd0dQaFVvcHk5T2k4Y1B3UlRlc3hVYk1NRHFzVGJWeVhZ?=
 =?utf-8?B?NFB4NFpEcEJNRzE3U2VPNUd4TGk1Y0ZLZHByUTdXTWtqLzdKeDlmQ2NQd01w?=
 =?utf-8?B?Tk5NY0NNbGZjRlZyNWlGalJCRkY3cFVncitHM1ZwRmdYbVlCdUNYVGoxY0hz?=
 =?utf-8?B?M0JwZXZDVlRrRU9OYmx5L2pNSnluYXdCTXdwZFU0aHZkNkdkSDRZcU1ma25B?=
 =?utf-8?B?SkNWd3JZdWdJUWJWQ2tDZHRzdElYYmt6clUrZDJqdnhUSTBSOTRlQmMxR3B3?=
 =?utf-8?B?MUo5eE9zcW9rcEdrYVUyeEtZaXl4RlUrNnhpcjkxQVk5aXJoUXo1N3ZVeGtJ?=
 =?utf-8?B?ZjkvNlBmRzZTWEx6VlgvRm9IaFA5NWpmazFORDk2SitHaUo3Sk5NUGpieDhH?=
 =?utf-8?B?T0VHYk5ONXVob0NIYzM2WTNtQzJvd1IwNFZzOFd4bXlVMWcvRXpsemJaR1NV?=
 =?utf-8?B?cUFJMFF3ckZmbElRWk5WVktNYlBIUktkS296ZGJUNFNUQ09zOTNLL3g5WXFH?=
 =?utf-8?B?NjZHckNNUGJSWkkwQVd3OEx0SkcxSTkveWZWN3JGMnpOUUl6YWpBUlZBUnVR?=
 =?utf-8?B?STczSDZlWFBHZkJ2T05FSXhGdFBNeHBnWEZqaWVIUFpWK2pjV0lwWFlRdG54?=
 =?utf-8?B?eU5NQ094MGFTa3k1cUlWR0pFN1JMc0xvbng3THkvZmxVWEZYVWlkc2NSNjgw?=
 =?utf-8?B?eDE5emtQMGJiNnRad3BkSnZiVytLdlpudXZucTVnOTJNSTN3N1BRR0hPSUNZ?=
 =?utf-8?B?WUZtNm9WS2owcW9obExZWDJjM0hnN3hpUm55S1dDRThVM0dMdUc0Y3Bmby93?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tNgdGehpUKrW4KJr4LZbcCAQMSCQBmeGxxosIYtOkYX5AIZAufnPHIB5Q+Sok6yAPZQCbHMAZoLgUr/3TZ6XqyyJsPRFrsGLtSQhj/8DQOPW+DYVzWfJNk43Tt/5wnM6wWh4rUGQO066PjwbBO+MYBAukB1aeBjVzwbx9dlfdsbBSTOL29wgnx9SlG5aIUT8HLHnBmlrrdhz3uRSopy9iFVFWTRoCVWaXUXThD5MpzkpuUOvx5l5OXPXcJgSpsfwbKfZL6pfXwUWArS6RTl6lvGtmuldnJDhRULjvwdz5SdtuTs5EnJcZ4rIZDozwM/EhJReTP0WnZ+rMQZ4KBuHp1jGMBvLJgz9YTCLQH+/RXd3AJyUohmLMM1St038gusJ1hLvbuBonO6Ad5nHixVKUmjSX/EaqV6F5diSh9cgRsrJZbc65dNOCzHEWKF2ODIvRSrHZzbl0XmH3DBmcTMo2JjfzfRsoLw1M9jWbpzENAUglerjX53Ao9ONp9oUwIZb8DPLV7WFUvU+Zia+R+aElNi2wnosdeU7ZqeRp0ZmnGz/1Snl7goaRHSnxxdsV/nqSzd0Q/dDUp6wZ+DB8YbBp+8GgLTSIzjeDr8Ywqi+g0rTKIt1d5hlrUGvK2ECCrzBfeEMHndJAfemuHC3rH9IrKTg35YnLwRnm2vzoLcRFwUYKa3i2Pm8uDVB1lnP6Yjfm9g+oJKNRp2uRi3B6UhQtRAmLvLWFeuIOeyD54BOA+BZoIceSJO4XUWbSUuAyMKRrseKpWyU8bU3QAG+HSXLkhriuR76fi0i7nzF7OxhhaZISGiITUiNfaleLEdfUpHl
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00832577-bfff-4555-f556-08dbc4290574
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 15:54:26.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2xTl1Q/Ohhfb1N6mUEA0GNokC2Wc0MGCvfvZJ+PlGmb/Eet/g9/6vOQzZcbCFZRaLBlP81CQjMRnMHB6Ihwv51kh/ZciXWi2wOcKTFuEug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030120
X-Proofpoint-GUID: dq9Wd6nTs4Je4XWWV7siOX3bi0Ob2rWf
X-Proofpoint-ORIG-GUID: dq9Wd6nTs4Je4XWWV7siOX3bi0Ob2rWf
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/3/23 10:47 AM, Ming Lei wrote:
> On Sun, Oct 01, 2023 at 01:54:48PM -0500, Mike Christie wrote:
>> We are converting tcmu applications to ublk, but have systems with up
>> to 1k devices. This patch allows us to configure the ublks_max from
>> userspace with the ublks_max modparam.
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>> ---
>>  drivers/block/ublk_drv.c | 31 ++++++++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 18e352f8cd6d..2833a81e05c0 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -2940,7 +2940,36 @@ static void __exit ublk_exit(void)
>>  module_init(ublk_init);
>>  module_exit(ublk_exit);
>>  
>> -module_param(ublks_max, int, 0444);
>> +static int ublk_set_max_ublks(const char *buf, const struct kernel_param *kp)
>> +{
>> +	unsigned int max;
>> +	int ret;
>> +
>> +	ret = kstrtouint(buf, 10, &max);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (max > UBLK_MAX_UBLKS) {
>> +		pr_warn("Invalid ublks_max. Max supported is %d\n",
>> +			UBLK_MAX_UBLKS);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ublks_max = max;
>> +	return ret;
> 
> It might be nice to reuse builtin helper:
> 
> 	return param_set_uint_minmax(buf, kp, 0, UBLK_MAX_UBLKS);
> 

Was looking for something like that but missed it. Will
use.


>> +}
>> +
>> +static int ublk_get_max_ublks(char *buf, const struct kernel_param *kp)
>> +{
>> +	return sysfs_emit(buf, "%d\n", ublks_max);
>> +}
>> +
>> +static const struct kernel_param_ops ublk_max_ublks_ops = {
>> +	.set = ublk_set_max_ublks,
>> +	.get = ublk_get_max_ublks,
> 
> Same with above, '.get    = param_get_int,' could be better.
> 

Will do.

