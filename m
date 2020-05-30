Return-Path: <SRS0=VeZL=7M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA7C433E0
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 01:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C8120810
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 01:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgE3B1u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 21:27:50 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:44930 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgE3B1u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 21:27:50 -0400
Received: by mail-pl1-f182.google.com with SMTP id bh7so1893287plb.11
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 18:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XDWfZVKTmoJWjJPnYLsSwVWmfKMK3J9Vaq5J+PDFQYY=;
        b=Wxgv1rTKUfp9LSGweLNGRuk7mbjWTKdbzyFp/uHu4D85Lm4w9VdSbWYR5qUWdiKltw
         NkLCeZRsKxP2jy81yPd9gSKY5cTBR4YRmFlS+uKaMzFd7459xJ+p7BAdWGr3nZIIjZmW
         pzCth3UvfL+I4hgjcILeQh5z/oELkd2jQ/uxaVWaZBtbqcVuCfAqLrF5LmRM+tN6sQo2
         iEBdfHYKVD/R3Wm15EW110YLKPVQVIaBzMIBUIUWwJ/a5H7+Ydl6qFRBQnGBIw1gZrhF
         QOId4fb6obIKvhrIWNLeqpVeiQTjRpksddiaNfBxSHfDUp8v9jmsKpgZe3gHYcLSbTe8
         IMrA==
X-Gm-Message-State: AOAM533Z34HY0dPKfWxzEb5fvo3E7Ar34ISrgy22siwjzGKsRHDuKlg1
        H5n7qeti37UziCiHlFAiD4Q=
X-Google-Smtp-Source: ABdhPJzlA44qy6sLNfmNl8+aMWIi0v33GlJafrNNnvvayBnypDZX8J6j3m8QU5DA6N4DKKAZ8/4Rxg==
X-Received: by 2002:a17:90a:2e8a:: with SMTP id r10mr11916008pjd.33.1590802068258;
        Fri, 29 May 2020 18:27:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7462:f68a:6e38:5c40? ([2601:647:4000:d7:7462:f68a:6e38:5c40])
        by smtp.gmail.com with ESMTPSA id 25sm559039pjk.50.2020.05.29.18.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 18:27:47 -0700 (PDT)
Subject: Re: [PATCH v2] block: improve discard bio alignment in
 __blkdev_issue_discard()
To:     Coly Li <colyli@suse.de>, linux-block@vger.kernel.org
Cc:     Acshai Manoj <acshai.manoj@microfocus.com>,
        Christoph Hellwig <hch@lst.de>,
        Enzo Matsumiya <ematsumiya@suse.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, Xiao Ni <xni@redhat.com>
References: <20200529163418.101606-1-colyli@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <a7d1b0d0-8823-2fa4-89ce-782be6f52016@acm.org>
Date:   Fri, 29 May 2020 18:27:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529163418.101606-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-29 09:34, Coly Li wrote:
> +static inline unsigned int bio_aligned_discard_max_sectors(
> +					struct request_queue *q)
> +{
> +	return round_down(UINT_MAX,
> +			 (q->limits.max_discard_sectors << SECTOR_SHIFT))
> +			>> SECTOR_SHIFT;
> +}

max_discard_sectors has been declared as an unsigned int. Can the shift
left operation overflow?

Thanks,

Bart.
