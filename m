Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:55231 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753147AbcKPX7N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 18:59:13 -0500
Date: Wed, 16 Nov 2016 19:09:18 -0500
From: Keith Busch <keith.busch@intel.com>
To: Scott Bauer <scott.bauer@intel.com>
Cc: linux-nvme@lists.infradead.org, Rafael.Antognolli@intel.com,
        axboe@fb.com, jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org, sagi@grimberg.me
Subject: Re: [PATCH v1 5/7] nvme: Implement SED Security Operations
Message-ID: <20161117000918.GF10050@localhost.localdomain>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
 <1479338252-8777-6-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479338252-8777-6-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 16, 2016 at 04:17:30PM -0700, Scott Bauer wrote:
> +static int nvme_sec_submit(void *data, u8 opcode, u16 SPSP,
> +			   u8 SECP, void *buffer, size_t len,
> +			   sec_cb *cb, void *cb_data)
> +{
> +	struct request_queue *q;
> +	struct request *req;
> +	struct sed_cb_data *sed_data;
> +	struct nvme_ns *ns;
> +	struct nvme_command *cmd;
> +	int ret;
> +
> +	ns = data;
> +
> +	sed_data = kzalloc(sizeof(*sed_data), GFP_NOWAIT);
> +	if (!sed_data)
> +		return -ENOMEM;
> +	sed_data->cb = cb;
> +	sed_data->cb_data = cb_data;
> +	cmd = &sed_data->cmd;
> +
> +	cmd->common.opcode = opcode;
> +	cmd->common.nsid = ns->ns_id;
> +	cmd->common.cdw10[0] = SECP << 24 | SPSP << 8;
> +	cmd->common.cdw10[1] = len;

Need to use the write cpu_to_le* conversions.

> +	q = ns->ctrl->admin_q;
> +
> +	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
> +	if (IS_ERR(req)) {
> +		ret = PTR_ERR(req);
> +		goto err_free;
> +	}
> +
> +	req->timeout = ADMIN_TIMEOUT;
> +	req->special = NULL;
> +
> +	if (buffer && len) {
> +		ret = blk_rq_map_kern(q, req, buffer, len, GFP_NOWAIT);
> +		if (ret) {
> +			blk_mq_free_request(req);
> +			goto err_free;
> +		}
> +	}
> +
> +	req->end_io_data = sed_data;
> +
> +	blk_execute_rq_nowait(q, ns->disk, req, 1, sec_submit_endio);
> +	return 0;
> +
> +err_free:
> +	kfree(sed_data);

Missing 'return ret;', here.

> +}
