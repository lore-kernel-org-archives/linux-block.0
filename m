Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F289CC433FE
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 20:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiKUUzU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 15:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKUUzR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 15:55:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF98C9A92
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 12:55:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67D5561472
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 20:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C9AC433C1;
        Mon, 21 Nov 2022 20:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669064115;
        bh=fklIbxjZ4fI2eVhvV7BHArTOHsla7HiRX/G/vPaCWDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKeias75RFAq5FnOjzAFo4LzKn5mlz0z6IzA9llv1JdN1uJiPlNY/OP4keEvAwcxN
         Rv8cvagu19/jpDaO5++d197rO8dtNIcQZFrabsoT3UjI3E0iPxN/RNRTmw3xkH+FGA
         h4D9jI4V7p3p4aH8aOWN7i0gQarZ84BoUg9FLHZa2V2KTUfEZqU00BMdn9lSpfDnZt
         wEX7aJao+vJu2StuvwctTL9EFevrADrLg4ggRqIW1RbVBTldmMPx4pHablsylSr0G8
         wRYg09tfwn6+bfEjld5O3p4pLJfV5PrDuvM/SmNA6ObuHeIN59lMSxbCXM/l2oXyu2
         9WPjuPjWtI+LQ==
Date:   Mon, 21 Nov 2022 13:55:12 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        "Shin\\'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] tests/nvme: Add admin-passthru+reset race test
Message-ID: <Y3vlsF7KcRrY7vCW@kbusch-mbp>
References: <20221117212210.934-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117212210.934-1-jonathan.derrick@linux.dev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 17, 2022 at 02:22:10PM -0700, Jonathan Derrick wrote:
> I seem to have isolated the error mechanism for older kernels, but 6.2.0-rc2
> reliably segfaults my QEMU instance (something else to look into) and I don't
> have any 'real' hardware to test this on at the moment. It looks like several
> passthru commands are able to enqueue prior/during/after resetting/connecting.

I'm not seeing any problem with the latest nvme-qemu after several dozen
iterations of this test case. In that environment, the formats and
resets complete practically synchronously with the call, so everything
proceeds quickly. Is there anything special I need to change?
 
> The issue seems to be very heavily timing related, so the loop in the header is
> a lot more forceful in this approach.
> 
> As far as the loop goes, I've noticed it will typically repro immediately or
> pass the whole test.

I can only get possible repro in scenarios that have multi-second long,
serialized format times. Even then, it still appears that everything
fixes itself after a waiting. Are you observing the same, or is it stuck
forever in your observations?

> +remove_and_rescan() {
> +	local pdev=$1
> +	echo 1 > /sys/bus/pci/devices/"$pdev"/remove
> +	echo 1 > /sys/bus/pci/rescan
> +}

This function isn't called anywhere.
