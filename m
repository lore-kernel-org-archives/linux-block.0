Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADFDC388F7
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 22:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B352207D3
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 22:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7eV344b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgKJWJp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Nov 2020 17:09:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgKJWJp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 17:09:45 -0500
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77B7920781;
        Tue, 10 Nov 2020 22:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605046184;
        bh=b+SFQtqHEdQhbaPIOA83WMmw90NiKcsRwqBghRiSRzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7eV344bjcIhDYWUE+K3JesM5FFIc7SKCobWibaoWwbDwx/vNGdprniyL3Pw+hqIt
         hdOv0RXrmWwXvf1xzLXnDveeo3UOjQjqTHuRB5stiBMsG80hwGs86IEt/xMZEdZTrU
         RQ9m1ug2cQCR/kd/6pXuoO/ppJ0NkF89oNprGwP0=
Date:   Tue, 10 Nov 2020 14:09:41 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V3] nvme: enable ro namespace for ZNS without append
Message-ID: <20201110220941.GA2225168@dhcp-10-100-145-180.wdc.com>
References: <20201110210708.5912-1-javier@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110210708.5912-1-javier@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 10, 2020 at 10:07:08PM +0100, javier@javigon.com wrote:
> -	if (id->nsattr & NVME_NS_ATTR_RO)
> +	if (id->nsattr & NVME_NS_ATTR_RO || test_bit(NVME_NS_FORCE_RO, &ns->flags))
>  		set_disk_ro(disk, true);

If the FORCE_RO flag is set, the disk is set to read-only. If that flag
is later cleared, nothing clears the disk's read-only setting.

> +	/* Refresh effects log page to check for changes on append support */
> +	status = nvme_get_effects_log(ns->ctrl, ns->head->ids.csi, &ns->head->effects);

That function just returns the cached log; no refresh occurs there.
