Return-Path: <SRS0=urI+=4C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0502FC35242
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 05:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D0B2067D
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 05:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgBNFt4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 00:49:56 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:37784 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgBNFt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 00:49:56 -0500
Received: by mail-pl1-f174.google.com with SMTP id c23so3309422plz.4;
        Thu, 13 Feb 2020 21:49:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EOnGdKnatWtPW+V0iRAfr+xmFZZKI2SDzVeIYLi9Cug=;
        b=QrAR+K2eguZfa+8D6GQhBwRx0lo4jIcHwJF73mrtM8HcipK0sTZtRK2wpkfQCpw4pB
         0SFdchGRc6t0BA0XYPhv7HZT2NccmZRya9PJms9NgKyZuT6ut6/iZPFwD+k6XFUmXS60
         pTEkeyhftJ4PP16skCC9j300EKc5zd1+6vXFJBexx+j4KhA7csvtC41OPKtsoT8LSrCs
         tjKoTOFLViecpWJMlZpAL7LIWAOAtD7WY1roP19cZ1QRNr7Ep3jyuCNUdbLBR0KTNf7/
         u8xcSGmYWcpQxyTBwoZuPHfTDaAi69wbVz1gl9bImYC6M0dwJR7uqJ7xkIgbQv9c8Aqp
         ANFQ==
X-Gm-Message-State: APjAAAUQ68KQ3A5ZX5qZkQUsbsvY/mXvBWCb0ZPydAlqzN13QjuRNQcB
        7+HApIjyusTZT/Olz1UOOao=
X-Google-Smtp-Source: APXvYqx2ihLjSHM16pPmKpngGJOWQZLjgTvSZPlvWEsBxjFlzSxDYedIa0Ktv4gCo5cqXlNeHgZn0w==
X-Received: by 2002:a17:902:708b:: with SMTP id z11mr1695988plk.121.1581659391205;
        Thu, 13 Feb 2020 21:49:51 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:c4a9:d5d0:62d2:6a5d? ([2601:647:4000:d7:c4a9:d5d0:62d2:6a5d])
        by smtp.gmail.com with ESMTPSA id w189sm5331705pfw.157.2020.02.13.21.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 21:49:50 -0800 (PST)
Subject: Re: BLKSECDISCARD ioctl and hung tasks
To:     Salman Qazi <sqazi@google.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
        Jesse Barnes <jsbarnes@google.com>
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200213082643.GB9144@ming.t460p>
 <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
 <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
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
Message-ID: <de7b841c-a195-1b1e-eb60-02cbd6ba4e0a@acm.org>
Date:   Thu, 13 Feb 2020 21:49:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-13 11:21, Salman Qazi wrote:
> AFAICT, This is not actually sufficient, because the issuer of the bio
> is waiting for the entire bio, regardless of how it is split later.
> But, also there isn't a good mapping between the size of the secure
> discard and how long it will take.  If given the geometry of a flash
> device, it is not hard to construct a scenario where a relatively
> small secure discard (few thousand sectors) will take a very long time
> (multiple seconds).
> 
> Having said that, I don't like neutering the hung task timer either.

Hi Salman,

How about modifying the block layer such that completions of bio
fragments are considered as task activity? I think that bio splitting is
rare enough for such a change not to affect performance of the hot path.

How about setting max_discard_segments such that a discard always
completes in less than half the hung task timeout? This may make
discards a bit slower for one particular block driver but I think that's
better than hung task complaints.

Thanks,

Bart.
