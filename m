Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2DAC433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 16:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbiDNQuH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Apr 2022 12:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241562AbiDNQt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Apr 2022 12:49:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D770912F6CF
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 09:16:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id md4so5551790pjb.4
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=+3YL7xsxkp4ZsyCEqThL1D+Zm3/9GD1ejK9GaDebASo=;
        b=JfQtc5oSpuASNaoRI1FUvOkwlTC2Z8OV3ELozAQF/W4HjtGwjE7vTAGXJwGHYWygtd
         mNkOxcFL1OAibRQD8qEA01VahW/Rix0Qu3jtTZp5XPeCD+OijJsdHMWNJEgJkgpv+Oyc
         xaU4XoSIcaZ2opRta0rUBFiR42j77+DMansESxRffqUVuyxbEprix+pMNNgR7vj/E29P
         ssv0LekfnBK/4iqfpoRr/NJueM44Hw8NAHgPDhQPrWUWQzlWLVod+2MQSaJH3XYI14QL
         hMTtLLnte3iKy+blJfhJVSZyehzXmjg2wxcWRCeLMnQqN+Y4H/jIUdo0jccg+Z05VpUP
         Gvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=+3YL7xsxkp4ZsyCEqThL1D+Zm3/9GD1ejK9GaDebASo=;
        b=hbtzET5Fd5Kd2PSy5qVhhUQLhehMNxcXtzMN0qlP3XkK4iYzrKnr18vnmFO1K0YPH9
         1M3uyWbzYbq+EG7DrdmylTTx0efUsDcoJ06hRruAOHEcIHtBvVO/Q8OXHWkd9OwwMidR
         EgwczBFK4gS2D5M7fRlti56/05sYJQWiBjBYcF7ESfUyLvs8VPnsNzQk4lHTyymeCerP
         jBSjyrYEd1iwoSYpM05dJrW/V0HWuUYMIO/HSiqKjKSNeqY18Ys8Y25LG1Tnhfenymr+
         M6uxwkwCQsFa8IiI2HFh+xsFQ2Wdd0Pdbj5N4V0mch3ryiavqk8ZhiHpSR8+iThRCjl4
         SwQA==
X-Gm-Message-State: AOAM5326fyeGVQr0RvHX30x2EFtLwveobW8PUD0YD9YoIQKzMlKUHq0w
        A2vZaPbmNTCjBVZLi06qSXdX8O9zbhghhQ==
X-Google-Smtp-Source: ABdhPJwu9MbPs0eN26XrCxvA8w+gJneIlMspr+QXwP+/HFurvr4PduwbXNro/jOJK/c0YphDwq9iTw==
X-Received: by 2002:a17:902:e8d1:b0:156:5651:777 with SMTP id v17-20020a170902e8d100b0015656510777mr47994684plg.65.1649952975019;
        Thu, 14 Apr 2022 09:16:15 -0700 (PDT)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id t31-20020a056a00139f00b00505b8a8ac08sm368014pfg.160.2022.04.14.09.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 09:16:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     chaitanya.kulkarni@wdc.com, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
In-Reply-To: <20220414084443.1736850-1-ming.lei@redhat.com>
References: <20220414084443.1736850-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix offset/size check in bio_trim()
Message-Id: <164995297405.65099.2455811113060249522.b4-ty@kernel.dk>
Date:   Thu, 14 Apr 2022 10:16:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Apr 2022 16:44:43 +0800, Ming Lei wrote:
> Unit of bio->bi_iter.bi_size is bytes, but unit of offset/size
> is sector.
> 
> Fix the above issue in checking offset/size in bio_trim().
> 
> 

Applied, thanks!

[1/1] block: fix offset/size check in bio_trim()
      commit: 8535c0185d14ea41f0efd6a357961b05daf6687e

Best regards,
-- 
Jens Axboe


