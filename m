Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC43C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC754207E0
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfBIJtI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:49:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:54542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726058AbfBIJtI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 Feb 2019 04:49:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8A1FAFC5;
        Sat,  9 Feb 2019 09:49:06 +0000 (UTC)
Subject: Re: [PATCH 13/19] net: split out functions related to registering
 inflight socket files
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
References: <20190208173423.27014-1-axboe@kernel.dk>
 <20190208173423.27014-14-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a1332a6b-8fff-3a28-e5be-82a434edbe18@suse.de>
Date:   Sat, 9 Feb 2019 10:49:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190208173423.27014-14-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 6:34 PM, Jens Axboe wrote:
> We need this functionality for the io_uring file registration, but
> we cannot rely on it since CONFIG_UNIX can be modular. Move the helpers
> to a separate file, that's always builtin to the kernel if CONFIG_UNIX is
> m/y.
> 
> No functional changes in this patch, just moving code around.
> 
> Cc: netdev@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   include/net/af_unix.h |   1 +
>   net/unix/Kconfig      |   5 ++
>   net/unix/Makefile     |   2 +
>   net/unix/af_unix.c    |  63 +-----------------
>   net/unix/garbage.c    |  71 +-------------------
>   net/unix/scm.c        | 146 ++++++++++++++++++++++++++++++++++++++++++
>   net/unix/scm.h        |  10 +++
>   7 files changed, 168 insertions(+), 130 deletions(-)
>   create mode 100644 net/unix/scm.c
>   create mode 100644 net/unix/scm.h
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes


