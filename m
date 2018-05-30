Return-Path: <BATV+1f4557cc97fec8e307c5+5393+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 30 May 2018 01:49:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeff Moyer <jmoyer@redhat.com>, Damien.LeMoal@wdc.com,
	linux-block@vger.kernel.org, bgurney@redhat.com
Subject: Re: [PATCH 0/2][RFC] block: default to deadline for SMR devices
Message-ID: <20180530084928.GB29413@infradead.org>
References: <20180525211432.20359-1-jmoyer@redhat.com>
 <9756f816-cea7-52cc-e616-54cd7b7d8c75@kernel.dk>
 <x49tvqvz8eb.fsf@segfault.boston.devel.redhat.com>
 <a0bdfb0c-8ed3-12ac-e11b-6204fe3bb665@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a0bdfb0c-8ed3-12ac-e11b-6204fe3bb665@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

While I really don't want drivers to change the I/O schedule themselves
we have a class of devices (zoned) that don't work at all with certain
I/O schedulers.  The kernel not chosing something sane and requiring
user workarounds is just silly.
