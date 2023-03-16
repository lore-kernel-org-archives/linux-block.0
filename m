Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECEAC6FD19
	for <linux-block@archiver.kernel.org>; Thu, 16 Mar 2023 15:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjCPPi6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Mar 2023 11:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjCPPik (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2023 11:38:40 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163781A642
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 08:36:56 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id s4so959564ioj.11
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678980956;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbqCSyzQ2Vc+jOdl+z6pC6351AAeMd3EjtD4NdIeOsM=;
        b=ZKJm1OkRdU7+ulP5R+L16WoW86AjyshwdfPWmzyY369cvbGOBr0ljZdSOwgZgq8jUJ
         XC2epD2SQpjZkNhcFLPUdG6qxXVaLPJjoo+rLG0yhrczb+FH3fw8gAfeccoB7T2HM3IG
         ROygfCN6aoeRo1y7yUGtveEL+rSteP6RXWCVyhQD6BdwSykI/0VG5lYsK8088ayhxyym
         0kQAuWnV+B03/rF1eENiy+sJ0JAlrr2Nbpa1/wWkN+k9Zd+WHz9rW6FC3WnUzP2Lvx11
         I55HoZk54TpCJXbCjA1iQl4kVT6oU0nwyUSrCddo9w5G9ipBFxQP9q+Qq8tmeLrLXUCq
         vI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678980956;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbqCSyzQ2Vc+jOdl+z6pC6351AAeMd3EjtD4NdIeOsM=;
        b=Kq5rcRiD5fveQ5zpxcKJhmhHWKFwCaXW9z7d66dMnivOYB9u7A30uE8oQJs6WsOhOo
         /GWRHpH7ifBuRGS0/3Ug8xMVh9xlvuc2WFlnMJkQAPMXg0q2XrzRRxd+h3xO+CL+uMoU
         IpfMrP0hDmkUE16f45bbf4o440x7OUvqTqPt2WsMaCkg9/9RwfPVY3EJ7gCKoknQ+ddT
         WzBjBdVNBxfTb+vQGY8Xr9bWumjoDtbPfVIy+44aDO2x7KUwdHF4sygtNF7h3+TU6gEG
         BB8yGQmorDBReVFhmbzFO4WQBcy7pH4mpPVJF2lRrd9O1fr3lk9U4fbvqyUY2PGyB9eV
         8kbg==
X-Gm-Message-State: AO0yUKXx99pMmj752zlgwhkk8A3NwVVhdTiaYxDLlnt6oERyzd9jdTPq
        Ly87dLIMSBbxxP0wHjESGClcsaI/DOzKP//k4eZGAw==
X-Google-Smtp-Source: AK7set8GnW5ByrPgZRuHB6Q6wFJgPvrgcHqe5wCLkLBo57phwL0hWWCrMSfD9fe1rIR99Gq23Bl1mg==
X-Received: by 2002:a05:6602:2c07:b0:74e:5fba:d5df with SMTP id w7-20020a0566022c0700b0074e5fbad5dfmr2370748iov.0.1678980955955;
        Thu, 16 Mar 2023 08:35:55 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t8-20020a056638204800b004050d92f6d4sm726970jaj.50.2023.03.16.08.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 08:35:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>
In-Reply-To: <20230315183907.53675-1-ebiggers@kernel.org>
References: <20230315183907.53675-1-ebiggers@kernel.org>
Subject: Re: [PATCH v3 0/6] Fix blk-crypto keyslot race condition
Message-Id: <167898095529.31557.16126359951385476698.b4-ty@kernel.dk>
Date:   Thu, 16 Mar 2023 09:35:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 15 Mar 2023 11:39:01 -0700, Eric Biggers wrote:
> This series fixes a race condition in blk-crypto keyslot management and
> makes some related cleanups.  It replaces
> "[PATCH] blk-crypto: make blk_crypto_evict_key() always try to evict"
> (https://lore.kernel.org/r/20230226203816.207449-1-ebiggers@kernel.org),
> which was a simpler fix but didn't fix the keyslot reference counting to
> work as expected.
> 
> [...]

Applied, thanks!

[1/6] blk-mq: release crypto keyslot before reporting I/O complete
      (no commit info)
[2/6] blk-crypto: make blk_crypto_evict_key() return void
      (no commit info)
[3/6] blk-crypto: make blk_crypto_evict_key() more robust
      (no commit info)
[4/6] blk-crypto: remove blk_crypto_insert_cloned_request()
      (no commit info)
[5/6] blk-mq: return actual keyslot error in blk_insert_cloned_request()
      (no commit info)
[6/6] blk-crypto: drop the NULL check from blk_crypto_put_keyslot()
      (no commit info)

Best regards,
-- 
Jens Axboe



