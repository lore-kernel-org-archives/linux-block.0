Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFB7C677F1
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 16:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjBVQyI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 11:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjBVQyG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 11:54:06 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B29311D2
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 08:54:05 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z5so231450ilq.0
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 08:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677084844;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmUUNARWgsefCewsumzc9JR6xfzvexmN+j0+8Qblr1Q=;
        b=5ev1+K6cto3FVYCBE/etdN9pbOYu9wUeGg59mxJp3i6j/9oSorBOxDM/o+C3zZuOM/
         KDLbp8+N60XYQM8JLojgzbYTz0a0GR1qHTzupJYMlSq+ufszaYWUtLoamLAcTsvagrkh
         PeKOsZlHLE/yjgzEq8o/w2ls01Q6enLhrrkd+rtNH7aw2T0Ui738l1FGUPlUe8j9WoQe
         7SNQ5oj63CdtYKQ3vS7kVAHzozq2flIJZPPSNZG4fS1Iq9QBW6efyZ6OS2FmRYCJjiln
         4jJn49iYLQKoQjnCIVzrhxY+H3lLNaJcDJenoxeZTr6jboti+YANzSmutF9+/d9au4Vk
         5JGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677084844;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmUUNARWgsefCewsumzc9JR6xfzvexmN+j0+8Qblr1Q=;
        b=i+X1UcIqdFTUf6yl5V8Bn8PzluvaR2wiq9mASXoljurpmIqHwBbv8MJoJFUsIi5hri
         MiZgoKEpjDQXjjlfBZVlKT0FtbkrYd4IvVYJUD0CcdJJFajxn5gbd/lIVE8/SXE1ET6C
         MWpnRBmhTI51mtS3EAy2vmeWzt6ScvER6SZBYSQLlYh7TqqRLKTLOUJHqak9cTT3n/Gx
         PZny9KZj4R+cgSkmdtlgB2uBxM/n2ru76czkkqX0BhTq50A1AEfIWD/4BdhzoIvjRh9B
         OzYnOqSiiHaTJeEJ8mNiAILIKokx3wzkXwuGhW4VOAmbWLuT+sv7PGyP25HBkt2hgUsm
         x7KQ==
X-Gm-Message-State: AO0yUKX1lijgXCgfVqHPHxbk5h4vpjLrXKFGifmtBlbDahBpw2r9SKc5
        4pifiS6R8mvaBDSpKYyITSRrq6DnJKM4s/C6
X-Google-Smtp-Source: AK7set8L86eKuspanAvmxwOQaCZl4HFutRXTt8bEz6fEj4SwzCfApysaNZWmUfnYqwLJX199TubsIg==
X-Received: by 2002:a05:6e02:1a06:b0:315:8bf9:53d8 with SMTP id s6-20020a056e021a0600b003158bf953d8mr5603053ild.2.1677084844453;
        Wed, 22 Feb 2023 08:54:04 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x17-20020a029711000000b003a7dc5a032csm997371jai.145.2023.02.22.08.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 08:54:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230220041413.1524335-1-ming.lei@redhat.com>
References: <20230220041413.1524335-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: remove check IO_URING_F_SQE128 in
 ublk_ch_uring_cmd
Message-Id: <167708484363.23363.13457539370769350671.b4-ty@kernel.dk>
Date:   Wed, 22 Feb 2023 09:54:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 20 Feb 2023 12:14:13 +0800, Ming Lei wrote:
> sizeof(struct ublksrv_io_cmd) is 16bytes, which can be held in 64byte SQE,
> so not necessary to check IO_URING_F_SQE128.
> 
> With this change, we get chance to save half SQ ring memory.
> 
> 

Applied, thanks!

[1/1] ublk: remove check IO_URING_F_SQE128 in ublk_ch_uring_cmd
      (no commit info)

Best regards,
-- 
Jens Axboe



