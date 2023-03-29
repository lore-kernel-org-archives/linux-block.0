Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A92CC6FD18
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 06:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjC2G0J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 02:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjC2G0I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 02:26:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7C235B7
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 23:26:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 868091FE31;
        Wed, 29 Mar 2023 06:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680071160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gg20VuxotjIBrApcqYsHTz75BAKs5arxadou0gRz/c4=;
        b=SrbO0Tz9m0noLJPnRR10xf0Fq5bDbC8bq7OrKWb9CLoy/Mm8m4NBQuy37rf3G9VdB86C3c
        HV/m5+H4KxuGAO2o0x25RX3wrDsHqYO7kETddYADnE3vwTLEifA74Jhay746h0p5HLjdVc
        RzNxKSB6rn87/R/kLvloMJeIgY2aP5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680071160;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gg20VuxotjIBrApcqYsHTz75BAKs5arxadou0gRz/c4=;
        b=KlfZjoClu3k1HvaT9iLgT0TlbdxDOhwaywF2a3mzObtwau3ZWd2S0TB6xjElsbmN9U0fxO
        C3Rztw45+Ym5fRBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63C70139D3;
        Wed, 29 Mar 2023 06:26:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WE9NGPjZI2SRHgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 29 Mar 2023 06:26:00 +0000
Date:   Wed, 29 Mar 2023 08:25:59 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests v2 0/3] Test different queue counts
Message-ID: <20230329062559.k4qltulx4oldx3pa@carbon.lan>
References: <20230322101648.31514-1-dwagner@suse.de>
 <ZCMzjVs26imnywgo@kbusch-mbp.dhcp.thefacebook.com>
 <6dcf501f-8863-b448-01fa-1252e73a87f5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dcf501f-8863-b448-01fa-1252e73a87f5@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 29, 2023 at 03:30:17AM +0000, Chaitanya Kulkarni wrote:
> On 3/28/23 11:35, Keith Busch wrote:
> > On Wed, Mar 22, 2023 at 11:16:45AM +0100, Daniel Wagner wrote:
> >> Setup different queues, e.g. read and poll queues.
> > If you wanted to add a similar test for pci, you do it by echo'ing the desired
> > options to:
> >
> >    /sys/modules/nvme/parameters/{poll_queues,write_queues}
> >
> > Then do an 'nvme reset' on the target nvme pci device.
> >
> > I'll just note that such a test will currently fail, and fixing that doesn't
> > look like fun. :)
> 
> then we should definitely add it ;) ha ha.
> 
> I was actually wondering about pci based on the discussion on this thread
> was mainly focused on tcp and rdam, thanks for the suggestion Keith.

The test is fabric centric because we configure the queues via the 'nvme
connect' call, something we can't do for PCI. It look likes it needs another
new test for PCI. Let me get this one sorted out first though.
