Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ECBC43612
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DCE20850
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="FOwkLRKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfARQVW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:21:22 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39266 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfARQVV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 11:21:21 -0500
Received: by mail-yw1-f67.google.com with SMTP id k188so5434483ywa.6
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 08:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2+Xp+1PxvpMrCtHJEzLEhHlqUYY2Zw6AGFHMc2AUUhc=;
        b=FOwkLRKVD7QBxkTWJi4E2THLnFwleZPVPDnKi3gwBnCPWtTNSkqTyV66ZTHgDYopVY
         Nga3lyIBWprnX81BUHumNE4GJmC2ctmyzfkQytDAKz4cgCsA7rjSlgB7GFJWbBlTrrC9
         uMiMfOM/DBhznCCl2N2ucKryXF6K7+CHCjikbEgmNRctA2Py57TLc5nWsbbYjOqRAazI
         ozGzbz9KHg3WfgySNbyWL70QPRJu2Y5/GXTsxVKHQOkpXtH/ffcglDIYVDw2dgvJqi0q
         oAFOJWjmQCjZGzFBf085db56hes/0Zmi2ccmZwtDMwz8Rp2zYIlpU6X+Sw/fh7gvWn4G
         Nc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2+Xp+1PxvpMrCtHJEzLEhHlqUYY2Zw6AGFHMc2AUUhc=;
        b=ofeYFq5k6AvymFFk+Jcw2AZgLn1hin89SSm8VPz55h6+zfI5Fkah92q/t8hR670QVF
         2WxrPKnIBvDBZL4XugtcGZyFPDFWkf7tn34O9XMnMbm42QjHni10PJiPhM65b+C6oVD9
         hq7FHVbVNNBKGoTm9WbkoehYUcm2Vv4GolK7cpHICDAeFy+PNn/7+hPqtf3h4g3PR/Jf
         L5XQIEviHQPwrmiw7CnceWjkgSn+s813+MTSRtu/CYHleFc498Sr4y3YWrDqWggSNf9J
         EVjF2vJBnGOcvfyTe9Xlzuo59lv/5L+gbD2lIvnCRatQzZCM0sJmCpBLo/tKQPdhkFoW
         JPBg==
X-Gm-Message-State: AJcUukf4ElVgcNO42ZG2LjHPJ2rM8UmulgaADpyUMeOnD0Krynpm5whc
        Bg0bg+KWZ21rwGBLNGCEF/TfQ6DNvO0=
X-Google-Smtp-Source: ALg8bN4bnp65cmDGjBWQLAtHSNHJN+kw1B3HvtVGl5p722Qi/+Hbobjln6FR5YMAJTIpngK+KnVg1w==
X-Received: by 2002:a0d:d586:: with SMTP id x128mr18509821ywd.346.1547828480435;
        Fri, 18 Jan 2019 08:21:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:e09e])
        by smtp.gmail.com with ESMTPSA id u4sm2839773ywu.92.2019.01.18.08.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:21:19 -0800 (PST)
Date:   Fri, 18 Jan 2019 11:21:18 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] blk-iolatency: fix IO hang due to negative inflight
 counter
Message-ID: <20190118162117.zqdwjkq74wzsaxn3@macbook-pro-91.dhcp.thefacebook.com>
References: <20190114192137.111275-1-bo.liu@linux.alibaba.com>
 <16ab732a-6537-3627-52ed-05013188a3f5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16ab732a-6537-3627-52ed-05013188a3f5@kernel.dk>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 05:58:18AM -0700, Jens Axboe wrote:
> On 1/14/19 12:21 PM, Liu Bo wrote:
> > Our test reported the following stack, and vmcore showed that
> > ->inflight counter is -1.
> > 
> > [ffffc9003fcc38d0] __schedule at ffffffff8173d95d
> > [ffffc9003fcc3958] schedule at ffffffff8173de26
> > [ffffc9003fcc3970] io_schedule at ffffffff810bb6b6
> > [ffffc9003fcc3988] blkcg_iolatency_throttle at ffffffff813911cb
> > [ffffc9003fcc3a20] rq_qos_throttle at ffffffff813847f3
> > [ffffc9003fcc3a48] blk_mq_make_request at ffffffff8137468a
> > [ffffc9003fcc3b08] generic_make_request at ffffffff81368b49
> > [ffffc9003fcc3b68] submit_bio at ffffffff81368d7d
> > [ffffc9003fcc3bb8] ext4_io_submit at ffffffffa031be00 [ext4]
> > [ffffc9003fcc3c00] ext4_writepages at ffffffffa03163de [ext4]
> > [ffffc9003fcc3d68] do_writepages at ffffffff811c49ae
> > [ffffc9003fcc3d78] __filemap_fdatawrite_range at ffffffff811b6188
> > [ffffc9003fcc3e30] filemap_write_and_wait_range at ffffffff811b6301
> > [ffffc9003fcc3e60] ext4_sync_file at ffffffffa030cee8 [ext4]
> > [ffffc9003fcc3ea8] vfs_fsync_range at ffffffff8128594b
> > [ffffc9003fcc3ee8] do_fsync at ffffffff81285abd
> > [ffffc9003fcc3f18] sys_fsync at ffffffff81285d50
> > [ffffc9003fcc3f28] do_syscall_64 at ffffffff81003c04
> > [ffffc9003fcc3f50] entry_SYSCALL_64_after_swapgs at ffffffff81742b8e
> > 
> > The ->inflight counter may be negative (-1) if
> > 
> > 0) blk-throttle had been enabled when the IO was issued, so its bio
> > has a associated blkg,
> > 
> > 1) blk-iolatency was disabled when the IO was issued, so iolatency_grp
> > in this blkg was not available by then,
> > 
> > 2) blk-iolatency was enabled before this IO reached its endio, so that
> > iolatency_grp became available when the IO did the endio.
> > 
> > 3) the ->inflight counter is decreased from 0 to -1.
> > 
> > This uses atomic_dec_is_positive() instead to avoid the negative
> > inflight counter.
> 
> The problem with that is that it'll hide a lot of other issues, too.
> Any way we can either track if this rqw is in flight, and only dec
> if it is, or quiesce when enabling?
> 

I worried about this too, but really the side-effect of allowing more through
because of mis-counting means we just let more IO through.  I think maybe we add
a debug option that we can turn on to see if we're messing up accounting, but in
general I don't see a problem with this approach.

The problem we're running into here is there's not really a good way to tag a
bio as "seen by io.latency."  We just have to assume if we're on and there's a
bi_blkg associated that we saw it at submit time.  We can't just add a flag for
every io controller that starts tracking inflight io's, so for now I think this
is a reasonable solution.  Thanks,

Josef
