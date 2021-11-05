Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C94C433EF
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 09:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CE76124D
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 09:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhKEJVJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:21:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19508 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhKEJVI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Nov 2021 05:21:08 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A58aGco007554;
        Fri, 5 Nov 2021 09:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=J1+zS6yHEaVcLEOtdmZzI9mpSIf0GTeG7WgFt279Sqo=;
 b=zLuDm1fjBJju7LuuKAnXGGoyfL2wFVjY/RbXV/vHawOx2uksDrTPNfL6WM81fsBecAVP
 lu3d7CbsvEjcoNmha5tnoCyIP+mx8y4NToI/a1nEUGu+xyUukGTFL2Squ89cM92Nr3/n
 cE4FGHEZfODTNtP9eBmSSGvrtzLFEnPy5IDzCzA76hAWAXIm9q6Rvw57N9RIqKd5hXQ/
 zYHticqtFF+367xmt0X7RTkAbuV9uTv2SPVZrIrlYWiMTjGRwb9TEQ9HqDoC6WnPAaKI
 W1Sxhh/j4BJPYunwwAc4xjZsq5FTmyKCeSR5xqEg9QcW8JaogfCDYQn1hlmupiBuKN/H uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c4t7bsjb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 09:18:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A59C3L0041857;
        Fri, 5 Nov 2021 09:18:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3c4t5s62ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 09:18:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/ztbU7XDSPw4P5K5oLa7FvFgBXtT10fe56Z4m1Wyzf7/bhQuavUXQ93xRJDdA4pSawHVhAYrW3GV+SoGDIJRe2wt3jto5lhpZQDBxedoPo0c58ftiR+8dg7KPeu176xPXTOTbwTfn4wEBpZxSvZn0KMFqsaBpc75RHmdVoDdqThdC33obn9xDgxfgnCZz2V+ddK7SLyz7OVtEWuhDIAIozk9+IIb1HjQs0o+fZOerVpGQJeE6qGCzAx0e8TDzMfhf2k9WgLEVqZOH799nLE7c28J6uHmvXN2fHHGNoksBg21djf4h09FUDsFh1JA3L6HXNpBBEnYpdy1oNnhs1iKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1+zS6yHEaVcLEOtdmZzI9mpSIf0GTeG7WgFt279Sqo=;
 b=OKP3pxweL7mL4MT+ynILRLlfKIW3H/I5nEx4aJM9eDMABmjqneiSVVAWfB/t65yy1jv+u6y1yhiWZ0i7hhvv76fNouvW0o7l/3r6BjNzjmHb1H/j9Iz2CTOfvWCRBsAxa+rNbi1XA4hQU91mw4ydqpK7g7DcxwVWloEk12KYybEZGSwsM+o4elEvpHR2o888DEc/xnBZ+Ta2x1qG9Kw9QgNACEyM177vJJz1bRrkcI7uY9f/ujq5BCxBCNpuOs6CYgT3NugL5ANk76V5Uv6AIrTKIFUbDAHSkaq05nSVTvqLLy5IE6e4D67aIBAc7Ez9TwiyCBUs72aW2LfJYhJYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1+zS6yHEaVcLEOtdmZzI9mpSIf0GTeG7WgFt279Sqo=;
 b=F2xFsSKt/h2AiJHPFp1AOGHvX6QZbeyl7+VSGKrOeettKGdp0anpWGhy78i2HRGMi6qxi4D+0kcehOvxvPvjWf4jCcAK9g8P17KtW1FS0d0GCx7Gcl7uiDJ8IfAOQopO4GHP4UvB/VMDcJR0N49FWZL2+Afw8oEj34WDx8TpT7c=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 09:18:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 09:18:24 +0000
Date:   Fri, 5 Nov 2021 12:18:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-block@vger.kernel.org
Subject: Re: [bug report] zram: avoid race between zram_remove and
 disksize_store
