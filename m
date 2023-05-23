Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1847C7EE2F
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 17:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbjEWRN7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 13:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbjEWRN6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 13:13:58 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A45B5
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 10:13:57 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7748e5302cdso198239f.0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684862037; x=1687454037;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0ImIQR3zwoiGK/W2JMZpBJW9daAl2CF4xlOmCVOKNo=;
        b=RiEVbS6C5syXRv8ymUZ11kTD886TzsaPcKLpiKXN7zbykvvgxrv7iN0N8G/5cjgEih
         Vtk1xzWEqG4pDAhTIHEksqQea2JiIwNAl9zY6maYDu4UjQQKrz2InsVJdKhGPFQCmrWU
         33HLirhMJzouC8WunHfHcc7pudTdRPr61SOHEd+k4VCSoQnUfq0WjEnCgxYZhuE2Ibqh
         TF9avfSiSQMe7SJxhDLK/Lpsz5eccC4sQiFYr0M7jXPAEeuxh3l2aSXriS1DXLret/+t
         DYqy7iAPR8pFwe/uKosxCHkYgYOHll38fc4DnhRMuD4Hlfo8wAes1fc2CVzzruK1Vuo9
         VyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862037; x=1687454037;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0ImIQR3zwoiGK/W2JMZpBJW9daAl2CF4xlOmCVOKNo=;
        b=R4ewXrEgfsz7RiacSFeqtjkUJvAfMJmz27l/R+uL1u2ZHWdUpzSg4DZjG6aZeM3yoJ
         MEV12jKsQcfxr7gYplTmmktROAaIhEI0spGkJKDW58tiCjxFvpaZCqXg05cKMb9a/1ZL
         0Ydng/CaviSvNqJEV0HxcUsvdRnwdnE/hKq2GMvc6ZL/VMVXpqiefG6tQd0WZQZmqjTs
         fHsAyR2m4umjzHiJSXQUgAUDX59D/Ustkqg4tWSu0iTZrZ+T5Pro+GNIYsHzr574YpqV
         4n3GMvd/DGPO82XU98fH03dEFdjEhvxPVCW6ckm7WNg7BEy48ouNqS6+DmC+WpmTIbgw
         a4OA==
X-Gm-Message-State: AC+VfDy3sE+RLFZY28XZkFQhg4f24pWZpGVIJcnnSst5JZxuJR3vZ3mn
        ijxR23gk09Qwv4OvAi2jP+q3Vg==
X-Google-Smtp-Source: ACHHUZ6/nh+iiXM/pQe7fODjDim+nORQA9CbnD3QtFeUirhUj0Vq+jLYmLpSCPWfST9dQKHgsnIPMQ==
X-Received: by 2002:a05:6602:889:b0:770:4c3:cd0c with SMTP id f9-20020a056602088900b0077004c3cd0cmr7605348ioz.1.1684862036947;
        Tue, 23 May 2023 10:13:56 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a02aa87000000b00411a1373aa5sm2524580jai.155.2023.05.23.10.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:13:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     john.g.garry@oracle.com, Tian Lan <tilan7663@gmail.com>
Cc:     linux-block@vger.kernel.org, liusong@linux.alibaba.com,
        ming.lei@redhat.com, tian.lan@twosigma.com
In-Reply-To: <20230522210555.794134-1-tilan7663@gmail.com>
References: <a11faa27-965e-3109-15e2-33f015262426@oracle.com>
 <20230522210555.794134-1-tilan7663@gmail.com>
Subject: Re: [PATCH 1/1] blk-mq: fix race condition in active queue
 accounting
Message-Id: <168486203574.398377.4594793053097538196.b4-ty@kernel.dk>
Date:   Tue, 23 May 2023 11:13:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 22 May 2023 17:05:55 -0400, Tian Lan wrote:
> If multiple CPUs are sharing the same hardware queue, it can
> cause leak in the active queue counter tracking when __blk_mq_tag_busy()
> is executed simultaneously.
> 
> 

Applied, thanks!

[1/1] blk-mq: fix race condition in active queue accounting
      (no commit info)

Best regards,
-- 
Jens Axboe



