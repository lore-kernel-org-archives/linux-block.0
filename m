Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8D0C5479D
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 18:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjAISKO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 13:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbjAISJN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 13:09:13 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3099AF3A;
        Mon,  9 Jan 2023 10:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=8g+bKvFT8gUpMI2qdr7uiWP3eCJcxkUJxNs6+aS/EVI=; b=QZdXmFXMkMOSNPzHO3XDeLspgO
        8bsblnQF8BlF2dj8u9vGQcXVfNDWN8GwLsamO/0WZUO5kGoM8KRsjQkEWOcOqynotvaeQokMYTFks
        WN751NFGsXT3Xl590vZGLqlsbWTeiMMdm0pJzCU4DtDGfXeJKQD4x3v8sv9dcRbqeYx6dVDoN1U8U
        7wCL8ahvcYumuudzDwoytL1PozYHS8C0J8QP3lpLyh7ISAg2VDn+TS7CPiEyoi4ex8EBVkh4ZUFxj
        xB2l1FChmde21I4bpmMz9GB0tpjvIl2veqDuuT+BEZ+NSTvP0lG6U7cIl1FAI/NOooYTpO6HlfbwG
        gSQebaVw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1pEwZj-00BFfA-1g; Mon, 09 Jan 2023 11:08:48 -0700
Message-ID: <f8168426-def6-333a-53b4-8947341b84c4@deltatee.com>
Date:   Mon, 9 Jan 2023 11:08:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-CA
To:     Yishai Hadas <yishaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org, jgg@nvidia.com,
        axboe@kernel.dk
Cc:     hch@lst.de, alex.williamson@redhat.com, leonro@nvidia.com,
        maorg@nvidia.com
References: <20230109144701.83021-1-yishaih@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230109144701.83021-1-yishaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: yishaih@nvidia.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, jgg@nvidia.com, axboe@kernel.dk, hch@lst.de, alex.williamson@redhat.com, leonro@nvidia.com, maorg@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] lib/scatterlist: Fix to calculate the last_pg properly
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2023-01-09 07:47, Yishai Hadas wrote:
> The last_pg is wrong, it is actually the first page of the last
> scatterlist element. To get the last page of the last scatterlist
> element we have to add prv->length. So it is checking mergability
> against the wrong page, Further, a SG element is not guaranteed to end
> on a page boundary, so we have to check the sub page location also for
> merge eligibility.
> 
> Fix the above by checking physical contiguity, compute the actual last
> page and then call pages_are_mergable().
> 
> Fixes: 1567b49d1a40 ("lib/scatterlist: add check when merging zone device pages")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>

Looks right by my eye, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
