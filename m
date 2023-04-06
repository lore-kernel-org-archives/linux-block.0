Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD0FC7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 05:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjDFFY5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 01:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjDFFY4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 01:24:56 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59834C2D
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 22:24:54 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so41826935pjt.2
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 22:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680758694; x=1683350694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7cEjrRQ03AQNV9wTUHdv+hxN2vrEId8MEhnE+DUBPM=;
        b=SxIo6BX+3ZPhpBLGgQZcXvZTxu2s3ldiGHoda80SvP2Cl0hb+rPDCmb9k2mjp4E7xN
         0UcsxUW9GsTNVfjgyaAgrUuFTqIbDtY+Ld2+LqjVDGBJpJB0WQYbV7xzOXRRNTNwA/GO
         lfK2QehXzGfndsZPMF6xuyVKezQ74y5I5HpLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680758694; x=1683350694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7cEjrRQ03AQNV9wTUHdv+hxN2vrEId8MEhnE+DUBPM=;
        b=jSBogPhFRWC/vxc2tgSPJya9SboogxE8uFbcCEfDyyVYIzbYwaNzcFjD69m61QTI1W
         LCsPlKO7CxeMN8meppIkRyEp+CKJW1lsgTxTIj1ZuTIWs2QHKJs2yAvmJbwzoN6U5TBq
         n2+GQolMmJRsvXCADseT8dXfkiuCG5iddoNaYOv28IHaI100suHpFWHRMyzTJdG8Fzpn
         S5+rc4Yu+Dj5Wc8GYibYpFm543xTe2DmDH/8GhLbeOYgXEfpAdT4pU9XlynbjlmKrtDZ
         ul1H51N1sECMNmV4R2PnCsDpJQYU5233ZCQ1pijykiImPMHWyvv9Yv5jD29szP36krCg
         8BjA==
X-Gm-Message-State: AAQBX9fOocbrqYM3JauWe1KX8Fc3WQ1ZiTEIQiaX61kSodzA2YvrucAp
        KcewjMPybtu22qQgC53MbLN4kQ==
X-Google-Smtp-Source: AKy350byRan/65RyjGJvucQkzjSHLsFXuv47xWT7VQYXHwm8t4xRYOFO0FZTVxHKH6cE9dBRWFD42Q==
X-Received: by 2002:a17:90b:3842:b0:23b:32e5:9036 with SMTP id nl2-20020a17090b384200b0023b32e59036mr9304383pjb.17.1680758694393;
        Wed, 05 Apr 2023 22:24:54 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:678c:f77b:229e:3adf])
        by smtp.gmail.com with ESMTPSA id jo18-20020a170903055200b0019a95baaaa6sm433765plb.222.2023.04.05.22.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 22:24:54 -0700 (PDT)
Date:   Thu, 6 Apr 2023 14:24:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 14/16] zram: don't return errors from read_from_bdev_async
Message-ID: <20230406052450.GC10419@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-15-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> bio_alloc will never return a NULL bio when it is allowed to sleep,
> and adding a single page to bio with a single vector also can't
> fail, so switch to the asserting __bio_add_page variant and drop the
> error returns.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
