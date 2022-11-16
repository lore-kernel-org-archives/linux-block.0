Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F93C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 20:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKPUHG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 15:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiKPUGk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 15:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B444E6587A
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 12:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668629139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JLUc8wFQUngPcn9VE0lYivlFFmu9hagcuFWZhYxzxAg=;
        b=HY3t08xybH+pa+0pLH5AucdDsOwcWTyJykrQ8A7O/ny05AX2YmCJInENV5njdVcoipjfhT
        bPMwEZsFtYxwrL40lFbM8Sf1C0mwvMqV7crQit2Q8lV8m2gzBGTyZqB6GRsa8aSrq18tdm
        8/+po041kwz/Nz2PU6NtgDHAxx/eWQ8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-336-VpCWQpbLNjO_EZcP_Dg_BA-1; Wed, 16 Nov 2022 15:05:37 -0500
X-MC-Unique: VpCWQpbLNjO_EZcP_Dg_BA-1
Received: by mail-qk1-f198.google.com with SMTP id bp10-20020a05620a458a00b006fa29f253dcso18554501qkb.11
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 12:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLUc8wFQUngPcn9VE0lYivlFFmu9hagcuFWZhYxzxAg=;
        b=N7lESI+O/IO08ZthOKO+naKuICFfY2VRH+dcMu+TNLmRmW6HZOTQ15+wLdqx+fuhBT
         JQs45MCfle5S25I6wal3SdZ5bt4K4+wzt5nYE+cpcir9AqrkX1AC/ZDMnZ09hxdq5vc9
         ygOnQEXBsIFu63uOo6dAsvfHLSYY5vD9UUIWlkzvTtx98pZcb2/uZwI0asBYTX0maO6H
         /fPHGcb6nXYhR5221HMZAWJ19WhA84pw53eiqxHb/ZRr0KUltyniMWsApIVoO1dyGHgd
         9COJY9zms7Kik8pl8ICUMApHD8n/QItVVFOMh8zoowh0AT0jm72G/dUM2WUGQwGZjS9p
         orMA==
X-Gm-Message-State: ANoB5pnexXro9jWJLEaBysJFobWalOzDFEI7j0nlGng6RgTWu+R+lzIO
        tlCJONsGu2g1hI6SCiH8qPt0pq+eAudN+dKhfG4Ezl3rD1/fzVrkMbq7lC9RSRiZW83b14ibHmp
        0Awdbw1V8IsFF9H4V1PzX3g==
X-Received: by 2002:a05:620a:c43:b0:6fa:6423:65b6 with SMTP id u3-20020a05620a0c4300b006fa642365b6mr13695672qki.324.1668629136794;
        Wed, 16 Nov 2022 12:05:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7QFuYuDYf+7fZ1eA/V2zF+3DqiMnkhOXs+SdKPfUYyDPJiEMnLz8vlNganM/gmYt11Dh8S9Q==
X-Received: by 2002:a05:620a:c43:b0:6fa:6423:65b6 with SMTP id u3-20020a05620a0c4300b006fa642365b6mr13695661qki.324.1668629136592;
        Wed, 16 Nov 2022 12:05:36 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id p70-20020a374249000000b006eef13ef4c8sm10488872qka.94.2022.11.16.12.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:05:36 -0800 (PST)
Date:   Wed, 16 Nov 2022 15:05:34 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        stefanha@redhat.com, ebiggers@kernel.org, me@demsh.org,
        mpatocka@redhat.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/5] dm-crypt: provide dma_alignment limit in io_hints
Message-ID: <Y3VCjoT2PtHWRvrO@redhat.com>
References: <20221110184501.2451620-1-kbusch@meta.com>
 <20221110184501.2451620-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110184501.2451620-3-kbusch@meta.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 10 2022 at  1:44P -0500,
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> This device mapper needs bio vectors to be sized and memory aligned to
> the logical block size. Set the minimum required queue limit
> accordingly.
> 
> Link: https://lore.kernel.org/linux-block/20221101001558.648ee024@xps.demsh.org/
> Fixes: b1a000d3b8ec5 ("block: relax direct io memory alignment")
> Reportred-by: Eric Biggers <ebiggers@kernel.org>
> Reported-by: Dmitrii Tcvetkov <me@demsh.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

