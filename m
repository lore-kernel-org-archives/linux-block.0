Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAAFC7EE23
	for <linux-block@archiver.kernel.org>; Tue,  9 May 2023 16:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjEIQyC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 May 2023 12:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjEIQx6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 May 2023 12:53:58 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B940059E3
        for <linux-block@vger.kernel.org>; Tue,  9 May 2023 09:52:55 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-3f39600f9b8so7321231cf.3
        for <linux-block@vger.kernel.org>; Tue, 09 May 2023 09:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651175; x=1686243175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGP12yp4f/zdeMyz6FmQhXwVLGe13YEnm2DiLQWOfHc=;
        b=fQjZ+LXK0PEucMeHBFmEOAPQDnWZnJo5vX8d1Tn87t87WNTSUDQReK4Foo5avkLV/5
         Xa25uKGfGNc6BUD/ki4haDLkzQVDK7pqF/9RBGurGFMmFQ1cNETc1cr/rrgW+HDVT8rL
         1a4sUPpkSHOlW4pjVp3T2qxA2uyYj0jG2qvT9Avl1LXVB/cmNHAUygyrv99XnSmRWWHe
         YYllVaMnzDTkWwHT0UpSxAVqCJQ9M5ayMpO+UfkmLyhdq3jy7BIkIocuzK8EOkLzmbfM
         cPNR0g0RByc2Z0syHNvvN8sTVRyx/9EnkxQsrg64Ibk+t2CO2qskciSEiduKBASrs6S6
         +sVg==
X-Gm-Message-State: AC+VfDw1+DAfiRzSf9b7XmnwTNTMeDP221X5pPkk5wTomE30vtSm9gnt
        70zhpHoJlkq0xtQe1a/GSTX8
X-Google-Smtp-Source: ACHHUZ60YxoIH2gyoAjnbydVA2DQU48zJWQIwW/0Dh9DydhZKu2onIPJxWL7YRFQz348oUBbEBXSUQ==
X-Received: by 2002:a05:622a:148a:b0:3f2:a8db:3d57 with SMTP id t10-20020a05622a148a00b003f2a8db3d57mr23188660qtx.3.1683651174740;
        Tue, 09 May 2023 09:52:54 -0700 (PDT)
Received: from localhost ([217.138.208.150])
        by smtp.gmail.com with ESMTPSA id o4-20020ac80244000000b003f38f55e71asm632547qtg.47.2023.05.09.09.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:52:54 -0700 (PDT)
Date:   Tue, 9 May 2023 12:52:53 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v6 3/5] dm: Add block provisioning support
Message-ID: <ZFp6ZSwzqk2CIKwu@redhat.com>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-4-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506062909.74601-4-sarthakkukreti@chromium.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 06 2023 at  2:29P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> Add block provisioning support for device-mapper targets.
> dm-crypt, dm-snap and dm-linear will, by default, passthrough
> REQ_OP_PROVISION requests to the underlying device, if
> supported.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
