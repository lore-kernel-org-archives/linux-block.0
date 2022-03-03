Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91817C433FE
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 17:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiCCRaJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 12:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbiCCRaJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 12:30:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64C0C7EA2
        for <linux-block@vger.kernel.org>; Thu,  3 Mar 2022 09:29:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b8so5116848pjb.4
        for <linux-block@vger.kernel.org>; Thu, 03 Mar 2022 09:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DcEbjshQgySqBtgjSy1+OKZZY+Sd4vwdSaGKmyFWkJc=;
        b=WXwaDnsb8HID0Spn/or2l4ztUrO48fYiMPvuk7fTqUXl/yka5P7ohbzzf9cV2hAAcT
         r1Ypw8qIhmRcd2a+FB8l7hWmXj40wnAXgYQM4XpXpshGuHGMeX3DeqDW/6p7225yy49n
         oLrlZSGoTL9KMnG5YbYVn3+WnRo/G43JH3rp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DcEbjshQgySqBtgjSy1+OKZZY+Sd4vwdSaGKmyFWkJc=;
        b=uO8iNOnBIYXE32+Tu5MZSec7ep8fJIla6prue+nkYqMBVwXPjDvvHb25jswILsCPq9
         u2sAMGCsRsH1L8/0LIHVRtpHVxNOy9fFxAHhmHRN1TFU5gb0pE3zkqiVTeS7avcGvzfL
         Joc8qfCsEuNkDQ9hcsd/U8ItRDk76jKYa5lKZQsnaSe5l65AaslV2k6MYcpALPWx+ZSo
         sJtkpkalR6YvE4NzNLGfDUgd/W8kJDerSKquK1nnw7I/Q7awvJBklwWpYAIL/0d9RXIT
         /EHzW4MCTj9DNo2aDzsvgFAu+wE71TQqGIsnaF5CgWCWR5yY13XnNAKMXT0I48FwPUuB
         rQlw==
X-Gm-Message-State: AOAM532Srnb5OsYSXh25nSVD86BNTAZG/tCYMs+qqLPxrkszkRb/UopU
        xC2PcYTYg7tfhee4gwGpij5tzw==
X-Google-Smtp-Source: ABdhPJxqUAgcm+o53nFPmMt3Xzp/nP5eJagrImosmirB4O8e0hyGXPiQ0MlWzoISBvak+MEryFoZ3A==
X-Received: by 2002:a17:902:cf05:b0:14d:5249:3b1f with SMTP id i5-20020a170902cf0500b0014d52493b1fmr37147754plg.135.1646328563239;
        Thu, 03 Mar 2022 09:29:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l17-20020a056a0016d100b004c34686e322sm3292114pfc.182.2022.03.03.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:29:22 -0800 (PST)
Date:   Thu, 3 Mar 2022 09:29:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 5/5] loadpin: stop using bdevname
Message-ID: <202203030929.BF0DE2B4@keescook>
References: <20220303113223.326220-1-hch@lst.de>
 <20220303113223.326220-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303113223.326220-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 03, 2022 at 02:32:23PM +0300, Christoph Hellwig wrote:
> Use the %pg format specifier to save on stack consuption and code size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
