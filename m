Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E81C07E9C
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 20:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAFE361C9D
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 20:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhGFVCU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFVCT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jul 2021 17:02:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8824AC061574;
        Tue,  6 Jul 2021 13:59:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i94so529329wri.4;
        Tue, 06 Jul 2021 13:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3h/6CdNDLiatwRf8U9GgK4AELHJbmk24hBENxY/7j7E=;
        b=UH36vNJusLOCUOUwMAuunT0VngPTD7q/CvY7dPiGEu4wV671ahgXwVcsuR3AVeIgwW
         O5ZY/h8IP0esQUob5EjhGQDkiDAe0xMCC5h7xvwSEgQdRfXc/gy4BtcGWVDHdQrUi0w3
         nH5S94v7jjNpKY2zQuvzrcfVfJ6lCQzhcIm/5z1g6Uj+Sb1q/CQkHJYVI7V3qvDnitew
         DuWXo2veftgK0nXtYi68G+DQh6ZLDcJSciobgEAj9cLQ5gJr0ZNpoop4QASVCQTlWLBp
         wpl0ybs0GxdMJJLLPPbElGscDhPGC/LIxcVY5YIeSyPOExOuD2XRjJjxmsuQPRG4n/DU
         1goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3h/6CdNDLiatwRf8U9GgK4AELHJbmk24hBENxY/7j7E=;
        b=hH0HtnaZsks6uMXwaWdnSG9ul/kOXQmX6KHVM62BW4U9LrWDv8P+et18UxO+Zebj2j
         U/HFk9aPCCa85f0xVkS/MOKjKjnfIEa20RPWizjEqBDPqi95LvyW/jiy7nTTyygIhLgv
         uVxTVDRVyz3vSd+CynXxTvlg74EaTVMgiyWguN9O7ChLl2mRBSUuWs3JdTkeDMYmGuOI
         1djmgTQMGfSvOyYpy0t9YzV+Lt2MHpRQ8oKQrHebTPfP3RG6Szhuu1pyKeKBFMTJvbtF
         t30er1jyMEkZMUAShpf4ZiYRG5l1d0rDD1v2EtRVdA6GId1Urn8+Kdzq0FcKJcIaHe+o
         GPCg==
X-Gm-Message-State: AOAM531GoEmIdOwR9xI5ETtizq5XnrDDbxHXoohg5dXbrYEtJfSC+Om5
        kX4Joi1hfnfDblmAwbKD5/s=
X-Google-Smtp-Source: ABdhPJyd0hCpYCFEGL2lgKo/Ar2zGNSYdm0NWjrV/EQfjjtLmHlBp45grUwOhTOWAoKQ5OOuAVRo/Q==
X-Received: by 2002:adf:e605:: with SMTP id p5mr24541624wrm.396.1625605179250;
        Tue, 06 Jul 2021 13:59:39 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id o17sm3944676wmh.19.2021.07.06.13.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:59:38 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     arnd@arndb.de
Cc:     hch@infradead.org, axboe@kernel.dk, bernie@develer.com,
        linux-parisc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: div_u64/do_div stack size usage, was Re: [v3] block: Removed a warning while compiling with a cross compiler for parisc
Date:   Tue,  6 Jul 2021 22:59:27 +0200
Message-Id: <20210706205927.4407-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
In-Reply-To: <CAK8P3a2mAQOnTxBhVzVA8q8O-uVrdidCN5h5-T2dc0=Wet2uPQ@mail.gmail.com>
References: <CAK8P3a2mAQOnTxBhVzVA8q8O-uVrdidCN5h5-T2dc0=Wet2uPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I have compiled the kernel with a cross compiler hppa-linux-gnu- (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0 and the conficuration was the default, Build for generic-32bit "generic-32bit_defconfig"

Abd-Arhman
