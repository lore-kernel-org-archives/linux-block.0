Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB056C433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 20:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8344361976
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 20:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCSUHn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:07:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36068 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSUHX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 16:07:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JK3p5g091933;
        Fri, 19 Mar 2021 20:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=PChbkdg5J3RiFCTsBiEJ+8N60ctHcXYYu1ZCLRHfqrc=;
 b=g6Sinq+LHhRh7HyFS2MIkKefNF6cNjMsQxjUo5+DZeWlw541oXfivBeDgWswpwny7Uha
 h02t67MCBpjmFSh+saSMeZHRM2LMs7McyLatcpdxeC9HCSbKz09zOGsOM0nHvHjCUhJY
 XDru9UKTyuJvNjJDJLGDdmkZFYWFhxd/RiUt9ivpbfNAJNLi1l9B9hVyth8p1fssG6QZ
 GKERIhVA+y3HzLIONuSl02UylUnDT7ThqBS+7ABKy7d5oKc/beLGSKWABXl8dXr2vOj3
 voJCae/smmpwP6zeClVhg0IozaSrnU74l1h1b57evr7IBfX4cWrtU3U2+iy5iG1UEFFj Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 378p1p44sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 20:07:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JK6Eu9090139;
        Fri, 19 Mar 2021 20:07:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 3797b4nmq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 20:07:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYITgw3XV39eZFEyEohz4a7VAytB/aDGx+njMEVgTZ3oBTpcf6XpLd0rIbaFIzq5BjJluGfpJfXcN1NU4U5jnadO652PBeK0MvtxGC7qw9BiSBjS8EziLm/fvjvziuQeAbjzrkv1rP7i1hcyioPMMOE3+NQAzQ2EOOPFSfPzOTa3pKCF5Gv/YW9hYRsLdTxFVfdYSTSimBzMPMjAiC6MEK8/H5TRj1OWsYgOHj8vpH/CQxlqLHWqPJCi7TlYaUczYB1d8Js6cjnPZwBicU0OVM2Rj01wozbuUdEF01qVvbgDsJDrFI8qDcl5OjKy5K1e1UNThnpHmhJvYRs9D3ncWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PChbkdg5J3RiFCTsBiEJ+8N60ctHcXYYu1ZCLRHfqrc=;
 b=Ftnsipi9678Mu185cGdK3PQq3qa7VW1o/DBYouo4+RukwA4seCKeNLfQHD8L5dVgkSt7H87AQoC1rVNaZ1UQ4mOb30+hwGtVAevc4lGYOIL0HS8dErM9Atn4ngVGPCckxA5p37OUxwQzJ6E+RFquv7HFvPaluY43RyZJUtzmyyDsQYSH6cigfdo43MDDrZHfINMMOMWhkmmyj8KgtzTuqRwj2GmvOcFvXGuJXZ6R+VBr6P/BI8FqMfa2buS+FiCiG5Wu+x3lU5JRyX28hmSm3orlgEao95lxkeWETqmw+5b9vVLndl1MBxhtOoEjQFHjrIaz04Nvj5ARfJs/ihAAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PChbkdg5J3RiFCTsBiEJ+8N60ctHcXYYu1ZCLRHfqrc=;
 b=pynsjfZNeqM5f498F7G79bQYjSMRyRve5GXuNZ+4o/ACN1xyfpK9CEKoDx31Z8xX0CFp1bCW2rtVMZUDmYMEwuj9Kp46t8Pc6T5scE6GKpaaWHJ7cCn6BtxyBytBQRJ5aIJwIECg9P92qYI9yo1LbgYrwlShLrsrYrxbAlZhE0w=
Authentication-Results: bombadil.infradead.org; dkim=none (message not signed)
 header.d=none;bombadil.infradead.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by SJ0PR10MB4672.namprd10.prod.outlook.com (2603:10b6:a03:2af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 20:07:09 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 20:07:09 +0000
Date:   Fri, 19 Mar 2021 14:07:06 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Randy Dunlap <rdunlap@bombadil.infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] Trivial typo fix and sentence construction for better
 readability
