Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41890C47096
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 09:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2425A613DA
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 09:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhFCJzo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 05:55:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48324 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFCJzo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 05:55:44 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1FB8F219B8;
        Thu,  3 Jun 2021 09:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622714039;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkOCTa1uijuwFWjRFGt7xUTjPvCPbu7IRw/D3ibgaLs=;
        b=DdpeDuwNQTbJy68rYOlr8IVZ801acHuTm5UT1jDk+GepGFJbNu+VIIDG+ftwGvMhVzfKhp
        LVJeWIdmGeqEfY+Mtiw8xn0VIr2chmMlg5cG0Wtlma0FeQmeC575rotDZq4mDetLD2cIzn
        YMbRfsuNHdnPrcBDVfGuerZOL9QCsRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622714039;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkOCTa1uijuwFWjRFGt7xUTjPvCPbu7IRw/D3ibgaLs=;
        b=VaEeA7g9ga1D273toLxMtGZmEga2E2Opnv83ApoKrjottaHFWP6jycsrip7ghSMzPXej+s
        TtEJ5j9BjS/a2xDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E0776A3B89;
        Thu,  3 Jun 2021 09:53:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CA00ADA72C; Thu,  3 Jun 2021 11:51:17 +0200 (CEST)
Date:   Thu, 3 Jun 2021 11:51:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN
Message-ID: <20210603095117.GU31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210531135444.122018-1-Niklas.Cassel@wdc.com>
 <20210531135444.122018-3-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531135444.122018-3-Niklas.Cassel@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 31, 2021 at 01:54:53PM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Performing a BLKREPORTZONE operation should be allowed under the same
> permissions as read(). (read() does not require CAP_SYS_ADMIN).
> 
> Remove the CAP_SYS_ADMIN requirement, and instead check that the fd was
> successfully opened with FMODE_READ. This way BLKREPORTZONE will match
> the access control requirement of read().

Does this mean that a process that does not have read nor write access
to the device itself (blocks) is capable of reading the zone
information? Eg. some monitoring tool.
