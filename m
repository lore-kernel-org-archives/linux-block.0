Return-Path: <SRS0=2XXV=ZD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFD2C43331
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 16:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E7721783
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 16:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573489103;
	bh=+6hQTzh2QYfYNuiGM1FK6Zq9ZcNL7L1DY9fILcPeOI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G1N4Oth9oKi9P2jlSfWU0FEXhIUWX57gFQk94Favxjs4zaKUIV5zKynv2lr1+UW0C
	 yY3UMo+Aw4yTRpb+DRuVYPgkF5muHwEGPqIFU0ZyOFLK7IOvxNFVWZAylBed4neJ/L
	 Jy7gZlYv6kEBcJWLvxZRuopu+7iofM1ZX1H+zfZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKKQSX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:18:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32889 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfKKQSW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 11:18:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id 71so11691372qkl.0;
        Mon, 11 Nov 2019 08:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YRVGHXt1HB9qr+Ma06FeEs+skE0icWgw+AMbzL9P2lQ=;
        b=bNsLQ0eI0tap3aMy6CVd2+UQlL25GEXlN+KxXYJ+9xq2sptfLDYMoHpbdW4N/Fzd4K
         nmMNkdUtb70AJTqTgzlunbfQA/F6iX8kz9jww9EfQAMbGCczBotScIUAl+iv2VjKiznn
         o0+25IuHKMmMHgaD+3TS7WgptnVPiEYSrscl9mpqxi2rprKu1BcPSsPSs7vAx/7qRhE/
         NXmHf1kMYrlrjqj51fxdGA+SL1HHvyt/XDaYbJQkMG+cpjo234GidLQmBUMfvBZMaXpq
         Ei20K6D03JnVveAQ9G4pS+VHtEYqugUyZN7euKS6VjQmJaT8sMP9ZJI3n1yyoAFYzoRJ
         7+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YRVGHXt1HB9qr+Ma06FeEs+skE0icWgw+AMbzL9P2lQ=;
        b=Ki7O3VnFv+OEUMp0SFBidyGFrWMwyWO/NzPir2Es1/TCQPfaRg87ENw86t6JA+9jw4
         2waIDZ9rFUctaCDifjpoTD3geRO8XSpfF3b494KTmO+bZBDY68Lp24MJiSbebkIoOSnr
         sosMB0RY41HYI5+RKeW4NeUV5JGKC+Ebk1VPSNULTINuI/rLk6sgm3DIXGpBFwcAxot/
         0JzSGEI7F04Fe1qzbMCPi967W3Hk6pLXUh/qqENDs9+Lv6NsGm3I9gQ314SnQSg+9nK6
         zWG0IXbI9ZtdeBagHekhmjhOSV/fWVtWgTRWZawl/td5XICb3MDeq/5kuLwDm8XJvBAh
         i4qg==
X-Gm-Message-State: APjAAAVFOFgjrDiV1NzhmD6x9ft401G4CmgydmReMRs1AYibZb7JKRYg
        IZuuUNZD69Czn4NbstVCORA=
X-Google-Smtp-Source: APXvYqzJ7ee1aj2ZUVHsuKp7Q6LunW7BCFaVfjrXFVfR8mxdhiojTdtgHEL9ligoqU6r+sazpq/9uw==
X-Received: by 2002:a37:9d96:: with SMTP id g144mr11251823qke.93.1573489100671;
        Mon, 11 Nov 2019 08:18:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:73b5])
        by smtp.gmail.com with ESMTPSA id p33sm10891029qtf.80.2019.11.11.08.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 08:18:18 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:18:16 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@fb.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Dennis Zhou <dennis@kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH block/for-linus] cgroup,writeback: don't switch wbs
 immediately on dead wbs if the memcg is dead
Message-ID: <20191111161816.GA4163745@devbig004.ftw2.facebook.com>
References: <20191108201829.GA3728460@devbig004.ftw2.facebook.com>
 <20191111131544.GJ1396@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111131544.GJ1396@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Michal.

On Mon, Nov 11, 2019 at 02:15:44PM +0100, Michal Hocko wrote:
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Cc: Dennis Zhou <dennis@kernel.org>
> > Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > Fixes: e8a7abf5a5bd ("writeback: disassociate inodes from dying bdi_writebacks")
> 
> Is this a stable material?

c3aab9a0bd91 ("mm/filemap.c: don't initiate writeback if mapping has
no dirty pages") likely addresses larger part of the problem, but yeah
it prolly makes sense to backport both for -stable.

Greg, Sasha, can you pick the following two commits for -stable?

* c3aab9a0bd91 ("mm/filemap.c: don't initiate writeback if mapping has
  no dirty pages")

* 65de03e25138 ("cgroup,writeback: don't switch wbs immediately on
  dead wbs if the memcg is dead")

Both are fixes for e8a7abf5a5bd ("writeback: disassociate inodes from
dying bdi_writebacks") - v4.2+.

Thanks.

-- 
tejun
