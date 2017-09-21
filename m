Return-Path: <keith.busch@intel.com>
Date: Thu, 21 Sep 2017 18:52:19 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/9] nvme: track subsystems
Message-ID: <20170921225218.GA4375@localhost.localdomain>
References: <20170918231453.27128-1-hch@lst.de>
 <20170918231453.27128-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170918231453.27128-7-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 18, 2017 at 04:14:50PM -0700, Christoph Hellwig wrote:
> +static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> +{
> +	struct nvme_subsystem *subsys, *found;
> +
> +	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
> +	if (!subsys)
> +		return -ENOMEM;
> +	INIT_LIST_HEAD(&subsys->ctrls);
> +	kref_init(&subsys->ref);
> +	nvme_init_subnqn(subsys, ctrl, id);
> +	mutex_init(&subsys->lock);
> +
> +	mutex_lock(&nvme_subsystems_lock);
> +	found = __nvme_find_get_subsystem(subsys->subnqn);
> +	if (found) {
> +		/*
> +		 * Verify that the subsystem actually supports multiple
> +		 * controllers, else bail out.
> +		 */
> +		kfree(subsys);
> +		if (!(id->cmic & (1 << 1))) {
> +			dev_err(ctrl->device,
> +				"ignoring ctrl due to duplicate subnqn (%s).\n",
> +				found->subnqn);
> +			mutex_unlock(&nvme_subsystems_lock);
> +			return -EINVAL;
> +		}
> +
> +		subsys = found;
> +	} else {
> +		list_add_tail(&subsys->entry, &nvme_subsystems);
> +	}
> +
> +	ctrl->subsys = subsys;
> +	mutex_unlock(&nvme_subsystems_lock);
> +
> +	mutex_lock(&subsys->lock);
> +	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
> +	mutex_unlock(&subsys->lock);

This function is called every time nvme_init_identify is called, which
happens on every controller reset. The controller reset does not remove
itself from the subsystem list of controllers, so its entry is getting
doubly added after a controller reset.
