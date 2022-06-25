Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF67C43334
	for <linux-block@archiver.kernel.org>; Sat, 25 Jun 2022 17:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiFYRCR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Jun 2022 13:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiFYRCO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jun 2022 13:02:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED491582D
        for <linux-block@vger.kernel.org>; Sat, 25 Jun 2022 10:02:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 68so5198047pgb.10
        for <linux-block@vger.kernel.org>; Sat, 25 Jun 2022 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Uo8r7jaeXJCq3QIZ0vAJ51L7HUV3izy1Z+WQ7B03Oi8=;
        b=pZhzvQ4548eA6jJkBT7zvGQ75hKg8K9pCfEQDHPRvamHIzUJA7ZWB4Yn6BjIFzRIms
         09kMpa43mGR9+YvQujfvJAXYSnVC3n91xNrabtc8CN/HEK+6xCoA320D9G4RKC8Qpiz1
         cJKkfiSMdBtKMaptm2/d5MYTQcVxMSfaNmP9oi+ZZn+Xoa9AEB0hHthtCtm/zl2hDTBV
         C6MzI3TcrzGCL/v7FqT6+vKpNFVO8GZ95iHcEIi47EGpAFMKhqmFlejD8LLEK1XN8NiW
         c2eGrsIv/wSd+dRQ1KuvTTKW3k49qaCXtim/7Q0F6x5Wr80kLSwoYMVOCOwDodRrTW9i
         Kpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Uo8r7jaeXJCq3QIZ0vAJ51L7HUV3izy1Z+WQ7B03Oi8=;
        b=PXjsyhiyp6qf24YIlp0V1kfePwGaYx/WfVxbCGazig8orwR5MLeoeoeDVwENWjEcVO
         QvtyB4AJqRdEMAto9JXeJEgdS8wbfvDTTQziyncMdUC1LxYrYTUYRZB1A5gvKMoq58wh
         yZDe4+NaNxMzinnx90fJu5CwJ72Tjc8xGhv/5ArCkMMsx18XSet0/LUy592OLaxqa2G/
         tlm/RLfhR6KtCNHL//vekSP5h7R9YHg/mAJEoC6tgfuswCtArN+rcOYihrOy8AMGjxeg
         YdDiVGZ+VknHFQdDlDDSSYTE03b64givqA7SFzhmKUMIMAsE3K5qQtDhJnAMo9iQRDqp
         25WA==
X-Gm-Message-State: AJIora+jXA8WfITw3ozo40CQUIY9ibvzkxN6VKNWJhcdMvdIt3VyaSR5
        YQEU60xBItd2QzZl+GRjlZiPBMcQb+Qs+g==
X-Google-Smtp-Source: AGRyM1vrF3iQcWjggh7qw8aOq6pSwKRJKGD6Yb5p1tLhhdMqnBxCnKCccGZNFcEfV4FEhqJW5kNchQ==
X-Received: by 2002:a62:f846:0:b0:51c:17b2:60de with SMTP id c6-20020a62f846000000b0051c17b260demr5152067pfm.76.1656176532419;
        Sat, 25 Jun 2022 10:02:12 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h6-20020aa796c6000000b00522c8fb04adsm4021088pfq.176.2022.06.25.10.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 10:02:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     liusong@linux.alibaba.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <1656170121-1619-1-git-send-email-liusong@linux.alibaba.com>
References: <1656170121-1619-1-git-send-email-liusong@linux.alibaba.com>
Subject: Re: [PATCH] blk-mq: blk_mq_tag_busy is no need to return a value
Message-Id: <165617653157.122304.12714727771375329885.b4-ty@kernel.dk>
Date:   Sat, 25 Jun 2022 11:02:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 25 Jun 2022 23:15:21 +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> Currently "blk_mq_tag_busy" return value has no effect, so adjust it.
> Some code implementations have also been adjusted to enhance
> readability.
> 
> 
> [...]

Applied, thanks!

[1/1] blk-mq: blk_mq_tag_busy is no need to return a value
      commit: ddec07b1ea26063d77da908cbeb8146fe57d4370

Best regards,
-- 
Jens Axboe


