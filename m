Return-Path: <msnitzer@redhat.com>
Date: Wed, 31 Aug 2016 09:39:09 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Milan Broz <gmazyland@gmail.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Ming Lei <tom.leiming@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Eric Wheeler <dm-devel@lists.ewheeler.net>,
        Christoph Hellwig <hch@lst.de>, johnstonj.public@codenest.com,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: dm-crypt: Fix error with too large bios
Message-ID: <20160831133908.GA1001@redhat.com>
References: <24746705-a3af-e634-e675-f2214b6cf356@kernel.dk>
 <20160826140501.GA1061@redhat.com>
 <alpine.LRH.2.02.1608271102560.14465@file01.intranet.prod.int.rdu2.redhat.com>
 <CACVXFVP36-XU4J0D2xgvPBqvEMC6oGfXbbF8aGB0Rj-J10SizA@mail.gmail.com>
 <alpine.LRH.2.02.1608291752340.29067@file01.intranet.prod.int.rdu2.redhat.com>
 <CACVXFVOP6BkgTbWOmMrc6tJ_ekEanKWwRaGmBFXyz+mVwCukFQ@mail.gmail.com>
 <alpine.LRH.2.02.1608300813280.9336@file01.intranet.prod.int.rdu2.redhat.com>
 <20160830205732.GA53993@redhat.com>
 <alpine.LRH.2.02.1608301825540.10943@file01.intranet.prod.int.rdu2.redhat.com>
 <6a58fece-c60b-9dc2-e2e6-bee4e877a376@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6a58fece-c60b-9dc2-e2e6-bee4e877a376@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 31 2016 at  2:26am -0400,
Milan Broz <gmazyland@gmail.com> wrote:

> On 08/31/2016 12:27 AM, Mikulas Patocka wrote:
> 
> ...
> > 
> > Drop that "#ifdef CONFIG_BCACHE". Anyone should be allowed to create a big 
> > bio, not just bcache.
> 
> Yes. Please, do not hide it behind #ifdef.
> If it is in code, it should be enabled always.
> 
> There can third party modules or some new code appears and creating strange
> config dependence only adds more problems later.

I did last night, see:
https://git.kernel.org/cgit/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.8&id=4e870e948fbabf62b78e8410f04c67703e7c816b

Will go to Linus for v4.8-rc5 by the end of the week.
