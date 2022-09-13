Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE38C6FA82
	for <linux-block@archiver.kernel.org>; Tue, 13 Sep 2022 11:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiIMLmO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Sep 2022 07:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiIMLmN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Sep 2022 07:42:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CBB558ED
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2022 04:42:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 88A061F8C6;
        Tue, 13 Sep 2022 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663069331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s3qrXVftc0ie6oK7GOBNq5dnLY1pkAlF/xu0mQg/Rto=;
        b=fjU+ioEwhIQ1FKSwILSJ9TzECbChTRTRQbZtsok0Y31BU3rkwDNMoj/YQXDqJ/z6oBFPZ0
        2JGUobQzLNX2CK271NI88lmZ2T5uOYj2Z+HIuUGq0yVnSIxkEkC5W7eLnvSc8PzPrqnfTh
        a7R9Fp43P+G+n2EdC6JT6kYYYi2b77A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663069331;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s3qrXVftc0ie6oK7GOBNq5dnLY1pkAlF/xu0mQg/Rto=;
        b=VoKAIqaXX+/MbBO3/NYecgOnUCnXzqcye1oadqsrUMxt8eEaSWaMsy5l7dFQJX+TWUTX6k
        DYjOUckIVaULUCBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79D5E13AB5;
        Tue, 13 Sep 2022 11:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LJa8HZNsIGN4awAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 13 Sep 2022 11:42:11 +0000
Date:   Tue, 13 Sep 2022 13:42:10 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v3] nvme/046: test queue count changes on
 reconnect
Message-ID: <20220913114210.gceoxlpffhaekpk7@carbon.lan>
References: <20220913065758.134668-1-dwagner@suse.de>
 <20220913105743.gw2gczryymhy6x5o@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913105743.gw2gczryymhy6x5o@shindev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 13, 2022 at 10:57:44AM +0000, Shinichiro Kawasaki wrote:
> >   Possible unsafe locking scenario:
> > 
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock((work_completion)(&queue->release_work));
> >                                 lock((wq_completion)nvmet-wq);
> >                                 lock((work_completion)(&queue->release_work));
> >    lock(&id_priv->handler_mutex);
> 
> I also observe this WARNING on my test machine with nvme_trtype=rdma. It looks a
> hidden rdma issue for me...

Yes, that problem is not new, just uncovered by this test.

> > The grep error is something I can fix in the test but I don't know how
> > to handle the 'eth0 speed is unknown' kernel message which will make
> > the test always fail. Is it possible to ignore them when parsing the
> > kernel log for errors?
> 
> FYI, each blktests test case can define DMESG_FILTER not to fail with specific
> keywords in dmesg. Test cases meta/011 and block/028 are reference use
> cases.

Ah okay, let me look into it.

> Having said that, I don't think 'eth0 speed is unknown' in dmesg makes the test
> case fail. See _check_dmesg() in "check" script, which lists keywords that
> blktests handles as errors. I guess the WARNING above is the failure cause,
> probably.

Makes sense. On second thought, the fc transport seems to behave
differently than tcp and rdma if you look at the grep error. Will look
into it, it might be another existing bug...

Daniel
