Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A57FEE49A5
	for <linux-block@archiver.kernel.org>; Wed, 23 Aug 2023 00:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjHWAIg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Aug 2023 20:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjHWAIg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2023 20:08:36 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FDA133
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 17:08:30 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso939767fac.0
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 17:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692749310; x=1693354110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6voCTFbL0lNbz7y0IRbENmmss3++8RsYIaK/hukXzZI=;
        b=sJY6ArUvu8a+wfwuZZ9xumV/iTUHXJUytEikIUOyu8NcO9k72WRic/FXlS76gq6rqG
         fCIulukOrg6Cj+6lEDbwH9u5/8bUfv5lwq8JNzH1FkZ6wF8soVd+C9aFfND9J1u5Zkbr
         frTgrlmcMI1YGlsYtB1RqSdSOYBOZLkJE2PNDAQrDFnZCFnlb6MIyxP2LcfyMx1SMQOQ
         0WGmTs8jaLsOojY4OJznrTu3ccaEJ8H4H2A+hfa/WHlTF9yo7h3U7YMeczONp1bfS2NC
         5y+o/aivcbB8+r2Yfs88Z4akJyiSnl5j8c4xayW4CDcadqvoLIaZ2EUUGf+bKz5tYECj
         QTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692749310; x=1693354110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6voCTFbL0lNbz7y0IRbENmmss3++8RsYIaK/hukXzZI=;
        b=fLDAjbdq4WDq+ctpsDEFzkaTDCqWpBSp9CwSQFB4RbSAavfig67muxa1B+LYmNPkaz
         kbHkY4BXD2yYDR7mlvaF6Zg4NurFk2mRDWb2yVu8eObdcqsrDpgjb8Rn28cfAgbvt/so
         IMPo4LZHdtrek+0Y2HLPUTFu0rXCK5680/WsdvlMPnx6lOK6dqXLqDlXkbqXnBX6eJ9w
         0pqmCB5MWr6y9/5NtIGXiLjJPPTmGXawSh517wGB1IiX5wEKuIaxMElKo966X62o3sBe
         ZkmANk0TBoGxsrAgWNJtOcPCAteGz73KLWyKE3sZCfca5gg+wG5W5JHGGkZPaqXuS9ZO
         sBUg==
X-Gm-Message-State: AOJu0YzmHe87ZxxzYIr/xOBnvYC6+PtmKLvflNMb+W5b+HlzNrKUEyP6
        4BQ/k4bvILryvriMFcHPtqMCHg==
X-Google-Smtp-Source: AGHT+IEsT7YDa/7c6bzW0F46+sq8eU5YKhnMY8iy6qpz38n7aoD6dI8tILwNZhuh50G4IT3oEZTqgA==
X-Received: by 2002:a05:6870:330a:b0:1bf:9fa2:bfa3 with SMTP id x10-20020a056870330a00b001bf9fa2bfa3mr12503886oae.1.1692749310072;
        Tue, 22 Aug 2023 17:08:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bg23-20020a17090b0d9700b002680b2d2ab6sm10149127pjb.19.2023.08.22.17.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 17:08:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     yang.yang29@zte.com.cn
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
In-Reply-To: <202212031422587503771@zte.com.cn>
References: <202212031422587503771@zte.com.cn>
Subject: Re: [PATCH linux-next] block: use strscpy() to instead of
 strncpy()
Message-Id: <169274930900.113062.17637182584523326020.b4-ty@kernel.dk>
Date:   Tue, 22 Aug 2023 18:08:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 03 Dec 2022 14:22:58 +0800, yang.yang29@zte.com.cn wrote:
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.
> 
> 

Applied, thanks!

[1/1] block: use strscpy() to instead of strncpy()
      commit: 146afeb235ccec10c17ad8ea26327c0c79dbd968

Best regards,
-- 
Jens Axboe



