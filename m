Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB91C3A589
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 17:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DCA2064A
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565890503;
	bh=jZQNTS7JeYOtb34meyZbI96CYuPKeV0gPhc+9hftCpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ol2yHiDesDQ8Sjrf2e2Amexog/ba4G8/P9x1aJnX73iq+d65Alo1xWLVBhobmuijI
	 xP+b37598w09RrEj2XuzkuurpFKnp/ni2tZh9ee4F/SjuUrvIkk88n9mNd76yeE8Jr
	 ReMiOPUE4c143BIgqe5S3w4LQ8hns8Yy/PXmXYPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfHORfC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:35:02 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:42981 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfHORfC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 13:35:02 -0400
Received: by mail-qt1-f174.google.com with SMTP id t12so3148048qtp.9;
        Thu, 15 Aug 2019 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ZSbStm7AbDlXUhKJSg3L8e0NLU9fEch1EIrUdDIspw=;
        b=gfG9UzxThCigCBaKBs4lpzT/DQERj6tRex3zsyhWWtC5mNoRtHY0KVhl1Eusttge/6
         gTa0XkfdlzW5xd0gUiYLS0otjvybVrqu20zk5hDPLSTPCA42Rld4afQ1YnK0eHOHfAvx
         XchEDv5NXEmt5CcVefyG3DYRIVtmobbNBMwDKn8GtVpQKOTUK9LexdYi+sTLctzGyNxe
         TYWo1VhCO+dbNXL98G4TvRHHRh6LRAXKcuaLZV2w+2AsiVgzdSbIulXiEvLbHnLjM9/r
         FAzV2hVYQhnbnkcDrUmUq0qh4De17xFpCKGwoLpS0fpwYewK6JYlJy0m2NMukOuaQRKo
         U9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ZSbStm7AbDlXUhKJSg3L8e0NLU9fEch1EIrUdDIspw=;
        b=c6DeMdCfgr+r15p7LEkHKlY1hQ37rACT/jyfedDPlBf1NrkBrzgJk66QROvwD5yo9N
         71VpVo+EHD9GrSl18nYWCZS3cSOyz+tBElFXf2VTuOk+dz/iIRK72OdZP1pdPuGmep67
         Wc1jn/epWHFPvkXcew9SdsctzaksMFGQWEKmLrV/380m550PvruIg0meC9+hbD647PE1
         2kbD4mClYNIx66pcUN4SQANCC3HYOC+P1rvngtefb7OIDI/G12C1vv/qrupKnUlIhBdn
         zMlLQWz7UOhVjZYJgycUqNxteR2IUP3GLkIN28mnCB60weUn/gasfdPFeyMSMyuL+br1
         4k9A==
X-Gm-Message-State: APjAAAWWCMR1VIw2YUwsflUOnAnwQLNXF/vMpi8efW+FvQ758NpASctW
        Jl3wdBI94LQ9GvcVsuYCtyc=
X-Google-Smtp-Source: APXvYqzlu7N6cRvS0ocSXBCf6KXcLrqKgjEDpi8R5FqcX+e5okBZTdTHSPWh9rbIZLoOA+UBtTrZqw==
X-Received: by 2002:a0c:e588:: with SMTP id t8mr4042293qvm.179.1565890501439;
        Thu, 15 Aug 2019 10:35:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:25cd])
        by smtp.gmail.com with ESMTPSA id y194sm1687796qkb.111.2019.08.15.10.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 10:35:00 -0700 (PDT)
Date:   Thu, 15 Aug 2019 10:34:59 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     axboe@kernel.dk, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 2/4] bdi: Add bdi->id
Message-ID: <20190815173459.GE588936@devbig004.ftw2.facebook.com>
References: <20190803140155.181190-1-tj@kernel.org>
 <20190803140155.181190-3-tj@kernel.org>
 <20190815144623.GM14313@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815144623.GM14313@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Thu, Aug 15, 2019 at 04:46:23PM +0200, Jan Kara wrote:
> Although I would note that here you take effort not to recycle bdi->id so
> that you don't flush wrong devices while in patch 4 you take pretty lax
> approach to feeding garbage into the writeback system. So these two don't
> quite match to me...

So, I was trying to avoid systemic errors where the wrong thing can be
triggered repeatedly.  A wrong flush once in a blue moon shouldn't be
a big problem but if they can be triggered consistently by some
pathological behavior, it's an a lot bigger problem.

Thanks.

-- 
tejun
