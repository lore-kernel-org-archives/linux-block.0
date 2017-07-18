Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.eu.citrix.com ([185.25.65.24]:8494 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdGRHk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jul 2017 03:40:26 -0400
Date: Tue, 18 Jul 2017 08:40:18 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@fb.com>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 1/6] xen-blkfront: quiesce/unquiesce queue instead of
 start/stop queues
Message-ID: <20170718074018.a52oya6fl3vyqerg@dhcp-3-128.uk.xensource.com>
References: <20170714231601.14444-1-ming.lei@redhat.com>
 <20170714231601.14444-2-ming.lei@redhat.com>
 <20170717112056.ysdtuugo5ipayv7e@MacBook-Pro-de-Roger.local>
 <20170717150621.GB26571@ming.t460p>
 <20170717160227.x5cmghxgqgyx2ye6@dhcp-3-128.uk.xensource.com>
 <20170718005316.GA3660@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20170718005316.GA3660@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 18, 2017 at 08:53:28AM +0800, Ming Lei wrote:
> On Mon, Jul 17, 2017 at 05:02:27PM +0100, Roger Pau Monn� wrote:
> > On Mon, Jul 17, 2017 at 11:06:28PM +0800, Ming Lei wrote:
> > > On Mon, Jul 17, 2017 at 12:20:56PM +0100, Roger Pau Monn� wrote:
> > > > seems fairly easy to mess up and call "start" on a "quiesced" queue
> > > > (or the other way around).
> > > 
> > > Definitely it shouldn't be worried because start/stop is removed
> > > in this patchset.
> > 
> > Hm, how is that? I haven't seen any patch to blkfront to remove the
> > usage of start/stop, am I missing something?
> 
> http://secure-web.cisco.com/19iIG2bc3Ce2_t8mSF4YQ2LopepIvjAOqnPAXQ_QahSNOEvLBmechzNZ0pQOPfSRhy3hyC4t6L-JJzu81FvWRyLoBmhtq7F9uEk7XZsTt-XNxLN1KdEJvEeUAWelYSd9NthbvpGad6DmpJ0QCHSOgq4mRcDaqlz5mRmNkTvxls-ri1qCqy6am0jTDdraGINb_BUyV0894BtaFOMGJGEKLjcrBfFfT6C5XHSEdsiuB12ZLIUyaRVyU0TCUz6Sm4uhD/http%3A%2F%2Fmarc.info%2F%3Fl%3Dlinux-block%26m%3D150007418321196%26w%3D2

Sadly I have not been CCed or otherwise I've lost patch #5. Related to
that patch AFAICT kick_pending_request_queues can be removed, since
it's only used by one caller (or it can even be removed in this patch,
#1).

Thanks, Roger.
