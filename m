Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9638DC433C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 15:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF17619FF
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 15:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCZPpk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:45:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50144 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhCZPpg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 11:45:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QFTWXw127512;
        Fri, 26 Mar 2021 15:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=OhSSz3I9betWpGjsBrllxpLu60ITou6YCPIkahKll+w=;
 b=WfX2RqUGJx3830PYz5Ov08HXh1RDbc9If+upkvp9qkqMPZh9Zdi+eozVp98wT1SCAnef
 1OjbBJQ/3og++GWp95FTA1QDvo/KZJgrbQ9Hi01GahPK6frvNgI8OGIMVP6yjL2ORuSZ
 lM81e66Kr93MdvyB2vGy4UJjT/ZJH9rBPZZ4/3mnt35sfDF2D6VqNKamPqBrNiOhGFMA
 PR+VWl11GIdAjLP6s8nHiOw/+2HDkrm44mrSn9m58uj2DXEyPndZakZ2TUg+6yCj6QFm
 huizElxdMHpEURkuyQ2whK2iK3zL0v30jClX0gri4cRrFjeEhh3IVOnjwkbRgxmmAfVy yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37h1422hkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 15:45:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QFVBJD066306;
        Fri, 26 Mar 2021 15:45:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by userp3030.oracle.com with ESMTP id 37h13xu3fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 15:45:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idVoc7FdD6a7xa7Y7kglat9HeoeAhwot4zCcR+LDlSt6bJ0B4GNsNs1hPZRqv8Gf8xqLpniV0sszVV6OvThvg5GMf+kLUIEEk15WLp67qPGizTuLlcOnpVbmH6mbvS2QQ24ziIC9xEp7zksg1fSYqMnhe3kXrmr2aQB7hlCkTjrIrDdtcNJr5V/XxXndRNtApBvsty4te+xg0AKXm+WtWefGWSELOZefldPyk5YO5+zfnnx0lHvbkRJR//f8eTpZQiJrvemO2WN3hM7FgJCrabAMf5+80MF0IFWkkETLJmtIdFcGFtIzpAHAyeNcDsWkSEnrDLP+xB8xx1PDF7d5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhSSz3I9betWpGjsBrllxpLu60ITou6YCPIkahKll+w=;
 b=cwg1J7l6h3nDzNLoYUiplBd4w1TKyqI6rFUn9T0MmEFIjSSH9C2vjso8mTPr6TkS9g1JrsgnJNAuI/0CyHYLei5024gJV3PQujgLIqFVQ0iks4HvqkX5pXcU5ok9TGK5TniwSd3j+3BW+mXixX15sYj1+nzKXYjvXbpzlNBdrWKShQwIkpxSEZ9AsXHahXTHTW+MywOc6D9wuE3hguT8SwAPRiUIeTrP1cctOOfEsc7QD2mGZ5w2a8zo5One/ZOhr/HuXc6M2KV3G6jVCwkAH8PVBrix0s0TEMxtMR05xPXI0xSgumzY3ud0NrW2SG3A3XZ2Xa8YhA6PBGIOJsG8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhSSz3I9betWpGjsBrllxpLu60ITou6YCPIkahKll+w=;
 b=tCg+2l2kF5uma1ihqNiyyBTowj7JUnHyPcB7CRVrk4uN7nn4owFmR5xikQOeIawxEfKcidZ7JumgQmVvrV219EYbhh3b+lZVjlxud8UOpWPq/4MagfEjlY8Mbjyd/0Bslvym13aCNT69q1qEs2ogOvwOSsKRXokMOoooJk+s5io=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by SJ0PR10MB4511.namprd10.prod.outlook.com (2603:10b6:a03:2de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 26 Mar
 2021 15:45:22 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3955.031; Fri, 26 Mar 2021
 15:45:22 +0000
Date:   Fri, 26 Mar 2021 10:45:19 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH 1/1] block: fix trivial typos in comments
Message-ID: <20210326154519.y2ztm2fqirxejaht@dhcp-10-154-182-208.vpn.oracle.com>
References: <31acb3239b7ab8989db0c9951e8740050aef0205.1616727528.git.tom.saeger@oracle.com>
 <2831e351-0986-28d5-5eef-53edcf8f41c3@kernel.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2831e351-0986-28d5-5eef-53edcf8f41c3@kernel.dk>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: SJ0PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::19) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-182-208.vpn.oracle.com (70.114.130.219) by SJ0PR03CA0194.namprd03.prod.outlook.com (2603:10b6:a03:2ef::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Fri, 26 Mar 2021 15:45:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6be0129-cffd-432b-d15b-08d8f06e2a69
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4511:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4511FEE09DC0F69DE6E89C95FC619@SJ0PR10MB4511.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SI9Wz1pZOYhVdwYNbE7kEGbGy0gLyPwbDuR6qzJKNQCQGEPWyLYktyZtFfzF7g/tT2WsoG8UWsp/p525Fg/KdfHfaFWcEYdQXJrzJrjC1RoJWQmZkIZX/1G22Y1eaRT4k0ulUtY5Nx7gwDG76iVbFlNXBps7ujeu47q61VwpWsgp5uPo/crZmuCqAh+vW+3ZCxdTS3KUx8XZcLovpiDYiXJj9OiK9cM/81e3mIrFGRc7kKwGsA7EwmIf1/emscBPHaDD3eIAKX1CRegRP2Dum/F2BbdNQkxPYCAW881OBnGYi104ry83wkBzylJD7C1SG6iyHDaQlFapM36jKnVPsCdSX5ohNUAEx0schJhIuiCueBYOv6u03viKIN4Z4SKT3AwzVvc741Fkg+WftjeDjmGXa9F3CjPZ/vfU32pvxKgCLeRGk6DjyJo/kHsU0g/HMkzEHhw9u/MivHADKOw2ciXVShqqquTMyKW1mgarHdcs8MRFtMqJftHhZRSvidhA8OSHImUHF5dMOshlpH0wf1FQtDw2gwWnbYKsFB9AjjYicybawpeeLpmEIaqRNAnrjshADw45ulz4AkYbd5FMce7DZ8ih8cID9BP+WUu3c3x6OiPvKcMUuqDUb35gXWf/9+Kd4scW3OOC6s3VNWy9H+giO7ZWKqRLjw3FPg6I/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(39860400002)(346002)(376002)(55016002)(4326008)(83380400001)(16526019)(186003)(44832011)(4744005)(53546011)(52116002)(7696005)(5660300002)(478600001)(26005)(956004)(316002)(66946007)(6916009)(66556008)(1076003)(86362001)(38100700001)(2906002)(66476007)(8936002)(8676002)(102196002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PTj45toyXpo4OZEe+L4LFpd6cP+5w27S4PtyB0uUHhMKkyJiC7O1ZsuKCX85?=
 =?us-ascii?Q?LrmB5KOrGuApQ2MUxiRT38G1X8mp4A0itxn+aU7a0rn+6UfVXUNfy5E2c7H0?=
 =?us-ascii?Q?mrmJybaxP4vmi5LHp9bxJiYUS1GEpi64eN1MPO2yKMzHyzNuRj3blPblNMf7?=
 =?us-ascii?Q?A9wx2KL6tEv1O3FPddP5it3iXgmQN7e22CLzW36Xqrqz2sviOU5Be2jT1hn6?=
 =?us-ascii?Q?TXfVCU9b4xMv5hLRZxOHrOO585pjbAdtZ2rBBQ8WQouST51+qPdnhruYZob0?=
 =?us-ascii?Q?fPzmUcWmlHi3apRg18pwN/xCROx0BlPAyDag8Q4EoUYLy6FpjB+fEk96Fay4?=
 =?us-ascii?Q?Z06Y5bzEz9nca9/eXtDIp/TESL+/+mUYmrkqeq/rTun6gbb8ekAFOaG2ka2+?=
 =?us-ascii?Q?GepDWP+0ob0s6vkoIt7rucjBAgFPS5sRjkI/n09ZnHb+AndydQkxQuio8WwU?=
 =?us-ascii?Q?9OiKW3mg+8TLAuMNqYP4emnSxqP8+fMCyKfR8/pPJQREjwRGAN18fSe+i/Xn?=
 =?us-ascii?Q?GApQ9/voIGWpUfLvfm76kZTNfL+ZAoNm+sJQfvfgtRgJSf9PrXnfffr7HQN/?=
 =?us-ascii?Q?ni2mQ19TVFGVJts7ft6AytWN3dW4PdZ+kCLdJANPd4eYORbf2jn2A+OV34jn?=
 =?us-ascii?Q?3Zz9M3nJyHbRrXgDXXoQwjEk2BbgAPQHJDh0amjsCTkicH5IJleyYwn3e4eF?=
 =?us-ascii?Q?fAbWnC82cdqk2KEMKb+gPOL0rdt2e+MG5SHPRrKo0XWegv/ZIX+3C/td+3bz?=
 =?us-ascii?Q?wOn1Lt1phRCASfJbp4sXeLElzX6Fsi8eF7nHJiEVd8BAu1jyglkVj9MAEaMW?=
 =?us-ascii?Q?9YEv2PpuhYVX8r43yf7Jk0k07t0bqJiAfDlYdnX3RqzJShIVao+D5d7/Mqq+?=
 =?us-ascii?Q?Zat7ElHxsxvFXitx3C1y+kPQOqNl4twlWm886k4o5oUKzvnXV0vHQhzIdX8H?=
 =?us-ascii?Q?qGRE+wi7bqDv2IwTtSatjVLk8Cpk60K9eACOsT31T5oSRXpswEsR/3WkWkXK?=
 =?us-ascii?Q?l0nZyqhee6omkLENi1845FROkR74OT+hFnbMk4lkj9IfIXnkyh0663qsF9Vw?=
 =?us-ascii?Q?RVvNagd6bj6SBnkX0Go+JYw4TqEXhzJ7cn4RiV6uhzK5aYFJt3b34AMJeLkp?=
 =?us-ascii?Q?NjSDwJa9itCZIWlnnwzTekUi7vndR95DFoDFh3w1h5IamVkr7qTqb6x/t7vS?=
 =?us-ascii?Q?/iXVtR378CD+m+wXtZFOe2k7ysuY55bruYcZLzgmDuLRPUMg9EeAL9dsNVRd?=
 =?us-ascii?Q?y/zt+LoR5/Y3zcLE3VRKHfvGKA4mfeFmPqhLs8l0VBVMYJz8s37pJU/6kJr6?=
 =?us-ascii?Q?h2y/vG5PqrRCpzndWNei8Fb6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6be0129-cffd-432b-d15b-08d8f06e2a69
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 15:45:22.3061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgnseulsfltGjWrG5tG3RsHB5Yk26h5AVAR2xnAh+lUD57gx5lDkx90wuApO79u0qkTUhh38eU6xV0iTG34D0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4511
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260117
X-Proofpoint-GUID: ZTKWpit6Jc1VK_Fw3Q-rBIychaWGdHKD
X-Proofpoint-ORIG-GUID: ZTKWpit6Jc1VK_Fw3Q-rBIychaWGdHKD
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260117
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 26, 2021 at 09:41:49AM -0600, Jens Axboe wrote:
> On 3/25/21 9:04 PM, Tom Saeger wrote:
> > 
> > s/Additonal/Additional/
> > s/assocaited/associated/
> > s/assocaited/associated/
> > s/assocating/associating/
> > s/becasue/because/
> > s/configred/configured/
> > s/deactive/deactivate/
> > s/followings/following/
> > s/funtion/function/
> > s/heirarchy/hierarchy/
> > s/intiailized/initialized/
> > s/prefered/preferred/
> > s/readded/read/
> > s/Secion/Section/
> > s/soley/solely/
> 
> While I'm generally happy to accept any patch that makes sense, the
> recent influx of speling fixes have me less than excited. They just
> add complications to backports and stable patches, for example, and
> I'd prefer not to take them for that reason alone.

Nod.

In that case - perhaps adding these entries to scripts/spelling.txt
would at least catch some going forward?

I can send that.

> 
> -- 
> Jens Axboe
> 
