Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3588DC4332F
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 16:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbiDNQu3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Apr 2022 12:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242230AbiDNQt7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Apr 2022 12:49:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE963CB01C
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 09:17:00 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b15so5294492pfm.5
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 09:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=hqerBM2cZBJXF6hQzzXhodPJyptooGbxqxXJnHKLZrM=;
        b=W2WlD3bntJ+C3w2cZ7PdxHR9YgWoJxAAqchvCEk5p5YLW3PaGBORF065TIqJlhlxez
         E11VhMhNUdKI1aIeI9I3qp1pSos3SqbSKeE979YaUFyFobPAgqn2aLyjvykJMEFnNvge
         qem2yf+jHBqKM6Yxkz5bil9zxmMVK3v0NRrvLbZ7U/HMGd9zu+nQaAH8GLkrywWtdJBf
         8u927uNMEYnRxFDEVRf36f6i7GB9yqZp9+/6+Xe5J65GP9pCUfwamt/SjJkbb6komm8Y
         Zfo2Wsy5klV9CZtbTXTpoErrdLUXe2p8X44OG79QAc+oyG1viJS3iWIQLK1cLy8qhP7e
         d/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=hqerBM2cZBJXF6hQzzXhodPJyptooGbxqxXJnHKLZrM=;
        b=Ho8oCqRjOd+x0hO+daKu5Ch8IKtuUnJAnyCLkizF22qtYX6XG4prWCaEojaEPdXcXf
         xGdttDwa3dweOUd9Gv1vikvZa8v/Vweyg1kR2E7vzaGJY39d0LhBO8q3Jvr52tQCyTsB
         b7qTfeqhk1jfT0kz8NkYxTF+g8U43fD8plztaXwBHclP19rVc2fbvInqb4uXaRuvprr8
         FRxxp76YZXdM9n8z+z3tkWirxYcEgj7ZruRVmPHznyAOuZAUAyeH6qH75Kw4qEH0R10a
         eFBWQIh4+zjTtY6pXxkCh9x1+wQyhZVZaBxCF+exb7OJoxslUSi5QzBizXpEGAovW19y
         bBwA==
X-Gm-Message-State: AOAM532uXu1+hfuv6KpTL8kVQhyTLJGCrKQOfcqyosXZaTTpIJLJ6lxQ
        k0qZDceOka3UJ3b2uU5EikqBjzdKBTsR5w==
X-Google-Smtp-Source: ABdhPJxPTbg/yLHZlyn18/qYrCBMLF69x5P5EUvhRL1a2F5a+zCLoglA+wkj/mipK7mk67T5D6JVfA==
X-Received: by 2002:a05:6a00:22c7:b0:505:9c6e:de39 with SMTP id f7-20020a056a0022c700b005059c6ede39mr4707314pfj.79.1649953020015;
        Thu, 14 Apr 2022 09:17:00 -0700 (PDT)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id d9-20020a056a00198900b00508379f2121sm371750pfl.52.2022.04.14.09.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 09:16:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220413084836.1571995-1-ming.lei@redhat.com>
References: <20220413084836.1571995-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: null_blk: end timed out poll request
Message-Id: <164995301885.65344.9694686883938607293.b4-ty@kernel.dk>
Date:   Thu, 14 Apr 2022 10:16:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 13 Apr 2022 16:48:36 +0800, Ming Lei wrote:
> When poll request is timed out, it is removed from the poll list,
> but not completed, so the request is leaked, and never get chance
> to complete.
> 
> Fix the issue by ending it in timeout handler.
> 
> 
> [...]

Applied, thanks!

[1/1] block: null_blk: end timed out poll request
      commit: 3e3876d322aef82416ecc496a4d4a587e0fdf7a3

Best regards,
-- 
Jens Axboe


