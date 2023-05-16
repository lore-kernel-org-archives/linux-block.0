Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532D7C77B7A
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 23:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjEPXYG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 19:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjEPXYE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 19:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C54A769D
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 16:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5EBC635BE
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 23:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679DDC433D2;
        Tue, 16 May 2023 23:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684279417;
        bh=2q4xbDE8CS4CymxASY49WYegES2YRcfMzoF1xx0PHiE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I7qRz/mZipmDTOE/jj+hw/k0DqzYWI7T67ih4JZI49p+KbaM/Bb8uHuni/pmtlYXG
         amL/s2+ujW5jlPrS5pYE3m6O9DPO4FoX+wH9+CE+nKVcrMfmkxV18QWTJJWZuMvRIr
         DIcVymLzIvObgDOUjEHKbatOUwxo3egWZD60P3wugJSBncpkmJaYO+z0qAzIED1Gsr
         cP9OgE8icGDI8hu0JfrFT4xAYi0htahaPfjZglabLk+wtYRSBQdv2ajHKKe+/PL6Sm
         tnp09YvbLTiEuPheebtefNAIaNXW3vwVh947V4ZaGs6hGar9+0nAyo0bQD9H/uUfGf
         0xD+DvzbXbJ7g==
Message-ID: <1f8a48ab-30b5-3025-507c-24d41d098509@kernel.org>
Date:   Wed, 17 May 2023 08:23:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 01/11] block: Simplify blk_req_needs_zone_write_lock()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-2-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230516223323.1383342-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 07:33, Bart Van Assche wrote:
> Remove the blk_rq_is_passthrough() check because it is redundant:
> blk_req_needs_zone_write_lock() also calls bdev_op_is_zoned_write()
> and the latter function returns false for pass-through requests.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

