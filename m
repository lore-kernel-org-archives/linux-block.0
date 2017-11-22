Return-Path: <hch@lst.de>
Date: Wed, 22 Nov 2017 08:28:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"mst@redhat.com" <mst@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
	virtio-blk (also 4.12 stable)
Message-ID: <20171122072857.GA19338@lst.de>
References: <8fedc2ad-d775-7789-742c-92ca928a3aee@kernel.dk> <ebf96f76-3f53-283d-042d-8ea3f5eddb3d@kernel.dk> <ba994ec6-8db6-f77e-ac73-92e3f6b0135a@de.ibm.com> <ae02b9c5-9a2e-cb8b-7828-475b3c0b1cb9@kernel.dk> <c438db5f-f4f1-69f8-37f3-e91eae29fa25@de.ibm.com> <d8dbde03-f528-1cac-03dd-bcc724fcd5c8@kernel.dk> <276625a9-44fb-719d-9281-caacefdbb99f@de.ibm.com> <eceae481-cf9a-0429-7a15-c363a8e7bc2a@kernel.dk> <1ddd1cd4-2862-849e-7849-82544bcb86be@de.ibm.com> <08e6f35a-4f49-973e-99f7-6087b44337c4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <08e6f35a-4f49-973e-99f7-6087b44337c4@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Jens, please don't just revert the commit in your for-linus tree.

On its own this will totally mess up the interrupt assignments.  Give
me a bit of time to sort this out properly.
