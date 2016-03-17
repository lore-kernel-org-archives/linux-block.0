Return-Path: <keith.busch@intel.com>
Date: Thu, 17 Mar 2016 16:39:46 +0000
From: Keith Busch <keith.busch@intel.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sagi Grimberg <sagig@mellanox.com>,
	Mike Snitzer <snitzer@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Cathy Avery <cavery@redhat.com>
Subject: Re: [PATCH RFC] block: fix bio merge checks when virt_boundary is
 set
Message-ID: <20160317163946.GC6217@localhost.lm.intel.com>
References: <1458055076-2175-1-git-send-email-vkuznets@redhat.com>
 <CACVXFVMs-fOaNVUyedg66T83MiOc7a+op3LeHVt6ogVBQnYdeQ@mail.gmail.com>
 <87oaae4cej.fsf@vitty.brq.redhat.com>
 <20160316223804.GA6217@localhost.lm.intel.com>
 <87egb94agz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87egb94agz.fsf@vitty.brq.redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 17, 2016 at 12:20:28PM +0100, Vitaly Kuznetsov wrote:
> Keith Busch <keith.busch@intel.com> writes:
> > been combined. In any case, I think you can get what you're after just
> > by moving the gap check after BIOVEC_PHYS_MERGABLE. Does the following
> > look ok to you?
> >
> 
> Thanks, it does.

Cool, thanks for confirming.

> Will you send it or would you like me to do that with your Suggested-by?

I'm not confident yet this doesn't break anything, particularly since
we moved the gap check after the length check. Just wanted to confirm
the concept addressed your concern, but still need to take a closer look
and test before submitting.
