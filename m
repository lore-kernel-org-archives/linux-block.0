Return-Path: <hch@lst.de>
Date: Thu, 23 Nov 2017 15:47:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
	virtio-blk (also 4.12 stable)
Message-ID: <20171123144728.GA30139@lst.de>
References: <c438db5f-f4f1-69f8-37f3-e91eae29fa25@de.ibm.com> <d8dbde03-f528-1cac-03dd-bcc724fcd5c8@kernel.dk> <276625a9-44fb-719d-9281-caacefdbb99f@de.ibm.com> <eceae481-cf9a-0429-7a15-c363a8e7bc2a@kernel.dk> <1ddd1cd4-2862-849e-7849-82544bcb86be@de.ibm.com> <08e6f35a-4f49-973e-99f7-6087b44337c4@kernel.dk> <20171122072857.GA19338@lst.de> <a1d51b13-c034-e0c8-9428-e360b2c898c3@kernel.dk> <20171123143453.GA29715@lst.de> <07e95492-9237-5c0c-fae9-c5704c735d38@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <07e95492-9237-5c0c-fae9-c5704c735d38@suse.de>
List-ID: <linux-block@vger.kernel.org>

[fullquote deleted]

> What will happen for the CPU hotplug case?
> Wouldn't we route I/O to a disabled CPU with this patch?

Why would we route I/O to a disabled CPU (we generally route
I/O to devices to start with).  How would including possible
but not present cpus change anything?
