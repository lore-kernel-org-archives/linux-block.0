Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D72C31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C5E2168B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="CmA0VwwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfFNNpF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:45:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46764 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfFNNpF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:45:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so2426012qtn.13
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2019 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OoE9TTwZ2oX4l67lO4UKKcsLXQImUKGP20eXDpNCJrQ=;
        b=CmA0VwwEqJigtFceHJxQeYm3whQH2/+4pEJ/T/TOOR81IIrusYRBFbvLnkk2d8y9zK
         n1zgsO3A3KhD6bJjzcoi53PSKIjlVu7yoeqsxOpjp0j0dLgQPuSs84L29BAT52XfCqPT
         0l9Luwh6m1xaqa5JgO0hohC6Kgb3fA6L1z+xJnvYDCe1p1/uQVjEmDenWKlttKNMi694
         O2zTv0sNHEM8H6IXKqNLita+OS5cAnoiCLwBMN8+xxSjPZvbkjNWrxPhgBUR84mn84bD
         iTnsipFfh1WbMAjWOuKPoxmuL5PsSVfcthoirTwInDvf05QM2YmJfPADbHinscIK24+J
         HwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OoE9TTwZ2oX4l67lO4UKKcsLXQImUKGP20eXDpNCJrQ=;
        b=uHNF4EUQhI0+Ml8LXh60p3E8I2mnV2EqtPzfieKNC1EqrvaMflD755zWtvmHdooaa+
         AmAzJEzyPQoUVDW3znu33DSMqmy5JgifLEaSFwps0ZPjy562JdvKdfvU3jCO2xOM146O
         rFxpbIweCmZkTAVGwpL3jwH+RAg3Dk49r0oH62vqoEwf4Y2dbRRWATlWaZrbg5WhoILH
         5foJmgDYDojTfwziGApztlRCBDyshh6MiqpjAOkqhVWieJTNqIYE5SAwy1JiXVnYVBLK
         DCqPamXhJFHI4ETwkRvddTwwT/E2yABrRWNyDGYE9Gtcv9gONZkfaowujy2MGyAh7bTk
         chGQ==
X-Gm-Message-State: APjAAAWGS3I7e3iWNLnhyHyMfCK6dVHNk7NosTdpHQRfiGMWd1LCV0lO
        S4CcaQCvUqU/07ICT+fVu/K5/g==
X-Google-Smtp-Source: APXvYqzK0goCeSYPjF5bhIPBakUW9p6CVwC+vyGH1n/OjNW5KJjnzAEtFGiENd0PQTCzCI2Gq26ImQ==
X-Received: by 2002:ac8:374b:: with SMTP id p11mr77934298qtb.316.1560519904543;
        Fri, 14 Jun 2019 06:45:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id c30sm1843863qta.25.2019.06.14.06.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:45:03 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:45:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/8] Btrfs: stop using btrfs_schedule_bio()
Message-ID: <20190614134501.cjnrsb5n6jtteqex@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-5-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-5-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:46PM -0700, Tejun Heo wrote:
> From: Chris Mason <clm@fb.com>
> 
> btrfs_schedule_bio() hands IO off to a helper thread to do the actual
> submit_bio() call.  This has been used to make sure async crc and
> compression helpers don't get stuck on IO submission.  To maintain good
> performance, over time the IO submission threads duplicated some IO
> scheduler characteristics such as high and low priority IOs and they
> also made some ugly assumptions about request allocation batch sizes.
> 
> All of this cost at least one extra context switch during IO submission,
> and doesn't fit well with the modern blkmq IO stack.  So, this commit stops
> using btrfs_schedule_bio().  We may need to adjust the number of async
> helper threads for crcs and compression, but long term it's a better
> path.
> 
> Signed-off-by: Chris Mason <clm@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
