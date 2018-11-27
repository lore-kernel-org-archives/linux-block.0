Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6311C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 21:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBA921104
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 21:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="BoOePB6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBA921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeK1IJQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:09:16 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39734 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeK1IJP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 03:09:15 -0500
Received: by mail-qt1-f196.google.com with SMTP id n21so23470946qtl.6
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 13:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ft4FysKjllP2Cb91bdlCvGAwT105IzF6SBB9loc5crw=;
        b=BoOePB6kLkSnZtNKIPcQr3rKUW3BdTkn4WKLPB/o7AZYEO3KwwF2Gka33pvZ7Od4Wv
         crT2YUcWp7Ta37OtfbynZy2QqmmHy9apo0rTB3gdb1hAIZHVpaWUXZnHoaRS/S6PmGjA
         f/oCzd9ROZKMq81SX7yi6OKif3j5Nbg9xmyAMdhm3mbkjr8dH7FWx6hMNgi28l/JknAD
         bHlbjK/c1hdlqy6feSpzPFsvqD/JI24mBOYkL7hxXi6xPGK+5k4psVkSSwmCqb2sYPL5
         QQn5jSk9cODOz3wwLcQ83t2Vvq1wPZj+2y3f6jVpO3pU7te0P1vfQJqFg2VdQYsy8EHg
         v7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ft4FysKjllP2Cb91bdlCvGAwT105IzF6SBB9loc5crw=;
        b=qIZzZ4gsHLNGv4qMIOQBPcfXJiWfBFztqVfNTtLa0u77FOYEOJwK5JZXzDMWAgNw6C
         FvcCVYArOolcTlJk2DaLIWqQA/aOn75Y2rnWXvU/bPyjKLJbZhnTXTT/CgCpX6bDRXaq
         5AlaJK1AxvpmCuNiPGZyZokUClTdzgg1ZbcCyBpX0HogVdwBJfq+1UIwJcyDNblpoW37
         jAL4c/TuBXxWqIS0EjOyfBdrb0fWmh6CfvhdZT4FrPp6cU19I3J2f49/AiXpHlVFTMBu
         sJ6SRG0+72W3U3w981s3CFdFsuySq2z2H8+bxKygmSPm3ZSvEl1ueviuYVbrl5EQbdOp
         cwag==
X-Gm-Message-State: AGRZ1gI8rJgn+WDU82og87GFUjcg+8L91pb+rpEhKqbOWlWHZaxmbd9k
        jQXuoxqSmBMQhd1g0dtxu3+mTmUPOYk=
X-Google-Smtp-Source: AJdET5fb87C2Yaje6a5i+jQFNQ71eXwPb1H3RG1NCVI+lwx0sqrxL32T2iWYydo/2FZW00GXVqcU2A==
X-Received: by 2002:ac8:7644:: with SMTP id i4mr32987833qtr.293.1543353002882;
        Tue, 27 Nov 2018 13:10:02 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:4c40])
        by smtp.gmail.com with ESMTPSA id c77sm5121348qkh.82.2018.11.27.13.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 13:10:02 -0800 (PST)
Date:   Tue, 27 Nov 2018 16:10:01 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13 v4] block: always associate blkg and refcount
 cleanup
Message-ID: <20181127210959.3c2yhp7citaxoqxm@macbook-pro-91.dhcp.thefacebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126211946.77067-1-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 04:19:33PM -0500, Dennis Zhou wrote:
> Hi everyone,
> 
> This is respin of v3 [1] with fixes for the errors reported in [2] and
> [3]. v3 was reverted in [4].
> 
> The issue in [3] was that bio->bi_disk->queue and blkg->q were out
> of sync. So when I changed blk_get_rl() to use blkg->q, the wrong queue
> was returned and elevator from q->elevator->type threw a NPE. Note, with
> v4.21, the old block stack was removed and so this patch was dropped. I
> did backport this to v4.20 and verified this series does not encounter
> the error.
> 
> The biggest changes in v4 are when association occurs and clearly
> defining the cases where association should happen.
>   1. Association is now done when the device is set to keep blkg->q and
>      bio->bi_disk->queue in sync.
>   2. When a bio is submitted directly to the device, it will not be
>      associated with a blkg. This is because a blkg represents the
>      relationship between a blkcg and a request_queue. Going directly to
>      the device means the request_queue may not exist meaning no blkg
>      will exist.
> 
> The patch updating blk_get_rl() was dropped (v3 10/12). The patch to
> always associate a blkg from v3 (v3 04/12) was fixed and split into
> patches 0004 and 0005. 0011 is new removing bio_disassociate_task().
> 
> Summarizing the ideas of this series:
>   1. Gracefully handle blkg failure to create by walking up the blkg
>      tree rather than fall through to root.
>   2. Associate a bio with a blkg in core logic rather than per
>      controller logic.
>   3. Rather than have a css and blkg reference, hold just a blkg ref
>      as it also holds a css ref.
>   4. Switch to percpu ref counting for blkg.
> 

Hmm so reading through this series it's made me realize that iolatency is sort
of broken.  It relies on knowing if it needs to do something with the bio if
there is a blkg associated with it.  Before this patchset there wouldn't be a
blkg on the bio unless it was specifically associated.  I'm going to need to
figure out a different way to tag bio's to indicate that blk-iolatency should
care about it.  Probably add a bio flag or something.  Thanks,

Josef
