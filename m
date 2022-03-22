Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B1EC433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 16:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiCVQoC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 12:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiCVQoB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 12:44:01 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015786EB17
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 09:42:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p8so18616948pfh.8
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=77c4xILzf/O00pDaLTDmZgC4aNmAhlF3RL33aO3F4a4=;
        b=lc9wIww+iqd9yRifTVNIikXX0idz5SPU5xDg4MPsZl5o0XVefwGr7RkmL2NNYDyt2R
         XueWwScCixMFdNbj0BrOUDFKHr2nu9VE+EHtRl5sHasNzf5+VBK4LB186EoNZJ2MTgZb
         GjH3bWi9fzSoELRHEtArtbTS0hQntBFk9mXb+wauNY7V6KluG80k/GbU7tomvJAe61/c
         /iL5EzWWHnjUseHlKPzApBIsYI8Klmtktdc5CPpYo5I6GAUoP3qzkFD1aWNMgVdmUznA
         yhEgUBjatg+4bPjx3Kv63jSl4Ds/aXiy2CLV4xs1y2DURx+sePYYRDFwwTfg8hjBIVrC
         swpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=77c4xILzf/O00pDaLTDmZgC4aNmAhlF3RL33aO3F4a4=;
        b=Y3Tn6P+GptZQcRyEPLOliN5vEl2/mGVfi/C8ShpuPYUoYIqGNoyLjtVvXRbtNBzzP1
         QPfVcPLvY/iWgwujcW0nWPjQMyb6abQ0/zQdAxz8MlfFViBTh1I2gAh0hceKiGytyPKy
         roJECS1y4tPllrtZPLtSh6HNDtQr6JEKXDynW1m9Vh4H4JSC5VhLVXgwU3KuI6Zu9RMm
         Yygh41CFIx6ge+lp8pwRcb7LxAzfUqeJSwuhknxkv6s/EEu46qP9T2HWaCanlJlg8kWq
         O5LCpRYEW1yQy/Mk7AUv7mJ2w2zus5st+o3WMqkLfIlCj2WqBqo2Fn68guUyKjAdU4hE
         yfRQ==
X-Gm-Message-State: AOAM530o/YAosxlxwSw6j/gEoFTqRzYv3ggv7gIjpRtn83BMc/2ISwID
        1Y86QLRPX2TVjYiA3xYBULM=
X-Google-Smtp-Source: ABdhPJxidIdokSw6r99a1SUutfqNk/r+r9XmHmQFTNiJ3Ib5yUgD3UcQpXSJu9bHpbIE6VPNcJP7EQ==
X-Received: by 2002:a05:6a00:1254:b0:4fa:874e:1319 with SMTP id u20-20020a056a00125400b004fa874e1319mr16220326pfi.14.1647967353378;
        Tue, 22 Mar 2022 09:42:33 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id f14-20020a056a0022ce00b004fabe9fac23sm3136035pfj.151.2022.03.22.09.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 09:42:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Mar 2022 06:42:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: avoid to call blkg_free() in atomic context
Message-ID: <Yjn8d6t2gIBcDMUJ@slm.duckdns.org>
References: <20220322161238.2006448-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322161238.2006448-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 23, 2022 at 12:12:38AM +0800, Ming Lei wrote:
> blkg_free() may be called in atomic context, either spin lock is held,
> or run in rcu callback. Meantime either request queue's release handler
> or ->pd_free_fn can sleep.
> 
> Fix the issue by scheduling work function for freeing blkcg_gq instance.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Fixes: 0a9a25ca7843 ("block: let blkcg_gq grab request queue's refcnt")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Do you have an example of this being a problem?

Thanks.

-- 
tejun
