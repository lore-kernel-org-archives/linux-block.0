Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016C9C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 18:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C821E21920
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 18:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j65XApHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389819AbfBOS3t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:29:49 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:35288 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389822AbfBOS3s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 13:29:48 -0500
Received: by mail-lj1-f178.google.com with SMTP id j13-v6so9215124ljc.2
        for <linux-block@vger.kernel.org>; Fri, 15 Feb 2019 10:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IZgw9gaO8r8isPNWpoogJg0kwUjlbyWeTSejuDimvhI=;
        b=j65XApHXiKnEaEFfz6BdSkuXsmD0R637bEfcjuYDx1ivn0JH3KdGBnoqXaEeO4QeUK
         DuIHdV1Gyam4l3qUOTjAttJk6G0h6yvYJBf/0LXOOmpnAsPNpym53wSmMVvVNHQ82KeJ
         E9G58HHvXLL2VF2iqORiFYBlJL2I1VFSt4GI1VCvHrOQpRVX40/d3QXQ5OlHctVUpowJ
         gujMJB4J6U+e2Mepz7Vapr4N4YNSee5B7ocwLkDuDnYq9+Pyj0IBwHHf+A7cX5OgHZ8a
         c1j1V+F9X3fhNNTjrsGDNwmId/7Ub1kKVQvt78CDkKy0FytaxTPj0FYIh2ltOKfVn9oY
         b4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZgw9gaO8r8isPNWpoogJg0kwUjlbyWeTSejuDimvhI=;
        b=YLx20nV7rGnKo/mAliuDyNQdHDf1ERHBnnUsjlgBcOqq0/KM3WKplPplBPpKnqKvuK
         sq0l+jVoS0Y3F1XG4BGOJrVNtpvj5h4I8330GcLJffplBDEqYnLmPDNGhuHrGVCD/rGu
         2NPj4y/7GsjYnkOstIkCrfO6Zz71HSkugf3M99ldXx9SdF9KZPqJab5l7c0vcp+w2RLY
         aQXV6fl7cMinidMxXu0DKkZa+zaLFzC1Xyw+PKEnKV6Lu51UZ9oeI1y/xhFMYARsoD38
         kPQ++NqgQkn5stp1hhuxmLEhiud+g5u+FLwSXUdicmgAWfwGqQPd8MXPHgZ/fjdvRKjB
         1qwQ==
X-Gm-Message-State: AHQUAuaBj9GQg6qAzuYHe9iGeFLYjumrON3E75z3q79nXRWpwk3/AnnN
        5LjxVYQbCHMy09l5lBIdXi1i1ve+p/p44e3F2O6rDA==
X-Google-Smtp-Source: AHgI3IZFNTIBifg9gsFllh79DurER6AX90Fz0PyXcjAadIfSDiu3Vrdfn97FcuD7UXBW6eIMAC3VHM8B/dTkB+Wkngo=
X-Received: by 2002:a2e:9f0b:: with SMTP id u11mr6620347ljk.64.1550255385867;
 Fri, 15 Feb 2019 10:29:45 -0800 (PST)
MIME-Version: 1.0
References: <1545261885.185366.488.camel@acm.org> <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
 <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com> <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
 <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk> <1545328865.185366.508.camel@acm.org>
 <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk> <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
 <1545339362.185366.511.camel@acm.org> <e7d6d857-b20a-245c-c6c7-fb9b110215e9@kernel.dk>
 <1545340987.185366.515.camel@acm.org> <120bb59a-af93-7d8c-9afc-7087973632bf@kernel.dk>
 <1545341470.185366.519.camel@acm.org> <61515137-0565-e3b7-e6de-554af7d49753@kernel.dk>
 <1545342043.185366.523.camel@acm.org> <60b4819c-4c19-a4e3-41f3-e21b0544c9a4@kernel.dk>
 <68c73daa-10e7-29da-b890-bf167ec164c2@kernel.dk> <1545344398.185366.531.camel@acm.org>
 <1864f5b8-cf64-a406-a3e0-9f5124ff95b5@kernel.dk> <a04dee3c-f355-4d28-caa4-21c7265ccae4@kernel.dk>
 <5869f2ed-dc65-135f-f12f-c14a1184125e@kernel.dk> <71fb9eff-43eb-24aa-fb67-be56a3a97983@kernel.dk>
 <1550187391.31902.87.camel@acm.org>
In-Reply-To: <1550187391.31902.87.camel@acm.org>
From:   Evan Green <evgreen@google.com>
Date:   Fri, 15 Feb 2019 10:29:09 -0800
Message-ID: <CAE=gft5H83gC2ay63druSr4sCznrXKvKd=FCTXpx_c2F3Z+icA@mail.gmail.com>
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
I got all turned around while trying to understand this fix, and I'll
admit it's probably just me. It looks like you're trying to use an rcu
lock to prevent the iter functions from racing with free. Is that
true? But then the race at least as I understand it wasn't that there
was a free in-flight, it's that the free had happened a long time ago,
and there was still a stale value in tags->rqs[bitnr]. So maybe
there's some other issue that part is solving?

And then it looks like you added a new struct where tags->rqs was so
that you could compare hctx->queue without reaching through rq. I have
no idea if that's sufficient to prevent stale accesses through rq.
Since you're changing multiple values I think where you populate that
structure you'd at least need to do something like: clear rq, barrier,
set hctx, barrier, set rq. But like Bart said, that's probably not the
right way to go.

Finally, I didn't really get why the conditional in
blk_mq_rq_inflight() changed. Is that guarding against some other
identified problem, or just an additional check you can do when you
convert rqs into a struct?

It looks like blk_mq_free_rqs() might be the magic function I was
looking for earlier. Would it be possible to just clear tags[rq->tag]
for each static_rq? Or is it possible for rqs from one set to end up
in the tags array of another set? (Which would make what I just
suggested insufficient).
-Evan
