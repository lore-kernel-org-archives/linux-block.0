Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661CAC77B7C
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 01:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjEVByb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 May 2023 21:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjEVBy3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 May 2023 21:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02457DB
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 18:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684720422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjpVYliWYmLsp+7DmHIQ6WIiz69+8hAntxXwMv/K+0o=;
        b=bZu6B6XqpQa0rbKaAbhHd69+KgJUVHnv8V0cqKO4TGgE9+2a8yDj1M3MYGPbJvjA1HbpCq
        Dymi0sIc1GDowULSS09GEoris7uPGlrHgOqHsrjEPcj2weD790rxiv9UzEbA/T/6uY61H/
        NWTsWknk5+a94yiO2Bu55GBCdkqPjPc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-UdT02riUO5GfrVVfGS3fJQ-1; Sun, 21 May 2023 21:53:40 -0400
X-MC-Unique: UdT02riUO5GfrVVfGS3fJQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-64d1cbfb240so2307743b3a.0
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 18:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684720419; x=1687312419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjpVYliWYmLsp+7DmHIQ6WIiz69+8hAntxXwMv/K+0o=;
        b=dhDpMaIzmjMyFwgSZND0wymrArBJkTmS5ONj3xPok29n+pk4VRvTsvbcvXEJPLsbC0
         XNSihflAtkENlFKk94uPy/0zNjRaEr13Ofv0sBwJnJ9l5BO7wY/Se/5LToR+KAIsxb8r
         TZMiHudNht7v0ANBGqeN8r2Wq8HkQro05BdvoKXnVlXf3PoRSUUYCfWHO6GUsSlNdlQS
         9sRVioV3CYs4ByW/Blp0zOpQvze7cHp4pixq14o1FwlXMPvSJ3E2UgHKcJwm+yODJNDW
         NtV2J3bAkBa1FJ9YOWikPOGpZ7BkvXKtqAlfc98WpIHbKmbZiC1jmQ0teGO4vzAxjr71
         9iSQ==
X-Gm-Message-State: AC+VfDyt4GZRBDagoibeyxWF6sLoTDix+cgkFbuXYgvNU8FPG865mwF9
        yBnfqq5pzojST2RBD6Cg0ma1XrjbMxY2jZanvhBbF7LK7Hxe4GZ4PjTsr+UUxHHzJ4sA5NG6WMW
        +n122ka2HJAmWqbT8JMgzeYo=
X-Received: by 2002:a05:6a00:2314:b0:63b:6149:7ad6 with SMTP id h20-20020a056a00231400b0063b61497ad6mr11651209pfh.34.1684720419699;
        Sun, 21 May 2023 18:53:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Mn7xT7CCI+yBGqvco+AvK/IKOxX++Ib2iwxBd4veVXnB4vaLlF/dnAev/HMla5PSUAUk2RQ==
X-Received: by 2002:a05:6a00:2314:b0:63b:6149:7ad6 with SMTP id h20-20020a056a00231400b0063b61497ad6mr11651198pfh.34.1684720419429;
        Sun, 21 May 2023 18:53:39 -0700 (PDT)
Received: from [10.72.12.68] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s9-20020aa78289000000b0063f2e729127sm3121905pfm.144.2023.05.21.18.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 18:53:38 -0700 (PDT)
Message-ID: <ef4cc431-4cc4-eb39-735d-0b3b3759abed@redhat.com>
Date:   Mon, 22 May 2023 09:53:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v20 13/32] ceph: Provide a splice-read stub
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
References: <c1fd63b9-42ea-fa83-ecb1-9af715e37ffa@redhat.com>
 <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-14-dhowells@redhat.com>
 <1743656.1684488288@warthog.procyon.org.uk>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <1743656.1684488288@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 5/19/23 17:24, David Howells wrote:
> Xiubo Li <xiubli@redhat.com> wrote:
>
>>> +	ret = ceph_get_caps(in, CEPH_CAP_FILE_RD, want, -1, &got);
>>> +	if (ret < 0) {
>>> +		ceph_end_io_read(inode);
>>> +		return ret;
>>> +	}
>>> +
>>> +	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) == 0) {
>>> +		dout("splice_read/sync %p %llx.%llx %llu~%zu got cap refs on %s\n",
>>> +		     inode, ceph_vinop(inode), *ppos, len,
>>> +		     ceph_cap_string(got));
>>> +
>>> +		ceph_end_io_read(inode);
>>> +		return direct_splice_read(in, ppos, pipe, len, flags);
>> Shouldn't we release cap ref before returning here ?
> Ummm...  Even if we got no caps?

No, at least we have got the 'need' caps: CEPH_CAP_FILE_RD once here.

I saw you have updated this and will check it.

Thanks

- Xiubo

>
> David
>

