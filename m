Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD282C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 16:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8639760F46
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 16:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhJYQcd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhJYQcc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 12:32:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE8C061745;
        Mon, 25 Oct 2021 09:30:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id o133so11233016pfg.7;
        Mon, 25 Oct 2021 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l4E+rSwz9ZP2ikRiYja4PDLRpPibRTNtRErggZ69ZaY=;
        b=XFprkqKE4Twrw5bLs4fY5iOkwYRet497j5H7vk+z9ikfw2vYFeGJ+tlp/wpBo1NvCU
         JVr5zw8I/8oMTHQlGKt4Wl5bf95Jv6zChFP61233ts6b3xgOaf6BOb0SOUYwbRugxEES
         a2Sz0Qp75tOuvLpN3gkCfqg4wJx72CPc8uRiJkfUr5nym2pNo0T848EteuM3YfaDsHw8
         f4DZgY35+CAc5uuvliPqxjqXsogo8u7WbYNff9AuI0wyQPBL3TnG28KVW3QyMjoIB3YM
         AtGgcqd1MCo7sgS0/uHV7wLorbMYOLLXhSCWHdQDn6tX915gId5phKEBiYtqX304vluq
         WLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=l4E+rSwz9ZP2ikRiYja4PDLRpPibRTNtRErggZ69ZaY=;
        b=6fDGD+dC64dKCUqseLKEPJUFl906lVSJnRspAlDq71SWchZU+ZqvIb/FaMnoIymdVq
         AU2xXAoZNfpVt9UdduJ5auRHqUT6wAdZh/Z+Wvk+FM+syFZJqpc/AARTxzqgcn1GnnRl
         bUgJAexVOn9/P4WTC4guL4FoDp+ZGZ3ZeatpB//NZKv6UhkjTGtpm+rrvBc4QWzpQ7Ed
         gCY4Ssie303+2Gm1jGKF+o6G+ZWI2GCEnyOjxWgplM8l1+l1fIrkaWrpuiC/kCZCTO37
         LYtSyLdkfcAv0oPpImkg/Q4O/20DsvdZqpSDMqAWazo3kuUC7JaS0mRpFrMcM/zXIg1O
         YURQ==
X-Gm-Message-State: AOAM5328Fdcqg/Vv81J2iWstWvaGnjwf7bicMBQrRXq8d9b6AgUrQBtl
        iE4G3SpkF/4RgExjzXKpq6w=
X-Google-Smtp-Source: ABdhPJzhvI0yhxCEhTYajzLusLKuldNEQL65n8XiknaSB53NbMFZk2UfB5ADOMP1zYl9reZYCqeLug==
X-Received: by 2002:aa7:8750:0:b0:47b:e995:cb3c with SMTP id g16-20020aa78750000000b0047be995cb3cmr9089169pfo.3.1635179409814;
        Mon, 25 Oct 2021 09:30:09 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:676:677c:1b95:77a5])
        by smtp.gmail.com with ESMTPSA id b13sm23425324pjl.15.2021.10.25.09.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 09:30:09 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 25 Oct 2021 09:30:07 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/4] zram: fix two races and one zram leak
Message-ID: <YXbbj7KhgAkgByp1@google.com>
References: <20211025025426.2815424-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025025426.2815424-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 25, 2021 at 10:54:22AM +0800, Ming Lei wrote:
> Hello,
> 
> Fixes three issues reported by Luis Chamberlain with one simpler approach:
> 
> - race between between zram_reset_device() and disksize_store() (1/4)
> 
> - zram leak during unloading module, which is one race between resetting
> and removing device (2/4)
> 
> - race between zram_remove and disksize_store (3/4)
> 
> Also replace replace fsync_bdev with sync_blockdev since no one opens
> it.(4/4)
> 
> V3:
> 	- no code change
> 	- update commit log or comment as Luis suggested
> 	- add reviewed-by tag
> 
> V2:
> 	- take another approach to avoid failing of zram_remove()
> 	- add patch to address race between zram_reset_device() and
> 	  disksize_store()
> 
> 
> Ming Lei (4):
>   zram: fix race between zram_reset_device() and disksize_store()
>   zram: don't fail to remove zram during unloading module
>   zram: avoid race between zram_remove and disksize_store
>   zram: replace fsync_bdev with sync_blockdev

Andrew Morton usually takes zram patches so Ccing him.

Acked-by: Minchan Kim <minchan@kernel.org>

for all patches in this thread.
