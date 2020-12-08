Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD57CC433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 17:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD28423998
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 17:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbgLHR3i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 12:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgLHR3i (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 12:29:38 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB6AC061793;
        Tue,  8 Dec 2020 09:28:52 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c12so7433042pfo.10;
        Tue, 08 Dec 2020 09:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1eCjyv5AYQr2qxuLo6/ait7gDzN7SzMmyZr3TYkqLG4=;
        b=ZmI14GuVeT5a+LFPJTmG0K/1PeM+gSpk1flxbpHVzSZh2uuGl69LDd5vVkOZKaWWnj
         zdUxr07jZJK53rlRRYtmCJGeiocmgsUeatjkry3S6k17Qtzfrh+C4r9U8SQ3jthMjRFl
         mgv0R9f+Sd7jSCxcZrXsAVH9KQZY8kpU9W1qhALvNJWY0e8DNdTlqWT6eGdTFlpXoUyz
         VjCV6cJQNXOX2ZinMWe9x+i6zqJ+gz/jh4n7iGHUTv3ll+PB+n6wUnUOulzwELgyQSEk
         vPmcyJJ5CAIu0eRHN2Fp6iC2n9KI61y1598gt2VZ1QsZQli7c4IW5D2Sw71OF5zmd18k
         o9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1eCjyv5AYQr2qxuLo6/ait7gDzN7SzMmyZr3TYkqLG4=;
        b=sLBs/99VdZjgNyavUN+xzvZ0RxSwhiDxFGKS50g3Z83HfIB4ocrvcLstAUKcbzJfQJ
         GQenZd4F3/+ATtUfX4dmLWGF3tOTYMyYbua56p5eZhAfJKppWEYa4FQ53txTmmU/3ACM
         TcwJ0N/3p8PhCMdIucphKFYRJ9gcX0Rs7PLEbJROuHH3l995jPY/aiFyH+zo6+wQokP9
         szGCtumrLvX+p59oYH2XlmTvvTsDHELRCybj59UJdegy1nzAILyLTtR8642WQqYYZQnu
         IAynhuWKbv5m2q3OAgfUHDfDvykHdGALD/3FuU9yZ+l1o9VDgi62WoVOVKa9HFhhH077
         W2UQ==
X-Gm-Message-State: AOAM532laOOOeaCuqzHeBBXl+QM9Y8hV38CS6K8a7t0N+CGa1eu9cZLL
        +P4rDQCKoALoQu7nJzagNHA=
X-Google-Smtp-Source: ABdhPJxmyvNMMzVsga0L1faMWDx4HgMYMUroGfCmiEvwynPjPl7a2bzIW0LukZZb7Xtd4kuIsLktzQ==
X-Received: by 2002:a17:90a:3ee3:: with SMTP id k90mr5172362pjc.164.1607448531916;
        Tue, 08 Dec 2020 09:28:51 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id f7sm18019852pfe.30.2020.12.08.09.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 09:28:51 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 8 Dec 2020 09:28:49 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] zram: break the strict dependency from lzo
Message-ID: <X8+30biXWgNRlKRM@google.com>
References: <20201207121245.50529-1-rsalvaterra@gmail.com>
 <X8+3X2piRUi/jIa/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8+3X2piRUi/jIa/@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 08, 2020 at 09:26:55AM -0800, Minchan Kim wrote:
> On Mon, Dec 07, 2020 at 12:12:45PM +0000, Rui Salvaterra wrote:
> > From the beginning, the zram block device always enabled CRYPTO_LZO, since
> > lzo-rle is hardcoded as the fallback compression algorithm. As a consequence, on
> > systems where another compression algorithm is chosen (e.g. CRYPTO_ZSTD), the
> > lzo kernel module becomes unused, while still having to be built/loaded.
> > 
> > This patch removes the hardcoded lzo-rle dependency and allows the user to
> > select the default compression algorithm for zram at build time. The previous
> > behaviour is kept, as the default algorithm is still lzo-rle.
> > 
> > Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > Suggested-by: Minchan Kim <minchan@kernel.org>
> > Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> Acked-by: Minchan Kim <minchan@kernel.org>

Ccing Andrew
