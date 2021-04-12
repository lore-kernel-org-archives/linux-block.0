Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA735C433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B103361289
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbhDLMAw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239950AbhDLMAw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 08:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618228833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fqhV33RkbsMbtO9g46LNef0TvFJ+Oo49emjwqgVWPXY=;
        b=fQtv9lnKyq/t27ZtOVHJAzKQP0wWAIytvQqlLb4cDbk+8mv8SQsEgOIQTpgiBS5oo6WWhu
        ktgJECZS/EO5WhDt/EZn2Y8z7AexwTxcYUmMhlZk7yaU0DT97rzaXkXwAUMlRZTE0O0kxQ
        /CfYVwJ3pBi7HNSidb1MdULeRg3at80=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-zCgtvGJiPamAsJwAR4j_5g-1; Mon, 12 Apr 2021 08:00:30 -0400
X-MC-Unique: zCgtvGJiPamAsJwAR4j_5g-1
Received: by mail-wm1-f71.google.com with SMTP id j187-20020a1c23c40000b0290127873d3384so1573574wmj.6
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 05:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fqhV33RkbsMbtO9g46LNef0TvFJ+Oo49emjwqgVWPXY=;
        b=H4Q29NSPkEl8Y3idvi2zDz/kxDox91l4F7EZ7JkMfQ71SdKHTvyXkhuoLf6kKWLOrE
         trLrSgBMJCo0jivUO4LiDdQmmraBWIeRlYwS9fcGapATTJlCONv/BA93SHR9jTcN9+dQ
         Oo2o58uk6kL9267GlaX0NlnklTXbZOmlbXkjsdqVWeMkIXdfawxSdv62zLrzhIb8Nw+0
         2Laq6d7Drq9I8455OZrpnPmtx026Sb7zTBCU/CbEXjG/sCuDVOIwQmZxuBN4siFtQIlA
         byJi/UfwXBlX5QBaED0BYC19zi4Bnh0o0NibyK915sOmhAjiBC0Eg2kgs6kuKz3wCOuC
         3whA==
X-Gm-Message-State: AOAM531Kym+4Cqw5raL25C/YkE6A8E3nPkEOA2eNcm99hSqMT95Y/fLX
        sTmkOYRb74ulieYDacsOp4k8+59Hi2E8v+fraUmlYIorTC3eNiDtYB76xsZK+J9iCg53wJfMYSY
        c4AKYP0NznLmgarI4UyMu0EA=
X-Received: by 2002:a1c:2985:: with SMTP id p127mr21710530wmp.165.1618228829093;
        Mon, 12 Apr 2021 05:00:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2SCE8sMznZG6rxO4GSbL4qQt0Uw6bMoyj3GCEYG1byM8BieOAw3WLYqRj7PoobgERMieckw==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr21710521wmp.165.1618228828984;
        Mon, 12 Apr 2021 05:00:28 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
        by smtp.gmail.com with ESMTPSA id j14sm16118383wrw.69.2021.04.12.05.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 05:00:28 -0700 (PDT)
Date:   Mon, 12 Apr 2021 08:00:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Enrico Granata <egranata@google.com>, jasowang@redhat.com,
        pbonzini@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: Add support for lifetime feature
Message-ID: <20210412074309-mutt-send-email-mst@kernel.org>
References: <20210330231602.1223216-1-egranata@google.com>
 <YHQQL1OTOdnuOYUW@stefanha-x1.localdomain>
 <20210412094217.GA981912@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412094217.GA981912@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 12, 2021 at 10:42:17AM +0100, Christoph Hellwig wrote:
> A note to the virtio committee:  eMMC is the worst of all the currently
> active storage standards by a large margin.  It defines very strange
> ad-hoc interfaces that expose very specific internals and often provides
> very poor abstractions.

Are we talking about the lifetime feature here?  UFS has it too right?
It's not too late to
change things if necessary... it would be great if you could provide
more of the feedback on this on the TC mailing list.

> It would be great it you could reach out to the
> wider storage community before taking bad ideas from the eMMC standard
> and putting it into virtio.

Noted.  It would be great if we had more representation from the storage
community ... meanwhile what would a good forum for this be?
linux-block@vger.kernel.org ?
Thanks,

-- 
MST

