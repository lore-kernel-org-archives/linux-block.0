Return-Path: <SRS0=kXjy=ZV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA740C432C0
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 11:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A2D21781
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 11:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfK2L4I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:56:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:50150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbfK2L4I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 06:56:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 521DBACC4;
        Fri, 29 Nov 2019 11:56:06 +0000 (UTC)
Subject: Re: [PATCH] xen-blkback: allow module to be cleanly unloaded
To:     Paul Durrant <pdurrant@amazon.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20191129113131.1954-1-pdurrant@amazon.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <6d0a90f6-3def-a970-6dca-8d1f3eb66c1c@suse.com>
Date:   Fri, 29 Nov 2019 12:56:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191129113131.1954-1-pdurrant@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29.11.2019 12:31, Paul Durrant wrote:
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -173,6 +173,8 @@ static struct xen_blkif *xen_blkif_alloc(domid_t domid)
>  	init_completion(&blkif->drain_complete);
>  	INIT_WORK(&blkif->free_work, xen_blkif_deferred_free);
>  
> +	__module_get(THIS_MODULE);
> +
>  	return blkif;
>  }
>  
> @@ -320,6 +322,8 @@ static void xen_blkif_free(struct xen_blkif *blkif)
>  
>  	/* Make sure everything is drained before shutting down */
>  	kmem_cache_free(xen_blkif_cachep, blkif);
> +
> +	module_put(THIS_MODULE);
>  }

I realize there are various example of this in the tree, but
isn't this a flawed approach? __module_get() (nor even
try_module_get()) will prevent an unload attempt ahead of it
getting invoked, while execution is already in this module's
.text section. I think the xenbus driver should do this
before calling ->probe(), in case of its failure, and after
a successful call to ->remove().

Jan
