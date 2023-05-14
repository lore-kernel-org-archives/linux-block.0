Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD981C77B7F
	for <linux-block@archiver.kernel.org>; Sun, 14 May 2023 14:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjENO3A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 May 2023 10:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjENO26 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 May 2023 10:28:58 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192A61FCD
        for <linux-block@vger.kernel.org>; Sun, 14 May 2023 07:28:58 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75773252cbfso840715685a.2
        for <linux-block@vger.kernel.org>; Sun, 14 May 2023 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684074537; x=1686666537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7eRSNNpt/fDq4FH4lTfo5u7cKYedoFAIvQAZfZNZ28=;
        b=QqzFwuT8nPEosz8AeHi0ji5DrB6ReDjtS5N/JRHvUNBbCHSad38EJc6WqQ18XNE5c8
         Y6EuRC6wv0eAMdgAgQDYr1Lzx4PZk94nF1Lu/USHFPyLjbJV4+NXDthWzFswyyS7jqfi
         GQF4R0UG9HYZEQ8RWmD65fcH4xacvOPENPdwZjE1+38/8J23LIcJRYFTEoptPbmdYE/I
         P9cTLfClfFl+ltVxzyVT589IfqzN2nJ0uZ84I+5LwyYbQt/LZKSLgwiYgAOlGngr0S6r
         8zkJjBqO2GTYKZAa0q72JNQK9q7d7GRACBPD8cimRwSsXWUqfb+RFHmFytmB+jQhqRbD
         cgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684074537; x=1686666537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7eRSNNpt/fDq4FH4lTfo5u7cKYedoFAIvQAZfZNZ28=;
        b=l9GLvuZ9Nm5S8WOdkURiTUVR33hDllB+Q8db9t4/VE4724sNI5o9FmO47QGtC9hMeh
         5CsqshMq7lcXLxc7AkO/48PQShhfSNqaFxUShAKGtEHVwOfHjFPe3F59PtqPZkkVx79X
         DlMcO0ELg/b6tCyU579cwTP/GcvnfFdWpjXNS8cwZ8H7HCYa3LKu5/p5RQhFyj3YvC3c
         4qJ6qwHfK0YsOd3N/rah+zVNmk8ts/72AxO5PBPyM+z06+ft5QtaiML294MGoh/tnRnj
         Rhqymw1krMXzw33GQOk1F7ElEfodAYfI3/LaUiIDlRl07134ELE84t8k6Y04s2nZbxUc
         JaHg==
X-Gm-Message-State: AC+VfDxfWgpvUIR9x383wYsoR5aMj6I/YXQsutNZW4ZFGNOgpZS0cbY3
        P645xPzjdQ/XKPp6Bw+YmEs=
X-Google-Smtp-Source: ACHHUZ6YBrMWIsmnApfA9PyC0TcI4RjLTg4VSdwp4P1zoLkGZqvX+hfQYMcHEIeQuRlh/ScUNOojzQ==
X-Received: by 2002:a05:622a:45:b0:3f3:91bd:a459 with SMTP id y5-20020a05622a004500b003f391bda459mr34477137qtw.34.1684074537133;
        Sun, 14 May 2023 07:28:57 -0700 (PDT)
Received: from tian-Alienware-15-R4.fios-router.home (pool-173-77-254-84.nycmny.fios.verizon.net. [173.77.254.84])
        by smtp.gmail.com with ESMTPSA id o20-20020a05620a111400b0075904321c87sm2655958qkk.13.2023.05.14.07.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 07:28:56 -0700 (PDT)
From:   Tian Lan <tilan7663@gmail.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, horms@kernel.org, linux-block@vger.kernel.org,
        lkp@intel.com, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        tian.lan@twosigma.com, tilan7663@gmail.com
Subject: Re: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Date:   Sun, 14 May 2023 10:28:55 -0400
Message-Id: <20230514142855.595298-1-tilan7663@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZGDur5+koRgNh5Ih@ovpn-8-17.pek2.redhat.com>
References: <ZGDur5+koRgNh5Ih@ovpn-8-17.pek2.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Ming, will make the requested changes.

Tian
