Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C3AC282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9824520857
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBIJWb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:22:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:52134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfBIJWb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 Feb 2019 04:22:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49C7DACF8;
        Sat,  9 Feb 2019 09:22:30 +0000 (UTC)
Subject: Re: [PATCH 02/19] block: wire up block device iopoll method
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190208173423.27014-1-axboe@kernel.dk>
 <20190208173423.27014-3-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c58b0cfd-e992-e847-4784-8f8dc6d6b4e7@suse.de>
Date:   Sat, 9 Feb 2019 10:22:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190208173423.27014-3-axboe@kernel.dk>
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
> Just call blk_poll on the iocb cookie, we can derive the block device
> from the inode trivially.
> 
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   fs/block_dev.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes

