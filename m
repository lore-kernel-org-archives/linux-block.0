Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E110EC433E2
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 15:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB4EB208C9
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 15:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NB6uIKvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgH1Pw7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgH1Pw5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 11:52:57 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6786C061264
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2020 08:52:56 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g128so1795600iof.11
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2020 08:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=67iGeru2Nm3suBTPnQQ0jShu/5WUaz/+SXMAZ3RkW0w=;
        b=NB6uIKvsmGYQ8d2RFJjr7P7HFGdF1FLVCcQlbe4LF2xzigaChYRwhJeJbn08xpsGBf
         4qQLDfC++wmZvJdIYvmKzYQD5tZew9p9ppQJvK9rs5wh2lxvV/pFP8GqtriFJShLHBky
         tRFmW16KiyJr1GEWxJCi9jiTr1Z95SmcE73BP2W6qo9Ydli7HeBP3os3ntD6/yvKSj2C
         fySg4Tfwt8R6ucue5yELi91LrMn5wA2vGlO0abicPjXFLpsCGLZ68InlP4rdjNMJ+BsC
         HPIjLzbgVF1bNPIo4SHZYRHI3ONRUVZP8FPRoJpBpck2OLBs3/JsHnl66kQxk+9cJl12
         RMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=67iGeru2Nm3suBTPnQQ0jShu/5WUaz/+SXMAZ3RkW0w=;
        b=o1+Q025VyEt9bIEvd+Ki15pKZ/suis/MCaIYb6y7ds9y7iQzaeo7hVmx81Vqn4hCvD
         0B7KiNxVjheHFEkgkESkSzF5LqtjUYwGv3iIh/aALF/uQXhYrUGbyrXZmzzYCTQmOC28
         yJNRU3pIaP4NgKUtZDDWgS2vz5BALLQRvTzr1ukEM3o7q7JhVsPLe7g1ZC4j+2VyYLQm
         Ay6RXIlUPMwu/MM1TFPQYpEr+MAvB/F1NsKM6RZE5/fJGl1nvIKulnbKGSJci7xcfKtK
         ke9T0h6PYgZIHO10ZbqjVrEgk0LGbDGodLimnpYUsRS17DLlpw+9JSqPE6h/KTnXze1p
         1EfQ==
X-Gm-Message-State: AOAM532lpQC5O9G/14ody5WvfmqRslKuvkGTP21vxIRM9HYXgvVXb6Hz
        p9kjQZJCLJZyjS2X2PUoQg79QNy5Ere44luF
X-Google-Smtp-Source: ABdhPJy6to3zAwxT+tEhvq47JVccT3PFrRB+ViwJaf6x99D4RL9xpAHcoSsw0UfOT8z69B4ILEdjZA==
X-Received: by 2002:a02:82c3:: with SMTP id u3mr1767081jag.81.1598629975838;
        Fri, 28 Aug 2020 08:52:55 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k18sm742370ils.42.2020.08.28.08.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 08:52:55 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: Return blk_status_t instead of errno codes
To:     Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
Cc:     linux-block@vger.kernel.org
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
 <1596062878-4238-2-git-send-email-ritika.srivastava@oracle.com>
 <20200814062620.GA24167@infradead.org>
 <C6F86C38-BE29-422A-8A57-5144E26C4569@ORACLE.COM>
 <de5c94ec-9079-22b7-bbcd-667f3b0fe94e@kernel.dk>
 <A0A0C5C0-957C-44DB-9B42-3EEC473D74C6@ORACLE.COM>
 <3C0C6E56-ECEF-457A-89A1-0944E004DC77@ORACLE.COM>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d5c2818f-ed6e-e8ff-709d-ecc4858ff4de@kernel.dk>
Date:   Fri, 28 Aug 2020 09:52:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3C0C6E56-ECEF-457A-89A1-0944E004DC77@ORACLE.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/28/20 9:52 AM, Ritika Srivastava wrote:
> Hi Jens,
> 
> The two patches apply on branch block-5.9 in linux-block.git
> 
> I apply the patches using git am xxx.patch.
> 
> $ git log --oneline --decorate -n 5
> 4d8e990 (HEAD, block59) block: better deal with the delayed not supported case in blk_cloned_rq_check_limits
> 9a8a3d4 block: Return blk_status_t instead of errno codes
> a433d72 (origin/block-5.9) Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.9
> 6af10a3 md/raid5: make sure stripe_size as power of two
> 79e5dc5 loop: Set correct device size when using LOOP_CONFIGURE
> 
> Please let me know if I missed something and should test on another branch?

It doesn't on my 5.10 branch, but I haven't pushed that out yet so can't
really fault you for that. I'll get to it in the next day or so.

-- 
Jens Axboe

