Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F38CC4332F
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 18:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKISde (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Nov 2022 13:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiKISdb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 13:33:31 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA73D38B7
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 10:33:30 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id k22so17504653pfd.3
        for <linux-block@vger.kernel.org>; Wed, 09 Nov 2022 10:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHp5Q2wOQy0KMZQlD30NsVfoIRug5gwk53ibb7cieWI=;
        b=Kii37SevvA7bc8LA5fR8u9bJRXykNhlhfF6YHQSyXl62ImyXzbUda3785EJz8uzhh3
         69zKPRTy3mrNBKumMEyOsuNn5B6+1UUh67uIk8dvoPYphmxpis3TXp2SFyIkwu6Inszv
         GaE072uorf+pfDiDWt/3qEBYtBR2wFG36f9V1MFmtR0F56Nds344w3immMLHM6i1qPNX
         9X330aao4iGbTZdV6W6m6ZZNnyS5NKoo4LmkB+8/osfYwU5ApsrTZF7AH8oUH6m31IzI
         Fvv/1EhdnP7y9srrnQvbiKhrPZq7eI5wae2MrkxsD3zZBbbzxs8h25CL0p/LMiunBPlb
         2sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHp5Q2wOQy0KMZQlD30NsVfoIRug5gwk53ibb7cieWI=;
        b=ElFW0K2CH2Ka9MpOuYDBoZkPNFjav+noi/QmEYcn2c6Sa3W1b19Nj9rJrG1diIy1id
         zY3lY/yLp2ZJOKEHreoPkJ2c4YSIYCbDlqwp86w5s8eQ3KV1u/ryDw7DR2AgzHXxFuga
         Rze8pLvS0ngU8Dx56BjACorMEd9rTubKLJYNSUxYpG7JHQgJ3BVxAfQ6XUyKPOi/MdUa
         1tB4uQi9tP+/AEkJ2tTWunKINBi5kQS/t+kChLCAWzTbTMsIj994MxzAVYX9pBkcXM8z
         h2m4VwHiWoZSroMIaPM9VhXOYAMIzb9DZp8UguvyYO9XQfIie3qtvkWbX5Be/PjSPvRx
         kKNQ==
X-Gm-Message-State: ACrzQf01SYnpp8DzXnuE1hqD5+jIxls5pQxmsTV8rq8F/wDwjPEbstUI
        wwFfcJAvhdV3ap+f+Pbh10EF3g==
X-Google-Smtp-Source: AMsMyM7hU2AShV4UZ4WTmMAwHQxYL4v/lW/DeBqUTu/MwpyWv2SRw77PxU9vDpozEEBwxy5XwsEB7g==
X-Received: by 2002:a63:187:0:b0:43b:cf3c:c64d with SMTP id 129-20020a630187000000b0043bcf3cc64dmr52910762pgb.359.1668018810159;
        Wed, 09 Nov 2022 10:33:30 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b0018863dbf3b0sm4977252plh.45.2022.11.09.10.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 10:33:29 -0800 (PST)
Message-ID: <2e7ccd49-b37b-2837-4baf-27a76f177c4f@kernel.dk>
Date:   Wed, 9 Nov 2022 11:33:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v11 0/9] Userspace P2PDMA with O_DIRECT NVMe devices
To:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>, viro@zeniv.linux.org.uk
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221024150320.GA26731@lst.de>
 <743ad0e5-6936-9287-d093-2ce1c2a3e32d@nvidia.com>
 <20221108065618.GA20283@lst.de>
 <ee9f817f-1573-f3f6-9b20-b4b2b2053eb6@deltatee.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ee9f817f-1573-f3f6-9b20-b4b2b2053eb6@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/9/22 10:28 AM, Logan Gunthorpe wrote:
> @add Jens
> 
> On 2022-11-07 23:56, Christoph Hellwig wrote:
>> On Mon, Oct 24, 2022 at 12:15:56PM -0700, John Hubbard wrote:
>>> A little earlier, Jens graciously offered [1] to provide a topic branch,
>>> such as:
>>>
>>>     for-6.2/block-gup [2]
>>>
>>> (I've moved the name forward from 6.1 to 6.2, because that discussion
>>> was 7 weeks ago.)
>>
>> So what are we going to do with this series?  It would be sad to miss
>> the merge window again.
> 
> I noticed Jens wasn't copied on this series. I've added him. It would be
> nice to get this in someone's tree soon.

I took a look and the series looks fine to me.

-- 
Jens Axboe


