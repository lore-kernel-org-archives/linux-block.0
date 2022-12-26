Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410A9C4167B
	for <linux-block@archiver.kernel.org>; Mon, 26 Dec 2022 19:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiLZTLl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Dec 2022 14:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLZTLk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Dec 2022 14:11:40 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B57E37
        for <linux-block@vger.kernel.org>; Mon, 26 Dec 2022 11:11:30 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id o17so3902000qvn.4
        for <linux-block@vger.kernel.org>; Mon, 26 Dec 2022 11:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki8erFK6+zdeqp6mmQ4ZeNXpW07xxtnIN5dQM+gH9tw=;
        b=I1Hb9MtthY1UsgJEjiEuH/h+pQZyfWJ8Lk4kX5EOkterJ0kgKclSV/OQBqRcS6yQwU
         NbQ3epR46cWs/444OUfZIfKQIWn/8ovKUKFCITCvtr0FTxYYRIaNMIpUkdks74UOj05t
         DrPlKj9HbOBDYgL8wzoFtWIZBStSjVvu3aOX+e3NKG2lraOnRLuVIyLlMcMa9rzE928B
         XG4WOqxB0LRxqyDEMwgZsww5ZQgFcpfvTiFYFp7fYtFjP1+2Oz/35ZyartbG5iuzpPya
         dZZCV9NjrhSjIitJ+vJLH1Znk+4p6Y3Pm+uammvg38Y7qcS1YhlibUaEOg2+6b/4+zDA
         VGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki8erFK6+zdeqp6mmQ4ZeNXpW07xxtnIN5dQM+gH9tw=;
        b=3qcb+gVjyjxZLkYVV/XBRWPA5KZksO4SO7+r66X1tHoedxH7eMkju3ceb9QH1sp18f
         4ud/gPDCzDtVcKFh4DJhv2Az1tLM3wrJfbzJEeumbHpKKuC1YT0QEBnMGc3y0qqYRDvt
         wU5P8AzcZbHVOiVa26XmGWd2Lttz44p+u9Mfxh9qJggx74gqXheQ5vHTRGZaGxZY0akN
         F3e/Ssgv73KnKTed2lkxW/Rdksf4edr0wm7F914DXMl4x1qx+EevUWi5Z61xhweJ0PJK
         bQj/75xWs+V4RvIRuWvL1N75nplgU9gNzAWFmh8xmuGx/Dbe247F2GRQZehAcJOl81tQ
         VcyA==
X-Gm-Message-State: AFqh2kocXuqRyxW3VviUwAiltoZE8THW/hGYd+y8wfULPWD2kPaqsD5p
        ufHPnaDPDfvpC1fz9s+EMADinQWYdosGiw42
X-Google-Smtp-Source: AMrXdXtG2kCsUCujjb7Nl8fxazyAzG36Qd03gN+F64PW5mgkrbEPsJjA9XvdNXeIYxOZWIF1tNasWw==
X-Received: by 2002:a0c:ec41:0:b0:530:c834:b3e with SMTP id n1-20020a0cec41000000b00530c8340b3emr2875483qvq.0.1672081889805;
        Mon, 26 Dec 2022 11:11:29 -0800 (PST)
Received: from [127.0.0.1] ([216.250.210.0])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006cbc6e1478csm8145190qko.57.2022.12.26.11.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 11:11:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     paolo.valente@linaro.org, jack@suse.cz,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
In-Reply-To: <20221226030605.1437081-1-yukuai1@huaweicloud.com>
References: <20221226030605.1437081-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block, bfq: fix uaf for bfqq in bfq_exit_icq_bfqq
Message-Id: <167208188642.23141.13167280199462782271.b4-ty@kernel.dk>
Date:   Mon, 26 Dec 2022 12:11:26 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-05166
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 26 Dec 2022 11:06:05 +0800, Yu Kuai wrote:
> Commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
> will access 'bic->bfqq' in bic_set_bfqq(), however, bfq_exit_icq_bfqq()
> can free bfqq first, and then call bic_set_bfqq(), which will cause uaf.
> 
> Fix the problem by moving bfq_exit_bfqq() behind bic_set_bfqq().
> 
> 
> [...]

Applied, thanks!

[1/1] block, bfq: fix uaf for bfqq in bfq_exit_icq_bfqq
      commit: 246cf66e300b76099b5dbd3fdd39e9a5dbc53f02

Best regards,
-- 
Jens Axboe


