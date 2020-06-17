Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C96C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 15:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93906208B3
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 15:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aSmane2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFQPHe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFQPHd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 11:07:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796DBC06174E
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 08:07:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i12so1133181pju.3
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 08:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AgWF67PHI9atiPWS54R+pnzrJXTu3aqI3zonqO6HsSg=;
        b=aSmane2BResES4fuQPuzz0g/1YLk70BqOxjiRFGE0tJEagC98po2UgpsSXQbBHVgHr
         IcbW0tMqCkc4fEc521vbpdyiea/psdqfKwuk3zA50DHunRx2UZJAt0bfqnKZpJtt+RqQ
         XNALKTkfvB7BRTkBt+taDvnL7B73WBgkggIc/v+EI/CbL7DzkTEksV6Haw3mcPmbqSo1
         8RNWe1x5xagIbHSJDExMnPexzXXvI2CJA+Ly5dM25K6dKlhFgWi33JMO/eJkqDobPexA
         5RkwCEjDGTYtMKWQXo3Gr0NIDx8bUB8rcz6Zb0xO+ipxcyi8qHJaPP+0sbUZoydtnaAi
         FjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AgWF67PHI9atiPWS54R+pnzrJXTu3aqI3zonqO6HsSg=;
        b=kgP5iaqPC+zzv6QEpQ4yKr5kganBnIeuIEH+lWsl+CHk03I5ApUmj8YsipM89gDWtt
         axsoQYSFscf6nd9DUivHWXFuSWx1VLGQZ0VEVuO+3V4NXdtsCLQP7XZvBc32bSXIyuUq
         f2+CwfO3TZfEFj2RcABo7pi657x9G1AGNilaGtOvlHshacLVC2l7Sc0coYa6aVC0levk
         ZyJKCGCy042J4SjgBrqhwDG/cB2OTU8P8B3jp+BElQyaxbDk7+sMKxcwpGf1Hjy7NTFV
         daed6y3YlkAfTiLAy7ofKC/fBzA8H4/pJoM3zdwTfRziytmfycZ+M8cQdstoN6qZ01Cy
         q4Bw==
X-Gm-Message-State: AOAM532vfxZUaxYVhQ54njqU348cub+1YlJkZM6MzQO+L0vu0E48/wD2
        uUSLh0ULl0qys0FQSZNYk+E9+Q==
X-Google-Smtp-Source: ABdhPJzFtT6uX0ISpg1+PSZzf1U6DdGD0nuE86VPr3ougiC7phZ/+uEVXc7DuWCFnsp3tUZfZp633g==
X-Received: by 2002:a17:90b:3793:: with SMTP id mz19mr8084856pjb.12.1592406451944;
        Wed, 17 Jun 2020 08:07:31 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i3sm170403pgj.52.2020.06.17.08.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 08:07:29 -0700 (PDT)
Subject: Re: [PATCH 0/2 v3] blktrace: Fix sparse annotations and warn if
 enabling multiple traces
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
References: <20200605145349.18454-1-jack@suse.cz>
 <20200617125151.GA30907@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <66c99cdc-4028-a0c5-6ce7-fe29ebfc1ec3@kernel.dk>
Date:   Wed, 17 Jun 2020 09:07:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617125151.GA30907@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/20 6:51 AM, Jan Kara wrote:
> Hello Jens!
> 
> On Fri 05-06-20 16:58:35, Jan Kara wrote:
>> this series contains a patch from Luis' blktrace series and then my patch
>> to fix sparse warnings in blktrace. Luis' patch stands on its own, was
>> reviewed, and changes what I need to change as well so I've decided it's just
>> simplest to pull it in with my patch.
> 
> Can you please merge this series?

Yep done, thanks.

-- 
Jens Axboe

