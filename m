Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69505EB64DB
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 20:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjFTU2j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFTU2i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 16:28:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7E610DA
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 13:28:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-260a1ca3c8aso379829a91.0
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687292916; x=1689884916;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnRhvwMh5wKLUeIs/36AWk10zDe0IXqNUgk3KF6xcsM=;
        b=O6wbdA6dNroqUNYL+fRMWUoXNKWMfKipYwBazJTaGKJvvUMWY39vg/3zchM4vIN0SD
         nNjUZv7JpETr0ZdCowIHKDqX0yCiJGEoOpHt0l2borjimEL2mukk2oVQvwbhkwNJZyxv
         3XOAjv86RWB3GcoenwHOUx+3nm3R0wNLhipJJP9qhTpcbAPwvRpFS1ocr/2MFvJRVS3O
         8KNZwrjZDJ1NYIje4j0LL+j30zVl8okbTBX8k9FrpaVK5ZpUK+VgkaFOqrjgi4sirdUw
         ux1soptxIvY5bqKphdo+h1mJuYvl60NcQ59NPHPtzPCYuvUSsEcmX2m9Wo4ZGlsnbs55
         mx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292916; x=1689884916;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnRhvwMh5wKLUeIs/36AWk10zDe0IXqNUgk3KF6xcsM=;
        b=FIkg3uR9i4rIrZnd06+1vSIjQiwUPVMD+9JV6JQdbZGmAxxwsIDdrZvS455pjgy6ll
         t8VEd748P480+aVW1mSq6veo0BoAgl0MLFwHIYGnoq0Gt/wzNpUAO1WgJDsH2TCMQEfD
         9eGpApZhiLkrcU63qHZCOo0Qso+5fweo4TTkqlpBMzOB4Wt8YsIngBmoiaGirInYq3w9
         cHn8u+OQjuShDGEcrsczbnBpqe5Ll86wILHltrh+q/OKrj+hC5drDRq0LfHHcfGoikzX
         WFiJio04yWoswrpuU9Sn220QbetNJi+xh/JJloH6ozdWeI7IbkfRAEWiboFqfoaC4BEI
         XIXg==
X-Gm-Message-State: AC+VfDx++qpqhPGRlZ51gG1UqYQR4L99cr3ZElntVlNO2ivlOzvVtZ0Z
        Z/fqYL/Velxf0JJRcTEPaeMfnSxD7akwldflanE=
X-Google-Smtp-Source: ACHHUZ4vaLzNKpHVIvHruLG/3PcqoBkNw964MsHNtAH0+XQZMWLt4KvTI84OE2TVBad7kgg+hgJB6w==
X-Received: by 2002:a17:90b:164a:b0:25b:e83b:593f with SMTP id il10-20020a17090b164a00b0025be83b593fmr16709593pjb.4.1687292915833;
        Tue, 20 Jun 2023 13:28:35 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090a694400b0025c1fbc9984sm7604904pjm.19.2023.06.20.13.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:28:35 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org
In-Reply-To: <20230620201725.7020-1-schmitzmic@gmail.com>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
Subject: Re: [PATCH v13 0/3] Amiga RDB partition support fixes
Message-Id: <168729291463.3788860.17194611750755016861.b4-ty@kernel.dk>
Date:   Tue, 20 Jun 2023 14:28:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 21 Jun 2023 08:17:22 +1200, Michael Schmitz wrote:
> another last version of this patch series, only change
> in this version is in the patch 2 subject (to better
> reflect what it's about), and adding Geert's review
> tag to said patch.
> 
> I hope I've crossed all i's and dotted all t's now...
> 
> [...]

Applied, thanks!

[1/3] block: fix signed int overflow in Amiga partition support
      commit: fc3d092c6bb48d5865fec15ed5b333c12f36288c
[2/3] block: change all __u32 annotations to __be32 in affs_hardblocks.h
      commit: 95a55437dc49fb3342c82e61f5472a71c63d9ed0
[3/3] block: add overflow checks for Amiga partition support
      commit: b6f3f28f604ba3de4724ad82bea6adb1300c0b5f

Best regards,
-- 
Jens Axboe



