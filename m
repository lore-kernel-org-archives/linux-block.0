Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF978C54E94
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 14:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjAXOy5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 09:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjAXOyw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 09:54:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A944B1A3
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 06:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674572038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1o51OJziP6bU+eCmiPMiOHJQX1d0z5FefyRCAiwMaA=;
        b=M1FxX9kOQWCxHQ55KpJu7YRX5l4VPjQ0tz3E0UoN18gAGqhrGVgzU6uwBcHBwEw3kM3u6r
        zKFQnEQYsfQZCQXuv84g7jnp3gqR//SNnIoUlZbEn2tO7CqmTOkUyuEDZ0+YwKWcrHm8LM
        DBtNJdktlrlnEiZuJ+90rmNKNLb/E2Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-8BGB_7wWOs-38VZhBx0I8g-1; Tue, 24 Jan 2023 09:53:57 -0500
X-MC-Unique: 8BGB_7wWOs-38VZhBx0I8g-1
Received: by mail-wm1-f69.google.com with SMTP id h9-20020a1ccc09000000b003db1c488826so10111035wmb.3
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 06:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1o51OJziP6bU+eCmiPMiOHJQX1d0z5FefyRCAiwMaA=;
        b=aeUo4UcHE3hNfnBYaZYztYDPS9Gi5N/1NxJSoivsMFez4lL3YIpexhON08upW1x6cS
         y6GMY/OrJTAPkS98jj+zArKA2h8J/wUJ8YjXoL+a5BoIyhaJ/LXrEuF3tdmJG30wLyF9
         OYR5XFQ4wgsu9+Z1dXsu+zwfAYaC4KrXIX4q/HVlH9SaKTGSqiTgliggCaPbNgnoLs70
         SjOv4YWNx6XU+QJD25JO21V1TIFsd8Jod+Z0uAbX4jBA0qSdjeUcaOiaR4pLmSh/3HC+
         cn1shU1u7LtTQg/SGAvbBloTx5v7sZPZ5oDJB0fkHWCRaM0Jz2R0/M0ngEcykHX2EKgq
         e6xQ==
X-Gm-Message-State: AFqh2koFlcvx4zFZDndetEwoZOx5ofIbpfHtK4DlnwYh2a+kd4WEhfZS
        CmhTLvqlN9i1soO5Je+nlmZAJ/Wy8t/SPaRGd7fa2phJjIOvc8XIHk+hKO/IMs1v8/Q3Bae4CP/
        6+BkovpZCZmBfB9em5143Fzo=
X-Received: by 2002:a05:600c:4f10:b0:3d3:48f4:7a69 with SMTP id l16-20020a05600c4f1000b003d348f47a69mr29345042wmq.17.1674572036379;
        Tue, 24 Jan 2023 06:53:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsWKnb4h2V9IrDZPNQLJb9xuVNOAv4tgAP04/SXdS4jirwC5GnrgtxAI7Zz/EbUkNYX+dYayA==
X-Received: by 2002:a05:600c:4f10:b0:3d3:48f4:7a69 with SMTP id l16-20020a05600c4f1000b003d348f47a69mr29345019wmq.17.1674572036027;
        Tue, 24 Jan 2023 06:53:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id k37-20020a05600c082500b003daf681d05dsm2160914wmp.26.2023.01.24.06.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:53:55 -0800 (PST)
Message-ID: <4909601d-8b3b-6ec2-b8b5-2764772d6e8d@redhat.com>
Date:   Tue, 24 Jan 2023 15:53:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 03/10] mm: Provide a helper to drop a pin/ref on a page
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
References: <fc18c4c9-09f2-0ca1-8525-5ce671db36c5@redhat.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-4-dhowells@redhat.com>
 <874546.1674571293@warthog.procyon.org.uk> <Y8/wwy6OJEqjzRfZ@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y8/wwy6OJEqjzRfZ@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24.01.23 15:52, Christoph Hellwig wrote:
> On Tue, Jan 24, 2023 at 02:41:33PM +0000, David Howells wrote:
>> Yes.  Christoph insisted that the bio conversion patch be split up.  That
>> means there's an interval where you can get FOLL_GET from that.
> 
> The only place where we have both is in the block layer.  It never gets
> set by bio_set_cleanup_mode.
> 
> Instead we can just keep using put_page dirctly for the BIO_PAGE_REFFED
> case in the callers of bio_release_page and in bio_release_pages itself,
> and then do away with bio_to_gup_flags and bio_release_page entirely.
> 

Thank you, just what I had in mind ...

-- 
Thanks,

David / dhildenb

