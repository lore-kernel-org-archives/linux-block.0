Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E272AC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 23:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7D320823
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 23:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7D320823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbeKTJoH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:44:07 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53258 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeKTJoH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 04:44:07 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AE77F14E17F0D;
        Mon, 19 Nov 2018 15:18:05 -0800 (PST)
Date:   Mon, 19 Nov 2018 15:18:05 -0800 (PST)
Message-Id: <20181119.151805.2250212740843808194.davem@davemloft.net>
To:     sagi@grimberg.me
Cc:     sagi@lightbitslabs.com, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, keith.busch@intel.com, hch@lst.de,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <f4997fa5-a0f1-2783-4732-15fbd7fcafd8@grimberg.me>
References: <21b60ffc-d9eb-2f2e-fa1a-891f7f8d5239@grimberg.me>
        <20181119.145343.2254073323355763213.davem@davemloft.net>
        <f4997fa5-a0f1-2783-4732-15fbd7fcafd8@grimberg.me>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 19 Nov 2018 15:18:06 -0800 (PST)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>
Date: Mon, 19 Nov 2018 15:14:44 -0800

> Also, looking a bit closer there is a slight difference between the
> copy vs. the copy_and_csum variants. copy allows for a short_copy if
> we copy less than we expect while the csum faults it. I'm thinking
> that the copy_and_hash variant should also fault? Although I'm not
> sure I understand the fault entirely as csum is supposed to be
> cumulative, any insight?

When we are writing and signal an error, sockets have this recurring
pattern where we return immediately the amount of bytes successfully
transferred.  Then on the next sendmsg() call we give the error.

I don't know if that is what is influencing the behavior here or not
but it could be.
