Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B06C433F5
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 20:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382947AbiEBUhq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 16:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiEBUhp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 16:37:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A010AB7C6
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 13:34:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242JK4A1004092;
        Mon, 2 May 2022 20:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=lVKafTR3k2ys9RoKSbpSZMoDFEwmM0MAZzwnEzv0MyE=;
 b=CKEBk8nxY1stnuGxEZq745ltot0mj6bMpoy6TfPx7oP2V9S9DiaZ/XVROOexjmFO/6Ia
 /vhTY1rOC/YDCj0ZCfrraTgcspfaDuiM9ML3pUButUTpDBMFX9kybwMlnNgmnhr/+mqD
 QIZj41Jf+BfMTAc1gzas9eyyZls1v8DwKcGHyW4VlSdtG3ekXIdkrfCHdq+9SYA0+75N
 UxhP2CM/2CZbvnFrGIP68w6XUluPUZJB3Z8qMVJVKrogabGza4eHR5iDDvFZiryAH+0X
 eow0PKVm5GOKBvm5OATi3wwXkbCJ/QAU4EBqh97lF8mZB4NFgO0vuOrsJ0xy/L46Stj/ 0g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0am6h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 20:34:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 242KQO34016146;
        Mon, 2 May 2022 20:34:05 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj8d0hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 20:34:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJa69BmMG/69PjrqAwyUwimYP8UaK0cxe/CLFxXDnLQ4amtkCGeh7WjsZ9ZZGbuB7Nz5eO3eAcFu/6AZEBZecoEll+Pfj1gP8dRJP+6PezMKzKwrXAx4rgL19wr5/Kv0stJTScVYvNj8Yg9DR6YvqF0ZpXk4dqqN49Sh3nEFK/D2KT4545vjlhxHjGjChZxHeBdPTN46NetSdQN30UjFsWKrOc9SiTJa+oC/To7AE0M0Aa8Emvcv23aMZKHBYdARz8tPe/Ph0iq7E5BNCBPMwm0NMZ682mdBlM1eb/xstiLfJh4c1SqoSobXRYMWCUDg0NC6SE8MY1iLvgYZiYBkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVKafTR3k2ys9RoKSbpSZMoDFEwmM0MAZzwnEzv0MyE=;
 b=dtPWMXrHnOCvWGVvGYJIdNifr7YI+f1fCKBCQidBmcsyxzIRQ/PXWCkivV1YYqxFcqXPOObcr0l4WP36+Gp929qUhIjYBhXxs0nYzWFy7dviC+TJu6+2ftY42lW2qouev2fry2bpfKiYmaVd/snYZoprrjwI0XYNJv0UOgMnk18J7j1dSl2w+ek+FgNWyM34JmRb/tO7gfXjJlG9JgKjdlMtp9NaY9AjHrrWt9to7cNXYgIfVkb07YY+fmLeGjmTUrI+RKxtzv31NQzut1ejCWkoosLT8t9VKrPa14L4Img0LnG2vRz8omNRGVWfrauFChvlB7qWzIQ99efHbNkXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVKafTR3k2ys9RoKSbpSZMoDFEwmM0MAZzwnEzv0MyE=;
 b=xDliwVSJC8m/ut/eW4uFL9L/8DNcCMpUMXqQ3CD6StGwC5wPi+BWfFndld6i0LsCBy+7gNFaKiO07jZlmJ8OI1dz4x/g9Wjt/msJvdxb37iGeiwVIgE4t8oYHokEH6P+DzhMEeLxUqD0FmsEgtJN6RaWlobzTlZ9E0E+t3eR+Jw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB3375.namprd10.prod.outlook.com (2603:10b6:208:12f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Mon, 2 May
 2022 20:34:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 20:34:04 +0000
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Hannes Reinecke <hare@suse.de>, Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] eBFP for block devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1zjd6am.fsf@ca-mkp.ca.oracle.com>
References: <5276e9fa-a253-6195-e697-60b4ff6e9bc4@suse.de>
        <87y1zjq14c.fsf@collabora.com> <yq1h767epmx.fsf@ca-mkp.ca.oracle.com>
        <CACGdZY+=Ugn0vd4+zsFoKwHp6f3Rv27wdssgvSoS_Onoi1yXUw@mail.gmail.com>
