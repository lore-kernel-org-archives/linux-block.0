Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9195C001E0
	for <linux-block@archiver.kernel.org>; Wed,  2 Aug 2023 15:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjHBPhw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Aug 2023 11:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjHBPh2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Aug 2023 11:37:28 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D812930C3
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 08:36:34 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7748ca56133so67331939f.0
        for <linux-block@vger.kernel.org>; Wed, 02 Aug 2023 08:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690990594; x=1691595394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=673FNT9+5mnaLVg5PRS120UPJdmtYWKDCkh6MjsqAGk=;
        b=R4amrDn6vllXAmBsGQnv9oHwNxdRbsqsTtZSo7STLE0X4xCcT2NH/8UwHo1w3NE7X9
         yLybNlu8wgc7zT+0qwXccOSODFeIOgs9wa1sY9SzjmfxegGbJreQCHQtUdQv+n3auNUS
         0LHE53TlHXsqs9NO32h18jJeakxACNmc/nwB0Q27z1rgXh2qGIjMZcv+4YTcZ74DPc0g
         vKos/2ByJZx1J4oBOK2OJ2b6JtmqCsspCzSwcI8OSlGURpj0+hMyhHREQ6/P0ujI9eKK
         tMtjUzcu5P54T2iMMxojTWO//ZVjDzPDWhHmhPBIsYvOkYh2mSxgIweS8G5VtMk5FFpG
         tEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690990594; x=1691595394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=673FNT9+5mnaLVg5PRS120UPJdmtYWKDCkh6MjsqAGk=;
        b=WLrBJIYjSiW7kHXCxs49HtOoCYbbT/383SOPqKL6PkVO4QhgoopnQDkssjJmYX4cKK
         vB2KZK1mDL0WSRUxjDM8Dzfc/+h2+RtZp81C2WWuNMQ+fqnit4lzmwCsOkdjkvRvTWfO
         Tf8WNw7iMWFj7WxQtDfcrBW2zzG4HFyEZ5GDM8pj0c/A2IZCCRKFf4a/qLDRG+l+Mt4J
         3pGJd1jmjLNpszl0Lk+eshNi0LWOyRIcxfqQaaq5zJ5WpASO1X1lNiaFpughUmFuTEBR
         OiUgPdEciIhECRaRDDBx11nSYCfkbn0Lbv7G/KxHDPAbZO7jgE9ukMnO8UiKXOyG1ERW
         bQlg==
X-Gm-Message-State: ABy/qLYNSCr6/DsvmsTlck9HReDwyOwvh8nkHBv16TKxLPjPVDThfO60
        Ix6NkyoAoEskRhCtwKzP8cNVKw==
X-Google-Smtp-Source: APBJJlGUkAAAMCsRyqhq/PIoWTsQaXC7gGA1eoObLajsTDL34SrB7j0y4Xe/8ukTb5Tru29rdlT26A==
X-Received: by 2002:a05:6602:2b91:b0:77a:ee79:652 with SMTP id r17-20020a0566022b9100b0077aee790652mr18610565iov.1.1690990594272;
        Wed, 02 Aug 2023 08:36:34 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m18-20020a056638225200b0042b08954dc3sm4351434jas.33.2023.08.02.08.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 08:36:33 -0700 (PDT)
Message-ID: <17c5d907-d276-bffc-17ca-d796156a2b78@kernel.dk>
Date:   Wed, 2 Aug 2023 09:36:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH V2 1/1] pmem: set QUEUE_FLAG_NOWAIT
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        linux-block@vger.kernel.org
References: <20230731224617.8665-1-kch@nvidia.com>
 <20230731224617.8665-2-kch@nvidia.com>
 <x491qgmwzuv.fsf@segfault.boston.devel.redhat.com>
 <20230801155943.GA13111@lst.de>
 <x49wmyevej2.fsf@segfault.boston.devel.redhat.com>
 <0a2d86d6-34a1-0c8d-389c-1dc2f886f108@nvidia.com>
 <20230802123010.GB30792@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230802123010.GB30792@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/23 6:30?AM, Christoph Hellwig wrote:
> Given that pmem simply loops over an arbitrarily large bio I think
> we also need a threshold for which to allow nowait I/O.  While it
> won't block for giant I/Os, doing all of them in the submitter
> context isn't exactly the idea behind the nowait I/O.

You can do a LOT of looping over a giant bio and still come out way
ahead compared to needing to punt to a different thread. So I do think
it's the right choice. But I'm making assumptions here on what it looks
like, as I haven't seen the patch...

> Btw, please also always add linux-block to the Cc list for block
> driver patches that are even the slightest bit about the block
> layer interface.

Indeed. Particularly for these nowait changes, as some of them have been
pretty broken in the past.

-- 
Jens Axboe

