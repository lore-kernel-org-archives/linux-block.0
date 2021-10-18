Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90BBC433FE
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D6461212
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhJRX6D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 19:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhJRX6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 19:58:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87055C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 16:55:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s1so10588658plg.12
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 16:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+LEQ+tebO6ATn4tiHRUJvzNAZiN6hFiHNtKZ2lhn1ko=;
        b=HeeVbqaIDPd56hEMsRVcJbTyAPqIdRLjylODoXjY9vMIu40XRnyzvfM8BW1mWZxwaN
         XTcTk0YWkrJwcy4bNbyUdjcfcaBPIeseIIzOtFfhlqeJKkSxb9mCtXJEciZJ2SGZ0iJb
         Ig1Ld9mZDGGLshwE16AOQHqzcZJwsUPZTe2R4jKwrSV52kl9cMjpM5ONVCNDPhJZp7y/
         kagGo87Au6FNWg24D97g6P67sNXGpW5veVlUvyS0cpiOtiCXOBHDxk7vz+1SpVW+omOq
         IOEdxRNNwpaG6MX2co1lvNABTbGY+BlgnkV2rOZBrFmR0DJhFV6AgjbMNrhB3B5SULC/
         eUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+LEQ+tebO6ATn4tiHRUJvzNAZiN6hFiHNtKZ2lhn1ko=;
        b=Q5hgBxmpVCFi8XU9k7h5lvxII+6V9sPGO3os1tBtz2HtrXRXHtIShtjTEnhDC+I+yO
         9wWY5yWA5Py8FL+l0UQnAeKYWkBXAYLA88jQcEL+vAcur7BOvOz5OpLwf2RMId4APcmZ
         DAFfldIBwiUOnRdmM0zBuqJC+oI/W7qt+yCZh/4Yz8SgeQe7UaOyqd4u7o/rlTVBq7Xz
         uEk+RLIHLoduNXDwTvMln0skDrhhAv0Bv+5lKjlQX3c6RwXW0ZkSPIiVSe53r3noaAjr
         M/KwAOFTRfVj3poLfAE2+beONpbGQOlGGow0XAJWS8h+RVTgi8ctQXG+idhb3erTkRr8
         GVvA==
X-Gm-Message-State: AOAM530w2KAQvGm+XFo3xgTC7noQ25O4OUWLaFHJEh2pv+NrHeOTg7Lk
        BASos7E3cF65PPbG8fBtDbcY7OraEALDdw==
X-Google-Smtp-Source: ABdhPJyx1HIPXWmqahtD9u6xSMJ2yEce+hfDoyEbK5Yg/X752xKJqAzrs4ARzaIWpYv5OlgP18JqCQ==
X-Received: by 2002:a17:90b:4c86:: with SMTP id my6mr2369535pjb.203.1634601350874;
        Mon, 18 Oct 2021 16:55:50 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:b911])
        by smtp.gmail.com with ESMTPSA id t1sm14088911pfe.51.2021.10.18.16.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:55:50 -0700 (PDT)
Date:   Mon, 18 Oct 2021 16:55:48 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH RFC] block - ataflop.c: fix breakage introduced at blk-mq
 refactoring
Message-ID: <YW4JhN/oin89P+TC@relinquished.localdomain>
References: <20211018222157.12238-1-schmitzmic@gmail.com>
 <8d60483d-3cd6-5df7-8db6-7a8b9ce462e3@kernel.dk>
 <791e1173-4794-a547-2c84-112cc6627a1f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <791e1173-4794-a547-2c84-112cc6627a1f@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 12:35:27PM +1300, Michael Schmitz wrote:
> Hi Jens,
> 
> On 19/10/21 11:30, Jens Axboe wrote:
> > Was going to ask if this driver was used by anyone, since it's taken 3
> 
> Can't honestly say - I'm not following any other user forum than linux-m68k
> (and that's not really a user forum either).
> 
> > years for the breakage to be spotted... In all fairness, it was pretty
> > horribly broken before the change too (like waiting in request_fn, under
> > a lock).
> 
> In all fairness, it was a pretty broken design, but it did at least work. I
> concede that it was unmaintainable in its old form, and still largely is,
> just surprised that I didn't see a call for testing on linux-m68k,
> considering the committer realized it probably wouldn't work.

I recall cc'ing some people that I hoped could point me at the right
place to test this, but I don't think I was aware of the linux-m68k
mailing list.
