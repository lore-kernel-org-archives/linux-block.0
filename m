Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813BE776F2
	for <linux-block@archiver.kernel.org>; Tue,  3 Oct 2023 02:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbjJCCFn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Oct 2023 22:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbjJCCFm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2023 22:05:42 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40179B
        for <linux-block@vger.kernel.org>; Mon,  2 Oct 2023 19:05:39 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57c0775d4fcso76034eaf.0
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2023 19:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696298739; x=1696903539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFaHdQHyS9i21JqtHeL8In3GwblPP2TqR46MnH+YE2Q=;
        b=CzYtxqGOxbC3yrYeHL/BGsFRa02cU/sysfbHC2MJqgaAhPpCUOUUZQpp+CqWfTZ8Ya
         xtOCK/3zjkmtEJ4N4XzIEr7sJBhOeHWonu9s6ZSPl5e+J3SoSNrQlUNpHMg2kalC8Mx8
         fNog8GMfy0wDGOqGISZzn+mjP1g44H6hh0PgaNGzudwBFa9LKRc5UmDQF7m5Dy9IAEis
         1elC1fkk0Tl81Zdu3gSIlAlg+KMi4TS+TtZSwGTb5B+FU4/LhpJsi/7crAPs2zxoRAzv
         wtRzvfn+uqOBOzFGAJWu7r23EZhNHhXidTbb7k13u0/VNFllhUWS+iKOTdEro8YGu7Xh
         HRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696298739; x=1696903539;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFaHdQHyS9i21JqtHeL8In3GwblPP2TqR46MnH+YE2Q=;
        b=DVYaw2VeJ2AIgz7ay0IAFcbiRpKSMwyUkC9ugRYIFNaXhjmeklgjkMGQo2UJ9PQb8k
         sUKtEGLWKVjgmrN6iRKfXDNvLrrTavyDXXtC2T+H9dX4oTjtVdvcxxvmXOM5ixWoOY1h
         iBXQIktHBNt0w2iGWz1RISRAdThLhDDr8E5KzOi4hrxih1dGpilfqQdToYlMbkvaz37a
         Alhen1iwP6VrMuyYmk2B8Hp0Z2fjem0xu7A1pAh6nmb1caAu8t6Y2lmlSHtBYwgzN0sU
         w/7CTKqjWBLlmxOe8YNspDNlYBzpMarrKAE6OL8S0AfujxufXBuYaduuidModOPUau8+
         WRpw==
X-Gm-Message-State: AOJu0Ywjuyg8++/UkM4azwMlcXPGoXC98z6Cp0m2Y9V3/GcFkLYzGqQB
        Zz61XKk6hVwb4eD26wXXzcow2lE155TZIw1CAWE=
X-Google-Smtp-Source: AGHT+IFWzFusbf8uVJyMXuY0Biftw/J5lCDah7fr/KwXx12HnkzKwYkxXx+YRhTuY1BE3ZWhxvKDxQ==
X-Received: by 2002:a05:6359:214:b0:14a:cca4:5601 with SMTP id ej20-20020a056359021400b0014acca45601mr9005905rwb.3.1696298739072;
        Mon, 02 Oct 2023 19:05:39 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id q28-20020a638c5c000000b005742092c211sm160428pgn.64.2023.10.02.19.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 19:05:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20231002220203.15637-1-phil@philpotter.co.uk>
References: <20231002220203.15637-1-phil@philpotter.co.uk>
Subject: Re: [PATCH 0/1] cdrom: patch for inclusion
Message-Id: <169629873742.1745606.9169168579232131161.b4-ty@kernel.dk>
Date:   Mon, 02 Oct 2023 20:05:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 02 Oct 2023 23:02:02 +0100, Phillip Potter wrote:
> Please include Joel's patch below, reviewed and signed off by myself.
> Many thanks.
> 
> Regards,
> Phil
> 
> Joel Granados (1):
>   cdrom: Remove now superfluous sentinel element from ctl_table array
> 
> [...]

Applied, thanks!

[1/1] cdrom: Remove now superfluous sentinel element from ctl_table array
      commit: 114b0ff62a6510eb218660cb4925b4c4a01cdd84

Best regards,
-- 
Jens Axboe



