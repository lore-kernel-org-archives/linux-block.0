Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A80CD3425
	for <linux-block@archiver.kernel.org>; Tue, 19 Sep 2023 00:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjISAdu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Sep 2023 20:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjISAdt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2023 20:33:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE43210B
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2023 17:33:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c46b30a1ceso18671785ad.3
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2023 17:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695083623; x=1695688423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIipbq6pl98CX5ShkSgKKbrlft0dGUdbFCyrQXg1CJw=;
        b=hIqBx8HoJuGsEA1Idofdj0WQLkGd+YCtugdzva+vU2O1dB5PyZ/crQ8lIcGemvUsQM
         4LBogAUTI+H6FBtDGhB7qfAoZtLXykpW/IMFQCx2q6MLZUBb3gfAUPPz6xWRp4y578KM
         RlujY7/LgIOJTbkC3HayXxqzKoVZizYobzQ4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695083623; x=1695688423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIipbq6pl98CX5ShkSgKKbrlft0dGUdbFCyrQXg1CJw=;
        b=R3mLFlHrD2PDsXlY8lu0rbN67rsBrndyd6j9sqOVQEjzPZqpWRbBxLrN1AVUuMl5wQ
         kPy6DZsvOCj5ZLbnTlNMeu5SUY5yPEEi2refkITVd1eoJbKsOoCEPdyPuR3rpMi3u3zn
         2Eb8xi67ckB7ofJneNwymB70T25IZpJt+Mt4Yjsy5Add0IArBPWA3xW0LLeQU+iaOusY
         gijgDf89q6X6UcWraQ8LOoaK5okc6Wtjip6QsSXL0cSU/6j6GxRijk2sKgfHM5hugjYw
         vKDzKTWqLclpTWS6Q16zPM2rIuCDc8vGV3njqUMQCm6KBZgSVPmbmuMfZ1lXcShny9R2
         igHQ==
X-Gm-Message-State: AOJu0YyXI2oq5Kprl+t6gudkOJUhQWhTIudW5WmlBcUvktHToo9tKimZ
        nWD8o0KGO9bBgU3oWaGrven7Kg==
X-Google-Smtp-Source: AGHT+IFUOb3498I9aJCAsXro45JHahBab0QuFwxDZdPRg1LyNnetymxXcQ/rnmVX0lcPtFN+MR2c3w==
X-Received: by 2002:a17:902:d488:b0:1c3:d9ed:a410 with SMTP id c8-20020a170902d48800b001c3d9eda410mr13470497plg.59.1695083623396;
        Mon, 18 Sep 2023 17:33:43 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f54c00b001b8052d58a0sm8814374plf.305.2023.09.18.17.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 17:33:42 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:33:38 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <kernel@pankajraghav.com>
Subject: Re: [PATCH 0/5] Improve zram writeback performance
Message-ID: <20230919003338.GA3748@google.com>
References: <CGME20230911133442eucas1p2f773a475e0a6dc1a448c63884d58c8d3@eucas1p2.samsung.com>
 <20230911133430.1824564-1-kernel@pankajraghav.com>
 <ef88e8e4-c94d-9ad3-a130-8cd6b3f722c9@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef88e8e4-c94d-9ad3-a130-8cd6b3f722c9@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/09/18 15:53), Pankaj Raghav wrote:
> Gentle ping Minchan and Sergey.

Hello,

zram writeback is currently under (heavy) rework, the series hasn't
been published yet, but it's in the making for some time already.
The biggest change is that zram will support compressed writeback,
that is writeback of compressed objects, as opposed to current design
when zram de-compresses pages before writeback.

Minchan will have more details, but I guess we'll need to wait for
that series to land.
