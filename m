Return-Path: <SRS0=GZIg=6R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769FEC3A5A9
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 02:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48FC42075B
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 02:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIHphvuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgECCtw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 May 2020 22:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726699AbgECCtw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 May 2020 22:49:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E70C061A0C
        for <linux-block@vger.kernel.org>; Sat,  2 May 2020 19:49:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so16666086wrm.13
        for <linux-block@vger.kernel.org>; Sat, 02 May 2020 19:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=D7oIYuxOz38wSDKDkJrOFYN8c9j2piNhyyoZCS7tKgs=;
        b=tIHphvuGoTcsgWxYohWLDBgJ7oTdyc8Rqt9Z7U+rl1QyDXXQY3Ay+kCyy4aDjmR64p
         3zhEzGNlNtknNAC6rLL6bcoqMfGydSbvi3HSTx3mY7Fewi3Zx9EEm/RHCsaoZKRhvJeD
         djDZW4y9u6bEOiBBSXPg6Hb7FP/oga2VzP/Q4cZjTsdnalCBLh8K22UHcD0MLl+eMxbC
         sVcxgouCE0qJ79od7TA1mudyNT1+Xd5Wu3FTH5aVJ+PjYZ6JwspLcj4yLxUa2HN7sd7x
         hAiGjlx7KL/8J/9il+BlyZERFxOUVpIBfe4t2DRYvrYFzLR0jpv35R880IXsxXMdrJQf
         k2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=D7oIYuxOz38wSDKDkJrOFYN8c9j2piNhyyoZCS7tKgs=;
        b=acZcuyjDxg4PvrQpYl4mYEHzwPVd6CMvKpywxhxH/mcLcpc2PmA/PHhgJgqgEqjkyD
         MrTpwpbBS/8stWxrMK6Jx+o2HyZdxZjfnfLsT9snAZ0AfUJXi+DPtjiK1I8KUyKG0jtv
         f5+QB8TZFeC6ocuYKgsu/k91YOKPBFh6K8ZiYKqECzKB0pIFLEtn/ogKHECvPrfKNjMP
         LCSkygQ9xYn+rhUsnxiicolcK6uwCp4TKdeylnOI7LyiMLErZzjnzciY4Rw3Tv/k7st6
         hT8dKWRMHJGjepCnSk3+/xUlcFgqHFsE+a1UdRpkoeoLcZjbrOSnFkM94ejnTCbWfkGl
         qUZg==
X-Gm-Message-State: AGi0Pua6KSp3e6lHg9xyZzTFiP8ocPi1SR+dIftBRIKnY+ARs1kXIglP
        j6KGiZyG1Ow4ePw3aWDqn3vtCGpsROymkrLo6UM=
X-Google-Smtp-Source: APiQypJtU8VRIDhkgYROb8BvbU9z+Xs7Se8TYfr5gawjNIBT7/oRFgEDyiwMo59U2eHbKB8AJUOPe6yF9+SzKqIpIzc=
X-Received: by 2002:a5d:5304:: with SMTP id e4mr11259593wrv.87.1588474189179;
 Sat, 02 May 2020 19:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588080449.git.zhangweiping@didiglobal.com> <5b06d772447eaab3b69dfc76716a79519eb932b3.1588080449.git.zhangweiping@didiglobal.com>
In-Reply-To: <5b06d772447eaab3b69dfc76716a79519eb932b3.1588080449.git.zhangweiping@didiglobal.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sun, 3 May 2020 10:49:37 +0800
Message-ID: <CACVXFVMgw_F++P+1A409_wX6i7e-oUij6FhbvotyAoa2ZReoSQ@mail.gmail.com>
Subject: Re: [RESEND v4 1/6] block: free both rq_map and request
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 9:29 PM Weiping Zhang
<zhangweiping@didiglobal.com> wrote:
>
> For this error handle, it should free both map and request,
> otherwise a memory leak occur.
>
> Allocation:
>
> __blk_mq_alloc_rq_map
>         blk_mq_alloc_rq_map
>                 blk_mq_alloc_rq_map
>                         tags = blk_mq_init_tags : kzalloc_node:
>                         tags->rqs = kcalloc_node
>                         tags->static_rqs = kcalloc_node
>         blk_mq_alloc_rqs
>                 p = alloc_pages_node
>                 tags->static_rqs[i] = p + offset;
>
> Free:
>
> blk_mq_free_rq_map
>         kfree(tags->rqs);
>         kfree(tags->static_rqs);
>         blk_mq_free_tags
>                 kfree(tags);
>
> The page allocated in blk_mq_alloc_rqs cannot be released,
> so we should use blk_mq_free_map_and_requests here.
>
> blk_mq_free_map_and_requests
>         blk_mq_free_rqs
>                 __free_pages : cleanup for blk_mq_alloc_rqs
>         blk_mq_free_rq_map : cleanup for blk_mq_alloc_rq_map
>
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a7785df2c944..f789b3e1b3ab 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2995,7 +2995,7 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
>
>  out_unwind:
>         while (--i >= 0)
> -               blk_mq_free_rq_map(set->tags[i]);
> +               blk_mq_free_map_and_requests(set, i);
>
>         return -ENOMEM;
>  }
> --
> 2.18.1
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming Lei
