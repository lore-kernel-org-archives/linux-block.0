Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C941C28CBC
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 13:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A20720757
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 13:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+3/1T5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgEFNtT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 09:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725801AbgEFNtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 09:49:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA61C061A0F
        for <linux-block@vger.kernel.org>; Wed,  6 May 2020 06:49:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so2299193wrx.4
        for <linux-block@vger.kernel.org>; Wed, 06 May 2020 06:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HOocdAGVHf5tl8B0zmCdAbwFif/Kuk3Eu+ebI2TS9Tw=;
        b=A+3/1T5yYgiE37J6a0mg9MaofDpWg3kb8CAxC3IVW72r+O3W5+DM6eRAX0YRZ1PZQQ
         h5AbkDpDLZALWz+oBveXZxSgkrfkiR/9VJIxJsdFx7AC//uq/af4mDh0RjTh+dgmpzWB
         ZNRVuQNQQw6cVy7VMjDebQ59c/I0nOwHdAUBsKWsmOuQUWsnYdm6WluuaLU1lOxH3clE
         WDGD7WX5zDXlRrszRt0uImFqZfVfKRq5QHWNen8coDFgzvMn9vde73TjaBMe87IbyDSl
         C6WnsPskZ2BKqDWDCkRrsm5bYsRHugu6gOOTIZUjyDlc9Ascuxqlracv60bW84EzwAfJ
         tgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HOocdAGVHf5tl8B0zmCdAbwFif/Kuk3Eu+ebI2TS9Tw=;
        b=AHUdrXxaJ0mS6KlVaDrUD9jpyPXySIHin5KjKuxlCmQzvt4DuVz3m+0AdW/nT59bQL
         CWNOQNtsbaOGxomdKwM/WttK+ZZfFMwdNU0xJ2AOIBMGzGBsq0iZfcZb3scGXXwoRJVQ
         Wn5RTxaTaXba0hT55Yi/+xz92/ksuHZ2xJ2a2i7rf5dpaSPScWmlHwX7EbXYCGRu0w6l
         SuyUkar19GorbRsvjqlafN0dlA5ZpSzpYgZ2mllNRLpT+yzA5ruphuZevvoScHZhTU51
         LkgWpxd/ksO1r2ysmHTlOxSKo/Wo+sjrnWzbO533xT7LkgtlFzNeIBxnKrAQjgfWcxCh
         KRvw==
X-Gm-Message-State: AGi0PuZi36MVnl4XUTLPfsiLYQiP+W20tuiBEFQsv3cFBq2PHWzEqys7
        hF7jZlGI5w3n8f55/H17AFWiJw==
X-Google-Smtp-Source: APiQypIGL7RxMTCpIu8hxFdIY4uRotvLa8Eq2mhQU4O0u1U+YQXJ+GTqvxRxX+wZlJX0AcY8ju066w==
X-Received: by 2002:a5d:510f:: with SMTP id s15mr10602180wrt.103.1588772956658;
        Wed, 06 May 2020 06:49:16 -0700 (PDT)
Received: from [192.168.0.101] ([84.33.163.133])
        by smtp.gmail.com with ESMTPSA id p6sm2738060wrt.3.2020.05.06.06.49.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 06:49:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/3] Fix blkparse and iowatcher for kernels >= 4.14
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20200506133933.4773-1-jack@suse.cz>
Date:   Wed, 6 May 2020 15:50:30 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E027D84B-27AE-4426-80A7-269E9357A03A@linaro.org>
References: <20200506133933.4773-1-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Does this fix make process names (with PIDS) be shown too in bfq log =
messages?

> Il giorno 6 mag 2020, alle ore 15:39, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> I was investigating a performance issue with BFQ IO scheduler and I =
was
> pondering why I'm not seeing informational messages from BFQ. After =
quite
> some debugging I have found out that commit 35fe6d763229 "block: use
> standard blktrace API to output cgroup info for debug notes" broke =
standard
> blktrace API - namely the informational messages logged by =
bfq_log_bfqq()
> are no longer displayed by blkparse(8) tool. This is because these =
messages
> have now __BLK_TA_CGROUP bit set and that breaks flags checking in
> blkparse(1) and iowatcher(1). This series fixes both tools to be able =
to
> cope with events with __BLK_TA_CGROUP flag set.
>=20
> 								Honza

