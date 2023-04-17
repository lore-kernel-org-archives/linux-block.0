Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFABAC77B70
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 06:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDQGep (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 02:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDQGeo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 02:34:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5CD1716
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 23:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD9B661E6C
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 06:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC44C433EF;
        Mon, 17 Apr 2023 06:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681713283;
        bh=LXBUSm7v6VZfFUkIGNkrn4I+eliKrFHnc0Rn+Zwaoo0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uphxyDoY1y/194TSbO9l2HRLV13qYi8lGa/FbEKXVt8//tmje7g4h8kHFRXAkBeNA
         3UfETe2IRnshfXqTudH3TM0hKDB7I4iI8O028ASsaktyrXiigZDCk8vK/F+SmZRKKs
         ce4IImQeVPc1eoqXiFThotoBqII9oO25nfOk+x5NQ297e+4OYuWwpw0QyRsOG1y44C
         Elyg8m+nBwnBHuyRIk0c/4oet5V1850oERgIg8iS9XD9HKaLJN9RDxwATxEFvt5t9K
         CG+7x5VWnhDcyRfbPx/lGLEfBAVNOXciupj2VBewoMZytQ06u4R2uXtdSKf3DIq8qV
         yQuFEanAn0rPw==
Message-ID: <7485179c-8db9-f98f-35de-9664e2f2f7ac@kernel.org>
Date:   Mon, 17 Apr 2023 15:34:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/7] blk-mq: also use the I/O scheduler for requests from
 the flush state machine
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230416200930.29542-1-hch@lst.de>
 <20230416200930.29542-5-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230416200930.29542-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/23 05:09, Christoph Hellwig wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> Send write requests issued by the flush state machine through the normal
> I/O submission path including the I/O scheduler (if present) so that I/O
> scheduler policies are applied to writes with the FUA flag set.
> 
> Separate the I/O scheduler members from the flush members in struct
> request since now a request may pass through both an I/O scheduler
> and the flush machinery.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> [hch: rebased]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


