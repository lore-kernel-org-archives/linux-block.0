Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Thu, 17 Nov 2016 05:16:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCH v1 6/7] nvme: Implement SED Unlock from suspend
Message-ID: <20161117131651.GB15852@infradead.org>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
 <1479338252-8777-7-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
In-Reply-To: <1479338252-8777-7-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@infradead.org, sagi@grimberg.me, axboe@fb.com,
 linux-nvme@lists.infradead.org, keith.busch@intel.com,
 Rafael.Antognolli@intel.com, linux-block@vger.kernel.org,
 jonathan.derrick@intel.com, j.naumann@fu-berlin.de
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

> +{
> +	struct opal_suspend_unlk ulk = { 0 };
> +	struct nvme_ns *ns;
> +	char diskname[DISK_NAME_LEN];
> +	mutex_lock(&ctrl->namespaces_mutex);
> +	if (list_empty(&ctrl->namespaces))
> +		goto out_no_namespace;
> +	ulk.data = ns =list_first_entry(&ctrl->namespaces, struct nvme_ns, list);

Simply grabbing a namespace without locking is broken.  That being
said..

> +	mutex_unlock(&ctrl->namespaces_mutex);
> +	snprintf(diskname, sizeof(diskname), "%sn%d",
> +		 dev_name(ctrl->device), ns->instance);
> +	ulk.name = diskname;
> +
> +	ulk.ops.send = nvme_sec_send;
> +	ulk.ops.recv = nvme_sec_recv;
> +	opal_unlock_from_suspend(&ulk);

passing a device _name_ to a lower level interface is even more
broken.  The Security Send/Receive commands operate on the NVMe
admin queue, and for SCSI and ATA that'd operate on the device.
So what we need to do here is to pass an object that identifies
the device - either the request queue if the opal code wants
to use it directly, or an opaqueue object that allows us to find
the nvme_ctrl.

Looking a bit at the actual low-level OPAL code it seems
like the driver should allocate the opal_dev structure when
setting up the device, and we should always pass it in.  But
maybe I need to understand that code a bit better first.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
