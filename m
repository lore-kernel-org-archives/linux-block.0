Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04D5EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 08:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348760AbjHQITx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 04:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348925AbjHQITU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 04:19:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234B13582
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 01:19:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D6DDF1F891;
        Thu, 17 Aug 2023 08:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692260340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJhnEkfD1jsN4t8MPe/F0flXlGnvUjNwChAguWMLs8w=;
        b=Lgove2rkHKp59k+4QbLjeat5w5zsp2sbqj9E4o0+Bom2uhwsBBcq/QORQQiqFI0wOASPF9
        bupjXXVksie+fiAgCJMxwxyZBxo0ZLH7BaojlZNS4smCNV3fbJ/A9obJhkIg9ytzWyEZ+n
        TB2BN+jyT6qNDx+Fo0URyollvMkOr44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692260340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJhnEkfD1jsN4t8MPe/F0flXlGnvUjNwChAguWMLs8w=;
        b=fmZsvtFo5krEWNZ6g8FFEkrIEfS0hbkrAt8u1AU0HzbP+KiT3evThdT5JHS0HanvGSNOb9
        I0w2lnfE4qPwYEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 993111392B;
        Thu, 17 Aug 2023 08:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HZ2fIfTX3WRBUQAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 17 Aug 2023 08:19:00 +0000
Date:   Thu, 17 Aug 2023 10:19:10 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2 1/2] nvme/rc: fix nvme device readiness check
 after _nvme_connect_subsys
Message-ID: <lqazvjte6tnjw45txgeo4yzj3cvyj427z5ldwnbbr5j7wf5jwf@g6twqzzqgdgl>
References: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 17, 2023 at 04:30:20PM +0900, Shin'ichiro Kawasaki wrote:
> The helper function _nvme_connect_subsys() creates a nvme device. It may
> take some time after the function call until the device gets ready for
> I/O. So it is expected that the test cases call _find_nvme_dev() after
> _nvme_connect_subsys() before I/O. _find_nvme_dev() returns the path of
> the created device, and it also waits for uuid and wwid sysfs attributes
> of the created device get ready. This wait works as the wait for the
> device I/O readiness.
> 
> However, this wait by _find_nvme_dev() has two problems. The first
> problem is missing call of _find_nvme_dev(). The test case nvme/047
> calls _nvme_connect_subsys() twice, but _find_nvme_dev() is called only
> for the first _nvme_connect_subsys() call. This causes too early I/O to
> the device with tcp transport [1]. Fix this by moving the wait for the
> device readiness from _find_nvme_dev() to _nvme_connect_subsys(). Also
> add --wait-for option to _nvme_connect_subsys(). It allows to skip the
> wait in _nvmet_passthru_target_connect() which has its own wait for
> device readiness.
> 
> The second problem is wrong paths for the sysfs attributes. The paths
> do not include namespace index, so the check for the attributes always
> fail. Still _find_nvme_dev() does 1 second wait and allows the device
> get ready for I/O in most cases, but this is not intended behavior.
> Fix the paths by adding the namespace index.
> 
> On top of the checks for sysfs attributes, add 'udevadm settle' and a
> check for the created device file. These ensures that the create device
> is ready for I/O.
> 
> [1] https://lore.kernel.org/linux-block/CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com/
> 
> Fixes: c766fccf3aff ("Make the NVMe tests more reliable")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks!

Reviewed-by: Daniel Wagner <dwagner@suse.de>
