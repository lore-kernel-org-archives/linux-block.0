Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D49C43219
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 13:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiB1NlZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 08:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiB1NlZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 08:41:25 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163597C7BA
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 05:40:46 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so11387760pja.1
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 05:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=8AEAKRGq8N0ON2WXDBrR6DvzDs8wlyStSGQdnh6J7Bk=;
        b=4CGakBFMfUd91qW2Zea8Ay3ZXjgwkHfjpcl9oYfHzNaGzNy9R9r4qRkFRFSMGvdimo
         d9aOWeUry/nhwT9eUXWJ1Vq8+4yc3w7X6NAuRXJjoROQ7c/8yWVNI+d3DhywL3wrpXAx
         32iNRwgY85RS27y4NP7pvSzs09tLKp4y2lWzVSVRMGR1ee9agNNEKlLQSLHgXAiD/KGa
         ImzsQlTnd5LWZmoyQjG/sO6K1IwfA3qXlaxtn6GQvDtaMXf+X8T6a8lhnwP5cCVECV9u
         v/M/BeiRS7oDi9lLiRXD0lptuZtCWieGIRQ+JHh9uUhcZelgoB1r6XH1l02MbpWdWG3Q
         a02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=8AEAKRGq8N0ON2WXDBrR6DvzDs8wlyStSGQdnh6J7Bk=;
        b=EjJGmjPlN90DgVL+jkC01OEiUhAv8O6BJkDfcVpY1otep9JuPgjRyqLoNUywuZ6fEc
         de+I3D9xTM08yRlCKnmkGWijFvKMHlAPI73+wsnSNHJcAwSq+Y0IIIlN+BxwtEIycvPE
         W1bQCQCrjY1O88/s6b32iYNnHfubVN285In23XJ0J0axhXbuKX6g3ru0uyvESAxGUznM
         PYwCK/bV5Mr7wzI6IQmMowZrsbaY4Moew8Lus7QrD1lMKopyQTAPAfu3UVnqI438U+17
         k+KQqM4phENhDhzPa9wjMJ8UW5fGvZ84me51WWv1+H75PBvOwiVA1ICryCIQLZwSN7nZ
         ew0g==
X-Gm-Message-State: AOAM533utGUSKVHmiP2ZTjlBMLSzXXynM4nvft3eRFDmQVMFMMPF28lX
        Bb1mAad+V/7Nyo3JLijk95FFPQ==
X-Google-Smtp-Source: ABdhPJzDDppjzyaiKiUKTzeLYFsp1i6YXo3jAy8eqnS0f2r8SktthNeZeMeNsqYu6qmmYNsunIPtJA==
X-Received: by 2002:a17:90a:578f:b0:1b9:b03f:c33c with SMTP id g15-20020a17090a578f00b001b9b03fc33cmr16854315pji.114.1646055645500;
        Mon, 28 Feb 2022 05:40:45 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s2-20020a056a001c4200b004f41e1196fasm1085316pfw.17.2022.02.28.05.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:40:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220124215938.2769-1-ebiggers@kernel.org>
References: <20220124215938.2769-1-ebiggers@kernel.org>
Subject: Re: [PATCH v4 0/3] block: show crypto capabilities in sysfs
Message-Id: <164605564421.5266.4770347755442851079.b4-ty@kernel.dk>
Date:   Mon, 28 Feb 2022 06:40:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 Jan 2022 13:59:35 -0800, Eric Biggers wrote:
> This series adds sysfs files that expose the inline encryption
> capabilities of request queues.
> 
> Patches 1 and 2 are some related cleanups for existing blk-sysfs code.
> Patch 3 is the real change; see there for more details.
> 
> This series applies to v5.17-rc1.
> 
> [...]

Applied, thanks!

[1/3] block: simplify calling convention of elv_unregister_queue()
      commit: f5ec592dd3bcf7c91f7c262a7f5011e001d269cd
[2/3] block: don't delete queue kobject before its children
      commit: 0f69288253e9fc7c495047720e523b9f1aba5712
[3/3] blk-crypto: show crypto capabilities in sysfs
      commit: 20f01f163203666010ee1560852590a0c0572726

Best regards,
-- 
Jens Axboe


