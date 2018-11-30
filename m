Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A71C04EB9
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 02:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF8A2086B
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 02:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF8A2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeK3NVo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:21:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39954 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3NVo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 08:21:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 65B6014EEF71D;
        Thu, 29 Nov 2018 18:14:06 -0800 (PST)
Date:   Thu, 29 Nov 2018 18:14:03 -0800 (PST)
Message-Id: <20181129.181403.1046644111319738364.davem@davemloft.net>
To:     sagi@grimberg.me
Cc:     hch@lst.de, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        keith.busch@intel.com
Subject: Re: [PATCH v4 00/13] TCP transport binding for NVMe over Fabrics
From:   David Miller <davem@davemloft.net>
In-Reply-To: <133a9650-4413-8692-4200-9d54710e7358@grimberg.me>
References: <20181127231615.9446-1-sagi@grimberg.me>
        <20181128070116.GB20369@lst.de>
        <133a9650-4413-8692-4200-9d54710e7358@grimberg.me>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 29 Nov 2018 18:14:06 -0800 (PST)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>
Date: Thu, 29 Nov 2018 17:24:09 -0800

> 
>> What is the plan ahead here?  I think the nvme code looks pretty
>> reasonable now (I'll do another pass at nitpicking), but we need the
>> networking stuff sorted out with at least ACKs, or a merge through
>> the networking tree and then a shared branch we can pull in.
> 
> I would think that having Dave ack patches 1-3 and taking it via the
> nvme tree should be easier..
> 
> Dave? What would you prefer?

No preference, if the nvme tree makes things easier for you then
please do it that way.

Acked-by: David S. Miller <davem@davemloft.net>
