Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7447C43444
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 17:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A891620656
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 17:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="484HcAMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfAORcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:32:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42104 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfAORcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 12:32:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0FHE0CW020845;
        Tue, 15 Jan 2019 17:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=u0WE5hfj6ulueNXnNXvJ1h/hCVgbLZphc8ZAdhtDa+4=;
 b=484HcAMvzc/XB+7NjoS1WfwWRsvQY+OX+bekwzHcMlmSLgYRd5itdXZNcfJpZpJiX+7L
 dWmirobgCb+1FJalFboAS8cuqBVo2JlnVWnkjulQgXvGKB/9ucAWRaojjuo1cM7ZjMBf
 THHuqjMlHIVtM5dFBEU/gOe/ETbfcNO5WOfCKPfED5LT2/AVvIr9Y/Lf1FYQCTiRWmfe
 jxGj4gcw/6Ye2d6HVf/lQqNQRBNB8NqofKzmO95QkOEIbhinMoCd8e16Bmh/nKBaITI9
 O5uYJYIBGq0eSTkVgwWii1yu4C/276PKM5l/4zUEPYthgf8c3RPttmkeiTXi/S5juMnP rg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2pybjs5900-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jan 2019 17:32:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0FHW2Ci025656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jan 2019 17:32:03 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0FHW2IE031843;
        Tue, 15 Jan 2019 17:32:02 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Jan 2019 09:32:02 -0800
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 05/15] Add io_uring IO interface
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190110024404.25372-1-axboe@kernel.dk>
        <20190110024404.25372-6-axboe@kernel.dk> <yq1sgxzys3s.fsf@oracle.com>
        <f97a5b9f-68f3-c4af-649d-7dffbc35e37f@kernel.dk>
        <54976aac-bef2-880f-dc10-e3030189a08a@kernel.dk>
Date:   Tue, 15 Jan 2019 12:31:59 -0500
In-Reply-To: <54976aac-bef2-880f-dc10-e3030189a08a@kernel.dk> (Jens Axboe's
        message of "Sun, 13 Jan 2019 09:22:16 -0700")
Message-ID: <yq1pnsxu8s0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9137 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=676
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901150143
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jens,

> I bit the bullet and bumped the size. 64 bytes is a nicer size in terms
> of cachelines anyway, and I really doubt that 48 vs 64 bytes makes a
> size consumption problem for anyone.
>
> The buf_index is only used for the fixed buffers, which means that we have
> 16 bytes / 128 bits that we can grab for things like KV.

Great!

-- 
Martin K. Petersen	Oracle Linux Engineering
