Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C5AC7619A
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 02:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjDFC6Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 22:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjDFC6Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 22:58:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D4B5B97
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 19:58:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id iw3so36290296plb.6
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 19:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680749903; x=1683341903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBxCnTWWioaHhsFkPOzVSJK72utSvq4IDlTrjAZpCn4=;
        b=NlDwbj41aGxAqSkRgwqh/UXS9WUjd38GHJvtbQdCGaHZZ40TwRphhM/ROLe54uuwzI
         4SQbG7d8Dp2R89oaeLxUnkabwoii25y8KRAVFCj9L7u5tHw/drxK3Jr0r+FhBbs9+dKr
         rxX5FCVh59GvOaSPsXgfk6LaXY32SQ1UAExSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680749903; x=1683341903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBxCnTWWioaHhsFkPOzVSJK72utSvq4IDlTrjAZpCn4=;
        b=l6AuXFDA+vN+e04bMfISJTkUM+PCvK2E1n7WPHwfn4iSwijRMp+/2nnRGUTRom5IJ1
         +TCCEhyFswHK1DhVBifrfaT1xVA1aTCL8Doy5lv1Eq096BYZlDvjwCP1FvS4XJcmNe2s
         6xiyrsK31kvcePvxG1+juaP0GTk3Cf4BY6218rKxWa5vlggT+G/7DN4LqKe+srBnzmwa
         pNKv3MGibAUQl9i8dJnsmFfquwPWqSw16z91oTCQzhvy/mK0jNCap3YM0aEyt6JmBxfa
         nILaLRAndwGZnATM6aaOuP11ajMcVL2EkwvCYtYSdVfiYUcV7DMrQhrUjMISwgjKCDA3
         hUKw==
X-Gm-Message-State: AAQBX9devK8BpF1+mCk99/IRjdissFpR7Xe1ouOa8qXE/C0sDhx4+O8l
        rSUfnb+ZWiFu1zxJzNrIIsBb7mXawyV4r9CQVfg=
X-Google-Smtp-Source: AKy350ZMtyKjdat01iVxX218E7nVDK4VSITYdbSaHkBW9agpKoBS6IBvka4ZKZbcWdb3j+Js8pc8XA==
X-Received: by 2002:a17:90a:190f:b0:23f:990d:b5b1 with SMTP id 15-20020a17090a190f00b0023f990db5b1mr9266766pjg.46.1680749902759;
        Wed, 05 Apr 2023 19:58:22 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090aec0200b0023fda235bb5sm85019pjy.33.2023.04.05.19.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 19:58:22 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:58:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 10/16] zram: refactor zram_bdev_read
Message-ID: <20230406025818.GV12892@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-11-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> 
> Split the partial read into a separate helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