Message-ID: <20211105091638.GA2026@kadam>
References: <20211104114830.GA4962@kili>
 <YYR5fmwmfvfQzWuZ@T590>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYR5fmwmfvfQzWuZ@T590>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM6P193CA0079.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by AM6P193CA0079.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 09:18:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa4b0314-aeec-43fa-60f8-08d9a03d37f1
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4705BB6FE18D539FA3116DC48E8E9@CO1PR10MB4705.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TiZX59wonYWKruaOdbzC+OkxuNWhi81YjToRWZkGLKPfL6D1uvcs3utT6cqhnGIfEXEmQ+ILL7KrNgM9cCYZnSroVfi3qntINxq9g+39y/KFm5RNuiTxrPVW5mNWhqwKOnZhvxuQCSiBbbE2mcW93QqRvFnntHZk4c5DAB8xau4y6tMb5MQkDpBpjzIGS2yzytKZXUxtg4bkXmovFQh7utgKggCcrNBshE4bgeGLThpOyBudzbpFw7WUEId/GxArqP6OW4/i7qPIG7dFllpJa8X/2u1MG0OeQ9ZZpGuNGYoTqhypVifzgk0lB9L8X008qpe4R6Tgu64uN0jc1syvy1h/JctlhtxmvJ++mbTbWnhCdnWQ/GhaBo5AB7iUu8GCavkiuSs+6XHqLrcEHGIKTq2zCSKo642u8lbXiBirwH4cNzxricI7E2fwTgpLiwjBBGyQb2kLS2Lvv0+++rr9w7sVR7B+1E70mKA/R1hISuA0sFGjHCzNh3GoS6c9y5h1YF7cM+6KpFNqmc7ymEdG98nj0NiPicAOz0zZin5pbly1onJX3aRxMqKaqZLFgXFvQWMFGp+/TQbTyLDk7GpsTZOgun0gdU9Rjg96RXrkBwUIVMbG9mJwOFRh2O+ReQknFwr2MoqHu9cvlt1RyNn6lZgroyH/mdUDDxGemQS+2jjfJamqQO/T0sav5Ng29lbS6WROb8rSULCDfcb6PjnhoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(55016002)(9686003)(33656002)(8676002)(956004)(66556008)(316002)(38100700002)(66476007)(6666004)(38350700002)(83380400001)(508600001)(6916009)(4326008)(2906002)(8936002)(52116002)(4744005)(33716001)(9576002)(6496006)(26005)(86362001)(44832011)(5660300002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gehip7YpOB1GjQ2UlkixUFKmOWZ5ZMcm/GAEV5UXrsU8Md7jILQDZyC5Ppu2?=
 =?us-ascii?Q?rNJDMjNrZ8bhKGmWev8MjXwtl2ltmm99kRULiZq+iscH6/6UXAqKWelHCs1a?=
 =?us-ascii?Q?Yr8jNxKx8Pnc9bmksJreNzpl9Pm7NnFE/IkwFlpLEQDblN9zK4UKKCYQ85S6?=
 =?us-ascii?Q?SL9FColHlF+UJTO3crYnMz2Kcr0jVj8vHlZhtyPbL8JZlF1jE6tZD2AhX1nw?=
 =?us-ascii?Q?Pv7NH6epj33VhZkLLD30OVblfnlru/ek86wawB8iAm9UIPYiaNrgBlVMQZwe?=
 =?us-ascii?Q?er27qWCYZ/7n+hPlRiJAp4mVa0Rhd9kZp5KP03+3DjVrHwPDAGPaCMBuZPKu?=
 =?us-ascii?Q?GtFlmpJ9EkyO7NvUPXXCypOBmWnieZb2gWjRSU3xvJYvTm/S9XoMEkQOktnB?=
 =?us-ascii?Q?PrVjpijrqpKBDVl9+qw9gkSvrtUl30iF/Q6VeZIW9BSoA1iYqW2kCt6+YQ8v?=
 =?us-ascii?Q?k1MYQ23d/NUSujYrQ1NxoewvXw9Jb7Y8hcRlZROmhlABq+ydu88RnDAc1WoW?=
 =?us-ascii?Q?I06QLi3f3XxokCu1HSByOvuMzzGk8r/0gqa3SlT11mUet1EDjjujbZcrnPcg?=
 =?us-ascii?Q?cyEI+faSn7V++HMxa+NKAgRmOsP/1xpDfqK7PpTj3m3j3fD23/XMrqkaonX+?=
 =?us-ascii?Q?V+3T4l8U8VaaFS+ncUOWOcPwndnDpqtX81ZNUiafV4II8133jFr1UTC+TSYn?=
 =?us-ascii?Q?2M5wjL53PO9oHIIm5PWuSD8fcPNqycQEJAWXoHafCb3hQwajaFthfkXOd0JX?=
 =?us-ascii?Q?v80GhqBeWqgyQa4fAf30cyRxt5H9yPBgkwZ02/knftI5K9X4ZrDqtsUVETPl?=
 =?us-ascii?Q?uwCe+bk2fRvx5gb+hxyjrxaP3/rkkhSzMz+fZQ0RUjFTfpwK6um5OaXxw/qx?=
 =?us-ascii?Q?FTeA6zOJpG5FyEy8DoQyMUEPRhboda2NczcHQuR1sd7EojLymlZI9A2q/lVe?=
 =?us-ascii?Q?8GYsY/hAtlItZ3GuhixdvFPpJnDxS3XR+cRBZJpr5r4nnyiUXQjdbU403EgN?=
 =?us-ascii?Q?HzKlUOB8FlIwM6Sr9OTtucvirWAUNZu+gL/wSdzf5eXX6DQnuMjlOsInI2gs?=
 =?us-ascii?Q?0/0OnfCfq/n/zVL8KubysrIIDNtd3QK+sgzhYJtfzVH5N4w40wrH2Wdh2fR1?=
 =?us-ascii?Q?7S48sL8xPCzuIcs5WxcS1SywWtAtD3BlZYxqBjFFKlAdmcrzeoTx/GQyN5Zb?=
 =?us-ascii?Q?YYe1YLFLdH7T4DeJ3OpWQ8DmOaztLlLenTTXKF2asdu7YOi0/Xt/UOHJ5JOH?=
 =?us-ascii?Q?oEOtO9JXW9+9nCl4nIqsa+M2nZgk3R2nYfmI8f22pMOP3cBYUanBnOcVBzP+?=
 =?us-ascii?Q?Gczc/BKqp7tf0Vr2OD8NkfcXq75M8EDxlGTOFWcUpox+QrC8Ln2/Ebc//Z/b?=
 =?us-ascii?Q?gJrL6l/tyNHG5QtuykrnlU5qbVvDCraFyILhCacIl71mmNaZSOJe7WWiRFUz?=
 =?us-ascii?Q?pAmf/Bd6RQeJ6uG0p3LPebe8EaGXXrlKjprG/jWJkloAIC+o4icHkcnwW/fy?=
 =?us-ascii?Q?xXhucJDUcwpvA+K6TNKHSoZQ/jPz/picTgmnzjUXODlKoHyWEsn/spVN1Yvz?=
 =?us-ascii?Q?qBE5BfZOoHy3B4AHWoHcFZrPMUeCZ/FMBpOLHgYbSC7A6Am2dhcifyW8jVOk?=
 =?us-ascii?Q?JN4QPxkzbJS/1Eg3NnljuBZ3uZfZ167j1Brx1EEOCw4Cm+wunm3eGWS6xQ6a?=
 =?us-ascii?Q?5rIAOFVuzmCIhfRy89zgUsJn8t0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4b0314-aeec-43fa-60f8-08d9a03d37f1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 09:18:24.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wtqWYdnzRklrrEbCmFmHWPqxFgcEfxydxvNLg0Pji4KBgCLYbg4DmUk4mbMJSwDxj8FJ4uZbdfNzPHdYBKVc1h3WY8nTKN8rRnX/owHZVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4705
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10158 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050054
X-Proofpoint-GUID: io48wJT3ojAvg0qZWnvvTiab09NHrfJK
X-Proofpoint-ORIG-GUID: io48wJT3ojAvg0qZWnvvTiab09NHrfJK
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 05, 2021 at 08:23:26AM +0800, Ming Lei wrote:
> > --> 2044         zram_reset_device(zram);
> > 
> > This double frees it.
> 
> No.
> 
> Inside zram_reset_device(), if init_done()(zram->disksize) is zero, zram_reset_device()
> returns immediately, otherwise zram->disksize is cleared and zram_meta_free()
> is run in zram_reset_device(). Meantime zram->init_lock protects the
> reset and disksize_store().
> 
> The 2nd zram_reset_device() can only reset device if disksize_store() sets new
> zram->disksize and allocates new meta after the 1st zram_reset_device().
> 
> Seems smatch static checker need to be improved to cover this case?

Yep.  It's a bug in Smatch.  It's supposed to parse this correctly.

I will investigate.  Thanks!

regards,
dan carpenter

