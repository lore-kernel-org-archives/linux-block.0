Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FE7C433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 22:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDFB20897
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 22:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590791580;
	bh=2EeVVHbwIL24E6BEnGDlQDLaPxbUkfL4gAeJ7C0NJXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=urw8s1x/1N0MjtfFU0B2Ym3BtkZ22/RRC9Xb/s/v86msarEGV8VUxEDa9heqRw+0y
	 eHAPTmpWFpiS/vkSO/7brrgddJyz4BEW6+39IDwl7zhzDMDdYla0gHhjEBnHDGVGIh
	 vJkGFvD8uBCB+KNnrvwPzmv9a8/v+xAciJbhTlw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgE2WdA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 18:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgE2Wc7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 18:32:59 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE3F207BC;
        Fri, 29 May 2020 22:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590791579;
        bh=2EeVVHbwIL24E6BEnGDlQDLaPxbUkfL4gAeJ7C0NJXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLDpMCrIutYY5PMUhtAAGv+Zn1v2w5dDE1DJv1KQjxPIRomdjUqxXLwzxI+KXbp1X
         dqujr6+5a5Cjytw/fpo3IO09lrJUV35WQsuYhRHiefSHyY5MmxmglwrxJQIfq9d+NO
         iLFqt6lIJ2sNOSzp873kAxpJEdY513yYkEBv8fcg=
Date:   Fri, 29 May 2020 15:32:56 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
Message-ID: <20200529223256.GA3564047@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200528153441.3501777-1-kbusch@kernel.org>
 <20200528153441.3501777-2-kbusch@kernel.org>
 <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com>
 <20200528191118.GB3504306@dhcp-10-100-145-180.wdl.wdc.com>
 <20200528191443.GA3504350@dhcp-10-100-145-180.wdl.wdc.com>
 <f9cbedc9-88b2-acc8-5b95-f1c247ab1525@oracle.com>
 <CACVXFVOTQ7HLV5DCP1XezPqha13LfUrj-fZE8++_BAoTvtPWMA@mail.gmail.com>
 <20200529132217.GB3506625@dhcp-10-100-145-180.wdl.wdc.com>
 <CACVXFVMithaukPF45qFzTgzqQ2g2mhLbUD+-AyaNwVwZo7+CyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVMithaukPF45qFzTgzqQ2g2mhLbUD+-AyaNwVwZo7+CyA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 30, 2020 at 06:23:08AM +0800, Ming Lei wrote:
> On Fri, May 29, 2020 at 9:22 PM Keith Busch <kbusch@kernel.org> wrote:
> > seconds. Your series will reset that broken controller indefinitely.
> > Which of those options is better?
> 
> Removing controller is very horrible, because it becomes a brick
> basically, together
> with data loss. And we should retry enough before killing the controller.
> 
> Mys series doesn't reset indefinitely since every request is just
> retried limited
> times(default is 5), at least chance should be provided to retry
> claimed times for IO
> requests.

Once the 5th retry is abandoned for all IO in the scheduled scan_work,
the reset will succeed and schedule scan_work, which will revalidate
disks, which will send new IO, which will timeout, then reset and
repeat...
