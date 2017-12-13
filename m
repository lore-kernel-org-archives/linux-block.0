Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39048 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdLMGYc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Dec 2017 01:24:32 -0500
MIME-Version: 1.0
From: Byungchul Park <max.byungchul.park@gmail.com>
Date: Wed, 13 Dec 2017 15:24:29 +0900
Message-ID: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
Subject: About the try to remove cross-release feature entirely by Ingo
To: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, david@fromorbit.com,
        tytso@mit.edu, willy@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, byungchul.park@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Lockdep works, based on the following:

   (1) Classifying locks properly
   (2) Checking relationship between the classes

If (1) is not good or (2) is not good, then we
might get false positives.

For (1), we don't have to classify locks 100%
properly but need as enough as lockdep works.

For (2), we should have a mechanism w/o
logical defects.

Cross-release added an additional capacity to
(2) and requires (1) to get more precisely classified.

Since the current classification level is too low for
cross-release to work, false positives are being
reported frequently with enabling cross-release.
Yes. It's a obvious problem. It needs to be off by
default until the classification is done by the level
that cross-release requires.

But, the logic (2) is valid and logically true. Please
keep the code, mechanism, and logic.

-- 
Thanks,
Byungchul
