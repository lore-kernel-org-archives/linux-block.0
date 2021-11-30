Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4AFC4332F
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 15:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244634AbhK3PHE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:07:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52726 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbhK3PEx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 10:04:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3B66F1FD58;
        Tue, 30 Nov 2021 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638284493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CgI4u0V46e8ysS6xowYfhDaY4uIRyr0Ib42Cj3bkSU=;
        b=pk29IOKurdk3dzS9Hp5SWAci8LFEu5JlaQLfKoKlArqjDi+8CVsXlQvpfdNFUgv5CVsJPe
        FX1E7N0FYozAyGuDV9HtnKIgszOuIakVON+v8d0C6A46VMfsa8OTnwFHTq0O0BBb2vs5JE
        dFqElsyO5LSB6eBI2Yvb37Vs6v8+g64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638284493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CgI4u0V46e8ysS6xowYfhDaY4uIRyr0Ib42Cj3bkSU=;
        b=Rfy4diBlpEJ0RnLfrd92QBVM3+0buzCbNyulsZL6lg1KHQ/LlstUq8j5TdSaB8dexqZceQ
        xX8fP+3f9P2mcZBQ==
Received: from quack2.suse.cz (jack.udp.ovpn2.prg.suse.de [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 210F8A3B8D;
        Tue, 30 Nov 2021 15:01:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C563C1E1494; Tue, 30 Nov 2021 16:01:32 +0100 (CET)
Date:   Tue, 30 Nov 2021 16:01:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/7] block: refactor put_iocontext_active
Message-ID: <20211130150132.GI7174@quack2.suse.cz>
References: <20211130124636.2505904-1-hch@lst.de>
 <20211130124636.2505904-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130124636.2505904-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 30-11-21 13:46:32, Christoph Hellwig wrote:
> Factor out a ioc_exit_icqs helper to tear down the icqs and the fold
> the rest of put_iocontext_active into exit_io_context.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
