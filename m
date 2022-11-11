Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F977C4332F
	for <linux-block@archiver.kernel.org>; Fri, 11 Nov 2022 00:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiKKAhS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 19:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiKKAhR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 19:37:17 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C358B959C
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 16:37:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso3336712pjc.5
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 16:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=joENuXZdCD3xg2y3vBRwMSO4BUP9wXySx77lEgOxTdU=;
        b=Qkd/eDkw5bDGoNk59bjQkjFqB17uANwrULMAAfIyNup6NMRtIdipemKzmdRwlKvc0Y
         m3gbegXJ41j+KOdrnFkD+PTdQd5lBs9ojFZ8toDmT0YZosaGq+j7kyrCx+8/w/qt7OMq
         6pXoyzpiq4fgN8uf0/qpL5mYBi/vgzt6i3+1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joENuXZdCD3xg2y3vBRwMSO4BUP9wXySx77lEgOxTdU=;
        b=J8c2eFydcp9F1fd6cnmZSmAbuwjjgoQmOUAH1gVCsD+Tr8t+vjNH/cg7Z5QOuVHM4o
         b9sc2oivRV9eTpoFG9SGKwryC1LgSiXdvxK/fyxM7fvjSg+nwLIfzk4F89paGznDCk8w
         S5t2JopKAfgmga0GZWM6n2/CVPxekkfcGR+t/p8E86N6ce8AAokhPHHDL0iYpYXsV42S
         AoNq44+tMaBvbRgoJF/prHug4LUiwS+8eJc/psSKgiK7AANecTd115O0+dOQZRDDDxwQ
         BHQctmeDBE242ZVoPyVNLPgYWXMYlS9IknBy8lk5LeMrmaP4RhjUzlbJAGResq8MLFiS
         zbUg==
X-Gm-Message-State: ANoB5plotMQd5+toeUOtl+CB4bF82N0LxaCQYaN6PESJ43RqstvTS9ma
        ZPHCwY7+lfhhnNaxvay2z5LtwA90xFbZJQ==
X-Google-Smtp-Source: AA0mqf67I+mNMSyBu5fw9kL7x/lMPOnne39/x2DjuxhKeAAUDDUXN/85avp90U0klAYNieKBXS/LjA==
X-Received: by 2002:a17:903:324d:b0:180:4030:1c7d with SMTP id ji13-20020a170903324d00b0018040301c7dmr97707plb.99.1668127036277;
        Thu, 10 Nov 2022 16:37:16 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b00186b138706fsm306805plj.13.2022.11.10.16.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:37:15 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:37:10 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     coverity-bot <keescook@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: zram_recompress(): OVERRUN
Message-ID: <Y22ZNtdH9s+cuL9l@google.com>
References: <202211100847.388C61B3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211100847.388C61B3@keescook>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (22/11/10 08:47), coverity-bot wrote:
[..]
> 1704     	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
> 1705     	/*
> 1706     	 * Iterate the secondary comp algorithms list (in order of priority)
> 1707     	 * and try to recompress the page.
> 1708     	 */
> 1709     	for (; prio < prio_max; prio++) {
> vvv     CID 1527270:    (OVERRUN)
> vvv     Overrunning array "zram->comps" of 4 8-byte elements at element index 4 (byte offset 39) using index "prio" (which evaluates to 4).
> 1710     		if (!zram->comps[prio])
> 1711     			continue;
> 1712
> 1713     		/*
> 1714     		 * Skip if the object is already re-compressed with a higher
> 1715     		 * priority algorithm (or same algorithm).

prio_max is always limited and max value it can have is 4 (ZRAM_MAX_COMPS).
Depending on use case we can limit prio_max even to lower values.

So we have

	for (; prio < 4; prio++) {
		foo = comps[prio];
	}

I don't see how prio can be 4 inside of this loop.
