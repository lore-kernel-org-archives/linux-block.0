Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCEDC4361B
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 22:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C8022D05
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 22:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgLOWrI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 17:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbgLOWrF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 17:47:05 -0500
Date:   Tue, 15 Dec 2020 14:46:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608072369;
        bh=KmhdxbEWbjxMgbM9k85U/Oe2ahWpdxp/ya5SYYDbN9w=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=KVqbps7s/RWiBNzxVbl6ITd1IvxXUuDVZX6Uu4EKtJxkA12AXE9Hvp+yXxqvcR5Cx
         RNFFUxdCHOxuum+vrPbcuUh3JAT7KC/aRwRiEGY3LcWw2r0rJkgCk2L4ifShp6QTts
         KjNQET7h7GBInbWRW5jnEoSyXv0N8AGkc+7jNjeEtF+UXnm7gICqKXXR6gPMKKaK2b
         e6NII92AdMVuCB8e+qEv0F1kO+FR47Pn/8X/ezFyr0Fo2ESJbg9zLAcmQGyhbmP0kx
         ee5wOmIPgguWqMC8IvZkS0a7NjdO+zu7AH4Z1PEKjSyuU6uHsWHt5tWalPdtoUQvoM
         Y0qwu2YpR55iw==
From:   Keith Busch <kbusch@kernel.org>
To:     javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, minwoo.im.dev@gmail.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V3] nvme: enable char device per namespace
Message-ID: <20201215224607.GB3915989@dhcp-10-100-145-180.wdc.com>
References: <20201215195557.30169-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215195557.30169-1-javier.gonz@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 15, 2020 at 08:55:57PM +0100, javier@javigon.com wrote:
> +static int nvme_alloc_chardev_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
> +{
> +	char cdisk_name[DISK_NAME_LEN];
> +	int ret;
> +
> +	device_initialize(&ns->cdev_device);
> +	ns->cdev_device.devt = MKDEV(MAJOR(nvme_ns_base_chr_devt),
> +				     ns->head->instance);

Ah, I see now. We are making these generic handles for each path, but
the ns->head->instance is the same for all paths to a namespace, so it's
not unique for that. Further, that head->instance is allocated per
subsystem, so it's not unique from namespace heads seen in other
subsystems.

So, I think you need to allocate a new dev_t for each subsystem rather
than the global nvme_ns_base_chr_devt, and I guess we also need a new
nvme_ns instance field assigned from yet another ida?
