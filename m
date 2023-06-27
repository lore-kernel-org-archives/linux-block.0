Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78778EB64D9
	for <linux-block@archiver.kernel.org>; Tue, 27 Jun 2023 16:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjF0Qfd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjF0QfS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 12:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BB4198C
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 09:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687883630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9A6ATY9LqaJSfWJfx2WWx323Pvwd+t487KhiuT9/AfA=;
        b=c6dlWQylEhhBYJU3WoK1FtBjHgO8IBsOPOySEm1FVbD69zpkhoqbjcb+UjJfdzfG+dfVaL
        ggPkwrcVeJZtCFGoLL3H/dMyrH+OAQmhuLlzGYaekiyUYuKdxOA4Ktf+DmmKMb5d96sENe
        Np2HMSzYb5TQq0lWtkhNqZq8vi77U7Y=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-lBaZn_7QMkG9hYywaPelsw-1; Tue, 27 Jun 2023 12:33:48 -0400
X-MC-Unique: lBaZn_7QMkG9hYywaPelsw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b7d5826f1fso13788325ad.3
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 09:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883626; x=1690475626;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9A6ATY9LqaJSfWJfx2WWx323Pvwd+t487KhiuT9/AfA=;
        b=c0h7Ipi2kV8CMC8mZwmIUca7hZiHDpAp4ET9X9fUhADdTx6q85jz1Xf610wfLdB2ts
         6FOb8xP/tI7yTg+pfqbx23PRe17/5i0eRFaART5tndICrYfRoZKCzLRuzWNF5urDYqaW
         W1qaGftEXfAkYnWPPcnWa9HUUq/mtiTX/VGtQ1O7pOUpnBoe1utq4exDTnP9CJnzLc2M
         lfPaRBwcG6D4kU/3kCjPMOYQpQYc/G3LuHfTnt//h5EygjCZ9BdLFxSyfoMbAD8ZOmgZ
         2bCxqVMGuc9ug8Drk+YubBwwfkjCqNnqGT/z1gvS5HbAkjWqWnysIqWxtet/MZEnzYYn
         vG9w==
X-Gm-Message-State: AC+VfDyCf7qeFyvgh7Z4TJvmA6UkU3dmm3hfjzEqgnoWwb4IIIKOcz5X
        aYe6Agu+WmQmga97BcXtf9rd/63Ec/ipkqP2PQ4qdKo1cIbpgHUEQUxtugkoWSXUmcHbcKtYbQx
        OYgjLPOelMjtDifb0k9l9GqIPQ/WU1ImoMGfoNI1uyBZtNEuvlSFl
X-Received: by 2002:a17:902:e811:b0:1b6:80f0:d97a with SMTP id u17-20020a170902e81100b001b680f0d97amr7578765plg.19.1687883626149;
        Tue, 27 Jun 2023 09:33:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fxdyZwD/T9HTf1SSNThYAa5VjotAfp4yLFOUFO6NZozSLACNYaRtimkegV2xAvHR+lRGiKcc3Uwp9cyBJgxs=
X-Received: by 2002:a17:902:e811:b0:1b6:80f0:d97a with SMTP id
 u17-20020a170902e81100b001b680f0d97amr7578754plg.19.1687883625837; Tue, 27
 Jun 2023 09:33:45 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 28 Jun 2023 00:33:34 +0800
Message-ID: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
Subject: [bug report] most of blktests nvme/ failed on the latest linux tree
To:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

I found this failure on the latest linux tree, and it cannot be
reproduced on v6.4,
it should be one regression recently merged to linux tree after v6.4.
I check the commit recently merged after v6.4, and found below commit
touched the related code, not sure if it was introduced by this
commit.

commit 959ffef13bac792e4e2e3321d6e2bd2b00c0f5f9
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Thu Jun 1 23:47:42 2023 -0700

    nvme-fabrics: open code __nvmf_host_find()

[  524.706158] run blktests nvme/004 at 2023-06-27 02:00:43
[  524.779499] loop0: detected capacity change from 0 to 2097152
[  524.790075] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  524.810743] nvme_fabrics: found same hostid
08dfb4e9-d246-4450-afb6-bc6249f9dc96 but different hostnqn
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-005a-3010-804b-b4c04f4e3232
[  525.346603] run blktests nvme/006 at 2023-06-27 02:00:44
[  525.380421] loop0: detected capacity change from 0 to 2097152
[  525.391846] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  525.901516] run blktests nvme/007 at 2023-06-27 02:00:45
[  525.934980] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  526.412792] run blktests nvme/008 at 2023-06-27 02:00:45
[  526.446070] loop0: detected capacity change from 0 to 2097152
[  526.456790] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  526.471220] nvme_fabrics: found same hostid
1cb04df4-a83c-4257-84ad-aa5dab3e961c but different hostnqn
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-005a-3010-804b-b4c04f4e3232
[  527.014108] run blktests nvme/009 at 2023-06-27 02:00:46
[  527.045095] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  527.059680] nvme_fabrics: found same hostid
1584c36e-4a26-4408-a7d6-5608c0197141 but different hostnqn
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-005a-3010-804b-b4c04f4e3232


-- 
Best Regards,
  Yi Zhang

