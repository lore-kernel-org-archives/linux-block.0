Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFC5C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3560E21916
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfBIJkC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:40:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:53532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726058AbfBIJkC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 Feb 2019 04:40:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCB62AF81;
        Sat,  9 Feb 2019 09:40:00 +0000 (UTC)
Subject: Re: [PATCH 07/19] io_uring: support for IO polling
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190208173423.27014-1-axboe@kernel.dk>
 <20190208173423.27014-8-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e158e595-fa04-b035-0ab8-f70164780b76@suse.de>
Date:   Sat, 9 Feb 2019 10:39:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190208173423.27014-8-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 6:34 PM, Jens Axboe wrote:
> Add support for a polled io_uring instance. When a read or write is
> submitted to a polled io_uring, the application must poll for
> completions on the CQ ring through io_uring_enter(2). Polled IO may not
> generate IRQ completions, hence they need to be actively found by the
> application itself.
> 
> To use polling, io_uring_setup() must be used with the
> IORING_SETUP_IOPOLL flag being set. It is illegal to mix and match
> polled and non-polled IO on an io_uring.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   fs/io_uring.c                 | 274 ++++++++++++++++++++++++++++++++--
>   include/uapi/linux/io_uring.h |   5 +
>   2 files changed, 270 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes


