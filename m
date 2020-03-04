Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C3EC3F2CD
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 11:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D885C2072A
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 11:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583323042;
	bh=L0topIv8kz8ZQ4dejVVXJVQkcjk526zk411RnRKavUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tytolWMem2dRWfkEi2jRpoluszr9No9DjWrbX26hZ1kH1aljHDIVxexx+xCWP/qEZ
	 GI+/EDUILHOBfFmKd5GUYbaCEZlQLlIAa5aGUjPy2B3a6DRWj8HwnOJ6R6ff/S8uOH
	 JUQ97ahUlN3RVz18+IezHEWQuzNt8Jr+sPbtknw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgCDL5W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:57:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34625 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDL5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 06:57:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id z15so2074641wrl.1;
        Wed, 04 Mar 2020 03:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y2POv5yKAFPFxKEVVoDHsptl95vHly+52LS7lFnVSNU=;
        b=IuNLEEfGreZQDTJaSpBrykS5VBw13GyuPmL7LKkAZ17qUpxc8W8gLnp1VS1VMFWxGZ
         Fl7Xd2O5yp6GYmV0aaoyabbOB9LzE28wqLDRRiuCpPJybtTSosFxJYj4Q+kdhI1uLOzj
         hQsUwWfwTjum/xLOqTVPZTEsf+J2cVHjwNAZGndEuxo3TWgZATm3dEl//96I2mIWT2+o
         A1vmCV1zk3Way6nlkIjSx9nY0K0oVzGzN8rSllBPs6ydRikpWyqeyo4lyyJO8IUssPO7
         tDxyBzvLIKyfXq67eOwYJJMSXzHJK+a+Zs9BoQQGVBZ57d3AnylL7pselaMfGm1di2t3
         jSYA==
X-Gm-Message-State: ANhLgQ23/xh4ME0SfpHbrPdtEc4sDlYpjrFZEBzlEhGR5EjI92SK1/pV
        ki7LimZOwbYVjqKZFpZ8eIU=
X-Google-Smtp-Source: ADFU+vvIZFHpo3NiEpdgXXp89vw0jByCNcMIVmxj9HXx/8bCwyXHeNoA3ydh1p5sqYJXE2uDEoUMIw==
X-Received: by 2002:adf:f9cd:: with SMTP id w13mr3727605wrr.406.1583323040210;
        Wed, 04 Mar 2020 03:57:20 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id j16sm38810219wru.68.2020.03.04.03.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 03:57:19 -0800 (PST)
Date:   Wed, 4 Mar 2020 12:57:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Coly Li <colyli@suse.de>, axboe@kernel.dk,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        hare@suse.de, mkoutny@suse.com
Subject: Re: [PATCH 1/2] bcache: ignore pending signals in
 bcache_device_init()
Message-ID: <20200304115718.GI16139@dhcp22.suse.cz>
References: <20200302093450.48016-1-colyli@suse.de>
 <20200302093450.48016-2-colyli@suse.de>
 <20200302122748.GH4380@dhcp22.suse.cz>
 <20200302134919.GB9769@redhat.com>
 <20200303080544.GW4380@dhcp22.suse.cz>
 <20200303121918.GA27520@redhat.com>
 <20200303160307.GI4380@dhcp22.suse.cz>
 <20200304113613.GA13170@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304113613.GA13170@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 04-03-20 12:36:13, Oleg Nesterov wrote:
[...]
> IOW, I mostly agree with
> 
> 	- * Flush all pending signals for this kthread.
> 	+ * Flush all pending signals for this kthread. Please note that this interface
> 	+ * shouldn't be used and in fact it is DEPRECATED.
> 	+ * Existing users should be double checked because most of them are likely
> 	+ * obsolete. Kernel threads are not on the receiving end of signal delivery
> 	+ * unless they explicitly request that by allow_signal() and in that case
> 	+ * flush_signals is almost always a bug because signal should be processed
> 	+ * by kernel_dequeue_signal rather than dropping them on the floor.
> 
> you wrote in your previous email, but "DEPRECATED" and "almost always a bug"
> looks a bit too strong to me.

So what would be a legit usecase to drop all signals while explicitly
calling allow_signal? 

-- 
Michal Hocko
SUSE Labs
