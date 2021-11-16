Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57D5C433F5
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 04:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9010061C14
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 04:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245555AbhKPEu4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Nov 2021 23:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245455AbhKPEuz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Nov 2021 23:50:55 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A7CC27F605
        for <linux-block@vger.kernel.org>; Mon, 15 Nov 2021 17:53:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p18so15962174plf.13
        for <linux-block@vger.kernel.org>; Mon, 15 Nov 2021 17:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FsEmy0v0kVwuM07VUF+cj/gSq+MVZGtjYE9T3VyRKCw=;
        b=HFUdX/lScnUZWDIgXPHc2kQYYvxFBdacGV0HXDsU8LuwmcPfaodTzMQ2laZTF+Dhpt
         SJl+oz4G8o00QIJwu/+yPLQMA0dvqjn0/cc87tlRAub7IrXSTRDFBc8kGmR8DyB8gjt6
         Hb87QOZQDMNmuIjH4y4JdnzVVbxVV0b89A965jJGPchQX09hL/2VEFhE7na/hpm14Z4W
         QVEDMIGfvTOAl2UbnKPHB9lduqkJHvchE9BX41SrMNjb+LEE0dDTeZsAGRA2LlFSMDVg
         hV+QpCbFVMb2jASNrULVeWkX1GFfx60dbgZXD786NE9BuLhQETVCy2aueQi3wpdi7O2h
         1n+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FsEmy0v0kVwuM07VUF+cj/gSq+MVZGtjYE9T3VyRKCw=;
        b=oSn7U8Z+pRrOu8tlPl9nfZRmccVJDgr5KmtNyKVT8SxDlvOmFT74xnNB2kz6QyxGFa
         Lb0I8VFFs/ZaOFPLg+RUwzTcvk0NaXxEFUuh7ZiXNI9S2rJTJ/Dt9D9vkVxfY8GxZ7Xg
         63PLtUujT2WihWJ77xEF7+aA9eJPQ7YzX42qR+6DRliIKsU6RWR9tskjqN7HvlF9UlwN
         roP+0t+gUam8RdwcRKZvK5FoeSBUyqYFZRWqX6PQNlsb6AZ8YN2l3ARfVZiZFo9N1UlX
         z8zAsi3NqzbZVrOQTlF6tE3mgl104DoQ56fEoWtVyitDs9A071yFja29y881zasmY3E+
         Fv3w==
X-Gm-Message-State: AOAM532PQ1GJCOAMoQjU2/QSCEEhc49+homUuAGrwt+7/YXMAXppLGFJ
        SpMJlrzpbe/Xa31LiZflEqpb+g==
X-Google-Smtp-Source: ABdhPJzbop2oU0y66CYb9haa2Zz8Lgk8Qma3xsMmsGa7F9jSepZI/nTw7l9ZBEbthCbVBVhCB0yoZA==
X-Received: by 2002:a17:903:1109:b0:143:85f3:af29 with SMTP id n9-20020a170903110900b0014385f3af29mr40846104plh.47.1637027621331;
        Mon, 15 Nov 2021 17:53:41 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:cf90])
        by smtp.gmail.com with ESMTPSA id k18sm12707586pgb.70.2021.11.15.17.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 17:53:41 -0800 (PST)
Date:   Mon, 15 Nov 2021 17:53:39 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] tests/block: add the missing _have_fio check
 for block/029 block/031
Message-ID: <YZMPIwBGDUALqgDi@relinquished.localdomain>
References: <20211027055654.3591-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027055654.3591-1-yi.zhang@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 27, 2021 at 01:56:54PM +0800, Yi Zhang wrote:
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/block/029 | 2 +-
>  tests/block/031 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks, applied.
