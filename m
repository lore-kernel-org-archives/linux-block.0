Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71455EB64D7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 13:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjFTNTZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjFTNSm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 09:18:42 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3931FC6
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 06:18:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6664ac3be47so875461b3a.0
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687267100; x=1689859100;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDv8Uw/BivO6RrvEwJ/00b7rhwIWR/7kRwMpgfqYEmk=;
        b=ff0eFdfUzf+2hCmF1W4mqopeSrAORrkWM4dPiQQ1MQ0ecWI986lgYC1PlrbzNsYR3k
         NBVGEpLg4ouh7DeCsiLgKiXfW9tLvsMAFdHlvIZbrxmUgPTAO5qQwQIIBlfwybwgsmqe
         8nZ3TGFRwI8+Z1NAmhicSQP23sm07z0qGH1kT+WnTpmXpHJ/sr8M2LQttdPzF7i2uFL+
         6zHw+8DZMYlYJg7BhFn3XWnPps69+fIXwo7zl8QQSlwtZZ2XgL+USVLWmVRwARGHRtk8
         PXJ+bm2KnWtfRT2PhJOKOXv9QpsP3QBsXIOuA8TsS9631Zg+quV2PGj9Kj5+XBdhj20e
         IueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267100; x=1689859100;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDv8Uw/BivO6RrvEwJ/00b7rhwIWR/7kRwMpgfqYEmk=;
        b=ZChL1ZvSrR40cEkajxuHdtcguiAurdIXkZG4NYismD+0OUil8bnEK76sE7zooPBoq2
         iQku0LO7h8luaqBADmiNwFwjh2f7+j/P6uUsGGVM75z37s0jN3bvxwqXmTZNXdlhtD80
         Kglj/dDkAOWT6MZ8iT9BdzIHtaw0QQvhZEYrejOj6i0Qf0NsMRtPjai7y2KevVhyFnxI
         JSAmwH1kV/6MzlVqbNGLpOJZ/XrvtAX+KW25svuXHez8qpKEXMbDUkzztU7qOSA+mp49
         3zy0ynpo1HOXcDqNv9zcE8pD9MDjIfDAsNq+opcigh5VAgFBnU0Q0VN2E87qRdPKBKWS
         cfgg==
X-Gm-Message-State: AC+VfDzP31b8jRiKcSlYUZe73RzVOHAIZ8B3SqOoN81xziBuxYqjb7Et
        s+8VmAkgzoHN7mHovk+ghBk0VA==
X-Google-Smtp-Source: ACHHUZ6I+p27DwLCdus5zoDSTYiPGLCGR5mjDiZNTNXkMaqLjB51FGpmFf0r16czMDlSW0mlybOntQ==
X-Received: by 2002:a05:6a00:8014:b0:666:e728:9f02 with SMTP id eg20-20020a056a00801400b00666e7289f02mr11717795pfb.0.1687267099960;
        Tue, 20 Jun 2023 06:18:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r23-20020a634417000000b005143448896csm1399994pga.58.2023.06.20.06.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:18:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20230620043051.707196-1-hch@lst.de>
References: <20230620043051.707196-1-hch@lst.de>
Subject: Re: [PATCH] swim: fix a missing FMODE_ -> BLK_OPEN_ conversion in
 floppy_open
Message-Id: <168726709899.3595534.10125964488925318467.b4-ty@kernel.dk>
Date:   Tue, 20 Jun 2023 07:18:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 20 Jun 2023 06:30:51 +0200, Christoph Hellwig wrote:
> Fix a missing conversion to the new BLK_OPEN constant in swim.
> 
> 

Applied, thanks!

[1/1] swim: fix a missing FMODE_ -> BLK_OPEN_ conversion in floppy_open
      commit: 9a7933f3aca9d3b77235953996126f0e87c1d496

Best regards,
-- 
Jens Axboe



