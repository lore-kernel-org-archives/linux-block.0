Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35168 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933382AbdABSPP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Jan 2017 13:15:15 -0500
Received: by mail-wm0-f42.google.com with SMTP id a197so370096725wmd.0
        for <linux-block@vger.kernel.org>; Mon, 02 Jan 2017 10:15:14 -0800 (PST)
From: Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Subject: [LSF/MM ATTEND AND AGENDA TOPIC] request to attend the summit
Date: Mon, 2 Jan 2017 19:14:14 +0100
Message-Id: <771BC555-46A4-4AE1-BDD5-BFB4E3F065F0@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@linaro.org>, linux-block@vger.kernel.org
To: lsf-pc@lists.linux-foundation.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,
this is to retry to request to attend the summit.  This time I'm
trying to propose and agenda topic too.

I would like to attend, and propose a topic, because:
1) the project for adding (only) the BFQ I/O scheduler to blk-mq has
entered a quite active phase: the framework prepared by Jens seems
mostly ready and complete, and I need just a few details to complete
the port of BFQ.
2) the landing of BFQ into blk-mq might have possibly important
consequences, in a way or the other.

So, it might be quite useful for me, and possibly for other
developers/stakeholders interested in these changes and consequences,
to have the opportunity to talk with each other, exactly when, or
right after these changes happen.

In addition, a few months ago Greg KH and James Bottomley even
suggested to postpone to this summit, or Vault, the KS discussion that
I proposed on the unsolved latency problems for which BFQ has been
devised.  So, my topic proposal would be exactly this:
"Unsolved latency problems, related to I/O, in Linux: consequences on
lsb-compliant and Android systems, solutions proposed so far, possible
next solutions".

If needed, I can provide more details on this topic.

As for the expertise that I may bring, I'm somehow expert in:
guaranteeing a good system and application responsiveness (a low lag
in typical Android terminology), providing strong low-latency
guarantees to video/audio playing/streaming applications, guaranteeing
a fair share of the bandwidth, and not just the time, of I/O
resources.

I would like to submit a talk proposal to Vault too.

Thanks,
Paolo
