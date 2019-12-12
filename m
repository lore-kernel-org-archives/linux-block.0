Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B7FC43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 16:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790F821655
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 16:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkYgMnF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfLLQHN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:07:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44154 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbfLLQHM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 11:07:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so1355066pgl.11;
        Thu, 12 Dec 2019 08:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=hCXWACuOCexCnHIz0jCOmF4DYKWkjPdd5H/jFPoItro=;
        b=IkYgMnF2gLAlQaxdpyryOpYIwVwEh0VKVFj7HudbihnYnxNZu4QI18aPJ37U4uzyp/
         BlD1tWs7IMBduKKeEZDaejczWP08RcOs4A+9t+gX6ojw+dyuoKPsnmPsHgURKQ9XP3eL
         oKjYVUqECyX1zczto/andUpR8yFdi3epbkapsSPYdqxNH1llQjEtnGm0yoG7x4+EB5Sq
         98r+UhLcWm8ADQpErB6akvg09+atbU2lE7wRZXexZSjl3fgD9tgZSW25uC81LTqyVmzJ
         NIIK9S7QAhXdr03iO+IRSNMmMe3rPGOknSlE/A0/RchzyNOr6L/UsJYKdBNPCJz9qnUe
         jO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=hCXWACuOCexCnHIz0jCOmF4DYKWkjPdd5H/jFPoItro=;
        b=tiUjk6U2khjIXJb6sTT50p31up3mYq3zK0vSsizsuMw+M2HA11jS4uuf9KJtLY+b7L
         76GV7QX81p32eONYFlZu92bqaUGa2bcn6FPq2hVufhRZsaz8oEcfoM/mzcJS32j7fOKN
         NsKiYtreCIwQztDPkLpdvm5Dia9LdnCJajLUjzYX0qdizCyKO3b5wxgQRcFzh30CvFY6
         FxCKOo5bSCdEPNNvvCB6Kzf8StiXo4XRnEH2zDzs8apYvpa7TobYWNREP7EmW/vgLmiA
         SH12lBfOamcKuDxx8/osgrC/RPdh75KIVdK1XaGP0aLieJ6jy9xqtWjR+Fn0LVKTb76v
         P+Kg==
X-Gm-Message-State: APjAAAXiJ5xT8L/lrsQwERyZ8oEufQwIKC8PmUrxzbplbJEBjAKMVjTO
        aTGQmDY5W0VCBDIsGAjDC0w=
X-Google-Smtp-Source: APXvYqxSVQfqyqgkVT73oV6Yh6YcW5Bxj10GO45cM95SrDPjF4K5yUaFstQ/B47LysRt136MrdXZdQ==
X-Received: by 2002:a63:338e:: with SMTP id z136mr11343954pgz.60.1576166831821;
        Thu, 12 Dec 2019 08:07:11 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id b2sm8183016pff.6.2019.12.12.08.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Dec 2019 08:07:10 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     jgross@suse.com, axboe@kernel.dk, sjpark@amazon.com,
        konrad.wilk@oracle.com, pdurrant@amazon.com,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: Re: [Xen-devel] [PATCH v7 2/3] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Thu, 12 Dec 2019 17:06:58 +0100
Message-Id: <20191212160658.10466-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
In-Reply-To: <20191212152757.GF11756@Air-de-Roger>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 12 Dec 2019 16:27:57 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> > diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> > index fd1e19f1a49f..98823d150905 100644
> > --- a/drivers/block/xen-blkback/blkback.c
> > +++ b/drivers/block/xen-blkback/blkback.c
> > @@ -142,6 +142,21 @@ static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
> >  		HZ * xen_blkif_pgrant_timeout);
> >  }
> >  
> > +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> > +static unsigned int buffer_squeeze_duration_ms = 10;
> > +module_param_named(buffer_squeeze_duration_ms,
> > +		buffer_squeeze_duration_ms, int, 0644);
> > +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> > +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
> > +
> > +static unsigned long buffer_squeeze_end;
> > +
> > +void xen_blkbk_reclaim_memory(struct xenbus_device *dev)
> > +{
> > +	buffer_squeeze_end = jiffies +
> > +		msecs_to_jiffies(buffer_squeeze_duration_ms);
> 
> I'm not sure this is fully correct. This function will be called for
> each blkback instance, but the timeout is stored in a global variable
> that's shared between all blkback instances. Shouldn't this timeout be
> stored in xen_blkif so each instance has it's own local variable?
> 
> Or else in the case you have 1k blkback instances the timeout is
> certainly going to be longer than expected, because each call to
> xen_blkbk_reclaim_memory will move it forward.

Agreed that.  I think the extended timeout would not make a visible
performance, though, because the time that 1k-loop take would be short enough
to be ignored compared to the millisecond-scope duration.

I took this way because I wanted to minimize such structural changes as far as
I can, as this is just a point-fix rather than ultimate solution.  That said,
it is not fully correct and very confusing.  My another colleague also pointed
out it in internal review.  Correct solution would be to adding a variable in
the struct as you suggested or avoiding duplicated update of the variable by
initializing the variable once the squeezing duration passes.  I would prefer
the later way, as it is more straightforward and still not introducing
structural change.  For example, it might be like below:

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index f41c698dd854..6856c8ef88de 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -152,8 +152,9 @@ static unsigned long buffer_squeeze_end;
 
 void xen_blkbk_reclaim_memory(struct xenbus_device *dev)
 {
-       buffer_squeeze_end = jiffies +
-               msecs_to_jiffies(buffer_squeeze_duration_ms);
+       if (!buffer_squeeze_end)
+               buffer_squeeze_end = jiffies +
+                       msecs_to_jiffies(buffer_squeeze_duration_ms);
 }
 
 static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
@@ -669,10 +670,13 @@ int xen_blkif_schedule(void *arg)
                }
 
                /* Shrink the free pages pool if it is too large. */
-               if (time_before(jiffies, buffer_squeeze_end))
+               if (time_before(jiffies, buffer_squeeze_end)) {
                        shrink_free_pagepool(ring, 0);
-               else
+               } else {
+                       if (unlikely(buffer_squeeze_end))
+                               buffer_squeeze_end = 0;
                        shrink_free_pagepool(ring, max_buffer_pages);
+               }
 
                if (log_stats && time_after(jiffies, ring->st_print))
                        print_stats(ring);

May I ask you what way would you prefer?


Thanks,
SeongJae Park

> 
> Thanks, Roger.
> 
