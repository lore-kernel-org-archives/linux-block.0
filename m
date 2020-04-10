Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3695AC2BA19
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 02:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1939020730
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 02:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDJCxC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 22:53:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44939 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgDJCxC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Apr 2020 22:53:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id b72so468380pfb.11;
        Thu, 09 Apr 2020 19:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SgPrptd85zUfqS0Tu1fnyBZ8OdxDfCTb8OSMKyUvV4o=;
        b=mkWwhxNwgcCKP5hHFefI8osVR0u8mhcxGql0ursk9GlTyzUBJjmU6i3pkSnkmgyMjY
         TFYcItOXtS93TVcveJEi7lJYQRRKjBCMZ1eH1jswij1MFqH1mLDWp97uaon1syBGonQ3
         zUpssXvfq27Rf4NDpZuyGJ7LAbtohnKGq/M944FchvJ7YV/afWD3IVAGYBakB3gI4T/4
         QorO9T2mSacCX9trVUmwpc5JCMDI5FA4CEAU2TaNMQvKb2AyvAijSaJNsMC491dsSfGj
         3VJTt+oR/2z58eSBuCxaniWAc+ydIDLN7w2arKKYwh+Hj2IXWPDJd4eO3Nk9Nqb5mlpf
         3eHg==
X-Gm-Message-State: AGi0PuZmS3jFgOPWFhhDU6qyROXYMSxJkfyhcF00RNKo6po74bQMisLL
        R6ysGtHrR0xV2SXSANklzJ0=
X-Google-Smtp-Source: APiQypKPxb5CXryb5BtNXPr5kdp0rt+Ym2cknSQtkUoHtL2oJR+gGL/isM4KsNE0SJYVfopnhV7zhA==
X-Received: by 2002:a62:2b05:: with SMTP id r5mr2738916pfr.120.1586487181522;
        Thu, 09 Apr 2020 19:53:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:ed4e:1b14:7fc4:cd73? ([2601:647:4000:d7:ed4e:1b14:7fc4:cd73])
        by smtp.gmail.com with ESMTPSA id c21sm408791pgn.84.2020.04.09.19.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 19:53:00 -0700 (PDT)
Subject: Re: [RFC v2 2/5] blktrace: fix debugfs use after free
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
References: <20200409214530.2413-1-mcgrof@kernel.org>
 <20200409214530.2413-3-mcgrof@kernel.org>
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
Message-ID: <88f94070-cd34-7435-9175-e0518a7d7db8@acm.org>
Date:   Thu, 9 Apr 2020 19:52:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409214530.2413-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-09 14:45, Luis Chamberlain wrote:
> +void blk_q_debugfs_register(struct request_queue *q)
> +{
> +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> +					    blk_debugfs_root);
> +}
> +
> +void blk_q_debugfs_unregister(struct request_queue *q)
> +{
> +	debugfs_remove_recursive(q->debugfs_dir);
> +	q->debugfs_dir = NULL;
> +}

There are no other functions in the block layer that start with the
prefix blk_q_. How about changing that prefix into blk_?

> -#ifdef CONFIG_BLK_DEBUG_FS
> +#ifdef CONFIG_DEBUG_FS
>  	struct dentry		*debugfs_dir;
> +#endif

Please add a comment above 'debugfs_dir' that it is used not only by the
code in block/blk-*debugfs.c but also by the code in
kernel/trace/blktrace.c. Otherwise this patch looks good to me.

Thanks,

Bart.
