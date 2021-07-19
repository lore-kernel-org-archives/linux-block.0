Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99362C636C9
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 09:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72EB2611BE
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 09:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhGSJDm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 05:03:42 -0400
Received: from verein.lst.de ([213.95.11.211]:48783 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234913AbhGSJDl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 05:03:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7A7BF68B05; Mon, 19 Jul 2021 11:44:15 +0200 (CEST)
Date:   Mon, 19 Jul 2021 11:44:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity
 managed if any irq is managed
Message-ID: <20210719094414.GC431@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com> <20210715120844.636968-2-ming.lei@redhat.com> <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 08:51:22AM +0100, John Garry wrote:
>> Address this issue by adding one field of .irq_affinity_managed into
>> 'struct device'.
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>
> Did you consider that for PCI device we effectively have this info already:
>
> bool dev_has_managed_msi_irq(struct device *dev)
> {
> 	struct msi_desc *desc;
>
> 	list_for_each_entry(desc, dev_to_msi_list(dev), list) {
> 		if (desc->affinity && desc->affinity->is_managed)
> 			return true;
> 	}
>
> 	return false;

Just walking the list seems fine to me given that this is not a
performance criticial path.  But what are the locking implications?

Also does the above imply this won't work for your platform MSI case?
