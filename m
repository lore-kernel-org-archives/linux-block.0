Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF3CC76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 09:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjDFJKM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 05:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjDFJKL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 05:10:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F0C19D
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 02:10:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD1AB22836;
        Thu,  6 Apr 2023 09:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680772209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xfpjhQpsC7u5WfaLzcwUgQNwj9KAibrTmUK9wT2RG4M=;
        b=jYhd60mgC1FpkNLNl9UYouHPEh/Yb1CFDpGzQFCucN5bIfYVvtodDRY0Ju/fdgfkyVuU3/
        C/rXgOxOF+N81yYFBHRdiERGwTYkBwDYbdnfINMd5bsmfFk/sHsfOSIKHaWhtObuJti5Vn
        PtRXPNdAJyscgFZvRxq9lHDkx7nlt7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680772209;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xfpjhQpsC7u5WfaLzcwUgQNwj9KAibrTmUK9wT2RG4M=;
        b=R8ESKdNDsYunS0R/fQNeZPl4WGWTw+g6slVnlj9vdTY2KsfFpKdIyHQNFI85Xx26OAkX2y
        uKqtiGCgBm6cAUAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF3D9133E5;
        Thu,  6 Apr 2023 09:10:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6u6XKnGMLmRDewAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 09:10:09 +0000
Date:   Thu, 6 Apr 2023 11:10:09 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v6 0/2] test queue count changes on reconnect
Message-ID: <ftljvb4alzxssqjzr5ik7pvatiwh25i4ftktvgvxzqxk76afew@brp7ch4v7wik>
References: <20230406083050.19246-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406083050.19246-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 10:30:48AM +0200, Daniel Wagner wrote:
> good and the bad case (rdma started to fail today, something to fix).

After adding the missing _nvmet_setup() call, tcp and rdma works fine.
