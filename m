Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F65C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 14:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE41611BF
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 14:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFVO7k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 10:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhFVO7k (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 10:59:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 893F360FEA;
        Tue, 22 Jun 2021 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624373844;
        bh=IhVaTTUCiqZBUzrBWDJ4f9rLfQX0JQeiWSx14O9TNuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAVdnLQqGc7/MA48bzs6ct6xcAP8PQKjzNsfhFhqCVvu7l/7BcS487EGU7jtzNc2T
         /Ip11ZTekAxYxVWu+AT+OXrCbRcys5+GpGhQZEGicA/lPCzenlcWcLZqgxmEaGDeFm
         KqhAUGIEkEi3SWA7SCf6fJEgRZ7fhO1q1mWJptckzP6u3rcLg+mjS88Z8PBaSTpGoF
         j0LF7yLOf5HeCxluFwVcEkmRYWJAi71O3VbbYagBwfXXSp0bHrtkrh7ptRu5uwmcUx
         +SPlbZsUAZsKzuB8qReO9/5AoorNFPVo0l4V05HoYiZnlzsUWEiQG/AQhxNdKVxqaI
         ZM+rg4A+iowog==
Date:   Tue, 22 Jun 2021 23:57:18 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv4 0/4] block and nvme passthrough error handling
Message-ID: <20210622145718.GA11584@redsun51.ssa.fujisawa.hgst.com>
References: <20210610214437.641245-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610214437.641245-1-kbusch@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

Do you have any thoughts on this series? I think it's good to go and
have received reviews, and just want to check if you are okay to take
this through block.

Thanks,
Keith
