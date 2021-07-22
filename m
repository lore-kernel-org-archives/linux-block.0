Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2CDC63793
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 13:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E229F61287
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 13:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhGVMcM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:32:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46628 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhGVMcL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 08:32:11 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C460C203AB;
        Thu, 22 Jul 2021 13:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626959565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w6q3ZumdrXWLHQV86aBSkpw4hCs4IH6Y044mzTbrEFE=;
        b=wJ5Dx9G8XNxfseF/gW7eodbMuQ4/L5DBNzEdaz5LNFrZ+fP9bSzPv7QeOkb08/0YdfVdyT
        fnG9qJEHZhNeoVQgv8n1s/WbtwPkBtKq3tSDDxZ7VL/2wb4EEtCIDRi394qjsrTF0uT7fs
        oJc1Mly3sFsYlwFfZO5Zke6MGmACK/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626959565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w6q3ZumdrXWLHQV86aBSkpw4hCs4IH6Y044mzTbrEFE=;
        b=Ae+eYC9zKPl6BskSyRGGd6DVvz4h4ciCKCXjScF/ohCKOMP0AV87KhBkZyUxSo1F6AOlP5
        Hmb3lnTL6RymluCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B4F79139A1;
        Thu, 22 Jul 2021 13:12:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id VTzJK81u+WC6dAAAGKfGzw
        (envelope-from <dwagner@suse.de>); Thu, 22 Jul 2021 13:12:45 +0000
Date:   Thu, 22 Jul 2021 15:12:45 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V6 0/3] blk-mq: fix blk_mq_alloc_request_hctx
Message-ID: <20210722131245.u4dhcqotepxhwgbz@beryllium.lan>
References: <20210722095246.1240526-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722095246.1240526-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 22, 2021 at 05:52:43PM +0800, Ming Lei wrote:
> Wen Xiong has verified V4 in her nvmef test.

FWIW, I am testing this series right now. I observe hanging I/Os
again, but I am not totally sure if my test setup is working
properly. Working on it. I'll keep you posted.
