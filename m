Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD3DC433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 20:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiBNU7I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 15:59:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiBNU7G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 15:59:06 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260F916E7F7
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 12:58:38 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id l19so25517749pfu.2
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 12:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=isuxaQBSlq+kBirX/kGv7oxM5QTuknPLlFBlCe5nqVY=;
        b=je2z0Wh1NDzPwSgHcO0RZYV6Mf6GiQgYh+beHxc1yNnZpCnkHoa3Esb1Mll7b42CoP
         2tX5BmH5/CIq5d//8xq3aW3CsfALhC355U6FzzUMQqSolL7mbQ8fXwwZdldeIYhlk1bu
         7jfDG/xdmlRniIi22NzP85bSwgwdDgsxBmm4FjlEEt+d4CSuF2Z0GSLc4yOxZMwgU0FU
         AaLADzhqQGirhDFhskx8XQYQ/0Zv364uEiv0Lrd5db2xxj4QLy2C2jIzHw8Dtr558lLG
         VLu19iFr6S8xpe7zDf0YFrkmOex5KSL3qjTiF9MVAWin3RFfSejTvJrecNI7LOGD5FC+
         atdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=isuxaQBSlq+kBirX/kGv7oxM5QTuknPLlFBlCe5nqVY=;
        b=XR0uS5Nqr+SY7ON49QY04RNOa9kAYOfkyrvx6RYAtNK6rzH8BM7f2ccDBy8vLW/R17
         fV/WeZQer1Jrf/qb8kJ1r3ZHVfEcgHF459BKuLIOkWjo5bsbPtSM/ffwJ2jStJ9jjxUg
         uXRHeoBhIp9y0o+dpow9CED5N7iXPNyYDn9PD2iwzeAs3pOePC+E0pwF180UywCEehsI
         raITAvOoKyqg6aGiuojLu9yFBYbnMAZvTt/2BY6OjDZyRuGlDMsK+2Qfu77Ht4iRxy69
         U/SuGaXeuP2odRLghqYvg6sdlnb8/lPUXaJIsHtT54F2smDy5eD4dwMC/oNuaiStt1Oo
         7SlA==
X-Gm-Message-State: AOAM5332o9vUxVQHao/mbBIF0sjCTJE/90awnJAOYBv0ID+nebk7kcwj
        ajCMHzt8b36vDLgDE5N6Dzhd1B/IPx4=
X-Google-Smtp-Source: ABdhPJyXPqhupOpAsjZ1q3fWsHm9Ft9Db5AZZUvMPf8+IKPrgy4YMTnErdYABaBzzrFy8unrjcKODg==
X-Received: by 2002:a17:902:d510:: with SMTP id b16mr704358plg.89.1644870170647;
        Mon, 14 Feb 2022 12:22:50 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id b20sm18665963pfv.31.2022.02.14.12.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 12:22:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Feb 2022 10:22:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V2 5/7] block: throttle split bio in case of iops limit
Message-ID: <Ygq6GanKSLlTixqe@slm.duckdns.org>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
 <20220209091429.1929728-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209091429.1929728-6-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Wed, Feb 09, 2022 at 05:14:27PM +0800, Ming Lei wrote:
> Chunguang Xu has already observed this issue and fixed it in commit
> 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO scenarios").
> However, that patch only covers bio splitting in __blk_queue_split(), and
> we have other kind of bio splitting, such as bio_split() &
> submit_bio_noacct() and other ways.

I see. So, we can go for adding split handling to all other places or try to
find a common spot.

> This patch tries to fix the issue in one generic way by always charging
> the bio for iops limit in blk_throtl_bio(). This way is reasonable:
> re-submission & fast-cloned bio is charged if it is submitted to same
> disk/queue, and BIO_THROTTLED will be cleared if bio->bi_bdev is changed.
> 
> This new approach can get much more smooth/stable iops limit compared with
> commit 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO
> scenarios") since that commit can't throttle current split bios actually.
> 
> Also this way won't cause new double bio iops charge in
> blk_throtl_dispatch_work_fn() in which blk_throtl_bio() won't be called
> any more.

But yeah, this should work too. This is simpler but more fragile given the
twisted history around BIO_THROTTLED. I think the root cause of the
convolution is that it's hooked at the wrong spot - it's sitting on top of
the queue trying to guess what actually happens to the bios it sent down.
Ideally, we probably wanna move this to rq-qos hooks which sit on the actual
issue-to-the-device path.

For now, I don't have a strong preference. This looks fine to me too. Please
feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

for the blk-throtl patches.

Thanks.

-- 
tejun
