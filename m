Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:56203 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934572AbdEOPaM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2017 11:30:12 -0400
Date: Mon, 15 May 2017 08:30:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonlist@gmail.com>
Cc: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: Announcing blktests
Message-ID: <20170515153010.GA30173@infradead.org>
References: <20170512184905.GA15267@vader.DHCP.thefacebook.com>
 <87h90m71xb.fsf@dmlp.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87h90m71xb.fsf@dmlp.sw.ru>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 15, 2017 at 03:13:52PM +0300, Dmitry Monakhov wrote:
> Observation #2
> It is appeared that git tree was corrupted after crash  :) Defenitely fsync is missed
> somewhere in git-core, I've straced it and found 'git clone' does only
> two fsync for tmp-pack-xxx files. It seems git's crash consistency is horrably broken.

You'll need to add

[core]
	fsyncobjectfiles = yes

to .gitconfig to make git not play lose with data integrity
