Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA70C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 04:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10F92086D
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 04:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei28byz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfF1E5U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:57:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40568 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1E5U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 00:57:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so2533108pla.7;
        Thu, 27 Jun 2019 21:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OR3h7WVLUUcHv2ZQw3/q57OQjyW+UVNhTLXPtjGCrJ0=;
        b=ei28byz3zaf69sNEyIoUnVyolQau6p1sOqIfjBqdwpVsQXxy5XzHcEtcvgFWzsUItj
         GjPTqfpmpzWDeM98iaQq5KvqmOmG/XfTrqheGfDYMhUL+QykDquFlkfhKCodwz2lE/u8
         Krr25RkrF4y2Ga8uPPoyOcsEF7tPdkBuq9QiBPy38UjjQEy91uBKvBmCMFndkrvb4bFd
         DtKwQk+bAMueFtqBBzrsoX7pxxDJSO2aUnwSRkywkC6jQej39VqzqRR71RMyC4+pT3e0
         HT+ulB+mEWC1dIvoy22exsNg5A1aijtcyD16uH3xINMfIvjcLCc0aGEulzpLq4IodNwI
         R96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OR3h7WVLUUcHv2ZQw3/q57OQjyW+UVNhTLXPtjGCrJ0=;
        b=CuQnKvQU+nuxRHxB/IXrnOuoAbnmxKTF5TrVIG3koNeSxUOi270vGNDNGv2ZSiZiYG
         U+KpvvcdxU77s4B5tDddIFV09zaRJA3mc1awx8Tar9iuRGVpc69MnOm5qKuRTzxnSmfB
         rsw53LeVS0W/dvWTHI8P+c6q2rLDu/PwpS/xz3dQfy9bOVl+JPuQiAJcW6MdkQyX0RoD
         Mn5+4pPjxEGP2YlHT/gTH2o6iY2QKkPDOt4d3rR+Qa8lJRzYJT2yHwgxHYei8x/va3eU
         p5qvaFDXF91jjHq3Kp37Yx8lzk+QECdTIEpOp3uq9iXFgWbqNQqCE9b7CC5BT7rcVTY8
         iW2w==
X-Gm-Message-State: APjAAAXLlfgmejagTGZahaRya7wKheFW+vEOfBBc868eMWJJErcksnso
        IQnc0/kpeR3DBTZNuX0EJjc=
X-Google-Smtp-Source: APXvYqxTafNgX712/BPSdB59aYvCszobul2tZO9M0XwL4VGiLruBAtR90duYAn9pzgt5uwdCJ/xEeg==
X-Received: by 2002:a17:902:e512:: with SMTP id ck18mr8694515plb.53.1561697838971;
        Thu, 27 Jun 2019 21:57:18 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e184sm842745pfa.169.2019.06.27.21.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 21:57:17 -0700 (PDT)
Date:   Thu, 27 Jun 2019 21:57:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, groeck@chromium.org,
        drinkcat@chromium.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block, bfq: NULL out the bic when it's no longer valid
Message-ID: <20190628045716.GA17274@roeck-us.net>
References: <20190628044409.128823-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628044409.128823-1-dianders@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 27, 2019 at 09:44:09PM -0700, Douglas Anderson wrote:
> In reboot tests on several devices we were seeing a "use after free"
> when slub_debug or KASAN was enabled.  The kernel complained about:
> 
>   Unable to handle kernel paging request at virtual address 6b6b6c2b
> 
> ...which is a classic sign of use after free under slub_debug.  The
> stack crawl in kgdb looked like:
> 
>  0  test_bit (addr=<optimized out>, nr=<optimized out>)
>  1  bfq_bfqq_busy (bfqq=<optimized out>)
>  2  bfq_select_queue (bfqd=<optimized out>)
>  3  __bfq_dispatch_request (hctx=<optimized out>)
>  4  bfq_dispatch_request (hctx=<optimized out>)
>  5  0xc056ef00 in blk_mq_do_dispatch_sched (hctx=0xed249440)
>  6  0xc056f728 in blk_mq_sched_dispatch_requests (hctx=0xed249440)
>  7  0xc0568d24 in __blk_mq_run_hw_queue (hctx=0xed249440)
>  8  0xc0568d94 in blk_mq_run_work_fn (work=<optimized out>)
>  9  0xc024c5c4 in process_one_work (worker=0xec6d4640, work=0xed249480)
>  10 0xc024cff4 in worker_thread (__worker=0xec6d4640)
> 
> Digging in kgdb, it could be found that, though bfqq looked fine,
> bfqq->bic had been freed.
> 
> Through further digging, I postulated that perhaps it is illegal to
> access a "bic" (AKA an "icq") after bfq_exit_icq() had been called
> because the "bic" can be freed at some point in time after this call
> is made.  I confirmed that there certainly were cases where the exact
> crashing code path would access the "bic" after bfq_exit_icq() had
> been called.  Sspecifically I set the "bfqq->bic" to (void *)0x7 and
                ^^^

> saw that the bic was 0x7 at the time of the crash.
> 
> To understand a bit more about why this crash was fairly uncommon (I
> saw it only once in a few hundred reboots), you can see that much of
> the time bfq_exit_icq_fbqq() fully frees the bfqq and thus it can't
> access the ->bic anymore.  The only case it doesn't is if
> bfq_put_queue() sees a reference still held.
> 
> However, even in the case when bfqq isn't freed, the crash is still
> rare.  Why?  I tracked what happened to the "bic" after the exit
> routine.  It doesn't get freed right away.  Rather,
> put_io_context_active() eventually called put_io_context() which
> queued up freeing on a workqueue.  The freeing then actually happened
> later than that through call_rcu().  Despite all these delays, some
> extra debugging showed that all the hoops could be jumped through in
> time and the memory could be freed causing the original crash.  Phew!
> 
> To make a long story short, assuming it truly is illegal to access an
> icq after the "exit_icq" callback is finished, this patch is needed.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Nicely done ... thanks!

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> Most of the testing of this was done on the Chrome OS 4.19 kernel with
> BFQ backported (thanks to Paolo's help).  I did manage to reproduce a
> crash on mainline Linux (v5.2-rc6) though.
> 
> To see some of the techniques used to debug this, see
> <https://crrev.com/c/1679134> and <https://crrev.com/c/1681258/1>.
> 
> I'll also note that on linuxnext (next-20190627) I saw some other
> use-after-frees that seemed related to BFQ but haven't had time to
> debug.  They seemed unrelated.
> 
>  block/bfq-iosched.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index f8d430f88d25..6c0cff03f8f6 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4584,6 +4584,7 @@ static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&bfqd->lock, flags);
> +		bfqq->bic = NULL;
>  		bfq_exit_bfqq(bfqd, bfqq);
>  		bic_set_bfqq(bic, NULL, is_sync);
>  		spin_unlock_irqrestore(&bfqd->lock, flags);
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
