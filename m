Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB64C7EE26
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 05:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjETFbF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 01:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjETFbE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 01:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E35F1B5
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 22:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684560615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XzCEspLGlKA254CwGe35oONfGtSOvg7zfEOdpWW9psA=;
        b=gxlrjznh8a5Ksia6vy/ycC1tZgqKGIdLecDRkZgDtFiaihlSorcGoo2re5UWIAF8bu5lBl
        DgfN4wxQX/hC15it5tatUHbCUmxdCgirKUQjZBH7ltMEFwL7qIaAtdkTl0ndu8KLIWIAL5
        rqz88/7FrirH1dtwhXujCQdJZ3zhNB4=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-x-b8c6DcPueXpKI1oF88fA-1; Sat, 20 May 2023 01:30:14 -0400
X-MC-Unique: x-b8c6DcPueXpKI1oF88fA-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-55288eb52f6so2448108eaf.0
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 22:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684560613; x=1687152613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzCEspLGlKA254CwGe35oONfGtSOvg7zfEOdpWW9psA=;
        b=ebl91JkQtFJqbEq/iJANRr0pdB2+FljoA5IA5hrha/Ve8kjPm84OMVaING6Bvu86jD
         IZ0L8L+d4K0pfUzqSzhtybbZJKV2Ysk1MRoUReKZavk8ectgni5uuL2l/fuO9vtO27su
         WjVbcQvykXKBbVty4DPF467cJQQbM9lxUdPY0o9tU6hCfgaUK1vKxoPsEMAK4q1zZsLH
         QlMHV/evuQfanjdyalwIFMqnOjngZuSdGttUamH6Zmdhyla6hQ/ejJ9apjNh5WBwL7g6
         5FYcM675cdeY7MHGtmkAXNVHbJJLlpd6ps3Gt+2U9XGOCzAAMrTSpi/YUBIKLGPlZ5jg
         dPIw==
X-Gm-Message-State: AC+VfDx4gA5zIMnWbKsFG15OwbEb35jDH5H3H/yJa307ViY4vOF6TmuP
        +K10Uz7v+rOXzVMFJaUVUUGenoD2SNnFle0NlVv6ErxJnrHXAYtv/LXrXUFGvdgxKM7AkIWOH1s
        chcApxpGrh8ha46MHnjgrpp8=
X-Received: by 2002:a4a:2a56:0:b0:550:ab9f:ae6c with SMTP id x22-20020a4a2a56000000b00550ab9fae6cmr1939155oox.7.1684560613393;
        Fri, 19 May 2023 22:30:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZWo8MuQDw+aQtJyA+TVBUa/z/h7TANbcVuEGzhRhIWm7wgNVaPiBGm+XdzbHOJcW9FAjxTQ==
X-Received: by 2002:a4a:2a56:0:b0:550:ab9f:ae6c with SMTP id x22-20020a4a2a56000000b00550ab9fae6cmr1939150oox.7.1684560613112;
        Fri, 19 May 2023 22:30:13 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
        by smtp.gmail.com with ESMTPSA id j14-20020a4ad6ce000000b005524555de56sm365494oot.36.2023.05.19.22.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 22:30:12 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] Move usages of struct __call_single_data to call_single_data_t
Date:   Sat, 20 May 2023 02:29:55 -0300
Message-Id: <20230520052957.798486-1-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes since RFCv1:
- request->csd moved to the middle of the struct, without size impact
- type change happens in a different patch (thanks Jens Axboe!)
- Improved the third patch to also update the .h file.

Leonardo Bras (3):
  blk-mq: Move csd inside struct request so it's 32-byte aligned
  blk-mq: Change request->csd type to call_single_data_t
  smp: Change signatures to use call_single_data_t

 include/linux/blk-mq.h | 10 +++++-----
 include/linux/smp.h    |  2 +-
 kernel/smp.c           |  4 ++--
 kernel/up.c            |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.40.1

