Return-Path: <anish.jhaveri@paviliondata.com>
Date: Tue, 12 Sep 2017 22:48:22 -0700
From: Anish Jhaveri <anish.jhaveri@paviliondata.com>
To: Keith Busch <keith.busch@intel.com>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 01/10] Initial multipath implementation.
Message-ID: <20170913054822.pkykbsvyh36uto5f@haynes>
References: <20170912042149.drr5dumro5grm7iu@haynes>
 <20170912160043.GB2832@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170912160043.GB2832@localhost.localdomain>
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 12, 2017 at 12:00:44PM -0400, Keith Busch wrote:
> 
> I find this patch series confusing to review. You declare these failover
> functions in patch 1, use them in patch 2, but they're not defined until
> patch 7.
Sorry for late reply. 

Idea was to keep header file changes as separate patch. 
I will move the function declaration to patch 7 and 
rearrange the patch series. If you or anyone else finds 
something which could help in browsing the changes, I
will try to incorporate next patchset.
