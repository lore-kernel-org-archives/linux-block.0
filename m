Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA608C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 20:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD1620660
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 20:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="KgSSMt4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD1620660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeK1Hxk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:53:40 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37210 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeK1Hxk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 02:53:40 -0500
Received: by mail-yw1-f68.google.com with SMTP id h193so8521041ywc.4
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 12:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bqyE1nmXeAtPZbB2AL1Q4bwPXAN2rTBpblfeBKlhVg4=;
        b=KgSSMt4L+4tqXR2s+UHTYAZflYlIuedUbXzViNuZYxBCrGfB2P6tWYKhhL9LqkWnIY
         uIWLGg625SPIus4yfa8vQ4Rn0berTLnGHGJa0iC2cJa1eD73Mt8pBBGxNhs12Ms1ggKI
         uksj6n+fKLc9mFWtfr5/rf0CwViWF9qHyxCrZ5RORsfJAT+ehnebXCrGtBK2naK75PTa
         ZR/Etd+hEl93Th/ytTmMiCidhAapEKabckiaf41BfTMzQlwxwJd5YIaSy8qZoovKLOD6
         z3SMMTiPewSfzgbh5hyY0w6FVDCe/+tBO5ZYPm47xWSCJszcmh28uTamHa22akWBpx2D
         BYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bqyE1nmXeAtPZbB2AL1Q4bwPXAN2rTBpblfeBKlhVg4=;
        b=gx49zrJjDX1s3AqTo/RujNVjeiCmpD+JE1MS5roSuY31SbCJQKTkWBBvL6FBSZQHmh
         YK1c9NvSRcBUvqkglw2k8uT6Pi/8Ywwng7dTlRzpjLmXyz621wC67qETw9w33MydJ93N
         vZYTMauSJSxmoQbvq/G3ALvI6ZaO+bWcbt4Zi9mcrZZiHXPEZhqXat57GJ9yrNbjpLwY
         /FT61zR2FNlgHGaBYN5DsXyce5DMQpE6XD5YNTiHN3OuAou/riBtcwcDs+zejulBPiE5
         noUIOuTtM2i69FoQNUCWm8Bk46j+bmVSqAi1DtXt4mIDbHBHWIlsalf8k1NkkgOSYj75
         0jxQ==
X-Gm-Message-State: AA+aEWZMM4IH6mPe3DgOVrnyQUQHl5xYjiKmyGMrfH8VYtu8cKY50mT0
        NAfVksMPWgXdqIj5bQMnqxaSdXVX6J3WVw==
X-Google-Smtp-Source: AFSGD/W3fopZM4IlQqmVurdng6nsmhdzsV0f1hTb8FMPFwdnrBuIfh5RMX8fJIu21kFMB7sYYy4xfQ==
X-Received: by 2002:a81:3883:: with SMTP id f125mr8960690ywa.507.1543352071016;
        Tue, 27 Nov 2018 12:54:31 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:4c40])
        by smtp.gmail.com with ESMTPSA id r20sm5290513ywa.13.2018.11.27.12.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 12:54:30 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:54:29 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] blkcg: fix ref count issue with bio_blkcg() using
 task_css
Message-ID: <20181127205427.v2x7ezd6jgkxg562@macbook-pro-91.dhcp.thefacebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-2-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126211946.77067-2-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 04:19:34PM -0500, Dennis Zhou wrote:
> The bio_blkcg() function turns out to be inconsistent and consequently
> dangerous to use. The first part returns a blkcg where a reference is
> owned by the bio meaning it does not need to be rcu protected. However,
> the third case, the last line, is problematic:
> 
> 	return css_to_blkcg(task_css(current, io_cgrp_id));
> 
> This can race against task migration and the cgroup dying. It is also
> semantically different as it must be called rcu protected and is
> susceptible to failure when trying to get a reference to it.
> 
> This patch adds association ahead of calling bio_blkcg() rather than
> after. This makes association a required and explicit step along the
> code paths for calling bio_blkcg(). In blk-iolatency, association is
> moved above the bio_blkcg() call to ensure it will not return %NULL.
> 
> BFQ uses the old bio_blkcg() function, but I do not want to address it
> in this series due to the complexity. I have created a private version
> documenting the inconsistency and noting not to use it.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Acked-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
