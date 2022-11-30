Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65480C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 18:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiK3SJZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiK3SJW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 13:09:22 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B31837FB
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 10:09:20 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id q21so12851170iod.4
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 10:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XS+6eK6sqFTnF9upSPizw27nH/W7NsnvcHiGtviZZKs=;
        b=ufJFfvrGXhOUjKAFpGp+19sYd38G3J5p/0qAff6W5yQLgEGCVfJDwU8e3eR9bppSVX
         cGtMDB7o/JEizhfmNpgqzZg4Eht73VhUhP4lPG0iUL9vTqQT7XeTR/owBAqekzJF5T/g
         hOFeD/F2XQ5SkHz+FfFHHKmkTEP8urIEbx1WmplrGCTnwu2Pzr4sEZFx7WJXXSBgPi8O
         PTgH+vDkohAPSt6TwOyxRrNz24GHjSkiB6KzCtCE3adp5dEJsV75TumSPn0018P4ZGGR
         pXUselvX3Z14lHw9W+yZP7uJBDsbdEA/UgQNR/Lxnn21wwA0ldGRCzLpuioAAyApflYR
         1YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XS+6eK6sqFTnF9upSPizw27nH/W7NsnvcHiGtviZZKs=;
        b=mw35TWRg5acC5EaIstVOKF8ykzhgeaWoFRlG3/IYXYoCyWkaZcMh+sxb9W/uYRGvhr
         VbTl19PzZyyg2tNOqZL0DbIwX51BeNEgcf3o8BBs0eIkoNImLBruIP198RphFw3pnQQC
         tJ8PAUljMWu5CwWBuksYdaSADemWhLnyRH+59JNi+sYlwcUXit0e0Qaz4Llq3gc5jbMl
         2hebhDAozyJtXTjXnSpMRedm8A3XSn9oxKUje8be1RlfccAaJJ7jCchF8zu+cWSJjWAf
         fryXZXoEBtWuScAET72piKWN21cuw192RmrMLE0M7EZhjUXTfwblrKhG/0sW5QG8SIRi
         UaOg==
X-Gm-Message-State: ANoB5pnIF1wNRbh2WaV8UU+gUgB0On2AQgX0Zex6hu8v4bumySEEbmQs
        TVTCKKQVLOJcESoHNa+Ui+iWv9QxXqAKZhOV
X-Google-Smtp-Source: AA0mqf4Xf64zZgFEBWU0LRNZCGhn4k9fSO5+Qx9uinShhYDJAtDlQc4QoPJOZPW8EAOQ3HJE3MmF5w==
X-Received: by 2002:a6b:4402:0:b0:6c3:996b:5960 with SMTP id r2-20020a6b4402000000b006c3996b5960mr19750668ioa.169.1669831760099;
        Wed, 30 Nov 2022 10:09:20 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a14-20020a029f8e000000b003755a721e98sm823231jam.107.2022.11.30.10.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:09:19 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
In-Reply-To: <20221114042637.1009333-1-hch@lst.de>
References: <20221114042637.1009333-1-hch@lst.de>
Subject: Re: untangle the request_queue refcounting from the queue kobject v2
Message-Id: <166983175906.206850.16388085618879790592.b4-ty@kernel.dk>
Date:   Wed, 30 Nov 2022 11:09:19 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d377f
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 14 Nov 2022 05:26:32 +0100, Christoph Hellwig wrote:
> this series cleans up the registration of the "queue/" kobject, and given
> untangles it from the request_queue refcounting.
> 
> Changes since v1:
>  - also change the blk_crypto_sysfs_unregister prototype
>  - add two patches to fix the error handling in blk_register_queue
> 
> [...]

Applied, thanks!

[1/5] blk-crypto: pass a gendisk to blk_crypto_sysfs_{,un}register
      commit: 450deb93df7d457cdd93594a1987f9650c749b96
[2/5] block: factor out a blk_debugfs_remove helper
      commit: 6fc75f309d291d328b4ea2f91bef0ff56e4bc7c2
[3/5] block: fix error unwinding in blk_register_queue
      commit: 40602997be26887bdfa3d58659c3acb4579099e9
[4/5] block: untangle request_queue refcounting from sysfs
      commit: 2bd85221a625b316114bafaab527770b607095d3
[5/5] block: mark blk_put_queue as potentially blocking
      commit: 63f93fd6fa5717769a78d6d7bea6f7f9a1ccca8e

Best regards,
-- 
Jens Axboe


