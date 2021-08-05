Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15361C432BE
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 07:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE65060ED6
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 07:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbhHEHLu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhHEHLu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Aug 2021 03:11:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1573C60F41;
        Thu,  5 Aug 2021 07:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628147495;
        bh=O9a3HRs73pQwCyxWN42LGJZX4aJ9FyFEg8Z3U4/fTgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZfpnjYf8skjAt9pwnu7FHoGa5dMwu/nYzyOjxpzFInxHKUbssI/eXFFe6e6oaYWgH
         pLlf+qR5fT8ASoRhTjeohzR6aZjPHprE86aqSmmGG5NQpUfhKAEMYvz7CQHwguiaKQ
         n+yhFChuHRf5QMQfpe7eyHLuK/hbgNTjjiGa5Q2o=
Date:   Thu, 5 Aug 2021 09:11:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     longli@linuxonhyperv.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, Long Li <longli@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, linux-doc@vger.kernel.org
Subject: Re: [Patch v5 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YQuPJUX4+HZ3FeKC@kroah.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <1628146812-29798-3-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628146812-29798-3-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 05, 2021 at 12:00:11AM -0700, longli@linuxonhyperv.com wrote:
> +static int az_blob_create_device(struct az_blob_device *dev)
> +{
> +	int ret;
> +	struct dentry *debugfs_root;
> +
> +	dev->misc.minor	= MISC_DYNAMIC_MINOR,
> +	dev->misc.name	= "azure_blob",
> +	dev->misc.fops	= &az_blob_client_fops,
> +
> +	ret = misc_register(&dev->misc);
> +	if (ret)
> +		return ret;
> +
> +	debugfs_root = debugfs_create_dir("az_blob", NULL);

So you try to create a directory in the root of debugfs called "az_blob"
for every device in the system of this one type?

That will blow up when you have multiple devices of the same type,
please fix.

thanks,

greg k-h
