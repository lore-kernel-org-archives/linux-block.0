Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D205C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230DD21916
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfBIJZs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:25:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:52420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbfBIJZs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 Feb 2019 04:25:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0842CACAE;
        Sat,  9 Feb 2019 09:25:47 +0000 (UTC)
Subject: Re: [PATCH 04/19] iomap: wire up the iopoll method
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190208173423.27014-1-axboe@kernel.dk>
 <20190208173423.27014-5-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e49f04c6-ab75-d0ed-feb0-ab5d02c854a5@suse.de>
Date:   Sat, 9 Feb 2019 10:25:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190208173423.27014-5-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 6:34 PM, Jens Axboe wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Store the request queue the last bio was submitted to in the iocb
> private data in addition to the cookie so that we find the right block
> device.  Also refactor the common direct I/O bio submission code into a
> nice little helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Modified to use bio_set_polled().
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   fs/gfs2/file.c        |  2 ++
>   fs/iomap.c            | 43 ++++++++++++++++++++++++++++---------------
>   fs/xfs/xfs_file.c     |  1 +
>   include/linux/iomap.h |  1 +
>   4 files changed, 32 insertions(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes


