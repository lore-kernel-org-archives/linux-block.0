Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBACC433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 13:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiJUN2V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 09:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJUN2U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 09:28:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8455A13669F
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 06:28:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id ADA2D68B05; Fri, 21 Oct 2022 15:28:15 +0200 (CEST)
Date:   Fri, 21 Oct 2022 15:28:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 6/8] nvme: move the NS_DEAD flag to the controller
Message-ID: <20221021132815.GE22327@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-7-hch@lst.de> <ac33021a-b7a1-37cf-b156-df021ac4de43@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac33021a-b7a1-37cf-b156-df021ac4de43@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 20, 2022 at 04:30:21PM +0300, Sagi Grimberg wrote:
>> -
>> +	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
>> +		list_for_each_entry(ns, &ctrl->namespaces, list)
>> +			nvme_set_queue_dying(ns);
>> +	}
>
> Looking at it now, I'm not sure I understand the need for this flag. It
> seems to make nvme_kill_queues reentrant safe, but the admin queue
> unquiesce can still end up unbalanced under reentrance?
>
> How is this not broken today (or ever since quiesce/unquiesce started
> accounting)? Maybe I lost some context on the exact subtlety of how
> nvme-pci uses this interface...

Yes, this also looks weird and I had a TODO list entry for myself
to look into what is going on here.  The whole interaction
with nvme_remove_namespaces is pretty weird to start with, and then
the code in PCIe is even more weird.  But to feel confident to
touch this I'd need real hot removal testing, for which I don't
have a good rig right now.
