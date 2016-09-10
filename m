Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45517 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754657AbcIJHnl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Sep 2016 03:43:41 -0400
Date: Sat, 10 Sep 2016 00:43:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <jbacik@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mpa@pengutronix.de,
        nbd-general@lists.sourceforge.net
Subject: Re: [PATCH 5/5] nbd: add multi-connection support
Message-ID: <20160910074340.GA24069@infradead.org>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <1473369130-22986-6-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473369130-22986-6-git-send-email-jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Josef,

I haven't read the full path as I'm a bit in a hurry, but is there
a good reason to not simply have a socket per-hw_ctx and store it in
the hw_ctx private data instead of using the index in the nbd_cmd
structure?
