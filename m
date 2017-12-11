Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:38840 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdLKVG5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Dec 2017 16:06:57 -0500
MIME-Version: 1.0
In-Reply-To: <20171211035017.32678-1-tytso@mit.edu>
References: <20171211035017.32678-1-tytso@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Dec 2017 13:06:55 -0800
Message-ID: <CA+55aFxU6A5doeHh6QagAPpTKvdHzUimAcq+gnnrva=TUtLzhg@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: Add CONFIG_LOCKDEP_AGGRESSIVE
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Byungchul Park <byungchul.park@lge.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@lge.com,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Dec 10, 2017 at 7:50 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> CONFIG_LOCKDEP_CROSSRELEASE and CONFIG_LOCKDEP_COMPLETIONS can result
> in a large number of false positives because lockdep doesn't
> understand how to deal with multiple stacked loop or MD devices.

Guys, can we just remove this nasty crud already?

It's not working. Give it up. It was complex, it was buggy, it was slow.

Now it's causing people to disable lockdep entirely, or play these
kinds of games in unrelated trees.

It's time to give up on bad debugging, and definitely _not_ enable it
by default for PROVE_LOCKING.

Ted: in the meantime, don't use PROVE_LOCKING. Just use
DEBUG_LOCK_ALLOC instead. Please drop this patch from your tree.

                      Linus
