Return-Path: <keith.busch@intel.com>
Date: Wed, 23 Aug 2017 18:04:34 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/10] nvme: track subsystems
Message-ID: <20170823220434.GB16596@localhost.localdomain>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823175815.3646-7-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Looks great. A few minor comments below.

On Wed, Aug 23, 2017 at 07:58:11PM +0200, Christoph Hellwig wrote:
> +static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
> +{
> +	struct nvme_subsystem *subsys;
> +
> +	lockdep_assert_held(&nvme_subsystems_lock);
> +
> +	list_for_each_entry(subsys, &nvme_subsystems, entry) {
> +		if (strcmp(subsys->subnqn, subsysnqn))
> +			continue;
> +		if (!kref_get_unless_zero(&subsys->ref))
> +			continue;

You should be able to just return immediately here since there can't be
a duplicated subsysnqn in the list.

> +		return subsys;
> +	}
> +
> +	return NULL;
> +}
> +
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

This could be a spinlock instead of a mutex.

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

Returning -EINVAL here will cause nvme_init_identify to fail. Do we want
that to happen here? I think we want to be able to manage controllers
in such a state, but just checking if there's a good reason to not allow
them.

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
> +
> +	return 0;
>  }
>  
>  /*
> @@ -1801,7 +1882,11 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		return -EIO;
>  	}
>  
> -	nvme_init_subnqn(ctrl, id);
> +	ret = nvme_init_subsystem(ctrl, id);
> +	if (ret) {
> +		kfree(id);
> +		return ret;
> +	}
