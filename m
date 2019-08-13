Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6BFC32750
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 13:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D8420840
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 13:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="J5V4QADc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfHMNOB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:14:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37891 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbfHMNOA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 09:14:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id x4so8214950qts.5
        for <linux-block@vger.kernel.org>; Tue, 13 Aug 2019 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aRc6WIG92MMoU4KEpjKnJq1lVqd4+r21OnQN4pwVGHg=;
        b=J5V4QADcreLQ5NIcg/Lz0ZHy5p9MJsXaxyxryfZSKOrhNZy9q/BQGFsDAiXE+dJoVA
         dzJwV0k51CkvC4FDjdqQHOq6zY9mcJIMOIYRYQUqKmKdnkH3CAQpVNW4ZqJErb60qLVy
         XJoNE0Roy0uk3WZQYPLWBzwzjQ6NWKmdyl2lQ4T5HGMkyg9jcG+4SZDCrR0F9CekK/bx
         AbPPx50/pXZG6mPFpAAoUoIJ3snl45uLcTzR5N4e3PCxlmjgH71Nz2pakB44bEhqdveV
         oG3QK9BxIC8rWWF5Dg0rlvycCTjC6snfGqTLoAXDX74T/1xTAdu7C8wcLiap5JAOKXUl
         tExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aRc6WIG92MMoU4KEpjKnJq1lVqd4+r21OnQN4pwVGHg=;
        b=MpvD8OEb5BAFRLg7OB+g9IMUllNePjBSq98aUqK7k6Xksg/2W7uQdU+8nrns6p78wu
         yYpOMktovhppVeRvNx4AMeo4sUGLwlO7FeUFR6FUu6fYdhkfqFAnSbfuVoWCTL+NtHyD
         WdkdiKL7+/TZPRIaN+wod/Q0pASjXm3aj0jv+s/nHUJ4FOEs2YWQ/8hpFd2Bku/dkQ4x
         thF47WL+Lgf8KNRcAtzd425FJCs6OQ1h8e9vuekJEE8hjgsPQQCwEVV1wiXq1C8fRlAu
         kHLcY73IuDnAik/8ivvwuZ8CW/jkO26LPPOZ4Yjdj70MHN3HO+sBOezVGbdHnbf5o55b
         hEqw==
X-Gm-Message-State: APjAAAWLli8xG16nPZ7woCad32C6VdexOZf/HTBkEnzQsKbZxhwVxXRM
        p1aAMpx1YHI1JrszMF/MuZZwEQ==
X-Google-Smtp-Source: APXvYqxHSoSONu93bJ/rXtNn5vWaMIhPJwMcKOOTcZA2IiCTsbiT6MPZkwXsnLMO3aTAKlJ1N+kAwA==
X-Received: by 2002:ac8:225d:: with SMTP id p29mr25094542qtp.259.1565702039930;
        Tue, 13 Aug 2019 06:13:59 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w5sm1536843qki.13.2019.08.13.06.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 06:13:59 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:13:58 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] nbd: fix zero cmd timeout handling
Message-ID: <20190813131357.dpyd5mqbfubqhiaa@MacBook-Pro-91.local>
References: <20190809212610.19412-1-mchristi@redhat.com>
 <20190809212610.19412-5-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809212610.19412-5-mchristi@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 09, 2019 at 04:26:10PM -0500, Mike Christie wrote:
> This fixes a regression added in 4.9 with commit:
> 
> commit 0eadf37afc2500e1162c9040ec26a705b9af8d47
> Author: Josef Bacik <jbacik@fb.com>
> Date:   Thu Sep 8 12:33:40 2016 -0700
> 
>     nbd: allow block mq to deal with timeouts
> 
> where before the patch userspace would set the timeout to 0 to disable
> it. With the above patch, a zero timeout tells the block layer to use
> the default value of 30 seconds. For setups where commands can take a
> long time or experience transient issues like network disruptions this
> then results in IO errors being sent to the application.
> 
> To fix this, the patch still uses the common block layer timeout
> framework, but if zero is set, nbd just logs a message and then resets
> the timer when it expires.
> 
> Josef,
> 
> I did not cc stable, but I think we want to port the patches to some
> releases. We originally hit this with users using the longterm kernels
> with ceph. The patch does not apply anywhere cleanly with older ones
> like 4.9, so I was not sure how we wanted to handle it.
> 

I assume you tested this?  IIRC there was a problem where 0 really meant 0 and
commands would insta-timeout.  But my memory is foggy here, so I'm not sure if
it was setting the tag_set timeout to 0 that made things go wrong, or what.  Or
I could be making it all up, who knows.

There's a blktest that just runs fio on a normal device with no timeouts or
anything, that's where I would see the problem since it was a little racy.
Basically have the timeout set to 0 and put load on the disk and eventually
you'd start seeing timeouts.  If that all goes fine then you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
