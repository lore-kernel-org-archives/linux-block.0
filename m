Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0484C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 17:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbiA0RJk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:09:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238767AbiA0RJj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 12:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643303379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dhUoO5mtU5C6v7W8MZ+6HMQJZitoVQcF/qB+IF1Jr0=;
        b=Gy8LmpFXxAOAGU7wRpJYDntrcuVCM/U9IaryiMmxjzahqE+OOGqUfNitsw1fmHcJ6nz+w4
        cki2C0YmkAod280gOQQRXPn2SMs0uiYX+AZTdh58R7eU9uHOdlYpRG2yid3l6SN89qdQDQ
        W3IziguawlapZVvthny9kdx9gifJfKk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-WhtWu3wFNyub2MUMwGu_NA-1; Thu, 27 Jan 2022 12:09:37 -0500
X-MC-Unique: WhtWu3wFNyub2MUMwGu_NA-1
Received: by mail-qk1-f199.google.com with SMTP id o3-20020a375a03000000b0047bc1e51002so2805759qkb.19
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 09:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+dhUoO5mtU5C6v7W8MZ+6HMQJZitoVQcF/qB+IF1Jr0=;
        b=RXnPvi6BHLLtuUSm/e65sSOT+LPzNBZrznJVJMwLDL3KhStewbotYK1ytyCcyvXyCG
         gXJPeMxFfz0l8AyjMg0qAKRDC5a8zKw5nbHvis08KCWyNiv1+tfuktOK2g9HhlgqiJ4K
         /BLZ9i5Liov65/ZSF/eJi2Lh4H0NJ+to7LAqOwMIzOX2AseRQP4LJ9PeA1HjCURG1onb
         ZzKhGNgufNrbFvnpt60Pvw5ERr5xhqFIEuNcOOlycFh6vTS6lN5teoOpxOmzwwzjLyki
         lSrRpETjGppEhuDyzn4W3Sqtdgg9TLLAk6/y/7aF+FcvN+xJ3PpFpoLvI5NFbPcaMmcF
         bbag==
X-Gm-Message-State: AOAM531/M7dtAvVTxc9AfwGP0Xk3uGCevdea0gD+QwPy/XtdBr7CaRrA
        qF97+1pWlMw7s+db8pQrFAA+sv9w1964mYLPL952zOM3eWl8rPujhUCOEE4Bt+y5KbFcthfWnGD
        wc8dZ9sdlC6dM29ousfxsUQ==
X-Received: by 2002:a05:620a:1671:: with SMTP id d17mr3422685qko.683.1643303377469;
        Thu, 27 Jan 2022 09:09:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyie4bqi26jfgNY8Cjw+Pn5xYBOKV6NvnkIoBYF0/ZaizWWrCUD9ZTrfOlIA4zvFGF0i2/RFw==
X-Received: by 2002:a05:620a:1671:: with SMTP id d17mr3422658qko.683.1643303377286;
        Thu, 27 Jan 2022 09:09:37 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id i8sm1628636qti.52.2022.01.27.09.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:09:36 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:09:36 -0500
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
Subject: Re: [PATCH 06/19] dm-crypt: remove clone_init
Message-ID: <YfLR0DPcDOYO65Hp@redhat.com>
References: <20220124091107.642561-1-hch@lst.de>
 <20220124091107.642561-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124091107.642561-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 24 2022 at  4:10P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Just open code it next to the bio allocations, which saves a few lines
> of code, prepares for future changes and allows to remove the duplicate
> bi_opf assignment for the bio_clone_fast case in kcryptd_io_read.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

