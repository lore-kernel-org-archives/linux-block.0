Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AD3C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 16:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbiA0Qw4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 11:52:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234331AbiA0Qw4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 11:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643302375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGOKQqcuQhkDwTPU+rhG3/lUwVIbdjyWIj81munfXW0=;
        b=VmRpdIyd0xvMY5AG/PvMJ/LgB5XpiN9VoyU1eK07v8Qcv2mLjq3PAYKzlXy6rbI9lRes52
        pb5Kv/kv8KZycePenDYmxBNn6NWaDK7E9Rjb1TA2izv/3Nw3mRD+8B/GFzCzGMmToFhhNC
        rab+AKj8XSjkSmDJEFmSWfZkGTRLP5M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-xW7JUHUMNIGcQq2PtTfKMg-1; Thu, 27 Jan 2022 11:52:53 -0500
X-MC-Unique: xW7JUHUMNIGcQq2PtTfKMg-1
Received: by mail-qk1-f197.google.com with SMTP id g3-20020a05620a108300b0047e16fc0d6cso2813111qkk.3
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 08:52:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AGOKQqcuQhkDwTPU+rhG3/lUwVIbdjyWIj81munfXW0=;
        b=TMgZbhpvKaIbJpHk3uV5P1QYDkhf8Pekm5qo8En5qbhxNsXj6fH4f4ctbX+PXVLWmM
         /OSMcjDojzrbFnHt9EUT9pBfjgMEAz5nyXkfkR7UvAHEP+6hS1hwoj87LG1eYKjw3hzZ
         x+SdRqi/7Xnd2LK1J5wDeQ7m4Mq0AehABTOht/bd7rImRcUwceNlpIRPZWoeJQWZBFmT
         6auZiJbLNKLx8Wy5Z4XkU+bz89Gut20hcBp3UPDsgC9Hdz6dmHrFMBwkNMQUL4hdhLXv
         FLT/sK6ERcmETZlXEemWaqb4B7g6P/NFiv0ijl21ENl8/r8bH9ASLg7DR4Cnf4SgkYx7
         Fp9g==
X-Gm-Message-State: AOAM5334WUAMc8Y7bjmf4H6VrjnJWNN6pq/VFoln2mHTs/2LiAqINo/2
        5hUtdi41kqelWTLl1V14cJ1KaC8vKbBOe+2y+RGSvTIraEWrbYoDtA15ooVu7qXOFadJNjLV1kz
        HqTyk3Be/Ybjgi0GAAUD2qA==
X-Received: by 2002:a0c:fa09:: with SMTP id q9mr4322350qvn.21.1643302373426;
        Thu, 27 Jan 2022 08:52:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2rtqqWw8vSSkq/pAGCHoYHXJ1BiURlAQlul/eODmSBNf8OGMbqxmxG8mMS7PpEMI9YH9jUw==
X-Received: by 2002:a0c:fa09:: with SMTP id q9mr4322338qvn.21.1643302373224;
        Thu, 27 Jan 2022 08:52:53 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id y15sm826432qtx.28.2022.01.27.08.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 08:52:52 -0800 (PST)
Date:   Thu, 27 Jan 2022 11:52:51 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: Re: improve the bio cloning interface
Message-ID: <YfLN4/2bYe4hebCy@redhat.com>
References: <20220127063546.1314111-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127063546.1314111-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27 2022 at  1:35P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Hi Jens,
> 
> this series changes the bio cloning interface to match the rest changes
> to the bio allocation interface and passes the block_device and operation
> to the cloning helpers.  In addition it renames the cloning helpers to
> be more descriptive.
> 
> To get there it requires a bit of refactoring in the device mapper code.

I'd like to take a closer look, do you happen to have this series
available in a git branch?

The changes generally look fine.  Any chance you could forecast what
you're planning for follow-on changes?

Or is it best to just wait for you to produce those follow-on changes?

Thanks,
Mike

