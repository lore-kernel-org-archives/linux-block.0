Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5FEC47255
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 02:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D517206D7
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 02:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgELCny (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 22:43:54 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:44299 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgELCnx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 22:43:53 -0400
Received: by mail-pf1-f173.google.com with SMTP id p25so5642961pfn.11
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 19:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C43bEIp+nU5Hgnx0iZjSYjB61XV3//6CUrMbh5jBPws=;
        b=gmdtXHP0PlE7yzN9QXNvGDKw2wW/Y3eoSC1nZhovkgJWABlZDLnUprLyeJUzZShdqy
         VdZdh+Fs+JwJlKeSR0XdagAw66MnUzQmhtEuLGy7FN/imYKWBySBK64aVgJvd05CpAI5
         fGy110zPQ+dFHDgrpxTQpOQgI9eNd5CCOrvzZjvinqwz4ZQComNEVc/mBfNOPr2epyu2
         jXqDqc4/8yFHkLislcqZr59WGzrB1hmBTyJDDqpy/y40kP69Y8h1LKX04/IcxR7pbE51
         uNa+Kfei/g7GlBkgESiZ4Gu7p7vvkzRSKd8d8+nft8CLX42Bb9JdzBPs3GDhSMBmPDv7
         3whA==
X-Gm-Message-State: AGi0PubJChFxJVsc3XYpLRd5mfOE577D7FBzji85DNQApOW5x2Kn/VAg
        b+GXIgoYBxI5DlEDmukF6xw=
X-Google-Smtp-Source: APiQypJUnZjYLen36eshTwjBBdJhyrk3Ur870WnZxdM7JLNVXrlgAWMVeaj0FOepEp3FAWInDa6NVQ==
X-Received: by 2002:a63:f802:: with SMTP id n2mr13797383pgh.195.1589251432450;
        Mon, 11 May 2020 19:43:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c4e5:b27b:830d:5d6e? ([2601:647:4000:d7:c4e5:b27b:830d:5d6e])
        by smtp.gmail.com with ESMTPSA id z1sm11209965pjn.43.2020.05.11.19.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 19:43:51 -0700 (PDT)
Subject: Re: null_handle_cmd() doesn't initialize data when reading
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>
References: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
 <d204a9d7-3722-5e55-d6cc-3018e366981e@kernel.dk>
 <CAG_fn=XXsjDsA0_MoTF3XfjSuLCc+6wRaOCY_ZDt661P_rSmOg@mail.gmail.com>
 <BYAPR04MB57495B31CEA65B2B5D76203C864A0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CAG_fn=WVHpRQ19MK12pxiizTEvUFLiV7LJgF_LrX_G2SYd=ivQ@mail.gmail.com>
 <277579c9-9e33-89ea-bfcd-bc14a543726c@acm.org>
 <CAG_fn=WQXuTuGmC8oQ25f6DYJ4CiMSz7_S7Nkp+z6L1QL7Zokw@mail.gmail.com>
 <55674c05-37dc-0646-af78-db4c3b112683@acm.org>
 <1e455c9f-4908-f476-f674-c0c920c17f9c@acm.org>
 <BY5PR04MB690045ED7665BF98A2EA7ED3E7BE0@BY5PR04MB6900.namprd04.prod.outlook.com>
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
Message-ID: <b90e0030-c0fa-7e7e-ea17-137d49293f54@acm.org>
Date:   Mon, 11 May 2020 19:43:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BY5PR04MB690045ED7665BF98A2EA7ED3E7BE0@BY5PR04MB6900.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-11 18:42, Damien Le Moal wrote:
> The patch looks good to me. However, I have one concern regarding the
> performance impact of this. When nullblk is used to benchmark the block IO stack
> overhead, doing this zeroing unconditionally will likely significantly impact
> measured performance. So may be this zeroing feature should be driven by a
> modprobe/configfs option ? Doing so, we can keep it off by default, preserving
> performance, and turn it on when needed as in Alexander use case.
> 
> Thoughts ?

Hi Damien,

Does the current implementation of null_blk allow one process to access
data that was generated by another process? If so, does that behavior
count as a security bug?

I am aware of the performance impact of the patch attached to my
previous email. I have not made the zeroing behavior optional because
I'm concerned about the security implications of doing that.

Bart.


