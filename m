Return-Path: <SRS0=/Scz=CT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D99C43461
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 13:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8309120C09
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 13:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BY7O5o2F";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YqZCboOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgIJNQw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Sep 2020 09:16:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35026 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730269AbgIJNNf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Sep 2020 09:13:35 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AD5oox011180;
        Thu, 10 Sep 2020 06:13:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=arZKiGVK0P5u1Y2Y9gstcQzcM2O9oAVY89TZcYaeJa8=;
 b=BY7O5o2FoKqWVAHBCdKLyCA4C27LsZhFZzfGXzqPh7o6/0MVwHS0ZNfmQgCkIGPmrvL+
 d40Rythkdck94TErytXwuZSPhlyNqG2h054koHOEi/5PNEhBXft1edX8V5dOO5btTC67
 Fz7WckCK818TpQEIoyBmhWlMFMcJBpn8s/I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33f8bfb1xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Sep 2020 06:13:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 06:13:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvvXcW911EKZdB2YZwIfW3E0BWC3mTidSz/gbEcSidgmh58wENdxM6ULgGG0FqhNsh3uPZH6ayar9kElB/a/gZxGpbpE2dVUjuDn8tTjJR1DGDRkts9jjbKMIO8BBxJ3Ha98eotsltNz/NEPFT5cvmyM5/W270G9Ca6MfVqzKTueNaQDc4Bioh018O4QVAfoixixgz/znqiWQ/BfNaDtZwtLlqx4mZywRHAQXPAK0Xa/hEJaD03Xn1GEI74NXe5K41xx6VBt3gTbJcoFBkdAEtFPPPDukzDJfCQZtxpi5/YTKX10S6SDfV+iXOAKfoW+lsBZVr1VWLRQmQuQzq+AjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arZKiGVK0P5u1Y2Y9gstcQzcM2O9oAVY89TZcYaeJa8=;
 b=iNOacRpRzfV1xMHTluYcrEPXcDvgVa017NiWaJl7g0Kzpiz502pLDY3eCq8NSnyUfi6CCOQM0mcymfCMHa3kNib5koebmbNQ4SPwObND4C6WyKIz573dxuff8M/5Zf4Ke6JVKwF1CwZLpS1XS2xS8nAWQqBA9nRqUQiYq5pUHs1wAbsV4Kc91EWRU/+gvjICMNsD2kyUAhe7Tzf6Brubmb2Mzn0sAbSIn0TEsp9Nj2D3kimjm2YkessNs+nCdRguxExoILUUag3Jn4bvfU07vgw/UKzRixugD3SSDHh21GiB7br+1q36Jl8YDYWye112tTnfU9HtbWT4+M186qkcjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arZKiGVK0P5u1Y2Y9gstcQzcM2O9oAVY89TZcYaeJa8=;
 b=YqZCboOmZfOzGNRJ3oXs+i8Zu2VeyFJmbdEVkW0stC9ryVTkHzkssxS/I0/3aaCAmO1kGBOEHg0NbZ0DLlgJaqoAwTNW8933sDFebG1aubDW8SNYQtBdKeu+j7iChIzxaESb4RbqTDCkMZX20il6VO0CSUxVjPr1rNcp8y2hAr8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24)
 by BY5PR15MB3620.namprd15.prod.outlook.com (2603:10b6:a03:1f8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 10 Sep
 2020 13:13:00 +0000
Received: from BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::80ff:5c88:e972:a2b3]) by BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::80ff:5c88:e972:a2b3%3]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 13:13:00 +0000
Subject: Re: [GIT PULL] nvme fixes for 5.9
To:     Christoph Hellwig <hch@infradead.org>
CC:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
References: <20200910100134.GA613851@infradead.org>
From:   Jens Axboe <axboe@fb.com>
Message-ID: <0ed4c3b6-91bf-9eae-6bee-6f5c24e5248c@fb.com>
Date:   Thu, 10 Sep 2020 07:12:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200910100134.GA613851@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:610:57::19) To BYAPR15MB2566.namprd15.prod.outlook.com
 (2603:10b6:a03:150::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.10] (65.144.74.34) by CH2PR12CA0009.namprd12.prod.outlook.com (2603:10b6:610:57::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:12:59 +0000
X-Originating-IP: [65.144.74.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7d14d00-df21-41b1-d4dd-08d8558b3e0c
X-MS-TrafficTypeDiagnostic: BY5PR15MB3620:
X-Microsoft-Antispam-PRVS: <BY5PR15MB362083D3ADD8270FB1C93C2CC0270@BY5PR15MB3620.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQtA/Gux5Rq11hcJtk1iwt5O0MEVIum5PubXAlx/iXj8CD22omzAUDjJQuqIV5A3b8ht+YhYNxyLYfOFVDqOVzG5BR/JpO1Bph+1W9a5R5fJWldBlxRz7kAcu/MsPpmpw12ojegkAtvCoF9g+LiqDMBbYcLZxu5+kyHleoXe25Fovg6s88XXsjBIJmGSKEkdCDwDAdai+MS+7Wk1RaSosuoHEU+HIKLS0dTrbC/xJh8mfI7mQyZlkF51Xcln1YSYdwl93ySvQxnTvczDS8s+dUzBUgYMLclgRzL76Tr6wuZH9o+dwUs8FrE19BYhD+/REITkKDfwh4JUW2TV1XUWwC82l8WiWv/ZEX+c2w7MiDIBXVHJBJrK501UtmEo2vwp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2566.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(6916009)(16576012)(6486002)(956004)(31686004)(26005)(2906002)(83380400001)(186003)(54906003)(2616005)(52116002)(5660300002)(36756003)(4744005)(478600001)(4326008)(86362001)(31696002)(8676002)(66476007)(66556008)(316002)(53546011)(8936002)(66946007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 9+5/JOHFmzHLa71wulcaB37PxkoxYbk2HJSzvW0Y+474otVab1Iw4F4/iCMnjs0uRsH6Q+ipQtTycmfCZk5iOfT9c7k10X7Qi7L1yd5eVljUk9Tt9QQZWk4gWiLMvp3jNYOFKTv4UU57jLpeEr9d2yohVKiwlC+s4jQdar+8BJ64mF0KQZADHUfbu87daIW8CJJQ+7LHxN335O3ryex1uTn67u3spfDxEHiYOAmyITRa6J/gG2P+iCXCUQAhqVh/Emzz0t98ZiFkabZYCK4sJqciHNkd8i/H1dM4VVXWbyENBWZbWvJJ1bFClrJAwcbIqxEcCPLILz6Mp7KS+AThgK8HsOF90y99Rb3BKVUIJvJKuhXbVfJ0cj/H724tWms9EkcAhl/Wb07KrPkK4QY1LcKy0DTuPn41Fq1Tj6d+i31kWOPCWoWQhKBsGaG4g6HQm/jqxbqrgZNzQ3DR5Q4/vJ+HnhySTw3754PVlbrE0jee9pRSmuEAXiUuL0ms6WFCAVQ+OewLtpkIHVQmgEIBITvwP7ZRuC9ns24/b5burupuqiyyVQg3QC6GYPMEzptCbd2Tzz8l+pcxrKbPLnev87417yG4HUEME/00pGWg/iSfhE7zVIWWLAnu22/N+5GNXa5r7jST3VjMN6y3v4AAPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d14d00-df21-41b1-d4dd-08d8558b3e0c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2566.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:13:00.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJuhbd14sFsXhFI2jLFO2EeiSCSayZmOP5kixhcCIt/r1Sn9tEZrB8ANEV4ISruC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3620
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_03:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=951 suspectscore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100121
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/10/20 4:01 AM, Christoph Hellwig wrote:
> The following changes since commit 88ce2a530cc9865a894454b2e40eba5957a60e1a:
> 
>   block: restore a specific error code in bdev_del_partition (2020-09-08 08:18:24 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.9-2020-09-10

Pulled, thanks.

-- 
Jens Axboe

