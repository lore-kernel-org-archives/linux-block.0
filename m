Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Wise <swise@opengridcomputing.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
Date: Thu, 1 Mar 2018 13:03:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180228234006.21093-11-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> We create a configfs attribute in each nvme-fabrics target port to
> enable p2p memory use. When enabled, the port will only then use the
> p2p memory if a p2p memory device can be found which is behind the
> same switch as the RDMA port and all the block devices in use. If
> the user enabled it an no devices are found, then the system will
> silently fall back on using regular memory.
> 
> If appropriate, that port will allocate memory for the RDMA buffers
> for queues from the p2pmem device falling back to system memory should
> anything fail.

Nice.

> Ideally, we'd want to use an NVME CMB buffer as p2p memory. This would
> save an extra PCI transfer as the NVME card could just take the data
> out of it's own memory. However, at this time, cards with CMB buffers
> don't seem to be available.

Can you describe what would be the plan to have it when these devices
do come along? I'd say that p2p_dev needs to become a nvmet_ns reference
and not from nvmet_ctrl. Then, when cmb capable devices come along, the
ns can prefer to use its own cmb instead of locating a p2p_dev device?

> +static int nvmet_p2pdma_add_client(struct nvmet_ctrl *ctrl,
> +				   struct nvmet_ns *ns)
> +{
> +	int ret;
> +
> +	if (!blk_queue_pci_p2pdma(ns->bdev->bd_queue)) {
> +		pr_err("peer-to-peer DMA is not supported by %s\n",
> +		       ns->device_path);
> +		return -EINVAL;

I'd say that just skip it instead of failing it, in theory one can
connect nvme devices via p2p mem and expose other devices in the
same subsystem. The message would be pr_debug to reduce chattiness.

> +	}
> +
> +	ret = pci_p2pdma_add_client(&ctrl->p2p_clients, nvmet_ns_dev(ns));
> +	if (ret)
> +		pr_err("failed to add peer-to-peer DMA client %s: %d\n",
> +		       ns->device_path, ret);
> +
> +	return ret;
> +}
> +
>   int nvmet_ns_enable(struct nvmet_ns *ns)
>   {
>   	struct nvmet_subsys *subsys = ns->subsys;
> @@ -299,6 +319,14 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>   	if (ret)
>   		goto out_blkdev_put;
>   
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (ctrl->p2p_dev) {
> +			ret = nvmet_p2pdma_add_client(ctrl, ns);
> +			if (ret)
> +				goto out_remove_clients;

Is this really a fatal failure given that we fall-back to main
memory? Why not continue with main memory (and warn at best)?

> +/*
> + * If allow_p2pmem is set, we will try to use P2P memory for the SGL lists for
> + * Ι/O commands. This requires the PCI p2p device to be compatible with the
> + * backing device for every namespace on this controller.
> + */
> +static void nvmet_setup_p2pmem(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
> +{
> +	struct nvmet_ns *ns;
> +	int ret;
> +
> +	if (!req->port->allow_p2pmem || !req->p2p_client)
> +		return;
> +
> +	mutex_lock(&ctrl->subsys->lock);
> +
> +	ret = pci_p2pdma_add_client(&ctrl->p2p_clients, req->p2p_client);
> +	if (ret) {
> +		pr_err("failed adding peer-to-peer DMA client %s: %d\n",
> +		       dev_name(req->p2p_client), ret);
> +		goto free_devices;
> +	}
> +
> +	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
> +		ret = nvmet_p2pdma_add_client(ctrl, ns);
> +		if (ret)
> +			goto free_devices;
> +	}
> +
> +	ctrl->p2p_dev = pci_p2pmem_find(&ctrl->p2p_clients);

This is the first p2p_dev found right? What happens if I have more than
a single p2p device? In theory I'd have more p2p memory I can use. Have
you considered making pci_p2pmem_find return the least used suitable
device?

> +	if (!ctrl->p2p_dev) {
> +		pr_info("no supported peer-to-peer memory devices found\n");
> +		goto free_devices;
> +	}
> +	mutex_unlock(&ctrl->subsys->lock);
> +
> +	pr_info("using peer-to-peer memory on %s\n", pci_name(ctrl->p2p_dev));
> +	return;
> +
> +free_devices:
> +	pci_p2pdma_client_list_free(&ctrl->p2p_clients);
> +	mutex_unlock(&ctrl->subsys->lock);
> +}
> +
> +static void nvmet_release_p2pmem(struct nvmet_ctrl *ctrl)
> +{
> +	if (!ctrl->p2p_dev)
> +		return;
> +
> +	mutex_lock(&ctrl->subsys->lock);
> +
> +	pci_p2pdma_client_list_free(&ctrl->p2p_clients);
> +	pci_dev_put(ctrl->p2p_dev);
> +	ctrl->p2p_dev = NULL;
> +
> +	mutex_unlock(&ctrl->subsys->lock);
> +}
> +
>   u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp)
>   {
> @@ -800,6 +890,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   
>   	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
>   	INIT_LIST_HEAD(&ctrl->async_events);
> +	INIT_LIST_HEAD(&ctrl->p2p_clients);
>   
>   	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
>   	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
> @@ -855,6 +946,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   		ctrl->kato = DIV_ROUND_UP(kato, 1000);
>   	}
>   	nvmet_start_keep_alive_timer(ctrl);
> +	nvmet_setup_p2pmem(ctrl, req);
>   
>   	mutex_lock(&subsys->lock);
>   	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
> @@ -891,6 +983,7 @@ static void nvmet_ctrl_free(struct kref *ref)
>   	flush_work(&ctrl->async_event_work);
>   	cancel_work_sync(&ctrl->fatal_err_work);
>   
> +	nvmet_release_p2pmem(ctrl);
>   	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
>   
>   	kfree(ctrl->sqs);
> diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
> index 28bbdff4a88b..a213f8fc3bf3 100644
> --- a/drivers/nvme/target/io-cmd.c
> +++ b/drivers/nvme/target/io-cmd.c
> @@ -56,6 +56,9 @@ static void nvmet_execute_rw(struct nvmet_req *req)
>   		op = REQ_OP_READ;
>   	}
>   
> +	if (is_pci_p2pdma_page(sg_page(req->sg)))
> +		op_flags |= REQ_PCI_P2PDMA;
> +
>   	sector = le64_to_cpu(req->cmd->rw.slba);
>   	sector <<= (req->ns->blksize_shift - 9);
>   
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 417f6c0331cc..85a170914588 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -64,6 +64,11 @@ static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
>   	return container_of(to_config_group(item), struct nvmet_ns, group);
>   }
>   
> +static inline struct device *nvmet_ns_dev(struct nvmet_ns *ns)
> +{
> +	return disk_to_dev(ns->bdev->bd_disk);
> +}
> +
>   struct nvmet_cq {
>   	u16			qid;
>   	u16			size;
> @@ -98,6 +103,7 @@ struct nvmet_port {
>   	struct list_head		referrals;
>   	void				*priv;
>   	bool				enabled;
> +	bool				allow_p2pmem;
>   };
>   
>   static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
> @@ -131,6 +137,8 @@ struct nvmet_ctrl {
>   	struct work_struct	fatal_err_work;
>   
>   	struct nvmet_fabrics_ops *ops;
> +	struct pci_dev		*p2p_dev;
> +	struct list_head	p2p_clients;
>   
>   	char			subsysnqn[NVMF_NQN_FIELD_LEN];
>   	char			hostnqn[NVMF_NQN_FIELD_LEN];
> @@ -232,6 +240,8 @@ struct nvmet_req {
>   
>   	void (*execute)(struct nvmet_req *req);
>   	struct nvmet_fabrics_ops *ops;
> +
> +	struct device *p2p_client;
>   };
>   
>   static inline void nvmet_set_status(struct nvmet_req *req, u16 status)
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 020354e11351..7a1f09995ed5 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -23,6 +23,7 @@
>   #include <linux/string.h>
>   #include <linux/wait.h>
>   #include <linux/inet.h>
> +#include <linux/pci-p2pdma.h>
>   #include <asm/unaligned.h>
>   
>   #include <rdma/ib_verbs.h>
> @@ -68,6 +69,7 @@ struct nvmet_rdma_rsp {
>   	u8			n_rdma;
>   	u32			flags;
>   	u32			invalidate_rkey;
> +	struct pci_dev		*p2p_dev;

Given that p2p_client is in nvmet_req, I think it make sense
that the p2p_dev itself would also live there. In theory, nothing
is preventing FC from using it as well.
