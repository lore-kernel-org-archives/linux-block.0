Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223DEC43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 01:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E134F2184C
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 01:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YI4bOiO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKLBc7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:32:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56108 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLBc7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 20:32:59 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAC1JjIO173779;
        Tue, 12 Nov 2019 01:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=fTgWHJSuJxj4enhVwv1L7tLVXaaO+logj3ywjSrwRZE=;
 b=YI4bOiO6wN/W0dLV/r2UFrXiihHcnxfijh6AQ2sY61eElle1gLkkMpqnaP3h6C7sNgbb
 39Gci5pqtewehUM0KDV9nq4wIBMOk8Zoua1fugmIGuCyJOJoobPfrZ9kcPrxlZPeiXES
 bpBwdTRIvf71hNpV3bMXvkqxUI/oAWh41IgVnCxRhpH98s6V5NTS6yM5ToO4Ue42FTSf
 ekwx1++VNGQtObYn0UA4n/x0ZT0VSLZ7F5KE4CCMU8D1f8BrRqyHPH4utO1mOzcIxNVd
 noeE538ZGGK39SvlaeNu1gQLJ1G5bZ93VB9iRJFhbSYfYfVXsugwGvjv9ijc7kMHmosN Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w5p3qhhqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 01:32:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAC1IKOp113548;
        Tue, 12 Nov 2019 01:32:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2w66wmya5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 01:32:52 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAC1WoSg007351;
        Tue, 12 Nov 2019 01:32:51 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 01:32:50 +0000
Date:   Mon, 11 Nov 2019 17:32:49 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Evan Green <evgreen@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] loop: Better discard for block devices
Message-ID: <20191112013249.GD6235@magnolia>
References: <20191111185030.215451-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111185030.215451-1-evgreen@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120009
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 11, 2019 at 10:50:28AM -0800, Evan Green wrote:
> This series addresses some errors seen when using the loop
> device directly backed by a block device. The first change plumbs
> out the correct error message, and the second change prevents the
> error from occurring in many cases.
> 
> The errors look like this:
> [   90.880875] print_req_error: I/O error, dev loop5, sector 0
> 
> The errors occur when trying to do a discard or write zeroes operation
> on a loop device backed by a block device that does not support write zeroes.
> Firstly, the error itself is incorrectly reported as I/O error, but is
> actually EOPNOTSUPP. The first patch plumbs out EOPNOTSUPP to properly
> report the error.
> 
> The second patch prevents these errors from occurring by mirroring the
> zeroing capabilities of the underlying block device into the loop device.
> Before this change, discard was always reported as being supported, and
> the loop device simply turns around and does an fallocate operation on the
> backing device. After this change, backing block devices that do support
> zeroing will continue to work as before, and continue to get all the
> benefits of doing that. Backing devices that do not support zeroing will
> fail earlier, avoiding hitting the loop device at all and ultimately
> avoiding this error in the logs.
> 
> I can also confirm that this fixes test block/003 in the blktests, when
> running blktests on a loop device backed by a block device.
> 
> Darrick, I see you've got a related change in linux-next. I'm not sure what
> the status of that is, so I didn't base my latest spin on top of yours.

AFAIK the patch you reference changes NOUNMAP requests to use
FALLOC_FL_ZERO_RANGE and is queued for 5.5, which means patch #2 will
clash with it.  It sort of looks like patch #2 reimplements the patch
that Jens already pulled for 5.5, so you probably want to rebase this
series atop his for-next tree.... but you should really ask Jens.

--D

> Changes in v6:
> - Updated tags
> 
> Changes in v5:
> - Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)
> 
> Changes in v4:
> - Mirror blkdev's write_zeroes into loopdev's discard_sectors.
> 
> Changes in v3:
> - Updated tags
> - Updated commit description
> 
> Changes in v2:
> - Unnested error if statement (Bart)
> 
> Evan Green (2):
>   loop: Report EOPNOTSUPP properly
>   loop: Better discard support for block devices
> 
>  drivers/block/loop.c | 66 +++++++++++++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 22 deletions(-)
> 
> -- 
> 2.21.0
> 
