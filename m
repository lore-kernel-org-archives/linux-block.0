Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbeAZGXj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jan 2018 01:23:39 -0500
Subject: Re: [PATCH v3 00/13] bcache: device failure handling improvement
To: Michael Lyle <mlyle@lyle.org>
Cc: Pavel Goran <via-bcache@pvgoran.name>, Nix <nix@esperi.org.uk>,
        linux-bcache <linux-bcache@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <20180114144236.28213-1-colyli@suse.de>
 <87po5ykiaw.fsf@esperi.org.uk> <1664591662.20180125063516@pvgoran.name>
 <874ln9hilm.fsf@esperi.org.uk> <355593907.20180126071541@pvgoran.name>
 <f2034e77-d351-cb50-d8e0-853ddc48db59@suse.de>
 <CAJ+L6qdLHXzOyKsacCdwB3QKKdnWdxo3kna-Zff8Bv2EfnmR8g@mail.gmail.com>
From: Coly Li <colyli@suse.de>
Message-ID: <68489606-77f7-973e-f6fe-c0847330ca68@suse.de>
Date: Fri, 26 Jan 2018 14:23:27 +0800
MIME-Version: 1.0
In-Reply-To: <CAJ+L6qdLHXzOyKsacCdwB3QKKdnWdxo3kna-Zff8Bv2EfnmR8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 26/01/2018 1:51 PM, Michael Lyle wrote:
> Hey Coly,
> 
> On Thu, Jan 25, 2018 at 8:56 PM, Coly Li <colyli@suse.de> wrote:
>> In order to make the failure handling simple and fast, I will not
>> distinct each bcache device whether it has dirty data on cache set. Once
>> the cache set is dirty, all attached bcache devices will be stopped.
> 
> Surely it shouldn't stop any writethrough/writearound ones though, right?
> 
>> It seems when this option is enabled by users, it should work for
>> writeback and writethrough, and no side effect to writearound and non.
> 
> Writethrough should be the same as writearound, shouldn't it?

Yes, they are no different with such an option.

Coly Li
