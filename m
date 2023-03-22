Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB743C6FD1F
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 14:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjCVOGt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjCVOGc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 10:06:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686D16424E
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 07:06:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 12C2733BA6;
        Wed, 22 Mar 2023 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679493980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZc0Qj4tZ4zTkmzE1ji+h6aLVP7ArKKuE6NKqyNX8Ms=;
        b=jq8ibrVdnjgWoiHkuYTGpLBdgrAUEpiIZxVYbZr7nBs5CKgbLQF5IOoAD2jWoxlFdTbtAI
        t35kjRmeXHl/5BVLg6S0uVGTkDhWP2OlD/sgDqDHEyuek6H0uOABk1EtMPr8vWkGNsK47k
        3ovwAsK325TrQjDjNJVtQOaIBy7z7bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679493980;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZc0Qj4tZ4zTkmzE1ji+h6aLVP7ArKKuE6NKqyNX8Ms=;
        b=kzC+o+meSy0BCfmHz3IjoqPjmj78VDc2SPNV32nysLHEL1uiiFvucEZJ6COdAsphz+MLbe
        OUrfz0ieohwpfjCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03CC613416;
        Wed, 22 Mar 2023 14:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K2DfAFwLG2ToGAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 14:06:20 +0000
Date:   Wed, 22 Mar 2023 15:06:19 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, sagi@grimberg.me,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Message-ID: <20230322140619.zy2msly7mcuwgo6a@carbon.lan>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-3-kbusch@meta.com>
 <20230322082310.GA22782@lst.de>
 <20230322084651.xmnup2ag3ve6jr3a@carbon.lan>
 <20230322135200.GA16587@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322135200.GA16587@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 02:52:00PM +0100, Christoph Hellwig wrote:
> Who says that we could support polling on all current and future
> fabrics transports?

I just assumed this is a generic feature supposed to present in all transports.
I'll update my new blktest test to run only tcp or rdma.
