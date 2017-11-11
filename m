Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme updates for Linux 4.15
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20171110143407.zapukx3fhfcr4fm5@infradead.org>
 <e4ae08a2-4724-6ae5-6e64-7f42fb825bad@kernel.dk>
 <fe9a0a40-11d0-97b4-86e1-ba66d3932eb1@kernel.dk>
 <20171110172248.GA8381@infradead.org>
 <a2178e34-ecae-f90d-bef4-eb02af6eb43e@kernel.dk>
 <20171110173342.GA15114@infradead.org>
 <9bcc3b27-0008-b11e-5bbe-4e908326e031@kernel.dk>
 <5c78255c-2678-db0c-55a2-128a11aff660@kernel.dk>
 <20171111084346.GA24802@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7276984e-3eaf-4746-2967-990588d28f98@kernel.dk>
Date: Sat, 11 Nov 2017 15:37:59 -0700
MIME-Version: 1.0
In-Reply-To: <20171111084346.GA24802@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/11/2017 01:43 AM, Christoph Hellwig wrote:
> Do you want to apply this forward ported version of the patch
> to your for-4.15/block tree?  That should at least make the conflict
> go away for Linus when he pulls it.

Yeah I will probably add that. I won't kill the conflict, but it'll
make it more logically solvable.

-- 
Jens Axboe
