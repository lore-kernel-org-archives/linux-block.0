Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B0EC77B7A
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 23:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjE3XEM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 19:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjE3XEL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 19:04:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D276E5
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 16:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685487804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKs4wbQndTavzhsczBJzKi8qv7Q4nRnq+Yk6Q+JcObA=;
        b=G24p0KP2o0AdafRrhz+hQEVDVBAutxyBTUPtC9JsXWuJzrx/2w8HGaVu+eZgUBllt2KZIz
        6BY4Klh6i5cyYz+wAQMPRgCiJxLy04IvJNnlH1orsBi6AT0uLfCf5H5sSxgNATas+n6tTi
        Ddpn/9DF6ZhL+TXxCeOSLhA+Q5da01w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563--nTY4dTLOVunLH2sbGoIEg-1; Tue, 30 May 2023 19:03:23 -0400
X-MC-Unique: -nTY4dTLOVunLH2sbGoIEg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75b0e24e379so356081085a.1
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 16:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487801; x=1688079801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKs4wbQndTavzhsczBJzKi8qv7Q4nRnq+Yk6Q+JcObA=;
        b=VsRaBLGc3GbSB6NoCAf2yLbN44DeYps7JKpLhRkZED3eBheC4Er2LelWi4AZ0Mxe3A
         a9qeJQY+a5TvZqIg2jF4Vl9I/WwUN/9VRI0zKn/PajQfoPJ1O6ulyb+Txf+RM+YMXIlC
         TtA4zLnxy1c+kh8iANjXHNE6rDjK2ErDnkdGSunK++y6eDHfOBLjbY8dE3XZcglmuBhu
         Q7tij8i3N+3bciK2zHY5mFZwnIxfSHQyh0l6JcRmBEpQ3xLiBvEbEQWO9IOhhxfP1rKy
         6NfXM48pf59FdompS7KSq6FVtzc2fqfe83DsRZzeQa4tNrVur87QZTZuoyCAh0n5Vwyl
         P+KQ==
X-Gm-Message-State: AC+VfDzZwEIfwIockQZw/aykvWXGwR/x6/WegahSDiYz4GKIavzDJq4e
        HyKXyzXAspThhEKLpJprNkm2mpxuPFI2RwMdbome19vHjD9Uv/IdLAE4SYLX9H/7JfL4K/YMaYR
        hnTqscPwoGTL48iT540PKoOqQfMerd0Uuzw==
X-Received: by 2002:a05:620a:884:b0:75b:23a1:8e6a with SMTP id b4-20020a05620a088400b0075b23a18e6amr3588729qka.59.1685487801131;
        Tue, 30 May 2023 16:03:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7U7dNXZBhOi8VI9A5TO3l+qcE1AblN+OzvViMpHOENYgH+39jJlsruHW8G0OV5WKI/KyEQvA==
X-Received: by 2002:a05:620a:884:b0:75b:23a1:8e6a with SMTP id b4-20020a05620a088400b0075b23a18e6amr3588712qka.59.1685487800847;
        Tue, 30 May 2023 16:03:20 -0700 (PDT)
Received: from [192.168.1.133] ([209.6.119.155])
        by smtp.gmail.com with ESMTPSA id o14-20020a05620a130e00b0075cb085cbc8sm4191403qkj.97.2023.05.30.16.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 16:03:11 -0700 (PDT)
Message-ID: <be55a799-5367-cd05-2b58-c002f9f2935d@redhat.com>
Date:   Tue, 30 May 2023 19:03:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [vdo-devel] [dm-devel] [PATCH v2 00/39] Add the dm-vdo
 deduplication and compression device mapper target.
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, vdo-devel@redhat.com,
        dm-devel@redhat.com
References: <20230523214539.226387-1-corwin@redhat.com>
 <20230523224047.GE888341@google.com>
From:   Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20230523224047.GE888341@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 18:40, Eric Biggers wrote:
> On Tue, May 23, 2023 at 05:45:00PM -0400, J. corwin Coburn wrote:
>> The dm-vdo target provides inline deduplication, compression, zero-block
>> elimination, and thin provisioning. A dm-vdo target can be backed by up to
>> 256TB of storage, and can present a logical size of up to 4PB. This target
>> was originally developed at Permabit Technology Corp. starting in 2009. It
>> was first released in 2013 and has been used in production environments
>> ever since. It was made open-source in 2017 after Permabit was acquired by
>> Red Hat.
> 
> As with any kernel patchset, please mention the git commit that it applies to.
> This can be done using the --base option to 'git format-patch'.

This will be in the next version of the patch set.

> - Eric
> 
> _______________________________________________
> vdo-devel mailing list
> vdo-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/vdo-devel
> 

