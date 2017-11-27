Return-Path: <hch@lst.de>
Date: Mon, 27 Nov 2017 16:54:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
	virtio-blk (also 4.12 stable)
Message-ID: <20171127155409.GA6937@lst.de>
References: <08e6f35a-4f49-973e-99f7-6087b44337c4@kernel.dk> <20171122072857.GA19338@lst.de> <a1d51b13-c034-e0c8-9428-e360b2c898c3@kernel.dk> <20171123143453.GA29715@lst.de> <cdca47a9-05cc-2676-57fe-904ce8ad5fbc@de.ibm.com> <20171123182542.GA2680@lst.de> <899f1638-cca4-28e6-3225-51505a053d45@de.ibm.com> <20171123183232.GA2845@lst.de> <92ef1aae-90b5-f14f-390e-bfab97899431@de.ibm.com> <419d8565-9cbe-16ac-3d5d-5945098694bc@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <419d8565-9cbe-16ac-3d5d-5945098694bc@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Can you try this git branch:

    git://git.infradead.org/users/hch/block.git blk-mq-hotplug-fix

Gitweb:

     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug-fix
