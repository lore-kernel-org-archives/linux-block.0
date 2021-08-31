Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D090CC432BE
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 09:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD1060F6C
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 09:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbhHaKA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Aug 2021 06:00:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59436 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbhHaKAZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Aug 2021 06:00:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFCF41FE68;
        Tue, 31 Aug 2021 09:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630403969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lx70k8u2MAA5RCAXK67RBAT4TDGyen08WXhc6Uhjfoc=;
        b=Kz3ZAFEhjEAqzoVpfddcZcOe8ZOpkR70+40CSI+n7SgGS4DFGJaRusuqHiGN6vcz8twCKK
        cM12pL72UUT4XqSHs78qHPHjI/qrqCKfaFHAZhqaO2JdyACfNaeBrVZPG7pZoOBWqih6tq
        zlTmqD4lp5WVRZaNqeg8osbWye9wl64=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D444913A64;
        Tue, 31 Aug 2021 09:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id phzfMoH9LWEedQAAGKfGzw
        (envelope-from <mkoutny@suse.com>); Tue, 31 Aug 2021 09:59:29 +0000
Date:   Tue, 31 Aug 2021 11:59:30 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3 v2] bfq: Limit number of allocated scheduler tags per
 cgroup
Message-ID: <20210831095930.GB17119@blackbody.suse.cz>
References: <20210715132047.20874-1-jack@suse.cz>
 <751F4AB5-1FDF-45B0-88E1-0C76ED1AAAD6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751F4AB5-1FDF-45B0-88E1-0C76ED1AAAD6@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Paolo.

On Fri, Aug 27, 2021 at 12:07:20PM +0200, Paolo Valente <paolo.valente@linaro.org> wrote:
> Before discussing your patches in detail, I need a little help on this
> point.  You state that the number of scheduler tags must be larger
> than the number of device tags.  So, I expected some of your patches
> to address somehow this issue, e.g., by increasing the number of
> scheduler tags.  Yet I have not found such a change.  Did I miss
> something?

I believe Jan's conclusions so far are based on "manual" modifications
of available scheduler tags by /sys/block/$dev/queue/nr_requests.
Finding a good default value may be an additional change.

(Hopefully this clarifies a bit before Jan can reply.)

Michal
