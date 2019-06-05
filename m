Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CDEC28D18
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 20:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC4320872
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 20:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jn33M/OL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfFEUWj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:22:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38430 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfFEUWi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jun 2019 16:22:38 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so65310qkk.5
        for <linux-block@vger.kernel.org>; Wed, 05 Jun 2019 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hdVKMo8506TgrZK1PYQwv5IIzq/3ub7YoF/TJnHz4iQ=;
        b=jn33M/OLPMrHDhWB/oB3uBW6KyUZwZ3dHbeuh1XlGJHpj6dwZhMsOO5OOrjM6STAk4
         qROquiS6fMH0HrsaHJQe7IWfco1/3CwVA1Gz+FGmFpUONVqiEw31nfTAMmDzWlOeuUEZ
         mk6d5RDBk04fmPauqpzDR3UBYRMhcvzlsYSc74mHKl9XePav6wRDF+ORoRV2fKHFG/sb
         cUQUGUyyBaCwXiDs4NT1HvJhutfWYLBEeCwb+RHe4UP0YFMmyv3lmlZz7HJMeHb2peh0
         c0KHydFemqtXhwO8HH1TOYZIPA8HQnsiNT2WYwoU7yhfgAcf8QGzWgN4SKzBFML0mJnJ
         tpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hdVKMo8506TgrZK1PYQwv5IIzq/3ub7YoF/TJnHz4iQ=;
        b=dLuZynbkwbRqzkGJtsJ4nggyc+OrzqSc/Y7DNBwXxzvZP+ui30g3AoSrqHUni6y677
         AVLwbm+Gq5Bmecoqa8WjK85OcaoyxdBFSdBNkubxxdaPh0iIT9vZa4P7432bQsBdTuYa
         Zv6tuK+TNZ1nGzC3DqUyY3SDLSHsxnZzC+edP9W5dj+QkMtfolgcXZi9cjQo95CiJ/a3
         v5PB1GfcUrjaaELqt1cOhX5UnbA42mhXD28qRz4/RuzTroLIKBIrpsc2/gIXhHyWYud/
         KaKHonzeqOk6JX6+WU08mbYvhraKsb5FAJ66FISnXxn0RCXaGP4qhrbQAwGjEZfIcOrG
         sSxQ==
X-Gm-Message-State: APjAAAW0bHHIW+2iWNtDg5EyZGrXwnYqCH6y/Se51oPDpl/pSiqZv6WK
        HjpETtq3WgWYCLrqs00XwltH9Q==
X-Google-Smtp-Source: APXvYqzsyiPSTmn82JkgPtH+Z1+lnK81jan/CvvnzRGGA4oYrI2ETBGBe6mNB1mjYk7SLXHnNDomow==
X-Received: by 2002:a37:6312:: with SMTP id x18mr35736460qkb.300.1559766157655;
        Wed, 05 Jun 2019 13:22:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v9sm884883qti.60.2019.06.05.13.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 13:22:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYcQd-0002uk-Vd; Wed, 05 Jun 2019 17:22:35 -0300
Date:   Wed, 5 Jun 2019 17:22:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] IB/iser: set virt_boundary_mask in the scsi host
Message-ID: <20190605202235.GC3273@ziepe.ca>
References: <20190605190836.32354-1-hch@lst.de>
 <20190605190836.32354-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605190836.32354-9-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 05, 2019 at 09:08:31PM +0200, Christoph Hellwig wrote:
> This ensures all proper DMA layer handling is taken care of by the
> SCSI midlayer.

Maybe not entirely related to this series, but it looks like the SCSI
layer is changing the device global dma_set_max_seg_size() - at least
in RDMA the dma device is being shared between many users, so we
really don't want SCSI to make this value smaller.

Can we do something about this?

Wondering about other values too, and the interaction with the new
combining stuff in umem.c

Thanks,
Jason
