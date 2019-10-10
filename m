Return-Path: <SRS0=jW7Q=YD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574B5C10F14
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3706F2053B
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 11:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfJJLh7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 07:37:59 -0400
Received: from verein.lst.de ([213.95.11.211]:57706 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfJJLh7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 07:37:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 22A1F68C65; Thu, 10 Oct 2019 13:37:54 +0200 (CEST)
Date:   Thu, 10 Oct 2019 13:37:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 01/12] nvme-core: introduce nvme_ctrl_get_by_path()
Message-ID: <20191010113754.GA28921@lst.de>
References: <20191009192530.13079-1-logang@deltatee.com> <20191009192530.13079-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-2-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
> +{
> +	struct nvme_ctrl *ctrl;
> +	struct file *f;
> +
> +	f = filp_open(path, O_RDWR, 0);
> +	if (IS_ERR(f))
> +		return ERR_CAST(f);
> +
> +	if (f->f_op != &nvme_dev_fops) {
> +		ctrl = ERR_PTR(-EINVAL);
> +		goto out_close;
> +	}
> +
> +	ctrl = f->private_data;
> +	nvme_get_ctrl(ctrl);
> +
> +out_close:
> +	filp_close(f, NULL);
> +
> +	return ctrl;

No need for the empty line here.  Also can you make sure this new
code (and all the new exports) are only enabled if
CONFIG_NVME_TARGET_PASSTHRU is set.  Preferably by having a little
block at the end of this file with this function and the extra
exports with a big fat comment that they are only for nvmet-passthrough.
