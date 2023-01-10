Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C86C54EBC
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 21:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjAJVl4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 16:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjAJVly (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 16:41:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47793E0E9
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 13:41:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n12so13818476pjp.1
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 13:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D6WnFAop7d5E0yhy9sgHCW9UOo46MAfDHRFM7/8uo+E=;
        b=KJo+O1YHeWC2lzofGztS9Z6uTDMmVlWLB0oOwFB4cWH+JefTudLQrBvQ9KR/wES1DH
         s55YeZOuEP51yOAAqSkmWZNTq1yKCPsvdtJbtEoqrzV32YyGUkTOQfx8EHFErLRp0TIF
         dbA0iy0r1v6/0akvMtV1mZ9eZ1Xm+KDuKznSApxUXkTJepJ/gIxqYdmukpDLEO/yhv6O
         4jSkBBYbPKepc1xYtHutIvS2acl7WeWD5vnG8IrzesVNneu25TSYWCJVCXpv/mTi1Kf5
         5MejEMdYxX8VvvuKXVwll3PIyn7LXsrSSFRHPyho/vfnYzF+Vgscw9ESWteLVqat2eMM
         ZnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6WnFAop7d5E0yhy9sgHCW9UOo46MAfDHRFM7/8uo+E=;
        b=QIQxueJFbHFmbY/Z8iN6eljJXziEQxOLUcFBGKvT2w+OkDI/04PCSlVIDb2JZXavaq
         uNFcyd7bpYtmFvPv5b6b+GUWNi0fkfKw86UE3pYEW9HhJAD5JJNaD0abt0xv/kly7CEX
         G2fdTcZd+ZMG+m6InQFmDQW9Mkej4uqhNhFKD7Wn1AF1qTw4ObKlKNzHoma95wUhTjIp
         LkTVkQR05Rjnskmt30qZAAGPCpI/B5jfkVkJAfmut/NqTs1+2hcvAgqAFa8C16hLltDj
         6ElySGnhg3LRQmvSBx2Hsh6npux0/H6asUep+VINFwrqsI2/7C1kHbgreMmXaqbS8VfB
         PeIA==
X-Gm-Message-State: AFqh2kppLPRnGN1ZEKwUuJN7O69g47TYrcSQPjVeF/xpD3bpCZadMNzs
        TaR3RYa8+JDEj1+E+Kg6jPviHQ==
X-Google-Smtp-Source: AMrXdXs7FzdBhI0TXB5I4AqPO5fCt1v60GEvPvH/08IGgK0xUVt2vA/ipEy6fEEt1A6vaejEUraLhg==
X-Received: by 2002:a05:6a20:54a1:b0:a5:170:9acf with SMTP id i33-20020a056a2054a100b000a501709acfmr25000775pzk.3.1673386908975;
        Tue, 10 Jan 2023 13:41:48 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d16-20020a63ed10000000b00476799699e4sm7310757pgi.30.2023.01.10.13.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 13:41:48 -0800 (PST)
Message-ID: <2c01e100-852d-d082-02b5-0b481fc72477@kernel.dk>
Date:   Tue, 10 Jan 2023 14:41:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 7/7] iov_iter, block: Make bio structs pin pages rather
 than ref'ing if appropriate
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <bbd9cde3-7cbb-f3e4-a2a4-7b1b5ae392e0@kernel.dk>
 <d0bb04e7-7e58-d494-0e39-6e98f3368a7b@kernel.dk>
 <20230109173513.htfqbkrtqm52pnye@quack3>
 <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
 <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk>
 <2008444.1673300255@warthog.procyon.org.uk>
 <2084839.1673303046@warthog.procyon.org.uk>
 <2155741.1673361430@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2155741.1673361430@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 7:37 AM, David Howells wrote:
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> I think it makes more sense to have NO_REF check, to be honest, as that
>> means the general path doesn't have to set that flag. But I don't feel
>> too strongly about that part.
> 
> It's just that the logic seems weird with BIO_NO_PAGE_REF and BIO_PAGE_PINNED
> being kind of opposite polarity.
> 
> Anyway, see attached.

Yeah, I guess I'll have to agree with you. So let's go with that approach
instead, but then please:

1) Change that flag as a prep patch so you don't mix up the two
2) Incorporate the feedback from the previous patch

Any chance we can get that cleanup_mode thing cleaned up as well?

-- 
Jens Axboe


