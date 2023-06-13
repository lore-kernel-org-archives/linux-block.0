Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E90C7EE2F
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 00:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjFMAz7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 20:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFMAz6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 20:55:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2580131
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 17:55:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKO5pb029728;
        Tue, 13 Jun 2023 00:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ZM0Jp4yvOwmDcBoxiWerI2S+DNUBvyTZIYPXF0cJES8=;
 b=Y/KvuR+1xyRW0mM4CcaYW/CJs3XHiUMRvZdttLrBA8WZu08l9R0SgLUgL8UMOEMi6yON
 IKnN52h4if5+pIxMTocnIYm1/eHAV8nbdupGn0aqopu/cCrPRlAq4G02n13os1ml5Q9t
 PLZujxGNE3xkcUmP2vt/hK7Su9vdVIOn7AtBktIgyuRmADTtV3CS0LuUvSkeRyZisYF+
 hqfGiRYy4KR4J1Bi4VM5RxK5O0/AryeJ3erkRqEWstq2zgPp77PlpI+9eiNjWJfHQ4fc
 bcIeZxXIoSNF6YczrZvMnO8AJLgA45MppRHF1YuC1OZFHkT/eXWUDrCiFUPlOYzHyTjC tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2am4rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 00:55:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CNOE8N014211;
        Tue, 13 Jun 2023 00:55:50 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm38cqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 00:55:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uwp4W+rXupI80yccEswdSHYjgk6mgKpYtXVP4762qGn62U1n9gq3em31wGUMkN2tsD6eZw7vC84nkdoKew+3cX6rRoNWmIUIHPNnz1d4I7vQoOpMTOacIzgmEE8JPqsyMtvE4RbA8vn88WDE7eyi5kgjey/r1Z6NB682qPIJgEkYZJpwF+rFx/Z61+jcgBkp0Pj5+yDZsr2JUSxazll0lo+KbS1ITXv2iBj5Oevta5tUckZWkUOMkpf1F41t5/E123p3+mc1jN7Kts0TBo/c9nYlNNb5UQZTTZrJ2vzYSmkvzWz7zZKHfRwBiTrdkAOVkbbOu8UyjkNACsK3Qna6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZM0Jp4yvOwmDcBoxiWerI2S+DNUBvyTZIYPXF0cJES8=;
 b=EplZ3nx1orh6FzsyxMhK3ca+/Bq1crCDZw6qKncwiOMOL1mEG9tKALZNBVmi0wTbEtdNW0mPGcm/GQD+b36lBtFQF/Lu43xRkpib4K189jQ0TQkbl7GIY31zIQJ2Evh8P18ez0LUSqFvTgp8gYLEj6ka4L0/Q6yc532N0RtnR6j+GgY5WZVnrInMK5xqnFND/iEaSf7scNHM2kOTs9BnXlO1ZWjtjn06HTmnxHc2qbdXp7k1RXSGSQTLdz/u1JciixA0mV/S3LCrbqXUlO1Po4+l8O+36ASatgm+GoeC0vf0hHOcCWwWQuU3gnX1ZZVbH/taYioHM39cn6NU/d1+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZM0Jp4yvOwmDcBoxiWerI2S+DNUBvyTZIYPXF0cJES8=;
 b=vAEphWtHJ5YfcRG/9A2Ka7g5Qw1F8MYQQwU+uuvSzi8f3lYQ3A18NtaUG+m6Tpm5/DJKEJIEd9/QxV6Vd9y2MRLXGhThW5JnoWJCCg7cxuxFW3vQTic/LOfAdP1hA50H+4XlrIfhQMKcUhmZZz38GNeCJYEVJrXnyQkdAQTFhiA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW5PR10MB5850.namprd10.prod.outlook.com (2603:10b6:303:190::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Tue, 13 Jun
 2023 00:55:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 00:55:48 +0000
To:     John Pittman <jpittman@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>, axboe@kernel.dk,
        djeffery@redhat.com, loberman@redhat.com, emilne@redhat.com,
        minlei@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: set reasonable default for discard max
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jnc18y0.fsf@ca-mkp.ca.oracle.com>
References: <20230609180805.736872-1-jpittman@redhat.com>
        <yq1legs1nns.fsf@ca-mkp.ca.oracle.com>
        <CA+RJvhzPfmjD0FZxWS5gFeZJWKki5OcdmywZdngqhgSjm6wiFA@mail.gmail.com>
Date:   Mon, 12 Jun 2023 20:55:46 -0400
In-Reply-To: <CA+RJvhzPfmjD0FZxWS5gFeZJWKki5OcdmywZdngqhgSjm6wiFA@mail.gmail.com>
        (John Pittman's message of "Fri, 9 Jun 2023 20:22:31 -0400")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:8:2f::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW5PR10MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: c6610ea8-d9f4-41b9-5a20-08db6ba8ed51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UwOSLfw0KnuimOp8R/vjWSIbiW/UETbXL+Vi+A3e9gH3vN0D/Yok6AzGljVBfLNWzFNgnO1ENjjm4VJoyydtMrEZPd2yhBFlW+yBkGrq4Ggv40KJwEkc6Tp6xtxniSCUxDOG26AT88wHmmCI2fet2MFobx3oGOivCUQekjyR2EfEa/eIBSOGXJ8fFZiX0CCrTbjJIx6b/CSRPxIw5MLZFk82BDGqhzjweHl8XstPeLp7NqhRYXNQJzEjdtS3cizpICfxwyJKyQmCok/6t+EZRdgdC+8ZdQcUxGNUijt/En61nfzbyAsL2nzxWJ4JIaj6S5g958uXZbf6iVLzIKwJ3z4W2GJzrIM9Mv/Fsop1R+iq4HdoCnx8Xsgh0crHUoHC3ZoaocHY0AoVHTTzYXp6QAXUl/8Ll+vt77TgyTymy81ix6ULIlPTrJr0lpgQWyJhP+8qjoEFl5wvZb5IZIu8/li/TQIm20SALFt7Oa5MlnQSg6P4rGYpU717VjVaOz+rHNiyEY6BliSoGVlQ53yicGYiZP32jN/tuwt8x2wxyiLpkiFfJE/jNeTfsv1qnqfu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(83380400001)(6486002)(478600001)(8936002)(8676002)(4326008)(86362001)(66476007)(66556008)(66946007)(6916009)(5660300002)(38100700002)(41300700001)(316002)(36916002)(4744005)(2906002)(6512007)(26005)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RO2WuhWtgckgzoine+0w5mVYtO1SlHhB6aVyjJGQDOLfjUkS1Uh8nxF1jq2i?=
 =?us-ascii?Q?2vJWYwwao/WwPZ+gHDumYAGeY/GY/tEnkoZWYpFpxry+HPiHEOci9eX49ed0?=
 =?us-ascii?Q?GTDkYOXvG0QsP85ILOxcSOPrw3GuOyKhYMowSTGuWleFL//xqAfofHDGCxcP?=
 =?us-ascii?Q?34O4V+OMl+f0vZENXOuywuQwIiySdSg28ETMLMX8IerqbfvPYUMZjvC0Oycn?=
 =?us-ascii?Q?NbDXvpP1dq+vkIQqMjXkTjIGHlevQgNAf4AdxWMC68O4EluQmPYdHq/BPet8?=
 =?us-ascii?Q?tMw6B+qUGC+i5FRmszJyroTlygfwWlNDZB1AIlKWRZUbq0fLsitBRLRjl1es?=
 =?us-ascii?Q?nwQvio0JneSKfXFi1+nm5mZT/vgtr7Az+Pbv6bdcbsnso8IYxDPmVOBNhq5E?=
 =?us-ascii?Q?N9lnd4buCMxW4tXAXnp7GZH8ECSIYyfRWFcTRb9o/bUhcPg7BMpwzmeGFJzt?=
 =?us-ascii?Q?ofnVZRm6yOb5u4IGxtd725hUhKVXhVOYrWpMlpfk2LiE6/RDVzlCrJkpoxu0?=
 =?us-ascii?Q?s0RVqTNMUgGZRjMs2qp7imJS6evlJrBtacGwagTdON/FPWy3+VShk1E4ElRo?=
 =?us-ascii?Q?LYa9XWta0DeqRPPAT2Pe+niLp+MAeotVeA89aYvn/XfC2MjxOnWMBJmaFeLr?=
 =?us-ascii?Q?spnnVWU9U0kCs/35lkxFMyl36YPh0ra5Tp6Tp/hXAxLqn5evVAdXRfflSfua?=
 =?us-ascii?Q?oxKR6kkgatu8UtArDnnHA+2T2VKRa3osTOk/1OdkiRb0Buqm3JdFdAo081xs?=
 =?us-ascii?Q?x9URCjKMLpn2bBzk+2UYhPYYrJ7DGEsBsmz5YTitbrxmLNm4w4GHJSqEYrMI?=
 =?us-ascii?Q?mE/0zFcwFEcHCoI3Em3CM9bVUQ1flkjC6ybtoDOYRrNtMARp0+ddm+iOjLXk?=
 =?us-ascii?Q?kJBl5T3KCSdv6DYVbf1WLN75HNpwh3G12gCjiTiU+Ch2CEKGsN+Y5gSxoQ93?=
 =?us-ascii?Q?Pi9kJkZ50IomljSSbO214HF0EvWlWqrbvGM6i9SOrmSTUq+bFNoJfmMfalU3?=
 =?us-ascii?Q?kRS+2npD+QnaypERKct9kNLWxY3R7hKSsCvB/p1y0t9nWoCUbU6YW3cGDm0J?=
 =?us-ascii?Q?jO8KvehdPohtFLh+V8Lfe827egfcPHqylh4JBxji3r4TW88m8c543kWDgZXM?=
 =?us-ascii?Q?4LBR0quROpvEV8huSb+bjCAvt+NzB/hPDWBM+1YQcWiyHqWk5c8f9a5mIUlK?=
 =?us-ascii?Q?8aU77Ope9r7x45szQpRokFMmha2u/cAbLAHmhBTdY4Xs0AzGUHQeTqwuUgRB?=
 =?us-ascii?Q?Lm5bqsatdx1F8ITTrGwY1JkK9Ii3nQ+Q1j1NCKM1QXeqdGSGjEDI3Z+Se5+G?=
 =?us-ascii?Q?wUqu7Hp206JISsELdVtz6aecNuRZ6RI6PQP2vRUfBsmyAIyct/z6p8cu9izi?=
 =?us-ascii?Q?S9YpDfwhWF5X9b/kuJZ5eCy3cIPCUHnnRHzJtamQOksY+A8dwHgeKCUIGy6+?=
 =?us-ascii?Q?cD25dHHnf6lpirIi+dvsrFirsoRs6HISp8rVZ/zRVCgJMM8HKMR3CRqq+2DU?=
 =?us-ascii?Q?JKZCm5QenhKEentNQ4/YDMY9viUfavby1IKC90I7aTUlWVTkEyrSGGQ3GInB?=
 =?us-ascii?Q?ThSMD3uNDtO4oqfWCKSozH391Z5OnWQT5SHPNoQgwqvHdECdUsx/eyWZrXS/?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: azM5kB21x38zBNVv1RvvqiWWsbVpClxfR2g9lE0o5PbcWbAcihJBiivm/SjkhSxkLCBcdim2GzwhTwbNfoYvN4sJEoCPUVfP5qjCB7pqOw78Tx69mJ0JnsIfV21St8rsxhvV6pc+ArBbW76BkwqmOxYljNGF3powGNSudy0VMxlNhv56iKcf6tqLSfOcTBmggmNei7Jr0b77byoXEv7MZqJNObSQvs25Ra/Bu5HyyuleTQsmQqHeJWfdk8o0bbeROOoM4MsqIwK3OVe8Kc5LpdL0kHget3dxdHtzWbgpRO5N3+Vp/suc8fxOMVUgTCimWgyXeU6x1XYD9duTy3dI2wW1a+mYcx6db1IS0KXVaEPVnwqDrm1zkp5RT2dkyGT8Aid4F2P+XQppqoUHHYXUiyplrDfU0SLzeiMUFSa9zRyr8FqeASEo0bFrG7m7PVxmShjlUXlIHxvPX9tZqxycPoQHzFyIlwzYCVLkqsWJhHtX0y920E6lR55Ygbi723OOLXZ3hVVS8AT+hfVaCMONEKAxaqCc4YXwVpEXvzvIifnlSvZKdUykmhblcOJSpeoBZc4ZmSOB3oEcnnNw4WMyWLGse2ZyI3ool62lICAmjr9sk7f9cu8rOBpVWT391B2j/eP/Ph/zL7JzzLxXLyG3QomTM4SDYAZberktWJ6jkeXdxsJwiRw8DOapPpUnd+fyHEM11DMVMgNFsWSjygY8d90s23Dg5ZlRWPXRW6K4YVvKIS4IXskV3nVhYwccg/V/rKecS+vgAblqjQXdZIZ21QvJPZuBfuSRGfcUkT9umMV3oFMRSOFcmqs7jPDDLYqJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6610ea8-d9f4-41b9-5a20-08db6ba8ed51
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 00:55:48.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKW9WNhwChR99LjIDz9wImoEPDv5iuhLVFKBu6Z2Y+EP1+sCGL2BYoI7sA8lNL9lkly132V7GzWYDwQRxjDKvs7SahJX3toKka0ZaTCnp/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=734 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130006
X-Proofpoint-ORIG-GUID: bgrOaMI8lbXxgetyAU11aBQ--AcROBXg
X-Proofpoint-GUID: bgrOaMI8lbXxgetyAU11aBQ--AcROBXg
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


John,

> Thanks alot for responding Martin.  Forgive my ignorance; just trying
> to gain understanding.  For example, if we find a device with a 2TiB
> max discard (way too high for any device to handle reasonably from
> what I've seen),

That really depends. On some devices performing a 2TB discard may just
involve updating a few entries in a block translation table. It could be
close to constant time regardless of the number of terabytes unmapped.

> and we make a quirk for it that brings the max discard down, how do we
> decide what value to bring that down to? Would we ask the hardware
> vendor for an optimal value? Is there some way we could decide the
> value?

The best thing would be to ask the vendor. Or maybe if you provide the
output of

# sg_vpd -p bl /dev/sdN

and we can try to see if we can come up with a suitable heuristic for a
quirk.

-- 
Martin K. Petersen	Oracle Linux Engineering
