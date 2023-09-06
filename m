Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD6ACCF9E9
	for <linux-block@archiver.kernel.org>; Wed,  6 Sep 2023 01:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbjIFBSW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Sep 2023 21:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjIFBSS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Sep 2023 21:18:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D0D1AB
        for <linux-block@vger.kernel.org>; Tue,  5 Sep 2023 18:18:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84519C433C8;
        Wed,  6 Sep 2023 01:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693963095;
        bh=a4h8krTsQr/eqQkMm2Qq9ZUbpwv1f6fkCVKOOEHSUC4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Vkrr5Tyo43EusLMJJU8vRx/FRH3idDumCKYE/Ij6ocIOJ0/oVWFhs6Aghg7s+VLA0
         bLbmUvW8mHLLdbTn+Bg0STTLR13nIPA/33i9vYgO/gZqiYiYezY+Do3pyFqL+iZYP9
         9RgjejddvLswaoRTpkgFz2mrHsp+dcyZy/xQNs9aahkP7usp+oKRKH71Lb1NRFH4bB
         RgzZ9zQJAC16k2IHN2gwvHnsaQ32q9Ykz+c7MuegB+m2kKuoY7eff48BnrMZsMP108
         CVgWUcHWQJ8MBzAsRoR3lZI7wzWROZABJ8GrtaI1x4WMnTBo7qm54mkuTmaFxnOTxN
         vqtFqKqdb5lPw==
Message-ID: <aa1a346e-0894-8501-5837-5f638ab162f8@kernel.org>
Date:   Wed, 6 Sep 2023 10:18:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] block: fix pin count management when merging same-page
 segments
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20230905124731.328255-1-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230905124731.328255-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/5/23 21:47, Christoph Hellwig wrote:
> There is no need to unpin the added page when adding it to the bio fails
> as that is done by the loop below.  Instead we want to unpin it when adding
> a single page to the bio more than once as bio_release_pages will only
> unpin it once.
> 
> Fixes: d1916c86ccdc ("block: move same page handling from __bio_add_pc_page to the callers")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

