Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28529C12002
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 07:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABD561181
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 07:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhGUGop (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 02:44:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45290 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhGUGjj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 02:39:39 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626852001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=14pa5e4ghKE3WxB0dYlBZl3aq8XwaNMqkiThF/hFm4o=;
        b=TALdyTTG2yvh5R1hfCjlcSNfrZ/1yg6DjzkqdboKop7dFX1cs52R0/Rk+PvbnWlnewH6IC
        mNSeecuwh65v1kq3dE7FpO9ZmD8OjbMNme79B+O8XkR9SSyosoUNG5HVd1Ylcyxvm+tJ9a
        5hmMmRKgW8LfKiiCujaWBsvSZDSiYmF4cN3mBbx3MfTCQ7TUt14bkh38sN1sahmSwfyTQg
        5tN+MOKkqwLcInndm8o5n7yMt4onBUstLGpHLX53D+CkNMDR5YMtPJyCh6+zc5yMAfGW4y
        Ag1pscvfxPsE2Scl9tHyxnpLTRt8rpfi87fG2UrwZ7zrOlmhZVM0zRvRl5J6wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626852001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=14pa5e4ghKE3WxB0dYlBZl3aq8XwaNMqkiThF/hFm4o=;
        b=6A5iwEz8jhu64Wy7GB9ySMY1c5O3BUSXx6OXfblT0Xk9RZkrB0/ArkhnHPnIoXHI/EjV+f
        wRs2+sHiArELXoBA==
To:     Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed if any irq is managed
In-Reply-To: <20210719094414.GC431@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com> <20210715120844.636968-2-ming.lei@redhat.com> <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com> <20210719094414.GC431@lst.de>
Date:   Wed, 21 Jul 2021 09:20:00 +0200
Message-ID: <87lf60cevz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19 2021 at 11:44, Christoph Hellwig wrote:
> On Mon, Jul 19, 2021 at 08:51:22AM +0100, John Garry wrote:
>>> Address this issue by adding one field of .irq_affinity_managed into
>>> 'struct device'.
>>>
>>> Suggested-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>
>> Did you consider that for PCI device we effectively have this info already:
>>
>> bool dev_has_managed_msi_irq(struct device *dev)
>> {
>> 	struct msi_desc *desc;
>>
>> 	list_for_each_entry(desc, dev_to_msi_list(dev), list) {
>> 		if (desc->affinity && desc->affinity->is_managed)
>> 			return true;
>> 	}
>>
>> 	return false;
>
> Just walking the list seems fine to me given that this is not a
> performance criticial path.  But what are the locking implications?

At the moment there are none because the list is initialized in the
setup path and never modified afterwards. Though that might change
sooner than later to fix the virtio wreckage vs. MSI-X.

> Also does the above imply this won't work for your platform MSI case?

The msi descriptors are attached to struct device and independent of
platform/PCI/whatever.

Thanks,

        tglx
