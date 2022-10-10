Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91246C433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 14:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJJOtV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJJOtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 10:49:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ACA72852
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 07:49:16 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h13so9530723pfr.7
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMtLwE5hEScjZzSAhrd8HUgskrcWzQHeKKqzQbt11Jk=;
        b=nWoMTjM94zP+hYYEVzbIUrdxJiBV4OTv1Q4dtToRtjT+ZJMtxynx3f9L7HiQ4sNL1G
         z6r34Qp8aFUPQ9SK1GTwV4uW7AyTQRYAuH0Qf05UF04jhUB3HdoffDasH0ECVVfDxDGH
         nNbaLr17b58+AN5VgMRDdE3G3/U6RntptWOZeIp+TgRn3ZDMjLS8Rwbretewl2zozwox
         oD0U4xRQsX8NZNALqePHd7X3QU5X1w539JSsrhVNCynkMHAhVSQn3ibWM18t0oy9q7cT
         hEMLtBRWzgy4YR05FCIR7aNYTj/jDL+Uu59TuafuhIyx1HpBvAzFu5cxrd5aBkmiamvZ
         03cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMtLwE5hEScjZzSAhrd8HUgskrcWzQHeKKqzQbt11Jk=;
        b=Y3lDV8g0W5xh0v8IeqZD6gpK3yj9OnxHGj1Vd3QJMEUOQLnbT0neMDG3c8e3+gNv99
         46Kevuwp4v6/ZQEnid+ZOZb0cQMMczS3zfqYYYcb0YG7F9fgSvpLjUsELHMo9iemC8wy
         TOdNidwfi60ITL4bSv6XEmiuTqa/IryzJjm9AHNe9g5PW+9425Fe3gvJ3rUUO3ADbVEz
         c9U6govUqhV7BsZxK/hgtpihNwIvMSKdjGPDKmMpp/Ywe3x8gEezcMwQB6AO2e2JGXKF
         +nWmb66g6XFcVkkmP4OYh38UFroCjghpfdLwXIwPiq9i8Alng3j72+5jpJi5t8qTQ3hN
         jBGQ==
X-Gm-Message-State: ACrzQf3DIz7KkVb8dXoUGBjupKsrjCNxOU5vHsk/dY6fq3X1Ec39EUzW
        qpE3ZieJ3xIuCHZRvTv4nmfnhaji9GeEVi06
X-Google-Smtp-Source: AMsMyM4gC5HzSGrccAZ121wn5xguU6BuyPshrkHr97SmW/Cb0yAOzO21BlWmd6CJmhkWqscf1gfaxg==
X-Received: by 2002:a65:6bca:0:b0:420:712f:ab98 with SMTP id e10-20020a656bca000000b00420712fab98mr17031931pgw.350.1665413355304;
        Mon, 10 Oct 2022 07:49:15 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a02c800b0020a71ca2cb8sm9212588pjd.56.2022.10.10.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 07:49:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org
In-Reply-To: <20221010131857.748129-1-hch@lst.de>
References: <20221010131857.748129-1-hch@lst.de>
Subject: Re: [PATCH] block: fix leaking minors of hidden disks
Message-Id: <166541335450.5340.12319693019784412348.b4-ty@kernel.dk>
Date:   Mon, 10 Oct 2022 08:49:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 10 Oct 2022 15:18:57 +0200, Christoph Hellwig wrote:
> The major/minor of a hidden gendisk is not propagated to the block
> device because it is never registered using bdev_add.  But the lack of
> bd_dev also causes the dynamic major minor number not to be freed.
> Assign bd_dev manually to ensure the dynamic major minor gets freed.
> 
> Based on a patch by Keith Busch.
> 
> [...]

Applied, thanks!

[1/1] block: fix leaking minors of hidden disks
      commit: a0a6314ae774f8a5e52a599946aa2ad0db867b83

Best regards,
-- 
Jens Axboe


