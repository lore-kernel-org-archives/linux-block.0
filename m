Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32F8C433F5
	for <linux-block@archiver.kernel.org>; Wed,  4 May 2022 16:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350056AbiEDQY2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 May 2022 12:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353480AbiEDQYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 May 2022 12:24:06 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5B027CF1
        for <linux-block@vger.kernel.org>; Wed,  4 May 2022 09:20:29 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id js14so1166036qvb.12
        for <linux-block@vger.kernel.org>; Wed, 04 May 2022 09:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Iou29lBg+2PNWoTT5TrZBUrkl9ztVWkvnzEIPU3Wvg=;
        b=dGCA1Dlv3XnFdIFWFClrlvuP+O3r/wEe9fEJA3AV4tQI9M15dZc9cJmXAF+Guj1/B6
         OVLVnfA9HT/2ioWAqPwmyjSyqBo8H+7IPbp/8+PfGUHdR7NjDWMY8XKOF7LXFGMkW3FV
         Gpd2Lg/cZXvNyMGUbwHwMxaB1uQ0KA7KZVE7p3QnfWIOzrI6sDi2siT6qVn8AYcsd3Rc
         BO8KOqEsLPUDiFYUjdiILb4IP1pCjEPceXVEsc01QAIs6wEnY803csYFfUT9hVLqJ1Jj
         leLCKwrBQAXMuLT22HgJ1EcMY0tgtWa/NQnpk2kEd14cT5P0G8mRkeo39KYaONORhkya
         +9tQ==
X-Gm-Message-State: AOAM532/koKeN6eOfD3z1XrZx2WpJsg0CE52la4ZQVzNNu3Q53R7HYEB
        d181iBRryAOCmKOyonJ99mO5djhdVaqF
X-Google-Smtp-Source: ABdhPJwwpKnz48V7121YFND0SQzyFzM84V44Z7OJQ+GUZF7ek/mxU0zvoTy6JO4sHkmqWqKE2j8Jkg==
X-Received: by 2002:ad4:4d4e:0:b0:456:3c11:d458 with SMTP id m14-20020ad44d4e000000b004563c11d458mr18707646qvm.64.1651681229127;
        Wed, 04 May 2022 09:20:29 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id r17-20020a37a811000000b0069fc13ce24dsm7822217qke.126.2022.05.04.09.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 09:20:28 -0700 (PDT)
Date:   Wed, 4 May 2022 12:20:28 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: allow passing a NULL bdev to
 bio_alloc_clone/bio_init_clone
Message-ID: <YnKnzBbGJYbyGA25@redhat.com>
References: <20220504142950.567582-1-hch@lst.de>
 <20220504142950.567582-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504142950.567582-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 04 2022 at 10:29P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Device mapper wants to allocate a bio before knowing the device it
> gets send to, so add explicit support for that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

Thanks
