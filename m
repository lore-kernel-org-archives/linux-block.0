Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4494C282E1
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 20:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE56217D7
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 20:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbfEWUbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 May 2019 16:31:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58854 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387611AbfEWUba (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 16:31:30 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1hTuN6-0007vw-Nc
        for linux-block@vger.kernel.org; Thu, 23 May 2019 20:31:28 +0000
Received: by mail-wr1-f70.google.com with SMTP id p3so3390017wrw.0
        for <linux-block@vger.kernel.org>; Thu, 23 May 2019 13:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dW+h03iOHL9hXzrG72krYhdVbEtg0vyFtbtFz1jJYI=;
        b=CtQNsCrG8bP19gPcVjnqfOg3nAI55l7I9Kmer1fuBPZWbVdv3UgFVWh5gXdrPs5A84
         oeuBnxKe2W6KFbh1jnW65cNMY8xQUOGw8LDMNvLrOqjTB6qVDTk9nYygN3OwkA/aoG5e
         2Z9U0UGo3qvUGdB5mUiskewzn5adq2xZYuml+W82zvqWUdcazThIyGZ6ae6y8O4+8W2H
         dlUw2a97EU9qinpgnbr8F7i8J/xcC8Hx7KaLygoRNCa7arTZ+NIng9oy55dsgZl7Ws9a
         lTOo+6khyRJdps4smT1lihQukHu/Aa/pG96CDYj14vkphCo62k9kCD7/lyeRViz8n6AX
         N8Bg==
X-Gm-Message-State: APjAAAXHQUV29yWa3L7kJfzVPCEtO7uzOxh+papYAHzQdh2u5R/WGJNq
        f1QwZp2S0w/bASdjEIPT8soT6N7dE297VmK5XgCNHS2uO837JRwRQoBGaaXgMMlmCWv4QHCdzYu
        ZQo9GctXd2U57fqM06WEThb7//TG7roZuY46BEAMsEc1Vwg7bkDseLqTG
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr12828713wmc.129.1558643488517;
        Thu, 23 May 2019 13:31:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxzZrVtJmlEUBWpf3yRAcENU+Y5IToKvqA0uAnb6p0nV/TUnSml7P2OrLKKphRhi6bSed9/gBVCt8Ff7XZ2eEU=
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr12828709wmc.129.1558643488390;
 Thu, 23 May 2019 13:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190520220911.25192-1-gpiccoli@canonical.com>
 <CAPhsuW6KayaNR-0eFHpvPG-LVuPFL_1OFjvZpOcnapVFe2vC9Q@mail.gmail.com>
 <3e583b2d-742a-3238-69ed-7a2e6cce417b@canonical.com> <CAPhsuW7o9bj5DYnUDkCqDeW7NnfNTSBBWJC5_ZVxhoomDEEJcg@mail.gmail.com>
In-Reply-To: <CAPhsuW7o9bj5DYnUDkCqDeW7NnfNTSBBWJC5_ZVxhoomDEEJcg@mail.gmail.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Thu, 23 May 2019 17:30:52 -0300
Message-ID: <CAHD1Q_zCkmiDN24Njjr5Nfuc11hSxN5fgw98MX9j5LJoiwgXPA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] block: Fix a NULL pointer dereference in generic_make_request()
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
        Jens Axboe <axboe@kernel.dk>,
        Gavin Guo <gavin.guo@canonical.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 23, 2019 at 2:06 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
>
> Sorry for the confusion and delay. I will send patches to stable@.
>
> Song


Hi Song, no problem at all! Thanks a lot for the clarification.
Cheers,


Guilherme
