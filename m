Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A458BC31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 20:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77360217F9
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 20:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560543747;
	bh=aj7/fKQ2N8GaCWCXCM5VRIPo2tvA9bdQFm5FspRsgpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Evl/X3xNIxxcSAy8co6aiwuuB6UORq58AXrsrZq7TtWIgvG2EqfVjqhSJj8wQr52u
	 LB5kjOEaVQLekxlCregtRSU3mEuO0ms5a6sbaTUmpBrF1xtichq2Pt6u6TcbZ1UWIU
	 EMnncBFs1Xt4UzP8ZzNy4QwmGnO5WZSKPwK0yiMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfFNUW1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:22:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41464 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNUW0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 16:22:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id c11so2507762qkk.8
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2019 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1D7SCUGd/jECjCkQnxTL5EbaroBUrsfwVZfavWMPTaY=;
        b=b0B7tpBKRQ4f819g06EquNP6eZbbD4D0ptp0cJvAZNVM+ZPCZjXr4I5U5qcjZu4Aim
         P6swDsLVLQ3ZMEUYyLdLegAyIL5c2faB9kgm32fv1xF98CFKtDCtCQt1bnZXhCWvtYDb
         uXwD34+NiGX+UZFGGSJo55+gHHRVcctskonVfkWlJYvpQZNw+gt5wMhi6gTMNkqPGWhH
         Ss6LBncfRrKJMc9bfUKl5GrK/Q4HMZ/uXVUC+KrqbcTaGpUMiXOvrSFDyHbxD+NKHxf6
         lCkdrNCe0OkeIfpOAOnFHbNtWZZxVsS71eN/B9yQPiWgCKCXLhfu4HeJByNe8kAXUCNK
         1PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1D7SCUGd/jECjCkQnxTL5EbaroBUrsfwVZfavWMPTaY=;
        b=BrGsf2vdlCmg6fkf9j+w0GHqdsYE0qatRatCCudb7rg2ZXKUdR6AjkWArYwSehiPl4
         2VVxQqexMTXmgf/PlmPcFqjV3npNsZ27eD/JOFhtGKTx7fXIO3bq0sL0wQ8jCZGCAk2/
         rFO7rNgcY3Tok5Wcu7xMypg0m6YdFYqXMmuYVIbuJXJh+Nw4O1OIRHtyXpIiQwUXA1jv
         w+8Tx7Jja4iYU0uOD7lLjBnEP8vnEDWULtNiRh06WsBZMFdwWdcir4qfsY7oxO0k0NV9
         PCYBuDRe2skTIkeS/7GMcO6R3dIrxoCrOfUR+F4DPgjEsNmyhs10zKQ8uPvwEAVYILOe
         qsKw==
X-Gm-Message-State: APjAAAUlPrGwPJ6gQClGpqvll42UC7ZOSRp7KotTiWsVb5f9R83KB4Qr
        L76an6PG0nLm4n8Y0/Hh51s=
X-Google-Smtp-Source: APXvYqzNUiDJZDU5H/4qBYvHdSIP5DpCH/1+m+IIgrrE35WDGQ8Z+1Cec6SDiDywOh6qp/XjWsOMJQ==
X-Received: by 2002:a37:a343:: with SMTP id m64mr39341643qke.75.1560543745585;
        Fri, 14 Jun 2019 13:22:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6bab])
        by smtp.gmail.com with ESMTPSA id 32sm1762684qta.91.2019.06.14.13.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 13:22:24 -0700 (PDT)
Date:   Fri, 14 Jun 2019 13:22:22 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH block/for-5.2-fixes] bfq: use io.weight interface file
 instead of io.bfq.weight
Message-ID: <20190614202222.GC657710@devbig004.ftw2.facebook.com>
References: <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
 <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
 <ebfb27a3-23e2-3ad5-a6b3-5f8262fb9ecb@kernel.dk>
 <90A8C242-E45A-4D6E-8797-598893F86393@linaro.org>
 <20190610154820.GA3341036@devbig004.ftw2.facebook.com>
 <20190611194959.GJ3341036@devbig004.ftw2.facebook.com>
 <20190611211718.GM3341036@devbig004.ftw2.facebook.com>
 <A1C3E3D8-62E3-4BD3-86B4-59E7E1319EA8@linaro.org>
 <20190612133926.GN3341036@devbig004.ftw2.facebook.com>
 <530F0FC2-EBE5-4417-8732-010837C18357@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <530F0FC2-EBE5-4417-8732-010837C18357@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Thu, Jun 13, 2019 at 08:10:38AM +0200, Paolo Valente wrote:
> BFQ does not implement weight_device, but we are not talking about
> weight_device here.  More precisely, *nothing* implements weight_device
> any longer in cgroups-v1, so the documentation is wrong altogether.

I can't see how renaming an interface file which has different
behaviors on the same input to the same name is something acceptable.
Imagine how confusing that'd be to userspace.  If you want to rename
the control knob to io.weight, please implement full semantics for
both cgroup1 and cgroup2.

I just posted a separate io.weight implementation for cgroup2 but it's
easy to provide a way to override the interface files when bfq gets
selected, so let me know when you have a working implementation of the
interface.

Thanks.

-- 
tejun
