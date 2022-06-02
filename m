Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF3BCCA479
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 08:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiFBIFp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 04:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiFBIFo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 04:05:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B390D12099
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 01:05:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h5so5433632wrb.0
        for <linux-block@vger.kernel.org>; Thu, 02 Jun 2022 01:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CqOoFv5ajKhhxuaIXwvvd9yF2mOBWHc6FT8FH9XleP4=;
        b=dUEHQ0iLv5JTPM8zRlQ2Xk5Quzir1yaICVyODgCYssqVnR7oCUfDPh7WVPI7fbnAXf
         YmTbwmormFhGjp8219I9Kt+r4MqHPUk5uroTQeciDbu2NBFDQ8sMD8PeUsepfUyDI/iE
         4CXeJ3WyCGNMRm03y07B5wuLf3+qDchEcQ4wcDWsihzlhvo55vCJTjmrJDTIuo/KV6u3
         keDpgvJNAtdowjc5BgEpx/fSJjVFwDD9FGS+mUDZu8C3vHJz4WBU5/bMVHJoF5tHvsaD
         KrGZe/2MmASd72xISXRjkgpCWylgKlYz2k+wU5VyLfm6mTE0S/lt1Ozv0Y9D93JlYWgk
         5MPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CqOoFv5ajKhhxuaIXwvvd9yF2mOBWHc6FT8FH9XleP4=;
        b=fl8O0n4qKIDYMA6gsbWIzuHKRAdutQwb+vCewOYtSuwBzT281KEj1ld13GlE6AbM8L
         oNX2CoiYuxH0Ajbese0Sxvz+ZVHaDsJ957eZAAAiKK3H3h0zAeffPH7pTxztV9zjQtcH
         Sj2fxYkSEekej/CkBhVV+ayHKBCR8u4hpCL4Ffw2i07KJFUTIkxyoKM4P0BRwckQsP6o
         EQWeS7plsUIIo+tnLEbk9+pERaKd4SWZkwY7XYgvkyFkcT6Kgy/nkqLuOr+WtRN9uSjx
         HgJGXcNf5J0kgerPv9moCDjD8W8qDfo/h3ITL5PGn7Dc48yEF3jR+q/0UwUfXWiAg9a5
         00gw==
X-Gm-Message-State: AOAM5329irRdYDGhTLHJhMnfzWRUP5G4kp4H7imXVxuK9fFWAmPmj1tu
        DouksA+9ZaB/aWVZB/D3OlMiGQ==
X-Google-Smtp-Source: ABdhPJyVe7JZW48l90LBJZKfQaeiwP+tN9o+v5/aRcI01HsnqA/Dtwqg+SouYLPIhJ1nBazalS6rSw==
X-Received: by 2002:a05:6000:1b8d:b0:20c:d372:f07c with SMTP id r13-20020a0560001b8d00b0020cd372f07cmr2535752wru.607.1654157141231;
        Thu, 02 Jun 2022 01:05:41 -0700 (PDT)
Received: from [10.40.36.78] ([193.52.24.5])
        by smtp.gmail.com with ESMTPSA id v19-20020a1cf713000000b0039c18d3fe27sm4151716wmh.19.2022.06.02.01.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 01:05:40 -0700 (PDT)
Message-ID: <f333ef06-6aab-81cb-e998-44b91670f9ef@kernel.dk>
Date:   Thu, 2 Jun 2022 02:05:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YphKZBtmtKFRNIPL@infradead.org>
 <2ae24afc-6474-60f3-ece0-fb5a1d19f8c5@kernel.dk>
 <Yphtx84vMpkX+bsb@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yphtx84vMpkX+bsb@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/2/22 1:59 AM, Christoph Hellwig wrote:
> On Thu, Jun 02, 2022 at 01:49:09AM -0600, Jens Axboe wrote:
>> On 6/1/22 11:28 PM, Christoph Hellwig wrote:
>>> The following changes since commit a1a2d8f0162b27e85e7ce0ae6a35c96a490e0559:
>>>
>>>   bcache: avoid unnecessary soft lockup in kworker update_writeback_rate() (2022-05-28 06:48:26 -0600)
>>>
>>> are available in the Git repository at:
>>>
>>>   ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-5.19-2022-06-02
>>
>> Eh, I can't pull from that... I used the usual git url with this tag.
> 
> Sorry, that was my push url.  The external facing one is:
> 
> git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-02

Yep that's what I used, and matches what it should look like. All queued
up.

-- 
Jens Axboe

