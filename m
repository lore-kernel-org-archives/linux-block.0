Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21444C433DB
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 08:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69DE235F9
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 08:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbhAVIhJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 03:37:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726988AbhAVIgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 03:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611304496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QhDv0nxBGDatOm8oAEr+e4jVMJT3FNAwSVks1BSxV64=;
        b=LaoXIevbVoDxsgzAKjflG1xe2sGi/oUBeOkjnvShVK8iBNukKwnATAYE7dU/P2H+uAoBuY
        iF0iRWjw5ezXrb2cE+z4Y7GN0UOnMW2HC/jfC/e6L2+z6M/fACYYyvMKmnLOC/nkZIJXGb
        ezfE/gVYJp3sSBXo84bYCV6mHypV3+0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-qJe8z8CdMtO6GD6C9sWm9w-1; Fri, 22 Jan 2021 03:34:54 -0500
X-MC-Unique: qJe8z8CdMtO6GD6C9sWm9w-1
Received: by mail-wr1-f70.google.com with SMTP id x12so2665761wrw.21
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 00:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QhDv0nxBGDatOm8oAEr+e4jVMJT3FNAwSVks1BSxV64=;
        b=p2rKlNTTmCe6CGLF8sof0YOLt+7d2IHVVUPni3m3BdaPxJqmvELlYh4NTJFfWvzM1L
         BJzpt0tCcsMuxDgGzR/7BRTIYL30cFRYR/TznayJPAkU44+LV4XWM03ZI0Vc1bcQY48m
         eYHs9dneBH6zzLCiGaXohazJRr2GbxjkSsoEKeM3GtPAkFTlDMNsNZuRTsCGN/Lmod08
         gA0B26flgoUx9yaDMwPU/saKGa6mMH9qLbRc/uQT/wZOTEnjjUGLw1cesYSLNtzigo0V
         yVTj7yAsIfLnaE3wdzAtaviB9P2ubAz38OS9/JlzXRYRrSLAGMXcHP2gYa0SDsXOPZap
         LVsg==
X-Gm-Message-State: AOAM5337hiQ2MVI5D1tgGM6wmbgDm6TwyNSH0YcoK6EUHhQJ3UTDY4W2
        YPgxRqvY1LEMTJ8qpnpqwD8iRUAG5thXgMK0o9yVMG/28npLIzkfVkWL8JBSrPtYuOVsp29uPiT
        7cQICVDwGKDnouStBbyjqzuM=
X-Received: by 2002:a7b:c20b:: with SMTP id x11mr2732057wmi.107.1611304493731;
        Fri, 22 Jan 2021 00:34:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdudmKkbtLpbzfTDbDMVvXKnLxQMKgl/CJb+L2NpJNINqIzeqlIGOBx/OM8WOS7lMr7QiepA==
X-Received: by 2002:a7b:c20b:: with SMTP id x11mr2732046wmi.107.1611304493570;
        Fri, 22 Jan 2021 00:34:53 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
        by smtp.gmail.com with ESMTPSA id d85sm32712120wmd.2.2021.01.22.00.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 00:34:52 -0800 (PST)
Date:   Fri, 22 Jan 2021 03:34:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
Message-ID: <20210122033412-mutt-send-email-mst@kernel.org>
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
 <405493e0-7917-2ee9-7242-5f02c044a0fb@redhat.com>
 <ce313c74-645f-3a55-44ac-4e757497c778@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce313c74-645f-3a55-44ac-4e757497c778@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 22, 2021 at 09:43:27AM +0800, Joseph Qi wrote:
> Hi Michael,
> 
> Any comments on this patch?
> 
> Thanks,
> Joseph

Suggest copying all reviewers, including Paolo Bonzini
<pbonzini@redhat.com> and Stefan Hajnoczi <stefanha@redhat.com>.

