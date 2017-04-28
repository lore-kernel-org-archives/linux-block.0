Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51347 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756477AbdD1OO7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 10:14:59 -0400
Date: Fri, 28 Apr 2017 16:14:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH v2 0/6] Fixup mtip32xx for scheduling
Message-ID: <20170428141458.GA308@lst.de>
References: <1493388117-15185-1-git-send-email-axboe@fb.com> <20170428141022.GB32073@lst.de> <3ee5ce46-8085-2383-2041-e00f5bb0878e@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ee5ce46-8085-2383-2041-e00f5bb0878e@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 08:13:56AM -0600, Jens Axboe wrote:
> On 04/28/2017 08:10 AM, Christoph Hellwig wrote:
> > On Fri, Apr 28, 2017 at 08:01:49AM -0600, Jens Axboe wrote:
> >> Round two of this patchset to cleanup. Changes since the first
> >> posting:
> > 
> > I got two mixed series in my inbox, one with two patches and one with
> > 6.  The two patch one doesn't seem to have a cover letter.
> 
> Hmm, I seem to get both series in full over the mailing. Perhaps
> it'll show up later? Isn't it the cover letter you are replying
> to?

That's the 0/6 cover letter, I didn't get a 0/2 one both here and
on my linux-block subsription (which uses a different mail server)
