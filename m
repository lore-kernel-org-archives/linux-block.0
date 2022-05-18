Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397C7C433EF
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 22:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiERWpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 18:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiERWpT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 18:45:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307A217789E
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 15:45:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n10so3449332pjh.5
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n3iurgYZFISFcgs5X6Ldo3ldCenlvZbMBwRmkDfrSRQ=;
        b=5rG+sdyHVtjwPwhb1iNcxH+nhvlYTDGmCKevlJ5V2Hqe8fzZSMRLDSC4t6Yjnbc2gV
         c60YVPIbyfdWFhUCtEuKUCnHK8CPW2drGqeayOHEGueeUKnWTMsI1tEdSOwhgeAygOJJ
         ASSed+aKowoMDjmUDKFRLkO4lpKQ3upYsOTAUVd/NL7ZnmXV5Oef+MzvSN/Huc1UUpfx
         1BbbqmQyj5iP55U84fbu5A8yTh2asAyal+teKaUSUFezFX906W3TWIiDQGjutmjMLoJj
         wLoFu9xrR5qntkZmbBEHa0iBPoIPo9zyCjLxBpTpkXtbgxHtMqZpVva9FcKkrJCxcT/i
         abqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n3iurgYZFISFcgs5X6Ldo3ldCenlvZbMBwRmkDfrSRQ=;
        b=5UyOpq+M0oxM25ochx+Xz5y77rO/mwZuJkqIXmK7xtZ03a8yg+qbI+IzpRPsRzwRnK
         l2+9iVIelhE8uEMn51F8spQfmlL5e4sRWW7Snhd4Q9/ecNjJGE9TxkquhOzV4zDeOXM+
         S8pvqk+JJTG/GmT4GRUHYHkV8WEM1/3Ra0rq0NW30+y31cftRCtvS0bDWKqXyI3K2FAd
         RuGDWimbPxwZKeLdXsg/FDxUxiALs5xCyAK2WXK90hfs+5D6PJC+bTY4S8auyeLxkiF+
         S7tFe0ifq95bkes88azbIGhkk0nnXbPvC1f+j539MS0zriY1UN08RYjllzRhWP3nyFx/
         xcXQ==
X-Gm-Message-State: AOAM531h20A7zrspprGU4gf9VmCH77ERtTTUQid6PfTnIlkYE78AwJWZ
        H2xtlKWg1fXZYKtnxxmfnjzD4Q==
X-Google-Smtp-Source: ABdhPJy3YhvhjlQnttfqmRtz2KT4IM2BrtBedUcYiqsNfPkqD69wW5klYhC5CpiiFiI1W0I9GAAsJw==
X-Received: by 2002:a17:902:d48d:b0:15e:c236:4fd3 with SMTP id c13-20020a170902d48d00b0015ec2364fd3mr1784979plg.113.1652913917682;
        Wed, 18 May 2022 15:45:17 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x21-20020a1709027c1500b001613dfe1678sm2185354pll.273.2022.05.18.15.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:45:16 -0700 (PDT)
Message-ID: <dc8e7b85-fba1-b45e-231e-9c8054aea505@kernel.dk>
Date:   Wed, 18 May 2022 16:45:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 0/3] direct io alignment relax
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Kernel Team <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
        damien.lemoal@opensource.wdc.com, Keith Busch <kbusch@kernel.org>
References: <20220518171131.3525293-1-kbusch@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220518171131.3525293-1-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/22 11:11 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Including the fs list this time.
> 
> I am still working on a better interface to report the dio alignment to
> an application. The most recent suggestion of using statx is proving to
> be less straight forward than I thought, but I don't want to hold this
> series up for that.

This looks good to me. Anyone object to queueing this one up?

-- 
Jens Axboe

