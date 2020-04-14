Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D4BC2BA19
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78EC3206E9
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586849745;
	bh=eDG8jUkXKP6GlO4ycCt674m7P7qKoklsMoL0hVpzxxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zBKYTvH0yFk0wsTfdNqam8bumVm8+5QoYQQMn49FdgR5yl6zhWwKosdEI0CStwKmN
	 TSgkAonlkotnJ8DisckdOEH4xcYKpMcq8RvzXGsg8amJILodR1DKCZaYk5VeM6K8vh
	 HvWwsKLJZW9eNzr+KqC9m9lfXl8h1gkGgvKMAa8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406688AbgDNHff (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406666AbgDNHfc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 03:35:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F8320575;
        Tue, 14 Apr 2020 07:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586849731;
        bh=eDG8jUkXKP6GlO4ycCt674m7P7qKoklsMoL0hVpzxxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wYpObs6ZvcIHIqra9ac5XXuKQw9De9kpn9vnNiIoKTMwYHwj7d75RlybGU0rHYkS2
         GBkEQDQLojwrekj1wP0m4GkbLsYiskX1vlMuBEkCTCDwxdBbZUrHXOtj56NEeXD8ZS
         ZBfE8rf3bz6SHKnSbROfmWD1AvCPivayZI/XrU9w=
Date:   Tue, 14 Apr 2020 09:35:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/5] block: move main block debugfs initialization to its
 own file
Message-ID: <20200414073528.GA4111599@kroah.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414041902.16769-2-mcgrof@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 14, 2020 at 04:18:58AM +0000, Luis Chamberlain wrote:
> make_request-based drivers and and request-based drivers share some
> some debugfs code. By moving this into its own file it makes it easier
> to expand and audit this shared code.
> 
> This patch contains no functional changes.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Nicolai Stange <nstange@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: yu kuai <yukuai3@huawei.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
