Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0142C4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 17:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4B7233A0
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 17:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgLQREZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 12:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgLQREY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 12:04:24 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2187CC061794
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 09:03:44 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id bd6so13592639qvb.9
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 09:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdyWfkBT3FTk3WERIytnfGK9aMbq5yLUuj7iCyWMYXg=;
        b=J+KVf2iOycImOXpfg+RG14p1t+kmuT7Ilbd/r+a3OP9zQO5k1aKT5EdN0d1gMpM8d4
         dXQZyOTWISUgGGAV85Xt6LdLJ/9fNAnkEb3YnXWeZ/chtKxpOLCByKN4up5hl/0uYGgv
         IwTHPCRoDI7PKere076sVaJHOT3H+zaY3JoJtt0FoYT5IHl4jr1kE73xecBSsAowKXrh
         fi603KKeslAs7Qg6nZRQbahBVmWSda6Ytp6z1wcthCKmmTXjo6Ftf7h27pffDQ7di0tv
         IymBx5/Jvj1fT+CwOFvyhRIpNeOij5qkaZUenxcrLuBRbP/sRSbsRnbvPMIdePJbGCui
         bvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdyWfkBT3FTk3WERIytnfGK9aMbq5yLUuj7iCyWMYXg=;
        b=El5xsBjnxPrNDgzSvalAZagIQm3D4njbIrSwVWbni9x+1KfF7CPNGnGE89TTdtt0Ks
         gSv2+iogFxT50VIBM/cI9+5RAExU0BPdZa9Jg2q848kmX58wI/NTf5bBAseAJIaxQafk
         PKl7h2HvqHuhaZpCnBv9UsjULcMPabWhJciuhexmeKGv/4+yvOgD0WQwBQ0PKFgiA92C
         qFior/0tNrOJ6nAZt4suqjuhs3xc303x9FB7O5ifWmUlD+XnDCst9eGppmImGpDoVbdC
         k3OzfYmLLmcnr88mZTdo7bZfcOshW4ZtwzZoqAqjooz1bJuPIQHcwZ/0BRIF7WgjnW7X
         9T9A==
X-Gm-Message-State: AOAM531FpZveBMqUDQwonxWvqKJnjF43zYeg1j1iM2bI+Pjarii21beQ
        jiAhfKFvy2HezXLUkiIhFxdEI41MUpH8qb596Bg=
X-Google-Smtp-Source: ABdhPJxV2gqgXcjeDHhxDd6zzQ3k63longhxpcIHvVewknSAVmQR8Vog0kH9M+R54yEBfxOX5LcbRXJg4X/frhraarE=
X-Received: by 2002:a0c:8b99:: with SMTP id r25mr49927880qva.0.1608224623234;
 Thu, 17 Dec 2020 09:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20201027045411.GA39796@192.168.3.9> <CAA70yB7bepwNPAMtxth8qJCE6sQM9vxr1A5sU8miFn3tSOSYQQ@mail.gmail.com>
 <CAA70yB6caVcKjJOTkEZa9ZBzZAHPgYrsr9nZWDgm-tfPMLGXHQ@mail.gmail.com>
 <20201117032756.GE56247@T590> <CAA70yB4G_1jHYRyVsf_mhHQA-_mGXzaZ6n4Bgtq9n-x1_Yz4rg@mail.gmail.com>
 <20201117074039.GA74954@T590> <CAA70yB4c_mBxr3ftDd1omU=Piozxw2jKM0nyMmOP9P_hOYjNMQ@mail.gmail.com>
 <CAA70yB76dWneSJvtyA=1BFSJit3jzyvBAzJQYO-UHo-KACSZ9g@mail.gmail.com>
In-Reply-To: <CAA70yB76dWneSJvtyA=1BFSJit3jzyvBAzJQYO-UHo-KACSZ9g@mail.gmail.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Fri, 18 Dec 2020 01:03:32 +0800
Message-ID: <CAA70yB5-LNNacq=oYfu+73LUW89tDgKD+WYWtFGORcWKpwU9gw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] fix inaccurate io_ticks
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        mpatocka@redhat.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping again.
