Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7271AC7619A
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 01:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjDFBpn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 21:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjDFBpm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 21:45:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B41769E
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 18:45:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so39163792pjz.1
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 18:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680745541; x=1683337541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVX/ObsoB1YMIpbJBvrf7XALXwTbbsVzCIqppDHHgC4=;
        b=Qy31wX2c1cCuVEpX3wOT9p7xc2B/D+buJTXIhyXlnvPC16JCnjaafSHZnFlxTtLAER
         6OAqZBhfiQ2DexHyjBhONymF3NZTqoLEieKKkGe3ias9iPjH1StF0DKGEU/tuu+Jm2lY
         URmGMXuRgJq66C8gqGmzJnZSF6SAQqk++W944=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680745541; x=1683337541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVX/ObsoB1YMIpbJBvrf7XALXwTbbsVzCIqppDHHgC4=;
        b=YEWwBSBaOzD3YirR2e+d90O5twfBSCbKB1/qFF1mId6pisWhWe2hM2yIyZGXen6Os9
         PEHtNkyHfBaLyYFPGzk2fvHmg+sxMHuY+vI+dwrsCFvrdpWJD5OhXKfPEoRiSqHm9JIE
         J1TGybbQrz2uLb1EQq7ehVgbKn4C54j24G5r3OKfyV/5Sxdzbkj5Z2HRVd1d7Mke7yhb
         PLoyJXREToDpuNXsrpek0dKkbJN6Z87Na3wzBTsoceVP1ZF/mehS6y3Z1EHhnrg4zmDN
         hOK/GVR6sRqBeeQFGh8vVBkFznPB+twqSznKJ55T/HPbiq0Q3DJHegIij4/5B+7WYiY6
         2gWA==
X-Gm-Message-State: AAQBX9dOKdHi6ePWhtghonq5JMkk35483EFx7Dfi+McAQbecksGk3qp3
        1ZPdrF1wzCsfyJONcpZ6UdfyrA==
X-Google-Smtp-Source: AKy350ZQkA7zjhkAnJbVuyAjVZHwuAHsAIYssQU6OX6TzftJVqk+aaGChlvgduKek/OV+6t5wWFldw==
X-Received: by 2002:a17:902:e353:b0:1a0:428b:d8c5 with SMTP id p19-20020a170902e35300b001a0428bd8c5mr6905777plc.45.1680745540956;
        Wed, 05 Apr 2023 18:45:40 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id 144-20020a630696000000b0051303d3e3c5sm14579pgg.42.2023.04.05.18.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 18:45:40 -0700 (PDT)
Date:   Thu, 6 Apr 2023 10:45:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 02/16] zram: make zram_bio_discard more self-contained
Message-ID: <20230406014536.GN12892@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> 
> Derive the index and offset variables inside the function, and complete
> the bio directly in preparation for cleaning up the I/O path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
