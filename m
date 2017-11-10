Return-Path: <BATV+b9f22be6cf688ae68bc2+5192+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 10 Nov 2017 09:22:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme updates for Linux 4.15
Message-ID: <20171110172248.GA8381@infradead.org>
References: <20171110143407.zapukx3fhfcr4fm5@infradead.org>
 <e4ae08a2-4724-6ae5-6e64-7f42fb825bad@kernel.dk>
 <fe9a0a40-11d0-97b4-86e1-ba66d3932eb1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fe9a0a40-11d0-97b4-86e1-ba66d3932eb1@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 10, 2017 at 08:22:32AM -0700, Jens Axboe wrote:
> Actually, double checking, one of them is a little suspicious:
> 
>         if (a == &dev_attr_uuid.attr) {
> <<<<<<< HEAD
>                 if (uuid_is_null(&ns->uuid) &&
>                     !memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
> =======
>                 if (uuid_is_null(&ids->uuid) ||
>                     !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
> >>>>>>> 34a9690712aa386fb5fa9e3b8fb44a22f5f2aec6
>                         return 0;
>         }
> 
> with the previous copy using is_null && memchr_inv, the change to ids
> makes it an OR instead. I'm going with the latter, but thought I'd bring
> it up.

The && from master is the right one, it comes from:

ommit 007a61ae2f35c7fcf767313285c4924e81f11983
Author: Martin Wilck <mwilck@suse.com>
Date:   Thu Sep 28 21:33:23 2017 +0200

    nvme: fix visibility of "uuid" ns attribute

and needs to be logically applied to the new code as well.
