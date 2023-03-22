Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F39C6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 08:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjCVIq6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 04:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCVIq5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 04:46:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC42B4FAA7
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 01:46:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B33D20B7A;
        Wed, 22 Mar 2023 08:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679474811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8pcB4NyNpnbjjVyVqPZjee1OMgx7fIK0IQ+AayPDOI=;
        b=E9g230bnlx+122H2nzMrW/4y80qlg+h4ZxmzlsB1j7O2jjyfGVbE6ojSSo76pTID9cM2cY
        saFdCdUVfVLSZQmntQ0o6yrhzLhuCeCDJ8LHMhqWDXToWB7AUhktx/Ps5PqzAt5zL4/83c
        6wgjpkC63fZOFUnBMl6A6MTJj3E3Xz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679474811;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8pcB4NyNpnbjjVyVqPZjee1OMgx7fIK0IQ+AayPDOI=;
        b=uDAsXIuPu62sIaf6OYJkb5nFzZ63jnm7YNfFAR7gZhXrH/QEVmi7S/jPMB9bnvpaotHT+3
        N1rf9jG0kSBwUXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C17F138E9;
        Wed, 22 Mar 2023 08:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Lv4ZInvAGmQ6SQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 08:46:51 +0000
Date:   Wed, 22 Mar 2023 09:46:51 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, sagi@grimberg.me,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Message-ID: <20230322084651.xmnup2ag3ve6jr3a@carbon.lan>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-3-kbusch@meta.com>
 <20230322082310.GA22782@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322082310.GA22782@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 09:23:10AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 21, 2023 at 05:23:49PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > This is for mostly for testing purposes.
> 
> I have to admit I'd rather not merge this upstream.  Any good reason
> why we'd absolutely would want to have it?

The blktest I have written for this problem fails for loop without something
like this. We can certaintanly teach blktests not run a specific test for loop
but currently, the _require_nvme_trtype_is_fabrics check is including loop.
