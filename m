Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADDFC433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 23:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7B3207D3
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 23:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgE0XJY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 19:09:24 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40157 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0XJX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 19:09:23 -0400
Received: by mail-pj1-f65.google.com with SMTP id ci23so2201196pjb.5
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 16:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=92wX3uzSZ/9bb4wAgxLL71PVPevVT09NfeDoUa12fcw=;
        b=YSL2u8EzOIMeh8ZhxM54yO4IOUtzPlamfLQy9ZVBjLpUS+FiS72ZY3ID1VWDPRrL5v
         y4tvqkHzS1i9VPmpZCsvGjbWNISMzTyXOXbMRnZVxkrB+CQ2b9ReV+i1ckc2iu2GPK7z
         1QdIG6c18PlyL5i+HM1sJr/tn9Rmz7CI0r0iMCWwlE5zFxVKbZ4ywFYMQxmOibL+xz4f
         TRCp/X0IFLIVUiPFoA7jddRfSyyfocAW4VUe8RwgzgV4MM9qNhGRKIWjMI62aFqixbCs
         q9byUEmjiVj8lPW/EZa3svSWTAgnhysRmd/ceoKoQ04RzFXNWIjXo2OZ9XzRTDF0KNZI
         XgNg==
X-Gm-Message-State: AOAM530a0ky4bEzaoO0FVYYKDkUS7sGzlg1exoPiIlEQhoO3493PmtYN
        zAU0fdid5de4GshIa43LTng=
X-Google-Smtp-Source: ABdhPJwufw1zR7e9bF6zu4qG3pO5uUI+d8NaBNmNYfgzPtkCYmmkR+51ECkF0mBPtsB34usRMcfRbQ==
X-Received: by 2002:a17:90b:238d:: with SMTP id mr13mr683514pjb.236.1590620962445;
        Wed, 27 May 2020 16:09:22 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id g18sm2943827pfq.146.2020.05.27.16.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 16:09:21 -0700 (PDT)
Subject: Re: [PATCH 8/8] blk-mq: drain I/O when all CPUs in a hctx are offline
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-9-hch@lst.de>
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
Message-ID: <7acc7ab5-02f9-e6ee-e95f-175bc0df9cbc@acm.org>
Date:   Wed, 27 May 2020 16:09:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527180644.514302-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-27 11:06, Christoph Hellwig wrote:
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -180,6 +180,14 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  	sbitmap_finish_wait(bt, ws, &wait);
>  
>  found_tag:
> +	/*
> +	 * Give up this allocation if the hctx is inactive.  The caller will
> +	 * retry on an active hctx.
> +	 */
> +	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))) {
> +		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
> +		return -1;
> +	}
>  	return tag + tag_offset;
>  }

The code that has been added in blk_mq_hctx_notify_offline() will only
work correctly if blk_mq_get_tag() tests BLK_MQ_S_INACTIVE after the
store instructions involved in the tag allocation happened. Does this
mean that a memory barrier should be added in the above function before
the test_bit() call?

Thanks,

Bart.
