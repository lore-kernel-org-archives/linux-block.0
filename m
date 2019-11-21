Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2081EC43141
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 16:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9915206CC
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 16:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fZqcwRu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfKUQEi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:04:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38190 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKUQEh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 11:04:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALFsQCU042866;
        Thu, 21 Nov 2019 16:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=lPdzRkGQjx1NBncVBBW08mF7iSdoj3OKKNLTrQgVL1A=;
 b=fZqcwRu6/297MXYL4AQrhH652KbdWwYD5hkeAy3ANx2APi7pkzdLg2SEwSEKnXtnhm/l
 LP6sE5fDyy5cE1nuIVpJvi5e4fwn67KAcDpeHFbnnjNZa4EPf9o6cUhNYzjxeXoO5Wg/
 0IN166/jwdzGKEzEkS04DtxbO3+eG8bKHoiQVb+oyzGmTYa6vlikByCUrUfqERMq/bgM
 ET3Zr4/lXjs3VoUgpQ8fHu/inSnjeLRiTkTpacdJQUCqoZm5Y66RkZJf31vL0x93nw9w
 DebbKqkWFPgSI4s77cSm0Em66OEoPtGbtnyoIpk3VlZp3IMPIY2jkCWZE2HOSxOi09FM 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wa92q58kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 16:04:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALFquan057588;
        Thu, 21 Nov 2019 16:04:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wdfrtfur2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 16:04:33 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xALG4WhA010611;
        Thu, 21 Nov 2019 16:04:32 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 08:04:31 -0800
Date:   Thu, 21 Nov 2019 08:04:30 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] block: add iostat counters for flush requests
Message-ID: <20191121160430.GJ6211@magnolia>
References: <157433282607.7928.5202409984272248322.stgit@buzz>
 <ff971ff6-9a10-c3f1-107d-4f7d378e8755@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff971ff6-9a10-c3f1-107d-4f7d378e8755@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210142
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 21, 2019 at 08:56:14AM -0700, Jens Axboe wrote:
> On 11/21/19 3:40 AM, Konstantin Khlebnikov wrote:
> > Requests that triggers flushing volatile writeback cache to disk (barriers)
> > have significant effect to overall performance.
> > 
> > Block layer has sophisticated engine for combining several flush requests
> > into one. But there is no statistics for actual flushes executed by disk.
> > Requests which trigger flushes usually are barriers - zero-size writes.
> > 
> > This patch adds two iostat counters into /sys/class/block/$dev/stat and
> > /proc/diskstats - count of completed flush requests and their total time.
> 
> This makes sense to me, and the "recent" discard addition already proved
> that we're fine extending with more fields. Unless folks object, I'd be
> happy to queue this up for 5.5.

Looks like a good addition to /me... :)

--D

> -- 
> Jens Axboe
> 
