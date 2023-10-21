Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE630C001DF
	for <linux-block@archiver.kernel.org>; Sat, 21 Oct 2023 00:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjJUAit (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Oct 2023 20:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjJUAis (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 20:38:48 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD3DD6F
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 17:38:45 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c7a4735a30so249217a34.1
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 17:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697848725; x=1698453525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=423X7bf3mKdV2TfpiLpGt3onIWyjL6GRNCUQJNzFbJY=;
        b=GCPt+Mr41cq8TzswR0amE3zshzM9Nlas9+I4pUIA+1qBSHqfuoyG8qdeSePaM70SK+
         ga/J4yau0grKFwXeCIfUfUpRnAcJ3AKKgxJIoFgbuWbyOGKOUm4/kwOO9h1s4fIsRsDz
         ajY3TGF7x4n64DypEAndW86jd3361xl12mf9uXaUxbaNXaxsbztkOkbHA7XvoWh8L8V7
         oF8wv35OlpUcoQemrvBfBEOxhMLX/csUHhXXKYQj2pFgHwAPEkQ8Vb1OVVE4hR+AfJrm
         JSU8EgTs9ZLSTnDBkFtsG5DwOp+RyUrXZDAQ2fZ89xp3hfinEkuSJxTr+63XAEVS9cD4
         CMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697848725; x=1698453525;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=423X7bf3mKdV2TfpiLpGt3onIWyjL6GRNCUQJNzFbJY=;
        b=txc+ONNUjUYm1a3gE/ypXHCk4bsoZQg822sj5dJc/Q+zT9kpbfkVePmEVzxUqiPOXs
         fMxWjk12l1dvBP1QgJLYakyQz1Eih7fSNhmUZDHD+LU/6WAwTNrpbPJhzxNwYehK5rpr
         /xMB2DmgO/voRxaXF4Psxog5jtsybxU9rd2CHuZtnV9R1b0Jfj+s5MxCTVvN33hSrYmE
         /WVxrctb2Fxt8Gma5H7Huk19KTANeBLbViTYEHhg/2Ovm04X4Lz2Id62pLgOLqNdwJUt
         fP93/mjy/A2al5OG2WOGU0RDlq5yaUZ+m7eiuqFWpiK89tQYqysWJMOZEXh5nawvDfjz
         Gk3w==
X-Gm-Message-State: AOJu0YxLbEfgMSCRxULvBRgtDRIoRPdbX/w8KB60n5WkInpe8QGi+xT0
        4FC1Gnyzdq5yMTVnfw8Irte6nA==
X-Google-Smtp-Source: AGHT+IGdv9UkTnlXLx/5ijBTQR2xHsaXZ87/AXJ/nw5vxj4PW5/dpIBr4LcagbwlUR9FnNBJNYtfhg==
X-Received: by 2002:a9d:51d2:0:b0:6bf:500f:b570 with SMTP id d18-20020a9d51d2000000b006bf500fb570mr3774295oth.3.1697848725192;
        Fri, 20 Oct 2023 17:38:45 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:984c:2fe2:e7f8:bd24:713c:c8fb])
        by smtp.gmail.com with ESMTPSA id h6-20020a9d61c6000000b006cd33d6fd5csm520636otk.11.2023.10.20.17.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 17:38:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Khazhismel Kumykov <khazhy@chromium.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        oleg@redhat.com, linan122@huawei.com,
        Khazhismel Kumykov <khazhy@google.com>
In-Reply-To: <20231020223617.2739774-1-khazhy@google.com>
References: <20231020223617.2739774-1-khazhy@google.com>
Subject: Re: [PATCH] blk-throttle: check for overflow in
 calculate_bytes_allowed
Message-Id: <169784872374.3020638.17698696801548218359.b4-ty@kernel.dk>
Date:   Fri, 20 Oct 2023 18:38:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 20 Oct 2023 15:36:17 -0700, Khazhismel Kumykov wrote:
> Inexact, we may reject some not-overflowing values incorrectly, but
> they'll be on the order of exabytes allowed anyways.
> 
> This fixes divide error crash on x86 if bps_limit is not configured or
> is set too high in the rare case that jiffy_elapsed is greater than HZ.
> 
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: check for overflow in calculate_bytes_allowed
      commit: 2dd710d476f2f1f6eaca884f625f69ef4389ed40

Best regards,
-- 
Jens Axboe



