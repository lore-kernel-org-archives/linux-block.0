Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:43249 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbcJYMCA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2016 08:02:00 -0400
Date: Tue, 25 Oct 2016 14:01:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: Re: clean up block ops defintions
Message-ID: <20161025120158.GA2706@lst.de>
References: <1476969135-32732-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476969135-32732-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

any comments on this series? I addition to fixing up the zoned command
direction issue it's also the base for some more work that I'm doing
at the moment, so I'd really like to know if you're fine with the direction.
