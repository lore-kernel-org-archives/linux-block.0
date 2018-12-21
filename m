Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F19C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 17:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6228A21920
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545411773;
	bh=qPl7/9fq8kgrjSFdwZxRRY0jZwzMjoTD/kEnc9Abbig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VjDcRrS6QAS2z4PpDD8FWsQZjO2NAOkGlzl14BcUSwSvwxvpWe5hsAYMByJuWc/zC
	 sq8vOJQyWHOGI6VhddmzpniyOzL6EZ2JcJPjoliVZ6CC5gvcsTBh0XjWssfAHg5HG2
	 WLpwRTRzBq0UrdEGfpX77cse8Sls0vY3JqSweI+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389835AbeLURCr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:02:47 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40396 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389352AbeLURCr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 12:02:47 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so7454219ita.5;
        Fri, 21 Dec 2018 09:02:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f2S/HUpNrybDo8EwdKrGzEanCsjWjx4bQPRK1gN9MBY=;
        b=qDr++mgo3iurYUnuiZGIBuVbI6kaPtL7Et7S52LODMvs7D1rZszQWPbo0BtCST/i4K
         M6l0t0Cv571hcv83MXM9JXSCShaOsf2l/nH/sD59nT7LWW1g/Gblni4l2VHTLj2+C1cG
         wTPICcubP8AjIR1Hjo6N7x3vn2tNgH0TuRhnGzahe/MyCJyYK8pf8/ZoZL276nUhyMce
         vI4n7abfB3/iMR2KFednlvL5/7lTam19AglzN08SQdmcW0AeMPWkRjfjUsYHI9CDkjCu
         egGlXH1MMj9VEkaUit4eoKY6T0IbzFpD20VfTk/zUWre4OfEfmGk1/f2OMuSzkNQJzI1
         aKvQ==
X-Gm-Message-State: AA+aEWZvYfx9Uvqu+j+K8pU0UhJeIKmzW2AaQ7Kp+3k2cCIVxPyggYPl
        n5Z170p8aW3cfD2ic6CrGTo=
X-Google-Smtp-Source: AFSGD/V0jbPIWeeyNyEQrPC4vUNzvTGeuMLcZIp7FeGiHEF+vyBhELkWwzJ4F/USoDWFeB1kKZ2Fug==
X-Received: by 2002:a24:4709:: with SMTP id t9mr2658005itb.47.1545411766213;
        Fri, 21 Dec 2018 09:02:46 -0800 (PST)
Received: from dennisz-mbp (c-68-59-32-93.hsd1.mn.comcast.net. [68.59.32.93])
        by smtp.gmail.com with ESMTPSA id y76sm6966359ita.18.2018.12.21.09.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 09:02:45 -0800 (PST)
Date:   Fri, 21 Dec 2018 11:02:43 -0600
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dennis Zhou <dennis@kernel.org>, kernel-team@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blkcg: add rcu lock to bio_clone_blkg_association()
Message-ID: <20181221170243.GA17140@dennisz-mbp>
References: <20181221145441.13814-1-dennis@kernel.org>
 <f1dacd9e-7c3d-44e5-aff1-923d9e7a374c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1dacd9e-7c3d-44e5-aff1-923d9e7a374c@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 21, 2018 at 08:26:02AM -0700, Jens Axboe wrote:
> On 12/21/18 7:54 AM, Dennis Zhou wrote:
> > I cleaned up blkg_tryget_closest() to require rcu_read_lock() earlier.
> > However, this was a subtle case too which clearly was too subtle for me.
> > The idea was the src bio should be holding a ref to the blkg so rcu
> > wasn't technically needed. If it doesn't hold a ref, it should be %NULL
> > and the blkg->parent pointers are unused.
> > 
> > This adds the appropriate read lock in bio_clone_blkg_association().
> 
> Shall I just fold this with the previous? I staged it in a
> later-in-merge-cycle branch, so that's not an issue to amend.
> 

Yeah that would be great!

Thanks,
Dennis
