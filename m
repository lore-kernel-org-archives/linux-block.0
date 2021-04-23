Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1D3C433ED
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 22:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5872D6146D
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 22:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244088AbhDWWFe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 18:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232657AbhDWWFd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 18:05:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DCAD613AB;
        Fri, 23 Apr 2021 22:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619215496;
        bh=5I7f25efOcuG4ieJvT0ovuYzdBDs8s7FIQEiKrfubsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJb1BLuwgvbLCn3VOnhT8g24kS+Qsf2bpOjaVfgt2Z4Ff9xTWV1LjqeWo9kHkyXy8
         5YpmTsSdRXxVQsrcNweb9QwPQ6FOYLc1Xk+u7n9B3a0KWhSYdDahYp+5OQy8CUCfqH
         aCE82GpDMUc8GLw0mq2+elsaYvOwHD3TaFSkQZ5wEQLdZ59UIDFPGgmSf+bcsWOxSf
         dzaIaKc18vDEaOAcXBjAMDKRo4e1LdMEHXmtRgiBopCRszWsruJuv9l8fI6m1NOQcx
         0ORszVHhg+KqKm9yyU1XxncEuyzB91jGYdUO5dG1DhDrRixNiR8ngWqatwFrISXRrV
         p/sgGk22cnMGg==
Date:   Fri, 23 Apr 2021 15:04:54 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCH 1/2] block: return errors from blk_execute_rq()
Message-ID: <20210423220454.GA40699@dhcp-10-100-145-180.wdc.com>
References: <20210423215800.40648-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423215800.40648-1-kbusch@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sorry, please disregard this series. This came from the directory of the
first version of this patch, but I intended to send the v2.
