Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7DAC43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E317021556
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576094628;
	bh=E/Wl2zUEE2W4tDm++V4R4/rd4mM7HKc1mteZm/Ui4wY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NnvrW09lxFoMEL/G4QONtmE66641jMIDWOQ9ADeArpA6l46ZB3KE3sfG7N81Hij4Z
	 oz4pUr6PZKJQvxyrlG3/t/y4IsYl+pfggWL2Stjoi9cvm7UWqJURaeOSZ972yQJLu5
	 Ci1IEMHTw+31MQzhAMdfj9pxIoCADqoEBJf0E7Lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLKUDr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:03:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44529 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfLKUDr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 15:03:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so17638516lfa.11
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 12:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARg/+L4b2QIR/B9zIQc3US5T+eVRe9Cf50TlETDyNaM=;
        b=al6iELdaRQuI0zpwDdTfK6nolqCFFm3GeyTbURFnuQx3l3Gazb6Tek0ArH9y2SX5mj
         ifsQj5G0solgyBXOD8mZItnFHBffKhpIKNK26Ergh9hSZEoHOJWUgHwG+n3+CPziqfcP
         XZM+UMagtUrNJXK+iqlOjo+Rihu5Abb63zLsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARg/+L4b2QIR/B9zIQc3US5T+eVRe9Cf50TlETDyNaM=;
        b=uEFz+ZnWr7+Ct9WlFeIaGR6m0XvFn+VkNLRx+MyXjkgNcqr1AWLUS4cOrpKR51hxYd
         pEsN0N6vfxJcWKWRTOkNSecvO4xXKGKEJHk5dLrncZxE+4sGtxi77x3qfkdUs6d7Qmsg
         h2/u/iKTNpcrvck0j33YdixX1BKEzAtcb/6qSzoU7MO76VgZZ6pB8yOr04Y/QRGL6Gre
         O6VFSU46cbxSh+/PmJP0qWVcEIeLPVIflSLcN8QToFBOqRBEse63/+QTBx0QWHkNRNPk
         twXOrTbcPmgS0PIV4f/gEXKIbcUBCay2ikwN0bM0VnAWVXhrNrATNGlI/kY+U5wiCzDs
         BbtA==
X-Gm-Message-State: APjAAAXiZWRiTS3yiuA/zcTgUhHiiWfh6alsC+6XHPKI6/0Pbt6J3wlk
        vojVQu0BQkDQK8Gwfi1P/MwYdTBzzmY=
X-Google-Smtp-Source: APXvYqwB+hlX0GR+ftvlLvStQQRNAPcCdOTAVI9b2WxtNzvkSCqb2g4sWBXb1ciPCr2iQBY9xUzROA==
X-Received: by 2002:a05:6512:284:: with SMTP id j4mr3281629lfp.109.1576094624687;
        Wed, 11 Dec 2019 12:03:44 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id e21sm1939140lfc.63.2019.12.11.12.03.43
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 12:03:43 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id r14so17696643lfm.5
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 12:03:43 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr3498008lfo.134.1576094623187;
 Wed, 11 Dec 2019 12:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk> <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
In-Reply-To: <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 12:03:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
Message-ID: <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 11:34 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> I can't tell a difference in the results, there's no discernable
> difference between NOT calling mark_page_accessed() or calling it.
> Behavior seems about the same, in terms of pre and post page cache full,
> and kswapd still churns a lot once the page cache is filled up.

Yeah, that sounds like a bug. I'm sure the RWF_UNCACHED flag fixes it
when you do the IO that way, but it seems to be a bug relardless.

Does /proc/meminfo have everything inactive for file data (ie the
"Active(file)" line is basically zero?).

Maybe pages got activated other ways (eg a problem with the workingset
code)? You said "See patch below", but there wasn't any.

That said, it's also entirely possible that even with everything in
the inactive list, we might try to shrink other things first for
whatever odd reason..

The fact that you see that xas_create() so prominently would imply
perhaps add_to_swap_cache(), which certainly implies that the page
shrinking isn't hitting the file pages...

               Linus
