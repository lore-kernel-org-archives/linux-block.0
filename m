Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E73C636CC
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 15:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjAaPtc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjAaPtb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 10:49:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BE430EAA
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 07:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675180120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuMUrfZRtvlkmAFqawT/rQRdhoiPDUHnVA5JYzWI9R4=;
        b=PYqP9b4PpsaKY8VJE2/zMEtwnTJwUZ7ReIw29xP+KnOq+MSWS4f6HjIEpUeUpARrbFKhAi
        iwesP8I3pmHsUlJTUAQ3B9Dmv6zyGRujhoer3BUl4UJjseiUmrqRMZDgHJhn0v61Na2/tV
        o+2rPMAp6AYtjncXDGJvq9cRakh7C34=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-443-CNYXBmWqMqOxSPRScxdp_Q-1; Tue, 31 Jan 2023 10:48:39 -0500
X-MC-Unique: CNYXBmWqMqOxSPRScxdp_Q-1
Received: by mail-wm1-f69.google.com with SMTP id bg24-20020a05600c3c9800b003db0ddddb6fso9039898wmb.0
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 07:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuMUrfZRtvlkmAFqawT/rQRdhoiPDUHnVA5JYzWI9R4=;
        b=FvIoecUgREiPr63o+ZSh5ojumH2GfdRqWAOIzB74nLrvLCz/1vvA5/0NLbKpBZR8Om
         t66WK+Rsc/94dpBT1U+/NVE7THics/j4l6jUwk/pudWa2kT9tJALBaK6DrU3GNFDwYVZ
         qDATstQbz9oEakYhB9s+wl4xPJY8voCrUlpZKlqo9qu+ap32ycX/VND+AqVP5UIaUkfR
         0WftmOCtZh5Aw6EiHF9uN7PJ7dtUdVc438/6vlnNWln++o3mObp9TLC2Og7BkYri4Ft1
         cd+OmFmevI9o5RRhK50x38bN7324ZB9hhyXYLdnepoGdCWM4JfNWMO99Ho0EpWCE3X0R
         agQA==
X-Gm-Message-State: AO0yUKWmCJx+xhygsiv+IEr3acCdvwyT++gcYlDVpFusONJuSE/M/BiX
        qDuSeHPcS8T8gm+0d26sALbQYxShKGDrt4cw+LQOCQGkTXvwah3RC914W7H161b0D0IHokN1qP/
        hUqZlafTlvfi797WmvVCU5VQ=
X-Received: by 2002:a05:600c:34c5:b0:3dc:4b87:a570 with SMTP id d5-20020a05600c34c500b003dc4b87a570mr12905668wmq.35.1675180117985;
        Tue, 31 Jan 2023 07:48:37 -0800 (PST)
X-Google-Smtp-Source: AK7set8kopvgornNa/3eCsVmMH6PQqtvbGhtwEQ6BLZLQ9Q8wQrLpxLNtEK3uRU/nyy7bunIPWt9Uw==
X-Received: by 2002:a05:600c:34c5:b0:3dc:4b87:a570 with SMTP id d5-20020a05600c34c500b003dc4b87a570mr12905646wmq.35.1675180117733;
        Tue, 31 Jan 2023 07:48:37 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id l35-20020a05600c1d2300b003dd1bd0b915sm3722974wms.22.2023.01.31.07.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:48:37 -0800 (PST)
Message-ID: <057142a9-b190-905a-5539-02d9d8a5d26e@redhat.com>
Date:   Tue, 31 Jan 2023 16:48:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm: move FOLL_PIN debug accounting under CONFIG_DEBUG_VM
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
References: <54b0b07a-c178-9ffe-b5af-088f3c21696c@kernel.dk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <54b0b07a-c178-9ffe-b5af-088f3c21696c@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 31.01.23 16:36, Jens Axboe wrote:
> Using FOLL_PIN for mapping user pages caused a performance regression of
> about 2.7%. Looking at profiles, we see:
> 
> +2.71%  [kernel.vmlinux]  [k] mod_node_page_state
> 
> which wasn't there before. The node page state counters are percpu, but
> with a very low threshold. On my setup, every 108th update ends up
> needing to punt to two atomic_lond_add()'s, which is causing this above
> regression.
> 
> As these counters are purely for debug purposes, move them under
> CONFIG_DEBUG_VM rather than do them unconditionally.
> 
> Fixes: fd20d0c1852e ("block: convert bio_map_user_iov to use iov_iter_extract_pages")
> Fixes: 920756a3306a ("block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages")
> Link: https://lore.kernel.org/linux-block/f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk/
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> I added fixes tags, even though it's not a strict fix for this commits.
> But it does fix a performance regression introduced by those commits.
> It's a useful hint for backporting.

I'd just mention them in the commit log instead, but I don't 
particularly care here as long as the commit ID's are stable.

If still possible, I'd include this as a preparational change for these 
commits instead. Anyhow

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

