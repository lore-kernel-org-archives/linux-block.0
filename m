Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13A9C46467
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 03:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjAPDxz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Jan 2023 22:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjAPDxx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Jan 2023 22:53:53 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E637383CB
        for <linux-block@vger.kernel.org>; Sun, 15 Jan 2023 19:53:51 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v23so24143066plo.1
        for <linux-block@vger.kernel.org>; Sun, 15 Jan 2023 19:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeL2aMm/FlBSF1QP/YxXM0H+2tWA4RrG/z4nLNj/C5A=;
        b=Nm6l1cDkz2vKYpYch7neC71ii3Ml4A0/rJ0KvUmcnWfdFsSMdtGXrTzG1/moOYv8TK
         iWmbHXm3dqOaO2vRzYj/4hXl9g5NrIJUb0FO2TT8Pbp5ptAoadGB5kUxcaW7jUhPIgKG
         PRV5Y4mkwxImAB2LaNRbOljmMaoIJ07SeqDdWqX979SvzmpCEKSuLVG6UF3KsEWUejne
         eL8Yf4ZgKHMkunkjP2JjMIqY7woGKaaf+2WBxb9EuIXafNBxjibsOUyU3ahj84Bbl+9i
         yVxqB7uo70jIKu7kQfXMAYreaiMbZ/SkmYBbVAWgHpeoz2usqc11XDCygHZz17mSGfuP
         VIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeL2aMm/FlBSF1QP/YxXM0H+2tWA4RrG/z4nLNj/C5A=;
        b=FZ2DidWl8tIUOlKQmaXj02wlAnS+QaMr0jvRLpr4ImBXbcK88w8mCcslr33hZBheOZ
         rbyREvC1QKThWpfPiFLjoYmqdMPW1Es27Q6p9nRxDPM9QiYXngsWx7MPW1tO9WKydYw1
         6hTaWrF/Xd+DJlDNpeqej1rSfufTNRBIt/Mgw+JpoTWT2iKdCCZA7aPcpN3YGi+8KljM
         ESC4xD31uoJoNusw82Nl+cYcincIImUsDxiZ9F7a6VUkI5RRdGZduWvuwMYAH4VvHfEk
         uPRBPy7YUz//02XF4rYaah4MoU9Xtv24x9aCfdm6qAQaYZVOEeH6AvO/HQ68uLoMDLV/
         St7A==
X-Gm-Message-State: AFqh2koMFsdHYd1lRMXP78AO58tu7ecppwG7Ei1mjAVrFpEmFomACVse
        UwHfaguenXgQwkMjz/AyRYLQGw==
X-Google-Smtp-Source: AMrXdXtJkUkxD2XGU3GP1AMcajSPxDY0bC3EiVPGlzcexk5O5DtAyG2PJsrGWwdv5HGdgyw4Phq0Ww==
X-Received: by 2002:a05:6a20:1455:b0:aa:512:82fc with SMTP id a21-20020a056a20145500b000aa051282fcmr31630673pzi.1.1673841231379;
        Sun, 15 Jan 2023 19:53:51 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g8-20020aa79f08000000b0058d928374f2sm1975504pfr.20.2023.01.15.19.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 19:53:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, paolo.valente@linaro.org, tj@kernel.org,
        josef@toxicpanda.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230103084755.1256479-1-yukuai1@huaweicloud.com>
References: <20230103084755.1256479-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block, bfq: switch 'bfqg->ref' to use atomic refcount
 apis
Message-Id: <167384123010.165459.4491550988140898321.b4-ty@kernel.dk>
Date:   Sun, 15 Jan 2023 20:53:50 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 03 Jan 2023 16:47:55 +0800, Yu Kuai wrote:
> The updating of 'bfqg->ref' should be protected by 'bfqd->lock', however,
> during code review, we found that bfq_pd_free() update 'bfqg->ref'
> without holding the lock, which is problematic:
> 
> 1) bfq_pd_free() triggered by removing cgroup is called asynchronously;
> 2) bfqq will grab bfqg reference, and exit bfqq will drop the reference,
> which can concurrent with 1).
> 
> [...]

Applied, thanks!

[1/1] block, bfq: switch 'bfqg->ref' to use atomic refcount apis
      commit: 216f764716f34fe68cedc7296ae2043a7727e640

Best regards,
-- 
Jens Axboe



