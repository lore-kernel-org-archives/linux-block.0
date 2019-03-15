Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8619C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 13:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B041920854
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 13:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="DOm3k7xY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfCON1r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:27:47 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:36699 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCON1o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 09:27:44 -0400
Received: by mail-qt1-f179.google.com with SMTP id y36so223692qtb.3
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=No1HWm0EsCJCKhgJLbb3/U/NHO8sMm1k/TSYX8LGc6Q=;
        b=DOm3k7xYFoHXos1RvdmIdXhpBQAYPDHy9rp4+wXKTEfosJSu0x0usHOezzegKlg5lh
         Ske6dLEJgMQKVQFaW8LHTxi3i5eVwP++jO/HwV/CrcQ33PGMm/GQq7rAsQaSc5o+fO8j
         2G4U77ocq1EW+UXUBlVKzqC++Mo/UEIai9wlgPwumMOAnnYuKt+KYDdvJ4srvty/z94H
         AjBwnrDbO/NhfPKs+Rtpwv9fKSYRadkgrLLyZakDUssdgdUV76+HvwXQTldCAjVTrYR0
         Vjk3qQIq2ezdv7ZO+QwAJhwLJIjLE2SvFyTyTz4iqjzmAzvW+oeRBs/4BF9BsJ0klKTO
         TgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=No1HWm0EsCJCKhgJLbb3/U/NHO8sMm1k/TSYX8LGc6Q=;
        b=jeFMRaoyfoGKp/6wJGfW9lk80oN9UVY1PfWF6mc56S5Haa4AmvSoGEsfe8TTpX0U2B
         XQyNnBf+HxuF5uG+w8LcoAfcnh8X99OP77qM6jBAZ7reVtujrAzYqCwG0ktGU5tn93kW
         q+xxAsFUIu27Lg2CbfIbLqdoyN2vljtUx8tRd764v4g2JxAelUMlYSlYCXLnZ8kenU0E
         CRpvDa1khkOJHLDJLkPwB055uIYwZRUriYS/Uz9coEDcYinCn4CcG9xJJg25KAk5tgec
         0suFujxci9Lu59EOBra6sAhKqmpWlxTz6FAQXnr/4p1Y8UCtVccBp4GR31byB26v32Hm
         +UnA==
X-Gm-Message-State: APjAAAWCV/zcT4CnC0nUV5N0xFnvzGXlrdgJNWbTJQFuGRTWzm9INPWm
        0dNQI73lqncqgyO8XrRcojdWNA==
X-Google-Smtp-Source: APXvYqz7HLKof8j3jGEoMoEfytO3lSQQVR/S/SdZ6syIQqabjFNdZDG/SL5NGoFYK8OFMQW7jmvsLQ==
X-Received: by 2002:a0c:b89e:: with SMTP id y30mr2557406qvf.52.1552656463123;
        Fri, 15 Mar 2019 06:27:43 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w33sm1438382qth.34.2019.03.15.06.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 06:27:42 -0700 (PDT)
Date:   Fri, 15 Mar 2019 09:27:40 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: nbd: fix a missing check for nla_nest_start
Message-ID: <20190315132739.mfnbkp5vdjx2uhko@MacBook-Pro-91.local>
References: <20190315063138.17666-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315063138.17666-1-kjlu@umn.edu>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 15, 2019 at 01:31:38AM -0500, Kangjie Lu wrote:
> nla_nest_start may fail and thus deserves a check.
> 
> The fix inserts such a check and exits gracefully in case it
> fails.
> 

Except it won't because we pre-reserve enough space for that attr.  Subsequent
calls could fail, and those are checked properly, but this one won't.  Thanks,

Josef
