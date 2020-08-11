Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4844C433E0
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 19:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A941920782
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 19:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YUDT7ps6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgHKTxq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgHKTxo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 15:53:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36BAC06174A
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 12:53:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c10so1930392pjn.1
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HUeEh/Jol5rGLKd9TzkUnIYwPuOB4unmy8/8aW+J2e0=;
        b=YUDT7ps6SbFFHmJ1K+/R8wkxJgTaatLcNrXU81ChIYwOzlAsXnn9G6G7OWOxjXbiRp
         698S9grYc8nycWEvZuvIIVIHF52Iyj++hE2twaC0bibYQlkaNStTknDETM/WqTvXkS2Q
         lYv0HlVYDgTGL4vgaSD4/8cjdyOxeEYQsPfZRV58YcjBiq4EVPx73aV0Fvq5xxAGprkk
         GcNg9EOL33D6fNEkb2lO1a2CoxVC2UToRnzuc8mCHhIMItyOytBuxG4VYYanRg7CGKnS
         djOTZ7wr4ClqcjPNKLPDSHLbUf6n/1MSJ/MqVVHDd0yNaTQk9LOwP9FdQunsBvP8vyLr
         OAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HUeEh/Jol5rGLKd9TzkUnIYwPuOB4unmy8/8aW+J2e0=;
        b=GJcv4swDxBDSaYGGSjgO4briZiBHopeRSegJaE5tUx7zX1UzIluBgef+StK4gJqhbs
         wYymqd0f7F3gpvfZkTCOhCixbH+R3zct6o/uAJk8wpZkAp5hAfBQSqT6Pvp0WZNaE9X9
         N1ANue87oRbjoYHXPI4ir03hZeGfGhPQYrPf76TIeJzBXwlfYhasx/1YXooewodVccfz
         YqYwzNc3blCHEOaceLqUb1TsjmKRUFfna3U9bdVykmZ0JcG3qdN3osN6w7g2whQgBdi/
         qPuEGKY3vSd2XNRbdBF4x+kDTCQJRhICvZCl1n0fT4gJ2Tgj+qptfrrnX8hnV2UJt5k5
         6eKQ==
X-Gm-Message-State: AOAM533gpz3kIY1eAwlpDn0MWE+XbEH30EQmke9spiH9tCpZ7xFIT2Gz
        wXNcYQdn6Fwq1HTAh71r/vV0Mw==
X-Google-Smtp-Source: ABdhPJy4il2+HtbB8Yg4w4uwqlz+3CWEkFgTd+reqPK0iaAehSLhnpfAfAkqAnZrsTv+94Gd5L6xxA==
X-Received: by 2002:a17:902:b205:: with SMTP id t5mr2389647plr.7.1597175623227;
        Tue, 11 Aug 2020 12:53:43 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f63sm3574034pjk.53.2020.08.11.12.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 12:53:42 -0700 (PDT)
Subject: Re: [PATCH] block: fix double account of flush request's driver tag
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20200810035950.2211549-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da692df5-6b30-fe02-42b7-adb1c0e30bee@kernel.dk>
Date:   Tue, 11 Aug 2020 13:53:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810035950.2211549-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/9/20 9:59 PM, Ming Lei wrote:
> In case of none scheduler, we share data request's driver tag for
> flush request, so have to mark the flush request as INFLIGHT for
> avoiding double account of this driver tag.

Applied, thanks.

-- 
Jens Axboe

