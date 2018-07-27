Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:40793 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388075AbeG0RKO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jul 2018 13:10:14 -0400
Received: by mail-qt0-f176.google.com with SMTP id h4-v6so5483831qtj.7
        for <linux-block@vger.kernel.org>; Fri, 27 Jul 2018 08:47:44 -0700 (PDT)
Date: Fri, 27 Jul 2018 11:47:42 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [Bug] block/for-next: IO hang in rq_qos_throttle
Message-ID: <20180727154741.v2ubbwerblyug43a@destiny>
References: <CACVXFVNKAhGkievaHXDvPngw7xW5hWg_0oOSLXD1R4uaxSJs3w@mail.gmail.com>
 <83C56CD1-93E0-41E3-AF41-27C4F33851FE@fb.com>
 <20180722072804.GA955@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180722072804.GA955@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jul 22, 2018 at 03:28:05PM +0800, Ming Lei wrote:
> On Sun, Jul 22, 2018 at 02:15:38AM +0000, Josef Bacik wrote:
> > Yup I sent a patch for this on Thursday, sorry about that,
> > 
> 
> I just applied the patch of 'blk-rq-qos: make depth comparisons unsigned',
> looks the same IO hang can be triggered too.

Ok I'm back from vacation and I'm trying to reproduce but it's not happening for
me.  What testing infrastructure is this?  blktests and xfstests don't have a
sanity/ in their test suites.  I'm wondering if there's something else about the
test that I'm missing.  Thanks,

Josef
