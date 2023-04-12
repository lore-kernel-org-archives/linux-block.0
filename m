Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B90C77B72
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDLHqN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjDLHqL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:46:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1752A213A
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96C4962878
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B81BC433D2;
        Wed, 12 Apr 2023 07:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681285570;
        bh=/uR3yUR1zsH+ueUiypH5P4wE4pcN4UeVhXzPicqZTqQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fYYNvkn9C5bCrI8XI3YpuHkPt3SQX2UqWKYnQIiLXV5q3AzMJCjWP/oPJeqP4pWPy
         iKkACWscAcsSHmxLRjanQ9mJEFy65d6mPSGCAV6BkdZJvJ/3eXqdgi727W4b0VxTnD
         2FscJTPfwMiLj9BstWR5PUTaCqQfj2rEQ5Z0dxb8HLFDUhd62Id7lJ3xV3htSXXgSh
         hBe9vchsluZOAIJWTrPX+tQEf5wCqeaXnt5VeqiL3NtFAC0wIyXxsSaAx6b2qphkor
         4YplX8PxUjPoHLbDPwYdcgxIHspJxJaWiKSTD8/iZ7F48vFFIkBr9GO+oEXNVDBwlh
         6JpOiXjBN9AgQ==
Message-ID: <4c702fc4-03a3-300a-0873-6af1da4a557a@kernel.org>
Date:   Wed, 12 Apr 2023 16:46:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 17/18] blk-mq: pass a flags argument to
 blk_mq_request_bypass_insert
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-18-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-18-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> Replace the boolean at_head argument with the same flags that are already
> passed to blk_mq_insert_request.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Nice cleanup.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


