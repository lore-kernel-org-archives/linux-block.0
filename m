Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C97C433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 17:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbiA0RTm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbiA0RTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 12:19:42 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE83C061714
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 09:19:41 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id i62so4443629ioa.1
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 09:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=SeXRjVY9Q4YMFH/0nT9DEyoUFf/9IS91BdFB/cZlSJA=;
        b=P5qbJwDNwltmD9CyLlTzaoOs4EcO4GWAu5aJKZGaFFp7qMYKNsqNU68qxxN/hPGsFD
         BmBF0+FL13a2Zs7K2DmIz16Qa71CCcLIiDEglAC4/Cyb/p3yGqa3qRrfVdkjmC+2IBm4
         B1lXRXw69o9K6Xf+pstdoEpC+GSDG5OOOp7NdOydhNRaZAS2Zmyip6Cn9UC5s6eTGvJC
         +aeU6vI0FFujmGign6ArfDxcsGP2tV7q6XLcW6Xb9p205TFG9OxK1YFBusZFElvK0Uay
         /HNt1JwPTfazzN+0TIXshOOXuAOi8YV6YLZQWyDNn75rh4RAfTXALReDBKuK23ZcHjo5
         3gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=SeXRjVY9Q4YMFH/0nT9DEyoUFf/9IS91BdFB/cZlSJA=;
        b=bQk7o0TOP6QqaY+oq67T/Sl16Fd1mx4TQSlccLvw0QEoxSCuCRCUrRuKJp0KcO8vDr
         l+3S7e9H3DY0Bm845UOIJrJCutzCjdWm0MLZ/Ms7Mng4hHGwOrH5is96OddcYltR1W3n
         ZJIPDKnXVeOw9XD7US6vJOd1v+plGTIEVags5oSTSmhXQn87O0EujCdcOImtxljAxVMx
         5G1A513dzB+OMHj1TFO0/6MlOX4cKOQ7P109a0GJ2YefpiFR58pd5lkjmy+BZnpqg9Eb
         dZTx7OaLypBvKCjRLRpd+OaAJ1GvKNDoYa9k6Uy/VwuHJoRIAx4t4wpOmC6dFgjHgCh/
         vz3A==
X-Gm-Message-State: AOAM531GP3P6scma6L4lJ2Lg82viBORSVJy03bQDPFQUEQ4Siua3RVhM
        T9wMlEFYH5WWKveuzUZeQQvYZzf6ZGpP1g==
X-Google-Smtp-Source: ABdhPJwuqe8N1RbR24xkG+UMr2VmXEmUjtK7I8UPHnfnYWcJQEe+Qt1lFaocPxlKztU7Swx3f7MxYg==
X-Received: by 2002:a05:6602:2ac2:: with SMTP id m2mr2565606iov.103.1643303981279;
        Thu, 27 Jan 2022 09:19:41 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f2sm12839063ilu.79.2022.01.27.09.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:19:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220127070549.1377856-1-hch@lst.de>
References: <20220127070549.1377856-1-hch@lst.de>
Subject: Re: [PATCH 1/2] block: remove blk_needs_flush_plug
Message-Id: <164330398052.211167.14801879231624002504.b4-ty@kernel.dk>
Date:   Thu, 27 Jan 2022 10:19:40 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 27 Jan 2022 08:05:48 +0100, Christoph Hellwig wrote:
> blk_needs_flush_plug fails to account for the cb_list, which needs
> flushing as well.  Remove it and just check if there is a plug instead
> of poking into the internals of the plug structure.
> 
> 

Applied, thanks!

[1/2] block: remove blk_needs_flush_plug
      commit: 1642097f8e40bf81c9c5976879a561eb098fc6d8
[2/2] block: check that there is a plug in blk_flush_plug
      commit: 1741f0be918539f186e8262d4bd020629c60b400

Best regards,
-- 
Jens Axboe


