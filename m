Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:48640 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753250AbdJHSKJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Oct 2017 14:10:09 -0400
Received: by mail-qt0-f176.google.com with SMTP id f8so4531107qta.5
        for <linux-block@vger.kernel.org>; Sun, 08 Oct 2017 11:10:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C6C056E1-713E-4E3C-910D-5737463C2F95@profihost.ag>
References: <20171008052520.17068-1-mlyle@lyle.org> <fe817f47-89d6-8543-ded6-7ffa46fd52d0@coly.li>
 <C6C056E1-713E-4E3C-910D-5737463C2F95@profihost.ag>
From: Michael Lyle <mlyle@lyle.org>
Date: Sun, 8 Oct 2017 11:10:07 -0700
Message-ID: <CAJ+L6qf7W_vjr-X3EKnC5TYMvcXgR357d0Pdu7UZ4f3vGb-Z1w@mail.gmail.com>
Subject: Re: [PATCH] bcache: writeback rate shouldn't artifically clamp
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Coly Li <i@coly.li>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Stefan--

On Sun, Oct 8, 2017 at 12:50 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Is there a branch with all patches available?

I have a github repository up of linux-next, with commits currently
being staged for next on top, at https://github.com/mlyle/linux/ .

The specific branch contents can be seen at
https://github.com/mlyle/linux/commits/bcache-for-next ; the contents
are Coly's current list of patches for inclusion in next staged on top
of the present version of the next tree.  All the caveats that apply
to tracking linux-next apply to this branch.

This branch is ephemeral and used for staging and verification--
history will be rewritten (I'll rebase it on top of linux-next rather
than have lots of merge commits).  I'm getting together some
continuous integration infrastructure to aid automated test and
verification.

There will probably be other important branches on here.. e.g. a
"kitchensink" branch that includes all submitted patches, including
controversial ones / and ones with only light review.  Probably
sometimes it will make sense to be based on Linus's master, too.  I am
still figuring out my workflow.

> Stefan
>
> Excuse my typo sent from my mobile phone.

Mike
