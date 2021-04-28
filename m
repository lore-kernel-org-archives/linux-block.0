Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D3BC433ED
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 20:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B236143D
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 20:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhD1UJN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 16:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241862AbhD1UJM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 16:09:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10500C061573
        for <linux-block@vger.kernel.org>; Wed, 28 Apr 2021 13:08:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l10-20020a17090a850ab0290155b06f6267so3516903pjn.5
        for <linux-block@vger.kernel.org>; Wed, 28 Apr 2021 13:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DB7MZoU3HMVpsUlzpXDqKdOJ0sh2qyOLWTaTCi65oJs=;
        b=u/E393em5DeeTD24WLcw8rJh6lhERt8Nv6Q0Y+xVuRjEaCOmQ8k+rq26igaB5YfLg9
         9jGccToW88HJYDZdOJ8aamx/TGE3xs9Cm2iHQ8GDBCWR/VDkkRfg9r9GRlXyZRNQ1txa
         ZFfvR+1os00O5Q7/jZN/cEScPfB9a+CF7DajIkbVB2AZYSrGE/6LWSm2G54C1dCQOPhV
         AGVtYpmzNUOsxaym/rtgL/NE9Lms7kq7H/EJ/LLfAIfkVY49Tz0v/dlYnmuYcfaORtN1
         C4H2r5rx5fy0/Nbvtz2mvgDaFkiqdOYdAb/B3eS5EgYpgn3MhxcCpAHK2H5+sNgwiEzu
         iiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DB7MZoU3HMVpsUlzpXDqKdOJ0sh2qyOLWTaTCi65oJs=;
        b=C/hm7Gj+QXFJdbLdBzFgOpVyCXJp+vR4yEWWaszI4jJRFLkWzGynupAX3Bk0b/76sW
         C9FIpgDSWvwUtPdTZaMiWa34pNLEEbPuCuX6VMKZvGflruhXBb5aJMKd+/YJo9ZpJ2Jo
         KIiWvW1TfQQoyKOIKU3rH9HTp+bl7PUpINDzc0oxcF0vaYjSN10rPaQcoIzza+R7gxq4
         MUxdtVRJwpJeebNuycC2ctDANyyKM5X8MXHz7QBcCcIJ9UVr/oAn/vsblx6h/66Q/Anm
         z9iQGik0WcvLtTZE4Cm2vgwlciW5uIDxsPQZNl9WaTTvl4E7yl2iTR/1XP6dFX7rXlqO
         wfTw==
X-Gm-Message-State: AOAM530JOPzPHg5STKku47QxFR6U+DhfuJpW/6WW/PGb2U1ObzyKIbl/
        E+lJPLBwSEmvWvTeuehjc4wBtA==
X-Google-Smtp-Source: ABdhPJyh8ikd6mVH5vSQd8zxzacNwo/y1i1vrW+6JQZDkQy92abhXm3LzgBmmb3J9MR8vbj9ICrbPw==
X-Received: by 2002:a17:902:a582:b029:ec:d002:623b with SMTP id az2-20020a170902a582b02900ecd002623bmr31842309plb.36.1619640506474;
        Wed, 28 Apr 2021 13:08:26 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s19sm506862pfh.18.2021.04.28.13.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 13:08:26 -0700 (PDT)
Subject: Re: bio_add_folio argument order
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210428165044.GB1847222@casper.infradead.org>
 <7be8f00a-1444-d614-267f-1477289e4f62@kernel.dk>
 <20210428200032.GC1847222@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e7109944-fbc9-80af-10d2-ba7e841bc67d@kernel.dk>
Date:   Wed, 28 Apr 2021 14:08:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210428200032.GC1847222@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/21 2:00 PM, Matthew Wilcox wrote:
> On Wed, Apr 28, 2021 at 10:58:44AM -0600, Jens Axboe wrote:
>> On 4/28/21 10:50 AM, Matthew Wilcox wrote:
>>> bio_add_page() has its arguments in the wrong order:
>>>
>>> extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
>>>
>>> Oh, right, and the prototype commits the cardinal sin of just giving you
>>> a pair of unsigned ints and doesn't bother to tell you what they mean.
>>> I'll send a patch for that ... anyway:
>>>
>>> int bio_add_page(struct bio *bio, struct page *page,
>>>                  unsigned int len, unsigned int offset)
>>>
>>> This fails to follow #4: https://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html
>>>
>>> Here's what I want to do for the folio equivalent:
>>>
>>> size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t off,
>>>                 size_t len)
>>>
>>> This will make the transition more painful, but it does remove an irritant
>>> for the future.  Any objections?
>>
>> What's the point in shuffling len and offset around?
> 
> That almost everything else does (off, len).  Grepping include, here's
> the (object, len, off) examples I found (will miss multi-line examples,
> tried to use my best judgement, tried to exclude loff_t):
> 
> bio_add_zone_append_page
> __bio_try_merge_page
> __bio_add_page
> bio_integrity_add_page
> fscrypt_encrypt_block_inplace
> fscrypt_decrypt_block_inplace
> sg_set_page
> sg_copy_buffer
> sg_pcopy_from_buffer
> sg_pcopy_to_buffer
> sg_zero_buffer
> copy_linear_skb
> 
> versus (object, off, len):
> 
> bpf_ctx_copy_t
> ->is_partially_uptodate
> memcpy_from_page
> memcpy_to_page
> memzero_page
> (basically all of the iomap functions)
> kvm_write_guest_page
> kvm_vcpu_write_guest_page
> skb_gro_remcsum_process
> nf_checksum_partial
> perf_copy_f
> read_module_eeprom
> skb_frag_foreach_page
> skb_to_sgvec_nomark
> skb_to_sgvec
> skb_send_sock
> various skb_checksum_ops
> sk_msg_clone
> various gss_krb functions
> xdr_process_buf
> usercopy_warn
> various network getfrag functions
> 
> Not _quite_ as one-sided as I thought, but there are basically three
> families of functions (bio, fscrypt, sg) that are len-first (plus
> copy_linear_skb() is out-of-family), then networking, filesystems,
> highmem, perf, bpf, kvm are off-first.
> 
> So, you're the maintainer, it's your call ... do you want
> bio_add_folio() to resemble the bio_add_page() calls as much as
> possible, or do you want to migrate towards how the rest of the world
> works?

Given that, I'd rather stick with the current ordering. The risk of
mistakes is much smaller that way. And not sure 'rest of world' is
really that applicable here in the kernel, the list above seems only
slightly skewed to one side. Hence I'd rather keep it safe and just
retain it.

-- 
Jens Axboe

