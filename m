Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35BBC76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 01:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjDGBBh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 21:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjDGBBf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 21:01:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7941E49CA
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 18:01:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6262956578bso69711b3a.0
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 18:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680829293; x=1683421293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xc1elUC0A6VPs2hEGtcnom0Oa7mWG0FGy+xTjiBZ0Uc=;
        b=HVsqCunVHwnGJ4IGSm0JmCFnfkIvqzCFEehBxpfDrnCJBGZlvSFLHFcL4rg1qdg9NQ
         sd6YbkeQnacdCw6BGDiGU1pABYtc4YtGvOy15TSdQ42XXyJhhNrTunBDIH1F0qy0YIyN
         jX4rhj7joL2Tx6zWc4eOK/KBSIF7NL9YDFe9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680829293; x=1683421293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xc1elUC0A6VPs2hEGtcnom0Oa7mWG0FGy+xTjiBZ0Uc=;
        b=ObgtWEZluaT9yQupilYC8oK5UIq6ueT1jHABFwE4Ciq4bwm5BtGIlPLpunJa+aTclz
         TaD/9yoqodbkookkaMjhZ9kyZb7qP3uyoM+TxkphOFKqg9foyBsTiJnd4e08dLaDGhoR
         gAn9zR+bLmUFzpRB39u0Fm3HZQKHy3/vtxuv1wba/1pyPrzodEA6RPVCD+lK3LIQQ5Lx
         kW5OtGteqNX67XKD/nR5/w/SBpvbXUMhT2t/gbl/ec7Vn8AMNgPoI8raLnJ2Y+hyTQum
         hh+Rn9TsXlfbv/7b/z2+r6hFQWszLhpI3YgozHnqUD2FR+5hsHazjSNrsMC3NEUj8ay0
         OeQQ==
X-Gm-Message-State: AAQBX9cUqImIfUwGr9TPwe5L4RCxLnmDtHuBjkbYvvpVznRNy/hzeq4S
        cnLg0a6CsVfZxYMi9HuYckJHrcRA3hKagx7xcU8=
X-Google-Smtp-Source: AKy350YqUMYxLWmNR1hIG4mQS/jRIh8BW3K6uwgHy85Qpb0J26ixIai43YiZUZ08K9cs4N01EWF4ww==
X-Received: by 2002:a62:1911:0:b0:625:1487:f06c with SMTP id 17-20020a621911000000b006251487f06cmr665754pfz.29.1680829292905;
        Thu, 06 Apr 2023 18:01:32 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id k3-20020aa78203000000b00625c96db7desm1895131pfi.198.2023.04.06.18.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 18:01:32 -0700 (PDT)
Date:   Fri, 7 Apr 2023 10:01:28 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 05/16] zram: return early on error in zram_bvec_rw
Message-ID: <20230407010128.GW12892@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/06 16:40), Christoph Hellwig wrote:
> 
> When the low-level access fails, don't clear the idle flag or clear
> the caches, and just return.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
