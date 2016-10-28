Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
To: Linus Walleij <linus.walleij@linaro.org>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <20161026113443.GA13587@quack2.suse.cz>
 <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com>
 <12386463.fJy0cVexVD@wuerfel> <20161026152955.GA21262@infradead.org>
 <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk>
 <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk>
 <CAPDyKFrCNS_ZWzVU9Y=J9q0ewp-7=VFs4LwV69SzgSGHBxTn-g@mail.gmail.com>
 <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk>
 <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
 <1ac9b794-7e7f-0748-e4c8-a13034aecbc3@kernel.dk>
 <CAPDyKFpLhp0eoS8LWy-jU0_U_cWq4immq2+bPdi-j7=oa24OjA@mail.gmail.com>
 <e792e932-cf16-4272-2388-ae813a0372b6@kernel.dk>
 <CACRpkdbngAKuwDaUwZ=QaW9POb4U2tFJA60aLKD6QZKf60bq6g@mail.gmail.com>
 <CACRpkda0fmPdM2WZ_gtW=T7xvMfP_4ErtNZseExN2AggzZbcDQ@mail.gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Paolo Valente <paolo.valente@linaro.org>,
 Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>,
 Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>, Mark Brown
 <broonie@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Grant Likely <grant.likely@secretlab.ca>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3d0b38bb-537d-94ff-574f-587bad949fdd@kernel.dk>
Date: Fri, 28 Oct 2016 09:30:07 -0600
MIME-Version: 1.0
In-Reply-To: <CACRpkda0fmPdM2WZ_gtW=T7xvMfP_4ErtNZseExN2AggzZbcDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/28/2016 03:32 AM, Linus Walleij wrote:
> The patch to enable MQ looks like this:
> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-stericsson.git/commit/?h=mmc-mq&id=8f79b527e2e854071d8da019451da68d4753f71d

BTW, another viable "hack" for the depth issue would be to expose more
than one hardware queue. It's meant to map to a distinct submission
region in the hardware, but there's nothing stopping the driver from
using it differently. Might not be cleaner than just increasing the
queue depth on a single queue, though.

That still won't solve the issue of lying about it and causing IO
scheduler confusion, of course.

Also, 4.8 and newer have support for BLK_MQ_F_BLOCKING, if you need to
block in ->queue_rq(). That could eliminate the need to offload to a
kthread manually.

-- 
Jens Axboe
