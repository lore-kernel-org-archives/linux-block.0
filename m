Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B76C7EE26
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 22:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbjEWWOA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 18:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjEWWN7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 18:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2DF83
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 15:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684879992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPM01XPJotlxXQm9x8UW+H+xbOwXmHBJ79622BZ9Cv8=;
        b=IKAJuOVdu50qICiGQZNq8IecijbiH95A9yIpfROIZcwZFDf6k9G9ZsMTXpsKrUp6je/Wc9
        k5Fi8PkK4MWnA6qve4c/IgOX8JQGYQUUJQLG6hysPceC9ySVwWC9iXoSgBPNxbcSk+iGwq
        H8fGVXQmN+QqjdusUWm5O5yFT6jpRzc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-yQ7Mv9IOPwe0A8tG7XLdbw-1; Tue, 23 May 2023 18:13:10 -0400
X-MC-Unique: yQ7Mv9IOPwe0A8tG7XLdbw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f39fc06acaso1587841cf.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 15:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684879990; x=1687471990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPM01XPJotlxXQm9x8UW+H+xbOwXmHBJ79622BZ9Cv8=;
        b=Nrmi3TvENeq5WMN8mSrgD807uH6Ml8YEMSsrZccr5OQQHphsHhjUHHstxHTLsGqU2A
         k5bTSMIYSiujRxO8pQcsF5s/QkVfbvPH+v/q2eQ5REc9VHEXymFkuUz6/fPJl+tVGMpr
         wH6gEQ394/hljRcK3T9eSwpqiyWE8cZoDQ+9cKedWO03B1IMnXwbDT4P4KFj/XCvCnAM
         S4zt8iZKrMS7I7Aon/xYwEow14zltB8kfa+1YwpDEY6hDihxbIVU2GGhxqHo/84/EFT6
         DXMI+CUxWVxb1A+4LrS9xWsWHO9dB3KvsAhP1DotsMbNkVUiyiwjG9gGImnyE+WuCATh
         KwUA==
X-Gm-Message-State: AC+VfDxmW4wwhSVekLzmbN74/Wdt9UcWLT0ZLuzOonUwC4J8ySftCwER
        b9uN5DgvKPZQkl/AfKhSt+erC7MH0lY1FruZ41s8evEYkhg781QGUzg9KwZtV9YkekBtRS7t70j
        /ldTxe8U+C7JpqlFn2sxvOixx4/hKDNS2mg==
X-Received: by 2002:a05:622a:48d:b0:3f5:ef49:722c with SMTP id p13-20020a05622a048d00b003f5ef49722cmr24849850qtx.2.1684879990124;
        Tue, 23 May 2023 15:13:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/3mFuM4Sg5KPzLpANVm5ZJP+Nbjijgyek8H2PKX/k1qAPcrIS64/OcNJwMjLRAN+W/l1YLA==
X-Received: by 2002:a05:622a:48d:b0:3f5:ef49:722c with SMTP id p13-20020a05622a048d00b003f5ef49722cmr24849824qtx.2.1684879989743;
        Tue, 23 May 2023 15:13:09 -0700 (PDT)
Received: from [172.16.2.39] (173-166-2-198-newengland.hfc.comcastbusiness.net. [173.166.2.198])
        by smtp.gmail.com with ESMTPSA id n12-20020ac85a0c000000b003e302c1f498sm1289329qta.37.2023.05.23.15.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 15:13:09 -0700 (PDT)
Message-ID: <0d3d1835-d945-9fa2-f3b7-6a60aae3d1df@redhat.com>
Date:   Tue, 23 May 2023 18:13:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [dm-devel] [PATCH v2 02/39] Add the MurmurHash3 fast hashing
 algorithm.
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, vdo-devel@redhat.com,
        dm-devel@redhat.com
References: <20230523214539.226387-1-corwin@redhat.com>
 <20230523214539.226387-3-corwin@redhat.com>
 <20230523220618.GA888341@google.com>
From:   corwin <corwin@redhat.com>
In-Reply-To: <20230523220618.GA888341@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 6:06 PM, Eric Biggers wrote:
> On Tue, May 23, 2023 at 05:45:02PM -0400, J. corwin Coburn wrote:
>> MurmurHash3 is a fast, non-cryptographic, 128-bit hash. It was originally
>> written by Austin Appleby and placed in the public domain. This version has
>> been modified to produce the same result on both big endian and little
>> endian processors, making it suitable for use in portable persistent data.
>>
>> Signed-off-by: J. corwin Coburn <corwin@redhat.com>
>> ---
>>   drivers/md/dm-vdo/murmurhash3.c | 175 ++++++++++++++++++++++++++++++++
>>   drivers/md/dm-vdo/murmurhash3.h |  15 +++
>>   2 files changed, 190 insertions(+)
>>   create mode 100644 drivers/md/dm-vdo/murmurhash3.c
>>   create mode 100644 drivers/md/dm-vdo/murmurhash3.h
> 
> Do we really need yet another hash algorithm?
> 
> xxHash is another very fast non-cryptographic hash algorithm that is already
> available in the kernel (lib/xxhash.c).
> 
> - Eric

The main reason why vdo uses Murmur3 and not xxHash is that vdo has been 
in deployment since 2013, and, if I am reading correctly, xxHash did not 
have a 128 bit variant until 2019.

It would certainly be possible to switch vdo to xxHash, but it would be 
problematic for existing users.

corwin