Date:   Mon, 02 May 2022 16:34:02 -0400
In-Reply-To: <CACGdZY+=Ugn0vd4+zsFoKwHp6f3Rv27wdssgvSoS_Onoi1yXUw@mail.gmail.com>
        (Khazhy Kumykov's message of "Mon, 2 May 2022 13:28:20 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0014.namprd12.prod.outlook.com
 (2603:10b6:806:6f::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b39fb4d2-919d-4505-f637-08da2c7b1915
X-MS-TrafficTypeDiagnostic: MN2PR10MB3375:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3375F1AA761A45B89BAD6D328EC19@MN2PR10MB3375.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rm6yCi7BgXj7PHmo2b2l0j6pRCxBSL+PbGV9y6+XVLBQKgZJLWSa5WjiX5IT7Y9TdrbAZeXnCJP28Tb7zaA0WptzmDRhZmIF9zavXOPVFSiLiIIzpi0VtGTYk4BhWU60TB5rOU+PdILWg4sRQnJGyz4A/1sa3+oSsbl7z+0yo7QMxZxSttx3Q0GHYFFp//k1kzyWii2d/fnD8rhPmhrPb+U8tVPOy0FGRd/T1ScPpEynJR7zGBRZzl5I/Hbe5hoefPgwGB3E/JslXK7qT1IUQgWhlKVpC9qyJ15CIG8b22LKx3RtFzhoIcVDNeGl4mIfAjLcf3oiMlTbiHfT8/U9Owt/KMJVumP3OlUfQKTctp8v8hphNck/a1jZgA2kKP8Y/dhRy5PQHb1ZgQvasdwYgvGBPp/RGu4IP5gK7pwD607CmuOW0fLsq2npH26bMMKXC6BoY+hgx+ZjPsmuQ7Yl+OL72bKsw9dDwTfVnSm73kYuTthc4j9kqUqe8hp4rKkvUwIZvrpoVSqmzjnHy2LJJNAy+aMmWjzlWWnU8lGSjVQFhIztpNRHECUZDVCsQCEt8KXMZU9f3a3attMwOd13d1pMPqauh+PSdm6xWln2y28Lj/OxiGOIvIzHPoTMNbsma28gBOljllVjWpMytBBmn2JD0PKfKmVBTybjXVV32z2S/CoGTgExTQEuz6RsWlG0HE1kV5Pn1OdTItqVimJg3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36916002)(186003)(52116002)(508600001)(66946007)(8676002)(66476007)(6506007)(4326008)(38100700002)(6512007)(26005)(38350700002)(6486002)(66556008)(6916009)(54906003)(316002)(83380400001)(2906002)(86362001)(8936002)(5660300002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KZrfi7G9/W40LaquHpQgG4t4YAk995E3q+0+UGWgq/h4TwGsjHUoN9j660JM?=
 =?us-ascii?Q?9LooMVce+ZaBPYKKvpB96HESZf7djLRUulzLGSfJCohnf9z0sIixjurKytni?=
 =?us-ascii?Q?go0n7DXb37Lwo4sbMWWu78zFrVxaAE1RDl5qkS9nxrqsSS0LH5IEhM9Z0P/S?=
 =?us-ascii?Q?F3Gm6pGZyzekvLAmCFbI4GJ0Wf3kr2pFSAT9FZPCnwaPPTWfjmBjZZkZCFDS?=
 =?us-ascii?Q?/ES8TdaivD/ScaxRt/TJCgKAwy6e9eK6J6GG7j8Nsu57cJbswp1q8LYwgyfb?=
 =?us-ascii?Q?iNxfTp+sWo5fTCNn9QdnyEIvslm9TyuV0aE1t7kjiGLvodkL/6zkv69+JIGS?=
 =?us-ascii?Q?PW34dgKTxG+7EUmlJSvdaK0lEJLggfEekgTa83ozR1oPnW+1ZcANoUH9/HIv?=
 =?us-ascii?Q?OP/MBVrF5fazyiVuxhlTrIa7tJtE6n8aNpIrkcQYa6u1f10zoSJ3upCke/48?=
 =?us-ascii?Q?AqslG1z+hMthfcICaT/DqJcMvom6yHPlHbPQJGBEQInb6XsuWJswxKOT7k4S?=
 =?us-ascii?Q?GgZCJd1GbBKXad0UFhixzXU7qDxnPnB+18O98NstwNrr3e7wVl14aLgS1zcs?=
 =?us-ascii?Q?eWY0bdX9VKVnIBfJPLuz+njAJEYgOmriLIPc6iQce9a1oipbEpApKzJeFaXO?=
 =?us-ascii?Q?9F3YOZYwa7xvqck6jhMenlmdTNbcOlWZHqpvy3JNs8aNiYlK0E5LIuvV6sca?=
 =?us-ascii?Q?/3XukOj3uh1fuH2sS9aaIW/yhiivsnXlUoEWEOrEikPFNmqHriGZ7lbq148r?=
 =?us-ascii?Q?9LW/WciZbw6FgbqNtKVeElLsZ3UqJE1Wi3cc+FPXCHnT0Ij6ek/oovHex8WI?=
 =?us-ascii?Q?RusO46Fouqy8uZY/nINTJxY3vo4gm1150yp4PoJClUVuyTZtZHJDb94aB0Fa?=
 =?us-ascii?Q?RdSdyrFYPWXtG08g0eIS2gNbA3W2HhBGD1VZ/Fnxx/ciAXh9wfY5VFlLAzEa?=
 =?us-ascii?Q?BZV9b7wiY++5d/MD9p/715Ha5c6LXl6QTntg04ThK33c+tgv6lONW8xojfDC?=
 =?us-ascii?Q?OL5UR+Uq0HdUk+1y6uMSC1p/FgokW0DGJpccmzZu9mpFx9eKXk8tvOZBnynP?=
 =?us-ascii?Q?VzbdTNtRbuAD+AF23jS0a8xB+0RH3eWlslPIVSbo1jzc1gAX9dInIIb39FgY?=
 =?us-ascii?Q?CKakEtgOCbS0cWw0M4tvjuLt+UK/xhfD1dUVD+kwgzzDYquSdLzehyvN+dOh?=
 =?us-ascii?Q?8h+M0KYQn/9uCen9Vb7CRFU7PhjNukUnIDSIyvhPf2q+yd6kVh7WUdZoOZew?=
 =?us-ascii?Q?+jqCt+SUVVuM+wG4wAtL4YMuDZC0WSboEE5HPwD5D6R6MoCknoH1wYxjgirp?=
 =?us-ascii?Q?SV46DIjWD6bLPZEijs4Tl/WvlDvkoU5xUOCXaWyOlPkvQyYash9SLEuk7k/+?=
 =?us-ascii?Q?uzP6ZIA8c0JMTwnGQ3XWweOhUQTI92zuyfMbjS4gASM4EkF59/Ejjpvdv1an?=
 =?us-ascii?Q?J6PwPgK6RAp/+veKrpRKiwl0U883RG4m3+3ay925ZOMu5dSw1CGGXwg1Ns/d?=
 =?us-ascii?Q?SnRoxOiXu/1H94xjMd9eBgicpccOMih5W85tbd2a98QPgi/uEgqJ1zfFuAXN?=
 =?us-ascii?Q?QGTzxCbMToi/OirvCCmCu5xRwyWd2B+YNKxji2TrtNb8bKTFUToMoiJ1NST1?=
 =?us-ascii?Q?rIRnVooQm99z8Y4cAYqnihND9BvN7p6h1UjGPePw9tk2cWXk60PvHsDhiVVV?=
 =?us-ascii?Q?GGs6qTWmCtMJFU/Y1SK/Ncm9Dm+V4W4d+Mw6gcr+LYcDG78FlCO/CaySlEEY?=
 =?us-ascii?Q?tUsouvFeez/Mp4780tcQ64yOodFJ2sY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39fb4d2-919d-4505-f637-08da2c7b1915
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 20:34:04.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIOFmJDtXj9+si3CFG8eNYT3rkfdGTFuZGgA0QxeXU0PTPUZgpph2JrIHdaxhSNa0+hcP5xjni6W8RwGXDCbp4DF1fnp+XCuv6I8KB1EosQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3375
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-02_06:2022-05-02,2022-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=934 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020152
X-Proofpoint-GUID: KoNin8yV6lQH5FB7OU-l34DQHA4ALw9X
X-Proofpoint-ORIG-GUID: KoNin8yV6lQH5FB7OU-l34DQHA4ALw9X
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Khazhy,

>> We've been working in this area too. It possible to write BPF filters to
>> protect block ranges using should_fail_bio().
>
> It'd be nice to have a "proper" api vs. ALLOW_ERROR_INJECTION, which
> feels more debug-y and has the drawback of
> CONFIG_FUNCTION_ERROR_INJECTION being all-or-nothing

I agree that it would be nice for this to be detached from error
injection.

-- 
Martin K. Petersen	Oracle Linux Engineering
