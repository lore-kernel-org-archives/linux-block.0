Return-Path: <SRS0=TQg9=4A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1D1C2BA83
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 03:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF6C2082F
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 03:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgBLD12 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 22:27:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44953 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgBLD12 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 22:27:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so378919plo.11;
        Tue, 11 Feb 2020 19:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=X45N0tqHhxTK8vZNyfUu0bHovRYtsSFlSAY9DKDh7Kw=;
        b=SxmlHtP+vuzgld6TWghA/F0vGQ2DHva3RkW3kmULnxNmsgyspI6Pz5SwQtBbrqrFHk
         URnwCH1kkE0Wy62aOlOMHfufnWkB99+a5Zhvz0LnAoMrBIAHivSUkM93ccfuWGee/1Gp
         sHhs5O3gPUQkWfSjl0ZvK6hJyA6nvo8Ou4vuV46UGU1MQ70tpoHQ/60tzIzSDoZSyiPk
         ieuemFeGkwNbT/EnDlBaqfw8Hnl0j4TGJ+fr1Ya5Mj5SnuVo+92D/3+wD3pBuT8xcbWg
         XhzVmpuxxmkDEIomHVtVeQTeAS0Wl4TyynLiAG06TpBkqivbnmkk4ihfsfzcn4hCzP/X
         /ijQ==
X-Gm-Message-State: APjAAAWqtq8G+s6GnBv6vzZbmDplJw+aLYsRvObID/GyTcYoBX48uocs
        +iFdIfsDZkL39XUJ7SjnOayZWE7kbbE=
X-Google-Smtp-Source: APXvYqxoXNjbvSA4Pf9axrVm1CPhwwz+BZLUoulZhbFXL9cGlMoRGTyK7RqIPYaiVIUkoE1Qah9/Dg==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3mr6056344plk.331.1581478047301;
        Tue, 11 Feb 2020 19:27:27 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:d900:2c38:71f8:f575? ([2601:647:4000:d7:d900:2c38:71f8:f575])
        by smtp.gmail.com with ESMTPSA id r17sm5720961pgn.36.2020.02.11.19.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 19:27:26 -0800 (PST)
Subject: Re: [PATCH] block: rename 'q->debugfs_dir' in blk_unregister_queue()
To:     yu kuai <yukuai3@huawei.com>, axboe@kernel.dk, ming.lei@redhat.com
Cc:     yi.zhang@huawei.com, zhangxiaoxu5@huawei.com,
        luoshijie1@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200211035137.19454-1-yukuai3@huawei.com>
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
Message-ID: <c57b050d-9ed7-9d6b-b1d0-628a197f6ea6@acm.org>
Date:   Tue, 11 Feb 2020 19:27:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211035137.19454-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-10 19:51, yu kuai wrote:
> +static struct dentry *blk_prepare_release_queue(struct request_queue *q)
> +{
> +	struct dentry *new = NULL;
> +	char name[DNAME_INLINE_LEN];
> +	int i = 0;
> +
> +	if (IS_ERR_OR_NULL(q->debugfs_dir))
> +		return q->debugfs_dir;
> +
> +	while (new == NULL) {
> +		sprintf(name, "ready_to_remove_%d", i++);
> +		new = debugfs_rename(blk_debugfs_root, q->debugfs_dir,
> +				     blk_debugfs_root, name);
> +	}
> +
> +	return new;
> +}

What is the behavior of this loop if multiple block devices are being
removed concurrently? Does it perhaps change remove block device removal
from an O(1) into an O(n) operation?

Since this scenario may only matter to syzbot tests: has it been
considered to delay block device creation if the debugfs directory from
a previous incarnation of the block device still exists?

Thanks,

Bart.