Message-ID: <20210319200706.2dlq33ii33gyakyf@brm-x62-17.us.oracle.com>
References: <20210319195451.32456-1-unixbhaskar@gmail.com>
 <5ac591a4-2ed-311a-fcc2-3cc8443d71ef@bombadil.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ac591a4-2ed-311a-fcc2-3cc8443d71ef@bombadil.infradead.org>
X-Originating-IP: [129.157.69.51]
X-ClientProxiedBy: SJ0PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:332::6) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.51) by SJ0PR05CA0061.namprd05.prod.outlook.com (2603:10b6:a03:332::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Fri, 19 Mar 2021 20:07:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f25ca32e-d726-4f44-90b1-08d8eb129383
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4672:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4672F45027ACC46006D7E1C7FC689@SJ0PR10MB4672.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WboOR4skx9XZaDR+nhSoP0E5QT62XlYpfKJRQJxCmXDB8Tkzff1F/DEwjEoEgyubVQuh/1vn3FnOLCDQ1+g/ucZMImReGl8vE9C7vrFb0ZBeCKcgpvYSqL9UUMl7MQWk3LoPQWOdpSvtv6OxIAG85h4WEBr0uwTeDLNHaQYYkENL3mx/9fMui5rrX6Utcdl8f4vLPdU1VDSJKF1XZVW026nNvpzkfiNaX2ZJePVxosrsnkb2GIL3IrwMSB2bM5FTP0Yff72DT4WhjGWVN33lmN+1CZzkXTfnpA6hjunMxiqnEE5uGq27V6PsfJzYz03QX8ZH/vNap79MlrQd1gUmljW6emS5c5uUuoWkI8JyaoBL7WFAZnfihb6rfpoujuoWXvjZ0MFIacJo4q9ywqzji9FQz7GWLA0RDHflVqkUsacpeEMwa5G5WHX7VP2UgmjzYvcWxr4gBfxTCG54uR74jHfqbYx584azSv06SroXyvPeqYqtAyYbBsOEQTXPa+7PQs1r7JJiats05rfi5DtIL94HQ2+myUGy96rgVp8/sOnPvLEcTVB6OvHq/JMoq5enUNchZ7dnklao5bhpYcCKk7j9W4q3NWoc2Uk0o9KGg/eW5AeLaxrdjdgQvX/kyQI37kztsUfbja2swaXTA3v0/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(346002)(396003)(366004)(44832011)(5660300002)(8936002)(38100700001)(26005)(186003)(16526019)(66556008)(66476007)(956004)(86362001)(2906002)(66946007)(8676002)(83380400001)(6916009)(4326008)(7696005)(52116002)(316002)(478600001)(1076003)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HKsdxFsSXEoq5wJy9/oLR+DcaUfInocl6NDNewJVe+qbVZOAS9uodSC0KhX3?=
 =?us-ascii?Q?5JLARYsjYj+XgQA5wL1djmaQNBUvsL4XY1xQokv1ZyeZepl4sAclfwbbuoua?=
 =?us-ascii?Q?dkLkoZ+6abxa9/X1+d1srTjtzY9PKTOrNSufaV6wwqkftW1lXZpo8soz6ZqV?=
 =?us-ascii?Q?oVeg0fIhY3r2ZUX5nZbitd4kVatuOjNm5qlc+L8jb3Q7ZFSTmr1zy9IvRRGv?=
 =?us-ascii?Q?JDXWXvq4OJdDjU/CTIxiH4ZmemPkuwhDTk/099zGQSOYoZdR8RYKxmp8/4o7?=
 =?us-ascii?Q?iMZLUBGYGehtMG02NEffF/RNeJ+kzgG4eonOqZxUmZbxow/i0TxDF8VrJ0AC?=
 =?us-ascii?Q?WG0TDsScywNDRkhSX87fq3E4r2iEWXYd1FVBBu9ZcI0R8uukZP/Ekn8HilJo?=
 =?us-ascii?Q?U2+H5FztDwAmTQbWgy/eG0D+ne+gKk4X9B/5QT9bl07VNAATQ3QDCD2ITmoo?=
 =?us-ascii?Q?h2fQ7Jk0GvpoQkFjMw3gnJKRL4clrslVjmT8KLOKxdSUdQz7MnW08hK6xZIC?=
 =?us-ascii?Q?EMvuvyF1jSzV7X+VBhD/70aT921nrLi0pcS20yJS6geAIBSmmzi9sXc97KAb?=
 =?us-ascii?Q?EcZ871ti8a6fXBU7GhdfplsWYFaRoQi9I2kRD1bphMzeGZuIcKcgPvH/yrDp?=
 =?us-ascii?Q?0hQ0DeGBxXxZ73atzkLiC75PdZ5SrzUDBGmemlYm9HJhzShxitXBj+dFGWfl?=
 =?us-ascii?Q?8RRVc2aoRt3O/PY/95DxCqlcLnU6XmTfPlZRIW1/OM+qaOJrQs13MF5bKjvT?=
 =?us-ascii?Q?eDMqpQfAfMejcIGMd1eNs+KEHbeqxSlDgNwWMl/5uJiLaTkMWrh7WNc6greX?=
 =?us-ascii?Q?ko96PUvEOc3/aPbvxDKzxbEjVNXP4FLeTZjdUBgaj8Et3KHvgXMn7DZ56Rzj?=
 =?us-ascii?Q?F1R69oK4w6lpeRBiQjxIV0JAwFOCZp3ZJFlTtTFoL3r4foUiMJlIFkQe4ki6?=
 =?us-ascii?Q?XX3Ir4uGA4EpmJoPNa/MWYZmJAMPYoBSbotze6woQxfLrtER7yGA6tXEZ4Wh?=
 =?us-ascii?Q?swv09nnK9m0uaKB7f07GixWCvlv9KtSaZ5gxOivaMxnN4Ct3+9gkbMNIah6y?=
 =?us-ascii?Q?1ieiDiZKToWtZhQqeOrh48/D4k1ZgbQFgfwn1hPu7Mif8JtrC0bkNqW7CSbq?=
 =?us-ascii?Q?V/wh1omvK2JjzqO+bqLzIchTL1v1QA14Rp6JTt30YKhQ3Pob+Ql5Oe6/Lfjd?=
 =?us-ascii?Q?vEw1hxaOK365VBFVhEqPmbed/cgwM8pVYjLK8/92s3SpHtiLKo9QBiGD7Jiv?=
 =?us-ascii?Q?4JzySMp7GnXrGUMEw3IO+w4ZUq4lIoScYTcxZeBMjwh07tn5+Ajr4itIquT/?=
 =?us-ascii?Q?bxZAtSENnVzGgvmx9s7t3lZU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25ca32e-d726-4f44-90b1-08d8eb129383
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 20:07:09.2775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wNVhsYD+z2cCWKWrL8mxPWqtjaGj95rEvCkesQ8NPJbt3oRJ36yAsUmMZiRZdVPUBAol7DxJhOYpVbNeZXmlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4672
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190135
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1011 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190135
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 19, 2021 at 01:03:02PM -0700, Randy Dunlap wrote:
> 
> Hm, needs some spacing fixes IMO. See below.
> 
> 
> On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:
> 
> > 
> > s/funtion/functions/
> > 
> > Plus the sentence reconstructed for better readability.
> > 
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> > ---
> > Changes from V1:
> >  Randy's suggestions incorporated.
> > 
> > block/blk-mq-tag.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 9c92053e704d..c2bef283db63 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
> > }
> > 
> > /**
> > - * blk_mq_tagset_wait_completed_request - wait until all completed req's
> > - * complete funtion is run

completion function

That's my read of it.

--Tom

> > + * blk_mq_tagset_wait_completed_request - wait until all the  req's
> 
>                                                             the req's
> 
> > + *  functions completed their run
> 
> and more indentation + wording on that line above:
>  *        functions have completed their run
> 
> >  * @tagset:	Tag set to drain completed request
> >  *
> >  * Note: This function has to be run after all IO queues are shutdown
> > --
> 
> Thanks.
