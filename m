Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDE7C433F5
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 15:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiCRP7Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiCRP7Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 11:59:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA89103BA3
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 08:58:05 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z6so207562iot.0
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=qIou9S2/2FdgCJ+90Zh1nkJgQgucyihEJO5ekj7gDiM=;
        b=F7CdvJhnHxN37PQimfnJQGlQ4jrkDXnnnpim4W089RjWasOAIxK7TsNQfrZzXUfOun
         43ERJ86zzQ0rz7HR/tZQyUNRV79yqzZakrK674eiUhfuJYTnj8z5saK9cFvWOssDVpIu
         EgCeAQcYRhDxtexBGcQq9SUVqE/2e+70hBP+vDALsg0oAMNDA65vDbePwz9ZkLtsXeFo
         3rID+wdkbc127JmOXNVNn7iRB101vGNoGVyZkZjgyCf8XffxXrFTWeCL//z+0xXBOkbh
         Kn1uYdntynukfqwPqYGJhjr8tDUQQSJX/MDa3+gzbY/tNR16g0ZY5B4YBmMS2QYdQu+W
         Y1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=qIou9S2/2FdgCJ+90Zh1nkJgQgucyihEJO5ekj7gDiM=;
        b=DKBTKZjLg+wMSdVdwpHX0kiyV3lKrlVAvbiO11vE2xrk/7IH2lZ2eUmg6wElUBlEwL
         0oWSu1lULN5vvE/Dq3KLYbx+qqdQmhehJjevGcNZLnWpYrBw1BfZcq5xELjn8w2+XLFl
         dT+DsS1qc5kP+eEwLYjG8ErkD9qIov69B2W1Q0O0e7SiBhiM4qw7KS0Bw3J/OioRu6CX
         RKvjDC7hufLiqPYbaizCw/30rEBVtbX1Th1zCQPcwbQtK+0G7SJsOE4SWQtUVCQQQHgz
         8sa/jd/O0nboBMAlLE4MoSjRVEDCbJMFFX7QW+qRpvX9ivsunjqgcGP/qdO0rIDpM9gx
         dEfQ==
X-Gm-Message-State: AOAM531ZC9cbmueQELsqeuw7uTW2JZjzJ8OKpv0V3q3NKhj/LxjVBrpa
        aw4Cm2xPdQDMU/6Wk4ueoHyr4S4t0YXHxGVz
X-Google-Smtp-Source: ABdhPJyANfwEn3Pez+yVoCrbh2Tvqwk1OGbcYPl0ApR3pvipTVzYYniofEGkFZ08chSg9wveMr3ehg==
X-Received: by 2002:a5d:8898:0:b0:645:e689:3381 with SMTP id d24-20020a5d8898000000b00645e6893381mr4806108ioo.179.1647619084238;
        Fri, 18 Mar 2022 08:58:04 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b12-20020a6be70c000000b00648f61d9652sm4377844ioh.52.2022.03.18.08.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 08:58:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai3@huawei.com>
In-Reply-To: <20220318130144.1066064-1-ming.lei@redhat.com>
References: <20220318130144.1066064-1-ming.lei@redhat.com>
Subject: Re: [PATCH for-5.18 0/3] block: throttle related fixes
Message-Id: <164761908367.95320.5410030281959937015.b4-ty@kernel.dk>
Date:   Fri, 18 Mar 2022 09:58:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 18 Mar 2022 21:01:41 +0800, Ming Lei wrote:
> The 1st and 2nd patches fix use-after-free on request queue and
> throttle data.
> 
> The 3rd patch speeds up throttling after disk is deleted, so long
> wait time is avoided.
> 
> 
> [...]

Applied, thanks!

[1/3] block: avoid use-after-free on throttle data
      commit: ee37eddbfa9e0401f13a01691cf4bbbacd2d16c9
[2/3] block: let blkcg_gq grab request queue's refcnt
      commit: 0a9a25ca78437b39e691bcc3dc8240455b803d8d
[3/3] block: cancel all throttled bios in del_gendisk()
      commit: 8f9e7b65f833cb9a4b2e2f54a049d74df394d906

Best regards,
-- 
Jens Axboe


