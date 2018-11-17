Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB91C43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 20:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26B62080D
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 20:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26B62080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbeKRGc7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 01:32:59 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34564 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeKRGc7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 01:32:59 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2DD2F146F2BE5;
        Sat, 17 Nov 2018 12:15:11 -0800 (PST)
Date:   Sat, 17 Nov 2018 12:15:10 -0800 (PST)
Message-Id: <20181117.121510.1754018619653365187.davem@davemloft.net>
To:     sagi@lightbitslabs.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, hch@lst.de, keith.busch@intel.com
Subject: Re: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181115171626.9306-11-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
        <20181115171626.9306-11-sagi@lightbitslabs.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 17 Nov 2018 12:15:11 -0800 (PST)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>
Date: Thu, 15 Nov 2018 09:16:22 -0800

> +static unsigned nvmet_tcp_recv_budget = 8;
> +module_param_named(recv_budget, nvmet_tcp_recv_budget, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(recv_budget, "recvs budget");
> +
> +static unsigned nvmet_tcp_send_budget = 8;
> +module_param_named(send_budget, nvmet_tcp_send_budget, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(send_budget, "sends budget");
> +
> +static unsigned nvmet_tcp_io_work_budget = 64;
> +module_param_named(io_work_budget, nvmet_tcp_io_work_budget, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(io_work_budget, "io work budget");

I strongly suggest moving away from module parameters for this stuff.

Create a genetlink socket family and allow run time configuration of these knobs
by the user.

Thanks.
