Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F58EC636CC
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 00:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBQAOl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 19:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBQAOk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 19:14:40 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D113234FA
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 16:13:54 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id f10so4036537qtv.1
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 16:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kImKyTnUFlrsbZ3cxw052u3lsceBXaXeoQEmfLR09Q=;
        b=cjo2AHCbwPMfZ0b+ufm2xue4qk2YfNIrAkDkfg7soI3RmFZT/+FkzoKxLHgs0TS9Q8
         jTE4qi8sDNhljRvW27V0PPfnxhJvZR2OHK49mHO3W7HkOswhEBujot7/TNCAENRKYKix
         MLAsE04T+T57e9hb17YBrrqPleExNB/LRjY5cYXIHL8G2uvMb6v+j3tPiO03g4b/v5ud
         viSRmm5WU4cqE4pTd3AMF+u/OZMQjoZDLQz3sK452V1kcCzzenuRF2tH2xI+thUdTo4Z
         b4/Gj6LsBC4QEZOuVhGl5Oq90v1kF393PriAQJiR4zmZwoFlIcqtUAnImOT/ukuGy77h
         FM3w==
X-Gm-Message-State: AO0yUKU7kk/i1fyXMcJOMYVoywx2AMbZgSvsN6Jm4SnOqFFr/0qA3K3I
        aEQyCmMBgYYIHhKjtuGyxj61
X-Google-Smtp-Source: AK7set8j9cfHfcZl/vzGU/yVM8ih72maPo/h2Vl1C+ebpdpF9rGGVgryO/199T+35W3ZyOZr6LNmWA==
X-Received: by 2002:ac8:5f4a:0:b0:3b9:bc8c:c1f8 with SMTP id y10-20020ac85f4a000000b003b9bc8cc1f8mr8029510qta.3.1676592833020;
        Thu, 16 Feb 2023 16:13:53 -0800 (PST)
Received: from localhost ([87.249.138.162])
        by smtp.gmail.com with ESMTPSA id 18-20020a370312000000b0071b1fe18746sm2260140qkd.63.2023.02.16.16.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 16:13:52 -0800 (PST)
Date:   Thu, 16 Feb 2023 19:13:51 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Uday Shankar <ushankar@purestorage.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>
Subject: Re: blk-mq: enforce op-specific segment limits in
 blk_insert_cloned_request
Message-ID: <Y+7Gv84lxIR0OsWc@redhat.com>
References: <20230215201507.494152-1-ushankar@purestorage.com>
 <Y+3IoOd02iFGNLnC@infradead.org>
 <20230216192702.GA801590@dev-ushankar.dev.purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216192702.GA801590@dev-ushankar.dev.purestorage.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 16 2023 at  2:27P -0500,
Uday Shankar <ushankar@purestorage.com> wrote:

> On Wed, Feb 15, 2023 at 10:09:36PM -0800, Christoph Hellwig wrote:
> > I'd just remove the debug check entirely
> 
> Older kernels have these checks in a separate function called
> blk_cloned_rq_check_limits, which carries the following comment:
> 
> /**
>  * blk_cloned_rq_check_limits - Helper function to check a cloned request
>  *                              for the new queue limits
>  * @q:  the queue
>  * @rq: the request being checked
>  *
>  * Description:
>  *    @rq may have been made based on weaker limitations of upper-level queues
>  *    in request stacking drivers, and it may violate the limitation of @q.
>  *    Since the block layer and the underlying device driver trust @rq
>  *    after it is inserted to @q, it should be checked against @q before
>  *    the insertion using this generic function.
>  *
>  *    Request stacking drivers like request-based dm may change the queue
>  *    limits when retrying requests on other queues. Those requests need
>  *    to be checked against the new queue limits again during dispatch.
>  */.
> 
> Is this concern no longer relevant?

Still relevant.
