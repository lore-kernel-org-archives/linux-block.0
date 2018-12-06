Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1E6C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 03:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02872082D
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 03:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C7+OurDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02872082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeLFDPU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:15:20 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37382 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLFDPT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 22:15:19 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB63EIjQ080465;
        Thu, 6 Dec 2018 03:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=eBqrN2H71fZCLDJb+yzJXB+6upH38HGyB0Z+LqIl9P8=;
 b=C7+OurDTFa8EPH0EeYKuitRxnKPV6Nc51wicRqCe1xwLI84zOk5yI/dkyjFdLfXuQTlR
 AIFWJ63T+YVjXcelKiFgG65Z/EV7x4tShJ312/0AkbvIV5xZ2Jz9tZH6ExXN+WMXgbB0
 neFKKFbqcnb0nEk7diY5kjU+RXRK+0mteG3VSombbQKOgaK7PmRG+sGtDFd0cSALli8u
 v06X6PlALkBGpkQE20K2sg1InFRk9MPhLz7oQ9zAFwzUTtDmow4l8svc6VmFWIZSHxJW
 MimZjMfcoMgUVNzI1bD3omi+aYfNZRDg6b82fsg4OzIxSfPAtB2E7bKsrfDZ7yqQL7oN DA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2p3ftf9ujm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 03:15:14 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB63FDeh025820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 03:15:13 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB63FCrY007548;
        Thu, 6 Dec 2018 03:15:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 19:15:12 -0800
To:     Evan Green <evgreen@chromium.org>
Cc:     ming.lei@redhat.com, axboe@kernel.dk,
        Gwendal Grignou <gwendal@chromium.org>, asavery@chromium.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] loop: Better discard support for block devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181030230624.61834-1-evgreen@chromium.org>
        <20181030230624.61834-3-evgreen@chromium.org>
        <20181128012624.GB11128@ming.t460p>
        <CAE=gft7Fyq+Jb3ZG3PSTR=C0Wjt3uu57+H2bshM6Gu=_0W0YQw@mail.gmail.com>
        <20181205011059.GA17845@ming.t460p>
        <CAE=gft7K2OrN93c8TQ5ozOpXzXf5ZD-PNnVHWP9SbZXZqp2dHw@mail.gmail.com>
Date:   Wed, 05 Dec 2018 22:15:10 -0500
In-Reply-To: <CAE=gft7K2OrN93c8TQ5ozOpXzXf5ZD-PNnVHWP9SbZXZqp2dHw@mail.gmail.com>
        (Evan Green's message of "Wed, 5 Dec 2018 11:35:57 -0800")
Message-ID: <yq1va47pcqp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=848
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060027
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Evan,

> Ah, I see. But I think it's useful to reflect max_discard_sectors,
> max_write_zeroes_sectors, discard_granularity, and discard_alignment
> from the block device to the loop device. With the exception of
> discard_alignment, these parameters are visible via sysfs,

discard_alignment is visible in sysfs, just not in the queue directory
since alignment can be different on a per-partition basis. So there is
one discard_alignment at the root of each /sys/block/foo directory and
one for each partition subdirectory. This mirrors the alignment_offset
variable which indicates a partitions alignment wrt. the underlying
physical block size.

That said, there are not many devices that actually report a non-zero
discard alignment so it's not as useful as the device manufacturers
(that were looking for an implementation shortcut) envisioned.

> I'm not totally sure about discard_alignment, that seems to be useful
> in cases of merging blk requests. So I can stop mirroring that one if
> it's harmful or not helpful. But unless it's a nak, I'd really love to
> keep most of the mirroring. In which case the bool doesn't do a whole
> lot of simplifying.

I think it's fine to export these. The block device topology was
explicitly designed to be stackable like this.

-- 
Martin K. Petersen	Oracle Linux Engineering
