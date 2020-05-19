Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6A2C433DF
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC4C20715
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgESEKM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 00:10:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35191 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgESEKL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 00:10:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id n18so5939604pfa.2
        for <linux-block@vger.kernel.org>; Mon, 18 May 2020 21:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dyG9opt4PelARfFlTn6v9XvFscmnCkNkH6gum0DwNFA=;
        b=BVh1f2tDVjXJMkOUQ7Fn8XSsK/xUkTf2CYldADGGCYp0JxHjgPTi7HhO0hvd7oLgSh
         i9E5htoQIPq0lORE7YFaPw2f8MLr4dpTPg9SkCULz14rCO8HQUP79N7kw0gGt+cmUw4h
         DzWE7IbZZ6A0xhiAdUzGEx8DHbOWWW7BhcM9si4BLDeg/oHPNLaiGYDFqkBoobtTKafs
         PGu+1MWUUXExd2kBLOZ62nijQCD8EpatggLSeiI2oIKnjBsDtFmkhnjwJP/UVFyOyyA8
         jxfVlpGzGgMkeldo+Y0BAP8+D7jtrk7/6ESi+/UiCuH7mm8ACvW5gzn7AJjdfy0U/yjr
         u5LA==
X-Gm-Message-State: AOAM531rfMA1lEEMkcDrmRYauAMoc3CD8rI84F0MfEmKZwWDOdEMf6kc
        bv61ZRIkFtYCAWzuEPVY9Wg=
X-Google-Smtp-Source: ABdhPJxDqYpKDBXXlfGnyNyChREsTtIPHZuyTo2nhAOwzRosUQkkMDP2fAUNnPuC7DjvB/QRjP05Yw==
X-Received: by 2002:aa7:988a:: with SMTP id r10mr11822510pfl.267.1589861410732;
        Mon, 18 May 2020 21:10:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:dc5d:b628:d57b:164? ([2601:647:4000:d7:dc5d:b628:d57b:164])
        by smtp.gmail.com with ESMTPSA id c21sm5990100pfo.131.2020.05.18.21.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 21:10:09 -0700 (PDT)
Subject: Re: [PATCH 5/5] null_blk: Zero-initialize read buffers in
 non-memory-backed mode
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Alexander Potapenko <glider@google.com>
References: <20200516001914.17138-1-bvanassche@acm.org>
 <20200516001914.17138-6-bvanassche@acm.org>
 <BY5PR04MB69008A16B82CD028FC01D0A6E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
 <440743f4-1053-32f3-2edf-3eb0fdd057ef@acm.org>
 <BY5PR04MB690032A546EF80F2B823C984E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
 <45f9df39-a62e-4721-5bc8-ac9fa87b02ea@acm.org>
 <BY5PR04MB69008EEBF379E3E45CE972D5E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
 <be635a33-c07c-c961-3033-cc1a9bc82e8b@acm.org>
 <BY5PR04MB69000C77620D48609E90D411E7B90@BY5PR04MB6900.namprd04.prod.outlook.com>
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
Message-ID: <0f6db3f8-71a1-23db-36aa-ea4511f17b3e@acm.org>
Date:   Mon, 18 May 2020 21:10:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BY5PR04MB69000C77620D48609E90D411E7B90@BY5PR04MB6900.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-18 20:03, Damien Le Moal wrote:
> Makes sense. Thanks for the explanation.
> But from code-size perspective, I think it would still make sense to add the
> #ifdef CONFIG_KMSAN around the zeroing functions.

Does anyone who cares about kernel size include the null_blk driver? I
would be surprised if anyone who cares about kernel size (e.g. embedded
systems developers) would use anything else than CONFIG_BLK_DEV_NULL_BLK=n.

Thanks,

Bart.
