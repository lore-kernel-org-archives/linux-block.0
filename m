Return-Path: <SRS0=nGPF=IF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD982C433E0
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 12:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8717C64F5B
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 12:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhCGMmk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Mar 2021 07:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhCGMmO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Mar 2021 07:42:14 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6373C06174A;
        Sun,  7 Mar 2021 04:42:13 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id j3so5515205qtj.12;
        Sun, 07 Mar 2021 04:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=smwItFStAw2FtnRO67mrz+LuQfkFcEUy4rxR5vsice4=;
        b=HqvlNSPlTpnF1T1pbvcs/NlWD2/M7xxvBqYSXKYiI0ske0qyx/geIPvUsrpQ7NGJHc
         eposLSbF8hFwEE7OoGY2riiq1hHI9z4LEceQCzROV5eFE3GBBn/KKCDcmv6C5pdre4kt
         0M6lm+WRjOTz9UBbe5lBVRH6nNwa95R+JN+19cVdsHsd3nCFPhOZJZeyS2H54+zt9xta
         2JgmKy/pWzmada/P1A2XLphi37kOYks3AUI0NE1YnzSQOfTo7R/bqcQRz9A/4AaGT/1d
         2RqphfMZdOM7PQ8BS3/QHvkscAMBOyiNFhYVm8Qrl/mVNPILYpaHMi8e/zGNTLLV4UOl
         DGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=smwItFStAw2FtnRO67mrz+LuQfkFcEUy4rxR5vsice4=;
        b=lU8EUiLzJXPW7ABaM9w1ogm+i5OAseaqT3u2reGrY5kNFVPl8PI1ScfV8DbiD3mboQ
         7jRbJ91war8/Eetlvo8ZFZkGC8H9pQvoHEpp88scR2xbIlFMSZ7xfb7BSDSnbgwa9OiL
         uvXPluiY1NBQt6jXSAK+mYX/JG1CGGjQZysQwlzyqHWzxB5nJqAcJUyyslEkoftEa8+g
         ONb2cteFvR4JySdwzs47bldFCKKcWZ80WzjTyWahfFbCGfmiYSy7zP5/QyYzgCABXx1D
         23xq+i54BhjugQk4iG2i2NFHRwvrPZUfmJYpGgWn/Kh4Fo56y12uDRH+1AUfU9liCi1c
         Hlqw==
X-Gm-Message-State: AOAM530oV7ZydMGN1cuhKFd4rjvvdjy7j3CJxWH+SdGzWAmsPE+SC3bw
        IwAyG4uyQdePWHrhZF8RQyK+/KW3cUIIIg==
X-Google-Smtp-Source: ABdhPJxFbT+ahKVycU44uUY132TTAvnHn+vcZG9NL/rZ51kpo87KdK3JJvTCmL/Fe3b+ksZB1KYdKA==
X-Received: by 2002:ac8:57d1:: with SMTP id w17mr16970178qta.124.1615120932819;
        Sun, 07 Mar 2021 04:42:12 -0800 (PST)
Received: from localhost (2603-7000-9602-8233-06d4-c4ff-fe48-9d05.res6.spectrum.com. [2603:7000:9602:8233:6d4:c4ff:fe48:9d05])
        by smtp.gmail.com with ESMTPSA id a2sm5054332qtj.76.2021.03.07.04.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 04:42:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 7 Mar 2021 07:42:10 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: Fix the recursive blkg rwstat
Message-ID: <YETKIo2iZpcd08Zk@slm.duckdns.org>
References: <1614932007-97224-1-git-send-email-xlpang@linux.alibaba.com>
 <4cc104d1-9aa3-a838-b786-9a808dd85945@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc104d1-9aa3-a838-b786-9a808dd85945@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 05, 2021 at 11:32:05AM -0700, Jens Axboe wrote:
> On 3/5/21 1:13 AM, Xunlei Pang wrote:
> > The current blkio.throttle.io_service_bytes_recursive doesn't
> > work correctly.
> > 
> > As an example, for the following blkcg hierarchy:
> >  (Made 1GB READ in test1, 512MB READ in test2)
> >      test
> >     /    \
> >  test1   test2
> > 
> > $ head -n 1 test/test1/blkio.throttle.io_service_bytes_recursive
> > 8:0 Read 1073684480
> > $ head -n 1 test/test2/blkio.throttle.io_service_bytes_recursive
> > 8:0 Read 537448448
> > $ head -n 1 test/blkio.throttle.io_service_bytes_recursive
> > 8:0 Read 537448448
> > 
> > Clearly, above data of "test" reflects "test2" not "test1"+"test2".
> > 
> > Do the correct summary in blkg_rwstat_recursive_sum().
> 
> LGTM, Tejun?

Gees, that's horrible. Thanks for fixing this.

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
