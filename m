Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35043 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754684AbcLNEIr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2016 23:08:47 -0500
Subject: Re: [PATCH] block_dev: don't update file access position for sync
 direct IO
To: Shaohua Li <shli@fb.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <d78aaba0928aa012d13eb462bbfc33cdddd0621a.1481684697.git.shli@fb.com>
CC: <kernel-team@fb.com>, Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <58920289-6947-c079-6d96-779408436aeb@fb.com>
Date: Tue, 13 Dec 2016 21:08:18 -0700
MIME-Version: 1.0
In-Reply-To: <d78aaba0928aa012d13eb462bbfc33cdddd0621a.1481684697.git.shli@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/13/2016 08:07 PM, Shaohua Li wrote:
> For sync direct IO, generic_file_direct_write/generic_file_read_iter
> will update file access position. Don't duplicate the update in
> .direct_IO. This cause my raid array can't assemble.

That's not great... Thanks, added.

-- 
Jens Axboe

