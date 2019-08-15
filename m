Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CCCC3A589
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 16:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EA920578
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 16:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3H9xxK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbfHOQe6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:34:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46114 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbfHOQe6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 12:34:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so2719328wru.13;
        Thu, 15 Aug 2019 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEfHwjG9N7iHX8ZUQFtAly9eYKVm35bhOLQ3YSQSUqs=;
        b=k3H9xxK5XwKo6ni03t5dNepf9zvvZPX0K0P+Rj0+R+d2xgyd8S71Wnw6qmlQtExo6W
         HoQHlqwRWxLZnjOJX0YsUX2HJpZfpSc9GNFmqhJllOcXBpqzTwdJq+b26z8gLHmgF0Wk
         BEs2obOnQ0BSlI0S2g83zTzy0nTMAnbML/vCYsLB+J5tvHnxYeti0Y7PBLLltwWVWHhQ
         vX07Movo4p+zNu0VzFsy5pSqfcLfgjVRsIw6mu+ndADyN5r1Telo1eaG/54SMcbBqN2d
         7k50g3rwoBcmrfSusd5XFaJ5GLstlfgWfSh6UL+BKeZQP9BThWiFmN0KUEDI1/dPU3YC
         Y7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEfHwjG9N7iHX8ZUQFtAly9eYKVm35bhOLQ3YSQSUqs=;
        b=aXdWiRtikExGYiSuo4L3ngx8qnq55D2BDhQQ8SXZc2JqhFzbjs40JESiJqs60g4Ip/
         UVETNfs6Jryd4sQ+ZWggc42Dn7p6+n9TZeozwyeC7ZyKllfTQhrbLUY71Ma+4O3O9OQg
         cv/11C3tTdBKiKsFhtxRqx1RzIOZqt+jbJ4NqZW3dUkluC3uicEcXdHHX4TTp+m2hQt7
         I4+DHWHJ+7A/ioETEylaX/kaBAMlE7G0F3XyNsP1o+G3PyVKzVQ7Od3P9Cx5toooVIsA
         FWU3eE3jY9K6fr53uByS1DgCOOwmpKuCgd4sghza4f/ATohPqU6k/u/dYukdhHff4seO
         NmUQ==
X-Gm-Message-State: APjAAAWmj7mLncFcde1nRjp30MCT7qqcj5N5WjegT4ryrXW3v1sBsqZo
        JA/6cm14Ch/cI0C4hu2xZF4YSAEJc9EhkZgdQsA=
X-Google-Smtp-Source: APXvYqzG5kqXWgwL2+xEhTWxHtT5Xl5CZ06ZoRoALleqe6tLsCTLHX2skX6B6gIWHtosFoKmVW++A78TeZ6XFunWey4=
X-Received: by 2002:adf:e4c6:: with SMTP id v6mr6043426wrm.315.1565886896202;
 Thu, 15 Aug 2019 09:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190814103244.92518-1-maco@android.com> <20190814113348.GA525@ming.t460p>
 <CAB0TPYHdaOTUKf5ix-oU7cXsV12ZW6YDYBsG+VKr6zk=RCW2NA@mail.gmail.com>
 <20190814114646.GA14561@ming.t460p> <CAB0TPYGc8H1pJZrDX1r5wO1gyYV9rzgi3acT9mp-vxxrdA-pyA@mail.gmail.com>
In-Reply-To: <CAB0TPYGc8H1pJZrDX1r5wO1gyYV9rzgi3acT9mp-vxxrdA-pyA@mail.gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 16 Aug 2019 00:34:44 +0800
Message-ID: <CACVXFVP0JrpUgterqHs5bvCQn7L9a-XrjDCD3BmQOLe+rgC1KQ@mail.gmail.com>
Subject: Re: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when possible.
To:     Martijn Coenen <maco@android.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@android.com,
        Narayan Kamath <narayan@google.com>,
        Dario Freni <dariofreni@google.com>,
        Nikita Ioffe <ioffe@google.com>,
        Jiyong Park <jiyong@google.com>,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 15, 2019 at 11:38 PM Martijn Coenen <maco@android.com> wrote:
>
> On Wed, Aug 14, 2019 at 12:47 PM Ming Lei <ming.lei@redhat.com> wrote:
> > blk_queue_init_done() is only called in blk_queue_init_done() for
> > this purpose, so this approach should be fine, IMO.
>
> I was thinking somebody might add more stuff to "init" in the future,
> and then that new stuff would now no longer be executed for the loop
> driver. The name "init" is pretty generic...but if that's not a
> concern I'm happy with your proposal as well. There's one more
> "freeze" I'd like to get rid of - we also call LOOP_SET_STATUS(64),
> and there's a freeze in there because lo->transfer is modified. That
> makes sense, but I was hoping we can make that freeze conditional on
> whether lo->transfer would actually change value; if it stays the
> same, I think freezing is not necessary.

The queue freeze in SET_STATUS may not be avoided, not only
.transfer, there are also .lo_offset, .size, filename, dio and others.

If nothing will change, why does the userspace bother to send
SET_STATUS?


Thanks,
Ming Lei
