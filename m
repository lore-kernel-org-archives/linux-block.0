Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AD7C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 13:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F169520652
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 13:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uG6ja0iC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfDXNPD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:15:03 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57672 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbfDXNPD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 09:15:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3ODEGXD003750;
        Wed, 24 Apr 2019 13:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=27FXUHsMgLsCTIL/O8nlrQbvaIV7QR9XL7VHwVTIQ7I=;
 b=uG6ja0iC73CZP3UBaYLpUuAK9BZxGtv2aN0X0sVryovq1yfNfyV06zyJuyBSkHCXglrZ
 6gJ0HfwUjIh5gLXpN3kc3eDhMimlpBxCd3MlPMMcCu5LhZGWkoT6T+N0N1tVcDBotB5N
 KDTtXU7ZM3E5WrjYlMkyStKQnTnWfZS3h07QHSiWjDfHj6Hoy5K36g+s1yxiM2vjJ9vs
 RCjmlGwWAHJjt1Dqf6iQF9Sr8tfLkXJJ+f6YjiYuM1gkZ17eOGLBWPU4nWZGLiW7LNGy
 uY6tMa5McHHhyjJYJgPEvYdN9Bx/u9KQxXPWQh2b5AaFxI/ilBFK18b1FjyjgkoSfvYo mQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2ryrxd2ety-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 13:14:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3ODDMTx025796;
        Wed, 24 Apr 2019 13:14:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ryrhsn3c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 13:14:44 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3ODEcto004364;
        Wed, 24 Apr 2019 13:14:39 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Apr 2019 06:14:38 -0700
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] block: integrity: enable multi-page bvec for bio integrity
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190423071550.20806-1-ming.lei@redhat.com>
        <20190423071550.20806-2-ming.lei@redhat.com>
Date:   Wed, 24 Apr 2019 09:14:36 -0400
In-Reply-To: <20190423071550.20806-2-ming.lei@redhat.com> (Ming Lei's message
        of "Tue, 23 Apr 2019 15:15:49 +0800")
Message-ID: <yq1ftq78s03.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904240105
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904240106
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming,

I'm traveling today and probably won't be able to take a closer look
until tomorrow. But from a quick glance this looks OK.

> The integrity buffer can't be very big, for example, the max sectors
> for one bio is 2560, one sector may take at most 8bytes for integrity
> info, so the max size of integrity buffer is just 20k(<=5 pages).

Just a comment on your rationale about 5 pages.

buffer_head submissions have traditionally been small, and depending on
your choice of allocator, new allocations would grow backwards in
memory. So there were several common I/O patterns that produced a
single, non-mergeable 8 byte integrity metadata allocation for every 512
bytes of data in the I/O. It's a pathological corner case. Just make
sure it's something you handle when you muck with this. ext[23] and dd
to the block device used to be able to reproduce this scenario easily.

-- 
Martin K. Petersen	Oracle Linux Engineering
