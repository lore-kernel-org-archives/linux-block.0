Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9687EC433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 13:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5635164E61
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 13:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhBVNgt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 08:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhBVNeo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 08:34:44 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED60BC061574
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 05:34:03 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o63so10220557pgo.6
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 05:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uv7YVNLgBFeEaonu1d3TUmnYtxDPsnIBaNc76btwyd8=;
        b=sO006ejs2B6bhaPDTXOobF78uzW4a1uE5BMwMMHf+2YMz8F7DnbtabiEsyRy8uKNhN
         BHEnVTmjso/gE13kvnNULICN1HJMjLYhczKEggWlHvHmKWmIlXxVGIfFzlGsfh6vnLQg
         0hO6F20vL9c5xN2VYa2Vhoyzo3mLRfqDwxaUHOqSPYmCncnbyfuAz6fPDirPndfFMIQn
         uinMCX6UV+hNxGYGOtpU3ocW/+MkErUEz9+4M+SdARtZuEa7s3tcoozoub0vfDkMpxYP
         s+mQ24K1KlgdmNMYtn2dHeqgO+rJqJXzQ7xDYNd6L8OFBRNUHAUNqoKbZ4jnVM6xRW4Q
         hCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uv7YVNLgBFeEaonu1d3TUmnYtxDPsnIBaNc76btwyd8=;
        b=Kg63JGUBCOuo+9+4NCyd3S8dZBFQ4i2uix64WKmuX0az49pxZhXFwO08a2sQvsMFT/
         gYauPW+Ozdh40cqETsFllpB8Nui7DvSyl80x2pUGVteSXamOJ1g3n6nDQq/H68+zZrVO
         HigVDaXKurpQ35WRhWFIbQj6iIWIZCxbJWoDxeU0QFw9dMeLL0X2yAqHHo0LSkuGPMms
         zBitN104knBMzd63tpIGzpIVXNIiF7ZWrwr1oaWHabIGoIuxSTvl8EMpSsemarXvcowC
         +rM4WJXWqlH6nwKK9iKk2mAb97LFuRzJ3+4u5Nw6cPHkcQ7F0+uEMZ/jrnm2qs80nwcq
         tqAQ==
X-Gm-Message-State: AOAM533LXtsNaPYZFMga6tlokY8z9rrbXmWC9o03QgmRkeIOnQcQ96UE
        jNW7Cb7/0vPoRyIRHADlcGMb778HmBZ+bg==
X-Google-Smtp-Source: ABdhPJw7XY62NRR0iFC9AKxm5qSHU0fsRobJlZ71YsrFzBkWXX52h5x1+OQmGMHOnKRtAkZadbsMIQ==
X-Received: by 2002:a63:d153:: with SMTP id c19mr4979083pgj.311.1614000843441;
        Mon, 22 Feb 2021 05:34:03 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id gj24sm3755732pjb.4.2021.02.22.05.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 05:34:02 -0800 (PST)
Subject: Re: [PATCH] block: Remove unused blk_pm_*() function definitions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20210222022805.18196-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <36f80121-6dba-77b1-a7a5-3961e37df409@kernel.dk>
Date:   Mon, 22 Feb 2021 06:34:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222022805.18196-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/21 7:28 PM, Bart Van Assche wrote:
> Commit a1ce35fa4985 ("block: remove dead elevator code") removed the last
> callers of blk_pm_requeue_request(), blk_pm_add_request() and
> blk_pm_put_request(). Hence remove the definitions of these functions.
> Removing these functions removes all users of the struct request nr_pending
> member. Hence also remove 'nr_pending'. Note: 'nr_pending' is no longer
> used since commit 7cedffec8e75 ("block: Make blk_get_request() block for
> non-PM requests while suspended").

Applied, thanks.

-- 
Jens Axboe

