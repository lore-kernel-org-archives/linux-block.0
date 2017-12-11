Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:57282 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752048AbdLKD53 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Dec 2017 22:57:29 -0500
Date: Sun, 10 Dec 2017 22:57:12 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Byungchul Park <byungchul.park@lge.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@lge.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com, tj@kernel.org
Subject: Re: [PATCH] locking/lockdep: Add CONFIG_LOCKDEP_AGGRESSIVE
Message-ID: <20171211035712.okj5azpzo32juvs4@thunk.org>
References: <20171211035017.32678-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171211035017.32678-1-tytso@mit.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Dec 10, 2017 at 10:50:17PM -0500, Theodore Ts'o wrote:
> CONFIG_LOCKDEP_CROSSRELEASE and CONFIG_LOCKDEP_COMPLETIONS can result
> in a large number of false positives because lockdep doesn't
> understand how to deal with multiple stacked loop or MD devices.
> 
> Until someone can figure out how to automatically add annotations to
> all file system and storage devices --- hopefully without forcing
> developers to insert a large number of calls to undocumented lockdep
> macros into the the loop device, every single file system, and every
> single device-mapper backend --- let's add an option to allow these
> lockdep features to be disabled.  Otherwise, many file system
> developers will disable LOCKDEP entirely since it results in far too
> many false positives when trying to use xfstests.

Note --- this is going to be in the ext4 git tree because otherwise
using Lockdep would greatly interfere with ext4 development --- and
I'd prefer not to completely give up on Lockdep as a lost cause.  As
such, it will appear in linux-next.

I'll drop it from the ext4 git branch before I send a pull request to
Linus, unless I get an OK for me to merge this patch to mainline via
the ext4 git tree.

Cheers,

						- Ted
