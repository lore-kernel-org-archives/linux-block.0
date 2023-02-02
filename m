Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEED5C636CD
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 02:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBBC1E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Feb 2023 21:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBBC1C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 21:27:02 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD31A61D75
        for <linux-block@vger.kernel.org>; Wed,  1 Feb 2023 18:27:01 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id cr11so228334pfb.1
        for <linux-block@vger.kernel.org>; Wed, 01 Feb 2023 18:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiMtQj23ENw49UryLu6SrjWnqGm22IzNvPe5medc/7M=;
        b=WbOL08Z2BiMadWnVgq/vAXN0TheSeU1uFVNY9h1TBweXcJ3WUanQS3ZpLFVYZwzZC5
         Wlw1DuzPL6DBBop104BVL5dBgWt9fSeWzhZAvvC2Zlhvgfn7HEIhqkHcNnjsyh8kTt5w
         nnf54FMRPysUZ/5DX+CLeH8VfjKbSLBY6ikAMbAdITlg8wiTaAM3hfse03vjMVZUr03k
         z66rJw+gq6NUuIbwR5URqFxsdNs87lOjLn20lFS3psj4QQ2Aul/NQvUOjdu7gwP1s263
         fcCqjt68F4uyyVFvmZpEusAN8SSEbmSSd9lrVJKC4Lx3GltPrcGPbumS+vfStjhdiQmu
         cpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiMtQj23ENw49UryLu6SrjWnqGm22IzNvPe5medc/7M=;
        b=gf3ZMSMLUrZ/HGEk6KS6APAsqE0vT7hCRI9UQcEjNxJ4CRW6mztRjcO9nuyPA8PBwJ
         naqHwv2maN7jJLrbUiXsFtqEC7u+nq3VUqo3YHUTOJ1tGDfqBS4dM8P6i9/PZEWQ0ydB
         fbfsw/TR0AGtLDf5goTEk8C2xwlklm5bGtufiG1NtpbyFwo/mIBSrq6VKQPLhv7uFbzH
         zWhhbpI7P6rWLSBjUvNlNqyouyFI1X7yUTrtgW4F8GlDjqndQBn74JkoJoXkSxh8Q6NC
         aOMsBazNuV0IeRGb7le7x6J3RM3+m68RaEpDooJLdY2qM95zZdYuzXjl+WJc5DKWTE2l
         waEg==
X-Gm-Message-State: AO0yUKVJ4R1SK58Ky2hSXGxwznAhiuNrC8r9teqmtbp/FCX8HtgYt/ii
        6gm+AeVujoJCHFGXhwLxJ3Haz48JQNQFbeNt
X-Google-Smtp-Source: AK7set8fSGB4uQiL+978yD7ciC5InI9aUFNwgYCev5AW5oV0faFL3/PazSgvlRD7ghfv0eHV8meJDQ==
X-Received: by 2002:a05:6a00:882:b0:593:fe34:96de with SMTP id q2-20020a056a00088200b00593fe3496demr4570354pfj.0.1675304820524;
        Wed, 01 Feb 2023 18:27:00 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e21-20020a62aa15000000b0058c8bf500bcsm6512507pff.72.2023.02.01.18.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 18:26:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Bart van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>
In-Reply-To: <20230202021804.278582-1-ming.lei@redhat.com>
References: <20230202021804.278582-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-cgroup: don't update io stat for root cgroup
Message-Id: <167530481937.11309.3152642739705496030.b4-ty@kernel.dk>
Date:   Wed, 01 Feb 2023 19:26:59 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 02 Feb 2023 10:18:04 +0800, Ming Lei wrote:
> We source root cgroup stats from the system-wide stats, see blkcg_print_stat
> and blkcg_rstat_flush, so don't update io state for root cgroup.
> 
> Fixes blkg leak issue introduced in commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> which starts to grab blkg's reference when adding iostat_cpu into percpu
> blkcg list, but this state won't be consumed by blkcg_rstat_flush() where
> the blkg reference is dropped.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: don't update io stat for root cgroup
      commit: 0416f3be58c6b1ea066cd52e354b857693feb01e

Best regards,
-- 
Jens Axboe



