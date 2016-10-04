Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35024 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754021AbcJDUwa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2016 16:52:30 -0400
Date: Tue, 4 Oct 2016 16:52:27 -0400
From: Tejun Heo <tj@kernel.org>
To: Adam Manzanares <adam.manzanares@hgst.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/3] block: Add iocontext priority to request
Message-ID: <20161004205227.GL4205@htj.duckdns.org>
References: <1475000096-6148-1-git-send-email-adam.manzanares@hgst.com>
 <1475000096-6148-2-git-send-email-adam.manzanares@hgst.com>
 <20160929084059.GB11087@mtj.duckdns.org>
 <20160930160216.GA13637@hgst.com>
 <20161002085321.GA13648@mtj.duckdns.org>
 <20161004154917.GA4764@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161004154917.GA4764@hgst.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Adam.

On Tue, Oct 04, 2016 at 08:49:18AM -0700, Adam Manzanares wrote:
> > I wonder whether the right thing to do is adding bio->bi_ioprio which
> > is initialized on bio submission and carried through req->ioprio.
> 
> I looked around and thought about this and I'm not sure if this will help. 
> I dug into the bio submission code and I thought generic_make_request was 
> the best place to save the ioprio information. This is quite close in 
> the call stack to init_request_from bio. Bcache sets the bio priority before 
> the submission, so we would have to check to see if the bio priority was 
> valid on bio submission leaving us with the same problem. Leaving the 
> priority in the upper bits of bio->bi_rw is fine with me. It may help to 
> have the bio->bi_ioprio for clarity, but I think we will still face the 
> issue of having to check if this value is set when we submit the bio or 
> init the request so I'm leaning towards leaving it as is.

I see.  Thanks for looking into it.  It's icky that we don't have a
clear path of propagating ioprio but let's save that for another day.

-- 
tejun
