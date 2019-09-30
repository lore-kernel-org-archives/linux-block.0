Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1155C4360C
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 01:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917942082F
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 01:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qsF1+Pja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfI3BDe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Sep 2019 21:03:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45486 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfI3BDd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Sep 2019 21:03:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id q7so6382267pgi.12
        for <linux-block@vger.kernel.org>; Sun, 29 Sep 2019 18:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nChOCBPXOk40nlg9qp/LXBAnELBGlt3t6VJwDE0swYI=;
        b=qsF1+PjahVpwhdE5/6+bqyFSJ/3+x6y92uf6FQIPEkEFX5+OcXZ2Qt5ZeQ4VCRAMj6
         AOBUDXTdtglDNo6w5qixkjpGgbSF/24Qot01KPH11Ewfa+Ps5DEBmqpjpibb9JN6Pdtt
         +4+wWd4bxokffrfcMKUpqUO35vF9hUrCviIayKRM4UIlWuitQF9gjBnCFTE92qKTgPRW
         l2cxii3Ko6uERqkFrCg38hk5X3SDpNyyciY3a2OdIyHq1Zgs5LmOdZsJJ/isjfgt/ci6
         KTZ0PHoT9iETc4GvhlcH8jes+7PkSA0SKX3ViJ6pMKWDzzBPeKgJPXnM66pUvzpD50hX
         8WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nChOCBPXOk40nlg9qp/LXBAnELBGlt3t6VJwDE0swYI=;
        b=WsR8O10Ce3+7Ne8cI9v08cA3YM9QyaJJ2xyHw+CdiHHxF34WIhHmcY+Lcot1mIq7ub
         wNmKWPB2n/XWwgpckFt4pKeTsrTAunmV5690WnU60BKLE3YEp1mMc+5pmdIhUkcyufUm
         GhHNStn8RED0PmTEGKRdUMV4HhBjpdT4tX0E93n+oI8LK2XyfWolxmYRGMJFXWVnKHJ1
         Hbvev/WggWWkMFSCt+IgNnYGjZjw6xyRBx6/v8WNlD+tqv+THHvWRTiSO3wIl+0J5wpt
         qlnjhKUgFiE7ZfMDGIXDPrHfWkBp0UajzW7YI7lM5IdiNK/7cONmZADELhnX7SoWSAl9
         nBGg==
X-Gm-Message-State: APjAAAXO1TC3nKmJZnf/0RFr2ZPXVtISVF5Ix5fuQvyQMhe1HgQ7JO+5
        6sxBvg3HFv5HJqorDFDBRaCXio7AMy0i/w==
X-Google-Smtp-Source: APXvYqyC9Fxq2AXE1HfS/meFlJ9n7rE8/VFV2ckl5xiRgu7ZXYXpD4laD+fiYjNwd2Ban2W32Yu+zQ==
X-Received: by 2002:a63:4749:: with SMTP id w9mr21655676pgk.153.1569805411167;
        Sun, 29 Sep 2019 18:03:31 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id u17sm11144922pgf.8.2019.09.29.18.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 18:03:30 -0700 (PDT)
Subject: Re: [PATCH v2] io_uring: run dependent links inline if possible
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <d1413db4-7ba5-2d4a-7f46-8734da452222@kernel.dk>
 <6D11D22A-52CC-4089-962A-CECA4F49C418@kylinos.cn>
 <d26d5585-0f31-c6c1-b139-ab0a8a1bfd4e@kernel.dk>
 <84D443CE-9F9B-4677-A3B7-E212F95C044B@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0dbbd933-a5a5-536b-40f5-302ec24143a8@kernel.dk>
Date:   Sun, 29 Sep 2019 19:03:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <84D443CE-9F9B-4677-A3B7-E212F95C044B@kylinos.cn>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/19 2:52 AM, Jackie Liu wrote:
> Cool performance improvement, Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>

Thanks for the review.

> BTW, we always use s->needs_lock to determine if it is in async. Is it
> possible to consider replacing it directly with s->in_async?

Yeah I think that'd be a good cleanup, would make it clearer without
needing comments to say that they are equivalent.

-- 
Jens Axboe

