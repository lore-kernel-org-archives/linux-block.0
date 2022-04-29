Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB56AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Apr 2022 12:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356212AbiD2MtL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Apr 2022 08:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiD2MtJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Apr 2022 08:49:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26F58BF0F
        for <linux-block@vger.kernel.org>; Fri, 29 Apr 2022 05:45:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p8so6819589pfh.8
        for <linux-block@vger.kernel.org>; Fri, 29 Apr 2022 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ocs0mbwWAgp+tAzV857SlK6UIswo55neeWcWC4SY3Dg=;
        b=M75tT7fYDZfjp2tooPLlxMQYQCHtfgnPjxrcG9sjO42fIEVdkZaBnWBzOBXOEmYC9W
         JabKq23L0OLWu8ahSAEd6NPC3Sfeq91RQmUzFmjWiz4Ws889UkTQi1Fk81nTagfrlfWu
         K23tTRDPhdroVfIEBbspC8P+AglAXcN+MIvl8wK2OmLa5DHdQ/3VwU6N16EHIuBeYRKi
         OPJGTUV5KkJ+9ELMNfwH+ihmvDC1E9uPkW9uTbSx2wp8H0o0P+TbBP3ECVmyi4BaHlRb
         08sKokJAjEYkmy3pUBk8kB/Y18B8zN3n6WJqZ5QD1zgR+qTs1qncEBVKors9RsYHTRoN
         aukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ocs0mbwWAgp+tAzV857SlK6UIswo55neeWcWC4SY3Dg=;
        b=r0BGWF0Cij7FUYFGftPFdTA4fBrtUBNTBGlTJPPLth6xbQx7Hae5XuAc/Vvi2d+97z
         3JO0wfzqDFQRz74hWzcebqw7XJZrYs6gy5m/LG5cSYzAElf/nZMglydDWfcEKWW/ROFB
         0OXaQEIYJhS+W1UwQ0nFG9mlCMZDGlLIzdybaYk5ajJuoBgPBT14m9MyciElvn2VCDDv
         F21pNdMYAKUrFbX1Q/HwLBld73t5+Cx6z37dfSxsys2jiMnNR1BkOXBOP3RwLNw/YFHf
         yVHBUkQpzXqTqZCJh0vX1kEPilBIjCrGb5itU00/gSwDK+awAw8X9Ekl8mWtLmunWvoW
         GWtw==
X-Gm-Message-State: AOAM533+Acr5EbVaSHdzPnx81WwS+YHXtrUYPELUwAUM93F2v7543uMw
        ITiD4FtviO4PzZkzSQBhm5lgsA==
X-Google-Smtp-Source: ABdhPJwKlSzZpHDij9KxX7qhr19A8CctJ49N5nK9OCJnkYsL5jYSRcGt1HiFqXKIJmXzYMOH6YWc1Q==
X-Received: by 2002:a05:6a00:1749:b0:50a:8eed:b824 with SMTP id j9-20020a056a00174900b0050a8eedb824mr39902311pfc.50.1651236351379;
        Fri, 29 Apr 2022 05:45:51 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x186-20020a6363c3000000b003c14af505f6sm6010824pgb.14.2022.04.29.05.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:45:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, paolo.valente@linaro.org
Cc:     yukuai3@huawei.com, stable@vger.kernel.org,
        linux-block@vger.kernel.org, lists@colorremedies.com
In-Reply-To: <20220407140738.9723-1-jack@suse.cz>
References: <20220407140738.9723-1-jack@suse.cz>
Subject: Re: [PATCH] bfq: Fix warning in bfqq_request_over_limit()
Message-Id: <165123635009.46786.3093085989076098329.b4-ty@kernel.dk>
Date:   Fri, 29 Apr 2022 06:45:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 7 Apr 2022 16:07:38 +0200, Jan Kara wrote:
> People are occasionally reporting a warning bfqq_request_over_limit()
> triggering reporting that BFQ's idea of cgroup hierarchy (and its depth)
> does not match what generic blkcg code thinks. This can actually happen
> when bfqq gets moved between BFQ groups while bfqq_request_over_limit()
> is running. Make sure the code is safe against BFQ queue being moved to
> a different BFQ group.
> 
> [...]

Applied, thanks!

[1/1] bfq: Fix warning in bfqq_request_over_limit()
      commit: 09df6a75fffa68169c5ef9bef990cd7ba94f3eef

Best regards,
-- 
Jens Axboe


