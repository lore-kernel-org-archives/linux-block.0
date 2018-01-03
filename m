Return-Path: <ming.lei@redhat.com>
Date: Wed, 3 Jan 2018 09:29:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Vincent Batts <vbatts@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, NeilBrown <neilb@suse.com>,
	Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH 0/2] block: fix two regressiones on bounce
Message-ID: <20180103012931.GA9787@ming.t460p>
References: <20171218074044.1369-1-ming.lei@redhat.com>
 <8d1baf35-3f94-a6d7-7e05-0f90acbefde0@kernel.dk>
 <CANcsyS5YJZJO_JutN_WAusJjxHQ5-Gg3atNg76AEU+-48caS1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANcsyS5YJZJO_JutN_WAusJjxHQ5-Gg3atNg76AEU+-48caS1g@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hi Vincent,

On Tue, Jan 02, 2018 at 04:16:44PM -0500, Vincent Batts wrote:
> Will this set make it to the 4.14.x stable branch?

Greg has posted out the two patches for 4.14-stable review:

	https://marc.info/?l=linux-kernel&m=151481772722222&w=2

So it will be in 4.14.x stable branch soon.

Thanks,
Ming

> 
> vb
> 
> On Mon, Dec 18, 2017 at 3:22 PM, Jens Axboe <axboe@kernel.dk> wrote:
> > On 12/18/2017 12:40 AM, Ming Lei wrote:
> >> Hi Jens,
> >>
> >> The 1st patch makes sure that passthrough IO won't enter .make_request_fn.
> >>
> >> The 2nd one fixes blk_rq_append_bio(), which is from your post with
> >> small change on failure handling.
> >
> > Thanks Ming, queued up.
> >
> > --
> > Jens Axboe
> >

-- 
Ming
