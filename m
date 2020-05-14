Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1965C433E1
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 13:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D144C2074A
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 13:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgENNzC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 09:55:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40063 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgENNzB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 09:55:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so1190872plo.7
        for <linux-block@vger.kernel.org>; Thu, 14 May 2020 06:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=syNto/APAFXo39Jfkywx9rKgvyWiBrNCHLK7V6gP5Rk=;
        b=tbHCIS96lFxj7NbOBwkZWBvuXziuzOEc++NMYIp20jNUuRumL4XBW9UT83CZOYTmnV
         nYPi4Swv0D+uLhAM7N3dyzD/rSh+lMRqcVUne3jZPkqKlwoDpGji/Jjf62yw2OOEMIpR
         ItTygd/DNJrMHQt9Gtwode+0hC83MOEQ5aOTikG7akGexEdHABccGD4A/ApaIFZn8gF9
         XUTIcFM5l7idinL32HD73e149ljpu0ebaxpUeVjoF9KUi0ZMLgJKBZv1iSVxtlJg6Jkt
         p7OkOsKRJy5g8r01Nyu3S35i2hlFM3r/dOLvXsUBdKEoE9IKnuL+OYMOpP91OCDzXPRg
         orog==
X-Gm-Message-State: AGi0Puby/vXkbfDdwYTyzIKQS67c5lmb5oDaU53r0wBuRllEsm3OoInv
        Xl/4rggddHVUENpIZMnZjV0=
X-Google-Smtp-Source: APiQypJefENidtwNEC3VSBDshB71tPNe/RaPv8G2yXtUu6a8TxGC/v+OtnuYRiWmGDizDJMbe69Azg==
X-Received: by 2002:a17:90a:2365:: with SMTP id f92mr42405201pje.117.1589464500400;
        Thu, 14 May 2020 06:55:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6c16:7f27:8c37:e02d? ([2601:647:4000:d7:6c16:7f27:8c37:e02d])
        by smtp.gmail.com with ESMTPSA id q5sm2208389pgv.67.2020.05.14.06.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 06:54:59 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: Fix io_opt limit setting
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20200514055626.1111729-1-damien.lemoal@wdc.com>
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
Message-ID: <ac07c7eb-9632-7f3a-6ac3-301854c1ce3c@acm.org>
Date:   Thu, 14 May 2020 06:54:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514055626.1111729-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-13 22:56, Damien Le Moal wrote:
> Currently, a namespace io_opt queue limit is set by default to the
> physical sector size of the namespace and to the the write optimal
> size (NOWS) when the namespace reports optimal IO sizes. This causes
> problems with block limits stacking in blk_stack_limits() when a
> namespace block device is combined with an HDD which generally do not
> report any optimal transfer size (io_opt limit is 0). The code:

Reviewed-by: Bart van Assche <bvanassche@acm.org>
