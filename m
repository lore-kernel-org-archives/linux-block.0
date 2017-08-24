Return-Path: <hch@lst.de>
Date: Thu, 24 Aug 2017 10:52:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 06/10] nvme: track subsystems
Message-ID: <20170824085210.GB19504@lst.de>
References: <20170823175815.3646-1-hch@lst.de> <20170823175815.3646-7-hch@lst.de> <20170823220434.GB16596@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823220434.GB16596@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 23, 2017 at 06:04:34PM -0400, Keith Busch wrote:
> > +	struct nvme_subsystem *subsys;
> > +
> > +	lockdep_assert_held(&nvme_subsystems_lock);
> > +
> > +	list_for_each_entry(subsys, &nvme_subsystems, entry) {
> > +		if (strcmp(subsys->subnqn, subsysnqn))
> > +			continue;
> > +		if (!kref_get_unless_zero(&subsys->ref))
> > +			continue;
> 
> You should be able to just return immediately here since there can't be
> a duplicated subsysnqn in the list.

We could have a race where we tear one subsystem instance down and
are setting up another one.

> > +	INIT_LIST_HEAD(&subsys->ctrls);
> > +	kref_init(&subsys->ref);
> > +	nvme_init_subnqn(subsys, ctrl, id);
> > +	mutex_init(&subsys->lock);
> > +
> > +	mutex_lock(&nvme_subsystems_lock);
> 
> This could be a spinlock instead of a mutex.

We could.  But given that the lock is not in the hot path there seems
to be no point in making it a spinlock.

> > +	found = __nvme_find_get_subsystem(subsys->subnqn);
> > +	if (found) {
> > +		/*
> > +		 * Verify that the subsystem actually supports multiple
> > +		 * controllers, else bail out.
> > +		 */
> > +		kfree(subsys);
> > +		if (!(id->cmic & (1 << 1))) {
> > +			dev_err(ctrl->device,
> > +				"ignoring ctrl due to duplicate subnqn (%s).\n",
> > +				found->subnqn);
> > +			mutex_unlock(&nvme_subsystems_lock);
> > +			return -EINVAL;
> 
> Returning -EINVAL here will cause nvme_init_identify to fail. Do we want
> that to happen here? I think we want to be able to manage controllers
> in such a state, but just checking if there's a good reason to not allow
> them.

Without this we will get duplicate nvme_subsystem structures, messing
up the whole lookup.  We could mark them as buggy with a flag and
make sure controllers without CMIC bit 1 set will never be linked.
