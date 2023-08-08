Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E7C41513
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 21:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjHHVqK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHHVqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 17:46:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7191E72
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 14:46:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6879986a436so1024260b3a.0
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2023 14:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691531168; x=1692135968;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwfgpA0q5iaTBOUpEBxbAN7dqDlF1eIK8XtzDLK2LHw=;
        b=jV0xS+l3GV71dqP3Nhb95LNVVItFq29aaqswYJ8OXn91vamWNXOoaFEeRIpn5GH0X6
         erx3U822JsexvvaRKikwZHjTqUI8WQmHazpV/045wqsM8h82rFEJchaym5pxme9BlKkp
         JNcmpF14MpgaTlldPkWBQbytA5YRzwl5sOxKXpfyODXT0VcJK5TyWeu9NEN8SAt59dsX
         btA9f4odc0LxpAG06YX9mLA5mmBOcY3C8GIUbAV11p4+uE0MN5Q/VCcRGKml86MhiMMU
         hgO76O3/JjM5xcEh7YDVqUyVgtueWBFp2cAH4ATPG/OkB/YtQXnvQTOe1M8VgfQetqxs
         zaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691531168; x=1692135968;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwfgpA0q5iaTBOUpEBxbAN7dqDlF1eIK8XtzDLK2LHw=;
        b=TvGeob3YLHZLJeiJBlVXMkYGrtGlUbyjo5h7TMLpJUpT0Sq9FCNlYfcknb5+RP+9o0
         7E7MgNKZHoXWy+EuJJtUEFcL552CD4IQhSS6RwdjohhM1tcHZXXsR0B/V0OQVgLfW6eK
         yOOeVLEqdyHB/VPDC4I/kKA3hXmZ6CMBTzCkQJAsbc3kEXo6d/ZMthPVDfEyDRIvYd3c
         raTEHkuGYu+VPL0EmMEeffe/ozCg40uFkouMzzj6X0kAEYvOLZjH3CIyXwV8hkWzkJBw
         PdK7mKqmrS6Aq8ZVS53MLk7gey9Vb4QsLKVmcKOadxyFO4b+V9a8uIxBsyTdrKANnD/o
         06Dg==
X-Gm-Message-State: AOJu0YxTIZAEDIglHSVssWDnO8sknR4avoK05H/geRwynn0XhuL9h1ks
        GmoaHVZwiiqZGZx3o2Mw0yLaNVZ9Ir3pg8ZDzYQ=
X-Google-Smtp-Source: AGHT+IHq8RWRJ6ZFb9EfZ1bID5BejwTL+tXFvnRXAefi/H1WyVxXA9rBf+ECEZKWgXMMCjsI41MPUA==
X-Received: by 2002:a05:6a00:2906:b0:687:95ad:d8dd with SMTP id cg6-20020a056a00290600b0068795add8ddmr878332pfb.0.1691531168403;
        Tue, 08 Aug 2023 14:46:08 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e21-20020a62ee15000000b00687dde8ae5dsm459819pfi.154.2023.08.08.14.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:46:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>,
        "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc:     Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20230804114610.179530-1-nmi@metaspace.dk>
References: <20230804114610.179530-1-nmi@metaspace.dk>
Subject: Re: [PATCH v11 0/3] ublk: enable zoned storage support
Message-Id: <169153116716.140710.16807799143266719730.b4-ty@kernel.dk>
Date:   Tue, 08 Aug 2023 15:46:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 04 Aug 2023 13:46:07 +0200, Andreas Hindborg (Samsung) wrote:
> This patch set adds zoned storage support to `ublk`. The first two patches do
> some house cleaning in preparation for the last patch. The last patch adds
> support for report_zones and the following operations:
> 
>  - REQ_OP_ZONE_OPEN
>  - REQ_OP_ZONE_CLOSE
>  - REQ_OP_ZONE_FINISH
>  - REQ_OP_ZONE_RESET
>  - REQ_OP_ZONE_APPEND
> 
> [...]

Applied, thanks!

[1/3] ublk: add helper to check if device supports user copy
      commit: 9d4ed6d46272bb60036a6539aae74eafcbbb3d2d
[2/3] ublk: move check for empty address field on command submission
      commit: 1a6e88b9593b63ccdfe1d84e3f99dd91e4f8d490
[3/3] ublk: enable zoned storage support
      commit: 29802d7ca33bc0a75c9da2a143eeed4f9e99fca4

Best regards,
-- 
Jens Axboe



