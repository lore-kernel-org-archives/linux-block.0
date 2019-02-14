Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87296C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 02:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477FE21904
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 02:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="agDZ79Tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfBNCbo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:31:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41946 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfBNCbo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 21:31:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E2OJWI190193;
        Thu, 14 Feb 2019 02:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=ILZdBoH9xHJVjmQA7MBd5DfsMcBb4zKTy6OPACDKbA4=;
 b=agDZ79TnMY3u1JMJeCm5OA/6XBWon3el0Hh2IAPTgi60gANU/dExQD6ro7G0VyhDOzHc
 KubwkolOUY0x8FhoaAYoz6ncgIHyeuNPAofi48IZ27sSxmX0gH6o/igxMgas7ODUJ1NP
 ltyAOn4I1QY4DKa5bILzqWaemVxsHR6fDsW11GD5fWVtY/L+RfLrq26GAVeDLKQnjpyY
 zoIHIaytoje3zsfep/DaPpHzvtEvDXDJm7ihvP43P9JYraY1f6enSCbKlxsxvyZmS29E
 BmBlqgvrK4NCM9DEznWjemJFw2sCBua1XZfnCErO4fNzcIxGBfWvwn2e9+VxMG8uKaM3 0w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qhreknf59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 02:31:28 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E2VLnV012041
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 02:31:22 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1E2VK1h026681;
        Thu, 14 Feb 2019 02:31:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 18:31:20 -0800
To:     "zhangxiaoxu \(A\)" <zhangxiaoxu5@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        John Dorminy <jdorminy@redhat.com>, <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Mike Snitzer" <snitzer@redhat.com>, <linux-block@vger.kernel.org>,
        <dm-devel@redhat.com>, Alasdair G Kergon <agk@redhat.com>
Subject: Re: [dm-devel] block: Fix a WRITE SAME BUG_ON
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
        <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
        <20190128221441.GA24102@redhat.com> <yq1lg34f4i7.fsf@oracle.com>
        <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
        <20190131103924.GA22503@infradead.org>
        <CAMeeMh-uxiee7rKutnr3jrMjzkc8=R2Y3DPPBLvLYjqSwjfi_w@mail.gmail.com>
        <20190201073527.GA14758@infradead.org>
        <CAMeeMh-wAZ8377sMrnyQZUt2HT1hB02DHSROJURLmPsaZPkeQQ@mail.gmail.com>
        <f7b05928-316c-4c73-b04b-bba38ea60b27@redhat.com>
        <20190201161803.GA21124@infradead.org>
        <d693e299-3c7d-b3cb-e8c7-a1f94bba4697@huawei.com>
Date:   Wed, 13 Feb 2019 21:31:16 -0500
In-Reply-To: <d693e299-3c7d-b3cb-e8c7-a1f94bba4697@huawei.com> (zhangxiaoxu's
        message of "Tue, 12 Feb 2019 11:11:29 +0800")
Message-ID: <yq1lg2jqex7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=704 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140017
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


zhangxiaoxu,

> Any progress about the problme?
> Should we disable the write same when stack the different LBA disks?

Yes, please.

-- 
Martin K. Petersen	Oracle Linux Engineering
