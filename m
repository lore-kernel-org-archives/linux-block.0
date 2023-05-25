Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF700C77B7A
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 14:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbjEYOyh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241064AbjEYOyh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 10:54:37 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00316187
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 07:54:35 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77479a531abso16545539f.1
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685026475; x=1687618475;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rSHBWkBgS2mm8ALT6WvzGN5/+TkGxD7ynUj1kfMsBQ=;
        b=xbd0kecRRx+9NWW2PIoMEfqgPX0CRT1+PNfTWRD27rP6SGjEA08oc2g1ig6qytqArt
         hxT8emqjIMV+G/8/gMmi49z+HQ/9tAjIdEyPo7LPANxGF9HJoYnm+MLwMWFygdBh3uQ2
         lyw0gvPILXzUW6eI2WgP4+TIOmIxnj5pQYVGXlUGwOP2hxzwqn1DtoLLCDApR2lY50+w
         DkNLqerJzwQT2iG5CfgwyEf5ehHUQTVjkHw5EUGwRzB9gemxMQtul7GDRdUHW3c1KkTH
         OH5Md4o2jll6AEZql2Yoxq2VZawK2EbwkhemknYhEfew0w/vKszegAFX5NxaHMt6fou4
         T39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685026475; x=1687618475;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rSHBWkBgS2mm8ALT6WvzGN5/+TkGxD7ynUj1kfMsBQ=;
        b=BbnsMo68SFOPLzcYVeRSDEgbe7xsY6iRgvv4h3R4zLobnC30y+CvIhTqhx/V9UoPt9
         ju81qbtOAfGNc3KoAHh0UhFZGBvD6T0D9qGZCmf7pbB3nCHdv0KiuPRrQedzM/IqYYZI
         amTV7E/cDiQooUboDDgphTBxDWmXqT+vrKGIpe+cS0xmcDSK2dEN+8SI2B4KcH3HpPNd
         lWtuxyiZf0lDxN6ZU6seCADaesVucmLPxwzYkRBfAeaZcOZ3S7ZrIhffCMd8A+z9/MjU
         yt0dFSaO9m7OvcLkPODa7ZIFzgt4CumJWS8V4KJJ+e2O+SGqAIQ4u49oWo6+QPwsrRv6
         o6mQ==
X-Gm-Message-State: AC+VfDyuDzu5qRf9dBUPH5YsuZLPoZFrroIDJwwM8+a/tc5UFGzYwweO
        Pm1Gjla87kAWQ0CBBjaISL4ObgF+SMHQ2ScZEnk=
X-Google-Smtp-Source: ACHHUZ7LB78/pRUlJbEGNmv97WHmzS3adTxZS+I/k6g+L59//3zumtt9ceLdjobbR+UUxoF4QMs8NA==
X-Received: by 2002:a5d:9d9f:0:b0:769:8d14:7d15 with SMTP id ay31-20020a5d9d9f000000b007698d147d15mr4546756iob.0.1685026475368;
        Thu, 25 May 2023 07:54:35 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ei24-20020a05663829b800b00411bf6b457bsm480532jab.101.2023.05.25.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:54:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc:     kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        joshi.k@samsung.com
In-Reply-To: <cover.1684154817.git.asml.silence@gmail.com>
References: <cover.1684154817.git.asml.silence@gmail.com>
Subject: Re: [PATCH for-next 0/2] Enable IOU_F_TWQ_LAZY_WAKE for
 passthrough
Message-Id: <168502647392.717124.7925068931544884226.b4-ty@kernel.dk>
Date:   Thu, 25 May 2023 08:54:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 15 May 2023 13:54:41 +0100, Pavel Begunkov wrote:
> Let cmds to use IOU_F_TWQ_LAZY_WAKE and enable it for nvme passthrough.
> 
> The result should be same as in test to the original IOU_F_TWQ_LAZY_WAKE [1]
> patchset, but for a quick test I took fio/t/io_uring with 4 threads each
> reading their own drive and all pinned to the same CPU to make it CPU
> bound and got +10% throughput improvement.
> 
> [...]

Applied, thanks!

[1/2] io_uring/cmd: add cmd lazy tw wake helper
      commit: 5f3139fc46993b2d653a7aa5cdfe66a91881fd06
[2/2] nvme: optimise io_uring passthrough completion
      commit: f026be0e1e881e3395c3d5418ffc8c2a2203c3f3

Best regards,
-- 
Jens Axboe



