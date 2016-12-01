Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Wed, 30 Nov 2016 19:50:41 -0500
From: Keith Busch <keith.busch@intel.com>
To: Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCH v2 3/4] nvme: Implement resume_from_suspend and sed block
 ioctl
Message-ID: <20161201005040.GF21081@localhost.localdomain>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
 <1480456322-27339-4-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
In-Reply-To: <1480456322-27339-4-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@infradead.org, sagi@grimberg.me, Rafael.Antognolli@intel.com,
 linux-nvme@lists.infradead.org, axboe@fb.com, linux-block@vger.kernel.org,
 jonathan.derrick@intel.com, j.naumann@fu-berlin.de
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 29, 2016 at 02:52:01PM -0700, Scott Bauer wrote:
> +static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer,
> +			   size_t len, bool send)
> +{
> +	struct request_queue *q;
> +	struct request *req;
> +	struct nvme_ns *ns;
> +	struct nvme_command cmd = { 0 };
> +	int ret;
> +
> +	ns = data;
> +
> +	if (send)
> +		cmd.common.opcode = (u8)nvme_admin_security_send;
> +	else
> +		cmd.common.opcode = (u8)nvme_admin_security_recv;
> +
> +	cmd.common.nsid = ns->ns_id;
> +	cmd.common.cdw10[0] = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
> +	cmd.common.cdw10[1] = cpu_to_le32(len);
> +
> +	q = ns->ctrl->admin_q;
> +
> +	req = nvme_alloc_request(q, &cmd, 0, NVME_QID_ANY);
> +	if (IS_ERR(req)) {
> +		ret = PTR_ERR(req);
> +		return ret;
> +	}
> +
> +	req->timeout = ADMIN_TIMEOUT;
> +	req->special = NULL;
> +
> +	if (buffer && len) {
> +		ret = blk_rq_map_kern(q, req, buffer, len, GFP_KERNEL);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	ret = blk_execute_rq(req->q, ns->disk, req, 1);

I think you want to use the __nvme_submit_sync_command API instead of
duplicating some of the things it does for you.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
