Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.com" <hare@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v3 1/5] blk-mq: Make it safe to use RCU to iterate over
 blk_mq_tag_set.tag_list
Date: Fri, 7 Apr 2017 15:15:13 +0000
Message-ID: <1491578112.2559.5.camel@sandisk.com>
References: <20170406181050.12137-1-bart.vanassche@sandisk.com>
	 <20170406181050.12137-2-bart.vanassche@sandisk.com>
	 <20170407094623.GD27631@ming.t460p>
In-Reply-To: <20170407094623.GD27631@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-04-07 at 17:46 +0800, Ming Lei wrote:
> On Thu, Apr 06, 2017 at 11:10:46AM -0700, Bart Van Assche wrote:
> > Since the next patch in this series will use RCU to iterate over
> > tag_list, make this safe. Add lockdep_assert_held() statements
> > in functions that iterate over tag_list to make clear that using
> > list_for_each_entry() instead of list_for_each_entry_rcu() is
> > fine in these functions.
> >=20
> > Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Hannes Reinecke <hare@suse.com>
> > ---
> >  block/blk-mq.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index f7cd3208bcdf..b5580b09b4a5 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2076,6 +2076,8 @@ static void blk_mq_update_tag_set_depth(struct bl=
k_mq_tag_set *set, bool shared)
> >  {
> >  	struct request_queue *q;
> > =20
> > +	lockdep_assert_held(&set->tag_list_lock);
> > +
> >  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> >  		blk_mq_freeze_queue(q);
> >  		queue_set_hctx_shared(q, shared);
> > @@ -2096,6 +2098,8 @@ static void blk_mq_del_queue_tag_set(struct reque=
st_queue *q)
> >  		blk_mq_update_tag_set_depth(set, false);
> >  	}
> >  	mutex_unlock(&set->tag_list_lock);
> > +
> > +	synchronize_rcu();
>=20
> Looks synchronize_rcu() is only needed in deletion path, so it can
> be moved to blk_mq_del_queue_tag_set().
>=20
> Also list_del_init/list_add_tail() need to be replaced with RCU
> safe version in functions operating &set->tag_list.

Hello Ming,

I will replace list_del_init() / list_add_tail() by their RCU equivalents.

Regarding synchronize_rcu(): have you noticed that that call has been added=
 to
blk_mq_del_queue_tag_set(), the function you requested to move that call to=
?

Bart.=
