Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4473C433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 13:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242834AbiBHNzC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiBHNzC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Feb 2022 08:55:02 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ABAC03FECE
        for <linux-block@vger.kernel.org>; Tue,  8 Feb 2022 05:55:00 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y5so18043178pfe.4
        for <linux-block@vger.kernel.org>; Tue, 08 Feb 2022 05:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=30us5nxyL6oI9dDszE8BvRVfqJo3mI1FKcFQiRSZ5Js=;
        b=rBy+0HGJYt/kw9M5uK0zWmJamGTlO87v8akRPQABOX3rNd9PPG9DW7sX+ar2McLpKJ
         NbNeuLNZ6G4kYtW+bqUFzPSZ5Hv07bYP8DUB3PzXE4KTorvy5MQ4vA45pc2u5wCe0PVu
         AZda4c4Kj/5yXWl4HdnkH/mPcAvpbfugcA0zBikNl2IYAhcW45HSfzLSt1jcIiW6Ov08
         HsF4ZKDNLnofdJh8X9DLvEn5ZkGdnBbky+l10pbMuoPyPjZ79T30QscDV7WF60vW+UJU
         CdZuXOxC2bsRDBIuVjk7XjcfTsmoBJpnDihrg1sb/9Qft4UGaFbC/PcvJ93k/2qdCfE0
         CWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=30us5nxyL6oI9dDszE8BvRVfqJo3mI1FKcFQiRSZ5Js=;
        b=FvQfk+kwHmBBtFF3n6lLBNhUyzlHV2NFq8dzUUgIAzZV/cr6z0RIISQChhTjlCZF3v
         SVaqm4+8+fyfhI1tknv3MhXDALtZdsb+/fXAE7Fw0TMybxKaQshzmi1IEulJjv7762Ee
         hmC260OJp+q2pJuZ9xSGGd9gKIYHTzFGSSa/ZvD/10rKbFjb5sV8fQO+/PzB0i3PXrho
         1skRdfprHmTI1nCwU3xbRDqRjQ5TECQuW/LCQ4YEzfoeYRUSg8OxFIwDW7a0fdRowqNA
         YjoW6tszI7NaH+rbRoYcYiAHOJWoFZUj5IwEoim7ISFk07JYkPid7SNSGXpSi23inZib
         veyg==
X-Gm-Message-State: AOAM5309MPGGC1kmzgmuzoE7pEIv6ioSWNy0+styxjttKHFlaeZIRNU6
        HCubqJ4ZZEcl5Lx3FPHyoEzTSL8Neanvpw==
X-Google-Smtp-Source: ABdhPJzgdD05VhkNp9xgJBuuJV1CWHDtzvIEiJe63P8OJ1XxmwpDPmiV/4SkdKTOfpVp0wCZtL545Q==
X-Received: by 2002:a05:6a00:1c99:: with SMTP id y25mr4623311pfw.17.1644328500274;
        Tue, 08 Feb 2022 05:55:00 -0800 (PST)
Received: from [192.168.1.116] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e8sm3063958pja.9.2022.02.08.05.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 05:54:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Martin Wilck <martin.wilck@suse.com>
In-Reply-To: <20220110072945.347535-1-ming.lei@redhat.com>
References: <20220110072945.347535-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] lib/sbitmap: kill 'depth' from sbitmap_word
Message-Id: <164432849902.112367.4722641037594849052.b4-ty@kernel.dk>
Date:   Tue, 08 Feb 2022 06:54:59 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 10 Jan 2022 15:29:45 +0800, Ming Lei wrote:
> Only the last sbitmap_word can have different depth, and all the others
> must have same depth of 1U << sb->shift, so not necessary to store it in
> sbitmap_word, and it can be retrieved easily and efficiently by adding
> one internal helper of __map_depth(sb, index).
> 
> Remove 'depth' field from sbitmap_word, then the annotation of
> ____cacheline_aligned_in_smp for 'word' isn't needed any more.
> 
> [...]

Applied, thanks!

[1/1] lib/sbitmap: kill 'depth' from sbitmap_word
      commit: 3301bc53358a0eb0a0db65fd7a513cd4cb50c83a

Best regards,
-- 
Jens Axboe


