Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3C3C433F5
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 19:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B8361101
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 19:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhKCTcE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 15:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhKCTcE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 15:32:04 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E83CC061714
        for <linux-block@vger.kernel.org>; Wed,  3 Nov 2021 12:29:27 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id x16-20020a9d7050000000b00553d5d169f7so4985585otj.6
        for <linux-block@vger.kernel.org>; Wed, 03 Nov 2021 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Y3d6E1SHGhXJn4Dvk0e2wYnCWALGfieMsoRHb/exO38=;
        b=Nlpj9VQg9J9S4S48NzQMds56GucWKbqxz1cKoQevhTMAyjBD6P8S6lpVHh7hCKXk8Z
         ubvCBQZIhFNRl75oWDVIjQU86EMiV5BhFO4w0FanEa2QNigig0oKKWExBqrHjOxyfbZD
         x4AaeV2afFFIW2IAMXWX4paB5XyrVb/Uj4cGO1tMbtbwEDT6wDMYYwljYiyX6/tslQUV
         8LEDllACSnwAVIXM1ijiEaFVt5mYJnLQ1pujeRWntcFSPR4ETsIliUxJFSTLCUzkcly1
         wzz2jUT2upPO6voi4OfJ1Xs0INnNeCOy3lE3XgpYnKijSpinp+ba1DsNqikIJMr0lLkr
         b6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Y3d6E1SHGhXJn4Dvk0e2wYnCWALGfieMsoRHb/exO38=;
        b=e5LRr1PuhF5NK/yxhX447qlyKZoYIYuyqF7o/gcYhIcJXauWmLkZu7AzhC67EL9+dA
         KSJ1Iyk0ENuqgqLruHxgo33OQ1inDr5okuYOwaSvqk6tY5kGWSbWsNCVaItpPGjXROeb
         7da9iJYLmk/IeeKd/OP6B4tK8tnmVYQn2SvpvCtXq8gluOOHhuYvkkIXYR55Hg4wtXF+
         m/3OK0dmsm4T0f6MqLQPuiPScDPK2lWFhHK6okrFlimQMRFLZKL0f9uroYJYvw3Yqtra
         Rnrn2gD7+tvhzivycfDWNY7D1ea2ZyEVNKL9VYB+ZiqM3ZajRbU7i0/bSArfOd7vSPq+
         K79A==
X-Gm-Message-State: AOAM5315z9qGfeLmWxuJLAX9Jq2Uu40GG8qmSRBQ5Ts09xIIoqD/LJVe
        lbrasuuJJfZVcNmxFzDQlQUuNQ==
X-Google-Smtp-Source: ABdhPJyQzzTX1UgPm7SvPYQQRUJBgfitrA3qciUqirF/PD9KbBoSKsEuMnzT7nuMc4W5j3DiZHufsg==
X-Received: by 2002:a9d:70c4:: with SMTP id w4mr21718621otj.78.1635967766484;
        Wed, 03 Nov 2021 12:29:26 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z13sm748257otq.53.2021.11.03.12.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 12:29:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     vishal.l.verma@intel.com, ira.weiny@intel.com,
        dave.jiang@intel.com, Luis Chamberlain <mcgrof@kernel.org>,
        hch@lst.de, dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
In-Reply-To: <20211103165843.1402142-1-mcgrof@kernel.org>
References: <20211103165843.1402142-1-mcgrof@kernel.org>
Subject: Re: [PATCH v3] nvdimm/btt: do not call del_gendisk() if not needed
Message-Id: <163596776548.186543.8354031131670153996.b4-ty@kernel.dk>
Date:   Wed, 03 Nov 2021 13:29:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 3 Nov 2021 09:58:43 -0700, Luis Chamberlain wrote:
> del_gendisk() should not called if the disk has not been added. Fix this.
> 
> 

Applied, thanks!

[1/1] nvdimm/btt: do not call del_gendisk() if not needed
      commit: 3aefb5ee843fbe4789d03bb181e190d462df95e4

Best regards,
-- 
Jens Axboe


