Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF29C48BE6
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 11:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4054461185
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 11:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhFNLmI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 07:42:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60854 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbhFNLjK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 07:39:10 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C63121988;
        Mon, 14 Jun 2021 11:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623670627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SzwBqXjJZzX3pYRcE/53+PJH0Y1vEg8AUTJdvK/4KpQ=;
        b=xRWWEKeSVPXTdeWX1at48FqkgF6bnXkJBUFe7y8AbORpkUZ9+WcILEs+gCJHjWqnssQuDy
        8zVbZ5TIan8oOuWLzhC9kGSCCzvGj9vxaXbGG4wnjEhmrqzSYMU3JwhHnVIxuDRNI0CAxV
        VsQveP5R78SRT8zUKtwySZBJLXHIy5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623670627;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SzwBqXjJZzX3pYRcE/53+PJH0Y1vEg8AUTJdvK/4KpQ=;
        b=l+6PgBj87+U+WgGF1g4/O8NRjjiRgCLhiuQiLzRTjhS78abvu5VpgB7cgVGqwSmsxX7szG
        MlUFVNCtdRaDw5CQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id F20C8118DD;
        Mon, 14 Jun 2021 11:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623670627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SzwBqXjJZzX3pYRcE/53+PJH0Y1vEg8AUTJdvK/4KpQ=;
        b=xRWWEKeSVPXTdeWX1at48FqkgF6bnXkJBUFe7y8AbORpkUZ9+WcILEs+gCJHjWqnssQuDy
        8zVbZ5TIan8oOuWLzhC9kGSCCzvGj9vxaXbGG4wnjEhmrqzSYMU3JwhHnVIxuDRNI0CAxV
        VsQveP5R78SRT8zUKtwySZBJLXHIy5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623670627;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SzwBqXjJZzX3pYRcE/53+PJH0Y1vEg8AUTJdvK/4KpQ=;
        b=l+6PgBj87+U+WgGF1g4/O8NRjjiRgCLhiuQiLzRTjhS78abvu5VpgB7cgVGqwSmsxX7szG
        MlUFVNCtdRaDw5CQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id XLEdOmI/x2ASFwAALh3uQQ
        (envelope-from <dwagner@suse.de>); Mon, 14 Jun 2021 11:37:06 +0000
Date:   Mon, 14 Jun 2021 13:37:06 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Do not lookup ctx with invalid index
Message-ID: <20210614113706.astexefgfo4tuejr@beryllium.lan>
References: <20210608183339.70609-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608183339.70609-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 08, 2021 at 08:33:39PM +0200, Daniel Wagner wrote:
> cpumask_first_and() returns >= nr_cpu_ids if the two provided masks do
> not share a common bit. Verify we get a valid value back from
> cpumask_first_and().

So I got feedback on this issue (but not on the patch itself yet). The
system starts with 16 virtual CPU cores and during the test 4 cores are
removed[1] and as soon there is an error on the storage side, the reset
code on the host ends up in this path and crashes. I still don't
understand why the CPU removal is not updating the CPU mask correctly
before we hit the reset path. I'll continue to investigate.

[1] echo 0 > /sys/devices/system/cpu/cpu#/online
