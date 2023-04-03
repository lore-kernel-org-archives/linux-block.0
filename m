Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303D8C761A6
	for <linux-block@archiver.kernel.org>; Mon,  3 Apr 2023 17:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjDCRhY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Apr 2023 13:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjDCRg4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2023 13:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8FC1BE4
        for <linux-block@vger.kernel.org>; Mon,  3 Apr 2023 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680543368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kRxa0YKbguBcG37lL5IXPmAB9UHNR9qC66djwGg5+XY=;
        b=GtJPXurheN1LCMk5M17DBYxHzhBVWnTCjXlbqf6mdCPLqQo+cZ0gT44FGsAUZFxX6mk4Lo
        njQqKxWg3HToiyNJhdp42PrTFqtWu2S3X9zqf5ZhCJwga07Vok65pKD6lNPkSdAF7SR7cU
        nF7vvD7ZA62iLqvlC3hPbcxJ4oELrrY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-Dws4UzYuMpyty8gnMdumZw-1; Mon, 03 Apr 2023 13:36:07 -0400
X-MC-Unique: Dws4UzYuMpyty8gnMdumZw-1
Received: by mail-ed1-f69.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so41569455edc.9
        for <linux-block@vger.kernel.org>; Mon, 03 Apr 2023 10:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRxa0YKbguBcG37lL5IXPmAB9UHNR9qC66djwGg5+XY=;
        b=RepsP8lZoFo7Ywig+7Dw1YaFITQc0zYOCymYh72uGk+dTrRO2wKbf9P7dISUIIeNOM
         B86PB5MTiN4XBTnaN4wwGq154wdU6tpp4QjMrziiQAFHI+uJyGljzEJFOqmvz7WAwH1w
         GrVwXjbr4mwjVKDAij9bVhjnccc0w2zYqW1/O0hxS3wW3kNIYGA8ceaaMpCtFE9YciWB
         Gsl62yqHuzwYwmIAXZXUatumXofZ8XaTMlN8LYJKxfyAig97+mVip/0IeP39ZJ2lAnP3
         V6+vIwR1o1a3K+G5vk/yheg4oppdQPT8pUXHRzq4m63lVG33ZNBSDwHAln9JPwnh/wXJ
         wihQ==
X-Gm-Message-State: AAQBX9fEbE3xJpcM9h3muUUWOsd48nZovRg+vpi1yRz71kSKa+sXIFNY
        xqGi/ITUt0oLp3aAmKeixlP0b820qCvxmU6eaYEaxXNS7ejqNRAcCH3sF1zsQTMTsCqkCWCYqoU
        faF3v5bGTbSJ54sq3d02R1BE=
X-Received: by 2002:a05:6402:68a:b0:500:47ed:9784 with SMTP id f10-20020a056402068a00b0050047ed9784mr18115780edy.14.1680543366041;
        Mon, 03 Apr 2023 10:36:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZeBwpH/XQY7l9EvuJLwM3aTGzHzseeXKXbq/GXuvWXoXuy0gvDUtkeWJVcJ9D9wmn4rGwqSA==
X-Received: by 2002:a05:6402:68a:b0:500:47ed:9784 with SMTP id f10-20020a056402068a00b0050047ed9784mr18115771edy.14.1680543365798;
        Mon, 03 Apr 2023 10:36:05 -0700 (PDT)
Received: from redhat.com ([213.152.162.235])
        by smtp.gmail.com with ESMTPSA id m2-20020a50d7c2000000b004fe924d16cfsm4903827edj.31.2023.04.03.10.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:36:05 -0700 (PDT)
Date:   Mon, 3 Apr 2023 13:35:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, virtio-dev@lists.oasis-open.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sam Li <faithilikerun@gmail.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/2] virtio-blk: migrate to the latest patchset version
Message-ID: <20230403133334-mutt-send-email-mst@kernel.org>
References: <20230330214953.1088216-1-dmitry.fomichev@wdc.com>
 <20230330214953.1088216-2-dmitry.fomichev@wdc.com>
 <ZCrtjrYQHnppV8gN@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCrtjrYQHnppV8gN@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 03, 2023 at 08:15:26AM -0700, Christoph Hellwig wrote:
> What is "migrate to the latest patchset version" even supposed to mean?
> 
> I don't think that belongs into a kernel commit description.

I think this should be something like "update to latest interface version".

-- 
MST

