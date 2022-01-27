Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79CAC433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 17:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbiA0RJC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244300AbiA0RJB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 12:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643303340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kAV23rTMcuty4CJFZ8o8ysOxnvRFj2DI1yB1mT746og=;
        b=QU+UARpVft1TH4Ycj9CFqX254OOzM8EVrl3ZtSl6Dm32JTefsVBZbhy/HPfFFespA+mbTR
        N92inGTPutQzpsDrmtG8FbGj739lvdaM7u5zo/Los13xUSThaZNJ09o4q0S2CfBUaczQ+J
        pX2caUc1wui+XiRXE/spsU6KvZ7L4xc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-CbDB6yO9PU2vvLVl45ry5A-1; Thu, 27 Jan 2022 12:08:59 -0500
X-MC-Unique: CbDB6yO9PU2vvLVl45ry5A-1
Received: by mail-qk1-f198.google.com with SMTP id b204-20020a3767d5000000b004b2a0d2e930so1849327qkc.15
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 09:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kAV23rTMcuty4CJFZ8o8ysOxnvRFj2DI1yB1mT746og=;
        b=LFT/Lo+H1hybvSeWMIvU6LI17dl35XV4RblBJraPKlEHGlTTtmZ3L7hUL/bZrKr9M3
         T3grJJgzJJMA8FPXP9ImihdrEE/aHSJ+tRyd7O7RmVXp61QS10QIgLAzBAhw9TICDC7a
         b72rt9IKva+IPw3ZycjB6bxpKAkF0J+Vc+uyoxaCfUZxBSnroaEQWcevFkUUVaqu3Gmr
         qj+kMOhG18nAUFO+rCxE96YNMitqU7APzHLwFYcatiaim4TTr89XpbKZ7uOiSZQUIKdl
         po6RQPGmGkg0dEOMmLg110puQCZd62PUW3YPRVCSBoVWm3+4Rp2sz4+vB/SLp0sZ9HLI
         yIIg==
X-Gm-Message-State: AOAM533xk0GcBYq6istPCXIdRi9M2fMG524QXmw4t1quenDwY2zeGdHH
        uh2+vPZF6SWHZkmxrGpnf05I1+53o+6a5H4vhNWPzfQj6YK+ZSG3aVFnHj16O0osEXBXxq/Zj9e
        /bCbbVCTckLwEQKIciqyHbA==
X-Received: by 2002:ac8:44c9:: with SMTP id b9mr3555361qto.524.1643303338771;
        Thu, 27 Jan 2022 09:08:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDu0k2yM0Z7B8jNmnNXJFkDazruS7TZzFMNaHKbWmY0JBs9tIC0IfQuLij5Gmty6LtXXG+Yw==
X-Received: by 2002:ac8:44c9:: with SMTP id b9mr3555294qto.524.1643303338263;
        Thu, 27 Jan 2022 09:08:58 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id a141sm1694826qkc.73.2022.01.27.09.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:08:57 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:08:56 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: Re: [PATCH 05/19] dm: bio_alloc can't fail if it is allowed to sleep
Message-ID: <YfLRqCMAhLH8xhDD@redhat.com>
References: <20220124091107.642561-1-hch@lst.de>
 <20220124091107.642561-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124091107.642561-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 24 2022 at  4:10P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Remove handling of NULL returns from sleeping bio_alloc calls given that
> those can't fail.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

