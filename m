Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9294C433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 20:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12A52089D
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 20:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgE0UHT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 16:07:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45055 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0UHS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 16:07:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id p30so12314309pgl.11
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 13:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+WbfliVtnDKxE0Rh+9gNyTM41PrwRT7phDMTYki/75s=;
        b=aVBFvd4mHlJ7onnmJTLx75KvEjGkVOLwPwKAkJgimM6DlrEjKYrdBBI8r6vg8XGWxA
         M3mF86avOo0f62T343JLKg8qFKchllgLSYIr4r/2OwagD/7siL+NEELy0ClLPHsKP9+W
         DJio4ae46B+GNA38ESHrmGYB8+BI8e2MndRKuUG8+/F0Hm41KCFWu0LqsSp5JapMk21K
         hRp+nrj+qA4stUtZ37ewZsQuVWNRsfg0yzKxIk2+aZvHBJ7ex7K3dixbbJFt+j/eZMfI
         ddbnzuitla8H7W5jHpVvIE6JZBrwDuECdDu2qnyFoRAV1XTlNOT/68yw5lEPnZNolLY1
         mylA==
X-Gm-Message-State: AOAM532jhp8/ZDm2U/UXXoAUUrjxaMKW6+9cE7/hSc/G4MZRWN50Jzu2
        ozLa2qdWEtqeRdlzNqRcJ9w=
X-Google-Smtp-Source: ABdhPJwZjV2Y4ThUWTz4yVyZJVbMqrn7MrgIaGmrp0FEsmifVjPvcerm1/LKTBKoAasfOWXWQAWWwA==
X-Received: by 2002:a62:7e0e:: with SMTP id z14mr5664671pfc.58.1590610037684;
        Wed, 27 May 2020 13:07:17 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id d2sm2777490pfc.7.2020.05.27.13.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 13:07:16 -0700 (PDT)
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v4
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200527180644.514302-1-hch@lst.de>
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
Message-ID: <e70a1d79-4bc4-53a4-d8ad-b5d61225f736@acm.org>
Date:   Wed, 27 May 2020 13:07:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527180644.514302-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-27 11:06, Christoph Hellwig wrote:
> this series ensures I/O is quiesced before a cpu and thus the managed
> interrupt handler is shut down.
> 
> This patchset tries to address the issue by the following approach:
> 
>  - before the last cpu in hctx->cpumask is going to offline, mark this
>    hctx as inactive
> 
>  - disable preempt during allocating tag for request, and after tag is
>    allocated, check if this hctx is inactive. If yes, give up the
>    allocation and try remote allocation from online CPUs
> 
>  - before hctx becomes inactive, drain all allocated requests on this
>    hctx
> 
> The guts of the changes are from Ming Lei, I just did a bunch of prep
> cleanups so that they can fit in more nicely.  The series also depends
> on my "avoid a few q_usage_counter roundtrips v3" series.
> 
> Thanks John Garry for running lots of tests on arm64 with this previous
> version patches and co-working on investigating all kinds of issues.

Hi Christoph,

Thanks for having prepared and posted this new patch series. After v3
was posted and before v4 was posted I had a closer look at the IRQ core.
My conclusions (which may be incorrect) are as follows:
* The only function that sets the 'is_managed' member of struct
  irq_affinity_desc to 1 is irq_create_affinity_masks().
* There are two ways to cause that function to be called: setting the
  PCI_IRQ_AFFINITY flag when calling pci_alloc_irq_vectors_affinity() or
  passing the 'affd' argument. pci_alloc_irq_vectors() calls
  pci_alloc_irq_vectors_affinity().
* The following drivers pass an affinity domain argument when allocating
  interrupts: virtio_blk, nvme, be2iscsi, csiostor, hisi_sas, megaraid,
  mpt3sas, qla2xxx, virtio_scsi.
* The following drivers set the PCI_IRQ_AFFINITY flag but do not pass an
  affinity domain: aacraid, hpsa, lpfc, smartqpi, virtio_pci_common.

What is not clear to me is why managed interrupts are shut down if the
last CPU in their affinity mask is shut down? Has it been considered to
modify the IRQ core such that managed PCIe interrupts are assigned to
another CPU if the last CPU in their affinity mask is shut down? Would
that make it unnecessary to drain hardware queues during CPU
hotplugging? Or is there perhaps something in the PCI or PCIe
specifications or in one of the architectures supported by Linux that
prevents doing this?

Is this the commit that introduced shutdown of managed interrupts:
c5cb83bb337c ("genirq/cpuhotplug: Handle managed IRQs on CPU hotplug")?

Some of my knowledge about non-managed and managed interrupts comes from
https://lore.kernel.org/lkml/alpine.DEB.2.20.1710162106400.2037@nanos/

Thanks,

Bart.
