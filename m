Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCA3C4332F
	for <linux-block@archiver.kernel.org>; Mon, 12 Dec 2022 14:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiLLOVq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiLLOVp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Dec 2022 09:21:45 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E943886
        for <linux-block@vger.kernel.org>; Mon, 12 Dec 2022 06:21:44 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g10so12213209plo.11
        for <linux-block@vger.kernel.org>; Mon, 12 Dec 2022 06:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9XdE4u8wb4SGysfqm2k4eAsH/hYE/rL6WOXQqKBcfCQ=;
        b=nr/TmBJudujF3LzjEPT/iI1bG5mry7lvgQr4qFXTqsymwqvIaQD1ustZ3P/gJQfnoZ
         lkGbOu5RabaD+hj6Divl536kKQx0fsd6RKjJYQ8LDHXRuW53h26lQRpgSHWP0pJBR4TV
         PmX04YQo/R5tjtzI4Fv+EUn5Q8Te4rNxpZAO6K/YnYQE5V64a41e4R+OYO1ZrNhxZWhg
         7s51ilRa+1LiSkJPEskgMg9Y5ODpDlzv+YRX67klUeNoXEzBhhLYgBgFcBY+333ayTa+
         W+GIezBwCDuWDozMMyuPwrea9wWwgn36WuufydHYYv3EtQcZelvuEpHZET0ANNePPZHb
         UkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XdE4u8wb4SGysfqm2k4eAsH/hYE/rL6WOXQqKBcfCQ=;
        b=Y7PofW1NNgmk5wYAlrJpxfGpEdO9N+wm5ioisQcDAXEA3WKROmu+vA/H9cdKBFU/C1
         +cTx9Hh1MRGiSq8XRZJ1CrkdoMJv8W0G+oSTEDVmDMNLMQwc2RA13bAE2mIK3N7K6lfo
         r3/xDWCECoq+XeNjeT4y6bWBGkPLTE3Fuz9pebc1zQGCKpVm0B2YTuVjFa22VbWGhV7H
         Y0k3hAfEuvieebQay+1g91XJHeZYmKpKb8IcjJYiw93wZDM9P+VX47mQyIGcqjVxvF/u
         q4XqLaeF+NBdKbOvM1cTjb04S48/nlaoTfwqUXtmhjq/M2UvWblxO03uKmTjJ/oANNJc
         BkZQ==
X-Gm-Message-State: ANoB5pl5vNKHdHUk9aD5k7WzfnK8lL6HSzTqDfuQtHlFk3hqlageIcLM
        h1R6fKssehz0JpMHP9gWGHc=
X-Google-Smtp-Source: AA0mqf4EDWLTKEbOQpGXbaof/cBi/H+iEeCBhyeImreuuLDU0FVDM5DVhH6MXI79mBPAGwjki99ZKw==
X-Received: by 2002:a17:902:e811:b0:189:d8fb:152d with SMTP id u17-20020a170902e81100b00189d8fb152dmr23146353plg.25.1670854904218;
        Mon, 12 Dec 2022 06:21:44 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id je19-20020a170903265300b00186b3c3e2dasm6419558plb.155.2022.12.12.06.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 06:21:43 -0800 (PST)
Date:   Mon, 12 Dec 2022 23:21:32 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stefan Hajnoczi <stefanha@redhat.com>, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio-blk: set req->state to MQ_RQ_COMPLETE after
 polling I/O is finished
Message-ID: <Y5c47EqWknNKefRl@localhost.localdomain>
References: <20221206141125.93055-1-suwan.kim027@gmail.com>
 <Y5EJ+6qtsy8Twe/q@fedora>
 <4701aded-0464-791e-8b8c-a34c422e8e62@kernel.dk>
 <Y5bPG9QGMd/cDTQG@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5bPG9QGMd/cDTQG@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 11, 2022 at 10:50:03PM -0800, Christoph Hellwig wrote:
> On Thu, Dec 08, 2022 at 09:48:23AM -0700, Jens Axboe wrote:
> > > The doc comment for blk_mq_set_request_complete() mentions this being
> > > used in ->queue_rq(), but that's not the case here. Does the doc comment
> > > need to be updated if we're using the function in a different way?
> > 
> > Looks like it's a bit outdated...
> 
> I think the comment is still entirely correct.
> 
> > 
> > > I'm not familiar enough with the Linux block APIs, but this feels weird
> > > to me. Shouldn't blk_mq_end_request_batch(iob) take care of this for us?
> > > Why does it set the state to IDLE instead of COMPLETE?
> > > 
> > > I think Jens can confirm whether we really want all drivers that use
> > > polling and io_comp_batch to manually call
> > > blk_mq_set_request_complete().
> > 
> > Should not be a need to call blk_mq_set_request_complete() directly in
> > the driver for this.
> 
> Exactly.  Polling or not, drivers should go through the normal completion
> interface, that is blk_mq_complete_request or the lower-level options
> blk_mq_complete_request_remote and blk_mq_complete_request_direct.

Hi all,

Thanks for the comment. It was the wrong use of the function...
I will use blk_mq_complete_request_remote() instead of
blk_mq_set_request_complete() and send next version soon.

Regards,
Suwan Kim
