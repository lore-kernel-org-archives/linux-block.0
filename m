Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA247C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 22:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2172072F
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 22:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TCn3525h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgFBWf1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 18:35:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59522 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgFBWf1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 18:35:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052MW68P016387;
        Tue, 2 Jun 2020 22:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=bD3UacLBwx+YKEs4eG5RaYbAiUcQOKlKnfWL01xaU9A=;
 b=TCn3525h7WGw7GfyJPHuKzNJtBY7z9gkmJh4JZ7YshPYlLhL/IaPlZaAb8F1Hl071+y3
 EMN3SZAqEotAzVU+85Pgtzgj0BKp/2acNXwhUmVUc3hVtSxR0B7oW2LRUTvGKBSUzqm9
 4yLJab0oVaETP351Tli+0ENjMWmuYiihsncTC1Z+B6yCyKAMJ9XV2eIBjdFLEHhI/CuA
 RNfDleoMB6dGD+isZ6ytm0FrKOUKS6JSYATv2/qKhyxEXTxqmDjN5nIkCHHiik7ynuwz
 ocGHmgj/WJXtR11P8rHADuGEkdFeE0TxchrBiFQ+qDETkI1I5wpyvEd6jmvOT/Zj64aH rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31bewqxe6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 22:35:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052MXwGD050538;
        Tue, 2 Jun 2020 22:35:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31c25q76gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 22:35:15 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 052MZCUo024602;
        Tue, 2 Jun 2020 22:35:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 15:35:12 -0700
To:     yu kuai <yukuai3@huawei.com>
Cc:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <martin.petersen@oracle.com>, <wenwen@cs.uga.edu>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
Subject: Re: [PATCH] block/bio-integrity: don't free 'buf' if
 bio_integrity_add_page() failed
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tuzt9k6w.fsf@ca-mkp.ca.oracle.com>
References: <20200601123856.3895734-1-yukuai3@huawei.com>
Date:   Tue, 02 Jun 2020 18:35:10 -0400
In-Reply-To: <20200601123856.3895734-1-yukuai3@huawei.com> (yu kuai's message
        of "Mon, 1 Jun 2020 20:38:56 +0800")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=5 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=5 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020157
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Yu!

I suggest a few minor wording tweaks to the commit message:

> commit e7bf90e5afe3 ("block/bio-integrity: fix a memory leak bug") add

s/add/added/

> a kree() for 'buf' if bio_integrity_add_page() return '0'. However,
> the

s/kree/kfree/
s/return/returns/

> object will be freed in bio_integrity_free() since 'bio->bi_opf' and
> 'bio->bi_integrity' was set previousy in bio_integrity_alloc().

s/was/were/

Otherwise OK.

And like Ming pointed out, you may want to add a comment about the
assertion that the first vec is valid.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
