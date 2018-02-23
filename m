Return-Path: <jthumshirn@suse.de>
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>,  linux-block@vger.kernel.org,  Christoph Hellwig <hch@lst.de>,  Josef Bacik <jbacik@fb.com>,  Shaohua Li <shli@fb.com>,  Omar Sandoval <osandov@fb.com>,  Hannes Reinecke <hare@suse.com>,  Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v4 1/6] block/loop: Delete gendisk before cleaning up the request queue
References: <20180223010808.25765-1-bart.vanassche@wdc.com>
	<20180223010808.25765-2-bart.vanassche@wdc.com>
Date: Fri, 23 Feb 2018 09:22:23 +0100
In-Reply-To: <20180223010808.25765-2-bart.vanassche@wdc.com> (Bart Van
	Assche's message of "Thu, 22 Feb 2018 17:08:03 -0800")
Message-ID: <mqdsh9sdsjk.fsf@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
--=20
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
