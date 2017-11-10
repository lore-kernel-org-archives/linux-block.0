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
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9bcc3b27-0008-b11e-5bbe-4e908326e031@kernel.dk>
Date: Fri, 10 Nov 2017 10:38:22 -0700
MIME-Version: 1.0
In-Reply-To: <20171110173342.GA15114@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/10/2017 10:33 AM, Christoph Hellwig wrote:
> On Fri, Nov 10, 2017 at 10:27:24AM -0700, Jens Axboe wrote:
>> That makes for a bit of an awkward merge, why wasn't this fixed up
>> in your tree?
> 
> Because you asked me to always base on for-4.15/block last time?

That's not what I meant. It's conflicting because of a patch, that's
fine. But the code in your tree is:

if (a == &dev_attr_uuid.attr) {
        if (uuid_is_null(&ids->uuid) ||
            !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
                return 0;
}

and you're saying the right resolution is:

if (a == &dev_attr_uuid.attr) {
        if (uuid_is_null(&ids->uuid) ||
            !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
                return 0;
}

My point is that this should have been fixed up in your tree. Yes, it'd
still cause a conflict, that's fine, but at least the merge would not
end up also containing a fix for the above code. That part is not
logical.

-- 
Jens Axboe
