Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0C6C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 15:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjC2PV2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 11:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC2PV1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 11:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837119E
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680103241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8QfBEWZaETqXKkNIZWe2Rgfoz5A0Mz2yy7ZiCrKeUrk=;
        b=cYk8FeP5rFo2BuKC0+lN4n356AJyMydQTwE/1xE8VcJR00QcS1/FErsz2o9Oczd/yJMofZ
        3lkzTKtJ8y+ZzXak5mNV6QiFwJHJJSuGC6kXSs+Bis3uPH3E2Bl2vDVU4IojARvCOD4iKY
        fKjdxNbdusVsNuDv3NPMDtcyH4Dru3M=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-xtRa4GCUNUyO3ghhxR7IJA-1; Wed, 29 Mar 2023 11:20:32 -0400
X-MC-Unique: xtRa4GCUNUyO3ghhxR7IJA-1
Received: by mail-ed1-f71.google.com with SMTP id i42-20020a0564020f2a00b004fd23c238beso22847268eda.0
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 08:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680103231;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QfBEWZaETqXKkNIZWe2Rgfoz5A0Mz2yy7ZiCrKeUrk=;
        b=UnnqqXMc1Fp9oIADb4tVK8pexvZxi7iYvUoHZOf/VqmK04YAxc7EwMgzWwTL9GZKXX
         hrWhKa7cELeFuIf4oQK8EZm1WWIkptm3EwYpNmUT6SkqXFAM2ELHcG4Chdo6No/KNirR
         nyfIWLKv4EJTgt8LqG7l3Rvc2ceWxf5lvhgIR3A4RLL5NBua11/rd2szBxmhFoQhAcVQ
         3gJdPrBJH/dOrYndEBlWpEMFXlek3UXBRU+FrF2GgZgJ26oh76U1nklfJ3RUSwB/ZrcF
         /DmZhFWnUl2DcH//qCjFTLUD9J9A0vt/bp794tMkzihWRE9EYmR7PGZX8z7Q4spg7IHv
         XJWw==
X-Gm-Message-State: AAQBX9fvfgiJZopTofgvGdXiHs4xC0RSIgvROWbbCtJInl3OYxNt7Sj7
        yS/Hqx9ky0PeYeesVk6oXt9vwMp9OHtFdLz6O10VUZa3OtvSKICnmsTiC7VlKEEvBuc7fi68Xr/
        1BstE88W9IjGhj7y0WwbLYQ==
X-Received: by 2002:a05:6402:70a:b0:4fb:9b54:ccb8 with SMTP id w10-20020a056402070a00b004fb9b54ccb8mr19963098edx.21.1680103231325;
        Wed, 29 Mar 2023 08:20:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZIDq5cbD4oxWGT+bxHeC8eCeDrmTmHS2bporzQleFYwRv0FroOOgbBgNfZL6B5UYLBTBOzQQ==
X-Received: by 2002:a05:6402:70a:b0:4fb:9b54:ccb8 with SMTP id w10-20020a056402070a00b004fb9b54ccb8mr19963077edx.21.1680103231077;
        Wed, 29 Mar 2023 08:20:31 -0700 (PDT)
Received: from [10.43.17.42] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y94-20020a50bb67000000b004be11e97ca2sm17165261ede.90.2023.03.29.08.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:20:30 -0700 (PDT)
Message-ID: <a2ce079f-f3de-9bf1-5cd0-ec3045a25168@redhat.com>
Date:   Wed, 29 Mar 2023 17:20:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, jonathan.derrick@linux.dev
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230322151604.401680-2-okozina@redhat.com>
 <20230329-amendment-trodden-75a619120b5e@brauner>
From:   Ondrej Kozina <okozina@redhat.com>
Subject: Re: [PATCH 1/5] sed-opal: do not add user authority twice in boolean
 ace.
In-Reply-To: <20230329-amendment-trodden-75a619120b5e@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29. 03. 23 16:15, Christian Brauner wrote:
> On Wed, Mar 22, 2023 at 04:16:00PM +0100, Ondrej Kozina wrote:
> 
> This index only appears one time in the code. IOW, you're completely
> removing OPAL_HALF_UID_BOOLEAN_ACE leavig only
> OPAL_HALF_UID_AUTHORITY_OBJ_REF. Is that intended and if so why is
> OPAL_HALF_UID_BOOLEAN_ACE not needed anymore?
> 

It seemed redundant when only single authority is added in the set 
method aka { authority1, authority1, OR }:

TCG Storage Architecture Core Specification, 5.1.3.3 ACE_expression

"This is an alternative type where the options are either a uidref to an 
Authority object or one of the boolean_ACE (AND = 0 and OR = 1) options. 
This type is used within the AC_element list to form a postfix Boolean 
expression of Authorities."

I add OPAL_HALF_UID_BOOLEAN_ACE when there's more than single authority 
added in any ACE_expression in later code.

