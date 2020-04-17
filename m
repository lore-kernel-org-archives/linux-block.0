Return-Path: <SRS0=bgcA=6B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230C7C2D0EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 14:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70E920B1F
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 14:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hcfQPOHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgDQOW3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgDQOW2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 10:22:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7AFC061A0C
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2020 07:22:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g30so1137516pfr.3
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2020 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1mjhi/vw2O0pWtL1L+I1BJBKmVKf6YJhnj/uKAs8WK0=;
        b=hcfQPOHy1owTc4NkDbg1cgGC14uO4Or6hks8TjO4dr9ed6hyywwRm09/xwhxDeChmM
         noRyzKQuYp2YSki89Y74KpaOMgQ4bDO3Hj+1U4t2RThLBEXcS+UPZT+SKHV/5LjFr6+R
         sZZK1tife+ycq7118QoM94kgot4rFUlgqWbxRzaoam+rkfuqi/Wj+zmsMOxvFOlJ3TjI
         Xp0fWM8NCuAKx6WWBS3A0lz870stnrTfqNFFzCxmYBl4ccHWETcnUlIhld/24dkd54+S
         41l8a4gREnxQmoH+IxClKsq7VUnssX4ds1zlJ9ICT0cfeNA1MCxlIqYFAF4OAJqZB9Sw
         Z39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1mjhi/vw2O0pWtL1L+I1BJBKmVKf6YJhnj/uKAs8WK0=;
        b=AKCyKZJp2mgQZslKo8C9kuig1otq28IqojK9y34pNQLUD15A82pC1KwW4eogmmRKaL
         pa+tOPJZfQxSUoVJHncBvA1Oz6TvDxe5Tb0fNByYwleU+ge5V4JqUBQadnKWZ64FkheA
         GTRsYpwPDkLtmQAMuKFPQzjyM7Hyl6z4KhJE+pAwx2Mypeb4whYg6XtsMYfaf3VKJAqM
         3vEl6RwCByqcsDQqBSQC+fKtBXjIssdYvdkqeBQjo1+bENdvzdjmsjCpapm0ysDIswid
         wSWXFRf/L1pHImok73qmw2vRgFIMvyK43tzbf8jb6OiQhXaqOYyAIYVjlQJ8WO5pIWV3
         wDAw==
X-Gm-Message-State: AGi0PuZ4ffe2QmFBCPd0FbXuB8cJ+m/r6vnss1qC5Dtvk9W90Xg2TBbQ
        tohQy+1uTUMhMdUP5D2VgmmFNw==
X-Google-Smtp-Source: APiQypIHuLffI9pE2UOq/KSndl/Gk+ULKTxg3i0PlkKmEpUI42IViGSXfVqhCBtEVbPQL3MuUlkeQA==
X-Received: by 2002:a63:5125:: with SMTP id f37mr3247139pgb.327.1587133347044;
        Fri, 17 Apr 2020 07:22:27 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id p8sm5897252pjd.10.2020.04.17.07.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 07:22:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-wbt: Use tracepoint_string() for wbt_step
 tracepoint string literals
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200417130023.104481-1-tommi.t.rantala@nokia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3948a162-f983-3b7b-9823-8c75dfe57736@kernel.dk>
Date:   Fri, 17 Apr 2020 08:22:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417130023.104481-1-tommi.t.rantala@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/20 7:00 AM, Tommi Rantala wrote:
> Use tracepoint_string() for string literals that are used in the
> wbt_step tracepoint, so that userspace tools can display the string
> content.

Applied 1-2, thanks.

-- 
Jens Axboe

