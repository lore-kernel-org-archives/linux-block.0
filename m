Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB1EC4360F
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2FB2081B
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 16:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXzSE3FO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfCGQ0O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:26:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53864 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGQ0N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 11:26:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id e74so9855175wmg.3
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2019 08:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UxOvR5LIzyVtZTJmDWWFfb2O4VMxlw2QAftQL36+kfQ=;
        b=DXzSE3FOdSBC5leOZ5Dm+vDRS3Ol1afytWxBjdn3Z8vvmSNBY/jGMl0yhGnr5CDSa3
         4Cz+eMUc4gjrgbHDyBBQmleVht1uG6TQ4zjVI/SJVhU6hO3ImiefEWIHtOQ70uCTRznP
         6YBK1x7SN9BZ3uekWIkfA5wvh7d+UsuUPPUzMTpvqg1gAGRuWdcDi/3eVDRvGnoOB/CL
         5Q6FwQzQQQ+kxeC7AFpzCiUVFx+QNyqBzthAVsmKZ+laCxZKvfFHPnFs8UFcgX4ABwXg
         Cfhbn9Z2tN+jzg3ZE5DEP1g10g7vw7mGOT5A9XTCZyo17FN6Mq0A+uJ2Km48jkT6mJI1
         yQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UxOvR5LIzyVtZTJmDWWFfb2O4VMxlw2QAftQL36+kfQ=;
        b=C/ujP/wH+iEi/g2pLkAerM7mWoBKaw0f0FVgBZJbp974w2nh+ASI9t2o5ewNbA9TbY
         c0svNnYsk3omixhrmPUU/hSoCdOazHCGMOUhlk4xfa6nVb+oYSxR3+PGt8KfJ4KuVNSu
         j9427nFmN71PFaU8ILseL2sgYEOcMkiFsa77BkvVi8y8UWYEiO89ZqIurXHoMegRJm2S
         mE9JbF02g6u47l10fOppobjnM2AIyg52Mgp7jjmfuynNpC+ndG6cpEhO5qpoW/5T8hUz
         gtmsCrBb88hNat+4aFR0kNqg+STG7t2AyExte10Ix9CTz2Nq4SH/Mb4m1T00nhzkJMyV
         LRBw==
X-Gm-Message-State: APjAAAU3jzNrhhghx93hsZISTyxPAZ21eYYw3wqEKUrEtGaSuer2nwM6
        c9EwL2Efh9N+Wd78DZoTuKeACQ==
X-Google-Smtp-Source: APXvYqydf625L/OMl+GBJuJASVMTiLwzU2KEuPay3HT3ZafG7/KK7d/Fyj4QKYChsi53Jdq5r6+y5A==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr5935443wmf.28.1551975971116;
        Thu, 07 Mar 2019 08:26:11 -0800 (PST)
Received: from localhost.localdomain (146-241-117-61.dyn.eolo.it. [146.241.117.61])
        by smtp.gmail.com with ESMTPSA id o127sm5801797wmo.20.2019.03.07.08.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 08:26:10 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 0/8] block, bfq: fix bugs, reduce exec time and boost performance
Date:   Thu,  7 Mar 2019 17:25:46 +0100
Message-Id: <20190307162554.77205-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
since I didn't make it to submit these ones for 5.1, let me be
early for 5.2 :)

These patches fix some bug affecting performance, reduce execution
time a little bit, and boost throughput and responsiveness.

They are meant to be applied on top of the last series I submitted:
https://lkml.org/lkml/2019/1/29/368

Thanks,
Paolo

Francesco Pollicino (2):
  block, bfq: print SHARED instead of pid for shared queues in logs
  block, bfq: save & resume weight on a queue merge/split

Paolo Valente (6):
  block, bfq: increase idling for weight-raised queues
  block, bfq: do not idle for lowest-weight queues
  block, bfq: tune service injection basing on request service times
  block, bfq: do not merge queues on flash storage with queueing
  block, bfq: do not tag totally seeky queues as soft rt
  block, bfq: always protect newly-created queues from existing active
    queues

 block/bfq-cgroup.c  |   3 +-
 block/bfq-iosched.c | 786 ++++++++++++++++++++++++++++++++++++--------
 block/bfq-iosched.h |  87 +++--
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 704 insertions(+), 174 deletions(-)

--
2.20.1
