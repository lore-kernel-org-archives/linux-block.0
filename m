Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A43C433F5
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 17:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbiCRRQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiCRRQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 13:16:40 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE36109A4B
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 10:15:21 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c2so5457958pga.10
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ystcA4B3mHB5Z3FwtKwTfWX10Trcdze+0Et6HW2D85M=;
        b=SxVR+sA6ZnvWSD4toPD0ajFWkexni3qfdqqNMk63XYNFX7J3HzLMnCnEu/JdajCaQL
         wry6evgPNwHF4uAZXzJN1JgvA07Aa1K5QrYyK6esner4QTkH8xcvvrwwQOJF9b3tzvtQ
         Db/xwoP0rwK3hP7aDM24+cMTX6NwKxKTYG3LwryVsEBvYhorhr5rXoOPpqSl3OifGPGO
         JYB6+XiRYqUifQpypAYYe63f1nrBjcGJpvBwfqRsuxL+T0I1+1Xp1YREWzYR6wegZmXM
         hXNrxnJjSdqb21GVVozBgvimL47iUULMyOCYePxKsCyeUBBp6cKPEoHkaSWcE9aRnQzv
         pg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ystcA4B3mHB5Z3FwtKwTfWX10Trcdze+0Et6HW2D85M=;
        b=TWNqjBgts+QbqIrCFv84CedCGvkC6VJ7YzUwA9MVN41hoH8eWZV0IIJnA7pVL7JL6x
         MEASwEc3ExFKjLF+Zjf/jznU0kujeX2rJawL1JLYhu71kZ9fDFgnC5r2nex5G/+ZoDDZ
         J1tj+Ew4a4pLl46y2IUnGSLRUkY8FFzCHUVSU2zTIToSJE+EqqIVfUktCXZF9DuyVZhf
         2HO7cgCbFc55t+zl9vR6peDwGMP/82Tjww3/ZWJLZ6ErS84+BHQ2j7+fPhsOgknAHnu5
         Texixx6E5qEPh2Qr5Lk4eAagXt08Do2rHROTzU0AXuO82qV5w8/G/6YkGn5OOlsZUcyq
         ObuA==
X-Gm-Message-State: AOAM533BZhmzi1nhi9pB+t/sMvkR587OdvFzhxrvR5gfjzKYnr6DZDjB
        8EMkSX94NPECdXJ/sYE8FAc=
X-Google-Smtp-Source: ABdhPJxcyxJwwlG3GL9h1JxoEhpRaS8DNS199FpBG5h2efTzhyIELUZcVjxmwqlGel27lwvPVEGWeQ==
X-Received: by 2002:a63:5d62:0:b0:381:eef5:c9d6 with SMTP id o34-20020a635d62000000b00381eef5c9d6mr8560560pgm.412.1647623720777;
        Fri, 18 Mar 2022 10:15:20 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id oa12-20020a17090b1bcc00b001bf430c3909sm13536656pjb.32.2022.03.18.10.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 10:15:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 18 Mar 2022 07:15:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] loop: add WQ_MEM_RECLAIM flag to per device workqueue
Message-ID: <YjS+Jr6QudSKMSGy@slm.duckdns.org>
References: <e0a0bc94-e6de-b0e5-ee46-a76cd1570ea6@I-love.SAKURA.ne.jp>
 <YjNHzyTFHjh9v6k4@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
 <5542ef88-dcc9-0db5-7f01-ad5779d9bc07@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5542ef88-dcc9-0db5-7f01-ad5779d9bc07@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Fri, Mar 18, 2022 at 09:05:42PM +0900, Tetsuo Handa wrote:
> But since include/linux/workqueue.h only says
> 
> 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
> 
> , I can't tell when not to specify __WQ_LEGACY and WQ_MEM_RECLAIM together...
> 
> Tejun, what is the intent of this warning? Can the description of __WQ_LEGACY flag
> be updated? I think that the loop module had better reserve one "struct task_struct"
> for each loop device.
> 
> I guess that, in general, waiting for a work in !WQ_MEM_RECLAIM WQ from a
> WQ_MEM_RECLAIM WQ is dangerous because that work may not be able to find
> "struct task_struct" for processing that work. Then, what we should do is to
> create mp->m_sync_workqueue with WQ_MEM_RECLAIM flag added instead of creating
> lo->workqueue with __WQ_LEGACY + WQ_MEM_RECLAIM flags added...
> 
> Is __WQ_LEGACY + WQ_MEM_RECLAIM combination a hack for silencing this warning
> without fixing various WQs used by xfs and other filesystems?

So, create_workqueue() is the deprecated interface and always imples
MEM_RECLAIM because back when the interface was added each wq had a
dedicated worker and there's no way to tell one way or the other. The
warning is telling you to convert the workqueue to the alloc_workqueue()
interface and explicitly use WQ_MEM_RECLAIM flag if the workqueue is gonna
participate in MEM_RECLAIM chain.

Thanks.

-- 
tejun
