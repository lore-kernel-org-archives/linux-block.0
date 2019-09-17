Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FCAC4CECD
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 15:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D9A214AF
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 15:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfIQP76 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:59:58 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:33484 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfIQP76 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 11:59:58 -0400
Received: by mail-pl1-f181.google.com with SMTP id t11so1737578plo.0
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 08:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UkNFRdjv2O9x9sX5WaGXGWovbN0hZ2LCAlEUCa6Dcto=;
        b=Brg+xP0Z8izuCzE/+7Wq52CW9QlVPEoM3uv1w6AHeHHZVSR+umjz0wcsv6TZqqi37G
         2k4rOvzeDwVDhwo3vppi2v1StnME1rcVZkNx+0Ds9VCfLEZzAdbgNPO8V5eCbL49pv7m
         XNCxDZVndwNn803gluIjdeYQb5Ih7vm2dKhC3c+/8FnQXyizrtUnMpiDgby+pgYx/vHN
         H6GGUQQ4XLoUlfu80rQ68qzN5aUfKX6Xp7x3hIZKLorL5CxrMHkaviAMLi10LMGvDh8T
         HeLzb36sz7C695C434tKWvhs950gxC+e+PFp0uXRxYoxWCNiCjd1pzfe0B+CDGq3sY6c
         gl4w==
X-Gm-Message-State: APjAAAVu0eQ2WC30BCEvD5JxWm5vKPPojfbFGITWVyvlgl+wGIA1YmFv
        8IKd/8hONaZxpD1Ra+pNbh006uqN
X-Google-Smtp-Source: APXvYqzSBbcTm2Cg9YaE/fbTbQZcm7jFWOo89zXGnM/ruDnaAc22hzR6RaKmPHPO0TxGIwUJo9WVug==
X-Received: by 2002:a17:902:ff08:: with SMTP id f8mr4387838plj.309.1568735997119;
        Tue, 17 Sep 2019 08:59:57 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s19sm3108945pfe.86.2019.09.17.08.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 08:59:56 -0700 (PDT)
Subject: Re: [PATCHv2 0/2] blk-mq: Avoid memory reclaim when allocating
 request map
To:     Christoph Hellwig <hch@infradead.org>, xiubli@redhat.com
Cc:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com,
        linux-block@vger.kernel.org
References: <20190916021631.4327-1-xiubli@redhat.com>
 <20190916090606.GA13266@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bcd9aa53-af21-5d05-8e52-397079a6c195@acm.org>
Date:   Tue, 17 Sep 2019 08:59:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916090606.GA13266@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/16/19 2:06 AM, Christoph Hellwig wrote:
> On Mon, Sep 16, 2019 at 07:46:29AM +0530, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> To make the patch more readable and cleaner I just split them into 2
>> small ones to address the issue from @Ming Lei, thanks very much.
> 
> I'd be much happier to just see memalloc_noio_save +
> memalloc_noio_restore calls in the right places over sprinkling even
> more magic GFP_NOIO arguments.

Hi Christoph,

My understanding is that memalloc_noio_save() and 
memalloc_noio_restore() have been introduced to avoid having to pass 
flags that specify the noio context along deep call chains. Are you sure 
it helps to use these functions if no other function than kmalloc() is 
called between the memalloc_noio_save() and memalloc_noio_restore() calls?

Thanks,

Bart.

