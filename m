Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6841C433B4
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 20:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72B061355
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 20:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhESUKc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 16:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhESUKc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 16:10:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDA5C06175F;
        Wed, 19 May 2021 13:09:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s20so7680406plr.13;
        Wed, 19 May 2021 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lriiXlwHl41FtaV5CoBrV98HLQ9Gp2N1i35WCPU1eqA=;
        b=dKEqkRVfGgMyoGeqNU/Wv8pn+ukFifp9q8JivcHVlOQdrprqGZxxNJ6xf3JaNyTUdx
         pMGL8dFzJxihPpRu6DYg3c8Vu9xAfxna2Zx5q+Ak4PwluGAsqPvoIp54sV4sfWJ+MpXB
         xBqb5J6izMjs/JFnOGZM4x9jbI+5pFH5xj5KRz2nMPb3eNCbrlTFHH9RgC/waFkMpQ6J
         PdM/PQEfOZx0LNTlyZGomnoOfcPoW0pI/pDUhufucnT5YcTJ9HnsnuEP9JFkni9u3lIJ
         pk+uSvgXTn8WHo+TdY8l0jw5umUnOVGFfHHkZFOgyviTtwwllUl/c6HxowplQ2Eo1XnV
         4PZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lriiXlwHl41FtaV5CoBrV98HLQ9Gp2N1i35WCPU1eqA=;
        b=ltebFBV7d6jCjyw8TEqRmThZRw0ZDMboIx08p69+L+3bvVvUNzpM1nAtScDL/M0Iju
         pONFj538m+3Mha6dcW+XiRNtRZh1rSvLX/2FZ/cNDRSTiopUEK9ORbuhd2QfJ/r+V41O
         e3rbNAMcPORzWs6X+Wt4+ayZfGodKYZdvAYkTUAnAxmOS3emiJnxo1wTDxvttYTqDXxo
         qY4LeA5+vfWy9/eNzPvcO9FF6bAMzln1l6H2RPm/wSa4cFIgI2xh5zH6CgDSU8SzOuF/
         QFIHl4wQk1I1CiQHdVAswNuHykTRqtmDyVQ8jPTIee/v5goog7YqTI/nEwV0xOt1qL7v
         Q6iA==
X-Gm-Message-State: AOAM532up/4PWjPihTQp6Ocq+tB7s3prxOHt/xYxO7seTE88jS7Cglrl
        qvxXqV8Xb0p8Rk9vkIUqaqM=
X-Google-Smtp-Source: ABdhPJyRIP2OET6BhmkttYHpZgBQw+uanaslQBGyKVZRHgg4WwBOqHzuR/+zFxeGcOxN1nzy5O6zSw==
X-Received: by 2002:a17:90b:116:: with SMTP id p22mr718929pjz.186.1621454951706;
        Wed, 19 May 2021 13:09:11 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:4102:f4c7:9246:e6c4])
        by smtp.gmail.com with ESMTPSA id 10sm181025pgl.39.2021.05.19.13.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:09:11 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 19 May 2021 13:09:09 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] zram: fix few sysfs races
Message-ID: <YKVwZVcbZBNXUpKm@google.com>
References: <20210423011108.11988-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423011108.11988-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 01:11:04AM +0000, Luis Chamberlain wrote:
> This 2nd series documents the fixes better and includes a bdgrab() fix
> for the issue noted by Minchan. A general fix has been proposed for two
> of these issues however they are not yet deemed required upstream and so
> we just open code individual solutions on the driver.
> 
> Luis Chamberlain (4):
>   zram: fix crashes due to use of cpu hotplug multistate
>   zram: avoid disksize setting when device is being claimed
>   zram: fix deadlock with sysfs attribute usage and driver removal
>   zram: fix possible races between sysfs use and bdev access
> 
>  drivers/block/zram/zram_drv.c | 473 +++++++++++++++++++++++++++++-----
>  1 file changed, 414 insertions(+), 59 deletions(-)

Hi Luis,

First of all, I am sorry too late review. Now I see [3/4] and [4/4] would
be not only zram issue since you shed a light in the descriptions.
Yeah, that would be helpful if it could be deal with under general
layer but looks like arguable or would take some times at least, IIUC.

On the case, yeah, we could fix it for zram first until the issue will
bring up further. Anyway, I'd like to see some wrapper rather than annotating
for every sysfs files for maintainance point of view.
At least, could you introduce one more patch "introduce zram sysfs wrapper"
on top of this series to centralize the work?

Thanks for your works!
