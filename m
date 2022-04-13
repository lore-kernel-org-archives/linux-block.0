Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45139C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 18:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiDMSLT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiDMSLS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 14:11:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5BE4D262
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YvzIs9BEv5eEfyodPDl3/81QAr6FgCYIIF52vEruur8=; b=QA3c6v0U1OXEAryOpgo3zXFf1p
        bF/fGB3EbbX4goo6O/z0cwzLVbhpI7wwdGgQNl3bHUIz1G/xAZ9rspt5ai2H1EmXdM+KgqJpt8uI0
        W66W9e9DYo3VcGHHX2kv1ityvvtgklCiMRkE4L8q2OdIeSydpJnfDChiv5WY9wk1lHvWWwvd2udan
        EbNaJ+2yGe5VIn8dsTju8zZGI4Bw0NqnyN0OroqaElmC6OBhKrLX03nmUDm70QBmCT5Ks5MxaqQ6n
        aHNNjW23BlnyGur+OFqanNuQnHRZfHXnqVyOlQlq4ieND89AwtmRW28I9gW1uMw7EqvB0NK9at4G0
        ELspwiig==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nehQD-0021wa-LO; Wed, 13 Apr 2022 18:08:53 +0000
Date:   Wed, 13 Apr 2022 11:08:53 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     yi.zhang@redhat.com, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlcRtVYmFJHaxzKG@bombadil.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <6cd7ebd1-f069-7f95-62f5-e8b18d6b3e58@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd7ebd1-f069-7f95-62f5-e8b18d6b3e58@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12, 2022 at 10:53:40PM -0700, Bart Van Assche wrote:
> On 4/12/22 17:24, Luis Chamberlain wrote:
> > I do have CONFIG_NVME_MULTIPATH=y but I also have:
> > 
> > cat /etc/modprobe.d/nvme.conf
> > options nvme_core multipath=N
> > 
> > And yet I always end up booting with:
> > 
> > cat /sys/module/nvme_core/parameters/multipath
> > Y
> 
> Is the nvme_core module loaded from the initial ramdisk or from
> /lib/modules? In the former case, does the initial ramdisk perhaps have to
> be regenerated?

No, no ramdisk, but I just had to use the /etc/default/grub file to set
nvme_core=N as the /etc/modprobe.d/nvme.conf was not being picked up
for whatever reason.

cat /etc/modprobe.d/nvme.conf 
options nvme_core multipath=N

Either way, from a test automation perspective this requirement is a
pain, as I can't do a change dynamically at run time. So for this test
I have to manually change a kernel boot param. Is doing the required
changes dynamic not possible in the future?

I take it that it does not make sense at all to have multipath=N for all
blktests tests.

  Luis
