Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38051 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbeCQJ66 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Mar 2018 05:58:58 -0400
Subject: Re: [PATCH 0/4] bcache-tools: enable big endian support for s390x
To: Michael Lyle <mlyle@lyle.org>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20180315104240.24647-1-colyli@suse.de>
 <45f74b66-91b6-d733-0f7f-7ef36402672a@lyle.org>
From: Coly Li <colyli@suse.de>
Message-ID: <f4f2bdfd-543b-e737-7e8c-f45ce3393a88@suse.de>
Date: Sat, 17 Mar 2018 17:58:50 +0800
MIME-Version: 1.0
In-Reply-To: <45f74b66-91b6-d733-0f7f-7ef36402672a@lyle.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 17/03/2018 2:28 AM, Michael Lyle wrote:
> Hmm.  I can review these, but I don't currently have rights to apply to
> bcache-tools.  Who's been maintaining these?  I'm glad to take it on...
> 

Hi Mike,

I guess that Kent maintains user space tools currently. Since bcachefs
should have a different tools set, use bcache-tools specifically for
Linux bcache might be a good idea.

If you plan to maintain the user space tools, and have an agreement with
Kent, maybe you can clone a tree on your own and modify the wiki page
for your new tree address. At least I will poll new code for our
products from your tree once you are ready.

Back to this patch set, I will post a new one, which distinguish on-disk
format from in-memory structure.

Thanks.

Coly

[snip]
