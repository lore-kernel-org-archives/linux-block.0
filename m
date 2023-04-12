Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71E7C77B71
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 12:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjDLMbU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 08:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjDLMbQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 08:31:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6389E7DB9
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 05:31:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-635a81be246so891792b3a.2
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 05:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681302669; x=1683894669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BemMrKsiVPWhr8KgAgF7wba8eC0bKPhdDgywL32/aPQ=;
        b=MQSoIK94eEv7ri0juw4qDUOsohp3s2KhBIjA4xCWvnipHaqI3D7PrBaQdehxKBDO2e
         NxpNAdcFXwzhvNTTF1QoH4pDvnFE7b6FRZ55WozVUGs3K2AAkjGtrhqwWuJQzu3/eTzM
         HKyzj0rPrPxoX6IvID5PuMbap39VOGiTGv62c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302669; x=1683894669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BemMrKsiVPWhr8KgAgF7wba8eC0bKPhdDgywL32/aPQ=;
        b=pN4AoPxR68JqyNkZx0PrFn+X7w5+QsKvImZcHt1xOA1CAxa4gASHd2TIcdtxbwVeuC
         s2HkjbSo9rubCkxqZv5JNvwU+w1dNcL8T3sHOUBrMJF2mtZ+9Bwi4BVuAFFLbbYt8K4w
         S3UQvOERQm/GOER5tzVadE9wVV8ptDLBWQ4zipgJNCeXFt89DqK8zk+3wEu6Ct+w9hoz
         9y6or02p3SgTA2OuZtz0hri1v+QT48BPixFdJFr1Q09IKjVboylKn92MMz2b1IJBnyfA
         F0JU676TASuMHpf9RqU7dkzV05V4tq81er1CU6rNdkhmHaHoFkK0lFeGzl8YuGwTphWp
         M2LQ==
X-Gm-Message-State: AAQBX9dJyLhJmvv32oSk/PadWz1k/9Tfz/gQ2R16j0NnklosBjR4fi8E
        m28MzFSKIZMay40XuXMYncuBeQ==
X-Google-Smtp-Source: AKy350bOyOtuVOJEtrrk2ja0trJm+5u/EBXSosOBCnA7UGyMLsrhRvxG57vP3JYy3QDDrJCZWOAusQ==
X-Received: by 2002:aa7:8f25:0:b0:638:7c22:6fd with SMTP id y5-20020aa78f25000000b006387c2206fdmr7591835pfr.1.1681302669604;
        Wed, 12 Apr 2023 05:31:09 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id c11-20020aa78c0b000000b0063afb08afeesm1884037pfd.67.2023.04.12.05.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:31:09 -0700 (PDT)
Date:   Wed, 12 Apr 2023 21:31:05 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 13/17] zram: refactor zram_bdev_write
Message-ID: <20230412123105.GH25053@google.com>
References: <20230411171459.567614-1-hch@lst.de>
 <20230411171459.567614-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411171459.567614-14-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/11 19:14), Christoph Hellwig wrote:
> Split the read/modify/write case into a separate helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
