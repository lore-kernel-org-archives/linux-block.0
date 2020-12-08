Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F944C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 17:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6DE207D8
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 17:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgLHR1j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 12:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgLHR1j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 12:27:39 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F368BC061749;
        Tue,  8 Dec 2020 09:26:58 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id m9so12791043pgb.4;
        Tue, 08 Dec 2020 09:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JzJa62+h9IWO9HdUS/s0n/qxaiHYSZ6m+KmjEm7qI/A=;
        b=ncE9+Zg7HC8jdfWIIhPHTjJAXr5UIxUTHzt1InqoHrW/e1UJFlLmaiRL5fKLe7avKz
         okKotJllzT59Y3ZArL2FGKW7GVsh53SHOvgnBiTHgdBcje7A/kRKD074xe0NZ/0HotnI
         /kFDute9s4G2ah4hgKaBzww8XCFiLB0rxDc2uf0fEVnx4SEh85101w/zPVHwbzsX7feZ
         li6GMiI0jRXpt97kIf0Ov3duXArcZzhLfE3KZqcjBZvd3z0KyLL2R7sMWii90B4aH3FA
         6gkJTMDkfAGEI3/cqbNEpKdDPPPwwSFzKK+Wadefru0C20X9mo6nwqD6bhdaVbLg1jfg
         b20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JzJa62+h9IWO9HdUS/s0n/qxaiHYSZ6m+KmjEm7qI/A=;
        b=giM+KcLtzCjcficWdodd8X/XE+cOKmWPxwaf5cITja790xLeCaURQLAm4JKlB7XMV9
         DpRulOJdTCwuwWVTnBfXuekqVnDeHE6rWRbGUdbhZoz0faZilSaEnB6Y6GWQAnscWCYY
         qBg8kEEdkQR49EzHAksAas66SZaLFQSR1Bxhj0hTMzRsTjYVatcfWPtUnhEJhN/HevuO
         SgWY+3MuisNNT1rzQFS/67de62lkUN/4A828PYTKHIDj3MiijXSrHopnaFG13vGVXxXm
         iNNhyNSVwO3bWxk9A902wo3rdg+FkjtX4zoavHUWABp1ZDp9sl+sAEit1oBlFUv/7A6p
         mYPQ==
X-Gm-Message-State: AOAM533J6glwTaTdchD9F5S8DwOHFieCWDgQ8mq6XIgf9WYyVUTd4VdL
        rw6AIXCYGIea+fyEJY5DbsFqEEjwkcQ=
X-Google-Smtp-Source: ABdhPJyBlBcxgi5EPZ03wymn+gGdDug0lE6PF0vkwWWUKpt9cXr2oDDRhURvc5hiMdHq+34S720gUQ==
X-Received: by 2002:a17:90b:1886:: with SMTP id mn6mr5269014pjb.31.1607448418568;
        Tue, 08 Dec 2020 09:26:58 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id p15sm72870pgl.19.2020.12.08.09.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 09:26:57 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 8 Dec 2020 09:26:55 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] zram: break the strict dependency from lzo
Message-ID: <X8+3X2piRUi/jIa/@google.com>
References: <20201207121245.50529-1-rsalvaterra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207121245.50529-1-rsalvaterra@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 07, 2020 at 12:12:45PM +0000, Rui Salvaterra wrote:
> From the beginning, the zram block device always enabled CRYPTO_LZO, since
> lzo-rle is hardcoded as the fallback compression algorithm. As a consequence, on
> systems where another compression algorithm is chosen (e.g. CRYPTO_ZSTD), the
> lzo kernel module becomes unused, while still having to be built/loaded.
> 
> This patch removes the hardcoded lzo-rle dependency and allows the user to
> select the default compression algorithm for zram at build time. The previous
> behaviour is kept, as the default algorithm is still lzo-rle.
> 
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Suggested-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks, Rui.
