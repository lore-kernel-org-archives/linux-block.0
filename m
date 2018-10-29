Return-Path: <pbonzini@redhat.com>
Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
To: Christoph Hellwig <hch@infradead.org>
Cc: Daniel Verkamp <dverkamp@chromium.org>, Jens Axboe <axboe@kernel.dk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Changpeng Liu <changpeng.liu@intel.com>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
 <20181012210628.226361-1-dverkamp@chromium.org>
 <20181015092740.GA3964@infradead.org>
 <486afcff-a8bd-a05b-e331-e395d4d14853@redhat.com>
 <20181026082640.GA1147@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf8fbe85-37a0-be6b-bfd0-da45dfaf7920@redhat.com>
Date: Mon, 29 Oct 2018 19:03:44 +0100
MIME-Version: 1.0
In-Reply-To: <20181026082640.GA1147@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 26/10/2018 10:26, Christoph Hellwig wrote:
> On Fri, Oct 26, 2018 at 01:28:54AM +0200, Paolo Bonzini wrote:
>> On 15/10/2018 11:27, Christoph Hellwig wrote:
>>> There is some issues in this spec.  For one using the multiple ranges
>>> also for write zeroes is rather inefficient.  Write zeroes really should
>>> use the same format as read and write.
>>
>> What makes it inefficient?
> 
> We require a memory allocation for each write zeroes instead of encoding
> the lba/len in the command.

Oh, I see.  That's not a spec issue, the lba/length descriptor can be
included in the same buffer as the rest of the command; using
kmalloc_array even for a single-bio REQ_OP_WRITE_ZEROES is a choice made
by this patch, I suppose for simplicity.

It is possible to special case single-bio unmap and write zeroes so that
they don't call virtblk_setup_discard_write_zeroes and avoid
RQF_SPECIAL_PAYLOAD.

Thanks,

Paolo
