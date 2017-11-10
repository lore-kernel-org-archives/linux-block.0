Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33668 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdKJHa5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Nov 2017 02:30:57 -0500
Date: Fri, 10 Nov 2017 08:30:53 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Byungchul Park <byungchul.park@lge.com>
Cc: peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v2] locking/lockdep: Revise
 Documentation/locking/crossrelease.txt
Message-ID: <20171110073053.qh4nhpl26i47gbiv@gmail.com>
References: <1510212036-22008-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510212036-22008-1-git-send-email-byungchul.park@lge.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


* Byungchul Park <byungchul.park@lge.com> wrote:

>     Event C depends on event A.
>     Event A depends on event B.
>     Event B depends on event C.
>  
> -   NOTE: Precisely speaking, a dependency is one between whether a
> -   waiter for an event can be woken up and whether another waiter for
> -   another event can be woken up. However from now on, we will describe
> -   a dependency as if it's one between an event and another event for
> -   simplicity.

Why was this explanation removed?

> -Lockdep tries to detect a deadlock by checking dependencies created by
> -lock operations, acquire and release. Waiting for a lock corresponds to
> -waiting for an event, and releasing a lock corresponds to triggering an
> -event in the previous section.
> +Lockdep tries to detect a deadlock by checking circular dependencies
> +created by lock operations, acquire and release, which are wait and
> +event respectively.

What? You changed a readable paragraph into an unreadable one.

Sorry, this text needs to be acked by someone with good English skills, and I 
don't have the time right now to fix it all up. Please send minimal, obvious
typo/grammar fixes only.

Thanks,

	Ingo
