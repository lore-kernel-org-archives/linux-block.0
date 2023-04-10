Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A82C77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 08:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjDJILP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 04:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDJILK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 04:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D3140EA
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 01:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 356D860FF4
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 08:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C61C433D2;
        Mon, 10 Apr 2023 08:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681114268;
        bh=bwk3D7NaT2Wdt11I5hFEezkJpvi4cQOAQkq21gCYxO4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TFbZUyCbhmKLsV+TkJd7+Xmfidl8Hmg64TH/SU6PHc1oOHy4dPTvWpIrT88YCw/1/
         Yr6OnrXFR9R8+dsjI/RXXH1+NCm3DWZX0ahjd/8BPMviA2d5cnnVwgmf+pifjtNMjn
         VDpMn5X+fe3cgd5BIEHlQk2gw5zSVLiJd2bpGgaSfehwvmVl6nmMWBV+rpjSHHAMYQ
         NsuFumzzV52epVK67U8f5l94DIidBMxdQhZOyC3oMELKA46G49ztIOsc0ST/kDVThA
         uefJlTae/hbL3ojXWJYGH87SojxTusJClIy7alZixOZVHBzGJkT7nq5Z3HPGXEcHp4
         4670JkcDEpdeQ==
Message-ID: <02e7a992-fa2f-338a-dd36-9c3959c4f468@kernel.org>
Date:   Mon, 10 Apr 2023 17:11:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 10/12] block: mq-deadline: Introduce a local variable
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-11-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230407235822.1672286-11-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/23 08:58, Bart Van Assche wrote:
> Prepare for adding more code that uses the request queue pointer.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

