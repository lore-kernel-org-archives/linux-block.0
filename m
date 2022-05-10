Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BDFC433F5
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 23:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiEJXDZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 19:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiEJXDY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 19:03:24 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715471EAE1
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 16:03:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m12so181143plb.4
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 16:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HPk+go5LyIucQgon9794k6akBZYk28Bmhe21akj/n20=;
        b=0j49XluBdgJJkAIC4ixE5sWTHvQGAaXecSvRbhEqdHUlBTM0uydyVXU4MoDjh6i3YL
         KkTyEh6oorXkRF0atEHueVIacBj9Uz1CeECriFbWLfCdxgQsBSYeUqHfEdSUARWQZwQi
         jgZCKAHWHlIea/ntChdtcHxRYzbbCIlepjX3Yr3ns+7nRl/PTpliB72e353l2ualnyN4
         6cfyc3Kc8rrF3gtHhets9+eL1SVN3qARBhSVoAD/1i+lu1agklbzalADLiklqDlfT42M
         8yQvGoFr1IzZDbWYKI2xPant0UVjQ2cX70T0iakP3fR9SeKACxaWhEtHU2A6iv56qwkK
         LacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HPk+go5LyIucQgon9794k6akBZYk28Bmhe21akj/n20=;
        b=CSzQdF45FHEEtvg5WjTYw0jMwHSu35MLypf0OFtbb38QUrHtMf65WtpEBuUzDLLZvB
         dfe6OiQKtBdLrgpVo2pnRbxj3TnCVvGc2IXISodIDyzqSctGduTCVYPzXsf3j628EfKv
         albD6FO487o3VlqIFaTpwOPLTpvXxKfHEv5yDoT/lUPbLaZAK7+H2L93wZrmsafx+x5P
         L0SxKC+Y1byNiPfZO27y0W3r/g7H0SDI6GCHQ5mwX5KCpIAu6p3BfMUYdO1irrg4YcqX
         y4NGpm1lu4rZsHmlIASzDQZadGKtDho+h9jx9mydE9U1I0QvzVLiTlcinCypOekYJHTE
         icGg==
X-Gm-Message-State: AOAM532w+TKyYak3DOVDmjF6LUe2dFWXKWW47MWt+p7I3KN7/cvxcq7r
        6pkDIXE35weySDer3s7dMIGhKqAekOCzDpNE
X-Google-Smtp-Source: ABdhPJxdKTYAg7KUXD/WHP28AYe/yHERD8UaJK59wD2Y1X+HqL2x2XddrYaYpX8pwjnN3vp+DlneBA==
X-Received: by 2002:a17:902:b684:b0:156:80b4:db03 with SMTP id c4-20020a170902b68400b0015680b4db03mr23031260pls.16.1652223801877;
        Tue, 10 May 2022 16:03:21 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j190-20020a6380c7000000b003c14af50627sm241761pgd.63.2022.05.10.16.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 16:03:21 -0700 (PDT)
Message-ID: <09a72de2-c171-63d8-ff0d-13050aa40c87@kernel.dk>
Date:   Tue, 10 May 2022 17:03:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] block: reorder the REQ_ flags
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20220510130058.1315400-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220510130058.1315400-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/10/22 7:00 AM, Christoph Hellwig wrote:
> Keep the op-specific flag last.

Not that I'm against the patch, but we really should have some
justification in the commit message as to why the change is
useful or needed.

-- 
Jens Axboe

