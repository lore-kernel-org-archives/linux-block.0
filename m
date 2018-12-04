Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0612CC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B975B20834
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1nhPZnzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B975B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbeLDSkV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:40:21 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:54800 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDSkU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 13:40:20 -0500
Received: by mail-it1-f176.google.com with SMTP id i145so17078877ita.4
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 10:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1+JDQ/NnX6tG1n8cbWDk+0wKzjEzGeT4Hsf8t0KdPw4=;
        b=1nhPZnzj34EtoKokIFRYgJmp60PvtGTIH9dIL59nlbRG+tt43Wcv4aJWQBBUq0I+cp
         Oeve1pVqVI/Q4ao6gZE+8wo3DU869TZDQz+M5wqEFLDRy6z3KXj4sekYpbfjRXjMdz28
         1QH4J4nQFDD5kTKZk0mJFkOALouN+CkkMonX7NSQryNXFSSjWUa1YszTEyT7mUjo2akX
         XkdSQi+hz+QIUBRR93PV3bPSQabMf1Vc08TbKnL4N/sB6qOsiTFQS6FHBXlyi2k8OswO
         AQ9AsgkvuNFZg6oQdgPfteMEJXA5znEmeEzi+9kO7jh2HUm84d1qIpKAJWfdKWFcHAzh
         6ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1+JDQ/NnX6tG1n8cbWDk+0wKzjEzGeT4Hsf8t0KdPw4=;
        b=JLfdg+UZgGurQo0DEp0rMR1DZEiqe2HwytFFbBL5kJW556Vu00WXpvXsz0zTN31Ecg
         4RZ9fknTzP+oz1oA/pQHM6L6j31TdNxQNB46KE1Qwu6FrtvFkHiPNFxxM/G+lPxnOr9z
         7EI1fNmy0W/xFgGMQN2H0mwhVcISsJFOhnCwcFZqiVVYDnlqj4mIP21eIw90m0d+Rp/C
         RlHWFAsUsvJZFZ13f5lxsnk+bLAwE+Fp+B4+Rv3TrXSD7K3qELYy9T1+YeUZuQu5ksQh
         gQ9V2P1rO4UIfLK0R3Kfbis/IGCPSSp0AsdQkY2g0s9KsuTEQRiDNEjw7FMkdChZlQwB
         W8HA==
X-Gm-Message-State: AA+aEWa2nb083ukFkwkSbNSXS8hYcFkL4UyW2DyofPOfJxQV8NSMMjVp
        8KkLX4Hiu4zrd7fFYdC/DCNiI4CP++w=
X-Google-Smtp-Source: AFSGD/WMTtYuMero7yAjWcZ1PwF6g6DJDUNRTyMzfYtwDam5PnXSm3u6C3TRt7uVs7bDUd8xQ6LZIg==
X-Received: by 2002:a02:6:: with SMTP id 6mr18744943jaa.19.1543948818783;
        Tue, 04 Dec 2018 10:40:18 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d192sm7458319iog.81.2018.12.04.10.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 10:40:17 -0800 (PST)
Subject: Re: block and nvme polling improvements V3
To:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <11a7106d-17e2-ceb4-bc16-22b447d0bc0f@kernel.dk>
Date:   Tue, 4 Dec 2018 11:40:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202164628.1116-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/2/18 9:46 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series optimizes a few bits in the block layer and nvme code
> related to polling.
> 
> It starts by moving the queue types recently introduce entirely into
> the block layer instead of requiring an indirect call for them.
> 
> It then switches nvme and the block layer to only allow polling
> with separate poll queues, which allows us to realize the following
> benefits:
> 
>  - poll queues can safely avoid disabling irqs on any locks
>    (we already do that in NVMe, but it isn't 100% kosher as-is)
>  - regular interrupt driven queues can drop the CQ lock entirely,
>    as we won't race for completing CQs
> 
> Then we drop the NVMe RDMA code, as it doesn't follow the new mode,
> and remove the nvme multipath polling code including the block hooks
> for it, which didn't make much sense to start with given that we
> started bypassing the multipath code for single controller subsystems
> early on.  Last but not least we enable polling in the block layer
> by default if the underlying driver has poll queues, as that already
> requires explicit user action.
> 
> Note that it would be really nice to have polling back for RDMA with
> dedicated poll queues, but that might take a while.  Also based on
> Jens' polling aio patches we could now implement a model in nvmet
> where we have a thread polling both the backend nvme device and
> the RDMA CQs, which might give us some pretty nice performace
> (I know Sagi looked into something similar a while ago).

Applied, thanks.

-- 
Jens Axboe

