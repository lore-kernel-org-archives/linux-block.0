Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58877C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 20:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiCVUNQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 16:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiCVUNO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 16:13:14 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3273765172
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 13:11:46 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id r127so14838611qke.13
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v00bZ5/GrtJkHwEVsUd7zi7yA5VU4pS81+ixMGyiNzw=;
        b=t+zVhg/8DWIoJ9+TtqA9MfYhQixNsuvDLGpv2FtmuHR13aC4IiMRykbt24V7fLjGf0
         KIp2nF82eLjNJn28YsTWtPDfhcIaeQ4w21KrccvrBOa9CmL6MRroZq2Me3AE1FTNQVoA
         UjWD1Wt+diwfRBF/jNshIDtN0nzoIK3pD2E1+x64Qn1Ct1NyY2TOlZNC0nDppzi2+MLT
         +9j0GwAgchYoFywDRL4PUiopvWmZSd0jAPkFiglav9xAvzA6+mId1xcPZnVm8vfGicTp
         cuUpL4VSxX0aN/KYHdyZjA4pBjttMlcN6fP50/DO/FAPZyZDsf8PwH+7JF3AGii+1ZL9
         s5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v00bZ5/GrtJkHwEVsUd7zi7yA5VU4pS81+ixMGyiNzw=;
        b=y0Q6TjhldT/TWzEQ5BJRk5iPX6lhQvaBxugQOmpMYcyonPoDABj3YJEjUsZXlKSeTJ
         VfAc5IaMh7leoConOKTx43wy4opU64f3KKDs9kpBNP5jYPLQ9IuAHZrdgEvy5QE15EY+
         PjY6ZFLijN+IEl3AfUyyZBKQN3P8LgBAKw4QvdAnmfiYXvnvHtpS5Kp9nf2uINoVmOVf
         NBw9mGKVOJnGmylfKl8mvThUKgUsMxEuPRS5H5/BjK/YjNefxy/zkabvifU1rY3ezUZg
         2FMjW5UgcV+vl5wNGUBsKF3KUBfLtSppk2YKnFh5zyGy9w8zIqW5fBYOXIhgmna3aRPO
         wi9w==
X-Gm-Message-State: AOAM532ZFv7o52mb0psEjD3TU2WFWSF66a9ugo/ciggf0ufX8JA6R2Dj
        6oOQ+6ZclQwmgvoBFnT0xDZbqg==
X-Google-Smtp-Source: ABdhPJw2EzkiZtzBMvlZNpbdB92S79Fvr6YfPQrZJ+/2xT2gVC35TkQhMhJqaM4L+dUFXDBlTAKjmg==
X-Received: by 2002:a05:620a:200f:b0:67b:3fb7:8784 with SMTP id c15-20020a05620a200f00b0067b3fb78784mr16519494qka.336.1647979905206;
        Tue, 22 Mar 2022 13:11:45 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a16-20020a05622a02d000b002e20e4bf4aesm7517324qtx.23.2022.03.22.13.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 13:11:44 -0700 (PDT)
Date:   Tue, 22 Mar 2022 16:11:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     axboe@kernel.dk, bvanassche@acm.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
Message-ID: <YjotekJZcSvwoZhp@localhost.localdomain>
References: <20211227091241.103-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227091241.103-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 27, 2021 at 05:12:41PM +0800, Xie Yongji wrote:
> The rescuer thread might take over the works queued on
> the workqueue when the worker thread creation timed out.
> If this happens, we have no chance to create multiple
> recv threads which causes I/O hung on this nbd device.
> 
> To fix it, we can not simply remove the WQ_MEM_RECLAIM
> flag since the recv work is in the memory reclaim path.
> So this patch tries to create kthreads directly to
> handle the recv work instead of using workqueue.
> 

I still don't understand why we can't drop WQ_MEM_RECLAIM.  IIRC your argument
is that we need it because a reconnect could happen under memory pressure and we
need to be able to queue work for that.  However your code makes it so we're
just doing a kthread_create(), which isn't coming out of some emergency pool, so
it's just as likely to fail as a !WQ_MEM_RECLAIM workqueue.  Thanks,

Josef
