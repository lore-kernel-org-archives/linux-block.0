Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B074C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 22:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0202080C
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 22:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0202080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbeKTJTj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:19:39 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52692 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbeKTJTj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 04:19:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B71DC14C7C41A;
        Mon, 19 Nov 2018 14:53:43 -0800 (PST)
Date:   Mon, 19 Nov 2018 14:53:43 -0800 (PST)
Message-Id: <20181119.145343.2254073323355763213.davem@davemloft.net>
To:     sagi@grimberg.me
Cc:     sagi@lightbitslabs.com, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, keith.busch@intel.com, hch@lst.de,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <21b60ffc-d9eb-2f2e-fa1a-891f7f8d5239@grimberg.me>
References: <20181115171626.9306-11-sagi@lightbitslabs.com>
        <20181117.121510.1754018619653365187.davem@davemloft.net>
        <21b60ffc-d9eb-2f2e-fa1a-891f7f8d5239@grimberg.me>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 19 Nov 2018 14:53:44 -0800 (PST)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>
Date: Mon, 19 Nov 2018 13:26:12 -0800

> I would love you to look at skb_copy_and_hash_datagram_iter as these
> changes will require an ack from you.

My first impression is that we now have this kind of code pattern
in at least two main places and now this will be a third.

I know that nobody likes callbacks because of spectre, but all of
these cases could be done with something like:

int __skb_datagram_iter(const struct sk_buff *skb, int offset,
			struct iov_iter *to, int len,
			int (*cb)(void *, int, struct iov_iter *, void *),
			void *data)
{
	...
		n = cb(skb->data + offset, copy, to, data);
	...
}

You get the idea.  Then we have one version of all the loops and
the different (copy, copy+csum, copy+hash) cases all can be
handled by __skb_datagram_iter() but just with a different 'cb'
and private 'data'.

