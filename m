Return-Path: <keith.busch@intel.com>
Date: Tue, 12 Sep 2017 12:00:44 -0400
From: Keith Busch <keith.busch@intel.com>
To: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 01/10] Initial multipath implementation.
Message-ID: <20170912160043.GB2832@localhost.localdomain>
References: <20170912042149.drr5dumro5grm7iu@haynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170912042149.drr5dumro5grm7iu@haynes>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 11, 2017 at 09:21:49PM -0700, Anish M Jhaveri wrote:
>  struct nvme_ctrl_ops {
> @@ -277,6 +307,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
>  int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
>  int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
> +struct nvme_ctrl *nvme_init_mpath_ctrl(struct nvme_ctrl *ctrl);
>  int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>  		const struct nvme_ctrl_ops *ops, unsigned long quirks);
>  void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
> @@ -287,6 +318,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
>  
>  void nvme_queue_scan(struct nvme_ctrl *ctrl);
>  void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
> +void nvme_trigger_failover(struct nvme_ctrl *ctrl);
> +int nvme_set_ns_active(struct nvme_ns *standby_ns, struct nvme_ns *mpath_ns,
> +		int retry_cnt);
>  
>  int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
>  		bool send);
> @@ -325,6 +359,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
>  void nvme_start_keep_alive(struct nvme_ctrl *ctrl);
>  void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
>  int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
> +void nvme_mpath_ns_remove(struct nvme_ns *ns);
>  
>  #ifdef CONFIG_NVM
>  int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *id);

I find this patch series confusing to review. You declare these failover
functions in patch 1, use them in patch 2, but they're not defined until
patch 7.
