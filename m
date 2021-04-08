Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA8FC433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 08:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61937610A5
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 08:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhDHIBj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 04:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDHIBi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Apr 2021 04:01:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D30C61130;
        Thu,  8 Apr 2021 08:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617868888;
        bh=eqLdGS2wSVG1c6ZY6RuWyIqkPV3l6BBB7ZLZz/COD7w=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Tb2jWvIqK20mZpYJsyNx5WmeD7J8YojTitKZNvW3PotaRfZj20JEz665J/h2Hud+9
         MdEA12IQkVSTWPuNkP2qUWoecPpnozrEaGJgtDERKXCHtRykuDFGDmkePQvUTr7mx6
         FzIKzM1VSdJGUkQ5apkKXK9JcqCMK2L2fm3obEAK25AFS537jEzqr3qgY6EXPcS7Qq
         qvUjAJpfvaUdpzo6HEN5e/cfgdDflCfpFSI5Sx8molu/ctGVVztVZL67QeJI+kHg2K
         nOwqM4Ym4h5FUxVCqmcTSx7Nrht8r7R35Al6UV1S/9Qs9BGUKBA+X8TOIYqimnKxsW
         R6zCzwN7NKCvQ==
Date:   Thu, 8 Apr 2021 10:01:23 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
In-Reply-To: <YG6fpgmYSg/PwOrU@kroah.com>
Message-ID: <nycvar.YFH.7.76.2104080957580.18270@cbobk.fhfr.pm>
References: <YErOkGrvtQODXtB0@google.com> <20210312183238.GW4332@42.do-not-panic.com> <YEvA1dzDsFOuKdZ/@google.com> <20210319190924.GK4332@42.do-not-panic.com> <YFjHvUolScp3btJ9@google.com> <20210322204156.GM4332@42.do-not-panic.com> <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com> <YGbNpLKXfWpy0ZZa@kroah.com> <87blap4kum.ffs@nanos.tec.linutronix.de> <YG6fpgmYSg/PwOrU@kroah.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 8 Apr 2021, Greg KH wrote:

> Removing a module from a system has always been "let's try it and see!"
> type of operation for a very long time.  

Which part of it?

If there is a driver/subsystem code that can't handle the reverse 
operation to modprobe, it clearly can't handle error handling during 
modprobe (which, one would hope, is supported), and should be fixed.

If there is a particular issue in kernel dynamic linker that causes crash 
on module removal, we'd better off fixing it. Is there one such that makes 
you claim module removal unsupported?

Thanks,

-- 
Jiri Kosina
SUSE Labs

