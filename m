Return-Path: <jthumshirn@suse.de>
Date: Mon, 11 Sep 2017 10:42:49 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>, NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 1/5] percpu-refcount: Introduce
 percpu_ref_switch_to_atomic_nowait()
Message-ID: <20170911084249.rrwccvjqxj4zyudf@linux-x5ow.site>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
 <20170908235226.26622-2-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170908235226.26622-2-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 08, 2017 at 04:52:22PM -0700, Bart Van Assche wrote:
> +/**
> + * percpu_ref_switch_to_nowait - switch a percpu_ref to atomic mode

This should probably read percpu_ref_switch_to_atomic_nowait, shouldn't it?

> +void percpu_ref_switch_to_atomic_nowait(struct percpu_ref *ref)

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
