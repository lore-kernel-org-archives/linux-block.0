Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA970C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 09:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2B72177B
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 09:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfBJJTw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 04:19:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:36906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbfBJJTv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 04:19:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2694CADFB;
        Sun, 10 Feb 2019 09:19:49 +0000 (UTC)
Subject: Re: [PATCH 16/19] io_uring: add io_kiocb ref count
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190209211346.26060-1-axboe@kernel.dk>
 <20190209211346.26060-17-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8766cb28-9d25-0862-2f87-828046b590d0@suse.de>
Date:   Sun, 10 Feb 2019 10:19:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190209211346.26060-17-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/9/19 10:13 PM, Jens Axboe wrote:
> We'll use this for the POLL implementation. Regular requests will
> NOT be using references, so initialize it to 0. Any real use of
> the io_kiocb ref will initialize it to at least 2.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   fs/io_uring.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes

