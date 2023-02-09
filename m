Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D88AC6379F
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 15:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjBIPNO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjBIPNN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 10:13:13 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC1160E76
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 07:13:00 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id r18so1741925pgr.12
        for <linux-block@vger.kernel.org>; Thu, 09 Feb 2023 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OY5gQwyKWMxHS/zahFDOxWc094F1lT6x7VxT9TFOD3E=;
        b=mxdIm6NuLTyud9cYdT3Nv2yIFbjasSgPTevVgNrEuwJJu6tLPOlxlNbjn9eLgxCpMx
         LOnOY+g/XV9xm+ZcymSzlq207EsNYmGmUuXy0MrQ/cT7V2XI9U9fgd9MRV8BOAjxkQly
         pg3hbMVV6Iju5WSO2aECs7Tz8GN8UsfmZ0wAdHVDhCkkZQnMk1HPXTkVthfKP02X6mnF
         UhUsceMoVUiNBNdWITUBKC48B5P5NyW+u01HdzwKdWGk6Sfv7uI1Or3L/ikYOs/hS1Rq
         C92Na2h5yYHSlE3SCTyoPX7S3IwBY6KSEF7QmSCfkwFOdyfouhm9TzpzOe1WNg7S01JX
         BqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY5gQwyKWMxHS/zahFDOxWc094F1lT6x7VxT9TFOD3E=;
        b=kAQLNFJIkOogftHkEkPdLnUkEQYlHxVTULj3seuh3NvyLbbu/NnaRiUrQqem2yTZs0
         BPAbDzPS3pb6OfBTAvfzdrerauE/2Ejm1Q4BEH2sjl8Guo+vWArAz1GXOdOj2Tx1H/GP
         RFdQLi8NV6whn+Yyg2tomholQM/7LPmL2go8r8YwI3L4HzbFAbRq+uWDADpzCwTR2/9m
         idnYCjPPer47Z5ncimP8xs8Wuz5HwU/wjUk9kUqZ4DuHDLBUvXWW7c0QpGJVn7A/iKkG
         6/6SE6JfeFutAhO2hSGsMKiJWfvK8LcwIaU+/73e0jr5tx8TxdYHQyA4d1o7uYI09UPl
         7+2g==
X-Gm-Message-State: AO0yUKUupo9BWLtuOX8fb5P7CdU+cQwI6AWs/U/Sviqa6duTY/7Pm8i8
        Rk7nKWMQlWOrpKMdlVUmvUw+IQ==
X-Google-Smtp-Source: AK7set9t3MSXhdPsADqn+JzN4zSA9SvC6KSp858SlM+bsAkAKKDRO2UlpcfGt26PN/rCLiSzVko02Q==
X-Received: by 2002:a62:a118:0:b0:592:5e1d:8d03 with SMTP id b24-20020a62a118000000b005925e1d8d03mr9635960pff.2.1675955579955;
        Thu, 09 Feb 2023 07:12:59 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78d43000000b00593906a8843sm1585716pfe.176.2023.02.09.07.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:12:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Xiao Ni <xni@redhat.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
In-Reply-To: <20230209031930.27354-1-xni@redhat.com>
References: <20230209031930.27354-1-xni@redhat.com>
Subject: Re: [PATCH 1/1] block: Merge bio before checking ->cached_rq
Message-Id: <167595557892.325128.17846082603567400159.b4-ty@kernel.dk>
Date:   Thu, 09 Feb 2023 08:12:58 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 09 Feb 2023 11:19:30 +0800, Xiao Ni wrote:
> It checks if plug->cached_rq is empty before merging bio. But the merge action
> doesn't have relationship with plug->cached_rq, it trys to merge bio with
> requests within plug->mq_list. Now it checks if ->cached_rq is empty before
> merging bio. If it's empty, it will miss the merge chances. So move the merge
> function before checking ->cached_rq.
> 
> 
> [...]

Applied, thanks!

[1/1] block: Merge bio before checking ->cached_rq
      commit: 23f3e3272e7a4d9fb870485cd6df1e4f9539282c

Best regards,
-- 
Jens Axboe



