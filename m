Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D778C64EC3
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 16:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjBFQ3y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 11:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjBFQ3r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 11:29:47 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF1A21940
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 08:29:46 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id o1so4634205ioo.10
        for <linux-block@vger.kernel.org>; Mon, 06 Feb 2023 08:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0wSgKUacGM7xvS2cBdhx6arq2ihGPco/pYthVvg21s=;
        b=Ou0qdNl+W/3pD5Mbs69QEZlUJxBjbP/Ce2eJ6WniAHlvyInm8n3xyoJdQ7XiDRXg0b
         xzZ92HBKHjYYbeYiJJJj4s5iSyPy5+Mfg4cQJPYD9Tl60e4vs5/Dr9XKIcToo1npe2QS
         foTxzyzukpuC6bz1ZWMoN/FfogeZMd0u7BbuOIoGYuCzrCg44AfTaIznrEdvwkfOsZaY
         j6Ao57G3NoDmclo2trDIPF1bKhSpWRy6tk/PCurQgUlTXEJYkFjOO7s2dxMIFA3gz7gK
         XLIZplBWMHRpG1maWxefNiqFF6YN7iH5r25xPkNabqNbX+yCZDk4dbs1UITOUgenXHqd
         +Zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0wSgKUacGM7xvS2cBdhx6arq2ihGPco/pYthVvg21s=;
        b=lZzJgniXwx9ul0YVtaK3dFe5dI2yGBHVH+b/4UrjTpBaukJIpTEQSveqwKbZ+vMVCf
         3XBc2k/aUMYIhxnf7U5fgwt25fmtJVJNQkFIcwWoa1Tu8J/DiV5Fp6FSHpxaHfxPYjCN
         hrquhOk8NM7anRsX+26dF+6PGk4RqiaxMPGSZ20qH+8vIjLbG/bXqt2AMgaSURnld/58
         2wpoEyih7LPjMN1YMZWN+4ABVLCVLQSYs9dnG+R0f/PosicuKzURVGCzGyKWGFv3+7M0
         /YwNJoZTNqIDi5qTo78xYlDRCdjcIw45QrXhzuBHYLn5yxTrSTaIlu5JIbz+rMn5rvYi
         p3+A==
X-Gm-Message-State: AO0yUKUAV+4xBiTGhUDF82ZzJ/xNdRLJyx6QBnp20vQDuwNmxHgr9T9E
        wH3SIBZKGeuQBQ7K4YKSqpd/XQ==
X-Google-Smtp-Source: AK7set9bUNSjke79Got4lwtiThY2fA3KOJf/RNpPFWIB2xPST2fTtzAuMaafu5jj49Tkp0IAgPgvyQ==
X-Received: by 2002:a6b:7808:0:b0:71d:63e5:7b5f with SMTP id j8-20020a6b7808000000b0071d63e57b5fmr13132135iom.2.1675700985321;
        Mon, 06 Feb 2023 08:29:45 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dl6-20020a056638278600b003a60b0b09d1sm3575949jab.5.2023.02.06.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:29:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-trace-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230202141956.2299521-1-gregkh@linuxfoundation.org>
References: <20230202141956.2299521-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] trace/blktrace: fix memory leak with using
 debugfs_lookup()
Message-Id: <167570098443.24242.14188383758966607556.b4-ty@kernel.dk>
Date:   Mon, 06 Feb 2023 09:29:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 02 Feb 2023 15:19:56 +0100, Greg Kroah-Hartman wrote:
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at once.
> 
> 

Applied, thanks!

[1/1] trace/blktrace: fix memory leak with using debugfs_lookup()
      commit: 83e8864fee26f63a7435e941b7c36a20fd6fe93e

Best regards,
-- 
Jens Axboe



