Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08559C43334
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 20:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiGLUkE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiGLUkD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 16:40:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C15CC79D
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 13:40:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso222269pjh.1
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=aX97FT52LcXsTBCiBL5hq7AYEJzsuUqnsB+OeO5wNUI=;
        b=ISNO/DvKwrzvLX+I3lt4LSTitlFeuCDsXxg7l0bOqQrLfTda0AaH7JwUwddV3ZXjtY
         NsOyVdJCBRvz26jArgXSzLHTq2NF6SdRNfj7PWjfhVDlJxFudzKCZMZx20MHK1Y1knq0
         /9u8jaX5Z291rmQYVGsyY/uxj9NpYGX5ej9ij7Sy5K3oUeWcRy+WFVyI8FKD0BQf7t0Q
         Hp09wJ6te5WZp9BUQS9FOOj1Xgk6kHejMeI4YdsNG8Zpb851rS8W0+UEsMeTSGmFgOeA
         +ZKnmH7ZNxajWMDHPJy8ocCWothlzQY43DBWcQCx71CFqz+kGTstfski/wZ1zNhCrXUA
         msXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=aX97FT52LcXsTBCiBL5hq7AYEJzsuUqnsB+OeO5wNUI=;
        b=Aq7dFsIBsDFmZCvFbwfrmRz0JBTSg2hxftBQmfF7AVBB3ihGNllXsvl8XOs6dJMipd
         Xt5Q5UhH7Yyclf5+9oBTviXTpkcbfP9SnANY7zOmmBWolAcO0lgMYF0/Yad9403/+Y86
         uZUh+nTad8RxmevSi11uLKv0tEVi/oQQ4IiVO4F5ZBJekrernFtOODPT0J0hJMSX/S92
         QIZzbt4CgPKvD6jz6RIUaPZTjVyr3N6gK06tYdpQcuAprMRvF+xqUZwjNLGSm5Xj9QJu
         Ch2YNd25z+LIxEyvN+u5zPGbyK8zmPbkgcgMc8ByFeWIJdjtD/kdETh7q2uk5uvSlnTG
         v4rg==
X-Gm-Message-State: AJIora/QMh50NiLVT91MvOLWO3Iu+9dIF6IVR7vVKIWcCjxfvVX5R8Fy
        Vg9VWQj8KX7uIL2J1EKd9r0dvrgh/QIBsg==
X-Google-Smtp-Source: AGRyM1t6x1Ab7heabJRf35mE4oK6fvMWsvfp1HSbfdON5u+tBveeyFBGQ4hJxCuNCdDcPgjTKuMiBA==
X-Received: by 2002:a17:902:f60d:b0:16a:1a7f:a22f with SMTP id n13-20020a170902f60d00b0016a1a7fa22fmr25715932plg.13.1657658401528;
        Tue, 12 Jul 2022 13:40:01 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b0016c0c82e85csm7245012pln.75.2022.07.12.13.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:40:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, ubizjak@gmail.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220712152741.7324-1-ubizjak@gmail.com>
References: <20220712152741.7324-1-ubizjak@gmail.com>
Subject: Re: [PATCH v2] block: Use try_cmpxchg in update_io_ticks
Message-Id: <165765840073.44296.3101525406707231315.b4-ty@kernel.dk>
Date:   Tue, 12 Jul 2022 14:40:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 12 Jul 2022 17:27:41 +0200, Uros Bizjak wrote:
> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> update_io_ticks. x86 CMPXCHG instruction returns success in ZF flag,
> so this change saves a compare after cmpxchg (and related
> move instruction in front of cmpxchg).
> 
> No functional change intended.
> 
> [...]

Applied, thanks!

[1/1] block: Use try_cmpxchg in update_io_ticks
      commit: 939f9dd040fe1063d884f8f0f89b037093fe2341

Best regards,
-- 
Jens Axboe


