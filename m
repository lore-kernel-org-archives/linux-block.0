Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AB1C433FE
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 15:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJCP2z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 11:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJCP2t (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 11:28:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BE927FE6
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 08:28:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67F5EB81178
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 15:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848A9C43145;
        Mon,  3 Oct 2022 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664810920;
        bh=egRzaguwiAmhjHHlqqCJraw7EaIGbUFlmqqv6qZnqZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEze71G/o9K0RLEseBuJblJ0zcDW6+XUOEja4V0kSUB+bEplZTIRUgmYanoYVEfil
         3YvLBgS0IefgMNS+HK9yfeMjZNm0Uh1H0vmEXwfh3MVot+i7BQWZP+sFtnIdegKjsh
         J7mYSsUjdXHKE31ojbjiANVNVREm5/7dwMpiE6kasE/p3+fysNOhsDWaKhPYpgOkVf
         M32K7wEoFoTcb+YGwoNKPMMpIVteipaEj0I0v9Y67FC7cg2yrqXUu8OYMko+FFamm0
         WTfUsj/R00KaUmQCELLrsiieZvpHrOKNVfI0A6bL0P4o60iNMUxjdPhmEyvP8SxEpa
         otURC/3YPjNIQ==
Date:   Mon, 3 Oct 2022 09:28:36 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: lockdep WARNING at blktests block/011
Message-ID: <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003133240.bq2vynauksivj55x@shindev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 03, 2022 at 01:32:41PM +0000, Shinichiro Kawasaki wrote:
> 
> BTW, I came up to another question during code read. I found nvme_reset_work()
> calls nvme_dev_disable() before nvme_sync_queues(). So, I think the NVME
> controller is already disabled when the reset work calls nvme_sync_queues().

Right, everything previously outstanding has been reclaimed, and the queues are
quiesced at this point. There's nothing for timeout work to wait for, and the
sync is just ensuring every timeout work has returned.

It looks like a timeout is required in order to hit this reported deadlock, but
the driver ensures there's nothing to timeout prior to syncing the queues. I
don't think lockdep could reasonably know that, though.
