Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:41150 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752182AbdKIAX5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Nov 2017 19:23:57 -0500
Date: Thu, 9 Nov 2017 09:23:47 +0900
From: Byungchul Park <byungchul.park@lge.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] locking/lockdep: Revise
 Documentation/locking/crossrelease.txt
Message-ID: <20171109002347.GA24935@X58A-UD3R>
References: <1509344324-22399-1-git-send-email-byungchul.park@lge.com>
 <20171108093438.t5zjpsgealkiamlh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171108093438.t5zjpsgealkiamlh@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 08, 2017 at 10:34:38AM +0100, Ingo Molnar wrote:
> 
> * Byungchul Park <byungchul.park@lge.com> wrote:
> 
> > I'm afraid the revision is not perfect yet. Of course, the document can
> > have got much better english by others than me.
> > 
> > But,
> > 
> > I think I should enhance it as much as I can, before they can help it
> > starting with a better one.
> > 
> > In addition, I removed verboseness as much as possible.
> > 
> > ----->8-----
> > From c7795104ca6ac6dd9f7fd944aee23a2011a6d3a2 Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul.park@lge.com>
> > Date: Mon, 30 Oct 2017 14:51:26 +0900
> > Subject: [PATCH] locking/lockdep: Revise
> >  Documentation/locking/crossrelease.txt
> > 
> > The document should've been written with a better readability. Revise it
> > to enhance its readability.
> > 
> > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > ---
> >  Documentation/locking/crossrelease.txt | 388 +++++++++++++++------------------
> 
> Could you please run a spellchecker over this text? It's still full of typos and 
> various grammar mistakes...

Sure.. I have to.. I will look for a way and use it. Thanks a lot.

> Thanks,
> 
> 	Ingo
