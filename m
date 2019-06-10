Return-Path: <SRS0=HnxX=UJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F74C31E40
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 15:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC4D20859
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560181705;
	bh=tY2Twzshbyv/F/dRRUK/cHBz65eIbvLq7uCSVNc++aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N1ADr5FhK1BP7ZvoAFNKL6hVDxIMktpSxqkbeoaZVhd6xEH8TJlBeCABkGxLAPn5t
	 WPR/tgBAiw4Yb/xSBjFztSqI6r2e9uPduO6Bk3h9FIygVf4DjhADWvKktiZJf3PnEM
	 yGaD18pZMRH8l3fpNOaZtNgyGOjYgz8BrHyA7/0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390596AbfFJPsY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:48:24 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:42981 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390335AbfFJPsY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jun 2019 11:48:24 -0400
Received: by mail-vs1-f48.google.com with SMTP id 190so2055084vsf.9
        for <linux-block@vger.kernel.org>; Mon, 10 Jun 2019 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=InSX//BsPgLGRgFvSD/3zSaZWr/eH9f9X6VlvUwK580=;
        b=YIx/57wJQlnvZwTNs3zcAWqTLoVrnINCLhrEjmdBR8NQSu9SSzyP6610YgM+/3x4Iu
         +uorNjg3fG0Xvrt/WAAz/b1L8YwSU8uYVDbdWZYmIqfgkvdyQ/4iBwfk1RV2bqX7rBHc
         AcQmis5iGB8YwlJOHETbLN+yiNk1fkkU17bZrjSHLCFoowIYDUzy3T3FdGJTu9lLAit+
         HCCinthJ7WVuGr+cUmNqffdrGJLnKlV2U2jwFR7atLRwISW1BwWcXmk1Iq7w98LU7YB1
         av1GDY1DbfuvIh8w1s+NvAOOFj52vt8Iy4QtnFPSeFYBlNHmMqyIc6C894fU/QD25wg/
         2xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=InSX//BsPgLGRgFvSD/3zSaZWr/eH9f9X6VlvUwK580=;
        b=liEXUz+2A4idN5CYF29O6SsLYf+tJSD1ayvwMD6WLCKDaKbZ5z0NTPyXuesflVlpjk
         wOFvdlhoJMY/EjWoACaE0JtUJCBebSqC4QJibQe3Jgr3l5tLTSlGkXut1wpkFtvWWkcx
         Qt+24ffK/aOI2YcXjSUWIsCuGTdT+hEQlYds1leCy6M+JP08Vf4vrBPWzkGLZ841uZae
         DPO2f9u6rtBlkVsM/12Ae2NO3KRgVeoo3rVlx0/hqu6y4nIMVjG+llOxIXPQOGkwBGC3
         j4WQpM1T5NNEj1dgnwiTMFYetoRmnWQ/WGabRZ6tJcUaLfTTKgmX2L4UZd4Klq+CTinY
         H6YA==
X-Gm-Message-State: APjAAAWMHQot0puMlSoRXAo+0q8oVR+yUag80hTKcbnEfGUk72nGpOXj
        FWcNCExJk2TF9Xz5oGm0roo=
X-Google-Smtp-Source: APXvYqxOPhv72wp9AGBBoQ5nrIWeMTiMgT/LHnXOeqYxb8XOoceSFbF7c3aTmt4a3faWYzMbbVCfkQ==
X-Received: by 2002:a05:6102:85:: with SMTP id t5mr5175913vsp.221.1560181703400;
        Mon, 10 Jun 2019 08:48:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:1677])
        by smtp.gmail.com with ESMTPSA id g41sm2907164uah.12.2019.06.10.08.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 08:48:22 -0700 (PDT)
Date:   Mon, 10 Jun 2019 08:48:20 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fam Zheng <fam@euphon.net>
Subject: Re: [GIT PULL] Block fixes for 5.2-rc4
Message-ID: <20190610154820.GA3341036@devbig004.ftw2.facebook.com>
References: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
 <CAHk-=whXfPjCtc5+471x83WApJxvxzvSfdzj_9hrdkj-iamA=g@mail.gmail.com>
 <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
 <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
 <ebfb27a3-23e2-3ad5-a6b3-5f8262fb9ecb@kernel.dk>
 <90A8C242-E45A-4D6E-8797-598893F86393@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90A8C242-E45A-4D6E-8797-598893F86393@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Paolo.

On Mon, Jun 10, 2019 at 04:49:47PM +0200, Paolo Valente wrote:
> 1) General solution allowing multiple entities to share common files:
>    rejected by Tejun.

It was printing outputs from multiple policies for the same device in
the same file without any way of telling which one is actually being
used.  It can't work that way.  We can't show stuff which don't make
sense to users as a part of the kernel interface.  A general solution,
if we want to pursue, would be in this direction but something which
actually considers what's being used where, but an easier alternative
would be selecting the active policy system-wide.

> 2) Simple replacement bfq.weight -> weight, after the only entity
>    using that name, cfq, has gone: rejected by Jens because it is a
>    disruptive change of the interface.
> 3) Symlink, proposed by Johannes: maybe rejected by Tejun.
> Tejun, could you please tell us whether you may accept the last
> option?  This option may be associated with deprecating the explicit
> use of bfq.weight (I don't know of anybody who wants to use this
> confusing name).  So, in a few releases we could finally drop this
> bfq.weight and turn the symlink back into an actual interface file.

Yeah, it'd either have to be 2) or 3) but I wasn't really engaged in
the discussion.  The simplest would be just renaming the interface
file given that that was ppl were using anyway.  Jens, if you aren't
too opposed to it, let's just rename bfq.weight to weight.

Thanks.

-- 
tejun
