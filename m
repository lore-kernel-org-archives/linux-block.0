Return-Path: <BATV+565afbf04a591bdc5c13+5155+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 3 Oct 2017 23:25:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: drop "sending ioctl to a partition" message
Message-ID: <20171004062526.GA29811@infradead.org>
References: <1506005362-13429-1-git-send-email-pbonzini@redhat.com>
 <019433fb-9a89-4ef9-6d76-a817a2f52a0f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <019433fb-9a89-4ef9-6d76-a817a2f52a0f@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 03, 2017 at 06:22:23PM +0200, Paolo Bonzini wrote:
> On 21/09/2017 16:49, Paolo Bonzini wrote:
> > After the first few months, the message has not led to many bug reports.
> > It's been almost five years now, and in practice the main source of
> > it seems to be MTIOCGET that someone is using to detect tape devices.
> > While we could whitelist it just like CDROM_GET_CAPABILITY, this patch
> > just removes the message altogether.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Ping (with fixed email address for Jens)...

How about implementing the revised version I suggested?
