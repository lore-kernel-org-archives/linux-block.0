Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCA5C433EF
	for <linux-block@archiver.kernel.org>; Sat, 25 Jun 2022 03:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiFYDJs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 23:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiFYDJp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 23:09:45 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6B454F9A
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 20:09:45 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id z14so4079735pgh.0
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 20:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iYFUaMwvzZJF6vEMmAoJeqVUj/lS/jiIVNwwYJ+sr/Q=;
        b=7on7DCN+lF6bWlkFG3LtcT/zsOfygdRSLak8GI9coIlORBbTf15zisKFvDi8M6d2ZV
         0LujVkH2xQom4e67VFvuNX8VV8zttHgAocs4smuTOzXz7NlVkMVX/tMqAaIcNPE0Jy8Z
         VaugURNhSIL7Vc3fvylWl3Mq3LykGDjWPO84D0M78NYJVMLthb0EnCr6UU3xLZibZD4F
         o4GgfKE5BrzSRpe5p6+WYFoZlDqPRdhqUZhGbshuqiyxBpDc300h74zBG4VuB5Frgf8N
         huw+BqPFubuPm9iKGrXstDlFi3u0vGZQtJQ6iriqYPm/PG4G53VT6lp4kylFDzSRgPOJ
         kI7Q==
X-Gm-Message-State: AJIora/YF8ZnNn7Uvjs67nopLXr95Igcyw/BOoqV4b/ocHzCLi81csxw
        ptKxgpAKHRuAZ6vjd0cqrrXvnqaCkZY=
X-Google-Smtp-Source: AGRyM1vB9LK4oowcEE0daIcuPpvz5KApWdIXq+PJ26r+R8uRWZA5jQgIv6mu/of29wYbt60QgD4iVA==
X-Received: by 2002:a05:6a00:2490:b0:51b:f709:ebbc with SMTP id c16-20020a056a00249000b0051bf709ebbcmr2373704pfv.43.1656126584473;
        Fri, 24 Jun 2022 20:09:44 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b005255165be67sm2496999pfh.23.2022.06.24.20.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 20:09:43 -0700 (PDT)
Message-ID: <ee50cca2-c6d2-141e-5855-7822b3c5a491@acm.org>
Date:   Fri, 24 Jun 2022 20:09:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 6/6] blk-mq: cleanup disk sysfs registration
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220624052510.3996673-1-hch@lst.de>
 <20220624052510.3996673-7-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220624052510.3996673-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 22:25, Christoph Hellwig wrote:
> Pass a gendisk to the sysfs register/unregister functions and give
> them descriptive names.  Also move the unregistration helper next
> to the one doing the registration.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
