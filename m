Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 0/4] blk-mq: support to use hw tag for scheduling
Date: Wed, 3 May 2017 17:43:48 +0000
Message-ID: <1493833428.3901.24.camel@sandisk.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
	 <839682da-f375-8eab-d6f5-fcf1457150f1@fb.com>
	 <20170503040303.GA20187@ming.t460p>
	 <f52b4478-0d18-a248-3fbf-721216a79f92@fb.com>
	 <370fbeb6-d832-968a-2759-47f16b866551@kernel.dk>
	 <20170503150351.GA7927@ming.t460p>
	 <31bb973e-d9cf-9454-58fd-4893701088c5@kernel.dk>
	 <20170503153808.GB7927@ming.t460p> <20170503165201.GB9706@ming.t460p>
	 <20170503170315.GD9706@ming.t460p>
	 <24ff7ca6-73d6-f8a5-b7d9-e92d0bfdb4b0@kernel.dk>
	 <1493831722.3901.19.camel@sandisk.com>
	 <d537355e-3581-fc86-62ce-0757a84d9c1a@kernel.dk>
	 <1493832921.3901.22.camel@sandisk.com>
	 <63d4a989-25ac-5ab7-ec5d-e92ebb7976d5@kernel.dk>
In-Reply-To: <63d4a989-25ac-5ab7-ec5d-e92ebb7976d5@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-05-03 at 11:40 -0600, Jens Axboe wrote:
> Subject: [PATCH] blk-mq: don't use sync workqueue flushing from drivers
>=20
> A previous commit introduced the sync flush, which we need from
> internal callers like blk_mq_quiesce_queue(). However, we also
> call the stop helpers from drivers, particularly from ->queue_rq()
> when we have to stop processing for a bit. We can't block from
> those locations, and we don't have to guarantee that we're
> fully flushed.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
