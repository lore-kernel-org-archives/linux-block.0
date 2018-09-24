Return-Path: <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] clean up physical merging helpers
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-block@vger.kernel.org, xen-devel@lists.xen.org,
        linux-arm-kernel@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20180904191431.20102-1-hch@lst.de>
 <20180915070300.GA10555@lst.de>
 <b8f3621a-f789-d737-649f-7b3645912888@kernel.dk>
 <20180920062946.GA12893@lst.de>
 <6e7fa8d3-4839-726d-572c-1678f5450880@kernel.dk>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <5fc63f64-4e81-0e10-bc3e-bde6f279c973@oracle.com>
Date: Mon, 24 Sep 2018 10:25:45 -0400
MIME-Version: 1.0
In-Reply-To: <6e7fa8d3-4839-726d-572c-1678f5450880@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/20/18 10:39 AM, Jens Axboe wrote:
> On 9/20/18 12:29 AM, Christoph Hellwig wrote:
>> On Sat, Sep 15, 2018 at 08:47:13AM -0600, Jens Axboe wrote:
>>>>> this series moves various helpers related to merging based on physical
>>>>> addresses from the public headers into block/, moves the Xen special
>>>>> case from arch hooks into common code, cleans up the code a bit, and
>>>>> removes not nessecary includes from the block headers.
>>>> ---end quoted text---
>>>>
>>> It's a good cleanup, I like it. Would prefer if the arm/xen folks could
>>> ack the first bits,
>> Konread, can you look at the series (or delegate).


Konrad is out this (and last) week, this looks good to me. Including
patch 13, although it's hard to say whether it may break some builds.

-boris



>>
>>> and 13/13 should probably just to in differently.
>> I can't parse this setence.
> The irony is thick :-)
>
> Anyway, s/to/go for that sentence. I don't mind carrying it if Konrad
> is happy with it, but it could go in separately after this series is
> merged.
>
