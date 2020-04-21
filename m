Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0497BC54FCC
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 13:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92562071E
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 13:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa3l8piB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgDUNzi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726691AbgDUNzh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 09:55:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B449C061A10;
        Tue, 21 Apr 2020 06:55:37 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v7so14556472qkc.0;
        Tue, 21 Apr 2020 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JdVf9BN3VBYjlAhO1URHy0+Z7z5xubg6gKNXsMj3SD4=;
        b=Oa3l8piBEzFzpUodpAlB8sX2rIFN5rCXcXoK/64lBT5B4WYoVSwHlYi34Q5qywt28H
         cfvMFt9WTY5nAH/3jZaU6gCro5xLxShm8sZTIbJ663fFyYihQBaJ2+KIrIjmiuNvsaZH
         xLXvGjPvLO80jKeV+hYT8pMCUHQ1ECHN+VH4USRvsCwp7x5nC+1YpdZsFWdg6nteG+wS
         TPWaFEd1X/gT+pZzFfJPhG/793rk8haj9S21poT71hz4YSMj3z9lCUchhCA0+yE2LAyu
         +JBhENAXBxxMFHMnxjf4MuOG9FD3Womgna2yC/rHmrY24iXI1lb/8e3XQHAhRKi83BwG
         D9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JdVf9BN3VBYjlAhO1URHy0+Z7z5xubg6gKNXsMj3SD4=;
        b=rPN8vrYPtvaG1PZdBEU07g5ErXvFtkil8SOKvvtKPSW877h/TwNSMqIupkBsgzOmtf
         /5j1ZujVG3ZUlQrH3YkO9TArb62Am5/lL3R1Bj+vBBNBYDDyrCc5v7ZcouO4hwkoMqC2
         wczaEbSzdBM4HsN25t6RAiFbEYRAz4QttIiMbsQCwSBgbwOkzwh/WuTmO2yCL16oRxBj
         hYH3b1ZntMUhTlTebXXu6WzRhGb8p1bf1DSQ7Hki/iU/iGpq8i764PAO98tHVp5V2cNn
         J55ttZ7pY2xFJhsInl8K3X+1lZQBUNi4JAqQ8xQO+ul4LnA6CMuxbo+klA1ReQT4OXuv
         u0Ew==
X-Gm-Message-State: AGi0Pua1MRRxLJjqvyNCKM5Q7y4pljWxlR1w60PXzoeAGY4sn+F+CRNB
        sC1he2TY7hqE5RUU4oCNTGg=
X-Google-Smtp-Source: APiQypInKCW27Sksr2RruGrr84Fcf0glvObAa7VP5aoCxArIj1/PHlvxTm9HsNw6U4bBzMxqrk+G7w==
X-Received: by 2002:a37:b93:: with SMTP id 141mr21368378qkl.192.1587477336425;
        Tue, 21 Apr 2020 06:55:36 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:480::1:6809])
        by smtp.gmail.com with ESMTPSA id g6sm1774808qtc.52.2020.04.21.06.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:55:35 -0700 (PDT)
Date:   Tue, 21 Apr 2020 09:55:33 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] loop: Use worker per cgroup instead of kworker
Message-ID: <20200421135533.GA9623@dschatzberg-fedora-PC0Y6AEN>
References: <20200420223936.6773-1-schatzberg.dan@gmail.com>
 <20200421024845.6948-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421024845.6948-1-hdanton@sina.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 21, 2020 at 10:48:45AM +0800, Hillf Danton wrote:
> 
> On Mon, 20 Apr 2020 18:39:29 -0400 Dan Schatzberg wrote:
> > 
> > @@ -1140,8 +1215,17 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
> >  	blk_mq_freeze_queue(lo->lo_queue);
> >  
> >  	spin_lock_irq(&lo->lo_lock);
> > +	destroy_workqueue(lo->workqueue);
> 
> Destruct it out of atomic context.

I may as well do this, but it doesn't matter, does it? The
blk_mq_freeze_queue above should drain all I/O so the workqueue will
be idle.
