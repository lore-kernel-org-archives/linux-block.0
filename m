Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE40EC433EF
	for <linux-block@archiver.kernel.org>; Thu,  7 Oct 2021 23:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62D760FD8
	for <linux-block@archiver.kernel.org>; Thu,  7 Oct 2021 23:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhJGXgR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Oct 2021 19:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhJGXgR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Oct 2021 19:36:17 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B51C061570;
        Thu,  7 Oct 2021 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=tugju1JUEZJBZUFrxJ4ZMrMB9fpeGLyFJeYbcKA9tmQ=; b=rvjgJYcLM7BqOUgQDchuRGKCmO
        tXsd2MgCRhIlJ0F+gc1CaHcnG1wGEd7wwcGba7Beh00SdMNr497gembcw7k4PP1P4Qb72dqvUDVPV
        cCFq38fgYJFJCD+Z/j8/fbKSwRhJ4E3s+SSqFkOQcr7EKcxL2rhlkFdfaOP1CdY+3aQk/Hu0SFKMx
        4ibxG5YR7UnG75qmfPdFZfZgOnhODLMRZLuCqz5jKQaVNA80VnMtwgsrLn838tQt2MmcH/cSc240r
        y8pSPg2mo/+DCMZ/XwtKwtyp7L7pFA+j8XnZ4nHZ5O01tyL9TtxsrqfMBH837FgYFhuBLSgZOTKD2
        MWFy/Onw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYcty-000yBT-IW; Thu, 07 Oct 2021 23:34:15 +0000
Subject: Re: [PATCH] cdrom: docs: reformat table in
 Documentation/userspace-api/ioctl/cdrom.rst
To:     Phillip Potter <phil@philpotter.co.uk>, axboe@kernel.dk
Cc:     hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lumip@lumip.de
References: <20211007231720.31997-1-phil@philpotter.co.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <464a0b2f-c556-ccda-aa3c-26733fba4617@infradead.org>
Date:   Thu, 7 Oct 2021 16:34:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007231720.31997-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/21 4:17 PM, Phillip Potter wrote:
> Add extra space to the first column of ioctl values table, and also realign
> the text in the second column, to fix a documentation build warning
> introduced by: commit 67f1e027c270 ("drivers/cdrom: improved ioctl for
> media change detection")
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 67f1e027c270 ("drivers/cdrom: improved ioctl for media change detection")
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Looks good. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>   Documentation/userspace-api/ioctl/cdrom.rst | 116 ++++++++++----------
>   1 file changed, 58 insertions(+), 58 deletions(-)
> 
> diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
> index bac5bbf93ca0..682948fc88a3 100644
> --- a/Documentation/userspace-api/ioctl/cdrom.rst
> +++ b/Documentation/userspace-api/ioctl/cdrom.rst



-- 
~Randy
