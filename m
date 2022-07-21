Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E318C43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 17:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiGURDz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGURDy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 13:03:54 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B97C76447
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 10:03:53 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d4so1088473ilc.8
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=NZYobLlW+Bkdq9rfIBNLs6iBowi/+bmHxPb9jaIyWpM=;
        b=zJzS2iNvJDzCbYV91AzrWte5PMTLMJNVOeqmlpSiRcrPyg62GL6qen6vKllorPtwBP
         P94IQga8tprtO4NSKr+52wnChBHHmVvJsqOQmHYlIjoVfHejk0GEPLJdSGFmtbsl6yDg
         CUFtdBpTfxgZ6RoWolAv4wpUdzBFYSEnUYbP74zB+Z0ECWAXO8GD1MmwsvQSZ6RKebmp
         ZWxlltBwo441wa1lwL49VnMUAayyg8OqzSAPKFQ7mUW2UBb4X3vzM9dOswoB2y5rLXQ1
         HbONSACjHF2ozqk6DmdFmy38QOjO37VF6dPqg2AOiXnaQZ9FGaX6jW+ckIS0055szYpv
         CP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=NZYobLlW+Bkdq9rfIBNLs6iBowi/+bmHxPb9jaIyWpM=;
        b=qfLGIG1pJMF7g+v/H7WwTfSmnt2EmvXZfhUJ+tdCdH8OmFvfGGTcORAUMM2p1jT4fh
         fTW1h/Ivt8NryFbZ/xzHBRrpPQxBFQ6IR/Tiyr6Qfeyz3u4rUm98PDG0ruWqh19cVKMl
         X9bsdxEGarIvm0Pq2eu9L43N7TtdZnJwGE1XtVTv3iw/cEwZGUdjPKMj1QaFgluL+P2U
         stl4z8Y2ihJe3930TbCKKY9jA8lUjVN+TPh3eXRiGERalXHA8kvEEGCQGBd8kA6jInQ1
         qxw/tB43tB9Xf1Op3ZQEKEUmdsdda9YrQH4L54iXnU9NMOd+rBbjSCe6NnKzb18R5PHC
         ekZA==
X-Gm-Message-State: AJIora+EDNNTGw3GrcXblabcSilhenwPG7vMM2vIldv7UrfOOJDevbzO
        sori9v1S+/pd5dMQVhi+aerWS2aAsSMBrA==
X-Google-Smtp-Source: AGRyM1sQW+kaXpXExlPaoI4zNgcI6d58I7cuLvQ/jEPyhku0WepOE0IvIbWDfkr/sEIWOxTGrNg+8Q==
X-Received: by 2002:a05:6e02:2161:b0:2dc:e67f:30ed with SMTP id s1-20020a056e02216100b002dce67f30edmr10370147ilv.293.1658423032216;
        Thu, 21 Jul 2022 10:03:52 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h76-20020a6bb74f000000b0067baeb55e65sm1082749iof.38.2022.07.21.10.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:03:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220721063432.1714609-1-hch@lst.de>
References: <20220721063432.1714609-1-hch@lst.de>
Subject: Re: [PATCH] block: remove __blk_get_queue
Message-Id: <165842303165.67132.14478442233940072264.b4-ty@kernel.dk>
Date:   Thu, 21 Jul 2022 11:03:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 21 Jul 2022 08:34:32 +0200, Christoph Hellwig wrote:
> __blk_get_queue is only called by blk_get_queue, so merge the two.
> 
> 

Applied, thanks!

[1/1] block: remove __blk_get_queue
      commit: 828b5f017d9d5d0491cd2e71d48f4f2139078e2c

Best regards,
-- 
Jens Axboe


