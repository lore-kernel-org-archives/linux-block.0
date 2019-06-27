Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42B7C48BD6
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 10:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C172080C
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 10:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKb75tFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfF0KWX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 06:22:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41764 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfF0KWX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 06:22:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so995630pff.8
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2019 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ggLlF2EjFVqXz9pRT82ofMFIivuIl9ESdL9ZpeeHMdI=;
        b=RKb75tFmkVCPnHxrWVVqdwbtWbBUk/BzY/t1nQELHhp6fv/QjItEqyFx0EoSGkIkiN
         uPRW7mhowLEeZyy/KcdjN8J4tugTir3L14FoCMoeHmEa+x4LEiCHcVxpu6aYQ5DJW3xX
         TfblCo3eZ3n1H/WdQjsdn6KuIJAxxEFC/AcxxBf7Yo9shk7f+S2KQuMdRXchq/7l90vk
         8TpZDOeRLUwz1ws3A3RXpiist7wFxdl25LeLQXivijUPkd2q7EYg3E5gP6jo7rmcMHlG
         ZLrhHRBt1JWeMtdlri9cuJzYyw5Tutr82770xcLmI/3rEt2xY/VnvFvtoOkqpAyH9gYZ
         PvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ggLlF2EjFVqXz9pRT82ofMFIivuIl9ESdL9ZpeeHMdI=;
        b=f2aHpTEa6A1ugX/ZD3YHtbj2qDjUgzvb5HqjMbkXePRIFqc9c3fXyhbDHHXWXj16uD
         VGylyMumL7F704QBkbtk56qa3SmKXGRcqO9L/VaXyQG0ieP9nsbydNXe/sNXeg0+/26w
         ChgejqOSQEv1djV88N2JdYMuDTxk3HdKQcWJPClAVDQsQ+QS29rSr8fXJdZVxII3yUX5
         KM/XTsgofh4AqeiGbVdkAO/v50NyALxPU+OEKPXgQVOfyPw0FQPWnEehfPIyycb6LC9b
         6ZLGa5N38ncROmNKvEYn9WhaAHKrWjpb/jgkbYqjsCWgxwz+c39rZD3hSwrofJtY09++
         3Vww==
X-Gm-Message-State: APjAAAWW1quy/o4k/E7T/8GGQUUXW8DI9WZt9IMDN+Y2NyxjS80pR5gW
        boqTQDnClArOd6x9dzfscSE=
X-Google-Smtp-Source: APXvYqyrQpK0TtgQHNXKEnRTFFN5lP+wBTZl0ur/ToS88ykuS8tpF0cbER5KuSetBCToZXbeqjICPA==
X-Received: by 2002:a17:90a:37c8:: with SMTP id v66mr5231469pjb.33.1561630942885;
        Thu, 27 Jun 2019 03:22:22 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id r7sm3760609pfl.134.2019.06.27.03.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 03:22:22 -0700 (PDT)
Date:   Thu, 27 Jun 2019 19:22:19 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 2/9] block: optionally mark pages dirty in
 bio_release_pages
Message-ID: <20190627102219.GA4421@minwooim-desktop>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-3-hch@lst.de>
 <20190626205247.GH4934@minwooim-desktop>
 <20190627082759.GC11043@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190627082759.GC11043@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-06-27 10:27:59, Christoph Hellwig wrote:
> On Thu, Jun 27, 2019 at 05:52:47AM +0900, Minwoo Im wrote:
> > Could you please explain a bit why we should not make it dirty in case
> > of compound page?
> 
> PageCompount is only true for the tail pages, and marking them dirty
> doesn't work.  On the other hand marking the head page dirty covers
> the whole compount, so we are fine.

Christoph,

Thanks for letting me know this.
