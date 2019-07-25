Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71964C76190
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 20:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB472190F
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 20:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf9ynE3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfGYUDs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 16:03:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43016 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfGYUDs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 16:03:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so23548561pgv.10;
        Thu, 25 Jul 2019 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i7HKiq/WRQz0iWC9yLf6vBbDqvnWRhx/n8XJNQctoPo=;
        b=Bf9ynE3UDgxm+Zv/OCeEt0hGTZlFH9kWNuDrIjMNRKazUpHigok5aNmkyRntw5dwZo
         pvUV79f6rYQ6mCBOGFzlOCWHteiTwzF8wshenVMnuq4w58dgiOZIZSMB2G0xy1iC6mnP
         WFIlvc1QaoQLbi5N6R9ezEXpMKYn+sBte0RsUegRQNms7gXlCn+R781ZcOy9GfjaLmOv
         r27JY6BJWyUG00cXHWw8+yCY9iWtTdb7F+q5+BmMLG7SMINGlgK9oRKN/TwOhd0WF6mk
         PJyxuba3I4JDLOpT0b2XBWVOP98Cb8eA9/Q6eIKSe8+RHDO7jSQ2oFevbErk6CMOk26G
         X5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i7HKiq/WRQz0iWC9yLf6vBbDqvnWRhx/n8XJNQctoPo=;
        b=SSjivrCyqu9RsE8gGLVZdhOVOBooXms7cits+6eZIrfKvGFmp12bQTUVRkYu0PUxX5
         V8PHTcbyluxWevklyY9Rnu/ReyATp0+3CMY5/ehFBSFMuFyPwBRTDgsmVlVbnBu8SGIi
         GlIweuviyAuHhs2tGXo6plhVCLTo8Qa2pU5f1jIwbqKCxOJVMMZTSlsP2TJ9JUtoHhiz
         V77/mHasSUCDFZRtJ9q+g+RWg1JPlXMbPe70W8iempLHf62vqQP8/qrl4H6fzlM/R14g
         dBGf1d0rkJ4NxSug/HWa8WYuMgww/VmF7hxtZJZNo5eZ0zP4h4l5GPP1iOeUrg7PnmXb
         J8qQ==
X-Gm-Message-State: APjAAAVD7QAu8cLxw5rM/htVGnf46PUl1l8EiluqbTBnw8e+T4+m3iyI
        avQlpECBay2Ff/xB7Rc2WnZ58dCFgng=
X-Google-Smtp-Source: APXvYqxOQb+pjaW/NNI6FKmYDbf4JjFnZFJz2vIPuOgex0YMNmWgGKTQsnWEaV7W3FG2p1b/4JA+zA==
X-Received: by 2002:a63:f857:: with SMTP id v23mr62941932pgj.228.1564085026955;
        Thu, 25 Jul 2019 13:03:46 -0700 (PDT)
Received: from continental ([179.185.209.0])
        by smtp.gmail.com with ESMTPSA id a3sm50666740pfl.145.2019.07.25.13.03.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 13:03:45 -0700 (PDT)
Date:   Thu, 25 Jul 2019 17:04:34 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/4] Remove elevator kernel parameter
Message-ID: <20190725200434.GA16459@continental>
References: <20190714053453.1655-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190714053453.1655-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

there are two reviewers for this patchset, can you take a look?

Thanks,
Marcos

On Sun, Jul 14, 2019 at 02:34:49AM -0300, Marcos Paulo de Souza wrote:
> After the first patch sent[1], together with some background from Jens[2], this
> patchset aims to remove completely elevator kernel parameter, since it is not
> being used since blk-mq was set by default.
> 
> Along with elevator code, some documentation was also updated to remove elevator
> references.
> 
> Please review, thanks.
> 
> [1]: https://lkml.org/lkml/2019/7/12/1008
> [2]: https://lkml.org/lkml/2019/7/13/232
> 
> Marcos Paulo de Souza (4):
>   block: elevator.c: Remove now unused elevator= argument
>   kernel-parameters.txt: Remove elevator argument
>   Documenation: switching-sched: Remove notes about elevator argument
>   Documentation:kernel-per-CPU-kthreads.txt: Remove reference to
>     elevator=
> 
>  Documentation/admin-guide/kernel-parameters.txt |  6 ------
>  Documentation/block/switching-sched.txt         |  4 ----
>  Documentation/kernel-per-CPU-kthreads.txt       |  8 +++-----
>  block/elevator.c                                | 14 --------------
>  4 files changed, 3 insertions(+), 29 deletions(-)
> 
> -- 
> 2.22.0
> 
