Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2][RFC] block: default to deadline for SMR devices
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, Damien.LeMoal@wdc.com,
 linux-block@vger.kernel.org, bgurney@redhat.com
References: <20180525211432.20359-1-jmoyer@redhat.com>
 <9756f816-cea7-52cc-e616-54cd7b7d8c75@kernel.dk>
 <x49tvqvz8eb.fsf@segfault.boston.devel.redhat.com>
 <a0bdfb0c-8ed3-12ac-e11b-6204fe3bb665@kernel.dk>
 <20180530084928.GB29413@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <71ad1d2e-b4cc-a36d-22ea-86574c76370c@kernel.dk>
Date: Wed, 30 May 2018 08:22:40 -0600
MIME-Version: 1.0
In-Reply-To: <20180530084928.GB29413@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/30/18 2:49 AM, Christoph Hellwig wrote:
> While I really don't want drivers to change the I/O schedule themselves
> we have a class of devices (zoned) that don't work at all with certain
> I/O schedulers.  The kernel not chosing something sane and requiring
> user workarounds is just silly.

They work just fine for probing and reading purposes. There's absolutely
no reason why we can't handle these special snowflakes with a udev rule.

-- 
Jens Axboe
