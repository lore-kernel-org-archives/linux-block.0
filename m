Return-Path: <SRS0=UGhi=5B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AC9C10DCE
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 00:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E63205ED
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 00:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgCPA0A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Mar 2020 20:26:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41565 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbgCPA0A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Mar 2020 20:26:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id b1so8676465pgm.8
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2020 17:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vcfldlU7gH/AeaxDKdmDVL/De34y3hnPJmw8JyT4izM=;
        b=gCBcJtRqT+2+yutCDCvj2epSCIl14aRxc+O0zHJENfTaD68hsTxzttnSWYRvE0m2jN
         2K8y0d+yY26z8senEKsgyB94aNFhsDEufjNFBkxFzoTdxrO9QwESjh88YCVNS2kMc4nH
         JHho1cPiz1EEbYp0edgvr5U3E1SpeqZHZ6uGDv76r+vrLjIt/3HyjLQomuZ+8VbN068b
         vwQiKK+oGqeVqrN6RG99oKxrgksfhO/A2T0/gYEQrp2KbfpT0DmP2F06zH+GnwcReDKf
         Hmx/AHA+5Pm9EpUihc9cbK2+d6r8ybe+isDyne4nSxp5G5g12y+DXzO/+aDT3kuannQU
         J+LA==
X-Gm-Message-State: ANhLgQ3mjBNMM2m6FFNU66fuOxIlpGV4o30mNtzJGWwRkJPy4npNUM7C
        z0ZZp4+WhzujTKAbKRJ+h3zPdAm2gDqntw==
X-Google-Smtp-Source: ADFU+vsPa2Nnya1kBB9sIqPqa3iWZaOAPTz6DXvHB7CTM8N23goRDUsR0YGzrPrLj0eBC61u5HnjjQ==
X-Received: by 2002:a63:e14c:: with SMTP id h12mr24378898pgk.393.1584318358582;
        Sun, 15 Mar 2020 17:25:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:dc50:2da4:5bd2:69ab? ([2601:647:4000:d7:dc50:2da4:5bd2:69ab])
        by smtp.gmail.com with ESMTPSA id m13sm2407354pjq.26.2020.03.15.17.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2020 17:25:57 -0700 (PDT)
Subject: Re: [PATCH blktests v2 1/4] Make _exit_null_blk remove all null_blk
 device instances
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Omar Sandoval <osandov@fb.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200315221320.613-1-bvanassche@acm.org>
 <20200315221320.613-2-bvanassche@acm.org>
 <BYAPR04MB57496AC6BE6F598F7D159F5B86F80@BYAPR04MB5749.namprd04.prod.outlook.com>
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
Message-ID: <d3655260-8a31-0c5c-ef02-f0d033d299be@acm.org>
Date:   Sun, 15 Mar 2020 17:25:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB57496AC6BE6F598F7D159F5B86F80@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-03-15 16:22, Chaitanya Kulkarni wrote:
> Looks good, except the commit log is > 80 char, can be fixed at
> the time of applying the patch.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Thanks for the reviews, but I have two comments:
* The commit message is only 76 characters wide.
* Please do not top-post. From https://en.wikipedia.org/wiki/Posting_style:

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

Thanks,

Bart.
