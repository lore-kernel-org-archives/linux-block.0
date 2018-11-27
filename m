Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC720C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 21:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9182133F
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 21:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="wqUG50Df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9182133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbeK1ID5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:03:57 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45262 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1ID5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 03:03:57 -0500
Received: by mail-qk1-f194.google.com with SMTP id y78so4748222qka.12
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 13:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DKhHMZUmO4T2JI4GxBQQCY43PdHMrucN4JTGGfDXF4A=;
        b=wqUG50DfArZzDI2OENoPA7BlkLdyZFZecJxoqhGbU8JT0QLUgpjFdZ28glcNyCIpJH
         lvr+lLx0UGFkPTk3rpMRBui/6wna+WpJuCEG5yyCTyzthtoEOhkbdpADrH710MDpqA5K
         p41XUCY6XCpQtI+G2GXbRfA5+6BVCxJHcnjN3Q/rjVlm5CdB+aI2uqdadGHA6XJCFdxd
         gqgCWUXPHoFfWikX98jJGDE/DLxV5UJXDHIx8DvkUlWLMsDrD5OebyirJ1GEM7YijMdv
         lT/Xrom2boQMjjaUHykYIVLkke9UJFiPzcPkarS5z2iT+zJE9SP3WgKg8Q0ICAX7SEKZ
         mzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DKhHMZUmO4T2JI4GxBQQCY43PdHMrucN4JTGGfDXF4A=;
        b=I6eUTiwCQeMxil2ut1/Cond6eRKaMvHrgEhtzqOxFDU3ZGlOYg4PAGawCIZ4WiQDES
         1UP1W9FiEbbrCzV0Zwkxu+IRnNtKfMO9oONKwOM6f2fojWkbthDWk1mkqkuwcqLjbTea
         0Qwvqjt+Z7H7KjAGHyYERUr3cLPdKjBEqiE6kx1dg9ymb4aycJjpxmDPt4MfmiZ68ang
         dOmBeBqMI6rboa/+2rb1dZAUJ0yElfC4TDCq+R/RJO46KkI54w9ilQJEXitUKEm0gSFM
         Srv9v6UWYy5v2uAFbEZZ5Troft+UHS986YCEIm7UInNgjBuR3mYPOpunBuAF67QYNfIk
         khRA==
X-Gm-Message-State: AA+aEWa8zrMvzEoJ4RUBcjzcYo/Z+odO6h2zXlSr3MI+D4Np/tvFOKvM
        9c3aDlE+n2r3pjO2g0siOwR3pQ==
X-Google-Smtp-Source: AFSGD/VBweFeKfke3uTryRrU3AtmvjqVKtxOzIWXhtbP8prOB9czS9a0tZ35vjaIimeaMLPe9DOSCA==
X-Received: by 2002:a37:6749:: with SMTP id b70mr31414512qkc.41.1543352686559;
        Tue, 27 Nov 2018 13:04:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:4c40])
        by smtp.gmail.com with ESMTPSA id j36sm2901421qtk.15.2018.11.27.13.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 13:04:45 -0800 (PST)
Date:   Tue, 27 Nov 2018 16:04:44 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] blkcg: introduce common blkg association logic
Message-ID: <20181127210443.pornubsaa6vcbgih@macbook-pro-91.dhcp.thefacebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-5-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126211946.77067-5-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 04:19:37PM -0500, Dennis Zhou wrote:
> There are 3 ways blkg association can happen: association with the
> current css, with the page css (swap), or from the wbc css (writeback).
> 
> This patch handles how association is done for the first case where we
> are associating bsaed on the current css. If there is already a blkg
> associated, the css will be reused and association will be redone as the
> request_queue may have changed.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
