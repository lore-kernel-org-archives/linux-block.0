Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27913C388F7
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 14:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C350D20809
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 14:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH7yYyRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgKJOQl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Nov 2020 09:16:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730306AbgKJOQk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 09:16:40 -0500
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D79892064B;
        Tue, 10 Nov 2020 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605017799;
        bh=yzAKnfzyFfX1zggSzmll1h/pqaUbZHH5azdI/mlAxEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZH7yYyRcW/p7+J4kcta9hCpwCwdv+d/BPmIa6oJHHZ2MpG7oDtNgGV7+OmI55v7ER
         ckBEcu5eZFAqc+N55MF92SKbfuuKDBOGIqKIqw9uAFCOMp5n3o1zKijQdkIzRSJylc
         H6l+gZflxsrEodfgEBer9Py2OuP6Wuh3mgtnoQd8=
Date:   Tue, 10 Nov 2020 06:16:36 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2] nvme: enable ro namespace for ZNS without append
Message-ID: <20201110141636.GD2221592@dhcp-10-100-145-180.wdc.com>
References: <20201110093938.25386-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110093938.25386-1-javier.gonz@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 10, 2020 at 10:39:38AM +0100, Javier González wrote:
>  	if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
>  			NVME_CMD_EFFECTS_CSUPP)) {
> +		set_bit(NVME_NS_FORCE_RO, &ns->flags);
>  		dev_warn(ns->ctrl->device,
> -			"append not supported for zoned namespace:%d\n",
> +			"append not supported for zoned namespace:%d. Forcing to read-only mode\n",
>  			ns->head->ns_id);
> -		return -EINVAL;
>  	}

In the unlikely event that a f/w upgrade adds append support, do we want
to bother clearing this flag? If so, we would need to refresh the
command effects log page.

If not, you'd have to rebind the driver to make it writable. I don't see
that as being a big deal, so I think the patch is probably fine as-is.
