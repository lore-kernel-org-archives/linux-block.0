Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DB4C433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 21:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42193207D8
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 21:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593121765;
	bh=0kQClpfN+7bHE6QT6+asDHd2oJRChHBrwWMSwfQoLy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GUr9vgFozMLtu1KAVT5Xp/oQ4jajZekJHXWJtp4IK7dsTd+8d02oPbDUy84zPXudE
	 /qUJMJOgOgAXuMhp3CA2/p30PZ7V9whl+cRivSHAmJdKhluA9aiwgNhHE3Xdcz7f1b
	 DuczGmcGqg9AOulnk/qt9p6dpsvKgU4Ahv8NGhtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390636AbgFYVtY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389963AbgFYVtY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 17:49:24 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 224AF20709;
        Thu, 25 Jun 2020 21:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593121763;
        bh=0kQClpfN+7bHE6QT6+asDHd2oJRChHBrwWMSwfQoLy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWZFPZNvupekAoID/cPmCOZ49p3EvPk+F/4UKVdDJFvZqwlm4LmuFGJZU/wjsrHEa
         Yq5Q+wkrPiEokOmPbYOpNLBVHcbUPJjDIRH8mXTqNFNZrSTqzQDrHTj4QyuXKawC6H
         OUN1GXhGjhi1WS5OlxR2qrSMvrZ+x8O14JFvxIh0=
Date:   Thu, 25 Jun 2020 14:49:21 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Message-ID: <20200625214921.GA1773527@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625122152.17359-7-javier@javigon.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 25, 2020 at 02:21:52PM +0200, Javier González wrote:
>  drivers/nvme/host/zns.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 7d8381fe7665..de806788a184 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -234,6 +234,13 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  		sector += ns->zsze * nz;
>  	}
>  
> +	if (nr_zones < 0 && zone_idx != ns->nr_zones) {
> +		dev_err(ns->ctrl->device, "inconsistent zone count %u/%u\n",
> +				zone_idx, ns->nr_zones);
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
>  	ret = zone_idx;

nr_zones is unsigned, so it's never < 0.

The API we're providing doesn't require zone_idx equal the namespace's
nr_zones at the end, though. A subset of the total number of zones can
be requested here.
