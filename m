Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F29AC77B73
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 19:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjEATQq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 15:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjEATQp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 15:16:45 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033941FC0
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 12:15:54 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-61946c27e58so10160246d6.0
        for <linux-block@vger.kernel.org>; Mon, 01 May 2023 12:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682968553; x=1685560553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xta1ORIjLKUC6sudz2oVdR8ZSjIECo/NNbn+t5B7/30=;
        b=SYYP8Qrjg5o/IlX+am5XOu2gSkNG5yp9Qi4WB5xt9YAIqMZJodwzCpBbIKXIhyaSsm
         ZyR3DRB3eQLgDpcAGZacn8W6AF3tNgNw6WDOBinlaHj4a0A8/zFkYfyNNKHnmKzvUbFK
         tQ5i+9fGTuHQImunmK8KL8UMLsRj6IWIxlcYPJQHTbsGiBd/vM8xUeLngY/yzoL1uqw3
         Im39hj1f7DDl1A/L5PzFF77/f/tG0GJQWBovpGYkhhSvE9HxSihty+StPF8F3BoKqcXk
         S8SK781rOi2gPkyD4J0R1nx4OcbPM0Hgry/P8NzmGyF8GFtTDcf1jrAdCdxYoSPXNjfw
         eV4Q==
X-Gm-Message-State: AC+VfDzDHVXoE4cN40cXMeZ51tIVf5RsYnHcRs1O7efxZoNp7GnlMsY+
        H/dbDjN80UebgNV+3S8VH64tlkzfPmvcH5wD3g==
X-Google-Smtp-Source: ACHHUZ4jmmEuczYIXEM5IlwBG9kl9JWTkff4UV1CX3KDAprVLLnMz+RC3V5MfXehBawcFMx/T2jIDA==
X-Received: by 2002:a05:6214:27e1:b0:5e3:d150:3168 with SMTP id jt1-20020a05621427e100b005e3d1503168mr1170309qvb.18.1682968553151;
        Mon, 01 May 2023 12:15:53 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id o14-20020a0ccb0e000000b0061b62c1534fsm69023qvk.23.2023.05.01.12.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:15:52 -0700 (PDT)
Date:   Mon, 1 May 2023 15:15:51 -0400
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
        Daniil Lunev <dlunev@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>, ejt@redhat.com
Subject: Re: [PATCH v5 4/5] dm-thin: Add REQ_OP_PROVISION support
Message-ID: <ZFAP5yQ0mwE4F6Vg@redhat.com>
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230420004850.297045-5-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420004850.297045-5-sarthakkukreti@chromium.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 19 2023 at  8:48P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> dm-thinpool uses the provision request to provision
> blocks for a dm-thin device. dm-thinpool currently does not
> pass through REQ_OP_PROVISION to underlying devices.
> 
> For shared blocks, provision requests will break sharing and copy the
> contents of the entire block. Additionally, if 'skip_block_zeroing'
> is not set, dm-thin will opt to zero out the entire range as a part
> of provisioning.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  drivers/md/dm-thin.c | 73 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 68 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index 2b13c949bd72..58d633f5c928 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c
> @@ -1891,7 +1893,8 @@ static void process_shared_bio(struct thin_c *tc, struct bio *bio,
>  
>  	if (bio_data_dir(bio) == WRITE && bio->bi_iter.bi_size) {
>  		break_sharing(tc, bio, block, &key, lookup_result, data_cell);
> -		cell_defer_no_holder(tc, virt_cell);
> +		if (bio_op(bio) != REQ_OP_PROVISION)
> +			cell_defer_no_holder(tc, virt_cell);

Can you please explain why cell_defer_no_holder() is skipped for REQ_OP_PROVISION here?

Thanks,
Mike
