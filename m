Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123DDC7EE23
	for <linux-block@archiver.kernel.org>; Thu,  8 Jun 2023 23:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbjFHXKN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jun 2023 19:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjFHXKM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jun 2023 19:10:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404B12D7F;
        Thu,  8 Jun 2023 16:10:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d44b198baso895995b3a.0;
        Thu, 08 Jun 2023 16:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686265811; x=1688857811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4FKiEuTY82YAx8X30F4eHfJTbH8o0Cttt9EczZAL3w=;
        b=JxuHQgmGloQy0UG4WmE9136U+ix/yoFiPKDYVh5C5OqVHTkn0nAgHFVQkYGeAj1/Ej
         3LrhJY1K0zI8Fam6cCMvU2tjj0phKzecZLqls0c0BseELUEUF61VIb7TUdheqS2WzqCY
         dSAEUSzqP3VDbCOmJXA9Mq0p7bC2nMIePzk7GXLGE3vgsucTddpMLd/bp/u5G3eNBHCn
         cN7TxomenxlZ5Qq49AVHwmD2yrS8RseKgcCuDo68Ll0IRca4dMUW8GRvKjHcymbLfXp1
         ZG+4gZMZo1zvKpwA7lpgBNq8DtUY7gRB8zjMIgWmzGXynqmhLo3TfZFZOChqMiZfb1x0
         CbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686265811; x=1688857811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4FKiEuTY82YAx8X30F4eHfJTbH8o0Cttt9EczZAL3w=;
        b=D2Lc4iVv2fAULjGOKnzeBRHyY4bmgaq1hkU8Kg/b07GKw5oWZBZLyzCwKGz/h4nDhk
         TLp6yC9q08CUoCEBqEq5SETBMhlwrHOVVT23RUbPDbgoFAh3A0IplxldemW0RyLQnmkC
         IE77li0WjE1etvp3/epYYMKdITV3g7qNLXNnsEVFmWivD+d5VAHX5tSRTqVO5xBaF4Xd
         erAIvK6vjU2ZI/o0oRqJgD+3MDLMeuNhcJ7Srn5TJmfAZ/fAyvYI1juVdoE5QVisaMbS
         3Io7j80a1MbAyY3ucL2UTHoOHyv9qrX4ZtHADayk8gtO2nbKC2X5nnjy6f7+xJKE4MAl
         Iz7Q==
X-Gm-Message-State: AC+VfDzFojhe9c2LI6tUs9XBibSA/Qe+3RMvaKDDzPmrN1T8UKHk7YyB
        MlHqsICgaAsSD6lD79QTIuc=
X-Google-Smtp-Source: ACHHUZ6K9VCTFcMLBRjQIz8O1sq6dZlmJLKUuquIhY6b+HKX49rqri5Fnd4NmviM1hmWkcdUPct66g==
X-Received: by 2002:a05:6a00:24c4:b0:64f:f478:2294 with SMTP id d4-20020a056a0024c400b0064ff4782294mr185298pfv.0.1686265810191;
        Thu, 08 Jun 2023 16:10:10 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id a15-20020aa7864f000000b0064fe332209esm1592972pfo.98.2023.06.08.16.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 16:10:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 8 Jun 2023 13:10:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>,
        Waiman Long <longman@redhat.com>, mkoutny@suse.com,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH V3] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <ZIJf0hBOB89II79Z@slm.duckdns.org>
References: <20230525043518.831721-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525043518.831721-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 25, 2023 at 12:35:18PM +0800, Ming Lei wrote:
> As noted by Michal, the blkg_iostat_set's in the lockless list hold
> reference to blkg's to protect against their removal. Those blkg's
> hold reference to blkcg. When a cgroup is being destroyed,
> cgroup_rstat_flush() is only called at css_release_work_fn() which
> is called when the blkcg reference count reaches 0. This circular
> dependency will prevent blkcg and some blkgs from being freed after
> they are made offline.
> 
> It is less a problem if the cgroup to be destroyed also has other
> controllers like memory that will call cgroup_rstat_flush() which will
> clean up the reference count. If block is the only controller that uses
> rstat, these offline blkcg and blkgs may never be freed leaking more
> and more memory over time.
> 
> To prevent this potential memory leak:
> 
> - flush blkcg per-cpu stats list in __blkg_release(), when no new stat
> can be added
> 
> - add global blkg_stat_lock for covering concurrent parent blkg stat
> update
> 
> - don't grab bio->bi_blkg reference when adding the stats into blkcg's
> per-cpu stat list since all stats are guaranteed to be consumed before
> releasing blkg instance, and grabbing blkg reference for stats was the
> most fragile part of original patch
> 
> Based on Waiman's patch:
> 
> https://lore.kernel.org/linux-block/20221215033132.230023-3-longman@redhat.com/
> 
> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> Cc: stable@vger.kernel.org
> Reported-by: Jay Shin <jaeshin@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: mkoutny@suse.com
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
