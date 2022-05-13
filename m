Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD02C433EF
	for <linux-block@archiver.kernel.org>; Fri, 13 May 2022 16:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359757AbiEMQwj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 May 2022 12:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379129AbiEMQwS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 May 2022 12:52:18 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE4254FAC
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 09:51:45 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso11337061pjb.1
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 09:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Alv0Q5yUp4HcQx/ktizSOXMokGOXZCCo4Fvnr/F9WVE=;
        b=44yr3gWbtWRKivkyz74tcmCNXS+Fl26bM2OMoQlSQirdFa8HibOR+CWXvUEfHbdZA9
         h6wXFiQE3pvtzkUJra7b/+Blz3dar4A6jsLR2f3DHu+5KVpP28LZOmLlGKnaaM5F38JK
         h6N3zahnqpEUAgG0hi+8LHtrRFbzHjDeaMqtFFjWfuk6y+aPswwAfeTepTT7wVFtz1U3
         B9p6dBuTadiQ+MdajCqg8uQ0y6ShzV/GYi2ESOB6nSkGW5iUMDNKbDuzB2bbQvRFhz2p
         DFWb6+jLWx52o+emX4wrmgd9JugEQkqWyPoWXnZUB4Y77c6a11Y40Fi6joW8Ljz6WBvu
         z94w==
X-Gm-Message-State: AOAM530ZbYTJRsCrtQ42twILIcmxpA4p/+qSwzvqJZouAxks8F+j6jt6
        dgs0puXmPCrcPb9El4oXZP0=
X-Google-Smtp-Source: ABdhPJw/nU+yv/v8x7oWDPRRYouf4KFyVT439ijBbIAyRgHHGYzGVcAqTyX3dQLX6nliQWzyM5wCKg==
X-Received: by 2002:a17:90b:194f:b0:1dd:a47:3db5 with SMTP id nk15-20020a17090b194f00b001dd0a473db5mr5844014pjb.74.1652460705249;
        Fri, 13 May 2022 09:51:45 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090ad98d00b001cd4989fee5sm3795426pjv.49.2022.05.13.09.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 09:51:44 -0700 (PDT)
Message-ID: <10b594f2-bec1-76db-5580-7bc1709805c3@acm.org>
Date:   Fri, 13 May 2022 09:51:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] block: avoid to serialize blkdev_fallocate
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <20220512134814.1454451-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220512134814.1454451-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/22 06:48, Ming Lei wrote:
> Commit f278eb3d8178 ("block: hold ->invalidate_lock in blkdev_fallocate")
> adds ->invalidate_lock in blkdev_fallocate() for preventing stale data
> from being read during fallocate().
> 
> However, the side effect is that blkdev_fallocate() becomes serialized
> since blkdev_fallocate() always blocks.
> 
> Add one atomic fallocate counter for allowing blkdev_fallocate() to
> be run concurrently so that discard/write_zero bios from different
> fallocate() can be submitted in parallel.

Please consider adding a "Fixes:" tag since otherwise this patch won't 
be integrated automatically into any of the stable kernel trees.

Thanks,

Bart.
