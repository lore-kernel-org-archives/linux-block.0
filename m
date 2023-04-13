Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25D0C77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 12:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDMMr2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 08:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMMr2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 08:47:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EDFE46
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 05:47:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2449909b74fso529029a91.0
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 05:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681390046; x=1683982046;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfNvO27FUUcwk17jr9f62z9pKd1Z17+cp4a1LRJNTgY=;
        b=r7+mQBWl13/V0jyLm8RLHHEEscowFuuG87Kz9sVsS8L3478L7vUM7ldIQMDInGqWop
         7OZ+xXOUMzP1QmMq97jNBfFf/Y84F72iibtfTnKKplWuw1xwZQK/OY3+/4B3IfRTVoTw
         xPWgmKefYLt9jIHE5TvDZU7zpLmWJYK3n7Kj9tJX0Fo3mFvVCC5B+vN2q0kpd0717TDU
         BMKVtHp5nTdApZEWNoccWxjsDJxpnu1lWxoZpi3H8PbqPgEQWet7JO8Brc4R52dpiq5b
         fwO00ddeef01ZSeLQ/NgleMdLtk9A6XU+HEL1AsoF1BqaiIn0W6mQQ8iXC6GPfX05YSs
         09kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681390046; x=1683982046;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfNvO27FUUcwk17jr9f62z9pKd1Z17+cp4a1LRJNTgY=;
        b=U1kOJSP0jAKvfJ3phUe8IOIGY4LxR9mnBbNY92yKd0KhAW/JZOrN+3YBfpCHTTynHM
         c7ZCF0pWjP3hFK5JxexC6BjZBQxKi1d+t8/9JVYPobeHpJ+MlBX62uZZTJ5rYvFlQyKh
         HU2nJGtbsx3GmiX7KfrZdHdTzquQX9iqedPZ6Xin/jXykzFKo57X5wf7UACdjU/stth1
         KJmizqagYIsJX1KRa8vPGl2fZj6bzXCZEMxVuE+4QSW4154Bwftl2PLSUlSZWkQyWsze
         J5rp2OFKtEhWl3F2u4jonko5IFT3qqEvN3WuKlWkerLhsX072wzSxqZ6AE35w/EOhM4+
         XpHw==
X-Gm-Message-State: AAQBX9fylUoBjHOA2kfAYdVoOvcTLD/VfjDOcSIBHx8azbLOfkWxFnqD
        WWEeSu/9R9gw1KmC4JvVQ31X/IbYVIPvxBES4io=
X-Google-Smtp-Source: AKy350ZzTacf/Pj1nAICBWl0AzO32wMxQuWuAbZMfzZklabZLnr+Mzch0LEgybKb/LU+k87aA19D4g==
X-Received: by 2002:a17:902:ce92:b0:1a2:1a52:14b3 with SMTP id f18-20020a170902ce9200b001a21a5214b3mr3073104plg.4.1681390046649;
        Thu, 13 Apr 2023 05:47:26 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id g21-20020a170902869500b001a5260a6e6csm1410819plo.206.2023.04.13.05.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 05:47:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, hch@lst.de, Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com
In-Reply-To: <20230413000649.115785-1-tj@kernel.org>
References: <20230413000649.115785-1-tj@kernel.org>
Subject: Re: [PATCHSET v4 block/for-next] blkcg: Improve blkg config
 helpers and make iolatency init lazy
Message-Id: <168139004581.7900.17121403006264906726.b4-ty@kernel.dk>
Date:   Thu, 13 Apr 2023 06:47:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 12 Apr 2023 14:06:45 -1000, Tejun Heo wrote:
> * v2[2] fixes the build failure caused by v1[1] forgetting to update bfq.
> 
> * v3[3] drops __acuquires/__releases() changes and updates patch descriptions.
> 
> * v4 rebases on top of the current block/for-next.
> 
> This patchset:
> 
> [...]

Applied, thanks!

[1/4] blkcg: Drop unnecessary RCU read [un]locks from blkg_conf_prep/finish()
      commit: 83462a6c971cdc550475b672cf29bd3b53bedf84
[2/4] blkcg: Restructure blkg_conf_prep() and friends
      commit: faffaab2895914a803e011600164683bf747fee3
[3/4] blk-iolatency: s/blkcg_rq_qos/iolat_rq_qos/
      commit: 3304918758125a0eb18fb480c82945e327b81f78
[4/4] blk-iolatency: Make initialization lazy
      commit: a13696b83da4f1e53e192ec3e239afd3a96ff747

Best regards,
-- 
Jens Axboe



