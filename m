Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153B2C433B4
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 01:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D775E60FE9
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 01:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhDABzw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:55:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43740 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhDABzb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 21:55:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1311sfFs116544;
        Thu, 1 Apr 2021 01:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=3iT6/XGXvDPCLBxhdNPC6U+bkv/WN7kdmSevgKDp+nc=;
 b=lRkLTmR6bkAM7RNpYjQhXr2d93HTloiWMrhJ+KxpBlK4aszltuU8h64Gn+1HRJrzM40b
 +EIOhF7BPM/dA68nQRoSw4EiG6KCwdShMQ3G6SAsZyc584JvuHU10tDZqBJnKJyeJw49
 equJmTZqimv4IwiPkd4LcBtFY5cMVBDBv0RsPZu9FV1btPURuvdmZH2dRZrfqX3lJjr7
 IU75QA+RlD3tXf4sW1GzPWfRndF9WWV9Pg3yUWLEuFDxbUnVWAsKzZqr/bR9OnKubCdd
 t3+CiaZPwWZJPV/mhmy5G5PYlaVc2zXqqgjd9ApZ+MXujVV/IW3eHaKC7T8O2uIUznGv Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37n33dr4xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 01:55:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1311pYQQ016019;
        Thu, 1 Apr 2021 01:55:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3030.oracle.com with ESMTP id 37n2as3xmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 01:55:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuJnsrGXbhZcXBeEuuv5Tz/I7azHtq/ROz/YSCJ6ELwUvMxllBLdNyv21f5vEHQ8KsPS5+kBLvQE1aW7IlMCBZD0HV7PeYUyLV7FqnwvUKrApUxWqjnVzEGu5Bfbl1OHAw/hFMOm+pw8WAXTv26nEfepz6mEWnYyYVM/HHOw5zpBhr0dUic7AqXfCIYunGy5MwCMjoy0dCWWPIkO3m9uuz821hQX9ptPLOUsh2kDd7RZwm1irjYzYweXRRPmjDhMmz/G57dBQKCJtkIe+13XfHFX0D3RTxdK5ZdeTN0odIWVGjNrCtz7jdHN6R4DOWYRrV9Xn7afDDI6Mjw3jZqyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iT6/XGXvDPCLBxhdNPC6U+bkv/WN7kdmSevgKDp+nc=;
 b=JUF1rW6Z/61G6jrOxPA7D+OzCqnY1d3CUxXdYceX/IPbjI9wOb3bsaskxcItKgvxS65pXCtHvvh0MT4lKM9zLDXKr7qBLb6MzTEKDs09GUnieaVI6ogalKwjuNLE0r2kGVg09ek3nRXZu52k+l8fRCKnV4xDr2TPY/+7eAsqL2s5HNRnX3zoTh7I3e3x/RyhXp6CURcZfMsYUfuGvyg150YS2VZMJzF3kJ+1RXj9gnQIvTxshMAq401ZrB28Azc0SraUsRwARaQHFuwmmQYvotQ1U814FYn5OjyVRn0lc/z3J0PqTboAMkDt4e2s1IVlzulNiTdnkN4KSifap2xFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iT6/XGXvDPCLBxhdNPC6U+bkv/WN7kdmSevgKDp+nc=;
 b=ykO56CiXp2xjpk9JA8dpRi3UsS78Jp+5C0UdTR62KT9IAKsAZ0XtGT2u/RyYDN5aPHX6wpcIK9PIF9W/W5RjCBuQ+PQ02bbTc15/fvzKbT0a6DJm7VpZ4k835gAtSNsZ0wJvAxj089Ur23GKOaz1FbvGfDoytdkImj1ZLAh7kCw=
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4630.namprd10.prod.outlook.com (2603:10b6:510:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 1 Apr
 2021 01:55:18 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 01:55:18 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 0/3] blk-mq: Fix a race between iterating over
 requests and freeing requests
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y2e2g45r.fsf@ca-mkp.ca.oracle.com>
References: <20210329020028.18241-1-bvanassche@acm.org>
Date:   Wed, 31 Mar 2021 21:55:15 -0400
In-Reply-To: <20210329020028.18241-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Sun, 28 Mar 2021 19:00:25 -0700")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: SN4PR0201CA0045.namprd02.prod.outlook.com
 (2603:10b6:803:2e::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SN4PR0201CA0045.namprd02.prod.outlook.com (2603:10b6:803:2e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Thu, 1 Apr 2021 01:55:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23cd7e36-8305-4c9e-3356-08d8f4b13383
X-MS-TrafficTypeDiagnostic: PH0PR10MB4630:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4630E3A58E9596C06B78DC818E7B9@PH0PR10MB4630.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWwe+an3UXCCZ9t7vXxRMYON5uWpDHoiSoOz8jpVZjTPN/A+vzntyZ09S67GJdkTvrCT/f9GkOoL5Dd+waO+awzxCRFD10kLZaT+WSRWQ4VyM1V9LgykKIxRy8ivT+rLm3RnfBmRNQQYpe9a92hVqxGCfJaaP1+MFz+EllEFQUj0xqjOQn5/l31WVb5Ll5TVMqETsPFizJ/ZcvA+3yX2hBy3uSsb+6XwQwIrq96oYRoEPEul+HkM5Nu6vJxv3BmXkmN+G6/LcnT1JiPKAGT80EQ+0PYqWOfHLe0HhQ17SQSse5kJR05RqRmVZFME29uN4jwLsPdRjkWAu88tF1ZJf2edS36z7lQ59toAdKVPRAqfQcDIyIS4KLEwq+ZMFO0Q5H5IZQIV01dltXIkczotxkp7YE9YRvyMD9aW4udCl9wE6I8KUI9J/H9q0RvGw4bMts4niO3a1nwCblG9PzncdX7v/VAq9xoNIeOlzGFGamw4QHldXacphWVa3MGbq9mAgsFPy1bMmY8XP8jLwoflRuq1HhS75nmun1htfw1Chz2wgv6rzfLyZVn5gIXkzSFD6BDmLmL4m0sFne5sq8uQyDisypLbN1gsZ2pk4FEkaKiYY35RWzSLx5n+tuP27b5eeZTUxjss0QXRuZq+baOgkgx8WuxPsqyMRczK9NxdQTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(346002)(376002)(396003)(4744005)(83380400001)(8676002)(316002)(66556008)(54906003)(7696005)(2906002)(8936002)(26005)(66476007)(52116002)(5660300002)(478600001)(38100700001)(66946007)(186003)(4326008)(36916002)(956004)(16526019)(86362001)(55016002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?C1BnY2JzaaZBMADrENURewg9JrKwaxy89na3+h7EpbmjvvyG8MRPttzECKsA?=
 =?us-ascii?Q?VB/1WotgQKr8ALg0kIosKCsAJrPGi41WWImb4HDWGtPW3VMy8qnHZNyPj9e0?=
 =?us-ascii?Q?Y4Ye7mBf0YBa8uC+9nazyZgKBoth4Wmpla9xtFnOtnDCCg8f3RrdVN7h61I3?=
 =?us-ascii?Q?Ck5sC83xgcbfRGsjSYZhw4b4PJkbEZ+Tva8EGBCW106UbW2YEuaoNpa5jsJJ?=
 =?us-ascii?Q?AskqcQcdE+iwPfPmH+456H6HkI/LnMY3ONDNKtOQtgmbEaacGOBGsasXSB+s?=
 =?us-ascii?Q?t8Jp5sVaFzbpiMoHguQ9rFaAxbGqyxBibkzIr4O8HsL2RU5G4U5QwodxVDmJ?=
 =?us-ascii?Q?pg1A3wFEWKgPo5EOTi6NPaocZINbUz2twButtxbtA51t+9nRdtagP8J1g2rK?=
 =?us-ascii?Q?0yhzJDTlqQC6UHYSczOuSiMZGzteNWeV//IFQw4Widk4PVOi5OIjlct63eqh?=
 =?us-ascii?Q?gFn4ZlsqhBnX45PbW0oJU8pFZ02MkZ4O2Sm9ErLpaBMN7IlYJScfV1e7Gdsi?=
 =?us-ascii?Q?fRAscxvme8Y7LSQNYr08ebe3Gmj7lRGQE5Bxe1F3razySHENV/DYNBm8a8kX?=
 =?us-ascii?Q?jQezH52zy3u118U7yNsGm5NLMN0sbcRGLPH4y1xfEgL+zSM711YDmeVA2NAi?=
 =?us-ascii?Q?iI6aWJi5G4vb+0ryJAklG0bhWnyCkSKeuxPq1PPbDkU10/++MwbwiEa9h+gY?=
 =?us-ascii?Q?KU7+IYxyuplW12S3zP6soC6F0fOYpjatAlTPWWxa+5IXovyTe9UWWrszbTRE?=
 =?us-ascii?Q?pBOEdXOHFYqQA/UIPc/w8sJVX54nPM/xc7qIZH6ZwedJPa+3cj4YVF2K1l6H?=
 =?us-ascii?Q?vPYvzoFuBpeyOtCfRSWWxNttnow0ZZeUigXfPK6XJ/BuWn1RWsMrRQdeuUCp?=
 =?us-ascii?Q?Hlrhm0jzaGmchGwIKHazDhXAp8EEddTH5lYeDEx+NDijQpN3bjudvOBTnZaR?=
 =?us-ascii?Q?xVzRBYYhLj4V6KY/nSg1MiWXif98wgzdUQR6zfIKprSY8ijTgn4VH8ec4548?=
 =?us-ascii?Q?bfF1rAn/Wsiih0GQgEeLzIvoLlGRzVciTuyLbSDxoGbJ+yZVnNHZ3SKom7y4?=
 =?us-ascii?Q?WnZtHt/J+qfSS6U/TbO6rf5MHPqf2gZ76iTxqSoZzQAzYa3AR4kVmaGF3b8R?=
 =?us-ascii?Q?P77AvgwJytquHJk127uNgEbOxyWG7wspne/dcDyoKUkgG+89egmm0x+nYJu4?=
 =?us-ascii?Q?PXHmYrE1a/NJkUdzM/9kP8P3rJMDW+0eTb70DXpeXdXbr/D6A4aBhUVR25J9?=
 =?us-ascii?Q?NPDNG8FNhABk6tvZP23M99398bXhPrO788Gsthid5kz7yr8j81gepcIFSy4W?=
 =?us-ascii?Q?NoChudrjafHu2vHIYTLAZCju?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cd7e36-8305-4c9e-3356-08d8f4b13383
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 01:55:18.4635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySS8xmG3P1lQ0fwELDUlQRiD3ium0hJiNtXrtm/QQndWUecP9RuxNbUp8Piv4qZzR+WB3ipaL8i3g5nPkyoNhRtZuJPDNqMs2RXdVmMDbFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4630
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010009
X-Proofpoint-GUID: HGFkhjAp_omovuM9nN3UcnUrFSw0RcGc
X-Proofpoint-ORIG-GUID: HGFkhjAp_omovuM9nN3UcnUrFSw0RcGc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010010
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Bart,

> This patch series fixes the race between iterating over requests and
> freeing requests that has been reported by multiple different users
> over the past two years. Please consider this patch series for kernel
> v5.13.

No objections from me.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
