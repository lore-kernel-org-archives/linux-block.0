Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C0EC2BC11
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 16:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBB222205
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 16:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQpBBG2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgIKQoU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgIKPIW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 11:08:22 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C155C0612F9
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 07:56:54 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g4so10303889edk.0
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+ERCkZUeZu8s5TymqK70/6ixnPgTRvUSmQEo+SSPP0M=;
        b=bQpBBG2q7RVXsZCcoxX5+mVNvV5YkMLRJVVufE8dDa0pITfuzA/y1AJcDGn8SwIQOL
         UIhD2XgJTvAwxQgWNUJgJWqZsQDCqvIW9bAags/fi1twLqCX0y7e5URXD+QWKq3jXayF
         ZoZZ2uP3FdQcdX5CwG/dRu12gLZVvKId/GBoWSa+ieA9zLSXdPCAYRffJCgvULiwObDU
         GKyRcQpEszwNwUHyTG+MtmuuyQi8bbl8vEfGCKPWXzKNoRwPqAUp39cFdc7EGLh76Mq0
         ALboNNEPezBWSluu14UFF9V4giuQQUp67PHBXsg5ecWRHXq1sFg4G9qIL04ek2Wk7Fdz
         Rsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+ERCkZUeZu8s5TymqK70/6ixnPgTRvUSmQEo+SSPP0M=;
        b=L8awxuiDU7r/+rGq0/j/k292Ixvcpgsf8fisHOvcmn6c6jg44Z8TtDurdIVQUV7X5P
         y0Xrf1WYPhvd3BrDZWrAp3NFRkzbdv2Frbs3gw4IVB00syVaajLoBdFjBxebAmIFQJqA
         sEI1kQv/PgwTRnucFMqJ16P+2lO531fVzCEIXopd6mE38fJHWCH8ynvsHYu+O+Qa+Mdo
         /QDm4RbPTptdLT8jdWEoDXSM1MRCEa/I6OnFNMlmOaSjPVrvpmrIAVC3tQ2ahUl0jqiU
         uLcqwOf7DyrDDUDEI3afT2peZcYc0f9QhTV0ene12LBh3CQS0LuaalWYS2eXox1DuZGk
         vKeA==
X-Gm-Message-State: AOAM532WahZIS/rwnOLBZEWanYpPNHz5PFyMj8lxpvRo/rla2lFZiKfe
        kedSwHlFQ9+GFbfvvcyn6zsp1x5Zpm7WnVYbOMo=
X-Google-Smtp-Source: ABdhPJx3VW0fRyCVI5Yl8KxXuzBMlV4+M1RQ7kL0sGThKTBG8v0XrNGyawAiZJ3glASH+UDYFDkrTmFLlXDeuTg2HwE=
X-Received: by 2002:a05:6402:17ed:: with SMTP id t13mr2467365edy.163.1599836212726;
 Fri, 11 Sep 2020 07:56:52 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitriy Gorokh <degifted@gmail.com>
Date:   Fri, 11 Sep 2020 17:56:42 +0300
Message-ID: <CANYdAbJVvNB+5Kyqgu3aoh8ug6C2DVkys8JWrY-nQvtPLEgeOw@mail.gmail.com>
Subject: [PATCH] block: fix locking in bdev_del_partition
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

Unfortunately this fix (Upstream commit
08fc1ab6d748ab1a690fd483f41e2938984ce353) breaks compatibility with
some userspace tools, specifically mdadm, who expect ENXIO errno as a
result of BLKPG_DEL_PARTITION operation to test if the block device is
a whole-disk or a partition. With the recent 5.8 kernel it now returns
ENOMEM on an existing block device which seems inconsistent.

Regards,
Dmitriy
