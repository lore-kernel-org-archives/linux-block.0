Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE596C54FCB
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 15:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7402075A
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 15:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ib2Njg09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgDWPfx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729018AbgDWPfw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 11:35:52 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5900C09B040
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2020 08:35:52 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id o127so6850561iof.0
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2020 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mYWosp1Hg5R0CXYCie6qdmSLtX8wD3fCZHntYs2LJ3M=;
        b=ib2Njg09kRKE8mXjkU6rwtdE9cWVfsiIf5CD1VnLI7UPfhrNWt1Wev4cd4KZ+tmsY4
         XfRwUE2K/EvDmJ/pmDRXODo4uxB05BISBNCxRMANsA9UyW6hwsG1QQzhCvEHZBfvPiBY
         LAqukHXqolBvOMq6gvUsStl8NUTil+3ryUnRXM5a1nxcGLasMXdGI5PI51GsT8JBVXxJ
         sfarlQGdlYsdTJv3FLwgbvQGvqMOd5wYeluQs0ZVMnl/ASZp+P/PAFzEZx80XjpYcjJR
         WWc97ZzbPYiys3fibs9wlkeucGyiV+FVZJTRYxSjNYd0Z78ef32vdl3SChvhWB7Ek6+C
         ifQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mYWosp1Hg5R0CXYCie6qdmSLtX8wD3fCZHntYs2LJ3M=;
        b=JFwiv7DTT+0sOTDjvDwOFm9GGxeUJavjtOhy0gm1QEI+3kKX98Pr9gKDV5UVF7tTuL
         B8EbzfXCT2PN+lnHx1+yVUQ8+Wtwup6Fk3CU3LN8HODCvQ4JOWE9lhYa71RWMogDS1u9
         8Jn108BTYP8Tkl3uAPhhclMOmavyfShHs9dLj7mCr5rRCeNf1SgfUpOJiWyAzlCBz+Yf
         0Wc++m57GVLDx8JqBjPjLPzn2nBJHkVEtFKuInSzwgr6Q3YhhlXg/mNYDgp1vqZ186T8
         zw4EXo0YuHgAAFDHI3piry4srzLw/W7Bho1nCecCN6LassLMYT6IDSYiZ0XciwtQEVF6
         GQ5g==
X-Gm-Message-State: AGi0Pub6Vae6DmHaSXX7ign3FFg8zCdVgwLocDX2b0NWAW/S25pXSaQj
        ps+nfbLkm1gQxOTTQnraapNuBw==
X-Google-Smtp-Source: APiQypKG3HUjUtDq8eTFMgHurgp1XPJibSiAzWDAtr1L/xvaAzC269eqUuP7CPGNe8NlayAPak7D0g==
X-Received: by 2002:a5d:914b:: with SMTP id y11mr4300464ioq.3.1587656152136;
        Thu, 23 Apr 2020 08:35:52 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b77sm152614iof.29.2020.04.23.08.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 08:35:51 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] null_blk cleanup and fix
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200423030238.494843-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <263f6213-6732-0c21-28aa-e97aa0db7a41@kernel.dk>
Date:   Thu, 23 Apr 2020 09:35:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423030238.494843-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/20 9:02 PM, Damien Le Moal wrote:
> Jens,
> 
> The first patch of this series extracts and extends a fix included in
> the zone append series to correctly handle writes to null_blk zoned
> devices. The fix forces zone type and zone condition checks to be
> executed before the generic null_blk bad block and memory backing
> options handling. The fix also makes sure that a zone write pointer
> position is updated only if these two generic operations are executed
> successfully.
> 
> The second patch is from Johannes series for REQ_OP_ZONE_APPEND support
> to clean up null_blk zoned device initialization. The reviewed tag
> from Christoph sent for the patch within Johannes post is included here.
> 
> Please consider these patches for inclusion in 5.7.

Applied, thanks.

-- 
Jens Axboe

